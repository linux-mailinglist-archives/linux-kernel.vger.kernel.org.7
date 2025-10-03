Return-Path: <linux-kernel+bounces-841074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AE2BB632C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 09:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9412E4E40AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 07:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A739025E824;
	Fri,  3 Oct 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C/lmm3ow";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S1eyH6nj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C/lmm3ow";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S1eyH6nj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F125C809
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759477802; cv=none; b=MxQluFfA742ZeVJ1iCRVGJTIacDWiVmVj/7Lg3gVk4rwY46Yp7Vjhc76XrYUQiDY4J6/pm3Cuh/A8nEEw5PElaavdi6WCLxXat08VSbKI+uEwNqU+Wzxax9jAfpbJHOFVWDKFrK5RCTL83oKPkj8LlUC7FaGhCGG+3IpykjTIyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759477802; c=relaxed/simple;
	bh=EDez1S4AqiFaQkCFmx3Xu2teXcZCZcYEEh7Fmcq6Z+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahFcmG03bsOZzef5ldV32TIpSdZo0DaF2NOTtM1O/Kwn0aMh1V8CdNAUCOHI4f2C5zYAH2E6YqF8nNvCanXIjHTCzjoFtb4fxf8Rq5MceaszBVVLjKRzH2z4/epHMxNbT3LwOSefmkfNh83YOy6iF+oaVlkxrbzvg3E6DsZosOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C/lmm3ow; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S1eyH6nj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C/lmm3ow; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S1eyH6nj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4FF7D1F799;
	Fri,  3 Oct 2025 07:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759477798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sFANgBbddzqqfD/X2CBv0pVIzs/fX2yb+wzLngSKptI=;
	b=C/lmm3owZNu0rtANDu1/6zyDLnCtp20YXUYngak5FzGa+As1vzBJpNz7NYK9/C/o6Ewpab
	6oAzVIIolWGD/5VUfCECsSqj+tXOnRq+ufLTpw2ZQRp0gLXGB3uYvyQQgx6SA+KrE60l1b
	pm/cIKDBkyo6JxZ4328+hRcvZD34dq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759477798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sFANgBbddzqqfD/X2CBv0pVIzs/fX2yb+wzLngSKptI=;
	b=S1eyH6njYwBlOSxREBFthoCFnLr0fOPNYSLvo6FR7/0LZuCWpOhBp1QmV4XZ4Jrkc7csfB
	yVuLPmXv/5DXjxAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="C/lmm3ow";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=S1eyH6nj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759477798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sFANgBbddzqqfD/X2CBv0pVIzs/fX2yb+wzLngSKptI=;
	b=C/lmm3owZNu0rtANDu1/6zyDLnCtp20YXUYngak5FzGa+As1vzBJpNz7NYK9/C/o6Ewpab
	6oAzVIIolWGD/5VUfCECsSqj+tXOnRq+ufLTpw2ZQRp0gLXGB3uYvyQQgx6SA+KrE60l1b
	pm/cIKDBkyo6JxZ4328+hRcvZD34dq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759477798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sFANgBbddzqqfD/X2CBv0pVIzs/fX2yb+wzLngSKptI=;
	b=S1eyH6njYwBlOSxREBFthoCFnLr0fOPNYSLvo6FR7/0LZuCWpOhBp1QmV4XZ4Jrkc7csfB
	yVuLPmXv/5DXjxAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3710D13AAD;
	Fri,  3 Oct 2025 07:49:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0vEQDSaA32h0ZQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 03 Oct 2025 07:49:58 +0000
Message-ID: <f72deca7-4344-4adc-88e3-35a4a1d9a30b@suse.cz>
Date: Fri, 3 Oct 2025 09:49:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: Fix using this_cpu_ptr() in preemptible context
Content-Language: en-US
To: ranxiaokai627@163.com, akpm@linux-foundation.org, cl@gentwo.org,
 rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com,
 ast@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, ran.xiaokai@zte.com.cn
References: <20250930083402.782927-1-ranxiaokai627@163.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250930083402.782927-1-ranxiaokai627@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4FF7D1F799
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[163.com,linux-foundation.org,gentwo.org,google.com,linux.dev,oracle.com,kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email,zte.com.cn:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 9/30/25 10:34, ranxiaokai627@163.com wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> defer_free() maybe called in preemptible context, this will
> trigger the below warning message:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> caller is defer_free+0x1b/0x60
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xac/0xc0
>  check_preemption_disabled+0xbe/0xe0
>  defer_free+0x1b/0x60
>  kfree_nolock+0x1eb/0x2b0
>  alloc_slab_obj_exts+0x356/0x390
>  __alloc_tagging_slab_alloc_hook+0xa0/0x300
>  __kmalloc_cache_noprof+0x1c4/0x5c0
>  __set_page_owner+0x10d/0x1c0
>  post_alloc_hook+0x84/0xf0
>  get_page_from_freelist+0x73b/0x1380
>  __alloc_frozen_pages_noprof+0x110/0x2c0
>  alloc_pages_mpol+0x44/0x140
>  alloc_slab_page+0xac/0x150
>  allocate_slab+0x78/0x3a0
>  ___slab_alloc+0x76b/0xed0
>  __slab_alloc.constprop.0+0x5a/0xb0
>  __kmalloc_noprof+0x3dc/0x6d0
>  __list_lru_init+0x6c/0x210
>  alloc_super+0x3b6/0x470
>  sget_fc+0x5f/0x3a0
>  get_tree_nodev+0x27/0x90
>  vfs_get_tree+0x26/0xc0
>  vfs_kern_mount.part.0+0xb6/0x140
>  kern_mount+0x24/0x40
>  init_pipe_fs+0x4f/0x70
>  do_one_initcall+0x62/0x2e0
>  kernel_init_freeable+0x25b/0x4b0
>  kernel_init+0x1a/0x1c0
>  ret_from_fork+0x290/0x2e0
>  ret_from_fork_asm+0x11/0x20
> </TASK>
> 
> Replace this_cpu_ptr with raw_cpu_ptr to eliminate
> the above warning message.
> 
> Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Since the slab PR was merged, we should fix this ideally before rc1 so I
updated the code myself per the discussion and added to slab/for-next

Thanks!

----8<----
From d6306a3d5577769b179ae4e448fd144e2b0f7717 Mon Sep 17 00:00:00 2001
From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Date: Tue, 30 Sep 2025 08:34:02 +0000
Subject: [PATCH] slab: Fix using this_cpu_ptr() in preemptible context

defer_free() maybe called in preemptible context, this will trigger the
below warning message:

BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
caller is defer_free+0x1b/0x60
Call Trace:
 <TASK>
 dump_stack_lvl+0xac/0xc0
 check_preemption_disabled+0xbe/0xe0
 defer_free+0x1b/0x60
 kfree_nolock+0x1eb/0x2b0
 alloc_slab_obj_exts+0x356/0x390
 __alloc_tagging_slab_alloc_hook+0xa0/0x300
 __kmalloc_cache_noprof+0x1c4/0x5c0
 __set_page_owner+0x10d/0x1c0
 post_alloc_hook+0x84/0xf0
 get_page_from_freelist+0x73b/0x1380
 __alloc_frozen_pages_noprof+0x110/0x2c0
 alloc_pages_mpol+0x44/0x140
 alloc_slab_page+0xac/0x150
 allocate_slab+0x78/0x3a0
 ___slab_alloc+0x76b/0xed0
 __slab_alloc.constprop.0+0x5a/0xb0
 __kmalloc_noprof+0x3dc/0x6d0
 __list_lru_init+0x6c/0x210
 alloc_super+0x3b6/0x470
 sget_fc+0x5f/0x3a0
 get_tree_nodev+0x27/0x90
 vfs_get_tree+0x26/0xc0
 vfs_kern_mount.part.0+0xb6/0x140
 kern_mount+0x24/0x40
 init_pipe_fs+0x4f/0x70
 do_one_initcall+0x62/0x2e0
 kernel_init_freeable+0x25b/0x4b0
 kernel_init+0x1a/0x1c0
 ret_from_fork+0x290/0x2e0
 ret_from_fork_asm+0x11/0x20
</TASK>

Disable preemption in defer_free() and also defer_deactivate_slab() to
make it safe.

[vbabka@suse.cz: disable preemption instead of using raw_cpu_ptr() per
 the discussion ]
Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Link: https://lore.kernel.org/r/20250930083402.782927-1-ranxiaokai627@163.com
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1433f5b988f7..44aa0e3f48ee 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6432,17 +6432,24 @@ static void free_deferred_objects(struct irq_work *work)
 
 static void defer_free(struct kmem_cache *s, void *head)
 {
-	struct defer_free *df = this_cpu_ptr(&defer_free_objects);
+	struct defer_free *df;
 
+	guard(preempt)();
+
+	df = this_cpu_ptr(&defer_free_objects);
 	if (llist_add(head + s->offset, &df->objects))
 		irq_work_queue(&df->work);
 }
 
 static void defer_deactivate_slab(struct slab *slab, void *flush_freelist)
 {
-	struct defer_free *df = this_cpu_ptr(&defer_free_objects);
+	struct defer_free *df;
 
 	slab->flush_freelist = flush_freelist;
+
+	guard(preempt)();
+
+	df = this_cpu_ptr(&defer_free_objects);
 	if (llist_add(&slab->llnode, &df->slabs))
 		irq_work_queue(&df->work);
 }
-- 
2.51.0



