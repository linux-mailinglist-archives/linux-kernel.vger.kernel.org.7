Return-Path: <linux-kernel+bounces-800003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A14B43256
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91838567CC6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB9E2641C6;
	Thu,  4 Sep 2025 06:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UvCwlHKr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1454270569
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967004; cv=none; b=numE5p3ndshHjH/OoqCpcCJbfObGDARszIM8eyd1E7QmQrvUzb1909X5yRg+PPwRCd3Su0xSlHP5r0PkeUY2L5fKr86cl3Nzmb2v85trYypad3fNSPb1BFdC8sP8rZcKiG5uVuS994bFfspHE/gSpWZxlMc3F53qn6JLmlm0MJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967004; c=relaxed/simple;
	bh=gf0nDTfu/A6wTAQjMH+keGPa2RXck8NCBn62CulO27A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ld9uDLfu1tDwSjSXAv2KO5o/u7nr1yN6ASd+9jXabUunaqX0ChK6TqiPxUbqV1zmcWZF8dyiKXtzfr5eee5QlPxSMxJys0AcVgmLKKlQx6ptYqzdl7ssPJGeEAx7TxrBUuys/jNeNF/QDmejSDToO4uKwILrKztWFOidLzAOaFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UvCwlHKr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5840evHK021993
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 06:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FH2W+hNthlwsjcU6LhQutSm9G0ruDj/xBkaCmXCbKhQ=; b=UvCwlHKrrv74UuvK
	sc7yG6NP9KiKG4SjoeMT+PPHbKwK0bs7K8T/gyogI1836D12a40VHNkNJl/yOK9o
	MMUUVlyvfmvgET0J5FLPc9nHOhrvjYPPy/UeKHgcdpjPgzRmQwqCulW5Di+Isf4H
	GTXgUWgwGLrIxAMgoniYxUoxijVhK2w5xo1+bhvZamlYO90EXA1vRRY+rx7f60qG
	XjF1qHxFsBiOvGiBPwSnQ4EzuIt4ffniyo5UhReJcTClwbhpf/GaK1DwHdomobOo
	2KBFpZCp/We9ktiw6ASZFhzagSRyLX8BzpZaxio04JxH0XGoB/ModrenhA0JRO2J
	CwE8Rw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fp9pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:23:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24457f59889so7224975ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756967001; x=1757571801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FH2W+hNthlwsjcU6LhQutSm9G0ruDj/xBkaCmXCbKhQ=;
        b=qq4kTb+zpcUkIJjyGO5wMt7CdAD/yFN1FBD2tNAtdsSvoInOSPT/9wv1BuPCknWL2E
         NwCy5+FarrOYp5mdEH0WNI+EMFtMxPejBdYe8x/SeOIbCs10+ditWaYyKRnRPYt6RkGh
         CA7PqAQgBixvJ5mJmTrhh5EzxWfDm2HlWzxqYuWBiqaQUPS/wfvQujaWAeyjLyRfdIJo
         gJ7Vp+GDimxmf0nHUz4VIcj6txpMCblTb0LlXFx8Fqw47C3IsK7zJMUP1TlfuHrTWVCv
         SE5V9WQGjNQvMz8MvW6xutBheHR5H+BCtConHEA4lstUtgbWVsx4C6TrnqhyeyxpSz4y
         Js6g==
X-Forwarded-Encrypted: i=1; AJvYcCXYNBDO3ZbPhQU0jpsvyNUpJDTFjwaYy6RbYPESSPWe1L3K2XAO/KywsBsNHOYrFvSegU+GZ3aO9sC0MDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJ57OQPhZeLFH3iGPluopADPQpI12/y/zc2A6vPFcDYuAOWGc
	qf3uXSA3pRGBkGvuOQaNHktdUCKIMrpRPyCzkIHi3kxWQ5zyL/NmvxFchRbnofQnXl+i4ZpSuDH
	h16OL9Fzh8EYvYN4uVmP4N6efYYHY3A2eVtZxp1cGN4hfFSMNeOZfpBjuNgYGu/GPK8A=
X-Gm-Gg: ASbGncvdOfeP/WKzkC0cakNg7A9dT4bEqXxO2CWyd7BAjL1jeQ0Em05JZhHi4Ggij+K
	J71ivlUg73NvxKuSu8nsiZa7o00qWfxfjhoFqgbJv+dCTyxZ4frmvyowUcjvhkQ5AUhRUXi54vD
	/wrrsIF20u+BlRBPt0V4l79CDwxbpnQkoPtGTSfT49x2iELgg6MtMKk3JC7HRuIo+8uoiFvjfes
	+4hZO/ltAK/GhYGJji6fejw0vknNhQR/cpvtiUJ2EwWuGeBFt3rc7/BHHgTQirAG58yZ/VmAKFF
	CUysPbClcQy4q7VT5+42TpjQDBkdBde2mMP4GTnNCCxrgsPfV5BvpHYW2HzvWMOK5UAZ1Tb87QI
	nfwigdxZi8RX2TsM=
X-Received: by 2002:a17:90b:5190:b0:31e:d4e3:4002 with SMTP id 98e67ed59e1d1-32815411d3emr21146322a91.2.1756967001302;
        Wed, 03 Sep 2025 23:23:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwUeM+ClagutolDofBUjVohRmTJoK3OIjZuYPW7td4JSGTMamC9aTtqyQQ14+pL8kEkZeDvg==
X-Received: by 2002:a17:90b:5190:b0:31e:d4e3:4002 with SMTP id 98e67ed59e1d1-32815411d3emr21146296a91.2.1756967000826;
        Wed, 03 Sep 2025 23:23:20 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723427c127sm17120911b3a.62.2025.09.03.23.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:23:20 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 23:22:05 -0700
Subject: [PATCH v4 4/4] phy: qcom: qmp-pcie: Add support for Glymur PCIe
 Gen5x4 PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-glymur_pcie5-v4-4-c187c2d9d3bd@oss.qualcomm.com>
References: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
In-Reply-To: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756966993; l=2876;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=Ruwm7lGDShLRO8c1+C0WfHCrP5dAWvWnDGg5quqL960=;
 b=2lXngGqEWRqYeQyiji0BInBdRc6hNVgLNCDjYXB1c6Be4DQSZfE/62DPSDg+OUwWE15axu8Ac
 p5ibZeXiY5ZBhJz4vFvXf8AymX4ADH/zZZ2wdDz3AJKl9bPmMenfHF+
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX8uWi2Zj/14Br
 dSCKlbUU17ZiBhcRAZeN8lI0H8lZyaMPb7RJsu9ln+qtzVXEVCh3kZga+CkXEflZVc4LGrPQDUO
 ApFiCjCj+oLtznCThc9DQEF7176yxLPdx8qAS8MW0axrzmPHVsAc9hmJFRAWzWi1aA8cezWCYbT
 YdN2uRcJUgc6+6pNEG8RlaqlG4K+X99+pkG9LY+17xv6g1v8TC37sldGtyVIP9/uJ+b9P/ZCHPn
 j3P67R6A5yIEmgh0r/58OUjSktyiMiNuBqoBKGa0WH9JYIRUXuL7JzUoUygbT3fIeOzVo2bUatK
 42H4klkrjr2lm7XZ/eiJ1C5T3QaJ58WQsSmmJARnXRRe4H18jPLYp2h9pNJVxuDhRHGFxP9FNp7
 NIhwzii5
X-Proofpoint-ORIG-GUID: 5y81UsBCVu9AT7r3PTzORtZpiACfwLEt
X-Proofpoint-GUID: 5y81UsBCVu9AT7r3PTzORtZpiACfwLEt
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b9305a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=KvwrgBbZ-pJFRlqJlL4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

Add support for Gen5 x4 PCIe QMP PHY found on Glymur platform.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 8fdc146ef73221392371c00afb21d673dbf46d49..dc741fa8900a3a89c88fa51aea13fb912347915b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -100,6 +100,12 @@ static const unsigned int pciephy_v7_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V7_PCS_POWER_DOWN_CONTROL,
 };
 
+static const unsigned int pciephy_v8_50_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_START_CTRL]		= QPHY_V8_50_PCS_START_CONTROL,
+	[QPHY_PCS_STATUS]		= QPHY_V8_50_PCS_STATUS1,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V8_50_PCS_POWER_DOWN_CONTROL,
+};
+
 static const struct qmp_phy_init_tbl msm8998_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
 	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
@@ -3072,6 +3078,7 @@ struct qmp_pcie_offsets {
 	u16 rx2;
 	u16 txz;
 	u16 rxz;
+	u16 txrxz;
 	u16 ln_shrd;
 };
 
@@ -3348,6 +3355,12 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
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
 
@@ -4404,6 +4417,22 @@ static const struct qmp_phy_cfg qmp_v6_gen4x4_pciephy_cfg = {
 	.phy_status             = PHYSTATUS_4_20,
 };
 
+static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_cfg = {
+	.lanes = 4,
+
+	.offsets		= &qmp_pcie_offsets_v8_50,
+
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+
+	.regs			= pciephy_v8_50_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS_4_20,
+};
+
 static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -5150,6 +5179,9 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 
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


