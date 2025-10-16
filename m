Return-Path: <linux-kernel+bounces-856612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634EABE49BE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55593B70A2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C142C329C54;
	Thu, 16 Oct 2025 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwU6O+Yh"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99D1FC110
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632589; cv=none; b=H76Q/7e8Qav32bFzAKOqgtleEjTbg0N1dsYNSt4patxy0RM435jPJqoGFpDMEA0w1IYKfdEWMEkRrEvTzcUcVuvR0IkYjqJCHJtxwy8LViU2LXYbkrxq299eDOECUWpsigU7plPJ9Vy0RvtbKt3rQozogAcKbw7PQUtv7cJ4sY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632589; c=relaxed/simple;
	bh=nGCl7r6sYsaGETR4dVzN/n0l3F0TLdlzghQngtVVq74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k77Y4uAjkrXzC0qc0kCZsostaddc2y2/2TFE3l/uEYmjL7i1fAGgPx+Vh05REkYF/N8aS0Dxkp2uaG92U97Dg5Ac2F5S4lYZN5FNoV+i2q+/5dbNbdKjAXGliHx3MwiblvVT6q23NfjhamqYxJuX0cXO6hP7hbBLKnFmGe7PWTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwU6O+Yh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47114a40161so8261775e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760632586; x=1761237386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iudVjJpy0o1qbrH2KXL6hDXBUJ+8wFir9fAarOxkEk=;
        b=KwU6O+YhrBIAwRHCp27ktNITvPnkvTrRrgD68Ih8qXzO9MZ6SQgzPdVbqE+DhTrxNR
         nlOw850giqRSf1Z0JG2Hqn1yz+gsYwywmbYeUvMhrS/DnlJUJHtypk/VNYihwpIg16B5
         ameq2t4kj4JQ8LI56wIQ772vPTeQBCHOAy+7vXsGeyMNaZOc06F2FM5Plxh6H676TzPg
         JAgJHki4s81CbNhMla0/4W/2ZTdMd4ZcsCDa/PftuJKfz0GubwABezglI1pfGSOXeZTa
         WbliN7BxRNpA6uA43nOKQ42hDMInvIa0dnsEm1DZ752cnIY4YnP9c/cqgTzmTn2WTbpD
         fZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760632586; x=1761237386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iudVjJpy0o1qbrH2KXL6hDXBUJ+8wFir9fAarOxkEk=;
        b=AbEJHRXTrwomJBLUhZSaz8x13aCsEdEtbxZV6cXXeecypA4S96aexe8pcOlO9bE9AR
         OO9uni6QiWsIxod1RPp0JiZK0muQfR71kmTfCgk8T5XM+SUa8XzyqSvmh4CRlxT471sL
         U5ps3uCIZiud5pEvRtsPIkMXkbjS/AaN2BmpOB/KUuGP6oyoSjeH2zTLSnJH+gGfDDIL
         HZY8L6T70a/rSv7W3LfQrDdM0JEwc50rADZPNIdZjRPiAluvIHkZ09Eqz8UDSY7HYb5R
         r0snpNFXSynArmD24tBhjeCbpjcNZPMbr1BDjp5y3o9p+EHRVDCMqoyn4ssZhzFmJMk2
         ih4w==
X-Forwarded-Encrypted: i=1; AJvYcCWC1FYi0KyGkdZ4OO1UicnjpmRLOLEldqYIBa4ETdyRjVS0sA/67QeJfuUWaNRHZ580ueoaXqT3ShAS5VM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+1QEXkA5rVHxdsBdkRZk3ICJc0NmPIwI1IPsz5+QtCk5mfMU3
	Wo5Zhn9F/Vc6tCVMDAUo4zLPdMiY4sQTFku6Dov5CbpFtukas2Ttdd6o
X-Gm-Gg: ASbGncsONhsjNLxBzsZAHIThHi0mEEUbNtUT2h48rqvE4xl/0RZ6EXIfYo7rAepfr5+
	FDs+mlxYJ4PtvylXzelPsZ2RcjPkhery9DtCLATwvbOcTCHvUCxplkkN0ZQbgRPpV/1c89utMBA
	v//AyTWhcTSseIKMAbJXjAio3H8GDWkn0KYkPSrBDTHDxqlHFOOC+2sBBR0hL9xzPC1lbdDc9P8
	Y/DY+ny7q1RHIzXuNzpeaDhBuUPHc1URkCKo9yPPVBdGM8j8Yet8Gt84XfxKCzvocsAGdA0kXMD
	nWKtSyfzGDDnbd5rvlXtCZqcziV/zlkEVGlXIrFFPhvJQba/j6nHlSgVOl/tkkxFITjfYqZ+o/6
	lWT8M/zIgN3SxEaIjUwfAJwJvHPt3kMg0lelr3B8/ecweP5KzimCRUSotTVW7Hkz/HrDkgSA24v
	sX+2jVY8i57q7D6k7prDNlbcPl
X-Google-Smtp-Source: AGHT+IExtADAqu4uX1pzMIJkBxPq+LfqHR/0r27r2uz36uYKe2cyn2W6w1F9x0DZ69c3Zjnu/ghXbQ==
X-Received: by 2002:a05:600c:34d1:b0:46e:394b:4991 with SMTP id 5b1f17b1804b1-47117876f30mr4328605e9.11.1760632585339;
        Thu, 16 Oct 2025 09:36:25 -0700 (PDT)
Received: from dev-linux.homserver.local ([51.154.248.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114444b06sm38388325e9.12.2025.10.16.09.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 09:36:24 -0700 (PDT)
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Michael Buesch <m@bues.ch>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6] gpio: bt8xx: use generic power management
Date: Thu, 16 Oct 2025 16:36:13 +0000
Message-ID: <20251016163618.1355923-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013174319.GA847155@bhelgaas>
References: <20251013174319.GA847155@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to the generic PCI power management framework and remove legacy
callbacks like .suspend() and .resume(). With the generic framework, the
standard PCI related work like:
	- pci_save/restore_state()
	- pci_enable/disable_device()
	- pci_set_power_state()
is handled by the PCI core and this driver should implement only gpio-bt8xx
specific operations in its respective callback functions.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/gpio/gpio-bt8xx.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-bt8xx.c b/drivers/gpio/gpio-bt8xx.c
index 05401da03ca3..324eeb77dbd5 100644
--- a/drivers/gpio/gpio-bt8xx.c
+++ b/drivers/gpio/gpio-bt8xx.c
@@ -52,10 +52,8 @@ struct bt8xxgpio {
 	struct pci_dev *pdev;
 	struct gpio_chip gpio;
 
-#ifdef CONFIG_PM
 	u32 saved_outen;
 	u32 saved_data;
-#endif
 };
 
 #define bgwrite(dat, adr)	writel((dat), bg->mmio+(adr))
@@ -224,9 +222,10 @@ static void bt8xxgpio_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
-#ifdef CONFIG_PM
-static int bt8xxgpio_suspend(struct pci_dev *pdev, pm_message_t state)
+
+static int bt8xxgpio_suspend(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct bt8xxgpio *bg = pci_get_drvdata(pdev);
 
 	scoped_guard(spinlock_irqsave, &bg->lock) {
@@ -238,23 +237,13 @@ static int bt8xxgpio_suspend(struct pci_dev *pdev, pm_message_t state)
 		bgwrite(0x0, BT848_GPIO_OUT_EN);
 	}
 
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-
 	return 0;
 }
 
-static int bt8xxgpio_resume(struct pci_dev *pdev)
+static int bt8xxgpio_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct bt8xxgpio *bg = pci_get_drvdata(pdev);
-	int err;
-
-	pci_set_power_state(pdev, PCI_D0);
-	err = pci_enable_device(pdev);
-	if (err)
-		return err;
-	pci_restore_state(pdev);
 
 	guard(spinlock_irqsave)(&bg->lock);
 
@@ -267,10 +256,8 @@ static int bt8xxgpio_resume(struct pci_dev *pdev)
 
 	return 0;
 }
-#else
-#define bt8xxgpio_suspend NULL
-#define bt8xxgpio_resume NULL
-#endif /* CONFIG_PM */
+
+static DEFINE_SIMPLE_DEV_PM_OPS(bt8xxgpio_pm_ops, bt8xxgpio_suspend, bt8xxgpio_resume);
 
 static const struct pci_device_id bt8xxgpio_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_BROOKTREE, PCI_DEVICE_ID_BT848) },
@@ -286,8 +273,7 @@ static struct pci_driver bt8xxgpio_pci_driver = {
 	.id_table	= bt8xxgpio_pci_tbl,
 	.probe		= bt8xxgpio_probe,
 	.remove		= bt8xxgpio_remove,
-	.suspend	= bt8xxgpio_suspend,
-	.resume		= bt8xxgpio_resume,
+	.driver.pm	= &bt8xxgpio_pm_ops,
 };
 
 module_pci_driver(bt8xxgpio_pci_driver);
-- 
2.51.0


