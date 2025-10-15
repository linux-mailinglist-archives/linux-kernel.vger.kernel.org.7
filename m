Return-Path: <linux-kernel+bounces-854860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DCCBDF9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9A219A2F78
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C05F2BE7D9;
	Wed, 15 Oct 2025 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fagthP9B"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF625EFBF
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544986; cv=none; b=hMGYdZMSRSdNApd+2SmpyIQ+QAWteh9doywtv1a3NsyTlQc7p2uN1k+tOTyK984C+hmEUAZw7yYZIgaNmCNEEiHZCzlN0k6TQ0EeUVODS2BisrTEt2RQYYqyw7sm224lTzLMHtoQhIvVDlMo3y821CQV1tTXNc9GH9RC1PQdSlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544986; c=relaxed/simple;
	bh=ABsvn3CifAgPNbiNNauHoJn45SqYrllPKwIsUYgWcok=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NLMBh6qc3Q/v6DZcOM0WynKGo7A0Gw2H0ev+bM/YrxMu5p90/PEjJbYAcJJEBTLqF6eKWAYjyZNUgLlaYfnBFAsHojkOEbURXm7be1IXcDjBmjFE2LaghK6bALCHgO2aG07O2TsELnvjHGIbBjQSMUqna4Pjx6ddaOEXjv7PpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fagthP9B; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710022571cso7216505e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760544983; x=1761149783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1jhFeHhxricwTrw7zKiCatYtcIZJsLq8LCeG7tZdkc=;
        b=fagthP9B2lnlOjQ0CwRDGj48stZvJsdAqoQ8CesHOMEDfnwIjdNpHe+PbGsOAAptQH
         Bpnqlm67GKPP5qrz/BmOe2kUpYB50Rg68qYfGN6+iBefgrUVwKJnJlABP/IXPzOkZA4+
         FJIThW1eKa1wMnrXaPTfhfAeOq6nvnRKvRPNt8Vr2Im8IFEe18YOFnFNfyKi4cw+I4IP
         sd76j0ruF9WpTkoPzvUxOuHnDBvi6p0OEwYJ/UtrX9ofMBrd96+brexgZRO2HKUxxB7Y
         E6Q7wHQY5TxrTi+8+9tJruSEP6TYmpfX6acmn85RU91CBzE05rZfX5E9NF5sklTGk4OV
         CCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760544983; x=1761149783;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1jhFeHhxricwTrw7zKiCatYtcIZJsLq8LCeG7tZdkc=;
        b=Kv+wjm06y3brH+4i1fm4fbdsDb5MSdV3WZ8tcOGBV247LlLaEXuUrBrtlKvo7yVQpP
         wJ/xQQ5UBbfJPBbmnSYEBCUEoJ+hkGLy/xVgxPjRo5wjSHACXrqG2NzbQ5wYGh/W0NGD
         s38ojrKN3CvSqvKVIKLWDNy/1CfGKk6m3zMVZDO4e+7Qwh8zYJFcYYFgPOgSEdGXXsfg
         nyDCABbkxPtRHD9aCABRQ+lZqk1Q8CvIRYpcUeb/zXYnUazhqI/liOU68KULRZsjRIf9
         HboABzHJQa9brNns4bUTRlJ+8V3CCf7DmuFLn8Jei7DpJJmdRC5FOAZGRbGHOJH9CzoI
         nsVw==
X-Forwarded-Encrypted: i=1; AJvYcCV20drKZNAUp+xmyoZ79wY9J4r1+DRlRrzs9VCtVGMGY5wDM+VmzE63GE2VX0UBCD3lo/pTeeUJN2cBsvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR6o7ZSCFAI4fmd3bCJTNIY4uFQH3Ix8OxuHLoSwECQCfQKhmT
	nPQCj9NxNYxlITuhvDlI1uHbcAyoudxQJwJak40do86ZtHdVSOPkirMI+LWiWWtQ
X-Gm-Gg: ASbGncvUKjvuSX9nwYRoMajnVhUbYjCv4mNB39Qm8zisC8MydSJRHaSCb1JuMBYQVV0
	01uy32LCQmUfbxLxqanAcwlv0aynCKroFTuTB+mw4tevO2m7DbhsliKVjW0bCibl0mQONi0e0cF
	c/WqE1m8L9qPeamgAufzgRgqpFSGPwCHxO18Dbx+8XOmiO8fvYIrz6BJJ8KgCxBTyKMEhPhYIwL
	91CrCBvsIEsRRVQpX/sh/uui9HRQchB2v3/vEmMyG9AYk1fZRkjkSWRoOesBV4/t8zmHY6C+IlR
	dlDjVG/4leZJ3bwvSfpf10oEUo4auVoDa5RVplj0dTMW/niOS+JnLrsBKNa0hddsHLDiYreFu39
	3Yn2/TOWrF0+Dg5wl1e4nfGk5RCh2x0LWFgn7X6PZz1owVrP1Nvm9kp3R+iFT5yw=
X-Google-Smtp-Source: AGHT+IEDFLngjLhH+qa5J3SdfKbetfYwDdtqRpZ172a3AEduhHeAZwUjGeGS3B4m2q6J/gfPbFxn8A==
X-Received: by 2002:a05:6000:2586:b0:425:73ef:b034 with SMTP id ffacd0b85a97d-4266e8f7f4cmr20106882f8f.36.1760544982479;
        Wed, 15 Oct 2025 09:16:22 -0700 (PDT)
Received: from ctocxl9700.oa.cto.st.com ([37.161.98.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47101be3468sm38033775e9.2.2025.10.15.09.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:16:21 -0700 (PDT)
From: Mario Tesi <martepisa@gmail.com>
X-Google-Original-From: Mario Tesi <mario.tesi@st.com>
Date: Wed, 15 Oct 2025 18:16:19 +0200
To: lorenzo@kernel.org, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: st_lsm6dsx: Fixed calibrated timestamp calculation
Message-ID: <20251015161619.GA87736@ctocxl9700.cto.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The calibrated timestamp is calculated from the nominal value using the
formula:
  ts_gain[ns] ≈ ts_sensitivity - (ts_trim_coeff * val) / 1000.

The values of ts_sensitivity and ts_trim_coeff are not the same for all
devices, so it is necessary to differentiate them based on the part name.
For the correct values please consult the relevant AN.

Signed-off-by: Mario Tesi <mario.tesi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 18 ++++++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 19 ++++++++-----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index c225b246c8a5..f8486a1b02d0 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -192,6 +192,22 @@ struct st_lsm6dsx_fifo_ops {
  * @fifo_en: Hw timer FIFO enable register info (addr + mask).
  * @decimator: Hw timer FIFO decimator register info (addr + mask).
  * @freq_fine: Difference in % of ODR with respect to the typical.
+ * @ts_sensitivity: Nominal timestamp sensitivity.
+ * @ts_trim_coeff: Coefficient for calculating the calibrated timestamp gain.
+ *                 This coefficient comes into play when linearizing the formula
+ *                 used to calculate the calibrated timestamp (please see the
+ *                 relevant formula in the AN for the specific IMU).
+ *                 For example, in the case of LSM6DSO we have:
+ *
+ *                  1 / (1 + x) ~= 1 - x (Taylor’s Series)
+ *                  ttrim[s] = 1 / (40000 * (1 + 0.0015 * val)) (from AN5192)
+ *                  ttrim[ns] ~= 25000 - 37.5 * val
+ *                  ttrim[ns] ~= 25000 - (37500 * val) / 1000
+ *
+ *                  so, replacing ts_sensitivity = 25000 and
+ *                  ts_trim_coeff = 37500
+ *
+ *                  ttrim[ns] ~= ts_sensitivity - (ts_trim_coeff * val) / 1000
  */
 struct st_lsm6dsx_hw_ts_settings {
 	struct st_lsm6dsx_reg timer_en;
@@ -199,6 +215,8 @@ struct st_lsm6dsx_hw_ts_settings {
 	struct st_lsm6dsx_reg fifo_en;
 	struct st_lsm6dsx_reg decimator;
 	u8 freq_fine;
+	u16 ts_sensitivity;
+	u16 ts_trim_coeff;
 };
 
 /**
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index d8cb4b0218d5..a2daf0c14d96 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -94,8 +94,6 @@
 
 #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
 
-#define ST_LSM6DSX_TS_SENSITIVITY		25000UL /* 25us */
-
 static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
 	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
 	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
@@ -983,6 +981,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(7, 6),
 			},
 			.freq_fine = 0x63,
+			.ts_sensitivity = 25000,
+			.ts_trim_coeff = 37500,
 		},
 		.shub_settings = {
 			.page_mux = {
@@ -1196,6 +1196,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(7, 6),
 			},
 			.freq_fine = 0x63,
+			.ts_sensitivity = 25000,
+			.ts_trim_coeff = 37500,
 		},
 		.event_settings = {
 			.enable_reg = {
@@ -1371,6 +1373,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = GENMASK(7, 6),
 			},
 			.freq_fine = 0x4f,
+			.ts_sensitivity = 21701,
+			.ts_trim_coeff = 28212,
 		},
 		.shub_settings = {
 			.page_mux = {
@@ -2248,20 +2252,13 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm6dsx_hw *hw)
 	}
 
 	/* calibrate timestamp sensitivity */
-	hw->ts_gain = ST_LSM6DSX_TS_SENSITIVITY;
+	hw->ts_gain = ts_settings->ts_sensitivity;
 	if (ts_settings->freq_fine) {
 		err = regmap_read(hw->regmap, ts_settings->freq_fine, &val);
 		if (err < 0)
 			return err;
 
-		/*
-		 * linearize the AN5192 formula:
-		 * 1 / (1 + x) ~= 1 - x (Taylor’s Series)
-		 * ttrim[s] = 1 / (40000 * (1 + 0.0015 * val))
-		 * ttrim[ns] ~= 25000 - 37.5 * val
-		 * ttrim[ns] ~= 25000 - (37500 * val) / 1000
-		 */
-		hw->ts_gain -= ((s8)val * 37500) / 1000;
+		hw->ts_gain -= ((s8)val * ts_settings->ts_trim_coeff) / 1000;
 	}
 
 	return 0;
-- 
2.25.1


