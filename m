Return-Path: <linux-kernel+bounces-746460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D524BB126EF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CB84E3D96
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C5723ABAA;
	Fri, 25 Jul 2025 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="geXk94jT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3501DE892
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753482972; cv=none; b=NI2NT3vwNPzIgFUFzbvpeEsX7rp8IwolmoxgT41FCtVlE1oZJzn9h4n3mb+DXbeCHubDIhqDG3Hem0cwNZqHPVn8UWYitXkxlmLUKKEIyFDTy3/jlcDhLC2//+4XEOiDpCtJ5YgrISbHNw4PM13rwaOKuB2m5QiUF8TAsWdejZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753482972; c=relaxed/simple;
	bh=mm+eWX66NCSma7+1pbQITTRUhZ910X1BziV/UlSEaHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAHfixml9ifvFm7qp1zofr28Yxb/8w95mVB8ZSBOAfu4KzA3cyUmhKHQkzH6Wuu9DvuhkteO5BeZVQVJO7lfrPF4DhC+pRriGJZ/us/QubZeJtU6DyrVrN2a4FRGe6EZoLUnt7QNYWI1/8pEHBpO9iil2Hkc6s4U+HBUfXmaYSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=geXk94jT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753482969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9d5B9fr4Nfm+zF43cKINLpDPc+Ji1sf50+7PmWlTvU=;
	b=geXk94jT1qLx3GlMVVZgf/mFvEaT8NrA1HCyUWwLfPcjNBgcU2llOQjeJXpNlAPat6EJa6
	evIIOk3lNgiS8XqszxhShQUzjRN3Ir0gwe+vHKyOPFmO1hm20f9lf6CZyi2KE19qWcZFlA
	Svshf8BOiQw3GoJT9ziRyQaFlnbYXAs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-zIQqbE81OjGIad53_ceEnw-1; Fri, 25 Jul 2025 18:36:07 -0400
X-MC-Unique: zIQqbE81OjGIad53_ceEnw-1
X-Mimecast-MFC-AGG-ID: zIQqbE81OjGIad53_ceEnw_1753482967
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-707cf1b0ecbso42025047b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753482967; x=1754087767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9d5B9fr4Nfm+zF43cKINLpDPc+Ji1sf50+7PmWlTvU=;
        b=s2SxXLY+0Zt0TCMCr5uOrYpkjnFbyGAugly6pyAT1zfKtGkcWDtU9WmmtCm/zR8JHe
         42FwVTKdG1xq5Hlg0scxhRE1UeWHhnFAzz5bIbBqC5tYrBPlDS1o3+fmNcfQZCYcvo0O
         XudEQTGUsC4v8vmVff3+OppJdNbzvWG18Uzf7LsAOWxjKN2jV+DoKjoqMfJ0SQnYimwp
         8L12l9N+BWOLczy4j1790if23C0HR3biVbhtMO/J+9ueqahe7LpBDkuwjrt0Y4qCddMN
         VN2tT0KKt76wx9mhA6f+yvS6XbMORJeWE78VFyK5gGK+YF5r1pqTlzCY7L6mvTRi2RCn
         WgDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Yo8c74myfu48aWo7mqRtDH4P/nRmbfNpOxUYAH+72IMedCf8XV2IE2gJkZwCmxT4ZDjCNN8L3e2tbuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDxU/nthGM+wOhth2mnffMqq+n1AArGLgA+ZpIv9XCqDVdgD39
	vFmK5b23kngCR7v6Vffp+VC903T/bVVkIYjyXPxh4vY/58dtQCB2v0NO6Xr1x8B3k4SYfIuLXbk
	wdd0mh/mA3y+Ah8DMPerYMsPIGQErLMVrpezRS4Gm7YGPhABU07rA93iD0/aMyBr6fWkn87Rqpk
	rBDp2dhkX9OMbenQuyhAHHFlxZqfPI+F2F4nD8QkCD
X-Gm-Gg: ASbGnctWeiXW5lT9LxbzYmgh6SMv9xkzJOHJZt2jKa5BhPKs007vkyaTv7K/5fjOxZb
	irKlsfJyU8BR/6JjOZDAvlV0kLY+lrAD4wsH+YcBjJ//murf4bqNbFjon7THHRyP+IU8itVRaIw
	8gqXOqILzHV79JytKArZVHNoM=
X-Received: by 2002:a05:690c:d90:b0:714:268:a9f8 with SMTP id 00721157ae682-719e341e6a9mr44682377b3.27.1753482966568;
        Fri, 25 Jul 2025 15:36:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpjppnEr5ljWGh9tArrsIJ5IRH6CVauDHUkUdyxGIimReaTFjjdrsPrpmlcjRIbGNsIDizaerPjiiSlgiVQZ4=
X-Received: by 2002:a05:690c:d90:b0:714:268:a9f8 with SMTP id
 00721157ae682-719e341e6a9mr44681987b3.27.1753482965992; Fri, 25 Jul 2025
 15:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-2-npache@redhat.com>
 <02aa93fa-b179-48b9-a319-264be0e027a0@lucifer.local>
In-Reply-To: <02aa93fa-b179-48b9-a319-264be0e027a0@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Fri, 25 Jul 2025 16:35:39 -0600
X-Gm-Features: Ac12FXy8rwzZlL0SK2QdvPBGS9FXasbUCB1K3oRqNSBr9kuXSbYU0DuDKRZp-pg
Message-ID: <CAA1CXcAv=zSRwos-j7VeYuJRXRqUPy3VUZ06HuQ5u+6krG8woA@mail.gmail.com>
Subject: Re: [PATCH v9 01/14] khugepaged: rename hpage_collapse_* to collapse_*
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 10:44=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Hm it seems you missed some places:
Hehe I did notice that after running the git rebase --exec script
David showed me. Already fixed, it will be in the V10!
>
> mm/khugepaged.c: In function =E2=80=98collapse_scan_mm_slot=E2=80=99:
> mm/khugepaged.c:2466:43: error: implicit declaration of function =E2=80=
=98hpage_collapse_scan_file=E2=80=99; did you mean =E2=80=98collapse_scan_f=
ile=E2=80=99? [-Wimplicit-function-declaration]
>  2466 |                                 *result =3D hpage_collapse_scan_f=
ile(mm,
>       |                                           ^~~~~~~~~~~~~~~~~~~~~~~=
~
>       |                                           collapse_scan_file
> mm/khugepaged.c:2471:45: error: implicit declaration of function =E2=80=
=98hpage_collapse_test_exit_or_disable=E2=80=99; did you mean =E2=80=98coll=
apse_test_exit_or_disable=E2=80=99? [-Wimplicit-function-declaration]
>  2471 |                                         if (hpage_collapse_test_e=
xit_or_disable(mm))
>       |                                             ^~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~
>       |                                             collapse_test_exit_or=
_disable
> mm/khugepaged.c:2480:43: error: implicit declaration of function =E2=80=
=98hpage_collapse_scan_pmd=E2=80=99; did you mean =E2=80=98collapse_scan_pm=
d=E2=80=99? [-Wimplicit-function-declaration]
>  2480 |                                 *result =3D hpage_collapse_scan_p=
md(mm, vma,
>       |                                           ^~~~~~~~~~~~~~~~~~~~~~~
>       |                                           collapse_scan_pmd
> mm/khugepaged.c: At top level:
> mm/khugepaged.c:2278:12: error: =E2=80=98collapse_scan_file=E2=80=99 defi=
ned but not used [-Werror=3Dunused-function]
>  2278 | static int collapse_scan_file(struct mm_struct *mm, unsigned long=
 addr,
>       |            ^~~~~~~~~~~~~~~~~~
> mm/khugepaged.c:1271:12: error: =E2=80=98collapse_scan_pmd=E2=80=99 defin=
ed but not used [-Werror=3Dunused-function]
>  1271 | static int collapse_scan_pmd(struct mm_struct *mm,
>       |            ^~~~~~~~~~~~~~~~~
>
> Other than this it LGTM, so once you fix this stuff up you can get a tag =
:)
Awesome Thanks!
>
> On Sun, Jul 13, 2025 at 06:31:54PM -0600, Nico Pache wrote:
> > The hpage_collapse functions describe functions used by madvise_collaps=
e
> > and khugepaged. remove the unnecessary hpage prefix to shorten the
> > function name.
> >
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 46 +++++++++++++++++++++++-----------------------
> >  1 file changed, 23 insertions(+), 23 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index a55fb1dcd224..eb0babb51868 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -402,14 +402,14 @@ void __init khugepaged_destroy(void)
> >       kmem_cache_destroy(mm_slot_cache);
> >  }
> >
> > -static inline int hpage_collapse_test_exit(struct mm_struct *mm)
> > +static inline int collapse_test_exit(struct mm_struct *mm)
> >  {
> >       return atomic_read(&mm->mm_users) =3D=3D 0;
> >  }
> >
> > -static inline int hpage_collapse_test_exit_or_disable(struct mm_struct=
 *mm)
> > +static inline int collapse_test_exit_or_disable(struct mm_struct *mm)
> >  {
> > -     return hpage_collapse_test_exit(mm) ||
> > +     return collapse_test_exit(mm) ||
> >              test_bit(MMF_DISABLE_THP, &mm->flags);
> >  }
> >
> > @@ -444,7 +444,7 @@ void __khugepaged_enter(struct mm_struct *mm)
> >       int wakeup;
> >
> >       /* __khugepaged_exit() must not run from under us */
> > -     VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
> > +     VM_BUG_ON_MM(collapse_test_exit(mm), mm);
> >       if (unlikely(test_and_set_bit(MMF_VM_HUGEPAGE, &mm->flags)))
> >               return;
> >
> > @@ -503,7 +503,7 @@ void __khugepaged_exit(struct mm_struct *mm)
> >       } else if (mm_slot) {
> >               /*
> >                * This is required to serialize against
> > -              * hpage_collapse_test_exit() (which is guaranteed to run
> > +              * collapse_test_exit() (which is guaranteed to run
> >                * under mmap sem read mode). Stop here (after we return =
all
> >                * pagetables will be destroyed) until khugepaged has fin=
ished
> >                * working on the pagetables under the mmap_lock.
> > @@ -838,7 +838,7 @@ struct collapse_control khugepaged_collapse_control=
 =3D {
> >       .is_khugepaged =3D true,
> >  };
> >
> > -static bool hpage_collapse_scan_abort(int nid, struct collapse_control=
 *cc)
> > +static bool collapse_scan_abort(int nid, struct collapse_control *cc)
> >  {
> >       int i;
> >
> > @@ -873,7 +873,7 @@ static inline gfp_t alloc_hugepage_khugepaged_gfpma=
sk(void)
> >  }
> >
> >  #ifdef CONFIG_NUMA
> > -static int hpage_collapse_find_target_node(struct collapse_control *cc=
)
> > +static int collapse_find_target_node(struct collapse_control *cc)
> >  {
> >       int nid, target_node =3D 0, max_value =3D 0;
> >
> > @@ -892,7 +892,7 @@ static int hpage_collapse_find_target_node(struct c=
ollapse_control *cc)
> >       return target_node;
> >  }
> >  #else
> > -static int hpage_collapse_find_target_node(struct collapse_control *cc=
)
> > +static int collapse_find_target_node(struct collapse_control *cc)
> >  {
> >       return 0;
> >  }
> > @@ -912,7 +912,7 @@ static int hugepage_vma_revalidate(struct mm_struct=
 *mm, unsigned long address,
> >       struct vm_area_struct *vma;
> >       unsigned long tva_flags =3D cc->is_khugepaged ? TVA_ENFORCE_SYSFS=
 : 0;
> >
> > -     if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> > +     if (unlikely(collapse_test_exit_or_disable(mm)))
> >               return SCAN_ANY_PROCESS;
> >
> >       *vmap =3D vma =3D find_vma(mm, address);
> > @@ -985,7 +985,7 @@ static int check_pmd_still_valid(struct mm_struct *=
mm,
> >
> >  /*
> >   * Bring missing pages in from swap, to complete THP collapse.
> > - * Only done if hpage_collapse_scan_pmd believes it is worthwhile.
> > + * Only done if khugepaged_scan_pmd believes it is worthwhile.
> >   *
> >   * Called and returns without pte mapped or spinlocks held.
> >   * Returns result: if not SCAN_SUCCEED, mmap_lock has been released.
> > @@ -1071,7 +1071,7 @@ static int alloc_charge_folio(struct folio **foli=
op, struct mm_struct *mm,
> >  {
> >       gfp_t gfp =3D (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpm=
ask() :
> >                    GFP_TRANSHUGE);
> > -     int node =3D hpage_collapse_find_target_node(cc);
> > +     int node =3D collapse_find_target_node(cc);
> >       struct folio *folio;
> >
> >       folio =3D __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nm=
ask);
> > @@ -1257,7 +1257,7 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
> >       return result;
> >  }
> >
> > -static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> > +static int collapse_scan_pmd(struct mm_struct *mm,
> >                                  struct vm_area_struct *vma,
> >                                  unsigned long address, bool *mmap_lock=
ed,
> >                                  struct collapse_control *cc)
> > @@ -1371,7 +1371,7 @@ static int hpage_collapse_scan_pmd(struct mm_stru=
ct *mm,
> >                * hit record.
> >                */
> >               node =3D folio_nid(folio);
> > -             if (hpage_collapse_scan_abort(node, cc)) {
> > +             if (collapse_scan_abort(node, cc)) {
> >                       result =3D SCAN_SCAN_ABORT;
> >                       goto out_unmap;
> >               }
> > @@ -1440,7 +1440,7 @@ static void collect_mm_slot(struct khugepaged_mm_=
slot *mm_slot)
> >
> >       lockdep_assert_held(&khugepaged_mm_lock);
> >
> > -     if (hpage_collapse_test_exit(mm)) {
> > +     if (collapse_test_exit(mm)) {
> >               /* free mm_slot */
> >               hash_del(&slot->hash);
> >               list_del(&slot->mm_node);
> > @@ -1733,7 +1733,7 @@ static void retract_page_tables(struct address_sp=
ace *mapping, pgoff_t pgoff)
> >               if (find_pmd_or_thp_or_none(mm, addr, &pmd) !=3D SCAN_SUC=
CEED)
> >                       continue;
> >
> > -             if (hpage_collapse_test_exit(mm))
> > +             if (collapse_test_exit(mm))
> >                       continue;
> >               /*
> >                * When a vma is registered with uffd-wp, we cannot recyc=
le
> > @@ -2255,7 +2255,7 @@ static int collapse_file(struct mm_struct *mm, un=
signed long addr,
> >       return result;
> >  }
> >
> > -static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned lon=
g addr,
> > +static int collapse_scan_file(struct mm_struct *mm, unsigned long addr=
,
> >                                   struct file *file, pgoff_t start,
> >                                   struct collapse_control *cc)
> >  {
> > @@ -2312,7 +2312,7 @@ static int hpage_collapse_scan_file(struct mm_str=
uct *mm, unsigned long addr,
> >               }
> >
> >               node =3D folio_nid(folio);
> > -             if (hpage_collapse_scan_abort(node, cc)) {
> > +             if (collapse_scan_abort(node, cc)) {
> >                       result =3D SCAN_SCAN_ABORT;
> >                       folio_put(folio);
> >                       break;
> > @@ -2362,7 +2362,7 @@ static int hpage_collapse_scan_file(struct mm_str=
uct *mm, unsigned long addr,
> >       return result;
> >  }
> >
> > -static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *r=
esult,
> > +static unsigned int collapse_scan_mm_slot(unsigned int pages, int *res=
ult,
> >                                           struct collapse_control *cc)
> >       __releases(&khugepaged_mm_lock)
> >       __acquires(&khugepaged_mm_lock)
> > @@ -2400,7 +2400,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned int pages, int *result,
> >               goto breakouterloop_mmap_lock;
> >
> >       progress++;
> > -     if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> > +     if (unlikely(collapse_test_exit_or_disable(mm)))
> >               goto breakouterloop;
> >
> >       vma_iter_init(&vmi, mm, khugepaged_scan.address);
> > @@ -2408,7 +2408,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned int pages, int *result,
> >               unsigned long hstart, hend;
> >
> >               cond_resched();
> > -             if (unlikely(hpage_collapse_test_exit_or_disable(mm))) {
> > +             if (unlikely(collapse_test_exit_or_disable(mm))) {
> >                       progress++;
> >                       break;
> >               }
> > @@ -2430,7 +2430,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned int pages, int *result,
> >                       bool mmap_locked =3D true;
> >
> >                       cond_resched();
> > -                     if (unlikely(hpage_collapse_test_exit_or_disable(=
mm)))
> > +                     if (unlikely(collapse_test_exit_or_disable(mm)))
> >                               goto breakouterloop;
> >
> >                       VM_BUG_ON(khugepaged_scan.address < hstart ||
> > @@ -2490,7 +2490,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned int pages, int *result,
> >        * Release the current mm_slot if this mm is about to die, or
> >        * if we scanned all vmas of this mm.
> >        */
> > -     if (hpage_collapse_test_exit(mm) || !vma) {
> > +     if (collapse_test_exit(mm) || !vma) {
> >               /*
> >                * Make sure that if mm_users is reaching zero while
> >                * khugepaged runs here, khugepaged_exit will find
> > @@ -2544,7 +2544,7 @@ static void khugepaged_do_scan(struct collapse_co=
ntrol *cc)
> >                       pass_through_head++;
> >               if (khugepaged_has_work() &&
> >                   pass_through_head < 2)
> > -                     progress +=3D khugepaged_scan_mm_slot(pages - pro=
gress,
> > +                     progress +=3D collapse_scan_mm_slot(pages - progr=
ess,
> >                                                           &result, cc);
> >               else
> >                       progress =3D pages;
> > --
> > 2.50.0
> >
>


