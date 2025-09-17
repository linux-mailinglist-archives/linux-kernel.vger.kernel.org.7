Return-Path: <linux-kernel+bounces-821023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF82B8016A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260E5164ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1064D2F1FD5;
	Wed, 17 Sep 2025 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b90Md3nL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D042F3621
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119910; cv=none; b=s5m18015N2T98LSLtuQ5tiVHFIKBlvfQy6Jp45Vyag+35DWxDmmwrctWAWYt+kE+WlTfpzYp0M7rl261zrgPgeElZ2YleYvdAe/MnuKGTs8RsbGphGe/8720Np0gay3lYQzFuUV5ZL7aj/MW8tbQ7FafbBeAvqxyQWan15hG5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119910; c=relaxed/simple;
	bh=yXQMzE7u7vJaWF+q6evpHmh8mnMRx6jAmJ0dmD7uxfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvEJ4kfTqFRtNxArPnvLYxxERXHZV/maxV3ektQ5DMc3HAvDxOF2EhjTpS8NtSSuCs1I56WinppkJO0dwOcnPVNZJ04xDfQt1yb+INUwGA1HJ0BxS+OdrmQpII2Wpy/EfayqUvE9Boi5nW2QimyIelHTrht9dqH/tAXEy13cZUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b90Md3nL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340F6C4CEF0;
	Wed, 17 Sep 2025 14:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758119908;
	bh=yXQMzE7u7vJaWF+q6evpHmh8mnMRx6jAmJ0dmD7uxfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b90Md3nLg06AdbPclruBh+rd1NWg7t+FS3LkQzq4szbDX498eIhaNARcp+1IrXyOI
	 SPgHbuuasO4C+9du0cQTx7OacTI43kME4HB9h8Ap5XWux0egahlrtxkEdbW0TlE0Kq
	 ymMNXCwakoDrKnqAOojTA9u99vLlx+64aYCqUhoe+r/YBUu0RLyu5KOX1FTNB7q8f6
	 T5dbDZGR5I5mor4KLhpj1sj3oOEiBYDx3VYLmRDW29FaKFr5P2iyYc+0olaeHN9O0B
	 l7rvvwAAwdmiJ2Q8ET+ksGXNeOHg4FZvIMSlnMYivz3pNtil5U04nvjx8vfIxyFgD6
	 R3ASHM9Pp9hog==
Date: Wed, 17 Sep 2025 17:38:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] kho: make sure page being restored is actually
 from KHO
Message-ID: <aMrH3NQzFrmMbEd3@kernel.org>
References: <20250917125725.665-1-pratyush@kernel.org>
 <20250917125725.665-2-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917125725.665-2-pratyush@kernel.org>

On Wed, Sep 17, 2025 at 02:56:54PM +0200, Pratyush Yadav wrote:
> When restoring a page, no sanity checks are done to make sure the page
> actually came from a kexec handover. The caller is trusted to pass in
> the right address. If the caller has a bug and passes in a wrong
> address, an in-use page might be "restored" and returned, causing all
> sorts of memory corruption.
> 
> Harden the page restore logic by stashing in a magic number in
> page->private along with the order. If the magic number does not match,
> the page won't be touched. page->private is an unsigned long. The union
> kho_page_info splits it into two parts, with one holding the order and
> the other holding the magic number.
> 
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> 
> Notes:
>     Changes in v2:
>     
>     - Add a WARN_ON_ONCE() if order or magic is invalid.
>     - Add a comment explaining why the magic check also implicitly makes
>       sure phys is order-aligned.
>     - Clear page private to make sure later restores of the same page error
>       out.
>     - Move the checks to kho_restore_page() since patch 1 now moves sanity
>       checking to it.
> 
>  kernel/kexec_handover.c | 41 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 69cab82abaaef..911fda8532b2e 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -32,6 +32,22 @@
>  #define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
>  #define PROP_SUB_FDT "fdt"
>  
> +#define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
> +
> +/*
> + * KHO uses page->private, which is an unsigned long, to store page metadata.
> + * Use it to store both the magic and the order.
> + */
> +union kho_page_info {
> +	unsigned long page_private;
> +	struct {
> +		unsigned int order;
> +		unsigned int magic;
> +	};
> +};
> +
> +static_assert(sizeof(union kho_page_info) == sizeof(((struct page *)0)->private));
> +
>  static bool kho_enable __ro_after_init;
>  
>  bool kho_is_enabled(void)
> @@ -186,16 +202,24 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
>  static struct page *kho_restore_page(phys_addr_t phys)
>  {
>  	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
> -	unsigned int nr_pages, order;
> +	union kho_page_info info;
> +	unsigned int nr_pages;
>  
>  	if (!page)
>  		return NULL;
>  
> -	order = page->private;
> -	if (order > MAX_PAGE_ORDER)
> +	info.page_private = page->private;
> +	/*
> +	 * deserialize_bitmap() only sets the magic on the head page. This magic
> +	 * check also implicitly makes sure phys is order-aligned since for
> +	 * non-order-aligned phys addresses, magic will never be set.
> +	 */
> +	if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER))
>  		return NULL;
> -	nr_pages = (1 << order);
> +	nr_pages = (1 << info.order);
>  
> +	/* Clear private to make sure later restores on this page error out. */
> +	page->private = 0;
>  	/* Head page gets refcount of 1. */
>  	set_page_count(page, 1);
>  
> @@ -203,8 +227,8 @@ static struct page *kho_restore_page(phys_addr_t phys)
>  	for (unsigned int i = 1; i < nr_pages; i++)
>  		set_page_count(page + i, 0);
>  
> -	if (order > 0)
> -		prep_compound_page(page, order);
> +	if (info.order > 0)
> +		prep_compound_page(page, info.order);
>  
>  	adjust_managed_page_count(page, nr_pages);
>  	return page;
> @@ -341,10 +365,13 @@ static void __init deserialize_bitmap(unsigned int order,
>  		phys_addr_t phys =
>  			elm->phys_start + (bit << (order + PAGE_SHIFT));
>  		struct page *page = phys_to_page(phys);
> +		union kho_page_info info;
>  
>  		memblock_reserve(phys, sz);
>  		memblock_reserved_mark_noinit(phys, sz);
> -		page->private = order;
> +		info.magic = KHO_PAGE_MAGIC;
> +		info.order = order;
> +		page->private = info.page_private;
>  	}
>  }
>  
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

