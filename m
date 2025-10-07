Return-Path: <linux-kernel+bounces-843787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E29BABC0447
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 07:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFEA188A94A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 05:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAA4221FDA;
	Tue,  7 Oct 2025 05:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+aq2zNh"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011FA221FDC
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 05:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759816541; cv=none; b=nqpkbL3cp/N1AOTdzxVsdgIyT3TZ+M9BPaPcKBIAATj3GH0lPM3SMTcoQPHOoZHx2J4mHqAJk5a0T4pKULAL4qipHZRMYPgHCYz41QZD68f7q4iTcV7qLf82/nfb7QXdVTlNQ6jeXFzl0x7M3QmfCI19fU/Y9/x+W74fSdgjBBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759816541; c=relaxed/simple;
	bh=N1hoppWvFWdMHgHPGR3fy/OrxavXhpIhCQkkPMNM7zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIyGXQyw/aDzGjyI3EbruVrj/aZ69yXPCQBO+1M8bYaqkgdjwxBoFY5NcFe/0LUn9Me6ZI0xCUnvnMkeBbESDYBC9Q4UchwPRZZTThHSlzwcspkcyPQC1N6ac4EWvpCMTl9/0LjXptJ4unREjzrTUH2r3jW4SZI+2q+fYclrriM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+aq2zNh; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3369dcfef12so6454097a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759816539; x=1760421339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ev+lPBLOT3f1ol4vy53Jgd0ENs8ZOWt2KgWh8zRfjk=;
        b=P+aq2zNhEdqvMtcnMSpbA4aR2yMXlNep9fV7j3+MHFRv7sSPE5EW8Ceu9oVvGQOJc9
         soQL/ITEE4Gtdo2XXK9MoQLrsy1FI+aatVW7gQxTGpSExyXdtCKsYVY6xXeLDX+8IHD0
         5ZxnxGAGTaD9pV3Cynp/xAul1G/Ijf/z2m/ojNKKwE6PKpWKsG78noztLRgzMGgxUGBK
         JWJm/FGVskHp2yJmo3Uuwen6DTM5j9Bb/sEvtdDMegfC8mx2gLI5aCM0cDtQH25yrnvi
         b7bdZ7rUV5aymm1wy+RT8wvvq9Al9ATVBy5pWPeIriKIPw2NF6eiwzZQlReEyOL0CKxx
         bHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759816539; x=1760421339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ev+lPBLOT3f1ol4vy53Jgd0ENs8ZOWt2KgWh8zRfjk=;
        b=vCPbBiQtzFy64HZlsSbLkR4VJH1Hy+KBO4RlxjSsxuUQAiOI1GQvr/Qq+BgL5iU5qw
         DIh1DLIrvAmDPXW2072TOfzjbP3etI0kucbRkmUfI+kRJTbE4x6X4xv6XVDZR8rgF0mS
         j2aBrUm1haM0MBPpcWlKYmqkpcU7AEYtvvxqNJmjXRwYIeZzTj2IQZBpgazWAjnV95xb
         j4gyTEsxjtgWbhM1JK+YzLqLNvAc82kYdyMOTpGkuXjVCzJk4lUthKp4dJvgZxbfU2yB
         5mgyLaNuwzKBHaqYa900iTsF6cLpJFpf21RSrfvcLPTThoyI3qT7ZRMgyhEMkkk9yDRz
         zu4w==
X-Forwarded-Encrypted: i=1; AJvYcCXjTmdgdNXXXCL+EjT421aecp4p38HgphdXNi+Apm58Bbyommj1T5ds24hL74HtMdNzoytWWsf2C++XXR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfK11/YmyO13qQdBdeWqQPk0usJE746v953QtXeawNSb8twa8t
	4Yrwl1Bl6/6ENNxuKt8nlhvfBBTV+R9rgQbkF7xmX+8Gokvgoe2yy5sv
X-Gm-Gg: ASbGncu31YnfEvQZiTKf3tA9TfXBLNUVfN3OfMl/XAqxU11QSAhkEO2wJ3IugrNC23S
	CbOaH/eCJtk5aAEtk4sviDBznOU3kPNfNV27yGCYXaHKYtUwfXm6lweG7/ZDPI6qpntX/P+6EIt
	LWgiWn0YiS3on1Z5913F/Q4LpsqlGfzUowxVXuixkfRcx4ApDm6sXelpUWh46ynDn2xQp/5fc3E
	O6KikLz79e7YACkE2u3kpwrN6N4/H2W6D4BYLNp2cDXeXrJcfY9kfY94KWz5IhqmQOhwFfNjGp0
	5z47B6tlAeAAkIngOTVkBl2HvML9k/tZfc6GaDy++10SWtfKM2xu/4Yt0UN00JvTBwGem9U2WvQ
	Yb8qN5RYB+nM4iaNpfcxnkHm2CVBQWondKl66gizPciKPvcSjvUSlgT3f
X-Google-Smtp-Source: AGHT+IEUgQb04MZx6gU9pgrqckuEVzh7bdmcSUp1295wCV/EDqkCFkQgvaU7/ATYvOGFOpySWnos5w==
X-Received: by 2002:a17:90b:2544:b0:339:d03e:2a11 with SMTP id 98e67ed59e1d1-339d03e2c14mr13510320a91.14.1759816538908;
        Mon, 06 Oct 2025 22:55:38 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a1a9e8sm12983829a91.11.2025.10.06.22.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 22:55:38 -0700 (PDT)
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
Subject: [PATCH v4 3/6] iio: accel: bma400: Use index-based register addressing and lookup
Date: Tue,  7 Oct 2025 11:25:03 +0530
Message-ID: <20251007055511.108984-4-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007055511.108984-1-akshayaj.lkd@gmail.com>
References: <20251007055511.108984-1-akshayaj.lkd@gmail.com>
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

Changes since v3:
- Assigned explicit values to reg field enums introduced

 drivers/iio/accel/bma400.h      |  17 +++--
 drivers/iio/accel/bma400_core.c | 131 +++++++++++++++++++-------------
 2 files changed, 88 insertions(+), 60 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index 60fc323958f3..12836111710e 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -91,6 +91,11 @@
 #define BMA400_INT_CONFIG0_GEN2_MASK		BIT(3)
 #define BMA400_INT_CONFIG0_DRDY_MASK		BIT(7)
 
+enum bma400_generic_intr {
+	BMA400_GEN1_INTR = 0x1,
+	BMA400_GEN2_INTR = 0x2,
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
 	BMA400_DETECT_ACTIVITY = 0x1,
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


