Return-Path: <linux-kernel+bounces-817125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9C2B57E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651A416DC0A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4740322DAC;
	Mon, 15 Sep 2025 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FxtCWqvR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mTzrYONe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FxtCWqvR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mTzrYONe"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6333B305062
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944534; cv=none; b=UnV14RIWUInph7xKkY165NIBIhF38MQE/FXczAhCwAHwUxfZfE/SSS0oSUrrSdc3YnnKvpgF9TQk/+A6zdcCZweZNuDEuKmKaj6b+GGs6AhNWmY8DGZz/bjSSOSp/032k/2tQGp82UbAce82LqiHsB5o18SD5dyQmg8i15/JEx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944534; c=relaxed/simple;
	bh=aDJ5YxL8SPy2pJ4aI19nrb5XcncBqfio3shlTU1b0ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oc9AnM+lMf6pmu/+4Z83cV1rXHA7ku6uB2pVBYVDlKIJzaXBjhTaLMSPgGG1E10Y64iIaw5bWV+JsDWB66q/xE1OdOKUE8Og5s19UciDAOw8xgdpACq2a2GyOhzW/b4g2acWI90awZFhvipPY5+KQUy3JpZn1rw6RMX2+otTCRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FxtCWqvR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mTzrYONe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FxtCWqvR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mTzrYONe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 988433374A;
	Mon, 15 Sep 2025 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757944510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yhq37OvjM7fq00iEJul32hLecu5UF+dKNzM5S6DIT68=;
	b=FxtCWqvR5ywVPaYtW5YFKfdfWmRJ3K6NxfiT/WISnhCdXqkcsTQJEwv3RrNpSrYU47Gm7e
	x/A6YEm0wJOi8YgJbClNr3lO9P84GIuhrzgMmQdpdZgkp6OjPvNHJm7EQAQsB84EsJgVwA
	ZGtEv1U986SydiOJ5pVIVED2PqNzr7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757944510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yhq37OvjM7fq00iEJul32hLecu5UF+dKNzM5S6DIT68=;
	b=mTzrYONeW8ploOIGMF5soa9ONZ78yoSDZAqUfFFlBTkBwMc33XoxrC9S0Ip2GBnqZM/3kw
	O7LDL+kk/DgRAaBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FxtCWqvR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mTzrYONe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757944510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yhq37OvjM7fq00iEJul32hLecu5UF+dKNzM5S6DIT68=;
	b=FxtCWqvR5ywVPaYtW5YFKfdfWmRJ3K6NxfiT/WISnhCdXqkcsTQJEwv3RrNpSrYU47Gm7e
	x/A6YEm0wJOi8YgJbClNr3lO9P84GIuhrzgMmQdpdZgkp6OjPvNHJm7EQAQsB84EsJgVwA
	ZGtEv1U986SydiOJ5pVIVED2PqNzr7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757944510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yhq37OvjM7fq00iEJul32hLecu5UF+dKNzM5S6DIT68=;
	b=mTzrYONeW8ploOIGMF5soa9ONZ78yoSDZAqUfFFlBTkBwMc33XoxrC9S0Ip2GBnqZM/3kw
	O7LDL+kk/DgRAaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 864891368D;
	Mon, 15 Sep 2025 13:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +FaGIL4ayGhnVgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 15 Sep 2025 13:55:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 15 Sep 2025 15:55:13 +0200
Subject: [PATCH v2 6/6] slab: don't validate slab pointer in
 free_debug_processing()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-slub-slab-validation-v2-6-314690fc1532@suse.cz>
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
X-Rspamd-Queue-Id: 988433374A
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
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

The struct slab pointer has been obtained from the object being freed on
all the paths that lead to this function. In all cases this already
includes the test for slab type of the struct page which struct slab is
overlaying. Thus we would not reach this function if it was not a valid
slab pointer in the first place.

One less obvious case is that kmem_cache_free() trusts virt_to_slab()
blindly so it may be NULL if the slab type check is false. But with
SLAB_CONSISTENCY_CHECKS, cache_from_obj() called also from
kmem_cache_free() catches this and returns NULL, which terminates
freeing immediately.

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index e5b53d1debddd3fe0f941f579a1043a5b976e50b..6fe02b1d3fe9d4101465190ebefd6df41f887fb9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3492,11 +3492,6 @@ static inline bool free_debug_processing(struct kmem_cache *s,
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


