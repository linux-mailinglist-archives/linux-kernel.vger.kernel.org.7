Return-Path: <linux-kernel+bounces-812576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A69B539E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72908561B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDAE36299A;
	Thu, 11 Sep 2025 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MtT2CGXS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5GSiutm2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aRi7YGSd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UFU16EPg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C346535FC18
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610186; cv=none; b=S0Y+56bb1n5KcplrSAqxcLYUOzIOG2Nzz/OsGpsXjjZnHN/xBlbfdzzmTaAeCK4xIn7gO06HHzfKj4QCRlV1oI5iizlSLuOnaI+/IKlb471pcAJ1+EUPFHnyupwzSlLzJSQ0xpKnPgqtyqZh+xqN2CqSwEXOlcM9U3sfdGy9ka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610186; c=relaxed/simple;
	bh=UkVCPyexZLuujdS/vq/QGfsjbUjvfJOcwBd5QuSG1Dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DU6x0upGHfIRLeDcVW/MvMzQ7QETRrlmUvXJu4W0JidNHUPkpixlpqhZZRRhIS7orq/0TB07vueHxZvp7X3ZZCJvSDpLfavFOD4EXqYAEyyTfrf9UnHBa4CYsILghexvVmJUiiQxh3tpcDTgDlsD3nie1wGFlacT7lD49myYHy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MtT2CGXS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5GSiutm2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aRi7YGSd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UFU16EPg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01DC47647E;
	Thu, 11 Sep 2025 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757610156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr2Y5vpWLhYmkFvvE0c3RnudTXKlGf10pEcNoBQE900=;
	b=MtT2CGXS0oB0KE1fLvExDMMJMc8nuu5zAuU4GGnqGztTCwbkABvMuffinDIgF3zqj8kqta
	3AoVsTSuueITNaVq5kqGMa8RRwt1OjPcs6aE6xFIhXq+MgCmlHgphheOCFJYxAWNNz8wjT
	xDXwBHzNblv2tej3IzBsCL5X519G42g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757610156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr2Y5vpWLhYmkFvvE0c3RnudTXKlGf10pEcNoBQE900=;
	b=5GSiutm2fsIaxCzQ51sYTrzP2N+ePhhsgtlgzgUPNLJmkKs88ZBL9ckisMxvkdEji9kxQi
	LfWroL+vWuICWTDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757610155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr2Y5vpWLhYmkFvvE0c3RnudTXKlGf10pEcNoBQE900=;
	b=aRi7YGSdI/ZSD8wGJzaYz9hrGpD8rTajcN2DOUK0xGb5fo8QZos5GWypcwB03LfqNih4Nk
	UxMF/lPpfP5VSvTxm5UeO8tyhKqPVyn/czhyn7m2aUd9CMvCBve7Xff6tqqO/JAgHNSIza
	sk+Ya7lBEqTc0aq5fupszNHOeaWR+PA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757610155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gr2Y5vpWLhYmkFvvE0c3RnudTXKlGf10pEcNoBQE900=;
	b=UFU16EPgWUxx9bfx8YzkL8UdxDIMNz6fYhEqJyLaiyW2gWddq6NlX7AuR/C0apIbYu7Ege
	6QRvffcbojJh5lBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E169F13ABA;
	Thu, 11 Sep 2025 17:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mFfANqoAw2gUJAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 11 Sep 2025 17:02:34 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 11 Sep 2025 19:02:34 +0200
Subject: [PATCH 1/6] slab: Remove dead code in free_consistency_checks()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-slub-slab-validation-v1-1-8b67eb3b3dc5@suse.cz>
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
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,oracle.com:email,suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

We already know that slab is a valid slab as that's checked by the
caller.  In the future, we won't be able to get to a slab pointer
from a non-slab page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3062f56bf49882538ba5af407de9f69c451f2e29..56143bfd1ae319d384981c810a5ed84af00f4afa 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1684,10 +1684,7 @@ static inline int free_consistency_checks(struct kmem_cache *s,
 		return 0;
 
 	if (unlikely(s != slab->slab_cache)) {
-		if (!folio_test_slab(slab_folio(slab))) {
-			slab_err(s, slab, "Attempt to free object(0x%p) outside of slab",
-				 object);
-		} else if (!slab->slab_cache) {
+		if (!slab->slab_cache) {
 			slab_err(NULL, slab, "No slab cache for object 0x%p",
 				 object);
 		} else {

-- 
2.51.0


