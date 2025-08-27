Return-Path: <linux-kernel+bounces-787970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 818A8B37E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9B01899C9C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B074833473B;
	Wed, 27 Aug 2025 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELberhrV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062B23E320;
	Wed, 27 Aug 2025 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756285243; cv=none; b=Z0hP0WMwJ+udLvNFLjy1nQbG6w67mjNIuVA+rNRyvL18HFTkVk3RyZkxlqf3H+BnYEbIL8epVAqIATP28qQX5Yst6XWMoCHO1QokepL0dpL0cuKQSCp2CN9lAgEPTUZcVrTawmwGkwg/FkgfaxjhMYeP/k5+2LIgBiL9FW4HjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756285243; c=relaxed/simple;
	bh=P1tW4Fc9pM5RV/+5zvx2josqESpA9cn6WEoOk4XH7LM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=FzjI8eK03CaPEQMQfeMqzdpcDhQL21fzX02Q6GdKJ2BrK+KppN7c8XOJNO9i2E8vxS6+S92KhuACPuxeGE9ZIocL+FR+5AlBdP7zj5IR47yeYI3Y96L4MkZ4Xo12xuuHdTyZis5UAuRn+YGtyXwDynuVbSOBd4hvuDerDpg/6Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELberhrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC7BC4CEEB;
	Wed, 27 Aug 2025 09:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756285242;
	bh=P1tW4Fc9pM5RV/+5zvx2josqESpA9cn6WEoOk4XH7LM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ELberhrVZ7pB1Z/QLQM3O2Q4963L8HxBpPlpR1IiQvgi9ZYUPSFhesta0JuJqvbBd
	 OSTSXfl+D9/R4pqh73sJd+N+gI7vhKyfSpIKJtWax93Nxkkd29KGFqg9CFUvnWK+t+
	 c/Tw6RQDkGP/VvU2yrfKqI8P6x8qU1g6Ulw8k5QhniXnOaxRblTc6VBp6nUbxbJNu+
	 NUb/ax/DsJN2eI1c2J+3pIsZMWLmgPH97O25kgjOJQapm+6yM1cLUtVKFDuJWzHQVW
	 uzIN7aKTy6QAAY8WtwEFFTy13qK7c7W+4/XDnOMY0SP5E3TCuZd4An+jSTEOBVPk/R
	 4f0pHjlYTVgZA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Aug 2025 11:00:36 +0200
Message-Id: <DCD35NEEPLYB.2PBCLR8FWFGKD@kernel.org>
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout_atomic function
Cc: <a.hindborg@kernel.org>, <alex.gaynor@gmail.com>, <ojeda@kernel.org>,
 <aliceryhl@google.com>, <anna-maria@linutronix.de>,
 <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>, <frederic@kernel.org>,
 <gary@garyguo.net>, <jstultz@google.com>, <linux-kernel@vger.kernel.org>,
 <lossin@kernel.org>, <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
 <sboyd@kernel.org>, <tglx@linutronix.de>, <tmgross@umich.edu>,
 <acourbot@nvidia.com>, <daniel.almeida@collabora.com>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
 <20250821035710.3692455-3-fujita.tomonori@gmail.com>
 <DCCF63BESWQ9.9LC8MZK7NG1Y@kernel.org>
 <20250827.091427.1081669324737480994.fujita.tomonori@gmail.com>
In-Reply-To: <20250827.091427.1081669324737480994.fujita.tomonori@gmail.com>

On Wed Aug 27, 2025 at 2:14 AM CEST, FUJITA Tomonori wrote:
> On Tue, 26 Aug 2025 16:12:44 +0200
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>
>> On Thu Aug 21, 2025 at 5:57 AM CEST, FUJITA Tomonori wrote:
>>> +pub fn read_poll_timeout_atomic<Op, Cond, T>(
>>> +    mut op: Op,
>>> +    mut cond: Cond,
>>> +    delay_delta: Delta,
>>> +    timeout_delta: Delta,
>>> +) -> Result<T>
>>> +where
>>> +    Op: FnMut() -> Result<T>,
>>> +    Cond: FnMut(&T) -> bool,
>>> +{
>>> +    let mut left_ns =3D timeout_delta.as_nanos();
>>> +    let delay_ns =3D delay_delta.as_nanos();
>>> +
>>> +    loop {
>>> +        let val =3D op()?;
>>> +        if cond(&val) {
>>> +            // Unlike the C version, we immediately return.
>>> +            // We know the condition is met so we don't need to check =
again.
>>> +            return Ok(val);
>>> +        }
>>> +
>>> +        if left_ns < 0 {
>>> +            // Unlike the C version, we immediately return.
>>> +            // We have just called `op()` so we don't need to call it =
again.
>>> +            return Err(ETIMEDOUT);
>>> +        }
>>> +
>>> +        if !delay_delta.is_zero() {
>>> +            udelay(delay_delta);
>>> +            left_ns -=3D delay_ns;
>>> +        }
>>> +
>>> +        cpu_relax();
>>> +        left_ns -=3D 1;
>>=20
>> How do we know that each iteration costs 1ns? To make it even more obvio=
us, we
>> don't control the implementation of cond(). Shouldn't we use ktime for t=
his?
>
> The C version used to use ktime but it has been changed not to:
>
> 7349a69cf312 ("iopoll: Do not use timekeeping in read_poll_timeout_atomic=
()")

Ick! That's pretty unfortunate -- no ktime then.

But regardless of that, the current implementation (this and the C one) lac=
k
clarity.

The nanosecond decrement is rather negligible, the real timeout reduction c=
omes
from the delay_delta. Given that, and the fact that we can't use ktime, thi=
s
function shouldn't take a raw timeout value, since we can't guarantee the
timeout anyways.

Instead, I think it makes much more sense to provide a retry count as funct=
ion
argument, such that the user can specify "I want a dealy of 100us, try it 1=
00
times".

This way it is transparent to the caller that the timeout may be significan=
tly
more than 10ms depending on the user's implementation.

As for doing this in C vs Rust: I don't think things have to align in every
implementation detail. If we can improve things on the Rust side from the
get-go, we should not stop ourselves from doing so, just because a similar =
C
implementation is hard to refactor, due to having a lot of users already.

