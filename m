Return-Path: <linux-kernel+bounces-823691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB20B87361
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE892A78A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5932B2FCBF1;
	Thu, 18 Sep 2025 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l4lyEqMa"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2902FCC0E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758233592; cv=none; b=Jp21q3k8NiW9Z7BrfvvsD/0+KIjCYBca08Rnx4ugu+r1c5+uFfloojI1iHEDyWBaHT1deHiRjfa6fwimMTkhLMxBSvhjBWb0JdcosKoy5aFOo/g/5ACYEmapjoEA9Yzxls+wp7jvYE1JC+8Kt+eXe70Qr7oAPgsmFMpHoS4hju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758233592; c=relaxed/simple;
	bh=epHYQD6T5du6rCp1uGHb2sWH06axx0QmxfC14swkiik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nLWIRRBOv+N4d5MnXemeqK8lvRPe4ZumKmCk0HyEPu2Fy3rznYA/pmjLdutnuS1iC8aMaKR/N29n0iDqPcw+bcQFp+XpvSu2hU6McYBK8Ka1g50kkZkosyJfXvNALxSxH1D/SluC2ZlNpEPApXvLycO48SMh5VDqAc8MwL1jpms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l4lyEqMa; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758233583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lo8pzMCC9mbCED52NwkyFdYylycaU5rZrxRgzH0GnhI=;
	b=l4lyEqMa99j1WPDgD2pxL0xZO6+pvCtZ0B4/46l3Xz7B5YUvF8OQA7jfjKMp0eAjTvSDWK
	gEBeBUYuLZFs8D6JvPRmuKDcvNs7JYun5oU2S4O1+TdN+JUEqQjhJGHf/b1kTXaU7XyY31
	peV+oVyT02ipeiVhAcOJnI6ez0TVr7c=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Frank van der Linden <fvdl@google.com>
Cc: akpm@linux-foundation.org,  muchun.song@linux.dev,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  hannes@cmpxchg.org,  david@redhat.com
Subject: Re: [RFC PATCH 00/12] CMA balancing
In-Reply-To: <CAPTztWYp2yPsdvFfMm6bVB-juwHM11zKAEty9q+J8gy5d-8=KQ@mail.gmail.com>
	(Frank van der Linden's message of "Wed, 17 Sep 2025 15:04:30 -0700")
References: <20250915195153.462039-1-fvdl@google.com>
	<7ia4ecs59a2b.fsf@castle.c.googlers.com>
	<CAPTztWYp2yPsdvFfMm6bVB-juwHM11zKAEty9q+J8gy5d-8=KQ@mail.gmail.com>
Date: Thu, 18 Sep 2025 22:12:54 +0000
Message-ID: <7ia4qzw3z9y1.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Frank van der Linden <fvdl@google.com> writes:

> On Tue, Sep 16, 2025 at 5:51=E2=80=AFPM Roman Gushchin <roman.gushchin@li=
nux.dev> wrote:
>>
>> Frank van der Linden <fvdl@google.com> writes:
>>
>> > This is an RFC on a solution to the long standing problem of OOMs
>> > occuring when the kernel runs out of space for unmovable allocations
>> > in the face of large amounts of CMA.
>> >
>> > Introduction
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>> > When there is a large amount of CMA (e.g. with hugetlb_cma), it is
>> > possible for the kernel to run out of space to get unmovable
>> > allocations from. This is because it cannot use the CMA area.
>> > If the issue is just that there is a large CMA area, and that
>> > there isn't enough space left, that can be considered a
>> > misconfigured system. However, there is a scenario in which
>> > things could have been dealt with better: if the non-CMA area
>> > also has movable allocations in it, and there are CMA pageblocks
>> > still available.
>> >
>> > The current mitigation for this issue is to start using CMA
>> > pageblocks for movable allocations first if the amount of
>> > free CMA pageblocks is more than 50% of the total amount
>> > of free memory in a zone. But that may not always work out,
>> > e.g. the system could easily run in to a scenario where
>> > long-lasting movable allocations are made first, which do
>> > not go to CMA before the 50% mark is reached. When the
>> > non-CMA area fills up, these will get in the way of the
>> > kernel's unmovable allocations, and OOMs might occur.
>> >
>> > Even always directing movable allocations to CMA first does
>> > not completely fix the issue. Take a scenario where there
>> > is a large amount of CMA through hugetlb_cma. All of that
>> > CMA has been taken up by 1G hugetlb pages. So, movable allocations
>> > end up in the non-CMA area. Now, the number of hugetlb
>> > pages in the pool is lowered, so some CMA becomes available.
>> > At the same time, increased system activity leads to more unmovable
>> > allocations. Since the movable allocations are still in the non-CMA
>> > area, these kernel allocations might still fail.
>> >
>> >
>> > Additionally, CMA areas are allocated at the bottom of the zone.
>> > There has been some discussion on this in the past. Originally,
>> > doing allocations from CMA was deemed something that was best
>> > avoided. The arguments were twofold:
>> >
>> > 1) cma_alloc needs to be quick and should not have to migrate a
>> >    lot of pages.
>> > 2) migration might fail, so the fewer pages it has to migrate
>> >    the better
>> >
>> > These arguments are why CMA is avoided (until the 50% limit is hit),
>> > and why CMA areas are allocated at the bottom of a zone. But
>> > compaction migrates memory from the bottom to the top of a zone.
>> > That means that compaction will actually end up migrating movable
>> > allocations out of CMA and in to non-CMA, making the issue of
>> > OOMing for unmovable allocations worse.
>> >
>> > Solution: CMA balancing
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>> > First, this patch set makes the 50% threshold configurable, which
>> > is useful in any case. vm.cma_first_limit is the percentage of
>> > free CMA, as part of the total amount of free memory in a zone,
>> > above which CMA will be used first for movable allocations. 0
>> > is always, 100 is never.
>> >
>> > Then, it creates an interface that allows for moving movable
>> > allocations from non-CMA to CMA. CMA areas opt in to taking part
>> > in this through a flag. Also, if the flag is set for a CMA area,
>> > it is allocated at the top of a zone instead of the bottom.
>>
>> Hm, what if we can teach the compaction code to start off the
>> beginning of the zone or end of cma zone(s) depending on the
>> current balance?
>>
>> The problem with placing the cma area at the end is that it might
>> significantly decrease the success rate of cma allocations
>> when it's racing with the background compaction, which is hard
>> to control. At least it was clearly so in my measurements several
>> years ago.
>
> Indeed, I saw your change that moved the CMA areas to the bottom of
> the zone for that reason. In my testing, I saw a slight uptick in
> cma_alloc failures for HugeTLB (due to migration failures), but it
> wasn't much at all. Also, our current usage scenario can deal with the
> occasional failure, so it was less of a concern. I can try to re-run
> some tests to see if I can gather some harder numbers on that - the
> problem is of course finding a test case that gives reproducible
> results.

It might heavily depend on which file system you're using.

>>
>>
>> > Lastly, the hugetlb_cma code was modified to try to migrate
>> > movable allocations from non-CMA to CMA when a hugetlb CMA
>> > page is freed. Only hugetlb CMA areas opt in to CMA balancing,
>> > behavior for all other CMA areas is unchanged.
>> >
>> > Discussion
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>> > This approach works when tested with a hugetlb_cma setup
>> > where a large number of 1G pages is active, but the number
>> > is sometimes reduced in exchange for larger non-hugetlb
>> > overhead.
>> >
>> > Arguments against this approach:
>> >
>> > * It's kind of heavy-handed. Since there is no easy way to
>> >   track the amount of movable allocations residing in non-CMA
>> >   pageblocks, it will likely end up scanning too much memory,
>> >   as it only knows the upper bound.
>> > * It should be more integrated with watermark handling in the
>> >   allocation slow path. Again, this would likely require
>> >   tracking the number of movable allocations in non-CMA
>> >   pageblocks.
>>
>> I think the problem is very real and the proposed approach looks
>> reasonable. But I also agree that it's heavy-handed. Doesn't feel
>> like "the final" solution :)
>>
>> I wonder if we can track the amount of free space outside of cma
>> and move pages out on reaching a certain low threshold?
>> And it can in theory be the part of the generic kswapd/reclaim code.
>
> I considered this, yes. The first problem is that there is no easy way
> to express the number that is "pages allocated with __GFP_MOVABLE in
> non-CMA pageblocks".  You can approximate pretty well by checking if
> they are on the LRU, I suppose.

Hm, but why do you need it? Even if there are movable pages outside of
cma, but there are no or little free pages, we can start (trying) moving
movable pages into cma, right?

>
> If you succeed in getting that number accurately, the next issue is
> defining the right threshold and when to apply them. E.g. at one point
> I had a change to skip CMA pageblocks for compaction if the target
> pageblock is non-CMA, and the threshold has been hit. I ended up
> dropping it, since this more special-case approach was better for our
> use case. But my idea at the time was to add it as a 3rd mechanism to
> try harder for allocations (compaction, reclaim, CMA balancing).

Agree, but I guess we can pick some magic number.

>
> It was something like:
>
> 1) Track movable allocations in non-CMA areas.
> 2) If the watermark for an unmovable allocation is below high, stop
> migrating things (through compaction) from CMA to non-CMA, and always
> start allocating from CMA first.
> 3) If the watermark is approaching low, don't try compaction if you
> know that CMA can be balanced, but do CMA balancing instead, in
> amounts that satisfy your needs
>
> One problem here is ping-ponging of memory. If you put CMA areas at
> the bottom of the zone, ompaction moves things one way, CMA balancing
> the other way.

Agree, it's a valid concern.

