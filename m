Return-Path: <linux-kernel+bounces-772013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC83B28DDE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0848AC5155
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE0723ABA8;
	Sat, 16 Aug 2025 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XRmYW1zH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0A2E2F1A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755348080; cv=none; b=C94D+Q2hf1x19I72NLQ4TeCtIkhTUb6q432gOeI7xL78nVgVDjoxG4Lr4qiKMXZHM0Wy3wKsRu457EPyMqPmMAwQrkcU3S01TXsTfuYGHjqU4GbC2s14jNl2UfiXCniNa7fietMq/iIfSIzJpuEOtOJEE3BkXi2mmLrlVD6JA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755348080; c=relaxed/simple;
	bh=M1Oso041hLRSQwTPqGh7bGs7LIRCGyRBW2ycbXLCh80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=afI2GFtyngF5WtM0oyxnSwzLjmSRMFIzS9uupDhOxLc9HJKy//KrXxxMX0ZwWLjnE6qY6Nu523cIjFjjmYXLgwjRGOzJVdndpOxLPspQBFkLLAXpZ52Mo40w6VGJRtfhhv8KiWHOV3fqrfjOoEiY+Yj3PR6Bnh3+ztMULO6Vf8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XRmYW1zH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G5dDJa001113
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1gFPmXWSueTddtYIhYSEFEG9PUYrsVzLpIWEMClRrIQ=; b=XRmYW1zHg1AqO3JF
	5zv7HsUkJYGje5OX+OvGtE8R1KEux3YoFGw7ZM9ArrvStCVYHrdlE1M0yycMhMnD
	vidsYzcNcLSVc3zwnvq6p2/Cy1+n9hb3QQoQv6VBOR4rMh60IDKZcYtV0dX0avfv
	/7y5jO/9/U1knExd/nWKdBJW/bj5d2xM9KPyxWQDYNlpFCS5Dicag2t6Tlmafkr/
	01IfmGp7QtLl3te29EpcoCV+XoNwiSH/7smvC6WGTUjIMeq1GBiW6i7HvP6JOUNM
	EIdVyJeh3MxghZuO1duxUr5Pi8DA6cvQRi9gce1mP9B0mr0ubVE5rG41/zTcMnym
	jVe7WQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jgxt8qxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:41:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109bb3e22so81484031cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 05:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755348068; x=1755952868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gFPmXWSueTddtYIhYSEFEG9PUYrsVzLpIWEMClRrIQ=;
        b=hscL74IMuwYrCpLxtiqkj1S7XoCmNxD2gy5bskOfHM30JFQUOYuTB8KytYlDS6R16H
         bjXy0V1oIe+k6pTEDqSj3NsPHXED1Kma0MIbrIlMQ/7m+CDUe/sGR8fzUB3itIiZLPKf
         Hw1PINwxHtf+0RVgATtgJtbc1poRzsXUi3BiFZeDvLgfP2NpC7BM9WyDDUKwjsThViXT
         PhgxJnLkiBnYbIRCW8zoHaGTvmAMUPaDHdj4SF+48Zlu0Q+mRDFSD+EbLDeX82fN7w1g
         jbzhVB4EPXP2HM8myzpKMw8V8d/u5QDclwqhBAkxZ/iaDiXxjUGA8r43vpAubEzIaHto
         V1Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXUbeFatUUD7HXHNmgK0TS8cBM6lmxII5ZwRIN2Vbbj0/HsjeM5mYKUvA8tE9oFLUbNk8LbL0hmnCLRtXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqoFGzNJCxu/E+wUsxf9mIuDnAZLY39R/fzMtgvzkobaFdqpZM
	7H0zHeMcKP6RkcClQbqpLrqSyO+2G4QQiayLAguEyxYT8TLqrZAm3b4jryGvb1GGfODk134tmUN
	hrnewc/kVCYzoYoW8jnKgLQc5UOHok4g/qRiVN9HQStOJp9r+5Y/6UGuD+uhRuT6MzBY=
X-Gm-Gg: ASbGncv7Pnb3yv11cwMzAgCgCOR7EhdW7r8LStTVRMLRS/t682o/HYu+PCDG1ohI5wJ
	ZmKntv6hW3j9McxYJmV+IKOcvp/aD4TTgNYbH6WFWfQL9TZQBmwtCkFlcwLc7iW8FmWQITLVy7P
	n+rfgwPvmDsAT5gwIScz6+7YcDMZ/Bq1EAuB4KHtKShiwosF59Fe9g9vDO9b/AjCLAtyrN0+QBv
	QiW3LSBe2/3kXJ6nS/sGTzIkjR65eM0xy1DKpS2CQONAknzx0GQEa59o2DAXtUl49PbxC/CfQ/r
	+SmnpWTudvFBuuRIq/7xoL459jfp3ANZnV/zjgs57eXTI17YAfGt+Pil5vda35f073q3fvF43x/
	zyFKl5pjn8PyX2Z3tRHQyRnzeZ8oIfP8bXfPJ3DSB6BspKDLuTcAU
X-Received: by 2002:a05:622a:2ca:b0:4b0:81d0:c119 with SMTP id d75a77b69052e-4b11e27e77fmr80636431cf.38.1755348067972;
        Sat, 16 Aug 2025 05:41:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdqT8OUvSv7EHxhPLdcfSwidIxeo8nxtBOuDhQpm2piGYWb8xjZTqJkxgnLrCNt8at0b8r9A==
X-Received: by 2002:a05:622a:2ca:b0:4b0:81d0:c119 with SMTP id d75a77b69052e-4b11e27e77fmr80635701cf.38.1755348067323;
        Sat, 16 Aug 2025 05:41:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cca21sm856554e87.104.2025.08.16.05.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 05:41:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 16 Aug 2025 15:41:01 +0300
Subject: [PATCH 1/7] drm/connector: let drivers declare infoframes as
 unsupported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-drm-limit-infoframes-v1-1-6dc17d5f07e9@oss.qualcomm.com>
References: <20250816-drm-limit-infoframes-v1-0-6dc17d5f07e9@oss.qualcomm.com>
In-Reply-To: <20250816-drm-limit-infoframes-v1-0-6dc17d5f07e9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=21968;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=M1Oso041hLRSQwTPqGh7bGs7LIRCGyRBW2ycbXLCh80=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBooHxfwp6a3pEb0+ur/XQsVy2kQiBGKJidUiZI4
 YmWNB1OBF2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKB8XwAKCRCLPIo+Aiko
 1bbHB/4vtifsBWS6FvOBbT1buEUUwO/uk1NzNNanoWsWIDISOpScdFUImer587CFn/xa/faMBH+
 Z60/MZZCbwP9wwG3M7m1qfgDNy3F2xGocM5RhEv/qGpSGKSSGhcP/sime6V2LBvl44GSI1wH57q
 muBeClvuONXT5mSehLxUGZhojD4ElmSbUYt7PQ+6z8vsTmwF01lE7wumgd+z25NP6VwYGdw8g9r
 gnNCchCR+Zq0G16145tSzg8eHVVY+XPlsybTL6/J7LRJepli1qpdl6aGJxxdfe4AfDyHKK3QE/M
 C/sBJHJQLhhWOgcVZmiaWWpppEYmYZCEmxjQd3cpvUg5H/7E
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: ueFeR-ADgUinF2AHA64zUfeG3oUkrmpM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfXyPs7XpoLXroQ
 bPMlftN8INnhOyg6AukfX8hO9D0aIhmtBcjje3evfBCtdsq2Mq5SSSIKeoycrMW/wjNj3Ztvt7c
 6MpbEHNKaC4pBrzyxvl4iz8hwRWwCnojLTW2Oh/yflC7vvVTUJniIUpzUKoQpsH8cAiePRVHQD9
 cBPXKkDE+ZE9kX6uSZuFTiJnB2OU6+hsK9CixTZasDf3V7BiGj6pmcRG2ATfO7PwtKlLa5MscTt
 4NP7WydB/GKfoka2Y5SVir/5EZ0SqtU1vwgzNcR4t4lyIVblw72Fl5rGRKPAC9U2UvlHI/Wy+mY
 KznVADYVE6gCy0cM/c94AX7kakzxVvvoQheLMs2GP2YJ36RUS46vAH75KTgS5JgiHk9dCMvvE7R
 RUMq/fX8
X-Proofpoint-GUID: ueFeR-ADgUinF2AHA64zUfeG3oUkrmpM
X-Authority-Analysis: v=2.4 cv=V7B90fni c=1 sm=1 tr=0 ts=68a07c68 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=EjBJG3Ffxhrz6juHXs8A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160020

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
 drivers/gpu/drm/display/drm_bridge_connector.c     |  6 +++
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    | 43 +++++++++++++++++++++-
 drivers/gpu/drm/drm_connector.c                    |  4 ++
 drivers/gpu/drm/drm_debugfs.c                      | 16 +++++---
 drivers/gpu/drm/rockchip/inno_hdmi.c               |  1 +
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  1 +
 drivers/gpu/drm/tests/drm_connector_test.c         | 28 ++++++++++++++
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |  8 ++++
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  4 ++
 include/drm/drm_bridge.h                           |  7 ++++
 include/drm/drm_connector.h                        | 23 ++++++++++++
 11 files changed, 134 insertions(+), 7 deletions(-)

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
index a561f124be99a0cd4259dbacf5f5f6651ff8a0ea..fb8b9e3769cb74345f9c6ef6f6ca441a373141c1 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -687,6 +687,10 @@ static int hdmi_generate_avi_infoframe(const struct drm_connector *connector,
 
 	infoframe->set = false;
 
+	if (!drm_hdmi_connector_supports_infoframe(connector,
+						   HDMI_INFOFRAME_TYPE_AVI))
+		return 0;
+
 	ret = drm_hdmi_avi_infoframe_from_display_mode(frame, connector, mode);
 	if (ret)
 		return ret;
@@ -718,6 +722,10 @@ static int hdmi_generate_spd_infoframe(const struct drm_connector *connector,
 
 	infoframe->set = false;
 
+	if (!drm_hdmi_connector_supports_infoframe(connector,
+						   HDMI_INFOFRAME_TYPE_SPD))
+		return 0;
+
 	ret = hdmi_spd_infoframe_init(frame,
 				      connector->hdmi.vendor,
 				      connector->hdmi.product);
@@ -742,6 +750,10 @@ static int hdmi_generate_hdr_infoframe(const struct drm_connector *connector,
 
 	infoframe->set = false;
 
+	if (!drm_hdmi_connector_supports_infoframe(connector,
+						   HDMI_INFOFRAME_TYPE_DRM))
+		return 0;
+
 	if (connector->max_bpc < 10)
 		return 0;
 
@@ -771,6 +783,10 @@ static int hdmi_generate_hdmi_vendor_infoframe(const struct drm_connector *conne
 
 	infoframe->set = false;
 
+	if (!drm_hdmi_connector_supports_infoframe(connector,
+						   HDMI_INFOFRAME_TYPE_VENDOR))
+		return 0;
+
 	if (!info->has_hdmi_infoframe)
 		return 0;
 
@@ -905,6 +921,11 @@ static int clear_device_infoframe(struct drm_connector *connector,
 		return 0;
 	}
 
+	if (!drm_hdmi_connector_supports_infoframe(connector, type)) {
+		drm_dbg_kms(dev, "Infoframe %d not supported, bailing.\n", type);
+		return 0;
+	}
+
 	ret = funcs->clear_infoframe(connector, type);
 	if (ret) {
 		drm_dbg_kms(dev, "Call failed: %d\n", ret);
@@ -932,21 +953,27 @@ static int write_device_infoframe(struct drm_connector *connector,
 	const struct drm_connector_hdmi_funcs *funcs = connector->hdmi.funcs;
 	struct drm_device *dev = connector->dev;
 	u8 buffer[HDMI_INFOFRAME_SIZE(MAX)];
+	enum hdmi_infoframe_type type = frame->any.type;
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
@@ -1067,6 +1094,12 @@ drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector *co
 	struct drm_display_info *info = &connector->display_info;
 	int ret;
 
+	if (!drm_hdmi_connector_supports_infoframe(connector,
+						   HDMI_INFOFRAME_TYPE_AUDIO)) {
+		drm_dbg_kms(connector->dev, "Audio Infoframe not supported, bailing.\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (!info->is_hdmi)
 		return 0;
 
@@ -1102,6 +1135,12 @@ drm_atomic_helper_connector_hdmi_clear_audio_infoframe(struct drm_connector *con
 	struct drm_display_info *info = &connector->display_info;
 	int ret;
 
+	if (!drm_hdmi_connector_supports_infoframe(connector,
+						   HDMI_INFOFRAME_TYPE_AUDIO)) {
+		drm_dbg_kms(connector->dev, "Audio Infoframe not supported, bailing.\n");
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
index 07c91b450f93ab9e795d040d6f60f485ac71cfe8..f7024fd554e04dbfa38d24f775ec5993ac8db335 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -556,6 +556,10 @@ static int vc4_hdmi_connector_init(struct drm_device *dev,
 				       BIT(HDMI_COLORSPACE_RGB) |
 				       BIT(HDMI_COLORSPACE_YUV422) |
 				       BIT(HDMI_COLORSPACE_YUV444),
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
index 8f34f4b8183d83dccd3e820a444fbf74fb6c16f2..5b4bc1d7d566d28f90f0aa342a1258685dda6bd0 100644
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
@@ -2488,6 +2495,22 @@ void drm_connector_attach_privacy_screen_provider(
 	struct drm_connector *connector, struct drm_privacy_screen *priv);
 void drm_connector_update_privacy_screen(const struct drm_connector_state *connector_state);
 
+#define DRM_CONNECTOR_INFOFRAME(type)	\
+	BIT(type - 0x80)
+
+#define DRM_CONNECTOR_INFOFRAME_AUDIO DRM_CONNECTOR_INFOFRAME(HDMI_INFOFRAME_TYPE_AUDIO)
+#define DRM_CONNECTOR_INFOFRAME_AVI DRM_CONNECTOR_INFOFRAME(HDMI_INFOFRAME_TYPE_AVI)
+#define DRM_CONNECTOR_INFOFRAME_DRM DRM_CONNECTOR_INFOFRAME(HDMI_INFOFRAME_TYPE_DRM)
+#define DRM_CONNECTOR_INFOFRAME_SPD DRM_CONNECTOR_INFOFRAME(HDMI_INFOFRAME_TYPE_SPD)
+#define DRM_CONNECTOR_INFOFRAME_VENDOR DRM_CONNECTOR_INFOFRAME(HDMI_INFOFRAME_TYPE_VENDOR)
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


