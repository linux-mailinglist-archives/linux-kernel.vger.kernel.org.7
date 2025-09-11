Return-Path: <linux-kernel+bounces-811931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C94CEB53042
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E593B6B26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0AC31D384;
	Thu, 11 Sep 2025 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iXeJhjMM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB1931A046
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589877; cv=none; b=Tb8XVpvGxOiKCNRKRsuM0QOfBIOYYtkk0Qwd0vPgvpN3ipT/4Cp98R0w/6/9K1erMMzENxQGDTPES6/rZxoWLGabj3yYCX7PoU/k/QC8yNUSF6ETS9ELMLJqP6Ugo4Q4LvnkiwJeZjYC6CzPTUTc+QOD7l7kzgaYrkJj+WBdzXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589877; c=relaxed/simple;
	bh=lFN1sMwdttJ5r2Kv533T9IKN7mmKBYK/3QoUk3LJ7G0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nZ1kDLqRps0b6I6zJwijXbUSzZiTgz0Oi6G+D9xACJE1CCcCRCy0tuBmTfNjfzIntRzsrGS427YSkZftBBfQVJ4a3sqS/G+ncXxa2uDgOQZR4VpVt6n7+R+KrNDVRrdI+pYE72MNfe/++o1c/R4JcGIX+X9DtotS9KPWAF84RmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iXeJhjMM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BBFsDT015134
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X1cCbIxUR+VsDx4Y/Jzp7M8AWWpOI4wkGua8Lku+mII=; b=iXeJhjMMtRMtR/Lc
	cnEXprI00lHlVwE8adnqybQ57T/WSD+Pe4fIp5Z8qLPrQPdyobrnaYC46z+J2iue
	fcN4QbbiHXp914wnhJX9vBfwdUxh23cA1nkf8eSJ9m8hNxd4WQbeU/d/qavQycaM
	dEnC4Y/MKi87pdZqNypneCVCT32R5HFxYkwQNuxC8dSrLkqda35QKsrFxg3GnGMO
	sfpCJ9kulRgWF2DQ8nwPwO0d9PFZ50hsXGOTRhRDwpSJUcnsW87cpU52aOQMxxJu
	voRFEYDF4t5J4eiRXBXSWhYziqVO82UXczHWFKNNnYDs/zVhqvIf2ttY2AITzLiu
	HqERCw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4m78w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25bdf8126ceso12425925ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589874; x=1758194674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1cCbIxUR+VsDx4Y/Jzp7M8AWWpOI4wkGua8Lku+mII=;
        b=hQ5LM5NKBkdP5pTm1+7Hw3o5JZxQBHsfAd14txeCYvAbXabB8dnzwY8APSlrm2vOB3
         bZRBflVQjnJkcWarSh0LBUTpkyV1VT+2JKfMdH0GFM8KANJlj/obEf8E6Xt2ycLOW3D1
         JVq46SVEt29qqs1HPACevBt7szC9Ml3neOURKLOBjkbzIlzkeiM0jr/eMaE9UHpkcyn4
         dQjE+OGy0MbmVy4W+TYxAaJiD2TFSTtqz6LwgjlAnGuYxW8oZZJMksNuYAeWAhbsnpf1
         uTtz72gIIWrQ16gK+JqS03FAUMFynpRphs+MwXSLhlAnGX08fTCcJ4A1dxm5fXhc2ZYO
         1kgA==
X-Forwarded-Encrypted: i=1; AJvYcCVS3SeZHdJPhLAGBytGKzi66Mb5/eDnXV7r1SXwP2lmkU9ISK6G64a/RSkA58Yfz5+fK0rqudMcDvv7+1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzJnfTqqBXfu9/I3fw08N24B7ig5LvXyKPT48EDzM+Su8Byhm
	x4AgUncc3Soj2kyUXDOhSqF9Z8yQGP2q6C14jw0LjpMToOsEz5QSmpC9Z0eaGm7Ccuh2vFNeqrp
	koQI8g/g7NBBUKJTc3yJbzs64hE73dkMlwooTkeYpY/QmIqJ1jCgifPxPIjR+pburciUoaBqHe0
	c=
X-Gm-Gg: ASbGncuTNdyE9iNHTyeHE1mn5SNLLc5ApcBTL1vSjqXRjSccXhw39qD25VNL+s3GPnI
	R2Yw59E2FOPzlgeM6GgpCuH87/yBZ4TU9esN9qwCfPwV9qKSM0X7soQIfINS/Wt2tEWrPRAaOm+
	WFSWvUODJ1BHEpP4KPed+hKwWq9cK8NYMJEA/gMBipFAne17BPRhKSIBMFJ/7Fi536oEb9poTkQ
	NOmCIheB4GJlYrjNHYQveBTZvtrmZQRePzLChkD2bO9/EMkblFSHJ67n2X1R4h0WG50Oz10TeJN
	ea1fsKHL8MuXZOemdUtxzUYCCwzqbertH4O2152WVJ1RTLrgoVXBM+vwzBZ8rtw8MTgIG9xW4gl
	xqtha/Vs//Wdzoegb1TOrKAAk8IN5p2zX
X-Received: by 2002:a17:903:384c:b0:25c:9084:41a0 with SMTP id d9443c01a7336-25c908466a1mr8498915ad.35.1757589873716;
        Thu, 11 Sep 2025 04:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFokFS5q54/Cvo8S9tqB5c+XA+bpjsB4hNl9atz6818deoyyeu4EuWcHFGxSGCykHD4RjjcWQ==
X-Received: by 2002:a17:903:384c:b0:25c:9084:41a0 with SMTP id d9443c01a7336-25c908466a1mr8498425ad.35.1757589873171;
        Thu, 11 Sep 2025 04:24:33 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37294b17sm17005365ad.40.2025.09.11.04.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 04:24:32 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 19:24:03 +0800
Subject: [PATCH v12 3/5] dt-bindings: display/msm: Document MDSS on QCS8300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcs8300_mdss-v12-3-5f7d076e2b81@oss.qualcomm.com>
References: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
In-Reply-To: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757589847; l=10240;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=lFN1sMwdttJ5r2Kv533T9IKN7mmKBYK/3QoUk3LJ7G0=;
 b=XEZ8VM04siZFkKcaxUexJOU3ppt0yAUzRqYoqw0PSXz3Hrfa+YS4hs7PDmhNrxL666wrrMwEd
 w392QIKrZYrCmFiv1YZ4bDEtKouSH/nrpUootqstvrdqrevE+OyRz6d
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX96S8NnoY2UYt
 Ae0yE3NrTq8W725+Oy9X/bVZk25r5VuR+L78co35gh4u8bp4pPoiBhI/yPOPTZk71/94AoLKS1d
 RwQPs5Orx8sGN07UVvDkwXvJlEh4Xo50GdXI5hJb0w1zc6vdviL2b5aRF2GDOIu3VgkrFOY0j/9
 NBX1xIWFFEZlAge9PsMOZuK5S5K7m6zL0rnmhJsC/R4V3rz8rSl/mEC0qOxsQCn/aBcRtm2L9Dz
 xEMr4EBBgo8iWJzWDEyElR6CLrnWwKM/Icw1PBpYGIH1ss2YXdu2WJGkHEDur85b0wQIGpW2zaj
 HBvOaMrW/gDUpKkQaEG/tOb0ddIbRdkYrQ9E4EYWJKlZfsAdu7IUzvkb2mEjGYnhKhtfOoObQvg
 A1Z0gxQ4
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c2b172 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=mw5JQ2FHeNGQCEwkIB4A:9 a=x9G3774qgbUdaUce:21 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: 7kZ-v2O1DB418lPhLC8KL_SWRw2VqW6D
X-Proofpoint-ORIG-GUID: 7kZ-v2O1DB418lPhLC8KL_SWRw2VqW6D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

Document the MDSS hardware found on the Qualcomm QCS8300 platform.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 .../bindings/display/msm/qcom,qcs8300-mdss.yaml    | 286 +++++++++++++++++++++
 1 file changed, 286 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcs8300-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcs8300-mdss.yaml
new file mode 100644
index 000000000000..e96baaae9ba9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcs8300-mdss.yaml
@@ -0,0 +1,286 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,qcs8300-mdss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. QCS8300 Display MDSS
+
+maintainers:
+  - Yongxing Mou <yongxing.mou@oss.qualcomm.com>
+
+description:
+  QCS8300 MSM Mobile Display Subsystem(MDSS), which encapsulates sub-blocks like
+  DPU display controller, DP interfaces and EDP etc.
+
+$ref: /schemas/display/msm/mdss-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,qcs8300-mdss
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
+    maxItems: 3
+
+  interconnect-names:
+    maxItems: 3
+
+patternProperties:
+  "^display-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        contains:
+          const: qcom,qcs8300-dpu
+
+  "^displayport-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        contains:
+          const: qcom,qcs8300-dp
+
+  "^phy@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        contains:
+          const: qcom,qcs8300-edp-phy
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,qcs8300-gcc.h>
+    #include <dt-bindings/clock/qcom,sa8775p-dispcc.h>
+    #include <dt-bindings/interconnect/qcom,qcs8300-rpmh.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    mdss: display-subsystem@ae00000 {
+        compatible = "qcom,qcs8300-mdss";
+        reg = <0x0ae00000 0x1000>;
+        reg-names = "mdss";
+
+        interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ACTIVE_ONLY
+                         &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+                        <&mmss_noc MASTER_MDP1 QCOM_ICC_TAG_ACTIVE_ONLY
+                         &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+                        <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+                         &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+        interconnect-names = "mdp0-mem",
+                             "mdp1-mem",
+                             "cpu-cfg";
+
+        resets = <&dispcc_core_bcr>;
+        power-domains = <&dispcc_gdsc>;
+
+        clocks = <&dispcc_ahb_clk>,
+                 <&gcc GCC_DISP_HF_AXI_CLK>,
+                 <&dispcc_mdp_clk>;
+
+        interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        iommus = <&apps_smmu 0x1000 0x402>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        display-controller@ae01000 {
+            compatible = "qcom,qcs8300-dpu", "qcom,sa8775p-dpu";
+            reg = <0x0ae01000 0x8f000>,
+                  <0x0aeb0000 0x2008>;
+            reg-names = "mdp", "vbif";
+
+            clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_MDP_LUT_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_MDP_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_VSYNC_CLK>;
+            clock-names = "nrt_bus",
+                          "iface",
+                          "lut",
+                          "core",
+                          "vsync";
+
+            assigned-clocks = <&dispcc0 MDSS_DISP_CC_MDSS_VSYNC_CLK>;
+            assigned-clock-rates = <19200000>;
+            operating-points-v2 = <&mdp_opp_table>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            interrupt-parent = <&mdss>;
+            interrupts = <0>;
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                port@0 {
+                    reg = <0>;
+
+                    dpu_intf0_out: endpoint {
+                         remote-endpoint = <&mdss_dp0_in>;
+                    };
+                };
+            };
+
+            mdp_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-375000000 {
+                    opp-hz = /bits/ 64 <375000000>;
+                    required-opps = <&rpmhpd_opp_svs_l1>;
+                };
+
+                opp-500000000 {
+                    opp-hz = /bits/ 64 <500000000>;
+                    required-opps = <&rpmhpd_opp_nom>;
+                };
+
+                opp-575000000 {
+                    opp-hz = /bits/ 64 <575000000>;
+                    required-opps = <&rpmhpd_opp_turbo>;
+                };
+
+                opp-650000000 {
+                    opp-hz = /bits/ 64 <650000000>;
+                    required-opps = <&rpmhpd_opp_turbo_l1>;
+                };
+            };
+        };
+
+        mdss_dp0_phy: phy@aec2a00 {
+            compatible = "qcom,qcs8300-edp-phy", "qcom,sa8775p-edp-phy";
+
+            reg = <0x0aec2a00 0x200>,
+                  <0x0aec2200 0xd0>,
+                  <0x0aec2600 0xd0>,
+                  <0x0aec2000 0x1c8>;
+
+            clocks = <&dispcc MDSS_DISP_CC_MDSS_DPTX0_AUX_CLK>,
+                     <&dispcc MDSS_DISP_CC_MDSS_AHB_CLK>;
+            clock-names = "aux",
+                          "cfg_ahb";
+
+            #clock-cells = <1>;
+            #phy-cells = <0>;
+
+            vdda-phy-supply = <&vreg_l1c>;
+            vdda-pll-supply = <&vreg_l4a>;
+        };
+
+        displayport-controller@af54000 {
+            compatible = "qcom,qcs8300-dp", "qcom,sa8775p-dp";
+
+            pinctrl-0 = <&dp_hot_plug_det>;
+            pinctrl-names = "default";
+
+            reg = <0xaf54000 0x104>,
+                  <0xaf54200 0x0c0>,
+                  <0xaf55000 0x770>,
+                  <0xaf56000 0x09c>,
+                  <0xaf57000 0x09c>,
+                  <0xaf58000 0x09c>,
+                  <0xaf59000 0x09c>,
+                  <0xaf5a000 0x23c>,
+                  <0xaf5b000 0x23c>;
+
+            interrupt-parent = <&mdss>;
+            interrupts = <12>;
+            clocks = <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_AUX_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL1_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL2_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL3_CLK>;
+            clock-names = "core_iface",
+                          "core_aux",
+                          "ctrl_link",
+                          "ctrl_link_iface",
+                          "stream_pixel",
+                          "stream_1_pixel",
+                          "stream_2_pixel",
+                          "stream_3_pixel";
+            assigned-clocks = <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
+                              <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>,
+                              <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC>,
+                              <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL2_CLK_SRC>,
+                              <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL3_CLK_SRC>;
+            assigned-clock-parents = <&mdss_dp0_phy 0>,
+                                     <&mdss_dp0_phy 1>,
+                                     <&mdss_dp0_phy 1>,
+                                     <&mdss_dp0_phy 1>;
+            phys = <&mdss_dp0_phy>;
+            phy-names = "dp";
+            operating-points-v2 = <&dp_opp_table>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            #sound-dai-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    mdss_dp0_in: endpoint {
+                        remote-endpoint = <&dpu_intf0_out>;
+                    };
+                };
+
+                port@1 {
+                   reg = <1>;
+
+                   mdss_dp_out: endpoint { };
+                };
+            };
+
+            dp_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-160000000 {
+                    opp-hz = /bits/ 64 <160000000>;
+                    required-opps = <&rpmhpd_opp_low_svs>;
+                };
+
+                opp-270000000 {
+                    opp-hz = /bits/ 64 <270000000>;
+                    required-opps = <&rpmhpd_opp_svs>;
+                };
+
+                opp-540000000 {
+                    opp-hz = /bits/ 64 <540000000>;
+                    required-opps = <&rpmhpd_opp_svs_l1>;
+                };
+
+                opp-810000000 {
+                    opp-hz = /bits/ 64 <810000000>;
+                    required-opps = <&rpmhpd_opp_nom>;
+                };
+            };
+        };
+    };
+...

-- 
2.43.0


