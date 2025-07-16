Return-Path: <linux-kernel+bounces-734206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21982B07E60
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD1107BB9DC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407D329B20A;
	Wed, 16 Jul 2025 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax/Dho5C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACBB285C97;
	Wed, 16 Jul 2025 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695359; cv=none; b=cic/qw+IX8YE2u72h2eT2OEfkJNCNCi9KEOzo/EKu0bzjF2mHkez/FwZlgH6GeC3STRB8Hd/ytvapPQpLyIJkHETGP4g9+2bxuz7q7g+mJU5amPjBkP8CuXZ0WmpK8ppdmmzLpt5vv9fkzqZyDIMlkcdqreR8VqMpVOeOYZV4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695359; c=relaxed/simple;
	bh=98eAA74NZUa1xoj0lpaxUpd2ScY1y0L8aj2pUiMsOUM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=G0NvzLWNPh4e6UbS3H0flXZOdT0gPi5/8HKLJh/vEEvi8n+koHgYL+Fd+KaxjfEgMs0uqYqrw4KGfKteUxbN5ShoDeixlZdjzLVbY1FnZoz7Ngdsv8RYdW9CI9fQZopplzJ8RNa49sr0HJhzx1Bc73kiOvUUR+ktQWhNAPqB+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax/Dho5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9855FC4CEF5;
	Wed, 16 Jul 2025 19:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752695357;
	bh=98eAA74NZUa1xoj0lpaxUpd2ScY1y0L8aj2pUiMsOUM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Ax/Dho5CmKErIgSpo/gUNZAa4hSWtbNiI842kl+gpq3hkjsS/tUe3ZrFJzjh3UWK/
	 zLgU6wF8GbfM2/hyA+mtCu+XphUjdIQ9G75ct/++d6j68ENsOGl63bJqQd72/vRcD3
	 JZPc15vnm4B1oaSlOw/KLP96GVbf6O252SJny9Tlkr/AtouqFQlHa7eaR1EhiO96wy
	 oEyB7SqC0pKq9dwQooh0M9SaFkDtWRrJTe/wB+mo+/t+nSN9hx3pzabJ+FR+HidQRN
	 2Ts8qU6uPYIVQnmPsZ6gLdu4Qrk9icmCddsk/mvG9PSm+o03rz7A1LdTkivk1tCUfO
	 JtTn2l1C/+qWQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 21:49:12 +0200
Message-Id: <DBDQNDJDV41H.I58GXBM55PVG@kernel.org>
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
 <DBDQASMSS32U.FJBYKS3LWEQ6@kernel.org>
 <1DCA3EA2-5CBB-4193-B1D3-7E286C344A14@collabora.com>
In-Reply-To: <1DCA3EA2-5CBB-4193-B1D3-7E286C344A14@collabora.com>

On Wed Jul 16, 2025 at 9:44 PM CEST, Daniel Almeida wrote:
>
>
>> On 16 Jul 2025, at 16:32, Danilo Krummrich <dakr@kernel.org> wrote:
>>=20
>> On Wed Jul 16, 2025 at 9:11 PM CEST, Daniel Almeida wrote:
>>> Let=E2=80=99s transfer this discussion to this patch.
>>>=20
>>>> I also quickly tried genmask and I have a few questions:
>>>>=20
>>>> (1) Why does genmask not use a const generic? I think this makes it mo=
re
>>>>     obvious that it's only intended to be used from const context.
>>>=20
>>> I guess none of us thought about it, since the current version also wor=
ks.
>>=20
>> I think using a const generic would be a bit better for the mentioned re=
ason.
>
> Btw, how does monomorphization work here? Would we have to codegen all th=
e
> versions? Also, I don't think that you can take a range as a const generi=
c
> argument, i.e., I don't recall ever seeing this syntax:
>
> genmask_u64::<0..=3D63>();

Ah, of course, it's RangeInclusive, just scratch the const generic proposal=
. :)

>>>> (2) Why is there no build_assert() when the range exceeds the number o=
f bits
>>>>     of the target type? I would expect genmask_u64(0..100) to fail.
>>>=20
>>> Doesn=E2=80=99t it?
>>>=20
>>> There is a build_assert in the underlying bit implementation. It was re=
dundant
>>> to have it both in bit_* and in genmask, because genmask calls bit().
>>>=20
>>> In your example, bit_u64(100) hits that assert, and so it shouldn't com=
pile.
>>=20
>> Indeed, and it also works, except from doc-tests for some reason, which =
is what
>> I tried real quick. :)
>>=20
>
> Wait, this was a bit confusing :)
> You=E2=80=99re confirming that it doesn=E2=80=99t compile, correct?

Yes, except for in doc-tests for some reason.

>> I feel like usize would be a better fit, but not a strong opinion.
>
> I guess this is the same problem as u64: drivers will usually have either
> i32s/u32s and this would require a cast.

I don't understand this argument? We usualy use usize for such things, no?

>
> =E2=80=94 Daniel


