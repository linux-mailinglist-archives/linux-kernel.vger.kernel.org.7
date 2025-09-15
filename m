Return-Path: <linux-kernel+bounces-817118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CDEB57E35
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DFD73B7601
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A86231B130;
	Mon, 15 Sep 2025 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sMZHxzxT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZvB3dreT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sMZHxzxT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZvB3dreT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98930EF87
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944513; cv=none; b=jNZAWf2WAAspqsieXyDgfIh35ZrSBl+rZHHWt+v2BLCEXzLQCS1coV/3/VX6AvYxZu3XeNzZRNWyAFA8UKMAfmtMYrhQHKsA2NY6nkWy/ZBXnGe32/OEKEmyQYcQ0dkhzM8niwzCD9xhXSMliN35VGD7uI58sVcxAgIfpQ+bRS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944513; c=relaxed/simple;
	bh=BCJZmAr1Bx5V8/zojsYy7RlB6Vdaz+dZH0np5iUmmZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VrRnwyOZ6D6RYAuTGWGVuCAU0CJkFmpEeQWNvCxPTuSjjQ5hRtEofTwSR0Poq4G/eshZBClr065hzGlm0UzZyBjddEzr49hCO2YDQDbOwrGOaKWVP7PmTzx80w5ccVSRdlChQOpYJdCrbw9hQbZl6aJc0G5wCX+55vdGm1rWxkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sMZHxzxT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZvB3dreT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sMZHxzxT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZvB3dreT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C936336BF;
	Mon, 15 Sep 2025 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757944510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVmn++9xJB9GpxveASuMULaQTKTMrSj+26tW8lFK6LI=;
	b=sMZHxzxT/K4//pDSK5b0FvXDxnPAklwI8Jqhin6x4U/N00Wp1kKG6NHeIjRISYSrMLuDkW
	3heY/FBZ+ksOrq1k1wAo+ByP6DVNJay6TR4bJv+fpXtioNrp/RUNdnBpe3oORGWc6Ne3GQ
	UL6R5ZiPS6AcoLjDUEurUaQzg0aglOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757944510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVmn++9xJB9GpxveASuMULaQTKTMrSj+26tW8lFK6LI=;
	b=ZvB3dreTfm43G16xd6mRYRFIm3Ocd6F2n/Ls0ww1kbdrjpV/IO7uRpkxoFqbEJKBIbO3/z
	V5bfC1Qm/qMSsZBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sMZHxzxT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZvB3dreT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757944510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVmn++9xJB9GpxveASuMULaQTKTMrSj+26tW8lFK6LI=;
	b=sMZHxzxT/K4//pDSK5b0FvXDxnPAklwI8Jqhin6x4U/N00Wp1kKG6NHeIjRISYSrMLuDkW
	3heY/FBZ+ksOrq1k1wAo+ByP6DVNJay6TR4bJv+fpXtioNrp/RUNdnBpe3oORGWc6Ne3GQ
	UL6R5ZiPS6AcoLjDUEurUaQzg0aglOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757944510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVmn++9xJB9GpxveASuMULaQTKTMrSj+26tW8lFK6LI=;
	b=ZvB3dreTfm43G16xd6mRYRFIm3Ocd6F2n/Ls0ww1kbdrjpV/IO7uRpkxoFqbEJKBIbO3/z
	V5bfC1Qm/qMSsZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 483CB13A92;
	Mon, 15 Sep 2025 13:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wB9LEb4ayGhnVgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 15 Sep 2025 13:55:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 15 Sep 2025 15:55:09 +0200
Subject: [PATCH v2 2/6] slab: wrap debug slab validation in
 validate_slab_ptr()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-slub-slab-validation-v2-2-314690fc1532@suse.cz>
References: <20250915-slub-slab-validation-v2-0-314690fc1532@suse.cz>
In-Reply-To: <20250915-slub-slab-validation-v2-0-314690fc1532@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Harry Yoo <harry.yoo@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5C936336BF
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

This will make it clear where we currently cast struct slab to folio
only to check the slab type, and allow to change the implementation
later with memdesc conversion.

For now use a struct page based implementation instead of struct folio
to be compatible with further upcoming changes.

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 56143bfd1ae319d384981c810a5ed84af00f4afa..75e4388d507d1abcbce8c7d5d2581381de46cf4d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -821,6 +821,15 @@ static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
 	return *(unsigned int *)p;
 }
 
+/*
+ * For debugging context when we want to check if the struct slab pointer
+ * appears to be valid.
+ */
+static inline bool validate_slab_ptr(struct slab *slab)
+{
+	return PageSlab(slab_page(slab));
+}
+
 #ifdef CONFIG_SLUB_DEBUG
 static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
 static DEFINE_SPINLOCK(object_map_lock);
@@ -1453,7 +1462,7 @@ static int check_slab(struct kmem_cache *s, struct slab *slab)
 {
 	int maxobj;
 
-	if (!folio_test_slab(slab_folio(slab))) {
+	if (!validate_slab_ptr(slab)) {
 		slab_err(s, slab, "Not a valid slab page");
 		return 0;
 	}
@@ -1653,7 +1662,7 @@ static noinline bool alloc_debug_processing(struct kmem_cache *s,
 	return true;
 
 bad:
-	if (folio_test_slab(slab_folio(slab))) {
+	if (validate_slab_ptr(slab)) {
 		/*
 		 * If this is a slab page then lets do the best we can
 		 * to avoid issues in the future. Marking all objects
@@ -2818,7 +2827,7 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
 	slab->inuse++;
 
 	if (!alloc_debug_processing(s, slab, object, orig_size)) {
-		if (folio_test_slab(slab_folio(slab)))
+		if (validate_slab_ptr(slab))
 			remove_partial(n, slab);
 		return NULL;
 	}

-- 
2.51.0


