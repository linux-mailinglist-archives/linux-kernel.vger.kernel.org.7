Return-Path: <linux-kernel+bounces-830760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784AFB9A73B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B564E28A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11643126CE;
	Wed, 24 Sep 2025 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WaQ7Y9qd"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15953115A0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726027; cv=none; b=RE9ZbiezzkhHQCqDKmxjgBWN8vpS4QOidHBCr9lYQvo9jzgRDbe8qX9TQYCqefRyRnkdH5cJ8/Lm8CudqF4ay+MEKf0MN7J2uYJJLX1m5dHFlY+q6DmH0qnD/zYetQ6HLdKao8spmrktZKmWuxNiM+0Fy+Zo4OLv37RwB38hWmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726027; c=relaxed/simple;
	bh=DpKQYYOwhhNiFVGoyRG8dxQpnsEucQPZHGf7AUa02ls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pUgCgNiWBrYi0WjwKJb9rK9pqmxQ5GJvvKnVSjkvHa0JoDMzAM8wsNoZGrq3zThg/q4uPHgQHoGOBaeh8nHsXlJtadfB3ruzqu86QgSAnAFK5vmcy+AgpyN7eqj2qkmqCZMiqRnFSGyrw1txhZtw6kkWAMnV7qyKp6hXQnfGUfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WaQ7Y9qd; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3ece14b9231so3547817f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726024; x=1759330824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=41pQw++XrTQuPmXHdjyzKZvwkMfko68cyk5qRol2Kg0=;
        b=WaQ7Y9qdlkB79Lu50kIIOUvwYumy/dP1277iGbJgrvsS0q+bI4cjXYAxQ4Qauzd1u8
         8JXT8u9PCPuttcKF5sqGpcP5fO5lIq/q0EwgSo0v+U+uiu1P3sFnuMBvppeADSjaVQbe
         WQCha+TxdxBMifJhL6jD6UDdeiIgb03oX4J7JHaWbRphuOyqtq45co/iXjzKPiBf1CwV
         iBZT3DmxxpFgKZACE6q6CccEyDStktcIiKahgluSa3uzc7NiGuPaBB6FfY3zmNIJVszA
         SJvo/P/xwd0bkBCZ48w2q0k0tleS3KlIokUCkxpmT+ImuG4/LOMBq6CejQzq0+zNc3QJ
         a/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726024; x=1759330824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41pQw++XrTQuPmXHdjyzKZvwkMfko68cyk5qRol2Kg0=;
        b=U7Zw9k1KhM8wmeDrYVoNCQRNzo9j79ZOIjEJ0ySTa/2S6tDz7U+zbBBIyHi19Lmfdo
         o9ZqveQVVd2BkIQ3rWJNF26M0pgorU/qEvWaTnRuXmVnD8lW410QYPW5u8SCSr2E53Ai
         v/Vxmgikudbjl7dBYEHxdg38u7Be/Vt3gpo+wvzo1TjHZKZUAsJqyPoMS8QawhsGQsao
         wtjzjWQ8J65E3jFSyF8mQUWWgzdV5fBaIgSchk34g89ZheTWutzjrzqCZ/Jvx3COknis
         dChyBhnv2xupY9JQbDCNxAIY0ihuHST+3KS1dFl04Ld5SkeEpi6EJNz8ZNjrY21Z1wsB
         ZFgw==
X-Forwarded-Encrypted: i=1; AJvYcCXHEvBpknJdX1RPGOxlOpNKJh/qsIvOeT1Xkb+2hXzKgHYPuKzUpUydjx3qHbOy62WiKPD0eJ6zzEymc+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNbdZ3TgP88UNg05RVwSg/grJyDdP9Qd1s6dO81v8VSU74sRjc
	ySAPxmIlFLxQlJxw4iBomsjm1lw/tKpbRcAUAQIEUwJGBIbkPNi5AHAMxmytxzIO8nEkV0rZmEg
	gvFAeypkmHkj14A==
X-Google-Smtp-Source: AGHT+IHkwdtdIH8CI6uyF/rnsDuP+ou/4VjkKWWzkjAqCtb5L9y32bbpEud8KTzQ+39EVfVnPp60ULCATUlEug==
X-Received: from wrbl12.prod.google.com ([2002:adf:a38c:0:b0:3ec:a590:990])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4210:b0:3e4:5717:368e with SMTP id ffacd0b85a97d-40e498b7705mr228614f8f.2.1758726023909;
 Wed, 24 Sep 2025 08:00:23 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:51 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-16-2d861768041f@google.com>
Subject: [PATCH 16/21] mm/page_alloc: introduce ALLOC_NOBLOCK
From: Brendan Jackman <jackmanb@google.com>
To: jackmanb@google.com, Andy Lutomirski <luto@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org, 
	david@redhat.com, derkling@google.com, junaids@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com, 
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org, 
	yosry.ahmed@linux.dev
Content-Type: text/plain; charset="utf-8"

This flag is set unless we can be sure the caller isn't in an atomic
context.

The allocator will soon start needing to call set_direct_map_* APIs
which cannot be called with IRQs off. It will need to do this even
before direct reclaim is possible.

Despite the fact that, in principle, ALLOC_NOBLOCK is distinct from
__GFP_DIRECT_RECLAIM, in order to avoid introducing a GFP flag, just
infer the former based on whether the caller set the latter. This means
that, in practice, ALLOC_NOBLOCK is just !__GFP_DIRECT_RECLAIM, except
that it is not influenced by gfp_allowed_mask.

Call it ALLOC_NOBLOCK in order to try and mitigate confusion vs the
recently-removed ALLOC_NON_BLOCK, which meant something different.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/internal.h   |  1 +
 mm/page_alloc.c | 29 ++++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 513aba6c00bed813c9e38464aec5a15e65edaa58..c697ed35a8ca3376445d1e4249e9ce03097f15b8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1315,6 +1315,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
 #define ALLOC_TRYLOCK		0x400 /* Only use spin_trylock in allocation path */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
+#define ALLOC_NOBLOCK	       0x1000 /* Caller may be atomic */
 
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_HARDER|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cd47cfaae820ce696d2e6e0c47436e00d3feef60..b0aeb97baa13af038fff0edae33affbbf49e825c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4552,6 +4552,8 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
 
 	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
+		alloc_flags |= ALLOC_NOBLOCK;
+
 		/*
 		 * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
 		 * if it can't schedule.
@@ -4745,14 +4747,13 @@ check_retry_cpuset(int cpuset_mems_cookie, struct alloc_context *ac)
 
 static inline struct page *
 __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
-						struct alloc_context *ac)
+		       struct alloc_context *ac, unsigned int alloc_flags)
 {
 	bool can_direct_reclaim = gfp_mask & __GFP_DIRECT_RECLAIM;
 	bool can_compact = gfp_compaction_allowed(gfp_mask);
 	bool nofail = gfp_mask & __GFP_NOFAIL;
 	const bool costly_order = order > PAGE_ALLOC_COSTLY_ORDER;
 	struct page *page = NULL;
-	unsigned int alloc_flags;
 	unsigned long did_some_progress;
 	enum compact_priority compact_priority;
 	enum compact_result compact_result;
@@ -4795,7 +4796,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * kswapd needs to be woken up, and to avoid the cost of setting up
 	 * alloc_flags precisely. So we do that now.
 	 */
-	alloc_flags = gfp_to_alloc_flags(gfp_mask, order);
+	alloc_flags |= gfp_to_alloc_flags(gfp_mask, order);
 
 	/*
 	 * We need to recalculate the starting point for the zonelist iterator
@@ -5045,6 +5046,19 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	return page;
 }
 
+static inline unsigned int init_alloc_flags(gfp_t gfp_mask, unsigned int flags)
+{
+	/*
+	 * If the caller allowed __GFP_DIRECT_RECLAIM, they can't be atomic.
+	 * Note this is a separate determination from whether direct
+	 * reclaim is actually allowed, it must happen before applying
+	 * gfp_allowed_mask.
+	 */
+	if (!(gfp_mask & __GFP_DIRECT_RECLAIM))
+		flags |= ALLOC_NOBLOCK;
+	return flags;
+}
+
 static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 		int preferred_nid, nodemask_t *nodemask,
 		struct alloc_context *ac, gfp_t *alloc_gfp,
@@ -5121,7 +5135,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	struct list_head *pcp_list;
 	struct alloc_context ac;
 	gfp_t alloc_gfp;
-	unsigned int alloc_flags = ALLOC_WMARK_LOW;
+	unsigned int alloc_flags = init_alloc_flags(gfp, ALLOC_WMARK_LOW);
 	int nr_populated = 0, nr_account = 0;
 
 	/*
@@ -5267,7 +5281,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 		int preferred_nid, nodemask_t *nodemask)
 {
 	struct page *page;
-	unsigned int alloc_flags = ALLOC_WMARK_LOW;
+	unsigned int alloc_flags = init_alloc_flags(gfp, ALLOC_WMARK_LOW);
 	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
 
@@ -5319,7 +5333,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 	 */
 	ac.nodemask = nodemask;
 
-	page = __alloc_pages_slowpath(alloc_gfp, order, &ac);
+	page = __alloc_pages_slowpath(alloc_gfp, order, &ac, alloc_flags);
 
 out:
 	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
@@ -7684,10 +7698,11 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 	 */
 	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC | __GFP_COMP
 			| gfp_flags;
-	unsigned int alloc_flags = ALLOC_TRYLOCK;
+	unsigned int alloc_flags = init_alloc_flags(gfp_flags, ALLOC_TRYLOCK);
 	struct alloc_context ac = { };
 	struct page *page;
 
+	VM_WARN_ON_ONCE(!(alloc_flags & ALLOC_NOBLOCK));
 	VM_WARN_ON_ONCE(gfp_flags & ~__GFP_ACCOUNT);
 	/*
 	 * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which is

-- 
2.50.1


