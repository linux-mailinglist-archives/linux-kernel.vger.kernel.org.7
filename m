Return-Path: <linux-kernel+bounces-865608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0169FBFD8D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C0954E74B0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAA8286D40;
	Wed, 22 Oct 2025 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yVBSxjfS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NQZPIom/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PhYuuFXQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="belS6VmZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5835B154
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153813; cv=none; b=DJrcbSDIGVLDbhOV2szoF1+y/PGVzWD4YDupYcNdKwSWBlxEsoX7VuVjP2ijQ5Uvo3nN7Gjp67tPpT5y3WksIxrKB2fBbnljIt4IyWcfSvX3y7Qs0EblJHbbvmYMwjh98tYuifrbqSSlNsjEjaBjqJLITNDwVH764LsQA/PVpjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153813; c=relaxed/simple;
	bh=lvP1zUvr7+W9aflgEwbNBpEd2W2lGAnG76Ysu0c45jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KKjYOWsbWbmRVomDLuFsMGgrHXEewitKxRVo6nQkgordKg6Ua3AZY0ipz3FDolT7l/qJyRoIdvuiCurR23mVMFWXlU4v4r/7cPgMFwVYIxVNHtmdyTTIWFgM6unPaRLHQrsJCx+ySNCAkGHnJoU56zWOPqcOzhCqv0M6YLC6Q3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yVBSxjfS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NQZPIom/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PhYuuFXQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=belS6VmZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1ED08211A9;
	Wed, 22 Oct 2025 17:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761153805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kVnlSRM+u7M2JbzO+iE6nuKFeIyJgHgIeVpcpBnG6as=;
	b=yVBSxjfSKjf8/n8/R6swNQZcAHfZqKcRrr2Aso+r+VF6VPkqcDVWVNezasm9hMKi9pUy3k
	wesSnpzT9sy4KjlRRnXhiGiysu7wAD+0rhSlcDAcrID5l/urLeN00tFBJFY/Ot1Kll2D00
	wfU8HFp0NG3OzQCnH2IrgnEGy+0h9MM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761153805;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kVnlSRM+u7M2JbzO+iE6nuKFeIyJgHgIeVpcpBnG6as=;
	b=NQZPIom/d30d9j58TNh4qABJN7/QCn1vTxX4knSyeEYvgRkKCZmlquMegMD5L1xnbR1UmU
	orZD661xfs6a4EAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PhYuuFXQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=belS6VmZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761153801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kVnlSRM+u7M2JbzO+iE6nuKFeIyJgHgIeVpcpBnG6as=;
	b=PhYuuFXQecljfIafTw8nWYru+Ujmf9dpdUwYeifYKoEuEaqiPfgHEvf9hiGwtAxwwnknXa
	w8MtWDsDQ7qk2H9QiJyoq5su98IgvEsaWJ0coouOGzszjAg7KxLA89Q97DXFTXS45gqLpL
	CY3mYWncbnBXk1HZcewU1YVyMA46hBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761153801;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kVnlSRM+u7M2JbzO+iE6nuKFeIyJgHgIeVpcpBnG6as=;
	b=belS6VmZBauqGJMHXhrM3Jrp9gfkini7Tda9BGTAqRfh2OFKrjlBhT0XPaSALWU12WU0Fo
	6gzdZSlgv2Pk0HDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8B4813A29;
	Wed, 22 Oct 2025 17:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TyhgMAgT+WgoSgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 22 Oct 2025 17:23:20 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 22 Oct 2025 19:23:11 +0200
Subject: [PATCH] slab: perform inc_slabs_node() as part of new_slab()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-fix-slab-accounting-v1-1-27870ec363ce@suse.cz>
X-B4-Tracking: v=1; b=H4sIAP4S+WgC/x2MQQqAIBAAvxJ7bkGFIvpKdFhttYXQ0Iog+nvSc
 WBmHiichQuMzQOZLymSYgXdNuBWioFRlspglOm0Mga93Fg2skjOpTMeEgN6RdYuNFDvPdRyz1y
 1/zrN7/sBFSnOcmUAAAA=
X-Change-ID: 20251022-fix-slab-accounting-f0abbda8a6ff
To: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
 Alexei Starovoitov <ast@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3629; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=lvP1zUvr7+W9aflgEwbNBpEd2W2lGAnG76Ysu0c45jw=;
 b=owGbwMvMwMG4+8GG0kuuHbMYT6slMWT8FGbdEJ7NVOh+6N6t7A9PGNW1C+yrbSwXizo8u6la5
 F/m08DUyejPwsDIwWAppshSvfuEo+hMZY9pHr4fYQaxMoFMkRZpYAACFga+3MS8UiMdIz1TbUM9
 Q0MdIJOBi1MApjrkFvv/1PlF666qrXnyWp9f9qTIgnkbz/P7PGmLfrXwy4qrDxalumc2+U0KCPL
 WZJ630T6MO+elxlyv2SVSH7mCRFO+e5RZX1AL/v3M8rW4sPapR4cO6olke3p/W/v/iFn6bD+N54
 nTnb72FrzZ1bV+8QyWy19LHvHZrFpg/OMl4/Z39xyyMzxqrxYJf35WUs4j/Px2xquJUdmvhW5WP
 g5SDuT5tvF4scVkB75pjhpzHdg0TNP5E2ZoyU9tua8r+4dJsJxvojDD44SScxd/25zzkTu0zX2i
 VYC6ge7rPVfn9Ww/YTRj/l+pjb7GuiITMqLF25bYdwb0WiVqXmlXLu0oVflwcoKOim1Jjc7+sGM
 5ZYEA
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1ED08211A9
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
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

Since commit af92793e52c3 ("slab: Introduce kmalloc_nolock() and
kfree_nolock().") there's a possibility in alloc_single_from_new_slab()
that we discard the newly allocated slab if we can't spin and we fail to
trylock. As a result we don't perform inc_slabs_node() later in the
function. Instead we perform a deferred deactivate_slab() which can
either put the unacounted slab on partial list, or discard it
immediately while performing dec_slabs_node(). Either way will cause an
accounting imbalance.

Fix this and also make the code more robust by performing
inc_slabs_node() in new_slab() itself, and removing it from its callers.
As a side effect, in the theoretical case where the new slab is
immediately leaked due to debugging consistency check failure, it will
be accounted (as full) in /proc/slabinfo anyway, which is not wrong.

The exceptional caller is early_kmem_cache_node_alloc() where the node
for stats is not yet initialized. We can handle it by using
allocate_slab() there as the gfp flags are known and fixed and we don't
need need new_slab()'s fixups.

Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 23d8f54e9486..dd4c85ea1038 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3268,13 +3268,21 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
 static struct slab *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
+	struct slab *slab;
+
 	if (unlikely(flags & GFP_SLAB_BUG_MASK))
 		flags = kmalloc_fix_flags(flags);
 
 	WARN_ON_ONCE(s->ctor && (flags & __GFP_ZERO));
 
-	return allocate_slab(s,
-		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
+	flags &= GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK;
+
+	slab = allocate_slab(s, flags, node);
+
+	if (likely(slab))
+		inc_slabs_node(s, slab_nid(slab), slab->objects);
+
+	return slab;
 }
 
 static void __free_slab(struct kmem_cache *s, struct slab *slab)
@@ -3415,8 +3423,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
 					int orig_size, gfp_t gfpflags)
 {
 	bool allow_spin = gfpflags_allow_spinning(gfpflags);
-	int nid = slab_nid(slab);
-	struct kmem_cache_node *n = get_node(s, nid);
+	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
 	unsigned long flags;
 	void *object;
 
@@ -3451,7 +3458,6 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
 	else
 		add_partial(n, slab, DEACTIVATE_TO_HEAD);
 
-	inc_slabs_node(s, nid, slab->objects);
 	spin_unlock_irqrestore(&n->list_lock, flags);
 
 	return object;
@@ -4680,8 +4686,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	slab->inuse = slab->objects;
 	slab->frozen = 1;
 
-	inc_slabs_node(s, slab_nid(slab), slab->objects);
-
 	if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin)) {
 		/*
 		 * For !pfmemalloc_match() case we don't load freelist so that
@@ -7697,7 +7701,7 @@ static void early_kmem_cache_node_alloc(int node)
 
 	BUG_ON(kmem_cache_node->size < sizeof(struct kmem_cache_node));
 
-	slab = new_slab(kmem_cache_node, GFP_NOWAIT, node);
+	slab = allocate_slab(kmem_cache_node, GFP_NOWAIT, node);
 
 	BUG_ON(!slab);
 	if (slab_nid(slab) != node) {

---
base-commit: 6ed8bfd24ce1cb31742b09a3eb557cd008533eec
change-id: 20251022-fix-slab-accounting-f0abbda8a6ff

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


