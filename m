Return-Path: <linux-kernel+bounces-786029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD28B353C5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32992683F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECA92F6198;
	Tue, 26 Aug 2025 06:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RfX1684Y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6A2F0688
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756188195; cv=none; b=SzZxQOz8dMSLuAObhRrrPLvavouOtqoCyfgaZeMdI3LBQcoYHqN8kiHrm0K1Q82M6oUimesrr7RBDNgwWG36mBigECHTdr0li6vceA9qwAs0FbXGtFDCsxZ+iHcbm5Kx1PK9WIZ3fGs5Unckql23ykXKaiLnQr6yiFolDR4UE1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756188195; c=relaxed/simple;
	bh=IfziWFFf/H3XQBhEXCM0s6Mt9gHjDi0jKSu4C+l4gYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/VlHen0wkiOUssdTpYBObivY98nljFT3JGXveAXa8GCwjKF2/ocXjuR2SA+tF95C1+hjiHRn7AVvsx5y0S8ZKwyEVHAHMKoSnqFHPsqwKtSUBFaURXZurLor65CCowDw/KyY5otDhqyrdqcuTPpWCHTEt9ajYdj32TaibD+DSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RfX1684Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q0Wdjt028879
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sg6t04yvwJowULjFjnx5seEWqKEX3qeXoRM5EgMAPfM=; b=RfX1684YHo0HUMXY
	3av/bca5vg96oBKkIwkB5qmb2BdU28UrjVccqUJ/aqaBPKbKM7T2+TyoVQwq6A2S
	8f9l9fBSD4OQtYg9tAGyqZjp2AHlZ2oM85gzWPLTov2CCdkPDg/rQ5LA7rNZrtdU
	YuVcoz3HeumKuwRwGBA4xq5C/3hUdCdj6LmpUQxDVIilnIOyqho4vk75FYRw1MtP
	lS1WD6CzHJohmLqXi8ESLLP+pXRXNkaowHzARkjeziSzRbHNPsuQFFYlg/pKz5u1
	Ca4K37Mu9oR1Sust9aeOc23B2mfEFCrD3Y2MXMnZW5GlVZKKEzBkMZ+4D+grK+aF
	TuQ1rw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48s2eugrey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:03:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24458264c5aso57094645ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 23:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756188192; x=1756792992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sg6t04yvwJowULjFjnx5seEWqKEX3qeXoRM5EgMAPfM=;
        b=AC0RaxDKt/L+CjSqy4urnxSwVneS2zt5BTZkx7NzSzaKB4TwExdFDxQtaOt9udy12C
         D1vRzzfVDsoix7Bs04qzNd7GIUeCLjLFUPKSR43yxYB1SvSdz50UcrupX9J2/Yw9AVxO
         LsjXxthfZOne5M5uI8l32BRKAX074qkxqBD+lzE5g9UgpI4Itl+TTIMaLup9T6yUAZ1u
         7s7JIpPjBqmTysUjD+lcbsFgcn6S81EMkPwLTDX/Cah8QhhcRPSrQuyqXgxogKuZ8Sy/
         Y5DK8DnuAohCh3LFNpeR8x0TfsP9+LsLQOvh3VZloP9tH3iUgd32nqvvjG2KpVNwS/38
         7Lww==
X-Forwarded-Encrypted: i=1; AJvYcCXbempIa623zyfO35JzhGKx0qaJ+6fcw29eqNMN0J55PLgQhA4PHacIvUqBr/cuXqEJdrR41BqfLouVM+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXXVp4cRF+wVh7d+Brn8eQehk7K/I4dxF3kQc7r46VVqyvqyiR
	7WoI9O79H/xddSK1H39fv07+HCnBRM+sT7D0qa+g3efwNMxE3N8VL2QcO6lsw0d1agblYbmtzYX
	7QRb5p66YQE7o/u69rATST3RSafkXJ4t+0Mclq7KjAaS7kTO2LZuHO/b1QmcrEfLF9rI=
X-Gm-Gg: ASbGnculS44zAQeDeSHxiGl1R+Ok1cJuLyPK2tuEdoeYfCPK3UvrONwYiacTcBKQ00g
	TeihifW/zcGQ6Az09JxPl/+fvNHh6emm61Ravqm5uYUqFr8jKIsVOq2sveVEfgMj78PrCPv47xt
	vzJA2HfSqRLq5yXJqJ8JEGjtGu83ZGZDbpvJPMpAvp8ondzNL56u4VmcCifqWGUsi07LXAt9GWu
	t9zmSnuQ3uyaBgL/6HasvBsxUWSwFmSxSXl1DBM0AaMAP7iCV3W8IBsD8NZPPgiHgrsEZPq9xm6
	S+sPtPJLk9DFwTw6xh3MqRLZXQQa4pFHs6x7Sslq6zq2rJ4N8k0TKcOqgAvWpxYR3OoAIXU/usB
	KtQwlgz3kFo73bGI=
X-Received: by 2002:a17:903:38d0:b0:246:2e9:daaa with SMTP id d9443c01a7336-2462edd744bmr208899155ad.2.1756188192431;
        Mon, 25 Aug 2025 23:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiaCTpX91QHxe9LUTEkm6kd/z7vYyzcxIas2Vh9StaKSasNwJP5+pW6S4fOangHLfokQ0h1Q==
X-Received: by 2002:a17:903:38d0:b0:246:2e9:daaa with SMTP id d9443c01a7336-2462edd744bmr208898715ad.2.1756188191950;
        Mon, 25 Aug 2025 23:03:11 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668864431sm84989705ad.93.2025.08.25.23.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:03:11 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 23:01:50 -0700
Subject: [PATCH v3 4/4] phy: qcom: qmp-pcie: Add support for Glymur PCIe
 Gen5x4 PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-glymur_pcie5-v3-4-5c1d1730c16f@oss.qualcomm.com>
References: <20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com>
In-Reply-To: <20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756188184; l=2792;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=Nr0WsLxc/VUi4y8+iOUuwvKAT/kAkH+eKp93ndoPpzE=;
 b=IUeQDJcS0dNEhoUydBJ/BH9E2XHxLFHiVZroalqVWq/AMBSiil/8rq7ghXuNk5bZdyRNohUj3
 zH7iwApD2x4CZ+dNfxgFd4NhxSVSBGlfMIl9G/oSS4izoGfAJBLsfiT
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-ORIG-GUID: yBnv7u0xin9-AvBGh8yiAg72XPUx1U-9
X-Proofpoint-GUID: yBnv7u0xin9-AvBGh8yiAg72XPUx1U-9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDAwMSBTYWx0ZWRfX4eV0N53HA7OU
 BaRi9LA0tfxiCoOq+1YrC++lLcQA+NMV7hH80Ixz51Nkn1ulPBtv+8PZrKogDOjzFlw1dqhNw2H
 IrnywG5wQ6NA+cEpiP/LB/HxHYfDC8JMOiQDs7K9N2/ARA1QNrcR/zAOy3hoEY/jtP4fRJn2wym
 ZgOhCT5qx0iSWWbUJz0vO9LgVOl+BvtKi/Nd6lq3pB/ScuYXpjL3TQ0V4XieB9KzVQFbKV7Nhn2
 FDcM09JGOc1KxgY9aMgH3aQ72pcShDtSeoAmyrKeT5xp7f5AiaDxMhFSrxxCPo7Dcrmcsb4jZUD
 mRhSwyMgm4kU5u/LCGv0bbnRYRrfHTWN4wrXlBygwHKLUTC70J7odWJVji1XxvOJSxy5C/UXeP1
 Og4i4lII
X-Authority-Analysis: v=2.4 cv=PJUP+eqC c=1 sm=1 tr=0 ts=68ad4e21 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KvwrgBbZ-pJFRlqJlL4A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260001

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

Add support for Gen5 x4 PCIe QMP PHY found on Glymur platform.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 95830dcfdec9b1f68fd55d1cc3c102985cfafcc1..011687e6191e7a496b56cd85a149b10f7f00a749 100644
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
+	.vreg_list      = qmp_phy_vreg_l,
+	.num_vregs      = ARRAY_SIZE(qmp_phy_vreg_l),
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
@@ -5004,6 +5033,9 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 
 static const struct of_device_id qmp_pcie_of_match_table[] = {
 	{
+		.compatible = "qcom,glymur-qmp-gen5x4-pcie-phy",
+		.data = &glymur_qmp_gen5x4_pciephy_cfg,
+	}, {
 		.compatible = "qcom,ipq6018-qmp-pcie-phy",
 		.data = &ipq6018_pciephy_cfg,
 	}, {

-- 
2.34.1


