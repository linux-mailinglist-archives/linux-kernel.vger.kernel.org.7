Return-Path: <linux-kernel+bounces-879045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD610C221FA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254D7188DA05
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4554A36E357;
	Thu, 30 Oct 2025 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFE0Xpwz"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB7331A74
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854849; cv=none; b=rNrH7zbbJEsljWXTgx4Y0xXhNOOAhyvm6Sg5QZQLs76cSdLArdGGGwWYS5L5+ftgesfWX35wh23FpDkcTSiEBwTo2JF7XwVW9vCG95Uut2R6YorJrVvcl9EeF5+MpC+/IUVkAuZJ/lllGUF5rbmS5UzwYMvBh7Ek1kdFQmrzCFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854849; c=relaxed/simple;
	bh=3Js0uYAIC0bd6EOohKenbxNO7P8/ananC7e9waGafnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnWkF+OoDVcdAsu+wB4ZsmnvA6MTi71yUgEuSU4iJUFc5midSIUJdH4mB/f/htGQDEAXtDRkV/F5wDHLDwuYP+lD8GN11ds3kZXLFF72EUgCOV4J2I0ZiraqgdDfmV0b7AMm0kRqSMs2cPfi5D5ehL5N67JDwz+6VXvq7ai9GBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFE0Xpwz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so15696225e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761854846; x=1762459646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IK5/MD5jQaHlgmEIIClreHp/khBkythuO8kivjpFv+4=;
        b=KFE0XpwzNcs9lQNbtUayZtpNSa60PdYVEsKDpy7alo/b1kWdo/5Hcl120BQL9O6qCZ
         QAmATvB2ECh4P1UxuL38vmZOwRPoo7hjBVIdawUKfmES7VEhNwZbhhGYUuDAMmSW5NvP
         5852hBUxPiE55bHSvB36OziSGqZ+avTyWW2NBFjGTiG7aLsPEXe7RmKahPRsKJ3COX1t
         u963RNbtEizc6MjYCN9IqTg6aGAJSnOjbi9I29Wi3wVQ8aoGHJD0+UzEb4n1minN5ChY
         eaBOvJm3mcx4cuaLaXqKLiolXxQKAsHfqnFIiG9k3TTL4FO5ybSfCqckxGEc/9xbS+qa
         N8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761854846; x=1762459646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IK5/MD5jQaHlgmEIIClreHp/khBkythuO8kivjpFv+4=;
        b=HIzRs0MIgXIHhORgmcF7IxtUfpnln1LS+OBY1Ixp7A9f4BtghoGKVpJbAYdOG5Y1TT
         RW6YXdSdjdVnAKluIHexCvSp32Be6+W3n0a5B7A+uwGJDGPQffyES3/EX/b3u70CVr21
         CaJX5YluMNOTJa3OA+/xlDQN9LatsSpd+SZX9FT0oY9F9CAzxc867pxRcyUrNBU0NBN9
         pqzfBilV3ICf4fw2wuukzBKwYodIXbEAZRFUIFECF2U66bAndhpgyzEp4IE1/ni5k5xR
         oup78zjXA2o1frZx+xeBLJB5ooIfTt5xi7T6q6lUgaTuqJchwZxydVyQwYbUm2YnJ4GS
         u/ig==
X-Forwarded-Encrypted: i=1; AJvYcCUWKOO6bhngpaP5mIu79YFcF4mNq0Gzmh3j8PE/ZNM4LYv2RsJ42vA6NKzx/4+XuwvopmkUsPumcJJTeeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKZDdurmwrCM6JUWDEOgQXYa4+uAKLXdlrox3zBCK9KESezSc5
	WKb2UMpPWVMGq/RZLjqmjcTz78Tz8cy4+MaQHNVCTlP18AVOyep+0vRO
X-Gm-Gg: ASbGnctrFsJGQ59HRtg/qHeYywbTr3e5aiGxCQLm9aX11PVNMMfs7ikK1iI77MzGl26
	ohvO/a4XnkMOjvhEmiGjpWwPSFx2APH/Hpk5l7RphE4tlcmUOy1+nyJUpZ/Upzotmv5QzBF6IX0
	ckmd+Vu46QorbXAoeP3BvWfMTHbssWiGoaNXNvEP9mXLTmuXA8NQCgXmd6f1VAEN5Is4QOczJ0I
	HdKQxLUS2mi2g2O+Ddr4oUTb85D249Z6VjnuONPitaYwCXy/Rc2qZHswFXYj/yv35UjWmZm0rdg
	cUI5Ge2l02UVHG7rY8RsdAG0Usmbti++X7tizW+w+nsladrULfC4Vitx2afIwKIjt6O4KynxnyK
	W7DO5M1JbuC7lOu3CQgvUYHfxrQK+CRMPnNmzXqF8JctZ+gyTlQZDolxE2KkU83+u9fbc3wjXV4
	iCROyI6oYv1Ud7jbPypdLwOZb+7MJKZtLFSY+srmzTRnPG0lZ7zhPXfZAa9uw=
X-Google-Smtp-Source: AGHT+IEKK73PbMSHf6dhhfOw/8d7gi7F8JIqgvvWZVKIGfNyOVCe87Tf3SMiH0lxF2XB6hun78s0fA==
X-Received: by 2002:a05:600c:1c93:b0:46e:37d5:dbed with SMTP id 5b1f17b1804b1-4773010414fmr11136175e9.12.1761854845631;
        Thu, 30 Oct 2025 13:07:25 -0700 (PDT)
Received: from dell (229.red-88-1-12.dynamicip.rima-tde.net. [88.1.12.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952da645sm32485309f8f.30.2025.10.30.13.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 13:07:25 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH v2] fbdev/vesafb: Use dev_* fn's instead printk.
Date: Thu, 30 Oct 2025 21:07:23 +0100
Message-ID: <20251030200723.2788931-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028185021.2758401-1-rampxxxx@gmail.com>
References: <20251028185021.2758401-1-rampxxxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Family dev_* fn's will show device name, giving extra info to logs.
- Delete the prefix `vesafb:` from msg strings, not needed now.

[    0.981825] vesa-framebuffer vesa-framebuffer.0: scrolling: redraw

Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---
v1 -> v2:
      * Fix checkpatch.pl messages, thanks Helge Deller.
      * v1 https://lore.kernel.org/lkml/20251028185021.2758401-1-rampxxxx@gmail.com/

 drivers/video/fbdev/vesafb.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index a81df8865143..f135033c22fb 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -314,8 +314,8 @@ static int vesafb_probe(struct platform_device *dev)
 #endif
 
 	if (!request_mem_region(vesafb_fix.smem_start, size_total, "vesafb")) {
-		printk(KERN_WARNING
-		       "vesafb: cannot reserve video memory at 0x%lx\n",
+		dev_warn(&dev->dev,
+		       "cannot reserve video memory at 0x%lx\n",
 			vesafb_fix.smem_start);
 		/* We cannot make this fatal. Sometimes this comes from magic
 		   spaces our resource handlers simply don't know about */
@@ -333,12 +333,12 @@ static int vesafb_probe(struct platform_device *dev)
 	par->base = si->lfb_base;
 	par->size = size_total;
 
-	printk(KERN_INFO "vesafb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
+	dev_info(&dev->dev, "mode is %dx%dx%d, linelength=%d, pages=%d\n",
 	       vesafb_defined.xres, vesafb_defined.yres, vesafb_defined.bits_per_pixel,
 	       vesafb_fix.line_length, si->pages);
 
 	if (si->vesapm_seg) {
-		printk(KERN_INFO "vesafb: protected mode interface info at %04x:%04x\n",
+		dev_info(&dev->dev, "protected mode interface info at %04x:%04x\n",
 		       si->vesapm_seg, si->vesapm_off);
 	}
 
@@ -352,9 +352,10 @@ static int vesafb_probe(struct platform_device *dev)
 		pmi_base  = (unsigned short *)phys_to_virt(pmi_phys);
 		pmi_start = (void*)((char*)pmi_base + pmi_base[1]);
 		pmi_pal   = (void*)((char*)pmi_base + pmi_base[2]);
-		printk(KERN_INFO "vesafb: pmi: set display start = %p, set palette = %p\n",pmi_start,pmi_pal);
+		dev_info(&dev->dev, "pmi: set display start = %p, set palette = %p\n",
+			 pmi_start, pmi_pal);
 		if (pmi_base[3]) {
-			printk(KERN_INFO "vesafb: pmi: ports = ");
+			dev_info(&dev->dev, "pmi: ports = ");
 			for (i = pmi_base[3]/2; pmi_base[i] != 0xffff; i++)
 				printk("%x ", pmi_base[i]);
 			printk("\n");
@@ -365,14 +366,14 @@ static int vesafb_probe(struct platform_device *dev)
 				 * Rules are: we have to set up a descriptor for the requested
 				 * memory area and pass it in the ES register to the BIOS function.
 				 */
-				printk(KERN_INFO "vesafb: can't handle memory requests, pmi disabled\n");
+				dev_info(&dev->dev, "can't handle memory requests, pmi disabled\n");
 				ypan = pmi_setpal = 0;
 			}
 		}
 	}
 
 	if (vesafb_defined.bits_per_pixel == 8 && !pmi_setpal && !vga_compat) {
-		printk(KERN_WARNING "vesafb: hardware palette is unchangeable,\n"
+		dev_warn(&dev->dev, "hardware palette is unchangeable,\n"
 		                    "        colors may be incorrect\n");
 		vesafb_fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR;
 	}
@@ -380,10 +381,10 @@ static int vesafb_probe(struct platform_device *dev)
 	vesafb_defined.xres_virtual = vesafb_defined.xres;
 	vesafb_defined.yres_virtual = vesafb_fix.smem_len / vesafb_fix.line_length;
 	if (ypan && vesafb_defined.yres_virtual > vesafb_defined.yres) {
-		printk(KERN_INFO "vesafb: scrolling: %s using protected mode interface, yres_virtual=%d\n",
+		dev_info(&dev->dev, "scrolling: %s using protected mode interface, yres_virtual=%d\n",
 		       (ypan > 1) ? "ywrap" : "ypan",vesafb_defined.yres_virtual);
 	} else {
-		printk(KERN_INFO "vesafb: scrolling: redraw\n");
+		dev_info(&dev->dev, "scrolling: redraw\n");
 		vesafb_defined.yres_virtual = vesafb_defined.yres;
 		ypan = 0;
 	}
@@ -410,7 +411,7 @@ static int vesafb_probe(struct platform_device *dev)
 		vesafb_defined.bits_per_pixel;
 	}
 
-	printk(KERN_INFO "vesafb: %s: "
+	dev_info(&dev->dev, "%s: "
 	       "size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
 	       (vesafb_defined.bits_per_pixel > 8) ?
 	       "Truecolor" : (vga_compat || pmi_setpal) ?
@@ -453,14 +454,14 @@ static int vesafb_probe(struct platform_device *dev)
 	}
 
 	if (!info->screen_base) {
-		printk(KERN_ERR
-		       "vesafb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
+		dev_err(&dev->dev,
+		       "abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
 			vesafb_fix.smem_len, vesafb_fix.smem_start);
 		err = -EIO;
 		goto err_release_region;
 	}
 
-	printk(KERN_INFO "vesafb: framebuffer at 0x%lx, mapped to 0x%p, "
+	dev_info(&dev->dev, "framebuffer at 0x%lx, mapped to 0x%p, "
 	       "using %dk, total %dk\n",
 	       vesafb_fix.smem_start, info->screen_base,
 	       size_remap/1024, size_total/1024);
-- 
2.50.1


