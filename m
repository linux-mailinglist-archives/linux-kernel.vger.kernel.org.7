Return-Path: <linux-kernel+bounces-804065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BA8B4696B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 08:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2AB1C810F4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C292C0289;
	Sat,  6 Sep 2025 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlIdwM99"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884221ABD5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 06:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757140137; cv=none; b=LfD1I+lFOWcpLezOn5w2X63kKQbyz8UQt1/1Js/VpB1LL9zg9PisMNC4GM7xHH/j5DAKTLAThkuAfkzicxUOy/zBSwq1xMD+qaOnbUp8Ic14H4cc5O25pniTQRf5hXw2UPYNG96EAZSgRdK4Q676wi8K4mIYs5OxLE0rzG+aM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757140137; c=relaxed/simple;
	bh=CqleG4duW2XXsdDciSE9K/OYs9hslHMgMtLqgMiz6Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWRE0U2daiU5ZBWjzZ7wa7NBavpcMb5Zlzx0ubNTX0yYEKQSyWibCSE00Xg2D7BllZ5ueoMs5r+HnzLioS9yRJesBCyNlW0jm+yOuTcRmEt0SUbfuV39W+KEyDVYmg7o02cDf0yBbwnIKYXinViepW86rev7Tl+PM4Zl/R3q5tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlIdwM99; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-620724883e6so4288155a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 23:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757140134; x=1757744934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4h66ZB3eu8GQGQL6aGzFIVzFho9ZlCpR/MIbMd2vyg=;
        b=BlIdwM99xj8Dt6tJlvcJZCaDUlC/ivEgb8dbVbyfS1nzhoPEtLl1fptBxxYfngtixw
         I/WkUHBeQokZEjRI7cIL1teOab4qbY3Axu2V58DJ0Ce8KUkexFJl558gxYhXzNf8jyLq
         Z4qlJvOvjT0JC7kwTaCX2FKdQqyDynLikU29Y43no3Ry0synjU29BSGbpQPigwqfCAVP
         BROYmH02MOyfyihz1Sm1T/2XYLg2Ip+PEDtRMHGrwUCJ6/AoadlzO/Y9y33LnLPFHKj5
         ZODCHsMo/ccHhCVw0FXwNa3QHR7I31mgGdUByYxo1FqvhftHeZBhp7uxlK1+biD6Tt3R
         PD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757140134; x=1757744934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4h66ZB3eu8GQGQL6aGzFIVzFho9ZlCpR/MIbMd2vyg=;
        b=v6e0OF5YfEfGytUsK/Qvw43IXzH8FPQGpqo3iYvZkcV5517pgrChVDqwPiOHiAiyXV
         MPBhjEfbCL00saRNpdZVyTBf1a3L7FjEEss4nlpWQ+HZ2/hkp80q0FegGvqhdsSo7XCA
         WCTWZAzewuTmphYxHJvMhnGRWvN3xGrppmuMWGKU/kmQ4qg0ocu4MzaEbs0s7yQ3lJXG
         11u2XCw8eGy8HLx8BBabTN5+ey5rcw2RmvZqaL0y2MnCJuXA1p9RY6F5lb9BVPSNIJT9
         MnTqOwewyupjudgTkEU3rsRmV0WAUa0BLKEQONcsj2hpSfaX9iLuYTANru4b09aDNSv2
         OZTw==
X-Forwarded-Encrypted: i=1; AJvYcCVrqKJ2JzZMP0Fin5ka+MVudNbILqvX4fKo80bX6WJUuoC94MAyQSbgfOenrwGyol+j3Uhl8onWa1w8ZNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywORkqzRnooOW0WZv7XT8i5xVfL9/m28+hz/3TjuZxzSsVvUGj
	Nhrh0+FrSQd9wzXggygabvcP4mDEAoDimUHPw12ZAr6NZRPAn5nRr3Z71R6wBw68WM2UhU3v/dT
	vNRy2cZncK3BdJzmBPI1k+wP5QCr/GUo=
X-Gm-Gg: ASbGnctKNKAEbcM/qIPw1vgBvU140TCg6BIilr4bpbSyLvkNdmnqPsTpVea2nHQKFgM
	oEol10cqwlvjHRxmiv1dIU19N/aEHuKTZtAlZfAmXCgFd97EY5JGkTPFtg2eCksgqNYTiQuUTS5
	Ti+QEpQCAHXZztJ7A3uLXjAHFQSoP4ZPsJPZpagDZHnqsH/zXpEjuP+sxVZSSI/UGD5uNGs/CDE
	NfDQoKj6hYzuw+6d+sk4bjvDkmL39Rl
X-Google-Smtp-Source: AGHT+IHsC2knxDQNn4giP+JXb6pHa0hvgmBiK3ec9kCE3HQZg9euXTZHJ3R19Cz2VQYbHKU+7X559ibjoRKbAKjal5o=
X-Received: by 2002:a05:6402:13d5:b0:622:b89c:d4b3 with SMTP id
 4fb4d7f45d1cf-6237bc57750mr1322154a12.10.1757140134021; Fri, 05 Sep 2025
 23:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-4-ryncsn@gmail.com>
 <CAF8kJuNhLDovRO+8Y25ArdMBVFjXnYBVjmASzMBtdsdZkQ0NLQ@mail.gmail.com>
In-Reply-To: <CAF8kJuNhLDovRO+8Y25ArdMBVFjXnYBVjmASzMBtdsdZkQ0NLQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 6 Sep 2025 14:28:17 +0800
X-Gm-Features: Ac12FXy89p0Y7o4HcvOqd96xDhUx0JrLVG0q1xhf4KrwpHZK-9I_wf8HIzv7XNs
Message-ID: <CAMgjq7CyXEy3+98JdATscgPu9b9oLbE6CM7-2pFpiQP2QrsrpQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] mm, swap: fix swap cahe index error when
 retrying reclaim
To: Chris Li <chrisl@kernel.org>
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

On Sat, Sep 6, 2025 at 11:19=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> Hi Kairui,
>
> The patch looks obviously correct to me with some very minor nitpicks fol=
lowing.
>
> Acked-by: Chris Li <chrisl@kernel.org>
>
> On Fri, Sep 5, 2025 at 12:14=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > The allocator will reclaim cached slots while scanning. Currently, it
> > will try again if the reclaim found a folio that is already removed fro=
m
> > the swap cache due to a race. But the following lookup will be using th=
e
> > wrong index. It won't cause any OOB issue since the swap cache index is
> > truncated upon lookup, but it may lead to reclaiming of an irrelevant
> > folio.
> >
> > This should not cause a measurable issue, but we should fix it.
> >
> > Fixes: fae8595505313 ("mm, swap: avoid reclaiming irrelevant swap cache=
")
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swapfile.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 4b8ab2cb49ca..4c63fc62f4cb 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -240,13 +240,13 @@ static int __try_to_reclaim_swap(struct swap_info=
_struct *si,
> >          * Offset could point to the middle of a large folio, or folio
> >          * may no longer point to the expected offset before it's locke=
d.
> >          */
> > -       entry =3D folio->swap;
> Nitpick:
> This and the following reuse the folio->swap dereference and
> swp_offset() many times.
> You can use some local variables to cache the value into a register
> and less function calls. I haven't looked into if the compiler will do
> the same expression elimination on this, a good compiler should. The
> following looks less busy and doesn't need the compiler to optimize it
> for you.
>
>            fe =3D folio->swap;
>            eoffset =3D swp_offset(fe);
>            if (offset < eoffset ) || offset >=3D eoffset + nr_pages) {
> ...
>            }
>            offset =3D eoffset;
>
> This might generate better code due to less function code. If the
> compiler does the perfect jobs the original code can generate the same
> optimized code as well.

Right, this part of the code will be gone soon so I think maybe better
to keep the change minimal, and it's not a hot path.

>
> > -       if (offset < swp_offset(entry) || offset >=3D swp_offset(entry)=
 + nr_pages) {
> > +       if (offset < swp_offset(folio->swap) ||
> > +           offset >=3D swp_offset(folio->swap) + nr_pages) {
> >                 folio_unlock(folio);
> >                 folio_put(folio);
> >                 goto again;
> >         }
> > -       offset =3D swp_offset(entry);
> > +       offset =3D swp_offset(folio->swap);
>
> So the first entry is only assigned once in the function and never change=
d?
>
> You can use const to declare it.

That's a very good point, thanks!

>
> Chris
>
> >
> >         need_reclaim =3D ((flags & TTRS_ANYWAY) ||
> >                         ((flags & TTRS_UNMAPPED) && !folio_mapped(folio=
)) ||
> > --
> > 2.51.0
> >
> >
>

