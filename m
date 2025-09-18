Return-Path: <linux-kernel+bounces-803804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC0B46596
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01504A035D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAADF2F1FF5;
	Fri,  5 Sep 2025 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h3ahOOnk"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B5315D5F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108016; cv=none; b=HvEl9DxQBXWSGiGp6gvlTwC7RD8sRRaV+H/5Ks1Yk13IvpOkaj0ybk2tGuTes/2fKo2XQfVK14G+MXU8fhOjSjZux5iUws0DsPxYBk3T6WWuoKmo4MCVwbNF6ATutOqbiR9ZCI6mxcL7HP7q8IjbQKWT3riXTV93kvcgavMgN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108016; c=relaxed/simple;
	bh=cM/sC7g+vP43k3NeMR6pWqq6H0KzVlXEAKAVU0GkdsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSI/hsLql/zhNs+/ocEKf/0nSGqM1BAeA/OTXmS1BJzKXZUSre1061pPHWw47K0KEw28Uj8mjMdjvLQUGTpAILBEgl8oRP+/BW9zSPmS4uGu9HmvpMlzSpcFnVj4HgxUA+L2VJVm9SqHofqd3XEgWQGTZwU/BhKqs4HlmkFoMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h3ahOOnk; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Sep 2025 14:33:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757108002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QwCCUd0KTHgYFr0j+O9LFcsWubnSBozHvxaBHLHATR4=;
	b=h3ahOOnk/F0MmUrnwBj0pv+WS92VUhpUcjg9AF/33EvQBSOR10RVaCo6g6sKvHPZ7RxQiR
	ossZ/zceuY6LBcRxgB1y3V/V+5V4ZIXr9lLQmuk9MmkA2Gmipmt8kzFJybjnnxAq+gq4kj
	1PBirCUf/vYTfpvlbNyxekDm4CIgA8c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Peilin Ye <yepeilin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <ukh4fh3xsahsff62siwgsa3o5k7mjv3xs6j3u2ymdkvgpzagqf@jfrd7uwbacld>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
 <aLtMrlSDP7M5GZ27@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLtMrlSDP7M5GZ27@google.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 05, 2025 at 08:48:46PM +0000, Peilin Ye wrote:
> On Fri, Sep 05, 2025 at 01:16:06PM -0700, Shakeel Butt wrote:
> > Generally memcg charging is allowed from all the contexts including NMI
> > where even spinning on spinlock can cause locking issues. However one
> > call chain was missed during the addition of memcg charging from any
> > context support. That is try_charge_memcg() -> memcg_memory_event() ->
> > cgroup_file_notify().
> > 
> > The possible function call tree under cgroup_file_notify() can acquire
> > many different spin locks in spinning mode. Some of them are
> > cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> > just skip cgroup_file_notify() from memcg charging if the context does
> > not allow spinning.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Tested-by: Peilin Ye <yepeilin@google.com>

Thanks Peilin. When you post the official patch for __GFP_HIGH in
__bpf_async_init(), please add a comment on why __GFP_HIGH is used
instead of GFP_ATOMIC.

> 
> The repro described in [1] no longer triggers locking issues after
> applying this patch and making __bpf_async_init() use __GFP_HIGH
> instead of GFP_ATOMIC:
> 
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1275,7 +1275,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
>         }
> 
>         /* allocate hrtimer via map_kmalloc to use memcg accounting */
> -       cb = bpf_map_kmalloc_node(map, size, GFP_ATOMIC, map->numa_node);
> +       cb = bpf_map_kmalloc_node(map, size, __GFP_HIGH, map->numa_node);
>         if (!cb) {
>                 ret = -ENOMEM;
>                 goto out;
> 
> [1] https://lore.kernel.org/bpf/20250905061919.439648-1-yepeilin@google.com/#t
> 
> Thanks,
> Peilin Ye
> 

