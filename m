Return-Path: <linux-kernel+bounces-772220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5561FB2901A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 20:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D0444E22D9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 18:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DA42F9C24;
	Sat, 16 Aug 2025 18:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ExmhwD+n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R91vEMK0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zzoL5f8Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JWvC2qOP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A73C137E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755368965; cv=none; b=bh8b/B1g81FXJ2ZZrYiGCJJX/VY4PGUrDHRVkJMbb183hLSdWkSDsDk/ox3zu7oKgHKrUuRz9rqY/Bjwi0+UXmQ8mHR+1uPo9WjieyKdl+arQQb8H9cBynhjOr1rPGd9CF8gMUu5Og5aD6tNCWdxEfoZ+1CgdImstiTZAH+2l3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755368965; c=relaxed/simple;
	bh=v+G0Iry0/J/7aIrEHcbReKV8fVxjFuWLVbhuJekF4Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1Ekb5r8UXEwpV1eWHD7LNVmLDxV5GNeLjkZXSf21wgsGdYUMxPWwxPoaoD4t2mmGIsdGzzXJGelA85Uo7cx3+HywEATGeaN2RzuOUrS6tQS8ofZ5QH2/2E5NmSGVH5W/a1jnYRKzrIH4iLTJIQCDp/5xuDSMTljoEKadK3kM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ExmhwD+n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R91vEMK0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zzoL5f8Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JWvC2qOP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D9C061F79C;
	Sat, 16 Aug 2025 18:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755368955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3+m47Qj3Eghi4YuXoOVp+BiD93yWyZ2w53q8+M5Kvg=;
	b=ExmhwD+nWhBWWHh5eviHhKSfqOusBZNMahfFP0E8bPPqfG09CIxogO7KVsqyHm6Ksoc/yQ
	ouf3NMiWgGniuKkMFIyUcJAYqHT/faNcaiiLDQtHJ9K+fQ/Eu239TS4jzHDLgYB0kJiD/W
	thYhPAUaIzHovwfYk9LkCXDiX3qIucY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755368955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3+m47Qj3Eghi4YuXoOVp+BiD93yWyZ2w53q8+M5Kvg=;
	b=R91vEMK0dxcFTC8N4tVvRlRp6cNPf0JKH37QkkrQMrsbcFPd1YTSMJYusz8ja2gVMOQuSc
	UUe2PZONpN4g1GAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755368954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3+m47Qj3Eghi4YuXoOVp+BiD93yWyZ2w53q8+M5Kvg=;
	b=zzoL5f8QXUrS0mMGa/ugMZvVCYFoMpJnf6y+EKmaW4xHxTde11bvdKEv1xWETbSkMfSBKq
	a5eRQbk4Dp+N4XDnUC7K7xZr/jkniU1bXV6aKcbxo4lIXRIbnz5L9793RePQmIvGZ6Z5lN
	//q5yqVwIwEU1ELfHmZoz2F31kRwlkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755368954;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3+m47Qj3Eghi4YuXoOVp+BiD93yWyZ2w53q8+M5Kvg=;
	b=JWvC2qOPdKv0r36fNhcic2LyreGXBN/o5M/1D08xzsW6uwJrEEYzJBW7szMhskQbRUzI7h
	ze+rYkQ2Yrl8iJDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B4B113432;
	Sat, 16 Aug 2025 18:29:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rcI4EPrNoGhvBwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Sat, 16 Aug 2025 18:29:14 +0000
Message-ID: <498fc518-d78a-43a4-9196-507891e9b844@suse.cz>
Date: Sat, 16 Aug 2025 20:31:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/14] SLUB percpu sheaves
To: Sudarsan Mahendran <sudarsanm@google.com>,
 Harry Yoo <harry.yoo@oracle.com>
Cc: Liam.Howlett@oracle.com, cl@gentwo.org, howlett@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 maple-tree@lists.infradead.org, rcu@vger.kernel.org, rientjes@google.com,
 roman.gushchin@linux.dev, surenb@google.com, urezki@gmail.com,
 Greg Thelen <gthelen@google.com>
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250815225259.3012455-2-sudarsanm@google.com> <aKA7180s0HdLfOKc@harry>
 <CAA9mObAiQbAYvzhW---VoqDA6Zsb152p5ePMvbco0xgwyvaB2Q@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <CAA9mObAiQbAYvzhW---VoqDA6Zsb152p5ePMvbco0xgwyvaB2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,gentwo.org,gmail.com,vger.kernel.org,kvack.org,lists.infradead.org,google.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 8/16/25 7:35 PM, Sudarsan Mahendran wrote:
> 
> 
> On Sat, Aug 16, 2025 at 1:06 AM Harry Yoo <harry.yoo@oracle.com
> <mailto:harry.yoo@oracle.com>> wrote:
>>
>> On Fri, Aug 15, 2025 at 03:53:00PM -0700, Sudarsan Mahendran wrote:
>> > Hi Vlastimil,
>> >
>> > I ported this patch series on top of v6.17.
>> > I had to resolve some merge conflicts because of
>> > fba46a5d83ca8decb338722fb4899026d8d9ead2
>> >
>> > The conflict resolution looks like:
>> >
>> > @@ -5524,20 +5335,19 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
>> >  int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>> >  {
>> >         MA_WR_STATE(wr_mas, mas, entry);
>> > -       int ret = 0;
>> > -       int request;
>> >
>> >         mas_wr_prealloc_setup(&wr_mas);
>> >         mas->store_type = mas_wr_store_type(&wr_mas);
>> > -       request = mas_prealloc_calc(&wr_mas, entry);
>> > -       if (!request)
>> > +       mas_prealloc_calc(&wr_mas, entry);
>> > +       if (!mas->node_request)
>> >                 goto set_flag;
>> >
>> >         mas->mas_flags &= ~MA_STATE_PREALLOC;
>> > -       mas_node_count_gfp(mas, request, gfp);
>> > +       mas_alloc_nodes(mas, gfp);
>> >         if (mas_is_err(mas)) {
>> > -               mas_set_alloc_req(mas, 0);
>> > -               ret = xa_err(mas->node);
>> > +               int ret = xa_err(mas->node);
>> > +
>> > +               mas->node_request = 0;
>> >                 mas_destroy(mas);
>> >                 mas_reset(mas);
>> >                 return ret;
>> > @@ -5545,7 +5355,7 @@ int mas_preallocate(struct ma_state *mas, void
> *entry, gfp_t gfp)
>> >
>> >  set_flag:
>> >         mas->mas_flags |= MA_STATE_PREALLOC;
>> > -       return ret;
>> > +       return 0;
>> >  }
>> >  EXPORT_SYMBOL_GPL(mas_preallocate);
>> >
>> >
>> >
>> > When I try to boot this kernel, I see kernel panic
>> > with rcu_free_sheaf() doing recursion into __kmem_cache_free_bulk()
>> >
>> > Stack trace:
>> >
>> > [    1.583673] Oops: stack guard page: 0000 [#1] SMP NOPTI
>> > [    1.583676] CPU: 103 UID: 0 PID: 0 Comm: swapper/103 Not tainted
> 6.17.0-smp-sheaves2 #1 NONE
>> > [    1.583679] RIP: 0010:__kmem_cache_free_bulk+0x57/0x540
>> > [    1.583684] Code: 48 85 f6 0f 84 b8 04 00 00 49 89 d6 49 89 ff 48
> 85 ff 0f 84 fe 03 00 00 49 83 7f 08 00 0f 84 f3 03 00 00 0f 1f 44 00 00
> 31 c0 <48> 89 44 24 18 65 8b 05 6d 26 dc 02 89 44 24 2c 31 ff 89 f8 c7 44
>> > [    1.583685] RSP: 0018:ff40dbc49b048fc0 EFLAGS: 00010246
>> > [    1.583687] RAX: 0000000000000000 RBX: 0000000000000012 RCX:
> ffffffff939e8640
>> > [    1.583687] RDX: ff2afe75213e6c90 RSI: 0000000000000012 RDI:
> ff2afe750004ad00
>> > [    1.583688] RBP: ff40dbc49b049130 R08: ff2afe75368c2500 R09:
> ff2afe75368c3b00
>> > [    1.583689] R10: ff2afe75368c2500 R11: ff2afe75368c3b00 R12:
> ff2aff31ba00b000
>> > [    1.583690] R13: ffffffff939e8640 R14: ff2afe75213e6c90 R15:
> ff2afe750004ad00
>> > [    1.583690] FS:  0000000000000000(0000) GS:ff2aff31ba00b000(0000)
> knlGS:0000000000000000
>> > [    1.583691] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > [    1.583692] CR2: ff40dbc49b048fb8 CR3: 0000000017c3e001 CR4:
> 0000000000771ef0
>> > [    1.583692] PKRU: 55555554
>> > [    1.583693] Call Trace:
>> > [    1.583694]  <IRQ>
>> > [    1.583696]  __kmem_cache_free_bulk+0x2c7/0x540
>>
>> [..]
>>
>> > [    1.583759]  __kmem_cache_free_bulk+0x2c7/0x540
>>
>> Hi Sudarsan, thanks for the report.
>>
>> I'm not really sure how __kmem_cache_free_bulk() can call itself.
>> There's no recursion of __kmem_cache_free_bulk() in the code.
> Hi Harry,
> 
> I assume somehow the free_to_pcs_bulk() fallback case is taken, thus
> calling __kmem_cache_free_bulk(), which calls free_to_pcs_bulk() ad nauseam.

Could it be a rebase gone wrong? Mine to 6.17-rc1 is here (but untested)

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/
> free_to_pcs_bulk()
> {
> ...
> fallback:
>         __kmem_cache_free_bulk(s, size, p);
> ...
> }
> 
> static void __kmem_cache_free_bulk(struct kmem_cache *s, size_t size,
> void **p)

I don't have this, this codes seems to correspond to my
kmem_cache_free_bulk(), while __kmem_cache_free_bulk() is just
build_detached_freelist() and do_slab_free() with no sheaves involved.

> {
>         if (!size)
>                 return;
> 
>         /*
>          * freeing to sheaves is so incompatible with the detached
> freelist so
>          * once we go that way, we have to do everything differently
>          */
>         if (s && s->cpu_sheaves) {
>                 free_to_pcs_bulk(s, size, p);
>                 return;
>         }
> ...
> 
> Thanks Greg for pointing this out.
> 
> 
>> As v6.17-rc1 is known to cause a few surprising bugs, could you please
>> rebase onto of mm-hotfixes-unstable and check if it still reproduces?
>>
>> > [    1.583761]  ? update_group_capacity+0xad/0x1f0
>> > [    1.583763]  ? sched_balance_rq+0x4f6/0x1e80
>> > [    1.583765]  __kmem_cache_free_bulk+0x2c7/0x540
>> > [    1.583767]  ? update_irq_load_avg+0x35/0x480
>> > [    1.583768]  ? __pfx_rcu_free_sheaf+0x10/0x10
>> > [    1.583769]  rcu_free_sheaf+0x86/0x110
>> > [    1.583771]  rcu_do_batch+0x245/0x750
>> > [    1.583772]  rcu_core+0x13a/0x260
>> > [    1.583773]  handle_softirqs+0xcb/0x270
>> > [    1.583775]  __irq_exit_rcu+0x48/0xf0
>> > [    1.583776]  sysvec_apic_timer_interrupt+0x74/0x80
>> > [    1.583778]  </IRQ>
>> > [    1.583778]  <TASK>
>> > [    1.583779]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
>> > [    1.583780] RIP: 0010:cpuidle_enter_state+0x101/0x290
>> > [    1.583781] Code: 85 f4 ff ff 49 89 c4 8b 73 04 bf ff ff ff ff e8
> d5 44 d4 ff 31 ff e8 9e c7 37 ff 80 7c 24 04 00 74 05 e8 12 45 d4 ff fb
> 85 ed <0f> 88 ba 00 00 00 89 e9 48 6b f9 68 4c 8b 44 24 08 49 8b 54 38 30
>> > [    1.583782] RSP: 0018:ff40dbc4809afe80 EFLAGS: 00000202
>> > [    1.583782] RAX: ff2aff31ba00b000 RBX: ff2afe75614b0800 RCX:
> 000000005e64b52b
>> > [    1.583783] RDX: 000000005e73f761 RSI: 0000000000000067 RDI:
> 0000000000000000
>> > [    1.583783] RBP: 0000000000000002 R08: fffffffffffffff6 R09:
> 0000000000000000
>> > [    1.583784] R10: 0000000000000380 R11: ffffffff908c38d0 R12:
> 000000005e64b535
>> > [    1.583784] R13: 000000005e5580da R14: ffffffff92890b10 R15:
> 0000000000000002
>> > [    1.583784]  ? __pfx_read_tsc+0x10/0x10
>> > [    1.583787]  cpuidle_enter+0x2c/0x40
>> > [    1.583788]  do_idle+0x1a7/0x240
>> > [    1.583790]  cpu_startup_entry+0x2a/0x30
>> > [    1.583791]  start_secondary+0x95/0xa0
>> > [    1.583794]  common_startup_64+0x13e/0x140
>> > [    1.583796]  </TASK>
>> > [    1.583796] Modules linked in:
>> > [    1.583798] ---[ end trace 0000000000000000 ]---
>> > [    1.583798] RIP: 0010:__kmem_cache_free_bulk+0x57/0x540
>> > [    1.583800] Code: 48 85 f6 0f 84 b8 04 00 00 49 89 d6 49 89 ff 48
> 85 ff 0f 84 fe 03 00 00 49 83 7f 08 00 0f 84 f3 03 00 00 0f 1f 44 00 00
> 31 c0 <48> 89 44 24 18 65 8b 05 6d 26 dc 02 89 44 24 2c 31 ff 89 f8 c7 44
>> > [    1.583800] RSP: 0018:ff40dbc49b048fc0 EFLAGS: 00010246
>> > [    1.583801] RAX: 0000000000000000 RBX: 0000000000000012 RCX:
> ffffffff939e8640
>> > [    1.583801] RDX: ff2afe75213e6c90 RSI: 0000000000000012 RDI:
> ff2afe750004ad00
>> > [    1.583801] RBP: ff40dbc49b049130 R08: ff2afe75368c2500 R09:
> ff2afe75368c3b00
>> > [    1.583802] R10: ff2afe75368c2500 R11: ff2afe75368c3b00 R12:
> ff2aff31ba00b000
>> > [    1.583802] R13: ffffffff939e8640 R14: ff2afe75213e6c90 R15:
> ff2afe750004ad00
>> > [    1.583802] FS:  0000000000000000(0000) GS:ff2aff31ba00b000(0000)
> knlGS:0000000000000000
>> > [    1.583803] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > [    1.583803] CR2: ff40dbc49b048fb8 CR3: 0000000017c3e001 CR4:
> 0000000000771ef0
>> > [    1.583803] PKRU: 55555554
>> > [    1.583804] Kernel panic - not syncing: Fatal exception in interrupt
>> > [    1.584659] Kernel Offset: 0xf600000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> >
>> >


