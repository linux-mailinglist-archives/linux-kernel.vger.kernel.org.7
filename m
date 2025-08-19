Return-Path: <linux-kernel+bounces-776333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E55B2CC10
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACF856833C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185142FC87B;
	Tue, 19 Aug 2025 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="WnMr3qbo"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740181CA84;
	Tue, 19 Aug 2025 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628315; cv=pass; b=GsmgIfkRRUkmp+H1Yqo7kiGrIjJicjKt6JOskiTAsFt3b4iZRl5Nr7cOLsZtsqFd+zqi4IoY20qkK/gjMxNtEb24Uxy5+yYxBn9XdTmHAVeAy5rZHF0m2BIOFFR2um1YLdQ81ICzZg3gocu846/g2GXh14/VvGqJr/i6G8LLDj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628315; c=relaxed/simple;
	bh=I0Kw8IxK5dkRiyBU0gUnD8C43XziqbuK6UpcH5DdK1w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jR8R3nMx5giOVlSSQzahh6lWDmmzZIPB/Dy2WzxBR0FzDVOf/oPjLjFthC+A2xNWAhUouloHVgxM+sizLh4ijwC2/qLZOOTWo2qMgUlYP3eM7EJDDUC6gsP+3JwqVDu2LxmbdW4jCzjuDg6NmmVrXOmEomFwQhZ8wH5LUQjMPGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=WnMr3qbo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755628271; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DYtA8vPZazJR+33rl8FWHHI6w0O/6vYgkJ1YXY/fsF1q7wjpuKfUOtyP3JC6Iy1QaaP8lZtK3RmDoRNomlnY9hHT32AzNkgEWwbQu8eZc33I7Rn6IIQEUm1WRjf/0SbvfbBwKJreagm8DbFiO6NrWR2yZ3GT1YqOtfPpCr90WYQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755628271; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GQLyOLdjCY2K7z1TP24thZJaGt6jgbP9deQnONx51zA=; 
	b=TzphuIPaB83MhpiHhRLNzMBTSQ7nP7aTrFtGpcr4ILAgiAuUZhKAmtsmvEYZWNmtfI22PKhydlQVqj2/ff6TIw/F8Jw/rz0IZ+yBKPKXTiXBpfOhvd09TtlFX9zBx/dhFoIM2Fb43ofGPgziWHMbSn2S2aopIQ+1oVAyWXwCC/A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755628271;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=GQLyOLdjCY2K7z1TP24thZJaGt6jgbP9deQnONx51zA=;
	b=WnMr3qboBMJmh6KLzd5XJbbj5y60zxl3z7D+8RIJtbFo8jgkuKBO5uSeyONs9eCS
	SnTRFBlvP/xjN2Qr5b+Yz2xk4k5dYXyH5N0gkWperMDtFrsb5L1MiZsUMbsSl6KOb0k
	bp7dNhWRsNYniBpwKKpbj9Atzs4wF6Y4C4dsonxc=
Received: by mx.zohomail.com with SMTPS id 1755628269942511.43717673607466;
	Tue, 19 Aug 2025 11:31:09 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 2/2] rust: Add read_poll_timeout functions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250817044724.3528968-3-fujita.tomonori@gmail.com>
Date: Tue, 19 Aug 2025 15:30:51 -0300
Cc: a.hindborg@kernel.org,
 alex.gaynor@gmail.com,
 ojeda@kernel.org,
 aliceryhl@google.com,
 anna-maria@linutronix.de,
 bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com,
 dakr@kernel.org,
 frederic@kernel.org,
 gary@garyguo.net,
 jstultz@google.com,
 linux-kernel@vger.kernel.org,
 lossin@kernel.org,
 lyude@redhat.com,
 rust-for-linux@vger.kernel.org,
 sboyd@kernel.org,
 tglx@linutronix.de,
 tmgross@umich.edu,
 acourbot@nvidia.com,
 Fiona Behrens <me@kloenk.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F512B17D-5C07-4C10-9710-E2467D21BA80@collabora.com>
References: <20250817044724.3528968-1-fujita.tomonori@gmail.com>
 <20250817044724.3528968-3-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Fujita,

> On 17 Aug 2025, at 01:47, FUJITA Tomonori <fujita.tomonori@gmail.com> =
wrote:
>=20
> Add read_poll_timeout function which poll periodically until a
> condition is met or a timeout is reached.
>=20
> The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
> macro and a simple wrapper for Rust doesn't work. So this implements
> the same functionality in Rust.
>=20
> The C version uses usleep_range() while the Rust version uses
> fsleep(), which uses the best sleep method so it works with spans that
> usleep_range() doesn't work nicely with.
>=20
> The sleep_before_read argument isn't supported since there is no user
> for now. It's rarely used in the C version.
>=20
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
> rust/kernel/io.rs      |  1 +
> rust/kernel/io/poll.rs | 96 ++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 97 insertions(+)
> create mode 100644 rust/kernel/io/poll.rs
>=20
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 03b467722b86..ee182b0b5452 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -8,6 +8,7 @@
> use crate::{bindings, build_assert, ffi::c_void};
>=20
> pub mod mem;
> +pub mod poll;
> pub mod resource;
>=20
> pub use resource::Resource;
> diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> new file mode 100644
> index 000000000000..e6325725d5a3
> --- /dev/null
> +++ b/rust/kernel/io/poll.rs
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! IO polling.
> +//!
> +//! C header: =
[`include/linux/iopoll.h`](srctree/include/linux/iopoll.h).
> +
> +use crate::{
> +    error::{code::*, Result},
> +    processor::cpu_relax,
> +    task::might_sleep,
> +    time::{delay::fsleep, Delta, Instant, Monotonic},
> +};
> +
> +/// Polls periodically until a condition is met or a timeout is =
reached.
> +///
> +/// The function repeatedly executes the given operation `op` closure =
and
> +/// checks its result using the condition closure `cond`.
> +///
> +/// If `cond` returns `true`, the function returns successfully with =
the result of `op`.
> +/// Otherwise, it waits for a duration specified by `sleep_delta`
> +/// before executing `op` again.
> +///
> +/// This process continues until either `cond` returns `true` or the =
timeout,
> +/// specified by `timeout_delta`, is reached. If `timeout_delta` is =
`None`,
> +/// polling continues indefinitely until `cond` evaluates to `true` =
or an error occurs.
> +///
> +/// This function can only be used in a nonatomic context.
> +///
> +/// # Examples
> +///
> +/// ```no_run
> +/// use kernel::io::{Io, poll::read_poll_timeout};
> +/// use kernel::time::Delta;
> +///
> +/// const HW_READY: u16 =3D 0x01;
> +///
> +/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> =
Result<()> {
> +///     match read_poll_timeout(
> +///         // The `op` closure reads the value of a specific status =
register.
> +///         || io.try_read16(0x1000),
> +///         // The `cond` closure takes a reference to the value =
returned by `op`
> +///         // and checks whether the hardware is ready.
> +///         |val: &u16| *val =3D=3D HW_READY,
> +///         Delta::from_millis(50),
> +///         Delta::from_secs(3),
> +///     ) {
> +///         Ok(_) =3D> {
> +///             // The hardware is ready. The returned value of the =
`op` closure
> +///             // isn't used.
> +///             Ok(())
> +///         }
> +///         Err(e) =3D> Err(e),
> +///     }
> +/// }
> +/// ```
> +#[track_caller]
> +pub fn read_poll_timeout<Op, Cond, T>(
> +    mut op: Op,
> +    mut cond: Cond,
> +    sleep_delta: Delta,
> +    timeout_delta: Delta,
> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: FnMut(&T) -> bool,
> +{
> +    let start: Instant<Monotonic> =3D Instant::now();
> +
> +    // Unlike the C version, we always call `might_sleep()` =
unconditionally,
> +    // as conditional calls are error-prone. We clearly separate
> +    // `read_poll_timeout()` and `read_poll_timeout_atomic()` to aid
> +    // tools like klint.
> +    might_sleep();
> +
> +    loop {
> +        let val =3D op()?;
> +        if cond(&val) {
> +            // Unlike the C version, we immediately return.
> +            // We know the condition is met so we don't need to check =
again.
> +            return Ok(val);
> +        }
> +
> +        if start.elapsed() > timeout_delta {
> +            // Unlike the C version, we immediately return.
> +            // We have just called `op()` so we don't need to call it =
again.
> +            return Err(ETIMEDOUT);
> +        }
> +
> +        if !sleep_delta.is_zero() {
> +            fsleep(sleep_delta);
> +        }
> +
> +        // fsleep() could be busy-wait loop so we always call =
cpu_relax().
> +        cpu_relax();
> +    }
> +}
> --=20
> 2.43.0
>=20
>=20

Thanks for working on this. Definitely going to be needed by a lot of =
drivers.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

How is the atomic version going to look like? The same, except for
might_sleep() and without the sleep_delta argument?


