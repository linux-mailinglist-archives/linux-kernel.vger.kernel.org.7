Return-Path: <linux-kernel+bounces-877682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F84C1EBE5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CA913466B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590D03376A3;
	Thu, 30 Oct 2025 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dgB4bHma"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9338336EEE
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809280; cv=none; b=Egy7NQ33ZKuq+jFDhu54hObaUX42wrn1RAWrlHft/JTmXftodBwB7c1cyPFc6eziah5YSUdykEHxd2oRnoj2yorEIWQ4DwrowOHE3NWoYZ8tzP5rlHGgoKS2ixN/FEFNdf/VhCZ9NTx0KQwMS8J9DtKiLjlRJaDO0v/yuEFC4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809280; c=relaxed/simple;
	bh=rLKIJIR5n/24I4E8NSjNiQ7FAoDMdyFHbSEQW/3F2Cs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=io27ccu5NQBoCisVlfMnbuD1mf9m6DyJ/i/YTMiRpjHFoLE/Q8bfmC+g3GeW3mXGnBYWRid1oudXHWSNc9/UXbmfZcKYn1RblnROuko8VioGIRGRqvlj9j4PvMAdlRXtsd1wNqwe6lIaEZBTQWFSSKMtPSbne5wPhf0kq/Vb2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dgB4bHma; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63e076e24f2so1345542a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761809275; x=1762414075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCiysze81zvpuckihO3vXcAU03R7m1bAHp9sMdhuIQ0=;
        b=dgB4bHmagJIJYt1rCbHuIHOGbPftCl1lbOdQIUbzCLQaE6wJEUL3Un3A1WXfwDxRsR
         gOhHiPpnAx9KflzKJNdlVEoRZW/9dj/y7Ps24ePtIbYcwFTc9cL13SGf1DCk6rNywN7R
         iN8q2nQTfP7ozCavSNIani8PWND8xNBq2ekVKJBGnpaREUAlP52nJowQ20qMACtBgtFq
         n0VwRHbks/GYNlWXAycZgasxk7GjPw8V7u1qoeSynXwqU6vM8peA8te9TgX84A4XQx+E
         R2T7hLqhgQ7Row9kckcVDKHAIPDSoZZr/WMs/6JI0lclpXiU5MIGJNd7u2el+sS6dh3j
         ouLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809275; x=1762414075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCiysze81zvpuckihO3vXcAU03R7m1bAHp9sMdhuIQ0=;
        b=WEKmmqNuhKJLQ3ZnjlbIM1L+AEoSQooKTtaQPL1lv3x52x0gurkL6TirTgcd1+fKnb
         uCDVrczqmGMvyDZIYC71josPQz9FDMxN+ynXtBCZRCw7F/eLZxzuqEQga1DG+hHT4zK+
         12L1wQl7FEK4pfuL5OMRNiehVAHuOsNViVk2qYTy+Cci8vYvvegiN4JaEeHnIPjlb75D
         xmE2dFDraBJ1yoqcBgBPQKl7cDxxvlnB6u7gxSPrzQ3Kt223ncPfcNw9yEeM0DMM0AJI
         IyKsm6+7nN+n3vjEGaKy7cJ/V+zmBAeY/4NtWdC9ZrZd9H3KlN3T8D4BoijiNxIMg8SH
         I8kA==
X-Forwarded-Encrypted: i=1; AJvYcCV28NA1eqvncSLWa8Qf6QlC6Hv1aH+UuDX43gNP8Hnr3bEfxhUyOhbEdYVyg5pfagSG9lQgDNOQub+B9S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvFBmhgoa9HWd+RHtl2xlKDRnJY1R/tc0QJApU8AbwYILYGRf+
	lfvyt7P5HpVJ766r/FUDV4V+TDSc+PzmhFqnB487nxCCxjQ2CZiSuuC71B6ZQio1ybYQIAp39a/
	Epj89
X-Gm-Gg: ASbGncvchHL8HMDrXkXLLvXufdTwukSO491tXKUBp6QNniI8pcG4NlSBkJLFncmVJd2
	nnP9mw5rLeb46wIsbpYiUySDk9bufIY0yN4pXnK+K0Y7alUdkpU5uvmyYYeH6ud+fSqvC8+oaYt
	jyok6lvRk9bIEy8/IWB0kD8hPjKQl4JrGTNow5UDLxDU39FZu8ng32Kn1r7ERzzcE2iXvQEkRzL
	AIpM7VCYzq//5gicXpby4yt3eIDwLtJUaScB0vSfSPzvyFGrJppGuGIB/KcPpJ0KTfRLNs5h1wA
	OthUTRe2UafWqtp6kkRZ2dZz4JfI4mD/jYbYDrPK5YhQTba1b+xZEBzW281+N2hfvN/zguz/T+x
	Z0VcJJiyrGUVvKMMeFgecJh0vHacTh8ro0wdIWLla+AyzZR7WJv8U833x9onrnM8ceNCr14A575
	IekTz3aIkVtGQJl0l6OmmXro3K+w==
X-Google-Smtp-Source: AGHT+IF1gubCwhXQAxo5VWGyMVbyghuWrEToKA6xgkyWAPt2DG+ZR5c20KGn+rzDdDwlf0df307Afg==
X-Received: by 2002:a17:907:7e90:b0:b04:9ad9:5b29 with SMTP id a640c23a62f3a-b7053e8a712mr215556866b.54.1761809275059;
        Thu, 30 Oct 2025 00:27:55 -0700 (PDT)
Received: from localhost (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7044d00de6sm394089566b.74.2025.10.30.00.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:27:54 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] iio: imu: st_lsm6dsx: dynamically initialize iio_chan_spec data
Date: Thu, 30 Oct 2025 08:27:44 +0100
Message-Id: <20251030072752.349633-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251030072752.349633-1-flavra@baylibre.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10487; i=flavra@baylibre.com; h=from:subject; bh=rLKIJIR5n/24I4E8NSjNiQ7FAoDMdyFHbSEQW/3F2Cs=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpAxNIzfPd4xHTFizoqCtDo/6TG3u3yqb3zkuRr LH0+N9YDVKJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaQMTSAAKCRDt8TtzzpQ2 X0YODACfoc+lsjiexNlwWCPJHrBSCJN5z8yse/xMhnY2EpamcT1/8/J0lhDgJQIVPUffSruan3h 5q/AHghvEv9M2jL/eItGnq1iHvlc+6zFDfl53y/N0AJEC+oClEpuiAUcd39N58U9pyF9iUEavA8 EpHfw+d62RD/V+4MtzZqdDBOts2Y8P4+Ru4hBsZSgrIn8ySOgLoJ1io84v33uNJSnx0Wj9oHXNx CSbVbZL/956r9fENcUGN3YMUDutpGr/iHRE8C+ETNZX7eVrxfbWflSaDO1e9S52eTg7FW0+pdX1 EQ61S3hRwp9o+sBfAbQOdQr+tofcndH/tFCVwIW5/hMcncH9mI2kynYRmwhakzuomtTKy0cliIy hzHhjCkixIVwGckU7PdTSfs48qvmI844A22wIk4cXSlKGw1bm+jvzwFeTuhdq6yg23a5+xj0Hbe lx7gPBQxowLOuaz1u2BeBRIzPCE4Se8wbQ7YgJurNwAswPe9nTqF6WUC5xDDNbgU08ZtA=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

Using the ST_LSM6DSX_CHANNEL_ACC() macro as a static initializer
for the iio_chan_spec struct arrays makes all sensors advertise
channel event capabilities regardless of whether they actually
support event generation. And if userspace tries to configure
accelerometer wakeup events on a sensor device that does not
support them (e.g. LSM6DS0), st_lsm6dsx_write_event() dereferences
a NULL pointer when trying to write to the wakeup register.
Replace usage of the ST_LSM6DSX_CHANNEL_ACC() and
ST_LSM6DSX_CHANNEL() macros with dynamic allocation and
initialization of struct iio_chan_spec arrays, where the
st_lsm6dsx_event structure is only used for sensors that support
wakeup events; besides fixing the above bug, this serves as a
preliminary step for adding support for more event types.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  26 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 164 ++++++++-----------
 2 files changed, 71 insertions(+), 119 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index a4f558899767..db863bd1898d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -80,27 +80,6 @@ enum st_lsm6dsx_hw_id {
 					 * ST_LSM6DSX_TAGGED_SAMPLE_SIZE)
 #define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mask))
 
-#define ST_LSM6DSX_CHANNEL_ACC(chan_type, addr, mod, scan_idx)		\
-{									\
-	.type = chan_type,						\
-	.address = addr,						\
-	.modified = 1,							\
-	.channel2 = mod,						\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
-	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
-	.scan_index = scan_idx,						\
-	.scan_type = {							\
-		.sign = 's',						\
-		.realbits = 16,						\
-		.storagebits = 16,					\
-		.endianness = IIO_LE,					\
-	},								\
-	.event_spec = &st_lsm6dsx_event,				\
-	.ext_info = st_lsm6dsx_ext_info,				\
-	.num_event_specs = 1,						\
-}
-
 #define ST_LSM6DSX_CHANNEL(chan_type, addr, mod, scan_idx)		\
 {									\
 	.type = chan_type,						\
@@ -328,10 +307,7 @@ struct st_lsm6dsx_settings {
 		const char *name;
 		u8 wai;
 	} id[ST_LSM6DSX_MAX_ID];
-	struct {
-		const struct iio_chan_spec *chan;
-		int len;
-	} channels[2];
+	u8 chan_addr_base[2];
 	struct {
 		struct st_lsm6dsx_reg irq1;
 		struct st_lsm6dsx_reg irq2;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 216160549b5a..17b46e15cce5 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -96,26 +96,7 @@
 
 #define ST_LSM6DSX_TS_SENSITIVITY		25000UL /* 25us */
 
-static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
-	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
-	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
-	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2c, IIO_MOD_Z, 2),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
-};
-
-static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
-	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x22, IIO_MOD_X, 0),
-	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x24, IIO_MOD_Y, 1),
-	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x26, IIO_MOD_Z, 2),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
-};
-
-static const struct iio_chan_spec st_lsm6ds0_gyro_channels[] = {
-	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x18, IIO_MOD_X, 0),
-	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x1a, IIO_MOD_Y, 1),
-	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x1c, IIO_MOD_Z, 2),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
-};
+#define ST_LSM6DSX_CHAN_COUNT		4
 
 static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	{
@@ -142,15 +123,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.wai = 0x68,
 			},
 		},
-		.channels = {
-			[ST_LSM6DSX_ID_ACC] = {
-				.chan = st_lsm6dsx_acc_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
-			},
-			[ST_LSM6DSX_ID_GYRO] = {
-				.chan = st_lsm6ds0_gyro_channels,
-				.len = ARRAY_SIZE(st_lsm6ds0_gyro_channels),
-			},
+		.chan_addr_base = {
+			[ST_LSM6DSX_ID_ACC] = 0x28,
+			[ST_LSM6DSX_ID_GYRO] = 0x18,
 		},
 		.odr_table = {
 			[ST_LSM6DSX_ID_ACC] = {
@@ -246,15 +221,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.wai = 0x69,
 			},
 		},
-		.channels = {
-			[ST_LSM6DSX_ID_ACC] = {
-				.chan = st_lsm6dsx_acc_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
-			},
-			[ST_LSM6DSX_ID_GYRO] = {
-				.chan = st_lsm6dsx_gyro_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
-			},
+		.chan_addr_base = {
+			[ST_LSM6DSX_ID_ACC] = 0x28,
+			[ST_LSM6DSX_ID_GYRO] = 0x22,
 		},
 		.odr_table = {
 			[ST_LSM6DSX_ID_ACC] = {
@@ -412,15 +381,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.wai = 0x69,
 			},
 		},
-		.channels = {
-			[ST_LSM6DSX_ID_ACC] = {
-				.chan = st_lsm6dsx_acc_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
-			},
-			[ST_LSM6DSX_ID_GYRO] = {
-				.chan = st_lsm6dsx_gyro_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
-			},
+		.chan_addr_base = {
+			[ST_LSM6DSX_ID_ACC] = 0x28,
+			[ST_LSM6DSX_ID_GYRO] = 0x22,
 		},
 		.odr_table = {
 			[ST_LSM6DSX_ID_ACC] = {
@@ -590,15 +553,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.wai = 0x6a,
 			},
 		},
-		.channels = {
-			[ST_LSM6DSX_ID_ACC] = {
-				.chan = st_lsm6dsx_acc_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
-			},
-			[ST_LSM6DSX_ID_GYRO] = {
-				.chan = st_lsm6dsx_gyro_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
-			},
+		.chan_addr_base = {
+			[ST_LSM6DSX_ID_ACC] = 0x28,
+			[ST_LSM6DSX_ID_GYRO] = 0x22,
 		},
 		.odr_table = {
 			[ST_LSM6DSX_ID_ACC] = {
@@ -847,15 +804,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.wai = 0x6d,
 			},
 		},
-		.channels = {
-			[ST_LSM6DSX_ID_ACC] = {
-				.chan = st_lsm6dsx_acc_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
-			},
-			[ST_LSM6DSX_ID_GYRO] = {
-				.chan = st_lsm6dsx_gyro_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
-			},
+		.chan_addr_base = {
+			[ST_LSM6DSX_ID_ACC] = 0x28,
+			[ST_LSM6DSX_ID_GYRO] = 0x22,
 		},
 		.drdy_mask = {
 			.addr = 0x13,
@@ -1060,15 +1011,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.wai = 0x6b,
 			},
 		},
-		.channels = {
-			[ST_LSM6DSX_ID_ACC] = {
-				.chan = st_lsm6dsx_acc_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
-			},
-			[ST_LSM6DSX_ID_GYRO] = {
-				.chan = st_lsm6dsx_gyro_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
-			},
+		.chan_addr_base = {
+			[ST_LSM6DSX_ID_ACC] = 0x28,
+			[ST_LSM6DSX_ID_GYRO] = 0x22,
 		},
 		.drdy_mask = {
 			.addr = 0x13,
@@ -1237,15 +1182,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.wai = 0x70,
 			},
 		},
-		.channels = {
-			[ST_LSM6DSX_ID_ACC] = {
-				.chan = st_lsm6dsx_acc_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
-			},
-			[ST_LSM6DSX_ID_GYRO] = {
-				.chan = st_lsm6dsx_gyro_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
-			},
+		.chan_addr_base = {
+			[ST_LSM6DSX_ID_ACC] = 0x28,
+			[ST_LSM6DSX_ID_GYRO] = 0x22,
 		},
 		.drdy_mask = {
 			.addr = 0x13,
@@ -1443,15 +1382,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.wai = 0x22,
 			}
 		},
-		.channels = {
-			[ST_LSM6DSX_ID_ACC] = {
-				.chan = st_lsm6dsx_acc_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
-			},
-			[ST_LSM6DSX_ID_GYRO] = {
-				.chan = st_lsm6dsx_gyro_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_gyro_channels),
-			},
+		.chan_addr_base = {
+			[ST_LSM6DSX_ID_ACC] = 0x28,
+			[ST_LSM6DSX_ID_GYRO] = 0x22,
 		},
 		.odr_table = {
 			[ST_LSM6DSX_ID_ACC] = {
@@ -2366,21 +2299,64 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 	return st_lsm6dsx_init_hw_timer(hw);
 }
 
+static int st_lsm6dsx_chan_init(struct iio_chan_spec *channels, struct st_lsm6dsx_hw *hw,
+				enum st_lsm6dsx_sensor_id id, int index)
+{
+	struct iio_chan_spec *chan = &channels[index];
+
+	chan->type = (id == ST_LSM6DSX_ID_ACC) ? IIO_ACCEL : IIO_ANGL_VEL;
+	chan->address = hw->settings->chan_addr_base[id] + index * ST_LSM6DSX_CHAN_SIZE;
+	chan->modified = 1;
+	chan->channel2 = IIO_MOD_X + index;
+	chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
+	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
+	chan->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ);
+	chan->scan_index = index;
+	chan->scan_type.sign = 's';
+	chan->scan_type.realbits = 16;
+	chan->scan_type.storagebits = 16;
+	chan->scan_type.endianness = IIO_LE;
+	chan->ext_info = st_lsm6dsx_ext_info;
+	if (id == ST_LSM6DSX_ID_ACC) {
+		if (hw->settings->event_settings.wakeup_reg.addr) {
+			chan->event_spec = &st_lsm6dsx_event;
+			chan->num_event_specs = 1;
+		}
+	}
+	return 0;
+}
+
 static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 					       enum st_lsm6dsx_sensor_id id,
 					       const char *name)
 {
 	struct st_lsm6dsx_sensor *sensor;
 	struct iio_dev *iio_dev;
+	struct iio_chan_spec *channels;
+	int i;
 
 	iio_dev = devm_iio_device_alloc(hw->dev, sizeof(*sensor));
 	if (!iio_dev)
 		return NULL;
 
+	channels = devm_kzalloc(hw->dev, sizeof(*channels) * ST_LSM6DSX_CHAN_COUNT, GFP_KERNEL);
+	if (!channels)
+		return NULL;
+
+	for (i = 0; i < 3; i++) {
+		if (st_lsm6dsx_chan_init(channels, hw, id, i) < 0)
+			return NULL;
+	}
+	channels[3].type = IIO_TIMESTAMP;
+	channels[3].channel = -1;
+	channels[3].scan_index = 3;
+	channels[3].scan_type.sign = 's';
+	channels[3].scan_type.realbits = 64;
+	channels[3].scan_type.storagebits = 64;
 	iio_dev->modes = INDIO_DIRECT_MODE;
 	iio_dev->available_scan_masks = st_lsm6dsx_available_scan_masks;
-	iio_dev->channels = hw->settings->channels[id].chan;
-	iio_dev->num_channels = hw->settings->channels[id].len;
+	iio_dev->channels = channels;
+	iio_dev->num_channels = ST_LSM6DSX_CHAN_COUNT;
 
 	sensor = iio_priv(iio_dev);
 	sensor->id = id;
-- 
2.39.5


