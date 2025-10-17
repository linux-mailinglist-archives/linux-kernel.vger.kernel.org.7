Return-Path: <linux-kernel+bounces-857907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC02BBE8333
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67A9256735C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6BF32A3F0;
	Fri, 17 Oct 2025 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3Cw8mVR"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD24328B7C
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698702; cv=none; b=M0Z10qHal4R4V7aTD+AAuWlTxGEgmQZDqX2upDKalOyxjMEPodSccTBsyb+ndwR3O/9xLWA8XlJIm2tQ4B+IJ4tXszWdWR8mEykJn1KzTa/AI1WzKlwMZO14lnGyuFcQNOOklHOUzBqF7g0SNWi2eR2ook5kDCsT1v91jRmVGHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698702; c=relaxed/simple;
	bh=tw9pTix3d1V1bsV3ujopDEE5hvHEYt1zdC0Fjq1WzGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpFmGYEY4OjmzH5KJ3jApOM78I08F5oxJOllP/CKKjxCEomlt7KtyP2HC81OHm83vj1zXIqLEuZ/W6/6Ikb18WTpjWRjAcTCCZfVbo42yrAw0BUkDZLFJuj4lAYGuevzXmzFIJQcRL8xTVNObc5IxMCk2r8OwdvB2u5ysQXzv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3Cw8mVR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7811a02316bso1293731b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760698700; x=1761303500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoxrwebuRtbV5iuPvdBx4dtYOpi1yijSJyJyqpAbgnI=;
        b=H3Cw8mVRINoG8v7NejRpcv7JrxfSUTVD4JsD6sVixiPL/bNKJeuygiZra4AeIF24vr
         qAK+Z5Nr+mHqidStuP7FiMLMnbJ2R0QFF8TJeFwrVQf6wrCptoHSA6rGiWKH0mFRJlKT
         1xOTu60d+vmwxq3RT1UTPEGtVdEAdLpwHmLu8Mr/L0LGAy3VmzFybTlnA5GiiTuKaJ2+
         nMZUs3e5wXroZQgqd9YgR03w2kugRjekSaC6s/j1/9wMiIiwIPSLl5RI+dDqx0bCmnh/
         wTzNR0V6cTMYIknzpCJqDtcFJjxxHLOnCFv5gTf/QQWJIspsObB/0h26t83TWFtmD+Vh
         3Miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698700; x=1761303500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoxrwebuRtbV5iuPvdBx4dtYOpi1yijSJyJyqpAbgnI=;
        b=bZF9xbCvo1RdTw/j3U/gyw7PQfMELi9JhqK6xN3U755ZdGNgjQKw5iQnMu/N06WBxW
         fHFjV7oWP1Y4xMfzHfa6irANktysvvF7wGvWOMGNzB7AUih+RlB5NSLvn9o8fVehhoyN
         053Yv5lw3CNgZFr0xP8iyDfj+NqnFlfGBXfyYPma/MXC6LrrWxBRMxjMjczePiAke9b4
         lnEXfJY+FLT2IBF716P2ShOIjfjkEqaVMWUGYjg3uekkJsl4z4jiqnIOLKc3TwVlfEwF
         UsWYM41XdPoSDmRql+uIZMGaq0OjH+9YpraqUwEZ3SewioEzQzIO2RekeZCZKjw48uBk
         5YQw==
X-Forwarded-Encrypted: i=1; AJvYcCUg3lTft09QzRc8yBu/vrBYQXZsKppZDuXL4MEhK9Ld34RpPgSUB55/vpkKa7NhlNeTr5ZbEcK1erHyHd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNT7c9Zmm9d/mCtpOc0EoMmjEr9jCG90u/XAhazjRfPGAYMCSo
	CFjnEY7/+lPjMBhm1P5XoF3gS2560Ahh8IgXtP+pUUP36KCuIwyBSGPD
X-Gm-Gg: ASbGnctBnxAN7oQGCGFhtbeIavtLWGqDi0lvIIsZFsE0YEmzarYH8cYlbDvJcj3REho
	8X+ISHX0cV0yZyl/cCphqK2Iv8QadWad6gStixtvNVoORV6b2alolDkKk/Ms0e11nW+eKgKa2ty
	1o8JRK0bDXXzmN93vX9dCCXWdzvEbyj881OkE1cRCW2mFiC8jdSiJVXHPiVdDuwdkP6OuTAY6x2
	5d3u5Vm0CYNDTH4yBBb6dwVvEeX2fra6bxViV7/XzRWj2bAzhrXyq2lvx6merHLWbP9E4YKiyVn
	FAfDwm8QulM/y19rm5XrT/b7VUnyDVXJTT5ZsusjSc8Xt8lWtECXbJXlzs0qa9+5fpltodrHH58
	ulEI7fJuYG0Nb5df1fR40z4iVwGGEj8jSMjkRB2wYD/i9zomU2CJURbNW206Ab1v/n0CL/nV9hU
	IyqbnN1A==
X-Google-Smtp-Source: AGHT+IEj3vGbUVsnkPQBakLSq8SjTpQWMQ8Z5wX7tiQgU72nmya/V+4HJToJ0DxbrIxKiBMLHXGDlA==
X-Received: by 2002:a05:6a20:2451:b0:334:969f:fafb with SMTP id adf61e73a8af0-334a8630437mr4202657637.59.1760698700289;
        Fri, 17 Oct 2025 03:58:20 -0700 (PDT)
Received: from tixy.nay.do ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cc8sm25407571b3a.20.2025.10.17.03.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 03:58:20 -0700 (PDT)
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
Subject: [PATCH 1/3] docs/hwmon: Fix broken maxim-ic.com links to analog.com
Date: Fri, 17 Oct 2025 16:27:16 +0530
Message-ID: <20251017105740.17646-2-spyjetfayed@gmail.com>
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

Broken redirects fixed to their proper analog.com links.
Fixes warnings in 'make linkcheckdocs'.

Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
---
 Documentation/hwmon/jc42.rst     |  6 +++---
 Documentation/hwmon/max16064.rst |  2 +-
 Documentation/hwmon/max16065.rst | 16 ++++++++--------
 Documentation/hwmon/max1619.rst  |  4 ++--
 Documentation/hwmon/max31790.rst |  4 +++-
 Documentation/hwmon/max6650.rst  |  8 ++++++--
 Documentation/hwmon/max8688.rst  |  4 +++-
 7 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/Documentation/hwmon/jc42.rst b/Documentation/hwmon/jc42.rst
index 19d10512f6c0..df47a5d265cc 100644
--- a/Documentation/hwmon/jc42.rst
+++ b/Documentation/hwmon/jc42.rst
@@ -5,7 +5,7 @@ Supported chips:
 
   * Analog Devices ADT7408
 
-    Datasheets:
+    Datasheet: Publicly available at the Analog Devices website
 
 	https://www.analog.com/static/imported-files/data_sheets/ADT7408.pdf
 
@@ -31,9 +31,9 @@ Supported chips:
 
   * Maxim MAX6604
 
-    Datasheets:
+    Datasheet: Publicly available at the Analog Devices website
 
-	http://datasheets.maxim-ic.com/en/ds/MAX6604.pdf
+	https://www.analog.com/media/en/technical-documentation/data-sheets/MAX6604.pdf
 
   * Microchip MCP9804, MCP9805, MCP9808, MCP98242, MCP98243, MCP98244, MCP9843
 
diff --git a/Documentation/hwmon/max16064.rst b/Documentation/hwmon/max16064.rst
index c06249292557..2a8a76d7b230 100644
--- a/Documentation/hwmon/max16064.rst
+++ b/Documentation/hwmon/max16064.rst
@@ -9,7 +9,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX16064.pdf
+    Datasheet: https://www.digikey.com/en/htmldatasheets/production/701833/0/0/1/max16064
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
diff --git a/Documentation/hwmon/max16065.rst b/Documentation/hwmon/max16065.rst
index 45f69f334f25..0526e961a03c 100644
--- a/Documentation/hwmon/max16065.rst
+++ b/Documentation/hwmon/max16065.rst
@@ -10,9 +10,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet:
+    Datasheet: Publicly available at the Analog Devices website
 
-	http://datasheets.maxim-ic.com/en/ds/MAX16065-MAX16066.pdf
+	      https://www.analog.com/media/en/technical-documentation/data-sheets/max16065-max16066.pdf
 
  *  Maxim MAX16067
 
@@ -20,9 +20,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet:
+    Datasheet: Publicly available at the Analog Devices website
 
-	http://datasheets.maxim-ic.com/en/ds/MAX16067.pdf
+	      https://www.analog.com/media/en/technical-documentation/data-sheets/max16067.pdf
 
  *  Maxim MAX16068
 
@@ -30,9 +30,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet:
+    Datasheet: Publicly available at the Analog Devices website
 
-	http://datasheets.maxim-ic.com/en/ds/MAX16068.pdf
+	      https://www.analog.com/media/en/technical-documentation/data-sheets/max16068.pdf
 
  *  Maxim MAX16070/MAX16071
 
@@ -40,9 +40,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet:
+    Datasheet: Publicly available at the Analog Devices website
 
-	http://datasheets.maxim-ic.com/en/ds/MAX16070-MAX16071.pdf
+	      https://www.analog.com/media/en/technical-documentation/data-sheets/max16070-max16071.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
diff --git a/Documentation/hwmon/max1619.rst b/Documentation/hwmon/max1619.rst
index b5fc175ae18d..a9523ca8c42f 100644
--- a/Documentation/hwmon/max1619.rst
+++ b/Documentation/hwmon/max1619.rst
@@ -9,9 +9,9 @@ Supported chips:
 
     Addresses scanned: I2C 0x18-0x1a, 0x29-0x2b, 0x4c-0x4e
 
-    Datasheet: Publicly available at the Maxim website
+    Datasheet: Publicly available at the Analog Devices website
 
-	       http://pdfserv.maxim-ic.com/en/ds/MAX1619.pdf
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/MAX1619.pdf
 
 Authors:
        - Oleksij Rempel <bug-track@fisher-privat.net>,
diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
index 33c5c7330efc..5f75a55d16a9 100644
--- a/Documentation/hwmon/max31790.rst
+++ b/Documentation/hwmon/max31790.rst
@@ -9,7 +9,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://pdfserv.maximintegrated.com/en/ds/MAX31790.pdf
+    Datasheet: Publicly available at the Maxim website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31790.pdf
 
 Author: Il Han <corone.il.han@gmail.com>
 
diff --git a/Documentation/hwmon/max6650.rst b/Documentation/hwmon/max6650.rst
index 7952b6ecaa2d..4718ce47b770 100644
--- a/Documentation/hwmon/max6650.rst
+++ b/Documentation/hwmon/max6650.rst
@@ -9,7 +9,9 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf
+    Datasheet: Publicly available at the Maxim website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/MAX6650-MAX6651.pdf
 
   * Maxim MAX6651
 
@@ -17,7 +19,9 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf
+    Datasheet: Publicly available at the Maxim website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/MAX6650-MAX6651.pdf
 
 Authors:
     - Hans J. Koch <hjk@hansjkoch.de>
diff --git a/Documentation/hwmon/max8688.rst b/Documentation/hwmon/max8688.rst
index 71e7f2cbe2e2..071689a8fa3b 100644
--- a/Documentation/hwmon/max8688.rst
+++ b/Documentation/hwmon/max8688.rst
@@ -9,7 +9,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX8688.pdf
+    Datasheet: Publicly available at the Maxim website
+
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/max8688.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
-- 
2.51.0


