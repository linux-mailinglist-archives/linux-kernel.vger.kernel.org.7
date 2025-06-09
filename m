Return-Path: <linux-kernel+bounces-677700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49636AD1DE1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 14:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDC716D1A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 12:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425A725C83A;
	Mon,  9 Jun 2025 12:31:02 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11AD25C837
	for <linux-kernel@vger.kernel.org>; Mon,  9 Jun 2025 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749472261; cv=none; b=fCz4CV0ZhtZlSBHpkVR8NFbstvMwSsDZAs8REIERFxsSCURwCgaG7v0hwc81GDuwLlumA8qvdXfJmS1BlNyrkAhf5x0OR2/RX01YR0eVCnmgpg/zBN/p0/3Br1eOZ2coEFyCP/mRvppVCJJS+CQWk0mGgHgGQaQteet97mC2XmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749472261; c=relaxed/simple;
	bh=32jXRdWIPLgffjmkpVflQM5fqGG00qDvTU4uI3VqiXs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fBwG1DHrQnV7wocq1+i7PJZjvX+stQgGL6MX5QVBrjJxjdxgBTIzMa/4f/sW38xyKXjPrz4FHwYyXA58eKLSe0/xfv94EDbaKPFDQuvdLTsUPnhIUuadUML437+GRzaValXRnKAhHMlcTs7D9bIuR5G9EWw1Ww1RHS1axHiZVgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-b4-6846d3fd693d
Message-ID: <74a7db85-8fcc-4bd5-8656-0f4d0670f205@sk.com>
Date: Mon, 9 Jun 2025 21:30:53 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, david@redhat.com, mhocko@kernel.org,
 zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 2/2] mm/damon/sysfs-schemes: add use_nodes_of_tier on
 sysfs-schemes
Content-Language: ko
To: wangchuanguo <wangchuanguo@inspur.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org, sj@kernel.org
References: <20250528111038.18378-1-wangchuanguo@inspur.com>
 <20250528111038.18378-3-wangchuanguo@inspur.com>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250528111038.18378-3-wangchuanguo@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsXC9ZZnke7fy24ZBqs3WFvMWb+GzeLJ/9+s
	Fl/X/2K2WL3J1+LyrjlsFvfW/Ge1ODlrJYvF62/LmC2ez5rLZHH46xsmi+OfnzNbfLpygN2B
	x+PfiTVsHoffvGf2OLFjA7PHplWdbB6bPk1i9zgx4zeLx8KGqcweLzbPZPT4+PQWi8f7fVfZ
	PD5vkgvgjuKySUnNySxLLdK3S+DK+DltLWPBLbGKR8c0GxjvCXQxcnJICJhIrPjxhR3GfvP5
	NhOIzStgKfHt+T5GEJtFQEXiwY07bBBxQYmTM5+wgNiiAvIS92/NAOrl4mAWuM8osXxyN1hC
	WCBSYsWtfrAGZgERidmdbcwgtohAlsT7/VvBhgoJ5Es8ajsOFmcTUJO48nIS0GIODk4BW4kt
	v6FazSS6tnYxQtjyEtvfzmEG2SUh0M4u8ejeNTaIoyUlDq64wTKBUXAWkvtmIVk9C8msWUhm
	LWBkWcUolJlXlpuYmWOil1GZl1mhl5yfu4kRGHnLav9E72D8dCH4EKMAB6MSD+8JYEQKsSaW
	FVfmHmKU4GBWEuFdCRLiTUmsrEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgm
	y8TBKdXAuHrKkWealWs9TR1DZzvHszi8v5Su1H2I5ekqu6nFzHcu7WBYUsp2qrIrfvaJcv/o
	hut9hpteNr0Ofr4vzMjlea9sooUBu+yhQ1Zxqa9un6gISgu7daRwZ2H5vb4VsxJMBVZMi0y+
	7NegqnDhibrqFZO2K/OTvRbf+9Z+3d/q2FZRwe8Va7XOKrEUZyQaajEXFScCAEnz0yy4AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LhmqGlp/v3sluGwfdFOhZz1q9hs3jy/zer
	xdf1v5gtVm/ytTg89ySrxeVdc9gs7q35z2pxctZKFovX35YxWzyfNZfJ4vDXN0wWxz8/Z7b4
	dOUAuwOvx78Ta9g8Dr95z+xxYscGZo9NqzrZPDZ9msTucWLGbxaPhQ1TmT1ebJ7J6PHx6S0W
	j/f7rrJ5LH7xgcnj8ya5AJ4oLpuU1JzMstQifbsEroyf09YyFtwSq3h0TLOB8Z5AFyMnh4SA
	icSbz7eZQGxeAUuJb8/3MYLYLAIqEg9u3GGDiAtKnJz5hAXEFhWQl7h/awZ7FyMXB7PAfUaJ
	5ZO7wRLCApESK271gzUwC4hIzO5sYwaxRQSyJN7v3wo2VEggX+JR23GwOJuAmsSVl5OAFnNw
	cArYSmz5DdVqJtG1tYsRwpaX2P52DvMERr5ZSM6YhWTDLCQts5C0LGBkWcUokplXlpuYmWOq
	V5ydUZmXWaGXnJ+7iREYR8tq/0zcwfjlsvshRgEORiUe3hPA+BJiTSwrrsw9xCjBwawkwrsS
	JMSbklhZlVqUH19UmpNafIhRmoNFSZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp1cB4RmOJ9Haf
	v4oz1OZ+1eIT5io+qnT5QGHkY0dWLufvBUotdhedymfOzEnpDD1ivyxzdfr6BW2PQq/8WrVr
	7q1rF39cuyQl6sPfd46nqUSn+rHY2tc5pz/PW3mkelKtYq5tXkhG2aTyn8IJpeeXZ4U7LFbL
	2Xz1rWe4aeRuvhfz5RuaHsdZ9yUosRRnJBpqMRcVJwIA8WlOj58CAAA=
X-CFilter-Loop: Reflected

Hi Simon and SeongJae,

Sorry for the late response.

On 5/28/2025 8:10 PM, wangchuanguo wrote:
> This patch adds use_nodes_of_tier under
>    /sys/kernel/mm/damon/admin/kdamonds/<N>/contexts/<N>/schemes/<N>/
> 
> The 'use_nodes_of_tier' can be used to select nodes within the same memory
> tier of target_nid for DAMOS actions such as DAMOS_MIGRATE_{HOT,COLD}.
> 
> Signed-off-by: wangchuanguo <wangchuanguo@inspur.com>
> ---
>   include/linux/damon.h        |  9 ++++++++-
>   include/linux/memory-tiers.h |  5 +++++
>   mm/damon/core.c              |  6 ++++--
>   mm/damon/lru_sort.c          |  3 ++-
>   mm/damon/paddr.c             | 19 ++++++++++++-------
>   mm/damon/reclaim.c           |  3 ++-
>   mm/damon/sysfs-schemes.c     | 31 ++++++++++++++++++++++++++++++-
>   mm/memory-tiers.c            | 13 +++++++++++++
>   samples/damon/mtier.c        |  3 ++-
>   samples/damon/prcl.c         |  3 ++-
>   10 files changed, 80 insertions(+), 15 deletions(-)

[...snip...]

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index e8464f7e0014..e13321cff38f 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -383,7 +383,7 @@ static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
>   
>   static unsigned int __damon_pa_migrate_folio_list(
>   		struct list_head *migrate_folios, struct pglist_data *pgdat,
> -		int target_nid)
> +		int target_nid, bool use_nodes_of_tier)
>   {
>   	unsigned int nr_succeeded = 0;
>   	nodemask_t allowed_mask = NODE_MASK_NONE;
> @@ -405,6 +405,9 @@ static unsigned int __damon_pa_migrate_folio_list(
>   	if (list_empty(migrate_folios))
>   		return 0;
>   
> +	if (use_nodes_of_tier)
> +		allowed_mask = get_tier_nodemask(target_nid);

I have a concern about this part.  This might work but, IMHO, the current memory
tier doesn't provide a concept of cross socket bridge, which is UPI in Intel.

For example, please see the following topology.

        node0           node1
      +-------+  UPI  +-------+
      | CPU 0 |-------| CPU 1 |
      +-------+       +-------+
      | DRAM0 |       | DRAM1 |  <-- memory tier 0
      +---+---+       +---+---+
          |               |
      +---+---+       +---+---+
      | CXL 0 |       | CXL 1 |  <-- memory tier 1
      +---+---+       +---+---+
        node2           node3

Even if some nodes are in the same memory tier, but if those are in the
different socket side, then the migratio makes the situation worse unexpectedly.

For example, if the page at node0 is tried to be demoted to node2, but if node2
is full then the current behavior is to cancel the demotion, but this change
makes it to be demoted to node3, which is on the other side of socket.

Since the cross socket access is a lot worse, I worry about this change.

Please let me know if you have a different thought.

Thanks,
Honggyu

