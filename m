Return-Path: <linux-kernel+bounces-847267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B359DBCA654
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD4F1A6491F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE22246762;
	Thu,  9 Oct 2025 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ctw6rRYY"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DE1242D7D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031376; cv=none; b=ZrVz/4Oz25AhgAU1LIzyw4BQC3sQUfP3J+yLMl4gLhm5g1KoZ1YtkZsJ73fy1bJFKGcw5uxhKrhVd5YSX7FN/tKyMBfkqqyzvlWTFMJcKfysRAZs6HFePqQZ4YeTAkS3A1u4+Sfkgtwbos0ffAgPYCZ6QV+5Usxd2WI8MzYsBFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031376; c=relaxed/simple;
	bh=662BiyGdXv2W9DnviRmUVMwteKePLQpJjJoJLBRK16s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q8hpDBK4lS1gHsh39h1iTXYTTasM6qk9bqxiBMPZV1KA6xMrPPnmAjWpcw8e7AyBJgWEql+aNtK8Yoipygjd1lG1zvqvCyyIVcQ+SncEUGD/RbWhM1HlLbYwlEDJk+jqocuOj9i9R2ejMfQmtyd2G1XVXjuGU74TPjOAp9Yp8k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ctw6rRYY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb7ae31caso207804466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760031373; x=1760636173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UoTylyozS+A8FmhwbVNYmrXgdsEgCAS7YMtlxoSU5ak=;
        b=Ctw6rRYYWzkJZPF7DufMU0VWVBUJIq58Z7kmsFLgUa6tF2FQrGMYpvZqtUfYvAHcjP
         cm0KJ6kcDoXGg2sy6qt2UKxZ85rox9JJYQxeJKI1LTIglAd27IMJz9g2At6KPZJp9be1
         aHRNYuGOiomtb1XHg1ymSxTSX9PLHsmUoBril/Zy/H+iIlm4ynLLCnlil50t8KULMiY0
         ZUVq8rI4vgRpaubzS2jgvLU76+0PqPtI9OS0wB2J6LvWNEdjqkp2wHasALMW1pf2B3NL
         GJfPujgMfj1aNWPhgaEtcSSc8T82gefbVNO6uhe4IZQRdsb8KDfvdgDdrQVNpL5NRwo9
         oufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760031373; x=1760636173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UoTylyozS+A8FmhwbVNYmrXgdsEgCAS7YMtlxoSU5ak=;
        b=ZQjSC0W3+dXAD4NUkHDSw8u0TQjWktGKIBKumTlgmE4WHTQyDzePDhxJctg3wfezrg
         LAwxLYX58HkCDR9g5KxeHfjPP0lxRQjF0WSzCBr7RlOqN4n0FXJmuR6PLfB2MREDhE0F
         hsI8Bf9T5DUD+F2GF7DVvI2YxhHWvZrZZtpHAOolJjYavokKsKnlLuU691aUrB3ngzKg
         AfUnWUcfFDvN8Ej1mPkd+un0KbbR9I7DtfBMv12K3oD3aO7U8giGBiW3wRn6GdtRIZQB
         VCgdG0kJfw1LqO+CbkL5TFdawcLIJsA2ei5N0dPEAOODYlhHmJgB/W8VTMI2nhsAEx3o
         Zrbw==
X-Forwarded-Encrypted: i=1; AJvYcCXKYbJxrfuuHAVDuE9xH5+4JBdWvKX+om+Rb76u8I3zKT4nBRTf7AQpEjKrI+kiVIFmdt/WKFXDfp7ZGzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8iIVtkElu1sGbnLRlfvG2pRu0feWv+w72/WGbr1O1hgcBil4O
	IDH4nAd9IvPLCu3iLLtYgOcY+H9PqzAbt9ViwGXXY3bd+ZdPZWNlR/NK2kzKTQSHx+k=
X-Gm-Gg: ASbGncuQt8VoJn0EisLCKUCwalLzO3ZgNfBHr64888fnNJwQyTeCKAjZ5e49sF/kkYl
	N21L86Qe9mFMxZqRmscZ6EYM+ufBx28xru9HmHRmL4ueoaUmKh+cXMWSH3L40Au7O0Hziufo4kr
	4qdBLG+K/dUsVKWYQIJ8PEpSxAEGW4e0YF7jziFlA9jTwthXIskFTxLNlaGDclwDvWKJ6BR59a7
	qE7sebmtxpLvcdb+Fd+38U+IhCr61YeAcWzrMqPbypWGZUpScy/+mPHZGmcKpfG5a7B7g6oNsCH
	cdAroQTQzLXxtfEK5z38A0lXxBqEwsxqRqFCgFNE2MREMdMPHl/0oR9KaYIeD4VxWWthDEGLMLr
	Wx1f4bZBLOjnNcudpRg==
X-Google-Smtp-Source: AGHT+IECXQsPVZsJ1vwB/FI0Fbvge/Nu/eIo282pruMpUqeY1GNHAGbfE3u1dgTRp5uHxf8RrgnQTw==
X-Received: by 2002:a17:906:af09:b0:b3d:b251:cdec with SMTP id a640c23a62f3a-b50abfd5e91mr769738866b.37.1760031372661;
        Thu, 09 Oct 2025 10:36:12 -0700 (PDT)
Received: from localhost ([151.35.157.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d9a4054fsm20861666b.89.2025.10.09.10.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:36:12 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate
Date: Thu,  9 Oct 2025 19:36:09 +0200
Message-Id: <20251009173609.992452-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009173609.992452-1-flavra@baylibre.com>
References: <20251009173609.992452-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8237; i=flavra@baylibre.com; h=from:subject; bh=662BiyGdXv2W9DnviRmUVMwteKePLQpJjJoJLBRK16s=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBo5/JF0/zE7bUAgiArKHuvRfIYia9JPAZe2DGpA QTKh3f75buJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaOfyRQAKCRDt8TtzzpQ2 X8b7DACEzYtzZ8wMSkuBAmiOv9BZCw69tF35aQmA9AKjWBI7cHEyA02jrjQNcnRSN73oBS8J/+N tKWbKBKm7nBTICGSz/y6NaY1QVKZiiQqlhbOACPCWK5aZf7E6xOf7THojnMphu2DtwmXQryGaMi LF8HsJ0QkllRBqmW6ZL12L55HQS0by3UWKjPfby0AnrxkX77YfFC71amB39Ln3OumjLOLRFG2de G6aDIJ671q9hEkLl6iO4G8Gku6N5Chtkwg+7ShZ06wpQnumAsbuDUvPQPwV2QUKQ0JMex2/00C5 0kfehSCZDuCE6ljgdYV9g3csZ8piKXsXqADk8q8lVmvVa+L/UiESlZcKQdzRD9Ayrxb3RNCHm+Q xi1DDITGsntMQogL/PDNh4nAbI1uEfvfyEXyltT9Ck7cEM5AaSYou0umqZpoKwKKwUIvU+AGCbd X8jVQ20RMCovetPpmwwh/Oc3iHs8UrUCmamSZmJuhqD2HfcR5M+fiGuCcynMfSAz1d4as=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The rate at which accelerometer or gyroscope sensor samples are fed
to the hardware FIFO (batch data rate, or BDR) does not have to
coincide with the sensor sampling frequency (output data rate, or
ODR); the only requirement is for the BDR to not be greater than
the ODR. Having a BDR lower than the ODR is useful in cases where
an application requires a high sampling rate for accurate detection
of motion events (e.g. wakeup events), but wants to read sensor
sample values from the device buffer at a lower data rate.
To support the above use case, add a sampling_frequency sysfs
attribute to the buffer directory of st_lsm6dsx IIO devices, which
controls the BDR for a given sensor independently from the "main"
sampling_frequency attribute (which controls the ODR); introduce a
new `bdr` field in struct st_lsm6dsx_sensor to keep track of the
current BDR value, and use this field instead of the `odr` field in
the code that deals with the FIFO data rate. In the sensor hub
driver, make the bdr value always mirror the odr value, since there
is no separate configuration setting to control the BDR for data
produced by the sensor hub functionality.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 +
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 64 ++++++++++++++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  9 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  |  4 +-
 4 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index bd366c6e282a..dc4aeea3a3b8 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -366,6 +366,7 @@ enum st_lsm6dsx_fifo_mode {
  * @hw: Pointer to instance of struct st_lsm6dsx_hw.
  * @gain: Configured sensor sensitivity.
  * @odr: Output data rate of the sensor [mHz].
+ * @bdr: Batch data rate [mHz]
  * @samples_to_discard: Number of samples to discard for filters settling time.
  * @watermark: Sensor watermark level.
  * @decimator: Sensor decimation factor.
@@ -380,6 +381,7 @@ struct st_lsm6dsx_sensor {
 
 	u32 gain;
 	u32 odr;
+	u32 bdr;
 
 	u16 samples_to_discard;
 	u16 watermark;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 8a9d2593576a..5912ea76d493 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -56,6 +56,7 @@
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/sysfs.h>
 #include <linux/regmap.h>
 #include <linux/bitfield.h>
 
@@ -105,7 +106,7 @@ static int
 st_lsm6dsx_get_decimator_val(struct st_lsm6dsx_sensor *sensor, u32 max_odr)
 {
 	const int max_size = ARRAY_SIZE(st_lsm6dsx_decimator_table);
-	u32 decimator =  max_odr / sensor->odr;
+	u32 decimator =  max_odr / sensor->bdr;
 	int i;
 
 	if (decimator > 1)
@@ -136,14 +137,14 @@ static void st_lsm6dsx_get_max_min_odr(struct st_lsm6dsx_hw *hw,
 		if (!(hw->enable_mask & BIT(sensor->id)))
 			continue;
 
-		*max_odr = max_t(u32, *max_odr, sensor->odr);
-		*min_odr = min_t(u32, *min_odr, sensor->odr);
+		*max_odr = max_t(u32, *max_odr, sensor->bdr);
+		*min_odr = min_t(u32, *min_odr, sensor->bdr);
 	}
 }
 
 static u8 st_lsm6dsx_get_sip(struct st_lsm6dsx_sensor *sensor, u32 min_odr)
 {
-	u8 sip = sensor->odr / min_odr;
+	u8 sip = sensor->bdr / min_odr;
 
 	return sip > 1 ? round_down(sip, 2) : sip;
 }
@@ -231,7 +232,7 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
 		if (enable) {
 			int err;
 
-			err = st_lsm6dsx_check_odr(sensor, sensor->odr,
+			err = st_lsm6dsx_check_odr(sensor, sensor->bdr,
 						   &data);
 			if (err < 0)
 				return err;
@@ -713,7 +714,7 @@ st_lsm6dsx_update_samples_to_discard(struct st_lsm6dsx_sensor *sensor)
 
 	data = &hw->settings->samples_to_discard[sensor->id];
 	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++) {
-		if (data->val[i].milli_hz == sensor->odr) {
+		if (data->val[i].milli_hz == sensor->bdr) {
 			sensor->samples_to_discard = data->val[i].samples;
 			return;
 		}
@@ -799,6 +800,52 @@ static const struct iio_buffer_setup_ops st_lsm6dsx_buffer_ops = {
 	.postdisable = st_lsm6dsx_buffer_postdisable,
 };
 
+static ssize_t st_lsm6dsx_bdr_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_to_iio_dev(dev));
+	u32 bdr = sensor->bdr;
+
+	return sysfs_emit(buf, "%d.%03d\n", bdr / 1000, bdr % 1000);
+}
+
+static ssize_t st_lsm6dsx_bdr_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
+{
+	struct iio_dev *iio_dev = dev_to_iio_dev(dev);
+	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
+	int integer, fract;
+	int ret;
+	u32 bdr;
+	u8 data;
+
+	ret = iio_str_to_fixpoint(buf, 100, &integer, &fract);
+	if (ret)
+		return ret;
+	bdr = integer * 1000 + fract;
+	ret = st_lsm6dsx_check_odr(sensor, bdr, &data);
+	if (ret < 0)
+		return ret;
+	bdr = ret;
+	if (!iio_device_claim_direct(iio_dev))
+		return -EBUSY;
+	/* the batch data rate must not exceed the sensor output data rate */
+	if (bdr <= sensor->odr)
+		sensor->bdr = bdr;
+	else
+		ret = -EINVAL;
+	iio_device_release_direct(iio_dev);
+	return (ret < 0) ? ret : len;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(0664, st_lsm6dsx_bdr_show, st_lsm6dsx_bdr_store);
+
+static const struct iio_dev_attr *st_lsm6dsx_buffer_attrs[] = {
+	&iio_dev_attr_sampling_frequency,
+	NULL
+};
+
 int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 {
 	int i, ret;
@@ -807,8 +854,9 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 		if (!hw->iio_devs[i])
 			continue;
 
-		ret = devm_iio_kfifo_buffer_setup(hw->dev, hw->iio_devs[i],
-						  &st_lsm6dsx_buffer_ops);
+		ret = devm_iio_kfifo_buffer_setup_ext(hw->dev, hw->iio_devs[i],
+						      &st_lsm6dsx_buffer_ops,
+						      st_lsm6dsx_buffer_attrs);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c65ad49829e7..e4922578329e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1847,10 +1847,13 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 
 		val = val * 1000 + val2 / 1000;
 		val = st_lsm6dsx_check_odr(sensor, val, &data);
-		if (val < 0)
+		if (val < 0) {
 			err = val;
-		else
+		} else {
 			sensor->odr = val;
+			/* the batch data rate must not exceed the sensor ODR */
+			sensor->bdr = min_t(u32, sensor->bdr, sensor->odr);
+		}
 		break;
 	}
 	default:
@@ -2383,7 +2386,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	sensor = iio_priv(iio_dev);
 	sensor->id = id;
 	sensor->hw = hw;
-	sensor->odr = hw->settings->odr_table[id].odr_avl[0].milli_hz;
+	sensor->odr = sensor->bdr = hw->settings->odr_table[id].odr_avl[0].milli_hz;
 	sensor->gain = hw->settings->fs_table[id].fs_avl[0].gain;
 	sensor->watermark = 1;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 3c5e65dc0f97..01d73002e888 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -639,7 +639,7 @@ __st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
 			return odr;
 
 		sensor->ext_info.slv_odr = val;
-		sensor->odr = odr;
+		sensor->odr = sensor->bdr = odr;
 		return 0;
 	}
 	case IIO_CHAN_INFO_SCALE:
@@ -745,7 +745,7 @@ st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	sensor = iio_priv(iio_dev);
 	sensor->id = id;
 	sensor->hw = hw;
-	sensor->odr = hw->settings->odr_table[ref_id].odr_avl[0].milli_hz;
+	sensor->odr = sensor->bdr = hw->settings->odr_table[ref_id].odr_avl[0].milli_hz;
 	sensor->ext_info.slv_odr = info->odr_table.odr_avl[0].milli_hz;
 	sensor->gain = info->fs_table.fs_avl[0].gain;
 	sensor->ext_info.settings = info;
-- 
2.39.5


