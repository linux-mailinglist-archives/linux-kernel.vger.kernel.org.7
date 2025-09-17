Return-Path: <linux-kernel+bounces-821012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4BFB8008C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A6C5251A9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717132D836A;
	Wed, 17 Sep 2025 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQEqNcn0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239D2D46A4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119511; cv=none; b=KjiCCNWS+oX1UtYAdiqd+JZtRKYlKmNX+Z2DFVe20BSn0eCuhl8e/zQpBzVSWp67hAKwg4ZBrm4nqFyf+p4zkVayp6eYXqG1cVkiFP63WKTjiJvCR8AyGA4HJqH3yjVJaIVhkFFjh4dmAD9Zyabnlgy56cEMUzmtVTO7u4kCZi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119511; c=relaxed/simple;
	bh=k9cG3kz/ofV3MOY4tO3NxTa8C0lQ0KwhYvMThaTJklY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyvhNIW8LrQsqikfoCkp07jYViDbxa3jYmMqKI720MsuXVAIMv6SxgyoK1CnSonUdDa4KDsNbg2E8GnMdsoAipCT+2ENmJ5JnlV7ikKhnAitb0J1fzcl+aQH6hH5lWtXQWYv6rSGLWey13HaKAfGLqZFeRi7ty+96WT3FWaep+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQEqNcn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FADCC4CEF5;
	Wed, 17 Sep 2025 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758119511;
	bh=k9cG3kz/ofV3MOY4tO3NxTa8C0lQ0KwhYvMThaTJklY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQEqNcn0RVU/IcZMKtRGuPfTEkCa0ftTy/KsYvzMc3vySV8NIyQSfoyOOB2AZ0qf7
	 uvKDbh8G2D1egXCoXYyAkAROQqrV/L6uYZ7WwgHjGV6vU8XN/U2gdNN/81/ykgz74x
	 BKM5zcBdLMGa9+WaH5hvAylH3sHfMjkc4ahHvOAvCLfYgVwBPOFIVTbNicQsvWEIor
	 nkYqUQw2pr2C/CaUkc+/SWb3ZjvoyWXxJZ8jQhUlkTcGlL0mShtgbI6PzxxuQVbuiO
	 duNhZzx8ephb7lWkr8DQmTnrYbA5pTXGmjtpRlB4u3M1eBQqoK/0aWk+CWHFSahNCV
	 GweR5D4v6nbEA==
Date: Wed, 17 Sep 2025 17:31:43 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] kho: move sanity checks to kho_restore_page()
Message-ID: <aMrGT9IyHBFe5-nH@kernel.org>
References: <20250917125725.665-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917125725.665-1-pratyush@kernel.org>

On Wed, Sep 17, 2025 at 02:56:53PM +0200, Pratyush Yadav wrote:
> While KHO exposes folio as the primitive externally, internally its
> restoration machinery operates on pages. This can be seen with
> kho_restore_folio() for example. It performs some sanity checks and
> hands it over to kho_restore_page() to do the heavy lifting of page
> restoration. After the work done by kho_restore_page(),
> kho_restore_folio() only converts the head page to folio and returns it.
> Similarly, deserialize_bitmap() operates on the head page directly to
> store the order.
> 
> Move the sanity checks for valid phys and order from the public-facing
> kho_restore_folio() to the private-facing kho_restore_page(). This makes
> the boundary between page and folio clearer from KHO's perspective.
> 
> While at it, drop the comment above kho_restore_page(). The comment is
> misleading now. The function stopped looking like free_reserved_page()
> since 12b9a2c05d1b4 ("kho: initialize tail pages for higher order folios
> properly"), and now looks even more different.
> 
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> 
> Notes:
>     Changes in v2:
>     
>     - New in v2.
> 
>  kernel/kexec_handover.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index ecd1ac210dbd7..69cab82abaaef 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -183,10 +183,18 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
>  	return 0;
>  }
>  
> -/* almost as free_reserved_page(), just don't free the page */
> -static void kho_restore_page(struct page *page, unsigned int order)
> +static struct page *kho_restore_page(phys_addr_t phys)
>  {
> -	unsigned int nr_pages = (1 << order);
> +	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
> +	unsigned int nr_pages, order;
> +
> +	if (!page)
> +		return NULL;
> +
> +	order = page->private;
> +	if (order > MAX_PAGE_ORDER)
> +		return NULL;
> +	nr_pages = (1 << order);
>  
>  	/* Head page gets refcount of 1. */
>  	set_page_count(page, 1);
> @@ -199,6 +207,7 @@ static void kho_restore_page(struct page *page, unsigned int order)
>  		prep_compound_page(page, order);
>  
>  	adjust_managed_page_count(page, nr_pages);
> +	return page;
>  }
>  
>  /**
> @@ -209,18 +218,9 @@ static void kho_restore_page(struct page *page, unsigned int order)
>   */
>  struct folio *kho_restore_folio(phys_addr_t phys)
>  {
> -	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
> -	unsigned long order;
> -
> -	if (!page)
> -		return NULL;
> -
> -	order = page->private;
> -	if (order > MAX_PAGE_ORDER)
> -		return NULL;
> +	struct page *page = kho_restore_page(phys);
>  
> -	kho_restore_page(page, order);
> -	return page_folio(page);
> +	return page ? page_folio(page) : NULL;
>  }
>  EXPORT_SYMBOL_GPL(kho_restore_folio);
>  
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

