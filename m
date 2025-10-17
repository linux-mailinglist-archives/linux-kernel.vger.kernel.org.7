Return-Path: <linux-kernel+bounces-858686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4C8BEB6CF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447F862584E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BDB2561AE;
	Fri, 17 Oct 2025 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoDgKL6q"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD0C23A98E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731244; cv=none; b=fIQ8OzKkmaa8yMCUcm+gdp+Qq4mVdFdZHXbnQYVIagvd0Dt+JwgLxZ2GtAFNrbRJAKBl8vnSLBPNb+ms2yBnUDXsFgKFJomrINL6rUuwff4fcYz318GGv248Upr3W0wr2h0cWy5hOBD15ofbkkKpE6NArbUMdFJ8q/IuIUHixus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731244; c=relaxed/simple;
	bh=F2zDecP6+oFfoSg8W+FxJSa/s3jTLYNPTNsWj2Zuph0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X/Mxe9vX9RLcqtPQkBykYSkKCb2OugckJe7qXOsfqawp6rp7PC1V/i+tg8RYUf3zvXUI5xrE86QZ3t5teUV2ws7IAKgILKe42TeOEp0iXEOneAAGylnVhtws3e3sm/GmXxWYMnMdGdf4pkM8z+zPr4b6kGGpSGmLFPmv+mJSGmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoDgKL6q; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-367874aeeacso23853161fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760731241; x=1761336041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQNJSxr8t/BdOOWVzHAAqI48NQwvfIqpyN0Al86/+Ik=;
        b=CoDgKL6qeSpEtOdkltiQdM6lKq8SKshtM0o1TwwAIBBTknGFxW593YMFj0VIcdfLoG
         xRB1VUhpRIB/AmGKtTTd0F0gFWoODULuI6hrDBkrjINmugpZpGPuMXooBsgpVdvIH6r+
         KHiLC8BKbySk7nolP/XlhQpJaco+zt0lMMAHfsWv3XtzG61l718SD4RWv2w9Qudq+peY
         aPmVIoCE4O4WA4jC0UOxRGt3zlP/JMWgJO7jRKdrr6Cn7w3WqmJ+JcLtSSdD/xPaOcqS
         QwvmZxFffVRb0zTvw8+OsBRpqTGeo+pE57cgkck3wPBzaCpLdkEoC6CwmoA5giT/wroH
         F3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731241; x=1761336041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQNJSxr8t/BdOOWVzHAAqI48NQwvfIqpyN0Al86/+Ik=;
        b=C8sRQGo7s/+BdVocbFYwubV71POwjCC5/k8auLM0x4N0MIKx2h4lJyPY0c/P98hngI
         DUQlieEFAni7K4j0QUOUhqpd6twWUWihHB8aGa59uC9DDTErmcGbhWdS3ZhFglhiEqW5
         rhscqpTaCuyjt8R+AuvthiHupAI2B6sWlyflrS6Cb2kQDQUb1hl2RH6e+Q0LMoT9e7Lc
         /rU4rQL/ODf/up8ieJcrwRpDJbpNt16ISgszQoakWeoHpDDxuHFSIfsYxU8SjgC6rWc1
         5e4R66rF7yU0+jRqr1ZZU/SACnqkAOMHZGiZ1N/9SmhFYRcmeB1LcrTjzxGfI9nqfALS
         zqAg==
X-Forwarded-Encrypted: i=1; AJvYcCV88AGQX/6rXKBmv6oqVQiLp8BhD+AEJFjesYSX86eM8wRD4qxw5KcKRLB6934ddMKAZAdX02X7B68vGac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV0RTEd3aoK5iEUjB4Ty3gxs955OCruf8PlauNoO+wBjemLvqG
	V8xaTRuA7u+EERx91Inr4jrEIKf+uB5tj3gm4Jz2DKD7V8wKfzaqr42K
X-Gm-Gg: ASbGncu4Qr6ruk7CAisVgxd6crmB1+/LGv7Ab78foxP4zOq2dAtufVDQ1AbuUW1Z1sk
	scn3Cf8NVCh8/k0sqUTiBUIBbtN5T/HcBiAmjNw9wgJEwFY+oF1wQMojfQLvY58qZpHwLNEYc2S
	I2wgwXr/TXSzraUDnrBlVTFA7vfNHDXVXPOa/L4cjIv5jtF9FNzE6gkHQ6OJ4iXyVS0oLAD0oey
	3miTvLzxoWLPr8wrEgjo5RrXNmPKm9Osf2Hsm5jHZiAnjh3bFCrvgxRXBTn6zJoomnQy/cMLb96
	TNkh+UzcPuxUZ0lp/2fyQnVY3s+I0sD1EwEHRxb5B6CXZoj+nAD4YOEsmLSWlCaODn2s81xZX60
	pYUEYDs1aDhpEhonQyEpN9GWEr990lrmZ9HGeu49VlzpZ5LUIwXHv79wiBPVjnU70E6IFlEaPw7
	nhTc6gmVfED7t8CxwMCAdljIIkpL7n3CgHT+bSfQZFEP1ySEPaQBkT5aqfJD4Mdg==
X-Google-Smtp-Source: AGHT+IGNU4fQjBz2jSA6DBrpEqZEn5tDNBRAgHPtQC9tAm1M2lku7pLWWHwNUw5re71jbQvu9jXrmA==
X-Received: by 2002:a2e:bd03:0:b0:333:e590:1bc9 with SMTP id 38308e7fff4ca-37797a0e735mr14647271fa.24.1760731240714;
        Fri, 17 Oct 2025 13:00:40 -0700 (PDT)
Received: from [192.168.1.244] (public-nat-13.vpngate.v4.open.ad.jp. [219.100.37.245])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a921d99bsm1580861fa.22.2025.10.17.13.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:00:40 -0700 (PDT)
From: Vladimir Lypak <vladimir.lypak@gmail.com>
Date: Fri, 17 Oct 2025 19:58:37 +0000
Subject: [PATCH 3/6] drm/msm/dpu: Disable scaling for unsupported scaler
 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-b4-dpu-fixes-v1-3-40ce5993eeb6@gmail.com>
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

Scaling is not implemented for some type of scalers (QSEED2 and RGB) but
it was unintentionally re-enabled with change below. The remaining
condition in dpu_plane_atomic_check_pipe is not enough because it only
checks for length of scaler block (which is present). This patch adds a
additional check for setup_scaler operation.

Fixes: 8f15005783b8 ("drm/msm/dpu: move scaling limitations out of the hw_catalog")
Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index d198a65a2c5fef5fbdebc9c383a4b08bc71b8bf3..6effe0fa4837284a1f038e4907c4c91d239aeb8b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -740,7 +740,7 @@ static int dpu_plane_atomic_check_pipe(struct dpu_plane *pdpu,
 	 * We already have verified scaling against platform limitations.
 	 * Now check if the SSPP supports scaling at all.
 	 */
-	if (!sblk->scaler_blk.len &&
+	if (!(sblk->scaler_blk.len && pipe->sspp->ops.setup_scaler) &&
 	    ((drm_rect_width(&new_plane_state->src) >> 16 !=
 	      drm_rect_width(&new_plane_state->dst)) ||
 	     (drm_rect_height(&new_plane_state->src) >> 16 !=

-- 
2.51.0


