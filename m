Return-Path: <linux-kernel+bounces-728743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC34B02C68
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 20:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CD23B644B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 18:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787EC290BA5;
	Sat, 12 Jul 2025 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qS10jkcS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D925629186F
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752344392; cv=none; b=URO3M2j30dwgheV4u+JHezWL3kA7WNKbbzGGVmcC6T+hhcXwjWlUqDB7JwqeBqShngX79QEFClKf3W1e3sRYdjcVLVcRJHP3wU6Bc/URoy5RagHO9Nt4PPQKsl8/aOr4wBS/jJ31399VmskYRW/mzAj5vcTNSvAJ5RZuA+83J4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752344392; c=relaxed/simple;
	bh=Y3hRCSsldPj5ARMnB/SrLEFEGqOAb0x2ImtikXO+zfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXwIORxuVCFVATk6xqifVd2finkLkW/2S0sTb6YfFZNNFabUw6pFvDCuCuYYYSLsFi7t3o4Oabs2OGvw7JAYfPDzB7fjnsThvZye/+3FCrk5jkZAF8l7J0cAZwRD0UTa4YAP2osTXutcW1rM1mh1Y/3/awiEyMQX2O1oJUILa9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qS10jkcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41132C4CEF5;
	Sat, 12 Jul 2025 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752344392;
	bh=Y3hRCSsldPj5ARMnB/SrLEFEGqOAb0x2ImtikXO+zfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qS10jkcScXsg0HOtLwwIAuTiO5O1qpOBRtwHvHVs76FH9dVsAtD9e5jWvQJMKqIs2
	 vF6IVkT0wS/4SFz3jVHWMGIh/y9sYl0dPgMlxH72J8I0whYwQqjDNXWAE+Y16a43ZN
	 sRv0/jYnNIwyKtl+UjDwIjKl0+FBID2v5qA7D9K20P7pEUFbfjsLuDrn7o0NdQ1aoE
	 sVb3joPytCJXxToKsc1N86UlRYyPiItFf1PGroXdJl/xPGlOjXT/ke5AFTEcL800yZ
	 ebYriMqfoOEQIlCDcjKqjva+xrdvNBmFX+eUAmllOoiTo2QCJA/k+0CPUNTH76yj99
	 abwM06w1nm+VQ==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 8/8] dt-bindings: nvmem: convert vf610-ocotp.txt to yaml format
Date: Sat, 12 Jul 2025 19:19:04 +0100
Message-ID: <20250712181905.6738-9-srini@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250712181905.6738-1-srini@kernel.org>
References: <20250712181905.6738-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

Convert vf610-ocotp.txt to yaml format.

Additional changes:
- Remove label in examples.
- Add include file in examples.
- Move reg just after compatible in examples.
- Add ref: nvmem.yaml and nvmem-deprecated-cells.yaml
- Remove #address-cells and #size-cells from required list to match existed
dts file.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 .../bindings/nvmem/fsl,vf610-ocotp.yaml       | 47 +++++++++++++++++++
 .../devicetree/bindings/nvmem/vf610-ocotp.txt | 19 --------
 2 files changed, 47 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,vf610-ocotp.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,vf610-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,vf610-ocotp.yaml
new file mode 100644
index 000000000000..5aef86a752a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/fsl,vf610-ocotp.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/fsl,vf610-ocotp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: On-Chip OTP Memory for Freescale Vybrid
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+allOf:
+  - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,vf610-ocotp
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: ipg clock we associate with the OCOTP peripheral
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/vf610-clock.h>
+
+    ocotp@400a5000 {
+        compatible = "fsl,vf610-ocotp", "syscon";
+        reg = <0x400a5000 0xcf0>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        clocks = <&clks VF610_CLK_OCOTP>;
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt b/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
deleted file mode 100644
index 72ba628f6d0b..000000000000
--- a/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-On-Chip OTP Memory for Freescale Vybrid
-
-Required Properties:
-  compatible:
-  - "fsl,vf610-ocotp", "syscon" for VF5xx/VF6xx
-  #address-cells : Should be 1
-  #size-cells : Should be 1
-  reg : Address and length of OTP controller and fuse map registers
-  clocks : ipg clock we associate with the OCOTP peripheral
-
-Example for Vybrid VF5xx/VF6xx:
-
-	ocotp: ocotp@400a5000 {
-		compatible = "fsl,vf610-ocotp", "syscon";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		reg = <0x400a5000 0xCF0>;
-		clocks = <&clks VF610_CLK_OCOTP>;
-	};
-- 
2.43.0


