Return-Path: <linux-kernel+bounces-812575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E8EB539E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16D4168053
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630FA35FC27;
	Thu, 11 Sep 2025 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zqAMFcRd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SZN5HjVQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zqAMFcRd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SZN5HjVQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120B3362997
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610180; cv=none; b=I5Kn1KVF1Xzgpc4RrdeKlio3DrptBvRvHad+nphOnkXIem/T0PJ1F+KMfWko0H2yt3SFNcguY3x3XRXLC3GGE8WtzpU2eKqKSm22KdtDXHTsKciCmRgKAI2UTnKCg1vh79zj3TAA99rNUyUlOwS+jmHLpuxxfU0Pc8jPOSxFx5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610180; c=relaxed/simple;
	bh=u41jKkPeVaZ40Td3aPD6Zm+fSYateZo15susiF2ehm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CIkU8A7KrNTFdccd9f6aCAJyBqwlZyCt8vub8El4wdqN5FCHnYUT7EV/TMzvYtqM8a86SkXNWkc7pbfX7b9nruJNLxJts/x4XiIOb4y1jy1xrjs2dQR+V9An4Cbn1fnUiyEKObvFe5bJEXV6Jd8fQjtT9yhO8IWe+KP68YwKOHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zqAMFcRd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SZN5HjVQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zqAMFcRd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SZN5HjVQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 20C1576481;
	Thu, 11 Sep 2025 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757610155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6f2UzExln6BeKZDBJcPia3VoQR4i2uiv1uWrKQDThX8=;
	b=zqAMFcRd0T8/Twk0PQTF4F5+pW56BJRruI4CHexUjek9fqBJLHOK4y/l0Y8yelAOxclz6P
	i0qTDSOtItIRAyOg6JVE/j6p6EEimt7R12EP+1SWMRGxtgO6PkD16QF1MATavB8q+q3ST5
	Z407S5wPjh+yrN3hXruz1PAeL3UJxtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757610155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6f2UzExln6BeKZDBJcPia3VoQR4i2uiv1uWrKQDThX8=;
	b=SZN5HjVQH7I6DxWuH/saAoWkOzECfWBjOFnbm+SQlrLVpYfvKgag+zQHPNs4GM6Pnv7ipm
	G/yzbj9qb1zfkZAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zqAMFcRd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SZN5HjVQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757610155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6f2UzExln6BeKZDBJcPia3VoQR4i2uiv1uWrKQDThX8=;
	b=zqAMFcRd0T8/Twk0PQTF4F5+pW56BJRruI4CHexUjek9fqBJLHOK4y/l0Y8yelAOxclz6P
	i0qTDSOtItIRAyOg6JVE/j6p6EEimt7R12EP+1SWMRGxtgO6PkD16QF1MATavB8q+q3ST5
	Z407S5wPjh+yrN3hXruz1PAeL3UJxtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757610155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6f2UzExln6BeKZDBJcPia3VoQR4i2uiv1uWrKQDThX8=;
	b=SZN5HjVQH7I6DxWuH/saAoWkOzECfWBjOFnbm+SQlrLVpYfvKgag+zQHPNs4GM6Pnv7ipm
	G/yzbj9qb1zfkZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C87A13ADB;
	Thu, 11 Sep 2025 17:02:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0PHHAqsAw2gUJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 11 Sep 2025 17:02:35 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 11 Sep 2025 19:02:36 +0200
Subject: [PATCH 3/6] slab: move validate_slab_ptr() from check_slab() to
 its callers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-slub-slab-validation-v1-3-8b67eb3b3dc5@suse.cz>
References: <20250911-slub-slab-validation-v1-0-8b67eb3b3dc5@suse.cz>
In-Reply-To: <20250911-slub-slab-validation-v1-0-8b67eb3b3dc5@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Harry Yoo <harry.yoo@oracle.com>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 20C1576481
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

We will want to do the validation earlier in some callers or remove it
completely, so extract it from check_slab() first. No functional change.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 5bbfe4ee8d9846ec9a34584c10750388849da3b9..94a089205a86f0667444484e158d307e72cd96e1 100644
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


