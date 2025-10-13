Return-Path: <linux-kernel+bounces-850408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6421CBD2B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25AA14F0C32
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E843305979;
	Mon, 13 Oct 2025 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyI75/QJ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A738E2571B0
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353522; cv=none; b=nAt0K6FFg+dFYQjsnOljuYtRalmm9U3JSt1Fxs7rtK1RBbAcWlyY+ajMH54YNDXSmIfLeadMlyTxkZknpFPBzm5pp9yNboJnEEyjr6Rnb7btLmZLhceMgO3dBgQzxfEsAlC8AWC8bBHeLAALvgMmGIJCIFwDxbYP/XhxJwD5r9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353522; c=relaxed/simple;
	bh=BflumSUt1Df+Pt4sylcVPf1fNVvDZusLNi5LKPKa6gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkLN1foLNZIvWYwHoolMntERLIgN/fC6ox54wzqrIdK1hpyoHHG/eq0L+ZO2zC3hRXjQUJAu4QP0Sm8yDo3KQI5UKD3S/oPpuREXMYkMzEF7h1FfpB7IdJ8qdAlvO09o4wU1fL+BgwIGSPDPGM8wYpSLepwoz1UdaIZ8iu6hYuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyI75/QJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46b303f7469so25811155e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760353519; x=1760958319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PP2cVBqxTHo4iOzKU9RsvBFv1wvTlNYcCHBA/GUcdj0=;
        b=WyI75/QJORXj+PljTm1LAPAXnflSYkqDi9YjIIfwP4GL2Fpc0MA/9UmiHJAWMh+wSR
         ouh4Ax+THJIF5uip92GwFq8wPXfPba92WOlCZvL0ShAf9RjslKaKFn6TzITQz1xKamCs
         4rgMZm8/dL7+PSIcZX8iG4TxAgvnMvP3GlHulUA3zwrgog8g4poPiE8tiTMPY42M5CY9
         dqxUr79b3zwvbJ2DtQNCiCTZUv11sf+tFrijVtaksrFhzVjOiqTHbWMSs/rsaIm5Papc
         DMMjHXXLBakhugZDm0CW9JPokPxI3un+57PR1Cb0KxXvTxO7fo+ukN4ICqTPpVXXkFL0
         lg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760353519; x=1760958319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PP2cVBqxTHo4iOzKU9RsvBFv1wvTlNYcCHBA/GUcdj0=;
        b=LiJjhdNHQSz5cN2QwuZ5s0lQuThQjIQhJQFg/Ee8B6deitqny5aJ36YgNRJvL3c7PK
         v33m27499MIvqFDiPxR8c60n5F3k+52xKE9p80DUsAiwroD/ndYZBQ6iL2s945Qjggsi
         EFZDCXW13VODutR/ENC9cAOU7T6aopAPhiS9wB1EUigS8ZYoImV0tjRnZnAsLXp0tjgC
         GMqH7gIl+9FPQ4wOq4BHkDIX8GGnD3Q9InEaSMuZJjZ0kqN5rHR3Fd+LALi8CWrDAKYi
         1IjxDJKzNAT6cbpq/1nTQuICQMoc/dQXmPn6pty+sKcZjrIU1FvUh1RJvp52V4Tx+U3S
         Bx2g==
X-Forwarded-Encrypted: i=1; AJvYcCUD/3QYkFwL8S1elt9OkyMUmmT0zw9zSLVa0mxbq4EgDpi0OyWgEWg0tPHKgvVujmeaCqUvXS1McdnL9EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNG54k3lZMW9wGM+4z95RJCbnqssmDsqQCe71bVDYM6xA7PgGV
	+JBR98RsZk1A6tcM0BrTmEZd8GVo8HmhQNZ1g+HwjvHm/rfdNi2SUIRM
X-Gm-Gg: ASbGncuMyqC8X/6tpyCqzb/fw1OnJVF4AJfUuQRvL13X9owrn6oQGYGpWvh6fILLLfE
	t+LFa+fHKw37qbEzsVpfjbKj5V3zrZua2Iw2NbMYC8K9KNoE+QtN+VqNFAiKP7EEtt7SYl8XfNy
	2hgrQ+lXaCBaoUnpIhEftm0oe10FB3MsXSKag7rNpRkruDZDi3lFndDBo1VJZxcHWAPbHbLoL9M
	Chu4omdDkQfspJgThN1H/6fMRCQGLwJAilN+GOFFmwIMDDwMrBaXGdCYuu4s/IzrN0qcuwxRtnQ
	UPj0EoZ4DR4DW7YuGe+9saSwcqPjUWx+JVwr/LIZdJiCHDjvROYTQUhP+wObPPmHNXeI/Nb3RTb
	fywY9vUvWeKohpIvTDbJSxFYTwgfnGxwJ8h4xIHeHyn0VmRRcWebQiC49MZbqPyzRk8y37pz4lU
	c=
X-Google-Smtp-Source: AGHT+IEoBhH6E0j/01oD5xqQvaGL0mqo94iCVU6OxELQ2mySLIzYNb7Weh0QwV7Qqq0AcoF2HMvrJg==
X-Received: by 2002:a05:600c:6304:b0:46f:b42e:e361 with SMTP id 5b1f17b1804b1-46fb42ee3camr85799275e9.41.1760353518647;
        Mon, 13 Oct 2025 04:05:18 -0700 (PDT)
Received: from dev-linux.homserver.local ([51.154.249.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489197dsm185442035e9.10.2025.10.13.04.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 04:05:18 -0700 (PDT)
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Michael Buesch <m@bues.ch>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] driver: gpio: bt8xx: use generic PCI PM
Date: Mon, 13 Oct 2025 11:04:50 +0000
Message-ID: <20251013110512.1089428-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251011125802.1068043-1-vaibhavgupta40@gmail.com>
References: <20251011125802.1068043-1-vaibhavgupta40@gmail.com>
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


