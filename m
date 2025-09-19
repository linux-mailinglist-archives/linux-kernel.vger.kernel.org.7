Return-Path: <linux-kernel+bounces-824533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE815B897F8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DE81C289C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916B21FBEB9;
	Fri, 19 Sep 2025 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="NSYViHEW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kDbBi8RO"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC024218596
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285651; cv=none; b=dYskwqH7TAiURCLN3mOJqfI6AHfDJZCAgeTNefKtaBTuKYLZCfJtYxSO589cZSXsvzeAf/1XjXR+ZXakblfiP4kxE0mbF/bhCkRBREIy0FL2ddcASfF7f/7OmE0NI7i60i03vDhTzm+JP+V276JcGXZMVU+81AgIkLj3UzdpHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285651; c=relaxed/simple;
	bh=z4mJNmjmw5N0EDvGoxq7YE6LN2fEWNHPu/+UWlYFCxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBFYwD2LojHtBoger+1P9YadE0Xq8ga4ESJB6oh+7vSuJxLR8JpdowMGEBEDumZ+SYho4uLQuTkEcjYYg8ABAbPV5FxmSK8oIkkRwoMO0hWbySnaNxAdDK+fB4rnDjebAIe4FOWAEgMUdY+aGp3ugoO9M3TthiO3Zbe4vKUicXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=NSYViHEW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kDbBi8RO; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1FC241400185;
	Fri, 19 Sep 2025 08:40:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 19 Sep 2025 08:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758285649; x=
	1758372049; bh=zbXQCXRSraPiiKdXSvs7n/9rDBYdGNJLDwAjIbxUIRs=; b=N
	SYViHEWild38F6WS9INcKPuheF7zhmeVta5B2MH+Fd+EwozMYQm6PWZHXG35G1+m
	+S52ybxYtD45Hnu1i+BTPyUnqas5Tvf7M8JEkvVL1Ff3SUz2qn/Bahb0dqCpZbE1
	sYKDzJlJ2zUUfQCeTpTVOJaY+irQeFVMpbqyVwEfH/MB4BBvzNH+UKmgjIIPDPSH
	6lbtRdOJi7B5Q/O44aamoO+/3A4lS4FqtnXMvaR+6lxDdSRC3dKkPtvFlw/7BRYX
	fSskhHDFupDuGZ+0kkKb+wUnhdonyzT6ktH+dT4juPa17rPxn2z697+ihAg0Y+Bb
	ZY0e39ykKlHoGZD3n20DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758285649; x=1758372049; bh=z
	bXQCXRSraPiiKdXSvs7n/9rDBYdGNJLDwAjIbxUIRs=; b=kDbBi8ROkAz0sn539
	NhdcLTG+VbQ9pN9Z9Bgf6YgHXcLN8AqtezTZDXrz3R3e94vrfzmJmJm24utk/EDI
	q51KGt659t2FKcxTy3TVoO8od7xmBQH8IQqiUcdDkbKG8JwYjKClS8ycT7KSxdnu
	zMLmhcx7nh5BmlXMOl+yrlDzQOTSRwF7B3UynnkjsaNaDgEjemoyV/+RnpuEq1/z
	P/KErjnLjw1vRNWofg77Afc9LD233PoaUogKpHWLEu+XCxfYN590e7aJyPbOVRfR
	bT03TDgVRy02KICnyaFMsyZZrSVw0c5iS57ULiQUBhyucEAoJhR/T26aPoy12f+9
	VzsvA==
X-ME-Sender: <xms:UE_NaOIynym39jH7ipn8OgrnkfAMPu0hrcl38pK-fLeMRQQ1X3r6ag>
    <xme:UE_NaHpSuWdNwdYEvmuGjQY6_hMNEmYVqJbQ83ShFQOdCdLvJlPX8asL74lLCUond
    x7q7YBuGlaeXVodXo0>
X-ME-Received: <xmr:UE_NaMWSH6G6mWwDcyHYJZI17YaQ79DFb6ZRU-aPVhhtSFEvDZht6xlZSBI08w>
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
X-ME-Proxy: <xmx:UE_NaK0uqiiVdtiGAGQ0IVnUYxR-YLHrzt-EWVsWnlN3pM1riBHZdA>
    <xmx:UU_NaF3pCeFGH43GhX_HKjpLGkGnOmRuA9_YLLIoEEubMdi_qOdPSw>
    <xmx:UU_NaBkKPcsu-XEdPZ-27U9G1b_shcsWLWfEoCQmHOinO1lSSYEVRA>
    <xmx:UU_NaONZNr-E-fIDhOA1sTQIzxJiyLC0IF9bWBsTMhbcY0b9ayuU9w>
    <xmx:UU_NaB-en_t2e6nqwVGnn6SZ1vYVZXSK0aBtHqateyX9wMWvwQbFF3L9>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 08:40:48 -0400 (EDT)
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
Subject: [PATCHv2 3/5] mm/rmap: mlock large folios in try_to_unmap_one()
Date: Fri, 19 Sep 2025 13:40:34 +0100
Message-ID: <20250919124036.455709-4-kirill@shutemov.name>
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

Currently, try_to_unmap_once() only tries to mlock small folios.

Use logic similar to folio_referenced_one() to mlock large folios:
only do this for fully mapped folios and under page table lock that
protects all page table entries.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 mm/rmap.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 3d0235f332de..482e6504fa88 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1870,6 +1870,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	unsigned long nr_pages = 1, end_addr;
 	unsigned long pfn;
 	unsigned long hsz = 0;
+	int ptes = 0;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1910,10 +1911,26 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		 */
 		if (!(flags & TTU_IGNORE_MLOCK) &&
 		    (vma->vm_flags & VM_LOCKED)) {
+			ptes++;
+			ret = false;
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
+				goto walk_done;
+
 			/* Restore the mlock which got missed */
-			if (!folio_test_large(folio))
-				mlock_vma_folio(folio, vma);
-			goto walk_abort;
+			mlock_vma_folio(folio, vma);
+			goto walk_done;
 		}
 
 		if (!pvmw.pte) {
-- 
2.50.1


