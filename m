Return-Path: <linux-kernel+bounces-765132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D17BB22BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66CC8503B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5E0302CC0;
	Tue, 12 Aug 2025 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4QmRXigr"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B232EB5A7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013501; cv=none; b=arqta+1SKnGPC3PpMQED8yw6fcNWHqPZRGHVmtncWi3U5xd88xEUCRnQZCNp3VWsA2XBIva/rLGL46i22VTzL72c3vkS5UiiloLYGOyIHTBWAeQN+5aMatD6C1fx9mzvHcuj6ChpnQ69SpuRWSdw3Wz+ilDp1ZqtTjNJfDj12bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013501; c=relaxed/simple;
	bh=V4nAfRh5hJEaNgQ0XNa1PZHky2LJQmCg5Kdc9PzaoPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFPk0MEtGBG4CnwqFv6H+UpX8N89K1DL4UMv6C8u84gJ97UOtBhD22nFW/tHkWRQDHb/jev7rZODj4NFNZUvsTkkl5/DDLSImwuPp8375+GUCTjArtsLwySBk1Ea5LAAa9nf9vqRgjJG4e/ZNs1rOI3JysgjK5POORZZ3v8fUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4QmRXigr; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-618076f9545so10151a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755013497; x=1755618297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsK293MmHf8pse6HN2BuJU8GIQNvtZ8jhqFCWJgRy+I=;
        b=4QmRXigrsTNTpm0nSlEcaThLh0bxbKrjveh6/lwujgS3wO/XZC+4esBd7ZtshmYZWQ
         JPrmOwvWCWxcipZKfoC4QDcYFmI/R5+QBfpJDc00CnnMhBr55Tc5trF8iNk+EFQUqM4v
         F9pEIi3pd7ZhOYin27QOqbFhUec2q6oXkw1480uY/qjfEh/TtJaN5qIS2Tj2UoYNxnaf
         Z9BCZg44u1WGLyAPwVWi0Xyny07oPIC9VX4GEzbzsOdDat9Ldw2gODyHGbIJ8SbsDlcW
         +If4nVK2f8ibHB2Y1vLWOUfF2O+gLlJ8sSCv/7uOQNVkFbDxv8iOMwTgi+zZSjzCmjf6
         Pl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755013497; x=1755618297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsK293MmHf8pse6HN2BuJU8GIQNvtZ8jhqFCWJgRy+I=;
        b=CdPZg1lc910vyJzAUPPn8IGzDg49vk3uzOqMvscvtCygwoWtyy6ubjJe+9SePLZjny
         Oyi/Yva6BaUVo31NV6y44OYxx3kKp3alsiR4qYik3CwXl9/kY71qz3xdp7RZXtO9mFfZ
         Q5RSyxLRtV1XGRld2SKYFtow5g29WIsbmsCpsWkbAGo4d0ToyWwQyC7dFYFYsPHY0BWu
         kmp0WbhG4iruOypkFRSWiQx9tj+JJCDqXCsmxzh4b5pp5g6NUUafrGeAVd5OmX1PcYmd
         YYZaAgrTxgHKK1AegaKWl9+QRD83R1p+tejwvp0rPphVwnkI6sk3xQtaL2VMa4uT9bq4
         lsmg==
X-Forwarded-Encrypted: i=1; AJvYcCV+EXFmdmzv43fIW9BXDN/v5QrmAY8XigN8hO1HkSX/ECfUCbi/Afo5bEHBUCJf5yQxbEE5STh615mzN1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0q0kcwyRn70IPcnX0JytIwacZVMWKj2opWHsk61cwgrPHYO0X
	hckBPBaowxo0GaGqNn2Bbb+9Qr8FaPqY/vc8Y6/QaIUYIzE+YWf61grV9d1wctMbfykP2q5ejAI
	W6YmSJsPIfr9afl5PRu7xGx/LgZEHneIwE3ql8Xmb
X-Gm-Gg: ASbGnctIvTKk+egHrz9q5AXzw82rxVXKznbIvSZvtXGR/CeQOBgdvL3gpEhaO009l7u
	Nbt7gQGwA7P2lr7z+NrRZxqbEH2GF5BhkZLv+gWr76RVgLmd6tr4pISBZASgPVqd8Hh75Wq56Sf
	ydhBDuiicG0IGWxELTdoyIvtPpbfUGmJeRebnjgINSlpbZDurAE7MbtTFYMog6VC0xnsrxiMk0X
	PVj+9kCEXq57GT0rWs8868jei9quNbACg62CWsc
X-Google-Smtp-Source: AGHT+IHmN1t9Ow7j1HNO/tSwEsAAgRPZFDsfEauZe3ao3LGyM8hJQlwtkpJACn0tgu3202KbNvXn1eiPTrCsNP+bcKU=
X-Received: by 2002:a50:c309:0:b0:618:527d:633d with SMTP id
 4fb4d7f45d1cf-618527d6397mr70467a12.5.1755013497120; Tue, 12 Aug 2025
 08:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810062912.1096815-1-lokeshgidra@google.com>
 <CAGsJ_4wbXkfaAn+79g20SfE-0Ak4QACVP+Mw2vAvMnxBCcLAsQ@mail.gmail.com> <aJtTPkenKeFuFFNQ@x1.local>
In-Reply-To: <aJtTPkenKeFuFFNQ@x1.local>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 12 Aug 2025 08:44:44 -0700
X-Gm-Features: Ac12FXyU0NQ9L3LCZ3v7S5pHOgaGIENanOTtEMEbC_428PvXJZ_y6RAyNUzVtBo
Message-ID: <CA+EESO763JtY3jjmgGGbJjSQcnJJFNpDs2iPaUwjP44VpyyzdQ@mail.gmail.com>
Subject: Re: [PATCH v4] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Peter Xu <peterx@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, aarcange@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 7:44=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Aug 11, 2025 at 11:55:36AM +0800, Barry Song wrote:
> > Hi Lokesh,
> >
> >
> > On Sun, Aug 10, 2025 at 2:29=E2=80=AFPM Lokesh Gidra <lokeshgidra@googl=
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
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Kalesh Singh <kaleshsingh@google.com>
> > > Cc: Barry Song <v-songbaohua@oppo.com>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > ---
> > > Changes since v3 [1]
> > > - Fix unintialized 'step_size' warning, per Dan Carpenter
> > > - Removed pmd_none() from check_ptes_for_batched_move(), per Peter Xu
> > > - Removed flush_cache_range() in zero-page case, per Peter Xu
> > > - Added comment to explain why folio reference for batched pages is n=
ot
> > >   required, per Peter Xu
> > > - Use MIN() in calculation of largest extent that can be batched unde=
r
> > >   the same src and dst PTLs, per Peter Xu
> > > - Release first folio's reference in move_present_ptes(), per Peter X=
u
> > >
> > > Changes since v2 [2]
> > > - Addressed VM_WARN_ON failure, per Lorenzo Stoakes
> > > - Added check to ensure all batched pages share the same anon_vma
> > >
> > > Changes since v1 [3]
> > > - Removed flush_tlb_batched_pending(), per Barry Song
> > > - Unified single and multi page case, per Barry Song
> > >
> > > [1] https://lore.kernel.org/all/20250807103902.2242717-1-lokeshgidra@=
google.com/
> > > [2] https://lore.kernel.org/all/20250805121410.1658418-1-lokeshgidra@=
google.com/
> > > [3] https://lore.kernel.org/all/20250731104726.103071-1-lokeshgidra@g=
oogle.com/
> > >
> > >  mm/userfaultfd.c | 178 +++++++++++++++++++++++++++++++++------------=
--
> > >  1 file changed, 127 insertions(+), 51 deletions(-)
> > >
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index cbed91b09640..39d81d2972db 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -1026,18 +1026,64 @@ static inline bool is_pte_pages_stable(pte_t =
*dst_pte, pte_t *src_pte,
> > >                pmd_same(dst_pmdval, pmdp_get_lockless(dst_pmd));
> > >  }
> > >
> > > -static int move_present_pte(struct mm_struct *mm,
> > > -                           struct vm_area_struct *dst_vma,
> > > -                           struct vm_area_struct *src_vma,
> > > -                           unsigned long dst_addr, unsigned long src=
_addr,
> > > -                           pte_t *dst_pte, pte_t *src_pte,
> > > -                           pte_t orig_dst_pte, pte_t orig_src_pte,
> > > -                           pmd_t *dst_pmd, pmd_t dst_pmdval,
> > > -                           spinlock_t *dst_ptl, spinlock_t *src_ptl,
> > > -                           struct folio *src_folio)
> > > +/*
> > > + * Checks if the two ptes and the corresponding folio are eligible f=
or batched
> > > + * move. If so, then returns pointer to the locked folio. Otherwise,=
 returns NULL.
> > > + *
> > > + * NOTE: folio's reference is not required as the whole operation is=
 within
> > > + * PTL's critical section.
> > > + */
> > > +static struct folio *check_ptes_for_batched_move(struct vm_area_stru=
ct *src_vma,
> > > +                                                unsigned long src_ad=
dr,
> > > +                                                pte_t *src_pte, pte_=
t *dst_pte,
> > > +                                                struct anon_vma *src=
_anon_vma)
> > > +{
> > > +       pte_t orig_dst_pte, orig_src_pte;
> > > +       struct folio *folio;
> > > +
> > > +       orig_dst_pte =3D ptep_get(dst_pte);
> > > +       if (!pte_none(orig_dst_pte))
> > > +               return NULL;
> > > +
> > > +       orig_src_pte =3D ptep_get(src_pte);
> > > +       if (!pte_present(orig_src_pte) || is_zero_pfn(pte_pfn(orig_sr=
c_pte)))
> > > +               return NULL;
> > > +
> > > +       folio =3D vm_normal_folio(src_vma, src_addr, orig_src_pte);
> > > +       if (!folio || !folio_trylock(folio))
> > > +               return NULL;
> > > +       if (!PageAnonExclusive(&folio->page) || folio_test_large(foli=
o) ||
> > > +           folio_anon_vma(folio) !=3D src_anon_vma) {
> > > +               folio_unlock(folio);
> > > +               return NULL;
> > > +       }
> > > +       return folio;
> > > +}
> > > +
> >
> > I=E2=80=99m still quite confused by the code. Before move_present_ptes(=
), we=E2=80=99ve
> > already performed all the checks=E2=80=94pte_same(), vm_normal_folio(),
> > folio_trylock(), folio_test_large(), folio_get_anon_vma(),
> > and anon_vma_lock_write()=E2=80=94at least for the first PTE. Now we=E2=
=80=99re
> > duplicating them again for all PTEs. Does this mean we=E2=80=99re doing=
 those
> > operations for the first PTE twice? It feels like the old non-batch che=
ck
> > code should be removed?
>
> This function should only start to work on the 2nd (or more) continuous
> ptes to move within the same pgtable lock held.  We'll still need the
> original path because that was sleepable, this one isn't, and it's only
> best-effort fast path only. E.g. if trylock() fails above, it would
> fallback to the slow path.
>
Thanks Peter. I was about to give exactly the same reasoning :)
> >
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
> > >  {
> > >         int err =3D 0;
> > > +       struct folio *src_folio =3D *first_src_folio;
> > > +       unsigned long src_start =3D src_addr;
> > > +       unsigned long addr_end;
> > > +
> > > +       if (len > PAGE_SIZE) {
> > > +               addr_end =3D (dst_addr + PMD_SIZE) & PMD_MASK;
> > > +               len =3D MIN(addr_end - dst_addr, len);
> > >
> > > +               addr_end =3D (src_addr + PMD_SIZE) & PMD_MASK;
> > > +               len =3D MIN(addr_end - src_addr, len);
> > > +       }
> >
> > We already have a pmd_addr_end() helper=E2=80=94can we reuse it?
>
> I agree with Barry; I wante to say this version didn't use ALIGN() that I
> suggested but pmd_addr_end() looks better.

ALIGN() couldn't be used as we are calculating "how many bytes to the
next PMD" and not just align it. Anyways, pmd_addr_end() is definitely
better. Will do it in the next patch.
>
> Other than that this version looks good to me (plus the higher level
> performance results updated to the commit message, per requested in v3),
> thanks Lokesh.

Thanks Peter. I'll update the commit message in v5.
>
> --
> Peter Xu
>

