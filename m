Return-Path: <linux-kernel+bounces-792046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7022B3BFC5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D153AAF8B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA41832274F;
	Fri, 29 Aug 2025 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZZI84MJ"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE04188CC9
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482427; cv=none; b=m0oF+6e0r4It6FKXLmSKR6gL/VSLWVC78K+GxqsHwMa/dc05QMNKFjzv+FWd+bznqiWPHfSz53JorFnr64050Iob/U10yXxkJiLNv5Pl7RTzoGUfh/iU6aCeLhu+9qDsTGAMzoGe6VagMy/DjhTFCW5vsgAwjUZvk0DbOFWEuA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482427; c=relaxed/simple;
	bh=BFpTKgCpOwW1cxVyDp8rzUTnvXhBBZMK9CH5gd4emzk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DKdRGhJ4staGpeCv6wNuxEsCR+GxgxPlPjfpxPOnVVng1T3SsPuaj/MM0ad5dRjVtbzrkAjcortZP8QT38FA03105/bAtZ+3dRnAiJrdLiK1/EY0IZhd3Yq0gsRNWSo+EPq3kXotM/AsMExocrJWaCb45Ai6LNIRBeMboAxBJO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jZZI84MJ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d605a70bdso13921117b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756482425; x=1757087225; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VMpbX/2FtFqpgYi77vApNFXCw+W0zMV1YchkzsWEhB8=;
        b=jZZI84MJobH6zrb8KtU516CwvYVE90sKyMBNSfB5DgEj/tmXSeBmY/mTYm2MHZNudh
         GeMaumYhlYe9hHNGnetT3B5WIMDKOPlt4xIBmoAC0En2iEmVKqrB3hJZ92a4iTk7erq3
         VpiFoftOkrf8uB2D6CXZHmkviXTbg56v1l0TW3DlBqynYexqoF/w7B9BbYTpvLf0i4QY
         GMJ95GfjU1c5t+2w9yAcSnHiUXlDDBz7/rzmLF2ON89bh2QFbQDFzow8o20xgZEaAUKY
         A3a2o3JhJKUML5meKKMkHt6O60cg/IrJtObjU1VtIkSBQMvkk7ZQIplRq9OCYZNAi9mS
         s4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756482425; x=1757087225;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VMpbX/2FtFqpgYi77vApNFXCw+W0zMV1YchkzsWEhB8=;
        b=ca0/+WH1Zkq/n8yyeMnc9IIblLweCHKZOz85MptjyVM4tl18HylKWn1vyNT5umqJCS
         IEhb3VsaAVxQlUwYGP8f+8WO1uw3VOtfM6TZ6Zfzv3LdpJEjIGmOqUceFmbwwDQbwwW5
         hUVXOaR69Wq1WfyG5LyzX4L7/q9szW8PDtYF8V1gjpuNQzKLBVdnTShAXuCRUcyByvcz
         CsCFuiIt+TfCMgPrU608rGqmTEh8Wj9lZChL57nMCqlwSM4EYHY1msvfcY/wDKu9PK3e
         mBPFZVpDXm4h7ww9Rp6eO2vJOWQUVDbbU4Y7BPfHNkHStDh6y0Rt7vU2/ET5IWDOfQhK
         FJhA==
X-Forwarded-Encrypted: i=1; AJvYcCXvEEMZ2ZOt62Ta1SSox1Ud9DyKYRLg1GcNY5cpQyXBp2wK4mbvmyedkikPxcZjw3Lf+Bme/mxQTNhM0Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK25ZMFyRGtuLQ/enHj2/TOBxZrjNzlHGUQyGUOHzGs+NazjrF
	VQFg0Ne5t/xgvDrorazKHWi82QE2HkAGjGjaXyEdM5mEBDICqJ+2QRUDiMVPmRuVAQ==
X-Gm-Gg: ASbGncsp2R34x3SA2BAaMgS9nI8bIaG4/lqYhjIhB4+jwknScj8uK2aO34HtjTRRLCT
	R5cFIuuMTTqfEixDV2WEQhds0SBPDxA9k69zPP3mrjSW8BR6dygjZTr7YLSQe9UVdpokxNUuk9L
	wwcrEnhoktebzZgkL1VEvITSIket6PmpKkl14aWl97Q+ZYEJvQomL8VyYU3gFJ5MgUNxwaY0InK
	2SojJuvraNi4KqRfofgueP/TS2a9ieM1GN4bVQoEI4/SodLWHF95JryUqBFM/1Gqf51hjb5hbRo
	rRAhRtpEByGKitWzlid+QPBTshPkrRCxtky0YEzQ3jQhzUhwk3PTBLAjw3trOrmA8UAxPlmHPox
	d3v6HDjt5b49ONcOA2Jv3XciG1ZlRGc/fNxxJOKJ7ATkstO4U9GBOhm2ZXxPL9E5jFCBRIR3uCn
	fS0Fxi9g3PegkCXHjo5jJuiBD/
X-Google-Smtp-Source: AGHT+IGYbdSHodDuTFqyNCLyyFCsXP9AkvMjFSwwU9xyZEIsbEfHIyT2HtUbmAyGlDvSOEG31G+Qvg==
X-Received: by 2002:a05:690c:63c8:b0:71e:6f13:976 with SMTP id 00721157ae682-71fdc2a89f2mr254116157b3.6.1756482424706;
        Fri, 29 Aug 2025 08:47:04 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721c63530acsm7713727b3.26.2025.08.29.08.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 08:47:03 -0700 (PDT)
Date: Fri, 29 Aug 2025 08:46:52 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Will Deacon <will@kernel.org>
cc: Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    Keir Fraser <keirf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
    John Hubbard <jhubbard@nvidia.com>, Frederick Mayle <fmayle@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, 
    Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, 
    Ge Yang <yangge1116@126.com>
Subject: Re: [PATCH] mm/gup: Drain batched mlock folio processing before
 attempting migration
In-Reply-To: <aLGVsXpyUx9-ZRIl@willie-the-truck>
Message-ID: <7ce169c2-09b7-39e3-d00b-ba1db6dd258c@google.com>
References: <20250815101858.24352-1-will@kernel.org> <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com> <aKMrOHYbTtDhOP6O@willie-the-truck> <aKM5S4oQYmRIbT3j@willie-the-truck> <9e7d31b9-1eaf-4599-ce42-b80c0c4bb25d@google.com> <8376d8a3-cc36-ae70-0fa8-427e9ca17b9b@google.com>
 <aLGVsXpyUx9-ZRIl@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 29 Aug 2025, Will Deacon wrote:
> On Thu, Aug 28, 2025 at 01:47:14AM -0700, Hugh Dickins wrote:
...
> > 
> > It took several days in search of the least bad compromise, but
> > in the end I concluded the opposite of what we'd intended above.
> > 
> > There is a fundamental incompatibility between my 5.18 2fbb0c10d1e8
> > ("mm/munlock: mlock_page() munlock_page() batch by pagevec")
> > and Ge Yang's 6.11 33dfe9204f29
> > ("mm/gup: clear the LRU flag of a page before adding to LRU batch").
> 
> That's actually pretty good news, as I was initially worried that we'd
> have to backport a fix all the way back to 6.1. From the above, the only
> LTS affected is 6.12.y.

I'm not so sure of that. I think the 6.11 change tickled a particular
sequence that showed up in your testing, but the !folio_test_lru()
was never an adequate test for whether lru_add_drain_all() might help.

I can't try to estimate the probabilities, you'll have to make your
own decision, whether it's worth going back to change a release which
did not (I presume) show problems in real life.

...
> > Unless I'm mistaken, collect_longterm_unpinnable_folios() should
> > never have been relying on folio_test_lru(), and should simply be
> > checking for expected ref_count instead.
> > 
> > Will, please give the portmanteau patch (combination of four)
> > below a try: reversion of 33dfe9204f29 and a later MGLRU fixup,
> > corrected test in collect...(), preparatory lru_add_drain() there.
> > 
> > I hope you won't be proving me wrong again, and I can move on to
> > writing up those four patches (and adding probably three more that
> > make sense in such a series, but should not affect your testing).
> > 
> > I've tested enough to know that it's not harmful, but am hoping
> > to take advantage of your superior testing, particularly in the
> > GUP pin area.  But if you're uneasy with the combination, and would
> > prefer to check just the minimum, then ignore the reversions and try
> > just the mm/gup.c part of it - that will probably be good enough for
> > you even without the reversions.
> 
> Thanks, I'll try to test the whole lot. I was geographically separated
> from my testing device yesterday but I should be able to give it a spin
> later today. I'm _supposed_ to be writing my KVM Forum slides for next
> week, so this offers a perfect opportunity to procrastinate.

Well understood :) And you've already reported on the testing, thanks.

> 
> > Patch is against 6.17-rc3; but if you'd prefer the patch against 6.12
> > (or an intervening release), I already did the backport so please just
> > ask.
> 
> We've got 6.15 working well at the moment, so I'll backport your diff
> to that.
> 
> One question on the diff below:
> 
> > Thanks!
> > 
> >  mm/gup.c    |    5 ++++-
> >  mm/swap.c   |   50 ++++++++++++++++++++++++++------------------------
> >  mm/vmscan.c |    2 +-
> >  3 files changed, 31 insertions(+), 26 deletions(-)
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index adffe663594d..9f7c87f504a9 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2291,6 +2291,8 @@ static unsigned long collect_longterm_unpinnable_folios(
> >  	struct folio *folio;
> >  	long i = 0;
> >  
> > +	lru_add_drain();
> > +
> >  	for (folio = pofs_get_folio(pofs, i); folio;
> >  	     folio = pofs_next_folio(folio, pofs, &i)) {
> >  
> > @@ -2307,7 +2309,8 @@ static unsigned long collect_longterm_unpinnable_folios(
> >  			continue;
> >  		}
> >  
> > -		if (!folio_test_lru(folio) && drain_allow) {
> > +		if (drain_allow && folio_ref_count(folio) !=
> > +				   folio_expected_ref_count(folio) + 1) {
> >  			lru_add_drain_all();
> 
> How does this synchronise with the folio being added to the mlock batch
> on another CPU?
> 
> need_mlock_drain(), which is what I think lru_add_drain_all() ends up
> using to figure out which CPU batches to process, just looks at the
> 'nr' field in the batch and I can't see anything in mlock_folio() to
> ensure any ordering between adding the folio to the batch and
> incrementing its refcount.
> 
> Then again, my hack to use folio_test_mlocked() would have a similar
> issue because the flag is set (albeit with barrier semantics) before
> adding the folio to the batch, meaning the drain could miss the folio.
> 
> I guess there's some higher-level synchronisation making this all work,
> but it would be good to understand that as I can't see that
> collect_longterm_unpinnable_folios() can rely on much other than the pin.

No such strict synchronization: you've been misled if people have told
you that this pinning migration stuff is deterministically successful:
it's best effort - or will others on the Cc disagree?

Just as there's no synchronization between the calculation inside
folio_expected_ref_count() and the reading of folio's refcount.

It wouldn't make sense for this unpinnable collection to anguish over
such synchronization, when a moment later the migration is liable to
fail (on occasion) for other transient reasons.  All ending up reported
as -ENOMEM apparently? that looks unhelpful.

There is a heavy hammer called lru_cache_disable() in mm/swap.c,
stopping the batching and doing its own lru_add_drain_all(): that is
used by CMA and a few others, but not by this pinning (and I do not
want to argue that it should be).

Hugh

