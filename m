Return-Path: <linux-kernel+bounces-849647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15947BD093C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7B2B4E4FCD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D6E2F068E;
	Sun, 12 Oct 2025 18:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+hbt/Am"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0E92EFDAC
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292425; cv=none; b=n/HH19fii6/OF1AmmODVUeeyFhNPyzOe+zQWy1OMLecCB5N5zM4xlhHYIlgGSCOuqG8AstC8UwFLurZEE3zBQmd3y2PM/Rz/0GsmadeEQv5vpomDhEq9Y7GQMBY4mwlPaFhuy/63wC68d36ddt0y2v90t2jJC8HghT8Uyt3+R24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292425; c=relaxed/simple;
	bh=ClX01rlXMoXjKQ/J6oSs+dW0I5v1HXnoT4iu6978AV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdJLz0wl6ORCrxkGZyS+5U5235aJjtWeMrm5vPNPLwb99kgJb4XKGXF81o/1CPeKFSdZh6DMvYj04oj8REy5Z1OO1400bJiOUmmPtsMXC72RG36LncQ9TK+WEibq5rhML6qbi2w1OayChQNpZpH8STaGlNWaVYLeNEd/tR5Aa/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+hbt/Am; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7835321bc98so3364912b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 11:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292423; x=1760897223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EA5A5uOGNzPpYhd/jiWtutSSlSi/Og+euueasT4P/UE=;
        b=a+hbt/AmpbEQR3HX8az8hr6Ahj2w+ixD8/nax/XTgY7Kr2SNz6oL1CGIQrqC7xXCFu
         OYtU2XVNWwcyssBmQidbjK8KjskVR9hiDwCFlu+Q9Rjt+jSnXMzTRDBnGW2udgXK2rCG
         h5YKektL5XXCr+WaUSC2MTtD7sliqkugF7xfW17dGAaFRsEOVTplWYvVjH28Ced40Pm9
         0r6Al5vt4isFOIpXMgbXhCcoAPst9Td8E6T6yKJYKVn3DU+cEni2Gz9BMgd35auBzVHp
         pinqAyIMJUHNQw/dYt4MiGR8Nx5pohOiGNEEnJWTpXQ+m9ughYwka/md/JBKiPMIilOn
         mgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292423; x=1760897223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EA5A5uOGNzPpYhd/jiWtutSSlSi/Og+euueasT4P/UE=;
        b=mwUIzAfsVOe4zQNLlix6MFOdCjC69wt9Uuk74VgVugYXJvPEmhr8U51//s57RyTHB7
         /EWDx+3sMXS3PashLKDiH6yDLji3JMB5Q9PQ6hlPCZkdYz1LFFNi0ITW7PPMRYV8izHQ
         nOtUOZMaNTeo2AE+KXGfp9ZYk9eTEJyaThcNMjtyVC5DjKWfaRh/AJmvF/EGCUJOqRnL
         NdNuWB6H3udouBgqiPUsQnhtn8S/6QNaO5SM70Ma090A95aiWi4cdAufaOpITonlUwrz
         /tsxmxTWYNCOSh0d+orxvxlOabBuz0dyEocZKbCMLcNuddh+32OrMCAqZr78gPL83Wq9
         o6hw==
X-Forwarded-Encrypted: i=1; AJvYcCXHZUqLYLptIJ5ceSipASPYRu+RFuicA97xerTnXfkItgtEarRLmPxHjjnsNfELd/8Bb6W9hVZtQpJqzh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPJFmUFdLWJa6SMpeE5o7PSJHJuscLIz1/pdiv4PiioxHBD7mC
	q0DVSOMGTNJDTuOVOlfVaoZfaI5RYKVqOD4XOPv8yg4Vl9o93+QGVsZpgGxEWA==
X-Gm-Gg: ASbGnctR44ttK6oZj4QLiQf08pFk5bO6Z35pkwUTxx6vqsN6ZBSt5qwtog96B7C+ECV
	dowA+MR7biM6TrSCKOojeWp97OMhCOZXk4RNUBqqNM+HUUAAa26FKhaMAxLkByDWDfeXLBje8dV
	XJxCCBPrbW8WNJm+mCK1MRWPn9zIRzaNTccPRJbysJIuj2b3w3JNWn7jzJZqqon0NDuL/j5mePg
	fj/OzTPMm//LleC2YYpqmNMK8wWwzTtnZlCZ/0so/hIDaWQOOEItVWDx3aCNcYw9p/Rx/jY1K4e
	Dqy0K2jcj4YhqB124W19nti5k0BbkchgrXK7tkfgcEYSf9WyoJjUm65nNPcTp9kOkvRIJfYCt7m
	7oA9Pxe/Du4g/T5p0LFgUYL2dCOV0MBC58Zhl0FwbmQN8bHV6nis=
X-Google-Smtp-Source: AGHT+IFiF/Ba1DV6ZO0HpC19hA+TpwY4BxbEecfq0ewa8tmyEUIHREHyuLz2xm3GCuT7NlL4ULrsPw==
X-Received: by 2002:a17:902:d588:b0:27e:f06b:ae31 with SMTP id d9443c01a7336-290273a5f2bmr234627825ad.61.1760292422854;
        Sun, 12 Oct 2025 11:07:02 -0700 (PDT)
Received: from akshayaj-lenovo.. ([223.233.65.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f56c0fsm111734345ad.104.2025.10.12.11.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:07:02 -0700 (PDT)
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
Subject: [PATCH v5 2/6] iio: accel: bma400: Use macros for generic event configuration values
Date: Sun, 12 Oct 2025 23:36:09 +0530
Message-ID: <20251012180619.195244-3-akshayaj.lkd@gmail.com>
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
index fcafd1fba57a..12e7bf5fe647 100644
--- a/drivers/iio/accel/bma400.h
+++ b/drivers/iio/accel/bma400.h
@@ -113,8 +113,38 @@
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
index 2324c4ef645c..46855073ce3a 100644
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


