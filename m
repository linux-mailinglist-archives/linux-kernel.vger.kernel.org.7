Return-Path: <linux-kernel+bounces-792590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F00EB3C645
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B28624E195F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A3686331;
	Sat, 30 Aug 2025 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IXnoLFe3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917E1D86DC
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756513402; cv=none; b=hYHledUrFVy/+Ah0pqHFPiLJ2E1qt9jHgpyrMmnX6FY9jDuiBKM8r8nMeyH9M0oKKgPcETQztz613Y6Aspr2JAeZkuoCfbPSLC01/hBM5x9bpZshy+jErklQQWvlwxaa7e813CuIttVXFoKJoY15xb6OuLzSr7vb7Awu92Rj2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756513402; c=relaxed/simple;
	bh=cd27TNKmPZcfQJ3UKiBSlNuQpycc1+LIV7BQ0LEWwY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sgdl3jUdxmw9+zIn+z1EwU38A/I7yY9xzfZmo5hJiC2JnB0mM2zy/abjaxukZlQS498EQZ7vsZMbWIPPxvJSLDTNXjBRLlniGRZUAc0C8K1hYyUWwUmcGmgy2vvJpAJYPg0Wp6fAQHnoD+2X7/hgRN/Co5JQyyYlJyC5HYiTETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IXnoLFe3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57U08ifo012964
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1AqNK0JvpkzUHYLdcGKR1RHF7N4CzTcthmQAulAujD0=; b=IXnoLFe3Mnw7FJ/3
	m28CaZTdvpwEbp6SY8hiWZu3PDM2KVfemXtqbZ9pWZ0QONyNOwQP7Pq8C9wXiQZ8
	9KIhHSY8UONnU8T2SV4IkXofTvDtgFwha/05lBNGensz56A4oTPBbThlXO61ZH36
	zQmiYcnMRsY6j2IdQPwmkTkiL8r6bV8SxKvm3ekrYrf/ic+4iIC/CSx4EzraZnq2
	oKpthEJcp8PA96vmPm4bg6c7H0nhhXoU08WUzfoFmzJOPDRlc4FFHhCcN5Iz8X55
	wpXXNiNNnB4P6lR8vn+bFUWx/k06lQaC7KuFDqtCT8Gtza4GSlMDew2tXRjX2R3t
	FkB7Ew==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615w3tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:23:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b10990a1f0so59874591cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756513398; x=1757118198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AqNK0JvpkzUHYLdcGKR1RHF7N4CzTcthmQAulAujD0=;
        b=ZAh79P7hXuTJIE2lSfSHCXEnqj78+KHCMAgiCe/eAGsWKnYzsd+5kUqnm1wkd01TDd
         F1tqjKB2/qAy2hlxobepazJ3+0R0wy1DWQ9QUunRurB4Co4oLlbIap7C13UVrA110o8v
         p1mMCqHFMCyt11ufKHJBgBEgfD9qebKxQppK8uLEhjorwQFDkyNBXChrnWJhmZbw/Kid
         0SoOmyQr+Q5H3fpqta/SgB0aYJ1V0pF1FMcNAaPbqL8LiC+DZsqC/hqsov12kQuSmQ4J
         MwdJW0jUYVUXK5IO3FqfVDyhOr/C81G0FeQq9KdxSNRk4omQKChMuVDR+6AJ5AOOVvUC
         MNsA==
X-Forwarded-Encrypted: i=1; AJvYcCXen2I70zp0DxQEFtlvU4CuQ0SK83NRzkROBgFFyLqy8Buvu6mUYAQQxqBgB+dpvHSBtUhQQE/TZCEVM5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxImFvanDuW82+hSsN9mjCcF6inwda4GzuK+qLnxzXyrVxLfRAY
	ofMMX5JJGv3ePuRLn29eLxRVK07jdCPMDDhOnCDrRne/xViPcQgfAoJfiQvMGRg+yJaHGSaO4u6
	4GcjWwrK9gD/jTN0RXL2wQapNmFj2j1sbAVqesrSYD8e56KjcWi1szSw6mZrsQGzLcpw=
X-Gm-Gg: ASbGncv7sRXEZ7rtqsICVgAqXVPuicJQCEEIaHVlsnc8izFn3UNP6qlVpR3dfJFEO89
	g8q1OdZ52AuzY+PKBJqN1w5Y1Q0IyxtaZhuVAK7vNo2Ay92yBmOhsan2ijTfpTpd3nSsyPU7pFF
	XXz87T9zu3fJioH1abzNjmnjqBpdT2oA1QaLsX+K3E7xRjBTFZVt8Yuet64eKhkObxKYBUoMIfy
	0D0p3vEXmAJTXRN43U73Vr/XC4f8DK6fZBHBvJe7QZ5ApjsjkHn3yvq1VP4Wz03pDuHckvEeUBU
	3X8oxuALojUdn/GDNvy5loM28SoLMWUn3JjXW1Q/1FKbfSsXMGFaIJpfgW6500sGJF2gwmT5RnH
	uR4zpcPyM8+0gLcXMzYJ5dYaQ6N4hlMN0UdJCm93YG8szH8jqwyxd
X-Received: by 2002:a05:622a:1a98:b0:4a3:fcc7:c72e with SMTP id d75a77b69052e-4b31d80cadbmr5813691cf.9.1756513398570;
        Fri, 29 Aug 2025 17:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVN1muIBwmw4hoq9Rahodlm2w2ewntFQnkQICLUImr1NmaPx8XUeu2IF08fUmhex3lGfMyjg==
X-Received: by 2002:a05:622a:1a98:b0:4a3:fcc7:c72e with SMTP id d75a77b69052e-4b31d80cadbmr5813271cf.9.1756513398051;
        Fri, 29 Aug 2025 17:23:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f676dc52esm1019907e87.8.2025.08.29.17.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 17:23:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 30 Aug 2025 03:23:04 +0300
Subject: [PATCH v3 08/11] drm/display: bridge_connector: drop default list
 for HDMI Infoframes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-drm-limit-infoframes-v3-8-32fcbec4634e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=cd27TNKmPZcfQJ3UKiBSlNuQpycc1+LIV7BQ0LEWwY0=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ8Yml5RgLv0905LPmzQqxvhe2nOH5VfAIu5qjh8VjHPOT
 zjoMtOpk9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQATyTvD/lf0vs0N2VdxoewZ
 BlvKi1+Fpdx4oJ01g7fslfG8TE6f+kcbLJ81nku69W/mZz1rOe1Hpwyr3iWdED7Lo78x4ljX77t
 qdrbvpkZMmsBfof+pWKdBPm7n7qfFRk/ecfzsPf3tsOo3OxedX/aPmqNLTSbJlj7IE68q0jj3wj
 CxzjXZIePtS/dDOY+LF+rKV67NWGG73faf3I+mMv2ltctNV7jYC6ycModrTdPtj7IiBXlf9bZML
 bESv/3wA3NU0/3L6SLFdhPMn0xT8dBpkez0WVe51T+FcaO+g/iaSP24B4/aBMzOPihT/Sq7u8nv
 zDELdVPFCbyigqIpb1OvcIQxGLRbanuGOlkaZtyUK8oHAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfX1bpSmQpXIxL9
 TrG3Fn/Wkuk1WsqdX1tExfe1eZIHLYk8dYBRjf+SUwqFFVxswMJKw/YD1BeNmBdNifKf2ubGyJ0
 NAiUZEydd9xbwy6m7rokMXdcTDVyube0zhaeOq6AzcJQ+fNpFjrIgGxI356Gqt0JM13CutmHPgz
 8f44d4MwhMCjm4wXg0Ej9QtChOC3WOKzqFzgD/r1MbFQEPSXbjjoVG6Ur46B66aI89tJY/unT9v
 YotILocuUIg4vPmFUc4r68GyH81Dv5Y0OQi5RJSpDGgfaqsv9GxcE4gHv4eypbHF2C3atn9AwIL
 MN31XA3KTcQzksCWYXepuApVvw10wAFRJBNCGy/GuYNsX10UiOp07quu3curtVzPy+t8k8+6ypW
 MIKD4QIL
X-Proofpoint-GUID: hfwf79wf9PVNdidHBDQoDtyzMLF1-rx9
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68b24477 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=-zYrYaJvJPDGblfDOm8A:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: hfwf79wf9PVNdidHBDQoDtyzMLF1-rx9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

Now as all bridges are updated to list supported HDMI InfoFrames, drop
the default value from drm_bridge_connector_init(). All HDMI bridges now
have to declare all supported InfoFrames.

Reviewed-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 944fb497ca339ddd63c132c2df0888011cc0487f..2eb7ab033cc84f8bf5816b5a608b2583226336c5 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -786,12 +786,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 					       &drm_bridge_connector_hdmi_funcs,
 					       connector_type, ddc,
 					       supported_formats,
-					       bridge->software_infoframes ? :
-					       DRM_CONNECTOR_INFOFRAME_AUDIO |
-					       DRM_CONNECTOR_INFOFRAME_AVI |
-					       DRM_CONNECTOR_INFOFRAME_DRM |
-					       DRM_CONNECTOR_INFOFRAME_SPD |
-					       DRM_CONNECTOR_INFOFRAME_VENDOR,
+					       bridge->software_infoframes,
 					       bridge->autogenerated_infoframes,
 					       max_bpc);
 		if (ret)

-- 
2.47.2


