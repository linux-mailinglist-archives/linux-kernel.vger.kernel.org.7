Return-Path: <linux-kernel+bounces-737214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBB9B0A94E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC2A5A16EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC572E6D00;
	Fri, 18 Jul 2025 17:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rf/ycg1Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F1Kq8pAt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Rf/ycg1Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F1Kq8pAt"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522144503B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859306; cv=none; b=pGQa7kftNodJaRwQZwrCiLVmK1nV3Dxs3IUuBxMlLMaTaXmmpWMrLO4XFcfXkA34Reb/wreEHWL4HyX+TF7NFjUB2lIPIsPVHHzo0Uj+bVY2SZvbmNOz3gTsELNif4aJQYzFMXW4zn0fHV5A1t0mURuKn7hnRf/FaukasbX1Zfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859306; c=relaxed/simple;
	bh=KKKiWbCfHBlPOlaqKjZXSPANsewCKKyGVgYwf1jRbx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALf3C3Shk7r2byrc5ONgbjSIqLt2XH6D6Kw2pcz5dqkFifaxfAOma2zW4bH5fXP617GOtWYFH9hYRAEp2MgQWKYDzxxrbhf+fSeuvbl9RXZ8KEEtlTaHfJTou9MZqvQ1XdVvrN8ed3pCALzQ0GTqWvgtb/HgyAyw4j1Putb8KUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rf/ycg1Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F1Kq8pAt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Rf/ycg1Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F1Kq8pAt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A23C211F9;
	Fri, 18 Jul 2025 17:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752859301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ned1pgNlWGdntOMM16NdhHs5e042zHyl9sNCiue17Po=;
	b=Rf/ycg1QkKgdJiDPGpiHXBUK8mnewrjwXx8XrZ3eRWTZ0lT/F2OJTUd+VM3/a5+tKrf05K
	ekHxhwbUPxE/BeulVksTgey/z6MgNI7u86rO1HhEYP79iQ+3Xv5Ez22mYrqCmZJcJ8lzlg
	iC5tl6FAWY4iMYLhSKZ0JxDO0eFX+zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752859301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ned1pgNlWGdntOMM16NdhHs5e042zHyl9sNCiue17Po=;
	b=F1Kq8pAt9bhibgucIYm9ZK5k2WK+zrmfTDeGiQnnwGzvGejxHwuHLBemGvOdUB/Z6BnC6e
	6Kt+5lUcJkm1nkAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752859301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ned1pgNlWGdntOMM16NdhHs5e042zHyl9sNCiue17Po=;
	b=Rf/ycg1QkKgdJiDPGpiHXBUK8mnewrjwXx8XrZ3eRWTZ0lT/F2OJTUd+VM3/a5+tKrf05K
	ekHxhwbUPxE/BeulVksTgey/z6MgNI7u86rO1HhEYP79iQ+3Xv5Ez22mYrqCmZJcJ8lzlg
	iC5tl6FAWY4iMYLhSKZ0JxDO0eFX+zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752859301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ned1pgNlWGdntOMM16NdhHs5e042zHyl9sNCiue17Po=;
	b=F1Kq8pAt9bhibgucIYm9ZK5k2WK+zrmfTDeGiQnnwGzvGejxHwuHLBemGvOdUB/Z6BnC6e
	6Kt+5lUcJkm1nkAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBE1D138D2;
	Fri, 18 Jul 2025 17:21:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M+9EKqSCemizYQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 18 Jul 2025 17:21:40 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH 1/2] maple_tree: Use kfree_rcu in ma_free_rcu
Date: Fri, 18 Jul 2025 18:21:36 +0100
Message-ID: <20250718172138.103116-1-pfalcato@suse.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
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


