Return-Path: <linux-kernel+bounces-784894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F9EB3431F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6CF8189B92C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2484B2FA0F7;
	Mon, 25 Aug 2025 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nPYWMbJ9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A992FAC1E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131451; cv=none; b=HsS/zX4/7d5FkUubvRaWKQpOXW8iMMrnGq4WMA61fHH692xmEs8RMbk0+Nfodf4XsIPlSSeRYGDlfWFdVECy/N8VfYnA29VP8GCZgC94eoCBKvsXn4XP7K6nI58AaG3qxTwR+SwoOihVbGyGPbTzJHcHZUQmQTCeNf+/imgJawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131451; c=relaxed/simple;
	bh=IN3IuT6i2XCS+CUhUzaXtJn87Di4DoLSuOnqFBj/8lQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=azY93DRi7K/SHpu1ax+Bq/oie5zkPgJHmZOWbtih/hFVNL9Y+GW/eaMNVZmByDnr7s8CtOPIByi3mjoTuNUvr7hLipkbuEEAU/tw/5w2+chWUdCiY3IK35AM85YQWrvor7oXaTMIL6aqroQUK43RJ00cfa9nETnDZVKTfw9aUqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nPYWMbJ9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8DPe4028623
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dhu2pyL0X/ioZ8T2TjoRhnhCcvCEY46TDbOm5EiNtvY=; b=nPYWMbJ997wyma8i
	R/b2CwTMPStWo9zsBpAwPU2z2BnpqbqKvsPk3rvULtT37RCicGvVWg012I/Jnw0r
	M5YcPWMYwT29GIf4Fr9GdTYsZBAeVRSSJwcppyQ9bdvjMsBwEpE5cB+XsNM+IP5G
	6GO2qsB0o6xJDvsqUQdkeBfFSK/LPR2LC47ww3O779qYJMYQJKCMaCWqKFyguG61
	lAqGnUHRNRGFvEfs3KFxam2/0mpsreiaXq8jZnGsQKlYifHX5ee7oFw5Vgp3ntmL
	iIAsLCI7RNhLSG4ShEiYtCbAwbnTCaVxCALB6K1wwwv7GsChB0M5ylGMg5AU+jUU
	1HT18A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615d919-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:27 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e395107e2so4233636b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131446; x=1756736246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhu2pyL0X/ioZ8T2TjoRhnhCcvCEY46TDbOm5EiNtvY=;
        b=mlI4Hz526geCbKHh8Zx6DgBce/jArq1N5o7xcyTwiSOlCkOkvS7soJj6YNUEQyQi2A
         rkmPU7TmCivnCoK2dZjXn0i9Wffw18wumYSbS3AOr4DPfGvVh+H8s7ZrZ2utx/4qAjfI
         biwWuHr2SEm/wuVqdrjQGAdCXhWRabU7Eab1CfoKZmNK/3Sn5fRHHkmXlvnfgjk6tdSU
         XxnPzncJGIOn7plO0N19igw9p1rYLvbAyZwat0SXeMZI3MkHR9bzcyY6YNqbEBtjM1nL
         xZ6jkUa3ZzvkveTtsHeGnI9Ztxj2qqu16X/b76ilr3OxRTTgTENnDJNv/RfXru5ieUau
         lMyg==
X-Forwarded-Encrypted: i=1; AJvYcCX5n1gLXijZabtmMF7vSyemibE6k/9u1IdGkqxarGUs2DU073MBKVMkhyKhOQGYP7sOj7V8zpLhSy9T+30=@vger.kernel.org
X-Gm-Message-State: AOJu0YzioEhc2YZVfbS7ZXbhhE+GhTUGKCyyRQdVkSVjTJXlg/jL2PvQ
	rkYsQ9XV0Wyrj+wOvTOnOW4hCkMCXPZ2ez0LmsYvVgSwpKU5l8fEYiEc2uWaDcgE7EFKO+kPWc0
	a4vKhqCkUyb/WJXpmDagWMTQUASO98CK2JI4uZIf1qI75MBO82ml3iN1kBAxjGdb3+xE=
X-Gm-Gg: ASbGncvmBT3idMuP668oEAPkyg7UEwYVty+RvOOaFk8elC7c9LuauyXs3DvLLE3flad
	r1kcSWUu4X1OZYCJBmmjiBk65xApIuzI7Ti5NLLST9rssGpOmGhBANmQvaS5iYwCMOV4JCWgAXe
	ttV/VKJhGh19XVNU7HRq1fjx2Uiy8x0dv5TMD3tTbvDlElPk0sILxKlVXnxE5y1MR3IdHrSwXAC
	iTRi3DRvUwg/iR1gr6bQndd6hEeg2fNtmfQo+tSpHlqG8uvdbwUUXAAcz4BV5d5IfodSFx31sXW
	cxJRpSLNFraSUTIfzNBQ5ef7jczFGmsP0zh4C0L8EnJKQK4A+w4Y2f8B2sVIrcmOJrIZeU0=
X-Received: by 2002:a05:6a00:10ce:b0:736:3979:369e with SMTP id d2e1a72fcca58-7702f9eb582mr15836890b3a.9.1756131446046;
        Mon, 25 Aug 2025 07:17:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSA32/pz4JTFpftaw70l3JtTNu6V/0FjNUIWgG3oAVz7MrPT54k1XuSVABqVGbBbpJMYM7RQ==
X-Received: by 2002:a05:6a00:10ce:b0:736:3979:369e with SMTP id d2e1a72fcca58-7702f9eb582mr15836850b3a.9.1756131445564;
        Mon, 25 Aug 2025 07:17:25 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:17:25 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:15:50 +0800
Subject: [PATCH v3 04/38] drm/msm/dp: re-arrange dp_display_disable() into
 functional parts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-4-01faacfcdedd@oss.qualcomm.com>
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
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131419; l=3995;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=pcLIA/1j0xUF/hVxpkEvzGCgW0UBBqYXiTe4Lh/Hipo=;
 b=RuBdo6IucYKeLkvTVUy4/Z7tKcVlYbRA14ZBgdHUD8reN+XgzMpe10OYsuQuUGhf5UIA1PhV1
 l3LcV5otO3yDHgzX1Ov3aEX1mbeLLcesc/WV0e98Pky5MD4gVrrI9e/
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX7rj1b0b1II33
 yAp3j4Fep4wK2OdEBmeatjIC4IXLWxz8fd/ggx6RZftuAZmlhEt2NQ6/N1iJY/UJyQjwmBWpDRr
 ByIYpNzfLntbDc43bj0P6IgA2tOR2y4BTBv8emSS7nXYTIjgbOp6upQATSdJLHw3nkMioZRw6Gp
 JUmIMMFpJUa7yn3SxcsGixEZBqmst6r1FOtTB7m6f1X19S9fVeuLKD6ev3QpWJIdr9/bNci8uGv
 smCes7MK8DNODOEz9LQerzuW97umnP5pzvmhaC89D2rkIotHkFsNgSv2zVIcwWkON6BZ2DO/T3/
 c+l74LKd/ml5XKPVnC/JDbGPHECqNxhVB3//8ttd3jW4Xs7i0QnHvk6F6uMTJiOpD+CKTlh6mbY
 zFZ8DAqA
X-Proofpoint-GUID: UnJPfOaWkKtz5oLPQtkRboouZrqVoG_q
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68ac7077 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=zjUDaY1vqB1ZZ-tktEwA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: UnJPfOaWkKtz5oLPQtkRboouZrqVoG_q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

dp_display_disable() handles special case of when monitor is
disconnected from the dongle while the dongle stays connected
thereby needing a separate function dp_ctrl_off_link_stream()
for this. However with a slight rework this can still be handled
by keeping common paths same for regular and special case.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 19 +------------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  3 ++-
 drivers/gpu/drm/msm/dp/dp_display.c | 10 +++++++++-
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 6bfd8faa1e212c3a25964677a4462e7a3a162fa4..e1ff4c6bb4f0eed2e1ff931f12ba891cf81feffb 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2549,7 +2549,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	return ret;
 }
 
-void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct phy *phy;
@@ -2557,23 +2557,6 @@ void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 	phy = ctrl->phy;
 
-	msm_dp_panel_disable_vsc_sdp(ctrl->panel);
-
-	/* set dongle to D3 (power off) mode */
-	msm_dp_link_psm_config(ctrl->link, &ctrl->panel->link_info, true);
-
-	msm_dp_ctrl_mainlink_disable(ctrl);
-
-	if (ctrl->stream_clks_on) {
-		clk_disable_unprepare(ctrl->pixel_clk);
-		ctrl->stream_clks_on = false;
-	}
-
-	dev_pm_opp_set_rate(ctrl->dev, 0);
-	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
-
-	phy_power_off(phy);
-
 	/* aux channel down, reinit phy */
 	phy_exit(phy);
 	phy_init(phy);
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 1497f1a8fc2f00991356663c19c87eb9fad48a73..93747c0a9b3f049bc877f347f05d42b66ad0dddf 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -19,7 +19,6 @@ struct phy;
 int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
 int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl);
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
-void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl);
@@ -46,4 +45,6 @@ void msm_dp_ctrl_core_clk_disable(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 
+void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
+
 #endif /* _DP_CTRL_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 36a12150925246b168acbabf77d1206a1ef8eff5..4c74eb2915fd620868f658ccafc32030b1c208c6 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -773,12 +773,20 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 	if (!msm_dp_display->power_on)
 		return 0;
 
+	msm_dp_panel_disable_vsc_sdp(dp->panel);
+
+	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0) {
 		/*
 		 * irq_hpd with sink_count = 0
 		 * hdmi unplugged out of dongle
 		 */
-		msm_dp_ctrl_off_link_stream(dp->ctrl);
+
+		/* set dongle to D3 (power off) mode */
+		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+		msm_dp_ctrl_off(dp->ctrl);
+		/* re-init the PHY so that we can listen to Dongle disconnect */
+		msm_dp_ctrl_reinit_phy(dp->ctrl);
 	} else {
 		/*
 		 * unplugged interrupt

-- 
2.34.1


