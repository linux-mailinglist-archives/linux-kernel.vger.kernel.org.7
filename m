Return-Path: <linux-kernel+bounces-625924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83489AA3BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 01:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509524E0BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 23:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8525D2DAF91;
	Tue, 29 Apr 2025 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CJCd6vVv"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9B126989D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745967902; cv=none; b=NN90vJceO4tHe1wR0xxKtTd3DnpKa4x7JuKQhfY37bPuhqOt2aFSMSd7xbfY0XcZfAu8snSST17te2AdTdCW95wQsnI6gybt2Iusvkz0QgV8jxa9tqD9erT2pww3BieiFR0nB+1Zx3HYocy+O0UPfOM/VdUzTYSuip8H6N6KBdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745967902; c=relaxed/simple;
	bh=kNpHfcQPDo+Dwyzi8dvG+NXgW53MJezi2FuhTG11jW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FA9ubyTmvX2CM2cTmmhQtXVVfZgb0aPRpPaN70llMq5AUYEg4VPVvFqtehNJhSdxNewpu1lDKAGCuZq24MbXrueZWajZpESquJV38K+VJYy7diCH9tzyYCrYOfbsQpNPVaixI3b2eMoEX+Cx+ACXd09fzqjo3ddCVjkGP+0mZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CJCd6vVv; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745967896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nbvCkVhHHtDcKqUC2DWDg/6KEw2udjRnrOYkfHNgmcQ=;
	b=CJCd6vVvXZmXfHc16o6jHtkjQhqPmzqlTLuls9wv21E9hSk5pLIRwuOpgLHAUdkr/xPWcd
	YcTswv8gGCM1Yzmbh01N3laHDwhpOTiw6sGCXQu1zWaXvJcc+GAOhT5P6u74GEev34ey9n
	DoqFyl9jm8SW2DIYAreOcNHzQRvsdqI=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 1/4] memcg: simplify consume_stock
Date: Tue, 29 Apr 2025 16:04:25 -0700
Message-ID: <20250429230428.1935619-2-shakeel.butt@linux.dev>
In-Reply-To: <20250429230428.1935619-1-shakeel.butt@linux.dev>
References: <20250429230428.1935619-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The consume_stock() does not need to check gfp_mask for spinning and can
simply trylock the local lock to decide to proceed or fail. No need to
spin at all for local lock.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 650fe4314c39..40d0838d88bc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1804,16 +1804,14 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
  * consume_stock: Try to consume stocked charge on this cpu.
  * @memcg: memcg to consume from.
  * @nr_pages: how many pages to charge.
- * @gfp_mask: allocation mask.
  *
- * The charges will only happen if @memcg matches the current cpu's memcg
- * stock, and at least @nr_pages are available in that stock.  Failure to
- * service an allocation will refill the stock.
+ * Consume the cached charge if enough nr_pages are present otherwise return
+ * failure. Also return failure for charge request larger than
+ * MEMCG_CHARGE_BATCH or if the local lock is already taken.
  *
  * returns true if successful, false otherwise.
  */
-static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
-			  gfp_t gfp_mask)
+static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
 	uint8_t stock_pages;
@@ -1821,12 +1819,8 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 	bool ret = false;
 	int i;
 
-	if (nr_pages > MEMCG_CHARGE_BATCH)
-		return ret;
-
-	if (gfpflags_allow_spinning(gfp_mask))
-		local_lock_irqsave(&memcg_stock.stock_lock, flags);
-	else if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags))
+	if (nr_pages > MEMCG_CHARGE_BATCH ||
+	    !local_trylock_irqsave(&memcg_stock.stock_lock, flags))
 		return ret;
 
 	stock = this_cpu_ptr(&memcg_stock);
@@ -2329,7 +2323,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	unsigned long pflags;
 
 retry:
-	if (consume_stock(memcg, nr_pages, gfp_mask))
+	if (consume_stock(memcg, nr_pages))
 		return 0;
 
 	if (!gfpflags_allow_spinning(gfp_mask))
-- 
2.47.1


