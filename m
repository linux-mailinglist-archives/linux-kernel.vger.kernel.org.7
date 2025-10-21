Return-Path: <linux-kernel+bounces-863321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D5ABF78BF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0834B4E96A2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48413446A7;
	Tue, 21 Oct 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUHZQz3D"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38C03451B8
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062383; cv=none; b=aT4cEchpLAtgiHh1I/YNZETcqI9EJdWFHVV7Mxe0fzsAwuQWUlfZyxfgXNXRyIefzX416kIgnGknB+mf4ghaIMBVB77yhln4Qo/gmBx44VhFfeYpDfjZ6auyP7YnSbjA9T/NFXpwWROIyKFeZzeP/7tSripjaxEgdmj48yvUxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062383; c=relaxed/simple;
	bh=DVZk9/6Hz1u40oFEn/dvO2HpS/h5DXQYBj9t8pth4is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJTXGv1oIktogGI6uCAAL4EWhj1QXzlrxQMOSh55qdf+4lROYJ/2Bvn+0W0aW+DIrkOExmpDJ2P7vfG1/9mHNLxfPGLQZh3auECAGOfvoQ9bvjDAr79N8p9ebB1WM5Phc3TR3TCvKjxaqP4caOp0pDjC2vuzx00bcWOVk8LsUmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUHZQz3D; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f67ba775aso7491848b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761062381; x=1761667181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BYngmfsv4iOZfMpdOA17S9GKl2RTrHqqlq8fKnQ8GQ=;
        b=OUHZQz3D5cHZsZR8Ksf87Ly0xumBMlW4XsYH6e0hx1gyzwBmvkKrN5rpM6oAFP95Y1
         kQGSAEn+PQTqoO8eBFoB4Ha/s7tHo6SUKFMyMHHoULAsfwZDXNlsqbOZOXOPafJ4MBcx
         EysLHc2nNJwZRKTZTdoJdlH+W2dlzjmCLxOH6MdF1otb69HLU/3QxlXQhjBUrVS10pWu
         mXQMAuHOgWMY0vySwsJtO8ausQqUN9lacOcGCDmxHKFXRsSBWEJLY6J/w19SZg79Phuq
         fFyC454zxkDOWu468mkTnauvX/GdvQnqNytQETdzuBlRdRrRjqs3fWz7uqYVMSjKraLI
         XU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062381; x=1761667181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BYngmfsv4iOZfMpdOA17S9GKl2RTrHqqlq8fKnQ8GQ=;
        b=b+DvM4zzm5olRcTK2BJ0BGqWq/jm0JdqqjK5fw3yPH1FVYr96wqcgkq/rYEEhemP3z
         ivzh/ntlvyewN3WkXFkfAcWJgYLv7/yn5U3fHa4WPChIReoa7eYeBKRR7ZyywZx5fChx
         0s+A1rtiimtVdlYLWyPmc7FF9yVtT8rj9rMnmcyc6clLP6VfWTbeGfhoiF2iQvVeKuK5
         PH+IVtX1SExoBBLjNYKcRIe2SL/ECBawKkP5pyBvqx0GsCunwjJ+z/V8K3GJ8j+CwG23
         617Mf6vGCGtXR6ALyw+99K/S45xoVOBgzpBJIi5dZVFs7VUrM5T9szOfm9R7RVDgB5Yh
         6Eiw==
X-Forwarded-Encrypted: i=1; AJvYcCVgYYS5QGhDWXrz/QmYfsH3jxV8XagD4OpbxWdgKDPssk6YOWTNJ1UTc5ZdK858z/Yg0iIU2ByGly6HdUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5yHDAfy2yd3S1supS8CijQRHIuH08rsU9jvpiVvlZv4tJ8lDh
	4ueqpZcIo65eM6NQiz/uq9MHQ3u9wNthA5KHu7pRlmw5iKolWRYzGl+e
X-Gm-Gg: ASbGncuSOQ2Hacvb8cGp2274eAMcJ2aTRjWg9UpzVm20m246fmj/OTRSQt6qP61adS2
	TOYBEWFAu9OsrRKuszHqtVN68kRaEjHuIwAKC4fxy0bxJKm7MnzqzLIaKy+svNptZ+ceZxUKQXU
	6mBiVm0hR6ZFe07ZlGQ29uuw/JUUJdBj176Dn5lUhppT9fbzLcBoEcATEQSv8lygZpd21QFMlta
	5qMvrzyHDr5eWJfaAo1nSjw2xl+7mEAiASdzoM4GZYBUFIRcNO11F7sfG+ytjXuGzUllOT2M7qA
	oOPSbKnwUWYlBmoFGp0NCxfdqJ7HbsdNWN+KhVzrk3x6irqhzn5nv76DaYpbMuSqyBtgbSCCpVJ
	9H3jMBqCJT9gDki7G8w9qBk86SKltV9xrRR02dVsFLMD5CDt4efOpjoI9g/J6HFtsRU6fYbygys
	JmMT5Mos8IR1zWXkkdORbGKg==
X-Google-Smtp-Source: AGHT+IEtJXtD4SFYx9QJaaRQ/IY2Zd/UHeW3zow+bskDa2aDqwuFyhBsTTMrh4PK8Y00pXXiRosWCQ==
X-Received: by 2002:a05:6a00:2308:b0:792:52ab:d9fe with SMTP id d2e1a72fcca58-7a220440d9fmr21260599b3a.0.1761062381001;
        Tue, 21 Oct 2025 08:59:41 -0700 (PDT)
Received: from DESKTOP-P76LG1N.lan ([42.118.149.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff184basm11793032b3a.15.2025.10.21.08.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:59:40 -0700 (PDT)
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
Subject: [PATCH v17 1/3] dt-bindings: leds: add TI/National Semiconductor LP5812 LED Driver
Date: Tue, 21 Oct 2025 22:59:25 +0700
Message-Id: <20251021155927.140929-2-trannamatk@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021155927.140929-1-trannamatk@gmail.com>
References: <20251021155927.140929-1-trannamatk@gmail.com>
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
 .../devicetree/bindings/leds/ti,lp5812.yaml   | 246 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 252 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lp5812.yaml

diff --git a/Documentation/devicetree/bindings/leds/ti,lp5812.yaml b/Documentation/devicetree/bindings/leds/ti,lp5812.yaml
new file mode 100644
index 000000000000..de34bff441c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/ti,lp5812.yaml
@@ -0,0 +1,246 @@
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
+  ti,scan-mode:
+    description: |
+      Selects the LED scan mode of the LP5812. The device supports
+      three modes:
+        - Direct-drive mode (by default if 'ti,scan-mode' is omitted)
+        drives up to 4 LEDs directly by internal current sinks (LED0-LED3).
+        - TCM-drive mode ("tcm:<n>:<order...>") drives up to 12 LEDs
+        (4 RGB) using 1-4 scan multiplexing. The <n> specifies the number
+        of scans (1-4), and <order...> defines the scan order of the outputs.
+        - Mix-drive mode ("mix:<n>:<direct>:<order...>") combines
+        direct-drive and TCM-drive outputs. The <n> specifies the number
+        of scans, <direct> selects the direct-drive outputs, and <order...>
+        defines the scan order.
+    $ref: /schemas/types.yaml#/definitions/string
+    pattern: '^(tcm|mix):[1-4](:[0-3]){1,4}$'
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
+            ti,scan-mode = "tcm:4:0:1:2:3";
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
index 545a4776795e..6a84f999ef73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25424,6 +25424,12 @@ S:	Supported
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


