Return-Path: <linux-kernel+bounces-820797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CC9B7F2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAEF27ABA86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC8E1E1E00;
	Wed, 17 Sep 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtEIDobW"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17C1F4192
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115379; cv=none; b=ruHUSQ23ns91/DBrJzteHH97CW3Iw1Fgir7HuXb2Po2dq75ZuIQivMQ8ML+6hHt11FpndUaIox2kJYbb4+oO3pzEqWHpE0D9TqQ4JCw2UB21fs7kTr36Uz/2LC9D93j93vr45m5ff+aWppXshTCYVVOf+l3jntniBxxExIYGYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115379; c=relaxed/simple;
	bh=IXtdj43M5q2Ed5NQe9mn8kcTi6HyJvp+nQtN50y6JwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fvqczsri6EBCQCXFRUROjqSyyn+jDjdSij5uH9hiOW/BsGtvnLmVxaDli+ZbRBO4t25YuU/1AwXhGhX9G6ZPy0EnH128xp+7BsE0rBwE8Lb0R3r7N+9B/NRK5V/ldkdXHnnD+AbZXNog1RV+63mGV3GGm/gk3jc8yoQvp8T58yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtEIDobW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62f1987d446so5851029a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758115375; x=1758720175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNei8MHThiloklPU7UxzTmaJV1wQ0pvOzFsJZ+duSAw=;
        b=dtEIDobWRDzpGN+FdDhFfoFiHtzGUPzW0pcT/Jb+oNR3B80z0S24QkQ2+tJp6BZ+E/
         2SlbHxnjDN783WeZS11qulZHLrmY8tfl32+sUPaLEHDQxM2VdtGVjCSoAWO/81tAVN2u
         ZQwPKFJbwP2at65JIdllh/SMVVp4UfrocsykoBmIxiIski7oZfqhigY4pelh0UtMjMxY
         WvQoX61HxRKGO0Dq+//ussr1do4V2PL7DoU/mjsktCGkBr8AlvvmntplrClk9kmGL0sc
         J9DmNVrqTVEUBc1/2sp70X5gfLIDNC387OJskChrSs6DRyg/zPih4y+a+vXpqM7bLNdE
         mHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115375; x=1758720175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNei8MHThiloklPU7UxzTmaJV1wQ0pvOzFsJZ+duSAw=;
        b=Ko9GV7mq1AdkkyfyBMOhRz9PleM8lPA4G9zBv67aZecLvC2qlt8Ts+fDJy6bneuPkA
         qDxcoXJxv5Tcz+pH9w0WywgWVX39N8lx73qDUbnon1G3agLEG8aw4DND3lSg7Nj12Nn5
         +/ZTzJp3aXqMF+Nj3BKSyCYoYhvRegjWp6RRDoDqLqtKEXc6lQ5apQihQ7uoaLMEQyRr
         V1i0hCZTAJioZ02UT/kt3HRGFeVtcQQEYhC1ROVkemiRd5j0Ho5urr5FoCgn00Qwgaxm
         64isdqDEzD2sSPh4mRH+UrIZbpGLRgTS6DC8WmM7QyGoyHHTnJfWlyMG4cBUhW78spn5
         ebJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNCQ034PHbHCOqJNXldVoG1FgWUOyPYWBzrcMVrQUAuAbQNgRHCcwiCWKQ6vlLcJ32k4Kx5cFz2lKzoP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ms7pXWfRrCF0VyZpZUxqZyDyGR/GXFCJkrKVNlAkTofP6QiK
	GLY45vCwNDH/cR3bJWKubqmFPQrIj0sRvnkHC/IUMw1dJUaJdR0JqdXy0FHs+8zdlRFtN1klvMD
	muuHXfsdSJO8jC1v8yctpRnODJCvNbAA=
X-Gm-Gg: ASbGncsAPXr7sf6wteKig66BGTV0m6O5TYxyM6QuTQbFiCPh8JHyAaxSOCXkrjhbyDQ
	Dlv6xEtBZf6Le5FLE5mQx53oESPsl48G6Wtz7o8ij0yOGgp0UMecipbdhhLIg+K/TcFr4MAF20A
	w0iIpOZYxyXcHH1PATGFWUFH/rnJmFmKvwbGxb4AkpF5S1EAWlHuVsodmaBQDyoZb7VFcwkJSq0
	f49MVRs9F6N1OfUrvtAjJ3RqR0/JLIPOAEKsB0=
X-Google-Smtp-Source: AGHT+IH1fnd7pg1OiM+Vful9dVduFaBmJC8BwTm18iho+3iiqRU+5s4WiBnxugsYrfCl+j7st2Br4O7QIh8RDO+5yVc=
X-Received: by 2002:a05:6402:34c2:b0:62f:65f5:a8cd with SMTP id
 4fb4d7f45d1cf-62f84213d25mr2465122a12.7.1758115374571; Wed, 17 Sep 2025
 06:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com> <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
In-Reply-To: <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 15:22:42 +0200
X-Gm-Features: AS18NWCj5D-vA3jAqNwkPHxdj4sWxauOvPCPJajJmK9sXPHNO63KqrqU8QfOTfU
Message-ID: <CAGudoHHiH+2+LdQGBs8cS4Hr6sDWk6diEG+JQ7HMQbWdiNtKAA@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Max Kellermann <max.kellermann@ionos.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:13=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Wed, Sep 17, 2025 at 2:44=E2=80=AFPM Max Kellermann <max.kellermann@io=
nos.com> wrote:
>
> I don't know about ceph internals, so no comment on that front.
>
> > +/**
> > + * Queue an asynchronous iput() call in a worker thread.  Use this
> > + * instead of iput() in contexts where evicting the inode is unsafe.
> > + * For example, inode eviction may cause deadlocks in
> > + * inode_wait_for_writeback() (when called from within writeback) or
> > + * in netfs_wait_for_outstanding_io() (when called from within the
> > + * Ceph messenger).
> > + *
> > + * @n: how many references to put
> > + */
> > +void ceph_iput_n_async(struct inode *inode, int n)
> > +{
> > +       if (unlikely(!inode))
> > +               return;
> > +
> > +       if (likely(atomic_sub_return(n, &inode->i_count) > 0))
> > +               /* somebody else is holding another reference -
> > +                * nothing left to do for us
> > +                */
> > +               return;
> > +
> > +       doutc(ceph_inode_to_fs_client(inode)->client, "%p %llx.%llx\n",=
 inode, ceph_vinop(inode));
> > +
> > +       /* the reference counter is now 0, i.e. nobody else is holding
> > +        * a reference to this inode; restore it to 1 and donate it to
> > +        * ceph_inode_work() which will call iput() at the end
> > +        */
> > +       atomic_set(&inode->i_count, 1);
> > +
>
> That loop over iput() indeed asks for a variant which grabs an
> explicit count to subtract.
>
> However, you cannot legally transition to 0 without ->i_lock held. By
> API contract the ->drop_inode routine needs to be called when you get
> here and other CPUs are prevented from refing the inode.
>
> While it is true nobody *refs* the inode, it is still hanging out on
> the superblock list where it can get picked up by forced unmount and
> on the inode hash where it can get picked up by lookup. With a
> refcount of 0, ->i_lock not held and no flags added, from their POV
> this is a legally cached inode they can do whatever they want with.
>
> So that force setting of refcount to 1 might be a use-after-free if
> this raced against another iput or it might be losing a reference
> picked up by someone else.
>
> If you got the idea to bring back one frem from iput() in the stock kerne=
l:
>
>         if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
>                 if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
>                         atomic_inc(&inode->i_count);
>
> Note this guy still makes sure to take the lock first. As a side note
> this weird deref to 0 + ref back to 1 business is going away [1].
>
> I don't know what's the handy Linux way to sub an arbitrary amount as
> long as the target is not x, I guess worst case one can just write a
> cmpxchg loop by hand.
>
> Given that this is a reliability fix I would forego optimizations of the =
sort.
>
> Does the patch convert literally all iput calls within ceph into the
> async variant? I would be worried that mandatory deferral of literally
> all final iputs may be a regression from perf standpoint.
>
> I see you are mentioning another deadlock, perhaps being in danger of
> deadlocking is something you could track with a flag within ceph (just
> like it happens for writeback)? Then the local iput variant could
> check on both. I have no idea if this is feasible at all for the netfs
> thing.
>
> No matter what though, it looks like the way forward concerning
> ->i_count is to make sure it does not drop to 0 within the new
> primitive.
>

That is to say the routine async routine should start with:
        if (atomic_add_unless(&inode->i_count, -1, 1))
                return;
         /* defer to iput here */

this is copy pasted, no credit needed for anyone

As you can see there is some work going on concerning these routines,
I would wager that loop over iput in writeback will go away in
mainline after the dust settles ;)

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=
=3Dvfs-6.18.inode.refcount.preliminaries&id=3D9e70e985bdc2[1[1c6fe7a160e4d5=
9ddd7c0a39bc077
>
> > +       /* simply queue a ceph_inode_work() without setting
> > +        * i_work_mask bit; other than putting the reference, there is
> > +        * nothing to do
> > +        */
> > +       WARN_ON_ONCE(!queue_work(ceph_inode_to_fs_client(inode)->inode_=
wq,
> > +                                &ceph_inode(inode)->i_work));
> > +
> > +       /* note: queue_work() cannot fail; it i_work were already
> > +        * queued, then it would be holding another reference, but no
> > +        * such reference exists
> > +        */
> > +}
> > +

