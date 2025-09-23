Return-Path: <linux-kernel+bounces-828817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512FCB958E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268C12E6841
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0D43218DA;
	Tue, 23 Sep 2025 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="X94OxRck";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eBykFhZL"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C09F321268
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625404; cv=none; b=XzZk4PLOc/zX7lDfUR+aZ1f1gx30ltgWGEfyoWtJjvFfHImOOyfTCr2rIdd0AJfZQpsba7N7IX06qeA13L4Gfg0wIKICyroPm9cG4P06Ej13sYCetMc4KrTcQitn5J1XaYxYD4C2SKVQp4QTu/NQvPtMsxMiKIGhZgzsx6PiYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625404; c=relaxed/simple;
	bh=FO+dE9pku24uLN8N4NL+QT6mBqrNJmrCztRwBtxu04o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eb5xfinEgfnTJ5hwzzPUwdwKdWZDKNQws+Tz13BdiLbZITyF1AEuuSJrLh7uinWXDJG8E6WlHNQwcICoXqZf7ZFL/QG4uHFvh91iVKgXL8mCZMN4akZdlBRHDKNB64RKJbuGRMqOGhVK1jvEHdHKNLP1CfYA5gI/im75bWP2xUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=X94OxRck; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eBykFhZL; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13793140007F;
	Tue, 23 Sep 2025 07:03:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 23 Sep 2025 07:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758625401; x=
	1758711801; bh=BDBl7oJGV3fWpTYYjjz2yGgNlw4zY/i9bG+IwFihDok=; b=X
	94OxRck9RS3KXkLR2kgprjzcjR2TMNPXUrpCff15/MeG3qjwC5e622rJ3fpKHdhs
	9+asmgb0zhY7IX7Ck0dG4w5SnIfuh2/G+v+NqNl5c+s5Jpz32JVn7Rws+F1fszDg
	oVPUtP/0taH+vQs5dI+7uWH2Osh2RRHdM9Y190RPr4AhCB2FGJEhgPTej2+RF1A8
	Aj3pdGm6lzGIBc/crz1NsHHkcUOhYs8jkv6KxWVRfZipfpP3vHMlrQN0zlxxE9u5
	H5nXk+GsiciJ5LFP6dRl+oGdJy1MEH49sXBBPyD5o8y19D2V96nyaKPk2xtThu89
	Rg65mVi+JhShKcqtUb/yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758625401; x=1758711801; bh=B
	DBl7oJGV3fWpTYYjjz2yGgNlw4zY/i9bG+IwFihDok=; b=eBykFhZL/pnhgwzO6
	a0BLPrLSjos+DE2PcwOb9kjK8H0CQ57EunTyPSfwI3Ad2MsNxprbjJUfWzDR00hx
	HP2OnZVn1FXOjZ2DRhmqA2Tft2UZ6ZowqItiSBUe6nAOvaWzBAnfEZDKQfpJsKoR
	KAxydWbQfKGUdq7qp9OhmkjZakt/K2TZhETisaqg7D4RxL1I3Cgo8sbJqnfP9Y9M
	+/5xDPT8m99Kl/AbzHYwIaT6DXye7uiRk1cLL+cb8AXhAL1ocpFrZOPIiED0VoFC
	6EbfEX5AFNvt9j0HPFRyEK92PFqVbB0193DO1URMQgakrEoW5Lc7Zx6jgGQGgOKH
	jdQ0g==
X-ME-Sender: <xms:eH7SaEEnBouU8viGPz3Xt_tAS6xuib4V6q6OGVKV8nliqpNU7iBHIQ>
    <xme:eH7SaJTbE5CPLWPozq3wuGgfIkGwJJtHMYLW7PJ4RIKpKWSZ3YUYsBWnQl_MS9ZQC
    U--FM9mNPPzuxpfNwDbQ9KlH6IpVx4H5pgXKcpFIJzJJxTVmaQ-yAE>
X-ME-Received: <xmr:eH7SaEQSDbdmbPYgKJOVjnz5DTXy-idgGla58KT7c6dHaAMTSyoKuYV-CemOWg>
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
X-ME-Proxy: <xmx:eH7SaMe3T6BWg8MY6sGH2CCqC4iHOBXQPXR089cvix5oJFJeR3ssaQ>
    <xmx:eH7SaIe8QevXnGJyqPQtgBBDKAw3HFXrnzw6BwcAXYdGqJVj0LkGiQ>
    <xmx:eH7SaC8r-7WkGxo-RTNrrc0lV3LFD1IYW92nGuQZHyjX0zEvydtjEQ>
    <xmx:eH7SaIO8sAC4bkh_nT7UPOFSlXhHvnKCtpHQuH2lr4Zarh6wngMWDA>
    <xmx:eX7SaGKy2F_9OJ82Xz3AodbFgkFVEbFqEZE10d0UKLiYX-M_Kidkzy7B>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 07:03:19 -0400 (EDT)
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
Subject: [PATCHv3 2/5] mm/rmap: mlock large folios in try_to_unmap_one()
Date: Tue, 23 Sep 2025 12:03:07 +0100
Message-ID: <20250923110310.689126-3-kirill@shutemov.name>
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

Currently, try_to_unmap_once() only tries to mlock small folios.

Use logic similar to folio_referenced_one() to mlock large folios:
only do this for fully mapped folios and under page table lock that
protects all page table entries.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/rmap.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 3d0235f332de..a55c3bf41287 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1870,6 +1870,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	unsigned long nr_pages = 1, end_addr;
 	unsigned long pfn;
 	unsigned long hsz = 0;
+	int ptes = 0;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1910,10 +1911,34 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		 */
 		if (!(flags & TTU_IGNORE_MLOCK) &&
 		    (vma->vm_flags & VM_LOCKED)) {
+			ptes++;
+
+			/*
+			 * Set 'ret' to indicate the page cannot be unmapped.
+			 *
+			 * Do not jump to walk_abort immediately as additional
+			 * iteration might be required to detect fully mapped
+			 * folio an mlock it.
+			 */
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


