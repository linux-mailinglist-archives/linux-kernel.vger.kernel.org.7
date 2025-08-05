Return-Path: <linux-kernel+bounces-756414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEF2B1B3B4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE12622AEE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56893274651;
	Tue,  5 Aug 2025 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRN0mvyd"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18062737F6;
	Tue,  5 Aug 2025 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397922; cv=none; b=jnrOSMKWSA2NYnOpQCDXJXL126t+MZVKHWtTomb9p6lMGge/jI65RpWZGpJuucSHqXn63EYQrBQY21dTnxzgiRvSeKwhCY8+FYtwFBQeIkKhbk9Q2YR9/5vtMOkEsuVtla9+hvIaEtQHQ+MQ7mfO49akFvIMPR7W+RNjVyxrA1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397922; c=relaxed/simple;
	bh=ur0+FtE7C1sln/WEU2uVKhxyCP/viV94oTeRyrrapFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twJycj5ZRWFbilJxTHQmdSv/QfbfEgpXVdvFThghLRCEZcI6Sv9Zc0n3EokcTS2yeHeRI3JjXAn/Z8PC7E/CFizojESChf4/I6HRUQ4Nq+LzFcNTE83IOGoh+527KXTCWDRZUs5G47oTajKPdurnt7sff3ycdXw6vApPb1O15CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRN0mvyd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76bd6e84eddso5355042b3a.0;
        Tue, 05 Aug 2025 05:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754397920; x=1755002720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gowrAGAtt/8PGy3ltcInMP14/WjUgpF9Gx6AgOeagC0=;
        b=BRN0mvyd01ksXYHuXOQobhi6Sqbxn6LPxfXrE6J5BRtbkp3oiSjom4YCjNEvcRQ2RT
         xiue94D5B+AyKp7/+seY08PIZLIb954MVamaXPSoWwgso3K9neNyCDS0rl+3+xp3GxSD
         xYCmQxc9glfSgDhWoY3+gPmk4uy+Li8Bo1tQkF0NwHB2wONJpqBmjYakUfh2QhckNtl0
         OVGZTPyDAVNnKxhO+RRmGdOPB3JwxknVWZPmoPmep/KrUGgJwnOyulCHjeXpiV/5QLs9
         mW07AQd0DYyVLJqIwEbbNw7+q7oYf1vzPQC+RITZzCVfL2nBRWeAFXy7VGdFs0jUSPD3
         U3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754397920; x=1755002720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gowrAGAtt/8PGy3ltcInMP14/WjUgpF9Gx6AgOeagC0=;
        b=U9/XEvZIAb8D09y32EbgQ1MIX7co7ivh/6JaavnXPxOopxPhRW/EyvqUGmvKMXGZP8
         PZPOW6jdHMh3ZpdCigT7O3QwkHB/5GYqjm66TK7fs1noIXo0AGHuCUd4/ew+vS49areG
         VOSL6Bjm/YImmYSTivVJN7eVrdxyDsySkCN+4jA8f1ytHmrYGYfIrnTvghr/ZTDilpsv
         RpTgbFF8DYfZfHNJCiWsBa34k+SaRot4XwdfwkLE3Ve2efvdFBNXmj+XnU7smjZTu201
         AtZE9J6dgzdagBjEd9jWOXvcU6DhWF8BI7CsPIDKy69aZg92dRkmp77bmNW/LEwzSS03
         3BzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFwWV4TEMZF8HR72jSMraXyjvV5GbdBTmoN+jL2czJtU5+ZOBzvH7VoxBK01/G/gSLAfh5hTr5l4m6@vger.kernel.org, AJvYcCVpwM6JTBNMB1/I48EFulAoZ/TPYd5Lp63PG5nkh32PZXONXL+poXuuicvmrAOha0ysDAkDMN00c9FwVcVo@vger.kernel.org, AJvYcCWvkMVVEUWDkLrSeh/ocMGAercXP8SwA3g+oHFedTgUu15zFPisIO3ZmZrKnb04nrvlE1+ebzS5eAt5@vger.kernel.org
X-Gm-Message-State: AOJu0YzBz3h4l52Rfj1+RTIInS2cmZ3PWnXJU3mIjfkEmKvxenaBUD9j
	LkCeHKJbaULUZb3XhHpkS7kQBxqZSr9CTaQL+5l/KvtzXaqSRBrQwuO9RJjDKQ==
X-Gm-Gg: ASbGncs6r5VBzR7WtFnsbyJ+VcUjFpiTfzg3c/yWtUpAKU0u4YRxpORfMQp1Y9e+SH7
	xpcUucCPL7aLmMyU0hiNoyAtVXfv9eJNgp3fUptjg28BjTFmnsZtfBEWea64oxZtGWAvqdFCWbD
	OdBCggtMxm3//KlEPwrwL3T/oobHUgqmTMcOnUGmAYdCn1Qf5pWApG4izzrWj0NIxixxVL9XEHK
	KEFBfml2GWFTnfMFyUphFWn+9bSfhC1SJBHMg4z1bBsVb/7OSaYJmpVUmdo0BdpBXsFY1Q6IwhH
	z0l6AlI9sQ3MGS8mXQb/57HPPOWoSBzKAMPxZAnh17FlnMOqE1cQp2zlzT75qiksEF68cE9yLWU
	GoDuQv2zEsbOD2fbFHXb8OMk66+7aZc5wh9V/3tu2+Rd4diMqleLzqntbRMpF/dkliWnkevOch5
	Z87ryV
X-Google-Smtp-Source: AGHT+IEw2MkCSwxeG4/o+92lYWppE9GWCh5GkRQ4v1sjzLydlo76BptUhitZzBoLgdXN/RmRpQgLMg==
X-Received: by 2002:a05:6a20:3953:b0:20b:a75e:fa32 with SMTP id adf61e73a8af0-23df98662e8mr20899533637.40.1754397920104;
        Tue, 05 Aug 2025 05:45:20 -0700 (PDT)
Received: from CNTWS00427A.itotolink.net (111-242-118-39.dynamic-ip.hinet.net. [111.242.118.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf523sm12959863b3a.90.2025.08.05.05.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 05:45:19 -0700 (PDT)
From: ChiShih Tsai <tomtsai764@gmail.com>
To: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	t630619@gmail.com,
	ChiShih Tsai <tomtsai764@gmail.com>
Subject: [PATCH v2 2/2] hwmon: (pmbus/adm1275) add sq24905c support
Date: Tue,  5 Aug 2025 20:44:49 +0800
Message-ID: <20250805124449.15187-3-tomtsai764@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805124449.15187-1-tomtsai764@gmail.com>
References: <20250805124449.15187-1-tomtsai764@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for sq24905c which is similar to adm1275 and other chips
of the series.

Signed-off-by: ChiShih Tsai <tomtsai764@gmail.com>
---
 Documentation/hwmon/adm1275.rst | 24 ++++++++++++++++--------
 drivers/hwmon/pmbus/Kconfig     |  3 ++-
 drivers/hwmon/pmbus/adm1275.c   | 11 ++++++++---
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/Documentation/hwmon/adm1275.rst b/Documentation/hwmon/adm1275.rst
index 57bd7a850558..cf923f20fa52 100644
--- a/Documentation/hwmon/adm1275.rst
+++ b/Documentation/hwmon/adm1275.rst
@@ -67,6 +67,14 @@ Supported chips:
 
     Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1293_1294.pdf
 
+  * Silergy SQ24905C
+
+    Prefix: 'mc09c'
+
+    Addresses scanned: -
+
+    Datasheet: https://www.silergy.com/download/downloadFile?id=5669&type=product&ftype=note
+
 Author: Guenter Roeck <linux@roeck-us.net>
 
 
@@ -74,14 +82,14 @@ Description
 -----------
 
 This driver supports hardware monitoring for Analog Devices ADM1075, ADM1272,
-ADM1273, ADM1275, ADM1276, ADM1278, ADM1281, ADM1293, and ADM1294 Hot-Swap
-Controller and Digital Power Monitors.
+ADM1273, ADM1275, ADM1276, ADM1278, ADM1281, ADM1293, ADM1294, and SQ24905C
+Hot-Swap Controller and Digital Power Monitors.
 
-ADM1075, ADM1272, ADM1273, ADM1275, ADM1276, ADM1278, ADM1281, ADM1293, and
-ADM1294 are hot-swap controllers that allow a circuit board to be removed from
-or inserted into a live backplane. They also feature current and voltage
-readback via an integrated 12 bit analog-to-digital converter (ADC), accessed
-using a PMBus interface.
+ADM1075, ADM1272, ADM1273, ADM1275, ADM1276, ADM1278, ADM1281, ADM1293,
+ADM1294 and SQ24905C are hot-swap controllers that allow a circuit board to be
+removed from or inserted into a live backplane. They also feature current and
+voltage readback via an integrated 12 bit analog-to-digital converter (ADC),
+accessed using a PMBus interface.
 
 The driver is a client driver to the core PMBus driver. Please see
 Documentation/hwmon/pmbus.rst for details on PMBus client drivers.
@@ -160,5 +168,5 @@ temp1_highest		Highest observed temperature.
 temp1_reset_history	Write any value to reset history.
 
 			Temperature attributes are supported on ADM1272,
-			ADM1273, ADM1278, and ADM1281.
+			ADM1273, ADM1278, ADM1281 and SQ24905C.
 ======================= =======================================================
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 55e492452ce8..77add0c6ee53 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -52,7 +52,8 @@ config SENSORS_ADM1275
 	help
 	  If you say yes here you get hardware monitoring support for Analog
 	  Devices ADM1075, ADM1272, ADM1273, ADM1275, ADM1276, ADM1278, ADM1281,
-	  ADM1293, and ADM1294 Hot-Swap Controller and Digital Power Monitors.
+	  ADM1293, ADM1294 and SQ24905C Hot-Swap Controller and
+	  Digital Power Monitors.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called adm1275.
diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 7d175baa5de2..bc2a6a07dc3e 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -18,7 +18,8 @@
 #include <linux/log2.h>
 #include "pmbus.h"
 
-enum chips { adm1075, adm1272, adm1273, adm1275, adm1276, adm1278, adm1281, adm1293, adm1294 };
+enum chips { adm1075, adm1272, adm1273, adm1275, adm1276, adm1278, adm1281,
+	 adm1293, adm1294, sq24905c };
 
 #define ADM1275_MFR_STATUS_IOUT_WARN2	BIT(0)
 #define ADM1293_MFR_STATUS_VAUX_UV_WARN	BIT(5)
@@ -486,6 +487,7 @@ static const struct i2c_device_id adm1275_id[] = {
 	{ "adm1281", adm1281 },
 	{ "adm1293", adm1293 },
 	{ "adm1294", adm1294 },
+	{ "mc09c", sq24905c },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adm1275_id);
@@ -532,7 +534,8 @@ static int adm1275_probe(struct i2c_client *client)
 		dev_err(&client->dev, "Failed to read Manufacturer ID\n");
 		return ret;
 	}
-	if (ret != 3 || strncmp(block_buffer, "ADI", 3)) {
+	if ((ret != 3 || strncmp(block_buffer, "ADI", 3)) &&
+	    (ret != 2 || strncmp(block_buffer, "SY", 2))) {
 		dev_err(&client->dev, "Unsupported Manufacturer ID\n");
 		return -ENODEV;
 	}
@@ -558,7 +561,8 @@ static int adm1275_probe(struct i2c_client *client)
 
 	if (mid->driver_data == adm1272 || mid->driver_data == adm1273 ||
 	    mid->driver_data == adm1278 || mid->driver_data == adm1281 ||
-	    mid->driver_data == adm1293 || mid->driver_data == adm1294)
+	    mid->driver_data == adm1293 || mid->driver_data == adm1294 ||
+	    mid->driver_data == sq24905c)
 		config_read_fn = i2c_smbus_read_word_data;
 	else
 		config_read_fn = i2c_smbus_read_byte_data;
@@ -708,6 +712,7 @@ static int adm1275_probe(struct i2c_client *client)
 		break;
 	case adm1278:
 	case adm1281:
+	case sq24905c:
 		data->have_vout = true;
 		data->have_pin_max = true;
 		data->have_temp_max = true;
-- 
2.43.0


