Return-Path: <linux-kernel+bounces-721615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5E2AFCBAB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850C01894B5D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC92DCC1A;
	Tue,  8 Jul 2025 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwL3+wp8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A01E3761;
	Tue,  8 Jul 2025 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980526; cv=none; b=WJtJeifWXeAxiVECU62FNH2y7Hb5u8YSN1BJNG3fRo93cR/eIi0TwSY03r6NiqYwRDKG2CQ+h/IS6cw/UVRZxd+zAayY+fdxrFYEipgbEnKJLNB4O1AcI+/EpNzjwyNGfZlNjKJjeLLriOb9TxTRKl8ZBds6NfmQGv/jglSkQ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980526; c=relaxed/simple;
	bh=iwohD2gi79jnQPLDi27JHRgJNFiXkk8YiPmOVC98f/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nOEkw/RPlikMD9stlkaXbUTFasj0PvWVj/jV4ahpZ3uhXfpl9E7ESPNJvjSgb9SIdQu26IiXi8BxN+sh5NG9hQi8/GZh83JcZ36bHa4bXZRUxQBu/Wi/p9ri6HP9rpNglOLM8wDjkjdRDJfMsLopS7vpUMxHzdzipDR9onb0VqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwL3+wp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BA2C4CEF0;
	Tue,  8 Jul 2025 13:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751980525;
	bh=iwohD2gi79jnQPLDi27JHRgJNFiXkk8YiPmOVC98f/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LwL3+wp86tjF5p8jv9VOtDqKyFRSh5NfWEKUJKyfXztdzY6f7GqdaiffVmJ0TYOM8
	 i/XFFI3Bk7Pj4HFFNp7abFCnzfTzhTYrCE5gBUv6meFPaV0SRztNTKykGrqcNXMKzN
	 /pbtAQoOoX/FwhsserusxY7jq5tSzpML0T0pFc/p/kp1EOhJSVizniLyAMulwp/wIr
	 o2Wv6zLAEE313nBC7E6A/7stg24mRHvWjus89mqWBRZuQD7kMlAcBnDq5ronLzYpP7
	 tV366vil8FA3JbDTctfjIinbYGS3HqCTocDX9Rdq3u5Sa5xGc8BDY8L1Pq02GIjR8Y
	 vox86mPHLb09w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
Cc: "Oliver Mangold" <oliver.mangold@pm.me>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Asahi Lina" <lina+kernel@asahilina.net>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 4/4] rust: Add `OwnableRefCounted`
In-Reply-To: <DB5XPFYBATZZ.5EH3TWGPHTDB@kernel.org> (Benno Lossin's message of
	"Mon, 07 Jul 2025 17:39:43 +0200")
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
	<20250618-unique-ref-v11-4-49eadcdc0aa6@pm.me>
	<DB1LPFAX66WG.1QL5JDCWI7RN4@kernel.org> <aGuAR7JCrlmzQrx4@mango>
	<gFz7glX0UIHGffQdm4_vD_XkT5GZEKB0Lx0cd8-TCR8glMzIIY7VBIvppFVr2RURNBnGx9lKJqrE5av7xSUcbA==@protonmail.internalid>
	<DB5PX74OB3DX.1UNT8MIBWNC2G@kernel.org> <87bjpwqmo5.fsf@kernel.org>
	<gUxXEpuPZ0HXQ-cptykcSOV4dVbZNFvDq4Ey5YR1GT8exNFK0qhYAg4HFgWTvTpDk8HXMGl5XThvR7f4m-T6Sg==@protonmail.internalid>
	<DB5SRE5S7AR3.QUF369W9JYGJ@kernel.org> <87zfdgp253.fsf@kernel.org>
	<Kl9_mnIVP7OY9TWELXIwOVkotanEt7IsdpMx-IbaRfjHf6EF0tC06PzcC8-Z9pDiw1FQHulknmgbS9eQU28kQw==@protonmail.internalid>
	<DB5XPFYBATZZ.5EH3TWGPHTDB@kernel.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 08 Jul 2025 15:15:18 +0200
Message-ID: <87jz4iomc9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <lossin@kernel.org> writes:

> On Mon Jul 7, 2025 at 3:21 PM CEST, Andreas Hindborg wrote:
>> "Benno Lossin" <lossin@kernel.org> writes:
>>
>>> On Mon Jul 7, 2025 at 1:12 PM CEST, Andreas Hindborg wrote:
>>>> "Benno Lossin" <lossin@kernel.org> writes:
>>>>> Ah right, I forgot about this. What was the refcount characteristics =
of
>>>>> this again?
>>>>>
>>>>> *  1 =3D in flight, owned by C
>>>>> *  2 =3D in flight, owned by Rust
>>>>> * >2 =3D in flight, owned by Rust + additional references used by Rust
>>>>>        code
>>>>>
>>>>> Correct? Maybe @Andreas can check.
>>>>
>>>> We have been a bit back and forth on this. This is how we would like it
>>>> going forward:
>>>>
>>>>
>>>> /// There are three states for a request that the Rust bindings care a=
bout:
>>>> ///
>>>> /// - 0: The request is owned by C block layer or is uniquely referenc=
ed (by [`Owned<_>`]).
>>>> /// - 1: The request is owned by Rust abstractions but is not referenc=
ed.
>>>> /// - 2+: There is one or more [`ARef`] instances referencing the requ=
est.
>>>
>>> Huh, now I'm more confused... Could you go into the details again?
>>
>> Well, there is not much to it. We found out we can alias "unique" and
>> "owned by C".
>>
>> We initialize the refcount to 0 when we initialize the request
>> structure. This happens at queue creation time.
>
> And IIRC this refcount is only on the Rust side, since you store it in
> some private data, right?

Yes.

>
>> When C block layer hands over a request for processing to a Rust driver,
>> we `debug_assert!` that the refcount is 0. We unsafely invent an
>> `Owned<Request<_>>` and pass that to the driver.
>
> And you don't increment the refcount?

No, we leave it at 0.

>
>> The driver has the option of `into_shared` to obtain an
>> `ARef<Request<_>>`. We use this for remote completion and timer
>> completion in rnull.
>
> This operation will set the refcount to 2?

Yes.

>
>> In most drivers, when the driver hands off the request to the hardware,
>> the driver will stop accounting for the request. The `Owned<Request<_>>`
>> is consumed when issuing to the driver, or the driver could simply drop
>> it. Refcount goes to 1. An ID is passed along to hardware.
>
> And with the current API design it must let go of all `ARef<Request<_>>`
> because otherwise it can't call `end_ok` (or some other method?).

Exactly. That one will take an `Owned<Request<_>>` (previously `Unique`).

>
>> When a completion comes back from hardware, it carries the ID. We use
>> the C block layer `tag_to_rq` machinery to turn this ID back into an
>> `Owned<Request<_>>`. In that process, we check that `refcount =3D=3D 1` =
and
>> if so, we set refcount to 0 and invent an `Owned<Request<_>>`.
>
> (because if not, this would be wrong)

I hope it is not wrong =F0=9F=98=86 You can see the latest and greatest her=
e [1].

>
> I have some idea what we should do for the safety requirements of
> `Ownable`, but still need some time to write it down.

Great!


Best regards,
Andreas Hindborg


[1] https://git.kernel.org/pub/scm/linux/kernel/git/a.hindborg/linux.git/tr=
ee/rust/kernel/block/mq/request.rs?h=3Drnull-v6.15#n398


