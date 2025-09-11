Return-Path: <linux-kernel+bounces-812915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0A4B53E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EEB2172569
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBA3286D71;
	Thu, 11 Sep 2025 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xWIpP9xk"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027AA24A063
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627499; cv=none; b=jmhQzYPb0ec0CfIa0KvYnaExCMl6hU7mQYhFYJq51w0UH5tYTG6OrySmPjV75VTto69aSaXwQJdab6I1fCzGd7CPB+4CcaMxC55dDZFlizQRGOuZPTkmCwnmXII5PepsmKq4mrnZykEzXBO+kATa1QmMkkgvKGwgQver8ARCReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627499; c=relaxed/simple;
	bh=Lkd9HrF1b+4mfTI1YOCZ2mACyXtFE/0MVQte2SFRQY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IvcBkNy1TCjRlSbNRJjD9feMxseaaDU+nQ83OySkFx6axfHQHZwrLPAM6pxfk670hRXk/iMbC4cdgEPrMMovR11f+24To9ePOAFeUTnXRHk0Q3GCYi6aoxknATr5Trt3hV//Z903fxSkvdE+4fjuTL6qSiHHDRmz6KLTYcFnaDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xWIpP9xk; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b5d6ce4ed7so159711cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757627497; x=1758232297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67rcoc0tiLSiwLVQ0lP6T2Ab+0hzeaK8IugOY+L2aq0=;
        b=xWIpP9xkxNRAzi0K1DxDejVdvGkdTCcwJV0de1cuk5nUO/LZKtptGOxF35JJXYiS73
         nFgfpgxI8FiPGnLQydRpw2+e9G8eBLCCwUXAfl5uWdvemiydXqBhBSU58LJCf+6EdR7w
         ak/30BR9FHfgvw7B7sr9ANnNigECoiQFV1a20ktE3njL0BhbBfQ3DPytV7F9l3EsJOCQ
         aoqXd2yLN5Wt0UGecQnFHlELrME50mTc7FgZZT3djZZ7nfMrKnWSgSyXjR7JI6rKqtr9
         fL6Q6yWjFlcNoJDJ4tC3JUkYUceZtwKzwCye9x+gZrDqj3DVnjnoDqew9/dz572WOkHK
         WHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757627497; x=1758232297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67rcoc0tiLSiwLVQ0lP6T2Ab+0hzeaK8IugOY+L2aq0=;
        b=Y+47dcKPpSfMzCoO5N+s13frOoYA4p2JjpcuP6dX0l5BWxLrTh6xMxXnzMECLNAWE/
         ORFFGvlapLz80liUikOrub1QGaV9en7MdCwOp+9No0+zV5oxbTwN6CRjRLC6VdiR6tVs
         IL536T9cTc2FzW52OqZPIfkfP2AhV9QzTBMm+rQmmC3nMLbD0PW38bRWal/z4mpeAiJ0
         NlP/um0oXeBYN/2DVktUHbd0MOwzxoad6l9D7AHL9cEG5dr7o3Gnn3oCdxaynC0Hd1xc
         MYBvzKCCpkFvoea0F7iHKDGVKkMyEu91Pbfnq9ydmTkJbWnngfGy2r3fXQfE+1t8C+9x
         vezg==
X-Forwarded-Encrypted: i=1; AJvYcCXNmIOwywE9+po4M1ChJg24ZNUJfNjSJqw3WLoP9sKDQ+qy9l2/D/SxE/pecjhqNN4TRuVoxvPkXEEY11M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbEd6+krsZIl3B6VhKWHYKAGAVBIqKzP2P+BizEsp2o2jJ3YDP
	1jf0Rg5kkjfbEGSZ6eJWFQUV/adQdPY/0DESfpoz8wKOX4OSu2bVbkGU4ld0W5Ac5c3WpidAYhP
	FaGFz11eiHJgNw9SR24hxsOpXSMzTy2WU0E4GYHan
X-Gm-Gg: ASbGncsUNwhHRm5Ryg2Jt7yNj8OGOpCEeXP86mDLtyvUOwogL96zqmFZ8eA8jf82kUc
	nPMmAg7t91mrqjKbCyHZG7bXuxw6pOQbHPvGdrVYO1u9DZL11hTwdVQXMlCvJExsO6h67GFk2Og
	e9Tsc6PhjGc8rPXPAFNWZAU7R93ILEYC5tzoAagMJeCVQo+TwZTZFRbV/NFMjYlDYf/safbqlPV
	eu4UFiVH2v90KIFR5FlEotRm1EE4WUW+fX50R4VfqjA
X-Google-Smtp-Source: AGHT+IFKCZ97d8yEAXy0IzqL/xIeSOsq8eTyCtL7p4R+IKNl+kbV2vPdoUW+XGceL7axm7TLgZ+JNFRKf5KyFaTuUv0=
X-Received: by 2002:a05:622a:c9:b0:4b3:4ed0:c6f6 with SMTP id
 d75a77b69052e-4b62522c93bmr17274971cf.16.1757627496389; Thu, 11 Sep 2025
 14:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909233409.1013367-1-surenb@google.com> <20250909233409.1013367-4-surenb@google.com>
 <zxbgiqf4d3nlww2xxoea7rud3q4oj2osk657xnhu6r7du4lf3p@es7mqt7joo7b>
 <CAJuCfpFV0d=JSwA8zDpdrg4C2TpTTZypeX0Qype-EFKHho2bQQ@mail.gmail.com> <yfebg4bs4nck7kvc3d3irbxpfja45pcyjbtip2jtcojiv5pj4f@jp53hiso6vga>
In-Reply-To: <yfebg4bs4nck7kvc3d3irbxpfja45pcyjbtip2jtcojiv5pj4f@jp53hiso6vga>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Sep 2025 14:51:25 -0700
X-Gm-Features: AS18NWAYJD7p3_wAWHt6t9BtXnrobKcobygiyfTNh5kX10qBbZB119SkJzlYs_E
Message-ID: <CAJuCfpEAfvFfFdNusJwPQGXM2sTMaB4RoEwjrUtwp1n3Afwk=Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] alloc_tag: avoid warnings when freeing non-compound
 "tail" pages
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	usamaarif642@gmail.com, 00107082@163.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 2:45=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Sep 11, 2025 at 01:12:11PM -0700, Suren Baghdasaryan wrote:
> > On Thu, Sep 11, 2025 at 1:01=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Tue, Sep 09, 2025 at 04:34:09PM -0700, Suren Baghdasaryan wrote:
> > > > When freeing "tail" pages of a non-compount high-order page, we pro=
perly
> > > > subtract the allocation tag counters, however later when these page=
s are
> > > > released, alloc_tag_sub() will issue warnings because tags for thes=
e pages
> > > > are NULL.
> > > > This issue was originally anticipated by Vlastimil in his review [1=
] and
> > > > then recently reported by David.
> > > > Prevent warnings by marking the tags empty.
> > > >
> > > > [1] https://lore.kernel.org/all/6db0f0c8-81cb-4d04-9560-ba73d63db4b=
8@suse.cz/
> > > >
> > > > Suggested-by: David Wang <00107082@163.com>
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  mm/page_alloc.c | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > > index 1760346bbd24..d21a411e807e 100644
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -5240,9 +5240,16 @@ static void ___free_pages(struct page *page,=
 unsigned int order,
> > > >               __free_frozen_pages(page, order, fpi_flags);
> > > >       else if (!head) {
> > > >               pgalloc_tag_sub_pages(tag, (1 << order) - 1);
> > > > -             while (order-- > 0)
> > > > +             while (order-- > 0) {
> > > > +                     /*
> > > > +                      * The "tail" pages of this non-compound high=
-order
> > > > +                      * page will have no code tags, so to avoid w=
arnings
> > > > +                      * mark them as empty.
> > > > +                      */
> > > > +                     clear_page_tag_ref(page + (1 << order));
> > >
> > > Do we need something similar for the release_pages() code path or is =
it
> > > happening already?
> >
> > Pages released with release_pages() should have valid tags, so I
> > expect no warnings.
> >
>
> Oh so this is orthogonal to your first patch which is replacing
> __free_page with release_pages(). This non-compound high-order page is
> not an issue in the codepath vm_module_tags_populate(), correct?

Yes, these are independent fixes.

