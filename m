Return-Path: <linux-kernel+bounces-775343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2AEB2BE2D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0201B61D18
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D38321433;
	Tue, 19 Aug 2025 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WxLe+u3Y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC88321430
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597174; cv=none; b=lgpiH8sNvCvT72JGHZFIRXYzNS3LJIQUlWYrIrYCgsZd+kYi1xBpiPt25xq1mnUMp6l8Rb0D7mSSscm7zMjHCVGpUJfH+3R0QYQoo9zFGKfOUq6U7aHGUbxhAtFqIpumgNrHSXoLRWPBcMxzqPBN844lq8syFw3fRHnX1lRN1/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597174; c=relaxed/simple;
	bh=XbC/EhKIPbWgAx5xtCXs15Izpyh+QjiCFb5aWinn93k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7AMwxjENCBnGit5R79qIlItUng5Wlwi1N8jS90OEV/QAy9rRdDayU/cM+QzP9AusAghYOb7aBT4KJ7lwSgUylRhJZ2SaHIne0yBqEGWKRT6/95O8dwmHT97+M7G/eTZTzqkvFLSWfMfaBkQKILXmzZoomCdMNiqBPWQu3c/9Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WxLe+u3Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90iCQ021904
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZXdUtQNXJ2hesfvhNvI/OWy7YCjNNYfGl5bsLwFo4PQ=; b=WxLe+u3YzcryvC+U
	6hBambZ+jwevUrQjnFGvbMsmUWo5fF82NysSjIDSRMKtM+4i2ZEGvuLG2g/LNkRE
	V8im4WQf0tG7EBStZmOLzapDhH+C8xqSMOGvdai2EUVZN+pCjKLatlPm8BoE/kwf
	bZ5AaMn3s8qSGuvgivOjk866wHVjGv01Wo77tAWdBpx2rt2LFSGxPT8n8IMBc23l
	7Z5M2Jd62WJ8JR/9MqV/NBgQh/lwK7pDBHuOjX/UGUCopZTmREpIkPL8I3JuTveA
	I8nTPLVdi/aFVvbBYxf0l/oiTNK/2ic/2EGF1WPNAAQlo6SRgvE3aoCgf7XRkH4B
	/hxeiQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m71cjsnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:52:51 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2e5c4734so5019125b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597171; x=1756201971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXdUtQNXJ2hesfvhNvI/OWy7YCjNNYfGl5bsLwFo4PQ=;
        b=qvqfdFOsRNXn00vX8Lk+ki7wPr/eWWcHKXo40MNWcKXsFpoAQb6Q9oae2h8Cfn0sM5
         4Aj5cloWxMPKsyeaKGmnfN/SBoqpWKTR8hJ8KgncLKs1+So5w6UbEtQ1ecOzrkf7ZoTJ
         L1yyp0xZ/LH5L1SCaclZ4ws9PsnmLqjGFq6i3J0ybjiglCEeKtte8iUu0IuHOwWNXEcq
         bnZqz7jLQpiOs5byeJGFqyryYrgBo/7bL8oEKEeg+TTeZUH70KZOd4ifpiI2vzP6RQhD
         +PXRk1VLr+jeWNfVWXJvsXhM3irxZOyA9it9fZbhIxunhoWRuDuA8VPLsz0pmRNfN+Th
         5Mag==
X-Forwarded-Encrypted: i=1; AJvYcCXBSBbcYaC2fhvZQ/sKkJSxbmmuac6TCM3QQ5kEU4GMuS71n3QgL5CYynRSMWdV1ohtZohRyBJ2QhIGKE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2RoAae9564gOr72aWnUULLx/w7WmpDTtTFrrvBWSznqQykY3w
	sEUsa1nyeQlgTDpbdklSzjbqloPwYhytQ4m9X+2pI6NDjyeAtJCLNbL4tc0R3jnRXu0g/zgJ7Ak
	FK0uJ7m4SUxgNmWlcI5ISQRSHLFn34C296IIba2RftqwjVh0Ht64cJq6TYk0Vn5uBatk=
X-Gm-Gg: ASbGncswIaqSg7+kWsBoA3Mx9Xd4KZpFm2mz2MFGoSMb/c67ODPFxo+pcAbty4AwMlu
	2P1n/MJh++Xji2ldTWLkDDY9zULnZtuBP1IZWc0Se99OeEDOvwG+HLZ5zSNN1Ao0SKKDWl2tltj
	NnWZWKt4/l+ZgD6Y0rPO8CWXrY4mKrtMknJHT3OlgtYhz9pDBtrH6V1l7enObqiRHVvvrR17U0b
	MIe7NuQYzu3mI/by6c847nzh8BeHga0wUFMlm6S8OKK6o8hQNkXDz5nqA9dyCy6HeYpI6EEqBcU
	PGfvzVjuzqJkke1b0fPy6yHylZYOyweHQmaImRFiCJMa6q9O7TihBinV5UE+YnDhG0n4r+3Bcq/
	S3LnLwPLm/2kPvhY=
X-Received: by 2002:a05:6a00:1893:b0:748:e9e4:d970 with SMTP id d2e1a72fcca58-76e80e746a8mr2218638b3a.1.1755597170756;
        Tue, 19 Aug 2025 02:52:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf4aRpNKR1aJRW4hTTUipwhih4soPt+VU7Faus3psEcWXtA92FJ5i400YWIWNJxAKyarm4MA==
X-Received: by 2002:a05:6a00:1893:b0:748:e9e4:d970 with SMTP id d2e1a72fcca58-76e80e746a8mr2218594b3a.1.1755597170275;
        Tue, 19 Aug 2025 02:52:50 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f7cf7sm1998291b3a.69.2025.08.19.02.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:52:49 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 02:52:08 -0700
Subject: [PATCH 4/4] phy: qcom: qmp-pcie: Add support for Glymur PCIe
 Gen5x4 PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-glymur_pcie5-v1-4-2ea09f83cbb0@oss.qualcomm.com>
References: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
In-Reply-To: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755597163; l=2597;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=IjDSUOkDbzgxEeCC7x7bThrq8X7KAnHKc7YQ1oYlFq8=;
 b=+Yimf78LSPEQGi1dy/kn7GxcxX38qdkUzPgyA+eTTvwfToKLPMpvQ4zApWicSQZq7xwZZVLFx
 M1Nj5OfoxLyAau0VpucdXkSVo4mO9wu4SzVDBKYbvItORaLJRe29M/u
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-ORIG-GUID: DvvJMAJ85c_14UocCa3b-Gu6lGW-R47E
X-Proofpoint-GUID: DvvJMAJ85c_14UocCa3b-Gu6lGW-R47E
X-Authority-Analysis: v=2.4 cv=IvQecK/g c=1 sm=1 tr=0 ts=68a44973 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KvwrgBbZ-pJFRlqJlL4A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0NyBTYWx0ZWRfX5ZuKxO55WSLo
 qRzrnOCyRrVcRsCZoSo/x5a0WNvmHwaoGZMxGZcXMtNnQ0CHqpP5htuIPwm+nJLJYH8Bf6A3Ujw
 GxigpJtGKjNj3DMZW8La2hLnGNvbnjHbb7DdE0U0VZb/jaqxqWyKeW8QfhlIePI335v/XRIH2ds
 cZC1uv6+TspmvyWtCcffyi7ry+GG8RSeick3gWOm1Xw4VXOzjZrq0ehdFfuNCA0cKeBry9EwKzj
 fLOp6E5ZIJ0lBRLfRH4c3xmOKsWIJBj0ex7F14MgpKikmuAMZdKUahb+n/egz2GceJi3kjZ6L3V
 +t+9Hemcmvl8cOVmlBC77ttzOWvC1mqwo+reEgAZeTvMV3i/+O5H2cI9Zw4na95Dm6iFXTSMFps
 tg7aQ8kr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180147

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

Add support for Gen5 x4 PCIe QMP PHY found on Glymur platform.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 95830dcfdec9b1f68fd55d1cc3c102985cfafcc1..e422cf6932d261074ed3419ed8806e9ed212c26c 100644
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
@@ -3229,6 +3235,10 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
 	.ln_shrd	= 0x8000,
 };
 
+static const struct qmp_pcie_offsets qmp_pcie_offsets_v8_50 = {
+	.pcs        = 0x9000,
+};
+
 static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
 	.lanes			= 1,
 
@@ -4258,6 +4268,22 @@ static const struct qmp_phy_cfg qmp_v6_gen4x4_pciephy_cfg = {
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
@@ -5114,6 +5140,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
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


