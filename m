Return-Path: <linux-kernel+bounces-756511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED26B1B547
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FD51883B29
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4901275113;
	Tue,  5 Aug 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="icFgHUxt"
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3662701D6;
	Tue,  5 Aug 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401834; cv=none; b=uKsSnJHyDlLh17tO1eYSgDyAcKT7vbCyJ/4fejGk0rEbxokpSDndWF+FYXRj+h7Z/x+M2C21A3hN0cROAIY5fO/x5EdFOcYClb9ZYj/yF2poWMgPxi7BE1YJdN3Y7aff1qfEerOVe0m7VW/rybmEp2OwABeQjHFC6WKn+9STlVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401834; c=relaxed/simple;
	bh=q0+nYeuyQ+6AoyDKNBeY3RHlTqfS9TyWMrZyoB3tSIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Te8Jraqdr9dGuUSwh5dVfDgS87JgfTAVynT6/tLtugtP3k5zD4HHU5aGdM106gEtj39f4avicVTO/qYTaKdNPq2d7YbxLHrbp1IgMJ9uLIiP8olInD5wldHhEZDdk9NlUZeHWqwTBeKvbTc2yVovHiXvpxH4qVxBZEnSNQtRnks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=icFgHUxt; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:4d88:0:640:1229:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id BDEEBC1362;
	Tue, 05 Aug 2025 16:50:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Gog2NwfMuGk0-QN8z0oWJ;
	Tue, 05 Aug 2025 16:50:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1754401821;
	bh=q0+nYeuyQ+6AoyDKNBeY3RHlTqfS9TyWMrZyoB3tSIg=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=icFgHUxth2kAC0N2wx+IIUyxCIr15Pbuum+xoMEySyFqdQ/8iSfnphu6OLPHIrcy3
	 dJ2WyaJ8oNEAViHpsJ34pbTIAlb50MXDP5OtWl4XyfuXm31DtRm49CP0i704rcmmhD
	 2MIsNGYVe8VtvN00gt5dS+fdORzfnb59zGbw9NtM=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Tue, 5 Aug 2025 16:50:14 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Benno Lossin <lossin@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, felipe_life@live.com, daniel@sedlak.dev,
 bjorn3_gh@protonmail.com, dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 2/3] implement ww_mutex abstraction for the Rust tree
Message-ID: <20250805165014.1766f8dd@nimda.home>
In-Reply-To: <8FA1F09F-CDD0-4A95-8E9E-49A3326613A2@collabora.com>
References: <20250621184454.8354-1-work@onurozkan.dev>
	<20250621184454.8354-3-work@onurozkan.dev>
	<DASY7BECFRCT.332X5ZHZMV2W@kernel.org>
	<aFlQ7K_mYYbrG8Cl@Mac.home>
	<DATYHYJVPL3L.3NLMH7PPHYU9@kernel.org>
	<aFlpFQ4ivKw81d-y@Mac.home>
	<DAU0ELV91E2Q.35FZOII18W44J@kernel.org>
	<20250707163913.5ffc046d@nimda.home>
	<DB5XIWGZ8U36.1VB58YBJFL7OT@kernel.org>
	<20250707210613.2fd5bb55@nimda.home>
	<DB62ZN1LTO31.1HVWDLAWJWVM8@kernel.org>
	<FF481535-86EF-41EB-830A-1DA2434AAEA0@collabora.com>
	<DBRVNP4MM5KO.3IXLMXKGK4XTS@kernel.org>
	<E997DCAF-552F-4EF2-BF94-1385ECADF543@collabora.com>
	<20250805120813.1f8714f5@nimda.home>
	<8FA1F09F-CDD0-4A95-8E9E-49A3326613A2@collabora.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Aug 2025 09:41:43 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> Hi Onur,
>=20
> > On 5 Aug 2025, at 06:08, Onur =C3=96zkan <work@onurozkan.dev> wrote:
> >=20
> > On Sat, 2 Aug 2025 11:15:07 -0300
> > Daniel Almeida <daniel.almeida@collabora.com> wrote:
> >=20
> >> Btw, I can also try to implement a proof of concept, so long as
> >> people agree that this approach makes sense.
> >=20
> > It's not necessary to provide a full P.o.C but a small
> > demonstration of the kind of ww_mutex API you would prefer would be
> > helpful. Seeing a few sample Rust use-cases (especially in
> > comparison to existing C implementations) would give a clearer
> > picture for me.
> >=20
> > At the moment, the implementation is just a wrapper ([1]) around
> > the C ww_mutex with no additional functionality, mostly because we
> > don't have a solid consensus on the API design yet (we had some
> > ideas about Tuple based approach, but seems like that isn't going
> > to be useful for most of the ww_mutex users).
> >=20
> > [1]: https://github.com/onur-ozkan/linux/commits/673e01a9c309c
> >=20
> >> By the way, dri-devel seems to not be on cc? Added them now.
> >=20
> > Thanks!
> >=20
> > --
> >=20
> > Regards,
> > Onur
> >=20
>=20
> This topic is on my TODO for this week.
>=20
> =E2=80=94 Daniel

Awesome, thank you for doing it. :)

Regards,
Onur

