Return-Path: <linux-kernel+bounces-588180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFF8A7B582
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 03:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984D617A773
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 01:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCFD1537CB;
	Fri,  4 Apr 2025 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lJr61OEX"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267614A614
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743730798; cv=none; b=UREyyxAk2XizOivOSNSf/NquI/cCc26Zow2JYN7sme1ClFBBxFgQJxwQ2cqaoacM3MM62SXifGHqnzMLKfz5KtsD4ZHbR+z197jYtToMy1XTPrnO4KJjeUa6BI25+qKzWcEQ1td++WL9vOgyly9vVy5IK50FUR9TEUgcN6z9Cdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743730798; c=relaxed/simple;
	bh=v8b9Fi3MhEJftF/PX1M+/Bkc3YxAYhK3++UVDF+VxEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DstN+i3XvqJzIPB6qLmafmy6F4cKHZSeZDw6NJkfOl6oqO0otbK2UC0gGTGUk+CrvJged+AS061I7veK4yN2g9UOi1bTyTevBV0Eu1Chs07Y7CU/zOgc4vKQEEgSfd1ddeG9DZ51bNxiGWuChuPVOdmAzuxDa9ZgBL1TI++O9IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lJr61OEX; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743730794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBVDPRxC7zGlf74XAtJaE4SLulN0IfYjtlemuQUW//g=;
	b=lJr61OEX4xx/9USfw1sohnqhrgFqNhWyygUyfhavSMJTjmL+JpCYHdT4JzRjko3+YFDyoA
	o3FvDnCdezFhTPYkauE78iHGzVxwYtbUgoDBBCLUDjGvT++701sTPl2fBbo0WZl525k4sd
	c3sIlCIGT1ABcv3k91f6uLqX/LRI9r0=
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
Subject: [PATCH v2 5/9] memcg: no refilling stock from obj_cgroup_release
Date: Thu,  3 Apr 2025 18:39:09 -0700
Message-ID: <20250404013913.1663035-6-shakeel.butt@linux.dev>
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

obj_cgroup_release is called when all the references to the objcg have
been released i.e. no more memory objects are pointing to it. Most
probably objcg->memcg will be pointing to some ancestor memcg. In
obj_cgroup_release(), the kernel calls obj_cgroup_uncharge_pages() which
refills the local stock.

There is no need to refill the local stock with some ancestor memcg and
flush the local stock. Let's decouple obj_cgroup_release() from the
local stock by uncharging instead of refilling. One additional benefit
of this change is that it removes the requirement to only call
obj_cgroup_put() outside of local_lock.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 03a2be6d4a67..df52084e90f4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -129,8 +129,7 @@ bool mem_cgroup_kmem_disabled(void)
 	return cgroup_memory_nokmem;
 }
 
-static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages);
+static void memcg_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages);
 
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
@@ -163,8 +162,16 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
 	nr_pages = nr_bytes >> PAGE_SHIFT;
 
-	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages);
+	if (nr_pages) {
+		struct mem_cgroup *memcg;
+
+		memcg = get_mem_cgroup_from_objcg(objcg);
+		mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
+		memcg1_account_kmem(memcg, -nr_pages);
+		if (!mem_cgroup_is_root(memcg))
+			memcg_uncharge(memcg, nr_pages);
+		mem_cgroup_put(memcg);
+	}
 
 	spin_lock_irqsave(&objcg_lock, flags);
 	list_del(&objcg->list);
-- 
2.47.1


