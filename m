Return-Path: <linux-kernel+bounces-806114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B9FB49212
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0B93ABF2B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9677A2FFDDB;
	Mon,  8 Sep 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKLkMpNM"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEFA12DDA1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343016; cv=none; b=LObmr/RCNDpAGC/rhuuZ3lnpHUWEWwkIsEJrsyMttLg8W2ddqnNEWlKL+psvxdA/gDmTN7PuBxy5V4s9mCe+LMeBuK+J7H6PZDViGRq5TiJ718NS26asrUhkPM6Aok+ERH0g3DoJApK/4ARyk7l9GwPf4LboPVuS7tECmI8YVpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343016; c=relaxed/simple;
	bh=gewFS51l8nN+fvzJRb4TLJwzgaGm5q/09cJq/bVbJJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrZnQlaq7ry0myCE19rtAWUeoHReho5DheR23Hhw78SudtWISYzXHLyE8EdPHnyntBeCWNwVPn4jHoORM4ab3waLNBkHMh0IlGizJrKR2faPdtbkpU3QV6HBl2ozu7zT9uIGNOxkE2Xf7jC8zjd6O2fCgdtpw769nZyyl2JtBQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKLkMpNM; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso1737963a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757343012; x=1757947812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBnBAzByhKHzc++vGzjU9VUoO8lmeANHV6T0Upv1VAY=;
        b=TKLkMpNMGNCSnGARLb+LHUxHRzbe/u71aBYypZnMflidtpVn8Oc3KykEHjv+By27BO
         dPo/iJSOJmH0eJxdA8y0ssHyTIGnaQmKnCjiYFOnXEwgtTETalisaqtCfuBJ/gUJImKc
         ZzAZfTNWoW2oSb+oILxGE6mXxmDZtJxKdFHlJ7BsfmaMGw+pRgsc+EA7/Hid1pmc/oZq
         /XauXMDGuNzNZrDM6WrUmjpMzgZ4WAALkD2PycRtLt0CpTZnsF+dBySr/Vl2Ysb+NAxZ
         6WddyRedwJdR/XHVJPUdIjATvQRpopnx9hUNtpYtQgcK1mirpYWNwIy8iMDDr/6U0+XF
         uCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757343013; x=1757947813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBnBAzByhKHzc++vGzjU9VUoO8lmeANHV6T0Upv1VAY=;
        b=p1kgRrn7HInX0F6wlA1RY/OPZaJ9DkHk5Zc/gTZSZkDg7Ca5BLmlY6R22yXmXYVWdM
         AjQgDxYf7QwWV4bHCXSyHFOOgDkPuzzgIKPRPrMJw4mC9i3cXOJxQJG+s3ydnaumTYuG
         IPvipZZuXm2UqEBSuCiHXqTSreWYhOYwEYXfMFr3N8RxB4vup1N6DXslHyHT+BIsHOz+
         OAS9zBhQ476o8NWVXGnkekHbTYE/dPmsBnoqGm0gokhuYNwcMkju7wH7FU4IWDj3Gz2t
         uMHpi2ffMHr5lNXIjaDp3n5810YSi1qvrX1HZwJT/Zjcup2TDTX2rxJph1vU87zZwino
         hFSw==
X-Forwarded-Encrypted: i=1; AJvYcCVWpgnJ0Ybh4gJSzni1SRM1f41BwyI3T1AfgU11IIkN28tIb0qllh+h0dL/g1gHxVMmDYkguFdp6KpIkeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlfFFiRFvTOWRHd4r3x9mMYvOHQU4zV0teg2ggUYcLe9wK1kJm
	Zdz+t/y2j30LZdSQ03q5TcBj/3sEl6U9kZLV3YR49qze2u4X6ceAJkVIVCItRzzY1B+JMVr78q2
	mod7yfM4KdakfCOOjk7+9cgasYWdX6ZE=
X-Gm-Gg: ASbGncs//e8jwQ0EsmZCCrtxHkN2AEu8VYpB35RgHCTKsTwz8b0g0+UTgQDB31bZsGL
	LkCykz2Qg0WmFMnqy5+dwNmX44NiNQc/ZfzdbnL2Sv+SM43ZS65hiwjY8Cg5JIZaCvzYbWyJOrT
	/2AFZSgSJu5Bm833OE92/461OltcCPEAXq7Wzlsq3t/B0dFuYWJ6ZqkpK522nM62V6XLy+B/ONl
	oLkaMeIQMVubkRQG3D1kg==
X-Google-Smtp-Source: AGHT+IHoCdMs3Rgdl4qcYf60aLmzGiOInPelzWXR6QdgP/GxD8XjaDfo7Lkz/WbYhPUj3aY2YwNFvuHZxaURYh+Mn6o=
X-Received: by 2002:a05:6402:278d:b0:626:59d6:36a8 with SMTP id
 4fb4d7f45d1cf-62659d63bf1mr5325649a12.10.1757343012341; Mon, 08 Sep 2025
 07:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-11-ryncsn@gmail.com>
 <c2ff433c-35d4-45e4-bf06-e725726fa515@redhat.com> <CAMgjq7AsYz+pDTCU5PWoNPN1VJ5Vx8ZLQgF6MT26JUSXr=6__A@mail.gmail.com>
 <9b4808cd-3239-4bb2-8073-7eb1412c4529@redhat.com>
In-Reply-To: <9b4808cd-3239-4bb2-8073-7eb1412c4529@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 8 Sep 2025 22:49:35 +0800
X-Gm-Features: AS18NWDTJApVExUbWOm3Uk5o3faBrft3HdzEwpOWLJ_Dud28dx1pmYwAgnZ0qk4
Message-ID: <CAMgjq7B5tm=cCPM6DrrjWS1tkpHDwmQueMKEBKz=br7xAgOgjw@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] mm, swap: wrap swap cache replacement with a helper
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:39=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 08.09.25 16:20, Kairui Song wrote:
> > On Mon, Sep 8, 2025 at 8:35=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >>
> >>>
> >>> +/**
> >>> + * __swap_cache_replace_folio - Replace a folio in the swap cache.
> >>> + * @mapping: Swap mapping address space.
> >>> + * @entry: The first swap entry that the new folio corresponds to.
> >>> + * @old: The old folio to be replaced.
> >>> + * @new: The new folio.
> >>> + *
> >>> + * Replace a existing folio in the swap cache with a new folio.
> >>> + *
> >>> + * Context: Caller must ensure both folios are locked, and lock the
> >>> + * swap address_space that holds the entries to be replaced.
> >>> + */
> >>> +void __swap_cache_replace_folio(struct address_space *mapping,
> >>> +                             swp_entry_t entry,
> >>> +                             struct folio *old, struct folio *new)
> >>
> >> Can't we just use "new->swap.val" directly and avoid passing in the
> >> entry, documenting that new->swap.val must be setup properly in advanc=
e?
> >
> > Thanks for the suggestion.
> >
> > I was thinking about the opposite. I think maybe it's better that the
> > caller never sets the new folio's entry value, so folio->swap is always
> > modified in mm/swap_state.c, and let __swap_cache_replace_folio set
> > new->swap, to make it easier to track the folio->swap
> > usage.
> >
> > This can be done easily for migration and shmem parts, the huge split
> > code will need a bit more cleanup.
>
> Right, but it's probably worth it.
>
> >
> > It's a trivial change I think. But letting __swap_cache_replace_folio
> > setup new's swap and flags may deduplicate some code. So I thought
> > maybe this can be better cleaned up later. So for now I just add a
> > debug check here that `entry =3D=3D new->swap`.
> >
> > And the debug check does imply that we can just drop the entry params
> > in this patch, there will be no feature change.
>
> Well, the current API as you introduce it here is confusing, as it's not
> clear who is supposed to initialize what.
>
> So better to it cleanly right from the start.
>
> >
> >> Similarly, can't we obtain "mapping" from new?
> >
> > This is doable. But this patch is only an intermediate patch, next
> > commit will let the pass in ci instead. Of course the `ci` can be
> > retrieved from `entry` directly too, but it's the caller's
> > responsibility to lock the `ci`, so passing in a locked ci explicitly
> > might be more intuitive? Also might save a tiny bit of CPU time from
> > recalculating and load the `ci`.
>
> Well, no other swap_cache_* functions consumes an address space, right?

Right. I can drop it in this patch.

>
> --
> Cheers
>
> David / dhildenb
>

