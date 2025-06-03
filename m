Return-Path: <linux-kernel+bounces-671401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A5FACC0FE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 09:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C94189051D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 07:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BA326AAB5;
	Tue,  3 Jun 2025 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x3QkGjC7"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049F268C49
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748934690; cv=none; b=t2pTyPsvcN9B8JVpeBx9PQL1iN1/eJvDE3ytLiwFYVsA6/CFFwE6bTxrK8k9WGh3oUSdxOebJ2ZsS9lVzyirhAs8W0dw6OqxAzKqY/ys89z/nvtyOueMbSSQ2Gqu8PxBUX2P0VmToMiJFnjUJ/3G2doqrD7p8iXDMOWxAvGxYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748934690; c=relaxed/simple;
	bh=Z+hYtg2N54oWb31O//Qk5cgPs6uNy0350+rWTK60htc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KndWOhsweO8eNKtw5emQknkm25/q3GsHnJecpE33cqrdknFqC2S6V51ZftbyUPxEoxigbSSh0XjewQeGRJhpDuPDvoBIdhTeoZREb++wVc4dwHSkF0qj5vqLVf2ysJmjllwGjzNOfuwOhkMOxuQ/UL+xcMCLGWxYzSoLDT4hm2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x3QkGjC7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74019695377so3228494b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 00:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748934688; x=1749539488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6aNf77dZMqvgD4x/cyfNBUYMjpneTGPfqs/YVhGEJc=;
        b=x3QkGjC721q5pKUw0NQzMYaX+CoDRfMPkCaqVKAp1+WYWmWdwh7a77czLCxKJh6LrZ
         Jl7xLScsvNKYuBu5+fgsvJqD+HV59cXT0/Ln3PXDB8ezllwDlecgmrICHy7x5nWWdhjT
         1my5CdKp8ucoIWOtokaRQA6YhgW9HZHEJcvHsgti45bETJ+nm6XdkedKwaDzr6QfCkGs
         ATOq3eNeXzLaFfiB4cixYsVqDgC5ymWMUPZR8T9nk3ub3ZPAZVhBOWEL7kvPVN2DvPPV
         wxdAeM6fN40TCoWEGCWQrcDE7LuBvhab3URpNfhNu8NSFxiGpsbY1bkGx6YsuCFYBpJt
         BiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748934688; x=1749539488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6aNf77dZMqvgD4x/cyfNBUYMjpneTGPfqs/YVhGEJc=;
        b=U6GJa6u4WnAyinACBvYzqH8ZtjeG16Hd7vVphE2E3yLztzBJtGI8kYUaRSxPyyMgOT
         d2ogtjPJK+gG7E6dBxPc6hF0apz0935idXn1szUBP+GfS0oKmE6p3/88l+6WsCuknLd/
         9Ih7GhGyjYctom087yzdXhRoZ7P5gQGOSlywZ7gq7p8Lgqx2eIsSszvxo7EF+wHWdNHw
         oRSSI4TJjEXUuteWnTG5qtnpt9bQ6PtzIZAvrt8JDPkL6BcFasReJ5k76LIiM0W/sVN/
         P3r5odek5L9uNfRwwNwHd5Nt81/ZwcDpZ09bDhSzbpIj66TGKgpiop5OHSjCXejQCKaX
         r6sg==
X-Forwarded-Encrypted: i=1; AJvYcCUo+uRsdm07rFVoUz5o66HmQXGaAwRH7tpb5/MDPJotnT55og2Pke/AQS2s65u/7Y10AzETgkIDjoLp+8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFcG84e04rO2pH2a4r0xT6qE9gvDbNHFQP9lZmFu5miUE6VoMn
	QCUr3I0Da6P3KpNRCPEZhM8tyP65g61yf9ybJ31gEbo3ChsWBS4Xm2h5bLparjCpPKM=
X-Gm-Gg: ASbGncu/nKRhKMze1T54hW0GVj3FQHz6gJCzdYqiRzevPBJvjkLZ3QBrS3pKG7hg7Pn
	CFH1YqNt57l57WhZApdYV7CbJHfxDANlSGvKXWtsG+ZFZVvz2p1cMxIkvEPeu0ChMHP+DWz5Ie4
	GLFAXipfTI2JjHWnKYUxDnVIiFokBbDe4kGQQqc+jF0nIWEG6vz+Uw1cp8IO0Oyy+HYvocwSEK3
	9kdlAEilOvPIwi0qfQx0iEMBqBf5rrRr2qnZvj4QKFpc/5cQm/NYIGS6DThHqchlC/8Q3sxr+Ni
	VnxV7AoAtNTYhhEpeC38TugDle8VZRtf/vvZG47p0XYyhFf1Eg+MlrFSOYOZ
X-Google-Smtp-Source: AGHT+IETictwGYbPTBkViIRb2uOOYYiWbO6IF3qPE8DiFwJnQM6QC65E4tTAZVhZghEeY6er7aHyIg==
X-Received: by 2002:a05:6a00:981:b0:740:b372:be5 with SMTP id d2e1a72fcca58-747d1831c2bmr15667861b3a.9.1748934688467;
        Tue, 03 Jun 2025 00:11:28 -0700 (PDT)
Received: from [127.0.1.1] ([104.234.225.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed360fsm8746481b3a.81.2025.06.03.00.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 00:11:27 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Tue, 03 Jun 2025 15:10:08 +0800
Subject: [PATCH v11 09/12] drm/msm/dpu: blend pipes per mixer pairs config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-v6-15-quad-pipe-upstream-v11-9-c3af7190613d@linaro.org>
References: <20250603-v6-15-quad-pipe-upstream-v11-0-c3af7190613d@linaro.org>
In-Reply-To: <20250603-v6-15-quad-pipe-upstream-v11-0-c3af7190613d@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>, Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748934620; l=5256;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=Z+hYtg2N54oWb31O//Qk5cgPs6uNy0350+rWTK60htc=;
 b=MOwmJhxS/+i5G5jsyH7FPRBMJfPi6QCikDSu2CmGxCvFPp3dlpCoOcvb07Z5FufJT5KYpYwOk
 sU4TJj24CVpA4yik6bnactGaXFsBv4Mj/n8ynegaorMctZIvYinflgV
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Currently, only 2 pipes are used at most for a plane. A stage structure
describes the configuration for a mixer pair. So only one stage is needed
for current usage cases. The quad-pipe case will be added in future and 2
stages are used in the case. So extend the stage to an array with array
size STAGES_PER_PLANE and blend pipes per mixer pair with configuration in
the stage structure.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    | 45 +++++++++++++++++++----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  3 +-
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index e7f1b5816511b33b106f292541f8f5c966c87118..85f585206218f4578e18b00452762dbada060e9c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -392,7 +392,7 @@ static void _dpu_crtc_program_lm_output_roi(struct drm_crtc *crtc)
 static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
 				       struct drm_plane *plane,
 				       struct dpu_crtc_mixer *mixer,
-				       u32 num_mixers,
+				       u32 lms_in_pair,
 				       enum dpu_stage stage,
 				       const struct msm_format *format,
 				       uint64_t modifier,
@@ -426,7 +426,7 @@ static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
 	stage_cfg->multirect_index[stage][stage_idx] = pipe->multirect_index;
 
 	/* blend config update */
-	for (lm_idx = 0; lm_idx < num_mixers; lm_idx++)
+	for (lm_idx = 0; lm_idx < lms_in_pair; lm_idx++)
 		mixer[lm_idx].lm_ctl->ops.update_pending_flush_sspp(mixer[lm_idx].lm_ctl, sspp_idx);
 }
 
@@ -442,7 +442,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 	const struct msm_format *format;
 	struct dpu_hw_ctl *ctl = mixer->lm_ctl;
 
-	uint32_t lm_idx, i;
+	uint32_t lm_idx, stage, i, pipe_idx, head_pipe_in_stage, lms_in_pair;
 	bool bg_alpha_enable = false;
 	DECLARE_BITMAP(active_fetch, SSPP_MAX);
 
@@ -463,15 +463,24 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
 		if (pstate->stage == DPU_STAGE_BASE && format->alpha_enable)
 			bg_alpha_enable = true;
 
-		for (i = 0; i < PIPES_PER_PLANE; i++) {
-			if (!pstate->pipe[i].sspp)
-				continue;
-			set_bit(pstate->pipe[i].sspp->idx, active_fetch);
-			_dpu_crtc_blend_setup_pipe(crtc, plane,
-						   mixer, cstate->num_mixers,
-						   pstate->stage,
-						   format, fb ? fb->modifier : 0,
-						   &pstate->pipe[i], i, stage_cfg);
+		/* loop pipe per mixer pair with config in stage structure */
+		for (stage = 0; stage < STAGES_PER_PLANE; stage++) {
+			head_pipe_in_stage = stage * PIPES_PER_STAGE;
+			for (i = 0; i < PIPES_PER_STAGE; i++) {
+				pipe_idx = i + head_pipe_in_stage;
+				if (!pstate->pipe[pipe_idx].sspp)
+					continue;
+				lms_in_pair = min(cstate->num_mixers - (stage * PIPES_PER_STAGE),
+						  PIPES_PER_STAGE);
+				set_bit(pstate->pipe[pipe_idx].sspp->idx, active_fetch);
+				_dpu_crtc_blend_setup_pipe(crtc, plane,
+							   &mixer[head_pipe_in_stage],
+							   lms_in_pair,
+							   pstate->stage,
+							   format, fb ? fb->modifier : 0,
+							   &pstate->pipe[pipe_idx], i,
+							   &stage_cfg[stage]);
+			}
 		}
 
 		/* blend config update */
@@ -503,7 +512,7 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 	struct dpu_crtc_mixer *mixer = cstate->mixers;
 	struct dpu_hw_ctl *ctl;
 	struct dpu_hw_mixer *lm;
-	struct dpu_hw_stage_cfg stage_cfg;
+	struct dpu_hw_stage_cfg stage_cfg[STAGES_PER_PLANE];
 	int i;
 
 	DRM_DEBUG_ATOMIC("%s\n", dpu_crtc->name);
@@ -518,9 +527,9 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 	}
 
 	/* initialize stage cfg */
-	memset(&stage_cfg, 0, sizeof(struct dpu_hw_stage_cfg));
+	memset(&stage_cfg, 0, sizeof(stage_cfg));
 
-	_dpu_crtc_blend_setup_mixer(crtc, dpu_crtc, mixer, &stage_cfg);
+	_dpu_crtc_blend_setup_mixer(crtc, dpu_crtc, mixer, stage_cfg);
 
 	for (i = 0; i < cstate->num_mixers; i++) {
 		ctl = mixer[i].lm_ctl;
@@ -537,8 +546,12 @@ static void _dpu_crtc_blend_setup(struct drm_crtc *crtc)
 			mixer[i].mixer_op_mode,
 			ctl->idx - CTL_0);
 
+		/*
+		 * call dpu_hw_ctl_setup_blendstage() to blend layers per stage cfg.
+		 * stage data is shared between PIPES_PER_STAGE pipes.
+		 */
 		ctl->ops.setup_blendstage(ctl, mixer[i].hw_lm->idx,
-			&stage_cfg);
+			&stage_cfg[i / PIPES_PER_STAGE]);
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index 9f75b497aa0c939296207d58dde32028d0a76a6d..e4875a1f638db6f1983d9c51cb399319d27675e9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -34,8 +34,9 @@
 #define DPU_MAX_PLANES			4
 #endif
 
-#define PIPES_PER_PLANE			2
+#define STAGES_PER_PLANE		1
 #define PIPES_PER_STAGE			2
+#define PIPES_PER_PLANE			(PIPES_PER_STAGE * STAGES_PER_PLANE)
 #ifndef DPU_MAX_DE_CURVES
 #define DPU_MAX_DE_CURVES		3
 #endif

-- 
2.34.1


