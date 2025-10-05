Return-Path: <linux-kernel+bounces-842348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40959BB98E4
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 17:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5153B8387
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F9F28C037;
	Sun,  5 Oct 2025 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E67Ar/2/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6974286342
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759678470; cv=none; b=DhM7qX6aQf6JO8SWRIZy04shGdZf0e6S12QPEBOn4XJjmHigm99CpdO0SD3Xdl8+UI85S0oTIlWO624jDpmAbGobwxVHT5+nQy378qVoI9iGWvSjCmcF1l+eAMhOySEj7oqZvltR2q+OgH46AnunmG+lkGU+P4GrlyC5gPG7FbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759678470; c=relaxed/simple;
	bh=jvDU90SLOc+78K7dMZENIg1QewfPmCHCCe6gEbTzCZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVbrP1S6+aep0hrOiWK+mU3ZPpxVAXSZgEUnPDen4REB1cWkhQNfX8xTSR6VhkNeYAbGvIEXo8QfjgnVek2WnLBgNW90ogePrDjciA7AbrpiTPYqk6OAoHzJPOkEetM3aVa1d66eWMrEljJaeliK+tV9U8OwPykOhgVUPkiw9DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E67Ar/2/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so56032215ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 08:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759678467; x=1760283267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNk/U6IE8mQbxqdTgBsFaFf/uVyNOzk66GK8x6NhUFE=;
        b=E67Ar/2/xbvq9WJce6DroPiS4PjQkl8rNYqN646mo3DKqPW7o96hJLA3bgQG5otq33
         aEKemoVMXSkVWsrd8Mpv/B6DzoXXU2esExjM9WA1uq0PX1M+Ycr5UZ/BgV6+3Yt4Jtib
         h5fs2udPDyS3GrSjmRxJy6OXfZNejJr4scOQ5fCwndTVclzNL82tk9BJ/kyIG+0sDQ3F
         RRI/0vkZGmXCtvkz7UqLju2SASse2sf4sXnuoJbYoxfhbOFz/pJ2GLkeGhYpde1IbL6A
         AaokXPTJEnlhqJceo6hEhlGkLkW4e9w77dQCzV+8e7+DqiByKyebEkGiHuRkZrz4cLeH
         24Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759678467; x=1760283267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNk/U6IE8mQbxqdTgBsFaFf/uVyNOzk66GK8x6NhUFE=;
        b=Ut8T/suZQWHgdGURip7kzc15D22cXoq3/6rNmKszZJHn0biUSbi5+LMujUN+XxYqtN
         mFnVrycwECyVWmeeNjtUk6ioqNo2VN9TCd1BI9Gcj8llIJsZxEg0795Hay2O+Eea46tT
         NX65CBnhMMIRwiUfL2OaeI8rVwz75TBMMfAP12tNWTGgP1Ohp3eP4ZlbXK2XCwBXUIYh
         K15LPXOCijEaxmBRsiUayR6KvoB16lL7l5FKVJPGHey0usaNSZOKKytaXWWrbIHy+4GH
         oNcouoE12TicSRy/9j6IChfvfukLC852dhAyKuRrbFqQHt8z40j1WF3km8DlKUT+V4vA
         0KWg==
X-Forwarded-Encrypted: i=1; AJvYcCU4P0MHLYzeDJ3serNKITodSGtPlLKgHo4P2vxfuoSWGO5hesLr2tNOKNMkjW1yFMDT4ME+MMRrmeV4gwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOS9I7c00cUu0VYQekL8+X3YF1Eh+0ZBqD5fGhJDhy1a57499M
	Qe1Ne+bZPVT/AxBcbFgmj6S0f5wmv9IPxd+l66G+PIbq3MU6+quv3G8b
X-Gm-Gg: ASbGnctStZ1GC2pkjpKxfvSVWgCSacYeKLvibmkSrcOzSLsiiNMqL8LANsxcnARsAPL
	050qew18t8d2CxcGGub5imX8F/4xZtz2ak8LUddw0iSpZvn7kCL8xqd9sBmwZHg9yzbvVlhN5Ic
	XHKmkX+6Khm3GlcsykqfR5rKlODMlsMhW7Mg0+9TbdzQ8e1LvqKFPPVXZpeWCcykhEMf44ye9Ei
	Xswe66cDrTTmNma/uDhyMTr6YqDZqAaorFdADoldu0VjO56D0bpRBRvHnrLlALxISQtnEVYaedE
	eVzukS2pbXUzhd0W+J8m0V+lQ+yxlzLsYIxGPYe6HXNf5WD2ho963tcKrZfxwzwSIvS7c6w1geh
	nzkxhr2VN4IfJs4rsoHleGjmtholofOoeb//iLFbgXdgkxYhWSZgKZ68=
X-Google-Smtp-Source: AGHT+IFXbfpfbAoB2bwhEvZbvUOaR+Uknsssi4Wg8VDAS21liMVscqEo+1sERzHpiYFDBwYxldGa+g==
X-Received: by 2002:a17:903:2f0e:b0:250:bd52:4cdb with SMTP id d9443c01a7336-28e9a62ff1emr98496115ad.32.1759678467527;
        Sun, 05 Oct 2025 08:34:27 -0700 (PDT)
Received: from DESKTOP-P76LG1N.lan ([58.187.66.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110d9csm105555965ad.2.2025.10.05.08.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 08:34:27 -0700 (PDT)
From: Nam Tran <trannamatk@gmail.com>
To: lee@kernel.org
Cc: pavel@kernel.org,
	gregkh@linuxfoundation.org,
	rdunlap@infradead.org,
	christophe.jaillet@wanadoo.fr,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nam Tran <trannamatk@gmail.com>
Subject: [PATCH v15 1/3] dt-bindings: leds: add TI/National Semiconductor LP5812 LED Driver
Date: Sun,  5 Oct 2025 22:33:35 +0700
Message-Id: <20251005153337.94025-2-trannamatk@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251005153337.94025-1-trannamatk@gmail.com>
References: <20251005153337.94025-1-trannamatk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LP5812 is a 4x3 RGB LED driver with an autonomous animation
engine and time-cross-multiplexing (TCM) support for up to 12 LEDs
or 4 RGB LEDs. It supports both analog (256 levels) and PWM (8-bit)
dimming, including exponential PWM for smooth brightness control.

Signed-off-by: Nam Tran <trannamatk@gmail.com>
---
 .../devicetree/bindings/leds/ti,lp5812.yaml   | 290 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 296 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lp5812.yaml

diff --git a/Documentation/devicetree/bindings/leds/ti,lp5812.yaml b/Documentation/devicetree/bindings/leds/ti,lp5812.yaml
new file mode 100644
index 000000000000..d759ba7a86fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/ti,lp5812.yaml
@@ -0,0 +1,290 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/ti,lp5812.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LP5812 4x3 Matrix RGB LED Driver with Autonomous Control
+
+maintainers:
+  - Nam Tran <trannamatk@gmail.com>
+
+description: |
+  The LP5812 is a 4x3 matrix RGB LED driver with I2C interface
+  and autonomous animation engine control.
+  For more product information please see the link below:
+  https://www.ti.com/product/LP5812#tech-docs
+
+properties:
+  compatible:
+    const: ti,lp5812
+
+  reg:
+    maxItems: 1
+
+  ti,operation-mode:
+    description: |
+      Selects the LED operation mode of the LP5812. The device supports
+      three modes:
+        - Direct-drive mode ("direct_mode") drives up to 4 LEDs directly
+        by internal current sinks (LED0-LED3).
+        - TCM-drive mode ("tcmscan:<n>:<order...>") drives up to 12 LEDs
+        (4 RGB) using 1-4 scan multiplexing. The <n> specifies the number
+        of scans (1-4), and <order...> defines the scan order of the outputs.
+        - Mix-drive mode ("mixscan:<n>:<direct>:<order...>") combines
+        direct-drive and TCM-drive outputs. The <n> specifies the number
+        of scans, <direct> selects the direct-drive outputs, and <order...>
+        defines the scan order.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - direct_mode
+      - tcmscan:1:0
+      - tcmscan:1:1
+      - tcmscan:1:2
+      - tcmscan:1:3
+      - tcmscan:2:0:1
+      - tcmscan:2:0:2
+      - tcmscan:2:0:3
+      - tcmscan:2:1:2
+      - tcmscan:2:1:3
+      - tcmscan:2:2:3
+      - tcmscan:3:0:1:2
+      - tcmscan:3:0:1:3
+      - tcmscan:3:0:2:3
+      - tcmscan:4:0:1:2:3
+      - mixscan:1:0:1
+      - mixscan:1:0:2
+      - mixscan:1:0:3
+      - mixscan:1:1:0
+      - mixscan:1:1:2
+      - mixscan:1:1:3
+      - mixscan:1:2:0
+      - mixscan:1:2:1
+      - mixscan:1:2:3
+      - mixscan:1:3:0
+      - mixscan:1:3:1
+      - mixscan:1:3:2
+      - mixscan:2:0:1:2
+      - mixscan:2:0:1:3
+      - mixscan:2:0:2:3
+      - mixscan:2:1:0:2
+      - mixscan:2:1:0:3
+      - mixscan:2:1:2:3
+      - mixscan:2:2:0:1
+      - mixscan:2:2:0:3
+      - mixscan:2:2:1:3
+      - mixscan:2:3:0:1
+      - mixscan:2:3:0:2
+      - mixscan:2:3:1:2
+      - mixscan:3:0:1:2:3
+      - mixscan:3:1:0:2:3
+      - mixscan:3:2:0:1:3
+      - mixscan:3:3:0:1:2
+
+  vcc-supply:
+    description: Regulator providing power to the 'VCC' pin.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-3]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 3
+
+    required:
+      - reg
+
+  "^multi-led@[4-7]$":
+    type: object
+    $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        minimum: 4
+        maximum: 7
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^led@[4-9a-f]$":
+        type: object
+        $ref: common.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            minimum: 4
+            maximum: 15
+
+        required:
+          - reg
+
+required:
+  - compatible
+  - reg
+  - ti,operation-mode
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@1b {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "ti,lp5812";
+            reg = <0x1b>;
+            ti,operation-mode = "tcmscan:4:0:1:2:3";
+            vcc-supply = <&vdd_3v3_reg>;
+
+            led@0 {
+                reg = <0x0>;
+                label = "LED0";
+                led-max-microamp = <25500>;
+            };
+
+            led@1 {
+                reg = <0x1>;
+                label = "LED1";
+                led-max-microamp = <25500>;
+            };
+
+            led@2 {
+                reg = <0x2>;
+                label = "LED2";
+                led-max-microamp = <25500>;
+            };
+
+            led@3 {
+                reg = <0x3>;
+                label = "LED3";
+                led-max-microamp = <25500>;
+            };
+
+            multi-led@4 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0x4>;
+                color = <LED_COLOR_ID_RGB>;
+                label = "LED_A";
+
+                led@4 {
+                    reg = <0x4>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    led-max-microamp = <25500>;
+                };
+
+                led@5 {
+                    reg = <0x5>;
+                    color = <LED_COLOR_ID_RED>;
+                    led-max-microamp = <25500>;
+                };
+
+                led@6 {
+                    reg = <0x6>;
+                    color = <LED_COLOR_ID_BLUE>;
+                    led-max-microamp = <25500>;
+                };
+            };
+
+            multi-led@5 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0x5>;
+                color = <LED_COLOR_ID_RGB>;
+                label = "LED_B";
+
+                led@7 {
+                    reg = <0x7>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    led-max-microamp = <25500>;
+                };
+
+                led@8 {
+                    reg = <0x8>;
+                    color = <LED_COLOR_ID_RED>;
+                    led-max-microamp = <25500>;
+                };
+
+                led@9 {
+                    reg = <0x9>;
+                    color = <LED_COLOR_ID_BLUE>;
+                    led-max-microamp = <25500>;
+                };
+            };
+
+            multi-led@6 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0x6>;
+                color = <LED_COLOR_ID_RGB>;
+                label = "LED_C";
+
+                led@a {
+                    reg = <0xa>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    led-max-microamp = <25500>;
+                };
+
+                led@b {
+                    reg = <0xb>;
+                    color = <LED_COLOR_ID_RED>;
+                    led-max-microamp = <25500>;
+                };
+
+                led@c {
+                    reg = <0xc>;
+                    color = <LED_COLOR_ID_BLUE>;
+                    led-max-microamp = <25500>;
+                };
+            };
+
+            multi-led@7 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0x7>;
+                color = <LED_COLOR_ID_RGB>;
+                label = "LED_D";
+
+                led@d {
+                    reg = <0xd>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    led-max-microamp = <25500>;
+                };
+
+                led@e {
+                    reg = <0xe>;
+                    color = <LED_COLOR_ID_RED>;
+                    led-max-microamp = <25500>;
+                };
+
+                led@f {
+                    reg = <0xf>;
+                    color = <LED_COLOR_ID_BLUE>;
+                    led-max-microamp = <25500>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 5a2cde903910..38f913ba7a4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25383,6 +25383,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
 F:	drivers/iio/dac/ti-dac7612.c
 
+TEXAS INSTRUMENTS' LP5812 RGB LED DRIVER
+M:	Nam Tran <trannamatk@gmail.com>
+L:	linux-leds@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/leds/ti,lp5812.yaml
+
 TEXAS INSTRUMENTS' LB8864 LED BACKLIGHT DRIVER
 M:	Alexander Sverdlin <alexander.sverdlin@siemens.com>
 L:	linux-leds@vger.kernel.org
-- 
2.25.1


