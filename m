Return-Path: <linux-kernel+bounces-802886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D8BB457FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3883B8DFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32451350845;
	Fri,  5 Sep 2025 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDtrSrjb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E98A34F486;
	Fri,  5 Sep 2025 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076003; cv=none; b=KZ+HvlZhlucYltUf94H4apu3KXzqCBt9+AQVSlEhdVN7cC/E+D0pIJlu6z7W9nvBHNUBJ9PG/z8eJ/D0E6YoXnxW8jqtzSbeOGhajxtj6QarYUEDUuvMG8NKHSK+51Bc6qNoYsLv2Pm/VSn4+S3vGLzs08TQ+V0qhmmEq9wRFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076003; c=relaxed/simple;
	bh=dnjRpNqUHpCCqmEgd85I4QFT6pOpZkdtOu7seS3QRUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WanHy5AjDlPBFCh5pr6GCZ2ubWUwc3BH7wXPpJacaHJIqi2B1rXMTQTR79SIWqW89j1v0HiP6r3hcqsdsvs2vPuLJHZMGh178+CkRrag6EAhTbe2WC3Y4aQZYTyBM9mX/KcLHkaIqgvHCFBZdOosabOftzmtikYlO0EzaTjhZHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDtrSrjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F616C4CEF8;
	Fri,  5 Sep 2025 12:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757076002;
	bh=dnjRpNqUHpCCqmEgd85I4QFT6pOpZkdtOu7seS3QRUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oDtrSrjb/KUUxLaKU2ClfX94QXSWBl4PBvKEIznBNYdEeI0fzKo9ABS9f1XR/dEZy
	 1B19YA1Ngolj767KZbitAN/pA8Aua7HEHtglhY6j8QfPSE37G1pXSZvrLymPOgrBMv
	 nCWrcGQA7TY8fOprbZ+2M0PUN89nVnv1wj0hERriiT3aeDSYOElDI1xfoHElY5vOk+
	 hmggRFH1fPg1GsXX62/PyDY7JfBkHFcin32l9Ff1k49DCM5cZ60haekm987dYogRyE
	 PhBFMB1Y1dVOUOkXIKbbw0/AsKoe7Cc/+Qw4zyiTT5wCRVSyxopMAGDhQncf5oD1X7
	 LoX8lKbDDj10A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC3ACA1013;
	Fri,  5 Sep 2025 12:40:01 +0000 (UTC)
From: Woodrow Douglass via B4 Relay <devnull+wdouglass.carnegierobotics.com@kernel.org>
Date: Fri, 05 Sep 2025 08:39:42 -0400
Subject: [PATCH v7 1/2] regulator: dt-bindings: nxp,pf530x: Add NXP
 PF5300/PF5301/PF5302 PMICs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-pf530x-v7-1-10eb2542f944@carnegierobotics.com>
References: <20250902-pf530x-v7-0-10eb2542f944@carnegierobotics.com>
In-Reply-To: <20250902-pf530x-v7-0-10eb2542f944@carnegierobotics.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Woodrow Douglass <wdouglass@carnegierobotics.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2021;
 i=wdouglass@carnegierobotics.com; h=from:subject:message-id;
 bh=GD/QKOeIwH6rbORAuBGoRr4qUHkMzXDClFHYwzK9aEo=;
 b=owEBbQGS/pANAwAKAewLuLlPNh4UAcsmYgBoutohx0/o4FKRg04xIhoXtqGt+27lNHYVpW1JX
 3H4P5K3WbCJATMEAAEKAB0WIQSIUqjrbDLQw0mgxHLsC7i5TzYeFAUCaLraIQAKCRDsC7i5TzYe
 FI/dCACW0IxiwITRW1ui2rqoV6KRQAW894ZHeskC9UF9YeYKhmKK8VmMm/AGeH8Vc0wxG8sL/wh
 CvktFGvZp36fXeHSIbbFCHB80o2e0QS74qyw/Pi5klColoZEXLwtEFCdUZNudwX9tRXKPVDUTSc
 dH/XwJH9vo2RjQlfYltjeyp3AT/AB2GyhK/6xDCOCSqMiNKWutKLW93PumnF3mRnzFPat5ojZaM
 Qj3xep1a2WAjhVjTldcHwsVHElyucESvujLeZA9Gn1Q87X9kcQOdwIB0b8/O/87AnQg2zIn7ymX
 JZ5g/65o8mHa0Zrew9iWy2K96v1ptySWSZum7N+v+Md+/g7I
X-Developer-Key: i=wdouglass@carnegierobotics.com; a=openpgp;
 fpr=8852A8EB6C32D0C349A0C472EC0BB8B94F361E14
X-Endpoint-Received: by B4 Relay for wdouglass@carnegierobotics.com/default
 with auth_id=514
X-Original-From: Woodrow Douglass <wdouglass@carnegierobotics.com>
Reply-To: wdouglass@carnegierobotics.com

From: Woodrow Douglass <wdouglass@carnegierobotics.com>

Bindings for the pf530x series of voltage regulators

Signed-off-by: Woodrow Douglass <wdouglass@carnegierobotics.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/regulator/nxp,pf5300.yaml  | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
new file mode 100644
index 000000000000..5b9d5d4e48d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/nxp,pf5300.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/nxp,pf5300.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP PF5300/PF5301/PF5302 PMIC regulators
+
+maintainers:
+  - Woodrow Douglass <wdouglass@carnegierobotics.com>
+
+description: |
+  The PF5300, PF5301, and PF5302 integrate high-performance buck converters,
+  12 A, 8 A, and 15 A, respectively, to power high-end automotive and industrial
+  processors. With adaptive voltage positioning and a high-bandwidth loop, they
+  offer transient regulation to minimize capacitor requirements.
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: nxp,pf5300
+      - items:
+          - enum:
+              - nxp,pf5301
+              - nxp,pf5302
+          - const: nxp,pf5300
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@28 {
+            compatible = "nxp,pf5302", "nxp,pf5300";
+            reg = <0x28>;
+
+            regulator-always-on;
+            regulator-boot-on;
+            regulator-max-microvolt = <1200000>;
+            regulator-min-microvolt = <500000>;
+        };
+    };

-- 
2.39.5



