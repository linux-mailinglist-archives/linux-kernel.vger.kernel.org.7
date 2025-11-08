Return-Path: <linux-kernel+bounces-891184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F8DC421A1
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693383BC299
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7AC20330;
	Sat,  8 Nov 2025 00:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rKOWtDUy"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C46179A3
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 00:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762560581; cv=none; b=r02G5hi1uGMC/PtR6SyKk52r9QQDICd+UQSi+BdqFx0qEvLqpmYAIyqLo9qjJI7OQrtu6JhplDCbWLm5pBWDQROMdhKy9ZZguEwml0PmaRV3sLmwT52+vP78KjZp9VLsOXOWLePEbxQtJysP2YuurpqX5/wKqceN6s6qCNmzLsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762560581; c=relaxed/simple;
	bh=UI5/FWgrTaYVfb7rjEuyZmPuidDv2VQWUruwwfdvZhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtSvD+k8DW2UoK6iYZw+o3qynKXVfEhZ/FPL5mMwydLHqlvj/ey26vvEcp8yDvwq8ufMogY8fgtrrqjbnoLxqcqoim3bCJRl6CQZWlbtdJhbAHIZbXK40nZsvn34DwAONqL6n5Gf8U7uOOl/d/X7JryoVBCc2TN/jMCG+SymouM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rKOWtDUy; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Nov 2025 16:09:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762560577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBJT4/z1hj67jfdfBO/RFvyIJnHDFcqSunY1R03npJU=;
	b=rKOWtDUyluopFvaWjD5VtJGiw3uuJLeS1AQdApXn0Ysp7Luz9ois3pFwBBZdFco5dngJvf
	2b5L53OquL+RROkxnHgq05LTzGedjVJbLWtXE3+/olsb/3vEJ3D56ZOUxWWMc7K07iiga7
	pCCV5h2HAIeHEIH1g53CpQ/NGpNZXHA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/vmscan: Add retry logic for cgroups with
 memory.low in kswapd
Message-ID: <v56ql5ptxyx4x2j7nffznhs3osjghkoj3dlkfbpohotuof3yiv@gf74er4pf34v>
References: <20251014081850.65379-1-jiayuan.chen@linux.dev>
 <aO4Y35l12Cav-xr4@tiehlicka>
 <a6cd4eb712f3b9f8898e9a2e511b397e8dc397fc@linux.dev>
 <aPEGDwiA_LhuLZmX@tiehlicka>
 <46df65477e0580d350e6e14fea5e68aee6a2832b@linux.dev>
 <aPE84XfToVH4eAbs@tiehlicka>
 <db4d9e73e6a70033da561ed88aef32c1ebe411dd@linux.dev>
 <aQ3yhmsT2NHeNwLi@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQ3yhmsT2NHeNwLi@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 07, 2025 at 02:22:14PM +0100, Michal Hocko wrote:
> Sorry for late reply.
> 
> On Mon 20-10-25 10:11:23, Jiayuan Chen wrote:
> [...]
> > To provide more context about our specific setup:
> > 
> > 1. The memory.low values set on host pods are actually quite large,
> >    some pods are set to 10GB, others to 20GB, etc.
> > 2. Since most pods have memory limits configured, each time kswapd
> >    is woken up, if a pod's memory usage hasn't exceeded its own
> >    memory.low, its memory won't be reclaimed.
> > 3. When applications start up, rapidly consume memory, or experience
> >    network traffic bursts, the kernel reaches steal_suitable_fallback(),
> >    which sets watermark_boost and subsequently wakes kswapd.
> > 4. In the core logic of kswapd thread (balance_pgdat()), when reclaim is
> >    triggered by watermark_boost, the maximum priority is 10. Higher priority
> >    values mean less aggressive LRU scanning, which can result in no pages
> >    being reclaimed during a single scan cycle:
> > 
> > if (nr_boost_reclaim && sc.priority == DEF_PRIORITY - 2)
> >     raise_priority = false;
> > 
> > 5. This eventually causes pgdat->kswapd_failures to continuously accumulate,
> >    exceeding MAX_RECLAIM_RETRIES, and consequently kswapd stops working.
> >    At this point, the system's available memory is still significantly above
> >    the high watermark—it's inappropriate for kswapd to stop under these
> >    conditions.
> > 
> > The final observable issue is that a brief period of rapid memory allocation
> > causes kswapd to stop running, ultimately triggering direct reclaim and
> > making the applications unresponsive.
> 
> This to me sounds like something to be addressed in the watermark
> boosting code. I do not think we should be breaching low limit for that
> (opportunistic) reclaim.

Jiayuan already posted v2 with different approach. We can move the
discussion there.

http://lore.kernel.org/20251024022711.382238-1-jiayuan.chen@linux.dev

