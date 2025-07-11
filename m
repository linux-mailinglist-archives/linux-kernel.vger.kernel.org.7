Return-Path: <linux-kernel+bounces-728060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1CCB02332
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67CB1892730
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DFE2F198D;
	Fri, 11 Jul 2025 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PQ+6q71P"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BD019E82A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256559; cv=none; b=m/oQE0eWObauYrjBqhnaFaB9WdyWvw+XnHcfVD6Is5dQLx4EiXr2PoqOgt5roj3ivQ417fglDvvevQZMpUlfHd3vMygpIOgdIo2urxq9uJiqEsJccFhQ38IuqogVavuhPdmG7qKUNjyCLzbbmumFkHQKpYx7y0uinPsRgiA5nj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256559; c=relaxed/simple;
	bh=By+aOu6/h9lPpjtWeD7XIQONx6OKMRuvadlk7LOIevA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b5kHGDUJn2JZ6/WY7woVQgyrTzqFX3UZGwyw96gyUlFa9Tx3XclNag3vGP1a/sJpymbsi9CwmEV/lloaQYQIbdsT+4qiaEzc5U3Fo4Gv6+4q0vaZD6Pdg3T9kLVZKy4yiPMakh+8j1lxNrByBovi3GwMER6sQgAaup0K0nC915c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PQ+6q71P; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752256554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SSjeOZLyeiOPwpEsxQkp3Er7192dg8pTZOxPaQMpH9Y=;
	b=PQ+6q71PJESszXAu+siQctemYyi+5RKnvX4uq6+JhSZFtxzyzbQBW/maKSVbjpG+1CO+k2
	ssWAtZsEQALQkUVKtvpzvpUt6bn/b7fC52A4DUneV1wGPYy6zOQ8yEO5PKsmnYKWp+hvTs
	k7XGojQ1EA1kfSNGhAcUaKrSFA6GvO4=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
  Michal Hocko <mhocko@kernel.org>,  David Hildenbrand <david@redhat.com>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: skip lru_note_cost() when scanning only file or anon
In-Reply-To: <20250711172028.GA991@cmpxchg.org> (Johannes Weiner's message of
	"Fri, 11 Jul 2025 13:20:28 -0400")
References: <20250711155044.137652-1-roman.gushchin@linux.dev>
	<20250711172028.GA991@cmpxchg.org>
Date: Fri, 11 Jul 2025 10:55:48 -0700
Message-ID: <8734b2vcgr.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Johannes Weiner <hannes@cmpxchg.org> writes:

> On Fri, Jul 11, 2025 at 08:50:44AM -0700, Roman Gushchin wrote:
>> lru_note_cost() records relative cost of incurring io and cpu spent
>> on lru rotations, which is used to balance the pressure on file and
>> anon memory. The applied pressure is inversely proportional to the
>> recorded cost of reclaiming, but only within 2/3 of the range
>> (swappiness aside).
>> 
>> This is useful when both anon and file memory is reclaimable, however
>> in many cases it's not the case: e.g. there might be no swap,
>> proactive reclaim can target anon memory specifically,
>> the memory pressure can come from cgroup v1's memsw limit, etc.
>> In all these cases recording the cost will only bias all following
>> reclaim, also potentially outside of the scope of the original memcg.
>> 
>> So it's better to not record the cost if it comes from the initially
>> biased reclaim.
>> 
>> lru_note_cost() is a relatively expensive function, which traverses
>> the memcg tree up to the root and takes the lruvec lock on each level.
>> Overall it's responsible for about 50% of cycles spent on lruvec lock,
>> which might be a non-trivial number overall under heavy memory
>> pressure. So optimizing out a large number of lru_note_cost() calls
>> is also beneficial from the performance perspective.
>
> Does it actually help? It's under elevated pressure, when lru locks
> are the most contended, that we also usually scan both lists.

It does, but it's mostly about !swap or memsw limit case.
It's also mostly pronounced only during high memory pressure
when there are many rotations.

And it's pretty significant in our case: I'm actually trying to address
a production regression caused by commit 0538a82c39e9 ("mm: vmscan: make
rotations a secondary factor in balancing anon vs file"), which
added another lru_note_cost() call.


> The caveat with this patch is that, aside from the static noswap
> scenario, modes can switch back and forth abruptly or even overlap.
>
> So if you leave a pressure scenario and go back to cache trimming, you
> will no longer age the cost information anymore. The next spike could
> be starting out with potentially quite stale information.
>
> Or say proactive reclaim recently already targeted anon, and there
> were rotations and pageouts; that would be useful data for a reactive
> reclaimer doing work at around the same time, or shortly thereafter.

Agree, but at the same time it's possible to come up with the scenario
when it's not good.
  A
 / \
B  C  memory.max=X
  / \
 D   E

Let's say we have a cgroup structure like this, we apply a lot
of proactive anon pressure on E, then the pressure from on D from
C's limit will be biased towards file without a good reason.

Or as in my case, if a cgroup has memory.memsw.limit set and is
thrashing, does it makes sense to bias the rest of the system
into anon reclaim? The recorded cost can really large.

>
> So for everything but the static noswap case, the patch makes me
> nervous. And I'm not sure it actually helps in the cases where it
> would matter the most.

I understand, but do you think it's acceptable with some additional
conditions: e.g. narrow it down to only very high scanning priorities?
Or !sc.may_swap case?

In the end, we have the following code in get_scan_count(), so at
least on priority 0 we ignore all costs anyway.
        if (!sc->priority && swappiness) {
                scan_balance = SCAN_EQUAL;
                goto out;
        }

Wdyt?

>
> It might make more sense to look into the cost (ha) of the cost
> recording itself. Can we turn it into a vmstat item? That would make
> it lockless, would get rstat batching up the cgroup tree etc. This
> doesn't need to be 100% precise and race free after all.

Idk, maybe yes, but rstat flushing was a source of the issues as well
and now it's mostly ratelimited, so I'm concerned that because of that
we'll have sudden changes in the reclaim behavior every 2 seconds.

