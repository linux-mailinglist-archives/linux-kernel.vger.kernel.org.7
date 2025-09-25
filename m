Return-Path: <linux-kernel+bounces-831538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFD0B9CF24
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5121BC3FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF372DEA7E;
	Thu, 25 Sep 2025 00:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PyDV3ovX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9BC2DC798
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761564; cv=none; b=EmaNrUz4qkDGY9LeDtQmWHkA9hutqRFNIXzySpuMgHDcofeeVCSDi2Fa7G9A5g0elDbzlb8qfwznE6jjPPYzk6gwT//rtO5LXEhqRaXzTb8lrvGPtO10vRNaXdFjPZRb2JpoqPjZ4aJmQSERAB35OuIguRDFK05e8N9nssAEnoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761564; c=relaxed/simple;
	bh=QSaczH0DxPhO08LlshD2u4AexZPXX/GpQPCyuLMnHus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AN3zqaZntMqpTehUF42+R50NJjrrJp+NaOyHlnWO0Uo8RO/SkMRgriZZ7VBIDnO0jrHJ77RaeAd2GslEpIr16qwo5p43xr2quhSqbG+MDygDsRXy2nthNwf7q6R6ArNlHreZoKKppFOE+2kLn59SQ4deZR7Inbx39sOZHz4/ve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PyDV3ovX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0M9a2017424
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fMLDrKeIfTQ
	d2Dm3YXJnSbuw4SMZKXrwiUeC9YZ70YE=; b=PyDV3ovXtTN5nKymmA9cph+zUpc
	s5bH4HNUejcwXAnZUjDYn4ZOanHubzgLFJFYufarOiJ222XXbR9fA+iSh2LYexJc
	77MBsu4F+yBQaUJhRC6gxQyo/cDJr8Mxx1qaRvaDk1hqXtlpdXh4UjOZrmnZ/asI
	o7nEhw/cYmGqe2rwq3vhNpMMNZgk1MCHzt9KLZINU5CrKPH5JH4LUVJfpbPErb0T
	XfPBqUyJlRGlKvhutZikDC8QCawhY2Pk6wDYOQgdXs7jhqF0kIOWFCOgdbmi0lEG
	LqCjlVzPh6T3jGSUDUn0QCxHmk5Bc+2HawSo5bMB9GkmOXltuhbrJEGsaHg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjyj41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2445806b18aso3664005ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758761561; x=1759366361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMLDrKeIfTQd2Dm3YXJnSbuw4SMZKXrwiUeC9YZ70YE=;
        b=TgZzS0kIAXYU8uk95Q+xBMP9dfQkJB3ZB1qCMaBupHu5E1S/2CQTpfDBeZjyKoqGat
         zIiMK5RRhtvTPOGfP5yQwzZHy/jo79RjHSZXs4W/m16sbWWb6WLSeuD9jY6EYUNJ5v8v
         ZvkHw1sh/M3YoNEJPXKO2CYAENCwMO7Ph+wjPFWhgdgxStU+E0Q/vDTA0ZTsiiiTDVsD
         BxznFhfLNk559anrcOzXqznzxIyNuylF7TItvM9ET8y0cdIztOdf3Lc4UAvxm778fZ5v
         iDYGtS5EIme2riRXd27vAEEru5dg1LF8fPfknjJP3ckfGoevCoeLFoWDqAZL2eET59X7
         p8Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXd4i1c1NSMBFr8u3uwNV/nzsQtAr3V1mj5+CY/lVqIuQL9TjZB7GnFAsdFqKWmqVYp9+fmOo7X2Ssmcjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7JXS9Y8C1+NIOO2ksdVKVxfgJOmiLn45D5lu0WxCANQu8+Fk
	rUSI5eRBC2ZCbiLQLDx9L5xZ3Y4jEIJnhh3TPiq1Z1ElicN8c/gI4GsRHUVAKUwoc2kKhVj8FKH
	QpkUx6y/Lyux1HM+P9tgyNiDrJCPK+pEmz8KY4hUIeCCmUzb4GL5AOV1gpfzhCjFhOiI=
X-Gm-Gg: ASbGnctnziFImyFogigIS4rQrb/+DQp8LJD8CqvpGZqxmMiYASvMwoKss0yH17v2McM
	p3pwVg/8gq0eyjXR6T88lHX3AVda+zQogIrYtZmN/zD/hbAdvDV7/3IFpm+Bkhoxcj1WAGfMLw/
	nyhL4cQgRsVoHctOVtG7aummJUrN1YnnKnp7E/zUm2NFRX5RSpIKnfxky4HoUFvJJ/9yncVkiZC
	vSMw1q3zRIwee+zVqhbKNThao3wonZKlC5bdZgmxMTdHk3k/MBFtnG/GoCZpWFY+1YjH8GqKAVK
	i2jMW1paQYjkBnI1qaOatPbGKqY0p2k6jGW3Wo8rfV4G7JgCc1h5cQ/C06/Pp0yMeR9JJcYu5bk
	l/OwHQLSI9a5ZzqrY
X-Received: by 2002:a17:902:e843:b0:24e:3cf2:2450 with SMTP id d9443c01a7336-27ed49b30f2mr18686215ad.2.1758761560989;
        Wed, 24 Sep 2025 17:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPH5N4FiwgPEeFKYPrADX4IgOesXzC/XJSHJZuzBfk1v+pbr4IOGkX5np/f/5CXi9/6YxsQg==
X-Received: by 2002:a17:902:e843:b0:24e:3cf2:2450 with SMTP id d9443c01a7336-27ed49b30f2mr18685855ad.2.1758761560535;
        Wed, 24 Sep 2025 17:52:40 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ac27d4sm5238105ad.135.2025.09.24.17.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:52:39 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v2 06/10] phy: qualcomm: Update the QMP clamp register for V6
Date: Wed, 24 Sep 2025 17:52:24 -0700
Message-Id: <20250925005228.4035927-7-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
References: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: B6XO-IsAjWmc-NQ5GUxT3wkYytkkKZ_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX0FIjx+Ug0kdl
 62Ku1yuRZ//mF9glSraNEYA10Xw95h5bYaWe0NbffSIqhGMBzfYIyGtcGfON3WNIqKo5rPZZ1Pq
 TqRV5IVcQn6+uR3PmwnCzKi4ROOvkNeYQvInIGzTh5L5Jpjv96eJr8zkd5s+xMKm8zRuSealHS0
 QpuUhbCNkR9JIJ1g9TEC0OMN4er2LnUfekodFBownrH2p3ve8355Wa3vZCrMIchZHU044fsqCNR
 Y7kR545q8NLW5lEnQDSQ48ESBFUJiGFYrbW1kPvH8SxUNO63b+wt5A7eDaTzJY+XTGR30tYtMVg
 MchvxZ/y62dUeRYWpQKdhj8KP0BokRyjyPWDox8D/rJDSIHqrMN+x1thYOmA+m7U2FV8fYBNS+F
 gGoPBTkj
X-Proofpoint-GUID: B6XO-IsAjWmc-NQ5GUxT3wkYytkkKZ_U
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d49259 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=p6rJcVbQ9lVvMV6GHPsA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

QMP combo phy V6 and above use the clamp register from the PCS always on
(AON) address space.  Update the driver accordingly.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 38 ++++++++++++++++++++---
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 7b5af30f1d02..1caa1fb6a8c7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -29,7 +29,10 @@
 #include "phy-qcom-qmp-common.h"
 
 #include "phy-qcom-qmp.h"
+#include "phy-qcom-qmp-pcs-aon-v6.h"
 #include "phy-qcom-qmp-pcs-misc-v3.h"
+#include "phy-qcom-qmp-pcs-misc-v4.h"
+#include "phy-qcom-qmp-pcs-misc-v5.h"
 #include "phy-qcom-qmp-pcs-usb-v4.h"
 #include "phy-qcom-qmp-pcs-usb-v5.h"
 #include "phy-qcom-qmp-pcs-usb-v6.h"
@@ -78,6 +81,7 @@ enum qphy_reg_layout {
 	QPHY_PCS_AUTONOMOUS_MODE_CTRL,
 	QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR,
 	QPHY_PCS_POWER_DOWN_CONTROL,
+	QPHY_PCS_CLAMP_ENABLE,
 
 	QPHY_COM_RESETSM_CNTRL,
 	QPHY_COM_C_READY_STATUS,
@@ -105,6 +109,8 @@ static const unsigned int qmp_v3_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V3_PCS_AUTONOMOUS_MODE_CTRL,
 	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V3_PCS_LFPS_RXTERM_IRQ_CLEAR,
 
+	[QPHY_PCS_CLAMP_ENABLE]		= QPHY_V3_PCS_MISC_CLAMP_ENABLE,
+
 	[QPHY_COM_RESETSM_CNTRL]	= QSERDES_V3_COM_RESETSM_CNTRL,
 	[QPHY_COM_C_READY_STATUS]	= QSERDES_V3_COM_C_READY_STATUS,
 	[QPHY_COM_CMN_STATUS]		= QSERDES_V3_COM_CMN_STATUS,
@@ -130,6 +136,8 @@ static const unsigned int qmp_v45_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V4_PCS_USB3_AUTONOMOUS_MODE_CTRL,
 	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V4_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
 
+	[QPHY_PCS_CLAMP_ENABLE]		= QPHY_V4_PCS_MISC_CLAMP_ENABLE,
+
 	[QPHY_COM_RESETSM_CNTRL]	= QSERDES_V4_COM_RESETSM_CNTRL,
 	[QPHY_COM_C_READY_STATUS]	= QSERDES_V4_COM_C_READY_STATUS,
 	[QPHY_COM_CMN_STATUS]		= QSERDES_V4_COM_CMN_STATUS,
@@ -155,6 +163,8 @@ static const unsigned int qmp_v5_5nm_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL,
 	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
 
+	[QPHY_PCS_CLAMP_ENABLE]		= QPHY_V5_PCS_MISC_CLAMP_ENABLE,
+
 	[QPHY_COM_RESETSM_CNTRL]	= QSERDES_V5_COM_RESETSM_CNTRL,
 	[QPHY_COM_C_READY_STATUS]	= QSERDES_V5_COM_C_READY_STATUS,
 	[QPHY_COM_CMN_STATUS]		= QSERDES_V5_COM_CMN_STATUS,
@@ -180,6 +190,8 @@ static const unsigned int qmp_v6_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL,
 	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
 
+	[QPHY_PCS_CLAMP_ENABLE]		= QPHY_V6_PCS_AON_CLAMP_ENABLE,
+
 	[QPHY_COM_RESETSM_CNTRL]	= QSERDES_V6_COM_RESETSM_CNTRL,
 	[QPHY_COM_C_READY_STATUS]	= QSERDES_V6_COM_C_READY_STATUS,
 	[QPHY_COM_CMN_STATUS]		= QSERDES_V6_COM_CMN_STATUS,
@@ -205,6 +217,8 @@ static const unsigned int qmp_v6_n4_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL,
 	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
 
+	[QPHY_PCS_CLAMP_ENABLE]		= QPHY_V6_PCS_AON_CLAMP_ENABLE,
+
 	[QPHY_COM_RESETSM_CNTRL]	= QSERDES_V6_COM_RESETSM_CNTRL,
 	[QPHY_COM_C_READY_STATUS]	= QSERDES_V6_COM_C_READY_STATUS,
 	[QPHY_COM_CMN_STATUS]		= QSERDES_V6_COM_CMN_STATUS,
@@ -1755,6 +1769,7 @@ struct qmp_combo_offsets {
 	u16 usb3_serdes;
 	u16 usb3_pcs_misc;
 	u16 usb3_pcs;
+	u16 usb3_pcs_aon;
 	u16 usb3_pcs_usb;
 	u16 dp_serdes;
 	u16 dp_txa;
@@ -1836,6 +1851,7 @@ struct qmp_combo {
 	void __iomem *tx2;
 	void __iomem *rx2;
 	void __iomem *pcs_misc;
+	void __iomem *pcs_aon;
 	void __iomem *pcs_usb;
 
 	void __iomem *dp_serdes;
@@ -1960,6 +1976,7 @@ static const struct qmp_combo_offsets qmp_combo_offsets_v8 = {
 	.usb3_serdes	= 0x1000,
 	.usb3_pcs_misc	= 0x1c00,
 	.usb3_pcs	= 0x1e00,
+	.usb3_pcs_aon	= 0x2000,
 	.usb3_pcs_usb	= 0x2100,
 	.dp_serdes	= 0x3000,
 	.dp_txa		= 0x3400,
@@ -3345,6 +3362,7 @@ static void qmp_combo_enable_autonomous_mode(struct qmp_combo *qmp)
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *pcs_usb = qmp->pcs_usb ?: qmp->pcs;
 	void __iomem *pcs_misc = qmp->pcs_misc;
+	void __iomem *pcs_aon = qmp->pcs_aon;
 	u32 intr_mask;
 
 	if (qmp->phy_mode == PHY_MODE_USB_HOST_SS ||
@@ -3364,9 +3382,14 @@ static void qmp_combo_enable_autonomous_mode(struct qmp_combo *qmp)
 	/* Enable required PHY autonomous mode interrupts */
 	qphy_setbits(pcs_usb, cfg->regs[QPHY_PCS_AUTONOMOUS_MODE_CTRL], intr_mask);
 
-	/* Enable i/o clamp_n for autonomous mode */
-	if (pcs_misc)
-		qphy_clrbits(pcs_misc, QPHY_V3_PCS_MISC_CLAMP_ENABLE, CLAMP_EN);
+	/*
+	 * Enable i/o clamp_n for autonomous mode
+	 * V6 and later versions use pcs aon clamp register
+	 */
+	if (pcs_aon)
+		qphy_clrbits(pcs_aon, cfg->regs[QPHY_PCS_CLAMP_ENABLE], CLAMP_EN);
+	else if (pcs_misc)
+		qphy_clrbits(pcs_misc, cfg->regs[QPHY_PCS_CLAMP_ENABLE], CLAMP_EN);
 }
 
 static void qmp_combo_disable_autonomous_mode(struct qmp_combo *qmp)
@@ -3374,10 +3397,13 @@ static void qmp_combo_disable_autonomous_mode(struct qmp_combo *qmp)
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *pcs_usb = qmp->pcs_usb ?: qmp->pcs;
 	void __iomem *pcs_misc = qmp->pcs_misc;
+	void __iomem *pcs_aon = qmp->pcs_aon;
 
 	/* Disable i/o clamp_n on resume for normal mode */
-	if (pcs_misc)
-		qphy_setbits(pcs_misc, QPHY_V3_PCS_MISC_CLAMP_ENABLE, CLAMP_EN);
+	if (pcs_aon)
+		qphy_setbits(pcs_aon, cfg->regs[QPHY_PCS_CLAMP_ENABLE], CLAMP_EN);
+	else if (pcs_misc)
+		qphy_setbits(pcs_misc, cfg->regs[QPHY_PCS_CLAMP_ENABLE], CLAMP_EN);
 
 	qphy_clrbits(pcs_usb, cfg->regs[QPHY_PCS_AUTONOMOUS_MODE_CTRL],
 		     ARCVR_DTCT_EN | ARCVR_DTCT_EVENT_SEL | ALFPS_DTCT_EN);
@@ -4075,6 +4101,8 @@ static int qmp_combo_parse_dt(struct qmp_combo *qmp)
 	qmp->serdes = base + offs->usb3_serdes;
 	qmp->pcs_misc = base + offs->usb3_pcs_misc;
 	qmp->pcs = base + offs->usb3_pcs;
+	if (offs->usb3_pcs_aon)
+		qmp->pcs_aon = base + offs->usb3_pcs_aon;
 	qmp->pcs_usb = base + offs->usb3_pcs_usb;
 
 	qmp->dp_serdes = base + offs->dp_serdes;

