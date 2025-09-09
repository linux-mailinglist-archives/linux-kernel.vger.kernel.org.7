Return-Path: <linux-kernel+bounces-808471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F50B5003E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E026B173B02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE86352FEC;
	Tue,  9 Sep 2025 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g7JfrdUk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFD353379
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429554; cv=none; b=OB7pPWeDa7AIMsdX4KC/Koql/iqSO5YXZ3Q+z4nMUEb7OA1dIf7cej4IdHzYXNC/9JBqNDi7ElnTv33+uBko+jvt58rwph9pQ4/R1MOz+MQ45pbbmafyi+EmqUeTLJwJd8BslRMjS9+RTy1+1lJ+O/DhSSyxGG8nwt22dnTkgAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429554; c=relaxed/simple;
	bh=IJZghCboJx+n0r036AP0jF7y3adcwBpcry6IF9spRKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oiJ2H+cpRymKKEoyP8AHm2dhlBb+XCCiPwaNSUyJlDRVVosP8ipcPHlCMGQESQQzdDQbcjeqxEsmA9SvTZsR+6uQ+7penNaENOxQk6a1HFMcdM1b6QFgRWYyBAROE+F7h+YpojZAka3rmQsHTOcgCg66I0lnsMW2Ngg75OAcens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g7JfrdUk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LWu8029852
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rn4+Wi525+F0z3MVcWKrKeV/0wAxSecqgj2MgM3DOG8=; b=g7JfrdUkeQXpz3WB
	OyCGDQ9wCTBCRS5rGQFEfBzOPiI+/p79Q2bFuHoCn5lQFzB6i4qKOOgDo8O0HqF9
	XoQd/I3lBgRDrZgY5Z7WHV3lxMUZfEJA8rZlr4/DpAjL6Ab205xe7xOQdPI4MQpc
	6VkHDPT8TPU+VHe5J90awHK/zwUMKMuubVcjQtxieSdinEL10JSq0V6kVJmbySt+
	7vtXwdUZtUnI6iQN1BTe7sNWRYGKCTI6n2NKdv8e632lyzitClUIou7e29TEgQEH
	QjcG6raauWUzdsWDvMb1oj+sUUWu2ow2pbXrQXCW4x56/6OhLCoiZW/D5NTVoMuu
	F+GMHg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t37w21h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:52:32 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7273bea8979so112092086d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429549; x=1758034349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rn4+Wi525+F0z3MVcWKrKeV/0wAxSecqgj2MgM3DOG8=;
        b=jV2FI6vDzsCRZ+pmSFNoib/4+e3mL4TBlrg6fuFFdBmaW9mzXxmuiv5e2gzEtTZoVt
         DsNPkwtnixfpkV2M2rBuS1QvoG+KUiMQFtO18i1PvFtBx5zdruXR9dof2PZItjSFvAWZ
         ZwsCxl+WsEkGxBJtK2kcMTCOd1rGAxkTSgN0VuF5jrpsH9oo5hbU969zGk/Rgb6jaoQH
         pBbdzFTOJB0O5oK3IdncIPkWY5App0PstqeGkVrW3AcqXjzvrvZ5+8O/GvN1iauEU7TE
         i6GBRoWPBf40vzr0EmeM+QforRId6W4oAJLt2Qzrefsjj8JRlbn4fDY1Lsk4LUAUTUaU
         Hsuw==
X-Forwarded-Encrypted: i=1; AJvYcCXxGszGWUVjevYOwBhkfflZzy0AvGuhAG/3FpPKE8jLIBOCXEeSc/M7L0wsfhICSjgSgzC1vY30GzRGeuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ypqTgYDC42/gTlkstiB9K0C8MygL7dv3CtNTWLgloxwh+jcv
	AGzs8Pp12QK+A/f+LOcW688FBE8Gdf6aQpKcqe5TEVqWr0hGJiJmzO6OuivytTO/qBYjwx86Pm0
	EEgf0b1UVlgD/hL2bkZK2j6+byTfo4APtwzYJg8+ljl06C6lDF5Pv/nQLGjuLEbYzmjg=
X-Gm-Gg: ASbGncv8LANuvt4tv2MOX39gvBBUrFX8X7ZSEWYo6f9GHxW2DqmKRKJIRTa7ICYHHIY
	M9TP2zWLt/9Fnv24kZFV5iujdyA+ePPJTLlWuUEPxaZZ4ADgS2hVkYaIPUfGGQqC65mftT7L3S2
	NUkU9Lbf8o3BpaVMGrKLkuQfgfp+Xfwofsl1PvQY2K7t8z0mBBNCpQ0r+tVZmJHe41dVOu62GL3
	6myOtGTCoFabD9zy8Fd+Qeua20Fs6bsRmt4S0m0ZAdYt5bX9uMwucFqewGBlCnqU/uwdrG9Hi+z
	gRnKVfkCcqKxPZmXNuK2oUBwL2Ze8mdW5nguMkzq0PusCTmz7NWxpRarH5UA8Wcne6uQT69Se4a
	0R/XRV4PrO1beVITSZssLSfiiXRHE5qcR8Eb/mM4C9Q4b88gI6oZn
X-Received: by 2002:a05:6214:20aa:b0:732:10ae:d55d with SMTP id 6a1803df08f44-73919c9e239mr146165136d6.4.1757429548918;
        Tue, 09 Sep 2025 07:52:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkZ1SyNAZOKwaZjgWGgZYNxsRKTBuelhQ+O6Fw6gKcHDoTAWyspctjVqKaotztS7CYCn5cWA==
X-Received: by 2002:a05:6214:20aa:b0:732:10ae:d55d with SMTP id 6a1803df08f44-73919c9e239mr146164046d6.4.1757429547463;
        Tue, 09 Sep 2025 07:52:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c90eb9sm38735781fa.22.2025.09.09.07.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:52:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 17:52:04 +0300
Subject: [PATCH v4 06/10] drm/msm: hdmi: declare supported infoframes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-drm-limit-infoframes-v4-6-53fd0a65a4a2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1717;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=IJZghCboJx+n0r036AP0jF7y3adcwBpcry6IF9spRKw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBowD8b8ieAgxj637Sq4ws+QM7LjLkOdE7Yn4gby
 LcXsEN9pQGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaMA/GwAKCRCLPIo+Aiko
 1SNdB/4rCLhDfybuoskGcE1VGyhQHDNRop907iuQ/KfMohI82tNkUxmqn3fcViK1Dvdys80Wyfp
 VAFYFQHBID4DL59qRb5c/LSwkwDodGdGXF6y07zpgxsnTUegD7KDvUX0gzJjwgj9tZzVv/UQOm6
 hFYKV1nXm6oA8QLpbayUSXqTlXnckkVr0Ihc4Za41VQ1aLTz8F/M2jqh+pmgwN9myyOiAZfrt8x
 2+zvee2f6gaeDcRIlcvUKZ1zM/HLgIxJ91eERe2/sZ/wV6xMCw5TMRlCArGjeIHU+4Ha9MmneeG
 bl7XeBkt3LIIaXdjnUXmsUCAPLNsip2K9VKmZWaOQh8k09Hj
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: nBhRujWRWNQyGi6cRWggh5bv8MnUGeM-
X-Proofpoint-GUID: nBhRujWRWNQyGi6cRWggh5bv8MnUGeM-
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c03f30 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=8AirrxEcAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=HI3Jv4oHZFu9xgwai2MA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=ST-jHhOKWsTCqRlWije3:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX7DaE9cMPI+Ow
 7lAIXzCWSSq7duVe2uiPQFvG6kZLRk0x6nSqG1NAkxgW9wuGOz8MvfVH4m8H7r+0QKxJ84aFeFK
 zXcqJwJa6QBIltd1nbL5XibW3v84+42bhAgg0vFOHDjXmE5B24vF9XA99NDYirTkO6uHc3zgDD7
 1Ni7I0wCp/XiqtFHi+PiAlMd7MQko5vGwLjakriATwpqBcdexnVU6zwOkM1Ggvq/wVutZaMb4Qx
 TkuzFt9h+HyVZ2MlrF3rFFANRq0+k5ysQonn2TxcGz1/ZW+Hc0IelaI8D0XvqsHJwhZ+25HjmrG
 M1zJeo436mgug2VX7zq38xY6euKjV3gXDNl6ABitjFuJtiZ4/afOWBE5JOhKpPoPaz4vEGXShSx
 UcZ0mlS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

Declare which infoframes are supported via the .hdmi_write_infoframe()
interface. Return -EOPNOTSUPP if the driver is asked to write or clear
the unsupported InfoFrame.

Reviewed-by: Liu Ying <victor.liu@nxp.com>
Acked-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 46fd58646d32fd0611192595826a3aa680bd0d02..f6ba8032904187a2f169456052b0e4cbd60ab919 100644
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
+	bridge->supported_infoframes =
+		DRM_CONNECTOR_INFOFRAME_AVI |
+		DRM_CONNECTOR_INFOFRAME_AUDIO |
+		DRM_CONNECTOR_INFOFRAME_SPD |
+		DRM_CONNECTOR_INFOFRAME_VENDOR;
 	bridge->ops = DRM_BRIDGE_OP_HPD |
 		DRM_BRIDGE_OP_DETECT |
 		DRM_BRIDGE_OP_HDMI |

-- 
2.47.3


