Return-Path: <linux-kernel+bounces-850643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998B3BD35D2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7FF189E40E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE9125E824;
	Mon, 13 Oct 2025 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T7ULooxs"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C78D246BD8
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364821; cv=none; b=k3f3PGurbFy1QfDnrgMNi+uwuFXm95Yf1MHaGO1PkRUGjq7jgVOl+ro0WJPZUxsSD2q6zct6/l4vIGiNAaRtQ6x0PImhptVUEoj3yi8CHpwCasexu6w1k9x72+upO/0TihY5MUAcuNjX+OcLQzCxAIAOGLq+u6rxS4PDtOVCfBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364821; c=relaxed/simple;
	bh=VrwVxnBJbE1HH8epyWBnfON3AOVOOL93Wc26DKJqcVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EVPoP5bQsG1vGvNksQR7MtzKISMm8c2gf+Ihi64CMTciTF/ElwYMHYVoK2X+6WlLVcXs1fi+qrZv2c0Y/LkmTsdDEIYFfaM4sppxhesTJ2aHbdHvmI/TddlmxadEtda5FATq4HrUqLo2Jk4J9fNEVJDt1NJVssXzwuKJ4Yg/UIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T7ULooxs; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso1148259e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760364818; x=1760969618; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VMoJohml7hT26UAcl5VOsiah4+MzHyU0IYmm0KpSVVE=;
        b=T7ULooxssY5ZM/BQm4id/0/6TPr3Yw/1jqyL5rk93NrCojhaq5EsU4NeaFcGmCUvcl
         NVlQRvUjZpR9ADpWJPMP5QS99k1AxPyHVseAaQVaDoKBtBSDe89YP3aLAVAUUi7g/m+X
         vmiwn3aBSr0fKh204I7+94nDc7Sfxgt1o95Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364818; x=1760969618;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMoJohml7hT26UAcl5VOsiah4+MzHyU0IYmm0KpSVVE=;
        b=tEeXBpvO+ZHlHZ4qIYN4XwsCjw9ARVttWcDW9h4eaxFw4d1Mo+e+hT7Ph4gu+sfkL1
         tEB/2vTyVAnGvXcW33NZdbfRajN0btmIegn8SKTmFAvwZy3K66RLou+NjcnjOE8FGhkh
         mDdQk6njOhK/mATv5H52+cgNkXzroeg6tFHg1+iUC1IdEe8fdH5Dz4I2BQyp5WNtycpZ
         rsHIzOAhB+mGWqrvgrR/Y99DrqXbZOL5E2QaF76zAptUldibW91l/Kl9aveIVRUQR16g
         RhSvXlsPIF3Etw6gQ1iMqDASLMCySCrbFubEv8fFe1qkSi2uk02fELrayFnF7/DQG2Et
         YG0A==
X-Forwarded-Encrypted: i=1; AJvYcCXgd5zqE5Xpq086Tnjh0hWHP+O/TU9eagtYPoPVEhLV0Wv2zWmaMDwCITiTyMjMvMH1PxoQkb7o1OArLps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHf7M2i34VUbv5TCEI85TvrIKjmAJdAdcsiRbyeSIVFgJtWIq2
	CMxasKrTXrxyynIxLjcwS+bB7lBVT2DwgbC8k5Ixrl5b7mwymy4kC/mSSmfFf4b+OA==
X-Gm-Gg: ASbGncuYKoiBkvQfni34O8GMMscmNj1jZIDqD/Nxc4RKUAtsKBBBQHyqh/kLhlhL+zB
	9mmpgkwbFM4G1NPwaACVtPL7qB6INiiy3ueZvptCTzi49YACoa+dCJEgmKjLFD1xuHJjGykPq39
	dh5q15C8Hzv3L9gMd1D0BF/KNAmRUK/CoTeXq2JbsKQ524kupkQvYlbV9KRWso2/UvjtpuLpSYO
	Ef8rOGi0SFw1AUjsqvRAYtXKRAXfO68hIop1hw8TKiZcpyXs26jGYTNdg5ZpUcvPyNOt7KXDe9c
	xNV7xC+/5AF/mVhqg/LFpKV73AkfB0priUvz9Rbov06eb1eEfEUhc6ff2SaD8NdP4hnoq99s/Y4
	PwtSx9Ca+XfG7GENy9Zg8H0UJwbAILdC9xq8/CsOuaUigP3pOdnbMB+4IoeZoROIrnlwrNqmSno
	p+vMLedQfOd0meNtApqwS0lzIH8qi1
X-Google-Smtp-Source: AGHT+IE2EczYKFQFN7sMxN2/+GfInkv+GHaLvdo/s9X0uHJy14+SUpjLLq4nVeukL3Rqh7NbHKU/DQ==
X-Received: by 2002:a05:6512:3c9c:b0:577:494e:ca61 with SMTP id 2adb3069b0e04-5906dd53f00mr6801047e87.31.1760364817682;
        Mon, 13 Oct 2025 07:13:37 -0700 (PDT)
Received: from ribalda.c.googlers.com (56.213.88.34.bc.googleusercontent.com. [34.88.213.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f91c0sm4168722e87.41.2025.10.13.07.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:13:37 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Oct 2025 14:13:36 +0000
Subject: [PATCH] media: iris: Fix fps calculation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-iris-v1-1-6242a8c82ff7@chromium.org>
X-B4-Tracking: v=1; b=H4sIAA8J7WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nj3cyizGJdy8SUlKQUI/PUNHMzJaDSgqLUtMwKsDHRsbW1AF8mgcJ
 WAAAA
X-Change-ID: 20251013-iris-9addbd27ef76
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Bryan O'Donoghue <bod@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

iris_venc_s_param() uses do_div to divide two 64 bits operators, this is
wrong. Luckily for us, both of the operators fit in 32 bits, so we can use
a normal division.

Now that we are at it, mark the fps smaller than 1 as invalid, the code
does not seem to handle them properly.

The following cocci warning is fixed with this patch:
./platform/qcom/iris/iris_venc.c:378:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead

Fixes: 4ff586ff28e3 ("media: iris: Add support for G/S_PARM for encoder video device")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/qcom/iris/iris_venc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
index 099bd5ed4ae0294725860305254c4cad1ec88d7e..1234c61d9e44c632b065a5c44d3290f6e1491892 100644
--- a/drivers/media/platform/qcom/iris/iris_venc.c
+++ b/drivers/media/platform/qcom/iris/iris_venc.c
@@ -371,11 +371,10 @@ int iris_venc_s_param(struct iris_inst *inst, struct v4l2_streamparm *s_parm)
 	us_per_frame = timeperframe->numerator * (u64)USEC_PER_SEC;
 	do_div(us_per_frame, timeperframe->denominator);
 
-	if (!us_per_frame)
+	if (!us_per_frame || us_per_frame > USEC_PER_SEC)
 		return -EINVAL;
 
-	fps = (u64)USEC_PER_SEC;
-	do_div(fps, us_per_frame);
+	fps = USEC_PER_SEC / (u32)us_per_frame;
 	if (fps > max_rate) {
 		ret = -ENOMEM;
 		goto reset_rate;

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251013-iris-9addbd27ef76

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


