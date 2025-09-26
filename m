Return-Path: <linux-kernel+bounces-834478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2E6BA4C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25221BC2840
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D86243371;
	Fri, 26 Sep 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/8sV+cG"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B7E56A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758908038; cv=none; b=LaZOxNehhLOW+xL037+hyBKoJk7J/IT9ogJmV+A+faJTMC6DD4iaCbcJ4McFn/527pIysYyNa0pRtc9+GTVWK88ZMwzQS5UHBIbw411MuQYacNJysTD+gsTXpngER9SxOTv3pl82Y4S1iJhNMSLavYgl/3BDuPN1An5f0KZCe9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758908038; c=relaxed/simple;
	bh=QnEH1PqCJqvixx6GhU11x7qnjXX+fv7vnj43LqXwtSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMR7105iWbvgCXqMRlON6gdbMvd7Ce5c6ioBbvwumt5qArDIbtvkmNxKSnPGcFygIZTcl3I5Tj4cx+PgLS8zcyICJNODO+2HkRrHEXGw6W6tyqeIXECxf4Gr/Ox8dSWvGijMONXtLk2DZUafcnOuy8FwTzfKRRqfzORFo7S9E7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/8sV+cG; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-72ce9790aceso24169847b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758908035; x=1759512835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tIyjN68caZZj15yGUoQsD17H0Ww8dCvVPZYwpO6gf4=;
        b=f/8sV+cGJCnaidfa1puFXk3LWLgcCEB+Ds/B+cc0nRMriNxXFT9M96rJEZhuf7nwZC
         in9nWLlrPePbWNPJbFB79WivNhpbFYYHIpovYc+VfxUpbRgKTGU+Nfody/SlClxYWBY7
         gyJEPhg90tEN+rsXixyWgGeyNcgPuOnpeAManR+4UUPA5BrWuAMsHHharGy0g0MJovBX
         puSo9BgXQ1aU7mHwVrF7nGT8ESR4i/bVb91nXYcb6ZcAx6KQN9jBusy5m8nKzbWdKqNp
         f4ae+1uPVZiY8zOPHVb7EiwN57oJzRW6nNUr6RWGkMWq+jfrdKNOWTPrVd+fKmPkkZSk
         kmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758908035; x=1759512835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tIyjN68caZZj15yGUoQsD17H0Ww8dCvVPZYwpO6gf4=;
        b=ca0sUfalMopIb4xBm8AGjv9tL/dNB5aW0ZKjL0n4pPO5mgOLfQSSjSakcVYlYZl5Xi
         whq48E+WjxhzBkNtyyq0MbA50jI0fvGVJQtrtUmhTpZsEwm2YnM3XIyTMXarlR3rsFrb
         jF+Oxr3AvgESx/RbxNE45TF2W5Yk1Uyh9HAdBLUn2dt6StwvWHNHh4Ia5oHgrzYZEDMe
         AoqcOftLDzhtM+3qG/absPQfF9KFJv95TbuV3+dqj5p2Feejon5EvQjBJggtSLlJ5jkC
         xByOcl0bbg2sn+N+QM15nDJk9ckVOVUYS/Y1TBeNe/bC1+T2q3kQBfVh0D6yjSzYTiYB
         yQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCXRskL/46frvXSnslVYotBZo12H9ZTI5bPqz5mugdfFjO/P+9+Qxo+lbAQKqLPZcUWplwXZFLbYfBVGCwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1P/1onQYTA0BgSh4omudbhunFGEd4lHjlzzqdtH5Y0JYW+zYi
	VJufFFS0j1ldJ3s6zWvJaFD/p8/QMAFdR8tmkOMKflWhJf2JqyPbKL2N25FM4g==
X-Gm-Gg: ASbGncsP/DL6WtIFO03jrR8nsL+aVnpQRXW9wNknQcbyQhU2UTWzWUH/KxE54IV4djs
	QwN/Y92a+SPbzb2mdCoSyU/c5YSqetYSDTho8dclUvaO9x7qnlNiFDRw40vkiEbHG01gm1Dp62f
	PUAsIOEo3hvrGnMpS1m5Lm+TQNscNPEyi8zIPzSEfCwahzaysqKoV/LoerHZ5S6sTIMOJCibF0w
	AcS4TqQXTRdwP2gmu90q59P6LFN8+iTJ1lRkVISFbf0MZ1s4lMofMjk6k0i03M4Uaz8UjNHTSDg
	yeuSr2lFpKdfoLOnfcGyo+KUR8g6cXTa080rzwZ4Oerlk8SRAVxNlhBlXR6OgOuVtI1pgxQnvhZ
	SZ1pUNmsYi+SXN+X3qqaPYYcwCM5ajEsQ3dE9SG+3uvF+YxJiwSUvaA==
X-Google-Smtp-Source: AGHT+IEubc4JJpGRwQRxurB+nRlYGoZoQ9jmMPYR0K74KyC8/v0jMkfTY/PqqLCskN8kN7mzuHKHZg==
X-Received: by 2002:a05:690c:6087:b0:734:e6d4:acce with SMTP id 00721157ae682-763f9e75c51mr77045277b3.3.1758908034859;
        Fri, 26 Sep 2025 10:33:54 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765aebc1503sm12538887b3.0.2025.09.26.10.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 10:33:54 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in drain_pages_zone
Date: Fri, 26 Sep 2025 10:33:52 -0700
Message-ID: <20250926173353.2850266-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <DD2W2YFEPC3L.250WBJ4E5EM4K@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 26 Sep 2025 16:57:16 +0000 Brendan Jackman <jackmanb@google.com> wrote:

> On Fri Sep 26, 2025 at 3:48 PM UTC, Joshua Hahn wrote:
> > On Fri, 26 Sep 2025 14:01:43 +0000 Brendan Jackman <jackmanb@google.com> wrote:
> >> Hey Joshua, do you know why pcp->batch is a factor here at all? Until
> >> now I never really noticed it. I thought that this field was a kinda
> >> dynamic auto-tuning where we try to make the pcplists a more aggressive
> >> cache when they're being used a lot and then shrink them down when the
> >> allocator is under less load. But I don't have a good intuition for why
> >> that's relevant to drain_pages_zone(). Something to do with the amount
> >> of lock contention we expect?
> >
> > From my understanding, pcp->batch is a value that can be used to batch
> > both allocation and freeing operations. For instance, drain_zone_pages
> > uses pcp->batch to ensure that we don't free too many pages at once,
> > which would lead to things like lock contention (I will address the
> > similarity between drain_zone_pages and drain_pages_zone at the end).
> >
> > As for the purpose of batch and how its value is determined, I got my
> > understanding from this comment in zone_batchsize:
> >
> > 	 * ... The batch
> > 	 * size is striking a balance between allocation latency
> > 	 * and zone lock contention.

Hi Brendan, thanks for your feedback!

> > And based on this comment, I think a symmetric argument can be made for
> > freeing by just s/allocation latency/freeing latency above. My understanding
> > was that if we are allocating at a higher factor, we should also be freeing
> > at a higher factor to clean up those allocations faster as well, and it seems
> > like this is reflected in decay_pcp_high, where a higher batch means we
> > lower pcp->high to try and free up more pages.
> 
> Hmm thanks, now I'm reading it again I think I was not clear in my head
> on how ->batch is used. It's more like a kinda static "batchiness"
> parameter that informs the dynamic scaling stuff rather than being an
> output of it, in that context it's less surprising that the drain code
> cares about it.

It also took me a while to understand how all of the pcp high, count,
batch, etc. tuning worked. But yes, from my understanding, batch is used
as the parameter that helps inform things like what value to decay
pcp->high to, as well as how many pages to free, how many pages to leave
remaining in the pcp, among other operations. 

> > Please let me know if my understanding of this area is incorrect here!
> >  
> >> Unless I'm just being stupid here, maybe a chance to add commentary.
> >
> > I can definitely add some more context in the next version for this patch.
> > Actually, you are right -- reading back in my patch description, I've
> > motivated why we want batching, but not why pcp->batch is a good candidate
> > for this value. I'll definitely go back and clean it up!
> >
> >> >
> >> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> >> > ---
> >> >  mm/page_alloc.c | 3 +--
> >> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >> >
> >> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> > index 77e7d9a5f149..b861b647f184 100644
> >> > --- a/mm/page_alloc.c
> >> > +++ b/mm/page_alloc.c
> >> > @@ -2623,8 +2623,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
> >> >  		spin_lock(&pcp->lock);
> >> >  		count = pcp->count;
> >> >  		if (count) {
> >> > -			int to_drain = min(count,
> >> > -				pcp->batch << CONFIG_PCP_BATCH_SCALE_MAX);
> >> > +			int to_drain = min(count, pcp->batch);
> >> 
> >> We actually don't need the min() here as free_pcppages_bulk() does that
> >> anyway. Not really related to the commit but maybe worth tidying that
> >> up.
> >
> > Please correct me if I am missing something, but I think we still need the
> > min() here, since it takes the min of count and pcp->batch, while the
> > min in free_pcppages_bulk takes the min of the above result and pcp->count.
> 
> Hold on, what's the difference between count and pcp->count here?

Hm, sorry. I think I also confused myself here. count is indeed pcp->count.
So what is basically happening here is
	min3(pcp->count, pcp->batch, pcp->count)

... and you are absolutely right that one instance of pcp->count is
unnecessary here. So it seems like the solution is just to pass
pcp->batch to free_pcppages_bulk, and that way we can have only one
instance of pcp->count!

I think I confused myself because I thought you meant we don't need the
pcp->batch portion of this min(), not the pcp->count!

With all of this said, as noted in my conversation with Christoph I think
this patch may be unnecessary since this is not a source of contention
or lock monopoly anyways (in fact, it may even be harmful to batch it
to a lower value here).

> > From what I can understand, the goal of the min() in free_pcppages_bulk
> > is to ensure that we don't try to free more pages than exist in the pcp
> > (hence the min with count), while the goal of my min() is to not free
> > too many pages at once.
> 
> Yeah, I think we're in agreement about the intent, it's just that one of
> us is misreading the code (and I think it might be me, I will probably
> be more certain on Monday!).

It was me : -)

Thank you for taking the time to review this. I hope you have a great day!
Joshua

