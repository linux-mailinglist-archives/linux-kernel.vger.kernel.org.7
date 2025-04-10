Return-Path: <linux-kernel+bounces-597069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F42EA834D2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 01:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7658C0B34
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 23:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069C421B9C3;
	Wed,  9 Apr 2025 23:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tW4eYrBv"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4321A5BA4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 23:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242564; cv=none; b=O+LQIUvsM7BfTIjYGdybqWL2bytBXfstsU2MOXvi2s4hGLy10sNWGhrr43599vaMNqU9+svJad0qRCzIOEOOcBYp+nRMMTa4kAfT/7psBJ3TuucmiTCN3xp4R7o1YOHf/3LNT1Ld/jIb+Z8ggaXbHr6ro7ZzNpWc5xNVzmn+0PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242564; c=relaxed/simple;
	bh=6bteriFkfzTdZSX5zx7zzEw0WeVJEzf/0AjjlNeU/gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbX4t700D0j/BKSVnyLuMyHOyxpKDYR4nSrPruKEW4x7/6gHyNqOQQt2K5y+C1kJG3yCoyA/NX7R1tv/Ab90fQ8/5kwJn2grkZiyE+Jo/ZeQFJyrmZ1O0mFMq53I5zv4j67SSAU+lTA1FoL1c1XQfkNRvMyRFWbjZbHuzfdS/64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tW4eYrBv; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744242559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=79KmuShFT0OWZoCqYUxoC00IFXDPi718JpVr84N2Wa4=;
	b=tW4eYrBvwAA03RrYgu0wtSylOO4sNUg37R9ECDivbgJG+hNF8BRnqpppDnR/mqr6pDTKQv
	SaaGCRb3fNeJtPc6gTMEmC2LBKx9ga+ANM0nwDv+MoY1BFmebvIxlsX+doz9nZCqfkFVdk
	ogjQbR5VbSEyNrOTa9PHKKt80bTWVGU=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] memcg: optimize memcg_rstat_updated
Date: Wed,  9 Apr 2025 16:49:08 -0700
Message-ID: <20250409234908.940121-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently the kernel maintains the stats updates per-memcg which is
needed to implement stats flushing threshold. On the update side, the
update is added to the per-cpu per-memcg update of the given memcg and
all of its ancestors. However when the given memcg has passed the
flushing threshold, all of its ancestors should have passed the
threshold as well. There is no need to traverse up the memcg tree to
maintain the stats updates.

Perf profile collected from our fleet shows that memcg_rstat_updated is
one of the most expensive memcg function i.e. a lot of cumulative CPU
is being spent on it. So, even small micro optimizations matter a lot.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 421740f1bcdc..ea3e40e589df 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -585,18 +585,20 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	cgroup_rstat_updated(memcg->css.cgroup, cpu);
 	statc = this_cpu_ptr(memcg->vmstats_percpu);
 	for (; statc; statc = statc->parent) {
+		/*
+		 * If @memcg is already flushable then all its ancestors are
+		 * flushable as well and also there is no need to increase
+		 * stats_updates.
+		 */
+		if (!memcg_vmstats_needs_flush(statc->vmstats))
+			break;
+
 		stats_updates = READ_ONCE(statc->stats_updates) + abs(val);
 		WRITE_ONCE(statc->stats_updates, stats_updates);
 		if (stats_updates < MEMCG_CHARGE_BATCH)
 			continue;
 
-		/*
-		 * If @memcg is already flush-able, increasing stats_updates is
-		 * redundant. Avoid the overhead of the atomic update.
-		 */
-		if (!memcg_vmstats_needs_flush(statc->vmstats))
-			atomic64_add(stats_updates,
-				     &statc->vmstats->stats_updates);
+		atomic64_add(stats_updates, &statc->vmstats->stats_updates);
 		WRITE_ONCE(statc->stats_updates, 0);
 	}
 }
-- 
2.47.1


