Return-Path: <linux-kernel+bounces-889476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E964C3DB99
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1885D3A420A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3EA3502A9;
	Thu,  6 Nov 2025 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQxsApTb"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F9355035
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469987; cv=none; b=P1ht5ii5x+t8gs5Iltf6nCXOLds3wg5zyy4J45wogNr8UL4z9SaFNidX/NwkxWlSCZsD+5d/Ory1WjmiweEeJoTHL+My9lgz7FWRd/nX8rgip/1NLwYKX9HQceOWVsf8z1vKW+N3NUIjpX2JrI/DFsHIk1FWBwpaXRCRFQKFDS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469987; c=relaxed/simple;
	bh=b+MSBxV5Mft7tnlCEnM4CK9pEtwgD/mLZOO0TRxa2ek=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8dy4tGMXTqupLIkcchgr45ZO9bfk/PiiVUrXwUSKjT0HwNFGhagcXCyc4JVO0vfx5urdG94fjFrY+QlahfojE620q1mrfm56csYDMC+zybjz1oF7xoWDyHT5ZMWnzSHODaXr8xcFe2SZDMAoH/3sPS+wq/ZlFzShgVjo/0/eE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQxsApTb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47112a73785so743065e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 14:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762469984; x=1763074784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMsSmseR9QHY+HZa+ss2GWQw1aiE3hwhHgWcJtl8K7g=;
        b=JQxsApTbHX3F9TsCWN4TkPUlM7q+RfRmqlSlUdhJRTv+6Etp8r9wtvVNVofxlKDab+
         1ZND1YdX+vLXbOmDhMt/SUeqQFTO49M3RoktCbnZjD7koB3wE2DNoqKjtL0IBYgsa4I2
         sKaQMRMQVDuGVGx+Bug9eRzCD86A2HcbbTcpt8BXlz4IasDGTMU8OWrkbWL61FyTMCTP
         J+tRedxf0ZEUALTBx/rB8ncwIIndNn7jxCf0E9rR/XD3xdAOhzky1boKNtP8kb5mPDIY
         M/iu8VnfaBe1Kl3uQWGBjXQV3PO1zhbojCHxyTurbhFdkmy8X7o9KArVmADn1Na5yE0q
         oq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762469984; x=1763074784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oMsSmseR9QHY+HZa+ss2GWQw1aiE3hwhHgWcJtl8K7g=;
        b=D1n+YMWEn5Q4q2zqBL9eVqvWBdy/+TNBW36ENbLuCF8qvlUrdvb+UeIBlE/O3zhNMa
         2BsXtT8lmfs7be0L+ULgSNu8Sbjgdde+MsHobwvk6SQ3eSsVquvqOLKJappffoVlViv+
         DMJezxd7VQF/ZwBS50s3uo3DIH1hLtW9DxdXvCq6IzTzp4uvEaqpLMAWMYIjzF7pbBm9
         Q2m2q2XqNfAFa4tAsdo0oXYg7wEMRcM4UCXMYIwu9YmNtOAB0jRxS+6YwidKqwmFJuhf
         27ce7xbDyszSx4XuY2as/r99i0XqkbqGTZMgPOCmIE627XPxbqYS2I4CuTooabkFqmep
         QXIg==
X-Forwarded-Encrypted: i=1; AJvYcCWwC9+UT1Bxa2Dgd3kcy/pqPNUMS375ZoQg8QDAwlF/OeHBSl+tgMxQNsSOlCpm3u0kCJwYHu9qUlk4yro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQLJcqku/bQVRjl3fR2OHpmDe7FDK7INmHvtVxQLk0FdUdoeQ8
	vTWKwAC5voRPpFfFffJiPnjunYUV50PLfY0q7AIoRK28DnRfXMCGQ4I5
X-Gm-Gg: ASbGnctj90sS72DS2DzcLBMe9cGxSVEMCCdAHT1XKsW+1U0BRD1q/HfMboIDqp68+IM
	w/imL2nTbyhA9NwcFIkIUNKrbtNkmyyPFh0jroFEtGJuLmxNxxaueRPyyAgR96gphmClJLuDU4T
	NZA/hJhROAuFN1hd4/k1XK1VzaswWaaN8s9Qotc0zKtLbMo6+BShVuy1yy86CkoBSKSR83A98lC
	BXVNYgvzv6Ej2GZl5B+9njYOaoiOtOpBVBH5iVJasxkHSXZ7WhsPqW/r06VS3hnT4NmQtaFTgjo
	18CdvI1wk2RJ/hU8VSjiiZ59zs4PzOmKp1GbeD1Z46G/NH58/TM2bQrVqFbd1Ba+XMOVK5vegMG
	WJoWVH4t5bN/S3zQAWkBaD0P4E8jHI0QDu3vu76ZKh12nJ5toD87IhPEw/om2c2pq06YDLARdc4
	0VebgOAT9jM0PJI1Pc1MLAntPnn4vTJA==
X-Google-Smtp-Source: AGHT+IHkk3R9oebXFo4lLMo9Gkif1lXQaXrfZ/UrpasowwO7k0I79dLv8Iz0jVn90sCMyMCkllA9JQ==
X-Received: by 2002:a05:600c:1d0d:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-4776bcc3c58mr6660315e9.18.1762469984018;
        Thu, 06 Nov 2025 14:59:44 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42ac6794f63sm1640000f8f.42.2025.11.06.14.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 14:59:43 -0800 (PST)
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
Subject: [PATCH v3 5/5] thermal/drivers: airoha: Add support for AN7583 Thermal Sensor
Date: Thu,  6 Nov 2025 23:59:14 +0100
Message-ID: <20251106225929.1778398-6-ansuelsmth@gmail.com>
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

Add support for Airoha AN7583 Thermal driver. This apply similar logic
on how to read the temperature but totally drop support for the
PTP_THERMAL subsystem. PTP_THERMAL subsystem was a way to trigger trip
point from hardware by configuring how to read the temperature
internally.

This subsystem has been totally removed from Airoha AN7583 permitting
only to read the temperature.

The SoC support up to 3 sensor but the original driver always read the
BGA sensor hence it's currently implemented reading only this specific
sensor. Reference and values for the other 2 sensor are defined for
further implementation if confirmed working.

set_thermal_mux() is extended to also address muxing the sensor as
AN7583 use a different way to read the temperature from 3 different
diode. The EN7581 code is updated to account for these changes.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/airoha_thermal.c | 158 ++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
index a062922cb116..c190b696d3a8 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -18,6 +18,12 @@
 #define EN7581_DOUT_TADC			0x2f8
 #define   EN7581_DOUT_TADC_MASK			GENMASK(15, 0)
 
+#define AN7583_MUX_SENSOR			0x2a0
+#define   AN7583_LOAD_ADJ			GENMASK(3, 2)
+#define AN7583_MUX_TADC				0x2e4
+#define   AN7583_MUX_TADC_MASK			GENMASK(3, 1)
+#define AN7583_DOUT_TADC			0x2f0
+
 /* PTP_THERMAL regs */
 #define EN7581_TEMPMONCTL0			0x800
 #define   EN7581_SENSE3_EN			BIT(3)
@@ -181,6 +187,11 @@
 #define EN7581_SCU_THERMAL_PROTECT_KEY		0x12
 #define EN7581_SCU_THERMAL_MUX_DIODE1		0x7
 
+#define AN7583_SCU_THERMAL_PROTECT_KEY		0x80
+#define AN7583_NUM_SENSOR			3
+
+#define AIROHA_THERMAL_NO_MUX_SENSOR		-1
+
 /* Convert temp to raw value as read from ADC	((((temp / 100) - init) * slope) / 1000) + offset */
 #define TEMP_TO_RAW(priv, temp)			((((((temp) / 100) - (priv)->init_temp) * \
 						  (priv)->default_slope) / 1000) + \
@@ -193,8 +204,39 @@
 
 #define AIROHA_MAX_SAMPLES			6
 
+/*
+ * AN7583 supports all these ADC mux but the original driver
+ * always checked temp with the AN7583_BGP_TEMP_SENSOR.
+ * Assume using the other sensor temperature is invalid and
+ * always read from AN7583_BGP_TEMP_SENSOR.
+ *
+ * On top of this it's defined that AN7583 supports 3
+ * sensor: AN7583_BGP_TEMP_SENSOR, AN7583_GBE_TEMP_SENSOR,
+ * AN7583_CPU_TEMP_SENSOR.
+ *
+ * Provide the ADC mux for reference.
+ */
+enum an7583_thermal_adc_mux {
+	AN7583_BGP_TEMP_SENSOR,
+	AN7583_PAD_AVS,
+	AN7583_CORE_POWER,
+	AN7583_AVSDAC_OUT,
+	AN7583_VCM,
+	AN7583_GBE_TEMP_SENSOR,
+	AN7583_CPU_TEMP_SENSOR,
+
+	AN7583_ADC_MUX_MAX,
+};
+
+enum an7583_thermal_diode_mux {
+	AN7583_D0_TADC,
+	AN7583_ZERO_TADC,
+	AN7583_D1_TADC,
+};
+
 enum airoha_thermal_chip_scu_field {
 	AIROHA_THERMAL_DOUT_TADC,
+	AIROHA_THERMAL_MUX_SENSOR,
 	AIROHA_THERMAL_MUX_TADC,
 
 	/* keep last */
@@ -208,6 +250,7 @@ struct airoha_thermal_priv {
 	struct resource scu_adc_res;
 
 	u32 pllrg_protect;
+	int current_adc;
 
 	struct thermal_zone_device *tz;
 	int init_temp;
@@ -224,6 +267,24 @@ struct airoha_thermal_soc_data {
 	int (*post_probe)(struct platform_device *pdev);
 };
 
+static const unsigned int an7583_thermal_coeff[AN7583_ADC_MUX_MAX] = {
+	[AN7583_BGP_TEMP_SENSOR] = 973,
+	[AN7583_GBE_TEMP_SENSOR] = 995,
+	[AN7583_CPU_TEMP_SENSOR] = 1035,
+};
+
+static const unsigned int an7583_thermal_slope[AN7583_ADC_MUX_MAX] = {
+	[AN7583_BGP_TEMP_SENSOR] = 7440,
+	[AN7583_GBE_TEMP_SENSOR] = 7620,
+	[AN7583_CPU_TEMP_SENSOR] = 8390,
+};
+
+static const unsigned int an7583_thermal_offset[AN7583_ADC_MUX_MAX] = {
+	[AN7583_BGP_TEMP_SENSOR] = 294,
+	[AN7583_GBE_TEMP_SENSOR] = 298,
+	[AN7583_CPU_TEMP_SENSOR] = 344,
+};
+
 static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
 {
 	u32 val;
@@ -234,7 +295,7 @@ static int airoha_get_thermal_ADC(struct airoha_thermal_priv *priv)
 }
 
 static void airoha_set_thermal_mux(struct airoha_thermal_priv *priv,
-				   int tdac_idx)
+				   int tdac_idx, int sensor_idx)
 {
 	u32 pllrg;
 
@@ -245,9 +306,20 @@ static void airoha_set_thermal_mux(struct airoha_thermal_priv *priv,
 	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT,
 		     priv->pllrg_protect);
 
+	/*
+	 * Configure Thermal Sensor mux to sensor_idx.
+	 * (if not supported, sensor_idx is AIROHA_THERMAL_NO_MUX_SENSOR)
+	 */
+	if (sensor_idx != AIROHA_THERMAL_NO_MUX_SENSOR)
+		regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_SENSOR],
+				   sensor_idx);
+
 	/* Configure Thermal ADC mux to tdac_idx */
-	regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_TADC],
-			   tdac_idx);
+	if (priv->current_adc != tdac_idx) {
+		regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_TADC],
+				   tdac_idx);
+		priv->current_adc = tdac_idx;
+	}
 
 	/* Sleep 10 ms for Thermal ADC to enable */
 	usleep_range(10 * USEC_PER_MSEC, 11 * USEC_PER_MSEC);
@@ -360,7 +432,8 @@ static void en7581_thermal_setup_adc_val(struct device *dev,
 	u32 efuse_calib_info, cpu_sensor;
 
 	/* Setup Thermal Sensor to ADC mode and setup the mux to DIODE1 */
-	airoha_set_thermal_mux(priv, EN7581_SCU_THERMAL_MUX_DIODE1);
+	airoha_set_thermal_mux(priv, EN7581_SCU_THERMAL_MUX_DIODE1,
+			       AIROHA_THERMAL_NO_MUX_SENSOR);
 
 	regmap_read(priv->map, EN7581_EFUSE_TEMP_OFFSET_REG, &efuse_calib_info);
 	if (efuse_calib_info) {
@@ -476,6 +549,10 @@ static int en7581_thermal_probe(struct platform_device *pdev,
 	for (i = 0; i < AIROHA_THERMAL_FIELD_MAX; i++) {
 		struct regmap_field *field;
 
+		/* Skip registering MUX_SENSOR field as not supported */
+		if (i == AIROHA_THERMAL_MUX_SENSOR)
+			continue;
+
 		field = devm_regmap_field_alloc(dev, priv->chip_scu,
 						en7581_chip_scu_fields[i]);
 		if (IS_ERR(field))
@@ -516,6 +593,71 @@ static int en7581_thermal_post_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int an7583_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct airoha_thermal_priv *priv = thermal_zone_device_priv(tz);
+	int sensor_idx;
+	int delta_diode, delta_gain;
+	int coeff, slope, offset;
+
+	int diode_zero, diode_d0, diode_d1;
+
+	/* Always read sensor AN7583_BGP_TEMP_SENSOR */
+	sensor_idx = AN7583_BGP_TEMP_SENSOR;
+
+	coeff = an7583_thermal_coeff[sensor_idx];
+	slope = an7583_thermal_slope[sensor_idx];
+	offset = an7583_thermal_offset[sensor_idx];
+
+	airoha_set_thermal_mux(priv, sensor_idx, AN7583_ZERO_TADC);
+	diode_zero = airoha_get_thermal_ADC(priv);
+	airoha_set_thermal_mux(priv, sensor_idx, AN7583_D0_TADC);
+	diode_d0 = airoha_get_thermal_ADC(priv);
+	airoha_set_thermal_mux(priv, sensor_idx, AN7583_D1_TADC);
+	diode_d1 = airoha_get_thermal_ADC(priv);
+
+	delta_diode = diode_d1 - diode_d0;
+	delta_gain = (delta_diode * coeff) / 100 + (diode_zero - diode_d1);
+	*temp = (slope * delta_diode * 10) / delta_gain - offset * 10;
+	*temp *= 100;
+
+	return 0;
+}
+
+static const struct thermal_zone_device_ops an7583_tz_ops = {
+	.get_temp = an7583_thermal_get_temp,
+};
+
+static const struct reg_field an7583_chip_scu_fields[AIROHA_THERMAL_FIELD_MAX] = {
+	[AIROHA_THERMAL_DOUT_TADC] = REG_FIELD(AN7583_DOUT_TADC, 0, 31),
+	[AIROHA_THERMAL_MUX_TADC] = REG_FIELD(AN7583_MUX_TADC, 1, 3),
+	[AIROHA_THERMAL_MUX_SENSOR] = REG_FIELD(AN7583_MUX_SENSOR, 2, 3),
+};
+
+static int an7583_thermal_probe(struct platform_device *pdev,
+				struct airoha_thermal_priv *priv)
+{
+	struct device *dev = &pdev->dev;
+	int i;
+
+	priv->chip_scu = device_node_to_regmap(dev->of_node);
+	if (IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
+
+	for (i = 0; i < AIROHA_THERMAL_FIELD_MAX; i++) {
+		struct regmap_field *field;
+
+		field = devm_regmap_field_alloc(dev, priv->chip_scu,
+						an7583_chip_scu_fields[i]);
+		if (IS_ERR(field))
+			return PTR_ERR(field);
+
+		priv->chip_scu_fields[i] = field;
+	}
+
+	return 0;
+}
+
 static int airoha_thermal_probe(struct platform_device *pdev)
 {
 	const struct airoha_thermal_soc_data *soc_data;
@@ -530,6 +672,7 @@ static int airoha_thermal_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->pllrg_protect = soc_data->pllrg_protect;
+	priv->current_adc = -1;
 
 	if (!soc_data->probe)
 		return -EINVAL;
@@ -558,8 +701,15 @@ static const struct airoha_thermal_soc_data en7581_data = {
 	.post_probe = &en7581_thermal_post_probe,
 };
 
+static const struct airoha_thermal_soc_data an7583_data = {
+	.pllrg_protect = AN7583_SCU_THERMAL_PROTECT_KEY,
+	.thdev_ops = &an7583_tz_ops,
+	.probe = &an7583_thermal_probe,
+};
+
 static const struct of_device_id airoha_thermal_match[] = {
 	{ .compatible = "airoha,en7581-thermal", .data = &en7581_data },
+	{ .compatible = "airoha,an7583-chip-scu", .data = &an7583_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, airoha_thermal_match);
-- 
2.51.0


