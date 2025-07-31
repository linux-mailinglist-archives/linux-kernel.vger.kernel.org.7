Return-Path: <linux-kernel+bounces-752662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A05B178FF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B911F17438A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDB6278E67;
	Thu, 31 Jul 2025 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiPdH8bJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367B7277C9E;
	Thu, 31 Jul 2025 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999965; cv=none; b=bIS8yf5atPdMp08sNTeI5uDpDvEd8pTmJHYMglBqPwS3sy/IVWsQ/pWVxB9p4Evu8B4DGWNFBi6m5Dwk0YpaLpQkQFUkl8pamCfJVcpxSfqsDFKm+HULLz0qmtF090O+r54qVxG31AMsi6WMdR3itXAmGwV6itqirX4HccdFOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999965; c=relaxed/simple;
	bh=ynT/7P19nBEbnk4v3wUHrwMTXAlpxpXmfSbDLW7QBow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVq0IJX1meJ1r1TxN/jL5KotF7XtGHN3O8FxCNeQK/Kg935bHNb3haeHPUemDoJrKC/wDM6F7psjbccI+0P9yzC6sYBAGkjoMztDO5zPOlJZQo/KdzG+v9tY8VTRaHXM+IfRXimSSypwMG/cUAtGKm8UkKQpogMxMrB/yXEALLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiPdH8bJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38E7C4CEEF;
	Thu, 31 Jul 2025 22:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753999965;
	bh=ynT/7P19nBEbnk4v3wUHrwMTXAlpxpXmfSbDLW7QBow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WiPdH8bJVZiPwaVYPbRRr523yZEzOPQ+ie6pu6R67AsJQNNDlJEGT7ay45wD7eDkq
	 LWt9adqI1IaCuV8oC5dgyWEPfcpu0QWaFm81n00/ylYgb66xnFkzMEFgIWG0FbBJYp
	 dvh8q5g065Hf5jP+cXZ/eg+BAU2Td+fwPUhef4xpkbzfSeI9FKX7sA1ba+y8me/2hc
	 pN0WY4/A4lK+hUzEbMPDIDPoHZR9R8cdk48SP3pV7KbsIJVTOSEsyyO2ucOLBciLMB
	 iyTpyCCDMz7xlXpajr2lRYL/VBzx0bxlOT3SDiWhTKYXg4flf5djaa4SSIWFt0u6xI
	 ZCFD5xkDIvBkg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 31 Jul 2025 17:12:23 -0500
Subject: [PATCH 6/6] dt-bindings: fsi: Convert aspeed,ast2400-cf-fsi-master
 to DT schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-dt-fsi-cleanups-v1-6-e7b695a29fc3@kernel.org>
References: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
In-Reply-To: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org
X-Mailer: b4 0.15-dev

Convert the ASpeed Coldfire offloaded GPIO FSI master.

Drop the "fsi-master" compatible as it has not be used consistently and
doesn't represent anything.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/fsi/aspeed,ast2400-cf-fsi-master.yaml | 81 ++++++++++++++++++++++
 .../devicetree/bindings/fsi/fsi-master-ast-cf.txt  | 36 ----------
 2 files changed, 81 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/fsi/aspeed,ast2400-cf-fsi-master.yaml b/Documentation/devicetree/bindings/fsi/aspeed,ast2400-cf-fsi-master.yaml
new file mode 100644
index 000000000000..690b6c936f18
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/aspeed,ast2400-cf-fsi-master.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/aspeed,ast2400-cf-fsi-master.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASpeed ColdFire offloaded GPIO-based FSI master
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+allOf:
+  - $ref: /schemas/fsi/fsi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-cf-fsi-master
+      - aspeed,ast2500-cf-fsi-master
+
+  clock-gpios:
+    maxItems: 1
+    description: GPIO for FSI clock
+
+  data-gpios:
+    maxItems: 1
+    description: GPIO for FSI data signal
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO for enable signal
+
+  trans-gpios:
+    maxItems: 1
+    description: GPIO for voltage translator enable
+
+  mux-gpios:
+    maxItems: 1
+    description:
+      GPIO for pin multiplexing with other functions (eg, external FSI masters)
+
+  memory-region:
+    maxItems: 1
+    description:
+      Reference to the reserved memory for the ColdFire. Must be 2M aligned on
+      AST2400 and 1M aligned on AST2500.
+
+  aspeed,cvic:
+    description: Reference to the CVIC node.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  aspeed,sram:
+    description: Reference to the SRAM node.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - clock-gpios
+  - data-gpios
+  - enable-gpios
+  - trans-gpios
+  - mux-gpios
+  - memory-region
+  - aspeed,cvic
+  - aspeed,sram
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    fsi-master {
+      compatible = "aspeed,ast2500-cf-fsi-master";
+      clock-gpios = <&gpio 0>;
+      data-gpios = <&gpio 1>;
+      enable-gpios = <&gpio 2>;
+      trans-gpios = <&gpio 3>;
+      mux-gpios = <&gpio 4>;
+      memory-region = <&coldfire_memory>;
+      aspeed,cvic = <&cvic>;
+      aspeed,sram = <&sram>;
+    };
diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
deleted file mode 100644
index 3dc752db748b..000000000000
--- a/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Device-tree bindings for ColdFire offloaded gpio-based FSI master driver
-------------------------------------------------------------------------
-
-Required properties:
- - compatible =
-	"aspeed,ast2400-cf-fsi-master" for an AST2400 based system
-   or
-	"aspeed,ast2500-cf-fsi-master" for an AST2500 based system
-
- - clock-gpios = <gpio-descriptor>;	: GPIO for FSI clock
- - data-gpios = <gpio-descriptor>;	: GPIO for FSI data signal
- - enable-gpios = <gpio-descriptor>;	: GPIO for enable signal
- - trans-gpios = <gpio-descriptor>;	: GPIO for voltage translator enable
- - mux-gpios = <gpio-descriptor>;	: GPIO for pin multiplexing with other
-                                          functions (eg, external FSI masters)
- - memory-region = <phandle>;		: Reference to the reserved memory for
-                                          the ColdFire. Must be 2M aligned on
-					  AST2400 and 1M aligned on AST2500
- - aspeed,sram = <phandle>;		: Reference to the SRAM node.
- - aspeed,cvic = <phandle>;		: Reference to the CVIC node.
-
-Examples:
-
-    fsi-master {
-        compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
-
-	clock-gpios = <&gpio 0>;
-        data-gpios = <&gpio 1>;
-        enable-gpios = <&gpio 2>;
-        trans-gpios = <&gpio 3>;
-        mux-gpios = <&gpio 4>;
-
-	memory-region = <&coldfire_memory>;
-	aspeed,sram = <&sram>;
-	aspeed,cvic = <&cvic>;
-    }

-- 
2.47.2


