Return-Path: <linux-kernel+bounces-796612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C025FB403AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5D01B63AC7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7732877FC;
	Tue,  2 Sep 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkxM8Tdg"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7730BF54
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819687; cv=none; b=O86nAaCsoDrVAQc9V3si2cYU//BXbfyuyimXCEuXReljtYs0fIpOAFac8xGVAyyreUTc+lFA/YMkNc2Ec6mgzMjoEtakRb+r3Ul6N81EiRKZxgeIXpSiQ5r8aLJQpVZPVsqBaBtZyDrP9LVVWMslT1BBWpFCS072xarsYBjPAts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819687; c=relaxed/simple;
	bh=R2r/mpeKTSsbIAfnQRXWi3fdzeWa6D7xfutpiWD5Rhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0Y2W5Yim5SaoLMxCAQl8kVEz473MpQ1gmSJgyRqgRklAUI2v6cUQNZlIx6Aqu0GqgWL5JIxZv7Ei1bbQiRtcNKNTEQsqJ6ovRHiieawo4m3fj+D3gmHVQlsfqKTb0BH0ML9LVjJlD69yl9hCJlckSIrOR2sI0j0cRpjja924Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkxM8Tdg; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6188b6f501cso6222487a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756819684; x=1757424484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2r/mpeKTSsbIAfnQRXWi3fdzeWa6D7xfutpiWD5Rhs=;
        b=EkxM8TdgQoyc5y/DSQ6daJTJ4rc5YL3JpCSsM5EmFv2Qu0AfeLkZxVuYGdN7wpUntf
         qbYkRiTPoE1wTz2Ir1U3mmNy5oCPx4msLNbYj/LD/8qMDraTwSVP1JSGX7ffJkHDx1pN
         26wUpqZSt9LLyCvhITmAISt0+D2Ry8iMg2va/NZ0hEAdFlwB4u8OR7YW4E/KHEFL1E30
         2GAIsb6tZDLK7tqBTkA63NWmPyWPhwafXr6Z9/O+ixp2ZkAKV2flL5LLaa71EhtmVJkw
         EA+5/33fMOW9RS5haEHOcU6XowhWuJmJdEjSxuhJ5rBON0xXK+eSblg9xDdwFgtQvnq9
         OHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756819684; x=1757424484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2r/mpeKTSsbIAfnQRXWi3fdzeWa6D7xfutpiWD5Rhs=;
        b=IQi7UynX7VfS/zCNB7A5uvOfdXRVU8ifQ1kzYQ0Ndce6DNnKGYnuMWGC8WSkLaa+a6
         rocrCjCGpp9s0aRIu0/kGt+w/awCK/IwUnTu2/9AY8RMBUQ8orl7CgY1SXhiXpLBtM3X
         XMdmzv35FACZdlG42JgPsZW8f9G/plfi0cumETpJGSVHSiKl2TegOUATt9AAzx5uHbJB
         Rk4xaRbsPGtil3EjdZoy1zToteRfAXQH4b6uyE3g25yU6/oMkmn+itdata8VuVYxDxDh
         Cx74IZJmQI4+UhnUSIIbtIBfLrmcKtA/nZ2Nmt3QEqLrb/v4posH1cVWyz5Dg+fJJIWk
         Lmzg==
X-Forwarded-Encrypted: i=1; AJvYcCVJuF1ZP0z+QZ7gqy1mkXExG+P1e30FDeXodX0gcLho+6+AZdtZaIC44fHpuBqnVbZCylQeGkWaYaNXdcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynzY++Z60WDXjMiC8cekYjOiKCsbThchxpPTyjpp4WCvQc3mnT
	q1bA/cwap0btuGmBQXmlypc6GZGW4LHKSfQ3zHitqIQNH77HFcMCQTEf+/ewhgCn83HRbcj+6I3
	Bla4LTBxxoBgzeurqnVTgdKlIBEWRG54=
X-Gm-Gg: ASbGncsQtyu8N0dsXaUP70B58lWAwJXS7T6yX4SAmqtIidnMhEAytzM5yf1ZvTh4E9s
	YS7hvd4Krrp0PsjSMR7RW36slzsgJazYoV0MjbhjXh3hdrjczKQ8QveEUb+wgpplmWlU0eJR68e
	deflcCp/QbboR7ecZxnVzNZv7VzBkIXFuquPfujuyWXrrM/aNeOUvAN5WihtCwc1zV7R94O8Bb5
	so55wVko6JRPE5Homq1xA==
X-Google-Smtp-Source: AGHT+IG8WM3LN3n+vs8UfaZfhyKrh9NOM79dhQApSdhBW99EaIXb2eKvjvaDXdwBWeu8xJOM+PNHoMyKJvxujvcsD7k=
X-Received: by 2002:a05:6402:3589:b0:61e:9307:702b with SMTP id
 4fb4d7f45d1cf-61e93077153mr7144821a12.9.1756819683920; Tue, 02 Sep 2025
 06:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-3-ryncsn@gmail.com>
 <911dc3b4-c511-4ef2-a159-091780987965@redhat.com> <CACePvbXs3J6qYWFycVW8rGjiaOw9iTFLdWq1Lq4HyaDkSY45uA@mail.gmail.com>
In-Reply-To: <CACePvbXs3J6qYWFycVW8rGjiaOw9iTFLdWq1Lq4HyaDkSY45uA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 2 Sep 2025 21:27:27 +0800
X-Gm-Features: Ac12FXyXH_eAyWYE5C0gX0GODJQwF_Wg6FYFg7CcBoXlApyBiT4JHidtNY6X7ho
Message-ID: <CAMgjq7BPUE_+AhF_Nm98k6hbVPpLkQcwPGGMqA3yZuKmMR6xZw@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm, swap: always lock and check the swap cache folio
 before use
To: Chris Li <chrisl@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Nhat Pham <nphamcs@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 9:03=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Sep 2, 2025 at 3:18=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 22.08.25 21:20, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > Swap cache lookup is lockless, it only increases the reference count
> > > of the returned folio. That's not enough to ensure a folio is stable =
in
> > > the swap cache, so the folio could be removed from the swap cache at =
any
> > > time. The caller always has to lock and check the folio before use.
> > >
> > > Document this as a comment, and introduce a helper for swap cache fol=
io
> > > verification with proper sanity checks.
> > >
> > > Also, sanitize all current users to use this convention, and use the =
new
> > > helper when possible for easier debugging. Some existing callers won'=
t
> > > cause any major problem right now, only trivial issues like incorrect
> > > readahead statistic (swapin) or wasted loop (swapoff). It's better to
> > > always follow this convention to make things robust.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> >
> > [...]
> >
> > > +/**
> > > + * folio_contains_swap - Does this folio contain this swap entry?
> > > + * @folio: The folio.
> > > + * @entry: The swap entry to check against.
> > > + *
> > > + * Swap version of folio_contains()
> > > + *
> > > + * Context: The caller should have the folio locked to ensure
> > > + * nothing will move it out of the swap cache.
> > > + * Return: true or false.
> > > + */
> >
> > I appreciate the kerneldoc.
> >
> > Intuitively, this should be called "..._swap_entry".
> >
> > But I wonder if "contains" is really the right term to use here. It's
> > more like that a swap entry "belongs to" (was assigned to) a folio, rig=
ht?
>
> Right, in the other design doc I use the word "binding" for the
> relationship between folio and swap entry. As if it is a binding
> contract, your folio data goes and only goes here. There is no owning
> relationship. Other folios might want to compete and win over the
> binding contract as well (the race in swap in).
>
> > Sure, we store the information in the folio, but the "contains" is a bi=
t
> > weird.
> >
> > folio_matches_swp_entry() maybe?
>
> Yes, I like the name folio_match_swap_entry() you suggested in the
> other email as well.

I like this name too. The `folio_contains_swap` name comes from
`folio_contains` as it's just like a swap version of it. But I also
found the name a bit strange as they are different things, but had no
better idea. Thanks for the suggestion.

>
> Chris
>

