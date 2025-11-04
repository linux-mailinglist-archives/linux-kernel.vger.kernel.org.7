Return-Path: <linux-kernel+bounces-884249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A667FC2FBC5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF93018998EE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA94311C3B;
	Tue,  4 Nov 2025 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ux5VKHro";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MIA2Rwx+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393C3112B4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762242995; cv=none; b=oR40XxUvL+cY4UH+qePycJXY4oFG/bOtOIKqObeSnc5rFWagf4mYR4hTvX7Y+tdnKdHns5AajN68j/YbRRqltFHe6cvfmvhZ0ySMkOU/KuenVH1mDrrYY5L9tLdlEBNtHJCharS4Zr/982Np0mmhayVAmkbnM0IzYDXosVRpizo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762242995; c=relaxed/simple;
	bh=zt/h1GPrcku6VfCD1Z2xF2fCFX7fT2M31PCFfCnbMWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GzDS6fVQW6on2F3ABqap/y7C7F4QlspZWxqMad38/NloMimGJLrejGukY0TTrbMgdmDzR5dmSlHLh5qlbIdHJCAL7sT4upbdsiSqMcAezOAlePs9J/Ef2qXmSAw/2qzEL+DNPGc0k3q6kigSYYqBkF3XWwh8tA8dffJ2rg0o3Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ux5VKHro; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MIA2Rwx+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A433Gww3616991
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 07:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	36rRRJsb8die6TTtLLHxpI3oG8UeacOGLRFgDPbnS9E=; b=Ux5VKHrowjSzFGVd
	8RbnKGrH08ze39srzgQOVAcXVsirjiq6VDbXmFF2rqFkSGxt7MMo3BYnTpSFA4Sj
	FSeDGlzAAYALT6nxLzNV05F1TNs2Uim/sr0tEmVya9ZuQlL3Tx+For52DVUvl4I8
	ZRavsHyaC9O61y31OY3zNSRL/6y9ws0qMbOfO8XpCHXB0AN1WPGP9bJqMUgjiJTI
	l4VFumi09iGGPFK19wqLVjJcNvOCDVfXBdPENht9MF0KTMcz3sMiWhVrtqttxYKG
	0VnxJdvvfwFyUiPNizxTMMTt20zuUmIpzPTeZZCZL8cjg3ZtCJN7ZehgHjmXYZzS
	Dvz5nA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70fht4t4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 07:56:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3405c46a22eso5549081a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 23:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762242992; x=1762847792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36rRRJsb8die6TTtLLHxpI3oG8UeacOGLRFgDPbnS9E=;
        b=MIA2Rwx+zZ7DdxTpD9lMCKevZt3ruRFYLoynlpBO8l14Ns3SvoJrQLV9qnTW3Sm0G9
         hfEDFXTIVP3/EdbZ6DaH1pCrOc7UdARpKR0uzed3hUa5HcJQzGj6vIIJYCKq9ts7c+8n
         lieF8FE3nTZPRsu8wNaHB6s53iR4l6WUgNgzERJyqMBYZGbrWpLvmsRF/lWsmv/b5ufD
         V4EswxIl6Ita8ffvqsizip6GY1pf0ea78UK8+10rAJItb1LIkKH4dGkdXJNsRHgFMLI9
         VQ/6gPhADIHXRCb6fTsK55E2d89dKM+3KufufsPvEtwXJWJFJj2AobFGltfVrPxmt65z
         e2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762242992; x=1762847792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36rRRJsb8die6TTtLLHxpI3oG8UeacOGLRFgDPbnS9E=;
        b=kOin1jarAseb2cHNrR5Ha/ws5md7oOPq2UUXcAlR2kj9cCl72b3/qD5dOi4DKPiwfk
         x/eiaNasfS09fTWGNppXZ+pGQz98Iu7vMK7Pdw/MAesBfyY4PMuWkwCuMD5+jrLjU9RV
         wDReRiX1Qmp/+GJ4ocb1TR6RxNk63CRF2csWBb6oOFyTHxmhH6Kato7Ml3zI/2eQ+1J8
         2I/k3eRmtvh0VVEzidmaGVe4rFD5tqKFTH9sZQ4IPK7sczoU5xNBfylVUeaiANrhMrYC
         fp+17uqRB4qFudbWd0HoR0KSTzfhRxx1hTnyyyTpT9mg6LzSxhwOtOriVolStKx1MJlE
         0SqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaRo/h90xLlVVOu6vKx2XG38Xe9CEH1BR0C3N1AnNFllVu8BdOAb8KwsbZa1hdYqyWbOCgMpqtCBWmQ3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOojO9h0qxzBOXS3dCISJ4Xla3DZV1jrexPG+srXHdmn3wVoIx
	p5NKYVEy+ApwfRVdNdiAgwdIipO+lNlaJfypt2ii1zbgV0Q9l7YP1YzxjnzEWYa5h8SFj5GJ5rZ
	xxf83Xm7oeEvveVhnSvqIQFXaax1mSOFbegTGnrUuGVxlDaP/PIMmBQaMVyoiH01pmP4=
X-Gm-Gg: ASbGnctQ3pyB6QHwZ3w0umbddQBIc63T1NvvBsJrDS/CqRkQ9+J/i5X079cs2L3wAq2
	1kg+g8n0HflQ/CDgM9jRnEb/0+D4qWAtNC0uxcpn38gByYRTNOw49TJISbGODyEPFseq6b2u8dk
	PcCv7Anp25cbHiIxwK00lvUSCoJnr9KDEqTipeVE5rWaqP4rqTlecyYWWfEhXrdmRftAr8z8B/S
	IKXHko3iMKmU/5GTcWeURak6ynANpYZ0XiRGj1HDRLLspF7gijwHLlrs9Ldqmy00m1/2D8BtpJz
	5HH/B3DFQvlqy038HTgVzvsWEZPn+SqOvgD/3oCLaydINI8iIJHuefoRSXmBs8ca84ryH5ytYak
	GZlOO7jpqQLM+6kpbBCNtUA0wefzp0qkiWdDdzSXcjwhpEA==
X-Received: by 2002:a17:90b:3891:b0:340:c179:365a with SMTP id 98e67ed59e1d1-340c179451amr14114075a91.0.1762242992040;
        Mon, 03 Nov 2025 23:56:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETspjX1zfLO79dug+X80CLuKL5y0H5UZzcdJuKRXhbJn8V/01XyYLjgtnScFuA8LhmepwgcA==
X-Received: by 2002:a17:90b:3891:b0:340:c179:365a with SMTP id 98e67ed59e1d1-340c179451amr14114038a91.0.1762242991380;
        Mon, 03 Nov 2025 23:56:31 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a16652sm3627951a91.20.2025.11.03.23.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 23:56:31 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Mon, 03 Nov 2025 23:56:26 -0800
Subject: [PATCH v6 3/3] phy: qcom: qmp-pcie: Add support for Glymur PCIe
 Gen5x4 PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-glymur-pcie-upstream-v6-3-18a5e0a538dc@oss.qualcomm.com>
References: <20251103-glymur-pcie-upstream-v6-0-18a5e0a538dc@oss.qualcomm.com>
In-Reply-To: <20251103-glymur-pcie-upstream-v6-0-18a5e0a538dc@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762242987; l=2929;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=3I4+Hh02UK/6hCXFAJiGGjbIJsRvaSQpVywV9Q7zV1c=;
 b=Yy0wCNKoMhHH5+bQwNBM44G+N0KLCCONobdst6FmOH8rDTGtsbP9m10SSMTJLjzkyWK7f3zOv
 ljg3VAf21cLByVHntHv+oCK2C7W0VY280ExOKcxYAjx+vJ8KHssX0cZ
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2NCBTYWx0ZWRfXzXT7lsseepPn
 rfBOo5J9ikpmky27NTOeGLonIsbBumN3f74fyx12Pkc4KzaRfJfFgYSqMm4CpB2OvluHngIKSqs
 UgcuNY5QD3/j3UX3liQEYLV2Y8PJ8MOsAYJrwgKgUbrqQLQKDhl89u4PvdZz1PBLeSa5ynwlxGE
 bauLe1lXk2zXkbEZielir+weQzfgiE5Kts4S2KY8OaHtYJr0vWEy0o1LBj2El0y/f4Yg4z776p/
 maOF3vkhNzloCKOhENuqJyoKsJGWHk7h+wwm3fZnOeuhULjVefP3KCMVvsCDUydNqXDy2I4znN2
 c2yVyREbxqO4f4XVRLdTVTlB7HnbDUvC0ERhFwW0DXDvZGSetYmmafM5EAQ5F3+e4jhf2yVv6sf
 oXe+Z+eaI9+ThMpW1pZmNj9bjW9ltA==
X-Proofpoint-ORIG-GUID: gfp-spuFSXEVS2wnsB7XfAA3VLaNU6D0
X-Authority-Analysis: v=2.4 cv=CbsFJbrl c=1 sm=1 tr=0 ts=6909b1b0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=cXB1dxBGfnZZ65A63A0A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: gfp-spuFSXEVS2wnsB7XfAA3VLaNU6D0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040064

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

Add support for Gen5 x4 PCIe QMP PHY found on Glymur platform.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 62b1c845b6275d924fa501ac64e69db5f58844aa..86b1b7e2da86a8675e3e48e90b782afb21cafd77 100644
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
 
@@ -3356,6 +3363,12 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
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
 
@@ -4412,6 +4425,22 @@ static const struct qmp_phy_cfg qmp_v6_gen4x4_pciephy_cfg = {
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
@@ -5163,6 +5192,9 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 
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


