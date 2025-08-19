Return-Path: <linux-kernel+bounces-774690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F71B2B632
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298FC62235B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88209202F65;
	Tue, 19 Aug 2025 01:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hWDs5yAD"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2A71EFF9A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567115; cv=none; b=t9sZcR0vp/1PxC1nI7f8pDCpxPjkJrZuQ2nDCjLOiNEDOMI52Ah1wIiRO42yYP/m/s7s17PotbhTqQqXV6qzV+ktejVY+64dg/3jyNyGX61W6JRCs6xIaT1x7pbT+dpPv+puST3VJglR9ElT7s9KBjkCBUUCn73T1hDJj4ygcgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567115; c=relaxed/simple;
	bh=EMexKmSgbyJrNm4fgVgmbAaex5tIopqSAoqfoqK2ahU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NU4sk906kVjp1FmPCN89/WNLMTYJwkzmaq4Y9s4HRgc30Jv/vVeZfsWTOOSAhu1s/e4zYv2xx0l7zU7PhO7wKkET0qpY8JdfqTSa3g9gNUXP1pXmsf7kNtjs2aoH7KlEoEAguTG7jH95fvXpkCKt/4YkqVcH1ejbriLxFw5SZ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hWDs5yAD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-323266baa22so3679218a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755567113; x=1756171913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILXciEgW0I//qoLe7GzIdmNaMHGieJ0bsFVXKGQw/3Y=;
        b=hWDs5yADbZL03OQQVZyIX2mdmJsuoaK4lX4bUOmLBjFO31oISm/T9DgUJSGvFFxSvs
         4hfkplRpJQYvjnbC+sbUZgo8PcIdHirRuyMfhZ3LMbcOHa6gaTLRgdE+8p0kQqR8PjEQ
         2+SVcPtSNP2qCGPukgoQe7tmJCQFkDCy5lnXmd9R8CUkzy0ZR1Oe7K9BoV0MhRCvUbbV
         jfdeTYY9atIqHLPjf+TInZ18t3CAl/pRL6cTeuC4l2xOnxjnX93pxRvztGyN0wFyGMoH
         c5sc1cCEGhJ8Y6t8S4SHCqEMC1qCxoDSbMDuPnr1sPSvWaVbRAE1g4QQFmlbDGQv/1Em
         fLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567113; x=1756171913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILXciEgW0I//qoLe7GzIdmNaMHGieJ0bsFVXKGQw/3Y=;
        b=sKY/ltJLqZt2FTiha93g4RfHtdhT4NvwyiiOBjmnNDBZiNzYpWl/JjdxoCn4aG93Rs
         zzyLGdTTPpzeR2KSfmRFgvVXFFjpAvSH+wByQkocNF8ypdkjTqeP3l2wzgW3uui0YFHI
         BdIZDKUTpq1wZ9nuh9eW9Btm7UWhOXxx10HqWdaNSdom24FOQenEvZM46dkEi/5UKJxw
         Mo6SvaFE1Anb8lL/tanO4rZQ+ybTPXxEpga+8pcHQ+gr3k4AfleU6b0zoNxZvJ4KpJyg
         EJAZEmBkjCOpJC2xn+zMr3BQ3vjyuF77kPtTBIuLkSjF+cNFMM7vexlw6/3/WHNDR0YE
         AZkg==
X-Forwarded-Encrypted: i=1; AJvYcCWzy2Y+GZixSFdAqvirL7eBL8NLhz0lGU4sLgvWFm1I1NTQ12TmbUy3onlTI3Xf8GjW5b+3/yuHMKP5RUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/cN00iK3vdtPB+MfE3AG4h2Eenhlsd/wfl2BdT+ZOObW3obNu
	2bz2CBqLNxFhQ6tILmfebVC/VJr4oqNRnfgYDnmS95YGS3szWRHvUjQIMasyYS7bD8Q=
X-Gm-Gg: ASbGncu3W6+bB/P/9OjJO2urDNSBnOT4uN35PpOoRHoP2sMPs8xf3gYhgKNMVNR59z8
	SeVYcqdYC/t8CrHKfXDG+XDKHSTxAws5fQ92hvGPPrGB/XoiM4WtpfVTAmP6dINB5UCCQRtMWLW
	2UsaP8uJNHAFP5oC97IS+cDqnTSNYnfCR+L3tW6kJnpv1J3m+fSJ99O9UiQsc3zWGxoCcRNE0bm
	mTTb0HVoh0CWpLOSq/xteQ4Sq1A/J4VigcHbbeOGMLSks4glNwsEZ11d+GxQxv72AlTKfF5jNV0
	AFXYvyhmWhXGxvJwJYNdEVQXMZh/ho7lrgP0e/u3owqgZf9cV0XzX0S6Ollpk9TrVa+9zSH13jN
	wx2BA6uKT2SWy7MIj1oYgOBS2ZHjv
X-Google-Smtp-Source: AGHT+IH2kVjberDRpSlxOjehMswhobbGekKigcmkVDPGGJC58B2H5j6Wr2QGX4eK/xZiHfjmYspfrQ==
X-Received: by 2002:a17:90b:3c12:b0:31e:3f7f:d4b1 with SMTP id 98e67ed59e1d1-32476affe90mr1293364a91.24.1755567113520;
        Mon, 18 Aug 2025 18:31:53 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.60.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3245e4faf80sm248637a91.5.2025.08.18.18.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 18:31:53 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Tue, 19 Aug 2025 09:31:03 +0800
Subject: [PATCH v15 09/13] drm/msm/dpu: Use dedicated WB number definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-v6-16-rc2-quad-pipe-upstream-v15-9-2c7a85089db8@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755567061; l=1716;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=EMexKmSgbyJrNm4fgVgmbAaex5tIopqSAoqfoqK2ahU=;
 b=Et/gGQXTneD5OZkXn8Pgl1NkEtAaawb54PFekqSi7POOha9fmpe+nFaGtNIyJt9uu4hbBiQ3H
 CuZXEeVVGbjBgyAnBLxvaJyamAe58n+gzvGpQsipqZzjf2adMJgCTVr
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Currently MAX_CHANNELS_PER_ENC is defined as 2, because 2 channels are
supported at most in one encoder. The case of 4 channels per encoder is
to be added. To avoid breaking current WB usage case, use dedicated WB
definition before 4 WB usage case is supported in future.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 2d88d9129ec787df6dac70e6f4488ab77c6aeeed..4616b360812491afbe63f8ffd4a57bc9604382e7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -56,6 +56,7 @@
 	(MAX_H_TILES_PER_DISPLAY * NUM_PHYS_ENCODER_TYPES)
 
 #define MAX_CHANNELS_PER_ENC 2
+#define MAX_CWB_PER_ENC 2
 
 #define IDLE_SHORT_TIMEOUT	1
 
@@ -182,7 +183,7 @@ struct dpu_encoder_virt {
 	struct dpu_encoder_phys *cur_master;
 	struct dpu_encoder_phys *cur_slave;
 	struct dpu_hw_pingpong *hw_pp[MAX_CHANNELS_PER_ENC];
-	struct dpu_hw_cwb *hw_cwb[MAX_CHANNELS_PER_ENC];
+	struct dpu_hw_cwb *hw_cwb[MAX_CWB_PER_ENC];
 	struct dpu_hw_dsc *hw_dsc[MAX_CHANNELS_PER_ENC];
 
 	unsigned int dsc_mask;
@@ -2387,7 +2388,7 @@ void dpu_encoder_helper_phys_setup_cwb(struct dpu_encoder_phys *phys_enc,
 	 */
 	cwb_cfg.input = INPUT_MODE_LM_OUT;
 
-	for (int i = 0; i < MAX_CHANNELS_PER_ENC; i++) {
+	for (int i = 0; i < MAX_CWB_PER_ENC; i++) {
 		hw_cwb = dpu_enc->hw_cwb[i];
 		if (!hw_cwb)
 			continue;

-- 
2.34.1


