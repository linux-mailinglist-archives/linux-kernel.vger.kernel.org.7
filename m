Return-Path: <linux-kernel+bounces-832063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA5DB9E420
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFEF1BC5A92
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7A92D9EF5;
	Thu, 25 Sep 2025 09:15:33 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B135523D2A3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791733; cv=none; b=NGEWjp7bmRBtvDeb91318MxqfGaLMRBPQdhvGGkKDMX2GMxn6CunEYtNgW3EaXMR5vqiXpxedE/1YFaTs57xbIXTuHLN9RBKaTl8VR3vRsc0w9B/4UX9D3pEfgyFMFmyXgjG5dES7ZYs67Gd6K18CjTSLrqPnA/fEU492d04HHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791733; c=relaxed/simple;
	bh=yLpv0PFi8W/6YRqGsAfPEAUF3jl1XRJOR9IniZyc8F4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T6/EJo3GxWKJIN61sqG/hT1mJTrBS6A9kEKbkY4JrSaq+LRhWf22pDN7lLrZvUm8Kf2gxUpPBB7b5RqGEh+wonCr5WMZKRiEGu5yEzqH5gOjekZXVfKtFAyEKr9A92NFGQHZZA/3dQao/8iwp5jtLvjYtYjyn/cg21YkpmqeCwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cXShp30phztTCF;
	Thu, 25 Sep 2025 17:14:34 +0800 (CST)
Received: from kwepemh100012.china.huawei.com (unknown [7.202.181.97])
	by mail.maildlp.com (Postfix) with ESMTPS id 040A4180B69;
	Thu, 25 Sep 2025 17:15:27 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemh100012.china.huawei.com
 (7.202.181.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Sep
 2025 17:15:26 +0800
From: Wang ShaoBo <bobo.shaobowang@huawei.com>
To: <deller@gmx.de>
CC: <bobo.shaobowang@huawei.com>, <leijitang@huawei.com>,
	<tzimmermann@suse.de>, <qianqiang.liu@163.com>, <daniel.vetter@ffwll.ch>,
	<linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>
Subject: [RFC PATCH] tty: vt: Fix vc_origin buffer copy overflow in fbcon_prepare_logo()
Date: Thu, 25 Sep 2025 17:15:25 +0800
Message-ID: <20250925091525.767477-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemh100012.china.huawei.com (7.202.181.97)

I got some KASAN report as below:

BUG: KASAN: slab-use-after-free in fbcon_prepare_logo+0x61e/0xc90
Read of size 14 at addr ffff88812c9a4c38 by task syz.0.3549/19016

CPU: 0 PID: 19016 Comm: syz.0.3549 Not tainted 6.6.0+ #80
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x72/0xa0
 print_address_description.constprop.0+0x6b/0x3d0
 ? fbcon_prepare_logo+0x61e/0xc90
 print_report+0xba/0x280
 ? fbcon_prepare_logo+0x61e/0xc90
 ? kasan_addr_to_slab+0xd/0xa0
 ? fbcon_prepare_logo+0x61e/0xc90
 kasan_report+0xaf/0xe0
 ? fbcon_prepare_logo+0x61e/0xc90
 kasan_check_range+0x100/0x1c0
 __asan_memcpy+0x23/0x60
 fbcon_prepare_logo+0x61e/0xc90
 fbcon_init+0xeb9/0x1db0
 ? __pfx_drm_fb_helper_set_par+0x10/0x10
 visual_init+0x310/0x5c0
 do_bind_con_driver.isra.0+0x627/0xbd0
 store_bind+0x60b/0x710
 ? __pfx_store_bind+0x10/0x10
 dev_attr_store+0x5a/0x90
 ? __pfx_dev_attr_store+0x10/0x10
 sysfs_kf_write+0x145/0x1b0
 kernfs_fop_write_iter+0x367/0x580
 ? __pfx_sysfs_kf_write+0x10/0x10
 new_sync_write+0x1b1/0x2d0
 ? __pfx_new_sync_write+0x10/0x10
 ? rb_commit+0x121/0x910
 ? avc_policy_seqno+0xe/0x20
 ? selinux_file_permission+0x129/0x5d0
 ? security_file_permission+0xa8/0x700
 vfs_write+0x71a/0x960
 ksys_write+0x12e/0x260

fbcon_init()
	-> vc_resize()
	//success resize vc_origin buffer size=224=7(cols)*2*16(rows)
	-> bcon_prepare_logo(vc, info, old_cols, old_rows,
                            new_cols, new_rows)
	//old_cols=256，old_rows=4，new_cols=7，new_rows=16

There happened to be a vc_origin buffer copy overflow error in
fbcon_prepare_logo(), scrolling screen down when using old cols
after vc resize would trigger out of lower bound of vc_origin buffer.

Fixes: 6104c37094e7 ("fbcon: Make fbcon a built-time depency for fbdev")
Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/video/fbdev/core/fbcon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index ac3c99ed92d1..6fa81d0297a0 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -610,6 +610,8 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 		/* We can scroll screen down */
 		r = q - step - cols;
 		for (cnt = rows - logo_lines; cnt > 0; cnt--) {
+			if (r < (unsigned short *) vc->vc_origin)
+				break;
 			scr_memcpyw(r + step, r, vc->vc_size_row);
 			r -= cols;
 		}
-- 
2.25.1


