Return-Path: <linux-kernel+bounces-817512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A1BB58319
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B13348297C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608FE287273;
	Mon, 15 Sep 2025 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tu3/qjRC"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5A7285CA4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956292; cv=none; b=VkMhhyQFZ2ciFFqHCUMSBjjRido7pFBOVc5tDMHqq3vepMtBmWaT6GXInX1l0nmNDqJj5TrFes0woq/glWGZ4qqm7Uvjkb8aj33IOY1WvOvAhU2YjvdhFVOlrepOMl38iS5cEYxr6Lz/IIqpgRHdwYUPE3ZGLGaLp6JE4tedc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956292; c=relaxed/simple;
	bh=qda1dWcgxmRXR+So3Bm2FXzAIEJ6VXo2r3eN9sCdyvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6Uxehl06ol06kCOisLhqIZdOXFtgExT7/MpkXHaejPtd3nt9GfJ/QZCiovT7VbB5+09e2BILKBlV9U5jF6pJG8l0jejT8vG+BCMQpB+F4ohoECdnZzPgqSSN557l7efECbojXNxQVrC7cPjw6STuSqFXW31vcAT3uOUXKAoJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tu3/qjRC; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f277546abso3472928a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757956288; x=1758561088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Tl/RXGMAL1JqyStv0MTAwh9nUwRE5C//Qnl70T6OQM=;
        b=Tu3/qjRCoJU31DFlIxDjfhxRXKulmnIK8dPLXi1cXZ6rGl7HGXOj1/2a8FGZwWEaqL
         JHB414A9wwU5z+GHwcic4TMVHeLPdaTnghqpbNF3NkjhY4xFrpnlFCRegh/9QMcy6crd
         5mpaCeDqVfmOhzfANGaLdG9bRgRWTUZESAqyZy20wjXzgje2vJMy/9cmp2hrzGGnLJjs
         NjUsB5Ilq2EIQk4Gj2xe1O0N4ONwpCBeXjXvCe2rWqillz7WdEzIQKM5P9Csoogzt/t8
         uuRBARiR4brH1nl6uybG8G39HMN434BaeVW0Y/xT9Hhkp+nlXLxFuAbauCxBUr2iFPH2
         WPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757956288; x=1758561088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Tl/RXGMAL1JqyStv0MTAwh9nUwRE5C//Qnl70T6OQM=;
        b=jAyzUnzcMPX2Ic6YLesUjgUdEy8roW1So5oasARKNAL5QhTTyhw8Azt9iOaB7wLfg8
         xydkdjjs1Xx9LI+7eA9Bx6cFzIU3Ywf1xCY/IwNOpdkYlh5g9zGa2uJGVDPzjgu3ZqS1
         TQUH6hZfoLxZVIzNTUDMpRrcsEvAvUA10sxRPPueGHY+NBJzVjuZU4fHyOVA7DvyuUUI
         hieG/S4po8jrEZEjH6CFfmNcZ1Eu2MHaWPFmibz0IOEr9C1zLKgBMNyf/gz1zWE24qls
         k0k+vfMEwikogMCVYa+k+IxCADXcDIoPOOZKdp0RWdwOt8TNirHattJ0+jzRntSRCtYI
         5oCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLY+PGD73NGYW6HCp00NdcXz5G9n+/N4VESpJ39cpx0yBjOxsHUAbNxwOgIAgqTDBpOXoUsno2k/MAD5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Wo862SIWVpbDphr4yMnoI872wZ2dWmXeHS12KlWCek0bJgJn
	YeDNnlksDdOEZb0z+Ch5j8lsXgTzQVZfEnuQNZNjYar47kaNBjcOHL4lJll4vsVguLA=
X-Gm-Gg: ASbGncuUVQSIBpSCqw/4pfLrq+SV9GzWBFLewnABlGNOcrJyz9zAqQQCqw+FDen5pPN
	SShXN+Fvw87outUHBZP6sJGCc6+Efg9jjiUXpZyEUi/HXC5kcnZPCDLgHWI/w8fzir2aMaUcUGZ
	ybnubVemtY0dLwhHFTSx3aUzoxRzkDm4uUy6jg3Bfy57KcRtzOsJ9RoGhHUz7ISiPaz2ns48InT
	b3hS9jziqjnzpEoOOIqHY/0H598WGiwLzT5lmHdmXkxp17xJftMNApEpglwnka8bch7ImFiNhSm
	P0KH9o8m0xNQYt3n2JYliAI1HN5ZUkYyr2o3ZqJ9WEzf1rsdH6FyLHz/oGKclnivHQMX/CGwfSf
	zmA5tj/GRPkcQtuQ9fL9Y1GxCA/Hl8UYu4A==
X-Google-Smtp-Source: AGHT+IEU141ppPHC0f43WV7Mu6b53qnsOKX1PToxTJqKeIfoSyv68wG7aiLv2qvPkXtSZcUgUGL70A==
X-Received: by 2002:a05:6402:2714:b0:62f:50ff:b675 with SMTP id 4fb4d7f45d1cf-62f50ffb8a6mr1585266a12.33.1757956288538;
        Mon, 15 Sep 2025 10:11:28 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62f11390075sm5158227a12.40.2025.09.15.10.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 10:11:28 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:11:27 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/10] mm/vmalloc: Avoid cond_resched() when blocking
 is not permitted
Message-ID: <aMhIv3HfRMyjlSec@tiehlicka>
References: <20250915134041.151462-1-urezki@gmail.com>
 <20250915134041.151462-5-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915134041.151462-5-urezki@gmail.com>

On Mon 15-09-25 15:40:34, Uladzislau Rezki wrote:
> vm_area_alloc_pages() contains the only voluntary reschedule points
> along vmalloc() allocation path. They are needed to ensure forward
> progress on PREEMPT_NONE kernels under contention for vmap metadata
> (e.g. alloc_vmap_area()).
> 
> However, yielding should only be done if the given GFP flags allow
> blocking. This patch avoids calling cond_resched() when allocation
> context is non-blocking(GFP_ATOMIC, GFP_NOWAIT).

We do have cond_resched in the page allocator path, right?
So unless I am missing something we can safely drope these. I thought we
have discused this already.

> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 49a0f81930a8..b77e8be75f10 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3633,7 +3633,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  							pages + nr_allocated);
>  
>  			nr_allocated += nr;
> -			cond_resched();
> +
> +			if (gfpflags_allow_blocking(gfp))
> +				cond_resched();
>  
>  			/*
>  			 * If zero or pages were obtained partly,
> @@ -3675,7 +3677,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  		for (i = 0; i < (1U << order); i++)
>  			pages[nr_allocated + i] = page + i;
>  
> -		cond_resched();
> +		if (gfpflags_allow_blocking(gfp))
> +			cond_resched();
> +
>  		nr_allocated += 1U << order;
>  	}
>  
> -- 
> 2.47.3

-- 
Michal Hocko
SUSE Labs

