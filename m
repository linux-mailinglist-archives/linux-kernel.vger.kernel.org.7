Return-Path: <linux-kernel+bounces-801248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A06B442A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B413188E1D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F29822D4DC;
	Thu,  4 Sep 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVKcmCir"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3671D63F7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003098; cv=none; b=SoVos+QLDyvNA7cvFpfqQ6yxHXiejefmtnXcJI01IYz7/t+lnJGKkyA1GE7VcgndYOYnK61CmAK8VJ1F9zuwgetiilR6Tgl7SpKDs5XFJHy3iiyej3Zif3mfgotIY9XfMV43wfL4j93Cb8cinSlJgF7qHH/uh8dWdHdOQkCt3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003098; c=relaxed/simple;
	bh=FT1qrCIvO8/2l9qxuMwiOn7bbjoWD052Nu9cCz2kIZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAquIJj3S6xOs1uUFPYT2G93vgpdhvYn75vlR2r9Kfm1mbeV8x5Wsjzi/0ZDXKi210sT13uaEBMd2E903L0aOnaRIzqof0xJVQheyQfSoR4LvQKgKPb4Ar740C/obJ3o57indJ0PklhTJUX786FZqN3rYvXZZDp29hZrm3Rf8Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sVKcmCir; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24b2337d1bfso233535ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757003096; x=1757607896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFT2XNmKJMqJjJ79Z4MTMpVJ3yD1gMC0n0BoP0X9opI=;
        b=sVKcmCir9IWZ4h+cyj73niYtsnQXcnKZr+O9urvbZ4/QyrcXEBGUAo5NYUZL2cg8C/
         HS0AfP9yGb/ht8dszovDMa4CTt/mCg9dkJA18tAKOu5+38XDJzv6Yd1bviIRw29RjQ/i
         tPSEbILIF/f6UxokGU8lgYmEb5kL0/nS6+JAqv9JzNelqq/LYz3IXZgDW8y/H4ORlf+9
         SgdE0nr21NfY2X9Zc344aB5GY3YtPus1U2v5LZOuVYgVgZYIpWrAB65Nre0OEAImrv44
         FYr8DhRK9CBpf7D7T4V9fWmL9Y96zrZvRK/XMfa+ehFpkZ37v3tfriC8+6ITr2eiTFd1
         ADkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003096; x=1757607896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFT2XNmKJMqJjJ79Z4MTMpVJ3yD1gMC0n0BoP0X9opI=;
        b=RqfDb1MjioIYyfsk8YZ1uItwbYCArNatz5qCx22DOgFkNYHHKHZxru9fESXrZIxK4q
         ligNMMaZ2LrmxZQa7TvbuSugoP8UDixuZGcmnFFYKNhhx572zkznTKON7nxnTBp/5Vgq
         c1L/ZZ1F28S2xqFU29Q3HVFDA3gi+loYLbnPDvXFqhUjb8wnrTlLsXFAuEetD3ONzG1m
         8DvWehkuY+cIMBZabwkTIQ001qniZlIii3+r3hUlwcWQCsQGlalJYr/Pn+ajpv9Qwfhr
         vmL8N1PcI0kYON/Dg1WKvPwzlPyUgPhC5tq5Fss7P99O+p6a7XU120gZ8ZECG8uu/xPN
         0npA==
X-Forwarded-Encrypted: i=1; AJvYcCVUnBakSs6UjDvSX2jYbwznihGNQ3ug4wcfvTujFbPM2UTR8YEf4y3e3egQdMCkwItHwoUhtOgWmRDyv2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3X4FsG5u6oJL612qUq1wKvrhzTgp5hWpPOX+v26w/foQoSrWi
	koGHXvVOWXOF2H5o/cIyjgwZFHqPOM/EGYzKBQfFQz8XLWRiD/yLZRZhISAeARMhjdVXNIfdm4v
	NmPcDqqCDxsVvRuYuOtn9rqw9PuKvseIGZyt3sWfA
X-Gm-Gg: ASbGncv+ZnZ5/1N5f7Vlh85BSF/ErrNJ/LgbaYH5HW535YvJfTTP9ItArfMD9BlADZm
	I4r8EAFJV3NlfLRmuXFQugnFRWFtULzLZEqDFY65QGSM4l1tWiyf/zGGSlB3ASreA9TjqK1agN9
	nMj1dERrrt9pZegi9UDpX9h3hyveV5aQG04h3uMPfko8RLTciCkDvvm5WnEnbxQnZA6YdFRG5Gd
	oYoCRwcMcZxu5glMzWnve3Wd6tVNvs0oVaRuzeI49DFU5ewcOTZ5Yw=
X-Google-Smtp-Source: AGHT+IGAm0XmOGNriB4QaIFnEDqerBTh/T4Isup/MLFm4TpGRkjTg+tlhc0v5DUDCXYa4WATyHeEEilzLQTs3FmdcfA=
X-Received: by 2002:a17:903:186:b0:24b:131c:48b4 with SMTP id
 d9443c01a7336-24cccca62b7mr2615175ad.5.1757003095906; Thu, 04 Sep 2025
 09:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903232437.1454293-1-kaleshsingh@google.com> <3997965c-4cc6-405c-b6fe-a70b4e75afa6@redhat.com>
In-Reply-To: <3997965c-4cc6-405c-b6fe-a70b4e75afa6@redhat.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Thu, 4 Sep 2025 09:24:43 -0700
X-Gm-Features: Ac12FXyI8cT7GjNmqWKUiyjar1SUg-FKukKdQAYqgi0-iYI-lyutgx2yN_rj1rQ
Message-ID: <CAC_TJvc-V9=59p0HG8tmUqQHmp5Sn3E8BV3gHsPj+RHCANd0HA@mail.gmail.com>
Subject: Re: [PATCH] mm: centralize and fix max map count limit checking
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	kernel-team@android.com, android-mm@google.com, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 3:14=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 04.09.25 01:24, Kalesh Singh wrote:
> > The check against the max map count (sysctl_max_map_count) was
> > open-coded in several places. This led to inconsistent enforcement
> > and subtle bugs where the limit could be exceeded.
> >
> > For example, some paths would check map_count > sysctl_max_map_count
> > before allocating a new VMA and incrementing the count, allowing the
> > process to reach sysctl_max_map_count + 1:
> >
> >      int do_brk_flags(...)
> >      {
> >          if (mm->map_count > sysctl_max_map_count)
> >              return -ENOMEM;
> >
> >          /* We can get here with mm->map_count =3D=3D sysctl_max_map_co=
unt */
> >
> >          vma =3D vm_area_alloc(mm);
> >          ...
> >          mm->map_count++   /* We've now exceeded the threshold. */
> >      }
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
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >   include/linux/mm.h | 11 ++++++++++-
> >   mm/mmap.c          | 15 ++++++++++++++-
> >   mm/mremap.c        |  7 ++++---
> >   mm/nommu.c         |  2 +-
> >   mm/util.c          |  1 -
> >   mm/vma.c           |  6 +++---
> >   6 files changed, 32 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 1ae97a0b8ec7..d4e64e6a9814 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -192,7 +192,16 @@ static inline void __mm_zero_struct_page(struct pa=
ge *page)
> >   #define MAPCOUNT_ELF_CORE_MARGIN    (5)
> >   #define DEFAULT_MAX_MAP_COUNT       (USHRT_MAX - MAPCOUNT_ELF_CORE_MA=
RGIN)
> >
> > -extern int sysctl_max_map_count;
> > +/**
> > + * exceeds_max_map_count - check if a VMA operation would exceed max_m=
ap_count
> > + * @mm: The memory descriptor for the process.
> > + * @new_vmas: The number of new VMAs the operation will create.
>
> It's not always a "will" right? At least I remember that this was the
> worst case scenario in some ("may split").
>
> "The number of new VMAs the operation may create in the worst case.
>

Hi Daivd,

You are correct. Cases like mremap account for the worst case (3 way
split on both src and dest). I'll update the  description.

Thanks,
Kalesh
>
> --
> Cheers
>
> David / dhildenb
>

