Return-Path: <linux-kernel+bounces-831247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89471B9C2E6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395362E7AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE8C32BBF6;
	Wed, 24 Sep 2025 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlzfrUa1"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C6732A80B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746657; cv=none; b=Qa0882pZKUBNPMwj0APQtPgOehT9ZlmgiB6ZGf1Ksy9qsEWi1g34IbYu85eFrsPogp5D65KTPA5keK6ieukNtGA6ABIwFB89wjFCfpt+TBYYjoeSrnv67gnCnweN6Ll2epA2lQEHoDjiGOW+ViJkIw6IoSvidmSiidQmLaaHpOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746657; c=relaxed/simple;
	bh=++4exA2wOuipajrX2RyWo1Vr81kf5GOhL77WZeNBNIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOrtbGSrRud8/A9Fyc8GHiZXVzzoDxIofGQ9TRCZz+fxmjjwRYok6V4QtMBw2WPBySuC6hLo6yhf/a0l2xMF47PKI0gT020ocRao8wDNffNsbsBqUcMtCliIwim3Gbhm1icT6fPQShlmXAJQbtxZqZ7nVJzUzv6yx/nnJfQfgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlzfrUa1; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ea856357c38so205413276.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758746655; x=1759351455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fpXopbf9nrg842Iu+f16vQitKmYdsg5/JBu9HvQmTw=;
        b=DlzfrUa1WuY1vhxZbO7DpBlbFUWVd0ekRpdzUL8alU4iKIlBf6CMuYoALs8fVAZqrg
         v3082j29XYeZhKHTlvjiiZbA6L1bc7A1gx+hzUQHqJSonxuqCznqXY+0VIfLFQ8DKWoV
         +vwo4fI2/wJQC3DQMjzCCjf1Lr2pABdgbYyM1TOHEMdtMMnKVhF2qcps7kwmEa3o6xoa
         xrT/rFcDUrofOKkBgEN+fhBgKAAWMsP33uG/vgvbGeeXeN+tnaVEgQnrwQUYoVqwzQ5i
         168txHbi5tDhgbEqVAFrlvLLF4x5V6HPPrHe79xZU7fsguP8545cdwRKwtZPvKo5ADqD
         Ly9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758746655; x=1759351455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fpXopbf9nrg842Iu+f16vQitKmYdsg5/JBu9HvQmTw=;
        b=cC7kAIr6nY8tXUZq8fcRgzCWqFR0+7jx8ZyMve0H4DJ766vnnWDJmVg1K5mmr6m8Zp
         4nTEynczmOSsnD2SIjseR47S2Za9eFIs9r0S7+bbmGgFY03lrz/Ff4NAzER9LWFO5iGa
         F6I3mkeYgvYsUW4PRRplGKcEYWUXuCDH4vthgeQh+H0Mch2bGr4t7Mq6Qvtk323V3M/D
         YkaizOduh36oEqsGuA2rxoli59KzQWbiEtYfdLbW/ydK+949w1wlknOhWXO0RSjIwBuz
         XYdJlbq3wzs/4/JuQeP7zTESHbvwC6UWgM8ZHaIpGHXAetvJIHtHAgh4Uag1V1/4Km27
         qGDg==
X-Forwarded-Encrypted: i=1; AJvYcCWE4WGLZ62MUQhGU4xboyW0NKm5JHCDY5IhwxPT/ImQp9ecTaZqJYzlxNU6IB+TT4S2jCx4CcncG6J3wU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbZaYi/MdxlQfoycZQJU6Z5iZ2JveVsaXfod+JWEBZt/KYFzp3
	FytUuw4Ed/AH5mJG/PZU7h5hTvZ2kOds2QcS5euSo9C/vRWt0mphuVws
X-Gm-Gg: ASbGncvBiAeI0YhibRgbZPdQe9eh3tR5q6vGCkqEQqp60rPybwgMGTXfmHBgJRXx1QN
	/P5euEMIN+Tjc8NohyskLy9k5dGTEuYR1yj5J3ZSwbckE+YVlmnWxKz/Cxx1QbERsvRx3htQ8na
	BFlox6s2Dy3hvh+g9u+8aNlwZGLchg5I4grDNiukHJatIWdOdRjD3fPDOPrR88bbil11uOcWJXK
	63S2+M5tMolnhFpVRup8NAq1WaLnNPo4lwY6+uR8AjstAIa0KugOqNs5UzQckWFYHVIf6+4ClN1
	ti2Wk7NAqCl98kGFg7BydfWCrocr6yt7XD1bBisqTCBKcSL4nr5XipHZIUCR0ej2ZoeLcr6Pi9B
	a3nZjoHO6+MW6L/MtIRb/mEIGaKcXm0lluUdzTbTEICzm+3rkUDqqoQ==
X-Google-Smtp-Source: AGHT+IF10NXmJFuZ39y0IplwFjsDAIgIBgF/Cg8/CUpRd91k9Lu0+3DKjmDX74kTx+FAzC83Jfqj6Q==
X-Received: by 2002:a05:690c:6c08:b0:721:5b31:54ce with SMTP id 00721157ae682-76401b30aaemr10760517b3.31.1758746654908;
        Wed, 24 Sep 2025 13:44:14 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739718b0046sm50848027b3.59.2025.09.24.13.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 13:44:14 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Chris Mason <clm@fb.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH v2 4/4] mm/page_alloc: Batch page freeing in free_frozen_page_commit
Date: Wed, 24 Sep 2025 13:44:08 -0700
Message-ID: <20250924204409.1706524-5-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250924204409.1706524-1-joshua.hahnjy@gmail.com>
References: <20250924204409.1706524-1-joshua.hahnjy@gmail.com>
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
starved of the pcp (and zone) lock, free the pcp lock.

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
 mm/page_alloc.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 467e524a99df..50589ff0a9c6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2821,11 +2821,19 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
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
 	bool free_high = false;
 
@@ -2864,17 +2872,34 @@ static void free_frozen_page_commit(struct zone *zone,
 		 * Do not attempt to take a zone lock. Let pcp->count get
 		 * over high mark temporarily.
 		 */
-		return;
+		return true;
 	}
 	high = nr_pcp_high(pcp, zone, batch, free_high);
-	if (pcp->count >= high) {
-		free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
-				   pcp, pindex);
+	to_free = nr_pcp_free(pcp, batch, high, free_high);
+	while (to_free > 0 && pcp->count >= high) {
+		to_free_batched = min(to_free, batch);
+		free_pcppages_bulk(zone, to_free_batched, pcp, pindex);
 		if (test_bit(ZONE_BELOW_HIGH, &zone->flags) &&
 		    zone_watermark_ok(zone, 0, high_wmark_pages(zone),
 				      ZONE_MOVABLE, 0))
 			clear_bit(ZONE_BELOW_HIGH, &zone->flags);
+
+		high = nr_pcp_high(pcp, zone, batch, free_high);
+		to_free -= to_free_batched;
+		if (pcp->count >= high) {
+			pcp_spin_unlock(pcp);
+			pcp_trylock_finish(*UP_flags);
+
+			pcp_trylock_prepare(*UP_flags);
+			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
+			if (!pcp) {
+				pcp_trylock_finish(*UP_flags);
+				return false;
+			}
+		}
 	}
+
+	return true;
 }
 
 /*
@@ -2922,8 +2947,9 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
-		free_frozen_page_commit(zone, pcp, page, migratetype, order, fpi_flags);
-		pcp_spin_unlock(pcp);
+		if (free_frozen_page_commit(zone, pcp, page, migratetype, order,
+					    fpi_flags, &UP_flags))
+			pcp_spin_unlock(pcp);
 	} else {
 		free_one_page(zone, page, pfn, order, fpi_flags);
 	}
@@ -3022,8 +3048,9 @@ void free_unref_folios(struct folio_batch *folios)
 			migratetype = MIGRATE_MOVABLE;
 
 		trace_mm_page_free_batched(&folio->page);
-		free_frozen_page_commit(zone, pcp, &folio->page, migratetype,
-					order, FPI_NONE);
+		if (!free_frozen_page_commit(zone, pcp, &folio->page,
+				migratetype, order, FPI_NONE, &UP_flags))
+			pcp = NULL;
 	}
 
 	if (pcp) {
-- 
2.47.3

