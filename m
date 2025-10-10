Return-Path: <linux-kernel+bounces-847948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8733BCC240
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 512FB4F29F6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A6B255E26;
	Fri, 10 Oct 2025 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HsHlnNcY"
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C2B34BA44;
	Fri, 10 Oct 2025 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085132; cv=none; b=i/wTBfu83cNSZIEtQJGFeERrPEVvwPZzVHAq74+/E1cosoHQgpFmka5Q5QvNp5Vksay4ff9/NM//0fEVcHNvpzxYibuXqAdgq2yNgCJItejqWsHDfkFKNF5Yh5uDc4WAup0Wh4K2x11P7F5xuF5uQ+tUuvZlJKuJwvm8+YPFkEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085132; c=relaxed/simple;
	bh=Kb5cgGF5ckGuhYQnHWbe83rdwTYdTZ89SJus7EtsSqs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mBJodxVV3Tqs5hHZ89JYTGL0CdJXCe2ZGFQtWCGSFB4MtpiVFEMTOLmmQ7VXWHvliWk45PhUfJazkPW62xBFkzuW6UsSf8mfp1GwsdpZIdEMER33OJJxuBX/U7540cEeTnapnxQz79WB2MFeqwMtQ8LUdq0CBal5F19DR+ni0qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HsHlnNcY; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pdS1EW9jcK370UHJoQR6CtbmqQ6PWXVjAxzle3L9Fds=;
	b=HsHlnNcYVhU624rtF4gVCBRGSm6QevKAjeAVyk+nDQh/iN3GmWQPRazFKi5w33JjEXhA28bKb
	HFsfw2YT28eVCDfozrAsMGB02Xfe5pWsquqwCgwhksFcHP/bkRgGYY1bWAGfYgKdcLVQIYjBbXy
	NStE2vFEpFFTLzzw+TXq3l0=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cjg225DzWz1T4Fp;
	Fri, 10 Oct 2025 16:31:22 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 473731402C8;
	Fri, 10 Oct 2025 16:32:00 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 10 Oct
 2025 16:31:59 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <tzimmermann@suse.de>
CC: <simona@ffwll.ch>, <deller@gmx.de>, <linux-kernel@vger.kernel.org>,
	<linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>,
	<sunnanyong@huawei.com>
Subject: [PATCH v2] fbcon: Set fb_display[i]->mode to NULL when the mode is released
Date: Fri, 10 Oct 2025 16:16:59 +0800
Message-ID: <20251010081659.3609082-1-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200018.china.huawei.com (7.185.36.31)

Recently, we discovered the following issue through syzkaller:

BUG: KASAN: slab-use-after-free in fb_mode_is_equal+0x285/0x2f0
Read of size 4 at addr ff11000001b3c69c by task syz.xxx
...
Call Trace:
 <TASK>
 dump_stack_lvl+0xab/0xe0
 print_address_description.constprop.0+0x2c/0x390
 print_report+0xb9/0x280
 kasan_report+0xb8/0xf0
 fb_mode_is_equal+0x285/0x2f0
 fbcon_mode_deleted+0x129/0x180
 fb_set_var+0xe7f/0x11d0
 do_fb_ioctl+0x6a0/0x750
 fb_ioctl+0xe0/0x140
 __x64_sys_ioctl+0x193/0x210
 do_syscall_64+0x5f/0x9c0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Based on experimentation and analysis, during framebuffer unregistration,
only the memory of fb_info->modelist is freed, without setting the
corresponding fb_display[i]->mode to NULL for the freed modes. This leads
to UAF issues during subsequent accesses. Here's an example of reproduction
steps:
1. With /dev/fb0 already registered in the system, load a kernel module
   to register a new device /dev/fb1;
2. Set fb1's mode to the global fb_display[] array (via FBIOPUT_CON2FBMAP);
3. Switch console from fb to VGA (to allow normal rmmod of the ko);
4. Unload the kernel module, at this point fb1's modelist is freed, leaving
   a wild pointer in fb_display[];
5. Trigger the bug via system calls through fb0 attempting to delete a mode
   from fb0.

Add a check in do_unregister_framebuffer(): if the mode to be freed exists
in fb_display[], set the corresponding mode pointer to NULL.

Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---

Changes from v1
(https://lore.kernel.org/all/20250923110608.3385083-1-yanquanmin1@huawei.com/)
- Focus on fixing the issue specifically in the framebuffer unregistration
  path, as other paths do not encounter this problem.
- Adjusted according to Thomas's suggestions.

 drivers/video/fbdev/core/fbcon.c | 19 +++++++++++++++++++
 drivers/video/fbdev/core/fbmem.c |  1 +
 include/linux/fbcon.h            |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 96cc9b389246..9bd3c3814b5c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2810,6 +2810,25 @@ int fbcon_mode_deleted(struct fb_info *info,
 	return found;
 }
 
+static void fbcon_delete_mode(struct fb_videomode *m)
+{
+	struct fbcon_display *p;
+
+	for (int i = first_fb_vc; i <= last_fb_vc; i++) {
+		p = &fb_display[i];
+		if (p->mode == m)
+			p->mode = NULL;
+	}
+}
+
+void fbcon_delete_modelist(struct list_head *head)
+{
+	struct fb_modelist *modelist;
+
+	list_for_each_entry(modelist, head, list)
+		fbcon_delete_mode(&modelist->mode);
+}
+
 #ifdef CONFIG_VT_HW_CONSOLE_BINDING
 static void fbcon_unbind(void)
 {
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 53f1719b1ae1..eff757ebbed1 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -544,6 +544,7 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
 		fb_info->pixmap.addr = NULL;
 	}
 
+	fbcon_delete_modelist(&fb_info->modelist);
 	fb_destroy_modelist(&fb_info->modelist);
 	registered_fb[fb_info->node] = NULL;
 	num_registered_fb--;
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 81f0e698acbf..f206370060e1 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -18,6 +18,7 @@ void fbcon_suspended(struct fb_info *info);
 void fbcon_resumed(struct fb_info *info);
 int fbcon_mode_deleted(struct fb_info *info,
 		       struct fb_videomode *mode);
+void fbcon_delete_modelist(struct list_head *head);
 void fbcon_new_modelist(struct fb_info *info);
 void fbcon_get_requirement(struct fb_info *info,
 			   struct fb_blit_caps *caps);
@@ -38,6 +39,7 @@ static inline void fbcon_suspended(struct fb_info *info) {}
 static inline void fbcon_resumed(struct fb_info *info) {}
 static inline int fbcon_mode_deleted(struct fb_info *info,
 				     struct fb_videomode *mode) { return 0; }
+static inline void fbcon_delete_modelist(struct list_head *head) {}
 static inline void fbcon_new_modelist(struct fb_info *info) {}
 static inline void fbcon_get_requirement(struct fb_info *info,
 					 struct fb_blit_caps *caps) {}
-- 
2.43.0


