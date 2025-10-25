Return-Path: <linux-kernel+bounces-869767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FF2C08B0E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 06:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FAA4042A1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 04:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82F5285C99;
	Sat, 25 Oct 2025 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/aiqgIZ"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F07274646
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761366793; cv=none; b=hw0h408ENFTd4iRm86NlcmZUKPlpTl3itD+8cyfJVGIFgHSLzGotysoQGfb8Ixb2nz4Eu5eRYj0nMAmd7BvXgjVuZqbD90bX6wYCeT5qecCuzRDykTaovnkwAIgWTwG6OXgQo0DHwoFsPnVdDGEpOfJaoTtbKbfPXDOqlT/7Szs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761366793; c=relaxed/simple;
	bh=vKwIkRtVEbLiJY2BlW4E9oyIfD48LqL7a3hDQ3iAOsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PP6GjYAIPSCQz1jjL/KO9exdSHNwlIX0NohpMlR/15KUliJVPSkRtzVQ1/ca49dk6PuR6DM4B3vFoWPYFWBAlHUEat5vbXfdGqY0C5k1S/xLbZC6AbKrbIG3py3R5Fg6AkLwh9vY2yHjzv1GjryJzvLYpUxNvAUBp3FTkvg3C80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/aiqgIZ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-362acd22c78so24656521fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761366790; x=1761971590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpucFmLklCdqMhA9C9XyPHvfCwLqk6dMk7FGikdB0lU=;
        b=I/aiqgIZzf1+H/rfKheCJ5WcvKaTX0yc90/N4AmXtWycpheIw5SkaZcqhujrOPNV6w
         2LsduEBQTtzysaBX+uU8zEY16HqiRk0OwD0Tm0KTyfbkljqFpiEPp0oILMG7jDsCP7z/
         oV5yiruFkepNsm6ctESclmaqgFqe2ML1F3fnjcfgwsUD55h3QTEkacXyzvUsxHmryTJu
         SCmMD7ioVbOYjpVCvH7PcXmyFLv9JrvoUPjp5ahdPW+9MAB0zAWz6OdQQftw631Z9zYZ
         9iSh3BN7l+GMgIt8U4Qln/em7WnHncpW9fTGM0Xhthr5dK+6V537ZQ32t+dfncTMlHZV
         9TEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761366790; x=1761971590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpucFmLklCdqMhA9C9XyPHvfCwLqk6dMk7FGikdB0lU=;
        b=KrhsqVmQXmNKmt0B73cxGQOPa0834YTs5eZrerUOky0744YkIbo9NgjB76yeSlR1f9
         znfKDQ7Nir31C85CksTZ3N5ofxDr4lwV9c9CWl/ko7bvvAX867ac3zrXHRUVRbcKRhl/
         dw1hP1u+4LBsIOyIhcVM6KFjhDyBgIKwNqBx7Y69hcsOMa7KN8mOVzf5t45Z7S0ecvk0
         1sy2GAeVagqADHQdWUaQZF9t/ngLezz9hwW1I+n8v/ah1Vxkdo5PEhahxEwpJ4Wg7/Mv
         /yM2gbHZeU1ErI3atr32eCOlnNADVSqh5I5Rjl0rQnSwGHWxhEjAMWaWVnKmmiLtJ1f1
         1OuA==
X-Forwarded-Encrypted: i=1; AJvYcCUq+BlHJenAWzVWR7vwhDcjpKrx81oxy7ahPgnRNrj+RWE8hcI4/h78q+VnwduTWjH//mWO3yGeUhSHA5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdV0mFV2nltGycs/1U8bilcZurrE8bb1DAYPIRWCxSqq0YOj7C
	PTSLT62CNC2IEWI3bnxlNZJ0p2MIcvyHM8k8Yml1GRliC4y2vgbCbYc8
X-Gm-Gg: ASbGnctJh6fn107QfDZecdDPIYIJ6fDefKcU9Rp0o+TrADv0jNiEVZsGvuij+3szwIF
	Q9IlP9hGBO4Ms0BC4L/S11BFTqPA/MZmUuB+ezZHYdmMdI35+QPWrVyzMF3VU57DE4TFRPtuc8R
	kwWJjotO3ukZiW1Yx9ghRFcynAZein3e6JM/RWs2yB6xtN0Wd+rqlPRVGZkDGnzpNobFO37wDZT
	e9H1C/hsMySexJNQrbbTdaYp7NXuGoXl1CNHh/6JsdrI5xr9O8tq8n8TSWLkefUfDyHWcyinbyV
	0EDA4Y0c8SLdc4k4lkIMVvhcf5B3P2iGu+9aI+j8MGsETkhlL5s9wiVUB9quRQKPTnfl0yKcCX0
	Rx6le89Pj1jaRvIHSub5dTlmYyuM7ncTDI/k+nWJQU7YKyYgkgtCOAAp7b1CKiDCIHaU1nFjIaA
	Tn
X-Google-Smtp-Source: AGHT+IGI1bkGkIs+m+mcDg1QheXEpjkKTfwp/CVg0HfjhPonvg/HY7Zg24J0VSwSVIiajjlFuNgFMg==
X-Received: by 2002:a05:651c:150c:b0:378:e58f:5f10 with SMTP id 38308e7fff4ca-378e58f613dmr12893371fa.35.1761366789881;
        Fri, 24 Oct 2025 21:33:09 -0700 (PDT)
Received: from junAIR ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0ca7a0sm3409241fa.33.2025.10.24.21.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 21:33:09 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
Date: Sat, 25 Oct 2025 12:31:28 +0800
Message-ID: <20251025043129.160454-6-iuncuim@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025043129.160454-1-iuncuim@gmail.com>
References: <20251025043129.160454-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The A523 processor has two temperature controllers, THS0 and THS1.

THS0 has only one temperature sensor, which is located in the DRAM.

THS1 does have 3 sensors:
ths1_0 - "big" cores
ths1_1 - "little" cores
ths1_2 - gpu

The datasheet mentions a fourth sensor in the NPU, but lacks any registers
for operation other than calibration registers. The vendor code reads the
value from ths1_2, but uses separate calibration data, so we get two
different values from real one.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 133 ++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index d6d8e13e5..7d35ea3c4 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -59,6 +59,12 @@
 #define SUN50I_H6_THS_PC_TEMP_PERIOD(x)		((GENMASK(19, 0) & (x)) << 12)
 #define SUN50I_H6_THS_DATA_IRQ_STS(x)		BIT(x)
 
+#define SUN55I_A523_DELIMITER			0x7c8
+#define SUN55I_A523_OFFSET_ABOVE		2736
+#define SUN55I_A523_OFFSET_BELOW		2825
+#define SUN55I_A523_SCALE_ABOVE			74
+#define SUN55I_A523_SCALE_BELOW			65
+
 struct tsensor {
 	struct ths_device		*tmdev;
 	struct thermal_zone_device	*tzd;
@@ -116,6 +122,15 @@ static int sun50i_h5_calc_temp(struct ths_device *tmdev,
 		return -1590 * reg / 10 + 276000;
 }
 
+static int sun55i_a523_calc_temp(struct ths_device *tmdev,
+				 int id, int reg)
+{
+	if (reg >= SUN55I_A523_DELIMITER)
+		return SUN55I_A523_SCALE_ABOVE * (SUN55I_A523_OFFSET_ABOVE - reg);
+	else
+		return SUN55I_A523_SCALE_BELOW * (SUN55I_A523_OFFSET_BELOW - reg);
+}
+
 static int sun8i_ths_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct tsensor *s = thermal_zone_device_priv(tz);
@@ -301,6 +316,97 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 	return 0;
 }
 
+/*
+ * The A523 nvmem calibration values. The ths1_3 is not used as it
+ * doesn't have its own sensor and doesn't have any internal switch.
+ * Instead, the value from the ths1_2 sensor is used, which gives the
+ * illusion of an independent sensor for NPU and GPU when using
+ * different calibration values.
+ *
+ * efuse layout 0x38-0x3F (caldata[0..3]):
+ *     caldata[0]      caldata[1]      caldata[2]      caldata[3]
+ * 0               16      24      32  36          48          60 64
+ * +---------------+---------------+---------------+---------------+
+ * |               |       |   temp    |  ths1_0   |  ths1_1   |   +
+ * +---------------+---------------+---------------+---------------+
+ *
+ * efuse layout 0x44-0x4B (caldata[4..7]):
+ *     caldata[4]      caldata[5]      caldata[6]      caldata[7]
+ * 0           12  16      24      32  36          48             64
+ * +---------------+---------------+---------------+---------------+
+ * |  ths1_2   |  ths1_3   |    ths0   |           |               +
+ * +---------------+---------------+---------------+---------------+
+ */
+static int sun55i_a523_ths_calibrate(struct ths_device *tmdev,
+				     u16 *caldata, int callen)
+{
+	struct device *dev = tmdev->dev;
+	int i, ft_temp;
+
+	if (!caldata[0])
+		return -EINVAL;
+
+	ft_temp = (((caldata[2] << 8) | (caldata[1] >> 8)) & FT_TEMP_MASK) * 100;
+
+	for (i = 0; i < tmdev->chip->sensor_num; i++) {
+		int sensor_reg, sensor_temp, cdata, offset;
+		/*
+		 * Chips ths0 and ths1 have common parameters for value
+		 * calibration. To separate them we can use the number of
+		 * temperature sensors on each chip.
+		 * For ths0 this value is 1.
+		 */
+		if (tmdev->chip->sensor_num == 1) {
+			sensor_reg = ((caldata[5] >> 8) | (caldata[6] << 8)) & TEMP_CALIB_MASK;
+		} else {
+			switch (i) {
+			case 0:
+				sensor_reg = (caldata[2] >> 4) & TEMP_CALIB_MASK;
+				break;
+			case 1:
+				sensor_reg = caldata[3] & TEMP_CALIB_MASK;
+				break;
+			case 2:
+				sensor_reg = caldata[4] & TEMP_CALIB_MASK;
+				break;
+			default:
+				sensor_reg = 0;
+				break;
+			}
+		}
+
+		sensor_temp = tmdev->chip->calc_temp(tmdev, i, sensor_reg);
+
+		/*
+		 * Calibration data is CALIBRATE_DEFAULT - (calculated
+		 * temperature from sensor reading at factory temperature
+		 * minus actual factory temperature) * X (scale from
+		 * temperature to register values)
+		 */
+		cdata = CALIBRATE_DEFAULT -
+			((sensor_temp - ft_temp) / SUN55I_A523_SCALE_ABOVE);
+
+		if (cdata & ~TEMP_CALIB_MASK) {
+			/*
+			 * Calibration value more than 12-bit, but calibration
+			 * register is 12-bit. In this case, ths hardware can
+			 * still work without calibration, although the data
+			 * won't be so accurate.
+			 */
+			dev_warn(dev, "sensor%d is not calibrated.\n", i);
+			continue;
+		}
+
+		offset = (i % 2) * 16;
+		regmap_update_bits(tmdev->regmap,
+				   SUN50I_H6_THS_TEMP_CALIB + (i / 2 * 4),
+				   TEMP_CALIB_MASK << offset,
+				   cdata << offset);
+	}
+
+	return 0;
+}
+
 static int sun8i_ths_calibrate(struct ths_device *tmdev)
 {
 	struct nvmem_cell *calcell = NULL;
@@ -730,6 +836,31 @@ static const struct ths_thermal_chip sun50i_h616_ths = {
 	.calc_temp = sun8i_ths_calc_temp,
 };
 
+/* The A523 has a shared reset line for both chips */
+static const struct ths_thermal_chip sun55i_a523_ths0 = {
+	.sensor_num = 1,
+	.has_bus_clk_reset = true,
+	.has_gpadc_clk = true,
+	.ft_deviation = 5000,
+	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
+	.calibrate = sun55i_a523_ths_calibrate,
+	.init = sun50i_h6_thermal_init,
+	.irq_ack = sun50i_h6_irq_ack,
+	.calc_temp = sun55i_a523_calc_temp,
+};
+
+static const struct ths_thermal_chip sun55i_a523_ths1 = {
+	.sensor_num = 3,
+	.has_bus_clk_reset = true,
+	.has_gpadc_clk = true,
+	.ft_deviation = 5000,
+	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
+	.calibrate = sun55i_a523_ths_calibrate,
+	.init = sun50i_h6_thermal_init,
+	.irq_ack = sun50i_h6_irq_ack,
+	.calc_temp = sun55i_a523_calc_temp,
+};
+
 static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
 	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
@@ -740,6 +871,8 @@ static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
 	{ .compatible = "allwinner,sun20i-d1-ths", .data = &sun20i_d1_ths },
 	{ .compatible = "allwinner,sun50i-h616-ths", .data = &sun50i_h616_ths },
+	{ .compatible = "allwinner,sun55i-a523-ths0", .data = &sun55i_a523_ths0 },
+	{ .compatible = "allwinner,sun55i-a523-ths1", .data = &sun55i_a523_ths1 },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, of_ths_match);
-- 
2.51.0


