Return-Path: <linux-kernel+bounces-822622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D193FB84557
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26811C0619B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75014302772;
	Thu, 18 Sep 2025 11:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="HPN7TsEa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MnNJsRCt"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9695D3043AC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194529; cv=none; b=uTh7IGiCz9NT2V8dNowbJmyN/j9bBSYJVinGqJKMuByl42o0GOjRZV/oJM5K53oRx8srrW4m9OCblaYYVlC4A1vXrGFzmxIduZua8qQ0XaqW4Asu7hXh23y48wiZ/35DhTCFQZMAR81UhwihD34I91fs1Rl/zhP/3OSVkjtTMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194529; c=relaxed/simple;
	bh=DsJtSVR2FAiVms+3NUAosA4r7xeLm1fdPX2FqIYU1H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vyx1px7qMVXDLZbq03nYfdo69HtzZcS2L1hTiF1MB0iB6gwHRpnbCyvxQSv7kMyTOBlbpbth0kWYnhEYHJn8Aj07cOkSqhhnkSYgJDwF+z03BCXj8PDw9t5//udSMcgZCaqNemxXFeP24/K7HhMrfnYWCFN8Xex+sTM/LbP4++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=HPN7TsEa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MnNJsRCt; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id ABA85EC027C;
	Thu, 18 Sep 2025 07:22:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 18 Sep 2025 07:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758194526; x=
	1758280926; bh=JF8klN+Ypxvh4q7BTrSxqIYNo6Zuu1c2pmf4rhg8wJA=; b=H
	PN7TsEadiv1A6p5PKtA+HdyGDKp2K5fYXJUx8wc+7Wge1zjaf50Op5oByjV+U9dj
	g1qqVdEVrltShIqs7AQ0nYKDyWVJvpbpnJ/SfOsHgsxLJycqeTHG6UHFWphBr6sv
	A74Z1//gyXP+zUfZmOFyMepjTGYcZWzlsMYRcVMMpYEeDBxrIHEvfmvAfLr238dV
	mTErZ932q/+LYJXiyXXyI1Y5sTUIAwGsejwYt42AAozbcwYR0zi5zlIno7zmCM/A
	Zht6+CLq5tYNHTgCBJOvZB/1FaSwzy07G32w4eKsdYlTj1cxVNtYRZ+8i1S5pjx0
	UWpC0R8vBBlGq/lBLytAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758194526; x=1758280926; bh=J
	F8klN+Ypxvh4q7BTrSxqIYNo6Zuu1c2pmf4rhg8wJA=; b=MnNJsRCtFpCQ8/0Cy
	wat4pb/PirvlQfkhl7MaLNQ38toBIi2WIqACffDnK1jbbVGLtdV/bI+r+OiNEAje
	8iXDazoJ5nGTXuG+OxtJWXkkDuJepEamwUaT1SsLpcWNr1FSdvcoPBP4nv0DCwQi
	Kjq3hOhdUcHY7ThJclrnGCb1HYnScvL8Joa3p5EODCK1xOST3rRFltej+i0pnU4a
	WpM5NPW5np7cxrZaIY5JEOUraHfHS82OVb4ef+MvFJvzvqy/OGkAiIHglBuiexeV
	tvxgNGUdfni1VWmCpoxS4T1EjO7fTqWr3PMic9/nUvlO5HiLAoi4xOsSWE9Qy7+B
	P8tGA==
X-ME-Sender: <xms:XuvLaOhaRhgwY9i0cMzi7gSsn7XFgzzUtLL-AuuPMq_IZZtButwn3g>
    <xme:XuvLaJ5Aff_rawvaxv6TAcMWnZ11BIs3hNBySE-LiZZeynxr8UUb6RLQbDEcLqI9N
    hli3ClimtgCanZyFsk>
X-ME-Received: <xmr:XuvLaATDcLd6DXnaIjQU7JPnu1J5RNvIRGQvF4fPoszEU6qA2ggRay09J2vlrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegiedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehkihhrihhllhes
    shhhuhhtvghmohhvrdhnrghmvgenucggtffrrghtthgvrhhnpeejgeevheeuieefheekle
    eiheefkeekieevteefudefveehhfevffeludejgfehueenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    epuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhughhhugesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprh
    gtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdrtghomhdprhgt
    phhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtoh
    epvhgsrggskhgrsehsuhhsvgdrtgiipdhrtghpthhtoheprhhpphhtsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehsuhhrvghnsgesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:XuvLaI_e53nSiG-HtegQ2-ArbMMG9bV8nqg7c2huLkIooPp5HpcLHA>
    <xmx:XuvLaBq7uqO3B121XWMb9f5FMxBGPyNveuWbkvpOPgNiEbFXqquY8A>
    <xmx:XuvLaOULQGGq_YJuuRd6SOmah-k070H_wFAw4C88bUW4sqN1zTt1Mg>
    <xmx:XuvLaG6Yki06THTaeVFkrClSxyAdXAp9eUs8emTL31UMR_7NMeDf1A>
    <xmx:XuvLaDgoB5i7WgUKQUlGvgX9sC0VLA-HLZyGGxwa-XtgWwcCQoQp1-mB>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 07:22:05 -0400 (EDT)
From: kirill@shutemov.name
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
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCH 2/2] mm/rmap: Improve mlock tracking for large folios
Date: Thu, 18 Sep 2025 12:21:57 +0100
Message-ID: <20250918112157.410172-3-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250918112157.410172-1-kirill@shutemov.name>
References: <20250918112157.410172-1-kirill@shutemov.name>
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
mapped and safe to mlock it. However, nowadays the caller passes a
number of pages of the folio that are getting mapped, making it easy to
check if the entire folio is mapped to the VMA.

mlock the folio on rmap if it is fully mapped to the VMA.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 mm/rmap.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 568198e9efc2..ca8d4ef42c2d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1478,13 +1478,8 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 				 PageAnonExclusive(cur_page), folio);
 	}
 
-	/*
-	 * For large folio, only mlock it if it's fully mapped to VMA. It's
-	 * not easy to check whether the large folio is fully mapped to VMA
-	 * here. Only mlock normal 4K folio and leave page reclaim to handle
-	 * large folio.
-	 */
-	if (!folio_test_large(folio))
+	/* Only mlock it if the folio is fully mapped to the VMA */
+	if (folio_nr_pages(folio) == nr_pages)
 		mlock_vma_folio(folio, vma);
 }
 
@@ -1620,8 +1615,8 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
 	nr = __folio_add_rmap(folio, page, nr_pages, vma, level, &nr_pmdmapped);
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
 
-	/* See comments in folio_add_anon_rmap_*() */
-	if (!folio_test_large(folio))
+	/* Only mlock it if the folio is fully mapped to the VMA */
+	if (folio_nr_pages(folio) == nr_pages)
 		mlock_vma_folio(folio, vma);
 }
 
-- 
2.50.1


