Return-Path: <linux-kernel+bounces-750734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AF3B16070
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427B218C705F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C52E2989B3;
	Wed, 30 Jul 2025 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XNapruVw"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B053299943
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753878964; cv=none; b=Tp4QUPthCk8OsIfQNNv6RchjcvcEbxBFHlUeik+gwjpfLcXQnkyrmExgFjdLkUm9cLibG8JDIUwDl+0ri9E5KH8br+2dWn0/QhCQvZZjsHUCi6JQS7f9X5kQ0SPMcvD/5epHQnKcA/vneLw+kwwkx6O6GlbcDUSlzDi2vUUsahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753878964; c=relaxed/simple;
	bh=boCA9V7sdFxzCI0LILmKKujCbe1eahhsFvEftXk76ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gahfn2iSex9JjtTm5MVF27w1rGMS35A4acZXelMw+08wERGjckSVxth98vGc4cLBqftm+mvWjMrApl+/lRzLE/wQ9lwFVu8O/eVYm/+rDA3g39GQERK6olkrtbNZYGzHeLD0XIdc36IU+eUYjUqRW/lY3YQR1/o+fX9Cpxn96y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XNapruVw; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-707504f050cso5282196d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753878961; x=1754483761; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BK+Qe1LGAkGbTPbl50bCcrtO0BrMrgGPtaP514sRKAg=;
        b=XNapruVwAZ3nr6taQHElCBAURa6wbUV9Bv1/xT3Inz5rYKmAMxxnCNYRfvImJSEClr
         SnqQO5cwxhBs4BGZQqRbGZAR/9x1SauPrp3Yo+0Ve1eqQCwkZ02qBh14a9yqUysotF19
         /9DA5aTxuNqSj/c1paWClvaOCS2LctfNoDoEW4mE4Oi4szOYPob2wAZ+BBVtWAB5HJOJ
         eCwVIwnfU7nohhAvGpp7CAH4axGGZcrpDdJ4VURH5kmw9rr4CXP8NWep9n+TkB9ZkZsQ
         vTScUW1jJnp8tq162ZjDynnHBYNGcf5Puz5mXWB7I8ht7XK1sI7uk235Dsmch1U6uOiI
         +mAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753878961; x=1754483761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BK+Qe1LGAkGbTPbl50bCcrtO0BrMrgGPtaP514sRKAg=;
        b=xTbl3XHSqU0UAmZ+ppv2PzvO7sWE1Ua8/QRGTvi2gcssUSKkIMfo5tl+qBu5WOjg4o
         H1sjGp7+c2JR1GiopIrsztwjbmCYePcAC+JQiTF5B17HS4/7dGSHT5Qmu19TPK2P+4sx
         GrvxQ80u8t0EVIAfFharyb+PQdO501KvoZMj1vkjpPAPtMsvoTkLy/BfOrmYZTHBbhRn
         dahFzluWbjvffz0Rbky5Ib/kPuDErUdO02IcoyB4WbppSLH7le6r6mBe1AjLN2VhyF0W
         RRems5ybzMtayhoKMaphIeK4T9r/rWlEkFdUnVjWvTQjzsyg1vRytUtuJNjcX3nSKPXV
         e6Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWUVUdjtd5l0uAgvD//EwFGz/IpgwBjjjyhcQzeJnO8ecKdr61oQpxt1WXtPmSuerLZpdF7Y0xpj2Rz65M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF59SuRpcOyGlOyhJyNkHw1JFpmRR+lptXH5BbJGidU3Nspl82
	d0lQB+B/r+UGsO47X6aWVf6T0N1jGoseggeaWyRkDEMslEpNVARhWSetvG2hBRHbcQA=
X-Gm-Gg: ASbGncviHeh5gTXKKLvd1nkCCDQUbBEUAX/zM7ANRBRHV5gIiOEh7zj8Y5FX4sD8v+R
	2N5rJkJTkNAu7LxTadoiLra4v6En30GOv+yo1klwYBjfv1HC/VZptR863qKfRBa4cSnWoopn9Sm
	Xt+tpGpbB+ysCtqdgRBJAhzdK5AxuXkDbhR/OPja46NuoJcScNvM6sxscMHlR2emz4w4HDH9b57
	rXbdJWG9fYg8Sca8/WBaFKaSnq1y6Vb0D707oS9SYBgeNMHhoVmcj402FJUgwV0rrRcjqvn4dWs
	4OzgJhURVx9kbyDOW76mdv29hvppTY6SUWf1G8RIdAMGBhfqDivOBxz1XPreWhO207WcTAG0CBc
	xwqG+Y/SJ5+vSRi4R6z+08xHpaSOdmlkWf0E5lUs=
X-Google-Smtp-Source: AGHT+IEW0cadrg1ZN1RG03vDTq0f84xR/ulVr2IH6hMSVwOLg+CysA5FEmskNDvHn4664OUgc7jtLg==
X-Received: by 2002:a05:6214:1c0d:b0:705:b43:10fa with SMTP id 6a1803df08f44-70766d387f8mr19703356d6.1.1753878961384;
        Wed, 30 Jul 2025 05:36:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.218.223])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7076a647d47sm10105716d6.9.2025.07.30.05.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 05:36:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 30 Jul 2025 14:35:37 +0200
Subject: [PATCH 2/2] dt-bindings: ufs: qcom: Split SC7280 and similar
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-dt-bindings-ufs-qcom-v1-2-4cec9ff202dc@linaro.org>
References: <20250730-dt-bindings-ufs-qcom-v1-0-4cec9ff202dc@linaro.org>
In-Reply-To: <20250730-dt-bindings-ufs-qcom-v1-0-4cec9ff202dc@linaro.org>
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11790;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=boCA9V7sdFxzCI0LILmKKujCbe1eahhsFvEftXk76ec=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoihGmr6jo7Aor+3UbS6k3j6a1qWb3wcXpYEu+S
 T1fluxxheSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaIoRpgAKCRDBN2bmhouD
 17SAEACBDvyabLZV9xW21iI3QDfAHNg47RgcHyKNjkIuhv7ybSQQxw5B+DBbI4ZAxwJzZAUdshl
 7MPRQi2TIxISDnVlYJaihDuewG+yDg+oCzUDOf4Phb3vwAqr/IhNAZXOaHi3jKbrk9vzGiH25gi
 jIlzKZGPJaq4isRelT3qHTuED60497uQ/dEKqLeER2SUv+WuBmt0mUpsQoqUlcCzq7kzWj35uW2
 H7R8LaDnc/KgY4/RyuO2EIb9rxFaP/DnLK1UXXqOO+rvmDTwbXaax8yzDWLpFDDueAaYAvtpgIl
 Dhb4vSG9zG7LhP60gL7+QTjow+9dv5daju1pG4G6QvpItb+1lHjvmMk2qrwaTwaJsqvB3mer1zr
 XYkzTOVtPjQGUytlWbneoBCjgoBS1jWUgeeot9d/OiZdGevgs7ZkD5e2pCdZHRUYU15Wx65OWwL
 3uyZvMEsa6Ivxdl2dgNWjdVCe5+t1W8PFwcyDF1PpKSWNKlKtLDYMD0Z2nBwdGa3zWHT0w+5y81
 JbpMhsC/U8VGeqsGSBfOAe4YbFxLh5PCKHjKZK1Kh8UjZpT4mlus/R37CM2mjN/f6TB6ELrYs0T
 xcFFPGBet1lxlBXc2WqOh4GQUQRWzABPoGWgMMcSvUsO7eB70356rm06XECyZbWs+tmkT4tihP2
 Pxm5As5ZuT2v5Fg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The binding for Qualcomm SoC UFS controllers grew and it will grow
further.  Split SC7280 and several other devices which:
1. Do not reference ICE as IO address space, but as phandle,
2. Have same order of clocks.

The split allows easier review and further growth with MCQ IO address
space.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/ufs/qcom,sc7280-ufshc.yaml | 149 +++++++++++++++++++++
 .../devicetree/bindings/ufs/qcom,ufs.yaml          | 107 +++++----------
 2 files changed, 183 insertions(+), 73 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,sc7280-ufshc.yaml b/Documentation/devicetree/bindings/ufs/qcom,sc7280-ufshc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..0f2fe48860a7847819f325bb8170692a82af2ae3
--- /dev/null
+++ b/Documentation/devicetree/bindings/ufs/qcom,sc7280-ufshc.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ufs/qcom,sc7280-ufshc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SC7280 and Other SoCs UFS Controllers
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+# Select only our matches, not all jedec,ufs-2.0
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - qcom,msm8998-ufshc
+          - qcom,qcs8300-ufshc
+          - qcom,sa8775p-ufshc
+          - qcom,sc7280-ufshc
+          - qcom,sc8180x-ufshc
+          - qcom,sc8280xp-ufshc
+          - qcom,sm8250-ufshc
+          - qcom,sm8350-ufshc
+          - qcom,sm8450-ufshc
+          - qcom,sm8550-ufshc
+          - qcom,sm8650-ufshc
+          - qcom,sm8750-ufshc
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,msm8998-ufshc
+          - qcom,qcs8300-ufshc
+          - qcom,sa8775p-ufshc
+          - qcom,sc7280-ufshc
+          - qcom,sc8180x-ufshc
+          - qcom,sc8280xp-ufshc
+          - qcom,sm8250-ufshc
+          - qcom,sm8350-ufshc
+          - qcom,sm8450-ufshc
+          - qcom,sm8550-ufshc
+          - qcom,sm8650-ufshc
+          - qcom,sm8750-ufshc
+      - const: qcom,ufshc
+      - const: jedec,ufs-2.0
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    items:
+      - const: std
+
+  clocks:
+    minItems: 8
+    maxItems: 8
+
+  clock-names:
+    items:
+      - const: core_clk
+      - const: bus_aggr_clk
+      - const: iface_clk
+      - const: core_clk_unipro
+      - const: ref_clk
+      - const: tx_lane0_sync_clk
+      - const: rx_lane0_sync_clk
+      - const: rx_lane1_sync_clk
+
+  qcom,ice:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the Inline Crypto Engine node
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: qcom,ufs-common.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm8450.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,sm8450.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        ufs@1d84000 {
+            compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
+                         "jedec,ufs-2.0";
+            reg = <0x0 0x01d84000 0x0 0x3000>;
+            interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+            phys = <&ufs_mem_phy_lanes>;
+            phy-names = "ufsphy";
+            lanes-per-direction = <2>;
+            #reset-cells = <1>;
+            resets = <&gcc GCC_UFS_PHY_BCR>;
+            reset-names = "rst";
+            reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
+            vcc-supply = <&vreg_l7b_2p5>;
+            vcc-max-microamp = <1100000>;
+            vccq-supply = <&vreg_l9b_1p2>;
+            vccq-max-microamp = <1200000>;
+
+            power-domains = <&gcc UFS_PHY_GDSC>;
+            iommus = <&apps_smmu 0xe0 0x0>;
+            interconnects = <&aggre1_noc MASTER_UFS_MEM &mc_virt SLAVE_EBI1>,
+                            <&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_UFS_MEM_CFG>;
+            interconnect-names = "ufs-ddr", "cpu-ufs";
+
+            clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
+                     <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+                     <&gcc GCC_UFS_PHY_AHB_CLK>,
+                     <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
+                     <&rpmhcc RPMH_CXO_CLK>,
+                     <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
+                     <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+                     <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
+            clock-names = "core_clk",
+                          "bus_aggr_clk",
+                          "iface_clk",
+                          "core_clk_unipro",
+                          "ref_clk",
+                          "tx_lane0_sync_clk",
+                          "rx_lane0_sync_clk",
+                          "rx_lane1_sync_clk";
+            freq-table-hz = <75000000 300000000>,
+                            <0 0>,
+                            <0 0>,
+                            <75000000 300000000>,
+                            <75000000 300000000>,
+                            <0 0>,
+                            <0 0>,
+                            <0 0>;
+            qcom,ice = <&ice>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index fc0f7b8d1cd1c4a2168f29cffcc0c2ff660424df..b34da3df841a11eb50022fa7d091ebfbb33b1d17 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -15,7 +15,16 @@ select:
   properties:
     compatible:
       contains:
-        const: qcom,ufshc
+        enum:
+          - qcom,msm8994-ufshc
+          - qcom,msm8996-ufshc
+          - qcom,qcs615-ufshc
+          - qcom,sc7180-ufshc
+          - qcom,sdm845-ufshc
+          - qcom,sm6115-ufshc
+          - qcom,sm6125-ufshc
+          - qcom,sm6350-ufshc
+          - qcom,sm8150-ufshc
   required:
     - compatible
 
@@ -25,25 +34,13 @@ properties:
       - enum:
           - qcom,msm8994-ufshc
           - qcom,msm8996-ufshc
-          - qcom,msm8998-ufshc
           - qcom,qcs615-ufshc
-          - qcom,qcs8300-ufshc
-          - qcom,sa8775p-ufshc
           - qcom,sc7180-ufshc
-          - qcom,sc7280-ufshc
-          - qcom,sc8180x-ufshc
-          - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
           - qcom,sm6115-ufshc
           - qcom,sm6125-ufshc
           - qcom,sm6350-ufshc
           - qcom,sm8150-ufshc
-          - qcom,sm8250-ufshc
-          - qcom,sm8350-ufshc
-          - qcom,sm8450-ufshc
-          - qcom,sm8550-ufshc
-          - qcom,sm8650-ufshc
-          - qcom,sm8750-ufshc
       - const: qcom,ufshc
       - const: jedec,ufs-2.0
 
@@ -92,44 +89,6 @@ allOf:
         reg-names:
           maxItems: 1
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,msm8998-ufshc
-              - qcom,qcs8300-ufshc
-              - qcom,sa8775p-ufshc
-              - qcom,sc7280-ufshc
-              - qcom,sc8180x-ufshc
-              - qcom,sc8280xp-ufshc
-              - qcom,sm8250-ufshc
-              - qcom,sm8350-ufshc
-              - qcom,sm8450-ufshc
-              - qcom,sm8550-ufshc
-              - qcom,sm8650-ufshc
-              - qcom,sm8750-ufshc
-    then:
-      properties:
-        clocks:
-          minItems: 8
-          maxItems: 8
-        clock-names:
-          items:
-            - const: core_clk
-            - const: bus_aggr_clk
-            - const: iface_clk
-            - const: core_clk_unipro
-            - const: ref_clk
-            - const: tx_lane0_sync_clk
-            - const: rx_lane0_sync_clk
-            - const: rx_lane1_sync_clk
-        reg:
-          minItems: 1
-          maxItems: 1
-        reg-names:
-          maxItems: 1
-
   - if:
       properties:
         compatible:
@@ -246,10 +205,10 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/qcom,gcc-sm8450.h>
+    #include <dt-bindings/clock/qcom,gcc-sm8150.h>
     #include <dt-bindings/clock/qcom,rpmh.h>
     #include <dt-bindings/gpio/gpio.h>
-    #include <dt-bindings/interconnect/qcom,sm8450.h>
+    #include <dt-bindings/interconnect/qcom,sm8150.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     soc {
@@ -257,9 +216,12 @@ examples:
         #size-cells = <2>;
 
         ufs@1d84000 {
-            compatible = "qcom,sm8450-ufshc", "qcom,ufshc",
+            compatible = "qcom,sm8150-ufshc", "qcom,ufshc",
                          "jedec,ufs-2.0";
-            reg = <0 0x01d84000 0 0x3000>;
+            reg = <0x0 0x01d84000 0x0 0x2500>,
+                  <0x0 0x01d90000 0x0 0x8000>;
+            reg-names = "std", "ice";
+
             interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
             phys = <&ufs_mem_phy_lanes>;
             phy-names = "ufsphy";
@@ -275,19 +237,8 @@ examples:
             vccq-max-microamp = <1200000>;
 
             power-domains = <&gcc UFS_PHY_GDSC>;
-            iommus = <&apps_smmu 0xe0 0x0>;
-            interconnects = <&aggre1_noc MASTER_UFS_MEM &mc_virt SLAVE_EBI1>,
-                            <&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_UFS_MEM_CFG>;
-            interconnect-names = "ufs-ddr", "cpu-ufs";
+            iommus = <&apps_smmu 0x300 0>;
 
-            clock-names = "core_clk",
-                          "bus_aggr_clk",
-                          "iface_clk",
-                          "core_clk_unipro",
-                          "ref_clk",
-                          "tx_lane0_sync_clk",
-                          "rx_lane0_sync_clk",
-                          "rx_lane1_sync_clk";
             clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
                      <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
                      <&gcc GCC_UFS_PHY_AHB_CLK>,
@@ -295,15 +246,25 @@ examples:
                      <&rpmhcc RPMH_CXO_CLK>,
                      <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
                      <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
-                     <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
-            freq-table-hz = <75000000 300000000>,
+                     <&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
+                     <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+            clock-names = "core_clk",
+                          "bus_aggr_clk",
+                          "iface_clk",
+                          "core_clk_unipro",
+                          "ref_clk",
+                          "tx_lane0_sync_clk",
+                          "rx_lane0_sync_clk",
+                          "rx_lane1_sync_clk",
+                          "ice_core_clk";
+            freq-table-hz = <37500000 300000000>,
                             <0 0>,
                             <0 0>,
-                            <75000000 300000000>,
-                            <75000000 300000000>,
+                            <37500000 300000000>,
                             <0 0>,
                             <0 0>,
-                            <0 0>;
-            qcom,ice = <&ice>;
+                            <0 0>,
+                            <0 0>,
+                            <0 300000000>;
         };
     };

-- 
2.48.1


