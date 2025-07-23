Return-Path: <linux-kernel+bounces-742593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F25FB0F421
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FE9966347
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522C42E7BC4;
	Wed, 23 Jul 2025 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k7TWNhIa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dhAFiZfv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k7TWNhIa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dhAFiZfv"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492622E8894
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277714; cv=none; b=FCmJid98EYnTJS2m663+BMzL2EG2X2IT4BG296KqDjvCfigIFUOkgT4fEj+E4K4BAdXeSP0NjiDlo1QTX7RKwdGykJsy511z2IHvK9+lYldSn91cIGkwzRGugsCc5C2wSw+riqbLWhj31dkSY/B6nSx05cQkLOSjrj84emyBEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277714; c=relaxed/simple;
	bh=uwGuMkdfFM9dL2F84LqpQY2YADs4OLXcO/y6R3TN23Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U+ydgyPyXFJ+9M1DRHR8K0ewkJZEynolQz7EfOw6fI2FYK2O6aeBNeOvq+rNKEytkOy6ZHD5ujIg3wSFoRUhAN+D+LF99n1nP9vK1ZGABVdTChdhNQhWPId1jVneOAb3eJrJSpM2kxXKdfrpUvVwx5gn8g5nR5wXiwvYOH2qQT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k7TWNhIa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dhAFiZfv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k7TWNhIa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dhAFiZfv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7ACF6218B0;
	Wed, 23 Jul 2025 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753277704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjspbytw5pUKmztZF0TrPMKw/E4DLanznrsR+bMZ7RQ=;
	b=k7TWNhIaARnum1WkfbGe5RwoewtunZWxrgNGiLzBmp8m1PRoNoDkPEIFtd05Z9Vmv9CNtL
	u09LiDbroxL8En4mLkNAPFeHaERQ4GYqAk36oBZfEUcnG9111b6gdgRrHv8+Sjf/ha5JTr
	S5VFn7nePx0GbfOIZtvr6Cv0n630emM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753277704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjspbytw5pUKmztZF0TrPMKw/E4DLanznrsR+bMZ7RQ=;
	b=dhAFiZfvJVtq3zZuZ5AZ8bXG7pje4bq/RsQHdv/EjrDDGaFM27AftIV7dMmKQxKE9gTQC1
	mCTB3/sdl3ceb5Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753277704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjspbytw5pUKmztZF0TrPMKw/E4DLanznrsR+bMZ7RQ=;
	b=k7TWNhIaARnum1WkfbGe5RwoewtunZWxrgNGiLzBmp8m1PRoNoDkPEIFtd05Z9Vmv9CNtL
	u09LiDbroxL8En4mLkNAPFeHaERQ4GYqAk36oBZfEUcnG9111b6gdgRrHv8+Sjf/ha5JTr
	S5VFn7nePx0GbfOIZtvr6Cv0n630emM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753277704;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjspbytw5pUKmztZF0TrPMKw/E4DLanznrsR+bMZ7RQ=;
	b=dhAFiZfvJVtq3zZuZ5AZ8bXG7pje4bq/RsQHdv/EjrDDGaFM27AftIV7dMmKQxKE9gTQC1
	mCTB3/sdl3ceb5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65FBF13ADD;
	Wed, 23 Jul 2025 13:35:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uDKiGAjlgGh0IwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 23 Jul 2025 13:35:04 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 23 Jul 2025 15:34:41 +0200
Subject: [PATCH v5 08/14] mm, vma: use percpu sheaves for vm_area_struct
 cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-slub-percpu-caches-v5-8-b792cd830f5d@suse.cz>
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
In-Reply-To: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

Create the vm_area_struct cache with percpu sheaves of size 32 to
improve its performance.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/vma_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vma_init.c b/mm/vma_init.c
index 8e53c7943561e7324e7992946b4065dec1149b82..52c6b55fac4519e0da39ca75ad018e14449d1d95 100644
--- a/mm/vma_init.c
+++ b/mm/vma_init.c
@@ -16,6 +16,7 @@ void __init vma_state_init(void)
 	struct kmem_cache_args args = {
 		.use_freeptr_offset = true,
 		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
+		.sheaf_capacity = 32,
 	};
 
 	vm_area_cachep = kmem_cache_create("vm_area_struct",

-- 
2.50.1


