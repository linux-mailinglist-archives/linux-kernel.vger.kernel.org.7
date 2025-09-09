Return-Path: <linux-kernel+bounces-808473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA28B50046
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE9EA7B355E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45403568FC;
	Tue,  9 Sep 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DlhjBKE6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B3835337E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429557; cv=none; b=SGSOXVnBY9kOG+1aVHUQsto0wIntujS2Y1OoZRD3kE2n73D597h1L8Aaz3z6+jgGmILeY+/N0Wr6cEQH/X03eyyn85mSllWPaHVWmIMu1wZ7C/tu1/MGticOSaAkcWTCkYsyl02cW4jlhZV+W8RPZxfJqXxsF0jGg8GhdKzibHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429557; c=relaxed/simple;
	bh=SH5p1NXLdtPpRbZHLxmXRUJRNEhWUgJZ/FZhGKys6U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p9Jhge3ZkHDDqQijzZLLwqQA2nNOe2NcqbN88nTTRV00LI5O2QfO8ZKJGgcJJtW5eyoD3zxbxdhm6oE93wPAi+LdpJcyX5sfPXblAlwtP2ueYGjL/8nt1SvmBbiTef3ILwW3+JgFPdtxerhPlUQBykn2RgCMAUewrlC/r20tEn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DlhjBKE6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LRjv029799
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AqxjcA7v9kQUHsW1dWHX4LPd+nTqAg1ssnBO5hXevIc=; b=DlhjBKE6vXrJs7eF
	/Ui+StvzdUKZ5fYxSLyNpcJxGo+zkaXklrif3Nr7+EgoHdEfNgbCcj3VRKDSBngm
	NwGtpxq1eUc5oJyMJcVnhydxdcWM9UCv01QJWRMHrAJnWGYd+tQ3KTqQoZlCv1KO
	L3HlGgYLVuvx5i/B62w6ulRsPYaK/4BxjsXISYjXwg0T/wwdC96XrP3jptrwWy2M
	aIBLZGVh7YhQ4mQeenJdK661KOiQ4sToqjxDOZy48fj/i1bpTZ/Tb94+xt+Psdss
	oYgcc+CsvngX7nnMSzqby8cYWdZahm3SUZ/vAccW19867zrbmO9G6Xtr+IRV9tiS
	MOoJ0A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t37w21u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:52:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5fb1f057fso40404931cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429554; x=1758034354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqxjcA7v9kQUHsW1dWHX4LPd+nTqAg1ssnBO5hXevIc=;
        b=mPWglMRosrgOfMTWF3AMzl3vnQZCblG4IWlfotV6UMb35PH5esYn1q2WMKPWhtyeip
         yqbXRIcMF8eYxzOmK9tedwp3SOUc0UPW+48Marvo4x+dfGZfgusya5o/Uoxx/XOr/LNq
         GExCKPM6KYc6qJ7TercKjMSV4+eihMkOqcfO3lldPVxpgQMgSNSCa0VDZZ7F5+3OFJvD
         cNplQBaXcbKXskcNGybzmVfRs3A0oQQrHb256UulobfD7ZDWeKj8Q1BKMN+YD/P5FyLE
         ay7WataJGaNiryEUDTU03zAcRKTj6CaZBOovdclmdc70WSQDFlls5gvjCBk6/Xz0+XNL
         9a4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiOntheO66RN0Bu12LVeA6cpClPl6Q6U0cosmqK1hIhMT8iAqYRdhS2GwXsH3McaxdipRHi6S54AKjuco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5fhUT5477SH3uwvE8ij+mKxscctcI9EpLNfyxq1UfP9eF9hHD
	A4bZ9KgyAGxRnqB/DM1TK5Drz1OpfyhbGl4qD9PggvHiLJLs4xfZaomRzcvb+AgO6SYL+Rgd1tt
	Ot/ZgVwwDHJHvareB7aKAaAfDorsn0JCuVfA0iqzarJKW0cYq5tOhjILlg6AcfdEUS7M=
X-Gm-Gg: ASbGncuxiFfrdTNio7C7CEO0X/E3LjaaDN5+ywW6MSREqy/P81jOlyTw7l9h/BTWo4k
	dbYnxL6CyjpDomuYBjX4UhH6IpD/2AdwYD0bL86dn3hu3VEUUdvtSTmPpDlxEJUiUEiXRCXsP4j
	JvCgTCg2whanA8uDWMP7KPmpGg6sf+M1g+5TfCrb8JV5agh1zX1Wbm3tf56ZxUsKz6SG1kkhdXn
	gnjbqlK447iNPFdfxAF2l2qvVnOvl+316/KDrHl8Yh80B8ZaBpJNJ+yEVwostEugPbfH7D2tjHQ
	nW4g73POFssP/AS9+ZWdlIjZiy68nRkFj99OuI10SCvPY+aPTwCAn6OCGaplJGwVGumppvVULpM
	alx1iNlR0+o1O/OMZcRKn4Vk+ZeYRy3926G3/++x1takPzbQvzNLA
X-Received: by 2002:a05:6214:21e9:b0:709:cf54:2cb6 with SMTP id 6a1803df08f44-73924e24079mr131513966d6.16.1757429554138;
        Tue, 09 Sep 2025 07:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELvHh+YLlPgh4Yd5dwaizGOKRDtwIRu4dOckQfLSj453ZKMPo3ZARJmUDs6l5WC0UTNyT2YA==
X-Received: by 2002:a05:6214:21e9:b0:709:cf54:2cb6 with SMTP id 6a1803df08f44-73924e24079mr131513396d6.16.1757429553493;
        Tue, 09 Sep 2025 07:52:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c90eb9sm38735781fa.22.2025.09.09.07.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:52:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 17:52:06 +0300
Subject: [PATCH v4 08/10] drm/display: bridge_connector: drop default list
 for HDMI Infoframes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-drm-limit-infoframes-v4-8-53fd0a65a4a2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=SH5p1NXLdtPpRbZHLxmXRUJRNEhWUgJZ/FZhGKys6U8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBowD8blvrwI5L8dQHSUz/xZ6GHVeuDdbZGULZMV
 WuEhl8+3y6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaMA/GwAKCRCLPIo+Aiko
 1TrPB/4iqW/Wm2SYljGHlxILyUx1w3ArHNHCeDStNLT25ZG6XUwvH3rLYMRzQQCcX3XYeP9w7/n
 br7LaRGkE7OOakFZ28SR+/IG8O9407EpzXyWAjNajt3AwRuXMI1ceXUB70WoQYyiQ2p86sx2sD8
 rk96tIGNTj+Qk3LLtNOfFhhU2mKk8vZ+7IJmun34/LLVdMgr6WGEYUI0HHvcXsWauvVUd9QcMXW
 48EwXLxeCxs4iM+SI02SHlOAp3svBZc/AL4f0u89V/Pxi6cQuvVzavQ1SrBcuQHP8kYGG5WVMlS
 yLTVNPBw8cDByk+YH6FlumiErNCqzW648OHti/7E+XtKyrw6
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: sZQglFD4zmFBuwFV-GDNyQak9i260fES
X-Proofpoint-GUID: sZQglFD4zmFBuwFV-GDNyQak9i260fES
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c03f33 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=8AirrxEcAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=uJ1-o3tuYwvhD5ZCdfEA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=ST-jHhOKWsTCqRlWije3:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX2tEwnjVTlk7I
 vQxQZUyknMyYSVm7rP5l0wWm/5plLYiKS5rkT7unuJ5E9WlF2RggHQ5uFz1dP/eO0P9+j3A45gh
 /2DYeN83xQ2Heth7mVS3XMZK3y/830U3IFdKw0HSjObwPeWg2MYyd972cLmsYG+M49ZmLqG5Nz4
 rDSyPAGWp7t/RI0nSpSSGcdnmZfzbHOGrGPhOGqdxd9zdPkDhnTwHn+V0F+7PQkd3jjORGtlMKw
 UFGBIAiErvrMVVnAvYdkGfJKSL5ADxPVoRD3cNmQ8M19h5F4hMTJWsD0/9C59XSeCUbTF77FrsW
 7KQXRiMc6P3v100zlCeJ7dZoLo+8aX10qmc/xEyCLh5YpLEoiZ3zdavYuoxhDrAH22WnQwiQI2j
 RdvInIed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

Now as all bridges are updated to list supported HDMI InfoFrames, drop
the default value from drm_bridge_connector_init(). All HDMI bridges now
have to declare all supported InfoFrames.

Reviewed-by: Liu Ying <victor.liu@nxp.com>
Acked-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 55bf5ac53739fda098be69a5c61e4934704ce046..05dc2b61643af5316df431a3cbf53b86139a63e9 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -783,12 +783,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 					       &drm_bridge_connector_hdmi_funcs,
 					       connector_type, ddc,
 					       supported_formats,
-					       bridge->supported_infoframes ? |
-					       DRM_CONNECTOR_INFOFRAME_AUDIO |
-					       DRM_CONNECTOR_INFOFRAME_AVI |
-					       DRM_CONNECTOR_INFOFRAME_DRM |
-					       DRM_CONNECTOR_INFOFRAME_SPD |
-					       DRM_CONNECTOR_INFOFRAME_VENDOR,
+					       bridge->supported_infoframes,
 					       max_bpc);
 		if (ret)
 			return ERR_PTR(ret);

-- 
2.47.3


