Return-Path: <linux-kernel+bounces-831343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85231B9C69D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C8C57B3B46
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44D22C0285;
	Wed, 24 Sep 2025 22:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iFl9H+Mq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4936829D270
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754750; cv=none; b=kzB3l3Leyi+NRSY56jpm8nOKLlby+pUttHEt4lHQf5rwPTiGZDJrxxjpHQlMczJHDv/TIAC9lYBmqJZnKdmXpqV+iZfoz/G5rxIHsBi9gEbhaCFSJ4RrG13O9twrfbIb338jFGxDKi/B9Pw9U1GcgxGQF67RG6jukuWBTkdD/5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754750; c=relaxed/simple;
	bh=yGar3RBx3zA6XrTR6cHYw5fB4rndRIKmG3cZDd2cMf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p1bwDfYAJXFZvxW5B7iK6G8/3R24LTs4Sd46rYLeCS50Nc81IIzW2t8Uck8HwYYL2ydfi2gI6UUrYL/Yg9LR3CDYrYbNZkOlfq97aHkO3+H6ldWOmou5IX4ZtlyFMoi6staB5Fs/vJxvjLFcX4I8sHkPYv1UTFaRJH1L97SSIls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iFl9H+Mq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCDY88002665
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rHA82ipy6O20otSqtPYzgHtPq2xKzxnYQNCyWaJl/Zw=; b=iFl9H+MqEdpNpvMu
	a4R59zABG2vggcbjldIAYXtiM6qNoiE7Qv9PxI8r73GoVIC5iCJjYL4ViqPfh3Li
	Wr0BcN4EK3/2/sqVZuvcjKnaplbqXVOlvchhs9RoCRIGBVWJdcMLdM/6+lESvu01
	sJtMDirdFKKScJBqNXI4ormiKVdtYcZYcOQ2RGMKmzcMHIKBtu2zTvu+ZFycaOLm
	JlnGg3Rbn8c3WIL5piLr4Dn4xxCpmeWwcq8aWEF4VXiXYB8DaMGt1SSTVbycd7zh
	iGsdpEh60J+yumYjqNqPa7a7hAI+1kT0QLdzqP9UJsS7uCAtD5HuOBqDQvxyAM37
	LUOTnQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf0h5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:07 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso275040b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758754746; x=1759359546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHA82ipy6O20otSqtPYzgHtPq2xKzxnYQNCyWaJl/Zw=;
        b=JZoipqAfeY1y5uCtKSZbWkWRcv2lCGHkCbMwVNrjciOBjq8qLDYTyJypoJfv9YfqJs
         tbIWTkVX3B64inbpfRqu4gxXxFGee4ZMycp8SFapnEzapwfQDdgD0aeI1QB4erByPgqB
         748OmdZlJKhc47ah2rr+sxdDCcGb5vSUspCqC3rGx9GUyHs+IhTG4PvQXqAaU7LPAci/
         wuKiS9Y754aY7s0/QZNlzCnj/JYzaeJb9W5NSDVxw1/Zky2r2IRT2ag3KcuaSyLuYFF5
         Wu71VyMHx2XEPykYRqD+1mDjSIxklgjbRy/QPr/eyozCCP9DHN1B3vwJUYZ8Q2H2001Z
         rktw==
X-Forwarded-Encrypted: i=1; AJvYcCVIzbxaXWEjQFnJv8GWTwP0vn8ax7C/8BirLM4/QXTSJ7mNHsPHd9eLWd6TZoq29mS1e66Ajus8Kq/Tdso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmGjsE43OAnfxHccT8TJoclO08EAYOmBKrcklBamvS4Jzq9vU1
	WJ3S8ODGz0o8lGOXfo1XRIt/JQVsqOgPBWX2KdkR6M2K72/7kB8ag5rKU6GesV0LT43RuEqqJHl
	3xUx/rhAzW3NPmHeXACjyvpO8MTwuNNfF5LLCU7X0AWT5ykWwOdLhZCWsE2eZK3oypUY=
X-Gm-Gg: ASbGncvXu8FZtehZZmU0FlU0mKJpj4s1h2N13QQ1g+OLcRhGeN9t/x/2fkbdZ6D9Wna
	J250VwnE69Z+8mBpNLEGBSfNI854ePDg6ZwiHfGxDwZeLqEz00EMDr1CJYV50ODIukDO9GSJ4xL
	PZ8vmsue//gqp4a4JOKMcGZvfgD5somNkhkJ6btwQf1U4p1q8VNX6lWb8b0uNRk/KC2f6e/yqxZ
	8v563+sy3VwRtMYmCSRoYxogWEz4waBhFYpSkFrWYen1iuBKPOFsRMIRGwLVLR/9zCWZowFzuIo
	b1afdBZwaHeVKIt2K1yGQsdGOtf7IPWaKhxSyMcto2Jp6DTzRvuzcmbFK+8OTPyw5JMzyI/T57N
	XGk7Dj1KOSBmYFEc=
X-Received: by 2002:a05:6a20:3d88:b0:2e1:1e67:502a with SMTP id adf61e73a8af0-2e7ce91fd32mr1380289637.32.1758754746471;
        Wed, 24 Sep 2025 15:59:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB348jDk+P+5TTtyE/NOAQUnYsW2pbeBBT+5DVb8XYuSDLHq9n2n4pd06p01ekfPg/Xv/Jwg==
X-Received: by 2002:a05:6a20:3d88:b0:2e1:1e67:502a with SMTP id adf61e73a8af0-2e7ce91fd32mr1380263637.32.1758754745995;
        Wed, 24 Sep 2025 15:59:05 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c2b70esm111166b3a.101.2025.09.24.15.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:59:05 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 15:58:55 -0700
Subject: [PATCH 3/9] dt-bindings: clock: qcom: Add Kaanapali Global clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-clk-v1-3-29b02b818782@oss.qualcomm.com>
References: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
In-Reply-To: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758754740; l=10906;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=5r4PhXTpDpitz3Lx09XfA4ED20VJWtMbNZe00iugabA=;
 b=hxSkys8rtsGiU+IDE3SgudGBxCI9gK3pgP/IefZBUWTjIaV9s2HrzEYThwLnqEOYAaeX0Cah5
 jlUz+oUkm8tApIIA9jiUEvhXIpUQ7r8RsH9yk1i/2JQ6fHhAV/2wpOU
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: 0MRH_wnqBYK6re8u5CI0_rHAaDYCJEtR
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d477bb cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ienkSzUGxTtIZQoOJKMA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX1AHakwODhjrn
 6FSiBupxPrQkDIo58FKb+M/p6boUDMsnHXARbM3NQzFvnTtLFHxdrMvNNVkQswdKAAHLZS4LIOv
 cLhyJx1UBhuU4EQ32MSyVvLLAobsPTfSLdjlUNIxNVRne6LoOR6oCVyAc0pokiVZfD9LowPPMDN
 Yw3llbeCJheCTTk310zX0ZNjMWR6Cu+B6vMUMlDkhgxykWUvwcAlqVtI59SCMavZeV4qe3S1w2f
 QuKlUQ8ZkSqyxVRZVtundSgb1YQ56+NziSHdpU+V6qHr1G8JWey2gMas80G3WMsK/vr2O2QVGer
 Vg4UoSU85uNOP6tqqk+g2VXP/7J2XIQCphyYU1CfyF0RsKd08fnLU65BMj+tLQa0U5+OgxwT0Rl
 wk2lxEG7
X-Proofpoint-ORIG-GUID: 0MRH_wnqBYK6re8u5CI0_rHAaDYCJEtR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

From: Taniya Das <taniya.das@oss.qualcomm.com>

Add device tree bindings for the global clock controller on Qualcomm
Kaanapali platform.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 .../devicetree/bindings/clock/qcom,sm8750-gcc.yaml |   8 +-
 include/dt-bindings/clock/qcom,kaanapali-gcc.h     | 241 +++++++++++++++++++++
 2 files changed, 247 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8750-gcc.yaml
index aab7039fd28d..0114d347b26f 100644
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
index 000000000000..890e48709f09
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
2.25.1


