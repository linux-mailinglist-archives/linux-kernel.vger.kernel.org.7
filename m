Return-Path: <linux-kernel+bounces-771173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AEEB283C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E360B1B663F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190883090D0;
	Fri, 15 Aug 2025 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zra3l2pJ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847212248BD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275252; cv=none; b=t7dVxoZksN6Mvk2Tp3Lx2n3rv5bR/BQ9x6vKeGsltPanVh7e0VmYaetUSJFLczWcyq+ZolK9SLB479IrazchsqXDuFpyKUqPZPjaISOEJZRKwDHRaY6ZONth5Fpb9IkPbaADkLRrnxvyAsBCx/VUV8njrGnkKOgJ1X0DmFhk/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275252; c=relaxed/simple;
	bh=h6/a5A+7S5vF3Xsvd9A6Lntrtl5sYLaWaKYfVACkTL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWPq6tV18ec6MT/+2e+1irt1MOhXFmZDjzGm10g8SNB+9BNmchBVx1lQdL2SpFApBlmKKO/Zn5LGkltQd6yuMA7bfihyl8ABE9T1fWfswUdZtYTGb5Xc6q+wroQY4P+zTNw52nwCTnfIO4YDQqbsJiQ1+bPOFSxnfyMhfC4LpxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zra3l2pJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-618076fd48bso11123a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755275249; x=1755880049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7b8oxrc7pOHrKPjGkqyzBZ/G/DZJKdV/+bSxMfPUC8=;
        b=Zra3l2pJ+ef41eaaoKmHxzApSfqgeI/i8jNTNYYR8TIDYcbwk7fv8fb0YeXSp8KxBE
         ohcKkgJrc0ZV5btmgrEL9wfUPMH35T0/aD1WP8rFogrUvz2OIYNRQ+eS+Xri6+UI7X0L
         xQpblAOxGFqX52IMfj7a2GC2nhRue7Q1amNtRo0C+KKm+6DmrEsEs5L9+gKRE332AQvW
         CAb8Yr5MrmVijBvEIrOtgAA6C7Eqr8RjaReGqNkRcp9ynyIOrkmced4hnHp7f9iOW2KL
         Zns9o1Z7IPreGjo99YOz/SbYODd6/tZFgU6rf1mjp9NSHm12q54R+g/jsga6QfcPEos6
         kDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755275249; x=1755880049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7b8oxrc7pOHrKPjGkqyzBZ/G/DZJKdV/+bSxMfPUC8=;
        b=nXSRMcFgK6qsJgmalIB2hCDjsGE+o8kvz1xBdQLzUEL6FJidqBw1mIP6yIx5KwSe56
         /WiPOvdQFfFjdnnj1o9ribiqMzc5i876/IcF3Q8BgW8YNfEowZJk1THCBXuVj7OKZ+L4
         03bLZcCKfS/Ilewa8HsLs740oS9EPif+r4YxxoizueglhAD75a2+5b0A9glRX1vgVXIO
         /d8vTZy9c8xFCZ08uHXFY9NzBG7bYP9FvmVIdf76hL5mtxKaP/kuyLkMEW2BOtdxiBAQ
         fD2wrc3D1azNhF24mJnz7n4DlIeskcszWNk3zjW+BlnfxclDJngV2qLrZ7dziNMKFPaY
         tBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3XVor3iXrIm2Ed27hTFrvojmimtA/m2JOGl5XIeFH122it0wVE/j6a0nKLL8hYIxRwY6/dlVCa8AOwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTePmBmSwpFsFPExtkDYozrhIyomjVEA+AUPSul0QFHAHtg5O
	KU0a3FgQc+bMpZU3nClNyw00bTwTPO3GdxgwVBi7HyDXHT+LhjBN4lNCUaCIvb9f3BOeXh85sx0
	YnaMKP15bSzNiM5fWkVh/yQ+slgKeJROwcDM4zbh1
X-Gm-Gg: ASbGncusYrIPpuno8b3NAkAvSwNXRoYkpUMcfjX0BSJrjAe5aEAi7kWGHMASLge8QM8
	Lj7djZFyZvRjilLmGXusOxhW7xeE4qSujSkyNWfKmcm02Gxj61TEZy4fUVoCpPHR2R1psUrM2Tb
	pBz8z/212KlIKl6j6WK9gquNcAK+9s/WF+JXvzh1zgl3azfjl03pmTMrkFDe7bTs6D9uMoEVwt9
	u2up3Dmrm5Yow==
X-Google-Smtp-Source: AGHT+IGglLepco85oIjAKOpjvDulhB+bg499plT62J5lYXGvf1ludelKLG9gV9n6ae1Z1Lh/JDlQbxUAZ3kI0RpZVew=
X-Received: by 2002:a05:6402:5052:b0:618:249e:e59a with SMTP id
 4fb4d7f45d1cf-618aa4426b5mr115146a12.0.1755275248660; Fri, 15 Aug 2025
 09:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813193024.2279805-1-lokeshgidra@google.com>
 <CAGsJ_4w5bAJHyBrwb5+n_EANqzhz4cFSX+9yZacmOiXVJZ_Dkw@mail.gmail.com> <CAGsJ_4wt_30C82B9_ZoOB2umBi-u_kE441ARvYoJVjkLtLqFCg@mail.gmail.com>
In-Reply-To: <CAGsJ_4wt_30C82B9_ZoOB2umBi-u_kE441ARvYoJVjkLtLqFCg@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Fri, 15 Aug 2025 09:27:17 -0700
X-Gm-Features: Ac12FXzspbKZzAHgIU34G4BfMeoX9CgHPYdykS2bYhWXn8D1iiAdjQDY8h8woSk
Message-ID: <CA+EESO4NfgT6uAP52eQEt4_cx7KPdHv4MxnSw_UwHVSurime8w@mail.gmail.com>
Subject: Re: [PATCH v5] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 3:11=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Fri, Aug 15, 2025 at 9:44=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Thu, Aug 14, 2025 at 7:30=E2=80=AFAM Lokesh Gidra <lokeshgidra@googl=
e.com> wrote:
> > >
> > > MOVE ioctl's runtime is dominated by TLB-flush cost, which is require=
d
> > > for moving present pages. Mitigate this cost by opportunistically
> > > batching present contiguous pages for TLB flushing.
> > >
> > > Without batching, in our testing on an arm64 Android device with UFFD=
 GC,
> > > which uses MOVE ioctl for compaction, we observed that out of the tot=
al
> > > time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), an=
d
> > > ~20% in vm_normal_folio().
> > >
> > > With batching, the proportion of vm_normal_folio() increases to over
> > > 70% of move_pages_pte() without any changes to vm_normal_folio().
> > > Furthermore, time spent within move_pages_pte() is only ~20%, which
> > > includes TLB-flush overhead.
> > >
> > > When the GC intensive benchmark, which was used to gather the above
> > > numbers, is run on cuttlefish (qemu android instance on x86_64), the
> > > completion time of the benchmark went down from ~45mins to ~20mins.
> > >
> > > Furthermore, system_server, one of the most performance critical syst=
em
> > > processes on android, saw over 50% reduction in GC compaction time on=
 an
> > > arm64 android device.
> > >
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Kalesh Singh <kaleshsingh@google.com>
> > > Cc: Barry Song <v-songbaohua@oppo.com>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> >
> > Reviewed-by: Barry Song <baohua@kernel.org>
Thanks :-)
> >
> > [...]
> > > +static long move_present_ptes(struct mm_struct *mm,
> > > +                             struct vm_area_struct *dst_vma,
> > > +                             struct vm_area_struct *src_vma,
> > > +                             unsigned long dst_addr, unsigned long s=
rc_addr,
> > > +                             pte_t *dst_pte, pte_t *src_pte,
> > > +                             pte_t orig_dst_pte, pte_t orig_src_pte,
> > > +                             pmd_t *dst_pmd, pmd_t dst_pmdval,
> > > +                             spinlock_t *dst_ptl, spinlock_t *src_pt=
l,
> > > +                             struct folio **first_src_folio, unsigne=
d long len,
> > > +                             struct anon_vma *src_anon_vma)
> > > +{
> > > +       int err =3D 0;
> > > +       struct folio *src_folio =3D *first_src_folio;
> > > +       unsigned long src_start =3D src_addr;
> > > +       unsigned long src_end;
> > > +
> > > +       if (len > PAGE_SIZE) {
> > > +               len =3D pmd_addr_end(dst_addr, dst_addr + len) - dst_=
addr;
> > > +               src_end =3D pmd_addr_end(src_addr, src_addr + len);
> > > +       } else
> > > +               src_end =3D src_addr + len;
> >
> > Nit:
> >
> > Look at Documentation/process/coding-style.rst.
> >
> > This does not apply if only one branch of a conditional statement is a =
single
> > statement; in the latter case use braces in both branches:
> >
> > .. code-block:: c
> >
> >     if (condition) {
> >         do_this();
> >         do_that();
> >     } else {
> >         otherwise();
> >     }
Sorry for missing that. I can fix this in v6.
> >
> > By the way, what about the following for both cases? Would it impact
> > performance in the `PAGE_SIZE` cases?

I just wanted to avoid a bunch of instructions in two pmd_addr_end
invocations for the (len =3D=3D PAGE_SIZE) case, which is not going to be
uncommon. But I guess overall, it is not big enough to matter so can
be removed.
> >
> > len =3D pmd_addr_end(dst_addr, dst_addr + len) - dst_addr;
> > src_end =3D pmd_addr_end(src_addr, src_addr + len);
>
> By the way, do src and dst always have the same offset within a
> single PMD? I don=E2=80=99t think so. If not, how can we verify that if
> src=E2=80=99s PMD is not overflowing, dst is safe as well?
>
> Have you only checked src? And for src, since you are already using
> pmd_addr_end(), is src_end =3D src_addr + len fine? Why are you calling
> pmd_addr_end twice after your first pmd_addr_end has already limited
> the range?

Effectively, we have to calculate min(len, extent in src pmd, extent
in dst pmd). That's the max that can be batched within a single
critical section of src_ptl and dst_ptl. The first pmd_addr_end() is
calculating min(len, extent of dst pmd). The second pmd_addr_end() is
calculating min(result of previous pmd_addr_end, extent of src pmd). I
don't think I'm missing any overflow check. But please correct me if
I'm mistaken.
>
> Thanks
> Barry

