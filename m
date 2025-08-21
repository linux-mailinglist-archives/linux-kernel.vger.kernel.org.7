Return-Path: <linux-kernel+bounces-779464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1452B2F473
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC92603E31
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEFE2F7462;
	Thu, 21 Aug 2025 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O4SimEev"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD362F5329
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769499; cv=none; b=rEQ8Ba80hdwpVUvYYRzVLMlp0+qt36Ryvb5OUeu4bSBkkoMJJXShv/15ICeYoUWkBAljkwIzYq8p6B1wvlUd72iwLDuxUjjKYd4o94yJHQ4nun0gZIatq7hnp+hFXE61Xvge7VEU4lEoaJ9k4yIofqomT3i0AQBjJIpCJ1IgH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769499; c=relaxed/simple;
	bh=u8m9J6JQcdijVzZyCUGGAb3P5FvSVwhfqYJgvJbWutg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LP8Kxw4OgVyb+Cen6ehCr9uvT23eDNGprEPnX0ibvLTzIFTSN5dIJxGvXdYUwF9fuJIa2t6YL9FVhPUPCcbhmoTo5UWC4/wLab461KulqCd2jooOSbeLr980O/y8Gnj8VITvcF1bXhgm4NeprXjuLVaqsmicn6sU3vOsMEPw+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O4SimEev; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9b7w4030556
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pAjVIj9zZFihL1lRBahHpibojgWb7AeuAiH+1H/bqwE=; b=O4SimEevwrTiOB8/
	Q/CV5f89mpciz9a9uEDPJyNEn8VgtPq9vk+dKGBbBRSB1dIe4iLYwrUlBkmjskIG
	hk6wu8bY8y9gSp2RX85NjuPxbk/z94PtBw7SBru61U4Q+oYqVu5cN36pMaqauKPP
	lWS0SVIDkfWIb2/07PSxPsjt0uSvSm+XxiSiaXFd5aW9SuJu7ZYdlqNWnvBd7ZyV
	HvCnBn/wkpkYVIuq9vn7q0Qa59XoSIvDeSLtrfs4GXJ9A0NcAfAFyP/59NbL2DxE
	B5lyV8Xt5SmDYrIyTx/Fpw7JKEldqS53xz3nfT4x38PfkctgChymWsTpn81YYCJp
	llIGsQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a51k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:44:57 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e614889so923346b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769497; x=1756374297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAjVIj9zZFihL1lRBahHpibojgWb7AeuAiH+1H/bqwE=;
        b=tBRRXiDs3C0Y6PIDsM0GQgmpbqOMstFly10wiASnEtaP4ZgvwGLW9CjUVOMvsS5wtk
         Pxixm4CKmrP3UHJwhuIj8cC98uPbiE6FaDhkJxOHxebHr/i8cT9P1Xy+67oEzym+zgAN
         PMiffUXunBd6jebS9ksGfGPs3m2Tt7RKeBEarrTmE09oEbRt9A1c2T3qCP5uJlYvnqX6
         i3oRirs738jNIKbZ++i8CE1eAhYHfCVZ3kzudoYGSvjEiOyKzaVeluPS7qn6peR+3qFy
         ekEUvIc2Itn1dC8A0GzecREdJS3tGyYLEDE23tqpkKzf6pVqcXOQWjRE5eGhwoIGgGvE
         LebQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZnfgLpWtVA4CoktLiCAKUiaCTFzXMIuKHxi9rFtvuf888qz8VXGod1t4ynlmuhNyZLduYpdAb4nGuU9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwruO7qGZIjoCS4ksEbldNqN1H+Dmk7jHRnsXMHY6OvMicNlIKp
	/axP6ca2DKu/ldSm2Gazx2Gh3u3rsx5IPvG5NZO8VgDhJjT/3+xy/oWGpv9VjG9L9/wxwQGYNbQ
	e0DHOqDdgkfqEgJxDg86q87KM3pIn5CZWm7x5G/Sr+NTF3AAh2AqXx7Qo/5L2sy4+zr4=
X-Gm-Gg: ASbGncugBjevzWny+wqnaAqLmULgPe98Ntn17sWtrFmigNS6082UjD5+jhADRnJvBUs
	i8YN8rRt6j4DoqFfIra8kCxKBngeiTFTwhKH60zmhLncy46BR3PqcjZ0I2qMtwMwYhJk1SpeYJQ
	uqaHISoKzXdUGp8ShebPORx1TF7iLclum6MMHdZd7nkvwuwob5Zmg5DAtM22e+t/7HEc4mTyYRW
	vKFTTmviKf6lLnmO2YxFxAnNW4Ns8Zg/D5B+hDvZG1CdbvFf9IKvkJAXrjHqEnflw244CWUs9EA
	Gdh7n4NOR+xMR2cbm81yktnHA3Wk02FxGBhmZQos6o3leaV3IbfQEBIehfloGFVWrAo4ikbOKLv
	tAL7crtZkF7mH1SM=
X-Received: by 2002:a05:6a21:6daa:b0:240:1a3a:d7bc with SMTP id adf61e73a8af0-2433074ea5dmr2729242637.3.1755769496733;
        Thu, 21 Aug 2025 02:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/MpkzQr3ODF27xl6H7fzctS/steJVN2Lh7mmHLZCmX18Qc+LXKukq9LL+tR+L4vIIZsB+BQ==
X-Received: by 2002:a05:6a21:6daa:b0:240:1a3a:d7bc with SMTP id adf61e73a8af0-2433074ea5dmr2729197637.3.1755769496270;
        Thu, 21 Aug 2025 02:44:56 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f23d853esm1426078a91.6.2025.08.21.02.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:44:55 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 02:44:31 -0700
Subject: [PATCH v2 4/4] phy: qcom: qmp-pcie: Add support for Glymur PCIe
 Gen5x4 PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-glymur_pcie5-v2-4-cd516784ef20@oss.qualcomm.com>
References: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
In-Reply-To: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755769489; l=2773;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=JCxdUH/Y1jTAi945mFOnkGKBqKReuEeHRFI8YpRwdqY=;
 b=6wWnoLAUA4kYP35QHTffBdgSdXwR5Lbvh/SsOGFjyL6WHXSpedpTdCm7nm6S/liahDEy/d2bs
 IHolWYfa9GbCqIKvGTxQIMxeN2g6PHyR0poVPj8UmQfDLMRioUouvFd
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a6ea99 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KvwrgBbZ-pJFRlqJlL4A:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Pm0FOLB_sQG4SYiWL86mMkTVBErkzaIJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX8ns116iuTxW+
 E6hyBOZDsoOMphPqbaph1QtrWvcL7lc8dGsLylq/1G+elcMFle6YwqMVWMaHIddRu0uhBOuOKDi
 aHYtZWVo+/nz0W8AgrEo9x201o52NKTKJnGIuf8XtnGHc09666Fwj2d4qYT3dU6eEju76bdkMDT
 ZSVRnK7s49QtTpiPmx7z3bFoi5StbjwcZkLjAqFSijUNwcpmZsnrEjJ8tXmH9SA1+e+13PoTHhj
 64SCJTHhWzNXe+0/yZH8vLnsiV7v6wr1X8mY1i1Iz7y1jj6DkNK69N9dFpfjALvC5EQmS2z7+Zj
 1XY3xIZdC/pVhqwv+005JQbPWShf+hfVofJOhU0EsQXS7t/msjkSXg2CYeCR0uJ+uQGYJ3OZJly
 p68lpusa0MRQWeCltIBRehfq+w8neA==
X-Proofpoint-GUID: Pm0FOLB_sQG4SYiWL86mMkTVBErkzaIJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

Add support for Gen5 x4 PCIe QMP PHY found on Glymur platform.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 95830dcfdec9b1f68fd55d1cc3c102985cfafcc1..fc67ee1e4a3c0c6f2ec23f51c09c3cc16df9aaf4 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -93,6 +93,12 @@ static const unsigned int pciephy_v6_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_PCS_POWER_DOWN_CONTROL,
 };
 
+static const unsigned int pciephy_v8_50_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_START_CTRL]		= QPHY_V8_50_PCS_START_CONTROL,
+	[QPHY_PCS_STATUS]		= QPHY_V8_50_PCS_STATUS1,
+	[QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V8_50_PCS_POWER_DOWN_CONTROL,
+};
+
 static const struct qmp_phy_init_tbl msm8998_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
@@ -2963,6 +2969,7 @@ struct qmp_pcie_offsets {
 	u16 rx2;
 	u16 txz;
 	u16 rxz;
+	u16 txrxz;
 	u16 ln_shrd;
 };
 
@@ -3229,6 +3236,12 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
 	.ln_shrd	= 0x8000,
 };
 
+static const struct qmp_pcie_offsets qmp_pcie_offsets_v8_50 = {
+	.serdes     = 0x8000,
+	.pcs        = 0x9000,
+	.txrxz      = 0xd000,
+};
+
 static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.lanes			= 1,
 
@@ -4258,6 +4271,22 @@ static const struct qmp_phy_cfg qmp_v6_gen4x4_pciephy_cfg = {
 	.phy_status             = PHYSTATUS_4_20,
 };
 
+static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_cfg = {
+	.lanes = 4,
+
+	.offsets        = &qmp_pcie_offsets_v8_50,
+
+	.reset_list     = sdm845_pciephy_reset_l,
+	.num_resets     = ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list      = sm8550_qmp_phy_vreg_l,
+	.num_vregs      = ARRAY_SIZE(sm8550_qmp_phy_vreg_l),
+
+	.regs           = pciephy_v8_50_regs_layout,
+
+	.pwrdn_ctrl     = SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status     = PHYSTATUS_4_20,
+};
+
 static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -5114,6 +5143,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
 	}, {
 		.compatible = "qcom,x1p42100-qmp-gen4x4-pcie-phy",
 		.data = &qmp_v6_gen4x4_pciephy_cfg,
+	}, {
+		.compatible = "qcom,glymur-qmp-gen5x4-pcie-phy",
+		.data = &glymur_qmp_gen5x4_pciephy_cfg,
 	},
 	{ },
 };

-- 
2.34.1


