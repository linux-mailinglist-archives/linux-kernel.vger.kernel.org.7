Return-Path: <linux-kernel+bounces-812574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B10FB539DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374E7A01018
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA6C369967;
	Thu, 11 Sep 2025 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="caB69UBa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eciko9ma";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="caB69UBa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eciko9ma"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602E022AE45
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610173; cv=none; b=N/JXjoHhNsEf0enKL/oX7N5XLbI9tHRKzc9mIeX8FlwxUQpITvpBjysfVebBE5YEshV1GBYl21vY6XDzs2/94tNQn0r2HhiUIoUb18mkKK8wAdga/ptnYi5NFZDPp3iTVmJz4TWqVHJyXbnSSeAAdqKtzEgfEOpXKinY2lPCXYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610173; c=relaxed/simple;
	bh=6tkeaTNyRm1SBHJQKgvKFHCqSVqtEzkC5yHycaSB9t0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hkoi4tH95p4mp13Hv8gXgdOKmazR5mFW95Q1Swp4wgfP1N2h5L5eKZHP+vnNlTpptUJmmkvcjwxZr4Fwi1r5WoYW7x5Cm+9q5yU5VYWaKUTfGl+X+oujW3ry2qHwJh4MarfO1hu+qkDYEm5Xq3YOyKJnBEX7facpro2Fa3FiFAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=caB69UBa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eciko9ma; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=caB69UBa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eciko9ma; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 11BE47647F;
	Thu, 11 Sep 2025 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757610155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRP07fiR2IX4gxo9ENuoZTQhuQ0mAms5suV1861+oXk=;
	b=caB69UBaTbJw0cyHbpwNyhsojWzldNenRQf7IxQxYYwsRwFbZdTbBFqmXnGnAGylbG5XUg
	I5a6YRc/oyJW8A5J8RVQ776dTKd4NHj4ur+OL0++IZVMvjqcxkOoHUX9zRiuO8du7yXG5E
	HxvVaXgq4LODJ7BLPbAebZN/vGYVRTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757610155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRP07fiR2IX4gxo9ENuoZTQhuQ0mAms5suV1861+oXk=;
	b=eciko9ma7alFW2z3yd0wB6yiSLgj3Fo+mGOYT5Imo3INWV5tQGVmCZaGV+oajdOCArOO+C
	Kot8xIChGaREOEAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757610155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRP07fiR2IX4gxo9ENuoZTQhuQ0mAms5suV1861+oXk=;
	b=caB69UBaTbJw0cyHbpwNyhsojWzldNenRQf7IxQxYYwsRwFbZdTbBFqmXnGnAGylbG5XUg
	I5a6YRc/oyJW8A5J8RVQ776dTKd4NHj4ur+OL0++IZVMvjqcxkOoHUX9zRiuO8du7yXG5E
	HxvVaXgq4LODJ7BLPbAebZN/vGYVRTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757610155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRP07fiR2IX4gxo9ENuoZTQhuQ0mAms5suV1861+oXk=;
	b=eciko9ma7alFW2z3yd0wB6yiSLgj3Fo+mGOYT5Imo3INWV5tQGVmCZaGV+oajdOCArOO+C
	Kot8xIChGaREOEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0C5C13AD6;
	Thu, 11 Sep 2025 17:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ECiDOqoAw2gUJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 11 Sep 2025 17:02:34 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 11 Sep 2025 19:02:35 +0200
Subject: [PATCH 2/6] slab: wrap debug slab validation in
 validate_slab_ptr()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-slub-slab-validation-v1-2-8b67eb3b3dc5@suse.cz>
References: <20250911-slub-slab-validation-v1-0-8b67eb3b3dc5@suse.cz>
In-Reply-To: <20250911-slub-slab-validation-v1-0-8b67eb3b3dc5@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Harry Yoo <harry.yoo@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

This will make it clear where we currently cast struct slab to folio
only to check the slab type, and allow to change the implementation
later with memdesc conversion.

For now use a struct page based implementation instead of struct folio
to be compatible with further upcoming changes.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 56143bfd1ae319d384981c810a5ed84af00f4afa..5bbfe4ee8d9846ec9a34584c10750388849da3b9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -821,6 +821,15 @@ static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
 	return *(unsigned int *)p;
 }
 
+/*
+ * For debugging context when we want to check if the struct slab pointer
+ * appears to be valid.
+ */
+static bool validate_slab_ptr(struct slab *slab)
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


