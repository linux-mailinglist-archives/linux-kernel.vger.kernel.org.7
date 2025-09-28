Return-Path: <linux-kernel+bounces-835312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E83BA6B4F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55C8E3AFEE2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD02C08C8;
	Sun, 28 Sep 2025 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="buCADdXk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DBE2BEC2D
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759047922; cv=none; b=bmlr4AMtC18X+izdwDH8H0wGgx6dam2uifRN9Xy31sSZE86ZRxJbrvrecD+HqdAamMLFu9K78HWyPQhjgA4/F3+p7vAbnHnhML15un5RmL8EDYyvx+q/3BNd0cwm+8rR9/krHOzXya6IxSIYfxrJY2RZo77JihodutSR+W6ifxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759047922; c=relaxed/simple;
	bh=W9b6XDfq52rGNwLc4zsgRSvpebnOTLw260yRhrb4Lug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+oqjoiSNdmvVn9hykZCNFbOjO8Nxhtn31teo8HUKR+uX/Q1Pp97LSMX/kfll4aEhxIBykPOHgcBHFBnJ9WPqzu6ZQBwy8zfnjaIQko0g4+48bLeHsOsoU5CHUbqATp+Ac21DiR5k6P7c7jr+IcsLQ2wSD9rM1SkxIXbjMl4B8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=buCADdXk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S5PJEM014162
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NW6O36yvGMaCMJruxLgmHiMoRnZgXb8542oDwX0AOxE=; b=buCADdXklBonbx88
	yQXEnIVHCKmKKGaKlUd2DEna9Y8RP367YFy0zH5bX4/6GvXxeYZuDCOZ9cQvyZTG
	UPbG6PNp5jQB4ujsyn+/N+H04591MRydIEPB31U+6DGjQM0v31voqfaNdNW2qvpP
	ofWJZ79wt4+O46Zhbp8Gb/D/k38j5ECCMEProZH+zpFbVee99t3ephpV2+QfaWRH
	MUZ5IQfW0rP3W8KoYStNEqFK0G+/Usk9lfMk7zxGbR3THjLjJyAFrVaSEQeeb0fV
	NuCHxn0IWJLfaljOMJvo2jDq8ZYcUSwnyJXS3MeogmTYECHk1TpGaJXEZBVrne8S
	jppKtA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59mtrdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:25:19 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4de2c597a6eso68691221cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759047918; x=1759652718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NW6O36yvGMaCMJruxLgmHiMoRnZgXb8542oDwX0AOxE=;
        b=tB+d2c7T1ULs8B74OZI7DQT/iEGWMNmaK8fscRmITBV1o+Thll0RL2MbRXJOPFNRZL
         j0Zt8tcTBW/A4W5ki76SzYjQ+8DoPaehZyTXDVHDrffWoCdxI21KT+GmneV437NZOhk6
         CMZoGMRGA3fLhdW2omm7DNPOvApCwkrAb++s4Mf2Cr6MjApNZKp4XjIn8ojrP3Z7GPcS
         rS3xP494ZS8A9CKXKjg12wDlPg3Vj3U/qPZ6Zv8+Ejd7cmQRkjCifTMLPTbBzG4rhEZy
         xJFlwX4RhFHGSPMXXwMkqBcj4e8ump/7eShTPwwXiEAzz9f4B1DGtiF3So4Wa2ZktinE
         7Tsg==
X-Forwarded-Encrypted: i=1; AJvYcCXyLSfbXa3pmXGb2WAAzMmITgIRnAPP2J5ssCgO+Wt1GyUCIZG0E7HO5c1zjUZnIi30IooRlSvWYK0jfhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdLUxi1Mqgwd1jGpT25xmb9OEzDvgdEgIUviPi+qUWOUBzkpp4
	jNeiRTyloHigr65/h2N3oKj4HOUNRarwVNUFFocm5BoKYIZ9iD9emn1B9NW1hpVXh4U+msQI2hj
	ecvhWR+1cjt53w5kFMm1YG4+F7ri4d6JSNa1tgRg+9davzOoGRnrHVxkOjWSkQqQfYB4=
X-Gm-Gg: ASbGncsmiNUAgwRCbnPtsjWTQwm+dq8AKgkWUoN/Yi+6rxnrVllWY3gkWnO1JQ3KwIy
	xUHI9o6vu5iCOsrB8ZObvbPWRaj/2MgXztyxgDIFrp/hjTdgbSEkvYQnGjxeqiwVTrrfuYuBOlC
	MM1u4HAXT+VH2S7dGc6zBl+V8s95epjCL/3sIyWx/NSof7TMtDIr+uUQjtjZMABBhSfg1brIOiO
	xZBmdHvk+uIZYxLubpz/PKwZdyiRXcfY9GTUKwwIJ37wO44ANRX3YN9MP1Jnw/p17hj5LO9j7nu
	8CJrq5Rp2H4RX3hjgLHS4Tzu7ahHnTV4l5kPaakqgDnMdE2rOZ4RKTDUktEipfObDTUP2Avb++N
	ZxJsqiRjCUxRx5LhBrl3Hbna6DyEkZ4OcQb0Ih5g+8eObXPYDxZZL
X-Received: by 2002:a05:622a:28b:b0:4dd:2d5a:4c81 with SMTP id d75a77b69052e-4dd2d5a5227mr115444551cf.80.1759047918171;
        Sun, 28 Sep 2025 01:25:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF27D25nggKmxCQPuY2QEZ5kb5OMkUcGWSWenXBk1jMFSmot08OrVTyFKGy9g6C2KuS41KORQ==
X-Received: by 2002:a05:622a:28b:b0:4dd:2d5a:4c81 with SMTP id d75a77b69052e-4dd2d5a5227mr115444191cf.80.1759047917658;
        Sun, 28 Sep 2025 01:25:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583166561c0sm3244298e87.81.2025.09.28.01.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 01:25:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 28 Sep 2025 11:24:52 +0300
Subject: [PATCH v2 7/9] drm/rockchip: rk3066_hdmi: handle unsupported
 InfoFrames
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250928-limit-infoframes-2-v2-7-6f8f5fd04214@oss.qualcomm.com>
References: <20250928-limit-infoframes-2-v2-0-6f8f5fd04214@oss.qualcomm.com>
In-Reply-To: <20250928-limit-infoframes-2-v2-0-6f8f5fd04214@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Samuel Holland <samuel@sholland.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3035;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=W9b6XDfq52rGNwLc4zsgRSvpebnOTLw260yRhrb4Lug=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo2PDU6HTPvF+Y88cTCEIA/XqAYSXsI17MJ/Kuo
 GBYAduGAauJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaNjw1AAKCRCLPIo+Aiko
 1cq6CACwsfecD4+Y57wsVqifG4KmJ1uLXo3XecBdE9p/0GhGRaWV3arhyRyfKp0tlB35c8MzljK
 fDtPzmsDvrhP2urxzq1TpspnVu9IXcEypIW0sF87iXw+iFME67+Gyn9a9OkTsH2PnQMOFRkixVX
 mH/gIAf3P2S40lcubBSetxPYyllypeNFWjqzzKMd0KvjErmpePUInZnPTLBd8/Xh4pW3QuIhgrU
 Sm7Z56KIe4dVsOT6HH+7Kq4tyjrHZUh3tKF7qaQ9i4K1hx3kgg/RMruPZmNz9kpUP1zJyzFKYCZ
 ++CnvNdxchJd5yd4WAK1Hb1e0RR5mdzcMjyyN22Bu74kcYoN
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: KcWMpyGrjNqjUqiAPTRnr9HTEh8yVKPn
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68d8f0ef cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=LTYPIh7T-TEeLale1FMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: KcWMpyGrjNqjUqiAPTRnr9HTEh8yVKPn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX8HWb4P0YSZ93
 SV5fviXCBgWDJO7+TPiAWfTwDuGCzCS2aPtxnyqdP2sOqsjK4YdHCVhtVvx5wpIGLh+ReQrt8XF
 woqWbs5Wr/BvSADcdk/ThJLWYAwSciY8AM6jES0hwon3BjoRaQyjxVK5O5MOsPtonClr9i09l/T
 skCtlL4bwa2+uKfcpGqD0UvCb4QVoYRL+ElrLKltSVQToSL+wJzmcHvNEaknlldpWGb1hFCUG/8
 S0oyoND5AHKC1M2Tsl3e3NzZVTwVl639AKTpV9kdYyI2W/cZHTC5grpbWGaCoCBz24G6cweuBIV
 LPJ+qlzA6p00BScRCBTafTNtJAL/nxTquCoPCHYI44zEoIoMrg1ImoFzM17w2he0GcZgBKBjUvi
 38EbKSghZBNpbXviwGtYTYTcwlHjDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001

Make hdmi_write_hdmi_infoframe() and hdmi_clear_infoframe() callbacks
return -EOPNOTSUPP for unsupported InfoFrames and make sure that
atomic_check() callback doesn't allow unsupported InfoFrames to be
enabled.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 39 +++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index ae4a5ac2299a93a49f87df7604752f6b651c839c..33f52a83ca4597193de8c012b4cc598e82c3f09b 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -162,12 +162,11 @@ static int rk3066_hdmi_bridge_clear_infoframe(struct drm_bridge *bridge,
 {
 	struct rk3066_hdmi *hdmi = bridge_to_rk3066_hdmi(bridge);
 
-	if (type != HDMI_INFOFRAME_TYPE_AVI) {
-		drm_err(bridge->dev, "Unsupported infoframe type: %u\n", type);
-		return 0;
-	}
+	if (type != HDMI_INFOFRAME_TYPE_AVI)
+		return -EOPNOTSUPP;
 
 	hdmi_writeb(hdmi, HDMI_CP_BUF_INDEX, HDMI_INFOFRAME_AVI);
+	// XXX: this doesn't seem to actually disable the infoframe.
 
 	return 0;
 }
@@ -180,10 +179,8 @@ rk3066_hdmi_bridge_write_infoframe(struct drm_bridge *bridge,
 	struct rk3066_hdmi *hdmi = bridge_to_rk3066_hdmi(bridge);
 	ssize_t i;
 
-	if (type != HDMI_INFOFRAME_TYPE_AVI) {
-		drm_err(bridge->dev, "Unsupported infoframe type: %u\n", type);
-		return 0;
-	}
+	if (type != HDMI_INFOFRAME_TYPE_AVI)
+		return -EOPNOTSUPP;
 
 	rk3066_hdmi_bridge_clear_infoframe(bridge, type);
 
@@ -193,6 +190,31 @@ rk3066_hdmi_bridge_write_infoframe(struct drm_bridge *bridge,
 	return 0;
 }
 
+static int
+rk3066_hdmi_bridge_atomic_check(struct drm_bridge *bridge,
+				struct drm_bridge_state *bridge_state,
+				struct drm_crtc_state *crtc_state,
+				struct drm_connector_state *conn_state)
+{
+	/* not supported by the driver */
+	conn_state->hdmi.infoframes.spd.set = false;
+
+	/* FIXME: not supported by the driver */
+	conn_state->hdmi.infoframes.hdmi.set = false;
+
+	/* should not happen, audio support not enabled */
+	if (drm_WARN_ON_ONCE(bridge->encoder->dev,
+			     conn_state->connector->hdmi.infoframes.audio.set))
+		return -EOPNOTSUPP;
+
+	/* should not happen, HDR support not enabled */
+	if (drm_WARN_ON_ONCE(bridge->encoder->dev,
+			     conn_state->hdmi.infoframes.hdr_drm.set))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static int rk3066_hdmi_config_video_timing(struct rk3066_hdmi *hdmi,
 					   struct drm_display_mode *mode)
 {
@@ -485,6 +507,7 @@ rk3066_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs rk3066_hdmi_bridge_funcs = {
+	.atomic_check = rk3066_hdmi_bridge_atomic_check,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,

-- 
2.47.3


