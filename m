Return-Path: <linux-kernel+bounces-766186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6EDB24379
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94A216FC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2452EA743;
	Wed, 13 Aug 2025 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VSWPPfEs"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797822E611A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755071768; cv=none; b=jCmlVnf4MVERStPjdJ+n464R27wAxvpqxL45bYwr02apMv0OgkUrlRnvNF6f1KrENkvPQrFT59xhxqB8cgWB3xTJeqlQgUhINeaPMkPjlFmhp9Uo2iO5tPSAiXDbXYnzDZCisU9lMCrH9mOO9/XQSgQ5C9doTniFPORjRUpaRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755071768; c=relaxed/simple;
	bh=sHf7vbULTz2C/ybAwmFsk/gb/8n1wIkojTIqqM9GJ2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z0lpTYYYKwJ7XiYh6WJF1bhIFvxZUzURIi+jU/JyvPtcm3HR6XgAzfoAu9KsttNAqoBgu/vN81+wHFCFtDTBXOdxx7CxhTuRjnT6FT0vGJ/YLkcwxNO9EraGcKdCEVlQ1Xw0pdXFIW+eBw74r/9vrCuCCSfUORK4/nIzAPA0L18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VSWPPfEs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mH71001935
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fUsD0dVnhmqkRsajdXDAuWEgzh80GlwERn+EBG0yzc4=; b=VSWPPfEsZhieDTOx
	To8YnaE13MmNjVCN3ulAKV6jKfDBHs+tvKwn6z0RsLGwjr1olOGwihF67pjLMlAm
	pYT2UqTEAXReCQK6KNHclJ00TROfOGtH17Z21I69vj8TP0omGeGh8Gu6mHX0fdWY
	JkOJWE4MaZptPVlN+S75I43XrJYMrbega7JfX0tlIu54m7sJUM7YHdro3viXiYfi
	i7AMUPOgwkrRBPL2g9DL4HwPnB5osjvKzQUhzxw+vqGUXUlOCb/h09H8eABdQz9h
	QNDjsfxoT9bPhiZA6ORqzbxh/AtvC+abKphmpCA1zsyR3z7fr9T33uEucsRBkjCA
	i3d/dQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjpsu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 07:56:05 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76c47324232so4400793b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755071764; x=1755676564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUsD0dVnhmqkRsajdXDAuWEgzh80GlwERn+EBG0yzc4=;
        b=n/hCQdZa1GWBQ2k/jszHdOL+cgrzav8IeryJR8NJBkMMVf1WWqQ9XrBbUrYAFxpPbQ
         ZSXSnxkRzFsFMHF6shOEbZFIhwHhSYxbwA66Nf+IHfLndnOPW4vyJY812Ai5zOFSaRTC
         w5Ru5fA2FGxjAyytzo8hHjO2NkrMQB5KqumvIbB83eLn4RyFE0/Cs/FY7uhZ0tpRHJNc
         Fo9Dn7i2bDRwzaNGMBtlicz2gYwpmchYIwOn7Qq2f9JAbaCQWG35bOVImPxE2HcmNQ/O
         Bsk1sz6szLjVCXxmySvBWl1qkiwQ8CvpyhJ9/1dca9xX0mggnn7v79/8B8PLTzH+o/zY
         BGvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvM7YzuBiKTkSsgY8b/dd8ySZccxGRHgJGBWdrvR9dIXuB3/Hgup2oDycQV9aGj5Nrz7shqQcoDIJZEAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKr8x1fvZ51PkqI1PnlBDWQgh5wXXMUzpAk+j0X/agjgju6rLr
	g2Gp5kK7evzaGz8XLEdT/Wzfz7Qi8t/HitL4uYldNCLCCTtCi+avJ0CoVlu6IhTL1zfT+XaWKuH
	JaETNwRuAXWNY9TO6bD5qbuBi3roL56N8KbmSRKoOwTTwYc0SlDieT3CW0PTg2zTmdUM=
X-Gm-Gg: ASbGncs+2zDBWSNCr8agagHKHxneekpOxVWOnA+n9KQPXUQoKdyObMk98wpXbPppcyS
	8LE93gyeReKjYyFAwgZaD5DMtgNa88e9qUsStBTM00YmyxECoRwF/fYdx1De2E2R/7mliMIc8RK
	teDyf6+0/XSrpNVbwF8gj7JFy4/Mv0Qes2CaBINDuZbvPTjSjFzOjG9bP+nYAkY7ZBLPwfgWGK1
	nUK6nKw6rPqjh2xBYXQdD3kXaM1FzzTuwWfSq8NtWX/JafFUBUstpOaIoQHI2AHDZeX9G3zSYgy
	zPsag3DaqymuCVkq1k/5vFqSOdTBg/pJq3sfQLn40PXe78me6Znib4gw3DYsy031
X-Received: by 2002:a05:6a00:2396:b0:76b:f1c0:224b with SMTP id d2e1a72fcca58-76e20fd02b7mr3433297b3a.23.1755071763970;
        Wed, 13 Aug 2025 00:56:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERFxv9gFWTq8pe8BgE9fFX8Kld5lCGhSgqJZoo2m38yCdBawTCYOPwqUMppj5BB8hBCFL8Dw==
X-Received: by 2002:a05:6a00:2396:b0:76b:f1c0:224b with SMTP id d2e1a72fcca58-76e20fd02b7mr3433259b3a.23.1755071763502;
        Wed, 13 Aug 2025 00:56:03 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd22csm31395754b3a.65.2025.08.13.00.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 00:56:03 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 13:25:18 +0530
Subject: [PATCH v4 2/7] dt-bindings: clock: qcom: Document the Glymur SoC
 TCSR Clock Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-glymur-clock-controller-v4-v4-2-a408b390b22c@oss.qualcomm.com>
References: <20250813-glymur-clock-controller-v4-v4-0-a408b390b22c@oss.qualcomm.com>
In-Reply-To: <20250813-glymur-clock-controller-v4-v4-0-a408b390b22c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX3aWHYNkP4fgf
 UNshZ+noGgvX6nRyHOfx9HcUsvaCpQLz4l5D+kVQi0IX2qeN5ab6lDnBytLPVvx+ppfg71tNzij
 uWCNHukGDE9qot5yiP5UBvAENqMaB6JtHf7/aWbOecqhg0SxeHzXleasrQ2Kjl91/rJQi+paAFE
 8gMdLoExmR7cvgaNKz0xPf0m4MLzpU8FWd1/nDoFCi4PMv14g/WnWt6i+hzxfiMYKCPJk3wY5+6
 Rhxn/LcueU2SaZBmbX6IZKHqWk9XiBTFY3nIkuDbfpMuf9nWTgGN1FeGGmGy69sLLzj2rqsYkrx
 KJo+aO3w24xcY96tpQUuf0nfVERzdmDDFBQoSI7OamoYR4+RremvgIaL+wBFhYsJ3Jm1fkueWHQ
 IWY7jYuS
X-Proofpoint-GUID: 22D3EIlLzcpp9nQOnmL7oJvy8wqzyXO4
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689c4515 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=NoBSHRPQAjGLFGKXj-wA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 22D3EIlLzcpp9nQOnmL7oJvy8wqzyXO4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

The Glymur SoC TCSR block provides CLKREF clocks for EDP, PCIe, and USB. Add
this to the TCSR clock controller binding together with identifiers for
the clocks.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |  3 +++
 include/dt-bindings/clock/qcom,glymur-tcsr.h       | 24 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
index 2ed7d59722fc7e1e8ccc3adbef16e26fc44bf156..2c992b3437f29b38d9c73e3c600f2c55e0b8ae98 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
@@ -8,12 +8,14 @@ title: Qualcomm TCSR Clock Controller on SM8550
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
+  - Taniya Das <taniya.das@oss.qualcomm.com>
 
 description: |
   Qualcomm TCSR clock control module provides the clocks, resets and
   power domains on SM8550
 
   See also:
+  - include/dt-bindings/clock/qcom,glymur-tcsr.h
   - include/dt-bindings/clock/qcom,sm8550-tcsr.h
   - include/dt-bindings/clock/qcom,sm8650-tcsr.h
   - include/dt-bindings/clock/qcom,sm8750-tcsr.h
@@ -22,6 +24,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,glymur-tcsr
           - qcom,milos-tcsr
           - qcom,sar2130p-tcsr
           - qcom,sm8550-tcsr
diff --git a/include/dt-bindings/clock/qcom,glymur-tcsr.h b/include/dt-bindings/clock/qcom,glymur-tcsr.h
new file mode 100644
index 0000000000000000000000000000000000000000..72614226b113bb60f1e430fc18e13c46c8b043d3
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,glymur-tcsr.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_TCSR_CC_GLYMUR_H
+#define _DT_BINDINGS_CLK_QCOM_TCSR_CC_GLYMUR_H
+
+/* TCSR_CC clocks */
+#define TCSR_EDP_CLKREF_EN					0
+#define TCSR_PCIE_1_CLKREF_EN					1
+#define TCSR_PCIE_2_CLKREF_EN					2
+#define TCSR_PCIE_3_CLKREF_EN					3
+#define TCSR_PCIE_4_CLKREF_EN					4
+#define TCSR_USB2_1_CLKREF_EN					5
+#define TCSR_USB2_2_CLKREF_EN					6
+#define TCSR_USB2_3_CLKREF_EN					7
+#define TCSR_USB2_4_CLKREF_EN					8
+#define TCSR_USB3_0_CLKREF_EN					9
+#define TCSR_USB3_1_CLKREF_EN					10
+#define TCSR_USB4_1_CLKREF_EN					11
+#define TCSR_USB4_2_CLKREF_EN					12
+
+#endif

-- 
2.34.1


