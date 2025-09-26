Return-Path: <linux-kernel+bounces-834389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B98BA498D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BACA4A6F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5E525A34F;
	Fri, 26 Sep 2025 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="CNm+PbEE"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08AC1E7C2D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903697; cv=none; b=T3NtLOEWNUaFaGPn7pUGWoyJGDkF46/ZvjgWAedxgqtzVQNks47QmiZwGMN37IY16kYVK0NVNg5mjCVShTZ3a0LepKxuEDExhftktbhyazXlzxoRyf5olC8OhOaVVtxjhRMSZ1Cw3b37gcwgHqaHZJwOnXEvdujHvTM3aDmhsak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903697; c=relaxed/simple;
	bh=i37nP5Fsob6v27s2uWqZghUanMjCFkgfqQelus7jYZk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cuyNnhjAWzPM9em2Q4MeHwbf4gHfydCg16FSfTjf3g/p0QhzjEJhDNwU4prc+O63s3Mf759ZQlwNJMOZAVYfVotB9nzAE613woqa+o5EAVx41UpqWPr130U+ZZ+GecmWSBGnmC/mH4tRvMq8t9bWiRC9lhVUNepsRLlosQPuVrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=CNm+PbEE; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1758903689;
	bh=i37nP5Fsob6v27s2uWqZghUanMjCFkgfqQelus7jYZk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=CNm+PbEEeiWQMTxOz2g7X7Au3srI3fYV/lCulXVwtRi05x++a4eF8ooa+ce/5xE7g
	 E9c9TU3m9EGg1Pbf4ecSNQ0MvpmA5cPENTB4M4Tv+X19WgwsqZE/99sPQs5do3TCxO
	 lqQoJCT7a6lUS7J6HoRAN4xbqW/8AZbxkI6Xp1DM=
Received: by gentwo.org (Postfix, from userid 1003)
	id A72E0402AD; Fri, 26 Sep 2025 09:21:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id A5BD44028E;
	Fri, 26 Sep 2025 09:21:29 -0700 (PDT)
Date: Fri, 26 Sep 2025 09:21:29 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Johannes Weiner <hannes@cmpxchg.org>, Chris Mason <clm@fb.com>, 
    Kiryl Shutsemau <kirill@shutemov.name>, 
    Brendan Jackman <jackmanb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
    Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    kernel-team@meta.com
Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in
 drain_pages_zone
In-Reply-To: <20250925184446.200563-1-joshua.hahnjy@gmail.com>
Message-ID: <567be36f-d4ef-e5bc-e11c-3718272d3dfe@gentwo.org>
References: <20250925184446.200563-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 25 Sep 2025, Joshua Hahn wrote:

> > So we need an explanation as to why there is such high contention on the
> > lock first before changing the logic here.
> >
> > The current logic seems to be designed to prevent the lock contention you
> > are seeing.
>
> This is true, but my concern was mostly with the value that is being used
> for the batching (2048 seems too high). But as I explain below, it seems
> like the min(2048, count) operation is a no-op anyways, since it is never
> called with count > 1000 (at least from the benchmarks that I was running,
> on my machine).


The problem is that you likely increase zone lock contention with a
reduced batch size.

Actually that there is a lock in the pcp structure is weird and causes
cacheline bouncing on such hot paths. Access should be only from the cpu
that owns this structure. Remote cleaning (if needed) can be triggered via
IPIs.

This is the way it used to be and the way it was tested for high core
counts years ago.

You seem to run 176 cores here so its similar to what we tested way back
when. If all cores are accessing the pcp structure then you have
significant cacheline bouncing. Removing the lock and going back to the
IPI solution would likely remove the problem.

The cachelines of the allocator per cpu structures are usually very hot
and should only be touched in rare circumstances from other cpus.

Having a loop over all processors accessing all the hot percpus structurs
is likely causing significant performance issues and therefore the issues
that you are seeing here.




