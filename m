Return-Path: <linux-kernel+bounces-787631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8C7B378E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3E17C210F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D098309DDC;
	Wed, 27 Aug 2025 03:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W08j5Jq4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050A330CDA0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266763; cv=none; b=RpUya8Mb55rLs5M7CMWziG+8XIgdNd6CubmEqYeRa7miHW5s4z0Inuo75L1lfwLcksZJGdZgsDn84zYuE0NEkV/cf7ypwPNcpv8D705EfyWkZGPuMXGouF1uzojGiuz/t9ifa1EzRHx26NPMk/Tz7/M4wXlVOjdMHUDvxjZE07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266763; c=relaxed/simple;
	bh=ZCSmCHHCWA7zqVYYTgdFOuVi0izDB7p5KH4fBzNM8vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRyV072GpyHjJbmJNKRwRrHdguLza7h22JTw4Wd5sOOGlC/NLvb/wZeSLqFmR3vtNdhNmLSIy35d1zIrsMXTgL+PhInDDNA5IBY/zdI3gVkqNtn35072q2ort9flqYvaN/ZiB4cPikNXfdoeYsze13xYn4lKoRJI/qnyRQmJSkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W08j5Jq4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756266760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sv1GyWM+sC/GNWSw17NBq91CsCOpfd89bfoVZTZKtAY=;
	b=W08j5Jq4vgfE2UsCKhUNWrGfMV8sRzEpYGlD3YFlCH9+tkjw6x5t0PmukuW1EjBK0petN7
	AAk3jSKrpq5gFs+s70V0dtF1zFSoA+swq4g+7tcKt/pgBM3Xj/t/lamU/2N1UWYaeqMmF6
	GALQm/6pL5qC+s5PEbtsaOLhJT95s5M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-LFAt1coCM56G21_qlnRySQ-1; Tue,
 26 Aug 2025 23:52:35 -0400
X-MC-Unique: LFAt1coCM56G21_qlnRySQ-1
X-Mimecast-MFC-AGG-ID: LFAt1coCM56G21_qlnRySQ_1756266753
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1CC019560B2;
	Wed, 27 Aug 2025 03:52:32 +0000 (UTC)
Received: from localhost (unknown [10.72.112.154])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40574180047F;
	Wed, 27 Aug 2025 03:52:29 +0000 (UTC)
Date: Wed, 27 Aug 2025 11:52:15 +0800
From: Baoquan He <bhe@redhat.com>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] mm, swap: use unified helper for swap cache look up
Message-ID: <aK6A76NVcV2j+J57@MiWiFi-R3L-srv>
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-2-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822192023.13477-2-ryncsn@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/23/25 at 03:20am, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
......snip...
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 99513b74b5d8..ff9eb761a103 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -69,6 +69,21 @@ void show_swap_cache_info(void)
>  	printk("Total swap = %lukB\n", K(total_swap_pages));
>  }
>  
> +/*
> + * Lookup a swap entry in the swap cache. A found folio will be returned

Lookup is a noun, we should use 'look up' which is a verb here instead?

And all other places in swap code, even though they are not introduced
by this patchset. Just a nitpick.

> + * unlocked and with its refcount incremented.
> + *
> + * Caller must lock the swap device or hold a reference to keep it valid.
> + */
> +struct folio *swap_cache_get_folio(swp_entry_t entry)
> +{
> +	struct folio *folio = filemap_get_folio(swap_address_space(entry),
> +						swap_cache_index(entry));
> +	if (!IS_ERR(folio))
> +		return folio;
> +	return NULL;
> +}
> +
>  void *get_shadow_from_swap_cache(swp_entry_t entry)
>  {
>  	struct address_space *address_space = swap_address_space(entry);
> @@ -273,54 +288,40 @@ static inline bool swap_use_vma_readahead(void)
>  }
>  
>  /*
> - * Lookup a swap entry in the swap cache. A found folio will be returned
> - * unlocked and with its refcount incremented - we rely on the kernel
> - * lock getting page table operations atomic even if we drop the folio
> - * lock before returning.
> - *
> - * Caller must lock the swap device or hold a reference to keep it valid.
> + * Update the readahead statistics of a vma or globally.
>   */
> -struct folio *swap_cache_get_folio(swp_entry_t entry,
> -		struct vm_area_struct *vma, unsigned long addr)
> +void swap_update_readahead(struct folio *folio,
> +			   struct vm_area_struct *vma,
> +			   unsigned long addr)
>  {
> -	struct folio *folio;
> -
> -	folio = filemap_get_folio(swap_address_space(entry), swap_cache_index(entry));
> -	if (!IS_ERR(folio)) {
> -		bool vma_ra = swap_use_vma_readahead();
> -		bool readahead;
> +	bool readahead, vma_ra = swap_use_vma_readahead();
>  
> -		/*
> -		 * At the moment, we don't support PG_readahead for anon THP
> -		 * so let's bail out rather than confusing the readahead stat.
> -		 */
> -		if (unlikely(folio_test_large(folio)))
> -			return folio;
> -
> -		readahead = folio_test_clear_readahead(folio);
> -		if (vma && vma_ra) {
> -			unsigned long ra_val;
> -			int win, hits;
> -
> -			ra_val = GET_SWAP_RA_VAL(vma);
> -			win = SWAP_RA_WIN(ra_val);
> -			hits = SWAP_RA_HITS(ra_val);
> -			if (readahead)
> -				hits = min_t(int, hits + 1, SWAP_RA_HITS_MAX);
> -			atomic_long_set(&vma->swap_readahead_info,
> -					SWAP_RA_VAL(addr, win, hits));
> -		}
> -
> -		if (readahead) {
> -			count_vm_event(SWAP_RA_HIT);
> -			if (!vma || !vma_ra)
> -				atomic_inc(&swapin_readahead_hits);
> -		}
> -	} else {
> -		folio = NULL;
> +	/*
> +	 * At the moment, we don't support PG_readahead for anon THP
> +	 * so let's bail out rather than confusing the readahead stat.
> +	 */
> +	if (unlikely(folio_test_large(folio)))
> +		return;
> +
> +	readahead = folio_test_clear_readahead(folio);
> +	if (vma && vma_ra) {
> +		unsigned long ra_val;
> +		int win, hits;
> +
> +		ra_val = GET_SWAP_RA_VAL(vma);
> +		win = SWAP_RA_WIN(ra_val);
> +		hits = SWAP_RA_HITS(ra_val);
> +		if (readahead)
> +			hits = min_t(int, hits + 1, SWAP_RA_HITS_MAX);
> +		atomic_long_set(&vma->swap_readahead_info,
> +				SWAP_RA_VAL(addr, win, hits));
>  	}
>  
> -	return folio;
> +	if (readahead) {
> +		count_vm_event(SWAP_RA_HIT);
> +		if (!vma || !vma_ra)
> +			atomic_inc(&swapin_readahead_hits);
> +	}
>  }
>  
>  struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
> @@ -336,14 +337,10 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  	*new_page_allocated = false;
>  	for (;;) {
>  		int err;
> -		/*
> -		 * First check the swap cache.  Since this is normally
> -		 * called after swap_cache_get_folio() failed, re-calling
> -		 * that would confuse statistics.
> -		 */
> -		folio = filemap_get_folio(swap_address_space(entry),
> -					  swap_cache_index(entry));
> -		if (!IS_ERR(folio))
> +
> +		/* Check the swap cache in case the folio is already there */
> +		folio = swap_cache_get_folio(entry);
> +		if (folio)
>  			goto got_folio;
>  
>  		/*
......


