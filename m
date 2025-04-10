Return-Path: <linux-kernel+bounces-599088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835D0A84EFF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 23:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F74146207C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 21:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D4620D4F2;
	Thu, 10 Apr 2025 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QwXVB+97"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5596EB79
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744319155; cv=none; b=TnOZfrR3gmH7nPLwY0TgCvcM3IbE1Gqcmi4hLS1lO3p4PFK/lloz+m1ThRZiyIUUlfLH9Ea6uvgjHKVMx2bPpk08TcxfD6N/qxHf74KT4AoKhMC9kq3gRBN0/k10EFzIUC19WAFERP5xnpL/YXnAp81TKH1KokvumhCaJ5K/uLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744319155; c=relaxed/simple;
	bh=DtT89+uvLHfCiKyUys+FOCLOx9WHrt9Q23xHZioOQus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iqjP7Nvj4iiIVwsNlVBcbjQbhE/V7AAEsfdhgz/qdUTYuSrWdC3VoKnHyq6ng2zrd0KoFgzHnVOVV6WqHgVinQ9PLfWoY+A79tAgK5DzmTSjP9XbDM14Jsb+7NX21NLWN6nyPDLenCqyhCepao2wLoCpTk5KDF7V5MZNisiNdaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QwXVB+97; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744319146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UySO3eXUO6+JFC4kGqzkj2HoZuMo1TTGk0FfxlKFpMM=;
	b=QwXVB+9720cVeGPvm4RweqZqY9uk03RwZuPPIbJi7yo8oYE6rDz+86RbN2cTFoK3jKl8cL
	6/QRY1wMQgGsSOZKJb2zfioVFhO73LVDHn3DtWkCGkjnv3VwKsBwIHRkshP7oLRRIQ8Ez7
	4dcvuHhxmVe/p1M8dZSSootgyomMGcc=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Waiman Long <llong@redhat.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] memcg: no refill for offlined objcg
Date: Thu, 10 Apr 2025 14:05:35 -0700
Message-ID: <20250410210535.1005312-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In our fleet, we are observing refill_obj_stock() spending a lot of cpu
in obj_cgroup_get() and on further inspection it seems like the given
objcg is offlined and the kernel has to take the slow path i.e. atomic
operations for objcg reference counting.

Other than expensive atomic operations, refilling stock of an offlined
objcg is a waster as there will not be new allocations for the offlined
objcg. In addition, refilling triggers flush of the previous objcg which
might be used in future. So, let's just avoid refilling the stock with
the offlined objcg.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2178a051bd09..23c62ae6a8c6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2474,6 +2474,17 @@ static inline void __mod_objcg_mlstate(struct obj_cgroup *objcg,
 	rcu_read_unlock();
 }
 
+static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
+				     struct pglist_data *pgdat,
+				     enum node_stat_item idx, int nr)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__mod_objcg_mlstate(objcg, pgdat, idx, nr);
+	local_irq_restore(flags);
+}
+
 static __always_inline
 struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
 {
@@ -2925,6 +2936,13 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	unsigned int nr_pages = 0;
 
+	if (unlikely(percpu_ref_is_dying(&objcg->refcnt))) {
+		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
+		if (pgdat)
+			mod_objcg_mlstate(objcg, pgdat, idx, nr_acct);
+		return;
+	}
+
 	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
-- 
2.47.1


