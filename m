Return-Path: <linux-kernel+bounces-848136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E356BCC9DB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDFDF4E953C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB602820B7;
	Fri, 10 Oct 2025 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcQnON2P"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03042853EF
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760093628; cv=none; b=ceqNmQfA+0GNXdXs1ua9ac8ecISI2rnv0WQPhe6Q1x6Jq2JsQEV1e+P4MTU+/Oby+zsV2dU/XICQmtqaAIX0DziYHTA0hRostJv8c9nppN009tCMUWGzSzo6r6kKBUIFBPTiZPTpTgGC/ORgHAy/HxUX6obcJn/cIrTun2RfzhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760093628; c=relaxed/simple;
	bh=VT/Q5/cCmXGEVaIxL9EqS7cO15NmL2PHqm+oFXUO1ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VqbS9L2H0yhspiM+XnOYjJsigihXSwn/6A2hTvP2qjChJ2iWyl8RS28pz3ijLSv+A1mq42XDCFMISucW62Uz4/LntQBtetm3+oy3qcZ60iWqVWsfYZUs8mQ6f8snhSafDtQTbZt6j6jDdm71QlNk6agOZM0Bz+14Th2Y49KEEDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcQnON2P; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so10493505e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760093625; x=1760698425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQZwgbH1uwfwr12Wrdw5CZ0PuDM7xPtb6/PYbm7MoVs=;
        b=IcQnON2Pv/7h8pX8+iwJTopoE4W7Wb63+hBbuaX+Fvxpdr6ldITje7VyXBl1fxRaTj
         rv1Y9yxMTTyBtbtSQCOD6OTqf3i7rFIvwyH79GjdTA9g1TMrh7MtKYNUwnVsty9HTNyH
         mk5vE6FLBA35lLOdWlIb4J4e2RLg8fBSPBsmkNddTG+N+pwoteM4NEdwrpK4nRn/8l1t
         y5XZqfojBDpaMgTiBZpe1jexCL8cMEpvQlm7mt20xSOrVnumrfHNiExWBnZDtM1LpFMH
         orfj4AC5IcD63FMAUmvefs8qB+4hW97Kjj9js+Xxax/SUYvzDeTne83crUrc0Wdn7Gp2
         qLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760093625; x=1760698425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQZwgbH1uwfwr12Wrdw5CZ0PuDM7xPtb6/PYbm7MoVs=;
        b=QrkCAgqDGSnVagpQ6oLB82D6IUGmtarXWyYiw2ASCD8NQ0p7BXe/pajxyl6r3B8Wp2
         pfTtVbI9a5kjMlHM8w+JeG63O2ExCdJzdeZ1iAmFJJKdjZ95grvMgK8zblZuRf1cqlhe
         jmtyoyojNxmVGbZhleWDq8x+elDKCA93yacwo/yy4xF42VsdQ0i0ANMedE7oSRhHWcsO
         tlYowS1eo8ZmaOyDRanWxIQeOH6bOWyGprvcVjSxMaTU2KVh/RJ4lwCuQh99yUr5Yarl
         4jVGWAwZyUMqmvk4cAszujh4K5Tsiz3OkUENgMB5W7h0/L3BdscWqmTm4cofW9yaX1ml
         rz+w==
X-Forwarded-Encrypted: i=1; AJvYcCUrWohhN9vFBJ7hx2h00U3Iy8c/ryOVcNxMTFgsgLgMRrQO2b40+Vma+qvzhVCC+/Cz46ouLeN2TZkDydY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDUzOmFQT82XM8i8t+fMG5fHAgGejVqN4ydsboNE5eaxbPCWt7
	D8bZWhIVoXQwQdZc7hTZc8WOg+xJouLBdBvRIDT4Ie++B9HTNyPe72Ym
X-Gm-Gg: ASbGncuT5znuVAZApzoQrqHW7kG1kIbdomZ4NlU9HN6tpg4vW05pt8AFEpuwTqDv/xz
	t4e4JcbLTwYCZc74xNR2fmpk2JJp47a5uXL8Lm+Z59KsZCXelzTFfzOHv+Du+aP7/8q+xpswvyz
	hVYfLck1g+ain1j5xvpe2rRP9fGaftjRSPtlNY+6lnKSlx5ka++PvvoYRR9ecpmFfj4BtU8gJE5
	bvby6zLWxcE6bDPRgAa5E02YUGGWIsRbLyyt9accz3BkXYRySWiqcd83lF05stO+BDkZrpqEJqy
	hVmIw70olSz/YCtipK+WcTrBKpc8CkF8NAcMo4y5VD50t/Ht1AWUhuFqb2sZXgJrqhiDQwTBhYl
	NhNGZEmI0ocPVV9fqXMuZaHDYXEEbZSEoAkT4/VsXJwx3fgWxIfULbYQ+5zIbRSImcuRADptbop
	9c
X-Google-Smtp-Source: AGHT+IHH9F92BAY1gGu4HHJ/SnpYJZAdB9b4ua0sHAT9WkHef3NzVZbZ9ZaAZaZ2EeenNmAWf8+TCw==
X-Received: by 2002:a05:600c:c4a8:b0:46e:4921:9443 with SMTP id 5b1f17b1804b1-46fa9b1b277mr76411355e9.37.1760093624587;
        Fri, 10 Oct 2025 03:53:44 -0700 (PDT)
Received: from dev-linux.homserver.local ([51.154.249.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb4983053sm38889925e9.8.2025.10.10.03.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:53:44 -0700 (PDT)
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Michael Buesch <m@bues.ch>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] driver: gpio-bt8xx: use generic PCI PM
Date: Fri, 10 Oct 2025 10:53:36 +0000
Message-ID: <20251010105338.664564-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.51.0
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
 drivers/gpio/gpio-bt8xx.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-bt8xx.c b/drivers/gpio/gpio-bt8xx.c
index 05401da03ca3..e8d0c67bb618 100644
--- a/drivers/gpio/gpio-bt8xx.c
+++ b/drivers/gpio/gpio-bt8xx.c
@@ -224,9 +224,9 @@ static void bt8xxgpio_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
-#ifdef CONFIG_PM
-static int bt8xxgpio_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused bt8xxgpio_suspend(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct bt8xxgpio *bg = pci_get_drvdata(pdev);
 
 	scoped_guard(spinlock_irqsave, &bg->lock) {
@@ -238,23 +238,13 @@ static int bt8xxgpio_suspend(struct pci_dev *pdev, pm_message_t state)
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
 
@@ -267,10 +257,8 @@ static int bt8xxgpio_resume(struct pci_dev *pdev)
 
 	return 0;
 }
-#else
-#define bt8xxgpio_suspend NULL
-#define bt8xxgpio_resume NULL
-#endif /* CONFIG_PM */
+
+static SIMPLE_DEV_PM_OPS(bt8xxgpio_pm_ops, bt8xxgpio_suspend, bt8xxgpio_resume);
 
 static const struct pci_device_id bt8xxgpio_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_BROOKTREE, PCI_DEVICE_ID_BT848) },
@@ -286,8 +274,7 @@ static struct pci_driver bt8xxgpio_pci_driver = {
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


