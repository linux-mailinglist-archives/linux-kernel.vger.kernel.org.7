Return-Path: <linux-kernel+bounces-774682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7D5B2B619
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13BCB1965AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FB71F03C5;
	Tue, 19 Aug 2025 01:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKMJbsZk"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E6E1EF09B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567083; cv=none; b=Q48ynvXdW7r2YG5uN/1W0jdzqDgm49vtgmUTtkWGmUcPpIvhL4eZGRVxJ4CBzJrbJxY7apf5gPeZ9IVeByUveHmHv98qbUh0Vff6jKDQQhTsbRncZ/Ycztt9/+PMq2HtNNnAjKQqmemoxiGE1cHXyVhTIg7fyIu/6+yH9jjYSpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567083; c=relaxed/simple;
	bh=KP97mkf4mFx6Hynpv+UvTtqAjJLhCHcsa39rmhW+j40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V2EJv8RuRYKrfwm+kbMXzixgWe4oN/OCgnX6qo0r6Un2vcF/LpO5B1RRAnWDp+rxSVh234+WbvlIxOoSYC9sMfnz4qP+FKSzndeQwmF7GOF/pAV3aive1xontH/3qCeIp40EXETKO+8LD0XjcHftB2ho87ERxnDCwkoNkkvB+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vKMJbsZk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32326df0e75so3898109a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755567081; x=1756171881; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rf99YwbE+zk9ZgJ2ORD0W2vahwafwsW/a1Bh6B8t8K0=;
        b=vKMJbsZku22c55ifBnHkn6CLm5kkNctY9KdGeQ6d9B5wyd8G5Bpcf/I+ywhQuKVeRJ
         g0VQrRGE9NwUc2dcUDSG/+LMu+JxwRJiuxUs4aD+rlO7gkXlUHx7B+PLaHu48GqR125V
         ULPrJ6pR5ypQc+bgoeWB/E59uUzMvreupZWVtXgdHquMvFYzvulry76geeHqayx4tGhX
         4KT+cFSX6xdTetk4bGYNpJiT854Brgm+ihXnJzJQeBdxMMtP6FGNlQPxgvxe6XFrYWxT
         L5qFI30/1giybaHqo3OvQblIjb6LQdN8U6PsKdZKCix43fy2bAPdTX864XmeGr4AbUyV
         YykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567081; x=1756171881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rf99YwbE+zk9ZgJ2ORD0W2vahwafwsW/a1Bh6B8t8K0=;
        b=wLkmW2bsezli2k3AS3455mrlEtzqeE5ND37HMZh2XD10xq+GJTgqsbvEURig1hVMyi
         j42MZjSmecXozyOYpB31P/adEf5bCcIsYZwHREar1bBKajNjXC/h26ETp06ZGoaUFVkl
         bT/81KBOFcny6lPZuT49It8Uu2onkc0PdTYgWLygMqSlhSTLni6FxDMpKqFrpg1t+SqI
         Q5bwYwhqYo8I8fDvAfjly75e0KFXvCV5nzoHr+1gU5UPODzeG3wx31AG9cqGDwDK0mxs
         dkLM+YvwZmiNCWM39jlMAvJjyRq/xxTxBsoUtXvCeq9COhoS4WM7EHuLa0DlRTvcKMF6
         ucaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbjZmW5c0gxBEUkSvzhMbQ3KxTGJoGuTiqhbjrqpYSGhd9u6o+jlGB0O860eOwRvTQPaNAqqX6GKGSKEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTbI1ZKhx+vZZcBPk78iLQwq6yLsAl2Ck6E8hNV+Cobc7zcLW7
	GABUefqyMKaGVgmtZrWZrfWaor7hnoNoJ5iQ/BH/EMH5XzeDRnz7f5E4jB6cW7Zmc3s=
X-Gm-Gg: ASbGncskhyw+ho2S7GMT5MOTTFgg1JiG/ni4fJKf0kZqKbVXAJdk3aLaSk3sStwHv7x
	ejbnTmf2ab1p0fttYsdI7XNvzMqeZEpcwzF/Zfy4I4kxrvfO0jQ6jr3nMgxlGfmN7HihO+Jjd67
	B07glppzIcj9ukNa7uRXe2EHE6lEHvPwv8tsKPBk2aVLkGGVWwmYuXrqtlqaju3hqeh2Zn5iMj1
	8Cf99tFO2WOa4EQQnCed8C6L4bUd+NnBnsouuDiKrWIZDvtA6nyH7sVsEq0QNmcWSfSpCtxG2nt
	0Mz8UrMHgMS+Z4IFsrqcytLfHFqeATrhNmVlM+Er7wbl8Biy32RAv2FDjLkQLV/pXJlKLBCHLyB
	kgdI/i390ufbrks5QvQ==
X-Google-Smtp-Source: AGHT+IHsqfSLfsmrlFST+ENYayoezQghp4VEB2nLn4dJzMzMWEWc/lmmasXNyozxF8zA5e3IljcCrg==
X-Received: by 2002:a17:90b:2cc8:b0:311:c939:c851 with SMTP id 98e67ed59e1d1-32476a4f190mr1303029a91.4.1755567081241;
        Mon, 18 Aug 2025 18:31:21 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.60.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3245e4faf80sm248637a91.5.2025.08.18.18.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 18:31:20 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Tue, 19 Aug 2025 09:30:57 +0800
Subject: [PATCH v15 03/13] drm/msm/dpu: decide right side per last bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-v6-16-rc2-quad-pipe-upstream-v15-3-2c7a85089db8@linaro.org>
References: <20250819-v6-16-rc2-quad-pipe-upstream-v15-0-2c7a85089db8@linaro.org>
In-Reply-To: <20250819-v6-16-rc2-quad-pipe-upstream-v15-0-2c7a85089db8@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755567061; l=1985;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=KP97mkf4mFx6Hynpv+UvTtqAjJLhCHcsa39rmhW+j40=;
 b=YoZ5FtiM7UZD4XTi6fivtdVzU+G2ybZj+qrFjggUBlCvL1Krk5X0FNM4ec81wpW7LAShhi1N+
 DMHZL59GWxPCXAwtIhih5Ir2QOQcxPAWn45fJTn5T9iZCg6Ml0flHyO
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


