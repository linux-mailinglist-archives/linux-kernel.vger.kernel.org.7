Return-Path: <linux-kernel+bounces-807547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8D7B4A5FD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E9B84E26AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2AE275847;
	Tue,  9 Sep 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="ltDOABSV"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B21A274B3C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407912; cv=none; b=iWTiQaKSBAhA5U8fXCuizf0yREYMtOrkRRT3vSkO/McAcbJ+nYDYDcYRBi9r9fjCYXbu0EnACwVB6yaBuwFgTyGiDuPQoU2vdyPw4n5wNF3fR5idUKkYIjMFCPOzl4xXcQTH/8htmWwYkKkGumPfHtP1bthkE+k1un58uGlUkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407912; c=relaxed/simple;
	bh=V2LD4c2YqvvZsVb5vESU9/gd6wD8GomVEn03Q1TEoGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BszzMzrhzX2epx6M3x1jdiyJdFAN5V9SPep/q1MBab6s3tWAaA0sN2zH08DdUmP/Zfw8D4RN9SIRWri7A760vDLKHVBaDceRv9EWZ+8Bgw43TGJrGlgzbGZUjRM3xt7v9iau5fX31NcMHn3/63R8apl4FjQysRi1qCC/Yt4asBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=ltDOABSV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45de6ab6ce7so11659865e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1757407908; x=1758012708; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHOTfsWdn/6gtCaqm3kyodB2aISE9a8blixZBCDKEC0=;
        b=ltDOABSVqTsGV825nIpTAAJaEfXwjAihqfxwt+ds5dPG2f7IcAXwblMDzYza4tVg7n
         cuFVFYQFg913RoAqnOxsEXVioHGHwcW98bduwLB7xJyqjQQW+yxS7W41kKxXBL+7E7E+
         XVZeCXnQcH4+TwFNmvVsnUaAHVM/A5D5/7z0Dos8AEkf9XkkCkUZFbtMNXp3dpjlebnG
         uzQinEK+Y3JM+3Ant/c1t5wophlzUbUgtSlbJ5FBBLvaJDoRXYVOoJ7elEd9+aofWESG
         uMyQ5QYcKVLo/aoYeTeta42vhnnLYhhqdfihh2/O9fWAqNiJo3rrGAx65Kb8LirUTdWx
         PKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757407908; x=1758012708;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHOTfsWdn/6gtCaqm3kyodB2aISE9a8blixZBCDKEC0=;
        b=DBktStrtZ125Jw8YbxejsMGEycH/UC8WZ7A32e0e273Eo8YqB1Gjx+qaCoDuaEKv5k
         0EF9GZc3QD6F9QtoTO8DVfvtb6Z+60eaQzWGpMOo8znZYMgVnl/ErC4oGw6E5jZ0mf5n
         XUa20NM1L+6+HqRMveqAl963buGBG8N3dr16JoaOH+cOh8jjdhutcCI6NtwuC2WKQ4A5
         HB3ogxVKusFD83QS74atqDs/QjqPO86bt1jUdssnkcPATcGboJQolKFPzdg85IRvKd0Q
         m0NWRZV03y6I9pQXvSsU3LuI7DeHJFXrtLUKbUPRVsY8w3ehRTSCVKoA+65KA2YgC9l3
         A+sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTJtKYaExLsO44IhLpxKquCWLUMDoCJeHWfIzsy4v6dqgHIWhbOCNmsBebBDNyoyLlA1mcRhScMWxa4cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrmvyFn8QLL8ccXVTm5CmDe2KUoR/zZBA9M5r84k9Sm2Zuaw3t
	uLDjINn1Pofk7JjBwpFk6FcCXWasin/ljrclqOmZkXI+4BDybGPRs+phE7HKJjU1GLY=
X-Gm-Gg: ASbGnctbZUoRqt9A7kLIveUO2fRq2+ocE6b2lfLxFGpDSt9NB8boGr5N6BZ8/AJZ4Lt
	eQxAlNzgHTtwJ5wFFK5CGUlxUfT5hzmGP6j97qymbNjf251T+fxMkvtWcLkXab/K0eMUcs1Qqhh
	fiGRMhN8tjQj0fc4mK/zYK4j8b+VAHU6hScBn3Dk3SvHgW/jXG6xZSO27uret6ppIiIbYz9gAf9
	xPSCj2ZQ11Y05yiOdBDIaHeurmWAGUDa9Hh7d/T2lwGEvZBxwFglDfsFy2ibnx3LfeYLA2nAbkM
	/UI8aapYh+mVF68in8ImuCFiCO97S6AvCuecLYLox3v6x5XZsOiaVz+iRGp11k7gsNIGTsPI27t
	lXwfhrEXzEYizlGGylrAXRDUJCYMsWj3+b6Ffzw7+owrXU5g17atO3HQP8g==
X-Google-Smtp-Source: AGHT+IEPSBuO9Gho/ytg2wOmIg3pXkxG0F3RZPO+7vrq2Q8pxjaaLAsoZ56SGlT+JonILgddvkWrgA==
X-Received: by 2002:a05:600c:4fcd:b0:45d:dae8:b137 with SMTP id 5b1f17b1804b1-45dddec8468mr90281295e9.22.1757407908240;
        Tue, 09 Sep 2025 01:51:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a02:c7c:8a3e:8c00:8286:d205:8f5a:7f5e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab14esm518120955e9.21.2025.09.09.01.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 01:51:47 -0700 (PDT)
From: Harrison Carter <hcarter@thegoodpenguin.co.uk>
Date: Tue, 09 Sep 2025 09:50:04 +0100
Subject: [PATCH] dt-bindings: leds: as3645: Convert to DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-ams-txt-to-dt-schema-v1-1-8a30c25c8295@thegoodpenguin.co.uk>
X-B4-Tracking: v=1; b=H4sIADvqv2gC/x3MPQqAMAxA4atIZgOxalGvIg6lRpvBH5oignh3i
 +M3vPeAchRWGIoHIl+icuwZVVmAD25fGWXOBkOmpZ4suk0x3QnTgXNC9YE3h64zFRNT7RsLOT0
 jL3L/23F63w8xQxsIZgAAAA==
X-Change-ID: 20250906-ams-txt-to-dt-schema-a821e0e03c46
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Harrison Carter <hcarter@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757407907; l=6995;
 i=hcarter@thegoodpenguin.co.uk; s=20250904; h=from:subject:message-id;
 bh=V2LD4c2YqvvZsVb5vESU9/gd6wD8GomVEn03Q1TEoGs=;
 b=rBNQmeJz2PGwDsJGqsOXX1epHswRma8CnJWbRuPlFCb/5p6jTQoQIf6sw7hPS2IOHOXk5e2xF
 vO8j5IPQsetDeZKfN9rMtlGcGk8POnv+7EMXTif4JMkRYPWHczIEqIu
X-Developer-Key: i=hcarter@thegoodpenguin.co.uk; a=ed25519;
 pk=xn5ghTMMWQniDtZih4xwKCTAaBHDozflTmqNKtaKo6s=

Convert the ams,as3645a.txt to DT Schema format.

maintainer: set to what I found in MAINTAINERS

Signed-off-by: Harrison Carter <hcarter@thegoodpenguin.co.uk>
---
 .../devicetree/bindings/leds/ams,as3645a.txt       |  85 --------------
 .../devicetree/bindings/leds/ams,as3645a.yaml      | 130 +++++++++++++++++++++
 2 files changed, 130 insertions(+), 85 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/ams,as3645a.txt b/Documentation/devicetree/bindings/leds/ams,as3645a.txt
deleted file mode 100644
index 4af2987b25e92394ebd46456e30002d3ae3a6101..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/leds/ams,as3645a.txt
+++ /dev/null
@@ -1,85 +0,0 @@
-Analog devices AS3645A device tree bindings
-
-The AS3645A flash LED controller can drive two LEDs, one high current
-flash LED and one indicator LED. The high current flash LED can be
-used in torch mode as well.
-
-Ranges below noted as [a, b] are closed ranges between a and b, i.e. a
-and b are included in the range.
-
-Please also see common.txt in the same directory.
-
-
-Required properties
-===================
-
-compatible	: Must be "ams,as3645a".
-reg		: The I2C address of the device. Typically 0x30.
-#address-cells	: 1
-#size-cells	: 0
-
-
-Required properties of the flash child node (0)
-===============================================
-
-reg: 0
-flash-timeout-us: Flash timeout in microseconds. The value must be in
-		  the range [100000, 850000] and divisible by 50000.
-flash-max-microamp: Maximum flash current in microamperes. Has to be
-		    in the range between [200000, 500000] and
-		    divisible by 20000.
-led-max-microamp: Maximum torch (assist) current in microamperes. The
-		  value must be in the range between [20000, 160000] and
-		  divisible by 20000.
-ams,input-max-microamp: Maximum flash controller input current. The
-			value must be in the range [1250000, 2000000]
-			and divisible by 50000.
-
-
-Optional properties of the flash child node
-===========================================
-
-function	:  See Documentation/devicetree/bindings/leds/common.txt.
-color		:  See Documentation/devicetree/bindings/leds/common.txt.
-label		:  See Documentation/devicetree/bindings/leds/common.txt (deprecated).
-
-
-Required properties of the indicator child node (1)
-===================================================
-
-reg: 1
-led-max-microamp: Maximum indicator current. The allowed values are
-		  2500, 5000, 7500 and 10000.
-
-Optional properties of the indicator child node
-===============================================
-
-function	:  See Documentation/devicetree/bindings/leds/common.txt.
-color		:  See Documentation/devicetree/bindings/leds/common.txt.
-label		:  See Documentation/devicetree/bindings/leds/common.txt (deprecated).
-
-
-Example
-=======
-
-#include <dt-bindings/leds/common.h>
-
-	as3645a@30 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x30>;
-		compatible = "ams,as3645a";
-		led@0 {
-			reg = <0x0>;
-			flash-timeout-us = <150000>;
-			flash-max-microamp = <320000>;
-			led-max-microamp = <60000>;
-			ams,input-max-microamp = <1750000>;
-			function = LED_FUNCTION_FLASH;
-		};
-		led@1 {
-			reg = <0x1>;
-			led-max-microamp = <10000>;
-			function = LED_FUNCTION_INDICATOR;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/leds/ams,as3645a.yaml b/Documentation/devicetree/bindings/leds/ams,as3645a.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f956c20cc8fb379f370ad785a3d75f27d0cfa032
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/ams,as3645a.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/ams,as3645a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AS3645A LED Controller
+
+maintainers:
+  - Sakari Ailus <sakari.ailus@iki.fi>
+
+description: |
+  The AS3645A flash LED controller can drive two LEDs, one high current
+  flash LED and one indicator LED. The high current flash LED can be
+  used in torch mode as well.
+
+properties:
+  compatible:
+    const: ams,as3645a
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  led@0:
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0
+
+      flash-timeout-us:
+        minimum: 100000
+        maximum: 850000
+        description: |
+          Flash timeout in microseconds. Must be divisible by 50000
+
+      flash-max-microamp:
+        minimum: 200000
+        maximum: 500000
+        description: |
+          Maximum flash current in microamperes. Must be divisible by 20000
+
+      led-max-microamp:
+        minimum: 20000
+        maximum: 160000
+        description: |
+          Maximum torch (assist) current in microamperes Must be divisible by 20000
+
+      ams,input-max-microamp:
+        minimum: 1250000
+        maximum: 2000000
+        description: |
+          Maximum flash controller input current. Must be divisible by 50000
+
+    required:
+      - reg
+      - flash-timeout-us
+      - flash-max-microamp
+      - led-max-microamp
+      - ams,input-max-microamp
+
+  led@1:
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 1
+
+      led-max-microamp:
+        enum:
+          - 2500
+          - 5000
+          - 7500
+          - 10000
+        description: |
+          Maximum indicator current. The allowed values are 2500, 5000, 7500 and 10000.
+
+    required:
+      - reg
+      - led-max-microamp
+
+required:
+  - compatible
+  - reg
+  - "#size-cells"
+  - "#address-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c{
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        as3645a@30 {
+            compatible = "ams,as3645a";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0x30>;
+
+            led@0 {
+                reg = <0>;
+                flash-timeout-us = <150000>;
+                flash-max-microamp = <320000>;
+                led-max-microamp = <60000>;
+                ams,input-max-microamp = <1750000>;
+                function = LED_FUNCTION_FLASH;
+            };
+
+            led@1 {
+                reg = <1>;
+                led-max-microamp = <10000>;
+                function = LED_FUNCTION_INDICATOR;
+            };
+        };
+    };
+...

---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250906-ams-txt-to-dt-schema-a821e0e03c46

Best regards,
-- 
Harrison Carter <hcarter@thegoodpenguin.co.uk>


