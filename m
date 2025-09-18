Return-Path: <linux-kernel+bounces-823243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCDEB85E49
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA35D189543D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4523313E34;
	Thu, 18 Sep 2025 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0AuIhhM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BDC243951;
	Thu, 18 Sep 2025 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211393; cv=none; b=mGIupq0sznqy0xgikEbUiB4qZnIZJe+TExTIJY56zPxcttkhDvJ4UpniMT9EHaiW+iZ6msPr+I0ggxa8g3kPGDMVtZdSYddG4ZKubKSVA+iFN1hgY/2aWA7/p0LJ3iCTkGZGNtFnohP5rIt9qnMl54V32oW3aVEkGWyeomwuiuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211393; c=relaxed/simple;
	bh=vH5vxTGmTQMX72D+ve+fQ+5ugobLSMznc3Ridr8UWLQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EHWPF+c56CXkXMRKV6ZeqCVn5FI5iAlFvsRcL3tRczftiq8W2RjDCsk6lW0vurtAIUlGuHhgkCnGRdoiM4CZTES1OYHPFx+FdMR2DMLCTtw2Kjn2eBD95xU1wRPNzex5BFg8w6vQYKQwE2BPg6I+e4uDJllTSPca8IIQ4FmM0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0AuIhhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FBCC4CEE7;
	Thu, 18 Sep 2025 16:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758211392;
	bh=vH5vxTGmTQMX72D+ve+fQ+5ugobLSMznc3Ridr8UWLQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=B0AuIhhMsEhy9/U2Ac148Np47X//3+PNEjPKs8YGaRIv9xEglCq9DIZa+xT8N6FiO
	 oqfSgRPBTOf/ioaK605mhscrelsJyjCVt1qwVGCzWm6+a6dmb+Yaa1cegongIeMCCE
	 ZCX9YDkU9TwFGWqxuvrQQeg3Y8TjjYI0BEg9rJ5ybhR+4bcDY/Fm8NJTFyH5uMrE3d
	 zXBhNDjcnFUV3wUd32nw8mq6jlKIA5J8ImGK1BCt0SP2h7SbA4g69cXhDxYjJ+6S4H
	 UjRFOR3uLnDUqYME768v3XTg5HHJpPiB/pB6vAH7fawjiy3blwmkLn8e6odhmkq3kb
	 F0uFSik5agO2A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Sep 2025 18:03:05 +0200
Message-Id: <DCW1X3ZY82PY.TCFDCBLZ7HDQ@kernel.org>
Cc: <skhan@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [RESEND PATCH v5] rust: kernel: introduce
 `unsafe_precondition_assert!` macro
From: "Benno Lossin" <lossin@kernel.org>
To: "Ritvik Gupta" <ritvikfoss@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20250827060013.6874-1-ritvikfoss@gmail.com>
In-Reply-To: <20250827060013.6874-1-ritvikfoss@gmail.com>

On Wed Aug 27, 2025 at 8:00 AM CEST, Ritvik Gupta wrote:
> diff --git a/rust/kernel/safety.rs b/rust/kernel/safety.rs
> new file mode 100644
> index 000000000000..e78d49e3e7c8
> --- /dev/null
> +++ b/rust/kernel/safety.rs
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Safety related APIs.

I think this looks fine to start out with.

> +
> +/// Checks that preconditions of an unsafe function are followed.
> +///
> +/// The check is enabled at runtime if debug assertions (`CONFIG_RUST_DE=
BUG_ASSERTIONS`)
> +/// are enabled. Otherwise, this macro is no-op.
> +///
> +/// # Examples
> +///
> +/// ```no_run
> +/// use kernel::unsafe_precondition_assert;
> +///
> +/// struct RawBuffer<T: Copy, const N: usize> {
> +///     data: [T; N],
> +/// }
> +///
> +/// impl<T: Copy, const N: usize> RawBuffer<T, N> {
> +///     /// # Safety
> +///     ///
> +///     /// The caller must ensure that `index` is less than `N`
> +///     unsafe fn set_unchecked(&mut self, index: usize, value: T) {
> +///         unsafe_precondition_assert!(
> +///             index < N,
> +///             "RawBuffer::set_unchecked requires index ({}) < N ({})",
> +///             index,
> +///             N,

You can move the names into the `{}`:

    unsafe_precondition_assert!(
        index < N,
        "RawBuffer::set_unchecked requires index ({index}) < N ({N})",
    );

> +///         );
> +///
> +///         // SAFETY: By the safety requirements of this function, `ind=
ex` is valid
> +///         unsafe {
> +///             *self.data.get_unchecked_mut(index) =3D value;
> +///         }
> +///     }
> +/// }
> +/// ```
> +///
> +/// # Panics
> +///
> +/// Panics if the expression is evaluated to `false` at runtime.
> +#[macro_export]
> +macro_rules! unsafe_precondition_assert {
> +    ($cond:expr $(,)?) =3D> {
> +        $crate::unsafe_precondition_assert!(@inner $cond, ::core::string=
ify!($cond))
> +    };
> +
> +    ($cond:expr, $($arg:tt)+) =3D> {
> +        $crate::unsafe_precondition_assert!(@inner $cond, $crate::prelud=
e::fmt!($($arg)+))
> +    };
> +
> +    (@inner $cond:expr, $msg:expr) =3D> {
> +        ::core::debug_assert!($cond, "unsafe precondition(s) violated: {=
}", $msg) };

The closing `}` should be on the next line.

---
Cheers,
Benno

> +}
>
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585


