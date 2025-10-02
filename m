Return-Path: <linux-kernel+bounces-840658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704ACBB4E97
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 20:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3D72A418E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB6F17A2E1;
	Thu,  2 Oct 2025 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abo1N0yi"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0427B35F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430533; cv=none; b=c2ntlJanmzl6DOvzTJMZG018ETNZ8qspP0mjj15gIIKgSFjB6PqS2Pdq6q45mJ6KD+/+gc1UCugPwCTCcnejaK1lBDYwIl5ZWu6Lvnh0OQi4KFRB+y4d8Jtnk6jla3PnUUnQCdoy6i2EXuGsgWRW76Z5OCcc4GXsp6ZG7OB9HHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430533; c=relaxed/simple;
	bh=CgdLoSRqcqubsg0rI377cLUrOqK7eOYKEPqDrL7PqVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZ2gEhumM/IyvPsj7yA8ZrVtghawaM/IhCUM9X8OMCMBVC6en6ZcYUpCoDLVdW+/SUJ0n4+D4ShhlYzvZ8YFEabSgbuMGz8xPYDxx+3OAubWbyeIOcyzKo9ZzQSzdK76FS5hXn/gSVd+iyHQol33saHWYYMnzQxZhicz/UBIoN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abo1N0yi; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f5d497692so2004827b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 11:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759430529; x=1760035329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDyDktYkrwmeCiCnLdbEvncGAxhs/BH7a/A0BkO50cg=;
        b=abo1N0yiwGc9rCzEndi3uUgf+ADodkbL9AVrYl/qUe3NYohiCKApw6m+XI4TqsLBj8
         BZrfStpLvUX9sbxMQcqnoAFlDzuF7q9KWqy1bcoOHcMMIMO9PRNhm46MJuvV/rwUvuum
         Z7GPh+lTKcqhlx6zmylIBnf1Q6TsNNUjEpPnOpzDHhDlsmX1GByXEx6GWSOjm4/kAu6i
         c3Q1jYCwyyjEmR8J1NiutAk7LCeXDRsOfvQBRSmnsanuyKgz5dyd9RO0oyxoZcc0Hy5W
         L86Uq2qMpM8GtKiGcZ4tyj7b2854ZwNxY8bYmtpCzu+jn9MCk/6cZdoYmRD+xSa1AKLv
         cNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759430529; x=1760035329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDyDktYkrwmeCiCnLdbEvncGAxhs/BH7a/A0BkO50cg=;
        b=ZiYAB+b49uRryRasdD0kRWJ3QIKLt4QKLa0gv6VQMR1HqEsuJfu7tlmeKvcF9K9+Cm
         7mmPDH+0Pa7HZB1/TyF1Ii0GpKSRIo0q1VU/OLijOtF+vknnfutdgS8V1oKE065PWYMg
         z8Mv+eA7KQF2G091ngmME8OCDCw6vgR71Pa9wZHdyzp2OHMVsk0bBonpUhNyauk2ir3W
         q2yxwdn0ZVOD9N0UpF9KCRU7MphjjejB0kEAA/oDT2Z1kVu41N1vWnXATZSYJGFqgxLf
         GJyAiw3jjGTAPUI1HVv9Bre67d8FN/B5HLsVjSEu+HcO6J/X9pWgr8rqS/bOmPyJmoIY
         QpIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWahd7V+vw6o/WpznOMbd0a7kkFv6ozMdV4l6wuSrgKbWQenLRc0K9PBKIuNU/RvRvMaqoYwWhhdlLFCMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxonrj0B4o1t5ylWw7XwczDV+YZO44hLfj4WOZez8c5Lk+iIftA
	l6UJWEo/BBc0d+2sXjDgnDWpto/m5Wyf3ifXUSuXzK5S/yjeRgVZnrGE
X-Gm-Gg: ASbGncsqoEUbKHboxsiFjUEkHgvvdCjXi0qSaqkpDbKKVccp1Sf7KxJU7LGyaXSEH0z
	iTP47yxBLCW0+ZcpuihYciWsG6KF3L4VkIxD3LaUyO6ZcuYw7OVq4+PF4gZhCS2SfY+zXBF/IAP
	HfzwVYtv+KFVTgp5JiAb2pbv2CONjK1MQ2x5pVfSCMPmeJrwyPoTaQNJuZO8lP/732/NQ0Mn3/V
	lql30nsR1KJrnMeb7/X6h5+5Bf4z4Q40uOmLAW2qWaAlZxgmFJP7stGMQwkVD/uaPnVMPSsKtw7
	mYb+9GdigcmvKntRI64g9Y8Kpd8X01nAncVRKshw8Tp1sxodPcZaKYTaAOFB4bjpeLluhAIcYeK
	h8DgqBRCPZ8YKSzVX1BgUetq3bibT0jqfaQ8vlLZtTlwxCijYKM26lPKI/7+Zc4Oeyuk=
X-Google-Smtp-Source: AGHT+IGP8WFUpp6D5O3V3PcWBOeK8FWgcAKMa1vb9ii5DoVIizWgPxfaNyi7VlxqzxFNS83t349/jA==
X-Received: by 2002:a05:6a21:998e:b0:302:9f3b:3e5c with SMTP id adf61e73a8af0-32b620a8d65mr538970637.39.1759430529439;
        Thu, 02 Oct 2025 11:42:09 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62ce55205csm162917a12.18.2025.10.02.11.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 11:42:08 -0700 (PDT)
From: Akshay Jindal <akshayaj.lkd@gmail.com>
To: dan@dlrobertson.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Akshay Jindal <akshayaj.lkd@gmail.com>,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] iio: accel: bma400: Use index-based register addressing and lookup
Date: Fri,  3 Oct 2025 00:11:04 +0530
Message-ID: <20251002184120.495193-4-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
References: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce formula-based macros to compute GEN INTR configuration register
addresses from the interrupt number and register index. This reduces the
need for 22 explicit register macros to three base definitions.

Add a centralized lookup table keyed by IIO event direction and replace
get_gen_config_reg() with a helper integrated with this table.

Apply these changes across the affected callbacks to ensure consistent
access to generic interrupt registers.

No functional changes are intended.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---
 drivers/iio/accel/bma400.h      |  17 +++--
 drivers/iio/accel/bma400_core.c | 131 +++++++++++++++++++-------------
 2 files changed, 88 insertions(+), 60 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 13fe2e5a3175..48fcaeeb553d 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -91,6 +91,11 @@
 #define BMA400_INT_CONFIG0_GEN2_MASK		BIT(3)
 #define BMA400_INT_CONFIG0_DRDY_MASK		BIT(7)
 
+enum bma400_generic_intr {
+	BMA400_GEN1_INTR = 1,
+	BMA400_GEN2_INTR,
+};
+
 #define BMA400_INT_CONFIG1_REG	    0x20
 #define BMA400_INT_CONFIG1_STEP_INT_MASK	BIT(0)
 #define BMA400_INT_CONFIG1_S_TAP_MASK		BIT(2)
@@ -103,8 +108,12 @@
 #define BMA400_TWO_BITS_MASK        GENMASK(1, 0)
 
 /* Generic interrupts register */
-#define BMA400_GEN1INT_CONFIG0_REG      0x3f
-#define BMA400_GEN2INT_CONFIG0_REG      0x4A
+#define BMA400_GENINT_CONFIG_REG_BASE		0x3f
+#define BMA400_NUM_GENINT_CONFIG_REGS		11
+#define BMA400_GENINT_CONFIG_REG(gen_intr, config_idx)		\
+	(BMA400_GENINT_CONFIG_REG_BASE +			\
+	(gen_intr - 1) * BMA400_NUM_GENINT_CONFIG_REGS +	\
+	(config_idx))
 #define BMA400_GENINT_CONFIG0_HYST_MASK		GENMASK(1, 0)
 #define BMA400_GENINT_CONFIG0_REF_UPD_MODE_MASK	GENMASK(3, 2)
 #define BMA400_GENINT_CONFIG0_DATA_SRC_MASK	BIT(4)
@@ -138,10 +147,6 @@ enum bma400_detect_criterion {
 	BMA400_DETECT_ACTIVITY,
 };
 
-#define BMA400_GEN_CONFIG2_OFF      0x02
-#define BMA400_GEN_CONFIG3_OFF      0x03
-#define BMA400_GEN_CONFIG31_OFF     0x04
-
 /* TAP config registers */
 #define BMA400_TAP_CONFIG_REG		0x57
 #define BMA400_TAP_CONFIG_SEN_MASK	GENMASK(2, 0)
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 58c378ba9931..a0e994f9882b 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -121,6 +121,41 @@ struct bma400_data {
 	__be16 duration;
 };
 
+struct bma400_genintr_info {
+	enum bma400_generic_intr genintr;
+	unsigned int intrmask;
+	enum iio_event_direction dir;
+	enum bma400_detect_criterion detect_mode;
+};
+
+/* Lookup struct for determining GEN1/GEN2 based on dir */
+static const struct bma400_genintr_info bma400_genintrs[] = {
+	[IIO_EV_DIR_RISING] = {
+		.genintr = BMA400_GEN1_INTR,
+		.intrmask = BMA400_INT_CONFIG0_GEN1_MASK,
+		.dir = IIO_EV_DIR_RISING,
+		.detect_mode = BMA400_DETECT_ACTIVITY,
+	},
+	[IIO_EV_DIR_FALLING] = {
+		.genintr = BMA400_GEN2_INTR,
+		.intrmask = BMA400_INT_CONFIG0_GEN2_MASK,
+		.dir = IIO_EV_DIR_FALLING,
+		.detect_mode = BMA400_DETECT_INACTIVITY,
+	}
+};
+
+static inline const struct bma400_genintr_info *
+get_bma400_genintr_info(enum iio_event_direction dir)
+{
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+	case IIO_EV_DIR_FALLING:
+		return &bma400_genintrs[dir];
+	default:
+		return NULL;
+	};
+}
+
 static bool bma400_is_writable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
@@ -1159,32 +1194,22 @@ static int bma400_activity_event_en(struct bma400_data *data,
 				    enum iio_event_direction dir,
 				    int state)
 {
-	int ret, reg, msk, value;
-	int field_value = 0;
+	int ret;
+	unsigned int intrmask, regval;
+	enum bma400_generic_intr genintr;
+	enum bma400_detect_criterion detect_criterion;
+	const struct bma400_genintr_info *bma400_genintr;
 
-	switch (dir) {
-	case IIO_EV_DIR_RISING:
-		reg = BMA400_GEN1INT_CONFIG0_REG;
-		msk = BMA400_INT_CONFIG0_GEN1_MASK;
-		value = FIELD_PREP(BMA400_GENINT_CONFIG1_AXES_COMB_MASK, BMA400_EVAL_X_OR_Y_OR_Z) |
-			FIELD_PREP(BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK, BMA400_DETECT_ACTIVITY);
-		set_mask_bits(&field_value, BMA400_INT_CONFIG0_GEN1_MASK,
-			      FIELD_PREP(BMA400_INT_CONFIG0_GEN1_MASK, state));
-		break;
-	case IIO_EV_DIR_FALLING:
-		reg = BMA400_GEN2INT_CONFIG0_REG;
-		msk = BMA400_INT_CONFIG0_GEN2_MASK;
-		value = FIELD_PREP(BMA400_GENINT_CONFIG1_AXES_COMB_MASK, BMA400_EVAL_X_OR_Y_OR_Z) |
-			FIELD_PREP(BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK, BMA400_DETECT_INACTIVITY);
-		set_mask_bits(&field_value, BMA400_INT_CONFIG0_GEN2_MASK,
-			      FIELD_PREP(BMA400_INT_CONFIG0_GEN2_MASK, state));
-		break;
-	default:
+	bma400_genintr = get_bma400_genintr_info(dir);
+	if (!bma400_genintr)
 		return -EINVAL;
-	}
+
+	genintr = bma400_genintr->genintr;
+	detect_criterion = bma400_genintr->detect_mode;
+	intrmask = bma400_genintr->intrmask;
 
 	/* Enabling all axis for interrupt evaluation */
-	ret = regmap_write(data->regmap, reg,
+	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 0),
 			   BMA400_GENINT_CONFIG0_X_EN_MASK |
 			   BMA400_GENINT_CONFIG0_Y_EN_MASK |
 			   BMA400_GENINT_CONFIG0_Z_EN_MASK|
@@ -1195,31 +1220,32 @@ static int bma400_activity_event_en(struct bma400_data *data,
 		return ret;
 
 	/* OR combination of all axis for interrupt evaluation */
-	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG1_OFF, value);
+	regval = FIELD_PREP(BMA400_GENINT_CONFIG1_AXES_COMB_MASK, BMA400_EVAL_X_OR_Y_OR_Z) |
+		 FIELD_PREP(BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK, detect_criterion);
+	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 1), regval);
 	if (ret)
 		return ret;
 
 	/* Initial value to avoid interrupts while enabling*/
-	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG2_OFF, 0x0A);
+	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 2), 0x0A);
 	if (ret)
 		return ret;
 
 	/* Initial duration value to avoid interrupts while enabling*/
-	ret = regmap_write(data->regmap, reg + BMA400_GEN_CONFIG31_OFF, 0x0F);
+	ret = regmap_write(data->regmap, BMA400_GENINT_CONFIG_REG(genintr, 4), 0x0F);
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG, msk,
-				 field_value);
+	regval = state ? intrmask : 0;
+	ret = regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG, intrmask, regval);
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG, msk,
-				 field_value);
+	ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG, intrmask, regval);
 	if (ret)
 		return ret;
 
-	set_mask_bits(&data->generic_event_en, msk, field_value);
+	set_mask_bits(&data->generic_event_en, intrmask, regval);
 	return 0;
 }
 
@@ -1344,18 +1370,6 @@ static int bma400_write_event_config(struct iio_dev *indio_dev,
 	}
 }
 
-static int get_gen_config_reg(enum iio_event_direction dir)
-{
-	switch (dir) {
-	case IIO_EV_DIR_FALLING:
-		return BMA400_GEN2INT_CONFIG0_REG;
-	case IIO_EV_DIR_RISING:
-		return BMA400_GEN1INT_CONFIG0_REG;
-	default:
-		return -EINVAL;
-	}
-}
-
 static int bma400_read_event_value(struct iio_dev *indio_dev,
 				   const struct iio_chan_spec *chan,
 				   enum iio_event_type type,
@@ -1364,22 +1378,25 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 				   int *val, int *val2)
 {
 	struct bma400_data *data = iio_priv(indio_dev);
-	int ret, reg, reg_val, raw;
+	int ret, reg_val, raw;
+	enum bma400_generic_intr genintr;
+	const struct bma400_genintr_info *bma400_genintr;
 
 	if (chan->type != IIO_ACCEL)
 		return -EINVAL;
 
 	switch (type) {
 	case IIO_EV_TYPE_MAG:
-		reg = get_gen_config_reg(dir);
-		if (reg < 0)
+		bma400_genintr = get_bma400_genintr_info(dir);
+		if (!bma400_genintr)
 			return -EINVAL;
+		genintr = bma400_genintr->genintr;
 
 		*val2 = 0;
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
 			ret = regmap_read(data->regmap,
-					  reg + BMA400_GEN_CONFIG2_OFF,
+					  BMA400_GENINT_CONFIG_REG(genintr, 2),
 					  val);
 			if (ret)
 				return ret;
@@ -1387,7 +1404,7 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 		case IIO_EV_INFO_PERIOD:
 			mutex_lock(&data->mutex);
 			ret = regmap_bulk_read(data->regmap,
-					       reg + BMA400_GEN_CONFIG3_OFF,
+					       BMA400_GENINT_CONFIG_REG(genintr, 3),
 					       &data->duration,
 					       sizeof(data->duration));
 			if (ret) {
@@ -1398,7 +1415,9 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
 			mutex_unlock(&data->mutex);
 			return IIO_VAL_INT;
 		case IIO_EV_INFO_HYSTERESIS:
-			ret = regmap_read(data->regmap, reg, val);
+			ret = regmap_read(data->regmap,
+					  BMA400_GENINT_CONFIG_REG(genintr, 0),
+					  val);
 			if (ret)
 				return ret;
 			*val = FIELD_GET(BMA400_GENINT_CONFIG0_HYST_MASK, *val);
@@ -1452,16 +1471,19 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 				    int val, int val2)
 {
 	struct bma400_data *data = iio_priv(indio_dev);
-	int reg, ret, raw;
+	int ret, raw;
+	enum bma400_generic_intr genintr;
+	const struct bma400_genintr_info *bma400_genintr;
 
 	if (chan->type != IIO_ACCEL)
 		return -EINVAL;
 
 	switch (type) {
 	case IIO_EV_TYPE_MAG:
-		reg = get_gen_config_reg(dir);
-		if (reg < 0)
+		bma400_genintr = get_bma400_genintr_info(dir);
+		if (!bma400_genintr)
 			return -EINVAL;
+		genintr = bma400_genintr->genintr;
 
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -1469,7 +1491,7 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 				return -EINVAL;
 
 			return regmap_write(data->regmap,
-					    reg + BMA400_GEN_CONFIG2_OFF,
+					    BMA400_GENINT_CONFIG_REG(genintr, 2),
 					    val);
 		case IIO_EV_INFO_PERIOD:
 			if (val < 1 || val > 65535)
@@ -1478,7 +1500,7 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 			mutex_lock(&data->mutex);
 			put_unaligned_be16(val, &data->duration);
 			ret = regmap_bulk_write(data->regmap,
-						reg + BMA400_GEN_CONFIG3_OFF,
+						BMA400_GENINT_CONFIG_REG(genintr, 3),
 						&data->duration,
 						sizeof(data->duration));
 			mutex_unlock(&data->mutex);
@@ -1487,7 +1509,8 @@ static int bma400_write_event_value(struct iio_dev *indio_dev,
 			if (val < 0 || val > 3)
 				return -EINVAL;
 
-			return regmap_update_bits(data->regmap, reg,
+			return regmap_update_bits(data->regmap,
+						  BMA400_GENINT_CONFIG_REG(genintr, 0),
 						  BMA400_GENINT_CONFIG0_HYST_MASK,
 						  FIELD_PREP(BMA400_GENINT_CONFIG0_HYST_MASK,
 							     val));
-- 
2.43.0


