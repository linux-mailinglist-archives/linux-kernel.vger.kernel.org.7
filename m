Return-Path: <linux-kernel+bounces-775298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C812B2BD9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67291894175
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1280B31CA5F;
	Tue, 19 Aug 2025 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qax5foHh"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D662631A046
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596305; cv=none; b=pvrv6mDbCxHUE7O8jsZ7MQ/ka0ZGxC/TV48cOFoh+qi9d3J+1oXyopTr+ro3KxtPucQEQu2RpV5QhuzAUPLnk3H6bplwNW4Yj57uUkr9jGhKOy0xTEHol3klxjvAObe6zzH8PuvPrlF5r9jbhJFVcTDcmtD7fJbMkxD4TjT/uKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596305; c=relaxed/simple;
	bh=yeTB2l2UN+Dfs8SkRieR9aXEQAYC0WR3yQg5oK1gn74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/GHIrsotJWHI+BpAvqC3ALDtLAd7Zc+NLynxXa+6+2Qh2ETDYLrXW4VL1iQrIP+bKBA5b0gLDHvOF7QVdoC4t8upgKQVxrFDX7C1aSpipHMd4eOWZ87x2ERmhgTksUGb+ell6A4TASn7lTAp1nDWq9+1vPvLt8Vd1Vyr/C6Up8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qax5foHh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b001f55so22940685e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755596302; x=1756201102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cQNHUhi6q6rKtdJPu5piFu1Pt6Qdn+yGCZCHH5qFNtA=;
        b=qax5foHhCypgZ5WdfDPa60lxPZ+Z9AfJNn/5Bn/wl2SyBhIZgfZQGLWt+hLEu5UOHN
         K3as4LoEV+xTautv3DfkBS1wz1wMtqnjD8DP5oWlkR5DYSP1iYrceF8r1ipVBcWVAexC
         +3UIYM+/cAmUpa5GSR99HC1o8Zx+nngBYeR5f+uYYfZc2afS1QpPYF4rGXOALC0QvX5x
         8vQOzrC9rVCxUeg93vcUXNUJ1YEB4AtgZL2zIFFz4WrWpswG3Rl1qN2m4q0UaeUEeiBE
         /GYPe60k5UUIMg36u3nYsjiYxyKabj3R5VXP3ui9I8uQk3X0yhbC9gL3w1AY7JEO5eEP
         tDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596302; x=1756201102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQNHUhi6q6rKtdJPu5piFu1Pt6Qdn+yGCZCHH5qFNtA=;
        b=ABJXoUObwPOIHCjWvTU9lZF2HMqNrz6oGlcyzqAj+w9wXhCLVo98y8sC6Q9xeaXeL8
         rXratMcNNbLWV7xlxdM57bkoP2k/01EZavRauTRPYJteFHGFU/gCphamDdZA4f0y2Bsc
         DnWZk9XeE4S3VKdj+MxUEQbBJhewZ0Ztz0L7X4LxrIVxEDy1pxjPvY3M4Zu7vvtg0cgY
         LUgb7Ex53EPcZlu8K/AoLCjnllWQwPpHTTe1WdOIACqQ2hxogrAA1N8A98gxcZV6w35H
         35PnlBtAt8tDn9o0+lvQQNwIC8AE8JjzE+8u8tYwYGDToc3cUOcTGyVX00l7XpuS7yVc
         dMFA==
X-Forwarded-Encrypted: i=1; AJvYcCX2udVzijw++kCOYZA4OyXkqO2Nfk9PACRdvAfXuqfkT1/zpoe6JLzqBw1UjQvVyNn/sLKHu/hiJjDp3s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsEbCCKoTIqigq3/iWYOGXHH1g0EVLa2GYgu91UiTXgGlXWwcB
	gzCK/I6mTjg3v3+YZHpYGJCn9i6k/elQYBV1eRE2vnckfv8BNCs14u3we4mcRc73Kmw=
X-Gm-Gg: ASbGnctb7+6x7SJx5MYutcvMPerPV3rVfDToyhpEcM7Snyib8eWu5sxGMoA20vCWIIL
	VxXwh3h/HCaNLtMlCKKAJmy7EAoppFc4rXqfWe/ESf1Re5S9dEYvuCu+FGWH6AWd6uWyfTTwmPk
	cz8ssaD1NqzJVKyBzCpM6KpH3VQmo4mYS6C3TZHKEOQ+RjHEAlWuS7B0ZjkWN5Cc02mrYNVCV8S
	u6/YlMIcuBFnWVmLChE2x9UXgwKZ8MY1yBrkPGhwV1JVv5OxyW+o0R26ltnE/KlpnaeZQeyKAHX
	YM2rkprsbQ1FL0Su88wkxtchrDAKVgnQsRuZ+qd+pVs9pIqF9GLWS9two9ifh5vOfmE0nggIqSf
	nQqTY3u7xvn1HgWj1bu8BoVWgKUU=
X-Google-Smtp-Source: AGHT+IGyrjULf+RdvVTDZSXTBxzshpoUU51bE+6aqkNwYFecCzQvOYD+ZNcx9bLMZ5tuTwxDYI9CKA==
X-Received: by 2002:a05:6000:1449:b0:3a6:d7ec:c701 with SMTP id ffacd0b85a97d-3c0ec66078fmr1105498f8f.30.1755596302031;
        Tue, 19 Aug 2025 02:38:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0748798aasm3056876f8f.14.2025.08.19.02.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:38:21 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:38:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/plane: Clean up 0 vs NULL issue
Message-ID: <ffa882934a0c0db3c7d2493a7b030051bfa8f683.1755591666.git.dan.carpenter@linaro.org>
References: <cover.1755591666.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755591666.git.dan.carpenter@linaro.org>

The create_in_format_blob() function returns pointers, not integers.
Change the zero to a NULL.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/drm_plane.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 38f82391bfda..ad21fc855aea 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -210,7 +210,7 @@ static struct drm_property_blob *create_in_format_blob(struct drm_device *dev,
 	formats_size = sizeof(__u32) * plane->format_count;
 	if (WARN_ON(!formats_size)) {
 		/* 0 formats are never expected */
-		return 0;
+		return NULL;
 	}
 
 	modifiers_size =
-- 
2.47.2


