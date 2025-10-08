Return-Path: <linux-kernel+bounces-844984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8A2BC333A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 05:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035A7189D7D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 03:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8841929E112;
	Wed,  8 Oct 2025 03:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/K8rEtD"
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CE629DB99
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 03:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759893511; cv=none; b=dVOqjJafnmMHzQqRDlq70v/7HmZFXJu3zDahcLtFFnL2sr4e5brazMcCD1Q8ktKMYlkEFTw/532HG0vpWH7ITtENpJmIFytkGibLcBP7Ug+FyCBcXBV4rAzL9F8Cm4M+8v0KXBfwZ3XW4rImk86Y1MjwRewYKH2v9XNYArMavZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759893511; c=relaxed/simple;
	bh=OjsnqX4w9xVPWhGo4KZ1oMWtoIY/AxwyxdfC9ODPA0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjNDeQKGYqarXudPdfPShpo3aSqXhlL2EQ+O4qF4tDhtVIVOBydpXKcrg99Cu6R2a1d1fRnh24cnGvDaVOEjNu5lXnnjOGM7Y9mNbHjpS2vQ1f265sCptpTfvjSYYrdp1d8HcbwaJqYmVpywuvH8Nc3ta3UBsASbjvZNtGkImuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/K8rEtD; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so6217722a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 20:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759893510; x=1760498310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDg4ZaE0kQk1RB2KpwuXVcFNrMgNFMWXQ87bNU/VPH0=;
        b=E/K8rEtD7HOBL64OL6zdrRNpvlP6JBFlnxRWZmpEU6rdlUFihY/2L2xgQ7NZ8hHCTC
         hFVnZXTuPQ6jXl/rnxBs+2lnTBIJTl5mZEMwJ5aQDdgFWtpS1/wQ/WaEXxyhBb+1vstt
         D4wnP8g20vUyM6JJgX+rfjEtS0UmPgoGc+Dq7lFc1BOQeFNV+Dwv3rrYyPRKB+ONsd3n
         3JXXjAMteARsa6djr95aWc2YSL0hWYWQVA0JubyT+DRgufZB6OYQrtizp6vt39V8SZ6j
         tlSmVCacPs9jjTvU/8p8MpFcROjYwqdu/iziTdzCGPfveB0J/AMFlQNs3wQYHiZwexHF
         YkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759893510; x=1760498310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDg4ZaE0kQk1RB2KpwuXVcFNrMgNFMWXQ87bNU/VPH0=;
        b=b0InwjZeAZM8IMhASBOBNCb7NdOXbbpqhtIN2CwlQQ4Xka0K973qYgO6KsP9iFLWM/
         Z80u70krcinWrZR+qubob6eb7JaR17H+cOnyWh5OpwBSQjAPsyUueLR7s7tNJ1ZNLhA4
         uzCDUFvlpXgkdBvNP0dtAPVj+TMmELkYgVM6YCTlGisUpI/4hvg5WdfCCCm3oHifeDl+
         PSnBx/f9g4AGeMQBrOPEH1e5gMwimOS9UJ5gWvsZmlrpYp1+Hr4qw7qjjxfijBTRH310
         3Riybly371iiQifQKmn0sHzET/Zg/1v/wVXsmVACnL+TC2BbX/oT/1LnfUY38fsjgyFa
         R5XA==
X-Forwarded-Encrypted: i=1; AJvYcCVpNDR3/mdkcGut//pzYxVH08r1Mg68zJ8+uhtsaOTas3+9hme6ahYPhZct49dvMX9ere1XDbNN5MIdlbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS2/zv5aRC+LYISlkwNbsixoNymvf5MEyUnZeBE96tf54aZzC2
	nvOn9lVJM1AMy1z5YAtVNhGgIA7QVV0W2V7zAKvUAoR6W9e/VO88eqSo
X-Gm-Gg: ASbGncsQ4M7r8s7s7AavowoLYoehb8KqAaI+Fevul2AtemWseZnnKE3OxJtt/cuESiW
	LfgiBeUe8rZ7BXjOrIO7E3ogO5VGBNLMdHUDG0uwF8vuMVVWN9Sm+w6A1mBuGiSXZOWrfxhZYOc
	DAVnPcf6+xZ1JTllpt3dSvQvVNLRvmp1GIQlcjKErNWkoM845Bj2rjtWbeYjInnYHf8AAUa8ryh
	5wTNuWj1q38lwyZ7slkZg7Iwvfuy2i9hxT0/wq98A9h0KGmDMaAGlty3A0ccaOQv7eCCx/SZHEP
	TwRlsuKwo4IO93zHTbjkbxkYniaCGtdTs6D0xENTOlNDKdzgH3sU/q3t+I9EZSU+SFJh9GIqzy4
	X5oOdscU3G4Dkk09Bwsu8CuBIF/KXec/j+NOcarELuhYTWpV26A==
X-Google-Smtp-Source: AGHT+IG1UQCmaY8cs78qKrEmsXcpdVVL9Yje3K7pg4Yhi80RChazLD8kGiz5Ppw9B7HegArhgX/3FA==
X-Received: by 2002:a17:90b:3911:b0:338:2ef8:14af with SMTP id 98e67ed59e1d1-33b513bee03mr2184017a91.37.1759893509584;
        Tue, 07 Oct 2025 20:18:29 -0700 (PDT)
Received: from Ubuntu24.. ([103.187.64.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f5990csm16527746a12.38.2025.10.07.20.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 20:18:29 -0700 (PDT)
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
Subject: [PATCH v2 2/2] iio: health: max30100: Add pulse-width configuration via DT
Date: Wed,  8 Oct 2025 08:47:37 +0530
Message-ID: <20251008031737.7321-3-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008031737.7321-1-raskar.shree97@gmail.com>
References: <20251008031737.7321-1-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX30100 driver previously hardcoded the SPO2 pulse width to
1600us. This patch adds support for reading the pulse width from
device tree (`maxim,pulse-width-us`) and programming it into the SPO2
configuration register.

If no property is provided, the driver falls back to 1600us to
preserve existing behavior.

Testing:
Hardware: Raspberry Pi 3B + MAX30100 breakout
Verified DT property read in probe()
Confirmed SPO2_CONFIG register written correctly using regmap_read()

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>

Changes since v1:
Use FIELD_PREP() and define a pulse width bit mask.
Initialize default pulse_us before property read.
Use dev_err_probe() for error reporting.
Make pulse_width signed to handle negative return values.

Link to v1:
https://lore.kernel.org/all/20251004015623.7019-3-raskar.shree97@gmail.com/
---
 drivers/iio/health/max30100.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 814f521e47ae..50cd4fd13849 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2015, 2018
  * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  *
- * TODO: enable pulse length controls via device tree properties
  */
 
 #include <linux/module.h>
@@ -54,6 +53,10 @@
 #define MAX30100_REG_SPO2_CONFIG		0x07
 #define MAX30100_REG_SPO2_CONFIG_100HZ		BIT(2)
 #define MAX30100_REG_SPO2_CONFIG_HI_RES_EN	BIT(6)
+#define MAX30100_REG_SPO2_CONFIG_PW_MASK	GENMASK(1, 0)
+#define MAX30100_REG_SPO2_CONFIG_200US		0x0
+#define MAX30100_REG_SPO2_CONFIG_400US		0x1
+#define MAX30100_REG_SPO2_CONFIG_800US		0x2
 #define MAX30100_REG_SPO2_CONFIG_1600US		0x3
 
 #define MAX30100_REG_LED_CONFIG			0x09
@@ -306,19 +309,47 @@ static int max30100_led_init(struct max30100_data *data)
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
+	int pulse_width;
+	/* set default pulse-width-us to 1600us */
+	unsigned int pulse_us = 1600;
+	struct device *dev = &data->client->dev;
 
 	/* setup LED current settings */
 	ret = max30100_led_init(data);
 	if (ret)
 		return ret;
 
+	/* Read pulse-width-us from DT */
+	device_property_read_u32(dev, "maxim,pulse-width-us", &pulse_us);
+
+	pulse_width = max30100_get_pulse_width(pulse_us);
+	if (pulse_width < 0)
+		return dev_err_probe(dev, pulse_width, "invalid pulse-width %uus\n", pulse_us);
+
 	/* enable hi-res SPO2 readings at 100Hz */
 	ret = regmap_write(data->regmap, MAX30100_REG_SPO2_CONFIG,
 				 MAX30100_REG_SPO2_CONFIG_HI_RES_EN |
-				 MAX30100_REG_SPO2_CONFIG_100HZ);
+				 MAX30100_REG_SPO2_CONFIG_100HZ |
+				 FIELD_PREP(MAX30100_REG_SPO2_CONFIG_PW_MASK, pulse_width));
 	if (ret)
 		return ret;
 
-- 
2.43.0


