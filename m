Return-Path: <linux-kernel+bounces-824534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E65CB897FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3790416FDCC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97AF2264DC;
	Fri, 19 Sep 2025 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="gYaoqNUW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oBRMyPX6"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D48221FDA
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285654; cv=none; b=ktMW8///HggXG63AcSEq9vIWWfKdV2Do7xRGF/lafGwsuiZ+0qJ+nZdw1hkgkJXOnyf0KmPEbvpxWRVP3aNI4iCtt0oW/f78RGJNMRJF2/259PzxU9VL2Odb5SAin6efa192QLT4busbNvRwpc61EhFN3L7MYOYQgtMbYnvfhsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285654; c=relaxed/simple;
	bh=XChvTvuq/7NeECGDeUSWMtBEaCBZNCfi/y1ZkjW4cx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOWsBCW4eSrEw2SLk4JO/CecGwNHSrcRYtORVhZYkxKOoJORoybUz2fsUctk9n4CAWG6hz1FCi9X2lf5SkDv+gykIXrebAb2vdbmLFzpfsssnoCZFuAJQQvxnAW558dGor3+e5SnpAKmgJH8LLkCbQjRQxuzxeLHkCxhioEgxSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=gYaoqNUW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oBRMyPX6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 63487EC02D6;
	Fri, 19 Sep 2025 08:40:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 19 Sep 2025 08:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758285651; x=
	1758372051; bh=TC0qa4dJ8ZfxpD8eOHAvcq6Kh4/gpC+GYroIRc1A+zs=; b=g
	YaoqNUWaKHhvv3Ed4xHBXRktxSLULfs/iAAuYrd7j55EZwLmi18d89+j4kySwA12
	5SyZ2uYXjdwz3FmJ82Kk4p3w2wCOYWDmriHFwCmlw88SQYiMNg73I3OUH5FsYGKo
	4qxeC+AqeN71HV3IX9QR7a0wyomCVQhvXau8Gu5fldftzhhA6CetYZelZH8BPMGq
	EBIYmWRo7FDIkuy8YcbteuqPik/hKtWxRdlsqyYUQ5fNRkfn6uW2wB8K4RWowICL
	9WJTQUpVnMwtHUz71tcKCab4m/huYVrtpsMV8gX9HISY15uJj+C+rfv0sCire3yv
	oiZy9DUWJOjm7E8AwETOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758285651; x=1758372051; bh=T
	C0qa4dJ8ZfxpD8eOHAvcq6Kh4/gpC+GYroIRc1A+zs=; b=oBRMyPX6XhIiUnMzG
	jhA/GKeWruN58gwnj9eQuLD1ahHUAjCToZnr7lsMkryuiYuOpTuc9m1Fq+WwJa66
	W2cj6gXLpeu7xZofG855foOYmB0A6U8K8JfoAycT77K2kRM6Go1BJtF3nF7BwbNb
	VKGPFVhKqORsZS2Q9HVK6JTfeH8ahXLvp5vR3WDi7YDdAKruMYWLUC4M/8EWt/2m
	/c8bJZkh2BeKd3FwPtK+ox3Vd2Qg6rDhK23e3j29qceVo3pvPArS9yEljfsqnW7F
	Hmx/b5TA/PrQPyLNmizITnISEmUhEcTrCaodCVpfFnx8oiUscKm8DZ2/ORunpIFc
	kTCKQ==
X-ME-Sender: <xms:Uk_NaLx12g527lLRr8ab-q6rf-lKXdZuTxxXWpfNE8yPF5UW2YMfKA>
    <xme:Uk_NaEyl_Oy6W_x6mvM0J1N73IRP2w7r3qUeXqsQaqGjZiytZj_B76Vz_IqMQHLuv
    Gxk60CB3zfLDyDMLSg>
X-ME-Received: <xmr:Uk_NaC-CylDn64zzxcQxRKKQdlEkIt3fdkL46R-qcdfIhZoKbryy27MuFoJ86A>
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
X-ME-Proxy: <xmx:Uk_NaM9aQynDmY3IwdeGcxb53N8zxhLiirYpR6A7lyklttLAT8VDOw>
    <xmx:Uk_NaNc_QOusRX8iTHqFu5nOg3grSXPV-BxstZC-g7kNgPMDWlHE7Q>
    <xmx:Uk_NaAt4iXraghTT5OqP1wQbj7wIJJN16LGeS8VbH_FQwu4cwCuUAg>
    <xmx:Uk_NaO2VoEST3kgdDy3gJLyoDqyy8mThO4_NNydG4kpeJreF4L8-OA>
    <xmx:U0_NaA4E8_qKm_qZyNl8qUs8iUVmPJ9bPMLHUl2T310RpggJiqjCgrIZ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 08:40:50 -0400 (EDT)
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
Subject: [PATCHv2 4/5] mm/fault: Try to map the entire file folio in finish_fault()
Date: Fri, 19 Sep 2025 13:40:35 +0100
Message-ID: <20250919124036.455709-5-kirill@shutemov.name>
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


