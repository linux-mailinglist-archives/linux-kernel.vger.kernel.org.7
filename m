Return-Path: <linux-kernel+bounces-762301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010C3B204A8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87253BE3A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13E721D00E;
	Mon, 11 Aug 2025 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lm5gnyO/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0E1DB377;
	Mon, 11 Aug 2025 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906162; cv=none; b=Tcm9cb+s8zDA3YxPur6xXZzx/PEeQsb+XdmAG4VxKPbdcdVjCmnIk/6yoUGQo1lDq/Ap8gc6+iHZ6YUwDL/ou1px4nY5Whk2Hp8up4YEUFRqwM72wJTPA71vQZO7z2cPkf2xl+aTZupN5J7DD/zlxcDBrfWMVt0rgG2O/HAieS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906162; c=relaxed/simple;
	bh=6ddEsZkTPgyJ6G4W6EfflK7Fh+rgwc3ZN+EeVMY+p+U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SmfZNfQjoK1QVyEfQCSLzwjypBBejmfWgc3JNyaJsSeQMdBfvShHXlDopkQMPz+vcoeecZYwChMtVwAtMKGIeZjr+5ori01JQf51PXeuh19NJDBAy7odxBQgwH+Ae1rpf8PPcPzC0SHEtpjIbRq3VlooYe9I/ts5cDPfBvb9a14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lm5gnyO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A68C4CEED;
	Mon, 11 Aug 2025 09:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754906162;
	bh=6ddEsZkTPgyJ6G4W6EfflK7Fh+rgwc3ZN+EeVMY+p+U=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=lm5gnyO/wMWT3X7lLF80WkKVYsyFXF+2dkd1lDsJ0eB6BA1Wq7oAHZnKFR4YWTN3v
	 i7BfO5a95oK2wMD78+bmWhMLYEd+EI+8T4UPk2JkHFJhVw0AzKUg4KRB/FFdf3iJqN
	 GegiYC8OmZPC1PENcdDxZd1u+09w/dBsNC1wlNJWSSyNUYoLDpz8/YZamh/MO+g+qS
	 oHzumA+8PraoVm8y2VGKe8hiavyQC6+r/H2Uxu1oHIOOSK3klmcnQSlGY4IvWFb8Sp
	 jZeB7jP9M56jL0kvgfWO7QkCX56Axpkzvfi7ZgFLZpAS3ks5IFTAL4xTR63vrWWnNW
	 +IG7eUv0zAJxg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Aug 2025 11:55:56 +0200
Message-Id: <DBZIBAUIBYNH.3I8AZG4I8I59E@kernel.org>
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout functions
Cc: <a.hindborg@kernel.org>, <alex.gaynor@gmail.com>, <ojeda@kernel.org>,
 <aliceryhl@google.com>, <anna-maria@linutronix.de>,
 <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>, <frederic@kernel.org>,
 <gary@garyguo.net>, <jstultz@google.com>, <linux-kernel@vger.kernel.org>,
 <lossin@kernel.org>, <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
 <sboyd@kernel.org>, <tglx@linutronix.de>, <tmgross@umich.edu>,
 <acourbot@nvidia.com>, <daniel.almeida@collabora.com>, "Fiona Behrens"
 <me@kloenk.dev>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250811041039.3231548-1-fujita.tomonori@gmail.com>
 <20250811041039.3231548-3-fujita.tomonori@gmail.com>
In-Reply-To: <20250811041039.3231548-3-fujita.tomonori@gmail.com>

On Mon Aug 11, 2025 at 6:10 AM CEST, FUJITA Tomonori wrote:
> Add read_poll_timeout functions which poll periodically until a
> condition is met or a timeout is reached.
>
> The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
> macro and a simple wrapper for Rust doesn't work. So this implements
> the same functionality in Rust.
>
> The C version uses usleep_range() while the Rust version uses
> fsleep(), which uses the best sleep method so it works with spans that
> usleep_range() doesn't work nicely with.
>
> The sleep_before_read argument isn't supported since there is no user
> for now. It's rarely used in the C version.
>
> read_poll_timeout() can only be used in a nonatomic context. This
> requirement is not checked by these abstractions, but it is intended
> that klint [1] or a similar tool will be used to check it in the
> future.
>
> Link: https://rust-for-linux.com/klint [1]
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/time.rs      |   1 +
>  rust/kernel/time/poll.rs | 104 +++++++++++++++++++++++++++++++++++++++

Hm, are we should this should go in the time module? I does use timekeeping
stuff, but not every user of timekeeping stuff should go under the time mod=
ule.

This is rather I/O stuff and I'd expect it in rust/kernel/io/poll.rs instea=
d.

> +/// Polls periodically until a condition is met or a timeout is reached.
> +///
> +/// The function repeatedly executes the given operation `op` closure an=
d
> +/// checks its result using the condition closure `cond`.
> +///
> +/// If `cond` returns `true`, the function returns successfully with the=
 result of `op`.
> +/// Otherwise, it waits for a duration specified by `sleep_delta`
> +/// before executing `op` again.
> +///
> +/// This process continues until either `cond` returns `true` or the tim=
eout,
> +/// specified by `timeout_delta`, is reached. If `timeout_delta` is `Non=
e`,
> +/// polling continues indefinitely until `cond` evaluates to `true` or a=
n error occurs.
> +///
> +/// This function can only be used in a nonatomic context.
> +///
> +/// # Examples
> +///
> +/// ```no_run
> +/// use kernel::io::Io;
> +/// use kernel::time::{poll::read_poll_timeout, Delta};
> +///
> +/// const HW_READY: u16 =3D 0x01;
> +///
> +/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result<()>=
 {
> +///     // The `op` closure reads the value of a specific status registe=
r.
> +///     let op =3D || -> Result<u16> { io.try_read16(0x1000) };
> +///
> +///     // The `cond` closure takes a reference to the value returned by=
 `op`
> +///     // and checks whether the hardware is ready.
> +///     let cond =3D |val: &u16| *val =3D=3D HW_READY;
> +///
> +///     match read_poll_timeout(op, cond, Delta::from_millis(50), Some(D=
elta::from_secs(3))) {
> +///         Ok(_) =3D> {
> +///             // The hardware is ready. The returned value of the `op`=
` closure isn't used.
> +///             Ok(())
> +///         }
> +///         Err(e) =3D> Err(e),
> +///     }
> +/// }
> +/// ```

This is exactly what I had in mind, thanks!

> +/// ```rust
> +/// use kernel::sync::{SpinLock, new_spinlock};
> +/// use kernel::time::Delta;
> +/// use kernel::time::poll::read_poll_timeout;
> +///
> +/// let lock =3D KBox::pin_init(new_spinlock!(()), kernel::alloc::flags:=
:GFP_KERNEL)?;
> +/// let g =3D lock.lock();
> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Some=
(Delta::from_micros(42)));

I assume you want to demonstrate misuse from atomic contex here? I'd rather=
 not
do so. But if we really want that, there should be a *very* obvious comment
about this being wrong somewhere.

> +/// drop(g);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +#[track_caller]
> +pub fn read_poll_timeout<Op, Cond, T>(
> +    mut op: Op,
> +    mut cond: Cond,
> +    sleep_delta: Delta,
> +    timeout_delta: Option<Delta>,
> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: FnMut(&T) -> bool,
> +{
> +    let start: Instant<Monotonic> =3D Instant::now();
> +    let sleep =3D !sleep_delta.is_zero();
> +
> +    // Unlike the C version, we always call `might_sleep()`.

I think we should explain why, i.e. the argument about being error prone, c=
lear
separation of read_poll_timeout() and read_poll_timeout_atomic() for klint,=
 etc.
(I also think the C version should not have done this conditionally to begi=
n
with.)

> +    might_sleep();
> +
> +    loop {
> +        let val =3D op()?;
> +        if cond(&val) {
> +            // Unlike the C version, we immediately return.
> +            // We know the condition is met so we don't need to check ag=
ain.
> +            return Ok(val);
> +        }
> +        if let Some(timeout_delta) =3D timeout_delta {
> +            if start.elapsed() > timeout_delta {
> +                // Unlike the C version, we immediately return.
> +                // We have just called `op()` so we don't need to call i=
t again.
> +                return Err(ETIMEDOUT);
> +            }
> +        }
> +        if sleep {
> +            fsleep(sleep_delta);
> +        }
> +        // fsleep() could be busy-wait loop so we always call cpu_relax(=
).
> +        cpu_relax();
> +    }
> +}
> --=20
> 2.43.0


