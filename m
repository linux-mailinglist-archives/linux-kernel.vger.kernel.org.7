Return-Path: <linux-kernel+bounces-753558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5263AB18484
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85FA565D5B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1081F2571D8;
	Fri,  1 Aug 2025 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bc2xHQd6"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB02571AA
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060888; cv=none; b=a4l75eNxsdN6W9lGb6o2Mw0GM7QiEKy9J9MrNQ2VxNX5TRsZy1WxHOaHUCuFYnBXFj4ezIM8cnagjgcVfeLAHm1jzo6Gzfe0G1fBKHXzjEW0wTJDHxv0S2q/jFiYKWcmLZopIwnxCGOm7sNhzn+4uIq7Q0ndwmceWbQ6UF2lydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060888; c=relaxed/simple;
	bh=KP97mkf4mFx6Hynpv+UvTtqAjJLhCHcsa39rmhW+j40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CQqstWENWSvpX+ShvsdUccmZ5ZhUKqL/DIO+RRL1Ih/zvYi7wENHs1owIACGqGudi1gVpWuMKEldr3bPjMNJK40lkbR3f1tpQkcpac/DdfdSGZs3K0danDd9EDUE8k3kM0cTEbaCTzyzJ6RRAQtqHeK/VOc8aTCMPHUVo8UiQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bc2xHQd6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24014cd385bso12751605ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 08:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754060885; x=1754665685; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rf99YwbE+zk9ZgJ2ORD0W2vahwafwsW/a1Bh6B8t8K0=;
        b=bc2xHQd6D2HGLfMPkf0XPeDJyc8xtcIMI1yERSnoAnuJZMRDnhtCbywVLKNn+UjxcY
         ZVMs0tWCP5OT2mlFrkn46rYstCV+8Hmdr8b81HLdw5L72j1G7K4fZ/nir0NlKtCWjt7f
         o6JWrFS5/FWYNrwsf00DXWAPZ0WzgEjrSXE0qTyRf2CIrEfzKLPigMmDgtG1h+CEPLB+
         8xvLWQdQUNfmhoMTKObJc/ImvjWFPydypF25zorEFUQSJLEZAiCKlpAmS18xx9CPCOiQ
         kXI6mFaxGsxHJo+HDJjPXZ46gXtF97XLyBpI8jrIAZU1Ic4KN2+fomZixYuRV/HubJ1n
         Tnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754060885; x=1754665685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rf99YwbE+zk9ZgJ2ORD0W2vahwafwsW/a1Bh6B8t8K0=;
        b=SAwrGdtHQwWKromMp1KeMM4ooAad++dshgNN0HNLqdAO069g6q0bRj2jBphtfzGV3F
         K8g0wHE+qPxohoUbJrXewc3VS397nJfHMBLM6DTMuuWHniusecPqhHDxBrh4PhUNWO/7
         I94UpkDJ7H7ZKEtxshlxKK7+G/aYMwZHg6+a2lod4iB0LFytgSedAc/3ugvKR892xYxH
         jREPmH2JwDWR3Cm9o+8AoIsxjllFiT8XnWKx2RWhkPBI+LSXWFy9zRFqzvZ0EGQPFvvl
         +2i4tMN83PgP+KfumcPcT1EBVse9RRxw7hPMx4PEMN5WDWD67g2A+iihl7iRhpfR+nDK
         fI7A==
X-Forwarded-Encrypted: i=1; AJvYcCXMLZLEYMX2w6OGS3REDpMUbvpGDIURk2SS8eGvuDA4l/wYShLfPxjmQF6Z4b6UvotKrINYVqeLCaQ4vh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJyU4SAKGZFreVmwZOqPUNmN4iELdaiq2SJvpJz3pDOe4xxpL1
	/Ryh5szWK+WqELiwbHQaosId/bPIugnNjo9ZumKGdQW1+5B3xXSNtThUdzsotOwoKPw=
X-Gm-Gg: ASbGncvTMtQIP7Q1U78z75QAe6oeqhT0OJ0xh9P5+E/556OEgl95OY2752x2qw7NKdw
	Jjjwt0iC1FOVEFF+9TtMPJ43HFBPBqDtlhVe5BQY2UcjbBxaRa4S3jB89+bVdKp9cAX1GYGfFif
	Tu3dUv3/rMilPOTv3gigk2OoyNikrmhj1jjBuTlTzmS/WRUDK+xjWddBmpx+y6AStSVU2IBnvoS
	9/KsiX8Fp/nv54DP0rRuxZ+s+7e6xDEslzO1/R2PuKY7/j7xVvhLZFYypUJOJrEyUzeLAliYKOh
	QdGcVuNBPpYCCSmQd4+SVcdYgrZF0Q9X0sDl6wXUc4aXI6EAl+g6QpzAB2+UZUNuwIqsFUmdLxF
	ZOLEQwS5rEdL4ecDitA==
X-Google-Smtp-Source: AGHT+IGiwYm32MVhjAi/R8SAhYPDtoGfgkZqyTUOInwqu82Q9+Cr13JsjqnX0HH3RV2AGlVvh596rA==
X-Received: by 2002:a17:902:d2cd:b0:223:619e:71da with SMTP id d9443c01a7336-24096bb3420mr176856955ad.49.1754060885202;
        Fri, 01 Aug 2025 08:08:05 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.60.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafa11sm45639705ad.172.2025.08.01.08.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 08:08:04 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Fri, 01 Aug 2025 23:07:27 +0800
Subject: [PATCH v14 03/13] drm/msm/dpu: decide right side per last bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-v6-16-rc2-quad-pipe-upstream-v14-3-b626236f4c31@linaro.org>
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
 Jun Nie <jun.nie@linaro.org>, Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754060859; l=1985;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=KP97mkf4mFx6Hynpv+UvTtqAjJLhCHcsa39rmhW+j40=;
 b=pF1qZrZf2S+wUGQF/vCeb1xQMwFfn3f+VOwpEVhumT1JmRUWshKxSjhwjlppjnAQvIBf1Y7p3
 1qpy5d8fWD1BpBpuiMdy9fhYKpn68tPwOZpZ/FxZvmQCDofhsmcoE1N
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Currently, only one pair of mixers is supported, so a non-zero counter
value is sufficient to identify the correct mixer within that pair.
However, future implementations may involve multiple mixer pairs. With
the current implementation, all mixers within the second pair would be
incorrectly selected as right mixer. To correctly select the mixer
within a pair, test the least significant bit of the counter. If the
least significant bit is not set, select the mixer as left one;
otherwise, select the mixer as right one for all pairs.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index d4b545448d74657aafc96e9042c7756654b4f0e7..9a40492e5aa961f7180ba4ac6c86e06fcccef8c2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -377,11 +377,10 @@ static void _dpu_crtc_setup_blend_cfg(struct dpu_crtc_mixer *mixer,
 static void _dpu_crtc_program_lm_output_roi(struct drm_crtc *crtc)
 {
 	struct dpu_crtc_state *crtc_state;
-	int lm_idx, lm_horiz_position;
+	int lm_idx;
 
 	crtc_state = to_dpu_crtc_state(crtc->state);
 
-	lm_horiz_position = 0;
 	for (lm_idx = 0; lm_idx < crtc_state->num_mixers; lm_idx++) {
 		const struct drm_rect *lm_roi = &crtc_state->lm_bounds[lm_idx];
 		struct dpu_hw_mixer *hw_lm = crtc_state->mixers[lm_idx].hw_lm;
@@ -392,7 +391,7 @@ static void _dpu_crtc_program_lm_output_roi(struct drm_crtc *crtc)
 
 		cfg.out_width = drm_rect_width(lm_roi);
 		cfg.out_height = drm_rect_height(lm_roi);
-		cfg.right_mixer = lm_horiz_position++;
+		cfg.right_mixer = lm_idx & 0x1;
 		cfg.flags = 0;
 		hw_lm->ops.setup_mixer_out(hw_lm, &cfg);
 	}

-- 
2.34.1


