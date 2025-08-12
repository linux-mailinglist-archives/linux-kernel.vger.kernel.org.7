Return-Path: <linux-kernel+bounces-765241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A97FDB22D39
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 853C04E14E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E130A2F8BC8;
	Tue, 12 Aug 2025 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nnf+d+BE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zOFoRkf3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nnf+d+BE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zOFoRkf3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A39C2F8BDC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015704; cv=none; b=jwUWS9rx+fDzp0DXGFNCUorsdDvNfisGV8V1llioiJ3Y0JbCUcUAmSQunY12EKZ/SLou8XUavFdcnv8QPNgDgIeMvKe7okJ7TN2eZgIWJURBndvbSGIDCrh5F1LdoTXo+D28SSAteN0fuJ+fI0sqv3KiR4HdCBFbgZynAMz960g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015704; c=relaxed/simple;
	bh=c1+SSazoyR2/Ax4bJR8rTARFa0S6hnY8wAujhqZlp9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9geppG9kuV57vW4faxGfakiJ66BzLRTqBy8PeT6GBWVw2X6gkfJtOuiNt65dHJJgM0ppJPDoe78u9dD3598sB/TR/jNsKlWyDYwpZHTQ26JkPzEEMb6cJ8CLnZTdVQ050rzyNDQILmpUhydQY6AR8RPwVwmnXQo+K2HHG/w1VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nnf+d+BE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zOFoRkf3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nnf+d+BE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zOFoRkf3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74E9421B49;
	Tue, 12 Aug 2025 16:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755015694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4C5NtI+VD1npfCwb74mn6d30ygiQNiXgYMXuYu6v+w=;
	b=Nnf+d+BErZu2oeCBhh8OW+VNmtAvg0PwIewFeSMnsseLzksVBiVhhpzql6/vpQ3qfbbrcl
	DbLf9/mEAKvFYaJW5LA3o3K3+8V5AcnPLchiXSBPSkXsFYgCmXlJ0fHnYIbaePc8Rv39IF
	1LjLuDHPk1GZu1mq0mDREYCymuHFCVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755015694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4C5NtI+VD1npfCwb74mn6d30ygiQNiXgYMXuYu6v+w=;
	b=zOFoRkf3Ho0REFlPnKKQCNcB3nRPDC59KMsTGNtglYwfzV9k/GrVMc0mhS9ckDSTeJTMoq
	aGjiZ11q2XOVRHBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nnf+d+BE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zOFoRkf3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755015694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4C5NtI+VD1npfCwb74mn6d30ygiQNiXgYMXuYu6v+w=;
	b=Nnf+d+BErZu2oeCBhh8OW+VNmtAvg0PwIewFeSMnsseLzksVBiVhhpzql6/vpQ3qfbbrcl
	DbLf9/mEAKvFYaJW5LA3o3K3+8V5AcnPLchiXSBPSkXsFYgCmXlJ0fHnYIbaePc8Rv39IF
	1LjLuDHPk1GZu1mq0mDREYCymuHFCVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755015694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4C5NtI+VD1npfCwb74mn6d30ygiQNiXgYMXuYu6v+w=;
	b=zOFoRkf3Ho0REFlPnKKQCNcB3nRPDC59KMsTGNtglYwfzV9k/GrVMc0mhS9ckDSTeJTMoq
	aGjiZ11q2XOVRHBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA8441351A;
	Tue, 12 Aug 2025 16:21:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SJgGMg1qm2iCbgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 12 Aug 2025 16:21:33 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: [PATCH v2 3/3] maple_tree: Replace mt_free_one() with kfree()
Date: Tue, 12 Aug 2025 17:21:24 +0100
Message-ID: <20250812162124.59417-3-pfalcato@suse.de>
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
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 74E9421B49
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

kfree() is a little shorter and works with kmem_cache_alloc'd pointers
too. Also lets us remove one more helper.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
---
 lib/maple_tree.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 91da2d9d00c3..3b756f1b67fd 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -181,11 +181,6 @@ static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
 	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
 }
 
-static inline void mt_free_one(struct maple_node *node)
-{
-	kmem_cache_free(maple_node_cache, node);
-}
-
 static inline void mt_free_bulk(size_t size, void __rcu **nodes)
 {
 	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
@@ -5274,7 +5269,7 @@ static void mt_free_walk(struct rcu_head *head)
 	mt_free_bulk(node->slot_len, slots);
 
 free_leaf:
-	mt_free_one(node);
+	kfree(node);
 }
 
 static inline void __rcu **mte_destroy_descend(struct maple_enode **enode,
@@ -5358,7 +5353,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
 
 free_leaf:
 	if (free)
-		mt_free_one(node);
+		kfree(node);
 	else
 		mt_clear_meta(mt, node, node->type);
 }
@@ -5585,7 +5580,7 @@ void mas_destroy(struct ma_state *mas)
 			mt_free_bulk(count, (void __rcu **)&node->slot[1]);
 			total -= count;
 		}
-		mt_free_one(ma_mnode_ptr(node));
+		kfree(ma_mnode_ptr(node));
 		total--;
 	}
 
@@ -6630,7 +6625,7 @@ static void mas_dup_free(struct ma_state *mas)
 	}
 
 	node = mte_to_node(mas->node);
-	mt_free_one(node);
+	kfree(node);
 }
 
 /*
-- 
2.50.1


