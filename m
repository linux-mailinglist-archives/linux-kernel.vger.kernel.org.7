Return-Path: <linux-kernel+bounces-776371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 205DAB2CCA7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240A816A276
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E14332BF52;
	Tue, 19 Aug 2025 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cn+FvHfJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17B322C82
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629862; cv=none; b=a/98PcMrfvk/nYj5nKGDnSzozXtwgsonBSJDOMH7pize3cDkmZE5FA6fohjJ9MyCCP4Q5yBXNoiebZfJ6eaWBwBpv8Z1tU+LS3YbEul6u/ciACYdR0jIYuiAs2/PSZ8nkoqhJKSMDXakWBjaOVRs9gALEcRxqKq3PVhWPt/q5LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629862; c=relaxed/simple;
	bh=PqwiZvRPALrMUjLzxT0/ZfTGIGxDBoMjiq2CRNclS2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ng2gNWG5itYdPW7l8EwNLNTcPPwtLv4j6NvYKWH/ZzSmCA+LTbHax2P2XpfnALAYOPK0qjcbIVjVZGYU/z8OPbaB1Al7eglycW3pxeSm+7olMrmtY33KBqBQI1gL2qu/2flGZ1bAO4Yylk8iY07QO1VOz81Vd+X0l+EhMP/fvvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cn+FvHfJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHIa7Q000431
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IGu9/qbvgUkVrqWgbqZAk5MIshpSA6npw+c9WVTvhdQ=; b=cn+FvHfJzq0XcWLp
	+UdG0PSyEUHoZgq7vI1bMfK4aeGPTtgn38ZxX1jocQp0iA4bz9GLopBEGCMkZLR5
	w8DIa7psZG4L/6Ym71r7BihI34BeUXIQPphY9um+xrs/fnChm9CXf+Qaav5cHXb3
	lr/LQR83JpalMPdumC11hR/Ms3whsnm5Ob0nRK9Qo6p7GBHObeXB+/CpAt/AWavR
	BdkfONeF9++icHD+K4f4nBZliREau5VRTlgxxbUQ0YjrJVL4LwAVbaXQgcgk1aj+
	jvOcPWCP/c3QNaIoJUAGg12jIGCF7fbp+uY/OiBuFf+6yc8wznQJWYG2A4GWJXWp
	7oACBQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh079n36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:57:39 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a92820fd0so55629276d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629858; x=1756234658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGu9/qbvgUkVrqWgbqZAk5MIshpSA6npw+c9WVTvhdQ=;
        b=XN1gA2R/SVDoZyeXeYZg5Uc7gRkn6Q/sWzuApcIRutvkXMriFaAGuaVgX21dtUqZ6G
         S0zdDghnKLpsojenriDnU2MLUwbT9Cp2KzEoDpGKnVVzlpLIyzkCFyIIZgSJx7XMe5Vr
         X1mVbROQAoqt3nYhw2STL0z6mUNVnghXFBXJ8UsXElhQQjHkW+HbdZh6bYfufu96Yk5I
         XEgf2KXjLN0Cwt+yTCtgcBflS/JPR/zElKS49CD3YeZl01rO4LQVFjC1vY1u19mHtHhc
         P/UOD3/UEpbfy1R6S52T5PkCFTiGr/aPfcRNNCtNz6Dt4CygMJNhXd4q5gjElyrto67g
         oIpA==
X-Forwarded-Encrypted: i=1; AJvYcCWrAqd286N2xQpm4jLpvAX3PlIrtBapxqhh3FYG58/x0MjQPSz8p4NBRHUd/BFJAAN/AyF9nQYTnHXRSAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMwE84baz/WjhRuDWzw0jJa+cLXnkiASLAqCjja65l8Pg7FoP
	54dTK5kzxpZwmcqoecuOebz9P03+RQY8+G5LjI5NBCodkBkhr18sR99/fKUHBjAtq2ELA+ODbnS
	8Q6dydFSL6yukepbFJszVrSjwU6WkgbEFuoJkpdShampsxJ0K9kVDK4mrpbqOL/vPceY=
X-Gm-Gg: ASbGnctjCuKVp4/9H8rj9jcWdSTT1SQIkb55cDYEfHlVii8d88wI4JaU061rz02QzSq
	sO7YlrMfSqeGh4hJ/2P9JQJ+HDBAEjBacrEFo7xE/emssf9kBeRiSpZQfkMkyPIWRkuO07XH6/3
	V+AhOK5L14ri0dNLvnsACuUUxAmJsO283KmXxbjLIRYKUXNRppyG7KxHE5LxKoP7GNdZVbm7hbf
	WSgCcgBwM4/BqJUBgzCYXJg3mOQX1PdJEigVDwUWjX0Xyi37OGq0E4cpHH9o09GfL9kElgZFJ7P
	WHjcj8MNj6vG5uzPeILmR3Mzo0t5CIzkSsp1HM1/WuJzrPSU01/KyOg1bDhqWujF+IUNZXWCgKo
	WlH/G5OCXOwhJZjGDTprBcukQu/1KBhvuCy2Sf272fC+eTuG2fexU
X-Received: by 2002:ad4:5767:0:b0:709:cf54:2cb6 with SMTP id 6a1803df08f44-70d76fb6a8dmr1096296d6.16.1755629857515;
        Tue, 19 Aug 2025 11:57:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuACaEBY+w5nPqs8GIoEiE6G2hOLmW6uXu4WqZtH687zcKyVJX9GDAHY+x4TyOexV3nyqfJg==
X-Received: by 2002:ad4:5767:0:b0:709:cf54:2cb6 with SMTP id 6a1803df08f44-70d76fb6a8dmr1095996d6.16.1755629856813;
        Tue, 19 Aug 2025 11:57:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35f11csm2207314e87.51.2025.08.19.11.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:57:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 21:57:30 +0300
Subject: [PATCH v2 1/8] drm/connector: let drivers declare infoframes as
 unsupported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-drm-limit-infoframes-v2-1-7595dda24fbd@oss.qualcomm.com>
References: <20250819-drm-limit-infoframes-v2-0-7595dda24fbd@oss.qualcomm.com>
In-Reply-To: <20250819-drm-limit-infoframes-v2-0-7595dda24fbd@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
        Liu Ying <victor.liu@nxp.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=21997;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=PqwiZvRPALrMUjLzxT0/ZfTGIGxDBoMjiq2CRNclS2k=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBopMkbCgULTMje/gLZb4auNy+lCmvuteCrp/TYv
 4zppck48w6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKTJGwAKCRCLPIo+Aiko
 1bP/B/kBZLCaWojMocVYU2sMGuZgP2CGkb5aWYexkfHWN/WHFJif/4YnvMs5LmFYA8bao0zKz/D
 7X6SdgKNC8oeIg1ovcNBRXl9Q/uNAYyLJHPUq6ATzt0L5Yh29lK1cH3VW32bRYllpJMbRTPyyb9
 zLbPYhB/aV/YQ6lrqdbIYD8U+MCqM47Eliu0n/ygX+AkpfYL5aPKhs8tohPjGvnYyuQeEDY384Q
 1eOEcOXH2NzLsMFE9wkIShhh1VJkEnWX0zFZmsRHHxt1Pjs3Z2DujP76m3xjX1BM2zfgWfhaPLB
 tHXQt9+JvGvAvnqUXbDNf0gQK1Az3VGK0zD7YTyyNn28da2s
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 83-uj1wPwAzmptNOesSeiOgCwcX0-r2T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX0C3lV8KpQG4W
 7cwNMoF9f9LRfhlcBHZr2eN1BOnbRqAoWa6fVOLHf7Q799iF7gAxXvaFI3c7OJgkrg8KVB9egA5
 rkKaExiTlN2NTmyHEqgbqGMJZ4vvCAQc3axoCtBFKK0FRD6G16BZrZmpPMzzqreyrUg1malv9of
 ubJt81Mg6x2McgjzbVGusL+tDBvEZujUBF3Xj3p34pPsl2PCv+4J4qKmuSsXxZG5xCEbyENQ96V
 Nzlu4eJCwBrDCn4hzEnU8KJnQKwe+9lTDY2u7FBXAznWanguWsocAd3WvmC1r5z+qbF6QA3inZ7
 zKnD6Rqf1lmOzYhIMh6vs7kFJa/zTIH9tc40OnqRmrQ945XFWB7dQ0b9uCCH+s+av6K7nd9vJ0f
 wu87Gquy
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a4c923 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=EjBJG3Ffxhrz6juHXs8A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 83-uj1wPwAzmptNOesSeiOgCwcX0-r2T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020

Currently DRM framework expects that the HDMI connector driver supports
all infoframe types: it generates the data as required and calls into
the driver to program all of them, letting the driver to soft-fail if
the infoframe is unsupported. This has a major drawback on userspace
API: the framework also registers debugfs files for all Infoframe types,
possibly surprising the users when infoframe is visible in the debugfs
file, but it is not visible on the wire.

Let drivers declare that they support only a subset of infoframes,
creating a more consistent interface.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c     |  6 ++++
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    | 37 ++++++++++++++++++++--
 drivers/gpu/drm/drm_connector.c                    |  4 +++
 drivers/gpu/drm/drm_debugfs.c                      | 16 +++++++---
 drivers/gpu/drm/rockchip/inno_hdmi.c               |  1 +
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  1 +
 drivers/gpu/drm/tests/drm_connector_test.c         | 28 ++++++++++++++++
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |  8 +++++
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  5 +++
 include/drm/drm_bridge.h                           |  7 ++++
 include/drm/drm_connector.h                        | 22 +++++++++++++
 11 files changed, 128 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 8c915427d0538435661d771940efe38b462027a1..b94458d5faa9ae283889fc79496ae323bb4dc88c 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -781,6 +781,12 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 					       &drm_bridge_connector_hdmi_funcs,
 					       connector_type, ddc,
 					       supported_formats,
+					       bridge->supported_infoframes ? :
+					       DRM_CONNECTOR_INFOFRAME_AUDIO |
+					       DRM_CONNECTOR_INFOFRAME_AVI |
+					       DRM_CONNECTOR_INFOFRAME_DRM |
+					       DRM_CONNECTOR_INFOFRAME_SPD |
+					       DRM_CONNECTOR_INFOFRAME_VENDOR,
 					       max_bpc);
 		if (ret)
 			return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index a561f124be99a0cd4259dbacf5f5f6651ff8a0ea..44100fba5e7465b39bce48a086bc3d012d951690 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -687,6 +687,9 @@ static int hdmi_generate_avi_infoframe(const struct drm_connector *connector,
 
 	infoframe->set = false;
 
+	if (!drm_hdmi_connector_supports_infoframe(connector, HDMI_INFOFRAME_TYPE_AVI))
+		return 0;
+
 	ret = drm_hdmi_avi_infoframe_from_display_mode(frame, connector, mode);
 	if (ret)
 		return ret;
@@ -718,6 +721,9 @@ static int hdmi_generate_spd_infoframe(const struct drm_connector *connector,
 
 	infoframe->set = false;
 
+	if (!drm_hdmi_connector_supports_infoframe(connector, HDMI_INFOFRAME_TYPE_SPD))
+		return 0;
+
 	ret = hdmi_spd_infoframe_init(frame,
 				      connector->hdmi.vendor,
 				      connector->hdmi.product);
@@ -742,6 +748,9 @@ static int hdmi_generate_hdr_infoframe(const struct drm_connector *connector,
 
 	infoframe->set = false;
 
+	if (!drm_hdmi_connector_supports_infoframe(connector, HDMI_INFOFRAME_TYPE_DRM))
+		return 0;
+
 	if (connector->max_bpc < 10)
 		return 0;
 
@@ -771,6 +780,9 @@ static int hdmi_generate_hdmi_vendor_infoframe(const struct drm_connector *conne
 
 	infoframe->set = false;
 
+	if (!drm_hdmi_connector_supports_infoframe(connector, HDMI_INFOFRAME_TYPE_VENDOR))
+		return 0;
+
 	if (!info->has_hdmi_infoframe)
 		return 0;
 
@@ -905,6 +917,11 @@ static int clear_device_infoframe(struct drm_connector *connector,
 		return 0;
 	}
 
+	if (!drm_hdmi_connector_supports_infoframe(connector, type)) {
+		drm_dbg_kms(dev, "Infoframe 0x%02x not supported, bailing.\n", type);
+		return 0;
+	}
+
 	ret = funcs->clear_infoframe(connector, type);
 	if (ret) {
 		drm_dbg_kms(dev, "Call failed: %d\n", ret);
@@ -930,23 +947,29 @@ static int write_device_infoframe(struct drm_connector *connector,
 				  union hdmi_infoframe *frame)
 {
 	const struct drm_connector_hdmi_funcs *funcs = connector->hdmi.funcs;
+	enum hdmi_infoframe_type type = frame->any.type;
 	struct drm_device *dev = connector->dev;
 	u8 buffer[HDMI_INFOFRAME_SIZE(MAX)];
 	int ret;
 	int len;
 
-	drm_dbg_kms(dev, "Writing infoframe type %x\n", frame->any.type);
+	drm_dbg_kms(dev, "Writing infoframe type %x\n", type);
 
 	if (!funcs || !funcs->write_infoframe) {
 		drm_dbg_kms(dev, "Function not implemented, bailing.\n");
 		return -EINVAL;
 	}
 
+	if (!drm_hdmi_connector_supports_infoframe(connector, type)) {
+		drm_dbg_kms(dev, "Infoframe %d not supported, bailing.\n", type);
+		return 0;
+	}
+
 	len = hdmi_infoframe_pack(frame, buffer, sizeof(buffer));
 	if (len < 0)
 		return len;
 
-	ret = funcs->write_infoframe(connector, frame->any.type, buffer, len);
+	ret = funcs->write_infoframe(connector, type, buffer, len);
 	if (ret) {
 		drm_dbg_kms(dev, "Call failed: %d\n", ret);
 		return ret;
@@ -1067,6 +1090,11 @@ drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector *co
 	struct drm_display_info *info = &connector->display_info;
 	int ret;
 
+	if (!drm_hdmi_connector_supports_infoframe(connector, HDMI_INFOFRAME_TYPE_AUDIO)) {
+		drm_warn_once(connector->dev, "Audio Infoframe not supported, bailing.\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (!info->is_hdmi)
 		return 0;
 
@@ -1102,6 +1130,11 @@ drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector *con
 	struct drm_display_info *info = &connector->display_info;
 	int ret;
 
+	if (!drm_hdmi_connector_supports_infoframe(connector, HDMI_INFOFRAME_TYPE_AUDIO)) {
+		drm_warn_once(connector->dev, "Audio Infoframe not supported, bailing.\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (!info->is_hdmi)
 		return 0;
 
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 272d6254ea4784e97ca894ec4d463beebf9fdbf0..e753de9fc80a26c30b9674c96083328711f32960 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -553,6 +553,7 @@ EXPORT_SYMBOL(drmm_connector_init);
  * @connector_type: user visible type of the connector
  * @ddc: optional pointer to the associated ddc adapter
  * @supported_formats: Bitmask of @hdmi_colorspace listing supported output formats
+ * @supported_infoframes: Bitmask of @DRM_CONNECTOR_INFOFRAME listing supported Infoframes
  * @max_bpc: Maximum bits per char the HDMI connector supports
  *
  * Initialises a preallocated HDMI connector. Connectors can be
@@ -576,6 +577,7 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 			     int connector_type,
 			     struct i2c_adapter *ddc,
 			     unsigned long supported_formats,
+			     unsigned long supported_infoframes,
 			     unsigned int max_bpc)
 {
 	int ret;
@@ -623,6 +625,8 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 
 	connector->hdmi.funcs = hdmi_funcs;
 
+	connector->hdmi.supported_infoframes = supported_infoframes;
+
 	return 0;
 }
 EXPORT_SYMBOL(drmm_connector_hdmi_init);
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 365cf337529fa2a88b69516d57360d212419c126..248cb9ea1d8781674160cd8d454113c9422ec691 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -672,6 +672,9 @@ static int create_hdmi_audio_infoframe_file(struct drm_connector *connector,
 {
 	struct dentry *file;
 
+	if (!drm_hdmi_connector_supports_infoframe(connector, HDMI_INFOFRAME_TYPE_AUDIO))
+		return 0;
+
 	file = debugfs_create_file("audio", 0400, parent, connector, &audio_infoframe_fops);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
@@ -679,7 +682,7 @@ static int create_hdmi_audio_infoframe_file(struct drm_connector *connector,
 	return 0;
 }
 
-#define DEFINE_INFOFRAME_FILE(_f) \
+#define DEFINE_INFOFRAME_FILE(_f, _F) \
 static ssize_t _f##_read_infoframe(struct file *filp, \
 				   char __user *ubuf, \
 				   size_t count,      \
@@ -726,6 +729,9 @@ static int create_hdmi_## _f ## _infoframe_file(struct drm_connector *connector,
 { \
 	struct dentry *file; \
 	\
+	if (!drm_hdmi_connector_supports_infoframe(connector, HDMI_INFOFRAME_TYPE_ ## _F)) \
+		return 0; \
+	\
 	file = debugfs_create_file(#_f, 0400, parent, connector, &_f ## _infoframe_fops); \
 	if (IS_ERR(file)) \
 		return PTR_ERR(file); \
@@ -733,10 +739,10 @@ static int create_hdmi_## _f ## _infoframe_file(struct drm_connector *connector,
 	return 0; \
 }
 
-DEFINE_INFOFRAME_FILE(avi);
-DEFINE_INFOFRAME_FILE(hdmi);
-DEFINE_INFOFRAME_FILE(hdr_drm);
-DEFINE_INFOFRAME_FILE(spd);
+DEFINE_INFOFRAME_FILE(avi, AVI);
+DEFINE_INFOFRAME_FILE(hdmi, VENDOR);
+DEFINE_INFOFRAME_FILE(hdr_drm, DRM);
+DEFINE_INFOFRAME_FILE(spd, SPD);
 
 static int create_hdmi_infoframe_files(struct drm_connector *connector,
 				       struct dentry *parent)
diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 1ab3ad4bde9ea7305021186ea221d2ff9057fdbb..65eed5ae23194200c145cb174acff4f252b3ef1f 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -1065,6 +1065,7 @@ static int inno_hdmi_register(struct drm_device *drm, struct inno_hdmi *hdmi)
 				 DRM_MODE_CONNECTOR_HDMIA,
 				 hdmi->ddc,
 				 BIT(HDMI_COLORSPACE_RGB),
+				 DRM_CONNECTOR_INFOFRAME_AVI,
 				 8);
 
 	drm_connector_attach_encoder(&hdmi->connector, encoder);
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index ab0938ba61f7d75dd0bec473807a04a20e1cffbd..0b931da4ea2d4eb58a6224476059b9205e8626b4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -640,6 +640,7 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       hdmi->ddc_i2c,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_INFOFRAME_AVI,
 				       8);
 	if (ret) {
 		dev_err(dev,
diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index 22e2d959eb31459f9981fef488228904d67cb6f9..fd28ed2bf8bcecabaabc67f2f8f5ccc1f42525d3 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -641,6 +641,13 @@ static struct kunit_suite drm_connector_dynamic_register_test_suite = {
 	.test_cases = drm_connector_dynamic_register_tests,
 };
 
+#define DRM_CONNECTOR_ALL_INFOFRAMES \
+	(DRM_CONNECTOR_INFOFRAME_AUDIO | \
+	 DRM_CONNECTOR_INFOFRAME_AVI | \
+	 DRM_CONNECTOR_INFOFRAME_DRM | \
+	 DRM_CONNECTOR_INFOFRAME_SPD | \
+	 DRM_CONNECTOR_INFOFRAME_VENDOR)
+
 /*
  * Test that the registration of a bog standard connector works as
  * expected and doesn't report any error.
@@ -657,6 +664,7 @@ static void drm_test_connector_hdmi_init_valid(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 }
@@ -677,6 +685,7 @@ static void drm_test_connector_hdmi_init_null_ddc(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       NULL,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 }
@@ -697,6 +706,7 @@ static void drm_test_connector_hdmi_init_null_vendor(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
@@ -717,6 +727,7 @@ static void drm_test_connector_hdmi_init_null_product(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
@@ -743,6 +754,7 @@ static void drm_test_connector_hdmi_init_product_valid(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	KUNIT_EXPECT_MEMEQ(test,
@@ -776,6 +788,7 @@ static void drm_test_connector_hdmi_init_product_length_exact(struct kunit *test
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	KUNIT_EXPECT_MEMEQ(test,
@@ -803,6 +816,7 @@ static void drm_test_connector_hdmi_init_product_length_too_long(struct kunit *t
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
@@ -829,6 +843,7 @@ static void drm_test_connector_hdmi_init_vendor_valid(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	KUNIT_EXPECT_MEMEQ(test,
@@ -861,6 +876,7 @@ static void drm_test_connector_hdmi_init_vendor_length_exact(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	KUNIT_EXPECT_MEMEQ(test,
@@ -888,6 +904,7 @@ static void drm_test_connector_hdmi_init_vendor_length_too_long(struct kunit *te
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
@@ -908,6 +925,7 @@ static void drm_test_connector_hdmi_init_bpc_invalid(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       9);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
@@ -928,6 +946,7 @@ static void drm_test_connector_hdmi_init_bpc_null(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       0);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
@@ -953,6 +972,7 @@ static void drm_test_connector_hdmi_init_bpc_8(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
@@ -994,6 +1014,7 @@ static void drm_test_connector_hdmi_init_bpc_10(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       10);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
@@ -1035,6 +1056,7 @@ static void drm_test_connector_hdmi_init_bpc_12(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       12);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
@@ -1071,6 +1093,7 @@ static void drm_test_connector_hdmi_init_formats_empty(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       0,
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
@@ -1091,6 +1114,7 @@ static void drm_test_connector_hdmi_init_formats_no_rgb(struct kunit *test)
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_YUV422),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
@@ -1149,6 +1173,7 @@ static void drm_test_connector_hdmi_init_formats_yuv420_allowed(struct kunit *te
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       params->supported_formats,
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_EQ(test, ret, params->expected_result);
 }
@@ -1170,6 +1195,7 @@ static void drm_test_connector_hdmi_init_type_valid(struct kunit *test)
 				       connector_type,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 }
@@ -1205,6 +1231,7 @@ static void drm_test_connector_hdmi_init_type_invalid(struct kunit *test)
 				       connector_type,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_LT(test, ret, 0);
 }
@@ -1482,6 +1509,7 @@ static void drm_test_drm_connector_attach_broadcast_rgb_property_hdmi_connector(
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       &priv->ddc,
 				       BIT(HDMI_COLORSPACE_RGB),
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       8);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 8bd412735000cb18e66aeca21433b2ebbefe2b44..2901fcb6b12ee318a4a9c727a62d5290d7c9aa84 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -138,6 +138,13 @@ static const struct drm_connector_funcs dummy_connector_funcs = {
 	.reset			= dummy_hdmi_connector_reset,
 };
 
+#define DRM_CONNECTOR_ALL_INFOFRAMES \
+	(DRM_CONNECTOR_INFOFRAME_AUDIO | \
+	 DRM_CONNECTOR_INFOFRAME_AVI | \
+	 DRM_CONNECTOR_INFOFRAME_DRM | \
+	 DRM_CONNECTOR_INFOFRAME_SPD | \
+	 DRM_CONNECTOR_INFOFRAME_VENDOR)
+
 static
 struct drm_atomic_helper_connector_hdmi_priv *
 __connector_hdmi_init(struct kunit *test,
@@ -192,6 +199,7 @@ __connector_hdmi_init(struct kunit *test,
 				       DRM_MODE_CONNECTOR_HDMIA,
 				       NULL,
 				       formats,
+				       DRM_CONNECTOR_ALL_INFOFRAMES,
 				       max_bpc);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 07c91b450f93ab9e795d040d6f60f485ac71cfe8..2098d04c95e7e733307c90bb9ab5e2631f6f5df0 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -556,6 +556,11 @@ static int vc4_hdmi_connector_init(struct drm_device *dev,
 				       BIT(HDMI_COLORSPACE_RGB) |
 				       BIT(HDMI_COLORSPACE_YUV422) |
 				       BIT(HDMI_COLORSPACE_YUV444),
+				       DRM_CONNECTOR_INFOFRAME_AUDIO |
+				       DRM_CONNECTOR_INFOFRAME_AVI |
+				       DRM_CONNECTOR_INFOFRAME_DRM |
+				       DRM_CONNECTOR_INFOFRAME_SPD |
+				       DRM_CONNECTOR_INFOFRAME_VENDOR,
 				       max_bpc);
 	if (ret)
 		return ret;
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 620e119cc24c3491c2be5f08efaf51dfa8f708b3..529dcaca1d7924da12d9587170f96ec6a00ad126 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1153,6 +1153,13 @@ struct drm_bridge {
 	 */
 	unsigned int max_bpc;
 
+	/**
+	 * @supported_infoframes: Bitmask of DRM_CONNECTOR_INFOFRAME values,
+	 * listing supported infoframes. This is only relevant if
+	 * @DRM_BRIDGE_OP_HDMI is set.
+	 */
+	unsigned int supported_infoframes;
+
 	/**
 	 * @hdmi_cec_dev: device to be used as a containing device for CEC
 	 * functions.
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 8f34f4b8183d83dccd3e820a444fbf74fb6c16f2..7a92b4d75d25b355898b6c5d7cc45431187dc3b9 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1839,6 +1839,12 @@ struct drm_connector_hdmi {
 	 */
 	unsigned long supported_formats;
 
+	/**
+	 * @supported_infoframes: Bitmask of infoframe types supported by the
+	 * controller. See @DRM_CONNECTOR_INFOFRAME.
+	 */
+	unsigned long supported_infoframes;
+
 	/**
 	 * @funcs: HDMI connector Control Functions
 	 */
@@ -2336,6 +2342,7 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 			     int connector_type,
 			     struct i2c_adapter *ddc,
 			     unsigned long supported_formats,
+			     unsigned long supported_infoframes,
 			     unsigned int max_bpc);
 void drm_connector_attach_edid_property(struct drm_connector *connector);
 int drm_connector_register(struct drm_connector *connector);
@@ -2488,6 +2495,21 @@ void drm_connector_attach_privacy_screen_provider(
 	struct drm_connector *connector, struct drm_privacy_screen *priv);
 void drm_connector_update_privacy_screen(const struct drm_connector_state *connector_state);
 
+#define DRM_CONNECTOR_INFOFRAME(type)		BIT(type - 0x80)
+
+#define DRM_CONNECTOR_INFOFRAME_AUDIO	DRM_CONNECTOR_INFOFRAME(HDMI_INFOFRAME_TYPE_AUDIO)
+#define DRM_CONNECTOR_INFOFRAME_AVI	DRM_CONNECTOR_INFOFRAME(HDMI_INFOFRAME_TYPE_AVI)
+#define DRM_CONNECTOR_INFOFRAME_DRM	DRM_CONNECTOR_INFOFRAME(HDMI_INFOFRAME_TYPE_DRM)
+#define DRM_CONNECTOR_INFOFRAME_SPD	DRM_CONNECTOR_INFOFRAME(HDMI_INFOFRAME_TYPE_SPD)
+#define DRM_CONNECTOR_INFOFRAME_VENDOR	DRM_CONNECTOR_INFOFRAME(HDMI_INFOFRAME_TYPE_VENDOR)
+
+static inline bool
+drm_hdmi_connector_supports_infoframe(const struct drm_connector *connector,
+				      enum hdmi_infoframe_type type)
+{
+	return connector->hdmi.supported_infoframes & DRM_CONNECTOR_INFOFRAME(type);
+}
+
 /**
  * struct drm_tile_group - Tile group metadata
  * @refcount: reference count

-- 
2.47.2


