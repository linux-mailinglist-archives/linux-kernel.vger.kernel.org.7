Return-Path: <linux-kernel+bounces-816734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A108EB577BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C061A20003
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA8B2FD1BC;
	Mon, 15 Sep 2025 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAdHyVCj"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C73D1DC1AB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934727; cv=none; b=hU5APmxuoN7xXJ/oLqpERvW9CHxSLs18GOL7FEppdIQBalDlFWHTJR0ujswn7T4yzjZ1iElHE/Fh/por0DKs1+OzqoFt5UpfC9kFI0yz2Tlfz1HOmfRrrgyLZ7S9J8hyEKF/O4L8efjqFDte5fSURUsfCg3Rv0kHpSh2i95F/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934727; c=relaxed/simple;
	bh=gDuk4GIitaqY85XZ1LRd0lc1m7wpqbst8TMHKLHdrZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moVPj8BsDTHxrdVatnHHMfeTU7l5Nv/ivzXxutgrKdkvc+750WFabseVBWqrULSHyu4LZ+tcgQ9+mPqX777mjcrsHG482d3MT+OVbC8+/UHdrhLO64Kqp/4p1fUW1j3sQml1TOJYzUwlBHmEBLxwCNnwEkU8KU109EUcluFTnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QAdHyVCj; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso29133875e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757934724; x=1758539524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=badnNnqIsXkPn2EvMp9u+z86UbkTv8uQkG/3+BUdjvA=;
        b=QAdHyVCjZdpq3WAg7QCnql6PAfsQbk8Dhhsdh4D8VLYMnyb03EVVG04+OWQwxJLvQG
         UQOjDwsZZWFa5ebxusbmWs8fH9TrXpGTvI8je9qTIHzAQnyUv9UyiHerHv5Hm43maekj
         QWZ4F5blcz0XJo6lihsoh0gPc27uKJxnGQR92mPyhRP52uFZQKAXz+fj6j0fd5q8D50H
         csEnQu3AsayOqCNKbnqWzev/YGIBwhK7Z2c8kBf/y5vO+meW0kK9URE+BkXyaodv5Flw
         8RFYgVhPUNmcA7SwXh9HUAOVw3Bvs/cHd/jgw0ApYh+meSPhzV6aUbT0gDyti0yYm2xe
         39nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934724; x=1758539524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=badnNnqIsXkPn2EvMp9u+z86UbkTv8uQkG/3+BUdjvA=;
        b=X5V+/kdQiChsG/D/P/NoMrdArg3u663ePCdqU8gB1l/DZL0+ho1F0AtD2NaD/YqNzg
         0kZlDzdadxZNWvG2gQ9VFiG55V5Kdr9yo4vsKG8MazZA9OhTompEvsOJDMK1jw2+bGZH
         s0NHaa1bfwujbLo7yT/LWGkAJXnLavSJOmgiRhNQucWuA0XN0XowWyuPTUc7N2kecY9+
         MRCx0hNweUSA4TevKTd+Gh9ajPGc3FF6abxxl5N1KRchTVfe5TNtKgoYniihnZmWHCBh
         9zHxpjFlroMLRPmo/Rhs5NTUPQXRB72HDLX4jhkWrkRh3L/al8BkJssce9uo76JKknAx
         indg==
X-Forwarded-Encrypted: i=1; AJvYcCWkSWgx3fKrixQa3u70nfdJwB8hWcCuS/gNzTxgxmJ4zqvN4y12e2pw6MvBvIUp7lUbNWItyacAkeKb+5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YysFa78XiQn89V97BXcdGh8l3WuPOdUFtOvReUvDp6BQHbYpT1p
	RWM04Uftpu1t3pdvL4iNiuMejtRNrD61zvs1y6QM81dDolnGDJPTroSXgu6tIVRu8+c=
X-Gm-Gg: ASbGncvGFCni6hGKlxHbPoHhgWXjF5j1yd5zplt/EZoO6I2ADr9q/Tq6aOa8p7JF3vl
	UOwdqVBgfnxCko1wyiyReTWhEFCPQETQLmU781wjwcenPd7aoxuRmJdnljpLR3MGcJhihbIeQWF
	EBzE5IgahQX+Kbl8dyWL8AR1HFRhtQlAaTFthbm92ZE+5EWnv7KzxtRI7oFtB+I5kH0zC1q1YvX
	yRemQCBEIVsOJJtl6f70xQwpV5iyv9a0MUu7RIGYdBioTYYaH4selQoSCz1xuaBNikm1d6l6V06
	hd77/Ce/4k6W/i/VyeFnbXtB82s5/USwEO3oY5aniSQKkDwKcDDaFDCEOboJFAgrxfjrmW4/6ju
	vSD77RquCvnyuzhO/6xm8Byt+eJuMKu1vAP0tjA==
X-Google-Smtp-Source: AGHT+IGm63UEHY4s1jwbRi4GCTY1XYfJ6+b0wYpsutPmJZyaFuGMrawbriAbxQunREyvB8TmP6296Q==
X-Received: by 2002:a05:600c:1c0e:b0:45f:2870:222e with SMTP id 5b1f17b1804b1-45f2a023010mr42132565e9.26.1757934724348;
        Mon, 15 Sep 2025 04:12:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e037d62besm171722925e9.21.2025.09.15.04.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:12:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:12:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/xe: Fix a NULL vs IS_ERR() in
 xe_vm_add_compute_exec_queue()
Message-ID: <aMf0gA6Zyj3PpgZn@stanley.mountain>
References: <aJTMBdX97cof_009@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJTMBdX97cof_009@stanley.mountain>

Ping?

regards,
dan carpenter

On Thu, Aug 07, 2025 at 06:53:41PM +0300, Dan Carpenter wrote:
> The xe_preempt_fence_create() function returns error pointers.  It
> never returns NULL.  Update the error checking to match.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/xe/xe_vm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index 432ea325677d..5c58c6d99dce 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -240,8 +240,8 @@ int xe_vm_add_compute_exec_queue(struct xe_vm *vm, struct xe_exec_queue *q)
>  
>  	pfence = xe_preempt_fence_create(q, q->lr.context,
>  					 ++q->lr.seqno);
> -	if (!pfence) {
> -		err = -ENOMEM;
> +	if (IS_ERR(pfence)) {
> +		err = PTR_ERR(pfence);
>  		goto out_fini;
>  	}
>  
> -- 
> 2.47.2

