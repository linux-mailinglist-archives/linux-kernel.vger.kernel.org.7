Return-Path: <linux-kernel+bounces-817122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89815B57E18
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C6B64E106E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E8A31E10D;
	Mon, 15 Sep 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K9jI49jQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nU/aOJJT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K9jI49jQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nU/aOJJT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D920313276
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944520; cv=none; b=gie0HwWMN55rbSKrT/MJdJebFUSyqmjbsS+vjIFwY2PtFO48h6WBMA1OcPVlJql3SJZsZ87543nZnSuawxW9yJPZPHhocESGTYx6P+pjydZTwNFiM9Jy7IZw2B6/xBxVtFroQzPsuTQgP7AgRwEwf3ovD3uuSjYkjR2TMCd2EjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944520; c=relaxed/simple;
	bh=IFEPrW0+O2b/PpdHrbhOMQ2ggtbk7wzfMiWyQCdvZ58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZwYcpGIcNnogHNyB5g3fBAALwVupIGMBNcjP2pqx1roqCpn+yaPYn7NzlmFytEZw5fDyLWJfYa94942ZEeOYeLlc23I/BQzM+J+3Ay0K9Mn83ElR590mMvjNnUuP12aj1GTmTSaQYukr5R1zX1SyUpBSaFCu1JKe9Oxti/UJmrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K9jI49jQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nU/aOJJT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K9jI49jQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nU/aOJJT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A2FC336EB;
	Mon, 15 Sep 2025 13:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757944510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BO/XM4CY4A6MXS0It0mmWotlrINeIN+ElFGE0qvaZQ=;
	b=K9jI49jQV8qPC4HDukiV/itEqObzPRcDI2cxTrbLaVmHM9c5kpjeHd3xA0WUcK7ZciLPFk
	OVZH5/WxvUsQ9kCs1PoDfPbs5jEUeu4d3SnuFRFh9hsgzZcD3XsGBbvFQyao8ltsU/H9OO
	OfUwNSfgv8RuAln/QMvHYLVpdrjxyTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757944510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BO/XM4CY4A6MXS0It0mmWotlrINeIN+ElFGE0qvaZQ=;
	b=nU/aOJJTGDoOskAVdUHdJW6JZDgK3whIZwe5TfkY1F8CQeHz/dFrzI2mVGzWcP1SA0s/ex
	+A3fbK32NFrgguDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757944510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BO/XM4CY4A6MXS0It0mmWotlrINeIN+ElFGE0qvaZQ=;
	b=K9jI49jQV8qPC4HDukiV/itEqObzPRcDI2cxTrbLaVmHM9c5kpjeHd3xA0WUcK7ZciLPFk
	OVZH5/WxvUsQ9kCs1PoDfPbs5jEUeu4d3SnuFRFh9hsgzZcD3XsGBbvFQyao8ltsU/H9OO
	OfUwNSfgv8RuAln/QMvHYLVpdrjxyTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757944510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BO/XM4CY4A6MXS0It0mmWotlrINeIN+ElFGE0qvaZQ=;
	b=nU/aOJJTGDoOskAVdUHdJW6JZDgK3whIZwe5TfkY1F8CQeHz/dFrzI2mVGzWcP1SA0s/ex
	+A3fbK32NFrgguDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65E7413AD3;
	Mon, 15 Sep 2025 13:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QO2bGL4ayGhnVgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 15 Sep 2025 13:55:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 15 Sep 2025 15:55:11 +0200
Subject: [PATCH v2 4/6] slab: move validate_slab_ptr() from
 alloc_consistency_checks() to its caller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-slub-slab-validation-v2-4-314690fc1532@suse.cz>
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
X-Spam-Score: -4.30

In alloc_debug_processing() we can call validate_slab_ptr() upfront and
then don't need to recheck when alloc_consistency_checks() fails for
other reasons.

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6fb24010c17019ed304b4ef61f402212dd634efb..12ad42f3d2e066b02340f2c30a85422583af3c5d 100644
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


