Return-Path: <linux-kernel+bounces-619772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB702A9C0F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 10:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05CF67AD001
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 08:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CE623816F;
	Fri, 25 Apr 2025 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0GVJqAwj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GDgMkE7D";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0GVJqAwj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GDgMkE7D"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3862356BA
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569702; cv=none; b=kYftvNE8Efl8TX8+2q3ZtVuhT/YTMTHmUTH1uGz77wpg8jcBvIi/hzrGqHDVac2R79ABgP4O741HsXH5J0QsjzXhOV82cfW7lA+lHZ7arKUTeKpU20w4ZPeLXdrh+5pUEydx3XJBKig4PRUEh0Bma5RXnZAMlT0McDxvFaybazs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569702; c=relaxed/simple;
	bh=xYykol/ZNIVL6HmnOqb00S6mcrmj/ya4eu3KQYIjz0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M6WI+5memQgqBIDB5dQHn2Oqy6Ym2MpctF5FyBkmBZhoIok+JYeMTKEzaHPrnHvXk3dsaLa9i5l9bHbl/LXqe5SHQijC7EJJ6iQ9XmaDGxgsb3Y60BgfME2LUwHuHFFVNni4ij7UAoQMDPbVaRqZqlKtia6yxZs6bZmxZyzkp4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0GVJqAwj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GDgMkE7D; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0GVJqAwj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GDgMkE7D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 591822116D;
	Fri, 25 Apr 2025 08:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745569673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9V7AWob2cKHkI17Xj2c1Fb82VkkcpTC1TQa4P763IdU=;
	b=0GVJqAwjkgGc3Ksw7Iv53tze4YqrtOan4Wyf4byTFGKdWsbhVeWpgyydPUFKJSZZ3l5sh1
	rq9NI33HSHMOTXmENIi8uo03weySrVWWalx4qdTIkbahXPDryczmApF1SQlok7OZLjD2Ei
	wru7TLabn5J22WQUhg8vL3uRmIY9cfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745569673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9V7AWob2cKHkI17Xj2c1Fb82VkkcpTC1TQa4P763IdU=;
	b=GDgMkE7D6fAdWJEIVlBYYxVXSGgmA4FfYSoiich5jSa1K1mMihc/jY5A/gT49QfJNJV9/d
	3euF4MIpz5XNuaBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745569673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9V7AWob2cKHkI17Xj2c1Fb82VkkcpTC1TQa4P763IdU=;
	b=0GVJqAwjkgGc3Ksw7Iv53tze4YqrtOan4Wyf4byTFGKdWsbhVeWpgyydPUFKJSZZ3l5sh1
	rq9NI33HSHMOTXmENIi8uo03weySrVWWalx4qdTIkbahXPDryczmApF1SQlok7OZLjD2Ei
	wru7TLabn5J22WQUhg8vL3uRmIY9cfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745569673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9V7AWob2cKHkI17Xj2c1Fb82VkkcpTC1TQa4P763IdU=;
	b=GDgMkE7D6fAdWJEIVlBYYxVXSGgmA4FfYSoiich5jSa1K1mMihc/jY5A/gT49QfJNJV9/d
	3euF4MIpz5XNuaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4400F13A9E;
	Fri, 25 Apr 2025 08:27:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OBhPEIlHC2htfwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Apr 2025 08:27:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 25 Apr 2025 10:27:28 +0200
Subject: [PATCH v4 8/9] mm, vma: use percpu sheaves for vm_area_struct
 cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-slub-percpu-caches-v4-8-8a636982b4a4@suse.cz>
References: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
In-Reply-To: <20250425-slub-percpu-caches-v4-0-8a636982b4a4@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 maple-tree@lists.infradead.org, vbabka@suse.cz
X-Mailer: b4 0.14.2
X-Spam-Score: -8.30
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,oracle.com,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLsunix6otu811wnbhxcn9byqb)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

Create the vm_area_struct cache with percpu sheaves of size 32 to
improve its performance.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index c4b26cd8998b8e7b2b516e0bb0b1d4676ff644dc..3bd711f0798c88aee04bc30ff21fc4ca2b66201a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3216,6 +3216,7 @@ void __init proc_caches_init(void)
 	struct kmem_cache_args args = {
 		.use_freeptr_offset = true,
 		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
+		.sheaf_capacity = 32,
 	};
 
 	sighand_cachep = kmem_cache_create("sighand_cache",

-- 
2.49.0


