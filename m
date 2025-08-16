Return-Path: <linux-kernel+bounces-772014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2478B28DDC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03027AC3CCD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABDA2E2DCD;
	Sat, 16 Aug 2025 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jqLHGpE0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4152E5D2E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755348081; cv=none; b=Ze6dLcmG+5+B4ArWRdt9EmfneTwpfJRA3mx5VjVqXP90aC41kFyvHUnSX3ZPKgqFbAmW94pkMB745Rhvppj7fam2tuysiCFPcW/CnLxH5rSxXcLBT533NupKBUAR9YQlHVh+ndnwq+592c3hr1qmO0JpnwQo1vQQ69zHzZeaIOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755348081; c=relaxed/simple;
	bh=7pF6L0JAujP/P/iu+e8rZjaaHJekyZiCiogkcTbsoPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kBmnpE8VDeX1plrLEebMUQyWzWI/203SaBcyuEtE7lynjuk4/XmN1xFky4FGkPvvsNdeiSYC46mpiTR/+bMWxX78dY7CQXjgl673NbK6j8Tdp9NV7XY+GrxHzlaLWshzY2R3sx4csJO6OKVLqEifIfy/p9RLeLmx0PDkLHNZNcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jqLHGpE0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G3jdpv024981
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XTXVZvn8yUTRjhlUwhGxkNee4aGkCZL4GH6QswhQXtc=; b=jqLHGpE0SrHzaNJq
	HvY2s9Lj//kd9ayUo5T8OPj3AhPzFYl9txS7IMbRPU6RzZqt7+fOMKaxzl4F0JL3
	Md4gtCfPBc9J/5TRiTPEEM+9mGTQrg/qRYFui3MXwYXZxi3zPK8yoYlCfZb1HEbg
	XtlcCpSqyIK9ffm6ojJhBnZ5mo5CX+YsJNiTP83oDfa0EJQ+gkujL1jHhB/KvTFB
	0+vgn93l7RW6eJDlAObxdXaXQcIRrCfblub6BEsh4qUsvOUhlSJl702OXvDC8O4z
	15EzQytH+vqquTtxAYCXYM/iv1pXpBhw7joL77Ui1p9iv2lFToHf+0EgAxEhtHNA
	+ErGiw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjc7rm21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 12:41:18 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a88ddec70so26697636d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 05:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755348077; x=1755952877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTXVZvn8yUTRjhlUwhGxkNee4aGkCZL4GH6QswhQXtc=;
        b=O7I4LxPlGSKqM/XbDjqG1ZugsEZtcP0Af8NZ75usrspvwRzTrl5CADptBG95s2jFh9
         WphbUvoojhJT8dIa2laKdYZYnWKoQvAH6P1g9NmsXDVoz44ak+asMXzkFJ5IQllGBXH7
         ubn9U+Df1N99yNHyYGMpvRD7xqt2UVMXHm+ttplkd9FnNAocHlVLG9u3Zs02dTY0Yuq9
         IIsBY5JMTN5Ov0d0OHWJ5bMft6h64WNJJOle7M0tO0MQr3HZORuggDdwUe2aFg7/GSxA
         4yG33nwIpu5x24p7YVEiMVvXXXyliEMoh4T97TDTK21DPHtNjnDSZ5g4Ohz/M3u1wlsQ
         vnYw==
X-Forwarded-Encrypted: i=1; AJvYcCXj/fA0OFg4TQDim5mADIUz+I2wvTZ3/OAWliLY6y+QpyHgT43R3BAuueoueiGybPe0RL/8pA6QvR+9Bh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPdDjGkZ3blASj/OiCTyQUnWpwUukM6o2H5yBhtPBmL/Nxium
	oknLotEHLXK2p9fqFiebC6EHk3qyc0rN2QjWJYFk9st8loxIBNM4PyUrV75+QMgYuf/cYX/+eIb
	sxXoMXOcXtSlX/XmJ9ApF4wkCDyqWNzEGUtAKxNZ/k61rz5VsFQfDZkCfbhQmZkBW6Ws=
X-Gm-Gg: ASbGnctfs2SkyhmK0IhU+0j2GUtBkZur2JCFt1G3dPhSpbC7XG43gF8oVWgY2vnQYNE
	39eNZOaHTIgYUWempJ7L8idpv3OG6yxljXdHIgf4BLtzNW5aPIkigHRCRnE2AvsTBjaxFpqYNTR
	Uoucq3/kvZeuGOUrsiTV9RAeCY6lE4ltNQ1XyN4IJNXPTJ/mChJNsX+oe5yu/MCvgoNcd0SvpI9
	NtAt06pFk/pFMMj4BhgQfIAgxevEKt0gw2bX5dWmXSV2KMK3nmvMkWgt8dNCUuLUJNjhwz9GGfe
	Q8dw4/i+wYMPTn6PwxL5M3qRLzcpHb4Ver6nrm3m2ESSFFIiRxu9n6kkr5vFygIGSshV9z/yc0W
	6Mbs/Cd6kilewgj87lNRjFmGD3YKNH10cpUo2Y3/3PKjMAd3TFspB
X-Received: by 2002:a05:6214:c43:b0:70b:a22f:cbe5 with SMTP id 6a1803df08f44-70ba7ae7e3bmr68367136d6.11.1755348077599;
        Sat, 16 Aug 2025 05:41:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKYA0jwLaGI60dgIdc5xLLC6MrgAPeHvs5XeZskw9tq2JN3MW49DplYWInTes5Xz+UumyLaw==
X-Received: by 2002:a05:6214:c43:b0:70b:a22f:cbe5 with SMTP id 6a1803df08f44-70ba7ae7e3bmr68366726d6.11.1755348077082;
        Sat, 16 Aug 2025 05:41:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cca21sm856554e87.104.2025.08.16.05.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 05:41:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 16 Aug 2025 15:41:06 +0300
Subject: [PATCH 6/7] drm/msm: hdmi: declare supported infoframes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-drm-limit-infoframes-v1-6-6dc17d5f07e9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=980;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7pF6L0JAujP/P/iu+e8rZjaaHJekyZiCiogkcTbsoPg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBooHxffZfdznR46omAz//o0FIm9ItgOJjoSW5dR
 tFCoAWaxwaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKB8XwAKCRCLPIo+Aiko
 1SJzB/9MbWkK1MsjNZOw3lcgrUqwdBEMotBk7PI88jIMb49m3q6pi1Ic+1OcZvMxbYHJ5ytFdOB
 99dkv7TMYuHpQwf5giIywYfwW0VuZrDAcFtTbCfvYKHASIQirPoDKIEhTcdtUUOtb2/ESl2OGr3
 yx1San5Qryx+TcnSV2oMfEjDBWqbisypv5F1qp6+85hJmN+eLfDeUNpy9whi3ZoY68pGFz7lzsi
 oCs8KusSv648XcZU8I8UwAZJVJBCPgNenSw72lah8u8Xd/o+1ZjHr39EmwY5SvvgFZNkRmzZSBy
 H/EjRxLrBHRVWid9aiI3/8ORFSsfpCh8JNlsgRLNo2FEBcrx
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX/9XtbxvnH/6M
 /HHMta1Rt7jOe+aov910/Z+tN695paAy8Tz7mmW4gcfQkbk/J/R60rrdvONSE7zVwBF98jvKiY8
 xmuhOYoOS7eTn4CKiCY1+nWyJbYsnJOXhCnVRT6XoVxCo0BLw68eOkA+NrdfEJaF8CY830hKT4g
 u83PGdvLhKnwpOyPT9F7lEbqlKSbYCL1f88iv3OdIKFIy/nZCjNSAMbarwklyHE1GPXbPZpJRpO
 +WgGf7nZIP794dHPaN8RaeLYVy8oHOCRpEEDUfew8t+jliOLzjP/0e9Ke+ug4QFLuXMw6wonkki
 360pf/UfOZMi/rKvnpLn4W1g41Sq1HuPAFelNpCmdoaUTg2Kuxj1+yWUnrILpgkWkyY9/d71ErP
 M5BUEw5W
X-Authority-Analysis: v=2.4 cv=c4mrQQ9l c=1 sm=1 tr=0 ts=68a07c6e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=gXnERKRtccFGBIMzwWQA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 6WtMEAMWQjWMPshLWCyCZ5NQK5N1kiXQ
X-Proofpoint-ORIG-GUID: 6WtMEAMWQjWMPshLWCyCZ5NQK5N1kiXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160033

Declare which infoframes are supported via the .hdmi_write_infoframe()
interface.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 46fd58646d32fd0611192595826a3aa680bd0d02..aa36d203f38f0f5a197afa8493fafb20cdc43476 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -498,6 +498,10 @@ int msm_hdmi_bridge_init(struct hdmi *hdmi)
 	bridge->type = DRM_MODE_CONNECTOR_HDMIA;
 	bridge->vendor = "Qualcomm";
 	bridge->product = "Snapdragon";
+	bridge->supported_infoframes = DRM_CONNECTOR_INFOFRAME_AVI |
+		DRM_CONNECTOR_INFOFRAME_AUDIO |
+		DRM_CONNECTOR_INFOFRAME_SPD |
+		DRM_CONNECTOR_INFOFRAME_VENDOR;
 	bridge->ops = DRM_BRIDGE_OP_HPD |
 		DRM_BRIDGE_OP_DETECT |
 		DRM_BRIDGE_OP_HDMI |

-- 
2.47.2


