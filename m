Return-Path: <linux-kernel+bounces-822861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CADB84D36
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1A21C07797
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8404130BB95;
	Thu, 18 Sep 2025 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQdk1qEr"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005F730C0F6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202167; cv=none; b=oLu3E7VkSY+kzzDAznrtMZtuBhvkgelbX9V/hnBQg15P1HJGLiDjQ3Fj5idWV1NVk/zo3UIfwyqtuWX/u/HY9i55ph4Pb9qQQ1B0yUVgNakEVTf//Tk+NPRmCbOYQ8zfjy334W+ywNBQEHFmiG1xhVDeSR+/tDRMZTwtpjpYZag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202167; c=relaxed/simple;
	bh=f/Sw/vwQEvrkF3u6LWBntZd5AAvvANHPgf3CTk8y8Jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJfk/vIQqcbsKTU7GVbmFdIXsu/ivTeq4lapqd1H5qElI6mjaDlbNXd3qhs0E+/+Z4svJtdmt5VxMz+JGl1/kerbWKg8G6Ezliq6fmeNp7vozkfnGnkh40z40FcQ0KEAJ0VBFC/V+p7Gl5bE4xckGhWOI7tAPkbynncPOhegIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gQdk1qEr; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so861847a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758202165; x=1758806965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SW4I0bHOJyIFQFMrj5TK+GBNLfagwAY9utI2/PYagvo=;
        b=gQdk1qErl27j+om+WYSBqETuCLEarVBbrbnlOhwToSbLhzVwvkJHr0QojXcTQsfR2O
         6BkgQcFXSEVEOAHtGW0F3XGDCtgYWVm0zJ5h6kOX4jwOJtRZgKjcFBEu6XBSv8JB9gCJ
         uhVJ7DJYWRRC1r23oLZbC5iCojFhEWlEfpkiVnrTqDCBho8zzyEggV+G5aSEvDqJvEy6
         EeWSkHg2Vn3CH1NmZEpA7KxpwlpFSQDytYeTiMG8AMr5N3VpUEgVG9fNKuOgDY5E7e26
         zjj4QPAE2/7OhQJfm6LCR5Y0GYuyLCAOVS+DlxkcO5ESbDHed8QXuU1vpYmltu4cZyG2
         9fvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202165; x=1758806965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SW4I0bHOJyIFQFMrj5TK+GBNLfagwAY9utI2/PYagvo=;
        b=V8pSeCTMn9FI4pD5neaVK+wlv+HlNG7+T1rQrbk7dTs2zi3HPdJD78iZVSVdI9kPW0
         Xm2CIu/MnQqNwxjdUeXaBhnO9bnwvhTKqOrskabbX8XwWqRJgxx971KzDDAD6fNNM4s/
         9Ztb6UBF1SrzBG9ei7h+HRT4gfPwcEMQApZk6hnc5wuLwSmgNa/y8AfVGAY6Yk22STMT
         k/hH2FmuAdE6oT5G7WTz9XhkDvX+NFTaFk9uiddBo4ZAeLvTXlFPCYprwWbCtQsWqndL
         X5CuknGqTo4mYD/cr2Ulg7MQREg4TmW6KM69j0RrH53phe4/U9twdMb/FiTa8Sr2gFoG
         QDjA==
X-Forwarded-Encrypted: i=1; AJvYcCWdzO86RbQBQTDhOKBEyOjtL3dU/iqmuAOG4fddBwozODXdt6kdbbwR9IsNMPMFdwaAwnHdnubcOOk8jxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvMEU4TgmvG0+77c9IOy8FkBEGD8mXnWtaVBUHdHljxoNUCevK
	OmgWKb9pzGBYjZhayU/dv6U3q4g/Lgwv5QDmGbts7EzdJ0IL4UULsrVM0v2eZQcHZEgjzay2ROV
	L0EsTcfc=
X-Gm-Gg: ASbGncufm4sArBvKF9JwHnvhinzrxNMlg/EYC5EZrnXZjDvYockd9Q7wOKMZfcVWZ36
	RwV7MUHc/8QuixJLbesQ1PXAgLoy/e2dFX6JLqTi/P+pL9YLRDLMAwtyKMoq4AvzlO8LN0Yw8kG
	431lUm8I0Jc1D/ih5+QK8i39l0aXtEC+D9oGCKrzZfx0JoqIt4oyUxQgo34NdJSQgRvsVxxa1QO
	mY9KqsMshIOInMQV3YK0Ojx2PcaHRCLWX2yTp8dT7HJFa6d94yOWAlEcCHuTmG5IhbanHyxQ5wx
	8fiWK1qpPVjdMiDehMzPQJ4T70ZyItKOqBIbgKQtfJP6QMElqDsMEWKfH34N9iVQnMchTUa/eo4
	FcIjunalYqeeGHmBEcZ2vx3GcuD7rtztthbw=
X-Google-Smtp-Source: AGHT+IH2BOShDFL1Cf1QibDMgt7GXFKPflGMs+oalRPNEjL00mKNm0WKOv0PuLnvFP5Kmrkq4BfVkQ==
X-Received: by 2002:a17:90b:2249:b0:32e:96b1:fb56 with SMTP id 98e67ed59e1d1-32ee3eaf849mr7991245a91.16.1758202165117;
        Thu, 18 Sep 2025 06:29:25 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff35cc76sm2331479a12.10.2025.09.18.06.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:29:24 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 18 Sep 2025 21:28:54 +0800
Subject: [PATCH v16 02/10] drm/msm/dpu: bind correct pingpong for quad pipe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-v6-16-rc2-quad-pipe-upstream-4-v16-2-ff6232e3472f@linaro.org>
References: <20250918-v6-16-rc2-quad-pipe-upstream-4-v16-0-ff6232e3472f@linaro.org>
In-Reply-To: <20250918-v6-16-rc2-quad-pipe-upstream-4-v16-0-ff6232e3472f@linaro.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758202147; l=1809;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=f/Sw/vwQEvrkF3u6LWBntZd5AAvvANHPgf3CTk8y8Jw=;
 b=8qMPBs6WF+TiriJSLAoXhaLroMMsTySRuEA3zKlrDBrgXsBMnBiUWxdE4gNtj85pxNPvLgUYl
 pLA2HenSuA0AB1x+Ez09YcdO34tmtXeFRknhiDPGQ92BmJDXLXq/hXM
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
index 258edaa18fc02f837122c84842b59f2cee68d66e..1318f9e63ef1e7bab078ae17e39d9ed19c04f465 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1160,7 +1160,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 	struct dpu_hw_blk *hw_ctl[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_dsc[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_blk *hw_cwb[MAX_CHANNELS_PER_ENC];
-	int num_ctl, num_pp, num_dsc;
+	int num_ctl, num_pp, num_dsc, num_pp_per_intf;
 	int num_cwb = 0;
 	bool is_cwb_encoder;
 	unsigned int dsc_mask = 0;
@@ -1239,10 +1239,16 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
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


