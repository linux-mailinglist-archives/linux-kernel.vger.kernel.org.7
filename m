Return-Path: <linux-kernel+bounces-586106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE762A79B4C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 07:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74F137A3E6F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 05:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAE419ABC3;
	Thu,  3 Apr 2025 05:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sd7RZ3+1"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDB1156C72
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 05:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658426; cv=none; b=GH72r/2wwqh/phsHSydgt7iyutvEiYeqBbPNgxhxfKgTOShev6PUHt5NiTL2tkZvsIZm2mBMlbbaNJFD00QzOz0gCsnZgoriE3n6rMQk3pZ/lfpZcBBc5ESDvE7iHRvp4zQb0p8WO3uVmlUkFUheoz5CORw20GhvsgBS7D21PzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658426; c=relaxed/simple;
	bh=YLFcV7bEiG7OVMaq5sdUT3UZmmLf5VxniO8wU6+/8Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i149Mw8DGgPeUkIWnvKAvb13UF+Byq0YL7fxoCKjcktjjb0iWMAOpqHYEpW2wJBvw4JrWWG+fvyZUBWlceArfnBgJQmL90rfrIP6xq64Ks5iLnc6D0H9cn9axy1hDRKU19hgKlxnqAUyCWG7pmSXKWM8tkSvqBozmLVZ4m1iFa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sd7RZ3+1; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743658422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m82CvK78yYT/5lTQIxRkvnm+pZdrU14HxUh0Z7KEcQM=;
	b=Sd7RZ3+1XIjf/4oyQaMfC5OG9cDChmzgoDmBmT9cTGZFAAsTFqXvT4B6Mht5mMBnTLLChf
	2OJTzlLP2Nn624+VwKr3WxUZPnMYv7ejKI8VfK6pblRXU8ANwDkoTefKZJE35blzMJzpiE
	5zOJyIYtJorWwQJCsjjYVP+pMSmDNwM=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] memcg: vmalloc: simplify MEMCG_VMALLOC updates
Date: Wed,  2 Apr 2025 22:33:26 -0700
Message-ID: <20250403053326.26860-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The vmalloc region can either be charged to a single memcg or none. At
the moment kernel traverses all the pages backing the vmalloc region to
update the MEMCG_VMALLOC stat. However there is no need to look at all
the pages as all those pages will be charged to a single memcg or none.
Simplify the MEMCG_VMALLOC update by just looking at the first page of
the vmalloc region.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/vmalloc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3ed720a787ec..cdae76994488 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3370,12 +3370,12 @@ void vfree(const void *addr)
 
 	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
 		vm_reset_perms(vm);
+	if (vm->nr_pages && !(vm->flags & VM_MAP_PUT_PAGES))
+		mod_memcg_page_state(vm->pages[0], MEMCG_VMALLOC, -vm->nr_pages);
 	for (i = 0; i < vm->nr_pages; i++) {
 		struct page *page = vm->pages[i];
 
 		BUG_ON(!page);
-		if (!(vm->flags & VM_MAP_PUT_PAGES))
-			mod_memcg_page_state(page, MEMCG_VMALLOC, -1);
 		/*
 		 * High-order allocs for huge vmallocs are split, so
 		 * can be freed as an array of order-0 allocations
@@ -3671,12 +3671,9 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		node, page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
-	if (gfp_mask & __GFP_ACCOUNT) {
-		int i;
-
-		for (i = 0; i < area->nr_pages; i++)
-			mod_memcg_page_state(area->pages[i], MEMCG_VMALLOC, 1);
-	}
+	if (gfp_mask & __GFP_ACCOUNT && area->nr_pages)
+		mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC,
+				     area->nr_pages);
 
 	/*
 	 * If not enough pages were obtained to accomplish an
-- 
2.47.1


