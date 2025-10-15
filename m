Return-Path: <linux-kernel+bounces-853847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F8DBDCC13
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1ED5E4F8237
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFEA3126A6;
	Wed, 15 Oct 2025 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sZxMVdrF"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0B3126C4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510171; cv=none; b=iHPTakY3BjPa9OA8kqMkVBIFconRwnB6FZW3VtPQqGNIQ8gIcNhaWHkLcTnFCZg1o2YfHnGld4BrflJI1Fzyus7NHctscrpXdb/zRxlBsAIwwHrH/TC7+qOYzWzVHy2e6rcVDtLRyMj3uixqFapnEUaqJJyq2edR2/ldvxEbbmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510171; c=relaxed/simple;
	bh=nvBSqZt0bHIau36FGThs7Jd8leymkIwgutkkf+0QOK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuK4J/smMFASqKYii84nnbFk3kNv9wkEw3WpgjBLo02rbEZZhrs6RYS2GWkEsKml5yhTpyPl6faR6fR93VmEiQcUCZwoQ3JBHALKAZgzR29CTXfVJTsxuSWhOZQrHZa8nbR/yGX4KKq/alPt54LbanyG34N7PsrEj8xjOkCzpjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sZxMVdrF; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760510167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQXtHg5khcpjKfA9N6hKlz732m3j1ep8SxiJ8w0fvZk=;
	b=sZxMVdrFhkD87zH9b3Mee+lB9R/FSU8wb9ObVJc8sQoieXdZAQYZvcV9B/4fjpH09EV4Tb
	IabURBYbRnKXfAnFXx5aIRo7bnIPs/jywS1YV8+p+zBNDLVW5m/r2uuhZNFMi+MID/4qjZ
	ux7cYSCnmZPPUuL4BXVK6Xk2m73xBuE=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 1/4] mm: thp: replace folio_memcg() with folio_memcg_charged()
Date: Wed, 15 Oct 2025 14:35:30 +0800
Message-ID: <bc75f3a5bd0920861e522abd83eef74d402d8b57.1760509767.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1760509767.git.zhengqi.arch@bytedance.com>
References: <cover.1760509767.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Muchun Song <songmuchun@bytedance.com>

folio_memcg_charged() is intended for use when the user is unconcerned
about the returned memcg pointer. It is more efficient than folio_memcg().
Therefore, replace folio_memcg() with folio_memcg_charged().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1d1b74950332e..3c42db542b1b9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4014,7 +4014,7 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
 	bool unqueued = false;
 
 	WARN_ON_ONCE(folio_ref_count(folio));
-	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg(folio));
+	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg_charged(folio));
 
 	ds_queue = get_deferred_split_queue(folio);
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-- 
2.20.1


