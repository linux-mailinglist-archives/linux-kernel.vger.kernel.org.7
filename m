Return-Path: <linux-kernel+bounces-786777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A28B36927
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADD5583A98
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126043570A4;
	Tue, 26 Aug 2025 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="jCmd8Xzl"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F834F496;
	Tue, 26 Aug 2025 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217510; cv=pass; b=oEpNMsZ4V8+R/iva3mYJhe11nZGSvc+TUjH0e4Pzxr5NL0RrxRrBJtFfAiPdve8wHZjiZLo92Nr+xEHYyML2sJzH/M3HVjU0X2+S+JZewtMS3hvmd2qDZE7TBwU9r/AlLlfD8bly8oo5oa18YBj6QDnP6bIMGD8H9fN7jQiUPbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217510; c=relaxed/simple;
	bh=u143iq9kU540ukaaaIIhe7e1blqk2QqaFqx4i+WY6sM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fAffe6i/0+QFGbQ/qXQXNCk9bowxgYNYp8irG3EBqFPWb8yqQKu4YF+XMJ51t6BFm66j/1l3ItfhtazCgHq64ko3nsrhUI+q5npvLsyd1oxTU33qIitkUHQ1brJTE7OCl7ncGSg9k1xcsJkurkT3WSiWPgdzDuGt3XVkeEStJ54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=jCmd8Xzl; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756217485; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iRlgzx5mAVuNd1h2xJQqwe9mD9n3EnFhkqhmJyitLNgHV8jtu1VpvQ9LcGFOVBU/tNvKWsc94WLTRKClnsw5vr5YmbdxUQ8xnl8eQd5icjrDH6QvX82s38Mm5hFjCrQI70a8jkc1CyXrkS88+jYBVvbN5yc1L28UEe3ehbV3Dh0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756217485; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EhQ89ogVO2cQzjVG5RrvUZ7cTzuHbPGTOIgPLQQVCnI=; 
	b=cGlnsiDOth5Cha/PQx36JV7LNzLkzdWCdsxbzuZmHQYXasGpEiNxKQh5O/5vdStyom51OxAjLA2MhObvpfjdhTbmGANpZTaRZFugTZpDKGMcqPG6ZYZSdWiPYa6V3r/T+fzlLTzdHimhLBFNqcLoZCinjH+/0ju/2t3g/61Fh0E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756217485;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=EhQ89ogVO2cQzjVG5RrvUZ7cTzuHbPGTOIgPLQQVCnI=;
	b=jCmd8XzlR7oQwkv98b/GsDN3OtVAZLuZ5GcHoPMVhGDKsRe1eeU01ZW6txuA0g7N
	I5tvDgnE4zEjRXEF9s06MqVup5kJuf6W4mRee08aJhMe4yMYXfX+aUPDSNZ25PBY0y1
	HDQ2YcefiwVEzPgO6pK80iJjfxePJmZqr0W1+5sQ=
Received: by mx.zohomail.com with SMTPS id 1756217482165873.4699548131458;
	Tue, 26 Aug 2025 07:11:22 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 1/2] rust: time: Implement Add<Delta>/Sub<Delta> for
 Instant
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250820203704.731588-2-lyude@redhat.com>
Date: Tue, 26 Aug 2025 11:11:06 -0300
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
Message-Id: <1BF6F8B6-BD06-4300-8BD6-6827DCE24A5C@collabora.com>
References: <20250820203704.731588-1-lyude@redhat.com>
 <20250820203704.731588-2-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Lyude,


> On 20 Aug 2025, at 17:26, Lyude Paul <lyude@redhat.com> wrote:
>=20
> In order to copy the behavior rust currently follows for basic =
arithmetic
> operations and panic if the result of an addition or subtraction =
results in
> a value that would violate the invariants of Instant, but only if the
> kernel has overflow checking for rust enabled.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> ---
>=20
> V2:
> * Change behavior in ops::{Add,Sub}<Delta> so that we panic on =
overflows
>  under the same conditions that arithmetic operations in rust would =
panic
>  by default.
> V3:
> * Don't forget to update the commit message this time!
>=20
> rust/kernel/time.rs | 43 ++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 42 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 64c8dcf548d63..4bd7a8a009f3e 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -25,6 +25,7 @@
> //! C header: =
[`include/linux/ktime.h`](srctree/include/linux/ktime.h).
>=20
> use core::marker::PhantomData;
> +use core::ops;
>=20
> pub mod delay;
> pub mod hrtimer;
> @@ -202,7 +203,7 @@ pub(crate) fn as_nanos(&self) -> i64 {
>     }
> }
>=20
> -impl<C: ClockSource> core::ops::Sub for Instant<C> {
> +impl<C: ClockSource> ops::Sub for Instant<C> {
>     type Output =3D Delta;
>=20
>     // By the type invariant, it never overflows.
> @@ -214,6 +215,46 @@ fn sub(self, other: Instant<C>) -> Delta {
>     }
> }
>=20
> +impl<T: ClockSource> ops::Add<Delta> for Instant<T> {
> +    type Output =3D Self;
> +
> +    #[inline]
> +    fn add(self, rhs: Delta) -> Self::Output {
> +        // INVARIANT: With arithmetic over/underflow checks enabled, =
this will panic if we overflow
> +        // (e.g. go above `KTIME_MAX`)
> +        let res =3D self.inner + rhs.nanos;

Shouldn=E2=80=99t we clamp here instead of..
> +
> +        // INVARIANT: With overflow checks enabled, we verify here =
that the value is >=3D 0
> +        #[cfg(CONFIG_RUST_OVERFLOW_CHECKS)]
> +        assert!(res >=3D 0);

..relying on this?

> +
> +        Self {
> +            inner: res,
> +            _c: PhantomData,
> +        }
> +    }
> +}
> +
> +impl<T: ClockSource> ops::Sub<Delta> for Instant<T> {
> +    type Output =3D Self;
> +
> +    #[inline]
> +    fn sub(self, rhs: Delta) -> Self::Output {
> +        // INVARIANT: With arithmetic over/underflow checks enabled, =
this will panic if we overflow
> +        // (e.g. go above `KTIME_MAX`)
> +        let res =3D self.inner - rhs.nanos;
> +
> +        // INVARIANT: With overflow checks enabled, we verify here =
that the value is >=3D 0
> +        #[cfg(CONFIG_RUST_OVERFLOW_CHECKS)]
> +        assert!(res >=3D 0);

Same here?

> +
> +        Self {
> +            inner: res,
> +            _c: PhantomData,
> +        }
> +    }
> +}
> +
> /// A span of time.
> ///
> /// This struct represents a span of time, with its value stored as =
nanoseconds.
> --=20
> 2.50.0
>=20
>=20


