Return-Path: <linux-kernel+bounces-812042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8170B53229
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493B6A830F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4227C32253A;
	Thu, 11 Sep 2025 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I1AdRgQE"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6FF321457
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593760; cv=none; b=ZFiFlVneiRfGjBBVvPrmuo57UEPKDnBi52V3pjSTYooPhCJLo/T4JNQOO2FmEQghLoY9RqMb+UNWBVsFCbF5EGUZH+RG5tuIPG8qYgSHa9caNyghmiN6a3PEl2RlM41QZ7yVrfrjHe4sNflyyqMHpGUe3UjxYZMImlCm+T+AKvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593760; c=relaxed/simple;
	bh=wjeR4yq0rhKQpcfdhgi+hZ70VI9DiH//JiCjDiten+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DiVrDGExWaN2jT6jpz6Zj1SF13UErmKDaAYv8pBxVIfLlpwKn2q4QJqQAJSrZF/9JByiMbyBvB1Tu+YJAMBkECg/DgybCRau4F7FBIEKg5lL55nbQDsxxNT7bHoJ9nxRpJpQI7cNhe2VTLQbPXYlXMNOUULdukMyKaW3KP0JM8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I1AdRgQE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e7622483beso319397f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757593756; x=1758198556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qXNWsTn6pGiq8BJScd1/HARksGvcPmKxTdiNE9akK8=;
        b=I1AdRgQEzIgEq1tBqpzYHcI1JfZgsbB7FNZ32t7yfap7D0BXgdZKEg+sIw/6D2o/Ug
         936C34qiG2xddces5IT5YC/00cIaRexLvxLDsn4VERPvxXD9DRmWxTNStIw9OMyIRZga
         gKmj9Hdvg+W/OB04AVZiMfAMwIxZWTEltEj3DIj+rUPWeLrQp0hjMSuMbOBath1rBf21
         /O5VC3NPKU3TfWJsxJoCu8KNnePbyGuG5vGUWf59nZLbgdqYSH1YcfMIl2KXF+OjhUrJ
         kTTEscaZ1jlbqnejpPcwxBuPVDyuSXAN1offQ39KpiO4uVh0b9euKHPLJXWwMMIPtIgt
         IdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757593756; x=1758198556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qXNWsTn6pGiq8BJScd1/HARksGvcPmKxTdiNE9akK8=;
        b=GiXxD46D7XiUyZz3H4+/Bm0K43z0lZm/Y3jz6o7Hl8VGNO+R0YfLvbk6alKFM4/S3g
         sooezFSwy/kEwJd+xsr6OnDx2CF69PCZY4OLqvnc0B4jCBMyhG7V88yewkHQ3oRwWlD4
         2qsEIXvFoQjWRnFSZa522s42kkUQH+6GrasHpdv9SSco/VQsUZgbS+QBcUBzUUVFxvGz
         MkKy8MNNyUnt8Dq/MyXUpt8z/tbutfnd279hC0ZFdeTILTzv5IZeagPD2ckRt/lw70Zf
         TBwgOqzklhSYcjIcbtKPFHUBe3/XHbxU6a4qwFJ5XqPkEVSNauQsJyG93rkS1FF4MN/O
         J1EA==
X-Forwarded-Encrypted: i=1; AJvYcCUGEvcvKPw5GTMbUtqdr2kgpYzkiRYIGFKCv5MUjPA35HBXEQ2/HOMnLmJBf4g0mnEOkNEMSEJ2716YhKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyoSA8bDoDXL1etQa/qXppJCwGom6oJkKN5qtQQ6cXBhEBc+cn
	c/Q2YctB3m8+tIckCI2ha/TPu/l+oJHW8fVM0CC+9GJ2gPfXHNCof/ECimNKd8Xx5P4=
X-Gm-Gg: ASbGnctLG+vMDu7EgguLbw5uL3JTTqu1YUZ2k5JZZI8iak8RZklyOFgSaPucpliN/ex
	Koi1AFGgC1QGoIpxYcZQIfnR2L2HAdhQQSdlxKesCX2VSnnWi/Bcmd/XGLD514Z+lzIkVJrNHGi
	KtrQQFraZsLs929bEZuhjl/iwNO3X16oS68tViQI/xYJ5hgIX2BDoAj8iu1Ia2cDCFiVKjYTxkS
	AJ0royb/y0GOpiAZme5GrWSIG3TVSeWUNo7uC6H6s8nIIY0fuhQL6ecwn7tAMWYncF7lL2ZrgLi
	h4HN8lZSfDQVlr083mhH8520g8ELQpEUbWNbjo9v30ZB49Uq3cW1Qo1inHfDw5qAi2nSTDcVwxV
	xNbTJK8gxU2fHY4Tnxo3uTM5QW5FDnj5xSQ==
X-Google-Smtp-Source: AGHT+IFbRJdAPS/wgqpCqpc+UQ+Ip7/jcNqIuW6+lVnwTnZgnY+WGsy8+/r8FbKw7owELtSpZymyZA==
X-Received: by 2002:a05:6000:200c:b0:3e2:2dd3:f9d6 with SMTP id ffacd0b85a97d-3e64ca780d5mr15562177f8f.55.1757593756354;
        Thu, 11 Sep 2025 05:29:16 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd424sm2230444f8f.36.2025.09.11.05.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 05:29:15 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 11 Sep 2025 15:28:48 +0300
Subject: [PATCH 1/6] dt-bindings: display: msm: Document the Glymur Mobile
 Display SubSystem
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-glymur-display-v1-1-d391a343292e@linaro.org>
References: <20250911-glymur-display-v1-0-d391a343292e@linaro.org>
In-Reply-To: <20250911-glymur-display-v1-0-d391a343292e@linaro.org>
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
 Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8503; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=wjeR4yq0rhKQpcfdhgi+hZ70VI9DiH//JiCjDiten+A=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBowsCQHXQ724a0d4Btt1zmSgs72TkhcLSYRl7jk
 MpX2hXnn0eJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaMLAkAAKCRAbX0TJAJUV
 VkZZD/9J49iATZvVATcaKJ0QIU8bURQVym1+gPk8smJYOwclSdkbCIYl8Fed0GJifp5FUWo9Qsd
 N0MIqD5d3uBuCPmPYLeBg4rSj/zXrUxQi5M5NZInqC/DND8ce5LLNh5BGohCDNDgagK6cgA1iVQ
 +ihu+d+mQkGtn7qG+jumoUvfHVv1rjjWSQrthBltb2qzwEJ/0F/NIHkLt9DLmPMoV3G3Hpy7CcG
 HxLutqlTrGliR0hU17Sfuk7m0ojwRb1DNmRysnvMMZZGavDqaJdx1TvhkU3M32BvMJ20YtDcdbG
 WcDe/waLdkCVXBUyyJK7IDw56Bu5sb8yCjStfInQgHT2Al1Ji8F2vagLY0XWMFzkCCJDm7nbyOJ
 hPkrtLB0C1BoUzsA3DTTIvm+atv7j1sEehpgdEDrbhLDP+/azBGRUT573wXGuyJjMTk55n9AY11
 vxqaK+MiOzoznZ9si5ymhD1aiozpgPY3tVR0U65oi94OSGfIK9jVIsgoshl15ddFXLXhOUaH0aQ
 o0rTKNp71N12lyEbFMp1uCr5b/Gil+sCp+BfwUjFc7OwKzSP7Qz/aanJ4035g8aqf35nqd8Q8YD
 GpA+QD3dalvEOxJcH8E7SfIeXyUAlObVLtphWjPgEOFaL0TzY5UafkAsVGwRI0EI/Y+WkHzDd0m
 m0/srMNT2NZ20Wg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add MDSS/MDP display subsystem for Qualcomm Glymur SoC, which is
is 2 minor version increase compared to SM8750.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/display/msm/qcom,glymur-mdss.yaml     | 260 +++++++++++++++++++++
 1 file changed, 260 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..00b8f6a75b0259ddc407ba8c11777d1a9cf45029
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml
@@ -0,0 +1,260 @@
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
+        contains:
+          const: qcom,glymur-dp
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
+        compatible = "qcom,glymur-mdss";
+        reg = <0x0ae00000 0x1000>;
+        reg-names = "mdss";
+
+        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+
+        clocks = <&dispcc_ahb_clk>,
+                 <&gcc_disp_hf_axi_clk>,
+                 <&dispcc_mdp_clk>;
+        clock-names = "bus", "nrt_bus", "core";
+
+
+        interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_ALWAYS
+                         &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+                        <&hsc_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+                         &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+        interconnect-names = "mdp0-mem",
+                             "cpu-cfg";
+
+        resets = <&disp_cc_mdss_core_bcr>;
+
+        power-domains = <&mdss_gdsc>;
+
+        iommus = <&apps_smmu 0x1c00 0x2>;
+
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        display-controller@ae01000 {
+            compatible = "qcom,glymur-dpu";
+            reg = <0x0ae01000 0x8f000>,
+                  <0x0aeb0000 0x2008>;
+            reg-names = "mdp", "vbif";
+
+            clocks = <&gcc_axi_clk>,
+                     <&dispcc_ahb_clk>,
+                     <&dispcc_mdp_lut_clk>,
+                     <&dispcc_mdp_clk>,
+                     <&dispcc_mdp_vsync_clk>;
+            clock-names = "nrt_bus",
+                          "iface",
+                          "lut",
+                          "core",
+                          "vsync";
+
+            assigned-clocks = <&dispcc_mdp_vsync_clk>;
+            assigned-clock-rates = <19200000>;
+
+            operating-points-v2 = <&mdp_opp_table>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            interrupt-parent = <&mdss>;
+            interrupts = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    dpu_intf1_out: endpoint {
+                        remote-endpoint = <&dsi0_in>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    dpu_intf2_out: endpoint {
+                        remote-endpoint = <&dsi1_in>;
+                    };
+                };
+            };
+
+            mdp_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-200000000 {
+                    opp-hz = /bits/ 64 <200000000>;
+                    required-opps = <&rpmhpd_opp_low_svs>;
+                };
+
+                opp-325000000 {
+                    opp-hz = /bits/ 64 <325000000>;
+                    required-opps = <&rpmhpd_opp_svs>;
+                };
+
+                opp-375000000 {
+                    opp-hz = /bits/ 64 <375000000>;
+                    required-opps = <&rpmhpd_opp_svs_l1>;
+                };
+
+                opp-514000000 {
+                    opp-hz = /bits/ 64 <514000000>;
+                    required-opps = <&rpmhpd_opp_nom>;
+                };
+            };
+        };
+
+        displayport-controller@ae90000 {
+            compatible = "qcom,glymur-dp";
+            reg = <0 0xae90000 0 0x200>,
+                  <0 0xae90200 0 0x200>,
+                  <0 0xae90400 0 0x600>,
+                  <0 0xae91000 0 0x400>,
+                  <0 0xae91400 0 0x400>;
+
+            interrupt-parent = <&mdss>;
+            interrupts = <12>;
+
+            clocks = <&dispcc_mdss_ahb_clk>,
+               <&dispcc_dptx0_aux_clk>,
+               <&dispcc_dptx0_link_clk>,
+               <&dispcc_dptx0_link_intf_clk>,
+               <&dispcc_dptx0_pixel0_clk>;
+            clock-names = "core_iface", "core_aux",
+                    "ctrl_link",
+                    "ctrl_link_iface",
+                    "stream_pixel";
+
+            assigned-clocks = <&dispcc_mdss_dptx0_link_clk_src>,
+                  <&dispcc_mdss_dptx0_pixel0_clk_src>;
+            assigned-clock-parents = <&usb_1_ss0_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+                  <&usb_1_ss0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
+
+            operating-points-v2 = <&mdss_dp0_opp_table>;
+
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            phys = <&usb_1_ss0_qmpphy QMP_USB43DP_DP_PHY>;
+            phy-names = "dp";
+
+            #sound-dai-cells = <0>;
+
+            ports {
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              port@0 {
+                  reg = <0>;
+
+                  mdss_dp0_in: endpoint {
+                    remote-endpoint = <&mdss_intf0_out>;
+                  };
+              };
+
+              port@1 {
+                  reg = <1>;
+
+                  mdss_dp0_out: endpoint {
+                  };
+              };
+            };
+
+            mdss_dp0_opp_table: opp-table {
+              compatible = "operating-points-v2";
+
+              opp-160000000 {
+                 opp-hz = /bits/ 64 <160000000>;
+                 required-opps = <&rpmhpd_opp_low_svs>;
+              };
+
+              opp-270000000 {
+                 opp-hz = /bits/ 64 <270000000>;
+                 required-opps = <&rpmhpd_opp_svs>;
+              };
+
+              opp-540000000 {
+                 opp-hz = /bits/ 64 <540000000>;
+                 required-opps = <&rpmhpd_opp_svs_l1>;
+              };
+
+              opp-810000000 {
+                 opp-hz = /bits/ 64 <810000000>;
+                 required-opps = <&rpmhpd_opp_nom>;
+              };
+            };
+        };
+    };

-- 
2.45.2


