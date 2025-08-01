Return-Path: <linux-kernel+bounces-753560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4ACB18490
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B855B1C26F08
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F39272E61;
	Fri,  1 Aug 2025 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUQW0Kf6"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1EF269AFB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060898; cv=none; b=sME30wxou6JLMvlmTCGdQDPfTQdrddZseR9Gbj2Scq1ca3MC4NQjLr0J3hhQIdMMS2DVW0/mqTtjRaOipUdqIEsG5vIYeiq1dEl+40mG0XHoWKwY6QWb9LR1uX596IaUf2hlycDSKgzSqEYwvAMnIZbjSaPLAYah9BRWA+arfnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060898; c=relaxed/simple;
	bh=flbnou7XSx1ETCmAxdlZnvB3+bqdNxru9LUU48yIE7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k28fjYvR8363zq77uGwCRNG+JdktSof5blqVo3TyJF5bPA/2sPjjp+quui/I8gq09+ce6B9YUrdpsqbQMId9VjqtRpxQ+0l7nvMsxvC31fyvDgel0dIdpuzlOB15tlxKhvmqb2MKm/tlD6JR9jJVswh9pFpQkXh0nYBfQWJjDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iUQW0Kf6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2406fe901fcso9889595ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 08:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754060896; x=1754665696; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZKppSrZ04BhPYsPEMDVl7eb2YZ+sFy//28ARL2GCmc=;
        b=iUQW0Kf6gHdTiuX3KSi0Ut1jxx2T26Imb34Q5ju3lvlFCWkqbhc/qeUXKNTnGCTjvz
         l2rkI9WXoyl1/qaKfhhU07UI+OWwsl1yp6eWDb7mEOzabw4QeL9ESHsAwF1NRVTlyvt0
         UvLrM3VaJSia4MrdVLtIi0spR8/kk8r5oI9jirRbmuNyoYpVzm0kq4MRjqTbUCszptVw
         SqJVNPaVLU5+K1mGDQ7/zBwjuUgRSvmqfLcZL93Bc6TkhFmeqDlMaKYGStgmv0sa3PdW
         wR97Z8sN/iw6zmYUwREwdNZcl754bsZskF8XfKb3mw/XFWtaemJVUrCOdxU/zhsNrkGK
         uWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754060896; x=1754665696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZKppSrZ04BhPYsPEMDVl7eb2YZ+sFy//28ARL2GCmc=;
        b=fpPCdPYjr2dfQuFDlcw8CtVINQ3gHSnOqNr4djEKUOnwaxxkGwr9SsKjqQLRPm/2c5
         YCuqEiYfjKbS+iLk971G8tV3R0AkYhNRBI08td1T2MDYFZek1aKIlWiVeesA1Tugtfd7
         zZDod8vjCCj8r8yX+3Ys30JJW+I8qvRhqb99sus7Kt3B5/1AqyuSCGEJ1CUB+Ny5v/9L
         GgMMjDJ0btxbnK0IGFoqJV5S66ADgFXiLpCpyr8vLbyWTCnEF43nvrguNFjPQJCdzzoq
         k38Hs6VDorLRg8S+qFTYD6ySl/iPnzYtiN6YPuaRtlXqHmCbq9+U7bzfmQFWu/Bag+q5
         5bTg==
X-Forwarded-Encrypted: i=1; AJvYcCUusCnKzwc06ZCmGvZPdDUDB9i9RPiT9NrS4dOPfq6Nf3eg+yB99U6obs43ZxTddw4TQTqo/2FJxmOTrlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlJZu8cM5GijJohvw0FR9ti3+EYcGel9oza477/tOdc02+YYmf
	4PyDN2e2Qvv//lkpoZriGaHBwd6oj6BPMQghvOSMLMsownXtUr9/+cqe8SHt1BP6kyE=
X-Gm-Gg: ASbGncukjoQYu0Lo1Pda2k+8BRgKVHzZGVXsw7YAW2hzsZQ8ospZZjr0cP1FMjEekpt
	4SjuElmJoS85rtVwALw+52FPiJuzhad/YOdk7ryyVa1BStIPXvfaXII36uKkXuf7GNjZ0WRNY1c
	/M3IGl4Le0+alLpn3T0HWJm529LdpE9ewd9ydt8gDlGSoIFzQcx5JdpScWrNB6SUoC+CL2PFq+X
	zCYX7Ac3/Pesh8Csz+Eoj4xqRPRpp2D7sf3utueVYmiI7fXZ7+7z/NFx9F3Qmw5zEOQasOW1dRM
	h5XEcx4AhIzj1N4XkxCu5nFxxEzFh/KM5nG6PukyPfxPxGsSIaDzG5m2og1XVrhk75D8DaB1r5/
	WFfCJSe5+FkfBjL7bJVB7krWolDp3
X-Google-Smtp-Source: AGHT+IHudz1t4fJf3sr8khfrKOYSdpVB9IVdyhQgqd2MsVqkvh+5HSblDsMSI50Mcf3k+J4yGJSyHQ==
X-Received: by 2002:a17:902:e78e:b0:240:52c8:2555 with SMTP id d9443c01a7336-24096b3f541mr149384245ad.42.1754060896367;
        Fri, 01 Aug 2025 08:08:16 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.60.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafa11sm45639705ad.172.2025.08.01.08.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 08:08:16 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Fri, 01 Aug 2025 23:07:29 +0800
Subject: [PATCH v14 05/13] drm/msm/dpu: bind correct pingpong for quad pipe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-v6-16-rc2-quad-pipe-upstream-v14-5-b626236f4c31@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754060859; l=1809;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=flbnou7XSx1ETCmAxdlZnvB3+bqdNxru9LUU48yIE7A=;
 b=piKOAwo5yTEkcr2BKcOKNaF1Sf+XaCU5mD8ANyKGtHNopaY0lKYvdcYkzc6Ljvv8AJiJv1oFF
 3tJ60/0cxGuAYLKcYSUzmhTMvdls+3vKwYdvvosKNc6928YAsDKk9Hv
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

There are 2 interfaces and 4 pingpong in quad pipe. Map the 2nd
interface to 3rd PP instead of the 2nd PP.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index b476d3c97ac9b6b4c5ca2963aa4a5805d57c8d7e..2d88d9129ec787df6dac70e6f4488ab77c6aeeed 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1158,7 +1158,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 	struct dpu_hw_blk *hw_ctl[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_dsc[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_cwb[MAX_CHANNELS_PER_ENC];
-	int num_ctl, num_pp, num_dsc;
+	int num_ctl, num_pp, num_dsc, num_pp_per_intf;
 	int num_cwb = 0;
 	bool is_cwb_encoder;
 	unsigned int dsc_mask = 0;
@@ -1237,10 +1237,16 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 		dpu_enc->cur_master->hw_cdm = hw_cdm ? to_dpu_hw_cdm(hw_cdm) : NULL;
 	}
 
+	/*
+	 * There may be 4 PP and 2 INTF for quad pipe case, so INTF is not
+	 * mapped to PP 1:1. Let's calculate the stride with pipe/INTF
+	 */
+	num_pp_per_intf = num_pp / dpu_enc->num_phys_encs;
+
 	for (i = 0; i < dpu_enc->num_phys_encs; i++) {
 		struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
 
-		phys->hw_pp = dpu_enc->hw_pp[i];
+		phys->hw_pp = dpu_enc->hw_pp[num_pp_per_intf * i];
 		if (!phys->hw_pp) {
 			DPU_ERROR_ENC(dpu_enc,
 				"no pp block assigned at idx: %d\n", i);

-- 
2.34.1


