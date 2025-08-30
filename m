Return-Path: <linux-kernel+bounces-792996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE007B3CB50
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 15:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8181BA5213
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5513D23BCEE;
	Sat, 30 Aug 2025 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImNgAQrM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD98C1A9FBC;
	Sat, 30 Aug 2025 13:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756561098; cv=none; b=F0abgQcaWGIevUF1LxyLVafX/fivip+QmI4bMJ9mE178vCkXfsKpyfhvEhIpE4zeRjdr0FwlJ5OvJqEhJPxSvpcLgRn56HhFHxGI1JyK7FhjOkDH++2f2Zmj+RI+rXxHiz1y3GfwuFG6s6ocZph6WXeXWXoHPIzlMERizUZofyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756561098; c=relaxed/simple;
	bh=G0LQPFOpkizRtJfrqOgFJqKcVXEgdYu2QAdEsC3pQtI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SzPa3CiladLCdhft6dyyyt7/KcDQbBbY7x/b2Sz/HcW37G7bv156GhhkRHmOBBEEMOtX3f2uS7qXbop/zdY9qwBwtBlYvlc2EctOKBdcCahE336V9Wk2Hh+pHaIYxAMFhTZjV6x7iTyrz+zJZ5Xhog8SJ86Yji+2kaAJHXgA5f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImNgAQrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5B3C4CEF1;
	Sat, 30 Aug 2025 13:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756561098;
	bh=G0LQPFOpkizRtJfrqOgFJqKcVXEgdYu2QAdEsC3pQtI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ImNgAQrMJBLx8Sqf84rQ0nM2MUxRON9bQKslpJp0WB2PSMV7bFbaVAzK81RIpdS48
	 oq0bMuUX1ge5zg9p06HVjFSeJ6U0DHfYIzlZiKbOgiJK1x7yzx9UjkGEmu6aI2PTKX
	 iKr2OCIi5VePoujUztqoUob1iXQPD2BekZTeSzwPuY2dt9h7xzfbjHgG1KZukS80CD
	 b7W2dcLJ5E8t0S3iusaPWtMvY7iVEZedEQ8mweY/SgcOMGFT5kbnLkFZbmznwXowKX
	 t4fDyX3kqhEzte0VhgxqpDzit9NOc/zRaxnk+2PCoC2dEJI7b5J5/ARBAL5nxOo4Go
	 rbyvxp2spiJPQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 Aug 2025 15:38:12 +0200
Message-Id: <DCFSXTUVBKL0.2CTM31D8Q8QW2@kernel.org>
Subject: Re: [PATCH 2/2] rust: regulator: add devm_regulator_get_enable API
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250829-regulator-remove-dynamic-v1-0-deb59205e8e9@collabora.com> <20250829-regulator-remove-dynamic-v1-2-deb59205e8e9@collabora.com> <DCFID32NEFH0.3JB41XV88JZ3F@nvidia.com> <DB27F561-30AD-400E-811B-19CEAE511CFA@collabora.com>
In-Reply-To: <DB27F561-30AD-400E-811B-19CEAE511CFA@collabora.com>

On Sat Aug 30, 2025 at 3:13 PM CEST, Daniel Almeida wrote:
>> On 30 Aug 2025, at 02:20, Alexandre Courbot <acourbot@nvidia.com> wrote:
>> On Sat Aug 30, 2025 at 6:11 AM JST, Daniel Almeida wrote:
>>> +/// Enables a regulator whose lifetime is tied to the lifetime of `dev=
`.
>>> +///
>>> +/// This calls `regulator_disable()` and `regulator_put()` automatical=
ly on
>>> +/// driver detach.
>>> +///
>>> +/// This API is identical to `devm_regulator_get_enable()`, and should=
 be
>>> +/// preferred if the caller only cares about the regulator being on.
>>> +pub fn enable(dev: &Device<Bound>, name: &CStr) -> Result {
>>=20
>> The name `enable` sounds like it just enables a regulator, which is a bi=
t
>> confusing IMHO. Maybe `get_enable` or `get_enable_for`? Not sure what
>> would be idiomatic here.
>
> So I thought about get_enabled, but I thought the "get" nomenclature was
> confusing. For example, "get" acquires a refcount, but for the devm_ vers=
ion
> the refcount management is transparent. In this sense, I thought that jus=
t
> "enable" would convey the idea better, i.e. "enable this and forget about=
 any
> lifetime management at all".

Technically, it does acquire a reference count, we just don't return the
corresponding regulator object to the caller, but leave the reference count=
 to
devres.

> If you still think that using the "get" prefix is better, I can change it=
 no
> worries :)

If we want to be extra correct, it should be devm_get_enable(). But the fac=
t
that devres holds a reference count is an implementation detail not relevan=
t to
the caller.

Hence, I think devm_enable() (and devm_enable_optional()) is enough. But we
should make it obvious that it's devres managed, i.e. "devm".

