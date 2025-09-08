Return-Path: <linux-kernel+bounces-804997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D685AB482D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1683C03F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C1920ADF8;
	Mon,  8 Sep 2025 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CYv9zcAP"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6D34316E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 03:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757301433; cv=none; b=hzsmlS8yjSKnFbuYT7bUlbLbK989+bqGBq3c/iJeBHQdVI4mPIxU/zOaATXckk4N8xsl6fq+lS+1dbCyf4soVG4qukG8x1WVchHadCfFEoePVNESzvzuSIk3hHmcr5s3kFE8k12NHwARdQLb4D/vou7u2620tyEkNV/F4znkE0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757301433; c=relaxed/simple;
	bh=cvSSrJzFaLvV/dJO1PmJIGo0hbL9UoOWpiSzinnSSjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbUJZ2uUWDjxT/r0geBqgxuMBmg2kwa4wNODNsDYIDSYbXQmjauEghwb9LOdIXCubmajKKz18wOvHgbAjnqvDFV6BsGQ1+HEQnx0eAdcE6Tx70i09KEl+MSZo/JxVJLVSGgLSzOyBuvswNTYzxS9Bs6rw/yyH7TsAsPLt5cmoG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CYv9zcAP; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757301428; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=F27m7s5BT5f1gDzt8fNIBCug1ivyD0DMViJPGFeUZ+0=;
	b=CYv9zcAPvLJ3tVEAOVnYyfnGz8lrLJbO0n2KKjPbp8ew64JxAiTKadphD2gMApFuPMqVd+ccgbB4edT/sdbkqyjENACbR4pwXWjysSNdNbqQ3fPC4hZfi5VRmpvmxAp5lxTWq/f+p680PMWK6MHR1HNfRkG0Fz0eNPf76nf2wGs=
Received: from 30.74.144.132(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnQYL4N_1757301426 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Sep 2025 11:17:07 +0800
Message-ID: <1ee09786-ed3c-485e-99e4-48c4d2b92ced@linux.alibaba.com>
Date: Mon, 8 Sep 2025 11:17:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] mm/shmem, swap: remove redundant error handling
 for replacing folio
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-9-ryncsn@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250905191357.78298-9-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/6 03:13, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Shmem may replace a folio in the swap cache if the cached one doesn't
> fit the swapin's GFP zone. When doing so, shmem has already double
> checked that the swap cache folio is locked, still has the swap cache
> flag set, and contains the wanted swap entry. So it is impossible to
> fail due to an Xarray mismatch. There is even a comment for that.
> 
> Delete the defensive error handling path, and add a WARN_ON instead:
> if that happened, something has broken the basic principle of how the
> swap cache works, we should catch and fix that.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/shmem.c | 42 ++++++++++++------------------------------
>   1 file changed, 12 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4e27e8e5da3b..cc6a0007c7a6 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1698,13 +1698,13 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
>   		}
>   
>   		/*
> -		 * The delete_from_swap_cache() below could be left for
> +		 * The swap_cache_del_folio() below could be left for
>   		 * shrink_folio_list()'s folio_free_swap() to dispose of;
>   		 * but I'm a little nervous about letting this folio out of
>   		 * shmem_writeout() in a hybrid half-tmpfs-half-swap state
>   		 * e.g. folio_mapping(folio) might give an unexpected answer.
>   		 */
> -		delete_from_swap_cache(folio);
> +		swap_cache_del_folio(folio);
>   		goto redirty;
>   	}

You should reorganize your patch set, as the swap_cache_del_folio() 
function is introduced in patch 9.

>   	if (nr_pages > 1)
> @@ -2082,7 +2082,7 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
>   	new->swap = entry;
>   
>   	memcg1_swapin(entry, nr_pages);
> -	shadow = get_shadow_from_swap_cache(entry);
> +	shadow = swap_cache_get_shadow(entry);

Ditto.

>   	if (shadow)
>   		workingset_refault(new, shadow);
>   	folio_add_lru(new);
> @@ -2158,35 +2158,17 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
>   	/* Swap cache still stores N entries instead of a high-order entry */
>   	xa_lock_irq(&swap_mapping->i_pages);
>   	for (i = 0; i < nr_pages; i++) {
> -		void *item = xas_load(&xas);
> -
> -		if (item != old) {
> -			error = -ENOENT;
> -			break;
> -		}
> -
> -		xas_store(&xas, new);
> +		WARN_ON_ONCE(xas_store(&xas, new));
>   		xas_next(&xas);
>   	}
> -	if (!error) {
> -		mem_cgroup_replace_folio(old, new);
> -		shmem_update_stats(new, nr_pages);
> -		shmem_update_stats(old, -nr_pages);
> -	}
>   	xa_unlock_irq(&swap_mapping->i_pages);
>   
> -	if (unlikely(error)) {
> -		/*
> -		 * Is this possible?  I think not, now that our callers
> -		 * check both the swapcache flag and folio->private
> -		 * after getting the folio lock; but be defensive.
> -		 * Reverse old to newpage for clear and free.
> -		 */
> -		old = new;
> -	} else {
> -		folio_add_lru(new);
> -		*foliop = new;
> -	}
> +	mem_cgroup_replace_folio(old, new);
> +	shmem_update_stats(new, nr_pages);
> +	shmem_update_stats(old, -nr_pages);
> +
> +	folio_add_lru(new);
> +	*foliop = new;
>   
>   	folio_clear_swapcache(old);
>   	old->private = NULL;
> @@ -2220,7 +2202,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>   	nr_pages = folio_nr_pages(folio);
>   	folio_wait_writeback(folio);
>   	if (!skip_swapcache)
> -		delete_from_swap_cache(folio);
> +		swap_cache_del_folio(folio);
>   	/*
>   	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks
>   	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
> @@ -2459,7 +2441,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>   		folio->swap.val = 0;
>   		swapcache_clear(si, swap, nr_pages);
>   	} else {
> -		delete_from_swap_cache(folio);
> +		swap_cache_del_folio(folio);
>   	}
>   	folio_mark_dirty(folio);
>   	swap_free_nr(swap, nr_pages);


