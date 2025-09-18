Return-Path: <linux-kernel+bounces-772125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A781B28F18
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B3877BF608
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA432FCC15;
	Sat, 16 Aug 2025 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SWH33GE8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9452FB978
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357589; cv=none; b=Aeggvs0zw+WoYvQArFoFGPFVMYers4V+f+KA6tiQuoE1x7tyIifDN9N93ABf8n6MS6knvTu2RVcFCAc75vc3AWzhKBBzK04zHwR9RAKqMHWiG0NvR/OyLSHv3FzsJUh+cyrcv1iOOLH2B6oAhoVc+J6FhWG6PR92hYk/onFxGxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357589; c=relaxed/simple;
	bh=bSu7BtDX/FJ/CYhdTG49eD8oSIyWKKcC6qKfEjkvl9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OOrSYN5UTiFYiIKgdwS+AcX4pGmBaQNLYjwddK8zHFlaL/9lB4DNj5Gp0/kZvnFxfNexcvlfeYSDdwOQRdu6ND8XogDf3zHE0m/roLdelK179+RienzLUQKYQLIPdh4Xqs6TBcoC1tcEHmy9T7HABSaUFzWvwqZnQGlKvZt9hzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SWH33GE8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G4ervX008852
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TRcyMGCl+30uALX35qrVjgv24YuvpY2moJlPtRkxYu0=; b=SWH33GE86FDLtZn0
	dlY2V3vW68TyhRFxU3mWsuoXo5/BnJWF5A8g7rb31wtBSSgn8cg6KL5ZogKpnyGv
	DoJoL2hzrBQh6fo0p1Q5hgYRdirAyUYrplnXJAuK/M9H5XIPDUQYxtwkxnTsBXzT
	cFB0IekECrC/H88ibrAS3CdJ0LMrRmUzj4JZtvfv3TpSac8n0sZuVDbd6OIpiIWB
	QmR08bWLoxlk+HnulcTh069TEcAe/OEfEhE/R8cVTdy5Khth0UKjizF4FomlhhTE
	0dcTTKMonlm4gmzh1voCqRRnQ2I9d7w75l8kM3jV61DmsysULKlLYGmIi7fiSZie
	uVL/tg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjc7rsyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:19:46 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a88dae248so58946996d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755357586; x=1755962386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRcyMGCl+30uALX35qrVjgv24YuvpY2moJlPtRkxYu0=;
        b=Rals9zR1WpOP/iNoArr9AnQ37n3B3I92aYusX7X2dMjHR+ewf9+p3MjsDshWUNKwAd
         5Y5wj5ZWuyWCiawOER8SQJT7mEdm0s817MNhSAGUypekJ/Nxo/B9lVIUcJQYn/GA0oT6
         2h2XCnt5lLghA/RGWVIz28aQ8R9rW+xc75uci4TzJaOt+j0UmwJWiseowNjCcmJPj4bd
         0bgvU3PDzBk7BjWZs7zyVpbGbXARpfKGGRVFfNk+H54+JBRA0l9tk2wg/G+SBjKxBVBo
         gq4OXZIU1/jEpo5CsjctLeutoiGI6YXyqHeHicow822ZLVzJWjRvghba97drFfe0gJnJ
         3Luw==
X-Forwarded-Encrypted: i=1; AJvYcCVbehaw1ozW1F0HuxKMCORWpuW7Ps6JZ2XinnwILdztL+NpFBgOVhb+F1SOsZz9kZNTRzRVCQFwcHDNGr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv3fbI8plMBl80Khe5SSVfXm8tQ1W+tt9mE4iJCIfTq62FGsNv
	4uoik/XAMaZ3Q3hYMLYAKw8TwEaWHWKjkXvu5+vkX7eWz+krecuNsqMJw+7VUGzQ0J8bALor3sO
	jPg3LLYD1zDCDp/gvrDG7D1zV8GWrnmI2ropnmX0yw/jhkOeE8udn4Xy6zrhg48hijj8=
X-Gm-Gg: ASbGnctoOBdXD4p8apdDJNyi8cCP2+zH/ROi9OIw2J7NfvL0KwZnHwe5MHYsfReUU8J
	OL89WLJnfIYXZghtvKYyMiXOYIvo/Jk020IkdH/vkgsAReIZR+/k9nlAEvu0Kge4T2eUmzEsyr7
	3+Ht1GF3EcJ+NBNhvgBQPlPoqa+bkOziCIblLHDFbTf6gJadU9Cc5pO2pZhNsPGFEiF9cdHPGcq
	4fz3FZyIHj0AqmU5fEzuog+VG8BQshGUM3Qggo1f6wRW/3bIQWj/aNwnPVg7IsOzcRw8tjKul1O
	YZATMUZD9rd/KqlRDK9Lf/zp5HyyFiaJSBLWBHiCLRC4TPnwYv6U7WNHSQVg/48Jqu35pX/wWqH
	yaRt/z2YwcuhzuuV606OdHKo+UGVSz/Xrr7eiKPflh7Jo5qy+ONlB
X-Received: by 2002:ad4:5c4d:0:b0:707:89e:20a0 with SMTP id 6a1803df08f44-70b97e5f8b6mr121342666d6.22.1755357585901;
        Sat, 16 Aug 2025 08:19:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYKtw8girfWWYEqO/Ggcji51+kihQkK91jR/jljS3mVOG35hIp3DD0cbbL9nG5EcyplDI8JA==
X-Received: by 2002:ad4:5c4d:0:b0:707:89e:20a0 with SMTP id 6a1803df08f44-70b97e5f8b6mr121342146d6.22.1755357585415;
        Sat, 16 Aug 2025 08:19:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35965fsm907579e87.37.2025.08.16.08.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 08:19:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 16 Aug 2025 18:19:37 +0300
Subject: [PATCH v2 3/8] drm/mali: use drmm_writeback_connector_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-wb-drop-encoder-v2-3-f951de04f4f9@oss.qualcomm.com>
References: <20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com>
In-Reply-To: <20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com>
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
        freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2621;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=bSu7BtDX/FJ/CYhdTG49eD8oSIyWKKcC6qKfEjkvl9M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBooKGIYX6MbbfX0q4CqCoZNIiZx1UDb6oAqdBYr
 e0GtlGtu66JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKChiAAKCRCLPIo+Aiko
 1XFKB/0X/ib5lIagcGHFFApfOPY+gYbqF8flWf58m5QwtwRW5JbZgubNJhn8ewnog9DlDUs1iQ2
 8AZd4JZE8uJ39gfaok+MTfL+tqc65sbijJoCKgvz9+dlMkRxi1rkg6W8XBAj/Ql5xi4QJdIrHuc
 6v09zB7eIG7Lmmyxvy7H+l2SX3npPoNX/1kWEBUcDdZMEz+kNRYaS2C67tip/1O53yvNISFiR9v
 DZc/rM1UzRP81nWh7ilpYyfA7hjUAMeNnYJR+EKl0Ma4t7O6c/ABqTgZmtecludu7wNZwZhCZBX
 S77fnkUHzj74L0sc6kM/VDZNgmgTj+Q8ATzzUHygv8oFDR+G
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX+/ouzuA/aoDx
 LZCTxjv/qf1nbkS0P4/cOImYBNFhaLUQ/CV/J1oJa11nNdqpHuzIH9btTRyptPb9X+ScDqvN7PI
 WkJkrhIxaMQ7WYBV+hy/+aGB9f4CaRnvT5La9RHp/0FUlbavLvCM27EtmtUGJq3SqN/rbYXF6tE
 MRYFp1FtQ49Ae5l3sD/dnQGhCmzucYGlOqHHtaNIKwNdY0oewIgpJ0H9/McHc8PWGyf+jbVZREz
 P24WC6LM7XwpoFclmC/MGqP1nAUeGEA03JSv9xZa3WBJC0SCmcMczq3VBCJWSuSPmWoi33h3PNR
 agMjrwedR7La5uH/329qT7MS+rW64FIZl66nPKrqto2fyY2FbdCsDNP94Dbq39/Q7A821SRQpTl
 ROqna/pt
X-Authority-Analysis: v=2.4 cv=c4mrQQ9l c=1 sm=1 tr=0 ts=68a0a192 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=mhD89yN676IZukTL2GQA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: LURA6ocvKhCcq-S-x_L4lL5DLc5IbXS9
X-Proofpoint-ORIG-GUID: LURA6ocvKhCcq-S-x_L4lL5DLc5IbXS9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160033

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/arm/malidp_mw.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index 600af5ad81b15d0c30f9f79588f40cca07437ed8..80f7f3474c4494554c6b6fb392e7f396b3b49c83 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -84,11 +84,6 @@ malidp_mw_connector_detect(struct drm_connector *connector, bool force)
 	return connector_status_connected;
 }
 
-static void malidp_mw_connector_destroy(struct drm_connector *connector)
-{
-	drm_connector_cleanup(connector);
-}
-
 static struct drm_connector_state *
 malidp_mw_connector_duplicate_state(struct drm_connector *connector)
 {
@@ -114,7 +109,6 @@ static const struct drm_connector_funcs malidp_mw_connector_funcs = {
 	.reset = malidp_mw_connector_reset,
 	.detect = malidp_mw_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = malidp_mw_connector_destroy,
 	.atomic_duplicate_state = malidp_mw_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
@@ -211,6 +205,7 @@ static u32 *get_writeback_formats(struct malidp_drm *malidp, int *n_formats)
 int malidp_mw_connector_init(struct drm_device *drm)
 {
 	struct malidp_drm *malidp = drm_to_malidp(drm);
+	struct drm_encoder *encoder;
 	u32 *formats;
 	int ret, n_formats;
 
@@ -224,11 +219,19 @@ int malidp_mw_connector_init(struct drm_device *drm)
 	if (!formats)
 		return -ENOMEM;
 
-	ret = drm_writeback_connector_init(drm, &malidp->mw_connector,
-					   &malidp_mw_connector_funcs,
-					   &malidp_mw_encoder_helper_funcs,
-					   formats, n_formats,
-					   1 << drm_crtc_index(&malidp->crtc));
+	encoder = drmm_plain_encoder_alloc(drm, NULL, DRM_MODE_ENCODER_VIRTUAL,
+					   NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &malidp_mw_encoder_helper_funcs);
+
+	encoder->possible_crtcs = drm_crtc_mask(&malidp->crtc);
+
+	ret = drmm_writeback_connector_init(drm, &malidp->mw_connector,
+					    &malidp_mw_connector_funcs,
+					    encoder,
+					    formats, n_formats);
 	kfree(formats);
 	if (ret)
 		return ret;

-- 
2.47.2


