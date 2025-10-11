Return-Path: <linux-kernel+bounces-849176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFEEBCF57B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EBE406C7B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216862797A1;
	Sat, 11 Oct 2025 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFvouBAU"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392B7277CA5
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760187517; cv=none; b=rQOBGz4DYuNx1fMxkWVjJHTP5f67cBxb9kXvuX27tkXCoqcQtSvWPoBVF6F5UCE4g4FJwyvh661OLBDpSjiCLM2p/i7g2aY/k7fUpGicO2FNJ/LSNz+IyDPP6x/h7wepOKz3wPvNsDQrFf9XTm9ZJuhJ83BCeQoUyKsIqgwFb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760187517; c=relaxed/simple;
	bh=BflumSUt1Df+Pt4sylcVPf1fNVvDZusLNi5LKPKa6gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c56RZ+WAjlvPYOh6lOnhtR9XCZjJCbvQwOwrea2zB4dIY0qLQ5XB59iRRdbMo/vvKmC0orkCOuA67O66goo5n8/oXVnWPyFBrKMlBeEDOFYqkwdo7RMDB94nU8IYmxl/VD7Tg9O8PhDhE/Pa63s5WKMneRVrUVJWrRUc7nkynow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFvouBAU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so28191845e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760187509; x=1760792309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PP2cVBqxTHo4iOzKU9RsvBFv1wvTlNYcCHBA/GUcdj0=;
        b=kFvouBAURiOb52ypVkX3Qw2tC9MgKYxQGA1Ie6iZXb/WdMxU0/Sxv2+E1JpXuu/ocA
         wz8NldianPzBkmtcCSFAB5rpC+QqCkZDgMjiBHM9k526BtPsxUcl4Ar/sMrOJ/rjjyB1
         0uEL2EE3cJFs2SNQHm5w6EG4SlZIi77K6UNsNrYSb35p53R7kOcLEXxj0flIxfJbK/mp
         prX+ZyGpmPjt+xpWhG7LNdp/DnknQ9ZeohJrbbXjSPBLQocxvgAVylCP3TIBt7RatT56
         bE68RMMkIqs4a70ibQoDuMchyAR529aLrZSLOOiEtLw0lIbvsPAme9zPPa6lrV0FpisH
         UJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760187509; x=1760792309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PP2cVBqxTHo4iOzKU9RsvBFv1wvTlNYcCHBA/GUcdj0=;
        b=szqdGoV9pQBvnUNiDBZGQTvVvjA2lf0SQ8pmtB1gsgD8Sd0JPBEhpXLyA67372tEo2
         tAveE2tIGrwmjqyBZEFSrvxo2wUJms1yEhlbD9+zIZYsR3/YXv0ezXDi1axJY6fvc95+
         1bqAYb5CODKCK6DN+EqedALtafY79ZZOX2RYFmi/pHjEmmK7uHUdnlC7OWxKgHvSGx+3
         kxrqls9AjkRJQbIFm7SDoWMySY+/qiB37+SkZm2D1ZCCTXTm9xUAG093YHW52xgKWSSB
         eZwuiM6o95Azb09Kqml256jcOxjo3+8qnpFj25UHWNzclciXIULs5k/u9F+lZ/n8YvKZ
         c9Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVXdiOf9CIzypnB0Fl4EG46bX9DTf0Yen01eKFjxHxJpEMpMron1yH1VuMtJ1YAyffsjUgMKqMraFZQAH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsjcixAbBxL1LGYavRV7cGwe0b6N1apY/m/SPa5zzNaLg8o3w8
	deUImN7977shdpgMaDRN9sTveaidHVWwX/UNQd+vnEneLiSsvmM0m92b
X-Gm-Gg: ASbGnctsq3Ay6eo0uEs5unDmMgSVAsGhqc+1d8SL+k3PvQREf2WW6EUWzGtKBOgIOIm
	7G0/b2D2ROyJ9u78ImCEi2wib40HvMC2FhSfoji6V5HQ1/6LZF2YbPdwgGOGLAnYiDnFXnxZ6fl
	m+u0Z4whHzPpgLJS1HfxFb9+2wYE5q4S8BA0HTKAjyEAPcmJPMbPZQkXs+n6H808cD4iw+ndGvH
	HfZkuwr37CMr7nbWulMKxAPcM/He5voGVPBpXayIo877L9SodiGCoXBgPzoFDH1IXKWsvAc71DD
	81IU/hdKXLAhKY9vcaf7aYDJP27nAE/pWXJCYeXQqsmrdb4fIQqXbrMzQ9CJEBVTadYLmmpI4kc
	46rRTPdrQ7LrgwoxbNvGDOqpiiQALLwlDa+wxcVGgkCoxm9YUseXG81MAj8OGvYM+iA==
X-Google-Smtp-Source: AGHT+IFypDFEfHT4k6jCPST2r0F14x52GIJv5i+x39HBd4euooCKsMtk4pEX4/z7HuGjqI5IAYoavA==
X-Received: by 2002:a05:600c:4e47:b0:46e:652e:16a1 with SMTP id 5b1f17b1804b1-46fa9a8b482mr104336315e9.7.1760187509283;
        Sat, 11 Oct 2025 05:58:29 -0700 (PDT)
Received: from dev-linux.homserver.local ([51.154.250.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb4982c10sm89708785e9.5.2025.10.11.05.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 05:58:28 -0700 (PDT)
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Michael Buesch <m@bues.ch>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] driver: gpio-bt8xx: use generic PCI PM
Date: Sat, 11 Oct 2025 12:57:53 +0000
Message-ID: <20251011125802.1068043-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251011143123.094043ed@barney>
References: <20251011143123.094043ed@barney>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to the new generic PCI power management framework and remove legacy
callbacks like .suspend() and .resume(). With the generic framework, the
standard PCI related work like:
	- pci_save/restore_state()
	- pci_enable/disable_device()
	- pci_set_power_state()
is handled by the PCI core and this driver should implement only gpio-bt8xx
specific operations in its respective callback functions.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/gpio/gpio-bt8xx.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-bt8xx.c b/drivers/gpio/gpio-bt8xx.c
index 05401da03ca3..70b49c385b43 100644
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
@@ -224,9 +222,9 @@ static void bt8xxgpio_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
-#ifdef CONFIG_PM
-static int bt8xxgpio_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused bt8xxgpio_suspend(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct bt8xxgpio *bg = pci_get_drvdata(pdev);
 
 	scoped_guard(spinlock_irqsave, &bg->lock) {
@@ -238,23 +236,13 @@ static int bt8xxgpio_suspend(struct pci_dev *pdev, pm_message_t state)
 		bgwrite(0x0, BT848_GPIO_OUT_EN);
 	}
 
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-
 	return 0;
 }
 
-static int bt8xxgpio_resume(struct pci_dev *pdev)
+static int __maybe_unused bt8xxgpio_resume(struct device *dev)
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
 
@@ -267,10 +255,8 @@ static int bt8xxgpio_resume(struct pci_dev *pdev)
 
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
@@ -286,8 +272,7 @@ static struct pci_driver bt8xxgpio_pci_driver = {
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


