Return-Path: <linux-kernel+bounces-819806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 202A2B7DE30
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DC9327730
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5A11E04AD;
	Wed, 17 Sep 2025 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ub44tfdh"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EBD258A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758070271; cv=none; b=FnaBNoPBf+PmRsGz061vrhI4AJNTSBjcrnY2apNOI1iaxiOVnHvc+PFV6MXZBOPPQ3jFfWGac4FGWeziRAd9oMQdTWvYfNrQfMnfH/3e91RmmfbkQu6hIXZtZYsclNqJ4OquZXhU55rSIhVgotfx4K6GepMgScX7/nesz/VgrTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758070271; c=relaxed/simple;
	bh=I178iPf2gJqEZ3xoO5xrQj9Z+pYuImVMTt5pDlH72nk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fDVCsYfJnCWvxVXNA1ePm2vpnWs2rzwXMrTG5elyoERyAxCGcjYHcSGgkr+xMC7AZ2ByMSJ7/TYsCn/xifTz7UeB1P2Jd8CFTdws9fMIciesM0WCmbR8P76m48/vN5lZMqP2XwmA1eMuMLw9AzbzbvQmnnMVBYjQbtpIncrdDII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ub44tfdh; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758070264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ix1AngQu9wwr1vHWjycL6FVEsvwg0DoG70fN3uSSsFM=;
	b=Ub44tfdhevd3WK2x+9vt8V4EzO2QrcDIolJ6Z+ed7sNktk32kP0Vc3BKJCJGSb4doSMY79
	5LMuLyNRneCDUwVIX/3QtKsuUZQfagEzWuTXGbQOXo+Wj/4H0g9bdG7NeF5yaYIRa3ujm2
	4SKJg6Gmo+CU4+HMQChS2dgTLDbr3g8=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Frank van der Linden <fvdl@google.com>
Cc: akpm@linux-foundation.org,  muchun.song@linux.dev,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  hannes@cmpxchg.org,  david@redhat.com
Subject: Re: [RFC PATCH 00/12] CMA balancing
In-Reply-To: <20250915195153.462039-1-fvdl@google.com> (Frank van der Linden's
	message of "Mon, 15 Sep 2025 19:51:41 +0000")
References: <20250915195153.462039-1-fvdl@google.com>
Date: Wed, 17 Sep 2025 00:50:20 +0000
Message-ID: <7ia4ecs59a2b.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Frank van der Linden <fvdl@google.com> writes:

> This is an RFC on a solution to the long standing problem of OOMs
> occuring when the kernel runs out of space for unmovable allocations
> in the face of large amounts of CMA.
>
> Introduction
> ============
>
> When there is a large amount of CMA (e.g. with hugetlb_cma), it is
> possible for the kernel to run out of space to get unmovable
> allocations from. This is because it cannot use the CMA area.
> If the issue is just that there is a large CMA area, and that
> there isn't enough space left, that can be considered a
> misconfigured system. However, there is a scenario in which
> things could have been dealt with better: if the non-CMA area
> also has movable allocations in it, and there are CMA pageblocks
> still available.
>
> The current mitigation for this issue is to start using CMA
> pageblocks for movable allocations first if the amount of
> free CMA pageblocks is more than 50% of the total amount
> of free memory in a zone. But that may not always work out,
> e.g. the system could easily run in to a scenario where
> long-lasting movable allocations are made first, which do
> not go to CMA before the 50% mark is reached. When the
> non-CMA area fills up, these will get in the way of the
> kernel's unmovable allocations, and OOMs might occur.
>
> Even always directing movable allocations to CMA first does
> not completely fix the issue. Take a scenario where there
> is a large amount of CMA through hugetlb_cma. All of that
> CMA has been taken up by 1G hugetlb pages. So, movable allocations
> end up in the non-CMA area. Now, the number of hugetlb 
> pages in the pool is lowered, so some CMA becomes available.
> At the same time, increased system activity leads to more unmovable
> allocations. Since the movable allocations are still in the non-CMA
> area, these kernel allocations might still fail.
>
>
> Additionally, CMA areas are allocated at the bottom of the zone.
> There has been some discussion on this in the past. Originally,
> doing allocations from CMA was deemed something that was best
> avoided. The arguments were twofold:
>
> 1) cma_alloc needs to be quick and should not have to migrate a
>    lot of pages.
> 2) migration might fail, so the fewer pages it has to migrate
>    the better
>
> These arguments are why CMA is avoided (until the 50% limit is hit),
> and why CMA areas are allocated at the bottom of a zone. But
> compaction migrates memory from the bottom to the top of a zone.
> That means that compaction will actually end up migrating movable
> allocations out of CMA and in to non-CMA, making the issue of
> OOMing for unmovable allocations worse.
>
> Solution: CMA balancing
> =======================
>
> First, this patch set makes the 50% threshold configurable, which
> is useful in any case. vm.cma_first_limit is the percentage of
> free CMA, as part of the total amount of free memory in a zone,
> above which CMA will be used first for movable allocations. 0 
> is always, 100 is never.
>
> Then, it creates an interface that allows for moving movable
> allocations from non-CMA to CMA. CMA areas opt in to taking part
> in this through a flag. Also, if the flag is set for a CMA area,
> it is allocated at the top of a zone instead of the bottom.

Hm, what if we can teach the compaction code to start off the
beginning of the zone or end of cma zone(s) depending on the
current balance?

The problem with placing the cma area at the end is that it might
significantly decrease the success rate of cma allocations
when it's racing with the background compaction, which is hard
to control. At least it was clearly so in my measurements several
years ago.


> Lastly, the hugetlb_cma code was modified to try to migrate
> movable allocations from non-CMA to CMA when a hugetlb CMA
> page is freed. Only hugetlb CMA areas opt in to CMA balancing,
> behavior for all other CMA areas is unchanged.
>
> Discussion
> ==========
>
> This approach works when tested with a hugetlb_cma setup
> where a large number of 1G pages is active, but the number
> is sometimes reduced in exchange for larger non-hugetlb
> overhead.
>
> Arguments against this approach:
>
> * It's kind of heavy-handed. Since there is no easy way to
>   track the amount of movable allocations residing in non-CMA
>   pageblocks, it will likely end up scanning too much memory,
>   as it only knows the upper bound.
> * It should be more integrated with watermark handling in the
>   allocation slow path. Again, this would likely require 
>   tracking the number of movable allocations in non-CMA
>   pageblocks.

I think the problem is very real and the proposed approach looks
reasonable. But I also agree that it's heavy-handed. Doesn't feel
like "the final" solution :)

I wonder if we can track the amount of free space outside of cma
and move pages out on reaching a certain low threshold?
And it can in theory be the part of the generic kswapd/reclaim code.

