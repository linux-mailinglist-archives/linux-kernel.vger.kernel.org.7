Return-Path: <linux-kernel+bounces-812807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE991B53CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F6358576B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FDB25C822;
	Thu, 11 Sep 2025 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KomZQJ3m"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E30255F31
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621545; cv=none; b=sgiXFifj639+Gr/F5VvpznK6UHtrgvNvGZvNo1sGgf/xMcKb4h5zx7UaE7vl/tGe9HuKzwbRDQ6sPlQedv+N/F6u73d4xwirjBkELgOrUA7a8K4X4jAd2yUrUHq8xs5DGvJuZpZNG7eGX+iHRAPH/NDxOPgbpSzrDFupj2K2/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621545; c=relaxed/simple;
	bh=NCtK+aYmXlXSg2Je3kW1irq4q781LjfFlNOUufjJH7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcvyB/xCw18BJoPRe9A5Iok2HTa2MW1EAgpcuwnkaWvfTfHDTUGXsgQRVncEBmmBFHK01TM4992iNdxYLkC0hsdzRxiTxlCOtrd4767IvNdcCSmdDyt3DQQ1BClKqFJI+F402X4FuPhwP3bNEUaoDTOBE+cdCkHNuQ0/zRNK2to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KomZQJ3m; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b4bcb9638aso146771cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757621542; x=1758226342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcZCQAonckCrUKPKm4x0besmYoVyv0nDELZzfCiKfPA=;
        b=KomZQJ3mV6ccZvQ7KSpRwe7tgccQbtiXWkUcK0TdYzF23aTidxyNS5J+QA03neiCia
         Nfudb7J6zDEoPqfRWfzoRFBz5Cg2LqUlSvQZzfk/9O2UWlaLRtORUZfIkV/rKECBnFdk
         8v5KhALT9jM/RrBdk/FGKAVGutVzCkLHRsLmLdSNjuVLnmxS55F4Icz02ud/yPtEFNwc
         s5LqWcBsm2ct3Hu3M3t5sRUlHIwgStCHHEEPVJkYnZ31rQR1E/TKRJ0Z8h+5WvreOnU3
         oroZpEJ9v/Ys+HdMsa9jD3wWW2VYsiQD7hvCqlr1eCb2kJPHVs9mS8OtxYMjRNzaH1qA
         ucKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757621542; x=1758226342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcZCQAonckCrUKPKm4x0besmYoVyv0nDELZzfCiKfPA=;
        b=MbngF1H3RTmZ8Vzo34yeL1U3sKkVbkLcU8XfJlJZuFDyRWapsyP32PJTbvWY6gKfx/
         Gujfrs0CLtUgjSa6oBwdaAJETqkI43eTff3CYGtcd9r1QfQe2cilj5NKZwFNHVuXN4Ak
         oNpn7jYWWSoH5ydC+vK+cf9i2B+Hf4+TMEzBEq+n3b/+sCcOwJIItuKK1dzlekaF5zJE
         w5qQQTSDWqmRYmQ3a/faMFTGgHpsUHVdJR6rMVRO9UiddEEBTD2VuL3TVf0Y6eB+d786
         T5dPh2kSBEz9eEbjKOYj/gtgc4Gg04uoqDbQBIZLeqvVn9++q/vZwcQk3vqNNZZCMAV5
         hVEA==
X-Forwarded-Encrypted: i=1; AJvYcCXq9s9/EgOaIoyu2AHrU5nNzkiJJj85r3B3UyOJ74n6TH52DmooSmkhQCDjhUPj0pXASqzcghOEeSF3Xx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSzKPr+BaQ1XiUrz1+M8avy5EavMM2NR/HMtM0BJdF3bCobfSQ
	QOPFeGfoo0Pu3DGKunjVm4sm7susaQFSEemi/kRDG+CGNMBX+pjiAc1dPE8XUV/aELzCAQVae3c
	fGRB0cBXCBrNQ2mWqFwRyzh8azRuq0vXCNspC/dvy
X-Gm-Gg: ASbGncuyjJkBfajqdyS/2OI0L1ktCQdNiNUB3pfR3+nt33km8tGe3DSfJpiapiPaHpT
	cZ8ttjCI3gXQ4qVMdGG9BuWLTSvZU4PkublbmF4UCPFZJpnaMYaxz1Q2d0+Vd5dbm0RmPg3sulk
	AMkEgpHJkLdXMuzYrktD//QNoGcYgMmuVsUTUNBuW4DnrFpbuDSgGfWrKkuJ56h98En2nqs8glz
	hUWtOb0TFvXfxeuNS0H+fJOEIX8hkOJslUXKUzRiZcC
X-Google-Smtp-Source: AGHT+IFwYG+oXNRCy8GEbBjKw5plhsNBK2EMVusWy6/CWD8cxMIvggWuNYsOlNkHxqipGFQAF+JfnH7EHJbUsSVWNCs=
X-Received: by 2002:ac8:7f04:0:b0:4b3:509b:8031 with SMTP id
 d75a77b69052e-4b626ecdc80mr14570821cf.13.1757621542016; Thu, 11 Sep 2025
 13:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909233409.1013367-1-surenb@google.com> <20250909233409.1013367-4-surenb@google.com>
 <zxbgiqf4d3nlww2xxoea7rud3q4oj2osk657xnhu6r7du4lf3p@es7mqt7joo7b>
In-Reply-To: <zxbgiqf4d3nlww2xxoea7rud3q4oj2osk657xnhu6r7du4lf3p@es7mqt7joo7b>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Sep 2025 13:12:11 -0700
X-Gm-Features: AS18NWAsvUZp8hHhTH4zlA907OSikwteEZk4N0sF9oy4TY-FkBF6EehF-T2LNl0
Message-ID: <CAJuCfpFV0d=JSwA8zDpdrg4C2TpTTZypeX0Qype-EFKHho2bQQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] alloc_tag: avoid warnings when freeing non-compound
 "tail" pages
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	usamaarif642@gmail.com, 00107082@163.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 1:01=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Tue, Sep 09, 2025 at 04:34:09PM -0700, Suren Baghdasaryan wrote:
> > When freeing "tail" pages of a non-compount high-order page, we properl=
y
> > subtract the allocation tag counters, however later when these pages ar=
e
> > released, alloc_tag_sub() will issue warnings because tags for these pa=
ges
> > are NULL.
> > This issue was originally anticipated by Vlastimil in his review [1] an=
d
> > then recently reported by David.
> > Prevent warnings by marking the tags empty.
> >
> > [1] https://lore.kernel.org/all/6db0f0c8-81cb-4d04-9560-ba73d63db4b8@su=
se.cz/
> >
> > Suggested-by: David Wang <00107082@163.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/page_alloc.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 1760346bbd24..d21a411e807e 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5240,9 +5240,16 @@ static void ___free_pages(struct page *page, uns=
igned int order,
> >               __free_frozen_pages(page, order, fpi_flags);
> >       else if (!head) {
> >               pgalloc_tag_sub_pages(tag, (1 << order) - 1);
> > -             while (order-- > 0)
> > +             while (order-- > 0) {
> > +                     /*
> > +                      * The "tail" pages of this non-compound high-ord=
er
> > +                      * page will have no code tags, so to avoid warni=
ngs
> > +                      * mark them as empty.
> > +                      */
> > +                     clear_page_tag_ref(page + (1 << order));
>
> Do we need something similar for the release_pages() code path or is it
> happening already?

Pages released with release_pages() should have valid tags, so I
expect no warnings.

>
> >                       __free_frozen_pages(page + (1 << order), order,
> >                                           fpi_flags);
> > +             }
> >       }
> >  }
> >
> > --
> > 2.51.0.384.g4c02a37b29-goog
> >
>

