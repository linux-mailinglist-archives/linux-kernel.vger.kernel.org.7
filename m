Return-Path: <linux-kernel+bounces-812572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD59BB539DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF235A7C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F513680BC;
	Thu, 11 Sep 2025 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QF7gdNKw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZzFRLsT1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QF7gdNKw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZzFRLsT1"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECFF2376FC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610166; cv=none; b=Te4jShve7Mm1WblnkBNv2fC/Ubsb/n71PLkVNRD4Bk9FER4yEFTXIFYFfRjDooJ/xVHqcZXDSoPF8WE6QR7X0rBTCpsA1jt6XrKbrlazy+pgvll7MPK8Gjmdt1XM9morsz6k0kz5sbTqrKXkuE0qOjKWvbI50z2u4e53rQgxQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610166; c=relaxed/simple;
	bh=J54BT6re3klenuxIAXAyoezp6r+AS24sukuirRLMaO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZtYLQVrcKC9yZCqfu/yLEobj5A357VR6nbhOfuRvyPxI39d9BmzwlG+7C+FNmVMkJI+d0lWe7B39HA9ICSQ3K61nli3NNrctlau+a+kiaHqwslrTa3TPsaYoLztrif6SNkskUYsRDXohQCGUj1DOha+842LZGmBs53o4yCiGdn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QF7gdNKw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZzFRLsT1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QF7gdNKw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZzFRLsT1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 485AC76483;
	Thu, 11 Sep 2025 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757610155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Pv1HSdC4mXzEJtFV99nSHn9ZZRv54mCokp/t2JPr4o=;
	b=QF7gdNKwdu0/USHXbl4y1V8/yJbhvLhl97mMfX04Ke9OmFeWQkWbXSDP5Dr6YGfiyUTuxa
	ZqdMklKHmoXCPwjCIkQm3Oz1lSQbfVOAOM3ID9xPRcBiCdXZWLXb05Q90q65Of6QkXxd8r
	MMGbQUc1Unp+j/QoySvE+aZckuUPyn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757610155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Pv1HSdC4mXzEJtFV99nSHn9ZZRv54mCokp/t2JPr4o=;
	b=ZzFRLsT1OyihjWkvvWzckDLpxpzhTnothsrLr4f3UrldTZP1Dig0fGl2EZCo6SvvRPmYhc
	qfkdAyNx5hihfrDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757610155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Pv1HSdC4mXzEJtFV99nSHn9ZZRv54mCokp/t2JPr4o=;
	b=QF7gdNKwdu0/USHXbl4y1V8/yJbhvLhl97mMfX04Ke9OmFeWQkWbXSDP5Dr6YGfiyUTuxa
	ZqdMklKHmoXCPwjCIkQm3Oz1lSQbfVOAOM3ID9xPRcBiCdXZWLXb05Q90q65Of6QkXxd8r
	MMGbQUc1Unp+j/QoySvE+aZckuUPyn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757610155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Pv1HSdC4mXzEJtFV99nSHn9ZZRv54mCokp/t2JPr4o=;
	b=ZzFRLsT1OyihjWkvvWzckDLpxpzhTnothsrLr4f3UrldTZP1Dig0fGl2EZCo6SvvRPmYhc
	qfkdAyNx5hihfrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A90513AF8;
	Thu, 11 Sep 2025 17:02:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qOAXCqsAw2gUJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 11 Sep 2025 17:02:35 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 11 Sep 2025 19:02:38 +0200
Subject: [PATCH 5/6] slab: validate slab before using it in
 alloc_single_from_partial()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-slub-slab-validation-v1-5-8b67eb3b3dc5@suse.cz>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
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
 mm/slub.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 909c71372a2f542b6e0d67c12ea683133b246b66..93df6e82af37c798c3fa5574c9d825f0f4a83013 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1651,11 +1651,6 @@ static noinline bool alloc_debug_processing(struct kmem_cache *s,
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
@@ -2825,15 +2820,19 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
 
 	lockdep_assert_held(&n->list_lock);
 
+	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
+		if (!validate_slab_ptr(slab)) {
+			slab_err(s, slab, "Not a valid slab page");
+			return NULL;
+		}
+	}
+
 	object = slab->freelist;
 	slab->freelist = get_freepointer(s, object);
 	slab->inuse++;
 
-	if (!alloc_debug_processing(s, slab, object, orig_size)) {
-		if (validate_slab_ptr(slab))
-			remove_partial(n, slab);
+	if (!alloc_debug_processing(s, slab, object, orig_size))
 		return NULL;
-	}
 
 	if (slab->inuse == slab->objects) {
 		remove_partial(n, slab);

-- 
2.51.0


