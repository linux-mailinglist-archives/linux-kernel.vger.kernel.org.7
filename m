Return-Path: <linux-kernel+bounces-765240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73C8B22D33
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 821947A8D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC822D6617;
	Tue, 12 Aug 2025 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q14A6BCi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9yK/YkiX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q14A6BCi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9yK/YkiX"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5D22F6570
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015697; cv=none; b=NqF/gYt+ugbnse2QJlBh3qtAggMFAS0eWQ3nkomI74vn7Npzb7QMXmbEji62fwSAFvSLzC3uzxaiXUEs8G1kOvJcfMhwpBr2tezxA1Expwk8an7buOZXuF0JTUGKqJJESOjANgML/lxs8ngyOZnYO2xy9+MnHTMEZF3kNckKCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015697; c=relaxed/simple;
	bh=KKKiWbCfHBlPOlaqKjZXSPANsewCKKyGVgYwf1jRbx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyFFExyjFHIKphQvF98EzPn4nRi4GBL4a8OJlA7X/6NU5RCH9sKfFmHT2rKd6/ZPE39nHP8x9i2xCv/oK7dSHhwCkppnukzRpJ2AAoIOJk7g9cVQtxJ2Wm3a3kl6TvAHzm+BQ30cGbmgBBWKBV4CSqeTfBTkUg40KM3B6SDc2Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q14A6BCi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9yK/YkiX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q14A6BCi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9yK/YkiX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1EA8521B15;
	Tue, 12 Aug 2025 16:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755015693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ned1pgNlWGdntOMM16NdhHs5e042zHyl9sNCiue17Po=;
	b=q14A6BCiNLhsD4V0qTIk8cM2gzbsVRQGDBTz3KA9uRqFHhdVUetyyzqpNAtTncccSK0NrA
	pjH3QE4HDTinQdwkO8D11p4jIwpFZn6YHCAnHGHENEESVftcgX0KXahbqi+O+yWC5l1kMs
	Xf655AfZkdk2dIst/agawZWN/GDVRZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755015693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ned1pgNlWGdntOMM16NdhHs5e042zHyl9sNCiue17Po=;
	b=9yK/YkiXr+f4tKbvTRp2rVAekN5hQ3AKy2YzjivhZlqNry3ogzgVdoWiDIyGCRlG8Tt6au
	LYXxd6EMw6mog6Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755015693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ned1pgNlWGdntOMM16NdhHs5e042zHyl9sNCiue17Po=;
	b=q14A6BCiNLhsD4V0qTIk8cM2gzbsVRQGDBTz3KA9uRqFHhdVUetyyzqpNAtTncccSK0NrA
	pjH3QE4HDTinQdwkO8D11p4jIwpFZn6YHCAnHGHENEESVftcgX0KXahbqi+O+yWC5l1kMs
	Xf655AfZkdk2dIst/agawZWN/GDVRZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755015693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ned1pgNlWGdntOMM16NdhHs5e042zHyl9sNCiue17Po=;
	b=9yK/YkiXr+f4tKbvTRp2rVAekN5hQ3AKy2YzjivhZlqNry3ogzgVdoWiDIyGCRlG8Tt6au
	LYXxd6EMw6mog6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 871871351A;
	Tue, 12 Aug 2025 16:21:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2FPKHQxqm2iCbgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 12 Aug 2025 16:21:32 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH v2 2/3] maple_tree: Use kfree_rcu in ma_free_rcu
Date: Tue, 12 Aug 2025 17:21:23 +0100
Message-ID: <20250812162124.59417-2-pfalcato@suse.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812162124.59417-1-pfalcato@suse.de>
References: <20250812162124.59417-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

kfree_rcu is an optimized version of call_rcu + kfree. It used to not be
possible to call it on non-kmalloc objects, but this restriction was
lifted ever since SLOB was dropped from the kernel, and since commit
6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()").

Thus, replace call_rcu + mt_free_rcu with kfree_rcu.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 lib/maple_tree.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b4ee2d29d7a9..91da2d9d00c3 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -191,13 +191,6 @@ static inline void mt_free_bulk(size_t size, void __rcu **nodes)
 	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
 }
 
-static void mt_free_rcu(struct rcu_head *head)
-{
-	struct maple_node *node = container_of(head, struct maple_node, rcu);
-
-	kmem_cache_free(maple_node_cache, node);
-}
-
 /*
  * ma_free_rcu() - Use rcu callback to free a maple node
  * @node: The node to free
@@ -208,7 +201,7 @@ static void mt_free_rcu(struct rcu_head *head)
 static void ma_free_rcu(struct maple_node *node)
 {
 	WARN_ON(node->parent != ma_parent_ptr(node));
-	call_rcu(&node->rcu, mt_free_rcu);
+	kfree_rcu(node, rcu);
 }
 
 static void mt_set_height(struct maple_tree *mt, unsigned char height)
@@ -5281,7 +5274,7 @@ static void mt_free_walk(struct rcu_head *head)
 	mt_free_bulk(node->slot_len, slots);
 
 free_leaf:
-	mt_free_rcu(&node->rcu);
+	mt_free_one(node);
 }
 
 static inline void __rcu **mte_destroy_descend(struct maple_enode **enode,
@@ -5365,7 +5358,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
 
 free_leaf:
 	if (free)
-		mt_free_rcu(&node->rcu);
+		mt_free_one(node);
 	else
 		mt_clear_meta(mt, node, node->type);
 }
-- 
2.50.1


