Return-Path: <linux-kernel+bounces-801384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ACAB44472
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA263ABD1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002A1311C39;
	Thu,  4 Sep 2025 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUPLasce"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3903023A564;
	Thu,  4 Sep 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007243; cv=none; b=X8wOqsL4MiT1FOkqo4a0ZZhvfD3hJePIeFXhLnZ/4sf/1BSWsriKytIseukOZ9lmIOE9BBcGy/iZjaGMmI66YufGZVlvfyj6m69yCsAUfQ82C4Ciy5Ta96OjIgaALwJZCcv+tk4G7JCknqQdm+T19Dom3tSUczfIdkmSM+GRi6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007243; c=relaxed/simple;
	bh=HYNh1E1vVbwojSYRggjiLHXNaJtU4E5wSRP88yT1/cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dz3x+zabh1RRwE9JIXJvkiqFFegXsBCFIT3+AF8kQpwd8vdPk5bGM5pwkpkiMV1X4QpxOrZ9VPbE/uy24/awMVGi2D2Yv+0najHBT8Hqjxh6wgNDjy2BuXxRr8ON1N0e2nqGCbBXSD5jSWupC5QQq+2WLgwzoJIitXHciktp+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUPLasce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D460AC4CEF6;
	Thu,  4 Sep 2025 17:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757007242;
	bh=HYNh1E1vVbwojSYRggjiLHXNaJtU4E5wSRP88yT1/cc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZUPLasceZgj7fuYu2aoLdoYj8S0ZkGBzIsvlLXAgGkxzsOszT2aX1u2UsAxMFje2G
	 rrDCZae04BtvfbFE3AkdGa+HRwmQ9TKgQ/J4tUwGpS02Zf+0qAqvz+Zhtrew4tocXg
	 vKcoikejbaU7CWczU0VPvvb8EgkcERLBvwhm8A47u5cBSszw4xLOg4c6L3kj3KggXd
	 dzJzriqfsCtbt41ix/6vTdn7nO51d+0YSsv7aCSEdcWGYrnfp18bhJGhbz4n53np+g
	 YupVg1BRXp4e1bfJDYC9LCl/wnQ3Ux8WczU7XZars/FgDCQIGz9O7HPtYxsbdOXsiy
	 NcIKgpWXQZ/4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B1FCA1013;
	Thu,  4 Sep 2025 17:34:02 +0000 (UTC)
From: Gregory Fuchedgi via B4 Relay <devnull+gfuchedgi.gmail.com@kernel.org>
Date: Thu, 04 Sep 2025 10:33:44 -0700
Subject: [PATCH v3 1/2] dt-bindings: hwmon: update TI TPS23861 with
 per-port schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-hwmon-tps23861-add-class-restrictions-v3-1-b4e33e6d066c@gmail.com>
References: <20250904-hwmon-tps23861-add-class-restrictions-v3-0-b4e33e6d066c@gmail.com>
In-Reply-To: <20250904-hwmon-tps23861-add-class-restrictions-v3-0-b4e33e6d066c@gmail.com>
To: Robert Marko <robert.marko@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Gregory Fuchedgi <gfuchedgi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757007242; l=3648;
 i=gfuchedgi@gmail.com; s=20250811; h=from:subject:message-id;
 bh=SKYcjxqEAKKTKyENkgiukshEk5CgSMUj+twbpURzbYg=;
 b=/ilmcY7LFjTKx+CUoGtzhjHpcAqskiBdnOZplChgwKAHiOuiN9z7Bylnp5qTlApxT4UQcWjff
 z6Xjk1QaQy7CeX9mgY5YmCfml+L/B9CvsDySr9xdpyq7o5WNoyC50oR
X-Developer-Key: i=gfuchedgi@gmail.com; a=ed25519;
 pk=J3o48+1a2mUIebH8K4S3SPuR5bmamUvjlsf8onoIccA=
X-Endpoint-Received: by B4 Relay for gfuchedgi@gmail.com/20250811 with
 auth_id=484
X-Original-From: Gregory Fuchedgi <gfuchedgi@gmail.com>
Reply-To: gfuchedgi@gmail.com

From: Gregory Fuchedgi <gfuchedgi@gmail.com>

Update schema after per-port poe class restrictions and a few other options
were implemented.

Signed-off-by: Gregory Fuchedgi <gfuchedgi@gmail.com>
---
 .../devicetree/bindings/hwmon/ti,tps23861.yaml     | 93 +++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
index ee7de53e19184d4c3df7564624532306d885f6e4..7538d1a9c19905ec90c48d34f84a92c1972f566b 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
@@ -24,12 +24,60 @@ properties:
   reg:
     maxItems: 1
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
   shunt-resistor-micro-ohms:
     description: The value of current sense resistor in microohms.
     default: 255000
     minimum: 250000
     maximum: 255000
 
+  reset-gpios:
+    description: GPIO for the reset pin.
+    maxItems: 1
+
+  ti,ports-shutdown-gpios:
+    description:
+      GPIO for the shutdown pin. Used to prevent PoE activity before the driver
+      had a chance to configure the chip.
+    maxItems: 1
+
+  interrupts:
+    description:
+      Only required if PoE class is restricted to less than class 4 in the
+      device tree.
+    maxItems: 1
+
+patternProperties:
+  "^poe-port@[0-3]$":
+    type: object
+    description: Port specific nodes.
+    unevaluatedProperties: false
+    properties:
+      reg:
+        description: Port index.
+        items:
+          maximum: 3
+
+      ti,class:
+        description: The maximum power class a port should accept.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maximum: 4
+
+      ti,off-by-default:
+        description: Indicates the port is off by default.
+        type: boolean
+
+      label:
+        description: Port label.
+
+    required:
+      - reg
+
 required:
   - compatible
   - reg
@@ -45,9 +93,52 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        tps23861@30 {
+        poe_controller@30 {
             compatible = "ti,tps23861";
             reg = <0x30>;
             shunt-resistor-micro-ohms = <255000>;
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        poe_controller@28 {
+            compatible = "ti,tps23861";
+            reg = <0x28>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            shunt-resistor-micro-ohms = <255000>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+            label = "cabinet_poe_controller";
+            reset-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+            ti,ports-shutdown-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+
+            poe-port@0 {
+                    reg = <0>;
+                    ti,class = <2>; // Max PoE class allowed.
+                    ti,off-by-default;
+                    label = "cabinet_port_a";
+            };
+
+            poe-port@1 {
+                    reg = <1>;
+                    status = "disabled";
+            };
+
+            poe-port@2 {
+                    reg = <2>;
+                    status = "disabled";
+            };
+
+            poe-port@3 {
+                    reg = <3>;
+                    status = "disabled";
+            };
+        };
+    };

-- 
2.43.0



