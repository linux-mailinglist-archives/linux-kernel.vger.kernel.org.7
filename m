Return-Path: <linux-kernel+bounces-587100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF51A7A7D1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 18:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 862357A33BA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C37253B54;
	Thu,  3 Apr 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TcThyohW"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1512125179F
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697234; cv=none; b=X6pD4wrUrYfq85/exYvKpYGUzsrunvaBUNJvRxEKXlGxfJJZf6o6ciEr/DfIoldoNAnxaOPtZevI1Cf4Qh6oxwWPpDqOYTGh9BfFHcINwwxbhaYF6ak1Vi6lpjklR8ytNVktzsVGnrOIuvWzmmYYu8o8AE9pzHek9lNLhd84svc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697234; c=relaxed/simple;
	bh=GAuwtVV2LPz6cQ7YQ57GL+yH6PAnOCH4FqR/ZBoZFx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wk5Fyf61IQkJ3ayZVLCTgBPPeQEcSLvxG30z1Qn1BLmg8ERbHUMxD1CQCFsw/oiMyP059+1W3IWTWceGuSjvDQLv62r5SgrEc9z5BK8eb4+GXMgZUsGpKC2BB714jQNLsfKJCIHe2FdVzHMMPym1mKPAM+HQF6uoBxdStofYiwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TcThyohW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso7242555e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Apr 2025 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743697230; x=1744302030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TfY4qSk60hX3lLReIodKR9Eo5X5vrCTMKVPYT7mkh8=;
        b=TcThyohWsd9nE11N9Tb7t+NaAEWUfNZgcjfQH3J8A9QxE4Sl5ekYHuPkFJPb6hxpRt
         yL4Gju40zSP84rm067YWflR8cMUXvd7EiWu3LoFY+iAHcSnw3VvVEJESkew4g2OUNbI1
         hqM8gKRwDdadQBde/vdsmKiOHnS5Jdu4zxdXe6/IXRtVi2/oaEiv5QlUeONLunAP1tXI
         +ObFPLziJglA4oHC4N6x9BnNzKvnVLUx+E7VzQN0kOrIio+FwPHatBMYtD0pVAvcei3N
         nWnmqMFpRAMnFBifBRmDLU5wfQDplf73CnVBjyctVAzbSCDBxAFYKoHnJNkqZ+hyNWcC
         Telg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743697230; x=1744302030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TfY4qSk60hX3lLReIodKR9Eo5X5vrCTMKVPYT7mkh8=;
        b=LqBu3q3lD+QtzrO83lqd9FOaBmF548+lTss2u0zY7g2jRi6QQRM7gY9LjKWTjHNc5X
         brgbh6mcqscfULg+JftxDR1yQWZT65Um01VS2wOVimWb2IfpElzJbHVHlO31Zmx2cYzS
         MIXY76h/Q7iG4qxmIRSMjyRVgI5u+kShi6n+mDjn5+LSCwTlffUgG9sYb5nKc/yI8GQY
         XUCjAJqSfFEguVv4ffXrXuVw7g1d1BqTjPQZBj262bK8Y7dcppXAutjtcNWEFQ2D16b8
         Sbk1NTQLTL3ywKqU/ho6uwsj5dEfXQVt4fu4/HJ5DTC3EU1CNaG/mlF58aLwaz8SvUia
         lsoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnHIZgFup1yGFnjGdpnJXd1Zj7CEW1fCYUk8k/02tdw6HLnytcocE16EbYD4oPnzJRPfBXrUqwslI5lwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbWlJA4UQ8plVCQsOfzU6CKwntay4XxS3nsCOPeEgX89HZ4UUC
	gWkHNrU8IbmeAOwXcXf29bGOfIbZMmrSIAYy9mZmsz6aFwPoE8EbQM+ajrDBVxA=
X-Gm-Gg: ASbGncspf4ad2cIG59H2+3SJqkYGmoAUJBrYMg35aZgENGMAC+WmaWXSfavavZBGQH3
	gMFqDIV/lZIevw12Fkas5kIBf1yodFlPYbLYff94hqCS93ip/M9ACP4Opo0esd9SkNLHfYTXHJH
	v0AUdjU7infoy8h05iGaESgU1j61+1TiUvTGb+HqI5a7gY60GYZBcdGNVx+uxdYBJUKMneSjygT
	FZ6G5H71I6+w/9Q8gaScsK9zsiinODsYK4pVcfGtCLtfs4G6EIH1qA26BNnEMZvs6nMLxEQ0Vj4
	gCXVIcK+cWCqbECXk4uq1fZ66zflNUBScu6JafM4CdY/X9becYqtEWgJnNttBVcs4UVysbKjMW7
	eqC0+mVwgwZqD25PnsUF2qQ==
X-Google-Smtp-Source: AGHT+IF8xYIBszIt76N3/Vj2/PAhkC7PlGgmLrnJ+KJlZmDpzXDRD/T6jtosHO8b5MQ8RilTZSurvg==
X-Received: by 2002:a05:600c:3547:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-43eb06bd359mr95792075e9.30.1743697230016;
        Thu, 03 Apr 2025 09:20:30 -0700 (PDT)
Received: from [192.168.0.2] (host-79-30-116-65.retail.telecomitalia.it. [79.30.116.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d68esm2197657f8f.67.2025.04.03.09.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 09:20:29 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 03 Apr 2025 18:19:06 +0200
Subject: [PATCH 3/3] iio: adc: ad7606: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-wip-bl-spi-offload-ad7606-v1-3-1b00cb638b12@baylibre.com>
References: <20250403-wip-bl-spi-offload-ad7606-v1-0-1b00cb638b12@baylibre.com>
In-Reply-To: <20250403-wip-bl-spi-offload-ad7606-v1-0-1b00cb638b12@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=19074;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=sTlXALFQnPjy07d36wd4636kyW9SEMVlwtfX04R/tNc=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkh/t5Up+LqA22x+LxZdISUx9X+Muh826k2c5qu7nOGOy
 hxb3imxHaUsDGJcDLJiiix1iREmobdDpZQXMM6GmcPKBDKEgYtTACZycBkjw8foP32eVS3P20PU
 dvNb/Hhc2yCb3XZmjz0zw4qeWVMYTRkZ3m1s/eHCrOEaaLm08c/Rbi6nBLY/Ww+0LZtRdGnK57O
 HmAE=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add SPI offload support for this family.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/Kconfig      |   2 +
 drivers/iio/adc/ad7606.c     |  50 ++++++++---
 drivers/iio/adc/ad7606.h     |  12 +++
 drivers/iio/adc/ad7606_spi.c | 210 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 264 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 859c77f40f1d1893d0fc92212ad538150f0992c8..df90db609f683217cffaeb605aa9b6f022cf2b9b 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -284,6 +284,8 @@ config AD7606_IFACE_SPI
 	tristate "Analog Devices AD7606 ADC driver with spi interface support"
 	depends on SPI
 	select AD7606
+	select IIO_BUFFER_DMAENGINE
+	select SPI_OFFLOAD
 	help
 	  Say yes here to build spi interface support for Analog Devices:
 	  ad7605-4, ad7606, ad7606-6, ad7606-4 analog to digital converters (ADC).
diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 843c30fddc7346d0dec7d791e26ca16e2c1ea0cf..aa6ae2c1b06acfa5d38229827e37fed1c2f82870 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -138,6 +138,7 @@ const struct ad7606_chip_info ad7606_6_info = {
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
+	.offload_storagebits = 32,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606_6_info, "IIO_AD7606");
 
@@ -149,6 +150,7 @@ const struct ad7606_chip_info ad7606_4_info = {
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
+	.offload_storagebits = 32,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606_4_info, "IIO_AD7606");
 
@@ -161,6 +163,7 @@ const struct ad7606_chip_info ad7606b_info = {
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
+	.offload_storagebits = 32,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606b_info, "IIO_AD7606");
 
@@ -173,6 +176,7 @@ const struct ad7606_chip_info ad7606c_16_info = {
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606c_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
+	.offload_storagebits = 32,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606c_16_info, "IIO_AD7606");
 
@@ -184,6 +188,7 @@ const struct ad7606_chip_info ad7607_info = {
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7607_chan_scale_setup,
+	.offload_storagebits = 32,
 };
 EXPORT_SYMBOL_NS_GPL(ad7607_info, "IIO_AD7606");
 
@@ -195,6 +200,7 @@ const struct ad7606_chip_info ad7608_info = {
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7608_chan_scale_setup,
+	.offload_storagebits = 32,
 };
 EXPORT_SYMBOL_NS_GPL(ad7608_info, "IIO_AD7606");
 
@@ -206,6 +212,7 @@ const struct ad7606_chip_info ad7609_info = {
 	.oversampling_avail = ad7606_oversampling_avail,
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7609_chan_scale_setup,
+	.offload_storagebits = 32,
 };
 EXPORT_SYMBOL_NS_GPL(ad7609_info, "IIO_AD7606");
 
@@ -218,6 +225,7 @@ const struct ad7606_chip_info ad7606c_18_info = {
 	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	.scale_setup_cb = ad7606c_18bit_chan_scale_setup,
 	.sw_setup_cb = ad7606b_sw_mode_setup,
+	.offload_storagebits = 32,
 };
 EXPORT_SYMBOL_NS_GPL(ad7606c_18_info, "IIO_AD7606");
 
@@ -232,6 +240,7 @@ const struct ad7606_chip_info ad7616_info = {
 	.os_req_reset = true,
 	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
 	.sw_setup_cb = ad7616_sw_mode_setup,
+	.offload_storagebits = 16,
 };
 EXPORT_SYMBOL_NS_GPL(ad7616_info, "IIO_AD7606");
 
@@ -514,7 +523,7 @@ static int ad7606_pwm_set_high(struct ad7606_state *st)
 	return ret;
 }
 
-static int ad7606_pwm_set_low(struct ad7606_state *st)
+int ad7606_pwm_set_low(struct ad7606_state *st)
 {
 	struct pwm_state cnvst_pwm_state;
 	int ret;
@@ -527,8 +536,9 @@ static int ad7606_pwm_set_low(struct ad7606_state *st)
 
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(ad7606_pwm_set_low, "IIO_AD7606");
 
-static int ad7606_pwm_set_swing(struct ad7606_state *st)
+int ad7606_pwm_set_swing(struct ad7606_state *st)
 {
 	struct pwm_state cnvst_pwm_state;
 
@@ -538,6 +548,7 @@ static int ad7606_pwm_set_swing(struct ad7606_state *st)
 
 	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
 }
+EXPORT_SYMBOL_NS_GPL(ad7606_pwm_set_swing, "IIO_AD7606");
 
 static bool ad7606_pwm_is_swinging(struct ad7606_state *st)
 {
@@ -626,7 +637,7 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 	 * will not happen because IIO_CHAN_INFO_RAW is not supported for the backend.
 	 * TODO: Add support for reading a single value when the backend is used.
 	 */
-	if (!st->back) {
+	if (st->trig) {
 		ret = wait_for_completion_timeout(&st->completion,
 						  msecs_to_jiffies(1000));
 		if (!ret) {
@@ -634,7 +645,12 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 			goto error_ret;
 		}
 	} else {
-		fsleep(1);
+		/*
+		 * If the BUSY interrupt is not available, wait enough time for
+		 * the longest possible conversion (max for the whole family is
+		 * around 350us).
+		 */
+		fsleep(400);
 	}
 
 	ret = ad7606_read_samples(st);
@@ -1201,7 +1217,7 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
 	bool slow_bus;
 	int ret, i;
 
-	slow_bus = !st->bops->iio_backend_config;
+	slow_bus = !(st->bops->iio_backend_config || st->offload_en);
 	indio_dev->num_channels = st->chip_info->num_adc_channels;
 
 	/* Slow buses also get 1 more channel for soft timestamp */
@@ -1222,7 +1238,14 @@ static int ad7606_probe_channels(struct iio_dev *indio_dev)
 		chan->scan_index = i;
 		chan->scan_type.sign = 's';
 		chan->scan_type.realbits = st->chip_info->bits;
-		chan->scan_type.storagebits = st->chip_info->bits > 16 ? 32 : 16;
+		/*
+		 * If in SPI offload mode, storagebits are set based
+		 * on the spi-engine hw implementation.
+		 */
+		chan->scan_type.storagebits = st->offload_en ?
+			st->chip_info->offload_storagebits :
+			(st->chip_info->bits > 16 ? 32 : 16);
+
 		chan->scan_type.endianness = IIO_CPU;
 
 		if (indio_dev->modes & INDIO_DIRECT_MODE)
@@ -1340,6 +1363,13 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	indio_dev->modes = st->bops->iio_backend_config ? 0 : INDIO_DIRECT_MODE;
 	indio_dev->name = chip_info->name;
 
+	/* Using spi-engine with offload support ? */
+	if (st->bops->offload_config) {
+		ret = st->bops->offload_config(dev, indio_dev);
+		if (ret)
+			return ret;
+	}
+
 	ret = ad7606_probe_channels(indio_dev);
 	if (ret)
 		return ret;
@@ -1355,7 +1385,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	}
 
 	/* If convst pin is not defined, setup PWM. */
-	if (!st->gpio_convst) {
+	if (!st->gpio_convst || st->offload_en) {
 		st->cnvst_pwm = devm_pwm_get(dev, NULL);
 		if (IS_ERR(st->cnvst_pwm))
 			return PTR_ERR(st->cnvst_pwm);
@@ -1394,8 +1424,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 			return ret;
 
 		indio_dev->setup_ops = &ad7606_backend_buffer_ops;
-	} else {
-
+	} else if (!st->offload_en) {
 		/* Reserve the PWM use only for backend (force gpio_convst definition) */
 		if (!st->gpio_convst)
 			return dev_err_probe(dev, -EINVAL,
@@ -1433,7 +1462,8 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->write_scale = ad7606_write_scale_hw;
 	st->write_os = ad7606_write_os_hw;
 
-	if (st->sw_mode_en) {
+	/* Offload needs 1 DOUT line, applying this setting in sw_setup_cb. */
+	if (st->sw_mode_en || st->offload_en) {
 		indio_dev->info = &ad7606_info_sw_mode;
 		st->chip_info->sw_setup_cb(indio_dev);
 	}
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index f0b262fb4554f0bf244338c98ca585143321d616..89d49551eaf515bab9706c12bff056dfcb707b67 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -60,6 +60,7 @@ typedef int (*ad7606_sw_setup_cb_t)(struct iio_dev *indio_dev);
  * @os_req_reset:	some devices require a reset to update oversampling
  * @init_delay_ms:	required delay in milliseconds for initialization
  *			after a restart
+ * @offload_storagebits: storage bits used by the offload hw implementation
  */
 struct ad7606_chip_info {
 	unsigned int			max_samplerate;
@@ -72,6 +73,7 @@ struct ad7606_chip_info {
 	unsigned int			oversampling_num;
 	bool				os_req_reset;
 	unsigned long			init_delay_ms;
+	u8				offload_storagebits;
 };
 
 /**
@@ -118,6 +120,8 @@ struct ad7606_chan_scale {
  * @trig:		The IIO trigger associated with the device.
  * @completion:		completion to indicate end of conversion
  * @data:		buffer for reading data from the device
+ * @offload_en:		SPI offload enabled
+ * @bus_data:		bus-specific variables
  * @d16:		be16 buffer for reading data from the device
  */
 struct ad7606_state {
@@ -145,6 +149,9 @@ struct ad7606_state {
 	struct iio_trigger		*trig;
 	struct completion		completion;
 
+	bool				offload_en;
+	void				*bus_data;
+
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
@@ -165,6 +172,8 @@ struct ad7606_state {
  * @read_block:		function pointer for reading blocks of data
  * @sw_mode_config:	pointer to a function which configured the device
  *			for software mode
+ * @offload_config:     function pointer for configuring offload support,
+ *			where any
  * @reg_read:		function pointer for reading spi register
  * @reg_write:		function pointer for writing spi register
  * @update_scan_mode:	function pointer for handling the calls to iio_info's
@@ -174,6 +183,7 @@ struct ad7606_state {
 struct ad7606_bus_ops {
 	/* more methods added in future? */
 	int (*iio_backend_config)(struct device *dev, struct iio_dev *indio_dev);
+	int (*offload_config)(struct device *dev, struct iio_dev *indio_dev);
 	int (*read_block)(struct device *dev, int num, void *data);
 	int (*sw_mode_config)(struct iio_dev *indio_dev);
 	int (*reg_read)(struct ad7606_state *st, unsigned int addr);
@@ -199,6 +209,8 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const struct ad7606_bus_ops *bops);
 
 int ad7606_reset(struct ad7606_state *st);
+int ad7606_pwm_set_swing(struct ad7606_state *st);
+int ad7606_pwm_set_low(struct ad7606_state *st);
 
 extern const struct ad7606_chip_info ad7605_4_info;
 extern const struct ad7606_chip_info ad7606_8_info;
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index b2b975fb7fea4d1af6caef59e75ca495501bc140..b086122497eb22042171580878160334f56baa23 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -6,15 +6,31 @@
  */
 
 #include <linux/err.h>
+#include <linux/math.h>
 #include <linux/module.h>
+#include <linux/pwm.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/provider.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/iio.h>
+
+#include <dt-bindings/iio/adc/adi,ad7606.h>
+
 #include "ad7606.h"
 
 #define MAX_SPI_FREQ_HZ		23500000	/* VDRIVE above 4.75 V */
 
+struct spi_bus_data {
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	struct spi_transfer offload_xfer;
+	struct spi_message offload_msg;
+};
+
 static u16 ad7616_spi_rd_wr_cmd(int addr, char is_write_op)
 {
 	/*
@@ -125,19 +141,211 @@ static int ad7606b_sw_mode_config(struct iio_dev *indio_dev)
 				   AD7606_SINGLE_DOUT);
 }
 
+static const struct spi_offload_config ad7606_spi_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
+static int ad7606_spi_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	const struct iio_scan_type *scan_type;
+	struct ad7606_state *st = iio_priv(indio_dev);
+	struct spi_bus_data *bus_data = st->bus_data;
+	struct spi_transfer *xfer = &bus_data->offload_xfer;
+	struct spi_device *spi = to_spi_device(st->dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
+	};
+	int ret;
+
+	scan_type = &indio_dev->channels[0].scan_type;
+
+	xfer->bits_per_word = scan_type->realbits;
+	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	/*
+	 * Using SPI offload, storagebits are related to the spi-engine
+	 * hw implementation, can be 16 or 32, so can't be used to compute
+	 * struct spi_transfer.len. Using realbits instead.
+	 */
+	xfer->len = (scan_type->realbits > 16 ? 4 : 2) *
+		    st->chip_info->num_adc_channels;
+
+	spi_message_init_with_transfers(&bus_data->offload_msg, xfer, 1);
+	bus_data->offload_msg.offload = bus_data->offload;
+
+	ret = spi_optimize_message(spi, &bus_data->offload_msg);
+	if (ret) {
+		dev_err(st->dev, "failed to prepare offload, err: %d\n", ret);
+		return ret;
+	}
+
+	ret = spi_offload_trigger_enable(bus_data->offload,
+					 bus_data->offload_trigger,
+					 &config);
+	if (ret)
+		goto err_unoptimize_message;
+
+	ret = ad7606_pwm_set_swing(st);
+	if (ret)
+		goto err_offload_exit_conversion_mode;
+
+	return 0;
+
+err_offload_exit_conversion_mode:
+	spi_offload_trigger_disable(bus_data->offload,
+				    bus_data->offload_trigger);
+
+err_unoptimize_message:
+	spi_unoptimize_message(&bus_data->offload_msg);
+
+	return ret;
+}
+
+static int ad7606_spi_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	struct spi_bus_data *bus_data = st->bus_data;
+	int ret;
+
+	ret = ad7606_pwm_set_low(st);
+	if (ret)
+		return ret;
+
+	spi_offload_trigger_disable(bus_data->offload,
+				    bus_data->offload_trigger);
+	spi_unoptimize_message(&bus_data->offload_msg);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad7606_offload_buffer_setup_ops = {
+	.postenable = ad7606_spi_offload_buffer_postenable,
+	.predisable = ad7606_spi_offload_buffer_predisable,
+};
+
+static bool ad7606_spi_offload_trigger_match(
+				struct spi_offload_trigger *trigger,
+				enum spi_offload_trigger_type type,
+				u64 *args, u32 nargs)
+{
+	if (type != SPI_OFFLOAD_TRIGGER_DATA_READY)
+	       return false;
+
+	/*
+	 * Requires 1 arg:
+	 * args[0] is the trigger event.
+	 */
+	if (nargs != 1 || args[0] != AD7606_TRIGGER_EVENT_BUSY)
+		return false;
+
+	return true;
+}
+
+static int ad7606_spi_offload_trigger_request(
+				struct spi_offload_trigger *trigger,
+				enum spi_offload_trigger_type type,
+				u64 *args, u32 nargs)
+{
+	/* Should already be validated by match, but just in case. */
+	if (nargs != 1)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ad7606_spi_offload_trigger_validate(
+				struct spi_offload_trigger *trigger,
+				struct spi_offload_trigger_config *config)
+{
+	if (config->type != SPI_OFFLOAD_TRIGGER_DATA_READY)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct spi_offload_trigger_ops ad7606_offload_trigger_ops = {
+	.match = ad7606_spi_offload_trigger_match,
+	.request = ad7606_spi_offload_trigger_request,
+	.validate = ad7606_spi_offload_trigger_validate,
+};
+
+static int ad7606_spi_offload_probe(struct device *dev,
+				    struct iio_dev *indio_dev)
+{
+	struct ad7606_state *st = iio_priv(indio_dev);
+	struct spi_device *spi = to_spi_device(dev);
+	struct spi_bus_data *bus_data;
+	struct dma_chan *rx_dma;
+	struct spi_offload_trigger_info trigger_info = {
+		.fwnode = dev_fwnode(dev),
+		.ops = &ad7606_offload_trigger_ops,
+		.priv = st,
+	};
+	int ret;
+
+	bus_data = devm_kzalloc(dev, sizeof(*bus_data), GFP_KERNEL);
+	if (!bus_data)
+		return -ENOMEM;
+	st->bus_data = bus_data;
+
+	bus_data->offload = devm_spi_offload_get(dev, spi,
+						 &ad7606_spi_offload_config);
+	ret = PTR_ERR_OR_ZERO(bus_data->offload);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get SPI offload\n");
+	/* Allow main ad7606_probe function to continue. */
+	if (ret == -ENODEV)
+		return 0;
+
+	ret = devm_spi_offload_trigger_register(dev, &trigger_info);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register offload trigger\n");
+
+	bus_data->offload_trigger = devm_spi_offload_trigger_get(dev,
+		bus_data->offload, SPI_OFFLOAD_TRIGGER_DATA_READY);
+	if (IS_ERR(bus_data->offload_trigger))
+		return dev_err_probe(dev, PTR_ERR(bus_data->offload_trigger),
+				     "failed to get offload trigger\n");
+
+	/* TODO: PWM setup should be ok, done for the backend. PWM mutex ? */
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev,
+							     bus_data->offload);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma),
+				     "failed to get offload RX DMA\n");
+
+	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
+		rx_dma, IIO_BUFFER_DIRECTION_IN);
+	if (ret)
+		return dev_err_probe(dev, PTR_ERR(rx_dma),
+				     "failed to setup offload RX DMA\n");
+
+	/* Use offload ops. */
+	indio_dev->setup_ops = &ad7606_offload_buffer_setup_ops;
+
+	st->offload_en = true;
+
+	return 0;
+}
+
 static const struct ad7606_bus_ops ad7606_spi_bops = {
+	.offload_config = ad7606_spi_offload_probe,
 	.read_block = ad7606_spi_read_block,
 };
 
 static const struct ad7606_bus_ops ad7607_spi_bops = {
+	.offload_config = ad7606_spi_offload_probe,
 	.read_block = ad7606_spi_read_block14to16,
 };
 
 static const struct ad7606_bus_ops ad7608_spi_bops = {
+	.offload_config = ad7606_spi_offload_probe,
 	.read_block = ad7606_spi_read_block18to32,
 };
 
 static const struct ad7606_bus_ops ad7616_spi_bops = {
+	.offload_config = ad7606_spi_offload_probe,
 	.read_block = ad7606_spi_read_block,
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
@@ -145,6 +353,7 @@ static const struct ad7606_bus_ops ad7616_spi_bops = {
 };
 
 static const struct ad7606_bus_ops ad7606b_spi_bops = {
+	.offload_config = ad7606_spi_offload_probe,
 	.read_block = ad7606_spi_read_block,
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
@@ -153,6 +362,7 @@ static const struct ad7606_bus_ops ad7606b_spi_bops = {
 };
 
 static const struct ad7606_bus_ops ad7606c_18_spi_bops = {
+	.offload_config = ad7606_spi_offload_probe,
 	.read_block = ad7606_spi_read_block18to32,
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,

-- 
2.49.0


