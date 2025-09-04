Return-Path: <linux-kernel+bounces-801270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A83E0B442E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E625A10AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEA71DE2C2;
	Thu,  4 Sep 2025 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qiRi0YHa"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6CD23507B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003685; cv=none; b=BDuO9dxZlwM817FlO68qXoABGmvdqJxWItdx6xVZw0zZIB1DWJYJZ7sdb03PcCEbiU3j1amY6iit1JqFo2mp1ywBzQ7KGgehZO6TWELGIeY3NriOB7rsNFjv1Ub9r/4f9YXLm1Bkkc1rI2RAMWmUHJx2neVikOSxPeHSSOWdtuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003685; c=relaxed/simple;
	bh=MtZYe6JG3XpxIXqk/NA0mU3LiZ2DVqocc06ddILhg4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J++5Yrf0aFUckRCyfFD9GK9rHbTeALm5LYqH0EmazK6vk3x4MgVfqH1Sxf/Sgm/3/FRbh6fVtL/qyw6sUVrrFmq7hSDuY2NVpdShZDEaGLeFsCzzMVp+7mcI8mn4n2yVn9Yt0WibRXoWhh/85kDtnrp5NflTjZVqxT5PT3kTYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qiRi0YHa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24cca557085so175835ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757003683; x=1757608483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIphyer/v3DPFwcbM/1VaFFLYbcPkwf7pTaOPXgyjPs=;
        b=qiRi0YHaCpiwk3L5p9UrvauE7aJKlr8kxVX7XPh3wgOx4Ty+nF+wN7Dd8PXivSLYZ2
         sn+uwc8wJkJ170Vpc/piLxQQMNuFpX7WqaDnt33zC8GXjkc/kokTtktwQUEFJPtAb04H
         ED0gMZkEDWyjXqNPmHHt2QlhgNF9CB4t7laJEglCRyhArDm9EGd+vUnrNJLRdzb0A5rs
         HSB8+EWvILiYvMUHXWzqMApEljWTzzYhnGxZdCg6bJ6TGSseyFrnX/1Ngz3jTxLlX+1S
         +brba2ag0NzrP+ODcVLUiIRCUz60au2LJC9CFx6C+CWjncgEGnpx1zG+lpkOdf6C8oQB
         a1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003683; x=1757608483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZIphyer/v3DPFwcbM/1VaFFLYbcPkwf7pTaOPXgyjPs=;
        b=OoOGWGLqK9KMu1LQkPUK7xVqKQJwgJo7PD5kocoW+ESw9F9W3qGnqKejPcDpO/9shV
         t4Ro1alh1Cg11jttA9NqcgYomZJHhvfsCluh2eCi22gqMr76bKBFSw2PJRswWTt2N5Ks
         ti2BTGpPx6WsyBVW5VKRw2GzltZu3p5/4q4QLDxHYwMcJTPGKpbmI7qu7iwUwQDsBcmH
         X7/YPatBoXhOwXQLFjiYUKOgqcwt0YTdLh2+9w/pUCps6T4FN3c2XaicFy3ZqCJtJOMA
         squKB64+0n9KqwXGcWexsIg3E5Mjh4X5YPilHLafTAt6xAsEkK33B+YSu7/r0wUzm6Nd
         gdTw==
X-Forwarded-Encrypted: i=1; AJvYcCXKJk0VQr9jXcOfFafU7Ssv+PI9Q4mmycROEOi51G0kOyuMq5mx+rdzAmajD4QRl0YTz8oVqlv5h/Y9BAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAAGsAJcP9OIlyOiGDVWGJUVQofxPGTKec496O78AWKt53mQ9w
	8gxy9Y1XUuN+pcByoSoP2r4UMcDTQ3Z/cYVv/dyuqtyUIIAkyDkp+dcEiNEm9RhMBNLNMnNqGvx
	lVVRVyZEcpDMJcWJjXAI6o33y5bCDUWPKHOLG5jls
X-Gm-Gg: ASbGncvCPMnV27CmiuV8PhB5GxnpNP/j7DVxYwBsCMF9cPNngVyKZxC89x+GS9X48Wl
	OJWmmnqscFXYQ8628JeFAtK50Xu+zA9kFUqaFJ6u0O+JsOdfzHLXpNdP6uZ+FZ81H2J6MuT//k7
	NXFvmnvpnIbbWDekiY8U2xiDkSnjDhfeMM2HGqFsrhQTwdE3nVW1tJm1Irwvf/9n3I2RyChCQM9
	IARIU+IJx67bk9iX8imr2Kr5eFEbnG3NdvRJDyneymj
X-Google-Smtp-Source: AGHT+IFSPuUUCV+cBM50sI3Z+1DFuftHs12TO1fvAlwdozBMKG95tjjnen/h1oMKUTo1sitW0F5Uu9n6CiEUtIOosmY=
X-Received: by 2002:a17:902:ea01:b0:231:f6bc:5c84 with SMTP id
 d9443c01a7336-24ccaf6e116mr3651605ad.8.1757003683119; Thu, 04 Sep 2025
 09:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903232437.1454293-1-kaleshsingh@google.com> <827c844f-7106-4f62-a108-1f83544aa56e@lucifer.local>
In-Reply-To: <827c844f-7106-4f62-a108-1f83544aa56e@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 4 Sep 2025 09:34:31 -0700
X-Gm-Features: Ac12FXyZ35C2YiXL_Ds3Xt1Dj85unZqP3Rp-ROvVkOK_JLyiLa944HgsyNtXqH4
Message-ID: <CAC_TJvfCRkDt-4BwffD_QN9hhuUz78N51ztwqcfDmA=wJjm_Zw@mail.gmail.com>
Subject: Re: [PATCH] mm: centralize and fix max map count limit checking
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, kernel-team@android.com, 
	android-mm@google.com, David Hildenbrand <david@redhat.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 9:03=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Sep 03, 2025 at 04:24:35PM -0700, Kalesh Singh wrote:
> > The check against the max map count (sysctl_max_map_count) was
> > open-coded in several places. This led to inconsistent enforcement
> > and subtle bugs where the limit could be exceeded.
> >
> > For example, some paths would check map_count > sysctl_max_map_count
> > before allocating a new VMA and incrementing the count, allowing the
> > process to reach sysctl_max_map_count + 1:
> >
> >     int do_brk_flags(...)
> >     {
> >         if (mm->map_count > sysctl_max_map_count)
> >             return -ENOMEM;
> >
> >         /* We can get here with mm->map_count =3D=3D sysctl_max_map_cou=
nt */
> >
> >         vma =3D vm_area_alloc(mm);
> >         ...
> >         mm->map_count++   /* We've now exceeded the threshold. */
> >     }
> >
> > To fix this and unify the logic, introduce a new function,
> > exceeds_max_map_count(), to consolidate the check. All open-coded
> > checks are replaced with calls to this new function, ensuring the
> > limit is applied uniformly and correctly.
> >
> > To improve encapsulation, sysctl_max_map_count is now static to
> > mm/mmap.c. The new helper also adds a rate-limited warning to make
> > debugging applications that exhaust their VMA limit easier.
> >
>
> Yeah this is nice thanks!
>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  include/linux/mm.h | 11 ++++++++++-
> >  mm/mmap.c          | 15 ++++++++++++++-
> >  mm/mremap.c        |  7 ++++---
> >  mm/nommu.c         |  2 +-
> >  mm/util.c          |  1 -
> >  mm/vma.c           |  6 +++---
> >  6 files changed, 32 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 1ae97a0b8ec7..d4e64e6a9814 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -192,7 +192,16 @@ static inline void __mm_zero_struct_page(struct pa=
ge *page)
> >  #define MAPCOUNT_ELF_CORE_MARGIN     (5)
> >  #define DEFAULT_MAX_MAP_COUNT        (USHRT_MAX - MAPCOUNT_ELF_CORE_MA=
RGIN)
> >
> > -extern int sysctl_max_map_count;
> > +/**
> > + * exceeds_max_map_count - check if a VMA operation would exceed max_m=
ap_count
> > + * @mm: The memory descriptor for the process.
> > + * @new_vmas: The number of new VMAs the operation will create.
> > + *
> > + * Returns true if the operation would cause the number of VMAs to exc=
eed
> > + * the sysctl_max_map_count limit, false otherwise. A rate-limited war=
ning
> > + * is logged if the limit is exceeded.
> > + */
> > +extern bool exceeds_max_map_count(struct mm_struct *mm, unsigned int n=
ew_vmas);
>
> No new externs please (as Pedro also pointed out! :)
>
> >
> >  extern unsigned long sysctl_user_reserve_kbytes;
> >  extern unsigned long sysctl_admin_reserve_kbytes;
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 7306253cc3b5..693a0105e6a5 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned l=
ong addr,
> >               return -EOVERFLOW;
> >
> >       /* Too many mappings? */
> > -     if (mm->map_count > sysctl_max_map_count)
> > +     if (exceeds_max_map_count(mm, 0))
>
> Yeah this last 'mystery meat' parameter isn't amazing though to be honest=
, it's
> kinda hard to read/understand.
>
> E.g.:
>
> int map_count_capacity(const struct *mm)
> {
>         const int map_count =3D mm->map_count;
>         const int max_count =3D sysctl_max_map_count;
>
>         return max_count > map_count ? max_count - map_count : 0;
> }
>
> Then this would become;
>
>         if (!map_count_capacity(mm)) {
>                 // blah.
>         }
>

Hi Lorenzo,

I agree your suggestion is a lot clearer and readable. Thanks for the
suggestion :)  Let me update that in the next revision.

--Kalesh

>
> >               return -ENOMEM;
> >
> >       /*
> > @@ -1504,6 +1504,19 @@ struct vm_area_struct *_install_special_mapping(
> >  int sysctl_legacy_va_layout;
> >  #endif
> >
> > +static int sysctl_max_map_count __read_mostly =3D DEFAULT_MAX_MAP_COUN=
T;
> > +
> > +bool exceeds_max_map_count(struct mm_struct *mm, unsigned int new_vmas=
)
> > +{
> > +     if (unlikely(mm->map_count + new_vmas > sysctl_max_map_count)) {
> > +             pr_warn_ratelimited("%s (%d): Map count limit %u exceeded=
\n",
> > +                                 current->comm, current->pid,
> > +                                 sysctl_max_map_count);
>
> Yeah not a fan of this, we aren't warning elsewhere, it's actually perfec=
tly
> normal for somebody to exceed this, this isn't at the level of a warning.
>
> > +             return true;
> > +     }
> > +     return false;
> > +}
> > +
> >  static const struct ctl_table mmap_table[] =3D {
> >               {
> >                               .procname       =3D "max_map_count",
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index e618a706aff5..793fad58302c 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -1040,7 +1040,7 @@ static unsigned long prep_move_vma(struct vma_rem=
ap_struct *vrm)
> >        * We'd prefer to avoid failure later on in do_munmap:
> >        * which may split one vma into three before unmapping.
> >        */
> > -     if (current->mm->map_count >=3D sysctl_max_map_count - 3)
> > +     if (exceeds_max_map_count(current->mm, 4))
> >               return -ENOMEM;
>
> In my version this would be:
>
>         if (map_count_capacity(current->mm) < 4)
>                 return -ENOMEM;
>
> And etc. etc. I won't do them all :)
>
> I do think this is clearer...
>
> >
> >       if (vma->vm_ops && vma->vm_ops->may_split) {
> > @@ -1811,9 +1811,10 @@ static unsigned long check_mremap_params(struct =
vma_remap_struct *vrm)
> >        * split in 3 before unmapping it.
> >        * That means 2 more maps (1 for each) to the ones we already hol=
d.
> >        * Check whether current map count plus 2 still leads us to 4 map=
s below
> > -      * the threshold, otherwise return -ENOMEM here to be more safe.
> > +      * the threshold. In other words, is the current map count + 6 at=
 or
> > +      * below the threshold? Otherwise return -ENOMEM here to be more =
safe.
> >        */
> > -     if ((current->mm->map_count + 2) >=3D sysctl_max_map_count - 3)
> > +     if (exceeds_max_map_count(current->mm, 6))
> >               return -ENOMEM;
> >
> >       return 0;
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index 8b819fafd57b..0533e1e3b266 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -1316,7 +1316,7 @@ static int split_vma(struct vma_iterator *vmi, st=
ruct vm_area_struct *vma,
> >               return -ENOMEM;
> >
> >       mm =3D vma->vm_mm;
> > -     if (mm->map_count >=3D sysctl_max_map_count)
> > +     if (exceeds_max_map_count(mm, 1))
> >               return -ENOMEM;
> >
> >       region =3D kmem_cache_alloc(vm_region_jar, GFP_KERNEL);
> > diff --git a/mm/util.c b/mm/util.c
> > index f814e6a59ab1..b6e83922cafe 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -751,7 +751,6 @@ EXPORT_SYMBOL(folio_mc_copy);
> >  int sysctl_overcommit_memory __read_mostly =3D OVERCOMMIT_GUESS;
> >  static int sysctl_overcommit_ratio __read_mostly =3D 50;
> >  static unsigned long sysctl_overcommit_kbytes __read_mostly;
> > -int sysctl_max_map_count __read_mostly =3D DEFAULT_MAX_MAP_COUNT;
> >  unsigned long sysctl_user_reserve_kbytes __read_mostly =3D 1UL << 17; =
/* 128MB */
> >  unsigned long sysctl_admin_reserve_kbytes __read_mostly =3D 1UL << 13;=
 /* 8MB */
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 3b12c7579831..f804c8ac8fbb 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -592,7 +592,7 @@ __split_vma(struct vma_iterator *vmi, struct vm_are=
a_struct *vma,
> >  static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
> >                    unsigned long addr, int new_below)
> >  {
> > -     if (vma->vm_mm->map_count >=3D sysctl_max_map_count)
> > +     if (exceeds_max_map_count(vma->vm_mm, 1))
> >               return -ENOMEM;
> >
> >       return __split_vma(vmi, vma, addr, new_below);
> > @@ -1345,7 +1345,7 @@ static int vms_gather_munmap_vmas(struct vma_munm=
ap_struct *vms,
> >                * its limit temporarily, to help free resources as expec=
ted.
> >                */
> >               if (vms->end < vms->vma->vm_end &&
> > -                 vms->vma->vm_mm->map_count >=3D sysctl_max_map_count)=
 {
> > +                 exceeds_max_map_count(vms->vma->vm_mm, 1)) {
> >                       error =3D -ENOMEM;
> >                       goto map_count_exceeded;
> >               }
> > @@ -2772,7 +2772,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
> >       if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
> >               return -ENOMEM;
> >
> > -     if (mm->map_count > sysctl_max_map_count)
> > +     if (exceeds_max_map_count(mm, 1))
> >               return -ENOMEM;
> >
> >       if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
> > --
> > 2.51.0.338.gd7d06c2dae-goog
> >

