Return-Path: <linux-kernel+bounces-753432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33016B182E7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57383581C14
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF47725743E;
	Fri,  1 Aug 2025 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bj6cMkpQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6164D599
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754056291; cv=none; b=s0ua8ylJKppky4usQMSMJKh455KML+8ujbjT0Y2GsMxPErTQ+pqiR22yfCvuPb70GIBQoX55YmKC+E3RIhQqhGHldFeIXoxyl2YcoVgrA3+uiNeCBOQ4Uk5K7Pz8DkjAdngn62i9S0or2PHZ1mzabw3s3s/n+D4gw3HZR24vxc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754056291; c=relaxed/simple;
	bh=NBwFx/yH904VfCprkWLv97gvBydY/VJ1MCw22/7DCtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yw3R8dFk0zWOj3H6kALzhbx3EfPDe6LW4hVON0yxWIkqgw4VqCJA96Wz+2QswaMZo7H6GxB9mlh3PvIJxe6x9tfy9xA5WF3W1dDFIcE2avToWqCqTuK1GFm33APSmfgyC8QcBEHWwpl7nsY+qqIfUToOaK8PV8SadVEs6C/zXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bj6cMkpQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719g68k006293
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 13:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mLmvIm7aiVxs6oMFsxxhFeeRx+tZKZlR89XtVnuV08M=; b=bj6cMkpQ1CVvcSbF
	fWDc1EgzCf9Uy42mi859BDmHxMGZLuGWKQ0511T+iMZFf3FBw34+kmvRM9ZwZ2T+
	hqSiWO0SElelynghmVxziCRovCRsIoOp0DPCMhhygCXadGqFTBMY31fmCzil56hn
	TwN1uWP4dvOa9eW9/rLfqx5Hxzi1t9g/fc+EQhci4F7kHScRoMm18OgCxPA/IMJJ
	Sn+1TZEAkO1SA4NpsS9qT97FYO17Vd89PNXRC1ZFsXpnqbmMpUiqBr4iute12eU/
	HjisHaG7kQRnXCTRalQhsczTLaXyaZfligHAJKqA1HEeCralZm5qQxCRbtItymku
	3B47hw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 488u650pmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 13:51:28 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab44642abeso16224171cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 06:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754056287; x=1754661087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLmvIm7aiVxs6oMFsxxhFeeRx+tZKZlR89XtVnuV08M=;
        b=qvC12KR06t8KvM4j410tRvglAFvEs5NKLZDleURgTDnl4YKdC48Q/x21eK9R7QoizI
         C4VK0GyrS+plHV9I5HT3WeptOxsORHjsk89q/e/1bWeZj7GumSyECDgrMbYk9mphQr4j
         uxSX5iLjhKoeGSm9LHbXZMp+zwVOSrWQRUFwTIOkigF530rPHJ9NbK4iws9bJpl2AL5o
         d4Izq4qeL/6GkXCXVNgXS1AlXrVYgHtZvadPcXRcWgiRhMe+3EfUqj5BmGTnC0afI6Es
         mPEX9SAL8jzKAgZsHCMnfr25DidLzXk+K1BvO9FmjA/HI3wMHatz3uB8JlEwK4AjTvfy
         HslQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE/hCcDOlUSway1YiKJ/dpNlERlS9PKmtRtPKitANsLzZfsxsRM5O0StsdmfLwvZA3WjkazjwxrzDJhuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAL2Na5p9mUTbTvDRBiu+Vh8gyqin9YtmAHejcr9TveEcs6Clr
	Fee+DwI0UH949Zc5xaCK7QsZrnRJK6xWs8ifD70PXJr6GsHDioO8RldcrVu6DrwtHR8yrfo0e0v
	WSBLdjOlnXWmgVdogce9ifS9d9AR8qxWoCi46rgR22XURCqnZun29yk1QL6K09AfcHl8=
X-Gm-Gg: ASbGncuJbpT5dcvLInfXk/kokaxTxs9jCX2eXb65bWvQbxHOO5FJVJ9+czaNIJq5ZQj
	GQi0s/y/VtQSEsOEtFN3VKOPKS0dEFgiMLqHZ76AhBA2i9XJYr8I1V0anISZN1bS2PGHxY27IB3
	FOeiXkJrfL6UEz1z7v2u78wVz66gM6Qn+fvk13cw0TporoXrv/Nn+Tv+CXcVNFdSE6ucx3LAWzS
	EOwZ/BkacLUM27BJvpKFVQcoTOPo1/DL9JG/PT2qgtT3M1HDVwKDuoCK2wLpwWPB4cM7rJZ2wnK
	LXvMtiy4+YZVGR7H0LdfjAjx8Le8ztUh9Mt6RklcBv2vMTwSseerVIy+6u7bGN3vXdFE/5iJPGC
	lISLvIT3quVENvc4Mr18dFbqMAZtrN5UAZM8623+0o3uHtsxUHaC+
X-Received: by 2002:ac8:7f0d:0:b0:4ae:cc29:829b with SMTP id d75a77b69052e-4aefc3aa90amr71546811cf.60.1754056287124;
        Fri, 01 Aug 2025 06:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2viD7HCKu6xS/QJRV2/S6eN0H8AL2SA3fKo1xo5upDmFhtIUjZt51hysctMnmpx05ndtrSQ==
X-Received: by 2002:ac8:7f0d:0:b0:4ae:cc29:829b with SMTP id d75a77b69052e-4aefc3aa90amr71546121cf.60.1754056286612;
        Fri, 01 Aug 2025 06:51:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-33238273006sm5917801fa.9.2025.08.01.06.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:51:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 01 Aug 2025 16:51:14 +0300
Subject: [PATCH 6/8] drm/vc4: use drmm_writeback_connector_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-wb-drop-encoder-v1-6-824646042f7d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=NBwFx/yH904VfCprkWLv97gvBydY/VJ1MCw22/7DCtU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBojMZTWODg7Z0I052lkDGy5sp+gbJXRPPW3+xXz
 I8SasIVGkCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIzGUwAKCRCLPIo+Aiko
 1WY8B/42eKCXBjQZniwEwDivu+L77h8KSZkeqYYq+el8I39V5l9aHEmdvGRms2n+efNwV1ck0rj
 Jy1a9Cv67p7eEXrs8o1zTP+BGa3sKhKTs4lvZWHx3d6YjAcJr2Zg3df9INQWC7IsATuDKgfbA2E
 JhHLnz8c+tuCb07y0uqnRTHGpLB3UcVli5DjTVGH5gGQPYpegIYqh/FVxuacRujIWIvOW4qRCT8
 +FnwXJAsYkPA9arYZIm2kX8awv2FHs2ZTSNfz1ht3uGAjMo4BD1uCkmrqpvMEoLyEzE8gjHsSP8
 5aOgtKUcrk2v0+9aBgHAKiILYunQCCOJCo28SHY+jdKL58YA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: GXFa-easrmm-EpWLjO0dHIshOjMp02Rx
X-Proofpoint-GUID: GXFa-easrmm-EpWLjO0dHIshOjMp02Rx
X-Authority-Analysis: v=2.4 cv=f+RIBPyM c=1 sm=1 tr=0 ts=688cc660 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=hRdDZflY9wZGYtDLNskA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwMyBTYWx0ZWRfX2Jpxd1bSGmia
 lSQSaVRyzYcKFqnBZOUETDWm5rcNxH514ll36UleE41ZjTdZkhPhogikiX0Fj9lIS2Y+6MoI4k9
 GgFZb74okiKr9vmHPQ4OLCnwGF8uv4GJGjby6rDDdcoEXgmA2yA7Ctvd1KxmteeahLTNvF2hCs5
 7sQ3sJ1PpVgiqamcGDmtc3KJkPWMRvuwEYr4Ys1lP2JghBWVHyOglcuk8hvrg1P30w+R67tqxIv
 45bIKHZ4ABrMWeNf2EeJk18eMDAELotzbSn2rSclL2Wp9373sPlCgnKSvRERNEfTChxi41m1fKi
 GwTsQvLY+lwduIaFIJZB5eT5XFWI2X5ZgijVfQlz3E4LY5WEonxBhVkF+gOVoBMPj4mbUEqZYga
 vibcW42glbX4qyCceyQhBujgE33PDOE1RN2o0Ov+K0eAduyWvMXBlqXW+r+kDOx7VDdyTWtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 mlxlogscore=883 mlxscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010103

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/vc4/vc4_txp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index 42acac05fe47861ced226a4f64661f545e21ddb5..fef4e4ee47cf41d40de47c5201f0349dc36c56bd 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -377,7 +377,6 @@ vc4_txp_connector_detect(struct drm_connector *connector, bool force)
 static const struct drm_connector_funcs vc4_txp_connector_funcs = {
 	.detect = vc4_txp_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -601,10 +600,10 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 
 	drm_connector_helper_add(&txp->connector.base,
 				 &vc4_txp_connector_helper_funcs);
-	ret = drm_writeback_connector_init_with_encoder(drm, &txp->connector,
-							encoder,
-							&vc4_txp_connector_funcs,
-							drm_fmts, ARRAY_SIZE(drm_fmts));
+	ret = drmm_writeback_connector_init(drm, &txp->connector,
+					    &vc4_txp_connector_funcs,
+					    encoder,
+					    drm_fmts, ARRAY_SIZE(drm_fmts));
 	if (ret)
 		return ret;
 

-- 
2.39.5


