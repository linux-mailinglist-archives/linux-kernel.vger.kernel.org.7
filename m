Return-Path: <linux-kernel+bounces-889474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F21C3DB85
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C21234E75F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F92E354ACB;
	Thu,  6 Nov 2025 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baOr273e"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892393502A9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469984; cv=none; b=MBs1zfV+8/5gomUz39JwGU3RfomPO+pU0EoEs/G3eP++4WxrSp2BPspqydx86FUQtyXniwZJPpI7mHZ8V6DP6RiN9t1foid4bCQucO0C3xX+uHWIqwPQ/NWmgc8Gew+mPiCw17AAGOzUY9qRp6pf26jXppf5Y01lolG4FY70MhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469984; c=relaxed/simple;
	bh=ufIvFFHkbZ8SPrXnxKoHOjRLGsK5oIeuWrLoO3TsjPo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MC7v9EZZpto8yJzvRQSFD5yZeXl2vc1aNXqrB4ZjpWvWzq9B1dBv294LaXrsls+Zc2VmNAFwgsbx64NiY5vXG9vPT7lrZv22GQCO0dpM643yHPXV8C5sT0Ee2tHE/9QBwsBIRIrPOgiY7Vx6g8bTtq8oVO4FUbXFWsNtq0T+vQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baOr273e; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47754e9cc7fso855805e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 14:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762469981; x=1763074781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0nJS+a2wrY+OCu17/ASVfzPnVrSQorpggCTxleeXyA=;
        b=baOr273emL1VOWOYd5H2sLS5BkdoGrVcuq0yI/vbNulhl8W5DpxzvSlOhlgrtbYNIZ
         CCzYYtSCUTYNIP/5lyiSNTPvdHR3iN2bxaocUliaSwVCiuHdDPTVw2MrxftO3j5TiGHm
         jhU6sc2HJlJb9hLwRaDD8e/o4t/zv8zrwYRcA1NzjCqboo3QTayGef6qTRVuUYS/Vspl
         vCXGpF/Meg4W5RSfx3Nh+6YRWyK8waQNzjIDhiyYjfNsJ9kAT0Tj8r8eDM60ntW2BQzP
         3yGbymwXYlwiQAGmOlk/i3hsysW6xIw/5pjgu21gl+W/on/p7DPO8LlDd0A0t9d7Ylhb
         1mWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762469981; x=1763074781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E0nJS+a2wrY+OCu17/ASVfzPnVrSQorpggCTxleeXyA=;
        b=KeTNvPH3JiA53YN6sSfqsJV1TJPKPVD4//Okvf/xdSRBWIfOT0cydUzI2/9E/N5C1e
         TKhBQOCdrURj06UmBLeFWhT6ig0IvgQXPmUQGd9082KVp9pR0P0GMhuxfny3plqZ7a0B
         M/vVN0Doy591wCl7b8IghULruUGjokbKFSpTTt+AZ2FH8d3+TkKLSPQt7J6pmXGO0jYw
         jWQYPppII8JSzNS735YryrlLxf/i/RcCkrSy0GgQWPxZvgnr373UeaBgY/Tx9pav+CV2
         nQQ6ltSJ1Cyrif/gIDaaaRaXZI4j8TDpQ1sFAT7GLg02aLcctJiBwgs7mnLWM+l7uSKp
         oZdw==
X-Forwarded-Encrypted: i=1; AJvYcCWPguQOiDgtWlnewO6VoGD9ONkZqXUwwX4gp3wCcgynatVLq2Ea6+8hJdppnvNphLpgzzLofQQQ16qRjvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYAnBB8zlNPQp6llSaNQZlvK/Nb/ilh72OGW1ZFQ1PNHZ4+P49
	lME2mveVNFgjVNIR86FHGQdrDCucN9OtfTnqIRf6RxJDTMx46EYLzbXl
X-Gm-Gg: ASbGnctujNRSssecFwnBJhqUGegoXnYG6nSOvW76iYfMeeDoEeru8t5OdiLMIuz0zv7
	dXfk68OUu0SSkZYHCJJvItPk0qkesyAeLNOaUdcms2NB+6/JwBIHx7f8yOkSqbTsv6cofwvCDXO
	RZsztv7NAB9XL1qXa82vpl3a/VvnNlOBt5hO0G2Ne3gYCmHU/15bDCBfkDhD+VCz/+LG0ue3BV3
	/LTQsroIrqi0ixXT8qnjm4N8p7MwFmr+/oFlJN+M0twnZcqcqH7a8RbnR5uMjvsSpHqz68fGf3g
	mw3T4vKbiD0EISxySOUwZGKqHnFIMkSh6uEJK8BYJO4PqE5zwTSGTm039sDGEvqvIYEKZd4Rsi9
	A03qdV6u8pqTb0KP6dDcqSzyMWIniR7VbBvu7NbutziS7jesvnfRE91EcaFxjluPpkWkSXGR7Bc
	kssWosNwLxqsyTyeoJuXvsunWqGY1EQQ==
X-Google-Smtp-Source: AGHT+IGP5v4e7GyVgRGWXfvWoW/ZVT1r9DKTfFFQz7PGqnWFrENBgTn+y3PnZMBKWoKvJ7AofF4Vhg==
X-Received: by 2002:a05:600c:46ce:b0:475:da13:257c with SMTP id 5b1f17b1804b1-4776bcc369emr7344765e9.27.1762469980616;
        Thu, 06 Nov 2025 14:59:40 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42ac6794f63sm1640000f8f.42.2025.11.06.14.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 14:59:40 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 3/5] thermal/drivers: airoha: Generalize get_thermal_ADC and set_mux function
Date: Thu,  6 Nov 2025 23:59:12 +0100
Message-ID: <20251106225929.1778398-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106225929.1778398-1-ansuelsmth@gmail.com>
References: <20251106225929.1778398-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for support of Airoha AN7583, generalize
get_thermal_ADC() and set_thermal_mux() with the use of reg_field API.

This is to account the same logic between the current supported SoC and
the new one but with different register address.

While at it also further improve some comments and move sleep inside the
set_thermal_mux function.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 54 +++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index 864a01fd8fd8..a062922cb116 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -193,9 +193,18 @@
 
 #define AIROHA_MAX_SAMPLES			6
 
+enum airoha_thermal_chip_scu_field {
+	AIROHA_THERMAL_DOUT_TADC,
+	AIROHA_THERMAL_MUX_TADC,
+
+	/* keep last */
+	AIROHA_THERMAL_FIELD_MAX,
+};
+
 struct airoha_thermal_priv {
 	struct regmap *map;
 	struct regmap *chip_scu;
+	struct regmap_field *chip_scu_fields[AIROHA_THERMAL_FIELD_MAX];
 	struct resource scu_adc_res;
 
 	u32 pllrg_protect;
@@ -219,22 +228,29 @@ static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
 {
 	u32 val;
 
-	regmap_read(priv->chip_scu, EN7581_DOUT_TADC, &val);
-	return FIELD_GET(EN7581_DOUT_TADC_MASK, val);
+	regmap_field_read(priv->chip_scu_fields[AIROHA_THERMAL_DOUT_TADC],
+			  &val);
+	return val;
 }
 
-static void airoha_init_thermal_ADC_mode(struct airoha_thermal_priv *priv)
+static void airoha_set_thermal_mux(struct airoha_thermal_priv *priv,
+				   int tdac_idx)
 {
-	u32 adc_mux, pllrg;
+	u32 pllrg;
 
 	/* Save PLLRG current value */
 	regmap_read(priv->chip_scu, EN7581_PLLRG_PROTECT, &pllrg);
 
-	/* Give access to thermal regs */
+	/* Give access to Thermal regs */
 	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT,
 		     priv->pllrg_protect);
-	adc_mux = FIELD_PREP(EN7581_MUX_TADC, EN7581_SCU_THERMAL_MUX_DIODE1);
-	regmap_write(priv->chip_scu, EN7581_PWD_TADC, adc_mux);
+
+	/* Configure Thermal ADC mux to tdac_idx */
+	regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_TADC],
+			   tdac_idx);
+
+	/* Sleep 10 ms for Thermal ADC to enable */
+	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
 
 	/* Restore PLLRG value on exit */
 	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, pllrg);
@@ -343,10 +359,8 @@ static void en7581_thermal_setup_adc_val(struct device *dev,
 {
 	u32 efuse_calib_info, cpu_sensor;
 
-	/* Setup thermal sensor to ADC mode and setup the mux to DIODE1 */
-	airoha_init_thermal_ADC_mode(priv);
-	/* sleep 10 ms for ADC to enable */
-	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
+	/* Setup Thermal Sensor to ADC mode and setup the mux to DIODE1 */
+	airoha_set_thermal_mux(priv, EN7581_SCU_THERMAL_MUX_DIODE1);
 
 	regmap_read(priv->map, EN7581_EFUSE_TEMP_OFFSET_REG, &efuse_calib_info);
 	if (efuse_calib_info) {
@@ -429,13 +443,18 @@ static const struct regmap_config en7581_thermal_regmap_config = {
 	.val_bits		= 32,
 };
 
+static const struct reg_field en7581_chip_scu_fields[AIROHA_THERMAL_FIELD_MAX] = {
+	[AIROHA_THERMAL_DOUT_TADC] = REG_FIELD(EN7581_DOUT_TADC, 0, 15),
+	[AIROHA_THERMAL_MUX_TADC] = REG_FIELD(EN7581_PWD_TADC, 1, 3),
+};
+
 static int en7581_thermal_probe(struct platform_device *pdev,
 				struct airoha_thermal_priv *priv)
 {
 	struct device_node *chip_scu_np;
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
-	int irq, ret;
+	int i, irq, ret;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -454,6 +473,17 @@ static int en7581_thermal_probe(struct platform_device *pdev,
 	if (IS_ERR(priv->chip_scu))
 		return PTR_ERR(priv->chip_scu);
 
+	for (i = 0; i < AIROHA_THERMAL_FIELD_MAX; i++) {
+		struct regmap_field *field;
+
+		field = devm_regmap_field_alloc(dev, priv->chip_scu,
+						en7581_chip_scu_fields[i]);
+		if (IS_ERR(field))
+			return PTR_ERR(field);
+
+		priv->chip_scu_fields[i] = field;
+	}
+
 	of_address_to_resource(chip_scu_np, 0, &priv->scu_adc_res);
 	of_node_put(chip_scu_np);
 
-- 
2.51.0


