Return-Path: <linux-kernel+bounces-768430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1079B2610B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B590C1894802
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC692EBDC6;
	Thu, 14 Aug 2025 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wBoreqTo"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E922E7BB8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163598; cv=none; b=HdAo41RFciwEsSnjuUoIpAfj2iOBQxxSgOK7ycR2aBZXi4QjV5Dev60O6mR40pVfYw+0ZFRv5uXjyQD7yCuNgxKSeLjYZDJvwVwqeCswUo1yQ1oGFTwZiGW1zzIGLWuzFeXzJkc4nYBhbcat2XMvP/1f/Ae32BISSOU6NV9e6zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163598; c=relaxed/simple;
	bh=Atea1BYVKfUEYy+NezaGCYj2NZUlAd5XDr13yfVDriY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YSaL1KcIJ5t3rD+s3RpLXSzTeVwiQdMq373auCmRMgJMU58wWNGu/X1VjbTKVMuy+GGG+yrmMJrb2tk9AszyEYBRoR47NEB/H7KnGRyKLSN8SsjkiIZ2dhHuLa5mMv6xq1T2JZzGfPoUHRh5IaHHypZeabSmtnqNQVuuxyTK1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wBoreqTo; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755163592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=emoZ3W5xNYAUC7dXv43Gaqg/G8nzxOmyJkag+iQ4tUs=;
	b=wBoreqTocFVCkZD7H3eAFcewnm7j4CNzyw59FQkyLESMCXnuBd7EFhzr7sD8+iDzHdPPF4
	cc9nmPH3bPDDWpx3gjOA/rAbCe2aqzzED62rdLaFRVTpmokSw9hqxgpqByOXMPB/uQR5D6
	5bXnhujnE14Nu55BQZgDgZPxqBorMKo=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Ye Liu <liuye@kylinos.cn>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/show_mem: Print totalreserve_pages in show_mem output
Date: Thu, 14 Aug 2025 17:26:21 +0800
Message-ID: <20250814092622.24535-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Add totalreserve_pages to the main show_mem output line for easier
debugging and memory analysis. This helps developers and
administrators quickly see how many pages are reserved by the kernel
and not available for user allocations.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 mm/show_mem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index 41999e94a56d..c56d5599de45 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -201,7 +201,8 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 		" mapped:%lu shmem:%lu pagetables:%lu\n"
 		" sec_pagetables:%lu bounce:%lu\n"
 		" kernel_misc_reclaimable:%lu\n"
-		" free:%lu free_pcp:%lu free_cma:%lu\n",
+		" free:%lu free_pcp:%lu free_cma:%lu\n"
+		" totalreserve_pages:%lu\n",
 		global_node_page_state(NR_ACTIVE_ANON),
 		global_node_page_state(NR_INACTIVE_ANON),
 		global_node_page_state(NR_ISOLATED_ANON),
@@ -221,7 +222,8 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 		global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE),
 		global_zone_page_state(NR_FREE_PAGES),
 		free_pcp,
-		global_zone_page_state(NR_FREE_CMA_PAGES));
+		global_zone_page_state(NR_FREE_CMA_PAGES),
+		totalreserve_pages);
 
 	for_each_online_pgdat(pgdat) {
 		if (show_mem_node_skip(filter, pgdat->node_id, nodemask))
-- 
2.43.0


