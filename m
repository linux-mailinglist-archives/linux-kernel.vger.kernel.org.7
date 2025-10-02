Return-Path: <linux-kernel+bounces-839989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D95BB33E9
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 10:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCF756076D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 08:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11C12DF155;
	Thu,  2 Oct 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VWWzcd77";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UzrHfhez";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VWWzcd77";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UzrHfhez"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281D02DF151
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392899; cv=none; b=j7neeY/4+pIviZFYAuZaXagUyJlFUPXN671qWRMZJIb1Egy+NTnAhleJ4s0TP3AfQw52aOEST4Fk5nG+gDVtylry8Kg8MKQ0RD9B9LWVR0DoKjgFjfizlIeCWxxkd0ZMrCR0cZf7RRqo5lmbuNXpa8TdgXzEzgqYLn4T2mg3SiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392899; c=relaxed/simple;
	bh=IQDcv9HohwuxlMQOXul9FK+5bewDRQO7Ob1WhGeyF+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBYgEXxaFeSQdIBUCnfaR9pNA6ID8li3L9Bug1onEMGWlVWmoQ7bWSFxxJ4cZsTDvpTyqM1i1KMED1LPXR28lRbHtOwMqF33ahQOgkHTDUT3TsX0ExPMjT9S/wtSxr0GX93kuGsyRb3F5ygldZZobV0qZxobznjIA4cHYuagcVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VWWzcd77; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UzrHfhez; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VWWzcd77; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UzrHfhez; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E1D633769;
	Thu,  2 Oct 2025 08:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759392896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JkJWMOW654A2NQw8DnXLLcGrKiRsoRYbhX3pXplYai4=;
	b=VWWzcd77OjwQ1CbNz6wrB7HcE5ZvWwfEUkURc3y3JjflQ/svq3PHm/78SGC3znYDVL4A7u
	9EiCaHDxJQi3fnbRjTcc6T4MxJVjAsjMAxoWBaaSUw2MMXgwuwI6iBGtC/dqHGp/QZRS8p
	LtV4RrvMuTYxib2G4//qpbBYE9Sxpio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759392896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JkJWMOW654A2NQw8DnXLLcGrKiRsoRYbhX3pXplYai4=;
	b=UzrHfhezFDoU19SNap9yR9071ng3xTx3wtGzgYa113dsd27cl8xwYoW5RqcKamC44qZuea
	MIBCocsuEVJV0mAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759392896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JkJWMOW654A2NQw8DnXLLcGrKiRsoRYbhX3pXplYai4=;
	b=VWWzcd77OjwQ1CbNz6wrB7HcE5ZvWwfEUkURc3y3JjflQ/svq3PHm/78SGC3znYDVL4A7u
	9EiCaHDxJQi3fnbRjTcc6T4MxJVjAsjMAxoWBaaSUw2MMXgwuwI6iBGtC/dqHGp/QZRS8p
	LtV4RrvMuTYxib2G4//qpbBYE9Sxpio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759392896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JkJWMOW654A2NQw8DnXLLcGrKiRsoRYbhX3pXplYai4=;
	b=UzrHfhezFDoU19SNap9yR9071ng3xTx3wtGzgYa113dsd27cl8xwYoW5RqcKamC44qZuea
	MIBCocsuEVJV0mAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA0C51395B;
	Thu,  2 Oct 2025 08:14:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1MWRNn803mjkUQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 02 Oct 2025 08:14:55 +0000
Message-ID: <b9fb0a69-6cfb-4285-8118-ef5301115948@suse.cz>
Date: Thu, 2 Oct 2025 10:14:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: Fix using this_cpu_ptr() in preemptible context
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Harry Yoo <harry.yoo@oracle.com>
Cc: ranxiaokai627@163.com, Andrew Morton <akpm@linux-foundation.org>,
 cl@gentwo.org, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, ran.xiaokai@zte.com.cn
References: <20250930083402.782927-1-ranxiaokai627@163.com>
 <aNu2xJMkEyYSdmW6@hyeyoo>
 <CAADnVQJ-bkd2UVsZmhdb1L5ZrXjZbTnRcaJ-D=ojsoiRHmHwaw@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAADnVQJ-bkd2UVsZmhdb1L5ZrXjZbTnRcaJ-D=ojsoiRHmHwaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[163.com,linux-foundation.org,gentwo.org,google.com,linux.dev,kernel.org,vger.kernel.org,kvack.org,zte.com.cn];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

On 9/30/25 13:19, Alexei Starovoitov wrote:
> On Tue, Sep 30, 2025 at 12:54 PM Harry Yoo <harry.yoo@oracle.com> wrote:
>>
>> On Tue, Sep 30, 2025 at 08:34:02AM +0000, ranxiaokai627@163.com wrote:
>> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> >
>> > defer_free() maybe called in preemptible context, this will
>> > trigger the below warning message:
>> >
>> > BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
>> > caller is defer_free+0x1b/0x60
>> > Call Trace:
>> >  <TASK>
>> >  dump_stack_lvl+0xac/0xc0
>> >  check_preemption_disabled+0xbe/0xe0
>> >  defer_free+0x1b/0x60
>> >  kfree_nolock+0x1eb/0x2b0
>> >  alloc_slab_obj_exts+0x356/0x390
> 
> Please share config and repro details, since the stack trace
> looks theoretical, but you somehow got it?
> This is not CONFIG_SLUB_TINY, but kfree_nolock()
> sees locked per-cpu slab?

Could it be just the "slab != c->slab" condition in do_slab_free()? That's
more likely. However...

> Is this PREEMPT_RT ?
> 
>> >  __alloc_tagging_slab_alloc_hook+0xa0/0x300
>> >  __kmalloc_cache_noprof+0x1c4/0x5c0
>> >  __set_page_owner+0x10d/0x1c0

This is the part that puzzles me, where do we call kmalloc from
__set_page_owner()? And in a way that it loses the GFP_KERNEL passed all the
way? I don't even see a lib/stackdepot function here.

>> >  post_alloc_hook+0x84/0xf0
>> >  get_page_from_freelist+0x73b/0x1380
>> >  __alloc_frozen_pages_noprof+0x110/0x2c0
>> >  alloc_pages_mpol+0x44/0x140
>> >  alloc_slab_page+0xac/0x150
>> >  allocate_slab+0x78/0x3a0
>> >  ___slab_alloc+0x76b/0xed0
>> >  __slab_alloc.constprop.0+0x5a/0xb0
>> >  __kmalloc_noprof+0x3dc/0x6d0
>> >  __list_lru_init+0x6c/0x210

This has a kcalloc(GFP_KERNEL).

>> >  alloc_super+0x3b6/0x470
>> >  sget_fc+0x5f/0x3a0
>> >  get_tree_nodev+0x27/0x90
>> >  vfs_get_tree+0x26/0xc0
>> >  vfs_kern_mount.part.0+0xb6/0x140
>> >  kern_mount+0x24/0x40
>> >  init_pipe_fs+0x4f/0x70
>> >  do_one_initcall+0x62/0x2e0
>> >  kernel_init_freeable+0x25b/0x4b0

Here we've set the full gfp_allowed_mask already so it's not masking our
GFP_KERNEL.

>> >  kernel_init+0x1a/0x1c0
>> >  ret_from_fork+0x290/0x2e0
>> >  ret_from_fork_asm+0x11/0x20
>> > </TASK>
>> >
>> > Replace this_cpu_ptr with raw_cpu_ptr to eliminate
>> > the above warning message.
>> >
>> > Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
>>
>> There's no mainline commit hash yet, should be adjusted later.
>>
>> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> > ---
>> >  mm/slub.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/mm/slub.c b/mm/slub.c
>> > index 1433f5b988f7..67c57f1b5a86 100644
>> > --- a/mm/slub.c
>> > +++ b/mm/slub.c
>> > @@ -6432,7 +6432,7 @@ static void free_deferred_objects(struct irq_work *work)
>> >
>> >  static void defer_free(struct kmem_cache *s, void *head)
>> >  {
>> > -     struct defer_free *df = this_cpu_ptr(&defer_free_objects);
>> > +     struct defer_free *df = raw_cpu_ptr(&defer_free_objects);
>>
>> This suppresses warning, but let's answer the question;
>> Is it actually safe to not disable preemption here?
>>
>> >       if (llist_add(head + s->offset, &df->objects))
>>
>> Let's say a task was running on CPU X and migrated to a different CPU
>> (say, Y) after returning from llist_add() or before calling llist_add(),
>> then we're queueing the irq_work of CPU X on CPU Y.
>>
>> I think technically this should be safe because, although we're using
>> per-cpu irq_work here, the irq_work framework itself is designed to handle
>> concurrent access from multiple CPUs (otherwise it won't be safe to use
>> a global irq_work like in other places) by using lockless list, which
>> uses try_cmpxchg() and xchg() for atomic update.
>>
>> So if I'm not missing something it should be safe, but it was very
>> confusing to confirm that it's safe as we're using per-cpu irq_work...
>>
>> I don't think these paths are very performance critical, so why not disable
>> preemption instead of replacing it with raw_cpu_ptr()?
> 
> +1.
> Though irq_work_queue() works for any irq_work it should
> be used for current cpu, since it IPIs itself.
> So pls use guard(preempt)(); instead.

Agreed. But we should fix it like this. But the report is strange.

