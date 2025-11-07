Return-Path: <linux-kernel+bounces-890496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 032AEC4031F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1863B3A8A08
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3D031B118;
	Fri,  7 Nov 2025 13:51:56 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758731A813
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523516; cv=none; b=oWyi7p8RTKIEuEMLFZ+PsHUthlYTbpBgXIb6S1Txm+V+C27NiKY7tEEg2cmRAEwUE47y0P6KXvCG5aLNKSRxmULikkeKEoMPp4XAFhhqO7cul+4HXB104ytSm9AxPOeFCvLL5Rhd6k+nOJLpCFkF+6Szd6+YMxkQU81VREXkyXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523516; c=relaxed/simple;
	bh=OOJrymWY/Gu0Gj4MYTTXnOnrPjcJyZkkFclG4H5WBuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hslx8hSmdoHS4Ra21IdzIIrdWGQ4AC7Gqcbhq3rvsJ/+do25xxBCRhp7zER0iQZCJzfxnK88fHm/UJfBBJN6v0LL5dwVFMUrg8HIpZJxJ/rbKBSxPEryYNtDTI70NkBKXKmMu3DSKSps67ZuTB3ruEHAyle8QXSe68STH6cXmTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2AC9211D6;
	Fri,  7 Nov 2025 13:51:46 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D1CB13A88;
	Fri,  7 Nov 2025 13:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IH4OJnL5DWlFCwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 07 Nov 2025 13:51:46 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 07 Nov 2025 14:51:25 +0100
Subject: [PATCH 3/4] slab: use struct freelist_counters for local variables
 instead of struct slab
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-slab-fms-cleanup-v1-3-650b1491ac9e@suse.cz>
References: <20251107-slab-fms-cleanup-v1-0-650b1491ac9e@suse.cz>
In-Reply-To: <20251107-slab-fms-cleanup-v1-0-650b1491ac9e@suse.cz>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: B2AC9211D6
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

In several functions we declare local struct slab variables so we can
work with the freelist and counters fields (including the sub-counters
that are in the union) comfortably.

With struct freelist_counters containing the full counters definition,
we can now reduce the local variables to that type as we don't need the
other fields in struct slab.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8330e4f8b3b2..a55e0af26ec7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3725,8 +3725,7 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 	void *nextfree, *freelist_iter, *freelist_tail;
 	int tail = DEACTIVATE_TO_HEAD;
 	unsigned long flags = 0;
-	struct slab new;
-	struct slab old;
+	struct freelist_counters old, new;
 
 	if (READ_ONCE(slab->freelist)) {
 		stat(s, DEACTIVATE_REMOTE_FREES);
@@ -4390,7 +4389,7 @@ __update_cpu_freelist_fast(struct kmem_cache *s,
  */
 static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
 {
-	struct slab new;
+	struct freelist_counters new;
 	unsigned long counters;
 	void *freelist;
 
@@ -4418,7 +4417,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
  */
 static inline void *freeze_slab(struct kmem_cache *s, struct slab *slab)
 {
-	struct slab new;
+	struct freelist_counters new;
 	unsigned long counters;
 	void *freelist;
 
@@ -5867,7 +5866,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 {
 	void *old_head;
 	bool was_frozen, was_full;
-	struct slab new;
+	struct freelist_counters new;
 	unsigned long counters;
 	struct kmem_cache_node *n = NULL;
 	unsigned long flags;

-- 
2.51.1


