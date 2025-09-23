Return-Path: <linux-kernel+bounces-828826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A44EB95909
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA90B4A3E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9941A3218D5;
	Tue, 23 Sep 2025 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="k57Yn56F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNhe5QDm"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A495321425
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625643; cv=none; b=iYAam3g2r99S9iKsyQjtzWU1Z4OkC6tipY502DpqDYg5xJeXkwJM1HYJp+N9NtpA4XjRguAWnp7Ep84NVrul5F/q0kwE6PVE+4GwxQo/DKqfTEBQ4sVoH85czfjVk6fROJLzpb4179A15pjcXM1TgKx5ls794/T7R8uO8CQnt6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625643; c=relaxed/simple;
	bh=7QCXYWOHwiU+p9/s4J6qDPLNsZQ85NJ6/lMLx1KnvP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Am6BJOYeK575nbL3C0LtGM2LjVXeMl57NR9bdx1feeLXtyhPplJl7k97OGdfhlZ55Z1MMPsnHT3W9KHmhZm8ZQ+KoR7bNjE3TxmDulA4uuJVWBf+P2TXuXFLFUxcR66O8IWavWopKXa9UD9IiwrijREJxYdslT8v8wpnAhmE3wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=k57Yn56F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RNhe5QDm; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 47919EC00DB;
	Tue, 23 Sep 2025 07:07:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 23 Sep 2025 07:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758625641; x=
	1758712041; bh=9h5a9glrsc1Q9FewltBTBylrIxsnIQry21VQ9ojF/aI=; b=k
	57Yn56Ft7V1wdRUjQFDU16OLtJjKXC9ojXp+Xly/KRh8s+26eNrrJqXwH1D3+blc
	EsbPeUED693c2ckC9PcNRxqU9hWN0ht+wP6MqXnm3RkYxSTIbSFTtqMvTU1wUQAe
	gzZ5yc10CWXxOmkYvSqggeuJH2j/6iF9F81EskCxcTCAK0iKAkBcHAtg01wWra5d
	Zms63rnfsYBXBFJoI+/zZVornKHTfgfv7qLOp552azU0f8rhj96ZF7u6l4f6CSx4
	x2TtEDASSbxM8cqe8LFicm6p7dXVKKCFVblLl7lqW5oQtwP5pYgFd7tjFwlnJWgW
	E9bX9d3rNwQxo1r2ChMKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758625641; x=1758712041; bh=9
	h5a9glrsc1Q9FewltBTBylrIxsnIQry21VQ9ojF/aI=; b=RNhe5QDmEf9xtn3d0
	ihdNJUhcwKphjfzODBwqVK0DRT3qzVn4HxFbUZrS84IaPQuwRIB8PhUO08D0TNpQ
	voIXkcBBQ95BJVGzRl6UCX2t+SYx63XQ5v2fA+HvKKbs4as+iMRkv5CUlhpK4+ag
	foP6nGPPEEWvPQiQdlz3f+6GSJBahvC0hvTOmWyMUkNZwCbncdljB8kD+gxdV7Sn
	OW0PZND/Ntl0M/4zmUT+jCkA5lD2m5dq5vwOxcgvL0LenTxkF9pIgMBeNFFPMc0P
	nGwJActrRumDAK/hKDxQ59Ut/wMg4MRY2Py8q+28SvudQbtXSvHQJQ3ARZWUUaJ7
	KMllQ==
X-ME-Sender: <xms:aH_SaNn37cKXrjN6V14BDk8q0G35B1l4myo4Nt_Mx149alBRijU34Q>
    <xme:aH_SaEw8UL-JgJ0CMQ53RegKCh3TbvKlvX7idEI6BUKKRCuJoYLivzQXgb7xPV9WD
    tfRECIteFDAJ6RX1JYu_wnYqT5cVjrJCnipmALLYI_CtgWUsL3VZQ>
X-ME-Received: <xmr:aH_SaJyQR8w-zVhE0h8UAM9g7bGCI15sKOOTnlojdO0CA4JfhBeiyhWjV5Rr-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeegveehtdfgvdfhudegffeuuddvgeevjefhveevgefhvdevieevteei
    vdehjefhjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepudek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouh
    hnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohephhhughhhugesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilh
    hlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlohhrvghniihordhsthho
    rghkvghssehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtth
    esohhrrggtlhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhr
    tghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsg
    esghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:aH_SaD-T2gBjlfmljqYYu5iwMTv1UzocAjmF6FVG5DMGtFMgB7c2ug>
    <xmx:aH_SaJ_-LirFFs1XkyuGJZPSkdMaJcEeq3sIyUJwKMhp4mafglfWqw>
    <xmx:aH_SaGffgWggxbnTf6yKA7Q6-y64HNjgWiXoYLgM-XVK4_C44GeTHw>
    <xmx:aH_SaFvIlb3Tz2-WH0saLBDr5lfQpZ4IpNmW5p47HZ151FFuPGQQgg>
    <xmx:aX_SaHqnZ1PCXdU4FJd6pDpubmswp9wsKRXmnp9MQ0Zra0Sd1gBGhgbx>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 07:07:20 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCHv3 2/6] mm/rmap: Fix a mlock race condition in folio_referenced_one()
Date: Tue, 23 Sep 2025 12:07:07 +0100
Message-ID: <20250923110711.690639-3-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923110711.690639-1-kirill@shutemov.name>
References: <20250923110711.690639-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

The mlock_vma_folio() function requires the page table lock to be held
in order to safely mlock the folio. However, folio_referenced_one()
mlocks a large folios outside of the page_vma_mapped_walk() loop where
the page table lock has already been dropped.

Rework the mlock logic to use the same code path inside the loop for
both large and small folios.

Use PVMW_PGTABLE_CROSSED to detect when the folio is mapped across a
page table boundary.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/rmap.c | 59 ++++++++++++++++++++-----------------------------------
 1 file changed, 21 insertions(+), 38 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 568198e9efc2..3d0235f332de 100644
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
-- 
2.50.1


