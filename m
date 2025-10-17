Return-Path: <linux-kernel+bounces-858687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CDBBEB6DB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49C66267E1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F7F2550D5;
	Fri, 17 Oct 2025 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfJzAwrs"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980A23EA8F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731258; cv=none; b=d3UARiRN6C7pSXg1x8qewXS6MDJkeWb6CRGHvkNvIYkn4hAj+FTL9UN+7ewaFrkqmu9G7yXs1oMa815kcfgErbv3Pq/lNDk8dQkOb/BsS7aFm7JRq8uJG0B0o5kve6cjWsLtMOYttuucBJMVn9oQV0S2hohwYDckZH1Bd4BOklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731258; c=relaxed/simple;
	bh=knh/HEr6cHlCZELVAiS5ohJ6Yl7S9RjBxDHyiwEz+aI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DOFPBru3xxTLRSh1NwOvOxBgCpBsr+R6gDAzsh+0uocUdiN/VF06wI5SUzhVjdCn9cwzpMlVhvJj6EwLKcLc5dO7QXrR8HUF5EbAP/JfbJKhooDsgSaqp6g/zHdVddXvnqk05/iaAhXBOdKT220SB1fD1q+HVuNp+QbPZP5Z/CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfJzAwrs; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-376466f1280so23244961fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760731254; x=1761336054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6uQHUW9ChgQjFk3rZ7rRlcJ/k+AJJTDJCwK+JBs0nE=;
        b=JfJzAwrs9Ld0x9V1GMpWf4iWNzb4WEtCUlUuF2V9I/x171shRXRB1ioKB6xUxomY3C
         uwjIWslSaZ9J0OOnOWAaY7d5tMEyZrupGO7VQDQbHitxMUWBAIUU8OCmQA5FjqzJiENE
         r3zqOEgpsfRjphaANU7l/egU4Vb+BNBEBfwOyMGBnCwW2+As74D4bp7NEIy1cs/Pb21r
         t22xNQ3bXQr2BCNFDTlbb0SPEcM0KYZPkNJPkokHzLV5J/wgvSVmF1w+phPyQBTNKMWt
         ImmpMAceWM0BroqMwLU/aSebFkB2KreUHufTqzVoIhh7DOh7OSv5FsIgdACrdcuGyt3g
         UUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731254; x=1761336054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6uQHUW9ChgQjFk3rZ7rRlcJ/k+AJJTDJCwK+JBs0nE=;
        b=HzaQdBOFE3GcK3MD1ijF8MSUIXLkF0mcQNr1UAboL2nlYX5PWlVoTseQw6pPiqy4fg
         HaVD0fQkTPZiVO9rDZjtgPqm8xtLfGVlDJeFiqFfabF9yF2DvRvvrz3BM25LFfp5yygF
         NigY6d4N+ZAVUqHOYkrZbUjD5BPF12w4f52fJRe7fBFNd42KKEeTkl82EXYLOZIdcwDa
         YFgEuihGFCOXTCpiCthvKpCR8Fuizl3C0OCYkRchoGJnKrMjHm3DdDfdwv14Z82WVl2C
         6ZhzYnVOlAqFlX90gfePJRloDn52R7gVVzvwYnCZpeB4wbWo4MINu/0MLCM5YrHCQFyS
         bsgA==
X-Forwarded-Encrypted: i=1; AJvYcCX54xstRbdkc+kgUbdOpNbL/4MTuKBBqHAlvOxw7PHWA10tT/4Bq3ipO4d8Q5b11ghbdRUfBSmyP8IU9Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwLkKDRdYVN6VxPhNr9ivMQT2Jf/+BdFpQ8aqYoP17WD0bmVA+
	my44/W76HYYl0CeC2vN0LHEr5t6dRPTW5hZAu9q9GhbvsZQyhS5miBLe
X-Gm-Gg: ASbGncs1Wpr6E8PfJZhejn42SQ43zRhBa10uM+qBh1gOUZPD5o21p+OELE2EWUE/uHA
	nM8hBFHdI/pJRi68UkgAZasbfw2BHF+Je0jPkNo3Ox09sYXPsSlkFGJ9Qf/5HiyNYMk3xt1LFxz
	2DU9werLg8nwoX3kKkNBrgtGGH5TmBbWPNCTcUEUXvOL5bkxOLeqrQne1Sy08AfabObaQAKByP1
	pA996p5cm3YvzV1Ccavoyl6BCb4QFYKPJooYwj2qzo2nZBqsbGzTGUwXlV6F1mYPL2KjiE2Oaqj
	k98g4JYXjgxZ3sxByap/jixF5DZckzJUgBvV2bdAQm8/leq37s1u/kVOj2UR5FBHzAe30VQAjlG
	pOPF2/S9UGrxAgd7moka3u7EmEYzX40cU9jfraR5Et7tnEYANQYOYTuEUg/t64tGQ0huQrb1dpk
	Q2smu2rO+ia4u6aKSIIY7k5SwU+dHnmsrUJOUJz42ARUMGD+i1S6AnXeCBpnUDDA==
X-Google-Smtp-Source: AGHT+IENQjN/CUYsH9VFFm4pVHWkRuMc9LBZvX1RWDo3Xnsvi+JcACMpM7wNhoU7fWK1Lo5cRQfMcA==
X-Received: by 2002:a05:651c:1586:b0:36b:5945:d3e8 with SMTP id 38308e7fff4ca-3779796dc35mr16004461fa.39.1760731254333;
        Fri, 17 Oct 2025 13:00:54 -0700 (PDT)
Received: from [192.168.1.244] (public-nat-13.vpngate.v4.open.ad.jp. [219.100.37.245])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a921d99bsm1580861fa.22.2025.10.17.13.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:00:54 -0700 (PDT)
From: Vladimir Lypak <vladimir.lypak@gmail.com>
Date: Fri, 17 Oct 2025 19:58:38 +0000
Subject: [PATCH 4/6] drm/msm/dpu: Fix pixel extension sub-sampling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-b4-dpu-fixes-v1-4-40ce5993eeb6@gmail.com>
References: <20251017-b4-dpu-fixes-v1-0-40ce5993eeb6@gmail.com>
In-Reply-To: <20251017-b4-dpu-fixes-v1-0-40ce5993eeb6@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Kalyan Thota <quic_kalyant@quicinc.com>, 
 Vinod Polimera <quic_vpolimer@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Vladimir Lypak <vladimir.lypak@gmail.com>
X-Mailer: b4 0.14.2

In _dpu_plane_setup_pixel_ext function instead of dividing just chroma
source resolution once (component 1 and 2), second component is divided
once more because src_w and src_h variable is reused between iterations.
Third component receives wrong source resolution too (from component 2).
To fix this introduce temporary variables for each iteration.

Fixes: dabfdd89eaa9 ("drm/msm/disp/dpu1: add inline rotation support for sc7280")
Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 6effe0fa4837284a1f038e4907c4c91d239aeb8b..905524ceeb1f192c093f1be7f571b29eb4b53379 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -500,13 +500,15 @@ static void _dpu_plane_setup_pixel_ext(struct dpu_hw_scaler3_cfg *scale_cfg,
 	int i;
 
 	for (i = 0; i < DPU_MAX_PLANES; i++) {
+		uint32_t w = src_w, h = src_h;
+
 		if (i == DPU_SSPP_COMP_1_2 || i == DPU_SSPP_COMP_2) {
-			src_w /= chroma_subsmpl_h;
-			src_h /= chroma_subsmpl_v;
+			w /= chroma_subsmpl_h;
+			h /= chroma_subsmpl_v;
 		}
 
-		pixel_ext->num_ext_pxls_top[i] = src_h;
-		pixel_ext->num_ext_pxls_left[i] = src_w;
+		pixel_ext->num_ext_pxls_top[i] = h;
+		pixel_ext->num_ext_pxls_left[i] = w;
 	}
 }
 

-- 
2.51.0


