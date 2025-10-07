Return-Path: <linux-kernel+bounces-844595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1611BBC24F3
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 19:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80023C5F04
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 17:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7772E8B8E;
	Tue,  7 Oct 2025 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hryn9ECz"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DF734BA5C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859825; cv=none; b=rgulFcgoRKkh2eL8Rteg41sNDs6w01+/vcSk8WzhYbTDQ8Wc05IjEPo0sxwxi4Fizvlx64+/gdfkovriotLnMLjJJZHIJfdHIDV7wmfup5U/YLFfVVN6PHkQQlFhEd9mO/pjMd1kjkpRgCzvdNDVnf2HDwJCsyxGXxBAyqYKhl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859825; c=relaxed/simple;
	bh=BBoLmzgQFjNWPojT3b9qrfvfUGCgJ6jVJBKAFlr7QvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsGq8gRaVzcO5KHQszc7ge58ph5N1uy+3/R9J4YdMb8wi2/EX2GW5og2BzV7LA0onbDackRsgi9mfgq0QmNw7inUlycnoPPblfS6tG53zWfkYmBX+oYXU39QeAAiCdIfaOusaPnwy16e8ndCvlNT0ePRcRf+qU28ZfVVvu7qWf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hryn9ECz; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 7 Oct 2025 10:56:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759859821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbA3BYEyn+mxKLyud6a/KO/PAxmrcSw7SZSIkfU9Jro=;
	b=Hryn9ECzWmsNJwns1EtidDA4yExpGmfII0Nmt0EwJ6MNEYvgE1tvHAy9mvDQqEDXdkZJgq
	5jWCrMEh6pwZP8Bk6ppCt9sM4KaJCJXIqlvy/LENuBa1BR1zZT5auynWh/UoiRA8e2Jldz
	LzY5C/Nnfqy4n4x9eKaG0R1ZlQDTMhU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v4 4/4] mm: thp: reparent the split queue during memcg
 offline
Message-ID: <sdpkprxqf43emy5sttfzxnv4aemlarimdybdva4xyywyndajtx@zyvckuxgujzm>
References: <cover.1759510072.git.zhengqi.arch@bytedance.com>
 <a01588414c9911f2bc912fa87f181aa5620d89d4.1759510072.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a01588414c9911f2bc912fa87f181aa5620d89d4.1759510072.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Oct 04, 2025 at 12:53:18AM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Similar to list_lru, the split queue is relatively independent and does
> not need to be reparented along with objcg and LRU folios (holding
> objcg lock and lru lock). So let's apply the similar mechanism as list_lru
> to reparent the split queue separately when memcg is offine.
> 
> This is also a preparation for reparenting LRU folios.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/huge_mm.h |  4 +++
>  mm/huge_memory.c        | 54 +++++++++++++++++++++++++++++++++++++++++
>  mm/memcontrol.c         |  1 +
>  3 files changed, 59 insertions(+)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index f327d62fc9852..0c211dcbb0ec1 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -417,6 +417,9 @@ static inline int split_huge_page(struct page *page)
>  	return split_huge_page_to_list_to_order(page, NULL, ret);
>  }
>  void deferred_split_folio(struct folio *folio, bool partially_mapped);
> +#ifdef CONFIG_MEMCG
> +void reparent_deferred_split_queue(struct mem_cgroup *memcg);
> +#endif
>  
>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  		unsigned long address, bool freeze);
> @@ -611,6 +614,7 @@ static inline int try_folio_split(struct folio *folio, struct page *page,
>  }
>  
>  static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
> +static inline void reparent_deferred_split_queue(struct mem_cgroup *memcg) {}
>  #define split_huge_pmd(__vma, __pmd, __address)	\
>  	do { } while (0)
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 59ddebc9f3232..b5eea2091cdf6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1099,6 +1099,11 @@ static struct deferred_split *memcg_split_queue(int nid, struct mem_cgroup *memc
>  {
>  	return memcg ? &memcg->deferred_split_queue : split_queue_node(nid);
>  }
> +
> +static bool memcg_is_dying(struct mem_cgroup *memcg)
> +{
> +	return memcg ? css_is_dying(&memcg->css) : false;
> +}

Please move the above function to include/linux/memcontrol.h

With that, please add:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


