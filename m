Return-Path: <linux-kernel+bounces-750305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2907B159C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F12A18C0A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE10290BA2;
	Wed, 30 Jul 2025 07:41:36 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.142.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65EB156CA;
	Wed, 30 Jul 2025 07:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.142.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753861296; cv=none; b=a65XvP8lK2Np+Kb/UIe1kcnn7/GpBK7w7OQmtYVAJiy6M/KzC/lg3jZgFyCjrBhOxFzQUM/7oTkV+bgMHFD6dz18NGU4SbCSXYz17eGkw584HD/q84ixvzQIgqGxpfSgUR8egT+zcjTeonKiNDQfo6iZ9eanuxQF2EIcJwvtOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753861296; c=relaxed/simple;
	bh=aXJZfYvSp54nqYbFpDzltlGne5k7sdyesh4BH8wBPYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kz9kff69uMi66TzB6u+xWZniV61OzWqZ4TRHc+9ADfB24Kvakb2QhmQW36w6nd0Dn37+oQSMSZKmsn7S7w934Yl1YZpVgedJ1s7+mpIUlULo1+lQTvCfGrvvl7nf3eI1l7FucQ0MqQJE6lvHOMuSF2Aq/zssqgqwBavjviU3ZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.142.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004758DT.eswin.cn (unknown [10.12.96.83])
	by app1 (Coremail) with SMTP id TAJkCgAnSxGXzIloMuG4AA--.52766S2;
	Wed, 30 Jul 2025 15:41:13 +0800 (CST)
From: zhangsenchuan@eswincomputing.com
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Thinh.Nguyen@synopsys.com,
	p.zabel@pengutronix.de
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	yangwei1@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Subject: [PATCH v2 1/2] dt-bindings: usb: Add Eswin EIC7700 USB controller
Date: Wed, 30 Jul 2025 15:40:57 +0800
Message-ID: <20250730074058.2004-1-zhangsenchuan@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250730073953.1623-1-zhangsenchuan@eswincomputing.com>
References: <20250730073953.1623-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgAnSxGXzIloMuG4AA--.52766S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1kWr45Kr4kKF1UCFyfJFb_yoW5trWfpa
	97CrW8Jr4fXr1fXa1rXF10kFsxJ3Z7CF10kr97Xr13trnaga40qw4akF15Ga4UCr1xZ34Y
	gFWYv3ySyw47C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUXJ5wUUUUU=
X-CM-SenderInfo: x2kd0wpvhquxxxdqqvxvzl0uprps33xlqjhudrp/

From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>

Add Device Tree binding documentation for the ESWIN EIC7700
USB controller module.

Co-developed-by: Wei Yang <yangwei1@eswincomputing.com>
Signed-off-by: Wei Yang <yangwei1@eswincomputing.com>
Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
---
 .../bindings/usb/eswin,eic7700-usb.yaml       | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml

diff --git a/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml b/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml
new file mode 100644
index 000000000000..c5a545d0ef49
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/eswin,eic7700-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Eswin EIC7700 SoC Usb Controller
+
+maintainers:
+  - Wei Yang <yangwei1@eswincomputing.com>
+  - Senchuan Zhang <zhangsenchuan@eswincomputing.com>
+
+description:
+  The Usb controller on EIC7700 SoC.
+
+properties:
+  compatible:
+    const: eswin,eic7700-usb
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: peripheral
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: suspend
+      - const: aclk
+      - const: cfg
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: vaux
+
+  ranges: true
+
+  eswin,hsp-sp-csr:
+    description:
+      The phandle to HSP(High-Speed Peripheral) Register Controller hsp_sp_csr node
+      and the offset of HSP register for USB.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to HSP Register Controller hsp_sp_csr node.
+          - description: usb bus register offset.
+          - description: axi low power register offset.
+          - description: vbus frequency register offset.
+          - description: mpll register offset.
+
+patternProperties:
+  "^usb@[0-9a-f]+$":
+    $ref: snps,dwc3.yaml#
+    description: Required child node
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - ranges
+  - eswin,hsp-sp-csr
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        usb {
+            compatible = "eswin,eic7700-dwc3";
+            clocks = <&fixed_factor_u_clk_1m_div24>,
+                     <&gate_clk_hsp_aclk>,
+                     <&gate_clk_hsp_cfgclk>;
+            clock-names = "suspend","aclk", "cfg";
+            eswin,hsp-sp-csr = <&hsp_sp_csr 0x800 0x808 0x83c 0x840>;
+            resets = <&reset 84>;
+            reset-names = "vaux";
+            ranges;
+            #address-cells = <2>;
+            #size-cells = <2>;
+
+            usb@50480000 {
+                compatible = "snps,dwc3";
+                reg = <0x0 0x50480000 0x0 0x10000>;
+                interrupt-parent = <&plic>;
+                interrupts = <85>;
+                interrupt-names = "peripheral";
+                dr_mode = "peripheral";
+                phy_type = "utmi";
+                maximum-speed = "high-speed";
+                snps,dis_enblslpm_quirk;
+                snps,dis-u2-freeclk-exists-quirk;
+                snps,dis_u2_susphy_quirk;
+                snps,dis-del-phy-power-chg-quirk;
+                snps,parkmode-disable-ss-quirk;
+            };
+        };
+    };
--
2.25.1


