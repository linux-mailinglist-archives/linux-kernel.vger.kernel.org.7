Return-Path: <linux-kernel+bounces-797599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 461ACB4125A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070FE207B74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2C51DE4CE;
	Wed,  3 Sep 2025 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp9rUBwn"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61DFBA4A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 02:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866714; cv=none; b=HhDxGVWscKZBVcSIgU+wx8rLEbQ3hc3dp+d6A+jSFanCAF5u1AsdINzih1WkS7A5wlU0IUMYsiB5Bw5im9JE1uVdYtUXBsQS8MShHvZ3il1+cIyD2uwXndDOqThCI891yIiNyULToqJXFfYjL9+p2V75pSC4yu9qaphzUyk7QfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866714; c=relaxed/simple;
	bh=9X8EedUjRIzFYPjBfuvG7rkbdTMimSDvFEn8iaZapsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0VjrM4sdkFSA+vrmXVWQJA7qvlBHUMa+Omrg4s42IUqRc5V5desvQAW8q+W37VD+4NEZSPGCmw6mW7rj9jO1IZxvAQzq0NbrPs0TYvBiNC0qbxZLQufcB6VFvHSDmCp+61r8gS+ZiTd7qvS0O64ug6PTFEap9jKPrm1W45T0eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp9rUBwn; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b2fa418ef3so57620721cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756866712; x=1757471512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaM8jElx76QsWPCI4i/bmHE7wpK9FrSZCqDi9Z/x0BU=;
        b=Yp9rUBwnv3/ElpTcEGIcxq+n6mUNWW6U9HtaGVAkecs4g3RAQGDFsYQKGtMUeq82WF
         Fu8rZ3ud7TZXMaFimKTyubXEuSprx2c/2MmylNiz8fBjpBNRhXllrR72A3yyZGuWTHcq
         WJv23DtkbEZe66V4ZYIPvZkYKy+P3IoDCdPATLhqSybw1v7rg78ekF5+waW6w/GNxs3L
         eO4LPHx1bqdwbdmLz1pOBjyQA+R86JaINJWzeZYm8gEIySf5Piw66EhX8i0jrlcRUDuo
         LDMPk+fZHdqmCHf80WRkMZ4upzBqIyNajcmwnEVHhKJAE0nrBmdriPkc40+8TVJcVH3C
         f4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756866712; x=1757471512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaM8jElx76QsWPCI4i/bmHE7wpK9FrSZCqDi9Z/x0BU=;
        b=LcNjBaC/ukH1yODM743O8VBdyZyukvrH7xHTLtfqdYam2hj8h07LEgoj0C8kiome/4
         Zy15Ol8jtzVvqCW55Lw6Mc4Z7dSfsqtPVdpG5cscL8IEa23W14YEjcD0ULJW2PRCPUCY
         ys8pww9Jh7WNzpBpX1g7RIHBItd29an90HhNTvRg5IvIDAwcXJ1420P++bSqZLTweUaz
         LkpCeTaTcdtuWhdQocHTd+Ltnbqkz1WP5rKZWTiR3DCOeg/aLgi6mbMmnRq1TUYhMqW3
         m58pDGrKO5uq1nrRnwkFLaRvG1oLxG3uHCJZQ6uHEPnXKSOZFp/rJDCc/BysRvt7oLwz
         vNnw==
X-Forwarded-Encrypted: i=1; AJvYcCX1+GrO3gEyLUyeuBjOO/y01ICbv+iET1yN8oP2xtPyTUVS+uFsLuIUpbndBsMexOqoyaRPf88fQZVm8PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPHzeSmGf0FB/DUEAeSpUUvkbCeHly/TYIbl7qT8vvWfLl5qF
	pX3R/V7ArPj8AFxiuVkvu97Jf+0aZKqt2l0XAp7hc1veRIoq2DVWyVyeXAeutAMnxBTgbbApCS1
	BTc1RtDJzky79EjX05WyNxVemTUP3xMM=
X-Gm-Gg: ASbGncu50/B3AMq2doKR2/F3waUIoRUBSeAnCtn7NdyFgx8ihL/7JvWqxrDiG6oMvCK
	wdMNeQpAqlx0lWlRjhqhMeDXCa89c5JNrpNQNcL2pv8RT8MuuLQQI23W91o+K9hjY7xtT1sQ1nv
	5aNPvjhy0KMExQLZjM3UaLQgBZkQaWy8v54WhGKG12Txg+J1CwNOdwOV01PXf4KzHHvx8V6kb6F
	Tl9j11s7nuCfnK5zg==
X-Google-Smtp-Source: AGHT+IGsu1otmlJC2BFf+whMMlTjSxOF7/4Mm300tUoYFIc19VewwnIHMj3ISJYok6gXjAx3c3Kr8hfeQ69x85fqyg8=
X-Received: by 2002:ac8:5e4d:0:b0:4b3:219:b74a with SMTP id
 d75a77b69052e-4b31dcccadbmr180598031cf.72.1756866711488; Tue, 02 Sep 2025
 19:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-7-ryncsn@gmail.com>
 <CAGsJ_4yRa65ogB0d90LmtOigGTqQ9mM-eUU6VbmcX63j6vgHEg@mail.gmail.com>
 <CAMgjq7A5Gr2V9TDFg=_S+SjZ1r1gWXTtRGNofuzAgWNYLMW_DQ@mail.gmail.com>
 <CAGsJ_4w7iV0YU+sXdYPrzqXAdaLncoP7bnGx8ELcpETL6y+cOQ@mail.gmail.com> <CAMgjq7AWQtbXMH4iOoV473wJj0TA8SEUyvsWKvsUP_=1oRuH9w@mail.gmail.com>
In-Reply-To: <CAMgjq7AWQtbXMH4iOoV473wJj0TA8SEUyvsWKvsUP_=1oRuH9w@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 3 Sep 2025 14:31:40 +1200
X-Gm-Features: Ac12FXw9QoA8aC-zRqLH3kdz8gE1l6zpGqF39cGUZA-kcxrOVqv_LPaFpOqQt0g
Message-ID: <CAGsJ_4z7BagquRVHoJq612h-_n87F_VuTqRxOnSCoox2qpYmRg@mail.gmail.com>
Subject: Re: [PATCH 6/9] mm, swap: use the swap table for the swap cache and
 switch API
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 2:12=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> Barry Song <21cnbao@gmail.com> =E4=BA=8E 2025=E5=B9=B49=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=B8=89 07:44=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Sep 2, 2025 at 11:59=E2=80=AFPM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > On Tue, Sep 2, 2025 at 6:46=E2=80=AFPM Barry Song <21cnbao@gmail.com>=
 wrote:
> > > >
> > > > > +
> > > > > +/*
> > > > > + * Helpers for accessing or modifying the swap table of a cluste=
r,
> > > > > + * the swap cluster must be locked.
> > > > > + */
> > > > > +static inline void __swap_table_set(struct swap_cluster_info *ci=
,
> > > > > +                                   unsigned int off, unsigned lo=
ng swp_tb)
> > > > > +{
> > > > > +       VM_WARN_ON_ONCE(off >=3D SWAPFILE_CLUSTER);
> > > > > +       atomic_long_set(&ci->table[off], swp_tb);
> > > > > +}
> > > > > +
> > > > > +static inline unsigned long __swap_table_get(struct swap_cluster=
_info *ci,
> > > > > +                                            unsigned int off)
> > > > > +{
> > > > > +       VM_WARN_ON_ONCE(off >=3D SWAPFILE_CLUSTER);
> > > > > +       return atomic_long_read(&ci->table[off]);
> > > > > +}
> > > > > +
> > > >
> > > > Why should this use atomic_long instead of just WRITE_ONCE and
> > > > READ_ONCE?
> > >
> > > Hi Barry,
> > >
> > > That's a very good question. There are multiple reasons: I wanted to
> > > wrap all access to the swap table to ensure there is no non-atomic
> > > access, since it's almost always wrong to read a folio or shadow valu=
e
> > > non-atomically from it. And users should never access swap tables
> > > directly without the wrapper helpers. And in another reply, as Chris
> > > suggested, we can use atomic operations to catch potential issues
> > > easily too.
> >
> > I still find it odd that for writing we have the si_cluster lock,
> > but for reading a long, atomic operations don=E2=80=99t seem to provide
> > valid protection against anything. For example, you=E2=80=99re still
> > checking folio_lock and folio_test_swapcache() in such cases.
> >
> >
> > >
> > > And most importantly, later phases can make use of things like
> > > atomic_cmpxchg as a fast path to update the swap count of a swap
> > > entry. That's a bit hard to explain for now, short summary is the swa=
p
> > > table will be using a single atomic for both count and folio tracking=
,
> > > and we'll clean up the folio workflow with swap, so it should be
> > > possible to get an final consistency of swap count by simply locking
> > > the folio, and doing atomic_cmpxchg on swap table with folio locked
> > > will be safe.
> >
> > I=E2=80=99m still missing this part: if the long stores a folio pointer=
,
> > how could it further save the swap_count?
>
> We use PFN here, it works very well, saves more memory and the
> performance is very good, tested using the 28 series patch which have
> already implemented this:
> https://lore.kernel.org/linux-mm/20250514201729.48420-25-ryncsn@gmail.com=
/

Alright, I see. With the PFN, we already have the folio.

>
> >
> > >
> > > For now using atomic doesn't bring any overhead or complexity, only
> > > make it easier to implement other code. So I think it should be good.
> >
> > I guess it depends on the architecture. On some arches, it might
> > require irq_disable plus a spinlock.
>
> If an arch can't provide atomic for basic access to a long, then that
> justified the usage of atomic here even more.. The read has to be
> atomic since swap cache lookup is lockless, so the write should be
> atomic too.

I actually confused atomic_64 with atomic_long. After double-checking, I
found that on almost all architectures, atomic_long_set/read are effectivel=
y
write_once and read_once. However, many architectures override these in the
common header file. This seems like a spot worth cleaning up for those
architectures.

>
> Xchg / cmpxchg is a bit more complex on some arches, they are optional
> in the swap table anyway. We can use them only on arches that provide
> better performance with atomic. I believe most arches do. For the xchg
> debug check, it can be dropped once we are confident enough that there
> is no hidden bug.

Thanks
Barry

