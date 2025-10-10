Return-Path: <linux-kernel+bounces-848606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FD0BCE267
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BEAF4E6E79
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00E9219A86;
	Fri, 10 Oct 2025 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAG2FT3O"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B261FFC7B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118593; cv=none; b=mYPgkydmIovI9JbnRJ/Cekw4ZVAlPw+PkBSRoUHP34PmZPDEe8oH9fVHsUqwfCOn9gvzDFn7KOEaPz9up4vBhm0FQX8An91YX425vGHyanr9PiecOfcUuKH+Yei+YDpPm+FvovcfhPEnVuYurizyFOE8dga63DGhwROJc8NZDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118593; c=relaxed/simple;
	bh=9XOq6YPq24CpDOGDOJ8EWJ8bkkDKwD6bJxPjyv75+Lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OaM6d4ee2AWh3ei3YJDdcDwYU3m9TjmMtwme4FylO0ZDNzQtYwr5l6ZE+HR/m/29IxqqszUy3MZ+4MBLWXlZ1ZoeG78c5k0SCGiOKGF1Sj3Ask05EMtrPJ6eoxMFCGC1mswu63DdDIZm5Ye5taVlI24+nSXP7v4B00IR+HNYSuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAG2FT3O; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso3956876a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760118590; x=1760723390; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4FlMoGYBpYvb/EBbOzxkP+h2B57HDoj8CpMbpuq4sQ4=;
        b=JAG2FT3O0aGtZJL171zLlTU9biQmzRFNcgkQMtwqFbKP/MyAafa3Y/82ywmzv4a0A0
         jCCeqvXLGz594PmO3/lTC/OP7vl1x9ahuzRM9HELxKuFCiL5/T2tr9NiOzijJqrWB90U
         bbPVJHs2D9hoXZ5wQDAxOo28gyJesAWjrOUkT9tDxLsqP1uaX0GCNnxpAkn/qR/8bFXz
         QWViFs+Zp39T/+vsO3JeXXtGQbMIjs+0RmWgNQ+m2wwVuYFXfKzMF6oGx1bfzkwj12Nm
         ioUKfvAGm9q4Tb0rrKSDWqJ836GBJfYVAlbJx8soULAWNrYqyxNuFjsuA5N9nhfJLpls
         FTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118590; x=1760723390;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FlMoGYBpYvb/EBbOzxkP+h2B57HDoj8CpMbpuq4sQ4=;
        b=BAyG5fRHuWflAgj7Y1ShbwF4EtI6EjuoPbDkj0AgTqZZcR2lNvEs9ym/d6+Hr+Nf2S
         oid/dJ2XulQGgIow5FWYP/2M7OdGWTSAFZy/54H7DGvfuKN+TbPU7XIA/87kRCiIiNPY
         ajHZTgHAYhbOkZvbSAS7YOwd86X4gG20u0CkQGwEEFceXftABp6W40d7669jIEePO1yh
         vcKUhIRHJYSTn37RCxVPapT766ewpG3z6vDsxoSb62Y1An8VWJA8jonVvjNRDJhJhyIy
         W3bD3EkPJ44+kfu1b3Z8lCeI0g+tW4JgYrw3h/VWVG4bQYqON3TlHhMugPPFZs8aLly9
         k/Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXvyJMbmikGe9zLSRFdHF4zXWrvs+YeAOR+9a64XdKWOTY7Ux6K2e4T9kr6QzJSxRRBhEr89+cJpJqwQdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNf08bnavQXsXHt1/mUJhLXNXGQ8R2Dkocdsb8al0KYwBCqDQN
	aA7zW36+CpAJB3DpvidRFLtIfFTtUYShNtqDJLHFRtmI8osRkE7NF7k=
X-Gm-Gg: ASbGncu6Tw62Nt6OUTA47TiA8pJwVLOJSFSSd6YwNMypXmO+hWK48Gjj5Be1fbRlU1x
	4tUd0SdY6HH5TwVEFW9X+FGFW25GkXo8k5FbWeMcDcTRQCAXUKPUKgbZxdFz0nfQEhTUdp3NF0J
	2QWY0amL3swLD/rv5IdQmyf07feBiFseif/CDfsllO4fb4n99aV363eDWSr+S3KWN5UalWLzhKT
	2w/kdyRv+645Il6/WQeB4EgJASvcncZmOtgxJtZ/pcBocv3f1nj+UTe7CqQaGXRdAhbXuQPvHPz
	zKtxxppQdTsbDpNiv8CqixOOv5BQYn1wbs8Nl3gTFzggh6p+EtSH13wi6ufqWfc3Qcg3tErB9nk
	rvgmx1Qu6+TnGkiPX4kvf/ikvmdlYBRSxdKPEHL+8aKjLQlhJk6iQ0z+hftVOgogSfhj4XINHRe
	AC5oWGadK6qGqGreBn2w4feoDSmA==
X-Google-Smtp-Source: AGHT+IHDJR17PQFFrv0Ddj5LxOyqWyfj6LF/dr8cN6Gek6nwWLnn8Mv5hRRCyiL9/vubmJXWRweCCg==
X-Received: by 2002:a05:6402:1456:b0:63a:3e7:49e4 with SMTP id 4fb4d7f45d1cf-63a03e75ebamr6614994a12.16.1760118589666;
        Fri, 10 Oct 2025 10:49:49 -0700 (PDT)
Received: from [192.168.1.17] (host-79-43-163-15.retail.telecomitalia.it. [79.43.163.15])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f860sm2751785a12.15.2025.10.10.10.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 10:49:49 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Fri, 10 Oct 2025 19:49:42 +0200
Subject: [PATCH RFC] drm/msm: Workaround IFPC counters bug
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-ifpc_counters_fix-v1-1-9187962b7d20@gmail.com>
X-B4-Tracking: v=1; b=H4sIADVH6WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0MD3cy0guT45PzSvJLUouL4tMwKXYukFBMTc4NUM2NTQyWgvoKiVKA
 w2MxopSA3Z6XY2loAOHIok2gAAAA=
X-Change-ID: 20251010-ifpc_counters_fix-8bd4470e6351
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760118588; l=1299;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=9XOq6YPq24CpDOGDOJ8EWJ8bkkDKwD6bJxPjyv75+Lc=;
 b=MjmbVLvbkiAWzCaRMDnhmThnylcuH2TPO3Q03Qe8qxN/k0yrCNsKkFfz9mAh+yTN19jpeQ3TK
 4lQ5OySpqjODehM8UT3s2xR9wOwF/HQKtLp0gxkDepDKw516sdSDi6f
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

When keepalive vote is set to false IFPC will be re-enabled even if the
perfcounter oob vote is set.

Workaround this by not setting keepalive vote when sysprof is active.

---
I have little confidence that this is the proper solution hence why
this is an RFC.

Hopefully something better can be found.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
index afc5f4aa3b17334027f3c20072cc3f059a9733b7..975b91e2c439f659b7f716cff87f73d389641d91 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
@@ -191,7 +191,8 @@ void a6xx_preempt_irq(struct msm_gpu *gpu)
 
 	set_preempt_state(a6xx_gpu, PREEMPT_NONE);
 
-	a6xx_preempt_keepalive_vote(gpu, false);
+	if (refcount_read(&a6xx_gpu->base.base.sysprof_active) <= 0)
+		a6xx_preempt_keepalive_vote(gpu, false);
 
 	trace_msm_gpu_preemption_irq(a6xx_gpu->cur_ring->id);
 

---
base-commit: b5bad77e1e3c7249e4c0c88f98477e1ee7669b63
change-id: 20251010-ifpc_counters_fix-8bd4470e6351

Best regards,
-- 
Anna Maniscalco <anna.maniscalco2000@gmail.com>


