Return-Path: <linux-kernel+bounces-738728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD69BB0BC5F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2332F3B2ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8A921D5BC;
	Mon, 21 Jul 2025 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="VcyO+xtY"
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D81DACA7;
	Mon, 21 Jul 2025 06:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753078455; cv=none; b=nsMMkfU64difZmAPaGAWV510c4Lk7tz/2epcoohj4uKew3RlXIH1IDv2fSTSFh5HQECjnZfzj2tAz5Rc4egGxOohBo+R9jRdG0utwgMEI9pD/nT/+ZKV03ZLdcbfDZbz32GbMfvufAXOzDYmfx+Uo4Aq3EH06t7OdSk6p9JemYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753078455; c=relaxed/simple;
	bh=qYVT63ZejfnIcWF4QfXl/VRZ7N+0m0/slVo378MbiTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6JCCdWBQQ2oRNq5N2hmUfXhtyM8CPJoyVLehIKjUkxx44OfQX41pomFyQWwx4eNO5r9Kcpk7DAKwhhimFoD2w/sqDVdMrTFzUsdd7WigNHZGpPOlHJ3lU1aY7OhIVCMJZzdjoEmbc/rCLgyoxuuSh1nK/QMo+bmWIWPwN9VrAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=VcyO+xtY; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:16c5:0:640:b9af:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id 1CABDC3F07;
	Mon, 21 Jul 2025 09:14:04 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 0EKxuH9Lp4Y0-gnLfREKb;
	Mon, 21 Jul 2025 09:14:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1753078443;
	bh=qYVT63ZejfnIcWF4QfXl/VRZ7N+0m0/slVo378MbiTM=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=VcyO+xtYKgaOiAnpUAY5VoNXM0W+rjktyyBQ5YENX439wF4epUSjlQgTpd4kwQ2wz
	 C2J4KTNg3cfKTdocoRU2stm6jQSf7gEH4kzfoag6n/8tUdmOuxSwhlRPebzzhq7bEV
	 n/dA2OzmH6sbarWgtereqCq2AKd5XLaU/PBvEbVg=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Mon, 21 Jul 2025 09:13:58 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, rust-for-linux@vger.kernel.org,
 dakr@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] rust: make various `alloc` functions `const fn`
Message-ID: <20250721091358.7dda6b31@nimda.home>
In-Reply-To: <CANiq72mv2yiJW_AD-_F1JUP2QdJKGGg8SqZ5SgDWT2xc_tpbZg@mail.gmail.com>
References: <20250720094838.29530-1-work@onurozkan.dev>
	<DBGYNQJJ0JI6.P280ZLVZUSO6@kernel.org>
	<20250720181721.54ab9faf@nimda.home>
	<CANiq72mv2yiJW_AD-_F1JUP2QdJKGGg8SqZ5SgDWT2xc_tpbZg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Jul 2025 17:42:43 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> On Sun, Jul 20, 2025 at 5:17=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.d=
ev> wrote:
> >
> > Personally, I don't have a specific reason. I thought the change is
> > harmless and might extend functionality for other people in the
> > future. It could also (although less likely) help the compiler
> > optimize things further.
>=20
> I think it is OK -- even if we promise they are `const` and we have to
> remove it in the future, it is fine, since there is no stable kernel
> API. So that flexibility is another advantage of no promises there.
>=20
> However, I am curious, in which cases it would help the compiler
> optimize? The compiler already has the information on whether it could
> actually be `const` and whether it can be evaluated at compile-time
> and so on -- do you mean it has an effect on heuristics like inlining
> or similar?

I thought it had effects similar to inlining, but after digging into the
assembly output of a simple program (with and without `const`
expressions) and reading some related discussions [1], it seems I was
wrong about it, sorry.

[1]: https://users.rust-lang.org/t/the-effects-of-const-fn/48303

Regards,
Onur

