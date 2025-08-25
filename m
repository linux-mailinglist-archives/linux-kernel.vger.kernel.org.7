Return-Path: <linux-kernel+bounces-783927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A26DB33464
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C783B832A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722BB22C355;
	Mon, 25 Aug 2025 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jUDtO3+j"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01556A935
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756090977; cv=none; b=GUJl8411oY3Emjei8EDbR3kedM/j+/X6cFq/1xHNPvqKl/1+8pEw72TtuOfMJNudhJ7FbGgBheHUsEV3XbqQvwgScxgmjCuxV3AOrtXO5VxEbGk7mAbt74MyRQbUaMPycjXXkRA964ATk/vSOeXDYg8LS3poVqWE8ZAmPZM3n9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756090977; c=relaxed/simple;
	bh=Yj3q1Sz4awXBFhyMHdtec8exSuUkQt0shYEf8GPbEeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdID8V4M1q9C7G0ZOjeFP5p3xtvdjjEhduaS18eVy33PwFowwUWxoNfVxpwIwqRjtaTceKZhyfue+5GLDtZMSpvuqE6uupRjOYvcVXKNzm8l43et6+0fzSh7NfZET4r82gUmGS+2JYnDFeZz6sgsJS6mlPgGOJLVZhvMj/mrmAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jUDtO3+j; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756090973; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YDyIr1bDDorwY28+AGmaE7j4FXIULd86PhLUjg5+Yc8=;
	b=jUDtO3+jbT8AD3KfX7spJLLQrgLJEWVBb2k5R93YaPI+pcxanjNCqsiecRCKzkFHXdKYENaj9duQDPXb6lMPIy7h6NpGy3m7Bp2vxPO53l2yJUw54oJ52hrwo/0Q/pRsp1aoJ1uDAZ7lCwAsWIdlrBMhRqhp1VuKUlAm9Bj86ak=
Received: from 30.74.144.124(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmPuZG-_1756090970 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Aug 2025 11:02:51 +0800
Message-ID: <0fc6e083-b7be-4144-a50c-d1a7a2e1c3a5@linux.alibaba.com>
Date: Mon, 25 Aug 2025 11:02:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] mm/shmem, swap: remove redundant error handling for
 replacing folio
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
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-6-ryncsn@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250822192023.13477-6-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/23 03:20, Kairui Song wrote:
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
> ---
>   mm/shmem.c | 28 +++-------------------------
>   1 file changed, 3 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b4d39f2a1e0a..e03793cc5169 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2158,35 +2158,13 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
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

It looks like the shmem statistics update was mistakenly deleted?

( Continue to understand the whole series:) )

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
> +	folio_add_lru(new);
> +	*foliop = new;
>   
>   	folio_clear_swapcache(old);
>   	old->private = NULL;


