Return-Path: <linux-kernel+bounces-837517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205DABAC7CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53643C1315
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3AA2F9DA1;
	Tue, 30 Sep 2025 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="eA7Yo35l"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9C1298CAB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759228230; cv=none; b=MBWxzry5Otr9ccDr6QR/xh5uXm+fOkfUiIL4Ho+TO2muBatlXzfZohQR+RyqGnXBBq5Mp5VSVXUxEbp+wOFf/MnkyzEEIZRfDkqWoHpJ6ZEAarMfYh1T5WCGWgnp1ITSjK6YxxHRndjTIMn0uUukeLDFV/u/yGwHNP1JBUBzaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759228230; c=relaxed/simple;
	bh=X/wr3MGDTFOkNuPn/VRTyZUuH3wQb7AS6HDcmUoL2gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HnwHtK++QT3r6tPAOldkfgpQLqYCjDmI0e2/JEiqfhy1oeWITBWEc8yesGck7aDlN5E3uCYSdpswq4LA2MKb8QRTbOgZDyvuCf5xE11drobPl3s49uOLBmuPvLVw3UVCay4R1WHfzRN/DvVEMP0UspMVYJn4RjuQkI78I9F0ZMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=eA7Yo35l; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e326e4e99so29592815e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1759228225; x=1759833025; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmaySRiI+50ei/d4R4eMAr86JU+dCSIoSVR2L4OQo0M=;
        b=eA7Yo35lCKlL4hgbb0e/vCHSh3r2XqzBvKZYrvjhSPshrJ+uvSmGqxs27Yuyvv7EZn
         dWAAMmFBqEuSt1qHIa2vm8Az4XPngccBn4n1bXLNxSTbdZQlpw86Ew2V8gas2xnBpt1d
         BZHwA2xHlrCjwNTqt7cptEBRYi93GvW/U8qJgs8YIc58eVADfE7dPy5c9LUFBsUybszB
         S89AsJ+3BMRVnB7xfcjRcwK38Dqr1o6QTYESF2m9Epapo6tOOsSCEIOA+VKViWSBKknR
         dG0QJuHvMk21MkeaqgT/zmUwIBAONIy06H7VeSiRm4DLOUkF26Gp5dwJs1YFTFNmRdt7
         9fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759228225; x=1759833025;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmaySRiI+50ei/d4R4eMAr86JU+dCSIoSVR2L4OQo0M=;
        b=kO3Svoqr6xSPRy0ATotvv4KzFKduwCOyk+pYm6nHvESoOfMrzf8o+OVMHr9QONIADk
         15HyAY1tuCN0EMvYGzVXfCGjuf3nxnAqzgWu+SqvY1jJkOBJwcRtHry9Xj8Q0GLCWcta
         aJqvx//M85kOfMuGgLTZtQHgl9rSrvEQc/BsW6bQ1dLDDy0mMeeFmyeXVoWpJaRHoNGZ
         2E9awr81Vs9Pcma1do4fQH477G7RsKYZLZ3pbftcD9ZW+46gB4PkkXdngbPVOuZ385aR
         CVf0l/HVLL0YiHMyzs6mRN8ZvhqVrvjKwVTWH4VLHrPaJa+dRvREjOyZso1VvdxG+Gsp
         u+7A==
X-Forwarded-Encrypted: i=1; AJvYcCUZDVfYd84o59qzS4Lmf0HGBWG6skq7wtxezMSVqQGdE9ahKDzptN1WcNt0RtyGhqYJSaZzj1KNzfBy8ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+XSEFBvk2kwKtFIPQnIm2xF+YNnVnMMMf/OGGxgD4Lfyq17vJ
	spGaCYimG6D9HaSRpSNhkWa0mMXvVqPyytsybC6QBFAcbccig0wuaLAGp8bDTaHwdpY=
X-Gm-Gg: ASbGnct+FzXvmdT6y8n6GwvJ9kdgkHoYd/YUwyY7bnPppNPb1rtkdP1aHKSa9YFXppw
	6nPDN0pOdfQadLJIeHdcM72RtIlHJbnf5EJkPjUlPlM9DOyZzm9iTKirmE0lhQdOYH3u2WFKcIa
	bbRLlrM/ksiZDyHdZVQ+6d/IomViko/m2FbARQXO7nzDKClNyFWqfA4nE2QKnHG5c1yWQDiONhz
	/2H0qR0SC6kzUbrxx5RaGjgDQ0d58bN3zHtbhm4PCwGVRn3s8unoRUSHtMKj5fRGDMSC5m9zkjM
	FzeT4AFgZmik9nIVWHGc2GAXY0ugtxBlagiVqOG6+fENdSIF76hfbPN7W3pfLAAoiNqTBWAXEHJ
	EsosnNQMqDSLKBMvJDEbYVF1F1a4wXwtLetrX4CBfCfTYvxHzG7Ca/bLI
X-Google-Smtp-Source: AGHT+IFN0hIRcZoNqQ/BXbbnuzyPPrC0zmvjlktDHX2VYIVGF+l1FpDVip6kw8/3WovkLU1UeVSBIg==
X-Received: by 2002:a05:600c:859a:b0:45d:e775:d8b8 with SMTP id 5b1f17b1804b1-46e58aac95bmr28632445e9.1.1759228224806;
        Tue, 30 Sep 2025 03:30:24 -0700 (PDT)
Received: from [127.0.1.1] ([2a02:c7c:8a3e:8c00:7ec6:d455:268:da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602efdsm23223104f8f.34.2025.09.30.03.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:30:24 -0700 (PDT)
From: Harrison Carter <hcarter@thegoodpenguin.co.uk>
Date: Tue, 30 Sep 2025 11:27:26 +0100
Subject: [PATCH] dt-bindings: leds: bcm6358: Convert to DT Schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-brcm6358-to-dt-v1-1-ba833ceb1575@thegoodpenguin.co.uk>
X-B4-Tracking: v=1; b=H4sIAI2w22gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyNj3aSi5FwzY1ML3ZJ83ZQS3UQzy7REQyMjC1NDIyWgpoKi1LTMCrC
 B0bG1tQAkRflwYAAAAA==
X-Change-ID: 20250923-brcm6358-to-dt-a69fa1228512
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonas Gorski <jonas.gorski@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Harrison Carter <hcarter@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759228224; l=9147;
 i=hcarter@thegoodpenguin.co.uk; s=20250904; h=from:subject:message-id;
 bh=X/wr3MGDTFOkNuPn/VRTyZUuH3wQb7AS6HDcmUoL2gw=;
 b=icoOAdMjWv1x3npmyRzVppa34/1BdDBPVIN1UuG/eIYF48Ev4NTVs8ACbvT8Gsn38+ajx2IAB
 TlEK0OysxV8DkJPsRd9b5ZLgNvfW6znbbTZyilG9n9HuGPBWlPgkU3z
X-Developer-Key: i=hcarter@thegoodpenguin.co.uk; a=ed25519;
 pk=xn5ghTMMWQniDtZih4xwKCTAaBHDozflTmqNKtaKo6s=

Convert the brcm,bcm6358 LEDs to DT Schema format

Signed-off-by: Harrison Carter <hcarter@thegoodpenguin.co.uk>
---
 .../bindings/leds/brcm,bcm6358-leds.yaml           | 187 +++++++++++++++++++++
 .../devicetree/bindings/leds/leds-bcm6358.txt      | 143 ----------------
 2 files changed, 187 insertions(+), 143 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/brcm,bcm6358-leds.yaml b/Documentation/devicetree/bindings/leds/brcm,bcm6358-leds.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a9052a29aa7bd6ddc252258bfe4982325499713f
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/brcm,bcm6358-leds.yaml
@@ -0,0 +1,187 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/brcm,bcm6358-leds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LEDs connected to Broadcom BCM6358 controller
+
+description: This controller is present on BCM6358 and
+  BCM6368. In these SoCs there are Serial LEDs (LEDs
+  connected to a 74x164 controller), which can either be
+  controlled by software (exporting the 74x164 as spi-gpio) 
+  or by hardware using this driver. See example at
+  Documentation/devicetree/bindings/gpio/fairchild,74hc595.yaml.
+
+maintainers:
+  - Jonas Gorski <jonas.gorski@gmail.com>
+
+properties:
+  compatible:
+    const: brcm,bcm6358-leds
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  brcm,clk-div:
+    description: SCK signal Divider. Default 1
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8]
+
+  brcm,clk-dat-low:
+    description: Makes clock and data signals active low.
+      Default false.
+    type: boolean
+
+patternProperties:
+  "^led@[0,1]?([0-9]|[a-z])$":
+    type: object
+    $ref: common.yaml
+    description: Each LED is represented as a sub-node of
+      this device.
+
+    properties:
+      reg:
+        description: LED pin number
+        maximum: 31
+        minimum: 0
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    /* The bcm6358 SOC */
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        led-controller@fffe00d0 {
+            compatible = "brcm,bcm6358-leds";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0xfffe00d0 0x8>;
+
+            alarm_white@0 {
+                reg = <0>;
+                active-low;
+                label = "white:alarm";
+            };
+            tv_white@2 {
+                reg = <2>;
+                active-low;
+                label = "white:tv";
+            };
+            tel_white@3 {
+                reg = <3>;
+                active-low;
+                label = "white:tel";
+            };
+            adsl_white@4 {
+                reg = <4>;
+                active-low;
+                label = "white:adsl";
+            };
+        };
+    };
+  - |
+    /* The bcm6368 SOC */
+    led-controller@100000d0 {
+        compatible = "brcm,bcm6358-leds";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0x100000d0 0x8>;
+
+        brcm,pol-low;
+        brcm,clk-div = <4>;
+
+        power_red@0 {
+            reg = <0>;
+            active-low;
+            label = "red:power";
+        };
+        power_green@1 {
+            reg = <1>;
+            active-low;
+            label = "green:power";
+            default-state = "on";
+        };
+        power_blue@2 {
+            reg = <2>;
+            label = "blue:power";
+        };
+        broadband_red@3 {
+            reg = <3>;
+            active-low;
+            label = "red:broadband";
+        };
+        broadband_green@4 {
+            reg = <4>;
+            label = "green:broadband";
+        };
+        broadband_blue@5 {
+            reg = <5>;
+            active-low;
+            label = "blue:broadband";
+        };
+        wireless_red@6 {
+            reg = <6>;
+            active-low;
+            label = "red:wireless";
+        };
+        wireless_green@7 {
+            reg = <7>;
+            active-low;
+            label = "green:wireless";
+        };
+        wireless_blue@8 {
+            reg = <8>;
+            label = "blue:wireless";
+        };
+        phone_red@9 {
+            reg = <9>;
+            active-low;
+            label = "red:phone";
+        };
+        phone_green@10 {
+            reg = <10>;
+            active-low;
+            label = "green:phone";
+        };
+        phone_blue@11 {
+            reg = <11>;
+            label = "blue:phone";
+        };
+        upgrading_red@12 {
+            reg = <12>;
+            active-low;
+            label = "red:upgrading";
+        };
+        upgrading_green@13 {
+            reg = <13>;
+            active-low;
+            label = "green:upgrading";
+        };
+        upgrading_blue@14 {
+            reg = <14>;
+            label = "blue:upgrading";
+        };
+    };
+...
+
diff --git a/Documentation/devicetree/bindings/leds/leds-bcm6358.txt b/Documentation/devicetree/bindings/leds/leds-bcm6358.txt
deleted file mode 100644
index 211ffc3c4a201235e8d242b0230747b5dfe2a417..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/leds/leds-bcm6358.txt
+++ /dev/null
@@ -1,143 +0,0 @@
-LEDs connected to Broadcom BCM6358 controller
-
-This controller is present on BCM6358 and BCM6368.
-In these SoCs there are Serial LEDs (LEDs connected to a 74x164 controller),
-which can either be controlled by software (exporting the 74x164 as spi-gpio.
-See Documentation/devicetree/bindings/gpio/fairchild,74hc595.yaml), or
-by hardware using this driver.
-
-Required properties:
-  - compatible : should be "brcm,bcm6358-leds".
-  - #address-cells : must be 1.
-  - #size-cells : must be 0.
-  - reg : BCM6358 LED controller address and size.
-
-Optional properties:
-  - brcm,clk-div : SCK signal divider. Possible values are 1, 2, 4 and 8.
-    Default : 1
-  - brcm,clk-dat-low : Boolean, makes clock and data signals active low.
-    Default : false
-
-Each LED is represented as a sub-node of the brcm,bcm6358-leds device.
-
-LED sub-node required properties:
-  - reg : LED pin number (only LEDs 0 to 31 are valid).
-
-LED sub-node optional properties:
-  - label : see Documentation/devicetree/bindings/leds/common.txt
-  - default-state : see
-    Documentation/devicetree/bindings/leds/common.txt
-  - linux,default-trigger : see
-    Documentation/devicetree/bindings/leds/common.txt
-
-Examples:
-Scenario 1 : BCM6358
-	leds0: led-controller@fffe00d0 {
-		compatible = "brcm,bcm6358-leds";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0xfffe00d0 0x8>;
-
-		alarm_white {
-			reg = <0>;
-			active-low;
-			label = "white:alarm";
-		};
-		tv_white {
-			reg = <2>;
-			active-low;
-			label = "white:tv";
-		};
-		tel_white {
-			reg = <3>;
-			active-low;
-			label = "white:tel";
-		};
-		adsl_white {
-			reg = <4>;
-			active-low;
-			label = "white:adsl";
-		};
-	};
-
-Scenario 2 : BCM6368
-	leds0: led-controller@100000d0 {
-		compatible = "brcm,bcm6358-leds";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x100000d0 0x8>;
-		brcm,pol-low;
-		brcm,clk-div = <4>;
-
-		power_red {
-			reg = <0>;
-			active-low;
-			label = "red:power";
-		};
-		power_green {
-			reg = <1>;
-			active-low;
-			label = "green:power";
-			default-state = "on";
-		};
-		power_blue {
-			reg = <2>;
-			label = "blue:power";
-		};
-		broadband_red {
-			reg = <3>;
-			active-low;
-			label = "red:broadband";
-		};
-		broadband_green {
-			reg = <4>;
-			label = "green:broadband";
-		};
-		broadband_blue {
-			reg = <5>;
-			active-low;
-			label = "blue:broadband";
-		};
-		wireless_red {
-			reg = <6>;
-			active-low;
-			label = "red:wireless";
-		};
-		wireless_green {
-			reg = <7>;
-			active-low;
-			label = "green:wireless";
-		};
-		wireless_blue {
-			reg = <8>;
-			label = "blue:wireless";
-		};
-		phone_red {
-			reg = <9>;
-			active-low;
-			label = "red:phone";
-		};
-		phone_green {
-			reg = <10>;
-			active-low;
-			label = "green:phone";
-		};
-		phone_blue {
-			reg = <11>;
-			label = "blue:phone";
-		};
-		upgrading_red {
-			reg = <12>;
-			active-low;
-			label = "red:upgrading";
-		};
-		upgrading_green {
-			reg = <13>;
-			active-low;
-			label = "green:upgrading";
-		};
-		upgrading_blue {
-			reg = <14>;
-			label = "blue:upgrading";
-		};
-	};

---
base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
change-id: 20250923-brcm6358-to-dt-a69fa1228512

Best regards,
-- 
Harrison Carter <hcarter@thegoodpenguin.co.uk>


