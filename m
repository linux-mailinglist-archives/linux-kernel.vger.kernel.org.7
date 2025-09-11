Return-Path: <linux-kernel+bounces-812571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC20BB539DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677513B6F30
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B953368086;
	Thu, 11 Sep 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3NUsIjTT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WTl41xxS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3NUsIjTT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WTl41xxS"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43C53629B5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610160; cv=none; b=LW6JN/SLCPccnuUSwHlqNVTRRerrh0HxTzdAotNw0TEN4o/yJUAHoz75V5BJzfNyfG6pu7VYaQakLSUaQ2MpsF2L7RI8L7LnLd4/Muhe2FWgd2Wiw+zPz0L2xoILzkT48k+PhI8RZC1SLchYvIxjDRJz0ZXmEuTmNUJsMz2OMDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610160; c=relaxed/simple;
	bh=OBrCz4d0jzHFrNHwjW+2Kmd3qAmniHh1spG+C3r92lA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LyZMKCjzt0OdOVPHxRYDx3OHZs9uY823oWXTEAnee3uhDr89tY6fnbFggUhZmF0pHvYcYn+B4PpCtsLPkvGBNrQBL6VGAppWc5ftdwlZgUASuBcJ2MjKuqPk/xBr3X5IMdGfQQxO8614lRvd4ZFIQtTo2Op0gV0v8RLMWi8QyX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3NUsIjTT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WTl41xxS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3NUsIjTT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WTl41xxS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 306B476482;
	Thu, 11 Sep 2025 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757610155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16JtMs2N3c8BfxyIy3mN0WoRRH25v+rdskgyAm89Lvk=;
	b=3NUsIjTTN3qASJMnexCA5e+92cBKzdrKYdjG2TFhAVDAXH3TfeGX85tKlNJ8azYupkjf8f
	k/uf/IJmJhEWgr54gKCtB+pSWTdd4UTPVhd+5bS2ehkgjl0kWnoyGrsU/m1nWeEg041mRl
	l7BcPPatZvfSxnz63//p00cKbK7HEqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757610155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16JtMs2N3c8BfxyIy3mN0WoRRH25v+rdskgyAm89Lvk=;
	b=WTl41xxSWFezDL6Yh/s1NTrX3RQSSzNglUw5tHGaNCTp1IQCnZ1OsWN8CyNn+e4ahIzxtj
	ywruhUuWBJsszNAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757610155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16JtMs2N3c8BfxyIy3mN0WoRRH25v+rdskgyAm89Lvk=;
	b=3NUsIjTTN3qASJMnexCA5e+92cBKzdrKYdjG2TFhAVDAXH3TfeGX85tKlNJ8azYupkjf8f
	k/uf/IJmJhEWgr54gKCtB+pSWTdd4UTPVhd+5bS2ehkgjl0kWnoyGrsU/m1nWeEg041mRl
	l7BcPPatZvfSxnz63//p00cKbK7HEqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757610155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=16JtMs2N3c8BfxyIy3mN0WoRRH25v+rdskgyAm89Lvk=;
	b=WTl41xxSWFezDL6Yh/s1NTrX3RQSSzNglUw5tHGaNCTp1IQCnZ1OsWN8CyNn+e4ahIzxtj
	ywruhUuWBJsszNAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B7F713AE0;
	Thu, 11 Sep 2025 17:02:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wGJtBqsAw2gUJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 11 Sep 2025 17:02:35 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 11 Sep 2025 19:02:37 +0200
Subject: [PATCH 4/6] slab: move validate_slab_ptr() from
 alloc_consistency_checks() to its caller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-slub-slab-validation-v1-4-8b67eb3b3dc5@suse.cz>
References: <20250911-slub-slab-validation-v1-0-8b67eb3b3dc5@suse.cz>
In-Reply-To: <20250911-slub-slab-validation-v1-0-8b67eb3b3dc5@suse.cz>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

In alloc_debug_processing() we can call validate_slab_ptr() upfront and
then don't need to recheck when alloc_consistency_checks() fails for
other reasons.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 94a089205a86f0667444484e158d307e72cd96e1..909c71372a2f542b6e0d67c12ea683133b246b66 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1633,11 +1633,6 @@ void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr)
 static inline int alloc_consistency_checks(struct kmem_cache *s,
 					struct slab *slab, void *object)
 {
-	if (!validate_slab_ptr(slab)) {
-		slab_err(s, slab, "Not a valid slab page");
-		return 0;
-	}
-
 	if (!check_slab(s, slab))
 		return 0;
 
@@ -1656,6 +1651,11 @@ static noinline bool alloc_debug_processing(struct kmem_cache *s,
 			struct slab *slab, void *object, int orig_size)
 {
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
+		if (!validate_slab_ptr(slab)) {
+			slab_err(s, slab, "Not a valid slab page");
+			return false;
+		}
+
 		if (!alloc_consistency_checks(s, slab, object))
 			goto bad;
 	}
@@ -1667,17 +1667,15 @@ static noinline bool alloc_debug_processing(struct kmem_cache *s,
 	return true;
 
 bad:
-	if (validate_slab_ptr(slab)) {
-		/*
-		 * If this is a slab page then lets do the best we can
-		 * to avoid issues in the future. Marking all objects
-		 * as used avoids touching the remaining objects.
-		 */
-		slab_fix(s, "Marking all objects used");
-		slab->inuse = slab->objects;
-		slab->freelist = NULL;
-		slab->frozen = 1; /* mark consistency-failed slab as frozen */
-	}
+	/*
+	 * Let's do the best we can to avoid issues in the future. Marking all
+	 * objects as used avoids touching the remaining objects.
+	 */
+	slab_fix(s, "Marking all objects used");
+	slab->inuse = slab->objects;
+	slab->freelist = NULL;
+	slab->frozen = 1; /* mark consistency-failed slab as frozen */
+
 	return false;
 }
 

-- 
2.51.0


