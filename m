Return-Path: <linux-kernel+bounces-822621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3DBB84554
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F57E7B1B53
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0B330496C;
	Thu, 18 Sep 2025 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="BjlnSC4I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O/N6HGa7"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB66C302179
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194527; cv=none; b=DRjGhoTFVlvA3VaGNtTajkwZU5GAnvq8/TPMZOh13Xm445UD23GStk1JT9m2p5KEks7YAtmLh3gKdcwljDyI/XDlIZTBc3VqZlaRiir6nvTPRYdkFW1HyPDQTCgEs+INfI20uBUsCTWZfkyAoqU9SlGPJ8XqsrU+I2z7J9ZxUaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194527; c=relaxed/simple;
	bh=XChvTvuq/7NeECGDeUSWMtBEaCBZNCfi/y1ZkjW4cx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvRk9kibQw2Sn2i7rT8jmvv4dumiGow/Cx1Ew9lk1wX0q45JNuAAL/SpskC98WJHTZKM5HrXFQmgGMw0dDwJdLFyqopaNYrEm9iLPjIEkJBxZHgLO+gMsC4FpxvHnZHcc5uEc9xXs1gRVd7DS5D0ioD6ByPlG6DxO2cEOA3XeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=BjlnSC4I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O/N6HGa7; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BBA7C1400189;
	Thu, 18 Sep 2025 07:22:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 18 Sep 2025 07:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758194524; x=
	1758280924; bh=TC0qa4dJ8ZfxpD8eOHAvcq6Kh4/gpC+GYroIRc1A+zs=; b=B
	jlnSC4I5QYishrFKnKK9wwyolspBZIm5+esjfdskwA4hWQHwKzW5aWOl8JP9pi6o
	yQw6Gwiku0EOklDIv2OfURaJ5tTTsAlzCXHK5oOnX+bdNpfur0ComdoAbdBkB3HG
	p0uImfDZSugFVh0wSpnz6EYcbZRQ4vO5BLMyP2ZbPI6bHY2WTH6ecO/X2PT1AI8K
	cM1QemB8AlPgdUZG2JpTouBOWzMzpdb/4xEspMEnWzlc/byyYb/P/h58xvzh2NnU
	CCGr5eZ6v35UYgc6OHniB+SSNfDP0lIWIvlKLTaPlCuseQnX+td5ErNl3n4YXCvM
	T/p8EHOxOD+j8wqnp+NfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758194524; x=1758280924; bh=T
	C0qa4dJ8ZfxpD8eOHAvcq6Kh4/gpC+GYroIRc1A+zs=; b=O/N6HGa7hAuX5edV4
	bGnn2ILo8TPFaev6z6I0mwCtmOAEfdX+3nYBwWA3z5IH3xVB/aSZGBp56/3OVPVE
	IPrSAn6AaMXOeG6v2Wl5c5PniiPDfff4Nfqxpg31U1TRrUGKAsSsLS7+pOJMSWsW
	7gb/gSJvxOV7fkmUOKt2Y2HcTrN4+JGCI9u0S2+hwVUjeFwQ7/V4GKNxBkqisF6d
	8RIrxJjUv7bt+5f3kX8vi7lJPLyk4Vo7gdZjs+Kt5y6Oaze9Ba/5V9Brgt+rj+O9
	yMkpKvheyoX5SURB29+fmqC0gJ6cweLNZ36iUytieeZf2dukPzJagYKnMqBuo87f
	NAGUw==
X-ME-Sender: <xms:W-vLaOB7u4XeQHsJeH_BZ_HrGgVbvLCpHK3Cz-RNTH1JT_DFjOtQxg>
    <xme:W-vLaDYam0oLeMlzIY3nCSKWeFtYEDfUCaeDPWvywiY8YKNPqM5LtOwi-HSI905fn
    98jw-6X0MHXOkxcOuY>
X-ME-Received: <xmr:W-vLaLz4xOyr5RnAEN9n2T4dwjov5cCxs8NKl5EiYzdL_eolVN2xq-QbSo4Miw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegiedvtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:W-vLaOcNpuyXooUIwx1WKBfD81GiS5toSVqHM6YicQPy474lLOsvcg>
    <xmx:W-vLaJLzXVKBrBcgeOXSzjjxQQ07NKqk8sjrzmzqNiWF8tCnrvNqlQ>
    <xmx:W-vLaP3mGoB3S1jk4-4dgoybx7vfY-HBR0oITCNEb_9q2Cw6DhLynQ>
    <xmx:W-vLaKZxubsjifAQmeKLoMUU5DHCW0hT5h6alCQKFuSFY3RcNjHDhg>
    <xmx:XOvLaJCffpWMSs5QtxvLbLXxpAeu_H6RSf_58M2pMGemLhBJOVxjqFO6>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 07:22:03 -0400 (EDT)
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
Subject: [PATCH 1/2] mm/fault: Try to map the entire file folio in finish_fault()
Date: Thu, 18 Sep 2025 12:21:56 +0100
Message-ID: <20250918112157.410172-2-kirill@shutemov.name>
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

The finish_fault() function uses per-page fault for file folios. This
only occurs for file folios smaller than PMD_SIZE.

The comment suggests that this approach prevents RSS inflation.
However, it only prevents RSS accounting. The folio is still mapped to
the process, and the fact that it is mapped by a single PTE does not
affect memory pressure. Additionally, the kernel's ability to map
large folios as PMD if they are large enough does not support this
argument.

When possible, map large folios in one shot. This reduces the number of
minor page faults and allows for TLB coalescing.

Mapping large folios at once will allow the rmap code to mlock it on
add, as it will recognize that it is fully mapped and mlocking is safe.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 mm/memory.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0ba4f6b71847..812a7d9f6531 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5386,13 +5386,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 
 	nr_pages = folio_nr_pages(folio);
 
-	/*
-	 * Using per-page fault to maintain the uffd semantics, and same
-	 * approach also applies to non shmem/tmpfs faults to avoid
-	 * inflating the RSS of the process.
-	 */
-	if (!vma_is_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
-	    unlikely(needs_fallback)) {
+	/* Using per-page fault to maintain the uffd semantics */
+	if (unlikely(userfaultfd_armed(vma)) || unlikely(needs_fallback)) {
 		nr_pages = 1;
 	} else if (nr_pages > 1) {
 		pgoff_t idx = folio_page_idx(folio, page);
-- 
2.50.1


