Return-Path: <linux-kernel+bounces-833700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40CCBA2C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35EBE16EF37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32352900A8;
	Fri, 26 Sep 2025 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KeTeE/j+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161CC29D280
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871662; cv=none; b=jUhVi/vfs5nJ2yBqIMXHVtqXmDiO69U9LzQNdEz9xWKOfCTB9mrBI+ujq3xjaTsnHvISNcV3kvjgDWTqiCgeccxvy+wgLaGAXk6N7WT77Se/Dwe2A783o7VvGTDBPWq8cCmBtOwmBo51WOerOJIL6Sg0QILi5kmJV0hxV0vd2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871662; c=relaxed/simple;
	bh=bAcJPNht/+rnG7uZv7s+NNJvq4heKp19LQ+dsihcBNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MkFGvecTJ5PBONXRLlo1UBLyc5MrIg5vFLoqmhuKshyT77Hu86cjq1+l+97/DpEG1IjBD6BvQ18CKFwYLj4+t6+qoUWi6SUD2dtPUhxMsIKGm7v/NDIkNzuBssDWSRvT6Fm2LKUnorDVzfz9KCndEMAC6HJfiJVOz1JV/1VXptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KeTeE/j+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q6latO015771
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OymEGRX9BPbmJJk3jd9hUj8zYXUCvOAy4RsQcEnI+98=; b=KeTeE/j+fMwqurqj
	i6AEHHu5WXeK5/wLt8YN3Ohd7nEGaKIY3uzFlnB4XICL863Oj9r/IQWF2UXirp2c
	gadbrvgD0I6RRgZ+2NS73UdMBQb+Hdah2zILsjKmcqjX4yM83xhjVJ1zQrPzU8EC
	G2datMy40topC4U1LjvLEC+uaVoAHx7OJFx9Bsbzpz4YYOEwdTQSKfuA7zksWZMg
	BylKIxR1N1lNzsjgyG9xGo5JcozUyDP14eRNFpcEcNiTlrXVJHeoMc3XXVlRpsJr
	UUhd8HAU1cY+RsoI8A4QxeA1lJcJ54KxlJL+hh3z9uqOuthfM8yxuLG26EK1JvVr
	qnexbQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0t9wvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:27:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2680b3acdf0so4403945ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871658; x=1759476458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OymEGRX9BPbmJJk3jd9hUj8zYXUCvOAy4RsQcEnI+98=;
        b=bGlZ51ZtbXYPgX0FaodZiOLlZe/vRxvU32pGioD6b71qmK4mhfr4JdoqClk5OhGkSU
         HNsBE9G4H4UJ8tgXyqPdDFbBgiFshXSDUtqQG+SHkfrUS4ESfFMrz7/wBgWvMKe9IT3m
         lTVIRNDkI8noLI8xOOtIUrChvvC3bpOhNEtIaCKk+tPUfqri8KTSG0G3RmlxnjI66aXl
         f3R9HHGQIY7ZulFM3SohQIRihMFX+VE9AMgSGvgCRY79iSuPdGTUNCEgBcHx/nwCjMqe
         4d0AgOoINvFHikUWMQBAlFwoCGB77e4suGrTK5X/R2TdWV9weKTzYHL640ZQNIHynzyN
         VI+w==
X-Forwarded-Encrypted: i=1; AJvYcCV/d8O2k7JNxZyZKGTQFmuy0b93GRiei0yFQrdlQuGl/AW0R8QCwae7OsND1jPPUlb5LBGuScz1dQuu+Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw38EjqAn2n/pSS40B4EP16FsqC6tlFi07y+QYIgau9DCbVJ9iU
	820BahdEcbc9+1d79/7h3kGwNB15tbUqJH5wtaLEcgLjr0Jsgx7EwGCbYruUbd8yeQhX/O0eaVx
	zGeJjjyUZmpGIwG6OMFEK1tQBGMPC+9IYb01Yera39BLbt1Oq2Vw5XXIcNbgploxNTtA=
X-Gm-Gg: ASbGnctVHFoHqDmforUI32SnPsOBEn6UMHyjPz21emyuG4DLEt9GW2txdoFneq4Aymn
	UmQG4uq1oRND9AYDgcghveW1aTJ8oAmYoKL9CjpOmZem4ffn+Ai7Pcgkj3M4w4ZsWL0TlH2gutL
	cEdDK9GoNNXa05EGTPvoRUs8dU7Nf65dwDMtZGzMMc0evZ7KmBnI4J+X672z46KyH7zBF/GS5uA
	OiI6nRp/p6u+LnE0HBpaiJwfOG+3xfM/YrFsX6CJMmx+UEeQuOabj1q8u7NjRfc/3R0WvoqSf57
	bwPWCEEuzCYgLP2G3pNh9QL9jgWC+C8e57Xlh/PcqDnUkdrTuuPOUEv3SmmJqjJtw8wGnNDYBz8
	2WLeqHqmB2487SWGQeN73TZ7VqhpNf3+tgcixobP0QtZKmRwevyv1yv8z
X-Received: by 2002:a17:903:32cf:b0:269:80e2:c5a8 with SMTP id d9443c01a7336-27ed4a36556mr42844545ad.7.1758871657082;
        Fri, 26 Sep 2025 00:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPP+Ypu93N21m8S6kBgBSMJBRXMD3hXCuDSD66NazWdrAWQ5ZFGsGBW2MYZ9RZjYC42kBGag==
X-Received: by 2002:a17:903:32cf:b0:269:80e2:c5a8 with SMTP id d9443c01a7336-27ed4a36556mr42844195ad.7.1758871656533;
        Fri, 26 Sep 2025 00:27:36 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671d8a2sm45117985ad.55.2025.09.26.00.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:27:36 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 15:25:48 +0800
Subject: [PATCH v7 12/14] phy: qcom: qmp-usbc: Add QCS615 USB/DP PHY config
 and DP mode support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-add-displayport-support-for-qcs615-platform-v7-12-dc5edaac6c2b@oss.qualcomm.com>
References: <20250926-add-displayport-support-for-qcs615-platform-v7-0-dc5edaac6c2b@oss.qualcomm.com>
In-Reply-To: <20250926-add-displayport-support-for-qcs615-platform-v7-0-dc5edaac6c2b@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758871564; l=17174;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=bAcJPNht/+rnG7uZv7s+NNJvq4heKp19LQ+dsihcBNQ=;
 b=9Vrv75s6dH1x+rP9Q3wQeDjWty1+Ijt9S1ZGYrYcSefijB25kVFVo3D7RY/bZE30aFJdrF3uC
 ew1kwEGd6GKD8CgOPyshFBl3m8KDk5BjkvEvdXtyLhIFWXIBgDvqy2W
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-ORIG-GUID: m1aIzoG5YbS-lqcorebcdQiIJh590CVQ
X-Proofpoint-GUID: m1aIzoG5YbS-lqcorebcdQiIJh590CVQ
X-Authority-Analysis: v=2.4 cv=Jvz8bc4C c=1 sm=1 tr=0 ts=68d6406b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=shGh-05uZheFR9ghjlIA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX+Pbm/BG1T0LB
 sYemoXRoWmGxI1c5qw4Oez2cmEjOTf+xz6mrbwcmTSlGrHiG7IXmbjUcZwXV/9nv2tEEZSG7jCG
 y0U5NxGCp1pSjlspQHB5qXoYh9EHf4IzhnqQ2O4hdG2fXYtkus2k0KMelsfLuRvjAwY5U/SOrZe
 /pDE5LNyVh/yf3Njti7+ZX8xhccprGzI/vtpdaTTSr0kYYb/8Hn1rfIOovohAiJOEpKy8ZXz5Oo
 zTjR8tHRLIHg8uDaH8Yvqj0TPNUrUocLxlZAbXXSBkWcupZVu2Eat3HuljWcYd6HQHjHXYtE9da
 9sTjTdc3tEXDlV6N3lPImmsfXN2Bf72ueA8HIiXVU6DsZZYep2+K9BP515yhsE3oBxeKG5OAyM4
 hoEwsKJNKm8fJOOM/GSFDYkuThwPkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

Add QCS615-specific configuration for USB/DP PHY, including DP init
routines, voltage swing tables, and platform data. Add compatible
"qcs615-qmp-usb3-dp-phy".

Note: SW_PORTSELECT handling for orientation flip is not implemented
due to QCS615 fixed-orientation design and non-standard lane mapping.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 413 +++++++++++++++++++++++++++++++
 1 file changed, 413 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index d84bf68940043bce13565503bb34796e653adbb7..105cc0f4b8dddeed2431d64c2be44bda73f6000a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -30,6 +30,7 @@
 #include "phy-qcom-qmp-pcs-misc-v3.h"
 
 #include "phy-qcom-qmp-dp-phy.h"
+#include "phy-qcom-qmp-dp-phy-v2.h"
 
 #define PHY_INIT_COMPLETE_TIMEOUT		10000
 #define SW_PORTSELECT_VAL			BIT(0)
@@ -289,6 +290,83 @@ static const struct qmp_phy_init_tbl qcm2290_usb3_pcs_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
 };
 
+static const struct qmp_phy_init_tbl qmp_v2_dp_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_COM_SVS_MODE_CLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_EN_SEL, 0x37),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SYS_CLK_CTRL, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BIAS_EN_CLKBUFLR_EN, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_ENABLE1, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BG_CTRL, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_SYSCLK_BUF_ENABLE, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_CCTRL_MODE0, 0x28),
+	QMP_PHY_INIT_CFG(QSERDES_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CP_CTRL_MODE0, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN0_MODE0, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_MAP, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_BG_TIMER, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CORECLK_DIV, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_CTRL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE2_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_VCO_TUNE_CTRL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CORE_CLK_EN, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_CMN_CONFIG, 0x02),
+};
+
+static const struct qmp_phy_init_tbl qmp_v2_dp_serdes_tbl_rbr[] = {
+	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x2c),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x69),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x21),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
+};
+
+static const struct qmp_phy_init_tbl qmp_v2_dp_serdes_tbl_hbr[] = {
+	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x69),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
+};
+
+static const struct qmp_phy_init_tbl qmp_v2_dp_serdes_tbl_hbr2[] = {
+	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x8c),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x70),
+	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
+};
+
+static const struct qmp_phy_init_tbl qmp_v2_dp_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_TRANSCEIVER_BIAS_EN, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_VMODE_CTRL1, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_PRE_STALL_LDO_BOOST_EN, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_INTERFACE_SELECT, 0x3d),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_CLKBUF_ENABLE, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_RESET_TSYNC_EN, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_TRAN_DRVR_EMP_EN, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_PARRATE_REC_DETECT_IDLE_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_TX_INTERFACE_MODE, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_TX_EMP_POST1_LVL, 0x2b),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_TX_DRV_LVL, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_TX_BAND, 0x4),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_RES_CODE_LANE_OFFSET_TX, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V2_TX_RES_CODE_LANE_OFFSET_RX, 0x12),
+};
+
 struct qmp_usbc_offsets {
 	u16 serdes;
 	u16 pcs;
@@ -434,6 +512,10 @@ static const char * const usb3phy_reset_l[] = {
 	"phy_phy", "phy",
 };
 
+static const char * const usb3dpphy_reset_l[] = {
+	"phy_phy", "dp_phy",
+};
+
 static const struct regulator_bulk_data qmp_phy_msm8998_vreg_l[] = {
 	{ .supply = "vdda-phy", .init_load_uA = 68600 },
 	{ .supply = "vdda-pll", .init_load_uA = 14200 },
@@ -459,6 +541,34 @@ static const struct qmp_usbc_offsets qmp_usbc_offsets_v3_qcm2290 = {
 	.rx2		= 0x800,
 };
 
+static const struct qmp_usbc_offsets qmp_usbc_usb3dp_offsets_qcs615 = {
+	.serdes		= 0x0,
+	.pcs		= 0xc00,
+	.pcs_misc	= 0xa00,
+	.tx		= 0x200,
+	.rx		= 0x400,
+	.tx2		= 0x600,
+	.rx2		= 0x800,
+	.dp_serdes	= 0x1c00,
+	.dp_txa		= 0x1400,
+	.dp_txb		= 0x1800,
+	.dp_dp_phy	= 0x1000,
+};
+
+static const u8 qmp_v2_dp_pre_emphasis_hbr2_rbr[4][4] = {
+	{0x00, 0x0b, 0x12, 0xff},
+	{0x00, 0x0a, 0x12, 0xff},
+	{0x00, 0x0c, 0xff, 0xff},
+	{0xff, 0xff, 0xff, 0xff}
+};
+
+static const u8 qmp_v2_dp_voltage_swing_hbr2_rbr[4][4] = {
+	{0x07, 0x0f, 0x14, 0xff},
+	{0x11, 0x1d, 0x1f, 0xff},
+	{0x18, 0x1f, 0xff, 0xff},
+	{0xff, 0xff, 0xff, 0xff}
+};
+
 static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
 	.offsets		= &qmp_usbc_offsets_v3_qcm2290,
 
@@ -531,6 +641,51 @@ static const struct qmp_phy_cfg qcs615_usb3phy_cfg = {
 	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
 };
 
+static void qmp_v2_dp_aux_init(struct qmp_usbc *qmp);
+static void qmp_v2_configure_dp_tx(struct qmp_usbc *qmp);
+static int qmp_v2_configure_dp_phy(struct qmp_usbc *qmp);
+static int qmp_v2_calibrate_dp_phy(struct qmp_usbc *qmp);
+
+static const struct qmp_phy_cfg qcs615_usb3dp_phy_cfg = {
+	.offsets		= &qmp_usbc_usb3dp_offsets_qcs615,
+
+	.serdes_tbl		= qcm2290_usb3_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(qcm2290_usb3_serdes_tbl),
+	.tx_tbl			= qcm2290_usb3_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_tx_tbl),
+	.rx_tbl			= qcm2290_usb3_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(qcm2290_usb3_rx_tbl),
+	.pcs_tbl		= qcm2290_usb3_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(qcm2290_usb3_pcs_tbl),
+
+	.regs			= qmp_v3_usb3phy_regs_layout_qcm2290,
+
+	.dp_serdes_tbl		= qmp_v2_dp_serdes_tbl,
+	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v2_dp_serdes_tbl),
+	.dp_tx_tbl		= qmp_v2_dp_tx_tbl,
+	.dp_tx_tbl_num		= ARRAY_SIZE(qmp_v2_dp_tx_tbl),
+
+	.serdes_tbl_rbr		= qmp_v2_dp_serdes_tbl_rbr,
+	.serdes_tbl_rbr_num	= ARRAY_SIZE(qmp_v2_dp_serdes_tbl_rbr),
+	.serdes_tbl_hbr		= qmp_v2_dp_serdes_tbl_hbr,
+	.serdes_tbl_hbr_num	= ARRAY_SIZE(qmp_v2_dp_serdes_tbl_hbr),
+	.serdes_tbl_hbr2	= qmp_v2_dp_serdes_tbl_hbr2,
+	.serdes_tbl_hbr2_num	= ARRAY_SIZE(qmp_v2_dp_serdes_tbl_hbr2),
+
+	.swing_tbl		= &qmp_v2_dp_voltage_swing_hbr2_rbr,
+	.pre_emphasis_tbl	= &qmp_v2_dp_pre_emphasis_hbr2_rbr,
+
+	.dp_aux_init		= qmp_v2_dp_aux_init,
+	.configure_dp_tx	= qmp_v2_configure_dp_tx,
+	.configure_dp_phy	= qmp_v2_configure_dp_phy,
+	.calibrate_dp_phy	= qmp_v2_calibrate_dp_phy,
+
+	.reset_list		= usb3dpphy_reset_l,
+	.num_resets		= ARRAY_SIZE(usb3dpphy_reset_l),
+	.vreg_list		= qmp_phy_qcs615_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_qcs615_vreg_l),
+};
+
 static void qmp_usbc_set_phy_mode(struct qmp_usbc *qmp, bool is_dp)
 {
 	if (qmp->tcsr_map && qmp->dp_phy_mode_reg)
@@ -589,6 +744,253 @@ static int qmp_usbc_com_exit(struct phy *phy)
 	return 0;
 }
 
+static void qmp_v2_dp_aux_init(struct qmp_usbc *qmp)
+{
+	writel(DP_PHY_PD_CTL_AUX_PWRDN |
+	       DP_PHY_PD_CTL_LANE_0_1_PWRDN | DP_PHY_PD_CTL_LANE_2_3_PWRDN |
+	       DP_PHY_PD_CTL_PLL_PWRDN,
+	       qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
+
+	writel(DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
+	       DP_PHY_PD_CTL_LANE_0_1_PWRDN | DP_PHY_PD_CTL_LANE_2_3_PWRDN |
+	       DP_PHY_PD_CTL_PLL_PWRDN,
+	       qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
+
+	writel(0x00, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG0);
+	writel(0x13, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG1);
+	writel(0x00, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG2);
+	writel(0x00, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG3);
+	writel(0x0a, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG4);
+	writel(0x26, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG5);
+	writel(0x0a, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG6);
+	writel(0x03, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG7);
+	writel(0xbb, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG8);
+	writel(0x03, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG9);
+	qmp->dp_aux_cfg = 0;
+
+	writel(PHY_AUX_STOP_ERR_MASK | PHY_AUX_DEC_ERR_MASK |
+	       PHY_AUX_SYNC_ERR_MASK | PHY_AUX_ALIGN_ERR_MASK |
+	       PHY_AUX_REQ_ERR_MASK,
+	       qmp->dp_dp_phy + QSERDES_V2_DP_PHY_AUX_INTERRUPT_MASK);
+}
+
+static int qmp_v2_configure_dp_swing(struct qmp_usbc *qmp)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
+	void __iomem *tx = qmp->dp_tx;
+	void __iomem *tx2 = qmp->dp_tx2;
+	unsigned int v_level = 0, p_level = 0;
+	u8 voltage_swing_cfg, pre_emphasis_cfg;
+	int i;
+
+	if (dp_opts->lanes > 4) {
+		dev_err(qmp->dev, "Invalid lane_num(%d)\n", dp_opts->lanes);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < dp_opts->lanes; i++) {
+		v_level = max(v_level, dp_opts->voltage[i]);
+		p_level = max(p_level, dp_opts->pre[i]);
+	}
+
+	if (v_level > 4 || p_level > 4) {
+		dev_err(qmp->dev, "Invalid v(%d) | p(%d) level)\n",
+			v_level, p_level);
+		return -EINVAL;
+	}
+
+	voltage_swing_cfg = (*cfg->swing_tbl)[v_level][p_level];
+	pre_emphasis_cfg = (*cfg->pre_emphasis_tbl)[v_level][p_level];
+
+	voltage_swing_cfg |= DP_PHY_TXn_TX_DRV_LVL_MUX_EN;
+	pre_emphasis_cfg |= DP_PHY_TXn_TX_EMP_POST1_LVL_MUX_EN;
+
+	if (voltage_swing_cfg == 0xff && pre_emphasis_cfg == 0xff)
+		return -EINVAL;
+
+	writel(voltage_swing_cfg, tx + QSERDES_V2_TX_TX_DRV_LVL);
+	writel(pre_emphasis_cfg, tx + QSERDES_V2_TX_TX_EMP_POST1_LVL);
+	writel(voltage_swing_cfg, tx2 + QSERDES_V2_TX_TX_DRV_LVL);
+	writel(pre_emphasis_cfg, tx2 + QSERDES_V2_TX_TX_EMP_POST1_LVL);
+
+	return 0;
+}
+
+static void qmp_usbc_configure_dp_mode(struct qmp_usbc *qmp)
+{
+	bool reverse = (qmp->orientation == TYPEC_ORIENTATION_REVERSE);
+	u32 val;
+
+	val = DP_PHY_PD_CTL_PWRDN | DP_PHY_PD_CTL_AUX_PWRDN |
+	      DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_LANE_0_1_PWRDN | DP_PHY_PD_CTL_LANE_2_3_PWRDN;
+
+	writel(val, qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
+
+	if (reverse)
+		writel(0xc9, qmp->dp_dp_phy + QSERDES_DP_PHY_MODE);
+	else
+		writel(0xd9, qmp->dp_dp_phy + QSERDES_DP_PHY_MODE);
+}
+
+static int qmp_usbc_configure_dp_clocks(struct qmp_usbc *qmp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
+	u32 phy_vco_div;
+	unsigned long pixel_freq;
+
+	switch (dp_opts->link_rate) {
+	case 1620:
+		phy_vco_div = 0x1;
+		pixel_freq = 1620000000UL / 2;
+		break;
+	case 2700:
+		phy_vco_div = 0x1;
+		pixel_freq = 2700000000UL / 2;
+		break;
+	case 5400:
+		phy_vco_div = 0x2;
+		pixel_freq = 5400000000UL / 4;
+		break;
+	default:
+		dev_err(qmp->dev, "link rate:%d not supported\n", dp_opts->link_rate);
+		return -EINVAL;
+	}
+	writel(phy_vco_div, qmp->dp_dp_phy + QSERDES_V2_DP_PHY_VCO_DIV);
+
+	clk_set_rate(qmp->dp_link_hw.clk, dp_opts->link_rate * 100000);
+	clk_set_rate(qmp->dp_pixel_hw.clk, pixel_freq);
+
+	return 0;
+}
+
+static void qmp_v2_configure_dp_tx(struct qmp_usbc *qmp)
+{
+	const struct phy_configure_opts_dp *dp_opts = &qmp->dp_opts;
+	void __iomem *tx = qmp->dp_tx;
+	void __iomem *tx2 = qmp->dp_tx2;
+
+	/* program default setting first */
+	writel(0x2a, tx + QSERDES_V2_TX_TX_DRV_LVL);
+	writel(0x20, tx + QSERDES_V2_TX_TX_EMP_POST1_LVL);
+	writel(0x2a, tx2 + QSERDES_V2_TX_TX_DRV_LVL);
+	writel(0x20, tx2 + QSERDES_V2_TX_TX_EMP_POST1_LVL);
+
+	if (dp_opts->link_rate >= 2700) {
+		writel(0xc4, tx + QSERDES_V2_TX_LANE_MODE_1);
+		writel(0xc4, tx2 + QSERDES_V2_TX_LANE_MODE_1);
+	} else {
+		writel(0xc6, tx + QSERDES_V2_TX_LANE_MODE_1);
+		writel(0xc6, tx2 + QSERDES_V2_TX_LANE_MODE_1);
+	}
+
+	qmp_v2_configure_dp_swing(qmp);
+}
+
+static int qmp_v2_configure_dp_phy(struct qmp_usbc *qmp)
+{
+	u32 status;
+	int ret;
+
+	qmp_usbc_configure_dp_mode(qmp);
+
+	writel(0x05, qmp->dp_dp_phy + QSERDES_V2_DP_PHY_TX0_TX1_LANE_CTL);
+	writel(0x05, qmp->dp_dp_phy + QSERDES_V2_DP_PHY_TX2_TX3_LANE_CTL);
+
+	ret = qmp_usbc_configure_dp_clocks(qmp);
+	if (ret)
+		return ret;
+
+	writel(0x01, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
+	writel(0x05, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
+	writel(0x01, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
+	writel(0x09, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
+
+	writel(0x20, qmp->dp_serdes + QSERDES_COM_RESETSM_CNTRL);
+
+	if (readl_poll_timeout(qmp->dp_serdes + QSERDES_COM_C_READY_STATUS,
+			       status,
+			       ((status & BIT(0)) > 0),
+			       500,
+			       10000)) {
+		dev_err(qmp->dev, "C_READY not ready\n");
+		return -ETIMEDOUT;
+	}
+
+	if (readl_poll_timeout(qmp->dp_serdes + QSERDES_COM_CMN_STATUS,
+			       status,
+			       ((status & BIT(0)) > 0),
+			       500,
+			       10000)){
+		dev_err(qmp->dev, "FREQ_DONE not ready\n");
+		return -ETIMEDOUT;
+	}
+
+	if (readl_poll_timeout(qmp->dp_serdes + QSERDES_COM_CMN_STATUS,
+			       status,
+			       ((status & BIT(1)) > 0),
+			       500,
+			       10000)){
+		dev_err(qmp->dev, "PLL_LOCKED not ready\n");
+		return -ETIMEDOUT;
+	}
+
+	writel(0x19, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
+
+	if (readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V2_DP_PHY_STATUS,
+			       status,
+			       ((status & BIT(0)) > 0),
+			       500,
+			       10000)){
+		dev_err(qmp->dev, "TSYNC_DONE not ready\n");
+		return -ETIMEDOUT;
+	}
+
+	if (readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V2_DP_PHY_STATUS,
+			       status,
+			       ((status & BIT(1)) > 0),
+			       500,
+			       10000)){
+		dev_err(qmp->dev, "PHY_READY not ready\n");
+		return -ETIMEDOUT;
+	}
+
+	writel(0x3f, qmp->dp_tx + QSERDES_V2_TX_TRANSCEIVER_BIAS_EN);
+	writel(0x10, qmp->dp_tx + QSERDES_V2_TX_HIGHZ_DRVR_EN);
+	writel(0x0a, qmp->dp_tx + QSERDES_V2_TX_TX_POL_INV);
+	writel(0x3f, qmp->dp_tx2 + QSERDES_V2_TX_TRANSCEIVER_BIAS_EN);
+	writel(0x10, qmp->dp_tx2 + QSERDES_V2_TX_HIGHZ_DRVR_EN);
+	writel(0x0a, qmp->dp_tx2 + QSERDES_V2_TX_TX_POL_INV);
+
+	writel(0x18, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
+	writel(0x19, qmp->dp_dp_phy + QSERDES_DP_PHY_CFG);
+
+	if (readl_poll_timeout(qmp->dp_dp_phy + QSERDES_V2_DP_PHY_STATUS,
+			       status,
+			       ((status & BIT(1)) > 0),
+			       500,
+			       10000)){
+		dev_err(qmp->dev, "PHY_READY not ready\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int qmp_v2_calibrate_dp_phy(struct qmp_usbc *qmp)
+{
+	static const u8 cfg1_settings[] = {0x13, 0x23, 0x1d};
+	u8 val;
+
+	qmp->dp_aux_cfg++;
+	qmp->dp_aux_cfg %= ARRAY_SIZE(cfg1_settings);
+	val = cfg1_settings[qmp->dp_aux_cfg];
+
+	writel(val, qmp->dp_dp_phy + QSERDES_DP_PHY_AUX_CFG1);
+
+	return 0;
+}
+
 static int qmp_usbc_usb_power_on(struct phy *phy)
 {
 	struct qmp_usbc *qmp = phy_get_drvdata(phy);
@@ -855,6 +1257,14 @@ static int qmp_usbc_dp_power_on(struct phy *phy)
 	void __iomem *tx = qmp->dp_tx;
 	void __iomem *tx2 = qmp->dp_tx2;
 
+	/*
+	 * FIXME: SW_PORTSELECT handling for DP orientation flip is not implemented.
+	 * Expected:
+	 * - For standard lane mapping: configure SW_PORTSELECT in QSERDES_DP_PHY_CFG_1.
+	 * - For non-standard mapping: pass orientation to dp_ctrl and handle flip
+	 *   via logical2physical lane remapping.
+	 */
+
 	mutex_lock(&qmp->phy_mutex);
 
 	qmp_usbc_dp_serdes_init(qmp);
@@ -1601,6 +2011,9 @@ static const struct of_device_id qmp_usbc_of_match_table[] = {
 	}, {
 		.compatible = "qcom,qcm2290-qmp-usb3-phy",
 		.data = &qcm2290_usb3phy_cfg,
+	}, {
+		.compatible = "qcom,qcs615-qmp-usb3-dp-phy",
+		.data =  &qcs615_usb3dp_phy_cfg,
 	}, {
 		.compatible = "qcom,qcs615-qmp-usb3-phy",
 		.data = &qcs615_usb3phy_cfg,

-- 
2.34.1


