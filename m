Return-Path: <linux-kernel+bounces-754405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFADB193EE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 13:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E543B699D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 11:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E2C1B043F;
	Sun,  3 Aug 2025 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oa1McpqS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69042259CB6
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754222050; cv=none; b=C3i0acrisqkpScU2f9mXh5g24u4GEpVEe+bG2xRppTq0s6XTz3YM+5rDz5vqNRjFFxqOfmc4IXAwOjLq3fI2IuurrstpJsnB57EcadtDIPzr0otkcRsagfP+8ULjtDa2LYsdnQ4Y+C9+JvWDoEDwi/incUEIf1XmDg11STFno1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754222050; c=relaxed/simple;
	bh=Q7HopIOTnY6OvjIs/ZdbZ8AVdNk/D/2TLd7Vbpjb/sM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UVRV1t0EuOnhizcTKtBJUPJBTK2X2PT70X0ZZOwi6vWk/8TcpC6OjPWEICSoaAMA7IXmTacRq8zWcbEuss1el1ifO6vLrRPG9XuIeij6+3dYBHsoGGREHq6Ofig354p/mSZhbeaA8RbdvwmY3nUAhgv+TLwNASPtk9jKvSbLUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oa1McpqS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573BpCaR030135
	for <linux-kernel@vger.kernel.org>; Sun, 3 Aug 2025 11:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OarMjpCIfYSkdkdW6bUdGi1fdmdKOoKfw0cvB3ckh4U=; b=oa1McpqSmnROzTG8
	QRuna6UWkZoGedGlWV6YZR8aK0ASMJbjfkezkiyoRVkkGTEIeWoD4ieRfnSjhhsX
	4Aj+239XFkNc3EndHgD+53KZMaLZBjW7hJTQJhTOhZgH+L3zgDgUDrN5AkTczz4D
	QypwOYTHrh767djrJqj4zpRAKNGMEIh44Pcvz8qzgo6fD+X+vhQ4WrprShxWbbEr
	m9WqVX25dd+me4PVYsMNsTfrRPb5QwSPbYPep81uaCu0M51iakOOvcCoebHBeoQa
	drQhoWbJZOTC7OP90zReWtaMOZWXWQIN1Pc3476r1UaL+9Zj/kaycrIr3Qf75ZTj
	Hswvbg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48a2ke0a2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 11:54:08 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70738c24c4fso22715256d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 04:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754222047; x=1754826847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OarMjpCIfYSkdkdW6bUdGi1fdmdKOoKfw0cvB3ckh4U=;
        b=f5XZoB0vBOSoRLxcbE+hSN+MX3kZES9a1JfOJy4KbE5ftJvxdA1d9nRZcqHsXO69fr
         nSBwIhtMuiCPEj042v2EMfYWR4lgcI/V5y3jIuH/U2banSncioNxFSWZPozsvRgUuTtj
         jjx5YOERnaRuA/+PQodI52BuzwuUGy+IfSXX9SvSXn+DFq1fc/EaQ9WLv+IpDxoVPfEC
         Ypr6HViCMMogAQ8MuFV49DcAIQvmhn6OLYzizGFqeqtd9gFMdsV7BrBveGtdHEnoUGUi
         867pi9wuMNKcMUqb8GQoA/cpbBoAyw8qiZ6dWuXBTAmtjChXIhgAdXpSZV3JfENrzecM
         rAeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+aadOoN9J25H/+4oe1Pe9rHs9bA/z61BkGmVYxJrlsfmbzgLV4zE/ii8E1/oyY6l7s98+Cg5zHt+h7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPG4bQ9ditd/GE5Bp0Pasy5Yt8E4ka0lvBfag+Ob2uH+eNzCQF
	KfBg7K8o5RQ7CjX6D5zjTiPM7WEw42L+oRFytGsBt/1oTeuQbzPY/oKppe2ix9dGaVAkmvMhErJ
	iwYKrzxY55I7XsZ4DBkJg/2V6NxHDPmSejMzuKZTfIMzRslN/UICEkecmCMRRO1Nx+dw=
X-Gm-Gg: ASbGnctTSrrvrH0EVhtahYVK9nDwtteY7EFvqaFegDyO2VSt4vN7lUnQmUhRfqfaXJg
	XuTlhjWOJMC6anX+myF/6R08+Qgs41NbxeDKASuQrpGw2OadYbmBtgac2jyLLfz/CNPBuRjFmE5
	azS/L3UjGZCRrqLeSlgepbSWznXmJtwBMQMvtOlC/lmHxToyTA1pGQuOggSFfFpcpBcPQCMpNtG
	4g5ftNVBoi5W/g+NsJna6iFOfDj7IPKLCqH0qQryYD9qQahZffg9UCfX/RJURTHKtu+RVptJsEY
	sULF5G/2tCNzyvae0PDlxDZ7fETHgP0q1y2GUA2hXWryL1OGT9Lv0l9QQMqdv331TN8Qq8nvoM6
	dIM0orgDycclRc6a33Gg1IiKY7WEWwNgE60/TlOJ9BJU9fFcKCdrD
X-Received: by 2002:a05:6214:5294:b0:707:458a:a1d2 with SMTP id 6a1803df08f44-70935f0e68fmr68792756d6.8.1754222046910;
        Sun, 03 Aug 2025 04:54:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYJtAa3Jt0m4NRJ/zRiS+cHF+uv22QjpHfvokGO6es+edxh1sHS3nM88A/XbZxPix1pvJmiQ==
X-Received: by 2002:a05:6214:5294:b0:707:458a:a1d2 with SMTP id 6a1803df08f44-70935f0e68fmr68792176d6.8.1754222046367;
        Sun, 03 Aug 2025 04:54:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382a6f74sm13281731fa.20.2025.08.03.04.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 04:54:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 03 Aug 2025 14:53:52 +0300
Subject: [PATCH RESEND 2/2] drm/bridge: lontium-lt9611uxc: switch to HDMI
 audio helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250803-lt9611uxc-hdmi-v1-2-cb9ce1793acf@oss.qualcomm.com>
References: <20250803-lt9611uxc-hdmi-v1-0-cb9ce1793acf@oss.qualcomm.com>
In-Reply-To: <20250803-lt9611uxc-hdmi-v1-0-cb9ce1793acf@oss.qualcomm.com>
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
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6559;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Q7HopIOTnY6OvjIs/ZdbZ8AVdNk/D/2TLd7Vbpjb/sM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoj03ToPLH5Byq4lo7D85bCtTHS3XG0bPogIwUm
 /cQUERHctaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaI9N0wAKCRCLPIo+Aiko
 1cISCACQxo+ezbLEzR4+iHyyDF4DOdbCBE2hKG6Hc92ZzUWkMsqgNRYIUT6Y0Nwn7z8nzXnKPGz
 Sr1DlH5k7vW+iMx3htubJgM16nalVz/Ok5Z6u+nP40p/jJf6bhXs48L6dOgmSuVD40TTxeuGBsK
 jRXcFGWuJMlExM8CNm1rgGCGhSwIgtfR3yxlw4Jr4B6ahSAWv8MSduTARspo9R/jygywBJIUnE7
 /oRJ4ZmPppuoSdVLRkhn0grwm7GzpA5Ngcifv2AuRc5iqpCElMmCfehgYz/Dq6hqcD033zdAngt
 FXHGkjxPSJLtzYA6XEKD+3T4jbt5Hur7470I+jS0DmcQx8x9
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: HrZ5JFjN7LQTgFDUxFQxV74b5eqmE6Ah
X-Authority-Analysis: v=2.4 cv=TMNFS0la c=1 sm=1 tr=0 ts=688f4de0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=rji8DJjHHTBzgOBfyK4A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAzMDA4MCBTYWx0ZWRfX3lRfozrEEc+K
 teHBeyQyQvnByaeHTE5XYXy+ZV2bfmgyZbKbXRvP3KeasYRr80GTjM3vnC8Tz/vAYUrhhWIQ6hd
 Q9l+JWvKD5dKUGxxhZeugIBsnOsTAf8BIsixFeIFGaYuQOTydyEu8/sf+9FURnshIhhNeBoYCZs
 bET8SgmQOHnGXqbV5CchuQswoJGNRmeUficAv7UX0L5kKmJTHwiuyUxXlHVvIFUkMxu/1Ltoyz2
 p7P0KwJlAVWwxLqZCnbYQh5QRLxtg0c8/RcYkQkOtYGsZ/FL8vu82GHPVi4weup+m//3X7ozCez
 5Srb5g6tqCYzpls4KoiAiVCKQNQNs4Wg8VDIAYX/qnXKcL2DBelRI/iQfU/IoLYA720xYyo0wgo
 cjb3XrkZc/s/q8qXOUr8J2IpX4ik4I5ltkc3yK0uJ7NU6aBUIammlR3PKA0wyLtTxXPbhVmx
X-Proofpoint-GUID: HrZ5JFjN7LQTgFDUxFQxV74b5eqmE6Ah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_03,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508030080

While LT9611UXC is a DSI-to-HDMI bridge, it implements all HDMI-related
functions internally, in the firmware, thus it doesn't make sense to
implement DRM_BRIDGE_OP_HDMI. However it is possible to implement
DRM_BRIDGE_OP_HDMI_AUDIO, streamlining HDMI audio plumbing (which
includes plugged notifications and ELD handling).

Implement corresponding callbacks and trigger EDID read /
drm_connector_hdmi_audio_plugged_notify() from the hpd_notify callback.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 125 +++++++++++------------------
 1 file changed, 49 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 38fb8776c0f441ae433c60a7680aaa6501a8956e..11aab07d88df646a54fea287030a183eb823b26d 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -17,8 +17,6 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
-#include <sound/hdmi-codec.h>
-
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_edid.h>
@@ -27,6 +25,8 @@
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
+#include <drm/display/drm_hdmi_audio_helper.h>
+
 #define EDID_BLOCK_SIZE	128
 #define EDID_NUM_BLOCKS	2
 
@@ -48,7 +48,6 @@ struct lt9611uxc {
 	struct device_node *dsi1_node;
 	struct mipi_dsi_device *dsi0;
 	struct mipi_dsi_device *dsi1;
-	struct platform_device *audio_pdev;
 
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *enable_gpio;
@@ -429,12 +428,52 @@ static const struct drm_edid *lt9611uxc_bridge_edid_read(struct drm_bridge *brid
 	return drm_edid_read_custom(connector, lt9611uxc_get_edid_block, lt9611uxc);
 }
 
+static void lt9611uxc_bridge_hpd_notify(struct drm_bridge *bridge,
+					struct drm_connector *connector,
+					enum drm_connector_status status)
+{
+	const struct drm_edid *drm_edid;
+
+	if (status == connector_status_disconnected) {
+		drm_connector_hdmi_audio_plugged_notify(connector, false);
+		drm_edid_connector_update(connector, NULL);
+		return;
+	}
+
+	drm_edid = lt9611uxc_bridge_edid_read(bridge, connector);
+	drm_edid_connector_update(connector, drm_edid);
+	drm_edid_free(drm_edid);
+
+	if (status == connector_status_connected)
+		drm_connector_hdmi_audio_plugged_notify(connector, true);
+}
+
+static int lt9611uxc_hdmi_audio_prepare(struct drm_bridge *bridge,
+					struct drm_connector *connector,
+					struct hdmi_codec_daifmt *fmt,
+					struct hdmi_codec_params *hparms)
+{
+	/*
+	 * LT9611UXC will automatically detect rate and sample size, so no need
+	 * to setup anything here.
+	 */
+	return 0;
+}
+
+static void lt9611uxc_hdmi_audio_shutdown(struct drm_bridge *bridge,
+					  struct drm_connector *connector)
+{
+}
+
 static const struct drm_bridge_funcs lt9611uxc_bridge_funcs = {
 	.attach = lt9611uxc_bridge_attach,
 	.mode_valid = lt9611uxc_bridge_mode_valid,
 	.mode_set = lt9611uxc_bridge_mode_set,
 	.detect = lt9611uxc_bridge_detect,
 	.edid_read = lt9611uxc_bridge_edid_read,
+	.hpd_notify = lt9611uxc_bridge_hpd_notify,
+	.hdmi_audio_prepare = lt9611uxc_hdmi_audio_prepare,
+	.hdmi_audio_shutdown = lt9611uxc_hdmi_audio_shutdown,
 };
 
 static int lt9611uxc_parse_dt(struct device *dev,
@@ -508,73 +547,6 @@ static int lt9611uxc_read_version(struct lt9611uxc *lt9611uxc)
 	return ret < 0 ? ret : rev;
 }
 
-static int lt9611uxc_hdmi_hw_params(struct device *dev, void *data,
-				    struct hdmi_codec_daifmt *fmt,
-				    struct hdmi_codec_params *hparms)
-{
-	/*
-	 * LT9611UXC will automatically detect rate and sample size, so no need
-	 * to setup anything here.
-	 */
-	return 0;
-}
-
-static void lt9611uxc_audio_shutdown(struct device *dev, void *data)
-{
-}
-
-static int lt9611uxc_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
-					 struct device_node *endpoint,
-					 void *data)
-{
-	struct of_endpoint of_ep;
-	int ret;
-
-	ret = of_graph_parse_endpoint(endpoint, &of_ep);
-	if (ret < 0)
-		return ret;
-
-	/*
-	 * HDMI sound should be located as reg = <2>
-	 * Then, it is sound port 0
-	 */
-	if (of_ep.port == 2)
-		return 0;
-
-	return -EINVAL;
-}
-
-static const struct hdmi_codec_ops lt9611uxc_codec_ops = {
-	.hw_params	= lt9611uxc_hdmi_hw_params,
-	.audio_shutdown = lt9611uxc_audio_shutdown,
-	.get_dai_id	= lt9611uxc_hdmi_i2s_get_dai_id,
-};
-
-static int lt9611uxc_audio_init(struct device *dev, struct lt9611uxc *lt9611uxc)
-{
-	struct hdmi_codec_pdata codec_data = {
-		.ops = &lt9611uxc_codec_ops,
-		.max_i2s_channels = 2,
-		.i2s = 1,
-		.data = lt9611uxc,
-	};
-
-	lt9611uxc->audio_pdev =
-		platform_device_register_data(dev, HDMI_CODEC_DRV_NAME,
-					      PLATFORM_DEVID_AUTO,
-					      &codec_data, sizeof(codec_data));
-
-	return PTR_ERR_OR_ZERO(lt9611uxc->audio_pdev);
-}
-
-static void lt9611uxc_audio_exit(struct lt9611uxc *lt9611uxc)
-{
-	if (lt9611uxc->audio_pdev) {
-		platform_device_unregister(lt9611uxc->audio_pdev);
-		lt9611uxc->audio_pdev = NULL;
-	}
-}
-
 #define LT9611UXC_FW_PAGE_SIZE 32
 static void lt9611uxc_firmware_write_page(struct lt9611uxc *lt9611uxc, u16 addr, const u8 *buf)
 {
@@ -858,11 +830,17 @@ static int lt9611uxc_probe(struct i2c_client *client)
 	i2c_set_clientdata(client, lt9611uxc);
 
 	lt9611uxc->bridge.of_node = client->dev.of_node;
-	lt9611uxc->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
+	lt9611uxc->bridge.ops = DRM_BRIDGE_OP_DETECT |
+		DRM_BRIDGE_OP_EDID |
+		DRM_BRIDGE_OP_HDMI_AUDIO;
 	if (lt9611uxc->hpd_supported)
 		lt9611uxc->bridge.ops |= DRM_BRIDGE_OP_HPD;
 	lt9611uxc->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 
+	lt9611uxc->bridge.hdmi_audio_dev = dev;
+	lt9611uxc->bridge.hdmi_audio_max_i2s_playback_channels = 2;
+	lt9611uxc->bridge.hdmi_audio_dai_port = 2;
+
 	drm_bridge_add(&lt9611uxc->bridge);
 
 	/* Attach primary DSI */
@@ -881,10 +859,6 @@ static int lt9611uxc_probe(struct i2c_client *client)
 		}
 	}
 
-	ret = lt9611uxc_audio_init(dev, lt9611uxc);
-	if (ret)
-		goto err_remove_bridge;
-
 	return 0;
 
 err_remove_bridge:
@@ -908,7 +882,6 @@ static void lt9611uxc_remove(struct i2c_client *client)
 
 	free_irq(client->irq, lt9611uxc);
 	cancel_work_sync(&lt9611uxc->work);
-	lt9611uxc_audio_exit(lt9611uxc);
 	drm_bridge_remove(&lt9611uxc->bridge);
 
 	mutex_destroy(&lt9611uxc->ocm_lock);

-- 
2.39.5


