Return-Path: <linux-kernel+bounces-852790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC34BD9EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EB6A504515
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB275314B6D;
	Tue, 14 Oct 2025 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qmHUBqwK"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C976314B95
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760450958; cv=none; b=jORDk4zq6ISXT8j3WMoVPYf9HvhxBCLGuWj2m2SC5TB9KOf1GwXLy+0ubAdga27WK/ivCXCsf7Fp2rUJVAq7EE4fVvmvRf08PDCfTex3KnoBi6rkIaKHJv3IneuVRo1L9EZgcyKX7/qH1HwnhRplBRXLBdrc1Mjb5FbtJYZmjsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760450958; c=relaxed/simple;
	bh=PBU4fhmS7xNaU4hsexHHxQh75ZgP+S8EWiuxCN5cjGw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W9Qij6ZIlKu2/rD3lu9ZaPxiBCCmf71l4Yj5eZATkDHWsvsELECwVSrBoTrRQhNjQqjXrw7EWQbqt4SQBer0W5E3yvduOzdbLviEbrEaFkQBhROXW6+prQjT4VOnMhmXUHZEOvtyYc4O+ZIJRu50Bw+v+Bn2DKMtYMgs3thrAQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qmHUBqwK; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760450944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HTt/KzKieiee5hMQF+Yl+hZuVbxPhLlk+WHV6D9guo8=;
	b=qmHUBqwKWNT5vYFudzOiUF4zcASTLZYuSKIEBYKIYVECM3evlnYbwtVC8+wujvSBGhkRvY
	OyuizPA56TwSUlr7qmo4GZLrjp3R+5oetCgXTIS7kckygImIJsFsBocWRNnvc2skNg4ZEq
	Ug6JIGrNsyZQALcEojvwDxh6J+Z7bGw=
From: Hao Ge <hao.ge@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v2] slab: Add check for memcg_data's upper bits in folio_memcg_kmem
Date: Tue, 14 Oct 2025 22:08:15 +0800
Message-Id: <20251014140815.383823-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

This is because OBJEXTS_ALLOC_FAIL and OBJEXTS_ALLOC_FAIL currently share
the same bit position. Therefore, we cannot simply determine whether
memcg_data still points to the slabobj_ext vector by checking
folio->memcg_data & MEMCG_DATA_OBJEXTS.

We can distinguish between these two cases by checking whether the upper
bits set:

1) MEMCG_DATA_OBJEXTS is set, but upper bits are not set,
   so it should mean obj_exts allocation failed (OBJEXTS_ALLOC_FAIL),
   thus do not report error, or

2) MEMCG_DATA_OBJEXTS is set, and upper bits are also set, so someone
   did not clear a valid folio->memcg_data before freeing the folio
   (report error).

So let's add check for memcg_data's upper bits in folio_memcg_kmem.

Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
v2: Per Vlastimil and Harry's suggestion, instead of introducing a new bit,
    implement this by checking if the highest bit is set.
    Many thanks to Vlastimil and Harry.
---
 include/linux/memcontrol.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 873e510d6f8d..f9f7ba14be04 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -534,7 +534,9 @@ static inline struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *ob
 static inline bool folio_memcg_kmem(struct folio *folio)
 {
 	VM_BUG_ON_PGFLAGS(PageTail(&folio->page), &folio->page);
-	VM_BUG_ON_FOLIO(folio->memcg_data & MEMCG_DATA_OBJEXTS, folio);
+	VM_BUG_ON_FOLIO((folio->memcg_data & MEMCG_DATA_OBJEXTS) &&
+			(folio->memcg_data & ~(ULONG_MAX >> 1)),
+			folio);
 	return folio->memcg_data & MEMCG_DATA_KMEM;
 }
 
-- 
2.25.1


