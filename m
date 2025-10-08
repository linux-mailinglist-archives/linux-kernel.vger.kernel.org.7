Return-Path: <linux-kernel+bounces-845177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2436FBC3CA3
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0B519E23C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263282F39CD;
	Wed,  8 Oct 2025 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eHEGt6g9"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645CB2F0C6F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759911487; cv=none; b=t8iT7dXMxSvdT+438AMoLJhO/k6CoKPB5qC6BMcqYiwhZqeSiMdSPLq53VXpAmqSEjSDE32viV9gy33GQpVkRsAZBPeo1pq9+w7DZJacVzgLsxfm0H/HuODby76o+r4Y7phvRyY0PXSaDGaf7rShst27416qSSOiPp9OVyWpJK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759911487; c=relaxed/simple;
	bh=uciJlq+TbXsKutG22uU7xLtKChzbr5uSBiBa5VcNwoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BXKav5eaoTP/rGRZP4zmAVyPtfEjzx5AWiOcEoewo5a9cYXfTidsO4AZCZzj+aMpqEyXH6+sbY0xCe3m/6/aUCEeK8WAjqxNaQyASkDNNbry8/Zg37k/RIqFHb5dhoxG6qxs4SjTFk7Rkp+A2ZRl0UaIU5TX2sJ7gRvmeIIg6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eHEGt6g9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42557c5cedcso3573817f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759911483; x=1760516283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBlQSSiEamv+oYM2If/aD+aYUWLw42K0i3enm5+zupw=;
        b=eHEGt6g9X2ItHKIIO8tmUD/k0LpSLnBnPOOLZ3G1DNwUFTxSX8iniEiQ7j1/37SD32
         RWV50crPmeC4CkBA0DKLGcIaSovQ/w6wlua/Jazz3tZAvs4lXv774alX34UtN2IYE54k
         5e3pJauDelOxt41YB8i3lFrum9SEB3wqoB8S7Y1tvRhttaExNh7twO6M529/AZDCnmWs
         w+fVyg4RYsiP7GK03FNPY3fWj1rkkALGmNfXJ56EpH7ph0x7Sw28sn6HQ3vZ7THb0cJ7
         Y+3rx/MO36BZGV5aWdHToJChJX1p1frmry7y+0RihrpE/aTXUcc4hU8dECNuyOdL10ER
         FP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759911483; x=1760516283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBlQSSiEamv+oYM2If/aD+aYUWLw42K0i3enm5+zupw=;
        b=WG32R0zVnBG4Yly7kHnSZbgq1026YlyLhfm2Q3BKFdTfIzKzF+dfy4ej9KbYVMuEF9
         UAFktkjt3PDhl1OvA47mJWNOjH4T/3sMssSqetho6OkS/6txNavKEs1UVJkVCtZOZgJZ
         2zaGR5nGSVWl+H29SvpXQbyuLeaA9bayBcZf7280qznaMlJt+6fs8cyLxpWZx8rzxnLh
         ytMGKDRCgOTdEw99KEsdVrrmewINrkvOkEIh4GQC4XG6fnbS8zcpJTipny+UW6Df4WDX
         fWX2S3lmeNMmEZO9IdMfttx985nJvs+4KpSsRyOC+660c3H1vislgRYeANIC9CWCx9ih
         YiXA==
X-Forwarded-Encrypted: i=1; AJvYcCWjqzYOAj0tUnUApFxfd8QsATyDvru6/MR/ca/P+/qgPn9Qm2XzupyaPWI7ZRO4Ge6vRbduKxPqloJDlqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxWbNYeNlaQdhRRikQXnhsC/kaIfP1alBoW59q+STtCutGXY8W
	2Bjqwd2fYAXEVTGFoWwlxTax27FBUSILXDkI2XCCcCB2myU2sXZkxt29mC54yaogZ96/P1eE1Ha
	3Prsbi14=
X-Gm-Gg: ASbGnctvNqlVj7RFSEi8KUlOQhVaHJN7nZJmYuQ3bGE1t75XcPBQ5VfYtQhoNsUCghT
	AncOHymK0/bfGjwbRr1nagQMwH5UV51ZFIzIUcuLL3Dj/lEs4GMC+TXndGFWnOIMRBGtJj/0Bw+
	C8ubKs4vco6TXmPPTU1EwolGiuZTONyED7K+SkXqJfEuVs7SDNrEK4XKptgf3UE/hYsLkVnZ/qf
	kXaQzIfrfViqmOuvnBKbUtP/tYSvlMOZkOk3W/zNvH9Y8hOjVBG+mZ1oeBnplp5pwqvag+1j0SM
	bVH1tEnkxjfDJt8pm+7g2IEhGEXQK6sp4O0WyYCOUOPNSNgG+OMSEAz5qdhTzJdaIsfqFy8+H2R
	FD6r3jbtn7K+nZFh5lcetdoTwLLFyXOG387XUbC2oCdCBN7vzuSKe
X-Google-Smtp-Source: AGHT+IHFjiAXaEAX/qwdcuEj85ehmkltNO/B2fGV2gAeQQvqe2timCfHbDTdR4nqHfSt59VV8hUwRg==
X-Received: by 2002:a5d:5c8a:0:b0:415:7a6c:6a38 with SMTP id ffacd0b85a97d-4266e8e6ebemr1270056f8f.59.1759911482606;
        Wed, 08 Oct 2025 01:18:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:286d:ff1d:8b7c:4328])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e97f0sm28498943f8f.27.2025.10.08.01.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 01:18:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 08 Oct 2025 10:17:48 +0200
Subject: [PATCH v2 1/8] dt-bindings: net: qcom: document the ethqos device
 for SCMI-based systems
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-qcom-sa8255p-emac-v2-1-92bc29309fce@linaro.org>
References: <20251008-qcom-sa8255p-emac-v2-0-92bc29309fce@linaro.org>
In-Reply-To: <20251008-qcom-sa8255p-emac-v2-0-92bc29309fce@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4930;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=jt98/fKCMiWsJRKIBoUPImv7pfYjdVSMRpukpIdLRi0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo5h41r2ZAFmiwUn7PgIvcsf9/Ki1be/TmFs6ex
 u9nsqOD39GJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOYeNQAKCRARpy6gFHHX
 cmLzEADDqXLdT+V7DmBbV2ZHe6RevBtvs/WskQguIekDpkpNMLSZUe9utgX4MAErix3Em600Fzb
 Tkj9Kqh+36Bc1FRGcZdRxZe73pOJpCGuCmG/KRJF5tLYIJyahyZC1508jX2v7hNmyGf6mo9E82N
 6/NDjG6ER2cU5IYtRDXLCbZHCxLJ55/QETUEBaEDppvVeYw2fuHPkXI72YN/rEZXDH/H/53yqlE
 2S1DabEok5qR3ZriVTUgPrb1A5F/Mwl/cSXsC0Z08RNG1kLKgKnOEkyJiGDQGXMI2KaBS0hKwCY
 cU9b7DMtbM0N9iWaFSPSjx0dTPcnmYvibwW7lvnhzDdeIEt3KHnD7PBgr2dOxUIJ1HGKarNYk01
 /70LZu4CmKqAZCP7cmP1mOA3lQWM9bMoQRQfcHyRrCIwb9NapxwyzZhqFtFnljzzrfoIUkLVR/b
 buL4wdvPvzHXXcsESe+jKltN0EA5k9iEWoeyMoeh5G+6BulF9UXbnw0k0s+8nFI6SeaEHCTdswK
 fP+l7j4Y1xw8Eg8ytjO4p30MMZso6krN7sHCC3JpUbVn83uAbqc+l53bbiyaEe0q1D2ZT/FxloU
 qX0NuHdAFujSg0cBE4rrb8p4H9I8Jbb7r8FKuj0nL1/bRE1uZkC3ZDexsMgQ1McQhE+YUNpAjUA
 n39CRzJaFaAqWnw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Describe the firmware-managed variant of the QCom DesignWare MAC. As the
properties here differ a lot from the HLOS-managed variant, lets put it
in a separate file.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../devicetree/bindings/net/qcom,ethqos-scmi.yaml  | 101 +++++++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml        |   5 +-
 MAINTAINERS                                        |   1 +
 3 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos-scmi.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos-scmi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..0a9cc789085e8bc94d44adc9da982b66071d1e79
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qcom,ethqos-scmi.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/qcom,ethqos-scmi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Ethernet ETHQOS device (firmware managed)
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Konrad Dybcio <konradybcio@kernel.org>
+  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
+
+description:
+  dwmmac based Qualcomm ethernet devices which support Gigabit
+  ethernet (version v2.3.0 and onwards) with clocks, interconnects, etc.
+  managed by firmware
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    const: qcom,sa8255p-ethqos
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: stmmaceth
+      - const: rgmii
+
+  interrupts:
+    items:
+      - description: Combined signal for various interrupt events
+      - description: The interrupt that occurs when HW safety error triggered
+
+  interrupt-names:
+    items:
+      - const: macirq
+      - const: sfty
+
+  power-domains:
+    minItems: 3
+
+  power-domain-names:
+    items:
+      - const: power_core
+      - const: power_mdio
+      - const: perf_serdes
+
+  iommus:
+    maxItems: 1
+
+  dma-coherent: true
+
+  phys: true
+
+  phy-names:
+    const: serdes
+
+required:
+  - compatible
+  - reg-names
+  - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    ethernet: ethernet@7a80000 {
+        compatible = "qcom,sa8255p-ethqos";
+        reg = <0x23040000 0x10000>,
+              <0x23056000 0x100>;
+        reg-names = "stmmaceth", "rgmii";
+
+        iommus = <&apps_smmu 0x120 0x7>;
+
+        interrupts = <GIC_SPI 946 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 782 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq", "sfty";
+
+        dma-coherent;
+
+        snps,tso;
+        snps,pbl = <32>;
+        rx-fifo-depth = <16384>;
+        tx-fifo-depth = <16384>;
+
+        phy-handle = <&ethernet_phy>;
+        phy-mode = "2500base-x";
+
+        snps,mtl-rx-config = <&mtl_rx_setup1>;
+        snps,mtl-tx-config = <&mtl_tx_setup1>;
+
+        power-domains = <&scmi8_pd 0>, <&scmi8_pd 1>, <&scmi8_dvfs 0>;
+        power-domain-names = "power_core", "power_mdio","perf_serdes";
+    };
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 658c004e6a5c836bcc1dca109a251e27af6e23ca..5ef5c28d0337050268e76cdd787b4cd6de7fb0e2 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -71,6 +71,7 @@ properties:
         - loongson,ls7a-dwmac
         - nxp,s32g2-dwmac
         - qcom,qcs404-ethqos
+        - qcom,sa8255p-ethqos
         - qcom,sa8775p-ethqos
         - qcom,sc8280xp-ethqos
         - qcom,sm8150-ethqos
@@ -176,7 +177,8 @@ properties:
           - const: ahb
 
   power-domains:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   mac-mode:
     $ref: ethernet-controller.yaml#/properties/phy-connection-type
@@ -639,6 +641,7 @@ allOf:
                 - ingenic,x1830-mac
                 - ingenic,x2000-mac
                 - qcom,qcs404-ethqos
+                - qcom,sa8255p-ethqos
                 - qcom,sa8775p-ethqos
                 - qcom,sc8280xp-ethqos
                 - qcom,sm8150-ethqos
diff --git a/MAINTAINERS b/MAINTAINERS
index 3773c74b31d6d9d4c2f9ba53c4b3ecf3e4e2dd79..cb097a1369d08e708152a3a41b610b35273cebea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21096,6 +21096,7 @@ M:	Vinod Koul <vkoul@kernel.org>
 L:	netdev@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/qcom,ethqos-scmi.yaml
 F:	Documentation/devicetree/bindings/net/qcom,ethqos.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
 

-- 
2.48.1


