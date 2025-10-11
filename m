Return-Path: <linux-kernel+bounces-849078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1403BCF28D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4CDD334CD07
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3C01F63FF;
	Sat, 11 Oct 2025 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AIKQhx7c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4wrBLIUc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AIKQhx7c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4wrBLIUc"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE045190664
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760172367; cv=none; b=KvmufLaKFj5p/23CIB8y05EExVZyub5hT42ow2i4VuKWoIqXhxf6jkPjqtLZr1tRGnBeqIN85o683uHAadKEB3Y4f9zPzpKxlmS2ifJTXOSTANf+Qj33Fwen+dpf8xzGkka/PW8lYC35VUd6xIgXPR8wfjnP8wrkTJpUbQPoXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760172367; c=relaxed/simple;
	bh=eSKr9IBJV+Ys3CLgeRLf2XJ08eOImR5qejaCPGUWui4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r2zvjoNGd8wbfGT7NwgrZ108NXOAFm0idRVzse7PnCVv+gFZbPGFFs3UtAHuVDRIfXCXZWx6FOTSenRfdYW2ygDb/zrsvEKtS9DZUUu3cbhdoRc5QX1Tq/j7bN/JGFNoT1gjTaMvz66BARysIZkNdfLAIB0oaUwJjiErTddc434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AIKQhx7c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4wrBLIUc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AIKQhx7c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4wrBLIUc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2ABA62121D;
	Sat, 11 Oct 2025 08:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760172353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RkiZAPfAoO2k8f8DYL/BSYfMmFd/L7etyt17voz3Rtk=;
	b=AIKQhx7ckTirsOU68KWn8yDe/eyEsVqHI6ChyldowkisZjFAxTF6Pg76zl1glZpuMv3FyZ
	t5XHF6+g8+GZTueYrUrRUZlQyYkfHWo+wM9zL4AdiyEXwkzVC1NUQNSKOp5u+D136P0W8S
	k1EsTY/sPuXpcrLyFzE1+HAUZtCSGYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760172353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RkiZAPfAoO2k8f8DYL/BSYfMmFd/L7etyt17voz3Rtk=;
	b=4wrBLIUcznfnH8+pKudmkb4vvtjo4Bam8x+1V+NIPjOB7Rcr6FatG6tKsxJJmvVVpCvErx
	3bkxYcoAY1P5hQBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760172353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RkiZAPfAoO2k8f8DYL/BSYfMmFd/L7etyt17voz3Rtk=;
	b=AIKQhx7ckTirsOU68KWn8yDe/eyEsVqHI6ChyldowkisZjFAxTF6Pg76zl1glZpuMv3FyZ
	t5XHF6+g8+GZTueYrUrRUZlQyYkfHWo+wM9zL4AdiyEXwkzVC1NUQNSKOp5u+D136P0W8S
	k1EsTY/sPuXpcrLyFzE1+HAUZtCSGYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760172353;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RkiZAPfAoO2k8f8DYL/BSYfMmFd/L7etyt17voz3Rtk=;
	b=4wrBLIUcznfnH8+pKudmkb4vvtjo4Bam8x+1V+NIPjOB7Rcr6FatG6tKsxJJmvVVpCvErx
	3bkxYcoAY1P5hQBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1585C13693;
	Sat, 11 Oct 2025 08:45:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QI/kBEEZ6mi3CgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sat, 11 Oct 2025 08:45:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Sat, 11 Oct 2025 10:45:41 +0200
Subject: [PATCH] slab: fix barn NULL pointer dereference on memoryless
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-null-barn-fix-v1-1-5fe5af5b8fd8@suse.cz>
X-B4-Tracking: v=1; b=H4sIADQZ6mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0ND3bzSnBzdpMSiPN20zArdRGNzM1MLM6MUgzQTJaCegqJUoDDYvOj
 Y2loArihwS18AAAA=
X-Change-ID: 20251011-null-barn-fix-a3765862d0f4
To: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
 Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Phil Auld <pauld@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11153; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=eSKr9IBJV+Ys3CLgeRLf2XJ08eOImR5qejaCPGUWui4=;
 b=owGbwMvMwMG4+8GG0kuuHbMYT6slMWS8krT5sVz+13z/Wk6DckWv1p+JzQ8/3Jva9EbNOb93p
 5Lxt+ryTkZ/FgZGDgZLMUWW6t0nHEVnKntM8/D9CDOIlQlkirRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrqAJkMXJwCMNUTGtj/ynMummQ1z/Ssqmq59HLv76Ki2t5fFPduuKaSOpfrnvq5hDcefNl3Lqd
 +PlZ6bLnfQwvPWO1nZ/kK3MWPbFCfcT955UO9Od0cEzwP/dMtfvr50QT25bv63/om/BJ5fPzwU7
 f3T8Pbas08r1zvln52e7+mgn3dfaeXiztXbXnyZuEj9/3VjZmxfN2TbaZvDNdM1Wy/3bczwzng3
 MzXLBnmT7tdZrLKZKo9/pvc7aHRPPPLjHJVbrYPiyedVa272ceqVq2SomNd/VI56OWHK1/mnM9s
 /v7wzuslHeLfjuhOPeqWqV7pGOolVZB1aMb8lc63Ps53nHZx2wUeZbeVHe7se9ivnQ7w+SYl62y
 7oOKfJgA=
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

Phil reported a boot failure once sheaves become used in commits
59faa4da7cd4 ("maple_tree: use percpu sheaves for maple_node_cache") and
3accabda4da1 ("mm, vma: use percpu sheaves for vm_area_struct cache"):

 BUG: kernel NULL pointer dereference, address: 0000000000000040
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP NOPTI
 CPU: 21 UID: 0 PID: 818 Comm: kworker/u398:0 Not tainted 6.17.0-rc3.slab+ #5 PREEMPT(voluntary)
 Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.26.0 07/30/2025
 RIP: 0010:__pcs_replace_empty_main+0x44/0x1d0
 Code: ec 08 48 8b 46 10 48 8b 76 08 48 85 c0 74 0b 8b 48 18 85 c9 0f 85 e5 00 00 00 65 48 63 05 e4 ee 50 02 49 8b 84 c6 e0 00 00 00 <4c> 8b 68 40 4c 89 ef e8 b0 81 ff ff 48 89 c5 48 85 c0 74 1d 48 89
 RSP: 0018:ffffd2d10950bdb0 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff8a775dab74b0 RCX: 00000000ffffffff
 RDX: 0000000000000cc0 RSI: ffff8a6800804000 RDI: ffff8a680004e300
 RBP: ffffd2d10950be40 R08: 0000000000000060 R09: ffffffffb9367388
 R10: 00000000000149e8 R11: ffff8a6f87a38000 R12: 0000000000000cc0
 R13: 0000000000000cc0 R14: ffff8a680004e300 R15: 00000000000000c0
 FS:  0000000000000000(0000) GS:ffff8a77a3541000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000040 CR3: 0000000e1aa24000 CR4: 00000000003506f0
 Call Trace:
  <TASK>
  ? srso_return_thunk+0x5/0x5f
  ? vm_area_alloc+0x1e/0x60
  kmem_cache_alloc_noprof+0x4ec/0x5b0
  vm_area_alloc+0x1e/0x60
  create_init_stack_vma+0x26/0x210
  alloc_bprm+0x139/0x200
  kernel_execve+0x4a/0x140
  call_usermodehelper_exec_async+0xd0/0x190
  ? __pfx_call_usermodehelper_exec_async+0x10/0x10
  ret_from_fork+0xf0/0x110
  ? __pfx_call_usermodehelper_exec_async+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Modules linked in:
 CR2: 0000000000000040
 ---[ end trace 0000000000000000 ]---
 RIP: 0010:__pcs_replace_empty_main+0x44/0x1d0
 Code: ec 08 48 8b 46 10 48 8b 76 08 48 85 c0 74 0b 8b 48 18 85 c9 0f 85 e5 00 00 00 65 48 63 05 e4 ee 50 02 49 8b 84 c6 e0 00 00 00 <4c> 8b 68 40 4c 89 ef e8 b0 81 ff ff 48 89 c5 48 85 c0 74 1d 48 89
 RSP: 0018:ffffd2d10950bdb0 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: ffff8a775dab74b0 RCX: 00000000ffffffff
 RDX: 0000000000000cc0 RSI: ffff8a6800804000 RDI: ffff8a680004e300
 RBP: ffffd2d10950be40 R08: 0000000000000060 R09: ffffffffb9367388
 R10: 00000000000149e8 R11: ffff8a6f87a38000 R12: 0000000000000cc0
 R13: 0000000000000cc0 R14: ffff8a680004e300 R15: 00000000000000c0
 FS:  0000000000000000(0000) GS:ffff8a77a3541000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000040 CR3: 0000000e1aa24000 CR4: 00000000003506f0
 Kernel panic - not syncing: Fatal exception
 Kernel Offset: 0x36a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: Fatal exception ]---

And noted "this is an AMD EPYC 7401 with 8 NUMA nodes configured such
that memory is only on 2 of them."

 # numactl --hardware
 available: 8 nodes (0-7)
 node 0 cpus: 0 8 16 24 32 40 48 56 64 72 80 88
 node 0 size: 0 MB
 node 0 free: 0 MB
 node 1 cpus: 2 10 18 26 34 42 50 58 66 74 82 90
 node 1 size: 31584 MB
 node 1 free: 30397 MB
 node 2 cpus: 4 12 20 28 36 44 52 60 68 76 84 92
 node 2 size: 0 MB
 node 2 free: 0 MB
 node 3 cpus: 6 14 22 30 38 46 54 62 70 78 86 94
 node 3 size: 0 MB
 node 3 free: 0 MB
 node 4 cpus: 1 9 17 25 33 41 49 57 65 73 81 89
 node 4 size: 0 MB
 node 4 free: 0 MB
 node 5 cpus: 3 11 19 27 35 43 51 59 67 75 83 91
 node 5 size: 32214 MB
 node 5 free: 31625 MB
 node 6 cpus: 5 13 21 29 37 45 53 61 69 77 85 93
 node 6 size: 0 MB
 node 6 free: 0 MB
 node 7 cpus: 7 15 23 31 39 47 55 63 71 79 87 95
 node 7 size: 0 MB
 node 7 free: 0 MB

Linus decoded the stacktrace to get_barn() and get_node() and determined
that kmem_cache->node[numa_mem_id()] is NULL.

The problem is due to a wrong assumption that memoryless nodes only
exist on systems with CONFIG_HAVE_MEMORYLESS_NODES, where numa_mem_id()
points to the nearest node that has memory. SLUB has been allocating its
kmem_cache_node structures only on nodes with memory and so it does with
struct node_barn.

For kmem_cache_node, get_partial_node() checks if get_node() result is
not NULL, which I assumed was for protection from a bogus node id passed
to kmalloc_node() but apparently it's also for systems where
numa_mem_id() (used when no specific node is given) might return a
memoryless node.

Fix the sheaves code the same way by checking the result of get_node()
and bailing out if it's NULL. Note that cpus on such memoryless nodes
will have degraded sheaves performance, which can be improved later,
preferably by making numa_mem_id() work properly on such systems.

Fixes: 2d517aa09bbc ("slab: add opt-in caching layer of percpu sheaves")
Reported-and-tested-by: Phil Auld <pauld@redhat.com>
Closes: https://lore.kernel.org/all/20251010151116.GA436967@pauld.westford.csb/
Analyzed-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/CAHk-%3Dwg1xK%2BBr%3DFJ5QipVhzCvq7uQVPt5Prze6HDhQQ%3DQD_BcQ@mail.gmail.com/
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 135c408e0515..b1f15598fbfd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -504,10 +504,18 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
 	return s->node[node];
 }
 
-/* Get the barn of the current cpu's memory node */
+/*
+ * Get the barn of the current cpu's closest memory node. It may not exist on
+ * systems with memoryless nodes but without CONFIG_HAVE_MEMORYLESS_NODES
+ */
 static inline struct node_barn *get_barn(struct kmem_cache *s)
 {
-	return get_node(s, numa_mem_id())->barn;
+	struct kmem_cache_node *n = get_node(s, numa_mem_id());
+
+	if (!n)
+		return NULL;
+
+	return n->barn;
 }
 
 /*
@@ -4982,6 +4990,10 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 	}
 
 	barn = get_barn(s);
+	if (!barn) {
+		local_unlock(&s->cpu_sheaves->lock);
+		return NULL;
+	}
 
 	full = barn_replace_empty_sheaf(barn, pcs->main);
 
@@ -5153,13 +5165,20 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	if (unlikely(pcs->main->size == 0)) {
 
 		struct slab_sheaf *full;
+		struct node_barn *barn;
 
 		if (pcs->spare && pcs->spare->size > 0) {
 			swap(pcs->main, pcs->spare);
 			goto do_alloc;
 		}
 
-		full = barn_replace_empty_sheaf(get_barn(s), pcs->main);
+		barn = get_barn(s);
+		if (!barn) {
+			local_unlock(&s->cpu_sheaves->lock);
+			return allocated;
+		}
+
+		full = barn_replace_empty_sheaf(barn, pcs->main);
 
 		if (full) {
 			stat(s, BARN_GET);
@@ -5314,6 +5333,7 @@ kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *sheaf = NULL;
+	struct node_barn *barn;
 
 	if (unlikely(size > s->sheaf_capacity)) {
 
@@ -5355,8 +5375,11 @@ kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
 		pcs->spare = NULL;
 		stat(s, SHEAF_PREFILL_FAST);
 	} else {
+		barn = get_barn(s);
+
 		stat(s, SHEAF_PREFILL_SLOW);
-		sheaf = barn_get_full_or_empty_sheaf(get_barn(s));
+		if (barn)
+			sheaf = barn_get_full_or_empty_sheaf(barn);
 		if (sheaf && sheaf->size)
 			stat(s, BARN_GET);
 		else
@@ -5426,7 +5449,7 @@ void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
 	 * If the barn has too many full sheaves or we fail to refill the sheaf,
 	 * simply flush and free it.
 	 */
-	if (data_race(barn->nr_full) >= MAX_FULL_SHEAVES ||
+	if (!barn || data_race(barn->nr_full) >= MAX_FULL_SHEAVES ||
 	    refill_sheaf(s, sheaf, gfp)) {
 		sheaf_flush_unused(s, sheaf);
 		free_empty_sheaf(s, sheaf);
@@ -5943,10 +5966,9 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
  * put the full sheaf there.
  */
 static void __pcs_install_empty_sheaf(struct kmem_cache *s,
-		struct slub_percpu_sheaves *pcs, struct slab_sheaf *empty)
+		struct slub_percpu_sheaves *pcs, struct slab_sheaf *empty,
+		struct node_barn *barn)
 {
-	struct node_barn *barn;
-
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
 	/* This is what we expect to find if nobody interrupted us. */
@@ -5956,8 +5978,6 @@ static void __pcs_install_empty_sheaf(struct kmem_cache *s,
 		return;
 	}
 
-	barn = get_barn(s);
-
 	/*
 	 * Unlikely because if the main sheaf had space, we would have just
 	 * freed to it. Get rid of our empty sheaf.
@@ -6002,6 +6022,11 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
 	barn = get_barn(s);
+	if (!barn) {
+		local_unlock(&s->cpu_sheaves->lock);
+		return NULL;
+	}
+
 	put_fail = false;
 
 	if (!pcs->spare) {
@@ -6084,7 +6109,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
 	}
 
 	pcs = this_cpu_ptr(s->cpu_sheaves);
-	__pcs_install_empty_sheaf(s, pcs, empty);
+	__pcs_install_empty_sheaf(s, pcs, empty, barn);
 
 	return pcs;
 }
@@ -6121,8 +6146,9 @@ bool free_to_pcs(struct kmem_cache *s, void *object)
 
 static void rcu_free_sheaf(struct rcu_head *head)
 {
+	struct kmem_cache_node *n;
 	struct slab_sheaf *sheaf;
-	struct node_barn *barn;
+	struct node_barn *barn = NULL;
 	struct kmem_cache *s;
 
 	sheaf = container_of(head, struct slab_sheaf, rcu_head);
@@ -6139,7 +6165,11 @@ static void rcu_free_sheaf(struct rcu_head *head)
 	 */
 	__rcu_free_sheaf_prepare(s, sheaf);
 
-	barn = get_node(s, sheaf->node)->barn;
+	n = get_node(s, sheaf->node);
+	if (!n)
+		goto flush;
+
+	barn = n->barn;
 
 	/* due to slab_free_hook() */
 	if (unlikely(sheaf->size == 0))
@@ -6157,11 +6187,12 @@ static void rcu_free_sheaf(struct rcu_head *head)
 		return;
 	}
 
+flush:
 	stat(s, BARN_PUT_FAIL);
 	sheaf_flush_unused(s, sheaf);
 
 empty:
-	if (data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES) {
+	if (barn && data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES) {
 		barn_put_empty_sheaf(barn, sheaf);
 		return;
 	}
@@ -6191,6 +6222,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 		}
 
 		barn = get_barn(s);
+		if (!barn) {
+			local_unlock(&s->cpu_sheaves->lock);
+			goto fail;
+		}
 
 		empty = barn_get_empty_sheaf(barn);
 
@@ -6304,6 +6339,8 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 		goto do_free;
 
 	barn = get_barn(s);
+	if (!barn)
+		goto no_empty;
 
 	if (!pcs->spare) {
 		empty = barn_get_empty_sheaf(barn);

---
base-commit: f76b1683d16dcd5299a9b67d8ef45fe8d29cb2e6
change-id: 20251011-null-barn-fix-a3765862d0f4

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


