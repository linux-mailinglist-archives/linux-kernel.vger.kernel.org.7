Return-Path: <linux-kernel+bounces-817439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D155B58231
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46FF47AB45D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364A27877D;
	Mon, 15 Sep 2025 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrUNDXkf"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9432C181
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954135; cv=none; b=m9vlaW1COhcFGnqQz4yjvRvhCsFIczFANiBMLPHlv1Gjv3Hlhvp3Cwx4oKBEyXKfGA/lVvSjM+/gxSwchgZU9kJ1LL/D9BGmK2mWHEKj3rsfOalQtTe7hO2POaNeexcIh2up4zvk2OObCg+s9QROJuqGMtDT0tV2STKuUV7kBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954135; c=relaxed/simple;
	bh=RSowVsNl4N7b4FPmTKveKQTcAcSzfTApfhJeIzxm5R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYjQzEMpxduJjsw+cVj9ESNDFjIc8h8pZD9OEOmw0fTD99oAToOw1QxJTSTEIQ2ZPeX2BaLi6E1Noz+SzMJK6W3/P2i3tCjf9kBop7oWUkPwMgc9cukRo+yW7Oflcrbx+gZa2b1QQc+KzOP5cGhC+YJ4uaORInYhlrHn0Aq/fZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrUNDXkf; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so323493a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757954132; x=1758558932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaS+4e9CD9qq/qcfYA/NkZS+Q4I1Jtxyn3M0VBK+Z8M=;
        b=YrUNDXkfKC366UsvjM/z5RPUeZub0UmAOdDoJPFnhP0m0M7rxTEbFyakZGB/MO+blZ
         xFAEBwcLfK9J/gtLj/B3oR12+lQW0fglfVqNXNcMFYXBaH2yM5FuyFKCouHa3J3cDhSe
         piSJibqmrOpv3naZlNAfZVSRJ+yJSj/uabh2Xa/zuzUzlN/lQpnPudx9vSjdpuRQlKKk
         +RSQGt1ZXUzHyUt7iiqgqsDzcXHA6YMJWMT9GzVhL2qcoxYtEM97H4T62tU50xqPBSuB
         r+JGAw5YTwaggTX+oEpNqsjtMgvcd1jcZggA5X4MQxkKlED73xKf3FE69tIydERDjHo1
         GfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954132; x=1758558932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaS+4e9CD9qq/qcfYA/NkZS+Q4I1Jtxyn3M0VBK+Z8M=;
        b=hI8GMbeid8dZBUCYq9kBoRv+rhhI/qVJhP1DGM8+m02zNIE9HWH9bRqerkRoloujzj
         bGhcrHEbQ3X9knyYrdSXTf3t+2DIYv0MKQyC8XQxnlabyYgx/d747mU7jkMRFkPSoCV0
         VBWgA//6OqLfv/RiOAf8fsUHbsl0obVWkB62CMfZhUm7iKkOEFYPhqUppWqwskZq9Bli
         m+1p3Gry3n94MsaWIheDuaem8iFpC5BtsqRBdnZKuCgx1EnpPTOTmX5WkzRat+jY80XK
         O2xMdLHO1QnrU12BKeS//YxHYgs0o0w+KOybJj2cSCvqCMoWY6WIyHmdvYhsJvEfSwQ6
         W+EA==
X-Forwarded-Encrypted: i=1; AJvYcCXB2CLNLGDJet8XddbfdBsbBSa7cNv99htTkuGBgCcjRUpMNef9gG4/HZM09u747uODE0y6oS0UczPQ7bs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9dv1L5KFwDufqHy14QzuH5/lv0xPBoWIWV/fd0R8h0MnSNF8o
	IWdGhv3gHXXOq341GGASIlEblc0O3gKWiS1h98NpVqiMKZtgVPuGLLjAM1CVeg1Z2nHPIpnfPVF
	0ssHfS2pJ1rg9nXWd7gNe4aFKS5PzKv8=
X-Gm-Gg: ASbGncsaNRqvpnug2ZnKH+laludHwjoPFmaXU6pqRuRoIeztFoW7l5GRyudGu2TrNj1
	uWXbt6t7tIgY8MPz5+9SStOp4xq4rdoHN7RpuwKsp5AXpSBW1vk1gYvFEgqBYAH6KUaBsM5RBtc
	npOGvUybIJ/S7pJhOoHpx8w/vPGjTJOd4UC8kqkT1wZneHZ8wWabN5Q+R9hp3wBn+Y/jvyPR6J9
	M10NAmpLzuDkEenJVPalg==
X-Google-Smtp-Source: AGHT+IHVXEBwPC51SnFdwQUYw9y7HhXwNvoyENyaB1Bz3o6IJeGXsQsiMQQNhelK9xiWwWQe8BzplsMVrUd6qgL2l6M=
X-Received: by 2002:a05:6402:1e93:b0:62e:dd2b:b700 with SMTP id
 4fb4d7f45d1cf-62edd2bb931mr11812400a12.2.1757954131625; Mon, 15 Sep 2025
 09:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910160833.3464-1-ryncsn@gmail.com> <20250910160833.3464-6-ryncsn@gmail.com>
 <CACePvbX4juhR5jry0Bi202qo=nfFVZkztHzo8KxKMW_yKBseyA@mail.gmail.com>
In-Reply-To: <CACePvbX4juhR5jry0Bi202qo=nfFVZkztHzo8KxKMW_yKBseyA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 16 Sep 2025 00:34:55 +0800
X-Gm-Features: AS18NWDf-XutQXVyGUmemggoHy9lplrAX8RvyMvG0-69Mvw2smNEDJTjC4BRwgY
Message-ID: <CAMgjq7Cddet5BQorsc5gaLbNKJrZhCwi5qifpHz=sd6gb9dQ8g@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] mm, swap: always lock and check the swap cache
 folio before use
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

On Mon, Sep 15, 2025 at 11:07=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Wed, Sep 10, 2025 at 9:09=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> > @@ -2004,6 +2002,13 @@ static int unuse_pte(struct vm_area_struct *vma,=
 pmd_t *pmd,
> >         bool hwpoisoned =3D false;
> >         int ret =3D 1;
> >
> > +       /*
> > +        * If the folio is removed from swap cache by others, continue =
to
> > +        * unuse other PTEs. try_to_unuse may try again if we missed th=
is one.
> > +        */
>
> It took me a while to figure out why we add a
> folio_matches_swap_entry() check here but we don't have an existing
> check for folio swap entry matching in this function. Can you confirm
> that if a race has happened causing the folio swap entry mismatch,
> then try_to_usue() MUST try again rather than "may" try again. It
> seems to me that it is a MUST rather than "may". I am curious in what
> condition the mismatch happens and the try_to_unuse() does not need to
> try again.

It depends, I think it may, because: for example here we are unusing
folio A with entry S1, and a raced process just swapin folio A then
remove it from swap cache. If the raced process didn't swapout the PTE
again, then there is no need to retry as we are dong with this PTE.

There are many races, someone else swapped out folio A again using S2.
Then here we will see a !folio_matches_swap_entry. And that's OK.

But there have been many other subtle race conditions in other places,
e.g. another folio occupied the same PTE and got swapped out using S1,
causing PTE =3D=3D S1 and here got a wrong folio A installed. This isn't
happening here, because we have removed the !SWP_WRITEOK flag from the
si during swapoff...

It's really complex and fragile, so just make it easier, check
folio_matches_swap_entry and abort early, is safer and follows the
convention.

> BTW, this function has three types of return value, 1, 0, and negative
> for error. The 0 and 1 are ignored by the caller, the caller only
> cares about the negative value. Overall this unuse_pte() and
> try_to_unuse() walk feels complicated and maybe a candidate for later
> clean up. That is not your patch's fault. I am not requesting a
> cleanup in this series.

Right, totally agree, we can cleanup the swapoff part later.

> With that Nitpick,
>
> Acked-by: Chris Li <chrisl@kernel.org>

Thanks!

