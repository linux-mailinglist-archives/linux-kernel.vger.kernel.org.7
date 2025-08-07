Return-Path: <linux-kernel+bounces-758975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCCFB1D686
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCC0721C1B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F07F27814A;
	Thu,  7 Aug 2025 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OhXs0LA6"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E2267B15
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565659; cv=none; b=JYo+uJv+Hat7+pcn4wdxIUeDU4pG57RhQtVvmmlDQ7ux4rfYQrB/YJeBECJqFltZLq6xHNfPglcMpwekC9+WB+mzgc5F0LPUdLggp36yCnhkqIItPfpiG2CQMF5M1AP6tlmPlOgxPjtz/zphbdFIcYtMhFbSDPHfvckywBWCxZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565659; c=relaxed/simple;
	bh=5QP9nMkkcmn8cVMDf7O6vbSnVzwSiJraPAQjkjZw8JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqegqvGzmc5iK05piDvB4DgUpb9dVjkEd4HTIwkMQ6gvfxMct4t1PfmIXwStePplFq6c/I7W9p+XVVeKTEDdgVG5apyQNqooZNkeAQUN7yb6uSB+KPLPJWcnDaTbaG5BymKW3y84GhUXHBPmRWG/Eh6Lq27k07ElHmZXl8k2iw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OhXs0LA6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b78bca0890so402440f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 04:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754565655; x=1755170455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddfW087BVCo9R6jS1rE1MnNhGEOPmweIEOxT56WjhsY=;
        b=OhXs0LA638MWoYBj8OcD7fgdhggR4nx5uyBReZPt6I4wn7W5dEk/1dljYI0e3ocBaa
         4vwdRfiy18vNOZPi2idI1JyyeJ1c5+8/Rjr3O5JqMmbOxHjJlDpmLv/jpjp+oaHV5YKa
         XUgLzU9BFW+0sFb1NbfPHa0754OTEmUHHjEGMcIluuD1BpDsckRKASY68AkYVJCBVNFO
         BvEB5hYvj+eGRjn07l7EiLg8boKaoaKEgKdj/owelJnL0gwnk3gRU/ef7tMnjkfk5swZ
         AT7ffQn/nwF4GOk/Ji5l8nf0Z4+Yy9g+tS7Of5WVTzGm6s/TkbgMprZsQrpvDvDB3Kb2
         /bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565655; x=1755170455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddfW087BVCo9R6jS1rE1MnNhGEOPmweIEOxT56WjhsY=;
        b=D0kA8AxchKagFtJpjOg321We7GEpiSpzsEdq+BkcJpzU1+U0+ypVMqktUdnIwBHKIP
         xeOXrFjc4vI4HMbjFORhSLnL9FzAg2KGBvXWtRkVuQoVuaB+nrsVvEmcTObXVXCgMbI6
         XMK+GfG+IzO6iK6i37IiFTIZRrVw3Td3WZuf5hYMeLWyOtS23OIa+xZ27J3+vKHfRQAO
         DejZdneyXp8IuoAxKTAZ702Ql16RoODON06LWV+NhEsNXh04tlwtIF8CJqd9JsPO3QkL
         flBXDmffgcXzyqePifAv/h2S7bD9dnV9Jg9JzowBDB2d7pelQocvXYXxiP9md162OcrG
         pT1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkwf/aSgVBCEMpUTdXD3nF7A2iK+EI2t4OLoOT1L2z0otTXt5ht19SiOGtwje9doh5AeqJodO8JSw/VUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQG7Rt2DpRE2oD9uu1xJlLZyr38aoOfSmuy+qoJBPQ2RdxP785
	mUZ3bQpnUxfGYXzxKAozzwPfQCAFT9lm2XpF0g7r6JcDAIXm39QYaP2KbOvnPwa5K5w=
X-Gm-Gg: ASbGncs4c8bXnnpcLY0g9N6MQz/eS6xXNoOnMZRc23Ijd0K4c/qqNvoQZEFiYwu0x6o
	2mYQp6kLBCohVMdssY8etzDDL153cCEGcunEgZQ9VwoL/l4/lQeVAJ47W/aeseHRImHfSGRJw0d
	5CXf7DkgR5HsJDLOQ5XbQMnplNeo0tTEDV0l2lqJNJ8O1WjO12LizjqjZhrYyJV4Yyyd5NjmAY9
	zLo7LNE1rYG/JtCrBu0dr5WYcSVEMl3qUnYqAUZkPA+EfR2z42Yvc4YpdYQcv6zYnI+402RgrTr
	XpBHaeqciKTTTEteo5WqzmJ0pCab95UeOfOmv6Q/KpJ7d1NjeIyJf79i7sFi+HMYIS8z2TvAaD0
	xmC+F1a1NU0Tq3ZbKzCLqEk6gwaeb5ra4zwg=
X-Google-Smtp-Source: AGHT+IHOu/dkjQy4sl03HVD1C9gSx90Y0R1uDAO4yyw9e75J4od/tpJNEfFOepafebY+xXR46niLqw==
X-Received: by 2002:a05:6000:1885:b0:3a4:eef5:dece with SMTP id ffacd0b85a97d-3b8f41ab66bmr5864243f8f.35.1754565655344;
        Thu, 07 Aug 2025 04:20:55 -0700 (PDT)
Received: from localhost (109-81-80-221.rct.o2.cz. [109.81.80.221])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3ac158sm26896024f8f.4.2025.08.07.04.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:20:55 -0700 (PDT)
Date: Thu, 7 Aug 2025 13:20:54 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] mm/vmalloc: Support non-blocking GFP flags in
 alloc_vmap_area()
Message-ID: <aJSMFgvrLEN-nwdT@tiehlicka>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-4-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807075810.358714-4-urezki@gmail.com>

On Thu 07-08-25 09:58:05, Uladzislau Rezki wrote:
> alloc_vmap_area() currently assumes that sleeping is allowed during
> allocation. This is not true for callers which pass non-blocking
> GFP flags, such as GFP_ATOMIC or GFP_NOWAIT.

Those are currently not allowed so it would be better to mention this is
a preparation for those to _be_ supported later in the series.
 
> This patch adds logic to detect whether the given gfp_mask permits
> blocking. It avoids invoking might_sleep() or falling back to reclaim
> path if blocking is not allowed.
> 
> This makes alloc_vmap_area() safer for use in non-sleeping contexts,
> where previously it could hit unexpected sleeps, trigger warnings.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

With the changelog clarified
Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/vmalloc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6dbcdceecae1..81b6d3bde719 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2017,6 +2017,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	unsigned long freed;
>  	unsigned long addr;
>  	unsigned int vn_id;
> +	bool allow_block;
>  	int purged = 0;
>  	int ret;
>  
> @@ -2026,7 +2027,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	if (unlikely(!vmap_initialized))
>  		return ERR_PTR(-EBUSY);
>  
> -	might_sleep();
> +	allow_block = gfpflags_allow_blocking(gfp_mask);
> +	might_sleep_if(allow_block);
>  
>  	/*
>  	 * If a VA is obtained from a global heap(if it fails here)
> @@ -2065,8 +2067,16 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	 * If an allocation fails, the error value is
>  	 * returned. Therefore trigger the overflow path.
>  	 */
> -	if (IS_ERR_VALUE(addr))
> -		goto overflow;
> +	if (IS_ERR_VALUE(addr)) {
> +		if (allow_block)
> +			goto overflow;
> +
> +		/*
> +		 * We can not trigger any reclaim logic because
> +		 * sleeping is not allowed, thus fail an allocation.
> +		 */
> +		goto error;
> +	}
>  
>  	va->va_start = addr;
>  	va->va_end = addr + size;
> @@ -2116,6 +2126,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  		pr_warn("vmalloc_node_range for size %lu failed: Address range restricted to %#lx - %#lx\n",
>  				size, vstart, vend);
>  
> +error:
>  	kmem_cache_free(vmap_area_cachep, va);
>  	return ERR_PTR(-EBUSY);
>  }
> -- 
> 2.39.5

-- 
Michal Hocko
SUSE Labs

