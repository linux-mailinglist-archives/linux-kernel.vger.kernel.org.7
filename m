Return-Path: <linux-kernel+bounces-822866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698D1B84D63
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32EE7C118C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D624830CB5C;
	Thu, 18 Sep 2025 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAr1G4IH"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D3630CB54
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202191; cv=none; b=PkjTzKtce/Q9TUwS7GroMEIYPvm0vAbCk82HjMnwcQrZCVe1zfcR0qCx4gGQEcEa6yuD4UlyB8unYoTtXxuoDwBqkixfDk+cHRbq0aRjfIclFeqnJwJM4tnUHscSWAcYV+cEI5EyCP3TKiqVotd5gofqE7o7s2ZI+gLxovfeuYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202191; c=relaxed/simple;
	bh=PRJ+au3DI7HiuWEGK005K0r17ABM8j6SQDUJwlnMCMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YGqxNNYMskzC84+uf9o0vkqKJhNnNpehICKdRCdWDzLDu717OGlV3hPLsDgKhAWisZHt81LXnAJD7VPEfj7vKv82n8b6ag2kSLBXXe+5F3oJNNAbYbTvq2zJjD99lwK/vvbftULUuyXjD/8iz7eRKLFPlZZc5CMPb2Yq+Qj26EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bAr1G4IH; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-327f87275d4so1014244a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758202189; x=1758806989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuRBfqh8CopNeGj4s9JcPIl8SA4pKW/98Tru8VZbruE=;
        b=bAr1G4IHwFwqIfP8XiqxOjqrQOKDyCmF2OyeVQPO1ptRu0jyZ/uWKjcb+ychnESd7u
         SlQjq4mY6QRVIp6blNxHSnKiTfqvp1qbCg8bGDLJ4QxJuzFbIftFg8a2lEdXNTxqq1nG
         Paeagaehi0+IqKZQYzM7wTFHmunwaKbNtTQ16FLZmHoZHzX8FwNwuT86MMEHyg39rKMM
         wLKOg30/EFRZG9nPC/nVMaR0sPCao0v55cV9S6FE72SNayfW9mKyzdrv/2k4xUOzzEg4
         +ZeifKtH6nRnN5yfvb2DmgKqlyDV/X7ZPlNdGOgOoNfhJumTdHd8P8NJTYwSn7Y9URKC
         bDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202189; x=1758806989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuRBfqh8CopNeGj4s9JcPIl8SA4pKW/98Tru8VZbruE=;
        b=Py18saWQ5+U65puCRRulOEl5m7fuATG6xXFGzi4Gti3NUPogyzd9p6bYmKsztACX01
         lp0719zgJviJp7UwLaFXznkA450vf6la4UbMIne2nia2dzBI5MXU0B+GxsfcqOSk0Uh4
         5GcerUv34QLn/tzNjRNLHBigq6Ovtvi7Z4WUGvL+UI6SrOttvRzZpWl3PVFcaPg+GvSW
         Fl0LxSfFPKt4FjO8wHnfWK74HShV/+/UW6TPgzqCADNt2UpZ7Ss+TMzrioWuoCgDOZrk
         YM3Asv70Uv6L7jHxWDGTD5z7c8cnZpDCM9T32TIhXn/hCNjPP8lvDVm7/DegQnOmf8yY
         9gCA==
X-Forwarded-Encrypted: i=1; AJvYcCUIcSMK4exGeqnLLC/4ryo7ddPz2A6IMRF/MqzCZiy+jJQVRouik4lKjSA2ovzhVgiw9zlgGC+BLnBC5YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzAYDkQnJAz7BIkIEYuTOuK3jQ+/0/6Dqi777kPVZ3c//r8Tnc
	CbY0T1WJS1SD6pSQ7AtOmfoQX8TGUWRayEPBq7idu4E/8wHiPrub9ucZm+nWCvY0t3k=
X-Gm-Gg: ASbGncsveTLjunmlwgbG7ffucqkxTeg+4U4ZUNa0yX76aw9OKpbmYhfwVaQwG2BN93a
	nyohCQbpTIdBX9zGMACYWnHGMuXgWHqzlWD/N3rW1cci1QYxuzIExGCkp5GrBp7y90IVnXg1N2a
	NnSSWUIRswEqjBqhaAEkdLkqJAEzfcN6z15reoJOOnIYkqw+lg8sfepPQZN6iWH2DGTW2iY3YH+
	yQVIqyXOPxzokClvmYSLtHZh06NB8tQ7l2OaMAXLKX/WYCrHQoUW4Hs3++GaSXbm0Z3TQHinVZh
	OdmFLejha8nXTao/gInM12xQH1nnGLlqrwBHfDvHQ6fsmpyJvbgP6WTDy9NzsefIDBDkpCXMS1b
	2vi15GsZX0mcRhwnHVCioUwoBOtjBdtwA61oq/zrU5ilQHw==
X-Google-Smtp-Source: AGHT+IHFJ1UXuMDIcizq+VwgouZRP1MpzHNb3lgea1Tc65YVimECTE5UfJoCwJJFEWAwPnexmrET2A==
X-Received: by 2002:a17:90b:4c4c:b0:32e:3e2c:8ad8 with SMTP id 98e67ed59e1d1-32ee3f73a0amr7783868a91.20.1758202188968;
        Thu, 18 Sep 2025 06:29:48 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff35cc76sm2331479a12.10.2025.09.18.06.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:29:48 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 18 Sep 2025 21:28:58 +0800
Subject: [PATCH v16 06/10] drm/msm/dpu: Use dedicated WB number definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-v6-16-rc2-quad-pipe-upstream-4-v16-6-ff6232e3472f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758202147; l=1716;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=PRJ+au3DI7HiuWEGK005K0r17ABM8j6SQDUJwlnMCMI=;
 b=LCib+BVV8wTLxZd2X7O64JU7UwWu9AMDspmPEKtl2onfR7RP0tAEONojfQ5IvOsin/POXyC4Y
 Ua4gKxQopuLDEQAr5K4RUIKczTuh4iGAR4E1AoEZREolcmSf0bb7Cd9
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
index 1318f9e63ef1e7bab078ae17e39d9ed19c04f465..55b83ba6102d38a9ec97bc4d12ad31810e4b261a 100644
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
@@ -2389,7 +2390,7 @@ void dpu_encoder_helper_phys_setup_cwb(struct dpu_encoder_phys *phys_enc,
 	 */
 	cwb_cfg.input = INPUT_MODE_LM_OUT;
 
-	for (int i = 0; i < MAX_CHANNELS_PER_ENC; i++) {
+	for (int i = 0; i < MAX_CWB_PER_ENC; i++) {
 		hw_cwb = dpu_enc->hw_cwb[i];
 		if (!hw_cwb)
 			continue;

-- 
2.34.1


