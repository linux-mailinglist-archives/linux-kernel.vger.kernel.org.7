Return-Path: <linux-kernel+bounces-792588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CF2B3C63F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799891CC14D8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC62D1D5CDE;
	Sat, 30 Aug 2025 00:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D7uh6kBb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BE31A3167
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756513398; cv=none; b=uq4Q5duWUowtQnmly7qnCcVn6hpudZVF/6aHVmexhy6/73s4hW3Dqm2bNQwMdJnI/z+3E8MFt01d9AOqWd0+098O0tHaZCBKAzOoCrbpcpLHtTZooC6MakanojUTOAPXs0JisJexXIIU9DRh6+OxDt1dYkvCG7hBFIDAXBKh0PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756513398; c=relaxed/simple;
	bh=ECUd39xCRDayMF07yZPid7frZVCtdwJ1DNCpnou818A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2uQWvaz3jmC9bq9cRcpy1MCAufx+SLPhFeL7GAgie3v1HoCv9TKEiUvOC/x2xrOJP5mHDwkEoKppWN8OTx+MhymMZK2UJBF+QQFuMyHMcX1SJ/iizgurQQwnqScqaaYQa63KLv4KaUpgj4ocAbAPRDR63vuf2NdxTM/CPH5JCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D7uh6kBb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TKSl6G001185
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7nf0+abWmGCJST77+Ob/lOwCJuYhA6HECShYvSo7oZM=; b=D7uh6kBbblxZW9vJ
	AQO8arjsTAUfNxLenI3aVXaXtb+11BbgrmB1CsxpHrPwQdS43XAwfzIrKq+kezth
	j0GQ7nGhM7SpUqwR2cPX+XWfVbC24Ib5B7YwoYmATkzJY4gh8J1rwzi3aFyH9Ix+
	tAJCELg4AuWIOal/7AXKBIFsw1i4bmBWQMFMxyji7h6Ae+XVjBEjjf29BpO64YmQ
	6Wxm2TSFNric0wtJAfepyQebNkRovHAZTKwmgsL8J3FPhz7g9m5WwjFRN1Y+peAo
	YCMJZg046hFPxkrKymnymtVULik4qmEuSipYKoKOjpZlJYnHLEzCUmqqjwjldwBz
	WVeqDA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5umna63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b2f7851326so70909811cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756513395; x=1757118195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nf0+abWmGCJST77+Ob/lOwCJuYhA6HECShYvSo7oZM=;
        b=g3aq5o0jWGOQvGybxfEOV+E2Sa1nx7mQGQoHJDQEwKW9/EqhOOuK5mzl0xgMn8NDYE
         pP6xBaYVJXFJaI03dTI3TSyQICJSbUzv2LJg/hbYeLwif0cN5e5aQLNPx2KfeSYxQsB0
         fNER3xcuBsWtuPKpsBPFY/eNLg3nLwY2mbQGr9iFkyLHfKpnBiq0kEK5+Njg8BAe53CL
         J4TrfDuYdxq+9sfwuga0fNR33nM5bAilkxk3/HTQYVnuG9vd1QwbP9JfSjbskKNj/aXf
         1hzsJbGd7UErhoeiOo19UiBeoofyiFawFT9zzydVO+0bm6YvuH/l6httMzyCzXlmk5i4
         wiSg==
X-Forwarded-Encrypted: i=1; AJvYcCXRoCDRS6czWE/w0c5k5DHxZy4PqwaOkrUExCRFHjKijsRJg8HxOZimAWQAE9VOklpRDAch9lX18q/dz0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzJYse6etGnkc8HyP/s1hjcY03Zppij4YHLRJSW/hvFXVHMnpZ
	/9tUhXxMlXPIIwAkmHeVCnM7IBKp9dVzlpXBE+s5peBBPXUAeCKDRfSe6AOwmB0JRhifp2MzMbs
	FS4bwVZ7YWwd6+l9cIIxuKsBh8a+U9AeHi3ucuJcHPBxPDoLTxVZUJdNWx/y5UYZObs8=
X-Gm-Gg: ASbGncsiDBU1s0h2NTh4RmZvwaSHFsee/HljO4UGfn1yh2ZUmXbYMx014lvQ1SX2Xxv
	9mNMwJk1lpa2QkflTBz0ICtYwfEpGxPjJON2IO0at9nBsg0zJ4Pn88qB/tTuVj6m6MSDdNZ0vlQ
	HzloeON1b4clvWsafUPhLmHgAyx7vvlC/rryt/h2zYu6VwX/o9f+EQc9lRFV05KQkQ/zYDrGstJ
	uVQXmL8gpX80c0ApA3W4dblHF9WSPnbSyqjeIQmIjjeJCHZ8PDoqkN9pDdO1Fni2UXIB1m9K9Ux
	iMGUsDT2oO7POfaKzDOg9IL3Erb6OQpM5xuszhcZuhdyPgT8nWZcQVoFtHva+7Ju625DG2AVHca
	+jevVkBoQJc1n/jHwOdfzmifjaGGxUJErmZa0mleBfNVN97/4wvVg
X-Received: by 2002:ac8:5893:0:b0:4b2:967f:cb4b with SMTP id d75a77b69052e-4b31dcce3aemr6287661cf.63.1756513395168;
        Fri, 29 Aug 2025 17:23:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOls7IHK5n71gLOims9R5oXNm30OZQlHiNW3nK6iLa1qZum2ksrrXODlblb3ZuRNvP5SOgkg==
X-Received: by 2002:ac8:5893:0:b0:4b2:967f:cb4b with SMTP id d75a77b69052e-4b31dcce3aemr6287201cf.63.1756513394655;
        Fri, 29 Aug 2025 17:23:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f676dc52esm1019907e87.8.2025.08.29.17.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 17:23:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 30 Aug 2025 03:23:02 +0300
Subject: [PATCH v3 06/11] drm/msm: hdmi: declare supported infoframes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-drm-limit-infoframes-v3-6-32fcbec4634e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ECUd39xCRDayMF07yZPid7frZVCtdwJ1DNCpnou818A=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoskRkadcPsIT5VtZsPUIxt4c7DuFRHVG0R9qPC
 e+hnmDKZ1qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLJEZAAKCRCLPIo+Aiko
 1XJoB/9uSIvkAkBHEdynP5Np4TmqF25QxdIHnyZDZRd2oMA6beg+0p2vmu4j8T7iBPLH6wuOfv6
 yuy3KGzqXY92I/wemcHThKBJhM3F9irEXV+pLwba1BFZ1tX4k9erRi846J49Ao7zWeEP/xfmaPz
 81ispd03TPnsUvWwua6/x85ON05f4ECTHRc4+QUmjqTUB5Do+4aS6kfHip8DmrVdpbiYpQEZcDY
 dyZgO9lEnPsSGc+YkPsQmyKeuNdrMSHxmoExrCm2VBYq9CaceiwABEYUbvXFk4YlFDv3aa3E0R6
 LB4x461C04PK5YUvWfKCdrT6vT5Mwb5jFjWe5xU7iIbWVh5W
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=VtIjA/2n c=1 sm=1 tr=0 ts=68b24474 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=QemjF6U71Mh5n78GOpwA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX+C8WE/Fje6dY
 rdpf8MBPjOXHJ88KoGtZg+M3OvTABAfIe7pMgnxbskrYqiq8lMxqHuCDGgh16KYmkDa23H8AQtb
 lMy5aTj8MQQpy+WxqqCf0iAIuhIboSp0YfrjNxzFeWTFLO2cXoXcxwIDCkJqLsUe0nxHm6yIlsp
 rwIX5G/gm9awuX5TLO+ZvukgQNTpKqpMGbWDHAKUCN1Eze8bGIA/aUP/EElMQetVuj/2BLiY8HN
 RQclzA0HV4GrOH7ykG1JGqBzpFwVZZy4SBuSZcwRaKn1vm+5bYsruIVyicW6dZexF6mTXbQLnfR
 eQpUs5sSZraoG4vqhy37TjADXE7crzwCOWdQvJOwfcLtpAzsKNNI6HdsgPI0WlTKhtD5w3o/YRy
 6YPHNMwj
X-Proofpoint-GUID: SXHVE8iyKMKpIjNw57MsRx00vTt1P6TM
X-Proofpoint-ORIG-GUID: SXHVE8iyKMKpIjNw57MsRx00vTt1P6TM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032

Declare which infoframes are supported via the .hdmi_write_infoframe()
interface.

Reviewed-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 46fd58646d32fd0611192595826a3aa680bd0d02..9dddc0e47de462212d42f3ff1012a073b98e3a96 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -249,6 +249,7 @@ static int msm_hdmi_bridge_clear_infoframe(struct drm_bridge *bridge,
 
 	default:
 		drm_dbg_driver(hdmi_bridge->base.dev, "Unsupported infoframe type %x\n", type);
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -274,7 +275,7 @@ static int msm_hdmi_bridge_write_infoframe(struct drm_bridge *bridge,
 		return msm_hdmi_config_hdmi_infoframe(hdmi, buffer, len);
 	default:
 		drm_dbg_driver(hdmi_bridge->base.dev, "Unsupported infoframe type %x\n", type);
-		return 0;
+		return -EOPNOTSUPP;
 	}
 }
 
@@ -498,6 +499,11 @@ int msm_hdmi_bridge_init(struct hdmi *hdmi)
 	bridge->type = DRM_MODE_CONNECTOR_HDMIA;
 	bridge->vendor = "Qualcomm";
 	bridge->product = "Snapdragon";
+	bridge->software_infoframes =
+		DRM_CONNECTOR_INFOFRAME_AVI |
+		DRM_CONNECTOR_INFOFRAME_AUDIO |
+		DRM_CONNECTOR_INFOFRAME_SPD |
+		DRM_CONNECTOR_INFOFRAME_VENDOR;
 	bridge->ops = DRM_BRIDGE_OP_HPD |
 		DRM_BRIDGE_OP_DETECT |
 		DRM_BRIDGE_OP_HDMI |

-- 
2.47.2


