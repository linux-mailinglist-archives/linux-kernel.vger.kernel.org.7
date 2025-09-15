Return-Path: <linux-kernel+bounces-817121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7D8B57E32
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B582A1EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD4B30F543;
	Mon, 15 Sep 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U/aOyTJI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/yrH6ds7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U/aOyTJI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/yrH6ds7"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200AD30DEDE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944519; cv=none; b=H7JJXir4nINu4drILF5182x099Yad6SzyVvXxlV9NTy+BkURGLFSh1ukohozpiduw7u9sXc0Mq+5RdlOGdAs8Lw/hK+t0Ozb/YQrPSva89g/IyJUOVUBjQm3MVf14W5qs5vJlnMe+RxYH2aBKOhhDLxr3lC58KUKoGRznWmGDww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944519; c=relaxed/simple;
	bh=nC2l1AVwnnn4sM7J9x2F2Oqttd3HygqlYWCnMO2r/d4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pC1DsM2ylo3dIeUJdNe79PMpvOuadAnPHxR5nr2Bzx5VfR/O7tZRjYgNDzQKQC7X/9G7eTUtrCrZT7LWe1r/h32vQ6sGz1JyXQ7wK4tJwQXCQ8FNhzqFJ61cmyog2hz7lMeQSKgQML4sOH3No9+GgECW3pbjNZWoBGj8dflBp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U/aOyTJI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/yrH6ds7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U/aOyTJI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/yrH6ds7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C7791FB5D;
	Mon, 15 Sep 2025 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757944510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sp7wX8LAIXoZv2g9Und0rpOnfEG/AgSUWiifNHh6/Uk=;
	b=U/aOyTJI6mxu4J16SBnq/1byPaGnjFtJsTlF2NhS3H4xcEqUbM8FkYVH2RtVqcVzoX10mW
	12tJji+v2+yQzx08Gra5MkZaiFqX+/C9GTExEuk/kNk6OBhXngqJr6pX8/hPa9hLmJa9wW
	is9SXYO/2EsE5xZKaRCJ5Qxyil6yfTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757944510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sp7wX8LAIXoZv2g9Und0rpOnfEG/AgSUWiifNHh6/Uk=;
	b=/yrH6ds7EBlnmdP5IBLvOaCOWGPjtPBTN2rF1GRimxvA2gpsTm08ynSqzZYg8gCybmVaBB
	4jHIdlXjJEYcG4Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757944510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sp7wX8LAIXoZv2g9Und0rpOnfEG/AgSUWiifNHh6/Uk=;
	b=U/aOyTJI6mxu4J16SBnq/1byPaGnjFtJsTlF2NhS3H4xcEqUbM8FkYVH2RtVqcVzoX10mW
	12tJji+v2+yQzx08Gra5MkZaiFqX+/C9GTExEuk/kNk6OBhXngqJr6pX8/hPa9hLmJa9wW
	is9SXYO/2EsE5xZKaRCJ5Qxyil6yfTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757944510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sp7wX8LAIXoZv2g9Und0rpOnfEG/AgSUWiifNHh6/Uk=;
	b=/yrH6ds7EBlnmdP5IBLvOaCOWGPjtPBTN2rF1GRimxvA2gpsTm08ynSqzZYg8gCybmVaBB
	4jHIdlXjJEYcG4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56FCB13AB2;
	Mon, 15 Sep 2025 13:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sFT6FL4ayGhnVgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 15 Sep 2025 13:55:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 15 Sep 2025 15:55:10 +0200
Subject: [PATCH v2 3/6] slab: move validate_slab_ptr() from check_slab() to
 its callers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-slub-slab-validation-v2-3-314690fc1532@suse.cz>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

We will want to do the validation earlier in some callers or remove it
completely, so extract it from check_slab() first. No functional change.

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 75e4388d507d1abcbce8c7d5d2581381de46cf4d..6fb24010c17019ed304b4ef61f402212dd634efb 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1458,15 +1458,15 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 	return ret;
 }
 
+/*
+ * Checks if the slab state looks sane. Assumes the struct slab pointer
+ * was either obtained in a way that ensures it's valid, or validated
+ * by validate_slab_ptr()
+ */
 static int check_slab(struct kmem_cache *s, struct slab *slab)
 {
 	int maxobj;
 
-	if (!validate_slab_ptr(slab)) {
-		slab_err(s, slab, "Not a valid slab page");
-		return 0;
-	}
-
 	maxobj = order_objects(slab_order(slab), s->size);
 	if (slab->objects > maxobj) {
 		slab_err(s, slab, "objects %u > max %u",
@@ -1633,6 +1633,11 @@ void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr)
 static inline int alloc_consistency_checks(struct kmem_cache *s,
 					struct slab *slab, void *object)
 {
+	if (!validate_slab_ptr(slab)) {
+		slab_err(s, slab, "Not a valid slab page");
+		return 0;
+	}
+
 	if (!check_slab(s, slab))
 		return 0;
 
@@ -3485,6 +3490,11 @@ static inline bool free_debug_processing(struct kmem_cache *s,
 	int cnt = 0;
 
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
+		if (!validate_slab_ptr(slab)) {
+			slab_err(s, slab, "Not a valid slab page");
+			goto out;
+		}
+
 		if (!check_slab(s, slab))
 			goto out;
 	}
@@ -6519,6 +6529,11 @@ static void validate_slab(struct kmem_cache *s, struct slab *slab,
 	void *p;
 	void *addr = slab_address(slab);
 
+	if (!validate_slab_ptr(slab)) {
+		slab_err(s, slab, "Not a valid slab page");
+		return;
+	}
+
 	if (!check_slab(s, slab) || !on_freelist(s, slab, NULL))
 		return;
 

-- 
2.51.0


