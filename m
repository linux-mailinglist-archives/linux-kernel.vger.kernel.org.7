Return-Path: <linux-kernel+bounces-791710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7686B3BA66
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9495B1CC1767
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD3D31064E;
	Fri, 29 Aug 2025 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGOUvtEe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B182FC880
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756468664; cv=none; b=XrSPi4LLe0xmMEXhHLYBAgGpAmhdRLrZstkVEnj4I44/9d+b4j6Eojd3Sbkg7eNttvn/gXyGN0WZkGm0rLJ8zwTfMceAl9NUbw2oQ4GbnQtjObpJIw0oHPg8WW3r4E7WjahmNzcRgybe3wEbYRFCR9d3wDfy7lo8ZbuAJzjfCA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756468664; c=relaxed/simple;
	bh=UhVB8HJlAyrOnH5f4Og5S4P1NPNiTomGarjtdGQI++o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkOD6pbX77iovZFgXoq/dZW2Bwzip7VvKpyDoGZ67HXA3Y9eb+kqLhDUSMlZdUmdgITUtX5yYWzPJon2KFeeu7bBuhWhVlIimN5hLpsyBIUKjTm8AjSMOq+WN9jgJhPMZ4W78DWmzocL+ke5KFrD//i/IHASERGcLPyDammQ4hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGOUvtEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ED1C4CEF0;
	Fri, 29 Aug 2025 11:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756468663;
	bh=UhVB8HJlAyrOnH5f4Og5S4P1NPNiTomGarjtdGQI++o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGOUvtEefHOvUnKUpRXwk5yr2EaCZdYu9SojDPbjxrYutCrAUalQPgYHc0LmqF1o+
	 rgT23w2JIL17hrybawOD03y4xZN7mLfJ3ZzVOJsTi94bDqezMbMvZxQ+MC4JHmdU7k
	 BQ8ZSi2kddoqPWo/ciEOP0mZ2wd63v3lpynrXGhpEOs++zE2/T6l+K10KEWcMr3Dj0
	 5jiVhCgPOd5gknfmLKfR1smfBZR5Te/MXZ2s/fsyiulRc4ABP0gyO4ItPNlmV7kZDg
	 b+jxl4crk4TFcdUz933Ayt9+oNspJEmDWfxl33nqUDM5p+kLpsv3XADBKpeOPDBvlW
	 CxPaIeJpDmTaA==
Date: Fri, 29 Aug 2025 12:57:37 +0100
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
Message-ID: <aLGVsXpyUx9-ZRIl@willie-the-truck>
References: <20250815101858.24352-1-will@kernel.org>
 <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com>
 <aKMrOHYbTtDhOP6O@willie-the-truck>
 <aKM5S4oQYmRIbT3j@willie-the-truck>
 <9e7d31b9-1eaf-4599-ce42-b80c0c4bb25d@google.com>
 <8376d8a3-cc36-ae70-0fa8-427e9ca17b9b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8376d8a3-cc36-ae70-0fa8-427e9ca17b9b@google.com>

Hi Hugh,

On Thu, Aug 28, 2025 at 01:47:14AM -0700, Hugh Dickins wrote:
> On Sun, 24 Aug 2025, Hugh Dickins wrote:
> > On Mon, 18 Aug 2025, Will Deacon wrote:
> > > On Mon, Aug 18, 2025 at 02:31:42PM +0100, Will Deacon wrote:
> > > > On Fri, Aug 15, 2025 at 09:14:48PM -0700, Hugh Dickins wrote:
> > > > > I think replace the folio_test_mlocked(folio) part of it by
> > > > > (folio_test_mlocked(folio) && !folio_test_unevictable(folio)).
> > > > > That should reduce the extra calls to a much more reasonable
> > > > > number, while still solving your issue.
> > > > 
> > > > Alas, I fear that the folio may be unevictable by this point (which
> > > > seems to coincide with the readahead fault adding it to the LRU above)
> > > > but I can try it out.
> > > 
> > > I gave this a spin but I still see failures with this change.
> > 
> > Many thanks, Will, for the precisely relevant traces (in which,
> > by the way, mapcount=0 really means _mapcount=0 hence mapcount=1).
> > 
> > Yes, those do indeed illustrate a case which my suggested
> > (folio_test_mlocked(folio) && !folio_test_unevictable(folio))
> > failed to cover.  Very helpful to have an example of that.
> > 
> > And many thanks, David, for your reminder of commit 33dfe9204f29
> > ("mm/gup: clear the LRU flag of a page before adding to LRU batch").
> > 
> > Yes, I strongly agree with your suggestion that the mlock batch
> > be brought into line with its change to the ordinary LRU batches,
> > and agree that doing so will be likely to solve Will's issue
> > (and similar cases elsewhere, without needing to modify them).
> > 
> > Now I just have to cool my head and get back down into those
> > mlock batches.  I am fearful that making a change there to suit
> > this case will turn out later to break another case (and I just
> > won't have time to redevelop as thorough a grasp of the races as
> > I had back then).  But if we're lucky, applying that "one batch
> > at a time" rule will actually make it all more comprehensible.
> > 
> > (I so wish we had spare room in struct page to keep the address
> > of that one batch entry, or the CPU to which that one batch
> > belongs: then, although that wouldn't eliminate all uses of
> > lru_add_drain_all(), it would allow us to efficiently extract
> > a target page from its LRU batch without a remote drain.)
> > 
> > I have not yet begun to write such a patch, and I'm not yet sure
> > that it's even feasible: this mail sent to get the polite thank
> > yous out of my mind, to help clear it for getting down to work.
> 
> It took several days in search of the least bad compromise, but
> in the end I concluded the opposite of what we'd intended above.
> 
> There is a fundamental incompatibility between my 5.18 2fbb0c10d1e8
> ("mm/munlock: mlock_page() munlock_page() batch by pagevec")
> and Ge Yang's 6.11 33dfe9204f29
> ("mm/gup: clear the LRU flag of a page before adding to LRU batch").

That's actually pretty good news, as I was initially worried that we'd
have to backport a fix all the way back to 6.1. From the above, the only
LTS affected is 6.12.y.

> It turns out that the mm/swap.c folio batches (apart from lru_add)
> are all for best-effort, doesn't matter if it's missed, operations;
> whereas mlock and munlock are more serious.  Probably mlock could
> be (not very satisfactorily) converted, but then munlock?  Because
> of failed folio_test_clear_lru()s, it would be far too likely to
> err on either side, munlocking too soon or too late.
> 
> I've concluded that one or the other has to go.  If we're having
> a beauty contest, there's no doubt that 33dfe9204f29 is much nicer
> than 2fbb0c10d1e8 (which is itself far from perfect).  But functionally,
> I'm afraid that removing the mlock/munlock batching will show up as a
> perceptible regression in realistic workloadsg; and on consideration,
> I've found no real justification for the LRU flag clearing change.
> 
> Unless I'm mistaken, collect_longterm_unpinnable_folios() should
> never have been relying on folio_test_lru(), and should simply be
> checking for expected ref_count instead.
> 
> Will, please give the portmanteau patch (combination of four)
> below a try: reversion of 33dfe9204f29 and a later MGLRU fixup,
> corrected test in collect...(), preparatory lru_add_drain() there.
> 
> I hope you won't be proving me wrong again, and I can move on to
> writing up those four patches (and adding probably three more that
> make sense in such a series, but should not affect your testing).
> 
> I've tested enough to know that it's not harmful, but am hoping
> to take advantage of your superior testing, particularly in the
> GUP pin area.  But if you're uneasy with the combination, and would
> prefer to check just the minimum, then ignore the reversions and try
> just the mm/gup.c part of it - that will probably be good enough for
> you even without the reversions.

Thanks, I'll try to test the whole lot. I was geographically separated
from my testing device yesterday but I should be able to give it a spin
later today. I'm _supposed_ to be writing my KVM Forum slides for next
week, so this offers a perfect opportunity to procrastinate.

> Patch is against 6.17-rc3; but if you'd prefer the patch against 6.12
> (or an intervening release), I already did the backport so please just
> ask.

We've got 6.15 working well at the moment, so I'll backport your diff
to that.

One question on the diff below:

> Thanks!
> 
>  mm/gup.c    |    5 ++++-
>  mm/swap.c   |   50 ++++++++++++++++++++++++++------------------------
>  mm/vmscan.c |    2 +-
>  3 files changed, 31 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index adffe663594d..9f7c87f504a9 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2291,6 +2291,8 @@ static unsigned long collect_longterm_unpinnable_folios(
>  	struct folio *folio;
>  	long i = 0;
>  
> +	lru_add_drain();
> +
>  	for (folio = pofs_get_folio(pofs, i); folio;
>  	     folio = pofs_next_folio(folio, pofs, &i)) {
>  
> @@ -2307,7 +2309,8 @@ static unsigned long collect_longterm_unpinnable_folios(
>  			continue;
>  		}
>  
> -		if (!folio_test_lru(folio) && drain_allow) {
> +		if (drain_allow && folio_ref_count(folio) !=
> +				   folio_expected_ref_count(folio) + 1) {
>  			lru_add_drain_all();

How does this synchronise with the folio being added to the mlock batch
on another CPU?

need_mlock_drain(), which is what I think lru_add_drain_all() ends up
using to figure out which CPU batches to process, just looks at the
'nr' field in the batch and I can't see anything in mlock_folio() to
ensure any ordering between adding the folio to the batch and
incrementing its refcount.

Then again, my hack to use folio_test_mlocked() would have a similar
issue because the flag is set (albeit with barrier semantics) before
adding the folio to the batch, meaning the drain could miss the folio.

I guess there's some higher-level synchronisation making this all work,
but it would be good to understand that as I can't see that
collect_longterm_unpinnable_folios() can rely on much other than the pin.

Will

