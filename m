Return-Path: <linux-kernel+bounces-839575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9772BB1F12
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5695A189E325
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57113148D4;
	Wed,  1 Oct 2025 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IjfEFwRT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7274F313E20
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356357; cv=none; b=DLPUZgd/tuWbCV9AWa3KxB6doSYnOSy81zdPVuoPF2TDcpW98Xvnokhg6dkKnMZl6pRJ/Z4z/qPbp+UTtaan8JRSiPflRoAlS6rvyI9YWi0rRmvR1IJS2TuZEgIWa7lnu8kz9ozsWXy3T0Rt/lKcpUrlm4q3AXbIT+IDs1EWhEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356357; c=relaxed/simple;
	bh=BOVBLougKlpnye+jKwZlG3a8UhNzQJaB8Y0LF9G/DUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B5cRd+r2Wlo2T3fOFK+CdSE66+DkQtMkFivtqPqmyi5s6gm6LZ++mTVPTVTzFkAGjmsIzkYdqAdFxsr4Wj+QwfvnZVadCWUF/7QOHSsoTbPM+DkZEe/dQRinDmomD4BtUYroLOe3AmsLxJAWkQ2oIumiz5YnR9HW7pgWsKXdJP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IjfEFwRT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcE6T018009
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 22:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TmQ/hwHvfjn
	VMR9ZqSBQsA5zywfc7f8XvM0GNdLOBXI=; b=IjfEFwRTAp9xMe+oTdx+TVpZUjj
	16uLMXaB0P40gDnEJXnO6kbBeIZmqM18xcQho4F8SV/p1jVrBv9x4yhx1mcrdMUP
	WFOe8nqOMQQEt6osRalxvekM/G6af60kjzx7pU1hYyFkAgSw6YfaK/CY2PRvHoe4
	rR3Nq3EJN2hcyJ5a7nq38oWJvjNyzndf83YYSJ0De78ARhxEujSNT7iwQ8nfkScm
	ArsusT3ea/LgvMdUGmNsNW/AEigj/7ixTmug9ra+eOVwcpdivoxp6lYeHlufJRZO
	wfz8IstwubG85A4tU2KTc6tCzg7Ou3mJ+ba+mw7bflPzY/FD04DQarCXUZA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fyrf7hbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:05:54 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b5a013bc46dso231464a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 15:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759356349; x=1759961149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmQ/hwHvfjnVMR9ZqSBQsA5zywfc7f8XvM0GNdLOBXI=;
        b=LWbIexJLnWPgDagvgFrMCEM+ioIjh3auxTZNXyZUk22kgr6zvA33NCKgg2GihdLpK7
         WKRnJYL1WXwTdr6UohhV7dY/pn533JKItk48JeLW4/RPVPO33Hp49rh5xNuml+rc9Jdc
         j5JxeL2jfregfutKZoBAforzRAhjtt4JqJ1Wx+DGwlQlb0rZ4D2CCTyTBygIMZI39WSF
         lmiZcD+9pR1X9SavDe5QQGtR01AKcsDbvPgXGFA54306M9Cm9NWZ1GPSCwfe8J7XC+I9
         xSYU58paccuz310BVyGCGMI5tWr78uKcoSOKT23p16w6LSx5kByoEj+JzCHc5c5/Eu1E
         UYdw==
X-Forwarded-Encrypted: i=1; AJvYcCUcMxm5/FJ8T0KSRgaUQnbS4YAfYZl8ozhIqQC2cl/QbyEnW18nzGqIKOGgyQdPLgbJEr4AttIk5CfIkYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+vGeUOH1f+/Itio30sCMdDYmaCocP9SGDHPn5+gLwaN/iPCT7
	ph8d2xt8IsGhZZ9ilZ+QJJdKz3l8Jq13ZlMFIMrqE+GNWvaq/UQcfGKb9mNoIFA35zo/X8SwleL
	4N3vexXR2+ndO8h7iS9q+dtYFZrI7Mv9RD8IoLL2ItTV2qDS0K/CDArHwdAVlIdR3paY=
X-Gm-Gg: ASbGncvxLM78a3D4v2iaTBn9k3+hmlttO9WUB0Agyc2UA6gYFVt4zLEzPDGun/2K+ka
	o0SCmVZmdEc0Yb+3ElyBkIiEw8M73dq3uV8fIhDeofJF+b58WsSraGlOAMFTT4MXk6myRu82fMt
	UJYxrqdv3CZVXyqWuIfYkYPToRMhtouGXVyGO04P4JNXmaVbs8HV+MauOfdvyzQSxc8rgVg/VCT
	NrAYeidmAPBHoSblFPOwNvx0OiAEuaxi+G9iheoQrNcKymxSyj0jozUYfDCE7/UcMaR6gn8wq2b
	d8zPjptYqtwl6fbKUIrm24NKnJ9mGg9yfWsLUlvZsrYFsPcX+lQ4691ADkGW6+8gO08QbSwLw1H
	o0XdjLBRyWV3GGzfOUgKZaQ==
X-Received: by 2002:a17:90b:1d01:b0:332:afb1:d050 with SMTP id 98e67ed59e1d1-339a6e6f058mr5681657a91.14.1759356349313;
        Wed, 01 Oct 2025 15:05:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtXjtx1CgPbMeZAaJ9FMmzfr00T8wOkmLkVDsPqDJtQ1JtqAVWOpUSxIwTkFg7mZ6ahmIFBQ==
X-Received: by 2002:a17:90b:1d01:b0:332:afb1:d050 with SMTP id 98e67ed59e1d1-339a6e6f058mr5681620a91.14.1759356348788;
        Wed, 01 Oct 2025 15:05:48 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339b4ea3c3dsm702085a91.5.2025.10.01.15.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 15:05:48 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v4 08/10] phy: qualcomm: qmp-usb: Add support for Glymur USB UNI PHY
Date: Wed,  1 Oct 2025 15:05:32 -0700
Message-Id: <20251001220534.3166401-9-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001220534.3166401-1-wesley.cheng@oss.qualcomm.com>
References: <20251001220534.3166401-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tT6XQLub_rPGarvWXkR9i-Gg977-zFII
X-Proofpoint-GUID: tT6XQLub_rPGarvWXkR9i-Gg977-zFII
X-Authority-Analysis: v=2.4 cv=etzSD4pX c=1 sm=1 tr=0 ts=68dda5c2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=bxfdmw13fxgBHIVlFAEA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3NSBTYWx0ZWRfXxCo3oXYXTHUl
 IPqxd7fBReGHqcfU2X46/0xG2U5LRdQzEpElhX8S6/1owhVPV6pQOXGo1OUezSK4mG9tTD66i+1
 hTbcLW0/4VF/7S0B7z3tbQNzcW2ALT4Hx9QduD/DDCRgr8WVLxHUSEqr6yQcRt4uXsTORDgfc7q
 l/sv8v2yEIMnp4aezHLcVIiW/hRHmpMNw2AN3BYPsSm2EtoPqhx1/ot8jiCjNvvQ9cjIRNpqBnJ
 E6T5rVlvKuFKZwPEvm42h7uaBCT0BBP/EwXL4/MbGpKI3zrLyaroHjyidmDVVD3YCk0utzCZ+bw
 x/84kQx6ZBLtmTdBJ0e9v8ViVCwwwPAc/FktbBIF4DpMK0nyoW2s0bHykHORxDOsm9QNDaaCOnt
 kBFHSCHI25Kpv5RFoc92CoWrMpaHxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290175

Glymur contains a USB multiport controller which supports a QMP UNI PHY.
These ports do not have typeC capability, so it needs to be differentiated
in this manner.  Update the QMP PHY sequence required to bring up the UNI
PHY for Glymur.  The UNI PHY follows mostly the same register field
definitions as previous SoCs.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 163 ++++++++++++++++++++++++
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

