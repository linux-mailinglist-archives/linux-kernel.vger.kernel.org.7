Return-Path: <linux-kernel+bounces-852882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A06BDA29A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8183B8B07
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ED32FFDE3;
	Tue, 14 Oct 2025 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpmczhE6"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288192FE59C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453419; cv=none; b=E/Pu2tRJaSEJobOJye9a1CvfxvS+CJbSKoiXEKedEVZwY13SXvfEGipCfOVAZheOJ6FDCWSafD6fNbWFldQaji1fW5LgMjQxxMm3QhQIU5VyKpLX/CMk43eF6t8J3J2TPBqbZVP2WuM8S8LmkJLhuLRxhURAwi6VTBDLmgxWn5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453419; c=relaxed/simple;
	bh=gM4BHnwAtz6HI7EhDYS58J8f6agfCCs2MKOQf2OwZ+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHOR6NMbE0ZdMXEJVn+MRzpuvxnVLuXp8zaYRGT7ULTaB95f4dL8MSCKI5ttvZpKAxjzGQQvsvIzl2bSV2g33rJhIiNk6g/3uKBeU9XWlmMQCpoGWCY9GFcQWQx7kB2nY6Wgeq0BRkTISDDmkXwAd0IjvZKoiokxePlCmJxkds0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpmczhE6; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-77fac63ba26so53130427b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760453416; x=1761058216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClhLNJaftDP05NzJp1lkBa4h24q4WP2h3MIN5SIwT/I=;
        b=ZpmczhE6vR8IU/AEBHko79LkBd4LPy71TAhgZN1v2meHjt4VmCb+Z1VZ23Ct6tKxWh
         +oFCxMhbhk9Ff7HFcvoQsOteHYv0qKvINUKBSpaLROGP12OGuUQwNWQd/ZDdgaRlLTlM
         Sni5mL+1uX1+9TV1ZVGPEevXpV9kI0/RSPH0vF6sPnWJN+uvWtXRaw50JtSwpASlEVrE
         qWNrGZ9VfusqS427snAMPRLbn9jgMMvVJ3yNG5ZLQn2FY3LwkkXNEvSUm1IKJ6Z+4GbJ
         cHcL1oUFfSsuWRQm9ngz+VpzslBFXVPq+ZTQ/K6eT5oIrWHyJf2hmUNNM9bAKG59ahBU
         0r/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453416; x=1761058216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClhLNJaftDP05NzJp1lkBa4h24q4WP2h3MIN5SIwT/I=;
        b=Eks/tv9YGrE9BqZpKQX5BTHWLhqC7nG36DnSFr9/eCAlnkhiFzi4E2qhUfD+YxL7Ec
         tXF3uD0jCdBfeuTpIirxfo7oL/VvqMTXEsInKge7nOmjdTO+Nzuk9zK/2cqlElH6xYmC
         1FEMlSEp45oFsX/vabiKSfbFT6t+miZVD/1tKQkHd89VAmx5CImUUfiOxvcIgErqVBcE
         68+qtOvkU7mRxioN8ZcOifJVoZ9FQfzE/OY3e+ZNvr1MwhSEXPAyLY5J3wqTRSD+eFS/
         zA4bAbQB6VYsZ3R1OcEMPu4fUgu4C3QrMQcHo39XgNBcVYL2V9QZHpg+/ioHBL3P9UDR
         ux2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnkS9UWNwf8FG40wre+JV7GNMqKsVtcJtb8WWtYtNvvNnLklMmCs4N2vN8VLtY3zn4MTa/ddWchEdnw0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlOSbVvy029KHTz0alXZI7ZLuEUAlSDnLZMMdv9FRJ2kJHCbTY
	VuxuT97uD/YZnpiwCFS8GSQLULiC4a43o2OjLiNwBMBGHSNs/Y9CuyZS
X-Gm-Gg: ASbGncsinYhRlo+Lu56uWXGOp6HZCQIb/HF8fNPZsNS31XRhToYv5jNuXyGSxzbVpgQ
	pE3aKGg2GnhFcrjgu45PYyNfaAeh28J/Spm9c2G6knm5OSOwmIj+N1QEErLKDddn46ZGcKRtiuU
	a7I3dzIl9Js50imvAII5oWB6HeMFF0R+MaVyKYpMrgp4ieS+JvEaF+V9pVW6RZwjo7hIqcUd90j
	FfD9zRhQPFKbeWsmlzNPs7fw0zlkXzOc+4p/oo78vdEAPM9p0HwqbEux52Y9phwiLP65XoDpmwo
	X5GLTCCeTyiZhnRhHAbMaDq3g6Q94pr8oNQoTiL/l1NGErm1eraM72z6SaJy+/+pyYgQPLVSwEw
	EYCSOkZxyJw1e+9QpRSY1klo7EA20Ki8L4U199NERQiLb59pPF5kDpp90sVL3f5E4SdWq1MrRGe
	Wm4Z2ibZXBvHJGx4B/r1U=
X-Google-Smtp-Source: AGHT+IFLwCmMuwzIce9/aUOI7BcbPoJAhUZpDPqSafzbEBP4ORZ6NkkDdl2noKzyFimA8Zx/Uj77vw==
X-Received: by 2002:a05:690c:d06:b0:735:7cbc:a935 with SMTP id 00721157ae682-780e13f5099mr272944127b3.11.1760453415821;
        Tue, 14 Oct 2025 07:50:15 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78107205820sm34229117b3.31.2025.10.14.07.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:50:15 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v5 3/3] mm/page_alloc: Batch page freeing in free_frozen_page_commit
Date: Tue, 14 Oct 2025 07:50:10 -0700
Message-ID: <20251014145011.3427205-4-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014145011.3427205-1-joshua.hahnjy@gmail.com>
References: <20251014145011.3427205-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before returning, free_frozen_page_commit calls free_pcppages_bulk using
nr_pcp_free to determine how many pages can appropritately be freed,
based on the tunable parameters stored in pcp. While this number is an
accurate representation of how many pages should be freed in total, it
is not an appropriate number of pages to free at once using
free_pcppages_bulk, since we have seen the value consistently go above
2000 in the Meta fleet on larger machines.

As such, perform batched page freeing in free_pcppages_bulk by using
pcp->batch. In order to ensure that other processes are not starved of the
zone lock, free both the zone lock and pcp lock to yield to other threads.

Note that because free_frozen_page_commit now performs a spinlock inside the
function (and can fail), the function may now return with a freed pcp.
To handle this, return true if the pcp is locked on exit and false otherwise.

In addition, since free_frozen_page_commit must now be aware of what UP
flags were stored at the time of the spin lock, and because we must be
able to report new UP flags to the callers, add a new unsigned long*
parameter UP_flags to keep track of this.

The following are a few synthetic benchmarks, made on three machines. The
first is a large machine with 754GiB memory and 316 processors.
The second is a relatively smaller machine with 251GiB memory and 176
processors. The third and final is the smallest of the three, which has 62GiB
memory and 36 processors.

On all machines, I kick off a kernel build with -j$(nproc).
Negative delta is better (faster compilation)

Large machine (754GiB memory, 316 processors)
make -j$(nproc)
+------------+---------------+-----------+
| Metric (s) | Variation (%) | Delta(%)  |
+------------+---------------+-----------+
| real       |        0.8070 |  - 1.4865 |
| user       |        0.2823 |  + 0.4081 |
| sys        |        5.0267 |  -11.8737 |
+------------+---------------+-----------+

Medium machine (251GiB memory, 176 processors)
make -j$(nproc)
+------------+---------------+----------+
| Metric (s) | Variation (%) | Delta(%) |
+------------+---------------+----------+
| real       |        0.2806 |  +0.0351 |
| user       |        0.0994 |  +0.3170 |
| sys        |        0.6229 |  -0.6277 |
+------------+---------------+----------+

Small machine (62GiB memory, 36 processors)
make -j$(nproc)
+------------+---------------+----------+
| Metric (s) | Variation (%) | Delta(%) |
+------------+---------------+----------+
| real       |        0.1503 |  -2.6585 |
| user       |        0.0431 |  -2.2984 |
| sys        |        0.1870 |  -3.2013 |
+------------+---------------+----------+

Here, variation is the coefficient of variation, i.e. standard deviation / mean.

Suggested-by: Chris Mason <clm@fb.com>
Co-developed-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/page_alloc.c | 65 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8ecd48be8bdd..6d544521e49c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2818,12 +2818,22 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 	return high;
 }
 
-static void free_frozen_page_commit(struct zone *zone,
+/*
+ * Tune pcp alloc factor and adjust count & free_count. Free pages to bring the
+ * pcp's watermarks below high.
+ *
+ * May return a freed pcp, if during page freeing the pcp spinlock cannot be
+ * reacquired. Return true if pcp is locked, false otherwise.
+ */
+static bool free_frozen_page_commit(struct zone *zone,
 		struct per_cpu_pages *pcp, struct page *page, int migratetype,
-		unsigned int order, fpi_t fpi_flags)
+		unsigned int order, fpi_t fpi_flags, unsigned long *UP_flags)
 {
 	int high, batch;
+	int to_free, to_free_batched;
 	int pindex;
+	int cpu = smp_processor_id();
+	int ret = true;
 	bool free_high = false;
 
 	/*
@@ -2861,15 +2871,46 @@ static void free_frozen_page_commit(struct zone *zone,
 		 * Do not attempt to take a zone lock. Let pcp->count get
 		 * over high mark temporarily.
 		 */
-		return;
+		return true;
 	}
 
 	high = nr_pcp_high(pcp, zone, batch, free_high);
 	if (pcp->count < high)
-		return;
+		return true;
+
+	to_free = nr_pcp_free(pcp, batch, high, free_high);
+	while (to_free > 0 && pcp->count > 0) {
+		to_free_batched = min(to_free, batch);
+		free_pcppages_bulk(zone, to_free_batched, pcp, pindex);
+		to_free -= to_free_batched;
+
+		if (to_free <= 0 || pcp->count <= 0)
+			break;
+
+		pcp_spin_unlock(pcp);
+		pcp_trylock_finish(*UP_flags);
+
+		pcp_trylock_prepare(*UP_flags);
+		pcp = pcp_spin_trylock(zone->per_cpu_pageset);
+		if (!pcp) {
+			pcp_trylock_finish(*UP_flags);
+			ret = false;
+			break;
+		}
+
+		/*
+		 * Check if this thread has been migrated to a different CPU.
+		 * If that is the case, give up and indicate that the pcp is
+		 * returned in an unlocked state.
+		 */
+		if (smp_processor_id() != cpu) {
+			pcp_spin_unlock(pcp);
+			pcp_trylock_finish(*UP_flags);
+			ret = false;
+			break;
+		}
+	}
 
-	free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
-			   pcp, pindex);
 	if (test_bit(ZONE_BELOW_HIGH, &zone->flags) &&
 	    zone_watermark_ok(zone, 0, high_wmark_pages(zone),
 			      ZONE_MOVABLE, 0)) {
@@ -2887,6 +2928,7 @@ static void free_frozen_page_commit(struct zone *zone,
 		    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
 			atomic_set(&pgdat->kswapd_failures, 0);
 	}
+	return ret;
 }
 
 /*
@@ -2934,7 +2976,9 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
-		free_frozen_page_commit(zone, pcp, page, migratetype, order, fpi_flags);
+		if (!free_frozen_page_commit(zone, pcp, page, migratetype,
+						order, fpi_flags, &UP_flags))
+			return;
 		pcp_spin_unlock(pcp);
 	} else {
 		free_one_page(zone, page, pfn, order, fpi_flags);
@@ -3034,8 +3078,11 @@ void free_unref_folios(struct folio_batch *folios)
 			migratetype = MIGRATE_MOVABLE;
 
 		trace_mm_page_free_batched(&folio->page);
-		free_frozen_page_commit(zone, pcp, &folio->page, migratetype,
-					order, FPI_NONE);
+		if (!free_frozen_page_commit(zone, pcp, &folio->page,
+				migratetype, order, FPI_NONE, &UP_flags)) {
+			pcp = NULL;
+			locked_zone = NULL;
+		}
 	}
 
 	if (pcp) {
-- 
2.47.3

