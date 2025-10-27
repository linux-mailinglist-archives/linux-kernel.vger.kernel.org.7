Return-Path: <linux-kernel+bounces-871910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E41C0ECDA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DD8420DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7F63090C2;
	Mon, 27 Oct 2025 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVCfF3ll"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745222C236D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577181; cv=none; b=BeWT7JFsfn5hrLeS+OPi2/IiNrQKuzNRhOZ9X5reFZWCNpeE0SHc+GsSKhnKw404HKpSrZ9wKD2CLere0a6JB1xBpC4ecBayhvVL3zlYMgwestyUty3X26u8mZjpQVQpNKloKS15gbeBk1pyMLm83VQL93KrNHGelQ464PRcn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577181; c=relaxed/simple;
	bh=Six70z1/X+dxSTC5ydzInJn0GmeZ2UN+GtGlSXt3f5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWVwMANqnhB7TuwZz27m+ZXbjST+vdha1VxE87dD4UneELAzjs5xlwi8pV9Cz70148twwWYwPU1EepbvyZiRg5o4pv9q+FgdqHOHvXj+fp+AoLjJkZtTvefvGBxqinuRbq5/v9RLX9O5OwOnvhBC7hGqYZy2D2CUo5q07Pabb6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jVCfF3ll; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-475e01db75aso15282575e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761577178; x=1762181978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZ+Ywiph/7WahU1SOFkWTRgUz00UbT1lmnLBy9g4gbA=;
        b=jVCfF3ll6x2nNO9peSgLVqZ7hogL6sQhm8v0+KU3vEyYnE0kHY40RiPdOQymTKmV/q
         o1LC3Z1S6XnF51nhaZqZVR6X7l8YmbDdTXuXZnKK709Fq8Kf9upzSfk+Mivevz6cz1nR
         Jhfw1g3p8MYRYkkYq7W1PPRw0Y362IRttAv/4oUCDsRmc3AalS4rqbxh3BW3XHdMZiXX
         rrvBjvTslxdT6tbLuzF+rQEk3+zUoYpUVI5ThPL8qjK4L5B51j93cWW7RDuOXd1xSTP+
         wPzSBxQiFbR/3W2LauHrq+dIT/yL/CnDEkVleRj4GpTz1yBhNgzJEK/Ypyt+URCW0AAO
         MmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577178; x=1762181978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZ+Ywiph/7WahU1SOFkWTRgUz00UbT1lmnLBy9g4gbA=;
        b=X1vqfWxxU6AMjvKsoQzPVpv6H9WVK91n3COpFXFX6nGMKJPn9/ioojKz0qwSjlR4Uf
         yRW8Se3YhaFByCSCFUApVCSqOxYego0ENGfiRQTKnwug/7Lj+/kKJb8kcfxNsRwpUG5A
         5L9rsTebgTrtuXVtcfynyXtmP+Z9XwC1QLFB+/AAzmPbzeoWB5sUPgFoX7QAfmuy3TvN
         SzzzSuymM6SweRyOzwQMkUWYR0XqRVtDD6+B+bw+uzWGZqsDnUoOR530cpBGPFBVSt33
         l4I0n5VcIQXsz8URT1EpR1279RLarCjSVISSA6gRaHGLXOf5QjXhRqo/8apd/5ykBUzR
         YSEg==
X-Forwarded-Encrypted: i=1; AJvYcCVOXBekrEnKHv5W9RKH4IAt8SM/Rd5wd1rKSC73NjSw23a0gmDLc3XZVvxsw5CwK6dwpaBBEuw5E9+NRt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBIO2el2n/hSoGPdsBgeMYPyrvkGz4U9Oiv7PiucrpGbQVyxt8
	G4l3Lg37avrzD7vw2OzjCVo3WAyI5/ixLvoV5pvr7IXKEvxA91SfcFlyMeES2PBmBUc=
X-Gm-Gg: ASbGnctDsZ+Ys4xSnQqev62yiHtoS5y+ZI5krSSRSsHxDjMTAtZYnT4f7fVTjkE4njb
	IHvCz8bT0NgLVCfSdZ3tbhBWRmN0wMCcVGh5ACqKB2o8fWRDR7eHzJutNbVcoJPO5k150Jj0wOS
	XrYo6VQxdjtJJuSyuUFn+fNY2W1pU7AYLV3/8IkAROGEbT/KDgMV4anADcF+jlwH19vdm/ASMTP
	InF3kXJgh3SjoS2cX86WlMf+aPN/d6u11TCgYRMq7KCGCIMzkPjqLtfGRhaJ8S68HBgN8aP+Mn4
	EUoscjQ0zZ2fARqQGWtftnubQIN4hNLCxLWCmncuwdeGQotOBukJks08GPiY5/HlHFbwdl7dkik
	UqQCaHj43vJ6ypyQA9VKT8g9awTYTZWz2wBj/G1rGmd4oJz0bVFGcE65oyJdVMxrtxpQparcVlA
	==
X-Google-Smtp-Source: AGHT+IFFpEGha6SAhr77dustt6OPIPitY9NLPaaDTkQ/S0rygb9WS5dQwu5JIBs72ZfhYJ1f3jP1sg==
X-Received: by 2002:a05:600c:548d:b0:46e:436c:2191 with SMTP id 5b1f17b1804b1-47117903f96mr296592605e9.25.1761577177686;
        Mon, 27 Oct 2025 07:59:37 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df682sm14624801f8f.43.2025.10.27.07.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:59:36 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 27 Oct 2025 16:59:18 +0200
Subject: [PATCH v3 1/7] dt-bindings: display: msm: Document the Glymur
 Mobile Display SubSystem
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-glymur-display-v3-1-aa13055818ac@linaro.org>
References: <20251027-glymur-display-v3-0-aa13055818ac@linaro.org>
In-Reply-To: <20251027-glymur-display-v3-0-aa13055818ac@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9606; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Six70z1/X+dxSTC5ydzInJn0GmeZ2UN+GtGlSXt3f5k=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo/4jMIj09GsCJG8FJ4eBmdSKtQtCJtyAqs/nmf
 FB0sI7y8WmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaP+IzAAKCRAbX0TJAJUV
 VjZnD/oDthzgV6l4RoyONyfXJ/eiWkj4rViBoJRc07vjah5WvON2hzlgI39TjAD7nnh+XhhyK5d
 uqZm2rOw0D74Hyt6Mr+4ADYfkwZlwp53MrizG42xPsmJvfeDdLYbFw5zuIpXE9SfwoyCvMrvESs
 IGnARvvSWzhxBXHZu0gAn+GTjT3PVLOtt6hgr137RTD/xpGEHS8tRQntAweOClARINg1/sTCTi2
 WeIt7GTlT3M5YctCMaR32h54a6Ntd++S1l2m0ZIvceoqat+yowJimhAj32Pdin+atLmw8cX5EPQ
 SdiFWxxHEgCL56QW6U8+F8z2zY1eyQNAL1iIjBCE5RXrUCsXkrXmPk9Pui7clgQsDlZn0FBRaUn
 278yE493Ti9BFyLcywYljBbByLcfAA0P4Ppwkx9bNYvomkp0lxgRCtwy+LcZYHhvrFie4njePjL
 kOAHFxpzr/dmLRECo2CnkapPxi1w4SJZhO/h52k8bbfzZyRnQ9pbz5HJsCf6jRoQlsfWpSQDVoF
 CalkQmxJ/FhavWfkl5v8SMH592TcqNZqNS0k8XOCe/HSl43/AhN9qstvqXyL/PWLwqW4zo8IWas
 ujUKkx9pu008gaaWa8DnryDI8By2jqY78WT0dPQNBFAf9+gRmp5AEYSdc9KJF4YapZpbmyJ1Pv1
 civz/s1wZgJrGzQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The MDSS/MDP display subsystem found on Glymur platform is 2 minor version
increase compared to SM8750, which makes it incompatible with all previous
platforms. So document it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/display/msm/qcom,glymur-mdss.yaml     | 264 +++++++++++++++++++++
 1 file changed, 264 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..2329ed96e6cb37bf63a686e966aa81e690fc5dcd
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml
@@ -0,0 +1,264 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,glymur-mdss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Glymur Display MDSS
+
+maintainers:
+  - Abel Vesa <abel.vesa@linaro.org>
+
+description:
+  Glymur MSM Mobile Display Subsystem(MDSS), which encapsulates sub-blocks like
+  DPU display controller, DP interfaces, etc.
+
+$ref: /schemas/display/msm/mdss-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,glymur-mdss
+
+  clocks:
+    items:
+      - description: Display AHB
+      - description: Display hf AXI
+      - description: Display core
+
+  iommus:
+    maxItems: 1
+
+  interconnects:
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
+
+  interconnect-names:
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
+
+patternProperties:
+  "^display-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,glymur-dpu
+
+  "^displayport-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,glymur-dp
+
+  "^phy@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,glymur-dp-phy
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy-qcom-qmp.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    display-subsystem@ae00000 {
+            compatible = "qcom,glymur-mdss";
+            reg = <0x0ae00000 0x1000>;
+            reg-names = "mdss";
+
+            interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+
+            clocks = <&dispcc_ahb_clk>,
+                     <&gcc_disp_hf_axi_clk>,
+                     <&dispcc_mdp_clk>;
+            clock-names = "bus", "nrt_bus", "core";
+
+            interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_ALWAYS
+                             &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+                            <&hsc_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+                             &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+            interconnect-names = "mdp0-mem",
+                                 "cpu-cfg";
+
+            resets = <&disp_cc_mdss_core_bcr>;
+
+            power-domains = <&mdss_gdsc>;
+
+            iommus = <&apps_smmu 0x1c00 0x2>;
+
+            interrupt-controller;
+            #interrupt-cells = <1>;
+
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges;
+
+            display-controller@ae01000 {
+                compatible = "qcom,glymur-dpu";
+                reg = <0x0ae01000 0x8f000>,
+                      <0x0aeb0000 0x2008>;
+                reg-names = "mdp", "vbif";
+
+                clocks = <&gcc_axi_clk>,
+                         <&dispcc_ahb_clk>,
+                         <&dispcc_mdp_lut_clk>,
+                         <&dispcc_mdp_clk>,
+                         <&dispcc_mdp_vsync_clk>;
+                clock-names = "nrt_bus",
+                              "iface",
+                              "lut",
+                              "core",
+                              "vsync";
+
+                assigned-clocks = <&dispcc_mdp_vsync_clk>;
+                assigned-clock-rates = <19200000>;
+
+                operating-points-v2 = <&mdp_opp_table>;
+                power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+                interrupt-parent = <&mdss>;
+                interrupts = <0>;
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+                        dpu_intf1_out: endpoint {
+                            remote-endpoint = <&dsi0_in>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+                        dpu_intf2_out: endpoint {
+                            remote-endpoint = <&dsi1_in>;
+                        };
+                    };
+                };
+
+                mdp_opp_table: opp-table {
+                    compatible = "operating-points-v2";
+
+                    opp-200000000 {
+                        opp-hz = /bits/ 64 <200000000>;
+                        required-opps = <&rpmhpd_opp_low_svs>;
+                    };
+
+                    opp-325000000 {
+                        opp-hz = /bits/ 64 <325000000>;
+                        required-opps = <&rpmhpd_opp_svs>;
+                    };
+
+                    opp-375000000 {
+                        opp-hz = /bits/ 64 <375000000>;
+                        required-opps = <&rpmhpd_opp_svs_l1>;
+                    };
+
+                    opp-514000000 {
+                        opp-hz = /bits/ 64 <514000000>;
+                        required-opps = <&rpmhpd_opp_nom>;
+                    };
+                };
+            };
+
+            displayport-controller@ae90000 {
+                compatible = "qcom,glymur-dp";
+                reg = <0xae90000 0x200>,
+                      <0xae90200 0x200>,
+                      <0xae90400 0x600>,
+                      <0xae91000 0x400>,
+                      <0xae91400 0x400>;
+
+                interrupt-parent = <&mdss>;
+                interrupts = <12>;
+
+                clocks = <&dispcc_mdss_ahb_clk>,
+                         <&dispcc_dptx0_aux_clk>,
+                         <&dispcc_dptx0_link_clk>,
+                         <&dispcc_dptx0_link_intf_clk>,
+                         <&dispcc_dptx0_pixel0_clk>,
+                         <&dispcc_dptx0_pixel1_clk>;
+                clock-names = "core_iface",
+                              "core_aux",
+                              "ctrl_link",
+                              "ctrl_link_iface",
+                              "stream_pixel",
+                              "stream_1_pixel";
+
+                assigned-clocks = <&dispcc_mdss_dptx0_link_clk_src>,
+                                  <&dispcc_mdss_dptx0_pixel0_clk_src>,
+                                  <&dispcc_mdss_dptx0_pixel1_clk_src>;
+                assigned-clock-parents = <&usb_1_ss0_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+                                         <&usb_1_ss0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
+                                         <&usb_1_ss0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
+
+                operating-points-v2 = <&mdss_dp0_opp_table>;
+
+                power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+                phys = <&usb_1_ss0_qmpphy QMP_USB43DP_DP_PHY>;
+                phy-names = "dp";
+
+                #sound-dai-cells = <0>;
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+
+                        mdss_dp0_in: endpoint {
+                          remote-endpoint = <&mdss_intf0_out>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+
+                        mdss_dp0_out: endpoint {
+                        };
+                    };
+                };
+
+                mdss_dp0_opp_table: opp-table {
+                    compatible = "operating-points-v2";
+
+                    opp-160000000 {
+                        opp-hz = /bits/ 64 <160000000>;
+                        required-opps = <&rpmhpd_opp_low_svs>;
+                    };
+
+                    opp-270000000 {
+                        opp-hz = /bits/ 64 <270000000>;
+                        required-opps = <&rpmhpd_opp_svs>;
+                    };
+
+                    opp-540000000 {
+                        opp-hz = /bits/ 64 <540000000>;
+                        required-opps = <&rpmhpd_opp_svs_l1>;
+                    };
+
+                    opp-810000000 {
+                        opp-hz = /bits/ 64 <810000000>;
+                        required-opps = <&rpmhpd_opp_nom>;
+                    };
+                };
+            };
+        };
+...

-- 
2.48.1


