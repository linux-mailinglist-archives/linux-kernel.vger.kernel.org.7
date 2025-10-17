Return-Path: <linux-kernel+bounces-858341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE2FBEA54A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9F9058662E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077203277A9;
	Fri, 17 Oct 2025 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0THCF8c"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668A420C00A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716090; cv=none; b=SIBCS9pavrdS7487jhEMzbOGhsp7epQV7EuZny6rVg12i75t+Fw8Ga+MOWntQtCZl5Wwyn+gIEcHDjd1teweciL7bVArmtUtHLbaXf8C9aoHTPtvioP3ZP+5yTU3p7wozToclnbuGPbnck97fUHC4hzggP9BHLszQNXqWOCvj94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716090; c=relaxed/simple;
	bh=K8DFRb0Ztia+qrCcoflV/ZeZ7NwFvRkhWlev7x/h/Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txU00zGkrtrXK5WJpVCnwan81oYxMHaBxwzxyFX2rljI4bol2Dcr3sB2Yusyj1tqBVBZeFLJpx7QUjjLlP/0RfF9btc+d0va919qMAN4IqnqK/7RU5eMoaZfTfY9MJxU/rkLY9r1hFlZRg5ENXxfTfMxCsGHpzlOpkexyliGZBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0THCF8c; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27c369f898fso28982145ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760716088; x=1761320888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA8hB+fKoSI0C5+4jjJikVSM6fs77YDr0e+WwSrJDj0=;
        b=E0THCF8caNqRdYLPUA5m/gGEVUXfd85xuh9tMyeLuHMBLlh/vIhKx7iT2iAagP+h/P
         t3pekaAJJ9UJ95zlmdY6DKuzIOAfctyBPLD2H3+T3m1kiPPB1L6+sC0s3Bv4eFS4Orvi
         tIgyQHO6D4f1JUY3dCFwuIxPBRDbgE0vp2YYfjgEc7qVW5wFa2J9SjW6mkrd3twLvgaX
         vqSGtBYOqTcioS9UAkghJ87P+/h0f5EbNHbLYag8RhhbDHhMtQbsWArDy3n326QIuaSv
         NBUZ+UIWyb1NoNh4o4cXtZ/dK9vpGRabSQJY0btB9Ot/PXNcvStbjxrm+9Wr36Ko5kjs
         cNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760716088; x=1761320888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA8hB+fKoSI0C5+4jjJikVSM6fs77YDr0e+WwSrJDj0=;
        b=ho1+hTynlz2FVrfahtKNQrs7kJ03R/Cf4lKN5S6pmavxij7XqNAPHIcNIsF6N1dRJI
         pGAgu1ISj578WRFRkz1VIvLvyQrLHsJEE3GdolX7J7vjnG3rKpMYBFviwSS8xUuJGNqq
         VCuRT/ty85d+9WJHAtBVsVYWEMNnsTkZEO9+6G4fTlPzqGck2WAIOvtXxumWR+KCmoAM
         YsOLRVIWORsI2hMIvTJgjc5W1/VLsDFSM9bykEBqC38uk88TyKjCVGQl+ueCvP9MKGrV
         Iytefgy5iZrLal+ZcYmVzCGz7afVT8Z9Dc7eAa6B9KtB5FHbualccyetdCRcA1tIQC0D
         Bpgw==
X-Forwarded-Encrypted: i=1; AJvYcCWieMlsbn6c4GyE4XK5/+J4cNcdTIe3dveSOZ4lWKWRmk0akNc9C3+oLwdCDk26EtRiz35Rsmsb58niJyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyMLXlAq8ZpsqLukSYzAjLOZ6P9P188xQcei+K7NgrnU4CDBd0
	ygICYb9fk7vbZcjhfutDJmzdYA+WN1RkJPEd9By8ND20umc9Rj09PHpi
X-Gm-Gg: ASbGnctUZfwE6MqwWfg+lRyqS1uetVo+asTb6v+URa2XWuIAohm16R5lsbBtrRagobO
	ZWV0fzb0SgaJz+/FWDh099euzumOZ02IM3eLGX5M4t2Iae/DpCXoxcNFGbPZl1CdK3taVesI3H3
	qjieWC5ZauX9K+fRlaBII8TlCSZBQPQepmZAnjTJAxKQQVbu6Q8xdkip01TI+Eh+zbc3e25V8do
	wzYZNfNLcHNYuP1KklpiMoeX1B/s0+aNo7VWuXiCMA9n5tDyCmnzsM8gcqEljA+sgbserZUFnZ/
	t0iQDZZaM9fv7980Kd6o99pmIvn7ZB8JxutBw5DvrZaw6XVRxvk0Kj7eKySEUeMv1hfsmAiaBLP
	QjIO6rwqbDtRdXelySw9kM9uaXGpg2mybFJVwRGgzhwHAzLegfUoRrGFfK0ruK6aOBoCWd0vCXq
	ZpV7AvJf+NxtF7D0L1
X-Google-Smtp-Source: AGHT+IEbaVBUhL2FBwern7+zHOit6xgEgtPgDccPkqcCVLqGnNEkHex6DpAOpZKc6wJEB6vGZjGEkQ==
X-Received: by 2002:a17:902:d510:b0:267:776b:a31a with SMTP id d9443c01a7336-290ca121a37mr51838215ad.29.1760716087572;
        Fri, 17 Oct 2025 08:48:07 -0700 (PDT)
Received: from tixy.nay.do ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a9a7sm67893225ad.18.2025.10.17.08.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:48:07 -0700 (PDT)
From: Ankan Biswas <spyjetfayed@gmail.com>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Ankan Biswas <spyjetfayed@gmail.com>
Subject: [PATCH v2 1/3] Fix broken maxim-ic.com links to analog.com
Date: Fri, 17 Oct 2025 21:17:47 +0530
Message-ID: <20251017154755.32105-1-spyjetfayed@gmail.com>
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
 Documentation/hwmon/jc42.rst     | 2 +-
 Documentation/hwmon/max16064.rst | 2 +-
 Documentation/hwmon/max16065.rst | 8 ++++----
 Documentation/hwmon/max1619.rst  | 4 ++--
 Documentation/hwmon/max31790.rst | 2 +-
 Documentation/hwmon/max6650.rst  | 4 ++--
 Documentation/hwmon/max8688.rst  | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/hwmon/jc42.rst b/Documentation/hwmon/jc42.rst
index 19d10512f6c0..3736e63db2a8 100644
--- a/Documentation/hwmon/jc42.rst
+++ b/Documentation/hwmon/jc42.rst
@@ -33,7 +33,7 @@ Supported chips:
 
     Datasheets:
 
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
index 45f69f334f25..ac3dc6f023dd 100644
--- a/Documentation/hwmon/max16065.rst
+++ b/Documentation/hwmon/max16065.rst
@@ -12,7 +12,7 @@ Supported chips:
 
     Datasheet:
 
-	http://datasheets.maxim-ic.com/en/ds/MAX16065-MAX16066.pdf
+	https://www.analog.com/media/en/technical-documentation/data-sheets/max16065-max16066.pdf
 
  *  Maxim MAX16067
 
@@ -22,7 +22,7 @@ Supported chips:
 
     Datasheet:
 
-	http://datasheets.maxim-ic.com/en/ds/MAX16067.pdf
+	https://www.analog.com/media/en/technical-documentation/data-sheets/max16067.pdf
 
  *  Maxim MAX16068
 
@@ -32,7 +32,7 @@ Supported chips:
 
     Datasheet:
 
-	http://datasheets.maxim-ic.com/en/ds/MAX16068.pdf
+	https://www.analog.com/media/en/technical-documentation/data-sheets/max16068.pdf
 
  *  Maxim MAX16070/MAX16071
 
@@ -42,7 +42,7 @@ Supported chips:
 
     Datasheet:
 
-	http://datasheets.maxim-ic.com/en/ds/MAX16070-MAX16071.pdf
+	https://www.analog.com/media/en/technical-documentation/data-sheets/max16070-max16071.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
diff --git a/Documentation/hwmon/max1619.rst b/Documentation/hwmon/max1619.rst
index b5fc175ae18d..f134d0fa9bfd 100644
--- a/Documentation/hwmon/max1619.rst
+++ b/Documentation/hwmon/max1619.rst
@@ -9,9 +9,9 @@ Supported chips:
 
     Addresses scanned: I2C 0x18-0x1a, 0x29-0x2b, 0x4c-0x4e
 
-    Datasheet: Publicly available at the Maxim website
+    Datasheet:
 
-	       http://pdfserv.maxim-ic.com/en/ds/MAX1619.pdf
+	       https://www.analog.com/media/en/technical-documentation/data-sheets/MAX1619.pdf
 
 Authors:
        - Oleksij Rempel <bug-track@fisher-privat.net>,
diff --git a/Documentation/hwmon/max31790.rst b/Documentation/hwmon/max31790.rst
index 33c5c7330efc..b8af2d907b6e 100644
--- a/Documentation/hwmon/max31790.rst
+++ b/Documentation/hwmon/max31790.rst
@@ -9,7 +9,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: https://pdfserv.maximintegrated.com/en/ds/MAX31790.pdf
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX31790.pdf
 
 Author: Il Han <corone.il.han@gmail.com>
 
diff --git a/Documentation/hwmon/max6650.rst b/Documentation/hwmon/max6650.rst
index 7952b6ecaa2d..427f353c5e9c 100644
--- a/Documentation/hwmon/max6650.rst
+++ b/Documentation/hwmon/max6650.rst
@@ -9,7 +9,7 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX6650-MAX6651.pdf
 
   * Maxim MAX6651
 
@@ -17,7 +17,7 @@ Supported chips:
 
     Addresses scanned: none
 
-    Datasheet: http://pdfserv.maxim-ic.com/en/ds/MAX6650-MAX6651.pdf
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX6650-MAX6651.pdf
 
 Authors:
     - Hans J. Koch <hjk@hansjkoch.de>
diff --git a/Documentation/hwmon/max8688.rst b/Documentation/hwmon/max8688.rst
index 71e7f2cbe2e2..71b6b9ee90ab 100644
--- a/Documentation/hwmon/max8688.rst
+++ b/Documentation/hwmon/max8688.rst
@@ -9,7 +9,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX8688.pdf
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max8688.pdf
 
 Author: Guenter Roeck <linux@roeck-us.net>
 
-- 
2.51.0


