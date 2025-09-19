Return-Path: <linux-kernel+bounces-824535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F36B897FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54BC55A053B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923A822D9EB;
	Fri, 19 Sep 2025 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="NmsJzCb7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R1+Sr7MG"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029932248B3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285655; cv=none; b=Ec5arCDNWcIUyxFvueeNWOMejgZ+8M46NbySv7Nrxih9jsb1Q6EHohGOnNv8SEr48kcHuqopNPdE5wgnYvzWY51InzsQ4Ew8HcB4fxpfryK0hg7Awo8wpo/zrBKYMaLYTQheRpQfa5LCrDiocpyeP55AkEItFv92XaYI+pBKpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285655; c=relaxed/simple;
	bh=zdMoQugj5dZCnEqJberPdOJTUKqP3WcxTTDCP87sqj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvAGxIwxx5edLE187/aE8jJLOH1WQNHGVj4/bFW+MsiY1KJ5rf0fb4qSKIWDBiivfrs1dlsEg3LwPFAKOWgG715dfAbPizymc7/DU0p3hRoeyUGDgKGkhXAz+IDVhq2Py+G0O53FMqdIxm4VAs9XYU5ZlhyFo6fnplT8Mi2mB4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=NmsJzCb7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R1+Sr7MG; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 10F171400189;
	Fri, 19 Sep 2025 08:40:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 19 Sep 2025 08:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758285653; x=
	1758372053; bh=mxh0csfVOqXEIeJ0PDZRZ2dOl352C/UceF+juPeU56o=; b=N
	msJzCb7eLd2gI0Zfaco0EvDRWDj7CmihiaDFfishQMh/f1pRAkQMAUxmv1ls4dsZ
	GflJFsnfiRczd++qW8n0M52k5xF9grKIXYfTrf0j2yxEUPgEBpdOSXMVIp1ChtHf
	fxz7lfWg2UW3pBEs71cnG5hziGfPpxUWojvr+zot2Kg7/Yon95XhXYG9xa7CfNi+
	x6Okgvi1Yg0wigzpXuS2cULBwUUpFMEA5by++n8RtpBewT6QEL/vVJ16qofk0n+r
	ASwx1YG8QCZGKzvAQjOGO27VlkJ8OlLFPePXzqitCAL69ADBs4/o19P5rE837aFi
	dF3WXnvd87b0/hTeZIMRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758285653; x=1758372053; bh=m
	xh0csfVOqXEIeJ0PDZRZ2dOl352C/UceF+juPeU56o=; b=R1+Sr7MGq+aSYY4wH
	kOsTx/2EOwo1JplaQY3c6bXdLkWm352tdLHHJzoBUxpYDTWOW5ryoCBtXWkv9k7O
	zLgcqiTWtu4Vc3dDcJdeheOWhuQnHXWjFn2JEmxGxPUwg7G4Fea2JWBolCU3Lnld
	tsHctCtcYdVGie1CJQkNs57ZGtff+u9FcyU8bCGA5OwLzodMNw0nvrv70VXI/svG
	hU/cse3OmFEgYp1obWTMH0JDGRdvHicpCV0KEuc8HXGpyg7k+d+S3Y/htGnFDpcw
	fTC7zOqH7oSYtARBG1kpUklkQMuLOL32e6hcN1h6ctEdbATFMWUK+wi17oBMfIFE
	tPS7g==
X-ME-Sender: <xms:VE_NaPjba1MBPCTYbx0TAZaLkPJGs5ujl4V68d6TmEqxa6N46OwsPQ>
    <xme:VE_NaNgUDwjhfsa-D5cjLt04_orxOfzgzvUz7bcddWReeEUCIeh8FPh4-LTtw9v0-
    -UFbr9jY_VxW55Fh4g>
X-ME-Received: <xmr:VE_NaMvI66RrkR06KiA8GNu1anMpaFCDbW14KbatjGSUocnXOSGOVKiTCq8slQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegledvfecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:VE_NaDuTrkARgMiI_JyIa9QOhf6m_vdjp-9paw6zpUx_29TPkF1S3Q>
    <xmx:VE_NaNNNKORfVFQhVCobk2UtXn9WgQJGi0Q4y_AM27czdpSNphGBFA>
    <xmx:VE_NaFfUN16EFA3pJWLVE2Uw_g6SRbpC5wv1MKv9gLd3By5l6u_msA>
    <xmx:VE_NaEkq2tpUtT7xKf8rBXGwacTHNgbkj3gR0900nxpcfsaPY_W0WA>
    <xmx:VU_NaIrpBwudk1qRhkHwkbHukUm9TJO0LRz2tm9iAg-gwd_BYF2EtpYF>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 08:40:52 -0400 (EDT)
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
Subject: [PATCHv2 5/5] mm/rmap: Improve mlock tracking for large folios
Date: Fri, 19 Sep 2025 13:40:36 +0100
Message-ID: <20250919124036.455709-6-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250919124036.455709-1-kirill@shutemov.name>
References: <20250919124036.455709-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiryl Shutsemau <kas@kernel.org>

The kernel currently does not mlock large folios when adding them to
rmap, stating that it is difficult to confirm that the folio is fully
mapped and safe to mlock it.

This leads to a significant undercount of Mlocked in /proc/meminfo,
causing problems in production where the stat was used to estimate
system utilization and determine if load shedding is required.

However, nowadays the caller passes a number of pages of the folio that
are getting mapped, making it easy to check if the entire folio is
mapped to the VMA.

mlock the folio on rmap if it is fully mapped to the VMA.

Mlocked in /proc/meminfo can still undercount, but the value is closer
the truth and is useful for userspace.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/rmap.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 482e6504fa88..6e09956670f4 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1462,12 +1462,12 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 	}
 
 	/*
-	 * For large folio, only mlock it if it's fully mapped to VMA. It's
-	 * not easy to check whether the large folio is fully mapped to VMA
-	 * here. Only mlock normal 4K folio and leave page reclaim to handle
-	 * large folio.
+	 * Only mlock it if the folio is fully mapped to the VMA.
+	 *
+	 * Partially mapped folios can be split on reclaim and part outside
+	 * of mlocked VMA can be evicted or freed.
 	 */
-	if (!folio_test_large(folio))
+	if (folio_nr_pages(folio) == nr_pages)
 		mlock_vma_folio(folio, vma);
 }
 
@@ -1603,8 +1603,13 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
 	nr = __folio_add_rmap(folio, page, nr_pages, vma, level, &nr_pmdmapped);
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
 
-	/* See comments in folio_add_anon_rmap_*() */
-	if (!folio_test_large(folio))
+	/*
+	 * Only mlock it if the folio is fully mapped to the VMA.
+	 *
+	 * Partially mapped folios can be split on reclaim and part outside
+	 * of mlocked VMA can be evicted or freed.
+	 */
+	if (folio_nr_pages(folio) == nr_pages)
 		mlock_vma_folio(folio, vma);
 }
 
-- 
2.50.1


