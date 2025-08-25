Return-Path: <linux-kernel+bounces-784898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C69DB34341
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38B9189E683
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AB92F9C3F;
	Mon, 25 Aug 2025 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YgalJd0x"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978F22FD1C3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131462; cv=none; b=m0xxPm7GtaGpFclovxPLl2HTU3S1bhJuEPC6DXxCxXvGjU/iHOJZLZBqvruRlhkn6/OBSMIdKRrKrroGEhOCmbiggBT7c+9O12mxO8QtrBSEsmLqmiwmvp5WGeaaj0IV7jPc8Ri6sLrfl8zI/5pRUUmL+JXc2DtPXjKYFCs8CZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131462; c=relaxed/simple;
	bh=7INxLvbdAwotD1cFgbHypSZRRIPzoZucy0ELHCfSkgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c5Pvwyu97iQB+kzgDULphjFha6pbhr+IDOUxIt3lMVpzGhKE6ph5zNFW+LlnKGnqKokKU5eWT1a4EdBkLEHn4ur+cktOqKn/qM4yi9hHiKHV8NcAGnif2pKvnMOkL9kGXDdVNrOZn1NWg5DLJNUWSJ6oAwfr/AF15Y2sy01GCoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YgalJd0x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8Z2eO029703
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wrKjdpoxycp4zwQBuyFtLrpN7EB/eov61YjzQV3qsaY=; b=YgalJd0xo2V2c+CZ
	Tn8HjV3KRBF6crBV2LkayDXvEjzV52RQvwNsgikQ5S9XvztHq9nQg9YkOoW5Vp/3
	bRzZ8wd0U7VirlN9MREXCllkdRL5D8MguhhFjnUYOfL/GeIGRD1ZZn7uynVwFBUT
	/86a/vnAcS1IOYCFvE/IZRH1MtHk2GE+KWwHJDm3vpnRYZvHCCgNx0X+WoIR7lNi
	3jXhO0RKEEz2EW+XO01lzMplxBija9itq+8njVtzLoUCTnraq5RIP7JL2lCH1R26
	y+bVYhYz5YAKghH9EJSUdybC4OgYaHYb8Dw2epSSp0EcrO0+bFZ0+FLQRFcc0omT
	T0C6qA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5d7pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:39 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-771e1657d01so864334b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131458; x=1756736258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrKjdpoxycp4zwQBuyFtLrpN7EB/eov61YjzQV3qsaY=;
        b=FHnZ1d/orfijlyD7Z76cwDsrprTD0dribUTuL+MAmtajeWLzBt3rt/Avt844uLd8eI
         C5r9S4wpehDLKkMuMlLQoHIpYaHs02S6MDYOJhWgfeufSAX+gR0Zkl3rbazh2dlnktBx
         hdujffJ6grcj0gxX/17ukAvA/r+ORc0gHIa96h3oN3frjjRegbnOOAsu5ek5nS/eupGQ
         Rtt6+yktZgPW48bCnKM624E3r1Vk5zC3IHVRW+Fk+e8Rfel7gL0jAc1tEjiQxx1dr4W7
         qUCV/vvgDQZL1Mg30Yu/prO/4m0fxyw/FXLp6B8uoJFPuPvE4p+Vye5JPfpF/+GADy/E
         kfOg==
X-Forwarded-Encrypted: i=1; AJvYcCX/9X0TIDUAC5+Q+vwuUs9m0QRsxGxmDVc22z2/JeQ9j8S+zKimN9CKCi92whQRSAcY1wcdkGr+KGAQnOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4yN1Rt+pEDKMd0HItdRDk720A7298JAjcaT+XJCz3YAil7/Oc
	kdmwrT+SdulAwkbsSQmf+UH0YqXCwwdwDUs8V6BYFsdkjea0EmnbEuojSfBzxebD1OoLc+R/wjV
	BlmmF0sNbftgo8Avowe2Hk/9dT914kywalXZJ0xN2kvdSIPxWnOq95i/LvzScjOo/HQk=
X-Gm-Gg: ASbGncvGWhTPDh9yJx4On0/mSl9E94/8/UPPL1lIlBLKgQN1NOR9GNZOtU05JWlpriJ
	KdLTrFk2oaepxhzhLcJgKZTCXWuLlo5nycfW8BTlbXvm9W5vMTALYUdnBi6hURJSHPGb4CScMyz
	MVrYl6LpW0ZEnlWPplBu8k3mil5TAGAs1g/l+WcbPdFYyfHgs5+HKmrQc+0im+fyjjoYVUoCRPR
	5aCGpvjeR3qeRmFb62XYugOd5D9Dp4LWzx1jJB/5+qLs88+AU6p0nbhl/2EJmPW13cPs6JTKrbD
	cXXOZVc04boJ77QvGLQupcy6/+HECyZhljWNKt7+qbuV+s/Ee4IR2YykpyyBsRB68M4ZYl4=
X-Received: by 2002:a05:6a00:3912:b0:748:e5a0:aa77 with SMTP id d2e1a72fcca58-7702f9f153fmr18042111b3a.13.1756131458053;
        Mon, 25 Aug 2025 07:17:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoeoIYD7IX4d2D6LwWN4xg7TGBlsCBJRgR2BV3sGR9tz7vWmXqFytzXB5A1yuns22KYfx06g==
X-Received: by 2002:a05:6a00:3912:b0:748:e5a0:aa77 with SMTP id d2e1a72fcca58-7702f9f153fmr18042070b3a.13.1756131457522;
        Mon, 25 Aug 2025 07:17:37 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:17:37 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:15:53 +0800
Subject: [PATCH v3 07/38] drm/msm/dp: allow dp_ctrl stream APIs to use any
 panel passed to it
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-7-01faacfcdedd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131419; l=4541;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=laPtcJI1sC3fX2ycQzzsK05nYl2YDFvhgopjq1iL0Jg=;
 b=u/fLY+q++RSsxq/mnLG9orc/hcrk3nh6rXINegH8Oo5ZOJGMugsoi7pjWq0MvAkr2r9zpSHFB
 ROXDbGf5voYCQYZQq5uqi8gsO2eSShoJ1IFNK38zr9hhYhVYVuAtZI5
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX0dC8KPaNIaXC
 SqZV33fI6+rZNBkwQRwaLB0yzAQv2UYwHMorWPg61rI9B5weoLSTkoxZCQy+Z6Ux0gv8mZGfdOU
 kyQkZ/7yRknleh24VImjLpCWoXL5bUbJP3T9APyGYyueBZFwhv0l+Lxm2m8nEUHdI4DcY8NtZ6F
 APiIndU1aJI/3yS0Sd3hhWGfPQIIUIc55fWaRHs3ApUES+GTO/FH4VP1vzKG94yeJTqa8hYBi27
 EqpUs+VOo1uVnhy9Hmfvn+zXhdN0lvBAJAWzXFacIAIuFqO0LKUIvJ9dzPo/DqB+hYEqmYqEIsf
 84MvaELqq9y4dNT7W6zUWYACokew7WCwTpwBoGdjRVB24QbROOcFgNQV+1W1gpj/8F81rKg63Ma
 h4CnZ1UN
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68ac7083 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=s_Xww9EJd3sp7u0t16cA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rSQ44VMeXJapedKoYco5DL7FDpXmBvlU
X-Proofpoint-ORIG-GUID: rSQ44VMeXJapedKoYco5DL7FDpXmBvlU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Currently, the dp_ctrl stream APIs operate on their own dp_panel
which is cached inside the dp_ctrl's private struct. However with MST,
the cached panel represents the fixed link and not the sinks which
are hotplugged. Allow the stream related APIs to work on the panel
which is passed to them rather than the cached one. For SST cases,
this shall continue to use the cached dp_panel.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 21 +++++++++++----------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 6bfb639c1ebd33f1103c5b68dfb40701738fa267..261907446135904a9e479f18051974f5fea88ef1 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -469,13 +469,14 @@ static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
 	msm_dp_write_link(ctrl, REG_DP_MISC1_MISC0, misc_val);
 }
 
-static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl,
+						struct msm_dp_panel *msm_dp_panel)
 {
-	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, msm_dp_panel);
 
-	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
+	msm_dp_ctrl_config_misc1_misc0(ctrl, msm_dp_panel);
 
-	msm_dp_panel_timing_cfg(ctrl->panel, ctrl->msm_dp_ctrl.wide_bus_en);
+	msm_dp_panel_timing_cfg(msm_dp_panel, ctrl->msm_dp_ctrl.wide_bus_en);
 }
 
 /*
@@ -2497,7 +2498,7 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_li
 	return ret;
 }
 
-int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
+int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel)
 {
 	int ret = 0;
 	bool mainlink_ready = false;
@@ -2510,9 +2511,9 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
-	pixel_rate = pixel_rate_orig = ctrl->panel->msm_dp_mode.drm_mode.clock;
+	pixel_rate = pixel_rate_orig = msm_dp_panel->msm_dp_mode.drm_mode.clock;
 
-	if (msm_dp_ctrl->wide_bus_en || ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
+	if (msm_dp_ctrl->wide_bus_en || msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
 		pixel_rate >>= 1;
 
 	drm_dbg_dp(ctrl->drm_dev, "pixel_rate=%lu\n", pixel_rate);
@@ -2544,14 +2545,14 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	msm_dp_setup_peripheral_flush(ctrl);
 	msm_dp_ctrl_config_ctrl_link(ctrl);
 
-	msm_dp_ctrl_configure_source_params(ctrl);
+	msm_dp_ctrl_configure_source_params(ctrl, msm_dp_panel);
 
 	msm_dp_ctrl_config_msa(ctrl,
 		ctrl->link->link_params.rate,
 		pixel_rate_orig,
-		ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420);
+		msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420);
 
-	msm_dp_panel_clear_dsc_dto(ctrl->panel);
+	msm_dp_panel_clear_dsc_dto(msm_dp_panel);
 
 	msm_dp_ctrl_setup_tr_unit(ctrl);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 93747c0a9b3f049bc877f347f05d42b66ad0dddf..78406c757eccf95e82f1a9d4437ebdbbc4f8ea46 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -17,7 +17,7 @@ struct msm_dp_ctrl {
 struct phy;
 
 int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
-int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl);
+int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
 void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 4c74eb2915fd620868f658ccafc32030b1c208c6..d07bb40f848e0e13a0fa32aa70ffb1621edca159 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -720,7 +720,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp)
 		return 0;
 	}
 
-	rc = msm_dp_ctrl_on_stream(dp->ctrl);
+	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel);
 	if (!rc)
 		msm_dp_display->power_on = true;
 

-- 
2.34.1


