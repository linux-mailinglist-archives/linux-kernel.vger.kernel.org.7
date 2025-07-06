Return-Path: <linux-kernel+bounces-712287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6493FAF0720
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 02:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBF8482CBC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 00:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F711DDD1;
	Wed,  2 Jul 2025 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxAHdOx/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBA4184
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751414439; cv=none; b=nqXwLEwISfgwkVwMVvjVfamiZv+y5imAbefu92sewuo31Dd4BjoqqTz04wijcidQVF+emVW4KBZ77+m8UIpqu3saDxDuc/uTG0ygJPk0D2sskL05Ncm18q0ykJsSPZxgVauOmE0fuJLQ+pgXJNrdPPlWNHoyQvXsbuXm0b9B7Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751414439; c=relaxed/simple;
	bh=A6RDckIlqByQCUpUXZkrNArh0QHAu81EZDPLYnV0zls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pCjZxOLT5fjmelzLF4YuJ/+SlTkrjxqKvE/T5yePy4bU1o2sr99BhxRr2zXdt7mPmM6f19sGjqePu1vUfBronmdiT0rPVAraJJjrWaAcuM18GpquOIwULu0kzmqxZv+y392Heu6+0n/vbzKHyqpMZlnKhEMBnI3NiWOJYM29eB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hxAHdOx/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751414436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRV/V7cFhUYa8tD8K3MIiuvNW63Wg6JKNzKDRdWMUPk=;
	b=hxAHdOx//ReftFJsr4x9WsAUjgNMaTumOuugcO7vwn802Uk6DV/KIVapRcUOv5WsbBB/65
	/PcJGA3Z8yZJwbrgpfVOfDHNHMk2qWF2hbTBElGUzU3Ijx+gmRV+2D+RlPpSaChLsEOiCA
	ezQJ/PcX7oQBEIZcyh2u2fqU+fDtRWc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-oVxaOxkGPAqRcYcYOZyVhA-1; Tue, 01 Jul 2025 20:00:33 -0400
X-MC-Unique: oVxaOxkGPAqRcYcYOZyVhA-1
X-Mimecast-MFC-AGG-ID: oVxaOxkGPAqRcYcYOZyVhA_1751414433
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7111ff9f2d4so83032267b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 17:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751414432; x=1752019232;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRV/V7cFhUYa8tD8K3MIiuvNW63Wg6JKNzKDRdWMUPk=;
        b=xJTcSDUs+xpfM+js2DiuagYvEWIJT3LMEdQnlyaDvohPZ71N9Pyp70W62E2jV4/u+J
         AMG0JPvM80/1rlaILJpPl8YpHsk1SOgYEFRdC8rUrAFlTPXI8GFFf2R//RCm0zVhvSuT
         xOkWSAtsMu8lhoUgPBsDRUSQO3vOo9fcpDxyZ5xTQwkKOtFVQIuKujqebapCCQZww0aB
         Q3sPfUxZIoYzaftwRmON4MC+YLjZFpUT4GsEBI3J52fFARla5Vye83gek3XMdgOv215y
         gMxt1YDI6iJFvaHTErXVbUAhvKJojOzjt07SEaPomyXhNd0ZaFIpv9bmnk60LvGX36CZ
         8PTg==
X-Forwarded-Encrypted: i=1; AJvYcCUT6GY1GYDBk79BfZIU8cjLwf5Q9dcnP0l6spKIyncThynKXRWaNW3CHL+p+C0/I3q9zDAAXPAOpk0Wec0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw80MtosIYfOttQHpKC6l24xvO+0OKU3j3q8QdL7WJr5F6b84C0
	qMWdA1C+hoI/R6dL0NMUIWw0OvaQXShWEmXNd052Fdwbd8SNJAO11qYD+GyN+r9UjxVIzfolDkv
	eRwYKUFm4Fa23sgfvXtRpVME9Q/pntwlDhC1bEWOXU1FW4t6M3l2ssHTWszpbzYXsSrQ1j7uxXj
	CO3eEUzEDe269uXcuysXm7a9e3IoLHwfOBfiIm+CCW
X-Gm-Gg: ASbGncvjWfhKYX/zTBEDJ95qsjMZgn28/o+4Od4d6R4JoB39JY9IJiKva7AOVp+oQNo
	TB52McN2Dp5ErNiWhFyR3UhvNda9wtX2hitTdyGVJWqEkYifJV01S2rLmQZK9C855aycAMZ9yDC
	Z5Tq4bRA==
X-Received: by 2002:a05:690c:3705:b0:710:e7ad:9d52 with SMTP id 00721157ae682-7164d3f5e16mr8757817b3.14.1751414432472;
        Tue, 01 Jul 2025 17:00:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgMkMqenRVIqOB+9ikiw2xzUobWJPDfSpX1sjEEG6ud3M1WjTpVzhUCF5ZRpdsrBnIkVoZFbtg+0UBjBNvEbE=
X-Received: by 2002:a05:690c:3705:b0:710:e7ad:9d52 with SMTP id
 00721157ae682-7164d3f5e16mr8757197b3.14.1751414431864; Tue, 01 Jul 2025
 17:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515032226.128900-1-npache@redhat.com> <20250515032226.128900-3-npache@redhat.com>
 <db37bakzupqagevhjvngsu7vzcqugp6coy635bvhoy6cdrzk53@mrldbtuep3gk>
In-Reply-To: <db37bakzupqagevhjvngsu7vzcqugp6coy635bvhoy6cdrzk53@mrldbtuep3gk>
From: Nico Pache <npache@redhat.com>
Date: Tue, 1 Jul 2025 18:00:05 -0600
X-Gm-Features: Ac12FXxAB8ippf1H8C0DLIPh7P_mnejfYCanz9QqAu4hJw7WwvZREJy6H5AGBg4
Message-ID: <CAA1CXcCT32ehmoK-8uxjQGzPnxfSFs_UBf+eSaw=++nt4rPj+Q@mail.gmail.com>
Subject: Re: [PATCH v7 02/12] introduce khugepaged_collapse_single_pmd to
 unify khugepaged and madvise_collapse
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com, 
	sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 11:13=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Nico Pache <npache@redhat.com> [250514 23:23]:
> > The khugepaged daemon and madvise_collapse have two different
> > implementations that do almost the same thing.
> >
> > Create khugepaged_collapse_single_pmd to increase code
> > reuse and create an entry point for future khugepaged changes.
> >
> > Refactor madvise_collapse and khugepaged_scan_mm_slot to use
> > the new khugepaged_collapse_single_pmd function.
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 96 +++++++++++++++++++++++++------------------------
> >  1 file changed, 49 insertions(+), 47 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 806bcd8c5185..5457571d505a 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2353,6 +2353,48 @@ static int khugepaged_scan_file(struct mm_struct=
 *mm, unsigned long addr,
> >       return result;
> >  }
> >
> > +/*
> > + * Try to collapse a single PMD starting at a PMD aligned addr, and re=
turn
> > + * the results.
> > + */
> > +static int khugepaged_collapse_single_pmd(unsigned long addr,
> > +                                struct vm_area_struct *vma, bool *mmap=
_locked,
> > +                                struct collapse_control *cc)
> > +{
> > +     int result =3D SCAN_FAIL;
> > +     struct mm_struct *mm =3D vma->vm_mm;
> > +
> > +     if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {
>
> why IS_ENABLED(CONFIG_SHMEM) here, it seems new?
Fixed in the next version. It was a mishandled rebase conflict.
>
> > +             struct file *file =3D get_file(vma->vm_file);
> > +             pgoff_t pgoff =3D linear_page_index(vma, addr);
> > +
> > +             mmap_read_unlock(mm);
> > +             *mmap_locked =3D false;
> > +             result =3D khugepaged_scan_file(mm, addr, file, pgoff, cc=
);
> > +             fput(file);
> > +             if (result =3D=3D SCAN_PTE_MAPPED_HUGEPAGE) {
> > +                     mmap_read_lock(mm);
> > +                     *mmap_locked =3D true;
> > +                     if (khugepaged_test_exit_or_disable(mm)) {
> > +                             result =3D SCAN_ANY_PROCESS;
> > +                             goto end;
> > +                     }
> > +                     result =3D collapse_pte_mapped_thp(mm, addr,
> > +                                                      !cc->is_khugepag=
ed);
> > +                     if (result =3D=3D SCAN_PMD_MAPPED)
> > +                             result =3D SCAN_SUCCEED;
> > +                     mmap_read_unlock(mm);
> > +                     *mmap_locked =3D false;
> > +             }
> > +     } else {
> > +             result =3D khugepaged_scan_pmd(mm, vma, addr, mmap_locked=
, cc);
> > +     }
> > +     if (cc->is_khugepaged && result =3D=3D SCAN_SUCCEED)
> > +             ++khugepaged_pages_collapsed;
> > +end:
> > +     return result;
>
> This function can return with mmap_read_locked or unlocked..
>
> > +}
> > +
> >  static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *r=
esult,
> >                                           struct collapse_control *cc)
> >       __releases(&khugepaged_mm_lock)
> > @@ -2427,34 +2469,12 @@ static unsigned int khugepaged_scan_mm_slot(uns=
igned int pages, int *result,
> >                       VM_BUG_ON(khugepaged_scan.address < hstart ||
> >                                 khugepaged_scan.address + HPAGE_PMD_SIZ=
E >
> >                                 hend);
> > -                     if (!vma_is_anonymous(vma)) {
> > -                             struct file *file =3D get_file(vma->vm_fi=
le);
> > -                             pgoff_t pgoff =3D linear_page_index(vma,
> > -                                             khugepaged_scan.address);
> > -
> > -                             mmap_read_unlock(mm);
> > -                             mmap_locked =3D false;
> > -                             *result =3D hpage_collapse_scan_file(mm,
> > -                                     khugepaged_scan.address, file, pg=
off, cc);
> > -                             fput(file);
> > -                             if (*result =3D=3D SCAN_PTE_MAPPED_HUGEPA=
GE) {
> > -                                     mmap_read_lock(mm);
> > -                                     if (hpage_collapse_test_exit_or_d=
isable(mm))
> > -                                             goto breakouterloop;
> > -                                     *result =3D collapse_pte_mapped_t=
hp(mm,
> > -                                             khugepaged_scan.address, =
false);
> > -                                     if (*result =3D=3D SCAN_PMD_MAPPE=
D)
> > -                                             *result =3D SCAN_SUCCEED;
> > -                                     mmap_read_unlock(mm);
> > -                             }
> > -                     } else {
> > -                             *result =3D hpage_collapse_scan_pmd(mm, v=
ma,
> > -                                     khugepaged_scan.address, &mmap_lo=
cked, cc);
> > -                     }
> > -
> > -                     if (*result =3D=3D SCAN_SUCCEED)
> > -                             ++khugepaged_pages_collapsed;
> >
> > +                     *ngle_pmd(khugepaged_scan.address,
> > +                                             vma, &mmap_locked, cc);
> > +                     /* If we return SCAN_ANY_PROCESS we are holding t=
he mmap_lock */
>
> But this comment makes it obvious that you know that..
>
> > +                     if (*result =3D=3D SCAN_ANY_PROCESS)
> > +                             goto breakouterloop;
>
> But later..
>
> breakouterloop:
>         mmap_read_unlock(mm); /* exit_mmap will destroy ptes after this *=
/
> breakouterloop_mmap_lock:
>
>
> So if you return with SCAN_ANY_PROCESS, we are holding the lock and go
> immediately and drop it.  This seems unnecessarily complicated and
> involves a lock.
SCAN_ANY_PROCESS indicates that the process we are working on has
either exited, or THPs have been disabled mid-scan. So we have to drop
the lock regardless.
>
> That would leave just the khugepaged_scan_pmd() path with the
> unfortunate locking mess - which is a static function and called in one
> location..
>
> Looking at what happens after the return seems to indicate we could
> clean that up as well, sometime later.
I see your point, all other instances handle the unlock within their
own function and this one should too. instead of handling the unlock
in the parent function I should just return with it unlocked and have
the already established if(!mmap_locked) do the cleanup.
>
> >                       /* move to next address */
> >                       khugepaged_scan.address +=3D HPAGE_PMD_SIZE;
> >                       progress +=3D HPAGE_PMD_NR;
> > @@ -2773,36 +2793,18 @@ int madvise_collapse(struct vm_area_struct *vma=
, struct vm_area_struct **prev,
> >               mmap_assert_locked(mm);
> >               memset(cc->node_load, 0, sizeof(cc->node_load));
> >               nodes_clear(cc->alloc_nmask);
> > -             if (!vma_is_anonymous(vma)) {
> > -                     struct file *file =3D get_file(vma->vm_file);
> > -                     pgoff_t pgoff =3D linear_page_index(vma, addr);
> >
> > -                     mmap_read_unlock(mm);
> > -                     mmap_locked =3D false;
> > -                     result =3D hpage_collapse_scan_file(mm, addr, fil=
e, pgoff,
> > -                                                       cc);
> > -                     fput(file);
> > -             } else {
> > -                     result =3D hpage_collapse_scan_pmd(mm, vma, addr,
> > -                                                      &mmap_locked, cc=
);
> > -             }
> > +             result =3D khugepaged_collapse_single_pmd(addr, vma, &mma=
p_locked, cc);
> > +
> >               if (!mmap_locked)
> >                       *prev =3D NULL;  /* Tell caller we dropped mmap_l=
ock */
> >
> > -handle_result:
> >               switch (result) {
> >               case SCAN_SUCCEED:
> >               case SCAN_PMD_MAPPED:
> >                       ++thps;
> >                       break;
> >               case SCAN_PTE_MAPPED_HUGEPAGE:
> > -                     BUG_ON(mmap_locked);
> > -                     BUG_ON(*prev);
> > -                     mmap_read_lock(mm);
> > -                     result =3D collapse_pte_mapped_thp(mm, addr, true=
);
> > -                     mmap_read_unlock(mm);
> > -                     goto handle_result;
>
> All of the above should probably be replaced with a BUG_ON(1) since it's
> not expected now?  Or at least WARN_ON_ONCE(), but it should be safe to
> continue if that's the case.
I dont think we should warn as this is the return value for indicating
that we are trying to collapse to a mTHP that is smaller than the
already established folio (see __collapse_huge_page_isolate), but
continuing should be ok.
>
> It looks like the mmap_locked boolean is used to ensure that *prev is
> safe, but we are now dropping the lock and re-acquiring it (and
> potentially returning here) with it set to true, so perv will not be set
> to NULL like it should.
Luckily Lorenzo just cleaned this up with the madvise code changes he
made, but yes you are correct.
>
> I think you can handle this by ensuring that
> khugepaged_collapse_single_pmd() returns with mmap_locked false in the
> SCAN_ANY_PROCESS case.
>
> > -             /* Whitelisted set of results where continuing OK */
>
> This seems worth keeping?
I'll add that back, thanks.
>
> >               case SCAN_PMD_NULL:
> >               case SCAN_PTE_NON_PRESENT:
> >               case SCAN_PTE_UFFD_WP:
>
> I guess SCAN_ANY_PROCESS should be handled by the default case
> statement?  It should probably be added to the switch?
I believe it should be handled by the default case, since we dont want
to continue, so we break out as intended.
>
> That is to say, before your change the result would come from either
> hpage_collapse_scan_file(), then lead to collapse_pte_mapped_thp()
> above.
In the khugepaged case we do the following check
(khugepaged_test_exit_or_disable) before calling pte_mapped_thp, but
we weren't doing it in the madvise_collapse case. seems like we had a
bug lingering or unnecessary code in the original implementation (its
been that way since day 1). I can note the slight difference in the
commit log. I believe having the same check for both is wise, although
now I have to ask why we arent using the revalidate function like all
other callers do when they drop the lock. I will note this small
difference in the commit log, and will invest some time in the future
into cleaning up this madness. I think unifying these two callers into
one, as I'm trying to do here, will make these behavioral deviations
harder in the future, and we can have sanity knowing there is *mostly*
one way to call the collapse.
>
> Now, you can have khugepaged_test_exit_or_disable() happen to return
> SCAN_ANY_PROCESS and it will fall through to the default in this switch
> statement, which seems like new behaviour?
>
> At the very least, this information should be added to the git log on
> what this patch does - if it's expected?
Will do, thanks for the thought provoking review, I had to do some
digging to verify this one :)

-- Nico
>
> Thanks,
> Liam
>


