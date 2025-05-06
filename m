Return-Path: <linux-kernel+bounces-636337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C17AACA09
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 17:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2DE982647
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 15:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04B2857DC;
	Tue,  6 May 2025 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uk4eiUPE"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273EB286400
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546540; cv=none; b=ChfHGWjk5nmKKmOXnj2ZPM2QBeSoEYdaLVdMrHNtWqSuMnrU/In822qjmbWHBn9GdC0wi2h/J788YdmsmFjJnguCDzLumPnTe1QLlALFVifQpTtvHvdE357n3x12keBEVzkBfGuxKj1qAf9HVEIgnR2L/jhlHwHbECiYJDjQ1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546540; c=relaxed/simple;
	bh=f0Tzfh1yvnaYbDUAZffu+djk3BGqZGIejxCDMBrBoL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eshm2e6oKhbgVCe2+TynbtoSVaf40tSN3VfbVMOVn2q7hAHSQcyMx5S5UIyRecyAoDMtY5kMUT95Mt0vD+23dW4c9ZIFbKRwSsmb8p8lsLdvxUVf7BhFa0yLu/IT3RksmwbnFFfvQbpLm8d9B5CyrFcG/Y4sfQQbRFIr6zBclQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uk4eiUPE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30332dfc820so6863380a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746546538; x=1747151338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqqAVPVcqIh+WPYUKatlQyVBY706HhXFBRkuhT+kys4=;
        b=Uk4eiUPE703dxvil83tq3lTygVOr92WGoXbuzX0Y5tc6MAfLnBC7x2uPWZkE5x9M+t
         tKS9agjogODFZucsaKYRzIHtvf+/fOosLM/pGhtKR+kTN7KPPj74idsiYYnCXmy7U2p4
         +aJWFBvU/XudYqOYfl7VC7ZNZkc0UlUVF48qybNhdsYScDwrV79JtJBf3HYrRi6t3Wps
         uUY1up7/p/4K9Pjerjq+b6Nr6/LpVkFV3Q7hiQJWcIHwMkFGQlK0Bb3EQ7+e7YdI5GDM
         8BZPIXCBxVlG+6RlNU+8BH1SX0OM+dNPTKII4caBLEaQ310f8/7l8zIPWygQuYHygBsF
         e5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746546538; x=1747151338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CqqAVPVcqIh+WPYUKatlQyVBY706HhXFBRkuhT+kys4=;
        b=loPsIjg6E11Qbv/UlJBWQbssAovIuUQS1WKByJ9ARA3vJEECIeCB0eMB1M3m71jCVU
         q2vbjXzVCesuDDEtwGn8AC2aFHk3Qe3MTWSD/ULclIaPkCqNX4sEVOsvRTUJteU/36KC
         pUU+c/m4zgx2mH8T3MFLwZOECKlRzkMTYW4RCA+6GoOTYW5f/9PIHV+xDah24OHpexTF
         uISga7js6YVxZp9wqvn5HkdA2lJvPhuSqYe1D5YtCB93xzoiAoukz4GlWyD3+POqYUt9
         94ye3aVb/hq2UJTUlQWtGOdtDzcRxBiBxi3cAKYuKoutWnrtaPbj3vy2BrMerZFWuStZ
         oVAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb4inTd4UL9Q3309kit0/LbVfwfsAGeMvedgUp3xzLriegcudFoNBTN9zbF9HzrIESIo78UYJ104UAkPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzNBP98L8ndiRXfU6GmdssrIsmt7rp2qSNQ7DCFb1Vl54vqzJK
	nWNFhiBG91A3qUoDV2ajYK3XINXlLhE2h/oBQY2u9KF6Ygshf4TlhdVPWNfj3O0=
X-Gm-Gg: ASbGncsqvmGAnj2mu7RPhADtg33S7WbAPok4VeO4RmsSG135rf870X8v+qxmtaq66wi
	ARjz3mo11+SLZUkyDy9IRGpsvnvXCCWHgYj7IZ8yf23te/QLnVlLFqttQ4Nyqh/asuc2wfdZJ3v
	ucX8+QGEHlGVcPapLszQnp7aonhydA+72Rjpnr84O8Op0r3IQufKwGqq92qE7jVKtn52pa6XpwH
	lnmjEJY7PvolUB2J+HDeKuIoeaV8VBvkCHmi/8NWBcLuNaQ5q3N+shPna9h/1Vlu37TyeTqluA9
	PopuoGr56c6tFBWwgWtlClhWWJqS0xvFDPV0Gw==
X-Google-Smtp-Source: AGHT+IFQ6oQjP2TFd+k/ScOw2oGpCqmcrR8DzKf0ZmDyiXBObn6veOhBHYO8aScsyaRSBQW3+yK/Eg==
X-Received: by 2002:a17:90b:2744:b0:2fe:b8b9:5aa6 with SMTP id 98e67ed59e1d1-30a800a11cfmr4005253a91.31.1746546538457;
        Tue, 06 May 2025 08:48:58 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a4748e83bsm11495999a91.22.2025.05.06.08.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 08:48:58 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Tue, 06 May 2025 23:47:39 +0800
Subject: [PATCH v9 09/14] drm/msm/dpu: split PIPES_PER_STAGE definition per
 plane and mixer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-quad-pipe-upstream-v9-9-f7b273a8cc80@linaro.org>
References: <20250506-quad-pipe-upstream-v9-0-f7b273a8cc80@linaro.org>
In-Reply-To: <20250506-quad-pipe-upstream-v9-0-f7b273a8cc80@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Dmitry Baryshkov <lumag@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746546456; l=5426;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=f0Tzfh1yvnaYbDUAZffu+djk3BGqZGIejxCDMBrBoL4=;
 b=o8LVJUxzJkYW3dVEzJjJmfMk4MM1cDBaXWmW3Mn/uo0cUQX5epjrKT7/DTpFoLI1CG5Jyj2aV
 2kiMf3Y/1ZrBIaiZzgtiU/gj0UwPJZ5ZKhtAHyOE2CfbrhhNnKTk/gG
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

The stage contains configuration for a mixer pair. Currently the plane
supports just one stage and 2 pipes. Quad-pipe support will require
handling 2 stages and 4 pipes at the same time. In preparation for that
add a separate define, PIPES_PER_PLANE, to denote number of pipes that
can be used by the plane.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  4 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c   | 14 +++++++-------
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h   |  4 ++--
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 6338603bf8be9fcc4324b098d5d69d20235cdbae..d710b4eec7ad946a4cf74d6ac5f4db90e8dcf1fd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -463,7 +463,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 		if (pstate->stage == DPU_STAGE_BASE && format->alpha_enable)
 			bg_alpha_enable = true;
 
-		for (i = 0; i < PIPES_PER_STAGE; i++) {
+		for (i = 0; i < PIPES_PER_PLANE; i++) {
 			if (!pstate->pipe[i].sspp)
 				continue;
 			set_bit(pstate->pipe[i].sspp->idx, fetch_active);
@@ -1272,7 +1272,7 @@ static int dpu_crtc_reassign_planes(struct drm_crtc *crtc, struct drm_crtc_state
 	return ret;
 }
 
-#define MAX_CHANNELS_PER_CRTC 2
+#define MAX_CHANNELS_PER_CRTC PIPES_PER_PLANE
 #define MAX_HDISPLAY_SPLIT 1080
 
 static struct msm_display_topology dpu_crtc_get_topology(
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index 8d820cd1b5545d247515763039b341184e814e32..b0ed41108a32158c0bc3be2e25fc229b218fd6c5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -34,6 +34,7 @@
 #define DPU_MAX_PLANES			4
 #endif
 
+#define PIPES_PER_PLANE			2
 #define PIPES_PER_STAGE			2
 #ifndef DPU_MAX_DE_CURVES
 #define DPU_MAX_DE_CURVES		3
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 4cb81a6a692be51d342d9a6f322b632e5fd07b2c..ea7e3fdf52f726737941ad33218a843dca17280b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1078,7 +1078,7 @@ static int dpu_plane_virtual_atomic_check(struct drm_plane *plane,
 		 * resources are freed by dpu_crtc_assign_plane_resources(),
 		 * but clean them here.
 		 */
-		for (i = 0; i < PIPES_PER_STAGE; i++)
+		for (i = 0; i < PIPES_PER_PLANE; i++)
 			pstate->pipe[i].sspp = NULL;
 
 		return 0;
@@ -1129,7 +1129,7 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
 	pipe_cfg = &pstate->pipe_cfg[0];
 	r_pipe_cfg = &pstate->pipe_cfg[1];
 
-	for (i = 0; i < PIPES_PER_STAGE; i++)
+	for (i = 0; i < PIPES_PER_PLANE; i++)
 		pstate->pipe[i].sspp = NULL;
 
 	if (!plane_state->fb)
@@ -1240,7 +1240,7 @@ void dpu_plane_flush(struct drm_plane *plane)
 		/* force 100% alpha */
 		_dpu_plane_color_fill(pdpu, pdpu->color_fill, 0xFF);
 	else {
-		for (i = 0; i < PIPES_PER_STAGE; i++)
+		for (i = 0; i < PIPES_PER_PLANE; i++)
 			dpu_plane_flush_csc(pdpu, &pstate->pipe[i]);
 	}
 
@@ -1363,7 +1363,7 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane,
 			&fmt->pixel_format, MSM_FORMAT_IS_UBWC(fmt));
 
 	/* move the assignment here, to ease handling to another pairs later */
-	for (i = 0; i < PIPES_PER_STAGE; i++) {
+	for (i = 0; i < PIPES_PER_PLANE; i++) {
 		if (!pstate->pipe[i].sspp)
 			continue;
 		dpu_plane_sspp_update_pipe(plane, &pstate->pipe[i],
@@ -1377,7 +1377,7 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane,
 
 	pstate->plane_fetch_bw = 0;
 	pstate->plane_clk = 0;
-	for (i = 0; i < PIPES_PER_STAGE; i++) {
+	for (i = 0; i < PIPES_PER_PLANE; i++) {
 		if (!pstate->pipe[i].sspp)
 			continue;
 		pstate->plane_fetch_bw += _dpu_plane_calc_bw(pdpu->catalog, fmt,
@@ -1396,7 +1396,7 @@ static void _dpu_plane_atomic_disable(struct drm_plane *plane)
 	struct dpu_sw_pipe *pipe;
 	int i;
 
-	for (i = 0; i < PIPES_PER_STAGE; i += 1) {
+	for (i = 0; i < PIPES_PER_PLANE; i += 1) {
 		pipe = &pstate->pipe[i];
 		if (!pipe->sspp)
 			continue;
@@ -1518,7 +1518,7 @@ static void dpu_plane_atomic_print_state(struct drm_printer *p,
 
 	drm_printf(p, "\tstage=%d\n", pstate->stage);
 
-	for (i = 0; i < PIPES_PER_STAGE; i++) {
+	for (i = 0; i < PIPES_PER_PLANE; i++) {
 		pipe = &pstate->pipe[i];
 		if (!pipe->sspp)
 			continue;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
index 052fd046e8463855b16b30389c2efc67c0c15281..18ff5ec2603ed63ce45f530ced3407d3b70c737b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h
@@ -33,8 +33,8 @@
 struct dpu_plane_state {
 	struct drm_plane_state base;
 	struct msm_gem_address_space *aspace;
-	struct dpu_sw_pipe pipe[PIPES_PER_STAGE];
-	struct dpu_sw_pipe_cfg pipe_cfg[PIPES_PER_STAGE];
+	struct dpu_sw_pipe pipe[PIPES_PER_PLANE];
+	struct dpu_sw_pipe_cfg pipe_cfg[PIPES_PER_PLANE];
 	enum dpu_stage stage;
 	bool needs_qos_remap;
 	bool pending;

-- 
2.34.1


