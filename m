Return-Path: <linux-kernel+bounces-776377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E16FCB2CCAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663181BC5CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837F034321E;
	Tue, 19 Aug 2025 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cjfZLcpa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD9342CBC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629873; cv=none; b=PHXkdF/mYgcQvaSmc4xML7vq7qHO7wEnyUUo7N6FEquST7Jx2kSFeAKwnuZNy+nSiRyte6Iw5TfiMHTiS89HkRO/Fe5pU2rJLeZKVqVDkt5RYCjiC/FzYCkiV5iqf7hKH7P7Ni6Cx9lUxrjN9XHTgvtalDipvEaUWn18aAc6FK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629873; c=relaxed/simple;
	bh=7deMFPHaCP1tEuAyd0wqGDyMbbgXRm8M3x+yrKhIoqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gV5dueAvbwxHpUjHJURLvIFVWkKLo0XPoMydP7xM4s1jfFokGRpJf6OaS4IJCDPa5i/7JilUv88sZHO1SCa4KJAVTRdAIY9mymv1HcHZiPnJ9HqOk+gjUOjYzWdH9YA/h850OM253SnDnZ6garJswBz/+gPkq4uT7sfmmryCVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cjfZLcpa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHoabg018342
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GwwcuTSdQf0vvJ25qV2FXPYXtLSGO4QcuUbd1Q+beKM=; b=cjfZLcpa8g0ZiqHC
	za6eFtectx3dKHteVvIWF8BgkDa79oOPaudQEWmqVCwkJGUEvUQNoPIPRmWTF6Fu
	bBQYe694VLPDEk57j30y9ygejpQHTYmeKORc/hHvmeeLaSKZdws+5SnJXJXTIg/T
	7eJZqrCGe/BaRVynTOMv3kTFuHC6aT+MGyH1L0Uf5GRn8Ky2W3TBnl4d8uxaD08R
	nFsSK23dqsamvItlmud5LPV/FrgWTSeLxTGHf5EMFpn7H3W75oIkXxFtxChEhpjo
	SN4JDvPaGuSEOWmDHAlycxa6De74o6ORg+BcdAdWmpsiEJaAiCnxEbiv2HQMT2q7
	iGu1cQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhah1kms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:57:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a88daeb18so124997456d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629870; x=1756234670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwwcuTSdQf0vvJ25qV2FXPYXtLSGO4QcuUbd1Q+beKM=;
        b=A6QXFO1ALrT0Lf6ahiDqC7Um08cHzHYyFg5nRLhVpbh/2PMK3HgWOOT92/X6Rh51oX
         Y+BGn2PNAtKayxbjzshKSb/r4siH27ZyD6smcHv0bJjAKlCTdlcDYAZD5DyDq0JJetuM
         9gFeTm1ODGrwcNSDPg8iDcNKnfqZnUMMGzJCQddHeg/5fmER4nBSO4IBBxbp/KUwNpWB
         OEyi0o3rvGLCRsiuM6SPzZBfmcIkSMF6chWAvu06zNhWZhyghi99V/5uw07hgZUIbxzf
         L0ZJme8TIBPxm1U/N/UbYc1d0OJcrshFTHNig3AYUiYGAuyStavYsE/fLTaoSNIxOsa+
         BRdw==
X-Forwarded-Encrypted: i=1; AJvYcCVqZj63zdJxJ/3tcuj/11ml/6rVmPCqxI3eKevAqeJ87WBZ9QVnXG9pu2LPUArjZ2SVmC+qkKOPmcrK3pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymMR4xBHmB4ThgWworWq894fw/fIXuAM9xSUoiSB/1GV1XEifT
	Wj8Oi2o3YmYPO+C0fCpj6kOc8+uYa+AaI5qaNFgvKvlPP5Olyn1scWXzAOPpEbhj13nfSPuEcCy
	CZO/xdsl6gnsj1u0bmGHRdqnkeOTR/ZxgW8DD9GiAuObjkaDObf24QQTFEEqyE1mLgxg=
X-Gm-Gg: ASbGncvN2uwvkVaxY9/yDZBZNzjw64aM0wS42blc6KAEiNma7L5Rh3ik7BXUxHkrEk+
	zPLYm2nh5zpFwvk1zVgBknx1Jo8Mj29rMyCfmbLxisDxfDUW15Ik0UNZC7Xg5JkGB2jRMJjsDrp
	Jc2deo0HcLcwGCitqqEI0PByorZMhuNY/80v7ygwiv+RO/yDC8ynPrmonCvRDG1o752I5G6hbvp
	I7Xy26kRn9PpXeFZVUhJvReVZz//43Vw+jVBToGtTgt2jJnkVyD9h7G+WaPg4kHUJI9xBU82wVE
	zsMM3wGNOMcf8P0zaaFyxuKHsf+6jixqZBj1KhSNHJiXGObBInBOwFnbbmfrF32EGIJfj3KS6kl
	3BjyJM7f74c67i591k0hjjYFQh9oPPjeUzt0Ld9/m5xe2MK9eSJIT
X-Received: by 2002:a05:6214:1d06:b0:704:7df6:44b4 with SMTP id 6a1803df08f44-70d76ff7ea4mr1292746d6.23.1755629870133;
        Tue, 19 Aug 2025 11:57:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgeB6BspkJmBzVZghKuKkvMQsrc7yh47pgRmrociqcAQYwZxD4o4UnSWHYlSHwPmGuWLNsBA==
X-Received: by 2002:a05:6214:1d06:b0:704:7df6:44b4 with SMTP id 6a1803df08f44-70d76ff7ea4mr1292266d6.23.1755629869609;
        Tue, 19 Aug 2025 11:57:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35f11csm2207314e87.51.2025.08.19.11.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:57:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 21:57:37 +0300
Subject: [PATCH v2 8/8] drm/display: bridge_connector: drop default list
 for HDMI Infoframes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-drm-limit-infoframes-v2-8-7595dda24fbd@oss.qualcomm.com>
References: <20250819-drm-limit-infoframes-v2-0-7595dda24fbd@oss.qualcomm.com>
In-Reply-To: <20250819-drm-limit-infoframes-v2-0-7595dda24fbd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7deMFPHaCP1tEuAyd0wqGDyMbbgXRm8M3x+yrKhIoqg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBopMkcfIiZrdP6T1yKBcFmYUYjGemOpooWhlAir
 XvwHx5bmkCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKTJHAAKCRCLPIo+Aiko
 1dK0CACnaQ5P4qzpStTan2KFXA/Co+l8yegd9ipo+oTCj+eykTovOi7mhcG8CZnOFPUnsGb7kQd
 LyZnJQugFjc10kh2vK9lA1XdM4Cf6YI4WK8B7Ve12p3KmEVjnHSYroGza8IHcOF4nVIIrZnfxuo
 weLeMloZjk4ugu8fgJcuYuxcnIpUN8PfaK2EcNwyeJoxv66YrA1H3fQ8A7mfgvlIQDpmbyAhrs4
 3kxvNmJBPnkUKfk2FK+O4X90ktA0eTQdqVfe3mRMeW+YOTxjWtqa0eLtVMjV5QTjc1Dwo9CK2XG
 PqllamKjHCM5PHS0RBut4Mcu0qyvmLtxANCYLQWkCP0lKqND
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=D9xHKuRj c=1 sm=1 tr=0 ts=68a4c92f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=98uy0pNEvqNMg_-Oa9cA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: LJcFLVFz-2msnn94lTPgBuaF8iZUxDMh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNCBTYWx0ZWRfX8N17vXm5B5IR
 0ooSZdCMmz0Vg0dAV1/yyJHjXQ+CZ8naI+QAOcv5Z5HozU06aXPhkiYelGFqfg7OTxCdxNtSqTt
 2c82RreGfPvGL0fKuSINmITqbYS0gUTKDMjcvdHO84bg4KXJsl6vSP3Uomtmibe0tK7lYfVm840
 2MonUFJ5ylf9AeaLF2SwnjV0Jb/qZ7GllRcgKK6Pz44+hGRPRO30eH6XFHf63HuO1fWOmWVkkR9
 DE2at9lccuwdEf/LMyAbFDAsfy6oduFv50/hH/0Ld12qkhsUHQtNTXWl+QJQMtGZGgSKnWrcuCy
 PoF5J/R1qUCFdQdYLiKXiOMz2TygJX66a++plNEUdskVqwaiSrnFkv/bpOog2fdjJMhVVgg3fSO
 pduqe+pd
X-Proofpoint-GUID: LJcFLVFz-2msnn94lTPgBuaF8iZUxDMh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160024

Now as all bridges are updated to list supported HDMI InfoFrames, drop
the default value from drm_bridge_connector_init(). All HDMI bridges now
have to declare all supported InfoFrames.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index b94458d5faa9ae283889fc79496ae323bb4dc88c..047fb6276e9d84de39718cb65de72ba782bfb3a7 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -781,12 +781,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 					       &drm_bridge_connector_hdmi_funcs,
 					       connector_type, ddc,
 					       supported_formats,
-					       bridge->supported_infoframes ? :
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
2.47.2


