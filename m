Return-Path: <linux-kernel+bounces-852371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF66DBD8C87
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1091A1923443
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2742F9DB5;
	Tue, 14 Oct 2025 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utz2bd//"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF402F7468
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760438361; cv=none; b=S5BNSaNk683aw5fN+wED+qgj8PcSlTxTrINpLI32wlYIRH5bYm6XWaFXJkcyJkhnnK8g3gNSy16BakYSwYN4LV+5/z2CSPxbIvK0S7liJOKvFmEpn4e0h23AV/9Nmmod9UB0/q4fSTZ5+/6Xkp2EY9CszS9oqsE62ifJ7EYyO8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760438361; c=relaxed/simple;
	bh=q9P0PZo6cOuJ7XhtTvcQVZCsmpjkgC3FXXL1ZL3FWEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCOaSdWkO2Qp3pTJ+4YLrwaWL4J+NibxsEF2Ty3OerrAR8eBw/jlnQYKfCMfs7SwAkpelbcPHutNaQYpu4HwekUMqGpGWyB+gwJVFlyFF6e7GQARbKN1533Ybvcy7BCMSGNpCG5I4nWqnKEbWrOmmm+DwDFhNywP7Ri8Lt/gGl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=utz2bd//; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8582a34639aso387740685a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760438359; x=1761043159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8i8HbdVZPfionD4pRoeQJ/6YsnBufC3F7NgJEHPSzVE=;
        b=utz2bd//LCgSaXSDGqKeiciqIpkP6tI+Dub1kST75Ar63td5RhjZn1LRHLph1ddm0o
         W3WmFyGkBnLnL7YpmQiRw2jddQOs7rjCJuLFO0hyJuVQmIDuqyjtWYUO8Z3vKP5yTntx
         Mb2/ByOmHYXtDRDunQDEalMcJ1Z6lk7aZWSVBv374gfDw1mQsd4qlcb+l3fTh55fBwQP
         ZtCmjg2Ad6mLufGgehVeLuglw7VbhXtW1NBvqdLWwIWTIAFBy77RoeeZlGmQHc4Hi5Vg
         ZU2guXOswWdCXlJHfaSaGsLuWYUOmPvB3rvnA63We7uJmzbOjBs62xXm8d0BZ7CccGf6
         jSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760438359; x=1761043159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8i8HbdVZPfionD4pRoeQJ/6YsnBufC3F7NgJEHPSzVE=;
        b=U+7m5+uVhkOiR82AH23IBoXYyJcsjldIkK9cRZQEHWSSG8kCB0T0zztIOhkoY+Ff+v
         mOw5Wo2Q3/pXg6UtH8/Qu19ZpWiOqALbdffcUvwFmq26RH2+45fJRYT6L3IGqNgNqAsr
         NQD5bREcpqqN64mpXayzSWXTj7tzggIdAJW+H6jvz8edIaKZgMwBwseE+WY6NVpitaTy
         GbQBmb6+PWw95Zc/BZUUdjwwXERUJ8h5ekEnVq9tQjYu8mnEVTa8rS1SUIeR3dDjXcm/
         eDdktPxUXCZ9OAr+xooFD72jVxYruAnAu8HqzTrhp3aRlKivJmr4ZMK6OABidmmAMzpt
         WPOg==
X-Forwarded-Encrypted: i=1; AJvYcCX5AB3Pz2WVcmYTrgExZIdTOFkGxxdFJHStNSEfUBwpuu+n9JZ7PAdrmmeWQ+kWsNGV/k5FPZMPX7Anykw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlee5cNzJnc+uUuXMvrTJ6kHaUBaYkz1JY/YkLvBhMaDxAgVtG
	GkSMlC16aHI/JWJCnDFLdLbJLvnqzLLRRpFmfNZSlBtH6vtoRtr4NBauB20fJd7h19+DjJ1c5MG
	1LDTKs3nuDSm4YrGLPOmVEhYqGVzq61ZPh3LiI/hu
X-Gm-Gg: ASbGnct4I/lJqobpPalOv2TQwiZv1skR4lzABtT3NWTHeR3zu8/7o3q4hJ7IhEkxsJ5
	G4hb0oUzfifiPet/PQWtB17Pjaul5zWJgv3UBjsHudPksMplZO2Zr6jU//V7JQxSKCM584NM7Q8
	xqSmX4UdezvJbYYhPsGFH0JkyY0/4fgAQmt3wcwDRka0AGwc2HYMJYHlwFuu70tDdBau0jhkk4l
	iXJaXn6JnVuFL7CBguVxkh4eCK8qrau
X-Google-Smtp-Source: AGHT+IEFzNXw/v6xZVTk0phPdvVBFB9EdAErZ6ksdm/dcjAu+K9F+ebHYFJ1AyXwmjljbbFPU7Tg80KyboEacHc3cFc=
X-Received: by 2002:ac8:5d05:0:b0:4e4:2006:b009 with SMTP id
 d75a77b69052e-4e6eaccc55cmr307481031cf.17.1760438358741; Tue, 14 Oct 2025
 03:39:18 -0700 (PDT)
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
 <CANn89iKSW-kk-h-B0f1oijwYiCWYOAO0jDrf+Z+fbOfAMJMUbA@mail.gmail.com> <CAGsJ_4wJHpD10ECtWJtEWHkEyP67sNxHeivkWoA5k5++BCfccA@mail.gmail.com>
In-Reply-To: <CAGsJ_4wJHpD10ECtWJtEWHkEyP67sNxHeivkWoA5k5++BCfccA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 14 Oct 2025 03:39:07 -0700
X-Gm-Features: AS18NWC6tSD-2fPgi67vs3tdqcGs5ZT4phYwNUo9MOM_IOY7jeMq3pOnwQALTO4
Message-ID: <CANn89iKC_y6Fae9E5ETOE46y-RCqD6cLHnp=7GynL_=sh3noKg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Barry Song <21cnbao@gmail.com>
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

On Tue, Oct 14, 2025 at 3:19=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> > >
> > > >
> > > > I think you are missing something to control how much memory  can b=
e
> > > > pushed on each TCP socket ?
> > > >
> > > > What is tcp_wmem on your phones ? What about tcp_mem ?
> > > >
> > > > Have you looked at /proc/sys/net/ipv4/tcp_notsent_lowat
> > >
> > > # cat /proc/sys/net/ipv4/tcp_wmem
> > > 524288  1048576 6710886
> >
> > Ouch. That is insane tcp_wmem[0] .
> >
> > Please stick to 4096, or risk OOM of various sorts.
> >
> > >
> > > # cat /proc/sys/net/ipv4/tcp_notsent_lowat
> > > 4294967295
> > >
> > > Any thoughts on these settings?
> >
> > Please look at
> > https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
> >
> > tcp_notsent_lowat - UNSIGNED INTEGER
> > A TCP socket can control the amount of unsent bytes in its write queue,
> > thanks to TCP_NOTSENT_LOWAT socket option. poll()/select()/epoll()
> > reports POLLOUT events if the amount of unsent bytes is below a per
> > socket value, and if the write queue is not full. sendmsg() will
> > also not add new buffers if the limit is hit.
> >
> > This global variable controls the amount of unsent data for
> > sockets not using TCP_NOTSENT_LOWAT. For these sockets, a change
> > to the global variable has immediate effect.
> >
> >
> > Setting this sysctl to 2MB can effectively reduce the amount of memory
> > in TCP write queues by 66 %,
> > or allow you to increase tcp_wmem[2] so that only flows needing big
> > BDP can get it.
>
> We obtained these settings from our hardware vendors.

Tell them they are wrong.

>
> It might be worth exploring these settings further, but I can=E2=80=99t q=
uite see
> their connection to high-order allocations, since high-order allocations =
are
> kernel macros.
>
> #define SKB_FRAG_PAGE_ORDER     get_order(32768)
> #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
> #define PAGE_FRAG_CACHE_MAX_ORDER       get_order(PAGE_FRAG_CACHE_MAX_SIZ=
E)
>
> Is there anything I=E2=80=99m missing?

What is your question exactly ? You read these macros just fine. What
is your point ?

We had in the past something dynamic that we removed

commit d9b2938aabf757da2d40153489b251d4fc3fdd18
Author: Eric Dumazet <edumazet@google.com>
Date:   Wed Aug 27 20:49:34 2014 -0700

    net: attempt a single high order allocation

