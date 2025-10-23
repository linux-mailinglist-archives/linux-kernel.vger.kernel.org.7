Return-Path: <linux-kernel+bounces-867101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7356CC01990
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0E53B4CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC5C32D42B;
	Thu, 23 Oct 2025 13:53:31 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5432C95E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227610; cv=none; b=iOCyBwK2A79W49Qpo1JAPHZl3Tpo0OcUmB+qItF+y3UQ364C/iCMsFBIsf+alw+7WfUzuwDWXXjPvseGRRMqGbaJ+Kk9TNcOGg8spox6WoybrQcb/aRSzLbF58i6R3RCCvBBGmYTT3J410/aauMRt0FDm6vS6qTSvpvIO2GW8HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227610; c=relaxed/simple;
	bh=kdE9Jg1aTTwOMfEfQ1gVdd0QwKyIOwxWFl/ZobnLhVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lVZ4g07EWqDdNTIGTGGRCmQj7SfY1TbWM7ILMzVWMpCjkl14oYv7wP5FX0Yxq85UvyP9aP3BWJBs0CEbwF39NGd9Xh+kULbHy3F+52z61G2nuzmI5Uc0UQUehocCpKPGsU7H9kL/a2YO8hZffy4H7QubT0W6CSAHPJgTbW91qcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA61721279;
	Thu, 23 Oct 2025 13:53:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED1B413B11;
	Thu, 23 Oct 2025 13:52:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OMeeOTYz+mjvQQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 23 Oct 2025 13:52:54 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 23 Oct 2025 15:52:41 +0200
Subject: [PATCH RFC 19/19] slab: remove frozen slab checks from
 __slab_free()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-sheaves-for-all-v1-19-6ffa2c9941c0@suse.cz>
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: BA61721279
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

Currently slabs are only frozen after consistency checks failed. This
can happen only in caches with debugging enabled, and those use
free_to_partial_list() for freeing. The non-debug operation of
__slab_free() can thus stop considering the frozen field, and we can
remove the FREE_FROZEN stat.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 515a2b59cb52..9b551c48c2eb 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -336,7 +336,6 @@ enum stat_item {
 	FREE_RCU_SHEAF_FAIL,	/* Failed to free to a rcu_free sheaf */
 	FREE_FASTPATH,		/* Free to cpu slab */
 	FREE_SLOWPATH,		/* Freeing not to cpu slab */
-	FREE_FROZEN,		/* Freeing to frozen slab */
 	FREE_ADD_PARTIAL,	/* Freeing moves slab to partial list */
 	FREE_REMOVE_PARTIAL,	/* Freeing removes last object */
 	ALLOC_FROM_PARTIAL,	/* Cpu slab acquired from node partial list */
@@ -5036,7 +5035,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 
 {
 	void *prior;
-	int was_frozen;
 	struct slab new;
 	unsigned long counters;
 	struct kmem_cache_node *n = NULL;
@@ -5059,9 +5057,8 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		counters = slab->counters;
 		set_freepointer(s, tail, prior);
 		new.counters = counters;
-		was_frozen = new.frozen;
 		new.inuse -= cnt;
-		if ((!new.inuse || !prior) && !was_frozen) {
+		if (!new.inuse || !prior) {
 			/* Needs to be taken off a list */
 			n = get_node(s, slab_nid(slab));
 			/*
@@ -5083,15 +5080,10 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		"__slab_free"));
 
 	if (likely(!n)) {
-
-		if (likely(was_frozen)) {
-			/*
-			 * The list lock was not taken therefore no list
-			 * activity can be necessary.
-			 */
-			stat(s, FREE_FROZEN);
-		}
-
+		/*
+		 * The list lock was not taken therefore no list activity can be
+		 * necessary.
+		 */
 		return;
 	}
 
@@ -8648,7 +8640,6 @@ STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
 STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
 STAT_ATTR(FREE_FASTPATH, free_fastpath);
 STAT_ATTR(FREE_SLOWPATH, free_slowpath);
-STAT_ATTR(FREE_FROZEN, free_frozen);
 STAT_ATTR(FREE_ADD_PARTIAL, free_add_partial);
 STAT_ATTR(FREE_REMOVE_PARTIAL, free_remove_partial);
 STAT_ATTR(ALLOC_FROM_PARTIAL, alloc_from_partial);
@@ -8753,7 +8744,6 @@ static struct attribute *slab_attrs[] = {
 	&free_rcu_sheaf_fail_attr.attr,
 	&free_fastpath_attr.attr,
 	&free_slowpath_attr.attr,
-	&free_frozen_attr.attr,
 	&free_add_partial_attr.attr,
 	&free_remove_partial_attr.attr,
 	&alloc_from_partial_attr.attr,

-- 
2.51.1


