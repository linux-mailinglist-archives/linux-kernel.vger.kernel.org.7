Return-Path: <linux-kernel+bounces-752312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16467B173DE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D7E7A7C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F019D084;
	Thu, 31 Jul 2025 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPwsnV9/"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEC315A8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975252; cv=none; b=A4WW97wMr8sHJWt3xiDf7K7sx0i8qil43W9gOiUdZP+kv1WI3usnQEKOh7N1WXdDuUt4Jj1euRaaFO0Pckja0XQYLyQ7oydfE5p2OjKUgWT9Tm/42zqSyn5XLhBghNIbcUnAe/QKpyNF3+LhBx7vMNbDyjbsAKXTVeC8+MIP2d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975252; c=relaxed/simple;
	bh=7Wz6Kpu9/oh0MnexH/dfybYV/U2en80U/afUX74ofNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUhw2uOyHNT7VjpdX9SiZ0wkOafxctCA2SalnrgxcOz+O/sgxC/JvgAty3sKg5XTEj44wbsj/yIekzK4nxtvFyDyH4GTH/MLZ5wHbroqWcik2k6L/7svkJHHHXBEKvWnyCi+hJ33JnI1wQDu5H0j7TRJkh7ZjFC5pIxddPbpBkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nPwsnV9/; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab3ad4c61fso435281cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753975250; x=1754580050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXVgdNzaNf2ppZOAnb0Hf74PiGm255gpHJ61J8Ej/kI=;
        b=nPwsnV9/rqdCVk8fuzoTEQu31gESUMipEB+bGc3SUmQ0zX4RUIbxWSPolAbEdOQcfy
         Fo4V0kyhny8jAMC1S+0phQ7TUCj6KhA0jNkDUapFhAnP1tQNaBh/JzWg+zRLX+zxnp3b
         UHhD6mbdHHLxwTZPN69VDh8ijhVBHLdF1QLH/KjIS3rEdxn0/QOGe7wLBr5BAVNBBiEj
         9BGCloK66DkQi1jmc3XzdxQfIwpwC/gcWFuzGrJr5NHpPcaTOZGwleaqFj4ODegpU+Kk
         92ggrUvWpxUhGe3HQE+SeyG3dMLepMwiC3MNTBPEzArNkrMBa9KJI8y97Vp0BM8iyeCs
         LEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753975250; x=1754580050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXVgdNzaNf2ppZOAnb0Hf74PiGm255gpHJ61J8Ej/kI=;
        b=Zwjmz891FVpAyM/tEHMcQsLhc67kBaiUF2+TQ6dBYI7JLU3AzEKEhN2ZV5+bnfSm5b
         zj5OsG61POxXzgVOUR5fdu6+FoCI52HdTt/TYwzHsH1+BHTR2c+DvWyUNOkNDBrd5Mf+
         DshXsgz5Gspe2QqvUTG3Vizd9DHOg+9FwM15TMWWIyx7q971wji655m3Fq6Wx8f3QVz2
         2Drht5DiW1XRKhj790Ag+YP0UIt8zYuG3sAoXlPTa+MWw7BKN6/RGXGh7syv8+5MDpD2
         DdT89w8g9DMVX5hlYhWxmpQmUlCfMjelST33fg2ib/Y36/sIAmGRWFDW2Duo/az6F3gr
         UdfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlFA1zW9ky8kXRxuXmiU5hmDnvY8DLZEocdtQ/spF2SzQmUQrfOboLnSZL+SLdhrh19jm3dF1vDDHvUsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJGrBbKauj00cm6IdZwrmQzXIdrW85N/HDcFJFbh06+Fx8W4bq
	cBjO70z6J6HWPs5xWhJcbJggehANnygZPEaMnCp+9oP0Sihhi3ySMZsXeIe6xa2yAMQ9TmJUS5C
	jjlu6CiIHwPK2PHdLO3G8KWD3W76aN9+s81Z5DJm5
X-Gm-Gg: ASbGncs7pE8yQ8yD+DDE6suqYZOJYiezEbnhMrCbSm6I79ZGLYK0kZtEesTv5xZpL9o
	55FHm3Mg6TIjx6G1adJTz9haO7dJUk4XxuNNxwjJc5ijwyMxYHyjTNDeBHVrUHhBwh8c/2cJ8j1
	ng1mgnRA49UJJnDFoNdUO5Zlpxcyh4THp+Z2euJrMeDsZwlbaUstGj7y29EA8OisaQjx2PmpjD3
	4v7FEhs+Y7aVnvee4VcsabdNWMCJnBDqIdDRQ==
X-Google-Smtp-Source: AGHT+IFkHJ+uk6AmGEYAUc89bOxa9TpcABZ8Qd0G5R47W//bln6p9f0FhGBSRzH4gNy8qyLWXck/VYShbXNXSXFXwls=
X-Received: by 2002:a05:622a:13cd:b0:4ab:4088:7d97 with SMTP id
 d75a77b69052e-4aeeff8922bmr4072771cf.24.1753975249031; Thu, 31 Jul 2025
 08:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731151919.212829-1-surenb@google.com>
In-Reply-To: <20250731151919.212829-1-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 31 Jul 2025 08:20:37 -0700
X-Gm-Features: Ac12FXytLxguJzhGbhRbOxMecFVRBKGK18J2j15debQV7RsZ7FbXW6Xatmguq8w
Message-ID: <CAJuCfpHghvnWWvF6JN+DHbD8Vv7zPVC0BZcTmW6HcrWrxo=KWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: limit the scope of vma_start_read()
To: akpm@linux-foundation.org
Cc: jannh@google.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	vbabka@suse.cz, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 8:19=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Limit the scope of vma_start_read() as it is used only as a helper for
> higher-level locking functions implemented inside mmap_lock.c and we are
> about to introduce more complex RCU rules for this function.
> The change is pure code refactoring and has no functional changes.
>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Forgot to add Lorenzo's

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!

> ---
>  include/linux/mmap_lock.h | 85 ---------------------------------------
>  mm/mmap_lock.c            | 85 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+), 85 deletions(-)
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 11a078de9150..2c9fffa58714 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -147,91 +147,6 @@ static inline void vma_refcount_put(struct vm_area_s=
truct *vma)
>         }
>  }
>
> -/*
> - * Try to read-lock a vma. The function is allowed to occasionally yield=
 false
> - * locked result to avoid performance overhead, in which case we fall ba=
ck to
> - * using mmap_lock. The function should never yield false unlocked resul=
t.
> - * False locked result is possible if mm_lock_seq overflows or if vma ge=
ts
> - * reused and attached to a different mm before we lock it.
> - * Returns the vma on success, NULL on failure to lock and EAGAIN if vma=
 got
> - * detached.
> - *
> - * WARNING! The vma passed to this function cannot be used if the functi=
on
> - * fails to lock it because in certain cases RCU lock is dropped and the=
n
> - * reacquired. Once RCU lock is dropped the vma can be concurently freed=
.
> - */
> -static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm=
,
> -                                                   struct vm_area_struct=
 *vma)
> -{
> -       int oldcnt;
> -
> -       /*
> -        * Check before locking. A race might cause false locked result.
> -        * We can use READ_ONCE() for the mm_lock_seq here, and don't nee=
d
> -        * ACQUIRE semantics, because this is just a lockless check whose=
 result
> -        * we don't rely on for anything - the mm_lock_seq read against w=
hich we
> -        * need ordering is below.
> -        */
> -       if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(mm->mm_lock_seq.=
sequence))
> -               return NULL;
> -
> -       /*
> -        * If VMA_LOCK_OFFSET is set, __refcount_inc_not_zero_limited_acq=
uire()
> -        * will fail because VMA_REF_LIMIT is less than VMA_LOCK_OFFSET.
> -        * Acquire fence is required here to avoid reordering against lat=
er
> -        * vm_lock_seq check and checks inside lock_vma_under_rcu().
> -        */
> -       if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_re=
fcnt, &oldcnt,
> -                                                             VMA_REF_LIM=
IT))) {
> -               /* return EAGAIN if vma got detached from under us */
> -               return oldcnt ? NULL : ERR_PTR(-EAGAIN);
> -       }
> -
> -       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> -
> -       /*
> -        * If vma got attached to another mm from under us, that mm is no=
t
> -        * stable and can be freed in the narrow window after vma->vm_ref=
cnt
> -        * is dropped and before rcuwait_wake_up(mm) is called. Grab it b=
efore
> -        * releasing vma->vm_refcnt.
> -        */
> -       if (unlikely(vma->vm_mm !=3D mm)) {
> -               /* Use a copy of vm_mm in case vma is freed after we drop=
 vm_refcnt */
> -               struct mm_struct *other_mm =3D vma->vm_mm;
> -
> -               /*
> -                * __mmdrop() is a heavy operation and we don't need RCU
> -                * protection here. Release RCU lock during these operati=
ons.
> -                * We reinstate the RCU read lock as the caller expects i=
t to
> -                * be held when this function returns even on error.
> -                */
> -               rcu_read_unlock();
> -               mmgrab(other_mm);
> -               vma_refcount_put(vma);
> -               mmdrop(other_mm);
> -               rcu_read_lock();
> -               return NULL;
> -       }
> -
> -       /*
> -        * Overflow of vm_lock_seq/mm_lock_seq might produce false locked=
 result.
> -        * False unlocked result is impossible because we modify and chec=
k
> -        * vma->vm_lock_seq under vma->vm_refcnt protection and mm->mm_lo=
ck_seq
> -        * modification invalidates all existing locks.
> -        *
> -        * We must use ACQUIRE semantics for the mm_lock_seq so that if w=
e are
> -        * racing with vma_end_write_all(), we only start reading from th=
e VMA
> -        * after it has been unlocked.
> -        * This pairs with RELEASE semantics in vma_end_write_all().
> -        */
> -       if (unlikely(vma->vm_lock_seq =3D=3D raw_read_seqcount(&mm->mm_lo=
ck_seq))) {
> -               vma_refcount_put(vma);
> -               return NULL;
> -       }
> -
> -       return vma;
> -}
> -
>  /*
>   * Use only while holding mmap read lock which guarantees that locking w=
ill not
>   * fail (nobody can concurrently write-lock the vma). vma_start_read() s=
hould
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index b006cec8e6fe..10826f347a9f 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -127,6 +127,91 @@ void vma_mark_detached(struct vm_area_struct *vma)
>         }
>  }
>
> +/*
> + * Try to read-lock a vma. The function is allowed to occasionally yield=
 false
> + * locked result to avoid performance overhead, in which case we fall ba=
ck to
> + * using mmap_lock. The function should never yield false unlocked resul=
t.
> + * False locked result is possible if mm_lock_seq overflows or if vma ge=
ts
> + * reused and attached to a different mm before we lock it.
> + * Returns the vma on success, NULL on failure to lock and EAGAIN if vma=
 got
> + * detached.
> + *
> + * WARNING! The vma passed to this function cannot be used if the functi=
on
> + * fails to lock it because in certain cases RCU lock is dropped and the=
n
> + * reacquired. Once RCU lock is dropped the vma can be concurently freed=
.
> + */
> +static inline struct vm_area_struct *vma_start_read(struct mm_struct *mm=
,
> +                                                   struct vm_area_struct=
 *vma)
> +{
> +       int oldcnt;
> +
> +       /*
> +        * Check before locking. A race might cause false locked result.
> +        * We can use READ_ONCE() for the mm_lock_seq here, and don't nee=
d
> +        * ACQUIRE semantics, because this is just a lockless check whose=
 result
> +        * we don't rely on for anything - the mm_lock_seq read against w=
hich we
> +        * need ordering is below.
> +        */
> +       if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(mm->mm_lock_seq.=
sequence))
> +               return NULL;
> +
> +       /*
> +        * If VMA_LOCK_OFFSET is set, __refcount_inc_not_zero_limited_acq=
uire()
> +        * will fail because VMA_REF_LIMIT is less than VMA_LOCK_OFFSET.
> +        * Acquire fence is required here to avoid reordering against lat=
er
> +        * vm_lock_seq check and checks inside lock_vma_under_rcu().
> +        */
> +       if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_re=
fcnt, &oldcnt,
> +                                                             VMA_REF_LIM=
IT))) {
> +               /* return EAGAIN if vma got detached from under us */
> +               return oldcnt ? NULL : ERR_PTR(-EAGAIN);
> +       }
> +
> +       rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
> +
> +       /*
> +        * If vma got attached to another mm from under us, that mm is no=
t
> +        * stable and can be freed in the narrow window after vma->vm_ref=
cnt
> +        * is dropped and before rcuwait_wake_up(mm) is called. Grab it b=
efore
> +        * releasing vma->vm_refcnt.
> +        */
> +       if (unlikely(vma->vm_mm !=3D mm)) {
> +               /* Use a copy of vm_mm in case vma is freed after we drop=
 vm_refcnt */
> +               struct mm_struct *other_mm =3D vma->vm_mm;
> +
> +               /*
> +                * __mmdrop() is a heavy operation and we don't need RCU
> +                * protection here. Release RCU lock during these operati=
ons.
> +                * We reinstate the RCU read lock as the caller expects i=
t to
> +                * be held when this function returns even on error.
> +                */
> +               rcu_read_unlock();
> +               mmgrab(other_mm);
> +               vma_refcount_put(vma);
> +               mmdrop(other_mm);
> +               rcu_read_lock();
> +               return NULL;
> +       }
> +
> +       /*
> +        * Overflow of vm_lock_seq/mm_lock_seq might produce false locked=
 result.
> +        * False unlocked result is impossible because we modify and chec=
k
> +        * vma->vm_lock_seq under vma->vm_refcnt protection and mm->mm_lo=
ck_seq
> +        * modification invalidates all existing locks.
> +        *
> +        * We must use ACQUIRE semantics for the mm_lock_seq so that if w=
e are
> +        * racing with vma_end_write_all(), we only start reading from th=
e VMA
> +        * after it has been unlocked.
> +        * This pairs with RELEASE semantics in vma_end_write_all().
> +        */
> +       if (unlikely(vma->vm_lock_seq =3D=3D raw_read_seqcount(&mm->mm_lo=
ck_seq))) {
> +               vma_refcount_put(vma);
> +               return NULL;
> +       }
> +
> +       return vma;
> +}
> +
>  /*
>   * Lookup and lock a VMA under RCU protection. Returned VMA is guarantee=
d to be
>   * stable and not isolated. If the VMA is not found or is being modified=
 the
>
> base-commit: 01da54f10fddf3b01c5a3b80f6b16bbad390c302
> --
> 2.50.1.552.g942d659e1b-goog
>

