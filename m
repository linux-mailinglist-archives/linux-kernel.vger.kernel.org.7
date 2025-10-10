Return-Path: <linux-kernel+bounces-848433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE6DBCDBF8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A2BA3557F6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96752F83A7;
	Fri, 10 Oct 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4bP4CL1"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDC82ED854
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109245; cv=none; b=jCn9UVN/y6b2OyGgIy5OiY2roRsE9RsNsqXr+XYwdwO+qoC4CrSYvX+6jItMwWHtk47N39pU9Et8DH6q1dSqFyeqTLz1vUGDxdu/GGslakqxzdzYnQzuCe+JCamrW0ao0AUyeeeR3XiXtqMHPVntTHTBavS8B/y0FhV54JZ+Ffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109245; c=relaxed/simple;
	bh=wSMs/dIw+1bMGmkFw0Dnrxk8TkOD9aMhrR7BfB4aDKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTSelI1SsECezf/Q/9aQqy1RFpceT/1K3hVeiSow8pGM1jGnmyn9qhiuSPaXn+piqm5WKSLUe6B5/qrKy1UOWXvprjKnrC2qrO/hPvbX1W+pcW4qrs7XuPuvK4dZtMKP1ihHm/b8N0xLdwDenBTI1/Ffv1PSqRRHZFR4Pxd1VYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4bP4CL1; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d60504bf8so20989947b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760109242; x=1760714042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tu3w7uzl84l8Ft0YZbH5YNQMm501F7O/lzUqK1Lwx90=;
        b=F4bP4CL1xlc5mjrnWS2XEO+tzn+Mm9Vu8whnMeJffzz/n+M7ZRCSzPoW4ui9+KT8ak
         KH5CX3YGSkaYedDEX40bI/pZkEJt+SDUeJH+Ylof4C7tnp4S7ZWqUO0+qE97dsAdaOB3
         KgoIvSo+KlW7HU7W4B3RLQiWPfdRTHqY52VguDDtkqxBG/p1JIRMlX6t/oQcI+yDbtvU
         1O4awftnn7EX05MGM8kRMFCpIdgz0xur/gye0LAnTpk6gy4LEQHjFrHG3AHRCSo6doHx
         9BPHFVH+4xLgE4402bQjsLAE3RDfCriocKRq9ASfxMt9nbbwEAtIXW4TNXk904B5uUJ4
         F5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760109242; x=1760714042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tu3w7uzl84l8Ft0YZbH5YNQMm501F7O/lzUqK1Lwx90=;
        b=G0SUFz5TEiYZ05shoHWq6Mdqd5qheqJS+qIxc/mCOFERIsonmc6adSpyMTn0a9WhFu
         lPS5IvqkGkrtTPrR99+Pc+C8HBz+xOd4Rcl2NR52sE3Jpql4VisjWYid4AR+H6tyERZP
         UPlVvxNNghtBPopZqoF9FHkNg0LHASzgc8L3QsBB42sLGeVb5ZoI/7uBikFdgD1nrZ4y
         DusxVHMDld7DWhgqIiIMom1XcZCVIiYRRPIqZwq3YzToDc/b0avMnCE8SGaudhqhn9d+
         Kip+WBI1QpyO6UUEzL9snFd+Ve0ZpROXLyv4iXXa+wx2rcQNFXQcpQDKyPxEHb7ItccR
         HyIA==
X-Forwarded-Encrypted: i=1; AJvYcCXINGTiBZTC02Mbi0wVeX1SknBTswOQ24KRcmKsrb4ZBs6K9nsIXw8eCh8BWoc+R/MRLmjAEgkjsVDzF9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAbOLNqOPvipXs7/qolsLES3u0cVZFOuHuERumJKE852rAGWUX
	Rk5+gk+Sug6XaHLEj5NDFOE6HeRgS3Z5SWKuvvkxHuocyECjeLiPuJI6
X-Gm-Gg: ASbGncvvyWaWqu/HNpc/t83YwRowp3LzEpfAjTb/T9WMlxYEKEtFRCSTYmb6UlF5mmT
	SfBskuG5jwJIEOPRtYlJ9fygM9js5QyQYXwwNb/8YU5ltxz3xqnkye/CetZxtmolGSFJoWPeZPc
	E2AFBcFq+vIf9agKLhFkm/QzfOWYC1+sIaaAHpN/3IPKsYW3qJFsN7XzghhUTUHmg3uMFQPaZOL
	mAoch9VG3JWknpvKry+41qaRrwIrRPM1EdltsRezksh6bj93arnSiimDI5/4/Nc0PdqczCLtcR9
	EcI9SpInqc1L6CjSbxliOOtEmzSOfLN/keO7mAQbpe4yLoOfWha0jF0E2qEoJZcV2QBW0GdFcNO
	gSRyCY8A4JUAfsOPRNVHene5/Du/ZU0andHcb5SJUDla8npfY3vXutpsnPNzdg0LEUycGBNAHam
	ZWy1qkU3zDLa3j/9U5tg==
X-Google-Smtp-Source: AGHT+IGl9qnBMei/PCnRuefDn/nGk1brpz0LjP5GS9OBntxd0TvfpQuY0J02WWnj0+QmTUzyq7Q1Zg==
X-Received: by 2002:a05:690c:a083:10b0:781:64f:2b3e with SMTP id 00721157ae682-781064f390dmr37402917b3.64.1760109242149;
        Fri, 10 Oct 2025 08:14:02 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-781071fa127sm6387437b3.37.2025.10.10.08.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:14:01 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3 3/3] mm/page_alloc: Batch page freeing in free_frozen_page_commit
Date: Fri, 10 Oct 2025 08:13:59 -0700
Message-ID: <20251010151400.1925642-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c48ae6d5-3a04-4c32-8084-33d2e10d8d2e@suse.cz>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 10 Oct 2025 15:37:23 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

[...snip...]

> >  	high = nr_pcp_high(pcp, zone, batch, free_high);
> >  	if (pcp->count < high)
> > -		return;
> > +		return true;
> > +
> > +	to_free = nr_pcp_free(pcp, batch, high, free_high);
> > +	if (to_free == 0)
> > +		return true;
> >  
> > -	free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
> > -			   pcp, pindex);
> > +free_batch:
> > +	to_free_batched = min(to_free, batch);
> > +	free_pcppages_bulk(zone, to_free_batched, pcp, pindex);
> >  	if (test_bit(ZONE_BELOW_HIGH, &zone->flags) &&

Hello Vlastimil, thank you for your review!

> We could do this handling once after all batches. But maybe it's better to
> act as soon as it becomes true, and checking once ber batch isn't measurably
> slower, dunno.

My thinking was that if we are to release the pcp and zone lock and another
task remotely inspects this pcp in the middle of the loop, I would want the
ZONE_BELOW_HIGH bit to reflect the correct state of the pcp, as opposed to
doing it once at the end.

> >  	    zone_watermark_ok(zone, 0, high_wmark_pages(zone),
> >  			      ZONE_MOVABLE, 0)) {
> > @@ -2887,6 +2901,35 @@ static void free_frozen_page_commit(struct zone *zone,
> >  		    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
> >  			atomic_set(&pgdat->kswapd_failures, 0);
> >  	}
> > +	high = nr_pcp_high(pcp, zone, batch, free_high);
> 
> It's not clear why we recalculate this. Ah I see, the calculation involves a
> ZONE_BELOW_HIGH check which we might have changed above. So as a result ths
> patch isn't a straightforward "we free the same amount of pages but in
> smaller batches" but something different (and I'm not immediately sure what
> exactly).

Yes! So nr_pcp_high will check if we are now below high, and see what the
new high should be, and see if we need to free some more pages. My goal was
to prevent having to call free_frozen_page_commit again in the future once
we realize that there are still pages yet to be freed, and handle that case
within this loop as if it was what we originally decided to free.

> I think it's an argument for doing the ZONE_BELOW_HIGH test above just once
> in the end, and not recalculating "high" here. I'd just stick to the
> "to_free" calculated uprofront and decreasing it by "to_free_batched" each
> round.

Yes, this makes sense to me. The last sentence in my paragraph above seems
a little sneaky in doing more work than it originally was called to do, so
I do agree that we should do the ZONE_BELOW_HIGH check once, and also
calculate how many pages to free at once in the beginning.

> We should maybe also check that pcp->count went to 0 and bail out so we
> don't make useless iterations in rare cases when someone else drains the pcp
> between our batches (free_pcppages_bulk() protects itself from passing too
> high "count" so it would be just some wasted cpu otherwise, not a disaster).

Hopefully the check below is enough to handle this race case. When it
determines whether to iterate through in the loop again, we check that
to_free > 0 && pcp->count >= high, so if someone else were to drain the
drain the pcp->count, it would go under high (I don't think it's possible
for high to become negative here) it would break this check and prevent
another iteration. 

> > +	to_free -= to_free_batched;
> > +	if (pcp->count >= high) {
> > +		pcp_spin_unlock(pcp);
> > +		pcp_trylock_finish(*UP_flags);
> > +
> > +		pcp_trylock_prepare(*UP_flags);
> > +		pcp = pcp_spin_trylock(zone->per_cpu_pageset);
> > +		if (!pcp) {
> > +			pcp_trylock_finish(*UP_flags);
> > +			return false;
> > +		}
> > +
> > +		/*
> > +		 * Check if this thread has been migrated to a different
> > +		 * CPU. If that is the case, give up and indicate that
> > +		 * the pcp is returned in an unlocked state.
> > +		 */
> > +		if (smp_processor_id() != cpu) {
> 
> We could have remembered the old pcp pointer and compare that instead of
> doing smp_processor_id(), although that should also work.

I think that would have also worked. To be completely honest, I wasn't
sure if there was some pcp stuff inside that would change the pointer,
so just went with using the CPU int instead. 

> > +			pcp_spin_unlock(pcp);
> > +			pcp_trylock_finish(*UP_flags);
> > +			return false;
> > +		}
> > +	}
> > +
> > +	if (to_free > 0 && pcp->count >= high)

           Check is here:  ^^^^^^^^^^^^^^^^^^

> > +		goto free_batch;
> > +
> > +	return true;
> >  }
> >  
> >  /*
> > @@ -2934,7 +2977,9 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
> >  	pcp_trylock_prepare(UP_flags);
> >  	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
> >  	if (pcp) {
> > -		free_frozen_page_commit(zone, pcp, page, migratetype, order, fpi_flags);
> > +		if (!free_frozen_page_commit(zone, pcp, page, migratetype,
> > +						order, fpi_flags, &UP_flags))
> > +			return;
> >  		pcp_spin_unlock(pcp);
> >  	} else {
> >  		free_one_page(zone, page, pfn, order, fpi_flags);
> > @@ -3034,8 +3079,11 @@ void free_unref_folios(struct folio_batch *folios)
> >  			migratetype = MIGRATE_MOVABLE;
> >  
> >  		trace_mm_page_free_batched(&folio->page);
> > -		free_frozen_page_commit(zone, pcp, &folio->page, migratetype,
> > -					order, FPI_NONE);
> > +		if (!free_frozen_page_commit(zone, pcp, &folio->page,
> > +				migratetype, order, FPI_NONE, &UP_flags)) {
> > +			pcp = NULL;
> > +			locked_zone = NULL;
> > +		}
> >  	}
> >  
> >  	if (pcp) {

Thank you again for your review, Vlastimil. I agree with all of your
feedback, so I will make those changes (as well as the commit message
change for patch 2/3) and submit a new version. I hope you have a great day!
Joshua

