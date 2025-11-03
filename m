Return-Path: <linux-kernel+bounces-883201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27591C2CC27
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81F0188DBA1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D1132573A;
	Mon,  3 Nov 2025 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1kJzan/"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605D0325497
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182903; cv=none; b=E86sFR0HAWDSe7SPuzzqBjJaXb8SUhxau2wxaIVk/StGgGP+cdsDYSZlZyeBfjpm1ylnLfKrldzCcpdWb8ydI0Ubef7GGgucm65ySCfCZlC5ARwOZL36zwva7T2GZ/0uRs0ZONorG9LiqDhTqlqXA7wmIISO54rDI0EVEdUTPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182903; c=relaxed/simple;
	bh=egHww2t1z7O8lMAW4nDR4uMRLOlHCAlm1FDiQSbolnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s3LRC2GvUhkre66Tzodhq/ztS1Tp2kKEkZ+0627/2uK54EUUTWrlAskvsNWjczt2NPt5PgZd5rhP4R9TbKTsv0UdgkcIObQM8axGVMxNL09ftXPfdeYQOuNl9Gsi1mzi3W1L/U3rgxgZ2TdBtNIENhRWguiNozCBwbErQx64kH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H1kJzan/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64075080480so759754a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762182900; x=1762787700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChU9xcP6l7Vj6IpJ2XKjkHdCFEUFK/0Ic063b9tHQ60=;
        b=H1kJzan/233Zuj88+Sc4Wk8f3CiFwn3DankyA98FUezq3p0cfapRGvNyMqRKb5W2dz
         tXKlxZHCGKTMdvSLZ4UoCVVsR80ar9Yuy60AzYZtoEFbHX3OOIghwgnKNGN7L/DR7TjR
         U+H7VwwhILLOPnh4KdIYCnHL7aVdSYozG+Kh4LjRup3hi3//TrbnGzrnjRt6ZaxjouhL
         zJ5e09gGWpPgOMDO8xAMW6cQgaM8hxPf9hg+FVNmEpC2NbCtgw7dle2g1GZBDZRwE9yY
         SxceXuSCg1JhRCRzmLzvZGOYZfHrxHnUXHpMe8VHAvnIvTbUIGLU5faiLDy41VBvDK3Y
         8paA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182900; x=1762787700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChU9xcP6l7Vj6IpJ2XKjkHdCFEUFK/0Ic063b9tHQ60=;
        b=KwjHGtYDqyc9HTm2vkjmHaJAF1UZWKjcGeVBqyhucwe1yZc8BCBZ/cqMdhbbPwIqYX
         7KhG4rNhw52ihEQ4AkN9AF2TjBJ8E8ZA6mpdxO3rJ981jrLYWHi5DUPxacynzMKGit2+
         jz1wHhYWPM+n6MafkW/wda0VSBej2x1g7NVKkcQehOIjFKVmwOWpZSX7g6z0BUPRh2XG
         4YU5itEPFsdfqEhBHU1Pz2PRm8EWdmBc080f2CvKeejGGI62BbW9FN9/lFNTn8WhkLWX
         szgz7KsUnLEAgGtLmEe0/NyrCi4Luu18ShtmIiGDYAJ3sKAnGdJ0K7qjLdzFQSFt/Kk3
         w3cA==
X-Forwarded-Encrypted: i=1; AJvYcCUSoXVktzp2oLe0tUY6M+i1zZr7y+pD8Si5ConOLNJjuJrmTj83fqpqoVLqFQhwF3k9t/28jYwWDGbhijI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLW05ALN0m16pDwW2VFqEZG0tJqvLhsKEyimYbR8VLF/yiQps+
	6h9dO7fBRuO9n5YsxDPlpuFLJZFA+YLx6l8BNvaBA/rzcn8Ccpiu+nmYeE1W+RnX1aI=
X-Gm-Gg: ASbGncvhnHnvky8tDt7Go5oFlCR83vApCEkYm0hVZ6rhFrcCt0EFv3daxPTOUhy8bjd
	dTKFUzv36hre0RyuUZMSFoolaQtKrjAc49otpGyanE+iwc+AhqxRWlpU0LoEY1tfkFTzgQo94mX
	edP3pBewyinr+ZW92OZ/Lx58NbqLnsKmeTJnpXHFXYqPAegn4CJqhTIvmCJZrgSBjUahljJyC4o
	s0yHvtphXDRUeBGYahklN21XflrqgTxiNE4L2A8pLUp1uyw5hiwgYI6NLmccTPGxVZlkZrA+x1m
	YSA72diAecJTFQ3X8ePZzcPozvmEPtYiiDyDlRKAYuS415zoiDdbko91/t+xFbjOueHFg8X8Kio
	baJHunGw/2XPPQmkZhtkX+rgonOAO/wOJkop9qMApGi2MwAgknl0THZN0YSUxFMfrYs+t72ql7O
	HOEZLDmC+QZGh9JszY
X-Google-Smtp-Source: AGHT+IGO1QZdLsp5RDeaAkvSiJvBz83lfZBDLxcTKsYb6sp8J8NF8tf7de2//pzCihxlCT9dk4XJLw==
X-Received: by 2002:a17:906:2683:b0:b70:bb39:6f34 with SMTP id a640c23a62f3a-b70bb398a8emr174411166b.1.1762182899017;
        Mon, 03 Nov 2025 07:14:59 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975dfdsm1045203066b.13.2025.11.03.07.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:14:57 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 03 Nov 2025 16:14:41 +0100
Subject: [PATCH 01/12] dt-bindings: PCI: qcom,pcie-sm8150: Merge SC8180x
 into SM8150
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dt-bindings-pci-qcom-v1-1-c0f6041abf9b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6918;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=egHww2t1z7O8lMAW4nDR4uMRLOlHCAlm1FDiQSbolnQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpCMbkbycgIuII735kdFAk5l4/HQanwul6bIOoV
 O31e1EFk4WJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQjG5AAKCRDBN2bmhouD
 1/5vD/91z+wKMVCx1xw6cB2blR0nC4FmrkHdj3/ipVGRrpkIvXwzwcnr8KjprOewWDgZVTtUxV+
 rEMKWBLt6vP0b4ho5RlbEVBvS2t/cx7nrCbOXY1a1tyq2qERz5fisVCDynU9bAZ+zLbk5WFazmn
 LS5ZC7oFpI6jVWyP1zhz5Nnr+6QPdAMwFHJYrzAfDh0L+oXuxwzIDxvWAqcxPxIZbw6FG+Ssz/X
 Usi3oCGvuiyBXm5ydxdW2rPsPmAjXmr7eFpgLOJH9/pK1TVjodcXJ8tOnfhROKeQaV6jfli01de
 cczaEHs93zvpqO8EGxVHAqPxTMQ8GM8jy1yGTzWYPcSj+RGs1FMPp6q37tPCOBDNu8XAbY1FGKF
 yp/LBkllnyNdW7eH/HCdXXUaR2VlV09PxP3JDODm73UiuULe/936g3mXzBRJAQGwFkJluNucJdX
 U/mwb8Tu2WClOcHjmIUpC6xI3eRKU40hmcraTskU4a6dzzsMQMZHVoL1LvOI3U3XKckaVkIo+Oj
 sjmHic8+UuA//A328NVGKWnc2Kwh826vrzXEhSLqgSpAJ9l6QmY3mu1vwEKiTq4qgmK7pWMrkYV
 rBPRpP+QlmzHDp2bWRmqC3T+e2wdVui23WRFj6OZKoC0EBXD5/+H36DsGjS/DbJyHNqoHw3tDAL
 iL76VZ0o3oLAd7A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

After the commit 26daa18e35eb ("dt-bindings: PCI: qcom,pcie-sc8180x:
Drop unrelated clocks from PCIe hosts") and the
commit e1cb67ab82aa ("dt-bindings: PCI: qcom,pcie-sm8150: Drop unrelated
clocks from PCIe hosts"), which dropped two clocks from each of the
bindings, the devices share entire binding and could be kept in one file
for simplicity.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml | 168 ---------------------
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  |   1 +
 2 files changed, 1 insertion(+), 168 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
deleted file mode 100644
index 34a4d7b2c845..000000000000
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
+++ /dev/null
@@ -1,168 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/pci/qcom,pcie-sc8180x.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm SC8180x PCI Express Root Complex
-
-maintainers:
-  - Bjorn Andersson <andersson@kernel.org>
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
-
-description:
-  Qualcomm SC8180x SoC PCIe root complex controller is based on the Synopsys
-  DesignWare PCIe IP.
-
-properties:
-  compatible:
-    const: qcom,pcie-sc8180x
-
-  reg:
-    minItems: 5
-    maxItems: 6
-
-  reg-names:
-    minItems: 5
-    items:
-      - const: parf # Qualcomm specific registers
-      - const: dbi # DesignWare PCIe registers
-      - const: elbi # External local bus interface registers
-      - const: atu # ATU address space
-      - const: config # PCIe configuration space
-      - const: mhi # MHI registers
-
-  clocks:
-    minItems: 6
-    maxItems: 6
-
-  clock-names:
-    items:
-      - const: pipe # PIPE clock
-      - const: aux # Auxiliary clock
-      - const: cfg # Configuration clock
-      - const: bus_master # Master AXI clock
-      - const: bus_slave # Slave AXI clock
-      - const: slave_q2a # Slave Q2A clock
-
-  interrupts:
-    minItems: 8
-    maxItems: 9
-
-  interrupt-names:
-    minItems: 8
-    items:
-      - const: msi0
-      - const: msi1
-      - const: msi2
-      - const: msi3
-      - const: msi4
-      - const: msi5
-      - const: msi6
-      - const: msi7
-      - const: global
-
-  resets:
-    maxItems: 1
-
-  reset-names:
-    items:
-      - const: pci
-
-allOf:
-  - $ref: qcom,pcie-common.yaml#
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/clock/qcom,gcc-sc8180x.h>
-    #include <dt-bindings/interconnect/qcom,sc8180x.h>
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-
-    soc {
-        #address-cells = <2>;
-        #size-cells = <2>;
-
-        pcie@1c00000 {
-            compatible = "qcom,pcie-sc8180x";
-            reg = <0 0x01c00000 0 0x3000>,
-                  <0 0x60000000 0 0xf1d>,
-                  <0 0x60000f20 0 0xa8>,
-                  <0 0x60001000 0 0x1000>,
-                  <0 0x60100000 0 0x100000>;
-            reg-names = "parf",
-                        "dbi",
-                        "elbi",
-                        "atu",
-                        "config";
-            ranges = <0x01000000 0x0 0x60200000 0x0 0x60200000 0x0 0x100000>,
-                     <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>;
-
-            bus-range = <0x00 0xff>;
-            device_type = "pci";
-            linux,pci-domain = <0>;
-            num-lanes = <2>;
-
-            #address-cells = <3>;
-            #size-cells = <2>;
-
-            assigned-clocks = <&gcc GCC_PCIE_0_AUX_CLK>;
-            assigned-clock-rates = <19200000>;
-
-            clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
-                     <&gcc GCC_PCIE_0_AUX_CLK>,
-                     <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
-                     <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
-                     <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
-                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>;
-            clock-names = "pipe",
-                          "aux",
-                          "cfg",
-                          "bus_master",
-                          "bus_slave",
-                          "slave_q2a";
-
-            dma-coherent;
-
-            interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names = "msi0",
-                          "msi1",
-                          "msi2",
-                          "msi3",
-                          "msi4",
-                          "msi5",
-                          "msi6",
-                          "msi7",
-                          "global";
-            #interrupt-cells = <1>;
-            interrupt-map-mask = <0 0 0 0x7>;
-            interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-                            <0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-                            <0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-                            <0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
-
-            interconnects = <&aggre2_noc MASTER_PCIE 0 &mc_virt SLAVE_EBI_CH0 0>,
-                            <&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_PCIE_0 0>;
-            interconnect-names = "pcie-mem", "cpu-pcie";
-
-            iommu-map = <0x0 &apps_smmu 0x1d80 0x1>,
-                        <0x100 &apps_smmu 0x1d81 0x1>;
-
-            phys = <&pcie0_phy>;
-            phy-names = "pciephy";
-
-            power-domains = <&gcc PCIE_0_GDSC>;
-
-            resets = <&gcc GCC_PCIE_0_BCR>;
-            reset-names = "pci";
-        };
-    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
index 17c0d58af37c..0e0adbb25b68 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
@@ -17,6 +17,7 @@ description:
 properties:
   compatible:
     oneOf:
+      - const: qcom,pcie-sc8180x
       - const: qcom,pcie-sm8150
       - items:
           - enum:

-- 
2.48.1


