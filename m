Return-Path: <linux-kernel+bounces-817706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE9FB58586
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B03208641
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C52296BD4;
	Mon, 15 Sep 2025 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dwEv+7/F"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6430D28D8D0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965953; cv=none; b=fCezARQngFUSYDRIfhtsI4Gfi58FS5JdCjjTZDLvMO0sRbE2mWHm6viWjWhnMi3Sw1D7WXWHgSdABqFN5iqwaJjeZ8zzm6rmKrvpk2KXf9kGGhToVpeNI3FbsRHsBa0PglNFR63MyAuQRLe+npcydYlMkJAKr5pwAfloQaBfDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965953; c=relaxed/simple;
	bh=LlIK5l7n4robJLODbHBAVI4BsoX7LlGnbeStJBZkhzw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l9sVA0/NOd2CjNO4FJyqdIm7TfkrPecpF9UT8E4SE715zz1Q/+CGF1mGG9lWGu8tOtN9jARZw7KP7oWZSDghXEcYUy/42ed78OgPlC+iPT6OuyoTGPAltIo/nOuhIk6V7+pDrghSpmIzbi+jU5J/7meRHzP92GYQWAfIJO3dG5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dwEv+7/F; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2621fab9befso22082475ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757965951; x=1758570751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RZKjZrunq5am07txBDDkuCSvylPNhhpycrLLY5C5zoU=;
        b=dwEv+7/FCgTJYrbC/AQ2sq+12KI7crGkV5SR0iyq39ixFcU0PW4smElbELsPAtdtcl
         j1Rfl7BzKhbBO8yz1Zin18kqrA2hLftZRZ8qm4Z49NDo8vcHcfhjMTDM1QOj1dac4LXG
         TnGbgUeF8+aoGVfGfWV8We7LSQ7MMQ5ys4ocY2iDLAOei3myHGcAQo1sLhXE10ldolVQ
         Z+F03/mgyhW2xoIOY/J4tLpmrIc1D95rBuj5WEwcvdRufKekFpjd0wZvek52jkFMXvZQ
         lZltiWJAIoD9HFy7oCXpHtDshJ0s/Pzvvl6OKKcmvt+pyQ09fZ4Z91rdmCxAaOWYZUFe
         svwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965951; x=1758570751;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZKjZrunq5am07txBDDkuCSvylPNhhpycrLLY5C5zoU=;
        b=RpmhmCr4fEyc1qBM9xxRVxANhY7KpUXWks9QmF5egxo6SGg7aM7Wxmxp6frc/Vcpjg
         FMvXnUwF7zpsRRYce8JOBwzRYNEz0PEWKGj+3gKAJ6zFvwp/V5PFZMNrDgry7Cv5zTfg
         1p5xRcwLjYdhyJpeAL5D3rOV40q94fNRGWaTQoEd8I281LkGmgyy5itKfWe/ZcyWaW6I
         uhh/LBnh+0Twdm5XAnQpQaQhjqsmwUdlKkIXmPIE+covUcBTllb0jGeI9iilbXOWsCOS
         vmSiSwnHODLFr/dgfgqXFf+rPQljdj6Wtr1/WcJB2ROtmC/KLQWP+95jNCR8cy3eS+Pm
         jehg==
X-Forwarded-Encrypted: i=1; AJvYcCX3jZ02TxRYHW4Jhy6myhRlJI+/Rzh1WnzRZMcR6fKUsAmpp6W1e/XAw9Aoff57Zg8jpxujVOKWw0UCBk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBnlpYHr0Xjfa52UMCyVklrc/TNpUDHh3iMCUTSfztCl+wU8G
	PMVzbXV2xCAZzv9YmAJ25aC/VMTzMdCX0DTUfWfEM0XcfZEi6xIBiw3ljwhfXar4ym0jWqI4+g=
	=
X-Google-Smtp-Source: AGHT+IH9QOqt/yj9ycFYjOQ2rL3lizwBlj25FoMjJ5FB/agDQXZSFKAbBpu7CnQQ54uijVVe5BYAlfIL
X-Received: from plgi11.prod.google.com ([2002:a17:902:cf0b:b0:24a:ff7a:4c65])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78b:b0:25a:324a:9af1
 with SMTP id d9443c01a7336-25d26e42154mr150527385ad.38.1757965950699; Mon, 15
 Sep 2025 12:52:30 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:51:49 +0000
In-Reply-To: <20250915195153.462039-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915195153.462039-1-fvdl@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915195153.462039-9-fvdl@google.com>
Subject: [RFC PATCH 08/12] mm/compaction: simplify isolation order checks a bit
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

The code to isolate pages for migration always checked both
cc->alloc_contig and skip_isolation_on_order to determine
whether a page could be isolated for migration.

Simplify this a little bit by moving the cc->alloc_contig
check in to skip_isolation_on_order. Also rename alloc_contig
to migrate_large, since there will be an additional user
(CMA balancing) of this field soon, not just alloc_contig_range.

No functional change.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/compaction.c | 26 ++++++++++++++------------
 mm/internal.h   |  2 +-
 mm/page_alloc.c |  2 +-
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 6a2c06e356c5..2e6c30f50b89 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -793,13 +793,15 @@ static bool too_many_isolated(struct compact_control *cc)
 /**
  * skip_isolation_on_order() - determine when to skip folio isolation based on
  *			       folio order and compaction target order
+ * @cc:			compact control structure containing target order
  * @order:		to-be-isolated folio order
- * @target_order:	compaction target order
  *
  * This avoids unnecessary folio isolations during compaction.
  */
-static bool skip_isolation_on_order(int order, int target_order)
+static bool skip_isolation_on_order(struct compact_control *cc, int order)
 {
+	if (cc->migrate_large)
+		return false;
 	/*
 	 * Unless we are performing global compaction (i.e.,
 	 * is_via_compact_memory), skip any folios that are larger than the
@@ -807,7 +809,7 @@ static bool skip_isolation_on_order(int order, int target_order)
 	 * the desired target_order, so migrating this folio would likely fail
 	 * later.
 	 */
-	if (!is_via_compact_memory(target_order) && order >= target_order)
+	if (!is_via_compact_memory(cc->order) && order >= cc->order)
 		return true;
 	/*
 	 * We limit memory compaction to pageblocks and won't try
@@ -850,6 +852,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	unsigned long next_skip_pfn = 0;
 	bool skip_updated = false;
 	int ret = 0;
+	unsigned int order;
 
 	cc->migrate_pfn = low_pfn;
 
@@ -948,13 +951,13 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		}
 
 		if (PageHuge(page)) {
-			const unsigned int order = compound_order(page);
 			/*
 			 * skip hugetlbfs if we are not compacting for pages
 			 * bigger than its order. THPs and other compound pages
 			 * are handled below.
 			 */
-			if (!cc->alloc_contig) {
+			if (!cc->migrate_large) {
+				order = compound_order(page);
 
 				if (order <= MAX_PAGE_ORDER) {
 					low_pfn += (1UL << order) - 1;
@@ -962,7 +965,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 				}
 				goto isolate_fail;
 			}
-			/* for alloc_contig case */
+			/* for migrate_large case */
 			if (locked) {
 				unlock_page_lruvec_irqrestore(locked, flags);
 				locked = NULL;
@@ -1030,11 +1033,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		 * skip them at once. The check is racy, but we can consider
 		 * only valid values and the only danger is skipping too much.
 		 */
-		if (PageCompound(page) && !cc->alloc_contig) {
-			const unsigned int order = compound_order(page);
+		if (PageCompound(page)) {
+			order = compound_order(page);
 
 			/* Skip based on page order and compaction target order. */
-			if (skip_isolation_on_order(order, cc->order)) {
+			if (skip_isolation_on_order(cc, order)) {
 				if (order <= MAX_PAGE_ORDER) {
 					low_pfn += (1UL << order) - 1;
 					nr_scanned += (1UL << order) - 1;
@@ -1182,9 +1185,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			/*
 			 * Check LRU folio order under the lock
 			 */
-			if (unlikely(skip_isolation_on_order(folio_order(folio),
-							     cc->order) &&
-				     !cc->alloc_contig)) {
+			order = folio_order(folio);
+			if (unlikely(skip_isolation_on_order(cc, order))) {
 				low_pfn += folio_nr_pages(folio) - 1;
 				nr_scanned += folio_nr_pages(folio) - 1;
 				folio_set_lru(folio);
diff --git a/mm/internal.h b/mm/internal.h
index 7916d8be8922..ffcb3aec05ed 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -909,7 +909,7 @@ struct compact_control {
 					 * isolation or migration failures to
 					 * ensure forward progress.
 					 */
-	bool alloc_contig;		/* alloc_contig_range allocation */
+	bool migrate_large;             /* Always migrate large/huge pages */
 };
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d3966d31c039..dc59aaa63ae6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6903,7 +6903,7 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 		.mode = MIGRATE_SYNC,
 		.ignore_skip_hint = true,
 		.no_set_skip_hint = true,
-		.alloc_contig = true,
+		.migrate_large = true,
 	};
 	INIT_LIST_HEAD(&cc.migratepages);
 	enum pb_isolate_mode mode = (alloc_flags & ACR_FLAGS_CMA) ?
-- 
2.51.0.384.g4c02a37b29-goog


