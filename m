Return-Path: <linux-kernel+bounces-809679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07705B510BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA07E463557
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145ED31194C;
	Wed, 10 Sep 2025 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1agyELXW"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A962130F534
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491673; cv=none; b=S8DCOSTNyRxgoDWqKgvxrgHfmDDxDaIokpgIz+0HiO81B1+4/fJi7wSxBV0TgaimcAM/hFpsvV2NuYj1Kydn10ANHUcR1cplqbGAJj1zEYnadP54N/CJqYzRB/N39TfHM8hNr76MJFIsUXMWaW3eWBXbq0UbhH1xZuS4K5u40Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491673; c=relaxed/simple;
	bh=cCMCySr/VpbA7jK3NVpeLcWLGZWtRb22jM/wUssJ6zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sc0Y6PmpvNtkIUnuQKwZ3OBNf4LyXh+rl7Q2+I9hHDAxYXZ8YXlxg4TPjdsio9UTyTG+kDHy0L+vHVcrm8HeURfM/kg8OPZbf8Lv0pnchj1eo+fKqlzHtpcUU3Ozy8r33VdPnBWAbFYIJ/ctAWKmyeK+4BAV8Y479pTUVFyZ+SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1agyELXW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45ded619608so14445175e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757491669; x=1758096469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uY7tyXoLmxoMYiQ/WAWTMF4JkPWNBAVamog1AGlGOlk=;
        b=1agyELXWC/rpnRf6lizLT83wrK3i74HpO3tbqI+B9gpgyIzVRhHCeFNAm740hkQHZF
         hzQi+vTx2PzUsWh4VtY/K2/WfYNXzp6qqTVLB5Yyv6XqMoISLkgD4iLwHiN7X1oG9scj
         b7fkZavUGHkUe/WN8G95bgWj0GDMS/HLE1WWqkyy/yUVhfG9PRjuJBz+yAxwT6kVpgMV
         8wFllLl1/GWRtktGNYl4jqs+ug5vLr4LOFiJBdoMio40XZCvMVlEZtxDNCiG9jljqIzk
         qH10imkkKegSTUj/Z3+soQvHzs9Q+MJRAwd1iWzbJ6iPeCN/ZC1PD0IPl4Q5bUgz3zTT
         iWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757491669; x=1758096469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uY7tyXoLmxoMYiQ/WAWTMF4JkPWNBAVamog1AGlGOlk=;
        b=C0N0wIZFsYgsgRuG0ttqaczfhv1MlAuMPGaXTPInfmmxtwQ6N5hDVCf5yQ/+1W79ea
         Sxwc+NZhLW1RHkn0SfaDiF4PpDOJUaYA1QzUSwYJfGKgGo83hGOI1kKa2CrVL99llwEh
         0xux73wafNRZFtPltM5rad50HBhrfW/yQhqK91SjWieI6LLT+K8rZEa55KiZPJujgA5Z
         EGG05Wb4gTknUqsxuF/f6+qlqKloYxUNgcQSOwkdfklegy5W62IMJzANhb26yFPW5cey
         VAAWEsCHCOrolHyOl+5WbBGAz+44FtqEY/sPhNeQkrfp0k8GRtU8tDiHJYEGc2s8UabD
         Gdvw==
X-Forwarded-Encrypted: i=1; AJvYcCUb1e4dbeddMyMLXvXjKVNYAwCVIiTAPsO9ZQfPJ8I1Aa1YZ3YNq7GWQB1BD8VVJ1G0T9YVwa1uYOrCd5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwISremAzWRImH+bvBUz1MrY2Mc3Ald8vttL1cSDcDLeanahCVt
	WQ8oxP8k617+Zk5RlYrPV+EhXhRpBhjh+dBQhU3Rdg0Rn/YT2zoe0kryXbjDhkRm8X4=
X-Gm-Gg: ASbGncsOvZOE5Lkja3V4i03t/1+hW+vLK6Q1zLXUkiQyaXk3s/aAGrw/m46Bga3lV5k
	VpUAqttD2UdBp1dPghA66eJw1L+SEaLIaou5CQY+MP97ETq+NM5kNlDgER50KK4XjFApxHWiSEA
	SU+SaYiErgWd6zGfTlTHhwkdSSKvVq96ywwPmVMWWQwMJ2MZKBawaTcfiS2sg2GOGi7mXLtb+FS
	589XKp6Q7F9fJH7IlSbJso+wB/yZuqDRYJ7of0tKJoZdCmUj8Cvb2b2IynlIF6nCTbOmq8tSs0n
	GTyBDJgKCefWRv64/hZhkQJn2wj8NS5hWbHTY6LhT1aNV29Uw9RNeClzSg+ZDU42kFz49J+Cuj7
	lXN537Fl4MyaaPJc6hG5i5CzybiOvKz1kkySAfaw=
X-Google-Smtp-Source: AGHT+IFnNZEgNDzwo9ApEnobHwV8aAoxFw0Jkpaf4P9Rpvk6aHXizs1NLoPb9xG6C0xsESVPAcwBNQ==
X-Received: by 2002:a05:600c:3b23:b0:45d:d3f4:a640 with SMTP id 5b1f17b1804b1-45ddde82751mr137637395e9.15.1757491668832;
        Wed, 10 Sep 2025 01:07:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3936:709a:82c4:3e38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df8247cc6sm17813605e9.12.2025.09.10.01.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:07:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Sep 2025 10:07:39 +0200
Subject: [PATCH 2/9] dt-bindings: net: qcom: document the ethqos device for
 SCMI-based systems
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-qcom-sa8255p-emac-v1-2-32a79cf1e668@linaro.org>
References: <20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org>
In-Reply-To: <20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4931;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=YiaOUOOI0GWV9ljzY4gBLMGGn2gS4PsTZMpw74epeYo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBowTHM5rrhVBB6aGbLx1+QUka9GEHLBn1Bh6zAk
 6upsGPRnFWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaMExzAAKCRARpy6gFHHX
 clb7EACr8mgXcJhgQAtdioBd+rpPreLM1NgdsdbVw1eRYaLBKd8D6Gvowzq+W+SOWk6p5nt42LT
 yHphk380KW+A8RxjYCIPTDF0aIgEqXkvdtxViXF4WMU5rXPnG7YAgYGkZmV7XkaOBfXvkt8jr+f
 JIRuGuyNcLxrBDfdE+3aHT30Z5ImO3a8GAd+d1TlQT5QQr+IH+RWSddXjYXVRHbnZpNDw6A58xc
 1rKH5ZhUrllwrmvfZ2tL2ySQJ2tr7t9lCwdOxEMLp7x8ceU7gyDZSMEbYHCCqhKT1CUrbX3cEQ7
 seg3SC2afuBtDvkQh32Jf6v3Re9tHnMjpyzZJJGoWKnKTZlFkBWphcwA2GozI+ebZE8kGRRMM47
 u6/gFnm3+i2pePRz2BGlXiErGT4soU0D/Cxykz7AN1/zIyYJrJhKqUkty4KDQdmhD1a8dU0BQTA
 5Z1htu1KKk31ys72gNFQV+RrBNke/CJDTVmAqI1iuBusokeSjFbI9TLna6rROjPIGQiCIoc60VC
 mV701Kemnb8TglYfSTSZIc9hFX5TCfNFi4mRxn9lma7RRwmQqIo6eCuNx3kSRcTiGo5hnqnIFYQ
 CLS6xFvNuIDwVOKEau13A1WLlFvA6s5WHJuXCP42XtIpc6DPAghOU8OtItJIo+kk4eQtt0/u7DA
 QWzLqY6L+dkuFdw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Describe the firmware-managed variant of the QCom DesignWare MAC. As the
properties here differ a lot from the HLOS-managed variant, lets put it
in a separate file.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../devicetree/bindings/net/qcom,ethqos-scmi.yaml  | 101 +++++++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml        |   4 +-
 MAINTAINERS                                        |   1 +
 3 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos-scmi.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos-scmi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..d7d6c013311c2643d5ac0e2a75e0180911487d96
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
+  power-domains: true
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
+        phy-handle = <&sgmii_phy1>;
+        phy-mode = "2500base-x";
+
+        snps,mtl-rx-config = <&mtl_rx_setup1>;
+        snps,mtl-tx-config = <&mtl_tx_setup1>;
+        snps,ps-speed = <1000>;
+
+        power-domains = <&scmi8_pd 0>, <&scmi8_pd 1>, <&scmi8_dvfs 0>;
+        power-domain-names = "power_core", "power_mdio","perf_serdes";
+    };
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 4e3cbaa062290a6e8e5e60d0d01b0b39485c5478..07264c9c62778e9e8e2768999c5c377fce6811a1 100644
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
@@ -175,7 +176,7 @@ properties:
           - const: ahb
 
   power-domains:
-    maxItems: 1
+    maxItems: 3
 
   mac-mode:
     $ref: ethernet-controller.yaml#/properties/phy-connection-type
@@ -638,6 +639,7 @@ allOf:
                 - ingenic,x1830-mac
                 - ingenic,x2000-mac
                 - qcom,qcs404-ethqos
+                - qcom,sa8255p-ethqos
                 - qcom,sa8775p-ethqos
                 - qcom,sc8280xp-ethqos
                 - qcom,sm8150-ethqos
diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d321752ac44c91d2d7e74de28e08960..ab453e599a174e5414fc0c1baab5a64e0d88dd78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20745,6 +20745,7 @@ M:	Vinod Koul <vkoul@kernel.org>
 L:	netdev@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/qcom,ethqos-scmi.yaml
 F:	Documentation/devicetree/bindings/net/qcom,ethqos.yaml
 F:	drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
 

-- 
2.48.1


