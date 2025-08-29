Return-Path: <linux-kernel+bounces-791315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F81B3B544
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045713BEDEF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9723286412;
	Fri, 29 Aug 2025 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eU6zkGB+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B82D1319
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454304; cv=none; b=VKGaoa7HAXrRpYb0Zhm/P4LeUr40cxWWD0s4jaDF2L/tQsLrIrB4GqBnrvrpH39phl4QbQ9T3dRkZGYtisTnvt85LFbWK/ZXuD79/NfnfC0VkL7deoKZPrnTkdT+PCnEkHDW2eran5igbq86QYgOE+EP7/rqRnzMMk3TOau+ZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454304; c=relaxed/simple;
	bh=z9drRjXdTT0KA8t2VNi+iNMOxRn/Ma7SLpUA/tpJQcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BxK5XknsPazDa/PJWA7n8uZoYqf7IgQBnIO1/iXToGtVE4iAnI8gWDjnCKyaOA6CJcY5QUWKDsOdFU3IXw6XqcbJK9Oh6sgQ4bX8dBRrngD/ZDUS2Xdqn1rTYexxljiaiebfPQ6lgPIiOvifykdE8odcQxUnljy9VToErWqtXxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eU6zkGB+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T5tPlu009468
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tg0TadezHCZinWRaUOrMAwdmXaDSKwhZG9ok3+9UXoM=; b=eU6zkGB+GKqAa4gf
	GGY6VP76EZQkLEXK0s+MO2GmTH+pFdhWHO7rFZgb3e7zy9oR9rA4omnPos8Lfl7h
	+3pSRsBn4PDatZwsYmYvuHyPp6Arb2vmBFXTMcNIDKVPRVQN2L60TrpSr4fdHob9
	lVU4MAQ0gnu7Lh9IiIBjAsaBkVK/ueiWlh/lhmh6lOQ1i9ZG3zdeCKPJETwStN99
	e2V1rGf9AS4k82baaN2V538k99KrfbOG2q/9LB64KbhR0vPz3F4Hb+EDplhV5gBG
	wRlsdhLO3ZWagiyoKsePJRdZEdB8MxRy7Z808Vp+CFeSximG7wiUnW04BEJOTR0j
	zbcRSA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5u0sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 07:58:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4c746c020cso821128a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454300; x=1757059100;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tg0TadezHCZinWRaUOrMAwdmXaDSKwhZG9ok3+9UXoM=;
        b=qrWF5r0ZE59MlA0dgedPlTLeiV7Q9774NxSY24ZVUaJeE7Gtmod2xtEH0I7FHsK8x5
         gR/L7Gz8psBYdcWIGLP8iEW/Q+3p1Yifqcpg1Ewwaf+zhueSYZcWnPiu3XJ1eQ+riiiM
         eAHRrOfMutIB/CwoZZIhG9vZpfseCBvI1EEU/ysMiZHL3vZEaUBQCFqRUHuj//yfvaQT
         RvvMr5P8BHvq7l7qjAeawdk8eBpqkov3RLVNBmPMfsnBCWrD7790O0+8+x+UCt6xLXe7
         gTnWftX9tgcEQgAmah4QpkW2jYDkfpshBfpOwy1cmOwAqbnCzeYQifGK7LDHRUYa5tDE
         xrPg==
X-Forwarded-Encrypted: i=1; AJvYcCWIcoxczT2gq5834Co2/XQp2MlLwZcqgSEEXbuMuaMRRaRlkZonpyfP3qhqm1nadKdGVAuYetxamkNzEoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQuq3xNJuodDQ1m+77rmjIG7i9BDiXctN/T9uXHWpI9sJZwbfx
	2zft099TeYU0r991wk7Pz66kxyh4YACF0Th08IU2ktKSK0VSZ1qAafJzP0yLal7PZD6fcWBnBmD
	zmtUYnv+YklwQlBECAeAdkAAVsIQHOryr+tahdQpOrTz34rgOBfoRKiCyzSrdvdunRh8=
X-Gm-Gg: ASbGnctrr9uKRlsOF0ejAuelGyyL6Q/SaEoFECrrhmwNkrUFxOBZWte8VQPiEin8mKS
	TMFYbTFnnlJCZNTPRePBuot0Yc+/wqNM4ZmEDJ3pgi2tBbl8Nz7VTyOZc1ATLpOLGgRsVeaGVEn
	PhzbIvR+/+PS56tMHnx9LZyqAe3SReV1byPfCJTAZdGb/iRc+FRxXxDE5Cohl7063Ah4wEHFMCf
	Xk/1rv5164BapHn+9BGRfO0BF/cnetO38qSRoRXxRUePQR8iZPiuOFf98sQLCLJ7NpqtP3mkAfr
	0X0lfaqhMi5fbEK9RfLwn3C77oy+ghBAZ3ibU2vMgrXPdpQR8Ln6YcL06gLUgSxH
X-Received: by 2002:a05:6a20:9191:b0:243:a251:cf51 with SMTP id adf61e73a8af0-243a251d3eemr12213706637.54.1756454300448;
        Fri, 29 Aug 2025 00:58:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh6zQOpPVgv4227fwAgRWkPOqZi3+XUDXi949ObJPhcXPGNdm2RttgZhvvfTGIdNbP+4uPmQ==
X-Received: by 2002:a05:6a20:9191:b0:243:a251:cf51 with SMTP id adf61e73a8af0-243a251d3eemr12213663637.54.1756454299950;
        Fri, 29 Aug 2025 00:58:19 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bb5dasm1554416b3a.55.2025.08.29.00.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:58:19 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Fri, 29 Aug 2025 13:28:03 +0530
Subject: [PATCH 1/2] dt-bindings: clock: Add DISPCC and reset controller
 for GLYMUR SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-glymur-disp-clock-controllers-v1-1-0ce6fabd837c@oss.qualcomm.com>
References: <20250829-glymur-disp-clock-controllers-v1-0-0ce6fabd837c@oss.qualcomm.com>
In-Reply-To: <20250829-glymur-disp-clock-controllers-v1-0-0ce6fabd837c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXw+FlZMDi9FH7
 MAEnKNkdyfimnz0OvWbPpTBO0XZUFmjZYjfHQiuXgZz5a1YWFhUfkVz7i+TKgbqt+99potBVasm
 2tAPn9Sv0a11+qhzHkovvBWmH0M7KTWArFHLfG2kQZykm4puosp6wly6QtCbt+0J4tPY81uPFRm
 jFMrGfK6m1Pn84M1rv+zkiVLChGNS0jej2LHPUB/8Lop/Ahot7KOcebLscORbZlTa61DGtDufTQ
 mr8eDPBH/biYT3E43kHcFBzZyzuJWp6a4Hlq7XmS78GLWMSVGf3OsI0WHK4+U/Tt6SflMtJHPCG
 UcDeGSA+U0y7Hg+BBhLvMfd3iZL2ZN+8BjpeQ18T7Q6y8cAVpvdGkn5Qan9sYDNA7+L+FTF08Fv
 8BzZyKaU
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68b15d9d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=vLIBROXKFhWHEpkJx9gA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: JwdK_pnYjp-2kvpku-BBdLZv3dxt-__9
X-Proofpoint-ORIG-GUID: JwdK_pnYjp-2kvpku-BBdLZv3dxt-__9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

Add the device tree bindings for the display clock controller which are
required on Qualcomm Glymur SoC.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 .../bindings/clock/qcom,glymur-dispcc.yaml         |  99 ++++++++++++++++++
 include/dt-bindings/clock/qcom,glymur-dispcc.h     | 114 +++++++++++++++++++++
 2 files changed, 213 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,glymur-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,glymur-dispcc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..063da2416dbaed764b8579a090bc5fc0531ab60d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,glymur-dispcc.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,glymur-dispcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock & Reset Controller on GLYMUR
+
+maintainers:
+  - Taniya Das <taniya.das@oss.qualcomm.com>
+
+description: |
+  Qualcomm display clock control module which supports the clocks, resets and
+  power domains for the MDSS instances on GLYMUR SoC.
+
+  See also:
+    include/dt-bindings/clock/qcom,dispcc-glymur.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,glymur-dispcc
+
+  clocks:
+    items:
+      - description: Board CXO clock
+      - description: Board sleep clock
+      - description: DisplayPort 0 link clock
+      - description: DisplayPort 0 VCO div clock
+      - description: DisplayPort 1 link clock
+      - description: DisplayPort 1 VCO div clock
+      - description: DisplayPort 2 link clock
+      - description: DisplayPort 2 VCO div clock
+      - description: DisplayPort 3 link clock
+      - description: DisplayPort 3 VCO div clock
+      - description: DSI 0 PLL byte clock
+      - description: DSI 0 PLL DSI clock
+      - description: DSI 1 PLL byte clock
+      - description: DSI 1 PLL DSI clock
+      - description: Standalone PHY 0 PLL link clock
+      - description: Standalone PHY 0 VCO div clock
+      - description: Standalone PHY 1 PLL link clock
+      - description: Standalone PHY 1 VCO div clock
+
+  power-domains:
+    description:
+      A phandle and PM domain specifier for the MMCX power domain.
+    maxItems: 1
+
+  required-opps:
+    description:
+      A phandle to an OPP node describing required MMCX performance point.
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - power-domains
+  - '#power-domain-cells'
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,glymur-dispcc.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    clock-controller@af00000 {
+      compatible = "qcom,glymur-dispcc";
+      reg = <0x0af00000 0x20000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&sleep_clk>,
+               <&mdss_dp_phy0 0>,
+               <&mdss_dp_phy0 1>,
+               <&mdss_dp_phy1 0>,
+               <&mdss_dp_phy1 1>,
+               <&mdss_dp_phy2 0>,
+               <&mdss_dp_phy2 1>,
+               <&mdss_dp_phy3 0>,
+               <&mdss_dp_phy3 1>,
+               <&mdss_dsi0_phy 0>,
+               <&mdss_dsi0_phy 1>,
+               <&mdss_dsi1_phy 0>,
+               <&mdss_dsi1_phy 1>,
+               <&mdss_phy0_link 0>,
+               <&mdss_phy0_vco_div 0>,
+               <&mdss_phy1_link 1>,
+               <&mdss_phy1_vco_div 1>;
+      power-domains = <&rpmhpd RPMHPD_MMCX>;
+      required-opps = <&rpmhpd_opp_low_svs>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,glymur-dispcc.h b/include/dt-bindings/clock/qcom,glymur-dispcc.h
new file mode 100644
index 0000000000000000000000000000000000000000..a845d76defe282d953e82e8b595433c5f9cd364a
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,glymur-dispcc.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025, Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_GLYMUR_H
+#define _DT_BINDINGS_CLK_QCOM_DISP_CC_GLYMUR_H
+
+/* DISP_CC clocks */
+#define DISP_CC_ESYNC0_CLK					0
+#define DISP_CC_ESYNC0_CLK_SRC					1
+#define DISP_CC_ESYNC1_CLK					2
+#define DISP_CC_ESYNC1_CLK_SRC					3
+#define DISP_CC_MDSS_ACCU_SHIFT_CLK				4
+#define DISP_CC_MDSS_AHB1_CLK					5
+#define DISP_CC_MDSS_AHB_CLK					6
+#define DISP_CC_MDSS_AHB_CLK_SRC				7
+#define DISP_CC_MDSS_BYTE0_CLK					8
+#define DISP_CC_MDSS_BYTE0_CLK_SRC				9
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC				10
+#define DISP_CC_MDSS_BYTE0_INTF_CLK				11
+#define DISP_CC_MDSS_BYTE1_CLK					12
+#define DISP_CC_MDSS_BYTE1_CLK_SRC				13
+#define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC				14
+#define DISP_CC_MDSS_BYTE1_INTF_CLK				15
+#define DISP_CC_MDSS_DPTX0_AUX_CLK				16
+#define DISP_CC_MDSS_DPTX0_AUX_CLK_SRC				17
+#define DISP_CC_MDSS_DPTX0_LINK_CLK				18
+#define DISP_CC_MDSS_DPTX0_LINK_CLK_SRC				19
+#define DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC			20
+#define DISP_CC_MDSS_DPTX0_LINK_DPIN_CLK			21
+#define DISP_CC_MDSS_DPTX0_LINK_DPIN_DIV_CLK_SRC		22
+#define DISP_CC_MDSS_DPTX0_LINK_INTF_CLK			23
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK				24
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC			25
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK				26
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC			27
+#define DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK		28
+#define DISP_CC_MDSS_DPTX1_AUX_CLK				29
+#define DISP_CC_MDSS_DPTX1_AUX_CLK_SRC				30
+#define DISP_CC_MDSS_DPTX1_LINK_CLK				31
+#define DISP_CC_MDSS_DPTX1_LINK_CLK_SRC				32
+#define DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC			33
+#define DISP_CC_MDSS_DPTX1_LINK_DPIN_CLK			34
+#define DISP_CC_MDSS_DPTX1_LINK_DPIN_DIV_CLK_SRC		35
+#define DISP_CC_MDSS_DPTX1_LINK_INTF_CLK			36
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK				37
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC			38
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK				39
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC			40
+#define DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK		41
+#define DISP_CC_MDSS_DPTX2_AUX_CLK				42
+#define DISP_CC_MDSS_DPTX2_AUX_CLK_SRC				43
+#define DISP_CC_MDSS_DPTX2_LINK_CLK				44
+#define DISP_CC_MDSS_DPTX2_LINK_CLK_SRC				45
+#define DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC			46
+#define DISP_CC_MDSS_DPTX2_LINK_DPIN_CLK			47
+#define DISP_CC_MDSS_DPTX2_LINK_DPIN_DIV_CLK_SRC		48
+#define DISP_CC_MDSS_DPTX2_LINK_INTF_CLK			49
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK				50
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC			51
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK				52
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC			53
+#define DISP_CC_MDSS_DPTX2_USB_ROUTER_LINK_INTF_CLK		54
+#define DISP_CC_MDSS_DPTX3_AUX_CLK				55
+#define DISP_CC_MDSS_DPTX3_AUX_CLK_SRC				56
+#define DISP_CC_MDSS_DPTX3_LINK_CLK				57
+#define DISP_CC_MDSS_DPTX3_LINK_CLK_SRC				58
+#define DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC			59
+#define DISP_CC_MDSS_DPTX3_LINK_DPIN_CLK			60
+#define DISP_CC_MDSS_DPTX3_LINK_DPIN_DIV_CLK_SRC		61
+#define DISP_CC_MDSS_DPTX3_LINK_INTF_CLK			62
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK				63
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC			64
+#define DISP_CC_MDSS_ESC0_CLK					65
+#define DISP_CC_MDSS_ESC0_CLK_SRC				66
+#define DISP_CC_MDSS_ESC1_CLK					67
+#define DISP_CC_MDSS_ESC1_CLK_SRC				68
+#define DISP_CC_MDSS_MDP1_CLK					69
+#define DISP_CC_MDSS_MDP_CLK					70
+#define DISP_CC_MDSS_MDP_CLK_SRC				71
+#define DISP_CC_MDSS_MDP_LUT1_CLK				72
+#define DISP_CC_MDSS_MDP_LUT_CLK				73
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK				74
+#define DISP_CC_MDSS_PCLK0_CLK					75
+#define DISP_CC_MDSS_PCLK0_CLK_SRC				76
+#define DISP_CC_MDSS_PCLK1_CLK					77
+#define DISP_CC_MDSS_PCLK1_CLK_SRC				78
+#define DISP_CC_MDSS_PCLK2_CLK					79
+#define DISP_CC_MDSS_PCLK2_CLK_SRC				80
+#define DISP_CC_MDSS_RSCC_AHB_CLK				81
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK				82
+#define DISP_CC_MDSS_VSYNC1_CLK					83
+#define DISP_CC_MDSS_VSYNC_CLK					84
+#define DISP_CC_MDSS_VSYNC_CLK_SRC				85
+#define DISP_CC_OSC_CLK						86
+#define DISP_CC_OSC_CLK_SRC					87
+#define DISP_CC_PLL0						88
+#define DISP_CC_PLL1						89
+#define DISP_CC_SLEEP_CLK					90
+#define DISP_CC_SLEEP_CLK_SRC					91
+#define DISP_CC_XO_CLK						92
+#define DISP_CC_XO_CLK_SRC					93
+
+/* DISP_CC power domains */
+#define DISP_CC_MDSS_CORE_GDSC					0
+#define DISP_CC_MDSS_CORE_INT2_GDSC				1
+
+/* DISP_CC resets */
+#define DISP_CC_MDSS_CORE_BCR					0
+#define DISP_CC_MDSS_CORE_INT2_BCR				1
+#define DISP_CC_MDSS_RSCC_BCR					2
+
+#endif

-- 
2.34.1


