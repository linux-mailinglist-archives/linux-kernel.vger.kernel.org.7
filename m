Return-Path: <linux-kernel+bounces-866465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC21BFFD39
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 567AD3457FA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B682F2909;
	Thu, 23 Oct 2025 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TI2LtKEx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AD42E36F3
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207476; cv=none; b=oeNJFNYwzZKrjjcAbHReCi007Gf8/6ATfITzrJh/2ffGDeSVSiciEdbBsMDXtVwAt++a7j8aYsYaUP0FCIbT4tpJo1d480YOK7T6GGy3Eb6ZmO4obZjnLlHKXC6dwp9CKCgRGwUvFcJluD1HMI/xHg9PT19+KVOUTLZ33XEijes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207476; c=relaxed/simple;
	bh=iVB4aIETpqdaxaa5z/t5JkxTu1Tdd3YtvvH/qyE1gZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ssdd9w5nsMnHr19rBub2RB+MKetTYZtQBhrdBvnM34FCH9SrnZ8K36YUVvBOiazCHGX4KibDnlSaLXMcngQUcwb/fTB/P4wQk90QtWwkaYMuLx7awcttiHrIkcW/xlp6U/4wVwD13z6qRgegj60iZIIEVX4N0SLnosFK9XkU1GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TI2LtKEx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7eGO8026255
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lz1kHXEja+b
	uOq/94C0iL55lIlNIfI1MxOrjNw7/YO0=; b=TI2LtKExfmLnBPlddJifEvDK4ah
	khIdgPr37lPNt9gbWFPCf51cHyFjOWsJl/O2PRWuLMjciW1V+lyzmxzD5ZMIzJGQ
	YKJCHU4UxdcbQt24TRzcPSD0xzgY3Q5kuObCKIIR0EIBYSWWZvTlfbUsbWMoSKiG
	awrINv4k9v7kJMYFqXO8NyYUjetXKg7DUHCTsGCbm54nwIDgUjSOosbaWlyP7NB3
	pgGF4Etuvn59WRlRgDfblzUDHPbq/rT+FLnCfbrbY7tDwnC4fHGpq3VjP5G7siUR
	3DLiyAar2BE8j2NgNavSj8rYtC508dCxkBlT9a4ENF4yaBlEA8MVrLJzSHA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8hp5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:17:53 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78038ed99d9so1105784b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761207472; x=1761812272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lz1kHXEja+buOq/94C0iL55lIlNIfI1MxOrjNw7/YO0=;
        b=f0uBKh4oKZnhMI1B3CvEgpNBYaOuwSQzBFilQvXPq9dj0AcSp5+/seEO5kDMJ2QVsz
         K+WiG2/ifBW00djrXWdHZxh0PVbOPofzaUnPA0BEN1Y/3k08VlbQ8Q8eUCWoklHLY4Cz
         IrNj/B/56GJH9NMhk7e0cybuWSqhLQNYdNZrwo0dnOFM4p1krJhj5M9bVcWu7VxPuL+F
         WhrQDqelz5/QY5j7XmO346UzV0QUGOUUVSiKUQDocins9wUc8LDcPLhqZOtwplM92tPo
         lDjbGjctwX1C0w2Yyyk/1X912oob5CF/fJTupq85cCGRd1VnPbFEMaHLTFkkprS59B7q
         S12A==
X-Forwarded-Encrypted: i=1; AJvYcCVwDoRxbdt0KXoCFlslQiL3y6RxhuYhS3AhZkv8Cb4glgBBo0be4elTngmCmOCKGxiJj6RNfFBqgtRIGqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ztVJivwz19VFz4YXyok4BxeEKDg8jhLVG8iCXZC+wiZwn/Hs
	Nah3nYY7RU6EaeYfxIS0lhDLr3OTBMYN5oLo+t9TDttwj2E48iLOaVfc71hXamkok+5iRV2Gua+
	PheB5yoAimgTi3v/UBi7DRSa/hAFQUilMwQvW49f7feqhbzg2J5nnaPQbsNBPQU5rTrY=
X-Gm-Gg: ASbGnctPf7OZVfivdWPICsqtA9enwSmihvG0xVgaefBIJe+AaQmbUCE/fYpscxLtn9z
	1qrQMrBhW48oWRcN4C9dUWC+lLKAkGksdLb6TDTXtqb23fZfYpSUZ0Nk4NhE9J8HtZJiiD0mogd
	SnFtdeC0KHXV8MPSq1Aj2xEvGCuJ0cGzKSXlFXfin6c752hEv2chrTAmpv0bqSReWFjkpAQ+u47
	+TuHAV6Rwqh/NCsj4idnewCBHWwcFh/Vtf55eedOvsD9de+M66xOZXAk22vqwb0QI7tlLiEF83R
	jT0GKPwvp5zSbsPVRcX7T0UAI+8+1Hz9YacANlyNhrJod1TEtH3szLRtVGfmU++ejpg9WxVr2rm
	PzwHV3IG2yqTr9+GCuoLpXJGgScKOOtxi/m3+cGdsUoEOcuPd7A==
X-Received: by 2002:a05:6a00:4f81:b0:7a1:373f:c216 with SMTP id d2e1a72fcca58-7a220a9ded3mr29531171b3a.14.1761207471589;
        Thu, 23 Oct 2025 01:17:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp8zpx9j/Sn6QSnlYRNuEnR+/U77aCoIlwWaGJ5qaBx5l1S7e63z7GhP2jJKNH/fAFBybwTQ==
X-Received: by 2002:a05:6a00:4f81:b0:7a1:373f:c216 with SMTP id d2e1a72fcca58-7a220a9ded3mr29531138b3a.14.1761207471076;
        Thu, 23 Oct 2025 01:17:51 -0700 (PDT)
Received: from yuanjiey.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9e907sm1711740b3a.27.2025.10.23.01.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:17:50 -0700 (PDT)
From: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: [PATCH 12/12] dt-bindings: display/msm: qcom,kaanapali-mdss: Add Kaanapali
Date: Thu, 23 Oct 2025 16:17:36 +0800
Message-Id: <20251023081736.1251-1-yuanjie.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YJusTW1TDi0_y_wz9S-wnXqOmSiIBDFx
X-Proofpoint-GUID: YJusTW1TDi0_y_wz9S-wnXqOmSiIBDFx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfX0VBfQSn8ZY37
 QP/WRTmDYTpMYCYqwVYpLMUOqCR9xcVDIwerlw1HIvKCOnBP7Q8ZUxRRQO0VY7fa/+lmI//+M2q
 GJIIptAR/HR4gjNJY4EG4KJq8pqfoagEcRG2XSAUbsF8fmTDAAZxolE42suG2wYUQ5Cmzjk64nm
 2pjV9qdn/GHTCfmdmwVsgAmcFd0cv2KjiuwEGwGX7WEmOccBPPiUACXjC6KujDlY9t9LaVzXLCM
 Wj1ykeIC9rLmCuaSiqq6Njd59QV77M/NFbrdPnRvj38HDd8AEzXSPaeaoUJ+il4ojSJpfAsfzEo
 GTeRy3QlBMa/atUSA47aUhPHxD11TCYJPKNJpwyPn7SQHypDF2v5pnepgoxe3vcV6Wlnkb7a4BS
 c18BCFHVGivxFtY/PX/fU7lCIMdZxQ==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68f9e4b1 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=R7wmlHStZQC7fVxWcBoA:9 a=2VI0MkxyNR6bbpdq8BZq:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164

From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>

Add MDSS/MDP display subsystem for Qualcomm Kaanapali.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
---
 .../display/msm/qcom,kaanapali-mdss.yaml      | 298 ++++++++++++++++++
 1 file changed, 298 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
new file mode 100644
index 000000000000..3006c0a69309
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
@@ -0,0 +1,298 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,kaanapali-mdss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Kaanapali Display MDSS
+
+maintainers:
+  - Yongxing Mou <yongxing.mou@oss.qualcomm.com>
+
+description:
+  Kaanapali MSM Mobile Display Subsystem(MDSS), which encapsulates sub-blocks
+  like DPU display controller, DSI and DP interfaces etc.
+
+$ref: /schemas/display/msm/mdss-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,kaanapali-mdss
+
+  clocks:
+    items:
+      - description: Display AHB
+      - description: Display hf AXI
+      - description: Display core
+      - description: Display AHB SWI
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
+        const: qcom,kaanapali-dpu
+
+  "^dsi@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        contains:
+          const: qcom,kaanapali-dsi-ctrl
+
+  "^phy@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,kaanapali-dsi-phy-3nm
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
+    #include <dt-bindings/interconnect/qcom,kaanapali-rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy-qcom-qmp.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    display-subsystem@9800000 {
+            compatible = "qcom,kaanapali-mdss";
+            reg = <0x09800000 0x1000>;
+            reg-names = "mdss";
+
+            interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+
+            clocks = <&disp_cc_mdss_ahb_clk>,
+                     <&gcc_disp_hf_axi_clk>,
+                     <&disp_cc_mdss_mdp_clk>,
+                     <&disp_cc_mdss_ahb1_clk>;
+            resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
+
+            interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_ALWAYS
+                             &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+                            <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+                             &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+            interconnect-names = "mdp0-mem",
+                                 "cpu-cfg";
+
+            power-domains = <&dispcc DISP_CC_MDSS_CORE_GDSC>;
+
+            iommus = <&apps_smmu 0x800 0x2>;
+
+            interrupt-controller;
+            #interrupt-cells = <1>;
+
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges;
+
+            display-controller@9801000 {
+                compatible = "qcom,kaanapali-dpu";
+                reg = <0x09801000 0x1C8000>,
+                      <0x09B16000 0x3000>;
+                reg-names = "mdp",
+                            "vbif";
+
+                interrupts-extended = <&mdss 0>;
+
+                clocks = <&gcc_disp_hf_axi_clk>,
+                         <&disp_cc_mdss_ahb_clk>,
+                         <&disp_cc_mdss_mdp_lut_clk>,
+                         <&disp_cc_mdss_mdp_clk>,
+                         <&disp_cc_mdss_vsync_clk>;
+                clock-names = "nrt_bus",
+                              "iface",
+                              "lut",
+                              "core",
+                              "vsync";
+
+                assigned-clocks = <&disp_cc_mdss_vsync_clk>;
+                assigned-clock-rates = <19200000>;
+
+                operating-points-v2 = <&mdp_opp_table>;
+
+                power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+
+                        dpu_intf1_out: endpoint {
+                            remote-endpoint = <&mdss_dsi0_in>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+
+                        dpu_intf2_out: endpoint {
+                            remote-endpoint = <&mdss_dsi1_in>;
+                        };
+                    };
+                };
+
+                mdp_opp_table: opp-table {
+                    compatible = "operating-points-v2";
+
+                    opp-207000000 {
+                        opp-hz = /bits/ 64 <207000000>;
+                        required-opps = <&rpmhpd_opp_low_svs>;
+                    };
+
+                    opp-337000000 {
+                        opp-hz = /bits/ 64 <337000000>;
+                        required-opps = <&rpmhpd_opp_svs>;
+                    };
+
+                    opp-417000000 {
+                        opp-hz = /bits/ 64 <417000000>;
+                        required-opps = <&rpmhpd_opp_svs_l1>;
+                    };
+
+                    opp-532000000 {
+                        opp-hz = /bits/ 64 <532000000>;
+                        required-opps = <&rpmhpd_opp_nom>;
+                    };
+
+                    opp-600000000 {
+                        opp-hz = /bits/ 64 <600000000>;
+                        required-opps = <&rpmhpd_opp_nom_l1>;
+                    };
+
+                    opp-650000000 {
+                        opp-hz = /bits/ 64 <650000000>;
+                        required-opps = <&rpmhpd_opp_turbo>;
+                    };
+                };
+            };
+
+            dsi@ae94000 {
+                compatible = "qcom,kaanapali-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+                reg = <0x09ac0000 0x500>;
+                reg-names = "dsi_ctrl";
+
+                interrupts-extended = <&mdss 4>;
+
+                clocks = <&disp_cc_mdss_byte0_clk>,
+                         <&disp_cc_mdss_byte0_intf_clk>,
+                         <&disp_cc_mdss_pclk0_clk>,
+                         <&disp_cc_mdss_esc0_clk>,
+                         <&disp_cc_mdss_ahb_clk>,
+                         <&gcc_disp_hf_axi_clk>,
+                         <&mdss_dsi0_phy 1>,
+                         <&mdss_dsi0_phy 0>,
+                         <&disp_cc_esync0_clk>,
+                         <&disp_cc_osc_clk>,
+                         <&disp_cc_mdss_byte0_clk_src>,
+                         <&disp_cc_mdss_pclk0_clk_src>;
+                clock-names = "byte",
+                              "byte_intf",
+                              "pixel",
+                              "core",
+                              "iface",
+                              "bus",
+                              "dsi_pll_pixel",
+                              "dsi_pll_byte",
+                              "esync",
+                              "osc",
+                              "byte_src",
+                              "pixel_src";
+
+                operating-points-v2 = <&mdss_dsi_opp_table>;
+
+                power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+                phys = <&mdss_dsi0_phy>;
+                phy-names = "dsi";
+
+                vdda-supply = <&vreg_l3g_1p2>;
+
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+
+                        mdss_dsi0_in: endpoint {
+                            remote-endpoint = <&dpu_intf1_out>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+
+                        mdss_dsi0_out: endpoint {
+                            remote-endpoint = <&panel0_in>;
+                            data-lanes = <0 1 2 3>;
+                        };
+                    };
+                };
+
+                mdss_dsi_opp_table: opp-table {
+                    compatible = "operating-points-v2";
+
+                    opp-187500000 {
+                        opp-hz = /bits/ 64 <187500000>;
+                        required-opps = <&rpmhpd_opp_low_svs>;
+                    };
+
+                    opp-300000000 {
+                        opp-hz = /bits/ 64 <300000000>;
+                        required-opps = <&rpmhpd_opp_svs>;
+                    };
+
+                    opp-358000000 {
+                        opp-hz = /bits/ 64 <358000000>;
+                        required-opps = <&rpmhpd_opp_svs_l1>;
+                    };
+                };
+            };
+
+            mdss_dsi0_phy: phy@ae95000 {
+                compatible = "qcom,kaanapali-dsi-phy-3nm", "qcom,sm8750-dsi-phy-3nm";
+                reg = <0x09ac1000 0x200>,
+                      <0x09ac1200 0x280>,
+                      <0x09ac1500 0x400>;
+                reg-names = "dsi_phy",
+                            "dsi_phy_lane",
+                            "dsi_pll";
+
+                clocks = <&disp_cc_mdss_ahb_clk>,
+                         <&rpmhcc RPMH_CXO_CLK>;
+                clock-names = "iface",
+                              "ref";
+
+                vdds-supply = <&vreg_l3i_0p88>;
+
+                #clock-cells = <1>;
+                #phy-cells = <0>;
+            };
+        };
-- 
2.34.1


