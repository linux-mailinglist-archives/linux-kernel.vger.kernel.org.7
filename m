Return-Path: <linux-kernel+bounces-772641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6FFB29532
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 23:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1338C3BA67B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 21:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1143B2459FB;
	Sun, 17 Aug 2025 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHAhRwcR"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1EB149E17;
	Sun, 17 Aug 2025 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755467573; cv=none; b=bQAaXwEkOc9B4IRkQrxmAi0YO6AHNisF561NUvRkjf0TKv26OOMNEtVD3WV0vclNIFol9yRUex79B8RbOcQWRbNnuRYWBqMAjzjUK+NANo0QUABRhXiIyFNIhm8PlRnIXRZE3SS7PJmUHSyMxiRrJd5H4YODnJqbahoreQPjyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755467573; c=relaxed/simple;
	bh=JSAWqEaZvCzrKkYij1uGZzVtgT3IZ8ZQWNIaQ2TjScY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=USmH7d4E2pJhwcryMZi5DVb6yU0lhJeE2iSxI6pjnO1BhhEoY9LoGewUzOga57GKPtx3vMjOW5zJ848l7Ri3sdknXVZUuShz24W9TmIXrOY58llOVFA24pjo2JFVXl/rDrRgJf7vCJcA8lfNq4VFsr/vpyKJZzqLUnfH57GYTZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHAhRwcR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b00e4a1so22771245e9.0;
        Sun, 17 Aug 2025 14:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755467569; x=1756072369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c4/fnEGcbHPQa6LaRwLATBTPLNoN3B9wqwWCiNpBDeM=;
        b=nHAhRwcR9QIOTA+stN05DQOeAUFPO5hLtpOwUl1IAKog8G6pQwW7kawCxniZ9eh0XP
         5wsf/C4grnXzI6B5bs6i02Xug+2ZaJUR1F35QEjxfumyFTdjSJ5OrfdGcuvLewP0fBFW
         JKBHvxnjIiND3dh3yGdr2rSuYjl4OBeKSyEZAb91tb3LH7dgraaMjp45OKastxRPTDq3
         TlOEvq/YVZtQe6VOLLxhgxOZ1l3DIWbRyjDFr5n+ymu8x2mhtLy+A1iqdUFVLkHSDk0V
         lHVUZmHeymXFDdWimADGAuYLBaDoS6rBILR3W73ecNLjMuY026eS1eRUmmLLfjhdOmTJ
         8xCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755467569; x=1756072369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4/fnEGcbHPQa6LaRwLATBTPLNoN3B9wqwWCiNpBDeM=;
        b=sIIk5Si7NvmiV1w2kqsatqLkh6D4XVaCJgqLNSMXu9HWF1VQnLcwPDci9mJ7jpPaqN
         RnZ0fKOdyEaxAqADPQMA2Sk0uq3luQ9f0MZIBGrRiJzw+d1yI3c5s7tyP21IbLZ7NM6y
         v9UG54LiCTnXAbgMdkQJAX68rvNPFFq882s06n1VtyQVctwYKnqaLXczgViFMKi0zgM5
         xpb43xfX/Hur1rAfKicV03lJsYTDHDMLroMj7lqR5cy7w7lrSLVdPQHT3JkU4nrfm7Hn
         MYuNRZuy6eK1RJBNQqJAEi1guXjbEZPfSZIXfEhWA51Lo15Zj8FPqZ6P32MzopC8Ne7m
         BsOA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Q2smfaKVVieV8sxWIPK+d4z18ANqMtYMKD0dgMQhlSpHfFDmed/66fhfGtJ5AkIXSGLwZpGHukJp@vger.kernel.org, AJvYcCVPxIzR5gQUzntncFGPnnhbIAqw7SFfbJWT4H8JIXDqY6PHdmtfpEL2vlmDa6NyY4oysq724uDz6m3QHzP4@vger.kernel.org
X-Gm-Message-State: AOJu0YzgPj1kpcJig2zW9AJpO9xNU27rnNUGj+DdAAnOVxAjY3pCN/g/
	dWzbscyHrXe4Jn2dNnMFN/wgrdj5WPYG/vdn4nM+z+PWPbNWdUUtvzY=
X-Gm-Gg: ASbGncu4UQbuclhxNWxpy9jfRkObb+6YRuk2F95SFNBuvdd9KyhMuFE2LdMcp+QswU/
	d3kKbLSmMA10GLIP5HKqUENeJFj0ms01XZeeuJss6xoLYGtAphLEg0dolA0f4v7g1cAn8Hl1AGE
	9gDL9lCFt/f4v1FC8c4ewgAXjxS23AbHnv06cPkWc3cDldiC2MZfoz0n6mHiNeE2tQWLvMtN6JR
	wybXLjIf7UPwuksticY2DsAZX97EHF8f+ZV90sqHz9lSWwgx8gWZGMHdU5fWcENMVX8KSM25Bqk
	NfECRmD6I5aH5fePCztzHI7wSSCAZcbwO9sqQIFcxl0spb1sn1hIw/K7l/JrY3NX9OiDJvrE9ce
	EWVTwL3m1gkUj9ZHmU1yphKgfOFJH2jbex53UNu3Rob/t
X-Google-Smtp-Source: AGHT+IHj0/IFlzYMldREBmEo9qvi+sqTJlVZAWQfl7wvlSbuNfs4cTh7du6ZavLqfNRIOLznnbtSVA==
X-Received: by 2002:a05:600c:3510:b0:459:dde3:1a56 with SMTP id 5b1f17b1804b1-45a2185789bmr59888745e9.28.1755467569107;
        Sun, 17 Aug 2025 14:52:49 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:55e:d28f:a860:8af:5c69:4d9d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6863fc29sm10990589f8f.66.2025.08.17.14.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 14:52:48 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: robh@kernel.org,
	lee@kernel.org
Cc: peter.ujfalusi@gmail.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v5] mfd: dt-bindings: ti,twl6040: convert to DT schema
Date: Sun, 17 Aug 2025 23:52:34 +0200
Message-Id: <20250817215234.50904-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the legacy TXT binding for the TWL6040 MFD to the modern YAML
DT schema format. This adds formal validation and improves documentation
for the TWL6040/TWL6041 audio codec, which provides audio, vibra, and GPO
functionality on OMAP4+ platforms.

Key changes:

 - Dropped usage of the 'twl6040,audpwron-gpio' property from the schema
   as it is not used by the driver.
 - Retained 'clocks' and 'clock-names' as flexible (1-2 items) to match
   the original binding's "and/or" phrasing, which allows clk32k, mclk,
   or both.
 - Updated node name to 'audio-codec@4b' to follow generic naming
   conventions per the Device Tree specification.
 - Replaced raw interrupt values with standard defines for clarity.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v5:
 - Add missing changelogs

Changes in v4:
 - Retained 'clocks' and 'clock-names' as flexible (1-2 items) to match
   the original binding's "and/or" phrasing, which sould allow either
   clk32k, mclk, or both.
 - Updated node name to 'audio-codec@4b' to follow generic naming
   conventions per the Device Tree specification.
 - Replaced raw interrupt values with standard defines for clarity.
 - Added clock properties to the example.

Changes in v3:
 - Drop usage of The unused 'twl6040,audpwron-gpio' property from the
   schema as it is not used by the driver.
 - This patch was originally part of a larger series but has been
   sent separately per maintainer feedback.
   v2 (origial patch series) link:
   https://lore.kernel.org/all/20250814132129.138943-3-jihed.chaibi.dev@gmail.com

Changes in v2:
 - Renamed twl6040,audpwron-gpio to ti,audpwron-gpio for consistency
   with TI naming, this fixes the dt_binding_check vendor name  error.
 - Minor description clarifications for improved readability.

Changes in v1:
 - Initial conversion of twl6040.txt to YAML format.
 - v1 link :
   https://lore.kernel.org/all/20250811224739.53869-3-jihed.chaibi.dev@gmail.com/
---
 .../devicetree/bindings/mfd/ti,twl6040.yaml   | 154 ++++++++++++++++++
 .../devicetree/bindings/mfd/twl6040.txt       |  67 --------
 2 files changed, 154 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl6040.txt

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl6040.yaml b/Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
new file mode 100644
index 000000000..20865575f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,twl6040.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL6040/TWL6041 Audio Codec
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description:
+  The TWL6040s are 8-channel high quality low-power audio codecs providing
+  audio, vibra and GPO functionality on OMAP4+ platforms.
+  They are connected to the host processor via i2c for commands, McPDM for
+  audio data and commands.
+
+properties:
+  compatible:
+    enum:
+      - ti,twl6040
+      - ti,twl6041
+
+  reg:
+    const: 0x4b
+
+  interrupts:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 1
+
+  '#clock-cells':
+    description: TWL6040 is a provider of PDMCLK which is used by McPDM.
+    const: 0
+
+  vio-supply:
+    description: Regulator for the VIO supply.
+
+  v2v1-supply:
+    description: Regulator for the V2V1 supply.
+
+  enable-active-high:
+    type: boolean
+    description: If present, powers on the device during boot.
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+    description: Phandle to the clk32k and/or mclk clock providers.
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum: [clk32k, mclk]
+
+  # Vibra functionality :
+
+  vddvibl-supply:
+    description: Regulator for the left vibra motor supply.
+
+  vddvibr-supply:
+    description: Regulator for the right vibra motor supply.
+
+  vibra:
+    type: object
+    description: Node for vibra motor configuration parameters.
+    properties:
+      ti,vibldrv-res:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Resistance parameter for the left driver.
+
+      ti,vibrdrv-res:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Resistance parameter for the right driver.
+
+      ti,viblmotor-res:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Resistance parameter for the left motor.
+
+      ti,vibrmotor-res:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Resistance parameter for the right motor.
+
+      vddvibl_uV:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Optional override for the VDDVIBL default voltage (in uV).
+
+      vddvibr_uV:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Optional override for the VDDVIBR default voltage (in uV).
+    required:
+      - ti,vibldrv-res
+      - ti,vibrdrv-res
+      - ti,viblmotor-res
+      - ti,vibrmotor-res
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - gpio-controller
+  - '#gpio-cells'
+  - '#clock-cells'
+  - vio-supply
+  - v2v1-supply
+  - vddvibl-supply
+  - vddvibr-supply
+  - vibra
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      audio-codec@4b {
+        compatible = "ti,twl6040";
+        reg = <0x4b>;
+
+        interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&gic>;
+
+        gpio-controller;
+        #gpio-cells = <1>;
+        #clock-cells = <0>;
+
+        vio-supply = <&v1v8>;
+        v2v1-supply = <&v2v1>;
+        enable-active-high;
+
+        clocks = <&clk32k>;
+        clock-names = "clk32k";
+
+        /* regulators for vibra motor */
+        vddvibl-supply = <&vbat>;
+        vddvibr-supply = <&vbat>;
+
+        vibra {
+          /* Vibra driver, motor resistance parameters */
+          ti,vibldrv-res = <8>;
+          ti,vibrdrv-res = <3>;
+          ti,viblmotor-res = <10>;
+          ti,vibrmotor-res = <10>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mfd/twl6040.txt b/Documentation/devicetree/bindings/mfd/twl6040.txt
deleted file mode 100644
index dfd8683ed..000000000
--- a/Documentation/devicetree/bindings/mfd/twl6040.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-Texas Instruments TWL6040 family
-
-The TWL6040s are 8-channel high quality low-power audio codecs providing audio,
-vibra and GPO functionality on OMAP4+ platforms.
-They are connected to the host processor via i2c for commands, McPDM for audio
-data and commands.
-
-Required properties:
-- compatible : "ti,twl6040" for twl6040, "ti,twl6041" for twl6041
-- reg: must be 0x4b for i2c address
-- interrupts: twl6040 has one interrupt line connecteded to the main SoC
-- gpio-controller:
-- #gpio-cells = <1>: twl6040 provides GPO lines.
-- #clock-cells = <0>; twl6040 is a provider of pdmclk which is used by McPDM
-- twl6040,audpwron-gpio: Power on GPIO line for the twl6040
-
-- vio-supply: Regulator for the twl6040 VIO supply
-- v2v1-supply: Regulator for the twl6040 V2V1 supply
-
-Optional properties, nodes:
-- enable-active-high: To power on the twl6040 during boot.
-- clocks: phandle to the clk32k and/or to mclk clock provider
-- clock-names: Must be "clk32k" for the 32K clock and "mclk" for the MCLK.
-
-Vibra functionality
-Required properties:
-- vddvibl-supply: Regulator for the left vibra motor
-- vddvibr-supply: Regulator for the right vibra motor
-- vibra { }: Configuration section for vibra parameters containing the following
-	     properties:
-- ti,vibldrv-res: Resistance parameter for left driver
-- ti,vibrdrv-res: Resistance parameter for right driver
-- ti,viblmotor-res: Resistance parameter for left motor
-- ti,viblmotor-res: Resistance parameter for right motor
-
-Optional properties within vibra { } section:
-- vddvibl_uV: If the vddvibl default voltage need to be changed
-- vddvibr_uV: If the vddvibr default voltage need to be changed
-
-Example:
-&i2c1 {
-	twl6040: twl@4b {
-		compatible = "ti,twl6040";
-
-		interrupts = <0 119 4>;
-		interrupt-parent = <&gic>;
-		twl6040,audpwron-gpio = <&gpio4 31 0>;
-
-		vio-supply = <&v1v8>;
-		v2v1-supply = <&v2v1>;
-		enable-active-high;
-
-		/* regulators for vibra motor */
-		vddvibl-supply = <&vbat>;
-		vddvibr-supply = <&vbat>;
-
-		vibra {
-			/* Vibra driver, motor resistance parameters */
-			ti,vibldrv-res = <8>;
-			ti,vibrdrv-res = <3>;
-			ti,viblmotor-res = <10>;
-			ti,vibrmotor-res = <10>;
-		};
-	};
-};
-
-/include/ "twl6040.dtsi"
-- 
2.39.5


