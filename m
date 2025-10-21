Return-Path: <linux-kernel+bounces-862849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C88BF65A3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D11A354EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB83A330D3D;
	Tue, 21 Oct 2025 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9P3pQUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0C21F2B88;
	Tue, 21 Oct 2025 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048488; cv=none; b=TghknI36tYHW+l4oYwQosLh3E1kSWLpW4r/V7vrmK5KYV/6d8uCcXvs2AA3MELsC5ApTJR94vr2mUQBIK4qZaENKOHJNolT+XDPlPGeJlObckHOEsqEptk5J5t/QdV/ANM75OTaCE46tW/+lSxsp/HRxwFTuS/SEgD6fHBFKqlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048488; c=relaxed/simple;
	bh=7DjHgBoForzBw/ioH3OskBDRvNSN8D2M0ntMyu89rk0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=CgznfxuhbgeB6V5s3lvoLYeQjfq+542wL8hCw9r/3RcesBxkDDc+RZmiSXqjxPHh1CpHpu1p+Wd//hQN1AUbt3EdBHGqLPmqO/1/d4/6dmEc/A3/Kf/ehKpml+EQv/kjGfSQ90Fj8QnbVjEuTaUpMFWmob8ILcv2fHGHA41jdpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9P3pQUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E295BC4CEF1;
	Tue, 21 Oct 2025 12:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761048487;
	bh=7DjHgBoForzBw/ioH3OskBDRvNSN8D2M0ntMyu89rk0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=J9P3pQUvzibpU8f7v1NobcfFYWkgpqQBGXRQg2MfGmQrHPgwCkLdxYsw7PrV9R63R
	 hLAAgvuUmwLANJHtu4G8YKW1WWVkVHYu9BmCiT7wwAU/tSj8wA4f8E8Tn4t0PRzzSH
	 uyF2J3C30kMQSLjB3itnXb8nXa7csFsk2M6JJtO1kCkT0BuAh1vAvTwaelbwNKWSAE
	 H26Yl9EjNY9e/h6CzgwAKRNXGgRx8DC69g6LTgr85FyLk3wkSORaRY2G3sxh7hD8X/
	 2huMzKTJ1Or45/KvGmOW4Z9Wjm9KlLjFNAn3M1r3IQ/jZfRyuYQn3ScO5Ec0rgSqgj
	 1+JpAcEMJ0XJw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 14:08:02 +0200
Message-Id: <DDNZL452A8JR.K1AA7LHZEXW8@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: add udelay() function
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <a.hindborg@kernel.org>, <alex.gaynor@gmail.com>, <ojeda@kernel.org>,
 <anna-maria@linutronix.de>, <bjorn3_gh@protonmail.com>,
 <boqun.feng@gmail.com>, <frederic@kernel.org>, <gary@garyguo.net>,
 <jstultz@google.com>, <linux-kernel@vger.kernel.org>, <lossin@kernel.org>,
 <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>, <sboyd@kernel.org>,
 <tglx@linutronix.de>, <tmgross@umich.edu>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251021071146.2357069-1-fujita.tomonori@gmail.com>
 <20251021071146.2357069-2-fujita.tomonori@gmail.com>
In-Reply-To: <20251021071146.2357069-2-fujita.tomonori@gmail.com>

On Tue Oct 21, 2025 at 9:11 AM CEST, FUJITA Tomonori wrote:
> Add udelay() function, inserts a delay based on microseconds with busy
> waiting, in preparation for supporting read_poll_count_atomic().
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/helpers/time.c       |  5 +++++
>  rust/kernel/time/delay.rs | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
> index a318e9fa4408..67a36ccc3ec4 100644
> --- a/rust/helpers/time.c
> +++ b/rust/helpers/time.c
> @@ -33,3 +33,8 @@ s64 rust_helper_ktime_to_ms(const ktime_t kt)
>  {
>  	return ktime_to_ms(kt);
>  }
> +
> +void rust_helper_udelay(unsigned long usec)
> +{
> +	udelay(usec);
> +}
> diff --git a/rust/kernel/time/delay.rs b/rust/kernel/time/delay.rs
> index eb8838da62bc..fb7c15dfe186 100644
> --- a/rust/kernel/time/delay.rs
> +++ b/rust/kernel/time/delay.rs
> @@ -47,3 +47,40 @@ pub fn fsleep(delta: Delta) {
>          bindings::fsleep(delta.as_micros_ceil() as c_ulong)
>      }
>  }
> +
> +/// Inserts a delay based on microseconds with busy waiting.
> +///
> +/// Equivalent to the C side [`udelay()`], which delays in microseconds.
> +///
> +/// `delta` must be within `[0, `MAX_UDELAY_MS`]` in milliseconds;
> +/// otherwise, it is erroneous behavior. That is, it is considered a bug=
 to
> +/// call this function with an out-of-range value, in which case the fun=
ction
> +/// will insert a delay for at least the maximum value in the range and
> +/// may warn in the future.

I think clamping the given value to Delta::ZERO..=3DMAX_UDELAY_DELTA is the
correct thing to do and it should be mentioned by the documentation of the
function (as you do already).

However, if we want to consider it an error if an out of range value is giv=
en,
we should just return a Result. (A simple out of range condition, that can =
be
handled by the user easily shouldn't result into a potential WARN()).

Additionally, we can also have an infallible version of udelay() that evalu=
ates
the delta at build time.

Another alternative would be to just clamp the value and call it a day (i.e=
. do
not consider out of range values to be an error).

I don't mind one or the other, but I'm against adding a WARN() for somethin=
g
that can be handled with a Result easily *and* is already handled gracefull=
y.

> +///
> +/// The behavior above differs from the C side [`udelay()`] for which ou=
t-of-range
> +/// values could lead to an overflow and unexpected behavior.
> +///
> +/// [`udelay()`]: https://docs.kernel.org/timers/delay_sleep_functions.h=
tml#c.udelay
> +pub fn udelay(delta: Delta) {
> +    const MAX_UDELAY_DELTA: Delta =3D Delta::from_millis(bindings::MAX_U=
DELAY_MS as i64);
> +
> +    let delta =3D if (Delta::ZERO..=3DMAX_UDELAY_DELTA).contains(&delta)=
 {
> +        delta
> +    } else {
> +        // TODO: Add WARN_ONCE() when it's supported.
> +        MAX_UDELAY_DELTA
> +    };
> +
> +    // SAFETY: It is always safe to call `udelay()` with any duration.
> +    // Note that the kernel is compiled with `-fno-strict-overflow`
> +    // so any out-of-range value could lead to unexpected behavior
> +    // but won't lead to undefined behavior.
> +    unsafe {
> +        // Convert the duration to microseconds and round up to preserve
> +        // the guarantee; `udelay()` inserts a delay for at least
> +        // the provided duration, but that it may delay for longer
> +        // under some circumstances.
> +        bindings::udelay(delta.as_micros_ceil() as c_ulong)
> +    }
> +}
> --=20
> 2.43.0


