Return-Path: <linux-kernel+bounces-814522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2462B55520
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7283B0BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89B3322DC5;
	Fri, 12 Sep 2025 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cDtcWlzo"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00878321F57;
	Fri, 12 Sep 2025 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696054; cv=none; b=Pveoz5uNMXFOGyyW1YjrXDhJsIbI5LW00lMZIS+FN1Ry2I0uwxmxgl1R3sf1YHu23mze6HIbnBTwvfLIb9TtxYQ8jD6vdOt+09adLAmIISWuhdFXsOGQSBBTFVZM+tyr1/77mYDiv6wjY4I8Wlsy1aSOIG63K0tefOzSjHrLVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696054; c=relaxed/simple;
	bh=H7k5mDAfvycjhvRWu34N74VSOKqaMn3YDIjLNtIW6qM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EHtq+tlhP/hH58b4Jn994Y6KS3Z3BHCyLD/cMohH2ennJiaX6Rl0UvN0SnQjswvAqZq1WwTlrmXcaJgTNcmKZdMrTAcwRz1A6c+H+18UldqPQeqYe6m8MuyAXG255SKPFSqFCNpt6XrHyAxgy+9pvEEa88XBQkmJWEwObW7joVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cDtcWlzo; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757696049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mfZBlMHwJS9/OuN5VmEq2SYdNWX9aD0m2Sh8K3/blMA=;
	b=cDtcWlzozhFot9ePL0RKopC2wj5Ha8ZnnpDYQ7aobap3+nRnBinzDjTWwtedeYpVb11e5U
	YMzMJvSKw/I8LmIzCDsMEcAdOcw5a0pV7gVLuAv/cngWsw1qKxfo3DQnmkv9WNecoKjnQz
	wG4ZtDxNXpCa9i4jEJBFur7919gHgDA=
From: Ze Huang <huang.ze@linux.dev>
Date: Sat, 13 Sep 2025 00:53:47 +0800
Subject: [PATCH v8 1/2] dt-bindings: usb: dwc3: add support for SpacemiT K1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-dwc3_generic-v8-1-b50f81f05f95@linux.dev>
References: <20250913-dwc3_generic-v8-0-b50f81f05f95@linux.dev>
In-Reply-To: <20250913-dwc3_generic-v8-0-b50f81f05f95@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Ze Huang <huang.ze@linux.dev>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757696039; l=3806;
 i=huang.ze@linux.dev; s=20250705; h=from:subject:message-id;
 bh=H7k5mDAfvycjhvRWu34N74VSOKqaMn3YDIjLNtIW6qM=;
 b=jbkyzOcIQWAfVhF/BNStissrHzcoutpFBZe+WEk8BcO198bWNcMPm0EdUEbnvZkaf9Q1APLKP
 PmS3I93RLImCcqVZgPNDpD9gHN4DTICYWjLzoVBhYfKLosJdQe3RbPG
X-Developer-Key: i=huang.ze@linux.dev; a=ed25519;
 pk=Kzc4PMu5PTo8eZZQ5xmTNL9jeXcQ9Wml0cs+vlQpBkg=
X-Migadu-Flow: FLOW_OUT

Add support for the USB 3.0 Dual-Role Device (DRD) controller embedded
in the SpacemiT K1 SoC. The controller is based on the Synopsys
DesignWare Core USB 3 (DWC3) IP, supporting USB3.0 host mode and USB 2.0
DRD mode.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Ze Huang <huang.ze@linux.dev>
---
 .../devicetree/bindings/usb/spacemit,k1-dwc3.yaml  | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/spacemit,k1-dwc3.yaml b/Documentation/devicetree/bindings/usb/spacemit,k1-dwc3.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..0f0b5e061ca17cd02866a78d15d3808f933a76c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/spacemit,k1-dwc3.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/spacemit,k1-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 SuperSpeed DWC3 USB SoC Controller
+
+maintainers:
+  - Ze Huang <huang.ze@linux.dev>
+
+description: |
+  The SpacemiT K1 embeds a DWC3 USB IP Core which supports Host functions
+  for USB 3.0 and DRD for USB 2.0.
+
+  Key features:
+  - USB3.0 SuperSpeed and USB2.0 High/Full/Low-Speed support
+  - Supports low-power modes (USB2.0 suspend, USB3.0 U1/U2/U3)
+  - Internal DMA controller and flexible endpoint FIFO sizing
+
+  Communication Interface:
+  - Use of PIPE3 (125MHz) interface for USB3.0 PHY
+  - Use of UTMI+ (30/60MHz) interface for USB2.0 PHY
+
+allOf:
+  - $ref: snps,dwc3-common.yaml#
+
+properties:
+  compatible:
+    const: spacemit,k1-dwc3
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: usbdrd30
+
+  interrupts:
+    maxItems: 1
+
+  phys:
+    items:
+      - description: phandle to USB2/HS PHY
+      - description: phandle to USB3/SS PHY
+
+  phy-names:
+    items:
+      - const: usb2-phy
+      - const: usb3-phy
+
+  resets:
+    items:
+      - description: USB3.0 AHB reset
+      - description: USB3.0 VCC reset
+      - description: USB3.0 PHY reset
+
+  reset-names:
+    items:
+      - const: ahb
+      - const: vcc
+      - const: phy
+
+  reset-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 2
+    description: delay after reset sequence [us]
+
+  vbus-supply:
+    description: A phandle to the regulator supplying the VBUS voltage.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - phys
+  - phy-names
+  - resets
+  - reset-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    usb@c0a00000 {
+        compatible = "spacemit,k1-dwc3";
+        reg = <0xc0a00000 0x10000>;
+        clocks = <&syscon_apmu 16>;
+        clock-names = "usbdrd30";
+        interrupts = <125>;
+        phys = <&usb2phy>, <&usb3phy>;
+        phy-names = "usb2-phy", "usb3-phy";
+        resets = <&syscon_apmu 8>,
+                 <&syscon_apmu 9>,
+                 <&syscon_apmu 10>;
+        reset-names = "ahb", "vcc", "phy";
+        reset-delay = <2>;
+        vbus-supply = <&usb3_vbus>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hub_2_0: hub@1 {
+            compatible = "usb2109,2817";
+            reg = <1>;
+            vdd-supply = <&usb3_vhub>;
+            peer-hub = <&hub_3_0>;
+            reset-gpios = <&gpio 3 28 1>;
+        };
+
+        hub_3_0: hub@2 {
+            compatible = "usb2109,817";
+            reg = <2>;
+            vdd-supply = <&usb3_vhub>;
+            peer-hub = <&hub_2_0>;
+            reset-gpios = <&gpio 3 28 1>;
+        };
+    };

-- 
2.34.1


