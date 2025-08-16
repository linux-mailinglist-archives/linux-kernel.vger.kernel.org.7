Return-Path: <linux-kernel+bounces-772128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E948B28F0F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85871CC4F83
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118782FE594;
	Sat, 16 Aug 2025 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X5Gt1UWk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96F2FD1AD
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357592; cv=none; b=CvYNjCln5qAwVqvDkmZGwI8obTC3H5OFXVyLlk6sOo5+/mC7EicLtl1y35gTWnR4ZJS5ufxmqE+i4nZdU1TPnCBCOoJJBo3vzRBVejYLSvUKXvJx8NKSA8x3hpGd+t1k+lCTkv7rH41BRTZbxvOG2ZnhlO9felBJloKnr1qxSvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357592; c=relaxed/simple;
	bh=/fLUas0t6+pmOh4Lpow6ATkHgTqazIs0UqCL1npG8PE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NsLTDzdQRhafigjiC/zc1PB2QkVOqxZMmCKx1rRLtARF6iV7uAVx6o3RNoTkiy4QLKe2gEoM+LZFdfJMtVEn1UlGxrXil0I5m64mWmLom8I0WEsKXE8ykrqQtKex6ip6zk22IiCvzRocouoEfQWgoxXpQNbtANX+mUrj3r2s5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X5Gt1UWk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57GDbUWA029565
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qV+1O4itHxYPrihyEQKWirrQ3uqLooPtU+1YJ1+NTiI=; b=X5Gt1UWkBtIMJCFm
	C8L7MumhPmhoSG0JDTascQfKTI9hjhrhWUT6gbrN7YuPvnXR3pQr58i47YtlolQN
	M9404pODYFr7CzBpOICBjFPwepXwNswGlCBnmColodWNtAyZq4hzs+pl3ogNfW1B
	Io/VFH5qHPn8Udg6EQBqcsDBuFvhSkQ7tDwwZO4Rkx3N10j592iQjdPdOJdo4mJi
	JbwZTzPi0guL22dBHpQqI9VBC5u/2JMpBrd9evWVZ4EkZats8p970cEjfmK6BnTz
	zHr5v/oy9oNz1LO9J1K5KBBzMAnmEk8OU00Cj/P8XIbEGtcxNzGBH8cx2XShyKbj
	O1rWgw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jfbn92bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:19:50 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109c5457cso78918271cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755357589; x=1755962389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV+1O4itHxYPrihyEQKWirrQ3uqLooPtU+1YJ1+NTiI=;
        b=tkewUaF7CfQ8AQPKs9skoC1SJFUnk4Tz1mSCEPapLjIYNi1bNjWsJL2YcuRBUeBGBJ
         hTmnxrEzgpShh1MVMfm6uctfUjvexOwkEm/aRdvldbNt299mOIVPA+AMH5mkKD9H7nat
         EZUPLtkc1tqi7CleVmm314WiNNnHcarVvxmxP9kht2ZQD1NEvr/AKLaHJJ8DYoOu25rg
         LzuVP6HGTvTfpkwnze1QI6KAhSYQ53rwmoh83QSsmGNmkc44kBuu7f+SaJkDEDLlxlK+
         aYSZ80FXZrSWkBz/Z+e2iCwM22bcNhiCRp9yvcK7S39Mj3pyPW0btMoH8G/w1JwJWtO0
         K6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0MFelz7Dv2KwJnCoco0jBQ/ZmsX5KpI4Cvu1vfuQGsCZIIU6GhS8Mcb895/ex8cUp6cdcOKZI4in9igU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJr5G+8ViIEScO0Z5jQeUgNhrPjj65d4ANOhz3yUVqrosKi/kT
	qaZgpFyi008MQ22bABAewVEquyaEGdzPOCmcW82LxVYx61ntzfgV6Vi/GpN8Qh5VkAkOdzFR8an
	fGbFErNniMjkyzFtMAA+2wCG+YdCVSLOoodFLGXPQcafnbhlPgt+HBgWMCEvTGDasvV0=
X-Gm-Gg: ASbGnct+pFgLERLo5Hp/IOPvy7PfzGA2I/PcMomtMq//cMjdI0P/UJyq429H3PjAC/2
	C6QMjD08TMY85relGgxqqkKy3XXqII9txB/w28goJM5nd373TUJ0wj3v2t0Y1HrYaObvJyqXWci
	x0u1yb82FRtAiWuJi+COpv1CyAAOprvQuEyuueyaVzTHNUPKB+iPvfSsHJMGrWSRvq/lQXFPDod
	dHUhT9rhGz4ElGetZnSmTQVL2b3NUjboUIzdtOrHY7sUHQbjGgmexDmCX8YzBwh5pv4zurw23RV
	P6wTTJAB0LIG1p6FTOfFsqQK0gzViz87mCbHAn+w02aemMWyXpdgnvuzB0Kgo2mNXzarg8y156O
	rzVzfVHjggMpC/J4Nx+7KhGUxfszIc1msZrB+uIIlpKUn3wUZf02V
X-Received: by 2002:a05:622a:1803:b0:4b0:69ff:eb71 with SMTP id d75a77b69052e-4b11e05f86cmr89079281cf.1.1755357589305;
        Sat, 16 Aug 2025 08:19:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4j2k4YAYzpQ0pMCPbpzOT1o6CdrG9QkvoXk17IoZ7zfFypPLXZJtxqIY6aSy3p+i62FJnEA==
X-Received: by 2002:a05:622a:1803:b0:4b0:69ff:eb71 with SMTP id d75a77b69052e-4b11e05f86cmr89078721cf.1.1755357588831;
        Sat, 16 Aug 2025 08:19:48 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35965fsm907579e87.37.2025.08.16.08.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 08:19:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 16 Aug 2025 18:19:39 +0300
Subject: [PATCH v2 5/8] drm/msm/dpu: use drmm_writeback_connector_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250816-wb-drop-encoder-v2-5-f951de04f4f9@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2304;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/fLUas0t6+pmOh4Lpow6ATkHgTqazIs0UqCL1npG8PE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBooKGJrX/EOza+6SHDDyhh3b0F4k58JM15op7JC
 zsrf9qs2FKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKChiQAKCRCLPIo+Aiko
 1RPCB/9KsE7LBH2gz3/CuiP3n3VWw21nUSaR2KEoT3QNbRnJ3kkvF8BVfxyPCfMPXyL8GP8+X+W
 1eo7ACU/9lwfSLQKW1Gnv3ZPNYawwta+UR+hdHck6Lfeu+kPxKKOyqfVp+p+zVXa0SQ93cL/NEf
 JS8K/7gj1Mb0FMolDe1qPEfHsG8P8LPEiTcY1SzvEDp94WNhqZe/hngjRryF042P4d0Bj7worm4
 akTK/ST6rN9abWTt+MI51ZZc9SW1GkAGBQM6+yP9YItM403Q2JqK6zELkFGY5AXyQ8ICXLx+5Rb
 2lSOj6fPeztw3nIfRul5Iclrps8maUSX1XJImBsAqhNG89N4
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAwMSBTYWx0ZWRfX/LfpN/3hX26N
 aKMulf8oNLy9d6O9gbEB23Elj0r7SidKmnKuopdH/SyAkNqX0PLcRJZ+ewWWeVq6HLc8Hblsa1S
 StCZ0UvzLGVm+h+y2rSH8qXEZldD3b4wjPf49Biioc4E14T4mByMtfFnP1ft3PJX280lnmUXbXS
 g23UA5oYyPySlNW5LecRNUUUqURU/ymH7OcqlecubHWevyA/XU2LLUTZU1AMITTU6lQkdh5cvhV
 seK44QU1MqETNEeOk3G1inRAWlyk6Yf7QsEeXMIAk0//ru3siaxJhZ/74goNfrlJ5JOrVat4pj6
 te9DjOOZOgLpd/Rfh3ujp77evk1nQQxNnK6TIIeKrT+tRV+2pJypxKjOSliSOwBnpa7M8ZmTaU2
 7I8TVxJ5
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=68a0a196 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=mhD89yN676IZukTL2GQA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: WTGQYWdbGNEQRgP3bOGq5d2dE0imSEw4
X-Proofpoint-ORIG-GUID: WTGQYWdbGNEQRgP3bOGq5d2dE0imSEw4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160001

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


