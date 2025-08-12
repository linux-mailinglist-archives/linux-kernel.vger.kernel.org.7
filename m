Return-Path: <linux-kernel+bounces-765149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70637B22C30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069E5621899
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540BB2F8BC5;
	Tue, 12 Aug 2025 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+hobosO"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807062F8BC0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013850; cv=none; b=hiWGsvtHT8WK2ohnweup3laOnoRnkfR+Gvtvkzw+esAeZKMflEGb/TzU29+An2+hLle9PzkXlCllzJsbhmIAURsxWacftWGb43jdZb/2iz9L9CbLGBixT2RYUq3emA/CCgJsbM1p34bmdSWXBvggBNviC/Tnu/Q1ZEF8lEvil9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013850; c=relaxed/simple;
	bh=H2mT6BZQNndvKoFqhu386TqmQO0dbvpNeUiKe4wBcf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQmfHGUhFoFvwZ4ATFTyG7wbg3GiFZBK6jimiRT9WB6Bb9LkwEPYq4+M703XEljSiWLp24ci7d7hufTcg91miS3OMPRHpp95ByO1mjUEleAG2phIj6vkYX5XvJimqot5ebbCHK/KdxXEr/NAIWkoBwEVQz817ZLeC2/Gv2EnsVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d+hobosO; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-618076f9545so10214a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755013847; x=1755618647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCoZwKFBupR3itwaM4Skw0t8VDfdsrBMsPZ/C5dezKg=;
        b=d+hobosOCEaWy0504LYclIagpjWoaLgtBgbzfWHhWqo6CNthJLVSKG4fWX+5N5IS0J
         kJIuNWtuHqRpcY+lnXtMaYL54CYjCx3a6qJhWW87kXrZREIObzwUHM0mPDwsmiBdwZx5
         5EpmGaHm8rOSg9S8CqmvuSw+Zysl1J94Ce2fMZ+EkbZtDfxNp5atLvLBUrLf2ZRK4HH3
         NG825NMw9+C8xkMkSFRh/C+6pa7qxIrB5qgm71Gau8JjLoZXfoNJx5vDVb8PlzYBqUXP
         tbNXTeFMVETDeyyQlrDwbzlrc/oDBDscQFNyM941tHiECjiEC1Vkc8Tpws36Cy8NsJkv
         VhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755013847; x=1755618647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCoZwKFBupR3itwaM4Skw0t8VDfdsrBMsPZ/C5dezKg=;
        b=weRdk5RGsDC18pwEafJjD+EfpYlX0DE9lB8+CW3p5Tl+qyTfgUVWes1izjPAvQi1PZ
         kJTwhtNAtD0NiwlwHqhNCOFVPy2Oy1r5h/3G+SiDo4lYzBbfCB+4i8A42vC6D+sdJkio
         uycakuyS1g+uD74wKLcM+9BgOpu4aoURWjFeXikDQRh+7CkUVKcpAgQ1HrxD14kqh+m2
         fRNye2yWjLXwI3N7z8V4sog4NuJrPQJJ7NhoT3/Ghht16nFavOy7ioJ7zor0VcDeEP+N
         S2DPApUDP6ZmST8XtGEUguhbGCBixzAMzQ7VElcpBAAWV61lkaEwccP8gMK08ogiUT78
         sQyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLucfgp+yoEUDGcou4DcdAclK6Uyc6As6s1phQD/wUGUQIBnIHteW5TubQOrW+3MSh1ASr34P1zcrahv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx91Fh+PuAJ9runwC/Nzanotot1aS8tBcD6CpkQmPevC21SPKE
	luDN0WG2RVo3Sfbu0tpOrYMIUGI4v0n6q7PeYneUzwOkCiKQW2TCp1uGx8xLhhFKL4EKQIIXIQt
	uLgVBaFtPEzjeYL/dhQ8A4paL5YWr1qaY1+qrSbEk
X-Gm-Gg: ASbGncv3YF70Umy5XTEL8i4hNHBOS5q26SFdZJ++hCFrJ9MoWBXt/uqVLLEaRBJr71U
	XX7yuDfmd1of/tjHL3EGNXlsb8blWsr4XVMjQmdY7NlAs5TaWYrGXM98TAXy3OXCQYo8sqVvvhM
	dsmj+GE1eCIKtuca06+K7Yir9wXCRknyUahn77fC9SQ2rcUUjuk5vee7aV/Htc1NUyCkAwDNEuP
	OUm5LF0yfh4nV+NcUi2e/UOLWkSUben2ocrezbd
X-Google-Smtp-Source: AGHT+IEBJS+zJytE4LlBAX817PjNBbaQW+x370NQ4pBuN1Wk/0tDNwVb6chku+jMLsgNio0Ll/QZIxrFYt0bYXx0JBs=
X-Received: by 2002:aa7:d491:0:b0:618:1799:5baa with SMTP id
 4fb4d7f45d1cf-618517ce884mr81533a12.7.1755013846547; Tue, 12 Aug 2025
 08:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810062912.1096815-1-lokeshgidra@google.com> <CAGsJ_4wbXkfaAn+79g20SfE-0Ak4QACVP+Mw2vAvMnxBCcLAsQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4wbXkfaAn+79g20SfE-0Ak4QACVP+Mw2vAvMnxBCcLAsQ@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 12 Aug 2025 08:50:34 -0700
X-Gm-Features: Ac12FXyCf9Toynyp6Mriq0P668p_pyrHqsgpxbzBfKDhOkLtScB0l-B649WZ7-I
Message-ID: <CA+EESO4JFCR5P9PFoY2zo+X1Y-qv+-yy8X887isoqXwfQBtn1Q@mail.gmail.com>
Subject: Re: [PATCH v4] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 8:55=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> Hi Lokesh,
>
>
> On Sun, Aug 10, 2025 at 2:29=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.=
com> wrote:
> >
> > MOVE ioctl's runtime is dominated by TLB-flush cost, which is required
> > for moving present pages. Mitigate this cost by opportunistically
> > batching present contiguous pages for TLB flushing.
> >
> > Without batching, in our testing on an arm64 Android device with UFFD G=
C,
> > which uses MOVE ioctl for compaction, we observed that out of the total
> > time spent in move_pages_pte(), over 40% is in ptep_clear_flush(), and
> > ~20% in vm_normal_folio().
> >
> > With batching, the proportion of vm_normal_folio() increases to over
> > 70% of move_pages_pte() without any changes to vm_normal_folio().
> > Furthermore, time spent within move_pages_pte() is only ~20%, which
> > includes TLB-flush overhead.
> >
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Kalesh Singh <kaleshsingh@google.com>
> > Cc: Barry Song <v-songbaohua@oppo.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > ---
> > Changes since v3 [1]
> > - Fix unintialized 'step_size' warning, per Dan Carpenter
> > - Removed pmd_none() from check_ptes_for_batched_move(), per Peter Xu
> > - Removed flush_cache_range() in zero-page case, per Peter Xu
> > - Added comment to explain why folio reference for batched pages is not
> >   required, per Peter Xu
> > - Use MIN() in calculation of largest extent that can be batched under
> >   the same src and dst PTLs, per Peter Xu
> > - Release first folio's reference in move_present_ptes(), per Peter Xu
> >
> > Changes since v2 [2]
> > - Addressed VM_WARN_ON failure, per Lorenzo Stoakes
> > - Added check to ensure all batched pages share the same anon_vma
> >
> > Changes since v1 [3]
> > - Removed flush_tlb_batched_pending(), per Barry Song
> > - Unified single and multi page case, per Barry Song
> >
> > [1] https://lore.kernel.org/all/20250807103902.2242717-1-lokeshgidra@go=
ogle.com/
> > [2] https://lore.kernel.org/all/20250805121410.1658418-1-lokeshgidra@go=
ogle.com/
> > [3] https://lore.kernel.org/all/20250731104726.103071-1-lokeshgidra@goo=
gle.com/
> >
> >  mm/userfaultfd.c | 178 +++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 127 insertions(+), 51 deletions(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index cbed91b09640..39d81d2972db 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1026,18 +1026,64 @@ static inline bool is_pte_pages_stable(pte_t *d=
st_pte, pte_t *src_pte,
> >                pmd_same(dst_pmdval, pmdp_get_lockless(dst_pmd));
> >  }
> >
> > -static int move_present_pte(struct mm_struct *mm,
> > -                           struct vm_area_struct *dst_vma,
> > -                           struct vm_area_struct *src_vma,
> > -                           unsigned long dst_addr, unsigned long src_a=
ddr,
> > -                           pte_t *dst_pte, pte_t *src_pte,
> > -                           pte_t orig_dst_pte, pte_t orig_src_pte,
> > -                           pmd_t *dst_pmd, pmd_t dst_pmdval,
> > -                           spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > -                           struct folio *src_folio)
> > +/*
> > + * Checks if the two ptes and the corresponding folio are eligible for=
 batched
> > + * move. If so, then returns pointer to the locked folio. Otherwise, r=
eturns NULL.
> > + *
> > + * NOTE: folio's reference is not required as the whole operation is w=
ithin
> > + * PTL's critical section.
> > + */
> > +static struct folio *check_ptes_for_batched_move(struct vm_area_struct=
 *src_vma,
> > +                                                unsigned long src_addr=
,
> > +                                                pte_t *src_pte, pte_t =
*dst_pte,
> > +                                                struct anon_vma *src_a=
non_vma)
> > +{
> > +       pte_t orig_dst_pte, orig_src_pte;
> > +       struct folio *folio;
> > +
> > +       orig_dst_pte =3D ptep_get(dst_pte);
> > +       if (!pte_none(orig_dst_pte))
> > +               return NULL;
> > +
> > +       orig_src_pte =3D ptep_get(src_pte);
> > +       if (!pte_present(orig_src_pte) || is_zero_pfn(pte_pfn(orig_src_=
pte)))
> > +               return NULL;
> > +
> > +       folio =3D vm_normal_folio(src_vma, src_addr, orig_src_pte);
> > +       if (!folio || !folio_trylock(folio))
> > +               return NULL;
> > +       if (!PageAnonExclusive(&folio->page) || folio_test_large(folio)=
 ||
> > +           folio_anon_vma(folio) !=3D src_anon_vma) {
> > +               folio_unlock(folio);
> > +               return NULL;
> > +       }
> > +       return folio;
> > +}
> > +
>
> I=E2=80=99m still quite confused by the code. Before move_present_ptes(),=
 we=E2=80=99ve
> already performed all the checks=E2=80=94pte_same(), vm_normal_folio(),
> folio_trylock(), folio_test_large(), folio_get_anon_vma(),
> and anon_vma_lock_write()=E2=80=94at least for the first PTE. Now we=E2=
=80=99re
> duplicating them again for all PTEs. Does this mean we=E2=80=99re doing t=
hose
> operations for the first PTE twice? It feels like the old non-batch check
> code should be removed?
>
> > +static long move_present_ptes(struct mm_struct *mm,
> > +                             struct vm_area_struct *dst_vma,
> > +                             struct vm_area_struct *src_vma,
> > +                             unsigned long dst_addr, unsigned long src=
_addr,
> > +                             pte_t *dst_pte, pte_t *src_pte,
> > +                             pte_t orig_dst_pte, pte_t orig_src_pte,
> > +                             pmd_t *dst_pmd, pmd_t dst_pmdval,
> > +                             spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > +                             struct folio **first_src_folio, unsigned =
long len,
> > +                             struct anon_vma *src_anon_vma)
> >  {
> >         int err =3D 0;
> > +       struct folio *src_folio =3D *first_src_folio;
> > +       unsigned long src_start =3D src_addr;
> > +       unsigned long addr_end;
> > +
> > +       if (len > PAGE_SIZE) {
> > +               addr_end =3D (dst_addr + PMD_SIZE) & PMD_MASK;
> > +               len =3D MIN(addr_end - dst_addr, len);
> >
> > +               addr_end =3D (src_addr + PMD_SIZE) & PMD_MASK;
> > +               len =3D MIN(addr_end - src_addr, len);
> > +       }
>
> We already have a pmd_addr_end() helper=E2=80=94can we reuse it?
>
> [...]
>
> >         /*
> > @@ -1257,7 +1327,7 @@ static int move_pages_pte(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd,
> >                 if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES))
> >                         err =3D -ENOENT;
> >                 else /* nothing to do to move a hole */
> > -                       err =3D 0;
> > +                       err =3D PAGE_SIZE;
>
> To be honest, I find `err =3D PAGE_SIZE` quite odd :-) Could we refine th=
e
> code to make it more readable?
>
Agreed! I'll replace 'err' with 'ret' as the function no longer only
returns error but also bytes-moved if there is no error.

> [...]
>
> > @@ -1857,10 +1930,13 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx,=
 unsigned long dst_start,
> >                                 break;
> >                         }
> >
> > -                       err =3D move_pages_pte(mm, dst_pmd, src_pmd,
> > -                                            dst_vma, src_vma,
> > -                                            dst_addr, src_addr, mode);
> > -                       step_size =3D PAGE_SIZE;
> > +                       ret =3D move_pages_ptes(mm, dst_pmd, src_pmd,
> > +                                             dst_vma, src_vma, dst_add=
r,
> > +                                             src_addr, src_end - src_a=
ddr, mode);
> > +                       if (ret < 0)
> > +                               err =3D ret;
> > +                       else
> > +                               step_size =3D ret;
>
> also looks a bit strange :-)

Any suggestions on how to improve this? 'step_size' is expected to be
different in each iteration of the loop even without this patch.
>
> >                 }
> >
> >                 cond_resched();
> >
> > base-commit: 561c80369df0733ba0574882a1635287b20f9de2
> > --
> > 2.50.1.703.g449372360f-goog
> >
>
> Thanks
> Barry

