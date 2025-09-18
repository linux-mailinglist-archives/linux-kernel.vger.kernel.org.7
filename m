Return-Path: <linux-kernel+bounces-748004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD0AB13B4B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC993BDFBD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABF4450F2;
	Mon, 28 Jul 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NglRr/8X"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505526A0C5
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708548; cv=none; b=meukzwer+Rk8t5a0pzpjK4RSYyq7t3s8VaueuPM4jrH/aWV/OQpKNxNRgwEpkoHU3LhfA9C4Ay29cac9XRgTVIbZH8Byzf5Bb6BlKLu87/7HAw21seXdz7nkkDk86hey9AKbbMiPxi9fKpctKHFfScXAYkvSQcXHrxUSWE9VcNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708548; c=relaxed/simple;
	bh=dKFyKjmZeF9PN4Wn7efC/rAUhNPwQdgLaQ4zoFinDnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gYdww1WKRJ8/pNp3PYURbdmIkobKoH7xzpfCC6T/D1hQTQ9dpF+qX+/MXkyFSACwvHOLrase/qqvVgDf3mrWLRxBKyeMFrQH2lKJL7JhZ5QXnfDAO3uCKyieei/9JvjR96ncKnsmbXpG52bYApQNhul/hqcKREJFK6HaeIdWkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NglRr/8X; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74ce477af25so2875570b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753708546; x=1754313346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9b10Utde/4CPYmUXL4JbunDZfV3oczzPP2bJZaYWdQ=;
        b=NglRr/8XIMyyjeTzWuatpSQtG5+GI7KzPb3QdFTC2Z6s6oBPfB2tmxhP9maxU1t7TW
         2e5lhObb+QOxL1gjDtmQkE1VkJvwBJfAFaLQTrjg39zL5k16cAf0Qr00CzeD3QgO6JkM
         ZpOryN+Due34gbvehYpgBKpoL/6s4ELDnCUOehuUYanGp7ljNWT+REemhdx9ZtDSpeVW
         GuPiCJtk6IqDQxR+g8+eeUVxNtLUOXXvmbt5P6CgWDTCvy2Q/myvQVpywocLHOoQM33B
         lTlolvriV5A8ys1KnfBO/h8vRJPK2w5Lyuz/bjBeb7bhyiUv+4Oq7Xacl8wO5dIZ3mL+
         ZsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753708546; x=1754313346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9b10Utde/4CPYmUXL4JbunDZfV3oczzPP2bJZaYWdQ=;
        b=cg3O8qACpAKYv4Z23TkRBkeodChWZV87ezVkov/0EkZe7GwxN6VJv3ftYFeiAs4j4U
         Fg4wqre6oCGsUksmIj0YheEmK1qiCD3uH985jR1CMfWw0TrRZkZ5OlfkPEKAYXxwht0y
         gV/uxa9aKXHJYo91gPsom9UzWPzzVC4Gu640VX5FjjWvLCSC/CxfGBh3ytWAssNme1mr
         kJ7Oil1DTZ/47Ae0foL/aJGAmx4NqfbndnpKZSuX7244qlQyeP09OM+Gp8iuBba25SQU
         6BYow1S7HzmHY2RQ42Syf9fUL8oWkHy0fqVAUHZeiZS1ScYszzUX6uQuo2CDyCWD5oNC
         MzgA==
X-Forwarded-Encrypted: i=1; AJvYcCVGWQfTp5NF7DAt6ZZQWVl0hIYRNgqn81FzJikpinFgR9xtIkrRow0EVyuZtP+o19r92OVIGiEOaTYdfsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzal3EAnE2fEyBqkuXp7CFHGQkghCdv21dnlS4DzGPhcqGe07Wt
	GC7eGiG8pxW7zXq/YxoyBv41zgP2sy8xjMpXrsMiQEEwsnR7lkJt/FgdcPxXNyF1mJs=
X-Gm-Gg: ASbGncup6qB5Lu78QEILVh10yOkBFNCaI0QGUEf1AEuhpgaFTOzMI9gKcJmmKIjyByo
	uWl5PkYbXWfWLuXREhs3WpSxezmkjj2H/vEK4nHOPiw6lgdvZBwpgd+nkpnJsPdoA6lEgAtD99b
	FLDSkAT9vRTkCdnGGiSN/NT7aif6SOgESF6Y6HL372nSmGuqND7sZGq023DkXIyvrQFYW69f5eB
	qrrKjftJYpWOrNx0pNe50/5Yyi1aWtHfgW+eUd+tHF0RrbjNZ2tn31W0z/tGDqEqwvfSB/3WELP
	1sy99r+TAihHrLqTQqOl28iE5PfM/A/3W92+NE5xah+Aamb32XGdI40yiSN7XypX8BO4dpjAdOc
	9I/tcBqgpBo4gyq7M+g==
X-Google-Smtp-Source: AGHT+IHbqBpQjCtxe9bcHUGWtz/0l+dnLHsBvK5SG2J6Lsb4myJk0X8h64pZKZ/PgVwkog5yUGmIyA==
X-Received: by 2002:a05:6a00:23ce:b0:751:6771:f76 with SMTP id d2e1a72fcca58-763374066a6mr15723458b3a.12.1753708545592;
        Mon, 28 Jul 2025 06:15:45 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.60.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408c0287fsm5590318b3a.47.2025.07.28.06.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 06:15:45 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 28 Jul 2025 21:14:34 +0800
Subject: [PATCH v13 10/12] drm/msm/dpu: support SSPP assignment for
 quad-pipe case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-v6-16-rc2-quad-pipe-upstream-v13-10-954e4917fe4f@linaro.org>
References: <20250728-v6-16-rc2-quad-pipe-upstream-v13-0-954e4917fe4f@linaro.org>
In-Reply-To: <20250728-v6-16-rc2-quad-pipe-upstream-v13-0-954e4917fe4f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753708472; l=9758;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=dKFyKjmZeF9PN4Wn7efC/rAUhNPwQdgLaQ4zoFinDnw=;
 b=EN/CCzOSx5auRQN86J9yiqFTt/XuNVwjLL/EnZzXAIgmx1ijR7DfrttIomzlbho0rVeZrXgfn
 cJBoPoH09KEBm578AZQUgaR2yA8tPXq3uPqEIBR1+EsgDUmkz2whTrB
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
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 160 ++++++++++++++++++------------
 1 file changed, 99 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 55429f29a4b95594771d930efe42aaa4126f6f07..e1e16a8d5ac55ba52a0f460d62901dced65e3a9e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -959,6 +959,30 @@ static int dpu_plane_is_multirect_parallel_capable(struct dpu_hw_sspp *sspp,
 }
 
 
+static bool dpu_plane_get_single_pipe_in_stage(struct dpu_plane_state *pstate,
+					       struct dpu_sw_pipe **single_pipe,
+					       struct dpu_sw_pipe_cfg **single_pipe_cfg,
+					       int stage_index)
+{
+	int pipe_idx, i, valid_pipe = 0;
+
+	for (i = 0; i < PIPES_PER_STAGE; i++) {
+		pipe_idx = stage_index * PIPES_PER_STAGE + i;
+		if (drm_rect_width(&pstate->pipe_cfg[pipe_idx].src_rect) != 0) {
+			valid_pipe++;
+			if (valid_pipe > 1)
+				return false;
+
+			if (single_pipe)
+				*single_pipe = &pstate->pipe[pipe_idx];
+			if (single_pipe_cfg)
+				*single_pipe_cfg = &pstate->pipe_cfg[pipe_idx];
+		}
+	}
+
+	return valid_pipe == 1;
+}
+
 static int dpu_plane_atomic_check_sspp(struct drm_plane *plane,
 				       struct drm_atomic_state *state,
 				       const struct drm_crtc_state *crtc_state)
@@ -1023,17 +1047,20 @@ static bool dpu_plane_try_multirect_parallel(struct dpu_sw_pipe *pipe, struct dp
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
 
@@ -1048,11 +1075,6 @@ static int dpu_plane_try_multirect_shared(struct dpu_plane_state *pstate,
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
@@ -1181,36 +1203,69 @@ static int dpu_plane_virtual_atomic_check(struct drm_plane *plane,
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
@@ -1225,42 +1280,27 @@ static int dpu_plane_virtual_assign_resources(struct drm_crtc *crtc,
 
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
+	for (i = 0; i < STAGES_PER_PLANE; i++) {
+		if (!prev_adjacent_pstate[i])
+			goto assignment;
 
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
+		if (dpu_plane_try_multirect_shared(pstate, prev_adjacent_pstate[i], fmt,
+						   dpu_kms->catalog->caps->max_linewidth,
+						   i))
+			continue;
 
-			pipe->multirect_index = DPU_SSPP_RECT_SOLO;
-			pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
+assignment:
+		if (dpu_plane_get_single_pipe_in_stage(pstate, NULL, NULL, i))
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
@@ -1273,7 +1313,7 @@ int dpu_assign_plane_resources(struct dpu_global_state *global_state,
 			       unsigned int num_planes)
 {
 	unsigned int i;
-	struct drm_plane_state *prev_adjacent_plane_state = NULL;
+	struct drm_plane_state *prev_adjacent_plane_state[STAGES_PER_PLANE] = { NULL };
 
 	for (i = 0; i < num_planes; i++) {
 		struct drm_plane_state *plane_state = states[i];
@@ -1284,11 +1324,9 @@ int dpu_assign_plane_resources(struct dpu_global_state *global_state,
 
 		int ret = dpu_plane_virtual_assign_resources(crtc, global_state,
 							     state, plane_state,
-							     prev_adjacent_plane_state);
+							     &prev_adjacent_plane_state[0]);
 		if (ret)
 			break;
-
-		prev_adjacent_plane_state = plane_state;
 	}
 
 	return 0;

-- 
2.34.1


