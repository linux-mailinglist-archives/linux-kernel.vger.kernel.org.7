Return-Path: <linux-kernel+bounces-747999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE68B13B44
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3612617D64A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADBB26B2BE;
	Mon, 28 Jul 2025 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ip9/MBIY"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F20268FF1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708517; cv=none; b=LYpltpgIklhSXeyYS8jnLLvYoQ9RvAVGjCiEOvVlBfGlyokThYgkcAz1qUGqbNhH3HutzSUKo/xH2nWTUygOiCMppiknff0b+x+QAbZFWaR9vMFoiNJg41p/Pn6aI8wP44frz6RKFyXCc4P4ISjLJCPdHSf78/X2CwmPL+Er0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708517; c=relaxed/simple;
	bh=3U0bowJZD1UHEussz5PlKOBS3bAoQPdxBHy2P4TuJ5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVCu+tgnXfItR8GwHqChk1oLaQPaabfpkcaEragj8Azl1TPqdrjGiP/upazCmSb0qpnMznGz4X1jUiuYOpOYfSnhTFfVbbH+oBbncqdXuP8uMP+2w7RXRF7417gQNKk4JKhjadNEbTzfiGjmrpzOonugtm0llg9TE9a39g3PmEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ip9/MBIY; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73c17c770a7so4716635b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753708515; x=1754313315; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKfocSyum6c+ZXGva6cBv+Qtfqbf1qkUCIjZpV0tOYg=;
        b=Ip9/MBIYwR3cN+JXil+jvh5el8YxyayJ9Xqrs97OZ0czvf1mZqlAhtFTSU3XJlmSD6
         mogM8oIwWTilzOVdCQLWNd2ddbUotImDTHTvnT8/mg/YFwJVpTu4/pXpTDeLpI37AGJY
         heXAcvqf8Oe8tfKu6AjJfv1N9Ge91N/9QuDYrrpLxiF78EQvEV1HN9a8RENzWWDmcwqB
         OS5jLWTz3IxhOO7K+d1WpTRvKecBPfkanadi8gut+i4UUGY6DAOpcqymXMqPpCFMyJUY
         BfF0LpPKxM04+hwVFj0Bfl14pEqbcvx1XS+I+8FmQ12+DYeK63VTQYGdtV8GP3IPhGdZ
         fxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753708515; x=1754313315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKfocSyum6c+ZXGva6cBv+Qtfqbf1qkUCIjZpV0tOYg=;
        b=n1JU5AzX+aOHwHq5PlG9OnYnWO8J+RlwT3P1Twu9WT+ebaPHGeVyA2sCwDQmTjnc4n
         ttJqepdQKvX/2m/zy2VHB5r8i/CRoPNJz+CUusmMeLgcnYRBJA5746htSM2QBdptr9Dq
         aZGZ74CLxU1gVr7dSL2q8CF01wlnoqdXGK95JtZFvJX3Ufee8Ly+ZKit2zYRLMGrj5Z5
         nZ83t3G6Ca6wghKdhhlHYKK4q/SgSE6GoAnxy/tipWTqYWehR3dNfydWlEy1YY9QzKCw
         Zl527oTkBPP9hZwSr0tlOjzXo1erypdpHyemI03ueEb/K9LhEqyCpcqfGprcjnhV3tNy
         QYZA==
X-Forwarded-Encrypted: i=1; AJvYcCWSdqq7lBxlx2NaRhs5B4+KVwICVfPvNKxtfkblSB3n0HkZZhoqe8l7w9JjmDrD5ewipGbHSdNt/GJmfYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjUzd3sM0dof9BpzBkrn7A6jyUDhKSSUgNWgZFKPgkSVglT52O
	aixCnIKzkVUPtlGKgza13KCLxB5e50nFpd+1Fq7i5I+a9L80zpG1SP/VuLnNyX+mAuY=
X-Gm-Gg: ASbGncsg6K2ZpRv1FQjEKXn8KELfCF2c7F/hTDTffbj+s/aaiIaVZeOWJGRVSfUvXDD
	g1AE5xj5vVfJPNwnL2+u2r+sxLwpbDcW11dRHQTcqvuygE2OCITCw+6W0dt1eOxsi7L6k6uKutG
	kU43bxxcOp2xQrr3PhZEwwBQ2oB/WDPOYdfp9YNLEO/hjO/TGSq1hSCzodkPDP1zeoyw9XPckz0
	7vaytLg6rKURJ9odLwfdq2YUxqClYIu6TW3ezjNtkQcaDBPw4qumLbXBarlpU4nIvhTDKqstSFq
	p2XEhWdopsu11zEYGias/qDePN1FHyJVTuNVPghpZfFq6TJSsbYkMi5w5iYBgkQgc3+hqw9wvxt
	sYrP+W+A4/U5eokJSnQ==
X-Google-Smtp-Source: AGHT+IG627h4s8TzpNVHVzRet6w2TezxDsYEi3mVK9MUyU17fql3o4Yd6kGo7YPE8teLTsG/doWEbw==
X-Received: by 2002:a05:6a00:22ca:b0:74b:4cab:f01d with SMTP id d2e1a72fcca58-76337014813mr17169239b3a.12.1753708515011;
        Mon, 28 Jul 2025 06:15:15 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.60.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408c0287fsm5590318b3a.47.2025.07.28.06.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 06:15:14 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 28 Jul 2025 21:14:29 +0800
Subject: [PATCH v13 05/12] drm/msm/dpu: Add pipe as trace argument
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-v6-16-rc2-quad-pipe-upstream-v13-5-954e4917fe4f@linaro.org>
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
 Jun Nie <jun.nie@linaro.org>, Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753708472; l=2487;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=3U0bowJZD1UHEussz5PlKOBS3bAoQPdxBHy2P4TuJ5A=;
 b=2E9xmcpuhxUZv8IFdqhxakZ6y9VSScGQZKVK9b9CXt0soD/bO89oUUJvm/GI3BLH2vcinJ/6d
 bUWQxotWu3pCxl8fYtTgf2gfVV8IC7eg40kPVx6skBIxgXRsOXacda9
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Add pipe as trace argument in trace_dpu_crtc_setup_mixer() to ease
converting pipe into pipe array later.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 9a40492e5aa961f7180ba4ac6c86e06fcccef8c2..cd0ec3edfe2fa8132e114bc1544c389141d1c1ec 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -419,7 +419,7 @@ static void _dpu_crtc_blend_setup_pipe(struct drm_crtc *crtc,
 
 	trace_dpu_crtc_setup_mixer(DRMID(crtc), DRMID(plane),
 				   state, to_dpu_plane_state(state), stage_idx,
-				   format->pixel_format,
+				   format->pixel_format, pipe,
 				   modifier);
 
 	DRM_DEBUG_ATOMIC("crtc %d stage:%d - plane %d sspp %d fb %d multirect_idx %d\n",
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
index 5307cbc2007c5044c5b897c53b44a8e356f1ad0f..cb24ad2a6d8d386bbc97b173854c410220725a0d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h
@@ -651,9 +651,9 @@ TRACE_EVENT(dpu_crtc_setup_mixer,
 	TP_PROTO(uint32_t crtc_id, uint32_t plane_id,
 		 struct drm_plane_state *state, struct dpu_plane_state *pstate,
 		 uint32_t stage_idx, uint32_t pixel_format,
-		 uint64_t modifier),
+		 struct dpu_sw_pipe *pipe, uint64_t modifier),
 	TP_ARGS(crtc_id, plane_id, state, pstate, stage_idx,
-		pixel_format, modifier),
+		pixel_format, pipe, modifier),
 	TP_STRUCT__entry(
 		__field(	uint32_t,		crtc_id		)
 		__field(	uint32_t,		plane_id	)
@@ -676,9 +676,9 @@ TRACE_EVENT(dpu_crtc_setup_mixer,
 		__entry->dst_rect = drm_plane_state_dest(state);
 		__entry->stage_idx = stage_idx;
 		__entry->stage = pstate->stage;
-		__entry->sspp = pstate->pipe.sspp->idx;
-		__entry->multirect_idx = pstate->pipe.multirect_index;
-		__entry->multirect_mode = pstate->pipe.multirect_mode;
+		__entry->sspp = pipe->sspp->idx;
+		__entry->multirect_idx = pipe->multirect_index;
+		__entry->multirect_mode = pipe->multirect_mode;
 		__entry->pixel_format = pixel_format;
 		__entry->modifier = modifier;
 	),

-- 
2.34.1


