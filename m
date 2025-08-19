Return-Path: <linux-kernel+bounces-774683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E432B2B61D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C09F3A60D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FDB20DD52;
	Tue, 19 Aug 2025 01:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFfMjveD"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CEC17A2E8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755567089; cv=none; b=l0MREbyp/fNchfjHBcKW+Yd5czZlGz0xPmq6pAc6X2O7O8MLmq4rA595p7c8nnK5KjrMgnYZwREDjgHOgwKvJ8t3cWhWLumHVlTQVVujL/pyWSzAH53HYtOs15RKV1+RO/clDr6vm4FAphwMRcw0GiO1yTo+S8FSpbQvVL8SGvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755567089; c=relaxed/simple;
	bh=OO2Z7mIWJju/0AAWi0QFQrEeFkD+xuMhO5TmIsG9bFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=smugpC8XCtCeps1My2/aH10ynL2k5fL/sBVmYUvWTkFjug3a+2+69CG+4jGUHygbqY8axWoq6ZiCTSQNtZrxSAWlYFsfdwxBPr1eIFiH8lRXmSLlz2kVB7XyhYyucR4Dl4hujJG/wPjqY9F1aWFfFEf8sXAzDQgZl6ZZCE1l+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VFfMjveD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so2283049b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755567087; x=1756171887; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDSLLULuQro4tZ+C6kFbdQGbu24iHgqnLikNbErS/QE=;
        b=VFfMjveDgAr/OMsLqO/bUOLtEjffYQQz2i3i5XJvnmC5fOUTjezM+JKC6BmrOh1+ea
         6O85aohtadOL+7iglxYe1z4oc06ThItDaEAGWCtCe+vunPi6rRvtFN85WbQcZWg7rCja
         6kmcLHcayhpzgfCi8rc9AsrMR0Q5WtlNl3ikghA0MjSxg6DefB67LFgwRwjJV2x+hOKJ
         sOnw/HOUSFFbR8rEbDNeq12p7e0M8unnduUdPbmUR2f9HmoPF849GagqxhrNdGUi8cHT
         vhLFXcTrNQe+Ffx8pNSclb6BSpNEkvhmAd1M7cUyGd8IP5zOATVaCfIvAlPznKqnOZ5t
         rZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755567087; x=1756171887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDSLLULuQro4tZ+C6kFbdQGbu24iHgqnLikNbErS/QE=;
        b=dsIXwPvojMM/oy/9gCWirSJHr3e5mDmtpR504IU4QJlqOEF59srYyDFbHraAbWYkDV
         0WG7SVDD4dzGhsqXSYw+zP7BNeCKScq6mNaGl1VXFJKuBiaMJRO+dVg+Wl1BvdacUTPT
         GLWMG91QUy1q62uGes0mkTHFZ8yVGJH+aH2CUYHjD6ApX3zDcHuZGeiCbFRYe5q2++Ev
         r86x0wVakCZeDTG0sR7yJnrz+HUXOfKR0/zRVA5SUEbuM5ZefbQNeeOmphmr6APOwFAf
         rBb/2LB26QBJoU331kP7PprvBev5JlCOJ+J8hIfnga3TQWtziRVxsbu5k7ZUcKeOjzDO
         C1SA==
X-Forwarded-Encrypted: i=1; AJvYcCVz5LLukDgEg60L2JNrXBraBxvyceS3URlxUhVL+NHAS+A9umZy0PQn36eWgrkvlFj8MteRXPqVVk72enY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQPn/UYRmmJiH7AquRkrDuI7pT83BZ7FRRsq2s8I7Ba4TiqJ3E
	s6tNBw+jTTAmT15+BWYmVUMI4hFF0pv69dQ7iYnQAFiYqcCiSfaCVcYldvUUYs67ikg=
X-Gm-Gg: ASbGnct1JYQf6ERIzM2W6dte39vcAgLRBMKKF2lIT7UiDFDVJ4It9BCV6TbpT+hqII2
	HaZmXmzJzQivPfqHQbhbZ/n2xnsICXsBPWP0O5NZCQmOrugmlcek/VEdPhm55TY4rC0frFRdPNq
	HvQQ9JuaUCNTR3kuUT6HLU7fSAz7mObdJ19gBe95aOzWYQdmQzY03j7xaW38ywFELgVnM0VdCxm
	mHKGJmKEnfsmEPgcY9+tCodPNS1u5628RC1/pKwlpoWhcmjOeCx4N7YZxCFwJ03yUKKJK8/Ak/b
	6sY+4uW+5JIsv616oNoFRxsg9WS1KGP6ND1PqmlNoLKxvgAesAsyFRBBZAPzF3nNYvcky2XP02H
	xLaKndfSvwhhZcGe4mA==
X-Google-Smtp-Source: AGHT+IGps1ST7kdQvxYit2Ob99jtGtkYokyhyRmmvXkWhW2P7lhMmeUjXrOBgJl4/RARBwWnz7OdKg==
X-Received: by 2002:a05:6a20:7294:b0:240:9af2:71cb with SMTP id adf61e73a8af0-2430d372220mr922993637.20.1755567086739;
        Mon, 18 Aug 2025 18:31:26 -0700 (PDT)
Received: from [127.0.1.1] ([112.64.60.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3245e4faf80sm248637a91.5.2025.08.18.18.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 18:31:26 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Tue, 19 Aug 2025 09:30:58 +0800
Subject: [PATCH v15 04/13] drm/msm/dpu: fix mixer number counter on
 allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-v6-16-rc2-quad-pipe-upstream-v15-4-2c7a85089db8@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755567061; l=1366;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=OO2Z7mIWJju/0AAWi0QFQrEeFkD+xuMhO5TmIsG9bFo=;
 b=Dl0sF5pWfn9RHyOh3X9+toV9iaBEjSAor1oRajKpwW6z4obYTT7oFvWdRGeYf+oUPpjzPNx3z
 5LYiatLWoMBDaahzNyoUttMSMXwjmvTD6Zw4bE8Ia//fq2rbkAB5S9B
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


