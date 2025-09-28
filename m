Return-Path: <linux-kernel+bounces-835428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F11BA70D8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB5E7AA951
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 13:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C2B2D878C;
	Sun, 28 Sep 2025 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nyi4I9hB"
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC43231A24
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759065665; cv=none; b=FlggXNOfnq6OKRTvoWctyqlmD8Gm3Byrl8eXqqTi0hG/ouplRAFXZlmNt8tjdUIUkT+VtS4nhhXsFN5s8BazF4AgFbCVOojBE0c4eJ/qZyfU+a1Oagg/Exiw0mR2zrtEM+0eHEE9lgEdCqFYNPRTBtWU3EBru6/epCn0bBQ6wCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759065665; c=relaxed/simple;
	bh=d9v0N6XzVLqmTCQJRlFN7hY1wuglkNQ9teZxOx8L8Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uH2VNvQ1kHdaXEufZOm8pdSezPHaS6SxwdDGHRldYvB6O6J7Opuu03QNG4Af3+8/XeCSGuMDpnKu/H9jHf5pEdS5fKiVkixwhiObGudZ+fOdr8nPs03sRshd0uS61lI86b9HWed0ReKXUnxTQrOJGvNv6OcMDXZsmohbI0juKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nyi4I9hB; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b5516ee0b0bso2654442a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759065663; x=1759670463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuyN8LaIynLMOcVVAC8DjDfcTekaNgJ1YBpvc463uzg=;
        b=Nyi4I9hBu0+wUzOWjpDFudTwDO1bbWGHMK2gs22bRKybJXeLOB8wUrrYHfr/i/0Zn3
         9cmllc1DkMPLi93O16KLZN3VwEr/L+N958HKnYkxtIhc0rxniA3lcIAvLrBBlMnEG5Hv
         JaorvWHG1QGPWzd9ATVQdSFpe+SN9YSrud87DqgZiXPeDFtv/s4ZSjfQWQXIezvrxWLq
         27KbKOq/km0aSks/kfwrJOfwQsBQY4vFY7tTk4X5/6upM3MBktvd7jM7igeGB79/J7AZ
         5oBhp6PlZnmS+1E15FARXYsSSoYxObbtxJNRQINLQL/DowFERTP6TcJECQcDvNFGd18Z
         tlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759065663; x=1759670463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuyN8LaIynLMOcVVAC8DjDfcTekaNgJ1YBpvc463uzg=;
        b=SJ6zGdagIcvIVVBDkDwzBQz5NC6j1LJdCEAbO/OyhLWCZ0ps73jdVVqmOLizCrNhyy
         OItbbI29MRHPAcUwTB/7uUTTMU/N+VqpP2tEOprlTazAn8nqvpVsEutczwqaQhKTm1X0
         CBg5MQo9qfCxrf+qnKdUroqNN/VVRotZYIT29cKinbbpdzL5c3zk3wrFv+pTNDKuyUmc
         R+v3cMps8FjO+aORpVhuS6K3xcmQ3DksedKtztNX/1JQ/uALetKL0Jpun5uGMpZR3x/d
         DMqM6uJcHeMPpmXobbHQ9Co85FntQvXRNnCiIVOxBcpbPMH2TIJIyJ9HiNCNqKitRK9q
         AmOA==
X-Forwarded-Encrypted: i=1; AJvYcCW2AbfB1jswsC3yVpvZlY0cTPQyBBmLJ6/xQfLBRwCQshQVXq9rqagjSXlMECQvQmWs2HhgxaQDtizSwrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhY7WgptmnNz6q+1iv8VCbezvVx5HXFJ+lbTe/LkaCjWQGp9pZ
	FeaKT96ZzbwsH1u8ilDPN2svTno5Jji4Lo946WrHjRwjO8TRrOfUtbe/REx95C9Yx5yclCflwb3
	NQgKmkPk3kzouavEG+4lDKl9dEla98IUD94/cuSlesQ==
X-Gm-Gg: ASbGncsP7rz4iXd4FI49NCYxv1hBgoiXgOD4mPA0sRu12WdrGU5RYcBX+lM3SN/JCxX
	9nlaPoqvG/FUg4/uZdR64nT9DRSwFZwa+IJ28TGE+9P0OdOpGutfziLi4zZ284Vmxr+Qmh/XBjQ
	Ll0C7lVpdKf8TAjxpTpFHX7trhikg4DP15c3EfUMpV1oMQQP1ulM0wPPski7Ej0C47Oqp6WRjMw
	ncNJfw=
X-Google-Smtp-Source: AGHT+IFRY7I1KjBJHD7Gi4iDoz0ScrOwSI8gibtvMBpXyv84g3To5Nz+4EvBusFuikjVvBGDoVwGH9iWdxQZsANhsOE=
X-Received: by 2002:a17:902:dac2:b0:260:3c5d:9c2 with SMTP id
 d9443c01a7336-27ed4a93585mr142568915ad.48.1759065662606; Sun, 28 Sep 2025
 06:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927064926.1496579-1-jianyungao89@gmail.com> <933cfdc7-9e3f-4dec-a5d9-bb193b0b7f13@arm.com>
In-Reply-To: <933cfdc7-9e3f-4dec-a5d9-bb193b0b7f13@arm.com>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Sun, 28 Sep 2025 21:20:54 +0800
X-Gm-Features: AS18NWD5h28x_EqzgNeA5bm5R8WhOU4cAhQuKUd1TqaJB4e2HcCJNRb3F5Oq-pY
Message-ID: <CAHP3+4DpW1R4nP2c5JOK_==zDXBRkHyJggBp4KrCxv7dPfb3Eg@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: Fix some typos in hugetlb module
To: Dev Jain <dev.jain@arm.com>
Cc: linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 28, 2025 at 8:56=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
>
> On 27/09/25 12:19 pm, jianyun.gao wrote:
> > There are som typos in the code comments as follows:
> >
> >    differenciate =3D=3D> differentiate
> >    refernece =3D=3D> reference
> >    permissons =3D=3D> permissions
> >    indepdenent =3D=3D> independent
> >    Spliting =3D=3D> Splitting
> >
> > Just fix it.
> >
> > Signed-off-by: jianyun.gao <jianyungao89@gmail.com>
> > ---
> >   mm/hugetlb.c         | 6 +++---
> >   mm/hugetlb_vmemmap.c | 6 +++---
> >   2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index eed59cfb5d21..8ff9edd09504 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -2954,7 +2954,7 @@ typedef enum {
> >        * NOTE: This is mostly identical to MAP_CHG_NEEDED, except
> >        * that currently vma_needs_reservation() has an unwanted side
> >        * effect to either use end() or commit() to complete the
> > -      * transaction.  Hence it needs to differenciate from NEEDED.
> > +      * transaction.  Hence it needs to differentiate from NEEDED.
> >        */
> >       MAP_CHG_ENFORCED =3D 2,
> >   } map_chg_state;
> > @@ -5998,7 +5998,7 @@ void __unmap_hugepage_range(struct mmu_gather *tl=
b, struct vm_area_struct *vma,
> >       /*
> >        * If we unshared PMDs, the TLB flush was not recorded in mmu_gat=
her. We
> >        * could defer the flush until now, since by holding i_mmap_rwsem=
 we
> > -      * guaranteed that the last refernece would not be dropped. But w=
e must
> > +      * guaranteed that the last reference would not be dropped. But w=
e must
> >        * do the flushing before we return, as otherwise i_mmap_rwsem wi=
ll be
> >        * dropped and the last reference to the shared PMDs page might b=
e
> >        * dropped as well.
> > @@ -7179,7 +7179,7 @@ long hugetlb_change_protection(struct vm_area_str=
uct *vma,
> >               } else if (unlikely(is_pte_marker(pte))) {
> >                       /*
> >                        * Do nothing on a poison marker; page is
> > -                      * corrupted, permissons do not apply.  Here
> > +                      * corrupted, permissions do not apply.  Here
>
> Can also fix the extra space between "apply" and "Here".

Sure, I will fix it in the next patch.

>
> >                        * pte_marker_uffd_wp()=3D=3Dtrue implies !poison
> >                        * because they're mutual exclusive.
> >                        */
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index ba0fb1b6a5a8..e6f79b2c63ee 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -75,7 +75,7 @@ static int vmemmap_split_pmd(pmd_t *pmd, struct page =
*head, unsigned long start,
> >       if (likely(pmd_leaf(*pmd))) {
> >               /*
> >                * Higher order allocations from buddy allocator must be =
able to
> > -              * be treated as indepdenent small pages (as they can be =
freed
> > +              * be treated as independent small pages (as they can be =
freed
> >                * individually).
> >                */
> >               if (!PageReserved(head))
> > @@ -684,7 +684,7 @@ static void __hugetlb_vmemmap_optimize_folios(struc=
t hstate *h,
> >               ret =3D hugetlb_vmemmap_split_folio(h, folio);
> >
> >               /*
> > -              * Spliting the PMD requires allocating a page, thus lets=
 fail
> > +              * Splitting the PMD requires allocating a page, thus let=
s fail
>
> lets -> let's or let us

Okay, I will also fix it in the next patch.

>
> >                * early once we encounter the first OOM. No point in ret=
rying
> >                * as it can be dynamically done on remap with the memory
> >                * we get back from the vmemmap deduplication.
> > @@ -715,7 +715,7 @@ static void __hugetlb_vmemmap_optimize_folios(struc=
t hstate *h,
> >               /*
> >                * Pages to be freed may have been accumulated.  If we
> >                * encounter an ENOMEM,  free what we have and try again.
> > -              * This can occur in the case that both spliting fails
> > +              * This can occur in the case that both splitting fails
> >                * halfway and head page allocation also failed. In this
> >                * case __hugetlb_vmemmap_optimize_folio() would free mem=
ory
> >                * allowing more vmemmap remaps to occur.
>
> As Wei says, this patch can be merged with the earlier, thanks.
>
Get it, I will merge this patch to the next one.
Thank you very much for your review!

