Return-Path: <linux-kernel+bounces-817124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C022B57E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C6C3AD8ED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E924430CD98;
	Mon, 15 Sep 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TBB0SvGp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F3t0KNuU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TBB0SvGp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F3t0KNuU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8351F7910
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944527; cv=none; b=mZnnQR21yLcbyMFRNADvJKR4J/4KmkC1n1veWkbagrnSa0D4iRmyiuzGgoqocukeQ0sKyMlwNk5lEk8NlrWIiUa24QEyuoIkpoe/UO+fg23qOfrfsk71XW2CI8GuAKtoYM7bA/wo97lZ1X4Aqzm97uGghsj38MvOVFja3jbS308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944527; c=relaxed/simple;
	bh=yx9swKlEE32j5EGHX98aO4cFPrOX/4B2PJCvxwa1uU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ljg8MR0A79UraMPLVqsYNwMhq1Zbb3uWMuUDYoDOwdGytaXtdWmhO8eCpuIkcBlwiz9yMru3hOsc5GGaDViV5oLcxBHpl2FM17MFEP7g1Qu5MEQZ6aUtmD+IKadkw7tdBW4evoTWMAit4HbFLCDn9Jrdq9Wff7DluCoyh2nWVdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TBB0SvGp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F3t0KNuU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TBB0SvGp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F3t0KNuU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A5253373F;
	Mon, 15 Sep 2025 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757944510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aFYCuHm05s73tMXYFeBnQKfhnxCSiN8/Pi6EDb3yRQ=;
	b=TBB0SvGprSGr7Hp+nsaLYIP/LhraF6DmpBLL7FcPjr3SGa+RfMhT+olWwvqPyo5VqJM4RY
	bVk90WcY4QDIytc7Gx+oI7ALh0Lb5tPUVcTefMk5bBTiEZw9PYOhh2bAKCZ+S+UMX1kkHX
	IZVj55dEr98aGBcIaUMW8ALgEm+SmCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757944510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aFYCuHm05s73tMXYFeBnQKfhnxCSiN8/Pi6EDb3yRQ=;
	b=F3t0KNuUsvKacjdIp1+wuU530xZy7vYnSiQtPx7FAjudLq/0JFanw/HYHxROGDYlrQMA4x
	/f8HlOL1acJp9TAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757944510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aFYCuHm05s73tMXYFeBnQKfhnxCSiN8/Pi6EDb3yRQ=;
	b=TBB0SvGprSGr7Hp+nsaLYIP/LhraF6DmpBLL7FcPjr3SGa+RfMhT+olWwvqPyo5VqJM4RY
	bVk90WcY4QDIytc7Gx+oI7ALh0Lb5tPUVcTefMk5bBTiEZw9PYOhh2bAKCZ+S+UMX1kkHX
	IZVj55dEr98aGBcIaUMW8ALgEm+SmCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757944510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3aFYCuHm05s73tMXYFeBnQKfhnxCSiN8/Pi6EDb3yRQ=;
	b=F3t0KNuUsvKacjdIp1+wuU530xZy7vYnSiQtPx7FAjudLq/0JFanw/HYHxROGDYlrQMA4x
	/f8HlOL1acJp9TAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7567313ADB;
	Mon, 15 Sep 2025 13:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6FZZHL4ayGhnVgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 15 Sep 2025 13:55:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 15 Sep 2025 15:55:12 +0200
Subject: [PATCH v2 5/6] slab: validate slab before using it in
 alloc_single_from_partial()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-slub-slab-validation-v2-5-314690fc1532@suse.cz>
References: <20250915-slub-slab-validation-v2-0-314690fc1532@suse.cz>
In-Reply-To: <20250915-slub-slab-validation-v2-0-314690fc1532@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Harry Yoo <harry.yoo@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

We touch slab->freelist and slab->inuse before checking the slab pointer
is actually sane. Do that validation first, which will be safer. We can
thus also remove the check from alloc_debug_processing().

This adds a new "s->flags & SLAB_CONSISTENCY_CHECKS" test but
alloc_single_from_partial() is only called for caches with debugging
enabled so it's acceptable.

In alloc_single_from_new_slab() we just created the struct slab and call
alloc_debug_processing() to mainly set up redzones, tracking etc, while
not really expecting the consistency checks to fail. Thus don't validate
it there.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 12ad42f3d2e066b02340f2c30a85422583af3c5d..e5b53d1debddd3fe0f941f579a1043a5b976e50b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -821,6 +821,8 @@ static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
 	return *(unsigned int *)p;
 }
 
+#ifdef CONFIG_SLUB_DEBUG
+
 /*
  * For debugging context when we want to check if the struct slab pointer
  * appears to be valid.
@@ -830,7 +832,6 @@ static inline bool validate_slab_ptr(struct slab *slab)
 	return PageSlab(slab_page(slab));
 }
 
-#ifdef CONFIG_SLUB_DEBUG
 static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
 static DEFINE_SPINLOCK(object_map_lock);
 
@@ -1651,11 +1652,6 @@ static noinline bool alloc_debug_processing(struct kmem_cache *s,
 			struct slab *slab, void *object, int orig_size)
 {
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
-		if (!validate_slab_ptr(slab)) {
-			slab_err(s, slab, "Not a valid slab page");
-			return false;
-		}
-
 		if (!alloc_consistency_checks(s, slab, object))
 			goto bad;
 	}
@@ -2825,13 +2821,21 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
 
 	lockdep_assert_held(&n->list_lock);
 
+#ifdef SLUB_DEBUG
+	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
+		if (!validate_slab_ptr(slab)) {
+			slab_err(s, slab, "Not a valid slab page");
+			return NULL;
+		}
+	}
+#endif
+
 	object = slab->freelist;
 	slab->freelist = get_freepointer(s, object);
 	slab->inuse++;
 
 	if (!alloc_debug_processing(s, slab, object, orig_size)) {
-		if (validate_slab_ptr(slab))
-			remove_partial(n, slab);
+		remove_partial(n, slab);
 		return NULL;
 	}
 

-- 
2.51.0


