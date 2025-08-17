Return-Path: <linux-kernel+bounces-772640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98302B2952F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 23:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADA2189979D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 21:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0437B2D5C86;
	Sun, 17 Aug 2025 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQVrV9tg"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE2A21B9FD;
	Sun, 17 Aug 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755466803; cv=none; b=kS3EXedg85r758Ush943ruGvddraFBdILltsfxNIRFmfujV+h8sUN6mmC4DM/zNIe7wYq60zgCVXz9L3IXhKLunsoqXq8IwQcZ/4a2LdQFgWD8m6AaetQqEBH2473hMyt+1mSvEwB8flG1C/Jmu4yjK/tQJ2EUANbSwDCpWT7yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755466803; c=relaxed/simple;
	bh=hcg956TPIVdk5bcqGXoSuHPPurJL2czejHJxdt01Pwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cjgTzw4i8HCvgy4Od520YmizB7p8B7n/4SzzYdOGipLyG+KgUyAQo6cMdwSfJwmpl47B3f10wVK1LWJkgkEPTpeUlBHg1M/GUvuvAmvjFjSm2VD/lX8eP/ataSDZ5Mo6atIIWeREm0ctoJEcUIWbuhf9IBgKSjpIbJ1a5zZmMfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQVrV9tg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b00797dso21466195e9.0;
        Sun, 17 Aug 2025 14:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755466799; x=1756071599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vmglsrYNRpTXNRkzmUdRZibvhrsSGSBGGVp3ZAPgflc=;
        b=aQVrV9tgV/EvPhlvXP/RSFFLtN+l49MRc9NEdyZY1zrh3rrEpxOWbh05l5m4bnfA8k
         kapSdVWz6eBARKJg1qXZqrF5bWDf62GstzvGWPt7+ROjWSP6G50rhlh1uVqbVJS53DOH
         xe66+yFgZUXrVGI8xEOp5Fr0b55qHAVpTFppPHevOCevcDL9VtMZOH7XAI+sErfKyVCW
         iGMCAsQMzPF/BU2THHwz1plasYB03KuLIzMQ1B7FVttR9h4Y/MigIkap20VD7mMLojo3
         AETrcoZVnm/8dz+7/8A7r/goJOXRbA+tRtSm0JTu05qosnmzIUziPH3yJ7xtDA9IjU8E
         hQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755466799; x=1756071599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmglsrYNRpTXNRkzmUdRZibvhrsSGSBGGVp3ZAPgflc=;
        b=aAl5X2d2v0SlQpI1C1nEZUj69i8florCEH8TFwHTzfSkeEUkoScMY+MLgC93pGvwvA
         vL8EcWj0JMEg2obxfVdHxk/9ZEqVe74gKwOupPrZOKDtMKOSkaixOFXI78zJLI9n1f6l
         QPzgOxTvXvTTUECpm8qiAJS8N1xbnEIGtDCYE0AwXDR1UHlVyIKE6+diCOTuknVCPEr8
         sjSInWbruvXhboCYTNBO18muTHqylHC3QyTEupLMoRIAoUdM5KGJU995g6I92OhPM1mU
         r00s6WGWCP5DClxt/5FSYRZ2fqMNypbnYpFLdA9OUgIdlDhFMc0K48SZvnUY8lEJbi3/
         DMRw==
X-Forwarded-Encrypted: i=1; AJvYcCU3nmtJyAJROvhkRR/ZIGZ7Nbqm7zowLKKM9qu8BuAE5ndFe4WRawoimgZyQiYonSJqeiFMEWpfumGS@vger.kernel.org, AJvYcCWMHZ7vuYN+oonSt45bUGqC9jF663N22rhG6nKHJjtnM6hsHhGJZzG0hvpSfB/bJ9S4tX189SPRqd2my/B8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+hetC4TSqdS2KYTUz6w/1VfcZcJqiSg7TV3QRTff1uo245Rp
	ihGyq49/zNAhQeREAk408PKgML7D9zIT7QuawXuNFT7C3NBdMxEN0Yg=
X-Gm-Gg: ASbGncsnbWyUgfg/4fUNRR39NMkq3kYUNvUd5BGvccYn/KWug8L08FVG72HRsDYDzwf
	PgjgrCdDfUilJNLHGPBLJBzVj95xmfgikFz/xdQl+EpyqAFyYZSnMWJfgtUCMXE6jmx8dVMDNP5
	xJegJKUkZjBj94paIZYuqglZmYBXYETk/2ZvW2x1dT2TSF6sg+RRp/Sr85zuNhUvTw591oXuTD+
	oUexDyEVgCc4PT+ICvgmvb5tdI4Z7xXkhzxlLE25vbT1e/mflgKYW8LjUuGu1KIYqC6OhVqRjSE
	7yJQe5SisypvUR7o4Le4dynVjhrZlOG9abXU4qXSPCJvLglu0N5DLDjyWCEMOA/ThhD/anlTY0m
	t4UacsdkxxlKo0KNKJwJ1uU7OSXrGUobjIF2rEEn+/+Ec
X-Google-Smtp-Source: AGHT+IHlffkfXYmFgZ99Ms0EE74mCwJYNuWa5D88JjRViMcV6nhqvFjX/Ra5mSu4fcXcys4EePGJ0A==
X-Received: by 2002:a05:6000:248a:b0:3a4:fb7e:5fa6 with SMTP id ffacd0b85a97d-3bb66564b33mr7036010f8f.1.1755466799298;
        Sun, 17 Aug 2025 14:39:59 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:55e:d28f:a860:8af:5c69:4d9d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6816ee9fsm11005008f8f.59.2025.08.17.14.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 14:39:58 -0700 (PDT)
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
Subject: [PATCH v4] mfd: dt-bindings: ti,twl6040: convert to DT schema
Date: Sun, 17 Aug 2025 23:38:43 +0200
Message-Id: <20250817213843.46397-1-jihed.chaibi.dev@gmail.com>
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


