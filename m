Return-Path: <linux-kernel+bounces-767707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3D4B257EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D537B3A42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8230E84F;
	Wed, 13 Aug 2025 23:56:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AB530AACD;
	Wed, 13 Aug 2025 23:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129397; cv=none; b=Sfg905EzAFxAvZViIUELwazFXQTZSJFetBEEGNQ/OtRhdUTZch4N18/naRVR/A7lO/FOOaMqQAg7ezkleHGN+4s+LhSwVBE9Pr+mHcZ61MGVmGpOa2fsDH0svbg+CmHhY2EaOvYTfGS19PgARXYv7rd2fZT854PqCQqJA5kAyUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129397; c=relaxed/simple;
	bh=vxrLDxY58Q9SfgepllNxsM672a60gwFE8l1jnW5Sqbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoYDVKIIGsk0K1/Hzfj8peND0QCqju5CNziPQRhNJtkKD18F04fIEaWsVOi4EdN3Y+vyYAIN1+XR4kmBn8XTE2rl4E9bfjWR23Zq7+bsorOKyHh9g+HtAv3QvFwwyDpd7fgppoCibPaJYHmZ/V+dvwprGmdrpEg2B/TWhJOHIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25C7416A3;
	Wed, 13 Aug 2025 16:56:27 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 291103F738;
	Wed, 13 Aug 2025 16:56:32 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] regulator: axp20x: add support for the AXP318W
Date: Thu, 14 Aug 2025 00:53:30 +0100
Message-ID: <20250813235330.24263-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250813235330.24263-1-andre.przywara@arm.com>
References: <20250813235330.24263-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X-Powers AXP318W is a typical PMIC from X-Powers, featuring nine
DC/DC converters and 28 LDOs, on the regulator side.

Describe the chip's voltage settings and switch registers, how the
voltages are encoded, and connect this to the MFD device via its
regulator ID.
We use just "318" for the internal identifiers, for easier typing and
less churn. If something else other than the "AXP318W" shows up, that's
an easy change, externally visible strings carry the additional letter
already.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/regulator/axp20x-regulator.c | 159 +++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h           |  41 +++++++
 2 files changed, 200 insertions(+)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index da891415efc0b..eb2c45b5b9eb0 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -138,6 +138,15 @@
 #define AXP313A_DCDC_V_OUT_MASK		GENMASK(6, 0)
 #define AXP313A_LDO_V_OUT_MASK		GENMASK(4, 0)
 
+#define AXP318_DCDC1_V_OUT_MASK		GENMASK(4, 0)
+#define AXP318_DCDC2_V_OUT_MASK		GENMASK(6, 0)
+#define AXP318_LDO_V_OUT_MASK		GENMASK(4, 0)
+#define AXP318_ELDO_V_OUT_MASK		GENMASK(5, 0)
+#define AXP318_DCDC2_NUM_VOLTAGES	88
+#define AXP318_DCDC6_NUM_VOLTAGES	128
+#define AXP318_DCDC7_NUM_VOLTAGES	103
+#define AXP318_DCDC8_NUM_VOLTAGES	119
+
 #define AXP717_DCDC1_NUM_VOLTAGES	88
 #define AXP717_DCDC2_NUM_VOLTAGES	107
 #define AXP717_DCDC3_NUM_VOLTAGES	103
@@ -765,6 +774,151 @@ static const struct regulator_desc axp313a_regulators[] = {
 	AXP_DESC_FIXED(AXP313A, RTC_LDO, "rtc-ldo", "vin1", 1800),
 };
 
+static const struct linear_range axp318_dcdc2_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000,   0, 70, 10000),
+	REGULATOR_LINEAR_RANGE(1220000, 71, 87, 20000),
+};
+
+static const struct linear_range axp318_dcdc6_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000,    0,  70,  10000),
+	REGULATOR_LINEAR_RANGE(1220000,  71,  87,  20000),
+	REGULATOR_LINEAR_RANGE(1800000,  88, 118,  20000),
+	REGULATOR_LINEAR_RANGE(2440000, 119, 127,  40000),
+};
+
+static const struct linear_range axp318_dcdc7_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000,   0,  70, 10000),
+	REGULATOR_LINEAR_RANGE(1220000, 71, 102, 20000),
+};
+
+static const struct linear_range axp318_dcdc8_ranges[] = {
+	REGULATOR_LINEAR_RANGE(500000,    0,  70,  10000),
+	REGULATOR_LINEAR_RANGE(1220000,  71, 102,  20000),
+	REGULATOR_LINEAR_RANGE(1900000, 103, 118, 100000),
+};
+
+static const struct regulator_desc axp318_regulators[] = {
+	AXP_DESC(AXP318, DCDC1, "dcdc1", "vin1", 1000, 3400, 100,
+		 AXP318_DCDC1_CONTROL, AXP318_DCDC1_V_OUT_MASK,
+		 AXP318_DCDC_OUTPUT_CONTROL1, BIT(0)),
+	AXP_DESC_RANGES(AXP318, DCDC2, "dcdc2", "vin2",
+			axp318_dcdc2_ranges, AXP318_DCDC2_NUM_VOLTAGES,
+			AXP318_DCDC2_CONTROL, AXP318_DCDC2_V_OUT_MASK,
+			AXP318_DCDC_OUTPUT_CONTROL1, BIT(1)),
+	AXP_DESC_RANGES(AXP318, DCDC3, "dcdc3", "vin3",
+			axp318_dcdc2_ranges, AXP318_DCDC2_NUM_VOLTAGES,
+			AXP318_DCDC3_CONTROL, AXP318_DCDC2_V_OUT_MASK,
+			AXP318_DCDC_OUTPUT_CONTROL1, BIT(2)),
+	AXP_DESC_RANGES(AXP318, DCDC4, "dcdc4", "vin4",
+			axp318_dcdc2_ranges, AXP318_DCDC2_NUM_VOLTAGES,
+			AXP318_DCDC4_CONTROL, AXP318_DCDC2_V_OUT_MASK,
+			AXP318_DCDC_OUTPUT_CONTROL1, BIT(3)),
+	AXP_DESC_RANGES(AXP318, DCDC5, "dcdc5", "vin5",
+			axp318_dcdc2_ranges, AXP318_DCDC2_NUM_VOLTAGES,
+			AXP318_DCDC5_CONTROL, AXP318_DCDC2_V_OUT_MASK,
+			AXP318_DCDC_OUTPUT_CONTROL1, BIT(4)),
+	AXP_DESC_RANGES(AXP318, DCDC6, "dcdc6", "vin6",
+			axp318_dcdc6_ranges, AXP318_DCDC6_NUM_VOLTAGES,
+			AXP318_DCDC6_CONTROL, AXP318_DCDC2_V_OUT_MASK,
+			AXP318_DCDC_OUTPUT_CONTROL1, BIT(5)),
+	AXP_DESC_RANGES(AXP318, DCDC7, "dcdc7", "vin7",
+			axp318_dcdc7_ranges, AXP318_DCDC7_NUM_VOLTAGES,
+			AXP318_DCDC7_CONTROL, AXP318_DCDC2_V_OUT_MASK,
+			AXP318_DCDC_OUTPUT_CONTROL1, BIT(6)),
+	AXP_DESC_RANGES(AXP318, DCDC8, "dcdc8", "vin8",
+			axp318_dcdc8_ranges, AXP318_DCDC8_NUM_VOLTAGES,
+			AXP318_DCDC8_CONTROL, AXP318_DCDC2_V_OUT_MASK,
+			AXP318_DCDC_OUTPUT_CONTROL1, BIT(7)),
+	AXP_DESC_RANGES(AXP318, DCDC9, "dcdc9", "vin9",
+			axp318_dcdc8_ranges, AXP318_DCDC8_NUM_VOLTAGES,
+			AXP318_DCDC9_CONTROL, AXP318_DCDC2_V_OUT_MASK,
+			AXP318_DCDC_OUTPUT_CONTROL2, BIT(0)),
+	AXP_DESC(AXP318, ALDO1, "aldo1", "aldo156in", 500, 3400, 100,
+		 AXP318_ALDO1_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL1, BIT(0)),
+	AXP_DESC(AXP318, ALDO2, "aldo2", "aldo234in", 500, 3400, 100,
+		 AXP318_ALDO2_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL1, BIT(1)),
+	AXP_DESC(AXP318, ALDO3, "aldo3", "aldo234in", 500, 3400, 100,
+		 AXP318_ALDO3_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL1, BIT(2)),
+	AXP_DESC(AXP318, ALDO4, "aldo4", "aldo234in", 500, 3400, 100,
+		 AXP318_ALDO4_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL1, BIT(3)),
+	AXP_DESC(AXP318, ALDO5, "aldo5", "aldo156in", 500, 3400, 100,
+		 AXP318_ALDO5_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL1, BIT(4)),
+	AXP_DESC(AXP318, ALDO6, "aldo6", "aldo156in", 500, 3400, 100,
+		 AXP318_ALDO6_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL1, BIT(5)),
+	AXP_DESC(AXP318, BLDO1, "bldo1", "bldoin", 500, 3400, 100,
+		 AXP318_BLDO1_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL1, BIT(6)),
+	AXP_DESC(AXP318, BLDO2, "bldo2", "bldoin", 500, 3400, 100,
+		 AXP318_BLDO2_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL1, BIT(7)),
+	AXP_DESC(AXP318, BLDO3, "bldo3", "bldoin", 500, 3400, 100,
+		 AXP318_BLDO3_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL2, BIT(0)),
+	AXP_DESC(AXP318, BLDO4, "bldo4", "bldoin", 500, 3400, 100,
+		 AXP318_BLDO4_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL2, BIT(1)),
+	AXP_DESC(AXP318, BLDO5, "bldo5", "bldoin", 500, 3400, 100,
+		 AXP318_BLDO5_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL2, BIT(2)),
+	AXP_DESC(AXP318, CLDO1, "cldo1", "cldoin", 500, 3400, 100,
+		 AXP318_CLDO1_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL2, BIT(3)),
+	AXP_DESC(AXP318, CLDO2, "cldo2", "cldoin", 500, 3400, 100,
+		 AXP318_CLDO2_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL2, BIT(4)),
+	AXP_DESC(AXP318, CLDO3, "cldo3", "cldoin", 500, 3400, 100,
+		 AXP318_CLDO3_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL2, BIT(5)),
+	AXP_DESC(AXP318, CLDO4, "cldo4", "cldoin", 500, 3400, 100,
+		 AXP318_CLDO4_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL2, BIT(6)),
+	AXP_DESC(AXP318, CLDO5, "cldo5", "cldoin", 500, 3400, 100,
+		 AXP318_CLDO5_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL2, BIT(7)),
+	AXP_DESC(AXP318, DLDO1, "dldo1", "dldoin", 500, 3400, 100,
+		 AXP318_DLDO1_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL3, BIT(0)),
+	AXP_DESC(AXP318, DLDO2, "dldo2", "dldoin", 500, 3400, 100,
+		 AXP318_DLDO2_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL3, BIT(1)),
+	AXP_DESC(AXP318, DLDO3, "dldo3", "dldoin", 500, 3400, 100,
+		 AXP318_DLDO3_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL3, BIT(2)),
+	AXP_DESC(AXP318, DLDO4, "dldo4", "dldoin", 500, 3400, 100,
+		 AXP318_DLDO4_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL3, BIT(3)),
+	AXP_DESC(AXP318, DLDO5, "dldo5", "dldoin", 500, 3400, 100,
+		 AXP318_DLDO5_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL3, BIT(4)),
+	AXP_DESC(AXP318, DLDO6, "dldo6", "dldoin", 500, 3400, 100,
+		 AXP318_DLDO6_CONTROL, AXP318_LDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL3, BIT(5)),
+	AXP_DESC(AXP318, ELDO1, "eldo1", "eldoin", 500, 1500, 25,
+		 AXP318_ELDO1_CONTROL, AXP318_ELDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL3, BIT(6)),
+	AXP_DESC(AXP318, ELDO2, "eldo2", "eldoin", 500, 1500, 25,
+		 AXP318_ELDO2_CONTROL, AXP318_ELDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL3, BIT(7)),
+	AXP_DESC(AXP318, ELDO3, "eldo3", "eldoin", 500, 1500, 25,
+		 AXP318_ELDO3_CONTROL, AXP318_ELDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL4, BIT(0)),
+	AXP_DESC(AXP318, ELDO4, "eldo4", "eldoin", 500, 1500, 25,
+		 AXP318_ELDO4_CONTROL, AXP318_ELDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL4, BIT(1)),
+	AXP_DESC(AXP318, ELDO5, "eldo5", "eldoin", 500, 1500, 25,
+		 AXP318_ELDO5_CONTROL, AXP318_ELDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL4, BIT(2)),
+	AXP_DESC(AXP318, ELDO6, "eldo6", "eldoin", 500, 1500, 25,
+		 AXP318_ELDO6_CONTROL, AXP318_ELDO_V_OUT_MASK,
+		 AXP318_LDO_OUTPUT_CONTROL4, BIT(3)),
+};
+
 static const struct linear_range axp717_dcdc1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(500000,   0, 70, 10000),
 	REGULATOR_LINEAR_RANGE(1220000, 71, 87, 20000),
@@ -1347,6 +1501,7 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 		step = 150;
 		break;
 	case AXP313A_ID:
+	case AXP318_ID:
 	case AXP323_ID:
 	case AXP717_ID:
 	case AXP15060_ID:
@@ -1585,6 +1740,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 		regulators = axp313a_regulators;
 		nregulators = AXP313A_REG_ID_MAX;
 		break;
+	case AXP318_ID:
+		regulators = axp318_regulators;
+		nregulators = AXP318_REG_ID_MAX;
+		break;
 	case AXP717_ID:
 		regulators = axp717_regulators;
 		nregulators = AXP717_REG_ID_MAX;
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index a871789f6cfa9..f4217c4763669 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -559,6 +559,47 @@ enum {
 	AXP313A_REG_ID_MAX,
 };
 
+enum {
+	AXP318_DCDC1 = 0,
+	AXP318_DCDC2,
+	AXP318_DCDC3,
+	AXP318_DCDC4,
+	AXP318_DCDC5,
+	AXP318_DCDC6,
+	AXP318_DCDC7,
+	AXP318_DCDC8,
+	AXP318_DCDC9,
+	AXP318_ALDO1,
+	AXP318_ALDO2,
+	AXP318_ALDO3,
+	AXP318_ALDO4,
+	AXP318_ALDO5,
+	AXP318_ALDO6,
+	AXP318_BLDO1,
+	AXP318_BLDO2,
+	AXP318_BLDO3,
+	AXP318_BLDO4,
+	AXP318_BLDO5,
+	AXP318_CLDO1,
+	AXP318_CLDO2,
+	AXP318_CLDO3,
+	AXP318_CLDO4,
+	AXP318_CLDO5,
+	AXP318_DLDO1,
+	AXP318_DLDO2,
+	AXP318_DLDO3,
+	AXP318_DLDO4,
+	AXP318_DLDO5,
+	AXP318_DLDO6,
+	AXP318_ELDO1,
+	AXP318_ELDO2,
+	AXP318_ELDO3,
+	AXP318_ELDO4,
+	AXP318_ELDO5,
+	AXP318_ELDO6,
+	AXP318_REG_ID_MAX,
+};
+
 enum {
 	AXP717_DCDC1 = 0,
 	AXP717_DCDC2,
-- 
2.46.3


