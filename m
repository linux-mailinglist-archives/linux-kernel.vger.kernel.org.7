Return-Path: <linux-kernel+bounces-753431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E70ECB182EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C1333A114E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7B52586C7;
	Fri,  1 Aug 2025 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VjJ+wtta"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4926FA53
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754056289; cv=none; b=q1NI6xsvUQc1GYlbsmhgsnCyZw6IcoYPyCvv5hNM1oFc3pYuWf8XV8fCrBG9t9wBVdq6nDh/Wt06NSSV7FCWYxRt/wlyxzW5/BQCfliS0lvJxtr/F5QK0AERvJNOm+d/kYtgDNnFGMyS49cKkN5m+sj5vYOMiSLCduiWn5DFgY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754056289; c=relaxed/simple;
	bh=p1vIn/pLBbJ5zOAwN/G9XdaGKb83FPkfI1f2HSftzDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=So6nbLJgSi6Iml3FAp4/8AxfYR4gt4brz7NELuHY1hGqbhQCFbskv6cKuxUUaQNKfnlGukhDKAUrYrhsjb5LEJittDTOXCOxKrdV1E9dXD/aZk09zFsEkoJBmpKDfP/7CblmVc9S2UW7UlBxDlLmdMVZGEmlE2kC9VMtXy55W6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VjJ+wtta; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5718mk5c021714
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 13:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W2UCi+malvB0ar8bb6DW9kSFC86prf8rvHe8q8tIWaw=; b=VjJ+wttaMaAyvo/w
	Jp5kH6NjJ4kszVYIFnbCxOw0/E9yoW10FgZrcO5RLvi/Kbfr/mAtYEMhvVQumaXH
	nQTyvuYeFYE+0nKGN5x35T1Nb4xPytiW8wf3Lu2PeYUrv4HItVqM69zKgjh33L9F
	EhpSEqU6KVVLjpnCG1hPIWwE+uLMC/ZsecUYpYeCqOz+c1bwDjU/xJbFsFllXdIG
	0ejkdZE7GPXkgWopZyMVGb9SKvOBA/zITP2odOuNECJ2nzvXfnCQBP9Cw4yUMUDx
	C0VDjmMMHajjU7xu4hcazhSMOkazuUh/7L5TVGL52BG3mKjFngQ1sLrW2ff2r1GL
	cTNtEg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcrm7q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 13:51:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4aeb8b6acd1so17008381cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 06:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754056286; x=1754661086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2UCi+malvB0ar8bb6DW9kSFC86prf8rvHe8q8tIWaw=;
        b=RkOLpj44EYlYYHQY0Ks8l6qMjJ2BO9dzj8HrcYEvT3XJ+ANglZpIVlcsu53/BKIwvG
         UulPZd+Fun8ZAzccK3mB3j07YD8+CdpRhtH4g8WTZnZyA90OnPmzF7rRC4gyKuHZtY2L
         IYHcs/9tt23lkWXRK5duYOW2A68nceVprBreo3YrOe7wLWGYayiILMuXFacMDFcwyQS5
         PlAeu2njgssRupttzT8O3o9qhWpOjJA5b8QNPOfRRB01Zllf1W5RklgpZ+jQCW5ud7dD
         epM+2ZOez86StfaUrP34JIHiKGaz6f7hG2VGcKgTjwVDvl9aV7vw75TLZc7fMSK2Jf84
         zdXw==
X-Forwarded-Encrypted: i=1; AJvYcCWeIoRS3L3GsVKPzULw4DZ3gM5yAX2VW5RhSzxsN8unZqAK4UODKS9McUGjyyhbApt8LS3YGqa5BijvuGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuCpXKQmgE7brVqYZx3notLDAAoN5Gdf5FrQufs5K3hBz1vWZh
	BLAyum2rQ2J4kCwbsrBYNRaKSW/yaAfewuP4/bZU6v2f/L0gcy4seFhGPAc4ynDmBO9mBtzt/Nz
	JjKwDSfMiOEHqVSJLPaxlROWIsJF8KHKXMysxWCxzHRDkahzgfiFIYubZjtoKDoXc4Wo=
X-Gm-Gg: ASbGncuUk0+1oYiIAZ4E53XRNb8EYzlcJpioBY9hcogmVeK7PDF25v34BkEGUStxRVW
	hAqAluD3f5hSaRmf+7e4D5IYVG8yRQHmwuUEA7QcP2fKxWv63RuyeOuzctP0/t1e20jLxlLPjLo
	5+sFWhE9JFb56fURg+ywnSmHKIZirQ1jmUpQBbTPYEpUDe/uIJkRPqPZ08qNiEP5BZDd/frFxmL
	Ex3szJrZwpPmz0asMcCGmRQu449McRtOK2zIz9lVJRMdH3OCzRpyLALvDmVK9X7P/Ub+HXMujjm
	mRxIHdJVgeKowoqq80tUkdJoFVz086d2oV2PNG9vdhl3iGd23vQUqGxNPMKpKMIut87xa2gWpFu
	G9hIEdz4qhTpcbWXoqzHq7b9QaZUdZnHzLMuWKZ5EeCLqTPeG0rCw
X-Received: by 2002:a05:622a:4fcd:b0:4ae:f1c4:98fe with SMTP id d75a77b69052e-4aef1c49b02mr76647831cf.34.1754056285909;
        Fri, 01 Aug 2025 06:51:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAwqWqcrYsHbU0F2gj2xmMxu0CXmwPTRpB2ryFYEdGwGRHG1UFGg9MBUQvZBikakoqd/cRgw==
X-Received: by 2002:a05:622a:4fcd:b0:4ae:f1c4:98fe with SMTP id d75a77b69052e-4aef1c49b02mr76647531cf.34.1754056285484;
        Fri, 01 Aug 2025 06:51:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238273006sm5917801fa.9.2025.08.01.06.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:51:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 01 Aug 2025 16:51:13 +0300
Subject: [PATCH 5/8] drm/msm/dpu: use drmm_writeback_connector_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-wb-drop-encoder-v1-5-824646042f7d@oss.qualcomm.com>
References: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
In-Reply-To: <20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
        "Kandpal, Suraj" <suraj.kandpal@intel.com>,
        Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <siqueira@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=p1vIn/pLBbJ5zOAwN/G9XdaGKb83FPkfI1f2HSftzDk=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ0bPsWCx0yvsNgYcls5I+plW1j3Fjjm+X0px0rzqd0vs0
 k3EioQ7GY1ZGBi5GGTFFFl8ClqmxmxKDvuwY2o9zCBWJpApDFycAjCRty0cDE2u3dqvkrq7bmfF
 GxbJfBK+ZLJFuKaj26z4TYAFw/fJBZ2aYT3Gdf9/PWAxvbefn01Pz+WJmX4Nh7rCawmJhRy1706
 af0ncqHWyLqckPz6+/8blWQf0tQ+x+89a5TX7S45x/TNzlh3qyeFRl37Ezzy08rXZJ8bL6ooyoV
 EfHX5Ebo1krQ1gmbFK0crxnYXlZhXrdSGia/STswu9wpY82y07y9lQNGfJ8xOBFYyxVkrZOx+qb
 Vw16+qNB63ze6WmWzmfX/E88/ZurZg1MdG+O4LnBeR9/WLr+eX0wq2SAr+u6EnEO5o6eYV8PfnA
 vv3RupYU979rBV5UGpx5cvFAoH1d+/sSiX/KJit4UycDAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwMyBTYWx0ZWRfX9JVGrXX660FK
 ou468oWqvCMKFmoZOwKNLMkAUBDepJurCqAGin4umxLc/68n7AIEEkOcMyHB6TRT5+XN1VKXvPv
 stHnP4ODJAongTt9Z6b68FRqLBHGKS5ifYkPHnPX2LH7cYGNN3CeBYl5T1cWkQs77YMjMNy3M+c
 KrDHzx1xTmrAB7AWyogzI1fhKD1fWkqPXbSuWkA39P78EPzgrHcblNZ4YVBg3N7NtJwMZiq8jA8
 HsY/cjLwYvd5xN/ZkxM5LtF/eOCVpePelLJa8/389oCzhSDQFE7mbdrLhAU2n4P2/dzCRgLlSK8
 dFJesoR852Wjerp0oSlY4mRGvDRS96TEoOohqHAO3bW1OoqVFRafB/n5N+NcBtlk4CL+TyvMgBL
 jxW3gK8ShFgwK5yo9y7z31Gtrjypn982rqSmdx5ZhEb0sQZ+MqleCLBMHNAmjSHKNul9431S
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=688cc65f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=mhD89yN676IZukTL2GQA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 7DXPv9Oa0MpiyxukPk1W53YoKnTtOAAo
X-Proofpoint-ORIG-GUID: 7DXPv9Oa0MpiyxukPk1W53YoKnTtOAAo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=912 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010103

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 23 +++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
index 8cd37d7b8ae281cbc1fd8cbb243c621174517e23..9986a10e8114680e9da48986f4ca3ce6ec66b8cb 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
@@ -134,7 +134,6 @@ static void rcar_du_wb_conn_reset(struct drm_connector *connector)
 static const struct drm_connector_funcs rcar_du_wb_conn_funcs = {
 	.reset = rcar_du_wb_conn_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.atomic_duplicate_state = rcar_du_wb_conn_duplicate_state,
 	.atomic_destroy_state = rcar_du_wb_conn_destroy_state,
 };
@@ -202,15 +201,25 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
 {
 	struct drm_writeback_connector *wb_conn = &rcrtc->writeback;
 
+	struct drm_encoder *encoder;
+
+	encoder = drmm_plain_encoder_alloc(&rcdu->ddev, NULL,
+					   DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &rcar_du_wb_enc_helper_funcs);
+
+	encoder->possible_crtcs = 1 << drm_crtc_index(&rcrtc->crtc);
+
 	drm_connector_helper_add(&wb_conn->base,
 				 &rcar_du_wb_conn_helper_funcs);
 
-	return drm_writeback_connector_init(&rcdu->ddev, wb_conn,
-					    &rcar_du_wb_conn_funcs,
-					    &rcar_du_wb_enc_helper_funcs,
-					    writeback_formats,
-					    ARRAY_SIZE(writeback_formats),
-					    1 << drm_crtc_index(&rcrtc->crtc));
+	return drmm_writeback_connector_init(&rcdu->ddev, wb_conn,
+					     &rcar_du_wb_conn_funcs,
+					     encoder,
+					     writeback_formats,
+					     ARRAY_SIZE(writeback_formats));
 }
 
 void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,

-- 
2.39.5


