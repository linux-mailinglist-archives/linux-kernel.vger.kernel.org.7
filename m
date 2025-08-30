Return-Path: <linux-kernel+bounces-792591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13CAB3C647
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D353A9639
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DD21F37C5;
	Sat, 30 Aug 2025 00:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gTwPRJSr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482C7194C86
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756513404; cv=none; b=dd0UZ4aPrbux5Cp4Z7PWs7Ne7dWecVoKpw0Njacf1CK2bmQwlXV9THVSRIiTPglww8LjCf5poJlrJQPWqJMwX6hb0BzQCdlZiL4DUJmsrbV1yTcB6NVMMFxESiqtjdb2FIpbN1+mK5SHObgoHD5K3yOUcGqtoyHUYZA6013pp58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756513404; c=relaxed/simple;
	bh=TXVbDyYy47gcECct8bi3FdzY5XC0C+uBNPghEtpGc6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EAD5AjeOkLkaYT4sWuNYkA5t8eQ72x6eUDBLGxjf1SKp0LQqyEYHctucsFpXN3X1bRyEN/SrkyEbTat2hXntWX+RXiWoCSv6v1pPgsdKeZ2+4/nGpd+eC8MiMcSBEUr5HzctHzjUfNWlNZmKzZ0ncZNoA1P9lCJuQTU7y5pRe2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gTwPRJSr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57U08ifr012964
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P+gLmc6QIq1Gqbex22CG8o5k/mKnyADqk7w+J2c1oKo=; b=gTwPRJSrfbEm9ova
	UWH2HD2Kunhls692qcidzYuT+0FPL1Hut7Izk4SNYhYxkwYj+GAHqbn/DMOk6rHY
	K2ZaKRaLERT6IcpHP34r8q0BbJw8klmUbV9uoO1L1ZZQEgBQFIfFHz/AlF6S3Ljn
	O6kLlLkctUIDiz4vNXtDCk3LwN/z7sEDlkuRByJK2ty+F57Ab2me3DuDjoj4M47b
	3bFE8n63VRAjlacoruEGPR8gp4J42cRdkxk5f42RZXTBG/Y4PT+f6D7Tlr82DGlZ
	pOn/CG7TpV2vmKKK9PREYNtSi+ng+KFlag5FB2GhgKaJwBh+RxiljE10+FXiTSmE
	Z6mMtA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615w3tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:21 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70dd6d25947so56295786d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756513400; x=1757118200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+gLmc6QIq1Gqbex22CG8o5k/mKnyADqk7w+J2c1oKo=;
        b=IL1x3/HLojH92JvaAJyHRIie+peMjtTaec1wcqbv7XoK5/zwQ1PdcksuE2cqVrlSej
         /q7aOpKM2oD1tkAG4qKl5cvWGp8mPN3mSHBEXO6JahTwPD2pAM4fht3JprDNTUQINbLd
         HsOAn8MRba2xPU/+DIKNNeF0PJiSUH5rVg0oSk8p4kqNbDRbr0S1t5STENjvK/QoizHT
         0b+naBrCWcz+CfABWQLB577fC+w1I2bwQYO9+ekyvMcM7PJ3KIhGn3ZFmX+PQQI6Fiky
         fWdX+I5XzDXnZT9RRrVdNsnrSZco5BB7V7Hwi3vIdhi48QytiBqoUlncZW/U4epcAqzz
         qeIA==
X-Forwarded-Encrypted: i=1; AJvYcCX3JQcWWZTB4Y35IzQys8LADDt+86PuUnn8EJhcj+xhUagc8+TT+oSMXmJbcFHpVUhiMIZF3vC6eKSdeqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbqE4XvseofPRVk8LGvRCx6N5f7gLNp5kESBQahYZV2OK2inGH
	NGZwlXXQmqo5snate7zkqNNw3FiMZLRrDS7PFEvr4E328cF3lnYnvAZqvp30wd65HUIpuYDcDti
	p6p01K9N/mgWevnFn2KsUz/7RNJnnezePhO/mnAZqeThVHnhGtjSRCXlbQJ2Bp6/znI8=
X-Gm-Gg: ASbGncsG8GvCIUhgntRqrtOtTgBxE4DfeaAWBtr7E9wjXq4vsyTSkWI6hTXxKDA3xSt
	/A4mQgdgzNLuEJO6rEdpuaNuJeFhfD3dG2ewBC331Ksu8JZEfaE/4jWZhzIuFXkStRFNGKNq5uJ
	340iU4l3/MGZbt4jpDHlFv4gAts0fiSVlojsZ8Vhfn8BEYdEnAE5UJ/xpFHz/Rj6xjLSvoo/Spj
	N8uvjG4j+5j8zxyBLs/IwoKOgXxv6AedB8MoNBKdUxiZHvqAvxUm7AIBw2ewO3W6yfz9wBhq/qW
	2MHobVeyiYUt2iWWqcGTz5d5hYC7kUwTP3movQih6h/keYhPa2VnhdNu+PDHGvPnZrgyHK51VG6
	/Gyu9uYOUhtkIW42qJI1rw2HT28TnpHbpUv25CamlIbQsvz2Ymb03
X-Received: by 2002:a05:622a:98b:b0:4b2:8ac5:2588 with SMTP id d75a77b69052e-4b31dceda5fmr5331751cf.79.1756513400253;
        Fri, 29 Aug 2025 17:23:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiRVPCy1ZyvNRY0SxkmPtK5TdJ45H/D+mdd/nazOG8FE/zTJi/BBm8Fy800I1NQMGrZsr0qA==
X-Received: by 2002:a05:622a:98b:b0:4b2:8ac5:2588 with SMTP id d75a77b69052e-4b31dceda5fmr5331431cf.79.1756513399780;
        Fri, 29 Aug 2025 17:23:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f676dc52esm1019907e87.8.2025.08.29.17.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 17:23:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 30 Aug 2025 03:23:05 +0300
Subject: [PATCH v3 09/11] drm/connector: verify that HDMI connectors
 support necessary InfoFrames
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-drm-limit-infoframes-v3-9-32fcbec4634e@oss.qualcomm.com>
References: <20250830-drm-limit-infoframes-v3-0-32fcbec4634e@oss.qualcomm.com>
In-Reply-To: <20250830-drm-limit-infoframes-v3-0-32fcbec4634e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1517;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=TXVbDyYy47gcECct8bi3FdzY5XC0C+uBNPghEtpGc6w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoskRkOHE4fVow7vDWOUvmc/2iUcbcfIOqvZ6C2
 Dchv4veASeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLJEZAAKCRCLPIo+Aiko
 1YnWB/9HjDIWWBFOTM8HXaStc63uIk6SmVdJldXZsyniEFqPA35U6pxTvz22fY4ZqbvckumzrhR
 VzHrK4EaLNdvGVvpvzCqVg+lao3Ze8t/g8dHlSQUGz4uDNF9caS3kvpyqdRe/6MHFM1r3HC0Du+
 GKwPnh9RgBqznt7b/zoa44AB9KtgP/9LMftD22mQowgMWto5XI1N0Y4cPb6TL3PBmJkmQSvi63B
 fiTBoU6l5res5/vH2RuIug1cMVng+2t8eompix5jbFUnr3t9cm2f4SNOuTUVo6JZpap7J265oE5
 IBWsjZfpSptNolCOsELssC0lCC2aPYXd5tjx6jp63ntEd2vd
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfXzJav653l6h4F
 faRa/dXzcb35ox264sPjX1unKBrYdeymS+RlyOSSj3k9VPodJeshtNkCarnTScQojyLWt5rzdl0
 OZNVY9CkoXsP7qQybugz1Fgj0rdobk9CM8mUJ+OmKCpCIiUDtmvh7GM38iZQ9iXuoa+rYPCM1Mw
 AaMc033DDwz4cdurs2gAetlEvuSY1U4Y2tkcyNxuC7XUPVzB37I025hWK4t1a2/wIPxaE2Iye54
 +9FzMdYEmE4S0uuiSKZ49+ZxbNPNiSSmufZi4Y6iK1MeqEtOXgSz9uukuaRmECD6oQxBvAItE4q
 LnBYdVY6LHkAt77soaiNxLeGUDfmC1G0DdgmleVCZsmJwQ9GMlqDvyhB3euc9rURIsqi+F/KqHN
 AhnvdIYN
X-Proofpoint-GUID: 97JRdmcQXt_klcq43JuktYt8LNI7vE_y
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68b24479 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NnPSNIktjdB4Ge1gQTIA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: 97JRdmcQXt_klcq43JuktYt8LNI7vE_y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

Check that connector initialized by drmm_connector_hdmi_init() supports
AVI InfoFrames and warn if it doesn't support Vendor-Specific
InfofRames (HDMI InfoFrames are more or less required).

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_connector.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index f031e8f8df57da15bb0f8fe21fd62f02a1576ebe..12ee06bad364183ad56a20b2bf9860491913a295 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -582,6 +582,7 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 			     unsigned long autogenerated_infoframes,
 			     unsigned int max_bpc)
 {
+	unsigned long supported_infoframes;
 	int ret;
 
 	if (!vendor || !product)
@@ -604,6 +605,15 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	if (!(max_bpc == 8 || max_bpc == 10 || max_bpc == 12))
 		return -EINVAL;
 
+	supported_infoframes = software_infoframes | autogenerated_infoframes;
+
+	/* AVI is required */
+	if (!(supported_infoframes & DRM_CONNECTOR_INFOFRAME_AVI))
+		return -EINVAL;
+
+	if (!(supported_infoframes & DRM_CONNECTOR_INFOFRAME_VENDOR))
+		drm_info(dev, "HDMI conneector with no support for Vendor-Specific InfoFrame\n");
+
 	ret = drmm_connector_init(dev, connector, funcs, connector_type, ddc);
 	if (ret)
 		return ret;

-- 
2.47.2


