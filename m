Return-Path: <linux-kernel+bounces-769250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678F4B26BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3567C3B5EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7D8248176;
	Thu, 14 Aug 2025 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="q9wUU9/A"
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D2244690;
	Thu, 14 Aug 2025 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187411; cv=none; b=GkuDZlkif4EWR6FMxEJtLhB5z2Xew8eIcYX4GHnG9ksSFLlB6MnprwL7I8YDQwB77XWAuCC38wEPxxZJHl2GJUBEcG0sVlFciIdjZWXsYcLQ+woMAHbHtObK8s+85Ct16eOviNtIi/grEwGb7C1q6zX24BtvBOeWhSPJoJ/rz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187411; c=relaxed/simple;
	bh=g1WA8Ej03Sf9dhAAuIrvWiYJhQRp0RMxdlmdjVG+MZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1aom3F+wueM+/F1vpZaoeOZ2542sYpQ1FRgXG+a0vGeTHQljB7g2L30QiQBawrXiOIMgbBQJ0KTECVvJUfe+Dp0oct/K1yL2CfVX5PZwbBz+pS4dqVaaPqCppw/KtPYJW3pWqjL7CD8isvi5zDVCgDW6I/enVb3AQ5dwkrAUuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=q9wUU9/A; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:5c92:0:640:d905:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 749C081780;
	Thu, 14 Aug 2025 18:56:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id NuOJc8CMeqM0-Yb9JvFND;
	Thu, 14 Aug 2025 18:56:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1755186988;
	bh=QTy62BW8oSOSc+qcq9pzWoofEE0H7QDkiOpZD2U0w9M=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=q9wUU9/Al17TwHApLWwhmyk1OJ2o/toHvDrDDgVT5xMd3Xj9sh6mmkPJAvS224Ozi
	 Lckhpxdsll/mzMoT0xFykdXkf5iF9Xue3VYMQvChIzKDI6+1yMt/pfkJ0FtmAI8p0U
	 3L2PrP+EEV7lBALev2XM97oumXSobT7EJ18kQvwY=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Thu, 14 Aug 2025 18:56:22 +0300
From: Onur <work@onurozkan.dev>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Benno Lossin <lossin@kernel.org>, Lyude Paul <lyude@redhat.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, peterz@infradead.org, mingo@redhat.com,
 will@kernel.org, longman@redhat.com, felipe_life@live.com,
 daniel@sedlak.dev, bjorn3_gh@protonmail.com
Subject: Re: [PATCH v5 0/3] rust: add `ww_mutex` support
Message-ID: <20250814185622.468aad30@nimda.home>
In-Reply-To: <76D4D052-79B6-4D3F-AAA1-164FF7A41284@collabora.com>
References: <20250621184454.8354-1-work@onurozkan.dev>
	<20250724165351.509cff53@nimda.home>
	<ec32fc5f5a8658c084f96540bd41f5462fa5c182.camel@gmail.com>
	<20250806085702.5bf600a3@nimda.home>
	<539d3e0da773c32a42b4ab5c9d4aa90383481ff6.camel@redhat.com>
	<DBVLEGFYBWKE.2RW8J853CJHTY@kernel.org>
	<20250814141302.1eabda12@nimda.home>
	<76D4D052-79B6-4D3F-AAA1-164FF7A41284@collabora.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Aug 2025 09:38:38 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> Hi Onur,
>=20
> > On 14 Aug 2025, at 08:13, Onur =C3=96zkan <work@onurozkan.dev> wrote:
> >=20
> > Hi all,
> >=20
> > I have been brainstorming on the auto-unlocking (on dynamic number
> > of mutexes) idea we have been discussing for some time.
> >=20
> > There is a challange with how we handle lock guards and my current
> > thought is to remove direct data dereferencing from guards. Instead,
> > data access would only be possible through a fallible method (e.g.,
> > `try_get`). If the guard is no longer valid, this method would fail
> > to not allow data-accessing after auto-unlock.
> >=20
> > In practice, it would work like this:
> >=20
> > let a_guard =3D ctx.lock(mutex_a)?;
> > let b_guard =3D ctx.lock(mutex_b)?;
> >=20
> > // Suppose user tries to lock `mutex_c` without aborting the
> > // entire function (for some reason). This means that even on
> > // failure, `a_guard` and `b_guard` will still be accessible.
> > if let Ok(c_guard) =3D ctx.lock(mutex_c) {
> >     // ...some logic
> > }
> >=20
> > let a_data =3D a_guard.try_get()?;
> > let b_data =3D b_guard.try_get()?;
>=20
> Can you add more code here? How is this going to look like with the
> two closures we=E2=80=99ve been discussing?

Didn't we said that tuple-based closures are not sufficient when
dealing with a dynamic number of locks (ref [1]) and ww_mutex is mostly
used with dynamic locks? I thought implementing that approach is not
worth it (at least for now) because of that.

[1]: https://lore.kernel.org/all/DBS8REY5E82S.3937FAHS25ANA@kernel.org

Regards,
Onur

