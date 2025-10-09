Return-Path: <linux-kernel+bounces-847369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C22C1BCAA89
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82F224E59BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896A32561B9;
	Thu,  9 Oct 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuQKWRfz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6702B9B7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 19:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037113; cv=none; b=e7MLZUtiieDx+I4s4E5kb37lNwFN7hOdnITLLVEv/sKzG+kLIBTPNmYHYoLJvA5SAN9YeTx+tstK/JlEoFZ/n0S/2He81HDP+74mhGBu0T4i/LrFjcLaIZ+5KqYxQZAanO98x8p5zMDyPOieub2w4v7xed+hyCNx7gFDkD4sQgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037113; c=relaxed/simple;
	bh=6DwPMa+Wql2BSz1ZhMVyoJpuMWrdGiCDNvWyDRowITo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PkdfiNbi2sfrMwCTQ+dPxebosAeSKxtqs3cpYHYAbvWW1ZHll9IaNq95F7KuYSCyGWAZfaMJhOAEbiwyrVvsFpe/sK8U1NnOMnU4fnhep9UFiqe6fV/8zLsOVmCL4eRkUTH0I7jbUS6aZEXU2vfvG7jG59RAUUcgx9xRt5TdvkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuQKWRfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D44C4CEE7;
	Thu,  9 Oct 2025 19:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760037113;
	bh=6DwPMa+Wql2BSz1ZhMVyoJpuMWrdGiCDNvWyDRowITo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NuQKWRfzxA6IS/MRDXbYxHjq+bGfXpIWBY8+7wLZeZ8FOFcDXG34cW7gWwjmX3k7j
	 GjZHs1x588d+C2H2iIT7mwhrsTHJfWd+IUj1XRTlFBtmFxP5sWLq6KfchIgWRNRC1e
	 SMI/GrGb4Sm3EhB+ZEsIK3EUvOI2h/+z5rPgL3bFB3dYv54tcaEdCWvhfkL6mXHAeA
	 R3YKDadCNsIQ/1aq98CE2GPEuG71IZjhBKbta5KB/JlKwrxExMq+hY0ddTs5m6Br4k
	 lAFdyzym8bbKXxmEHjHs1N/1zDIzyycI8hDQfObUHCKxZubqPTI8g78N2DaqMvD9m5
	 W22CHEnOvITZQ==
From: SeongJae Park <sj@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	kas@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] mm/hugetlb: create hstate_is_gigantic_no_runtime helper
Date: Thu,  9 Oct 2025 12:11:49 -0700
Message-Id: <20251009191149.57652-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009172433.4158118-1-usamaarif642@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Usama,

On Thu,  9 Oct 2025 18:24:30 +0100 Usama Arif <usamaarif642@gmail.com> wrote:

> This is a common condition used to skip operations that cannot
> be performed on gigantic pages when runtime support is disabled.
> This helper is introduced as the condition will exist even more
> when allowing "overcommit" of gigantic hugepages.
> No functional change intended with this patch.

The change looks good to me.  I have a couple of trivial comments below.

> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---

I think adding a change log since v1 here, or adding a cover letter with it
would be nice.

>  mm/hugetlb.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c07b7192aff26..e74e41386b100 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -134,6 +134,17 @@ static void hugetlb_free_folio(struct folio *folio)
>  	folio_put(folio);
>  }
>  
> +/*
> + * Check if the hstate represents gigantic pages but gigantic page
> + * runtime support is not available. This is a common condition used to
> + * skip operations that cannot be performed on gigantic pages when runtime
> + * support is disabled.
> + */
> +static inline bool hstate_is_gigantic_no_runtime(struct hstate *h)
> +{
> +	return hstate_is_gigantic(h) && !gigantic_page_runtime_supported();
> +}
> +
>  static inline bool subpool_is_free(struct hugepage_subpool *spool)
>  {
>  	if (spool->count)
> @@ -1555,7 +1566,7 @@ static void remove_hugetlb_folio(struct hstate *h, struct folio *folio,
>  	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio_rsvd(folio), folio);
>  
>  	lockdep_assert_held(&hugetlb_lock);
> -	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> +	if (hstate_is_gigantic_no_runtime(h))
>  		return;
>  
>  	list_del(&folio->lru);
> @@ -1617,7 +1628,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>  {
>  	bool clear_flag = folio_test_hugetlb_vmemmap_optimized(folio);
>  
> -	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> +	if (hstate_is_gigantic_no_runtime(h))
>  		return;
>  
>  	/*
> @@ -2511,7 +2522,7 @@ static void return_unused_surplus_pages(struct hstate *h,
>  	/* Uncommit the reservation */
>  	h->resv_huge_pages -= unused_resv_pages;
>  
> -	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> +	if (hstate_is_gigantic_no_runtime(h))
>  		goto out;
>  
>  	/*
> @@ -3725,7 +3736,7 @@ static void __init hugetlb_init_hstates(void)
>  		 * - If CMA allocation is possible, we can not demote
>  		 *   HUGETLB_PAGE_ORDER or smaller size pages.
>  		 */
> -		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> +		if (hstate_is_gigantic_no_runtime(h))
>  			continue;
>  		if (hugetlb_cma_total_size() && h->order <= HUGETLB_PAGE_ORDER)
>  			continue;
> @@ -4202,7 +4213,7 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>  	int err;
>  	nodemask_t nodes_allowed, *n_mask;
>  
> -	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> +	if (hstate_is_gigantic_no_runtime(h))
>  		return -EINVAL;
>  
>  	if (nid == NUMA_NO_NODE) {
> -- 
> 2.47.3

It seems the new helper could be used for three more cases.

On mm-new:

    $ git grep gigantic_page_runtime_supported mm/hugetlb.c
    mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
    mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
    mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
    mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
    mm/hugetlb.c:           if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
    mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
    mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
    mm/hugetlb.c:   if (write && hstate_is_gigantic(h) && !gigantic_page_runtime_supported())

After applying this patch on top of mm-new:

    $ git grep gigantic_page_runtime_supported mm/hugetlb.c
    mm/hugetlb.c:   return hstate_is_gigantic(h) && !gigantic_page_runtime_supported();
    mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
    mm/hugetlb.c:   if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
    mm/hugetlb.c:   if (write && hstate_is_gigantic(h) && !gigantic_page_runtime_supported())

I'm curious if you are planning to do the conversion later, or there is a
reason why this patch is keeping those as is but I'm missing.


Thanks,
SJ

