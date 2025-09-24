Return-Path: <linux-kernel+bounces-831329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A45B9C5E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B01717544F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5CC296BAB;
	Wed, 24 Sep 2025 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1Flr4QV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1740028CF7C;
	Wed, 24 Sep 2025 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758753367; cv=none; b=JwZW2z1Eu5CXlnCPYysF6plLerzhMoF3ui9I8zIWJoHYVskkc54qO4SfVg9bXPVSfENdspKWWPKNLFBLtU9xyRntvR0SaFhsN5Xcy9Beopc4uHemNJBDJ9Czx4LKX8G37CvOJIDcCxaRLeXFIW7r4oNA1Q42YZcDWT7pV8dozA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758753367; c=relaxed/simple;
	bh=GI6jB9D994hRRmjawE8YU9X8HBiMYf9FyHhA+elKZog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dy5t4Jx0GTXrWQxVnLbyebBleLUr6njNzwRIjVKW9l4O2zDENDN4/0oohTFfVHZyihvZebGy+sDKM54GC17Sd4OfG4ieuVuOLp1+Sa+wfSU+V5y1qxau4yKus60g5LRElsHz8FsvOCkNaIDj/CsTZZuyBehboJYxM8YzCCPfP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1Flr4QV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A178AC4CEE7;
	Wed, 24 Sep 2025 22:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758753366;
	bh=GI6jB9D994hRRmjawE8YU9X8HBiMYf9FyHhA+elKZog=;
	h=From:To:Cc:Subject:Date:From;
	b=R1Flr4QVDck0e1cakyKMy/69Zzp+TYvEql9jGaC82Oa5aADIbhwa1N6VHTEJRjPmq
	 +mbZhDVBPLq+ZR4kYtIHpj//bxQ2e/G/vTaaw4Gty7/fZ1mPedPMk2AARnmtizyEJZ
	 35p1yZfMWVKHvTekYXfa+auuYbgJw5bg9u8xc/jB96wBML/wOt34rV0CtpbF4RXX/Z
	 6j7x+eOnIX8qEDqtxey49KT9cC6KycHiOPAhV76T4YWKGbNB3NlqnyGPFz9wnVngGO
	 Xit7hDo1lNnSjkSEUGqYiX/WnCNt2ShOPxBD8M5N4GkIYOWIgl8JhJJgJDJpqh4Hl3
	 EKTgduHoqZYEw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: gpu: Convert nvidia,gk20a to DT schema
Date: Wed, 24 Sep 2025 17:35:49 -0500
Message-ID: <20250924223551.2957340-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the NVIDIA GPU binding to DT schema format.

Add undocumented "interconnects" and "interconnect-names" properties for
gp10b and gv11b. Drop all but one example.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/gpu/nvidia,gk20a.txt  | 115 ------------
 .../devicetree/bindings/gpu/nvidia,gk20a.yaml | 171 ++++++++++++++++++
 2 files changed, 171 insertions(+), 115 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml

diff --git a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
deleted file mode 100644
index cc6ce5221a38..000000000000
--- a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt
+++ /dev/null
@@ -1,115 +0,0 @@
-NVIDIA Tegra Graphics Processing Units
-
-Required properties:
-- compatible: "nvidia,<gpu>"
-  Currently recognized values:
-  - nvidia,gk20a
-  - nvidia,gm20b
-  - nvidia,gp10b
-  - nvidia,gv11b
-- reg: Physical base address and length of the controller's registers.
-  Must contain two entries:
-  - first entry for bar0
-  - second entry for bar1
-- interrupts: Must contain an entry for each entry in interrupt-names.
-  See ../interrupt-controller/interrupts.txt for details.
-- interrupt-names: Must include the following entries:
-  - stall
-  - nonstall
-- vdd-supply: regulator for supply voltage. Only required for GPUs not using
-  power domains.
-- clocks: Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names: Must include the following entries:
-  - gpu
-  - pwr
-If the compatible string is "nvidia,gm20b", then the following clock
-is also required:
-  - ref
-If the compatible string is "nvidia,gv11b", then the following clock is also
-required:
-  - fuse
-- resets: Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names: Must include the following entries:
-  - gpu
-- power-domains: GPUs that make use of power domains can define this property
-  instead of vdd-supply. Currently "nvidia,gp10b" makes use of this.
-
-Optional properties:
-- iommus: A reference to the IOMMU. See ../iommu/iommu.txt for details.
-
-Example for GK20A:
-
-	gpu@57000000 {
-		compatible = "nvidia,gk20a";
-		reg = <0x0 0x57000000 0x0 0x01000000>,
-		      <0x0 0x58000000 0x0 0x01000000>;
-		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "stall", "nonstall";
-		vdd-supply = <&vdd_gpu>;
-		clocks = <&tegra_car TEGRA124_CLK_GPU>,
-			 <&tegra_car TEGRA124_CLK_PLL_P_OUT5>;
-		clock-names = "gpu", "pwr";
-		resets = <&tegra_car 184>;
-		reset-names = "gpu";
-		iommus = <&mc TEGRA_SWGROUP_GPU>;
-	};
-
-Example for GM20B:
-
-	gpu@57000000 {
-		compatible = "nvidia,gm20b";
-		reg = <0x0 0x57000000 0x0 0x01000000>,
-		      <0x0 0x58000000 0x0 0x01000000>;
-		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "stall", "nonstall";
-		clocks = <&tegra_car TEGRA210_CLK_GPU>,
-			 <&tegra_car TEGRA210_CLK_PLL_P_OUT5>,
-			 <&tegra_car TEGRA210_CLK_PLL_G_REF>;
-		clock-names = "gpu", "pwr", "ref";
-		resets = <&tegra_car 184>;
-		reset-names = "gpu";
-		iommus = <&mc TEGRA_SWGROUP_GPU>;
-	};
-
-Example for GP10B:
-
-	gpu@17000000 {
-		compatible = "nvidia,gp10b";
-		reg = <0x0 0x17000000 0x0 0x1000000>,
-		      <0x0 0x18000000 0x0 0x1000000>;
-		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH
-			      GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "stall", "nonstall";
-		clocks = <&bpmp TEGRA186_CLK_GPCCLK>,
-			 <&bpmp TEGRA186_CLK_GPU>;
-		clock-names = "gpu", "pwr";
-		resets = <&bpmp TEGRA186_RESET_GPU>;
-		reset-names = "gpu";
-		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_GPU>;
-		iommus = <&smmu TEGRA186_SID_GPU>;
-	};
-
-Example for GV11B:
-
-	gpu@17000000 {
-		compatible = "nvidia,gv11b";
-		reg = <0x17000000 0x1000000>,
-		      <0x18000000 0x1000000>;
-		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "stall", "nonstall";
-		clocks = <&bpmp TEGRA194_CLK_GPCCLK>,
-			 <&bpmp TEGRA194_CLK_GPU_PWR>,
-			 <&bpmp TEGRA194_CLK_FUSE>;
-		clock-names = "gpu", "pwr", "fuse";
-		resets = <&bpmp TEGRA194_RESET_GPU>;
-		reset-names = "gpu";
-		dma-coherent;
-
-		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_GPU>;
-		iommus = <&smmu TEGRA194_SID_GPU>;
-	};
diff --git a/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
new file mode 100644
index 000000000000..4d856a8b674c
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/nvidia,gk20a.yaml
@@ -0,0 +1,171 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpu/nvidia,gk20a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra Graphics Processing Units
+
+maintainers:
+  - Alexandre Courbot <acourbot@nvidia.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <treding@nvidia.com>
+
+properties:
+  compatible:
+    enum:
+      - nvidia,gk20a
+      - nvidia,gm20b
+      - nvidia,gp10b
+      - nvidia,gv11b
+
+  reg:
+    items:
+      - description: Bar0 register window
+      - description: Bar1 register window
+
+  interrupts:
+    items:
+      - description: Stall interrupt
+      - description: Nonstall interrupt
+
+  interrupt-names:
+    items:
+      - const: stall
+      - const: nonstall
+
+  vdd-supply:
+    description:
+      Regulator for GPU supply voltage
+
+  clocks:
+    minItems: 2
+    items:
+      - description: GPU clock
+      - description: Power clock
+      - description: Reference or fuse clock
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: gpu
+      - const: pwr
+      - enum: [ ref, fuse ]
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: gpu
+
+  power-domains:
+    maxItems: 1
+
+  interconnects:
+    minItems: 4
+    maxItems: 12
+
+  interconnect-names:
+    minItems: 4
+    maxItems: 12
+
+  iommus:
+    maxItems: 1
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,gp10b
+              - nvidia,gv11b
+    then:
+      required:
+        - power-domains
+    else:
+      properties:
+        interconnects: false
+        interconnect-names: false
+
+      required:
+        - vdd-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,gp10b
+    then:
+      properties:
+        interconnects:
+          maxItems: 4
+
+        interconnect-names:
+          items:
+            - const: dma-mem
+            - const: write-0
+            - const: read-1
+            - const: write-1
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,gv11b
+    then:
+      properties:
+        interconnects:
+          minItems: 12
+
+        interconnect-names:
+          items:
+            - const: dma-mem
+            - const: read-0-hp
+            - const: write-0
+            - const: read-1
+            - const: read-1-hp
+            - const: write-1
+            - const: read-2
+            - const: read-2-hp
+            - const: write-2
+            - const: read-3
+            - const: read-3-hp
+            - const: write-3
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/tegra124-car-common.h>
+    #include <dt-bindings/memory/tegra124-mc.h>
+
+    gpu@57000000 {
+        compatible = "nvidia,gk20a";
+        reg = <0x57000000 0x01000000>,
+              <0x58000000 0x01000000>;
+        interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "stall", "nonstall";
+        vdd-supply = <&vdd_gpu>;
+        clocks = <&tegra_car TEGRA124_CLK_GPU>,
+                 <&tegra_car TEGRA124_CLK_PLL_P_OUT5>;
+        clock-names = "gpu", "pwr";
+        resets = <&tegra_car 184>;
+        reset-names = "gpu";
+        iommus = <&mc TEGRA_SWGROUP_GPU>;
+    };
-- 
2.51.0


