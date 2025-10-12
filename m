Return-Path: <linux-kernel+bounces-849648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6D7BD0942
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965A8189417E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFAE2F1FCF;
	Sun, 12 Oct 2025 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6v9qG70"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6162EFDA2
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292432; cv=none; b=Vtfq2cl8oT6vidX9YqYpGjggkyFxUap1sKIrRT3gz0rDMFewndUTYxKytKQpoBkVLROjMaKhyejVNa87TfY4Twpe47yJnL3U4ghyQoN93JF25k8YCRCzNBwo7VjqBuKExE8cZ9FHdiMg7aCqGiW5ew9qkwH8w08Y7uJH2thGtV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292432; c=relaxed/simple;
	bh=Ak/h60vAIjf9Mp8zrf1xKvMjBdoyv7hoxMUx+IHfL94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6DLOqSBvrkO4j+HErhSIq12zuRb57f247y4B+MSHXJEg15u3RlRdT9WVeAvvCPbI3/YwgUUYP2xsWjb6clrO+sxN68L+AduAYfsN2ZS5zwnjlWPVKBQciBrt8tugHr/GiMHJpkb860runwa2npZ28lsYCEYKfpBsqIPvEI8NVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6v9qG70; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so40322255ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 11:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292430; x=1760897230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7WBZHMqvvgEkp/pSPwrdoVC7ilzPciXVI73gEp7Ico=;
        b=B6v9qG70rlLWajGcl2rrghM6YPRVV9PU8j7Va9JUz9eNFX8HANw3t3AZYmWPk2A/Qj
         PQUfMPZJzcdtalABFN+vzZ/kjdMqsxd+aa60JLedxQsgTAl+rPw1E4WQqnbeLxvGQwrl
         ue2RsIJzOSXg8xqytDAiFdFjiqtF7ITr/qAWhvY0XbjLjVNjaIGg4DYaG8zPAxRA2E8s
         l7hSRJTKgjFiIcyEJsVmJJ6CiYLIA55w3am0Q2Oy31/KY5uq/m7mpQbnLkVEJpPb6sve
         LoD/zGT3ocnh4c4tZ4M+uVx3nMalhfraKfWIv01znXEgn8RIu5i1c0cgSfeB2+epPPK6
         Bjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292430; x=1760897230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7WBZHMqvvgEkp/pSPwrdoVC7ilzPciXVI73gEp7Ico=;
        b=RVEsSWKD7DYT/f6caPSDdPBKRUFLWFhGcWQ7vXAMF0MV5BNjFqzYh/hjn9Sm0rBi0U
         8sFEnwaxQkq4IZjg3AIHWxKZeKl/xyWSG90968dS4SDN2GASDPLr6PJMZkv+TXm+LRYr
         umNu1DHPIEFn6sWIW17y17xbXnf7NtJrqNb4pWwslANiGnCHmJVUdZHYseKyBihqRWZP
         QYE6yc0lSsEjyg+atlCSK1VmRg6mGGlCZYL2I7+xgQ+u+a4haEU5ra8b1bux6m1YQPQV
         60GHwyala1b+F9Vxn5r60PV2YhOidGSPr4JbZpvNPY62CdoKelIpnnA/IffhygnJH0ja
         M5Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWFDRUAUbkMO/a22DH+vNV4Zjiyko1L8NGzXRBR14ENeAnS7gb4Ybt3c+hqPdQP/SU3B4+/M90zhFa5t38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1XF4vwZ4zwhj48AxVdNTl2cds+pUR/EIj+SugjBJ+gxEe/DYN
	F8C/0ICXBAGJYlW+lFENBnIkqFF76fheIGr7/JB8v+G/R5l7iA+AO2mg
X-Gm-Gg: ASbGncvjDPYeyu7rkMpriuvHmViL8Pnb9unn5oHHw90JzKKQ0dIqELY3sqfRYzYSJUW
	Zgvzg/2pVBXPkDHXlx3mlZJ3kBDskH2bUNhxv1xZ18LJWWyFhf011GB28eO1jV7Xs8kWiidwHBx
	NrWxHO0VoRJiowMoTEBkbWIyba7PqIYnbVhInXWe6GvjklBCS7LnYsPOM+9eQ2XK7jjxahP8+yi
	z2Hcr3/9tIzGjSu9eS/b7LeWg/O4TT2WEdH4eTmNdN0RZwLp/9klyYZHdCkVXBfpgclqaOCDt4j
	oOJL+Xtwo6q0C21XkMaJlwO8C40v3b8CmnnDvBeYgBOu81T4WNG/wmC0HXfkN2AokEVYjowY198
	vkji0QUVVFaV7cvbUYwqGoq76fCBsJSNIMazgSi0qAcX+kpKb+A5MRjnznLXfgijIQJaLVqX5
X-Google-Smtp-Source: AGHT+IGczUQHKhidrkrs8TNHxRnsW4Sz9rJltTBQDCS6nsP/FgIA8eKc0upOJod8ddbWAfiXF/K3/g==
X-Received: by 2002:a17:902:d4ca:b0:25d:5b09:a201 with SMTP id d9443c01a7336-2902739af89mr270997285ad.27.1760292429760;
        Sun, 12 Oct 2025 11:07:09 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.65.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f56c0fsm111734345ad.104.2025.10.12.11.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:07:09 -0700 (PDT)
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
Subject: [PATCH v5 3/6] iio: accel: bma400: Use index-based register addressing and lookup
Date: Sun, 12 Oct 2025 23:36:10 +0530
Message-ID: <20251012180619.195244-4-akshayaj.lkd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251012180619.195244-1-akshayaj.lkd@gmail.com>
References: <20251012180619.195244-1-akshayaj.lkd@gmail.com>
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
index 12e7bf5fe647..e2832d33862d 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -98,6 +98,11 @@
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
@@ -110,8 +115,12 @@
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
@@ -145,10 +154,6 @@ enum bma400_detect_criterion {
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
index 46855073ce3a..42cd55fa1609 100644
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


