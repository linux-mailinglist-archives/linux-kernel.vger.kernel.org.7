Return-Path: <linux-kernel+bounces-818514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B84BB592C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D935E1BC5E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF312BE646;
	Tue, 16 Sep 2025 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzFZqaXm"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DB42BD5A2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016372; cv=none; b=e3fvocT8ZjT0tgw8Q2KVKb9W3FGgA0FUgCi9k7XFFdk/cT5V5g06+8MAJjevzzXk/71ZOVi5/XIua6b+N4Qtf98kJ4nWZXaAbN5pXP+SvfpzxICWlk/Lul1on1ekNmJTAk+YahL+yymfkI8rPH4gvH/zkSm0Y5Amcl9cQMLs04s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016372; c=relaxed/simple;
	bh=GMzo4G/K64hUgE+aHnc+wOYatYFyjlLEAeAZYwZxris=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEpCbgZhFv0y1tmZKzTExqBt5XTjm4Ss0qC37zA7CrhNlKHAccd8p46JNN7tlohxr87CYajiPdbBFbIC+X886RjTv3aPXiL0ALrCt+Vdiab6h/zHPUd6kZQwBpfMz+nU/mSwLp6eZsEn6qWUoZ/zjSlJiD80SQ+7EA9jvw7Ocig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzFZqaXm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-25669596955so54020555ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758016369; x=1758621169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49QsBXiYXTpwW15ExZiEsCuxBVACiimdNLk2zhQ/sDM=;
        b=LzFZqaXmRf5tFdb7bf0dtd/95SZiusiKCKTzeFHeiPz7NjorZOp1oCFpkSdqOSLkEd
         EoC0nAMoVaxHLVwmCuINFABOdzCVMmWog1yfrHnXh3nJjUfi08PzAbxnNXY+uP4MYUHR
         WlMi5o5mpCvJF53KrhU/dHNNfXjo0eLvjbKTu1YtxslmmJNB6hVwO8U0DbmsBRxpT3cD
         G91J+artgkmdbisjLTykOOYX6sBHS/m+XnowLkR0kloByfJMbpGzLT9EEFsosxirVGYF
         Psb2H7fuXaNw6Q/MGzNqpycuYXgCv5+98oWc8NQDlVWQHdNfZ216//VuAQyTYRK96FYC
         0pZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758016369; x=1758621169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49QsBXiYXTpwW15ExZiEsCuxBVACiimdNLk2zhQ/sDM=;
        b=OkN1rD0nuMZukUJJoN7ReFKphR4faMmkU3QULx3XInuS7TwzEtvnoXrrW5TQdqHtxn
         V7Ayr8j22hWJFLxY/cf64yijQNV8eCvgAo7pMlhyTf5Q/ZdkP9sW92n/d2vny6maX6MH
         XZYcgYFHag4V06v9gruK3o//PyNFUieHh0u0M0O0UNNl9SkLJ24wWHX0PC4wK72+uqqf
         PXnsRS/Y4iNtYay7HuXsRBjwC9fk32I8Xc0dZHD5npSqdJped7aGV+kb1j+9S1ToTwva
         aReUAEN95nVn+A13gpSD5BrZsAL35iZZirIWbPPnzW95FexTCpt6J2OGT1JQdu0ZiZYP
         4ZYA==
X-Forwarded-Encrypted: i=1; AJvYcCXFX9u4M2w7zrEBBOH36v0c6+sctiYq0iE8fJ2ROkp69eNX2uR9gMo0Gv+EnYWoBXW4PNc0pLpQpoy9aWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBMab4qO67Kkw+WAm0fw1Bl1wdsS7tTjx/mwsohoXKtc7W9AK0
	vS4SS2EZG8QPGnYV5c6a4c1WVeDCxOvEQ3GqdWWg8pcfl1dM0h/mZU5Z
X-Gm-Gg: ASbGncv7bc5PkOii8WIaAV5j5dC8g1jXLlYY3KSsymaEJveJz/WNeXC3zZpiFNRpMgG
	6zIPgnVnPZiUcMevNDu1Y8Ve053gAvNTqxtPeRqFp/7HYX1AntuKJvajFTNBuN9z8VRNgOs0DJi
	RDXG4WJH9cREJvQWetrbScMJGSTpFhSqel4ozzKlvmMvvY3VK6P923OE3sRWHfVBb3JigNxqK2z
	ADGZf73dmER3iS79M+G9JUFYKqC8fR8axa8V4t6hz+/KBUYsJDZ3F1IhBUId3GhXzWzO8sO1qWm
	Y47nBTByRYIElFeKaJZQNpvS3HgwokXc1iSq2RCzkPxyLeDKoTFho4NkMTXMpK/RIdPCGrGc6a2
	0EMBxfYYy9zRvtUregIEdk4a+jJlxGnA2JZp5R9ax3xki+BciMCu27p9QMtUVKaNuQkWt0pSmPS
	4t8VA9sBwsGWsqg6JU2VBHvJ0=
X-Google-Smtp-Source: AGHT+IF9/+KWd45S6FYhiVJ8Q4f8Eu69CpQKUelHersC4ax5SQgbWHAEIysbDLfaY6JhGQ4DWDv1Vg==
X-Received: by 2002:a17:902:c40a:b0:267:6754:8fd9 with SMTP id d9443c01a7336-26767549b82mr74458675ad.39.1758016369128;
        Tue, 16 Sep 2025 02:52:49 -0700 (PDT)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2667b4d380csm53935775ad.71.2025.09.16.02.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:52:48 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH 2/2] hwmon: (pmbus/mp5990) add support for MP5998
Date: Tue, 16 Sep 2025 17:50:26 +0800
Message-ID: <20250916095026.800164-2-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916095026.800164-1-chou.cosmo@gmail.com>
References: <20250916095026.800164-1-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the MPS MP5998 hot-swap controller. Like MP5990, MP5998
uses EFUSE_CFG (0xC4) bit 9 to indicate linear/direct data format.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 Documentation/hwmon/mp5990.rst | 30 +++++++++++++--
 drivers/hwmon/pmbus/mp5990.c   | 67 ++++++++++++++++++++++++++++++----
 2 files changed, 85 insertions(+), 12 deletions(-)

diff --git a/Documentation/hwmon/mp5990.rst b/Documentation/hwmon/mp5990.rst
index 6f2f0c099d44..7fd536757ff2 100644
--- a/Documentation/hwmon/mp5990.rst
+++ b/Documentation/hwmon/mp5990.rst
@@ -9,9 +9,13 @@ Supported chips:
 
     Prefix: 'mp5990'
 
-  * Datasheet
+    Datasheet: Publicly available at the MPS website: https://www.monolithicpower.com/en/mp5990.html
 
-    Publicly available at the MPS website : https://www.monolithicpower.com/en/mp5990.html
+  * MPS MP5998
+
+    Prefix: 'mp5998'
+
+    Datasheet: Not publicly available
 
 Author:
 
@@ -21,7 +25,7 @@ Description
 -----------
 
 This driver implements support for Monolithic Power Systems, Inc. (MPS)
-MP5990 Hot-Swap Controller.
+MP5990 and MP5998 Hot-Swap Controller.
 
 Device compliant with:
 
@@ -53,7 +57,7 @@ The driver provides the following attributes for output voltage:
 
 **in2_alarm**
 
-The driver provides the following attributes for output current:
+The driver provides the following attributes for current:
 
 **curr1_input**
 
@@ -63,6 +67,14 @@ The driver provides the following attributes for output current:
 
 **curr1_max**
 
+**curr2_input**
+
+**curr2_label**
+
+**curr2_max**
+
+**curr2_max_alarm**
+
 The driver provides the following attributes for input power:
 
 **power1_input**
@@ -71,6 +83,16 @@ The driver provides the following attributes for input power:
 
 **power1_alarm**
 
+The driver provides the following attributes for output power:
+
+**power2_input**
+
+**power2_label**
+
+**power2_max**
+
+**power2_max_alarm**
+
 The driver provides the following attributes for temperature:
 
 **temp1_input**
diff --git a/drivers/hwmon/pmbus/mp5990.c b/drivers/hwmon/pmbus/mp5990.c
index 4ce381a39480..9a4ee79712cf 100644
--- a/drivers/hwmon/pmbus/mp5990.c
+++ b/drivers/hwmon/pmbus/mp5990.c
@@ -8,6 +8,8 @@
 #include <linux/of_device.h>
 #include "pmbus.h"
 
+enum chips { mp5990, mp5998 };
+
 #define MP5990_EFUSE_CFG	(0xC4)
 #define MP5990_VOUT_FORMAT	BIT(9)
 
@@ -110,10 +112,53 @@ static struct pmbus_driver_info mp5990_info = {
 	.read_word_data = mp5990_read_word_data,
 };
 
+static struct pmbus_driver_info mp5998_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = direct,
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.format[PSC_CURRENT_IN] = direct,
+	.format[PSC_CURRENT_OUT] = direct,
+	.format[PSC_POWER] = direct,
+	.format[PSC_TEMPERATURE] = direct,
+	.m[PSC_VOLTAGE_IN] = 64,
+	.b[PSC_VOLTAGE_IN] = 0,
+	.R[PSC_VOLTAGE_IN] = 0,
+	.m[PSC_VOLTAGE_OUT] = 64,
+	.b[PSC_VOLTAGE_OUT] = 0,
+	.R[PSC_VOLTAGE_OUT] = 0,
+	.m[PSC_CURRENT_IN] = 16,
+	.b[PSC_CURRENT_IN] = 0,
+	.R[PSC_CURRENT_IN] = 0,
+	.m[PSC_CURRENT_OUT] = 16,
+	.b[PSC_CURRENT_OUT] = 0,
+	.R[PSC_CURRENT_OUT] = 0,
+	.m[PSC_POWER] = 2,
+	.b[PSC_POWER] = 0,
+	.R[PSC_POWER] = 0,
+	.m[PSC_TEMPERATURE] = 1,
+	.b[PSC_TEMPERATURE] = 0,
+	.R[PSC_TEMPERATURE] = 0,
+	.func[0] =
+		PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT |
+		PMBUS_HAVE_IIN | PMBUS_HAVE_PIN | PMBUS_HAVE_POUT |
+		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_IOUT |
+		PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
+	.read_byte_data = mp5990_read_byte_data,
+	.read_word_data = mp5990_read_word_data,
+};
+
+static const struct i2c_device_id mp5990_id[] = {
+	{"mp5990", mp5990},
+	{"mp5998", mp5998},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mp5990_id);
+
 static int mp5990_probe(struct i2c_client *client)
 {
 	struct pmbus_driver_info *info;
 	struct mp5990_data *data;
+	enum chips chip;
 	int ret;
 
 	data = devm_kzalloc(&client->dev, sizeof(struct mp5990_data),
@@ -121,7 +166,15 @@ static int mp5990_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-	memcpy(&data->info, &mp5990_info, sizeof(*info));
+	if (client->dev.of_node)
+		chip = (uintptr_t)of_device_get_match_data(&client->dev);
+	else
+		chip = i2c_match_id(mp5990_id, client)->driver_data;
+
+	if (chip == mp5990)
+		memcpy(&data->info, &mp5990_info, sizeof(*info));
+	else
+		memcpy(&data->info, &mp5998_info, sizeof(*info));
 	info = &data->info;
 
 	/* Read Vout Config */
@@ -140,6 +193,9 @@ static int mp5990_probe(struct i2c_client *client)
 		data->info.format[PSC_VOLTAGE_OUT] = linear;
 		data->info.format[PSC_CURRENT_OUT] = linear;
 		data->info.format[PSC_POWER] = linear;
+		if (chip == mp5998)
+			data->info.format[PSC_CURRENT_IN] = linear;
+
 		ret = i2c_smbus_read_word_data(client, PMBUS_READ_VOUT);
 		if (ret < 0) {
 			dev_err(&client->dev, "Can't get vout exponent.");
@@ -153,16 +209,11 @@ static int mp5990_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id mp5990_of_match[] = {
-	{ .compatible = "mps,mp5990" },
+	{ .compatible = "mps,mp5990", .data = (void *)mp5990 },
+	{ .compatible = "mps,mp5998", .data = (void *)mp5998 },
 	{}
 };
 
-static const struct i2c_device_id mp5990_id[] = {
-	{"mp5990"},
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, mp5990_id);
-
 static struct i2c_driver mp5990_driver = {
 	.driver = {
 		   .name = "mp5990",
-- 
2.43.0


