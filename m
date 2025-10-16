Return-Path: <linux-kernel+bounces-856063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E390BE2F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A604353C33
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F24C302CA2;
	Thu, 16 Oct 2025 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSYeA3HF"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F072E0934
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612145; cv=none; b=OMA9r7n0fyp6QJHabC42byfwrFlZG5V2GBesgkzH7UNCnz8IMRlowtsbo7Z6tQ4WqEsga0T76pWh6MpDbErFsvU+qPXGRno7QcTNDzSp40/5hPkt6GdkSybs1TWynwrQREn8X+o4QWVSCsnwCtOvPw+Pxmz5BgPVlpJhsrY78ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612145; c=relaxed/simple;
	bh=4r1z6HtWUnySZNvtvG1gblMCYFFQ/7oF0GQ1wyfk/fA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mA5uUfyzd8ve+ixhnOLPgSYHxMLO5o0MSHz0HDVMpVBxHIrQbKgVLMR77m0OCE9F7a2O7v/nbIP4JaxSOnkDPhRVYO9303a6OrkxzQfd98+5I8f9f1YM8jfhwKVT2eVcHLA1KyDsuep00t+Mnb5m9KqiYNxZEraWcCvZZ9XQYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSYeA3HF; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-88f27b67744so84833185a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760612142; x=1761216942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tUv0dDyeU7y7WspWVqJNMNUdztGgUwvGxjkgJqZoga0=;
        b=bSYeA3HFh6BZtr3WrjNAhb9VuapbTjNDYM+wBozoQ2utR6P447I2KsR39hu61fsvX9
         Xv9Scp6E5jkxsE8mh4ne5gBXUBXK9+kA5fXFaX+SDxZEc71Ya5lntxedL9rsMhvgz46a
         yfCERzbQEjF5aD5QZyIR9gNGDJddS4wplrmIQ/0jncJ0O+zG+jKsq6R9P5M6jb17+KiY
         hcL0wD4++DzrfMppgfuCNeMA5GqAvc4u80UrIVBkoG1drjyWNNLDYtWt1oVLk2L7IRLK
         x6Awm13jgFuR1XdZ/BwmaicopjAn73PXHo0bGKWFX1nbYPxQlmAI4WDVD8Gaoc88cgVN
         2dLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760612142; x=1761216942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUv0dDyeU7y7WspWVqJNMNUdztGgUwvGxjkgJqZoga0=;
        b=pJklNGuCbBKscbzfFyck6FEDr+v3dKtoj5wwYXYfKhtNrp+vtr7lA5WqGTDErZvzpY
         ZOUZOpkCnKIAkUjYCDUCqiKsfwqjiUBOaiypQEedKnhd5NWF+cNBTaGGbPnlI88JNOSb
         iEgrKOtZipRcghw67jx+V5LvKohgP3mTp4/wEKORj739xNy+T5lwRMalFU+XpCZxNmK1
         Jql6mBG+FFUbEtyCKnZV69WwQC23tx+eqCodFViEygKrn/J9tmutqTwnFO1J6dZdRjLA
         EsEpDX3FJN3+qKB4w/V9dRWzfIlXk/DWCMAveU2VoueN5B08leRLKxTAVlLW3uayam+3
         BW4g==
X-Forwarded-Encrypted: i=1; AJvYcCXARjK61lkKOsdAZf6AQFVXhFSBeC/Feo0Lyi7h3b4xvtsq7CcnNht5E9E2OQiGMPtZS/KsJ7++sptx5I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyvqC6YfHa89m5pT4TMLIbLCRau2IDdxCnc1OTVS690Q2ZEWGU
	ZAKYslbXXNQS/WOerMe3oKALrgNIPQ/AEjPG48PVIPnUqPUv7wXyjH92
X-Gm-Gg: ASbGnctEbXBFfjzr59Rqn9xYe0Hc4uaPHw0rGXWvNPZb+9R981GQdO4bH0SqMkCsvkE
	AsfzZVIqWKewghVQn8Su2eAhxtWw+7zQWZJy9TKbmR+FRAd0n1BbgRXoTfv6MJTDPE8vcQF6DVo
	CqSbzd0698uBoJHaccTWFiNdWI56LuBzPgV2J+3wQ5c5iXMtrSiwG47a70BCzJK6HjODc4eRVmS
	fMOy7VWOMZkugwGOOYqjsjMTPVLgv9QfXcb6R1SsqL0ERunU81tVi4KHCs9z+vk1JT4MvmB03O7
	FsuCi1ACYSshFtVblkMdvKTJxyJZ0IQyRJ+tFcerUWYCLjms/nrL7RKvVpPNKoH/evAdGDRnOMy
	TNjrwkx4XCyYaYicUxntm7gNGvB984lYQqB9BeqKNYhQKy2DfSKbfRW+TpINFLfBXUd1ync5qS7
	OZr1gyhqY7t/GTofaPvXrBjDtkrnPxgLKndWE9bl3+Lxo=
X-Google-Smtp-Source: AGHT+IHSbCNA4gKXGQ79Apbh6UBdRta7p0DwiGGgBt4gE+gkwTjNxJ3W0SoZh5OSP96PJHmnX5Q4Lw==
X-Received: by 2002:a05:620a:2982:b0:827:1bda:ca68 with SMTP id af79cd13be357-883544f4c00mr3625404985a.46.1760612142108;
        Thu, 16 Oct 2025 03:55:42 -0700 (PDT)
Received: from kernel-internship-machine.. ([143.110.209.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f35c67577sm173681985a.25.2025.10.16.03.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:55:41 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: deller@gmx.de,
	soci@c64.rulez.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH] fbdev: vga16fb: replace printk() with dev_*() in probe
Date: Thu, 16 Oct 2025 10:54:46 +0000
Message-Id: <20251016105446.3646544-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dev_*() with &dev->dev and drop the hard-coded prefix. Keep
original severities. No functional change.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/video/fbdev/vga16fb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index eedab14c7d51..85852bca2d23 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1319,7 +1319,7 @@ static int vga16fb_probe(struct platform_device *dev)
 	if (ret)
 		return ret;
 
-	printk(KERN_DEBUG "vga16fb: initializing\n");
+	dev_dbg(&dev->dev, "initializing\n");
 	info = framebuffer_alloc(sizeof(struct vga16fb_par), &dev->dev);
 
 	if (!info) {
@@ -1331,12 +1331,12 @@ static int vga16fb_probe(struct platform_device *dev)
 	info->screen_base = (void __iomem *)VGA_MAP_MEM(VGA_FB_PHYS_BASE, 0);
 
 	if (!info->screen_base) {
-		printk(KERN_ERR "vga16fb: unable to map device\n");
+		dev_err(&dev->dev, "unable to map device\n");
 		ret = -ENOMEM;
 		goto err_ioremap;
 	}
 
-	printk(KERN_INFO "vga16fb: mapped to 0x%p\n", info->screen_base);
+	dev_info(&dev->dev, "mapped to 0x%p\n", info->screen_base);
 	par = info->par;
 
 	par->isVGA = screen_info_video_type(si) == VIDEO_TYPE_VGAC;
@@ -1364,13 +1364,13 @@ static int vga16fb_probe(struct platform_device *dev)
 	i = (info->var.bits_per_pixel == 8) ? 256 : 16;
 	ret = fb_alloc_cmap(&info->cmap, i, 0);
 	if (ret) {
-		printk(KERN_ERR "vga16fb: unable to allocate colormap\n");
+		dev_err(&dev->dev, "unable to allocate colormap\n");
 		ret = -ENOMEM;
 		goto err_alloc_cmap;
 	}
 
 	if (vga16fb_check_var(&info->var, info)) {
-		printk(KERN_ERR "vga16fb: unable to validate variable\n");
+		dev_err(&dev->dev, "unable to validate variable\n");
 		ret = -EINVAL;
 		goto err_check_var;
 	}
@@ -1381,7 +1381,7 @@ static int vga16fb_probe(struct platform_device *dev)
 	if (ret)
 		goto err_check_var;
 	if (register_framebuffer(info) < 0) {
-		printk(KERN_ERR "vga16fb: unable to register framebuffer\n");
+		dev_err(&dev->dev, "unable to register framebuffer\n");
 		ret = -EINVAL;
 		goto err_check_var;
 	}
-- 
2.34.1


