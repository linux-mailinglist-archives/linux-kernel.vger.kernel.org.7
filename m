Return-Path: <linux-kernel+bounces-773704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D755B2A64C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FF01B62DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DDA321F58;
	Mon, 18 Aug 2025 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jif98HVs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACDA321F4C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523902; cv=none; b=o7AWgPXNJTfmzlWF8aSPI0w/Kyxb1bwpu7XUoy0XDrIzgSclVK3vn1W9YosRoX/L6MKkhHOiA5tPnACJleuejibW+K8+kVYeUWPy6Wszk2QvErg6iRpx8thxItvab+3Xva0CPUgmRksDmH2BBTf+3H4FDu2hxGigVFV+kr7a57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523902; c=relaxed/simple;
	bh=XzEVQU118bjXuclKJk0YiVJkmWHkWNtJ+PbFU51iKQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoTCppJ3HnzFewdC4xrsVo8jrlZcf+aEosWAyZkdxAFmBh+b/PjZ4PxU0uXtXRaLI/2SYeAGInw+HGDBYOSNm2Xt4a8OZr6Hn7JJqyosFDervcQDbrm/GLT5ssSuo9LVxCkURCc1XS2LuCcAq3GHUT3L1oRzQ8dKJmUVfjJJPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jif98HVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406B7C4CEEB;
	Mon, 18 Aug 2025 13:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755523902;
	bh=XzEVQU118bjXuclKJk0YiVJkmWHkWNtJ+PbFU51iKQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jif98HVs2JWZC7FdaLL2O8ruQeHklu+b23JqetiFSziqS+JKK+tX6paCGlTw6NWoW
	 fHSz6AvorEuPeGx2xg/8DR+RwRu5vaC9/qtp1dXj8phObLBywTVnnibVQfjD3mBnbH
	 ZRWdEXatgm4f5JUWCRPMGVj3BNDoartOuFGd6h/O0LEQT8yRM5BufmDNxDceRrQCTe
	 6I8MlR2PAVyG2f98aiq2+WFmWnWA4w9wp/g2ww8592y022xDUgPnFWI8w8fFV6Mo7e
	 gBXneY/+afFRQlQYfAM0WlKD/E7CuFc8cjJkivKQDGdSXMxDP1nqlBsZ9w09mHyqdd
	 w2D4iLLkhZBUA==
Date: Mon, 18 Aug 2025 14:31:36 +0100
From: Will Deacon <will@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Keir Fraser <keirf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Frederick Mayle <fmayle@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/gup: Drain batched mlock folio processing before
 attempting migration
Message-ID: <aKMrOHYbTtDhOP6O@willie-the-truck>
References: <20250815101858.24352-1-will@kernel.org>
 <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com>

Hi Hugh,

On Fri, Aug 15, 2025 at 09:14:48PM -0700, Hugh Dickins wrote:
> On Fri, 15 Aug 2025, Will Deacon wrote:
> 
> > When taking a longterm GUP pin via pin_user_pages(),
> > __gup_longterm_locked() tries to migrate target folios that should not
> > be longterm pinned, for example because they reside in a CMA region or
> > movable zone. This is done by first pinning all of the target folios
> > anyway, collecting all of the longterm-unpinnable target folios into a
> > list, dropping the pins that were just taken and finally handing the
> > list off to migrate_pages() for the actual migration.
> > 
> > It is critically important that no unexpected references are held on the
> > folios being migrated, otherwise the migration will fail and
> > pin_user_pages() will return -ENOMEM to its caller. Unfortunately, it is
> > relatively easy to observe migration failures when running pKVM (which
> > uses pin_user_pages() on crosvm's virtual address space to resolve
> > stage-2 page faults from the guest) on a 6.15-based Pixel 6 device and
> > this results in the VM terminating prematurely.
> > 
> > In the failure case, 'crosvm' has called mlock(MLOCK_ONFAULT) on its
> > mapping of guest memory prior to the pinning. Subsequently, when
> > pin_user_pages() walks the page-table, the relevant 'pte' is not
> > present and so the faulting logic allocates a new folio, mlocks it
> > with mlock_folio() and maps it in the page-table.
> > 
> > Since commit 2fbb0c10d1e8 ("mm/munlock: mlock_page() munlock_page()
> > batch by pagevec"), mlock/munlock operations on a folio (formerly page),
> > are deferred. For example, mlock_folio() takes an additional reference
> > on the target folio before placing it into a per-cpu 'folio_batch' for
> > later processing by mlock_folio_batch(), which drops the refcount once
> > the operation is complete. Processing of the batches is coupled with
> > the LRU batch logic and can be forcefully drained with
> > lru_add_drain_all() but as long as a folio remains unprocessed on the
> > batch, its refcount will be elevated.
> > 
> > This deferred batching therefore interacts poorly with the pKVM pinning
> > scenario as we can find ourselves in a situation where the migration
> > code fails to migrate a folio due to the elevated refcount from the
> > pending mlock operation.
> 
> Thanks for the very full description, Will, that helped me a lot
> (I know very little of the GUP pinning end).
> 
> But one thing would help me to understand better: are the areas being
> pinned anonymous or shmem or file memory (or COWed shmem or file)?

crosvm is using memfd_create() so I think that means it's anonymous and
shmem? I'm not entirely sure what the right terminology is for a memfd.

> From "the faulting logic allocates a new folio" I first assumed
> anonymous, but later came to think "mlocks it with mlock_folio()"
> implies they are shmem or file folios (which, yes, can also be
> allocated by fault).
> 
> IIRC anonymous and COW faults would go the mlock_new_folio() way,
> where the folio goes on to the mlock folio batch without having yet
> reached LRU: those should be dealt with by the existing
> !folio_test_lru() check.

Most of my analysis has been constructed from backtraces when we've
managed to catch the problem. Thankfully, I've saved most of them, so
I went back to have a look and you're absolutely right -- it's _not_
the pin_user_pages() which allocates the page in this case, so apologies
for getting that wrong in the commit message. I've clearly been reading
too many trace logs!

The page is allocated and mlocked just before the pin thanks to a user
page fault:

 crosvm_VmRunApp-6493    [007] ...2.   144.767288: page_ref_mod: pfn=0x9f83a8 flags=locked|uptodate|swapbacked|mlocked count=4 mapcount=0 mapping=00000000f0e9c5fd mt=4 val=1
 crosvm_VmRunApp-6493    [007] ...2.   144.767288: <stack trace>
 => trace_event_raw_event_page_ref_mod_template
 => __page_ref_mod
 => mlock_folio
 => folio_add_file_rmap_ptes
 => set_pte_range
 => finish_fault
 => do_pte_missing
 => handle_mm_fault
 => do_page_fault
 => do_translation_fault
 => do_mem_abort
 => el0_da
 => el0t_64_sync_handler
 => el0t_64_sync

and the pin_user_pages() comes in a little later (on a different CPU):

    crosvm_vcpu0-6499    [003] ...1.   144.786828: page_ref_mod: pfn=0x9f83a8 flags=uptodate|dirty|lru|swapbacked|unevictable|mlocked count=1027 mapcount=0 mapping=00000000f0e9c5fd mt=4 val=1024
    crosvm_vcpu0-6499    [003] ...1.   144.786832: <stack trace>
 => trace_event_raw_event_page_ref_mod_template
 => __page_ref_mod
 => try_grab_folio
 => follow_page_pte
 => __get_user_pages
 => __gup_longterm_locked
 => pin_user_pages
 => __pkvm_pin_user_pages
 => pkvm_mem_abort
 => pkvm_mem_abort_prefault
 => kvm_handle_guest_abort
 => handle_exit
 => kvm_arch_vcpu_ioctl_run
 => kvm_vcpu_ioctl
 => __arm64_sys_ioctl
 => invoke_syscall
 => el0_svc_common
 => do_el0_svc
 => el0_svc
 => el0t_64_sync_handler
 => el0t_64_sync

Between the two there's an interesting filemap fault triggering
readahead and that's what adds the folio to the LRU:

 crosvm_VmRunApp-6493    [007] ...1.   144.767358: page_ref_mod_and_test: pfn=0x9f83a8 flags=uptodate|dirty|lru|swapbacked|unevictable|mlocked count=3 mapcount=0 mapping=00000000f0e9c5fd mt=4 val=-1 ret=0
 crosvm_VmRunApp-6493    [007] ...1.   144.767359: <stack trace>
 => trace_event_raw_event_page_ref_mod_and_test_template
 => __page_ref_mod_and_test
 => folios_put_refs
 => folio_batch_move_lru
 => __folio_batch_add_and_move
 => folio_add_lru
 => filemap_add_folio
 => page_cache_ra_unbounded
 => page_cache_ra_order
 => do_sync_mmap_readahead
 => filemap_fault
 => __do_fault
 => do_pte_missing
 => handle_mm_fault
 => do_page_fault
 => do_translation_fault
 => do_mem_abort
 => el0_ia
 => el0t_64_sync_handler
 => el0t_64_sync

> > diff --git a/mm/gup.c b/mm/gup.c
> > index adffe663594d..656835890f05 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2307,7 +2307,8 @@ static unsigned long collect_longterm_unpinnable_folios(
> >  			continue;
> >  		}
> >  
> > -		if (!folio_test_lru(folio) && drain_allow) {
> > +		if (drain_allow &&
> > +		   (!folio_test_lru(folio) || folio_test_mlocked(folio))) {
> >  			lru_add_drain_all();
> >  			drain_allow = false;
> >  		}
> 
> Hmm.  That is going to call lru_add_drain_all() whenever any of the
> pages in the list is mlocked, and lru_add_drain_all() is a function
> we much prefer to avoid calling (it's much better than the old days
> when it could involve every CPU IPIing every other CPU at the same
> time; but it's still raising doubts to this day, and best avoided).
>
> (Not as bad as I first thought: those unpinnably-placed mlocked
> folios will get migrated, not appearing again in repeat runs.)
> 
> I think replace the folio_test_mlocked(folio) part of it by
> (folio_test_mlocked(folio) && !folio_test_unevictable(folio)).
> That should reduce the extra calls to a much more reasonable
> number, while still solving your issue.

Alas, I fear that the folio may be unevictable by this point (which
seems to coincide with the readahead fault adding it to the LRU above)
but I can try it out.

> But in addition, please add an unconditional lru_add_drain()
> (the local CPU one, not the inter-CPU _all) at the head of
> collect_longterm_unpinnable_folios().  My guess is that that
> would eliminate 90% of the calls to the lru_add_drain_all() below:
> not quite enough to satisfy you, but enough to be a good improvement.

Sure, that's straightforward enough. We do already see an
mlock_drain_local() from try_to_migrate_one() but that happens after all
the unpinnable folios have been collected so it doesn't help us here.

Will

