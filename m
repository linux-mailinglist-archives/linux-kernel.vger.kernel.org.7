Return-Path: <linux-kernel+bounces-821005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C88B8005F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5006E1889C66
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1B72D4B71;
	Wed, 17 Sep 2025 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRhST95e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F211225A29
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119267; cv=none; b=b10fAR9FSp7m1hkFvz4PC5dGgqjdmfFjNLFBeORY2fKNKcJmjGoFE3qhvOCc6drkvLWH66vA8SLWBE/zKFReTbH4GQ5H1dzo6wNvCOtnkfaUFkMHXwKaPIQqaoleVACkjRfiJJraFETOm4i/wl227mMKcLkMVNVjPer6PZfVxLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119267; c=relaxed/simple;
	bh=/EeIQi0ansmbb7h7cdFJIsa+CD2IvLgTaCfE6ZaIlxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDnOfokQTzkEveNzwUlY82uPundMet/dj6B8CMsSAKaT9zgeP7cHCMOwZag7JxUppGpeiTCujHzaMHWtTxtyXh2ccTbZjdkYxzboreNpUO1Uea507iOLEgo85oWVy3R7CxwagwEu9kCl/DTHKorSv/kI4A4oo32wcGqNVrH54+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRhST95e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF49C4CEE7;
	Wed, 17 Sep 2025 14:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758119267;
	bh=/EeIQi0ansmbb7h7cdFJIsa+CD2IvLgTaCfE6ZaIlxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VRhST95e6M0ImbIkRf5j2AWy3ejUWuNIjebo0Vt5MgW06Upoza4JsMhq27JsHn87h
	 yKsPubiKosrsh2UtkoE3UBwZpfyR0LGuOX7YdXCPVJpxq0Ob4OqZGNn08bkEjo1q+x
	 2gyHdVlX/zSQmvXVJs3gWIU59dKdulFyf3wG0CKQct2Ql/jg71r+KX3AK9noMREomn
	 2mDHcEa8IHiKzxJ0/hgs4GCC1spb4cBkSykP3thbZlneN5IaTzXevesTClml/8oRio
	 ntlD4I58un7kW10VNqX1FvWuV7OPi6imYkRWWiCDcupgRQ77X11nIAJ1OtVwacduZz
	 1K8D2iqyPVcew==
Date: Wed, 17 Sep 2025 17:27:40 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Alexander Potapenko <glider@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, vbabka@suse.cz,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, elver@google.com,
	dvyukov@google.com, kasan-dev@googlegroups.com,
	Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [PATCH v1] mm/memblock: Correct totalram_pages accounting with
 KMSAN
Message-ID: <aMrFXOTrlcgPhqjo@kernel.org>
References: <20250917123250.3597556-1-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917123250.3597556-1-glider@google.com>

On Wed, Sep 17, 2025 at 02:32:50PM +0200, Alexander Potapenko wrote:
> When KMSAN is enabled, `kmsan_memblock_free_pages()` can hold back pages
> for metadata instead of returning them to the early allocator. The callers,
> however, would unconditionally increment `totalram_pages`, assuming the
> pages were always freed. This resulted in an incorrect calculation of the
> total available RAM, causing the kernel to believe it had more memory than
> it actually did.
> 
> This patch refactors `memblock_free_pages()` to return the number of pages
> it successfully frees. If KMSAN stashes the pages, the function now
> returns 0; otherwise, it returns the number of pages in the block.
> 
> The callers in `memblock.c` have been updated to use this return value,
> ensuring that `totalram_pages` is incremented only by the number of pages
> actually returned to the allocator. This corrects the total RAM accounting
> when KMSAN is active.
> 
> Cc: Aleksandr Nogikh <nogikh@google.com>
> Fixes: 3c2065098260 ("init: kmsan: call KMSAN initialization routines")
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  mm/internal.h |  4 ++--
>  mm/memblock.c | 18 +++++++++---------
>  mm/mm_init.c  |  9 +++++----
>  3 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 45b725c3dc030..ae1ee6e02eff9 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -742,8 +742,8 @@ static inline void clear_zone_contiguous(struct zone *zone)
>  extern int __isolate_free_page(struct page *page, unsigned int order);
>  extern void __putback_isolated_page(struct page *page, unsigned int order,
>  				    int mt);
> -extern void memblock_free_pages(struct page *page, unsigned long pfn,
> -					unsigned int order);
> +extern unsigned long memblock_free_pages(struct page *page, unsigned long pfn,
> +					 unsigned int order);

No need for extern, the inconsistency is fine here.

>  extern void __free_pages_core(struct page *page, unsigned int order,
>  		enum meminit_context context);
>  
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 117d963e677c9..de7ff644d8f4f 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1834,10 +1834,9 @@ void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
>  	cursor = PFN_UP(base);
>  	end = PFN_DOWN(base + size);
>  
> -	for (; cursor < end; cursor++) {
> -		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
> -		totalram_pages_inc();
> -	}
> +	for (; cursor < end; cursor++)
> +		totalram_pages_add(
> +			memblock_free_pages(pfn_to_page(cursor), cursor, 0));
>  }
>  
>  /*
> @@ -2259,9 +2258,11 @@ static void __init free_unused_memmap(void)
>  #endif
>  }
>  
> -static void __init __free_pages_memory(unsigned long start, unsigned long end)
> +static unsigned long __init __free_pages_memory(unsigned long start,
> +						unsigned long end)
>  {
>  	int order;
> +	unsigned long freed = 0;
>  
>  	while (start < end) {
>  		/*
> @@ -2279,10 +2280,11 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
>  		while (start + (1UL << order) > end)
>  			order--;
>  
> -		memblock_free_pages(pfn_to_page(start), start, order);
> +		freed += memblock_free_pages(pfn_to_page(start), start, order);
>  
>  		start += (1UL << order);
>  	}
> +	return freed;
>  }
>  
>  static unsigned long __init __free_memory_core(phys_addr_t start,
> @@ -2297,9 +2299,7 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
>  	if (start_pfn >= end_pfn)
>  		return 0;
>  
> -	__free_pages_memory(start_pfn, end_pfn);
> -
> -	return end_pfn - start_pfn;
> +	return __free_pages_memory(start_pfn, end_pfn);
>  }
>  
>  static void __init memmap_init_reserved_pages(void)
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 5c21b3af216b2..9883612768511 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2548,24 +2548,25 @@ void *__init alloc_large_system_hash(const char *tablename,
>  	return table;
>  }
>  
> -void __init memblock_free_pages(struct page *page, unsigned long pfn,
> -							unsigned int order)
> +unsigned long __init memblock_free_pages(struct page *page, unsigned long pfn,
> +					 unsigned int order)

Please either align this with 'struct' or drop spaces and keep only tabs.

>  {
>  	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
>  		int nid = early_pfn_to_nid(pfn);
>  
>  		if (!early_page_initialised(pfn, nid))
> -			return;
> +			return 0;
>  	}
>  
>  	if (!kmsan_memblock_free_pages(page, order)) {
>  		/* KMSAN will take care of these pages. */
> -		return;
> +		return 0;
>  	}
>  
>  	/* pages were reserved and not allocated */
>  	clear_page_tag_ref(page);
>  	__free_pages_core(page, order, MEMINIT_EARLY);
> +	return 1UL << order;
>  }
>  
>  DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);

-- 
Sincerely yours,
Mike.

