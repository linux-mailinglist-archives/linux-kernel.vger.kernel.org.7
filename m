Return-Path: <linux-kernel+bounces-828821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAFBB958F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C2A19C1CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3BA2F6587;
	Tue, 23 Sep 2025 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="HNjaJRtp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AWz/3unk"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98233302147
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625409; cv=none; b=c53Zhx1ak25REdQIS8YXjYii3j2HbGNsj2P12P2sPeQzQ8di496NajvYIgHhUuOnjpfku95H0mPpF/j2kCSy9k8hXUOTha6VNwXVikurvGYHZcRRpYh2RzrcxeZxt4s4LlpSSYfuJWMjHhS0qyCuXd36R49vaiY9aN1ntrDmNdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625409; c=relaxed/simple;
	bh=zgThalph9y47lmEr32v6T0NLRVPpwukomwHn+9xtsDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpkXuGPEzSPCXJtNwgecATLUUmQqBqoxqk+tRNprADkrL3jTa9V1b/ly1+hg3pzCpK3CVU/HudLON3nT9WQTaMSBX+xTATV2GkYz4+X28aQFk28/GSVIvph1qwVPmishZLqI6iqJ0m5Qf5o4tJBDm99nUSvZ3uUhgY0wXhQG+10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=HNjaJRtp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AWz/3unk; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id AD25FEC0040;
	Tue, 23 Sep 2025 07:03:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 23 Sep 2025 07:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758625406; x=
	1758711806; bh=gBJQwyFG/mBuy6u3kCYzOX5EZriO4heRBy+k+i4RgPY=; b=H
	NjaJRtpsVfOKdVDwAZnJREfeF5y0jmef00dfHEU6FnuZe78bUl9WNwf0tkI2FKgQ
	+MruUEBEyzY34kb50Ydfx1JcJ5RYn8ORHRCJ9+DgcUFB1Kbb070TrFo0bqgNvZFX
	hzt8q0ePr2H9tM8LhOZcSVZKKdDxWHj6GjPpXQMcmvljpdzWt5stgDB0z9WB1nqE
	3jAMak8hh8uNn36LJbKhWpl4Md9N8ldu0+6D0uSfCYWR5oHOj18hC120XehNWB6e
	cd0D44xEkHt5oAUyanDho/eDthOl/CAWOgFYGBacxHsVakfTOZ6+H+qSsAKJalEk
	UWfZQKTMpSLKb+KFMegIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758625406; x=1758711806; bh=g
	BJQwyFG/mBuy6u3kCYzOX5EZriO4heRBy+k+i4RgPY=; b=AWz/3unkIPlNecDqF
	gsNQmFd9BnXD+PgyKYnbcxwCMQsGZFp2dkrixlckj8stfErNX+hchm7Roydn5PGA
	gOUmYrtngnlasCs0ua9uisXOnkZC09TTscIx4B/pnU6q7uREzHCXQ8ZKyd0Shdks
	mpaZ/EKB1IxlH1fr/has42Mj4zB5H4/nCsPM2nrFF6eUuPj8rdqKDqSzXn0B4Yel
	fNCMSlg/XO+5qnZ0x19UuyJ3Kx4YBhRaZxmQ+4s4XwAR2zEn9s1oC8Sqds0O61k7
	yrF7g+KnIrG0ggu7yLm22yiSc+XWMsrTlDbuPuNhKlsNZaI+ANTKTEVd/mOa83fn
	BlYig==
X-ME-Sender: <xms:fn7SaHwasEwXoM51YrHZ0O3f1ukBfW7kZ1CnlBbPnbQiWy7oCeEl4g>
    <xme:fn7SaLNtWxovas7NVfQhLMN_Qtp0_dPIabtA_l_8PlgghAGYCrFwnHwvy18nlKybf
    5EjNbU9gWu_FEOZAftpiWOZCBwa3eCX3pQAXpiUFLe3KuqFxK8KGmk>
X-ME-Received: <xmr:fn7SaHcjYnvwJEXtb1uuGrlo2neJ1njXEbkt_vBq5tIIGOguXN-gqCXz28c_ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeegveehtdfgvdfhudegffeuuddvgeevjefhveevgefhvdevieevteei
    vdehjefhjeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepudek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouh
    hnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohephhhughhhugesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilh
    hlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlohhrvghniihordhsthho
    rghkvghssehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtth
    esohhrrggtlhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhr
    tghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsg
    esghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:fn7SaH7c_7p_csMIeM9cnpiD6GpokB9xj1XZG9CSdzBQM-aRrhrNFw>
    <xmx:fn7SaHLI8RNNBEClF2-GcL88x86ItcfpAg0biZU2wxfNo15B7XDqqQ>
    <xmx:fn7SaD5gSfoIsXsAk1D22_vGgHcTybTdzU9vfMS1a0_poan3CM35Cw>
    <xmx:fn7SaObNfEVxrcxUDNs88YxZYUnTy_S7p4aBjs15w8MCL8TMbgew1A>
    <xmx:fn7SaK15_f3E18R0L66AyktqPKQzL6Y7u30szSUltkfRrVB9QLwcvu5Y>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 07:03:26 -0400 (EDT)
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
Subject: [PATCHv3 5/5] mm/rmap: Improve mlock tracking for large folios
Date: Tue, 23 Sep 2025 12:03:10 +0100
Message-ID: <20250923110310.689126-6-kirill@shutemov.name>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923110310.689126-1-kirill@shutemov.name>
References: <20250923110310.689126-1-kirill@shutemov.name>
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


