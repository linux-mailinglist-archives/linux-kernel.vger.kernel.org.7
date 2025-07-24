Return-Path: <linux-kernel+bounces-745069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF050B11473
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959051C24CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2FC242D72;
	Thu, 24 Jul 2025 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fnQHRPB1"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9A6241116
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753399563; cv=none; b=BJRhpXh7T8Q6DeEGGEsFJ5hwtCBEPDooN8XgCy2qpZLk+3psJxo4lIxkFhtcqWSPv4IXY/vrh4lUrK76k9CXuWYIzN7QgxO5/ohRIZqiWazpVVncOxT5xsybR1VQkKnDJwDjDWkxvxA61NIa/LoSdR3YrtZnxxyhMj+RF767x4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753399563; c=relaxed/simple;
	bh=jipKWVKsFdr1qA0HSPJ1BXNrgw852G9el3ImjeG3Zvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WaGFssJwkEiSlZH4Ny2tggxwH6IWkOP35/ZzdfBCRsIFLm9uLzPKOvswoRGMIHOz5DAPmaI4O8318eDejFcDHzDCidAPTmHkHof+WzkHWFtuOIILZYlVakV1Y85R/6te3QxHdCLGFnxEex2HCWLePH80Vj2dKDRphnMhI94KcqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fnQHRPB1; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-73e9f2d8f41so656706a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753399560; x=1754004360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UL8ywrHdQaP6cce4vRzyQj8i/xvC4Qu5NnfytH11y+o=;
        b=fnQHRPB1jQxYnPIsHY0Twc/bCVYlVTIwZh4aHV8kNQAw0l38a88PjXZvykKTv4ScEs
         +6DsI0BWy04jCQsoHAuZHXHNpFvZztn1rLWN9GOH5rC5ufXbtebbgANQPJK0Yn0ndiwq
         D0UvLhNWUuUWfLbAe/UYrKvUDt3RJL4MGlc3wLVGQAbCPZIKx/fI7xifb1SLCEFqcSJv
         iSCauq5A6GEXGGeED9rYzpDsOR/VrzYMQOhHaJ2bVBCZ47aaP7YUspbChMuO2LuTaCgv
         wlTqSJHLtBvKP0NmCuupLMlhKbcJVQOfc4uFtGVUCq2666jLMMOrFZzOibaqRbZRGmNz
         8DbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753399560; x=1754004360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UL8ywrHdQaP6cce4vRzyQj8i/xvC4Qu5NnfytH11y+o=;
        b=t/p4HbxHFskh4muy3KzisIc68acRyd9xE4+mNWQdyygM+Xj4xOefBKEMnlNTuI+vLq
         LkVVsQ+zAx48BCyrbJJEizIKiGHrU+jrIR2sPc5CgrQYvF6qZgeAgi3Mz3WWF3p4fEd/
         a/9MQWaFKIZyiJFpOxyS0OgaGtXazrOq0wO3TSDZmFlqdvx0O5du3erIt0ok0icCESN1
         sFwjV1dABxGTc0qfsa86FTUnjNr5UtHdVv6BXSQfD+bsCtp6sF53FmmITNhsh9OaL/86
         3TH1aYnpOogHlrJaaUr1vtpKWBultFOwShBZBtVs/VTF1FXgU3WFQUjnEN31MRbRFVnh
         vWcg==
X-Forwarded-Encrypted: i=1; AJvYcCXFZSuT8s+TDGKkMY7YDgf79sn8lduUNLQ+FTZlb5+D7IdfJUMssqhQRS/VqvMUo2Eh6NMJSsVhmt2Y3Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhYNIqiRmuOpMXbk9L9DJCMF83rzTXkhuoQwZc6DsG8z6mXkIt
	SsoUHiwMtF4NgPGvrbu0UOMGMrm/E6V5wyna4216JNW5UhiJrfOnX8xkJZaP6trabJjUebu/AxE
	8Yzi6
X-Gm-Gg: ASbGncsecNhvWfgXdQC8Q5gi3ECQWbIHy05sGBg+zpZYlGgbqFU0GVFTPcvAK0cfFF6
	/AidP/FEjnNx64QnZEd9okXZkV2PIeALEDbqzxLlm/DNpgmUWenFy5cSmYfz+LKXiX7geSdJJHe
	u1Jm983H+hwWMbuKLcCoKCL7mNPSnfYnPWtIVrA/71Le4usF+F7xsANMkzzyToXKlu92NxdWWkK
	HhrjNEirvfduXpbpK4ZjW5YuelpbwiLl67KnFf5wvnrhlc2cRe71Ak+/sVni6C1mH6l/KVHMLs7
	GAubH5m5L2+p9e9hX/ChEnRyaRPikrmNuC6ioMByhaPQeogoBIOeVTQqLt9Zr5Fl4aXo2XecaJF
	ugI2qN+Qq0Mg0dwtdPlcUAR1n/Q==
X-Google-Smtp-Source: AGHT+IGGUztpINgxauLinjEHg8fWM3hH79nzL0EeC15g+wopz3h896e5+JgVovrtaCBIPOpgTRXUzg==
X-Received: by 2002:a05:6808:50a3:b0:40a:52e5:37df with SMTP id 5614622812f47-426ce78017emr5698186b6e.39.1753399560375;
        Thu, 24 Jul 2025 16:26:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:337f:e3bf:e9d2:b3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-306e3971332sm689626fac.0.2025.07.24.16.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 16:25:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 24 Jul 2025 18:25:22 -0500
Subject: [PATCH 1/4] dt-bindings: iio: adc: adi,ad7124: fix clocks
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-iio-adc-ad7124-proper-clock-support-v1-1-88f35db2fcaf@baylibre.com>
References: <20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com>
In-Reply-To: <20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3099; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=jipKWVKsFdr1qA0HSPJ1BXNrgw852G9el3ImjeG3Zvw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBogsDrFQDENobZmWQK6a+NGqu+QL4N715ystTEB
 RPr8RaRE9eJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaILA6wAKCRDCzCAB/wGP
 wKxRB/41H2jgneOzpdOFI36J/f77O6Dw2Ec9weJ9vDvG/JXo/8XLIk4jD/j5dl2bFOTTSbSCAJJ
 7dLjPEjJdBhNUOcBOcVL0pP7FS85zHC8GdOBJ0flD9OBpONj9YKj+YqaFuAibM54pJ/RvoIkCvr
 9hkIOn+tMvPyCmn8DAfoX/6Pffvefv0zlFp0s5Ux/5w2gOowJzPgDAi4Ls60bnijG91C2tF78CD
 iK0peTLAjKvzt1ocXF/uGHsx1Nuvh/5ZU0jRgbQ3EgYbK8lrv3huFRrRxFTZ1277F8pzROTfqJ5
 EkluqRgq+YuWcCa732U1tKsC2JDZ5fx3Lbaf66BQfXppfx72
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

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml     | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
index 7146a654ae382bac7410ba525dfc98662f0f674a..c4b5e29730d6df58d0c29ed6dc20d250a9af67e6 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -27,12 +27,21 @@ properties:
 
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
@@ -66,10 +75,14 @@ properties:
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
@@ -135,8 +148,6 @@ examples:
         interrupt-parent = <&gpio>;
         rdy-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
         refin1-supply = <&adc_vref>;
-        clocks = <&ad7124_mclk>;
-        clock-names = "mclk";
 
         #address-cells = <1>;
         #size-cells = <0>;

-- 
2.43.0


