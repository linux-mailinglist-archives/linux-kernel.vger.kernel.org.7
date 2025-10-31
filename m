Return-Path: <linux-kernel+bounces-880533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324B8C26017
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE1D562BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FA52EFDB5;
	Fri, 31 Oct 2025 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="REQE6mgq"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3D239E76;
	Fri, 31 Oct 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926401; cv=none; b=mU54PvP+OfUO0nXo2jMYPFrKs0/cxskLcRrjZAVxpiZyajVhx1z0fOqHvm+kF1UD4vtyMdWcuSJvumfi00gD//Dp2pO9DWLjRUl3DCTO82jvAtSfTEfD2d3EY+1pKbc7KLIYrvFZhnRUcbVrBq7enevxvbxVzEeRYS+EU9MDuKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926401; c=relaxed/simple;
	bh=E1Ay3P3QYYIXDIHoqXmgXi6xFF1jhlz0apVi1LA/54I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8HZLyfujSu1aiUoKHd9A7Q3Busto6KF0QToMF9iTJtXZzmtX1T7ex2VxH3QJPLUp/r1Z28dYLU+pDFm/6tmukuyruylMyRJGioPNEcxRZcuDgn+YZaUd+S96dcUpLmA+q0J1wkqQfiE5v2dISTLIMhzHCKGcEjLX7crP705ywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=REQE6mgq; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761926400; x=1793462400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E1Ay3P3QYYIXDIHoqXmgXi6xFF1jhlz0apVi1LA/54I=;
  b=REQE6mgqHzBe72/MB5SpD//zTZvIQ513QTyzADBXZqmO2urmDbt0LtDU
   Sqhin8XDVip1wiugnaE0ZmHePXK3kyyhfOoWKxYJc024nl93dQvzscogy
   aVUOvWDwVFB/K7rnCIpScfW6DmwJZHV1rtAU+cuAeUPRt00lDEPvPG3p1
   F7G4Ub4hE/kc4hVU1mPDO9hAXcNrfxP0ez7nynbjJGD+Maht8aar29Oe4
   ANFOveHkSoNcWnxfWQ+nMtS/1aOe8Xsb/M3K/WQ+HuFMLDmcS8Fvla5LO
   fMRqShGklC5zVHoP6BJajTkbH8h5o5qbiL3DS9llOla9lyeKkUqi+C8CA
   g==;
X-CSE-ConnectionGUID: 5FY/NrzDS2GK02PmSrgrvA==
X-CSE-MsgGUID: RKGD/kdAQQibe3oT6QmLmg==
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="48528057"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 08:59:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 31 Oct 2025 08:59:29 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 31 Oct 2025 08:59:27 -0700
From: <victor.duicu@microchip.com>
To: <linux@roeck-us.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <corbet@lwn.net>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v1 1/2] dt-bindings: hwmon: add support for MCP998X
Date: Fri, 31 Oct 2025 17:58:30 +0200
Message-ID: <20251031155831.42763-2-victor.duicu@microchip.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251031155831.42763-1-victor.duicu@microchip.com>
References: <20251031155831.42763-1-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Victor Duicu <victor.duicu@microchip.com>

This is the devicetree schema for Microchip MCP998X/33 and
MCP998XD/33D Multichannel Automotive Temperature Monitor Family.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
---
 .../bindings/hwmon/microchip,mcp9982.yaml     | 192 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,mcp9982.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/microchip,mcp9982.yaml b/Documentation/devicetree/bindings/hwmon/microchip,mcp9982.yaml
new file mode 100644
index 000000000000..77f4f8e21344
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/microchip,mcp9982.yaml
@@ -0,0 +1,192 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/microchip,mcp9982.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP998X/33 and MCP998XD/33D Temperature Monitor
+
+maintainers:
+  - Victor Duicu <victor.duicu@microchip.com>
+
+description: |
+  The MCP998X/33 and MCP998XD/33D family is a high-accuracy 2-wire
+  multichannel automotive temperature monitor.
+  The datasheet can be found here:
+    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf
+
+properties:
+  compatible:
+    enum:
+      - microchip,mcp9933
+      - microchip,mcp9933d
+      - microchip,mcp9982
+      - microchip,mcp9982d
+      - microchip,mcp9983
+      - microchip,mcp9983d
+      - microchip,mcp9984
+      - microchip,mcp9984d
+      - microchip,mcp9985
+      - microchip,mcp9985d
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Signal coming from ALERT/THERM pin.
+      - description: Signal coming from THERM/ADDR pin.
+      - description: Signal coming from SYS_SHDN pin.
+
+  interrupt-names:
+    items:
+      - const: alert-therm
+      - const: therm-addr
+      - const: sys-shutdown
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  microchip,enable-anti-parallel:
+    description:
+      Enable anti-parallel diode mode operation.
+      MCP9984/84D/85/85D and MCP9933/33D support reading two external diodes
+      in anti-parallel connection on the same set of pins.
+    type: boolean
+
+  microchip,parasitic-res-on-channel1-2:
+    description:
+      Indicates that the chip and the diodes/transistors are sufficiently far
+      apart that a parasitic resistance is added to the wires, which can affect
+      the measurements. Due to the anti-parallel diode connections, channels
+      1 and 2 are affected together.
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
+          minItems: 1
+          maxItems: 4
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
+              - microchip,mcp9982d
+              - microchip,mcp9983d
+              - microchip,mcp9984d
+              - microchip,mcp9985d
+              - microchip,mcp9933d
+    then:
+      properties:
+        interrupts-names:
+          items:
+            - const: alert-therm
+            - const: sys-shutdown
+    else:
+      properties:
+        interrupts-names:
+          items:
+            - const: alert-therm
+            - const: therm-addr
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: '^microchip,mcp998(2|3)$'
+    then:
+      properties:
+        microchip,enable-anti-parallel: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: '^microchip,mcp998(2|3)d$'
+    then:
+      properties:
+        microchip,enable-anti-parallel: false
+      required:
+        - microchip,parasitic-res-on-channel1-2
+        - microchip,parasitic-res-on-channel3-4
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            pattern: '^microchip,mcp99(33|8[4-5])d$'
+    then:
+      required:
+        - microchip,parasitic-res-on-channel1-2
+        - microchip,parasitic-res-on-channel3-4
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
+            compatible = "microchip,mcp9985";
+            reg = <0x4c>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            microchip,enable-anti-parallel;
+            microchip,parasitic-res-on-channel1-2;
+            microchip,parasitic-res-on-channel3-4;
+
+            vdd-supply = <&vdd>;
+
+            channel@1 {
+                reg = <1>;
+                label = "Interior Temperature";
+            };
+
+            channel@2 {
+                reg = <2>;
+                label = "GPU Temperature";
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 940889b158eb..103e0b56f88e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16942,6 +16942,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
 F:	drivers/iio/adc/mcp3911.c
 
+MICROCHIP MCP9982 TEMPERATURE DRIVER
+M:	Victor Duicu <victor.duicu@microchip.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/hwmon/microchip,mcp9982.yaml
+
 MICROCHIP MMC/SD/SDIO MCI DRIVER
 M:	Aubin Constans <aubin.constans@microchip.com>
 S:	Maintained
-- 
2.48.1


