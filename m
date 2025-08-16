Return-Path: <linux-kernel+bounces-772123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E93B28F02
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094AA169CCB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F912FB99A;
	Sat, 16 Aug 2025 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P3Qlr/sA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667822F99AF
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357587; cv=none; b=l/DNhBgdSYT77XwmYpoLt76ZuXtI4+ZvLqKsjVJWK8HdUUed0BungNnIS7aVjUX+Pd48KF2/5DzRk2Hwkr+fWWL7hLTU7YKN7cSq8MGI1m2KF9Myo5w21lUul96l9WwQ5TP6TLIJKTmahNm0Ws/ekw+OcQP7+oIYft/DLbOl++I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357587; c=relaxed/simple;
	bh=FAStH94G7STx9dmih1BwY2moi+ekwJevO6V7oZLap5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qBgI0SvyEQ3xc8vSVATe5VyjeF2HhmsGf50PDtlGBst0A5BQRccR/pWDym3fjdoueZpr73vjpMUNLNNhM2V9xhXr2fLzdVEW3zXBWe+JxMUDPqOFmYccEsBinTKFkJzXmPBTe0hBa+lsr+2FCjdyZKWN8LNMMfYceBvYr2VSbNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P3Qlr/sA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57GDYF3d013020
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3LiTGbp3yrZlb6BdgcZ8Qpq6CDIhRX/Qyb9HMEmTyzM=; b=P3Qlr/sAPTtXhNia
	iUQgs6sum8tN8E2pMz7a8TWihY4KgSewQaxH/ZJfgrXZ/PY5pEOd6sL0FyqPO2ao
	EzUb0Qr0R7ABXtB4JPF6KXf+02/u1iWYhU1ZiW0IzksMzTKQEWmWU6u7bYQiY1FP
	TUgzSv4L4ouPTCNd2LzYsZ3B2DLER/+5SadEdM/kMAOlYLhN/irGfubf19o4irlz
	m5NxVwNbLFM7Hg46WPSVzwhrfhZsZk+fNN8A2tUNdN/QhtJ26TI5JVza39u4mAbG
	+cHMw1zhe0173LPmx0Ejm9D9WORqMv8135jgO6eE4GFLFLrgYQYKZLCxSuyjsIIW
	mW1kMQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjc7rsy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:19:44 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a9f5b078bso30247516d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755357583; x=1755962383;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LiTGbp3yrZlb6BdgcZ8Qpq6CDIhRX/Qyb9HMEmTyzM=;
        b=LUwNf4LUVGxSnxwkKh2ttwp82IxGt+qgieJ23pDHvnXU1TcBqrWHFrJz4ZdCGgMZr2
         po3n5lhdyF682Xz6uZPgANJPoLUzqtEgOGjSc7vLqjrOfXfYD6tPNjrlwP/V79kOavsU
         VVkWkF9x2hxQGsGm1j+aqMd1k6GKQl8M6MnAtufRAC08D69TIP7aG7Wl3U8wH5XUUNUk
         TmeWuM+YWlfMESKeQxGe8AzgsOjWefhAT2elVDJQ0CoTJMnKlYDTC2pb+rBdVF4fTplT
         SVktLAwMlu+Nb5YWZFFQYIdKJu3f0GbSIKkqYeMci+ildbxmmLORArZZHYmikpjhjHQr
         qmWA==
X-Forwarded-Encrypted: i=1; AJvYcCWK0ik14GblFK8aCiusjaRca/5OYSaRtciHqz8z3jMtGRKPuBFLmIs3yyOalimVkre6CNad4gmAKm3mmrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJQ1E/mpkOSYeFRVcmtyxBedEgtUkVBF4uw4eyOl/eCwhGOvsW
	CWf9Z0CzyJ++N13vUuTEYFWY/4CNRfoJJlq05BG86rm6t9rpbds2z80YTh15w0Phxxab2ZemRmx
	XA50oYrrGhtErcLihKL9J8LhmdaCR2TJ3R7MKnE+yl7HpTVlkoP6OGN4suuaDIhH2B7k=
X-Gm-Gg: ASbGncvejR+nhM92NXrH/EdxcJ5rhI/BUYF3zxSqx6Xj+GPhvv+v4A1LIw7qffQxyXI
	V/3gipFusAdia4VP4RFa0CB4FNWGRgALi2VzPpu8sddshtglRsj7vZVOWyXYs/pErbeWojB4Q56
	dnMLdz1v6u6DFPnMnPMwe4Zi0tOYZxJNEtgN6Xv7NRzbK72b6so47Gdl3O1CN63ofc0N6eR3Bbq
	K3SbAKhi5DR+NNPHca7SwhZ98mdf0OQidGaup0ZuE+9TuVuBER4o9+M9NgGo27qcJIkTkvzan6G
	/pmzM6qdZbUuefEcdrQJ9XHZu3k1tMjKop8Z4RaDDpE3AQBJOIo5dt4/QRqBnZpgu2ytJEITugw
	aJpTauCOfF58GINs0K6jqvgHkeeF+3M8zA0atN4oM9xKezoyi+wDr
X-Received: by 2002:a05:6214:2aae:b0:70b:6e6d:20a with SMTP id 6a1803df08f44-70ba788e6a4mr73534746d6.0.1755357583328;
        Sat, 16 Aug 2025 08:19:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX7AXYCBCRqrmrQsT1LQyM0jWdKsXIc3YtI6BivWlsRGdFHgTuLmmSZBXhNj3Yos1Vch68qQ==
X-Received: by 2002:a05:6214:2aae:b0:70b:6e6d:20a with SMTP id 6a1803df08f44-70ba788e6a4mr73534476d6.0.1755357582786;
        Sat, 16 Aug 2025 08:19:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35965fsm907579e87.37.2025.08.16.08.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 08:19:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 16 Aug 2025 18:19:36 +0300
Subject: [PATCH v2 2/8] drm/komeda: use drmm_writeback_connector_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-wb-drop-encoder-v2-2-f951de04f4f9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3013;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=FAStH94G7STx9dmih1BwY2moi+ekwJevO6V7oZLap5U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBooKGIUlMQQLFiAtbFNdCE7iTeLG5NXVUIOYxXM
 6vF5Guen5SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKChiAAKCRCLPIo+Aiko
 1fS5B/9UEdB+BuXCj2ytlEfQ6Knryb/dViwFtPKUeb5r+e7VL1yRxxxT2kglrR7LNYMiS8Ecly9
 LHIp7j3MT33mN8RC2G81OBI4OYtosKhm7rokBbqmIN41yeqq2u1bJMK8qMo2JqOiK9qcSM9vZ8r
 SPIxl7ppjQ6vU1W5glfl4pxwjQeQvE8Be1Bo6s94TZCPzc7eqIe0BBd6re6aID8AvZkrbDyYVWv
 weP+MlXsuCXqWcP/RTxNkuwcueGDhFU/SuaVfTwJr1pI3asqMrn0GD83quiimxOrlD7Y/6SLA8b
 unH5GSZVhqtU7/2VAXZm3fwx4gf23rPpFp6ql62lXHM9YY54
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX7DFmMfQbzxeB
 UoVcx0ZoKalaJ4OPNB6kfX2tObuhl68vrWVlG9twbSTo85pRMdXyVYj29Z8Fzc190+NR/ZqpRfl
 Yo8+u/j1x1MDwEJliPVPkM0MZPzZlbde/+iCJCkJmqNVh1i8MBCQFK6yV1rKHAKqBf8lhj9KX9g
 jWv71P/9SAZdo1xgWzeuRYNNIXvdW7ftRKgzPd58vK2TrA92DkHxV8ykJuse3GVvpUd5mEeS9rK
 3UY5pEjwGF85DpBTzsjQOYvFzpIsuYPeMSDyTxMIzmBpFLP7/Mav7ZtOI84SDsFcf/qmSEY3VYZ
 93IaDVn/xNiheXSeTrFcZ+RnhGhgtf88+WR4XxQvDa0XO5hEeoxdUU1v1iBSEUx6VXcbIAx/4qT
 Sumq9mKs
X-Authority-Analysis: v=2.4 cv=c4mrQQ9l c=1 sm=1 tr=0 ts=68a0a190 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=EE5oNXVUeA2ILyHCr4wA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: zw5EO0ymZV5eKc5GNyEKeuY6OJVcY49m
X-Proofpoint-ORIG-GUID: zw5EO0ymZV5eKc5GNyEKeuY6OJVcY49m
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
 .../drm/arm/display/komeda/komeda_wb_connector.c   | 30 ++++++++++++----------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 875cdbff18c9dc97e736049feaa8a1fe1bcc82ff..bcc53d4015f1f27181e977272cdcfa35e970fa62 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -5,6 +5,7 @@
  *
  */
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_managed.h>
 #include "komeda_dev.h"
 #include "komeda_kms.h"
 
@@ -121,17 +122,10 @@ komeda_wb_connector_fill_modes(struct drm_connector *connector,
 	return 0;
 }
 
-static void komeda_wb_connector_destroy(struct drm_connector *connector)
-{
-	drm_connector_cleanup(connector);
-	kfree(to_kconn(to_wb_conn(connector)));
-}
-
 static const struct drm_connector_funcs komeda_wb_connector_funcs = {
 	.reset			= drm_atomic_helper_connector_reset,
 	.detect			= komeda_wb_connector_detect,
 	.fill_modes		= komeda_wb_connector_fill_modes,
-	.destroy		= komeda_wb_connector_destroy,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
@@ -143,13 +137,15 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 	struct komeda_wb_connector *kwb_conn;
 	struct drm_writeback_connector *wb_conn;
 	struct drm_display_info *info;
+	struct drm_encoder *encoder;
+
 	u32 *formats, n_formats = 0;
 	int err;
 
 	if (!kcrtc->master->wb_layer)
 		return 0;
 
-	kwb_conn = kzalloc(sizeof(*kwb_conn), GFP_KERNEL);
+	kwb_conn = drmm_kzalloc(&kms->base, sizeof(*kwb_conn), GFP_KERNEL);
 	if (!kwb_conn)
 		return -ENOMEM;
 
@@ -165,11 +161,19 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 		return -ENOMEM;
 	}
 
-	err = drm_writeback_connector_init(&kms->base, wb_conn,
-					   &komeda_wb_connector_funcs,
-					   &komeda_wb_encoder_helper_funcs,
-					   formats, n_formats,
-					   BIT(drm_crtc_index(&kcrtc->base)));
+	encoder = drmm_plain_encoder_alloc(&kms->base, NULL,
+					   DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &komeda_wb_encoder_helper_funcs);
+
+	encoder->possible_crtcs = drm_crtc_mask(&kcrtc->base);
+
+	err = drmm_writeback_connector_init(&kms->base, wb_conn,
+					    &komeda_wb_connector_funcs,
+					    encoder,
+					    formats, n_formats);
 	komeda_put_fourcc_list(formats);
 	if (err) {
 		kfree(kwb_conn);

-- 
2.47.2


