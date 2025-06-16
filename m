Return-Path: <linux-kernel+bounces-688446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8324ADB293
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 15:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EA53A66C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD32C2877E1;
	Mon, 16 Jun 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="x/99woWr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eAQ5bvop";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hvdBehz6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K021Rof3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735242BF018
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081945; cv=none; b=W7MZL8YsM0FAr0TrJN/Bkvpl3Lz/tZCqDOUs2fyZ11guWXT/r6mVbyd1XfAr9upKmrEjpPFM2jJsULQXpPIIG31i7uUOpxRqXYow7In/6i6xsYwDk0apzz68hdUNUToxOBKP7l8KGq7wRl7p/Tj9nl13tTeOGDl/ufS00yNJavs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081945; c=relaxed/simple;
	bh=6R9Ss4KQG7e6j2i/RejfHECkSDU5rzGoQQKl19n6nBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uL3j6a/f8liQqf64OCTsC0SR1T1pzRA1HOMf87d7cBrv9wRJK4clTqZTMQlsDDcTLBPbQIF6zQoctQhvgAHs9asJPtHk9pzO9LMVPx28sDDyRjhXIOypZWtlLMqXv0DFpqdqJrxZFAjEo7HCdxu9WlMKjCFiRO9cKYLDvvw2bPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=x/99woWr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eAQ5bvop; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hvdBehz6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K021Rof3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 921BE211B3;
	Mon, 16 Jun 2025 13:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750081936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPo5dP2xx4yCEpwtQyV+S69pInSlZfneHcEHHsBK/5o=;
	b=x/99woWrllKp2E0FlvZah0Bz/Y8ZQVPX6bEi8NLk/wyZoH7TFTY8wdTXQPyueE3f2NuHp7
	r0AsHScIjkYnf9gy3kwbzMPTyQTkdhJUURUgvaA/54SXWic5A9ITiJoy6XxXHi9f6s12hk
	ftTnHFUt2fpG5RFL37ajG8+ElndJmSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750081936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPo5dP2xx4yCEpwtQyV+S69pInSlZfneHcEHHsBK/5o=;
	b=eAQ5bvopSHs8j5mFMFJYjPsq4xvHpwr5LXLy7OUA3uu2kDbMcDPjz/ax+73TPN9YSbLmUz
	LdA9Ot+xcjJD55Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750081931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPo5dP2xx4yCEpwtQyV+S69pInSlZfneHcEHHsBK/5o=;
	b=hvdBehz68NOIPgj6zXx7S3On2ls13+7vkdrV0KWmN9e974nEFuF025M7muV5JYwZdu9+se
	u6R2wV2uXR4vPDiemMVET5fek/QMH9Py3nE+mL6kjFgJ5xNbT1oBmus+d5KgW2T2welJ8u
	0ZRRVl5LzcdUtDUBSiwsPEktYUZ94VQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750081931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oPo5dP2xx4yCEpwtQyV+S69pInSlZfneHcEHHsBK/5o=;
	b=K021Rof3kE2oHNm9fiQXHjnjE1x9Z3qLKTW5j66tR0dFQYOp1jE5AFRCoNz1T7VgeBurnV
	0jciM26L7Qy+U3Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 074F213A6D;
	Mon, 16 Jun 2025 13:52:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KJLEOoohUGhHLwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 16 Jun 2025 13:52:10 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v7 01/11] mm,slub: Do not special case N_NORMAL nodes for slab_nodes
Date: Mon, 16 Jun 2025 15:51:44 +0200
Message-ID: <20250616135158.450136-2-osalvador@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616135158.450136-1-osalvador@suse.de>
References: <20250616135158.450136-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[oracle.com:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,suse.cz,huawei.com,oracle.com,sk.com,gmail.com,kvack.org,vger.kernel.org,suse.de];
	RSPAMD_EMAILBL_FAIL(0.00)[david.redhat.com:query timed out,harry.yoo.oracle.com:query timed out,vbabka.suse.cz:query timed out,osalvador.suse.de:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:mid,suse.de:email,oracle.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 

Currently, slab_mem_going_online_callback() checks whether the node has
N_NORMAL memory in order to be set in slab_nodes.
While it is true that getting rid of that enforcing would mean
ending up with movables nodes in slab_nodes, the memory waste that comes
with that is negligible.

So stop checking for status_change_nid_normal and just use status_change_nid
instead which works for both types of memory.

Also, once we allocate the kmem_cache_node cache  for the node in
slab_mem_online_callback(), we never deallocate it in
slab_mem_offline_callback() when the node goes memoryless, so we can just
get rid of it.

The side effects are that we will stop clearing the node from slab_nodes,
and also that newly created kmem caches after node hotremove will now allocate
their kmem_cache_node for the node(s) that was hotremoved, but these
should be negligible.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/slub.c | 34 +++-------------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index be8b09e09d30..f92b43d36adc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -447,7 +447,7 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
 
 /*
  * Tracks for which NUMA nodes we have kmem_cache_nodes allocated.
- * Corresponds to node_state[N_NORMAL_MEMORY], but can temporarily
+ * Corresponds to node_state[N_MEMORY], but can temporarily
  * differ during memory hotplug/hotremove operations.
  * Protected by slab_mutex.
  */
@@ -6160,36 +6160,12 @@ static int slab_mem_going_offline_callback(void *arg)
 	return 0;
 }
 
-static void slab_mem_offline_callback(void *arg)
-{
-	struct memory_notify *marg = arg;
-	int offline_node;
-
-	offline_node = marg->status_change_nid_normal;
-
-	/*
-	 * If the node still has available memory. we need kmem_cache_node
-	 * for it yet.
-	 */
-	if (offline_node < 0)
-		return;
-
-	mutex_lock(&slab_mutex);
-	node_clear(offline_node, slab_nodes);
-	/*
-	 * We no longer free kmem_cache_node structures here, as it would be
-	 * racy with all get_node() users, and infeasible to protect them with
-	 * slab_mutex.
-	 */
-	mutex_unlock(&slab_mutex);
-}
-
 static int slab_mem_going_online_callback(void *arg)
 {
 	struct kmem_cache_node *n;
 	struct kmem_cache *s;
 	struct memory_notify *marg = arg;
-	int nid = marg->status_change_nid_normal;
+	int nid = marg->status_change_nid;
 	int ret = 0;
 
 	/*
@@ -6247,10 +6223,6 @@ static int slab_memory_callback(struct notifier_block *self,
 	case MEM_GOING_OFFLINE:
 		ret = slab_mem_going_offline_callback(arg);
 		break;
-	case MEM_OFFLINE:
-	case MEM_CANCEL_ONLINE:
-		slab_mem_offline_callback(arg);
-		break;
 	case MEM_ONLINE:
 	case MEM_CANCEL_OFFLINE:
 		break;
@@ -6321,7 +6293,7 @@ void __init kmem_cache_init(void)
 	 * Initialize the nodemask for which we will allocate per node
 	 * structures. Here we don't need taking slab_mutex yet.
 	 */
-	for_each_node_state(node, N_NORMAL_MEMORY)
+	for_each_node_state(node, N_MEMORY)
 		node_set(node, slab_nodes);
 
 	create_boot_cache(kmem_cache_node, "kmem_cache_node",
-- 
2.49.0


