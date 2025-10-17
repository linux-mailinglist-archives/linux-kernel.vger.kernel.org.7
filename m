Return-Path: <linux-kernel+bounces-858397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0687EBEAC11
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BA705A90D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4576429B78E;
	Fri, 17 Oct 2025 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGpiemnP"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCAE29B8E1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717678; cv=none; b=LF8hrRDcdE2xisjrPrpoxfUP158TgnL4Z0HQbQ8ilWs9W23lsV6EGtDXXeVn3jyTSlj1npNiob9Mr8ATAS6pq30kZhfs6tFl5xSBGD8JrtnduehF50Cfp8fwXBg/M+8FMC10I85ao/iE3x039tZurHKX3xUirQ/6XXTgbQgX79g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717678; c=relaxed/simple;
	bh=vDV6ZZW3e3a62EgCSJAFTk+hdmuxcZ7lOW4ecmH7Ok4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ei1g6WexjNOGCGZpzXq14obDVUgqzayT3IWTZbOEb2OkcgpxCJ0wj+SBhRLzUHnK7oYOnMy0yB2B3LxUL8+NnOwkttslRyvcNmcx20AhiBLqmzgbJYrA/Do3VxMLcQ48tWfRqo0QMQtkjd8/O7oC7NIPP6ZEIoMAgP8ru/ux68M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGpiemnP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7811fa91774so1979827b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760717675; x=1761322475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSaJmCc+aYCWqkWYZzGuOsFSxO7z0SExATIE2u9xswo=;
        b=QGpiemnPJmtPS8zV8Z5kDb8+1HEPs5O4jpwlpxbROZqexyR+a53/mvfiYwSVSFwBBN
         69+4dFXFYMMgylqsIRsjZrPPIuTiMcsZ6io8p++Kf+XVlHnzPZuMAPqbBVQPA11KucAa
         cgRqRhqXJ/KJ5f9F2hznkcm/Y1fkIhFK0xUyb82wdCljrPYuSq0zOanY0rCdv2diJAOI
         OkAWGh9ECf9BtzkmdPoUESSWzDtpoV19V8kyT/QFbPATldSSL6obq/TGMYw6HOBOolyf
         VQ0XRqv4Pg7jCLMV3UHjq1SjtTQYZqUC8X3mWgcQ8lcqDb7kdfumMvtHiFYZOdg9UrVw
         cfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717675; x=1761322475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSaJmCc+aYCWqkWYZzGuOsFSxO7z0SExATIE2u9xswo=;
        b=WMT+HtQNz81Ri1UQ0xBMBmmcDBkS1khnT8vXnu4ujNLldvwquHkeisYDKqfqguBtWq
         BUI9d5mhcBvJQg0F7Tq/JvLqnFQRKTBsTgauUiKZSAtwYTTQP/mmcSZXj1v9MwM3fXvW
         8911L82wYlf9suuQDeMqwUqFawPftjCoZQH0b0WeB9qIRKJ1M8Oa3udrVC9JBNBuwPbe
         BxaCVA9aRC5U+NWTEInvTKe9kdWZa/t1IBM6rJHtfQGn4oGXKgU4dvLG19xQISrkA+bC
         44rbzKkYPZJVjUw+OalCbq7crXUSQGO1Kj107RQsPvw6YNvvyuTGF1jEUgtJo5Tgoel3
         KPNw==
X-Forwarded-Encrypted: i=1; AJvYcCXvV49BW+sBndrzDKIzrHOl7lLU6bqOLdEG9n508uO8X7MWSkaGlMX8FiXeORiMHhZ/mCGB3LhaumaNXKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf9nwsDax5G1lTrn8yvOO0By3qx2KH4QPSE+JltjWaAh3CCult
	AjALoTM1qgMDobmvHdGp3ZiK4l/VvC86RuDylKc9ZCAYNx2G2VpuDxY4
X-Gm-Gg: ASbGnct4lePITLXvffuq5XMnKzdnS9+896ca+Mskx0M985npgpdD99RJp/BiSjxTr7+
	GrTl+JLiw39XZZWtBSkaVrxSiNYw/JoFlb1ksmAcR4Rga+V1fiEiDoRzXrBMdaQBEnJN7QJWobl
	W3rOBhadhA6qrx40mCi90V6dWO7RMpNB2bkOZ4bd3VYeabbKKiJW99LHLnOgk5o8/11Y55wxcFE
	ryMEw6bZMLO+L3Qs5bC1Gf9/S8yypRjpshJyAARza3Exa5oUZoqp5y12LiquwBrgXR9Sd+A++JN
	PD6joYtkrcCmbteguIftw4Q4nOe6BQn+dYVPHxrrNY1m7s4DMdcoV0tWMG7z2s0ZSqfIEGQB2dm
	JYP0MTUmMVtiO+HTD7OHu8unJef9nfrSDd/gbqnml7eUnMeGSAzlkojDsOx5ikLUf90fKLlFaUu
	6PqX9O4w==
X-Google-Smtp-Source: AGHT+IG7SDGpXXegR3AcehBNMMWlD6G3CZfZcnP6cVPBuF3R78WHD/XJ7PtHYZOXZMB5pV3wn2ijMA==
X-Received: by 2002:a05:6a00:991:b0:772:114c:bcbb with SMTP id d2e1a72fcca58-7a2206eaba6mr5407788b3a.4.1760717674820;
        Fri, 17 Oct 2025 09:14:34 -0700 (PDT)
Received: from tixy.nay.do ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09d6easm26357411b3a.51.2025.10.17.09.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:14:34 -0700 (PDT)
From: Ankan Biswas <spyjetfayed@gmail.com>
To: linux@roeck-us.net,
	corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Ankan Biswas <spyjetfayed@gmail.com>
Subject: [PATCH v2 2/3] Add missing datasheet links for Maxim chips
Date: Fri, 17 Oct 2025 21:38:05 +0530
Message-ID: <20251017161422.4404-1-spyjetfayed@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017105740.17646-1-spyjetfayed@gmail.com>
References: <20251017105740.17646-1-spyjetfayed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 2021, Maxim Integrated was acquired by Analog Devices.
maxim-ic.com & maximintegrated.com links redirect to analog.com.

Missing datasheets now available at Analog Devices added.

Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
---
Changes in v2:
- removed "Publicly available.."

 Documentation/hwmon/ds1621.rst   | 10 +++++-----
 Documentation/hwmon/lm75.rst     | 13 ++++++++-----
 Documentation/hwmon/max15301.rst |  2 +-
 Documentation/hwmon/max31827.rst |  6 +++---
 Documentation/hwmon/max77705.rst |  4 +++-
 Documentation/hwmon/pmbus.rst    |  2 +-
 6 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/Documentation/hwmon/ds1621.rst b/Documentation/hwmon/ds1621.rst
index 552b37e9dd34..d0808720aa07 100644
--- a/Documentation/hwmon/ds1621.rst
+++ b/Documentation/hwmon/ds1621.rst
@@ -9,7 +9,7 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: Publicly available from www.maximintegrated.com
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/DS1621.pdf
 
   * Dallas Semiconductor DS1625
 
@@ -17,7 +17,7 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: Publicly available from www.datasheetarchive.com
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/DS1620.pdf
 
   * Maxim Integrated DS1631
 
@@ -25,7 +25,7 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: Publicly available from www.maximintegrated.com
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/DS1631-DS1731.pdf
 
   * Maxim Integrated DS1721
 
@@ -33,7 +33,7 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: Publicly available from www.maximintegrated.com
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/DS1721.pdf
 
   * Maxim Integrated DS1731
 
@@ -41,7 +41,7 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: Publicly available from www.maximintegrated.com
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/DS1631-DS1731.pdf
 
 Authors:
       - Christian W. Zuckschwerdt <zany@triq.net>
diff --git a/Documentation/hwmon/lm75.rst b/Documentation/hwmon/lm75.rst
index 908b3a9df06e..4269da04508e 100644
--- a/Documentation/hwmon/lm75.rst
+++ b/Documentation/hwmon/lm75.rst
@@ -23,15 +23,17 @@ Supported chips:
 
 	       http://www.national.com/
 
-  * Dallas Semiconductor (now Maxim) DS75, DS1775, DS7505
+  * Dallas Semiconductor (now Analog Devices) DS75, DS1775, DS7505
 
     Prefixes: 'ds75', 'ds1775', 'ds7505'
 
     Addresses scanned: none
 
-    Datasheet: Publicly available at the Maxim website
+    Datasheets:
 
-	       https://www.maximintegrated.com/
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/DS75.pdf
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/DS1775.pdf
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/DS7505.pdf
 
   * Maxim MAX6625, MAX6626, MAX31725, MAX31726
 
@@ -39,9 +41,10 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: Publicly available at the Maxim website
+    Datasheets:
 
-	       http://www.maxim-ic.com/
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/MAX6625-MAX6626.pdf
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31725-MAX31726.pdf
 
   * Microchip (TelCom) TCN75
 
diff --git a/Documentation/hwmon/max15301.rst b/Documentation/hwmon/max15301.rst
index e2222e98304f..a0a993195cd1 100644
--- a/Documentation/hwmon/max15301.rst
+++ b/Documentation/hwmon/max15301.rst
@@ -11,7 +11,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX15301.pdf
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max15301.pdf
 
   * Maxim MAX15303
 
diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
index 6cc5088b26b7..ddd039529077 100644
--- a/Documentation/hwmon/max31827.rst
+++ b/Documentation/hwmon/max31827.rst
@@ -11,7 +11,7 @@ Supported chips:
 
     Addresses scanned: I2C 0x40 - 0x5f
 
-    Datasheet: Publicly available at the Analog Devices website
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31827-MAX31829.pdf
 
   * Maxim MAX31828
 
@@ -19,7 +19,7 @@ Supported chips:
 
     Addresses scanned: I2C 0x40 - 0x5f
 
-    Datasheet: Publicly available at the Analog Devices website
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31827-MAX31829.pdf
 
   * Maxim MAX31829
 
@@ -27,7 +27,7 @@ Supported chips:
 
     Addresses scanned: I2C 0x40 - 0x5f
 
-    Datasheet: Publicly available at the Analog Devices website
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31827-MAX31829.pdf
 
 
 Authors:
diff --git a/Documentation/hwmon/max77705.rst b/Documentation/hwmon/max77705.rst
index 4a7680a340e1..5202de614647 100644
--- a/Documentation/hwmon/max77705.rst
+++ b/Documentation/hwmon/max77705.rst
@@ -11,7 +11,9 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: Not available
+    Datasheet:
+
+	    https://www.analog.com/media/en/technical-documentation/data-sheets/max77505.pdf
 
 Authors:
       - Dzmitry Sankouski <dsankouski@gmail.com>
diff --git a/Documentation/hwmon/pmbus.rst b/Documentation/hwmon/pmbus.rst
index d477124cf67f..a8e01a5b96da 100644
--- a/Documentation/hwmon/pmbus.rst
+++ b/Documentation/hwmon/pmbus.rst
@@ -74,7 +74,7 @@ Supported chips:
 
     Datasheet:
 
-	Not published
+	https://www.analog.com/media/en/technical-documentation/data-sheets/MAX20796.pdf
 
   * Generic PMBus devices
 
-- 
2.51.0


