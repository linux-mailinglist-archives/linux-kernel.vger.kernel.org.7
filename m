Return-Path: <linux-kernel+bounces-763211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED25B211FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F9852071E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808782E3393;
	Mon, 11 Aug 2025 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFWlJLc0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7E2E2EF0;
	Mon, 11 Aug 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928796; cv=none; b=mUMyw/EqQ/gZTn+YvoIYaGRlg/1k2J09J4OaU0IFvH1cg4MmAMZmJw0Xt0I1J3yOYdw5JgXG9q2NRkVvaJmuXUw+J6W9Fljqh5pfWzy6BHEXr2F2jv4woJ/npTW3k9+Yqj/8LZ0ZRrKO87E0nR+6aGLgONem2rcJh+GEAsGIsEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928796; c=relaxed/simple;
	bh=OFIAxfCdVqiwI0BnVxFp7HK/cM2fOF129WyqjM+1rZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLpm4mdE7zuQXykc/HtQl3O97d3uNmz5M64wk0CMD4hfkT9nIpRWBTYl8TRw0JxeiSXKmvlzoxESLp6rvZHMSpxMueedEkgzR4UN5wDArkh0ldL32XlMfqwctGo9xRjAl3DVoB+xl/qi10X0wgDp0e2lxlRYTz0As9e7cyNBYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFWlJLc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45D28C4CEF9;
	Mon, 11 Aug 2025 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754928796;
	bh=OFIAxfCdVqiwI0BnVxFp7HK/cM2fOF129WyqjM+1rZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JFWlJLc0rhHglycTVAytmDXIZDciSyTdToUPpiBkG+yv28BdJFm9GGtPJZ9BQQcWG
	 T8m6DtisdzHDlIz6fSd3CYKbkxzWoTmCDxdwCUhaKyOiv874n5cYZNiTqiK6Vb23Ke
	 TteEcdAAE5KtvxaX06mEhA4WIW/ekbMkQtxIPYAvm3qJmr1lEwj5UVs2G57TTOLxA/
	 scigtsegiWiAykiG6sUdevsW2Z3l4H8fXZSNr0X5vU4j+cIdwy202YhJC4IMj5iNxF
	 efnNx7zXdOVaFGpaAd4igXUXUv4DJ+8gru7vcxqdY60nZRdFZjeGVowqSh3KXX9+Lj
	 GravrAJayNMrA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35579CA0ED3;
	Mon, 11 Aug 2025 16:13:16 +0000 (UTC)
From: Gregory Fuchedgi via B4 Relay <devnull+gfuchedgi.gmail.com@kernel.org>
Date: Mon, 11 Aug 2025 09:13:16 -0700
Subject: [PATCH v2 2/2] dt-bindings: hwmon: update TI TPS23861 bindings
 with per-port schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-hwmon-tps23861-add-class-restrictions-v2-2-ebd122ec5e3b@gmail.com>
References: <20250811-hwmon-tps23861-add-class-restrictions-v2-0-ebd122ec5e3b@gmail.com>
In-Reply-To: <20250811-hwmon-tps23861-add-class-restrictions-v2-0-ebd122ec5e3b@gmail.com>
To: Robert Marko <robert.marko@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Gregory Fuchedgi <gfuchedgi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754928795; l=3382;
 i=gfuchedgi@gmail.com; s=20250811; h=from:subject:message-id;
 bh=xpxZZVQduuI8ZuEwYXxZY5dWL1ZqA8Vhj1NRk9pc398=;
 b=m5Lxo8KQLpI997ER/UiJ0xI+2VYJHDsJ2jPXs0/xlemcSbFSNwbzrZoWx4dDYFdjq1q4uE6ve
 l3OImKrhu0KA1/5bHCH47MTf4EbQlfBUO1UkgJQg5uzrlwDRuvQmCqp
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
 .../devicetree/bindings/hwmon/ti,tps23861.yaml     | 86 ++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
index ee7de53e19184d4c3df7564624532306d885f6e4..578f4dad7eab630b218e9e30b23fc611a760d332 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
@@ -24,12 +24,62 @@ properties:
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
+    description: Optional GPIO for the reset pin.
+    maxItems: 1
+
+  shutdown-gpios:
+    description: |
+      Optional GPIO for the shutdown pin. Used to prevent PoE activity before
+      the driver had a chance to configure the chip.
+    maxItems: 1
+
+  interrupts:
+    description: |
+      The interrupt specifier. Only required if PoE class is restricted to less
+      than class 4 in the device tree.
+    maxItems: 1
+
+patternProperties:
+  "^port@[0-3]$":
+    type: object
+    description: Port specific nodes.
+    unevaluatedProperties: false
+    required:
+      - reg
+
+    properties:
+      reg:
+        description: Port index.
+        items:
+          minimum: 0
+          maximum: 3
+
+      class:
+        description: The maximum power class a port should accept.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 4
+
+      off-by-default:
+        description: Indicates the port is off by default.
+        type: boolean
+
+      label:
+        description: Optional port label
+
 required:
   - compatible
   - reg
@@ -51,3 +101,39 @@ examples:
             shunt-resistor-micro-ohms = <255000>;
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        tps23861@28 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "ti,tps23861";
+            reg = <0x28>;
+            shunt-resistor-micro-ohms = <255000>;
+            reset-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+            shutdown-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <14 0>;
+            label = "my_poe_controller";
+            port@0 {
+                    reg = <0>;
+                    class = <2>; // Max PoE class allowed.
+                    off-by-default;
+                    label = "myport";
+            };
+            port@1 {
+                    reg = <1>;
+                    status = "disabled";
+            };
+            port@2 {
+                    reg = <2>;
+                    status = "disabled";
+            };
+            port@3 {
+                    reg = <3>;
+                    status = "disabled";
+            };
+        };
+    };

-- 
2.43.0



