Return-Path: <linux-kernel+bounces-823219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A65B85CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12E4B4E181C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A16314D26;
	Thu, 18 Sep 2025 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0yEosCVg"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4042314B74
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210745; cv=none; b=NIPSxT0xMbq1s7pPvx1Zy3F4H2I+yQTwDvO99RzEuE+zFLQiu5GaWvIA9ZiYYcGDMoBK1q+Ga+8Cf3JQjHg7K5iQXP43tfLkdaY8B55AwLWDWHwf6CC7+3dWSUVfE4qFaXFlo4iwxBnEBfwYtz0sXmzL1asiqeW0ywyfci4F1So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210745; c=relaxed/simple;
	bh=Ud54sEzOPOEQniND4BIvZWYUoMracwMdxoBkbDo/uhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oK0QMYDIf/D3VVHTnUW/qnRAtV/bF2t6VcM0RmCPBQGnEwkCztTipp8IC0hOqb5RyXuKYgjXC5xzXjf6jwoNOoJRH03uL51cpQqzWCT8VvsFTUMk1jBfnzTvdwx0c91aacbBlNEsqz6RHozO/Z8h2tgXo5aOg1RxHkOuS9HMh/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0yEosCVg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-267c90c426dso246965ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210743; x=1758815543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWongCm8ZAf/azaHq+fEhrlTCA5Ds592xK8AQ0EqpNs=;
        b=0yEosCVgR7fs8TTTeYgfp70PoU07fvQkS5FIOOeziHRgj7qUYMG+Ghz0u4r7Db+uf9
         ssTefu3OYqWsOUsT6M3/yJ42O6nP71DumUu770S/WeVbR3ORbkLJvD6VV/tGOzxDZLKW
         1PxnxSMAeOVWQTlvmsnF78aNdq4gbeIQVuiFqFcdA/GS8yrwx2eOq4xDrY7Uy+qKSdYo
         54tG6a0PHH+irqhE7mNlIYYYyYY+qX26uSt9AVvPnYdIwv/JB+D4Lq5bpiNIkIDtO2K9
         dWSzKnvQrTtjmB5ZGio2AiaO6bdrq/2L2dmzLUfr1zWwJyzU4NoQsArX642rOwDhIr1t
         E90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210743; x=1758815543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWongCm8ZAf/azaHq+fEhrlTCA5Ds592xK8AQ0EqpNs=;
        b=S5gbcs2TRSokvrKEp1UaTBULypEPc5cJHq5pyoNLAkLDYo3MbBGg5TffNGm6dRbQYT
         6cM+tHfhwSgV9ucAd6u18LAJ0myatnXyw+kmI5UHxPkgo7YgBntl1PgCnrOEC0g0jUZQ
         t8SNCwFyrgpozu7+bYshB39MO8zqVZ5u89n7Xs8Qa5trEKz5jd+JF2Q7NDuy9DbCpiRX
         Fk024RRWGnxMn2Bu9S60ctbxfBAPgVjzFq+PJU/DORSZBKG2VfZZyVn4XPmfIh1WQ16x
         aURzASmw3fEDwGHKrUblsPf9ijUrFKtTq39rAcQLZCDQyr3OonEzpOeJz6WFADdR3TpR
         j54A==
X-Forwarded-Encrypted: i=1; AJvYcCUHt6GePmG7roxRPEKur6NdhtmUHeqazL7xS+PpvXfVu8sSGRPhr6bNxCtx8BMxO+Z7yipMSvC8xW9Cv0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsN6xZs6q7GLDMCrs2lVHtGOw+ES7rjxIEGrPef/DLutC7UaHQ
	ohE7TgWXBT1qnsJAfMczCsvtpHWBIbWa0vP2jThvBlGaESHQukIHzqL0evMPlaRoqZxxOGIB6fu
	Ld/yL3Rfi8MjpvPPnz6UCNryTSmPtVhbKfShHqQtI
X-Gm-Gg: ASbGncv3F/VSmuuygeSDP677PFBtMpnN9oKDUmjK/rY2v8/17CDQ2s7XlFIp4IUq4Wh
	ZVjQhk2KlPV7GcIwIssAX6ddVFYme3Gm3XONWAsAVg6mzmY5XSHCO9RRnEKsEWnSxv8lsF+uJkg
	/zKKpZRDJ6oALV23FIcXrMAfRtU9eKyEbhY1qNIYax5rn9wSNZIG/lHbdamkhtcDb91hgxQGbik
	7Wx6U95xrPqEmFL41j24opuhP5Wy4wNQe0IpvQUmVGN6jgxMAkJl+uqkcuMrgs=
X-Google-Smtp-Source: AGHT+IE1dVZDfdIlS5aJU2haj2U7eoaUKE7vXw1xNvbtSsJwxP5QUmxJfKZ0gNezoUJQtND9zTo/Z6GLyTbHTFmE7nk=
X-Received: by 2002:a17:902:e5cb:b0:248:7b22:dfb4 with SMTP id
 d9443c01a7336-26801092aefmr9948975ad.16.1758210742695; Thu, 18 Sep 2025
 08:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-4-kaleshsingh@google.com> <bed862a2-60a8-466e-ab71-b1c009bc4e5b@lucifer.local>
In-Reply-To: <bed862a2-60a8-466e-ab71-b1c009bc4e5b@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 18 Sep 2025 08:52:11 -0700
X-Gm-Features: AS18NWB8tF0mUJ-ghoyohYGZ4lY14lQJBa_1Pd4HDuYcKkBQgWDOcSdxyZA-oBk
Message-ID: <CAC_TJvcYERvsRx+PfvgdRxOJAZPxvN+tyc-sHe4h_ZU-iH50Kg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] mm: introduce vma_count_remaining()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, david@redhat.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 7:32=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Sep 15, 2025 at 09:36:34AM -0700, Kalesh Singh wrote:
> > The checks against sysctl_max_map_count are open-coded in multiple
> > places. While simple checks are manageable, the logic in places like
> > mremap.c involves arithmetic with magic numbers that can be difficult
> > to reason about. e.g. ... >=3D sysctl_max_map_count - 3
> >
> > To improve readability and centralize the logic, introduce a new helper=
,
> > vma_count_remaining(). This function returns the VMA count headroom
> > available for a givine process.
> >
> > The most common case of checking for a single new VMA can be done with
> > the convenience helper has_vma_count_remaining():
> >
> >     if (!vma_count_remaining(mm))
> >
> > And the complex checks in mremap.c become clearer by expressing the
> > required capacity directly:
> >
> >     if (vma_count_remaining(mm) <  4)
>
> Double space after 4.

Will fix in the resend.

>
> >
> > While a capacity-based function could be misused (e.g., with an
> > incorrect '<' vs '<=3D' comparison), the improved readability at the ca=
ll
> > sites makes such errors less likely than with the previous open-coded
> > arithmetic.
> >
> > As part of this change, sysctl_max_map_count is made static to
> > mm/mmap.c to improve encapsulation.
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Pedro Falcato <pfalcato@suse.de>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
>
> Generally logic looks ok, with various stuff fixed below + in commit msg =
we
> should be good to go :)
>
> > ---
> >
> > Changes in v2:
> >   - Fix documentation comment for vma_count_remaining(), per Mike
> >   - Remove extern in header, per Mike and Pedro
> >   - Move declaration to mm/internal.h, per Mike
> >   - Replace exceeds_max_map_count() with capacity-based vma_count_remai=
ning(),
> >        per Lorenzo.
> >   - Fix tools/testing/vma, per Lorenzo.
> >
> >  include/linux/mm.h               |  2 --
> >  mm/internal.h                    |  2 ++
> >  mm/mmap.c                        | 21 ++++++++++++++++++++-
> >  mm/mremap.c                      |  7 ++++---
> >  mm/nommu.c                       |  2 +-
> >  mm/util.c                        |  1 -
> >  mm/vma.c                         | 10 +++++-----
> >  tools/testing/vma/vma_internal.h |  9 +++++++++
> >  8 files changed, 41 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 1ae97a0b8ec7..138bab2988f8 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -192,8 +192,6 @@ static inline void __mm_zero_struct_page(struct pag=
e *page)
> >  #define MAPCOUNT_ELF_CORE_MARGIN     (5)
> >  #define DEFAULT_MAX_MAP_COUNT        (USHRT_MAX - MAPCOUNT_ELF_CORE_MA=
RGIN)
> >
> > -extern int sysctl_max_map_count;
> > -
>
> Nice to get rid of this as a global! :)
>
> >  extern unsigned long sysctl_user_reserve_kbytes;
> >  extern unsigned long sysctl_admin_reserve_kbytes;
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 45b725c3dc03..39f1c9535ae5 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1661,4 +1661,6 @@ static inline bool reclaim_pt_is_enabled(unsigned=
 long start, unsigned long end,
> >  void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
> >  int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
> >
> > +int vma_count_remaining(const struct mm_struct *mm);
> > +
> >  #endif       /* __MM_INTERNAL_H */
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index e5370e7fcd8f..af88ce1fbb5f 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned l=
ong addr,
> >               return -EOVERFLOW;
> >
> >       /* Too many mappings? */
> > -     if (mm->map_count >=3D sysctl_max_map_count)
> > +     if (!vma_count_remaining(mm))
> >               return -ENOMEM;
> >
> >       /*
> > @@ -1504,6 +1504,25 @@ struct vm_area_struct *_install_special_mapping(
> >  int sysctl_legacy_va_layout;
> >  #endif
> >
> > +static int sysctl_max_map_count __read_mostly =3D DEFAULT_MAX_MAP_COUN=
T;
> > +
> > +/**
> > + * vma_count_remaining - Determine available VMA slots
> > + * @mm: The memory descriptor for the process.
> > + *
> > + * Check how many more VMAs can be created for the given @mm
> > + * before hitting the sysctl_max_map_count limit.
> > + *
> > + * Return: The number of new VMAs the process can accommodate.
> > + */
> > +int vma_count_remaining(const struct mm_struct *mm)
> > +{
> > +     const int map_count =3D mm->map_count;
> > +     const int max_count =3D sysctl_max_map_count;
>
> David already commented on the READ_ONCE() here, seems wise.
>
> > +
> > +     return (max_count > map_count) ? (max_count - map_count) : 0;
>
> Not a big deal but would prefer:
>
>         if (map_count >=3D map_count)
>                 return 0;
>
>         return max_count - map_count;
>
> As the ternary here is a bit less clear, and it puts the 'failure' case f=
irst
> and the 'success' case afterwards.
>
> > +}
> > +
>
> As discussed in reply to the kernel bot, you've accidentally placed this =
in a
> CONFIG_SYSCTL block, so need to move it :>)

Yeah I unintentionally placed it there, I've moved this out in a newer
version. Thanks.

>
> >  static const struct ctl_table mmap_table[] =3D {
> >               {
> >                               .procname       =3D "max_map_count",
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 35de0a7b910e..14d35d87e89b 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -1040,7 +1040,7 @@ static unsigned long prep_move_vma(struct vma_rem=
ap_struct *vrm)
> >        * We'd prefer to avoid failure later on in do_munmap:
> >        * which may split one vma into three before unmapping.
> >        */
> > -     if (current->mm->map_count >=3D sysctl_max_map_count - 3)
> > +     if (vma_count_remaining(current->mm) < 4)
> >               return -ENOMEM;
>
> This is much clearer.
>
> >
> >       if (vma->vm_ops && vma->vm_ops->may_split) {
> > @@ -1814,9 +1814,10 @@ static unsigned long check_mremap_params(struct =
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
> > +     if (vma_count_remaining(current->mm) < 6)
> >               return -ENOMEM;
>
> I hate that we do this silly check here, but the time to revisit it is an=
other
> series...

Agreed, I also wondered if this check is more conservative than it
needs to be in all cases.

-- Kalesh

>
> >
> >       return 0;
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index 8b819fafd57b..dd75f2334812 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -1316,7 +1316,7 @@ static int split_vma(struct vma_iterator *vmi, st=
ruct vm_area_struct *vma,
> >               return -ENOMEM;
> >
> >       mm =3D vma->vm_mm;
> > -     if (mm->map_count >=3D sysctl_max_map_count)
> > +     if (!vma_count_remaining(mm))
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
> > index 033a388bc4b1..df0e8409f63d 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -491,8 +491,8 @@ void unmap_region(struct ma_state *mas, struct vm_a=
rea_struct *vma,
> >  }
> >
> >  /*
> > - * __split_vma() bypasses sysctl_max_map_count checking.  We use this =
where it
> > - * has already been checked or doesn't make sense to fail.
> > + * __split_vma() bypasses vma_count_remaining() checks. We use this wh=
ere
> > + * it has already been checked or doesn't make sense to fail.
> >   * VMA Iterator will point to the original VMA.
> >   */
> >  static __must_check int
> > @@ -592,7 +592,7 @@ __split_vma(struct vma_iterator *vmi, struct vm_are=
a_struct *vma,
> >  static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *=
vma,
> >                    unsigned long addr, int new_below)
> >  {
> > -     if (vma->vm_mm->map_count >=3D sysctl_max_map_count)
> > +     if (!vma_count_remaining(vma->vm_mm))
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
> > +                 !vma_count_remaining(vms->vma->vm_mm)) {
> >                       error =3D -ENOMEM;
> >                       goto map_count_exceeded;
> >               }
> > @@ -2772,7 +2772,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
> >       if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
> >               return -ENOMEM;
> >
> > -     if (mm->map_count >=3D sysctl_max_map_count)
> > +     if (!vma_count_remaining(mm))
> >               return -ENOMEM;
> >
> >       if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_i=
nternal.h
> > index 3639aa8dd2b0..52cd7ddc73f4 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -1517,4 +1517,13 @@ static inline vm_flags_t ksm_vma_flags(const str=
uct mm_struct *, const struct fi
> >       return vm_flags;
> >  }
> >
> > +/* Helper to get VMA count capacity */
> > +static int vma_count_remaining(const struct mm_struct *mm)
> > +{
> > +     const int map_count =3D mm->map_count;
> > +     const int max_count =3D sysctl_max_map_count;
> > +
> > +     return (max_count > map_count) ? (max_count - map_count) : 0;
> > +}
> > +
> >  #endif       /* __MM_VMA_INTERNAL_H */
> > --
> > 2.51.0.384.g4c02a37b29-goog
> >

