Return-Path: <linux-kernel+bounces-874539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D71C168A3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 382574E3C18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC7034DB76;
	Tue, 28 Oct 2025 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oud1k425"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAA9230BD9
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761677432; cv=none; b=BY2KPGeOZcmuDH7j2tGbPeVJFGAD1QKqJMht8C5Z7qXsCYWk9GDTzEIOWLWjDruXd9LyVNQF7HC0Kxg2O2FV061IEmLHl39uma1RFQ7mcIefPJ+btEkKEtTU8ckbxXsBLN4beMirLAy5DrCFfzNs/vWbvdZLzPm8TFSiaL+vGLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761677432; c=relaxed/simple;
	bh=4QPHYuLz7jGyYRxvQVaik81O1F3uvSKbF+5o4u1nejo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QNS9OUinqorrub4K1FV5QnEzyIVA37AChazZAD7j9OHkPkLj3zvlInbyxIuVgtpYtvkIPZbJDiXNuKmiFNEhtptx3b/R2E9GO2JWjNB7GTgMT18EHXA+vRaR3tgIBianpOehzHJzhydcFWwkCvX2c/DFmeMvtp5epEYITpQV89M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oud1k425; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4711810948aso47476235e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761677428; x=1762282228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKInHWtL/NoTyGjIvodU8RE8yH+iry3ECrXzTsyTC9E=;
        b=Oud1k425+vVqYOJqWdr5/IY4ocUX1pELMAtHS/SPmehF5TXU+h88lc3SqwHL43T49b
         jO+gVoQrsgZgS3twaslzzDORgtZDGq77dUgIf1oLAkurauuz63CiMPDlpdKX/TJwLPBd
         YJwiUSkmRKddU+G71xLC7gM3vFWh6IBaqo3GF6+0htVtFDTU0v2TP3iEHP6i5fk8w4TB
         qMLsgcQsCCnekLBlKYR8lHd1U20WDoXjUwTrU/F3iKZhIDAguUox9CLFzQSV9rwMmz9e
         mgPaaZC4d/WqikpFfAp+b8ZsAJnAsbJTKO+MIpz38hRum41myt07IEOT1mNLZVT1CFoD
         kIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761677428; x=1762282228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKInHWtL/NoTyGjIvodU8RE8yH+iry3ECrXzTsyTC9E=;
        b=tYFGX42gQdiE4QJ0ICtRYzG1WMNHoyryY/rDt4OanWR/AvatBGLWnhC+jpGXRvSXHk
         vEZ/y1E3ULT4O3FhVks8EXKvANTLFajtXgeAR/b7IwnredKvxjgivSlXXaD35JYpofe3
         6CgHrxxwpPwlRazntKf1WuWKiM8qzpGsdphEZzL3Fb8LMN3+Q6/Te18LG/gTKnSrzrQf
         SjJPa4Vmjn45B0vH/0AiAiAt6lDNNv6gaeWInYiZ8FvEqtz/BXXVXwKch7tqVI8TnPai
         ehoryELfaGSS66YDnqed4FmDVf7Pz4lw2N1NObb8ygmDd48bYiyoCyRSxcm1RJ8WlLxp
         0r6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJiLw/8bhlqSoFQxvwUumHBNSpVLv6feJzLDz1Dv4H+DZyQzNkMM/vcJSTOVqQJMJ3mLYyPo+Py66GDPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCwpzvxiw8Tp1QQDJvlaySfuXd+2y7kIhFG3Vjqoam2PiRFKNS
	VOyrxBID1EEiKoqSwI7CJLCAEs5tscqoyuyP3fxp6ObNMNkQ60u2xBzJ
X-Gm-Gg: ASbGnctek80GinyObSbAGLV1mmMNBSZd4qZ7vZhRqqO7rWZu+ebKI2Vf3RmyzEg+sx8
	Vuv5t5MkL+wOtwPZq2/F1/pgKUugF/4S/zJq0dhcM6d79Pqqlg+yi9qh4Od3X+msXg2OZzAWHie
	xm/sPjarsyGjs+DnMug5fxNAgpMVsFy3nhheW1v5K0rlEvAAdqNYhnOtU+NMYyJHq258YWWYJ6h
	plRyx3dulrMLwrSZoJfz7IcTzDqXnBN2wWUUrJKevCTuP9F7CvM2HDE8JCMbagCwhAN6F8vMApt
	I6kuC0FxD01M00R5uQYqFXVNFKkplLGDIYsdHF5NhZoBfFEN1qHoCebw6uSjTOwyBqka4fi+/8c
	J224IszkYxdgTHXYYXrYIaapHWb3Ip7i4yNRLSJ1c1TtYI5Wxmz13LJN6sUaWRgjIn9YAX32oNY
	lab7Zd8woOeUzlPlQxFif9HNvuNjqB3MlzFgFB4P5UOLYDdD/yLuamYVbaDd0=
X-Google-Smtp-Source: AGHT+IGRVa25s3OR2Cduu1pjQMHI10hc0vMm3RMUpviJTN181mKMkawFAXSXy+jCA9K4dDiCJCC0tw==
X-Received: by 2002:a05:600c:4686:b0:476:6ef6:e28c with SMTP id 5b1f17b1804b1-4771e3ba62emr3417945e9.38.1761677428341;
        Tue, 28 Oct 2025 11:50:28 -0700 (PDT)
Received: from dell (229.red-88-1-12.dynamicip.rima-tde.net. [88.1.12.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5c9dsm22782280f8f.26.2025.10.28.11.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 11:50:27 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH] fbdev/vesafb: Use dev_* fn's instead printk.
Date: Tue, 28 Oct 2025 19:50:21 +0100
Message-ID: <20251028185021.2758401-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
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
 drivers/video/fbdev/vesafb.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index a81df8865143..36c1fc553883 100644
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
+	dev_info(&dev->dev,"mode is %dx%dx%d, linelength=%d, pages=%d\n",
 	       vesafb_defined.xres, vesafb_defined.yres, vesafb_defined.bits_per_pixel,
 	       vesafb_fix.line_length, si->pages);
 
 	if (si->vesapm_seg) {
-		printk(KERN_INFO "vesafb: protected mode interface info at %04x:%04x\n",
+		dev_info(&dev->dev, "protected mode interface info at %04x:%04x\n",
 		       si->vesapm_seg, si->vesapm_off);
 	}
 
@@ -352,9 +352,9 @@ static int vesafb_probe(struct platform_device *dev)
 		pmi_base  = (unsigned short *)phys_to_virt(pmi_phys);
 		pmi_start = (void*)((char*)pmi_base + pmi_base[1]);
 		pmi_pal   = (void*)((char*)pmi_base + pmi_base[2]);
-		printk(KERN_INFO "vesafb: pmi: set display start = %p, set palette = %p\n",pmi_start,pmi_pal);
+		dev_info(&dev->dev, "pmi: set display start = %p, set palette = %p\n",pmi_start,pmi_pal);
 		if (pmi_base[3]) {
-			printk(KERN_INFO "vesafb: pmi: ports = ");
+			dev_info(&dev->dev, "pmi: ports = ");
 			for (i = pmi_base[3]/2; pmi_base[i] != 0xffff; i++)
 				printk("%x ", pmi_base[i]);
 			printk("\n");
@@ -365,14 +365,14 @@ static int vesafb_probe(struct platform_device *dev)
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
@@ -380,10 +380,10 @@ static int vesafb_probe(struct platform_device *dev)
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
@@ -410,7 +410,7 @@ static int vesafb_probe(struct platform_device *dev)
 		vesafb_defined.bits_per_pixel;
 	}
 
-	printk(KERN_INFO "vesafb: %s: "
+	dev_info(&dev->dev, "%s: "
 	       "size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
 	       (vesafb_defined.bits_per_pixel > 8) ?
 	       "Truecolor" : (vga_compat || pmi_setpal) ?
@@ -453,14 +453,14 @@ static int vesafb_probe(struct platform_device *dev)
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


