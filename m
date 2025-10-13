Return-Path: <linux-kernel+bounces-851239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4FEBD5E20
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDA364F18E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809B12D97B8;
	Mon, 13 Oct 2025 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpfXRlEb"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0C2D6E57
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382499; cv=none; b=dJfG+iB91eECxJjmqggcTrEiM0ynwcDYgCXn7P90JJhcQICHC4HgXPD8a5pvG3fxyGoL8yqG5r+K8fMyLq7BaWBhlgKPudYrHHBNXzyANrSebQqyTXijjy7S7ilhf2TP1o3fS8BX0QfJD/N9chzr4Qa5IZz2Sc1sS3L3VvKmKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382499; c=relaxed/simple;
	bh=Nw814zuhZwKKeZYq10E0XQ1hRIfSoUE8sJgW8LwlcAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHjSvPBgpvIr8m13CQA50gdfux5uCRqAE5OILYWD2yd/tKfARa6Fqi7SnTjgdihllYvWLZmnpfzzvZFQnsDmJIYNn6XCb8/5xAmoR/c85HHFJN8yg3TeYeK96OOtCMOJDNgECp3SxN334iVEjqzuV1Zc5FimSz+vcbcGfKH23PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpfXRlEb; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7814273415cso6017777b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760382497; x=1760987297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDzIWaOgwVfkqKsoR4FvITyGy2H0kRZNktinhlzDtIQ=;
        b=mpfXRlEbSA6nxyqwDSCC3wbxvMmwE9n7A8oMU7BmmWECwJIO5SCGhsD9TWVK5fb63+
         Gdidc7wRAZp4rxIsHz4Eq3J1+/VK1JRCkwPAfktn2VmGEXkKc6ACjdghLCgqSvtEAi8z
         CkQVCpuh6fjCTYwmo3k2zxWBxiYcmyHN7zEQFnabJzNpM8vBgG6K9ApeRvyItLXdVcYr
         bcxKZT5hOty+YCTtugt42ANjpJXA3a/Tq1v6garYEcxTuDb52+G1gcKs/3xMpcDe5+7W
         usKPuCYMx5VJI0/m1gGf3B851op2h72ZKKooSW3lW03xuOipTUuXFpal2e5qZKGzwSSX
         K+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760382497; x=1760987297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDzIWaOgwVfkqKsoR4FvITyGy2H0kRZNktinhlzDtIQ=;
        b=Vvggh+BuqY/RhPa0GFrZa/OsmHargevE3YmN2wkZiQ7gvnNVD2emqouvOP9XvdGIqK
         2hkW5aVA0ISwZNjxZZtFq+qAW4apRyVGpScSTSAIjSLVGqgDDy7ZGazVTQjUB6Tcy48W
         a+tItjbiTavfikGKcMuaRU+phFdPQvA67jBHv+CHV4BPsKPKn7wR6soh7RhT0Ie+TK9w
         5ONe8lMr+yBdfU2d27feUAY2J34Dr1KRpoTvl6pBC4w1E7m+urAohcbqa3lvMhev5v17
         Ylvbr6da8mpaZrFgqcdArIkmFMnxmoXonL5GTqu/HShtLFUSJVFrIr6tA6ubP/FbB85s
         bnMw==
X-Forwarded-Encrypted: i=1; AJvYcCU/HqkM+ei0JSj0Imo9uu4V38qNVgtdS+b7h1yLBPSR4UifFQt1yJIrIPkvgNLsozIFBZxvSxWRd2dWIQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkiRsmmdXmn6SYe/wn57QiFCTbuyQTQh+Rx2RPWHlsmxDXi/i5
	hUH9KuelkAeU0hpsdM3DIy0GNcBAIXHT1ZEOcAUuvNkODC9wiEGqSUOR
X-Gm-Gg: ASbGncs/FjOqeTpEdH7tvHOMWHJQGo8k4qy7AlvP99gKVc1KnA4da3hQKX1a8s9koD4
	tKJfGm4F6Ruarw8eluVqTZSvi6n2yDLfqyHefIFBAYbNOjUd8Zbn4h7+ka9v/ZbRVJqZo+J8fu6
	MzYV7WfiEExqC2z6fh5ZoowsmGGVfcHpQDD/qlx6GJMc6nAV1E8J3a2mp9iwqC1kxXYYdg0i0fP
	5n1I5tVdoO5VCK87988dpow2OVoE6QfM70DR37FJbS9cOiBoeJ5g+gusYjg7RK7MeFWJf1QFQ2N
	m93m33pq4roDGrDFofRY3p5VQ5iUOGywosU8ca6WB09DC6Xxz5djt98W94PyN2oOLi8cC2E4gCJ
	DSwD40jwP6oTOL8DQdAdkhoelUUJrsjdELrF2GoNQr85/AR1av2JFRigGHrT4j72PEC7wyltq0w
	P7nv6Kg2/K
X-Google-Smtp-Source: AGHT+IE9xC3500baXqEHlI48re4/P275laxRB6z9xaFR7v78dK95X3SgDSsqDOD2QAARYLwFZ+0PNw==
X-Received: by 2002:a05:690c:a641:b0:781:64f:2b68 with SMTP id 00721157ae682-781064f3762mr101116847b3.68.1760382496767;
        Mon, 13 Oct 2025 12:08:16 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78106dbbef8sm28680687b3.1.2025.10.13.12.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 12:08:16 -0700 (PDT)
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
Subject: [PATCH v4 3/3] mm/page_alloc: Batch page freeing in free_frozen_page_commit
Date: Mon, 13 Oct 2025 12:08:11 -0700
Message-ID: <20251013190812.787205-4-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251013190812.787205-1-joshua.hahnjy@gmail.com>
References: <20251013190812.787205-1-joshua.hahnjy@gmail.com>
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
pcp->batch member. In order to ensure that other processes are not
starved of the zone lock, free both the zone lock and pcp lock to yield to
other threads.

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
 mm/page_alloc.c | 66 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8ecd48be8bdd..e85770dd54bd 100644
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
@@ -2861,15 +2871,47 @@ static void free_frozen_page_commit(struct zone *zone,
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
+	if (to_free == 0)
+		return true;
+
+	while (to_free > 0 && pcp->count >= high) {
+		to_free_batched = min(to_free, batch);
+		free_pcppages_bulk(zone, to_free_batched, pcp, pindex);
+		to_free -= to_free_batched;
+		if (pcp->count >= high) {
+			pcp_spin_unlock(pcp);
+			pcp_trylock_finish(*UP_flags);
+
+			pcp_trylock_prepare(*UP_flags);
+			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
+			if (!pcp) {
+				pcp_trylock_finish(*UP_flags);
+				ret = false;
+				break;
+			}
+
+			/*
+			 * Check if this thread has been migrated to a different
+			 * CPU. If that is the case, give up and indicate that
+			 * the pcp is returned in an unlocked state.
+			 */
+			if (smp_processor_id() != cpu) {
+				pcp_spin_unlock(pcp);
+				pcp_trylock_finish(*UP_flags);
+				ret = false;
+				break;
+			}
+		}
+	}
 
-	free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
-			   pcp, pindex);
 	if (test_bit(ZONE_BELOW_HIGH, &zone->flags) &&
 	    zone_watermark_ok(zone, 0, high_wmark_pages(zone),
 			      ZONE_MOVABLE, 0)) {
@@ -2887,6 +2929,7 @@ static void free_frozen_page_commit(struct zone *zone,
 		    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
 			atomic_set(&pgdat->kswapd_failures, 0);
 	}
+	return ret;
 }
 
 /*
@@ -2934,7 +2977,9 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
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
@@ -3034,8 +3079,11 @@ void free_unref_folios(struct folio_batch *folios)
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

