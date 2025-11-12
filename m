Return-Path: <linux-kernel+bounces-896925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E38C51896
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA9118865F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280252D6624;
	Wed, 12 Nov 2025 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akwA/QS5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA6A2FF658
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941609; cv=none; b=CjfQ6DiVV1e4y47FRzZv49R0fvNwKbW5BLANs2qPeOUbAt77DWOQUciV23QDps+Mr0RTRU+KXA1nbD3l1lbXlKkWMasrBp4sho/sZThO3Ym+L2U6TPlURwh6oQZVx1/m67DSAu8bqeBfla7TuFZ/pxD0eJsvL6GsHI+i9uZ3vkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941609; c=relaxed/simple;
	bh=Hc9SpvODoEKqXyT0Yv/Hs9C9gFsaCYRYLwLn+AbBGok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCq+iGYFWtk8CKtvqXW2ETT96wyYuK9SgNincoROryOgLHWuOxMHxb6YjigqA1bSafJQLaHisc0yRIqXKuZX/w/ivfMekBpXvp5/QkiadkcYCWARCmoxGd4z+YHX1wkJkDtp/taKVaNABXgrQq5w2/TJwFlL/GTbtZryYkYhwr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akwA/QS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB55C4CEF8;
	Wed, 12 Nov 2025 10:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762941608;
	bh=Hc9SpvODoEKqXyT0Yv/Hs9C9gFsaCYRYLwLn+AbBGok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=akwA/QS5z6CaUXVEzunr+7pQgnrxiS05TwnBHMPu9G9K7v9c/3R8iUIoq0Fcs1D4g
	 uZyFVcYDoifzu15xZtQHiFBAIMDuqArYYZlBjJXdyvuagQ+WofFYu/yGFfMBt2KwOe
	 G+n6vnPF/RN8DkE0+tTxciwrHE1uEt6TYEil166dlKMJggi3wQvLptrv9X9lU6PxgQ
	 XNAr6Fr9I8+mApELE0Zj+iZ1Qiz442z8ZyH6mke/U0LWo9Hx0HSVCUoO8RPKVSBGnf
	 CUy8XhqDiIhiws23n55El8P4yhgadO8ReX6Eikf6sUhqd0LFCEWkHzOmC++LncJ0+w
	 wQDl9Ia2iQ4lw==
Message-ID: <048134fd-6a3d-4a6c-a2eb-9a9911c3b35f@kernel.org>
Date: Wed, 12 Nov 2025 11:00:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory.c: introduce split_unmapped_folio_to_order
To: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20251112044634.963360-1-balbirs@nvidia.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251112044634.963360-1-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.11.25 05:46, Balbir Singh wrote:
> Unmapped was added as a parameter to __folio_split() and related
> call sites to support splitting of folios already in the midst
> of a migration. This special case arose for device private folio
> migration since during migration there could be a disconnect between
> source and destination on the folio size.
> 
> Introduce split_unmapped_folio_to_order() to handle this special case.
> This in turn removes the special casing introduced by the unmapped
> parameter in __folio_split().

As raised recently, I would hope that we can find a way to make all 
these splitting functions look more similar in the long term, ideally 
starting with "folio_split" / "folio_try_split".

What about

	folio_split_unmapped()

Do we really have to spell out the "to order" part in the function name?

And if it's more a mostly-internal helper, maybe

	__folio_split_unmapped()

subject: "mm/huge_memory: introduce ..."

> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> Cc: Rakie Kim <rakie.kim@sk.com>
> Cc: Byungchul Park <byungchul@sk.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Ying Huang <ying.huang@linux.alibaba.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mika Penttilä <mpenttil@redhat.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Francois Dugast <francois.dugast@intel.com>
> 
> Suggested-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> ---
>   include/linux/huge_mm.h |   5 +-
>   mm/huge_memory.c        | 135 ++++++++++++++++++++++++++++++++++------
>   mm/migrate_device.c     |   3 +-
>   3 files changed, 120 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index e2e91aa1a042..9155e683c08a 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -371,7 +371,8 @@ enum split_type {
>   
>   bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
>   int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
> -		unsigned int new_order, bool unmapped);
> +		unsigned int new_order);
> +int split_unmapped_folio_to_order(struct folio *folio, unsigned int new_order);
>   int min_order_for_split(struct folio *folio);
>   int split_folio_to_list(struct folio *folio, struct list_head *list);
>   bool folio_split_supported(struct folio *folio, unsigned int new_order,
> @@ -382,7 +383,7 @@ int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
>   static inline int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   		unsigned int new_order)
>   {
> -	return __split_huge_page_to_list_to_order(page, list, new_order, false);
> +	return __split_huge_page_to_list_to_order(page, list, new_order);
>   }
>   static inline int split_huge_page_to_order(struct page *page, unsigned int new_order)
>   {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0184cd915f44..942bd8410c54 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3747,7 +3747,6 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
>    * @lock_at: a page within @folio to be left locked to caller
>    * @list: after-split folios will be put on it if non NULL
>    * @split_type: perform uniform split or not (non-uniform split)
> - * @unmapped: The pages are already unmapped, they are migration entries.
>    *
>    * It calls __split_unmapped_folio() to perform uniform and non-uniform split.
>    * It is in charge of checking whether the split is supported or not and
> @@ -3763,7 +3762,7 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
>    */
>   static int __folio_split(struct folio *folio, unsigned int new_order,
>   		struct page *split_at, struct page *lock_at,
> -		struct list_head *list, enum split_type split_type, bool unmapped)
> +		struct list_head *list, enum split_type split_type)

Yeah, nice to see that go.

>   {
>   	struct deferred_split *ds_queue;
>   	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
> @@ -3809,14 +3808,12 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>   		 * is taken to serialise against parallel split or collapse
>   		 * operations.
>   		 */
> -		if (!unmapped) {
> -			anon_vma = folio_get_anon_vma(folio);
> -			if (!anon_vma) {
> -				ret = -EBUSY;
> -				goto out;
> -			}
> -			anon_vma_lock_write(anon_vma);
> +		anon_vma = folio_get_anon_vma(folio);
> +		if (!anon_vma) {
> +			ret = -EBUSY;
> +			goto out;
>   		}
> +		anon_vma_lock_write(anon_vma);
>   		mapping = NULL;
>   	} else {
>   		unsigned int min_order;
> @@ -3882,8 +3879,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>   		goto out_unlock;
>   	}
>   
> -	if (!unmapped)
> -		unmap_folio(folio);
> +	unmap_folio(folio);
>   

Hm, I would have hoped that we could factor out the core logic and reuse 
it for the new helper, instead of duplicating code.

Did you look into that?


-- 
Cheers

David

