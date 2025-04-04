Return-Path: <linux-kernel+bounces-588178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E30A7B57B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 03:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5BD1899F48
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 01:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7920B39FCE;
	Fri,  4 Apr 2025 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GBGlTaaO"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31F22F01
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743730786; cv=none; b=db5TcrX9x2qn5zOBxdZ39PcfaV6fQW0qXa6i+lr8amOKCitLyoMjqyYmkdMA/7B1bRxp8NIBDOOsgwuXYjlQQFU4e8nTUNQ/OxlGEtm0+909kdr06deRc3j36jxtBpCRPlRALZHv102UnpNvUHgQcCYIuJ5KV9iCyvH0CZ3V4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743730786; c=relaxed/simple;
	bh=ctz754vKWw7u6LnsnYjGytOfKItBbMHZdJseJBd6xZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTCzUQH3W3kvDyQFBiC4fjOZgFbUQkkPuH/jfFfkYc3VseN1ysewpXcXyOIPK3jOivSYBJfQtn28toe6hepST4A3dDRh2xh4Fk23ZCNZJOfwWI9KGPkT9Kta3Kc+JcFyPasQ+xHm8D1CjqhIMfX4/v1dC1KDUO7XSQI24wg6EWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GBGlTaaO; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743730780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+VJqH57jlWrbThx984SIHQEcQAexzgLOXZKVlgElzs=;
	b=GBGlTaaOzOic8e54sSOr6B4iFeU2rPT3sI99/sfkGEvhKiXeEyqfuK0bvpBaWdvsDxDQZv
	XelY9nVeMRu7iMo1LxItUpyalrLdPwSU0UJPnLhiXAd8eCnsIuNtfNLnp8wiOMwWOhEJ6W
	PyvcCmYAn1lsfiVMDrkkk3ensDKlTt4=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2 3/9] memcg: introduce memcg_uncharge
Date: Thu,  3 Apr 2025 18:39:07 -0700
Message-ID: <20250404013913.1663035-4-shakeel.butt@linux.dev>
In-Reply-To: <20250404013913.1663035-1-shakeel.butt@linux.dev>
References: <20250404013913.1663035-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

At multiple places in memcontrol.c, the memory and memsw page counters
are being uncharged. This is error-prone. Let's move the functionality
to a newly introduced memcg_uncharge and call it from all those places.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 52be78515d70..dfb3f14c1178 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1822,6 +1822,13 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 	return ret;
 }
 
+static void memcg_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	page_counter_uncharge(&memcg->memory, nr_pages);
+	if (do_memsw_account())
+		page_counter_uncharge(&memcg->memsw, nr_pages);
+}
+
 /*
  * Returns stocks cached in percpu and reset cached information.
  */
@@ -1834,10 +1841,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 		return;
 
 	if (stock_pages) {
-		page_counter_uncharge(&old->memory, stock_pages);
-		if (do_memsw_account())
-			page_counter_uncharge(&old->memsw, stock_pages);
-
+		memcg_uncharge(old, stock_pages);
 		WRITE_ONCE(stock->nr_pages, 0);
 	}
 
@@ -1900,9 +1904,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		 * In case of unlikely failure to lock percpu stock_lock
 		 * uncharge memcg directly.
 		 */
-		page_counter_uncharge(&memcg->memory, nr_pages);
-		if (do_memsw_account())
-			page_counter_uncharge(&memcg->memsw, nr_pages);
+		memcg_uncharge(memcg, nr_pages);
 		return;
 	}
 	__refill_stock(memcg, nr_pages);
@@ -2876,12 +2878,8 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 
 			mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
 			memcg1_account_kmem(memcg, -nr_pages);
-			if (!mem_cgroup_is_root(memcg)) {
-				page_counter_uncharge(&memcg->memory, nr_pages);
-				if (do_memsw_account())
-					page_counter_uncharge(&memcg->memsw,
-							      nr_pages);
-			}
+			if (!mem_cgroup_is_root(memcg))
+				memcg_uncharge(memcg, nr_pages);
 
 			css_put(&memcg->css);
 		}
@@ -4702,9 +4700,7 @@ static inline void uncharge_gather_clear(struct uncharge_gather *ug)
 static void uncharge_batch(const struct uncharge_gather *ug)
 {
 	if (ug->nr_memory) {
-		page_counter_uncharge(&ug->memcg->memory, ug->nr_memory);
-		if (do_memsw_account())
-			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
+		memcg_uncharge(ug->memcg, ug->nr_memory);
 		if (ug->nr_kmem) {
 			mod_memcg_state(ug->memcg, MEMCG_KMEM, -ug->nr_kmem);
 			memcg1_account_kmem(ug->memcg, -ug->nr_kmem);
-- 
2.47.1


