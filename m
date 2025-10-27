Return-Path: <linux-kernel+bounces-872006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD81C0F0AB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEAE19C45BD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AABD313540;
	Mon, 27 Oct 2025 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gRxg1sLf"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C4030E84F
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579908; cv=none; b=KDlBgpKLAzWlr436NW1qS0LEXholbZ/mfNmoOQRURVocXN1vJKPyTwB4KA67jnw3XM6n0yN8LYHayJ0dMMpAt3BWWjWusP5SIyY3GB5+VwZ/8fFa8fw9ZqlskHtkXLFyAygfIV9KFRxFtpTpplpSPmKs+v5rIkIXv8ik/ZbQ7po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579908; c=relaxed/simple;
	bh=7o+nqASHx7UH7QHI/rACvEF8YONzSPI+tDQ5Q819Mjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NAZXM7t6bpQjadAOxvOQ/xnSw+rj/bXuk7orVtIyaq6782lQTn4Qg3bLx/Bguja25tRNBwoIhV9yJGcE41+4VQA6BSvNFlUFgbCmoCkVAAfD/pB4QVwIutQ8FfD+j4703zp3IdlQoYro6u/XMDvp8Yj585Qcaq0WDfUTb84eBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gRxg1sLf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4711810948aso35214485e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761579904; x=1762184704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OlAwR0Ez2lmPLsYc3tLDTQTUPw8dFRTu8oJtM9uyYA=;
        b=gRxg1sLfl/oNehVvqBWREMyuSzblcB8cWusv0Rv41CZPh5rigCp2Yji9sKEJ2FDcx1
         55OH+GAbdGH7pjQDtBBTkCiGaiFnhNdWt7H8mT6BcpCttcwz4vB0qcI3WKxOvizNjtzo
         t7Xo/Z5GfeE6iGEKyDe7B0gqtQGIz3pIcOod+DRGXt1FiHrKcRO6Do8eJCsB5tbcqgLy
         IwyjXQjrpyc8+zI15ZiyVUSF7i2cySFic5+BVRgiHc0QeQUXwqDwmUlxtP3s7dcJAD+/
         5IxbT849DQud7vfgnw8JadpQ3FeSe1fA4s69iXuSwm4jhIEmoqXfLPyUIlzX47p+pxm5
         1L1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761579904; x=1762184704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OlAwR0Ez2lmPLsYc3tLDTQTUPw8dFRTu8oJtM9uyYA=;
        b=mfGwuRMIbHEeQy6gJjsiuZY5e3XAvbm8zq7OuSmdNZCU9QNSyEE4WLqGYS9wx9cO2g
         KJgB1BX/k0ZAlubtdwp++oZAw2TFRRqMJmaQ+9RvRHgOfH7hcS+c4JxKwoYEYeaFRHTh
         1yjvFzl1goDY6QpnbLTrSphWFYlSsSdRftBcaEa2UeG9X2XUFqyZj7EKSUucfHOeohzk
         rMJHjPxImCWXKQDtWOXzSCiSrNyOA8FoIs/QSIR5L1MCkhzhZEoztUaMjhHS3IlMcw7h
         YjFmrL1WhQOOl9SMmkkTvF220H5BhCU1yK4LoKEwEghlEuP2Abd340d33ok2OTdN64pT
         +J3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRoPsVhWFNFM30fKcAQ4GwrNkbv2uUwNKZGmx6txrQNnYOIUCgL5Pu4y7Myd5ZZoSsrVYRwtbgFFD/rIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhADQn8yLYfTN3mgCMYkVdSsBKcCTdmtg83l/5rKIH+Oz3JMrF
	vE7cwWGlTS303NtzMloearuq8PnGPsIiPQfA37w8y11IeW6t7/RrnkhbJh8xMGjYo1E=
X-Gm-Gg: ASbGnctnUu63Xs2QY2bm7ISTXDXv36+2/ubJERn202YO1wrKQhxAntXSpV12jveGQ3C
	3p1PUFlCGBkRGlm13Be8zL1dPCpSAjdx7epIh1MGxPA0snjyZN/QOaiWq+zop6rvAusfm3QnGFQ
	G4VfnF9gWmPWXyF/rRpmayl6aCdVPVYL6DVi30H2t0q3k3dWR4QAYnxq+mYjSUw6znqrci40qXi
	YJHyQNSBU7LR+RY/JckVlXPO55+U0ifIFnEThVEjU8+5Qv80y6p8nFcDB3YQWN3n7drA+j2JSjV
	kL3737rzBtXHm8MqqKhQxYrDBZdDwX94DliChmiWLmuwY9IaCJ1cQ7LMGN1AVCGubl+KEHuM8p0
	vUBpUONUgHn+8lDu1P4RFP17xyRihvyMiCE4jX6d2fqmHlYAAelgIez3LR8bSdqv+YCY/xZT0VU
	wSrwIRC15LHxzvRPk8
X-Google-Smtp-Source: AGHT+IF3LUL3bfxhtdpuEv0pHPdlEkBGo06ytgVfCVUCGuaC1FOwUetTffXhS0o9uNVApIit+32qLA==
X-Received: by 2002:a05:600d:416d:b0:475:dcbb:76b0 with SMTP id 5b1f17b1804b1-47717dfaa40mr966635e9.12.1761579903932;
        Mon, 27 Oct 2025 08:45:03 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c1c6:7dde:fe94:6881])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd477d0esm138708045e9.0.2025.10.27.08.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:45:03 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 27 Oct 2025 16:44:49 +0100
Subject: [PATCH v3 1/8] dt-bindings: net: qcom: document the ethqos device
 for SCMI-based systems
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-qcom-sa8255p-emac-v3-1-75767b9230ab@linaro.org>
References: <20251027-qcom-sa8255p-emac-v3-0-75767b9230ab@linaro.org>
In-Reply-To: <20251027-qcom-sa8255p-emac-v3-0-75767b9230ab@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4896;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=OSzCwUgDD3l4L0pYJMm0DD9DnJ/KFBo24c29rgi8yQk=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo/5N6lhNlND4rsq376wqaZULe50mt5NDwwtTRC
 AFI8PIWioaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaP+TegAKCRARpy6gFHHX
 cruND/9HOgu2X1rNis9f+h3vpeLQ56ytu76P+bQW61H4CEezr3VWwQLx8BRjR1WXEoMT+5TlQRs
 ipD2fBeg8mJEbLux1Ltn6ag6107Soa/wvshuCQLxGVql/6xlYoDxSEEptIPhKa87T5+cb9tkCFJ
 xnw7Y4Wmsi9CKCy0YmRXURj0Gp+5llGqF6v0GYFf47t0PMRU6EQaxv5WFe7nw1V2ZA3ObckRqO2
 /e6dA0pR8x+mdWoIX9kdjlHcXEtlIseWvd+t3xM1UhGQM6atPn6tzQTh3JYd0uYChSqoqqxEO7x
 HjKBGc8YG1yjalOGpowa/eVeCjdVXw5KoUwZIREYEGEEnj5n4UssoDUABQC/LnKNGkoFRnF+0Bm
 Gg+7o9dasJAxuLr1Me2URwCXqUmxY6MQaN7/FqJm32LzdDs4z25W8siYaIc6hgl+/He8Nc1NAqP
 54GzTigkE5CjoL26SEhe+fRWClFSMDXUQQaFEfPDzvo5ZqPXkxZ/i4Jzac7IElpTQ6ItiKflDXL
 uqL6938plMXE7AQDbQ6IiZG20RV8dFgp6lHN3fN6Ktz4SLWi1jNkPMeFP9MzpATft99M2HDcAII
 NJVxIgZOSCbNz6zOqA9UlgkJ1Xo4f018d/ZhkyJ2hY4Sd1Sdc+Vt13hMV3uJCsJCuSJOd8luOwo
 i45uTVSxobapSnQ==
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
index 0000000000000000000000000000000000000000..b821299d7b30cdb802d9ee5d9fa17542b8334bd2
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
+      - const: core
+      - const: mdio
+      - const: serdes
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
+        power-domain-names = "core", "mdio","serdes";
+    };
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index dd3c72e8363e70d101ed2702e2ea3235ee38e2a0..312d1bbc2ad1051520355039f5587381cbd1e01c 100644
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
@@ -180,7 +181,8 @@ properties:
           - const: ahb
 
   power-domains:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   mac-mode:
     $ref: ethernet-controller.yaml#/properties/phy-connection-type
@@ -643,6 +645,7 @@ allOf:
                 - ingenic,x1830-mac
                 - ingenic,x2000-mac
                 - qcom,qcs404-ethqos
+                - qcom,sa8255p-ethqos
                 - qcom,sa8775p-ethqos
                 - qcom,sc8280xp-ethqos
                 - qcom,sm8150-ethqos
diff --git a/MAINTAINERS b/MAINTAINERS
index 252b06d4240cc2b67405b8a967055bd53dec7c8e..14c80fbad8b97cc5562555d2422c81724d42111d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21218,6 +21218,7 @@ M:	Vinod Koul <vkoul@kernel.org>
 L:	netdev@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/qcom,ethqos-scmi.yaml
 F:	Documentation/devicetree/bindings/net/qcom,ethqos.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
 

-- 
2.48.1


