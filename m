Return-Path: <linux-kernel+bounces-839571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B6FBB1EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E462D2A52AE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7017A313D56;
	Wed,  1 Oct 2025 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZTvcYmB+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39F731329B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356350; cv=none; b=sFzwcpCTvL05JdfMXXtNdT+Wj4OVuW/Hgy9XoyQVWT1XxCI84te1bWXSuIeQoZA2JLOya22a6i8ddupAiRFY4Nz2CoqbmvpUcQ1eNEN2CBs+rdsI+PUqH89ixNyoc/AmrVhdvMATu7dqc/YO6dWUujIl4ZWoyngvxgxLaHBGQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356350; c=relaxed/simple;
	bh=WxMZUmj2ngQ9rFSa9ukyQ401PTJp2ZPXFCY+DQ463ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VJl0p07OI3vUdPvBnZxzM75ckI1HmYHeC9eYLIZYFjsbUVlsRNsgo6wLgAMPOUFv/e5gjfEIIl3Tm9tsWAnGUdwgrnXRizzMS8hGZJdVXBa+NfWL2Q4xSgHVYX7JMLfXLy3CCdYIybUekMTmvFzw9umOrxP+3wOGtgz7J6K3/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZTvcYmB+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IbwYs017642
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 22:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VBqRZ4jqbmE
	I9VbvT9u9nUsnAWuxILBOxsAEN8Vqeng=; b=ZTvcYmB+781G33Jngta//qP6U8U
	+Pu7liFbjbl160GwMN9k76+Einp/qkAs9sQkTO1Deg+s7Ou9Xt73iSHXt4GG8T17
	MFS8SxBe9pGOzHPruQ2ormjsQ/nWAP7M6LBXDey2VSq+nJxB3wzRvioxnzlIzZSn
	jwOihU+3BXbCInWupvAKDHZFG54FW55IGl2iktxGYY0tZT794PHYXF2bT8O2AVQd
	bY+V29oOBfoRqbeYVN0GLePWaNt8UlcWBLUQb/1N//GfoPlPyLXg++ORqH/Ad78G
	1LVhOvCSG+dq42sCOypMl2eB4x4QKZFST6eoY7efkKEXmzdKQB1Vo2vPd2w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fyrf7hb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:05:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3304def7909so324185a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 15:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759356346; x=1759961146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBqRZ4jqbmEI9VbvT9u9nUsnAWuxILBOxsAEN8Vqeng=;
        b=e84lWVXpLtj6YBmdUttbUh06zPq//fPeRky6koDEbsJLa++oGoEuM5+GVv1GwJXdyo
         zHZR+8HO8/hZOg2b+BWy1T3huIj6oQB4S9IrBoLedX5/QmQRq5oBMmKRcLbHL5TLUnB8
         WQACeY2okHvrTBEuDNemGhZN7PRxRpaBrt0lncSkeoykTOO4komIB+XjINQ27UsyjVJ0
         liNu3LXe1bfpq0MDuzk9Y+UY0+Limnhz4ywUoSSFwUf63pFo8NU1Dhuj2vUt7mQiedDC
         7hbUZBexCWUaMk993qtSk54GgeNWxo7SNxOavXrcGMy3Gn0N1E/H9nWIk81O0UDpJA3d
         9mcg==
X-Forwarded-Encrypted: i=1; AJvYcCW55ISCMFgqpQ6GptGpXnzfeovVXloxnas5zWV7/c4kk0X4Wf++SEZXj6F8cdfDAPBkPZLb4P90nR+qFcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcAt5Nn0opkkg6i63cwCxXhohcP0nRFn3BzOJHKTZZ36dCig7F
	6y8Haa4DN1iakpChHaAxT1h4l3OQ6W9jJCI0k7xnYfXz8JjMEkUupmD6X0BBsmtje5RhQUozkDB
	as9XpMsp0+1pipNPGjJ09QXlEtk9ALsgh2au76M5yK8jVRKSuynRloZgFfGYq933+PMU=
X-Gm-Gg: ASbGnct8Lfo/sOcxLbpO1xp8KXJzR4l3qZhERAVjISX8yXbZtwWvoRRzySzRSozCjlr
	4L5rjtTHy2V0gijNqXui7BxXKQEXVzaPVQS/QC1C2xefRK7mxK1EtSDQZGZMncyrqlaYsQ/4FJi
	2B+dVDGEwa8tenXeFsJIkJtTntyb62f5KNKheW7ZqDAPviGQEWBAaQyBle+sMM72Kc0x8RKN51B
	jqQzwjRpn1SMwqKh7NY+jGt8lxMPMz2RMp5cRdnits8agjUJ1ZvoEImXpvYxHUgYPcF6Exe7zH6
	fhb95uT2Gg25ZRLraTsOYskyvqTwagY7wvsAXddx1nvMs85ZOzwj2ZEo5Gl+cpoOfVmoSxIt48Y
	tBMPUqM840eteWRmvvIas1A==
X-Received: by 2002:a17:90b:33c2:b0:32e:7270:94a4 with SMTP id 98e67ed59e1d1-339a6e95cffmr5527089a91.14.1759356346128;
        Wed, 01 Oct 2025 15:05:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHomWGZOC1WpXjj3slZlcWFaaQw2E4nqZjQOav79Kf+xt/dQaq7ApisM4b2By9Brg9TYTmnUA==
X-Received: by 2002:a17:90b:33c2:b0:32e:7270:94a4 with SMTP id 98e67ed59e1d1-339a6e95cffmr5527064a91.14.1759356345617;
        Wed, 01 Oct 2025 15:05:45 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339b4ea3c3dsm702085a91.5.2025.10.01.15.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 15:05:44 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Elson Roy Serrao <quic_eserrao@quicinc.com>
Subject: [PATCH v4 06/10] phy: qualcomm: Update the QMP clamp register for V6
Date: Wed,  1 Oct 2025 15:05:30 -0700
Message-Id: <20251001220534.3166401-7-wesley.cheng@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: X6zuSbe73OxJPIDnlzmVTmJ8zAqlcfkd
X-Proofpoint-GUID: X6zuSbe73OxJPIDnlzmVTmJ8zAqlcfkd
X-Authority-Analysis: v=2.4 cv=etzSD4pX c=1 sm=1 tr=0 ts=68dda5bb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=6zIwrvuT6hO6z1e-hKYA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3NSBTYWx0ZWRfXxvlf7r8s1yBX
 fs9tklEAn0TiPtfLT/RynUAAdR61uqlkCBHfPIU4V55xjtWNxEVNg5ZePu0lR1iy9ai8oOGl/RO
 XI/zM9u3QjnD9H4ZhVuR2xL79TUErAs+Vso7EIsvz8JMrBx0QBdebhIgKgLzCXDrA0eYwwyAGaz
 eQNCJQEywFHkVI5qNWnN/UZvgfuH1YKZcBIB2bhV0Lb0TIv0Pk0N4ghi7ZIrrvkgZYb1SseBUwY
 8F32p9KcEjpSfqUVV/0HvYK7zppxaH4kTLb1M0FSEopHLXmSghd3W9+NEO4nMml2YN9gAUtxbqa
 r0IHNqW4thEb95qH4SjUeukcMvg8XixY34owsj7nv9oeliQZdI/+dA7/C/sz3iMtNCv3TsnOhaE
 BeKF+yFCdyO7SKWNyIOU1TZIfVv4Rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290175

QMP combo phy V6 and above use the clamp register from the PCS always on
(AON) address space.  Update the driver accordingly.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

