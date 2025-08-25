Return-Path: <linux-kernel+bounces-785664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A908B34F3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E603B883D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7A52C0F97;
	Mon, 25 Aug 2025 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="raYk3nZ2"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47202BE02C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162543; cv=none; b=HFHRMI/wY75I9a+G5xpbBkkUB+qCEV2jKBi7kc65li98Dbh8xrR1Rbqi1B4dMMt/e5ErV/gyDyuZVdq65gHnbltg6eyk6RpGPzzgqr8odbq05Gk5mKwzahFoRhBw0T4eGNtd0K7H69y23JVRT+1WAZ20bXl4oBUn2TFsbSoumSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162543; c=relaxed/simple;
	bh=ejiW++p+A0I9xjvm23IuPsPQ6EO4iCmJb+R47NFoGFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Buf2akt5E1mWUhCuyYJiwa/L1xZK1SaC0Awr0UY7bYzpj1GtEWjFS0ix1J+oIJAgXRnW6Y7Sce7sJEE757TZ42xNpmHMRx8pO0LJ/uGgasr+9iKD5GMw+Ic002yvYs/69ia2zqkW46MHU08l74V+pEEeUo4i0cAUoT2DFA5Np/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=raYk3nZ2; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30ccec928f6so1484682fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756162540; x=1756767340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCS1blGVKzhibBa+GC93mJ6dY0HkTwPO0389IUyBXCQ=;
        b=raYk3nZ2h0JirOq0RbGPWGuD3i/BfBEOaDV3EFRISMwqJVjv1cNXk5GdWfFg27GaXW
         AimnX2M4TBmeZKETT7ujlxZ1pKc0Zvz5KIRkkw3nJaGsVUgunBxfLnEB7B6bTXusaJ16
         RJu+9NtC0E5SmLXDAVvEsYl0U9y/Xc9V86U+DFECvGSEuUzHN/a0m8iVCr/HvAtMrema
         ou6sGk5uC1lCHngoqADlNv3vyu6wu70l06ZVdMGBHJQl5uuQorPXvjHdW4aTM8Ncclmd
         rPDafvoHbcUdbHV0pmnAvqcPRxIQWydLU+iwCymjcSu+wV2eJVGKU7a04D7PNtpwNDVN
         nHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756162540; x=1756767340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCS1blGVKzhibBa+GC93mJ6dY0HkTwPO0389IUyBXCQ=;
        b=iA/Y9U79tiR2aj416Nj022mM8h1dxdncZuk1Rrg1HV1UmD21IuwRxAICxRGYFTeQpK
         uXmPWuulgaYOKF95+5Ykj3prOIDlK986LSJLGMLyVA8hj5t8LbMT7BiI5hdtcVCRPSfn
         IyKbsP8N71hGitvRp1ZtUeWMd8QgdC9sAl+EeMOOJFohQxcthOL5if3MZmRjV/f7EpMM
         j+mPa76DYKA+Z5d9eq7+ShfKVgsMAGP/hQN5mlQnRAvl+PPwqG2XcaG6ikkoKl1ucW30
         9WR5o66tfCESc23xoWoDkDpw3+qs26SGgOIUpMqUknWhRF8gvdcbh+iJxkrFBe0eSQ+w
         zJaw==
X-Forwarded-Encrypted: i=1; AJvYcCVfx4czlIVX9lf9V0iCEzS/e1ewwuAkTlMn4SDLaw+6NKbfwXwk4zRLbq+0wHVS2egjcgVJhNxAvbJ/DCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmGctT6rmsO5ZmuSfUslnyodIEQqH5yjoYt92G/o7Mi7u7NSgi
	ZQxX7Gj4o06Ie7Z8xilnuI4yTLTDGhwX2tmvGN0P6XXMpJHpWiFxsU5q6QjwhsKi1sicabmQdcl
	no8cG
X-Gm-Gg: ASbGncs2Z5Hy3nz0Z/HTgrhEEunhXWeLspcvr3UNpbmJlOhpmwBctSAIRw6Sei1uEG9
	ca8GhTEAHYjxh/6ifdNI0r0DGXhIabLlMCH5aOXNQ6zH2G+uNE0YqlZDnLKayDFQ4emC6MlEsZ1
	vYE1gqsPomMwWHsc4+2sYyNKs+zdRsHhSJXnFlIIhex+87hBFvF4IpsL4JNgPv3fzsLM5RIbFGq
	h3Zjyjj43VZoJnRWj60VaL9UnS3ZoAbGR4oqBs2F0tWMY6Le6f9bh4hw96M76QQczYL4v9/QTkr
	43AMFJcaaHkwTInd3GRCQpz3Ceu0A/F+RDUJF7Sf3rNSZTWMU9drtRy3k176b0oFCE+lGpUtVCb
	ErRbiPm9UHKhf5aysMJSd8wEpmz2ls+2fBtunACM=
X-Google-Smtp-Source: AGHT+IG4VbfJVkJxZqA+j3n+8jvXqEZbWK6Ftb5Y0wcjCOXmZgkbdUMlYCsFzEePddd25RPW+aio1w==
X-Received: by 2002:a05:6870:1698:b0:314:b6a6:68aa with SMTP id 586e51a60fabf-314dce1b218mr6156559fac.50.1756162540620;
        Mon, 25 Aug 2025 15:55:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:5075:40f3:ff25:c24c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e49d36esm1991747a34.40.2025.08.25.15.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 15:55:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 25 Aug 2025 17:55:00 -0500
Subject: [PATCH v2 1/4] dt-bindings: iio: adc: adi,ad7124: fix clocks
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-iio-adc-ad7124-proper-clock-support-v2-1-4dcff9db6b35@baylibre.com>
References: <20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com>
In-Reply-To: <20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3149; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ejiW++p+A0I9xjvm23IuPsPQ6EO4iCmJb+R47NFoGFU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBorOnQTpaL89+dgO4/3roWZJ3pfkCnrM9sgbTYp
 69gDTUeMLeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaKzp0AAKCRDCzCAB/wGP
 wKXZB/94Npdyo0oG2GLwGHIRiUblJ/LO92HfZFEtoR9yHzK2EzuzUTptn0My93mXkFjWFrR0rqE
 pGf47hKzPM/uQdvDDvWIQxElDCdZLvDDnsskpkYFmSt4NZ+8NwR6LJwJTrQL+ETXRuqFJUUHXeC
 hChKs17tcnrW/YnI3A4Cep96UcZL3od5n5Rm09eIe2MZcwHikmSg+TYu9DDAQIjzfKXBYmdm9kL
 WzeHXQmSanbjEkgGTeTeN7abWznb9kzbmZtu+twd4Qoja+wp8uPWwxhDOQAKzyiIJ+cqUdrwyxu
 1csZ9aC5Ho6zvTGZ2+Tx+toMDO13ZdYirBeDi6ysFmXLMpjF
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use correct clocks properties for the AD7124 family of ADCs.

These ADCs have an internal clock along with an optional external clock
that can be connected to the CLK pin. This pin can be wired up 3 ways:
1. Not connected - the internal clock is used.
2. Connected to an external clock (input) - the external clock is used.
3. Connected to the CLK pin on another ADC (output) - the internal clock
   is used on one and the other is configured for an external clock.

The new bindings describe these 3 cases by picking one of the following:
1. Omit both clocks and #clock-cells properties.
2. Include only the clocks property with a phandle to the external clock.
3. Include only the #clock-cells property on the ADC providing the output.

The clock-names property is now deprecated and should not be used. The
MCLK signal that it refers to is an internal counter in the ADC and
therefore does not make sense as a devicetree property as it can't be
connected to anything external to the ADC. Since there is only one
possible external clock, the clock-names property is not needed anyway.
Based on the implementation of the Linux driver, it looks like the
"mclk" clock was basically being used as a control to select the power
mode of the ADC, which is not something that should be done in the
devicetree.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml     | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
index 4dd5395730c10925c86782116dfd70a75d033bfb..2e3f84db6193b3d8765e2bdbd2d3175cf1892ba4 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -28,12 +28,21 @@ properties:
 
   clocks:
     maxItems: 1
-    description: phandle to the master clock (mclk)
+    description: Optional external clock connected to the CLK pin.
 
   clock-names:
+    deprecated: true
+    description:
+      MCLK is an internal counter in the ADC. Do not use this property.
     items:
       - const: mclk
 
+  '#clock-cells':
+    description:
+      The CLK pin can be used as an output. When that is the case, include
+      this property.
+    const: 0
+
   interrupts:
     description: IRQ line for the ADC
     maxItems: 1
@@ -67,10 +76,14 @@ properties:
 required:
   - compatible
   - reg
-  - clocks
-  - clock-names
   - interrupts
 
+# Can't have both clock input and output at the same time.
+not:
+  required:
+    - '#clock-cells'
+    - clocks
+
 patternProperties:
   "^channel@([0-9]|1[0-5])$":
     $ref: adc.yaml
@@ -136,8 +149,6 @@ examples:
         interrupt-parent = <&gpio>;
         rdy-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
         refin1-supply = <&adc_vref>;
-        clocks = <&ad7124_mclk>;
-        clock-names = "mclk";
 
         #address-cells = <1>;
         #size-cells = <0>;

-- 
2.43.0


