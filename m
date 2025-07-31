Return-Path: <linux-kernel+bounces-752236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 475D2B172D1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0DAC3AB83F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA5A2D1301;
	Thu, 31 Jul 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcCtgOfM"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD932D191F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970817; cv=none; b=Xbw+JAMwj/4zvlGDZWBU8KqFguC5co0ruNhi37b1RIK4YtS0WlnQ6u1RQ9corBC933FMAwUuCOTKFUgDlfU88ay8sth80LVbkHYTEnzv/YcZno2qCQKxM0DCuehZv0/ZLNeeIrM0Javc0MYCNLLbpHA89kR7LTgqXCoyq5vB3/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970817; c=relaxed/simple;
	bh=NMrqV4p7/MO3B+0XEzEB3+2k0TbnbXs78W5/4/4kw+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIhea1PqAIhHVy3IOOXYpd3x06Q5Drfq70KaVsD6yiYChJWbv4AMQr6f8rti96Hve9Uw9hIyuI/4cJziA1sXEdpsPJ/hzO83I/S+4R1J0emPKGnJAd8FhKHVpCsULw9WJ7LDbUqU4A27/c/norFv3zabKDrt19/AmLvcJsTEak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZcCtgOfM; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4aef56cea5bso173051cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753970814; x=1754575614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5llqPpJXMsP4dyiOE7WVZDK0are7sugahLuBxo/1+k=;
        b=ZcCtgOfMg58cdoeByRhzLwZ0e/tjK2B7xosbg/nU22HcB4x+XR2CfhgdDYY3rah8K9
         RK7eJP9avZvfC3baOjMX/WxALNXw1PDZdMePadOj+uIpccm7Qob14mlvOFN+arJqUdqs
         LHn2ofPZcz4O5BuryyTew/NCjEjJ5SRITGdhejX3NrX+lnIHQ4okDiJCisO9XfR/dW1k
         cHnezCG+rGJXfEbjRyfnzPhVgchDgrgKSp5EI9HPwnOeLRsJzpRTMAwVRWyq8vq1LCHK
         X7gXMt2FKY+9+0VC28qnlH9YlO3og4UsudWp5cyvD1ohx1E5PCtF2kYNDCv41FWdmFzK
         ijzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753970814; x=1754575614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5llqPpJXMsP4dyiOE7WVZDK0are7sugahLuBxo/1+k=;
        b=EMn3cC1N+nuxhgpU565s5ukYfMZcu17IpouAAHV3w2W2zGYGJz6W/yXi1lO61jMO2/
         c6TFi6ktqkbJgRa4LxFmdFHi0NOAhQHtgkeVDn75JBv3upXfa+YjmObCAdBsjDF2whhX
         XChMQlbuUyX6CyawpcmhUjEM+TFjFb60KhSEkggM0aq/l5hl/+Z5sS4Mfno32uJIg44T
         P1TB7RWsSmdQevfcfaebIarvuY+P0V2p01q3GaZWBzXA+m53aPX9Q1Oj8n5E7kzMnyjF
         /f/aH5WHS7YIOMpdo+fsPNsDxlysrolUuyWutTNS153hDncXah/movxCXDOllPeurbZ0
         M25g==
X-Forwarded-Encrypted: i=1; AJvYcCVKzrXpMRW/+c3tsN6JuW1KtDH/yO4bETYiUd2pLM4JAlJAX+FYUpDRqdbK26h36D1itLEAod55ZEdBOkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lIER67cLe8RCDh+WwiAHkayCydq9/rxtlrVWaZ3iILZ2CTo0
	jd4h7GM2MxpcwaSh3S3plbrc1U+niPr8h68+6iOpKNUmCkQnMQE0eu24QfMNVeu9g0jRJ+Haf9f
	7qQJwWFiat+OCwT37jpv40W+y81JQNVFBljCiLEQk
X-Gm-Gg: ASbGncsi6sH81ctHiReQ+1xigkDDZ0ncgqwxjQhNTshyK5g9VhRrGNC308wIGT5toIT
	NSUbr5g89dFeIXvHI5gKzT1xvGsvxsY9j2ybPYvUuf2RAvgB2UbbkmqHTCM+IIwGgBOkCAfnmth
	ap9BEd1ymN+zuR8tOGGAYBcrjnlYR9uIi+g+WOYAujddHF0w6GeMAVALAHOUbqxVXFeWw7GROBZ
	hBXeKpFX2l/KjMMI/DB+jluIwaZ/cbfA7wHGdp18XJ5384L
X-Google-Smtp-Source: AGHT+IH894GUjoNkeB0Z3QhzK4zS1IfDtEIXzaqbkWM3GLmY6MT9yOgEys4UdzkQZOFuTZF90gyM9yVt1DOWcXZWAE8=
X-Received: by 2002:a05:622a:255:b0:4a9:d263:dbc5 with SMTP id
 d75a77b69052e-4aeeff8921bmr4032981cf.20.1753970813106; Thu, 31 Jul 2025
 07:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731013405.4066346-1-surenb@google.com> <20250731013405.4066346-2-surenb@google.com>
 <6b0425c6-799e-4ff5-9238-66d8c5d49e0c@lucifer.local>
In-Reply-To: <6b0425c6-799e-4ff5-9238-66d8c5d49e0c@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 31 Jul 2025 07:06:41 -0700
X-Gm-Features: Ac12FXz9HkV6Tq_9Ps68E_Qex5JesP_P6HoRaBG97K_fDdg2OQAZm5bv3sLXtGE
Message-ID: <CAJuCfpEyh64aHhBFkFt6_u3f9sk1RXBd4Xxy80voMsyy7Unpsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: change vma_start_read() to drop RCU lock on failure
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, jannh@google.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 4:49=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> So this patch is broken :P

Ugh, sorry about that. I must have had lockdep disabled when testing this..=
.

>
> Am getting:
>
> [    2.002807] ------------[ cut here ]------------
> [    2.003014] Voluntary context switch within RCU read-side critical sec=
tion!
> [    2.003022] WARNING: CPU: 1 PID: 202 at kernel/rcu/tree_plugin.h:332 r=
cu_note_context_switch+0x506/0x580
> [    2.003643] Modules linked in:
> [    2.003765] CPU: 1 UID: 0 PID: 202 Comm: dhcpcd Not tainted 6.16.0-rc5=
+ #41 PREEMPT(voluntary)
> [    2.004103] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S Arch Linux 1.17.0-1-1 04/01/2014
> [    2.004460] RIP: 0010:rcu_note_context_switch+0x506/0x580
> [    2.004669] Code: 00 00 00 0f 85 f5 fd ff ff 49 89 90 a8 00 00 00 e9 e=
9 fd ff ff c6 05 86 69 90 01 01 90 48 c7 c7 98 c3 90 b8 e8 cb b4 f5 ff 90 <=
0f> 0b 90 90 e9 38 fb ff ff 48 8b 7d 20 48 89 3c 24 e8 64 26 d5 00
> [    2.005382] RSP: 0018:ffffb36b40607aa8 EFLAGS: 00010082
> [    2.005585] RAX: 000000000000003f RBX: ffff9c044128ad00 RCX: 000000000=
0000027
> [    2.005866] RDX: ffff9c0577c97f48 RSI: 0000000000000001 RDI: ffff9c057=
7c97f40
> [    2.006136] RBP: ffff9c0577ca9f80 R08: 40000000ffffe1f7 R09: 000000000=
0000000
> [    2.006411] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [    2.006692] R13: ffff9c04fb0423d0 R14: ffffffffb82e2600 R15: ffff9c044=
128ad00
> [    2.006968] FS:  00007fd12e7d9740(0000) GS:ffff9c05be614000(0000) knlG=
S:0000000000000000
> [    2.007281] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.007498] CR2: 00007ffe2f0d2798 CR3: 00000001bb8b1000 CR4: 000000000=
0750ef0
> [    2.007770] PKRU: 55555554
> [    2.007880] Call Trace:
> [    2.007985]  <TASK>
> [    2.008076]  __schedule+0x94/0xee0
> [    2.008212]  ? __pfx_bit_wait_io+0x10/0x10
> [    2.008370]  schedule+0x22/0xd0
> [    2.008517]  io_schedule+0x41/0x60
> [    2.008653]  bit_wait_io+0xc/0x60
> [    2.008783]  __wait_on_bit+0x25/0x90
> [    2.008925]  out_of_line_wait_on_bit+0x85/0x90
> [    2.009104]  ? __pfx_wake_bit_function+0x10/0x10
> [    2.009288]  __ext4_find_entry+0x2b2/0x470
> [    2.009449]  ? __d_alloc+0x117/0x1d0
> [    2.009591]  ext4_lookup+0x6b/0x1f0
> [    2.009733]  path_openat+0x895/0x1030
> [    2.009880]  do_filp_open+0xc3/0x150
> [    2.010021]  ? do_anonymous_page+0x5b1/0xae0
> [    2.010195]  do_sys_openat2+0x76/0xc0
> [    2.010339]  __x64_sys_openat+0x4f/0x70
> [    2.010490]  do_syscall_64+0xa4/0x260
> [    2.010638]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [    2.010840] RIP: 0033:0x7fd12e0a2006
> [    2.010984] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 19 8=
3 e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45 10 0f 05 <=
48> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
>
> and
>
> [   23.004231] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [   23.004464] rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-3): P20=
2/6:b..l
> [   23.004736] rcu:     (detected by 2, t=3D21002 jiffies, g=3D-663, q=3D=
940 ncpus=3D4)
> [   23.004992] task:dhcpcd          state:S stack:0     pid:202   tgid:20=
2   ppid:196    task_flags:0x400140 flags:0x00004002
> [   23.005416] Call Trace:
> [   23.005515]  <TASK>
> [   23.005603]  __schedule+0x3ca/0xee0
> [   23.005754]  schedule+0x22/0xd0
> [   23.005878]  schedule_hrtimeout_range_clock+0xf2/0x100
> [   23.006075]  poll_schedule_timeout.constprop.0+0x32/0x80
> [   23.006281]  do_sys_poll+0x3bb/0x550
> [   23.006424]  ? __pfx_pollwake+0x10/0x10
> [   23.006573]  ? __pfx_pollwake+0x10/0x10
> [   23.006712]  ? __pfx_pollwake+0x10/0x10
> [   23.006848]  __x64_sys_ppoll+0xc9/0x160
> [   23.006993]  do_syscall_64+0xa4/0x260
> [   23.007140]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   23.007339] RIP: 0033:0x7fd12e0a2006
> [   23.007483] RSP: 002b:00007ffe2f0f28e0 EFLAGS: 00000202 ORIG_RAX: 0000=
00000000010f
> [   23.007770] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd12=
e0a2006
> [   23.008035] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 000055abb=
0c5ae20
> [   23.008309] RBP: 00007ffe2f0f2900 R08: 0000000000000008 R09: 000000000=
0000000
> [   23.008588] R10: 00007ffe2f0f2c80 R11: 0000000000000202 R12: 000055abb=
0c3cd80
> [   23.008869] R13: 00007ffe2f0f2c80 R14: 000055ab9297b5c0 R15: 000000000=
0000000
> [   23.009141]  </TASK>
>
> Here.
>
> I identify the bug below.
>
> On Wed, Jul 30, 2025 at 06:34:04PM -0700, Suren Baghdasaryan wrote:
> > vma_start_read() can drop and reacquire RCU lock in certain failure
> > cases. It's not apparent that the RCU session started by the caller of
> > this function might be interrupted when vma_start_read() fails to lock
> > the vma. This might become a source of subtle bugs and to prevent that
> > we change the locking rules for vma_start_read() to drop RCU read lock
> > upon failure. This way it's more obvious that RCU-protected objects are
> > unsafe after vma locking fails.
> >
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/mmap_lock.c | 76 +++++++++++++++++++++++++++++---------------------
> >  1 file changed, 44 insertions(+), 32 deletions(-)
> >
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > index 10826f347a9f..0129db8f652f 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -136,15 +136,21 @@ void vma_mark_detached(struct vm_area_struct *vma=
)
> >   * Returns the vma on success, NULL on failure to lock and EAGAIN if v=
ma got
> >   * detached.
> >   *
> > - * WARNING! The vma passed to this function cannot be used if the func=
tion
> > - * fails to lock it because in certain cases RCU lock is dropped and t=
hen
> > - * reacquired. Once RCU lock is dropped the vma can be concurently fre=
ed.
> > + * WARNING! On entrance to this function RCU read lock should be held =
and it
> > + * is released if function fails to lock the vma, therefore vma passed=
 to this
> > + * function cannot be used if the function fails to lock it.
> > + * When vma is successfully locked, RCU read lock is kept intact and R=
CU read
> > + * session is not interrupted. This is important when locking is done =
while
> > + * walking the vma tree under RCU using vma_iterator because if the RC=
U lock
> > + * is dropped, the iterator becomes invalid.
> >   */
>
> I feel like this is a bit of a wall of noise, can we add a clearly separa=
ted line like:
>
>         ...
>         *
>
>         * IMPORTANT: RCU lock must be held upon entering the function, bu=
t
>         *            upon error IT IS RELEASED. The caller must handle th=
is
>         *            correctly.
>         */

Are you suggesting to replace my comment or amend it with this one? I
think the answer is "replace" but I want to confirm.

>
> >  static inline struct vm_area_struct *vma_start_read(struct mm_struct *=
mm,
> >                                                   struct vm_area_struct=
 *vma)
> >  {
>
> I was thinking we could split this out into a wrapper __vma_start_read()
> function but then the stability check won't really fit properly so never
> mind :)
>
> > +     struct mm_struct *other_mm;
> >       int oldcnt;
> >
> > +     RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu lock held");
>
> Good to add this.
>
> >       /*
> >        * Check before locking. A race might cause false locked result.
> >        * We can use READ_ONCE() for the mm_lock_seq here, and don't nee=
d
> > @@ -152,8 +158,10 @@ static inline struct vm_area_struct *vma_start_rea=
d(struct mm_struct *mm,
> >        * we don't rely on for anything - the mm_lock_seq read against w=
hich we
> >        * need ordering is below.
> >        */
> > -     if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(mm->mm_lock_seq.=
sequence))
> > -             return NULL;
> > +     if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(mm->mm_lock_seq.=
sequence)) {
> > +             vma =3D NULL;
> > +             goto err;
> > +     }
> >
> >       /*
> >        * If VMA_LOCK_OFFSET is set, __refcount_inc_not_zero_limited_acq=
uire()
> > @@ -164,7 +172,8 @@ static inline struct vm_area_struct *vma_start_read=
(struct mm_struct *mm,
> >       if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_re=
fcnt, &oldcnt,
> >                                                             VMA_REF_LIM=
IT))) {
> >               /* return EAGAIN if vma got detached from under us */
> > -             return oldcnt ? NULL : ERR_PTR(-EAGAIN);
> > +             vma =3D oldcnt ? NULL : ERR_PTR(-EAGAIN);
> > +             goto err;
> >       }
> >
> >       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> > @@ -175,23 +184,8 @@ static inline struct vm_area_struct *vma_start_rea=
d(struct mm_struct *mm,
> >        * is dropped and before rcuwait_wake_up(mm) is called. Grab it b=
efore
> >        * releasing vma->vm_refcnt.
> >        */
>
> I feel like this comment above should be moved below to where the 'action=
' is.

Ack.

>
> > -     if (unlikely(vma->vm_mm !=3D mm)) {
> > -             /* Use a copy of vm_mm in case vma is freed after we drop=
 vm_refcnt */
> > -             struct mm_struct *other_mm =3D vma->vm_mm;
> > -
> > -             /*
> > -              * __mmdrop() is a heavy operation and we don't need RCU
> > -              * protection here. Release RCU lock during these operati=
ons.
> > -              * We reinstate the RCU read lock as the caller expects i=
t to
> > -              * be held when this function returns even on error.
> > -              */
> > -             rcu_read_unlock();
> > -             mmgrab(other_mm);
> > -             vma_refcount_put(vma);
> > -             mmdrop(other_mm);
> > -             rcu_read_lock();
> > -             return NULL;
> > -     }
> > +     if (unlikely(vma->vm_mm !=3D mm))
> > +             goto err_unstable;
> >
> >       /*
> >        * Overflow of vm_lock_seq/mm_lock_seq might produce false locked=
 result.
> > @@ -206,10 +200,26 @@ static inline struct vm_area_struct *vma_start_re=
ad(struct mm_struct *mm,
> >        */
> >       if (unlikely(vma->vm_lock_seq =3D=3D raw_read_seqcount(&mm->mm_lo=
ck_seq))) {
> >               vma_refcount_put(vma);
> > -             return NULL;
> > +             vma =3D NULL;
> > +             goto err;
> >       }
> >
> >       return vma;
> > +err:
> > +     rcu_read_unlock();
> > +
> > +     return vma;
> > +err_unstable:
>
> Move comment above here I think.

Got it.

>
> > +     /* Use a copy of vm_mm in case vma is freed after we drop vm_refc=
nt */
> > +     other_mm =3D vma->vm_mm;
> > +
> > +     /* __mmdrop() is a heavy operation, do it after dropping RCU lock=
. */
> > +     rcu_read_unlock();
> > +     mmgrab(other_mm);
> > +     vma_refcount_put(vma);
> > +     mmdrop(other_mm);
> > +
> > +     return NULL;
> >  }
> >
> >  /*
> > @@ -223,8 +233,8 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm=
_struct *mm,
> >       MA_STATE(mas, &mm->mm_mt, address, address);
> >       struct vm_area_struct *vma;
> >
> > -     rcu_read_lock();
> >  retry:
> > +     rcu_read_lock();
> >       vma =3D mas_walk(&mas);
> >       if (!vma)
> >               goto inval;
>                 ^
>                 |---- this is incorrect, you took the RCU read lock above=
, but you don't unlock... :)
>
> You can fix easily with:
>
>         if (!vma) {
>                 rcu_read_unlock();
>                 goto inval;
>         }
>
> Which fixes the issue locally for me.

Yes, I overlooked that here we did not yet attempt to lock the vma. Will fi=
x.
Thanks!

>
> > @@ -241,6 +251,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm=
_struct *mm,
> >               /* Failed to lock the VMA */
> >               goto inval;
> >       }
> > +
> > +     rcu_read_unlock();
> > +
> >       /*
> >        * At this point, we have a stable reference to a VMA: The VMA is
> >        * locked and we know it hasn't already been isolated.
> > @@ -249,16 +262,14 @@ struct vm_area_struct *lock_vma_under_rcu(struct =
mm_struct *mm,
> >        */
> >
> >       /* Check if the vma we locked is the right one. */
> > -     if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
)
> > -             goto inval_end_read;
> > +     if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
) {
> > +             vma_end_read(vma);
> > +             goto inval;
> > +     }
> >
> > -     rcu_read_unlock();
> >       return vma;
> >
> > -inval_end_read:
> > -     vma_end_read(vma);
> >  inval:
> > -     rcu_read_unlock();
> >       count_vm_vma_lock_event(VMA_LOCK_ABORT);
> >       return NULL;
> >  }
> > @@ -313,6 +324,7 @@ struct vm_area_struct *lock_next_vma(struct mm_stru=
ct *mm,
> >                */
> >               if (PTR_ERR(vma) =3D=3D -EAGAIN) {
> >                       /* reset to search from the last address */
> > +                     rcu_read_lock();
> >                       vma_iter_set(vmi, from_addr);
> >                       goto retry;
> >               }
> > @@ -342,9 +354,9 @@ struct vm_area_struct *lock_next_vma(struct mm_stru=
ct *mm,
> >       return vma;
> >
> >  fallback_unlock:
> > +     rcu_read_unlock();
> >       vma_end_read(vma);
> >  fallback:
> > -     rcu_read_unlock();
> >       vma =3D lock_next_vma_under_mmap_lock(mm, vmi, from_addr);
> >       rcu_read_lock();
> >       /* Reinitialize the iterator after re-entering rcu read section *=
/
> > --
> > 2.50.1.552.g942d659e1b-goog
> >

