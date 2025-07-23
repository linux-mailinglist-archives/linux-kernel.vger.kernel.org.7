Return-Path: <linux-kernel+bounces-742596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE08B0F423
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2185668D3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5564C2E92D4;
	Wed, 23 Jul 2025 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OuWGX1re";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5LPiEh6m";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OuWGX1re";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5LPiEh6m"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096752E92BC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277724; cv=none; b=LQS399YD7P6r1M2jF62wiLUyq2W+jx35BZdcteFnnXTUKCiFU4U8/pY23KI1kwXdwwBMb+Ai3tAJlviWkZ3+B1QFNdf4OFLTF1eNAHFhXKLp8DZC8rx0IKHUPaMudZwNbVr8g3UiCk/FSvWQWmxN1zENFgQDSowHDaHZ+fY0WOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277724; c=relaxed/simple;
	bh=YT8w7VwaHmfgK4rEclfK/gMg30FZkEHgEnWpjH01vUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tR1bpr2oElwHj5xQMnPW5MqkueumRvN1rwBaSvLfRuYnOXXtRq1bHiSNr6dxiqf47KixkaXlz3ttGyw6PCDTB7gjYQpvfFoj6kjJPoNyTr37bZ7u45LBMB6uwXPChYqDx7U9t5FD+jumV1N+wa4LQrRnj7zkaUFHkITwf/ALH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OuWGX1re; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5LPiEh6m; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OuWGX1re; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5LPiEh6m; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B5FD1F78E;
	Wed, 23 Jul 2025 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753277704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NduNJaepLAgleA88Uf74owzlmCV2Xd25rAPKMSWelSY=;
	b=OuWGX1reBYwHdcrtB1jJUHDHPAAEO6Lotr5bOhPTd/+WW1SIuk/aqZmQ0loeHF0PpSVNCY
	4Xri5mhxdySUk3wSpOJJmktEIgovS1c/PxOdQmX1+CTqzWLHUnaVtKhtTGUZCdNSD1ZGLh
	PeOPKobxsARx2bH3BoRsn87r4pGGbME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753277704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NduNJaepLAgleA88Uf74owzlmCV2Xd25rAPKMSWelSY=;
	b=5LPiEh6mfqbWWomKiosa3PatrDcMiL2npq5K5lfve33JyxXEleQ0XgfUGDiPG36gU3IxnW
	Tf+yfPs/CrubgIDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OuWGX1re;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5LPiEh6m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753277704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NduNJaepLAgleA88Uf74owzlmCV2Xd25rAPKMSWelSY=;
	b=OuWGX1reBYwHdcrtB1jJUHDHPAAEO6Lotr5bOhPTd/+WW1SIuk/aqZmQ0loeHF0PpSVNCY
	4Xri5mhxdySUk3wSpOJJmktEIgovS1c/PxOdQmX1+CTqzWLHUnaVtKhtTGUZCdNSD1ZGLh
	PeOPKobxsARx2bH3BoRsn87r4pGGbME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753277704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NduNJaepLAgleA88Uf74owzlmCV2Xd25rAPKMSWelSY=;
	b=5LPiEh6mfqbWWomKiosa3PatrDcMiL2npq5K5lfve33JyxXEleQ0XgfUGDiPG36gU3IxnW
	Tf+yfPs/CrubgIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E640013AF2;
	Wed, 23 Jul 2025 13:35:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aCjYNwflgGh0IwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 23 Jul 2025 13:35:03 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 23 Jul 2025 15:34:35 +0200
Subject: [PATCH v5 02/14] slab: add sheaf support for batching kfree_rcu()
 operations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-slub-percpu-caches-v5-2-b792cd830f5d@suse.cz>
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
In-Reply-To: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0B5FD1F78E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
For caches with sheaves, on each cpu maintain a rcu_free sheaf in
addition to main and spare sheaves.

kfree_rcu() operations will try to put objects on this sheaf. Once full,
the sheaf is detached and submitted to call_rcu() with a handler that
will try to put it in the barn, or flush to slab pages using bulk free,
when the barn is full. Then a new empty sheaf must be obtained to put
more objects there.

It's possible that no free sheaves are available to use for a new
rcu_free sheaf, and the allocation in kfree_rcu() context can only use
GFP_NOWAIT and thus may fail. In that case, fall back to the existing
kfree_rcu() implementation.

Expected advantages:
- batching the kfree_rcu() operations, that could eventually replace the
  existing batching
- sheaves can be reused for allocations via barn instead of being
  flushed to slabs, which is more efficient
  - this includes cases where only some cpus are allowed to process rcu
    callbacks (Android)

Possible disadvantage:
- objects might be waiting for more than their grace period (it is
  determined by the last object freed into the sheaf), increasing memory
  usage - but the existing batching does that too.

Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
implementation favors smaller memory footprint over performance.

Add CONFIG_SLUB_STATS counters free_rcu_sheaf and free_rcu_sheaf_fail to
count how many kfree_rcu() used the rcu_free sheaf successfully and how
many had to fall back to the existing implementation.

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h        |   2 +
 mm/slab_common.c |  24 +++++++
 mm/slub.c        | 193 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 214 insertions(+), 5 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 1980330c2fcb4a4613a7e4f7efc78b349993fd89..44c9b70eaabbd87c06fb39b79dfb791d515acbde 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -459,6 +459,8 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
 	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
 }
 
+bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
+
 #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
 			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
diff --git a/mm/slab_common.c b/mm/slab_common.c
index e2b197e47866c30acdbd1fee4159f262a751c5a7..2d806e02568532a1000fd3912db6978e945dcfa8 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1608,6 +1608,27 @@ static void kfree_rcu_work(struct work_struct *work)
 		kvfree_rcu_list(head);
 }
 
+static bool kfree_rcu_sheaf(void *obj)
+{
+	struct kmem_cache *s;
+	struct folio *folio;
+	struct slab *slab;
+
+	if (is_vmalloc_addr(obj))
+		return false;
+
+	folio = virt_to_folio(obj);
+	if (unlikely(!folio_test_slab(folio)))
+		return false;
+
+	slab = folio_slab(folio);
+	s = slab->slab_cache;
+	if (s->cpu_sheaves)
+		return __kfree_rcu_sheaf(s, obj);
+
+	return false;
+}
+
 static bool
 need_offload_krc(struct kfree_rcu_cpu *krcp)
 {
@@ -1952,6 +1973,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	if (!head)
 		might_sleep();
 
+	if (kfree_rcu_sheaf(ptr))
+		return;
+
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
 		// Probable double kfree_rcu(), just leak.
diff --git a/mm/slub.c b/mm/slub.c
index 6543aaade60b0adaab232b2256d65c1042c62e1c..f6d86cd3983533784583f1df6add186c4a74cd97 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -350,6 +350,8 @@ enum stat_item {
 	ALLOC_FASTPATH,		/* Allocation from cpu slab */
 	ALLOC_SLOWPATH,		/* Allocation by getting a new cpu slab */
 	FREE_PCS,		/* Free to percpu sheaf */
+	FREE_RCU_SHEAF,		/* Free to rcu_free sheaf */
+	FREE_RCU_SHEAF_FAIL,	/* Failed to free to a rcu_free sheaf */
 	FREE_FASTPATH,		/* Free to cpu slab */
 	FREE_SLOWPATH,		/* Freeing not to cpu slab */
 	FREE_FROZEN,		/* Freeing to frozen slab */
@@ -444,6 +446,7 @@ struct slab_sheaf {
 		struct rcu_head rcu_head;
 		struct list_head barn_list;
 	};
+	struct kmem_cache *cache;
 	unsigned int size;
 	void *objects[];
 };
@@ -452,6 +455,7 @@ struct slub_percpu_sheaves {
 	local_trylock_t lock;
 	struct slab_sheaf *main; /* never NULL when unlocked */
 	struct slab_sheaf *spare; /* empty or full, may be NULL */
+	struct slab_sheaf *rcu_free; /* for batching kfree_rcu() */
 	struct node_barn *barn;
 };
 
@@ -2490,6 +2494,8 @@ static struct slab_sheaf *alloc_empty_sheaf(struct kmem_cache *s, gfp_t gfp)
 	if (unlikely(!sheaf))
 		return NULL;
 
+	sheaf->cache = s;
+
 	stat(s, SHEAF_ALLOC);
 
 	return sheaf;
@@ -2614,6 +2620,43 @@ static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf)
 	sheaf->size = 0;
 }
 
+static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
+				     struct slab_sheaf *sheaf)
+{
+	bool init = slab_want_init_on_free(s);
+	void **p = &sheaf->objects[0];
+	unsigned int i = 0;
+
+	while (i < sheaf->size) {
+		struct slab *slab = virt_to_slab(p[i]);
+
+		memcg_slab_free_hook(s, slab, p + i, 1);
+		alloc_tagging_slab_free_hook(s, slab, p + i, 1);
+
+		if (unlikely(!slab_free_hook(s, p[i], init, true))) {
+			p[i] = p[--sheaf->size];
+			continue;
+		}
+
+		i++;
+	}
+}
+
+static void rcu_free_sheaf_nobarn(struct rcu_head *head)
+{
+	struct slab_sheaf *sheaf;
+	struct kmem_cache *s;
+
+	sheaf = container_of(head, struct slab_sheaf, rcu_head);
+	s = sheaf->cache;
+
+	__rcu_free_sheaf_prepare(s, sheaf);
+
+	sheaf_flush_unused(s, sheaf);
+
+	free_empty_sheaf(s, sheaf);
+}
+
 /*
  * Caller needs to make sure migration is disabled in order to fully flush
  * single cpu's sheaves
@@ -2626,7 +2669,7 @@ static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf)
 static void pcs_flush_all(struct kmem_cache *s)
 {
 	struct slub_percpu_sheaves *pcs;
-	struct slab_sheaf *spare;
+	struct slab_sheaf *spare, *rcu_free;
 
 	local_lock(&s->cpu_sheaves->lock);
 	pcs = this_cpu_ptr(s->cpu_sheaves);
@@ -2634,6 +2677,9 @@ static void pcs_flush_all(struct kmem_cache *s)
 	spare = pcs->spare;
 	pcs->spare = NULL;
 
+	rcu_free = pcs->rcu_free;
+	pcs->rcu_free = NULL;
+
 	local_unlock(&s->cpu_sheaves->lock);
 
 	if (spare) {
@@ -2641,6 +2687,9 @@ static void pcs_flush_all(struct kmem_cache *s)
 		free_empty_sheaf(s, spare);
 	}
 
+	if (rcu_free)
+		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
+
 	sheaf_flush_main(s);
 }
 
@@ -2657,6 +2706,11 @@ static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cpu)
 		free_empty_sheaf(s, pcs->spare);
 		pcs->spare = NULL;
 	}
+
+	if (pcs->rcu_free) {
+		call_rcu(&pcs->rcu_free->rcu_head, rcu_free_sheaf_nobarn);
+		pcs->rcu_free = NULL;
+	}
 }
 
 static void pcs_destroy(struct kmem_cache *s)
@@ -2682,6 +2736,7 @@ static void pcs_destroy(struct kmem_cache *s)
 		 */
 
 		WARN_ON(pcs->spare);
+		WARN_ON(pcs->rcu_free);
 
 		if (!WARN_ON(pcs->main->size)) {
 			free_empty_sheaf(s, pcs->main);
@@ -3742,7 +3797,7 @@ static bool has_pcs_used(int cpu, struct kmem_cache *s)
 
 	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
 
-	return (pcs->spare || pcs->main->size);
+	return (pcs->spare || pcs->rcu_free || pcs->main->size);
 }
 
 static void pcs_flush_all(struct kmem_cache *s);
@@ -5339,6 +5394,127 @@ bool free_to_pcs(struct kmem_cache *s, void *object)
 	return true;
 }
 
+static void rcu_free_sheaf(struct rcu_head *head)
+{
+	struct slab_sheaf *sheaf;
+	struct node_barn *barn;
+	struct kmem_cache *s;
+
+	sheaf = container_of(head, struct slab_sheaf, rcu_head);
+
+	s = sheaf->cache;
+
+	/*
+	 * This may remove some objects due to slab_free_hook() returning false,
+	 * so that the sheaf might no longer be completely full. But it's easier
+	 * to handle it as full (unless it became completely empty), as the code
+	 * handles it fine. The only downside is that sheaf will serve fewer
+	 * allocations when reused. It only happens due to debugging, which is a
+	 * performance hit anyway.
+	 */
+	__rcu_free_sheaf_prepare(s, sheaf);
+
+	barn = get_node(s, numa_mem_id())->barn;
+
+	/* due to slab_free_hook() */
+	if (unlikely(sheaf->size == 0))
+		goto empty;
+
+	/*
+	 * Checking nr_full/nr_empty outside lock avoids contention in case the
+	 * barn is at the respective limit. Due to the race we might go over the
+	 * limit but that should be rare and harmless.
+	 */
+
+	if (data_race(barn->nr_full) < MAX_FULL_SHEAVES) {
+		stat(s, BARN_PUT);
+		barn_put_full_sheaf(barn, sheaf);
+		return;
+	}
+
+	stat(s, BARN_PUT_FAIL);
+	sheaf_flush_unused(s, sheaf);
+
+empty:
+	if (data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES) {
+		barn_put_empty_sheaf(barn, sheaf);
+		return;
+	}
+
+	free_empty_sheaf(s, sheaf);
+}
+
+bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
+{
+	struct slub_percpu_sheaves *pcs;
+	struct slab_sheaf *rcu_sheaf;
+
+	if (!local_trylock(&s->cpu_sheaves->lock))
+		goto fail;
+
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	if (unlikely(!pcs->rcu_free)) {
+
+		struct slab_sheaf *empty;
+
+		if (pcs->spare && pcs->spare->size == 0) {
+			pcs->rcu_free = pcs->spare;
+			pcs->spare = NULL;
+			goto do_free;
+		}
+
+		empty = barn_get_empty_sheaf(pcs->barn);
+
+		if (empty) {
+			pcs->rcu_free = empty;
+			goto do_free;
+		}
+
+		local_unlock(&s->cpu_sheaves->lock);
+
+		empty = alloc_empty_sheaf(s, GFP_NOWAIT);
+
+		if (!empty)
+			goto fail;
+
+		if (!local_trylock(&s->cpu_sheaves->lock)) {
+			barn_put_empty_sheaf(pcs->barn, empty);
+			goto fail;
+		}
+
+		pcs = this_cpu_ptr(s->cpu_sheaves);
+
+		if (unlikely(pcs->rcu_free))
+			barn_put_empty_sheaf(pcs->barn, empty);
+		else
+			pcs->rcu_free = empty;
+	}
+
+do_free:
+
+	rcu_sheaf = pcs->rcu_free;
+
+	rcu_sheaf->objects[rcu_sheaf->size++] = obj;
+
+	if (likely(rcu_sheaf->size < s->sheaf_capacity))
+		rcu_sheaf = NULL;
+	else
+		pcs->rcu_free = NULL;
+
+	local_unlock(&s->cpu_sheaves->lock);
+
+	if (rcu_sheaf)
+		call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
+
+	stat(s, FREE_RCU_SHEAF);
+	return true;
+
+fail:
+	stat(s, FREE_RCU_SHEAF_FAIL);
+	return false;
+}
+
 /*
  * Bulk free objects to the percpu sheaves.
  * Unlike free_to_pcs() this includes the calls to all necessary hooks
@@ -5348,10 +5524,8 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *main, *empty;
+	bool init = slab_want_init_on_free(s);
 	unsigned int batch, i = 0;
-	bool init;
-
-	init = slab_want_init_on_free(s);
 
 	while (i < size) {
 		struct slab *slab = virt_to_slab(p[i]);
@@ -6838,6 +7012,11 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	struct kmem_cache_node *n;
 
 	flush_all_cpus_locked(s);
+
+	/* we might have rcu sheaves in flight */
+	if (s->cpu_sheaves)
+		rcu_barrier();
+
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
 		if (n->barn)
@@ -8251,6 +8430,8 @@ STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
 STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
 STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
 STAT_ATTR(FREE_PCS, free_cpu_sheaf);
+STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
+STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
 STAT_ATTR(FREE_FASTPATH, free_fastpath);
 STAT_ATTR(FREE_SLOWPATH, free_slowpath);
 STAT_ATTR(FREE_FROZEN, free_frozen);
@@ -8349,6 +8530,8 @@ static struct attribute *slab_attrs[] = {
 	&alloc_fastpath_attr.attr,
 	&alloc_slowpath_attr.attr,
 	&free_cpu_sheaf_attr.attr,
+	&free_rcu_sheaf_attr.attr,
+	&free_rcu_sheaf_fail_attr.attr,
 	&free_fastpath_attr.attr,
 	&free_slowpath_attr.attr,
 	&free_frozen_attr.attr,

-- 
2.50.1


