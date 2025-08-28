Return-Path: <linux-kernel+bounces-789563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9C2B39764
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ABF91C25722
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CFB30CD89;
	Thu, 28 Aug 2025 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gi01xTXM"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8298D1C01
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370857; cv=none; b=btRqzAeb1zLjzJoC2sdZ3gEXKKGn2nFqYJJf7r96eA3ilbD7+WRdEFajQqzGUIev7/Sz2rCLF1MDBeYRo+gdEEDMrlEftYU7AFH8pVWD+sLK7pgPRAvIRtie+2rtb8/IQTzlqErasPgEh6Dv3nNhXIHckmzVgFSHHcBWbPcFeiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370857; c=relaxed/simple;
	bh=klgOpbjoTBdv2Vkm+b8o31L3dwGPXK20/KbS2tweohg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LCu9e3l1+N/wIY8RfHiGZDStywo8cEMrGfdQ028twkW+bqIb5VQaet6Wbvoq1DJ+bHQUfmBrm7DCgKLa/D8Tb2DXcOqRynAGupkj9JUAJWKe12FK+3hg9qdXdRDt+n9EcPjSPNCNPCcLrh2HvtDI+XAv5mMyY2LhArM0v+VRHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gi01xTXM; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d6059643eso4911177b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756370854; x=1756975654; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajlxqHLh//7RM2WXYQGL6911X3IOgGsMf++Sc3IjJEo=;
        b=gi01xTXM+mrblwGJwZB5QOxvFAATQ6cLNN0woZoi+YV+IfEHzp3BWzl7LzKxno+x6W
         /tiWp9Gt1Hq56IDm689Ve1rAXsqxwaG6X8zpbVU06CRLOEbEgiEj3+9uXvMKUV8HxHkJ
         praOD5JzQRnwUpX8VGM2GQG+Wvl1z+c76XLfu11UvYchh5T2uZ0YxiBM52iJBi6o1qN9
         Q8zIsV+muNypzd+/rLfQMLMZtUthZ/zvZnN4GuChzG3Tmf+XzVXlZCBCOZ/DJTNlzzt0
         M2IJeFAAJIEHqrVV76LPHXjFBSJTjz7t7IHUVdtV1HXWXeKXRqjTid1ZzsbUdUTSJZnv
         eW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756370854; x=1756975654;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajlxqHLh//7RM2WXYQGL6911X3IOgGsMf++Sc3IjJEo=;
        b=a66533k73mQ4LFXnGnF9Hbap2ib0YMKc2tKbmNOUn+I+HiDQcYlOR0P6vbknHUIZbh
         sXwujBZeEZMtjNkJPph+gEFiIrktNFtvAsbHFDIClaLoJAycbqsZEh6cGEUKW280vNcB
         2H3sZ3IzJRT2ICXtRSV7rawW4eu6DZ39fNoOgEfFUrJcHmdmRbTXxllkGAVfv1dpkn+0
         eA2eif9s/tWmwqLkYTR4p2i1AmPexbeGSZXI95kKTUwMw29qTvrqcpVYa5OMyqLDzhDl
         tqhwgoyqrSleO1u7yRLDvmDPDK0aKw2+0DxBSmlDDs37ZrZhv6wY3PU5jDXCsYUaaO+8
         EqlA==
X-Forwarded-Encrypted: i=1; AJvYcCVGZiyYZZwgBINntONB6Q8I5768OQeKFXnV4l+YYI15Yt5gvx8QTyQZZ6pKP4BEhUHZAe5rX7UfCGP6+yA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xSAETOlrkvr9MRyUFdlxQXwaDiNt8DWEqf4KfPiQApSYJjHA
	1LC52Dat6juA0KBPddNEwT7MHvjpmXH0XwN+/Z5pvkJG/Z3VdQRZQHa7iV12zmWI5w==
X-Gm-Gg: ASbGncutSGksLUxWaW5NR1S/xkCLTuSZqozP+5/w+esYCAh3r/SsgAXv1JIOmUVjgRv
	+MC/uAHZ+aq0S/PBj0jk+QiWP9bQjTVF1aRBvraINFqB/b6pvkF+0XthQY+DQoGCojMNcqYPYIR
	P5suX+brfuo1eFP7dNyWy1LuJYlRYVXqhz31+uKNcNxEtKIzEUc9PHCadw2gWRi1du8aomXYzW9
	JqR4MsyrUVt1p/Goo39oYMM1cF6bGx5VHUO4mbIlXqHiABRi6xiCgRkOzQQQ4iNaffoqxrCGgnH
	vKoVpZUR+BD2MmLYlSzKJhZi8xKOnCWBkbTYRv7iR9WSZ7+dQ77JsENXExlS1bOusBSBp0p+cjM
	D0ln2FXcUvrJkD4/J/Fm5IO/UYInTOftbXZLIOlvH1G2z9O4BtaWh4BmPOnIXT/aWqgFPL8UQ0V
	z8TWPbYn8x63nXIBvIiXysVw6/ORdP2ZxWGno=
X-Google-Smtp-Source: AGHT+IFqHuGPvWN4REWcVqA2EWGwb+rpAlfl2t1wU26wD0l5m4zrGCyGbHObK8y6+sA/7eJ/Cq3dIg==
X-Received: by 2002:a05:690c:374a:b0:71e:8309:ce81 with SMTP id 00721157ae682-71fdc4275b4mr250796477b3.39.1756370854218;
        Thu, 28 Aug 2025 01:47:34 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff17339fdsm37375447b3.21.2025.08.28.01.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:47:32 -0700 (PDT)
Date: Thu, 28 Aug 2025 01:47:14 -0700 (PDT)
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
In-Reply-To: <9e7d31b9-1eaf-4599-ce42-b80c0c4bb25d@google.com>
Message-ID: <8376d8a3-cc36-ae70-0fa8-427e9ca17b9b@google.com>
References: <20250815101858.24352-1-will@kernel.org> <c5bac539-fd8a-4db7-c21c-cd3e457eee91@google.com> <aKMrOHYbTtDhOP6O@willie-the-truck> <aKM5S4oQYmRIbT3j@willie-the-truck> <9e7d31b9-1eaf-4599-ce42-b80c0c4bb25d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 24 Aug 2025, Hugh Dickins wrote:
> On Mon, 18 Aug 2025, Will Deacon wrote:
> > On Mon, Aug 18, 2025 at 02:31:42PM +0100, Will Deacon wrote:
> > > On Fri, Aug 15, 2025 at 09:14:48PM -0700, Hugh Dickins wrote:
> > > > I think replace the folio_test_mlocked(folio) part of it by
> > > > (folio_test_mlocked(folio) && !folio_test_unevictable(folio)).
> > > > That should reduce the extra calls to a much more reasonable
> > > > number, while still solving your issue.
> > > 
> > > Alas, I fear that the folio may be unevictable by this point (which
> > > seems to coincide with the readahead fault adding it to the LRU above)
> > > but I can try it out.
> > 
> > I gave this a spin but I still see failures with this change.
> 
> Many thanks, Will, for the precisely relevant traces (in which,
> by the way, mapcount=0 really means _mapcount=0 hence mapcount=1).
> 
> Yes, those do indeed illustrate a case which my suggested
> (folio_test_mlocked(folio) && !folio_test_unevictable(folio))
> failed to cover.  Very helpful to have an example of that.
> 
> And many thanks, David, for your reminder of commit 33dfe9204f29
> ("mm/gup: clear the LRU flag of a page before adding to LRU batch").
> 
> Yes, I strongly agree with your suggestion that the mlock batch
> be brought into line with its change to the ordinary LRU batches,
> and agree that doing so will be likely to solve Will's issue
> (and similar cases elsewhere, without needing to modify them).
> 
> Now I just have to cool my head and get back down into those
> mlock batches.  I am fearful that making a change there to suit
> this case will turn out later to break another case (and I just
> won't have time to redevelop as thorough a grasp of the races as
> I had back then).  But if we're lucky, applying that "one batch
> at a time" rule will actually make it all more comprehensible.
> 
> (I so wish we had spare room in struct page to keep the address
> of that one batch entry, or the CPU to which that one batch
> belongs: then, although that wouldn't eliminate all uses of
> lru_add_drain_all(), it would allow us to efficiently extract
> a target page from its LRU batch without a remote drain.)
> 
> I have not yet begun to write such a patch, and I'm not yet sure
> that it's even feasible: this mail sent to get the polite thank
> yous out of my mind, to help clear it for getting down to work.

It took several days in search of the least bad compromise, but
in the end I concluded the opposite of what we'd intended above.

There is a fundamental incompatibility between my 5.18 2fbb0c10d1e8
("mm/munlock: mlock_page() munlock_page() batch by pagevec")
and Ge Yang's 6.11 33dfe9204f29
("mm/gup: clear the LRU flag of a page before adding to LRU batch").

It turns out that the mm/swap.c folio batches (apart from lru_add)
are all for best-effort, doesn't matter if it's missed, operations;
whereas mlock and munlock are more serious.  Probably mlock could
be (not very satisfactorily) converted, but then munlock?  Because
of failed folio_test_clear_lru()s, it would be far too likely to
err on either side, munlocking too soon or too late.

I've concluded that one or the other has to go.  If we're having
a beauty contest, there's no doubt that 33dfe9204f29 is much nicer
than 2fbb0c10d1e8 (which is itself far from perfect).  But functionally,
I'm afraid that removing the mlock/munlock batching will show up as a
perceptible regression in realistic workloadsg; and on consideration,
I've found no real justification for the LRU flag clearing change.

Unless I'm mistaken, collect_longterm_unpinnable_folios() should
never have been relying on folio_test_lru(), and should simply be
checking for expected ref_count instead.

Will, please give the portmanteau patch (combination of four)
below a try: reversion of 33dfe9204f29 and a later MGLRU fixup,
corrected test in collect...(), preparatory lru_add_drain() there.

I hope you won't be proving me wrong again, and I can move on to
writing up those four patches (and adding probably three more that
make sense in such a series, but should not affect your testing).

I've tested enough to know that it's not harmful, but am hoping
to take advantage of your superior testing, particularly in the
GUP pin area.  But if you're uneasy with the combination, and would
prefer to check just the minimum, then ignore the reversions and try
just the mm/gup.c part of it - that will probably be good enough for
you even without the reversions.

Patch is against 6.17-rc3; but if you'd prefer the patch against 6.12
(or an intervening release), I already did the backport so please just
ask.

Thanks!

 mm/gup.c    |    5 ++++-
 mm/swap.c   |   50 ++++++++++++++++++++++++++------------------------
 mm/vmscan.c |    2 +-
 3 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index adffe663594d..9f7c87f504a9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2291,6 +2291,8 @@ static unsigned long collect_longterm_unpinnable_folios(
 	struct folio *folio;
 	long i = 0;
 
+	lru_add_drain();
+
 	for (folio = pofs_get_folio(pofs, i); folio;
 	     folio = pofs_next_folio(folio, pofs, &i)) {
 
@@ -2307,7 +2309,8 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		if (!folio_test_lru(folio) && drain_allow) {
+		if (drain_allow && folio_ref_count(folio) !=
+				   folio_expected_ref_count(folio) + 1) {
 			lru_add_drain_all();
 			drain_allow = false;
 		}
diff --git a/mm/swap.c b/mm/swap.c
index 3632dd061beb..8ef3dea20e39 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -164,6 +164,10 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 	for (i = 0; i < folio_batch_count(fbatch); i++) {
 		struct folio *folio = fbatch->folios[i];
 
+		/* block memcg migration while the folio moves between lru */
+		if (move_fn != lru_add && !folio_test_clear_lru(folio))
+			continue;
+
 		folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
 		move_fn(lruvec, folio);
 
@@ -176,14 +180,10 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 }
 
 static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
-		struct folio *folio, move_fn_t move_fn,
-		bool on_lru, bool disable_irq)
+		struct folio *folio, move_fn_t move_fn, bool disable_irq)
 {
 	unsigned long flags;
 
-	if (on_lru && !folio_test_clear_lru(folio))
-		return;
-
 	folio_get(folio);
 
 	if (disable_irq)
@@ -191,8 +191,8 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 	else
 		local_lock(&cpu_fbatches.lock);
 
-	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) || folio_test_large(folio) ||
-	    lru_cache_disabled())
+	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) ||
+			folio_test_large(folio) || lru_cache_disabled())
 		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
 
 	if (disable_irq)
@@ -201,13 +201,13 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 		local_unlock(&cpu_fbatches.lock);
 }
 
-#define folio_batch_add_and_move(folio, op, on_lru)						\
-	__folio_batch_add_and_move(								\
-		&cpu_fbatches.op,								\
-		folio,										\
-		op,										\
-		on_lru,										\
-		offsetof(struct cpu_fbatches, op) >= offsetof(struct cpu_fbatches, lock_irq)	\
+#define folio_batch_add_and_move(folio, op)		\
+	__folio_batch_add_and_move(			\
+		&cpu_fbatches.op,			\
+		folio,					\
+		op,					\
+		offsetof(struct cpu_fbatches, op) >=	\
+		offsetof(struct cpu_fbatches, lock_irq)	\
 	)
 
 static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)
@@ -231,10 +231,10 @@ static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)
 void folio_rotate_reclaimable(struct folio *folio)
 {
 	if (folio_test_locked(folio) || folio_test_dirty(folio) ||
-	    folio_test_unevictable(folio))
+	    folio_test_unevictable(folio) || !folio_test_lru(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_move_tail, true);
+	folio_batch_add_and_move(folio, lru_move_tail);
 }
 
 void lru_note_cost_unlock_irq(struct lruvec *lruvec, bool file,
@@ -328,10 +328,11 @@ static void folio_activate_drain(int cpu)
 
 void folio_activate(struct folio *folio)
 {
-	if (folio_test_active(folio) || folio_test_unevictable(folio))
+	if (folio_test_active(folio) || folio_test_unevictable(folio) ||
+	    !folio_test_lru(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_activate, true);
+	folio_batch_add_and_move(folio, lru_activate);
 }
 
 #else
@@ -507,7 +508,7 @@ void folio_add_lru(struct folio *folio)
 	    lru_gen_in_fault() && !(current->flags & PF_MEMALLOC))
 		folio_set_active(folio);
 
-	folio_batch_add_and_move(folio, lru_add, false);
+	folio_batch_add_and_move(folio, lru_add);
 }
 EXPORT_SYMBOL(folio_add_lru);
 
@@ -685,13 +686,13 @@ void lru_add_drain_cpu(int cpu)
 void deactivate_file_folio(struct folio *folio)
 {
 	/* Deactivating an unevictable folio will not accelerate reclaim */
-	if (folio_test_unevictable(folio))
+	if (folio_test_unevictable(folio) || !folio_test_lru(folio))
 		return;
 
 	if (lru_gen_enabled() && lru_gen_clear_refs(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_deactivate_file, true);
+	folio_batch_add_and_move(folio, lru_deactivate_file);
 }
 
 /*
@@ -704,13 +705,13 @@ void deactivate_file_folio(struct folio *folio)
  */
 void folio_deactivate(struct folio *folio)
 {
-	if (folio_test_unevictable(folio))
+	if (folio_test_unevictable(folio) || !folio_test_lru(folio))
 		return;
 
 	if (lru_gen_enabled() ? lru_gen_clear_refs(folio) : !folio_test_active(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_deactivate, true);
+	folio_batch_add_and_move(folio, lru_deactivate);
 }
 
 /**
@@ -723,10 +724,11 @@ void folio_deactivate(struct folio *folio)
 void folio_mark_lazyfree(struct folio *folio)
 {
 	if (!folio_test_anon(folio) || !folio_test_swapbacked(folio) ||
+	    !folio_test_lru(folio) ||
 	    folio_test_swapcache(folio) || folio_test_unevictable(folio))
 		return;
 
-	folio_batch_add_and_move(folio, lru_lazyfree, true);
+	folio_batch_add_and_move(folio, lru_lazyfree);
 }
 
 void lru_add_drain(void)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a48aec8bfd92..674999999cd0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4507,7 +4507,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* ineligible */
-	if (!folio_test_lru(folio) || zone > sc->reclaim_idx) {
+	if (zone > sc->reclaim_idx) {
 		gen = folio_inc_gen(lruvec, folio, false);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;

