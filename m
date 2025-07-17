Return-Path: <linux-kernel+bounces-735902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD18B09504
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D535DA661B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037D12F6FBA;
	Thu, 17 Jul 2025 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hcAK9Uw/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BCTnvuRR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="flcpHr5p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="60QRonxR"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95A9CA4B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780818; cv=none; b=eZT8s36UNHDV16ANTn4yItKSaWkkkbyd6tbIZqzM2D7OdDBjCepcAeFqJLgLYKGZ4bEW3VHV7G0XhXiZUTbJIJBjAN7Dmgx+z2XQxdZZyNhAxmjTTXJxm6Y1JFdpG2b3wUL/ABDyPeuU6VgTJrBZjHmrR3Jh++t2/jb0ov0mO1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780818; c=relaxed/simple;
	bh=tD1oxhgaY1oVagM39DM+ZPmmFC4diDofLXqkQauTA1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+6VK2983A+Yki6sZFAjnGtsTLWCW55gxO4RDu2+wFd/X03oW+IEHOD+SM+K9TJQJhdz0uFQDdf2vA3FmWKTyTbZmAZPENIUGRFRbvOmeDdWLN0Gf//Wc7TfyhKKNnSsi7iTwLWbApHh5p1LEiGgbsqsyT6L3g0WdeHOyYzCptI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hcAK9Uw/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BCTnvuRR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=flcpHr5p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=60QRonxR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC3192203B;
	Thu, 17 Jul 2025 19:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752780814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ccb//KfzLk/Dst47cd0bS7WG+KflhTDu6dx4m7hNowI=;
	b=hcAK9Uw/yGRnl+3rw6PEnRUKPqrNRhAuDfQjM6hsWrB7tgQ5s8k1GSX4z3EeyKfvnDkB5z
	uTExk4X+SvWziGu0BqPXC8EbCRqGfqM/qkOlvbjPFl6kGHRg5fmJva5Q9/hWuel9+up0Ke
	YA58BEC8i8uKbW7SMROkLTjbfyDsRj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752780814;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ccb//KfzLk/Dst47cd0bS7WG+KflhTDu6dx4m7hNowI=;
	b=BCTnvuRRprlRsvho2XpyCNO/7IKEA6nkuI49ryyfCh9m4w/XbwZR5j4BB3hDUTYThL1WPB
	v8Sr6xTs9uzySQBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=flcpHr5p;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=60QRonxR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752780812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ccb//KfzLk/Dst47cd0bS7WG+KflhTDu6dx4m7hNowI=;
	b=flcpHr5pGSP7yNWEvc8E4UaC1KWF+8PWV87RnyKK8ks3A3Wh15UGbBWTrjmWRroxKOcb9a
	/O2/+XEnhyo5b99mK+V82xm94gqjvxXkfnKq/nMk5jToPEiefpecB/m9o0ugXRB/IKp0eb
	GfNOgDUz4vCPgrgIjfDLpGVLiOrkfe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752780812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ccb//KfzLk/Dst47cd0bS7WG+KflhTDu6dx4m7hNowI=;
	b=60QRonxRgjowKUiEcuunXruMuRg2uAnJlGrc6BBDbIyG9ykZ+unrI1RQmpLUJ16OVjRbMU
	MKvgu1TE35HFyjAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDFE113A6C;
	Thu, 17 Jul 2025 19:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id otaOMQxQeWhoBAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 17 Jul 2025 19:33:32 +0000
Message-ID: <10e6b8f1-4383-425f-be7e-2d632cebb1c8@suse.cz>
Date: Thu, 17 Jul 2025 21:33:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] mm: Drain LRUs upon resume to userspace on nohz_full
 CPUs
Content-Language: en-US
To: Frederic Weisbecker <frederic@kernel.org>, Michal Hocko
 <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, linux-mm@kvack.org
References: <20250703140717.25703-1-frederic@kernel.org>
 <20250703140717.25703-7-frederic@kernel.org>
 <aGaTh2esRWr3L6IC@casper.infradead.org> <aGar8p-GlbqXtl7U@tiehlicka>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aGar8p-GlbqXtl7U@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: EC3192203B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 7/3/25 18:12, Michal Hocko wrote:
> On Thu 03-07-25 15:28:23, Matthew Wilcox wrote:
>> On Thu, Jul 03, 2025 at 04:07:17PM +0200, Frederic Weisbecker wrote:
>> > +unsigned int folio_batch_add(struct folio_batch *fbatch,
>> > +			     struct folio *folio)
>> > +{
>> > +	unsigned int ret;
>> > +
>> > +	fbatch->folios[fbatch->nr++] = folio;
>> > +	ret = folio_batch_space(fbatch);
>> > +	isolated_task_work_queue();
>> 
>> Umm.  LRUs use folio_batches, but they are definitely not the only user
>> of folio_batches.  Maybe you want to add a new lru_batch_add()
>> abstraction, because this call is definitely being done at the wrong
>> level.
> 
> You have answered one of my question in other response. My initial
> thought was that __lru_add_drain_all seems to be a better fit. But then

__lru_add_drain_all is the part where we queue the drain work to other cpus.
In order to not disrupt isolated cpus, the isolated cpus have to self-
schedule the work to be done on resume, which indeed means at the moment
they are filling the batches to be drained, as this patch does.

> we have a problem that draining will become an unbounded operation which
> will become a problem for lru_cache_disable which will never converge
> until isolated workload does the draining. So it indeed seems like we
> need to queue draining when a page is added. Are there other places
> where we put folios into teh folio_batch than folio_batch_add? I cannot
> seem to see any...

The problem Matthew points out isn't that there would be other places that
add folios to a fbatch, other than folio_batch_add(). The problem is that
many of the folio_batch_add() add something to a temporary batch on a stack,
which is not subject to lru draining, so it's wasteful to queue the
draining for those. 

The below diff should address this by creating folio_batch_add_lru() which
is only used in the right places that do fill a lru-drainable folio batch.
It also makes the function static inline again, in mm/internal.h, which
means it's adding some includes to it. For that I had to fix up some wrong
include places of internal.h in varous mm files - these includes should not
appear below "#define CREATE_TRACE_POINTS".

Frederic, feel free to fold this in your patch with my Co-developed-by:

I also noted that since this now handles invalidate_bh_lrus_cpu() maybe we
can drop the cpu_is_isolated() check from bh_lru_install(). I'm not even
sure if the check is equivalent or stronger than the check used in
isolated_task_work_queue().

I have a bit of remaining worry for __lru_add_drain_all() simply skipping
the isolated cpus because then it doesn't wait for the flushing to be
finished via flush_work(). It can thus return before the isolated cpu does
its drain-on-resume, which might violate some expectations of
lru_cache_disable(). Is there a possibility to make it wait for the drain-
on-resume or determine there's not any, in a reliable way?

----8<----
From eb6fb0b60a2ede567539e4be071cb92ff5ec221a Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 17 Jul 2025 21:05:48 +0200
Subject: [PATCH] mm: introduce folio_batch_add_lru

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/pagevec.h | 18 ++++++++++++++++--
 include/linux/swap.h    |  2 +-
 mm/internal.h           | 19 +++++++++++++++++--
 mm/mlock.c              |  6 +++---
 mm/mmap.c               |  4 ++--
 mm/percpu-vm.c          |  2 --
 mm/percpu.c             |  5 +++--
 mm/rmap.c               |  4 ++--
 mm/swap.c               | 25 +------------------------
 mm/vmalloc.c            |  6 +++---
 10 files changed, 48 insertions(+), 43 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 7e647b8df4c7..5d3a0cccc6bf 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -61,8 +61,22 @@ static inline unsigned int folio_batch_space(struct folio_batch *fbatch)
 	return PAGEVEC_SIZE - fbatch->nr;
 }
 
-unsigned int folio_batch_add(struct folio_batch *fbatch,
-			     struct folio *folio);
+/**
+ * folio_batch_add() - Add a folio to a batch.
+ * @fbatch: The folio batch.
+ * @folio: The folio to add.
+ *
+ * The folio is added to the end of the batch.
+ * The batch must have previously been initialised using folio_batch_init().
+ *
+ * Return: The number of slots still available.
+ */
+static inline unsigned folio_batch_add(struct folio_batch *fbatch,
+		struct folio *folio)
+{
+	fbatch->folios[fbatch->nr++] = folio;
+	return folio_batch_space(fbatch);
+}
 
 /**
  * folio_batch_next - Return the next folio to process.
diff --git a/include/linux/swap.h b/include/linux/swap.h
index d74ad6c893a1..0bede5cd4f61 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -401,7 +401,7 @@ extern void lru_add_drain(void);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
-extern void lru_add_and_bh_lrus_drain(void);
+void lru_add_and_bh_lrus_drain(void);
 void folio_deactivate(struct folio *folio);
 void folio_mark_lazyfree(struct folio *folio);
 extern void swap_setup(void);
diff --git a/mm/internal.h b/mm/internal.h
index 6b8ed2017743..c2848819ce5f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -18,12 +18,12 @@
 #include <linux/swapops.h>
 #include <linux/swap_cgroup.h>
 #include <linux/tracepoint-defs.h>
+#include <linux/pagevec.h>
+#include <linux/sched/isolation.h>
 
 /* Internal core VMA manipulation functions. */
 #include "vma.h"
 
-struct folio_batch;
-
 /*
  * Maintains state across a page table move. The operation assumes both source
  * and destination VMAs already exist and are specified by the user.
@@ -414,6 +414,21 @@ static inline vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
 	return ret;
 }
 
+/*
+ * A version of folio_batch_add() to use with batches that are drained from
+ * lru_add_drain() and checked in cpu_needs_drain()
+ */
+static inline unsigned int
+folio_batch_add_lru(struct folio_batch *fbatch, struct folio *folio)
+{
+	/*
+	 * We could perhaps not queue when returning 0 which means the caller
+	 * should flush the batch immediately, but that's rare anyway.
+	 */
+	isolated_task_work_queue();
+	return folio_batch_add(fbatch, folio);
+}
+
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
 bool __folio_end_writeback(struct folio *folio);
diff --git a/mm/mlock.c b/mm/mlock.c
index 3cb72b579ffd..a95f248efdf2 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -254,7 +254,7 @@ void mlock_folio(struct folio *folio)
 	}
 
 	folio_get(folio);
-	if (!folio_batch_add(fbatch, mlock_lru(folio)) ||
+	if (!folio_batch_add_lru(fbatch, mlock_lru(folio)) ||
 	    folio_test_large(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
@@ -277,7 +277,7 @@ void mlock_new_folio(struct folio *folio)
 	__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
 
 	folio_get(folio);
-	if (!folio_batch_add(fbatch, mlock_new(folio)) ||
+	if (!folio_batch_add_lru(fbatch, mlock_new(folio)) ||
 	    folio_test_large(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
@@ -298,7 +298,7 @@ void munlock_folio(struct folio *folio)
 	 * which will check whether the folio is multiply mlocked.
 	 */
 	folio_get(folio);
-	if (!folio_batch_add(fbatch, folio) ||
+	if (!folio_batch_add_lru(fbatch, folio) ||
 	    folio_test_large(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
diff --git a/mm/mmap.c b/mm/mmap.c
index 09c563c95112..4d9a5d8616c3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -54,11 +54,11 @@
 #include <asm/tlb.h>
 #include <asm/mmu_context.h>
 
+#include "internal.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/mmap.h>
 
-#include "internal.h"
-
 #ifndef arch_mmap_check
 #define arch_mmap_check(addr, len, flags)	(0)
 #endif
diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index cd69caf6aa8d..cd3aa1610294 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -8,8 +8,6 @@
  * Chunks are mapped into vmalloc areas and populated page by page.
  * This is the default chunk allocator.
  */
-#include "internal.h"
-
 static struct page *pcpu_chunk_page(struct pcpu_chunk *chunk,
 				    unsigned int cpu, int page_idx)
 {
diff --git a/mm/percpu.c b/mm/percpu.c
index b35494c8ede2..b8c34a931205 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -93,11 +93,12 @@
 #include <asm/tlbflush.h>
 #include <asm/io.h>
 
+#include "internal.h"
+#include "percpu-internal.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/percpu.h>
 
-#include "percpu-internal.h"
-
 /*
  * The slots are sorted by the size of the biggest continuous free area.
  * 1-31 bytes share the same slot.
diff --git a/mm/rmap.c b/mm/rmap.c
index fb63d9256f09..a4eab1664e25 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -78,12 +78,12 @@
 
 #include <asm/tlbflush.h>
 
+#include "internal.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/tlb.h>
 #include <trace/events/migrate.h>
 
-#include "internal.h"
-
 static struct kmem_cache *anon_vma_cachep;
 static struct kmem_cache *anon_vma_chain_cachep;
 
diff --git a/mm/swap.c b/mm/swap.c
index da08c918cef4..98897171adaf 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -156,29 +156,6 @@ static void lru_add(struct lruvec *lruvec, struct folio *folio)
 	trace_mm_lru_insertion(folio);
 }
 
-/**
- * folio_batch_add() - Add a folio to a batch.
- * @fbatch: The folio batch.
- * @folio: The folio to add.
- *
- * The folio is added to the end of the batch.
- * The batch must have previously been initialised using folio_batch_init().
- *
- * Return: The number of slots still available.
- */
-unsigned int folio_batch_add(struct folio_batch *fbatch,
-			     struct folio *folio)
-{
-	unsigned int ret;
-
-	fbatch->folios[fbatch->nr++] = folio;
-	ret = folio_batch_space(fbatch);
-	isolated_task_work_queue();
-
-	return ret;
-}
-EXPORT_SYMBOL(folio_batch_add);
-
 static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 {
 	int i;
@@ -215,7 +192,7 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 	else
 		local_lock(&cpu_fbatches.lock);
 
-	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) || folio_test_large(folio) ||
+	if (!folio_batch_add_lru(this_cpu_ptr(fbatch), folio) || folio_test_large(folio) ||
 	    lru_cache_disabled())
 		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ab986dd09b6a..b3a28e353b7e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -44,12 +44,12 @@
 #include <asm/shmparam.h>
 #include <linux/page_owner.h>
 
-#define CREATE_TRACE_POINTS
-#include <trace/events/vmalloc.h>
-
 #include "internal.h"
 #include "pgalloc-track.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/vmalloc.h>
+
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 static unsigned int __ro_after_init ioremap_max_page_shift = BITS_PER_LONG - 1;
 
-- 
2.50.1


 


