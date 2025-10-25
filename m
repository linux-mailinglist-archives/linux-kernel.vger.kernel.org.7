Return-Path: <linux-kernel+bounces-869670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BDBC08794
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA8F1892D57
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34501205AB6;
	Sat, 25 Oct 2025 00:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lL5oGDpx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116E21ADA4
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761353289; cv=none; b=j2nsE6cbxhDAMy81ka628Yajc6ps7b6iHKcL4C57GH9meBdKarAxUpDM8tsSHWSv+9RKnVCyeTYATa+CrCS/81NnCNlj8982G0FKYMdUZeQ7FXtNSls+0hr/2PJNJS3n1+vXNoAdQiY2JIkR0z2jOUZe/SBrtZuBugeb79IE1+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761353289; c=relaxed/simple;
	bh=tF1PKg0gpVnUDOaSR0Ha5ZI5tCr3ofcZX+C2E8ca+Mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u0N2xRMGUckhW7Jx7YTb9cdDXK7r7Lbx1UPf3q/mQNpWsgTx2MamTtPJFc32b0W/x6b4uHUIlUdNuChUyRofsjqJxYF47hPh3VNsWQjbcu6K2yEsEsBktVJKS1qil7D64FwdZFJdrLOMkzLSfNVnR0bWyGt73Bu8kQpeqlDVI4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lL5oGDpx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9IAo023510
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k8oG4EQNP2/pL0qf9RpPpGGPY53QZ1h0jexgQTcOkeE=; b=lL5oGDpxA16qiCac
	wNGQRRJIlfoeZB/qVVV9wcIvDvvDnfptinZmEE2LsoQtezOHyubaLpyAH9tjAOBn
	xJGAWDRiiXr0NXnFyDGqUnPzBbS/nH4h/Mf1VYQIqp1L5cqqVXjgX+gDELtAejUv
	/k2arafDgiftRCtZ1b5yTDIYC8SIdmgaX8i1LSmZCmeIrdsnLG1MCFZnhVz/u5TL
	4aS4N/qomLZ2NKB6Yjb5gLGiA2Uj7ZfgsysvhDVX3mUsM0oyRmqhNeTpRVJx4hdp
	HIGaUuYkKg8FIlVWY+djXVo858HgCE0a8otHN99riH/1yPWmWLGLunZ+oMzKe3ha
	jZxaDQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8que6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:48:05 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6cedb7bd41so2002610a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761353284; x=1761958084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8oG4EQNP2/pL0qf9RpPpGGPY53QZ1h0jexgQTcOkeE=;
        b=s8GVPValJOhpADgv4rEYIRt05GFFzqkZBtKeUyID+iKaDqEJXcX/S8Kogxy9XRGZZX
         Cl66zV5s8qMaS4vR6hQ77kX8vF11Cx6VbQ35SE8BLmV6U8/ZcuFvcT3yLG/ktgODBTsJ
         jHl58GtRw5eD4iwq3ukXPfXq4qgYk+0HQLdmFiiWIpcmWjEtM3+t2Q3KGCTS/F85dpo5
         aYAp3xhbFk4W1k3rSja/54efaUIJJvsHizCXEy0Gya1E98y9gryBsrh5ISOgOo2J6tJe
         +uyyMugssILRi7MSgVnPGfRpkh5e0udKmTNuQ9mvoirLA+clBLUTaT4oR3EXQY4Wf6bb
         8z9g==
X-Forwarded-Encrypted: i=1; AJvYcCXWhFKRp7mUoB6pMJlPhAHM4hB8SHyXefLsdbD+4PYq/+TNXaM9HOEaTxoV0xj3RHG9X3h0Icn/lbsaG/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8MtOWjusFLYQkmx8qOKcZcYMxAkDoA4XOg+SOefBea9Kr/HVA
	6paKFDcsNdrdVh1dORB+89U0OPlrAq84VvFcU4P02XkFRIeQlZoZinxfz7ixuqszXmX6Mg0uvnJ
	aDZ3xbggvywrYNqqJvrrVI/dm7cJJycKKmNGXdAZEwZa1q1MRdvBMO5LyFXCXaeOo2K4=
X-Gm-Gg: ASbGnctWIzXPuTM6lkBgSyHw6dV1UnZLdiYjGvmV0lFMiShNFG9GmR7nSumPsG5Ai77
	Wy85Jrotu6ibiRVM6O/JRhKOwvX6olrxitDl3WhJ5h8TQjQTxeidQra+FreRW/TYCvIXMVReAA9
	DUf48+OMqJK5g3FQLx1YSIq4S/EWlXMNMGsBinxiI2WnTUheAzVFFulCll36r0jZbINPX6ero5w
	L2nF2ul6B1lGHEHJWtYrLr9dncygwoHWz7Bg099Cje2pP6ZjaUC0x/wNZy22ycg0o4m4imKoUwD
	MNw9v66fRU1BYG5bTGjIMb1rx0lwlwitDrvlvVpDqKJC4Nh/GgDonfe3p0VUSP6s41qZTDjrE7j
	xXpaVstHQCOuzaUufpNFe8/xkq7ISmW5QzhFpTeCcB8hS5mZF9VA=
X-Received: by 2002:a17:90b:568e:b0:32e:64ed:c20a with SMTP id 98e67ed59e1d1-33fd35d04ffmr5853203a91.0.1761353284201;
        Fri, 24 Oct 2025 17:48:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqc5xz6vl3lPRZUr/8mpEL6KyqRF4IByb4Kn1ZI9uJZoawA567hyuExokyIfdFFmNS8DXPLA==
X-Received: by 2002:a17:90b:568e:b0:32e:64ed:c20a with SMTP id 98e67ed59e1d1-33fd35d04ffmr5853173a91.0.1761353283699;
        Fri, 24 Oct 2025 17:48:03 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed3eca8dsm167352a91.0.2025.10.24.17.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 17:48:02 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 17:47:45 -0700
Subject: [PATCH v6 7/8] phy: qualcomm: qmp-usb: Add support for Glymur USB
 UNI PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-glymur_usb-v6-7-471fa39ff857@oss.qualcomm.com>
References: <20251024-glymur_usb-v6-0-471fa39ff857@oss.qualcomm.com>
In-Reply-To: <20251024-glymur_usb-v6-0-471fa39ff857@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: MEuImWq1loJ66MiSOMqFlTOMk8lwhpkL
X-Proofpoint-GUID: MEuImWq1loJ66MiSOMqFlTOMk8lwhpkL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfXxhn53kDFOEBr
 l0FBAvAOZLIW48cBFrT6mlN/HqxlTkgzGvY8NIwhGzIswXiz36VHcr7otev7hCWSXhxi6OT5wBM
 kC69n7XZ3RAKOqAbP+me35X1RrnuPAIjpAHDfqarRZVbf5eiLBLyo2DRe9ZJudeyvri0BAxmLlR
 P9aAQqbSjkQsA3YUDzpGejBb7VbRM3QQvn70tVl0nY4RI5eToCFNIBw9s5EzSg6ImLnG/r2NFGk
 IMVUQkIhGwFsLOXqvUeITI62L3FMh3UVzbZkeh9ABrCCYSMjDzcp/KFvPDHpnFyBDW9CAL4DwMd
 sF669a+ofDamLAiFWi6jsKQok/Zj+DHyxHKpDCo9jd+3OM9MPDv2q/gbo6d+fMrRDpNzGAYvmnd
 pBaeaxEodKl7Z6HGoyyToQ5eFhahqA==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68fc1e45 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=bxfdmw13fxgBHIVlFAEA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164

Glymur contains a USB multiport controller which supports a QMP UNI PHY.
These ports do not have typeC capability, so it needs to be differentiated
in this manner.  Update the QMP PHY sequence required to bring up the UNI
PHY for Glymur.  The UNI PHY follows mostly the same register field
definitions as previous SoCs.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 163 ++++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index ed646a7e705b..d5e9ba783c5e 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -28,6 +28,7 @@
 #include "phy-qcom-qmp-pcs-usb-v5.h"
 #include "phy-qcom-qmp-pcs-usb-v6.h"
 #include "phy-qcom-qmp-pcs-usb-v7.h"
+#include "phy-qcom-qmp-pcs-usb-v8.h"
 
 #define PHY_INIT_COMPLETE_TIMEOUT		10000
 
@@ -109,6 +110,139 @@ static const unsigned int qmp_v7_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V7_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
 };
 
+static const struct qmp_phy_init_tbl glymur_usb3_uniphy_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SSC_STEP_SIZE1_MODE1, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SSC_STEP_SIZE2_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_CP_CTRL_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_CORECLK_DIV_MODE1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_LOCK_CMP1_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_LOCK_CMP2_MODE1, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DEC_START_MODE1, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DEC_START_MSB_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DIV_FRAC_START1_MODE1, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DIV_FRAC_START2_MODE1, 0x75),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DIV_FRAC_START3_MODE1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_HSCLK_SEL_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_VCO_TUNE1_MODE1, 0x25),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_VCO_TUNE2_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SSC_STEP_SIZE1_MODE0, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SSC_STEP_SIZE2_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_CP_CTRL_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_LOCK_CMP1_MODE0, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_LOCK_CMP2_MODE0, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DEC_START_MODE0, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DEC_START_MSB_MODE0, 0x00),
+
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DIV_FRAC_START2_MODE0, 0x75),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_DIV_FRAC_START3_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_VCO_TUNE1_MODE0, 0x25),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_VCO_TUNE2_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SSC_PER1, 0x62),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SSC_PER2, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SYSCLK_BUF_ENABLE, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_SYSCLK_EN_SEL, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_LOCK_CMP_CFG, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_VCO_TUNE_MAP, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_CORE_CLK_EN, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_CMN_CONFIG_1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_AUTO_GAIN_ADJ_CTRL_1, 0xb6),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_AUTO_GAIN_ADJ_CTRL_2, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_AUTO_GAIN_ADJ_CTRL_3, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V8_COM_ADDITIONAL_MISC, 0x0c),
+};
+
+static const struct qmp_phy_init_tbl glymur_usb3_uniphy_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_LOCK_DETECT_CONFIG1, 0xc4),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_LOCK_DETECT_CONFIG2, 0x89),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_REFGEN_REQ_CONFIG1, 0x21),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_RX_SIGDET_LVL, 0x55),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_CDR_RESET_TIME, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_ALIGN_DETECT_CONFIG1, 0xd4),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_ALIGN_DETECT_CONFIG2, 0x30),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_EQ_CONFIG5, 0x10),
+};
+
+static const struct qmp_phy_init_tbl glymur_usb3_uniphy_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_RES_CODE_LANE_TX, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_RES_CODE_LANE_RX, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_RES_CODE_LANE_OFFSET_TX, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_RES_CODE_LANE_OFFSET_RX, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_LANE_MODE_1, 0xf5),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_LANE_MODE_3, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_LANE_MODE_4, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_LANE_MODE_5, 0x5f),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V8_TX_PI_QEC_CTRL, 0x21),
+};
+
+static const struct qmp_phy_init_tbl glymur_usb3_uniphy_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_FO_GAIN, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_SO_GAIN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_SB2_THRESH1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_SB2_GAIN1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_UCDR_SB2_GAIN2, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_AUX_DATA_TCOARSE_TFINE, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_VGA_CAL_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_GM_CAL, 0x1b),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_IDAC_TSETTLE_LOW, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x27),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_SIGDET_ENABLES, 0x0c),
+
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_00_LOW, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_00_HIGH, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_00_HIGH3, 0xdf),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_00_HIGH4, 0xed),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_01_LOW, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_01_HIGH, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_01_HIGH2, 0x91),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_01_HIGH3, 0xb7),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_RX_MODE_01_HIGH4, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_DFE_EN_TIMER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_DCC_CTRL1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_VTH_CODE, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_SIGDET_CAL_CTRL1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V8_RX_SIGDET_CAL_TRIM, 0x08),
+};
+
+static const struct qmp_phy_init_tbl glymur_usb3_uniphy_pcs_usb_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_USB_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_USB_RXEQTRAINING_DFE_TIME_S2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_USB_RXEQTRAINING_WAIT_TIME, 0x75),
+	QMP_PHY_INIT_CFG(QPHY_V8_PCS_USB_RCVR_DTCT_DLY_U3_L, 0x40),
+};
+
 static const struct qmp_phy_init_tbl ipq9574_usb3_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x1a),
 	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x08),
@@ -1403,6 +1537,14 @@ static const struct qmp_usb_offsets qmp_usb_offsets_v7 = {
 	.rx		= 0x1000,
 };
 
+static const struct qmp_usb_offsets qmp_usb_offsets_v8 = {
+	.serdes		= 0,
+	.pcs		= 0x0400,
+	.pcs_usb	= 0x1200,
+	.tx		= 0x0e00,
+	.rx		= 0x1000,
+};
+
 static const struct qmp_phy_cfg ipq6018_usb3phy_cfg = {
 	.offsets		= &qmp_usb_offsets_v3,
 
@@ -1704,6 +1846,24 @@ static const struct qmp_phy_cfg x1e80100_usb3_uniphy_cfg = {
 	.regs			= qmp_v7_usb3phy_regs_layout,
 };
 
+static const struct qmp_phy_cfg glymur_usb3_uniphy_cfg = {
+	.offsets		= &qmp_usb_offsets_v8,
+
+	.serdes_tbl		= glymur_usb3_uniphy_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(glymur_usb3_uniphy_serdes_tbl),
+	.tx_tbl			= glymur_usb3_uniphy_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(glymur_usb3_uniphy_tx_tbl),
+	.rx_tbl			= glymur_usb3_uniphy_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(glymur_usb3_uniphy_rx_tbl),
+	.pcs_tbl		= glymur_usb3_uniphy_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(glymur_usb3_uniphy_pcs_tbl),
+	.pcs_usb_tbl		= glymur_usb3_uniphy_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(glymur_usb3_uniphy_pcs_usb_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v7_usb3phy_regs_layout,
+};
+
 static int qmp_usb_serdes_init(struct qmp_usb *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -2302,6 +2462,9 @@ static int qmp_usb_probe(struct platform_device *pdev)
 
 static const struct of_device_id qmp_usb_of_match_table[] = {
 	{
+		.compatible = "qcom,glymur-qmp-usb3-uni-phy",
+		.data = &glymur_usb3_uniphy_cfg,
+	}, {
 		.compatible = "qcom,ipq5424-qmp-usb3-phy",
 		.data = &ipq9574_usb3phy_cfg,
 	}, {

-- 
2.34.1


