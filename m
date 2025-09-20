Return-Path: <linux-kernel+bounces-825477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C229B8BE28
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 05:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BEAA05AF7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F5F24166C;
	Sat, 20 Sep 2025 03:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OQx1WTkj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22F72367C1
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758338484; cv=none; b=jgk8bGI3XJ07hUXO799Ayjel90C+5ImeipbYlwMfL7h7M+WSEhjddxiPREpuYfbsBSwNxoY00orPqX4/AjYI5daRfKa5N8kD04pDg4l/jNRCAAI3wTxuZeYT21I2T/YDk0mdwurIAroR3rUabJHwuJDxdmjEOupI3buiG5+ju2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758338484; c=relaxed/simple;
	bh=BfwtCJ9yNaw37zL1zoMVP8hJ0uF+7CXhZhXT7JGQ8r0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ttT/ZqRCb8/0Ws79ypYv8rbkyOU+p++qcR3X2TGaAeadxTovMTNQ4x7L+atTzI6oHioNReNul8183JJl9SF9raf70LDTbmQ2lpOfxiQrTfnoLdepG226Lof2d68Lab1zGlUio/FmmZRCwdE1cCbFbgxEXJ+2M0EM4yKhGGoMH/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OQx1WTkj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3FYum032205
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8wTywRAWZXw
	EsR6jea+R90ywj5SpxQrORQMaOZpD3JU=; b=OQx1WTkjaW0Uwjd7nXBAwQPcMEA
	k0odHwB2Yl2ObTl6FDnhwzuX36qmkdeh6FIj07PxSGSrRxVmEdLtGHxJLOzV+0ar
	dqpB9jzTv56v4W2kTzV5sIJZVQSDW1kNgHhILTf+8nK96xamzUgRy8DRXAgnxJq4
	Z2MSt8oM4tXnzR8ULTHxQS43pminL7niK85YfJgS4LL8i9RXVpBetIsk6+xzZ3Pr
	ie+Yuf66kZest8DI9r5vrvfdwCgeI465WBftuyOAlE7omxEXtfyd1vucZUV7QBis
	joPuec6lt82bxIk1oyPP4y11YJW2tVTK/os94tSXvV5ga5BP1rtiKG4kLKw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k7sr3fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b54d6a67b5fso2078747a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758338481; x=1758943281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wTywRAWZXwEsR6jea+R90ywj5SpxQrORQMaOZpD3JU=;
        b=AYV3oALZ0EzlMR8/BiyKz3vuERZktO91AKSWBRoejUQwhTM2XjGaq66H7wEHbN155e
         EpIqz7HjczQyJWStr51fIzth4BHHoa+LwDcZeOP2Vnec6SXCKMRH7TppwCxCcBBEMaXv
         sv/Md13kSok5x05VwDT6jzMRa+Yw+apC/8ERHXE2JeX9l5xIIJ7Ry8EHe/UdY7p9mjAo
         Jd+CVi7I9/LNmNqO9suw/I9vKhGB5W4JJRcejB0hI1UFLXVOOwwdkuwOFIMoizOJbZOV
         pukEzW3b1kflmBJPX2e92d7pju4NvHRCNNjAOHZEf1O8kzIx3D6asjtvYOaOjFKixu0m
         6IGQ==
X-Gm-Message-State: AOJu0Yzc2Uk2NnLEyxl/YcH9O9tFiN7wEPub3inWb4hIXEvc/3iANBLh
	y/T8HoICYvzVAerxqsIrtp/YEfA74+c8jNkJ7Iko31jvz4y8h15uarnsdF3KCA36NqjIICsWcn0
	R4R+nLy8sv/+hLo0tVKAjlJ9fqpXtHkQnzoSrvTuVRnEXupidBE7ju/HF/StebPI0pE8=
X-Gm-Gg: ASbGncuCBGkb0Rj+sU4pRDIpvWc5N+tkhBmcYeX6nwIZxoenDZr3fm/t9jKmiVylOJi
	GsEEi2KtSbek1g7aruXb1Pj+FE8dj60ULKcAawXiSpCGJlvBOfS86Ig18+o9/z1jFyv9hUhtaud
	Z4GGS/MreTm2rKuHSburAWgbXVqI0xeOnHb2f+W6xwXf964bjIzNfpZHUeacIzAVjOw7CKj41Fe
	JG0E5cO7Nm5DPlrWOgtkTBgvTTmdgpadIBTk3YBQWK/q5S0Wo7QNL6OEdWWIfC9YvD5oraMa29d
	bRz5pTbUjM63Y2OhSj1wPOLVGYhsF5ISbM79qqAIdOZogPXiiu0SviKyktpgAU3vzMf0K70Vh6C
	SZeE9r6KtH1tqsNln
X-Received: by 2002:a05:6a20:2450:b0:262:da1c:3c07 with SMTP id adf61e73a8af0-2925ca2505fmr8575269637.20.1758338480902;
        Fri, 19 Sep 2025 20:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTeTsjrwy1w14Gd3TIgIl2EfonPS5FLCrgXg1NffT2ZQwM0KDDeXlRThzHDQ9xy1TTBYJTRQ==
X-Received: by 2002:a05:6a20:2450:b0:262:da1c:3c07 with SMTP id adf61e73a8af0-2925ca2505fmr8575242637.20.1758338480474;
        Fri, 19 Sep 2025 20:21:20 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff448058sm6178807a12.54.2025.09.19.20.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 20:21:19 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH 5/9] phy: qualcomm: Update the QMP clamp register for V6
Date: Fri, 19 Sep 2025 20:21:04 -0700
Message-Id: <20250920032108.242643-6-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfXzKtRF3pF+Ah9
 DXzB+Ql+lKMmI45axvGfHdZ/6Ug4LfyI+lOYndMPnQHXte68j3CvCoNJoAsQar+WBr1YUTCbJub
 x5YTOa95/plVbeNtEn+Z7gJ1rZzXGeOX+/Mwn55XMav9RIfngbowY12cOBmCQZTIz0ib9wRzFKn
 xfw9lbQZVurCEbHi01NcERiMD53l6PhSHEoZ++Nb+P2eJEXpMnqsFBDWl4j7b6PsQWJeOFwbcFK
 Vk7rMEOWm4yjDcEU75k4/YZsQOk9cvG3lg+qvQ/mfJvX4HCEEa9VxixB9kdH1pgNWJTm8MoVKJM
 yqmBz97PeT7kVw75c504ZP8gqzura68ZQjaiyhpY7QFiVs+aCESN2Fr6hXvWS/Ae3annRt9TXEm
 FOaHnFzf
X-Proofpoint-ORIG-GUID: iOzDqszS7Yb1P1UjUuTNUkspZWpC_o7G
X-Authority-Analysis: v=2.4 cv=bvpMBFai c=1 sm=1 tr=0 ts=68ce1db1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=6zIwrvuT6hO6z1e-hKYA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: iOzDqszS7Yb1P1UjUuTNUkspZWpC_o7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

From: Elson Roy Serrao <quic_eserrao@quicinc.com>

QMP combo phy V6 and above use the clamp register from the PCS always on
(AON) address space.  Update the driver accordingly.

Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 38 ++++++++++++++++---
 .../phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h    | 12 ++++++
 .../phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h   | 12 ++++++
 3 files changed, 57 insertions(+), 5 deletions(-)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index f07d097b129f..2a059d925679 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -28,7 +28,10 @@
 #include "phy-qcom-qmp-common.h"
 
 #include "phy-qcom-qmp.h"
+#include "phy-qcom-qmp-pcs-aon-v6.h"
 #include "phy-qcom-qmp-pcs-misc-v3.h"
+#include "phy-qcom-qmp-pcs-misc-v4.h"
+#include "phy-qcom-qmp-pcs-misc-v5.h"
 #include "phy-qcom-qmp-pcs-usb-v4.h"
 #include "phy-qcom-qmp-pcs-usb-v5.h"
 #include "phy-qcom-qmp-pcs-usb-v6.h"
@@ -71,6 +74,7 @@ enum qphy_reg_layout {
 	QPHY_PCS_AUTONOMOUS_MODE_CTRL,
 	QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR,
 	QPHY_PCS_POWER_DOWN_CONTROL,
+	QPHY_PCS_CLAMP_ENABLE,
 
 	QPHY_COM_RESETSM_CNTRL,
 	QPHY_COM_C_READY_STATUS,
@@ -98,6 +102,8 @@ static const unsigned int qmp_v3_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V3_PCS_AUTONOMOUS_MODE_CTRL,
 	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V3_PCS_LFPS_RXTERM_IRQ_CLEAR,
 
+	[QPHY_PCS_CLAMP_ENABLE]		= QPHY_V3_PCS_MISC_CLAMP_ENABLE,
+
 	[QPHY_COM_RESETSM_CNTRL]	= QSERDES_V3_COM_RESETSM_CNTRL,
 	[QPHY_COM_C_READY_STATUS]	= QSERDES_V3_COM_C_READY_STATUS,
 	[QPHY_COM_CMN_STATUS]		= QSERDES_V3_COM_CMN_STATUS,
@@ -123,6 +129,8 @@ static const unsigned int qmp_v45_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V4_PCS_USB3_AUTONOMOUS_MODE_CTRL,
 	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V4_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
 
+	[QPHY_PCS_CLAMP_ENABLE]		= QPHY_V4_PCS_MISC_CLAMP_ENABLE,
+
 	[QPHY_COM_RESETSM_CNTRL]	= QSERDES_V4_COM_RESETSM_CNTRL,
 	[QPHY_COM_C_READY_STATUS]	= QSERDES_V4_COM_C_READY_STATUS,
 	[QPHY_COM_CMN_STATUS]		= QSERDES_V4_COM_CMN_STATUS,
@@ -148,6 +156,8 @@ static const unsigned int qmp_v5_5nm_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL,
 	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
 
+	[QPHY_PCS_CLAMP_ENABLE]		= QPHY_V5_PCS_MISC_CLAMP_ENABLE,
+
 	[QPHY_COM_RESETSM_CNTRL]	= QSERDES_V5_COM_RESETSM_CNTRL,
 	[QPHY_COM_C_READY_STATUS]	= QSERDES_V5_COM_C_READY_STATUS,
 	[QPHY_COM_CMN_STATUS]		= QSERDES_V5_COM_CMN_STATUS,
@@ -173,6 +183,8 @@ static const unsigned int qmp_v6_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL,
 	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
 
+	[QPHY_PCS_CLAMP_ENABLE]		= QPHY_V6_PCS_AON_CLAMP_ENABLE,
+
 	[QPHY_COM_RESETSM_CNTRL]	= QSERDES_V6_COM_RESETSM_CNTRL,
 	[QPHY_COM_C_READY_STATUS]	= QSERDES_V6_COM_C_READY_STATUS,
 	[QPHY_COM_CMN_STATUS]		= QSERDES_V6_COM_CMN_STATUS,
@@ -198,6 +210,8 @@ static const unsigned int qmp_v6_n4_usb3phy_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL,
 	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
 
+	[QPHY_PCS_CLAMP_ENABLE]		= QPHY_V6_PCS_AON_CLAMP_ENABLE,
+
 	[QPHY_COM_RESETSM_CNTRL]	= QSERDES_V6_COM_RESETSM_CNTRL,
 	[QPHY_COM_C_READY_STATUS]	= QSERDES_V6_COM_C_READY_STATUS,
 	[QPHY_COM_CMN_STATUS]		= QSERDES_V6_COM_CMN_STATUS,
@@ -1748,6 +1762,7 @@ struct qmp_combo_offsets {
 	u16 usb3_serdes;
 	u16 usb3_pcs_misc;
 	u16 usb3_pcs;
+	u16 usb3_pcs_aon;
 	u16 usb3_pcs_usb;
 	u16 dp_serdes;
 	u16 dp_txa;
@@ -1829,6 +1844,7 @@ struct qmp_combo {
 	void __iomem *tx2;
 	void __iomem *rx2;
 	void __iomem *pcs_misc;
+	void __iomem *pcs_aon;
 	void __iomem *pcs_usb;
 
 	void __iomem *dp_serdes;
@@ -1949,6 +1965,7 @@ static const struct qmp_combo_offsets qmp_combo_offsets_v8 = {
 	.usb3_serdes	= 0x1000,
 	.usb3_pcs_misc	= 0x1c00,
 	.usb3_pcs	= 0x1e00,
+	.usb3_pcs_aon	= 0x2000,
 	.usb3_pcs_usb	= 0x2100,
 	.dp_serdes	= 0x3000,
 	.dp_txa		= 0x3400,
@@ -3309,6 +3326,7 @@ static void qmp_combo_enable_autonomous_mode(struct qmp_combo *qmp)
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *pcs_usb = qmp->pcs_usb ?: qmp->pcs;
 	void __iomem *pcs_misc = qmp->pcs_misc;
+	void __iomem *pcs_aon = qmp->pcs_aon;
 	u32 intr_mask;
 
 	if (qmp->mode == PHY_MODE_USB_HOST_SS ||
@@ -3328,9 +3346,14 @@ static void qmp_combo_enable_autonomous_mode(struct qmp_combo *qmp)
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
@@ -3338,10 +3361,13 @@ static void qmp_combo_disable_autonomous_mode(struct qmp_combo *qmp)
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
@@ -3934,6 +3960,8 @@ static int qmp_combo_parse_dt(struct qmp_combo *qmp)
 	qmp->serdes = base + offs->usb3_serdes;
 	qmp->pcs_misc = base + offs->usb3_pcs_misc;
 	qmp->pcs = base + offs->usb3_pcs;
+	if (offs->usb3_pcs_aon)
+		qmp->pcs_aon = base + offs->usb3_pcs_aon;
 	qmp->pcs_usb = base + offs->usb3_pcs_usb;
 
 	qmp->dp_serdes = base + offs->dp_serdes;
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h
new file mode 100644
index 000000000000..52db31a7cf22
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v6.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_AON_V6_H_
+#define QCOM_PHY_QMP_PCS_AON_V6_H_
+
+/* Only for QMP V6 PHY - PCS_AON registers */
+#define QPHY_V6_PCS_AON_CLAMP_ENABLE			0x00
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h
new file mode 100644
index 000000000000..77d04c6a1644
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v5.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_MISC_V5_H_
+#define QCOM_PHY_QMP_PCS_MISC_V5_H_
+
+/* Only for QMP V5 PHY - PCS_MISC registers */
+#define QPHY_V5_PCS_MISC_CLAMP_ENABLE			0x0c
+
+#endif

