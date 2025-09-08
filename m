Return-Path: <linux-kernel+bounces-805009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D39B482F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6B217B3CE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85AC21578F;
	Mon,  8 Sep 2025 03:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hvNo6rZY"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8281DFE26
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 03:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757302929; cv=none; b=NNaq3F/HhJ27M68f5xwWECtpPwm6zcYqEoxAlhEhvu4JTyeUZb9RPsFp8uEzOw1sTTzGDVc9Mbnb64IH392akZO62bKkAkQw56ptQIXr3xk6Q9Pbm+uS7o81RXQ0L+vuV5u50I7myrRLFy/ZQ3WOC+HU0ZXlj8bwtcuMZfUYwek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757302929; c=relaxed/simple;
	bh=bU668F49g8AFo41Rtq9tn6f5k7qvZXBDr1HAHPXkewY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INYxWfxZV7bjcGXvTYG7WYl2hTwtF71Hv3nwc2hk2bM8FkSilcKNR19RWTR8y6H5XkD3P/Y5AjmcekYls7NtvaTniHEUda09IDZb+wh/YfoumTsSC1UqEh+BKN/v1JHbTiVHmYVvBEeADcQDj51f06kttwmEuxTBLubP2aA8QNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hvNo6rZY; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757302918; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=p59BzXNdtsBBH4YiiOWeXAEJSDW7oZS3ScEZ3ZTPVpk=;
	b=hvNo6rZYHO0F+qGa8Yt8diNurTNF4luCTqr7YxHx1EfSpJT005OLbEctIoLrkwOja7yJzjrhaIzX/0fAbdz+PynIA1jZAScG3it2Wc5EY//kRqeSScf3iUoXETOsb2F+lfRHHrfxoxjRxmt+UCzOs12fAHJvnjALMMCMucFPuqI=
Received: from 30.74.144.132(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnQj7q5_1757302916 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Sep 2025 11:41:56 +0800
Message-ID: <f8051ae4-1b9d-42dc-8272-24a05741d86e@linux.alibaba.com>
Date: Mon, 8 Sep 2025 11:41:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] mm, swap: wrap swap cache replacement with a
 helper
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
 <20250905191357.78298-11-ryncsn@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250905191357.78298-11-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/6 03:13, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> There are currently three swap cache users that are trying to replace an
> existing folio with a new one: huge memory splitting, migration, and
> shmem replacement. What they are doing is quite similar.
> 
> Introduce a common helper for this. In later commits, they can be easily
> switched to use the swap table by updating this helper.
> 
> The newly added helper also makes the swap cache API better defined, and
> debugging is easier.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>   mm/huge_memory.c |  5 ++---
>   mm/migrate.c     | 11 +++--------
>   mm/shmem.c       | 10 ++--------
>   mm/swap.h        |  3 +++
>   mm/swap_state.c  | 32 ++++++++++++++++++++++++++++++++
>   5 files changed, 42 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 26cedfcd7418..a4d192c8d794 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3798,9 +3798,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>   			 * NOTE: shmem in swap cache is not supported yet.
>   			 */
>   			if (swap_cache) {
> -				__xa_store(&swap_cache->i_pages,
> -					   swap_cache_index(new_folio->swap),
> -					   new_folio, 0);
> +				__swap_cache_replace_folio(swap_cache, new_folio->swap,
> +							   folio, new_folio);
>   				continue;
>   			}

IIUC, it doesn't seem like a simple function replacement here. It 
appears that the original code has a bug: if the 'new_folio' is a large 
folio after split, we need to iterate over each swap entry of the large 
swapcache folio and then restore the new 'new_folio'.

