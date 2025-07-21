Return-Path: <linux-kernel+bounces-738669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E78B0BBBA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E6B177CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC341DE89A;
	Mon, 21 Jul 2025 04:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="v98dh1mn"
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC78A469D
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753071776; cv=none; b=kovTuMPHGYmNd/zt2VdSpNfz0tj9B443CSyODkbrg0Xjs168+trP0jM/QlN7cD/jeKZ5XjrscsW5JRRC+owYsovPEo3KKm2RvbigD4/Ijc00FDjzudaNzn5ZWP9hj/+Afm5Dd7K/UpOnip81ShPWQEuunlA/XxVj2m8WP0l44qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753071776; c=relaxed/simple;
	bh=r37ITysm2FDy/uFAKWHZNDHxe+gT+FCR2v5TwtZztVk=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Bde7kqaJCeDrf5rc6QdgG/RcbZ94/uFdh8Ayns0Ph7gy8DyyMIsh/zApGVMR8h9dCACuySTAfGHUvPrrkWUL1BzDPIIQRu52rox2QPIsyyX51tDPqMixNuadOJX129uXJ+NdXzFrXvrH7Q4G/b/VFLfk1YaaljSWmJ538r+bDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=v98dh1mn; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753071464; bh=huuCQOiCI/l/o5VOAp01tohbM7fD8xmvpEMzGbxvGwI=;
	h=From:To:Cc:Subject:Date;
	b=v98dh1mnRAiBdV4zVkIV6l+soJQ/xB21G2om6OxRSvVat1X2HGxJ2UZyAiB/UWgEQ
	 L2dLs/YexcQ8JMYKTT0zW4fVSU+JmRGccAFnzRYgt64NSAFNLOdoWyBDMh9B/f62qG
	 kxIo0x2sfc1nhGi9jcEp3ufiPkwieXevo4joWoBM=
Received: from VM-222-126-tencentos.localdomain ([14.116.239.34])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 469040FD; Mon, 21 Jul 2025 12:17:41 +0800
X-QQ-mid: xmsmtpt1753071461tsh4xanrk
Message-ID: <tencent_E9EF29CDB2286A690EB871B78BFE62491908@qq.com>
X-QQ-XMAILINFO: MsOOLhKAF3pPEXAa6VcqPqM6yfUgLB3ZpPoC5IRU4CTBRBcx6fLzuitNnRl1OL
	 i5PghUVGrZYkOOMpRRsv6E2wNsBrGkSFzWB25dD8Ys8bh0Y2ccPa6OQv8lo5SChErfXnKtCJ83+O
	 v+TXt2v9dNh9i3Y+EwJS/XMlxNCniGYbWoggoRdRzWZ60VcKEy5CgddW2LI5YfA0L8EQzO92aqDx
	 lo1QqaM3oIJdKQxP7hW+U8ktlrJOQdO7pers5xgrITKgG8IvvabrFYX4LLwmDvqHsaG3CvbDWTdV
	 tkV5KGifRjazgnZv+3JAECNJyf9c+pSIeied5gwLZWyVYmOIh0ikAwsoekgiJm1Cni91HUtMurwb
	 h3TkK2tGIEFNzO+O1Ddzh3WxxWDFgXa/+gX3ehHtxJv66LYbjWqsRWDSoG7OHenyGjblnzDsPFsW
	 xcm9jncFOMS5rzx+3HPWZt4ufpg3Ki+n5Yk2KN2+N90cAkevp1rDJZUOzdHbVhPkB7n0gjmSidhh
	 nd7+sukXUfiN78MUvcWeMcC5GZaNE/A7AYgxsJUafQtepCiwc88EOnvP8O1f3d7e+SCfqD/V2J1R
	 vu5lmnvwHOwzemHtL5dTme33Y7Iv+Tlef5H7Ubi7vRCvzs7rQTHoRvDk8WXlTvjyFQCW8fRBq9UR
	 Kc9mNvKMSOG1hqSRRPFyzT3XQmQPXiMYUNFIn9anfvevF0U+uTcner60S/mwi8OUzFYs//A++2Sp
	 lgxv8/9U5nFgxNEBhz8I3mHRqDytXup/N+trrU0eK2+ZWM0YrmV2VqFNM2/7Z4ah4x1EU+D5DB0R
	 BzmU1BRtlQ1fIg/GXHEpfSE8k5coFr5IYV35hALOeRzmGz2OjU+XISVEWyELKOF8KR2BEBKx6BOB
	 I6BZD1+KIeQX76Kywk/pn/TJR/nUvMaWR+Hvh9RP6ifDHXT5HUPL5/gxcCXiUJxMyNl6B3M8NYGJ
	 u8dK92bv3U0NQJxDorBLe/RrX3Uu04/sJfGp91PYbzF3cB+divCU4rE+kqzTbzUrMYhtltzojBnJ
	 nxax7QKaMAP84zo9+K+JQI/pjpBbsPdZtDjUsjZ8l49DjwJmZ2LSPm0298v1e0PwpReJjf0KtOQO
	 dIGl6wJbnpgNcIsa4=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: jackysliu <1972843537@qq.com>
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	1972843537@qq.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc : fix resource leak in holly_init_IRQ()
Date: Mon, 21 Jul 2025 12:17:32 +0800
X-OQ-MSGID: <20250721041732.145920-1-1972843537@qq.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siyang Liu <1972843537@qq.com>

When the 'pic-router' device node lookup fails in holly_init_IRQ(),
the function returns without releasing the previously acquired
'tsi_pci' node. This violates the device tree reference counting
rules and causes a resource leak.

This issue was detected by rule based static tools
developed by Tencent.

Signed-off-by: Siyang Liu <1972843537@qq.com>
---
 arch/powerpc/platforms/embedded6xx/holly.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index ce9e58ee9754..fefb7fd2365f 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -178,6 +178,7 @@ static void __init holly_init_IRQ(void)
 	cascade_node = of_find_node_by_type(NULL, "pic-router");
 	if (cascade_node == NULL) {
 		printk(KERN_ERR "%s: No tsi108 pci cascade node found !\n", __func__);
+		of_node_put(tsi_pci);
 		return;
 	}
 
-- 
2.43.5


