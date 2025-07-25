Return-Path: <linux-kernel+bounces-745936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CC8B120B0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236D11CE5356
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605D51A840A;
	Fri, 25 Jul 2025 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JJW325iU"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9D8635C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456593; cv=none; b=MDmcM4XWktSWwVgdkwz/ZjGyt9kBkiH7PSGb6K1eYDRhxHbJerrLdFU8WCcNfTelGCZGmw5JrRXOdB2JACjffxMH8xKwOtR4osGOP6k4NOopLwxh5c8PMcJKs4ieuNb62UYyc/9kIflZVzW175n+eCLhwmuS2CA8ulwbTm50+wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456593; c=relaxed/simple;
	bh=JxIY3J/UZY1H1QA5MLECobCDGYBYHke+Ej+Q9YT93Cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGjN96UJif1RqV1Yijdo/ubHD+SmWbV61P96sFZXm6wL4SFNT2fd6W6mx5+o+FftCqO8leP5W9116DyHB9KagNoCu3g1R/QDyIzkAAPUaTLRd/Oy/rFeCa6EwexE5mbFkN5J+kK82N5CAkkzJyv7vc4u6uX3iGTKz5IOYFsmPTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JJW325iU; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso11761a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753456590; x=1754061390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3aelP86DZFm0yFMte9irE1knJWouFsxwdQo+rhBPdA=;
        b=JJW325iUuBcOg55MFWVPMCMOCH6cgIu3crnatYZ/vSUzV+wCaWutZtELq9Rp1U+wKA
         dWVf5085oLQ+U7ocRvcnPMjGNHuFN+EgJ3EfNRbhEvdMxExJH8r8gYNs4WN5I4Nj4vQ2
         aJlL0Zp9DbVoPDmDPionPf5rro9pe4QbbZ0xhOWdNXw5kV6qVlY6w3hix86QZSDjCa5K
         teTtnGTjc4YwKLiihbhjQY4aQvHtNCz0ragC+26FDjnLz8mwyKh8/MUTt0fa7ubADq3D
         VFdH9/psDGIx/9UwWRZ/+WPPdGRcCigVh/PVUivmWam3gsNmei7XeqfWidYO2g/tLUVv
         2jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753456590; x=1754061390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3aelP86DZFm0yFMte9irE1knJWouFsxwdQo+rhBPdA=;
        b=dpRHXXfP8JXxjXQB98plrdKGB6jV+MkPwaiUF8PvDmctbWf6POaJSUvrh+qrQ+e8te
         +SXKCH+RBfo6rFfv+ObAWUrItl8NCU3J/wGA0UZr6Mzj/8iXXzpGyMb9K3yUsgmIDfbh
         WsGEtDoLO9ocMk8Yd4R0hWdkz0iIWU9c7kqiWe30oQFOLwKMlEEi0kNtL2qz4ydk1L/5
         lmXBsRdY4iZVi5x2zZWGIXAcvkWSVhB9XQTQ10HCAceL7RRkV9Zy3EXmx024/1RqhNfD
         ccBvAEb8Ccm4aIHlZVbWIAwt63VS26sFgC9p0yNHt70wzrc1dqPxQMauDrCbgJCNa0l0
         V3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUp77oEksTB5BVuop0z6mbuFh0Zvsu0ifcA7dwFeMKCoMZz7wnz7BXKciIiRxQRcVJi2xbi3wkIYWlH+sU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5fK728ZgmCDVBDZJcjbqOQp8FIq9gIQAbHI7JLcP8Ux1O3Ex6
	bCbRtPrNWGtQEEyrDb5B0myELdTYCdast59OfjFOAQTJ+5o2A+bT+XBsxoQL2160PhhHv91iLp/
	JHaXgoqOfAyP7jdm+daAS874+AFNmyv35a9kJe8kY
X-Gm-Gg: ASbGncsF6P0D32EuvGHiO809mmZ9j+Lq91s21V2jWwjjnYmHE1xiLt1JhFGMubHmoG1
	d5Ce3Rp9O3tsSiX8FAvxHSnKYqSB1jdhG0OruWfg+knT2Yz23unjyMNrInGXc/4zylYUtfRtsGq
	pQefSya6e8y5u5TB6pEVyATHqS6riSCMY/CEScwijsXFNAhQAaSxq8KVGxiqKzF5iyKj60BPiWs
	vjbpn66x1n/I1wZBkBIOWbwHHHNgb57LxY=
X-Google-Smtp-Source: AGHT+IG9EBGRShAtcrFGVkbd/pyc3jIAaBS2H/KKd7ti9iP9SAmV0nd+9NKXpwq273HHVXLDhMDwPDOw+NQ84WKh+3M=
X-Received: by 2002:a05:6402:3134:b0:609:99a7:efdb with SMTP id
 4fb4d7f45d1cf-614e6fe3361mr88105a12.2.1753456589881; Fri, 25 Jul 2025
 08:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com>
 <c3f04c75-a73b-48bb-b56e-7b18e57c2382@lucifer.local> <CAG48ez31aVnoBiMMjUczbmThWnRGmod4yppgMVqf2Nu5-hjU2g@mail.gmail.com>
 <50502c3b-903f-4018-b796-4a158f939593@lucifer.local> <CAG48ez1TOULrpJGsUYvRSsrdWBepCJf9jh-xPpurRUXbMmAkuA@mail.gmail.com>
 <3cfc1146-1b62-4b04-a2e5-997d10ba4124@lucifer.local>
In-Reply-To: <3cfc1146-1b62-4b04-a2e5-997d10ba4124@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 17:15:45 +0200
X-Gm-Features: Ac12FXzFQ6kL--SaRX25TSKqpOxK9bRnTErOgx7u8NlsTaYgrLohYP8OYTbs0Do
Message-ID: <CAG48ez3aiXUmCqu2i7g6qrnVmZ6PRUsA-rQzHX1r8SXeYh2sow@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: Add anon_vma lifetime debug check
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 5:07=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Fri, Jul 25, 2025 at 04:48:09PM +0200, Jann Horn wrote:
> > On Fri, Jul 25, 2025 at 3:49=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > On Fri, Jul 25, 2025 at 02:00:18PM +0200, Jann Horn wrote:
> > > > > We're sort of relying on this
> > > > >
> > > > > a. being a UAF
> > > > >
> > > > > b. the thing we're UAF-ing not either corrupting this field or (i=
f that
> > > > >     memory is actually reused as an anon_vma - I'm not familiar w=
ith slab
> > > > >     caches - so maybe it's quite likely - getting its refcount in=
cremented.
> > > >
> > > > KASAN sees the memory read I'm doing with this atomic_read(), so in
> > > > KASAN builds, if this is a UAF, it should trigger a KASAN splat
> > > > (modulo KASAN limitations around when UAF can be detected). Basical=
ly,
> > > > in KASAN builds, the actual explicit check I'm doing here is only
> > > > relevant if the object has not yet been freed. That's why I wrote t=
he
> > > > comment "Part of the purpose of the atomic_read() is to make KASAN
> > > > check that the anon_vma is still alive.".
> > >
> > > Hm, I'm confused, how can you detect a UAF if the object cannot yet b=
e
> > > freed? :P
> > >
> > > or would that be the case were it not an atomic_read()?
> > >
> > > I guess this permits this to be detected in a timely manner.
> >
> > If the anon_vma hasn't yet been freed, but its refcount is 0, then
> > that's still a bug because we rely on the anon_vma to have a nonzero
> > refcount as long as there are folios with a nonzero mapcount that are
> > tied to it, and it is likely to allow UAF at a later point.
>
> But how is this happening?
>
> The only places where we might explicitly manipulate anon_vma->refcount
> are:
>
> - anon_vma_ctor() -> set to 0 on construction used by slab.
> - folio_lock_anon_vma_read() / put_anon_vma() - both cases call
>   __put_anon_vma() when 0 to free the anon_vma.
>
> So how could we get to a refcount of 0 but the anon_vma still be hanging
> around, except if it's freshly allocated?

Due to SLAB_TYPESAFE_BY_RCU, the anon_vma is guaranteed to still be
accessible (possibly post-recycling) for an RCU grace period after its
refcount drops to zero. Under CONFIG_SLUB_RCU_DEBUG (which you need
for KASAN to catch UAF in such slabs semi-reliably), from KASAN's
perspective, the anon_vma is effectively freed after an RCU grace
period.

Basically CONFIG_SLUB_RCU_DEBUG turns kmem_cache_free() on
SLAB_TYPESAFE_BY_RCU slabs into something like kfree_rcu(), and this
allows KASAN to catch UAF access.

> It's surely only UAF?

I mean, "UAF" is kind of vague when talking about SLAB_TYPESAFE_BY_RCU
slabs. I am only using the term "UAF" when talking about a situation
where accessing the anon_vma object is entirely forbidden because an
RCU grace period has passed after it was "freed" with
kmem_cache_free().

