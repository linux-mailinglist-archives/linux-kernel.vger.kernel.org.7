Return-Path: <linux-kernel+bounces-883213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BEBC2CBF1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 706184F535E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB78732D0C2;
	Mon,  3 Nov 2025 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Blad9cqd"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62D1315D33
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182921; cv=none; b=b1xLl3BHU6ODUwFNkSK0uQ2H8mVsGhSjyuhNIrfxwS495wH+B39gzwZtsAA1V+vDVoSu8By5784PNHceYHW9M079YHd9a5Eq1/+jUUA2L1zfJgL1YlbRQT7GK/Dt8tRi147YxGJMHZBE+qDD+Dlzd8hbKkSQmRZ8rxxfg43zlHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182921; c=relaxed/simple;
	bh=6zLrbsNdOw+RF1vfo8r3Y4gUwMpa+sUa/mCBcI57VdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8J3RKSrWfrc6HiJRjQLf5+6OwBEYtgxGHj7OGww+FyTFrR3c5j1a71oADAtSWEDZA3A6uEJx4ArUZQCll6oRB/0oJ6kgdfSWHqkiUa/DebHAl9UUmtydlkAftUpM3KSDf6WcH8wsnYq3luPeK9KH0Oi2e2sBxx47qlKdKeBWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Blad9cqd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b70b40e0284so11079166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762182917; x=1762787717; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQxFTb1ZOcfp5XwYP2yjswuY66Nch4hHpQK8nNOIWBw=;
        b=Blad9cqdLFXqhNxWohf64VsFBVUgEge+FQ8wvq/htgbjmpE87Qk9xa+AT7pXm3Qb4M
         LzBTfRtP5YjNVn1o5qOraTH5riqTy+D3hhpixHrdfY3HE6419HeeqvFXLZI1nX7E/zXc
         iyN/3zpUZ0c3OJhur0doEAPiBNrvzlZJihmDHnuCfc/CyNlA7HHxDSSfzibt3vatjxIa
         ZfgJ6om/HLgWTRvBwz6HgR2JM5pP4oahSkpv+nOgrXY58DqkD6nCYB7jhMAut33VXlWV
         GIvM2RzbGwwlDVqzusKjL1jsIUyv2S8WiD2TMJpYGHkEj/zgRiNOMV4xA8ox+8gIbuM5
         71Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182917; x=1762787717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQxFTb1ZOcfp5XwYP2yjswuY66Nch4hHpQK8nNOIWBw=;
        b=JkMM73yK7a5qWRnI5y3o/bsyR87WYWRfHd5U9C53iMvQwHe1/2Id/h4qnCcmJ2RkP+
         mo1tfUHl0oa1DgtFZhAbhr4wkA1KxqPkFnSvt/QX8sBGsF1JpfGN95YBVLK+33Xc6R9U
         6F3VyGf5n0QoIMXk9638V+2dmOyvRCEFCfLiWFS0cS+K2i59UG5S/qN5ZLzmw+mPJv54
         hVrrwi6FBnUG6pVROdGiy48uaoINWedc17E2I8YBBEzI/pc6o4CCDSvzigaPTmRkVEC+
         W0On+XljjPupeQDCZY7czp2K9lWYEzVDkLRmNc/7iS7/JGDOWD1opeFo69+V9as8AG5Q
         kS6A==
X-Forwarded-Encrypted: i=1; AJvYcCVcA5/zQA5wBF0EBK+AiTur3l/5eRMyGAFKi9i7WFzJWMIDON3+/UY9WXLgaCNJJ7ULMgJgE+FO1oUVMkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc11Mvs8A/51hVClnVKgPOqlSQn9vj0uRCGUvy/Rea8g6Vn9Wa
	NRW7XL4p7+s1ziOmTqolOFyYX6qAQV4e9+eUfE1UHKjWOKL+MY9IQqFTBJ+h0n5KGE8=
X-Gm-Gg: ASbGncsu/m2c6WOnqvuszDuosbj+/eYZ9PHWZP8Dn/uaAfCW901KbGYhHIha0i9FLKX
	x8ChGTXTfb430woD/RFpRNQRp/KC80JfshDXvkW+lAIZLqiaQDmQtc5xi7YZ7M9UhX83IGDYHB1
	RXbUewJbi302hFQqZJWBY3Txz4GqI/xVLCUWFVJxs9T3eC2Gti7IPtjogOwETIOWk8n8DlrPB2q
	QdrW3cp5giPnCXuHB2Tr7Y0NvEOFk2djGtSbxjRfJl3dR81HBw+OFEbBw108bD1fmYmcGWMZ5gr
	Nv0vk0RJHiNpANIZgq9PrUdtvoosXwofdcfSVuH9kuuAPdbSO9wLAwnDwb2QSZh6+UpJsj3IaOb
	qqRQCuq+NM5W8ffi5IFPN9zWJg/uD3QMYxLKsLvYmk3yLv0Hk30PekUAO0fkRsaeMmjDSXRhyRr
	HP8i4M5+W03amd/U0dzdZ1lAwAjzA=
X-Google-Smtp-Source: AGHT+IHuL2/Cjq5NZiEe4soNPjbv5x2oe35lPxJQ3zbu6D5N+9Lqbg5wAdfJX34AqbepeK7UWoDlZg==
X-Received: by 2002:a17:906:e17:b0:b70:e685:5ac8 with SMTP id a640c23a62f3a-b70e68592a2mr155340966b.3.1762182916879;
        Mon, 03 Nov 2025 07:15:16 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975dfdsm1045203066b.13.2025.11.03.07.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:15:16 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 03 Nov 2025 16:14:51 +0100
Subject: [PATCH 11/12] dt-bindings: PCI: qcom,pcie-msm8996: Move MSM8996 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dt-bindings-pci-qcom-v1-11-c0f6041abf9b@linaro.org>
References: <20251103-dt-bindings-pci-qcom-v1-0-c0f6041abf9b@linaro.org>
In-Reply-To: <20251103-dt-bindings-pci-qcom-v1-0-c0f6041abf9b@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8304;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=6zLrbsNdOw+RF1vfo8r3Y4gUwMpa+sUa/mCBcI57VdU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpCMbtRdRkC0ZBDnbYgUNPwgpHZ8ofoWQLN/8hU
 1nK1ri6vEuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQjG7QAKCRDBN2bmhouD
 1/2YEACEXSJ9CVdADKu2tLg52loSIs+2b6iiwbFeGWM3Bk4bwWVTCsCu0fg5hTUXVLojKQ4OIs1
 9WKtewp/a/9X7NiS9xejuHTIXsTMo9ONNWjgoPtccJxkjA3w/3zprT6rJMgQzMQyiaUSIVdFKZr
 /baaJ2n+rnSI/ndcIHlq2nz3+4R9DAOdt3tUR8UoBcLFDhYLCse52QcHmB3bTNnOpqdCZzvPHjR
 OhpHCivKLYbu8/oINjURXKOJXx/jLlwr5lFOBSp3C250Xnsl/Y1zz4aUBF+3dkB19DxIiCoo0+Y
 SAnrF2Ibnm1oVQUXt5yEqs/89gVVtk7Sk7chGjwhOp1ZwDTNZG9E4qe5oA2cnNksGAyIjFGdXon
 wD9BIKN7dEbJ5+h/5OGEV4C5bY+Nub4I2JSN29kZSByD0Y/xVtTrxeQVU+2e+hvgho8o4j+gu9u
 wvCr0bZKpTwUJk8pjYQf90COdO04HG46nKEFM3QC1zJnsgpoj/aLQZyAkGME0uS6WSu/z7XiXyr
 7bmUFZBmlnwDpRPiSvqZlmopiNXS1S+TOr0OtipFiXCdNkDzUckXz0uuabFWJNOgAbTVqyDE9Jx
 DdgTWvmxEDgJv2oczPmBrkcWfLVDdOJRfXXYIZpIuRHGxRGIHsnONqxy3ipGcqp90NUfj6lTW5j
 lU5R9FpZpiAkpGA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move MSM8996 PCIe devices from qcom,pcie.yaml binding to a dedicated
file to make reviewing and maintenance easier.

New schema is equivalent to the old one with few changes:
 - Adding a required compatible, which is actually redundant.
 - Drop the really obvious comments next to clock/reg/reset-names items.
 - Expecting eight MSI interrupts and one global, instead of only one,
   which was incomplete hardware description.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-msm8996.yaml | 156 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  61 --------
 2 files changed, 156 insertions(+), 61 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-msm8996.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-msm8996.yaml
new file mode 100644
index 000000000000..f2081ae1593f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-msm8996.yaml
@@ -0,0 +1,156 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-msm8996.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM8996 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - qcom,pcie-msm8996
+      - items:
+          - const: qcom,pcie-msm8998
+          - const: qcom,pcie-msm8996
+
+  reg:
+    minItems: 4
+    maxItems: 5
+
+  reg-names:
+    minItems: 4
+    items:
+      - const: parf
+      - const: dbi
+      - const: elbi
+      - const: config
+      - const: mhi
+
+  clocks:
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: pipe # Pipe Clock driving internal logic
+      - const: aux
+      - const: cfg
+      - const: bus_master # Master AXI clock
+      - const: bus_slave # Slave AXI clock
+
+  interrupts:
+    minItems: 8
+    maxItems: 9
+
+  interrupt-names:
+    minItems: 8
+    items:
+      - const: msi0
+      - const: msi1
+      - const: msi2
+      - const: msi3
+      - const: msi4
+      - const: msi5
+      - const: msi6
+      - const: msi7
+      - const: global
+
+  vdda-supply:
+    description: A phandle to the core analog power supply
+
+  vddpe-3v3-supply:
+    description: A phandle to the PCIe endpoint power supply
+
+required:
+  - power-domains
+
+allOf:
+  - $ref: qcom,pcie-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8996.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie@600000 {
+        compatible = "qcom,pcie-msm8996";
+        reg = <0x00600000 0x2000>,
+              <0x0c000000 0xf1d>,
+              <0x0c000f20 0xa8>,
+              <0x0c100000 0x100000>;
+        reg-names = "parf", "dbi", "elbi", "config";
+        ranges = <0x01000000 0x0 0x00000000 0x0c200000 0x0 0x100000>,
+                 <0x02000000 0x0 0x0c300000 0x0c300000 0x0 0xd00000>;
+
+        device_type = "pci";
+        bus-range = <0x00 0xff>;
+        num-lanes = <1>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        linux,pci-domain = <0>;
+
+        clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+                 <&gcc GCC_PCIE_0_AUX_CLK>,
+                 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+                 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+                 <&gcc GCC_PCIE_0_SLV_AXI_CLK>;
+        clock-names = "pipe",
+                     "aux",
+                     "cfg",
+                     "bus_master",
+                     "bus_slave";
+
+        interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 411 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi0",
+                          "msi1",
+                          "msi2",
+                          "msi3",
+                          "msi4",
+                          "msi5",
+                          "msi6",
+                          "msi7";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0x7>;
+        interrupt-map = <0 0 0 1 &intc GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                        <0 0 0 2 &intc GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                        <0 0 0 3 &intc GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                        <0 0 0 4 &intc GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+        pinctrl-names = "default", "sleep";
+        pinctrl-0 = <&pcie0_state_on>;
+        pinctrl-1 = <&pcie0_state_off>;
+
+        phys = <&pciephy_0>;
+        phy-names = "pciephy";
+
+        power-domains = <&gcc PCIE0_GDSC>;
+
+        perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
+        vddpe-3v3-supply = <&wlan_en>;
+        vdda-supply = <&vreg_l28a_0p925>;
+
+        pcie@0 {
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            bus-range = <0x01 0xff>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index a42e665a23a8..b071af484a1e 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -19,10 +19,6 @@ properties:
     oneOf:
       - enum:
           - qcom,pcie-apq8084
-          - qcom,pcie-msm8996
-      - items:
-          - const: qcom,pcie-msm8998
-          - const: qcom,pcie-msm8996
 
   reg:
     minItems: 4
@@ -75,9 +71,6 @@ properties:
   vdda-supply:
     description: A phandle to the core analog power supply
 
-  vddpe-3v3-supply:
-    description: A phandle to the PCIe endpoint power supply
-
   phys:
     maxItems: 1
 
@@ -124,7 +117,6 @@ allOf:
           contains:
             enum:
               - qcom,pcie-apq8084
-              - qcom,pcie-msm8996
     then:
       properties:
         reg:
@@ -162,27 +154,6 @@ allOf:
           items:
             - const: core # Core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-msm8996
-    then:
-      properties:
-        clocks:
-          minItems: 5
-          maxItems: 5
-        clock-names:
-          items:
-            - const: pipe # Pipe Clock driving internal logic
-            - const: aux # Auxiliary (AUX) clock
-            - const: cfg # Configuration clock
-            - const: bus_master # Master AXI clock
-            - const: bus_slave # Slave AXI clock
-        resets: false
-        reset-names: false
-
   - if:
       not:
         properties:
@@ -195,38 +166,6 @@ allOf:
         - resets
         - reset-names
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-msm8996
-              - qcom,pcie-msm8998
-    then:
-      oneOf:
-        - properties:
-            interrupts:
-              maxItems: 1
-            interrupt-names:
-              items:
-                - const: msi
-        - properties:
-            interrupts:
-              minItems: 8
-              maxItems: 9
-            interrupt-names:
-              minItems: 8
-              items:
-                - const: msi0
-                - const: msi1
-                - const: msi2
-                - const: msi3
-                - const: msi4
-                - const: msi5
-                - const: msi6
-                - const: msi7
-                - const: global
-
   - if:
       properties:
         compatible:

-- 
2.48.1


