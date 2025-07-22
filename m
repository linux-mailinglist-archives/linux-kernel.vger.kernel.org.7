Return-Path: <linux-kernel+bounces-740330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBE0B0D2DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA10188F124
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06D72D0298;
	Tue, 22 Jul 2025 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nb2lJZoK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89452DC347
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169022; cv=none; b=uzYplyEln3xmxBXqmht2WHI2i5HsIQerWiPaN8Z7JGOn/cEmoAmlVSSEyY1k+kBGd7DmFrlWuppKB7kM8V3ZFdPNT/7HGtVpw6UXS1qoZTP20Vm3ZUBmvYnLR8/1RibEaJK0u1r1D7jikb00FL9X3DUXJhMoN+bjL3QlGyYGnaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169022; c=relaxed/simple;
	bh=IqNy2UOlnRxZPX6+c35gyiwHyCJKZ2vyWBvAK40oYUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jjZWFqQNOtMyOss79FQnmSeVSOyCbieSi3dUcC3QLOjBB0+bseOTgeqjCjSymTXIhP6J2WsY3AtEtCuIEN/HyK4r0OTMRQYNkq3QnF//pKBOlPFiOAvc9VSgHP/ZnqspPFPD5iIjsIsFTSx+FvJhfmSLBjFLzV2r7OfKGZ2kANg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nb2lJZoK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LIg55o013043
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6T5LoZlt4M2Nfb5X+7vfdX4LAsIOmzT/JE+HlobZE30=; b=Nb2lJZoKQUj0tLuH
	eRFnlJbO4HBHeUIrBulW0/dZjwGRnZ6w5pOhm4JWHajPfwLFKMZJIfBodb2Wkm8a
	WrAj0g51s5ii0drQgY0tVfrqg54VZziMNKT+gpWe5D8o10Ik/s1dWGLnuGpJRUD1
	ssVpJH2CIyvOxBgTwMWhthE6MxTnvPXsmLxRi5pb1jWOuJdhMb4tEIDXGr9SQx/0
	vxputu7C0op/3W17gMHHTqtT6R9Z2XC/h+2IE1MLyM9cxiyXAhoHWCIWdHAKyENd
	/HXSlfxyAXuseIYGBMpY9uoj2QeCeKBmPaJrVAAUz9sWBISvkqILHf7laILObGzk
	PeqkjA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3eka62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:23:40 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3131cf89075so1363879a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753169019; x=1753773819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6T5LoZlt4M2Nfb5X+7vfdX4LAsIOmzT/JE+HlobZE30=;
        b=HQQqm+HjBZ7TsJkvM/y8kH5KOk3sKukuKO19fgZBwQO4zLzpwu5U9dBj9LS4TQAIPF
         sBrfvChKLSHHFCZmcpV8G4r1H/ryZJmBNkqYNYvfg3aolXtBD2i/yPbaBEB4FnYToxcv
         u36BXOmTd+ijPoFy3Y0AM6EyqsB8PGcIR9g8rb2oEwnPXpPiQGYIWwMrXpOR+Gpwzj31
         8r65DyxjfTKL+TfE6+n4jS8DGpyNh3r1Un2OER3aj+KuGt6U6Vn8zeHQHpDY0aTvt+8J
         vGuT+6iBZL2MIYqTCf4hJmY9srz9yFTveBr7lX3B4uSxEwxfXpGdtbKFIhtAHTpvlvgW
         4VfA==
X-Forwarded-Encrypted: i=1; AJvYcCVsNhENryiPh/oBtnziIMjdDm5KYuV6bM6J/Y7HKAvUKpC9jjkNJ3eVXrPLhnuwOnbnKl/5OvG+o7gyeBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGMmrd2TfDGzQzHDDIJU0eozQBtSa381/ZqcnjwC/c/8TmK2mX
	c/w5s9gMyKueFE91+Zxx2l6KV0IS4NC9iKlPwkYB4MJkmJe6MsAvVxGJ2vopwBrXgNCEBxKbAGn
	lnqG8q8SMz6g2mqfgjWfHB3tyuF8jWk4ak6DHp/xqft2YXaUgVpHpLO6P78FaxcLeI28=
X-Gm-Gg: ASbGncsoVnC/MzbI2EFOeNi9sulyOh3U0DVO5OA5f0+/q8hR3MmRAtJ7e6AjCQHpXLH
	8clrjiLdJGo0z3N3tsxysrnTGHfeVme44aWL9pttKx2JTX1xJkZM4qlBOOKGGV8srQRIwmEmmVX
	PsJgclIHuZ5EF23rcvaN6p5TjnhWbponNP11tjzCUqGZ5PuCFtI55XZYylke90sjje3l78NbZ36
	a+wN8tmVPpORPI6LteB5Rslw/A1q+LOSHHBjCuVTDMOYT+lNiLwgDOPXOPD+3kbc10rtMdxaARY
	hZgZMaPV55nsnTlqA1xsg4JyduDiHIuB3XV6t66eg43INa1qxeIwKoPoRSEbol3qILN5hI4Zof/
	sbx2bV/4JFeYomlgbQsi2A3Kh5TyLs/BUfaz1cg4y1tsAR7K+BCHr73Y8
X-Received: by 2002:a17:90a:da8d:b0:311:e8cc:4250 with SMTP id 98e67ed59e1d1-31c9e75ef95mr12583164a91.3.1753169019032;
        Tue, 22 Jul 2025 00:23:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUBkompgYp4NsbDBV07hVcCo1eE/2e6MRN+tw1ZOzoeY3VNs+3v9W92tzFmCZwxBRf2BDv7A==
X-Received: by 2002:a17:90a:da8d:b0:311:e8cc:4250 with SMTP id 98e67ed59e1d1-31c9e75ef95mr12583132a91.3.1753169018485;
        Tue, 22 Jul 2025 00:23:38 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e45e6csm7490753a91.3.2025.07.22.00.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:23:38 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 15:22:12 +0800
Subject: [PATCH v2 11/13] phy: qcom: qmp-usbc: Add QCS615 DP PHY compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-add-displayport-support-for-qcs615-platform-v2-11-42b4037171f8@oss.qualcomm.com>
References: <20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com>
In-Reply-To: <20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        fange.zhang@oss.qualcomm.com, quic_lliu6@quicinc.com,
        quic_yongmou@quicinc.com, Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753168938; l=1803;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=IqNy2UOlnRxZPX6+c35gyiwHyCJKZ2vyWBvAK40oYUw=;
 b=chI1sTIkkoEQ34btM+a8bsvY7GDpzMDyBcI0I765ZtJRv43IghZ0xyFcN8ZZvoqA0o1cTqVom
 /JIMtAyXyYsBWSgRb/wbBdHsI+7fA5OjpN64gKTST3z1uBj7gp9RO1t
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-ORIG-GUID: v39MBCA3Lt7qKU2yOq2nipwx_VXU88Be
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA1OSBTYWx0ZWRfX+kJxvXIbis0d
 YJgjiCX4k+SNU2PlKhLDXMpsS7OVWLN+P7lP9GxixAPfuyFP2uTtSZu4mgrD7Eg6qhAMerLbfCN
 E9MGPX12sNQh7AKs0JDxTWEzAzMtus/ZU4AXw/f4aMCKMDdx1QGr5jwbOrKyEPfSPGucV+iLHUX
 soN+MQtUhoWc82SoMan0/qqU/zw5DW588Q1T0QQyToA1CcQjFC/msywwM0+1W+S0/6D+bo6v5PR
 NIajIakWZXnGGN55egwlTRiYjJJbuPK3wERPEmJOujU8pRjQLTDO6+zhgXY5U/wxD6/NsRK6jfX
 2b7rQmUosLZernkeJ0w4lkI6C2fUIr8y9oaXGf9kDCn9Py0Tf0FIWAdcI0PFkeShcTxxphtr6Vo
 9hC4vxQKLSKY6nDgZ+V0CjNC+nZp9j/oQmonYZ6IzKYokQwBNZVUDJihL1JWVrZYcT/heVLl
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=687f3c7c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=CWFEUPHrMG6v4K5r7EwA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: v39MBCA3Lt7qKU2yOq2nipwx_VXU88Be
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220059

Register the QCS615 DP PHY via device tree by adding its compatible
string and associating it with the full DP PHY configuration.

With this change, the DP PHY driver for QCS615 is fully integrated:
- All required ops and flow are implemented
- Platform-specific configuration and init data are in place
- Compatible handling is aligned with USB3.0 PHY via type-based
  dispatch
- Supports coexistence with USB3.0 PHY through mutual exclusion based
  on shared TCSR region

This enables end-to-end support for DP PHY mode on QCS615 platforms.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index e97a206a10554b2d157d1fadd66d66386eec6c40..35fecf78736f7a6b9c3af6a89c71fd3ad9a87496 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -699,6 +699,11 @@ static const struct qmp_phy_cfg sdm660_phy_usb3_cfg = {
 	.cfg = &sdm660_usb3phy_cfg,
 };
 
+static const struct qmp_phy_cfg qcs615_phy_dp_cfg = {
+	.type = QMP_PHY_USBC_DP,
+	.cfg = &qcs615_dpphy_cfg,
+};
+
 #define to_usb_cfg(x) ((struct qmp_phy_usb_cfg *)((x)->cfg))
 #define to_dp_cfg(x) ((struct qmp_phy_dp_cfg *)((x)->cfg))
 #define to_usb_layout(x) ((struct qmp_phy_usb_layout *)((x)->layout))
@@ -2204,6 +2209,9 @@ static const struct of_device_id qmp_usbc_of_match_table[] = {
 	}, {
 		.compatible = "qcom,qcm2290-qmp-usb3-phy",
 		.data = &qcm2290_phy_usb3_cfg,
+	}, {
+		.compatible = "qcom,qcs615-qmp-dp-phy",
+		.data =  &qcs615_phy_dp_cfg,
 	}, {
 		.compatible = "qcom,qcs615-qmp-usb3-phy",
 		.data = &qcm2290_phy_usb3_cfg,

-- 
2.34.1


