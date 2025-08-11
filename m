Return-Path: <linux-kernel+bounces-763306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5089FB21304
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F33777A780A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0145F238171;
	Mon, 11 Aug 2025 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEcF/qI+"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26B417993;
	Mon, 11 Aug 2025 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754932603; cv=none; b=r3n8TCFGCziAocM2G89mEhWI3U6DZTEJlgVYC1tOkm+2xV6rer3hm+5jOKUUHnOn/cBxqQuEnO0lOUfIWdKvA/L334FST2qCMmABZZuhKLiTrJx71K9H7fPj+mctAVSRYjs8YuwrbrbjeHro8FE5Xow8ZTJmttIn+4szWuHYnp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754932603; c=relaxed/simple;
	bh=e5AEOmBI5ubZPV8R1U/vLjYLFvEKAIBznar5LFAwYFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aB4iiZqkJZVLT9W+Yom8TDwvwZ8khedNrNuQLJ3lSBFWjN0M3/6RMz+EZj0hrcg1yTaeIOdXFJCuFrV8UYMMBGErg0BwQMY0eJJcmz0Hn9i8WIyQXoJ7vJCQT+hSZxUnuL54HbYymg8r7YPewRSyEIywup5zv5z4iFgeM94BZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEcF/qI+; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b3aa2a0022cso5266903a12.1;
        Mon, 11 Aug 2025 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754932601; x=1755537401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwmRVxoypitVs3JR9eeg0vDQ0UspWnm0vg20hy8bnak=;
        b=PEcF/qI+bMVUfnEJgYp8bW0PsIx47Ai+v61LKOpd8AEWzN6NouVHQLIX+2i6rxSOIJ
         p1Re+ZVjO3uh5A14dGJXqp1XOK/0OQecfR3+m6gq30Rx1q5QpfErKUZ8NkCQbU5YvhSL
         nFpX+nbg2bdxhdiAbRIR8M9gtSGNROhRjCvH6Rh2+3rhVn6Ye8UJK337FX9DTqfKHwFT
         zfUrielIAR6X1oZgRWgHaJZHiBinhiQIid80YGoO2sIBxOA5jaePLGyiV9DufQiU/imL
         7kTf/KbDY7mpESODStmxQkdXnamW9r4dQJwvYY98+/7OPG+5tjk4EKRn22ha/MnThgXz
         Y3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754932601; x=1755537401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwmRVxoypitVs3JR9eeg0vDQ0UspWnm0vg20hy8bnak=;
        b=PKfTsIFi0yRiCDegMSm3iUfTxp6pRN6hrPw+4QjIXqd8tDLielYKr7+u5pejD0CB2I
         zXWegHgLkGBmAhmEJ/IhtmQeXCOGEHaE3zKat5DoYnhZd6y82Q0XX6o0YtwLWOXUcSKa
         nlz/qFmTtLBkbAGR3fLvbcfnfwqeIDD5uUTIFsVuVZvD9ZYWPnT4yW7ComyiKAhat0UU
         /8WZQ0Nfl2br8//5UUQj/S5M9EZkx+0j5EeqUrSIBaaH0ukwKZN1U/X8g0KTVF1b6ehp
         FwaDAAkKjQPhLkJfdmFo9Uz8w54KQ3tT1vfHs8taX4kR1OOxGPGX+YlN6UgxC+MRBwVK
         xQew==
X-Forwarded-Encrypted: i=1; AJvYcCUAHylfPHt8tvczSVYtlwVBD6JZIFk3ePpxn7zvXDJ55IFYXgRp+EBBJgKnPUCIKuwe1zrv1aNwbIfsinac@vger.kernel.org, AJvYcCWW+PNsgZQWX5TGYHJZfrHTYsrvZOiQcDI6rcXr8bP+Hjwmi2wSjK4bnX0oSrfTDx+XatZpH43wg2Qhmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0a6LvovqDcjxO66IpgfPxeMLbezmJ0TwMvtzjfWSPocOMezxP
	dgIIdn3JqC5g0Q6qhsRDadDp3CroIPAVqint9zDyJohyLEeLLuh2YYbK
X-Gm-Gg: ASbGnct4qkCKDOXCKvG1/p+y81gWjlZnjqvCZAkIS1ExMqjYIR/EBl3elaHPubCLQ/m
	6HvnI+9wrlv4HrotaoHN59fpfUQ5BJQzexUJRWkHWjmPTt4vGukxGBPcr4gjeiMfjrrSHACn2SQ
	DhjCVA/memY1AMbBdFE98teDMT62wBU5JjyUqY8mWuvWwB82weEnXoJGU44V0lUfwNVLkALM6hK
	OGSFfiPaKrIKwcAsvlrtCX3TJHQ7xC0GokV514Q5k3XtbJsJUXeEBmoFshmTqRmHinUE66UFQcV
	hy913551yuonvo9IG9apeBkEJdRejq9QYCEvChYsO6IXQh1VmoWczMOqYpELdcwcKIQ10TiPvRh
	B1TV3fdytCSrissHA4jQ+dBWd5dI5nvoHJCX1cbxhP3JGxRA6bMEsHlxAWQ==
X-Google-Smtp-Source: AGHT+IE50h5mcmr8mOXI5L5sRxc1wqOhPappRgG0t7wckt4aPH31efcFQDa6CMVj7hc76Pues2I1iA==
X-Received: by 2002:a17:903:32c5:b0:240:2145:e50b with SMTP id d9443c01a7336-242fc205323mr5988625ad.11.1754932600937;
        Mon, 11 Aug 2025 10:16:40 -0700 (PDT)
Received: from CHUACHEN-M-44LQ.cisco.com ([64.104.44.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89a077csm278386895ad.138.2025.08.11.10.16.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 Aug 2025 10:16:40 -0700 (PDT)
From: Chuande Chen <chenchuande@gmail.com>
To: jdelvare@suse.com
Cc: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chuachen@cisco.com,
	chenchuande@gmail.com,
	groeck7@gmail.com
Subject: [PATCH v3 1/1] hwmon: sbtsi_temp: AMD CPU extended temperature range support
Date: Tue, 12 Aug 2025 01:16:30 +0800
Message-Id: <20250811171630.23302-1-chenchuande@gmail.com>
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


