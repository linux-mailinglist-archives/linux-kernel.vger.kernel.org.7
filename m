Return-Path: <linux-kernel+bounces-831417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B15B9C9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0445E1BC4474
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301682D0620;
	Wed, 24 Sep 2025 23:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HR0Zk/AJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0A22C158B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756813; cv=none; b=dspkV5kghW83kc1fgHPRqZBOJ0RXuU78qETAOVvN47DIwZNO9Rqj7Wa9GeS4SvRkS2F8ISuqxvq8FzS/rVvVUimStC4a3BBIhffxxHcGqohTwW5tcZ3bRcHRzygHdvwojaLI6k1L9MAlwhEalFpZFYsluzvWunKJ1CvQ3glV58M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756813; c=relaxed/simple;
	bh=s17pVTpfHpJBXVbeGOGy/DKB8otKGHuREpCt9nlrFq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p/cjmR7Pve93PUbqivpi9ejM4nY7/fjVcGHp+AptJmmQv4TsWKv30Cvg6ElbbiB/ARsScOgMz+HKvmCQh13rsqWok2N6ygtp9t6zZHup5npNAytoWff04IBmhf++fXNCPhZE9umi7/Mqly92V54ao91nkSuLnqeFw6X6am5Wbe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HR0Zk/AJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCQmhP002802
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ndw+rqs1qizTVWC5reblwW5J0ZiIr5WD2TSz5Cliqlo=; b=HR0Zk/AJRp6407YY
	eIvGNh6kUVESKF93V0hMQYoJWv7qmPcN33UXFe3Y5crrW8tTW0+jSgMHTJJXVsvd
	huJJDduF5E2VwB3mhSqftHNbcftWmjzEeM2aMG1KD/tGmGUxMlXyYx96a+R1jJA3
	k2HjgGCNO1SeYQqyfhxV+beVBojHaKzX6Xpty5OHm65S2r4FIrHjJeDYj8jBQrHo
	M9ZakkPXql7b9nV7nq6Mjh0mElY37Kb+jTEIvKSXqT945eUZjGZl/QDlrCvPgVRv
	WqqOGLf6v++FRRHUWy8wkeFmq+l0rVqg2mZrmUOaCR7aZ9uWKvMlCcSRFWSLjSch
	tFGDog==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf0km0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-252afdfafe1so3488375ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756810; x=1759361610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ndw+rqs1qizTVWC5reblwW5J0ZiIr5WD2TSz5Cliqlo=;
        b=ssiiqMgYzlT2moM1ZDqY3ralymBo49WsMmhvoy8Lrq9lDmGdnYxE69F6M7i9J8cRrK
         Yn9KQeDS+aXtVb6+m5ILigVylr/qBYKFGmb0ELg9KKLpJKESmh9wBP9+37IqoCO8J/Ru
         gLmR3p8HsvS3mk4VC56hf8YWXm2FGpOuUylGvpK7RdFitLl7aw8e2g1OZPAuGw8NBMlJ
         uc8ihEAHPFrSD45He93UhUTAr3CEehBsiIRZEbm1FG7Ju0AwYUXxk7Ohm+Dth0HvIB4T
         Boysu8utI/1Ew8f+IyoFYIbMVlaBTYG6k7RGnk+GHXjBK0BflvmiQ6Fq9awizqZDXBCJ
         oT9w==
X-Forwarded-Encrypted: i=1; AJvYcCU2nRemLbX6L6NaMU47WCnpdiSNr1WlGc9WC/x7hEpl93I7BXzE5hkP99Nl8jGGBsx8zKtbMzUkgyMAKL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJkMZohlmyKsgU5YdK3exK7cn7liaaKYa0UtvfZjBEGG3J1zsK
	cmgkPmUZVXeKRE0HnWwhWEOaWXykK53/iXkqDxlJEofG0yZLzYFCKt8gCkOvGJIpEWo1lenROXB
	HOI9Cc3LF0S5RsSroWJ+JWwXMwTfZTNI6sf8iGZ3QzY/kApCN3f/8h2g1+/jCw3tCnZQ=
X-Gm-Gg: ASbGnctQg16XA9D/lji98sgBNAngWvs4gsbz/kDcdSnm9lmXg6YMrMpOf6jqiw14p6o
	ImSDq0yAnxCnDbFN4F6UoDoEbbwKMD8uxnC211PXCSRxnkcScxPRCIYMCruC6HytwfsGcCb8VB6
	WzHFBn7iBBg8fcdbpa3SHwd1MsyJge1k9j+jca06AWRCRSju8xIKVoaqQRNQPZ819ixb+iOwToY
	zKpqQ/hrD3PFh0THpeejoj27TXkb8/5mMETX5Jp23/zCuDAafHHZCkdrAzRrq88flJX+hjjEa+E
	cmzL6wduuc0n3GB52IqZgG8/k0FJe5NyN1G9Tj8JPNc3KZr44dQY9V+FGS+uJtr2+F+wK7DK9MO
	HUy5Si7e9I7rrT8g=
X-Received: by 2002:a17:903:244d:b0:25c:392c:33be with SMTP id d9443c01a7336-27ed4a5c567mr15661705ad.59.1758756810041;
        Wed, 24 Sep 2025 16:33:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5CADDonj4Tj3EKc7HnMksbjmMI+Bu1zU78weaqGMcam4AMLJAz+8098+e9XI7Mmhcp0yHBA==
X-Received: by 2002:a17:903:244d:b0:25c:392c:33be with SMTP id d9443c01a7336-27ed4a5c567mr15661345ad.59.1758756809568;
        Wed, 24 Sep 2025 16:33:29 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53ca107sm392911a12.13.2025.09.24.16.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:33:29 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:33:20 -0700
Subject: [PATCH 4/6] phy: qcom-qmp: pcs-pcie: Add v8 register offsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-pcie-v1-4-5fb59e398b83@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756801; l=2102;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=lh5soms/PW05Acpi9g8AxeEqOMMit9vCSgZ1ViTmATo=;
 b=5tMPZ0N4k9d3RS+mJPp3yzpfG9uOjUB3PGKnR/MMsJHFt75AMbLGDGORXo1/pTnX2w1v6Ctso
 0OHJhRjQjxHAtqp/3XVN9c0OF/4OPIVcxiIsGLc9IG85bCKf1oKDjFE
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: 0x_hydkAy9T1ayNH_s65lLcoaZrfgR8H
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d47fcb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=8UDt2JBBUKJrZSEALGsA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX4Kc1Ig9+cyT8
 gTAO/kzZwRbA53cw9O27dTOKNKaX3Nn1Ee0lx4Q8XBDBKZkOGYs+/jSD2DNKn1EqnCNsYpy8Nwl
 UqyZOTXckLrk2v1sPOHglFSkJDFRnYvPaMuEiYzD3PRQWCds7ImGCPF/a6gCEg7Ik8OUPcIoC6M
 e1UQpB8fVrurZeWc4ueSQbVjQrRcHVIZB9r3Fdo82yYT8OEItkpgjL1uZ1mMDx6rZPHEO1AvCEC
 77MX5RSpk4FAi2A4RHny2iDf38pvk32RfQhOMVSqgrvWaQeJF4FOEslUupHuwolnXlb+J5nhNet
 MQkSt9CDVYBdGAaJj7xZc8AXomyYKE9cnDnD2r2NDXPWk2FfDQ3JAug2z28qVls9T6GsJeSLHmR
 dsPS3zTZ
X-Proofpoint-ORIG-GUID: 0x_hydkAy9T1ayNH_s65lLcoaZrfgR8H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

From: Qiang Yu <qiang.yu@oss.qualcomm.com>

Kaanapali SoC uses QMP phy with version v8 for PCIe Gen3 x2. Add the new
PCS PCIE specific offsets in a dedicated header file.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h | 35 +++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h
new file mode 100644
index 000000000000..5d630e5123a5
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_PCIE_V8_H_
+#define QCOM_PHY_QMP_PCS_PCIE_V8_H_
+
+/* Only for QMP V8 PHY - PCIE PCS registers */
+
+#define QPHY_PCIE_V8_PCS_POWER_STATE_CONFIG2		0x00c
+#define QPHY_PCIE_V8_PCS_TX_RX_CONFIG		0x018
+#define QPHY_PCIE_V8_PCS_ENDPOINT_REFCLK_DRIVE	0x01c
+#define QPHY_PCIE_V8_PCS_OSC_DTCT_ACTIONS		0x090
+#define QPHY_PCIE_V8_PCS_EQ_CONFIG1			0x0a0
+#define QPHY_PCIE_V8_PCS_G3_RXEQEVAL_TIME		0x0f0
+#define QPHY_PCIE_V8_PCS_G4_RXEQEVAL_TIME		0x0f4
+#define QPHY_PCIE_V8_PCS_G4_EQ_CONFIG5		0x108
+#define QPHY_PCIE_V8_PCS_G4_PRE_GAIN			0x15c
+#define QPHY_PCIE_V8_PCS_RX_MARGINING_CONFIG1	0x17c
+#define QPHY_PCIE_V8_PCS_RX_MARGINING_CONFIG3	0x184
+#define QPHY_PCIE_V8_PCS_RX_MARGINING_CONFIG5	0x18c
+#define QPHY_PCIE_V8_PCS_G3_FOM_EQ_CONFIG5		0x1ac
+#define QPHY_PCIE_V8_PCS_G4_FOM_EQ_CONFIG5		0x1c0
+#define QPHY_PCIE_V8_PCS_POWER_STATE_CONFIG6			0x1d0
+
+#define QPHY_PCIE_V8_PCS_G12S1_TXDEEMPH_M6DB			0x170
+#define QPHY_PCIE_V8_PCS_G3S2_PRE_GAIN			0x178
+#define QPHY_PCIE_V8_PCS_RX_SIGDET_LVL			0x190
+#define QPHY_PCIE_V8_PCS_ELECIDLE_DLY_SEL			0x1b8
+#define QPHY_PCIE_V8_PCS_PCS_TX_RX_CONFIG1			0x1dc
+#define QPHY_PCIE_V8_PCS_PCS_TX_RX_CONFIG2			0x1e0
+#define QPHY_PCIE_V8_PCS_EQ_CONFIG4			0x1f8
+#define QPHY_PCIE_V8_PCS_EQ_CONFIG5			0x1fc
+#endif

-- 
2.25.1


