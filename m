Return-Path: <linux-kernel+bounces-809311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D86B50BEE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B673A50D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB68246BD8;
	Wed, 10 Sep 2025 02:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF274h6e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDDF246789
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472798; cv=none; b=hwirnBeD49SsZq0CTOSys4ctYRdnkVERVpmWrB23Gi/GLPULh2gz+OJOqRMhZv0GMEnTClpG9z4T2ulY8BTlcJMicLxAj1VbXNhgvQu04l5w+TKH3ooj0HSS6pAXrLiAtR7RFLfZBEKEpt4J6GaUFxpg5L2te57N2jntDhIKOtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472798; c=relaxed/simple;
	bh=GJ1MLCdme2x9qtynutCYrIHT4ATvii1OjG3O+Z1i030=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGzocCaawoFN708HaOnGX/n7jCeK0jO1ISN97cu3blzDZG472KdK9ZOazhdypCTfxQXGMfIyw0shKVLTwceWoHwz5SudWVwANXugcOH/nOpMxEgiPbUgn3zTlF7ravDgNnBQjY9JXfWFbMH9z6epuB7MG78UJMr46VJYaE/QTYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF274h6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4CFC4CEF4;
	Wed, 10 Sep 2025 02:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757472797;
	bh=GJ1MLCdme2x9qtynutCYrIHT4ATvii1OjG3O+Z1i030=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MF274h6eft90SnUARRBgSkYCpkeBr8kOTdZElVORVZFQQ8d03ixPeSXzq3Gwsm0TT
	 hzNwssYMRaTlqDrTPPLNlIQtqDnSUi+5XIc6w7CNpjG4oDlRbgjzewwgxrcEEZhCPs
	 OCo2bJYOWQlWwg+P7uGIvGeSwvCTOOVBoncaM9owtcdFyycl1AvCqeNm5XERvLgbmI
	 WC+az8697a/hHeHRG3PQKwoUGE1tDTb4VQSW9g52fbLBI7jgAx7IqMLmqjucc71k0d
	 PfZTF+A+XMP9WN8O1PtIHFlLBAGB+Bi4ehhDhxFFStOLyV0qFvtj9DSOQ6q7lq+lcv
	 67GCFdEOQIDrA==
From: SeongJae Park <sj@kernel.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v2 11/15] mm, swap: use the swap table for the swap cache and switch API
Date: Tue,  9 Sep 2025 19:53:15 -0700
Message-Id: <20250910025315.109884-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905191357.78298-12-ryncsn@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kairui,

On Sat,  6 Sep 2025 03:13:53 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> From: Kairui Song <kasong@tencent.com>
> 
> Introduce basic swap table infrastructures, which are now just a
> fixed-sized flat array inside each swap cluster, with access wrappers.
> 
> Each cluster contains a swap table of 512 entries. Each table entry is
> an opaque atomic long. It could be in 3 types: a shadow type (XA_VALUE),
> a folio type (pointer), or NULL.
> 
> In this first step, it only supports storing a folio or shadow, and it
> is a drop-in replacement for the current swap cache. Convert all swap
> cache users to use the new sets of APIs. Chris Li has been suggesting
> using a new infrastructure for swap cache for better performance, and
> that idea combined well with the swap table as the new backing
> structure. Now the lock contention range is reduced to 2M clusters,
> which is much smaller than the 64M address_space. And we can also drop
> the multiple address_space design.
> 
> All the internal works are done with swap_cache_get_* helpers. Swap
> cache lookup is still lock-less like before, and the helper's contexts
> are same with original swap cache helpers. They still require a pin
> on the swap device to prevent the backing data from being freed.
> 
> Swap cache updates are now protected by the swap cluster lock
> instead of the Xarray lock. This is mostly handled internally, but new
> __swap_cache_* helpers require the caller to lock the cluster. So, a
> few new cluster access and locking helpers are also introduced.
> 
> A fully cluster-based unified swap table can be implemented on top
> of this to take care of all count tracking and synchronization work,
> with dynamic allocation. It should reduce the memory usage while
> making the performance even better.

Thank you for continuing this nice work.  I was unfortunately unable to get
time to review this thoroughly, but found below.

> 
> Co-developed-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
[...]
> --- a/mm/swap.h
> +++ b/mm/swap.h
[...]
> @@ -367,7 +452,7 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
>  static inline pgoff_t folio_index(struct folio *folio)
>  {
>  	if (unlikely(folio_test_swapcache(folio)))
> -		return swap_cache_index(folio->swap);
> +		return swp_offset(folio->swap);
>  	return folio->index;
>  }

This makes i386 build on my setup fails, like below:

    In file included from /mm/shmem.c:44:
    /mm/swap.h: In function ‘folio_index’:
    /mm/swap.h:462:24: error: implicit declaration of function ‘swp_offset’; did you mean ‘pmd_offset’? [-Werror=implicit-function-declaration]
      462 |                 return swp_offset(folio->swap);
          |                        ^~~~~~~~~~
          |                        pmd_offset
    In file included from /mm/shmem.c:69:
    /include/linux/swapops.h: At top level:
    /include/linux/swapops.h:107:23: error: conflicting types for ‘swp_offset’; have ‘long unsigned int(swp_entry_t)’
      107 | static inline pgoff_t swp_offset(swp_entry_t entry)
          |                       ^~~~~~~~~~
    /mm/swap.h:462:24: note: previous implicit declaration of ‘swp_offset’ with type ‘int()’
      462 |                 return swp_offset(folio->swap);
          |                        ^~~~~~~~~~
    cc1: some warnings being treated as errors

You may be able to reproduce this using my script [1].

I also found including swapops.h as below fix this on my setup.  I didn't read
this code thoroughly, so not really sure if it is the right approach, though.

    --- a/mm/swap.h
    +++ b/mm/swap.h
    @@ -3,6 +3,7 @@
     #define _MM_SWAP_H
    
     #include <linux/atomic.h> /* for atomic_long_t */
    +#include <linux/swapops.h>
     struct mempolicy;
     struct swap_iocb;

[1] https://github.com/damonitor/damon-tests/blob/master/corr/tests/build_i386.sh


Thanks,
SJ

[...]

