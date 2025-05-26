Return-Path: <linux-kernel+bounces-662592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F86AAC3CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 11:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939E018974A8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 May 2025 09:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF36A1F8ACA;
	Mon, 26 May 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbhQ5SJ8"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BD71F873B
	for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748251788; cv=none; b=C1L35lSVVKVoZV4auT4ZZHiGXfPJLO5bHzD139JaHD7GabDzrprFqmZbsRWcV50yZRvNct9zuZRHHr5b7HuYnZJ24xOJmrLKUovIB3s/Flo6krHkYZtpt0Bme2WLCcBLrTQESvCZ4x0IbgMSn+nXQJXjuErZD5NToYJnYCHcEbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748251788; c=relaxed/simple;
	bh=heInugFwRtw6CaXJKnON/115qamun6IvoaQJCL8BoFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3E6ZZWdV/fScCZTkADbmBvvaEH7OSpKSW/iyIEAbtCUWHilqnPznlQdzw67Zg8wCDbBrPxACPpwpsepGd2A74/flhp87t0pSkOescLJQzRRpEn2lMv1HmipqqHsmVbSikmyVcx22lKKEfqlGhuRh1xe2blN8i7AkcmGDLnYn/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pbhQ5SJ8; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74068f95d9fso1409073b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 May 2025 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748251786; x=1748856586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/f+SqVbymiUqr7EX/dLyPAYSH86sXDRxzwvGUhAyTxY=;
        b=pbhQ5SJ8P8Sad6+R1iTW3ZqtBGexq1/NqIFnvkPLGgkZIPGIBo7B6VnNxBc1/hHVes
         90ZHVNGmp1CQ7ZAHHxSZI3xXW8L9PLq6m0D4xunY0zMB1/drs9QLJRyjVzmUZD+uLTta
         gK7wWCte3HXUqyMJVbzp3JaIppV3KIjWCOU++sBKVuE9nhGpWlVURLr2jSna0RHptAgF
         kMxSABSjQJDH9yD+ANpjHQ8hFbnUDW1Exs9sMpmOlD+uChcQUQAUIwkH0Vq2FH8DyeVy
         8G5L3gCbWvkyBvri3drpE5dmUx3y8GbGuABtJXIBsSvJNEYaEVUnsnHd+H5TQpCZaFnk
         QOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748251786; x=1748856586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/f+SqVbymiUqr7EX/dLyPAYSH86sXDRxzwvGUhAyTxY=;
        b=V68f1ynPdpHv+Fv2gwBHUV9cKZ+naUVlGePUgVSwzUb+QgXJxMtwksqNEJIRZq+p1x
         vp3WgsOHRGZINTFAFeGhbq8GdXD1ak/CAxggk5J2BJ/d12DvBdx+VO6KvVFo7rx/7r8F
         JU3M+IwkTCInPuA0lMct6OWlqhSlzPzzqQhh2a5xDHxNrKtF64RdPa17JFAAN2C3QuXp
         32VX7VM3Z27oL3a7R3VLIAVBsFdiAo8dd20Lq4ytrP24geLisd5nLnqT3ZSR89VCaPyJ
         nIpBDh3kn8jKhWjOwOqX09evIJiZTbNTHGArHqF5FO6Vd4Yn+6M8O5DyYEKkxAcUKtb4
         phVA==
X-Forwarded-Encrypted: i=1; AJvYcCXkUhOH46lfC+c9ASty1tvW8MgIG6zeUeNZnkcgWwekfi0bf1cXf8arzc7IkWR1EKDdsuaOy0MDL4SLNR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDKFAQUKDWVIdkNGdDjoXM11caxpqns8YdAPy/4TZSrhg2oUld
	Z0bok55tNIwce6kjFz/UjiaOOTdgO2axPBbz7lnTyNwWyk5fJ1Oy8gfYBDOaUdOIzEk=
X-Gm-Gg: ASbGnctPrdxQY7Zuv5sBM0M89+NBm23SMYuuzeW+svZYhTc2L4TjHkInrZPdUJpVawM
	STHtWpQKlAehbXwAysIOEIeJVIZfFAyHfXw9NtY6XmwN8dmvG9dvdL+SZoqQajPwd6tu2SkXbUC
	XozUeENgGxabCOiE/+6XvaEnujtTtq1RCNVuZvJmHMt00wScqdFaArNk9VaEe4nAr58HVveUc80
	DxIcoqsh60f6GnpTbqgQWrNQv/gkNf+rcdf9yKKF1x0ShCUaVCdy6vTQtsDQXFGx+5chKZOTxD5
	32BmgvC5UGjM+I+gpjYfYHBaec99WydoFs2hm0BXnKrC5fzoiA==
X-Google-Smtp-Source: AGHT+IErEthueKynXHq5buzTz4skCgU6TqPNCN50PH5smfMk9zPZkeiz4eh88Jy7GKty6c+mDgetMA==
X-Received: by 2002:aa7:888c:0:b0:742:a111:ee6f with SMTP id d2e1a72fcca58-745fde9ca31mr11609053b3a.10.1748251786351;
        Mon, 26 May 2025 02:29:46 -0700 (PDT)
Received: from [127.0.1.1] ([104.234.225.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9876e62sm17162393b3a.147.2025.05.26.02.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:29:45 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 26 May 2025 17:28:29 +0800
Subject: [PATCH v10 11/12] drm/msm/dpu: support plane splitting in
 quad-pipe case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-v6-15-quad-pipe-upstream-v10-11-5fed4f8897c4@linaro.org>
References: <20250526-v6-15-quad-pipe-upstream-v10-0-5fed4f8897c4@linaro.org>
In-Reply-To: <20250526-v6-15-quad-pipe-upstream-v10-0-5fed4f8897c4@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748251705; l=8154;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=heInugFwRtw6CaXJKnON/115qamun6IvoaQJCL8BoFA=;
 b=+7Soq0oCoUFJHIeU6jRV99sLbPq1YmfWMAOyxF0nl3BvChnYDo29N4nBujK2cytLKnQtdBIww
 86EMuW7RMy/BRUgyKcPRtD3ZJmMOrpw6T4WKfw9thtVb+OonEKJz7WR
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

The content of every half of screen is sent out via one interface in
dual-DSI case. The content for every interface is blended by a LM
pair in quad-pipe case, thus a LM pair should not blend any content
that cross the half of screen in this case. Clip plane into pipes per
left and right half screen ROI if topology is quad pipe case.

The clipped rectangle on every half of screen is futher handled by two
pipes if its width exceeds a limit for a single pipe.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 137 +++++++++++++++++++++---------
 1 file changed, 97 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index f721dc504bbbe3a49986239adee113bfb6790f70..5349b99ebe0174a9ccae9a9c37c6d224768f6da7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -831,8 +831,12 @@ static int dpu_plane_atomic_check_nosspp(struct drm_plane *plane,
 	struct dpu_plane_state *pstate = to_dpu_plane_state(new_plane_state);
 	struct dpu_sw_pipe_cfg *pipe_cfg;
 	struct dpu_sw_pipe_cfg *r_pipe_cfg;
+	struct dpu_sw_pipe_cfg init_pipe_cfg;
 	struct drm_rect fb_rect = { 0 };
+	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
 	uint32_t max_linewidth;
+	u32 num_lm;
+	int stage_id, num_stages;
 
 	min_scale = FRAC_16_16(1, MAX_UPSCALE_RATIO);
 	max_scale = MAX_DOWNSCALE_RATIO << 16;
@@ -855,13 +859,10 @@ static int dpu_plane_atomic_check_nosspp(struct drm_plane *plane,
 		return -EINVAL;
 	}
 
-	/* move the assignment here, to ease handling to another pairs later */
-	pipe_cfg = &pstate->pipe_cfg[0];
-	r_pipe_cfg = &pstate->pipe_cfg[1];
-	/* state->src is 16.16, src_rect is not */
-	drm_rect_fp_to_int(&pipe_cfg->src_rect, &new_plane_state->src);
+	num_lm = dpu_crtc_get_num_lm(crtc_state);
 
-	pipe_cfg->dst_rect = new_plane_state->dst;
+	/* state->src is 16.16, src_rect is not */
+	drm_rect_fp_to_int(&init_pipe_cfg.src_rect, &new_plane_state->src);
 
 	fb_rect.x2 = new_plane_state->fb->width;
 	fb_rect.y2 = new_plane_state->fb->height;
@@ -886,35 +887,94 @@ static int dpu_plane_atomic_check_nosspp(struct drm_plane *plane,
 
 	max_linewidth = pdpu->catalog->caps->max_linewidth;
 
-	drm_rect_rotate(&pipe_cfg->src_rect,
+	drm_rect_rotate(&init_pipe_cfg.src_rect,
 			new_plane_state->fb->width, new_plane_state->fb->height,
 			new_plane_state->rotation);
 
-	if ((drm_rect_width(&pipe_cfg->src_rect) > max_linewidth) ||
-	     _dpu_plane_calc_clk(&crtc_state->adjusted_mode, pipe_cfg) > max_mdp_clk_rate) {
-		if (drm_rect_width(&pipe_cfg->src_rect) > 2 * max_linewidth) {
-			DPU_DEBUG_PLANE(pdpu, "invalid src " DRM_RECT_FMT " line:%u\n",
-					DRM_RECT_ARG(&pipe_cfg->src_rect), max_linewidth);
-			return -E2BIG;
+	/*
+	 * We have 1 mixer pair cfg for 1:1:1 and 2:2:1 topology, 2 mixer pair
+	 * configs for left and right half screen in case of 4:4:2 topology.
+	 * But we may have 2 rect to split wide plane that exceeds limit with 1
+	 * config for 2:2:1. So need to handle both wide plane splitting, and
+	 * two halves of screen splitting for quad-pipe case. Check dest
+	 * rectangle left/right clipping first, then check wide rectangle
+	 * splitting in every half next.
+	 */
+	num_stages = (num_lm + 1) / 2;
+	/* iterate mixer configs for this plane, to separate left/right with the id */
+	for (stage_id = 0; stage_id < num_stages; stage_id++) {
+		struct drm_rect mixer_rect = {
+			.x1 = stage_id * mode->hdisplay / num_stages,
+			.y1 = 0,
+			.x2 = (stage_id + 1) * mode->hdisplay / num_stages,
+			.y2 = mode->vdisplay
+			};
+		int cfg_idx = stage_id * PIPES_PER_STAGE;
+
+		pipe_cfg = &pstate->pipe_cfg[cfg_idx];
+		r_pipe_cfg = &pstate->pipe_cfg[cfg_idx + 1];
+
+		drm_rect_fp_to_int(&pipe_cfg->src_rect, &new_plane_state->src);
+		pipe_cfg->dst_rect = new_plane_state->dst;
+
+		DPU_DEBUG_PLANE(pdpu, "checking src " DRM_RECT_FMT
+				" vs clip window " DRM_RECT_FMT "\n",
+				DRM_RECT_ARG(&pipe_cfg->src_rect),
+				DRM_RECT_ARG(&mixer_rect));
+
+		/*
+		 * If this plane does not fall into mixer rect, check next
+		 * mixer rect.
+		 */
+		if (!drm_rect_clip_scaled(&pipe_cfg->src_rect,
+					  &pipe_cfg->dst_rect,
+					  &mixer_rect)) {
+			memset(pipe_cfg, 0, 2 * sizeof(struct dpu_sw_pipe_cfg));
+
+			continue;
 		}
 
-		*r_pipe_cfg = *pipe_cfg;
-		pipe_cfg->src_rect.x2 = (pipe_cfg->src_rect.x1 + pipe_cfg->src_rect.x2) >> 1;
-		pipe_cfg->dst_rect.x2 = (pipe_cfg->dst_rect.x1 + pipe_cfg->dst_rect.x2) >> 1;
-		r_pipe_cfg->src_rect.x1 = pipe_cfg->src_rect.x2;
-		r_pipe_cfg->dst_rect.x1 = pipe_cfg->dst_rect.x2;
-	} else {
-		memset(r_pipe_cfg, 0, sizeof(*r_pipe_cfg));
-	}
+		pipe_cfg->dst_rect.x1 -= mixer_rect.x1;
+		pipe_cfg->dst_rect.x2 -= mixer_rect.x1;
+
+		DPU_DEBUG_PLANE(pdpu, "Got clip src:" DRM_RECT_FMT " dst: " DRM_RECT_FMT "\n",
+				DRM_RECT_ARG(&pipe_cfg->src_rect), DRM_RECT_ARG(&pipe_cfg->dst_rect));
+
+		/* Split wide rect into 2 rect */
+		if ((drm_rect_width(&pipe_cfg->src_rect) > max_linewidth) ||
+		     _dpu_plane_calc_clk(mode, pipe_cfg) > max_mdp_clk_rate) {
+
+			if (drm_rect_width(&pipe_cfg->src_rect) > 2 * max_linewidth) {
+				DPU_DEBUG_PLANE(pdpu, "invalid src " DRM_RECT_FMT " line:%u\n",
+						DRM_RECT_ARG(&pipe_cfg->src_rect), max_linewidth);
+				return -E2BIG;
+			}
 
-	drm_rect_rotate_inv(&pipe_cfg->src_rect,
-			    new_plane_state->fb->width, new_plane_state->fb->height,
-			    new_plane_state->rotation);
-	if (drm_rect_width(&r_pipe_cfg->src_rect) != 0)
-		drm_rect_rotate_inv(&r_pipe_cfg->src_rect,
-				    new_plane_state->fb->width, new_plane_state->fb->height,
+			memcpy(r_pipe_cfg, pipe_cfg, sizeof(struct dpu_sw_pipe_cfg));
+			pipe_cfg->src_rect.x2 = (pipe_cfg->src_rect.x1 + pipe_cfg->src_rect.x2) >> 1;
+			pipe_cfg->dst_rect.x2 = (pipe_cfg->dst_rect.x1 + pipe_cfg->dst_rect.x2) >> 1;
+			r_pipe_cfg->src_rect.x1 = pipe_cfg->src_rect.x2;
+			r_pipe_cfg->dst_rect.x1 = pipe_cfg->dst_rect.x2;
+			DPU_DEBUG_PLANE(pdpu, "Split wide plane into:"
+					DRM_RECT_FMT " and " DRM_RECT_FMT "\n",
+					DRM_RECT_ARG(&pipe_cfg->src_rect),
+					DRM_RECT_ARG(&r_pipe_cfg->src_rect));
+		} else {
+			memset(r_pipe_cfg, 0, sizeof(struct dpu_sw_pipe_cfg));
+		}
+
+		drm_rect_rotate_inv(&pipe_cfg->src_rect,
+				    new_plane_state->fb->width,
+				    new_plane_state->fb->height,
 				    new_plane_state->rotation);
 
+		if (drm_rect_width(&r_pipe_cfg->src_rect) != 0)
+			drm_rect_rotate_inv(&r_pipe_cfg->src_rect,
+					    new_plane_state->fb->width,
+					    new_plane_state->fb->height,
+					    new_plane_state->rotation);
+	}
+
 	pstate->needs_qos_remap = drm_atomic_crtc_needs_modeset(crtc_state);
 
 	return 0;
@@ -997,20 +1057,17 @@ static int dpu_plane_atomic_check_sspp(struct drm_plane *plane,
 		drm_atomic_get_new_plane_state(state, plane);
 	struct dpu_plane *pdpu = to_dpu_plane(plane);
 	struct dpu_plane_state *pstate = to_dpu_plane_state(new_plane_state);
-	struct dpu_sw_pipe *pipe = &pstate->pipe[0];
-	struct dpu_sw_pipe *r_pipe = &pstate->pipe[1];
-	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg[0];
-	struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->pipe_cfg[1];
-	int ret = 0;
-
-	ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg,
-					  &crtc_state->adjusted_mode,
-					  new_plane_state);
-	if (ret)
-		return ret;
+	struct dpu_sw_pipe *pipe;
+	struct dpu_sw_pipe_cfg *pipe_cfg;
+	int ret = 0, i;
 
-	if (drm_rect_width(&r_pipe_cfg->src_rect) != 0) {
-		ret = dpu_plane_atomic_check_pipe(pdpu, r_pipe, r_pipe_cfg,
+	for (i = 0; i < PIPES_PER_PLANE; i++) {
+		pipe = &pstate->pipe[i];
+		pipe_cfg = &pstate->pipe_cfg[i];
+		if (!pipe->sspp)
+			continue;
+		DPU_DEBUG_PLANE(pdpu, "pipe %d is in use, validate it\n", i);
+		ret = dpu_plane_atomic_check_pipe(pdpu, pipe, pipe_cfg,
 						  &crtc_state->adjusted_mode,
 						  new_plane_state);
 		if (ret)

-- 
2.34.1


