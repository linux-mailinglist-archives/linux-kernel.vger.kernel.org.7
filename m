Return-Path: <linux-kernel+bounces-732616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828B2B0698F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2964E4E381A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCF32D5C78;
	Tue, 15 Jul 2025 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ipjDcwAV"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F098017BA1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620332; cv=none; b=GssFzgc9E+7nK/7aOlwtJI0NAXnhoRHlxDS+PKPvFOlNejO/gwdXpIIcUa4woDdI8qn6gPCw3lqSV3SthDnb0dcpBBt/dJOvRc0tASrr64zwJnrx6eAoZxvc8QagR3h68Ky6co2I+PKuvSudBCKl5n1zEHgqrz+cm2n3onxw28U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620332; c=relaxed/simple;
	bh=sxduJx+oAePAjNzvsNFqsRA6MRLgkNZm51fzqOFHbDM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nYlrM5vs60InTpd8hdjVJecOOzjXNxH96f7YmllTlLN6JY++pqsVICYySS7S1zreNTMcQDyEs+1+PKOtoizeknFnVENqxjM33NUs9R8B4mt+bwWoiLV16jaIxWTuJPJoXAZVvOkX1ZJs4OeC2wwWHLBdMQFrICAP1d8KER07VIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ipjDcwAV; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73e65d29fe9so68118a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620329; x=1753225129; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dQdS/fnesxZHeRTbK+njettpxhb9T3PJtvTTlq4Hbyo=;
        b=ipjDcwAVdEIBzQiDUqOZ7hog4rwKbPxvfQMoy0QhvYZEKaLbqsyegOO4OeOGg2DkPn
         /k9Ead2Y7U9wF2KgjhKi5RMYs3D4RT9D3MNB4hSV96Cn1rPjrqJkfmRmpK3IjdeEwUSM
         Mjyz9T78AbmxCtTLSBtiS8EsVT09R8LW4jv7pcgMgpkL+bqPcjZzR23rEeAieHeVOuBX
         Aj/ATBAbUk0imeUobNcRh4RMGQroY7WLngnVkXTRu4rQEVsMrFr7tZ5esaM2Bt473XNa
         xgm0fF18tbU4UBpYfEqy3MUijZkcpWnJ5O/7dXpKq2asHujt9OKan4hO6qRIAriwRRqg
         BChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620329; x=1753225129;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQdS/fnesxZHeRTbK+njettpxhb9T3PJtvTTlq4Hbyo=;
        b=c8J3HU+k4zLGgWuSrRv1WAPjD2DgOosZGVSaXSAWo+6/AtJi20DlJcAEjI0JNo9Gfj
         y2uMk5pOqw9iBZCBQOShUukVi5h5anqEYRe04bs+WLxP+tAgt/V8RV1OJiL6q+TyBItc
         NRrc2RgC9pzzENl3aRIVIdQUR5mJcKBaIvaMSk+5u1MGkCLAOYPYk1oYVJ5x9/VdvyPh
         Rs2LoY3VLDn9BEwPbcbIn1SW7eqcujNG8kaefQY/ebSrnmGZA9xHbxALF9u952kUwjqy
         JzED5AxQwmG2hYZ5Attc1ra2SycB4E+ruuLTKA3r9xgRGP9SCGJEL5V2c36WKJfAFPtY
         IU8w==
X-Forwarded-Encrypted: i=1; AJvYcCVlsx6xqK8Xl9qY93XDmWVrc/VntYe6DD9lDU+xEusup5QyhwRDmnNmsas74JPuh8UUnx2kHPSxvaeREr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm6DLHi4D2ePyq07l1mZAGFEgHjxbWV5eVj2G5/yv+ZWVd91By
	5KHw03Ep2JGNA5WqU8z5N5zytsCYgQBLghPhBwysGFQdUuCNkY6m0zE0TCxSKNmos6A=
X-Gm-Gg: ASbGnctPRu/1v5jAjwpEydj2vNPv3l2xYZUK3fOpr+T+l9oJdptyi5RV917l3az+39r
	t3FUFHtH3FyqkZezB9K8zDMc0CFgMARiSeYKDNwtd4s2FadCNsYvmhTrmD8wIpnJgIZLOEWPvhH
	ulVaBfJnMNi0cLPJhOvY7KxdcThfXNySCjZ5ELR9UMpXDjs5khE324pZiyUxKh4y2sRaPUKu+fn
	BkD34SbDLoExNKVY2YQGGecJjpBm0bKJbg9Wtm1+rEn6y06MFukH45m5LWpAVm26z0IRnExDWTM
	v/8KoL2B1gFAVGuvPzZce3Obip4AUk+9XTVtjR5hVANB58y8OrGJF848eWWCfqfNj9Ou8oMZPfZ
	/IxbALX9m532E44kd8MiELX/nfRss
X-Google-Smtp-Source: AGHT+IF8MmVG4ypCu726fhwqLEetif2ChyidvWvdhwWbSrW4wyOjZnawR/MGOE0avl2B+dB2nPbJkg==
X-Received: by 2002:a05:6830:2d86:b0:73b:2751:eee2 with SMTP id 46e09a7af769-73e66613225mr334520a34.23.1752620329043;
        Tue, 15 Jul 2025 15:58:49 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73cf10857b2sm2518429a34.16.2025.07.15.15.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 15:58:48 -0700 (PDT)
Date: Tue, 15 Jul 2025 17:58:47 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Shashank Sharma <shashank.sharma@amd.com>,
	Arvind Yadav <Arvind.Yadav@amd.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amdgpu: unlock on error in amdgpu_userq_create()
Message-ID: <ef53ff29-4d1e-4f07-a431-c0b91578f93b@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

We need to drop a couple locks before returning if the kasprintf() fails.

Fixes: c03ea34cbf88 ("drm/amdgpu: add support of debugfs for mqd information")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 492f1089316f..c3ace8030530 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -521,8 +521,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 
 	queue_name = kasprintf(GFP_KERNEL, "queue-%d", qid);
-	if (!queue_name)
-		return -ENOMEM;
+	if (!queue_name) {
+		r = -ENOMEM;
+		goto unlock;
+	}
 
 #if defined(CONFIG_DEBUG_FS)
 	/* Queue dentry per client to hold MQD information   */
-- 
2.47.2


