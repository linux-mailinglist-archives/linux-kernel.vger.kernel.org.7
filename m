Return-Path: <linux-kernel+bounces-833357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F40BA1C41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2551C278E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE5D262FE9;
	Thu, 25 Sep 2025 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nExaS2C6"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A840E212B0A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758838540; cv=none; b=JMXyLBYXLFnpu1RcSwYTyU59TkdukzPn2xJVXHY3vw5lT85C/DG5DdbkH53TrjCyQ1alXktaAMAh86Jy+gLS+nKz1bNVwbAFz5d6tqadxkUzUC9MhSIz/avp60sX0Xdk3ZUYZA3bbpN4teAijmXn7inTdvrWg9i1/KBYr+oK8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758838540; c=relaxed/simple;
	bh=zEzRByDzB6qYFhUQxoE4VuCeXHBK+6WOutayeAOdY2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5TLM/4XxwwOM6GEw6RN3KCzr2Y+H4sLnZ8/elp86mYzYRM9RNboZtPp1/cPm0mNylMy3RJTn8sNUZ4Dn01nfO20b14h/bod4xxIVrbLBA68Sxu/SIFqm4+3yt3R3SuqinZO74gvzdKEAb2MZc2OW0srbFkTTiyauZziQDRxWNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nExaS2C6; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Sep 2025 15:15:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758838535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+bbO6SaS0KRxab+lWSDdoC0WeKs4PytoWV0GEgq6Tc=;
	b=nExaS2C6Dcgxn4eNrjxVd//6ySpTajLoWfisBDkQtd1gKwEcoBmyBs8d0B45hZNvfkAHVT
	KarzIBsSkiP9PK+tND5YDgP7MySL5zFSP5y+cdhaCd4Lzkhsuu+go4bfuYXrcjqqUvPait
	I4XbqyYwMH3IUKyzloJRC0B5mCs6OCE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, lorenzo.stoakes@oracle.com, 
	harry.yoo@oracle.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: thp: reparent the split queue during memcg
 offline
Message-ID: <tyl5nag4exta7mmxejhzd5xduulfy5pjzde4mpklscqoygkaso@zdyadmle3wjj>
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <55370bda7b2df617033ac12116c1712144bb7591.1758618527.git.zhengqi.arch@bytedance.com>
 <b041b58d-b0e4-4a01-a459-5449c232c437@redhat.com>
 <46da5d33-20d5-4b32-bca5-466474424178@bytedance.com>
 <39f22c1a-705e-4e76-919a-2ca99d1ed7d6@redhat.com>
 <BF7CAAA2-E42B-4D90-8E35-C5936596D4EB@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BF7CAAA2-E42B-4D90-8E35-C5936596D4EB@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 25, 2025 at 03:49:52PM -0400, Zi Yan wrote:
> On 25 Sep 2025, at 15:35, David Hildenbrand wrote:
> 
> > On 25.09.25 08:11, Qi Zheng wrote:
> >> Hi David,
> >
> > Hi :)
> >
> > [...]
> >
> >>>> +++ b/include/linux/mmzone.h
> >>>> @@ -1346,6 +1346,7 @@ struct deferred_split {
> >>>>        spinlock_t split_queue_lock;
> >>>>        struct list_head split_queue;
> >>>>        unsigned long split_queue_len;
> >>>> +    bool is_dying;
> >>>
> >>> It's a bit weird to query whether the "struct deferred_split" is dying.
> >>> Shouldn't this be a memcg property? (and in particular, not exist for
> >>
> >> There is indeed a CSS_DYING flag. But we must modify 'is_dying' under
> >> the protection of the split_queue_lock, otherwise the folio may be added
> >> back to the deferred_split of child memcg.
> >
> > Is there no way to reuse the existing mechanisms, and find a way to have the shrinker / queue locking sync against that?
> >
> > There is also the offline_css() function where we clear CSS_ONLINE. But it happens after calling ss->css_offline(css);
> 
> I see CSS_DYING will be set by kill_css() before offline_css() is called.
> Probably the code can check CSS_DYING instead.
> 
> >
> > Being able to query "is the memcg going offline" and having a way to sync against that would be probably cleanest.
> 
> So basically, something like:
> 1. at folio_split_queue_lock*() time, get folio’s memcg or
>    its parent memcg until there is no CSS_DYING set or CSS_ONLINE is set.
> 2. return the associated deferred_split_queue.
> 

Yes, css_is_dying() can be used but please note that there is a rcu
grace period between setting CSS_DYING and clearing CSS_ONLINE (i.e.
reparenting deferred split queue) and during that period the deferred
split THPs of the dying memcg will be hidden from shrinkers (which
might be fine).

