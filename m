Return-Path: <linux-kernel+bounces-761785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95421B1FE70
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEF5178301
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 05:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5EB264F81;
	Mon, 11 Aug 2025 05:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKWtsig/"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFED223DEF;
	Mon, 11 Aug 2025 05:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754888903; cv=none; b=IaWgokd5mZCcqMB7oIGcLI2wuMxN7fyriQ5oNEmW92ZH/sC12jG4p7aScta2n+x6ZcH8LGSqOEzwetyt1uZX5AJeiixENhjEWHVHy/Jb8KttW0jP1plFjdDqEvk5OjvpDX0ezt11TM5qKSScgI3VOvxCi9Yvo1XlxjgMLddhgRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754888903; c=relaxed/simple;
	bh=5uiJhoRfOxtKGWvq81/FLi9WnKz8VAzkCnYf0wdbTtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IYKRN7DUs7sDgLMwadur8i++l0X30035Kc4ZK/8m2vRL7ZPGVBb/+RdL3JCj7aCuCUWxTIDdGfVwRdcCe+YFunT+mS9e92CTK9zvRzfNxxSqhn6rVGbjRWu0bc0ITf2N3adnoJ9VO2+JyCH+TBZNmx/NFCMc5aFrVtC6YFkEi2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKWtsig/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23ffdea3575so24670015ad.2;
        Sun, 10 Aug 2025 22:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754888901; x=1755493701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJDSwxZn5qjPHOur4BV3ER0nO6KPi51EcALpL6bV2Js=;
        b=QKWtsig/MMhJQClC3427txVfLOc6wF700Kvrcj8QqA6QAAUXqixmRN/Hw3orgQZ9kK
         2SOESwuoe3/3QX1m43atx/jSy79FL+9t2MtJt8ti0NukF/KxefcrQHaSzQ0RGhV+oyAv
         1ZxCCNrX354cBuxAQ4XpRsnspR5kcF48lEr6tcgUzXYDxKjbjSCD+oDqwEi972XEJarM
         JjOWw2PDiUrrSkmLZ77PtKmWeaCiB+EU9x13atsA5AVk2AV/NQo5WpMJJUTjnnv4Skdx
         tVJf+GXCbq2rWot97hqwtFACHvatpYQ25er3c6WUJEadlACCST/+01RbCnm7ekeWgqCr
         vIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754888901; x=1755493701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJDSwxZn5qjPHOur4BV3ER0nO6KPi51EcALpL6bV2Js=;
        b=lCmbIqBuAW6zry+WYE2Mzab1KKAN1Jp0xJLO2dc41TlwRUbSu23RxaP4L8cFiidKjq
         69asmevFOU/iDCbe1BEco0sbwFyd8MRS8AgRGzInFTxNXBPtSsHL32mDc1lNqKV+dLPh
         wcJxT9ui00aEZEmCMd4xDRGIiOJgWuBGfvR7ljhqdapumOIBAZK45ZsnRdRdT8ZhXMLE
         6Yrvvy9N2XL+6S0dZlQUf4Lwfy46JX+AMlQbZsfFl/4DrAyYOUZZUVjZ3zFBe2iuM5JV
         L+OTKztpmT4hYQqNwb/hlw2GXrCI+iiH2KUhFfbosZL6d+alffp8vfo6ov+Bx9JCfC6W
         mraw==
X-Forwarded-Encrypted: i=1; AJvYcCUjscYH4dwCos74VdjwpWMWtAVKgbrhE+Bj+Np+PQ4aJ232279b9znqm1ehY1a4BqrEm/rZhaiaNGu69KpC@vger.kernel.org, AJvYcCX8KFcQmGhJLW+Eqa1okrKXKHHLr/ZkKCR5Pfths9I7QR6dSUEAePWoln5FE7afJRT+e2eRHUcYRR5qHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Kya3mhGuXKSoX3KLrFQlGvHH+oslsezMS4DAlrDe21F1vshI
	ezXUzcC5Xm20FJLRmo7ei6XGcL+KEumljZl6rgdm2PawWIsklmHirYXhQcnVnOUa
X-Gm-Gg: ASbGncsEXL3kp/X31q67lttHkhKsQeHjHer4cBPenTYxEwpsWLr7l5DwTX7mi9eOaR2
	ywssNbHCC77XRjNHM6Y4EgIzlwwcHBsTzbk7l19tTF06rrvFCPEDEmguvH41wrplRNvaP4/mHx0
	zHs28sUmO3oahy8Y9LA+r8Bi1GCCf7sUMIopNdA5c5ErItMgp2g8ctMlbMDcGwxkbRdK7j6DQ3M
	v4mN+ubhNVwdenp2aXYJ6+nlh5ivENEbnV10Jo2dXSTGYJo3VoAIHuuPL5n1gvITJ1Rr6ajEfHS
	v5pj9QDPEfwnfv1v3fbdNIYXtbHumC2M5LokvgOixgabta520UMnGHARK6s4lW1FezCV6cu2iPy
	KSrDfVwDUbfCsKyEVu4Dui8OAhzoTrtIaju+VMNKhESKX+tkSwWMm5AxP7VdZL6k=
X-Google-Smtp-Source: AGHT+IH0NRExC2zc1evQQB5lgpgJBQtmE1dlXe4V+Nf4tfGt6SgJymnZ2FcyhrwGoSvFFFpXt7Qucw==
X-Received: by 2002:a17:903:19e8:b0:240:8cb5:98b4 with SMTP id d9443c01a7336-242c205b7bamr147728715ad.23.1754888901389;
        Sun, 10 Aug 2025 22:08:21 -0700 (PDT)
Received: from CHUACHEN-M-44LQ.cisco.com ([2001:420:588c:1300:b0b4:efd7:1f57:6e0e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm264726815ad.73.2025.08.10.22.08.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 10 Aug 2025 22:08:21 -0700 (PDT)
From: Chuande Chen <chenchuande@gmail.com>
To: jdelvare@suse.com
Cc: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chuachen@cisco.com,
	chenchuande@gmail.com,
	groeck7@gmail.com
Subject: [PATCH v2 1/1] hwmon: sbtsi_temp: AMD CPU extended temperature range support
Date: Mon, 11 Aug 2025 13:07:52 +0800
Message-Id: <20250811050752.76030-2-chenchuande@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250811050752.76030-1-chenchuande@gmail.com>
References: <20250810084307.41243-1-chenchuande@gmail.com>
 <20250811050752.76030-1-chenchuande@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuande Chen <chuachen@cisco.com>

Many AMD CPUs can support this feature now.
We would get a wrong CPU DIE temp if don't consider this.
In low-temperature environments, the CPU die temperature
can drop below zero.
So many platform would like to make extended temperature range
as their default configuration.
Default temperature range (0C to 255.875C) degree celsius.
Extended temperature range (-49C to +206.875C) degree celsius.
Ref Doc: AMD V3000 PPR (Doc ID #56558).

Signed-off-by: Chuande Chen <chuachen@cisco.com>
---
V1 -> V2: addressed review comments, also save READ_ORDER bit into sbtsi_data
---
 drivers/hwmon/sbtsi_temp.c | 46 +++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/sbtsi_temp.c b/drivers/hwmon/sbtsi_temp.c
index 3c839f56c..32d6a7162 100644
--- a/drivers/hwmon/sbtsi_temp.c
+++ b/drivers/hwmon/sbtsi_temp.c
@@ -5,6 +5,7 @@
  *
  * Copyright (c) 2020, Google Inc.
  * Copyright (c) 2020, Kun Yi <kunyi@google.com>
+ * Copyright (c) 2025, Chuande Chen <chuachen@cisco.com>
  */
 
 #include <linux/err.h>
@@ -14,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/bitfield.h>
 
 /*
  * SB-TSI registers only support SMBus byte data access. "_INT" registers are
@@ -29,8 +31,23 @@
 #define SBTSI_REG_TEMP_HIGH_DEC		0x13 /* RW */
 #define SBTSI_REG_TEMP_LOW_DEC		0x14 /* RW */
 
+/*
+ * Bit for reporting value with temperature measurement range.
+ * bit == 0: Use default temperature range (0C to 255.875C).
+ * bit == 1: Use extended temperature range (-49C to +206.875C).
+ */
+#define SBTSI_CONFIG_EXT_RANGE_SHIFT	2
+/*
+ * ReadOrder bit specifies the reading order of integer and
+ * decimal part of CPU temp for atomic reads. If bit == 0,
+ * reading integer part triggers latching of the decimal part,
+ * so integer part should be read first. If bit == 1, read
+ * order should be reversed.
+ */
 #define SBTSI_CONFIG_READ_ORDER_SHIFT	5
 
+#define SBTSI_TEMP_EXT_RANGE_ADJ	49000
+
 #define SBTSI_TEMP_MIN	0
 #define SBTSI_TEMP_MAX	255875
 
@@ -38,6 +55,8 @@
 struct sbtsi_data {
 	struct i2c_client *client;
 	struct mutex lock;
+	bool ext_range_mode;
+	bool read_order;
 };
 
 /*
@@ -74,23 +93,11 @@ static int sbtsi_read(struct device *dev, enum hwmon_sensor_types type,
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
@@ -122,6 +129,8 @@ static int sbtsi_read(struct device *dev, enum hwmon_sensor_types type,
 		return temp_dec;
 
 	*val = sbtsi_reg_to_mc(temp_int, temp_dec);
+	if (data->ext_range_mode)
+		*val -= SBTSI_TEMP_EXT_RANGE_ADJ;
 
 	return 0;
 }
@@ -146,6 +155,8 @@ static int sbtsi_write(struct device *dev, enum hwmon_sensor_types type,
 		return -EINVAL;
 	}
 
+	if (data->ext_range_mode)
+		val += SBTSI_TEMP_EXT_RANGE_ADJ;
 	val = clamp_val(val, SBTSI_TEMP_MIN, SBTSI_TEMP_MAX);
 	sbtsi_mc_to_reg(val, &temp_int, &temp_dec);
 
@@ -203,6 +214,7 @@ static int sbtsi_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
 	struct sbtsi_data *data;
+	int err;
 
 	data = devm_kzalloc(dev, sizeof(struct sbtsi_data), GFP_KERNEL);
 	if (!data)
@@ -214,6 +226,14 @@ static int sbtsi_probe(struct i2c_client *client)
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, data, &sbtsi_chip_info,
 							 NULL);
 
+	mutex_lock(&data->lock);
+	err = i2c_smbus_read_byte_data(data->client, SBTSI_REG_CONFIG);
+	mutex_unlock(&data->lock);
+	if (err < 0)
+		return err;
+	data->ext_range_mode = FIELD_GET(BIT(SBTSI_CONFIG_EXT_RANGE_SHIFT), err);
+	data->read_order = FIELD_GET(BIT(SBTSI_CONFIG_READ_ORDER_SHIFT), err);
+
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
-- 
2.39.5 (Apple Git-154)


