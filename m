Return-Path: <linux-kernel+bounces-855016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90562BDFF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BBBB4E8EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84B92FF157;
	Wed, 15 Oct 2025 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S7jxapwC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="laPpn4W6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SZSQv1sO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jTvP7Oh6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE802163B2
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760550652; cv=none; b=lxf3FvAL92PBIO+Eu97NjZrdsyt72ar0Ywb8L81lEoMc7y80/eJR+uTr/fJEhdNETdtqaN+4kYk6kFeQAPIF3qbKjt3l271pNheX/UOgVbR3YeC045Dvo8npEFpZXDG730JtTFZ7Ml73TN1IoNBoZvAhdmnrbJUqri3Ws11goPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760550652; c=relaxed/simple;
	bh=5YeiXycEHBP9UL7SpqxhlXaE4HDt2xnE7RFWrPOXngE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sj9mHuRn2uX1JMEngGlnd7aVbUO34D2wSwsJIg9wX+CVNSfP3q0oEwUq2mQRuifbzGMq++ELxJ07GgwPiTLez89ioin9dn3Wu/XPRZkcgWtwNikDnLKoWGi8vULSXuPDTigcjA1YFd9M+/75GG4Bzj1mPF1EF83PDZdUKiDHUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S7jxapwC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=laPpn4W6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SZSQv1sO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jTvP7Oh6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1ED2F229E8;
	Wed, 15 Oct 2025 17:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760550649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eQ75EAJh+K3fc00OxjTeenY3SD53Rdq8gimDFm5M73g=;
	b=S7jxapwCWwYuHKP1GFIjPSeBv17whoOQxJL9gU9GbQozuCtMcF/J5PG+nxDmEPjcUsYyLC
	O9xXRF8A4TwTpxe/JHj9dVjnFf9/rh/afYMC/dslXMP9iGlU9Zde1Prqe3iml78S4bylUW
	iug3WcDXXzOcz0bJk2fErnVj0TuEp40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760550649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eQ75EAJh+K3fc00OxjTeenY3SD53Rdq8gimDFm5M73g=;
	b=laPpn4W6F8reiAnkpLl82N7OF3lH1hk9XMYHJRwaGfr7n66fKIuuPM+FoDOBqDnqSjm/QV
	fomcN8tuAa5/rWAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760550648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eQ75EAJh+K3fc00OxjTeenY3SD53Rdq8gimDFm5M73g=;
	b=SZSQv1sOQtk6RB+iX5xnq9u3NpbtZRJ19XHB9kX1wAfP0j7fkjf8LNNRZb6nzp9MBdTfhw
	xSOxX5xNJiMVyY9cWXYMLbyO6b/UReOPwCWPMXPqEhu77LFrqA9fbIfQaqypGFTGKMqV+k
	YMQFR3bCeuZSG6QBTk3e8Vmhi5MUNyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760550648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eQ75EAJh+K3fc00OxjTeenY3SD53Rdq8gimDFm5M73g=;
	b=jTvP7Oh6ltI28GHkR6hIGTsiHCrbnDycKuWE9p2ehLtO/TBzfS9G+orrrjiGnYf0Yowzjp
	wKdA5tJJhgs8L7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 077E913A42;
	Wed, 15 Oct 2025 17:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pCFxAfje72jTTgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 15 Oct 2025 17:50:48 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 15 Oct 2025 19:50:38 +0200
Subject: [PATCH v2] mm/page_alloc: simplify and cleanup pcp locking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-b4-pcp-lock-cleanup-v2-1-740d999595d5@suse.cz>
X-B4-Tracking: v=1; b=H4sIAO3e72gC/32NQQ7CIBBFr9LM2jFA2lBdeY+mC6BTS2yAgCVqw
 93FHsDle8l/f4dE0VKCa7NDpGyT9a6CODVgFuXuhHaqDIKJjjPeoW4xmICrNw80Kym3BbxoyXT
 LpRKMoC5DpNm+juowVl5sevr4Pk4y/9n/vcyRYy97YiQnM2txS1uis/nAWEr5AmeEAtK0AAAA
X-Change-ID: 20251015-b4-pcp-lock-cleanup-9b70b417a20e
To: Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>
Cc: Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9848; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=5YeiXycEHBP9UL7SpqxhlXaE4HDt2xnE7RFWrPOXngE=;
 b=owEBiQF2/pANAwAIAbvgsHXSRYiaAcsmYgBo797zNbmiH4d7JrNLpLGyWlvuth3v/LOzjhmOf
 MStc63WHhKJAU8EAAEIADkWIQR7u8hBFZkjSJZITfG74LB10kWImgUCaO/e8xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQu+CwddJFiJq96wf/YG5DWuTVspUOR52b1acc5RMhQzZvNbC
 lQ6qReXKw6+gPQkZInW1xijhmYtN2Z/NgFlb+JeK22bGJN4sLHABxj6TQ0TyTKcCCgZdE3/lhHM
 LaCsN4cJQ/81WlUCwhk+YRDsiN4WktUpSwHKEo4wHdeQXOPOEb0H/nRCSE5u9r05dVzF+io7/JW
 PyeTIgP+PJhL42mPcNm/Bua3B7GmpW7o4gG7luOrEMGHOTtfFhZvAYbvBLnV4D1lm3yuQ2AQGOq
 IVQpsy9Idm/qmvdZmNI7M675YptsiSzdca9smsFAqObAUuJDMED9CLO2R77GdRKgwZPSUWdfcVU
 vV7pAbM9JdA==
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[techsingularity.net,kvack.org,vger.kernel.org,gmail.com,suse.cz];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

The pcp locking relies on pcp_spin_trylock() which has to be used
together with pcp_trylock_prepare()/pcp_trylock_finish() to work
properly on !SMP !RT configs. This is tedious and error-prone.

We can remove pcp_spin_lock() and underlying pcpu_spin_lock() because we
don't use it. Afterwards pcp_spin_unlock() is only used together with
pcp_spin_trylock(). Therefore we can add the UP_flags parameter to them
both and handle pcp_trylock_prepare()/finish() within.

Additionally for the configs where pcp_trylock_prepare()/finish() are
no-op (SMP || RT) make them pass &UP_flags to a no-op inline function.
This ensures typechecking and makes the local variable "used" so we can
remove the __maybe_unused attributes.

In my compile testing, bloat-o-meter reported no change on SMP config,
so the compiler is capable of optimizing away the no-ops same as before,
and we have simplified the code using pcp_spin_trylock().

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
based on mm-new
Changed my mind and did as Joshua suggested, for consistency. Thanks!
---
Changes in v2:
- Convert also pcp_trylock_finish() to noop function, per Joshua.
- Link to v1: https://lore.kernel.org/r/20251015-b4-pcp-lock-cleanup-v1-1-878e0e7dcfb2@suse.cz
---
 mm/page_alloc.c | 99 +++++++++++++++++++++++----------------------------------
 1 file changed, 40 insertions(+), 59 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0155a66d7367..fb91c566327c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -99,9 +99,12 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 /*
  * On SMP, spin_trylock is sufficient protection.
  * On PREEMPT_RT, spin_trylock is equivalent on both SMP and UP.
+ * Pass flags to a no-op inline function to typecheck and silence the unused
+ * variable warning.
  */
-#define pcp_trylock_prepare(flags)	do { } while (0)
-#define pcp_trylock_finish(flag)	do { } while (0)
+static inline void __pcp_trylock_noop(unsigned long *flags) { }
+#define pcp_trylock_prepare(flags)	__pcp_trylock_noop(&(flags))
+#define pcp_trylock_finish(flags)	__pcp_trylock_noop(&(flags))
 #else
 
 /* UP spin_trylock always succeeds so disable IRQs to prevent re-entrancy. */
@@ -129,15 +132,6 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
  * Generic helper to lookup and a per-cpu variable with an embedded spinlock.
  * Return value should be used with equivalent unlock helper.
  */
-#define pcpu_spin_lock(type, member, ptr)				\
-({									\
-	type *_ret;							\
-	pcpu_task_pin();						\
-	_ret = this_cpu_ptr(ptr);					\
-	spin_lock(&_ret->member);					\
-	_ret;								\
-})
-
 #define pcpu_spin_trylock(type, member, ptr)				\
 ({									\
 	type *_ret;							\
@@ -157,14 +151,21 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 })
 
 /* struct per_cpu_pages specific helpers. */
-#define pcp_spin_lock(ptr)						\
-	pcpu_spin_lock(struct per_cpu_pages, lock, ptr)
-
-#define pcp_spin_trylock(ptr)						\
-	pcpu_spin_trylock(struct per_cpu_pages, lock, ptr)
+#define pcp_spin_trylock(ptr, UP_flags)					\
+({									\
+	struct per_cpu_pages *__ret;					\
+	pcp_trylock_prepare(UP_flags);					\
+	__ret = pcpu_spin_trylock(struct per_cpu_pages, lock, ptr);	\
+	if (!__ret)							\
+		pcp_trylock_finish(UP_flags);				\
+	__ret;								\
+})
 
-#define pcp_spin_unlock(ptr)						\
-	pcpu_spin_unlock(lock, ptr)
+#define pcp_spin_unlock(ptr, UP_flags)					\
+({									\
+	pcpu_spin_unlock(lock, ptr);					\
+	pcp_trylock_finish(UP_flags);					\
+})
 
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
 DEFINE_PER_CPU(int, numa_node);
@@ -2887,13 +2888,10 @@ static bool free_frozen_page_commit(struct zone *zone,
 		if (to_free == 0 || pcp->count == 0)
 			break;
 
-		pcp_spin_unlock(pcp);
-		pcp_trylock_finish(*UP_flags);
+		pcp_spin_unlock(pcp, *UP_flags);
 
-		pcp_trylock_prepare(*UP_flags);
-		pcp = pcp_spin_trylock(zone->per_cpu_pageset);
+		pcp = pcp_spin_trylock(zone->per_cpu_pageset, *UP_flags);
 		if (!pcp) {
-			pcp_trylock_finish(*UP_flags);
 			ret = false;
 			break;
 		}
@@ -2904,8 +2902,7 @@ static bool free_frozen_page_commit(struct zone *zone,
 		 * returned in an unlocked state.
 		 */
 		if (smp_processor_id() != cpu) {
-			pcp_spin_unlock(pcp);
-			pcp_trylock_finish(*UP_flags);
+			pcp_spin_unlock(pcp, *UP_flags);
 			ret = false;
 			break;
 		}
@@ -2937,7 +2934,7 @@ static bool free_frozen_page_commit(struct zone *zone,
 static void __free_frozen_pages(struct page *page, unsigned int order,
 				fpi_t fpi_flags)
 {
-	unsigned long __maybe_unused UP_flags;
+	unsigned long UP_flags;
 	struct per_cpu_pages *pcp;
 	struct zone *zone;
 	unsigned long pfn = page_to_pfn(page);
@@ -2973,17 +2970,15 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 		add_page_to_zone_llist(zone, page, order);
 		return;
 	}
-	pcp_trylock_prepare(UP_flags);
-	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
+	pcp = pcp_spin_trylock(zone->per_cpu_pageset, UP_flags);
 	if (pcp) {
 		if (!free_frozen_page_commit(zone, pcp, page, migratetype,
 						order, fpi_flags, &UP_flags))
 			return;
-		pcp_spin_unlock(pcp);
+		pcp_spin_unlock(pcp, UP_flags);
 	} else {
 		free_one_page(zone, page, pfn, order, fpi_flags);
 	}
-	pcp_trylock_finish(UP_flags);
 }
 
 void free_frozen_pages(struct page *page, unsigned int order)
@@ -2996,7 +2991,7 @@ void free_frozen_pages(struct page *page, unsigned int order)
  */
 void free_unref_folios(struct folio_batch *folios)
 {
-	unsigned long __maybe_unused UP_flags;
+	unsigned long UP_flags;
 	struct per_cpu_pages *pcp = NULL;
 	struct zone *locked_zone = NULL;
 	int i, j;
@@ -3039,8 +3034,7 @@ void free_unref_folios(struct folio_batch *folios)
 		if (zone != locked_zone ||
 		    is_migrate_isolate(migratetype)) {
 			if (pcp) {
-				pcp_spin_unlock(pcp);
-				pcp_trylock_finish(UP_flags);
+				pcp_spin_unlock(pcp, UP_flags);
 				locked_zone = NULL;
 				pcp = NULL;
 			}
@@ -3059,10 +3053,8 @@ void free_unref_folios(struct folio_batch *folios)
 			 * trylock is necessary as folios may be getting freed
 			 * from IRQ or SoftIRQ context after an IO completion.
 			 */
-			pcp_trylock_prepare(UP_flags);
-			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
+			pcp = pcp_spin_trylock(zone->per_cpu_pageset, UP_flags);
 			if (unlikely(!pcp)) {
-				pcp_trylock_finish(UP_flags);
 				free_one_page(zone, &folio->page, pfn,
 					      order, FPI_NONE);
 				continue;
@@ -3085,10 +3077,8 @@ void free_unref_folios(struct folio_batch *folios)
 		}
 	}
 
-	if (pcp) {
-		pcp_spin_unlock(pcp);
-		pcp_trylock_finish(UP_flags);
-	}
+	if (pcp)
+		pcp_spin_unlock(pcp, UP_flags);
 	folio_batch_reinit(folios);
 }
 
@@ -3339,15 +3329,12 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct per_cpu_pages *pcp;
 	struct list_head *list;
 	struct page *page;
-	unsigned long __maybe_unused UP_flags;
+	unsigned long UP_flags;
 
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
-	pcp_trylock_prepare(UP_flags);
-	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
-	if (!pcp) {
-		pcp_trylock_finish(UP_flags);
+	pcp = pcp_spin_trylock(zone->per_cpu_pageset, UP_flags);
+	if (!pcp)
 		return NULL;
-	}
 
 	/*
 	 * On allocation, reduce the number of pages that are batch freed.
@@ -3357,8 +3344,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	pcp->free_count >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
 	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
-	pcp_spin_unlock(pcp);
-	pcp_trylock_finish(UP_flags);
+	pcp_spin_unlock(pcp, UP_flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
 		zone_statistics(preferred_zone, zone, 1);
@@ -5045,7 +5031,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 			struct page **page_array)
 {
 	struct page *page;
-	unsigned long __maybe_unused UP_flags;
+	unsigned long UP_flags;
 	struct zone *zone;
 	struct zoneref *z;
 	struct per_cpu_pages *pcp;
@@ -5139,10 +5125,9 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 		goto failed;
 
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
-	pcp_trylock_prepare(UP_flags);
-	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
+	pcp = pcp_spin_trylock(zone->per_cpu_pageset, UP_flags);
 	if (!pcp)
-		goto failed_irq;
+		goto failed;
 
 	/* Attempt the batch allocation */
 	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
@@ -5159,8 +5144,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 		if (unlikely(!page)) {
 			/* Try and allocate at least one page */
 			if (!nr_account) {
-				pcp_spin_unlock(pcp);
-				goto failed_irq;
+				pcp_spin_unlock(pcp, UP_flags);
+				goto failed;
 			}
 			break;
 		}
@@ -5171,8 +5156,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 		page_array[nr_populated++] = page;
 	}
 
-	pcp_spin_unlock(pcp);
-	pcp_trylock_finish(UP_flags);
+	pcp_spin_unlock(pcp, UP_flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(zonelist_zone(ac.preferred_zoneref), zone, nr_account);
@@ -5180,9 +5164,6 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 out:
 	return nr_populated;
 
-failed_irq:
-	pcp_trylock_finish(UP_flags);
-
 failed:
 	page = __alloc_pages_noprof(gfp, 0, preferred_nid, nodemask);
 	if (page)

---
base-commit: 550b531346a7e4e7ad31813d0d1d6a6d8c10a06f
change-id: 20251015-b4-pcp-lock-cleanup-9b70b417a20e

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


