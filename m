Return-Path: <linux-kernel+bounces-849170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB93EBCF55A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 017814EAA43
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050B827A108;
	Sat, 11 Oct 2025 12:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB6qm6Gw"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0B02797A4
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760186001; cv=none; b=bGgr2xqCDhJLiU0rCzO7KxgdmRIMpsutAHmqE5O1umWPYwitoQeS1iBd9j6C8uGy5xrvsECRT0DA2ZrwyGALfw+kkNdn4ZAnqXHXdbxtdwwtV51QI48QcTApr1WtWHCMgr/uXd2SrcvlQl/zIXoy+BBFbOhguTk2bccIO1AUNVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760186001; c=relaxed/simple;
	bh=inpeUlDIBoRDsXH4TWsQq1ZiqQ0DV7XEi0orKaHbBcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYFbYu9E8/IpXazrE0iFA6ChEW0uVBDfPZb9Yb1dNm3V8Gkxtdb6xUHuHH1Ntstn/WH5x3+XdR6a5zZsiqumkdnwMkPoUUBvgZqWgJbIkKi1giXJW06XwjTvXlEwswaUfAQFJcot/67PTjKqmAHB/xXOFzGndZBk1hqIymzIvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB6qm6Gw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso2082396f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 05:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760185994; x=1760790794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XT+sfDtLz6tUydrBZl+jOOWRVg4NxjB6zZlMkt2w9NI=;
        b=EB6qm6Gw0uqMS8zZnz+xXCVvf/ljCpIO3Dd6CFaMQEVq3iA0uuwqwM2YzfKWXmzRMZ
         wx+aqDze5s+EqMP9D0AUFdpcP764pxv6vt6mQeA0ehbYUBmR2Ve6drqEN6gqxF1jSzLZ
         B7y3q/fFyPRCB87600wB9h7avt5b6NkM8oJFjv4AmDqGkRFbq78oSWNRl5Wv/1HI1LNF
         9lPQr1VmrN4RwDpLQAW0wiNWsK/Zwtxp6/BjbZK+Xh1u2XI5p64An+2M12YahqqRmHii
         LUCvTTJzx6CGNezD+eK4n/5f9nLk+GOzrzHUAYWfXdq8z6TFA2WufV1TBczX+wk4XYbe
         x/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760185994; x=1760790794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XT+sfDtLz6tUydrBZl+jOOWRVg4NxjB6zZlMkt2w9NI=;
        b=ld7ECDmGvPW2yUPzQOtfP6xAKkOMoYqP3mM5diAanE98d6JIW0nfrLU8P2wLzSlGK3
         ebClRvPMyxFt89auF+5qTc8X+LJ7d2ovGs6QIT37VcIagDFBBm/duehDspN9OEvy54Ne
         4yvJgadBdbfnU0FFOUB6qkIiMSXDhMzHa1RPIJGLl/hrLQCWK98TI0JLL8AEInYl3G1n
         nnB0ey1SOGQHbqBgqDxo25okg9HEq6xdWIC+hVOsgGuOiUwQO+p5XfJWMxJ0zT4bZEhL
         lKKaqAWde4FNV2372qKXoZE/eHr8FJjzS+BXrpZWxwmsq/fCZWalKaqDKQoCbxIMRMBn
         gp3g==
X-Forwarded-Encrypted: i=1; AJvYcCXkrkCk+RfivVHECzSJzsBr5IDeQTz5ghl5uBQV/1G841G+OFj2fWy/do7BncxPHhF9dWpQA3c97sWxchQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4zS0p3UybnW70dq7BpgXJYr5Wocls2U7acWmtPBIk7RR0Wa2k
	0kDJLptltwRfThIV12z3KfhmSGe9LRnPZ2H+FZaxSG9xmRLCfom4TMCv
X-Gm-Gg: ASbGnct+gHw6q0bxrjIuAvxTh/k89fdDGbaAi1ERgZwTRHqN3UHVXGEI9PbTHO6c0vv
	WM9tG+DaAvCv+wEUmPh3Ykc8g1XQ/vnaQIldN5yYD9jg47/Kj7eh904VYEGmxLcQ2jaTqWUfK2N
	CRnhjOsQnEdFy3t15J0swLOUTuPMMK6jINGMECPSo80JmajGsKN8v8R39qQwLiWq87CGZfvgMyT
	5hiSTwGHGIgu3sOzUBbwpYhWdRavjutRrtLZjKOp3LWtNB2JFQTtRg193qDt/bFmQ0aEDqIO1GV
	9aEQjeYcJp6YNqCxpGNpmx2nAnmtyQEQRuDQy3CvDnytGx5LTj/3w55wvjzHxfR6f1E4/HeZrXq
	EMeUnNAR1Cb1xU9wJrY0MibayLk/owMzFQ5ifFTyxVICo4P4wBIy7ASrShgzT894IfoDQkTPkGd
	0=
X-Google-Smtp-Source: AGHT+IHE2SRuEzQw4sc4Yl2CYwfqXb0UrJgOEdW86pIPB8j/ijEO5Oa4pbqJpp3vGjyIFlUVvnBeng==
X-Received: by 2002:a05:6000:2408:b0:414:6fe6:8fbd with SMTP id ffacd0b85a97d-4266e8de55dmr9541053f8f.54.1760185994096;
        Sat, 11 Oct 2025 05:33:14 -0700 (PDT)
Received: from dev-linux.homserver.local ([51.154.249.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce589b3dsm9001601f8f.24.2025.10.11.05.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 05:33:13 -0700 (PDT)
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: Michael Buesch <m@bues.ch>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] driver: gpio-bt8xx: use generic PCI PM
Date: Sat, 11 Oct 2025 12:32:37 +0000
Message-ID: <20251011123303.1060490-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: aOpAO7j0Uyo6FPcu@gmail.com
References: <aOpAO7j0Uyo6FPcu@gmail.com>
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
index 05401da03ca3..451ec38c350d 100644
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
+static SIMPLE_DEV_PM_OPS(bt8xxgpio_pm_ops, bt8xxgpio_suspend, bt8xxgpio_resume);
 
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


