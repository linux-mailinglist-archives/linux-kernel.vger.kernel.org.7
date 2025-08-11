Return-Path: <linux-kernel+bounces-762360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E747CB20581
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C37618A243F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B9D23A9BD;
	Mon, 11 Aug 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJVlXne2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D82367C5;
	Mon, 11 Aug 2025 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908398; cv=none; b=UwFt6JmheaGd1VDQaO0cvlW7YO1DHdsZfrRxkmWYGOhL1aTpkCwTOF/gwYvyCJo70791VI6EJQM7kxbUVOSnsby0mg6ccgxoe53yIr5P4UitKUgHKsVw4jbE75sqpHccMbZnvROmnpLynSRlhC6FVxsx6uQr3vmlpnLVIfbOJBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908398; c=relaxed/simple;
	bh=Bb+HJJMwXAa9wHZL9KaKBaWkuVtOZHy9HVPQEPFbXGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j3QOofl95SLq682zr+D27h9k1KtjVBMSemwFuTVnY7FVloRj5BHQSRDryCUOtbxhHckwwZOxsIC60X5c7Ha7ATxAqiOVuQECAcq61AjU6IzJTMO5+m0A1ZhyINTREjEV09NKyYKL+MYMzy33dW1zS7Yo38IajhQXBK+eoERiCTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJVlXne2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C91C4CEED;
	Mon, 11 Aug 2025 10:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754908397;
	bh=Bb+HJJMwXAa9wHZL9KaKBaWkuVtOZHy9HVPQEPFbXGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DJVlXne2ZkiAwJkHm/6RC99HvsVCiZA11kpjiJz5hAN8Jm+mlpndEiNmawPR5soiL
	 6LHryqS81sO1H9pGeeqKgc5Ug32IdY7UYgBApXPSgBMwY5zrh8lG910CmcVX6xyZHQ
	 mGmjCO+Y26gOzkUzNhmJ1DpDgkFtuGVYwZymqbHIuJchEqEGx4twTWLdycELpMvS9j
	 SD8PfFpAnG+FDUYEOQXfoAxD3dA4gNOdoalkO1PYA3sPfsW+jn00S0jgu3cXEfmYSp
	 bv6yR8eAdBJJWWXzYxT/Vxg49hf8vwNZMS98iedbquWVCKoT/mJh13zf9sDrySjyZw
	 Wi2wSzMs5CalQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>
Cc: alex.gaynor@gmail.com, ojeda@kernel.org, aliceryhl@google.com,
 anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 frederic@kernel.org, gary@garyguo.net, jstultz@google.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com,
 rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de,
 tmgross@umich.edu, acourbot@nvidia.com, daniel.almeida@collabora.com,
 Fiona Behrens <me@kloenk.dev>
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout functions
In-Reply-To: <DBZIBAUIBYNH.3I8AZG4I8I59E@kernel.org>
References: <20250811041039.3231548-1-fujita.tomonori@gmail.com>
 <20250811041039.3231548-3-fujita.tomonori@gmail.com>
 <g-GNshC-IMvTiMmll2fadYBIoaUfWmifTVixFSbVa_ezg_KutSYmwQpXnfFnBmUkk7f2_prupGl9g7LONjFhiA==@protonmail.internalid>
 <DBZIBAUIBYNH.3I8AZG4I8I59E@kernel.org>
Date: Mon, 11 Aug 2025 12:32:51 +0200
Message-ID: <875xeugncc.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Danilo Krummrich" <dakr@kernel.org> writes:

> On Mon Aug 11, 2025 at 6:10 AM CEST, FUJITA Tomonori wrote:
>> Add read_poll_timeout functions which poll periodically until a
>> condition is met or a timeout is reached.
>>
>> The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
>> macro and a simple wrapper for Rust doesn't work. So this implements
>> the same functionality in Rust.
>>
>> The C version uses usleep_range() while the Rust version uses
>> fsleep(), which uses the best sleep method so it works with spans that
>> usleep_range() doesn't work nicely with.
>>
>> The sleep_before_read argument isn't supported since there is no user
>> for now. It's rarely used in the C version.
>>
>> read_poll_timeout() can only be used in a nonatomic context. This
>> requirement is not checked by these abstractions, but it is intended
>> that klint [1] or a similar tool will be used to check it in the
>> future.
>>
>> Link: https://rust-for-linux.com/klint [1]
>> Reviewed-by: Fiona Behrens <me@kloenk.dev>
>> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
>>  rust/kernel/time.rs      |   1 +
>>  rust/kernel/time/poll.rs | 104 +++++++++++++++++++++++++++++++++++++++
>
> Hm, are we should this should go in the time module? I does use timekeeping
> stuff, but not every user of timekeeping stuff should go under the time module.
>
> This is rather I/O stuff and I'd expect it in rust/kernel/io/poll.rs instead.
>
>> +/// Polls periodically until a condition is met or a timeout is reached.
>> +///
>> +/// The function repeatedly executes the given operation `op` closure and
>> +/// checks its result using the condition closure `cond`.
>> +///
>> +/// If `cond` returns `true`, the function returns successfully with the result of `op`.
>> +/// Otherwise, it waits for a duration specified by `sleep_delta`
>> +/// before executing `op` again.
>> +///
>> +/// This process continues until either `cond` returns `true` or the timeout,
>> +/// specified by `timeout_delta`, is reached. If `timeout_delta` is `None`,
>> +/// polling continues indefinitely until `cond` evaluates to `true` or an error occurs.
>> +///
>> +/// This function can only be used in a nonatomic context.
>> +///
>> +/// # Examples
>> +///
>> +/// ```no_run
>> +/// use kernel::io::Io;
>> +/// use kernel::time::{poll::read_poll_timeout, Delta};
>> +///
>> +/// const HW_READY: u16 = 0x01;
>> +///
>> +/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result<()> {
>> +///     // The `op` closure reads the value of a specific status register.
>> +///     let op = || -> Result<u16> { io.try_read16(0x1000) };
>> +///
>> +///     // The `cond` closure takes a reference to the value returned by `op`
>> +///     // and checks whether the hardware is ready.
>> +///     let cond = |val: &u16| *val == HW_READY;
>> +///
>> +///     match read_poll_timeout(op, cond, Delta::from_millis(50), Some(Delta::from_secs(3))) {
>> +///         Ok(_) => {
>> +///             // The hardware is ready. The returned value of the `op`` closure isn't used.
>> +///             Ok(())
>> +///         }
>> +///         Err(e) => Err(e),
>> +///     }
>> +/// }
>> +/// ```
>
> This is exactly what I had in mind, thanks!
>
>> +/// ```rust
>> +/// use kernel::sync::{SpinLock, new_spinlock};
>> +/// use kernel::time::Delta;
>> +/// use kernel::time::poll::read_poll_timeout;
>> +///
>> +/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
>> +/// let g = lock.lock();
>> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Some(Delta::from_micros(42)));
>
> I assume you want to demonstrate misuse from atomic contex here? I'd rather not
> do so. But if we really want that, there should be a *very* obvious comment
> about this being wrong somewhere.

I think we should just drop this example.


Best regards,
Andreas Hindborg




