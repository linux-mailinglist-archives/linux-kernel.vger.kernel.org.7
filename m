Return-Path: <linux-kernel+bounces-890499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCA1C40334
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3B264F2EAD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7A31B122;
	Fri,  7 Nov 2025 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fYxK1G/W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TGWKXhah"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371CF1D31B9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523526; cv=none; b=OyS7U2pWAUDXfmDCN/+Za1hGsHzL4xzFxWir+LhvytDnVxGdEE4Y/qNkasDh9JNJ1DAep9dT84ienARZtWFTOGQTKAHsMpugghiFlcczdvCahNMa3IcWTWHbq/a2tEFvI0Tzbc7EdSIyQpygtIFKNHfAHNwgSYDVGJBfClxpagM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523526; c=relaxed/simple;
	bh=hSWEdMLovcP9bQkB7Wk8xHcoJA3zCHtq+wyLjs21pmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgYruuENNhU567qbDhwk9uMRqzNCzFELO/gTD66DWCu9ehMhTZA59UQ9wcEeRSDZ+h5F1OcisojyMvQYSutPvs5a6UueIlUxSFvRuqbfeFDV5Z1L+rgntwol3Cacv+8VU1eVF7uth/uSVOMziMaBf7XL/lT1na16PU52w/xGvZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fYxK1G/W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TGWKXhah; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93CCC1F395;
	Fri,  7 Nov 2025 13:51:46 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762523506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpbVwPnigYZBYPBD0v1fEcmXhvJqKrRei+EvKd6N3nY=;
	b=fYxK1G/WAs29MTQdyG4dByVDgnPXCPDtfebWTTPlRWgieWXFzAFXw5gmwUHNimGlMgfOTV
	2r86Q1/yrh36ncnuN6hV56lyUwNj9a1voTpQbsiA4laNyWs7Jdf+SgWB+79gG3jcoLEEqq
	tf7sjPmO3wXCl8lYtteBzP0il4wq4RU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762523506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpbVwPnigYZBYPBD0v1fEcmXhvJqKrRei+EvKd6N3nY=;
	b=TGWKXhahJY6XQ/0Q8hvOY1jKzklVoLltGsdlgtHSsy3J5hkAgZl1Rib1VN2cDJP4cAnpGI
	7BCDMGm4DtQ4hzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8053513A60;
	Fri,  7 Nov 2025 13:51:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yP8JH3L5DWlFCwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 07 Nov 2025 13:51:46 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 07 Nov 2025 14:51:23 +0100
Subject: [PATCH 1/4] slab: separate struct freelist_tid from kmem_cache_cpu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-slab-fms-cleanup-v1-1-650b1491ac9e@suse.cz>
References: <20251107-slab-fms-cleanup-v1-0-650b1491ac9e@suse.cz>
In-Reply-To: <20251107-slab-fms-cleanup-v1-0-650b1491ac9e@suse.cz>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 93CCC1F395
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

In kmem_cache_cpu we currently have a union of the freelist+tid pair
with freelist_aba_t, relying implicitly on the type compatibility with the
freelist+counters pair used in freelist_aba_t.

To allow further changes to freelist_aba_t, we can instead define a
separate struct freelist_tid (instead of a typedef, per the coding
style) for kmem_cache_cpu, as that affects only a single helper
__update_cpu_freelist_fast().

We can add the resulting struct freelist_tid to kmem_cache_cpu as
unnamed field thanks to -fms-extensions, so that freelist and tid fields
can still be accessed directly.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 074abe8e79f8..5f6408c9e0fd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -411,18 +411,22 @@ enum stat_item {
 };
 
 #ifndef CONFIG_SLUB_TINY
-/*
- * When changing the layout, make sure freelist and tid are still compatible
- * with this_cpu_cmpxchg_double() alignment requirements.
- */
-struct kmem_cache_cpu {
+struct freelist_tid {
 	union {
 		struct {
-			void **freelist;	/* Pointer to next available object */
+			void *freelist;		/* Pointer to next available object */
 			unsigned long tid;	/* Globally unique transaction id */
 		};
-		freelist_aba_t freelist_tid;
+		freelist_full_t freelist_tid;
 	};
+};
+
+/*
+ * When changing the layout, make sure freelist and tid are still compatible
+ * with this_cpu_cmpxchg_double() alignment requirements.
+ */
+struct kmem_cache_cpu {
+	struct freelist_tid;
 	struct slab *slab;	/* The slab from which we are allocating */
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct slab *partial;	/* Partially allocated slabs */
@@ -4367,11 +4371,11 @@ __update_cpu_freelist_fast(struct kmem_cache *s,
 			   void *freelist_old, void *freelist_new,
 			   unsigned long tid)
 {
-	freelist_aba_t old = { .freelist = freelist_old, .counter = tid };
-	freelist_aba_t new = { .freelist = freelist_new, .counter = next_tid(tid) };
+	struct freelist_tid old = { .freelist = freelist_old, .tid = tid };
+	struct freelist_tid new = { .freelist = freelist_new, .tid = next_tid(tid) };
 
-	return this_cpu_try_cmpxchg_freelist(s->cpu_slab->freelist_tid.full,
-					     &old.full, new.full);
+	return this_cpu_try_cmpxchg_freelist(s->cpu_slab->freelist_tid,
+					     &old.freelist_tid, new.freelist_tid);
 }
 
 /*

-- 
2.51.1


