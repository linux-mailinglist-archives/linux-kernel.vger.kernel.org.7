Return-Path: <linux-kernel+bounces-841903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8EBBB880B
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 03:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E2714EFE3C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 01:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C2822127D;
	Sat,  4 Oct 2025 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ironIDZ4"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C7321FF4C
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759543016; cv=none; b=gSWNGhqQBv/Q4arhIVTARR0BrvamZwrl7oN1SSmAAdWwjFQNeshjF/1Yl5KxxDP3hR2Qit9jMVEC8REMfojIgJ38HsQDbuqppaTxXEUmoQb3AVj1a984p9GUv8QhEhYNqrf/Iskjzxv44DxVAuu9SDw/396QTFq/EvwoGD19skk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759543016; c=relaxed/simple;
	bh=60sFE8dH95IQRhjstRyY7EVNnqU2lIgts0o7HyQejn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Quh2wSVr/eL9y7sunibk9WuvSCiRvYFDGf/5X9RWOl2GfxcuJJC762Cm3NgOF5qFUh8CnrKG8GxqeeDUdJ0cI3+x3Tlim68w9ZHmJ9jmao2rgwkkAjEokHMaLYKIg+A7rIkQvZpEriXKN57vUAuyQT/Os2kyHvQ9s3DIi12sOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ironIDZ4; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-78af9ebe337so2053153b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 18:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759543014; x=1760147814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXs1QSVIqrmDB/CsKZ6PEf+V8gETdC9cB2i9VQlHTvA=;
        b=ironIDZ4udqKpjhSZpwBgM5dXqqf6gjHm26vva9HCngT685JrolL9UNhibj0dBlwSx
         l+AKJP2jbVFRSCUtOHvzGDcQ8s5ujWJxPduox8/VF4ydymvgS6SU7/QGtKqC3bTLz5L/
         nK1XtYtyMpw5F8efTW6rxPOniakQxBIcq5Lyr898t4N3FBjorBk0p2qvZr02LkVK4mZj
         9acOYCcHfHoxsQGAnfJc7lTS+vl7IdAuUEEJzl2dQVgmzW1qfEQBzEzReoHc1rXCc2rr
         l/oWm+YAW+0KdQofSBE3HOQGYxIXAKT8wir7eXCwqpZyoMCrhB2urOm3eMxYxT1KJRmU
         DBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759543014; x=1760147814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXs1QSVIqrmDB/CsKZ6PEf+V8gETdC9cB2i9VQlHTvA=;
        b=v6N9RJaeEn4cvU9vaQGpGq5IHUmFfu4MinGuOlRx2LN+zm+0qAOzYDKs+OIz4d3Zub
         OOiRLNdeV5mdYcof0kMjdCXF3MW1d82v26cYkUI/TAZw3AXTJljpxkc7VAKrLPpPq5h/
         uEo1fRL+LzAatx53pbhnHixwx2kbW5hT9XRxp3NM0hIcv3IkEUymr4J947G36jqhpK0J
         af5FQbKhdXC0V32CiOdZz+oXAG/2s2C4ilvKwF/bXokKVmjo26lcz9E6FoCRlp45vDuz
         AvcWpWfUPjHoJc5ly/36gEilGLeDZbRV7L+GI7xt56ILleYiG45lJzXgS8+W9kDeumRJ
         7/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCU+21Q8NsChMFXDp6kv/9cCP81VUzKRyxrGXxJ9fzGuFRqLj0SIJN1NLt2s9NI0NcmnHwsqjHY8+76ioLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIQh/krpQ7F90V6b6KH1HxkBYQyhN/MxlBk1MEbOKsycIDDETb
	LDaH1xLfYX8vR78nsRO4nzAFjUFsRACFQi3Y+E5SZ/N9WEUNeEswXPtT
X-Gm-Gg: ASbGncvTvK3m1PrOqAoy+cTsIKONNI+Sl2fykwN/+uB/FkzXuDz1qbdO8xJ51hq8un2
	f3WPse3DlvAsZ86E24ASYz8X/OiuryYh/e2ImFQiZ/qHLMTnP+ZqXKMHxFu2Xj436mR9RovYO1z
	amv4AWg78N6vfN1bC6103oRwv8Bx8QzfbBBPuCNaWm9i3lSMPR5hdkeyxjoOLvX6k4XKmHjSAKv
	rkPHwjOaTNXAbI+SVDSAzAQDM6W4y+ODLH8/94rvIFrp/kQV1fcOz6Na82GwmXtCA0OJRBBwnBQ
	rqKj0nR8cIxb+CU0ikmhAmKUoPIUMExqQDWJaftelqiS+AmiLEhtZFynZD+KwHWbimuMRxRS62G
	Cwzr0LGTfblJC0/VsB32gkoPbqAzRlPfEiGCRkcO+DwFkXL4GxtlKWTI=
X-Google-Smtp-Source: AGHT+IFkvcg76qipc69NuQnIWNLwlZfZsq2gWo9bV8jdBE0nvip+ixi0boun0gdtaOb85HXiysRS2w==
X-Received: by 2002:a17:903:40d1:b0:27e:f16f:618b with SMTP id d9443c01a7336-28e9a55c07fmr62108745ad.24.1759543014242;
        Fri, 03 Oct 2025 18:56:54 -0700 (PDT)
Received: from Ubuntu24.. ([157.33.197.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d134859sm63197485ad.57.2025.10.03.18.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 18:56:53 -0700 (PDT)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	matt@ranostay.sg,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH 2/2] iio: health: max30100: Add pulse-width configuration via DT
Date: Sat,  4 Oct 2025 07:26:23 +0530
Message-ID: <20251004015623.7019-3-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251004015623.7019-1-raskar.shree97@gmail.com>
References: <20251004015623.7019-1-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX30100 driver previously hardcoded the SPO2 pulse width to
1600us. This patch adds support for reading the pulse width from
device tree (`maxim,pulse-width`) and programming it into the SPO2
configuration register.

If no property is provided, the driver falls back to 1600us to
preserve existing behavior.

Testing:
Hardware: Raspberry Pi 3B + MAX30100 breakout
Verified DT property read in probe()
Confirmed SPO2_CONFIG register written correctly using regmap_read()

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/health/max30100.c | 39 +++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 814f521e47ae..2b3348c75beb 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2015, 2018
  * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  *
- * TODO: enable pulse length controls via device tree properties
  */
 
 #include <linux/module.h>
@@ -54,6 +53,9 @@
 #define MAX30100_REG_SPO2_CONFIG		0x07
 #define MAX30100_REG_SPO2_CONFIG_100HZ		BIT(2)
 #define MAX30100_REG_SPO2_CONFIG_HI_RES_EN	BIT(6)
+#define MAX30100_REG_SPO2_CONFIG_200US		0x0
+#define MAX30100_REG_SPO2_CONFIG_400US		0x1
+#define MAX30100_REG_SPO2_CONFIG_800US		0x2
 #define MAX30100_REG_SPO2_CONFIG_1600US		0x3
 
 #define MAX30100_REG_LED_CONFIG			0x09
@@ -306,19 +308,52 @@ static int max30100_led_init(struct max30100_data *data)
 		MAX30100_REG_LED_CONFIG_LED_MASK, reg);
 }
 
+static int max30100_get_pulse_width(unsigned int pwidth_us)
+{
+	switch (pwidth_us) {
+	case 200:
+		return MAX30100_REG_SPO2_CONFIG_200US;
+	case 400:
+		return MAX30100_REG_SPO2_CONFIG_400US;
+	case 800:
+		return MAX30100_REG_SPO2_CONFIG_800US;
+	case 1600:
+		return MAX30100_REG_SPO2_CONFIG_1600US;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int max30100_chip_init(struct max30100_data *data)
 {
 	int ret;
+	unsigned int pulse_us;
+	unsigned int pulse_width;
+	struct device *dev = &data->client->dev;
 
 	/* setup LED current settings */
 	ret = max30100_led_init(data);
 	if (ret)
 		return ret;
 
+	/* Get pulse width from DT, default = 1600us */
+	ret = device_property_read_u32(dev, "maxim,pulse-width", &pulse_us);
+	if (ret) {
+		dev_warn(dev, "no pulse-width defined, defaulting to 1600us\n");
+		pulse_width = MAX30100_REG_SPO2_CONFIG_1600US;
+	} else {
+		pulse_width = max30100_get_pulse_width(pulse_us);
+		if (pulse_width < 0) {
+			dev_err(dev, "invalid pulse-width %u\n", pulse_us);
+			return pulse_width;
+		}
+	}
+
 	/* enable hi-res SPO2 readings at 100Hz */
 	ret = regmap_write(data->regmap, MAX30100_REG_SPO2_CONFIG,
 				 MAX30100_REG_SPO2_CONFIG_HI_RES_EN |
-				 MAX30100_REG_SPO2_CONFIG_100HZ);
+				 MAX30100_REG_SPO2_CONFIG_100HZ |
+				 pulse_width);
 	if (ret)
 		return ret;
 
-- 
2.43.0


