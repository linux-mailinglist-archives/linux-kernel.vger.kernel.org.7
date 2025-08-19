Return-Path: <linux-kernel+bounces-774796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A812DB2B7A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC51A4E14F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB62C2D24AC;
	Tue, 19 Aug 2025 03:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UEsp33oC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CE524A07C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574460; cv=none; b=qJxYnZJn+AbUhOb1ljbT4d+7lbsxnhMtHCI1f8HR0xTU5QUVVPUYS2qMxNg/MiQUx1W/qj6IqdKmsfCKwS9rZDuadNXkAtP1rFIt8oNftejFAJATwvvEOE6v/6x/3Vw7GW5UITO4F2zqKSzLF63khB2+IxlD/SS/1ORk5BKLUMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574460; c=relaxed/simple;
	bh=Wenpnfpcg173i/c96KQQjiJFEgMUrwSYfyZ+6WeMrc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ug4Mramo0xSs/XfLXN25+E0oxntnaauoPHdpLh8zIn4kFDSgGidPoIf3Qthn8n95r3+k2z+VATdpUVHsmAnAKCCwHJBeQRwKn1Mr8labeYiWAm7qkpJVoUzmB1n/O+k26FvNID7mbiCY1us+3Py07MiFA4rM/uA9f6xbdkSeNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UEsp33oC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IMKTUM025668
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CP/bfFnyGckBytifnvL8aXmVIdR2eNM2EUptKGsoGus=; b=UEsp33oCMJtv0zih
	ZDBZtE3QtgANp+lrwNGfATzStLyztlHGwwoZkXQGUm5/BEkK5FwbCrQRKPtoek7e
	zofNsEafhG+z4C5uj9q8lh3UhlND1DcLltly4moFoBvn+nsikBw9LC8LbQ94lS8t
	ThqsFF0/u/mDr55uobzaqWozgZgGv5Mr7hLFB2os6H05r5S6zdRrxnauOE9V+Vti
	Y5e11B5XAICHnRMQBNF2LirP3CrBLmUIV3dGm7X8fDmFYYxwzYcGZupriHoOjWgy
	kJr50YBt1JDCLtOhjS+kBMnZ8PzXocHdqN2SONlgi60YIymg6hDJAT9oyrPMUnQU
	+t39Tw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyunu88a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24457f440f0so52848395ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755574455; x=1756179255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CP/bfFnyGckBytifnvL8aXmVIdR2eNM2EUptKGsoGus=;
        b=UnFUjW7yEbMWSC6D/arzO7YkYSkbnDmdxmeXj7FbUIzAXdC4ZOEdHr4WBESYAE7o8C
         myKpAHUgK9RtBgselw4/U6pttwIqXnaBhYLCvqeIxrEwO/1CZxOrYx+VyUH48UVdrg4l
         RRrDDEnsFN4EVcreniEQVvOqc/yu2zu+fTPKStN8KGBsdl1kfN50YWtp+bkfxeECVVhF
         PQ2sZYqhYaQTfs4DgfSy7Cph99pQSLB2FOPiBmsn2R1gKw9w7PLNei4+k7Timb4RR5OI
         RL5ksP5AJeopIs/XYhGfqYp71TKhhsdkQGQ5I72MSLmsu5e3Wei/rhOQd/2teP0teQ7F
         iyxw==
X-Forwarded-Encrypted: i=1; AJvYcCVbpVZOVYXtMIcM1mJwfb+qluwCX+aQK0m5blPbM+5dSQ/3rzbxtr+PBIzarfD0nnDuTmK60atd25f1MLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1FNXynGT8B9KJRHhjnlpHG05xJOZl6wXw67S4FpJbx/VSKvCU
	J64AT0P9H3NYUzILP+V3A5rzFMb2sr8apMz4FVjX/I1M8bSnRMooc9sTZJsoQyZqXt7nT/9BAtS
	r5imAqERNrXXO+FaJExwi1+1VyrFQuZY5/69y52Q804Z4JPjkuiya+J1Jz7fOLow/4r0=
X-Gm-Gg: ASbGnctMjelzZ9WVvP3QzEzJzG8eYA/bXS4/+9ZuCCtn7b77XB8Nx5tES9xCiXa3Qtd
	9Sy80n9reVgz3HWDu7vB5TG322X0B3MD6piI3PdF4j3mRyPcLygqASDmbLeelh/d0N+4KpK67pN
	Tdx4Lnbbloi/aP2AqfkxLunWtzpcK0PCt6xPCh+f70eGm+EirXTgYtpIPJIImJyyPT0iJFGF+6f
	u/9f6fvOn0Us5ei+RMXS3JuVEqOimMp7NIX9kHKePJNACCZklrxD5W11YG1E5INih99L/G6Kc++
	DbG5X7nBU5lVRypf87umYLny0brxu6BMNOXZPaSTOivVzzVY9Y+43jvaJC+nLO1W6l+0LDM=
X-Received: by 2002:a17:902:f652:b0:240:8fef:a3bd with SMTP id d9443c01a7336-245e03156camr12879595ad.25.1755574455204;
        Mon, 18 Aug 2025 20:34:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9ufkvzTrEOiCZ9V6By4yoYekSourzxEvbmCBVp9KGtRngcDmGBzJ92TYwdSZ0Szpeb50UeA==
X-Received: by 2002:a17:902:f652:b0:240:8fef:a3bd with SMTP id d9443c01a7336-245e03156camr12879295ad.25.1755574454643;
        Mon, 18 Aug 2025 20:34:14 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f55esm94486325ad.82.2025.08.18.20.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 20:34:14 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 11:33:30 +0800
Subject: [PATCH v7 3/6] dt-bindings: display/msm: Document MDSS on QCS8300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-qcs8300_mdss-v7-3-49775ef134f4@oss.qualcomm.com>
References: <20250819-qcs8300_mdss-v7-0-49775ef134f4@oss.qualcomm.com>
In-Reply-To: <20250819-qcs8300_mdss-v7-0-49775ef134f4@oss.qualcomm.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755574427; l=10120;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=Wenpnfpcg173i/c96KQQjiJFEgMUrwSYfyZ+6WeMrc4=;
 b=q93K5WK1BcTnIziQAw9/s51bmPNOGWKw9cvIGjZg9Nu8iqfeP7cObo1fYIX8hDYpqQCL9Obpf
 tie2VCiXFCuASj5jSORDGRh5R9bA6YeSlgI/dvt44hZnm7t73AEPjOi
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-GUID: hujcbaPEKNkMA4VgJW7B9ccq3HqN9lHG
X-Authority-Analysis: v=2.4 cv=N6UpF39B c=1 sm=1 tr=0 ts=68a3f0b8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=mw5JQ2FHeNGQCEwkIB4A:9 a=x9G3774qgbUdaUce:21 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA3MSBTYWx0ZWRfX3U9Zzw4rrcSL
 6+d0fclS5nI3SE3t12c6UinJe3GSeD519IH/6UYrj+cDpwcKvV8GXMBXJHSKFy5BcaBW+lFg2ZO
 9ehnOvuaDX05I0G6Rjyv2KXZre8TJ5Guz3C+bxIlMgfNtIACl1+0cpfw3KSFOTYffEtNOfBhiTc
 Gh5wOD4ZTY+HGx+axW8+s5z+VhsrVWZLiect17a9FQp/tHFb5mwPApJqLJ5TeYf3XIvL/AHZw6I
 chFS5r4+DjnpZkpjDpV0/6DHfSHszRKutoa34wFyEkaTwuOWlUZtjY0kdfBH7hBF1nt8wtx1j1R
 5fR3kSjdNR/slPPmdqR+LDTIbh+e8Kv5cXtTZgmNqIVSUoT8u32c2TPYKs3eJj3AWyKzROujyts
 Ir/1Qt6d
X-Proofpoint-ORIG-GUID: hujcbaPEKNkMA4VgJW7B9ccq3HqN9lHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180071

Document the MDSS hardware found on the Qualcomm QCS8300 platform.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 .../bindings/display/msm/qcom,qcs8300-mdss.yaml    | 282 +++++++++++++++++++++
 1 file changed, 282 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcs8300-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcs8300-mdss.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ebcfe1f9358b3721c0132621a4379897c05ea2d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcs8300-mdss.yaml
@@ -0,0 +1,282 @@
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
+        items:
+          - const: qcom,qcs8300-dp
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
+            compatible = "qcom,qcs8300-dp";
+
+            pinctrl-0 = <&dp_hot_plug_det>;
+            pinctrl-names = "default";
+
+            reg = <0xaf54000 0x104>,
+                  <0xaf54200 0x0c0>,
+                  <0xaf55000 0x770>,
+                  <0xaf56000 0x09c>,
+                  <0xaf57000 0x09c>;
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
2.34.1


