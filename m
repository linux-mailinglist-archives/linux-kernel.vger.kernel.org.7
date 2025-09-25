Return-Path: <linux-kernel+bounces-833209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DE9BA16AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E83167A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9332254B;
	Thu, 25 Sep 2025 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrRY3ZQY"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4C1321F4D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833175; cv=none; b=oYCjUPx7nyWwMG/EmzCF/AJUUfZx95PUkf5z1CyzB0/4Cc080Y7aKg3cdUlzni5fDVirSnhQMf+AAIgEIBvXnq+tgIXZK4MXlZ4/0Si79ySCN/hkodA1qJlxRCpFMht6cAWcKwVmEoQvbmf6r296gSZo/2BB9R8HsKTGPFhVE0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833175; c=relaxed/simple;
	bh=u/GRHoI6+QMWuN6Vgjvw8SAJW8N3epdnzemgpwb+gz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QyaW5N8/bWzqTNDi/QzB5aqSPJI/SO+7dlO0JnrWAFuyMjmD7ntC7TZDYrsI9IZOjsFWdLqbuKC5PMsR3/MMZLpOA8tecMG1A1WjvBUEWKXJVh1bXS3tFj4RByMUU/57YtMiSzvd4G5Dd2Rm86TzNz4rmPr4i6JeKc6EijfjCmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrRY3ZQY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so925784f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758833172; x=1759437972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zPbj99Jd6vk35LiQNF3EC6C/GileQTOnsmS8pZJrbM=;
        b=jrRY3ZQY3qs8MLajl0Iqw4igMD+QvppIhL69WcrMFDm7FYFhHy1h7slJdoAnraov06
         JhGWey76NxBG09129F3u7MQxieq56gdUj+UL39CapLY3SlkMv/TVYUMVndHcxTT4ljyh
         ySyjUKxk2kyWSrTPlq9CUDzmF89pknZ56UiUGhwHYYyMXwhIMFkCIGhyig4OSAJGLaOf
         N0652Akznx5NO1nKcofTkp8UuDxNGDeVmFjRvpL32zTlAZA+vRhlxw6UL+3yOnmf4REh
         iDHp6K2pxLJJuBRpx2OKGdPeOESrY8jbKb1CzcbobRE2h89TZ1VjcP+Brpl9NjtIwrP+
         /baA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833172; x=1759437972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zPbj99Jd6vk35LiQNF3EC6C/GileQTOnsmS8pZJrbM=;
        b=kl3EvxdblPEwaXKBE0Q154ti1TgTnh569PPngTxP3MWKA8V5Z4Sr5eh+HNsoqieu4a
         AopXPQca3a4DgebFvDxgfXL9m67filc0ev5mfe1w67YLcKnFy4EAQq1AZK0i2VMpkCZI
         WCOVTnxfm0nD9WRUs9FxwL3YpVDtKX0BCkmms0MkoktfzgitDaUR3ofiSeh5zJMXi2w/
         SNHbE8iUaAmMipueJr5uIVpYNmCS7aJLeS358Wkz7G6rUBSSiLJHgh7eT27OnQSwrO7r
         or4/RF0y7CxNJGLNlYtxTvL3ProlsGC4jqXPT+ea1jhRxpxc4iOqA9H+PmGxdGLoZhPZ
         rrng==
X-Gm-Message-State: AOJu0YzR4yGaUMvjabTSwQYUfBiA1vCJJ8L8kINrtZRjBIdaEtPuLdSy
	5OXlc1+Wl/+2sBH4/8URZZZkcwQjdM5/+9ozI1VMSwvitidOWVvmSqL2
X-Gm-Gg: ASbGncu8ME3bCPET08COwqBVk68mnQsFaKjOHAK7FjsVw049Le0d0hbHIjUrw8uf7HI
	kpTdqFA0CAqFohw3hyTlzTE6ttI/Je7OzlioVHrEkpSIlCa2IDUN2sq0hfmt3dXxtU/lGPdUup7
	MTFrNzM/sIUvtgLO0ta6vs6eWE8CKxWk7kq3Ju3+Z4pT1Oif662AON0B4z2k+k1zlvGtNXGuv6g
	AOZBX5JrRo9jv/1RAQ/d2OmmQ9N4lci0JbgZ3JNafUlMzcIhjaKfFDnbxg9aHONo6U5OV04Fycn
	MX7qXLqodWcH16w5vEKtIVUc9c6BBH7zCZPMHGirxAuXzMHT13bOpqo6RiDHvuDUcK3IkOuV67v
	uqHScNvP5dp6JuT5w7snIPVbhAvXGaOTP4eeMDrk=
X-Google-Smtp-Source: AGHT+IEinpr7xThxxJ2V3S9ikl6fajqbnDTdglwGkk2yO6nzp2tfjtosXm54Fu/kSna8xTkM9qOt/A==
X-Received: by 2002:a5d:5d10:0:b0:401:c52f:62de with SMTP id ffacd0b85a97d-40e4486c1a4mr4024325f8f.12.1758833171707;
        Thu, 25 Sep 2025 13:46:11 -0700 (PDT)
Received: from localhost.localdomain ([78.209.201.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm91201395e9.1.2025.09.25.13.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:46:11 -0700 (PDT)
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
Subject: [PATCH v2 4/4] iio: mpl3115: add support for sampling frequency
Date: Thu, 25 Sep 2025 22:45:38 +0200
Message-Id: <20250925204538.63723-5-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250925204538.63723-1-apokusinski01@gmail.com>
References: <20250925204538.63723-1-apokusinski01@gmail.com>
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
 drivers/iio/pressure/mpl3115.c | 81 ++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 13c8b338a15e..b854732e61cb 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -30,6 +30,7 @@
 #define MPL3115_INT_SOURCE 0x12
 #define MPL3115_PT_DATA_CFG 0x13
 #define MPL3115_CTRL_REG1 0x26
+#define MPL3115_CTRL_REG2 0x27
 #define MPL3115_CTRL_REG3 0x28
 #define MPL3115_CTRL_REG4 0x29
 #define MPL3115_CTRL_REG5 0x2a
@@ -48,6 +49,8 @@
 #define MPL3115_CTRL1_ACTIVE BIT(0) /* continuous measurement */
 #define MPL3115_CTRL1_OS_258MS GENMASK(5, 4) /* 64x oversampling */
 
+#define MPL3115_CTRL2_ST GENMASK(3, 0)
+
 #define MPL3115_CTRL3_IPOL1 BIT(5)
 #define MPL3115_CTRL3_IPOL2 BIT(1)
 
@@ -57,6 +60,25 @@
 
 #define MPL3115_INT2 BIT(2) /* flag that indicates INT2 in use */
 
+static const unsigned int mpl3115_samp_freq_table[][2] = {
+	{ 1,      0},
+	{ 0, 500000},
+	{ 0, 250000},
+	{ 0, 125000},
+	{ 0,  62500},
+	{ 0,  31250},
+	{ 0,  15625},
+	{ 0,   7812},
+	{ 0,   3906},
+	{ 0,   1953},
+	{ 0,    976},
+	{ 0,    488},
+	{ 0,    244},
+	{ 0,    122},
+	{ 0,     61},
+	{ 0,     30},
+};
+
 struct mpl3115_data {
 	struct i2c_client *client;
 	struct iio_trigger *drdy_trig;
@@ -174,10 +196,61 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
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
 static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -229,6 +302,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -242,6 +318,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
@@ -312,6 +391,8 @@ static const struct iio_trigger_ops mpl3115_trigger_ops = {
 
 static const struct iio_info mpl3115_info = {
 	.read_raw = &mpl3115_read_raw,
+	.read_avail = &mpl3115_read_avail,
+	.write_raw = &mpl3115_write_raw,
 };
 
 static int mpl3115_trigger_probe(struct mpl3115_data *data,
-- 
2.25.1


