Return-Path: <linux-kernel+bounces-822860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30895B84D33
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A29B7C3BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E0230BF5A;
	Thu, 18 Sep 2025 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8Zig5d1"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38F30BB82
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202161; cv=none; b=mNqABrtVTXXpdFSUljs3h1xs1/qyhqFgdyFS8r8/LSLatCr9rhPptjG/0OEzcb4jobnn5UWH9lI1FXHrVI1r5ZTbq0vA5wn7HAgSxwKi8ci94IixVPV5KovLcFAqVHhKKD/UXPjfvytt92spqOTJZF1eBcIMuD9v3VPKhRtIf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202161; c=relaxed/simple;
	bh=OO2Z7mIWJju/0AAWi0QFQrEeFkD+xuMhO5TmIsG9bFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UV514PY3xCDu5wlBiDFUssiQJU4MbeFm0vZ8rPO7zaXW7pqmP2o0LHhUmRgRQoGVXX+SjMyzAbU7VRbSxhb10qlIJT0B/e3vdq8+VSXHiLqExD20+9MblgrU+/R7OgSuRyUPA84ifh06xQQNTBG+BOTKvV0Y+e5IQnH4koiX+g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w8Zig5d1; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32e6f3ed54dso825845a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758202159; x=1758806959; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDSLLULuQro4tZ+C6kFbdQGbu24iHgqnLikNbErS/QE=;
        b=w8Zig5d1WAMXKOfr3J62G+T4sJ5Li7MsSv9HHEJdtUlx/hor5aMGCOq4Gkb/bybhah
         gsgdQQfiXaUeDlU7M2r5dGbt7/IhWsnq2srPSnCY3jhU/hx2g6MAPXYSgHAKGu0+aL+c
         9GNervOjb0NnAdHt6dFph/LSSZzClXu8z1oXxMG+AGqvxZVpYJXf2C0vx0TLhJX6Vw6E
         8vtFRJpnPTOmQI+RPyZ67r5950hoWlmkrY05qWZfe8AvzDOHwzMNFOIp2UPlfFC/Jk1c
         ZcwH82Mkih9hKvSdVynjvhkVEqPd+l9kWqN0APNfxyD8tv6J58bC7fgx/TmHzlbZ1+Km
         P/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758202159; x=1758806959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDSLLULuQro4tZ+C6kFbdQGbu24iHgqnLikNbErS/QE=;
        b=LY58lehQuTROyuOWa5qeX87Y3A/SprsDx7DMmWddGUT+e0GBjIN+7shHbT6pVMGIel
         6zC8ovYgw07Dn21t2ZLzYJYh7gUPmMz7WYtFMH/W3Xnel2v88ncHvl1tylcStaMw6IgB
         uIXM9KxlP0l/br7ZmegMoaGGikL6miBUqTKlBS/0APAWlKVNDZ+MPrEKh4RfqO9RSKI7
         TN1e4wgvjCG6GaSjzQtiW9MnorV+XQrxChv+YUlQPmogS1pirdh9FLLI3P3+YqKLeyWu
         xfUBtsj5OJ6GewWn8yq4BiWcqYezwzvAtmU0w1foXDv/6DIa2kZFeg8tk7dfwzSfuFpZ
         QIgg==
X-Forwarded-Encrypted: i=1; AJvYcCVLitv4QVVBAJD/ftHrT24ys1/SpmAkPQdl8bg5MpD6Qoy6m/leJYJ6L5Pbj9o9Y4AJbGvJM4x5KBvHZwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZQT7wm677G1W+SuhE0Hewr6kqdhGA8pOt8xpiPuL529ckSj9
	4yv7XUXia/2xnMw06H0zi7HkQSPECIB7/7eJZRDouxYX92CfNDbzLEPXr0uk1ir4ibU=
X-Gm-Gg: ASbGnctLF1ZDIx5HLj7CrCpDrYJ6ONc5BHXc15l0PTGXkYNzosSfjiuXijZUj+w0E7T
	Rcf1GONoR6whDO3UyL5VPw23cZs/dMoLp0UXYzHigZG3iJCNlz3MBTNwP+j7bb+nFIsqEAbyMuh
	uWdw0CmsLP44JQ6U4Hy3QHgAzIc9a2UdzWt+9bXGSVXVukd+O0+6YqyN1ijjildER8POau1/var
	SsH1e6NNDyqjsXaPD7M9ogttWSBnxl+natQ6sIo8x+esqBex8YvRUsQqW1+MwGofpSMq80CBtgR
	Tpdc5E6tDtugrOYrSFy375/FhKge/RnFnAxJ6LuZkAUv4oGa1IceVW3XCzn/sOcHQlSa4G42ZJY
	JSd3Pw+i2HIS5FkZGosJJmru6B0cbowzYcQf8S2gVNxet8w==
X-Google-Smtp-Source: AGHT+IHpvGiImQFwMteDMnsQ9boqP2YBE1lyMVqRTtWnZvCXRZeXk5yWOTPnDuzCAJ9Cj66gJ+B0Qw==
X-Received: by 2002:a17:90b:1dc8:b0:32e:7270:94aa with SMTP id 98e67ed59e1d1-32ee3f757dbmr8938250a91.19.1758202159252;
        Thu, 18 Sep 2025 06:29:19 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.61.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff35cc76sm2331479a12.10.2025.09.18.06.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:29:18 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 18 Sep 2025 21:28:53 +0800
Subject: [PATCH v16 01/10] drm/msm/dpu: fix mixer number counter on
 allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-v6-16-rc2-quad-pipe-upstream-4-v16-1-ff6232e3472f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758202147; l=1366;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=OO2Z7mIWJju/0AAWi0QFQrEeFkD+xuMhO5TmIsG9bFo=;
 b=El5ho2A1Ag5BjirXgdffSiX1h8pTj0dCcNchyg38ZuJA1UFEylEq7nQEPDG8YtcX2VYdfhjGg
 cg/nvcBSPMKCNxgMJeVm2co5QzxxSEYGb1vhmg2WPVvoJRnC7LsP9PQ
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

Current code only supports usage cases with one pair of mixers at
most. To support quad-pipe usage case, two pairs of mixers need to
be reserved. The lm_count for all pairs is cleared if a peer
allocation fails in current implementation. Reset the current lm_count
to an even number instead of completely clearing it. This prevents all
pairs from being cleared in cases where multiple LM pairs are needed.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 2c77c74fac0fda649da8ce19b7b3c6cb32b9535c..3f344322b7f214d0050986e675b32522f8eb0ba7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -374,7 +374,11 @@ static int _dpu_rm_reserve_lms(struct dpu_rm *rm,
 		if (!rm->mixer_blks[i])
 			continue;
 
-		lm_count = 0;
+		/*
+		 * Reset lm_count to an even index. This will drop the previous
+		 * primary mixer if failed to find its peer.
+		 */
+		lm_count &= ~1;
 		lm_idx[lm_count] = i;
 
 		if (!_dpu_rm_check_lm_and_get_connected_blks(rm, global_state,

-- 
2.34.1


