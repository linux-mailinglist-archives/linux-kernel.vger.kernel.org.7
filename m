Return-Path: <linux-kernel+bounces-824532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE595B897F5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CF15A3EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CAD21C9E3;
	Fri, 19 Sep 2025 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="ijmm53xz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i/VJuaJG"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE8208961
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285650; cv=none; b=a5J93dbBd8XqwDDgSvzznlPOBxtsrzw7R1QjstChsvz7zI5Gti2+nz6eu8zUa7Sxuj6Of1OSRz/29kn/6idv9kqEs5goIy1n4B/1u1oGgMFxEXMI5jPtf3E5B0q175U1IAFsOokXCfQngEs0TCDI8Sa9a6QtEUGZO25s/zehRBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285650; c=relaxed/simple;
	bh=GSkyuQksWqUgGXpyT/BplWH9AtYMLjAZ8kH9P7wgzKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pzijil6A7kLS8OzCi5lJ4vnKDfpseoZHC4gqX1jwhceZupwn8Ve3PgTMA4S/Nc04ZW9BMtzmnTkm8LqskAqwn06bOcM3r15SQlOdWyWACaWW6sSQpD+9Gp01ZSDlqSl82BpC6R+mSD14vbbzSSdEOVGOyJps0yVprJDfeWQLQPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=ijmm53xz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i/VJuaJG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5ED21EC02E4;
	Fri, 19 Sep 2025 08:40:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 19 Sep 2025 08:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758285647; x=
	1758372047; bh=KaO9m7USZDrpygot74UDSvojuR6ldLnT3ppbJu8X6HA=; b=i
	jmm53xzPDAUdcPUioFKoDAmGFp4tcdczwXpAyJ9iWew3LsPRnCro82mtzbqx68hz
	36Hf1upGlF8e00jOhez2AHxsaykCZXzjNFNq9XkBgWbtROd5WU2fQBl0fVBWA+0C
	VaZott2TwvoHzBMTQmbMSGDnEMFrxFEZFhHrZU765KTHMUMI0BfZo5S4RnuhQcRm
	JH0hxVhobBXhnC5jbX9pW4579cx4SeMyba4uAnWIOS3tEHLZifNnDCxLc26mDMvg
	XXiaDzyR1VRuEm9rHgriSVAp3tUrFRWQCefFUN7D7nWkb6roClcURlK53LoShdwP
	JzwZnMxZeQ/6/JnYfD99A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758285647; x=1758372047; bh=K
	aO9m7USZDrpygot74UDSvojuR6ldLnT3ppbJu8X6HA=; b=i/VJuaJGPik9isONQ
	Jrsb97nBw8WpsN2BNFsuFvX9e2k7BD0ZlYRMB/BfN5xScBHtQ6Y5OeZLsDLSyw6D
	UBzKy6GiVc1swjsVen1/3ztwzZwNqGNf4CLQShjVufqKw6lFX9iepMHurL2EH17k
	nrym6YJuL4i9cMlVai5+w7WsUBp4pEsngL0tPFCWTPJzXwTXwgB0VnB3ycZzyoSp
	ehcpM1RRXNLbg3ZNN8Zhmb5BhTOilxGS+5RjQ+Qvtb87URO2qVa+HF3qBPmzL6aM
	pNoaxj+hk1aZcg/2e+ojbPD37iRKW2Rtb+kx2D8y1g6rqvqr8Lsyy/2ohnfFqyka
	dVOGA==
X-ME-Sender: <xms:T0_NaGj-0sQ1ltiD8QHha-Y-Z16YdAd_oCQHrk_3RxPBqPvom8K4mQ>
    <xme:T0_NaIheKdnqriUKoeeabDZMbQcBNXzjgI8WKUDZA6jwWtwIo5tRpbWwQw8M-twlB
    MDYBaqpXGLz4T2R2H0>
X-ME-Received: <xmr:T0_NaLtIkdlwRu8Sgr7uK00MwWuoi8CbbAnZ-HYSChNhoXfFYGykHr9dcJud4w>
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
X-ME-Proxy: <xmx:T0_NaGusV20_v0lst65S5fPpr1Ez0DcA32xRKQQVv2V6Z_IKa6nffg>
    <xmx:T0_NaEMnCa0b9aVK23texrlZT0lmQsJ0jdzt8wX02K2SG5cs0OY8qQ>
    <xmx:T0_NaAcJj3xGgB-NusK7TVPOfBgz06GsiYX_hnAlyYmbCvdjjzXNbA>
    <xmx:T0_NaDm5kVFFR6W87La_OdxrczdVRb11UIKe2hQQLHb4ZzUc3TYi1Q>
    <xmx:T0_NaM1mc7qcc6OruZS35q6AnWwnm-tDrZPWmbdtAi1HfcMNPVydxFPg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 08:40:46 -0400 (EDT)
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
Subject: [PATCHv2 2/5] mm/rmap: Fix a mlock race condition in folio_referenced_one()
Date: Fri, 19 Sep 2025 13:40:33 +0100
Message-ID: <20250919124036.455709-3-kirill@shutemov.name>
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

The mlock_vma_folio() function requires the page table lock to be held
in order to safely mlock the folio. However, folio_referenced_one()
mlocks a large folios outside of the page_vma_mapped_walk() loop where
the page table lock has already been dropped.

Rework the mlock logic to use the same code path inside the loop for
both large and small folios.

Use PVMW_PGTABLE_CROSSED to detect when the folio is mapped across a
page table boundary.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
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


