Return-Path: <linux-kernel+bounces-837580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C381BACAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A3018935A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1985E262FC5;
	Tue, 30 Sep 2025 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJnORWlf"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9164C98
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231170; cv=none; b=XgV8qITVCeQ2K15DwjBY5ZAUf3oAwvQbFOg4S1suHi0O3643Ur45dtRV+8a+rKsw+cOjYJV5+Q1X03N/wpdH0atcCRf3VCDbfJsrFL3araESfiCtZjFR4XyLKpWHwYBgJwHhaKuPqxLsim7oR8ifzLKRbqBmaYIhkZukY15hMKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231170; c=relaxed/simple;
	bh=GCZlpn9CjRT/k1IQPc49AYA4DPeOTwZpqqTvJvZWk1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCAYRn6z+iNoeMYfPmBnakf3QuvX231FYiSm9ZvseoxpP0E6Z4x2N4fX7CRKA0KlzgYvi0qUcZhT0QXJjNEAqnxzvCqhsgpYfzd9Y90eDZVyNpMb1jf5NC+6hgu5ISOQSkCufKHGjAZboeiwWsXdEeSFUpIFRr2yMA2C0KcuAwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJnORWlf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so32893035e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759231167; x=1759835967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ypq+/ajxaG4je7HYmcqvMA1fKurMa0dGhCUD1PNUx50=;
        b=CJnORWlf65L1/v/xaCtAawrfe+r+7qsncQSC3rn9LTPI8a6pwWwQgsLFOHbKoLHU4K
         tj4oRvFylMddKEOZmBMwmFTRbdsuXBQRxdi+wnuxSaeyE1LyBIn8S5zY1t2p7pvGEyTL
         D2r0qj3s1RqOktSGeLIUUlbViSxLfMM9EjSHGsa3e2DBkshvVxGvamHyYvRhjuH86od1
         DYrl1HB5jlwHZy2jdsKUSxzBvbynMkQuqmDXGLqy+jKWOv+z3upsCX/JWhQQfskuHgOE
         Xa2H2tb6R6QufsGGcZhPmrEt4l1VYq3qM7DrherJYnrrXXFkcnY9cN5XE5r4PhQjJPKh
         5Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759231167; x=1759835967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ypq+/ajxaG4je7HYmcqvMA1fKurMa0dGhCUD1PNUx50=;
        b=c1z4K7jVYkOgqnGl8L1QBFkrL4KyI2XWtx8VzYjtUdb8qjLriwwBRlNyrikdP9bp/j
         /8M4AFrFlS838GJcapeDvGw5M9a0MRrJEYzqHV57RascSUuVxNpwe3LXKTTcKDbfNOOd
         0E03DTn5XxlW55lrnIICDdkBhzGukEEx/LX8olhZdOwvlTMFCJWHcJzon8gGGqdueJYU
         c+0lxGkKdr0/PxayRHdwwyG4yuvK4oynTTvbuKDuOwJctQ/C30DtBm+U1TgGiMcMmkAC
         VyBLFJraPJStyYTZRgt6Z157EwvsSt8Jlw1py/5AWUTannMTT2BQuzyLnqWvNS1Ff2td
         VrsA==
X-Forwarded-Encrypted: i=1; AJvYcCXa1X2P6XNbZOOUO3XaVkv8SEh18wk4t9shszsTq/vdaWiJykWxtvSG8uqGXFxPUdVr73NL7g1ZUeUaRro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFnUwTFb8vsUbO+T9wZHVurJUrvcQnGAlo42DJmtwaRtDvuZYq
	O/jWvLRqNO7d7WKG6gwXIZqWKwU9FJB1iu5rDifB4EbPmUC0dLmeuo76ETVmw33Gt6+XMwz3r5r
	W4Itxr4x+uf10Bks4l3i+inTi7kl1/kA=
X-Gm-Gg: ASbGnctW2fhP/1sXy79vqRtSEbC7I2otAxYpwiJTjwzdMtBhmcMGOQSR2GwLsyW/hUr
	iuw/pUVP3bFBL0KNfORFpfKHkyCF+VDqjRPDwDY+u9exmq/SGn18JbE7KaY91x6i7LPTFmDVKca
	qNyRUdgFZugE1ShFcR0LUxs1jR9qQNdblfdFXbT9igVrgPvQiXXEAM01LNzPCE+nNZuMrSIByRC
	hQxT8DzabCD0P1c+HPwvcmkAjp6ChYZ+Y5Yiq/2ER512axdBMdZag==
X-Google-Smtp-Source: AGHT+IFZ1fMTMwFHtaeQpXybp0NxecATfP4lqnf9y7TiHPos/hXiuxUHuUdy25b4V0fv4saKSFcmKIqnb2NB8ydX8Ww=
X-Received: by 2002:a05:600c:6303:b0:46e:37a3:3ec1 with SMTP id
 5b1f17b1804b1-46e37a34304mr173099175e9.24.1759231166709; Tue, 30 Sep 2025
 04:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930083402.782927-1-ranxiaokai627@163.com> <aNu2xJMkEyYSdmW6@hyeyoo>
In-Reply-To: <aNu2xJMkEyYSdmW6@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Sep 2025 13:19:15 +0200
X-Gm-Features: AS18NWDoOuauUwUhU_r-pegvcK1zYn6qFC4ElDPwWAuR9qeK68FX3q_eHNFaYvg
Message-ID: <CAADnVQJ-bkd2UVsZmhdb1L5ZrXjZbTnRcaJ-D=ojsoiRHmHwaw@mail.gmail.com>
Subject: Re: [PATCH] slab: Fix using this_cpu_ptr() in preemptible context
To: Harry Yoo <harry.yoo@oracle.com>
Cc: ranxiaokai627@163.com, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, cl@gentwo.org, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, ran.xiaokai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 12:54=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> w=
rote:
>
> On Tue, Sep 30, 2025 at 08:34:02AM +0000, ranxiaokai627@163.com wrote:
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >
> > defer_free() maybe called in preemptible context, this will
> > trigger the below warning message:
> >
> > BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0=
/1
> > caller is defer_free+0x1b/0x60
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0xac/0xc0
> >  check_preemption_disabled+0xbe/0xe0
> >  defer_free+0x1b/0x60
> >  kfree_nolock+0x1eb/0x2b0
> >  alloc_slab_obj_exts+0x356/0x390

Please share config and repro details, since the stack trace
looks theoretical, but you somehow got it?
This is not CONFIG_SLUB_TINY, but kfree_nolock()
sees locked per-cpu slab?
Is this PREEMPT_RT ?

> >  __alloc_tagging_slab_alloc_hook+0xa0/0x300
> >  __kmalloc_cache_noprof+0x1c4/0x5c0
> >  __set_page_owner+0x10d/0x1c0
> >  post_alloc_hook+0x84/0xf0
> >  get_page_from_freelist+0x73b/0x1380
> >  __alloc_frozen_pages_noprof+0x110/0x2c0
> >  alloc_pages_mpol+0x44/0x140
> >  alloc_slab_page+0xac/0x150
> >  allocate_slab+0x78/0x3a0
> >  ___slab_alloc+0x76b/0xed0
> >  __slab_alloc.constprop.0+0x5a/0xb0
> >  __kmalloc_noprof+0x3dc/0x6d0
> >  __list_lru_init+0x6c/0x210
> >  alloc_super+0x3b6/0x470
> >  sget_fc+0x5f/0x3a0
> >  get_tree_nodev+0x27/0x90
> >  vfs_get_tree+0x26/0xc0
> >  vfs_kern_mount.part.0+0xb6/0x140
> >  kern_mount+0x24/0x40
> >  init_pipe_fs+0x4f/0x70
> >  do_one_initcall+0x62/0x2e0
> >  kernel_init_freeable+0x25b/0x4b0
> >  kernel_init+0x1a/0x1c0
> >  ret_from_fork+0x290/0x2e0
> >  ret_from_fork_asm+0x11/0x20
> > </TASK>
> >
> > Replace this_cpu_ptr with raw_cpu_ptr to eliminate
> > the above warning message.
> >
> > Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock=
().")
>
> There's no mainline commit hash yet, should be adjusted later.
>
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > ---
> >  mm/slub.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 1433f5b988f7..67c57f1b5a86 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -6432,7 +6432,7 @@ static void free_deferred_objects(struct irq_work=
 *work)
> >
> >  static void defer_free(struct kmem_cache *s, void *head)
> >  {
> > -     struct defer_free *df =3D this_cpu_ptr(&defer_free_objects);
> > +     struct defer_free *df =3D raw_cpu_ptr(&defer_free_objects);
>
> This suppresses warning, but let's answer the question;
> Is it actually safe to not disable preemption here?
>
> >       if (llist_add(head + s->offset, &df->objects))
>
> Let's say a task was running on CPU X and migrated to a different CPU
> (say, Y) after returning from llist_add() or before calling llist_add(),
> then we're queueing the irq_work of CPU X on CPU Y.
>
> I think technically this should be safe because, although we're using
> per-cpu irq_work here, the irq_work framework itself is designed to handl=
e
> concurrent access from multiple CPUs (otherwise it won't be safe to use
> a global irq_work like in other places) by using lockless list, which
> uses try_cmpxchg() and xchg() for atomic update.
>
> So if I'm not missing something it should be safe, but it was very
> confusing to confirm that it's safe as we're using per-cpu irq_work...
>
> I don't think these paths are very performance critical, so why not disab=
le
> preemption instead of replacing it with raw_cpu_ptr()?

+1.
Though irq_work_queue() works for any irq_work it should
be used for current cpu, since it IPIs itself.
So pls use guard(preempt)(); instead.

