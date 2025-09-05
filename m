Return-Path: <linux-kernel+bounces-803528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCEFB461F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA45A41544
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40587303A22;
	Fri,  5 Sep 2025 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J7NKgRQR"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D56931C579
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095971; cv=none; b=Vs7/YUi5uZG+k1KHwJmkqHtwuRJED9c4KzfRFdaXTtet5nzxdGMjYROqOSBSUOZm9s9kiiQt7sWUhAQEMiGf/wlIDQMBYykClfQMJ3d4LrqWkJpFlujdqh0J/zL2aHy0lzfCjyf1gGdc3mFgEgsJTLYQVaIujM6coAxAMxtY6+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095971; c=relaxed/simple;
	bh=QEvSoG9oo+amGpQo5aYx923w5/Dr4Rh7PhvFmupuYfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ekmYvx0L/4lqV61V0axKOFG/JFX7Fmot4H2aTUOA3fNUOGLSojMrHyBarIQqeKgBmOlU/uBanLBycXRLnrigoJB2sNmuFGnnL66MQZ6OAD6pv9Y4k328p3A5bHGjNW48MWa5O0U4Ivv6j7kV1PrQaOEBUqAwKe37vur8eutSsVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J7NKgRQR; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-31d6b8be249so1844688fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757095968; x=1757700768; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pq/O4xCAgJP0KqFCiB1CekBvbauRk68b8NmuWzDdO7c=;
        b=J7NKgRQR/fWBqeYZh/cU0xlxE0k+tWVClgqRKEli2b6TzxqEJcz4b6a8lThp6oBtce
         V8Cz98m02c0RaS+FhCkdMf1shOKo0ni7HwxPw0YyhL4A5XuwWUOmE48XhzyAT4I6bm1r
         qdLxRksI3IpBfzL4VtRqbC2XlzwLwUfORaxt/sqH0y6Im0iNElDHNBdTwc+ju6VpnD65
         M37McxkFI0E9CuWb8OSABkUSuzNU/jhTEhChk2IVyxiepbs6RUuC+a4L/iHgL9L2hXVG
         UaUkrDmIT1HY1My0WtZr2nTi7fdGbf4zKzRhOKnGsdO5WZtbJYJ35GIyW84WaykWmP4F
         ucUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095968; x=1757700768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pq/O4xCAgJP0KqFCiB1CekBvbauRk68b8NmuWzDdO7c=;
        b=GjaSDqVjCBmOcgrR0dk8dhmDTE9w22kHwqc+BSYqN1KXYlpVKTMZDv77lHCuHKoo7I
         UjqVMTx6aYqbNi5Ji/b77DGBfP26IJmr8TUh5fP5LPERfXI5REUPpJSUC7Qzrw2McGrK
         NpN6B1EgiMDKlu7aNxscJ5i23ORFb5BfwZmWGYTMaNVk5PgcogEA0yIXz+BJDvKPAZcb
         vdsOfPfAkH8j4sJUJK8w3enJXBDEOmeN3dB0dU/whd+rTv50rB8MuS4k2Hv5K7UdIi8y
         Bg5EqBZ+ljEMAmj+XYKRAHf0zoSamdQ+AXc1I803MSo/eQwmomtYTJ9CX8b84Mq+NscA
         gNSg==
X-Forwarded-Encrypted: i=1; AJvYcCXscNmZnfRy5dnVQXeqwag3ONBS2/oWWfzavBukOvC5WMj7GRZMUN3Cv17UxyAegk6Leo2kObgzOcKItZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi081d9Or+eGFBgJ/a3cqRl/KGgFekEkpIfUYq9xib7T7WOiFM
	gSyzdo5RHx6DIW4blHgVZU2oyR7+nYxqWb/UUt84t3qzZH9Yjtj0Neh1wJMvS3Ze09w=
X-Gm-Gg: ASbGncvYdeqE5nfujB8o9JtK3Ixvrw8htvclB0pLUIZLoqV/NiPs8NWqVRkoYvCNzW3
	jI06VRsaD50eRM292kMScppaiqeQRUap2uBqsD0mENwC9VY6+wnaVnR2vh6PXP5BFiRRKrve/aU
	iFdlM6nUyaMfX/f3cOI5sa2dW8IlwQvWYmBUG3yq9++y4KRVv69PQeTz1JgZJINcF+BT+IOhu9X
	Ckk3JV3WMk2f4fM+oHGRvYbYqMJRUUwywmx7Qf60CatrAVD5SWnj2uLptST6ruzpE0/PNkjtmj9
	wGBeEFkIoDMSAx6dfB4TS6WYUygvkn1PCvx1um1zU4NzwVcxxLYIM8CLCskg04UZPO+6TkgS7QQ
	8APSZILqzoAzVBDaDidZ2Wic5JgshhjfMKDVY3Q1GLjuz8toy
X-Google-Smtp-Source: AGHT+IHiFaLhmix02to3SMgZZqByu/YBe6CEM25m/eqHlooV5XhvbN53r09zYYi9FDkfdZyJBlqDqg==
X-Received: by 2002:a05:6870:17a3:b0:315:a68c:d90b with SMTP id 586e51a60fabf-31963345786mr11690278fac.23.1757095968426;
        Fri, 05 Sep 2025 11:12:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-31d686398e1sm3052292fac.13.2025.09.05.11.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:12:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 05 Sep 2025 13:11:59 -0500
Subject: [PATCH 4/6] iio: adc: ad7124: support fractional
 sampling_frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-iio-adc-ad7124-add-filter-support-v1-4-aee3834be6a9@baylibre.com>
References: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
In-Reply-To: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5575; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=QEvSoG9oo+amGpQo5aYx923w5/Dr4Rh7PhvFmupuYfo=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBouygIcE4D5fTMX03D7KcVg5yFzpWnllIAr3oP2
 0dBRTLLqHmJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLsoCAAKCRDCzCAB/wGP
 wMH8B/4xu27Lk451bUl1W4lOAQNp20acyd2GPp93eNxqzmhsq5Iz5wzLiY1U4xzLiYa+GT7eTIt
 WDjGWcDkSxUBTDQJJXEYNGqGxKM8ZsTUIlAaacj1eAhUEUXDjN2wdke7eusWNIbGOPkgjghym6q
 48VoxcEROCHtBauAhTJ9S6NFUJ3iHzxLhXVdHxl9ezgURZkGwvcP6uhoeQ2rNOkPcFcnOM+Ygj5
 hlcsxY2oKJ2Zpl8zJHtOmcF2ntm9UAFGSY7cTwlKpCu4rAAKPtEIQevihCZfedGcgEw4uN5Kfz4
 QdPpaUbJHWr0gG7GnGIQ5xKJ6/GATTkCc8ihSKxdBlSperRq
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
index d0c6462bcf410efcc664b602beb94a9ab6a869c0..e2d92f2e3e2eb96d11dcaaf53de9124a6cc44ca4 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -168,7 +168,6 @@ struct ad7124_channel_config {
 		bool buf_negative;
 		unsigned int vref_mv;
 		unsigned int pga_bits;
-		unsigned int odr;
 		unsigned int odr_sel_bits;
 		unsigned int filter_type;
 		unsigned int calibration_offset;
@@ -287,7 +286,17 @@ static u32 ad7124_get_fclk_hz(struct ad7124_state *st)
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
 
@@ -302,29 +311,28 @@ static void ad7124_set_channel_odr(struct ad7124_state *st, unsigned int channel
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
@@ -348,7 +356,6 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 				     bool buf_negative;
 				     unsigned int vref_mv;
 				     unsigned int pga_bits;
-				     unsigned int odr;
 				     unsigned int odr_sel_bits;
 				     unsigned int filter_type;
 				     unsigned int calibration_offset;
@@ -365,7 +372,6 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 		    cfg->buf_negative == cfg_aux->buf_negative &&
 		    cfg->vref_mv == cfg_aux->vref_mv &&
 		    cfg->pga_bits == cfg_aux->pga_bits &&
-		    cfg->odr == cfg_aux->odr &&
 		    cfg->odr_sel_bits == cfg_aux->odr_sel_bits &&
 		    cfg->filter_type == cfg_aux->filter_type &&
 		    cfg->calibration_offset == cfg_aux->calibration_offset &&
@@ -720,16 +726,23 @@ static int ad7124_read_raw(struct iio_dev *indio_dev,
 
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
@@ -746,10 +759,10 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val2 != 0 || val == 0)
+		if (val2 < 0 || val < 0 || (val2 == 0 && val == 0))
 			return -EINVAL;
 
-		ad7124_set_channel_odr(st, chan->address, val);
+		ad7124_set_channel_odr(st, chan->address, val, val2);
 
 		return 0;
 	case IIO_CHAN_INFO_SCALE:
@@ -1298,7 +1311,7 @@ static int ad7124_setup(struct ad7124_state *st)
 		 * regardless of the selected power mode. Round it up to 10 and
 		 * set all channels to this default value.
 		 */
-		ad7124_set_channel_odr(st, i, 10);
+		ad7124_set_channel_odr(st, i, 10, 0);
 	}
 
 	ad7124_disable_all(&st->sd);

-- 
2.43.0


