Return-Path: <linux-kernel+bounces-854894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BFABDFB39
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0718D3B39C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B72E338F4B;
	Wed, 15 Oct 2025 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AjrJX9q5"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343A28D8DA
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546361; cv=none; b=HopU4bLL1vDiaaJZjtf1kwJoD3ik7FRNd8Isqgbssq+1B0x2y/quJQVd+zIHnfw3qUiHzG/Ib+BUhe57YA/UQt9Ug06qSCcByMf6mLSA+/LWIXIXK02waZja6tqUcwvnjGVqPSTN0uTn5YwIxnzcyZdDPjwsukfwb+4pZ2xKL3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546361; c=relaxed/simple;
	bh=XqB6na94/mJ0K/OgZi4TZF9h11JKDuGh6I2jheNoFF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9Gfcap5e1OrqlyvChBsGo0nXEO6xlh4PPLe0T/h9OOXEEpGggZ/f7/eZo6vsmhSJ0vGROdolf6al/wbnMfzJXz2S8OFyvDmtkmL1GPz854hKn3GaZtvKjFafKgafUP4WGVK4j31wqpYYXrxRhLQ11RYouQxPHDVwwOw48UKM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AjrJX9q5; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-634cc96ccaeso10306a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760546357; x=1761151157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzhM5CGB+RoDFW8y/0jUZz7oHPU/o/zMoGAuCJ5t4mg=;
        b=AjrJX9q56DrwDqINUhv9JXvl0DG4lhaE87MOvGDP3UBT4PWbbytMdKEVFxdHRMxzfX
         vwDiHPY/NS2QGIdAfl0jntd0bDacMId8coqk8o3jy4bS68VAGnEx9v//dNCAVtFL7YJG
         QJ4jOxGqnV84ZZa16IPB1n8mZNQwNDn9uilABWbrgxnUFKa6UOoOdvKh9bbW6dcNg+Q5
         FSOSx1X8ehgEDA12EsZ0DsHZQ7m7taIm9dxCkck1NHZFxIqhiq+CtPDoFKIEejTXvTvs
         tlkRRl1nBxys3Th9hWpiGKVauoMghPpOZybJ4Tl/sE1zlwUcgpU+VgXj095NEPS7T1gd
         mqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760546357; x=1761151157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzhM5CGB+RoDFW8y/0jUZz7oHPU/o/zMoGAuCJ5t4mg=;
        b=fC2kcF/cvU5H5dgHLGFDASLOXsAbm1wL7EjxaAwaFeAZKmCqOM1zz4YtsVAyXL44Sl
         z9DR+tRDYgK0n0m9PfhPFkCZS/2MLMAQWQByuKNM4fFdsIaXWkMKrGUqWJ0f01dO8QLB
         NjH+KLKzuF2UPeVsCwMr1BOA9CHtCNs9aWvYpyfR3wt+h1RY/nW7noBo6pZvOtyjNvPb
         CK7laUz224IKzQprXm06oSU3ES2CSd8TBAs6e7D8Pywh4I+lFx7HQhdOmbMDMXp3RUlt
         k2ET2+mCsDcn81NnQ8Jc/ax11MFNt6JIQwSCEC9VDXKK6xsbjux9srhEBpzdsTDbC/eJ
         uPTw==
X-Forwarded-Encrypted: i=1; AJvYcCU1DIvAsm+uX5bSF3t8ocYmFA27HsWjqi0doqVYkgGhLKyWqD/cOTVe8W7BLp04HjpB0//5VJL2DnmFYvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYCvIpI/ZVjfoQ2pG0V2lj6/8qqH052TaJlnjfCkXhgM4bxBtd
	Jq35H0VKHH1Mvch+B+dNdTmNX2W2MxlbIwNuBovAS9xzaq6G0tNcVAeRdp+P92BhVIp9v6gM9Lo
	HXwXwXFPpMzAdivqVg2c5dtdODH1zgPjw6fIsEC39
X-Gm-Gg: ASbGncuKnjJ82xYMU19ZWSN1uHeoQIeaJTh/N7KXDZ7vo+Eh06I0LzsZHTSDjMbVz2E
	smb4HBxvipkgOtFx9md3N7PwrtoHrAs8gVRDgyERGGZfUbieH5ABiqqhIXReIKL32SiJB0znZSc
	WmpbbCFU/mCf7A5kaL7Now3jDq5hdA0DrsegzbQZQM+DJkLud7MPUhv427+KL8rd7pFJ59P0rQe
	RdfzcezRnPEQnkqWImO47gIuRSu6Eeb45y1SIvbibsoeftxbPLYF8aS6IVNCxA=
X-Google-Smtp-Source: AGHT+IFiVuLYivP034AwNyXAkpK0U9cc8NbdifZyjw09pfdEvHJuVDozucJsWtjEL9bmQH3yJFcdpbpk6wFGjPz12kI=
X-Received: by 2002:a05:6402:3246:20b0:634:38d4:410a with SMTP id
 4fb4d7f45d1cf-63bebfa2921mr142406a12.2.1760546357234; Wed, 15 Oct 2025
 09:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101636.69220-1-21cnbao@gmail.com> <aO11jqD6jgNs5h8K@casper.infradead.org>
 <CAGsJ_4x9=Be2Prbjia8-p97zAsoqjsPHkZOfXwz74Z_T=RjKAA@mail.gmail.com>
 <CANn89iJpNqZJwA0qKMNB41gKDrWBCaS+CashB9=v1omhJncGBw@mail.gmail.com>
 <CAGsJ_4xGSrfori6RvC9qYEgRhVe3bJKYfgUM6fZ0bX3cjfe74Q@mail.gmail.com>
 <CANn89iKSW-kk-h-B0f1oijwYiCWYOAO0jDrf+Z+fbOfAMJMUbA@mail.gmail.com>
 <CAGsJ_4wJHpD10ECtWJtEWHkEyP67sNxHeivkWoA5k5++BCfccA@mail.gmail.com>
 <CANn89iKC_y6Fae9E5ETOE46y-RCqD6cLHnp=7GynL_=sh3noKg@mail.gmail.com>
 <CAGsJ_4x5v=M0=jYGOqy1rHL9aVg-76OgiE0qQMdEu70FhZcmUg@mail.gmail.com>
 <CANn89iJYaNZ+fkKosRVx+8i17HJAB4th645ySMWQEAo6WoCg3w@mail.gmail.com> <CAGsJ_4wYrQuhGY6FuZJzQJjQfx6udRAbP4XZvEevknrpqnkv8g@mail.gmail.com>
In-Reply-To: <CAGsJ_4wYrQuhGY6FuZJzQJjQfx6udRAbP4XZvEevknrpqnkv8g@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 15 Oct 2025 09:39:03 -0700
X-Gm-Features: AS18NWDCakq1h-mH7wphh8y1dVf2NhsytSCg4Cqtn1Pb9vJqQi_9SQu-IJteMNE
Message-ID: <CAJuCfpGf8Hj1QAgNtbRwsBwTOZTidt9sGLwX8PYhiHWYyE9Z1A@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Barry Song <21cnbao@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Jonathan Corbet <corbet@lwn.net>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Huacai Zhou <zhouhuacai@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 12:35=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Wed, Oct 15, 2025 at 2:39=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
>
> > > >
> > > > Tell them they are wrong.
> > >
> > > Well, we checked Qualcomm and MTK, and it seems both set these values
> > > relatively high. In other words, all the AOSP products we examined al=
so
> > > use high values for these settings. Nobody is using tcp_wmem[0]=3D409=
6.
> > >
> >
> > The (fine and safe) default should be PAGE_SIZE.
> >
> > Perhaps they are dealing with systems with PAGE_SIZE=3D65536, but then
> > the skb_page_frag_refill() would be a non issue there, because it would
> > only allocate order-0 pages.
>
> I am 100% sure that all of them handle PAGE_SIZE=3D4096. Google is workin=
g on
> 16KB page size for Android, but it is not ready yet(Please correct me
> if 16KB has been
> ready, Suren).

It is ready but it is new, so it will take some time before we see it
in production devices.

>
> >
> > > We=E2=80=99ll need some time to understand why these are configured t=
his way in
> > > AOSP hardware.
> > >
> > > >
> > > > >
> > > > > It might be worth exploring these settings further, but I can=E2=
=80=99t quite see
> > > > > their connection to high-order allocations, since high-order allo=
cations are
> > > > > kernel macros.
> > > > >
> > > > > #define SKB_FRAG_PAGE_ORDER     get_order(32768)
> > > > > #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE=
_MASK)
> > > > > #define PAGE_FRAG_CACHE_MAX_ORDER       get_order(PAGE_FRAG_CACHE=
_MAX_SIZE)
> > > > >
> > > > > Is there anything I=E2=80=99m missing?
> > > >
> > > > What is your question exactly ? You read these macros just fine. Wh=
at
> > > > is your point ?
> > >
> > > My question is whether these settings influence how often high-order
> > > allocations occur. In other words, would lowering these values make
> > > high-order allocations less frequent? If so, why?
> >
> > Because almost all of the buffers stored in TCP write queues are using
> > order-3 pages
> > on arches with 4K pages.
> >
> > I am a bit confused because you posted a patch changing skb_page_frag_r=
efill()
> > without realizing its first user is TCP.
> >
> > Look for sk_page_frag_refill() in tcp_sendmsg_locked()
>
> Sure. Let me review the code further. The problem was observed on the MM
> side, causing over-reclamation and phone heating, while the source of the
> allocations lies in network activity. I am not a network expert and may b=
e
> missing many network details, so I am raising this RFC to both lists to s=
ee
> if the network and MM folks can discuss together to find a solution.
>
> As you can see, the discussion has absolutely forked into two branches. :=
-)
>
> Thanks
> Barry

