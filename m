Return-Path: <linux-kernel+bounces-719253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C039EAFABC4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 08:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB4517CA07
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 06:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D163E28725F;
	Mon,  7 Jul 2025 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOGZsyX/"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E32C27F4F5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 06:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751869168; cv=none; b=isDUEAJvV4off4mZKykCBLA5lepIYLC6x2+lUZ1RxDff1RwHZeXe2dl9hJonGZ7nymDjQpQ/3SYydfCQzr7BUKp2NdSpHj8B3O88tTU1i+5TmjMFXd85jIQtK2tiFBrgYxF0RfS3sLTuDdqsHSfnmu/2oNONFl/ePLQJQOHOH+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751869168; c=relaxed/simple;
	bh=L0RJjmTLlYkHLbKt8l66Y1ANmmW3YDpsTiGU9UI7WH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZsCV+NGiAHNQaw5Y6CnvzfenMPlQevLf8+jPDNJr/ELfqshKYqcH6WEMC7Qo19Ov74pu6PMjwb2pKWZ4uhLoSXr611IsVtLlWRYQyFsm+HcQhiQBzeBtfb4PKO7hmfcqL7CLqA3/Rd/fcW5K5wHQdqN1OdTGv6qj9S1ZsEPUVXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xOGZsyX/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74b52bf417cso1675404b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jul 2025 23:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751869165; x=1752473965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMyTzj0YkyEhVsWHYdHluPcgaxyf2WjhZvLWIgnb3dk=;
        b=xOGZsyX/ducggBaogV+PbPa6yKF50D1UnDl8I47nt3LY0MINIfyaFwG3bQB9OTYApy
         zhvZfA5pLPQ5bI0n27tkjTm/EcgSascDBzWIvI3e7X+BdR+tS/JizQc7W1YfMRnt2bW/
         ugT+gTpDB2TMyg/rqwGHRiUOSeVaQGDF13+S0IbNIr7LJQRiEWZRITpktIpXGiRPaG15
         fp+tAuLSZ2Z49jUbKjYQEoT6rJnEKYt5/LJPmyDfrQYxLeauE0TOtEcg6ei+zuHUhUcw
         UoA8L8S72CejAhY9T88q6K1vRc8CaooxEkJ4YYIHu6a2t351GDBUgJ5QSq+LCeB2j1Bt
         ILog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751869165; x=1752473965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMyTzj0YkyEhVsWHYdHluPcgaxyf2WjhZvLWIgnb3dk=;
        b=Yn5jpMr0MjPdEMEQhgZ46xbzX5RV0Dsqc+8VVsqFS+WP8m5WReKCeiqyT7tWcTc84w
         QYHfrCI7vYEP05MKRPNV2crv6t5YrXjhbZh+vUK08UkW6Nca38xp7FFZJ86VeQTZdBdv
         LfRgJrudSrBG5KpMpm10mBn5jvmgTQfD7v0s1pEAIGfX+Oi9tjLBBdL2+IRAaYhxoqpP
         N/SjQDLHXKvS5piOfVLyYHro4G1cf+5eiEoNki6bn2Hs+c/IIG7/5uG+kni8q6h1/Wsb
         W24r8OI7stP+ge6Y3HAnMTWN7ecomxapG/LT4GQwnHW6xao6foieB/lw1JBYLaORckBS
         9AWA==
X-Forwarded-Encrypted: i=1; AJvYcCUnbNCsYSl79m7O4kKIgMNDPR63etknfH1LK7/gyUVHcjfmBqIo89wbcDcDNzPAmHMjqHcZqOzUgFvl9ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxzO17rLyOXX3KPoH/ScSJ0FK+atilG0NSZEV0bLwLCmmp7b97
	5UTogqw0dogfzt9aYoM1C2iraCGpDj9Rnd4DxwcoJubZ2GRim9NaWt3KgFnEYPhkdVE=
X-Gm-Gg: ASbGncv/xEB89ycLMM/u13nzjURsHO/+cN8bu7V5nIqTZ0xBIw+KvNkVkXEI+Ncvh+/
	lBDU9urp/9rhD0AZZgkOKiohk9rooWSO+GGDx2FrjcYei/ExNYycvCpAzLWN3YUAQr/eBuoRs9j
	EwgWepXsqV94JsYSqFFJOOCINGeZdBDnz2Moayup6AYiUhL4THPmbFRjRI/J7q+q5/1lhEI2fw4
	BeCCdl7aJJaT09eCSBk9GfFGhxp87hTHdm8ULG7g4rKuxt/M0mqYDKJk0WsosyB3xqm/AjcPROz
	VyfnXoBakHjBkS5fgIibViAH6d895lyziZwbWHUUk//S0tljQApg70gdJTk=
X-Google-Smtp-Source: AGHT+IEU12CaXxRFm+sHW41+n2+mseLBZwKCCLTcs1c/9DFVXDPTSMwU6toKiR7kSiB7FPV5y993ww==
X-Received: by 2002:a05:6a20:158a:b0:21f:a883:d1dd with SMTP id adf61e73a8af0-225b7c28afamr18891176637.14.1751869165502;
        Sun, 06 Jul 2025 23:19:25 -0700 (PDT)
Received: from [127.0.1.1] ([103.163.156.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee450ccbsm8037327a12.3.2025.07.06.23.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 23:19:24 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 07 Jul 2025 14:18:07 +0800
Subject: [PATCH v12 12/12] drm/msm/dpu: Enable quad-pipe for DSC and
 dual-DSI case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-v6-16-rc2-quad-pipe-upstream-v12-12-67e3721e7d83@linaro.org>
References: <20250707-v6-16-rc2-quad-pipe-upstream-v12-0-67e3721e7d83@linaro.org>
In-Reply-To: <20250707-v6-16-rc2-quad-pipe-upstream-v12-0-67e3721e7d83@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>, Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751869084; l=8147;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=L0RJjmTLlYkHLbKt8l66Y1ANmmW3YDpsTiGU9UI7WH8=;
 b=4G4XLLDvYSxavjmhXhXI6JvaYsyJkCW8y61FOU7WvLpblEPUuJjZ4upWl0ANtM+iL2D+pvWWk
 HDjrebhNaRRBKuIxR20QVG2Xav7C2YuK8L0R7QmTrTPpUKV0AnhQVNe
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

To support high-resolution cases that exceed the width limitation of
a pair of SSPPs, or scenarios that surpass the maximum MDP clock rate,
additional pipes are necessary to enable parallel data processing
within the SSPP width constraints and MDP clock rate.

Request 4 mixers and 4 DSCs for high-resolution cases where both DSC
and dual interfaces are enabled. More use cases can be incorporated
later if quad-pipe capabilities are required.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c         | 27 +++++++++++++++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h         |  6 ++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c      | 28 ++++++++----------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h   |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h      |  2 +-
 6 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 1c7a5e545745320018c3e9a2d163cbfd3dceaf7b..2625ad777e477d2d5a6a746989bb9e10493e19ad 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -200,7 +200,7 @@ static int dpu_crtc_get_lm_crc(struct drm_crtc *crtc,
 		struct dpu_crtc_state *crtc_state)
 {
 	struct dpu_crtc_mixer *m;
-	u32 crcs[CRTC_DUAL_MIXERS];
+	u32 crcs[CRTC_QUAD_MIXERS];
 
 	int rc = 0;
 	int i;
@@ -1328,6 +1328,7 @@ static struct msm_display_topology dpu_crtc_get_topology(
 	struct drm_display_mode *mode = &crtc_state->adjusted_mode;
 	struct msm_display_topology topology = {0};
 	struct drm_encoder *drm_enc;
+	u32 num_rt_intf;
 
 	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask)
 		dpu_encoder_update_topology(drm_enc, &topology, crtc_state->state,
@@ -1341,11 +1342,14 @@ static struct msm_display_topology dpu_crtc_get_topology(
 	 * Dual display
 	 * 2 LM, 2 INTF ( Split display using 2 interfaces)
 	 *
+	 * If DSC is enabled, try to use 4:4:2 topology if there is enough
+	 * resource. Otherwise, use 2:2:2 topology.
+	 *
 	 * Single display
 	 * 1 LM, 1 INTF
 	 * 2 LM, 1 INTF (stream merge to support high resolution interfaces)
 	 *
-	 * If DSC is enabled, use 2 LMs for 2:2:1 topology
+	 * If DSC is enabled, use 2:2:1 topology
 	 *
 	 * Add dspps to the reservation requirements if ctm is requested
 	 *
@@ -1357,14 +1361,23 @@ static struct msm_display_topology dpu_crtc_get_topology(
 	 * (mode->hdisplay > MAX_HDISPLAY_SPLIT) check.
 	 */
 
-	if (topology.num_intf == 2 && !topology.cwb_enabled)
-		topology.num_lm = 2;
-	else if (topology.num_dsc == 2)
+	num_rt_intf = topology.num_intf;
+	if (topology.cwb_enabled)
+		num_rt_intf--;
+
+	if (topology.num_dsc) {
+		if (dpu_kms->catalog->dsc_count >= num_rt_intf * 2)
+			topology.num_dsc = num_rt_intf * 2;
+		else
+			topology.num_dsc = num_rt_intf;
+		topology.num_lm = topology.num_dsc;
+	} else if (num_rt_intf == 2) {
 		topology.num_lm = 2;
-	else if (dpu_kms->catalog->caps->has_3d_merge)
+	} else if (dpu_kms->catalog->caps->has_3d_merge) {
 		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
-	else
+	} else {
 		topology.num_lm = 1;
+	}
 
 	if (crtc_state->ctm)
 		topology.num_dspp = topology.num_lm;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
index 6eaba5696e8e6bd1246a9895c4c8714ca6589b10..455073c7025b0bcb970d8817f197d9bcacc6dca5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.h
@@ -210,7 +210,7 @@ struct dpu_crtc_state {
 
 	bool bw_control;
 	bool bw_split_vote;
-	struct drm_rect lm_bounds[CRTC_DUAL_MIXERS];
+	struct drm_rect lm_bounds[CRTC_QUAD_MIXERS];
 
 	uint64_t input_fence_timeout_ns;
 
@@ -218,10 +218,10 @@ struct dpu_crtc_state {
 
 	/* HW Resources reserved for the crtc */
 	u32 num_mixers;
-	struct dpu_crtc_mixer mixers[CRTC_DUAL_MIXERS];
+	struct dpu_crtc_mixer mixers[CRTC_QUAD_MIXERS];
 
 	u32 num_ctls;
-	struct dpu_hw_ctl *hw_ctls[CRTC_DUAL_MIXERS];
+	struct dpu_hw_ctl *hw_ctls[CRTC_QUAD_MIXERS];
 
 	enum dpu_crtc_crc_source crc_source;
 	int crc_frame_skip_count;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 4616b360812491afbe63f8ffd4a57bc9604382e7..d13eeb3a707e186faec67ec02a634c14414d9048 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -55,7 +55,7 @@
 #define MAX_PHYS_ENCODERS_PER_VIRTUAL \
 	(MAX_H_TILES_PER_DISPLAY * NUM_PHYS_ENCODER_TYPES)
 
-#define MAX_CHANNELS_PER_ENC 2
+#define MAX_CHANNELS_PER_ENC 4
 #define MAX_CWB_PER_ENC 2
 
 #define IDLE_SHORT_TIMEOUT	1
@@ -675,22 +675,12 @@ void dpu_encoder_update_topology(struct drm_encoder *drm_enc,
 
 	dsc = dpu_encoder_get_dsc_config(drm_enc);
 
-	/* We only support 2 DSC mode (with 2 LM and 1 INTF) */
-	if (dsc) {
-		/*
-		 * Use 2 DSC encoders, 2 layer mixers and 1 or 2 interfaces
-		 * when Display Stream Compression (DSC) is enabled,
-		 * and when enough DSC blocks are available.
-		 * This is power-optimal and can drive up to (including) 4k
-		 * screens.
-		 */
-		WARN(topology->num_intf > 2,
-		     "DSC topology cannot support more than 2 interfaces\n");
-		if (topology->num_intf >= 2 || dpu_kms->catalog->dsc_count >= 2)
-			topology->num_dsc = 2;
-		else
-			topology->num_dsc = 1;
-	}
+	/*
+	 * Set DSC number as 1 to mark the enabled status, will be adjusted
+	 * in dpu_crtc_get_topology()
+	 */
+	if (dsc)
+		topology->num_dsc = 1;
 
 	connector = drm_atomic_get_new_connector_for_encoder(state, drm_enc);
 	if (!connector)
@@ -2179,8 +2169,8 @@ static void dpu_encoder_helper_reset_mixers(struct dpu_encoder_phys *phys_enc)
 	struct dpu_hw_mixer_cfg mixer;
 	int i, num_lm;
 	struct dpu_global_state *global_state;
-	struct dpu_hw_blk *hw_lm[2];
-	struct dpu_hw_mixer *hw_mixer[2];
+	struct dpu_hw_blk *hw_lm[MAX_CHANNELS_PER_ENC];
+	struct dpu_hw_mixer *hw_mixer[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_ctl *ctl = phys_enc->hw_ctl;
 
 	memset(&mixer, 0, sizeof(mixer));
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
index 61b22d9494546885db609efa156222792af73d2a..09395d7910ac87c035b65cf476350bf6c9619612 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
@@ -302,7 +302,7 @@ static inline enum dpu_3d_blend_mode dpu_encoder_helper_get_3d_blend_mode(
 
 	/* Use merge_3d unless DSC MERGE topology is used */
 	if (phys_enc->split_role == ENC_ROLE_SOLO &&
-	    dpu_cstate->num_mixers == CRTC_DUAL_MIXERS &&
+	    (dpu_cstate->num_mixers != 1) &&
 	    !dpu_encoder_use_dsc_merge(phys_enc->parent))
 		return BLEND_3D_H_ROW_INT;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index a78bb2c334e30bc86554bde45355808b790c6235..ce0265c13e050fbd48ac5c3202e8fa23edd1220d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -24,7 +24,7 @@
 #define DPU_MAX_IMG_WIDTH 0x3fff
 #define DPU_MAX_IMG_HEIGHT 0x3fff
 
-#define CRTC_DUAL_MIXERS	2
+#define CRTC_QUAD_MIXERS	4
 
 #define MAX_XIN_COUNT 16
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index e4875a1f638db6f1983d9c51cb399319d27675e9..5cedcda285273a46cd6e11da63cde92cab94b9f4 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -34,7 +34,7 @@
 #define DPU_MAX_PLANES			4
 #endif
 
-#define STAGES_PER_PLANE		1
+#define STAGES_PER_PLANE		2
 #define PIPES_PER_STAGE			2
 #define PIPES_PER_PLANE			(PIPES_PER_STAGE * STAGES_PER_PLANE)
 #ifndef DPU_MAX_DE_CURVES

-- 
2.34.1


