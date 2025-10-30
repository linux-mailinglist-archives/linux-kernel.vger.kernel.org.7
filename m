Return-Path: <linux-kernel+bounces-878082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D08BC1FBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FE054E9FE1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4468354714;
	Thu, 30 Oct 2025 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="So1p/57B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U6JyDlzI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884043559E1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822596; cv=none; b=lSirz6QayyXBEsRRbPWabpxzj32f0IaZnhByxCkALBLedZzw24QOG2C9IEZmhZAJzncki1NFOXC4I0Lr+hFwm6ByS/yiSsvh82T5Vk2E5Ch8r3oORKwDMH9kFcWZhaco/ofBwovPWVa4cIGMIDHTzKINPn0Ib4+H3mohcWJsxk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822596; c=relaxed/simple;
	bh=xMEWTUeTZqAmYWmKjJVUquhFbTxVjSpB/Zcdfx//mIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UGH+/nXnZfLLQn2qUuj46CSljgEZJDAKkJaX+ldXfaBBJ3abmFe1/eqqk9tTOWxeRE8Mxz2Qna/QED5IUFyXrSdFjA12d7S58aKLLLK8hj/S2A/Q5uN7MJ8buwpFlK/VyIKHQpbvXi/XtGAQkX0DyIqlezcx09BLhR48Ff8uzl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=So1p/57B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U6JyDlzI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U81Omp1578977
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MvO1eB/KY2ejmOB3YqVBRren7BoeHDRNfDV/HhPJ9Lk=; b=So1p/57BzEEn0lEA
	4SNf5t1fx8lncmQymxPxy54Dg1PNLfcbJvFOyp5Pe404OZFcv95AG7xA+Ry6PRPQ
	+RADbIoidMdiArlZdfr2w6aA7WXSATWOpG+2PKFr7HynQQdVSIjQO9FstBLK7Bx8
	gZ8W0XyxKp544bIcypuEyRDvdqUs+hprM2uwa+yvtKQq4ymEKrOqw4guImizUe19
	AwUPkJPW0nQNHzaB3bMpSQre7zJE7p5WFd4ClYdMtAT/pDH50kcPnyOdZsWY0H7o
	x6y5NRtM2+oiHR+A2Ej2ig04YNuvaV1qIW38gx7oewzjAr4kt4LXBFdbLVH4bUGS
	8RcOyw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tjej48v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:09:53 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b522037281bso607819a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761822593; x=1762427393; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MvO1eB/KY2ejmOB3YqVBRren7BoeHDRNfDV/HhPJ9Lk=;
        b=U6JyDlzIZbjJtzwSuha40cn9E3Ygu0K9OU4FHcliJI+GWOIvylMDYj2KEcca5AEOAJ
         UXuynpugB6PGcwqI2g3vPTjIs4C9TlQxn9k4569kpoz0L/BvJusZgI5XqjjuEG7QeD4i
         PyLl69iJE9bIDs8FH1pMk2ZJDxH+fivPtGwjVCYW/YArEsQXNOZ11nFRquJoWKr2xAhF
         VFXkJ1DT8T/7ltIUFeJxKSbvBpqcEpoUgJqK2R8jHJYl/iYlH4QLMw3Q1p25ig47G7op
         HSW0dAgCFiFxQDl3lE04VMwiXZpnVo03YN7OW2orI4D882aEbVfoJd+a+6As7Uvt6Ahy
         xvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822593; x=1762427393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvO1eB/KY2ejmOB3YqVBRren7BoeHDRNfDV/HhPJ9Lk=;
        b=qaQdzryEpBX7CtNQfjooWXmwJBMxw0RZPo0jbsFYjqPsZSTFGnKhar2Q0ZZDR0dwnJ
         Uu3y8JIXg3wvKaDBeXzxlXDuyNGyBmlvjNeRb8vHcJEatqBE0sVctcoXqFnbapxb20cq
         EmljS2sb2Jl/KuNepWo8AVHIVaUUAAKP17V8HMkpMwOrLUm86UctwUkGU0P2Y6KvWTZ9
         GGIAbbTIWH1ecIN6A8/lePXSdE7wxmflBrEKxuaUUwbVxSuigH/7u0wwo28p4UphMglL
         bzoatTbUX5DkXGaRcyJju+HIEbdRuBnAmraewnSSZorgZ8D4/0SZf9dan0kTbL71ISC+
         hgGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWonwAJ5R+AMl/iuQfkl7cnpsZDXMWg01hEJveLRSYJimmw+LrPOhSEkjlbKk9bBDMWwAcQVVFqgSvfSks=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK23p3Ljh8CJ9BmiI6Yi8yACmfuvZBQtgq27ysK2D5hp8pSSjK
	u9QVvaWOReGPrMKrBH9kNei8S0QTGcPLxmTlTBUZTOiXZokeMXPEP4UBfxPkCNm8u2vBDMVsPh2
	eux/5PK1FfEvRBG0iya89dmakWKRKgOo3vtpPm8Geyc60AO0J6nlkXfmwRXtdylj9PHk=
X-Gm-Gg: ASbGnctSflrMEgLBG02pq1KFeGtqlsPY6OUi3xV++npoNRlmlZQzm5ZCuQUPvDgy7TV
	dEMRfIJq+8yh8YasDL2Z9j+g2e0k3bHY96O2PCGto6XV3oIDz0xiooWTNjGGsuPQju4Sc3d/yZF
	CUjsoslt5tNDIRYCFhTPNmFCZMcF+iK2ws5dDLTV+Sk/0CJBoi09JCsecuztEpZ7KBm6KMmfveS
	yoE5Eh6XfAWTGToVphrfolucaXBfft7MF+rSrhUCqD1frEulxWpSqXCGhn8ZncEqU0NcneC/Tfe
	lkQBCAHr8sPKo3jGbhpt7bJWzXroelr8hKkwNXiFvmxOy7XK7wCqczB9sRgve1e4dvXe47ZpCU6
	JE7OzfdSUVhzJx7dz5mrACRM=
X-Received: by 2002:a05:6a21:339a:b0:340:cc06:94ee with SMTP id adf61e73a8af0-34654cf63a2mr8098673637.60.1761822593160;
        Thu, 30 Oct 2025 04:09:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7BUHSmpEu5Tn9G1WfUdWZEul78ioQ0ZzHEB4rOMUlzEpWtaUSfMiZ1oXBAudGhbyJN77lTg==
X-Received: by 2002:a05:6a21:339a:b0:340:cc06:94ee with SMTP id adf61e73a8af0-34654cf63a2mr8098615637.60.1761822592549;
        Thu, 30 Oct 2025 04:09:52 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340509727fesm2262839a91.4.2025.10.30.04.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:09:52 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 16:39:06 +0530
Subject: [PATCH v2 3/6] dt-bindings: clock: qcom: Add Kaanapali Global
 clock controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-gcc_kaanapali-v2-v2-3-a774a587af6f@oss.qualcomm.com>
References: <20251030-gcc_kaanapali-v2-v2-0-a774a587af6f@oss.qualcomm.com>
In-Reply-To: <20251030-gcc_kaanapali-v2-v2-0-a774a587af6f@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, jingyi.wang@oss.qualcomm.com
Cc: aiqun.yu@oss.qualcomm.com, Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: BHN3EotGnCzihFbRCdwI4g3IRo6Colpz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5MCBTYWx0ZWRfXyBGkamUi6Ydf
 e4ZGQbQDgCxbM7qlfsFoH0FIt/lPOwXutrALhKdwOGZpJxHV1IM/F768TWbYquMU8b86bqiLTO7
 pA5FXeQ8JSSKEusw1ro95pC+Iuq68x9ny1CTFOwnmCKHkPrgIu+AkjrN17BuA/2v4IwB6cmiuJc
 uDComHlkJQ6fzGm+W3x/DSAYdVNV2RUkzixaS8F7Db3JPfv6ExguQ9/EAGYhYvvOrq2lN4nSKp3
 ELE/YIBaCTPkeQNpeQELT7nPAHLWPUDXh+FphXJ+OcAp0SThAL9uiOQ0EmxJC3c99AC2rJmjWAQ
 wVSZ0zWw3GebuND5syODlYv3Wru9JhRwiC3RLfqFcjOA5kjOn3nelyLbbF1jFGIK54ONMXKLPVG
 o7Uw6KkOGlO9LasfVZePlJoWNM56zg==
X-Authority-Analysis: v=2.4 cv=a/Q9NESF c=1 sm=1 tr=0 ts=69034781 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=ienkSzUGxTtIZQoOJKMA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: BHN3EotGnCzihFbRCdwI4g3IRo6Colpz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300090

Add device tree bindings for the global clock controller on Qualcomm
Kaanapali platform.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 .../devicetree/bindings/clock/qcom,sm8750-gcc.yaml |   8 +-
 include/dt-bindings/clock/qcom,kaanapali-gcc.h     | 241 +++++++++++++++++++++
 2 files changed, 247 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml
index aab7039fd28db2f4e2a6b9b7a6340d17ad05156d..0114d347b26ff0e606ae415b1288a5ae055e2d5a 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml
@@ -13,11 +13,15 @@ description: |
   Qualcomm global clock control module provides the clocks, resets and power
   domains on SM8750
 
-  See also: include/dt-bindings/clock/qcom,sm8750-gcc.h
+  See also:
+    include/dt-bindings/clock/qcom,kaanapali-gcc.h
+    include/dt-bindings/clock/qcom,sm8750-gcc.h
 
 properties:
   compatible:
-    const: qcom,sm8750-gcc
+    enum:
+      - qcom,kaanapali-gcc
+      - qcom,sm8750-gcc
 
   clocks:
     items:
diff --git a/include/dt-bindings/clock/qcom,kaanapali-gcc.h b/include/dt-bindings/clock/qcom,kaanapali-gcc.h
new file mode 100644
index 0000000000000000000000000000000000000000..890e48709f09f7b5ff898ffc05264dc80385763b
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,kaanapali-gcc.h
@@ -0,0 +1,241 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_KAANAPALI_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_KAANAPALI_H
+
+/* GCC clocks */
+#define GCC_AGGRE_NOC_PCIE_AXI_CLK				0
+#define GCC_AGGRE_UFS_PHY_AXI_CLK				1
+#define GCC_AGGRE_USB3_PRIM_AXI_CLK				2
+#define GCC_BOOT_ROM_AHB_CLK					3
+#define GCC_CAM_BIST_MCLK_AHB_CLK				4
+#define GCC_CAMERA_AHB_CLK					5
+#define GCC_CAMERA_HF_AXI_CLK					6
+#define GCC_CAMERA_SF_AXI_CLK					7
+#define GCC_CAMERA_XO_CLK					8
+#define GCC_CFG_NOC_PCIE_ANOC_AHB_CLK				9
+#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK				10
+#define GCC_CNOC_PCIE_SF_AXI_CLK				11
+#define GCC_DDRSS_PCIE_SF_QTB_CLK				12
+#define GCC_QMIP_CAMERA_CMD_AHB_CLK				13
+#define GCC_DISP_HF_AXI_CLK					14
+#define GCC_DISP_SF_AXI_CLK					15
+#define GCC_EVA_AHB_CLK						16
+#define GCC_EVA_AXI0_CLK					17
+#define GCC_EVA_AXI0C_CLK					18
+#define GCC_EVA_XO_CLK						19
+#define GCC_GP1_CLK						20
+#define GCC_GP1_CLK_SRC						21
+#define GCC_GP2_CLK						22
+#define GCC_GP2_CLK_SRC						23
+#define GCC_GP3_CLK						24
+#define GCC_GP3_CLK_SRC						25
+#define GCC_GPLL0						26
+#define GCC_GPLL0_OUT_EVEN					27
+#define GCC_GPLL1						28
+#define GCC_GPLL4						29
+#define GCC_GPLL7						30
+#define GCC_GPLL9						31
+#define GCC_GPU_CFG_AHB_CLK					32
+#define GCC_GPU_GEMNOC_GFX_CLK					33
+#define GCC_GPU_GPLL0_CLK_SRC					34
+#define GCC_GPU_GPLL0_DIV_CLK_SRC				35
+#define GCC_QMIP_VIDEO_VCODEC_AHB_CLK				36
+#define GCC_QMIP_GPU_AHB_CLK					37
+#define GCC_PCIE_0_AUX_CLK					38
+#define GCC_PCIE_0_AUX_CLK_SRC					39
+#define GCC_PCIE_0_CFG_AHB_CLK					40
+#define GCC_PCIE_0_MSTR_AXI_CLK					41
+#define GCC_PCIE_0_PHY_AUX_CLK					42
+#define GCC_PCIE_0_PHY_AUX_CLK_SRC				43
+#define GCC_PCIE_0_PHY_RCHNG_CLK				44
+#define GCC_PCIE_0_PHY_RCHNG_CLK_SRC				45
+#define GCC_PCIE_0_PIPE_CLK					46
+#define GCC_PCIE_0_PIPE_CLK_SRC					47
+#define GCC_PCIE_0_SLV_AXI_CLK					48
+#define GCC_PCIE_0_SLV_Q2A_AXI_CLK				49
+#define GCC_PCIE_RSCC_CFG_AHB_CLK				50
+#define GCC_PCIE_RSCC_XO_CLK					51
+#define GCC_PDM2_CLK						52
+#define GCC_PDM2_CLK_SRC					53
+#define GCC_PDM_AHB_CLK						54
+#define GCC_PDM_XO4_CLK						55
+#define GCC_QUPV3_I2C_CORE_CLK					56
+#define GCC_QUPV3_I2C_S0_CLK					57
+#define GCC_QUPV3_I2C_S0_CLK_SRC				58
+#define GCC_QUPV3_I2C_S1_CLK					59
+#define GCC_QUPV3_I2C_S1_CLK_SRC				60
+#define GCC_QUPV3_I2C_S2_CLK					61
+#define GCC_QUPV3_I2C_S2_CLK_SRC				62
+#define GCC_QUPV3_I2C_S3_CLK					63
+#define GCC_QUPV3_I2C_S3_CLK_SRC				64
+#define GCC_QUPV3_I2C_S4_CLK					65
+#define GCC_QUPV3_I2C_S4_CLK_SRC				66
+#define GCC_QUPV3_I2C_S_AHB_CLK					67
+#define GCC_QUPV3_WRAP1_CORE_2X_CLK				68
+#define GCC_QUPV3_WRAP1_CORE_CLK				69
+#define GCC_QUPV3_WRAP1_QSPI_REF_CLK				70
+#define GCC_QUPV3_WRAP1_QSPI_REF_CLK_SRC			71
+#define GCC_QUPV3_WRAP1_S0_CLK					72
+#define GCC_QUPV3_WRAP1_S0_CLK_SRC				73
+#define GCC_QUPV3_WRAP1_S1_CLK					74
+#define GCC_QUPV3_WRAP1_S1_CLK_SRC				75
+#define GCC_QUPV3_WRAP1_S2_CLK					76
+#define GCC_QUPV3_WRAP1_S2_CLK_SRC				77
+#define GCC_QUPV3_WRAP1_S3_CLK					78
+#define GCC_QUPV3_WRAP1_S3_CLK_SRC				79
+#define GCC_QUPV3_WRAP1_S4_CLK					80
+#define GCC_QUPV3_WRAP1_S4_CLK_SRC				81
+#define GCC_QUPV3_WRAP1_S5_CLK					82
+#define GCC_QUPV3_WRAP1_S5_CLK_SRC				83
+#define GCC_QUPV3_WRAP1_S6_CLK					84
+#define GCC_QUPV3_WRAP1_S6_CLK_SRC				85
+#define GCC_QUPV3_WRAP1_S7_CLK					86
+#define GCC_QUPV3_WRAP1_S7_CLK_SRC				87
+#define GCC_QUPV3_WRAP2_CORE_2X_CLK				88
+#define GCC_QUPV3_WRAP2_CORE_CLK				89
+#define GCC_QUPV3_WRAP2_S0_CLK					90
+#define GCC_QUPV3_WRAP2_S0_CLK_SRC				91
+#define GCC_QUPV3_WRAP2_S1_CLK					92
+#define GCC_QUPV3_WRAP2_S1_CLK_SRC				93
+#define GCC_QUPV3_WRAP2_S2_CLK					94
+#define GCC_QUPV3_WRAP2_S2_CLK_SRC				95
+#define GCC_QUPV3_WRAP2_S3_CLK					96
+#define GCC_QUPV3_WRAP2_S3_CLK_SRC				97
+#define GCC_QUPV3_WRAP2_S4_CLK					98
+#define GCC_QUPV3_WRAP2_S4_CLK_SRC				99
+#define GCC_QUPV3_WRAP3_CORE_2X_CLK				100
+#define GCC_QUPV3_WRAP3_CORE_CLK				101
+#define GCC_QUPV3_WRAP3_IBI_CTRL_0_CLK_SRC			102
+#define GCC_QUPV3_WRAP3_IBI_CTRL_1_CLK				103
+#define GCC_QUPV3_WRAP3_IBI_CTRL_2_CLK				104
+#define GCC_QUPV3_WRAP3_S0_CLK					105
+#define GCC_QUPV3_WRAP3_S0_CLK_SRC				106
+#define GCC_QUPV3_WRAP3_S1_CLK					107
+#define GCC_QUPV3_WRAP3_S1_CLK_SRC				108
+#define GCC_QUPV3_WRAP3_S2_CLK					109
+#define GCC_QUPV3_WRAP3_S2_CLK_SRC				110
+#define GCC_QUPV3_WRAP3_S3_CLK					111
+#define GCC_QUPV3_WRAP3_S3_CLK_SRC				112
+#define GCC_QUPV3_WRAP3_S4_CLK					113
+#define GCC_QUPV3_WRAP3_S4_CLK_SRC				114
+#define GCC_QUPV3_WRAP3_S5_CLK					115
+#define GCC_QUPV3_WRAP3_S5_CLK_SRC				116
+#define GCC_QUPV3_WRAP4_CORE_2X_CLK				117
+#define GCC_QUPV3_WRAP4_CORE_CLK				118
+#define GCC_QUPV3_WRAP4_S0_CLK					119
+#define GCC_QUPV3_WRAP4_S0_CLK_SRC				120
+#define GCC_QUPV3_WRAP4_S1_CLK					121
+#define GCC_QUPV3_WRAP4_S1_CLK_SRC				122
+#define GCC_QUPV3_WRAP4_S2_CLK					123
+#define GCC_QUPV3_WRAP4_S2_CLK_SRC				124
+#define GCC_QUPV3_WRAP4_S3_CLK					125
+#define GCC_QUPV3_WRAP4_S3_CLK_SRC				126
+#define GCC_QUPV3_WRAP4_S4_CLK					127
+#define GCC_QUPV3_WRAP4_S4_CLK_SRC				128
+#define GCC_QUPV3_WRAP_1_M_AXI_CLK				129
+#define GCC_QUPV3_WRAP_1_S_AHB_CLK				130
+#define GCC_QUPV3_WRAP_2_M_AHB_CLK				131
+#define GCC_QUPV3_WRAP_2_S_AHB_CLK				132
+#define GCC_QUPV3_WRAP_3_IBI_1_AHB_CLK				133
+#define GCC_QUPV3_WRAP_3_IBI_2_AHB_CLK				134
+#define GCC_QUPV3_WRAP_3_M_AHB_CLK				135
+#define GCC_QUPV3_WRAP_3_S_AHB_CLK				136
+#define GCC_QUPV3_WRAP_4_M_AHB_CLK				137
+#define GCC_QUPV3_WRAP_4_S_AHB_CLK				138
+#define GCC_SDCC2_AHB_CLK					139
+#define GCC_SDCC2_APPS_CLK					140
+#define GCC_SDCC2_APPS_CLK_SRC					141
+#define GCC_SDCC4_AHB_CLK					142
+#define GCC_SDCC4_APPS_CLK					143
+#define GCC_SDCC4_APPS_CLK_SRC					144
+#define GCC_UFS_PHY_AHB_CLK					145
+#define GCC_UFS_PHY_AXI_CLK					146
+#define GCC_UFS_PHY_AXI_CLK_SRC					147
+#define GCC_UFS_PHY_ICE_CORE_CLK				148
+#define GCC_UFS_PHY_ICE_CORE_CLK_SRC				149
+#define GCC_UFS_PHY_PHY_AUX_CLK					150
+#define GCC_UFS_PHY_PHY_AUX_CLK_SRC				151
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK				152
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK_SRC				153
+#define GCC_UFS_PHY_RX_SYMBOL_1_CLK				154
+#define GCC_UFS_PHY_RX_SYMBOL_1_CLK_SRC				155
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK				156
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK_SRC				157
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK				158
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC				159
+#define GCC_USB30_PRIM_MASTER_CLK				160
+#define GCC_USB30_PRIM_MASTER_CLK_SRC				161
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK				162
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC			163
+#define GCC_USB30_PRIM_MOCK_UTMI_POSTDIV_CLK_SRC		164
+#define GCC_USB30_PRIM_SLEEP_CLK				165
+#define GCC_USB3_PRIM_PHY_AUX_CLK				166
+#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC				167
+#define GCC_USB3_PRIM_PHY_COM_AUX_CLK				168
+#define GCC_USB3_PRIM_PHY_PIPE_CLK				169
+#define GCC_USB3_PRIM_PHY_PIPE_CLK_SRC				170
+#define GCC_VIDEO_AHB_CLK					171
+#define GCC_VIDEO_AXI0_CLK					172
+#define GCC_VIDEO_AXI1_CLK					173
+#define GCC_VIDEO_XO_CLK					174
+#define GCC_QMIP_CAMERA_NRT_AHB_CLK				175
+#define GCC_QMIP_CAMERA_RT_AHB_CLK				176
+#define GCC_QMIP_DISP_DCP_SF_AHB_CLK				177
+#define GCC_QMIP_PCIE_AHB_CLK					178
+#define GCC_QMIP_VIDEO_CV_CPU_AHB_CLK				179
+#define GCC_QMIP_VIDEO_CVP_AHB_CLK				180
+#define GCC_QMIP_VIDEO_V_CPU_AHB_CLK				181
+#define GCC_DISP_AHB_CLK					182
+
+/* GCC power domains */
+#define GCC_PCIE_0_GDSC						0
+#define GCC_PCIE_0_PHY_GDSC					1
+#define GCC_UFS_MEM_PHY_GDSC					2
+#define GCC_UFS_PHY_GDSC					3
+#define GCC_USB30_PRIM_GDSC					4
+#define GCC_USB3_PHY_GDSC					5
+
+/* GCC resets */
+#define GCC_CAMERA_BCR						0
+#define GCC_DISPLAY_BCR						1
+#define GCC_EVA_AXI0_CLK_ARES					2
+#define GCC_EVA_AXI0C_CLK_ARES					3
+#define GCC_EVA_BCR						4
+#define GCC_GPU_BCR						5
+#define GCC_PCIE_0_BCR						6
+#define GCC_PCIE_0_LINK_DOWN_BCR				7
+#define GCC_PCIE_0_NOCSR_COM_PHY_BCR				8
+#define GCC_PCIE_0_PHY_BCR					9
+#define GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR			10
+#define GCC_PCIE_PHY_BCR					11
+#define GCC_PCIE_PHY_CFG_AHB_BCR				12
+#define GCC_PCIE_PHY_COM_BCR					13
+#define GCC_PCIE_RSCC_BCR					14
+#define GCC_PDM_BCR						15
+#define GCC_QUPV3_WRAPPER_1_BCR					16
+#define GCC_QUPV3_WRAPPER_2_BCR					17
+#define GCC_QUPV3_WRAPPER_3_BCR					18
+#define GCC_QUPV3_WRAPPER_4_BCR					19
+#define GCC_QUPV3_WRAPPER_I2C_BCR				20
+#define GCC_QUSB2PHY_PRIM_BCR					21
+#define GCC_QUSB2PHY_SEC_BCR					22
+#define GCC_SDCC2_BCR						23
+#define GCC_SDCC4_BCR						24
+#define GCC_UFS_PHY_BCR						25
+#define GCC_USB30_PRIM_BCR					26
+#define GCC_USB3_DP_PHY_PRIM_BCR				27
+#define GCC_USB3_DP_PHY_SEC_BCR					28
+#define GCC_USB3_PHY_PRIM_BCR					29
+#define GCC_USB3_PHY_SEC_BCR					30
+#define GCC_USB3PHY_PHY_PRIM_BCR				31
+#define GCC_USB3PHY_PHY_SEC_BCR					32
+#define GCC_VIDEO_AXI0_CLK_ARES					33
+#define GCC_VIDEO_AXI1_CLK_ARES					34
+#define GCC_VIDEO_BCR						35
+#define GCC_VIDEO_XO_CLK_ARES					36
+
+#endif

-- 
2.34.1


