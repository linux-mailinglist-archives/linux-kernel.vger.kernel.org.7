Return-Path: <linux-kernel+bounces-807681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5D7B4A7F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52FE443ECA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEB431063B;
	Tue,  9 Sep 2025 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AuK0gUgr"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1F230E0ED
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409374; cv=none; b=Yfl3QZ6BhH+e4tnwzTmSPiILX9zaU+eXi+neBbHxXmh5YgIDKZQrZDry9dzH+xYCjl4ViUHwr6QsSAXi34uxCBbDGFuul9p2paetbAec+mnpG1KYrWybHYdxj1PDmfowsePguWKELHgrtDhQeD+qRGKFoQFckMMI9GtfZmdkpDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409374; c=relaxed/simple;
	bh=pfY5A0u470ZWmlLJkPgoDVi7l1fJw/+hwUAmIObpEP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vAETxnUvS3mO/BuVrlI4jp9TP79f7ys45MXwgpIStABNOZTjbAm5XA6SLv/Ons6l3Pck7VOwTAbp/QkgYsahE/le6SBYFZEaBeQEdZ1zTBsd9hfvXbNCV/AyBAJEf/dlmNJZG5uVDCY48CWuXkngnQgUWHWFFu3MA2zBissQosc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AuK0gUgr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3dae49b117bso4690760f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 02:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757409370; x=1758014170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NS6kcVwueQk8PTITkKoVosiwdk6Lg4fQNiLC3+K+D0=;
        b=AuK0gUgrqmPRHUjGvJSXt3LmL6oqBoiEW2mn/Uox+IybzG/3sNs+MgZ74t+Of8qoSm
         /Qf9Ot3AX7KZoPGzhuWpt93pJ6KHoGCu++in+e5SNw8nXeZsnDQGFZQEkGaU20jZx1qa
         Bv3AyuLQbAqBsUMFAVQkPCplOgqcHXpQmdtSIEHk0jWlkfZD/rK32voTen46dhaI2Rhz
         Mqu/INfRovcvg/ydb5xcaP4/ayVE5uuF1KYOlD1k3u9Ehhw2Wf44vjEnSpC5qv4JVQUU
         5TDh2GDo6C8ZQIw0AvyuuWcEr1UOdWpVaCsO4ZW5CwowPBi2epJeZa4HL66c0/o5X8NQ
         SU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409370; x=1758014170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NS6kcVwueQk8PTITkKoVosiwdk6Lg4fQNiLC3+K+D0=;
        b=I81HwF/Z3PbGCUjFLk4x+x5Utx/3KiP1Cw1ysDiRAyqltfAP1W0WBqYWz8j/pHvl7Z
         CalFbbrsaQAtfVZt3rflJ1Twju8tHJxod9dzKaCn0JCrXa71hPVvfe1NRR/Ku68RtIIK
         EicJF28sBnp4TBlXMUvuh+hb1NuL7l5+kDULarhqt8u033O8heHu91a40Zws1NwmL1mq
         MWEh9iGWD0KrelfONyH6sir15gjCmTu/EoV6UCj8JYhVQSThJ85+6p/Z/PODheH2Wtj/
         oMcusRToSCsOqXYlmJ4wrPp2npm0vccrVq9HRqGhxXccANS7I6ZV5w/sdB3Mmc11Dtck
         ZqIw==
X-Forwarded-Encrypted: i=1; AJvYcCW+m3H29nCP67sFiePRopaUiRoWyDp7k0x00jqzXxns7jOdeR1lLgIOnN9PKzHMI2bqtMMv6B8WFbv1c3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB3d+sA9/8kRdu8noEpOJjAStYPb9GFd6PEiNX1mq3Fx1His/J
	XI3CP0jChhAOHk8Eevb7+NLnzDCaX2xApKjU5CqW7YK226k8Y2Xr7T3b70rKfU7h1aE=
X-Gm-Gg: ASbGnctXiywZ3Whiioj0Ubk3SFOw8W0m12PDufN39t2KgS2E6I64o1AVAjozhKayfiz
	VWPCzn6Ecih6+oMWtwN1AJinUekVz7j8hKdXTs7zJW0EwAYK0EgM1Dg4roDkcK9ou+6jBkjIG49
	XKeSoCpQ1tXG4K1r+Ts/XNZeKXDlkYDYunXUgMfrFuSkzqMewtQizUw+mo/fGZlslni4MPy/NFO
	1svi9RPqmnAxiNXiycCM5hSCGpxs4CC5TtPSFEBdww9fKEHg8fVYgGQQ8FGz207e6UstFodrZ/m
	3yGMNvjbVYfVM6dLLam5eHvP0JdgT2eo152LY96IYLRiBPfgrNqYOqRGOUVj0fPFJuUWEaHBpO9
	TleekF0rmsbkGDP0Eo9f06UW7vJUv
X-Google-Smtp-Source: AGHT+IGoJXBvUJSpBt2lyPYKxW7iuqKGK81p5w4PzJvmsSblYb1erZflWT5xfvs5LzLHjloaRsoS9A==
X-Received: by 2002:a5d:5f82:0:b0:3e7:4271:8c6d with SMTP id ffacd0b85a97d-3e742718faemr7197437f8f.34.1757409369974;
        Tue, 09 Sep 2025 02:16:09 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c1ee:7be9:3ebb:6cc0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9caasm1900039f8f.19.2025.09.09.02.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:16:08 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 09 Sep 2025 11:15:41 +0200
Subject: [PATCH 14/15] gpio: mmio: use new generic GPIO chip API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-gpio-mmio-gpio-conv-part4-v1-14-9f723dc3524a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2852;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ghLIXnylAYcLYVJg4ksyA9B4/RaoUKjw1Cc8UARhArE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBov/A7M1kWuQRnL65yzzeom2IENhFIls+CzXrAj
 boY3wL6vvGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaL/wOwAKCRARpy6gFHHX
 cjUbD/sHaYXToO+u0YqX7txBkP4Ezr0jc2j0S4iqMhj2XV/ZOkALp/qxGiMGm3GaPndvBOHLlko
 a+JYIaEtSb2cUM4o/Q7qpaiHJY7TST7XfNadxyDo/SfLQtQr7BzQ5FBU7+WU8omyvO2EonGCvah
 cCGCSQagVc7uqle5HXUtXcx5bglGy23IdFAi3D5HcPbgu8r4hegVKRPB35R3L196GVHJOARdZlJ
 SqGKqXaoRrqsCjoV7KfdkJs7Aq8KZs5lAMV/E7/Vjs0OQ5oL+IGXlf1pkfPQrk+m+bxxPo+CD1s
 o1co0Zh6+J34EVC5uiOvxm4QiWuJNJZ4OrU//m1bYHhAksr0qaLZmf6sd2eJ05ZyV2pCwbRyGcK
 NdN/wr81ld7t7tuLtbiWO85UH3i8G7+jlHyAB5kk4Bu1czKO0SCtM90ng3QeNoqhG/sI++TESm4
 JXHWeVwLLpSZqMU2Bf3EBFk0bPm1futJyBqmHcfDoPrXUJck+4IC/VrLUn09S8Y3evWzn9eTA2L
 NoxZIkWhOuNM8wZeBEuOPJ3IROTEAl0i0TNfkgOm76aAzuo5LXUEgUbIHQbNNi1KB3Wy8DD5i8d
 nkF6QDdT+keKJjVnvSQGBqIefYenhz+NehXtlsxXnYQKSdf3vpEEpWJ9iObJDEZVE3REDYl3+Il
 tXWZSivklUydFdQ==
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
index 79e1be149c94842cb6fa6b657343b11e78701220..a5e2f8a826af40ec96d2a3ea58240f1ca8ed250c 100644
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
+	config = (typeof(config)){
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


