Return-Path: <linux-kernel+bounces-755155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD4DB1A245
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C0A167A5A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F2926CE13;
	Mon,  4 Aug 2025 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIy8G44m"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BFC25EFB6;
	Mon,  4 Aug 2025 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311727; cv=none; b=sENJAOOXQo9uUJcXF8H1jI5B8xOf0QewlxN1+68Y5QQ1rnVLcHoCauuxVN+Lp46Nyf52J5DVLJDAqBzBTv7UkZhOvuCzkJIkCo8EIAnmLOku+Bc9/PNy+jAiyTnlwGlRBpMc1zPIh2IDgRQk2TK8A40vSkavwFGmmcwOMoYUIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311727; c=relaxed/simple;
	bh=HQST0UcmeoSbLX09rdBtA7BoTardCxQNoeKS11z/UO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smFONSE70hyx19+hYAxUN2MxV3XPdJiQaI5JcDKvW2wkHxxYcNG8uCOrMhJ3QjpEVr3j/g30MSyKEO/0Nc7HPhZYfURTSwsWcpnWrtO1fQfnv+LFkvtV1Gz93JgRkLSGKGRz+Cm3SAlyhRMe56hBCtc0Xuo4LVvyaW7bSFysVR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIy8G44m; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76bed310fa1so1388155b3a.2;
        Mon, 04 Aug 2025 05:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754311724; x=1754916524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIBGM5j540pkjTnXoxn5StmD3XtzjfbLiBm0ToBFC5Y=;
        b=bIy8G44m9P2bekGT9L/WbdkiwJmCrmhzmCac0xBkYwDrWbljCHMfoKLdr5/zLNKmsT
         o7v+tjkqka/ngLHPYHxLAjQTvjM3jnkbbq1tX+4mEF5IpVU0+OSxBuwCzzkxNcxsQEoj
         lvJBACyWp5efnUt6Pbb4AO/9m2ZWhJaJr9jKXq5TN1Lz0ZevY1yMeq39e5OOgsEbm1N8
         IkXA7M35zgv4KTVtpKA3JP7IaJTj2U/gibaDBGHgWPDmP38jE5bCXx4lmQbuLuhlRhbK
         eaH6kUYGypMI6Lcj74yZVGsyVlXSouVhjE04FEqs/J4m5ELRWvfvTcK9rgsOpfWksGZv
         I3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311724; x=1754916524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIBGM5j540pkjTnXoxn5StmD3XtzjfbLiBm0ToBFC5Y=;
        b=OixdEAMaqjKB70GtmjnIYY62r5OSetVVuQ3sOpKtmyOiNutTP0GXBFnhlZ9UQrfXCp
         XwOY5EtStwKFmrn1nSpG7U5qPLYHajgdMLn0+DzpstXBotX3IQEv3aE8Ma4KvZGMfSej
         J2bmxsj0SpX9EH1ZAncB1t/YvsgTBkP6507x8jLO0AikHcpD+KbxXcFe3LJnyJfnIBYn
         SR2lwiD1GmwmJgixZXu27Ka0GJBwLtVB7hqwR7/W0spBMOK0EU/COmcHA+LCNkCV9Fk5
         uJj/Q/s2DaCg2DGrEDRXEL6s7mBkeJCT/xmC+rnm7hXj3RWwvLK6jZINgpMd9JweEePC
         jc8g==
X-Forwarded-Encrypted: i=1; AJvYcCUe6gGJYtNiaPftaa0cH63seEn6pvQlcEnPRrqEi40aNYO4YV74rD2l4qFd+1gCHXJKoaXjVknPOvsWD18X@vger.kernel.org, AJvYcCW7fkKr/TszFAuNo38BjQ8Hz4i81thDVOQ7qzkv6aBsnJfw1SffqVnebZ1YDDxjEthHOSkvCDrgjsGE@vger.kernel.org, AJvYcCXhV+kdqlOn5gzbeG/GtZu+3aC4N77OQ7/iED7C5LaTqckK8FBoBpYMc1LuEuhq6IJHwa9N+45F6ZdZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxxhJ29MLTE2BkIGXZ3JFXZhF7us7oDbcKBuHFaCW9piaxgHbHk
	BxPfsVLITOJccbqQSaggGo3i7iDJGLgCLfJfvT4C1DGV1hf+cJ3rusDApnDnRw==
X-Gm-Gg: ASbGncv9PxDdxzSKEcI6Nx7/RvdLKOGyq7TQKY8dHZAFWKni/ofIwcjkM7y8ZJiWwcu
	tGeTKJnfBcUuSY4XThJXNMWxWVBICHFyjfzOtaRlJWiqthuZfneWCFxela8FVULF0W0VId80n67
	6TZaaRRThhPezMBub/cio+tBW26dUSmhDI/jJEggoBkKx5BW5SH0/0Vunwpd4PbEKfxsQCzL7PP
	JAgJA1Kgek9fa2AOwR9uU9e/T+bNyKaroRCFI1M2eQ9+dzE17jQx2tUzP/ZLdEP3cX8kNMBqN3V
	f2JrbG/S57jHQXxiFOCAClOEdOoIP7ywHMc4ueiVzn3LUWk3bkPO+PJyVZs1ummTP7PpM47HQFH
	gpnZp97cYb9vsK0mtNBIqoNrgi0LUnWbKe0C00sN9ZqGjBtii4Qp1dOEmbJNToHz5sToEFmZjrC
	QnaUUJOsImrYEIrZ8Uqw==
X-Google-Smtp-Source: AGHT+IFEEPKGBvrtG+KbJqpUmOCnHYA9fNNJXPGv1hSZUYIIJNQr30urUixDdW1ihbT/cJfGduOx9A==
X-Received: by 2002:a05:6a00:a95:b0:76b:a439:be4a with SMTP id d2e1a72fcca58-76bec48b2b6mr12438355b3a.12.1754311723828;
        Mon, 04 Aug 2025 05:48:43 -0700 (PDT)
Received: from CNTWS00427A.itotolink.net (111-242-101-165.dynamic-ip.hinet.net. [111.242.101.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd656sm10566612b3a.72.2025.08.04.05.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:48:43 -0700 (PDT)
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
Subject: [PATCH 2/2] hwmon: (pmbus/adm1275) add sq24905c support
Date: Mon,  4 Aug 2025 20:48:05 +0800
Message-ID: <20250804124806.540-3-tomtsai764@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804124806.540-1-tomtsai764@gmail.com>
References: <20250804124806.540-1-tomtsai764@gmail.com>
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
 drivers/hwmon/pmbus/Kconfig     |  5 +++--
 drivers/hwmon/pmbus/adm1275.c   | 27 +++++++++++++++++++--------
 3 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/Documentation/hwmon/adm1275.rst b/Documentation/hwmon/adm1275.rst
index 57bd7a850558..914f009f34e0 100644
--- a/Documentation/hwmon/adm1275.rst
+++ b/Documentation/hwmon/adm1275.rst
@@ -67,6 +67,14 @@ Supported chips:
 
     Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1293_1294.pdf
 
+  * Silergy SQ24905C
+
+    Prefix: 'sq24905c'
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
index 55e492452ce8..7485bc6b2e8a 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -51,8 +51,9 @@ config SENSORS_ADM1275
 	tristate "Analog Devices ADM1275 and compatibles"
 	help
 	  If you say yes here you get hardware monitoring support for Analog
-	  Devices ADM1075, ADM1272, ADM1273, ADM1275, ADM1276, ADM1278, ADM1281,
-	  ADM1293, and ADM1294 Hot-Swap Controller and Digital Power Monitors.
+	  Devices ADM1075, ADM1272, ADM1273, ADM1275, ADM1276, ADM1278,
+	  ADM1281, ADM1293, ADM1294 and SQ24905C Hot-Swap Controller and
+	  Digital Power Monitors.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called adm1275.
diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 7d175baa5de2..1c032aaac379 100644
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
+	{ "MC09C", sq24905c },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adm1275_id);
@@ -533,8 +535,10 @@ static int adm1275_probe(struct i2c_client *client)
 		return ret;
 	}
 	if (ret != 3 || strncmp(block_buffer, "ADI", 3)) {
-		dev_err(&client->dev, "Unsupported Manufacturer ID\n");
-		return -ENODEV;
+		if (ret != 2 || strncmp(block_buffer, "SY", 2)) {
+			dev_err(&client->dev, "Unsupported Manufacturer ID\n");
+			return -ENODEV;
+		}
 	}
 
 	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, block_buffer);
@@ -558,7 +562,8 @@ static int adm1275_probe(struct i2c_client *client)
 
 	if (mid->driver_data == adm1272 || mid->driver_data == adm1273 ||
 	    mid->driver_data == adm1278 || mid->driver_data == adm1281 ||
-	    mid->driver_data == adm1293 || mid->driver_data == adm1294)
+	    mid->driver_data == adm1293 || mid->driver_data == adm1294 ||
+	    mid->driver_data == sq24905c)
 		config_read_fn = i2c_smbus_read_word_data;
 	else
 		config_read_fn = i2c_smbus_read_byte_data;
@@ -708,6 +713,7 @@ static int adm1275_probe(struct i2c_client *client)
 		break;
 	case adm1278:
 	case adm1281:
+	case sq24905c:
 		data->have_vout = true;
 		data->have_pin_max = true;
 		data->have_temp_max = true;
@@ -786,9 +792,12 @@ static int adm1275_probe(struct i2c_client *client)
 		return -ENODEV;
 	}
 
-	if (data->have_power_sampling &&
+	if ((data->have_power_sampling &&
 	    of_property_read_u32(client->dev.of_node,
-				 "adi,power-sample-average", &avg) == 0) {
+				 "adi,power-sample-average", &avg) == 0) ||
+	    (data->have_power_sampling &&
+	    of_property_read_u32(client->dev.of_node,
+				 "silergy,power-sample-average", &avg) == 0)) {
 		if (!avg || avg > ADM1275_SAMPLES_AVG_MAX ||
 		    BIT(__fls(avg)) != avg) {
 			dev_err(&client->dev,
@@ -804,8 +813,10 @@ static int adm1275_probe(struct i2c_client *client)
 		}
 	}
 
-	if (of_property_read_u32(client->dev.of_node,
-				"adi,volt-curr-sample-average", &avg) == 0) {
+	if ((of_property_read_u32(client->dev.of_node,
+				"adi,volt-curr-sample-average", &avg) == 0) ||
+	    (of_property_read_u32(client->dev.of_node,
+				"silergy,volt-curr-sample-average", &avg) == 0)) {
 		if (!avg || avg > ADM1275_SAMPLES_AVG_MAX ||
 		    BIT(__fls(avg)) != avg) {
 			dev_err(&client->dev,
-- 
2.43.0


