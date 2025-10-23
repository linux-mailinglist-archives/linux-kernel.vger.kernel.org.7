Return-Path: <linux-kernel+bounces-866886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BEAC00F25
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF73B4E4050
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8584630F80A;
	Thu, 23 Oct 2025 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y65wUZXg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fAx7tjmP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x1nM2Jay";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NZt1RgMs"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E2030F535
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220882; cv=none; b=FnijyyRjiFywbpSCo+j5Cu9rxKBJKVQyAGuUDIh3B3OmoZGOhs0/h3h0S+rRsmRr+iHsca1ouR1FSU2av9S4Sl9kWRJVxfp+hIvLY2KK6ktUqEBvgiK+CROVVXat7sd/BHico1qyZf2MfYmnIqwceCQyAWhZNzW2XCeTQ7U66Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220882; c=relaxed/simple;
	bh=Zlay6eCbvp2/Sw6UVOR2JhIolZPjDd3LN1tdgEkO/9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JMn/bJf6SLrTGhf6QhUDTC6iBHH+YS9SFGYVf9FDjBO+DsDe/FB3W9Wh+esL8gENrGbJKmF8wod6E8+QTYTEtizGrSyCEjvKDyv1PZIMyGbeK4gknSo33jq9BV5Fru7NGIhxHQMOZ+SaVVLcmTqf4UipNZdFDNRbWw+9ysDjMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y65wUZXg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fAx7tjmP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x1nM2Jay; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NZt1RgMs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC4481F391;
	Thu, 23 Oct 2025 12:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761220875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W7p5nQWyCEhm9BH1MPA6rOHeMDHeFHPXgItAhkK0bBk=;
	b=Y65wUZXgkVndE5aov4Vu25yrlvdnxDZF3KzFeLn+HtrfNV3Iwwz+836Hf7159IhzEFhUXC
	qvMqHvgttwJppRWWJeaCrN5n2JP3LbXxpUf8iRV/RMtxtGiyuDb+3bjejOvD4ji6ok1agf
	MnNYi/ATJqjOvie+1QWIR9+wog5Ky78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761220875;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W7p5nQWyCEhm9BH1MPA6rOHeMDHeFHPXgItAhkK0bBk=;
	b=fAx7tjmP7SKp9lZ681IeFhbTwixq4xnXi8JX/vOO3wl/XEHU8CTIo/c7bEybwUTrmJfrCV
	FWxWBcPtBAvSaLDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761220870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W7p5nQWyCEhm9BH1MPA6rOHeMDHeFHPXgItAhkK0bBk=;
	b=x1nM2JaysuHh7Y6m6973jnSjlTihU14/4NCNonFKNyHk3uvwnQLkIdABqpdNwwbgizp3cX
	NvBwlEdWC2rgs2HQm8fuO9y69yefbL5zqhONs6lxS7ft2YL9h8tkOsQpSuDkK8IzjcNWX6
	EPyu7eVFnXQQSR49v206zI1WGuixCVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761220870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W7p5nQWyCEhm9BH1MPA6rOHeMDHeFHPXgItAhkK0bBk=;
	b=NZt1RgMsq8Jh6U9g028u8q8R3hXsTJbXTD9xq6Ofp3N+CJ5Kh89YxRtVmccdmYbbdGBaXp
	sJ3IRG0cCsai6aDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADD2913285;
	Thu, 23 Oct 2025 12:01:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 73glKgYZ+mjtVAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 23 Oct 2025 12:01:10 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 23 Oct 2025 14:01:07 +0200
Subject: [PATCH v2] slab: fix slab accounting imbalance due to
 defer_deactivate_slab()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-fix-slab-accounting-v2-1-0e62d50986ea@suse.cz>
X-B4-Tracking: v=1; b=H4sIAAIZ+mgC/32NQQ6CMBBFr0Jm7Zi2RCCuvIdh0ZYpTGJa0wGiE
 u5u5QAu38//728glJkErtUGmVYWTrGAOVXgJxtHQh4Kg1HmopUxGPiF8rAOrfdpiTPHEYOyzg2
 2s00IUJbPTKV2WO994YllTvl9nKz6l/73rRo1mrZrFfm6qT3dZBE6+w/0+75/AfnahGu0AAAA
X-Change-ID: 20251022-fix-slab-accounting-f0abbda8a6ff
To: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
 Alexei Starovoitov <ast@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2365; i=vbabka@suse.cz;
 h=from:subject:message-id; bh=Zlay6eCbvp2/Sw6UVOR2JhIolZPjDd3LN1tdgEkO/9U=;
 b=owGbwMvMwMG4+8GG0kuuHbMYT6slMWT8kmTZvKlyzQm2Pcc9Jp95ELVgk/UJvSeiXG8XWi53T
 vsn66W4upPRn4WBkYPBUkyRpXr3CUfRmcoe0zx8P8IMYmUCmSIt0sAABCwMfLmJeaVGOkZ6ptqG
 eoaGOkAmAxenAEz168ccDK2HIg3n6Vw6br03rFdNcraScK391WSDCxY3Ui4szLuy7X1f3Z2d3LK
 5KRPv8F+//LCtv4Zpo2z/7Nki6466usRGi26q8ctL+v7K3dXzX+LCet5lr/jVSteveGcrEaH7l7
 /VKME78pVfSFwYtzPTi2WPBKYd/akw9zNrGPMmllT9FY0fj3BcsGPlYj+TcnOT6ldJpRhlwcqFt
 6dH2Rhsfhko27LmnCN3go7C3IDLNW83v5pSddz30DROrk3zw06Wmx6Sf/OtUG3rRRYOuQuxkZzL
 f074EvjX7XjzvjdVB+t/8VomaGm25tv7PL30vbSu/32RWDv3bEvfK90Hf23T27dcwb/gTfqRxaG
 uM86dAgA=
X-Developer-Key: i=vbabka@suse.cz; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

Since commit af92793e52c3 ("slab: Introduce kmalloc_nolock() and
kfree_nolock().") there's a possibility in alloc_single_from_new_slab()
that we discard the newly allocated slab if we can't spin and we fail to
trylock. As a result we don't perform inc_slabs_node() later in the
function. Instead we perform a deferred deactivate_slab() which can
either put the unacounted slab on partial list, or discard it
immediately while performing dec_slabs_node(). Either way will cause an
accounting imbalance.

Fix this by not marking the slab as frozen, and using free_slab()
instead of deactivate_slab() for non-frozen slabs in
free_deferred_objects(). For CONFIG_SLUB_TINY, that's the only possible
case. By not using discard_slab() we avoid dec_slabs_node().

Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Changes in v2:
- Fix the problem differently. Harry pointed out that we can't move
  inc_slabs_node() outside of list_lock protected regions as that would
  reintroduce issues fixed by commit c7323a5ad078
- Link to v1: https://patch.msgid.link/20251022-fix-slab-accounting-v1-1-27870ec363ce@suse.cz
---
 mm/slub.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 23d8f54e9486..87a1d2f9de0d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3422,7 +3422,6 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
 
 	if (!allow_spin && !spin_trylock_irqsave(&n->list_lock, flags)) {
 		/* Unlucky, discard newly allocated slab */
-		slab->frozen = 1;
 		defer_deactivate_slab(slab, NULL);
 		return NULL;
 	}
@@ -6471,9 +6470,12 @@ static void free_deferred_objects(struct irq_work *work)
 		struct slab *slab = container_of(pos, struct slab, llnode);
 
 #ifdef CONFIG_SLUB_TINY
-		discard_slab(slab->slab_cache, slab);
+		free_slab(slab->slab_cache, slab);
 #else
-		deactivate_slab(slab->slab_cache, slab, slab->flush_freelist);
+		if (slab->frozen)
+			deactivate_slab(slab->slab_cache, slab, slab->flush_freelist);
+		else
+			free_slab(slab->slab_cache, slab);
 #endif
 	}
 }

---
base-commit: 6ed8bfd24ce1cb31742b09a3eb557cd008533eec
change-id: 20251022-fix-slab-accounting-f0abbda8a6ff

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


