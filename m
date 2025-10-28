Return-Path: <linux-kernel+bounces-873923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA54FC15137
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3277E1AA460B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988D2336EDB;
	Tue, 28 Oct 2025 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NVJozt+A"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC013328E5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660265; cv=none; b=RdgyJM5gO9hQnTDhxVnfj+vbEsF4dnAaWLaxpTU9nYcTELx73FDgmXTVvqk5I8n/i4uruNQzmQTbA4aDyRcQQPsof1Uhd6qe/6rqBr8vDUSLP02Ms1n8A+nrWt71ABezv+zENDmtUuketieHBGme4Zngv+W28xYQtANhnqq0VvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660265; c=relaxed/simple;
	bh=DzOkPJH5frJK/3HizU5/9Z+USdIFx5BFtceq8DvgOxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gb3LXg7ZSwzVbgHSRbU4eeMSM3+Lp+nGvL3xVnwWXoSQKYwP85+X001ETkPUyTqmB5rNHnULs3YsCkg11+/1wImnW776RF5FyHylzWsz5BLDmkJhqE9jOiLkwQip5ZQn5q2xd8g1DdXlq9kAsqCO1q6p/kjq2KSEKwLoheCM+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NVJozt+A; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aojrlW5QM0w8YO0ADBtzTkECPDUg/Z5IsfaLfTy6jEI=;
	b=NVJozt+AdVtBShZigadtoWRY1WbWR7ZpmjhNfD5oqkNoSunHh7O3bg0e+LXQkCnelRdVjj
	X2BHIa3BeXi0buSPXZBq2lboVKZxjmF0FxqfxBUTEsaKvpiCYNFVxur3NjE4kwmfm6s7zF
	MSovgm+6YsP2wyb9q6luD8mzY6ZfbjY=
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
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 19/26] mm: swap: prevent lruvec release in swap module
Date: Tue, 28 Oct 2025 21:58:32 +0800
Message-ID: <c8b190b1b4f2690f12dee0e334e4c0b3f94ad260.1761658311.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1761658310.git.zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Muchun Song <songmuchun@bytedance.com>

In the near future, a folio will no longer pin its corresponding
memory cgroup. So an lruvec returned by folio_lruvec() could be
released without the rcu read lock or a reference to its memory
cgroup.

In the current patch, the rcu read lock is employed to safeguard
against the release of the lruvec in lru_note_cost_refault() and
lru_activate().

This serves as a preparatory measure for the reparenting of the
LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/swap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index ec0c654e128dc..0606795f3ccf3 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -412,18 +412,20 @@ static void lru_gen_inc_refs(struct folio *folio)
 
 static bool lru_gen_clear_refs(struct folio *folio)
 {
-	struct lru_gen_folio *lrugen;
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
+	unsigned long seq;
 
 	if (gen < 0)
 		return true;
 
 	set_mask_bits(&folio->flags.f, LRU_REFS_FLAGS | BIT(PG_workingset), 0);
 
-	lrugen = &folio_lruvec(folio)->lrugen;
+	rcu_read_lock();
+	seq = READ_ONCE(folio_lruvec(folio)->lrugen.min_seq[type]);
+	rcu_read_unlock();
 	/* whether can do without shuffling under the LRU lock */
-	return gen == lru_gen_from_seq(READ_ONCE(lrugen->min_seq[type]));
+	return gen == lru_gen_from_seq(seq);
 }
 
 #else /* !CONFIG_LRU_GEN */
-- 
2.20.1


