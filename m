Return-Path: <linux-kernel+bounces-784432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77F7B33BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2183B8013
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BC52D59E8;
	Mon, 25 Aug 2025 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lkwXmo2F"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083C72D46A7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115343; cv=none; b=cDV4YKZkF8C6LYuufDsf4LFB7+eaJIn3Uf/30EvRviA607qCrtQil6GdOvstOA9qtjdBlC9JGZlpIz5JS3KjZwCY3ZnFMI9oJ5duJPaPR163d24gHopJq/+595dWOsDwjPmT7MEQnY8g4Rc9s02hhJek0/UkeTWtOLovfc71y10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115343; c=relaxed/simple;
	bh=Kt7kTlN8Qa7Pl4SqU30Df8uHnhys/xXdAQiFzxd+SRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cAHnOxnxeHozzTENsl/1Z35PQ2F+u0ATUa3dbMXXnK2gdYNyxj6lE622g6BaOMSfOddR7tMnMBCRByhn0LKxIauHcuIWkMNukQbQ2qJCHO56uEN/mf4XqnEBVaGohNbWvUvvlk1AvRuUYCmKkHdGP7cRwCFa00djoBxnnf7tYgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lkwXmo2F; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b49f7aaf5so24494255e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756115339; x=1756720139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XL7geZnhEu2GHgbcJnrbk4PK9+gLE9ZfzKbGFcoVdE=;
        b=lkwXmo2F6QcZMA/K2sMetobqQ8NWtXTKkEJlWcOUOGC8RxH5/3MwZrGYdnpQb9ducy
         umAax4uoc/1luMHIbviHIs4xvU5QTjd3DM+PMY6o+41o+vBykAuLxZWRPjU5WqJ2Qy+w
         RHewi8KH6xlR1zFwLp7FA9Lh0MS8a8rvW7DbGPkCKIBQs1MD6FNgnsbuUQubpLRHs9Vh
         XU8+++dTaEuqje4h7B9PUUkRHllQ630mngJ2z/Wc6gN+lm/5Fpoa1iDmvwph4E02QohD
         p5sBvut2lskmDsBeGB2CUh+cX4ooKzioqPZLq1MKXZUrrvYQUFnBbodTrfisqOIoOFfd
         UKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115339; x=1756720139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XL7geZnhEu2GHgbcJnrbk4PK9+gLE9ZfzKbGFcoVdE=;
        b=sl58Fs9PT/cG60r83RcyhIxaT9ZUAtLBqZSSOrESh/xWMe9jiDaSU5DNbrJ9sYoEVv
         jobjsci7N2a2MoiT7asGvrIXUdhkCuM+3iJNFDLQGc7KDsJ2SYn7gJ7TBW0H0SvB2CIR
         p4t5Bnd6HQWME20JP9BHL944HGN3fMV8OR3KKxd3piwPv2A3XwRkvox7rjiuR5msOOfv
         qAewCgy4DZyld4GWg1W5l3O8qnO1QjRHEI3uaGnFV58hzk//JjRNkVMNI+h2Wes4nbNa
         vFyDHDoiEQk8eNoUnWaVxaP3hCx6H1VCUEHV0F88gyINpC3tfp3GbXqS2jSwCj18yMX/
         mKvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLAlBz70x78Dqb9qAfLt5vDle6Elp8A3STqSWRuUti2ue/8oP4KHeRrb5bFGmL9oGs0E5j5exw3fbxBA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJP+MTz5OZG/WKWlvnC3dzNKlcag3k10icwCMJe0GHo7LjtIbI
	AIpx3bZyjLImbdCUZImsHUNdgGLKg+4BFSiPzWei8jka/WXXUpLCIqH0IZjCxuYT8ZU=
X-Gm-Gg: ASbGncsferaXc1Ju9hrPh+1wmwS3a1PY90ll9eZbWEXH+Pe22omAXs32xd62Z+moS49
	GFTc2m9hzigUKNnxKqvcodJi8l5nlXSVT2+LWEbCEzgXg1Mn1A2NZer/fR4jnYskMz3dat6LO1k
	dXDukDMYMDcVYoaKGFdEEiSQsQmGJNxRF1RUAsjFJn5ALgN8KNDoVIXrK/V2iXH0+2EmycPlbaS
	zDj7OMw61T0uIZ3DYmyual79LRM3eswbbM9Ea4EGKmZp/NZTs2tR90Sk7SOWSct88qPLzZ7uhum
	Tyo/L6slOmupGQNkPfGDLIzSsqvK+l5XlQq6ii2ZyZuY30xmxwMy6sNdJpgnDqrObxq3GzgDz3Y
	1xVhSvQdK3NHYb5IL3g==
X-Google-Smtp-Source: AGHT+IEegOIMU9MY8ViLpXUpgmi0qzunmqMgdKsRZ/R1rOCcGUkKbBKLGa79Jl9AtpUG8cW2p0LW0A==
X-Received: by 2002:a05:6000:3105:b0:3ba:cff3:2e9 with SMTP id ffacd0b85a97d-3c5daa27683mr7362068f8f.1.1756115338987;
        Mon, 25 Aug 2025 02:48:58 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef52:fc8d:34ad:9bfe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711bb1e3asm10877449f8f.57.2025.08.25.02.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:48:58 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Aug 2025 11:48:49 +0200
Subject: [PATCH RESEND 08/14] gpio: loongson-64bit: use new generic GPIO
 chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-gpio-mmio-gpio-conv-v1-8-356b4b1d5110@linaro.org>
References: <20250825-gpio-mmio-gpio-conv-v1-0-356b4b1d5110@linaro.org>
In-Reply-To: <20250825-gpio-mmio-gpio-conv-v1-0-356b4b1d5110@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Hoan Tran <hoan@os.amperecomputing.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3657;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=q0nDOolzmEolL80kYOdLVFVSG8jdJDB+vSKLox1kAgw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorDF/z4zF1+EzbSX44wW9kp5C98zyXeFWHMG99
 qM5rdbUe8eJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaKwxfwAKCRARpy6gFHHX
 cgkAEADb79ImSyrjWksRjQwnS5++P92g47dudBXPy9h3Q0D8aRDzB4vpmH49EUY9gzVQP23hHEs
 hZngF6HTmH6JBuL0DT5v453QiPforXrkouXp7V3AvUMrZP+Di/tSXxwNDFz9N+dEHgx0Y8//3eS
 aacgJ8wdtl+k+y9VAwkQ8Gw0jOspifdoMpiP7PCs2W8wE+J2SuPR+hHGwBdmykLlLmjeBWFsVkm
 g85RWVYDwM4xVEYUyaRb844JrOxkEfXvL4IbQcdve3kCL7JJqujpSxwNeS6eUfKnoH2PbnN5LiW
 ZrsBdVU+Sp6Y1EtS4lgX5MpnRYtdh9eacHK3m/Uw7x80+2rV0uEZGP5zo0zRpdwt0nBHRncgkNz
 w8ZWYThFpX4J6vchCC8vrRPIszWRXmVm1Gv/APHMPSSysfaeeTBLR2f4C++5RzpkwOe1dwWLZgv
 UJ/Gs9uqXy0Dml0IUrBcCoKOBUqgKn+Ut3YFwwbuw+fPOlothO9+MbySYEv2godYhJ3woXtd6Ef
 tKNGmZfVUEseCIGCdSDoBVCrzytkAZ8e1hlLySQipfHjW5pFNswyBgMvqFE6s2q47zjo0eDe6nS
 KNP/jh4kjpCU/Xdmftn/ElIAHKxVghpEIs+oNhQWsV0nIicqVpvt1fp1VVuFsYOg7K+Zu8hIG14
 zOPbKvV5wIPoaEw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-loongson-64bit.c | 42 ++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-loongson-64bit.c b/drivers/gpio/gpio-loongson-64bit.c
index 818c606fbc5149b2e4274f0776e558332700d916..482e64ba9b4209443c2f64ae7426b8fa9034011a 100644
--- a/drivers/gpio/gpio-loongson-64bit.c
+++ b/drivers/gpio/gpio-loongson-64bit.c
@@ -11,6 +11,7 @@
 #include <linux/spinlock.h>
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 #include <linux/platform_device.h>
 #include <linux/bitops.h>
 #include <asm/types.h>
@@ -30,7 +31,7 @@ struct loongson_gpio_chip_data {
 };
 
 struct loongson_gpio_chip {
-	struct gpio_chip	chip;
+	struct gpio_generic_chip chip;
 	spinlock_t		lock;
 	void __iomem		*reg_base;
 	const struct loongson_gpio_chip_data *chip_data;
@@ -38,7 +39,8 @@ struct loongson_gpio_chip {
 
 static inline struct loongson_gpio_chip *to_loongson_gpio_chip(struct gpio_chip *chip)
 {
-	return container_of(chip, struct loongson_gpio_chip, chip);
+	return container_of(to_gpio_generic_chip(chip),
+			    struct loongson_gpio_chip, chip);
 }
 
 static inline void loongson_commit_direction(struct loongson_gpio_chip *lgpio, unsigned int pin,
@@ -138,36 +140,40 @@ static int loongson_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
 static int loongson_gpio_init(struct device *dev, struct loongson_gpio_chip *lgpio,
 			      void __iomem *reg_base)
 {
+	struct gpio_generic_chip_config config;
 	int ret;
 
 	lgpio->reg_base = reg_base;
 	if (lgpio->chip_data->mode == BIT_CTRL_MODE) {
-		ret = bgpio_init(&lgpio->chip, dev, 8,
-				lgpio->reg_base + lgpio->chip_data->in_offset,
-				lgpio->reg_base + lgpio->chip_data->out_offset,
-				NULL, NULL,
-				lgpio->reg_base + lgpio->chip_data->conf_offset,
-				0);
+		config = (typeof(config)){
+			.dev = dev,
+			.sz = 8,
+			.dat = lgpio->reg_base + lgpio->chip_data->in_offset,
+			.set = lgpio->reg_base + lgpio->chip_data->out_offset,
+			.dirin = lgpio->reg_base + lgpio->chip_data->conf_offset,
+		};
+
+		ret = gpio_generic_chip_init(&lgpio->chip, &config);
 		if (ret) {
 			dev_err(dev, "unable to init generic GPIO\n");
 			return ret;
 		}
 	} else {
-		lgpio->chip.direction_input = loongson_gpio_direction_input;
-		lgpio->chip.get = loongson_gpio_get;
-		lgpio->chip.get_direction = loongson_gpio_get_direction;
-		lgpio->chip.direction_output = loongson_gpio_direction_output;
-		lgpio->chip.set = loongson_gpio_set;
-		lgpio->chip.parent = dev;
+		lgpio->chip.gc.direction_input = loongson_gpio_direction_input;
+		lgpio->chip.gc.get = loongson_gpio_get;
+		lgpio->chip.gc.get_direction = loongson_gpio_get_direction;
+		lgpio->chip.gc.direction_output = loongson_gpio_direction_output;
+		lgpio->chip.gc.set = loongson_gpio_set;
+		lgpio->chip.gc.parent = dev;
 		spin_lock_init(&lgpio->lock);
 	}
 
-	lgpio->chip.label = lgpio->chip_data->label;
-	lgpio->chip.can_sleep = false;
+	lgpio->chip.gc.label = lgpio->chip_data->label;
+	lgpio->chip.gc.can_sleep = false;
 	if (lgpio->chip_data->inten_offset)
-		lgpio->chip.to_irq = loongson_gpio_to_irq;
+		lgpio->chip.gc.to_irq = loongson_gpio_to_irq;
 
-	return devm_gpiochip_add_data(dev, &lgpio->chip, lgpio);
+	return devm_gpiochip_add_data(dev, &lgpio->chip.gc, lgpio);
 }
 
 static int loongson_gpio_probe(struct platform_device *pdev)

-- 
2.48.1


