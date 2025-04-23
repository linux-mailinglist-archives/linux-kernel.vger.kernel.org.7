Return-Path: <linux-kernel+bounces-616868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0F8A99733
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 19:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954B31B833D8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C0028CF6B;
	Wed, 23 Apr 2025 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FNjoF03p"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC628BAA8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745430772; cv=none; b=aGQvDKUDQa0m4x7um0rnmivLme69ekYQadLtBMAiL46uVwvSwf62+7E+1cLfWsW6TA344oScQmwFztLhPvw8ndfp5rqSkkoCnQHvG78VcA2ezSLIBBbxKi16k8jfLuthLj0NoskGtRbO0nBe/7MdRBiGbluU+vSZufEbsZ0Jq/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745430772; c=relaxed/simple;
	bh=x+8PxDeMkmUFMoOzBPreV7yrh5T6ePlwSLpA45n3oTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DIGFtDKjAW71133Lad58ZTBpM805vsorgL/5MifOkPCcX99cNlzAfbqIyXxkrKhEthJ3jKwF9fmwKCyFTmXsgj8vWI9JLEybdLz7l3c6W1w6xbVY4XSCEFVbZUC5cN5IB9uy2X8o5VKdc6Tt9PNHGCp+2L4PwrO0bf8cenAMwZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FNjoF03p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NAkmPN003191
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 17:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rJBziJdVKGd+U1aRarV6xf
	PxdaU3heLDlLUsnc4hHzs=; b=FNjoF03pGwFAC8CUpPgKgDKvfo1+3HiFPnwiOC
	N9nVCHG7hzFDeC3rLsRxK/e9jSJ5IMZW6BLJfPIDEkoUsSg7jcvTXHKpRdWPwBoN
	c5Yr0rXzJs/yHH9GukP1yuCzItsSMo06Pnh7RuFM+zBDXGHEEWCNs9Gjzxo8fCyV
	JrZFM9qoQppCRF0TgeWuTsd0V9BGX0oJE7hByzSTMCNK/oYgL+AEJsKvFrVPizPV
	gvLA4yiK13qTaPLzMHzk42gzizFFqPMnwn64Jw0hVpYe0iMTTRQ6d5ERbWtJVelm
	VJFHHoi3tvzG1uFb1GXGUQtNPh0T6upn201OG5JAsy2Q5DcQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jgy2y10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 17:52:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5d608e6f5so28164885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 10:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745430768; x=1746035568;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJBziJdVKGd+U1aRarV6xfPxdaU3heLDlLUsnc4hHzs=;
        b=daQpvrbJfrb+iUWlI2vibCdzaD/JtxW8Z846SuQrYKnc5U8Mqy0WhwfhbZQsgFFGuC
         hSg86Zbsfx/pzsFVp5WtmoRXlCwIqZtQTGC7783teG3zaczLmJwhhKdfdfRob/1uDe7s
         HcNiCwlfTOG7vD2vZhBNQRjIUydCJ4U8l+X7k3OydyyGhUt1oF+0ONCj43/YEeAye4tB
         cxv955U/Md3o3GMBxInuucRcVD/Hk5USDir+cFQnXQU3yBPkAKjbaWU7T5Xtpyljf6kB
         8oLAVbpP+YDr3GdXQkH9ygo+IabCiLRdYt/Q6WF9dO8fusroRAUoiBNbVc8+1N9kDRUQ
         i6sg==
X-Forwarded-Encrypted: i=1; AJvYcCUALHfuP2xjo4z98Ljrpy7em21ZMez31GB73lQZLJs3nmaGKGuR7kXxYPghDmfPqhRBuxl7XeaUO/NCKZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1nXLL4oATF+VxKnpEeMJfz1s30aceExpkq8MRtuxRIw2k/2zH
	1LsXmtTzZ4g1eXWX+mGJvH7B6brww7i8OkwD+Bd1YlYGrPVEzRxpKqjvKt9t8DjJUuzFf7n2lfY
	oNOeFvpB2qJ3sLRdgd7uBThyeISQIUED1pjdeHC6YZCbnjpURS2N/5AO3Mx6Shgw=
X-Gm-Gg: ASbGncuQacETB+TtWMUXqI9k8NLuuukZnWC7po0EoYthEvm8sAct9/7fhYAy4y9cxbQ
	gLUz3MAPKd7jaldLG1ZzzsSzayqsTjzEVKH36/aZAJpFcZwOOoKzNqlaV6LjhTRh7vUI6CQ6L/I
	0tZw+YXKiqranhb7jiFZJFwjZVYPOnTyhgqfMcDy03Az5s9rYw9i2LhZSA4zy6937335+KMZm1T
	SedYKPuzdFV89GdPqrUoifNTUgj9C0FPQYW6QxYRFu0x4JUHCSA4rTy/xsp9zNRHaSDFVmb1tbI
	EdzF+ewZAEobnP8reswi9LKTXMDpm5uuLuQVyeri3vFHGlCMV677ylyM4XQ4hrEvzH6rSQoaq8y
	yWvWiS4FTC76Pwds7xCbM3iiY
X-Received: by 2002:a05:620a:408a:b0:7c7:a5f5:5616 with SMTP id af79cd13be357-7c928015e4cmr2844233385a.42.1745430768317;
        Wed, 23 Apr 2025 10:52:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH06bKro5o+MpHPMmBUD8XdZI2r4jnXZAX6VOuKtKLaYMgm91xHLkpTseCzHq1rm6HfhxaxHQ==
X-Received: by 2002:a05:620a:408a:b0:7c7:a5f5:5616 with SMTP id af79cd13be357-7c928015e4cmr2844226485a.42.1745430767624;
        Wed, 23 Apr 2025 10:52:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d6e5f516bsm1588710e87.221.2025.04.23.10.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:52:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 23 Apr 2025 20:52:45 +0300
Subject: [PATCH v7] drm/msm/dp: reuse generic HDMI codec implementation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-dp-hdmi-audio-v7-1-8407a23e55b2@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOwoCWgC/3XQwWrEIBAG4FdZPNego8akp32Psgd1dCNs4la7o
 WXJu9fspSGhl4F/4PsZ5kmKz9EX8n56kuznWGKaatBvJ+IGM109jVgzAQaKAWsp3umAY6TmgTF
 RrrAPaL21fSDV3LMP8fvV93GpeYjlK+WfV/3M1+1/TTOnjHbGcGk6x1Di+RYnk1OT8pWsVTNse
 b/nUDlv0bbeBoAQDlxsOD9wUbmEnrHAhLSSHbj844LxPZfr8aBFjyZA59yBqy3Xe64qD8J64Kp
 +U3cH3m44l3veVo4WAbpgtEB9TqU0nw9zc2kcmzrIZVmWX/hQY5zsAQAA
X-Change-ID: 20250206-dp-hdmi-audio-15d9fdbebb9f
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
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Hermes Wu <Hermes.wu@ite.com.tw>, Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15589;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=USmdaNvtUti3XoeMQJw2vdNINUHLESzxn6cO7uGNC3c=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoCSjusuNS8VYTXvwcrCifxb/u92yLsudpehbxQ
 jjegQmnHBKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaAko7gAKCRCLPIo+Aiko
 1UyJB/4vlZucDGKjjs099wh+9yQe4YzzsE5br8pIqyhkx+1lvFl8tcjk9asJl9eWWxTqoP9oold
 s0nIGZSD+o/yyo0bC1fm/BmJlq48yRkmxAF8DGE+rGNAqjanuV5zs5EPbcV0axXrakMHWXKG+fF
 vz7+5Tk7BsCFyu+njpnfbgmTci0uudCrmsjRhgG4QFt8zSBAv774gAoPwZ6FlfOufV0rQEG/85z
 odkF2EkCEflxd+5ItI6nzFMQSrLU4j/dK5k7hroK1y1qyAo4mjYUdI2hnj82sLsiEEfdU18gv41
 GxX2cM3oIdgfTtwjGwbWsfG96Y5gksyAgZoSRDjnm5AvGA7l
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEyNSBTYWx0ZWRfX7EhxHVznSLwm hwwUHxbXkTbowyWfzLg9gTkFHw39CCJCW3s1YpqBnOWGczx4gFwfuA8LVBZaslPNbcEQS+/vIyO /vLSDwGkF16v6nkt58uoSEHMB9GEhxBbG7CtpUsHK/gwRmBW5QOqWfD6lQLd9NIlo18PajYt/ZE
 Od3RSkN48BVj5VanZju9yrLQmWrq2kJS9fEKzNPARop2qgUlpoxNvTtSgrUNO4ZYotG6Vv+Udlx CVgNeI5ZMQmQC5UEfUqensrb4nr6UnXZgq4e0/BGNCK1ITmIFjgk+KNseK1WETjmVNbyCye8UMV oZPNwUiw243wU0bYqR9s93DYPcXPQlrg9Yt2H37YQSV/wYNNm53siYngmdXk/nHV7AQ86n9jl48
 JxRU29Ryr2Yj9eRVe3DTqzViEGgOKrGC5LbCVIxH2RGqHEQm4qeC+7U3VXQ0L9mzLDUApozK
X-Proofpoint-GUID: OAogynRiu5cgPlGiJ146oToAAnNbMuPS
X-Proofpoint-ORIG-GUID: OAogynRiu5cgPlGiJ146oToAAnNbMuPS
X-Authority-Analysis: v=2.4 cv=M5VNKzws c=1 sm=1 tr=0 ts=680928f1 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=5sB3F6IwpAO9Ay8VHbAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_10,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230125

From: Dmitry Baryshkov <lumag@kernel.org>

The MSM DisplayPort driver implements several HDMI codec functions
in the driver, e.g. it manually manages HDMI codec device registration,
returning ELD and plugged_cb support. In order to reduce code
duplication reuse drm_hdmi_audio_* helpers and drm_bridge_connector
integration.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
A lot of DisplayPort bridges use HDMI Codec in order to provide audio
support. Present DRM HDMI Audio support has been written with the HDMI
and in particular DRM HDMI Connector framework support, however those
audio helpers can be easily reused for DisplayPort drivers too.

Patches by Hermes Wu that targeted implementing HDMI Audio support in
the iTE IT6506 driver pointed out the necessity of allowing one to use
generic audio helpers for DisplayPort drivers, as otherwise each driver
has to manually (and correctly) implement the get_eld() and plugged_cb
support.

Implement necessary integration in drm_bridge_connector and provide an
example implementation in the msm/dp driver.
---
Changes in v7:
- Dropped applied patches
- Link to v6: https://lore.kernel.org/r/20250314-dp-hdmi-audio-v6-0-dbd228fa73d7@oss.qualcomm.com

Changes in v6:
- Added DRM_BRIDGE_OP_DP_AUDIO and separate set of DisplayPort audio
  callbacks to the drm_bridge interface (Maxime)
- Link to v5: https://lore.kernel.org/r/20250307-dp-hdmi-audio-v5-0-f3be215fdb78@linaro.org

Changes in v5:
- Rebased on top of linux-next, also handling HDMI audio piece of the
  MSM HDMI driver.
- Link to v4: https://lore.kernel.org/r/20250301-dp-hdmi-audio-v4-0-82739daf28cc@linaro.org

Changes in v4:
- Rebased on linux-next, adding DRM_BRIDGE_OP_HDMI_AUDIO to Synopsys QP
  HDMI driver.
- Drop outdated comment regarding subconnector from the commit message.
- Link to v3: https://lore.kernel.org/r/20250219-dp-hdmi-audio-v3-0-42900f034b40@linaro.org

Changes in v3:
- Dropped DRM_BRIDGE_OP_DisplayPort, added DRM_BRIDGE_OP_HDMI_AUDIO
  (Laurent, Maxime)
- Dropped the subconnector patch (again)
- Link to v2: https://lore.kernel.org/r/20250209-dp-hdmi-audio-v2-0-16db6ebf22ff@linaro.org

Changes in v2:
- Added drm_connector_attach_dp_subconnector_property() patches
- Link to v1: https://lore.kernel.org/r/20250206-dp-hdmi-audio-v1-0-8aa14a8c0d4d@linaro.org
---
 drivers/gpu/drm/msm/Kconfig         |   1 +
 drivers/gpu/drm/msm/dp/dp_audio.c   | 131 ++++--------------------------------
 drivers/gpu/drm/msm/dp/dp_audio.h   |  27 ++------
 drivers/gpu/drm/msm/dp/dp_display.c |  28 ++------
 drivers/gpu/drm/msm/dp/dp_display.h |   6 --
 drivers/gpu/drm/msm/dp/dp_drm.c     |   8 +++
 6 files changed, 31 insertions(+), 170 deletions(-)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 974bc7c0ea761147d3326bdce9039d6f26f290d0..7f127e2ae44292f8f5c7ff6a9251c3d7ec8c9f58 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -104,6 +104,7 @@ config DRM_MSM_DPU
 config DRM_MSM_DP
 	bool "Enable DisplayPort support in MSM DRM driver"
 	depends on DRM_MSM
+	select DRM_DISPLAY_HDMI_AUDIO_HELPER
 	select RATIONAL
 	default y
 	help
diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 70fdc9fe228a7149546accd8479a9e4397f3d5dd..f8bfb908f9b4bf93ad5480f0785e3aed23dde160 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -13,13 +13,13 @@
 
 #include "dp_catalog.h"
 #include "dp_audio.h"
+#include "dp_drm.h"
 #include "dp_panel.h"
 #include "dp_reg.h"
 #include "dp_display.h"
 #include "dp_utils.h"
 
 struct msm_dp_audio_private {
-	struct platform_device *audio_pdev;
 	struct platform_device *pdev;
 	struct drm_device *drm_dev;
 	struct msm_dp_catalog *catalog;
@@ -160,24 +160,11 @@ static void msm_dp_audio_enable(struct msm_dp_audio_private *audio, bool enable)
 	msm_dp_catalog_audio_enable(catalog, enable);
 }
 
-static struct msm_dp_audio_private *msm_dp_audio_get_data(struct platform_device *pdev)
+static struct msm_dp_audio_private *msm_dp_audio_get_data(struct msm_dp *msm_dp_display)
 {
 	struct msm_dp_audio *msm_dp_audio;
-	struct msm_dp *msm_dp_display;
-
-	if (!pdev) {
-		DRM_ERROR("invalid input\n");
-		return ERR_PTR(-ENODEV);
-	}
-
-	msm_dp_display = platform_get_drvdata(pdev);
-	if (!msm_dp_display) {
-		DRM_ERROR("invalid input\n");
-		return ERR_PTR(-ENODEV);
-	}
 
 	msm_dp_audio = msm_dp_display->msm_dp_audio;
-
 	if (!msm_dp_audio) {
 		DRM_ERROR("invalid msm_dp_audio data\n");
 		return ERR_PTR(-EINVAL);
@@ -186,68 +173,16 @@ static struct msm_dp_audio_private *msm_dp_audio_get_data(struct platform_device
 	return container_of(msm_dp_audio, struct msm_dp_audio_private, msm_dp_audio);
 }
 
-static int msm_dp_audio_hook_plugged_cb(struct device *dev, void *data,
-		hdmi_codec_plugged_cb fn,
-		struct device *codec_dev)
-{
-
-	struct platform_device *pdev;
-	struct msm_dp *msm_dp_display;
-
-	pdev = to_platform_device(dev);
-	if (!pdev) {
-		pr_err("invalid input\n");
-		return -ENODEV;
-	}
-
-	msm_dp_display = platform_get_drvdata(pdev);
-	if (!msm_dp_display) {
-		pr_err("invalid input\n");
-		return -ENODEV;
-	}
-
-	return msm_dp_display_set_plugged_cb(msm_dp_display, fn, codec_dev);
-}
-
-static int msm_dp_audio_get_eld(struct device *dev,
-	void *data, uint8_t *buf, size_t len)
-{
-	struct platform_device *pdev;
-	struct msm_dp *msm_dp_display;
-
-	pdev = to_platform_device(dev);
-
-	if (!pdev) {
-		DRM_ERROR("invalid input\n");
-		return -ENODEV;
-	}
-
-	msm_dp_display = platform_get_drvdata(pdev);
-	if (!msm_dp_display) {
-		DRM_ERROR("invalid input\n");
-		return -ENODEV;
-	}
-
-	mutex_lock(&msm_dp_display->connector->eld_mutex);
-	memcpy(buf, msm_dp_display->connector->eld,
-		min(sizeof(msm_dp_display->connector->eld), len));
-	mutex_unlock(&msm_dp_display->connector->eld_mutex);
-
-	return 0;
-}
-
-int msm_dp_audio_hw_params(struct device *dev,
-	void *data,
-	struct hdmi_codec_daifmt *daifmt,
-	struct hdmi_codec_params *params)
+int msm_dp_audio_prepare(struct drm_connector *connector,
+			 struct drm_bridge *bridge,
+			 struct hdmi_codec_daifmt *daifmt,
+			 struct hdmi_codec_params *params)
 {
 	int rc = 0;
 	struct msm_dp_audio_private *audio;
-	struct platform_device *pdev;
 	struct msm_dp *msm_dp_display;
 
-	pdev = to_platform_device(dev);
-	msm_dp_display = platform_get_drvdata(pdev);
+	msm_dp_display = to_dp_bridge(bridge)->msm_dp_display;
 
 	/*
 	 * there could be cases where sound card can be opened even
@@ -262,7 +197,7 @@ int msm_dp_audio_hw_params(struct device *dev,
 		goto end;
 	}
 
-	audio = msm_dp_audio_get_data(pdev);
+	audio = msm_dp_audio_get_data(msm_dp_display);
 	if (IS_ERR(audio)) {
 		rc = PTR_ERR(audio);
 		goto end;
@@ -281,15 +216,14 @@ int msm_dp_audio_hw_params(struct device *dev,
 	return rc;
 }
 
-static void msm_dp_audio_shutdown(struct device *dev, void *data)
+void msm_dp_audio_shutdown(struct drm_connector *connector,
+			   struct drm_bridge *bridge)
 {
 	struct msm_dp_audio_private *audio;
-	struct platform_device *pdev;
 	struct msm_dp *msm_dp_display;
 
-	pdev = to_platform_device(dev);
-	msm_dp_display = platform_get_drvdata(pdev);
-	audio = msm_dp_audio_get_data(pdev);
+	msm_dp_display = to_dp_bridge(bridge)->msm_dp_display;
+	audio = msm_dp_audio_get_data(msm_dp_display);
 	if (IS_ERR(audio)) {
 		DRM_ERROR("failed to get audio data\n");
 		return;
@@ -311,47 +245,6 @@ static void msm_dp_audio_shutdown(struct device *dev, void *data)
 	msm_dp_display_signal_audio_complete(msm_dp_display);
 }
 
-static const struct hdmi_codec_ops msm_dp_audio_codec_ops = {
-	.hw_params = msm_dp_audio_hw_params,
-	.audio_shutdown = msm_dp_audio_shutdown,
-	.get_eld = msm_dp_audio_get_eld,
-	.hook_plugged_cb = msm_dp_audio_hook_plugged_cb,
-};
-
-static struct hdmi_codec_pdata codec_data = {
-	.ops = &msm_dp_audio_codec_ops,
-	.max_i2s_channels = 8,
-	.i2s = 1,
-};
-
-void msm_dp_unregister_audio_driver(struct device *dev, struct msm_dp_audio *msm_dp_audio)
-{
-	struct msm_dp_audio_private *audio_priv;
-
-	audio_priv = container_of(msm_dp_audio, struct msm_dp_audio_private, msm_dp_audio);
-
-	if (audio_priv->audio_pdev) {
-		platform_device_unregister(audio_priv->audio_pdev);
-		audio_priv->audio_pdev = NULL;
-	}
-}
-
-int msm_dp_register_audio_driver(struct device *dev,
-		struct msm_dp_audio *msm_dp_audio)
-{
-	struct msm_dp_audio_private *audio_priv;
-
-	audio_priv = container_of(msm_dp_audio,
-			struct msm_dp_audio_private, msm_dp_audio);
-
-	audio_priv->audio_pdev = platform_device_register_data(dev,
-						HDMI_CODEC_DRV_NAME,
-						PLATFORM_DEVID_AUTO,
-						&codec_data,
-						sizeof(codec_data));
-	return PTR_ERR_OR_ZERO(audio_priv->audio_pdev);
-}
-
 struct msm_dp_audio *msm_dp_audio_get(struct platform_device *pdev,
 			struct msm_dp_catalog *catalog)
 {
diff --git a/drivers/gpu/drm/msm/dp/dp_audio.h b/drivers/gpu/drm/msm/dp/dp_audio.h
index beea34cbab77f31b33873297dc454a9cee446240..58fc14693e48bff2b57ef7278983e5f21ee80ac7 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.h
+++ b/drivers/gpu/drm/msm/dp/dp_audio.h
@@ -35,23 +35,6 @@ struct msm_dp_audio {
 struct msm_dp_audio *msm_dp_audio_get(struct platform_device *pdev,
 			struct msm_dp_catalog *catalog);
 
-/**
- * msm_dp_register_audio_driver()
- *
- * Registers DP device with hdmi_codec interface.
- *
- * @dev: DP device instance.
- * @msm_dp_audio: an instance of msm_dp_audio module.
- *
- *
- * Returns the error code in case of failure, otherwise
- * zero on success.
- */
-int msm_dp_register_audio_driver(struct device *dev,
-		struct msm_dp_audio *msm_dp_audio);
-
-void msm_dp_unregister_audio_driver(struct device *dev, struct msm_dp_audio *msm_dp_audio);
-
 /**
  * msm_dp_audio_put()
  *
@@ -61,10 +44,12 @@ void msm_dp_unregister_audio_driver(struct device *dev, struct msm_dp_audio *msm
  */
 void msm_dp_audio_put(struct msm_dp_audio *msm_dp_audio);
 
-int msm_dp_audio_hw_params(struct device *dev,
-	void *data,
-	struct hdmi_codec_daifmt *daifmt,
-	struct hdmi_codec_params *params);
+int msm_dp_audio_prepare(struct drm_connector *connector,
+			 struct drm_bridge *bridge,
+			 struct hdmi_codec_daifmt *daifmt,
+			 struct hdmi_codec_params *params);
+void msm_dp_audio_shutdown(struct drm_connector *connector,
+			   struct drm_bridge *bridge);
 
 #endif /* _DP_AUDIO_H_ */
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bbc47d86ae9e67245c87a8365df366cce0dc529e..ece184d20c0f8bffa3c2a48216015185d6cbc99e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/string_choices.h>
 #include <drm/display/drm_dp_aux_bus.h>
+#include <drm/display/drm_hdmi_audio_helper.h>
 #include <drm/drm_edid.h>
 
 #include "msm_drv.h"
@@ -288,13 +289,6 @@ static int msm_dp_display_bind(struct device *dev, struct device *master,
 		goto end;
 	}
 
-
-	rc = msm_dp_register_audio_driver(dev, dp->audio);
-	if (rc) {
-		DRM_ERROR("Audio registration Dp failed\n");
-		goto end;
-	}
-
 	rc = msm_dp_hpd_event_thread_start(dp);
 	if (rc) {
 		DRM_ERROR("Event thread create failed\n");
@@ -316,7 +310,6 @@ static void msm_dp_display_unbind(struct device *dev, struct device *master,
 
 	of_dp_aux_depopulate_bus(dp->aux);
 
-	msm_dp_unregister_audio_driver(dev, dp->audio);
 	msm_dp_aux_unregister(dp->aux);
 	dp->drm_dev = NULL;
 	dp->aux->drm_dev = NULL;
@@ -626,9 +619,9 @@ static void msm_dp_display_handle_plugged_change(struct msm_dp *msm_dp_display,
 			struct msm_dp_display_private, msm_dp_display);
 
 	/* notify audio subsystem only if sink supports audio */
-	if (msm_dp_display->plugged_cb && msm_dp_display->codec_dev &&
-			dp->audio_supported)
-		msm_dp_display->plugged_cb(msm_dp_display->codec_dev, plugged);
+	if (dp->audio_supported)
+		drm_connector_hdmi_audio_plugged_notify(msm_dp_display->connector,
+							plugged);
 }
 
 static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
@@ -907,19 +900,6 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 	return 0;
 }
 
-int msm_dp_display_set_plugged_cb(struct msm_dp *msm_dp_display,
-		hdmi_codec_plugged_cb fn, struct device *codec_dev)
-{
-	bool plugged;
-
-	msm_dp_display->plugged_cb = fn;
-	msm_dp_display->codec_dev = codec_dev;
-	plugged = msm_dp_display->link_ready;
-	msm_dp_display_handle_plugged_change(msm_dp_display, plugged);
-
-	return 0;
-}
-
 /**
  * msm_dp_bridge_mode_valid - callback to determine if specified mode is valid
  * @bridge: Pointer to drm bridge structure
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index ecbc2d92f546a346ee53adcf1b060933e4f54317..cc6e2cab36e9c0b1527ff292e547cbb4d69fd95c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -7,7 +7,6 @@
 #define _DP_DISPLAY_H_
 
 #include "dp_panel.h"
-#include <sound/hdmi-codec.h>
 #include "disp/msm_disp_snapshot.h"
 
 #define DP_MAX_PIXEL_CLK_KHZ	675000
@@ -15,7 +14,6 @@
 struct msm_dp {
 	struct drm_device *drm_dev;
 	struct platform_device *pdev;
-	struct device *codec_dev;
 	struct drm_connector *connector;
 	struct drm_bridge *next_bridge;
 	bool link_ready;
@@ -25,14 +23,10 @@ struct msm_dp {
 	bool is_edp;
 	bool internal_hpd;
 
-	hdmi_codec_plugged_cb plugged_cb;
-
 	struct msm_dp_audio *msm_dp_audio;
 	bool psr_supported;
 };
 
-int msm_dp_display_set_plugged_cb(struct msm_dp *msm_dp_display,
-		hdmi_codec_plugged_cb fn, struct device *codec_dev);
 int msm_dp_display_get_modes(struct msm_dp *msm_dp_display);
 bool msm_dp_display_check_video_test(struct msm_dp *msm_dp_display);
 int msm_dp_display_get_test_bpp(struct msm_dp *msm_dp_display);
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index cca57e56c906255a315e759e85a5af5982c80e9c..838bc7d052c5cfa31572f7e23a6b1d09c4c63b5f 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -12,6 +12,7 @@
 
 #include "msm_drv.h"
 #include "msm_kms.h"
+#include "dp_audio.h"
 #include "dp_drm.h"
 
 /**
@@ -114,6 +115,9 @@ static const struct drm_bridge_funcs msm_dp_bridge_ops = {
 	.hpd_disable  = msm_dp_bridge_hpd_disable,
 	.hpd_notify   = msm_dp_bridge_hpd_notify,
 	.debugfs_init = msm_dp_bridge_debugfs_init,
+
+	.dp_audio_prepare = msm_dp_audio_prepare,
+	.dp_audio_shutdown = msm_dp_audio_shutdown,
 };
 
 static int msm_edp_bridge_atomic_check(struct drm_bridge *drm_bridge,
@@ -320,9 +324,13 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 	 */
 	if (!msm_dp_display->is_edp) {
 		bridge->ops =
+			DRM_BRIDGE_OP_DP_AUDIO |
 			DRM_BRIDGE_OP_DETECT |
 			DRM_BRIDGE_OP_HPD |
 			DRM_BRIDGE_OP_MODES;
+		bridge->hdmi_audio_dev = &msm_dp_display->pdev->dev;
+		bridge->hdmi_audio_max_i2s_playback_channels = 8;
+		bridge->hdmi_audio_dai_port = -1;
 	}
 
 	rc = devm_drm_bridge_add(dev->dev, bridge);

---
base-commit: 6ac908f24cd7ddae52c496bbc888e97ee7b033ac
change-id: 20250206-dp-hdmi-audio-15d9fdbebb9f

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


