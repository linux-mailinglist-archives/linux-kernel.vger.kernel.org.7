Return-Path: <linux-kernel+bounces-771653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AC0B28A16
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 04:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA7E171B24
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA69278F3A;
	Sat, 16 Aug 2025 02:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKyC69cE"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A5B1E49F;
	Sat, 16 Aug 2025 02:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755311775; cv=none; b=lvQBdw+QirmZw1gHNmE258cVXw/rifPEyUUWAF7sz048jpDuSKU/4zcv1HnW9Gxp6iUosXiPtjdw/3iu+fH0F1lSmjyaa9aN5G4YZfJx7380hFSSgh7hMRUX4dySUewbS1UybGcbTs020dY/SEmq72TRigI9qTszHZYQKd+b1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755311775; c=relaxed/simple;
	bh=3nQME40gvM8W6BwP5sBQwhr0YN3vk4QP8nR+VqStULY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=npd4uqXqcpenmgO5GNjCUFMT97qoxtOr7h8C7rG41hpco7ONdLIHjqaKGsdBj4a4mZXVzuhSWrsLaktKwsZiWZSRYaKuxTegGAuAO7ZO7eeQMH2cHGJstZhMumfvSqcFnep77fkNaxElnPSyS0AYXPuUJH2jmpzfA65RsabrWt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKyC69cE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9dc5c6521so1585461f8f.1;
        Fri, 15 Aug 2025 19:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755311772; x=1755916572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4M9ZyI6DowTCxonjTpizTCoCn6lmBq4WzieG8vFe7sE=;
        b=SKyC69cEenhP3xhWQWWbBZldPjZN9CLQ6/EpvXznMP0sbOTA8LvpDDDVhPRs0rBnsD
         dmxZkcg+y0Loket4Q3zwatmasMW00V7BVJtPYSvxadpwr0If1kN3CHx9dqYXinrVO+3A
         dDZ74uXqFsMYiQ1AWTv6u6RLVz5pvcBscGxoDNB+Fkg2o7QalABDUcgpGSkxAKn53xfq
         knwJkkMX239DZJtw0Ch93LwXQtbuZdvbHgVUtMUHsVBv2o4vvoBC4ReUTWPPbngpTxhO
         xk22P0oKPJLR2FW25yapskVd/2mgrsgkEjz1e17NXqu4wvJv9eFY/laXDPRgmYsy2ZEd
         fCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755311772; x=1755916572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4M9ZyI6DowTCxonjTpizTCoCn6lmBq4WzieG8vFe7sE=;
        b=QIgUe3quK7CJK9ZL/Kkfpg6NUcpYhNGbLh3YfzUJyICxjJ0XjLAgEQvljptS1Cxuy9
         pSOo4zNcR02NG0YC3bXgcZ4u3tvuNJ600bj7GZf9fJFyyuab2APha+CMgrsDCtnKDdUX
         elM7vamiI0UmrdVo3KuJUpv+rInE6r2HS86Yp/19zhbD892L19HZy8ofFYvpE21dptXv
         fWV23JvtTjXyGrv0QPsEI6xW0z/q7uCacfgtmpISHzK8fr6iZzOXTua9nHJfe3Olg9Oa
         TCX9CeNvF4esq71XLSeRL41eGOdy9hzzt73qYhFMmfluoGEFgHytNJ3BAitvEensRz83
         0opQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK6bvp3CxhumIk4Qh6oRorBQ2g7P/DMFskFuXoyIVyymsNJYC+uuPZM/rbiuo7zv9FVmMv23GVJ8830I2N@vger.kernel.org, AJvYcCWNY9Y8ld7VXeoWnTbOfmAhJ0+KQKcgJ8pNC45F+L0rchSlUZN2GJOyv+hoEgODi8BeXT2/mAXG05Lv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4tfrn0/673uC77MtZUiDdTDZPrnRqzhTezNgTEMXw7hL4kM44
	nt3eiMEJR9L/Bp+QnxKIM6qQy5L5ABy7oZs+E/TQVZlYQTPWNf6/OHQ=
X-Gm-Gg: ASbGncvdedukWoK6cTt9qmtdGXPoFPw2bY4ZpQMj8+BH+/i3RYtmhgb56Gljctj/a0t
	naZRQK+NMCtz0mleDU0hzRFlnHMq7wgPV4h3ZGhcf/lIJG1sueYeZlk9fEO9OT9Ai5m/7Hvhmmu
	qvTpSkDMQ3AtYnag0KcrKWd53j458LR5S403MGuxIdONyQZK+oo7pir9kGVsSpQwQtE8NmZE+o9
	P8iNk20xi25CIc3PjQdytCRxrfiu0gZbB0h7jzTC0phwSMqk8gOhV5klp2BeTi02cN/oSZvHlXU
	SLJ78/adA1DDmkenT6I8cZiLV4z+PX9VR58SFeCi38FeVrW80goKzj/z/qIqqSgkGUNVIRX4h9E
	nhepdn65eMPPWc7UueCW+AZmhIftE/Xqcf3KAdCXj4WEloIo=
X-Google-Smtp-Source: AGHT+IGaAKxSyahe4X7ye9LwU0bGzvLyikS4pBbTpwkuQUkuER5idUuQkE99J64paUrkLwVW9urFaQ==
X-Received: by 2002:a05:6000:26d0:b0:3b7:89c2:463c with SMTP id ffacd0b85a97d-3bb68734babmr2804049f8f.29.1755311771325;
        Fri, 15 Aug 2025 19:36:11 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:212f:1af8:ee74:5774:2fc2:70a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb5d089e07sm3949856f8f.0.2025.08.15.19.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 19:36:10 -0700 (PDT)
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
Subject: [PATCH] mfd: dt-bindings: ti,twl6040: convert to DT schema
Date: Sat, 16 Aug 2025 04:33:30 +0200
Message-Id: <20250816023330.173349-1-jihed.chaibi.dev@gmail.com>
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

The unused 'twl6040,audpwron-gpio' property has been dropped from
the schema as it is not used by the driver.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../devicetree/bindings/mfd/ti,twl6040.yaml   | 149 ++++++++++++++++++
 .../devicetree/bindings/mfd/twl6040.txt       |  67 --------
 2 files changed, 149 insertions(+), 67 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl6040.txt

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl6040.yaml b/Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
new file mode 100644
index 000000000..c8922fce4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
@@ -0,0 +1,149 @@
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
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      twl6040: twl@4b {
+        compatible = "ti,twl6040";
+        reg = <0x4b>;
+
+        interrupts = <0 119 4>;
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


