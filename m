Return-Path: <linux-kernel+bounces-734178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C79B07E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CE7A449CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7180E2D3757;
	Wed, 16 Jul 2025 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8MkCdBg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F1288C2C;
	Wed, 16 Jul 2025 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694371; cv=none; b=m2O2GIeM7m4F1TGme7+7oUepBxqlDV6mzZUl5lAJHV4Ztba4WgwD/gPqcyAYvjKZwPzy+O3QCOgayroYCzO7743bsrxEV8G/RL09ucMqjRliElyPnwhdyn8iBkbQw6dFNrn4WaO571Wai//kVw9uk2yP/V04uKMBZ2mOWVcV4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694371; c=relaxed/simple;
	bh=2DyOKJP7aKBHWg3wvE3e/BAL/NCFCynaRLW4W2mN880=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=bbWizhRzCoT9rdNL3kzOFBjLPRZVOxsHedJLR1UMqQo/5RzamuCwt7f9LHXOWpU1PMwirfHZ1AT+y46lbktuv1z98w8zKp3Ib2U5uh4wZFR1BuNi5twrrGnsOWXa/7+uy2kZIKXFztaKi76Va0LzpTTSXStiQvfzFZVe1bIXPXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8MkCdBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA276C4CEF1;
	Wed, 16 Jul 2025 19:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752694371;
	bh=2DyOKJP7aKBHWg3wvE3e/BAL/NCFCynaRLW4W2mN880=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=O8MkCdBgupOAeoBvlyzfaK/fVFPCcIcpMw0jxBuD3//hlUDEg9ok/V9bFdLpFsbDY
	 AS+bVWxK9jH0pUYApv1W6QcaE9nagPmFPYIS3jZr6U56SrJ4sVcxm8bXBArLmlp+67
	 pVCV5jZp8UAP9qyat+qg0udAjcH22Lzn1QmHuJo2POe7RjKiFbUrBXN36qK+bSgZ0q
	 A6s7ichqOg7T1pc6/12eQK5FePmj6JIP1UgG0yIancC5WttzTZ3g9V/xRMkNcBI4AR
	 eq1MvDxVuhZycChAW8wrs+um0T2U8k3tHIaP9RqMMWAyhogJDPbjM4m9JWyTjLDHEy
	 bAePdCDBRRetA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 21:32:47 +0200
Message-Id: <DBDQASMSS32U.FJBYKS3LWEQ6@kernel.org>
Subject: Re: [PATCH v9] rust: kernel: add support for bits/genmask macros
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250714-topics-tyr-genmask2-v9-1-9e6422cbadb6@collabora.com>
 <DBDP54SLN4EZ.2EQ004NXWCX2L@kernel.org>
 <705CD461-60D9-492E-B82F-C88A848A4348@collabora.com>
In-Reply-To: <705CD461-60D9-492E-B82F-C88A848A4348@collabora.com>

On Wed Jul 16, 2025 at 9:11 PM CEST, Daniel Almeida wrote:
> Let=E2=80=99s transfer this discussion to this patch.
>
>> I also quickly tried genmask and I have a few questions:
>>=20
>>  (1) Why does genmask not use a const generic? I think this makes it mor=
e
>>      obvious that it's only intended to be used from const context.
>
> I guess none of us thought about it, since the current version also works=
.

I think using a const generic would be a bit better for the mentioned reaso=
n.

>>=20
>>  (2) Why is there no build_assert() when the range exceeds the number of=
 bits
>>      of the target type? I would expect genmask_u64(0..100) to fail.
>
> Doesn=E2=80=99t it?
>
> There is a build_assert in the underlying bit implementation. It was redu=
ndant
> to have it both in bit_* and in genmask, because genmask calls bit().
>
> In your example, bit_u64(100) hits that assert, and so it shouldn't compi=
le.

Indeed, and it also works, except from doc-tests for some reason, which is =
what
I tried real quick. :)

>>  (3) OOC, why did you choose u32 as argument type?
>
> No reason. i32 is the default integer type and signed integers don=E2=80=
=99t make
> sense here, so I chose u32.
>
> Also, we can trivially promote integers to wider types,  but the other wa=
y
> around is not true. So my reasoning was that if you had u8, or u16s you c=
ould
> trivially get u32s using into(), but if you had u32s and e.g. genmask_u16
> required u16s, you'd have to resort to try_into() or `as`, which is annoy=
ing.
>
> In any case, feel free to suggest anything else, I think.

I feel like usize would be a better fit, but not a strong opinion.

