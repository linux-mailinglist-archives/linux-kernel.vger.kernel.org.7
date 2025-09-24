Return-Path: <linux-kernel+bounces-831463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C66B9CBC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E287B15D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC4F2D0C98;
	Wed, 24 Sep 2025 23:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P9gCCREW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D42C0F8E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758223; cv=none; b=D4VegqgqpqJvNA67EEJtRir8cC18r+sKFHN2TdmMnWptZmZH3dWqwV3mc0rXo+vWA8E6FTUbuBPyxEQMpdOt/P2wLtnxlbF0m0pGRuGD0NE12xCczNQTp4UIzvo0CkI5iNFPEc85Mjn4fDy02shharx+Iwjl9StdWgRuKCjZ7Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758223; c=relaxed/simple;
	bh=h5qg+lr9073qLv3FyOMbDZdM1ZWDyd1Z3NdxUcm+AV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rIDZ6E1CEbMAtZKDYNqrKXzlZlsLkzFn7YxXpQRzSt83+0BXyxAB1LECD+cmhl2WB+2F7DjzI+gHgufbTsA3PO9QvYnZvUQcl+UNJfFjR8Ec4VlwDSRF97Rlcb2Qmx6uvaFb2vRLhQ4jL1G5o69r70LdosZWGX5BKxx+9Di/Zyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P9gCCREW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCbHsg023766
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:57:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v+yaI6FR7vnjbNWezGxMpDdF/FgNA9YLXfOVLnAIGDw=; b=P9gCCREWzxKeVd2V
	crGtYZJhqWdeA6L9ylVakwG7eJbJL+3fEPZ+HRBE2DAiMSD664VSrGwD56/hLDTx
	G19ES1RuknZbcSIY1VI3I5p8a9kJpAaukA2nK03pKZSDxvn0HQ2g746lLdytgjtF
	b7g6+Ft7Dx0NpIVdovNPEcaNvmQSKxdHXS2EDuU2fi/6+sV+/mBU16qoGfm9DVCA
	eOFXCo/Uh9TB8P3xyz8SknPPKGLqeHb+avwZrZI54T5TlRqZiOGlviCQnn6rGhUX
	kvAj68jGGAUxAwP+MM8gHMwAzsZqIB9BYe/WgjkWzNlnWHIhr1SEz5aDcbqZpt0X
	ZuXz3g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0d4ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:57:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-26985173d8eso5334305ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758219; x=1759363019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+yaI6FR7vnjbNWezGxMpDdF/FgNA9YLXfOVLnAIGDw=;
        b=vC80If5959NZyriR4BDRjmd2nEv/OJlH4vS/1PsomYIP57FMURdwOfQPbwu1xzOg25
         mTzKBC+ASjo+WMNUsLkbD7WIsrFzZ0iLmssueJy7g49UQRxoZmcmpoESM0tvhgsGjeb1
         RnHGh0kfFm9Ox/96RScM9gfQm88/weRbkQ1eF8Ioq7YaR0c46ZXdqpESkDFnkET8i+e/
         KUiCE7M0npu/Ka3lFxclyLudf3CwAZsuNYgvdk5lnyykxAXXWm2VarERCFrdpkQZMK+X
         +x0Ciq9NdBv4UFN5k+13+wVRYJIfXWPj60YlMaUNo+eNHJ5Gn/2aewQ4Xv2mrRhSqXhE
         EIOw==
X-Forwarded-Encrypted: i=1; AJvYcCWgoyoNVjYvjjpTg9pDhu3C2B7z3UQt0KT6UqufzVuIVUWbOh6Jr7gZG0WykNe4I2ewiW1QOeTd7voFrlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8sjHpvRY9twZzki6MKucimsxr8WmfgVPUL/1iTtJlk2EnZc8
	e4RlfkL3MRIYBrruVBeI1KtUALLvi1v82n4g1EPF84VzlX8vzCCltsZcQ0MZvJEaWFh3+XkWkH7
	0cmSykCVtIMJIK/DZ/VQWiOOdLeonNMXGx83P2NI6gYXBWFLAoJSbevRVKrZ3KuLP9+I=
X-Gm-Gg: ASbGnctii8+QdI1GVlS2wnHeFEvoW1MBuuguIPmc0eomJlt6hDkLfIlWuv+pIjBghBL
	NS7c0BClheN29dfVIN8vY4mxyPUGPGK5tga6IYoxg7x7yU27d8XudZP0KaXJUNBdURV/1dE0igI
	Ezew66dGzB0xu95G00Xl0qFxV/BDzIqoayUGtBvOYVpi44cSXLPWurVTRiGzW0/jG5EEk7CkGUc
	1EiOzqdBH/MUgYi4kkHV6Z/FWfEM0gIEqhw9X9Z7afpCMUGeJhoZGWcUbjJpodcRdFUqkiBuNL3
	5zcMED4YWCf8VI4LEBUfTOQdgCjraldCltV7aYsbewHoSw9mchYMf/wT4xPW3uLF4LT50dw5aqr
	WlbX9t6rzO6aNO6s=
X-Received: by 2002:a17:902:d481:b0:25f:45d9:6592 with SMTP id d9443c01a7336-27ed4a56577mr14637675ad.48.1758758218841;
        Wed, 24 Sep 2025 16:56:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmqsLYBMpnPQAXHSlY2+YfF0P2SMFyW780ocQzNqXewKAoKC5mEI+DPfnaiEJF9eh1FUiWqA==
X-Received: by 2002:a17:902:d481:b0:25f:45d9:6592 with SMTP id d9443c01a7336-27ed4a56577mr14637355ad.48.1758758218398;
        Wed, 24 Sep 2025 16:56:58 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6881fd6sm4557185ad.87.2025.09.24.16.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:56:58 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:56:44 -0700
Subject: [PATCH 3/9] dt-bindings: clock: qcom: Add support for CAMCC for
 Kaanapali
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-mmclk-v1-3-d7ea96b4784a@oss.qualcomm.com>
References: <20250924-knp-mmclk-v1-0-d7ea96b4784a@oss.qualcomm.com>
In-Reply-To: <20250924-knp-mmclk-v1-0-d7ea96b4784a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758758212; l=9069;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=DhUpj40NQ2LD2wFIZmlHkYV7/QHoZ2IqSLLBAdqKXoM=;
 b=tWPzYVXOG0QKzonrF6pOxz4QjM7UrQmDHHJMdIXOfGB8Z1RjYMcZoE1W4RIbwXjVK65Vd6Z+f
 X+aOcb8rxepAaQ1K1lSgP6+Mv94lI9glazWQR8G6OynJmoM6Ty8bAHa
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d4854c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=M9E809UxJf-Bpjq6rgYA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: wLDNqeSlSHH9g14cd05OzoOSc102Bn1v
X-Proofpoint-ORIG-GUID: wLDNqeSlSHH9g14cd05OzoOSc102Bn1v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX4UdKUO2LKrMz
 p+xAW6ZBMwCPoEuudE1UnJtpC2v/u0hTKHPf1zqc54/zu43rL5kAjMDxkWv3z9u09rg0UO8D5e+
 N9yyUNyuWajA3cS6OlWdqSXEXd0scHnwGI8Gy/8Is8qNc5dUy/TgfyoWJDJINrznoOgCAklu8Oc
 Mjfb0H+FXkA5Hqt26eNxNNttJl1MIpLt3ICQ1a2NSdNo5FpZIXmA8X1kWqWT8xru9sUWZ/u8BLu
 Pmvbw9Y7V19QcO+3M+pW+yavYF1CNBorE89XVLI6/y00J8HSzOTfNjirGYx/ehQUybBnN0eG7VW
 4WkLR+fWPT+PauHy2BCBtbd5ahL+RlcMREL0quS8EwnGZSAjqaOoSZ+ulwUhJnyP4MCOPSmo/Iw
 ieI2NJE/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

From: Taniya Das <taniya.das@oss.qualcomm.com>

Update the compatible and the bindings for CAMCC support on Kaanapali
SoC.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 .../bindings/clock/qcom,sm8450-camcc.yaml          |   8 +-
 .../clock/qcom,kaanapali-cambistmclkcc.h           |  33 +++++
 include/dt-bindings/clock/qcom,kaanapali-camcc.h   | 147 +++++++++++++++++++++
 3 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
index dbfcc399f10b..54b04ecf67c1 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
@@ -12,9 +12,11 @@ maintainers:
 
 description: |
   Qualcomm camera clock control module provides the clocks, resets and power
-  domains on SM8450.
+  domains on SM8450 SoCs.
 
   See also:
+    include/dt-bindings/clock/qcom,kaanapali-camcc.h
+    include/dt-bindings/clock/qcom,kaanapali-cambistmclkcc.h
     include/dt-bindings/clock/qcom,sm8450-camcc.h
     include/dt-bindings/clock/qcom,sm8550-camcc.h
     include/dt-bindings/clock/qcom,sm8650-camcc.h
@@ -22,6 +24,8 @@ description: |
 properties:
   compatible:
     enum:
+      - qcom,kaanapali-cambistmclkcc
+      - qcom,kaanapali-camcc
       - qcom,sm8450-camcc
       - qcom,sm8475-camcc
       - qcom,sm8550-camcc
@@ -63,6 +67,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,kaanapali-cambistmclkcc
+              - qcom,kaanapali-camcc
               - qcom,sm8450-camcc
               - qcom,sm8550-camcc
     then:
diff --git a/include/dt-bindings/clock/qcom,kaanapali-cambistmclkcc.h b/include/dt-bindings/clock/qcom,kaanapali-cambistmclkcc.h
new file mode 100644
index 000000000000..ddb083b5289e
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,kaanapali-cambistmclkcc.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_CAM_BIST_MCLK_CC_KAANAPALI_H
+#define _DT_BINDINGS_CLK_QCOM_CAM_BIST_MCLK_CC_KAANAPALI_H
+
+/* CAM_BIST_MCLK_CC clocks */
+#define CAM_BIST_MCLK_CC_DEBUG_CLK				0
+#define CAM_BIST_MCLK_CC_DEBUG_DIV_CLK_SRC			1
+#define CAM_BIST_MCLK_CC_MCLK0_CLK				2
+#define CAM_BIST_MCLK_CC_MCLK0_CLK_SRC				3
+#define CAM_BIST_MCLK_CC_MCLK1_CLK				4
+#define CAM_BIST_MCLK_CC_MCLK1_CLK_SRC				5
+#define CAM_BIST_MCLK_CC_MCLK2_CLK				6
+#define CAM_BIST_MCLK_CC_MCLK2_CLK_SRC				7
+#define CAM_BIST_MCLK_CC_MCLK3_CLK				8
+#define CAM_BIST_MCLK_CC_MCLK3_CLK_SRC				9
+#define CAM_BIST_MCLK_CC_MCLK4_CLK				10
+#define CAM_BIST_MCLK_CC_MCLK4_CLK_SRC				11
+#define CAM_BIST_MCLK_CC_MCLK5_CLK				12
+#define CAM_BIST_MCLK_CC_MCLK5_CLK_SRC				13
+#define CAM_BIST_MCLK_CC_MCLK6_CLK				14
+#define CAM_BIST_MCLK_CC_MCLK6_CLK_SRC				15
+#define CAM_BIST_MCLK_CC_MCLK7_CLK				16
+#define CAM_BIST_MCLK_CC_MCLK7_CLK_SRC				17
+#define CAM_BIST_MCLK_CC_PLL0					18
+#define CAM_BIST_MCLK_CC_PLL_TEST_CLK				19
+#define CAM_BIST_MCLK_CC_PLL_TEST_DIV_CLK_SRC			20
+#define CAM_BIST_MCLK_CC_SLEEP_CLK				21
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,kaanapali-camcc.h b/include/dt-bindings/clock/qcom,kaanapali-camcc.h
new file mode 100644
index 000000000000..58835136b356
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,kaanapali-camcc.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_CAM_CC_KAANAPALI_H
+#define _DT_BINDINGS_CLK_QCOM_CAM_CC_KAANAPALI_H
+
+/* CAM_CC clocks */
+#define CAM_CC_CAM_TOP_AHB_CLK					0
+#define CAM_CC_CAM_TOP_FAST_AHB_CLK				1
+#define CAM_CC_CAMNOC_DCD_XO_CLK				2
+#define CAM_CC_CAMNOC_NRT_AXI_CLK				3
+#define CAM_CC_CAMNOC_NRT_CRE_CLK				4
+#define CAM_CC_CAMNOC_NRT_IPE_NPS_CLK				5
+#define CAM_CC_CAMNOC_NRT_OFE_MAIN_CLK				6
+#define CAM_CC_CAMNOC_RT_AXI_CLK				7
+#define CAM_CC_CAMNOC_RT_AXI_CLK_SRC				8
+#define CAM_CC_CAMNOC_RT_IFE_LITE_CLK				9
+#define CAM_CC_CAMNOC_RT_TFE_0_MAIN_CLK				10
+#define CAM_CC_CAMNOC_RT_TFE_1_MAIN_CLK				11
+#define CAM_CC_CAMNOC_RT_TFE_2_MAIN_CLK				12
+#define CAM_CC_CAMNOC_XO_CLK					13
+#define CAM_CC_CCI_0_CLK					14
+#define CAM_CC_CCI_0_CLK_SRC					15
+#define CAM_CC_CCI_1_CLK					16
+#define CAM_CC_CCI_1_CLK_SRC					17
+#define CAM_CC_CCI_2_CLK					18
+#define CAM_CC_CCI_2_CLK_SRC					19
+#define CAM_CC_CORE_AHB_CLK					20
+#define CAM_CC_CPHY_RX_CLK_SRC					21
+#define CAM_CC_CRE_AHB_CLK					22
+#define CAM_CC_CRE_CLK						23
+#define CAM_CC_CRE_CLK_SRC					24
+#define CAM_CC_CSI0PHYTIMER_CLK					25
+#define CAM_CC_CSI0PHYTIMER_CLK_SRC				26
+#define CAM_CC_CSI1PHYTIMER_CLK					27
+#define CAM_CC_CSI1PHYTIMER_CLK_SRC				28
+#define CAM_CC_CSI2PHYTIMER_CLK					29
+#define CAM_CC_CSI2PHYTIMER_CLK_SRC				30
+#define CAM_CC_CSI3PHYTIMER_CLK					31
+#define CAM_CC_CSI3PHYTIMER_CLK_SRC				32
+#define CAM_CC_CSI4PHYTIMER_CLK					33
+#define CAM_CC_CSI4PHYTIMER_CLK_SRC				34
+#define CAM_CC_CSI5PHYTIMER_CLK					35
+#define CAM_CC_CSI5PHYTIMER_CLK_SRC				36
+#define CAM_CC_CSID_CLK						37
+#define CAM_CC_CSID_CLK_SRC					38
+#define CAM_CC_CSID_CSIPHY_RX_CLK				39
+#define CAM_CC_CSIPHY0_CLK					40
+#define CAM_CC_CSIPHY1_CLK					41
+#define CAM_CC_CSIPHY2_CLK					42
+#define CAM_CC_CSIPHY3_CLK					43
+#define CAM_CC_CSIPHY4_CLK					44
+#define CAM_CC_CSIPHY5_CLK					45
+#define CAM_CC_DRV_AHB_CLK					46
+#define CAM_CC_DRV_XO_CLK					47
+#define CAM_CC_FAST_AHB_CLK_SRC					48
+#define CAM_CC_GDSC_CLK						49
+#define CAM_CC_ICP_0_AHB_CLK					50
+#define CAM_CC_ICP_0_CLK					51
+#define CAM_CC_ICP_0_CLK_SRC					52
+#define CAM_CC_ICP_1_AHB_CLK					53
+#define CAM_CC_ICP_1_CLK					54
+#define CAM_CC_ICP_1_CLK_SRC					55
+#define CAM_CC_IFE_LITE_AHB_CLK					56
+#define CAM_CC_IFE_LITE_CLK					57
+#define CAM_CC_IFE_LITE_CLK_SRC					58
+#define CAM_CC_IFE_LITE_CPHY_RX_CLK				59
+#define CAM_CC_IFE_LITE_CSID_CLK				60
+#define CAM_CC_IFE_LITE_CSID_CLK_SRC				61
+#define CAM_CC_IPE_NPS_AHB_CLK					62
+#define CAM_CC_IPE_NPS_CLK					63
+#define CAM_CC_IPE_NPS_CLK_SRC					64
+#define CAM_CC_IPE_NPS_FAST_AHB_CLK				65
+#define CAM_CC_IPE_PPS_CLK					66
+#define CAM_CC_IPE_PPS_FAST_AHB_CLK				67
+#define CAM_CC_JPEG_CLK						68
+#define CAM_CC_JPEG_CLK_SRC					69
+#define CAM_CC_OFE_AHB_CLK					70
+#define CAM_CC_OFE_ANCHOR_CLK					71
+#define CAM_CC_OFE_ANCHOR_FAST_AHB_CLK				72
+#define CAM_CC_OFE_CLK_SRC					73
+#define CAM_CC_OFE_HDR_CLK					74
+#define CAM_CC_OFE_HDR_FAST_AHB_CLK				75
+#define CAM_CC_OFE_MAIN_CLK					76
+#define CAM_CC_OFE_MAIN_FAST_AHB_CLK				77
+#define CAM_CC_PLL0						78
+#define CAM_CC_PLL0_OUT_EVEN					79
+#define CAM_CC_PLL0_OUT_ODD					80
+#define CAM_CC_PLL1						81
+#define CAM_CC_PLL1_OUT_EVEN					82
+#define CAM_CC_PLL2						83
+#define CAM_CC_PLL2_OUT_EVEN					84
+#define CAM_CC_PLL3						85
+#define CAM_CC_PLL3_OUT_EVEN					86
+#define CAM_CC_PLL4						87
+#define CAM_CC_PLL4_OUT_EVEN					88
+#define CAM_CC_PLL5						89
+#define CAM_CC_PLL5_OUT_EVEN					90
+#define CAM_CC_PLL6						91
+#define CAM_CC_PLL6_OUT_EVEN					92
+#define CAM_CC_PLL6_OUT_ODD					93
+#define CAM_CC_PLL7						94
+#define CAM_CC_PLL7_OUT_EVEN					95
+#define CAM_CC_QDSS_DEBUG_CLK					96
+#define CAM_CC_QDSS_DEBUG_CLK_SRC				97
+#define CAM_CC_QDSS_DEBUG_XO_CLK				98
+#define CAM_CC_SLEEP_CLK					99
+#define CAM_CC_SLOW_AHB_CLK_SRC					100
+#define CAM_CC_TFE_0_BAYER_CLK					101
+#define CAM_CC_TFE_0_BAYER_FAST_AHB_CLK				102
+#define CAM_CC_TFE_0_CLK_SRC					103
+#define CAM_CC_TFE_0_MAIN_CLK					104
+#define CAM_CC_TFE_0_MAIN_FAST_AHB_CLK				105
+#define CAM_CC_TFE_1_BAYER_CLK					106
+#define CAM_CC_TFE_1_BAYER_FAST_AHB_CLK				107
+#define CAM_CC_TFE_1_CLK_SRC					108
+#define CAM_CC_TFE_1_MAIN_CLK					109
+#define CAM_CC_TFE_1_MAIN_FAST_AHB_CLK				110
+#define CAM_CC_TFE_2_BAYER_CLK					111
+#define CAM_CC_TFE_2_BAYER_FAST_AHB_CLK				112
+#define CAM_CC_TFE_2_CLK_SRC					113
+#define CAM_CC_TFE_2_MAIN_CLK					114
+#define CAM_CC_TFE_2_MAIN_FAST_AHB_CLK				115
+#define CAM_CC_TRACENOC_TPDM_1_CMB_CLK				116
+#define CAM_CC_XO_CLK_SRC					117
+
+/* CAM_CC power domains */
+#define CAM_CC_IPE_0_GDSC					0
+#define CAM_CC_OFE_GDSC						1
+#define CAM_CC_TFE_0_GDSC					2
+#define CAM_CC_TFE_1_GDSC					3
+#define CAM_CC_TFE_2_GDSC					4
+#define CAM_CC_TITAN_TOP_GDSC					5
+
+/* CAM_CC resets */
+#define CAM_CC_DRV_BCR						0
+#define CAM_CC_ICP_BCR						1
+#define CAM_CC_IPE_0_BCR					2
+#define CAM_CC_OFE_BCR						3
+#define CAM_CC_QDSS_DEBUG_BCR					4
+#define CAM_CC_TFE_0_BCR					5
+#define CAM_CC_TFE_1_BCR					6
+#define CAM_CC_TFE_2_BCR					7
+
+#endif

-- 
2.25.1


