Return-Path: <linux-kernel+bounces-808468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5601AB50039
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26C6A1C28312
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D26D352FEF;
	Tue,  9 Sep 2025 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h1dHKg8E"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4A352080
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429547; cv=none; b=t27opUfVLN5FNjGZoPmA99JO8vfqm72tspJqHc6RPXpsCCcZI6pMFzZWm230gnR+4JLgf7n9YCLg/e8ijWc4aq+gaHaFRd2KTgHFfGeJW3Ns15/hLaOW8O6O5Lvurofsd2oTzeUev6YfK7wHgLkXIK/jauWTwKw1+c4RdyeAJVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429547; c=relaxed/simple;
	bh=mP/H5Pi0Ywh3c712kU9hSqtr5Ew0pjrLOLw+OxDtaCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OFo8KnTUHigr6Sh0IELf8Z2EmRmy4NG9ia4ZhasFdLa9GsD3eZiCXk/P92aheg/TtlqjKpYjoXJF6lQQH2u5TdEFH1UiS/+64EO9ZmX9WvUNelu7ak8hMfaYpzX71ADPxINj/ax6GahMs31JC8S4lHAPGIPrzGDG5+RnroxlycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h1dHKg8E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LYOO009606
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4qmCG5VRv/0xeHVKrnpkEHnE+MjRUIGDpWGRDcEunOM=; b=h1dHKg8EhWTr1lXC
	S3BSUDh/BQyURCuqb2vnoHNX2iV4CjJnPhaYHqPYs9xf9fzCG6TfyKcYPdboOu1z
	7LJswkBQsWZfDeK1ZmLLYltP3569oByQkb2BUOaXiVe9XaFUuY9K1J0uPiXvM7q9
	DFSlAwLLTTQbozeZsDsrsZTaxkD3d+OLY50gHDUoylALyLmv4mBoot59ipxUSIcF
	aDWB6bIbWAQZtRVdzhceG2xFglcAED8gMQznh8M0so1N6CTXE6VmcuRM6x78T+96
	T1Dl2Gf3eW5swEU0WaXJJd8U8vEwXhHCdR1LTWpDCgMMxmdA+k3nR8Y7KJd3YWz5
	53a0rg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdwcdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:52:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7296c012e7dso116263506d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429536; x=1758034336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qmCG5VRv/0xeHVKrnpkEHnE+MjRUIGDpWGRDcEunOM=;
        b=EX5QEDtGLSj6ojuvbyOdjkrTXSFA/OFLaHtKiYaewLRu221fDJXD2WxJx1xAbH0+Rv
         WsnAfuzENj+7OLi7zt4OrKpGU0gbPSX/ANvNiJn/SZLAgpa94JMcV5XlsBfTO4rsbIkp
         oL4IaqpmeBP9/7rSDUMXTVs4I9MpaIQeyJ/555eeNq2qnz9xqwH0fujGGPLmNSJjAsgV
         gkeQbUAgUHAWORTdK7OA2UdIqCOIdOP+BDfj2bglC9/xzCN9BKsZpqnEcdXqIbzFXR7V
         O2FCYdd1Gh7pWa4Th/q3wZj7CL/X6D4vESKBVPKTCVHmLFrpNyeXflHP2wRLM2gzLcab
         ghPA==
X-Forwarded-Encrypted: i=1; AJvYcCXXpNNiOksw8nfJhbg6yFJTT8+ceqxNIAJwyKVhdhxz7Qi/IVAX+zqs3wWLF1hsRFLuwSioZkWdOH4mcrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0yRkD+wlr9dMyct10isgsiaPgmg7Nfm8r/mRisV9WbqnDDrKe
	/jNIko+cC2lqGsAKdb45nCdEz3mYXM+7Va4F1T+hp0s1HwmbmwWs9GIISvMn7oYTx9mG63cqN6q
	fEGAXvz9Y7Tl8w6WzBTlcMpnLwgrrwFsPCXBlYCAVXtpgqajmGvWDF1kMq8OgPA8H4sM=
X-Gm-Gg: ASbGncuEUMNU0arATYxLrkayv+ZK2YIAp872d3jSmuLhKanD6BwvEmTSoEWZOKBpYq5
	tRQ18O9ChCv2K6M1ojQwH6UKXYmNaAueotUcUiCTUALA1y+NCVFMWgUNmrc9ExGmxB9xVtgNyhE
	u8PAHcDUYwLzLT8NrgX1HqDERwhrcPeaemHdoy4UHcruGjGlY/5wR48lsWgFBU/PgzJXHdBYYwT
	/PByt3pFKIbxb0lUlVE6REUY7JqEmIdFk0pQLQeM0pReUflRsp0mqjD/OK+8Sb0FcDLgsWMN51O
	d0XhiDTOPbQ2uRJ4NLfULRomiU3S/GTOtM3rOrU7RIvdczJOVj3NDmwJxBZ6953R4gJVGt3SaAN
	zCzz3G6lDwRei164+UAiC0RWy+Ft7qhiRyo15+yraY17qYzdps8eF
X-Received: by 2002:a05:6214:485:b0:712:8b65:d37a with SMTP id 6a1803df08f44-7393d42bbcbmr132608776d6.43.1757429535836;
        Tue, 09 Sep 2025 07:52:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/bbtuN3wllj9BkovM2JO/e0F2W8h5IRpZMJZhZIa2NtCKZE6emzGxG704Fb0C0orxRB0Aww==
X-Received: by 2002:a05:6214:485:b0:712:8b65:d37a with SMTP id 6a1803df08f44-7393d42bbcbmr132608116d6.43.1757429534961;
        Tue, 09 Sep 2025 07:52:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c90eb9sm38735781fa.22.2025.09.09.07.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:52:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 17:51:59 +0300
Subject: [PATCH v4 01/10] drm/connector: let drivers declare infoframes as
 unsupported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-drm-limit-infoframes-v4-1-53fd0a65a4a2@oss.qualcomm.com>
References: <20250909-drm-limit-infoframes-v4-0-53fd0a65a4a2@oss.qualcomm.com>
In-Reply-To: <20250909-drm-limit-infoframes-v4-0-53fd0a65a4a2@oss.qualcomm.com>
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
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Daniel Stone <daniels@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=25401;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mP/H5Pi0Ywh3c712kU9hSqtr5Ew0pjrLOLw+OxDtaCQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBowD8adLkeXkLmIEF+OgaYr7EQ+FUrPVenExzAA
 rvULDbm03qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaMA/GgAKCRCLPIo+Aiko
 1RopB/9495wgm7xM3zpSHMYgZm24eBg4hGYMAMTgxiTv+EFgNZ95luJl76+wzItr8YvC0XlxiD9
 aArALl1mPi14xh6vQ3IvHF5rcy/7l0CnW2A1j1xDs6DZFxpUojUuGA1JIVULHtZcJOESJBJ73+A
 uZvIV+4RibavlryvPp5uuZTuGFAbo/FepVzF0uFTWBKJ9c47VquTDAlUX4K7DOCQ2YIufmqZzrT
 XpodU5IKHiBc2+y1SxTIm78m42YZCL9HOjc3TIt+CaXGYLHTNdQFF1Y5M61c+KMSuCxlBj91mmh
 /P60zYf2X48H41adqut0iOOfVtj2tt82MPBTm5ylHiU/vLfl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: IiP0XlDnmfElmEcJnraXfrbWQeWKJr1w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfXwzyps4SE0E13
 DAMSRd8G7FykHD0LPo5INNGx+Q127BczyVwSkTiINJSt3rnAC4X3jup7ZPzzIrMwHxeADN+S1FC
 bsYLfro0Nlmx90grQRD3fIEoFPIQFdiccuAC549+6PxO4mUALp73Xpko29CCdidPI+r19k6PGJg
 cZ8OT9pGLoHCio7eVy1GvrEADtWNK1lAYCzhOT3VaOjgcTFABeW6pGecdS6Ah1FlOa3WOnPTNiM
 G335+rDaAsndajVGoveFneKD2P8byKI+/0h+QMcXAcE+ewUMzMQ1QSl6gKGrP3JRRuuVDBGf8IV
 w1+mwKB7L1Vnj8pfsUAhL0t1ccBBGCyCAvasqGeH2c5t0c1ueZtdAOTEX9gsGEbu6zCG59icnVd
 ccJDNqMQ
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68c03f26 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=8AirrxEcAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=XAD4hK_KzAuCMM6Gw7AA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=ST-jHhOKWsTCqRlWije3:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: IiP0XlDnmfElmEcJnraXfrbWQeWKJr1w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

Currently DRM framework expects that the HDMI connector driver supports
all infoframe types: it generates the data as required and calls into
the driver to program all of them, letting the driver to soft-fail if
the infoframe is unsupported. This has a major drawback on userspace
API: the framework also registers debugfs files for all Infoframe types,
possibly surprising the users when infoframe is visible in the debugfs
file, but it is not visible on the wire. Drivers are also expected to
return success even for unsuppoted InfoFrame types.

Let drivers declare that they support only a subset of infoframes,
creating a more consistent interface. Make the affected drivers return
-EOPNOTSUPP if they are asked to program (or clear) InfoFrames which are
not supported.

Acked-by: Liu Ying <victor.liu@nxp.com>
Acked-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c     |  6 +++
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    | 43 +++++++++++++++++++---
 drivers/gpu/drm/drm_connector.c                    |  4 ++
 drivers/gpu/drm/drm_debugfs.c                      | 16 +++++---
 drivers/gpu/drm/rockchip/inno_hdmi.c               |  5 ++-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  3 +-
 drivers/gpu/drm/tests/drm_connector_test.c         | 28 ++++++++++++++
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |  8 ++++
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  5 +++
 include/drm/drm_bridge.h                           | 12 +++++-
 include/drm/drm_connector.h                        | 30 ++++++++++++++-
 11 files changed, 143 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index baacd21e7341fca95ef3e5b793930ffde9d4d4e3..55bf5ac53739fda098be69a5c61e4934704ce046 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -783,6 +783,12 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 					       &drm_bridge_connector_hdmi_funcs,
 					       connector_type, ddc,
 					       supported_formats,
+					       bridge->supported_infoframes ? |
+					       DRM_CONNECTOR_INFOFRAME_AUDIO |
+					       DRM_CONNECTOR_INFOFRAME_AVI |
+					       DRM_CONNECTOR_INFOFRAME_DRM |
+					       DRM_CONNECTOR_INFOFRAME_SPD |
+					       DRM_CONNECTOR_INFOFRAME_VENDOR,
 					       max_bpc);
 		if (ret)
 			return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index a561f124be99a0cd4259dbacf5f5f6651ff8a0ea..9ae996b5a2acf27d23da7108865b721cc8975dbf 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -687,6 +687,9 @@ static int hdmi_generate_avi_infoframe(const struct drm_connector *connector,
 
 	infoframe->set = false;
 
+	if (!drm_hdmi_connector_supported_infoframe(connector, HDMI_INFOFRAME_TYPE_AVI))
+		return 0;
+
 	ret = drm_hdmi_avi_infoframe_from_display_mode(frame, connector, mode);
 	if (ret)
 		return ret;
@@ -718,6 +721,9 @@ static int hdmi_generate_spd_infoframe(const struct drm_connector *connector,
 
 	infoframe->set = false;
 
+	if (!drm_hdmi_connector_supported_infoframe(connector, HDMI_INFOFRAME_TYPE_SPD))
+		return 0;
+
 	ret = hdmi_spd_infoframe_init(frame,
 				      connector->hdmi.vendor,
 				      connector->hdmi.product);
@@ -742,6 +748,9 @@ static int hdmi_generate_hdr_infoframe(const struct drm_connector *connector,
 
 	infoframe->set = false;
 
+	if (!drm_hdmi_connector_supported_infoframe(connector, HDMI_INFOFRAME_TYPE_DRM))
+		return 0;
+
 	if (connector->max_bpc < 10)
 		return 0;
 
@@ -771,6 +780,9 @@ static int hdmi_generate_hdmi_vendor_infoframe(const struct drm_connector *conne
 
 	infoframe->set = false;
 
+	if (!drm_hdmi_connector_supported_infoframe(connector, HDMI_INFOFRAME_TYPE_VENDOR))
+		return 0;
+
 	if (!info->has_hdmi_infoframe)
 		return 0;
 
@@ -898,13 +910,18 @@ static int clear_device_infoframe(struct drm_connector *connector,
 	struct drm_device *dev = connector->dev;
 	int ret;
 
-	drm_dbg_kms(dev, "Clearing infoframe type 0x%x\n", type);
-
 	if (!funcs || !funcs->clear_infoframe) {
 		drm_dbg_kms(dev, "Function not implemented, bailing.\n");
 		return 0;
 	}
 
+	if (!drm_hdmi_connector_supported_infoframe(connector, type)) {
+		drm_dbg_kms(dev, "Infoframe 0x%02x not supported, bailing.\n", type);
+		return -EOPNOTSUPP;
+	}
+
+	drm_dbg_kms(dev, "Clearing infoframe type 0x%02x\n", type);
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
-
 	if (!funcs || !funcs->write_infoframe) {
 		drm_dbg_kms(dev, "Function not implemented, bailing.\n");
 		return -EINVAL;
 	}
 
+	if (!drm_hdmi_connector_supported_infoframe(connector, type)) {
+		drm_dbg_kms(dev, "Infoframe 0x%02x not supported, bailing.\n", type);
+		return -EOPNOTSUPP;
+	}
+
+	drm_dbg_kms(dev, "Writing infoframe type 0x%02x\n", type);
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
 
+	if (!drm_hdmi_connector_supported_infoframe(connector, HDMI_INFOFRAME_TYPE_AUDIO)) {
+		drm_warn_once(connector->dev, "Audio Infoframe not supported, bailing.\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (!info->is_hdmi)
 		return 0;
 
@@ -1102,6 +1130,11 @@ drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector *con
 	struct drm_display_info *info = &connector->display_info;
 	int ret;
 
+	if (!drm_hdmi_connector_supported_infoframe(connector, HDMI_INFOFRAME_TYPE_AUDIO)) {
+		drm_warn_once(connector->dev, "Audio Infoframe not supported, bailing.\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (!info->is_hdmi)
 		return 0;
 
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 272d6254ea4784e97ca894ec4d463beebf9fdbf0..92a75684a0f7375d3a94e8c666cb71064ecc8035 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -553,6 +553,7 @@ EXPORT_SYMBOL(drmm_connector_init);
  * @connector_type: user visible type of the connector
  * @ddc: optional pointer to the associated ddc adapter
  * @supported_formats: Bitmask of @hdmi_colorspace listing supported output formats
+ * @supported_infoframes: Bitmask of @DRM_CONNECTOR_INFOFRAME listing Infoframes generated by DRM core
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
index 365cf337529fa2a88b69516d57360d212419c126..0bf70164550b4eb0551aeab026d5bf1131739a02 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -672,6 +672,9 @@ static int create_hdmi_audio_infoframe_file(struct drm_connector *connector,
 {
 	struct dentry *file;
 
+	if (!drm_hdmi_connector_supported_infoframe(connector, HDMI_INFOFRAME_TYPE_AUDIO))
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
+	if (!drm_hdmi_connector_supported_infoframe(connector, HDMI_INFOFRAME_TYPE_ ## _F)) \
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
index 1ab3ad4bde9ea7305021186ea221d2ff9057fdbb..31d742b7627b8b31ebbd7056c9d44a0454407d6d 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -645,7 +645,7 @@ static int inno_hdmi_disable_frame(struct drm_connector *connector,
 	if (type != HDMI_INFOFRAME_TYPE_AVI) {
 		drm_err(connector->dev,
 			"Unsupported infoframe type: %u\n", type);
-		return 0;
+		return -EOPNOTSUPP;
 	}
 
 	hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_BUF_INDEX, INFOFRAME_AVI);
@@ -663,7 +663,7 @@ static int inno_hdmi_upload_frame(struct drm_connector *connector,
 	if (type != HDMI_INFOFRAME_TYPE_AVI) {
 		drm_err(connector->dev,
 			"Unsupported infoframe type: %u\n", type);
-		return 0;
+		return -EOPNOTSUPP;
 	}
 
 	inno_hdmi_disable_frame(connector, type);
@@ -1065,6 +1065,7 @@ static int inno_hdmi_register(struct drm_device *drm, struct inno_hdmi *hdmi)
 				 DRM_MODE_CONNECTOR_HDMIA,
 				 hdmi->ddc,
 				 BIT(HDMI_COLORSPACE_RGB),
+				 DRM_CONNECTOR_INFOFRAME_AVI,
 				 8);
 
 	drm_connector_attach_encoder(&hdmi->connector, encoder);
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index ab0938ba61f7d75dd0bec473807a04a20e1cffbd..f4c8ff60d78250d0100e210210d4e9a64a903af5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -50,7 +50,7 @@ static int sun4i_hdmi_write_infoframe(struct drm_connector *connector,
 	if (type != HDMI_INFOFRAME_TYPE_AVI) {
 		drm_err(connector->dev,
 			"Unsupported infoframe type: %u\n", type);
-		return 0;
+		return -EOPNOTSUPP;
 	}
 
 	for (i = 0; i < len; i++)
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
index 76e05930f50e00f6ef5999b3f5a476215951028d..a3e3518905a06835f61a1a60bd2f165820f57918 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -788,7 +788,7 @@ struct drm_bridge_funcs {
 	 *
 	 * This callback clears the infoframes in the hardware during commit.
 	 * It will be called multiple times, once for every disabled infoframe
-	 * type.
+	 * type. It should return -EOPNOTSUPP if the frame is not supported.
 	 *
 	 * This callback is optional but it must be implemented by bridges that
 	 * set the DRM_BRIDGE_OP_HDMI flag in their &drm_bridge->ops.
@@ -799,7 +799,8 @@ struct drm_bridge_funcs {
 	 * @hdmi_write_infoframe:
 	 *
 	 * Program the infoframe into the hardware. It will be called multiple
-	 * times, once for every updated infoframe type.
+	 * times, once for every updated infoframe type. It should return
+	 * -EOPNOTSUPP if the frame is not supported.
 	 *
 	 * This callback is optional but it must be implemented by bridges that
 	 * set the DRM_BRIDGE_OP_HDMI flag in their &drm_bridge->ops.
@@ -1205,6 +1206,13 @@ struct drm_bridge {
 	 */
 	unsigned int max_bpc;
 
+	/**
+	 * @supported_infoframes: Bitmask of DRM_CONNECTOR_INFOFRAME values,
+	 * listing InfoFrames to be generated by the DRM core. This is only
+	 * relevant if @DRM_BRIDGE_OP_HDMI is set.
+	 */
+	unsigned int supported_infoframes;
+
 	/**
 	 * @hdmi_cec_dev: device to be used as a containing device for CEC
 	 * functions.
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 8f34f4b8183d83dccd3e820a444fbf74fb6c16f2..7849a2343771ee869cd1e38b30f34d0c2237f4d7 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1256,7 +1256,8 @@ struct drm_connector_hdmi_funcs {
 	 * The @clear_infoframe callback is optional.
 	 *
 	 * Returns:
-	 * 0 on success, a negative error code otherwise
+	 * 0 on success, a negative error code otherwise, it should return
+	 * -EOPNOTSUPP if the frame is not supported
 	 */
 	int (*clear_infoframe)(struct drm_connector *connector,
 			       enum hdmi_infoframe_type type);
@@ -1273,7 +1274,8 @@ struct drm_connector_hdmi_funcs {
 	 * The @write_infoframe callback is mandatory.
 	 *
 	 * Returns:
-	 * 0 on success, a negative error code otherwise
+	 * 0 on success, a negative error code otherwise, it should return
+	 * -EOPNOTSUPP if the frame is not supported
 	 */
 	int (*write_infoframe)(struct drm_connector *connector,
 			       enum hdmi_infoframe_type type,
@@ -1839,6 +1841,14 @@ struct drm_connector_hdmi {
 	 */
 	unsigned long supported_formats;
 
+	/**
+	 * @supported_infoframes: Bitmask of infoframe types supported by the
+	 * controller and generated AS IS by the software.
+	 * See @DRM_CONNECTOR_INFOFRAME and
+	 * @drm_connector_hdmi_funcs.write_infoframe().
+	 */
+	unsigned long supported_infoframes;
+
 	/**
 	 * @funcs: HDMI connector Control Functions
 	 */
@@ -2336,6 +2346,7 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 			     int connector_type,
 			     struct i2c_adapter *ddc,
 			     unsigned long supported_formats,
+			     unsigned long supported_infoframes,
 			     unsigned int max_bpc);
 void drm_connector_attach_edid_property(struct drm_connector *connector);
 int drm_connector_register(struct drm_connector *connector);
@@ -2488,6 +2499,21 @@ void drm_connector_attach_privacy_screen_provider(
 	struct drm_connector *connector, struct drm_privacy_screen *priv);
 void drm_connector_update_privacy_screen(const struct drm_connector_state *connector_state);
 
+#define DRM_CONNECTOR_INFOFRAME(type)		((type) > 0x80 ? BIT((type) - 0x80) : 0)
+
+#define DRM_CONNECTOR_INFOFRAME_AUDIO	DRM_CONNECTOR_INFOFRAME(HDMI_INFOFRAME_TYPE_AUDIO)
+#define DRM_CONNECTOR_INFOFRAME_AVI	DRM_CONNECTOR_INFOFRAME(HDMI_INFOFRAME_TYPE_AVI)
+#define DRM_CONNECTOR_INFOFRAME_DRM	DRM_CONNECTOR_INFOFRAME(HDMI_INFOFRAME_TYPE_DRM)
+#define DRM_CONNECTOR_INFOFRAME_SPD	DRM_CONNECTOR_INFOFRAME(HDMI_INFOFRAME_TYPE_SPD)
+#define DRM_CONNECTOR_INFOFRAME_VENDOR	DRM_CONNECTOR_INFOFRAME(HDMI_INFOFRAME_TYPE_VENDOR)
+
+static inline bool
+drm_hdmi_connector_supported_infoframe(const struct drm_connector *connector,
+				      enum hdmi_infoframe_type type)
+{
+	return connector->hdmi.supported_infoframes & DRM_CONNECTOR_INFOFRAME(type);
+}
+
 /**
  * struct drm_tile_group - Tile group metadata
  * @refcount: reference count

-- 
2.47.3


