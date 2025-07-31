Return-Path: <linux-kernel+bounces-752654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F13B178E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261AD5A4D27
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E20E26C3B7;
	Thu, 31 Jul 2025 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPWTKeHU"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB39268688
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999836; cv=none; b=VCVRvF4xUE2LVigDtalxO8Ywfvz95kFGMZfuEAVKhiiWQqgT0/hC5agpG3TCGrlMG8oYVhhf+zTtEuC25WJg3eRKZujXWEEgGxT2PJVljlIGiUSbDUnT+1rhb6Dx09NuV9olBK5d17u3W+FN5blYxdhiIlNVRmkZ4i8k6Fn7N1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999836; c=relaxed/simple;
	bh=ph5z1M2S5YizVVxfT2cZN5Knu3Bzp40XCiHbEIYjOQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZXUFVgG/8mkgjw0Y685UBJBuP6trE6dl7lq3DIaP8Tzqv12trdJZbcFmzFJG7DK6WofHoH955CtFBEGBH8jXSHnDyTqbV4XhFav2LyJL6E6DYgDMIqe67wVPrWQ76QptqbgCmUdypPlmLGvetUPu0foI2spf+/3JHXCAzPMJwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wPWTKeHU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-455b00339c8so7213915e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753999833; x=1754604633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ph5z1M2S5YizVVxfT2cZN5Knu3Bzp40XCiHbEIYjOQk=;
        b=wPWTKeHUFaYIeDa+UA/iwYQZvC7G23gBv5UpU8TXIC1v77JJP+j3aXpch+OAiBa5zd
         oBotDTDu0Kt6JJOg0XkkZ9ieHtv9xIvATwZy6YnlFTb4p1x2RpmP1kfeCGljzQswR757
         oKT3wU8DqosKKaCBDqIdupOKu1EW+SiXPffMmu34R61OQoNvomnPjFUqU6Mcd7xdYMi2
         NOz9gi3PnlpF4A5cb/aN6vZuXbu3Nj4Es1Sz4NO//0u20xEsPi5nlRZwl2IWsq6QyMNM
         TBjBhOnwKl0Mq7N0ZFaYPn0EyiGJO5fQ9yFMWi+A6eJ01gFj2QR8rsrZvT4lttCwbcHC
         3qAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999833; x=1754604633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ph5z1M2S5YizVVxfT2cZN5Knu3Bzp40XCiHbEIYjOQk=;
        b=KOerPgcLtl1DDP5moHVlyaGSOjVJo+L172WGR1LaxUfbhQlq1ZmC1tny9cm8JSRKu6
         SOTBzmLrnCZyqO+briWJBVagS+/WUXfqrlq/ofHh30okrj/c6n4YiVcqXtaI8dgsSqJi
         rAHoOz9GzcaC9V+XbMetSDTB8N3m1eleYkqmPyI258NGRd5mWoewc3P9SwP8hJ8eZosk
         ghccr3UdOrJu/Ko/QHUikZh723cQk7an6VEtjKe11JnFdd/dVg9O+12mHGDx/y7+sCuv
         JRlNYbITwefLy4nmZOlSGzHvUIK3JAoRxcI7ggFBkBP011LC92o03Vw4WyZirtGUxp6f
         ZBiw==
X-Forwarded-Encrypted: i=1; AJvYcCVe7add0dEHPQzzEFSucHqfeDBbTURX3T4MgzVkmmgcPlv50auuwy2vClyrPyNrxRPGU4ZZw/Pz3NO13rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU/2QeChb05GFQYTkVI+0mmbv9IJrMjtYZY5JHoDQZ7P1sX4eC
	kw793vE8HMhN8WCXNQb1PXy8RhQqFh44hYP1Ld4tRyhEjxIqD/jxR4NFkZWZHoWwNpkbrfvNzQT
	howB1jtXxltYPSd55EJ4ZJBcOnw4c7fRj64fblEao
X-Gm-Gg: ASbGncuzkDyVsFn8hfI3UGgaraL4i3sMZ6B8oPX5MsFqy9QDteCv3B325c0p5JLmq5g
	KuVNSmfH+D+4MMzHhpJA19KCZgPFgcDjIx9Af5vwMZKBCE/lTc8A4FU5oM0Q6zjpNerQyVmEV7C
	xbgVTccQmhWXGv+YvRnZqZx0R1Rj/N6sCHZOMDca1zsatug3nynbyWP4GKlHWgNbRp6Xfy486/c
	ZtPbWJJAQRMwXiB6vc=
X-Google-Smtp-Source: AGHT+IG9B0/HQlauhDbtCrGKa7ynRKgDeqJvzuE8GgWceuYQmfiCERcW4fPwXRCQWhfYOBwEzppTY71T++u/o37D6WA=
X-Received: by 2002:a05:600c:3589:b0:456:2bd9:5126 with SMTP id
 5b1f17b1804b1-458aa450ac1mr1265735e9.16.1753999833128; Thu, 31 Jul 2025
 15:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724185700.557505-1-lyude@redhat.com> <20250724185700.557505-3-lyude@redhat.com>
 <aIXVzIwBDvY1ZVjL@google.com> <f92b5f82b3ad7bb8d5bf60b272aac8cf1e6ced24.camel@redhat.com>
 <aIi7ZycRtmOZNtcf@google.com> <ddea64af3b845d2c32d807c5aab6146a9ce3c2bf.camel@redhat.com>
In-Reply-To: <ddea64af3b845d2c32d807c5aab6146a9ce3c2bf.camel@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 1 Aug 2025 00:10:20 +0200
X-Gm-Features: Ac12FXzxjd0NufhNJUN1k32xZsCsJFCJt20asGSegoCOtjrXYYOZvMfs6p8b2yU
Message-ID: <CAH5fLgi63Avw2VYvaOEdZhw93Qb+1isuW-CsyaD-_ask62_tcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: time: Implement basic arithmetic operations for Delta
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 10:47=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrot=
e:
>
> On Tue, 2025-07-29 at 12:15 +0000, Alice Ryhl wrote:
> >
> >
> > The reason I bring up the example is that once you add code using these
> > impls, you're going to get kernel build bot errors from your code not
> > compiling on 32-bit. And as seen in the linked one, code may be compile=
d
> > for 32-bit when setting CONFIG_COMPILE_TEST even if you don't support i=
t
> > for real.
> >
> > > This being said, the kernel does have a math library that we can call=
 into
> > > that emulates operations like this on 32 bit - which I'd be willing t=
o convert
> > > these implementations over to using. I just put the CONFIG_64BIT ther=
e because
> > > if we do use the kernel math library, I just want to make sure I don'=
t end up
> > > being the oen who has to figure out how to hook up the kernel math li=
brary for
> > > 64 bit division outside of simple time value manipulation. I've got e=
nough
> > > dependencies on my plate to get upstream as it is :P
> >
> > If you just want to call the relevant bindings:: method directly withou=
t
> > any further logic that seems fine to me.
>
> Gotcha, I will do that. Ideally I would at least like to have us only cal=
l the
> bindings:: method so long as we're on a config where we really need it. W=
hich
> brings me to ask - do we actually have a way of checking BITS_PER_LONG in
> #[cfg()]? I would have assumed it'd be simple but I don't actually seem t=
o be
> able to reference BITS_PER_LONG.

There is:
#[cfg(target_pointer_width =3D "32")]
or
#[cfg(target_pointer_width =3D "64")]

Alice

