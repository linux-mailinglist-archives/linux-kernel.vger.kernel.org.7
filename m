Return-Path: <linux-kernel+bounces-833017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A9BA0FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DF6382748
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C7D313E1E;
	Thu, 25 Sep 2025 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="jZGGYTzo"
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743081DBB13;
	Thu, 25 Sep 2025 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824259; cv=none; b=gMGBC7CUK5lam4iq2DaYk696ek+Oow1ZbmWr50F2flIVHu9rJJ1BeZ9Q1LR3ooQlxEufneqlHS5u8BfD5qbJGlTyWVdkXPumEWMqN+MWfWuUsvuGT+P1+h985QbyONhcFFfl1s2eVQdrFRIQC1EX9WBErNeOruA2GIwmLtY/p1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824259; c=relaxed/simple;
	bh=PDvaNdqJ1+mA9hszjKY6qIq0/hAsF7yl1BQbUjuhLgc=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=C3rSKzs0pAPstuea6PUTl0jZSB/Ja/brrpuvPOIOktHgL0TNYE7TqYuNYbeD3fJDiN7SSD/99PvB7xfsd/lqSWWcdVpxic3aLOJQSrAN6vg46y2fKAivK+E06ZUIzR1T4owWjejHUMo/CJluoVTxymYh6/laDhR1aXMbrFoC7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=jZGGYTzo; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 5B754828840F;
	Thu, 25 Sep 2025 13:17:35 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id SSnFhtyKuS1e; Thu, 25 Sep 2025 13:17:34 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 034808288415;
	Thu, 25 Sep 2025 13:17:34 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 034808288415
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1758824254; bh=uS8vwIfaxybAC/RZGZPBPkj9ZjZVx37fF4a+ywmY54w=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=jZGGYTzoF+pxsjeTZgMw6HZiGSYfMhheNjhrRJsVUorxg6A9/SfvBFzL+zq1q2X5i
	 Jfrfy6s2BshnRFPYGjvvhLn/44WytKrQL23N1H9VmzusCsM3Lwc8GsHZUSfb4PHQbI
	 UVcZut0sLmEoxgR6xYV4gTbA2MzsXNkE+WE0Qi/A=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id x46fPWwsA3vv; Thu, 25 Sep 2025 13:17:33 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id C0623828840F;
	Thu, 25 Sep 2025 13:17:33 -0500 (CDT)
Date: Thu, 25 Sep 2025 13:17:33 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Lee Jones <lee@kernel.org>, 
	Georgy Yakovlev <Georgy.Yakovlev@sony.com>
Cc: Shawn Anastasio <sanastasio@raptorengineering.com>
Message-ID: <948400747.1748562.1758824253627.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH 1/4] dt-bindings: mfd: Add sony,cronos-cpld
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC139 (Linux)/8.5.0_GA_3042)
Thread-Index: Rh6UGNLUPF1qxdGMOKrvj7kxexnpWw==
Thread-Topic: dt-bindings: mfd: Add sony,cronos-cpld

The Sony Cronos Platform Controller CPLD is a multi-purpose platform
controller that provides both a watchdog timer and an LED controller for
the Sony Interactive Entertainment Cronos x86 server platform. As both
functions are provided by the same CPLD, a multi-function device is
exposed as the parent of both functions.

Add a DT binding for this device.

Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 .../bindings/mfd/sony,cronos-cpld.yaml        | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml

diff --git a/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml b/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
new file mode 100644
index 000000000000..3cebf6c0153d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2025 Raptor Engineering, LLC
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/sony,cronos-cpld.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sony Cronos Platform Controller CPLD multi-function device
+
+maintainers:
+  - Georgy Yakovlev <Georgy.Yakovlev@sony.com>
+
+description: |
+  The Sony Cronos Platform Controller CPLD is a multi-purpose platform
+  controller that provides both a watchdog timer and an LED controller for the
+  Sony Interactive Entertainment Cronos x86 server platform. As both functions
+  are provided by the same CPLD, a multi-function device is exposed as the
+  parent of both functions.
+
+properties:
+  compatible:
+    const: sony,cronos-cpld
+
+  reg:
+    maxItems: 1
+
+  leds:
+    type: object
+    additionalProperties: false
+    description: |
+      The Cronos LED controller is a subfunction of the Cronos platform
+      controller, which is a multi-function device.
+
+      Each led is represented as a child node of sony,cronos-led. Fifteen RGB
+      LEDs are supported by the platform.
+
+    properties:
+      compatible:
+        const: sony,cronos-led
+
+      reg:
+        maxItems: 1
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^multi-led@[0-15]$":
+        type: object
+        $ref: leds-class-multicolor.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            description:
+              LED channel number (0..15)
+            minimum: 0
+            maximum: 15
+
+        required:
+          - reg
+
+    required:
+      - compatible
+      - "#address-cells"
+      - "#size-cells"
+
+  watchdog:
+    type: object
+    description: Cronos Platform Watchdog Timer
+
+    allOf:
+      - $ref: watchdog.yaml#
+
+    properties:
+      compatible:
+        const: sony,cronos-watchdog
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cpld@3f {
+        compatible = "sony,cronos-cpld";
+        reg = <0x3f>;
+
+        watchdog {
+          compatible = "sony,cronos-watchdog";
+          timeout-sec = <20>;
+        };
+
+        leds {
+            compatible = "sony,cronos-led";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            multi-led@0 {
+                /*
+                 * No subnodes are needed, this controller only supports RGB
+                 * LEDs.
+                 */
+                reg = <0>;
+                color = <LED_COLOR_ID_MULTI>;
+                function = LED_FUNCTION_STATUS;
+            };
+        };
+      };
+    };
-- 
2.39.5

