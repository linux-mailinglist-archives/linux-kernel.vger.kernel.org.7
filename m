Return-Path: <linux-kernel+bounces-869501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB95C08050
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9663BD0B2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC3B2EE60F;
	Fri, 24 Oct 2025 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxmA8dUr"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F352ECD11
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337132; cv=none; b=PQTRVbrv/KVQFCf6LuWHQ5v4u2omoZb44F8mB0E92IbZdGLCPcAhqkceqhMkXZ8n4a9cSWIetA1teNSLZ7c4ji7W8pOdgU2h3ovnzFRVdvWKahZg0QtvtYHPTz6wM8B3fPuvGcn+VVkAQRMAiVPqZX6hY027lTuChzqDTsG5Umw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337132; c=relaxed/simple;
	bh=xzeajHU88X/j8qmmF4wCNYhCJXTFYwPN/gwRvvmOIF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMjCH0JZ93Q+go9ZU2vbsiYYaEfDhji5sHSXD7RqvqbrUQuxetzxWkXzCs6+jYiLGVgEXtIGXwyZFtWP84JLRoKgPhm65EUOWA+H6tS/uUcbN8/AcwPPVIzqUWlOa6PhTv/OqYbZ/chHGGzUWQJkdYd+59Ig64RzLlRqhBKgoqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxmA8dUr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2907948c1d2so26612455ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761337130; x=1761941930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mULeKvf0F77oOsPwMwj1L2TcDIvBV1sd5+vGF7TuRug=;
        b=BxmA8dUrWfyckFT4sccdd39AAMYWrLc2scKw0pahB3F2Zx/KyQsHn40Kjw1oQz7edw
         ckE6BWQfGNcFDd4lua377wTb2f7DtMa5tBQrtS9jq2MFqxaXTWnIWUAIDD4lxcLbvzpC
         UG9GWZ40FPTbUi/+24ieg7d0h4T3emMt6n4tJ6n7VckF4bIDxt8BY1Z5my5Gm6EkuORy
         KnYnd7wlT8lxiVFSpWngjumuZTXxuXiaG8KhPO6wanNbu3l6gentmSpJpTw5RbqO9CyQ
         jyUEe4a5E1RmUfbX0XG83sZwHVJE5iVet6SiaND/l6fJryc/DmqUCeJzzEhf4S8YTjfZ
         RtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761337130; x=1761941930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mULeKvf0F77oOsPwMwj1L2TcDIvBV1sd5+vGF7TuRug=;
        b=NLeuP6xxS6JEOtJyp+yHdAen0DX2QB6x8FuQX1aUfE8L5RTLTrr/FHU5Qk0xWPKXc1
         x7ExSubVed5Hj+uy6GjBboC/kTMYzYhetu5mRY1kDdFjw0xfeQQ/ccklPbDVvFkBgDh3
         HeLvvUGw4fEvZRstWIWU/ILXSs4wlbejmgB4VNQiEyB8y20H9wsHTnf7Jo7p5xB1Vw7k
         OKiat2VtDDIgYNO7n79ZD8NJZnfbDeqRER9+adrwbavXhR8HC1P3+MK0mio+sJoIAu5i
         6mUvT5RHW9B+D+4QYgNF5UZmLRCQn2Dv/Wx1gSm9dbilSh7rp/CIPd9iBuKRzgv6O33r
         WYFA==
X-Forwarded-Encrypted: i=1; AJvYcCWGAZUs2Fv9vMof8lnHJ+5I/aY/B4w75UU2+rgIp9cg+WFsZGXVGle10XOtYHjSLFJuAND8IseozjB64KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykbmhCGl6idvWvdilB1Y6BSbItehdd2hvFpdvNJCO1YYZz4Zcn
	QrYgddg3REiKq/qy+QGQirj66EThi/Kq2s4vfZUkADCtPp5wceJlWc99
X-Gm-Gg: ASbGncve2tTKEOKSr7WWMs8Vzq8IT1jtF1AoCu1oOibctxZz3ctd2OsfUJ2xAWvdfyn
	k/RAjTRAjyqzMnz8pMypJm2sjqrYi7m2cXl20O6uRmhlXR1IF84YDyR2NHWUW92AuKO3O95Gmc/
	oH/ePR7JOii/YRMtq0pXdgDuVii9r57Q8wIf1t3deCmWGUBkMYdVA2Kwb5ei4BpCcsPy01BMRiw
	xdrAc8fn/+9b0peW0k+iiHufyf96/55hle1tTHvMPA8+KjtQGqcY+/9CumJYKgBgoqJL6duM19q
	FOrMZyiRpNvqY/odRHCKQOino1rqb1IBdj8M3SvX0pxUYpWlgM0X7hZ2Nr+o6pi+pw/EP6MLu3R
	q6fLrEh/SgCK/xZacHH710IXtn2rfHHQCcd3GOX4HFbADg4Z/scYON6SSJcnUGixqHPb57KZ4nE
	dWmU609I3SvWW5nhgb+1E=
X-Google-Smtp-Source: AGHT+IE9jd7vtBcY2c6pPj+57JlvFNINYbSym1DDgY0wDk1VwaBVHA91I/tEwz5h57TtdV3dR82zFg==
X-Received: by 2002:a17:903:249:b0:262:2ae8:2517 with SMTP id d9443c01a7336-2946de489e0mr82382125ad.5.1761337129759;
        Fri, 24 Oct 2025 13:18:49 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:ef2:acef:f95:a35c:ca2d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42f5csm747695ad.104.2025.10.24.13.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:18:48 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next] dt-bindings: net: phy: vsc8531: Convert to DT schema
Date: Fri, 24 Oct 2025 21:18:36 +0100
Message-ID: <20251024201836.317324-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Convert VSC8531 Gigabit ethernet phy binding to DT schema format. While
at it add compatible string for VSC8541 PHY which is very much similar
to the VSC8531 PHY and is already supported in the kernel. VSC8541 PHY
is present on the Renesas RZ/T2H EVK.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Inspired from the DT warnings seen while running dtbs check [0],
took an opportunity to convert this binding to DT schema format.
As there was no entry in the maintainers file Ive added myself
as the maintainer for this binding.
[0] https://lore.kernel.org/all/176073765433.419659.2490051913988670515.robh@kernel.org/

Note,
1] dt_binding_check reports below warnings. But this looks like
the same for other DT bindings too which have dependencies defined.
./Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml:99:36: [warning] too few spaces after comma (commas)
<path>/mscc-phy-vsc8531.example.dtb: ethernet-phy@0 (ethernet-phy-id0007.0772): 'vsc8531' is a dependency of 'vsc8531,edge-slowdown'
	from schema $id: http://devicetree.org/schemas/net/mscc-phy-vsc8531.yaml
<path>/mscc-phy-vsc8531.example.dtb: ethernet-phy@0 (ethernet-phy-id0007.0772): 'vddmac' is a dependency of 'vsc8531,edge-slowdown'
2] As there is no entry in maintainers file for this binding, Ive added myself
as the maintainer for this binding.
---
 .../bindings/net/mscc-phy-vsc8531.txt         |  73 ----------
 .../bindings/net/mscc-phy-vsc8531.yaml        | 125 ++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +-
 3 files changed, 126 insertions(+), 74 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
 create mode 100644 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml

diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
deleted file mode 100644
index 0a3647fe331b..000000000000
--- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-* Microsemi - vsc8531 Giga bit ethernet phy
-
-Optional properties:
-- vsc8531,vddmac	: The vddmac in mV. Allowed values is listed
-			  in the first row of Table 1 (below).
-			  This property is only used in combination
-			  with the 'edge-slowdown' property.
-			  Default value is 3300.
-- vsc8531,edge-slowdown	: % the edge should be slowed down relative to
-			  the fastest possible edge time.
-			  Edge rate sets the drive strength of the MAC
-			  interface output signals.  Changing the
-			  drive strength will affect the edge rate of
-			  the output signal.  The goal of this setting
-			  is to help reduce electrical emission (EMI)
-			  by being able to reprogram drive strength
-			  and in effect slow down the edge rate if
-			  desired.
-			  To adjust the edge-slowdown, the 'vddmac'
-			  must be specified. Table 1 lists the
-			  supported edge-slowdown values for a given
-			  'vddmac'.
-			  Default value is 0%.
-			  Ref: Table:1 - Edge rate change (below).
-- vsc8531,led-[N]-mode	: LED mode. Specify how the LED[N] should behave.
-			  N depends on the number of LEDs supported by a
-			  PHY.
-			  Allowed values are defined in
-			  "include/dt-bindings/net/mscc-phy-vsc8531.h".
-			  Default values are VSC8531_LINK_1000_ACTIVITY (1),
-			  VSC8531_LINK_100_ACTIVITY (2),
-			  VSC8531_LINK_ACTIVITY (0) and
-			  VSC8531_DUPLEX_COLLISION (8).
-- load-save-gpios	: GPIO used for the load/save operation of the PTP
-			  hardware clock (PHC).
-
-
-Table: 1 - Edge rate change
-----------------------------------------------------------------|
-| 		Edge Rate Change (VDDMAC)			|
-|								|
-| 3300 mV	2500 mV		1800 mV		1500 mV		|
-|---------------------------------------------------------------|
-| 0%		0%		0%		0%		|
-| (Fastest)			(recommended)	(recommended)	|
-|---------------------------------------------------------------|
-| 2%		3%		5%		6%		|
-|---------------------------------------------------------------|
-| 4%		6%		9%		14%		|
-|---------------------------------------------------------------|
-| 7%		10%		16%		21%		|
-|(recommended)	(recommended)					|
-|---------------------------------------------------------------|
-| 10%		14%		23%		29%		|
-|---------------------------------------------------------------|
-| 17%		23%		35%		42%		|
-|---------------------------------------------------------------|
-| 29%		37%		52%		58%		|
-|---------------------------------------------------------------|
-| 53%		63%		76%		77%		|
-| (slowest)							|
-|---------------------------------------------------------------|
-
-Example:
-
-        vsc8531_0: ethernet-phy@0 {
-                compatible = "ethernet-phy-id0007.0570";
-                vsc8531,vddmac		= <3300>;
-                vsc8531,edge-slowdown	= <7>;
-                vsc8531,led-0-mode	= <VSC8531_LINK_1000_ACTIVITY>;
-                vsc8531,led-1-mode	= <VSC8531_LINK_100_ACTIVITY>;
-		load-save-gpios		= <&gpio 10 GPIO_ACTIVE_HIGH>;
-        };
diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml
new file mode 100644
index 000000000000..60691309b6a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/mscc-phy-vsc8531.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microsemi VSC8531 Gigabit Ethernet PHY
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description:
+  The VSC8531 is a Gigabit Ethernet PHY with configurable MAC interface
+  drive strength and LED modes.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-id0007.0570 # VSC8531
+          - ethernet-phy-id0007.0772 # VSC8541
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ethernet-phy-id0007.0570 # VSC8531
+          - ethernet-phy-id0007.0772 # VSC8541
+      - const: ethernet-phy-ieee802.3-c22
+
+  vsc8531,vddmac:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The VDDMAC voltage in millivolts. This property is used in combination
+      with the edge-slowdown property to control the drive strength of the
+      MAC interface output signals.
+    enum: [3300, 2500, 1800, 1500]
+    default: 3300
+
+  vsc8531,edge-slowdown:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Percentage by which the edge rate should be slowed down relative to
+      the fastest possible edge time. This setting helps reduce electromagnetic
+      interference (EMI) by adjusting the drive strength of the MAC interface
+      output signals. Valid values depend on the vddmac voltage setting
+      according to the edge rate change table in the datasheet.
+      For vddmac=3300mV valid values are 0, 2, 4, 7, 10, 17, 29, 53. (7 recommended)
+      For vddmac=2500mV valid values are 0, 3, 6, 10, 14, 23, 37, 63. (10 recommended)
+      For vddmac=1800mV valid values are 0, 5, 9, 16, 23, 35, 52, 76. (0 recommended)
+      For vddmac=1500mV valid values are 0, 6, 14, 21, 29, 42, 58, 77. (0 recommended)
+    enum: [0, 2, 3, 4, 5, 6, 7, 9, 10, 14, 16, 17, 21, 23, 29, 35, 37, 42, 52, 53, 58, 63, 76, 77]
+    default: 0
+
+  vsc8531,led-0-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: LED[0] behavior mode. See include/dt-bindings/net/mscc-phy-vsc8531.h
+      for available modes.
+    minimum: 0
+    maximum: 15
+    default: 1
+
+  vsc8531,led-1-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: LED[1] behavior mode. See include/dt-bindings/net/mscc-phy-vsc8531.h
+      for available modes.
+    minimum: 0
+    maximum: 15
+    default: 2
+
+  vsc8531,led-2-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: LED[2] behavior mode. See include/dt-bindings/net/mscc-phy-vsc8531.h
+      for available modes.
+    minimum: 0
+    maximum: 15
+    default: 0
+
+  vsc8531,led-3-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: LED[3] behavior mode. See include/dt-bindings/net/mscc-phy-vsc8531.h
+      for available modes.
+    minimum: 0
+    maximum: 15
+    default: 8
+
+  load-save-gpios:
+    description: GPIO phandle used for the load/save operation of the PTP hardware
+      clock (PHC).
+    maxItems: 1
+
+dependencies:
+  vsc8531,edge-slowdown: [ vsc8531,vddmac ]
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/net/mscc-phy-vsc8531.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@0 {
+            compatible = "ethernet-phy-id0007.0772", "ethernet-phy-ieee802.3-c22";
+            reg = <0>;
+            vsc8531,vddmac = <3300>;
+            vsc8531,edge-slowdown = <7>;
+            vsc8531,led-0-mode = <VSC8531_LINK_1000_ACTIVITY>;
+            vsc8531,led-1-mode = <VSC8531_LINK_100_ACTIVITY>;
+            load-save-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 54ba517d7e79..1af57177a747 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -20,7 +20,7 @@ patternProperties:
   "^(keypad|m25p|max8952|max8997|max8998|mpmc),.*": true
   "^(pciclass|pinctrl-single|#pinctrl-single|PowerPC),.*": true
   "^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*": true
-  "^(simple-audio-card|st-plgpio|st-spics|ts),.*": true
+  "^(simple-audio-card|st-plgpio|st-spics|ts|vsc8531),.*": true
   "^pool[0-3],.*": true
 
   # Keep list in alphabetical order.
-- 
2.43.0


