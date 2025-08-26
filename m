Return-Path: <linux-kernel+bounces-786759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE5DB3680C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D191D2A723C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4B034DCEC;
	Tue, 26 Aug 2025 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="MUC/6APP"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB81D42AA4;
	Tue, 26 Aug 2025 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216991; cv=pass; b=d1YRjdIU1M+2DZ3DTWYDXaR0mHqA22eNydtyZp4pU7cQuiIhO8NRoDSNT24gUkfSu+D2kvWauxfiINc/0RdPzdizecxX1gyLHZAU5aaB9OJ4bTgzLyudP2rOwiGYDyo1qRj0yjTv/Av9jTXAzZ48C9X3KUw2VkdGPlrqeNCCpYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216991; c=relaxed/simple;
	bh=WRs+H/ZDZ7RF8LCx5HAeOLIeMI7rMqwACtNhjQyBFy8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jvFfKcsunMoFWpQ2mg13nND/GTaIGxsENSUhArE4t7l0EhKFS0PoxKPzAIDzOWfNk3x7293nF+Ux7iLekeu91ZzMViKwVDv0Luyep+Ce9QpInHsLgrNYJ+8MFFLkEfE8TNUNhscnSWbUSMzRTC+pfJ9xGmQYoONyXb8/YuqykgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=MUC/6APP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756216958; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J525pvSSKsN56zFByOecX5BW6kWLHaPiqF1ow4O4jg5o4nhCx7fgBrOdBRNYvp9tST398ERkPJbSV0PGgMrjy1Wh1DTfbLGzujtUtJfzcMT5+15OPmNDt4bz1tKBROf4ni08/604KYqCGyouYjLVVeHdCSOh002nYw8sduPYzpw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756216958; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sqaWaCnnpnMBYwoyb7ocXao7tag5iNejWCovrwIbQ5Q=; 
	b=aEjxgMe4Eum8bv+tJPoDSK/RAFM9DKLnM+AOrNkIfzf+t5m2p4PUfwrLYETo4VlXAdOdJuSbl/UF58CzgSjoQJ7MMBpFni1FajVGHOPUo06UUZM8hx8dLRkk0OIE8UNasmGpVf59HkytM3Pp9FC0ees7BX571RZQPMY7LZvtzEc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756216958;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=sqaWaCnnpnMBYwoyb7ocXao7tag5iNejWCovrwIbQ5Q=;
	b=MUC/6APPEdO0+79lZN1QDND6jQhXZ7A6jxCl0Y+N03w30ta77IwQ3j2UZISvg8qj
	GU5YvXeVRdtYM/eGQ2ij+iWeIIJM1+sSxa8oKzOBaksQd3jgoFuNXfRNzYiBAeJ7d4n
	KDinCmuBz38xeyFoHCL5+G/NmtjBGLN5O9bT4xlU=
Received: by mx.zohomail.com with SMTPS id 1756216956393166.230791136005;
	Tue, 26 Aug 2025 07:02:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout_atomic function
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250821035710.3692455-3-fujita.tomonori@gmail.com>
Date: Tue, 26 Aug 2025 11:02:18 -0300
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
 acourbot@nvidia.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C851069-5E1E-4DE9-9E1F-0DF2C86C266C@collabora.com>
References: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
 <20250821035710.3692455-3-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Fujita,

> On 21 Aug 2025, at 00:57, FUJITA Tomonori <fujita.tomonori@gmail.com> =
wrote:
>=20
> Add read_poll_timeout_atomic function which polls periodically until a
> condition is met, an error occurs, or the timeout is reached.
>=20
> The C's read_poll_timeout_atomic (include/linux/iopoll.h) is a
> complicated macro and a simple wrapper for Rust doesn't work. So this
> implements the same functionality in Rust.
>=20
> The delay_before_read argument isn't supported since there is no user
> for now. It's rarely used in the C version.
>=20
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
> rust/kernel/io/poll.rs | 90 +++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 89 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> index 7af1934e397a..71c2c0e0d8b4 100644
> --- a/rust/kernel/io/poll.rs
> +++ b/rust/kernel/io/poll.rs
> @@ -8,7 +8,10 @@
>     error::{code::*, Result},
>     processor::cpu_relax,
>     task::might_sleep,
> -    time::{delay::fsleep, Delta, Instant, Monotonic},
> +    time::{
> +        delay::{fsleep, udelay},
> +        Delta, Instant, Monotonic,
> +    },
> };
>=20
> /// Polls periodically until a condition is met, an error occurs,
> @@ -102,3 +105,88 @@ pub fn read_poll_timeout<Op, Cond, T>(
>         cpu_relax();
>     }
> }
> +
> +/// Polls periodically until a condition is met, an error occurs,
> +/// or the timeout is reached.
> +///
> +/// The function repeatedly executes the given operation `op` closure =
and
> +/// checks its result using the condition closure `cond`.
> +///
> +/// If `cond` returns `true`, the function returns successfully with =
the result of `op`.
> +/// Otherwise, it performs a busy wait for a duration specified by =
`delay_delta`
> +/// before executing `op` again.
> +///
> +/// This process continues until either `op` returns an error, `cond`
> +/// returns `true`, or the timeout specified by `timeout_delta` is
> +/// reached.
> +///
> +/// # Errors
> +///
> +/// If `op` returns an error, then that error is returned directly.
> +///
> +/// If the timeout specified by `timeout_delta` is reached, then
> +/// `Err(ETIMEDOUT)` is returned.
> +///
> +/// # Examples
> +///
> +/// ```no_run
> +/// use kernel::io::{Io, poll::read_poll_timeout_atomic};
> +/// use kernel::time::Delta;
> +///
> +/// const HW_READY: u16 =3D 0x01;
> +///
> +/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> =
Result<()> {

Just =E2=80=9CResult=E2=80=9D.

> +///     match read_poll_timeout_atomic(
> +///         // The `op` closure reads the value of a specific status =
register.
> +///         || io.try_read16(0x1000),
> +///         // The `cond` closure takes a reference to the value =
returned by `op`
> +///         // and checks whether the hardware is ready.
> +///         |val: &u16| *val =3D=3D HW_READY,
> +///         Delta::from_micros(50),
> +///         Delta::from_micros(300),
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
> +pub fn read_poll_timeout_atomic<Op, Cond, T>(
> +    mut op: Op,
> +    mut cond: Cond,
> +    delay_delta: Delta,
> +    timeout_delta: Delta,
> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: FnMut(&T) -> bool,
> +{
> +    let mut left_ns =3D timeout_delta.as_nanos();
> +    let delay_ns =3D delay_delta.as_nanos();
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
> +        if left_ns < 0 {
> +            // Unlike the C version, we immediately return.
> +            // We have just called `op()` so we don't need to call it =
again.
> +            return Err(ETIMEDOUT);
> +        }
> +
> +        if !delay_delta.is_zero() {
> +            udelay(delay_delta);
> +            left_ns -=3D delay_ns;
> +        }
> +
> +        cpu_relax();
> +        left_ns -=3D 1;

A comment on the line above would be nice.

Also, is timeout_delta =3D=3D 0 an intended use-case?

> +    }
> +}
> --=20
> 2.43.0
>=20
>=20


