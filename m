Return-Path: <linux-kernel+bounces-735023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED68B08995
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D75A189BCE0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F45288CBE;
	Thu, 17 Jul 2025 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="g3GkkJxe"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A7B33086
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745469; cv=none; b=BXpDMyyC3C5gepReOCzokFLT+MK1KT60v8QyeSPSOnKe1O9RINPcqRm1Wo/Npf+fWuzl4sxSRWju2rJdvp0OqqACWKfrXgBS0WDQdfx6uwrtz0WCe561GFUqqfFJHx9szW6aCvngcnxUU7078MDEAt/hXdfeUMrOs4ohEd5c2BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745469; c=relaxed/simple;
	bh=iaq7HJ9qfvE98rHBSH+nyMmWcZRGFr9hPrQ/UJaAxWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5gxkeFI0lxuyJ4a1rsC4iaGuyO9KtA3u7IdOBNVz9s0kfTu58715L3l/Bh4zfdU5inNhp3uudrNQlboQdAz2e8XpyPmwcEmObCnyWwpOxIZCQZsWJC919EX3A2MrvVxb/4JTP00qjnCPV52BITIDrykgo7F7sOLdk5no+WNkoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=g3GkkJxe; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752745464; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PkCKxsY6Zs44X+GOM2QndRR5634GVOJV4plJy537mWM=;
	b=g3GkkJxeiYO+P2iOLsXiBGegRkvPifQrpsC2UDf9ZWfdxbxQI1gbaZ/SMnNJfAPPsrO2ussfbjzaW/U7jqNw3PJXld69g11HlGivUd4s9oCtALNFJNzwrFHvgeMwV1+Aa6KYLrOSr7XXnnvBeo27hIctP8p7jrbeYxoQRYjb0Ow=
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wj7eO2U_1752745463 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 17:44:23 +0800
Message-ID: <853a5211-cdab-4bdf-b0c4-8092dd943ff5@linux.alibaba.com>
Date: Thu, 17 Jul 2025 17:44:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 2/2] mm/shmem: writeout free swap if
 swap_writeout() reactivates
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>,
 Kairui Song <ryncsn@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <87beaec6-a3b0-ce7a-c892-1e1e5bd57aa3@google.com>
 <5c911f7a-af7a-5029-1dd4-2e00b66d565c@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <5c911f7a-af7a-5029-1dd4-2e00b66d565c@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hugh,

On 2025/7/16 16:08, Hugh Dickins wrote:
> If swap_writeout() returns AOP_WRITEPAGE_ACTIVATE (for example, because
> zswap cannot compress and memcg disables writeback), there is no virtue
> in keeping that folio in swap cache and holding the swap allocation:
> shmem_writeout() switch it back to shmem page cache before returning.
> 
> Folio lock is held, and folio->memcg_data remains set throughout, so
> there is no need to get into any memcg or memsw charge complications:
> swap_free_nr() and delete_from_swap_cache() do as much as is needed (but
> beware the race with shmem_free_swap() when inode truncated or evicted).
> 
> Doing the same for an anonymous folio is harder, since it will usually
> have been unmapped, with references to the swap left in the page tables.
> Adding a function to remap the folio would be fun, but not worthwhile
> unless it has other uses, or an urgent bug with anon is demonstrated.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>   mm/shmem.c | 33 ++++++++++++++++++++++++++++++++-
>   1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 33675361031b..5a7ce4c8bad6 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1655,6 +1655,7 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
>   
>   	if (!folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN)) {
>   		bool first_swapped = shmem_recalc_inode(inode, 0, nr_pages);
> +		int error;
>   
>   		/*
>   		 * Add inode to shmem_unuse()'s list of swapped-out inodes,
> @@ -1675,7 +1676,37 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
>   		shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swap));
>   
>   		BUG_ON(folio_mapped(folio));
> -		return swap_writeout(folio, plug);
> +		error = swap_writeout(folio, plug);
> +		if (error != AOP_WRITEPAGE_ACTIVATE) {
> +			/* folio has been unlocked */
> +			return error;
> +		}
> +
> +		/*
> +		 * The intention here is to avoid holding on to the swap when
> +		 * zswap was unable to compress and unable to writeback; but
> +		 * it will be appropriate if other reactivate cases are added.
> +		 */
> +		error = shmem_add_to_page_cache(folio, mapping, index,
> +				swp_to_radix_entry(folio->swap),
> +				__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
> +		/* Swap entry might be erased by racing shmem_free_swap() */
> +		if (!error) {
> +			spin_lock(&info->lock);
> +			info->swapped -= nr_pages;
> +			spin_unlock(&info->lock);

Using the helper 'shmem_recalc_inode(inode, 0, -nr_pages)' seems more 
readable?

> +			swap_free_nr(folio->swap, nr_pages);
> +		}
> +
> +		/*
> +		 * The delete_from_swap_cache() below could be left for
> +		 * shrink_folio_list()'s folio_free_swap() to dispose of;
> +		 * but I'm a little nervous about letting this folio out of
> +		 * shmem_writeout() in a hybrid half-tmpfs-half-swap state
> +		 * e.g. folio_mapping(folio) might give an unexpected answer.
> +		 */
> +		delete_from_swap_cache(folio);

IIUC, Should the delete_from_swap_cache() also be moved into the 'if 
(!error)' branch? Since if shmem_free_swap() has freed the swap entry, 
it would also reclaim the swap cache, no?

