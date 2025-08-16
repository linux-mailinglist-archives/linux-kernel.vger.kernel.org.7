Return-Path: <linux-kernel+bounces-772121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 329E3B28F07
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482761CC5BB5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9522F9C5D;
	Sat, 16 Aug 2025 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R5IKICsx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796B52F99AB
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357585; cv=none; b=kRocZwTaseU+/UHCMpHKAGuO3kYzguLqQMrjOu6V5WCtI0/tea06vrTUQ7Znb2T5aaYusSJzwxpXHEaqmeffBtL7Y8K4xesFdHLTCwBpwnLABiOgcII8/niTnw2j4mdeXiEUiEA2gwXipmk0QUWe9OkYlmVRwI8y4qrC4YCiZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357585; c=relaxed/simple;
	bh=pfarMdKTP3PKuK/rYN2PwD9JvqS3ROd0ZonPoWJ3yhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nGXBAkRLfOoEeRsa3pULrBBEQ1cz+IP6HPhMn7Klwxdp9TrmdxpqP9oMJmGomv+eFWQ24tXC5kZvimEbNfHhzYLeMIFXkAj9jfMXgk3ozZZtHs7TPOdopUfjdXWCt9XBCjaLDyhrdMKhw7hHIglsyDrpcf2A6N/3yh+LXIhbh9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R5IKICsx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G3ALEk015774
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ovJO1XSWvs0KNakJASmsJP5sNHD1z0QwbqY++5/N+xM=; b=R5IKICsxLv6COm9L
	PFZBk6sLP4uJR3A3VmpAMfp0N5eOTTrQoIkib5D+dYzFzDroTCmwNT6mTbwfFsaV
	X2jkvAKqoGclfm+vqCZlDyaZZ3futP8r88lBSkYl4SYqwzEGN9pqiEuSmJDnkrir
	7ltUcd+SwHraN5/tVW7PeCQj5tO2HGFn/JufUdzNJEpRzz6EiwiQaDCr1po3ah8h
	br8mCgAe4ipRPOkgnQK4hM+6YJ+VvbenEyGIH4sG7S3sd9+FZZoUGB4XVNM9k130
	toEuZ0l/whK3fJRWmEJ0pJJdoPbaAcWBHvI0oGZSZKD28mGs6f5stwEHkT4iI2wH
	5KDlfg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhagrvkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:19:42 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a9289280dso61133146d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755357581; x=1755962381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovJO1XSWvs0KNakJASmsJP5sNHD1z0QwbqY++5/N+xM=;
        b=jY7ED6sxKNQT3bMF2XGzxp5wgdcoBACLksVry+ucmlERfsXxThPuvU13+LTY8xcOIU
         1lw2uUQdZ/uZTVJNvpogVijhDbvQRF21fbIWPAWbeevDz3tMrKZNvuU0tURg7iF9lGhX
         ZfwoaeomUdJ9naLkA8qyikMSW2j5jrFLtvqD8PGyCVVBrZX6pVud7zMoH6yp4gIo4PnV
         qvZcMlmT29WC8rHqXiJ+O0O+ncXX45XF25+QB9w752GusTG7RlSA6nI5wAknDLBRbbz9
         VBgVZRYf2P+q8JcTh2h5c8k8NqFS9zqTw06CkNKp4QFWNwyT+OIxu1AulqsgQlaDjbvZ
         /DJg==
X-Forwarded-Encrypted: i=1; AJvYcCXXWNoq70abBB8R/k18fn/jpI0PDgk22yLN/aw5in/o9zeJCVvCfXdzdHpdHCm9vrMpLrpxsMUYHCBNeBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzQ/IX6RM0VYRiP0zdyjoNgWz+zYqkh5NX+OViQQAKXMLfIIUO
	M9I4AvVSEexJXHFQCfEBHMRTbszISbBZKUjUa4FcYEiAt/KHshk54byWbnqNo1ZlmtR4DDiUi0x
	fwuMi3c6C9uhpf7ckb99koSJmkqrJ6S1kO/m5vCvASR1nPOMEdYIGCLfcOg24LFd+Bvg=
X-Gm-Gg: ASbGncvMy1SfpHSPWTm7EiLGCBsFOaEPmXPpWHi2jZkK04jnt2eYQEB0NnDbSDqeSpW
	eLnkBD2hKiS0M1Jij+sFPmV8FQhY+YsDAsMSzZeaOvSzTFOs1SUQF1nY2Bvf0DG4dLqegEUMn5p
	qaftmV201nqbdF3T/4KYbBRUtNuu9Owo+bbYezOljycFLMPOezyAADlmAKLBvNiXXz6nHObGCJS
	LmqhtWYLH+A53k5znCKJ2yRtiKQMdNe3O490l83iZ+f/+s/wvZkMP+wZdguExdzulqk31CUu5am
	VXQ+//4j4Rl0aCQL9rKLLK6WWtCauiRbe5G1A2n6DXWsc3N144s059H13coQPWUWNWsC8g+K32u
	W3ZKyQgFSsqxCt8BsmfxQhytBDdEV7Z2Cw8+0K6nt1HweJl+MRQ2V
X-Received: by 2002:ad4:4ee9:0:b0:709:e3ae:d598 with SMTP id 6a1803df08f44-70ba7aa107emr81268156d6.14.1755357581463;
        Sat, 16 Aug 2025 08:19:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3L7Kg33TAOFsNeJ8twbLfA/y9ftS7KG9iciVNPJsGz5y06ZwF8dOFeuocvcqoStELWJ+qEw==
X-Received: by 2002:ad4:4ee9:0:b0:709:e3ae:d598 with SMTP id 6a1803df08f44-70ba7aa107emr81267506d6.14.1755357580964;
        Sat, 16 Aug 2025 08:19:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35965fsm907579e87.37.2025.08.16.08.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 08:19:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 16 Aug 2025 18:19:35 +0300
Subject: [PATCH v2 1/8] drm/amd/display: use
 drmm_writeback_connector_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-wb-drop-encoder-v2-1-f951de04f4f9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3090;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pfarMdKTP3PKuK/rYN2PwD9JvqS3ROd0ZonPoWJ3yhg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBooKGIUvDNB5/Vq1AfaWJ5dhoQY3yskNwZSsVo+
 QLCjRWL1BWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKChiAAKCRCLPIo+Aiko
 1RTIB/4oPGhWfB4pdoc2YqsPw9ILKe6U6yn/zFh6rnIOtHWK7ys5g3xj+GRAcwBghHgjcQ6BzH1
 dehVbsEOedPhTFVaigfw2rPYmwG92pSk5kN5G2lc4oYNAsUF+DxFsfHK0loyjvrUkd2bFIT5jWh
 UtPLDKBtcuw/4M9zqa6ppMfgd1aVB1sibq2w7xnR7fuLjlHn6MugHO1j28LWmWWTpgTB0H5FYoE
 Olqr0/g4qa8uLRJbbDPzpY4QD0cdT0iKtnrU7KeeIMNItjD4P5bht0GvrFBxeS/39EluqjryGY8
 eMVdRGRldWpOy6kPBFf2IhPHsn6/CuNNAbV8yiIu6J63L7Wt
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=D9xHKuRj c=1 sm=1 tr=0 ts=68a0a18e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=P-IC7800AAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=M-qvw7r3wQx8XY5Jx90A:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: -kEe0YJbgekAdACzuHkoz9KGBn4gTw4b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNCBTYWx0ZWRfX/zPDIlOHQ4kU
 WUDt/sS2UA0xR9idMleXK/UjsdlXJk9hI7Kditf1OkfGlvte7uMkJ3hMRHwviCr3mlbAdbIEn4f
 mR2NkDHm2r9Me607MY7QlAOScNzzFnZ6jAi24TAma3BFL9fVAs8NoxlpgNlpAgzSpZsj4BRPSpT
 driXV0oeKyeCgdZTMyrbRjdYrmnxEiJ8RxsXDFuBFVzrXxMK5/WV1ZWEMPE/hOTMneeBT3bAe3X
 zqdgTWT4bdREGzxlMc+ZhHezZGFMis9d4gnrErP8nfPfgbMjSIDxK7akCXPxZj4BSaXVpM8oNMw
 lvUGDr85/CKcdH9VflvJ3fWVSYbzhnywcpB0phyvCYgSMc3n1ozGsjHmG4zNaI6NXxSQVS8E5Cz
 gA7bO/ab
X-Proofpoint-GUID: -kEe0YJbgekAdACzuHkoz9KGBn4gTw4b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160024

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cd0e2976e268da41f576624c50ef0c76ede67414..0c9d347b1efc804a28fb3095df94e543a19e4159 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10006,7 +10006,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 		return;
 	}
 
-	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
+	acrtc = to_amdgpu_crtc(crtc_state->base.crtc);
 	if (!acrtc) {
 		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
 		kfree(wb_info);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index d9527c05fc878ef6916782ff9fde847813938461..80c37487ca77c0494eaf769c5b9a3c53486aa52d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -171,7 +171,6 @@ static const struct drm_encoder_helper_funcs amdgpu_dm_wb_encoder_helper_funcs =
 
 static const struct drm_connector_funcs amdgpu_dm_wb_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = amdgpu_dm_connector_funcs_reset,
 	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -190,17 +189,26 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 	struct dc *dc = dm->dc;
 	struct dc_link *link = dc_get_link_at_index(dc, link_index);
 	int res = 0;
+	struct drm_encoder *encoder;
+
+	encoder = drmm_plain_encoder_alloc(&dm->adev->ddev, NULL,
+					   DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &amdgpu_dm_wb_encoder_helper_funcs);
+
+	encoder->possible_crtcs = amdgpu_dm_get_encoder_crtc_mask(dm->adev);
 
 	wbcon->link = link;
 
 	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
 
-	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
+	res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
 					    &amdgpu_dm_wb_connector_funcs,
-					    &amdgpu_dm_wb_encoder_helper_funcs,
+					    encoder,
 					    amdgpu_dm_wb_formats,
-					    ARRAY_SIZE(amdgpu_dm_wb_formats),
-					    amdgpu_dm_get_encoder_crtc_mask(dm->adev));
+					    ARRAY_SIZE(amdgpu_dm_wb_formats));
 
 	if (res)
 		return res;

-- 
2.47.2


