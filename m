Return-Path: <linux-kernel+bounces-784895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B02B34328
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819D5189FCC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E6A2FC88B;
	Mon, 25 Aug 2025 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AFtimOF3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F62FA0FD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131454; cv=none; b=d9W1GBo7EnyB2Rvz9mMY0xhFCEP9XBXzBPGj4tBqcB8ic9Y0smCfuklGh2mg6BJz8c9jPLXpdUt0XsWbbhpM9fdxrGbwwUsCfpYVuSoLpP3+V1XNJ+D2eShaGL10+rUv5PXrTASBVakEqRAqvw11MZp5xrjb35X7cfEeuoxMlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131454; c=relaxed/simple;
	bh=xDy9ih89F5xZ4CDJXV+M2TH1QImXV64VcC6JWSBfCEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YmZTvrGUwVzMtsd9IHe8I5sefZHFI8kYICXn79KowoFMEShHdspov3PfI0wTSC51Q2nxl6UbN5yjMxvGjqyvweChzCn3Rp+hrkJMlTrRPHj6RkgioH5mwEV4dhd5a7s7GOn1V1tH/x+R3mHiin5o8wU6ev6g72zpE9u5HdMZ2fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AFtimOF3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P9Hpfc019199
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PAyYDRJsaYxENoD1H+Eu1JmDIGkAgeAFYSQHnGRM3UY=; b=AFtimOF3rqirlD3m
	InM/Vy4yl3Eo9+uQN8Li8wURib3geERHcfgPP9k/Ls96x8/uYjHukzkeXBcGa06o
	fiKwTAgPuc6g/ccwJkG7pq3piwfZXHhtNeR7ZaZ6mPldp+7v563nvmDuPbghtj1V
	aV83HXzUhLXXRFlAACoR/ZxNZe+SQu1YLeJrPPNvUSAjCF3ANn3ln+ByyUgEZx/k
	+p9K5l7QkCcp75XoiTdxgphafjHBDBbBssk9CspRj8q1UZr5iL9lKduy1vQ+LpGV
	i6U+Vc3oiORgXSJ4U9+NjKNO2HLpjji+7iZ8htQIpgwCOZD+DR0TMOY7EdmcHZHF
	piJM6Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5uc57es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:31 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-770d7a5f812so1001670b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131450; x=1756736250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAyYDRJsaYxENoD1H+Eu1JmDIGkAgeAFYSQHnGRM3UY=;
        b=sHvk06PXMWvCM0izjwndTc9RCFtP8vHElxZKyNSKGCgqWec/GG2tztwEEj20B+S7l6
         Sp+TqKKL5vEKQnkc8NgrTTLSqNFhRJh4gbk3zu/C5vc0I6ibdWDwutDVxz45ie6ym2wc
         UTmK32boeRk5bI4Dm0qFJgYxDXF97TwGpkf1TZ2xb/CcDSMUnzVYmHw2MbYL3jOxzd0W
         4/l48vT2whWu8RnajMUawZMk4KvcEvWONZkZX7AbrKFsVSOLCrAkQqa0Og+7DUa7XQ9v
         C1Z/2WgPTMW76Qpi7nJRk/dMjov57ZqmeIB8wPGMxUDj1A8JBMeZCdwNk+p1jagujo4S
         cUoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPqtSMiZimLZIVMogfK4don8vsmceVDJtQVH2/yoKw4pNzkQIiisZBJhxR5NqKG1WYKW05OgBVIDvSt18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7EqFNKL+K5eJG3fZGTDh0uyq4MEQunggBkATPHyME5N9PqtCM
	7TPcp7lvaCLmvmYA2lrGxTEoSDA4OldNLz190Det9kvnmfBIpT+7LrIPTnQv2kdz9zLD+lUW72R
	PXOOHvPLIpxQJWr9wWyxyuSvG9I2VueIhBKhee23rboOTPPuhna+8pWqo1Bs0XHxd2Ok=
X-Gm-Gg: ASbGncst6UUQy7bRa5Bp+bfGRibp4W+9w/xvzH11FA2CcaKwulEWQV6v5XrudgovS2a
	1AQ+0RVX62bwTwS6I/LN+3Bf3xsadtk3oTGjwAKWfgOY26GqrvguriQi18YM7yG/SE8oNKdwLyw
	g2VCCYSaHhYDdzRqGYbh8lxYzvU/Ag8JoYNzWy2e5viHkLJfNC03dCG6afTF9gBFeIv02GX1XKx
	fDJb0/QZlZeezlhob1AgfDM6BgfXCUxQ8MYmU+W/rljrNRXvjsOiAFFEM6X7OwCIWNB/W3DtL6L
	ComZIJc42aARTkXzG7fGPz2kb0i5k5KVgXhyLDcHe75taucJRXG3CE0TygU8paRURqqSWZM=
X-Received: by 2002:a05:6a21:328b:b0:240:27c:fcc6 with SMTP id adf61e73a8af0-24340d72168mr17478404637.42.1756131450081;
        Mon, 25 Aug 2025 07:17:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1nessZyA2NUMM89H1JrLWKePi/2394p08eRkWbRWq2iI3n+M5I1Y5+xYaNlVn6ePDJ2+MlQ==
X-Received: by 2002:a05:6a21:328b:b0:240:27c:fcc6 with SMTP id adf61e73a8af0-24340d72168mr17478356637.42.1756131449523;
        Mon, 25 Aug 2025 07:17:29 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:17:29 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:15:51 +0800
Subject: [PATCH v3 05/38] drm/msm/dp: splite msm_dp_ctrl_config_ctrl() into
 link parts and stream parts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-5-01faacfcdedd@oss.qualcomm.com>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
In-Reply-To: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131419; l=4323;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=xDy9ih89F5xZ4CDJXV+M2TH1QImXV64VcC6JWSBfCEE=;
 b=HW0FUIhch/TGL/hUGl5G89eaxl3x6hc0kAZXKDW69RK9I7wUSBciqoAT8LB2FZMA4r7TMO3ac
 01pCbpqhSTDDtZEvPDPzk85/8vGANoPWg6CEiUr5N+bvhqy54ACMnqy
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX1P9V7MPsuEfj
 wTuae31v6qMxbUERZL4ckchc62Ch5ae3RWspXfSjjuKx7DzoiGODtljweSusTljZNXbAz28GezH
 tBaFeRaIpCzchvP16Zlc8uFxoe+nSs6BUO/3roolIPo6arvT+VK207EZKsVO8H2zZ4aa0v4QhSt
 kDpuQO87jGRtOz06BLI7rDtZtYlqK5F5C/y1a2wixJvLUNk6oXnoJpC5hrs9r3OJOt2rH9TJxXQ
 Vao/Hisy9vGTqdWUG1yyoqsZQ6B5ea9lOYEaViAIwnkG0U8F/R2Ulb1Qxt8ZrN/hkN72BwufVoa
 MddgrKWWspXgi4MizATiIraP+vW+YfLPx67DCas5qZ9hm/QA5MliC+yIxxjCqX5Hzv4pb7qmxHD
 ySZZPlwO
X-Proofpoint-ORIG-GUID: fmxjcy9xtrW0Fhnk-vfw-u2pYP7r9lJt
X-Authority-Analysis: v=2.4 cv=I85lRMgg c=1 sm=1 tr=0 ts=68ac707b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=A4lVjiY8PA1Kidclo-gA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: fmxjcy9xtrW0Fhnk-vfw-u2pYP7r9lJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230032

The DP_CONFIGURATION_CTRL register contains both link-level and
stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
all of them together, which makes it harder to support MST.

This patch separates the configuration into two functions:
- msm_dp_ctrl_config_ctrl_link(): handles link-related fields
- msm_dp_ctrl_config_ctrl_streams(): handles stream-specific fields

It also moves the link-related configuration out of
msm_dp_ctrl_configure_source_params().

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 49 +++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index e1ff4c6bb4f0eed2e1ff931f12ba891cf81feffb..45d6c9a7f7ddaa049443253cbf4c6fc5feda3177 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -380,26 +380,41 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
 	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
 }
 
-static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
+					    struct msm_dp_panel *msm_dp_panel)
 {
 	u32 config = 0, tbd;
+
+	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
+
+	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
+		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
+
+	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
+			msm_dp_panel->msm_dp_mode.bpp);
+
+	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
+
+	if (msm_dp_panel->psr_cap.version)
+		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
+
+	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
+
+	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
+}
+
+static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl)
+{
+	u32 config = 0;
 	const u8 *dpcd = ctrl->panel->dpcd;
 
 	/* Default-> LSCLK DIV: 1/4 LCLK  */
 	config |= (2 << DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT);
 
-	if (ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
-		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
-
 	/* Scrambler reset enable */
 	if (drm_dp_alternate_scrambler_reset_cap(dpcd))
 		config |= DP_CONFIGURATION_CTRL_ASSR;
 
-	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
-			ctrl->panel->msm_dp_mode.bpp);
-
-	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
-
 	/* Num of Lanes */
 	config |= ((ctrl->link->link_params.num_lanes - 1)
 			<< DP_CONFIGURATION_CTRL_NUM_OF_LANES_SHIFT);
@@ -413,10 +428,7 @@ static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
 	config |= DP_CONFIGURATION_CTRL_STATIC_DYNAMIC_CN;
 	config |= DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK;
 
-	if (ctrl->panel->psr_cap.version)
-		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
-
-	drm_dbg_dp(ctrl->drm_dev, "DP_CONFIGURATION_CTRL=0x%x\n", config);
+	drm_dbg_dp(ctrl->drm_dev, "link DP_CONFIGURATION_CTRL=0x%x\n", config);
 
 	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
 }
@@ -439,10 +451,7 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 {
 	u32 colorimetry_cfg, test_bits_depth, misc_val;
 
-	msm_dp_ctrl_lane_mapping(ctrl);
-	msm_dp_setup_peripheral_flush(ctrl);
-
-	msm_dp_ctrl_config_ctrl(ctrl);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
 
 	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
 	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
@@ -1614,7 +1623,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
 	u8 assr;
 	struct msm_dp_link_info link_info = {0};
 
-	msm_dp_ctrl_config_ctrl(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
 
 	link_info.num_lanes = ctrl->link->link_params.num_lanes;
 	link_info.rate = ctrl->link->link_params.rate;
@@ -2524,6 +2533,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	 */
 	reinit_completion(&ctrl->video_comp);
 
+	msm_dp_ctrl_lane_mapping(ctrl);
+	msm_dp_setup_peripheral_flush(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+
 	msm_dp_ctrl_configure_source_params(ctrl);
 
 	msm_dp_ctrl_config_msa(ctrl,

-- 
2.34.1


