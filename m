Return-Path: <linux-kernel+bounces-767951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB71B25AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84DD688244
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6382A24293B;
	Thu, 14 Aug 2025 05:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJNBbIDE"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55F023D7F8;
	Thu, 14 Aug 2025 05:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149995; cv=none; b=kbxYSb4JUmFfgiyODRvqFrDKdlyr4LHoCA7Zm4EbPVhoZBcpaa9U11lKIQjGPD1hVRsGAxSXgT7SIdoy0DExTPz6ZlEuCA/VKY37tfn5ijPy+pXDyTvUS7hXFjaqOsQ3+jzBiFos6hfSRZ2B+5SPwcklFyliUR6R6L2gQ6Bu4kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149995; c=relaxed/simple;
	bh=e5AEOmBI5ubZPV8R1U/vLjYLFvEKAIBznar5LFAwYFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PuZ+4s3mNgdEgC5Rbx0IEL+oOIS1v9B2cD0+RZVr7arh8Jcc/Ch0xkBjTgRSypXbVR8s7yXnjg3lQ8Z+xpxilsfu62NHStjokXjUvLBN290mY+GnHEj7dOHIvWQSnXvpJ8DysOTN+2Nm1kdTe7U3iyHX662DKoqQjiWLNepexnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJNBbIDE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24456ce0b96so7742455ad.0;
        Wed, 13 Aug 2025 22:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755149993; x=1755754793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwmRVxoypitVs3JR9eeg0vDQ0UspWnm0vg20hy8bnak=;
        b=DJNBbIDEYxczPkos0VIxZDxWzvMojkS9gQeS10rpuu4S9FuHdSjrtlMO49tqRRWm8X
         /Ccv1JjIcSSjwkYXOCw4jygBVIYGiGYXV7Xz3Yv8xXhMZGf/CAX9djMFULFnHUKCJleG
         WqfQ4GCmr1ZHjNJK2BeL1MYM7rOcH4hnQv3F+feXTjQrllIcGS5qcF/MtFX/CJJ5x0KI
         JNuEzpRJOdeFSslhpvoAt8wsQsVDTWevqQnX2D+PeWQzOImjf06IYdQvBPQsYx/Mgqm/
         ZAJy2mBG157NTtcFIkVT9qAg17jWsfoT/qs4cL41Aor6GK4IILe4fHqoujt6wU/Gxg49
         YG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755149993; x=1755754793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwmRVxoypitVs3JR9eeg0vDQ0UspWnm0vg20hy8bnak=;
        b=mqMFLVvHT4Flmt+yp7zz1eHbKyI/f9feHChkTkyPjzgipF1xkoCUOGuWv9YJnmgoRo
         JKv0LB7n9fU13W/VJs71/X1NPXahPbc8QvkLTzFlycpVKvb27pxbhohnNwA22tjdM60d
         TLmi0ish7sbW9yn4FgfmTDBPd1qMWiX66mwLPGjeuLsWSqrTKSTqf5E++etGurr1dOsE
         kAog3/A3J/1oc501JRl5zvXcZjrlNQOqiP5PbcIP4ASfW/yvkkRHpRX1Ja82yJIwaWaW
         oJu9Aipk9vhOv9w7ZiwAGVOlWyBuCr3S7+OmFGEgq6oHuXxG5hhcadWx+W9bAaqSSJLp
         f8lw==
X-Forwarded-Encrypted: i=1; AJvYcCUXjDiyUuGjvCC8hcFYYi2M6IQXY4zTmnJELelVsKSXp7Q7Ma4oKpVacC8csUdFdMRNM3Ngru6OrM+m9w==@vger.kernel.org, AJvYcCVz1KTDPTtvcH1xzxJN6cHRDPhsw1oACSrjOrtCSJ9E4Fy457/ep3k7hzGXxZ5VL9hoLvLrh/IUDYFenf7B@vger.kernel.org
X-Gm-Message-State: AOJu0YyogvbmNZsCKzATcCLt+f2rSGEe2/qRCBSVfMwNk4ZFVHZCD5HP
	2fLvRP0PDJvxNWB4NvVy4xLfAshElBYp+K0gywRUdw/ljh8InIfTsur2
X-Gm-Gg: ASbGnctjll8QM5qH+FQEeQ5t1QCwxkw9hmGS5XjW8sXgsmmGN917f/bVdE+e5qhKT76
	ulfGBHusLU6BCkj5KtHVd3P9Ek7LCQLu+sFk3bzG2AXHb2TR1kp09+nPdsCf5/JrXUcO4jeKQpX
	Nfo8hB4nYkGoXY2piPEFhSq3XMLoW2IbECNF/QHmvvGTjqIn8WbDY3ko1WxmOQYvzazbDwuhSlP
	EgGARxnODBvvLqtlfuKMCKszj6rcQsi9yt/yzDK5iPvk/QSBCKVmTg2ZtdcabgpQa4o+wU1/U1V
	2O+uqt8fcoVXdKKHvAuz+X+LmozAWfsaRO7a4ffZRpPS5lUyN3DvAxZoikcZtwBtMuK7vhqw79z
	KyKA/GB29bgXMMDguP5wJC7t61wC/qo6ReZy+J4vIq7UcOAFLvp15qNns6NdjCcM=
X-Google-Smtp-Source: AGHT+IH1U8n+8P5jeNTAYR1pb4Fjud8Ok4ZqWM5TgvKN1jvuWCzIjDhiCaFufdqVSqbZvItGHt37OQ==
X-Received: by 2002:a17:902:e88d:b0:240:8381:45b9 with SMTP id d9443c01a7336-2445c38afcbmr17068805ad.8.1755149992749;
        Wed, 13 Aug 2025 22:39:52 -0700 (PDT)
Received: from CHUACHEN-M-44LQ.cisco.com ([2001:420:588c:1300:b0b4:efd7:1f57:6e0e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899af03sm339204575ad.126.2025.08.13.22.39.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 Aug 2025 22:39:52 -0700 (PDT)
From: Chuande Chen <chenchuande@gmail.com>
To: jdelvare@suse.com
Cc: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chuachen@cisco.com,
	chenchuande@gmail.com,
	arun.george@amd.com,
	groeck7@gmail.com
Subject: [PATCH v3 1/1] hwmon: sbtsi_temp: AMD CPU extended temperature range support
Date: Thu, 14 Aug 2025 13:39:40 +0800
Message-Id: <20250814053940.96764-1-chenchuande@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250810084307.41243-1-chenchuande@gmail.com>
References: <20250810084307.41243-1-chenchuande@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuande Chen <chuachen@cisco.com>

Many AMD CPUs can support this feature now. We would get a wrong CPU DIE
temperature if don't consider this. In low-temperature environments,
the CPU die temperature can drop below zero. So many platforms would like
to make extended temperature range as their default configuration.
Default temperature range (0C to 255.875C).
Extended temperature range (-49C to +206.875C).
Ref Doc: AMD V3000 PPR (Doc ID #56558).

Signed-off-by: Chuande Chen <chuachen@cisco.com>
---
V2 -> V3: Addressed review comments. Remove my name from Copyright.
          In sbtsi_probe(), removed unnecessary lock, save config before call
          devm_hwmon_device_register_with_info().
V1 -> V2: addressed review comments, also save READ_ORDER bit into sbtsi_data
---
 drivers/hwmon/sbtsi_temp.c | 46 +++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/sbtsi_temp.c b/drivers/hwmon/sbtsi_temp.c
index 3c839f56c..a6c439e37 100644
--- a/drivers/hwmon/sbtsi_temp.c
+++ b/drivers/hwmon/sbtsi_temp.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/bitfield.h>
 
 /*
  * SB-TSI registers only support SMBus byte data access. "_INT" registers are
@@ -29,8 +30,22 @@
 #define SBTSI_REG_TEMP_HIGH_DEC		0x13 /* RW */
 #define SBTSI_REG_TEMP_LOW_DEC		0x14 /* RW */
 
+/*
+ * Bit for reporting value with temperature measurement range.
+ * bit == 0: Use default temperature range (0C to 255.875C).
+ * bit == 1: Use extended temperature range (-49C to +206.875C).
+ */
+#define SBTSI_CONFIG_EXT_RANGE_SHIFT	2
+/*
+ * ReadOrder bit specifies the reading order of integer and decimal part of
+ * CPU temperature for atomic reads. If bit == 0, reading integer part triggers
+ * latching of the decimal part, so integer part should be read first.
+ * If bit == 1, read order should be reversed.
+ */
 #define SBTSI_CONFIG_READ_ORDER_SHIFT	5
 
+#define SBTSI_TEMP_EXT_RANGE_ADJ	49000
+
 #define SBTSI_TEMP_MIN	0
 #define SBTSI_TEMP_MAX	255875
 
@@ -38,6 +53,8 @@
 struct sbtsi_data {
 	struct i2c_client *client;
 	struct mutex lock;
+	bool ext_range_mode;
+	bool read_order;
 };
 
 /*
@@ -74,23 +91,11 @@ static int sbtsi_read(struct device *dev, enum hwmon_sensor_types type,
 {
 	struct sbtsi_data *data = dev_get_drvdata(dev);
 	s32 temp_int, temp_dec;
-	int err;
 
 	switch (attr) {
 	case hwmon_temp_input:
-		/*
-		 * ReadOrder bit specifies the reading order of integer and
-		 * decimal part of CPU temp for atomic reads. If bit == 0,
-		 * reading integer part triggers latching of the decimal part,
-		 * so integer part should be read first. If bit == 1, read
-		 * order should be reversed.
-		 */
-		err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
-		if (err < 0)
-			return err;
-
 		mutex_lock(&data->lock);
-		if (err & BIT(SBTSI_CONFIG_READ_ORDER_SHIFT)) {
+		if (data->read_order) {
 			temp_dec = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_DEC);
 			temp_int = i2c_smbus_read_byte_data(data->client, SBTSI_REG_TEMP_INT);
 		} else {
@@ -122,6 +127,8 @@ static int sbtsi_read(struct device *dev, enum hwmon_sensor_types type,
 		return temp_dec;
 
 	*val = sbtsi_reg_to_mc(temp_int, temp_dec);
+	if (data->ext_range_mode)
+		*val -= SBTSI_TEMP_EXT_RANGE_ADJ;
 
 	return 0;
 }
@@ -146,6 +153,8 @@ static int sbtsi_write(struct device *dev, enum hwmon_sensor_types type,
 		return -EINVAL;
 	}
 
+	if (data->ext_range_mode)
+		val += SBTSI_TEMP_EXT_RANGE_ADJ;
 	val = clamp_val(val, SBTSI_TEMP_MIN, SBTSI_TEMP_MAX);
 	sbtsi_mc_to_reg(val, &temp_int, &temp_dec);
 
@@ -203,6 +212,7 @@ static int sbtsi_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
 	struct sbtsi_data *data;
+	int err;
 
 	data = devm_kzalloc(dev, sizeof(struct sbtsi_data), GFP_KERNEL);
 	if (!data)
@@ -211,8 +221,14 @@ static int sbtsi_probe(struct i2c_client *client)
 	data->client = client;
 	mutex_init(&data->lock);
 
-	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data, &sbtsi_chip_info,
-							 NULL);
+	err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
+	if (err < 0)
+		return err;
+	data->ext_range_mode = FIELD_GET(BIT(SBTSI_CONFIG_EXT_RANGE_SHIFT), err);
+	data->read_order = FIELD_GET(BIT(SBTSI_CONFIG_READ_ORDER_SHIFT), err);
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data,
+							 &sbtsi_chip_info, NULL);
 
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
-- 
2.39.5 (Apple Git-154)


