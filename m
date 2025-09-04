Return-Path: <linux-kernel+bounces-799783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF6FB43031
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D344E7B6793
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D101EA7E4;
	Thu,  4 Sep 2025 03:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzlt7BHT"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F117C203
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 03:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756954924; cv=none; b=jDtVIclZaWze7v6qbYs2Yb7mgh9+Dvim5LaMsRjT99JYWR7Krv2x6uSO6C4BSkJ7+FXoOhoDDmSrOb0JJ+sWW/BSjQkCiiPz6auvhE1Np3nmbpiqthnlEizzSJrcXt5ScEi9niGqqjir2oA1rHHBQf88mQPioIu8iffFJIueUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756954924; c=relaxed/simple;
	bh=oW4Fbm6RX1C7MlRQuOcylgsSp3U7gkzE3rm4ZIOhFdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqqsBlzaf/m75VOXO/TAAxQuLVssDR4wfDAWsSAf/Lesnpsu1ERyIqH52BUq87LEhutD9WtK7T5HddWcguOdOLxtDKZ4lAu0L0x/D6E63cllIYpaghH8AobJi3TEbPiOXiwBkEhUdhvkw4lp9/Ns7IYftCeqxz6MgiVUc5tIUSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fzlt7BHT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24cca557085so38955ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 20:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756954922; x=1757559722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sg3/MOE3S1m7f3fF13n1hw3ITE04y8oKW6xr+zs7pi4=;
        b=fzlt7BHTInT9xpGICKXZ9FELsoghY0C48GCe++aavMSncdhjp4QyJOwB8W6acr5GGR
         9qtsQiBFsmCiyu9e2zRV+X+UVxIXTBHdeL1MiY5oepmYYGWnCI4AX0J8/B6YcXbml+5V
         m2aNPQyS5bMyt/Tf4su8VUbXu0xX+ELBagUnWJ36oPvhJhckBF4cJoKFVhbvRVwUpwJF
         L+7+Y85ublIFw63YyF6fTxIA2Ug09V2gZlgbTy0VPC2gLxdufhrqmnW+xYj4muSCDBSX
         WMarTnSpD7u0wWNltxng0JXCwnPawKjglKfyUgIyB2J86jPSUH20luLxLHqvIjJ894gp
         NX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756954922; x=1757559722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sg3/MOE3S1m7f3fF13n1hw3ITE04y8oKW6xr+zs7pi4=;
        b=qux39uLaSoaBXWLJjW16UJVFCFDRQEJGJtsqbD76T3eB4GpeyV8vS6fwS/Hrai20CO
         cONCr/ZymUXucadE3ZmhvCIwIlyoMibC5XbiuA9YRW8fqM2ZiCkL+VIE6G2bEuH/IDJn
         H0eoIZwVwTFvVG5gWzhDCtXZeDb1ZJ3MAUch2Gvty0sD3qlp63QgoP9SE67yvb7MYH76
         devAL9QwzM7VLrxhZ0mSoo1vv99cf0qQOooxq6kT37TfSfVUSOYwTBPR6lGElXKEk9P0
         YA3qWN27PuPwjguGKBFnVL9G5Izb17k2iGQIrVgZqy/qjiRYkJwW5kQoF1xTV6sPpU5l
         pWFw==
X-Forwarded-Encrypted: i=1; AJvYcCX3YkXKCeMSIbj3IyeoVEsN/371p/LKK6dI3xOfe4/FmAw+ecwHhuBCd+7FjHHVBm2OxaCS3/m8iGDIQXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeWSGZrc21XjdXIODosO1Uflu1y7D4PxWv/lGY/+1t0iCXkL8I
	ndyUjrJFnBsMC2DOZETYizkykKg+iJMB9NhE3DnJCfB1j93/s3zGAzdprFjiNSrKBWVTq7/i8+v
	R1NVOYG67XHUHOGddhOUyYRWSk0jiZCbufc2Y0sik
X-Gm-Gg: ASbGnctF4ikTmiaXZuasDJmPlzRDt9tL521rE5S0h+/G9V9swfCxTkAgVVgzocmpN8y
	u/yGUwH9QgXvkSLEV9Xi0+EHgMomO/72QGuiRVYit8R9e/lfOWZ5OLIbUD7qbD+csr3yCu9K0xe
	N5wJgfwF6tUq6ISyVAIHRr5VGq8I1atA5NRjthXKkhy54So3T5DpBdX4P3+JlUyoUhqNlApESRe
	898HvZvqmzqx9yJTkqANy6J0j9MImwpWd9/TR0OCcp2QXu1GAG5GiNeDA==
X-Google-Smtp-Source: AGHT+IG8YHt751a8iagriEcNsKMllgaN6wY06ZE8CJTNDUcFMlf5P7pepAtKth9DhLzX66wuKthgL0uNwy/D9mA5rp0=
X-Received: by 2002:a17:902:e748:b0:248:dce7:40e1 with SMTP id
 d9443c01a7336-24cccca7f62mr454025ad.9.1756954921579; Wed, 03 Sep 2025
 20:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903232437.1454293-1-kaleshsingh@google.com> <qa7b7pvrycejnn6pjytxysu57xckhexupjrzefmk4j5hlaxka3@ayeg2vzpfe3r>
In-Reply-To: <qa7b7pvrycejnn6pjytxysu57xckhexupjrzefmk4j5hlaxka3@ayeg2vzpfe3r>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 3 Sep 2025 20:01:50 -0700
X-Gm-Features: Ac12FXy43GL9nI9zR7z8e9dj8Hz5wlrXATZLKUd47Qr5ZkcfHVn_XRh1JMB9T7w
Message-ID: <CAC_TJvd0SnHpEv0MSwXsF4UFpP0MNvRc033=JS1xTEHAOjQY5A@mail.gmail.com>
Subject: Re: [PATCH] mm: centralize and fix max map count limit checking
To: Pedro Falcato <pfalcato@suse.de>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	kernel-team@android.com, android-mm@google.com, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:46=E2=80=AFPM Pedro Falcato <pfalcato@suse.de> wro=
te:
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
>
> I think this should be fixed separately, and sent for stable.

Hi Pedro, thanks for the review. I can split this out separate.

>
> >
> > To fix this and unify the logic, introduce a new function,
> > exceeds_max_map_count(), to consolidate the check. All open-coded
> > checks are replaced with calls to this new function, ensuring the
> > limit is applied uniformly and correctly.
>
> Thanks! In general I like the idea.
>
> >
> > To improve encapsulation, sysctl_max_map_count is now static to
> > mm/mmap.c. The new helper also adds a rate-limited warning to make
> > debugging applications that exhaust their VMA limit easier.
> >
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
> No new "extern" in func declarations please.

Ack

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
> >               return -ENOMEM;
>
> If the brk example is incorrect, isn't this also wrong? /me is confused

Ahh you are right, this will also go over by 1 once we return from
mmap_region(). I'll batch this with the do_brk_flags() fix.

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
> I'm not entirely sold on the map count warn, even if it's rate limited. I=
t
> sounds like something you can hit in nasty edge cases and nevertheless fl=
ood
> your dmesg (more frustrating if you can't fix the damn program).

I don't feel strongly about this, I can drop it in the next revision.

>
> In any case, if we are to make the checks more strict, we should also add
> asserts around the place. Though there's a little case in munmap() we can=
 indeed
> go over temporarily, on purpose.

To confirm, do you mean we should WARN_ON() checks where map count is
being incremented?

>  Though there's a little case in munmap() we can indeed
>  go over temporarily, on purpose.

For the 3 way split we need 1 additional VMA after munmap completed as
one of the 3 gets unmapped. The check is done in the caller beforehand
as __split_vma() explicitly doesn't check map_count. Though if we add
asserts we'll need a variant of vma_complete() or the like that
doesn't enforce the threshold.

Thanks,
Kalesh

>
> --
> Pedro

