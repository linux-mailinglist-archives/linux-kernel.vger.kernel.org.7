Return-Path: <linux-kernel+bounces-602426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D71A87AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 10:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C13165B15
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 08:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A8E25E808;
	Mon, 14 Apr 2025 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LOFBdaQf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A54C25D8E0;
	Mon, 14 Apr 2025 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620205; cv=none; b=tPKD+EDkXj4HcqJeXBPTwFIOqHy7fCzXHTYvqokwLOTC4kYQ+HsvkykiwRN9kpPXke08wuurjcYUrENCb31XqEz3KBU0hcm/hsf01bJAxwpu8p+I47xLHMsFQjmek7vDNkUJvTdB5OUbqBLoz00iRLGPoIPL5x1744vChLsYK5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620205; c=relaxed/simple;
	bh=1LOionzbss7mtMAS3gCRNeywhI8F7XTkxNtHW0gEyP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=I6GOM+VTA4O7jgyJHnyojMSXygTjhm+crLHlEWNi9LPrE0SKUOSZ6gseJzcscf9nPQnnioK2DfN9O/m7GUQO87v6Mt5KppayG7AIEkMKWQnEkc+HOQ3toVTuEZ7BhWaCgrbOXm3MpS2MmYFzHsYLyCUO5X5KiJW0dZwZp6oYhTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LOFBdaQf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DM1ijw017551;
	Mon, 14 Apr 2025 08:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l2pLI1CxtJRFhHckCpfQrYFzaWV4QWm8s5WWtkbuouI=; b=LOFBdaQfLgHimSm9
	DfTdegCKWHJoW5VW0GrMTvEhAG2cJFQPLcDGjWvB67+9ZNxscQKD8AWsHHnv7dtW
	0z8jrm4y+8qzqIvCJSoOHjquZVa9mHX90kSkkx3q/lGtnYELHO/4p5pmrfcUwh9A
	sdJ8bzpOrrgtXpM8Z0WnDqPw79cttCBwYrXRZfGU2i/ni/c1kCZMGSWq08UON2BD
	No/5OD9kHfXOwRuYsnXZCKGbUwSNxZeTZkbOXeLjrZONW+fuSQFt7BUw2UEs3Ks/
	IYx1hm+1QmlNIh0N+eFzI/taLswymc6OeGknQUV4TDlGGAQRMCJhUtV7m+auHxdG
	qSEm/Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhfcusd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 08:43:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53E8hDoe032178
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 08:43:13 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 14 Apr 2025 01:43:08 -0700
From: Taniya Das <quic_tdas@quicinc.com>
Date: Mon, 14 Apr 2025 14:12:13 +0530
Subject: [PATCH v7 02/10] dt-bindings: clock: Add Qualcomm QCS615 Camera
 clock controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250414-qcs615-mm-v7-clock-controllers-v7-2-ebab8e3a96e9@quicinc.com>
References: <20250414-qcs615-mm-v7-clock-controllers-v7-0-ebab8e3a96e9@quicinc.com>
In-Reply-To: <20250414-qcs615-mm-v7-clock-controllers-v7-0-ebab8e3a96e9@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>
CC: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-aa3f6
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=CfUI5Krl c=1 sm=1 tr=0 ts=67fccaa1 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=Ql2orbCSbd2v8qn6OVgA:9 a=QEXdDO2ut3YA:10 a=RVmHIydaz68A:10 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: nGoB0YlDD5ubD03uI0lL07nJKbY25V6F
X-Proofpoint-ORIG-GUID: nGoB0YlDD5ubD03uI0lL07nJKbY25V6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140062

Add DT bindings for the Camera clock on QCS615 platforms. Add the
relevant DT include definitions as well.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 .../bindings/clock/qcom,qcs615-camcc.yaml          |  51 ++++++++++
 include/dt-bindings/clock/qcom,qcs615-camcc.h      | 110 +++++++++++++++++++++
 2 files changed, 161 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,qcs615-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,qcs615-camcc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..87f3ba09ef316de97790f952d97971172cb35aa1
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,qcs615-camcc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,qcs615-camcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Camera Clock & Reset Controller on QCS615
+
+maintainers:
+  - Taniya Das <quic_tdas@quicinc.com>
+
+description: |
+  Qualcomm camera clock control module provides the clocks, resets and power
+  domains on QCS615
+
+  See also: include/dt-bindings/clock/qcom,qcs615-camcc.h
+
+properties:
+  compatible:
+    const: qcom,qcs615-camcc
+
+  clocks:
+    items:
+      - description: Board XO source
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@ad00000 {
+      compatible = "qcom,qcs615-camcc";
+      reg = <0xad00000 0x10000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>;
+
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,qcs615-camcc.h b/include/dt-bindings/clock/qcom,qcs615-camcc.h
new file mode 100644
index 0000000000000000000000000000000000000000..aec57dddc06735a5c6c48a1e93a8c498bdb8726a
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,qcs615-camcc.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_CAM_CC_QCS615_H
+#define _DT_BINDINGS_CLK_QCOM_CAM_CC_QCS615_H
+
+/* CAM_CC clocks */
+#define CAM_CC_BPS_AHB_CLK					0
+#define CAM_CC_BPS_AREG_CLK					1
+#define CAM_CC_BPS_AXI_CLK					2
+#define CAM_CC_BPS_CLK						3
+#define CAM_CC_BPS_CLK_SRC					4
+#define CAM_CC_CAMNOC_ATB_CLK					5
+#define CAM_CC_CAMNOC_AXI_CLK					6
+#define CAM_CC_CCI_CLK						7
+#define CAM_CC_CCI_CLK_SRC					8
+#define CAM_CC_CORE_AHB_CLK					9
+#define CAM_CC_CPAS_AHB_CLK					10
+#define CAM_CC_CPHY_RX_CLK_SRC					11
+#define CAM_CC_CSI0PHYTIMER_CLK					12
+#define CAM_CC_CSI0PHYTIMER_CLK_SRC				13
+#define CAM_CC_CSI1PHYTIMER_CLK					14
+#define CAM_CC_CSI1PHYTIMER_CLK_SRC				15
+#define CAM_CC_CSI2PHYTIMER_CLK					16
+#define CAM_CC_CSI2PHYTIMER_CLK_SRC				17
+#define CAM_CC_CSIPHY0_CLK					18
+#define CAM_CC_CSIPHY1_CLK					19
+#define CAM_CC_CSIPHY2_CLK					20
+#define CAM_CC_FAST_AHB_CLK_SRC					21
+#define CAM_CC_ICP_ATB_CLK					22
+#define CAM_CC_ICP_CLK						23
+#define CAM_CC_ICP_CLK_SRC					24
+#define CAM_CC_ICP_CTI_CLK					25
+#define CAM_CC_ICP_TS_CLK					26
+#define CAM_CC_IFE_0_AXI_CLK					27
+#define CAM_CC_IFE_0_CLK					28
+#define CAM_CC_IFE_0_CLK_SRC					29
+#define CAM_CC_IFE_0_CPHY_RX_CLK				30
+#define CAM_CC_IFE_0_CSID_CLK					31
+#define CAM_CC_IFE_0_CSID_CLK_SRC				32
+#define CAM_CC_IFE_0_DSP_CLK					33
+#define CAM_CC_IFE_1_AXI_CLK					34
+#define CAM_CC_IFE_1_CLK					35
+#define CAM_CC_IFE_1_CLK_SRC					36
+#define CAM_CC_IFE_1_CPHY_RX_CLK				37
+#define CAM_CC_IFE_1_CSID_CLK					38
+#define CAM_CC_IFE_1_CSID_CLK_SRC				39
+#define CAM_CC_IFE_1_DSP_CLK					40
+#define CAM_CC_IFE_LITE_CLK					41
+#define CAM_CC_IFE_LITE_CLK_SRC					42
+#define CAM_CC_IFE_LITE_CPHY_RX_CLK				43
+#define CAM_CC_IFE_LITE_CSID_CLK				44
+#define CAM_CC_IFE_LITE_CSID_CLK_SRC				45
+#define CAM_CC_IPE_0_AHB_CLK					46
+#define CAM_CC_IPE_0_AREG_CLK					47
+#define CAM_CC_IPE_0_AXI_CLK					48
+#define CAM_CC_IPE_0_CLK					49
+#define CAM_CC_IPE_0_CLK_SRC					50
+#define CAM_CC_JPEG_CLK						51
+#define CAM_CC_JPEG_CLK_SRC					52
+#define CAM_CC_LRME_CLK						53
+#define CAM_CC_LRME_CLK_SRC					54
+#define CAM_CC_MCLK0_CLK					55
+#define CAM_CC_MCLK0_CLK_SRC					56
+#define CAM_CC_MCLK1_CLK					57
+#define CAM_CC_MCLK1_CLK_SRC					58
+#define CAM_CC_MCLK2_CLK					59
+#define CAM_CC_MCLK2_CLK_SRC					60
+#define CAM_CC_MCLK3_CLK					61
+#define CAM_CC_MCLK3_CLK_SRC					62
+#define CAM_CC_PLL0						63
+#define CAM_CC_PLL1						64
+#define CAM_CC_PLL2						65
+#define CAM_CC_PLL2_OUT_AUX2					66
+#define CAM_CC_PLL3						67
+#define CAM_CC_SLOW_AHB_CLK_SRC					68
+#define CAM_CC_SOC_AHB_CLK					69
+#define CAM_CC_SYS_TMR_CLK					70
+
+/* CAM_CC power domains */
+#define BPS_GDSC						0
+#define IFE_0_GDSC						1
+#define IFE_1_GDSC						2
+#define IPE_0_GDSC						3
+#define TITAN_TOP_GDSC						4
+
+/* CAM_CC resets */
+#define CAM_CC_BPS_BCR						0
+#define CAM_CC_CAMNOC_BCR					1
+#define CAM_CC_CCI_BCR						2
+#define CAM_CC_CPAS_BCR						3
+#define CAM_CC_CSI0PHY_BCR					4
+#define CAM_CC_CSI1PHY_BCR					5
+#define CAM_CC_CSI2PHY_BCR					6
+#define CAM_CC_ICP_BCR						7
+#define CAM_CC_IFE_0_BCR					8
+#define CAM_CC_IFE_1_BCR					9
+#define CAM_CC_IFE_LITE_BCR					10
+#define CAM_CC_IPE_0_BCR					11
+#define CAM_CC_JPEG_BCR						12
+#define CAM_CC_LRME_BCR						13
+#define CAM_CC_MCLK0_BCR					14
+#define CAM_CC_MCLK1_BCR					15
+#define CAM_CC_MCLK2_BCR					16
+#define CAM_CC_MCLK3_BCR					17
+#define CAM_CC_TITAN_TOP_BCR					18
+
+#endif

-- 
2.48.1


