Return-Path: <linux-kernel+bounces-808027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19421B4AC48
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3654A1886E1A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E331CA44;
	Tue,  9 Sep 2025 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/NzefE9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E7C255F31
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417947; cv=none; b=D3RQx4Af7wYfrZlN86RXDy3TbXejFiRmVwsS1ubjyJsae6Q6ExkpYYQNwNiGFmOKD/dPMh5vKPo1O9Oanq9Ikqm3zdg62yq9U4ADiwc7GMJ1BjfebEmlJE2Pnhyiyz2sLdgMizjRIzeozQN+WeCaeEI9l1XlVCeJkzc+U2lRijA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417947; c=relaxed/simple;
	bh=MnMaEWlz/QtlQ28E4FkGCUPQB5UpUKYT1xidLfF37Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozzhjW6/bAEZqOCTi04SlJEJmmBz2YPGEinHuGzK/AOQ0zotgvxz6rlgdVBrbpJhSH302VGvx3lEUb8MKw8I5d7xjjYhw3SBoomuo2D0ytuq3R3tIRlydMZMAnvDxKyDM6z4uskk5pLqFf2BmTtzU9dXRmJORLBpddSI1KmuYNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/NzefE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B603C4CEFA;
	Tue,  9 Sep 2025 11:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757417946;
	bh=MnMaEWlz/QtlQ28E4FkGCUPQB5UpUKYT1xidLfF37Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/NzefE9MfgofUX6bK5rf8bsHeScQYaogVbPE3TFEw+YIDa/B6zwvzkQ0HVMkEyEP
	 Ar7uvJTFGYYOjWWIZMOVeGVzNRf0jC02t0kNvY+hW9TLuvYfpscRl2yFNvZSwjRsBA
	 FvTdKbsBz0jqP+TQi299CfYV+nqXNsSLupy2D6mzdcTFDXSHv4RK2F1ZZ+xKN7SqJp
	 nW2qj7JHliBKNEhg8hXb5MXfZYRBHLu8t9OmsM+d5aB736S1xJ9LrYL9+IjPT6kpBz
	 zt9GZOO7RUn3Rlit6szXoCzqS4WgcIiUJAjlV5rGa40FnC0zwFOLqd5NqCwHSXhfWH
	 ZmRGBd9s9yAVA==
Date: Tue, 9 Sep 2025 12:39:00 +0100
From: Will Deacon <will@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Frederick Mayle <fmayle@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>,
	Vlastimil Babka <vbabka@suse.cz>, Ge Yang <yangge1116@126.com>
Subject: Re: [PATCH] mm/gup: Drain batched mlock folio processing before
 attempting migration
Message-ID: <aMAR1A1CidQrIFEW@willie-the-truck>
References: <20250815101858.24352-1-will@kernel.org>
 <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com>
 <aKMrOHYbTtDhOP6O@willie-the-truck>
 <aKM5S4oQYmRIbT3j@willie-the-truck>
 <9e7d31b9-1eaf-4599-ce42-b80c0c4bb25d@google.com>
 <8376d8a3-cc36-ae70-0fa8-427e9ca17b9b@google.com>
 <aLGVsXpyUx9-ZRIl@willie-the-truck>
 <7ce169c2-09b7-39e3-d00b-ba1db6dd258c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ce169c2-09b7-39e3-d00b-ba1db6dd258c@google.com>

On Fri, Aug 29, 2025 at 08:46:52AM -0700, Hugh Dickins wrote:
> On Fri, 29 Aug 2025, Will Deacon wrote:
> > On Thu, Aug 28, 2025 at 01:47:14AM -0700, Hugh Dickins wrote:
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index adffe663594d..9f7c87f504a9 100644
> > > --- a/mm/gup.c
> > > +++ b/mm/gup.c
> > > @@ -2291,6 +2291,8 @@ static unsigned long collect_longterm_unpinnable_folios(
> > >  	struct folio *folio;
> > >  	long i = 0;
> > >  
> > > +	lru_add_drain();
> > > +
> > >  	for (folio = pofs_get_folio(pofs, i); folio;
> > >  	     folio = pofs_next_folio(folio, pofs, &i)) {
> > >  
> > > @@ -2307,7 +2309,8 @@ static unsigned long collect_longterm_unpinnable_folios(
> > >  			continue;
> > >  		}
> > >  
> > > -		if (!folio_test_lru(folio) && drain_allow) {
> > > +		if (drain_allow && folio_ref_count(folio) !=
> > > +				   folio_expected_ref_count(folio) + 1) {
> > >  			lru_add_drain_all();
> > 
> > How does this synchronise with the folio being added to the mlock batch
> > on another CPU?
> > 
> > need_mlock_drain(), which is what I think lru_add_drain_all() ends up
> > using to figure out which CPU batches to process, just looks at the
> > 'nr' field in the batch and I can't see anything in mlock_folio() to
> > ensure any ordering between adding the folio to the batch and
> > incrementing its refcount.
> > 
> > Then again, my hack to use folio_test_mlocked() would have a similar
> > issue because the flag is set (albeit with barrier semantics) before
> > adding the folio to the batch, meaning the drain could miss the folio.
> > 
> > I guess there's some higher-level synchronisation making this all work,
> > but it would be good to understand that as I can't see that
> > collect_longterm_unpinnable_folios() can rely on much other than the pin.
> 
> No such strict synchronization: you've been misled if people have told
> you that this pinning migration stuff is deterministically successful:
> it's best effort - or will others on the Cc disagree?
> 
> Just as there's no synchronization between the calculation inside
> folio_expected_ref_count() and the reading of folio's refcount.
> 
> It wouldn't make sense for this unpinnable collection to anguish over
> such synchronization, when a moment later the migration is liable to
> fail (on occasion) for other transient reasons.  All ending up reported
> as -ENOMEM apparently? that looks unhelpful.

I see this was tangentially discussed with David on the patches you sent
and I agree that it's a distinct issue from what we're solving here,
however, -ENOMEM is a particularly problematic way to report transient
errors with migration due to a race. For KVM, the -ENOMEM will bubble
back up to userspace and the VMM is likely to destroy the VM altogether
whereas -EAGAIN would return back to the guest and retry the faulting
instruction.

Will

