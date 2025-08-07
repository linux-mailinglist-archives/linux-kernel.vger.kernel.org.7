Return-Path: <linux-kernel+bounces-759396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C2BB1DCFC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189561886119
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C1D270EDF;
	Thu,  7 Aug 2025 18:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeWljBW9"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA626A1AC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591065; cv=none; b=qt0FAVWFXR/M6yC5+oYSnC2WbEntJ7nNoOVQs8mffzLAKr0OKIN8wJrGjVZKE20OyiOxosS12X3ouV3mk+sv9bUDQ88QScxmpgFQn/HAmgxTRgtrbY7kVi8M5KpcLuohqAH907WTzXtsA1rQi177wSnWybwfSjz6oKM46WM9eUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591065; c=relaxed/simple;
	bh=2js3pLbVOnul00oAx+TqpzhRf2XyA+E/3xngyzZYITM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFRNJP7OVbxb9T3/DRQzjdhLHSxTx1ne+6KjZizYg+yjwq5dfmtnGh89NOEmngGxNmkfZ6E5iKP0386Uh38/23LHJoXBoQafCUibD0uU8hHVrgnXDGShvfZhVVamZFzq2mmgDnRQa0PlLC1RYXhDZ2Bf8byhJ8jmU4zFaFyT2zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeWljBW9; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8818a5ba63fso38376539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754591063; x=1755195863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNuzWmTNPffaFCHaXEeQ0GR/T7nQZcXvwlguy7B/4dM=;
        b=MeWljBW99ciy7wFj7gt7b84mAPKPzI11xLSM3k4ew84FpH0IE+PgOqXYbEi4O0F3w1
         9C0QEBpAYr3KY9yVIU5oNig2shlDka52nYHsQk7Wq+XGyRVzejxltCuFlAIoFbBljBqE
         Muj3YP4HPvnz2uqUhHr1Pa6tZV8uBbgXPeHr6FmC9y1OX6uYPqkfxhPRLer7z419yYHW
         1H7/zOa8pF9B8EqNtM3/spKJyJJBdytD5vdfzIdYYg9oES6o6I424UXwNZ1T2He8zy+4
         c+wlRqTbiTGMDN4h0xdd5r9XbihnrL3lxlkqJrJP/C+UheaU6Es2d9JpWhsEB1S7X6XL
         eEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754591063; x=1755195863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNuzWmTNPffaFCHaXEeQ0GR/T7nQZcXvwlguy7B/4dM=;
        b=tmDXiyuuQ/0+oI3edc+iYBy67nsDynKJQL2ahc10v1i7XcLTtBUrqZtWkikODFTB7U
         4iQ8V8J31mHeJkSa3EvoGaPo5rP96Cdq4dTbxBV6qcFBx1Q2JaH4kiUIzxuxr3M0mqc4
         tm67f3a4zfNIXudObUZExZtFJKfLYwwnSARBu8c2Iny/wrDdMfWkZwhby9KzKRyi1rl/
         XQB1VKDi/V3QssilprJ6Rfto+pvTq0z3GdlZg0KhCncCzoClqKVxdAVh5L5/omFYFzu9
         3C8ZIw9jdwbMOZxyz3oxm7RkyCDtXpuJwEGhysNcPqDJmBwD+HrNvgkFHS4RH9HlMiPj
         SW4g==
X-Forwarded-Encrypted: i=1; AJvYcCVizb0+hIyLAJZl9bJF6juX7pXjj9MLObE6rVKhJQ7ItROxp52O+mQ/mjV/A1t80+vqtn1AnjJSSD3SjN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY8OHfiLpEYBI8izWtI29Ke2j2pYyE0cK/YuSH/gnoMTOA3fxf
	+lyWN0hn3udYt6aOwJX4tnXGLeZW9rxX0j2H9MgbxMz6MEzpAl9jrqWJ75oIOJtLoMBaytdwsC8
	6eWzkFZTkKABUdws0XcYgrxoEMjUHGDQ=
X-Gm-Gg: ASbGncu0qgDIUDpnv7ObtttiyzlF4QdsZPGt3T6FEvYki4lUf5uLMte1u/7uxrA1i5l
	yA1WLm+xSMAlrsSdbyHVvC0QEuahDzfvxav0uqYlct6zmB4X4cnvrHZ7He3SMP0X1HHO9mOlyup
	VcrUcZj+kpsr3SJ+JS+/j7l8rpGvPpuqWnij/e/XBb3ukUwjq4vmlJPYkaIbn6EiILET6pP1t9U
	FFXgK1zLlKiXFoxYA==
X-Google-Smtp-Source: AGHT+IHDtBVpeNVW47eT+EtH0KXWBMHn8A3N/MioH4ziUa6CKaP1TmvVbhFwJqCtq97d1u9GWnhfVRaRyjGhmkj4DYA=
X-Received: by 2002:a05:6e02:178f:b0:3e3:fe52:e576 with SMTP id
 e9e14a558f8ab-3e5330d9169mr2324415ab.9.1754591062511; Thu, 07 Aug 2025
 11:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807152720.62032-1-ryncsn@gmail.com> <20250807152720.62032-2-ryncsn@gmail.com>
 <CAKEwX=P8Qh4mOdv68UfXv-YBSnuZJkhEeuRJezZucbX7sysWvg@mail.gmail.com>
In-Reply-To: <CAKEwX=P8Qh4mOdv68UfXv-YBSnuZJkhEeuRJezZucbX7sysWvg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 8 Aug 2025 02:23:43 +0800
X-Gm-Features: Ac12FXwPvhPQJSzfZunKBjvVg2gy2SZePr5hJx--Wv6DiFAlNkDn_0ZycFRYpjs
Message-ID: <CAMgjq7CRdX3vpphUboHruO3wxRhph6SsPmBXnjtHuc4nzRczsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] mm/mincore, swap: consolidate swap cache checking
 for mincore
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Kemeng Shi <shikemeng@huaweicloud.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 2:07=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Thu, Aug 7, 2025 at 8:27=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > The filemap_get_incore_folio (previously find_get_incore_page) helper
> > was introduced by commit 61ef18655704 ("mm: factor find_get_incore_page
> > out of mincore_page") to be used by later commit f5df8635c5a3 ("mm: use
> > find_get_incore_page in memcontrol"), so memory cgroup charge move code
> > can be simplified.
> >
> > But commit 6b611388b626 ("memcg-v1: remove charge move code") removed
> > that user completely, it's only used by mincore now.
> >
> > So this commit basically reverts commit 61ef18655704 ("mm: factor
> > find_get_incore_page out of mincore_page"). Move it back to mincore sid=
e
> > to simplify the code.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> Seems reasonable to me for the most part - just a couple of questions bel=
ow.
>
> > ---
> >  mm/mincore.c    | 29 +++++++++++++++++++++++++++--
> >  mm/swap.h       | 10 ----------
> >  mm/swap_state.c | 38 --------------------------------------
> >  3 files changed, 27 insertions(+), 50 deletions(-)
> >
> > diff --git a/mm/mincore.c b/mm/mincore.c
> > index 10dabefc3acc..f0d3c9419e58 100644
> > --- a/mm/mincore.c
> > +++ b/mm/mincore.c
> > @@ -64,8 +64,33 @@ static unsigned char mincore_page(struct address_spa=
ce *mapping, pgoff_t index)
> >          * any other file mapping (ie. marked !present and faulted in w=
ith
> >          * tmpfs's .fault). So swapped out tmpfs mappings are tested he=
re.
> >          */
> > -       folio =3D filemap_get_incore_folio(mapping, index);
> > -       if (!IS_ERR(folio)) {
> > +       if (IS_ENABLED(CONFIG_SWAP) && shmem_mapping(mapping)) {
>
> Do we need CONFIG_SWAP check here? I suppose if !CONFIG_SWAP we'll
> never end up with an ordinary swap entry stored here right?

Yes, and in the next patch I'd like to introduce a WARN_ON if we see
swap entries with !CONFIG_SWAP. That means the memory is corrupted.

>
> Saves a couple of cycles, I suppose. No strong opinions.

Before 61ef18655704 it used a `#ifdef CONFIG_SWAP`, I used
IS_ENABLED(CONFIG_SWAP) here, same thing, the compiler will optimize
out the unused branch. Just with fewer lines of code and I personally
think this looks prettier.

>
> > +               folio =3D filemap_get_entry(mapping, index);
> > +               /*
> > +                * shmem/tmpfs may return swap: account for swapcache
> > +                * page too.
> > +                */
> > +               if (xa_is_value(folio)) {
> > +                       struct swap_info_struct *si;
> > +                       swp_entry_t swp =3D radix_to_swp_entry(folio);
> > +                       /* There might be swapin error entries in shmem=
 mapping. */
> > +                       if (non_swap_entry(swp))
> > +                               return 0;
> > +                       /* Prevent swap device to being swapoff under u=
s */
> > +                       si =3D get_swap_device(swp);
> > +                       if (si) {
> > +                               folio =3D filemap_get_folio(swap_addres=
s_space(swp),
> > +                                                         swap_cache_in=
dex(swp));
> > +                               put_swap_device(si);
> > +                       } else {
> > +                               return 0;
> > +                       }
> > +               }
> > +       } else {
> > +               folio =3D filemap_get_folio(mapping, index);
> > +       }
> > +
> > +       if (folio) {
>
> Should this check be "if (!IS_ERR(folio))"? Seems like that's how we
> inspect the output of filemap_get_folio() in other locations (for e.g,
> in filemap_fault()).

Yeah you are right, actuall should be IS_ERR_OR_NULL here as it uses
both filemap_get_entry and filemap_get_folio.
I wanted to change to always use filemap_get_entry in the next patch
for better performance, but somehow forgot it...
Will fix it.

>
> >                 present =3D folio_test_uptodate(folio);
> >                 folio_put(folio);
> >         }
>

