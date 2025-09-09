Return-Path: <linux-kernel+bounces-807680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA31B4A7B1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E077B6758
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88263310620;
	Tue,  9 Sep 2025 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nA9/lIsS"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB54430F935
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409371; cv=none; b=tIM9MOi/ioqVBlesB+ZGQcRys3BARQBOmakdJFOsEDxNdGs9nrVntoZKAEgHYnYKa4CJGSrsdmO8egXyOSoFtBWVs20eedXUeSFjCcoVJ9P5y+O61RD/EwuBFJyGXw3y/JrE//SklJ1qqhef4uvvDfHvDuLJfk4lhx1aYrVx2qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409371; c=relaxed/simple;
	bh=KDFwPnbkRvx0fTKChYEHU+W71Zlm+jzr4ejpjKKTNkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O4vBohh+YUMwiuS9IgugMQ42mgG+VzcEZIxRZcaT7T7vQ3QWYM6S7t6lzni5/J0/QS5HDe4akOqpKiG616wQBN9Mee3gB4A2DII38vk9OkG6426yFIHyNoPjdPpAJwoFTHY+o9SNxymNUkVdYRHybwyK353w38cDwPlRLoY/xPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nA9/lIsS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45ded619608so5130785e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757409368; x=1758014168; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMmaVn+LZJgn5b7c1rWtdZrF0XHWPwWhtZTr2dtFlt4=;
        b=nA9/lIsShanpPeuAhch96lazeOCjme8KqU/uAEi64KbjdLV8KATB3/wiyJU3A/rCZw
         /o8atZkA8RweFc4AFnvTezjsOYyS63TDVU7TH0j+Ov15kZd/p89NniJWb5wO+2bj6bm4
         bzhvXYATteqCzNY2wGK87YQkTLfsiteWhJGFLQ8mFGOjs3rvWVS2WbYxFaGiipxK9blq
         qDeFN6YUAuQ6GlJncvsDlrWf1Ig1IXXa3gDivmHfWRtdmTov9V9G4sWmegHUeX4MRyLt
         v4tOLsa+B7NmEyGe+2toSQ/y1mfRfTYA6MsSZ4E4H7v1B5GvOFghxggKzskkSLouMRMF
         8jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409368; x=1758014168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMmaVn+LZJgn5b7c1rWtdZrF0XHWPwWhtZTr2dtFlt4=;
        b=ebUKFAPJy3nMFyHQ5i412sVCYYGrdBRgGTP0BGgtfyPm8/P5+2fxzRugAOTvI7gzha
         tmokOKuRBcN0xtZzVRS8Ln8EtCmiuj++dRcUWBpr1Fpl801GpjUBZ6n22A9IBlGhyql3
         K50a859XQvGg/FnLFDLxK22nJvJz1m02Bb/65swV3v3swV1afTdufOBab/SVZyLrSLES
         G4TGqagYTvtP5Y7rakxdijNrE/DlWFWPHPxIuy7t5v6g/qIdEUasiqeoMJrkNOcU3BEl
         hrDB0QNayoyB3/EzCUDmoL847EexTE6Xu01wIQupsTZ6r/RuOYhIkiWE3F4fVkRPH8dn
         MjTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGnOy9AGyTnS8c1JMxo609DGoImQCL5vxWe6KnJ/dlu/QadQ3HJotnQYnN+F0epZXjsFEHxTMjQO1gNyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZALQHDPn6AsEonZINx13H8kJ0NLesF1ryT7INF9sgdEtkGOpP
	YEW/EVcOEP6EZyUZh/srf3wg+/y6AbkwY1HtmVW20Yc1cS7D6PIzOu4FHINo35yMaps=
X-Gm-Gg: ASbGncuQfsINl1XyhsZOYE9D+cpF1+IFEEHuZQEK8UkfjG8WtCFQU7aEhHxEkb4cH+M
	uvRZKfTpbk2M2ZDEm7zKzkZHZHF5Q+wmHHwjwSxMDDeJzbP4Me7EvdT/s130XS26/oCWh8Prx+/
	oAt9dzZeul6P8b9Qs8APpJwwy8pwzI+zIuVsOr6BdW/E1lhsu2Lx5TTvvcf5BXvya5rrUNe0ujp
	EZubrFQOaSxebcE5ymaqCaMSuMBoptUyjD0+teeBy2KsTEikaj+0+aUMaYgjzNnBqQ/7hwM8/IX
	7ofGCRCtNd4V0UK2Vz5TgYmBhKaC7mG/vINzWXqv9rVYOqzAmXnw56o5LJUdYEGicRZ5959+pFr
	QNmoV7EKd0/Bdh3riKQ==
X-Google-Smtp-Source: AGHT+IFmO6VqhZ9BkxEjJhWWUjTF6UtWEURBON8fvebih0GzMhUphDe9TftqByslO0IRvxtisIwrOw==
X-Received: by 2002:a05:600c:19ce:b0:45b:b05a:aeeb with SMTP id 5b1f17b1804b1-45dddec8ff1mr97136895e9.28.1757409367901;
        Tue, 09 Sep 2025 02:16:07 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c1ee:7be9:3ebb:6cc0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9caasm1900039f8f.19.2025.09.09.02.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:16:06 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 09 Sep 2025 11:15:40 +0200
Subject: [PATCH 13/15] gpio: sodaville: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-gpio-mmio-gpio-conv-part4-v1-13-9f723dc3524a@linaro.org>
References: <20250909-gpio-mmio-gpio-conv-part4-v1-0-9f723dc3524a@linaro.org>
In-Reply-To: <20250909-gpio-mmio-gpio-conv-part4-v1-0-9f723dc3524a@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Keguang Zhang <keguang.zhang@gmail.com>, Alban Bedel <albeu@free.fr>, 
 Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Samuel Holland <samuel.holland@sifive.com>, Yixun Lan <dlan@gentoo.org>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2177;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=OpZH1E4uX1rbCcdgDBOgsBrK0sLVF3+FQJb0MPT9Hmc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBov/A6p94D+S/c4LzuEPR6IThg0j1mZ/5T2G686
 meGifKdh+SJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaL/wOgAKCRARpy6gFHHX
 cvcmEADOfAiuC1Ep9RvIkJ+mqoo9WSMNXkDcTeYwBaiwwjIz0muCH85jNMqW9b3ZFhtBFSJuNtX
 arXg6eVDNEk4OcNWPJoc69s1QTJ9+jgvdXEqIvD/bmYCRDMpo+jQnl8UeLBhd7CBBEa45+1a68E
 M+d7xx0SBcN6nLNJqgO912DPu80/cw/gjXeHHbHoFmaCoklpIroAj2MEnMLoRluFVHoFaQ9d+8K
 Bu4Pzdqqu0HRLMJ1LAFhIF3VYoI+tpwPNIgT3E8/+5gmTzkcVW9Z+k/HLDTuKTyzC8lur0Ery/Y
 kT014qHXyE5TGEawY/IxfimrrtPXPu+wV2svkqUHpN3Pv7Qgph9GzQ8xluK3HnRV1tt1HUK/IMe
 f7j/0tewxNFyFeAGBlEua07W3bCnMCARotAno704aWDtPSIuP314GWm3T8z+l44QTe1F7vVVj/2
 8Q8vQYPB7OxkgxJv93dnJymPuJ1f4r/osq1nj6J8nngFzM2/Kc+UleQrCg+vmNpBSv4PTsApf16
 usJOj6hIKzfx05g/FzdSTDCqDptEEALnloKNJqBv1h8Y/qzjzei+M2XQmue1W5e8k7FqFuoP0zo
 AKlT5n8Ntxzdvl3e7GrObrqLBzaR9CTUOYcDGkDl1ixM/qLuQAJZWWxzTQZWfNeu0QrOndJIM/o
 3Bex3gwvCoubkBw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sodaville.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-sodaville.c b/drivers/gpio/gpio-sodaville.c
index abd13c79ace09db228e975f93c92e727d3864ef8..6bc224d3a561077bf3438a70591e1f313ac834f3 100644
--- a/drivers/gpio/gpio-sodaville.c
+++ b/drivers/gpio/gpio-sodaville.c
@@ -9,6 +9,7 @@
 
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -39,7 +40,7 @@ struct sdv_gpio_chip_data {
 	void __iomem *gpio_pub_base;
 	struct irq_domain *id;
 	struct irq_chip_generic *gc;
-	struct gpio_chip chip;
+	struct gpio_generic_chip gen_gc;
 };
 
 static int sdv_gpio_pub_set_type(struct irq_data *d, unsigned int type)
@@ -180,6 +181,7 @@ static int sdv_register_irqsupport(struct sdv_gpio_chip_data *sd,
 static int sdv_gpio_probe(struct pci_dev *pdev,
 					const struct pci_device_id *pci_id)
 {
+	struct gpio_generic_chip_config config;
 	struct sdv_gpio_chip_data *sd;
 	int ret;
 	u32 mux_val;
@@ -206,15 +208,21 @@ static int sdv_gpio_probe(struct pci_dev *pdev,
 	if (!ret)
 		writel(mux_val, sd->gpio_pub_base + GPMUXCTL);
 
-	ret = bgpio_init(&sd->chip, &pdev->dev, 4,
-			sd->gpio_pub_base + GPINR, sd->gpio_pub_base + GPOUTR,
-			NULL, sd->gpio_pub_base + GPOER, NULL, 0);
+	config = (typeof(config)){
+		.dev = &pdev->dev,
+		.sz = 4,
+		.dat = sd->gpio_pub_base + GPINR,
+		.set = sd->gpio_pub_base + GPOUTR,
+		.dirout = sd->gpio_pub_base + GPOER,
+	};
+
+	ret = gpio_generic_chip_init(&sd->gen_gc, &config);
 	if (ret)
 		return ret;
 
-	sd->chip.ngpio = SDV_NUM_PUB_GPIOS;
+	sd->gen_gc.gc.ngpio = SDV_NUM_PUB_GPIOS;
 
-	ret = devm_gpiochip_add_data(&pdev->dev, &sd->chip, sd);
+	ret = devm_gpiochip_add_data(&pdev->dev, &sd->gen_gc.gc, sd);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "gpiochip_add() failed.\n");
 		return ret;

-- 
2.48.1


