Return-Path: <linux-kernel+bounces-788117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3C9B37FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1898C7B2A80
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1E134A333;
	Wed, 27 Aug 2025 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkHlRj2L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0187523D7EC;
	Wed, 27 Aug 2025 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756290546; cv=none; b=aZOMzOud+gahqd/GgERDGkyy6EmWp4kE7SCKHuw63kRZOPO8ehos7abf3pKeuYgWs/Go02rQrnP0zcudPhgmeM9do46/tw8TggOO9CjLXK41gxgMluTo5uUKoG/11RU+h8J2WyUYq3iOuhUCyKYs+UtN++n42A9ErbGHsjFLpVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756290546; c=relaxed/simple;
	bh=6R2/69tk9XPT/gZw94FC0U4rmPvshOcT8Ms4HMWc+5Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Qsx1c1NR6EiDD6yNbHPo0qYGC1Ma9YSdbauJaLgnIY0BvzP1CmdMSGKB4EOqbfkLh1CKOONqqiuvYmYHyPufU6Y3P9lTXtwzRgQueQVVyZyq3mBDlZZ2Apxb3Uz4PU8u0dzOaee0t9WdQG6eshaoYzDUSO2Hx4+rN4jTQ/Xsz7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkHlRj2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF077C4CEEB;
	Wed, 27 Aug 2025 10:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756290545;
	bh=6R2/69tk9XPT/gZw94FC0U4rmPvshOcT8Ms4HMWc+5Y=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=qkHlRj2LKe0uccPHmjCraiG4q1WAEVizWL7D9pGTXu5kQLJruRXg7df1cm2LbMb8z
	 mdMVV8wdJd3nsQJiB92wceGZmoQOtntQBrhT0931OBAFw5azbrDymoibVV7nBIE+aF
	 WDDx6+lEAmdGKMoind/aFe/oaDbZPejcbn+ZqZ/KrAZMC6NYLlb1ujWTCek2KpV1h+
	 970GwKA9HBUKOypi3+7xLyL6LSup9GrGy34XkFNPL6xt9DSTJTfUn6KD0pVOAHlmMy
	 eRHLwvS340NpzV0U7sLTsAleiY2rr1GB0tosSiqsSYu8vh9xswy0BjEG1A8YxP8MLh
	 9DVmsxHI/eXjg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Aug 2025 12:29:00 +0200
Message-Id: <DCD51BP7YXJV.3BLY6YJKGC58W@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout_atomic function
Cc: <a.hindborg@kernel.org>, <alex.gaynor@gmail.com>, <ojeda@kernel.org>,
 <aliceryhl@google.com>, <anna-maria@linutronix.de>,
 <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>, <frederic@kernel.org>,
 <gary@garyguo.net>, <jstultz@google.com>, <linux-kernel@vger.kernel.org>,
 <lossin@kernel.org>, <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
 <sboyd@kernel.org>, <tglx@linutronix.de>, <tmgross@umich.edu>,
 <acourbot@nvidia.com>, <daniel.almeida@collabora.com>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
References: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
 <20250821035710.3692455-3-fujita.tomonori@gmail.com>
 <DCCF63BESWQ9.9LC8MZK7NG1Y@kernel.org>
 <20250827.091427.1081669324737480994.fujita.tomonori@gmail.com>
 <DCD35NEEPLYB.2PBCLR8FWFGKD@kernel.org>
In-Reply-To: <DCD35NEEPLYB.2PBCLR8FWFGKD@kernel.org>

On Wed Aug 27, 2025 at 11:00 AM CEST, Danilo Krummrich wrote:
> On Wed Aug 27, 2025 at 2:14 AM CEST, FUJITA Tomonori wrote:
>> On Tue, 26 Aug 2025 16:12:44 +0200
>> "Danilo Krummrich" <dakr@kernel.org> wrote:
>>
>>> On Thu Aug 21, 2025 at 5:57 AM CEST, FUJITA Tomonori wrote:
>>>> +pub fn read_poll_timeout_atomic<Op, Cond, T>(
>>>> +    mut op: Op,
>>>> +    mut cond: Cond,
>>>> +    delay_delta: Delta,
>>>> +    timeout_delta: Delta,
>>>> +) -> Result<T>
>>>> +where
>>>> +    Op: FnMut() -> Result<T>,
>>>> +    Cond: FnMut(&T) -> bool,
>>>> +{
>>>> +    let mut left_ns =3D timeout_delta.as_nanos();
>>>> +    let delay_ns =3D delay_delta.as_nanos();
>>>> +
>>>> +    loop {
>>>> +        let val =3D op()?;
>>>> +        if cond(&val) {
>>>> +            // Unlike the C version, we immediately return.
>>>> +            // We know the condition is met so we don't need to check=
 again.
>>>> +            return Ok(val);
>>>> +        }
>>>> +
>>>> +        if left_ns < 0 {
>>>> +            // Unlike the C version, we immediately return.
>>>> +            // We have just called `op()` so we don't need to call it=
 again.
>>>> +            return Err(ETIMEDOUT);
>>>> +        }
>>>> +
>>>> +        if !delay_delta.is_zero() {
>>>> +            udelay(delay_delta);
>>>> +            left_ns -=3D delay_ns;
>>>> +        }
>>>> +
>>>> +        cpu_relax();
>>>> +        left_ns -=3D 1;
>>>=20
>>> How do we know that each iteration costs 1ns? To make it even more obvi=
ous, we
>>> don't control the implementation of cond(). Shouldn't we use ktime for =
this?
>>
>> The C version used to use ktime but it has been changed not to:
>>
>> 7349a69cf312 ("iopoll: Do not use timekeeping in read_poll_timeout_atomi=
c()")
>
> Ick! That's pretty unfortunate -- no ktime then.
>
> But regardless of that, the current implementation (this and the C one) l=
ack
> clarity.
>
> The nanosecond decrement is rather negligible, the real timeout reduction=
 comes
> from the delay_delta. Given that, and the fact that we can't use ktime, t=
his
> function shouldn't take a raw timeout value, since we can't guarantee the
> timeout anyways.

Actually, let me put it in other words:

	let val =3D read_poll_timeout_atomic(
	    || {
	        // Fetch the offset to read from from the HW.
	        let offset =3D io.read32(0x1000);
=09
	        // HW needs a break for some odd reason.
	        udelay(100);
=09
	        // Read the actual value.
	        io.try_read32(offset)
	    },
	    |val: &u32| *val =3D=3D HW_READY,
	    Delta::from_micros(0),      // No delay, keep spinning.
	    Delta::from_millis(10),     // Timeout after 10ms.
	)?;

Seems like a fairly reasonable usage without knowing the implementation det=
ails
of read_poll_timeout_atomic(), right?

Except that if the hardware does not become ready, this will spin for 16.67
*minutes* -- in atomic context. Instead of the 10ms the user would expect.

This would be way less error prone if we do not provide a timeout value, bu=
t a
retry count.

> Instead, I think it makes much more sense to provide a retry count as fun=
ction
> argument, such that the user can specify "I want a dealy of 100us, try it=
 100
> times".
>
> This way it is transparent to the caller that the timeout may be signific=
antly
> more than 10ms depending on the user's implementation.
>
> As for doing this in C vs Rust: I don't think things have to align in eve=
ry
> implementation detail. If we can improve things on the Rust side from the
> get-go, we should not stop ourselves from doing so, just because a simila=
r C
> implementation is hard to refactor, due to having a lot of users already.

