Return-Path: <linux-kernel+bounces-788280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5522B38226
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6B41BA725A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16999303C88;
	Wed, 27 Aug 2025 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8u5cF2S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6023019A7;
	Wed, 27 Aug 2025 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297159; cv=none; b=iK8xz+HHtldXgMh2Ye9cHYvrGEmX8+VAwM9C/NtdvgWEFLA6Cjd3UisBwYe8A1FuXHUqnaaW726ZIzQYdkdXH2J/EG8mUp071AeGZanKvtCsKkf9BkVE/nOEdZSQ4kA6OSGO4G/3+XCgTkEvvOTDl4GvDVeKRN+Kn15X4bmq33A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297159; c=relaxed/simple;
	bh=U7W40+0vxc7wcdfrmKLjhhWcYucQeqjz/QKKtUOo7bU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Rob0lO37VQIGhM8Df9ZwOr6/6wsqqKjJcsM++5xOWaEK8h2T3Oq32vS3N6N0xChr9L+2PGDAyAbP28zLDag6GaIsoNsnaH/x/2lH/F+eD0ri+X3Mo+doc6DuQ+V0lkhxjzAuOSYdFwJzcbLLJXG+y5k2rZaz4OqL7QLWHaGaDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8u5cF2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B29C4CEF4;
	Wed, 27 Aug 2025 12:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756297158;
	bh=U7W40+0vxc7wcdfrmKLjhhWcYucQeqjz/QKKtUOo7bU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=l8u5cF2SudidspF66C+JepyroQu7V7+NaZk4fQsdB1bqr09I5bWNPF3W+BgGeqOoE
	 QWTBYsnCxHOycOVSgDzUqinM+A2R+ImB7Y0glmEUGmJ0wJ6CcoA8W03+PIoxx3MEyN
	 /QpkzHvP2qUyxLUQgOnKyxxucVKsCe6qtgrqRSJR82IjrLENsF5BB2asCNggd6tRuv
	 TQQou/N4GL1DuobV7JguH91JZsb71jkpuOzv7PLsY72dJsD/JCCPEs2VXacEraFkCE
	 pObugJR0S6Aw892emdVzVl27toi1CQE6HQj/rys7MbSGUlyd2YoZCBXJsnm9VYYn/l
	 VZ3PRPeDfzs7g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Aug 2025 14:19:11 +0200
Message-Id: <DCD7DP6A72A8.2HAYR7K7Z14UO@kernel.org>
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout_atomic function
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <a.hindborg@kernel.org>,
 <alex.gaynor@gmail.com>, <ojeda@kernel.org>, <aliceryhl@google.com>,
 <anna-maria@linutronix.de>, <bjorn3_gh@protonmail.com>,
 <boqun.feng@gmail.com>, <frederic@kernel.org>, <gary@garyguo.net>,
 <jstultz@google.com>, <linux-kernel@vger.kernel.org>, <lossin@kernel.org>,
 <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>, <sboyd@kernel.org>,
 <tglx@linutronix.de>, <tmgross@umich.edu>, <acourbot@nvidia.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
 <20250821035710.3692455-3-fujita.tomonori@gmail.com>
 <DCCF63BESWQ9.9LC8MZK7NG1Y@kernel.org>
 <20250827.091427.1081669324737480994.fujita.tomonori@gmail.com>
 <DCD35NEEPLYB.2PBCLR8FWFGKD@kernel.org>
 <DCD51BP7YXJV.3BLY6YJKGC58W@kernel.org>
 <D8CE958C-508F-4A09-96BA-985B5A7C2BA7@collabora.com>
In-Reply-To: <D8CE958C-508F-4A09-96BA-985B5A7C2BA7@collabora.com>

On Wed Aug 27, 2025 at 2:14 PM CEST, Daniel Almeida wrote:
> Hi Danilo,
>
> [=E2=80=A6}
>
>>=20
>> Actually, let me put it in other words:
>>=20
>> let val =3D read_poll_timeout_atomic(
>>     || {
>>         // Fetch the offset to read from from the HW.
>>         let offset =3D io.read32(0x1000);
>>=20
>>         // HW needs a break for some odd reason.
>>         udelay(100);
>>=20
>>         // Read the actual value.
>>         io.try_read32(offset)
>>     },
>>     |val: &u32| *val =3D=3D HW_READY,
>>     Delta::from_micros(0),      // No delay, keep spinning.
>>     Delta::from_millis(10),     // Timeout after 10ms.
>> )?;
>>=20
>> Seems like a fairly reasonable usage without knowing the implementation =
details
>> of read_poll_timeout_atomic(), right?
>>=20
>> Except that if the hardware does not become ready, this will spin for 16=
.67
>> *minutes* -- in atomic context. Instead of the 10ms the user would expec=
t.
>>=20
>> This would be way less error prone if we do not provide a timeout value,=
 but a
>> retry count.
>>=20
>>> Instead, I think it makes much more sense to provide a retry count as f=
unction
>>> argument, such that the user can specify "I want a dealy of 100us, try =
it 100
>>> times".
>>>=20
>>> This way it is transparent to the caller that the timeout may be signif=
icantly
>>> more than 10ms depending on the user's implementation.
>>>=20
>>> As for doing this in C vs Rust: I don't think things have to align in e=
very
>>> implementation detail. If we can improve things on the Rust side from t=
he
>>> get-go, we should not stop ourselves from doing so, just because a simi=
lar C
>>> implementation is hard to refactor, due to having a lot of users alread=
y.
>
> I must say I do not follow. Can you expand yet some more on this?

Sure, but it would help if you could clarify which aspect you want me to ex=
pand
on. :)

