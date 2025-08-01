Return-Path: <linux-kernel+bounces-753567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595E7B184A8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACBB568861
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B62F26CE06;
	Fri,  1 Aug 2025 15:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ulfMDgLo"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C5B27602A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060938; cv=none; b=pvUASYSpIB9wszEYDjHyiFWxezqqjALyLMZfu4fckNxPbj50GERCI2jlBxaJP6vTv9io3nh8rr6uguAiURy7GnqoUg+ECmXxjH1zNozBZOgCNaQnNTf/tEUs0Mqvv7MSkZ6NhwdkapJCiVJicxlQhMTmpeKkOMQ/nIrF0w6HeZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060938; c=relaxed/simple;
	bh=Z562NtPUXRhT8Hc4hvm8HoowSPE6ktbWnSIqtqVwrFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n4u3CCND3IJtNC04nzrlf1KMKset97NUwCwD+nGnoGJfUWFjop3m7L7JqWozP58BHxgaErLF+7CXZUfQgR67zMyAlHCW3KiTsURmzs7uA5AnzEA/ddT7pBt/KcP3YkjgY1FllymBHSIFsB6M/0xCOO3FALK9827dwcJgAD3gSe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ulfMDgLo; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-240418cbb8bso15287235ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754060936; x=1754665736; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgwWNZrDakWTRGIAzVwji8mlNvTEY3Evic7nS2oT060=;
        b=ulfMDgLo2wPbjvi5gjxNsY2e8A69wzMB+r3DEgJiWPFWM+AQUARn5uxrjWhnI1k5pW
         /SABb53c52xeJ1EleSSbR0jihgLUnkDMyeROxQCNnUhrdjreaIQKyNTZk1hzeYmhyVzp
         ZmwfrNrN0TcNYv5i3TYR0cP3B8xgkC0yOvXJhybf6eW96A2NNeMzYYGHJjjWUsBk/L1N
         tyP+KuZcjKgIRWJRjvR247wPnt5SKCOIqZxTPD7i3vzjSTe70H5zj+ThMbKNZpmNatC5
         BZze8bLy6yEggf/7FoCZqGG3tRbXm8F+hBwNCbuCROuFkwuT4pTCuuEyx8os+0IjghZs
         49MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754060936; x=1754665736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgwWNZrDakWTRGIAzVwji8mlNvTEY3Evic7nS2oT060=;
        b=SMEwazDHohqs6aC/z6NJ+oRcmmO7TWJKV8/iWuwQ6qcgv56SzBQXokZmxDU+PO9jVY
         VKBp+hQUfbkIU4HX84uw1i1OjOEQEGqdxf7VzZvmXVm3AKpBqzepJWOGWacr2p9Zhw4a
         FzONRyr6gNcKgDvWRVm19QqSRX/1SMIeJGDnGJn8pkZc7o1dG3ZhnwA5+Jwg8wGmmItT
         p3QoXvKUD31etYTL0wgGVjRXeQEJblZRGyHh4kRWk19O89PgNOiros8TAkkD5TiPje+L
         hpXf+Lz8emhIcIJWSc0rmMCWvKCwnBkKMoxd5g5pI6XQTWy+GrH/wGd8B2hi4/QLseKu
         HdrA==
X-Forwarded-Encrypted: i=1; AJvYcCVbZR+Sy75Ea+lghS5pEA6vKyRAEeS/GPOoGAmDbcL82/U8o4TK2f5w1TlnOptUHmOGWLdufTTiR3vNStc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7aB2qNBuepvwk5KtY30j00BHjvhZkwGjUrjLrKT4HGFw9Tivg
	092OTKN4HQskZW2BxoDGew+AQByIvlR5HQ/gAMpj6WxHCBeLvF4+Y09xlCRkVMRIPpU=
X-Gm-Gg: ASbGncsQ0SfoQ4ZoU/z3rP14FZX4GyrZBLuhbo42OPY/bio/fQQukifzmoA4796lZbk
	am1ZKYG8mwh+ThrCD0yPivTu4ObXV4hRM0WPmROIokf3kw8a6J0cOhGI0DxZtqvO4RIoeLeOQNL
	+S3ir8AWMBjTisTSsnkc3j5h+F2wdlz5XtJvpTyWXKe5qQSDDUs/EXZclX5/Skyer55oMvcNqQ3
	HsxlVzmZWFg1PACjrQQL/pYBYr8J7tXahqEzij1qPfLmX1tr4TZ+Pc4fykHJFZfcR07yDweeQIX
	yW8bpXhMAL+ZzEa7B42ItDNgQg77kK55m6PNQ7ZQxZ/rsSzqi0u+yHLLKejtxcPZ2RLURU0xegT
	fKElBgojiQL2gKN61uA==
X-Google-Smtp-Source: AGHT+IH3yQ2WZsf1TaouI4Sj6r8fc3DQaXgU+bRdXJZQ/Jn4uBqwLbbWcaif8+WUi7oy2XSYcv8aCQ==
X-Received: by 2002:a17:902:d482:b0:234:986c:66bf with SMTP id d9443c01a7336-24096a4f534mr168491285ad.11.1754060935960;
        Fri, 01 Aug 2025 08:08:55 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.60.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafa11sm45639705ad.172.2025.08.01.08.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 08:08:55 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Fri, 01 Aug 2025 23:07:35 +0800
Subject: [PATCH v14 11/13] drm/msm/dpu: support SSPP assignment for
 quad-pipe case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-v6-16-rc2-quad-pipe-upstream-v14-11-b626236f4c31@linaro.org>
References: <20250801-v6-16-rc2-quad-pipe-upstream-v14-0-b626236f4c31@linaro.org>
In-Reply-To: <20250801-v6-16-rc2-quad-pipe-upstream-v14-0-b626236f4c31@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754060859; l=9470;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=Z562NtPUXRhT8Hc4hvm8HoowSPE6ktbWnSIqtqVwrFo=;
 b=4u4inTWpho7OFYRJxY2nlI0TT4AavL0qXB9ZEcTY9rE6jict7U+Tf2//4tYZ86U3bE4djG1Dc
 wjQZCGlRQCWARxCOJh7um2hYtmQmYyPKc00DREUno9pDNHiPQ/Ja0s/
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Currently, SSPPs are assigned to a maximum of two pipes. However,
quad-pipe usage scenarios require four pipes and involve configuring
two stages. In quad-pipe case, the first two pipes share a set of
mixer configurations and enable multi-rect mode when certain
conditions are met. The same applies to the subsequent two pipes.

Assign SSPPs to the pipes in each stage using a unified method and
to loop the stages accordingly.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 150 ++++++++++++++++++------------
 1 file changed, 89 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 55429f29a4b95594771d930efe42aaa4126f6f07..9671af9620037b5c341e404bb3b2fc21696ce79e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -958,6 +958,23 @@ static int dpu_plane_is_multirect_parallel_capable(struct dpu_hw_sspp *sspp,
 		dpu_plane_is_parallel_capable(pipe_cfg, fmt, max_linewidth);
 }
 
+static bool dpu_plane_get_single_pipe_in_stage(struct dpu_plane_state *pstate,
+					       struct dpu_sw_pipe **single_pipe,
+					       struct dpu_sw_pipe_cfg **single_pipe_cfg,
+					       int stage_index)
+{
+	int pipe_idx;
+
+	pipe_idx = stage_index * PIPES_PER_STAGE;
+	if (drm_rect_width(&pstate->pipe_cfg[pipe_idx].src_rect) != 0 &&
+	    drm_rect_width(&pstate->pipe_cfg[pipe_idx + 1].src_rect) == 0) {
+		*single_pipe = &pstate->pipe[pipe_idx];
+		*single_pipe_cfg = &pstate->pipe_cfg[pipe_idx];
+		return true;
+	}
+
+	return false;
+}
 
 static int dpu_plane_atomic_check_sspp(struct drm_plane *plane,
 				       struct drm_atomic_state *state,
@@ -1023,17 +1040,20 @@ static bool dpu_plane_try_multirect_parallel(struct dpu_sw_pipe *pipe, struct dp
 static int dpu_plane_try_multirect_shared(struct dpu_plane_state *pstate,
 					  struct dpu_plane_state *prev_adjacent_pstate,
 					  const struct msm_format *fmt,
-					  uint32_t max_linewidth)
+					  uint32_t max_linewidth, int stage_index)
 {
-	struct dpu_sw_pipe *pipe = &pstate->pipe[0];
-	struct dpu_sw_pipe *r_pipe = &pstate->pipe[1];
-	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg[0];
-	struct dpu_sw_pipe *prev_pipe = &prev_adjacent_pstate->pipe[0];
-	struct dpu_sw_pipe_cfg *prev_pipe_cfg = &prev_adjacent_pstate->pipe_cfg[0];
+	struct dpu_sw_pipe *pipe, *prev_pipe;
+	struct dpu_sw_pipe_cfg *pipe_cfg, *prev_pipe_cfg;
 	const struct msm_format *prev_fmt = msm_framebuffer_format(prev_adjacent_pstate->base.fb);
 	u16 max_tile_height = 1;
 
-	if (prev_adjacent_pstate->pipe[1].sspp != NULL ||
+	if (!dpu_plane_get_single_pipe_in_stage(pstate, &pipe,
+						&pipe_cfg, stage_index))
+		return false;
+
+	if (!dpu_plane_get_single_pipe_in_stage(prev_adjacent_pstate,
+						&prev_pipe, &prev_pipe_cfg,
+						stage_index) ||
 	    prev_pipe->multirect_mode != DPU_SSPP_MULTIRECT_NONE)
 		return false;
 
@@ -1048,11 +1068,6 @@ static int dpu_plane_try_multirect_shared(struct dpu_plane_state *pstate,
 	if (MSM_FORMAT_IS_UBWC(prev_fmt))
 		max_tile_height = max(max_tile_height, prev_fmt->tile_height);
 
-	r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
-	r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
-
-	r_pipe->sspp = NULL;
-
 	if (dpu_plane_is_parallel_capable(pipe_cfg, fmt, max_linewidth) &&
 	    dpu_plane_is_parallel_capable(prev_pipe_cfg, prev_fmt, max_linewidth) &&
 	    (pipe_cfg->dst_rect.x1 >= prev_pipe_cfg->dst_rect.x2 ||
@@ -1181,36 +1196,69 @@ static int dpu_plane_virtual_atomic_check(struct drm_plane *plane,
 	return 0;
 }
 
+static int dpu_plane_assign_resource_in_stage(struct dpu_sw_pipe *pipe,
+					      struct dpu_sw_pipe_cfg *pipe_cfg,
+					      struct drm_plane_state *plane_state,
+					      struct dpu_global_state *global_state,
+					      struct drm_crtc *crtc,
+					      struct dpu_rm_sspp_requirements *reqs)
+{
+	struct drm_plane *plane = plane_state->plane;
+	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
+	struct dpu_sw_pipe *r_pipe = pipe + 1;
+	struct dpu_sw_pipe_cfg *r_pipe_cfg = pipe_cfg + 1;
+
+	if (drm_rect_width(&pipe_cfg->src_rect) != 0) {
+		pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, reqs);
+		if (!pipe->sspp)
+			return -ENODEV;
+		pipe->multirect_index = DPU_SSPP_RECT_SOLO;
+		pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+	}
+
+	if (drm_rect_width(&r_pipe_cfg->src_rect) != 0 &&
+	    dpu_plane_try_multirect_parallel(pipe, pipe_cfg, r_pipe, r_pipe_cfg,
+					      pipe->sspp,
+					      msm_framebuffer_format(plane_state->fb),
+					      dpu_kms->catalog->caps->max_linewidth))
+		goto stage_assinged;
+
+	if (drm_rect_width(&r_pipe_cfg->src_rect) != 0) {
+		r_pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, reqs);
+		if (!r_pipe->sspp)
+			return -ENODEV;
+		r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
+		r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+	}
+
+stage_assinged:
+	return 0;
+}
+
 static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
 					      struct dpu_global_state *global_state,
 					      struct drm_atomic_state *state,
 					      struct drm_plane_state *plane_state,
-					      struct drm_plane_state *prev_adjacent_plane_state)
+					      struct drm_plane_state **prev_adjacent_plane_state)
 {
 	const struct drm_crtc_state *crtc_state = NULL;
 	struct drm_plane *plane = plane_state->plane;
 	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
 	struct dpu_rm_sspp_requirements reqs;
-	struct dpu_plane_state *pstate, *prev_adjacent_pstate;
+	struct dpu_plane_state *pstate, *prev_adjacent_pstate[STAGES_PER_PLANE];
 	struct dpu_sw_pipe *pipe;
-	struct dpu_sw_pipe *r_pipe;
 	struct dpu_sw_pipe_cfg *pipe_cfg;
-	struct dpu_sw_pipe_cfg *r_pipe_cfg;
 	const struct msm_format *fmt;
-	int i;
+	int i, ret;
 
 	if (plane_state->crtc)
 		crtc_state = drm_atomic_get_new_crtc_state(state,
 							   plane_state->crtc);
 
 	pstate = to_dpu_plane_state(plane_state);
-	prev_adjacent_pstate = prev_adjacent_plane_state ?
-		to_dpu_plane_state(prev_adjacent_plane_state) : NULL;
-
-	pipe = &pstate->pipe[0];
-	r_pipe = &pstate->pipe[1];
-	pipe_cfg = &pstate->pipe_cfg[0];
-	r_pipe_cfg = &pstate->pipe_cfg[1];
+	for (i = 0; i < STAGES_PER_PLANE; i++)
+		prev_adjacent_pstate[i] = prev_adjacent_plane_state[i] ?
+			to_dpu_plane_state(prev_adjacent_plane_state[i]) : NULL;
 
 	for (i = 0; i < PIPES_PER_PLANE; i++)
 		pstate->pipe[i].sspp = NULL;
@@ -1225,42 +1273,24 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
 
 	reqs.rot90 = drm_rotation_90_or_270(plane_state->rotation);
 
-	if (drm_rect_width(&r_pipe_cfg->src_rect) == 0) {
-		if (!prev_adjacent_pstate ||
-		    !dpu_plane_try_multirect_shared(pstate, prev_adjacent_pstate, fmt,
-						    dpu_kms->catalog->caps->max_linewidth)) {
-			pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
-			if (!pipe->sspp)
-				return -ENODEV;
-
-			r_pipe->sspp = NULL;
-
-			pipe->multirect_index = DPU_SSPP_RECT_SOLO;
-			pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
-
-			r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
-			r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
-		}
-	} else {
-		pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
-		if (!pipe->sspp)
-			return -ENODEV;
-
-		if (!dpu_plane_try_multirect_parallel(pipe, pipe_cfg, r_pipe, r_pipe_cfg,
-						      pipe->sspp,
-						      msm_framebuffer_format(plane_state->fb),
-						      dpu_kms->catalog->caps->max_linewidth)) {
-			/* multirect is not possible, use two SSPP blocks */
-			r_pipe->sspp = dpu_rm_reserve_sspp(&dpu_kms->rm, global_state, crtc, &reqs);
-			if (!r_pipe->sspp)
-				return -ENODEV;
+	for (i = 0; i < STAGES_PER_PLANE; i++) {
+		if (prev_adjacent_pstate[i] &&
+		    dpu_plane_try_multirect_shared(pstate, prev_adjacent_pstate[i], fmt,
+						   dpu_kms->catalog->caps->max_linewidth,
+						   i))
+			continue;
 
-			pipe->multirect_index = DPU_SSPP_RECT_SOLO;
-			pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+		if (dpu_plane_get_single_pipe_in_stage(pstate, &pipe, &pipe_cfg, i))
+			prev_adjacent_plane_state[i] = plane_state;
 
-			r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
-			r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
-		}
+		pipe = &pstate->pipe[i * PIPES_PER_STAGE];
+		pipe_cfg = &pstate->pipe_cfg[i * PIPES_PER_STAGE];
+		ret = dpu_plane_assign_resource_in_stage(pipe, pipe_cfg,
+							 plane_state,
+							 global_state,
+							 crtc, &reqs);
+		if (ret)
+			return ret;
 	}
 
 	return dpu_plane_atomic_check_sspp(plane, state, crtc_state);
@@ -1273,7 +1303,7 @@ int dpu_assign_plane_resources(struct dpu_global_state *global_state,
 			       unsigned int num_planes)
 {
 	unsigned int i;
-	struct drm_plane_state *prev_adjacent_plane_state = NULL;
+	struct drm_plane_state *prev_adjacent_plane_state[STAGES_PER_PLANE] = { NULL };
 
 	for (i = 0; i < num_planes; i++) {
 		struct drm_plane_state *plane_state = states[i];
@@ -1287,8 +1317,6 @@ int dpu_assign_plane_resources(struct dpu_global_state *global_state,
 							     prev_adjacent_plane_state);
 		if (ret)
 			break;
-
-		prev_adjacent_plane_state = plane_state;
 	}
 
 	return 0;

-- 
2.34.1


