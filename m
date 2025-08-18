Return-Path: <linux-kernel+bounces-772979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A6B29A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB6517C303
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3699327934B;
	Mon, 18 Aug 2025 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIZVzUMH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858FF271457;
	Mon, 18 Aug 2025 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499590; cv=none; b=faEwq1pxovpUTWzUJQw9c2hpbQz699M6jQEvGoRtuwgJlozDuZBbfdGmiqkoq4NNoFWDi0pIgZYkehQEo2cj5aItuk3DTVJcANFLDUeKvtHFzyj+psJO3AAYn7YqQ44JItuEg9wjRziIEVHZMDVwLPnFleZd4E4ybEcjS4G9C8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499590; c=relaxed/simple;
	bh=5eSfCtdZloXF8ewebFcesyIx+wEpCfgf7oheGJfpmyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGSUgvwAFv6HdRJ1WIr1vtU08MD2GMBzMGH/CLLNCcksiwLpf16sosbQwgwMqLffsVR4UUcphMrsVdCJwlj3V4JEcbCqwFlc+CQcmG4yd+lB6XBQtsncg6RtHar+RKRrHPZugOBVFF7tbOg3pxMIeO6oRce2K+naOwcuJO1js0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIZVzUMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05165C4CEEB;
	Mon, 18 Aug 2025 06:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755499590;
	bh=5eSfCtdZloXF8ewebFcesyIx+wEpCfgf7oheGJfpmyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JIZVzUMHBOjxEJIsAsKLJVaP/k5p0NKfh9iQouzhRsaNWKVfLpr4A4Hn4ESMremCr
	 U/eytjBACZepXoOYyenDDEZluSvgj5g3bZI3cInpMUYHz8Db+Y49P7D/ZTFy4Qs2WE
	 5ds52Bni3LYsuNAv+sqjdE8uhnOuRYwc2BfoL0ynhD2aq2inEhY7zsmwfoHJulgfSk
	 XrnHUrqOUWsUxdMvLqo79rRZbNTN/Gh4ErlL+CtzOrxRLMoj/0F6iVu6aQHSs9Umvh
	 4erND4l+1nYMW68x2BY2/gudB7atMQNNFslobrMsAUcb+BAG+ljpBaItW/uGLvySMN
	 TSRnHX3GWdUmA==
From: Mike Rapoport <rppt@kernel.org>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Justin Stitt <justinstitt@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miguel Ojeda <ojeda@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 2/4] mm/mm_init: deferred_init_memmap: use a job per zone
Date: Mon, 18 Aug 2025 09:46:13 +0300
Message-ID: <20250818064615.505641-3-rppt@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818064615.505641-1-rppt@kernel.org>
References: <20250818064615.505641-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

deferred_init_memmap() loops over free memory ranges and creates a
padata_mt_job for every free range that intersects with the zone being
initialized.

padata_do_multithreaded() then splits every such range to several chunks
and runs a thread that initializes struct pages in that chunk using
deferred_init_memmap_chunk(). The number of threads is limited by amount of
the CPUs on the node (or 1 for memoryless nodes).

Looping through free memory ranges is then repeated in
deferred_init_memmap_chunk() first to find the first range that should be
initialized and then to traverse the ranges until the end of the chunk is
reached.

Remove the loop over free memory regions in deferred_init_memmap() and pass
the entire zone to padata_do_multithreaded() so that it will be divided to
several chunks by the parallelization code.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/mm_init.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 81809b83814b..1ecfba98ddbe 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2176,12 +2176,10 @@ static int __init deferred_init_memmap(void *data)
 {
 	pg_data_t *pgdat = data;
 	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
-	unsigned long spfn = 0, epfn = 0;
-	unsigned long first_init_pfn, flags;
+	int max_threads = deferred_page_init_max_threads(cpumask);
+	unsigned long first_init_pfn, last_pfn, flags;
 	unsigned long start = jiffies;
 	struct zone *zone;
-	int max_threads;
-	u64 i = 0;
 
 	/* Bind memory initialisation thread to a local node if possible */
 	if (!cpumask_empty(cpumask))
@@ -2209,24 +2207,20 @@ static int __init deferred_init_memmap(void *data)
 
 	/* Only the highest zone is deferred */
 	zone = pgdat->node_zones + pgdat->nr_zones - 1;
-
-	max_threads = deferred_page_init_max_threads(cpumask);
-
-	while (deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn, first_init_pfn)) {
-		first_init_pfn = ALIGN(epfn, PAGES_PER_SECTION);
-		struct padata_mt_job job = {
-			.thread_fn   = deferred_init_memmap_job,
-			.fn_arg      = zone,
-			.start       = spfn,
-			.size        = first_init_pfn - spfn,
-			.align       = PAGES_PER_SECTION,
-			.min_chunk   = PAGES_PER_SECTION,
-			.max_threads = max_threads,
-			.numa_aware  = false,
-		};
-
-		padata_do_multithreaded(&job);
-	}
+	last_pfn = SECTION_ALIGN_UP(zone_end_pfn(zone));
+
+	struct padata_mt_job job = {
+		.thread_fn   = deferred_init_memmap_job,
+		.fn_arg      = zone,
+		.start       = first_init_pfn,
+		.size        = last_pfn - first_init_pfn,
+		.align       = PAGES_PER_SECTION,
+		.min_chunk   = PAGES_PER_SECTION,
+		.max_threads = max_threads,
+		.numa_aware  = false,
+	};
+
+	padata_do_multithreaded(&job);
 
 	/* Sanity check that the next zone really is unpopulated */
 	WARN_ON(pgdat->nr_zones < MAX_NR_ZONES && populated_zone(++zone));
-- 
2.50.1


