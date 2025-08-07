Return-Path: <linux-kernel+bounces-759010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36075B1D70D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5ED63BCCAE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73117230BEC;
	Thu,  7 Aug 2025 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jf/xAkon"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE85BA36
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567666; cv=none; b=RU1GML7IPKvXDWwg4MYy0wxnpyFAin+cR32UFkOqyXa+NKD9BLoIrgbQmGgfi38XtpT5dJzkeBkoRbHgtEqdtX3XKCinyf5PD9wDgLUmlTcMIxK++l6TNYUXwHLm9WhSr71bpSuW18VpfCnmzSw+o6/9ynIbIwbAIH2GDUFgItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567666; c=relaxed/simple;
	bh=rvd91aGbINUDKnnu0Hxn+sJxVD+6+i32SNo3hrFUTkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPBUNrY0Jt1kxyBaoaYLfsqW87LB30l4WDvZcuPadz+2hRhvTZMptTGhpZOMy/DqBIa5sTWBrVBaa/G00d2j0thXOoBC7rnPPbMNb4lfWfrTvrJIGKuzUIP4AQSWkqHqL8kowkB2DKrRB66YcQqj2P7t8C0LjAkSSaPY0lNBj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jf/xAkon; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b78127c5d1so512866f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 04:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754567663; x=1755172463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BT4qexqfy5mbsc9gPProX37TwyBOeM3+/8lACE/SCU=;
        b=Jf/xAkonZtkoW2Cbeq+KHbU27wpJnNi7zOX5+sLlpQ/LfgtXTO68zjrs70b4meDFM9
         A2wky3dDDQJMkIKQCYuD9QFzqcYqqSbjaULSWlh5kJh+TbMZQk30XXqzfTQGhay8G5QK
         fklZZvGrx4UFq6EB6gxDoiqvfcd9UupjrN5OFRm6R8Xe4S91nhPChRn5Wm2ZMf+jOfPW
         TpqMZJPzkIXGj2d/EKH3inlcAkYDV4LTQcr2nufkIqHqTpGYY3cenXGqh5j9mUcwkFTd
         Z8Q+HI5Ffg0FvUST/ThPp6vH3EYkB1jWDf1p2qfbe4yjIZzVbfP0MGoPLxJlYOq3lL+h
         eLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754567663; x=1755172463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BT4qexqfy5mbsc9gPProX37TwyBOeM3+/8lACE/SCU=;
        b=gKE92YjiCVRNAEmlBzzH+Ln34zPDOgYprEvc+Wwy05N6pJqV28/wPT2lpaKuMZ2lSe
         h/atc+L+6LNH65kHrat8sxuPhBbjUtIvvgDAi4q5TdBTAD7keO6dG8r9JeWaKK45RT19
         7J+f+CzOwt2gAgkqE12MlrnxgL39W5QTDvJeXdAkUS6bxAkKGmif89EuKJDqzxu3jDPx
         MJNV5djSLvl3F5svFSqb48k/YGahZceA9L+TlphIWNo9vtpotG+vaoaZ7Ucu6a8Rf5b0
         7QDX0ydtYalM9G41/YhNMvqFusL3Vdr+FJH99gZnCjO1W5kg+Rc+UQPHQBnMzg+QLHMR
         xitA==
X-Forwarded-Encrypted: i=1; AJvYcCVCbLgIi6Ljui5yO70nhYASQXNoYPjaj/YOQrv3XNu3O+4iqwH6F6b1sFyip+s1jrW/8zp6YLwksu/stws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1OyCtzMUCqKMKEceLs+deG2Eq1fUSIHp0s3Z4BfLMZtc+L3NT
	asP8aayF8z+oLEyZw6WKmiedQljpqR/hah203HKRhJI4PQHK7nmxQMLd9mD6TVq4bZc=
X-Gm-Gg: ASbGncuo72R0KKe4btxftRksl8fh1l7cphavNaf0lSaJiV5h0uMNAkejNbIbSP9+ZI9
	uy99eREEcMIpctCgFWIbW7b6JDngiJPD36phkAu2koGaeMWXZAlkI/OwBQAJ932Bj3iz4Yt0jQ7
	288RU5txQMuUyYlEzHBhagRE5duRzwkLOi3KBp1uMgEpWfm/im9XkzGKqkCVbpT9vDn+JkQOg5Z
	y/9DK2CHX45aT6Pv68g9wHFrlCTby1cKRvzGghW2nfF8B4EbQaD8M0Ya4Np+edJnG3bj5Tr1UWh
	DVPytfKKOcudDSvRQQWmT6lFgic8ElsmmcVucQHK8DwAfVKHbT2D6vcFeXbYBrdaG9axrPQnLUL
	3xLXCC+J1g1G0ZgaJB3tTWCnGcO5Y+ViuYCE=
X-Google-Smtp-Source: AGHT+IELrwTrwViTNH3wEHxa9qVS2wjKSCcwBwiZ3gAW+4RTsHzlU0KgD+y4N/Jqi/C13eHcngcTqg==
X-Received: by 2002:a05:6000:3108:b0:3b8:d360:337f with SMTP id ffacd0b85a97d-3b8f420ec47mr5979837f8f.51.1754567662688;
        Thu, 07 Aug 2025 04:54:22 -0700 (PDT)
Received: from localhost (109-81-80-221.rct.o2.cz. [109.81.80.221])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459c58ed07fsm186745745e9.22.2025.08.07.04.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:54:22 -0700 (PDT)
Date: Thu, 7 Aug 2025 13:54:21 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] mm/vmalloc: Support non-blocking GFP flags in
 __vmalloc_area_node()
Message-ID: <aJST7TnermwROX41@tiehlicka>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-8-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807075810.358714-8-urezki@gmail.com>

On Thu 07-08-25 09:58:09, Uladzislau Rezki wrote:
> This patch makes __vmalloc_area_node() to correctly handle non-blocking
> allocation requests, such as GFP_ATOMIC and GFP_NOWAIT. Main changes:
> 
> - Add a __GFP_HIGHMEM to gfp_mask only for blocking requests
>   if there are no DMA constraints.

This begs for a more explanation. Why does __GFP_HIGHMEM matters? I
suspect this is due to kmapping of those pages but that could be done in
an atomic way. But in practice I do not think we really care about
highmem all that much for vmalloc. The vmalloc space is really tiny for
32b systems where highmem matters and failing vmalloc allocations due to
lack is of __GFP_HIGHMEM is hard to consider important if relevant at
all.

> - vmap_page_range() is wrapped by memalloc_noreclaim_save/restore()
>   to avoid memory reclaim related operations that could sleep during
>   page table setup or mapping pages.
> 
> This is particularly important for page table allocations that
> internally use GFP_PGTABLE_KERNEL, which may sleep unless such
> scope restrictions are applied. For example:
> 
> <snip>
> __pte_alloc_kernel()
>     pte_alloc_one_kernel(&init_mm);
>         pagetable_alloc_noprof(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM, 0);
> <snip>

As I've said in several occations, I am not entirely happy about this
approach because it doesn't really guarantee atomicty. If any
architecture decides to use some sleeping locking down that path then
the whole thing just blows up. On the other hand this is mostly a
theoretical concern at this stage and this is a feature people have
been asking for a long time (especially from kvmalloc side) so better
good than perfect that his.

That being said, you are missing __kvmalloc_node_noprof,
__vmalloc_node_range_noprof (and maybe some more places) documentation
update.

> Note: in most cases, PTE entries are established only up to the level
> required by current vmap space usage, meaning the page tables are typically
> fully populated during the mapping process.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

With the doc part fixed
Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/vmalloc.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 2424f80d524a..8a7eab810561 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3721,12 +3721,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
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
> +		/* __GFP_NOFAIL and "noblock" flags are mutually exclusive. */
> +		nofail = false;
> +	} else {
> +		/* Allow highmem allocations if there are no DMA constraints. */
> +		if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
> +			gfp_mask |= __GFP_HIGHMEM;
> +	}
>  
>  	/* Please note that the recursion is strictly bounded. */
>  	if (array_size > PAGE_SIZE) {
> @@ -3790,7 +3798,9 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	 * page tables allocations ignore external gfp mask, enforce it
>  	 * by the scope API
>  	 */
> -	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> +	if (noblock)
> +		flags = memalloc_noreclaim_save();
> +	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
>  		flags = memalloc_nofs_save();
>  	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
>  		flags = memalloc_noio_save();
> @@ -3802,7 +3812,9 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  			schedule_timeout_uninterruptible(1);
>  	} while (nofail && (ret < 0));
>  
> -	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> +	if (noblock)
> +		memalloc_noreclaim_restore(flags);
> +	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
>  		memalloc_nofs_restore(flags);
>  	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
>  		memalloc_noio_restore(flags);
> -- 
> 2.39.5
> 

-- 
Michal Hocko
SUSE Labs

