Return-Path: <linux-kernel+bounces-861497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B91DDBF2E13
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34AD134E4B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624BB2C2363;
	Mon, 20 Oct 2025 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="V3iFOIQz"
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C35354AF9;
	Mon, 20 Oct 2025 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983924; cv=none; b=Gcv+MGB0h5n34ffEL0BJaSpjXdn+ZX5vqQr/QMjR2xhHzoecsfouykl3ieanBSqNYi1JKfWQz/m7TmG6FG75/cXlEeTH/VZ32REwBi43DA/Nd7Uu2/k03QjXamhjpunWq89KgzsTp6w5bFNDBb5l+OYpJpL95udegAOTZXz/vQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983924; c=relaxed/simple;
	bh=9LFSjI4Ix7/aUYjBMN7LqoivdXj24EYcO/ebz6HRSBE=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=OQ3ePu9MiBR7lgK9cqEOCiWsIbNC4XN1KofRrz7s35zThrN3elqfUdmxwfqu7LRRthfnloQuO85Rx59aLrZH6nAYXaMu7C4e/TELspIK7o3N3DR9uhUR1ZmgjVezc0zgB1gTDjx4uQLc4mY8bzDmbMt9JVgbOY3CCuhEvpCtcD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=V3iFOIQz; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 465BD8288916;
	Mon, 20 Oct 2025 13:12:02 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id jyH9xrehds5M; Mon, 20 Oct 2025 13:12:01 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 728918288904;
	Mon, 20 Oct 2025 13:12:01 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 728918288904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1760983921; bh=TWT/S42OVGFvEzjTn8JP2GZlPp3a6DBwNMeV9XpeODo=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=V3iFOIQzkWGRvvX9XyGs8JFsMj9BlLvvtsybqgARv2QRnQ0Jvyh86nOLoEFNSqXuF
	 Xt2pQB3fxg7mjl83+SBtkFKnolsQF2OoBXgmoJaVgccw7LzJpX0sFduOAKfhDNJkFD
	 YH3UTC9t46hOmSltbfzQVNSrX7Fd5HtHfdJmv7Zo=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KuxPRhkURbAQ; Mon, 20 Oct 2025 13:12:01 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 4D5458288084;
	Mon, 20 Oct 2025 13:12:01 -0500 (CDT)
Date: Mon, 20 Oct 2025 13:12:01 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Lee Jones <lee@kernel.org>, 
	Georgy Yakovlev <Georgy.Yakovlev@sony.com>
Message-ID: <1587929609.1802041.1760983921227.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <1787448596.1802034.1760983830792.JavaMail.zimbra@raptorengineeringinc.com>
References: <1787448596.1802034.1760983830792.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH v4 1/4] dt-bindings: mfd: Add sony,cronos-smc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC141 (Linux)/8.5.0_GA_3042)
Thread-Topic: dt-bindings: mfd: Add sony,cronos-smc
Thread-Index: 2sKQBCK/cFq8bcVeB0FycJRZCrk72uhu0OzS

The Sony Cronos Platform Controller is a multi-purpose platform controller
that provides both a watchdog timer and an LED controller for the Sony
Interactive Entertainment Cronos x86 server platform. As both functions
are provided by the same CPLD, a multi-function device is exposed as the
parent of both functions.

Add a DT binding for this device.

Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 .../bindings/mfd/sony,cronos-smc.yaml         | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/sony,cronos-smc.yaml

diff --git a/Documentation/devicetree/bindings/mfd/sony,cronos-smc.yaml b/Documentation/devicetree/bindings/mfd/sony,cronos-smc.yaml
new file mode 100644
index 000000000000..ec0fd3ed6073
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sony,cronos-smc.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2025 Raptor Engineering, LLC
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/sony,cronos-smc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sony Cronos Platform Controller CPLD multi-function device
+
+maintainers:
+  - Georgy Yakovlev <Georgy.Yakovlev@sony.com>
+
+description:
+  The Sony Cronos Platform Controller CPLD is a multi-purpose platform
+  controller that provides both a watchdog timer and an LED controller for the
+  Sony Interactive Entertainment Cronos x86 server platform. As both functions
+  are provided by the same CPLD, a multi-function device is exposed as the
+  parent of both functions.
+
+properties:
+  compatible:
+    const: sony,cronos-smc
+
+  reg:
+    maxItems: 1
+
+  timeout-sec: true
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
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/watchdog/watchdog.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      smc@3f {
+        compatible = "sony,cronos-smc";
+        reg = <0x3f>;
+
+        timeout-sec = <20>;
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

