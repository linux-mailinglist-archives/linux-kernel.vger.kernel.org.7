Return-Path: <linux-kernel+bounces-722591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0286AFDCB0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2701C7B5431
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F811C84D5;
	Wed,  9 Jul 2025 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkiXj0k/"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ABD156678;
	Wed,  9 Jul 2025 01:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022856; cv=none; b=mbo6DDPQVEjd29QqMjg7oVZzXgr73rZh3W1UiNlovCg+OuYK8LYTHsWU+XP2LITazOSsPqyQW/XUjLgaZkBJ2QuIMqqxgTFXwO0uWVDZp591FhJDbegnWsms1ufCpJcpBATHg3Ig1EepkmF7IyPdCGQmOSsHiqLLYdQNufHZPgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022856; c=relaxed/simple;
	bh=L9z9MlZY9GADbKkS2o+6k0p7RSnZuJugrqzlxUfWhGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSzVwFQlRk+uTHMVjyujo9PA64d1PNl/11QO1YUNa9jZvJiILQ4+4xiJMxsslnxhkg+vCd/IO2UmmO5GoEnHbkCQY9/62SQ88yJqQFhB+tFPwRa19bTlbzngmKcpACWSa7pEo4iHXbJ7E8ctgQAlCWiRtZnqKGWOla1F2D9ndP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkiXj0k/; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e819ebc3144so4672055276.0;
        Tue, 08 Jul 2025 18:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022853; x=1752627653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXQH/ve6qx1KBEN74fLQjfqY8wtfZagojlNvUz86dAc=;
        b=hkiXj0k/K27Q8thL9luTD88fKv830pRY9/WgqHEf7KS8YtgTf7hfvXvijDMWcPkv42
         im2QjNbe99W73r2qlOQmNxWHkK2wbQAySQfXfS19Zoo46aFApJhwd16SSSrJtxmdLUcP
         dvrxOaPnn2Rrwo0bEwqpRbdoGf0k7Fv4+sYcM3claXCF4u114Hkuyg6dngJGRroal2Y/
         R6O+YoD0h1VwjOBvKyMS0SiaQcmPGb0UoUrB7avu23spbYr8jxzHYuR16j9VMhHvy3CE
         UrZ7f9YciztFXIVgKWQMxE1sQ29pQX4bbuiUxXSsFYL5S9qTon7okbT+5rwyCVxh0VdL
         2vWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022853; x=1752627653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXQH/ve6qx1KBEN74fLQjfqY8wtfZagojlNvUz86dAc=;
        b=L6aRAuXv6zpAAHcQX+eMa4WIXATG4zHW3r3wGW6zlMAZwJimdJNbg70XPvdC4zLR4B
         OdOQwtMw4VXVItMLipWXU+mWNu0vSDnXcNcPh6xMEIxRKc3WUDprurscxjtzBT259fbS
         hf7thQY4yB8UoLfm+YZwYnGdtpzmr+8MeSpHYDj62YUlPfkdT+K4FIU2cf3bN8fNWg2e
         bhYT/6lK4TV9994VyC+wsjpWxlSrZ5JfbDE+x5aDEsqmwj8MM339nNiH2Jd3hJcxbQWt
         bZ063OMTqcKQzUuWZK5pI1AuwFVKALAb03cXe5UjdDgNIywGG5Y7vMbPaKVCapVE3DZW
         k0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCX4gaQKtuVtLQrPR5NteUrbzb5mhoKBpPTx3ZU2DS0/CcwHd5XEE6n1s2Y68xe9sCclRGln2ZEZMlRwdib9@vger.kernel.org, AJvYcCXuOc0YPfNRgy9fyYRkEXwWaADoaflZQAL/rTDpH7rvX5tmd5G7vZ2E6eBck1fPC2b7sT7lWTPEWa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR3LVFkniPuqkxn3Lh99l61hzAdUHXm1f69k3IDX5eZv75+heR
	pLWUxZZ38iIy3m7IlSSVBo+IIaB/y+5wQgV2+ax9hm1B/QlHBVVZeXUV
X-Gm-Gg: ASbGncv27jquOEpA0hRVnsCYHEWV6xFZTOAxLvRbznvOexy0jdpEpRCjj5m6IAXe6iD
	jctrnZmplqokPDvDCSC0Wl80tfIr/j5W3nVzQH5oKDybcxfQai+pPAkEjH5CHeORCy28GNw2elI
	Lcnj74XsWDOeO7oghQ/whGqbSMxAfwgba+L9VOJlUZvbmvFZMsIk22hYICDNLmvhcABkg8kTYwO
	/VJ1Hbg67f/GV/WZlQeHOJBc5X/r4hLmStUOK41qXWHKzsSJwLFIzpZ6hA8JQnZiQ0QLg+E2ygu
	SIY52ttb0MV7P5OYtMSvGf0FzQRRAYJEIvLtLO7BuqSwE+NUNTSunLNUi4NYdV0CaKgB89BUlGN
	30CtJbpI=
X-Google-Smtp-Source: AGHT+IH4QyN9DH4rspZx7He5z7+iL9YLC4MetFnDASWRiFISwzMF2jwtmKA6AtCtBMwy//dlFDHNCA==
X-Received: by 2002:a05:6902:128f:b0:e85:e06a:7845 with SMTP id 3f1490d57ef6-e8b6e107726mr1137039276.5.1752022853205;
        Tue, 08 Jul 2025 18:00:53 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:52 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com,
	Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Subject: [PATCH v4 08/13] mm/damon: Move migration helpers from paddr to ops-common
Date: Tue,  8 Jul 2025 19:59:38 -0500
Message-ID: <20250709005952.17776-9-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

This patch moves the damon_pa_migrate_pages function along with its
corresponding helper functions from paddr to ops-common. The function
prefix of "damon_pa_" was also changed to just "damon_" accordingly.

This patch will allow page migration to be available to vaddr schemes as
well as paddr schemes.

Co-developed-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Ravi Shankar Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 120 +++++++++++++++++++++++++++++++++++++++++
 mm/damon/ops-common.h |   2 +
 mm/damon/paddr.c      | 122 +-----------------------------------------
 3 files changed, 123 insertions(+), 121 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index b43620fee6bb..918158ef3d99 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -5,6 +5,7 @@
  * Author: SeongJae Park <sj@kernel.org>
  */
 
+#include <linux/migrate.h>
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
 #include <linux/pagemap.h>
@@ -12,6 +13,7 @@
 #include <linux/swap.h>
 #include <linux/swapops.h>
 
+#include "../internal.h"
 #include "ops-common.h"
 
 /*
@@ -138,3 +140,121 @@ int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
 	/* Return coldness of the region */
 	return DAMOS_MAX_SCORE - hotness;
 }
+
+static unsigned int __damon_migrate_folio_list(
+		struct list_head *migrate_folios, struct pglist_data *pgdat,
+		int target_nid)
+{
+	unsigned int nr_succeeded = 0;
+	struct migration_target_control mtc = {
+		/*
+		 * Allocate from 'node', or fail quickly and quietly.
+		 * When this happens, 'page' will likely just be discarded
+		 * instead of migrated.
+		 */
+		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
+			__GFP_NOWARN | __GFP_NOMEMALLOC | GFP_NOWAIT,
+		.nid = target_nid,
+	};
+
+	if (pgdat->node_id == target_nid || target_nid == NUMA_NO_NODE)
+		return 0;
+
+	if (list_empty(migrate_folios))
+		return 0;
+
+	/* Migration ignores all cpuset and mempolicy settings */
+	migrate_pages(migrate_folios, alloc_migration_target, NULL,
+		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DAMON,
+		      &nr_succeeded);
+
+	return nr_succeeded;
+}
+
+static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
+						struct pglist_data *pgdat,
+						int target_nid)
+{
+	unsigned int nr_migrated = 0;
+	struct folio *folio;
+	LIST_HEAD(ret_folios);
+	LIST_HEAD(migrate_folios);
+
+	while (!list_empty(folio_list)) {
+		struct folio *folio;
+
+		cond_resched();
+
+		folio = lru_to_folio(folio_list);
+		list_del(&folio->lru);
+
+		if (!folio_trylock(folio))
+			goto keep;
+
+		/* Relocate its contents to another node. */
+		list_add(&folio->lru, &migrate_folios);
+		folio_unlock(folio);
+		continue;
+keep:
+		list_add(&folio->lru, &ret_folios);
+	}
+	/* 'folio_list' is always empty here */
+
+	/* Migrate folios selected for migration */
+	nr_migrated += __damon_migrate_folio_list(
+			&migrate_folios, pgdat, target_nid);
+	/*
+	 * Folios that could not be migrated are still in @migrate_folios.  Add
+	 * those back on @folio_list
+	 */
+	if (!list_empty(&migrate_folios))
+		list_splice_init(&migrate_folios, folio_list);
+
+	try_to_unmap_flush();
+
+	list_splice(&ret_folios, folio_list);
+
+	while (!list_empty(folio_list)) {
+		folio = lru_to_folio(folio_list);
+		list_del(&folio->lru);
+		folio_putback_lru(folio);
+	}
+
+	return nr_migrated;
+}
+
+unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
+{
+	int nid;
+	unsigned long nr_migrated = 0;
+	LIST_HEAD(node_folio_list);
+	unsigned int noreclaim_flag;
+
+	if (list_empty(folio_list))
+		return nr_migrated;
+
+	noreclaim_flag = memalloc_noreclaim_save();
+
+	nid = folio_nid(lru_to_folio(folio_list));
+	do {
+		struct folio *folio = lru_to_folio(folio_list);
+
+		if (nid == folio_nid(folio)) {
+			list_move(&folio->lru, &node_folio_list);
+			continue;
+		}
+
+		nr_migrated += damon_migrate_folio_list(&node_folio_list,
+							   NODE_DATA(nid),
+							   target_nid);
+		nid = folio_nid(lru_to_folio(folio_list));
+	} while (!list_empty(folio_list));
+
+	nr_migrated += damon_migrate_folio_list(&node_folio_list,
+						   NODE_DATA(nid),
+						   target_nid);
+
+	memalloc_noreclaim_restore(noreclaim_flag);
+
+	return nr_migrated;
+}
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index cc9f5da9c012..54209a7e70e6 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -16,3 +16,5 @@ int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
 int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
+
+unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index fcab148e6865..48e3e6fed636 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -13,7 +13,6 @@
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/memory-tiers.h>
-#include <linux/migrate.h>
 #include <linux/mm_inline.h>
 
 #include "../internal.h"
@@ -381,125 +380,6 @@ static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
 			sz_filter_passed);
 }
 
-static unsigned int __damon_pa_migrate_folio_list(
-		struct list_head *migrate_folios, struct pglist_data *pgdat,
-		int target_nid)
-{
-	unsigned int nr_succeeded = 0;
-	struct migration_target_control mtc = {
-		/*
-		 * Allocate from 'node', or fail quickly and quietly.
-		 * When this happens, 'page' will likely just be discarded
-		 * instead of migrated.
-		 */
-		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
-			__GFP_NOWARN | __GFP_NOMEMALLOC | GFP_NOWAIT,
-		.nid = target_nid,
-	};
-
-	if (pgdat->node_id == target_nid || target_nid == NUMA_NO_NODE)
-		return 0;
-
-	if (list_empty(migrate_folios))
-		return 0;
-
-	/* Migration ignores all cpuset and mempolicy settings */
-	migrate_pages(migrate_folios, alloc_migration_target, NULL,
-		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DAMON,
-		      &nr_succeeded);
-
-	return nr_succeeded;
-}
-
-static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
-						struct pglist_data *pgdat,
-						int target_nid)
-{
-	unsigned int nr_migrated = 0;
-	struct folio *folio;
-	LIST_HEAD(ret_folios);
-	LIST_HEAD(migrate_folios);
-
-	while (!list_empty(folio_list)) {
-		struct folio *folio;
-
-		cond_resched();
-
-		folio = lru_to_folio(folio_list);
-		list_del(&folio->lru);
-
-		if (!folio_trylock(folio))
-			goto keep;
-
-		/* Relocate its contents to another node. */
-		list_add(&folio->lru, &migrate_folios);
-		folio_unlock(folio);
-		continue;
-keep:
-		list_add(&folio->lru, &ret_folios);
-	}
-	/* 'folio_list' is always empty here */
-
-	/* Migrate folios selected for migration */
-	nr_migrated += __damon_pa_migrate_folio_list(
-			&migrate_folios, pgdat, target_nid);
-	/*
-	 * Folios that could not be migrated are still in @migrate_folios.  Add
-	 * those back on @folio_list
-	 */
-	if (!list_empty(&migrate_folios))
-		list_splice_init(&migrate_folios, folio_list);
-
-	try_to_unmap_flush();
-
-	list_splice(&ret_folios, folio_list);
-
-	while (!list_empty(folio_list)) {
-		folio = lru_to_folio(folio_list);
-		list_del(&folio->lru);
-		folio_putback_lru(folio);
-	}
-
-	return nr_migrated;
-}
-
-static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
-					    int target_nid)
-{
-	int nid;
-	unsigned long nr_migrated = 0;
-	LIST_HEAD(node_folio_list);
-	unsigned int noreclaim_flag;
-
-	if (list_empty(folio_list))
-		return nr_migrated;
-
-	noreclaim_flag = memalloc_noreclaim_save();
-
-	nid = folio_nid(lru_to_folio(folio_list));
-	do {
-		struct folio *folio = lru_to_folio(folio_list);
-
-		if (nid == folio_nid(folio)) {
-			list_move(&folio->lru, &node_folio_list);
-			continue;
-		}
-
-		nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
-							   NODE_DATA(nid),
-							   target_nid);
-		nid = folio_nid(lru_to_folio(folio_list));
-	} while (!list_empty(folio_list));
-
-	nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
-						   NODE_DATA(nid),
-						   target_nid);
-
-	memalloc_noreclaim_restore(noreclaim_flag);
-
-	return nr_migrated;
-}
-
 static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
@@ -527,7 +407,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 		addr += folio_size(folio);
 		folio_put(folio);
 	}
-	applied = damon_pa_migrate_pages(&folio_list, s->target_nid);
+	applied = damon_migrate_pages(&folio_list, s->target_nid);
 	cond_resched();
 	s->last_applied = folio;
 	return applied * PAGE_SIZE;
-- 
2.43.0


