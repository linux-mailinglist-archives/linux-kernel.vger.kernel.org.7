Return-Path: <linux-kernel+bounces-784892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4982B34333
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD599480CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F70B2FA0F5;
	Mon, 25 Aug 2025 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gGziQes7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07302FB610
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131442; cv=none; b=VZpaWe9SWXJNPk6YNabTOgBp37ZdVZcpNdc1ZJv/esR4ej49fvPHA8g9jkAud3bbXeHYdEkg4H2fZ7rWQ/Y+8v02VcpdFaNKRktWngP/KRmXfTe+L/R5/gPNM73lEAtN7EdXI9nZNm2fgyAz9Xj5/Yo/ifpJMuZHjPG8Wq/khKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131442; c=relaxed/simple;
	bh=34b+PsdVbCIHwsH+9r9lklxpT9ZX5L/KtaP6iHFFhto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OUGpa2c4QKzQuSIFK8V27rB8Px5fZIVIqSRknbSFL8wkVkuaMyxXllje1PlPdEdHfg0C6CS3gem79v9kS2lao745TTjJDBUNnwb1CF75A1QcXvnlb/KxdMk+HrbjyTDweb5VJSt40Jx4huPRyLjXV0msHf3ubeVxlpgJock6pko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gGziQes7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8rmbb023616
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	228/LJ536Yw6oDyiIYYU61EUqHaRT0V0B7t/T3/fRWg=; b=gGziQes79OlpQcOK
	zDOD+YjNlZ/UX73RyXvgR8hucq5t21ooUmKRGBFgng629ZjqDrn7ebuyvO1ydzMu
	Hxv8j7VJEkplMvtjzvmPZMD7mDw0VIHdcuh22IqIMXMbIRDC6VLnQtjQovHNKvOY
	rAXV4er5P3+PLk7bfq3Bt3KCDiwWfqJ/OXiOezJiHhH+GOZjD4RzCbehWtFSSwPD
	1QkiTqHxPteS5hmxQCtetndoeP6zTxCRxM5Q9zxlrEnH39EJnCCtIscMrNynViCQ
	KzIVzQQY0yweIpcBXeuMONh7teAkHOV8xX60fftB2vuKb1AbXPnJdnmc/LZmXmwq
	gSleAg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5d7m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:19 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4c20148c54so582530a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131438; x=1756736238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=228/LJ536Yw6oDyiIYYU61EUqHaRT0V0B7t/T3/fRWg=;
        b=QrYXXDPSdpb9t/AopgXrZN2Lo6Y3JWjYohnC7XcR5VTGfMtMR3VUAGQPZ7Bj79eD6u
         sInCKdXDdyHuTsHTwhGDCp5Vh0ia18n7zFEWebTDAsukOvw1fizv0uw2Pd8o9d1rxoCE
         P6Hx3a8AavMnrqjzIUaKECuZWWdsj5oVmPEKfDCrjnY51/ooE5NTOeWhBxzRCL/YCdV5
         I9EYFnfqJDuOGhYEQSjsFSHZFfMklgU6868xbn47SjG4PBEqkqBBuKKsWkBsNrSJDhH6
         Z0R3+zI5OgyF2PIz/Iv2JXiCEV5qIMSEfAIDjER4MMhgLpmh3TZILQuOsAC8jAHsFlZw
         Zufg==
X-Forwarded-Encrypted: i=1; AJvYcCXV97IfinYAOt6m+YjO6ZdlmJlZWW4SDFVoAJ3n70gJ8LD2jxL8GDN82Lu6SQxQeZXS9S/xCUm7RHY7TIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbAbmm6MBQZKBndHl69ubfgb5meUmSM/5KEhGVxLP4ryn3zw1J
	6o8RZJogHqiQnzgMToyLw+hsaIw2hgdZ0UT5dxNVcxznSZf7HaJkJHIcQLv+9elrPjZjYV/2UGW
	+J79eWaZm3BiJrWUI90z8FxkOQyqr0gh6UwyoyyA2NTXxE98/1VDHyMtXakoc8oUtA2s=
X-Gm-Gg: ASbGnctAN6ZhGd86TY37f0xOK49zwHOpdpaKFe+eDSDVBZeeSm92vYSsJLzGOEFlU5b
	TwRPAIedf/N8dSIiwa4eHiHSH63j1sY8zGVan+46T84d6ej+Y+MlVQT0RBsraHxrLuDVGNgTuVa
	Rtbz8DssWTAjSsYih3sGTBOSMwe6NHVRvtGWVxv5tStjdXMjB6oWpIQkQ0rTUitr19sEPUrCJ+8
	5aT2sRa0YNPdt4Vgs7b2HETUgyeiz3h4YpyqHeuWw7MFSJIHfaBWvo5MuXf6a7fKhpeV974tcRj
	XtMv0ABYjXJXXqx52705N93oceNDr9Mra+jcj12QWCVRCf7d8hbof44fM2Jl3SUaSz1woVo=
X-Received: by 2002:a05:6a20:2449:b0:239:a3b:33e5 with SMTP id adf61e73a8af0-24340d91844mr19080418637.39.1756131437834;
        Mon, 25 Aug 2025 07:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeidNOygMem/ySNqGGxvS/UkycnpbyA5wkruiJa3ZLqkO68ei+5oPylTEuapzUQcwzkqNywQ==
X-Received: by 2002:a05:6a20:2449:b0:239:a3b:33e5 with SMTP id adf61e73a8af0-24340d91844mr19080372637.39.1756131437288;
        Mon, 25 Aug 2025 07:17:17 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:17:16 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 22:15:48 +0800
Subject: [PATCH v3 02/38] drm/msm/dp: remove dp_display's dp_mode and use
 dp_panel's instead
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-msm-dp-mst-v3-2-01faacfcdedd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131418; l=5167;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=n4iY9cD+dBjYaCRvOQIEU6YYpjVmCWe/78mH40eh77w=;
 b=8dUmzqPkKrqJpSTKp59X3JBldDCjYW+1aJBMdtSRsgxsyUMuqgXBKSBS5JckVHsx+H7PMKZei
 wI9xYh5cHj1Dx1ogWt0TOyllj0mjlMCF8aw3Ucb/weyq0h3wGZxubV8
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX4RfkmPi/3vjl
 LLYGyqeFn9fcAkS1i2476MuAExOUNc8kaYDv31LhrOoNkfNxoRxPXlVyYH2w0JSloi+Hei3iCzX
 8WDrTgG0pKkGUZc1+CGgGHy79o96604AK7gDjMFG0MYJnKG6ws+m8jxbHCYuvj1pJO4Bpp4XR/l
 mZN1DWBlD97SiXVXDUe4VZRwWRydB1xQjxWEQ7ToTMmcr2wMkYDVVGjKjnz9Y4NzRy6BKkQ6QsR
 EDdtQlOvKru12fUaWlSUrdBpwVtI7ZLjWSC7DP3d548k2DKKhUrUH2ACOVagbQ9aF93+8CS/9f3
 rUboOEZDcOAgY2iBoy6RZK9wUrEwQMLAkvnQ15qj4ZB4NKUGVCvUPF/RqdUBP15mlJU+wpXNze/
 UmLggAyE
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68ac706f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=wrQRTU2gfdt6St0ev-sA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: k-xHXcZPMqkxo_sFUHY9Jr_u38yS3uHN
X-Proofpoint-ORIG-GUID: k-xHXcZPMqkxo_sFUHY9Jr_u38yS3uHN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

dp_display caches the current display mode and then passes it onto
the panel to be used for programming the panel params. Remove this
two level passing and directly populate the panel's dp_display_mode
instead.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 66 ++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index dadf31bc37763c4f07f68b76fbbe33fb77b20850..632a1191e4e48fecd7dbda2f6ec6b8ed0aeebc93 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -60,7 +60,6 @@ struct msm_dp_display_private {
 	struct msm_dp_panel   *panel;
 	struct msm_dp_ctrl    *ctrl;
 
-	struct msm_dp_display_mode msm_dp_mode;
 	struct msm_dp msm_dp_display;
 
 	/* wait for audio signaling */
@@ -649,16 +648,29 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 }
 
 static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
-			       struct msm_dp_display_mode *mode)
+				   const struct drm_display_mode *adjusted_mode,
+				   struct msm_dp_panel *msm_dp_panel)
 {
-	struct msm_dp_display_private *dp;
+	u32 bpp;
 
-	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+	drm_mode_copy(&msm_dp_panel->msm_dp_mode.drm_mode, adjusted_mode);
+
+	if (msm_dp_display_check_video_test(msm_dp_display))
+		bpp = msm_dp_display_get_test_bpp(msm_dp_display);
+	else
+		bpp = msm_dp_panel->connector->display_info.bpc * 3;
+
+	msm_dp_panel->msm_dp_mode.bpp = bpp ? bpp : 24; /* Default bpp */
 
-	drm_mode_copy(&dp->panel->msm_dp_mode.drm_mode, &mode->drm_mode);
-	dp->panel->msm_dp_mode.bpp = mode->bpp;
-	dp->panel->msm_dp_mode.out_fmt_is_yuv_420 = mode->out_fmt_is_yuv_420;
-	msm_dp_panel_init_panel_info(dp->panel);
+	msm_dp_panel->msm_dp_mode.v_active_low =
+		!!(adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC);
+	msm_dp_panel->msm_dp_mode.h_active_low =
+		!!(adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC);
+	msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 =
+		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode) &&
+		msm_dp_panel->vsc_sdp_supported;
+
+	msm_dp_panel_init_panel_info(msm_dp_panel);
 	return 0;
 }
 
@@ -1328,7 +1340,7 @@ bool msm_dp_wide_bus_available(const struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	if (dp->msm_dp_mode.out_fmt_is_yuv_420)
+	if (dp->panel->msm_dp_mode.out_fmt_is_yuv_420)
 		return false;
 
 	return dp->wide_bus_supported;
@@ -1389,10 +1401,6 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	bool force_link_train = false;
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
-	if (!msm_dp_display->msm_dp_mode.drm_mode.clock) {
-		DRM_ERROR("invalid params\n");
-		return;
-	}
 
 	if (dp->is_edp)
 		msm_dp_hpd_plug_handle(msm_dp_display, 0);
@@ -1405,12 +1413,6 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	if (msm_dp_display->link->sink_count == 0)
 		return;
 
-	rc = msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);
-	if (rc) {
-		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
-		return;
-	}
-
 	if (dp->link_ready && !dp->power_on) {
 		msm_dp_display_host_phy_init(msm_dp_display);
 		force_link_train = true;
@@ -1479,31 +1481,11 @@ void msm_dp_bridge_mode_set(struct drm_bridge *drm_bridge,
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 	msm_dp_panel = msm_dp_display->panel;
 
-	memset(&msm_dp_display->msm_dp_mode, 0x0, sizeof(struct msm_dp_display_mode));
-
-	if (msm_dp_display_check_video_test(dp))
-		msm_dp_display->msm_dp_mode.bpp = msm_dp_display_get_test_bpp(dp);
-	else /* Default num_components per pixel = 3 */
-		msm_dp_display->msm_dp_mode.bpp = dp->connector->display_info.bpc * 3;
-
-	if (!msm_dp_display->msm_dp_mode.bpp)
-		msm_dp_display->msm_dp_mode.bpp = 24; /* Default bpp */
-
-	drm_mode_copy(&msm_dp_display->msm_dp_mode.drm_mode, adjusted_mode);
-
-	msm_dp_display->msm_dp_mode.v_active_low =
-		!!(msm_dp_display->msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NVSYNC);
-
-	msm_dp_display->msm_dp_mode.h_active_low =
-		!!(msm_dp_display->msm_dp_mode.drm_mode.flags & DRM_MODE_FLAG_NHSYNC);
-
-	msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 =
-		drm_mode_is_420_only(&dp->connector->display_info, adjusted_mode) &&
-		msm_dp_panel->vsc_sdp_supported;
+	msm_dp_display_set_mode(dp, adjusted_mode, msm_dp_panel);
 
 	/* populate wide_bus_support to different layers */
-	msm_dp_display->ctrl->wide_bus_en =
-		msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 ? false : msm_dp_display->wide_bus_supported;
+	msm_dp_display->ctrl->wide_bus_en = msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ?
+		false : msm_dp_display->wide_bus_supported;
 }
 
 void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge)

-- 
2.34.1


