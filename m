Return-Path: <linux-kernel+bounces-812573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D21B539E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FA55A7A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED49F74BE1;
	Thu, 11 Sep 2025 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UlRLIenv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oGn/PNUn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UlRLIenv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oGn/PNUn"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D335FC39
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610167; cv=none; b=FtLzZm1Z4v78ITRqXVW3PRHe77+vyTix6k6BC5/bvhrAUh/dl6F4CBrUj3l+0giTSLQN35yEj5BpXo/sWNH8A1+1RJhOue/vi1UKH+AT9Q2zr4dwmsZ12WbCE7kwOZKSv+PBWtbJVyeSekrdViURaHJDOcZLLhZnKUuXt/cAlTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610167; c=relaxed/simple;
	bh=2bRHwmHX5rn1+DO9kZ0MmLe1t+SjB2iull3FQiSUXxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hHxMk1fKMa/iij5qdwK9c70pU2Ae1nQw15GPW2jRMl+wFWeWjFXoOBWJUtvnSqcojouMTY3yiMw8EGsIUF8tBMJ2uHubAn37KoShRX6e7W3d9bGiWQaAEv3jmfRnHtnAeMM3TKThCq9pUVrN6UMjh8bZokXNd3cEUh1JuQHkgJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UlRLIenv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oGn/PNUn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UlRLIenv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oGn/PNUn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B129385FB;
	Thu, 11 Sep 2025 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757610155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gU8uzwxAYobW2SW2rVaJMdcJbOZvC5xNrUDaVXNRGxg=;
	b=UlRLIenv1BNmXoAJVTeMxpBMoAOaKHc+pxyu8MYuMXV9fqIzZ772TMdMW3aU9SyOhqvpu8
	R2akgspt2OlhZShcE7t4dWKxIt5YhY8i24bHvKqb7c5INKHxKjJ0O+qvtYZPfNYp8VD06D
	5JRoTmIMTR0olrImNVE8InGeFX+Jc2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757610155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gU8uzwxAYobW2SW2rVaJMdcJbOZvC5xNrUDaVXNRGxg=;
	b=oGn/PNUniXADceo50TVabUOMevpYbP0N9zyRD3gLNzAzq1D7glDcZHWggPBOKsv2PZAEqQ
	JVylQibCsPAR0iDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757610155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gU8uzwxAYobW2SW2rVaJMdcJbOZvC5xNrUDaVXNRGxg=;
	b=UlRLIenv1BNmXoAJVTeMxpBMoAOaKHc+pxyu8MYuMXV9fqIzZ772TMdMW3aU9SyOhqvpu8
	R2akgspt2OlhZShcE7t4dWKxIt5YhY8i24bHvKqb7c5INKHxKjJ0O+qvtYZPfNYp8VD06D
	5JRoTmIMTR0olrImNVE8InGeFX+Jc2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757610155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gU8uzwxAYobW2SW2rVaJMdcJbOZvC5xNrUDaVXNRGxg=;
	b=oGn/PNUniXADceo50TVabUOMevpYbP0N9zyRD3gLNzAzq1D7glDcZHWggPBOKsv2PZAEqQ
	JVylQibCsPAR0iDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A2C413AD6;
	Thu, 11 Sep 2025 17:02:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KKnpDasAw2gUJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 11 Sep 2025 17:02:35 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 11 Sep 2025 19:02:39 +0200
Subject: [PATCH 6/6] slab: don't validate slab pointer in
 free_debug_processing()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-slub-slab-validation-v1-6-8b67eb3b3dc5@suse.cz>
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
	BAYES_HAM(-3.00)[99.99%];
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

The struct slab pointer has been obtained one from the object being
freed on all the paths that lead to this function. In all cases this
already includes the test for slab type of the struct page which struct
slab is overlaying. Thus we would not reach this function if it was
not a valid slab pointer in the first place.

One less obvious case is that kmem_cache_free() trusts virt_to_slab()
blindly so it may be NULL if the slab type check is false. But with
SLAB_CONSISTENCY_CHECKS, cache_from_obj() called also from
kmem_cache_free() catches this and returns NULL, which terminates
freeing immediately.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 93df6e82af37c798c3fa5574c9d825f0f4a83013..106dbce64acdf32c1d271ec130c35c0ec0e15630 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3487,11 +3487,6 @@ static inline bool free_debug_processing(struct kmem_cache *s,
 	int cnt = 0;
 
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
-		if (!validate_slab_ptr(slab)) {
-			slab_err(s, slab, "Not a valid slab page");
-			goto out;
-		}
-
 		if (!check_slab(s, slab))
 			goto out;
 	}

-- 
2.51.0


