Return-Path: <linux-kernel+bounces-831416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D5CB9C9AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875064A8611
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA602C3745;
	Wed, 24 Sep 2025 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gbNx8AYx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D784F2C0F8E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756812; cv=none; b=L9eJ/UCN1TKyeKcLBMmCsyLuJQkNFAJsEkVDLg+iht4xcE3Y+3dyPakUbwHPSRvcemg687Y8lIGf/oPt3ZSQ/TPpsnqzmwhxkAyz6A23R3Ww/kiADXd3+yD3Cu/FlfaGRUgqDbDSZU7fyEebxKciMkM+XVWbcgz62SunxHJ6emM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756812; c=relaxed/simple;
	bh=4vSdyILjWl7JeyGhaeKWfllkZGkG8k3DMb05WixnHQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b500msKDBUM75If96k+5a1dqiRiGOdUJjy99Kc4Lq2p/ecAZCQ3kdS8vLJEF4/SixutsoVpgfDgulQhoXQVSUovaLu5P8R4/5r7QC3D9XDX2KeO8MZchUlGwoij2aIQJMfQAuK28tqX74gSb7TKM1MCf4viT6Wwhiq0jkWGBZCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gbNx8AYx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCu8jv024516
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DHltwgur1BfMiD6ZCGpjw2sjWFIRGbG1DzGcy24bkEk=; b=gbNx8AYxnXQxDU9Z
	v+ytH3aw3dN0O/JJZXzsjCEOBh3DN5Bp8GqCajvGmLkiV5g5SFbT6BHcCZz9bMEn
	P7KADXGGCF+rLdK/m/qoGdL5uVNuuzN6r7EReyQ8vpaxU3C3hgT+2yU+AWcUr/qy
	oJ87bjl7rhUOsKE+vk/yKKQknsqQIODlUGW2sEmI1Rq6s7kflE1Y22K5lXiHf2A4
	RVWzDMPl1Dc42jUmZ4RrNPrjy6O7YD54PT01sDaQQjYWjf4tU5i4KqGQrhDRSnI0
	bgYKnsn0LrVEp9U0Z/p1PNlvuPWyEiDIjdS9uWcaM1BIbEuEHBHP3gPUVWdgv/w3
	6XwNdg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0d2rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:29 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b551338c2c9so180644a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756809; x=1759361609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHltwgur1BfMiD6ZCGpjw2sjWFIRGbG1DzGcy24bkEk=;
        b=T8/OH5SsTHCoLgwZzq4NDShPaWzagQMaj418FMFB7KS8SX9Fq952KDA4MEWyFHrU1x
         XJJRhk+hXOGD1cMqzEt4ZcxKyD+TJUMKvzHip8Lxf0UHFyQzQS807MoIPon+5BzP7rkt
         24yPiZecMflsPcQT3/pSwJc85NuAhh0BosCNCjPWYpxW1KQv8HE+GL47RU6wVN5osf6Z
         CiE54tcU/T14NqyIWbpWBBMtm3keCyt10Gy38l7a3no81W9QfTFpvuARwO2ObDW5y5/g
         umKqBZOed3EhzIamOjRNA7XqsN04+Jo/gT3MjQcFUthNAfaImFE2rhsMQ9ZdV97UI4Ea
         gRTg==
X-Forwarded-Encrypted: i=1; AJvYcCVxItaybLu2+mzuFjY80Rb4diFxY6nVcHVPuWuWVzVACrKqeUZlTi2YKDbWDkIoqGhX6eWn/DWaQKc65RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQbITd/iNTrAq4BlYDqno0KhqPqtGUNtSEGKF2kiRu8FkK6qkv
	KrW3NgXQ/Mr4oFtrkx6+dVDItTAPGU+7VCrbPlBHpZVfTTsJQoe/Gb1CmudsWrGwmDdCFiSz0Rg
	EiCN/OOx7Z6ThRLUaIKjPauWT0ZTPFqCUcfM1rJ8Ydd3mGfL7w30o32mAkniFjnN8DUY=
X-Gm-Gg: ASbGnctbg4scb+ic1U6B+5DVf/jQIg6GyzonYAsQlXatRWY0+KbGPxUc8iX2A0N346y
	eXaa0crvWyAi0tp+3AK3bFjb61nOEcVMQDq4ToKgzG5eSwxl2vrm0ssX9E9WIr9vIwJhnZ6YDGH
	ePYO5OHrs5GvTFqH09ismMnbqiInHSejTkYUwsqMpLmTZx54hF10tbB+IWZhX48KII/cafuuiL6
	OChA1f21wpQLBIx0+SAOFtQ2d9LAyVNpT7qVAhVyrUxjsNUulsTLlE2dvU03gWsssB80p1WkRzk
	lH0cFho8j2dDlEem1F48OcIF6plV7nETBgjwdgQ5wlIesj5vBKP1yvmXV6Yf6BmkRV5z1r7YBWy
	FJrWKzmnu9rK+5hE=
X-Received: by 2002:a05:6a20:9192:b0:277:f962:3163 with SMTP id adf61e73a8af0-2e7c29376b1mr1642723637.19.1758756808578;
        Wed, 24 Sep 2025 16:33:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTJ71K9g+469uClLmZwSoL9DavnoWtdXEI7DsRgFdlBq0ISrCZ69X/FgwyFw4ueQ317L5Drw==
X-Received: by 2002:a05:6a20:9192:b0:277:f962:3163 with SMTP id adf61e73a8af0-2e7c29376b1mr1642702637.19.1758756808129;
        Wed, 24 Sep 2025 16:33:28 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53ca107sm392911a12.13.2025.09.24.16.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:33:27 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:33:19 -0700
Subject: [PATCH 3/6] phy: qcom-qmp: qserdes-txrx: Add QMP PCIe PHY
 v8-specific register offsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-pcie-v1-3-5fb59e398b83@oss.qualcomm.com>
References: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
In-Reply-To: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756801; l=4314;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=jFjxkAF3nqQJ+9TobMmzv/05mm+4KFnWIHbV2tnmmys=;
 b=zA7wfPQ/vlNf/7X4Du1r8wbvarwm3TBfLjDd3lQhjTbIeeg9h3LBVgegrL6ORnIdveVaet98z
 Fl0r4It3ZgIBstk0+1Weuglswx5BfuOMDUA7FCDECNvMSCVfjbfKgzM
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d47fc9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=4xyYOQZvY-QN-ePQHmMA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: S3ZyyxG6d847ZJfRPGQEoPIofpFOophc
X-Proofpoint-ORIG-GUID: S3ZyyxG6d847ZJfRPGQEoPIofpFOophc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX6ax/tEzYCLp1
 ORj3wPHuzCPpuvdwmId2t7fL6LoegWeIGT91j67FpnKvL+UnVjwe6gqSqh2lVetCD9Fb8KscFBU
 92MoxWmSRKOcIZ8RYJor+c6oCORCV2vhOU+uLUUCzI5oXCF0iAuX+0hS7vxlpPZ6jmptBMOJfQn
 6+1m6TT9oYKpkfllNEtPj03WT4cPhFZSvVi6z48eDLH89PMGB1AC/UlbEhqgklxqEjpBW/sNS0H
 G7UWYNBdAaUrt1uxwpDl9sNMPgNafxoro98RMbHIOvOS7J7065nwfuPzvm4mQfdgSbBIJeI+MBZ
 gZ5RkZZ87a2UQPvkPMIYzQFexH5B/he0KiOGVWFmQGbkezgZn71gDAueQS9NltmVDKsfSFttCfO
 aQObQxYn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

From: Qiang Yu <qiang.yu@oss.qualcomm.com>

Kaanapali SoC uses QMP PHY with version v8 for PCIe Gen3 x2, but its
qserdes-txrx register offsets differ from the existing v8 offsets. To
accommodate these differences, add the qserdes-txrx specific offsets in
a dedicated header file.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h   | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h
new file mode 100644
index 000000000000..181846e08c0f
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_PCIE_V8_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_PCIE_V8_H_
+
+#define QSERDES_V8_PCIE_TX_RES_CODE_LANE_OFFSET_TX		0x030
+#define QSERDES_V8_PCIE_TX_RES_CODE_LANE_OFFSET_RX		0x034
+#define QSERDES_V8_PCIE_TX_LANE_MODE_1		0x07c
+#define QSERDES_V8_PCIE_TX_LANE_MODE_2		0x080
+#define QSERDES_V8_PCIE_TX_LANE_MODE_3		0x084
+#define QSERDES_V8_PCIE_TX_TRAN_DRVR_EMP_EN		0x0b4
+#define QSERDES_V8_PCIE_TX_TX_BAND0		0x0e0
+#define QSERDES_V8_PCIE_TX_TX_BAND1		0x0e4
+#define QSERDES_V8_PCIE_TX_SEL_10B_8B		0x0f4
+#define QSERDES_V8_PCIE_TX_SEL_20B_10B		0x0f8
+#define QSERDES_V8_PCIE_TX_PARRATE_REC_DETECT_IDLE_EN		0x058
+#define QSERDES_V8_PCIE_TX_TX_ADAPT_POST_THRESH1		0x118
+#define QSERDES_V8_PCIE_TX_TX_ADAPT_POST_THRESH2		0x11c
+#define QSERDES_V8_PCIE_TX_PHPRE_CTRL		0x128
+#define QSERDES_V8_PCIE_TX_EQ_RCF_CTRL_RATE3		0x148
+#define QSERDES_V8_PCIE_TX_EQ_RCF_CTRL_RATE4		0x14c
+
+#define QSERDES_V8_PCIE_RX_UCDR_FO_GAIN_RATE4		0x0dc
+#define QSERDES_V8_PCIE_RX_UCDR_SO_GAIN_RATE3		0x0ec
+#define QSERDES_V8_PCIE_RX_UCDR_SO_GAIN_RATE4		0x0f0
+#define QSERDES_V8_PCIE_RX_UCDR_PI_CONTROLS		0x0f4
+#define QSERDES_V8_PCIE_RX_VGA_CAL_CNTRL1		0x170
+#define QSERDES_V8_PCIE_RX_VGA_CAL_MAN_VAL		0x178
+#define QSERDES_V8_PCIE_RX_RX_EQU_ADAPTOR_CNTRL4		0x1b4
+#define QSERDES_V8_PCIE_RX_SIGDET_ENABLES			0x1d8
+#define QSERDES_V8_PCIE_RX_SIGDET_LVL			0x1e0
+#define QSERDES_V8_PCIE_RX_RXCLK_DIV2_CTRL			0x0b8
+#define QSERDES_V8_PCIE_RX_RX_BAND_CTRL0			0x0bc
+#define QSERDES_V8_PCIE_RX_RX_TERM_BW_CTRL0			0x0c4
+#define QSERDES_V8_PCIE_RX_RX_TERM_BW_CTRL1			0x0c8
+#define QSERDES_V8_PCIE_RX_SVS_MODE_CTRL			0x0b4
+#define QSERDES_V8_PCIE_RX_UCDR_PI_CTRL1			0x058
+#define QSERDES_V8_PCIE_RX_UCDR_PI_CTRL2			0x05c
+#define QSERDES_V8_PCIE_RX_UCDR_SB2_THRESH2_RATE3			0x084
+#define QSERDES_V8_PCIE_RX_UCDR_SB2_GAIN1_RATE3			0x098
+#define QSERDES_V8_PCIE_RX_UCDR_SB2_GAIN2_RATE3			0x0ac
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B0			0x218
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B1			0x21c
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B2			0x220
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B4			0x228
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE_0_1_B7			0x234
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B0			0x260
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B1			0x264
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B2			0x268
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B3			0x26c
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE3_B4			0x270
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B0			0x284
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B1			0x288
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B2			0x28c
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B3			0x290
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B4			0x294
+#define QSERDES_V8_PCIE_RX_RX_MODE_RATE4_SA_B5			0x298
+#define QSERDES_V8_PCIE_RX_Q_PI_INTRINSIC_BIAS_RATE32			0x31c
+#define QSERDES_V8_PCIE_RX_Q_PI_INTRINSIC_BIAS_RATE4			0x320
+#define QSERDES_V8_PCIE_RX_EOM_MAX_ERR_LIMIT_LSB			0x11c
+#define QSERDES_V8_PCIE_RX_EOM_MAX_ERR_LIMIT_MSB			0x120
+#define QSERDES_V8_PCIE_RX_AUXDATA_BIN_RATE23			0x108
+#define QSERDES_V8_PCIE_RX_AUXDATA_BIN_RATE4			0x10c
+#define QSERDES_V8_PCIE_RX_VTHRESH_CAL_MAN_VAL_RATE3			0x198
+#define QSERDES_V8_PCIE_RX_VTHRESH_CAL_MAN_VAL_RATE4			0x19c
+#define QSERDES_V8_PCIE_RX_GM_CAL			0x1a0
+
+#endif

-- 
2.25.1


