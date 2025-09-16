Return-Path: <linux-kernel+bounces-819402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 000F5B5A012
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7F8C7B4F04
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1802F283FD0;
	Tue, 16 Sep 2025 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulzoXZXm"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB6032D5A0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046030; cv=none; b=ch8+oncf+/il1q1z3JqenBpL+W2zWUgbzDhD/8IENnmyT/eP0ByT/dV2R3k30LP0Lk/dn6bHncMbsQl2WKLqrmBlXIua+9TXIGr/KeuR4VqOOG1PZyubqXTj6/2UwqDuVHfvCpIMwesGSdM0KA6UK65qFsCWJl2VWGInMIXq+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046030; c=relaxed/simple;
	bh=l63YpLdt6NJb37VHyjHoceD2xEd5xM4zNkDusCdj8CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjslWUQj+x6dI3Lr1UNhlKDDeT/ije0IcMAEz91W+CDXqkDkpvYXgijziY4jLyLLS0B6wcxU2q6NvpmIUZCcqxdyFQBr5izwYFpMU6hym9kAO4/s7srEgDZAlQzLWv75qYOOkQUlk4DgY+R86PiCvCl9fnJt1RBJlzmvWah0GSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ulzoXZXm; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-424077143d9so13975ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758046028; x=1758650828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KjGjO8XGxVvCKmZIwlHy8ncxZnVLCCocyJUuVml/u0=;
        b=ulzoXZXmjiubUoI329yYp7jvTtdSI1Y7yWyl6hhMqJ4DY4DRwTyVLVipxgihMdr95c
         Rzb4JLhVqCw1MR7YgqfN//C/ZFc3yAnotHdTf4xA9vUpeHHY+JSggPWB8NMAOztwkh4K
         wEfpu5wL9J5T61LoxfzFlV/ULTc0LMQcqe6+7gzujpCnXT3hscAOHIRG8POdU3a3u6WQ
         fMwWKuIb3+dPs6nIeclGu2iuzTizC5rXShIaT+k3sffAh5y+ntzP6gffhE0FqsCiPvIE
         p5zsjNDHKuyJktpb85faNRzIZ1pAVZIN/tRHm4qYu7O3z+tZEpEgBrgu1TPl5mt5ky9k
         uriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758046028; x=1758650828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/KjGjO8XGxVvCKmZIwlHy8ncxZnVLCCocyJUuVml/u0=;
        b=tIhYhgaEzPZogJhWaaa6tl09+FqreIPJDGTt4ZElxqFuyoqf439HOOzC+nkPvqoaQh
         GabeNMRgRaYlUD+MTuVyGc31lQr3fyBRpS1xm5DN99GhXf6ar3Rqi41Pm8GgYAZba7Wt
         9tlf8k5kIMXaBdDQQdDaQ9ND3lFfDQ/18P65bh/sjC2/Q2WCETCy2mgbVwNr3pF/48kL
         zpsWioRwzb1YKuY94dUvriwyd2/QMcc1DGttF469uzZJkVZcduf24clG03TG10f09yEh
         l8FgoPdr8mszNZtM38a9y1GqfNeajiL7dRgcfWNFr/9mCFVPRSL8YhZGfNot4eyW3tz4
         Hpsg==
X-Forwarded-Encrypted: i=1; AJvYcCU5OrAHoEqDBapMfbeU9jXenmdvSZDN+TjbVc0s2LWwviGdw4fX/p77TA7ecM9i6ApMgL8l5Rl6ILB94L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxA4hNNo8BfVCZSGBTdOFHIrthgw0Z32dqRhEml3jKJyQcS7z3
	3AEUlsBKDD2JRPQ9mXJUij5BcR/SJ7jkltEaOlSblP4KNR1oari8qYLPwcuxjcBKp7EjT7EZ33D
	pBR6ZGtxBcNiRPm1DLzo3Z0P/88UkP6jSQrA0GP2dBsvmFeCgShgedLXTzRA=
X-Gm-Gg: ASbGncvO6eaZhHDnCb2wOFabMKe+DOtC0oKBKrvd9LJxd7iFthLwUM2fkPWMxiNl3Yn
	yrnPLusF7Q4bh7N28s4K51lPvgSdR/ldL8b0tdB7VGVBFU1y/tdHLzdSln9KJP5zLlyFE//+Tw2
	uyq0VdcsSG2X+GGcuK1cpbzWqglu2vn394DklBCcLds/W4MoFMCd2U6ktEdbFQUEKQNOrEd/GRc
	ZFSKbqcJMkDirs=
X-Google-Smtp-Source: AGHT+IEAMJII84irpmIS/OV0EYa+nFz8pldmS99mcGDbzc3y+pmYWTzZkT0LnGPBAy23zM64iVBtswHZSemYM9fDOxA=
X-Received: by 2002:a05:6e02:1947:b0:41b:96f1:7e04 with SMTP id
 e9e14a558f8ab-42418653a5dmr526845ab.14.1758046027304; Tue, 16 Sep 2025
 11:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <v5ivpub6z2n2uyemlnxgbilzs52ep4lrary7lm7o6axxoneb75@yfacfl5rkzeh> <ecac1e7f-1709-4348-b8ff-fa1c0f087548@lucifer.local>
In-Reply-To: <ecac1e7f-1709-4348-b8ff-fa1c0f087548@lucifer.local>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Tue, 16 Sep 2025 11:06:30 -0700
X-Gm-Features: AS18NWC3dVBCWy9nf2z_yV-AQK7gFYe9HNxvrXs-9Ts5zi9RXbH5GvIfwGpTxSs
Message-ID: <CAAa6QmRaiKB2OOpZYjRx3EAQ+d8_G=MsVmV=9cc_MmHOYsikow@mail.gmail.com>
Subject: Re: [PATCHv2] mm/khugepaged: Do not fail collapse_pte_mapped_thp() on SCAN_PMD_NULL
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:54=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Sep 15, 2025 at 02:52:53PM +0100, Kiryl Shutsemau wrote:
> > From: Kiryl Shutsemau <kas@kernel.org>
> >
> > MADV_COLLAPSE on a file mapping behaves inconsistently depending on if
> > PMD page table is installed or not.
> >
> > Consider following example:
> >
> >       p =3D mmap(NULL, 2UL << 20, PROT_READ | PROT_WRITE,
> >                MAP_SHARED, fd, 0);
> >       err =3D madvise(p, 2UL << 20, MADV_COLLAPSE);
> >
> > fd is a populated tmpfs file.
> >
> > The result depends on the address that the kernel returns on mmap().
> > If it is located in an existing PMD table, the madvise() will succeed.
> > However, if the table does not exist, it will fail with -EINVAL.
> >
> > This occurs because find_pmd_or_thp_or_none() returns SCAN_PMD_NULL whe=
n
> > a page table is missing, which causes collapse_pte_mapped_thp() to fail=
.
> >
> > SCAN_PMD_NULL and SCAN_PMD_NONE should be treated the same in
> > collapse_pte_mapped_thp(): install the PMD leaf entry and allocate page
> > tables as needed.
> >
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>

So, since we are trying to aim for consistency here, I think we ought
to also support the anonymous case.

I don't have a patch, but can spot at least two things we'd need to adjust:

First, we are defeated by the check in __thp_vma_allowable_orders();

        /*
         * THPeligible bit of smaps should show 1 for proper VMAs even
         * though anon_vma is not initialized yet.
         *
         * Allow page fault since anon_vma may be not initialized until
         * the first page fault.
         */
        if (!vma->anon_vma)
                return (smaps || in_pf) ? orders : 0;

I think we can probably just delete that check, but would need to confirm.

And second, madvise_collapse() doesn't route SCAN_PMD_NULL to
collapse_pte_mapped_thp(). I think we just need to audit places where
we return this code, to make sure it's faithfully describing a
situation where we can go ahead and install a new pmd. As a hasty
check, the return codes in check_pmd_state() don't look to follow
that, with !present and pmd_bad() returning SCAN_PMD_NULL. Likewise,
there are many underlying failure reasons for
pte_offset_map_ro_nolock()=3D>___pte_offset_map() that aren't "no PMD
entry".

WDYT?

> There was a v1 with tags, you've not propagated any of them? Did you feel
> the change was enough to remove them?
>
> Anyway, LGTM so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> > ---
> >
> > v2:
> >  - Modify set_huge_pmd() instead of introducing install_huge_pmd();
> >
> > ---
> >  mm/khugepaged.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index b486c1d19b2d..986718599355 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1472,15 +1472,32 @@ static void collect_mm_slot(struct khugepaged_m=
m_slot *mm_slot)
> >  static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr=
,
> >                       pmd_t *pmdp, struct folio *folio, struct page *pa=
ge)
> >  {
> > +     struct mm_struct *mm =3D vma->vm_mm;
> >       struct vm_fault vmf =3D {
> >               .vma =3D vma,
> >               .address =3D addr,
> >               .flags =3D 0,
> > -             .pmd =3D pmdp,
> >       };
> > +     pgd_t *pgdp;
> > +     p4d_t *p4dp;
> > +     pud_t *pudp;
> >
> >       mmap_assert_locked(vma->vm_mm);
>
> NIT: you have mm as a local var should use here too. Not a big deal thoug=
h
> obviously...
>
> >
> > +     if (!pmdp) {
> > +             pgdp =3D pgd_offset(mm, addr);
> > +             p4dp =3D p4d_alloc(mm, pgdp, addr);
> > +             if (!p4dp)
> > +                     return SCAN_FAIL;
> > +             pudp =3D pud_alloc(mm, p4dp, addr);
> > +             if (!pudp)
> > +                     return SCAN_FAIL;
> > +             pmdp =3D pmd_alloc(mm, pudp, addr);
> > +             if (!pmdp)
> > +                     return SCAN_FAIL;
> > +     }
> > +
> > +     vmf.pmd =3D pmdp;
> >       if (do_set_pmd(&vmf, folio, page))
> >               return SCAN_FAIL;
> >
> > @@ -1556,6 +1573,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm,=
 unsigned long addr,
> >       switch (result) {
> >       case SCAN_SUCCEED:
> >               break;
> > +     case SCAN_PMD_NULL:
> >       case SCAN_PMD_NONE:
> >               /*
> >                * All pte entries have been removed and pmd cleared.
> > --
> > 2.50.1
> >
>

