Return-Path: <linux-kernel+bounces-812643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A308B53AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09F916DB5E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1F636808D;
	Thu, 11 Sep 2025 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEA3AN+U"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EA3362985
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613441; cv=none; b=X4w62y1Q2LXFKaepHt1SCJ6hlJpYCE/7Bo7XSjiaOko3Y/3nEP/dn+SIlzul9c2PCE9eDHIiYd1Jqcx+3oX58bhIh3peNiElSZwEshNISGb2eFut7RZJbY0Z0hL7EKssb+DM0mhHWVQpyvgsdQK36qX0wqRWxw6YSCWpUfQDMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613441; c=relaxed/simple;
	bh=0oqeEqIjS3+OtMIvtyosNybEOk1gpo3FJfz9EF2M1t0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PATdUhY38FkTfHrDPDDcyVLgUD/0Vez9K22CYRPhq3jn+hLGJXxsZz9uP+ECFqc+anTn/K4ZE/lXB6c9cBwhI8PgP0Th+Z3jYND+p8Uv1nEGR0Pj5UA/zOgLL14b093LMIwidG6vBrTXIolUC8B51g/qoBPHhg61xuFZC6eSbFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEA3AN+U; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b043a33b060so154052966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757613437; x=1758218237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OT8QGzf3PZ88uIRwWvPBWTj8UBsZ2B/sy/goy6AP/4=;
        b=hEA3AN+UnlybOTZFF8JjGt8aw+7c308ouXz2lIAfr+A4BHIj8y0lXSes+MACdDNtFO
         /mwCGEkC/NbUpZx2QC82iIE4tiMTIyGydsSRW5JbNqq2g1TrAvb/jbw5QwN+nFbA50C0
         9YJQc37T9/Yz8CGVYP0e4cBsxIw9siYxOid0x1qmiCTdETpzT/it0dF+EcrXxnQo1jp9
         9hb1J+V/7q9VaYu5sSTxY3/dBlF80H/Z+wdKJ3c42xqMPYlZRJoNfDIJ9l0Mk9rOpPdL
         3PRAMLyuHGzg/Q4ecA9D7FplDIaGBQuBetOf/pekHOhSTFUROpNSSR71rBdNyYDKdRoF
         2IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757613437; x=1758218237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OT8QGzf3PZ88uIRwWvPBWTj8UBsZ2B/sy/goy6AP/4=;
        b=kPZTjBfs9DpUOiLMoRBOLRpkh4YyHdQb8wr7gJJDUXRX0Xea0iYePNNg0B8fGlVFk6
         Tr1VcEH9K6PSe1n2S37DzpbROWp9Bcr0BLPzAvMMwXzVx8I93Yo0tUVYYI4exCyMEu5i
         I8JvHZslC1Gd76MP1cbmVkkyOJkX8C8Nf+4a0BcSHNLymCSJQPYqNAIVVMWGMLG3vqfx
         VI1jdE2yVSOKw9tnKp3MzOaLGU/c6Sb32mKQZaXLX0XYgWu9TXl+w1ouWbzc2niMeMJP
         knCHllt4zz2Qzaxl8MH3zE5C8D8vI3WYSr/7S4JWBxDMDNti306TzrOnz7r09fPkARCF
         /Siw==
X-Forwarded-Encrypted: i=1; AJvYcCU4eVeBrHx7Xyhch6Q91oD0/DFX4ac6NMuc+bM2QF51V0xNHcF+jif4UFE2Kzp3g3o6GCoajMLiX6bODpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoampKZYvUTuWKGiPSilmRWfoBC7ay5lknkwrWYTptQ5LIX1Vj
	HQD8LtEdazRZ8gfOgXe2lLSPTGrfIogAUbEHwzRESbJK5ReBLxGD7J9u
X-Gm-Gg: ASbGncvuPOsMPbr7OTPYa39/pZlEB7LjLUHOlquEfDkavwXdXUpyMqwcq//9qr//uEv
	2Qs4P7NJX39HQxCPFQlM8vDko9EDixc/beeUylaHJaTZyyrHKQpKEGeQU1k97rrbE9a0N9q20p5
	FNRH2TbVwtqJvfeRGqmIye7fO59d4a9FuKfouZ5ihiNtUF7bwJnzK9ha6euBlRDlTGXQ1kQrvUn
	O3Elohea0+PlFZ+Qe5PZ5jXmH0ntu+khNd9fvrFhTkc5mF7QWhd2lyrfBoLnsaf5hvTo1789S/C
	OO7Q/XyPF7oQenXhHPa3I0xMn3ggoWbjEDUuNcpYoxS5IgYQp6tlgbq86oMR/gDYLBSBTC6i0At
	quYy402FSlyyXXgKlzqfAr0FQR+ckWb4=
X-Google-Smtp-Source: AGHT+IHcB3VJfVSqFO+IQDoD/DkmwRlneij9GFUJhER0DABlY5Ut8tkco0VruhzAwkhyNhWMeVjtHg==
X-Received: by 2002:a17:907:3c91:b0:b04:3fe2:23c4 with SMTP id a640c23a62f3a-b07c3570b05mr3439866b.19.1757613437050;
        Thu, 11 Sep 2025 10:57:17 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07b312845esm171377166b.26.2025.09.11.10.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 10:57:16 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 11 Sep 2025 20:57:09 +0300
Subject: [PATCH v3 1/9] power: supply: max77705_charger: move active
 discharge setting to mfd parent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-max77705_77976_charger_improvement-v3-1-35203686fa29@gmail.com>
References: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
In-Reply-To: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757613433; l=1767;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=0oqeEqIjS3+OtMIvtyosNybEOk1gpo3FJfz9EF2M1t0=;
 b=B/Q66IUSa48NczLTFDY4T8H/Xx4wfHbYzK5h3esTvmf6+OxDBqRcT5X4oXe11ej8JGKWdC+Ug
 OPNSLLjUPJkD0n7R5G2zi8xP9TfI9R1NtqGRExPn3Veg4710ztLiJTN
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Active discharge setting is a part of MFD top level i2c device, hence
cannot be controlled by charger. Writing to MAX77705_PMIC_REG_MAINCTRL1
register from charger driver is a mistake.

Move active discharge setting to MFD parent driver.

Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/mfd/max77705.c                  | 3 +++
 drivers/power/supply/max77705_charger.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
index 6b263bacb8c2..ff07d0e0d5f8 100644
--- a/drivers/mfd/max77705.c
+++ b/drivers/mfd/max77705.c
@@ -108,6 +108,9 @@ static int max77705_i2c_probe(struct i2c_client *i2c)
 	if (pmic_rev != MAX77705_PASS3)
 		return dev_err_probe(dev, -ENODEV, "Rev.0x%x is not tested\n", pmic_rev);
 
+	/* Active Discharge Enable */
+	regmap_update_bits(max77705->regmap, MAX77705_PMIC_REG_MAINCTRL1, 1, 1);
+
 	ret = devm_regmap_add_irq_chip(dev, max77705->regmap,
 					i2c->irq,
 					IRQF_ONESHOT | IRQF_SHARED, 0,
diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 329b430d0e50..3b75c82b9b9e 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -487,9 +487,6 @@ static void max77705_charger_initialize(struct max77705_charger_data *chg)
 	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_00,
 				MAX77705_WDTEN_MASK, 0);
 
-	/* Active Discharge Enable */
-	regmap_update_bits(regmap, MAX77705_PMIC_REG_MAINCTRL1, 1, 1);
-
 	/* VBYPSET=5.0V */
 	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_11, MAX77705_VBYPSET_MASK, 0);
 

-- 
2.39.5


