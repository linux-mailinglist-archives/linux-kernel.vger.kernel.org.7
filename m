Return-Path: <linux-kernel+bounces-840657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E75BB4E91
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 20:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ED23B54C8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28F927B340;
	Thu,  2 Oct 2025 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfP38l1B"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B523279DB4
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430525; cv=none; b=Ml6vdBEbRfE0pj0WpqxyzDIRLlAuKxxBw8AChmIPydN7ZpepeMGlUoQPzSnxgp14pdUbkRKxeBLdB+BzUs1G7m2OD296jAac/eod9B9ob0aioiHjIc4O34XSG/RUEAr1YYH2MvARyQt/cHyL2QNaZU3sWeQjthSPe6Pn65/1SrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430525; c=relaxed/simple;
	bh=a7D9hz3epqZ0bQU6txYeaeBNSIwXAUcTbzwa7CuoZaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7GVRljjuVjseZaKcw9R23UtoGhvhCvk51qwt45MRsR7eEktC1wQnmMn8NHvLMbcS73SciPnPrDeuo2ArQCFoA15kQX5LA6QUKaK+w75bqaRKcQHgkM5NpPpdrHvfceXC8/KrJQdL4ymkXVju5vMm/5UhF6fakBnLo/73PaIsNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfP38l1B; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7800ff158d5so1300802b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 11:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759430523; x=1760035323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqjFYu+ePtbWEe02tU57DLUXg0AvCayHuA5DoSCV2Vg=;
        b=gfP38l1BkSbPzpiikZythvRXzOr+umHXU8MgUjX0LyvRl0SzOxd+iTqGvI2Bdw+6mo
         xSbD6fXxquuF2E2dKtkr+2aio/LG7ykBC/kGLEebV6HKrU2gn+FRaksFzjIyelpBgcvM
         JqfyBNu5gtA3cXy+nBi3gtCs9gBEfk1g/sQi/DubBw8HRfDGCOZJuzhGBx26IfdT0X+r
         kiqz9ETCCtteaTyyHBgHug3qmV9RCIkBT2xVTF5qrRZ+zd3VerXInoG2x+6ABlyZLxPL
         +zUAbAcerwZHkBpExn5xbtxGLAb72Tt4kA1QpY/SWmI7HqdCWLST6A03D1GCRQh6QxUz
         foHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759430523; x=1760035323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqjFYu+ePtbWEe02tU57DLUXg0AvCayHuA5DoSCV2Vg=;
        b=JMNC27sj4kNluXuPoDYaiH5fFjDnJII34qSiLLm7bxkQehUdlJ53wzU9NR1tJ1scGO
         UecNLZZyI/yYJma15lvt5+LpKuZEy2Tk8VrTesCtQuYhhoafRHUSAleqe/LqN7nFwLxf
         Nn/oLPflJ1q2Xo3GVaw8+Vw4v8VGh2R3M3XLcjcrK2fW02sEtCv3ZBhlNQrE8x03oyjc
         Q0Npq/wLImGQvezqC5rlZDxU7Cj7L3BqULpO/JRSuCjMf3z4DLJt8MEe+tTJ7qH5ZvDd
         Ug6BU/sFu8EHLcgEL4aNo6MeVGwa57dTUqWFD8Y5bgDidX/t7oEFAnqttB+w4ZuXpZ/J
         omBg==
X-Forwarded-Encrypted: i=1; AJvYcCVRUENLNGFbp25/TPA4ndcbwn2Uol6UWkYqs3nvWJjHg4RLhg+Rv1XL11rqzKb0kZDIWO5fww5Zq8TJF9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjRWXhU3EyM8ET1msU9tY+sclVJ8qnGv8pmkfpRP8Xon+ThIEf
	6DQDL5Ri1vX/pXRDDk69BAGmaI+shlyyJb0Xx9zGlTWAS3mf6FsjfICB
X-Gm-Gg: ASbGnct5I1y2nyZAw6HdNEknBTql7tn/UCETFMemKs84JqPpKqVMqmyLR37Zw/kvNt0
	cQBUTP3eOnJRLiejDVJ9UYO3t8nkXrQxMsP245DxfKQ67/FJNEH7K0GTeRX5biUOnbjcfvVMvmt
	jcYWKkwRxcsy1evUWCHQHFwozVOC7/ZNWbNgYA4ds6fUVf/BOwS4A1xVEnAcChFEDLdpUmD1AJv
	YS7QIfScaIIg3u8ZT/+zMBoG71TbB3u4CfwO4X+6w35zRrc7RS8ljtfG/7BeAuid1Ce4pq34Q7R
	n64xaGBk3c9SAmU1QpJZlv1T603lGaaDTKhXmRKePu6yKTCtzqCvqOXDqrHsnwviQ4iLbEVxyop
	BZV6BD9TH1ZL+41sLZSjLbJ+pW9X9jTxT2AZPpPmXX8ZRnt0PXpBF6kAX
X-Google-Smtp-Source: AGHT+IHsG5bz1iYiNfYk+h6yX5OFWi97oMSan5DkcHZBV6+S7qJwwY+wRw4tFAkjKIQyhbpMAdXjYQ==
X-Received: by 2002:a05:6a20:6a08:b0:2f9:dc8d:d2a2 with SMTP id adf61e73a8af0-32b61dee151mr513803637.2.1759430522853;
        Thu, 02 Oct 2025 11:42:02 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62ce55205csm162917a12.18.2025.10.02.11.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 11:42:02 -0700 (PDT)
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
Subject: [PATCH v3 2/5] iio: accel: bma400: Use macros for generic event configuration values
Date: Fri,  3 Oct 2025 00:11:03 +0530
Message-ID: <20251002184120.495193-3-akshayaj.lkd@gmail.com>
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

Add macros and enums for configuration values used in generic event
handling for activity and inactivity detection. Replace hard-coded
values in activity_event_en() with the new definitions to make the
configuration explicit.

No functional changes are intended.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---
 drivers/iio/accel/bma400.h      | 30 ++++++++++++++++++++++++++++++
 drivers/iio/accel/bma400_core.c | 14 +++++++++++---
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index ae3411c090c9..13fe2e5a3175 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -106,8 +106,38 @@
 #define BMA400_GEN1INT_CONFIG0_REG      0x3f
 #define BMA400_GEN2INT_CONFIG0_REG      0x4A
 #define BMA400_GENINT_CONFIG0_HYST_MASK		GENMASK(1, 0)
+#define BMA400_GENINT_CONFIG0_REF_UPD_MODE_MASK	GENMASK(3, 2)
+#define BMA400_GENINT_CONFIG0_DATA_SRC_MASK	BIT(4)
+#define BMA400_GENINT_CONFIG0_X_EN_MASK		BIT(5)
+#define BMA400_GENINT_CONFIG0_Y_EN_MASK		BIT(6)
+#define BMA400_GENINT_CONFIG0_Z_EN_MASK		BIT(7)
+
+enum bma400_accel_data_src {
+	ACCEL_FILT1,
+	ACCEL_FILT2,
+};
+
+enum bma400_ref_updt_mode {
+	BMA400_REF_MANUAL_UPDT_MODE,
+	BMA400_REF_ONETIME_UPDT_MODE,
+	BMA400_REF_EVERYTIME_UPDT_MODE,
+	BMA400_REF_EVERYTIME_LP_UPDT_MODE,
+};
 
 #define BMA400_GEN_CONFIG1_OFF      0x01
+#define BMA400_GENINT_CONFIG1_AXES_COMB_MASK	BIT(0)
+#define BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK	BIT(1)
+
+enum bma400_genintr_acceleval_axescomb {
+	BMA400_EVAL_X_OR_Y_OR_Z,
+	BMA400_EVAL_X_AND_Y_AND_Z,
+};
+
+enum bma400_detect_criterion {
+	BMA400_DETECT_INACTIVITY,
+	BMA400_DETECT_ACTIVITY,
+};
+
 #define BMA400_GEN_CONFIG2_OFF      0x02
 #define BMA400_GEN_CONFIG3_OFF      0x03
 #define BMA400_GEN_CONFIG31_OFF     0x04
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index 35d2b90425f8..58c378ba9931 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -1166,14 +1166,16 @@ static int bma400_activity_event_en(struct bma400_data *data,
 	case IIO_EV_DIR_RISING:
 		reg = BMA400_GEN1INT_CONFIG0_REG;
 		msk = BMA400_INT_CONFIG0_GEN1_MASK;
-		value = 2;
+		value = FIELD_PREP(BMA400_GENINT_CONFIG1_AXES_COMB_MASK, BMA400_EVAL_X_OR_Y_OR_Z) |
+			FIELD_PREP(BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK, BMA400_DETECT_ACTIVITY);
 		set_mask_bits(&field_value, BMA400_INT_CONFIG0_GEN1_MASK,
 			      FIELD_PREP(BMA400_INT_CONFIG0_GEN1_MASK, state));
 		break;
 	case IIO_EV_DIR_FALLING:
 		reg = BMA400_GEN2INT_CONFIG0_REG;
 		msk = BMA400_INT_CONFIG0_GEN2_MASK;
-		value = 0;
+		value = FIELD_PREP(BMA400_GENINT_CONFIG1_AXES_COMB_MASK, BMA400_EVAL_X_OR_Y_OR_Z) |
+			FIELD_PREP(BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK, BMA400_DETECT_INACTIVITY);
 		set_mask_bits(&field_value, BMA400_INT_CONFIG0_GEN2_MASK,
 			      FIELD_PREP(BMA400_INT_CONFIG0_GEN2_MASK, state));
 		break;
@@ -1182,7 +1184,13 @@ static int bma400_activity_event_en(struct bma400_data *data,
 	}
 
 	/* Enabling all axis for interrupt evaluation */
-	ret = regmap_write(data->regmap, reg, 0xF8);
+	ret = regmap_write(data->regmap, reg,
+			   BMA400_GENINT_CONFIG0_X_EN_MASK |
+			   BMA400_GENINT_CONFIG0_Y_EN_MASK |
+			   BMA400_GENINT_CONFIG0_Z_EN_MASK|
+			   FIELD_PREP(BMA400_GENINT_CONFIG0_DATA_SRC_MASK, ACCEL_FILT2)|
+			   FIELD_PREP(BMA400_GENINT_CONFIG0_REF_UPD_MODE_MASK,
+				      BMA400_REF_EVERYTIME_UPDT_MODE));
 	if (ret)
 		return ret;
 
-- 
2.43.0


