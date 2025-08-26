Return-Path: <linux-kernel+bounces-786807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82AEB36C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A885A037EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED54C35A29E;
	Tue, 26 Aug 2025 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="LVW10R6m"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DF63568EC;
	Tue, 26 Aug 2025 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218544; cv=pass; b=VlL4yYihsdyGQVhwXHBUN5RqejJ3pYRGpbJ1vNB9vzU4heBK0btg/kpVM20bEKxuEYjGfLpnHddsa3MLunhj9LyqUhdqvmrEBGhiuL9VaQK74JFuJcvJAD4svSIA/K62D2WhW/NpNYK+DUlTu9rlgcCKGuctd+g2rXnWpoBGoZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218544; c=relaxed/simple;
	bh=adRn9/Uca2BKbogSg1i9nz85G64qzgQBOG9jC9aGPzs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uFFOeSGgjIOQ/bodu+gduvHsTI8eirV7w+hoaJrvinXGjjRe31908j3k+UDUQy//poScdwTpCrY4ydzcZjIC0QrtT79E7Y0PtBfOFqowCaeaBV6mfVFxX22X2Ale0MtUEcJsjRfUbzcVWbVJI02+mYkCv1cglUD8MlWF8aXGK+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=LVW10R6m; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756218522; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BjFdXrcJIl95Ug2AaJX8bY/6vOiLaCyNKuE7TBLRVdMv5uu2uu8uao0gewWunbzgjE4GdYAoqmzY6yEEzVzoKAB3zd2qJ1CEIlMGyZQLB59auonX0jlyy7VPz0PDqCfMGHJWTd0Kn8S9ESoQyjhkp/cSOzp2F6uXwD0D672Uh4g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756218522; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dYW6VqjJB15mX/lK13ugJyD8uSJtaR/HOtz8vNCXuNU=; 
	b=Uw6FsFvGKPfW+j/NpF86iIcIyUE/y5N4AdClLs41TXVkr/kEosHvciLN1I+k95rUHeFD3elC2Tw/DxMj8uiae2U2hiUrFjnuMGvZ1eOL1zflcfKG9QH7L6LkNni9G20zrR9Krjxc6R9jHxUcx0SLI4vI3F+VMiuHOuizP5zgreY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756218522;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=dYW6VqjJB15mX/lK13ugJyD8uSJtaR/HOtz8vNCXuNU=;
	b=LVW10R6mVRr/15Z2qPidNNMIHoTXJwIk66kjGiA1SSi+/C4cye5ylDB5OBOUFd/D
	ylPVtR3LkXcnAj18kwY5imBEXiytwEro4prMAGwLnav5PKVThlan7Ry+mEXyEVQd5W2
	fK15OmHsCHbcImBWYefKZdhcL5KoWhnqYHwYF9lg=
Received: by mx.zohomail.com with SMTPS id 175621851964057.89311874075952;
	Tue, 26 Aug 2025 07:28:39 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 2/2] rust: time: Implement basic arithmetic operations
 for Delta
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250820203704.731588-3-lyude@redhat.com>
Date: Tue, 26 Aug 2025 11:28:23 -0300
Cc: rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <485A6C23-9E6A-45C6-8F3F-377E538F052E@collabora.com>
References: <20250820203704.731588-1-lyude@redhat.com>
 <20250820203704.731588-3-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 20 Aug 2025, at 17:26, Lyude Paul <lyude@redhat.com> wrote:
>=20
> While rvkms is only going to be using a few of these, since Deltas are
> basically the same as i64 it's easy enough to just implement all of =
the
> basic arithmetic operations for Delta types.
>=20
> Keep in mind there's one quirk here - the kernel has no support for
> i64 % i64 on 32 bit platforms, the closest we have is i64 % i32 =
through
> div_s64_rem(). So, instead of implementing ops::Rem or ops::RemAssign =
we
> simply provide Delta::rem_nanos().
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> ---
> V2:
> * Don't forget to make sure that we inline all of these
> * Drop ops::Rem and ops::RemAssign implementations for Delta, replace =
with
>  Delta::rem_nanos() instead. It turns out that there's actually no way =
to
>  perform i64 % i64 on 32 bit platforms in the kernel at the moment, =
the
>  closest that we have is div_s64_rem() which only allows a 32 bit =
divisor.
> * Actually use the kernel arithmetic helpers for division/remainders =
so
>  that this code works on both 32 and 64 bit platforms.
> V3:
> * Change the output type for Div to i64, drop DivAssign
> * Change Mul/MulAssign to accept i64, not another Delta
> * Fix parameter name in rem_nanos (ns -> dividend)
>=20
> rust/kernel/time.rs | 98 +++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 98 insertions(+)
>=20
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 4bd7a8a009f3e..e64c5b13152dd 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -265,6 +265,78 @@ pub struct Delta {
>     nanos: i64,
> }
>=20
> +impl ops::Add for Delta {
> +    type Output =3D Self;
> +
> +    #[inline]
> +    fn add(self, rhs: Self) -> Self {
> +        Self {
> +            nanos: self.nanos + rhs.nanos,
> +        }
> +    }
> +}
> +
> +impl ops::AddAssign for Delta {
> +    #[inline]
> +    fn add_assign(&mut self, rhs: Self) {
> +        self.nanos +=3D rhs.nanos;
> +    }
> +}
> +
> +impl ops::Sub for Delta {
> +    type Output =3D Self;
> +
> +    #[inline]
> +    fn sub(self, rhs: Self) -> Self::Output {
> +        Self {
> +            nanos: self.nanos - rhs.nanos,
> +        }
> +    }
> +}
> +
> +impl ops::SubAssign for Delta {
> +    #[inline]
> +    fn sub_assign(&mut self, rhs: Self) {
> +        self.nanos -=3D rhs.nanos;
> +    }
> +}
> +
> +impl ops::Mul<i64> for Delta {
> +    type Output =3D Self;
> +
> +    #[inline]
> +    fn mul(self, rhs: i64) -> Self::Output {
> +        Self {
> +            nanos: self.nanos * rhs,
> +        }
> +    }
> +}
> +
> +impl ops::MulAssign<i64> for Delta {
> +    #[inline]
> +    fn mul_assign(&mut self, rhs: i64) {
> +        self.nanos *=3D rhs;
> +    }
> +}
> +
> +impl ops::Div for Delta {
> +    type Output =3D i64;
> +
> +    #[inline]
> +    fn div(self, rhs: Self) -> Self::Output {
> +        #[cfg(CONFIG_64BIT)]
> +        {
> +            self.nanos / rhs.nanos
> +        }
> +
> +        #[cfg(not(CONFIG_64BIT))]
> +        {
> +            // SAFETY: This function is always safe to call =
regardless of the input values
> +            unsafe { bindings::div64_s64(self.nanos, rhs.nanos) }
> +        }
> +    }
> +}
> +
> impl Delta {
>     /// A span of time equal to zero.
>     pub const ZERO: Self =3D Self { nanos: 0 };
> @@ -353,4 +425,30 @@ pub fn as_millis(self) -> i64 {
>             bindings::ktime_to_ms(self.as_nanos())
>         }
>     }
> +
> +    /// Return `self % dividend` where `dividend` is in nanoseconds.
> +    ///
> +    /// The kernel doesn't have any emulation for `s64 % s64` on 32 =
bit platforms, so this is
> +    /// limited to 32 bit dividends.
> +    #[inline]
> +    pub fn rem_nanos(self, dividend: i32) -> Self {
> +        #[cfg(CONFIG_64BIT)]
> +        {
> +            Self {
> +                nanos: self.as_nanos() % i64::from(dividend),
> +            }
> +        }
> +
> +        #[cfg(not(CONFIG_64BIT))]
> +        {
> +            let mut rem =3D 0;
> +
> +            // SAFETY: `rem` is in the stack, so we can always =
provide a valid pointer to it.
> +            unsafe { bindings::div_s64_rem(self.as_nanos(), dividend, =
&mut rem) };
> +
> +            Self {
> +                nanos: i64::from(rem),
> +            }
> +        }
> +    }
> }
> --=20
> 2.50.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

