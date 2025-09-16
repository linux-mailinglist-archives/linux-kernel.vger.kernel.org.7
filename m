Return-Path: <linux-kernel+bounces-819118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A86B59BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DFA3BC889
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D38030DD31;
	Tue, 16 Sep 2025 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="Kwxqx+c9"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E346305E02
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035472; cv=none; b=ABzdiRY9rOVyC7WqWUt4zJwoANJONBPgC1JquRQILkqZeAdaNO17yg888SLNQNhYu5TDgO+ceTU46E7+c9Vy1LnpTrN8wMEJnjToYQbJnTlrwSuryKmsPlwGbD9E0S/xfeGFO2T6bCYSsNEWnWHv69EIPDBh4qIfGHodRzo8XTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035472; c=relaxed/simple;
	bh=xkmrgQrzuoinSGmLnFEEJ2AOTZir1zfdepMZ+yTs35I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UpqcdrF1rTd2WFEc2Uj9REnlucLRVWnk0E93sPgXYSQSJAp8aqYGTlbePJ077k7XWOxsuopMvTi73bW6qfNwCHl4/0ZKUHwirz0HzZXdsedHf4T+iZnEI5oknVqfCgSXePEq0RV/spc4PnL9E16btOpSbKsCLamvvTWjJLclkRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=Kwxqx+c9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45f2313dd86so38250555e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1758035468; x=1758640268; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bPk7Eye8VC0M0v+kNj0lPuEjCqs4U6Y0PjjlUqi87Gk=;
        b=Kwxqx+c9xZ+R1Dg24p2JdxMfNYD0TB6u9cEOJg/8odcn41P4rNX8ARLyA1hTjEetz2
         moAK6NQLNbEgqxlo8bRrRhcEWuRJxSXZPAJb6Ps4Ai2eRyqLXXJ5AXpax0PjZatXtVNn
         vBcCtwQ0Y+HjVp8wg7TXmaVytkW1Ad7bFcNDDxgQCZJWiAUIwxY2AnP6TFmAL81Kbn1W
         5Zbay31a07wIIGwB7JNAHUQyfSCDIeF9at8if6uAZn2ML2rzjyH2vP71f3aO2NSI/fMi
         cDT4ChbEa22gh+9yLQ73YW0qZ/8W4fIikYgWeFj7Qavda0TtfGBQsh+/3IpdCEJ63yxN
         TbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035468; x=1758640268;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPk7Eye8VC0M0v+kNj0lPuEjCqs4U6Y0PjjlUqi87Gk=;
        b=H/CB36K8BRd6/SOmUZpMdsCQokVSq2yl2vG+dUL2xpV2xY+rpN0SHPVjUDymeEQKi/
         HNljUSw/DmnUkYsfhD1sPM/e6BTWEFiV+dfw5OMKe50Jr5navFchu6X/dS5LTwpn2EVi
         7ewGMSNxT3f+rD16PmkrShaVb7/Ar9uxHfapcdQxo71DrHPFQ0814KChU/qKFFUYOqnf
         Mc5tjILsTPvKouVj2imZTNgajjXyD7aO8UOIo8G0HUqDPYUkIXpDVGExsiFKfm55od3z
         xFzyRpJmiVCCSFrNTS0lBaWt8AAIMfNZ9cgtUTSt+QAPX/eBTZT6Zi6Q7+EfpvBSk1Td
         aQUA==
X-Forwarded-Encrypted: i=1; AJvYcCVzWVUZ7MDPOKfhEeCsebj4sQx5hHBB5A1101bzsLu3xpgNzLjk9ixyY2JrYSCVpHY6VagG6+HdIqVgYak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUWYV7fhQ8EUkNZmevyyQFXiUZbibVLRhM6GRYoTihJ6W3bVmS
	I5N48TyDlGsnw8Mucr/+cMLkNhXiDHq9mMBP2EqCIIgYzJw8kVOWUvTRToGuYB/DvY0=
X-Gm-Gg: ASbGncuccFTkasdD0kU7+ML2ZQ/k/UR23KB9BVXHFFtlpC7tuw4HnbjkCZWm68vK5AD
	7BRFq8bXbvIwOWSeKbHiz2m8D8xc5Yuw+2bS235IaYgHuKrpHczbQUfvs8eTzlgFlj0UBqWtz5q
	VL+ZJIj2Q+Cp18Atw/un/67CymHzPmGcoHXWEkDBUhXOcaRGG59SU1I5rlLbxrmWajPEcwOHPqk
	rSrJStxXcc9VJXSBgOHmLQzevPE2F4zhW4nF+llpRJwoicfVV9zTb8vf9Tzu5tcMKEJlSwT4OWM
	Tb5aWFqFkkFtEaEJZlLnMaaOjiptS+8WW1TXkKTYIfU8Tub+JYTgYh6Fte+aVy5qBtKdGY4eqU3
	CrVep6/0OEAelxdAbnu45oGaHihlMFJFRdL9t
X-Google-Smtp-Source: AGHT+IHbw6qxWvt5wbaMCmyumPYxGMAg1kB+B0i3NMY43imy1I5P/7lTqLPtuRpzSsTf960J7N+NIg==
X-Received: by 2002:a05:600c:1c87:b0:45b:67e9:121e with SMTP id 5b1f17b1804b1-45f231e59f5mr159038485e9.14.1758035467495;
        Tue, 16 Sep 2025 08:11:07 -0700 (PDT)
Received: from [127.0.1.1] ([2a02:c7c:8a3e:8c00:9fef:1965:7419:ed5c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325c3c29sm19772955e9.3.2025.09.16.08.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:11:06 -0700 (PDT)
From: Harrison Carter <hcarter@thegoodpenguin.co.uk>
Date: Tue, 16 Sep 2025 16:11:01 +0100
Subject: [PATCH v2] dt-bindings: leds: as3645: Convert to DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-ams-txt-to-dt-schema-v2-1-6a9db6fb7ea3@thegoodpenguin.co.uk>
X-B4-Tracking: v=1; b=H4sIAAR+yWgC/22NQQqDMBBFryKz7kgSq2hXvUdxEeLUDMVEkigW8
 e5Nhe66fA/++ztECkwRbsUOgVaO7F0GdSnAWO1GQh4ygxKqFp1oUE8R05YweRwSRmNp0qhbJUm
 QqMy1gTydAz15O7OPPrPlmHx4ny+r/NpfsPsfXCVKbHUljKpNq7r6niyN3g8zuXFhVxpfLi/oj
 +P4AGbVpgfDAAAA
X-Change-ID: 20250906-ams-txt-to-dt-schema-a821e0e03c46
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Harrison Carter <hcarter@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758035466; l=7070;
 i=hcarter@thegoodpenguin.co.uk; s=20250904; h=from:subject:message-id;
 bh=xkmrgQrzuoinSGmLnFEEJ2AOTZir1zfdepMZ+yTs35I=;
 b=T+hrbsjhuiEhtbX04hVENKpnyxlzf2ToED+98eAqkcnPzJJHixSsCzNM8wYKKDNbGjsRjjFyS
 bcZvHbqKkusChPF/5d5ezVbCmPg9/Em+PdbEzY2XrrCU/j5n0ehhwx7
X-Developer-Key: i=hcarter@thegoodpenguin.co.uk; a=ed25519;
 pk=xn5ghTMMWQniDtZih4xwKCTAaBHDozflTmqNKtaKo6s=

Convert the ams,as3645a.txt to DT Schema format.

Signed-off-by: Harrison Carter <hcarter@thegoodpenguin.co.uk>
---
Changes in v2:
- removed unnecessary descriptions
- cleaned up clear text
- fixed syntax
- fixed line length
- Link to v1: https://lore.kernel.org/r/20250909-ams-txt-to-dt-schema-v1-1-8a30c25c8295@thegoodpenguin.co.uk
---
maintainer: set to what I found in MAINTAINERS
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
index 0000000000000000000000000000000000000000..250a4b275d8a8af28c69d14a419587f7a3db6ef8
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
+description:
+  The AS3645A flash LED controller can drive two LEDs, one
+  high current flash LED and one indicator LED. The high
+  current flash LED can be used in torch mode as well.
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
+    description: led0 describes the 'flash' feature
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
+        multipleOf: 50000
+
+      flash-max-microamp:
+        minimum: 200000
+        maximum: 500000
+        multipleOf: 20000
+
+      led-max-microamp:
+        minimum: 20000
+        maximum: 160000
+        multipleOf: 20000
+        description:
+          Maximum current when in torch (assist) mode.
+
+      ams,input-max-microamp:
+        minimum: 1250000
+        maximum: 2000000
+        multipleOf: 50000
+
+    required:
+      - reg
+      - flash-timeout-us
+      - flash-max-microamp
+      - led-max-microamp
+      - ams,input-max-microamp
+
+  led@1:
+    description: led1 describes the 'indicator' feature
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
+        description:
+          Maximum indicator current.
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
+        led-controller@30 {
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


