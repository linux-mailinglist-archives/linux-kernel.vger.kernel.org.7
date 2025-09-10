Return-Path: <linux-kernel+bounces-809669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D72B51093
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B01175834
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C3F314B8E;
	Wed, 10 Sep 2025 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bG8byubO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FRqvZn76";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bG8byubO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FRqvZn76"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B67314B8A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491357; cv=none; b=tmBSaE3033RMRQBB8rVYQ8gIf0pfcxV5oervtPqdrmwM15XBKDxtAGUJJky8A9xRCO9zqwdYI/EWtuo9yHlbX+zHzhw/u430FrI4VjkkF1ikm49f7w6lzKWRpMNdOTIh+kGlvdmSMEoLdC6aE+OPhWxsFiYc5iuVPgwsZo4w13w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491357; c=relaxed/simple;
	bh=28ASGun92PwbCnSWRg7GtRz7iIraEx4bfcesxbmo0no=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WRAv4Nb1Mltxyls4aT0hhgHtjNd7UWZXcEQom89STBmeTARp1Q9y/LUB7NeJf5F/7N8ZJ5+1ymQFFhvAjRs48UNN9FSe5GN2H92rQcu9QipAj3LvCBSYzvA5Y6ff0uENJqkwvps32ScapdhJ+6lvS51dovtDIiavHnVKbtOn4to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bG8byubO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FRqvZn76; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bG8byubO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FRqvZn76; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A30545CC0C;
	Wed, 10 Sep 2025 08:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1197+hnB0r2rFuPElGqqXMK0u+WFyH+bVUAY0R1B8I=;
	b=bG8byubOhLuFcRvQJ/p+M0Y2OV50g4nsGXfM8gfrJ0cPb0YCeaCHCfnTJRTX0itVNWk9uo
	mC9Dyy6Q3QiT2EQTB5SLttSap4J03aQo9rSc/ri6xVnc7mA8TQ7s1NurKh1r7sRigx0te1
	Jwx55wHfLrwjOGNwONXQYOQHnmUFadc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1197+hnB0r2rFuPElGqqXMK0u+WFyH+bVUAY0R1B8I=;
	b=FRqvZn76AmAanqTnKsjGlWhQU0riFgfbSy1PQwkbso/YR3aWuZCSzf9qHdHZWDEZNpZAvO
	8YLupf3mRiYc5hAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757491267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1197+hnB0r2rFuPElGqqXMK0u+WFyH+bVUAY0R1B8I=;
	b=bG8byubOhLuFcRvQJ/p+M0Y2OV50g4nsGXfM8gfrJ0cPb0YCeaCHCfnTJRTX0itVNWk9uo
	mC9Dyy6Q3QiT2EQTB5SLttSap4J03aQo9rSc/ri6xVnc7mA8TQ7s1NurKh1r7sRigx0te1
	Jwx55wHfLrwjOGNwONXQYOQHnmUFadc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757491267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1197+hnB0r2rFuPElGqqXMK0u+WFyH+bVUAY0R1B8I=;
	b=FRqvZn76AmAanqTnKsjGlWhQU0riFgfbSy1PQwkbso/YR3aWuZCSzf9qHdHZWDEZNpZAvO
	8YLupf3mRiYc5hAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C86213ABD;
	Wed, 10 Sep 2025 08:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2KgMIkMwwWgGJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Sep 2025 08:01:07 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 10 Sep 2025 10:01:24 +0200
Subject: [PATCH v8 22/23] maple_tree: Add single node allocation support to
 maple state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-slub-percpu-caches-v8-22-ca3099d8352c@suse.cz>
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
 "Liam R. Howlett" <Liam.Howlett@Oracle.com>
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz,Oracle.com];
	R_RATELIMIT(0.00)[to(RL941jgdop1fyjkq8h4),to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The fast path through a write will require replacing a single node in
the tree.  Using a sheaf (32 nodes) is too heavy for the fast path, so
special case the node store operation by just allocating one node in the
maple state.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/maple_tree.h       |  4 +++-
 lib/maple_tree.c                 | 47 +++++++++++++++++++++++++++++++++++-----
 tools/testing/radix-tree/maple.c |  9 ++++++--
 3 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 166fd67e00d882b1e6de1f80c1b590bba7497cd3..562a1e9e5132b5b1fa8f8402a7cadd8abb65e323 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -443,6 +443,7 @@ struct ma_state {
 	unsigned long min;		/* The minimum index of this node - implied pivot min */
 	unsigned long max;		/* The maximum index of this node - implied pivot max */
 	struct slab_sheaf *sheaf;	/* Allocated nodes for this operation */
+	struct maple_node *alloc;	/* allocated nodes */
 	unsigned long node_request;
 	enum maple_status status;	/* The status of the state (active, start, none, etc) */
 	unsigned char depth;		/* depth of tree descent during write */
@@ -491,8 +492,9 @@ struct ma_wr_state {
 		.status = ma_start,					\
 		.min = 0,						\
 		.max = ULONG_MAX,					\
-		.node_request= 0,					\
 		.sheaf = NULL,						\
+		.alloc = NULL,						\
+		.node_request= 0,					\
 		.mas_flags = 0,						\
 		.store_type = wr_invalid,				\
 	}
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a3fcb20227e506ed209554cc8c041a53f7ef4903..a912e6a1d4378e72b967027b60f8f564476ad14e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1073,16 +1073,23 @@ static int mas_ascend(struct ma_state *mas)
  *
  * Return: A pointer to a maple node.
  */
-static inline struct maple_node *mas_pop_node(struct ma_state *mas)
+static __always_inline struct maple_node *mas_pop_node(struct ma_state *mas)
 {
 	struct maple_node *ret;
 
+	if (mas->alloc) {
+		ret = mas->alloc;
+		mas->alloc = NULL;
+		goto out;
+	}
+
 	if (WARN_ON_ONCE(!mas->sheaf))
 		return NULL;
 
 	ret = kmem_cache_alloc_from_sheaf(maple_node_cache, GFP_NOWAIT, mas->sheaf);
-	memset(ret, 0, sizeof(*ret));
 
+out:
+	memset(ret, 0, sizeof(*ret));
 	return ret;
 }
 
@@ -1093,9 +1100,34 @@ static inline struct maple_node *mas_pop_node(struct ma_state *mas)
  */
 static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 {
-	if (unlikely(mas->sheaf)) {
-		unsigned long refill = mas->node_request;
+	if (!mas->node_request)
+		return;
+
+	if (mas->node_request == 1) {
+		if (mas->sheaf)
+			goto use_sheaf;
+
+		if (mas->alloc)
+			return;
 
+		mas->alloc = mt_alloc_one(gfp);
+		if (!mas->alloc)
+			goto error;
+
+		mas->node_request = 0;
+		return;
+	}
+
+use_sheaf:
+	if (unlikely(mas->alloc)) {
+		kfree(mas->alloc);
+		mas->alloc = NULL;
+	}
+
+	if (mas->sheaf) {
+		unsigned long refill;
+
+		refill = mas->node_request;
 		if(kmem_cache_sheaf_size(mas->sheaf) >= refill) {
 			mas->node_request = 0;
 			return;
@@ -5180,8 +5212,11 @@ void mas_destroy(struct ma_state *mas)
 	mas->node_request = 0;
 	if (mas->sheaf)
 		mt_return_sheaf(mas->sheaf);
-
 	mas->sheaf = NULL;
+
+	if (mas->alloc)
+		kfree(mas->alloc);
+	mas->alloc = NULL;
 }
 EXPORT_SYMBOL_GPL(mas_destroy);
 
@@ -5816,7 +5851,7 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
 		mas_alloc_nodes(mas, gfp);
 	}
 
-	if (!mas->sheaf)
+	if (!mas->sheaf && !mas->alloc)
 		return false;
 
 	mas->status = ma_start;
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 72a8fe8e832a4150c6567b711768eba6a3fa6768..83260f2efb1990b71093e456950069c24d75560e 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -35085,10 +35085,15 @@ static unsigned char get_vacant_height(struct ma_wr_state *wr_mas, void *entry)
 
 static int mas_allocated(struct ma_state *mas)
 {
+	int total = 0;
+
+	if (mas->alloc)
+		total++;
+
 	if (mas->sheaf)
-		return kmem_cache_sheaf_size(mas->sheaf);
+		total += kmem_cache_sheaf_size(mas->sheaf);
 
-	return 0;
+	return total;
 }
 /* Preallocation testing */
 static noinline void __init check_prealloc(struct maple_tree *mt)

-- 
2.51.0


