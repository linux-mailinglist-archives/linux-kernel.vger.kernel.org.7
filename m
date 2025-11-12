Return-Path: <linux-kernel+bounces-896340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC5DC50247
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D93F4E7A28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A951E7C23;
	Wed, 12 Nov 2025 00:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i4BGXkob"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59780219A8E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762908319; cv=none; b=BcCi36PFaLYQL4Dm4TLKHA9u2FBNuazo7lHacsZiVKSTIuOCe5WTnvFc64LFidYUbEpxK8nfjgZ8dgG5s6ouJd8M15oJN3ZFKJ50ywBNpODKJibpI8jq1IVJBmEN+WGqOhbNhgsdCylQ6B0c3S5OmBAS9xX2l3ztQx1OzUWLRzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762908319; c=relaxed/simple;
	bh=lwJTs6uHwfB3pFaBhGYmVTJmlthxkPebRAjqEgLlcXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=UPv3kPMTMsYwCqpW8HhFOtS+rifLZsg2ZZ0T165pEqrJNexVdPcIWMLRdERiH3c0iAx+j7ntyRBKwy7PpBVHp3LgEVlPufmCi9kHipzGhUnjyvc46nt5ho7VmsljaNtWC9iivV9iXRwA15IAHE494QKnqYJ9s6se//qfTDohawg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i4BGXkob; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4edb8d6e98aso175101cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762908316; x=1763513116; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJZAJpAbAEi7uff3FpFnrKv4oBXpITt048DY9Jv0DOM=;
        b=i4BGXkob3F+TnS2JspIPB2wkpU3wGpLlsuRWSc23cvFgDeKKKm0LCmsq+Vd7dnZfvr
         Wfn4VVe+iY3OOtTSN9tceRHjpphq+1tzSGWz+wcjS57CHH1oT7gYhI+M2BjdiGwS5Obq
         EjeOWTw3uuHJzUAtHtWWwG+x5erAB+rWgIefhvoqOWB4D0PsOzzPDQO5Kra1nHHVRCWc
         JagnQQt/tzjYIuDgxW5E1EUFnJykeGJS8BpgCxiQmaXOYuEuBU/4wmvBcocD6uqEW3nL
         aC/gNpR7kCtwysJ6ouyOAWPV2/WdjE6T4vgCJp9q9SNL3AX7JnCHunRSMFxDoyU3krFO
         4icQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762908316; x=1763513116;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UJZAJpAbAEi7uff3FpFnrKv4oBXpITt048DY9Jv0DOM=;
        b=VvZGEhA/XCLd4UmY+PKlwgJPRELz08HZtgRmNacNnfmL7EaFLloij2/bnNARCOawBF
         uFNl0jWdLb0ACyn2hL7Z55zPleImBt4vNI7gfFztm6p2KytAhj1BJUUdy0ly5UDjIrXL
         MyEKAXn0b0w9QjEMjpn8CA13eKj8r3s3p4p0DoivImqNtrHaBUDo2xvRnJDEtHXjFJKd
         NzgyRKSWEbgFSxkKq89fKd4b6TcaZCtAZOBpRIKTHmNYrPsggVrtioBFFCb6ZBWdVjF6
         zO3O+m74lZoUnEIdC9T0g1+bR70IJAYn5Dq6gqLFXhZXPcBZhy8qrgXnUpKUrn+qKH91
         XA+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXd4vGKvo1llhUx0/gDbFfOtwE4C/DpuJEQp7oTuQjKgwqTw3KLMJSzmObMy9lFL5z52EFjdk2zH77xrDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+KxiiV0L9pcm20QKKSXwjnUHRLCLbfMNuK3M19eTxFagGMaO
	jFWlA9ls17SUyOQdJCUsbLDPKpXTUcvHTQJcPrjWRwXP2W8rbbvpw+6DOpqYT1uIk8KRm7ZPxox
	yCOkLWGx6xXPUk/ZAlLVMtuT0baIs+CL0uarLaOED
X-Gm-Gg: ASbGnct4xZIqSbTCOgpJ62l3JJFSih5PMlKz9TqDKzsLDhuKFtNjTStLd9twyC3xzrh
	wyYBymWAouto0gbRPY5mEmkHBRZGTxyANyNg5oGaFi/alhhPkIAayBF4GnaR/ls7E/VXFQ5cjPn
	0tMZ9RK09Bnom957nB+MPxo4friny4lBr66eAbpNylJCQPLczGUNEy2i7Zfbw/TTJ37UOWKkdnk
	EjmP6ql1XlSNrEjli21AiG2ZAashxpavj3VBQ/LPA1PKfZEdqJrcvjwNYpoLr4/MnMgvUzU9YK7
	q79jwFabwqU2a4eBOdze0Ks7iOhcjJ5oD/RfAwn8qpjlmOM=
X-Google-Smtp-Source: AGHT+IHq3zhZ6RZDfm8+qlwrB06Heotrr0OpxA12uYFqb9GHqIYHhe+FtLnMFGAwYOGYRsGMcofhaTJmJdtZLZv+D90=
X-Received: by 2002:ac8:7c4c:0:b0:4ed:2f7d:bd46 with SMTP id
 d75a77b69052e-4eddd0280b2mr1699761cf.13.1762908315789; Tue, 11 Nov 2025
 16:45:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111215605.1721380-1-Liam.Howlett@oracle.com>
 <8219599b-941e-4ffd-875f-6548e217c16c@suse.cz> <CAJuCfpESKECudgqvm8CQ_whi761hWRPAhurR5efRVC4Hp2r8Qw@mail.gmail.com>
 <kfqzb2dfxubn6twcbiu3frihfkf6u34g2rcnui2m63rbc4x4kk@dh3bxvpzpnmp>
In-Reply-To: <kfqzb2dfxubn6twcbiu3frihfkf6u34g2rcnui2m63rbc4x4kk@dh3bxvpzpnmp>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 11 Nov 2025 16:45:03 -0800
X-Gm-Features: AWmQ_bk114MOn3d9XOqHpHR5NA3nrBE7uEUv2RhXge-xST0T5Pe14_lgGcp5zrI
Message-ID: <CAJuCfpEWMD-Z1j=nPYHcQW4F7E2Wka09KTXzGv7VE7oW1S8hcw@mail.gmail.com>
Subject: Re: [PATCH] mm/mmap_lock: Reset maple state on lock_vma_under_rcu() retry
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>, stable@vger.kernel.org, 
	syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 4:20=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [251111 19:11]:
> > On Tue, Nov 11, 2025 at 2:18=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> > >
> > > On 11/11/25 22:56, Liam R. Howlett wrote:
> > > > The retry in lock_vma_under_rcu() drops the rcu read lock before
> > > > reacquiring the lock and trying again.  This may cause a use-after-=
free
> > > > if the maple node the maple state was using was freed.
> >
> > Ah, good catch. I didn't realize the state is RCU protected.
> >
> > > >
> > > > The maple state is protected by the rcu read lock.  When the lock i=
s
> > > > dropped, the state cannot be reused as it tracks pointers to object=
s
> > > > that may be freed during the time where the lock was not held.
> > > >
> > > > Any time the rcu read lock is dropped, the maple state must be
> > > > invalidated.  Resetting the address and state to MA_START is the sa=
fest
> > > > course of action, which will result in the next operation starting =
from
> > > > the top of the tree.
> > > >
> > > > Prior to commit 0b16f8bed19c ("mm: change vma_start_read() to drop =
RCU
> > > > lock on failure"), the rcu read lock was dropped and NULL was retur=
ned,
> > > > so the retry would not have happened.  However, now that the read l=
ock
> > > > is dropped regardless of the return, we may use a freed maple tree =
node
> > > > cached in the maple state on retry.
> >
> > Hmm. The above paragraph does not sound right to me, unless I
> > completely misunderstood it. Before 0b16f8bed19c we would keep RCU
> > lock up until the end of lock_vma_under_rcu(),
>
> Ah.. usually, yes?  But.. if (unlikely(vma->vm_mm !=3D mm)), then we'd
> drop and reacquire the rcu read lock, but return NULL.  This was fine
> because we wouldn't return -EAGIAN and so the read lock was toggled..
> but it didn't matter since we wouldn't reuse the maple state.
>
> I wanted to make it clear that the dropping/reacquiring of the rcu lock
> prior to 0b16f8bed19c does not mean we have to backport the fix
> further.. which I failed to do, I guess.

Ah, ok, now I get it. You were talking about vma_start_read() and RCU
being dropped there... Would this explanation be a bit better?

Prior to commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU
lock on failure"), vma_start_read() would drop rcu read lock and
return NULL, so the retry would not have happened. However, now that
vma_start_read() drops rcu read lock on failure followed by a retry,
we may end up using a freed maple tree node cached in the maple state.

>
> > so retries could still
> > happen but we were not dropping the RCU lock while doing that. After
> > 0b16f8bed19c we drop RCU lock if vma_start_read() fails, so retrying
> > after such failure becomes unsafe. So, if you agree with me assessment
> > then I suggest changing it to:
> >
> > Prior to commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU
> > lock on failure"), the retry after vma_start_read() failure was
> > happening under the same RCU lock. However, now that the read lock is
> > dropped on failure, we may use a freed maple tree node cached in the
> > maple state on retry.
>
> This is also true, but fails to capture the fact that returning NULL
> after toggling the lock prior to 0b16f8bed19c is okay.
>
> >
> > > >
> > > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 0b16f8bed19c ("mm: change vma_start_read() to drop RCU lock =
on failure")
> > >
> > > The commit is 6.18-rc1 so we don't need Cc: stable, but it's a mm-hot=
fixes
> > > material that must go to Linus before 6.18.
> > >
> > > > Reported-by: syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=3D131f9eb2b58075732=
75c
> > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > >
> > > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >
> > With the changelog text sorted out.
> >
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Thanks!
> >
> > >
> > > > ---
> > > >  mm/mmap_lock.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > > > index 39f341caf32c0..f2532af6208c0 100644
> > > > --- a/mm/mmap_lock.c
> > > > +++ b/mm/mmap_lock.c
> > > > @@ -257,6 +257,7 @@ struct vm_area_struct *lock_vma_under_rcu(struc=
t mm_struct *mm,
> > > >               if (PTR_ERR(vma) =3D=3D -EAGAIN) {
> > > >                       count_vm_vma_lock_event(VMA_LOCK_MISS);
> > > >                       /* The area was replaced with another one */
> > > > +                     mas_set(&mas, address);
> > > >                       goto retry;
> > > >               }
> > > >
> > >

