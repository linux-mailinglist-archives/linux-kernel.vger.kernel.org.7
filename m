Return-Path: <linux-kernel+bounces-758409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA0AB1CE9C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60F93B16DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72FF21ABC8;
	Wed,  6 Aug 2025 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="14ZharJV"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BE717736
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754516775; cv=none; b=kyHdbrnPzK11a8bciidFiYZcDPiVzqbHS7DC1VFog9ZJuHSNzAv/NnATO+/68UF0PjAcQr8h87cwQ3ymwodzW+WfpHhy24/S8xtInGbgWuVQY1rcF9Dtkkc4uDabjk09tnJbLVglYogDDvD+fhJNzRh9VgJ7IfBkOkwacDveg9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754516775; c=relaxed/simple;
	bh=DgQqTdHnk24tVkbIMHH6pD0DTGYEij20ikDu8nWYaPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDOjJ4+sQ1bbemT4Fzn+es7hBsz0AQpT8HHI+0UqOIRmZDqiH9pUYQBzdkjzwrmmUCfCHTW4q8McerrxY9nal4rog821haCZf4y2IAMcKQUch6H8ESNnJ/m0MG/BxRFmobI6Bum+csYCLsxahErAVgomtgBzF4NZ5qQzydI7qKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=14ZharJV; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b0673b0a7cso89581cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 14:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754516773; x=1755121573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxW5GAL3bM/I2otEhPeRhXnNiAmw94QPD8j2NzcS20s=;
        b=14ZharJV2MBEaRw1V8a7uPFcjmSwGFRCehsQvXtRfM9vt7mOSpJxDnoctd73osz6Rw
         8Y+QbDlAzyWGrBr6Ht+OyAd+qzePCKGF1K6mM+X7bZ9ZoGFReF2oHk5It65oBYYdklJd
         avzEPGqKO9sw1eBVv0EJxMFo7NZyediiWFua17sS1hGQu5a5k5m4KZQbV/PON5ZJUkQ+
         euTIarbdlYelkUiDqp2OXvpO9M2uM4Z7rbCvkgm49zasuqI3kSxkqze6LaSufDwuFojF
         VOL9D3Xe7KcAWxnn8W5X6ZriqZ+XkHBBqTaXDkUFJ3LqflF6TFtogJ76UoZkrMflcgth
         ZgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754516773; x=1755121573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxW5GAL3bM/I2otEhPeRhXnNiAmw94QPD8j2NzcS20s=;
        b=mArgICvagt2VCOoQAfeR0xOkA0zmvpYagvvRfAri6GqB5UF07eiDh7PfrNIWCqmv/L
         8v5X7l66rwQsFnmMEPMynZ/sZmicDmYi3RSH+QT+nryP1iJ8qwXMXJcmsQcVn4iptOiM
         FU7ZJ0AwoEYwEn08cc4+//Xwb1IKii9ygXnunvSIEbynuFSg0ZQ5OPXJjUiwvMTpf603
         eFIdfPsMj3bPsjm5w7Jm3D8i3sGEv/sr47cjp9FZxIor5XgX7HBbCaRSvXCRgt3jcJpw
         7oFk5RwZ4DTlII27bxQgudrAuE34iKaKEyCw6x42plZ+ZmffWNxnQvCsH94BGIRxAAjc
         fPXw==
X-Forwarded-Encrypted: i=1; AJvYcCXXne8wXU2ciZSZUbCpH5CYkdhoYjLnRLKWomazZ0HOGz2ws8cKwki4ylKoA3jZb2rK1Zll6G6KUg/eewc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw10/yp8mxp2W/dzvIjFMEUMeWPjOtPUC5o3jgINFpyjf8uwPrI
	eyPuV4J2cdt6eHUiQoIbeDhHGeoNn7Lcmo4KyfH3Od0NYw4MCG9YY5Qzon0/TvGJrMYoSuZTu1N
	X/pgifL0on2q2banfavXgG7h5Ka8QnRwrswqPpGw+
X-Gm-Gg: ASbGnctvcFtUiCvVCR2tUIhdw7WC6wxzbRiSveySObgz4bWaGPWRIC/i9oXHZxnaXwR
	Eva68dJwL5Zwa9scDqqXxfl3h261laxKwbV+NE2wPFCtkzVKubf/oZMXKbhG7UQZYZG1TkWpIgu
	sBkl6cb8fKg7VeC5VLow1MAivrg46/baBHG54xb0TFlJLTLRVikxzWNvnw1KLnMRy+CiEmgQaPW
	Dy0nwxu46Mga3YZgPQrojjaB9P5uMPZUxCWYeTDfHQ/2vJf
X-Google-Smtp-Source: AGHT+IFdmXPQZItR2ayc1YdqBDwRQHE7GzP2qwoWOBR+mlDDDgs6jqf+g5f4jCHjpUZgoidmSeVTdUaYH200K1a+z3I=
X-Received: by 2002:a05:622a:607:b0:4b0:85d7:b884 with SMTP id
 d75a77b69052e-4b0a37dc7aemr454981cf.21.1754516772179; Wed, 06 Aug 2025
 14:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806155905.824388-1-surenb@google.com> <20250806155905.824388-4-surenb@google.com>
 <8ddff47d-3059-42ea-b022-6151da513049@lucifer.local>
In-Reply-To: <8ddff47d-3059-42ea-b022-6151da513049@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 6 Aug 2025 14:46:00 -0700
X-Gm-Features: Ac12FXz2HywmlnpQot2FVtRqWi3gIynzyBudbKw5U311U7inXb6k23cYiYmJ7i0
Message-ID: <CAJuCfpEntig+s6GNSERvMJBY=LNWNd_9CraxG7-zkwK1KF882Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl
 under per-vma locks
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 12:03=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Aug 06, 2025 at 08:59:04AM -0700, Suren Baghdasaryan wrote:
> > Utilize per-vma locks to stabilize vma after lookup without taking
> > mmap_lock during PROCMAP_QUERY ioctl execution. If vma lock is
> > contended, we fall back to mmap_lock but take it only momentarily
> > to lock the vma and release the mmap_lock. In a very unlikely case
> > of vm_refcnt overflow, this fall back path will fail and ioctl is
> > done under mmap_lock protection.
> >
> > This change is designed to reduce mmap_lock contention and prevent
> > PROCMAP_QUERY ioctl calls from blocking address space updates.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> A lot of nits but nothing's really standing out as broken, AFAICT...
>
> > ---
> >  fs/proc/task_mmu.c | 84 +++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 68 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 45134335e086..0396315dfaee 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -517,28 +517,81 @@ static int pid_maps_open(struct inode *inode, str=
uct file *file)
> >               PROCMAP_QUERY_VMA_FLAGS                         \
> >  )
> >
> > -static int query_vma_setup(struct mm_struct *mm)
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +
> > +static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
> >  {
> > -     return mmap_read_lock_killable(mm);
> > +     lock_ctx->locked_vma =3D NULL;
> > +     lock_ctx->mmap_locked =3D false;
>
> We also do this in lock_vma_range(), seems sensible to factor out? E.g.:
>
> static void ctx_clear_vma(struct proc_maps_locking_ctx *lock_ctx)

That name really confused me :) Maybe lock_vma_ctx_init() or something
along these lines. If we can't think of a good name I would prefer to
keep it as is, given it's only two lines and used only in two places.

> {
>         lock_ctx->locked_vma =3D NULL;
>         lock_ctx->mmap_locked =3D false;
> }
>
> > +
> > +     return 0;
> >  }
> >
> > -static void query_vma_teardown(struct mm_struct *mm, struct vm_area_st=
ruct *vma)
> > +static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
> >  {
> > -     mmap_read_unlock(mm);
> > +     if (lock_ctx->mmap_locked)
> > +             mmap_read_unlock(lock_ctx->mm);
>
> Maybe worth a comment as to why we leave lock_ctx->mmap_locked set here?

Sure. The reason is that this is a teardown stage and lock_ctx won't
be used anymore. I guess I could reset it just to leave lock_ctx
consistent instead of adding a comment. Will do that.

>
> > +     else
> > +             unlock_vma(lock_ctx);
>
> Should have said on 2/3, but I wonder if we should prefix with ctx_, as
> 'unlock_vma()' and 'lock_vma()' seem like core functions... esp. since we
> have vma_start_read/write() rather than functions that reference locking.
>
> So - ctx_unlock_vma() and ctx_lock_vma() or unlock_ctx_vma() /
> lock_ctx_vma()?

unlock_ctx_vma() / lock_ctx_vma() sounds good to me.

>
> > +}
> > +
> > +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_=
locking_ctx *lock_ctx,
> > +                                                  unsigned long addr)
> > +{
> > +     struct vm_area_struct *vma;
> > +     struct vma_iterator vmi;
> > +
> > +     if (lock_ctx->mmap_locked)
> > +             return find_vma(lock_ctx->mm, addr);
> > +
> > +     unlock_vma(lock_ctx);
> > +     rcu_read_lock();
> > +     vma_iter_init(&vmi, lock_ctx->mm, addr);
> > +     vma =3D lock_next_vma(lock_ctx->mm, &vmi, addr);
> > +     rcu_read_unlock();
>
> I think a comment at the top of this block would be useful, something lik=
e
> 'We unlock any previously locked VMA and find the next under RCU'.

Ack.

>
> > +
> > +     if (!IS_ERR_OR_NULL(vma)) {
>
> Is the NULL bit here really necessary? presumably lock_ctx->locked_vma is
> expected to be NULL already, so we're not overwriting anything here.
>
> In fact we could get rid of the horrid if/else here with a guard clause l=
ike:
>
>         if (!IS_ERR(vma) || PTR_ERR(vma) !=3D -EAGAIN)
>                 return vma;

We still need to assign lock_ctx->locked_vma when !IS_ERR(vma) before
we return the vma, so the lines about would not be correct. I can
change it to:

if (!vma)
    return NULL;

if (!IS_ERR(vma)) {
    lock_ctx->locked_vma =3D vma;
    return vma;
}

if (PTR_ERR(vma) =3D=3D -EAGAIN) {
    /* Fallback to mmap_lock on vma->vm_refcnt overflow */
    ...
}
return vma;

I think that would be the equivalent of what I currently have. Would
you prefer that?

>
> (the !IS_ERR() bit is probably a bit redundant but makes things clearer
> vs. just the PTR_ERR() thing)
>
> Then do the rest below.
>
>
> > +             lock_ctx->locked_vma =3D vma;
> > +     } else if (PTR_ERR(vma) =3D=3D -EAGAIN) {
> > +             /* Fallback to mmap_lock on vma->vm_refcnt overflow */
> > +             mmap_read_lock(lock_ctx->mm);
> > +             vma =3D find_vma(lock_ctx->mm, addr);
> > +             lock_ctx->mmap_locked =3D true;
>
> Kinda sucks we have two separate ways of doing fallback now, this
> open-coded thing and fallback_to_mmap_lock().
>
> Sort of hard to combine since we have subtly diffrent semantics - the RCU
> read lock is being held in the /proc/$pid/maps case, but here we've
> released it already.

Yeah, plus that one uses iterators and this one doesn't... I don't
think it's worth trying to shoehorn them together given that the code
is quite short.

>
> > +     }
> > +
> > +     return vma;
> > +}
> > +
> > +#else /* CONFIG_PER_VMA_LOCK */
> > +
> > +static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
> > +{
> > +     return mmap_read_lock_killable(lock_ctx->mm);
> >  }
> >
> > -static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct =
*mm, unsigned long addr)
> > +static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
> >  {
> > -     return find_vma(mm, addr);
> > +     mmap_read_unlock(lock_ctx->mm);
> >  }
> >
> > -static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
> > +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_=
locking_ctx *lock_ctx,
> > +                                                  unsigned long addr)
> > +{
> > +     return find_vma(lock_ctx->mm, addr);
> > +}
> > +
> > +#endif  /* CONFIG_PER_VMA_LOCK */
> > +
> > +static struct vm_area_struct *query_matching_vma(struct proc_maps_lock=
ing_ctx *lock_ctx,
> >                                                unsigned long addr, u32 =
flags)
> >  {
> >       struct vm_area_struct *vma;
> >
> >  next_vma:
> > -     vma =3D query_vma_find_by_addr(mm, addr);
> > +     vma =3D query_vma_find_by_addr(lock_ctx, addr);
> > +     if (IS_ERR(vma))
> > +             return vma;
> > +
> >       if (!vma)
> >               goto no_vma;
> >
> > @@ -579,11 +632,11 @@ static struct vm_area_struct *query_matching_vma(=
struct mm_struct *mm,
> >       return ERR_PTR(-ENOENT);
> >  }
> >
> > -static int do_procmap_query(struct proc_maps_private *priv, void __use=
r *uarg)
> > +static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
> >  {
> > +     struct proc_maps_locking_ctx lock_ctx =3D { .mm =3D mm };
>
> >       struct procmap_query karg;
> >       struct vm_area_struct *vma;
> > -     struct mm_struct *mm;
> >       const char *name =3D NULL;
> >       char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf =3D NULL;
> >       __u64 usize;
> > @@ -610,17 +663,16 @@ static int do_procmap_query(struct proc_maps_priv=
ate *priv, void __user *uarg)
> >       if (!!karg.build_id_size !=3D !!karg.build_id_addr)
> >               return -EINVAL;
> >
> > -     mm =3D priv->lock_ctx.mm;
> >       if (!mm || !mmget_not_zero(mm))
> >               return -ESRCH;
> >
> > -     err =3D query_vma_setup(mm);
> > +     err =3D query_vma_setup(&lock_ctx);
> >       if (err) {
> >               mmput(mm);
> >               return err;
> >       }
> >
> > -     vma =3D query_matching_vma(mm, karg.query_addr, karg.query_flags)=
;
> > +     vma =3D query_matching_vma(&lock_ctx, karg.query_addr, karg.query=
_flags);
> >       if (IS_ERR(vma)) {
> >               err =3D PTR_ERR(vma);
> >               vma =3D NULL;
> > @@ -705,7 +757,7 @@ static int do_procmap_query(struct proc_maps_privat=
e *priv, void __user *uarg)
> >       }
> >
> >       /* unlock vma or mmap_lock, and put mm_struct before copying data=
 to user */
> > -     query_vma_teardown(mm, vma);
> > +     query_vma_teardown(&lock_ctx);
> >       mmput(mm);
> >
> >       if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_n=
ame_addr),
> > @@ -725,7 +777,7 @@ static int do_procmap_query(struct proc_maps_privat=
e *priv, void __user *uarg)
> >       return 0;
> >
> >  out:
> > -     query_vma_teardown(mm, vma);
> > +     query_vma_teardown(&lock_ctx);
> >       mmput(mm);
> >       kfree(name_buf);
> >       return err;
> > @@ -738,7 +790,7 @@ static long procfs_procmap_ioctl(struct file *file,=
 unsigned int cmd, unsigned l
> >
> >       switch (cmd) {
> >       case PROCMAP_QUERY:
> > -             return do_procmap_query(priv, (void __user *)arg);
> > +             return do_procmap_query(priv->lock_ctx.mm, (void __user *=
)arg);
>
> OK this confused me until I worked it through.
>
> We set priv->lock_ctx.mm in:
>
> pid_maps_open() -> do_maps_open() -> proc_maps_open()
>
> Which it gets from proc_mem_open() which figures out the mm.
>
> Maybe one for 2/3, but it'd be nice to have a comment saying something
> about how this is set, since it being part of lock_ctx makes it seem like
> it's something that would be set elsewhere.
>
> Since we have fallback stuff and want to thread through this new lokc
> context type I guess it makes sense to put it here but given that's the
> case, let's maybe just add a comment here to clarify.

Ok, something like "lock_ctx.mm is set during file open operation" ?

>
> >       default:
> >               return -ENOIOCTLCMD;
> >       }
> > --
> > 2.50.1.565.gc32cd1483b-goog
> >
>
> Cheers, Lorenzo

