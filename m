Return-Path: <linux-kernel+bounces-822556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A44BB8420B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC70480430
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CA428643D;
	Thu, 18 Sep 2025 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smkYQj59"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90A623B62C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191531; cv=none; b=t7y4DlihLEAQ+hhomWUIRR+he+Gje9HZ7ALXagg+Ka7MxM+OjtHTHHSZ7WIiQ3pZzHSpruBrUNzdmyNLn75r7YLrFyEYEZNBGFAa4Aj29xtvQ4tOcUz5SWrU++r/R2ZRJ7eoNDifT3KTM+9jIuV56VJI6TTBx/ZxGkho+e5n3oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191531; c=relaxed/simple;
	bh=yy2/qGmH2QA2swtXgVVOAHnOxEMhRZ0NhObdYrFdpP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WPXD1h5rQt3zyynLG6Q0mx1w1Lv/ebbP2eQbwAJMPkJGFvuOGO+7f0wDeeco2pKeg/7rbvyhBVvbPvbvlYgkmZ3jUOu8p/HPdUlBCYMBGlOIfvAX0CWMOYl2m56gwU5lpnU2HHz3r+mY+1cIsaGkgj2qvrVfU5xssuGDQEbZj1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smkYQj59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772E8C4CEFC;
	Thu, 18 Sep 2025 10:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191531;
	bh=yy2/qGmH2QA2swtXgVVOAHnOxEMhRZ0NhObdYrFdpP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=smkYQj59cJEB2MBpLMWEo/hAvXX7jkJTDCXOe2YP6B8kjmfCFAlaw29s3ux/BKgAB
	 BN87ihWMAGN0M8GH5XkkXR5gSQpGbFfOkSdZVWemcu7XAPnuioH89tfzj4ndhqDfRM
	 mrfhGj0JEG72SS2jkPZ4pVFACZ4hfclVKHHxc6f/4ESFCWacU7MYgbI6XOZ/g6HCZ9
	 Vmq73d/+GCK2p37SXDMw+YFGDctVpPmeikPcp/k3Um83y5bPqrAZTTxnAGCeF2lpS7
	 zLE1C7TdB7kXGrUvzq9wunjrmFRxhcoyiGYcu2Ij8YlqqHofGS5VPp0T5kp9hz09v+
	 KWqav/GLcplpA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] kho: replace kho_preserve_phys() with
 kho_preserve_pages()
In-Reply-To: <20250917174033.3810435-3-rppt@kernel.org>
References: <20250917174033.3810435-1-rppt@kernel.org>
	<20250917174033.3810435-3-rppt@kernel.org>
Date: Thu, 18 Sep 2025 12:32:08 +0200
Message-ID: <mafs05xdggifr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Mike,

On Wed, Sep 17 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> to make it clear that KHO operates on pages rather than on a random
> physical address.
>
> The kho_preserve_pages() will be also used in upcoming support for
> vmalloc preservation.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  include/linux/kexec_handover.h |  5 +++--
>  kernel/kexec_handover.c        | 25 +++++++++++--------------
>  mm/memblock.c                  |  4 +++-
>  3 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index 348844cffb13..cc5c49b0612b 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -18,6 +18,7 @@ enum kho_event {
>  
>  struct folio;
>  struct notifier_block;
> +struct page;
>  
>  #define DECLARE_KHOSER_PTR(name, type) \
>  	union {                        \
> @@ -42,7 +43,7 @@ struct kho_serialization;
>  bool kho_is_enabled(void);
>  
>  int kho_preserve_folio(struct folio *folio);
> -int kho_preserve_phys(phys_addr_t phys, size_t size);
> +int kho_preserve_pages(struct page *page, unsigned int nr_pages);
>  struct folio *kho_restore_folio(phys_addr_t phys);
>  int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
>  int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
> @@ -65,7 +66,7 @@ static inline int kho_preserve_folio(struct folio *folio)
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline int kho_preserve_phys(phys_addr_t phys, size_t size)
> +static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
>  {
>  	return -EOPNOTSUPP;
>  }
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index f421acc58c1f..3ad59c5f9eaa 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -698,26 +698,23 @@ int kho_preserve_folio(struct folio *folio)
>  EXPORT_SYMBOL_GPL(kho_preserve_folio);
>  
>  /**
> - * kho_preserve_phys - preserve a physically contiguous range across kexec.
> - * @phys: physical address of the range.
> - * @size: size of the range.
> + * kho_preserve_pages - preserve contiguous pages across kexec
> + * @page: first page in the list.
> + * @nr_pages: number of pages.
>   *
> - * Instructs KHO to preserve the memory range from @phys to @phys + @size
> - * across kexec.
> + * Preserve a contiguous list of order 0 pages. Must be restored using
> + * kho_restore_page() on each order 0 page.

This is not true. The pages are preserved with the maximum order
possible.

	while (pfn < end_pfn) {
		const unsigned int order =
			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));

		err = __kho_preserve_order(track, pfn, order);
		[...]

So four 0-order pages will be preserved as one 2-order page. Restoring
them as four 0-order pages is wrong. And my proposed patch for checking
the magic [0] will uncover this exact bug.

I think you should either change the logic to always preserve at order
0, or maybe add a kho_restore_pages() that replicates the same order
calculation.

[0] https://lore.kernel.org/lkml/20250917125725.665-2-pratyush@kernel.org/

>   *
>   * Return: 0 on success, error code on failure
>   */
> -int kho_preserve_phys(phys_addr_t phys, size_t size)
> +int kho_preserve_pages(struct page *page, unsigned int nr_pages)
>  {
> -	unsigned long pfn = PHYS_PFN(phys);
> +	struct kho_mem_track *track = &kho_out.ser.track;
> +	const unsigned long start_pfn = page_to_pfn(page);
> +	const unsigned long end_pfn = start_pfn + nr_pages;
> +	unsigned long pfn = start_pfn;
>  	unsigned long failed_pfn = 0;
> -	const unsigned long start_pfn = pfn;
> -	const unsigned long end_pfn = PHYS_PFN(phys + size);
>  	int err = 0;
> -	struct kho_mem_track *track = &kho_out.ser.track;
> -
> -	if (!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size))
> -		return -EINVAL;
>  
>  	while (pfn < end_pfn) {
>  		const unsigned int order =
> @@ -737,7 +734,7 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
>  
>  	return err;
>  }
> -EXPORT_SYMBOL_GPL(kho_preserve_phys);
> +EXPORT_SYMBOL_GPL(kho_preserve_pages);
>  
>  /* Handling for debug/kho/out */
>  
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 117d963e677c..6ec3eaa4e8d1 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2516,8 +2516,10 @@ static int reserve_mem_kho_finalize(struct kho_serialization *ser)
>  
>  	for (i = 0; i < reserved_mem_count; i++) {
>  		struct reserve_mem_table *map = &reserved_mem_table[i];
> +		struct page *page = phys_to_page(map->start);
> +		unsigned int nr_pages = map->size >> PAGE_SHIFT;
>  
> -		err |= kho_preserve_phys(map->start, map->size);
> +		err |= kho_preserve_pages(page, nr_pages);

Unrelated to this patch, but since there is no
kho_restore_{phys,pages}(), won't the reserve_mem memory end up with
uninitialized struct pages, since preserved pages are
memblock_reserved_mark_noinit()?

That would also be a case for kho_restore_pages() I suppose?

-- 
Regards,
Pratyush Yadav

