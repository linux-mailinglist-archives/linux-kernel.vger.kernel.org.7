Return-Path: <linux-kernel+bounces-807675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72251B4A7A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8047D7B2A9B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3A430E0DB;
	Tue,  9 Sep 2025 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qLQCjz4N"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8609308F0A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409366; cv=none; b=oyEcDXXbXOAreo9gbskqrtjfJ8PkE66QSJ+zVix1E+psOHgs69rKHaKoMyYVtbI7nNOjHA1ubk010Zil4duPKvlKT2KSzG3TH/o8L0wUwYDBNO4o7CxikkmB0N0JOH81t9S9hgpUZ5nU16gaV6vUpp9kVDLiKcVkGUUt8Dk/eSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409366; c=relaxed/simple;
	bh=jG8CMLb4inMj87fVDZoRGePD2w1MG5h8a/maIqRELGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qvi6D9CFITWGMxTTS6IqHkLRe/uTqEHctDGbiZ0G+AR494IrZw5VaP4oEPVWlVWIns/BsQ6FIj1aO4NWy/BpKGtv3FzIu6UWmyHEL5YGb6Q4U8AgIewKAX4X5pUVAbl3ELnSb2OIwKaOfKtvYdifP1OSfp6IoDj035WQvRmjhlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qLQCjz4N; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so3492371f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757409362; x=1758014162; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzDGMJfmWh4iChkJ6qtmNZIGp6yJhGT0+TEuoPl0ljI=;
        b=qLQCjz4NHkPGrOnd5Dy/eX7EKQ4yZXSrWw5rCOqy9qi6vgHfCCS/+Q9uV6+2IQqj7O
         HWIuNw+bvR8ot9TTIEhCblgIoKhacwI6CpgIx/rTVG91OTtB3asFod88ga8QQwxEiodr
         TYMQx2A5ycJiL6pU5Tgmrnr4BLxnsAmaQef879qaVVw9Xh7SBru1b619sBIydRh8TvD+
         wWe6qCoQwn7QqHu/DsXvMyijBTXzGG3Eiaqd/8NXNgq6po3gFpWD5mpkCKzIu1dG5SdB
         yeYQg8/7OUDxWs5vgGRjMfH+rfjHDgcMjxm3lWZXTFnBh8HdA7IGTWyio5yJgYqO+qEY
         N83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409362; x=1758014162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzDGMJfmWh4iChkJ6qtmNZIGp6yJhGT0+TEuoPl0ljI=;
        b=XgWTP1sLVZwI0A0aTq3FH9BKxFWqO3VhxxpgaXdlGNEmwrm3Pm58bRkA8O71SYdvIj
         r7vUwSTxMIxDP3RJNwgmABqwpTC6Ms6HDwMTTMm7TBmD3STeUMUFgiM7Zb26eVlPv3V3
         PmtoOZxiHEmtFau+GQJL/aU7Pk3NFUsqDzcU7Sw9ac43vs/A1A82AYYSGw6jAtBPiHKg
         yb3U9h/dt/C1fxfPMCHuER6Vcc8mLxrWiYSL+8+1bb39UamXNP/Dxr/0FBiI9/lLalYu
         ZNWasM95YnWvpE/mMwubqBBic0+/5a3x8ul2Lrn+qy+Jj+7qg0bkcTbQ6X6eNZHzcvg2
         CUJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNxVx372vNJ6NTykysSJWC/p7mP3MDHsrz04/aSS9FedABxykDUqaBStyUQkFEo3t0szxU8DhKbfLvZVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp3sX4iQB+x5+Fb7+wBB30IW4ltSP8oaUvp8nXQCH4nTafQwau
	d1DSddPF4As/lOSrtO8A4XlR/szw5rkcnsB4sfobGcLpyJZVMI4BQ0iPq37ZavwLhdg=
X-Gm-Gg: ASbGncvp2L62HjVScseDMDRMJZHbDiXzmMtXs61TfOc0xdbKmhI2PFuXGd03QC0CryC
	xfuK1c/NB19SbbS3nMQTBfkbhiu3eQgQkCRZcoxPLY9zUzTGK2zmMxgqcSNV+Ri0ZZx9sUuj6aO
	vvBzxY4KGBSkIYuXOHZzcr5JVaDlz5lKvKi8pHAN4briSadWRNEuw0SxWefjaCh4XTHPpcGwPgN
	ETJAG+PvpVZe72/Xrjw7gA1b9mgKBLdrXkVzhons3mw1hbKp6SVA8ZdQ4StArQCEedEa41e5npz
	07JMKeMXYlnDzTKNletHWTU70Olh3fjIMBCZ7ZvACYk/rApZFUWemD58AnTWaG7FlQ/3p7JaofP
	q3rfjKX25Xiv3D+fZ6vuxlga2Eh4p
X-Google-Smtp-Source: AGHT+IEXdV8NISTEczU1VIRow+5p3wj26/zBGlI6Z3gmRyg6ivq5S1t8D83LU8LnUsvQNLDOuZ4iCg==
X-Received: by 2002:a05:6000:1ac6:b0:3e2:da00:44af with SMTP id ffacd0b85a97d-3e64317f1b0mr9908320f8f.36.1757409362157;
        Tue, 09 Sep 2025 02:16:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c1ee:7be9:3ebb:6cc0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9caasm1900039f8f.19.2025.09.09.02.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:16:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 09 Sep 2025 11:15:37 +0200
Subject: [PATCH 10/15] gpio: menz127: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-gpio-mmio-gpio-conv-part4-v1-10-9f723dc3524a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3332;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Lx7WAwqP3xPk38b+MFE7x8Xw00e0BMog5eP3WfeiT9s=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBov/A533XVMdjGZ1Cis8dHGgNwfAnmr6Mx6nPBe
 og/XTnFC0uJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaL/wOQAKCRARpy6gFHHX
 cvK3D/90zMG5N+5srxcF6cRvLhIl8gvluNWyjhGAirS1cpIR4x4XFqa1JRSvlICISA4EibUfKNJ
 PCqqwF+Ps0Sb0gxGvXIdzYawaenP1Ay9crGgWCG8dqA5Oh9GGEe1sAJ3fj+b7hBDr0bKiquZZZT
 qm8UPST9YGHy0qZh+xOow62KdkczRxAojMDQLZh5bNe/oCV04FO+Fi2fM8DdLa/t5tIjf7F2LgB
 x6h9uqy3ExyQRUSRz+yuRRbcf8RmRlNHgEWPxdT/3e82BmiIc1xpTXsQbELVgTrsgj3e7BS7LbL
 u1JuLGpx8VAQiDvKnl89BJUWTfjk1O22JRpUP1mWMrVgOcg7mB2OSrtIK/ddsW5l0rrC59Gmjk1
 qaeMlSXWkhqF29/nX3L9M9rKbGqUuZHBaVvBOvLRP4Xd9268YY19a70HNS76Wwt4rm2E0zsrkOH
 Cbic63a0LkP3gvP4WK+77qLsClCFZZwuKZGK4SYbDmK707BXh3JfQmdYoBi9czJtf53Man5JhgA
 niTsF3TUxsHuWNE13i0oWRxrsXAxGUlQk9nCxmJM7Edlm/ds70XygZ/W9iWscyAP2fou3Kx8RAc
 k0YZYHnRPLejEZmL7Zkig/YHgd750jS6if4fIrKfPjQVHCq8sRJM1mQwOksrvpikMmw2E9pyu3U
 8yS9x2NzZmFxfng==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-menz127.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-menz127.c b/drivers/gpio/gpio-menz127.c
index ebe5da4933bce730c70f83c1c0f86fc4a4cc9906..27cdbc36a5fd468dfcf9e0029651c8d22e176f56 100644
--- a/drivers/gpio/gpio-menz127.c
+++ b/drivers/gpio/gpio-menz127.c
@@ -12,6 +12,7 @@
 #include <linux/mcb.h>
 #include <linux/bitops.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 
 #define MEN_Z127_CTRL	0x00
 #define MEN_Z127_PSR	0x04
@@ -30,7 +31,7 @@
 					 (db <= MEN_Z127_DB_MAX_US))
 
 struct men_z127_gpio {
-	struct gpio_chip gc;
+	struct gpio_generic_chip chip;
 	void __iomem *reg_base;
 	struct resource *mem;
 };
@@ -64,7 +65,7 @@ static int men_z127_debounce(struct gpio_chip *gc, unsigned gpio,
 		debounce /= 50;
 	}
 
-	raw_spin_lock(&gc->bgpio_lock);
+	guard(gpio_generic_lock)(&priv->chip);
 
 	db_en = readl(priv->reg_base + MEN_Z127_DBER);
 
@@ -79,8 +80,6 @@ static int men_z127_debounce(struct gpio_chip *gc, unsigned gpio,
 	writel(db_en, priv->reg_base + MEN_Z127_DBER);
 	writel(db_cnt, priv->reg_base + GPIO_TO_DBCNT_REG(gpio));
 
-	raw_spin_unlock(&gc->bgpio_lock);
-
 	return 0;
 }
 
@@ -91,7 +90,8 @@ static int men_z127_set_single_ended(struct gpio_chip *gc,
 	struct men_z127_gpio *priv = gpiochip_get_data(gc);
 	u32 od_en;
 
-	raw_spin_lock(&gc->bgpio_lock);
+	guard(gpio_generic_lock)(&priv->chip);
+
 	od_en = readl(priv->reg_base + MEN_Z127_ODER);
 
 	if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN)
@@ -101,7 +101,6 @@ static int men_z127_set_single_ended(struct gpio_chip *gc,
 		od_en &= ~BIT(offset);
 
 	writel(od_en, priv->reg_base + MEN_Z127_ODER);
-	raw_spin_unlock(&gc->bgpio_lock);
 
 	return 0;
 }
@@ -137,6 +136,7 @@ static void men_z127_release_mem(void *data)
 static int men_z127_probe(struct mcb_device *mdev,
 			  const struct mcb_device_id *id)
 {
+	struct gpio_generic_chip_config config;
 	struct men_z127_gpio *men_z127_gpio;
 	struct device *dev = &mdev->dev;
 	int ret;
@@ -163,18 +163,21 @@ static int men_z127_probe(struct mcb_device *mdev,
 
 	mcb_set_drvdata(mdev, men_z127_gpio);
 
-	ret = bgpio_init(&men_z127_gpio->gc, &mdev->dev, 4,
-			 men_z127_gpio->reg_base + MEN_Z127_PSR,
-			 men_z127_gpio->reg_base + MEN_Z127_CTRL,
-			 NULL,
-			 men_z127_gpio->reg_base + MEN_Z127_GPIODR,
-			 NULL, 0);
+	config = (typeof(config)){
+		.dev = &mdev->dev,
+		.sz = 4,
+		.dat = men_z127_gpio->reg_base + MEN_Z127_PSR,
+		.set = men_z127_gpio->reg_base + MEN_Z127_CTRL,
+		.dirout = men_z127_gpio->reg_base + MEN_Z127_GPIODR,
+	};
+
+	ret = gpio_generic_chip_init(&men_z127_gpio->chip, &config);
 	if (ret)
 		return ret;
 
-	men_z127_gpio->gc.set_config = men_z127_set_config;
+	men_z127_gpio->chip.gc.set_config = men_z127_set_config;
 
-	ret = devm_gpiochip_add_data(dev, &men_z127_gpio->gc, men_z127_gpio);
+	ret = devm_gpiochip_add_data(dev, &men_z127_gpio->chip.gc, men_z127_gpio);
 	if (ret)
 		return dev_err_probe(dev, ret,
 			"failed to register MEN 16Z127 GPIO controller");

-- 
2.48.1


