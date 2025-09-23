Return-Path: <linux-kernel+bounces-828830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD399B95918
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAE118A7996
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18FA321F32;
	Tue, 23 Sep 2025 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="eBrpSZeD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PrhcBeG1"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0050B322545
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625651; cv=none; b=gOQbuZYnr6EEwTXF2IKfItDQYiosMbw5Bnhpw7GIiEBr7yk/pNX9IaU1RKHLp0wR5So9N+WFuegRc2iIKwmzxGJIW0Ph+laNl9qfvVm/ma+JoFZ5UrONy+k9mzkMIinGws5JOjOUECzPmdzK9Pm0BwEu+sElhfoMIZRWFYLKKU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625651; c=relaxed/simple;
	bh=zgThalph9y47lmEr32v6T0NLRVPpwukomwHn+9xtsDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dk639sh0hCcH29132ZrFZswt+RfuQUwd6eqjIvkRTXEWisGZJgAkrp2fvp/FXJY1brhkCvSZYy82EaiJVQEXoc10jFlBS/BbVBIeRdT/2GN1cItGzUZTqRYB/0w68uOyoa5ElioWHHLBhRsLy4Wt0yzqWO9nJNKIt/EJpYMS0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=eBrpSZeD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PrhcBeG1; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 22A6FEC00DF;
	Tue, 23 Sep 2025 07:07:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 23 Sep 2025 07:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758625649; x=
	1758712049; bh=gBJQwyFG/mBuy6u3kCYzOX5EZriO4heRBy+k+i4RgPY=; b=e
	BrpSZeDYT2luvIzf8C71a4BIoX44rg3deXZlRby5//Bqvi979R9rF8Rwykh7k3HY
	NDMBxDgxrom/QJk5RM0L+JywaBEWbQRVwMQ9szXMAdsMA5vbxzYuCuT2BcwPzG/9
	A5KbR+5eEtKnJus7x2o0el/ud1Fqszxt0/evfJroj10y+EnptwPBWaqv8tCjmoEP
	TyBqC2cjJgTuG6AdrwcCwA6YNu2HsKQGxxmXM2yK8ZLQw+osTrx76ibs37rVdHN0
	ilVg+/r9k/aQddk/X1vRmYsufIsUaUm8XDKj3rGEd2SCyPMsj7Mmjvx8yBBnQTAh
	zh89YKO0BCL34/5OoBZ/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758625649; x=1758712049; bh=g
	BJQwyFG/mBuy6u3kCYzOX5EZriO4heRBy+k+i4RgPY=; b=PrhcBeG11yAJoPQux
	np5WlJHQZ2qybfofYscuCW9VHC3wik4Eqp24AFrZTaPXGC7Hac6YrbWjn72rwBr0
	aemGpmDjqZzD8SbIzquUN+S8hI3sXv4GYRjmJYKJdLwnAAuJ8thiaPltP907Uj6T
	um7EXgcYD7DSemAfDTP/1hHcLAyhY5vhMysM23XTphozrhayUVQ9Ty2Cz4P482a9
	DRoSrjix1yL28pGQJlz4DMjhydUitelwNZNb4yhAs1UAj3zmAGyyNQiRoqjIfeFz
	Mk9aM3pGgn7hgbVDzgCjE3MFbYkAYUVcCaCRP+elZxfvG7ncdy2Tp4r1kBltgsVo
	i1GyQ==
X-ME-Sender: <xms:cH_SaLU7RmgQ8p59ow7A4lLbZfOcvoEFOYHLvUnJOdVmAojw4EmizQ>
    <xme:cH_SaPjIrMm2m0mS5GbSyMAetNrJOtwHLPRkcjNggbkVM4vGHQIQ9PJtzI-d8nQhv
    -fvbbAyQ_kl88sg3XuMMoB86r7Vd0Qjy6nMEu5av7moGOfpx697mNI>
X-ME-Received: <xmr:cH_SaNj9oTLRawfXVH9jVVJz5nvjzS3AIskQxGu49EtTHbKnTu6ewIeam3vhWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdehiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:cH_SaMv9zo5_bgQDRBUmbzFAYGSRGBRRQPY06dOmgGwS4wHykJAi5g>
    <xmx:cH_SaDskCtT6HkROZodSBtL6mqfu8Ely1vORTN4t2raRWV1IP5g6RA>
    <xmx:cH_SaNMKa5Ll_GigGDB2eHBZ3B2gUdrNxBy3LgPWHZMqIx6EQPCVOw>
    <xmx:cH_SaFdNcMJ5AQYuVJZbhGOFKdqc1gDTWF0q4N2vhrlUjExAlZRwkQ>
    <xmx:cX_SaJbYLO4lVtx39J9mlP_dXCQutmzSXYNXFM4CvnSbSfBYEwvJn-mt>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 07:07:28 -0400 (EDT)
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
Subject: [PATCHv3 6/6] mm/rmap: Improve mlock tracking for large folios
Date: Tue, 23 Sep 2025 12:07:11 +0100
Message-ID: <20250923110711.690639-7-kirill@shutemov.name>
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
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/rmap.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index a55c3bf41287..d5b40800198c 100644
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


