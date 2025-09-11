Return-Path: <linux-kernel+bounces-812905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41BBB53E05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD693A1350
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225822E3373;
	Thu, 11 Sep 2025 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KbgD9vUd"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE65B2E1749
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626980; cv=none; b=YyXWTVNnOHBPThT6f6ammjHkxxr9yrk31U6xo9P4GDpyHQZGRnqujdKIEd0z8ZDhxcEQ1jT3aEx3z0Ohy0NVdB3bx5FS8hPRTCIcmlzMiWWtHa6G8YrGgW1hZNdZ8BbcgP4/Im/wP4smpmWYCUv71TOpHSuhbcsaPf9UXDxcoXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626980; c=relaxed/simple;
	bh=2emXA2SStyc0MKsp4DgIlttQ3aARs3+icwXTl4wIg9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C2iN6oAIgTBl3RsYK82pe8+ldIEIIz76PxLv+EFOO8wm3EatVInVWZ36og0hYY0rOVsah11dv/MSEyWEqJc7i+gO/60mf2dYK1+lQYvISMi6MPs2r3WZT8BSXAKULs/TA9Ll8hGjN9+o8ny3oLbhJCk9Z1N/kRHrvE8PwA0Bvio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KbgD9vUd; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30cce8c3afaso771268fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757626977; x=1758231777; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+vlqNotxyngfaMtY7z4y6Czl360IhxSvv2niU7RyLk=;
        b=KbgD9vUdSiotqKh3USB0IPnPa/QIZ5qTfLs7wPTtIldvIpYSL/zMQYkJp7jsxK7zt+
         giKfOuE4PdxpW+lK8NQAc9J8Id/FBFBmRVUTnw/2Ctfvb3R1EcCNyDBRB9PQGTnOzBDe
         080Syl5nz2jKvRHZrIkteIAIHYEA/KTyu5bOahOga23chPq6gWVor48wgj8BEdAKQGd3
         1TRZP1UdDPiYedtp9HvQ9RReOnfxWkNUBiWrNSBqNvsaGnk7I6Zgz58BLwwBWXLJ+0RP
         JnRhk4JQACLz5c+ddvYEfOv0Y3yOLvoK/T4+OXzZD7+eG0+XL+P9op6E/zVtxpjjK9Li
         k1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626977; x=1758231777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+vlqNotxyngfaMtY7z4y6Czl360IhxSvv2niU7RyLk=;
        b=E529NHcaGtZ53FeWUpqT8+IdDXMl4AW9oOOcvJgCmgqOaK9VL/PPKJL0TBRj/uTsYB
         ZLnfyAbkGKHy+x1sL6/Kg7VG/CxxgqloSPOxitZ8wrr3FTELpIeqNAAdB/9Nvjsyzmus
         TK+b16NHOGOkmdt4vegg90ZAAkSAGSMTfTAx9D3Cug+P057jWjKYPZ6saIVNMVytAVID
         oXoZaOShYkYmxnZopVeUqawWiQFdZVOYM7fEfmHVCqJoMY88UU8nfYZOpCY0E1aqkOKx
         VHij4JMkNnrycxY2WOxdJtzOjvbOdcdaM3EoJ8CIyDDT4usy+6f6p9QEFK7jWXpG19nm
         +JDw==
X-Forwarded-Encrypted: i=1; AJvYcCXmutlTBmaszklUUx/MRCl5Yk2rD94W7WBBI8DHGx1C+uP+zi56o8SrVS6q259w4geUy3BfUeDUsmyGILY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX9Tu1ZibalPDHuGGm+NnTdP3xOZYhaj/S6mEePLmRWJ8VXPMJ
	fSjFywcdzRsNhjq1vLSn+zYaHETot/6fJzdf2l0GRQCePkBD5MEeOEXj7iiPFxs9oV8=
X-Gm-Gg: ASbGncu16OvqiJeEawBiG0vhAWStQFJOmaJwQ9Ox7zrDB8mDo39ozLk13Zs0QLnMuvE
	/Bhriu7UQJ0IrSUQWja/BmP/5m3/A8DNHFtrpXyuzKf2nlNHZ5tmETDgaF4A+H3UC6VTBQnviuJ
	8MoPCsN0ARn++FSfOSnL/lOCu5BFojEm/uP2XMXx6fdWvxDdtAp3qdQUyK16Y+QjXzSTkrhAl6H
	DgT26va2Knlw+7eoroO7ss3WWvuVY+ZDPIi0Ea/GgvhfZhxQPTMm7CzfOIV3fxzFhF6WZc7cQNA
	9gNMeAcPOU/jvLbl14tm8vu3yNb9UdNoSYUnw8ovgnDa7W7ZspLaw6torIQOKZHb0V1JIbRRN9i
	CFY8VSXbIsDEceC7z5krfFAi9wnb8ytJYplPaNVeolKX1GM4LIg==
X-Google-Smtp-Source: AGHT+IEzMxpM730S0qiQRVgFWlq/Gq/4VeCE9+gTt9KCsUctTsmXYdZt1ce8H/6F0GQvtNOFeDgd/w==
X-Received: by 2002:a05:6870:f6a9:b0:30b:a81d:b56 with SMTP id 586e51a60fabf-32e5886fd49mr375385fac.38.1757626976867;
        Thu, 11 Sep 2025 14:42:56 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986a7c3sm604188a34.10.2025.09.11.14.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:42:56 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Sep 2025 16:42:03 -0500
Subject: [PATCH v2 4/6] iio: adc: ad7124: support fractional
 sampling_frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-iio-adc-ad7124-add-filter-support-v2-4-b09f492416c7@baylibre.com>
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
In-Reply-To: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5575; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=2emXA2SStyc0MKsp4DgIlttQ3aARs3+icwXTl4wIg9k=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBow0JHv3ofy6c2tN3Wdc2L59YsDIIQlCxUyGDnH
 q88IQOzvGWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMNCRwAKCRDCzCAB/wGP
 wH80CACAjrwhqsjxfDqXHUxAjij7am/rU+wpww4W8KjDKTb0KlP4enIaX7qmTviUxZCKUfnZnBm
 qHp3zthg5cqxIOIZ07owQUYDfaNZ+A+vDBEWb97Oum0hgtOos9lVR9w9OkyZIITAQHI+ogl6cNW
 XKJju5ZVWrfdxNlpobrqBUYd8B06BXgu3FG/6chD9BTigahQrEMwIrFTO5kgCMVCmMVIE01jP7A
 fIAqLY2w2mnYphKRsWJyeM9ungC1/USwYaLmwfHEJkDXiaxpar16WakHA2Itx9FJ8XLJmx/akCP
 SOHMHvxhaEMHiq7xi7DrogI4bXIN8FHuXzR4USg0wwvsL4us
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Modify the attribute read/write functions for sampling_frequency and
filter_low_pass_3db_frequency to return fractional values.

These ADCs support output data rates in the single digits, so being
able to specify fractional values is necessary to use all possible
sampling frequencies.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 65 +++++++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 3afc4dcc315e82ab822370ff8d21590086e0bc7e..b644191319a5eb6ab1a8ba22df4520edbb34ee75 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -166,7 +166,6 @@ struct ad7124_channel_config {
 		bool buf_negative;
 		unsigned int vref_mv;
 		unsigned int pga_bits;
-		unsigned int odr;
 		unsigned int odr_sel_bits;
 		unsigned int filter_type;
 		unsigned int calibration_offset;
@@ -285,7 +284,17 @@ static u32 ad7124_get_fclk_hz(struct ad7124_state *st)
 	return fclk_hz;
 }
 
-static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel, unsigned int odr)
+static u32 ad7124_get_fadc_divisor(struct ad7124_state *st, unsigned int channel)
+{
+	/*
+	 * The output data rate (f_ADC) is f_CLK / divisor. We are returning
+	 * the divisor.
+	 */
+	return st->channels[channel].cfg.odr_sel_bits * 32 * 4;
+}
+
+static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel,
+				   unsigned int odr, unsigned int odr_micro)
 {
 	unsigned int fclk, factor, odr_sel_bits;
 
@@ -300,29 +309,28 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
 	 * FS[10:0] can have a value from 1 to 2047
 	 */
 	factor = 32 * 4; /* N = 4 for default sinc4 filter. */
-	odr_sel_bits = clamp(DIV_ROUND_CLOSEST(fclk, odr * factor), 1, 2047);
+	odr_sel_bits = DIV_ROUND_CLOSEST(fclk, odr * factor +
+					       odr_micro * factor / MICRO);
+	odr_sel_bits = clamp(odr_sel_bits, 1, 2047);
 
 	if (odr_sel_bits != st->channels[channel].cfg.odr_sel_bits)
 		st->channels[channel].cfg.live = false;
 
-	/* fADC = fCLK / (FS[10:0] x 32) */
-	st->channels[channel].cfg.odr = DIV_ROUND_CLOSEST(fclk, odr_sel_bits *
-								factor);
 	st->channels[channel].cfg.odr_sel_bits = odr_sel_bits;
 }
 
-static int ad7124_get_3db_filter_freq(struct ad7124_state *st,
-				      unsigned int channel)
+static int ad7124_get_3db_filter_factor(struct ad7124_state *st,
+					unsigned int channel)
 {
-	unsigned int fadc;
-
-	fadc = st->channels[channel].cfg.odr;
-
+	/*
+	 * 3dB point is the f_CLK rate times some factor. This functions returns
+	 * the factor times 1000.
+	 */
 	switch (st->channels[channel].cfg.filter_type) {
 	case AD7124_FILTER_FILTER_SINC3:
-		return DIV_ROUND_CLOSEST(fadc * 272, 1000);
+		return 272;
 	case AD7124_FILTER_FILTER_SINC4:
-		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
+		return 230;
 	default:
 		return -EINVAL;
 	}
@@ -346,7 +354,6 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 				     bool buf_negative;
 				     unsigned int vref_mv;
 				     unsigned int pga_bits;
-				     unsigned int odr;
 				     unsigned int odr_sel_bits;
 				     unsigned int filter_type;
 				     unsigned int calibration_offset;
@@ -363,7 +370,6 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 		    cfg->buf_negative == cfg_aux->buf_negative &&
 		    cfg->vref_mv == cfg_aux->vref_mv &&
 		    cfg->pga_bits == cfg_aux->pga_bits &&
-		    cfg->odr == cfg_aux->odr &&
 		    cfg->odr_sel_bits == cfg_aux->odr_sel_bits &&
 		    cfg->filter_type == cfg_aux->filter_type &&
 		    cfg->calibration_offset == cfg_aux->calibration_offset &&
@@ -718,16 +724,23 @@ static int ad7124_read_raw(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		mutex_lock(&st->cfgs_lock);
-		*val = st->channels[chan->address].cfg.odr;
+		*val = ad7124_get_fclk_hz(st);
+		*val2 = ad7124_get_fadc_divisor(st, chan->address);
 		mutex_unlock(&st->cfgs_lock);
 
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		mutex_lock(&st->cfgs_lock);
-		*val = ad7124_get_3db_filter_freq(st, chan->scan_index);
-		mutex_unlock(&st->cfgs_lock);
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: {
+		guard(mutex)(&st->cfgs_lock);
 
-		return IIO_VAL_INT;
+		ret = ad7124_get_3db_filter_factor(st, chan->address);
+		if (ret < 0)
+			return ret;
+
+		/* 3dB point is the f_CLK rate times a fractional value */
+		*val = ret * ad7124_get_fclk_hz(st);
+		*val2 = MILLI * ad7124_get_fadc_divisor(st, chan->address);
+		return IIO_VAL_FRACTIONAL;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -744,10 +757,10 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val2 != 0 || val == 0)
+		if (val2 < 0 || val < 0 || (val2 == 0 && val == 0))
 			return -EINVAL;
 
-		ad7124_set_channel_odr(st, chan->address, val);
+		ad7124_set_channel_odr(st, chan->address, val, val2);
 
 		return 0;
 	case IIO_CHAN_INFO_SCALE:
@@ -1296,7 +1309,7 @@ static int ad7124_setup(struct ad7124_state *st)
 		 * regardless of the selected power mode. Round it up to 10 and
 		 * set all channels to this default value.
 		 */
-		ad7124_set_channel_odr(st, i, 10);
+		ad7124_set_channel_odr(st, i, 10, 0);
 	}
 
 	ad7124_disable_all(&st->sd);

-- 
2.43.0


