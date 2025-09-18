Return-Path: <linux-kernel+bounces-823053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44A1B85656
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0391C04BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B321530496A;
	Thu, 18 Sep 2025 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="adPc1VEo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DV6F3pbz"
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D099A2FE05B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207514; cv=none; b=O5B3HwfFvro8nnakaaOmDSjx1IwhKh+FXcpVxipHhnrbpPygzbPQGuEPSA5PlPcEQPULxsCGagLd9nKfrgbDNSV6Yd1aizNYTrXQr6u2BQNL6B+1R9cl0xvqPuh9DMQAM5pbOZhw1n/2I/sA8L7HkcXzGGQa+IsU/j85sJ3NQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207514; c=relaxed/simple;
	bh=rIC3ZyOp4kVr688hxJAN8417b4on1DdVa/vc2bbQHxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvaE9NDSeKjuelmrJHx+zWKx12g76ljFwBDG3riDG77CF+ZePejdwkAC4NMygZJXA9BJI0RS8ETPot7+ToxLxr1z+h3zPPK2CGEG1ct0l/vdu5Jh4E1DeiTyGQ0QFLs9Vcsb16Nu4gvZSudDrY4IZ5+YoDgMsZLNw6lkBzMT5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=adPc1VEo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DV6F3pbz; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id EED511301561;
	Thu, 18 Sep 2025 10:58:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 18 Sep 2025 10:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758207509; x=
	1758214709; bh=L8pg48vNYs6t9/+XwPwkU2uiasNJp6vX14PGIKbK9co=; b=a
	dPc1VEod5zAB8+jl+a8T/k9xXjRLP2d+JuqGORhZIvOB0iSBlLyWbTeQS0RCnnNr
	l7Oe67B/Vb5SPerFR/MrSBS58pVXnXZ58xU3WLlKpK0sR//JTbbtYb0wY5Ahy2OC
	cOUV2qqkbG8dqTQCsxt4Dlwnh22sBwNH+W+UUk00mBNsHb3jwOY6tVyN+e2OTLF+
	bXqfZxY7E7vH8rstUdUVNGz3/bGkdhXRXiq+hXN/oyKC57479C11+fdCEy+pGlAL
	yKm1FniUs+XjXgbLrQue7usEni7CiOVUplUlUnE9ts6iyy3RgGPbk+vBnBSvCZCO
	kmxNhoG7XVIyurW23zIMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758207509; x=1758214709; bh=L8pg48vNYs6t9/+XwPwkU2uiasNJp6vX14P
	GIKbK9co=; b=DV6F3pbzYhifjM1R7ZFYdtv5Gd7EEK2g+aLSxmCSmTIGeutj1Lm
	BL1hearz+fakRDrPMULpsM5TNiL3pm3f4zi//yWIPv9GdieNckH07ik7j3ULRhZo
	+J6/eR0hpYE50igO/sjAFKtKa/lbyure5og8Jhg8lFZIOg01dBgTdcvFX84oUk9I
	PcQUqBWH2JCDj0o5S/R6eiXTUGeKh2Bh+2U7UQv+cTJtjiD1wjnEvFaA8B6Y2OLq
	TvnaaqA0UkvSlsmtJgQqTSZ+Wd8IKOnYNvqrUyX6SHJ872Q6FNMYM4TieT+Ai9sk
	FfCn46S9oqJoVgt9csRvI+6iqBOFpgoHQiA==
X-ME-Sender: <xms:FB7MaDNan9yyHFIiR65MXoLKi_L2TawaFQnpMyoroeEsEdfqR4z0GA>
    <xme:FB7MaLFPXIaWk5b_HryoBuZ-rxTZ2-Xg-JYDtfxzx4BZlLPWxnh8WOq4R7NwfZjyR
    lT1V4ifkPgMhXKNliU>
X-ME-Received: <xmr:FB7MaCvcg7hHLw1fqP7i125-8IDYR7fTB5iFg99gUCGrMqHarjsawGV771CNWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegieeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepfeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhrvghniihordhsthhorghkvg
    hssehorhgrtghlvgdrtghomhdprhgtphhtthhopehfvghnghifvghirdihihhnsehinhht
    vghlrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonh
    drohhrghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrh
    gruggvrggurdhorhhgpdhrtghpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghl
    vgdrtghomhdprhgtphhtthhopehvsggrsghkrgesshhushgvrdgtiidprhgtphhtthhope
    hrphhptheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FB7MaIvhcOW8RTLi_NxS_a3fBcVdbItDPNhUHF_c4xaBwBQsK0XKBw>
    <xmx:FB7MaDGldt__88ouzLItUh1EOPj0GT1Q1S_Z02Bm3b2z_uijm32KeA>
    <xmx:FB7MaLLtUlQzEM4ja34ahIQj1sYFImhwuFvYdJp5fboqgIgHCKlxsw>
    <xmx:FB7MaDbtHLd8j7zybuLllrSBICNl3R35yn-f5Oiz3oMwbYcc8FB2LQ>
    <xmx:FR7MaN6MkmK4rzorT_6u6oh09ihRs147rAPqBhpcZUaP_e4VSiDjWbIl>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 10:58:28 -0400 (EDT)
Date: Thu, 18 Sep 2025 15:58:25 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Yin Fengwei <fengwei.yin@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/rmap: Improve mlock tracking for large folios
Message-ID: <5c4gefrln7nnkhl4pcnlq7qtaj56wmpp6r3lagpuzcjoi2uyms@cd7c5oehjorz>
References: <20250918112157.410172-1-kirill@shutemov.name>
 <20250918112157.410172-3-kirill@shutemov.name>
 <429481ef-6527-40f5-b7a0-c9370fd1e374@lucifer.local>
 <ndryzvkmrfidmjgj4tl27hk2kmspmb42mxl2smuwgmp5hyedzh@thggle3dhp5j>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ndryzvkmrfidmjgj4tl27hk2kmspmb42mxl2smuwgmp5hyedzh@thggle3dhp5j>

On Thu, Sep 18, 2025 at 02:48:27PM +0100, Kiryl Shutsemau wrote:
> > So maybe we could do something similar in try_to_unmap_one()?
> 
> Hm. This seems to be buggy to me.
> 
> mlock_vma_folio() has to be called with ptl taken, no? It gets dropped
> by this place.
> 
> +Fengwei.
> 
> I think this has to be handled inside the loop once ptes reaches
> folio_nr_pages(folio).
> 
> Maybe something like this (untested):

With a little bit more tinkering I've come up with the change below.

Still untested.

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 6cd020eea37a..86975033cb96 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -928,6 +928,11 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
 /* Look for migration entries rather than present PTEs */
 #define PVMW_MIGRATION		(1 << 1)
 
+/* Result flags */
+
+/* The page mapped across page boundary */
+#define PVMW_PGTABLE_CROSSSED	(1 << 16)
+
 struct page_vma_mapped_walk {
 	unsigned long pfn;
 	unsigned long nr_pages;
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index e981a1a292d2..a184b88743c3 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -309,6 +309,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 				}
 				pte_unmap(pvmw->pte);
 				pvmw->pte = NULL;
+				pvmw->flags |= PVMW_PGTABLE_CROSSSED;
 				goto restart;
 			}
 			pvmw->pte++;
diff --git a/mm/rmap.c b/mm/rmap.c
index ca8d4ef42c2d..afe2711f4e3d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -851,34 +851,34 @@ static bool folio_referenced_one(struct folio *folio,
 {
 	struct folio_referenced_arg *pra = arg;
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, address, 0);
-	int referenced = 0;
-	unsigned long start = address, ptes = 0;
+	int ptes = 0, referenced = 0;
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
 
 		if (vma->vm_flags & VM_LOCKED) {
-			if (!folio_test_large(folio) || !pvmw.pte) {
-				/* Restore the mlock which got missed */
-				mlock_vma_folio(folio, vma);
-				page_vma_mapped_walk_done(&pvmw);
-				pra->vm_flags |= VM_LOCKED;
-				return false; /* To break the loop */
-			}
-			/*
-			 * For large folio fully mapped to VMA, will
-			 * be handled after the pvmw loop.
-			 *
-			 * For large folio cross VMA boundaries, it's
-			 * expected to be picked  by page reclaim. But
-			 * should skip reference of pages which are in
-			 * the range of VM_LOCKED vma. As page reclaim
-			 * should just count the reference of pages out
-			 * the range of VM_LOCKED vma.
-			 */
 			ptes++;
 			pra->mapcount--;
-			continue;
+
+			/* Only mlock fully mapped pages */
+			if (pvmw.pte && ptes != pvmw.nr_pages)
+				continue;
+
+			/*
+			 * All PTEs must be protected by page table lock in
+			 * order to mlock the page.
+			 *
+			 * If page table boundary has been cross, current ptl
+			 * only protect part of ptes.
+			 */
+			if (pvmw.flags & PVMW_PGTABLE_CROSSSED)
+				continue;
+
+			/* Restore the mlock which got missed */
+			mlock_vma_folio(folio, vma);
+			page_vma_mapped_walk_done(&pvmw);
+			pra->vm_flags |= VM_LOCKED;
+			return false; /* To break the loop */
 		}
 
 		/*
@@ -914,23 +914,6 @@ static bool folio_referenced_one(struct folio *folio,
 		pra->mapcount--;
 	}
 
-	if ((vma->vm_flags & VM_LOCKED) &&
-			folio_test_large(folio) &&
-			folio_within_vma(folio, vma)) {
-		unsigned long s_align, e_align;
-
-		s_align = ALIGN_DOWN(start, PMD_SIZE);
-		e_align = ALIGN_DOWN(start + folio_size(folio) - 1, PMD_SIZE);
-
-		/* folio doesn't cross page table boundary and fully mapped */
-		if ((s_align == e_align) && (ptes == folio_nr_pages(folio))) {
-			/* Restore the mlock which got missed */
-			mlock_vma_folio(folio, vma);
-			pra->vm_flags |= VM_LOCKED;
-			return false; /* To break the loop */
-		}
-	}
-
 	if (referenced)
 		folio_clear_idle(folio);
 	if (folio_test_clear_young(folio))
@@ -1882,6 +1865,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	unsigned long nr_pages = 1, end_addr;
 	unsigned long pfn;
 	unsigned long hsz = 0;
+	int ptes = 0;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1922,9 +1906,24 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		 */
 		if (!(flags & TTU_IGNORE_MLOCK) &&
 		    (vma->vm_flags & VM_LOCKED)) {
+			ptes++;
+
+			/* Only mlock fully mapped pages */
+			if (pvmw.pte && ptes != pvmw.nr_pages)
+				goto walk_abort;
+
+			/*
+			 * All PTEs must be protected by page table lock in
+			 * order to mlock the page.
+			 *
+			 * If page table boundary has been cross, current ptl
+			 * only protect part of ptes.
+			 */
+			if (pvmw.flags & PVMW_PGTABLE_CROSSSED)
+				goto walk_abort;
+
 			/* Restore the mlock which got missed */
-			if (!folio_test_large(folio))
-				mlock_vma_folio(folio, vma);
+			mlock_vma_folio(folio, vma);
 			goto walk_abort;
 		}
 
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

