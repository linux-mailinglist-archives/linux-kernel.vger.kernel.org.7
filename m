Return-Path: <linux-kernel+bounces-834691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98656BA5495
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD83B1C02944
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E667930CB5B;
	Fri, 26 Sep 2025 22:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ficbu0oC"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8A530DD17
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758924157; cv=none; b=RlqTvRPXx63MnwFBxgQU7Pl0vBysvWWsBdmCImwtzmQwkFaAAeaOZOE38LT3zWIMsOLbP6WxpxZgQZbisZj3vidtjnSbI8DKX22KdRhQTSXnycFS/MzgapH6v4TOhbzBnOp9UIfo7qSIsTyLxAEnr8j8QyCL1/xZ667mGreOJZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758924157; c=relaxed/simple;
	bh=XOWax2v2KYX1458l61V4MRz49SxrJWypS2Bb8v3VlCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFYBqPPvcLzDU+J/gH8iysBmPsBH8dH7RcAPKSPtVNicA26ZPLvp1HkrxBj8hdMkI5XMJUBRflRHEtSNuZv1XhkystBKPMvSU5PJNOURX7NgEcMJZzx8uBYgILaOOW0LTvq8b8qKNf1uZtuxdCNulzox4kYOyCfPs4/pYdYR7G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ficbu0oC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e3ea0445fso5857105e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758924153; x=1759528953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keOSSq7qxCBLRN0euL2Ky8S0cfHWSYbEeRT4dYHPsaY=;
        b=ficbu0oCeiXmTNKpeBXVxufQHdrwyF9y9PXabjSe7RPq1XGHSg2HgNYTIuL/GzKgF9
         Yy+V1Rf8GaDpWYUmz4WYpv+WDWtp/1boAkY059NCup0YpeCYTQ4rjwWVIBTjFIZeW4b/
         UoC3+cuj85MFhK5H67Y8Zvelo6c2wimADdsUePA6d3CdtaELxO+4HYZ+J4QbiVLOwVv2
         1KEKXTE7OgHnOcD4jUeb3Ctb2XYl8yv2MKsex4mbRXiD5OYzddxi/GUDM9okLuxgzSvL
         F0liJHi41xhvW+2wC+X48BrIeLukgfLTCG6siw44IMB/LbzdWRAJn4OpC53pdglMnhjj
         ONAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758924153; x=1759528953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keOSSq7qxCBLRN0euL2Ky8S0cfHWSYbEeRT4dYHPsaY=;
        b=QRj9GbXJPaswrk4/iegKsa4ksPO6YlA+ls/MffqBpaYXi/iYqMsr5QGXlO6swQ3qLh
         e59n9mHjWMPYcBv960s3/0OTmC0yyaexRCC7GG9rdSHruY14c/iTyLa5pNniRrT1Itzg
         T4EyUW/kpQ7GDmm2Zgsyoo3VX80HQktVeGiR7tZ6/Nwx6xWtFQJCz89S4vfLzjAMdttp
         ls/MIF0KpSvFv+gU1PBDyx3YVhemhWX6/5jC0IVvSG0DvEoA1SDB8D96bLp9dTPKvMlJ
         lDcGmbHhWTzz0h2bN49DxvH3z5fTUN+bgeBCZNWoHuEO8PV1QhD71o6qmdoKao3bo/IB
         EQJw==
X-Gm-Message-State: AOJu0YxjoI3RSbbBQkiX1r0MemfnV+ENWQ6yEt+6M1+qvNH2xGFhQmqC
	mOsWV2/HmO6Zbj84ny96mZKPANho6G+s+BPFh/I7TcJtg0QoueXoGVM/
X-Gm-Gg: ASbGncsM7xi2B/Z7aGDS4vO4p2dM81OuF1h0H5/mBah9k8noD6DKDjA14DQ3leRTmXi
	1jkGRJHLY5WQ3R8CFT4uQVx2YTKANDHY5PE6jDMTOOxmcuL6WfEp6cXiM1NTiuAA8zT8D7CvjBG
	MXPxCPeDAU8VWOs+FEkvbXWP1y5eshYm0sNWjthPhxEaJztL6DKREFxdbDAMekghiowjYJPhSW3
	xu4HpaCb2dO7RwOnbmyJkvsEiqrBowFz10ALJZlYJ5ZbLXULjR880x2fo6ddal03LxKKUtUrqn8
	kbYorCBCQBkAQaxbwIZkCgcjjpHQBDRc6dnLPA9s0wiwZyuSsWZx/mUNzQ2IS2e5i6poOdU+tIC
	5jZa7oPV5fG206wrW3nZCGBy9LAPV+5hWBR4aEqJp+u1KyH0ZGQLMMY9CoPwolw==
X-Google-Smtp-Source: AGHT+IFmlxLVnZBT1LwhYEs7yN9fTfegYhgr8vdvZKMVbXQQXf+IleK74UBzGjvgjkwQypDXTAq/UA==
X-Received: by 2002:a05:600c:37ce:b0:46e:38f7:625f with SMTP id 5b1f17b1804b1-46e38f762f6mr57509815e9.10.1758924152513;
        Fri, 26 Sep 2025 15:02:32 -0700 (PDT)
Received: from localhost.localdomain ([37.163.230.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2965sm8410236f8f.55.2025.09.26.15.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:02:31 -0700 (PDT)
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
Subject: [PATCH v3 4/4] iio: mpl3115: add support for sampling frequency
Date: Sat, 27 Sep 2025 00:01:50 +0200
Message-Id: <20250926220150.22560-5-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250926220150.22560-1-apokusinski01@gmail.com>
References: <20250926220150.22560-1-apokusinski01@gmail.com>
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
index 13c8b338a15e..04c126ff4d46 100644
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
 
@@ -57,6 +61,25 @@
 
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
@@ -174,10 +197,61 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
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
@@ -229,6 +303,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 		.type = IIO_PRESSURE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 0,
 		.scan_type = {
 			.sign = 'u',
@@ -242,6 +319,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = 1,
 		.scan_type = {
 			.sign = 's',
@@ -312,6 +392,8 @@ static const struct iio_trigger_ops mpl3115_trigger_ops = {
 
 static const struct iio_info mpl3115_info = {
 	.read_raw = &mpl3115_read_raw,
+	.read_avail = &mpl3115_read_avail,
+	.write_raw = &mpl3115_write_raw,
 };
 
 static int mpl3115_trigger_probe(struct mpl3115_data *data,
-- 
2.25.1


