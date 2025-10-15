Return-Path: <linux-kernel+bounces-853956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEF3BDD1CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B654A352C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9781B2FE577;
	Wed, 15 Oct 2025 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjwe29+4"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625BFAD2C
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513714; cv=none; b=hGtL4uxrsSnDcCGuSHZUnCzHCjPrw3SO3mHxIu8DefC3XmzSmWsiY1aPWgyuYkeA1D9AiFEYxJ9xCQMgZ1mIK3BSxFd7S49tl+5iUEPgbscaUoSjJ+PBmIZjOirOQODZDO12ARSVIkhgsEJE7NFRJJlTif5qcKWphbO9MPBUpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513714; c=relaxed/simple;
	bh=IFw0y3HFIK1S4mkksxahSnq3lwF6loF4/RY4O+5S2hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pk/v/HaRMmFBm8SrVD5BplGMbOztXsC9j1nah+O6hUuC6t3alIUwjSVLcd4fZN/zvoutf4j7Qznun+SH7KySXJNOR3OU5Z86kIHlLexl7RPS2/tvfnOKhTp4kek7Qy1Sr7z/Fd1z/fe89wpFYktMnCY8aY2ZuHPdBz8MUIjuTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjwe29+4; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-88e32ad012cso59638285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760513712; x=1761118512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BA3o1cHbuC0FFSVH6LGwTjiyg5Fjt24vDKqsTK1XeKk=;
        b=jjwe29+4qmJsV84FQDy6csUxIAZD0pT0J6kHJC/UbOV0BMdELqMhhAe8ajWGNJUKge
         wmmewbooap7ypZpybealvtsGslHYecWfsW7BSjjKIm3AUy8Qucc/YEJFm74OnZsopEcq
         k5WUsQ7UNCINTVIZe2Ajd+Ca5xZ8PTZP0t47gtyFawr4V15M3LNo8Khy3VgkBPBz9COM
         IeGizAYCHg6qx/MGRgFIBS331Iu4RcdboAnjvweBCY05z3je2ie/FpuXHLGD+ql8HwAF
         Pdp/J0qLu9G3EpII8k3+a46YD42gCvOKn5FcvbX6i7p8AveQBu/ovRRkfoTIi28weK05
         POgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760513712; x=1761118512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BA3o1cHbuC0FFSVH6LGwTjiyg5Fjt24vDKqsTK1XeKk=;
        b=acSwPrgjRUvn+PcKJc74cSFMFjlVqmDlJyl767vWEA4X1L3mk7xSTzmia8JP6PvITy
         0BaWFMuMUNwZB0R+eiPq/2s+BNZUmr0sxrAbkgajDWu7gtkven5wGAv9yx9PN544wwqw
         73F3WJXejoTePfLhS0XesL14o1c4EMVYJMGCr67Mk2C06zpDD/iPQsyWLQ2CbAbgCUrG
         ULrSwnU4Gdlxc8yYl8r7J0Xmu66dUl4g6Ec4IbmEREMkaqzpF6ybLRTDq8M+/h+bGA7/
         sdxeyBLTUIyCW+nDmOra4z3WxLIYEwSqOuIYBiyT1xKNi7QtWHFpFlWATGXrNafps4Zc
         vRhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQULJZpNQlRKKm7QVFDYfbx8t458QdI8Y/eGtfT2lMhyQ+8xL0BD7nTT+7IbKd6JFyGJ+kM7BvBXxCc1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXouQ3kC8DR4EOcGQC+7r5pw55Gq8t5ISQ22WPit3sWg5y5NGE
	HxzcppKWnMqL4VRY6ONYJOPhBzsVgo289C+FZd27yfe2dD/Xs5Y89HiBqocPf/eoIhvDcxnsGL4
	S+YM3u6VXq656EJ2Bxx3w8x26ENe1G/A=
X-Gm-Gg: ASbGncuQ2KkRhgo2+u90TpnyfpR50sHbfj+lNX0i6e/v4zB7u7aFeOOPWK4FP86RF4h
	/BTqhRfrVtozfSVZoNcat+PhwG37JhMh6xWpzgB4tjd5i4YkNaV8/DnJgvqJkQk6waWYUla3nja
	arKjoaansUuYaHMm02+fDTMwUCHVUfQi1pahylIOr/mgdIkifJaFzEMNAD+SIwtgNZKGAG46h/9
	EwvaceYsOd7SdSJlUxqmPeSA3F0VNUqOJiYWgnSicA/ShJliWkVZcf6vC8o66RTWWYE
X-Google-Smtp-Source: AGHT+IEKuviABuf8paTr2eaaeUlS/nUOTJ25Ra9gag22Alb6I0Md3LX7r3aaI+eo4s+XoFak3t65ds9W83VxSzBmJiE=
X-Received: by 2002:a05:620a:f13:b0:812:c6e3:6663 with SMTP id
 af79cd13be357-88350c678bdmr3682430585a.34.1760513711989; Wed, 15 Oct 2025
 00:35:11 -0700 (PDT)
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
 <CAGsJ_4x5v=M0=jYGOqy1rHL9aVg-76OgiE0qQMdEu70FhZcmUg@mail.gmail.com> <CANn89iJYaNZ+fkKosRVx+8i17HJAB4th645ySMWQEAo6WoCg3w@mail.gmail.com>
In-Reply-To: <CANn89iJYaNZ+fkKosRVx+8i17HJAB4th645ySMWQEAo6WoCg3w@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 15 Oct 2025 15:35:00 +0800
X-Gm-Features: AS18NWAHXtYVOjzGMsZVpeCyed9cBDk9Qc-GpblFolpgSoSOaZV2-smc5Nm5TAA
Message-ID: <CAGsJ_4wYrQuhGY6FuZJzQJjQfx6udRAbP4XZvEevknrpqnkv8g@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Eric Dumazet <edumazet@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>, Jonathan Corbet <corbet@lwn.net>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Huacai Zhou <zhouhuacai@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 2:39=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:

> > >
> > > Tell them they are wrong.
> >
> > Well, we checked Qualcomm and MTK, and it seems both set these values
> > relatively high. In other words, all the AOSP products we examined also
> > use high values for these settings. Nobody is using tcp_wmem[0]=3D4096.
> >
>
> The (fine and safe) default should be PAGE_SIZE.
>
> Perhaps they are dealing with systems with PAGE_SIZE=3D65536, but then
> the skb_page_frag_refill() would be a non issue there, because it would
> only allocate order-0 pages.

I am 100% sure that all of them handle PAGE_SIZE=3D4096. Google is working =
on
16KB page size for Android, but it is not ready yet(Please correct me
if 16KB has been
ready, Suren).

>
> > We=E2=80=99ll need some time to understand why these are configured thi=
s way in
> > AOSP hardware.
> >
> > >
> > > >
> > > > It might be worth exploring these settings further, but I can=E2=80=
=99t quite see
> > > > their connection to high-order allocations, since high-order alloca=
tions are
> > > > kernel macros.
> > > >
> > > > #define SKB_FRAG_PAGE_ORDER     get_order(32768)
> > > > #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_M=
ASK)
> > > > #define PAGE_FRAG_CACHE_MAX_ORDER       get_order(PAGE_FRAG_CACHE_M=
AX_SIZE)
> > > >
> > > > Is there anything I=E2=80=99m missing?
> > >
> > > What is your question exactly ? You read these macros just fine. What
> > > is your point ?
> >
> > My question is whether these settings influence how often high-order
> > allocations occur. In other words, would lowering these values make
> > high-order allocations less frequent? If so, why?
>
> Because almost all of the buffers stored in TCP write queues are using
> order-3 pages
> on arches with 4K pages.
>
> I am a bit confused because you posted a patch changing skb_page_frag_ref=
ill()
> without realizing its first user is TCP.
>
> Look for sk_page_frag_refill() in tcp_sendmsg_locked()

Sure. Let me review the code further. The problem was observed on the MM
side, causing over-reclamation and phone heating, while the source of the
allocations lies in network activity. I am not a network expert and may be
missing many network details, so I am raising this RFC to both lists to see
if the network and MM folks can discuss together to find a solution.

As you can see, the discussion has absolutely forked into two branches. :-)

Thanks
Barry

