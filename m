Return-Path: <linux-kernel+bounces-843786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEE6BC0453
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 07:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697003BDA35
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 05:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2DE21FF38;
	Tue,  7 Oct 2025 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZsIoFUA"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9456D214A79
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759816536; cv=none; b=D/wx7z7rWa8WWERCruJpGqJaysR2eehJnFy9lAoSxX6xC92CCXfyI26bPKkDxDbZT4/PWsycdUzWAe+O6yfdGYrd+ArQs8h6m6u5M0Uo2vsMF/J28JN8nlW/T2XIcOHaV0P4a6Mg/1+zTVDeiuDaDop2cpDQTDpOpQixzo++TYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759816536; c=relaxed/simple;
	bh=ZeuZdARXiHTymxE1JlTUOp5nSPhm3AOcEAYBoYJnaes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0UhrcG/UW1PhgD1RymjfIdwtBe7wQSZVGHwsEd+TGnaDtQNdJlS6mekFs0vXqSPl6sLVJmNrotyll0xF2otOUPteEzPCwoSf/CBkkU9rtKU7dYqs/ABfa5CDNUFHEJ1GRHLpm52u5JnEACxawPz8mmtiZ5b8z+lKeYH82qAb0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZsIoFUA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f1f29a551so7373594b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759816534; x=1760421334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0X1+1j7EZByUZ/MjMj/zCkGEHjVnb1pL8CqUc0voxw4=;
        b=jZsIoFUAzHrvZbS9/rDo1YhiW4EggRtba6uCUYnrVRkayym4mDqZOeRhTOATOWJboz
         I7gIweixT93Aa7ybwFdfFx5EDTEnvoMg4RQDSeiPvGqNnNXQ7WvWY93hZKh3puzEZJ41
         iFe3iqn62dzoM6fojc/i56EjL3ryMy5piP+6Phxh2K7ocVRP8ya5PGCUH4ABmB63xz7Y
         DbNK0pirzIUAK1OAoL9wYdgVzVh+6SOgqL5zT6ITZd/ccijx8OljPw92NFUm9v3K8rXl
         I8eEKvJGVfr61ZjvzWt34Z5TQRRLIBFUck2wkjRDIWFgCZO07iSfUZOve0bACrobnsie
         1vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759816534; x=1760421334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0X1+1j7EZByUZ/MjMj/zCkGEHjVnb1pL8CqUc0voxw4=;
        b=oGtz3UmzY0kabcmj2WSUI/KnBYly0tX0rlgKXPrU+kZdBzrc+JCTpxSuwvOR6+FiCy
         s4Zz6/8slNOTo32QajmxCleQQe13/1OIPblnzSOXpOCZt05VAFPvWOS5ImW8mvpRzwU+
         uNYVit79+esrJuM5UBLmX7LpTN50P4/8AQ6Ph0qf6MNoKkwhdC+hdqOamhP4GN1I4NY2
         iZpxoI/p4/By/4TT3qkCOLhRcPlLI8CRGoOKZz2H1ldM23UaglxdpI0d+eNIWlUhkLCe
         hd4OyTvKNYOx3PejYGajmIIFvZ2MMxnKDTk5xoo+tWhWz/GqDUGtpvdxdNns58hzr8xy
         N1iw==
X-Forwarded-Encrypted: i=1; AJvYcCUHgYJJN54hVQAB0yNk3K60FRwptIn+YgMQ7qNqa7ykP682EDl8KEwi4QgCs75oBV7z/sgpc7CM8YS46UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQy5Tq+IRFT7/0eqNtaiSwo9vJN1A+BG3KW9uSZWnhyY1O9t96
	CgpsJiRKTFQSImG28HYPfneBzjFFUb5tjZ+7IpPKdP8oIcdeVNmKKntG
X-Gm-Gg: ASbGncvY9So2VcHocwf2pmhP4Dkg7l5iKatFG0aqcVHAjGz3PGlKuMUfCqK46qGVHTU
	Nuic1B41kbKTV4BPYTNyAIoTwxiY6VFFnJIGlDsvsge3IhjJWsoQ8edrEitZen0mAvds5qIeX0g
	ZqDi7iRCWq9JmBqWqtKGGLSZKXAhV1NpAyXIDDxpFCuzcCJaCSl6TWmgubBTcTkJTzmxt3JM1F+
	/Tw83ecXi2gXrmShZp55If2+mjEgeWWYcXUKbv2pS/wvu9gw9/qUgC2QEj3cHjl0hHb98ygOj/N
	r/EYncivabDFk2AOL3SnNaCmstbPt2jF2Crg9AVkibHYozYCA3wh2ATmAZJYcENZMpbdTIgUuaj
	eLYiZmtlDLh/yfkI99VbhBkdFamHn2ZaWPcXKSOXRpV6orFv8X1CPvS7E
X-Google-Smtp-Source: AGHT+IHSS//6jn631H9SIMTuLsvPZlhi2waQ0tfsUdXJNWA75Dgnd2jEdLw04ZD5wYBDEl3kfzmYmg==
X-Received: by 2002:a05:6a21:e083:b0:253:1e04:4e8 with SMTP id adf61e73a8af0-32b62107fcdmr20491457637.56.1759816533863;
        Mon, 06 Oct 2025 22:55:33 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.78.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a1a9e8sm12983829a91.11.2025.10.06.22.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 22:55:33 -0700 (PDT)
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
Subject: [PATCH v4 2/6] iio: accel: bma400: Use macros for generic event configuration values
Date: Tue,  7 Oct 2025 11:25:02 +0530
Message-ID: <20251007055511.108984-3-akshayaj.lkd@gmail.com>
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

Add macros and enums for configuration values used in generic event
handling for activity and inactivity detection. Replace hard-coded
values in activity_event_en() with the new definitions to make the
configuration explicit.

No functional changes are intended.

Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
---

Changes since v3:
- Assigned explicit values to reg field enums introduced.

 drivers/iio/accel/bma400.h      | 30 ++++++++++++++++++++++++++++++
 drivers/iio/accel/bma400_core.c | 14 +++++++++++---
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
index ae3411c090c9..60fc323958f3 100644
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
+	ACCEL_FILT1 = 0x0,
+	ACCEL_FILT2 = 0x1,
+};
+
+enum bma400_ref_updt_mode {
+	BMA400_REF_MANUAL_UPDT_MODE = 0x0,
+	BMA400_REF_ONETIME_UPDT_MODE = 0x1,
+	BMA400_REF_EVERYTIME_UPDT_MODE = 0x2,
+	BMA400_REF_EVERYTIME_LP_UPDT_MODE = 0x3,
+};
 
 #define BMA400_GEN_CONFIG1_OFF      0x01
+#define BMA400_GENINT_CONFIG1_AXES_COMB_MASK	BIT(0)
+#define BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK	BIT(1)
+
+enum bma400_genintr_acceleval_axescomb {
+	BMA400_EVAL_X_OR_Y_OR_Z = 0x0,
+	BMA400_EVAL_X_AND_Y_AND_Z = 0x1,
+};
+
+enum bma400_detect_criterion {
+	BMA400_DETECT_INACTIVITY = 0x0,
+	BMA400_DETECT_ACTIVITY = 0x1,
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


