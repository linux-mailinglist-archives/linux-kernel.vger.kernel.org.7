Return-Path: <linux-kernel+bounces-776491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EA5B2CE15
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCAE582B90
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF47322A00;
	Tue, 19 Aug 2025 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hkRl9LDi"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F643343D98
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755635599; cv=none; b=a2MVkwLdK4fyEUVdkdLPXgJYR3RHgI+ukDdapcaegWooMZMu2er/qFkr3CcAiLxrflYgFoX2pVrzvbOqPYz99nMOfz2GjLYO8o4u2uvVHud8PcSITpkb5OaDUl8mjqhLnRk6iQY0FHcIbf8vlKOPvvUiLk4WTL9HAuoT8kQueag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755635599; c=relaxed/simple;
	bh=Tfx7muI07rte1gs226Q+hRYOArvmNBAMe2ZWuhmuISI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZKQflskcPWQows4ZsH+jeGq0/0kOwJKIj0ZeBHOwpBE1ZFDCRM8AJi2tsICLNAMVITtGQqSzmXNFXVnzh+wKsI33kv7UtHK1t/GfvJXces5+weCzOWGZ6Hnb73ofNso3Mu5yGOMaqFa6RixOWLwp5npfGqNOM8jDbF0uLJWjZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hkRl9LDi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHd5LL030474
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jvX092/V9dwE/NzPX2FObQHrrP1GpzHfFltQW2JSWGY=; b=hkRl9LDiymd2qGpZ
	Cbw4FW2f9rJF0wEieQzqe8TG+Ys7gFFG0JZaGsKgR0sfPf77GWV7Nm8yaraOwlyH
	Kq6tr1C9+J5z2Ty4C/sqb9rtyrRIeFQcmlK3zTL9Na3RYWLHpncroFVikj5Rh5nY
	6FM8FFtpTX8kcdOW6Vb8l4gUCDCOvGmjFPioVnU6l37NjsUmAbJji9+PelgXAjUi
	w4Q9mQ9PRYgWdsLoc5GumltwCBTYnkp5rqgjh7iwial7dBsaaY/N0WqAGiGilQdU
	/tGqZ0doGVxCYSBZR1mQ8DU6SReReQ0PKMsCwCQ8RErzO49Wwau9JMrCMqYriOeI
	YxdHoQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyunx4n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:33:16 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a9f6346f8so123345066d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755635595; x=1756240395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvX092/V9dwE/NzPX2FObQHrrP1GpzHfFltQW2JSWGY=;
        b=LbWz91ORLvG4Cm0xrEIoPK3lNvyVVD1t/oi9p1aZpqozGLBzMZY0NrIhfc1gSx9WVp
         uhmxGTe1QBHwCVy1B/CKghZOpoAcilNjtwYfAlbftEaI+aSRFiNO8Ga10b9X+0VvRHwh
         oh4uRgJau8h+JjkSClPcus3XPbFQuUrC6WY0w/oheYKnJeyzaG6QRH8ym9GLLFCk7uII
         +4QWljKGe20FBJfdSZY4qSyNaWqyrqSbArZKQBoNJvK7MXNJ2kFdhtHZFDoKv1V7zaEL
         b/3hiLbi0uSpjSPE8vUrJE+po+Zau3SjQBrvy2euGmV6Kg0Y6UESO/6Ro3omVSeHJaND
         crJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeAIxZwUo+pHAygz4v+egt1Nw7skZOSC/djrtLHX7+vbWMy6a4XZQvIKwR1dMijq32RqccXWrfpX3FcUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuEYgq/1ZtKL2Oj/g1SzIyeusrmOESMJRwbiGEj8XNuaxBYOVz
	pj17GZPsHO0bFbiQmiarvQ+UEfchbV6rRusdYRMyGbO8uV83Jl2jrlLb0xAHhq6aLBEfSgNOX9c
	nzhlEN1ufdL7I9FqTFs/bZfL09rsAtSsJWkXADlN9lafoi4p+ZyzpAZCV4NYNfWamMYA=
X-Gm-Gg: ASbGnctNnQmeTbw78bcR045+mTD3MU8eLUWPNe1lj05kOxCixj3yElBOXn+Z4llJI5a
	3N4HYf8oVITtM4m4cpAzffjv1Gi8C1h+2T2azJZPdKiPv7noXo3G3eAQQrNZksQzxj+7d+i7eem
	wt2jyGRjtA39U001gtstdAzDHgKu3XLTKjr5nybJ8LL2j5NhO59sck+9d5j3MhQqxifdbAkDgNH
	yydP9YY/TxGPIFUcEF6CwR/kwG7Q56Q6Y7Nke5aIg2ikUcnyDXwJI9y4A6b/Pz/A0OcVaQV0/Wl
	/pJr5lAQcBOfRyXTkybvlmB9fwR1KtLC8gPdu3LHPrdr4HptvZcUk8LfrtvXyMPm4qIczcXfQMz
	lmhlhv5z1yK2KjRPOMw9pFftjj8P+DGE6nqIG4ubKkLmrsyB4/ILf
X-Received: by 2002:a05:6214:e41:b0:70d:6de2:50cd with SMTP id 6a1803df08f44-70d77151247mr4493986d6.58.1755635595120;
        Tue, 19 Aug 2025 13:33:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9xDEb9rwYCS8WqAgM9AnhKQP8F/GYNkS59+4ktlhzxroNIvOhQps/yxg6kZP/FfKY8Ql/4A==
X-Received: by 2002:a05:6214:e41:b0:70d:6de2:50cd with SMTP id 6a1803df08f44-70d77151247mr4493396d6.58.1755635594371;
        Tue, 19 Aug 2025 13:33:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef351806sm2212969e87.13.2025.08.19.13.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 13:33:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 23:33:01 +0300
Subject: [PATCH v3 7/8] drm: writeback: drop excess connector
 initialization functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-wb-drop-encoder-v3-7-b48a6af7903b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4592;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Tfx7muI07rte1gs226Q+hRYOArvmNBAMe2ZWuhmuISI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBopN9947PbKAu+7+CUIfGx9WMCXm/z1B78epETI
 hPM199Q9DuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKTffQAKCRCLPIo+Aiko
 1RGOB/wNXkcFoxuLAJNkeEum/4zloQY+WG6CED7BLahxiCH2kQfFQcxOuvNWMMXaEqDQL216LeB
 ZbOWSqy6HJ00dZsO1O7ipqK579LQ2XUJM9JlHUUL5y8NLvDuuUM1EKCuQj3zWwYEohl48fG1V4u
 CNoWUsQx7aLwvlokBWFasOGAN5IcJJ9+fg2SzVYvrV/GyXVlnUiNQnswjOEaFmEeWw1xN2a+5Uk
 l563zrlaIZwEhnOsazuHd9AvOzqe6Kia26+XvPFLL0G5M6Y9B4ADOhKRUWcVskHr+k/Kz+mHAPc
 k6+bOvRAGUKJIFEgKO3F8YUgxmulZrA6UIchfRB4kSFKOWt0
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: fQS4ttiAxqDfyxP_tTmD2LP8XnVtojXU
X-Authority-Analysis: v=2.4 cv=N6UpF39B c=1 sm=1 tr=0 ts=68a4df8c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=3owybDqXPaZAjLikVYcA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA3MSBTYWx0ZWRfXxuh+XL2s1u+X
 OxGu1KUa6AXhJj1ggNWuXBc2BqOgKsCeGW3lQZFYk3wcCr8J6Wuuel4FVh2lY6rorfI+MTdpVtp
 nuGbEy58HIk6urrlwablz9XN1ngrfPLg+7ntWhNi2DfgraG77hEqFaVpr2BMNaiOOJsxG4ZwVrR
 0lIpSj1C6l9lPGp81PCvodT1q6ZMZNDqdi5tng/VuQHheq/rckomaUXuHGb+3BE7b80kTBK1nGk
 XAKGbXRl5hgMOTQRQdiOeGNkevgShrTcPlZo3oalPWR62FhHlyIy8Hk4tuZGRDEa6BTBFsLJMFr
 9Qt4a+iO79GuBqOXutgOWvdETv3DLk+9TOuXEI2jhshSKTF47s/qHJfua8GdWALslG7l5lII8EH
 kdtJlQ8B
X-Proofpoint-ORIG-GUID: fQS4ttiAxqDfyxP_tTmD2LP8XnVtojXU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180071

Now as all drivers have been converted to
drmm_writeback_connector_init(), drop drm_writeback_connector_init() and
drm_writeback_connector::encoder field, they are unused now.

Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/drm_writeback.c | 55 -----------------------------------------
 include/drm/drm_writeback.h     | 18 --------------
 2 files changed, 73 deletions(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 95b8a2e4bda69230591b50be15d14d0b3692373b..1a01df91b2c5868e158d489b782f4c57c61a272c 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -142,61 +142,6 @@ static int create_writeback_properties(struct drm_device *dev)
 	return 0;
 }
 
-static const struct drm_encoder_funcs drm_writeback_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
-/**
- * drm_writeback_connector_init - Initialize a writeback connector and its properties
- * @dev: DRM device
- * @wb_connector: Writeback connector to initialize
- * @con_funcs: Connector funcs vtable
- * @enc_helper_funcs: Encoder helper funcs vtable to be used by the internal encoder
- * @formats: Array of supported pixel formats for the writeback engine
- * @n_formats: Length of the formats array
- * @possible_crtcs: possible crtcs for the internal writeback encoder
- *
- * This function creates the writeback-connector-specific properties if they
- * have not been already created, initializes the connector as
- * type DRM_MODE_CONNECTOR_WRITEBACK, and correctly initializes the property
- * values. It will also create an internal encoder associated with the
- * drm_writeback_connector and set it to use the @enc_helper_funcs vtable for
- * the encoder helper.
- *
- * Drivers should always use this function instead of drm_connector_init() to
- * set up writeback connectors.
- *
- * Returns: 0 on success, or a negative error code
- */
-int drm_writeback_connector_init(struct drm_device *dev,
-				 struct drm_writeback_connector *wb_connector,
-				 const struct drm_connector_funcs *con_funcs,
-				 const struct drm_encoder_helper_funcs *enc_helper_funcs,
-				 const u32 *formats, int n_formats,
-				 u32 possible_crtcs)
-{
-	int ret = 0;
-
-	drm_encoder_helper_add(&wb_connector->encoder, enc_helper_funcs);
-
-	wb_connector->encoder.possible_crtcs = possible_crtcs;
-
-	ret = drm_encoder_init(dev, &wb_connector->encoder,
-			       &drm_writeback_encoder_funcs,
-			       DRM_MODE_ENCODER_VIRTUAL, NULL);
-	if (ret)
-		return ret;
-
-	ret = drm_writeback_connector_init_with_encoder(dev, wb_connector, &wb_connector->encoder,
-			con_funcs, formats, n_formats);
-
-	if (ret)
-		drm_encoder_cleanup(&wb_connector->encoder);
-
-	return ret;
-}
-EXPORT_SYMBOL(drm_writeback_connector_init);
-
 static void delete_writeback_properties(struct drm_device *dev)
 {
 	if (dev->mode_config.writeback_pixel_formats_property) {
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index c380a7b8f55a3616fa070c037d5cc653b0061fe6..879ca103320cc225ffb3687419088361315535fc 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -24,17 +24,6 @@ struct drm_writeback_connector {
 	 */
 	struct drm_connector base;
 
-	/**
-	 * @encoder: Internal encoder used by the connector to fulfill
-	 * the DRM framework requirements. The users of the
-	 * @drm_writeback_connector control the behaviour of the @encoder
-	 * by passing the @enc_funcs parameter to drm_writeback_connector_init()
-	 * function.
-	 * For users of drm_writeback_connector_init_with_encoder(), this field
-	 * is not valid as the encoder is managed within their drivers.
-	 */
-	struct drm_encoder encoder;
-
 	/**
 	 * @pixel_formats_blob_ptr:
 	 *
@@ -148,13 +137,6 @@ drm_connector_to_writeback(struct drm_connector *connector)
 	return container_of(connector, struct drm_writeback_connector, base);
 }
 
-int drm_writeback_connector_init(struct drm_device *dev,
-				 struct drm_writeback_connector *wb_connector,
-				 const struct drm_connector_funcs *con_funcs,
-				 const struct drm_encoder_helper_funcs *enc_helper_funcs,
-				 const u32 *formats, int n_formats,
-				 u32 possible_crtcs);
-
 int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
 				struct drm_writeback_connector *wb_connector,
 				struct drm_encoder *enc,

-- 
2.47.2


