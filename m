Return-Path: <linux-kernel+bounces-841539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88A3BB79D7
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7829E48762A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466C92D63E8;
	Fri,  3 Oct 2025 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eCEknGtn"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD632D593E
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510449; cv=none; b=eDp/vOiZRQAQIZgXLsNXjKZTpCb6aEkAkzVSXhD2uK4tX8nfkvgib+in3LRX4A5ARLp2mwAXuW0a/TT3LncTQOoX/Qs+1mye6U0nKgE0aNkkFrxVotS19leRw1Ukzvh4jro0xXw9OuGy8kEOPA00KrB/ziLhLjolDzNJHhpgowI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510449; c=relaxed/simple;
	bh=so7RJfeebSI74NMFkG2yWQ6L7+S2r5cp1MxkdrBK8Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jK2yTe6o7xbbI0kbzq5xcuF7rZHNh3u9ESIj6rMAC65dWD61J+Jt7UDutXniYufF5NKVI0tpcSSUl/9IqyObcYKAxfiqs/cGdcHTo/Iakr5uGk2y9/U5Capf/yi/vZY3l3Yc3kohm5lz63ADi2VxRpjfuQQvgWU3V1XO0QoP04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eCEknGtn; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759510441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LmuFZk4/UAW/wxAkzYqRFSTRE4mQotQ2IEfc61WTNZc=;
	b=eCEknGtnpG1txOB/xuohDbik3Bh3/mtFYzYUJHnoMppqy0PbH9ce2dCt9hDtS3WpkkGqjG
	IiWtXzrD2fA5/8OzbDiUi2/VtABzaS3OI4k7w5ComIG1Sw9goA7F3o0QggxvKWFb/R6Mdp
	h58jJLc135v47IBEBxLD/LPWvNht2Ko=
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
Subject: [PATCH v4 1/4] mm: thp: replace folio_memcg() with folio_memcg_charged()
Date: Sat,  4 Oct 2025 00:53:15 +0800
Message-ID: <7bb571c217c3c14c47e86706a50c1b792e88b4d6.1759510072.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1759510072.git.zhengqi.arch@bytedance.com>
References: <cover.1759510072.git.zhengqi.arch@bytedance.com>
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
index 1b81680b4225f..6db24b3a57005 100644
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


