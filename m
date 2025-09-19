Return-Path: <linux-kernel+bounces-825151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2263BB8B1F0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CE437BA4C3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECC4322A32;
	Fri, 19 Sep 2025 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N23zZ2LH"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2977B321434
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311551; cv=none; b=VfxernptKkx/nCld+iDYkIVSI0yP2eDp6OwaelLoN52l2we+CPbsdguQ7zxBOCxjE0OPZ2YXKVKbOmtb0y0TxZN3NShvKoEEC7Ahl73xHf55LGyF6n+OMHxKsV92GmvHcNoamvlSdXImtFL6suroz8R+Gacn2WGsVCWHCy5QnE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311551; c=relaxed/simple;
	bh=Z4+KbE6GsIZkdULkpVOcM/D3ULSNz+M1WkXs5KNc/Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umIechjUHUAebZDQ27weLN+vCjq1x386EdQDNgXDhboBBOPBjImJatXF+CX8lgIc3spXEOiCwtYd1kn5ZL419zknerBbuQm8Kd1cPj3u1fulwkXgEzcqIyhPU7hxxmHZveQ5Pux+nsxuG02fD9nVz4He/BGTnsjXwVIOx1mvhJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N23zZ2LH; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-72ce9790acdso25844087b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758311549; x=1758916349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5514hkUU6j/LpNp+jQR2Vw3xX4bDEVjgpb6NqfXeu0=;
        b=N23zZ2LHPNSqxZ0UHXnZPXqgA+4NQPjtwItMiy0aIKDTpfIPwheku6BfapemLFEFlh
         q/y3axXJL+PJEmQiW/51o2OpCmv/oatvgXpbAZ/0txX6iPg9yscQWwrcl4B7W+mjkhFD
         4RnphEdComGCfd7z7bZo/6cVqfphCOdvZKtkJdYmONtXXSg+eW73fTno6SRHghoZlqle
         P6SVKmnvgzTZ+ApVoddZ4pR43GuHuKjCf8uxt+kJs+CNJeUFmSJJCbpiy5B9wZT7LtCK
         e4MJBsADScbtcSMwbwiXPunLDiNj1k0VqF0YMsc90VIOqOQae5sKtfVvxuttOwD9NL63
         +DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758311549; x=1758916349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w5514hkUU6j/LpNp+jQR2Vw3xX4bDEVjgpb6NqfXeu0=;
        b=Tmc0UEb7SdoX4QBTYjPrX6qG8Zzu3oRE3WZcjPzi8Ko4dnW7hsoNnCz6iAwmpeVEx3
         AQ6L9qxBIsMycMmECg0Oa7WlpC7BgVU6VGQo1hnEW0Lb6URrd8ytEWeQU0vy7Kc3lWQD
         xrFRmMyNbBJKCeCja7jR429gN8YSgSSyRpwHa6PhStrIu17iCzvUCbUjQoLOic+bDHBO
         L/dfolYA9IMA9JO9OXrB2+zwuid9rskfX+zm1BkHodIYxy6yrnF4tFJqiSQiX3+U463v
         3+f1B+gmfVES+CQku5icb4AemC64b0Ey1RHkIG4dqsRkBqWuwZ8c7Fi+PI0DbNT0ahxA
         +rbw==
X-Forwarded-Encrypted: i=1; AJvYcCWwjF2QXw8dAfL6nFhUhC+9roLwekj9nPkuJb5kUm0KhAq6UewXQp7INZmf1LZ6vqLTJG1UY8UgmO810Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyVbAVpPSAaJQmugrqhnozWEnyBye61ZBxYgq//x2Ob1msgO3H
	E2/J84x/9WHjvC45S0nICm3oh0GDPB34QB3o/goz/tGXt/3bB2Ua5lzF
X-Gm-Gg: ASbGncvNNKDEF/f7rmGR5s8n6F0OSf4tFfBSVt5c1iiW2+aYqfRim3lfL2GmRLw1Rk+
	/flnw4QCE5JbfS61/+jc7TggJxa4Fbm+sntmohrp6HK5H5yuRQgTck+6H3kMYI9lUrgLbqHgBH7
	ADOQB5KjvvHAnaDTWEWS/7Vm9DdH67VvAuBtEnD2GpAHZVJHc20vFryb7nMHNLNqrBQ4HzJiH2/
	m40iBCC+OHsdfXpIviUMXKME7QailjsJjlZTmTVGsQj1E+oFPoIDE02VOM/Grdu8XDQ6hl6zotr
	b2S3X1EW3c/XKrri/ruE9E1x75/AX48x+ZirDlSN8DIVtkefxCnZheHJacwFhRKScCtVATaRbf7
	HWT7JPx7CmClbWrVrfsjxyTIdrTj0GFXSCAen/WR7MqvWZiBSpzvo
X-Google-Smtp-Source: AGHT+IEVBz0LvxtgrKD8uQV/kHRpMtKxa5IqUhA+Ja3x1EMKQQ8NgxEBIv4STTROBqXMAS7ua4+BRw==
X-Received: by 2002:a05:690c:6812:b0:72f:d215:60c9 with SMTP id 00721157ae682-73d3c0162afmr46956397b3.26.1758311549074;
        Fri, 19 Sep 2025 12:52:29 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-739716caf81sm16662397b3.1.2025.09.19.12.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:52:28 -0700 (PDT)
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
Subject: [PATCH 4/4] mm/page_alloc: Batch page freeing in free_frozen_page_commit
Date: Fri, 19 Sep 2025 12:52:22 -0700
Message-ID: <20250919195223.1560636-5-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919195223.1560636-1-joshua.hahnjy@gmail.com>
References: <20250919195223.1560636-1-joshua.hahnjy@gmail.com>
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

Suggested-by: Chris Mason <clm@fb.com>
Co-developed-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/page_alloc.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 467e524a99df..dc9412e295dc 100644
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
 		unsigned int order, fpi_t fpi_flags)
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
+			pcp_trylock_finish(UP_flags);
+
+			pcp_trylock_prepare(UP_flags);
+			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
+			if (!pcp) {
+				pcp_trylock_finish(UP_flags);
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
+					    fpi_flags))
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
+					migratetype, order, FPI_NONE))
+			pcp = NULL;
 	}
 
 	if (pcp) {
-- 
2.47.3

