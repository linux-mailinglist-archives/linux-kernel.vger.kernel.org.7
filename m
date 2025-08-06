Return-Path: <linux-kernel+bounces-758439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CAFB1CF25
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A66D18C56F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0726E239E7F;
	Wed,  6 Aug 2025 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iw5FpPOk"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC60923717F;
	Wed,  6 Aug 2025 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754519872; cv=none; b=prvjdyKkUl5nXenlbGV5agr5eJWsFfJQ83rBeva5zllOBB6M88DpNhGTUMH42pB2jsSvFcFmyGYnXi/wmCgYU92XXT0AIG9GyBFEa6gBnEhMlnnNxfufUhpS2Nwa7dwQOplC4jAGKhXhjSemiv05DQYnEVs71ADfbY/QI74W6ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754519872; c=relaxed/simple;
	bh=ur0+FtE7C1sln/WEU2uVKhxyCP/viV94oTeRyrrapFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uqpkgr38FaGsyfJ+mO96ALVLoy/oMGoPrwTCYtBH3mhzyeqQRonGCAKf1xoFRSglrJgCBcKWJ7CJcclQPpo8Y76+UpYH9AzYigLrcE9R2XxN3mcXza1unNwM0Xr0qrdAEeK+IS+pKD6ZrbtwPjLb98/soiAvoL/puqUzDHcjzdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iw5FpPOk; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b390136ed88so250614a12.2;
        Wed, 06 Aug 2025 15:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754519870; x=1755124670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gowrAGAtt/8PGy3ltcInMP14/WjUgpF9Gx6AgOeagC0=;
        b=Iw5FpPOka5QTUybv5E43QSPfaS7IMimUUlem9dgxzw844b1EBqCfed5TCJHxJyI1Aa
         8iMxFzLac4jn9SGBfVG/2nwyGK7W4V20BE7Plri1oRpyERyUGqC5mZMJ+mM2wgPmiffB
         Q+zZyENQn1xXhVRwvjCqAsiC/tdQXhIQJaAHkaCiJdVdenY/v1zufkugU4wPgm962c9S
         b0hty2qh2o3fGVMjQ3kQYSVF/w8f+Dg+Co8lSPXhIvW1fUQ2kpPyChmSTTzXdIOu6Sbd
         uDJ7G6Zpq8esj6sfNXug8e1YUUGRC1NcY2gKTGEs37PTwfQfEdhM7cSiYhBXQTFTQEpS
         e/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754519870; x=1755124670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gowrAGAtt/8PGy3ltcInMP14/WjUgpF9Gx6AgOeagC0=;
        b=ZkDgQZoWFR8CHr0a5WRxNYIjhMARJgPCkJW0s64HTvvRFVtHRP3KeLYkzdxsd2/lL6
         ZjIFAWLwcs6MBO8TAAu/Mg2qu0Gks6FNbIQsQlL1ddKkboRZ4j9XXXVUc7+xWBQyCoJW
         5r50eWGaw2EFkINL7+sXRlNJiNuTRgU1+iVCWtxBasM5TLQXE/hA7bNx3G11ggcC4xsK
         gDQ/H3tA37z2z6E4EWN5nH12rOA/bUQYMtJbBLUB85Ri3tStE2IB21iqX1WJzFvTceeO
         YMdJuVDS15eCXIZb1xhOydHLHWsFfZokEzZ1RYi2vAyMZd5AIR8IElP43vN8zOU3V/zu
         oVtA==
X-Forwarded-Encrypted: i=1; AJvYcCUnOiO1kJzEaQR8TOCwTQrKj+gD++zAf9SAO1cEyKeMiOB2awRw7vf2zxbgFda5KghFcRiBNwIZ3m/n@vger.kernel.org, AJvYcCX4ScEaBVtD1HwnJJRvNhjqQBKiR3jMEkxcToj62TT8MZFrIzKUEroSdcjHnkVLnScOFfGyXdA/B890@vger.kernel.org, AJvYcCXtrFBtIuF85rEKFq3ozILQQhz5ib7ckTZTD4tC5f3dSmXh2MUHEFp9Akr9o8pt8c1BkINi0hQCPOTFfvGR@vger.kernel.org
X-Gm-Message-State: AOJu0YxiF/104NsInwl072V5gKoaoW/U5hZxSXVM/107OJaKuUvnIbEL
	XHxu0E4G/0iDVEZQGj2U7iclMluj56TUKNf3dHrImt2eVqJKext1gwT3a084pQ==
X-Gm-Gg: ASbGncsCaPez5RaP7yKiEN14ygugPGoGbr0xteidHCa2mCFYo76nzc5woCP3NBnYh5c
	HiI9wqJmjtRwNUTqkDen+jEveePIpH75+oisv7f+QY4yl+ss1AEt1ppfHKsTm1bsU88EwkFS2d5
	Q5lqEFVTqDouOK76K6sJcmBBlWOTJBHx9DcelATrwEVd2O0/uDIpzJurT93yTSwY7zGbCa8aPN/
	kLTS8SRdKwnMqZIMFQAY6CsQvCTKIz3rbdWpbOWaOgNZGjx5+reuVI7ftnC8TUNG5U/PJWzqcFS
	3nFBzu0zCGK33j59jPMATrPXOUkoU4WuS/RJEdsXg2eK/CknVOYItowJK9qYSVxocnTEa6AwUaX
	W3NTsOoOzlZu8TKVWhgPC1K9/fzDkfCDQkjuP8eti5LQoNmY9Gsd7lU/MPdAB6s5YqRwoSVtt3a
	rUHwaf5KZlepw4FPU=
X-Google-Smtp-Source: AGHT+IGGXIpRu+MQH1UWjvwqaza58EkYTHdYw+0FEeF28d/J6xAbeGY+wjFULLY4bZu8CragxcxhpA==
X-Received: by 2002:a17:903:2a83:b0:240:70d4:85d9 with SMTP id d9443c01a7336-2429edeedc7mr62203175ad.0.1754519869742;
        Wed, 06 Aug 2025 15:37:49 -0700 (PDT)
Received: from CNTWS00427A.itotolink.net (111-242-118-39.dynamic-ip.hinet.net. [111.242.118.39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2426dec66desm86776775ad.54.2025.08.06.15.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 15:37:49 -0700 (PDT)
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
Subject: [PATCH v3 2/2] hwmon: (pmbus/adm1275) add sq24905c support
Date: Thu,  7 Aug 2025 06:37:24 +0800
Message-ID: <20250806223724.1207-3-tomtsai764@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806223724.1207-1-tomtsai764@gmail.com>
References: <20250806223724.1207-1-tomtsai764@gmail.com>
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


