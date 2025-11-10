Return-Path: <linux-kernel+bounces-893997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C174FC49071
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BFC188B20B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BD82FC011;
	Mon, 10 Nov 2025 19:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMFI5WWG"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5DC335BDB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802946; cv=none; b=a0R7zIpS77G0wAsxhbGXt++TH/VMhVGWys/pnX3YcbvN6rtjhXS1Xx9Dm4639Hqo3A29MumQAJiDgAIl7lXQyi58krx6epVRfj8toOT53EQOpAehgGQtV77Dp+0Z3ipBr2KEfUzXAQVuxJXxaYg59m4EAl4zSdvbrjBxT+18Hsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802946; c=relaxed/simple;
	bh=vr6RxEgpRiqHUk8X8wejxw+5jKyx/+2PeqGfiI/1qw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vb7mbn/8/wImw1Ay80YKjH3VqLOppLlG3J1GVGjrqUeQCW+LfYGsJuOjQDIdcXb6pYX2wjn1BjuS2iyo2FGUIOjtwebpk6ISRp0taxkkGSyr+EiadVUkyjsiIEmV8e5k2r/5hvKseBjvQtugC16I8kLSYzMtPxIAkUZjRJzcoN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mMFI5WWG; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b70bee93dc4so471790366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762802942; x=1763407742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJP3xn5w556q22fk22x1v3x1DdvW2KK6ZMHkjIju+gU=;
        b=mMFI5WWGt2QMFTb9RzQr+5O+c/VyTVOWBcX0mt9h33oPJJluB5/7FbPRNa9mF9W5At
         hquo6jNkfxYHJqX92U9izLyJDUXxS0Sjn28mJ0qzqSCng5YMGW+3GTLvycPd4sLPTTQi
         +cqtBSW/GDnf3kHiDJAGNjZgTGtSCuS3DoOdW7z+YjM96kHZxFG/2jYhEYhbuXedljlN
         n081YrqDqozPh84Ac/cRmiymCh86bvQeeNEV14kayfFJB28V/O+Y33dUQFxTwueIeEIj
         hXQUmBeSQaxtU+iRbVLJPyx1yXKh3ILz1HkvgZ5s1o3WSkTKQp5i6TioCOk62yoJcYhu
         dRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762802942; x=1763407742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dJP3xn5w556q22fk22x1v3x1DdvW2KK6ZMHkjIju+gU=;
        b=LUuv4c7pXJKwxTM6xGXaJvb+V0TBkaRRqGCu4JUX+EibTe7k/dpPL6XY5rO2bG4d/S
         BWPyHUsyIcIxHisBiQMdtcckJEBCVTCxFQMsCL9TPs3Gs9DVPcXtZiXF/RCR2ox2VxGB
         2yAvU7iOAwKsV2yGU7ZmRLRyx1nxxMW150lQuc0hhxVHsNPRYHbodJwUtl2knbzsp3JZ
         1eDa1ek032DIV1bf1scNHo+/HhkuSf4KlCNQtmwcAIJ3II3FQlPm/KsB6MIJLHFxTCGE
         k0qC/VR8Kkms7fex5Me8lOPDyrHYMBUxQ/HYTlx+qX1/YLLynTxeas0IQmT16oNR3h1y
         OTIA==
X-Forwarded-Encrypted: i=1; AJvYcCWsPKK3pUnCcbSo/KcqTwaSpkb9DjS0HlGoIKG6bo7xfWtMO51RU1pVAfB9Ux4pRKxiP9rItTLo7/nOSuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHxD6Bvwr+RHKaXJQQHya9G+pbth5QXbv6hlEueloGpxGXgruG
	iPPYt5IIKZZgI421Sr87ZAPHR7ODsk7BVYGWD0jxipXIxrTXptYzTslv+HtxjY8BERw=
X-Gm-Gg: ASbGncsgnpoHLcA0D9AXhf91SHrkUZhpI4jn+0CVQndZrkLa5cU03KgRwABdtcFDXJy
	shW+iLb3nEN3AK33cViIhaKpRrshh4k+xx32r5bzAIowgnwPP1N0B9u1Ny1OkLZSVtHyACIYoWc
	L4etISLFNeAB/hx/qQeQe+QpHy2VTCO5vhi3hbSmSIDDxWexi5VzlIGBDJO4bzQMpqG+VBDMqa7
	Ivi4jAlAbbX/epcrsQ3cphSxTbIa3SjzJTflbNxj9EOkLKcLxf6PKDhcKXMMqQ6Qxq9cHA4F19C
	qthh5nFmxCk8jWIK/I9NHdBIv3YjfhNmdMd4KNQJqNw9jnSWCaf2xuLN+elc2nANekTwg4vYf/y
	Ok/tB6PWOlq99hhcneJJtcte5UJW5NKQ2NU7NzgT6GB3vKrPpVKk4eWfRnl4W9mXU4E9pkoWWtb
	4hoEgiKO7iScPnlrZNj6w+ibdMIzDwy/Ej9skJRIm7knBflGtKRz5ufq0o1Vam5hVjqxTEvro=
X-Google-Smtp-Source: AGHT+IER280qngV4eaj2hj/ImB6hOgWWKOhNkqzG5nImM12xY/4hFX9cFnSFQkOOg0D7SoaJs4N1yg==
X-Received: by 2002:a17:907:7203:b0:b70:b661:cfcb with SMTP id a640c23a62f3a-b72e0410257mr1039055666b.31.1762802942053;
        Mon, 10 Nov 2025 11:29:02 -0800 (PST)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d16esm1168178166b.35.2025.11.10.11.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:29:01 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 10 Nov 2025 19:28:48 +0000
Subject: [PATCH v4 05/20] dt-bindings: mfd: samsung,s2mpg10-pmic: Link to
 its regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251110-s2mpg1x-regulators-v4-5-94c9e726d4ba@linaro.org>
References: <20251110-s2mpg1x-regulators-v4-0-94c9e726d4ba@linaro.org>
In-Reply-To: <20251110-s2mpg1x-regulators-v4-0-94c9e726d4ba@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Update the regulators node to link to the correct and expected
samsung,s2mpg10-regulators binding, in order to describe the regulators
available on this PMIC.

Additionally, describe the supply inputs of the regulator rails, with
the supply names matching the datasheet.

While at it, update the description and example slightly.

Note: S2MPG10 is typically used as the main-PMIC together with an
S2MPG11 PMIC in a main/sub configuration, hence the datasheet and the
binding both suffix the supplies with an 'm'.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v4:
- separate bindings for s2mpg10-pmic and s2mpg11-pmic (Krzysztof)

v3:
- move to new samsung,s2mpg10.yaml file
- move all patternProperties to top-level
---
 .../bindings/mfd/samsung,s2mpg10-pmic.yaml         | 57 ++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/samsung,s2mpg10-pmic.yaml b/Documentation/devicetree/bindings/mfd/samsung,s2mpg10-pmic.yaml
index 6475cd1d2d15e07d953c8b302c90c785835985e5..0ea1a440b983a47a55fc86d6251b89056ba51172 100644
--- a/Documentation/devicetree/bindings/mfd/samsung,s2mpg10-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/samsung,s2mpg10-pmic.yaml
@@ -10,12 +10,13 @@ maintainers:
   - André Draszik <andre.draszik@linaro.org>
 
 description: |
-  This is part of the device tree bindings for the S2MPG family of Power
-  Management IC (PMIC).
+  This is part of the device tree bindings for the S2MPG10 Power Management IC
+  (PMIC).
 
   The Samsung S2MPG10 is a Power Management IC for mobile applications with buck
   converters, various LDOs, power meters, RTC, clock outputs, and additional
-  GPIO interfaces.
+  GPIO interfaces and is typically complemented by S2MPG10 PMIC in a main/sub
+  configuration as the main PMIC.
 
 properties:
   compatible:
@@ -31,6 +32,7 @@ properties:
 
   regulators:
     type: object
+    $ref: /schemas/regulator/samsung,s2mpg10-regulator.yaml
     description:
       List of child nodes that specify the regulators.
 
@@ -38,6 +40,32 @@ properties:
 
   wakeup-source: true
 
+patternProperties:
+  "^vinb([1-9]|10)m-supply$":
+    description:
+      Phandle to the power supply for each buck rail of this PMIC. There is a
+      1:1 mapping of supply to rail, e.g. vinb1m-supply supplies buck1m.
+
+  "^vinl([1-9]|1[0-5])m-supply$":
+    description: |
+      Phandle to the power supply for one or multiple LDO rails of this PMIC.
+      The mapping of supply to rail(s) is as follows:
+        vinl1m - ldo13m
+        vinl2m - ldo15m
+        vinl3m - ldo1m, ldo5m, ldo7m
+        vinl4m - ldo3m, ldo8m
+        vinl5m - ldo16m
+        vinl6m - ldo17m
+        vinl7m - ldo6m, ldo11m, ldo24m, ldo28m
+        vinl8m - ldo12m
+        vinl9m - ldo2m, ldo4m
+        vinl10m - ldo9m, ldo14m, ldo18m, 19m, ldo20m, ldo25m
+        vinl11m - ldo23m, ldo31m
+        vinl12m - ldo29m
+        vinl13m - ldo30m
+        vinl14m - ldo21m
+        vinl15m - ldo10m, ldo22m, ldo26m, ldo27m
+
 required:
   - compatible
   - interrupts
@@ -49,6 +77,7 @@ examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/regulator/samsung,s2mpg10-regulator.h>
 
     pmic {
         compatible = "samsung,s2mpg10-pmic";
@@ -58,6 +87,8 @@ examples:
         system-power-controller;
         wakeup-source;
 
+        vinl3m-supply = <&buck8m>;
+
         clocks {
             compatible = "samsung,s2mpg10-clk";
             #clock-cells = <1>;
@@ -65,5 +96,25 @@ examples:
         };
 
         regulators {
+            buck8m {
+                regulator-name = "vdd_mif";
+                regulator-min-microvolt = <450000>;
+                regulator-max-microvolt = <1300000>;
+                regulator-ramp-delay = <6250>;
+            };
+
+            ldo1m {
+                regulator-name = "vdd_ldo1";
+                regulator-min-microvolt = <700000>;
+                regulator-max-microvolt = <1300000>;
+            };
+
+            ldo20m {
+                regulator-name = "vdd_dmics";
+                regulator-min-microvolt = <700000>;
+                regulator-max-microvolt = <1300000>;
+                regulator-always-on;
+                samsung,ext-control = <S2MPG10_EXTCTRL_LDO20M_EN2>;
+            };
         };
     };

-- 
2.51.2.1041.gc1ab5b90ca-goog


