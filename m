Return-Path: <linux-kernel+bounces-882854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E15CC2BB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E88FE4F5A61
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5E030EF64;
	Mon,  3 Nov 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o14NnLdn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mq4f+xmE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o14NnLdn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mq4f+xmE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940B630CDB6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172690; cv=none; b=gM8s6CtdTWbn3+lOGCAZAmf5zTmF5tJgmDdD+Ry+P7UZe3lb04b5HYaKrRc+U1pN4zzFdo4LpWbPQSOmaUHWWrxCzHDV206pT09vdFg3TdaMa6qGVnsV350T7TRatDdtmzuoB41+IfjS8tnzLy7lf85ywegXIceula1hjJdYuBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172690; c=relaxed/simple;
	bh=wQdnkU9hNx/O4Iwg0uQ2HzLaNraSVxoh2c1MXQVwov4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hQ4cwF/42Yna2dzPm1I0+gBRvB4IxwgnD34Hgbr6KEdPyPzlR0pB4H0Z8QnmjXQO1a8Kpqjma0zfgFrnlzDVu3xrQyRceFKYAjZq9uSgcBHZvV+BUHgmuHsN3gZ5DXoMVTfqWZlnUxvPbUh8Z0bDjyu+p3x4Z0pow/R64TTtPBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o14NnLdn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mq4f+xmE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o14NnLdn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mq4f+xmE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 959DA21AEF;
	Mon,  3 Nov 2025 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762172685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KeTeEG4nIfVPoLqtZ97rZ2qT6HDW8DCj4q3+dHrn6T4=;
	b=o14NnLdnAVsjOy91XWmxGYFTuSPv0bs/u1WOMDep7I6oNp8H2jdMPMiKYg14S4OnOnbRck
	oIorCN6CHKv6IE17DLsT23MKW9tkzPzVZVuFLAnfKW2Z6YEUIcWxEHuiYMvQvUFOifGoxv
	Se/tNlAIr4qi7kHuszt+r5ZMOplphI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762172685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KeTeEG4nIfVPoLqtZ97rZ2qT6HDW8DCj4q3+dHrn6T4=;
	b=Mq4f+xmEVxf/WJUXohVFol7JKlziud7xcsKC6v4UfMNxcPCN/LGTmFOQ2EAfnO3Cy1/PM0
	l4oxEzyVW2ZGfIBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=o14NnLdn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Mq4f+xmE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762172685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KeTeEG4nIfVPoLqtZ97rZ2qT6HDW8DCj4q3+dHrn6T4=;
	b=o14NnLdnAVsjOy91XWmxGYFTuSPv0bs/u1WOMDep7I6oNp8H2jdMPMiKYg14S4OnOnbRck
	oIorCN6CHKv6IE17DLsT23MKW9tkzPzVZVuFLAnfKW2Z6YEUIcWxEHuiYMvQvUFOifGoxv
	Se/tNlAIr4qi7kHuszt+r5ZMOplphI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762172685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KeTeEG4nIfVPoLqtZ97rZ2qT6HDW8DCj4q3+dHrn6T4=;
	b=Mq4f+xmEVxf/WJUXohVFol7JKlziud7xcsKC6v4UfMNxcPCN/LGTmFOQ2EAfnO3Cy1/PM0
	l4oxEzyVW2ZGfIBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CDC81364F;
	Mon,  3 Nov 2025 12:24:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BjdoHQ2fCGmOWQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 03 Nov 2025 12:24:45 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 03 Nov 2025 13:24:15 +0100
Subject: [PATCH] slab: prevent infinite loop in kmalloc_nolock() with
 debugging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-fix-nolock-loop-v1-1-6e2b3e82b9da@suse.cz>
X-B4-Tracking: v=1; b=H4sIAO6eCGkC/x2MSQqAMAwAv1JyNtDUFb8iHqRGDUojLYgg/t3ic
 WBmHkgchRP05oHIlyTRkIEKA36bwsooc2Zw1tVEtsRFbgx6qN/xUD2xqyu2ZKlp3QK5OiNn5T8
 O4/t+xNOKgmEAAAA=
X-Change-ID: 20251103-fix-nolock-loop-854e0101672f
To: Harry Yoo <harry.yoo@oracle.com>, Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1904; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=wQdnkU9hNx/O4Iwg0uQ2HzLaNraSVxoh2c1MXQVwov4=;
 b=owGbwMvMwMG4+8GG0kuuHbMYT6slMWRyzPuadbBx5/ulLL5bhM5remqunmjx3N2uOuDJLw7R9
 N3nir+2djL6szAwcjBYiimyVO8+4Sg6U9ljmofvR5hBrEwgU6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BQB8hk4OIUgKnmF2T/K+dpcSq46m6IiEnI+wwVy06xpIWzpnWZRL6f5ba1TsF1a/HXtMR1F9c
 Wf/LqN0vPPdhmeyDEO7a38d6HaTvaFUpf/ZmWFeX5/qmaA58Y92O/aLXlM5OunbP+7XTu41cvvT
 NhooU5m+3nT7pdO+351nSv2OyLea/bfDjS0ovfr3TX+Lrkd02h8pwwjrkuEnHccxm3Ke5d8uzS2
 7CPNUZ13y68uay9rpTHuG2muvrcS9a3LbPMpJNuzwg1WDPtwMnUJzVhzRck9qq6L7KfI5b/Xcr5
 4rHW0jnrXPb1PWfvflHJ9ExKp+mGVZvMqVtBf+K1q98KXNwfKROwYoleYNmUp1ezvf4aZLBaz1j
 7WTURAA==
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Rspamd-Queue-Id: 959DA21AEF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

In review of a followup work, Harry noticed a potential infinite loop.
Upon closed inspection, it already exists for kmalloc_nolock() on a
cache with debugging enabled, since commit af92793e52c3 ("slab:
Introduce kmalloc_nolock() and kfree_nolock().")

When alloc_single_from_new_slab() fails to trylock node list_lock, we
keep retrying to get partial slab or allocate a new slab. If we indeed
interrupted somebody holding the list_lock, the trylock fill fail
deterministically and we end up allocating and defer-freeing slabs
indefinitely with no progress.

To fix it, fail the allocation if spinning is not allowed. This is
acceptable in the restricted context of kmalloc_nolock(), especially
with debugging enabled.

Reported-by: Harry Yoo <harry.yoo@oracle.com>
Closes: https://lore.kernel.org/all/aQLqZjjq1SPD3Fml@hyeyoo/
Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
as we discussed in the linked thread, 6.18 hotfix to be included in
slab/for-next-fixes
---
 mm/slub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index d4367f25b20d..f1a5373eee7b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4666,8 +4666,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (kmem_cache_debug(s)) {
 		freelist = alloc_single_from_new_slab(s, slab, orig_size, gfpflags);
 
-		if (unlikely(!freelist))
+		if (unlikely(!freelist)) {
+			/* This could cause an endless loop. Fail instead. */
+			if (!allow_spin)
+				return NULL;
 			goto new_objects;
+		}
 
 		if (s->flags & SLAB_STORE_USER)
 			set_track(s, freelist, TRACK_ALLOC, addr,

---
base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
change-id: 20251103-fix-nolock-loop-854e0101672f

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


