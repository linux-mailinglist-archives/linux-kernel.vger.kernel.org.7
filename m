Return-Path: <linux-kernel+bounces-804529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC45FB478DF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 06:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D63B3BECA7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 04:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C65A15B135;
	Sun,  7 Sep 2025 04:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCg1JTCQ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF517E0
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 04:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757219076; cv=none; b=umgqXRDfQ5UmsjB9NXS6RTHIA6EI3XRGjI0LrKwpR8Hfw5/JXznpI8Pxdi9eYCQGa+q+yz3WsT1WTz28QLDVyLbLFQkXnTKva4eMSnDuGPt+pOc3ttxSR328hnw0cnAuyzEtfb8VIXrc9VzoE42jC7r9rZwZbei+VQJtqDUMBHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757219076; c=relaxed/simple;
	bh=1mdn15MDwR6X4L4S4rcqdKclmdlez5vbpopUmjklvbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMz+6Siy4UDNyN0fMYmOiOimuIqxZdzSbYjjI4uZ1Jmnu1xufW5r/4X6yUFl5eMNN0O6YsCe22O/AqtcgIIxtMFWHZFcWxebfKpDIOVPvH3HAFpwe1DlkL05ml7E0G/uuLwx36QXocoqm5HBbIwJ3vcmoPXdu4veOE3XIBg/4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCg1JTCQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24cf5bcfb60so146115ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 21:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757219074; x=1757823874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTPgPzRrBAxJrCac5XmQ2yTlMqaTokhJ/jQ8/1ljY9I=;
        b=jCg1JTCQu9xGQqnHBvaQev7Ysq3pyL4RDcEIGo3mAydvwYtQU+tV0eat3jtG0FrDZj
         UR15BCLzEYepycWOIVFyEySs42L3ReYo3xSlRZI/E5lilJ5vRTtTstT/cVnMMcrgVBhy
         vgOF/zFEthFJ7LlYnnmzaWMwYN+ET39p91ahMFSupXficN6DY+TguUilD4n4rdPcj6ul
         kU18G7PGva84BB/ibMUaQVxngYWKfhhEFyOd9fmb5gcQVISWhwlj5dv4Z4UfQKa++gzX
         l788GNauunRJA7TvVLkdhuosJeB0oL7UKpuzRWaHbnybdQExN/2o0tR2we4ybU708voi
         cfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757219074; x=1757823874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTPgPzRrBAxJrCac5XmQ2yTlMqaTokhJ/jQ8/1ljY9I=;
        b=ntqU/vZp7nJakbB9n7/u37VSRR9oHIstPmn3fiFlej5yeEYqzJ6UEpdvShRCxKQsQq
         /QcK+IWDHGqYBmybDizeWlhVguvo6LI8GycH/5iRCMlmGP7UIG034gVuXkhlvm0nQTWr
         ZQsfDxAw4yKeGo5Cb3tT0cEWqL23hg+D8Acx0/NCGTCer6wnt1nBbi+CCF3D06kOIgID
         +Env9p9Hq5uVKfmkHMiQmT2nsWjB2dgLiJGt1l9BvdaZc6D5nQ+ItioIGAQf+TH1y5H+
         0T/opzMdlO9LXejwHcJMfNKeUlKUHCXaNW55egXA2U9YTES6AIi38uldhA91dOb9Erc/
         SNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoKdimzNMmi7X3r1szO5saejBUy7XbAE1Rr5DPD5VnVk2n3goL4AA7bb7FAzcHBbb8TiJY9fyvcZ9aby4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZkE6yZSM5zDoLbiRoTe7vYKEwKtxo0sjTWVbbp5F410BFUNpq
	fZPnEEhkxA5Fk7m8Xozl40CNHKXlw3xQCossjTKJtCd3AWjidQJI7d7VPS8iBjtPiqOrnl9A0cj
	uo2ELZHjuUuEq6TLuyiIYJ+ZfwLX8ogUkfTKSKwQ3
X-Gm-Gg: ASbGnctF1Pth2q30CWpNUEky8R16m0aCmFQeNJebNM0DIKeatpgasj6v+eZsDdptFIg
	TMadBQ4OqpbdcPyC6VhW4dTSGayPnfOe7ocvEfIOu/KwkVgRqagjkQXz3NGidHYJz3304+ShSsr
	pa3CoC5NWTb+7r/rq3zOmdBC90cp6QEcgnyvDeGri3S5MI7R2rFrqwCiH5Itu4TC8zE0BlcjAYc
	F6luCV6goWo8pD7cPclU4OcDydQkAYofKOUzcCFcJhmbvNEeb6OIpfzsw==
X-Google-Smtp-Source: AGHT+IGYa0lPcHnn6yyQH0nLs+W33hFAxTRTwUNtazygW/FTP7faT7GUxA8+33u94005mbOApW9X6E+kBz9mCu3EfpY=
X-Received: by 2002:a17:902:e887:b0:248:d063:7511 with SMTP id
 d9443c01a7336-2517484234fmr2374415ad.9.1757219073688; Sat, 06 Sep 2025
 21:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903232437.1454293-1-kaleshsingh@google.com>
 <qa7b7pvrycejnn6pjytxysu57xckhexupjrzefmk4j5hlaxka3@ayeg2vzpfe3r> <aLs9f9WjxIOrE3Sr@google.com>
In-Reply-To: <aLs9f9WjxIOrE3Sr@google.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Sat, 6 Sep 2025 21:24:22 -0700
X-Gm-Features: Ac12FXyluFsg8rwjLeiuUN8OqbXpgEL5Ij8nUCZC_bTtjwaiTP3umbB2xEe5lA4
Message-ID: <CAC_TJvdXNJSqNjRQS92jAOBUJ+3qyS9+eZAGSJMokGQQHaxqoQ@mail.gmail.com>
Subject: Re: [PATCH] mm: centralize and fix max map count limit checking
To: Minchan Kim <minchan@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, 
	kernel-team@android.com, android-mm@google.com, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:44=E2=80=AFPM Minchan Kim <minchan@kernel.org> wr=
ote:
>
> On Thu, Sep 04, 2025 at 12:46:34AM +0100, Pedro Falcato wrote:
> > On Wed, Sep 03, 2025 at 04:24:35PM -0700, Kalesh Singh wrote:
> > > The check against the max map count (sysctl_max_map_count) was
> > > open-coded in several places. This led to inconsistent enforcement
> > > and subtle bugs where the limit could be exceeded.
> > >
> > > For example, some paths would check map_count > sysctl_max_map_count
> > > before allocating a new VMA and incrementing the count, allowing the
> > > process to reach sysctl_max_map_count + 1:
> > >
> > >     int do_brk_flags(...)
> > >     {
> > >         if (mm->map_count > sysctl_max_map_count)
> > >             return -ENOMEM;
> > >
> > >         /* We can get here with mm->map_count =3D=3D sysctl_max_map_c=
ount */
> > >
> > >         vma =3D vm_area_alloc(mm);
> > >         ...
> > >         mm->map_count++   /* We've now exceeded the threshold. */
> > >     }
> >
> > I think this should be fixed separately, and sent for stable.
> >
> > >
> > > To fix this and unify the logic, introduce a new function,
> > > exceeds_max_map_count(), to consolidate the check. All open-coded
> > > checks are replaced with calls to this new function, ensuring the
> > > limit is applied uniformly and correctly.
> >
> > Thanks! In general I like the idea.
> >
> > >
> > > To improve encapsulation, sysctl_max_map_count is now static to
> > > mm/mmap.c. The new helper also adds a rate-limited warning to make
> > > debugging applications that exhaust their VMA limit easier.
> > >
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Minchan Kim <minchan@kernel.org>
> > > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > ---
> > >  include/linux/mm.h | 11 ++++++++++-
> > >  mm/mmap.c          | 15 ++++++++++++++-
> > >  mm/mremap.c        |  7 ++++---
> > >  mm/nommu.c         |  2 +-
> > >  mm/util.c          |  1 -
> > >  mm/vma.c           |  6 +++---
> > >  6 files changed, 32 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 1ae97a0b8ec7..d4e64e6a9814 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -192,7 +192,16 @@ static inline void __mm_zero_struct_page(struct =
page *page)
> > >  #define MAPCOUNT_ELF_CORE_MARGIN   (5)
> > >  #define DEFAULT_MAX_MAP_COUNT      (USHRT_MAX - MAPCOUNT_ELF_CORE_MA=
RGIN)
> > >
> > > -extern int sysctl_max_map_count;
> > > +/**
> > > + * exceeds_max_map_count - check if a VMA operation would exceed max=
_map_count
> > > + * @mm: The memory descriptor for the process.
> > > + * @new_vmas: The number of new VMAs the operation will create.
> > > + *
> > > + * Returns true if the operation would cause the number of VMAs to e=
xceed
> > > + * the sysctl_max_map_count limit, false otherwise. A rate-limited w=
arning
> > > + * is logged if the limit is exceeded.
> > > + */
> > > +extern bool exceeds_max_map_count(struct mm_struct *mm, unsigned int=
 new_vmas);
> >
> > No new "extern" in func declarations please.
> >
> > >
> > >  extern unsigned long sysctl_user_reserve_kbytes;
> > >  extern unsigned long sysctl_admin_reserve_kbytes;
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 7306253cc3b5..693a0105e6a5 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned=
 long addr,
> > >             return -EOVERFLOW;
> > >
> > >     /* Too many mappings? */
> > > -   if (mm->map_count > sysctl_max_map_count)
> > > +   if (exceeds_max_map_count(mm, 0))
> > >             return -ENOMEM;
> >
> > If the brk example is incorrect, isn't this also wrong? /me is confused
> > >
> > >     /*
> > > @@ -1504,6 +1504,19 @@ struct vm_area_struct *_install_special_mappin=
g(
> > >  int sysctl_legacy_va_layout;
> > >  #endif
> > >
> > > +static int sysctl_max_map_count __read_mostly =3D DEFAULT_MAX_MAP_CO=
UNT;
> > > +
> > > +bool exceeds_max_map_count(struct mm_struct *mm, unsigned int new_vm=
as)
> > > +{
> > > +   if (unlikely(mm->map_count + new_vmas > sysctl_max_map_count)) {
> > > +           pr_warn_ratelimited("%s (%d): Map count limit %u exceeded=
\n",
> > > +                               current->comm, current->pid,
> > > +                               sysctl_max_map_count);
> >
> > I'm not entirely sold on the map count warn, even if it's rate limited.=
 It
> > sounds like something you can hit in nasty edge cases and nevertheless =
flood
> > your dmesg (more frustrating if you can't fix the damn program).
>
> How about dynamic_debug?
>
> a1394bddf9b6, mm: page_alloc: dump migrate-failed pages

Hi Minchan,

Thanks for the suggestion to use dynamic_debug. As you may have seen
in the discussion, it has moved to a capacity based helper
(vma_count_remaining()) based on feedback for better readability at
the call sites. Unfortunately, a side effect of that design is that
we've lost the single, centralized failure point where a dynamic_debug
message could be placed. I'm going to stick with that due to the
readability benefits. However, you've raised a good point about
observability. For this I am planning to add force increment/decrement
via vma_count_* helpers and perhaps we can add trace events in the
helpers to get similar observability.

Thanks,
Kalesh

