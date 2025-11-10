Return-Path: <linux-kernel+bounces-892641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E10C45838
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D343B618E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0CA2FE045;
	Mon, 10 Nov 2025 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRcUotCT"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD87E2FCC12
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765492; cv=none; b=d4zqCcuAxzZLqOoX5LctNyzAWzWCSy0mLzPE6t3VoE6aBhFL1SZsBk/Hxb74lISlwGlG+iIrzHQ7gnojFDgrIly8h7uiZAe5rgx+Hto1cokAm2LVy9JLVEcxEIXxzgJhM9MHmkp6fUpc2k+E4MyBFz41htB9GfZb0P9rj7wmrQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765492; c=relaxed/simple;
	bh=cuSN+/ibhibAMGoE5yYpTwRCJCYlYwVkoPXJV+RI0GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O2jT9IwCki+J3lciYH34uodZsuxfHEx2aTifmPOcgM75lNt//f+M4YdTo1W07npDqxoucuCEkbJxRBONn7dmUai/8wPIrv++E5aSRlb+T90lxIkaDpWpWU4NlV5ObVPEB5VKQwWfLdbQL/3jnIlxOQNUTXzGeLgtiBN68jv0RAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRcUotCT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so14271255e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762765489; x=1763370289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk5vRB2A8CTvXBhPjKRDoJZr7gkm+Aa51P8sRfLV4X0=;
        b=XRcUotCTCEu69tsMyqU8cbA/VzEnq+xVT5zvc3d5dWA+vReauW3pcLGqUIp/q52jIV
         bx9lyRzhy8cm9pBeWlQtU8ty3uxMFhvhhHFxDPWr9TIPAVpABY/1gHcaGfcaHCzZIFaV
         fBLcD7Tk8m3FENIP6KkjYDh7EA/r4cjBT6KkUg7bXCAWZtcJyJMlNC/LZjk6N+N5Uwrv
         5kDW7BUo1OX3y+F+HLk8mN2zzGYKZUGu3FcJNoe38D6z1+URhPX+mUVqUALI4aRKTRd/
         AOEmxp+LxcNlqT6YwUKVLB7Y+lZlf5++QOKdNmk5zh/iYrXmi7DfrwJDuxnFgW8ZDDKu
         rFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762765489; x=1763370289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk5vRB2A8CTvXBhPjKRDoJZr7gkm+Aa51P8sRfLV4X0=;
        b=IPC3nnXIrpN+EByMEoBxPY+cgWu7OYRdV0wztX1Prl45e/4j1ab8SQsUk2fc2Tb8ZS
         GJ39TSJRFkEIM5uFptwTztmASBuAbO9csM3aS9bdbkvH+m5zAdZRatznNhAVfv4C0zth
         rrewQlBRXOa/Sa+tQexDvZBKefkAPCK7LK32F2h4NuMu4u2xSb9tEsvKF3yLeTm/T0yZ
         sohBVEJqFOtg6efNSW3ZqrmHKpzfMeuhZx1BKc6T6yztzL/Wk6g8PIxqGXWps8urPIm6
         RO6oiJebIRdrHVA+Xjq+G+lsH/pjNMk4jgNIIEIGkWkMvq5IsKjzxH94IAEJhvUOEtY5
         C9xg==
X-Forwarded-Encrypted: i=1; AJvYcCWBPdJ/M6RzD5gXQhAeaHa/GpnbcMjwntcy5WQC6/eKXf9IzfhZT57pMKD3x1nwbGdHUWuw71nX2ebc9IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmYTnJeg6xOu+MPVQnj7mxKaKi+JM9supbtYZCu18QqBH6FMAc
	9mElJAP1WT855lFO5SrdYoZLD1m/4Vs6K1UaKS2os5fqSKXwxC3o/jf3
X-Gm-Gg: ASbGncs0gWsePkz0CAfZG0LnkOA3/Lc2x07jdByqPl1ra9s9OOVnpsRpB4zlRVFJfQc
	AfufbLVS6y/VfgldD8VIO9EfGktmL+9j59uQiy4ouXVAdMfjOYtPeiswcUltPNsJSKsHMbEG2QN
	puQUlbNUmWWsygWz2xbB0tpkNMrmwkCs3Gme/C4GYPQB1mrUMp7fWyqCk/4GMyMDIpwclCLcgmm
	UH5cIwKwlgjHp8nyHp8HjFLL2VpZYIA4T87v1AgrtmkORphJr7luVis5AYvZVOAqUpp8cBxMBlF
	0QxGu1bp5Q5/PRlmtZptiuGE9mXvgkGJVPP+soh/96RclT6caZCAX4J3e1d83859M6T+Bq9ut0Y
	gyxfiqjhyzkqaFhaPeaqnQRcyM4hdz74kCTN3I+uTkVX+zxmXVpXgXh/rU3BEcofBugxC1/0pU9
	yjomedLdc1fS3EB94/XHmkXneXc/P7BpiYl6Yioj6RAimU6uqtGRi3tgkAZVQ=
X-Google-Smtp-Source: AGHT+IEwdnOYLiRxGnlYWFiugvoKZP0MLjXKBzH1fGwb5TD6K5KB/oIeeQdF5BkkS4fmoxY0g26LaA==
X-Received: by 2002:a05:600c:444b:b0:477:7a78:3016 with SMTP id 5b1f17b1804b1-4777a783204mr26968615e9.8.1762765488848;
        Mon, 10 Nov 2025 01:04:48 -0800 (PST)
Received: from dell (229.red-88-1-12.dynamicip.rima-tde.net. [88.1.12.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e7a6desm103083205e9.8.2025.11.10.01.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:04:48 -0800 (PST)
From: Javier Garcia <rampxxxx@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH] fbdev/vga16fb: Use dev_* fn's instead printk.
Date: Mon, 10 Nov 2025 10:04:46 +0100
Message-ID: <20251110090446.2910998-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Family dev_* fn's will show device name, giving extra info to logs.
- Delete the prefix `vga16fb:` from msg strings, not needed now.

[    1.037947] vga16fb vga-framebuffer.0: initializing

Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
 drivers/video/fbdev/vga16fb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index 3b4c50d98ba6..432ba7c8164b 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1324,7 +1324,7 @@ static int vga16fb_probe(struct platform_device *dev)
 		dev_err(&dev->dev, "vga16b: cannot reserve video memory at 0x%lx\n",
 		       vga16fb_fix.smem_start);
 	}
-	printk(KERN_DEBUG "vga16fb: initializing\n");
+	dev_dbg(&dev->dev, "initializing\n");
 	info = framebuffer_alloc(sizeof(struct vga16fb_par), &dev->dev);
 
 	if (!info) {
@@ -1336,12 +1336,12 @@ static int vga16fb_probe(struct platform_device *dev)
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
@@ -1369,13 +1369,13 @@ static int vga16fb_probe(struct platform_device *dev)
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
@@ -1386,7 +1386,7 @@ static int vga16fb_probe(struct platform_device *dev)
 	if (ret)
 		goto err_check_var;
 	if (register_framebuffer(info) < 0) {
-		printk(KERN_ERR "vga16fb: unable to register framebuffer\n");
+		dev_err(&dev->dev, "unable to register framebuffer\n");
 		ret = -EINVAL;
 		goto err_check_var;
 	}
-- 
2.50.1


