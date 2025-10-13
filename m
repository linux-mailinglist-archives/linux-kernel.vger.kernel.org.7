Return-Path: <linux-kernel+bounces-850956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB18EBD4CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60A38350AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838372BE7BA;
	Mon, 13 Oct 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyJly32o"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45792356D9
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370791; cv=none; b=maPlUryNpnf3BOz+8RWQiij+4DuKtb8mHD63yV0/2lmPwunjPpqKpKY4UJY6T+1xD1FrE1RPAZ14UrdeU9Kc7i8WbtTz/HV0EWvxwPgukxaGmRcTW1DuWfMQXE6tAKXYib3hj/5N/sC2R3cQsnl5yKBt1HPV8Uksb/JBqwXCWUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370791; c=relaxed/simple;
	bh=BflumSUt1Df+Pt4sylcVPf1fNVvDZusLNi5LKPKa6gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBc5C0WzM+fWCRGxRke268vSdzv9qdrJMHzGUlXHcHBWkBz1B9zbqL4Ui2twRQAnmjgqE5u96B7cnyeHH/G0LB9nSBab7UmXejv8HaO1T7BnL9OusHZvwy7Q5B/GMysNMKoVAXFMSrwRff0SZ3DaR9l0PGF7elHM9d7ESE9LndU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyJly32o; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so31478735e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760370787; x=1760975587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PP2cVBqxTHo4iOzKU9RsvBFv1wvTlNYcCHBA/GUcdj0=;
        b=JyJly32o1i/q8U1xL0tYQMjGOrK+w7YaLi3Zm5Q4/+4P/dLwIlkB95dvJYCWN8nuXS
         mMlJ8CjqCjf6978NhCk6m/+XhFYqbXJSjqsSUUuXJXuxs5pn0yIbZdLErI5ncTEdo0S2
         LDCCp9dVST1izojwVB31TtmIQTEl4aSSsLwrjy75hlrI2JtvAZgsWHUjEew5Uf08yiVH
         QBw7Nnv0zUpxZrlRrhY+TMbOpf1E5QucF3M6qfBVN1LssfbhRc5knDil/x83FQ8xje1m
         GZzJzDitcYDChNErPqGTKpBC+09wTNNFHlMFM8f0ueZY6KUyKKKYJ77c2dFLzTWbKpKL
         mvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760370787; x=1760975587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PP2cVBqxTHo4iOzKU9RsvBFv1wvTlNYcCHBA/GUcdj0=;
        b=gjGTIJXz7PYR+4O5p7sgbV3rU/+d444CmJXiHk2UFI4qXHbNx930sUkdWMleIeoBL/
         Lo9PURhpq+BW1AJSz7/893lTqTgUfPIMCPuQgBJLsUiOAt+RhcanReTIxLkzBsbVKj66
         lV0FYMA32U15CdwYqoA2fSBSN84BOfvQp4O5KYflumNNywp3XJk1BHtGvz94+pV8A14C
         dnS3opgaH6ULkGaDC/SBmTp4TnTP0Oj80y8jwt+a9iyucST3zzcDqkDCC5A6vleUOzKe
         6CstaO1rZJOGBVcbR5txUh2Eex8PiZOKJ0bcDSpXJizDpjoHXx43ProseyT/EN4f40/3
         5g2g==
X-Forwarded-Encrypted: i=1; AJvYcCV05Av7pdVEDeTU6cZIUWjN5Dhnebq2n/uO7JZwr1gYNFlqVj5C2nDCWx0CLdw48n8fERGfWGUIukHgYmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoTogHYNV2nrRbPibOUNNK2ICMcb0RTcMjLnT4yY/Y/QGdPRi4
	0ZhC2YFPLGg6mGu6/CH9U+OhmhQjgYOcF8/3ZNDUtfpbr4beIRJLdzfI
X-Gm-Gg: ASbGncu757I+P60c6m2HvZPwFfif4iMZDkfRF/jNPlG1i2LpstO8H9+AdXTvnQjL78r
	Ad514o2yqdX7x2BpR9hYPBTWqQPfepldjemWOQsZBpvTwt00Dz4tdPhkajpvyosKzgthZXs+kp+
	9Ff0du+vWHe0VcGIAD0Jhn3bp66UC2OrCPzpH896Aw5hl2S8FebS7PZT9zPs9964CONgXnK7Ojh
	Tx6xf9WvukjzAz1EhxkpoUmRXHAHOJtDq0B9g4d3bQGyvK1OJDyHjo+8hQGsYBrIKtLvIqB7YEY
	QJMgxIqvvZxjIGQ9JkVEAN+BJHvC5NLskcOKnm6U8wyM6Y7rjxYW5ZWoXfztCuC+ss5iuHc5OLe
	rNQKBR5UZmIxA5dU2Uq8RrW7cFLB1WcDwKrG0m7T030LVVh/cWU6/wECSY1Es2/AuYQ==
X-Google-Smtp-Source: AGHT+IE2KvAyvfDcxqJ1Dsul6D4no3ioGcQdOMcLp37PQsjQ8g+ED7dk+ijfPAnXos4qSiImjsr++w==
X-Received: by 2002:a05:600c:34c5:b0:46e:4ac4:b7b8 with SMTP id 5b1f17b1804b1-46fa9b05361mr144494215e9.25.1760370786927;
        Mon, 13 Oct 2025 08:53:06 -0700 (PDT)
Received: from dev-linux.homserver.local ([51.154.249.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb497af18sm192097675e9.3.2025.10.13.08.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:53:06 -0700 (PDT)
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Michael Buesch <m@bues.ch>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] gpio: bt8xx: use generic PCI PM
Date: Mon, 13 Oct 2025 15:52:59 +0000
Message-ID: <20251013155303.1103235-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aO0f62-RnVyKRLS-@gmail.com>
References: <aO0f62-RnVyKRLS-@gmail.com>
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


