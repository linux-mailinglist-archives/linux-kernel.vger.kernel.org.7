Return-Path: <linux-kernel+bounces-828827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CCFB9590F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EE33B7266
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03EA321F37;
	Tue, 23 Sep 2025 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="bYDfrPdI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GoWm7xyg"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DD83218B1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625645; cv=none; b=X7JqIPyhL536e0owLJzmlttSJoCkcI0rxQfoa+NMb7GFwoSN5JTULsrMN7f92nKrhaJ5OhddvkYRnWbQc6ObQP1XorG9aTGmOLGW8t/8sPIWFYVqXlHW8+51WyekO3+TBTj9j071IRc0rq44or2UifNlWNF7EJbso6cCoqwwyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625645; c=relaxed/simple;
	bh=FO+dE9pku24uLN8N4NL+QT6mBqrNJmrCztRwBtxu04o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZHYB+58nUZtrbSj2vxmilufC2SpGMeasQ6uW1H1xaLKMPKz5f41KWfmdi+jTTne5VagUe9t5o26AcJqTj1HV4uuYCncIjrbPSg1CyxBvIcJqKNftzvVM+JuLFSGp5ZlxNSDY5bnVJ1GwgDtxzK//1BIuE7Tlo742U6Y6evv5J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=bYDfrPdI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GoWm7xyg; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A1BDEC00D6;
	Tue, 23 Sep 2025 07:07:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 23 Sep 2025 07:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758625643; x=
	1758712043; bh=BDBl7oJGV3fWpTYYjjz2yGgNlw4zY/i9bG+IwFihDok=; b=b
	YDfrPdIwLq3lpWq8Cp7n9DYO74ysd4WpJtuMPtFJV1iBLCNy8gx7HapavVe3MXHm
	RTOk95bFEv+ePlAaqUcHUnaA3pvsnDyqkQQVbncp/9BNX1gNRvPqmPV03Y/N1kEl
	Fd6Z3dANWDnVM9Hj9NrzKqi3swXNIMH1nuMVyr2COZJnQYOkSIG1JEgAQyCoj6tY
	2Ld8OolThZ3JZG4p3rHs+GxGJuP1noXcv1VlKXrf0ytWv5gbfCCHhK6DP8vESEMq
	Zl1lWt+8Wr+Ix+XF79QxD7g71o+BcsORjrS85M1jtuiUAZGHSAe8s2/5ZPm33Kw0
	z48EJBb6zyoMxZjh9SdVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758625643; x=1758712043; bh=B
	DBl7oJGV3fWpTYYjjz2yGgNlw4zY/i9bG+IwFihDok=; b=GoWm7xygmn0tkjDqZ
	PlF1+IkarWlbQjFHpbOFCu38GtM/aAvtp4IAWfWnyFvYZCv36BaXhCr2iGRs3IOj
	LRvMdIi+Goe2J7bgVLivjD0EOEHJltnuLKJ1n4ckYsgk5mlt9LG7REDvvSTVZIJS
	7PxFqL0OxjshNDChp6wbgJ2UTKYZ/pWorkwlB9Z/GVDGKiJIPPhiRIUuJpUh50iv
	hocfaD9UHnYijdPFFS3KanNXvET14Y8+WsQxdTyNdNwr3KKpLZpDZDQ4lbytAODG
	Zg47EWCVG/KKuMvLcrKN2VMWmELwmQ0qq9iMUd5a11JrmTLVgrK56CLrWHYwop/3
	ZukCQ==
X-ME-Sender: <xms:an_SaIRKZT_LlqtT6TFRApLLCD2YUJWsf_R6HTMFJN__t6xoGbTlsA>
    <xme:an_SaBsRCHLkcr0QGPx34eUu-y3O-hxio5GqyiYDvPsYC_YgXaO36A2VjEf7KLuTo
    GS14zdxLh9GuioS2-_aANyOWv0_mGdgOf1xtI2zNXHuCYQOk80aLRo>
X-ME-Received: <xmr:an_SaL8mk77ZxZYpoqWQjHSC2WCcTBBU3UHB891XAn5GGKVmLyO6jxxZO3j_Og>
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
X-ME-Proxy: <xmx:an_SaCbyMNbty62O3IgNwpDVjLq5JBPcIon3GbYPx26fpmK4voXHSw>
    <xmx:an_SaPrwLGismfNx7AILjtWNbF_LxbY68Tl53pR293SD6XWhMPiXGQ>
    <xmx:an_SaCbSQ0sO5q5CWfYT0DdkvN_xAyXM-gOQI67F2Lf7_PhiVP6mIw>
    <xmx:an_SaK69VfS9Gmb25htXtKfAVW-uxYPD8JiHXASCtF01rbHrgK7nsg>
    <xmx:a3_SaD3GTpiQ5FPCraKdOQhLDzSCIf9qcyFcXJ84ixrwUa3TPXKCTl9X>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 07:07:22 -0400 (EDT)
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
Subject: [PATCHv3 3/6] mm/rmap: mlock large folios in try_to_unmap_one()
Date: Tue, 23 Sep 2025 12:07:08 +0100
Message-ID: <20250923110711.690639-4-kirill@shutemov.name>
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


