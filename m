Return-Path: <linux-kernel+bounces-804185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75C6B46C26
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E78188B467
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6898F28726E;
	Sat,  6 Sep 2025 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeBjEByJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2EE136E37
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757159935; cv=none; b=BWDcYIIniWa+vJ5ncu2LfB7H1bS81QJZqimct9g0MzVYk43Gs6VwUFlw2oAPZrumWvcKtuqTcSl72TDamYTLpWRWwzxF1xh3Kvvu0GREdrg6TnIQNal5Xtqi0zRKfnDjz8r0IRx3NjIDntqe8/IrJccAGekbwehYKTIIjROHn0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757159935; c=relaxed/simple;
	bh=Y+R6OdqfM70uWhWnuBfHr9o5HKUIm94zXuJivP6hw4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAIsZnsMqf4RD5BkuvdSsrpOkMea5yjS9Ger5ya89I1Z5Lex+bySS0HcZAgCFk0lZpnpu1BMzeCX8vaSWi4iZMCYKb/JaJyPOd/bqBTIQeigzblrssLvt6JRaEELdR3rTp0NCqFHNvyoDCdoyw5WEN4oLmr63DbjYJGR121ROE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeBjEByJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BEBC4CEFA
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 11:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757159934;
	bh=Y+R6OdqfM70uWhWnuBfHr9o5HKUIm94zXuJivP6hw4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OeBjEByJku7Yc2fSJnPtWiWQVZWsK3hgRrEfXSNiiFkKsVFh90/1j6XQD5XIhrDA5
	 ZEnHcc1tOWVqANRmQwebPZvDP2hR4OznAfJTILuV4B3C+t+IN061O5Pc/vWvMdmvpz
	 cAl4ajwrSIrwh3/tgpk/XZlo1aztmkXn/YFeKgzqAJjiYgYX2MWVUrDIlwwMe4MVRO
	 DyfA7jUzffVpXRLrSutSpqBcy0qEkcSWceMEBjDTHXdO3FiESuWA4YNfJlu43RiePD
	 btY4ipsgjE7/C7cbW+09o3Qb8aI6CYdv72rTEXEKuQCJjgA5ife3j0AXzk3/zgEzeI
	 6loDtZJvfCT3A==
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dd9d72f61so46865e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 04:58:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDQW7AQGkgJCgYope38J+OoP7AkzLY457BzK6JhV+xH7zNTnAlvTP1+BOhpQ3aRwWIH+D6/yDe0Mqz+9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6TVznmRjQQnm7TFNIaWfLaYUIliYB4Qgel+zyeAQ48MmICtp
	SNJtaKeZjv7nY2TowDytv6IOox8Q6Xkko2Oja1elS+C6TWPgAipZuLimjPM1JzoIaVcYbEnTEMC
	6gtXll9s/aT4aJQbd6nsGiXNP8Kw4TfqTx6n9OeQx
X-Google-Smtp-Source: AGHT+IEdfbwBEn4ztTNn03ZcNZmiIGdjx6/+5WFlkp555xMk8nvWcFO4gxEF1owQmIfOxcr9ircCaRUpI4x2hMJXAAY=
X-Received: by 2002:a05:600c:34cb:b0:45c:b678:296 with SMTP id
 5b1f17b1804b1-45dde17c034mr899185e9.5.1757159932937; Sat, 06 Sep 2025
 04:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-4-ryncsn@gmail.com>
 <CAF8kJuNhLDovRO+8Y25ArdMBVFjXnYBVjmASzMBtdsdZkQ0NLQ@mail.gmail.com> <CAMgjq7CyXEy3+98JdATscgPu9b9oLbE6CM7-2pFpiQP2QrsrpQ@mail.gmail.com>
In-Reply-To: <CAMgjq7CyXEy3+98JdATscgPu9b9oLbE6CM7-2pFpiQP2QrsrpQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 6 Sep 2025 04:58:41 -0700
X-Gmail-Original-Message-ID: <CAF8kJuM1M=gDwkuQF0tU_d4YXxf9dpZfNe13ycPjgMcr1RUkJA@mail.gmail.com>
X-Gm-Features: AS18NWDL9WLHuN5sS1DbFEP7WJoIPUp7pl0etFR5WWyMwBy3lQ4adYkPyeehV-o
Message-ID: <CAF8kJuM1M=gDwkuQF0tU_d4YXxf9dpZfNe13ycPjgMcr1RUkJA@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] mm, swap: fix swap cahe index error when
 retrying reclaim
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 11:29=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sat, Sep 6, 2025 at 11:19=E2=80=AFAM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > Hi Kairui,
> >
> > The patch looks obviously correct to me with some very minor nitpicks f=
ollowing.
> >
> > Acked-by: Chris Li <chrisl@kernel.org>
> >
> > On Fri, Sep 5, 2025 at 12:14=E2=80=AFPM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > The allocator will reclaim cached slots while scanning. Currently, it
> > > will try again if the reclaim found a folio that is already removed f=
rom
> > > the swap cache due to a race. But the following lookup will be using =
the
> > > wrong index. It won't cause any OOB issue since the swap cache index =
is
> > > truncated upon lookup, but it may lead to reclaiming of an irrelevant
> > > folio.
> > >
> > > This should not cause a measurable issue, but we should fix it.
> > >
> > > Fixes: fae8595505313 ("mm, swap: avoid reclaiming irrelevant swap cac=
he")
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  mm/swapfile.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index 4b8ab2cb49ca..4c63fc62f4cb 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -240,13 +240,13 @@ static int __try_to_reclaim_swap(struct swap_in=
fo_struct *si,
> > >          * Offset could point to the middle of a large folio, or foli=
o
> > >          * may no longer point to the expected offset before it's loc=
ked.
> > >          */
> > > -       entry =3D folio->swap;
> > Nitpick:
> > This and the following reuse the folio->swap dereference and
> > swp_offset() many times.
> > You can use some local variables to cache the value into a register
> > and less function calls. I haven't looked into if the compiler will do
> > the same expression elimination on this, a good compiler should. The
> > following looks less busy and doesn't need the compiler to optimize it
> > for you.
> >
> >            fe =3D folio->swap;
> >            eoffset =3D swp_offset(fe);
> >            if (offset < eoffset ) || offset >=3D eoffset + nr_pages) {
> > ...
> >            }
> >            offset =3D eoffset;
> >
> > This might generate better code due to less function code. If the
> > compiler does the perfect jobs the original code can generate the same
> > optimized code as well.
>
> Right, this part of the code will be gone soon so I think maybe better
> to keep the change minimal, and it's not a hot path.

Ack. It is nitpick anyway. Most likely doesn't make a difference to
modern compilers anyway.

Chris

