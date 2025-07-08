Return-Path: <linux-kernel+bounces-721928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF12AFCF96
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344991BC7DE2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65F22E172F;
	Tue,  8 Jul 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LdzagvPj"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DA82DEA67
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989648; cv=none; b=HNu0CPFkQ71jfAO7+vx2Cz8M00CujZvQLldSpZ40QQos0iYpKo5W4Wy+y2vkpGtVXxGvYHfoCya5cSwv7BVUPbNXtd1pJXuDq4Vn1CWpKdazB2qll801LgJalAsqzscdprDthpwzubAXeObs03U+i0JFedMJvUVj8cXKkr3NWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989648; c=relaxed/simple;
	bh=2ibVBinwKG+HfOhanwQz7iMTyYNpM1EQ9sj7JYyXejY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRM0aOvvWWDNEia8aP96yiYTNWrgL17hJ1ac4+sKUtAvim6qJAhG1htXDMErubJevq27jrCQig2khb4iTCBnjKzB9UBACz0I7zrJQKtj+JbiH1IRQ+UJEnZGgpciDmMahu1EOpq0sfEEkiK83mB9cUOO0/J/XH6WaTR3NAXzMHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LdzagvPj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso49123145e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751989644; x=1752594444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KDL7RR2TbvEX2mJHggUryr42QulPV6Bkphf4Js6vNb4=;
        b=LdzagvPjMMLNdNKhFAMdKZQ0+sBYrKomxPPHE6cr9TFoBbFmNLjpwz3nizZ3PQMakN
         0Cp5c6cfXusmUhH5XfJpR93cnJu5viZlhe6PRaS0RhAA5ER1IbtUNMS4GKu4WVnLgWN9
         Syq1+K1T2DFzi8Y+w2fYdShcM6SQ+LK18/7v546ECwqM+SRauRQrbL7BZVTvq9LIJrpV
         2ISbysgVRKOX+M0HHeNqOoeyIFZ0Wvg9D8KJyv3ot9wVGJb3UnNCnfNx1RcREB1uMuy0
         JmEs/OE1t+8p4JajuEgvZpQnTlN4qmSDY6lPj1YKdmAn9hWu7IDKqa3rWIeD3OAD7LIp
         Qmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751989644; x=1752594444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDL7RR2TbvEX2mJHggUryr42QulPV6Bkphf4Js6vNb4=;
        b=rbQbGYfVxcP/AA626IDEvw1NPngJ93AyebEQYZ6IHVp46qVhnrnG7EK9sSveUtF9L2
         gObtN2OrQBwO7cCuv/KuB5u0mxRPmAe0BTtWmcWBRjPdmn2M51ug8o6OsPclTrAPNlss
         fQE5L63f/3oy5tLD13Nom/es4y3vdjzGu9v1Q3rajXWXCpZyVpvlAKmTNXj8T/h3c3Rt
         BnXOxhIlhddZDlU43AOLimWz235f+8FSHDlB5LbkI8kvb0wdtZy1zHEeUw28Qf+G709C
         o7A4rknlJ5r+Xp3jpOQ7qE5pa5Lmt6WalMVjHBi82/xCy8qE6OU8N7ZV7yjdMe/Z0O5f
         U+yg==
X-Forwarded-Encrypted: i=1; AJvYcCVWLTWIKfUWoHF6KdU5iMAsKbcRZKo06oNRJWYOjAgzHbmkWGxyS4j3rbOa3MDgyiZDHxF+WmAPEaEgBbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr5KT6NIcOznNgsbZbBbwwKwm5fP55/9fdjcYZyq7FSMgOtbMA
	KiXOiRh64OfmYH5SWnoEDfAAt85kjSxAKXUSW1vHgYKW3h6S3ZGi9iIE9t3ScCRmShc=
X-Gm-Gg: ASbGncspTvhWaWJgRflqoRxSE86V/CkqmGlQcTNnlDwwhyp7LGNgXRLal4x7M8OE6k7
	P+HWYB9ZT/V6Uf16PP3wld+7VLzY4bR1P4AJX9Sph2POycdRZ0MbQb8jjlmTnXqrFZ5pz6oXwfc
	8dfnFyhZh0rDdCJB7IRofDvvtk2LLo1k8s4rKIjQ8oHDO/p8z50H6scMo6yfnJoD5llu8NYeoum
	RkPPBb7Mo+g8/tN0j9sqkhBjw9rP1umPZCOWALFFC4FzPzAgysyk0o3ctSzrJ13FC1YaivMJMFi
	GTAT7cZXDx6nRLqQsZfTkbST/UCC6383lECvhktbK+RreAZaVBYpaLwkaublYwE20LQ/T7pwQHQ
	=
X-Google-Smtp-Source: AGHT+IHX8KpFEImVvtc79+YaRCiWXT+RTSp4DWGywBuxO2GfgOkMoYd7/TDZb/9ReafohN/p1bzf0g==
X-Received: by 2002:a05:600c:3b84:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-454d3623459mr1627035e9.4.1751989643697;
        Tue, 08 Jul 2025 08:47:23 -0700 (PDT)
Received: from localhost (109-81-17-167.rct.o2.cz. [109.81.17.167])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b4708d0beesm13495616f8f.36.2025.07.08.08.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:47:23 -0700 (PDT)
Date: Tue, 8 Jul 2025 17:47:21 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>
Subject: Re: [RFC 6/7] mm/vmalloc: Support non-blocking GFP flags in
 __vmalloc_area_node()
Message-ID: <aG09iVrHBPYPkp-Y@tiehlicka>
References: <20250704152537.55724-1-urezki@gmail.com>
 <20250704152537.55724-7-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704152537.55724-7-urezki@gmail.com>

On Fri 04-07-25 17:25:36, Uladzislau Rezki wrote:
> This patch makes __vmalloc_area_node() to correctly handle non-blocking
> allocation requests, such as GFP_ATOMIC and GFP_NOWAIT. Main changes:
> 
> - nested_gfp flag follows the same non-blocking constraints
>   as the primary gfp_mask, ensuring consistency and avoiding
>   sleeping allocations in atomic contexts.
> 
> - if blocking is not allowed, __GFP_NOFAIL is forcibly cleared
>   and warning is issued if it was set, since __GFP_NOFAIL is
>   incompatible with non-blocking contexts;
> 
> - Add a __GFP_HIGHMEM to gfp_mask only for blocking requests
>   if there are no DMA constraints.
> 
> - in non-blocking mode we use memalloc_noreclaim_save/restore()
>   to prevent reclaim related operations that may sleep while
>   setting up page tables or mapping pages.
> 
> This is particularly important for page table allocations that
> internally use GFP_PGTABLE_KERNEL, which may sleep unless such
> scope restrictions are applied. For example:
> 
> <snip>
>     #define GFP_PGTABLE_KERNEL (GFP_KERNEL | __GFP_ZERO)
> 
>     __pte_alloc_kernel()
>         pte_alloc_one_kernel(&init_mm);
>             pagetable_alloc_noprof(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM, 0);
> <snip>
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 2eaff0575a9e..fe1699e01e02 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3711,7 +3711,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  				 pgprot_t prot, unsigned int page_shift,
>  				 int node)
>  {
> -	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
> +	gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
>  	bool nofail = gfp_mask & __GFP_NOFAIL;
>  	unsigned long addr = (unsigned long)area->addr;
>  	unsigned long size = get_vm_area_size(area);
> @@ -3719,12 +3719,28 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	unsigned int nr_small_pages = size >> PAGE_SHIFT;
>  	unsigned int page_order;
>  	unsigned int flags;
> +	bool noblock;
>  	int ret;
>  
>  	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
> +	noblock = !gfpflags_allow_blocking(gfp_mask);
>  
> -	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
> -		gfp_mask |= __GFP_HIGHMEM;
> +	if (noblock) {
> +		/* __GFP_NOFAIL is incompatible with non-blocking contexts. */
> +		WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL);
> +		gfp_mask &= ~__GFP_NOFAIL;

Btw. we already ignore GFP_NOFAIL for atomic allocations and warn about
that at the page allocator level (__alloc_pages_slowpath)

What we can do though is to add a pr_warn + dump_stack for request with
size that would require (in the worst case) page tables allocation
larger than a portion of min_free_kbytes (to scale with different memory
sizes). That should be plenty for any reasonable non blocking vmalloc.
We would have means to catch abusers in that way.

-- 
Michal Hocko
SUSE Labs

