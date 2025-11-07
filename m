Return-Path: <linux-kernel+bounces-890500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF20C40328
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C597C421CEE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1DA31B10E;
	Fri,  7 Nov 2025 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DZNvXY9Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XJP9ZOW+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DZNvXY9Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XJP9ZOW+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E6E3168FD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523532; cv=none; b=J4jRD17OOongI35z6wtJstm95w7/0/5YTnTIX+ThoVlFFdTFHtJRjgstGVXu+d8uHFGhcvzFXIjFstZkL3YojBNeaNBg4btghY989RTMegFFj/rG03KMSOnjNBIuvbC4kyu9lHJTiKikJOWjma8065ejfsmHJtVwu+b9DzczWk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523532; c=relaxed/simple;
	bh=VlcyFpyyN8/dJ59tQZJAyvizdyQCo7jTGGmdC2FCilQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eh8itZNpDE7G9f1YIISrkkJDFSXA9TEgx3YTJs38K7Pw737h1Y0PAgQbAvRMjxu/PNSv8tk8GukWRSZ7TkM4fWE63pdW50UBXIvN7ehO+TwEXRva3JbY38bCnYmtJcDZPq8yX86R237qa8PQIb2IOyYoZPJYfn7oxiXuEHJyQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DZNvXY9Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XJP9ZOW+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DZNvXY9Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XJP9ZOW+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF08A1F461;
	Fri,  7 Nov 2025 13:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762523506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lbjp9eBdivzL6P8LhBfaJka806WwCcsNNUIAdQf/UyI=;
	b=DZNvXY9Y5Cevgwr5I91ouI7W/s/MxZbXP47IXlE4UjiYOYdRSlRE1YWxmZagun2nQqh7IR
	Szu4FwLkhjMCz+IjYVZPQskmg7DTl9BN01feerW2us4n6UlLWRnQKnxgIaDhs91AZHGQcj
	xqWgOCjPJfqVc2VGPrQQ+qd+kFS8eQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762523506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lbjp9eBdivzL6P8LhBfaJka806WwCcsNNUIAdQf/UyI=;
	b=XJP9ZOW+umo9kwWSM++dRKu32L8N+xdF/kBMG28busVSzwXF+bFkYhd5BPtNlqnjqDG8w4
	Cr/QFzMCa3zh6GBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762523506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lbjp9eBdivzL6P8LhBfaJka806WwCcsNNUIAdQf/UyI=;
	b=DZNvXY9Y5Cevgwr5I91ouI7W/s/MxZbXP47IXlE4UjiYOYdRSlRE1YWxmZagun2nQqh7IR
	Szu4FwLkhjMCz+IjYVZPQskmg7DTl9BN01feerW2us4n6UlLWRnQKnxgIaDhs91AZHGQcj
	xqWgOCjPJfqVc2VGPrQQ+qd+kFS8eQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762523506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lbjp9eBdivzL6P8LhBfaJka806WwCcsNNUIAdQf/UyI=;
	b=XJP9ZOW+umo9kwWSM++dRKu32L8N+xdF/kBMG28busVSzwXF+bFkYhd5BPtNlqnjqDG8w4
	Cr/QFzMCa3zh6GBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABD0913C01;
	Fri,  7 Nov 2025 13:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2G+nKXL5DWlFCwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 07 Nov 2025 13:51:46 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 07 Nov 2025 14:51:26 +0100
Subject: [PATCH 4/4] slab: use struct freelist_counters as parameters in
 relevant functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-slab-fms-cleanup-v1-4-650b1491ac9e@suse.cz>
References: <20251107-slab-fms-cleanup-v1-0-650b1491ac9e@suse.cz>
In-Reply-To: <20251107-slab-fms-cleanup-v1-0-650b1491ac9e@suse.cz>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Spam-Level: 
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -8.30

In functions such as [__]slab_update_freelist() and
__slab_update_freelist_fast/slow() we pass old and new freelist and
counters as 4 separate parameters. The underlying
__update_freelist_fast() then constructs struct freelist_counters
variables for passing the full freelist+counter combinations to cmpxchg
double.

In most cases we actually start with struct freelist_counters variables,
but then pass the individual fields, only to construct new struct
freelist_counters variables. While it's all inlined and thus should be
efficient, we can simplify this code.

Thus replace the 4 parameters for individual fields with two
freelist_aba_t pointers wherever applicable. __update_freelist_fast()
can then pass them directly to try_cmpxchg_freelist().

The code is also more obvious as the pattern becomes unified such that
we set up "old" and "new" struct freelist_counters variables upfront as
we fully need them to be, and simply call [__]slab_update_freelist() on
them.  Previously some of the "new" values would be hidden as one of the
many parameters and thus make it harder to figure out what the code
does.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 126 ++++++++++++++++++++++++++------------------------------------
 1 file changed, 52 insertions(+), 74 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a55e0af26ec7..ddd71f4937fa 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -759,34 +759,29 @@ static __always_inline void slab_unlock(struct slab *slab)
 }
 
 static inline bool
-__update_freelist_fast(struct slab *slab,
-		      void *freelist_old, unsigned long counters_old,
-		      void *freelist_new, unsigned long counters_new)
+__update_freelist_fast(struct slab *slab, struct freelist_counters *old,
+		       struct freelist_counters *new)
 {
 #ifdef system_has_freelist_aba
-	struct freelist_counters old = { .freelist = freelist_old, .counters = counters_old };
-	struct freelist_counters new = { .freelist = freelist_new, .counters = counters_new };
-
 	return try_cmpxchg_freelist(&slab->freelist_counters,
-				    &old.freelist_counters,
-				    new.freelist_counters);
+				    &old->freelist_counters,
+				    new->freelist_counters);
 #else
 	return false;
 #endif
 }
 
 static inline bool
-__update_freelist_slow(struct slab *slab,
-		      void *freelist_old, unsigned long counters_old,
-		      void *freelist_new, unsigned long counters_new)
+__update_freelist_slow(struct slab *slab, struct freelist_counters *old,
+		       struct freelist_counters *new)
 {
 	bool ret = false;
 
 	slab_lock(slab);
-	if (slab->freelist == freelist_old &&
-	    slab->counters == counters_old) {
-		slab->freelist = freelist_new;
-		slab->counters = counters_new;
+	if (slab->freelist == old->freelist &&
+	    slab->counters == old->counters) {
+		slab->freelist = new->freelist;
+		slab->counters = new->counters;
 		ret = true;
 	}
 	slab_unlock(slab);
@@ -802,22 +797,18 @@ __update_freelist_slow(struct slab *slab,
  * interrupt the operation.
  */
 static inline bool __slab_update_freelist(struct kmem_cache *s, struct slab *slab,
-		void *freelist_old, unsigned long counters_old,
-		void *freelist_new, unsigned long counters_new,
-		const char *n)
+		struct freelist_counters *old, struct freelist_counters *new, const char *n)
 {
 	bool ret;
 
 	if (USE_LOCKLESS_FAST_PATH())
 		lockdep_assert_irqs_disabled();
 
-	if (s->flags & __CMPXCHG_DOUBLE) {
-		ret = __update_freelist_fast(slab, freelist_old, counters_old,
-				            freelist_new, counters_new);
-	} else {
-		ret = __update_freelist_slow(slab, freelist_old, counters_old,
-				            freelist_new, counters_new);
-	}
+	if (s->flags & __CMPXCHG_DOUBLE)
+		ret = __update_freelist_fast(slab, old, new);
+	else
+		ret = __update_freelist_slow(slab, old, new);
+
 	if (likely(ret))
 		return true;
 
@@ -832,21 +823,17 @@ static inline bool __slab_update_freelist(struct kmem_cache *s, struct slab *sla
 }
 
 static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
-		void *freelist_old, unsigned long counters_old,
-		void *freelist_new, unsigned long counters_new,
-		const char *n)
+		struct freelist_counters *old, struct freelist_counters *new, const char *n)
 {
 	bool ret;
 
 	if (s->flags & __CMPXCHG_DOUBLE) {
-		ret = __update_freelist_fast(slab, freelist_old, counters_old,
-				            freelist_new, counters_new);
+		ret = __update_freelist_fast(slab, old, new);
 	} else {
 		unsigned long flags;
 
 		local_irq_save(flags);
-		ret = __update_freelist_slow(slab, freelist_old, counters_old,
-				            freelist_new, counters_new);
+		ret = __update_freelist_slow(slab, old, new);
 		local_irq_restore(flags);
 	}
 	if (likely(ret))
@@ -3774,10 +3761,7 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 		} else {
 			new.freelist = old.freelist;
 		}
-	} while (!slab_update_freelist(s, slab,
-		old.freelist, old.counters,
-		new.freelist, new.counters,
-		"unfreezing slab"));
+	} while (!slab_update_freelist(s, slab, &old, &new, "unfreezing slab"));
 
 	/*
 	 * Stage three: Manipulate the slab list based on the updated state.
@@ -4389,27 +4373,24 @@ __update_cpu_freelist_fast(struct kmem_cache *s,
  */
 static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
 {
-	struct freelist_counters new;
-	unsigned long counters;
-	void *freelist;
+	struct freelist_counters old, new;
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
 
 	do {
-		freelist = slab->freelist;
-		counters = slab->counters;
+		old.freelist = slab->freelist;
+		old.counters = slab->counters;
 
-		new.counters = counters;
+		new.freelist = NULL;
+		new.counters = old.counters;
 
-		new.inuse = slab->objects;
-		new.frozen = freelist != NULL;
+		new.inuse = old.objects;
+		new.frozen = old.freelist != NULL;
 
-	} while (!__slab_update_freelist(s, slab,
-		freelist, counters,
-		NULL, new.counters,
-		"get_freelist"));
 
-	return freelist;
+	} while (!__slab_update_freelist(s, slab, &old, &new, "get_freelist"));
+
+	return old.freelist;
 }
 
 /*
@@ -4417,26 +4398,22 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
  */
 static inline void *freeze_slab(struct kmem_cache *s, struct slab *slab)
 {
-	struct freelist_counters new;
-	unsigned long counters;
-	void *freelist;
+	struct freelist_counters old, new;
 
 	do {
-		freelist = slab->freelist;
-		counters = slab->counters;
+		old.freelist = slab->freelist;
+		old.counters = slab->counters;
 
-		new.counters = counters;
+		new.freelist = NULL;
+		new.counters = old.counters;
 		VM_BUG_ON(new.frozen);
 
-		new.inuse = slab->objects;
+		new.inuse = old.objects;
 		new.frozen = 1;
 
-	} while (!slab_update_freelist(s, slab,
-		freelist, counters,
-		NULL, new.counters,
-		"freeze_slab"));
+	} while (!slab_update_freelist(s, slab, &old, &new, "freeze_slab"));
 
-	return freelist;
+	return old.freelist;
 }
 
 /*
@@ -5864,10 +5841,8 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 			unsigned long addr)
 
 {
-	void *old_head;
 	bool was_frozen, was_full;
-	struct freelist_counters new;
-	unsigned long counters;
+	struct freelist_counters old, new;
 	struct kmem_cache_node *n = NULL;
 	unsigned long flags;
 	bool on_node_partial;
@@ -5891,13 +5866,19 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 			spin_unlock_irqrestore(&n->list_lock, flags);
 			n = NULL;
 		}
-		old_head = slab->freelist;
-		counters = slab->counters;
-		set_freepointer(s, tail, old_head);
-		new.counters = counters;
-		was_frozen = !!new.frozen;
-		was_full = (old_head == NULL);
+
+		old.freelist = slab->freelist;
+		old.counters = slab->counters;
+
+		was_full = (old.freelist == NULL);
+		was_frozen = old.frozen;
+
+		set_freepointer(s, tail, old.freelist);
+
+		new.freelist = head;
+		new.counters = old.counters;
 		new.inuse -= cnt;
+
 		/*
 		 * Might need to be taken off (due to becoming empty) or added
 		 * to (due to not being full anymore) the partial list.
@@ -5926,10 +5907,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 			}
 		}
 
-	} while (!slab_update_freelist(s, slab,
-		old_head, counters,
-		head, new.counters,
-		"__slab_free"));
+	} while (!slab_update_freelist(s, slab, &old, &new, "__slab_free"));
 
 	if (likely(!n)) {
 

-- 
2.51.1


