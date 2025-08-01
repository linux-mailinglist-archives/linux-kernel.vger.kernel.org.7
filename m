Return-Path: <linux-kernel+bounces-753564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E6CB184A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E53047A53C3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5312701CE;
	Fri,  1 Aug 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HC9dgprM"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AC6273D66
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060926; cv=none; b=JzxZv/7/RgSEQ6BXOUCLlSA8gF3ieCfvctzOR5aWedqPci+QAUMYaOYKwqtqBgi58ALbIgpnwyzK6LLfKZ3KaWVmuk9j8SYzVpdwsjeSQav+K2u9KLK6U5aOYIM/zsnzYYhzeVOXmIk9x1IwnpHm/XTunX+BMVIsCYl0oiatiaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060926; c=relaxed/simple;
	bh=EMexKmSgbyJrNm4fgVgmbAaex5tIopqSAoqfoqK2ahU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EHoSrcsjI1apUqRuXGZWEieVsUQr6Wwq3uJInskt94KgWWCElGh8hz5yJDlC9szAozP2wr5hvjPF3agoFSLd9YLlME6oRagNaCu4IRErfMpyYWK2Y7BnY3UTl0h+jktNUqDrJ+8Z1QT7t2ZIlsANkQF9+rB2OeuK/CKbTwG/UMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HC9dgprM; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b3be5c0eb99so1562373a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 08:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754060924; x=1754665724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILXciEgW0I//qoLe7GzIdmNaMHGieJ0bsFVXKGQw/3Y=;
        b=HC9dgprMTnPspTaSdJseibHLteOuIx4LRTwnOA1DLycfygzEEA2mSdiTgDdITJ73JU
         yNUK8tA+/E8T4nF7D+kjaKoHe4Mf+JBRGZR0ZLQCkCzl+sRRXhoYca26zur2Br3BeVwb
         pShGGLM4FzSpU/wrR3FWcsPsc/rBojoKMpgELn6pC712AyeBhQbBMvQrMPEk9thtz7TR
         THfG+Ht+cdM8cx/8HhULC3kFIn+IG3wiTFZcQRCcacJMEMZWb2YKjAdQ43JQDCZhZ4n0
         YHdRc0wUii6nBd3n2FmaxSVHDVQAu5OXTIfWzw72stT1wkxxpt6BKb+66RN9VLNqxzYe
         KW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754060924; x=1754665724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILXciEgW0I//qoLe7GzIdmNaMHGieJ0bsFVXKGQw/3Y=;
        b=byb+2KehHCGbYFAXL7jfYfLNz03B2hjnRf7uWpxDQ9/KcqziPgFyaq2lHBsil789Hm
         +MJKGv42ge/66e3PO7fq8+0t56AeRc3SFUYNgjs1Kies0H/7uz9nsAHYADllUwucqlP5
         WZioD0H973ftwLYQp7PppXwCL2KnDm34+EO1ULnV+goKdVUaEwAJfLg9oaFfIPz3pc0c
         pHcFUe+T3bk1gf0kbZyVGHA8qDTfDsy46a+PYWbmgX0hu5c3XRNFZVBtIsP2x+0bdXdu
         Ws4MKv1PEvheOxXrrkxEQF+l11nTN1J4Qw6zjR41DvmXTlJcrNdVfAtOPUTOPiFfrUjY
         LP8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2x7+kteC1xou7wT3Cv4tDnQbcWim+o+BiB2w/3txkU4ySYITD7sW+xpNgii5Ft/JNyP35KOslJeEJVPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXr0+EjOQvydJGnbgcVx45HNhWuGdVqCw9f7ZiXnrXS40nr06n
	1rc6tl/gxyqB93KZkNjfexOWwMurfd3UIuqxhqit3j/6hD2OcxFOgxYObzB2b90k02E=
X-Gm-Gg: ASbGnctD9ujpigogXrNymgNfyhLCw/XlgHZszzmaH63I37I38AgQhWu7mqXtCdnEEMS
	ybFl93wi7X6OnsGpUuHStUHEvSjOJBvbs/KFo+9+JDtWOO1TmZH3WTN6An6w64Q0KQzDyUK+tiV
	gkcZ5fpV9Qakz+tC89So2WmUGcBgBg7zduE4aWfUGnzxHk7l3Ch9OiV/JXgT6f0N68AMEvWNzkP
	6az0CYV6YAiw1LPLdkHVfCzqXZhzJmyFAcYnL7AxmCCp4pBnwI1K9mcJuEQkW/HmOgLkhD1dxIa
	9PmgdxC+03lZe4kcLOZDByUvLhoisRQlWk5MAp/OqLyi5pYk7TvQMLU4KV1GVOSU3bNu6q6Gz1F
	eegE9P3wH2h8tCB81YjAmAKYUnXDg
X-Google-Smtp-Source: AGHT+IE9UAyxTpK4FvWv3OXz+ocPajVif5bxOvOmnO1SWRMqXt2SsxSVT4XeHmgC4TDkosdykSCiGw==
X-Received: by 2002:a17:903:1b45:b0:23e:3c33:6be8 with SMTP id d9443c01a7336-24096a636bbmr158574575ad.8.1754060923651;
        Fri, 01 Aug 2025 08:08:43 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.60.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aafa11sm45639705ad.172.2025.08.01.08.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 08:08:43 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Fri, 01 Aug 2025 23:07:33 +0800
Subject: [PATCH v14 09/13] drm/msm/dpu: Use dedicated WB number definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-v6-16-rc2-quad-pipe-upstream-v14-9-b626236f4c31@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754060859; l=1716;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=EMexKmSgbyJrNm4fgVgmbAaex5tIopqSAoqfoqK2ahU=;
 b=Z+E7gfuNEZEyh4WTb79WFYqsnLg0ICLcdnjakTmbZ7RdMP3xs/RcV6+pAzmWVDpHSDX7boNRx
 ItHtGmVpMIDCSCe80J0k77eKAwbUpP/rS2yqTla9dZhdnhtR3pwPrMR
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


