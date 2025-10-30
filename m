Return-Path: <linux-kernel+bounces-879250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA42C22A58
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D860425148
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE12633B96C;
	Thu, 30 Oct 2025 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hKAjuKoZ"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A52433B943
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865506; cv=none; b=TrfbVsL8PLe1+HPv3DAX+RKZUOmnwlPjxtUJOYQS7E3PXOk5ycOMt6vX4Z9N9k7PFddzHOpZt871kTB+P/8u/yajf7DPTxsH907wgpQBO0qezdU22zQs+dDs/w++yKznYkJ24LxajfKg7hfYmSLFGeb4RXW87J+w+7xbUD8GVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865506; c=relaxed/simple;
	bh=xBJn3tImWNUwD5Rz7zazeeBdhMRsw1jwOL+Sn+y6NH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ej9mDBbMldFjB9SmLUZOUX+cRFqdIf5VwAIv/TfZYEHd2s7z7wSyyzr/FM683cVykPQklzUKMxcFKe/+zNcRzuZ5//YwH5UPwjVKs3UJIlAD1SU+ByQXbPgF+WVNYZeaZr2AHiErZzQu0a30l+ENM3G0Kw+6iJ/Zhe8iVpkSz5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hKAjuKoZ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 30 Oct 2025 23:04:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761865500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bQJC1QXkt5VkE/jRY6BIklJjlsax/KlvqbIZU2KJ9/I=;
	b=hKAjuKoZUMHePmJrJZeXuGp/FYZptRWwan1Piz6OQKJJT4xJLJYcHQqatl3bxqsIsmrAKV
	0KsSIj6YukHYK/5o7uZJZimgtjjie7sE9BG/EMvHpl8OuMEwsg/wORe3DProeIr8iBaQEI
	1a5hgpaFQ19F/sQ5fk+QR8gQURrEdkQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 00/19] mm, swap: never bypass swap cache and cleanup
 flags (swap table phase II)
Message-ID: <bvavihwrtkbnsqgjbotwihckxzmnhdd4e6jre4j7xdiyyeyv5o@dnnuyacthvms>
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 29, 2025 at 11:58:26PM +0800, Kairui Song wrote:
> This series removes the SWP_SYNCHRONOUS_IO swap cache bypass code and
> special swap bits including SWAP_HAS_CACHE, along with many historical
> issues. The performance is about ~20% better for some workloads, like
> Redis with persistence. This also cleans up the code to prepare for
> later phases, some patches are from a previously posted series.
> 
> Swap cache bypassing and swap synchronization in general had many
> issues. Some are solved as workarounds, and some are still there [1]. To
> resolve them in a clean way, one good solution is to always use swap
> cache as the synchronization layer [2]. So we have to remove the swap
> cache bypass swap-in path first. It wasn't very doable due to
> performance issues, but now combined with the swap table, removing
> the swap cache bypass path will instead improve the performance,
> there is no reason to keep it.
> 
> Now we can rework the swap entry and cache synchronization following
> the new design. Swap cache synchronization was heavily relying on
> SWAP_HAS_CACHE, which is the cause of many issues. By dropping the usage
> of special swap map bits and related workarounds, we get a cleaner code
> base and prepare for merging the swap count into the swap table in the
> next step.
> 
> Test results:
> 
> Redis / Valkey bench:
> =====================
> 
> Testing on a ARM64 VM 1.5G memory:
> Server: valkey-server --maxmemory 2560M
> Client: redis-benchmark -r 3000000 -n 3000000 -d 1024 -c 12 -P 32 -t get
> 
>         no persistence              with BGSAVE
> Before: 460475.84 RPS               311591.19 RPS
> After:  451943.34 RPS (-1.9%)       371379.06 RPS (+19.2%)
> 
> Testing on a x86_64 VM with 4G memory (system components takes about 2G):
> Server:
> Client: redis-benchmark -r 3000000 -n 3000000 -d 1024 -c 12 -P 32 -t get
> 
>         no persistence              with BGSAVE
> Before: 306044.38 RPS               102745.88 RPS
> After:  309645.44 RPS (+1.2%)       125313.28 RPS (+22.0%)
> 
> The performance is a lot better when persistence is applied. This should
> apply to many other workloads that involve sharing memory and COW. A
> slight performance drop was observed for the ARM64 Redis test: We are
> still using swap_map to track the swap count, which is causing redundant
> cache and CPU overhead and is not very performance-friendly for some
> arches. This will be improved once we merge the swap map into the swap
> table (as already demonstrated previously [3]).
> 
> vm-scabiity
> ===========
> usemem --init-time -O -y -x -n 32 1536M (16G memory, global pressure,
> simulated PMEM as swap), average result of 6 test run:
> 
>                            Before:         After:
> System time:               282.22s         283.47s
> Sum Throughput:            5677.35 MB/s    5688.78 MB/s
> Single process Throughput: 176.41 MB/s     176.23 MB/s
> Free latency:              518477.96 us    521488.06 us
> 
> Which is almost identical.
> 
> Build kernel test:
> ==================
> Test using ZRAM as SWAP, make -j48, defconfig, on a x86_64 VM
> with 4G RAM, under global pressure, avg of 32 test run:
> 
>                 Before            After:
> System time:    1379.91s          1364.22s (-0.11%)
> 
> Test using ZSWAP with NVME SWAP, make -j48, defconfig, on a x86_64 VM
> with 4G RAM, under global pressure, avg of 32 test run:
> 
>                 Before            After:
> System time:    1822.52s          1803.33s (-0.11%)
> 
> Which is almost identical.
> 
> MySQL:
> ======
> sysbench /usr/share/sysbench/oltp_read_only.lua --tables=16
> --table-size=1000000 --threads=96 --time=600 (using ZRAM as SWAP, in a
> 512M memory cgroup, buffer pool set to 3G, 3 test run and 180s warm up).
> 
> Before: 318162.18 qps
> After:  318512.01 qps (+0.01%)
> 
> In conclusion, the result is looking better or identical for most cases,
> and it's especially better for workloads with swap count > 1 on SYNC_IO
> devices, about ~20% gain in above test. Next phases will start to merge
> swap count into swap table and reduce memory usage.
> 
> One more gain here is that we now have better support for THP swapin.
> Previously, the THP swapin was bound with swap cache bypassing, which
> only works for single-mapped folios. Removing the bypassing path also
> enabled THP swapin for all folios. It's still limited to SYNC_IO
> devices, though, this limitation can will be removed later. This may
> cause more serious thrashing for certain workloads, but that's not an
> issue caused by this series, it's a common THP issue we should resolve
> separately.
> 
> Link: https://lore.kernel.org/linux-mm/CAMgjq7D5qoFEK9Omvd5_Zqs6M+TEoG03+2i_mhuP5CQPSOPrmQ@mail.gmail.com/ [1]
> Link: https://lore.kernel.org/linux-mm/20240326185032.72159-1-ryncsn@gmail.com/ [2]
> Link: https://lore.kernel.org/linux-mm/20250514201729.48420-1-ryncsn@gmail.com/ [3]
> 
> Suggested-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Unfortunately I don't have time to go through the series and review it,
but I wanted to just say awesome work here. The special cases in the
swap code to avoid using the swapcache have always been a pain.

In fact, there's one more special case that we can probably remove in
zswap_load() now, the one introduced by commit 25cd241408a2 ("mm: zswap:
fix data loss on SWP_SYNCHRONOUS_IO devices").

> ---
> Kairui Song (18):
>       mm/swap: rename __read_swap_cache_async to swap_cache_alloc_folio
>       mm, swap: split swap cache preparation loop into a standalone helper
>       mm, swap: never bypass the swap cache even for SWP_SYNCHRONOUS_IO
>       mm, swap: always try to free swap cache for SWP_SYNCHRONOUS_IO devices
>       mm, swap: simplify the code and reduce indention
>       mm, swap: free the swap cache after folio is mapped
>       mm/shmem: never bypass the swap cache for SWP_SYNCHRONOUS_IO
>       mm, swap: swap entry of a bad slot should not be considered as swapped out
>       mm, swap: consolidate cluster reclaim and check logic
>       mm, swap: split locked entry duplicating into a standalone helper
>       mm, swap: use swap cache as the swap in synchronize layer
>       mm, swap: remove workaround for unsynchronized swap map cache state
>       mm, swap: sanitize swap entry management workflow
>       mm, swap: add folio to swap cache directly on allocation
>       mm, swap: check swap table directly for checking cache
>       mm, swap: clean up and improve swap entries freeing
>       mm, swap: drop the SWAP_HAS_CACHE flag
>       mm, swap: remove no longer needed _swap_info_get
> 
> Nhat Pham (1):
>       mm/shmem, swap: remove SWAP_MAP_SHMEM
> 
>  arch/s390/mm/pgtable.c |   2 +-
>  include/linux/swap.h   |  77 ++---
>  kernel/power/swap.c    |  10 +-
>  mm/madvise.c           |   2 +-
>  mm/memory.c            | 270 +++++++---------
>  mm/rmap.c              |   7 +-
>  mm/shmem.c             |  75 ++---
>  mm/swap.h              |  69 +++-
>  mm/swap_state.c        | 341 +++++++++++++-------
>  mm/swapfile.c          | 849 +++++++++++++++++++++----------------------------
>  mm/userfaultfd.c       |  10 +-
>  mm/vmscan.c            |   1 -
>  mm/zswap.c             |   4 +-
>  13 files changed, 840 insertions(+), 877 deletions(-)
> ---
> base-commit: f30d294530d939fa4b77d61bc60f25c4284841fa
> change-id: 20251007-swap-table-p2-7d3086e5c38a
> 
> Best regards,
> -- 
> Kairui Song <kasong@tencent.com>
> 

