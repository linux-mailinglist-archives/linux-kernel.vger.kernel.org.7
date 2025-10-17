Return-Path: <linux-kernel+bounces-857910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01712BE83DE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9DF740750
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2765F329C53;
	Fri, 17 Oct 2025 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE1rvhMh"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649AB32B995
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698715; cv=none; b=ESfzdw2SO0npsuPkcxevYSls/CZ/WO2n5QRgQMP/tSdIJ6ejQMXgJARiuR5H0B+bCu8MXBibbHyYP7BiH2zYw0aIiSWjiYBSxQCvMxQGshSp/4IQGleUvonzxF14fbIOazQegK/Z9y+/sjAk1nObNX45EGLTkUe8j82rs7DfUig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698715; c=relaxed/simple;
	bh=TGNmouYc6kJWnmdz41HUSOws0rzTBKtG2sTqlItIOno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFXwFHB3Fm06AnhN3Z6TY5GBGPLF6x9iZoxmQqPsk3RWHpXtNGaTXgOz2ZIVSSvf2Q0yMpg1GdVJryrGmnKRgrKpPtP9OzE6Ox8VuwCDsWO3fzbkE8zpdBYqTcTVrbq0CeCaYlu2EtiuevSHnRcHqLCIAtFM9Af4EnLj5mwDPcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VE1rvhMh; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7835321bc98so1729825b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760698711; x=1761303511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcQxmQiwhTRDKIQ07xZS0XyTkiyUkEGo8GNfS/IDb2g=;
        b=VE1rvhMhv7ZWSJvApSp+LmvRug/0A+IMTSiSn/7f2DBG5gs3pjccrJHDZjStyflsvJ
         yF9Ee20K8UI4c90s4sopphzZ+a4t+4E3uHN7eUQJQJm+IF6aOSud3xLtyAHs8UZxxk+E
         aCU7dGVcRcP7uO5+0W5yVHNLxLf9zp49Dxeec+PNg7ir/6W1Y1sruV+D8zIJmMZaHrfd
         o/821HdzSAgrI48rC9aMcTu8Rn93SAT74royrmIqnacV4tFTBUfd9GWbKohbEVM+cf/5
         XryA1LFOaAKkWnIIppUf7VPeuMKeBIkkdaBsSSugtDC03msTemYuVylWDPc10cYo608A
         T1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698711; x=1761303511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcQxmQiwhTRDKIQ07xZS0XyTkiyUkEGo8GNfS/IDb2g=;
        b=FYsQiXQptc0LRrBjPzepPf2qVp3TDIhd6Bq4DHKyqubgRuTPOlttjeVKGxIwB8v5/L
         ZK+wO+M1nbuso1yngvm0lDXG56nu260PTI/nBsk5ReVrJF7QfOFo4JFyBFz7vc1T8vQT
         CqJ0KOg5r+gnNau8QusXZ/LlXrQ6k6LegtZtAes1SIUFnlhPUbjLszc788nQX6y2XO7/
         ctsW7lvWqnsxNqGN5sMaQro/1xP/ASOPLtNgfU/xJM95mEVYicv2ERYzJHBXlzqXGVtj
         bI5ggfHcOSTKuUwDmd4Lx+6cpG8MwY41LPoqDy3+6Ptbh0xd2ke05OnhOyUsSc11ZyaY
         FYog==
X-Forwarded-Encrypted: i=1; AJvYcCXpKW2EILH1Dq/lzpqhpcnCGGwYSN9OB6m7+5eKWLZ5rS4wv3sDLCHxjTGCuBQ+G0MWNeZc98dG42GOn7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWGjl0NgS5YXigyOXUGlSzET/UgJ32FrGSSKwceLGpHoIAHxF2
	FVbg18bK0Bd9S+kz640OlbpfKqwQjA+MdeaNgBRGZRMwI2DmI7tpIgQ9
X-Gm-Gg: ASbGncuXWOl94q4UwPzrrN9OrAPODUmuezRQWkhn69pG+PtGKWKk/7lp/WVdcx6cP+R
	HMaTU6UR/RZvO23/xX9TOBx8JCmOEQ64dCAAeFNAF5ZiMHhLN96z5/BM3CCiQTLC3BlwVm1vFna
	NuUxB/HZh8GYdW7agBsgo/gu2mLVb+CKAon/FZVVIQWRITPjBw2+6rCq86lJK55fDsuMljm5R9O
	2+Z5zc21u1SMtBg6mB4Y4JxsFxyUCS5sC6Z3f8DPbVZ1AfbaEwKv/NmqRzgixR6zGr+BNsmAZFr
	2jgE10MEdhpsHBmZxnCF5OV3fKoVJzM1q8oBI+XHhE8m5UKzJG7YVFbpf5DBlpLX5708+C1DmB5
	La8ok3ImUeTqbRQYTsIwgWXwQ1FlmKpPwknHxo1Z9rX9IpBqnuXo87YIu8DSu+bimTgV09sCCbh
	+gMmvPmg==
X-Google-Smtp-Source: AGHT+IGZbS/al5pfP6ZFP3Y4YJCX9ArTkNG4bvjw2RnO7QdoN87bvhipE1jMqEo31zsqvDApgk5XXw==
X-Received: by 2002:a05:6a00:2356:b0:781:2320:5a33 with SMTP id d2e1a72fcca58-7a220a82808mr3675550b3a.9.1760698711438;
        Fri, 17 Oct 2025 03:58:31 -0700 (PDT)
Received: from tixy.nay.do ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cc8sm25407571b3a.20.2025.10.17.03.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:58:31 -0700 (PDT)
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
Subject: [PATCH 3/3] docs/hwmon: Update maxim-ic.com links to analog.com
Date: Fri, 17 Oct 2025 16:27:18 +0530
Message-ID: <20251017105740.17646-4-spyjetfayed@gmail.com>
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

Update maxim-ic.com & maximintegrated.com links to analog.com links.

Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
---
 Documentation/hwmon/max127.rst   |  4 +++-
 Documentation/hwmon/max16601.rst |  4 +++-
 Documentation/hwmon/max1668.rst  |  4 +++-
 Documentation/hwmon/max197.rst   |  8 +++++--
 Documentation/hwmon/max20730.rst | 16 +++++++++----
 Documentation/hwmon/max31722.rst |  8 +++++--
 Documentation/hwmon/max31730.rst |  4 +++-
 Documentation/hwmon/max31785.rst |  4 +++-
 Documentation/hwmon/max34440.rst | 24 ++++++++++++++-----
 Documentation/hwmon/max6620.rst  |  4 +++-
 Documentation/hwmon/max6639.rst  |  4 +++-
 Documentation/hwmon/max6697.rst  | 40 ++++++++++++++++++++++++--------
 12 files changed, 93 insertions(+), 31 deletions(-)

diff --git a/Documentation/hwmon/max127.rst b/Documentation/hwmon/max127.rst
index dc192dd9c37c..5ff2f64f9daa 100644
--- a/Documentation/hwmon/max127.rst
+++ b/Documentation/hwmon/max127.rst
@@ -13,7 +13,9 @@ Supported chips:
 
     Prefix: 'max127'
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX127-MAX128.pdf
+    Datasheet: Publicly available at the Maxim website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max127-max128.pdf
 
 Description
 -----------
diff --git a/Documentation/hwmon/max16601.rst b/Documentation/hwmon/max16601.rst
index c8c63a053e40..b4deb12325b1 100644
--- a/Documentation/hwmon/max16601.rst
+++ b/Documentation/hwmon/max16601.rst
@@ -35,7 +35,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX16602.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	    https://www.analog.com/media/en/technical-documentation/data-sheets/max16602.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
diff --git a/Documentation/hwmon/max1668.rst b/Documentation/hwmon/max1668.rst
index 417f17d750e6..0f741e9ce0a5 100644
--- a/Documentation/hwmon/max1668.rst
+++ b/Documentation/hwmon/max1668.rst
@@ -9,7 +9,9 @@ Supported chips:
 
     Addresses scanned: I2C 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e
 
-    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX1668-MAX1989.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/MAX1668-MAX1989.pdf
 
 Author:
 
diff --git a/Documentation/hwmon/max197.rst b/Documentation/hwmon/max197.rst
index 02fe19bc3428..04413f4699dd 100644
--- a/Documentation/hwmon/max197.rst
+++ b/Documentation/hwmon/max197.rst
@@ -11,13 +11,17 @@ Supported chips:
 
     Prefix: 'max197'
 
-    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX197.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/MAX197.pdf
 
   * Maxim MAX199
 
     Prefix: 'max199'
 
-    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX199.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/MAX199.pdf
 
 Description
 -----------
diff --git a/Documentation/hwmon/max20730.rst b/Documentation/hwmon/max20730.rst
index cb0c95b2b1f6..9ea9d824f280 100644
--- a/Documentation/hwmon/max20730.rst
+++ b/Documentation/hwmon/max20730.rst
@@ -11,7 +11,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX20710.pdf
+    Datasheet: Publicly available at the Maxim website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max20710.pdf
 
   * Maxim MAX20730
 
@@ -19,7 +21,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX20730.pdf
+    Datasheet: Publicly available at the Maxim website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max20730.pdf
 
   * Maxim MAX20734
 
@@ -27,7 +31,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX20734.pdf
+    Datasheet: Publicly available at the Maxim website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max20734.pdf
 
   * Maxim MAX20743
 
@@ -35,7 +41,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX20743.pdf
+    Datasheet: Publicly available at the Maxim website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max20743.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
diff --git a/Documentation/hwmon/max31722.rst b/Documentation/hwmon/max31722.rst
index 0ab15c00b226..b15603c31c3e 100644
--- a/Documentation/hwmon/max31722.rst
+++ b/Documentation/hwmon/max31722.rst
@@ -11,7 +11,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX31722-MAX31723.pdf
+    Datasheet: Publicly available at the Maxim website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max31722-max31723.pdf
 
   * Maxim Integrated MAX31723
 
@@ -21,7 +23,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX31722-MAX31723.pdf
+    Datasheet: Publicly available at the Maxim website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max31722-max31723.pdf
 
 Author: Tiberiu Breana <tiberiu.a.breana@intel.com>
 
diff --git a/Documentation/hwmon/max31730.rst b/Documentation/hwmon/max31730.rst
index def0de19dbd2..b0be18570984 100644
--- a/Documentation/hwmon/max31730.rst
+++ b/Documentation/hwmon/max31730.rst
@@ -9,7 +9,9 @@ Supported chips:
 
     Addresses scanned: 0x1c, 0x1d, 0x1e, 0x1f, 0x4c, 0x4d, 0x4e, 0x4f
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX31730.pdf
+    Datasheet: Publicly available at the Maxim website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max31730.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
diff --git a/Documentation/hwmon/max31785.rst b/Documentation/hwmon/max31785.rst
index c8c6756d0ee1..7fb867bf2c70 100644
--- a/Documentation/hwmon/max31785.rst
+++ b/Documentation/hwmon/max31785.rst
@@ -9,7 +9,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX31785.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max31785.pdf
 
 Author: Andrew Jeffery <andrew@aj.id.au>
 
diff --git a/Documentation/hwmon/max34440.rst b/Documentation/hwmon/max34440.rst
index 8591a7152ce5..d1292dd8f24f 100644
--- a/Documentation/hwmon/max34440.rst
+++ b/Documentation/hwmon/max34440.rst
@@ -17,7 +17,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX34440.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max34440.pdf
 
   * Maxim MAX34441
 
@@ -27,7 +29,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX34441.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max34441.pdf
 
   * Maxim MAX34446
 
@@ -37,7 +41,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX34446.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max34446.pdf
 
   * Maxim MAX34451
 
@@ -47,7 +53,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX34451.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max34451.pdf
 
   * Maxim MAX34460
 
@@ -57,7 +65,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX34460.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max34460.pdf
 
   * Maxim MAX34461
 
@@ -67,7 +77,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX34461.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max34461.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
diff --git a/Documentation/hwmon/max6620.rst b/Documentation/hwmon/max6620.rst
index d70173bf0242..3846a48c5ca6 100644
--- a/Documentation/hwmon/max6620.rst
+++ b/Documentation/hwmon/max6620.rst
@@ -11,7 +11,9 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max6620.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	      https://www.analog.com/media/en/technical-documentation/data-sheets/max6620.pdf
 
 Authors:
     - L\. Grunenberg <contact@lgrunenberg.de>
diff --git a/Documentation/hwmon/max6639.rst b/Documentation/hwmon/max6639.rst
index c85d285a3489..0a275aa36781 100644
--- a/Documentation/hwmon/max6639.rst
+++ b/Documentation/hwmon/max6639.rst
@@ -9,7 +9,9 @@ Supported chips:
 
     Addresses scanned: I2C 0x2c, 0x2e, 0x2f
 
-    Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
+    Datasheet: Publicly available at the Maxim website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max6639-max6639f.pdf
 
 Authors:
     - He Changqing <hechangqing@semptian.com>
diff --git a/Documentation/hwmon/max6697.rst b/Documentation/hwmon/max6697.rst
index 90ca224c446a..fa9cd68aaf85 100644
--- a/Documentation/hwmon/max6697.rst
+++ b/Documentation/hwmon/max6697.rst
@@ -7,61 +7,81 @@ Supported chips:
 
     Prefix: 'max6581'
 
-    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6581.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max6581.pdf
 
   * Maxim MAX6602
 
     Prefix: 'max6602'
 
-    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6602.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max6602.pdf
 
   * Maxim MAX6622
 
     Prefix: 'max6622'
 
-    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6622.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max6622.pdf
 
   * Maxim MAX6636
 
     Prefix: 'max6636'
 
-    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6636.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max6636.pdf
 
   * Maxim MAX6689
 
     Prefix: 'max6689'
 
-    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6689.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max6689.pdf
 
   * Maxim MAX6693
 
     Prefix: 'max6693'
 
-    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6693.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max6693.pdf
 
   * Maxim MAX6694
 
     Prefix: 'max6694'
 
-    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6694.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max6694.pdf
 
   * Maxim MAX6697
 
     Prefix: 'max6697'
 
-    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6697.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max6697.pdf
 
   * Maxim MAX6698
 
     Prefix: 'max6698'
 
-    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6698.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max6698.pdf
 
   * Maxim MAX6699
 
     Prefix: 'max6699'
 
-    Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX6699.pdf
+    Datasheet: Publicly available at the Analog Devices website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max6699.pdf
 
 Author:
 
-- 
2.51.0


