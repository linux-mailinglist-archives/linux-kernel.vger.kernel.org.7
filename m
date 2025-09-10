Return-Path: <linux-kernel+bounces-809557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1FDB50F11
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08404E73D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478E630F925;
	Wed, 10 Sep 2025 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vA+B/bNb"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3787830F554
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757488407; cv=none; b=s5ouSH3z0ryaR5K0eFUQA1V2aEq6zxgOeoG36cJrCNSeqxod5XIM/qntdWPzQWwdpsyxr+YSP2tbP3c6eojEBoMnNisrb80xuaLPj3NPHLpiW1rkhikb8L2n86n0KJ2zJs1Di1i48nYfU67IkkHqra6w88JAa+GZimRCLpnS9Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757488407; c=relaxed/simple;
	bh=HibveWzwd76lNGw0hoPtFesB/eis3CiQnF9lnEPr4gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hmrdnd1IleCIassJ5jIzK2Vhv0bk3uAlY94Dnh73TPq4eyBKRYGIqNniYvhXWGaRzCcu4n/7hzz87GMIGclkh7+KAUcHY/FemkpVwwNG0eqBV0feIBd+uDA2ktEuQNSxZQbs6P8ga24eap5D2HwmRP7pYXhyOng+D516iLV0uOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vA+B/bNb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso33013995e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757488404; x=1758093204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgdrM4aJRYrczpVTjbdMrpsxOv5ioO0+n1bSkbQmCXA=;
        b=vA+B/bNbiZu7bdrvlpeUmw1JmImq8u0fymaMMsBQetW7/1iItk9i8sdMI4J3DF8aBT
         MXsO+NEGvqaAWDbMgTGV0yBSPhFFQjccj5E1dGjUanpaiMd6vK1ApyBc8NaZZ/COFsJu
         vKuE4Gx4h4Hi/mjuREa3qGgxQ06mwPA2UEY6kw8bu4IQMAfDe3aJswIIXrcKa+zaCXc3
         U3rYGY2h+8puHKA6QtAQjPUeQHKxt4GI0zNfGVTodok6WIPKYxBIJMsRHfh4mMmU8ljb
         HnohN7Na3I1jts2CxJzaYvegsCwnFxyyX9joyH5/vdpRY0iqHVIanXQ1ImFQp4nRB3b5
         AsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757488404; x=1758093204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgdrM4aJRYrczpVTjbdMrpsxOv5ioO0+n1bSkbQmCXA=;
        b=UIkNHgY9bomNq0NEI/ihOjKFU7b6FYbQ8NvimotXo+qFOUahslAZQ6EgwgiNt53Ktk
         jr8JF9GRrcWNztXPvThizbbQnxeUVAt+xMu/ALA2+NUqkvGOo27JkX2+h1Jr2h0TauQC
         KP3OE4HdcFpuHhk/bDYb+V8jJltMhFhkYXqevEzD0XfkXEBioaRtwKmTOJp7nOO17Zx4
         Y6ploUBznCZnxb4RftO5hb8Bff2cbxpaeSFxIo5kdlq3G7dLxV7+c1nH/RgzvFckQj1B
         TxDju8dnrBYxy5Y+DDLqz2s8b/GVuF6I/fz3p/rkIBdm7a791dY5Qe17hj3NsJku5ja6
         EJ3g==
X-Forwarded-Encrypted: i=1; AJvYcCVzFZmW1w7msClJC+COrSTj+czjIHpFjqf05XCRDR0Ec50P6HClvjk5gEYIuJD01Owgik4OVphDcC8TXBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk8vD10tHJKL7VWNzB++dNEnSa58cT2jIxnvtfCgNthl6WE8of
	vTj+ofqhUA5FcLl7S8HhYqUdJbDMVwwDiFtR1uZwNm4hGTqdUwbYiHWtlQBdCi5dzXU=
X-Gm-Gg: ASbGncv/aygG5Kn819lM3GDu0z2QjPOKh1WU5IugiD6OgHG4vgykM/ghxJHLL+N4eyz
	OKSgWMpqy0mRJBYcT+7L2zXJgQ8oPKTMzSQckFYLSTt9j74+XAQjGXrtxPN0iNqWJ77G7ViX6cs
	921TfpwAmQSOubWZ/RqJnz21ieWvuYohh3k8vQYG8o9jR7Z0FSmb802RUiPHI2JEOKgZTFHKZAb
	6acnXiFxqxToS+j3wekpOfrX4c3RF1pM6WlbhDkom+EdMNTILwIb+0KSOtVDXYocgtFWTF5X54D
	CsXytdEvlGthOrCOlGPLV7BOTtxw++kezgD2IexqGLNVF7SHU+LtwLTjyVA1vRWxgSj2zTC0XKB
	3go/DYwpVyPpGt5P6/5qSxEtwKf79oRnpQITrDw==
X-Google-Smtp-Source: AGHT+IH52c0NDjTg92BlFI1StBbf2SlfXbs3hSBtxvJaf6s0LfTwWHF4zDme3188iCv7fISkb9TvkA==
X-Received: by 2002:a05:600c:548a:b0:458:bfb1:1fb6 with SMTP id 5b1f17b1804b1-45ddde6a471mr110866285e9.2.1757488403590;
        Wed, 10 Sep 2025 00:13:23 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3936:709a:82c4:3e38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81d20d2sm16357035e9.8.2025.09.10.00.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 00:13:22 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Sep 2025 09:12:50 +0200
Subject: [PATCH v2 14/15] gpio: mmio: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-gpio-mmio-gpio-conv-part4-v2-14-f3d1a4c57124@linaro.org>
References: <20250910-gpio-mmio-gpio-conv-part4-v2-0-f3d1a4c57124@linaro.org>
In-Reply-To: <20250910-gpio-mmio-gpio-conv-part4-v2-0-f3d1a4c57124@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2870;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=jTYzXHXb5czFalzYciLNM7kw2y7Wfknx1rBEQWD7H2o=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBowSTvYeCo2U5//1kw2eyb8GaFucYbACnhM1h1b
 j06xC/+zTqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaMEk7wAKCRARpy6gFHHX
 cjZVD/9AFqlvniqbT8HvF7F7bzr3GPnqTQ0kCgmRscqp7Q9nkhIRz798jAllvC7arbNGc6Bd/RR
 C64IshK/9T6PmCTb+thHDxg39m28kKBoWH+p2PNkHLz4ekmmyLblZKGwCzUYg2qMavLi1t7OOgr
 3QuG/P4WFoXwe9ty7Z44O2ZITUKFWF+aq45RponrykKQtLfyg+257GPvlx+qj5oTiXV5jxsaEbM
 0Lptqy1v/MepVKY7QL9OW5xP4U2OnpLLHcIaxF7bN9z28L4JcII4h3oJn6B3NDss+cLn3uVNSX2
 4vCnNMIiibPIFdgzJvDuIU0HP4Rgvge9/sJZdobf/KwcIf1ZlrnqH7trBjzQ+v8tXlMhY44M8mE
 mSYlYN77g00pU1hZMXt2ptHkrBwtY+oknQfieQe31B9bzQT4nLf/yW7hohCkD8oR1YcVIPEoHGX
 4zh+hMw/Z9e6srBa1u0J0TMB7l6igulBC6BiOqd1qoxvJzxS1KvcYCKGv0bnjbEDiu94Ad+KF4F
 JUSl6rEBXpdR4lLTQ8P0T8cgh+b+v0l9cz6IpL2gRujbwWSF8wWko1Oe+l8Ob9qw673A1dV2UTI
 ELiQzt6TSguDmVitgU2Yu2NxFJAoOQfbuBnYqdqbb7DaNGlNAxUxeZNc8EpHHrdQNm5PMxraSAM
 iP+AJ2/RibBc5cg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Convert the driver to using the new generic GPIO chip interfaces from
linux/gpio/generic.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mmio.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index 79e1be149c94842cb6fa6b657343b11e78701220..b4f0ab0daaeb11bd88723f8b1c15bd09225f1d97 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -57,6 +57,7 @@ o        `                     ~~~~\___/~~~~    ` controller in FPGA is ,.`
 #include <linux/types.h>
 
 #include <linux/gpio/driver.h>
+#include <linux/gpio/generic.h>
 
 #include "gpiolib.h"
 
@@ -737,6 +738,8 @@ MODULE_DEVICE_TABLE(of, bgpio_of_match);
 
 static int bgpio_pdev_probe(struct platform_device *pdev)
 {
+	struct gpio_generic_chip_config config;
+	struct gpio_generic_chip *gen_gc;
 	struct device *dev = &pdev->dev;
 	struct resource *r;
 	void __iomem *dat;
@@ -748,7 +751,6 @@ static int bgpio_pdev_probe(struct platform_device *pdev)
 	unsigned long flags = 0;
 	unsigned int base;
 	int err;
-	struct gpio_chip *gc;
 	const char *label;
 
 	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dat");
@@ -777,8 +779,8 @@ static int bgpio_pdev_probe(struct platform_device *pdev)
 	if (IS_ERR(dirin))
 		return PTR_ERR(dirin);
 
-	gc = devm_kzalloc(&pdev->dev, sizeof(*gc), GFP_KERNEL);
-	if (!gc)
+	gen_gc = devm_kzalloc(&pdev->dev, sizeof(*gen_gc), GFP_KERNEL);
+	if (!gen_gc)
 		return -ENOMEM;
 
 	if (device_is_big_endian(dev))
@@ -787,13 +789,24 @@ static int bgpio_pdev_probe(struct platform_device *pdev)
 	if (device_property_read_bool(dev, "no-output"))
 		flags |= BGPIOF_NO_OUTPUT;
 
-	err = bgpio_init(gc, dev, sz, dat, set, clr, dirout, dirin, flags);
+	config = (struct gpio_generic_chip_config) {
+		.dev = dev,
+		.sz = sz,
+		.dat = dat,
+		.set = set,
+		.clr = clr,
+		.dirout = dirout,
+		.dirin = dirin,
+		.flags = flags,
+	};
+
+	err = gpio_generic_chip_init(gen_gc, &config);
 	if (err)
 		return err;
 
 	err = device_property_read_string(dev, "label", &label);
 	if (!err)
-		gc->label = label;
+		gen_gc->gc.label = label;
 
 	/*
 	 * This property *must not* be used in device-tree sources, it's only
@@ -801,11 +814,11 @@ static int bgpio_pdev_probe(struct platform_device *pdev)
 	 */
 	err = device_property_read_u32(dev, "gpio-mmio,base", &base);
 	if (!err && base <= INT_MAX)
-		gc->base = base;
+		gen_gc->gc.base = base;
 
-	platform_set_drvdata(pdev, gc);
+	platform_set_drvdata(pdev, &gen_gc->gc);
 
-	return devm_gpiochip_add_data(&pdev->dev, gc, NULL);
+	return devm_gpiochip_add_data(&pdev->dev, &gen_gc->gc, NULL);
 }
 
 static const struct platform_device_id bgpio_id_table[] = {

-- 
2.48.1


