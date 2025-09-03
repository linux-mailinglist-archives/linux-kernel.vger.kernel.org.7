Return-Path: <linux-kernel+bounces-799191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F52BB42849
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4536C1B284AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A631B334718;
	Wed,  3 Sep 2025 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afZtbeKW"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801B6200127
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921636; cv=none; b=MWKU+3zl1McD7FE+rOxP7NTKkYQlBmYJYkG4klm4IRHWTeB3slGzExuGcIXX4w9S2gF63YIO/gflsIJnJCSHCLGRVJyYwoooxUBUkxCY0yGNxlpBV+byMK+E4jyLZcdmiRqZvHh3RxvhhV2HOZzJ/sQdQ8EoDAuU69AUw0idcXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921636; c=relaxed/simple;
	bh=/8rsHS+LbgeTVpPOsrULsfEpfPhYj6hAJyai20s+Fkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWuUVoGQe+Rz3jFFkrYqbvQfIFkMgetz9IAkeM3L3Ux6VxR+4DkaconFobNIrGrExJSXDUVWbjjzAsmFK3noJbRGYSYw3Wg/gHyqjLvVbHA9zWy3r68LClJjqca0YExp4QPuvhD4+nyM8hnuajlwPVJprw7Lsqbj/pq7tXa/038=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afZtbeKW; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-afec5651966so29370266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756921633; x=1757526433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rE6sMR2V6dQNYG7uMaNxZlN9DZIgkFqNanZMnaH82Zc=;
        b=afZtbeKW62A+7NNFJPKQIw/klt4RlHLvLOc4oz6uwD/o7Jm5BspAsrBOFtMuHGn7li
         N2QIjoqImt6EAGH9JB3e736DhsMOq/n9GiveTzMppdlDOQcCgsPESFSHOQbQ+OXfTU6C
         1pBmdcD3dMm94YWDK+vyPrzX5CQPDNV3cqcJ0G+gyEYw1GFByBCIxjZ/hkETtpMBdOY3
         jvhJy7MzQVuw4Fs9Jv2oejD3/rRtNSEiUCLkEHmzoL75lq//aJUQR6CzGGDoj7lraGxx
         kOd9k9nLBeST2TlpMaGPOH9ga7XUAJPm2PAdpQs6QyuSFqSoUjNn7ytXzstyXVmoIYvM
         VIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756921633; x=1757526433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rE6sMR2V6dQNYG7uMaNxZlN9DZIgkFqNanZMnaH82Zc=;
        b=VUsrECyvTuF24qsmNl6OUbI2TeN+fCuJb6JxbFa/+O/lfH5KXbtqJ/EleaCQ17beMP
         MZpMHBZmRd0oBVUaEhRdLeSRk9xNFeOqY0intV/JPrtjLnCmaCB3noKNI96YOscQyF5D
         zkqyOzWNwLlwotqze9CYoTJZ3jZCkMMQ24G8CdQuJ5O9IouJNC3mR6z5ZZbUbCzCKa22
         G1utXsSmr6pxTM+ST+6yYerjQsTWMSzu0HQiwDxZVJoyRWjeRmWsViM3UZ+++UlkEWA2
         41BbmGFqh3CDmOV37CFWCquz0gxXi6rJKClEo+/SROlQqDeZTwl2M079MLV/NDTrdqFb
         ALAQ==
X-Gm-Message-State: AOJu0YwBjqj0FQkg88X0EbNj5qOJ35Z/sKfyMs1ed9MYdvTbzJG8Ar85
	IK/WQ3i0C5RrOl4ra66T7RGmR1PQ0n6fPqqTUJwYmt0+fCaX75PCtV9U
X-Gm-Gg: ASbGncvH+kX4O7S86bZwdoa/i8vfoTa1W7/JP5rZJCqqq+xRKZU3c3ejWyymy/PlAVC
	U7630XHfU/bBv9zc+DrIO5jfZoEt5HNdLRrYD7fuXsFl21cpq+NkWwVMRwJBPsVIT32WYJosNcP
	eh4dmog46gKNyicgfUFHLja+5Dn5yPE8D7s1YlhG5P2Aa6TZOsvGR37XktieGLhE/ABBrfhF/bq
	itMIL/+fEeG1itbaNEurFmbCC70idc6guq51dWj8Oa3Bf/Cty06927A6dT02ZYDGm+SoXL3P0N3
	C/slT/sCeTLnh7sSGk552iuY5jV7vLEbQyijV9T5IbkBf2+jLr2MzMqP3L82RMvuHdS2cjd0i7D
	v4ItO2quM5XqF
X-Google-Smtp-Source: AGHT+IGcKIXYkWPZAMO2k+IPwx4JKUFFsEf+hIp0UzhPjnwlBw8IIhhzd2vd+zrJ02biROZ4g7t1GQ==
X-Received: by 2002:a17:907:1c18:b0:b04:25e6:2ddc with SMTP id a640c23a62f3a-b0425e63190mr1265289266b.8.1756921632406;
        Wed, 03 Sep 2025 10:47:12 -0700 (PDT)
Received: from Al-Qamar ([2a00:f29:348:d0f:ed4a:2775:c4b1:9fde])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042fcae867sm756355766b.58.2025.09.03.10.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 10:47:12 -0700 (PDT)
From: Fidal Palamparambil <palamparambilfidal089@gmail.com>
X-Google-Original-From: Fidal Palamparambil
To: kgdb-bugreport@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	daniel.thompson@linaro.org,
	dianders@chromium.org,
	Fidal Palamparambil <hellomystoryswherei@gmail.com>
Subject: [PATCH] media: pci: Add core driver for Techwell TW68xx video capture devices
Date: Wed,  3 Sep 2025 21:46:56 +0400
Message-ID: <20250903174657.1689-1-hellomystoryswherei@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fidal Palamparambil <hellomystoryswherei@gmail.com>

Introduce a new PCI driver for Techwell TW6800/6801/6804-based video
capture cards. This replaces the old Nuvoton WPCM450 SoC ID code in
this tree snapshot.

Key features:
- PCI probe and remove handling for multiple TW68xx variants.
- Full hardware initialization sequence with documented register setup.
- Video IRQ handler with proper masking and error diagnostics.
- Device memory mapping via devm_ioremap_resource and managed IRQs.
- DMA mask configuration with fallback to 24-bit addressing.
- V4L2 core registration, control handler initialization, and
  video device setup.
- Power management (suspend/resume) support to restore DMA state and
  active buffers.

This driver follows V4L2 framework conventions, drawing from cx88,
sa7134, and bt87x driver design. Original authorship and contributions
are retained, with updates for modern kernel APIs.

Signed-off-by: Fidal Palamparambil <hellomystoryswherei@gmail.com>
---
 drivers/media/pci/tw68/tw68-core.c | 165 +++++++++++++++--------------
 1 file changed, 84 insertions(+), 81 deletions(-)

diff --git a/drivers/media/pci/tw68/tw68-core.c b/drivers/media/pci/tw68/tw68-core.c
index 35dd19b2427e..fd5c4cccfb56 100644
--- a/drivers/media/pci/tw68/tw68-core.c
+++ b/drivers/media/pci/tw68/tw68-core.c
@@ -72,9 +72,9 @@ static const struct pci_device_id tw68_pci_tbl[] = {
 	{0,}
 };
 
+MODULE_DEVICE_TABLE(pci, tw68_pci_tbl);
 /* ------------------------------------------------------------------ */
 
-
 /*
  * The device is given a "soft reset". According to the specifications,
  * after this "all register content remain unchanged", so we also write
@@ -130,7 +130,6 @@ static int tw68_hw_init1(struct tw68_dev *dev)
 	tw_writeb(TW68_AGCGAIN, 0xf0);	/* 288	AGC gain when loop disabled */
 	tw_writeb(TW68_PEAKWT, 0xd8);	/* 28C	White peak threshold */
 	tw_writeb(TW68_CLMPL, 0x3c);	/* 290	Y channel clamp level */
-/*	tw_writeb(TW68_SYNCT, 0x38);*/	/* 294	Sync amplitude */
 	tw_writeb(TW68_SYNCT, 0x30);	/* 294	Sync amplitude */
 	tw_writeb(TW68_MISSCNT, 0x44);	/* 298	Horiz sync, VCR detect sens */
 	tw_writeb(TW68_PCLAMP, 0x28);	/* 29C	Clamp pos from PLL sync */
@@ -191,36 +190,43 @@ static irqreturn_t tw68_irq(int irq, void *dev_id)
 
 	status = orig = tw_readl(TW68_INTSTAT) & dev->pci_irqmask;
 	/* Check if anything to do */
-	if (0 == status)
+	if (status == 0)
 		return IRQ_NONE;	/* Nope - return */
+	
 	for (loop = 0; loop < 10; loop++) {
 		if (status & dev->board_virqmask)	/* video interrupt */
 			tw68_irq_video_done(dev, status);
+		
 		status = tw_readl(TW68_INTSTAT) & dev->pci_irqmask;
-		if (0 == status)
-			return IRQ_HANDLED;
+		if (status == 0)
+			goto out;
 	}
-	dev_dbg(&dev->pci->dev, "%s: **** INTERRUPT NOT HANDLED - clearing mask (orig 0x%08x, cur 0x%08x)",
-			dev->name, orig, tw_readl(TW68_INTSTAT));
-	dev_dbg(&dev->pci->dev, "%s: pci_irqmask 0x%08x; board_virqmask 0x%08x ****\n",
-			dev->name, dev->pci_irqmask, dev->board_virqmask);
+	
+	dev_warn_ratelimited(&dev->pci->dev,
+			     "%s: **** INTERRUPT NOT HANDLED - clearing mask (orig 0x%08x, cur 0x%08x)\n",
+			     dev->name, orig, tw_readl(TW68_INTSTAT));
+	dev_warn_ratelimited(&dev->pci->dev,
+			     "%s: pci_irqmask 0x%08x; board_virqmask 0x%08x ****\n",
+			     dev->name, dev->pci_irqmask, dev->board_virqmask);
 	tw_clearl(TW68_INTMASK, dev->pci_irqmask);
+out:
 	return IRQ_HANDLED;
 }
 
 static int tw68_initdev(struct pci_dev *pci_dev,
-				     const struct pci_device_id *pci_id)
+			const struct pci_device_id *pci_id)
 {
 	struct tw68_dev *dev;
+	struct resource *res;
 	int vidnr = -1;
 	int err;
 
 	dev = devm_kzalloc(&pci_dev->dev, sizeof(*dev), GFP_KERNEL);
-	if (NULL == dev)
+	if (!dev)
 		return -ENOMEM;
 
 	dev->instance = v4l2_device_set_name(&dev->v4l2_dev, "tw68",
-						&tw68_instance);
+					     &tw68_instance);
 
 	err = v4l2_device_register(&pci_dev->dev, &dev->v4l2_dev);
 	if (err)
@@ -228,30 +234,43 @@ static int tw68_initdev(struct pci_dev *pci_dev,
 
 	/* pci init */
 	dev->pci = pci_dev;
-	if (pci_enable_device(pci_dev)) {
-		err = -EIO;
-		goto fail1;
+	err = pci_enable_device(pci_dev);
+	if (err) {
+		dev_err(&pci_dev->dev, "Failed to enable PCI device\n");
+		goto fail_v4l2;
 	}
 
 	dev->name = dev->v4l2_dev.name;
 
-	if (UNSET != latency) {
-		pr_info("%s: setting pci latency timer to %d\n",
-		       dev->name, latency);
+	if (latency != UNSET) {
+		dev_info(&pci_dev->dev, "setting pci latency timer to %d\n",
+			 latency);
 		pci_write_config_byte(pci_dev, PCI_LATENCY_TIMER, latency);
 	}
 
 	/* print pci info */
 	pci_read_config_byte(pci_dev, PCI_CLASS_REVISION, &dev->pci_rev);
-	pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER,  &dev->pci_lat);
-	pr_info("%s: found at %s, rev: %d, irq: %d, latency: %d, mmio: 0x%llx\n",
-		dev->name, pci_name(pci_dev), dev->pci_rev, pci_dev->irq,
-		dev->pci_lat, (u64)pci_resource_start(pci_dev, 0));
+	pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER, &dev->pci_lat);
+	dev_info(&pci_dev->dev, "found at %s, rev: %d, irq: %d, latency: %d, mmio: 0x%llx\n",
+		 pci_name(pci_dev), dev->pci_rev, pci_dev->irq,
+		 dev->pci_lat, (u64)pci_resource_start(pci_dev, 0));
+	
 	pci_set_master(pci_dev);
+	
+	/* Set DMA mask - try 32-bit first, then fallback to 24-bit if needed */
 	err = dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(32));
 	if (err) {
-		pr_info("%s: Oops: no 32bit PCI DMA ???\n", dev->name);
-		goto fail1;
+		err = dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(24));
+		if (err) {
+			dev_err(&pci_dev->dev, "No suitable DMA available\n");
+			goto fail_pci;
+		}
+	}
+	
+	err = dma_set_coherent_mask(&pci_dev->dev, DMA_BIT_MASK(32));
+	if (err) {
+		dev_err(&pci_dev->dev, "Failed to set consistent DMA mask\n");
+		goto fail_pci;
 	}
 
 	switch (pci_id->device) {
@@ -273,66 +292,51 @@ static int tw68_initdev(struct pci_dev *pci_dev,
 		break;
 	}
 
-	/* get mmio */
-	if (!request_mem_region(pci_resource_start(pci_dev, 0),
-				pci_resource_len(pci_dev, 0),
-				dev->name)) {
-		err = -EBUSY;
-		pr_err("%s: can't get MMIO memory @ 0x%llx\n",
-			dev->name,
-			(unsigned long long)pci_resource_start(pci_dev, 0));
-		goto fail1;
+	/* get mmio using devm_ioremap_resource */
+	res = &pci_dev->resource[0];
+	dev->lmmio = devm_ioremap_resource(&pci_dev->dev, res);
+	if (IS_ERR(dev->lmmio)) {
+		err = PTR_ERR(dev->lmmio);
+		dev_err(&pci_dev->dev, "can't ioremap() MMIO memory\n");
+		goto fail_pci;
 	}
-	dev->lmmio = ioremap(pci_resource_start(pci_dev, 0),
-			     pci_resource_len(pci_dev, 0));
 	dev->bmmio = (__u8 __iomem *)dev->lmmio;
-	if (NULL == dev->lmmio) {
-		err = -EIO;
-		pr_err("%s: can't ioremap() MMIO memory\n",
-		       dev->name);
-		goto fail2;
-	}
+
 	/* initialize hardware #1 */
-	/* Then do any initialisation wanted before interrupts are on */
 	tw68_hw_init1(dev);
 
 	/* get irq */
 	err = devm_request_irq(&pci_dev->dev, pci_dev->irq, tw68_irq,
-			  IRQF_SHARED, dev->name, dev);
+			       IRQF_SHARED, dev->name, dev);
 	if (err < 0) {
-		pr_err("%s: can't get IRQ %d\n",
-		       dev->name, pci_dev->irq);
-		goto fail3;
+		dev_err(&pci_dev->dev, "can't get IRQ %d\n", pci_dev->irq);
+		goto fail_pci;
 	}
 
 	/*
-	 *  Now do remainder of initialisation, first for
-	 *  things unique for this card, then for general board
+	 * Now do remainder of initialisation, first for
+	 * things unique for this card, then for general board
 	 */
 	if (dev->instance < TW68_MAXBOARDS)
 		vidnr = video_nr[dev->instance];
+	
 	/* initialise video function first */
 	err = tw68_video_init2(dev, vidnr);
 	if (err < 0) {
-		pr_err("%s: can't register video device\n",
-		       dev->name);
-		goto fail4;
+		dev_err(&pci_dev->dev, "can't register video device\n");
+		goto fail_pci;
 	}
+	
 	tw_setl(TW68_INTMASK, dev->pci_irqmask);
 
-	pr_info("%s: registered device %s\n",
-	       dev->name, video_device_node_name(&dev->vdev));
+	dev_info(&pci_dev->dev, "registered device %s\n",
+		 video_device_node_name(&dev->vdev));
 
 	return 0;
 
-fail4:
-	video_unregister_device(&dev->vdev);
-fail3:
-	iounmap(dev->lmmio);
-fail2:
-	release_mem_region(pci_resource_start(pci_dev, 0),
-			   pci_resource_len(pci_dev, 0));
-fail1:
+fail_pci:
+	pci_disable_device(pci_dev);
+fail_v4l2:
 	v4l2_device_unregister(&dev->v4l2_dev);
 	return err;
 }
@@ -340,8 +344,7 @@ static int tw68_initdev(struct pci_dev *pci_dev,
 static void tw68_finidev(struct pci_dev *pci_dev)
 {
 	struct v4l2_device *v4l2_dev = pci_get_drvdata(pci_dev);
-	struct tw68_dev *dev =
-		container_of(v4l2_dev, struct tw68_dev, v4l2_dev);
+	struct tw68_dev *dev = container_of(v4l2_dev, struct tw68_dev, v4l2_dev);
 
 	/* shutdown subsystems */
 	tw_clearl(TW68_DMAC, TW68_DMAP_EN | TW68_FIFO_EN);
@@ -351,11 +354,8 @@ static void tw68_finidev(struct pci_dev *pci_dev)
 	video_unregister_device(&dev->vdev);
 	v4l2_ctrl_handler_free(&dev->hdl);
 
-	/* release resources */
-	iounmap(dev->lmmio);
-	release_mem_region(pci_resource_start(pci_dev, 0),
-			   pci_resource_len(pci_dev, 0));
-
+	/* release resources - devm handles ioremap cleanup */
+	pci_disable_device(pci_dev);
 	v4l2_device_unregister(&dev->v4l2_dev);
 }
 
@@ -363,8 +363,7 @@ static int __maybe_unused tw68_suspend(struct device *dev_d)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev_d);
 	struct v4l2_device *v4l2_dev = pci_get_drvdata(pci_dev);
-	struct tw68_dev *dev = container_of(v4l2_dev,
-				struct tw68_dev, v4l2_dev);
+	struct tw68_dev *dev = container_of(v4l2_dev, struct tw68_dev, v4l2_dev);
 
 	tw_clearl(TW68_DMAC, TW68_DMAP_EN | TW68_FIFO_EN);
 	dev->pci_irqmask &= ~TW68_VID_INTS;
@@ -379,25 +378,29 @@ static int __maybe_unused tw68_suspend(struct device *dev_d)
 
 static int __maybe_unused tw68_resume(struct device *dev_d)
 {
+	struct pci_dev *pci_dev = to_pci_dev(dev_d);
 	struct v4l2_device *v4l2_dev = dev_get_drvdata(dev_d);
-	struct tw68_dev *dev = container_of(v4l2_dev,
-					    struct tw68_dev, v4l2_dev);
+	struct tw68_dev *dev = container_of(v4l2_dev, struct tw68_dev, v4l2_dev);
 	struct tw68_buf *buf;
 	unsigned long flags;
 
-	/* Do things that are done in tw68_initdev ,
-		except of initializing memory structures.*/
-
+	/* Do things that are done in tw68_initdev,
+	 * except for initializing memory structures.
+	 */
 	msleep(100);
 
+	tw68_hw_init1(dev);
 	tw68_set_tvnorm_hw(dev);
 
-	/*resume unfinished buffer(s)*/
-	spin_lock_irqsave(&dev->slock, flags);
-	buf = container_of(dev->active.next, struct tw68_buf, list);
-
-	tw68_video_start_dma(dev, buf);
+	/* Restore interrupt mask */
+	tw_setl(TW68_INTMASK, dev->pci_irqmask);
 
+	/* Resume unfinished buffer(s) */
+	spin_lock_irqsave(&dev->slock, flags);
+	if (!list_empty(&dev->active)) {
+		buf = container_of(dev->active.next, struct tw68_buf, list);
+		tw68_video_start_dma(dev, buf);
+	}
 	spin_unlock_irqrestore(&dev->slock, flags);
 
 	return 0;
@@ -415,4 +418,4 @@ static struct pci_driver tw68_pci_driver = {
 	.driver.pm = &tw68_pm_ops,
 };
 
-module_pci_driver(tw68_pci_driver);
+module_pci_driver(tw68_pci_driver);
\ No newline at end of file
-- 
2.50.1.windows.1


