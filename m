Return-Path: <linux-kernel+bounces-737650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A5AB0AEE9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CABE3A8D32
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 08:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F78A33EC;
	Sat, 19 Jul 2025 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pcr0XCxY"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079631E51D
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752915393; cv=none; b=jTrGOYl7CpVsIrrB4o9UWkxSHovWvBRmwfTzzf5ryfE4PP9jhLREIJrvW3v8cnbxibrLGUz0kXdx/l3x8sfEPiYaSSzHduWDDvcv2X7XzohI8LsShwm9E6QgR17MbvX6MXfDti/Z6hayiZDHR7B6rM8AVg2aWLZw0guXK0S1LJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752915393; c=relaxed/simple;
	bh=bu6IVHlxz8T9eX0JAB357kfRyct50vWKJjthCK8dd0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DknILRg+KXTP6Bv/8HWOm07A4pmdVs45OuGjKf+HzmJzh2Un4OKwM/KZHo6FV8OsRXmosL6FJ/jJIIcrd1rEjGmoGhQaUvF5CIn08DK+mNVvZa+74RdxZqoq7bfDkilTDgFdrvi/TEkvLh4E5ocA2yKAHL6LXRWCpWs1DD0bouI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pcr0XCxY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a54700a463so1620941f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752915390; x=1753520190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nA7BcyCVIg8nNGJHvplQxuWV2btzC7Qx9ZorK281uz8=;
        b=Pcr0XCxYE0h+CZvQyIBD4uK9k27asAKhuPQlORRtAIJdB3VCa8gsafTRCjLgUYTl+l
         EbR7DDRTqKpIS3piQC3ojdWj3jY3VgC84rGC2ZM60kmimuKw1e75AQeAnAbTO1lv89g7
         q42PDcBLXIpKwiTh+DK4bu5Kp0TU+6+bTAyD2pE+zXpQ6POvzqq43XG/XUlcZ7qVUDbJ
         78YVKqsc7iCDXZV6EAe/nsTxiAQjFyhMLWL+7pDoo/8T5bZRhZCqLAo2uGVfVZKd2Z/k
         zA4he8LQFKTRzsAtEM7fd73dg3vuxRPd4gVxCduhNW5QmF8OBS1NAoRnbd/fKSvVTHNC
         L8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752915390; x=1753520190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nA7BcyCVIg8nNGJHvplQxuWV2btzC7Qx9ZorK281uz8=;
        b=MO/4Ofe+WFMW1H1mCa2LPgUJU+CBjhMvy14LlRBEpLdWADNg0P9G05u7Gd9I74Nuc2
         OUB67/OsFNou5ZeX4J83iDvjrZlGL68ggxW5cbn2jHvtMPLRR5e9zT6oawCWZ/u7K5n8
         gvUBj1hWEWFKbLNAwj0sFZbo3ho62qmotqbjuUkYzHdINdBBeOYMD9ziudap1M/+Bszy
         rrRxsNgBB9uA/EiYCkK2Ktx0Z1DnHuxky9acfWWsEKz5AOwlrUhRaP5PD0yBZnfifJF6
         lBeZf2mMdxKYlwqz9oMsqGIMGwBcrxXFQjS24hVsXEljeW/eFPhsHOfBHiGbhlb4h8tx
         eBqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaLm2+od+lEw0XE47HiEMCz41KGU2iC23JOchXrBzFhpsjNB9rYKFLZ3icx9t/8Gkbd48RcNsiqKBtozM=@vger.kernel.org
X-Gm-Message-State: AOJu0YycqwrCa2TbOJi3lzecYT9x0aPHVgyiDhkEG8mnVICOEUh6FfPd
	XAxWDCEOBt4hKe+sUMescWhFEaTc11csxBRZ6AmIsJhhO6efgGvqlJo7swYg9e9HOVvsH5liGQi
	zvkeYMWVo93R7JutqQ8k0rgnAVDNQMFTp0q0BUoyq
X-Gm-Gg: ASbGnctbqLgdxQFMUsUhWtuounti+41svb/JD+zsQ1aut3XcRP+AJby0bfZPBceQrgK
	ZH4caHqWAV34fr5auzVlSL/34EMPaklAVrIQhKcpJ6Ft0G5NW+7os21N5RBTpEsrV0B4Y3xPC9D
	ILHZTX35hiZbLT0s93Q07QMYH3MJOdlcTqJjVB/p4/On3ptlF1H8XSyAI7THmol/JrpghcS7qSv
	w9tRG5R
X-Google-Smtp-Source: AGHT+IFtehjNq7i8/x9Cbu2UL2MqRAJ4BRyQNLHEL+cCznt6ml5hJKV6F3DuCiR6uxpaaWExnw62juPpLNSRmEU91NA=
X-Received: by 2002:a05:6000:2410:b0:3b4:a001:38fc with SMTP id
 ffacd0b85a97d-3b619ba8e44mr5429811f8f.9.1752915390203; Sat, 19 Jul 2025
 01:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
 <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org> <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com>
 <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org> <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org>
 <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org>
 <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org> <C4A101A7-282D-4A67-A966-CF39850952EA@collabora.com>
 <DBAZRNHGIGL8.3L2NGPCVXLI25@kernel.org> <DBAZXDRPYWPC.14RI91KYE16RM@kernel.org>
 <18B23FD3-56E9-4531-A50C-F204616E7D17@collabora.com> <DBB0NXU86D6G.2M3WZMS2NUV10@kernel.org>
 <1F0227F0-8554-4DD2-BADE-0184D0824AF8@collabora.com> <AACC99CD-086A-45AB-929C-7F25AABF8B6E@collabora.com>
 <ce656239-08a1-49e8-86b1-b33d0cdfbcd3@gmail.com>
In-Reply-To: <ce656239-08a1-49e8-86b1-b33d0cdfbcd3@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 19 Jul 2025 10:56:17 +0200
X-Gm-Features: Ac12FXziDTAPr7iQHl5XG-7N-BrpNtqsyfpXflvLScQegzDs48j1Kr5cC2Bsyfc
Message-ID: <CAH5fLgi7846Yi1tg1qAZFLhwkwtftZsdEdk4c6snQXtGyTFr8Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and handlers
To: Dirk Behme <dirk.behme@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Danilo Krummrich <dakr@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 7:47=E2=80=AFAM Dirk Behme <dirk.behme@gmail.com> w=
rote:
>
> Hi Daniel,
>
> On 13.07.25 17:32, Daniel Almeida wrote:
> >
> >
> >> On 13 Jul 2025, at 12:28, Daniel Almeida <daniel.almeida@collabora.com=
> wrote:
> >>
> >>
> >>
> >>>
> >>> (2) Owning a reference count of a device (i.e. ARef<Device>) does *no=
t*
> >>>     guarantee that the device is bound. You can own a reference count=
 to the
> >>>     device object way beyond it being bound. Instead, the guarantee c=
omes from
> >>>     the scope.
> >>>
> >>>     In this case, the scope is the IRQ callback, since the irq::Regis=
tration
> >>>     guarantees to call and complete free_irq() before the underlying =
bus
> >>>     device is unbound.
> >>>
> >>
> >>
> >> Oh, I see. I guess this is where I started to get a bit confused indee=
d.
> >>
> >> =E2=80=94 Daniel
> >
> > Fine, I guess I can submit a newer version and test that on Tyr.
> >
> > Dirk, can you also test the next iteration on your driver? It will poss=
ibly
> > solve your use case as well.
>
>
> Now, I'm slightly confused ;) I just saw your version 7 of this
>
> [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and handlers
> https://lore.kernel.org/rust-for-linux/20250715-topics-tyr-request_irq2-v=
7-3-d469c0f37c07@collabora.com/
>
> and somehow was expecting something like
>
> fn handle(&self, dev: &Device<Bound>) -> IrqReturn
>
> there. I.e. to get a bound device passed into the handler.
>
> If I misunderstood the discussion and this is supposed to not be
> added: Any hint how to get the &Device<Bound> from the probe
> function/irq registration into the irq handler, then? To be able to do
> something like
>
> fn handle(&self) -> IrqReturn {
>   let dev =3D ??;
>   let io =3D self.iomem.access(dev);

Please see:
https://lore.kernel.org/all/CAH5fLgibCtmgFpKNrC+jcSEqSUctyVMuYwEC0QSo+vzyDX=
K0zg@mail.gmail.com/

Alice

