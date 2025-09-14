Return-Path: <linux-kernel+bounces-815875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2164DB56C2E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 22:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8479417AAA4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3352E2286;
	Sun, 14 Sep 2025 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YxrRqjYu"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC12586CE
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757882308; cv=none; b=Su3flkJLtvIY7SKZ3OVR/o/hkbcJdjw3xmSGuNk47TqSTEPTtL/GIeyS2qB1hhT1lSwWHOO7KheOBCHPVRzm05fmOytDP99RgDmHia7IH0ANqwtPVsTCskmTWrowR/MZUkDMtAOhh9AdC7fhNXPPaDbNcSXHEaFQWlhfW3Pqtt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757882308; c=relaxed/simple;
	bh=riIk5A7/k5jmzqe4kgCxsQ3TRBKkwDnZsBjQ/+gseWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VF/Lu1alzqTl0kSz2MRrXI6jUTcGJkoKtQtOVdXG9WLNBqgERZ9LsQK1ovFypVAEnFzgE2fSyp2XUHbpE2NM0JZIPg1NCOrFtXKLhy78f0Tl0Zxg5q1aZ6NjYkWn6zoG9o7jMEjOYX+JRQc6q5gpltl+2pdl+z15gnOQG2UhFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=YxrRqjYu; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0418f6fc27so602967166b.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757882304; x=1758487104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9VY5ykh5wKPdVnX3qXAuw1qQOw6UnVjhurc+WIYVtA=;
        b=YxrRqjYujKbbBZ7FBQu8Jj6j9NSiIO9g+ZuOlzPBGGc0o1Pw9THlb2yVVO0Q4brtNA
         PiAr31PDNJ3FuApAPFXWmhrFDn7PIzrlDXy5RbzVLgYC6AzJcsGYYpQ5Xk3QJ54Otvmp
         Tw/SUkx79AgIVy3GQ0JTpSyCrd1uG9jOPTPh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757882304; x=1758487104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9VY5ykh5wKPdVnX3qXAuw1qQOw6UnVjhurc+WIYVtA=;
        b=eqdc41ezr/BC5uEY19/PtVU0fHLEluUeEbzwJ270ikP+lkS7ou+cUhpl7pT02hhpX/
         7ga/QhhSHz2h6P7sz3GkdbLp9NgjZADGhUHWNlYzmn8WsWTYfeSfMqjlZT/7t4BFPoj/
         OOj2bcPC0VFvk2R9KGpiHDddl0MNArf14Gpa8wzMrEfs7ZfOE7Lgv7rNdmzrZAGnXNgg
         ZhmgxkHpAiCMuq3miUompxDqL/XMXYc3IZnRd48KpI4DRC0a7kaf1v185aQIdSo4coFz
         hjcCK8Mrxz1/2BZZ0FteXT9J5gnD11RaaEQkgEnlRVHMNsUJg4+TRvHGyS89Pe1cgTZi
         zIfg==
X-Gm-Message-State: AOJu0Yx1Qwygnt0ngMnCRYatWy6Vk8Or/4qneMhgb+wVx4Odr00Vv0Tp
	jXfZgY0++k5+uO1ZoWbJAsHXC7sFLE+dfMCj941wJrhL6QvZtlXilrjOFKcwtr2mt/Yl3UQ4Xwb
	2OlDY
X-Gm-Gg: ASbGncuf6xzfD3fB7tcNwJ305V1btF12Jv7S+2dFZIXEH7yzA6KIpYo8juBBlK/84vQ
	a9UFLIyXKr/wA1ZIP9o/OmmBPh1K19VyJ99pAsEDeagR4YoeDaYGUEsSTI6gUdcr16u/hc6mW9E
	ndNn3F3lublV5xQqpWgQOMgUzYJ2dmwOttyXqIpUny0ttN+XThsKohkZ/X00bwzMv8VnipAECtA
	2zbTStjc9u3lc57ccMkxpHiXgP2xx02jN59L9r9ke7+zZMGfX4nAZBJePQ3v0NGKP07M7OelVWP
	u41d2oBbvfMpGXaFTU0dJ5E61LtwLeEc91SdJI1gDJLSmA/DwWvTSX9D+SDxvh2e0t1xAtF+5r3
	YSDc4dtPYAp5ba0YAW5RU5/YUJpc4BOJPt2iPmo886hpTxUMLu6dWJ0AxacuZvZWf/gTJy7fxp4
	Jn39FmHKAOM+0221r5t8Qhsj7BvTGDAlJ//Kfk8TP9QpXeLDZEeGE06fvlxvmjBmCAbie3crlSS
	vY=
X-Google-Smtp-Source: AGHT+IF/4Gm9Dk5Vnsm6Kkt9LidjypRjPXxM0EVBYC3sMhD4EIU/3t2fMNVpEOYVtSuXCXWSqxROjg==
X-Received: by 2002:a17:907:9443:b0:b09:d915:1416 with SMTP id a640c23a62f3a-b09d91547c7mr524413566b.54.1757882304362;
        Sun, 14 Sep 2025 13:38:24 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33ad242sm7803739a12.17.2025.09.14.13.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 13:38:24 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v3 1/5] dt-bindings: touchscreen: convert bu21013 bindings to json schema
Date: Sun, 14 Sep 2025 22:37:52 +0200
Message-ID: <20250914203812.1055696-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert Rohm BU21013 I2C touchscreen controller device tree binding to
json-schema.

Additional changes:
- Replace <supply_name>-supply with avdd-supply to match example and
  existing DTS.
- Add reset-gpios in the example because it is required.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v2)

Changes in v2:
- Added in v2

 .../bindings/input/touchscreen/bu21013.txt    | 43 ---------
 .../bindings/input/touchscreen/bu21013.yaml   | 96 +++++++++++++++++++
 2 files changed, 96 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/bu21013.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/bu21013.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/bu21013.txt b/Documentation/devicetree/bindings/input/touchscreen/bu21013.txt
deleted file mode 100644
index da4c9d8b99b1..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/bu21013.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-* Rohm BU21013 Touch Screen
-
-Required properties:
- - compatible              : "rohm,bu21013_tp"
- - reg                     : I2C device address
- - reset-gpios             : GPIO pin enabling (selecting) chip (CS)
- - interrupt-parent        : the phandle for the gpio controller
- - interrupts              : (gpio) interrupt to which the chip is connected
-
-Optional properties:
- - touch-gpios             : GPIO pin registering a touch event
- - <supply_name>-supply    : Phandle to a regulator supply
- - touchscreen-size-x      : General touchscreen binding, see [1].
- - touchscreen-size-y      : General touchscreen binding, see [1].
- - touchscreen-inverted-x  : General touchscreen binding, see [1].
- - touchscreen-inverted-y  : General touchscreen binding, see [1].
- - touchscreen-swapped-x-y : General touchscreen binding, see [1].
-
-[1] All general touchscreen properties are described in
-    Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt.
-
-Deprecated properties:
- - rohm,touch-max-x        : Maximum outward permitted limit in the X axis
- - rohm,touch-max-y        : Maximum outward permitted limit in the Y axis
- - rohm,flip-x             : Flip touch coordinates on the X axis
- - rohm,flip-y             : Flip touch coordinates on the Y axis
-
-Example:
-
-	i2c@80110000 {
-		bu21013_tp@5c {
-			compatible = "rohm,bu21013_tp";
-			reg = <0x5c>;
-			interrupt-parent = <&gpio2>;
-			interrupts <&20 IRQ_TYPE_LEVEL_LOW>;
-			touch-gpio = <&gpio2 20 GPIO_ACTIVE_LOW>;
-			avdd-supply = <&ab8500_ldo_aux1_reg>;
-
-			touchscreen-size-x = <384>;
-			touchscreen-size-y = <704>;
-			touchscreen-inverted-y;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/input/touchscreen/bu21013.yaml b/Documentation/devicetree/bindings/input/touchscreen/bu21013.yaml
new file mode 100644
index 000000000000..aeb581fcaf29
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/bu21013.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/bu21013.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rohm BU21013 touchscreen
+
+description:
+  Rohm BU21013 I2C driven touchscreen controller.
+
+maintainers:
+  - Dario Binacchi <dario.binacchi@amarulasolutions.com>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    enum:
+      - rohm,bu21013_tp
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO resetting the chip
+
+  touch-gpios:
+    maxItems: 1
+    description: GPIO registering a touch event.
+
+  avdd-supply:
+    description: Phandle to the regulator supplying the analog circuit.
+
+  rohm,touch-max-x:
+    deprecated: true
+    description: Maximum value on the X axis.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  rohm,touch-max-y:
+    deprecated: true
+    description: Maximum value on the Y axis.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  rohm,flip-x:
+    deprecated: true
+    description: Flip touch coordinates on the X axis
+    type: boolean
+
+  rohm,flip-y:
+    deprecated: true
+    description: Flip touch coordinates on the Y axis
+    type: boolean
+
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-swapped-x-y: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@5c {
+            compatible = "rohm,bu21013_tp";
+            reg = <0x5c>;
+
+            interrupt-parent = <&gpio2>;
+            interrupts = <0x20 IRQ_TYPE_LEVEL_LOW>;
+            reset-gpios = <&gpio2 19 GPIO_ACTIVE_LOW>;
+            touch-gpios = <&gpio2 20 GPIO_ACTIVE_LOW>;
+            avdd-supply = <&ab8500_ldo_aux1_reg>;
+
+            touchscreen-size-x = <384>;
+            touchscreen-size-y = <704>;
+            touchscreen-inverted-y;
+        };
+    };
-- 
2.43.0

base-commit: df86f912b45c20e236060321c85fe35437e9325d
branch: drop-touchscreen.txt

