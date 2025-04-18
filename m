Return-Path: <linux-kernel+bounces-610348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F159A933E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 09:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39E3467834
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 07:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950F726FDB6;
	Fri, 18 Apr 2025 07:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XeegHoj9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290A126FDB5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962618; cv=none; b=dYSp6Lv6mMbYFSwilykogfXTcL+CadMLQXiXybi022ccFwRjIUkxnoAoZHnilUvODM16bnkoHF8nN8DrqoSzNjluKM0lJx6odKhEOPg1Tg6uuQdiqq55VJ/TjEttd00cmeiazLBnJ6MRJ8x2zeO9U1RA+zmXwjjdO0PBu8B5p80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962618; c=relaxed/simple;
	bh=+1no2bmgs6MuDDaz2UkyIJNIWjs3RXM03IY6VUWb8zE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tVOXM/maPr6X/MWiXRjyW8ws2rF7RFPUauVQDzRqXWy+4jsu9vnOeSQ+f2GKOC+mTMzekg03NeDid+w/Hf90MEztrYTvaQWVznhTc3uQKqn1sohwMe1Iht1JdA12yed3LKijPjHUzVBMLPXJa8WAUdU6vNx85RSk0Cwko/I29SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XeegHoj9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I26VYv013261
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 07:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M3jJd3tpX3la7lvYFrEWmDfyU53nCPlZfvukoqDcIKc=; b=XeegHoj9jHtykDbM
	ta0q3arlee9WC4O9TiKohQ3azh1jTlZcv9C2Cf0sOGv5Q9h4kFZbYLLnqohiPF+q
	7GWu7NOkF+tyrMQTZZwpIOy03WCX5wz6xGgnuaJZOjhlHm7I3Udm2WpWv0pncgAv
	47wGRBReKyLTvCDHjOd982TmQKfC/03dpzn8mqdPif43nA/5uTPHbEiY5IDvLhWe
	VCa/MPP831BBERBjDTn4S8jQl27gOfNlsrQgvY3LqSLW7go71bFWEjqWZCVP6vnE
	dB1ENa/ok4YIQR9wEJKyCVZ2Fshv/3g4oztzWTsID7MoLWzneElzXtd3V7ytLDnk
	uiSNRg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4628rvepfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 07:50:16 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5d9d8890fso480197085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 00:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744962615; x=1745567415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3jJd3tpX3la7lvYFrEWmDfyU53nCPlZfvukoqDcIKc=;
        b=j4CdW0no2gBWCtlPaTxBiHGtXo4cnAy0LfOjcZiWTfoK7SBnzwQiCmXkgYlN6U8She
         tyBSxG1I3b9EonMpR+Ejj7DYTfKh2T2PVc75C2p+5IS+b5hw3FKqZZfS7aS0ckSrMK8l
         LwGRFMGpTQX/fLk3lPnGs3Gsx1PwY8OiszSn+dk89FUIYamUPgP2sJQ+ep2O9oSfACcZ
         FuiSC2VH3tDaqp9VlR+2WjphorrWlIsEDncysuAtbGvuH656+BVXDsPvOdXOwCrVn+54
         a1khnU41kTZgyAYUmlI4EM9ci4BxnGIJrISI7YVhEWBI/a0KLjJJSwmRRM+wq1yzVVgn
         tm+A==
X-Forwarded-Encrypted: i=1; AJvYcCUKhycuVHtRWP9EVYCWs6WqJT4EZY/U2Cu0Xr3eaUS+w4OK+BV3P/nis3Y2EI2VYkGd0bkgpvVM2hGdd3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YztzCWkZZwbXdmof9M+k9OK+Yx87neGdPyjK877dn1SXsbQPj1D
	+q/LN/IvnEwHAp0pVVztFC+XtILFErv8zhv4GQD+GjStiwc60fvIPH2pC65/owTN5HK/RfvYdi4
	7+ysQBfIjGbpsRwvWXv6psnc1VwzBwlH76GL/vyO9mb1BCaB2Lie6m9wquM99kEY=
X-Gm-Gg: ASbGncsLQP1wZlqGPxMM0dMwCj7mJRWh3WdfT/qHpkRRrxE2AltOs1RB8nZgZ7s01fb
	h0N7ed9NqMxYxF03oFrhfZO47M5encQETlCcqk67VwKp+juWOBEXaNmXYw5HvAVVCaraGssYHvM
	S/TQVqEiwGtKZG7NphNLXUHMV/AjKaC6699KExrnh1LAm9wVRfcFmrvrcWmWU7CV2zMi5EWEqsr
	o561PjH0mbPevV33S31FNv5UnSXeQtc/LmRNb74w8Ae8FoijSnvH+GdadP7HxHC7y+sdz56X6Wo
	ZS2E+GUlyyoK/XNlDGkN9GGBmBAcgQlIFbedYxhsIFMRj96TASReO2pWM7ZsYioBBJS1kX0mgDI
	y1DNRHkhmWDf/aIlHQbSEpMdF
X-Received: by 2002:a05:620a:1a0e:b0:7c5:6b46:e1f6 with SMTP id af79cd13be357-7c92573799dmr456562785a.1.1744962614967;
        Fri, 18 Apr 2025 00:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZhz7yFLC0lcOmPg14/IfBCqziyWqNbF40pJZIIcJDYe6mx7+7YBKTQoKiG7zT1FHjhFY7/A==
X-Received: by 2002:a05:620a:1a0e:b0:7c5:6b46:e1f6 with SMTP id af79cd13be357-7c92573799dmr456559885a.1.1744962614626;
        Fri, 18 Apr 2025 00:50:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-31090863bd0sm1649061fa.113.2025.04.18.00.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 00:50:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Apr 2025 10:50:02 +0300
Subject: [PATCH v5 07/10] drm/msm/dsi/phy: add configuration for SAR2130P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-sar2130p-display-v5-7-442c905cb3a4@oss.qualcomm.com>
References: <20250418-sar2130p-display-v5-0-442c905cb3a4@oss.qualcomm.com>
In-Reply-To: <20250418-sar2130p-display-v5-0-442c905cb3a4@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3195;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=VXFGPbLULr+xGELX+USGVkfaqafdytyi08lrC/x1doQ=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQwYTi6a2Wr67jEC9QrnSD+lo0YmlQd+Zve2SfD1/nGq9u
 KKT70AnozELAyMXg6yYIotPQcvUmE3JYR92TK2HGcTKBDKFgYtTACZS1cnBsFy0yGSlf935k8c8
 /H+oJh6bGXGv79vWPVfWGyrYybjsyhKXPVm16rnw5bdh+hITGx4sV451eT+bk2UFD+OCGdGXA6q
 seR1EDA9GblcqsWbepvJWOfji9Bk+/DKyKfsbOnqmVX6fc/ZOxK2KLJuOn+v8Y53a5389vJfdZD
 rHo/Occgc/ibDy/v8UsXw3o5iaxLJO1o5LpZeF/B88bt5+J3jVxKhzrbLb33ltf8KtJMnaeTHGI
 qPGqKdk+qSMCQ83vJzw9/dchWU/Pq8Kk0+ca2L7oSjlecO1e9Ge01z3m7FGST/8VKnXHf/g9KWX
 xTP8Fzal+Bo2yXkbbMrrlzQWrno5d8mELX+lnLpM0u27AA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 7srWN1_SmFzIxuoefHbOXP99_ezHirIu
X-Authority-Analysis: v=2.4 cv=RbSQC0tv c=1 sm=1 tr=0 ts=68020438 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=WWvJJprN3eueWNfT7O0A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 7srWN1_SmFzIxuoefHbOXP99_ezHirIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180056

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Qualcomm SAR2130P requires slightly different setup for the DSI PHY. It
is a 5nm PHY (like SM8450), so supplies are the same, but the rest of
the configuration is the same as SM8550 DSI PHY.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c     |  2 ++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |  1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 23 +++++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index c0bcc68289633fd7506ce4f1f963655d862e8f08..a58bafe9fe8635730cb82e8c82ec1ded394988cd 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -581,6 +581,8 @@ static const struct of_device_id dsi_phy_dt_match[] = {
 	  .data = &dsi_phy_7nm_cfgs },
 	{ .compatible = "qcom,dsi-phy-7nm-8150",
 	  .data = &dsi_phy_7nm_8150_cfgs },
+	{ .compatible = "qcom,sar2130p-dsi-phy-5nm",
+	  .data = &dsi_phy_5nm_sar2130p_cfgs },
 	{ .compatible = "qcom,sc7280-dsi-phy-7nm",
 	  .data = &dsi_phy_7nm_7280_cfgs },
 	{ .compatible = "qcom,sm6375-dsi-phy-7nm",
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
index 1925418d9999a24263d6621299cae78f1fb9455c..1ed08b56e056094bc0096d07d4470b89d9824060 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
@@ -59,6 +59,7 @@ extern const struct msm_dsi_phy_cfg dsi_phy_7nm_8150_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_7nm_7280_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8350_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8450_cfgs;
+extern const struct msm_dsi_phy_cfg dsi_phy_5nm_sar2130p_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_4nm_8550_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_4nm_8650_cfgs;
 
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index a92decbee5b5433853ed973747f7705d9079068d..cad55702746b8d35949d22090796cca60f03b9e1 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -1289,6 +1289,29 @@ const struct msm_dsi_phy_cfg dsi_phy_5nm_8450_cfgs = {
 	.quirks = DSI_PHY_7NM_QUIRK_V4_3,
 };
 
+const struct msm_dsi_phy_cfg dsi_phy_5nm_sar2130p_cfgs = {
+	.has_phy_lane = true,
+	.regulator_data = dsi_phy_7nm_97800uA_regulators,
+	.num_regulators = ARRAY_SIZE(dsi_phy_7nm_97800uA_regulators),
+	.ops = {
+		.enable = dsi_7nm_phy_enable,
+		.disable = dsi_7nm_phy_disable,
+		.pll_init = dsi_pll_7nm_init,
+		.save_pll_state = dsi_7nm_pll_save_state,
+		.restore_pll_state = dsi_7nm_pll_restore_state,
+		.set_continuous_clock = dsi_7nm_set_continuous_clock,
+	},
+	.min_pll_rate = 600000000UL,
+#ifdef CONFIG_64BIT
+	.max_pll_rate = 5000000000UL,
+#else
+	.max_pll_rate = ULONG_MAX,
+#endif
+	.io_start = { 0xae95000, 0xae97000 },
+	.num_dsi_phy = 2,
+	.quirks = DSI_PHY_7NM_QUIRK_V5_2,
+};
+
 const struct msm_dsi_phy_cfg dsi_phy_4nm_8550_cfgs = {
 	.has_phy_lane = true,
 	.regulator_data = dsi_phy_7nm_98400uA_regulators,

-- 
2.39.5


