Return-Path: <linux-kernel+bounces-809104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE87B508B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1931C61495
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A28264A97;
	Tue,  9 Sep 2025 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWFGFLdh"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B41F3BA4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757455433; cv=none; b=KlsdroQraw9YjO5GRyYCyNSvcMwhouNOQgVMpILWV9AM6L+t1I7gRIB7g8mJ6NBjxjdpZv7hlqcFFVPToVbZ3dkzB/w4y/aHqDlbhICBxSTG/Pxkf88pyeTfgk2xW31pJeeyhj0e9suz2J3k+UeAKlfPzyIee0GpU6PmzifN4h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757455433; c=relaxed/simple;
	bh=/YbOT/xtAuBU4zw5y1RJcshmBNddXjAtVK9Bqu9wucE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtPmfM9JNJ+PorwCmb/LwJym/VrUpN15q5PvwVDinWi1PYx22n3wk9vomIZs7z2ucSUIg/bfZc/AnRHWrRUbDrKhe5vbkIRqOGQ4mIEckSBJjrK+3rBowxeGGmi1ol7KJbIpCS1h2ffVvPtcOWbZS3JxmFGILAFptrU6y6vxwbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NWFGFLdh; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b4bcb9638aso183441cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 15:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757455430; x=1758060230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdfxY/tmePyPQQZ4AQC4iyvAmEwVEuUt1ANSa6zzOfk=;
        b=NWFGFLdhCA7lpC8fqV9mKSh1crRBJujPWcMblzni4XBu6tNHMsP+Yw3FWGiv60jc3O
         TTsvbw/YBP52UhBlEfzwQjOo4DmqNlrdqQFfOoGzuPQMM369tcOBdvL8JE0AvUEFHc8B
         ibrZZi44cSJ2VgLwsjuCkLUwigZQ3q92+5WH8u5Lb9YIZT/C/sRE6Drz9A7HtP8g4Fn3
         p4ADdqre0AK4+b3lNb+EylodT4AY7jhpyyDSYREMTHqnHhp1nzFtwMLAAYP1NdVgO4EJ
         8sKqjRb940HCvm88x6cjpiDE542mMK6AgM2F2OA+XM8XdGoyWNOFanLc50oB8VZTNcy7
         33vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757455430; x=1758060230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdfxY/tmePyPQQZ4AQC4iyvAmEwVEuUt1ANSa6zzOfk=;
        b=WKkrLLHS3YnFZBOhSfzkEqyYmRvuVE5bBbbOnccmfWtOT40pqvSAT01S0CEer3QY20
         TT/idxa7r8ITPUdUIg14/eojc59SpM5B/9BlvatWGdCN5RK05CZVlF5xZkOWRrsi14Se
         ue4JSDARvRqBDw1Thuc2ZIsmTFWDzlklrdD4ZudCsiF6SvgJRzXer/ILr/jVzF0KJs3/
         gsQWtD9O7/Q/8i8XiuHexB7hEGIb6Tqk/mppKEMmfjBJONVsOGQBOIsHaOHoO17ajO6J
         Nc50jDxwisRV8Wv/esf8kjMxGdl8TKn9deZuKJrrzMJpSTTZTwPtFQYBbcFTECbAZcWZ
         mShw==
X-Forwarded-Encrypted: i=1; AJvYcCXNK7LlQVHrB3lpXQzIc/25CoTufYggnbALMY5GhCJgl6MH93HHPj2cDGDLo0JrHCsM9z+4IVHBPoCAq+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmWXfLT/KyFPvEfQplncMQ7Ay4lsbS9w+QlmhXSoTGVVN/Svrz
	5o+3yD6OVfi4S8vSMMGPxBIc7vVDmBhQTw5v0r7Ux8lflcp1HU0IWqRRBcbgLNi6nSFDzuxrQP6
	uDf8wG1HCVtdwl17iCVZ8w0AN3U0wimNTSxFuYdY4
X-Gm-Gg: ASbGncuHy1qO/5t1hiYSmVOl1KAE20t6+/5+8OAPk/UK+MlxwePBwpwKr5UVTEPqEwh
	KFqqCAlzexX+lcfBSM233iBAz5uXw5vJwwQmE952OHtbw5l4/6cSU+2+d/IzJG+mQwuPBNF5wt0
	WkRfFzaCxk7PPhU3RnBH4B7HfhzOEVxIBhw8RiRPaLSjyt7AFMSMX1Qe7yxkx8JxENXS/NTlbfD
	uW1cdSHa0yE2EzrXYnDSVlbpuS16IuNvxieQIi9BE4W
X-Google-Smtp-Source: AGHT+IGH9MAIkn9QIyO6RoFKXtsuPBpT+6kFM3APqUb2DuqRhmpbV0XtFElws++iZPivmby1/3S8CAb0x/ApQRsbgRw=
X-Received: by 2002:ac8:5f0c:0:b0:4b3:1617:e616 with SMTP id
 d75a77b69052e-4b62525e5cemr1785581cf.16.1757455429996; Tue, 09 Sep 2025
 15:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com> <20250909190945.1030905-7-Liam.Howlett@oracle.com>
In-Reply-To: <20250909190945.1030905-7-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 15:03:38 -0700
X-Gm-Features: AS18NWCo9ZoQa9ZzyM3hmR7V51NOxY2fhATfOWnpl40gfbyxSS1Epx0ZyM8junY
Message-ID: <CAJuCfpHz9Q-GMSZQ0xY8_oAuoWTA6DUHfCses7e7_FL8mi_1bQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] mm: Change dup_mmap() recovery
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com, 
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 12:11=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> When the dup_mmap() fails during the vma duplication or setup, don't
> write the XA_ZERO entry in the vma tree.  Instead, destroy the tree and
> free the new resources, leaving an empty vma tree.
>
> Using XA_ZERO introduced races where the vma could be found between
> dup_mmap() dropping all locks and exit_mmap() taking the locks.  The
> race can occur because the mm can be reached through the other trees
> via successfully copied vmas and other methods such as the swapoff code.
>
> XA_ZERO was marking the location to stop vma removal and pagetable
> freeing.  The newly created arguments to the unmap_vmas() and
> free_pgtables() serve this function.
>
> Replacing the XA_ZERO entry use with the new argument list also means
> the checks for xa_is_zero() are no longer necessary so these are also
> removed.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/memory.c |  6 +-----
>  mm/mmap.c   | 42 +++++++++++++++++++++++++++++++-----------
>  2 files changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 24716b3713f66..829cd94950182 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -408,8 +408,6 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_=
state *mas,
>                  * be 0.  This will underflow and is okay.
>                  */
>                 next =3D mas_find(mas, tree_max - 1);
> -               if (unlikely(xa_is_zero(next)))
> -                       next =3D NULL;
>
>                 /*
>                  * Hide vma from rmap and truncate_pagecache before freei=
ng
> @@ -428,8 +426,6 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_=
state *mas,
>                 while (next && next->vm_start <=3D vma->vm_end + PMD_SIZE=
) {
>                         vma =3D next;
>                         next =3D mas_find(mas, tree_max - 1);
> -                       if (unlikely(xa_is_zero(next)))
> -                               next =3D NULL;
>                         if (mm_wr_locked)
>                                 vma_start_write(vma);
>                         unlink_anon_vmas(vma);
> @@ -2129,7 +2125,7 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_s=
tate *mas,
>                                  mm_wr_locked);
>                 hugetlb_zap_end(vma, &details);
>                 vma =3D mas_find(mas, tree_end - 1);
> -       } while (vma && likely(!xa_is_zero(vma)));
> +       } while (vma);
>         mmu_notifier_invalidate_range_end(&range);
>  }
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 0f4808f135fe6..aa4770b8d7f1e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1288,7 +1288,7 @@ void exit_mmap(struct mm_struct *mm)
>         arch_exit_mmap(mm);
>
>         vma =3D vma_next(&vmi);
> -       if (!vma || unlikely(xa_is_zero(vma))) {
> +       if (!vma) {
>                 /* Can happen if dup_mmap() received an OOM */
>                 mmap_read_unlock(mm);
>                 mmap_write_lock(mm);
> @@ -1858,20 +1858,40 @@ __latent_entropy int dup_mmap(struct mm_struct *m=
m, struct mm_struct *oldmm)
>                 ksm_fork(mm, oldmm);
>                 khugepaged_fork(mm, oldmm);
>         } else {
> +               unsigned long max;
>
>                 /*
> -                * The entire maple tree has already been duplicated. If =
the
> -                * mmap duplication fails, mark the failure point with
> -                * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encou=
ntered,
> -                * stop releasing VMAs that have not been duplicated afte=
r this
> -                * point.
> +                * The entire maple tree has already been duplicated, but
> +                * replacing the vmas failed at mpnt (which could be NULL=
 if
> +                * all were allocated but the last vma was not fully set =
up).
> +                * Use the start address of the failure point to clean up=
 the
> +                * partially initialized tree.
>                  */
> -               if (mpnt) {
> -                       mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_=
end - 1);
> -                       mas_store(&vmi.mas, XA_ZERO_ENTRY);
> -                       /* Avoid OOM iterating a broken tree */
> -                       mm_flags_set(MMF_OOM_SKIP, mm);
> +               if (!mm->map_count) {
> +                       /* zero vmas were written to the new tree. */
> +                       max =3D 0;
> +               } else if (mpnt) {
> +                       /* partial tree failure */
> +                       max =3D mpnt->vm_start;
> +               } else {
> +                       /* All vmas were written to the new tree */

So, the cleanup for this case used to be handled by exit_mmap(). I
think it's ok to do it here but the changelog should mention this
change as well IMHO.

> +                       max =3D ULONG_MAX;
>                 }
> +
> +               /* Hide mm from oom killer because the memory is being fr=
eed */
> +               mm_flags_set(MMF_OOM_SKIP, mm);
> +               if (max) {
> +                       vma_iter_set(&vmi, 0);
> +                       tmp =3D vma_next(&vmi);
> +                       flush_cache_mm(mm);
> +                       unmap_region(&vmi.mas, /* vma =3D */ tmp,
> +                                    /*vma_min =3D */ 0, /* vma_max =3D *=
/ max,
> +                                    /* pg_max =3D */ max, /* prev =3D */=
 NULL,
> +                                    /* next =3D */ NULL);
> +                       charge =3D tear_down_vmas(mm, &vmi, tmp, max);
> +                       vm_unacct_memory(charge);
> +               }
> +               __mt_destroy(&mm->mm_mt);
>                 /*
>                  * The mm_struct is going to exit, but the locks will be =
dropped
>                  * first.  Set the mm_struct as unstable is advisable as =
it is
> --
> 2.47.2
>

