Return-Path: <linux-kernel+bounces-876600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06754C1BE5F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 446C15E4A79
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC6C33B6F2;
	Wed, 29 Oct 2025 15:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xMSZDXe7"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E95227;
	Wed, 29 Oct 2025 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753105; cv=none; b=EZq0WjZTkxBVVhJITIvkbR4gmwCR3rdlYxBj4ZExI+z947cfKZxsCcUbnJKlUjL4rvBH8Jl2gQTkTSZh1muj47wQ3LFTR4qzF4XB3EV9+QTlv7GpU9vM0o6PD92OkzR0R1QsAij6rktwzQHKFT2yNFxhvhfVdEZg4+MJZjiOiNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753105; c=relaxed/simple;
	bh=ZKAuhcvGiMxkVSfeD/IFEzXCfmgMtELVjkUql9TTJWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UsM2knWkxUc+qiIEbsY64UvqhwMWSbAlAeAPQga52rCj/dyg7m+u9ff74l48grKr4SK23zf3iUZRRv/zbRWTjfI3dzbMBtn8Vh87QJzRI1Z/UH+EMB33j6tBiFZsElRXaiE6ZTAVqz0O+/wS+LJqci4Y71+qqzaUL1EBBrYw+dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xMSZDXe7; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761753103; x=1793289103;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ZKAuhcvGiMxkVSfeD/IFEzXCfmgMtELVjkUql9TTJWA=;
  b=xMSZDXe7jb3e5heGw4r0VdrQnrAgLrinXhz/Hz9IcXXV4BzplSTflnrf
   s5URZ4QyRxXxFtrrjyDbzDPiI0XsMDVNlqmcxWSfYcJfrdBc+D4/JRVN+
   NX93DhAT0gWJe4cWD/DerK77DCn4HrzFSmh3p3HfRAdgsrB6Vj4BOrVNF
   0vIo2XtRHmS1RqaDuaSoBsWooHzN1WuQSx9K9uBN9DZQJps+YH8SvXMFR
   SSnn/MYYGNFYjmDvUyOlYetXWJDAWLFpe1RKqgYn6DXke3jFUnqL81O7x
   fCL1lSEJrDLokuz8HeH+Y1ncCd82MOzsgmFI6Q8hraGk/sG03+WqFbrDb
   g==;
X-CSE-ConnectionGUID: iyBWzYvURAWNjcJpeOx0pg==
X-CSE-MsgGUID: LQIPOVeNQw6DPkGEZJ6fLQ==
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="54712635"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:51:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 29 Oct 2025 08:51:12 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 29 Oct 2025 08:51:10 -0700
From: Marius Cristea <marius.cristea@microchip.com>
Date: Wed, 29 Oct 2025 17:50:58 +0200
Subject: [PATCH 1/2] dt-bindings: hwmon: temperature: add support for
 EMC1812
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251029-hw_mon-emc1812-v1-1-be4fd8af016a@microchip.com>
References: <20251029-hw_mon-emc1812-v1-0-be4fd8af016a@microchip.com>
In-Reply-To: <20251029-hw_mon-emc1812-v1-0-be4fd8af016a@microchip.com>
To: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, Marius Cristea
	<marius.cristea@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5901;
 i=marius.cristea@microchip.com; h=from:subject:message-id;
 bh=ZKAuhcvGiMxkVSfeD/IFEzXCfmgMtELVjkUql9TTJWA=;
 b=owGbwMvMwCW2tbSTZa7u0x2Mp9WSGDKZzF8dFE57LcAzw14iwzvlJo9Yz8YDDPb22Z5reWJle
 F/OiK/pKGVhEONikBVTZFnx1k+tau2Hy0pimTowc1iZQIYwcHEKwEQ+HmRkaA6f5rRu/VP3dl2D
 Lzbtvy7tiBF3+D3nxKajoroSP/cw7GVkOFH0auutAqNdZ6YdPOkhOXvaUuvG2cYd2bt/WxQdrXS
 PZwEA
X-Developer-Key: i=marius.cristea@microchip.com; a=openpgp;
 fpr=E32F8D4396E72E463E8CCD91446DE0ABD9140C3E

This is the devicetree schema for Microchip EMC1812/13/14/15/33
Multichannel Low-Voltage Remote Diode Sensor Family.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 .../bindings/hwmon/microchip,emc1812.yaml          | 176 +++++++++++++++++++++
 MAINTAINERS                                        |   6 +
 2 files changed, 182 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc1812.yaml b/Documentation/devicetree/bindings/hwmon/microchip,emc1812.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..cc4c7bb53cb13416c1e9419cc8c6c8a56da22df8
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/microchip,emc1812.yaml
@@ -0,0 +1,176 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/microchip,emc1812.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip EMC1812/13/14/15/33 multichannel temperature sensor
+
+maintainers:
+  - Marius Cristea <marius.cristea@microchip.com>
+
+description: |
+  The Microchip EMC1812/13/14/15/33 is a high-accuracy 2-wire multichannel
+  low-voltage remote diode temperature monitor.
+
+  The datasheet can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/EMC1812-3-4-5-33-Data-Sheet-DS20005751.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,emc1812
+      - microchip,emc1813
+      - microchip,emc1814
+      - microchip,emc1815
+      - microchip,emc1833
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    description:
+      -alert-therm2 asserts when a diode temperature exceeds the ALERT
+      threshold.
+      -therm-addr asserts low when the hardware-set THERM limit threshold is
+      exceeded by one of the temperature sensors.
+    items:
+      - const: alert-therm2
+      - const: therm-addr
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  microchip,parasitic-res-on-channel1-2:
+    description:
+      Indicates that the chip and the diodes/transistors are sufficiently
+      far apart that a parasitic resistance is added to the wires, which can
+      affect the measurements. Due to the anti-parallel diode connections,
+      channels 1 and 2 are affected together.
+    type: boolean
+
+  microchip,parasitic-res-on-channel3-4:
+    description:
+      Indicates that the chip and the diodes/transistors are sufficiently far
+      apart that a parasitic resistance is added to the wires, which can affect
+      the measurements. Due to the anti-parallel diode connections, channels
+      3 and 4 are affected together.
+    type: boolean
+
+  vdd-supply: true
+
+patternProperties:
+  "^channel@[1-4]$":
+    description:
+      Represents the external temperature channels to which
+      a remote diode is connected.
+    type: object
+
+    properties:
+      reg:
+        items:
+          minimum: 1
+          maximum: 4
+
+      label:
+        description: Unique name to identify which channel this is.
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,emc1812
+              - microchip,emc1813
+              - microchip,emc1833
+    then:
+      properties:
+        microchip,parasitic-res-on-channel3-4: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,emc1812
+    then:
+      properties:
+        channel@1:
+          properties:
+            reg:
+              items:
+                const: 1
+      patternProperties:
+        "^channel@[2-4]$": false
+  - if:
+      properties:
+        compatible:
+          pattern: "^microchip,emc18[13]3"
+    then:
+      patternProperties:
+        "^channel@[12]$":
+          properties:
+            reg:
+              items:
+                maximum: 2
+        "^channel@[34]$": false
+  - if:
+      properties:
+        compatible:
+          pattern: "^microchip,emc1814"
+    then:
+      patternProperties:
+        "^channel@[1-3]$":
+          properties:
+            reg:
+              items:
+                maximum: 3
+      properties:
+        channel@4: false
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temperature-sensor@4c {
+            compatible = "microchip,emc1813";
+            reg = <0x4c>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            microchip,parasitic-res-on-channel1-2;
+
+            vdd-supply = <&vdd>;
+
+            channel@1 {
+                reg = <1>;
+                label = "External CH1 Temperature";
+            };
+
+            channel@2 {
+                reg = <2>;
+                label = "External CH2 Temperature";
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6d7b697bfdba16e4f0ee5f4f0195b9d7da06dae5..85c236df781e47c78deeb7ef4d80bc94bba604c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16646,6 +16646,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/interrupt-controller/microchip,sama7g5-eic.yaml
 F:	drivers/irqchip/irq-mchp-eic.c
 
+MICROCHIP EMC1812 DRIVER
+M:	Marius Cristea <marius.cristea@microchip.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/hwmon/microchip,emc1812.yaml
+
 MICROCHIP I2C DRIVER
 M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
 L:	linux-i2c@vger.kernel.org

-- 
2.48.1


