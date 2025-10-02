Return-Path: <linux-kernel+bounces-840754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E59BB525E
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 22:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768C23C6F77
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 20:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC98254AE4;
	Thu,  2 Oct 2025 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DF4AxCyh"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D381EEA55
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438005; cv=none; b=ZKiyLk0uW+kCFZh41tOSnIguj3Gb/6l1XFejHIFB7NWSQs6DfvOAp8BSbKXiLFeI4UmlBwQhsIZMwDj4tkFEQ/Vq87Cenyfu88PpQKadO8FB5QRJmkA46427ZUtR1Y7YYfFDLA1CwaitK8PEdvDcep0N+UVGkw4KNWMPveeZM6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438005; c=relaxed/simple;
	bh=JggwyU8+falGG8LJc+r4zOOOtJrz8MlfWHTD353hWew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E72z5sVXOd96rS6lgoasUqA/Sa3WhW7Hgq/pETP9cAdNY20nOHKATD+z+I1n1HlJW28KVN2kwdl/e27GXtBW+dFzETvXgXTss9efRskGQSy1j7RdAY6+dEIanOip2fdRgeyK2F8R/Iln3V9ybmjHz/x6zqf2cWWPYDkKofV3m5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DF4AxCyh; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d5fe46572so20425767b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759438003; x=1760042803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBa7sIAa7lZB7AE0W4U5YndRgjFk5P+mjzsHi3y1lyA=;
        b=DF4AxCyhf2OEw+cY3IkDe9IGfe7P2UFQWFF68CCSB7SXUim7fDGbUHKf88bDPchVq+
         i1uUYQgT+jvM50yxdMqxd5UhvlLoRYQ99fmnESQG+MUoOFCLlq1xONVkkLh1DRorHV6L
         J3CVzaK5Z+/PGJkyC3Ix3Z6enGY0Pt87jMhVRUfBGkWKjB8epagwnpLYdfW8rGWXnIbq
         3qAx2wN7v6+I7lP7DsJvX1D8ez/Q164KlRlK+NXiOQvycOJfjFYyzNjv2F8oBT+2X+yz
         IWT67aqwhfLYF/6g89Nnww6L8EzkCITCLQXjV7P+diN6QiU+SFcJeACumaUE7jmlSEBj
         wKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759438003; x=1760042803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBa7sIAa7lZB7AE0W4U5YndRgjFk5P+mjzsHi3y1lyA=;
        b=ZCNeYGwZP7nfV1/2iY9JW6PtpXyUy/7F2UQWME+5FHDnidYxQgoWYAWDy+eMfgFSOx
         6lekcbr7c8w08wGND0hq7eddaiEr7C8iPgI7g/zjNWXkdUUsmOvO+reQEZl/pMnKjRyS
         buJh6GAQc/BfJXeH5vwSEqhhSVyvxKsmzFKlvVRAfYxIuH4TxiHSNgHES5aelKjOfZGu
         jPrNJoFCuSwvXMeJ61egJ+bg+WUEBACL1DdTeW8Z1L0UngbOBrX0YwDU/05jQTc9mnUi
         1XkAiFBpFJ8eWVSOuidf6fnVaAsozDjkFSK9s3oyUGJroaRCxgMvmrNgJgnbpOmAwzXU
         Ouig==
X-Forwarded-Encrypted: i=1; AJvYcCXD3Z57do0mQareRLOXZ/4+qNYfMocxX4dz7IYbf24z4ayDQo2KQUdhknNuSk+PzCO5xEAS3lr++GqzDEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzStx9q9s+dinXbWm+8fDh9enBm5UiwsM9Wtzwwn/PcXOU9i9lN
	a7uM2inCgZ52vi0rn4aII4siB+T+BAJWAKPH0k7TPqvFh+X/8Jz3ISJS
X-Gm-Gg: ASbGncufkntqePjHkgyQ34E8HBy1avmxGH8YiMqAKFRLst+qJ0tw1CdLUJ5tdpXofLz
	dauHxC0JSuBB0AutoGrvYO456mPp5VAihyRPJdhnj6ofbU2rpEMyiSNHQBs1f5arlrTXJYrmSPR
	budQ6oP1Eo2HIBAkh0PWvN3jBd+bqIwDKtZo+gcE2D5jfv9xR7XTX/ONqWNZc0YXsqwxnziKhPL
	CTFBN5h7r4njP/E9W1dE9c/en/gJuslMA7Yx2ORA3iJtYiVjj5pySdVMFjQgS3B82807bkrPSUa
	O2GPWtTKCVsoauivsMAAY7dTX9BqEK9LqVJdyvDHnQXp95qAe+0g1KCu4ydaEChihmy6PPoHDCR
	XOpx3yHfB3/CnFF9R5+3baZ9geAv67jm6w+03o3ZmrJZaFg6IbFsypbPl3C+hZTL/8hs/OpkvmL
	oN0wC4NIb4GIE=
X-Google-Smtp-Source: AGHT+IENI2go9fghJpen+tUDrCCnqIsPZ10tsTLEeBnhI7cBoG/y7/sR3qgtxNTvBex2gqOGrkvgtA==
X-Received: by 2002:a05:690c:a4c8:b0:77f:771e:fb78 with SMTP id 00721157ae682-77f81b6c90amr49034987b3.18.1759438002398;
        Thu, 02 Oct 2025 13:46:42 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77f81d1444asm11412977b3.42.2025.10.02.13.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 13:46:41 -0700 (PDT)
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
Subject: [PATCH v3 3/3] mm/page_alloc: Batch page freeing in free_frozen_page_commit
Date: Thu,  2 Oct 2025 13:46:33 -0700
Message-ID: <20251002204636.4016712-4-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251002204636.4016712-1-joshua.hahnjy@gmail.com>
References: <20251002204636.4016712-1-joshua.hahnjy@gmail.com>
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

Suggested-by: Chris Mason <clm@fb.com>
Co-developed-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/page_alloc.c | 66 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f525f197c5fd..9b9f5a44496c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2818,12 +2818,21 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
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
 	bool free_high = false;
 
 	/*
@@ -2861,15 +2870,20 @@ static void free_frozen_page_commit(struct zone *zone,
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
 
-	free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
-			   pcp, pindex);
+free_batch:
+	to_free_batched = min(to_free, batch);
+	free_pcppages_bulk(zone, to_free_batched, pcp, pindex);
 	if (test_bit(ZONE_BELOW_HIGH, &zone->flags) &&
 	    zone_watermark_ok(zone, 0, high_wmark_pages(zone),
 			      ZONE_MOVABLE, 0)) {
@@ -2887,6 +2901,35 @@ static void free_frozen_page_commit(struct zone *zone,
 		    next_memory_node(pgdat->node_id) < MAX_NUMNODES)
 			atomic_set(&pgdat->kswapd_failures, 0);
 	}
+	high = nr_pcp_high(pcp, zone, batch, free_high);
+	to_free -= to_free_batched;
+	if (pcp->count >= high) {
+		pcp_spin_unlock(pcp);
+		pcp_trylock_finish(*UP_flags);
+
+		pcp_trylock_prepare(*UP_flags);
+		pcp = pcp_spin_trylock(zone->per_cpu_pageset);
+		if (!pcp) {
+			pcp_trylock_finish(*UP_flags);
+			return false;
+		}
+
+		/*
+		 * Check if this thread has been migrated to a different
+		 * CPU. If that is the case, give up and indicate that
+		 * the pcp is returned in an unlocked state.
+		 */
+		if (smp_processor_id() != cpu) {
+			pcp_spin_unlock(pcp);
+			pcp_trylock_finish(*UP_flags);
+			return false;
+		}
+	}
+
+	if (to_free > 0 && pcp->count >= high)
+		goto free_batch;
+
+	return true;
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

