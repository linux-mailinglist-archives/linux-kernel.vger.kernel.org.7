Return-Path: <linux-kernel+bounces-822440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA51BB83E34
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2111C00558
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11879243376;
	Thu, 18 Sep 2025 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="exZcVjA3"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD40F1F4717
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188809; cv=none; b=UDTI22cI8rdlYIynwfa4J4Z9Ows/YcbgOGsrcQHcx5rryiluhekP0C2LvgJbYErX0gG3u4ENkUsiInAN/WwnggKwiJmqamLnQUZpcKYGGiB5YEbOiiNVDuBZzCgsWQRGChtDj/o8AdURCe8v/vm8lGcz6ZEjNNJnVboG9Un26Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188809; c=relaxed/simple;
	bh=ad7dUBhWdzfID7qn71J7LfWlieFdmy7vuvrHGqyZGng=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NVxoaKD3yh147hfzacx0i0pLf0G/AcnuTr8xDJQac6zrR7iP9CMbN9+bIT/BTyKIiNdqM5devkZsYmppUrPr0zLUrJU6+qNWKmlY6In/3wVtIs3OL6LQMXqdC6YZevwaVe2mVxvg/aNlCOJgs0EUTgpXcheZxzZyDQLWuDHGjVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=exZcVjA3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so6667495e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758188806; x=1758793606; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJAzy7TZLPpiK0Xxbzu1n/iJ3JX7fhsQtzUstUQDi6k=;
        b=exZcVjA323G6xMP+DMJYF2bGh9m6nYr93cFoSJ5XJQWr7XOsPxIlCvLTNkllFpYcWf
         J13CF9gdxP04R1GOExp4eiKh0ZKywwbWZoib4v3i69iXuFTYqCbau5tBTXoY3BlJ5pGd
         aGt2ZXzGWUZh5dSCzhWVEF4C8SDCiLEb4oHuMyyDnQ3hKTlFADST3DeTeHK+wXQvZQOB
         /xG6lABtGi0nb6FqtTMxqLH2AsZjl/yYZDXotHGgIMSIZrv+ExUVU4eIIV2CRkHB60Xh
         MrhPIRyxUZhCs5ViSK7yvNtKbhvK2BAS1nhZUjPhQqxI4AwAxohnODi7UcAkA+w2RZl7
         B6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758188806; x=1758793606;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJAzy7TZLPpiK0Xxbzu1n/iJ3JX7fhsQtzUstUQDi6k=;
        b=NnsHv571mB2DnNh27KcgE6sVG3kuMiAuP8ZPYt9B06jjTP8G5iSOd1x3vwe5k0srEr
         LxiC9/q1QtYQbz9jEweCcry55JLgWFceMqaOW54T7SE/Ft5iI7tk17IsgSxNvZnGNZ0u
         g+dPWQIxgoQl9Iy9sOhsxIE/H66d3URQ8GsN6r/CftqzILetTjBwK8Cm0IRgMh3MyGya
         bJE4AQdcUNsJfapypHhDa10IcNcXBvEi5pW9lbamGy9KdkVxvLcFoyArotsUqjsOiI6n
         yRV17jV4rlulHsovUk37Q11tYT2SBaX0/t4o6PpM2fXTzUGxBe76HKZmvyZVqxDaa0pn
         AH6A==
X-Forwarded-Encrypted: i=1; AJvYcCVZtkTN1D59bsdoJI8Hqal2fofgmbtlElh58x4uHLyLmVoP3r41E5kd7UrMffNllJ4JalrvdzvJ0jpVvqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+POYW/dllU6qwZmIxVHeGrsA5FDaz2JM1aK6QOOf/8GJhOUSB
	ZFqs2Frcq/nR/RadImSLXOwInsnDeV3CjDlNUF0gyN9loQFOSFGoGhNLdLLULy6NEFE=
X-Gm-Gg: ASbGncv2oMbTPFawB7hqssS1wqOx9LI6yIn2T6ZrjkNXhQH863V+cyG8zLwrKbVnd+c
	m3WkLDS3TiXn0frmXsN6EyljzKiIFp0RkS8FCVSU3I9efATqprQwOru2QFr7jbBRc2qGFUNF6Ve
	eb8RZxbzWjV42NBPlAEy6rPSBE6DhvyuixB4wBHF9FPbJlBEAL8lR3qbIx+8hc3j/5By9YIwTk3
	i42vXEBOc1bEwT5hG2j50gpGCHMs6gIriCplaD5blcT7uYPj1g8uvnPIpUMrrgQjZo7q5SzBImh
	oJ1E7JuDotm3eyCzTZ9NYYXVB5nOQP4CV3o4gGeh+TMKS3z0ht2B3nnDrnZXj9ZOBw90xcNflRU
	34TZ8v8/bUzTt5XXxEsH32vzQpnElj/otMnX2mzns4CQrOQ==
X-Google-Smtp-Source: AGHT+IH1uv0RIxQ38Bm26GanPvGmDL+dRiH2jf2osh70wH0uYOlhbcgFH9gpcU5WdxVF0lInLAkHNQ==
X-Received: by 2002:a05:600c:8905:b0:459:d577:bd24 with SMTP id 5b1f17b1804b1-464f79bed6cmr20555095e9.7.1758188805990;
        Thu, 18 Sep 2025 02:46:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46138694957sm84698395e9.4.2025.09.18.02.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:46:45 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:46:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Prike Liang <Prike.Liang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Shashank Sharma <shashank.sharma@amd.com>,
	Arvind Yadav <Arvind.Yadav@amd.com>,
	Sunil Khatri <sunil.khatri@amd.com>,
	"Jesse.Zhang" <Jesse.Zhang@amd.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amdgpu/userq: Fix error codes in
 mes_userq_mqd_create()
Message-ID: <aMvVAsrczM9W2S7P@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return the error code if amdgpu_userq_input_va_validate() fails.  Don't
return success.

Fixes: 9e46b8bb0539 ("drm/amdgpu: validate userq buffer virtual address and size")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 2db9b2c63693..775b0bd5d6c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -298,8 +298,9 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
-		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
-		    max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE)))
+		r = amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
+		    max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE));
+		if (r)
 			goto free_mqd;
 
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
@@ -330,8 +331,9 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
 
-		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
-		    shadow_info.shadow_size))
+		r = amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
+		    shadow_info.shadow_size);
+		if (r)
 			goto free_mqd;
 
 		kfree(mqd_gfx_v11);
@@ -351,8 +353,9 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
-		if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
-		    shadow_info.csa_size))
+		r = amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
+		    shadow_info.csa_size);
+		if (r)
 			goto free_mqd;
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
-- 
2.51.0


