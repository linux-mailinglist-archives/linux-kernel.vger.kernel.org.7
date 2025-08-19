Return-Path: <linux-kernel+bounces-774685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82122B2B629
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC8D622726
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DBA21CC6A;
	Tue, 19 Aug 2025 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eVruC54Q"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B11F4606
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567095; cv=none; b=eU6MhcfckfmiFdkVcsWASKCNa8oBwJGAvWZBwhwTOjXHaqOGt8lsCD36f2sxL9ylkUMJoNnKoKOkjS9+RBPI4w+Qq437GwDl5W3uTWdxlRVeg5IdOE9ojDkvxtbGwB+zLcfR5xGZ+YMKvaG8jiaRP9hzm9MLYNPdxcO9uFfphGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567095; c=relaxed/simple;
	bh=flbnou7XSx1ETCmAxdlZnvB3+bqdNxru9LUU48yIE7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTF1VWkjcbly+MnuQoQ2GZaNP7tfWmtv5jfwPbrnIGzFRSXCZAjIFDwmksI92ibzMH7HUo7hzOFa2KexeddrpwiUtxSLvXw4+z/9/FOexjDzNbv9WkHYUBr4zz0RGQbXvvP6IFWuBo+UlM5Q/PIuD06XeoQLJvWPe51Z1Kwr5yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eVruC54Q; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24457f5835dso50493095ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755567093; x=1756171893; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZKppSrZ04BhPYsPEMDVl7eb2YZ+sFy//28ARL2GCmc=;
        b=eVruC54QRbAK8emC0NJK7XQ8YBbnG/RjIK6AziZSD0910sRLQqY3NnxvKd0Ove5Zck
         5NrfxfP7DGBz2slPexvpcAcQanDM/8ORv//iCxpaX7cOZiudmfxvtMtPex7/2eKTQ2VJ
         ieKIgE8fNXKYIoVIjaJo7M7h4E8bRJJEQHjKWPorSUKdk/A3iRaoPWTAynakB75JMW3N
         B8L2NTxUr0afVmVQyjcgz36C9DZpAZf2ONuocovfsAf7WRuDsTPUyCDMVUqqAT+6aw7G
         jPYRqDZjnnJlGPD1XarmMqKkwH9qUm9aCItWgxNa5Kh4L7JApptXfflbkqlj2D5SaIcU
         r/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567093; x=1756171893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZKppSrZ04BhPYsPEMDVl7eb2YZ+sFy//28ARL2GCmc=;
        b=jiQsXfnQEYhBsB0yIYqVuxtqP2dBv3/f2A3X8yUMp6Vy6RG36LdzkXFfxKcbknCjPW
         pvbXQBgofSMxEKfadxZrpmiAuGlQIG7iTVMnuwB518DttLOS5fVJnWrcFKSwUmXJXMAt
         crdoZGxSwEOqsrORWRAUcPiLCbGT7whn5Cea6jm+gzjvZjRaeizCjK4SbV/iDAK3FmSl
         4yFA/YHYB8zuk0GL1YBXV/ht4g+XmuLz+w0XIoQu4vbZPN5fZaN1NexT/hN2TeSfMAw1
         55HFUlcShdKXEaZh8N8ZoJLmubbJqKc+yJ46ukAO20oJ/AcdIOXYn8TfySEGZYr+r2ZC
         VQXA==
X-Forwarded-Encrypted: i=1; AJvYcCU6RZGFpBq88zQ9Q8loOejMJVUivhIaDfNJtPyhYE3K+jZyuk1FB3ae4XQSm9uaBI43+tbA0xKaEuEnw7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNWyMyGbcZg6USx9MfpXovdIOZXx9DjFlJhF9nFPrM7o65Gcd7
	Bv46p48JQSJbCa4tWAEbG4GFdoBeIiSAxGEo4WBTSMSckBx5StVaKpAvLwi3+ohzBj0=
X-Gm-Gg: ASbGncvMENVjgoCZPk4ti936JcY2gN4hQUqDrRistMsWcpoJYWWTOJEx+WV6IfTRNRs
	A/0qHk8/Zi6FGfTHe0bMlmE+Hvu3bqQppGb5vOyAx7yzWr0Rl5IAVikFbxhJKoXRLJdxi4j2qEa
	0DTnThtxE2RdAxfvO8D2JpHbtji7id84ArAhPOLDTubmmZafBDUKbdgPcHK6Nd8L84HRUMiIsy2
	uxKT3q6sf40ceHQtrcVvWFDXZO/75+7MylEBj67KE541DFBnY75VYUMDr+7P2Gm5ywDOqM54p/P
	jj1z0DmpGs5Hn7umSkaukNh2zvVn0u8QY9Hbv7hFfvfjvhIS5Df/AJKQsBsjDpRRBIICTM6qKmT
	3jwVD+EUq98ghjkIaRQ==
X-Google-Smtp-Source: AGHT+IHVbtYW4RYQHQZZskiSfzFwAgdNTCMwz7Kd2QtknRvYYfJid2ZZhGW6Kqr8W4eOUL8j+y1ocw==
X-Received: by 2002:a17:902:e5d1:b0:234:ed31:fca7 with SMTP id d9443c01a7336-245e04ca7b3mr10841685ad.48.1755567092833;
        Mon, 18 Aug 2025 18:31:32 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.60.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3245e4faf80sm248637a91.5.2025.08.18.18.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 18:31:32 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Tue, 19 Aug 2025 09:30:59 +0800
Subject: [PATCH v15 05/13] drm/msm/dpu: bind correct pingpong for quad pipe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-v6-16-rc2-quad-pipe-upstream-v15-5-2c7a85089db8@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755567061; l=1809;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=flbnou7XSx1ETCmAxdlZnvB3+bqdNxru9LUU48yIE7A=;
 b=tjVmr1icovhUDDSu+7xCILY21LeUOkpXcuU8bCCTs9359a8eqqh7Ucze0DQ59Ne0RsSEPBbFS
 W+ASKuucYSxDL8++f36loqo0PdDJ1JBQt26jhvadshdJAR+5eZCiEmL
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


