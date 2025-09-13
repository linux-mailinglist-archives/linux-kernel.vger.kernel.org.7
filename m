Return-Path: <linux-kernel+bounces-815108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B69AB55FDD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 11:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0ACA07E49
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 09:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF342E92BB;
	Sat, 13 Sep 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="I1VQxTsh"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA62D5946
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757755634; cv=none; b=UaVrn/ljAgf5IuU6Gx00YC/PGRrlvTgnrKEoSLA071XbDgspHmpkFTEqb7ZTaiRTLWP+aUBURjRsnw7pxame/eY6wjPg/9IRB+qNww0oR0t1J5PnIgM5Gg2liS3vwSBlJy/yN3qHcKaXzy4jIE0ylfams/ds6wctlrFED0RwbUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757755634; c=relaxed/simple;
	bh=AIm6v3p8wKnKa1j4npXfFMAQaKbeZOrZfGfBJrym7R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u9XtxSRUlS62uLgaLE5jwjZp2YS59LtegYGvakG/kMN4CzaE3152CdgwJcpVSKmb+ayr48KDnVLZVMBo+HeuC6uLHyzSfuhr7sAwTWeCl/N5xRAWu6M0va3bom3KfIvUn+tcEvx1yAypp+5WiIZNX+xrPZ1n/+S0DbGFjeUiOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=I1VQxTsh; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62f1987d4b2so210652a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 02:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757755630; x=1758360430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sqXoJTPCt/TEsVffyq8j5TIAdrRKPjQJmGTKxR+1RTc=;
        b=I1VQxTsh+5JX+dD01wJbOjNn3fRZj1WVHNCYNMw0sCiCgETe3BuNlRVZ2+yWKLZvIc
         c92X60h2ixqJIB5FasInXHknhb42xYFpCKpVdJ3lhVxiX6Q7hUTMwSVRO5l50WzEexL0
         VPgdTkYU4Tp5CfrxE0SZWpRNpBOxf/H/7Fe1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757755630; x=1758360430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqXoJTPCt/TEsVffyq8j5TIAdrRKPjQJmGTKxR+1RTc=;
        b=owPbH7HGWaB4Lup3By6B1fSO8mdNbXv8dDPvlNh6f6E/fbP99u7w0WZlI3ta5+W6+D
         MuTSjv4jAHGtmrW7M+DbrIHmzyyE/cRwvGDtcZOigo4g6nf/QxYDDX8uaXrb2qjfqDRU
         tZeUq6hUAKXO+//UYyT1GBmcsOyw5bgn7MZJaY39r1jWvFD+HWJzJ26gU2ND8/JqPlA0
         me9O0GH4rddxsXrjARovQK6rPqy8OO8N7dXjDA+rTGt7K5NSBeucCR8UAdLZFZzEXmxs
         d7d5T0XhUpRf9POjBd/Tq0c8oWndrU3dg/4wVxNFtspZT+G2c3EyO2g8v/R/rf/QKVmw
         x7eg==
X-Gm-Message-State: AOJu0YxM1bTRtYygXNKAh5aOvz9EmEqBzLPX7gD9h6SsnvEgjzs5jNmJ
	dUhbrVTZaiMjMTAd4fRdl8n1I98YLSZ/8WzSgszkgm77g1PLFlia0oFWGM+LLOrOFEfWEPugo1s
	kpRZG
X-Gm-Gg: ASbGnctmVzZjSEntvWVU1feLP1HyAPp7C7msohGo2VdFgIkgNuxmTmDGPn4NTDB6cKx
	Wq0rU3FMkY3dQ0Leh/WkWzqYL5FIpKdFRIgYYDG4Km3pRHSrhJdljjx4nZPg8DPGyi75QWa1Wh+
	t4Fi43zyTK1PC25Ks83L+XGXV5vs9OuqXznos23JncRy709JVekZCyZWbA8Hg689jq2/W6kwf7l
	rvHS7iIbvzBcTyXXdQUNNhagM/QgdW39lqXjoJJTg2HL980ErVOJcVhzfSCTBT496djdp8EsQ0Z
	1l9R4C9ot9W+xdmx6cRRpjh17Uozy4zzai4dx1dzYbCC+nFXyi8jng1wBw+hRzOeL9CiEp5LR/2
	RroaXTrzHdM/JhsqpTaWE1s3kv0/ClB2/ovHbHsRqShMpV32ubUD+RTBopyLxo3ZTYQq7M5H7YZ
	rrhkH7q5f5ydS0sV/ikz9eegB3WNSynhvDcT+dZ1yQzP8W/afmfmSU9yNYb5CF9NRj
X-Google-Smtp-Source: AGHT+IG1AZMTx8jwmHsi9JreMHXlOmk0ndpPX03YXoaqCXIRz9MQz7XfAjOe96yGGTUoXrX32mDd6A==
X-Received: by 2002:a17:907:daa:b0:b04:97a2:64f8 with SMTP id a640c23a62f3a-b07c3532805mr587574766b.2.1757755630506;
        Sat, 13 Sep 2025 02:27:10 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b33478besm551705766b.99.2025.09.13.02.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 02:27:10 -0700 (PDT)
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
Subject: [PATCH v2 1/5] dt-bindings: touchscreen: convert bu21013 bindings to json schema
Date: Sat, 13 Sep 2025 11:26:51 +0200
Message-ID: <20250913092707.1005616-1-dario.binacchi@amarulasolutions.com>
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

base-commit: 22f20375f5b71f30c0d6896583b93b6e4bba7279
branch: drop-touchscreen.txt

