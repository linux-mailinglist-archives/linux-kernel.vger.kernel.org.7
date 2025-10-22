Return-Path: <linux-kernel+bounces-864776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC38BFB85A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916071A0527A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3584A328613;
	Wed, 22 Oct 2025 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccJHk/a/"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CFA325482
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130982; cv=none; b=OSezLMiNIX0qkz1tqEwhV79NxA0qxtkgdUr82Y/DxNlM8jctoRXTloZrSQhYy+EEKgZTdWbdl/3z7og9WJ6TdT1GrpobYatO9LhnI3WKe9VhhtVpodOHXjrq2CttwC/z9VCg0v99mCJxSuqy+Sf0fVRj32fdDFkEM+h1H5rgGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130982; c=relaxed/simple;
	bh=4+w7XkrS1+QRdCahEtOYBcgFXdxrPu2UNwNYO31Dthc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a1yZIcl6xTsXpn55WXZZeP/aKHswrPn2LEysMpTlPR4v/+8htB1co7R+wakHSq++SKESnSgHTf8j5KxbcnfyH/JOLDTlHwvieOMBZpNyipcjjSbfB2k74VJxQkXeBN39z+VLFWS+Dd586o69otWxozAE/32jldfJ7o0WEyhh00Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ccJHk/a/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-474975af41dso14229825e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761130978; x=1761735778; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w9oIpyKZKP65JjkSPCQNgE2Eec7phDpEBv4WlPPRGpA=;
        b=ccJHk/a/OyBWvpylPY+/8NUG5D3LvAJ+cBMwo62fZYxYyQUHXELTs4WWBODtpd9grS
         AaSqpRvibqz5+FPhPZ5drm1cIagWAZRcgnEcgSjunRzgO/cK5djEeC5d0fdAFFhUhg3v
         2WiB6muEl7elx7z+/518NP/LiFO5SbmuzljznyN1LNc3uxjkQennobdcVWYbpzslHYTS
         /MVQMC2efhsWsUIdcAyMV2QGuUKWDkl2B06RupR2e5xBG0JCsMFzHIGvnKfD7bqjRnei
         JwV0u1dG2+dlbIQTbz6DjB/2xi3ZVJimRwKNb+oj8mMNp+Dv9x3vLxwIqAtmFhyXLQVE
         YPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130978; x=1761735778;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9oIpyKZKP65JjkSPCQNgE2Eec7phDpEBv4WlPPRGpA=;
        b=Rb5FSzGJGdBpn8wFgEnMkSCK++iSSiPjcGKIIFyeGar1WnyuYgkV4yB+WsQpeYx4/e
         gSv/pWy7TwLdNgutCxuhj2rdkDLT/0sXDyj3oS3Zz+uQZS+FEdGtjfXgx/BwlNJkUsGy
         6yut0H14YcIdgt/CykhFPNV4syIszFoQtocvSdbLEcV9TG9ErUcMP9Bb2DDRdVBQ9c2U
         YWyF43bRG26EKi9jo2I2Yd3FTq3MWoCv/oeAMpZGymfaGQAK98ILIqFadOm9i2SASQPQ
         uda1wL8z4fxMjqcrLjciewUX/yCAloNCA+N6Uh9VQNlwpoeN0MugIQCHIpHjMk5LjMRC
         Uwcg==
X-Forwarded-Encrypted: i=1; AJvYcCXdenUo+PIFoA3WusIZlbsFJoW00h+OdcXQr8GbJvg2wBKkSCrJkcp5hSMVqSTRhmUc3NXb1FRUJaELNf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqIaH7WBXAz56BntXbLUzIyXTUUMNOjujZbUB1GUASLzosMIgP
	0cmsitfffVTYcE8JWRZ7oxRsuop1MDC2K2WicLRgy0n0h1pMFOfyguQ9LCZIpc7YDdU=
X-Gm-Gg: ASbGncsGRH6yL9nHEZwiGLXhgSeQeqVuI8Mx0Av32IvAOFhCpl/TGhBgndft0UZAA+1
	8fZ3BmKvU29jrNZr5VTdZ7SPzL5f1CFT8s6MLtiNJRNxhy+7u9I9GiVA9apfv/Zkdz66ia3dxv4
	cACsxLN8av350r0kBVgJU3q8GhZxve6FBXoQ/HHrJN4iiV4+E4WKsLpRPCTky0ir00kTmlLB13T
	99ApDcf/5j/AhJjUds5d1MLno35KG+QJ5Ywpk/oeoqlaO7/r0/GZZJzzQn1SkrGiURzjeDRBk94
	dwFS+ians1lVEE2BtSPYOa2whrMAAHHcJsYoApbIRIxPAuIL7mrqtR/idoYnB9t1adOZv+8mhSj
	P5uYotGvJKIga4jM1nmvIHeau66bubToYNDTbpQDy2C1S1WkySyn7W+hM3E9LvzitBnh3qzCk/Z
	I+YA6lhxAjY31ECQh3
X-Google-Smtp-Source: AGHT+IHuoJkLRfik10AD7NBPZIudPe/zz0dSg5CN+bjMkIVUA3hu11mzQRZgc9RP/6950DlYAOSGLQ==
X-Received: by 2002:a05:600c:5298:b0:46e:432f:32ab with SMTP id 5b1f17b1804b1-4711791d1e3mr152626135e9.33.1761130978504;
        Wed, 22 Oct 2025 04:02:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47494ae5510sm35646435e9.3.2025.10.22.04.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:02:58 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:02:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Liu01 Tong <Tong.Liu01@amd.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amdgpu: unlock and cleanup on error in
 amdgpu_cs_parser_bos()
Message-ID: <aPi53iS_z4y4uVef@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If amdgpu_hmm_range_alloc() fails then free the previous iterations and
call mutex_unlock(&p->bo_list->bo_list_mutex) before returning.

Fixes: e095b55155ef ("drm/amdgpu: use user provided hmm_range buffer in amdgpu_ttm_tt_get_user_pages")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ecdfe6cb36cc..dac0b15823f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -892,8 +892,10 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		struct amdgpu_bo *bo = e->bo;
 
 		e->range = amdgpu_hmm_range_alloc(NULL);
-		if (unlikely(!e->range))
-			return -ENOMEM;
+		if (unlikely(!e->range)) {
+			r = -ENOMEM;
+			goto out_free_user_pages;
+		}
 
 		r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
 		if (r)
-- 
2.51.0


