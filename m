Return-Path: <linux-kernel+bounces-840722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E1DBB512B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EFF19E2EF1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9F22550A3;
	Thu,  2 Oct 2025 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSdzkMuV"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750B52BEC28
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759435387; cv=none; b=T49CANwLUCUsKliTp6T41KSJtx7uIXyZQRItYPGHdcT564yJPiJVhZz1LLlVSkzL9V8OAzXJqGboxTh3FfwhXErZXLR29oNUrk1lAqjxZ2By60k7PytLxIqJ7SDefcs/B3eKGwB3ze2wj5G9LNyljngSmeaIyQXccaeApR9AGb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759435387; c=relaxed/simple;
	bh=EpL1W1edi9h8REPOr4noDqXYtDbsdKwiqoOsc/wHtq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=caT9XhWCo9FFOXckZ4albSwb2gMvIYG9zVYmU6XorxY5ECFo2NHJAcTSTWMMkowNu+IUohS6X0uz28FD6Pzz6wcKgM1v/Eb9YtraQHtagvE5F62Tkt5/nUxr076DJCzc2Pijb+PFg0zFrWsOivpA9WDPhidY1NHDhIyx8k/pzdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSdzkMuV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3ee18913c0so257032466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759435382; x=1760040182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzCar1H1ETumQy6I5ubSkBWahxrlTkku+nLQixUObJ8=;
        b=WSdzkMuV9d676lRKDiOCXh7AcXk3otIz3QqZPLH+0ucFS/fZhblai2fH4Z1izdFgqN
         jw8aEYQAsIjYHNeKvVH1AP1PAcOXhq4Qq8GEbCwnMjSyPpPPNwUKPVkQ+EO/zTBj6tBW
         ZbZXqTy2FGaKy9vsYgJHP9YCuzlbq+8/MZerAZNXLIf5UtgaNRsS5fvcl1Yi9R2m8Sim
         +2/hicfSOZIkoDxsMwCVFlgics2zIZvSShR5x7eb0D6meagjVDF86q1tNbAoKBwpSTV4
         bw+nBqT40/rG8o5nrpq6r6YSnH98hvmXEqUjZvmDkHERAED0kTZ6a+D9KiUnl6Kdnqmn
         LksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759435382; x=1760040182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzCar1H1ETumQy6I5ubSkBWahxrlTkku+nLQixUObJ8=;
        b=jKNrjnE9Yimasu2xYZ0I2xk10nIcPUyNSWjQfh3DuPD7TIf/ViS4xCN5kAMV5jBTgC
         naJnpGPcIxUzuvhzNHkjW7oIC2iVB0BnfCeiC1H4t3jJH3uqlYPGVQXutJ4sQmwp4ngg
         cqsGCs8ssXEJljdWIxZigCFp9bYzmFaov0F9fuwLYhrT6FGCVyEXNAmdkSe9MTV+Yrza
         Hi5ZKzNuQczAOjhP1s7GXUx+w/EoYzDR7j/egzBZv6IP6IXnvMImZcr4ga+neL8JJ5H1
         Uuc2tYGTgVxIMJ5RaWt2btjzbHFv9y1ivNbBM8f57LzAtn2WxeRRfMfsiVoIwmqVnoRP
         GiUw==
X-Gm-Message-State: AOJu0Yw0HqSg3gNxFbVlqTcn+xnSMe+xwP/PYEA07D/727S17TPBM7Hr
	bxK4+RbSiGeE8ZFnQtbGH3g2EPyO9IUm1ukME0rjnLQZ9PqHJGEoejiQ
X-Gm-Gg: ASbGnctOiUPXRhWd+nRMe9+U/vFFllKr+aG+WjPMuKPq4CBLblkvODjKTcA04z52UlC
	kr/N7swHhN4AxtO2oscsU0lK8O9mqLRyxoDL0OVrKSs3+KRoTEInuV0bA1TQ42z868Lcb7UVxwv
	PgBI6VB9PYE+4JnUPzqz/jKaxhXUorP90t6uc7hfc/fHduXjoY505X43k/Ay+6eRfbareVypLQe
	jOS2noW2ZbCDN/9d//6LvJxKN8kPJYoNMGTI3C3dsljED59g0VFyE8gwnIwN9t6Uj50cNZVdjyf
	hv1DvqqnVUp6wiAGHuCn3Q7J0tsr1tuBUcxT9WgIs+hRKdrjU42vzaaJWgXtlR/9Xj7DJh+REWn
	W9Ucev8Tm0K6n8RdaEvh9Fc5Qvtsk+bvfTVaCNIEDUKrV
X-Google-Smtp-Source: AGHT+IGpyfeRLCnDjETKLlKioZzpJNMyWdT6kQuGS4FrfAMdqmpJBwjfEWnwHVuo/pNjJ2S0NuC65A==
X-Received: by 2002:a17:906:9f85:b0:b41:f729:77b0 with SMTP id a640c23a62f3a-b49c19775ccmr82770566b.21.1759435381559;
        Thu, 02 Oct 2025 13:03:01 -0700 (PDT)
Received: from localhost.localdomain ([78.212.167.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4c1f6sm270880466b.78.2025.10.02.13.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:03:01 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 5/5] iio: mpl3115: add support for sampling frequency
Date: Thu,  2 Oct 2025 22:02:06 +0200
Message-Id: <20251002200206.59824-6-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251002200206.59824-1-apokusinski01@gmail.com>
References: <20251002200206.59824-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the device is in ACTIVE mode the temperature and pressure measurements
are collected with a frequency determined by the ST[3:0] bits of CTRL_REG2
register.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 82 ++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index e1b2c9f2bb43..c212dfdf59ff 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -10,6 +10,7 @@
  * user offset correction, raw mode
  */
 
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -30,6 +31,7 @@
 #define MPL3115_INT_SOURCE 0x12
 #define MPL3115_PT_DATA_CFG 0x13
 #define MPL3115_CTRL_REG1 0x26
+#define MPL3115_CTRL_REG2 0x27
 #define MPL3115_CTRL_REG3 0x28
 #define MPL3115_CTRL_REG4 0x29
 #define MPL3115_CTRL_REG5 0x2a
@@ -48,6 +50,8 @@
 #define MPL3115_CTRL1_ACTIVE BIT(0) /* continuous measurement */
 #define MPL3115_CTRL1_OS_258MS GENMASK(5, 4) /* 64x oversampling */
 
+#define MPL3115_CTRL2_ST GENMASK(3, 0)
+
 #define MPL3115_CTRL3_IPOL1 BIT(5)
 #define MPL3115_CTRL3_IPOL2 BIT(1)
 
@@ -55,6 +59,25 @@
 
 #define MPL3115_CTRL5_INT_CFG_DRDY BIT(7)
 
+static const unsigned int mpl3115_samp_freq_table[][2] = {
+	{ 1,      0 },
+	{ 0, 500000 },
+	{ 0, 250000 },
+	{ 0, 125000 },
+	{ 0,  62500 },
+	{ 0,  31250 },
+	{ 0,  15625 },
+	{ 0,   7812 },
+	{ 0,   3906 },
+	{ 0,   1953 },
+	{ 0,    976 },
+	{ 0,    488 },
+	{ 0,    244 },
+	{ 0,    122 },
+	{ 0,     61 },
+	{ 0,     30 },
+};
+
 struct mpl3115_data {
 	struct i2c_client *client;
 	struct iio_trigger *drdy_trig;
@@ -170,10 +193,61 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = i2c_smbus_read_byte_data(data->client, MPL3115_CTRL_REG2);
+		if (ret < 0)
+			return ret;
+
+		ret = FIELD_GET(MPL3115_CTRL2_ST, ret);
+
+		*val = mpl3115_samp_freq_table[ret][0];
+		*val2 = mpl3115_samp_freq_table[ret][1];
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
 	return -EINVAL;
 }
 
+static int mpl3115_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
+		return -EINVAL;
+
+	*type = IIO_VAL_INT_PLUS_MICRO;
+	*length = ARRAY_SIZE(mpl3115_samp_freq_table) * 2;
+	*vals = (int *)mpl3115_samp_freq_table;
+	return IIO_AVAIL_LIST;
+}
+
+static int mpl3115_write_raw(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan,
+			     int val, int val2, long mask)
+{
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	int i, ret;
+
+	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(mpl3115_samp_freq_table); i++)
+		if (val == mpl3115_samp_freq_table[i][0] &&
+		    val2 == mpl3115_samp_freq_table[i][1])
+			break;
+
+	if (i == ARRAY_SIZE(mpl3115_samp_freq_table))
+		return -EINVAL;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG2,
+					FIELD_PREP(MPL3115_CTRL2_ST, i));
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
 static int mpl3115_fill_trig_buffer(struct iio_dev *indio_dev, u8 *buffer)
 {
 	struct mpl3115_data *data = iio_priv(indio_dev);
@@ -237,6 +311,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -250,6 +327,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
@@ -328,6 +408,8 @@ static const struct iio_trigger_ops mpl3115_trigger_ops = {
 
 static const struct iio_info mpl3115_info = {
 	.read_raw = &mpl3115_read_raw,
+	.read_avail = &mpl3115_read_avail,
+	.write_raw = &mpl3115_write_raw,
 };
 
 static int mpl3115_trigger_probe(struct mpl3115_data *data,
-- 
2.25.1


