Return-Path: <linux-kernel+bounces-734916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48402B0882A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684023BE976
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E81D283FD0;
	Thu, 17 Jul 2025 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bb/wgZXB"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89AE1D7E42
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742015; cv=none; b=bFJysEjSrVYII1Tpg4oAiWz09wIII0QuYEm7wJxFt/PC5OSfQN0M5J/PPcdhsZPejJXfOQIFJ4bt0v5VTPVCVG2Z0DDCi1F6zhjFa20greBYGLsIM8JREcNzBuMfZaF1djnhEPoosd+88GowkD+Js1scCFya9fRBxKUc/7TRHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742015; c=relaxed/simple;
	bh=FXLJcFsoj/SCw8PZIalLLWNq1LUPV8jdyQ175kpC898=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfV+MvdDVatTP+LiAxUTH2X7IjptuVErpZdhWIbWw6h44lzcnfnMKJagsHhxgfsUJqAlImwrUEfwRzBYbPd6XYo5s9nmDhheccV8YZgCyD8+niOcITjMwU8xAGkgbxGdLDY7t0c/2zMlhewddJEQ9a+dogOBY8DsmB7DyLpaVJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bb/wgZXB; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752742008; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WI9t0vYUiM6EPcwXB+Epv9DnfmRhxSqBDsbok8GgZlc=;
	b=bb/wgZXBOOKEwCePdVKC8erk5R4LYFbktny4A58m8I6lRoymh+aCESdejS/YUCijQI1xN7Q2wrOJfhZWENAcm+oXVWyX06OVlSiVXYLo8xUO6MFQgMx4T4/DyfGzmvKWr+asLLVAhyCQsn0GKZ/0emOmHJ3UNefLNWoLSTqCRxQ=
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wj7R2iT_1752742007 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 16:46:48 +0800
Message-ID: <f7d72dd8-00c4-4731-99d1-9faaca4275ba@linux.alibaba.com>
Date: Thu, 17 Jul 2025 16:46:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 1/2] mm/shmem: hold shmem_swaplist spinlock (not
 mutex) much less
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>,
 Kairui Song <ryncsn@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <87beaec6-a3b0-ce7a-c892-1e1e5bd57aa3@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87beaec6-a3b0-ce7a-c892-1e1e5bd57aa3@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/16 16:05, Hugh Dickins wrote:
> A flamegraph (from an MGLRU load) showed shmem_writeout()'s use of the
> global shmem_swaplist_mutex worryingly hot: improvement is long overdue.
> 
> 3.1 commit 6922c0c7abd3 ("tmpfs: convert shmem_writepage and enable swap")
> apologized for extending shmem_swaplist_mutex across add_to_swap_cache(),
> and hoped to find another way: yes, there may be lots of work to allocate
> radix tree nodes in there.  Then 6.15 commit b487a2da3575 ("mm, swap:
> simplify folio swap allocation") will have made it worse, by moving
> shmem_writeout()'s swap allocation under that mutex too (but the worrying
> flamegraph was observed even before that change).
> 
> There's a useful comment about pagelock no longer protecting from eviction
> once moved to swap cache: but it's good till shmem_delete_from_page_cache()
> replaces page pointer by swap entry, so move the swaplist add between them.
> 
> We would much prefer to take the global lock once per inode than once per
> page: given the possible races with shmem_unuse() pruning when !swapped
> (and other tasks racing to swap other pages out or in), try the swaplist
> add whenever swapped was incremented from 0 (but inode may already be on
> the list - only unuse and evict bother to remove it).
> 
> This technique is more subtle than it looks (we're avoiding the very lock
> which would make it easy), but works: whereas an unlocked list_empty()
> check runs a risk of the inode being unqueued and left off the swaplist
> forever, swapoff only completing when the page is faulted in or removed.
> 
> The need for a sleepable mutex went away in 5.1 commit b56a2d8af914
> ("mm: rid swapoff of quadratic complexity"): a spinlock works better now.
> 
> This commit is certain to take shmem_swaplist_mutex out of contention,
> and has been seen to make a practical improvement (but there is likely
> to have been an underlying issue which made its contention so visible).
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Makes sense to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/shmem.c | 59 ++++++++++++++++++++++++++++++------------------------
>   1 file changed, 33 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 60247dc48505..33675361031b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -292,7 +292,7 @@ bool vma_is_shmem(struct vm_area_struct *vma)
>   }
>   
>   static LIST_HEAD(shmem_swaplist);
> -static DEFINE_MUTEX(shmem_swaplist_mutex);
> +static DEFINE_SPINLOCK(shmem_swaplist_lock);
>   
>   #ifdef CONFIG_TMPFS_QUOTA
>   
> @@ -432,10 +432,13 @@ static void shmem_free_inode(struct super_block *sb, size_t freed_ispace)
>    *
>    * But normally   info->alloced == inode->i_mapping->nrpages + info->swapped
>    * So mm freed is info->alloced - (inode->i_mapping->nrpages + info->swapped)
> + *
> + * Return: true if swapped was incremented from 0, for shmem_writeout().
>    */
> -static void shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
> +static bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
>   {
>   	struct shmem_inode_info *info = SHMEM_I(inode);
> +	bool first_swapped = false;
>   	long freed;
>   
>   	spin_lock(&info->lock);
> @@ -450,8 +453,11 @@ static void shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
>   	 * to stop a racing shmem_recalc_inode() from thinking that a page has
>   	 * been freed.  Compensate here, to avoid the need for a followup call.
>   	 */
> -	if (swapped > 0)
> +	if (swapped > 0) {
> +		if (info->swapped == swapped)
> +			first_swapped = true;
>   		freed += swapped;
> +	}
>   	if (freed > 0)
>   		info->alloced -= freed;
>   	spin_unlock(&info->lock);
> @@ -459,6 +465,7 @@ static void shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
>   	/* The quota case may block */
>   	if (freed > 0)
>   		shmem_inode_unacct_blocks(inode, freed);
> +	return first_swapped;
>   }
>   
>   bool shmem_charge(struct inode *inode, long pages)
> @@ -1399,11 +1406,11 @@ static void shmem_evict_inode(struct inode *inode)
>   			/* Wait while shmem_unuse() is scanning this inode... */
>   			wait_var_event(&info->stop_eviction,
>   				       !atomic_read(&info->stop_eviction));
> -			mutex_lock(&shmem_swaplist_mutex);
> +			spin_lock(&shmem_swaplist_lock);
>   			/* ...but beware of the race if we peeked too early */
>   			if (!atomic_read(&info->stop_eviction))
>   				list_del_init(&info->swaplist);
> -			mutex_unlock(&shmem_swaplist_mutex);
> +			spin_unlock(&shmem_swaplist_lock);
>   		}
>   	}
>   
> @@ -1526,7 +1533,7 @@ int shmem_unuse(unsigned int type)
>   	if (list_empty(&shmem_swaplist))
>   		return 0;
>   
> -	mutex_lock(&shmem_swaplist_mutex);
> +	spin_lock(&shmem_swaplist_lock);
>   start_over:
>   	list_for_each_entry_safe(info, next, &shmem_swaplist, swaplist) {
>   		if (!info->swapped) {
> @@ -1540,12 +1547,12 @@ int shmem_unuse(unsigned int type)
>   		 * (igrab() would protect from unlink, but not from unmount).
>   		 */
>   		atomic_inc(&info->stop_eviction);
> -		mutex_unlock(&shmem_swaplist_mutex);
> +		spin_unlock(&shmem_swaplist_lock);
>   
>   		error = shmem_unuse_inode(&info->vfs_inode, type);
>   		cond_resched();
>   
> -		mutex_lock(&shmem_swaplist_mutex);
> +		spin_lock(&shmem_swaplist_lock);
>   		if (atomic_dec_and_test(&info->stop_eviction))
>   			wake_up_var(&info->stop_eviction);
>   		if (error)
> @@ -1556,7 +1563,7 @@ int shmem_unuse(unsigned int type)
>   		if (!info->swapped)
>   			list_del_init(&info->swaplist);
>   	}
> -	mutex_unlock(&shmem_swaplist_mutex);
> +	spin_unlock(&shmem_swaplist_lock);
>   
>   	return error;
>   }
> @@ -1646,30 +1653,30 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
>   		folio_mark_uptodate(folio);
>   	}
>   
> -	/*
> -	 * Add inode to shmem_unuse()'s list of swapped-out inodes,
> -	 * if it's not already there.  Do it now before the folio is
> -	 * moved to swap cache, when its pagelock no longer protects
> -	 * the inode from eviction.  But don't unlock the mutex until
> -	 * we've incremented swapped, because shmem_unuse_inode() will
> -	 * prune a !swapped inode from the swaplist under this mutex.
> -	 */
> -	mutex_lock(&shmem_swaplist_mutex);
> -	if (list_empty(&info->swaplist))
> -		list_add(&info->swaplist, &shmem_swaplist);
> -
>   	if (!folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN)) {
> -		shmem_recalc_inode(inode, 0, nr_pages);
> +		bool first_swapped = shmem_recalc_inode(inode, 0, nr_pages);
> +
> +		/*
> +		 * Add inode to shmem_unuse()'s list of swapped-out inodes,
> +		 * if it's not already there.  Do it now before the folio is
> +		 * removed from page cache, when its pagelock no longer
> +		 * protects the inode from eviction.  And do it now, after
> +		 * we've incremented swapped, because shmem_unuse() will
> +		 * prune a !swapped inode from the swaplist.
> +		 */
> +		if (first_swapped) {
> +			spin_lock(&shmem_swaplist_lock);
> +			if (list_empty(&info->swaplist))
> +				list_add(&info->swaplist, &shmem_swaplist);
> +			spin_unlock(&shmem_swaplist_lock);
> +		}
> +
>   		swap_shmem_alloc(folio->swap, nr_pages);
>   		shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swap));
>   
> -		mutex_unlock(&shmem_swaplist_mutex);
>   		BUG_ON(folio_mapped(folio));
>   		return swap_writeout(folio, plug);
>   	}
> -	if (!info->swapped)
> -		list_del_init(&info->swaplist);
> -	mutex_unlock(&shmem_swaplist_mutex);
>   	if (nr_pages > 1)
>   		goto try_split;
>   redirty:


