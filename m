Return-Path: <linux-kernel+bounces-747998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 972FEB13B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E335189ADBE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994DC26A1C1;
	Mon, 28 Jul 2025 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdpivSNj"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EAE266F15
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708512; cv=none; b=gOLZlOlIYCvdiI0SoGKhvXDwOBVsleDhP4rTMntMH83jsDJJIuwHTNT1wmQn8JqioDAn/vDk21U70l6myaeDn0n+WDXAif0aW5ZKFAlCmAoy1c2Hd36wEGbX1560hDMWjChJQ8auGAV8V/3AS2H4vTQzTUDqJ/OxAt+vgvNWcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708512; c=relaxed/simple;
	bh=flbnou7XSx1ETCmAxdlZnvB3+bqdNxru9LUU48yIE7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V54Qh0pko6AKMnAAkZ0iXdn8+z0HA+tqxMPtT0MVpR5dghNJjefWG6dUlJYWN+I/GrXFC3y7CksHPDEcvUpX/UB04oketwbnp+CXvtb0922/hh6oM2Gtqv5GZOlhVN/6hpVIlAhpQmFzz3K2sZr254DhyZC2epNkMCf9RuJNuAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NdpivSNj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso2523457b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753708510; x=1754313310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZKppSrZ04BhPYsPEMDVl7eb2YZ+sFy//28ARL2GCmc=;
        b=NdpivSNj4xvvsPOJLLtASC/NYx7TL9hlJeciWpP641x9Ls2vSX55bDDGCM1zTOpcNQ
         ae/v89VN0vX2Wij3G52RjvvdBYX72mvQrYju5JULCvlzXpvsvK67vj4sw/Rum58kjeXe
         98rPz9WRBmpskvK6ZDulHRTw8cGPqsxj01YSN8lF+c3WbIjemhKHDjQA+t61bIP+JIQr
         B0pBh3k54lRI7pK/L3uy/zsevZ87EUqLK2AtfH0x5SY95FchHVFutCfCJJ73QyBe5iUH
         kt1NcP0blOk1wY5vHPYlqfBBliTclsW6MU01t2XGPojuCuq5Elc2DSQXn5l7eNE07+Rf
         Q3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753708510; x=1754313310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZKppSrZ04BhPYsPEMDVl7eb2YZ+sFy//28ARL2GCmc=;
        b=ptug2eTSz9hvxRMVCg6md6JZ3QU2ros0QArjXb7RtMZwKjkxZOaZizGnQ15qWbQGvI
         YVnc+cQMUmo2oTaZByFzhnzOgxGSUYbwMScP79mB3JIO/gZKSLwm8uviUewyqbBR9pSA
         JNNlGPIqoaQ32rHPXLQs7U5G8ey5tDvrqo3g4R5viWAT3k5XxGC3tIIu9mgNdM2cyvEN
         JqJ03pYzkebh8OjbCZ8fXI4VGKJaLcac6Xf2OvGHDwFwIUlTwUGqIKx0xPsLfmgOTkRE
         yZSmr3Nqs+4benIhVaY7MtLf8k3LFIaXWbXjOZGJo3y8kk05/jIu/bdBHOvu/F+7j0cu
         bbbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVatuJCmb2iiZbGagyYd1yjkXGGYrONoOV77It+wySbDa9vXmN8EYhBpYIQMImlEvAhbiQ84mW/O3IcVqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLEbX9a6gXA1UhG/aq9AUISbotvxxoTea/KVH4c+OoMA/a5RrA
	AUIOFlGi2+MloMcsoUsrhh5m03LT30MzKVdVll5JiuxtCycsiZqo5TDWZhsm14NUwAY=
X-Gm-Gg: ASbGnctcIW3FLtxWjpJIAcKP+ihzeeez1eVInZhxOQV1Y6GQ5HGRw2PI6eRWN8ZifY2
	Rv19J3RSQUD89jIrwftAw3QHkivrCBgszhuQxWedyrYtbl65S9rTTJ7dDo11d7jTGV+Leq5iBN5
	h0chTJtCvSnZP8MMIaWpoXq2vJ0NUYmJ+Uk2XfCX0I+kI9HJW1tlRH7TKTtKgD4vdZXQWR6Jo4r
	kFs3fcuhOwtnRPQN3oLYUS/yXoy8Zg3k0UDEYPuwMwJyyYDopOaV4z3hHrPHqGyY2jxsasFTKpS
	VKznBqfv/3rYsE192ipZqHo65wVrm6GfXKYhlQltI9FsKEJP3JhV/QQsrzP/hQ6cy+6cilo7N8I
	Fq7NaQ3bFSgl76EaP7jDcU4EKY9/4
X-Google-Smtp-Source: AGHT+IG+JbwyDUG7pX0QI1BqFWP0lb0OYydB+BpasTxsom5LPqVzrzwiajyvHToI6cH2mOOlOZF3xw==
X-Received: by 2002:a05:6a00:10c6:b0:748:ff4d:b585 with SMTP id d2e1a72fcca58-763347bdacdmr17649834b3a.19.1753708509513;
        Mon, 28 Jul 2025 06:15:09 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.60.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408c0287fsm5590318b3a.47.2025.07.28.06.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 06:15:09 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Mon, 28 Jul 2025 21:14:28 +0800
Subject: [PATCH v13 04/12] drm/msm/dpu: bind correct pingpong for quad pipe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-v6-16-rc2-quad-pipe-upstream-v13-4-954e4917fe4f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753708472; l=1809;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=flbnou7XSx1ETCmAxdlZnvB3+bqdNxru9LUU48yIE7A=;
 b=Ze5paCQmaim3zJLE+SGSxm+xuFv+T0ykWoQxHFa9eh0exvmqLFyGEoTIgJBruGpU5h0dCU5bQ
 XzB2G6FTTm8APL+bSd7UT2Q3ACByObc4/Y7dSxbfgklxj9Ilef2hIEf
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


