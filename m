Return-Path: <linux-kernel+bounces-834185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78546BA423B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6057B2E85
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC5D2FB976;
	Fri, 26 Sep 2025 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvkrRJjQ"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28981D5154
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896368; cv=none; b=COWeJp06XBVTNlwJH8pazceyReHM+/VI8R8DA9/zMN5Lj99T2gt7RHU575dgqKR4gMU/+XiBwA6+DpvIyWQ1UGhysDlW8OQTIlD/8mHgDg3j3i5OnbjS+EXbPwM+oBYAUT7qGhRAh3VO+PHoEnwVj5yaj1VFVOXwBiF06+GuSFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896368; c=relaxed/simple;
	bh=qR2a+sIy1dcLg4TApO3hcXxTpdtuA3Glq5C890ldghM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jf0kkJpCb9H/m73VMVMEjzQYR3foH1raeRrK0oi1Z5IxXmXYJt015aCKSvNTkxa0OrbaDe4pkH608SjFDeLm37VjozhbRKQTBp/7A/0i2TiKONWGFOIFDxEDpjsjLhfgh5hfqHCOwOq/YJHbu0lF6TvqmXOeunbW+DV07gRhSI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvkrRJjQ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4de584653cfso6853791cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758896363; x=1759501163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mRRNbCZTXtY9rhLVn7v5LDS/spOOkK98V0GNyagck8=;
        b=PvkrRJjQ4oNJLZGf5EyCtF68/3fyal4UdAIK5/WTnVfvbkP9leAbCpL2kGz8UDF7B9
         WEDAZinJTTJq70pBz1K15VCTWM1zaz8w/z93VUhD0s4YiKQKHalo3fgmKZbZVAgxjhsf
         vOQBT4zGPW8o2KJsHZQcSfW7bH1eVRfMUBmqCNAYol63ViRoEzoQ2stpsCj0tovp6WHq
         +kp7jn/bwXjYSZSy/ESPDKsctEmUzqttYsbn83IOLxT18su0sTwjQCGJhRQBEmps5Ixa
         4JvBFmuO1tHgor5DBoBkbj8r3c8O9z36Ad/VrWMagw3YU7bpsgEVeaz2Aup4+4uQW8gY
         wuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758896363; x=1759501163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mRRNbCZTXtY9rhLVn7v5LDS/spOOkK98V0GNyagck8=;
        b=Pi3qmoCBJfI6vyZogxlLXXZ1xWh63adOwQOOpQrxisv76q31C6bbLhMSgIwRu/ZeXW
         18rslPZVdJEGdyte5aTrA/BnOS7/Ki1f0ZOE8n/JMUfzPFN0vJpyiMLs9T3v1iTkE9WC
         /d7LWykvFiEpQSbwES9BBPnJcL/cV7Ak32zVWL3jrwMK1XqR24PQQNvIcuVxX1xKUYP0
         YlOLwrGK+hNkypyqLB86G5tp3r7YgoFYqxt74bDIuvXfAuNBgt5j14whchaofCjXiwz7
         m8MTJ0zGnpdj29Qzeh/3TUVpGjlZgoCCH1xBFhmEraWtljx92OWfrbTNWPvyB4HRY4R2
         0E/g==
X-Gm-Message-State: AOJu0YydgBJWYOaxGnvtW5cQ5tQHQv5+u/KHh/scbFG25u3pHH0c7FQs
	7EfJ6hhwKnCmxlZ7wAWAOacrGWqxYii+VGm+iaQXiwLdgmCoZpKlsPk5
X-Gm-Gg: ASbGncsj01iwQndhNnnUClIaPY9SUB5g0DfpCEq/I1kMQZYv3xKq3LN8xdTmQwjQ9jz
	kJVXppQ/QnvEbsRKS+me3kYtiNjG88Q2rBzEeCTGoadWnvnz5qBfXFIx5PLNUaD3cJBrUTGSEZA
	rHjzbPynnego7eLEZ4laS1P7ZwUCK6oDwosmaDTOFE0DE3jbXlpzmVFZ1D8f0vN6rW8bXSX/9ad
	TW9YR/KiYmnVaMf7zKG6O0Y/49mcYR7SwkLIIICycbparKKEyIOzAgYYnNF90eTOXeL+y38zfw8
	v7b6RmAnpWx4KSqmYUm5YyMsl0yEfJpzTrL6T/5fqvuifNS8oYM7w+LTYeaDQn7FMCKMsGFI6bg
	CKmFgEV94FpsVgth7Y+7Sfcu/kzkYM+GQ3mCaHOr3jnBBwPhL+wSkmj6Qi9l5SrTSW1MWeHKwsi
	C+r90YEQGg5+4f8A==
X-Google-Smtp-Source: AGHT+IEQRquuaaARqWA3ptXlfqCpzgIfaknBU2dPbrE0a9uXyM4/oQ1KfvORDQ1cqWtH62rjngjY+Q==
X-Received: by 2002:ac8:5fd3:0:b0:4d3:a453:c503 with SMTP id d75a77b69052e-4da4e099ef0mr105385861cf.84.1758896359975;
        Fri, 26 Sep 2025 07:19:19 -0700 (PDT)
Received: from localhost (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b9458e1sm26078801cf.15.2025.09.26.07.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 07:19:19 -0700 (PDT)
From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 3/7] dt-bindings: auxdisplay: add Titan Micro Electronics TM16xx
Date: Fri, 26 Sep 2025 10:19:04 -0400
Message-ID: <20250926141913.25919-4-jefflessard3@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926141913.25919-1-jefflessard3@gmail.com>
References: <20250926141913.25919-1-jefflessard3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add documentation for TM16xx-compatible 7-segment LED display controllers
with keyscan.

Signed-off-by: Jean-François Lessard <jefflessard3@gmail.com>
---

Notes:
    The 'segments' property is intentionally not vendor-prefixed as it
    defines a generic hardware description concept applicable to any
    7-segment display controller. The property describes the fundamental
    grid/segment coordinate mapping that is controller-agnostic and could
    be reused by other LED matrix display bindings. Similar to how 'gpios'
    describes GPIO connections generically, 'segments' describes segment
    connections in a standardized way using uint32-matrix format.
    
    The property uses explicit coordinate pairs to handle real-world
    hardware variations. Some board manufacturers use standard layouts
    (same grid, different segments per digit) while others use transposed
    layouts (same segment, different grids per digit). The coordinate-pair
    approach accommodates both patterns without requiring separate arrays
    or boolean flags, as confirmed acceptable by DT maintainers.

 .../bindings/auxdisplay/titanmec,tm16xx.yaml  | 463 ++++++++++++++++++
 MAINTAINERS                                   |   5 +
 2 files changed, 468 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/titanmec,tm16xx.yaml

diff --git a/Documentation/devicetree/bindings/auxdisplay/titanmec,tm16xx.yaml b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm16xx.yaml
new file mode 100644
index 000000000000..d324023bbffb
--- /dev/null
+++ b/Documentation/devicetree/bindings/auxdisplay/titanmec,tm16xx.yaml
@@ -0,0 +1,463 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/auxdisplay/titanmec,tm16xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Auxiliary displays based on TM16xx and compatible LED controllers
+
+maintainers:
+  - Jean-François Lessard <jefflessard3@gmail.com>
+
+description: |
+  LED matrix controllers used in auxiliary display devices that drive individual
+  LED icons and 7-segment digit groups through a grid/segment addressing scheme.
+  Controllers manage a matrix of LEDs organized as grids (columns/banks in
+  vendor datasheets) and segments (rows/bit positions in vendor datasheets).
+  Maximum brightness and grid/segment indices are controller-specific.
+  Controller-specific maximum are validated in the driver.
+
+  The controller is agnostic of the display layout. Board-specific LED wiring is
+  described through child nodes that specify grid/segment coordinates for
+  individual icons and segment mapping for 7-segment digits.
+
+  The bindings use separate 'leds' and 'digits' containers to accommodate
+  different addressing schemes:
+  - LEDs use 2-cell addressing (grid, segment) for matrix coordinates
+  - Digits use 1-cell addressing with explicit segment mapping
+
+  The controller node exposes a logical LED-like control for the aggregate
+  display brightness. Child nodes describe individual icons and 7-seg digits.
+  The top-level control supports only label and brightness-related properties
+  and does not support other common LED properties such as color or function.
+  Child LED nodes use the standard LED binding.
+
+  Optional keypad scanning is supported when both 'linux,keymap' and
+  'poll-interval' properties are specified.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fdhisi,fd628
+              - princeton,pt6964
+              - wxicore,aip1628
+          - const: titanmec,tm1628
+      - items:
+          - enum:
+              - wxicore,aip1618
+          - const: titanmec,tm1618
+      - items:
+          - enum:
+              - fdhisi,fd650
+              - wxicore,aip650
+          - const: titanmec,tm1650
+      - enum:
+          - fdhisi,fd620
+          - fdhisi,fd655
+          - fdhisi,fd6551
+          - titanmec,tm1618
+          - titanmec,tm1620
+          - titanmec,tm1628
+          - titanmec,tm1638
+          - titanmec,tm1650
+          - winrise,hbs658
+
+  reg:
+    maxItems: 1
+
+  label:
+    description:
+      The label for the top-level LED. If omitted, the label is taken from the
+      node name (excluding the unit address). It has to uniquely identify a
+      device, i.e. no other LED class device can be assigned the same label.
+
+  max-brightness:
+    minimum: 0  # 0=off
+    maximum: 8  # Maximum across all TM16xx controllers
+    description:
+      Normally the maximum brightness is determined by the hardware and this
+      property is not required. This property is used to put a software limit
+      on the brightness apart from what the driver says, as it could happen
+      that a LED can be made so bright that it gets damaged or causes damage
+      due to restrictions in a specific system, such as mounting conditions.
+
+  default-brightness:
+    minimum: 0  # 0=off
+    maximum: 8  # Maximum across all TM16xx controllers
+    description:
+      Brightness to be set if LED's default state is on. Used only during
+      initialization. If the option is not set then max brightness is used.
+
+  digits:
+    type: object
+    description: Container for 7-segment digit group definitions
+    additionalProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^digit@[0-9]+$":
+        type: object
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            description:
+              Digit position identifier numbered sequentially left-to-right,
+              with reg=0 representing the leftmost digit position as displayed
+              to the user.
+            maxItems: 1
+
+          segments:
+            $ref: /schemas/types.yaml#/definitions/uint32-matrix
+            description: |
+              Array of grid/segment coordinate pairs for each 7-segment position.
+              Each entry is <grid segment> mapping to standard 7-segment positions
+              in order: a, b, c, d, e, f, g
+
+              Standard 7-segment layout:
+                 aaa
+                f   b
+                f   b
+                 ggg
+                e   c
+                e   c
+                 ddd
+            items:
+              items:
+                - description: Grid index
+                - description: Segment index
+            minItems: 7
+            maxItems: 7
+
+        required:
+          - reg
+          - segments
+
+  leds:
+    type: object
+    description: Container for individual LED icon definitions
+    additionalProperties: false
+
+    properties:
+      "#address-cells":
+        const: 2
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^led@[0-9]+,[0-9]+$":
+        type: object
+        $ref: /schemas/leds/common.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            description:
+              Grid and segment indices as <grid segment> of this individual LED icon
+
+        required:
+          - reg
+
+dependencies:
+  poll-interval:
+    - linux,keymap
+  linux,keymap:
+    - poll-interval
+  autorepeat:
+    - linux,keymap
+    - poll-interval
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/leds/common.yaml#
+    properties:
+      color: false
+      function: false
+      function-enumerator: false
+  - $ref: /schemas/input/input.yaml#
+  - $ref: /schemas/input/matrix-keymap.yaml#
+  # SPI controllers require 3-wire (combined MISO/MOSI line)
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fdhisi,fd620
+              - fdhisi,fd628
+              - princeton,pt6964
+              - titanmec,tm1618
+              - titanmec,tm1620
+              - titanmec,tm1628
+              - titanmec,tm1638
+              - wxicore,aip1618
+              - wxicore,aip1628
+    then:
+      $ref: /schemas/spi/spi-peripheral-props.yaml#
+      properties:
+        spi-3wire: true
+      required:
+        - spi-3wire
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    // I2C example: Magicsee N5 TV box with fd655 controller
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      display@24 {
+        reg = <0x24>;
+        compatible = "fdhisi,fd655";
+
+        digits {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          digit@0 {
+            reg = <0>;
+            segments = <1 3>, <1 4>, <1 5>, <1 0>, <1 1>, <1 2>, <1 6>;
+          };
+          digit@1 {
+            reg = <1>;
+            segments = <2 3>, <2 4>, <2 5>, <2 0>, <2 1>, <2 2>, <2 6>;
+          };
+          digit@2 {
+            reg = <2>;
+            segments = <3 3>, <3 4>, <3 5>, <3 0>, <3 1>, <3 2>, <3 6>;
+          };
+          digit@3 {
+            reg = <3>;
+            segments = <4 3>, <4 4>, <4 5>, <4 0>, <4 1>, <4 2>, <4 6>;
+          };
+        };
+
+        leds {
+          #address-cells = <2>;
+          #size-cells = <0>;
+          led@0,0 {
+            reg = <0 0>;
+            function = LED_FUNCTION_ALARM;
+          };
+          led@0,1 {
+            reg = <0 1>;
+            function = LED_FUNCTION_USB;
+          };
+          led@0,2 {
+            reg = <0 2>;
+            function = "play";
+          };
+          led@0,3 {
+            reg = <0 3>;
+            function = "pause";
+          };
+          led@0,4 {
+            reg = <0 4>;
+            function = "colon";
+          };
+          led@0,5 {
+            reg = <0 5>;
+            function = LED_FUNCTION_LAN;
+          };
+          led@0,6 {
+            reg = <0 6>;
+            function = LED_FUNCTION_WLAN;
+          };
+        };
+      };
+    };
+
+  - |
+    #include <dt-bindings/input/input.h>
+
+    // SPI example: TM1638 module with keypad support
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      display@0 {
+        reg = <0>;
+        compatible = "titanmec,tm1638";
+        spi-3wire;
+        spi-lsb-first;
+        spi-max-frequency = <500000>;
+
+        label = "tm1638";
+        default-brightness = <2>;
+        max-brightness = <4>;
+        poll-interval = <100>;
+        linux,keymap = <MATRIX_KEY(2, 0, KEY_F1)
+                        MATRIX_KEY(2, 2, KEY_F2)
+                        MATRIX_KEY(2, 4, KEY_F3)
+                        MATRIX_KEY(2, 6, KEY_F4)
+                        MATRIX_KEY(2, 1, KEY_F5)
+                        MATRIX_KEY(2, 3, KEY_F6)
+                        MATRIX_KEY(2, 5, KEY_F7)
+                        MATRIX_KEY(2, 7, KEY_F8)>;
+
+        digits {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          digit@0 {
+            reg = <0>;
+            segments = <7 0>, <7 1>, <7 2>, <7 3>, <7 4>, <7 5>, <7 6>;
+          };
+
+          digit@1 {
+            reg = <1>;
+            segments = <6 0>, <6 1>, <6 2>, <6 3>, <6 4>, <6 5>, <6 6>;
+          };
+
+          digit@2 {
+            reg = <2>;
+            segments = <5 0>, <5 1>, <5 2>, <5 3>, <5 4>, <5 5>, <5 6>;
+          };
+
+          digit@3 {
+            reg = <3>;
+            segments = <4 0>, <4 1>, <4 2>, <4 3>, <4 4>, <4 5>, <4 6>;
+          };
+
+          digit@4 {
+            reg = <4>;
+            segments = <3 0>, <3 1>, <3 2>, <3 3>, <3 4>, <3 5>, <3 6>;
+          };
+
+          digit@5 {
+            reg = <5>;
+            segments = <2 0>, <2 1>, <2 2>, <2 3>, <2 4>, <2 5>, <2 6>;
+          };
+
+          digit@6 {
+            reg = <6>;
+            segments = <1 0>, <1 1>, <1 2>, <1 3>, <1 4>, <1 5>, <1 6>;
+          };
+
+          digit@7 {
+            reg = <7>;
+            segments = <0 0>, <0 1>, <0 2>, <0 3>, <0 4>, <0 5>, <0 6>;
+          };
+        };
+
+        leds {
+          #address-cells = <2>;
+          #size-cells = <0>;
+
+          led@0,7 {
+            reg = <0 7>;
+          };
+
+          led@1,7 {
+            reg = <1 7>;
+          };
+
+          led@2,7 {
+            reg = <2 7>;
+          };
+
+          led@3,7 {
+            reg = <3 7>;
+          };
+
+          led@4,7 {
+            reg = <4 7>;
+          };
+
+          led@5,7 {
+            reg = <5 7>;
+          };
+
+          led@6,7 {
+            reg = <6 7>;
+          };
+
+          led@7,7 {
+            reg = <7 7>;
+          };
+        };
+      };
+    };
+
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    // SPI example: X96 Max with transposed layout (fd628 with tm1628 fallback)
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      display@0 {
+        reg = <0>;
+        compatible = "fdhisi,fd628", "titanmec,tm1628";
+        spi-3wire;
+        spi-lsb-first;
+        spi-max-frequency = <500000>;
+
+        digits {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          digit@0 {
+            reg = <0>;
+            segments = <0 7>, <1 7>, <2 7>, <3 7>, <4 7>, <5 7>, <6 7>;
+          };
+          digit@1 {
+            reg = <1>;
+            segments = <0 6>, <1 6>, <2 6>, <3 6>, <4 6>, <5 6>, <6 6>;
+          };
+          digit@2 {
+            reg = <2>;
+            segments = <0 5>, <1 5>, <2 5>, <3 5>, <4 5>, <5 5>, <6 5>;
+          };
+          digit@3 {
+            reg = <3>;
+            segments = <0 4>, <1 4>, <2 4>, <3 4>, <4 4>, <5 4>, <6 4>;
+          };
+        };
+
+        leds {
+          #address-cells = <2>;
+          #size-cells = <0>;
+          led@0,3 {
+            reg = <0 3>;
+            function = "apps";
+          };
+          led@1,3 {
+            reg = <1 3>;
+            function = "setup";
+          };
+          led@2,3 {
+            reg = <2 3>;
+            function = LED_FUNCTION_USB;
+          };
+          led@3,3 {
+            reg = <3 3>;
+            function = LED_FUNCTION_SD;
+          };
+          led@4,3 {
+            reg = <4 3>;
+            function = "colon";
+          };
+          led@5,3 {
+            reg = <5 3>;
+            function = "hdmi";
+          };
+          led@6,3 {
+            reg = <6 3>;
+            function = "video";
+          };
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f6206963efbf..9449dfc43a15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25441,6 +25441,11 @@ W:	http://sourceforge.net/projects/tlan/
 F:	Documentation/networking/device_drivers/ethernet/ti/tlan.rst
 F:	drivers/net/ethernet/ti/tlan.*
 
+TM16XX-COMPATIBLE LED CONTROLLERS DISPLAY DRIVER
+M:	Jean-François Lessard <jefflessard3@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/auxdisplay/titanmec,tm16xx.yaml
+
 TMIO/SDHI MMC DRIVER
 M:	Wolfram Sang <wsa+renesas@sang-engineering.com>
 L:	linux-mmc@vger.kernel.org
-- 
2.43.0


