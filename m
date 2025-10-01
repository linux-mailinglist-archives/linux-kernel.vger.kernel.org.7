Return-Path: <linux-kernel+bounces-839380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D8CBB183C
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 20:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B539819241DA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 18:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF9D2D593A;
	Wed,  1 Oct 2025 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="EU94pkYR"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0812D5939;
	Wed,  1 Oct 2025 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343834; cv=pass; b=e1Zed6ye9OmxerquRKkubqjVRVMCFPMDh8Q36eGOuM9XtMtCyiYV3iIXuH7Ps5LyCTrxBU4otTOR51NORYcmAUUfEIZ4ljUqB3XgjCbv5bUfXfPHvGLcFaLSFzq5S8sh6bBEwnxusPOrD/IZ3AhtMWqM/iMa4W3MgPH81SOHbAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343834; c=relaxed/simple;
	bh=CUBM0mBmVPkicODbBp1xx4UtFM19E0qMmRDkuNDGH3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cAkn9WBwftjKAg2K1n2aNCxjrnWoLRDwhka2g5N9PK107YWbNUXFPJoElfA1Mkm1eUDwnQLicJE+UBd/EkZJZCF0VegDADGqqDJZQicDPsOEg+y5PbvER2DIy16Y7pDeXiAe/gi+9zHNnG6D1oEM4X5B+Gh8AOwfBvFDbdEiQr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=EU94pkYR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759343818; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AWR7OmKcdTzjwYLprPea9rUkBBoDL3LBfJrDJ5a25efapNpT7U98yF955niYXX1s+5BXy+yqawkeQR3YshOTbtZNDNJLqP6GETR5fGCDYvBTNWVqNI4sPtqm0r8kjIy2yiCMJl8pHRnKDR3HSOaLhWG9OLMadRXlrjMU5GnDsD0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759343818; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VFwVI/DzokXdehoWBWg6HSD+fLixXuRHY7gKajclmqY=; 
	b=JMBXsiPIV9g5iDNZrsFJMoqw2MDFpMVQHtH+BSj4293ZHu0U3sGNbacsZjwdg6Tm8rdaifeEITGIVk6wS5mKXDjk8x4FxyK1YokvWvht5YODqrlSfzDdyBXF7nxIfoHc+kBctsHjDLk2RbKsFknu89Hfd1/KJDyJXV0Tto0PcMY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759343818;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VFwVI/DzokXdehoWBWg6HSD+fLixXuRHY7gKajclmqY=;
	b=EU94pkYRWE7J2ZNIc4MOzUEecpj2zYWkFjKjHAYEuBDbvovS5S4fUlIPCGkUPiiQ
	UYSufsNlQHeGDi0jITJFcs4jhCj0aVqus9qE+deAlXC/dSWncif/kVxarLMrB/4fn3T
	+0dG9z0yU6nzp+nCQOrzpi6PsEEtAO4jjIU6ueHo=
Received: by mx.zohomail.com with SMTPS id 1759343816562112.86931271037633;
	Wed, 1 Oct 2025 11:36:56 -0700 (PDT)
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: angelogioacchino.delregno@collabora.com,
	ariel.dalessandro@collabora.com,
	broonie@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	lgirdwood@gmail.com,
	robh@kernel.org,
	support.opensource@diasemi.com
Cc: devicetree@vger.kernel.org,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: regulator: Convert Dialog DA9211 Regulators to DT schema
Date: Wed,  1 Oct 2025 15:36:48 -0300
Message-ID: <20251001183648.83379-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Convert the existing text-based DT bindings for Dialog Semiconductor DA9211
Voltage Regulators family to a DT schema. Examples are simplified, as these
are all equal.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/regulator/da9211.txt  | 205 ------------------
 .../bindings/regulator/dlg,da9211.yaml        | 103 +++++++++
 2 files changed, 103 insertions(+), 205 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/da9211.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/dlg,da9211.yaml

diff --git a/Documentation/devicetree/bindings/regulator/da9211.txt b/Documentation/devicetree/bindings/regulator/da9211.txt
deleted file mode 100644
index eb871447d5082..0000000000000
--- a/Documentation/devicetree/bindings/regulator/da9211.txt
+++ /dev/null
@@ -1,205 +0,0 @@
-* Dialog Semiconductor DA9211/DA9212/DA9213/DA9223/DA9214/DA9224/DA9215/DA9225
- Voltage Regulator
-
-Required properties:
-- compatible: "dlg,da9211" or "dlg,da9212" or "dlg,da9213" or "dlg,da9223"
-  or "dlg,da9214" or "dlg,da9224" or "dlg,da9215" or "dlg,da9225"
-- reg: I2C slave address, usually 0x68.
-- interrupts: the interrupt outputs of the controller
-- regulators: A node that houses a sub-node for each regulator within the
-  device. Each sub-node is identified using the node's name, with valid
-  values listed below. The content of each sub-node is defined by the
-  standard binding for regulators; see regulator.txt.
-  BUCKA and BUCKB.
-
-Optional properties:
-- enable-gpios: platform gpio for control of BUCKA/BUCKB.
-- Any optional property defined in regulator.txt
-  - regulator-initial-mode and regulator-allowed-modes may be specified using
-    mode values from dt-bindings/regulator/dlg,da9211-regulator.h
-
-Example 1) DA9211
-	pmic: da9211@68 {
-		compatible = "dlg,da9211";
-		reg = <0x68>;
-		interrupts = <3 27>;
-
-		regulators {
-			BUCKA {
-				regulator-name = "VBUCKA";
-				regulator-min-microvolt = < 300000>;
-				regulator-max-microvolt = <1570000>;
-				regulator-min-microamp 	= <2000000>;
-				regulator-max-microamp 	= <5000000>;
-				enable-gpios = <&gpio 27 0>;
-				regulator-allowed-modes = <DA9211_BUCK_MODE_SYNC
-							   DA9211_BUCK_MODE_AUTO>;
-			};
-		};
-	};
-
-Example 2) DA9212
-	pmic: da9212@68 {
-		compatible = "dlg,da9212";
-		reg = <0x68>;
-		interrupts = <3 27>;
-
-		regulators {
-			BUCKA {
-				regulator-name = "VBUCKA";
-				regulator-min-microvolt = < 300000>;
-				regulator-max-microvolt = <1570000>;
-				regulator-min-microamp 	= <2000000>;
-				regulator-max-microamp 	= <5000000>;
-				enable-gpios = <&gpio 27 0>;
-			};
-			BUCKB {
-				regulator-name = "VBUCKB";
-				regulator-min-microvolt = < 300000>;
-				regulator-max-microvolt = <1570000>;
-				regulator-min-microamp 	= <2000000>;
-				regulator-max-microamp 	= <5000000>;
-				enable-gpios = <&gpio 17 0>;
-			};
-		};
-	};
-
-Example 3) DA9213
-	pmic: da9213@68 {
-		compatible = "dlg,da9213";
-		reg = <0x68>;
-		interrupts = <3 27>;
-
-		regulators {
-			BUCKA {
-				regulator-name = "VBUCKA";
-				regulator-min-microvolt = < 300000>;
-				regulator-max-microvolt = <1570000>;
-				regulator-min-microamp 	= <3000000>;
-				regulator-max-microamp 	= <6000000>;
-				enable-gpios = <&gpio 27 0>;
-			};
-		};
-	};
-
-Example 4) DA9223
-	pmic: da9223@68 {
-		compatible = "dlg,da9223";
-		reg = <0x68>;
-		interrupts = <3 27>;
-
-		regulators {
-			BUCKA {
-				regulator-name = "VBUCKA";
-				regulator-min-microvolt = < 300000>;
-				regulator-max-microvolt = <1570000>;
-				regulator-min-microamp 	= <3000000>;
-				regulator-max-microamp 	= <6000000>;
-				enable-gpios = <&gpio 27 0>;
-			};
-		};
-	};
-
-Example 5) DA9214
-	pmic: da9214@68 {
-		compatible = "dlg,da9214";
-		reg = <0x68>;
-		interrupts = <3 27>;
-
-		regulators {
-			BUCKA {
-				regulator-name = "VBUCKA";
-				regulator-min-microvolt = < 300000>;
-				regulator-max-microvolt = <1570000>;
-				regulator-min-microamp 	= <3000000>;
-				regulator-max-microamp 	= <6000000>;
-				enable-gpios = <&gpio 27 0>;
-			};
-			BUCKB {
-				regulator-name = "VBUCKB";
-				regulator-min-microvolt = < 300000>;
-				regulator-max-microvolt = <1570000>;
-				regulator-min-microamp 	= <3000000>;
-				regulator-max-microamp 	= <6000000>;
-				enable-gpios = <&gpio 17 0>;
-			};
-		};
-	};
-
-Example 6) DA9224
-	pmic: da9224@68 {
-		compatible = "dlg,da9224";
-		reg = <0x68>;
-		interrupts = <3 27>;
-
-		regulators {
-			BUCKA {
-				regulator-name = "VBUCKA";
-				regulator-min-microvolt = < 300000>;
-				regulator-max-microvolt = <1570000>;
-				regulator-min-microamp 	= <3000000>;
-				regulator-max-microamp 	= <6000000>;
-				enable-gpios = <&gpio 27 0>;
-			};
-			BUCKB {
-				regulator-name = "VBUCKB";
-				regulator-min-microvolt = < 300000>;
-				regulator-max-microvolt = <1570000>;
-				regulator-min-microamp 	= <3000000>;
-				regulator-max-microamp 	= <6000000>;
-				enable-gpios = <&gpio 17 0>;
-			};
-		};
-	};
-
-Example 7) DA9215
-	pmic: da9215@68 {
-		compatible = "dlg,da9215";
-		reg = <0x68>;
-		interrupts = <3 27>;
-
-		regulators {
-			BUCKA {
-				regulator-name = "VBUCKA";
-				regulator-min-microvolt = < 300000>;
-				regulator-max-microvolt = <1570000>;
-				regulator-min-microamp 	= <4000000>;
-				regulator-max-microamp 	= <7000000>;
-				enable-gpios = <&gpio 27 0>;
-			};
-			BUCKB {
-				regulator-name = "VBUCKB";
-				regulator-min-microvolt = < 300000>;
-				regulator-max-microvolt = <1570000>;
-				regulator-min-microamp 	= <4000000>;
-				regulator-max-microamp 	= <7000000>;
-				enable-gpios = <&gpio 17 0>;
-			};
-		};
-	};
-
-Example 8) DA9225
-	pmic: da9225@68 {
-		compatible = "dlg,da9225";
-		reg = <0x68>;
-		interrupts = <3 27>;
-
-		regulators {
-			BUCKA {
-				regulator-name = "VBUCKA";
-				regulator-min-microvolt = < 300000>;
-				regulator-max-microvolt = <1570000>;
-				regulator-min-microamp 	= <4000000>;
-				regulator-max-microamp 	= <7000000>;
-				enable-gpios = <&gpio 27 0>;
-			};
-			BUCKB {
-				regulator-name = "VBUCKB";
-				regulator-min-microvolt = < 300000>;
-				regulator-max-microvolt = <1570000>;
-				regulator-min-microamp 	= <4000000>;
-				regulator-max-microamp 	= <7000000>;
-				enable-gpios = <&gpio 17 0>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9211.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9211.yaml
new file mode 100644
index 0000000000000..4d7e495a6f599
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/dlg,da9211.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/dlg,da9211.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  Dialog Semiconductor DA9211-9215, DA9223-9225 Voltage Regulators
+
+maintainers:
+  - Ariel D'Alessandro <ariel.dalessandro@collabora.com>
+
+properties:
+  compatible:
+    enum:
+      - dlg,da9211
+      - dlg,da9212
+      - dlg,da9213
+      - dlg,da9214
+      - dlg,da9215
+      - dlg,da9223
+      - dlg,da9224
+      - dlg,da9225
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  regulators:
+    type: object
+    additionalProperties: false
+    description:
+      List of regulators provided by the device
+
+    patternProperties:
+      "^BUCK([AB])$":
+        type: object
+        $ref: regulator.yaml#
+        unevaluatedProperties: false
+        description:
+          Properties for a single BUCK regulator
+
+        properties:
+          regulator-initial-mode:
+            items:
+              enum: [ 1, 2, 3 ]
+            description:
+              Defined in include/dt-bindings/regulator/dlg,da9211-regulator.h
+
+          regulator-allowed-modes:
+            items:
+              enum: [ 1, 2, 3 ]
+            description:
+              Defined in include/dt-bindings/regulator/dlg,da9211-regulator.h
+
+          enable-gpios:
+            maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/regulator/dlg,da9211-regulator.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@68 {
+            compatible = "dlg,da9212";
+            reg = <0x68>;
+            interrupts = <3 27>;
+
+            regulators {
+                BUCKA {
+                    regulator-name = "VBUCKA";
+                    regulator-min-microvolt = < 300000>;
+                    regulator-max-microvolt = <1570000>;
+                    regulator-min-microamp = <2000000>;
+                    regulator-max-microamp = <5000000>;
+                    enable-gpios = <&gpio 27 0>;
+                };
+                BUCKB {
+                    regulator-name = "VBUCKB";
+                    regulator-min-microvolt = < 300000>;
+                    regulator-max-microvolt = <1570000>;
+                    regulator-min-microamp = <2000000>;
+                    regulator-max-microamp = <5000000>;
+                    enable-gpios = <&gpio 17 0>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.51.0


