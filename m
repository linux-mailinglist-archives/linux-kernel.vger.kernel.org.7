Return-Path: <linux-kernel+bounces-809651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3767B5106E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788DA1C809F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC03310644;
	Wed, 10 Sep 2025 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pxXNqw1p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xDCbppKK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dI2O39NK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/+WKm1tU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3655930FF34
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491290; cv=none; b=kYgLADJifjqKdwy2AnTni6/bTmBVN2XTImGWnahNADiyALi18KJEsP6ANy9xlPxhbuo7oCikrISNx9yfPwwpD/c0zXTeqd4r26CHmPl+4VxpJ1S19Tyl/URvWjw6HGbabw1R5dL6RLzx1jf/DaFxbCn1r+QVdUpzvw2tgWp7kAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491290; c=relaxed/simple;
	bh=HUtLjh4mG7mnZPbIylyNydz5hHyRmk9OeS5bTimFbrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ck07HlxBW0+/jbShto7ElV4C0ruKD5YdYQLqGKYWBacUHIHAxoa1+gXuFnbeJBO6f1P78VYWF3W/8TL9SWvws6k+4c9cmOZBw9pRoffujE+tv0WCdYPwSmLPGZVomoZYD8OtCFWY/xjJZsPQdbmu2cot/+6tAdeG4IuVWHN7+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pxXNqw1p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xDCbppKK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dI2O39NK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/+WKm1tU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0691434C05;
	Wed, 10 Sep 2025 08:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTJY3F3CgOixYYNExKGNnJeF/Wyp92vV8jqscqI0eDI=;
	b=pxXNqw1pNrMbx+Wqtp1OGe9imBO/wz0U4gTTzHSUdPNsDdtPxj3tQRZ2MYZa2xYMfer+Jl
	czOxAkvj5172os+KLKtIcDBxmxHMUKBIyOVNLTRfK7ZdNyiFKlJMg/NvF0Hpre91lbNCiA
	+DhfHO9K7G6RVKRZ7XpPMrtIEmj7YeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTJY3F3CgOixYYNExKGNnJeF/Wyp92vV8jqscqI0eDI=;
	b=xDCbppKKNGMG0pfkwE2YebnAAAxOvAHYRPZWlsIe+E114hKc+eDraEfkOiDGHBUigSClWL
	VhcYke0uodEGMZDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dI2O39NK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/+WKm1tU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTJY3F3CgOixYYNExKGNnJeF/Wyp92vV8jqscqI0eDI=;
	b=dI2O39NKWEG5iLR4HKT067p3iYVzVN/rUbBsV8FJuMstqEo/5t5Iy2cV8rbaGSA75Sf9Uz
	T3UpMGAUeqiE4Fw9wyi0i0a5KtkYFbahwV5GsuWG+E6kJ6SWjIxB2GwUA1wov4jSFDL+zf
	6vdB8NkXxkqSpBK9EqWR3z64sdZ8Dk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491266;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTJY3F3CgOixYYNExKGNnJeF/Wyp92vV8jqscqI0eDI=;
	b=/+WKm1tUQS6GkguMhZcqAlRsSAz3xOizI76P+P58buYatxK89/94wbth+9MVzd4au1250j
	BjnpKBxADMGZnrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE68513ABF;
	Wed, 10 Sep 2025 08:01:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WC8GNkEwwWgGJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Sep 2025 08:01:05 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 10 Sep 2025 10:01:05 +0200
Subject: [PATCH v8 03/23] slab: add opt-in caching layer of percpu sheaves
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-slub-percpu-caches-v8-3-ca3099d8352c@suse.cz>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
In-Reply-To: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz, 
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,linux.ibm.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 0691434C05
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

Specifying a non-zero value for a new struct kmem_cache_args field
sheaf_capacity will setup a caching layer of percpu arrays called
sheaves of given capacity for the created cache.

Allocations from the cache will allocate via the percpu sheaves (main or
spare) as long as they have no NUMA node preference. Frees will also
put the object back into one of the sheaves.

When both percpu sheaves are found empty during an allocation, an empty
sheaf may be replaced with a full one from the per-node barn. If none
are available and the allocation is allowed to block, an empty sheaf is
refilled from slab(s) by an internal bulk alloc operation. When both
percpu sheaves are full during freeing, the barn can replace a full one
with an empty one, unless over a full sheaves limit. In that case a
sheaf is flushed to slab(s) by an internal bulk free operation. Flushing
sheaves and barns is also wired to the existing cpu flushing and cache
shrinking operations.

The sheaves do not distinguish NUMA locality of the cached objects. If
an allocation is requested with kmem_cache_alloc_node() (or a mempolicy
with strict_numa mode enabled) with a specific node (not NUMA_NO_NODE),
the sheaves are bypassed.

The bulk operations exposed to slab users also try to utilize the
sheaves as long as the necessary (full or empty) sheaves are available
on the cpu or in the barn. Once depleted, they will fallback to bulk
alloc/free to slabs directly to avoid double copying.

The sheaf_capacity value is exported in sysfs for observability.

Sysfs CONFIG_SLUB_STATS counters alloc_cpu_sheaf and free_cpu_sheaf
count objects allocated or freed using the sheaves (and thus not
counting towards the other alloc/free path counters). Counters
sheaf_refill and sheaf_flush count objects filled or flushed from or to
slab pages, and can be used to assess how effective the caching is. The
refill and flush operations will also count towards the usual
alloc_fastpath/slowpath, free_fastpath/slowpath and other counters for
the backing slabs.  For barn operations, barn_get and barn_put count how
many full sheaves were get from or put to the barn, the _fail variants
count how many such requests could not be satisfied mainly  because the
barn was either empty or full. While the barn also holds empty sheaves
to make some operations easier, these are not as critical to mandate own
counters.  Finally, there are sheaf_alloc/sheaf_free counters.

Access to the percpu sheaves is protected by local_trylock() when
potential callers include irq context, and local_lock() otherwise (such
as when we already know the gfp flags allow blocking). The trylock
failures should be rare and we can easily fallback. Each per-NUMA-node
barn has a spin_lock.

When slub_debug is enabled for a cache with sheaf_capacity also
specified, the latter is ignored so that allocations and frees reach the
slow path where debugging hooks are processed. Similarly, we ignore it
with CONFIG_SLUB_TINY which prefers low memory usage to performance.

[boot failure: https://lore.kernel.org/all/583eacf5-c971-451a-9f76-fed0e341b815@linux.ibm.com/ ]

Reported-and-tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h |   31 ++
 mm/slab.h            |    2 +
 mm/slab_common.c     |    5 +-
 mm/slub.c            | 1164 +++++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 1142 insertions(+), 60 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index d5a8ab98035cf3e3d9043e3b038e1bebeff05b52..49acbcdc6696fd120c402adf757b3f41660ad50a 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -335,6 +335,37 @@ struct kmem_cache_args {
 	 * %NULL means no constructor.
 	 */
 	void (*ctor)(void *);
+	/**
+	 * @sheaf_capacity: Enable sheaves of given capacity for the cache.
+	 *
+	 * With a non-zero value, allocations from the cache go through caching
+	 * arrays called sheaves. Each cpu has a main sheaf that's always
+	 * present, and a spare sheaf that may be not present. When both become
+	 * empty, there's an attempt to replace an empty sheaf with a full sheaf
+	 * from the per-node barn.
+	 *
+	 * When no full sheaf is available, and gfp flags allow blocking, a
+	 * sheaf is allocated and filled from slab(s) using bulk allocation.
+	 * Otherwise the allocation falls back to the normal operation
+	 * allocating a single object from a slab.
+	 *
+	 * Analogically when freeing and both percpu sheaves are full, the barn
+	 * may replace it with an empty sheaf, unless it's over capacity. In
+	 * that case a sheaf is bulk freed to slab pages.
+	 *
+	 * The sheaves do not enforce NUMA placement of objects, so allocations
+	 * via kmem_cache_alloc_node() with a node specified other than
+	 * NUMA_NO_NODE will bypass them.
+	 *
+	 * Bulk allocation and free operations also try to use the cpu sheaves
+	 * and barn, but fallback to using slab pages directly.
+	 *
+	 * When slub_debug is enabled for the cache, the sheaf_capacity argument
+	 * is ignored.
+	 *
+	 * %0 means no sheaves will be created.
+	 */
+	unsigned int sheaf_capacity;
 };
 
 struct kmem_cache *__kmem_cache_create_args(const char *name,
diff --git a/mm/slab.h b/mm/slab.h
index 248b34c839b7ca39cf14e139c62d116efb97d30f..206987ce44a4d053ebe3b5e50784d2dd23822cd1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -235,6 +235,7 @@ struct kmem_cache {
 #ifndef CONFIG_SLUB_TINY
 	struct kmem_cache_cpu __percpu *cpu_slab;
 #endif
+	struct slub_percpu_sheaves __percpu *cpu_sheaves;
 	/* Used for retrieving partial slabs, etc. */
 	slab_flags_t flags;
 	unsigned long min_partial;
@@ -248,6 +249,7 @@ struct kmem_cache {
 	/* Number of per cpu partial slabs to keep around */
 	unsigned int cpu_partial_slabs;
 #endif
+	unsigned int sheaf_capacity;
 	struct kmem_cache_order_objects oo;
 
 	/* Allocation and freeing of slabs */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index bfe7c40eeee1a01c175766935c1e3c0304434a53..e2b197e47866c30acdbd1fee4159f262a751c5a7 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -163,6 +163,9 @@ int slab_unmergeable(struct kmem_cache *s)
 		return 1;
 #endif
 
+	if (s->cpu_sheaves)
+		return 1;
+
 	/*
 	 * We may have set a slab to be unmergeable during bootstrap.
 	 */
@@ -321,7 +324,7 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 		    object_size - args->usersize < args->useroffset))
 		args->usersize = args->useroffset = 0;
 
-	if (!args->usersize)
+	if (!args->usersize && !args->sheaf_capacity)
 		s = __kmem_cache_alias(name, object_size, args->align, flags,
 				       args->ctor);
 	if (s)
diff --git a/mm/slub.c b/mm/slub.c
index 9f671ec76131c4b0b28d5d568aa45842b5efb6d4..cba188b7e04ddf86debf9bc27a2f725db1b2056e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -363,8 +363,10 @@ static inline void debugfs_slab_add(struct kmem_cache *s) { }
 #endif
 
 enum stat_item {
+	ALLOC_PCS,		/* Allocation from percpu sheaf */
 	ALLOC_FASTPATH,		/* Allocation from cpu slab */
 	ALLOC_SLOWPATH,		/* Allocation by getting a new cpu slab */
+	FREE_PCS,		/* Free to percpu sheaf */
 	FREE_FASTPATH,		/* Free to cpu slab */
 	FREE_SLOWPATH,		/* Freeing not to cpu slab */
 	FREE_FROZEN,		/* Freeing to frozen slab */
@@ -389,6 +391,14 @@ enum stat_item {
 	CPU_PARTIAL_FREE,	/* Refill cpu partial on free */
 	CPU_PARTIAL_NODE,	/* Refill cpu partial from node partial */
 	CPU_PARTIAL_DRAIN,	/* Drain cpu partial to node partial */
+	SHEAF_FLUSH,		/* Objects flushed from a sheaf */
+	SHEAF_REFILL,		/* Objects refilled to a sheaf */
+	SHEAF_ALLOC,		/* Allocation of an empty sheaf */
+	SHEAF_FREE,		/* Freeing of an empty sheaf */
+	BARN_GET,		/* Got full sheaf from barn */
+	BARN_GET_FAIL,		/* Failed to get full sheaf from barn */
+	BARN_PUT,		/* Put full sheaf to barn */
+	BARN_PUT_FAIL,		/* Failed to put full sheaf to barn */
 	NR_SLUB_STAT_ITEMS
 };
 
@@ -435,6 +445,32 @@ void stat_add(const struct kmem_cache *s, enum stat_item si, int v)
 #endif
 }
 
+#define MAX_FULL_SHEAVES	10
+#define MAX_EMPTY_SHEAVES	10
+
+struct node_barn {
+	spinlock_t lock;
+	struct list_head sheaves_full;
+	struct list_head sheaves_empty;
+	unsigned int nr_full;
+	unsigned int nr_empty;
+};
+
+struct slab_sheaf {
+	union {
+		struct rcu_head rcu_head;
+		struct list_head barn_list;
+	};
+	unsigned int size;
+	void *objects[];
+};
+
+struct slub_percpu_sheaves {
+	local_trylock_t lock;
+	struct slab_sheaf *main; /* never NULL when unlocked */
+	struct slab_sheaf *spare; /* empty or full, may be NULL */
+};
+
 /*
  * The slab lists for all objects.
  */
@@ -447,6 +483,7 @@ struct kmem_cache_node {
 	atomic_long_t total_objects;
 	struct list_head full;
 #endif
+	struct node_barn *barn;
 };
 
 static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
@@ -454,6 +491,12 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
 	return s->node[node];
 }
 
+/* Get the barn of the current cpu's memory node */
+static inline struct node_barn *get_barn(struct kmem_cache *s)
+{
+	return get_node(s, numa_mem_id())->barn;
+}
+
 /*
  * Iterator over all nodes. The body will be executed for each node that has
  * a kmem_cache_node structure allocated (which is true for all online nodes)
@@ -470,12 +513,19 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
  */
 static nodemask_t slab_nodes;
 
-#ifndef CONFIG_SLUB_TINY
 /*
  * Workqueue used for flush_cpu_slab().
  */
 static struct workqueue_struct *flushwq;
-#endif
+
+struct slub_flush_work {
+	struct work_struct work;
+	struct kmem_cache *s;
+	bool skip;
+};
+
+static DEFINE_MUTEX(flush_lock);
+static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
 
 /********************************************************************
  * 			Core slab cache functions
@@ -2473,6 +2523,360 @@ static void *setup_object(struct kmem_cache *s, void *object)
 	return object;
 }
 
+static struct slab_sheaf *alloc_empty_sheaf(struct kmem_cache *s, gfp_t gfp)
+{
+	struct slab_sheaf *sheaf = kzalloc(struct_size(sheaf, objects,
+					s->sheaf_capacity), gfp);
+
+	if (unlikely(!sheaf))
+		return NULL;
+
+	stat(s, SHEAF_ALLOC);
+
+	return sheaf;
+}
+
+static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
+{
+	kfree(sheaf);
+
+	stat(s, SHEAF_FREE);
+}
+
+static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
+				   size_t size, void **p);
+
+
+static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
+			 gfp_t gfp)
+{
+	int to_fill = s->sheaf_capacity - sheaf->size;
+	int filled;
+
+	if (!to_fill)
+		return 0;
+
+	filled = __kmem_cache_alloc_bulk(s, gfp, to_fill,
+					 &sheaf->objects[sheaf->size]);
+
+	sheaf->size += filled;
+
+	stat_add(s, SHEAF_REFILL, filled);
+
+	if (filled < to_fill)
+		return -ENOMEM;
+
+	return 0;
+}
+
+
+static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t gfp)
+{
+	struct slab_sheaf *sheaf = alloc_empty_sheaf(s, gfp);
+
+	if (!sheaf)
+		return NULL;
+
+	if (refill_sheaf(s, sheaf, gfp)) {
+		free_empty_sheaf(s, sheaf);
+		return NULL;
+	}
+
+	return sheaf;
+}
+
+/*
+ * Maximum number of objects freed during a single flush of main pcs sheaf.
+ * Translates directly to an on-stack array size.
+ */
+#define PCS_BATCH_MAX	32U
+
+static void __kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p);
+
+/*
+ * Free all objects from the main sheaf. In order to perform
+ * __kmem_cache_free_bulk() outside of cpu_sheaves->lock, work in batches where
+ * object pointers are moved to a on-stack array under the lock. To bound the
+ * stack usage, limit each batch to PCS_BATCH_MAX.
+ *
+ * returns true if at least partially flushed
+ */
+static bool sheaf_flush_main(struct kmem_cache *s)
+{
+	struct slub_percpu_sheaves *pcs;
+	unsigned int batch, remaining;
+	void *objects[PCS_BATCH_MAX];
+	struct slab_sheaf *sheaf;
+	bool ret = false;
+
+next_batch:
+	if (!local_trylock(&s->cpu_sheaves->lock))
+		return ret;
+
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+	sheaf = pcs->main;
+
+	batch = min(PCS_BATCH_MAX, sheaf->size);
+
+	sheaf->size -= batch;
+	memcpy(objects, sheaf->objects + sheaf->size, batch * sizeof(void *));
+
+	remaining = sheaf->size;
+
+	local_unlock(&s->cpu_sheaves->lock);
+
+	__kmem_cache_free_bulk(s, batch, &objects[0]);
+
+	stat_add(s, SHEAF_FLUSH, batch);
+
+	ret = true;
+
+	if (remaining)
+		goto next_batch;
+
+	return ret;
+}
+
+/*
+ * Free all objects from a sheaf that's unused, i.e. not linked to any
+ * cpu_sheaves, so we need no locking and batching. The locking is also not
+ * necessary when flushing cpu's sheaves (both spare and main) during cpu
+ * hotremove as the cpu is not executing anymore.
+ */
+static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf)
+{
+	if (!sheaf->size)
+		return;
+
+	stat_add(s, SHEAF_FLUSH, sheaf->size);
+
+	__kmem_cache_free_bulk(s, sheaf->size, &sheaf->objects[0]);
+
+	sheaf->size = 0;
+}
+
+/*
+ * Caller needs to make sure migration is disabled in order to fully flush
+ * single cpu's sheaves
+ *
+ * must not be called from an irq
+ *
+ * flushing operations are rare so let's keep it simple and flush to slabs
+ * directly, skipping the barn
+ */
+static void pcs_flush_all(struct kmem_cache *s)
+{
+	struct slub_percpu_sheaves *pcs;
+	struct slab_sheaf *spare;
+
+	local_lock(&s->cpu_sheaves->lock);
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	spare = pcs->spare;
+	pcs->spare = NULL;
+
+	local_unlock(&s->cpu_sheaves->lock);
+
+	if (spare) {
+		sheaf_flush_unused(s, spare);
+		free_empty_sheaf(s, spare);
+	}
+
+	sheaf_flush_main(s);
+}
+
+static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cpu)
+{
+	struct slub_percpu_sheaves *pcs;
+
+	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
+
+	/* The cpu is not executing anymore so we don't need pcs->lock */
+	sheaf_flush_unused(s, pcs->main);
+	if (pcs->spare) {
+		sheaf_flush_unused(s, pcs->spare);
+		free_empty_sheaf(s, pcs->spare);
+		pcs->spare = NULL;
+	}
+}
+
+static void pcs_destroy(struct kmem_cache *s)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct slub_percpu_sheaves *pcs;
+
+		pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
+
+		/* can happen when unwinding failed create */
+		if (!pcs->main)
+			continue;
+
+		/*
+		 * We have already passed __kmem_cache_shutdown() so everything
+		 * was flushed and there should be no objects allocated from
+		 * slabs, otherwise kmem_cache_destroy() would have aborted.
+		 * Therefore something would have to be really wrong if the
+		 * warnings here trigger, and we should rather leave objects and
+		 * sheaves to leak in that case.
+		 */
+
+		WARN_ON(pcs->spare);
+
+		if (!WARN_ON(pcs->main->size)) {
+			free_empty_sheaf(s, pcs->main);
+			pcs->main = NULL;
+		}
+	}
+
+	free_percpu(s->cpu_sheaves);
+	s->cpu_sheaves = NULL;
+}
+
+static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
+{
+	struct slab_sheaf *empty = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&barn->lock, flags);
+
+	if (barn->nr_empty) {
+		empty = list_first_entry(&barn->sheaves_empty,
+					 struct slab_sheaf, barn_list);
+		list_del(&empty->barn_list);
+		barn->nr_empty--;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return empty;
+}
+
+/*
+ * The following two functions are used mainly in cases where we have to undo an
+ * intended action due to a race or cpu migration. Thus they do not check the
+ * empty or full sheaf limits for simplicity.
+ */
+
+static void barn_put_empty_sheaf(struct node_barn *barn, struct slab_sheaf *sheaf)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&barn->lock, flags);
+
+	list_add(&sheaf->barn_list, &barn->sheaves_empty);
+	barn->nr_empty++;
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+}
+
+static void barn_put_full_sheaf(struct node_barn *barn, struct slab_sheaf *sheaf)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&barn->lock, flags);
+
+	list_add(&sheaf->barn_list, &barn->sheaves_full);
+	barn->nr_full++;
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+}
+
+/*
+ * If a full sheaf is available, return it and put the supplied empty one to
+ * barn. We ignore the limit on empty sheaves as the number of sheaves doesn't
+ * change.
+ */
+static struct slab_sheaf *
+barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty)
+{
+	struct slab_sheaf *full = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&barn->lock, flags);
+
+	if (barn->nr_full) {
+		full = list_first_entry(&barn->sheaves_full, struct slab_sheaf,
+					barn_list);
+		list_del(&full->barn_list);
+		list_add(&empty->barn_list, &barn->sheaves_empty);
+		barn->nr_full--;
+		barn->nr_empty++;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return full;
+}
+
+/*
+ * If an empty sheaf is available, return it and put the supplied full one to
+ * barn. But if there are too many full sheaves, reject this with -E2BIG.
+ */
+static struct slab_sheaf *
+barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
+{
+	struct slab_sheaf *empty;
+	unsigned long flags;
+
+	spin_lock_irqsave(&barn->lock, flags);
+
+	if (barn->nr_full >= MAX_FULL_SHEAVES) {
+		empty = ERR_PTR(-E2BIG);
+	} else if (!barn->nr_empty) {
+		empty = ERR_PTR(-ENOMEM);
+	} else {
+		empty = list_first_entry(&barn->sheaves_empty, struct slab_sheaf,
+					 barn_list);
+		list_del(&empty->barn_list);
+		list_add(&full->barn_list, &barn->sheaves_full);
+		barn->nr_empty--;
+		barn->nr_full++;
+	}
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	return empty;
+}
+
+static void barn_init(struct node_barn *barn)
+{
+	spin_lock_init(&barn->lock);
+	INIT_LIST_HEAD(&barn->sheaves_full);
+	INIT_LIST_HEAD(&barn->sheaves_empty);
+	barn->nr_full = 0;
+	barn->nr_empty = 0;
+}
+
+static void barn_shrink(struct kmem_cache *s, struct node_barn *barn)
+{
+	struct list_head empty_list;
+	struct list_head full_list;
+	struct slab_sheaf *sheaf, *sheaf2;
+	unsigned long flags;
+
+	INIT_LIST_HEAD(&empty_list);
+	INIT_LIST_HEAD(&full_list);
+
+	spin_lock_irqsave(&barn->lock, flags);
+
+	list_splice_init(&barn->sheaves_full, &full_list);
+	barn->nr_full = 0;
+	list_splice_init(&barn->sheaves_empty, &empty_list);
+	barn->nr_empty = 0;
+
+	spin_unlock_irqrestore(&barn->lock, flags);
+
+	list_for_each_entry_safe(sheaf, sheaf2, &full_list, barn_list) {
+		sheaf_flush_unused(s, sheaf);
+		free_empty_sheaf(s, sheaf);
+	}
+
+	list_for_each_entry_safe(sheaf, sheaf2, &empty_list, barn_list)
+		free_empty_sheaf(s, sheaf);
+}
+
 /*
  * Slab allocation and freeing
  */
@@ -3344,11 +3748,40 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 	put_partials_cpu(s, c);
 }
 
-struct slub_flush_work {
-	struct work_struct work;
-	struct kmem_cache *s;
-	bool skip;
-};
+static inline void flush_this_cpu_slab(struct kmem_cache *s)
+{
+	struct kmem_cache_cpu *c = this_cpu_ptr(s->cpu_slab);
+
+	if (c->slab)
+		flush_slab(s, c);
+
+	put_partials(s);
+}
+
+static bool has_cpu_slab(int cpu, struct kmem_cache *s)
+{
+	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
+
+	return c->slab || slub_percpu_partial(c);
+}
+
+#else /* CONFIG_SLUB_TINY */
+static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu) { }
+static inline bool has_cpu_slab(int cpu, struct kmem_cache *s) { return false; }
+static inline void flush_this_cpu_slab(struct kmem_cache *s) { }
+#endif /* CONFIG_SLUB_TINY */
+
+static bool has_pcs_used(int cpu, struct kmem_cache *s)
+{
+	struct slub_percpu_sheaves *pcs;
+
+	if (!s->cpu_sheaves)
+		return false;
+
+	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
+
+	return (pcs->spare || pcs->main->size);
+}
 
 /*
  * Flush cpu slab.
@@ -3358,30 +3791,18 @@ struct slub_flush_work {
 static void flush_cpu_slab(struct work_struct *w)
 {
 	struct kmem_cache *s;
-	struct kmem_cache_cpu *c;
 	struct slub_flush_work *sfw;
 
 	sfw = container_of(w, struct slub_flush_work, work);
 
 	s = sfw->s;
-	c = this_cpu_ptr(s->cpu_slab);
-
-	if (c->slab)
-		flush_slab(s, c);
-
-	put_partials(s);
-}
 
-static bool has_cpu_slab(int cpu, struct kmem_cache *s)
-{
-	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
+	if (s->cpu_sheaves)
+		pcs_flush_all(s);
 
-	return c->slab || slub_percpu_partial(c);
+	flush_this_cpu_slab(s);
 }
 
-static DEFINE_MUTEX(flush_lock);
-static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
-
 static void flush_all_cpus_locked(struct kmem_cache *s)
 {
 	struct slub_flush_work *sfw;
@@ -3392,7 +3813,7 @@ static void flush_all_cpus_locked(struct kmem_cache *s)
 
 	for_each_online_cpu(cpu) {
 		sfw = &per_cpu(slub_flush, cpu);
-		if (!has_cpu_slab(cpu, s)) {
+		if (!has_cpu_slab(cpu, s) && !has_pcs_used(cpu, s)) {
 			sfw->skip = true;
 			continue;
 		}
@@ -3428,19 +3849,15 @@ static int slub_cpu_dead(unsigned int cpu)
 	struct kmem_cache *s;
 
 	mutex_lock(&slab_mutex);
-	list_for_each_entry(s, &slab_caches, list)
+	list_for_each_entry(s, &slab_caches, list) {
 		__flush_cpu_slab(s, cpu);
+		if (s->cpu_sheaves)
+			__pcs_flush_all_cpu(s, cpu);
+	}
 	mutex_unlock(&slab_mutex);
 	return 0;
 }
 
-#else /* CONFIG_SLUB_TINY */
-static inline void flush_all_cpus_locked(struct kmem_cache *s) { }
-static inline void flush_all(struct kmem_cache *s) { }
-static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu) { }
-static inline int slub_cpu_dead(unsigned int cpu) { return 0; }
-#endif /* CONFIG_SLUB_TINY */
-
 /*
  * Check if the objects in a per cpu structure fit numa
  * locality expectations.
@@ -4191,30 +4608,240 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 }
 
 /*
- * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_alloc)
- * have the fastpath folded into their functions. So no function call
- * overhead for requests that can be satisfied on the fastpath.
- *
- * The fastpath works by first checking if the lockless freelist can be used.
- * If not then __slab_alloc is called for slow processing.
+ * Replace the empty main sheaf with a (at least partially) full sheaf.
  *
- * Otherwise we can simply pick the next object from the lockless free list.
+ * Must be called with the cpu_sheaves local lock locked. If successful, returns
+ * the pcs pointer and the local lock locked (possibly on a different cpu than
+ * initially called). If not successful, returns NULL and the local lock
+ * unlocked.
  */
-static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
-		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
+static struct slub_percpu_sheaves *
+__pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs, gfp_t gfp)
 {
-	void *object;
-	bool init = false;
+	struct slab_sheaf *empty = NULL;
+	struct slab_sheaf *full;
+	struct node_barn *barn;
+	bool can_alloc;
 
-	s = slab_pre_alloc_hook(s, gfpflags);
-	if (unlikely(!s))
-		return NULL;
+	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
+
+	if (pcs->spare && pcs->spare->size > 0) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	barn = get_barn(s);
+
+	full = barn_replace_empty_sheaf(barn, pcs->main);
+
+	if (full) {
+		stat(s, BARN_GET);
+		pcs->main = full;
+		return pcs;
+	}
+
+	stat(s, BARN_GET_FAIL);
+
+	can_alloc = gfpflags_allow_blocking(gfp);
+
+	if (can_alloc) {
+		if (pcs->spare) {
+			empty = pcs->spare;
+			pcs->spare = NULL;
+		} else {
+			empty = barn_get_empty_sheaf(barn);
+		}
+	}
+
+	local_unlock(&s->cpu_sheaves->lock);
+
+	if (!can_alloc)
+		return NULL;
+
+	if (empty) {
+		if (!refill_sheaf(s, empty, gfp)) {
+			full = empty;
+		} else {
+			/*
+			 * we must be very low on memory so don't bother
+			 * with the barn
+			 */
+			free_empty_sheaf(s, empty);
+		}
+	} else {
+		full = alloc_full_sheaf(s, gfp);
+	}
+
+	if (!full)
+		return NULL;
+
+	/*
+	 * we can reach here only when gfpflags_allow_blocking
+	 * so this must not be an irq
+	 */
+	local_lock(&s->cpu_sheaves->lock);
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	/*
+	 * If we are returning empty sheaf, we either got it from the
+	 * barn or had to allocate one. If we are returning a full
+	 * sheaf, it's due to racing or being migrated to a different
+	 * cpu. Breaching the barn's sheaf limits should be thus rare
+	 * enough so just ignore them to simplify the recovery.
+	 */
+
+	if (pcs->main->size == 0) {
+		barn_put_empty_sheaf(barn, pcs->main);
+		pcs->main = full;
+		return pcs;
+	}
+
+	if (!pcs->spare) {
+		pcs->spare = full;
+		return pcs;
+	}
+
+	if (pcs->spare->size == 0) {
+		barn_put_empty_sheaf(barn, pcs->spare);
+		pcs->spare = full;
+		return pcs;
+	}
+
+	barn_put_full_sheaf(barn, full);
+	stat(s, BARN_PUT);
+
+	return pcs;
+}
+
+static __fastpath_inline
+void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp)
+{
+	struct slub_percpu_sheaves *pcs;
+	void *object;
+
+#ifdef CONFIG_NUMA
+	if (static_branch_unlikely(&strict_numa)) {
+		if (current->mempolicy)
+			return NULL;
+	}
+#endif
+
+	if (!local_trylock(&s->cpu_sheaves->lock))
+		return NULL;
+
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	if (unlikely(pcs->main->size == 0)) {
+		pcs = __pcs_replace_empty_main(s, pcs, gfp);
+		if (unlikely(!pcs))
+			return NULL;
+	}
+
+	object = pcs->main->objects[--pcs->main->size];
+
+	local_unlock(&s->cpu_sheaves->lock);
+
+	stat(s, ALLOC_PCS);
+
+	return object;
+}
+
+static __fastpath_inline
+unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
+{
+	struct slub_percpu_sheaves *pcs;
+	struct slab_sheaf *main;
+	unsigned int allocated = 0;
+	unsigned int batch;
+
+next_batch:
+	if (!local_trylock(&s->cpu_sheaves->lock))
+		return allocated;
+
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	if (unlikely(pcs->main->size == 0)) {
+
+		struct slab_sheaf *full;
+
+		if (pcs->spare && pcs->spare->size > 0) {
+			swap(pcs->main, pcs->spare);
+			goto do_alloc;
+		}
+
+		full = barn_replace_empty_sheaf(get_barn(s), pcs->main);
+
+		if (full) {
+			stat(s, BARN_GET);
+			pcs->main = full;
+			goto do_alloc;
+		}
+
+		stat(s, BARN_GET_FAIL);
+
+		local_unlock(&s->cpu_sheaves->lock);
+
+		/*
+		 * Once full sheaves in barn are depleted, let the bulk
+		 * allocation continue from slab pages, otherwise we would just
+		 * be copying arrays of pointers twice.
+		 */
+		return allocated;
+	}
+
+do_alloc:
+
+	main = pcs->main;
+	batch = min(size, main->size);
+
+	main->size -= batch;
+	memcpy(p, main->objects + main->size, batch * sizeof(void *));
+
+	local_unlock(&s->cpu_sheaves->lock);
+
+	stat_add(s, ALLOC_PCS, batch);
+
+	allocated += batch;
+
+	if (batch < size) {
+		p += batch;
+		size -= batch;
+		goto next_batch;
+	}
+
+	return allocated;
+}
+
+
+/*
+ * Inlined fastpath so that allocation functions (kmalloc, kmem_cache_alloc)
+ * have the fastpath folded into their functions. So no function call
+ * overhead for requests that can be satisfied on the fastpath.
+ *
+ * The fastpath works by first checking if the lockless freelist can be used.
+ * If not then __slab_alloc is called for slow processing.
+ *
+ * Otherwise we can simply pick the next object from the lockless free list.
+ */
+static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
+		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
+{
+	void *object;
+	bool init = false;
+
+	s = slab_pre_alloc_hook(s, gfpflags);
+	if (unlikely(!s))
+		return NULL;
 
 	object = kfence_alloc(s, orig_size, gfpflags);
 	if (unlikely(object))
 		goto out;
 
-	object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
+	if (s->cpu_sheaves && node == NUMA_NO_NODE)
+		object = alloc_from_pcs(s, gfpflags);
+
+	if (!object)
+		object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
 
 	maybe_wipe_obj_freeptr(s, object);
 	init = slab_want_init_on_alloc(gfpflags, s);
@@ -4591,6 +5218,295 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	discard_slab(s, slab);
 }
 
+/*
+ * pcs is locked. We should have get rid of the spare sheaf and obtained an
+ * empty sheaf, while the main sheaf is full. We want to install the empty sheaf
+ * as a main sheaf, and make the current main sheaf a spare sheaf.
+ *
+ * However due to having relinquished the cpu_sheaves lock when obtaining
+ * the empty sheaf, we need to handle some unlikely but possible cases.
+ *
+ * If we put any sheaf to barn here, it's because we were interrupted or have
+ * been migrated to a different cpu, which should be rare enough so just ignore
+ * the barn's limits to simplify the handling.
+ *
+ * An alternative scenario that gets us here is when we fail
+ * barn_replace_full_sheaf(), because there's no empty sheaf available in the
+ * barn, so we had to allocate it by alloc_empty_sheaf(). But because we saw the
+ * limit on full sheaves was not exceeded, we assume it didn't change and just
+ * put the full sheaf there.
+ */
+static void __pcs_install_empty_sheaf(struct kmem_cache *s,
+		struct slub_percpu_sheaves *pcs, struct slab_sheaf *empty)
+{
+	struct node_barn *barn;
+
+	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
+
+	/* This is what we expect to find if nobody interrupted us. */
+	if (likely(!pcs->spare)) {
+		pcs->spare = pcs->main;
+		pcs->main = empty;
+		return;
+	}
+
+	barn = get_barn(s);
+
+	/*
+	 * Unlikely because if the main sheaf had space, we would have just
+	 * freed to it. Get rid of our empty sheaf.
+	 */
+	if (pcs->main->size < s->sheaf_capacity) {
+		barn_put_empty_sheaf(barn, empty);
+		return;
+	}
+
+	/* Also unlikely for the same reason */
+	if (pcs->spare->size < s->sheaf_capacity) {
+		swap(pcs->main, pcs->spare);
+		barn_put_empty_sheaf(barn, empty);
+		return;
+	}
+
+	/*
+	 * We probably failed barn_replace_full_sheaf() due to no empty sheaf
+	 * available there, but we allocated one, so finish the job.
+	 */
+	barn_put_full_sheaf(barn, pcs->main);
+	stat(s, BARN_PUT);
+	pcs->main = empty;
+}
+
+/*
+ * Replace the full main sheaf with a (at least partially) empty sheaf.
+ *
+ * Must be called with the cpu_sheaves local lock locked. If successful, returns
+ * the pcs pointer and the local lock locked (possibly on a different cpu than
+ * initially called). If not successful, returns NULL and the local lock
+ * unlocked.
+ */
+static struct slub_percpu_sheaves *
+__pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
+{
+	struct slab_sheaf *empty;
+	struct node_barn *barn;
+	bool put_fail;
+
+restart:
+	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
+
+	barn = get_barn(s);
+	put_fail = false;
+
+	if (!pcs->spare) {
+		empty = barn_get_empty_sheaf(barn);
+		if (empty) {
+			pcs->spare = pcs->main;
+			pcs->main = empty;
+			return pcs;
+		}
+		goto alloc_empty;
+	}
+
+	if (pcs->spare->size < s->sheaf_capacity) {
+		swap(pcs->main, pcs->spare);
+		return pcs;
+	}
+
+	empty = barn_replace_full_sheaf(barn, pcs->main);
+
+	if (!IS_ERR(empty)) {
+		stat(s, BARN_PUT);
+		pcs->main = empty;
+		return pcs;
+	}
+
+	if (PTR_ERR(empty) == -E2BIG) {
+		/* Since we got here, spare exists and is full */
+		struct slab_sheaf *to_flush = pcs->spare;
+
+		stat(s, BARN_PUT_FAIL);
+
+		pcs->spare = NULL;
+		local_unlock(&s->cpu_sheaves->lock);
+
+		sheaf_flush_unused(s, to_flush);
+		empty = to_flush;
+		goto got_empty;
+	}
+
+	/*
+	 * We could not replace full sheaf because barn had no empty
+	 * sheaves. We can still allocate it and put the full sheaf in
+	 * __pcs_install_empty_sheaf(), but if we fail to allocate it,
+	 * make sure to count the fail.
+	 */
+	put_fail = true;
+
+alloc_empty:
+	local_unlock(&s->cpu_sheaves->lock);
+
+	empty = alloc_empty_sheaf(s, GFP_NOWAIT);
+	if (empty)
+		goto got_empty;
+
+	if (put_fail)
+		 stat(s, BARN_PUT_FAIL);
+
+	if (!sheaf_flush_main(s))
+		return NULL;
+
+	if (!local_trylock(&s->cpu_sheaves->lock))
+		return NULL;
+
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	/*
+	 * we flushed the main sheaf so it should be empty now,
+	 * but in case we got preempted or migrated, we need to
+	 * check again
+	 */
+	if (pcs->main->size == s->sheaf_capacity)
+		goto restart;
+
+	return pcs;
+
+got_empty:
+	if (!local_trylock(&s->cpu_sheaves->lock)) {
+		barn_put_empty_sheaf(barn, empty);
+		return NULL;
+	}
+
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+	__pcs_install_empty_sheaf(s, pcs, empty);
+
+	return pcs;
+}
+
+/*
+ * Free an object to the percpu sheaves.
+ * The object is expected to have passed slab_free_hook() already.
+ */
+static __fastpath_inline
+bool free_to_pcs(struct kmem_cache *s, void *object)
+{
+	struct slub_percpu_sheaves *pcs;
+
+	if (!local_trylock(&s->cpu_sheaves->lock))
+		return false;
+
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
+
+		pcs = __pcs_replace_full_main(s, pcs);
+		if (unlikely(!pcs))
+			return false;
+	}
+
+	pcs->main->objects[pcs->main->size++] = object;
+
+	local_unlock(&s->cpu_sheaves->lock);
+
+	stat(s, FREE_PCS);
+
+	return true;
+}
+
+/*
+ * Bulk free objects to the percpu sheaves.
+ * Unlike free_to_pcs() this includes the calls to all necessary hooks
+ * and the fallback to freeing to slab pages.
+ */
+static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
+{
+	struct slub_percpu_sheaves *pcs;
+	struct slab_sheaf *main, *empty;
+	bool init = slab_want_init_on_free(s);
+	unsigned int batch, i = 0;
+	struct node_barn *barn;
+
+	while (i < size) {
+		struct slab *slab = virt_to_slab(p[i]);
+
+		memcg_slab_free_hook(s, slab, p + i, 1);
+		alloc_tagging_slab_free_hook(s, slab, p + i, 1);
+
+		if (unlikely(!slab_free_hook(s, p[i], init, false))) {
+			p[i] = p[--size];
+			if (!size)
+				return;
+			continue;
+		}
+
+		i++;
+	}
+
+next_batch:
+	if (!local_trylock(&s->cpu_sheaves->lock))
+		goto fallback;
+
+	pcs = this_cpu_ptr(s->cpu_sheaves);
+
+	if (likely(pcs->main->size < s->sheaf_capacity))
+		goto do_free;
+
+	barn = get_barn(s);
+
+	if (!pcs->spare) {
+		empty = barn_get_empty_sheaf(barn);
+		if (!empty)
+			goto no_empty;
+
+		pcs->spare = pcs->main;
+		pcs->main = empty;
+		goto do_free;
+	}
+
+	if (pcs->spare->size < s->sheaf_capacity) {
+		swap(pcs->main, pcs->spare);
+		goto do_free;
+	}
+
+	empty = barn_replace_full_sheaf(barn, pcs->main);
+	if (IS_ERR(empty)) {
+		stat(s, BARN_PUT_FAIL);
+		goto no_empty;
+	}
+
+	stat(s, BARN_PUT);
+	pcs->main = empty;
+
+do_free:
+	main = pcs->main;
+	batch = min(size, s->sheaf_capacity - main->size);
+
+	memcpy(main->objects + main->size, p, batch * sizeof(void *));
+	main->size += batch;
+
+	local_unlock(&s->cpu_sheaves->lock);
+
+	stat_add(s, FREE_PCS, batch);
+
+	if (batch < size) {
+		p += batch;
+		size -= batch;
+		goto next_batch;
+	}
+
+	return;
+
+no_empty:
+	local_unlock(&s->cpu_sheaves->lock);
+
+	/*
+	 * if we depleted all empty sheaves in the barn or there are too
+	 * many full sheaves, free the rest to slab pages
+	 */
+fallback:
+	__kmem_cache_free_bulk(s, size, p);
+}
+
 #ifndef CONFIG_SLUB_TINY
 /*
  * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
@@ -4677,7 +5593,10 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 	memcg_slab_free_hook(s, slab, &object, 1);
 	alloc_tagging_slab_free_hook(s, slab, &object, 1);
 
-	if (likely(slab_free_hook(s, object, slab_want_init_on_free(s), false)))
+	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
+		return;
+
+	if (!s->cpu_sheaves || !free_to_pcs(s, object))
 		do_slab_free(s, slab, object, object, 1, addr);
 }
 
@@ -5273,6 +6192,15 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 	if (!size)
 		return;
 
+	/*
+	 * freeing to sheaves is so incompatible with the detached freelist so
+	 * once we go that way, we have to do everything differently
+	 */
+	if (s && s->cpu_sheaves) {
+		free_to_pcs_bulk(s, size, p);
+		return;
+	}
+
 	do {
 		struct detached_freelist df;
 
@@ -5391,7 +6319,7 @@ static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
 int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
 				 void **p)
 {
-	int i;
+	unsigned int i = 0;
 
 	if (!size)
 		return 0;
@@ -5400,9 +6328,20 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
 	if (unlikely(!s))
 		return 0;
 
-	i = __kmem_cache_alloc_bulk(s, flags, size, p);
-	if (unlikely(i == 0))
-		return 0;
+	if (s->cpu_sheaves)
+		i = alloc_from_pcs_bulk(s, size, p);
+
+	if (i < size) {
+		/*
+		 * If we ran out of memory, don't bother with freeing back to
+		 * the percpu sheaves, we have bigger problems.
+		 */
+		if (unlikely(__kmem_cache_alloc_bulk(s, flags, size - i, p + i) == 0)) {
+			if (i > 0)
+				__kmem_cache_free_bulk(s, i, p);
+			return 0;
+		}
+	}
 
 	/*
 	 * memcg and kmem_cache debug support and memory initialization.
@@ -5412,11 +6351,11 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
 		    slab_want_init_on_alloc(flags, s), s->object_size))) {
 		return 0;
 	}
-	return i;
+
+	return size;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_bulk_noprof);
 
-
 /*
  * Object placement in a slab is made very easy because we always start at
  * offset 0. If we tune the size of the object to the alignment then we can
@@ -5550,7 +6489,7 @@ static inline int calculate_order(unsigned int size)
 }
 
 static void
-init_kmem_cache_node(struct kmem_cache_node *n)
+init_kmem_cache_node(struct kmem_cache_node *n, struct node_barn *barn)
 {
 	n->nr_partial = 0;
 	spin_lock_init(&n->list_lock);
@@ -5560,6 +6499,9 @@ init_kmem_cache_node(struct kmem_cache_node *n)
 	atomic_long_set(&n->total_objects, 0);
 	INIT_LIST_HEAD(&n->full);
 #endif
+	n->barn = barn;
+	if (barn)
+		barn_init(barn);
 }
 
 #ifndef CONFIG_SLUB_TINY
@@ -5590,6 +6532,26 @@ static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
 }
 #endif /* CONFIG_SLUB_TINY */
 
+static int init_percpu_sheaves(struct kmem_cache *s)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct slub_percpu_sheaves *pcs;
+
+		pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
+
+		local_trylock_init(&pcs->lock);
+
+		pcs->main = alloc_empty_sheaf(s, GFP_KERNEL);
+
+		if (!pcs->main)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static struct kmem_cache *kmem_cache_node;
 
 /*
@@ -5625,7 +6587,7 @@ static void early_kmem_cache_node_alloc(int node)
 	slab->freelist = get_freepointer(kmem_cache_node, n);
 	slab->inuse = 1;
 	kmem_cache_node->node[node] = n;
-	init_kmem_cache_node(n);
+	init_kmem_cache_node(n, NULL);
 	inc_slabs_node(kmem_cache_node, node, slab->objects);
 
 	/*
@@ -5641,6 +6603,13 @@ static void free_kmem_cache_nodes(struct kmem_cache *s)
 	struct kmem_cache_node *n;
 
 	for_each_kmem_cache_node(s, node, n) {
+		if (n->barn) {
+			WARN_ON(n->barn->nr_full);
+			WARN_ON(n->barn->nr_empty);
+			kfree(n->barn);
+			n->barn = NULL;
+		}
+
 		s->node[node] = NULL;
 		kmem_cache_free(kmem_cache_node, n);
 	}
@@ -5649,6 +6618,8 @@ static void free_kmem_cache_nodes(struct kmem_cache *s)
 void __kmem_cache_release(struct kmem_cache *s)
 {
 	cache_random_seq_destroy(s);
+	if (s->cpu_sheaves)
+		pcs_destroy(s);
 #ifndef CONFIG_SLUB_TINY
 	free_percpu(s->cpu_slab);
 #endif
@@ -5661,18 +6632,29 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
 
 	for_each_node_mask(node, slab_nodes) {
 		struct kmem_cache_node *n;
+		struct node_barn *barn = NULL;
 
 		if (slab_state == DOWN) {
 			early_kmem_cache_node_alloc(node);
 			continue;
 		}
+
+		if (s->cpu_sheaves) {
+			barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, node);
+
+			if (!barn)
+				return 0;
+		}
+
 		n = kmem_cache_alloc_node(kmem_cache_node,
 						GFP_KERNEL, node);
-
-		if (!n)
+		if (!n) {
+			kfree(barn);
 			return 0;
+		}
+
+		init_kmem_cache_node(n, barn);
 
-		init_kmem_cache_node(n);
 		s->node[node] = n;
 	}
 	return 1;
@@ -5929,6 +6911,8 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	flush_all_cpus_locked(s);
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
+		if (n->barn)
+			barn_shrink(s, n->barn);
 		free_partial(s, n);
 		if (n->nr_partial || node_nr_slabs(n))
 			return 1;
@@ -6132,6 +7116,9 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
 		for (i = 0; i < SHRINK_PROMOTE_MAX; i++)
 			INIT_LIST_HEAD(promote + i);
 
+		if (n->barn)
+			barn_shrink(s, n->barn);
+
 		spin_lock_irqsave(&n->list_lock, flags);
 
 		/*
@@ -6211,12 +7198,24 @@ static int slab_mem_going_online_callback(int nid)
 	 */
 	mutex_lock(&slab_mutex);
 	list_for_each_entry(s, &slab_caches, list) {
+		struct node_barn *barn = NULL;
+
 		/*
 		 * The structure may already exist if the node was previously
 		 * onlined and offlined.
 		 */
 		if (get_node(s, nid))
 			continue;
+
+		if (s->cpu_sheaves) {
+			barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, nid);
+
+			if (!barn) {
+				ret = -ENOMEM;
+				goto out;
+			}
+		}
+
 		/*
 		 * XXX: kmem_cache_alloc_node will fallback to other nodes
 		 *      since memory is not yet available from the node that
@@ -6224,10 +7223,13 @@ static int slab_mem_going_online_callback(int nid)
 		 */
 		n = kmem_cache_alloc(kmem_cache_node, GFP_KERNEL);
 		if (!n) {
+			kfree(barn);
 			ret = -ENOMEM;
 			goto out;
 		}
-		init_kmem_cache_node(n);
+
+		init_kmem_cache_node(n, barn);
+
 		s->node[nid] = n;
 	}
 	/*
@@ -6440,6 +7442,17 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 
 	set_cpu_partial(s);
 
+	if (args->sheaf_capacity && !IS_ENABLED(CONFIG_SLUB_TINY)
+					&& !(s->flags & SLAB_DEBUG_FLAGS)) {
+		s->cpu_sheaves = alloc_percpu(struct slub_percpu_sheaves);
+		if (!s->cpu_sheaves) {
+			err = -ENOMEM;
+			goto out;
+		}
+		// TODO: increase capacity to grow slab_sheaf up to next kmalloc size?
+		s->sheaf_capacity = args->sheaf_capacity;
+	}
+
 #ifdef CONFIG_NUMA
 	s->remote_node_defrag_ratio = 1000;
 #endif
@@ -6456,6 +7469,12 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 	if (!alloc_kmem_cache_cpus(s))
 		goto out;
 
+	if (s->cpu_sheaves) {
+		err = init_percpu_sheaves(s);
+		if (err)
+			goto out;
+	}
+
 	err = 0;
 
 	/* Mutex is not taken during early boot */
@@ -6908,6 +7927,12 @@ static ssize_t order_show(struct kmem_cache *s, char *buf)
 }
 SLAB_ATTR_RO(order);
 
+static ssize_t sheaf_capacity_show(struct kmem_cache *s, char *buf)
+{
+	return sysfs_emit(buf, "%u\n", s->sheaf_capacity);
+}
+SLAB_ATTR_RO(sheaf_capacity);
+
 static ssize_t min_partial_show(struct kmem_cache *s, char *buf)
 {
 	return sysfs_emit(buf, "%lu\n", s->min_partial);
@@ -7255,8 +8280,10 @@ static ssize_t text##_store(struct kmem_cache *s,		\
 }								\
 SLAB_ATTR(text);						\
 
+STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
 STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
 STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
+STAT_ATTR(FREE_PCS, free_cpu_sheaf);
 STAT_ATTR(FREE_FASTPATH, free_fastpath);
 STAT_ATTR(FREE_SLOWPATH, free_slowpath);
 STAT_ATTR(FREE_FROZEN, free_frozen);
@@ -7281,6 +8308,14 @@ STAT_ATTR(CPU_PARTIAL_ALLOC, cpu_partial_alloc);
 STAT_ATTR(CPU_PARTIAL_FREE, cpu_partial_free);
 STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
 STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
+STAT_ATTR(SHEAF_FLUSH, sheaf_flush);
+STAT_ATTR(SHEAF_REFILL, sheaf_refill);
+STAT_ATTR(SHEAF_ALLOC, sheaf_alloc);
+STAT_ATTR(SHEAF_FREE, sheaf_free);
+STAT_ATTR(BARN_GET, barn_get);
+STAT_ATTR(BARN_GET_FAIL, barn_get_fail);
+STAT_ATTR(BARN_PUT, barn_put);
+STAT_ATTR(BARN_PUT_FAIL, barn_put_fail);
 #endif	/* CONFIG_SLUB_STATS */
 
 #ifdef CONFIG_KFENCE
@@ -7311,6 +8346,7 @@ static struct attribute *slab_attrs[] = {
 	&object_size_attr.attr,
 	&objs_per_slab_attr.attr,
 	&order_attr.attr,
+	&sheaf_capacity_attr.attr,
 	&min_partial_attr.attr,
 	&cpu_partial_attr.attr,
 	&objects_partial_attr.attr,
@@ -7342,8 +8378,10 @@ static struct attribute *slab_attrs[] = {
 	&remote_node_defrag_ratio_attr.attr,
 #endif
 #ifdef CONFIG_SLUB_STATS
+	&alloc_cpu_sheaf_attr.attr,
 	&alloc_fastpath_attr.attr,
 	&alloc_slowpath_attr.attr,
+	&free_cpu_sheaf_attr.attr,
 	&free_fastpath_attr.attr,
 	&free_slowpath_attr.attr,
 	&free_frozen_attr.attr,
@@ -7368,6 +8406,14 @@ static struct attribute *slab_attrs[] = {
 	&cpu_partial_free_attr.attr,
 	&cpu_partial_node_attr.attr,
 	&cpu_partial_drain_attr.attr,
+	&sheaf_flush_attr.attr,
+	&sheaf_refill_attr.attr,
+	&sheaf_alloc_attr.attr,
+	&sheaf_free_attr.attr,
+	&barn_get_attr.attr,
+	&barn_get_fail_attr.attr,
+	&barn_put_attr.attr,
+	&barn_put_fail_attr.attr,
 #endif
 #ifdef CONFIG_FAILSLAB
 	&failslab_attr.attr,

-- 
2.51.0


