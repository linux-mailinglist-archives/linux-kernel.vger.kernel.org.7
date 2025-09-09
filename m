Return-Path: <linux-kernel+bounces-808475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E92CAB50047
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F243B4E6273
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC7935A297;
	Tue,  9 Sep 2025 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SZw9Owat"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43696343217
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429560; cv=none; b=XnttIuZJYjVfc6Dv/8C1cuw5KMrfYBLzNTsF5WwSNBoEUBSTZ5qHRYx14G4rOsbx2pU05lyVpDb8vRnuouyXvaA+W8fyPbEZrFNEXDbGLbY69eSHw8JodYPhcmXDNoxwFCyFJZJyFEqO3FyWynO7SAAVcQu5vq73tqrQp3X5Bqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429560; c=relaxed/simple;
	bh=WvduT1qbRYo9sMATdr0cfogagyWfZym9JAGpyIFdd7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9sVUAGqQPzKcdBPRL2hkCoaRgJ1yuPQ+6lyoOCFKxWeeRKi5G/O+tU2j1s8k72vpVW94nDxSo23I5i/I5tArY/DAUPYI/8XMQeffklCZtpRKIxOV8A8OF9gVIBlnmiPZ767WZ5E9boIGmPtONT/j73EArcu2FCLk10MQ1zW/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SZw9Owat; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LRk1029799
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l9Z5uObkfX17ytwtS/hkOYbgTcwQucmA5+CIhqYDVSI=; b=SZw9Owat7M+hPDde
	VLW9jWV25LxsHJnfoY0WWEIgpl/+7gBglGj6T5phhPYTcfVZwEPc/IiBBzNeVnx8
	csnr5Bb18zMPGvmsnGRvV1vnFb49dzTsm04WcUvDxnDmHwoUB8OEdWLNqL19hvtf
	6MXOzwVHtnlyniNHCJWc6gNHXlnYtF1gbMXb8IsaZ2J4lwHDMdti12ekoSkw2DJI
	gVF82yZFmarm4vR5Y6iHgbikS3sNa17WPnLnsk8B3odF09EDzEjWXjfHNxNrQnSn
	O6X5x6KJOV/PIJHC80pZOfwoe6EFvufRqQktUI1DRaFDHmmqsFkqukgYLQ83ocib
	Ab2elA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t37w22c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:52:38 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-724ee8d2a33so121204246d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429557; x=1758034357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9Z5uObkfX17ytwtS/hkOYbgTcwQucmA5+CIhqYDVSI=;
        b=ucR6g+dvfRl9nrcRpTn1/wC5nn7iKmVS5NztN+r1GzKRe3aBp3ScqkApteRHWkpaWa
         9TsD8EqywVA1MGcRU0NSuAMdcOKjBTGeXViKN8QQ3yrtIv+0DE719msZBukvIp2Saxs1
         Sn9ZWif0X8xcuLft1RUPsYtnBi0IcnYObNiEyGpUXvDWiV+IrPc50zLN3UgluGZbsCHX
         J8YYaVVtwIUQGfbU33UaEXie7ErxLq9eNzOjQDPFKwASU44H95V19bWJRGiLBxI1yjCG
         KiK32cQhv1m2p6Us7JmWZr0ZPmVEfpePywN39tJDMkqrtshBQrBauKAWwzew515nP4Kl
         LOhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+eykZmq2ZDbghkZwZGBXnSqZbFNBX0dpWgnWGeA3W6ABBISfpFxEEQAKHqJATZLqol7+u6irj3QrAGXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfJAhaXq42OkevYU1RpjvFuPJccA17FNqe/2reivOxHJPUlrTF
	a34kucoRFn48fstWeGQhmQKOqr5M/tJAJAaNc6WpyAsBFM02kmAbHqIkAsfMGqRM6i71XXviHMJ
	KPF8InLjBgksbtGddTIpSKwrCc4JTSCNnZ6q0dtB9d/1FV85QQZnQylT/m9jnD22ACIg=
X-Gm-Gg: ASbGncv6FyNB4p9beHZG/Xqj13K0x5/HgjtMFlgdiOHttOTULuGBy2X1+C+gJ5Oca5b
	DrU+YwW6H/CrLMP6MiHoGSEgy2Q8GIfJXaf3tVzGOeyncGu3UqNLdr6HM7eYhaqTpJ+PQFtSck7
	sD69vTrt8WLs1stbMa0WhwWFi8h9SVAhWbNby+0C/9FYmgauM7j0sSJCDYwiz8Dvu3F5Rc59Y1j
	yyvHJdvUruDYTtI4iXLRoIdhZdfq6jx6l3EbssLRnGVJhfle8NxRq7S1pMKq0sV9Y6c57tpLQdR
	frC3oVHKfUO84orId7d7ArhviWGpDLOSqJTcSbbKT4UpFosNwH6oLKejDXffB2HwaANB0w4vK0G
	+ykXa7/mAwGL95H5WiFUwl/YSb1nGvqtr4+Y/ku5g8TAApEHyVUuz
X-Received: by 2002:a05:6214:4009:b0:720:4a66:d3ca with SMTP id 6a1803df08f44-73933639a08mr113606716d6.24.1757429556940;
        Tue, 09 Sep 2025 07:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPHL4NfJJ/zE5chnvOJ1HeidR9Kl8e6gYNpoM3SLwwaEavBYImkLXu+5zH8Ed3CkO98L4A0w==
X-Received: by 2002:a05:6214:4009:b0:720:4a66:d3ca with SMTP id 6a1803df08f44-73933639a08mr113606016d6.24.1757429556265;
        Tue, 09 Sep 2025 07:52:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c90eb9sm38735781fa.22.2025.09.09.07.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:52:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 17:52:08 +0300
Subject: [PATCH v4 10/10] drm/display: hdmi-audio: warn if HDMI connector
 doesn't support Audio IF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-drm-limit-infoframes-v4-10-53fd0a65a4a2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=WvduT1qbRYo9sMATdr0cfogagyWfZym9JAGpyIFdd7M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBowD8b4ByVcFhNzN6vL9g+i6Xr5Ru20ekBbEAdJ
 +90fSIYze6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaMA/GwAKCRCLPIo+Aiko
 1WdkB/42MgipULdDGBHhJLj9Rn2m9Z+xg8n2+dwVvzMmGYgpA+PltLj7B5uOaXeKjVbIhMn7eYy
 Tzms6FQKTMnjfCE/3nJUZbGUl9kN8NBaJn9uXq14HKdFTcm7/m9nN2XW/f50ds9jrb83lrS+WzG
 1d9IvcNI2kh9ls+VF2uX750NKeykqE9uqnwxU88frDB1V/0wW632N6YQOrfX47F59xl3Xx5H9Mn
 nLXDnZAAIRGfTxDehtuvZo4ncNgOzGciZR6MuZQi0E/gquRXdMuCez2EHR03zdWeJWONeOAx8KL
 XZfA2cwtxgOTNy+164ThuwnMGvRhfMoUF7t/uJwK4H8+Gh+O
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: Trr6-nfABLjFCCCqv5wBYpEnogLnqYZt
X-Proofpoint-GUID: Trr6-nfABLjFCCCqv5wBYpEnogLnqYZt
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c03f36 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=Yc4j0DFJudTMt519TXkA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX7YNF4U7RTCzw
 Ohw9eejhD8FixFT7Pp7GmUGGdpyArKeHPYyPKxIdpLxYk8Os/EUXG3oakqLrEYecPNaufDZEs2J
 q6jQElh0pfajaFAQLRzHxl1nPhKQA7mTszq3+bGksb0i/MsrBinKUrDVsko0kOS6lkJaNe5qgzk
 n3T1ldY8eq3McMUpkH7H09KDM/vKW1uzJ55C4ZS87GihLP/f0g+xKFjV+HbWygbE2BgbfsyE6Tj
 wBx9IMVuXgVBe2I63M8skWfzTJfQ73G7pBC/ny9MZ7aRl2WiavtcDKvpdumKpCCS/Awgb6Kdp3i
 uk7oqiFg+0FIeCLwb2gLqMdm7QX15ssjsqvZ3xGIJG21jHRw3ymxR2KytlwS/TO/jgGgj/ZE2aY
 pOGjIohr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

Sending Audio InfoFrames is mandatory for getting audio to work over the
HDMI link. Warn if the driver requests HDMI audio support for the HDMI
connector, but there is no support for Audio InfoFrames.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_hdmi_audio_helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
index 7d78b02c144621de528b40b1425f25e465edd1ae..35e0e79cb683a68af813344aa86c154c3a5531fe 100644
--- a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
@@ -10,6 +10,7 @@
 
 #include <drm/drm_connector.h>
 #include <drm/drm_device.h>
+#include <drm/drm_print.h>
 #include <drm/display/drm_hdmi_audio_helper.h>
 
 #include <sound/hdmi-codec.h>
@@ -178,6 +179,17 @@ int drm_connector_hdmi_audio_init(struct drm_connector *connector,
 	    !funcs->shutdown)
 		return -EINVAL;
 
+	if (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
+	    connector->connector_type == DRM_MODE_CONNECTOR_HDMIB) {
+		unsigned long supported_infoframes =
+			connector->hdmi.supported_infoframes;
+
+		if (supported_infoframes &&
+		    !(supported_infoframes & DRM_CONNECTOR_INFOFRAME_AUDIO))
+			drm_warn(connector->dev, "HDMI Audio with no support for Audio InfoFrames\n");
+	}
+
+
 	connector->hdmi_audio.funcs = funcs;
 	connector->hdmi_audio.dai_port = dai_port;
 

-- 
2.47.3


