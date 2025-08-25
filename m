Return-Path: <linux-kernel+bounces-785403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E667B34A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68AB482681
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799933126C1;
	Mon, 25 Aug 2025 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aY3xfU2b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4D930F529
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145980; cv=none; b=ObfSLRxDby/+xp8xjgnA/3t426TdzV8Dzlu4cmzXdcpEhVCo6ZLYDDEBVgratwJU6qKj2LQ3JnJKYI/OSp6Z/SUjT+wYAoVV9VUQWO3dThxmzXBa6P5AxljOGd8zmo78swV+qZeztmAoDfdNrbxCFgo3Kvm7wmYJzVG0fZrBnKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145980; c=relaxed/simple;
	bh=GtbwmtuoA/RBe5b8zxBPGEtjM/G6nG/3ONfOTQxsQ8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mWeOO2gtVdQg6644m4LKh2Kcq4KlAHegbC3csT27dpjTT3kybsEkvEujBCi9yS6GfzUfv7TDoMuQldBdmTxwBqsgsWAHXt0xDkTlyN7mbM7b+d8VtD6aqRxscz+OIwJ82c2sPybc1jZ1uwFrsE/FHZ9XOrr/UWPxGasFeAVT7r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aY3xfU2b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PHoTmB023313
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j8XNNR5zTZOnEFE8Ns2yHRkIaTcCY0LcCd9f6zu7FJM=; b=aY3xfU2bNCIpXG3u
	xsC/f8Dg0t506GCODq6BbPtQKCsYky3eXjgkGpPkl9CzdzafEqu9o27Gfer0hvYM
	VO5e/f41/5HEX9oXbBP9tih7GRdn4eei9lnKaGy0Unb8udp6UkLUFT9Xa/FVCOzy
	ymjUSxoPkhTcbKQbRY7J6ZIndLYhI6Ri+nMWRV8ZTaEYpOyCXLBGwdQUX2cuD0Rq
	oyh9h7npuxaClhnRnF0cyHjoafm4S9Rt45bkS1TK3JKwDMrn+j11nyRoaYkIDc/E
	RZP8Db5u1WV0GiCv1LhlvI8fg+Y2KSDqltfhy1wNZp1fEVJf98ZFogkMdQo7SI0s
	bXrM7A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5dyxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:19:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24456ebed7bso54304575ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 11:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756145976; x=1756750776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8XNNR5zTZOnEFE8Ns2yHRkIaTcCY0LcCd9f6zu7FJM=;
        b=WERT8JjynPOl2rX0uzaGp5iI5uOE8TX3qorIEjuJGNc2VC//d4UJTJSFs7kQBPKKrb
         uCkGsRnaRJb0n7gG/iSTMnuQ4c/ffvDJB6CXLxDmKlk8kpejSWmjcnj7AkQDdkgQp+Ui
         g8uVizgb2pqC+3Q0Hxc9mHOIHQsjgJ4vQNo2KSa3mIpL+0e5MDbH0ufzVp++VTSspISw
         mk4jl2MlP2L1KQBshArIGZF5tYJ6A7DfL/9VOf7TE/G+utpmVWTS1TQCBj6c9UktqEpa
         C/KpiwHbpMeKtEW8Yn6TNXI6PGDu8P5lQ3zM+3D2A7aA7VbodN937J7aNVortHqYimnh
         KTQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWde/r7KvNegotJGbPgLVTguXlzuV2CtqXqeL9cA8wylqgrVgf8ITPtVZD9m3x99dLeErBHzvLNC+XnPpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH7oDLKnqnu6PHFTEcI/Mz7h+LTTxLxCBLreyeFhR3HDspsLq5
	FP5QkW5UCqQJAmCcujm+1gyx4tyj70Gav9FnVFuCv4BJmtDTqsTPLzD8r7Wfoe4nHin1BYyiyLD
	yC/TGcTeAY5+l+y8DBFFnFVHxmbpJbwk2P0q6FPND5sqhFop5L+cegvqztLEqfS5Qn70=
X-Gm-Gg: ASbGnct7/Ym8QB22sU1G63GMTpUJEGCkzipU7kuYhRKmuFO2fyGw7zvK/1iNtWSFSl9
	/LzwhOpUv2+j29tMaDwudyhGXfPIi4yS8+Q1reBwtPnHZmFqMH9FxJriPO8VTnp+HTu+kRH2EE5
	rehgNETSztq644iXNF/EA1srDMUT35T4/RwcnKLlQIwFoUzX/5gy78hLpAjW0gKTAyMgex479hr
	MmCBxQ03AnscmvwylDG0ZNZZJ0bg0F/Gbl8poDIn/1oYYIIcuj3IfpOjtTpKv+Pikxvid5zWqsW
	m6+JsqdT0eKkzMFSfMCqisDktKa9viz/fHDup5dV79dfnVE6Ctsziqgo6434gDmN
X-Received: by 2002:a17:902:f690:b0:240:6fc0:3421 with SMTP id d9443c01a7336-2483deef02bmr5266345ad.3.1756145976245;
        Mon, 25 Aug 2025 11:19:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxgqJNt5H3Am11ZyaQvv80Pcq57RRvU2s0dMUVrSGwe/SucEQAzGZOcYHr2zqbV/FlMVTGRw==
X-Received: by 2002:a17:902:f690:b0:240:6fc0:3421 with SMTP id d9443c01a7336-2483deef02bmr5266015ad.3.1756145975781;
        Mon, 25 Aug 2025 11:19:35 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688647acsm74174015ad.87.2025.08.25.11.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:19:35 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 23:49:09 +0530
Subject: [PATCH v5 2/7] dt-bindings: clock: qcom: Document the Glymur SoC
 TCSR Clock Controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-glymur-clock-controller-v5-v5-2-01b8c8681bcd@oss.qualcomm.com>
References: <20250825-glymur-clock-controller-v5-v5-0-01b8c8681bcd@oss.qualcomm.com>
In-Reply-To: <20250825-glymur-clock-controller-v5-v5-0-01b8c8681bcd@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX3cr7jxcBtmq6
 I2nbkdtPnuxCytyszZ5sxN0CKBARR1d6P8ttd3/hb3sXcaoJFvs3RIzHY0yag0MgG3CHM5lX1Zs
 OFgBnbQc5H1GnIctabV/I0BevnWzoOizv25wXwRA1YLqIB7jyyVjaG2k9lSsKNrEEoJgtYTSTQu
 PwUdpKKKhdIbBuCnLh/Ul4xZ4qiKa91oj1brvC1kHoHeiKMSeW5rQGCd3HrzHnoQ3MC2eAZZ6Kr
 zL2NfGi8Qd2f9CDWm9jdIVYGzJAe5IaIY9GoD4jLroyVebPvHpUbe7vh9VNW/IwLNNW07f7M0QO
 /sgx5OQsHxVmjl5cTszL1naehil8TcTNdhcoRqIcD6on/fRQa0/r5wrmcTkEGYpcoiRO1IbPudj
 PPBtHiQ3
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68aca939 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=UTa3es7JcjS1KsmnmHQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Gng1jHvpsl6e0Ju5mVggfx-BTI-MyY1a
X-Proofpoint-ORIG-GUID: Gng1jHvpsl6e0Ju5mVggfx-BTI-MyY1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

The Glymur SoC TCSR block provides CLKREF clocks for EDP, PCIe and USB.
Add this to the TCSR clock controller binding together with identifiers
for the clocks.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
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


