Return-Path: <linux-kernel+bounces-756609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBC9B1B6A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47111898EDA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DF0278772;
	Tue,  5 Aug 2025 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1CwmR5ck"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2603E275B07
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404688; cv=none; b=UQdbwiAVbKh7R/LfLnj9/tvrqWEyXW1KhahXoQap/7Z9jctFpP2tQ5AtkByHBLBQti3PbJDtWuDv3oapwVUisaktG2avyyT+SUpQf18x8uaDaOAmzrf9CcJ60B7iLITkeNCzqsfHl9qbd+3szMzwmfanteNr4Xa4awncFOqIVec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404688; c=relaxed/simple;
	bh=arjCcfwEvuffPrclQ/6w1YywG85PqYHtkxOop0K6FLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkrQ0Z0KtzZw6jcYTwHWxCeP5kqTinzc0aCECGEZTF88VuGXzjAADVtgyf8oMyylYUqUmgIniLOPaXyLDDLLEUW11te8IqTlAsfvuW45JeChsf8KAmbSkPQpcYUrnKafwabyawctzMkNEQprIBe3SCdPJSZGoe6gS7NhV6r2f5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1CwmR5ck; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4aef56cea5bso159631cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754404686; x=1755009486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aef8IAvwtLn08IdbykC4EYYFzkMHHIdInKV+pvklfuE=;
        b=1CwmR5ckkPTgkSHhLPBs0Y9Zz9PUv0ECATdi77YkZsMg0bTn0w2csYJv6CwVSmfOz/
         lV2SC5SWwbblyVsG5qzYHAxjKRuHlQJXm85vbbpEUkAKUuxznK2/Ni04hpwNr0cnJhDB
         lkDHSC2s1vtYDvT8W6Q/klC/sFVHoQOju7Vq/iYlder7so4fzlFVN8vBHHh/DRDDHhFQ
         64Qi0Z7JrPe9qmYgJF6M8nnFT70Dxh9QJL/2QjVoQNdeAFwtvLEPB8SXNlyTPQ+gSV6R
         dYvvZ7klvczbOyV1MNXrtf948CcvXDFY7on/k4kYAWbIsgXgNwe2Y1Sj1vtLizkpxe2K
         hnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404686; x=1755009486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aef8IAvwtLn08IdbykC4EYYFzkMHHIdInKV+pvklfuE=;
        b=PmuuTSu19Uc7zw3Q58j5/eFtW2OeAZnFWInzkdx5/qTgzUjMO8gQsuF24J1Wio3dhD
         tjfz5yvKIr0XH4YC68tXjlv8M7parNAZ3XLGJMCl4ElN822zXFe12CkruKLBr1Zx9JZs
         rago1Et1lh4sSKTBJSEfAv0ZZ/sU2RULGUmqQROKN4P5WwfRY/aI/Oza9CNDBgjxcJWx
         HOO2pQLaGVAXzto4NMbPyR11eNg7QnL4TYJXwesBB1WZIAvAhsbYfwBfgieBILNyfISg
         0Yiy0At9EjhRRVz1xr69jG/hwhe/8wrokfyV6cgyiFe1cIIqralaOiN6NNvL3yRiZQiN
         31hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEttPvG9v2uyLi+FAhNr7Lk/BNMzB0Ns6t91qFhHjtxE9g0pUNVjbIclPo5u0rRaIQ/pXG+u/W6DgR9HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRaKB/crN7DujZeycgX22LRZ/TzomM9/GzGJMSq681hQAsF4Z0
	kKA3Wn1xF4KZNcGlW/4kvuuXIDXiOdYeTi8j8NTkQhv/i+ikjQSNM8Vzsi0rKWuuv2B1+ahtPFT
	RTHlNYhEKpiTKlfpMxyUtdvl23lSlmjgFyaoSCnaX
X-Gm-Gg: ASbGncup0RJyyUE0WLS+vY4UQsJrcrpXK5u7gmaNwXbQs1pTJeRkwmNxF+q5VN0yKRc
	IFyw3OWwznSVHSGo7XZNuJZ07ple1PEnVK5sz5w3nmyFs0+4G+91l9HLp60JTnLE38YtpFBoM6B
	wU9GUlxGfT+qch20VUdl2Pi+7tlQgxt++2oM3N7k7Nd2xrBIJ0mcBYt4QbiVLKnfd+BvDyiAMK/
	cfxdQQmiQjcsqog0NVc0UhXy+kDOMH6LT1Ulg==
X-Google-Smtp-Source: AGHT+IGNgBN87aq4QIxEol6Iry1WpPeZs6N2msqSePTFM5jWMKBB+kelQvyXcVEXcEbW86sUjLIcplgHgUotOVKwENk=
X-Received: by 2002:ac8:5e4b:0:b0:48a:ba32:370 with SMTP id
 d75a77b69052e-4b084f396fbmr3912431cf.10.1754404685401; Tue, 05 Aug 2025
 07:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804231552.1217132-1-surenb@google.com> <20250804231552.1217132-4-surenb@google.com>
 <a2fca13d-87bd-4eb3-b673-46c538f46e66@suse.cz>
In-Reply-To: <a2fca13d-87bd-4eb3-b673-46c538f46e66@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 5 Aug 2025 07:37:53 -0700
X-Gm-Features: Ac12FXw4MVzzUn2oCKvSzz_8aCVi1Bw7CmRaPzcL7KBJ8BbbbzRtIwg97emJVWA
Message-ID: <CAJuCfpG7_=3cN6VrPmx1qtXq53AptNynTccG5vYUEYdfyQ71DA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl
 under per-vma locks
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 7:18=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 8/5/25 1:15 AM, Suren Baghdasaryan wrote:
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
> > ---
> >  fs/proc/task_mmu.c | 81 +++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 65 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index 843577aa7a32..1d06ecdbef6f 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -517,28 +517,78 @@ static int pid_maps_open(struct inode *inode, str=
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
> > +     else
> > +             unlock_vma(lock_ctx);
> >  }
> >
> > -static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct =
*mm, unsigned long addr)
> > +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_=
locking_ctx *lock_ctx,
> > +                                                  unsigned long addr)
> >  {
> > -     return find_vma(mm, addr);
> > +     struct vm_area_struct *vma;
> > +     struct vma_iterator vmi;
> >
>
> Hm I think we can reach here with lock_ctx->mmap_locked being true via
> "goto next_vma" in query_matching_vma(). In that case we should just
> "return find_vma()" and doing the below is wrong, no?

Ah, you are quite right. I should handle mmap_locked differently in
query_vma_find_by_addr(). I will post the fix shortly.

>
> > +     unlock_vma(lock_ctx);
> > +     rcu_read_lock();
> > +     vma_iter_init(&vmi, lock_ctx->mm, addr);
> > +     vma =3D lock_next_vma(lock_ctx->mm, &vmi, addr);
> > +     rcu_read_unlock();
> > +
> > +     if (!IS_ERR_OR_NULL(vma)) {
> > +             lock_ctx->locked_vma =3D vma;
> > +     } else if (PTR_ERR(vma) =3D=3D -EAGAIN) {
> > +             /* Fallback to mmap_lock on vma->vm_refcnt overflow */
> > +             mmap_read_lock(lock_ctx->mm);
> > +             vma =3D find_vma(lock_ctx->mm, addr);
> > +             lock_ctx->mmap_locked =3D true;
> > +     }
> > +
> > +     return vma;
> >  }
> >

