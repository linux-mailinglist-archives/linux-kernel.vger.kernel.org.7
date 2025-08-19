Return-Path: <linux-kernel+bounces-776489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7A9B2CE14
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D454E58C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD6C343D97;
	Tue, 19 Aug 2025 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bFhsWMUV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D56340DAE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755635596; cv=none; b=NE8Z8rLkARPjdixGLtqT7q4ir54g3qncLUePPSUZM/71pDfc8Yxo46tDEitmq6mD7y+RSu8eeSgKlkhZCzAIwoxYEpTL2D6LeeY70mPy0sk0mgyL5eXCZbf50Z4NBjZZKwTwPTig+T/K44AZhFounCjHpFAEBsKRAv7uysj7wSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755635596; c=relaxed/simple;
	bh=/fLUas0t6+pmOh4Lpow6ATkHgTqazIs0UqCL1npG8PE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iQiol4PgVVBBN1evh03bFOGkSfUpdfZMndA86rB6RTq3/faBbGpljtSEpRdDfIri/GqI2edPrxqFA9EriYwpEU4bADfM1OepYetbuCcKNZcAHrUBRCmAybatlQDycRVY4p0Iu6BXCNt8XoJ+bflurNJC3s2G8n2StKpSRHIFE5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bFhsWMUV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHFFps008279
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qV+1O4itHxYPrihyEQKWirrQ3uqLooPtU+1YJ1+NTiI=; b=bFhsWMUVsK/mgqrG
	NSHunI1XmlSLZElpNwvyRiwZ/3mr5cI5bLIb1UdAw8uev1a4V5yaOTBLATlcDjlo
	W6T2VMXL2ko8M0yuICaEq3v0kpOrPxbN+up8MuHWL6BORh49znwHpRqIRtEx1mDc
	Q6cEZwHXvWMCRPEBCjTph0OTdUlQGHZihunQzqU6FywZhRRDCD4biEmpLD5B/rOu
	1V4uzyP2u4Aki5+U6rZL/RzVEMNqvk82YODQUSK8pF0jMFx1zxqkq7b1qgiBgMOn
	zJaJnoJhF0utusTDfKMs7NoYxNWPE7UkQQoinG1T6hTc7q4t+al2Yt7fkJCIMBba
	D7heoQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk99svfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:33:13 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f5b078bso62492036d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755635592; x=1756240392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV+1O4itHxYPrihyEQKWirrQ3uqLooPtU+1YJ1+NTiI=;
        b=lQPFuHOpb7SdIjiNdvSeXo8fj5ROtiMxVbgBiInYCPZJ2IaYX/yQD2eynGJqpDa7gH
         +7rIG2JE4A/u4IXn86ZNaPFSer5DyLM4IWTQw8vQP7TXEbbdcckIuy0TPPlSeg4qLAlo
         m9vlqGKfD3QOti39M+ieFxrKJd1nw7CEwY4XkLphzmvQyro46p7uXXqz8BSMMBDL+roB
         3D1MLfiU8aKUHt96+fuIYAkgdCxA1GLC0+xOa4NrSOsIxgdA93Pahge5y3bzm4/Coq25
         1joTWElK3aAtwy/G4ef/2Pe5UFZ4sKNOUINmdQznvqq+4NxNLTJ4xNvkU4NxvF+Rzte3
         JPAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtwxNx1G0L5PPeww/bPreXjc39j4PXOxnqISIpCL8ooca3OXXc6kFtSRJeD9wOLHlkWAsf1E1IcSBv4/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQXCi+eDG0msf9sYrRhsHipbn5mVOt1AsSGJF5JUtynuOg+7HF
	gN93TT+vyVif+lOdReHC7UXoYLrEOMQBOSxwGxklynRrx5P7dyazu1QSANngi2JIZFp+7irxMob
	kuvgEpaFQAYEp2HMyNJtXEnPrH9fG7npseryQagmgPARGb981iTq9jFtKabe2MXiJWk4=
X-Gm-Gg: ASbGnctmBo7LU9nI2nZ1gYuUXVU4apT9LPLN/OZq+3N0lJi3TYgWpkzRLFVPtwCSYyK
	N8FlLj1HmmewE5/BdAZT0QKXEzK3mcBuMALdt3otbxS1zBH5Vh6vo8aQj07B9v4lm76FnGczvkK
	2YJM90iqpJnhGFkWUDbRJZ9e5HLIrm8GOkalmQr8cNy7kotp+bEGaytObZ1jrOnjJ9XAoufb7f2
	4RVo7GiYgUEQqvy1aoCgiRvcA7rueY2GwVKjcq3fDOXrjxgHKfLLRge7lc5wKDsRkU6VGYk6Xf+
	TyBYzUXJ9JH5UFlS7vPYz0vu6xXvzz3qGTWdx4n3AoP+LkJv56GnHI/sRe7KxmgLfHCe0Jj7u5a
	fUVgNXMP+kyH2/kRkHpF+huE3okfJ/be9/XP4KXiEiluUecCenzGp
X-Received: by 2002:a05:6214:f2c:b0:709:bc45:b9f7 with SMTP id 6a1803df08f44-70d76f57943mr5196596d6.14.1755635592226;
        Tue, 19 Aug 2025 13:33:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDKziY91eNkFu9vLBSCg4AutRFh33SncxQFOgdnIxYVcxqqICtOLRE8iLeaVF2g0WJIIGjAA==
X-Received: by 2002:a05:6214:f2c:b0:709:bc45:b9f7 with SMTP id 6a1803df08f44-70d76f57943mr5195916d6.14.1755635591529;
        Tue, 19 Aug 2025 13:33:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef351806sm2212969e87.13.2025.08.19.13.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 13:33:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 23:32:59 +0300
Subject: [PATCH v3 5/8] drm: renesas: rcar-du: use
 drmm_writeback_connector_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-wb-drop-encoder-v3-5-b48a6af7903b@oss.qualcomm.com>
References: <20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com>
In-Reply-To: <20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2304;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/fLUas0t6+pmOh4Lpow6ATkHgTqazIs0UqCL1npG8PE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBopN98epbohhlNRN+h1NEK1xOyQcbh7iWhPdJwQ
 SZcAvaENneJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKTffAAKCRCLPIo+Aiko
 1bc7B/92b1GUfl19mLZdEdSZGXv/W6zvpY2/xRH/vjYXBUUv3SeYkNDpWGIJYROMyeOMzlycp0t
 99NiJcVMQjHVA9trbZTbH2fW5xaxO9f2xrJEiQI1dGEDFh5gnRoB4crRkxVTZ4um6S/atfDU271
 6TMvCy1ix69lUxiKHMicdLVMUhrFcQZOqKEjZ6ZsuEFxw7QP2lR4k1YTbAiQvvheHYuoUqQKxhO
 2dPVz0uaYuzwXYgBK1DtPqxj7JW2d2/YLaeMirNINj3QRZpAf4MDcQojRSJ7ALdp4yatPvOIFx3
 b5mdkvmeWroQkwwNhePwPDJItO+iuBw34yibnRlo48wTJ9Xr
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: 2Ub275XfgmA6Ld3hf5kgTivLbDorykQl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0NSBTYWx0ZWRfX/XN7I/nBXMRB
 WAMnCfd1yGbRF7X/v8JlRad/97D7KxUvSoZnp1OSe9V2SH3oH54k88pxQHoypHL0i6raqEQh7Pp
 A+IfusBj+YwZ9LGI7nneS8CrjClhJ5Cy66B11iQ1VNetwjHrv+kjXixRDVS3e8rBjFGHUQgEOkx
 tcNZzYtAslxoTjHFkLwqOLYLY8UtO+RhTUkai8rx6PuLjbVDBEyFDookS7Vz4HSR4nN8yaWrl28
 YLSwmp+4U6EUgTbcU5xQ2gXmqZRrdyZbfy47nDBNfqgNACDE/2PHmcr54wP900810m9MPc7935i
 CsPgybeyjg2DHMgq7VOkK/ny+PacoK+TyeqJkVRUxpWY1nbrHls5iRmGxEfSlppXat2G5bwqxa/
 RahExa4r
X-Authority-Analysis: v=2.4 cv=IIMCChvG c=1 sm=1 tr=0 ts=68a4df8a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=mhD89yN676IZukTL2GQA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 2Ub275XfgmA6Ld3hf5kgTivLbDorykQl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160045

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 23 +++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
index 8cd37d7b8ae281cbc1fd8cbb243c621174517e23..64cea20d00b38861e22fc53375ab41ae988ceb59 100644
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
+	encoder->possible_crtcs = drm_crtc_mask(&rcrtc->crtc);
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
2.47.2


