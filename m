Return-Path: <linux-kernel+bounces-882681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B2EC2B1B8
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF5753492AA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6D22FF165;
	Mon,  3 Nov 2025 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eckQOwm/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5692FD1DD;
	Mon,  3 Nov 2025 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166381; cv=none; b=Vh5y1JDGGPRzI81gZU2DUZ2BTVKIjfnEGz8A3NrwKWsP+7sVGHk4zuT6ZyhFgHccK2ZnbCLW3WwjJs7dI+NfrLUSFhw4wltSTuA/lfZs5N4KJjExUV5xkQOvOys57bXiFk/NezdfdZQ5wZPFpX81YCHAqlnaQbqEs1mtMfYs4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166381; c=relaxed/simple;
	bh=KO80Tanytiz9zx9QKJRE34TwuV8NATMH1iVrHnczWsM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iuFjj8TaI1srpEsqMnZYH5XNqoY1ljRP7GRIwwgK+KKP+wQ+KkX1iw6KhZhotv/LOZ3LSO0IaZXMKqlvbur4Ks1VSbU7Bahh7JvDyk7p6ejIUUEuGhTAmeRgg3KLUl/6lBRAlA0pQqogDqDYJAc2q2Q+I4jDi7+kFY5GxMa80jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eckQOwm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE1AC4CEE7;
	Mon,  3 Nov 2025 10:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762166380;
	bh=KO80Tanytiz9zx9QKJRE34TwuV8NATMH1iVrHnczWsM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=eckQOwm/pT9m0IT7GCpfsbdKWeJ4QYxU3keMaWPEz1hKFBX/o6Mh39P+XZryL8ETK
	 LiUZeSbK0vTI812jgU9VLZwNrD1GLXsg7j9+hakTvZICk5oSGtHwkQ4BVfoZeIeDFF
	 f830CilIPWwMm/xosOViqidm7laGXiSGLaZtWG2cz+luoA7VB9cOqi9qoYgwjQrgj4
	 4VV/6TGs2vpRIBQ5gQhD1BdFPyCiDazoLZcWNeazwDsM0cqXIHwtb4vNYhw96koKgr
	 b8GRpwmn5xhMBWk0EnTrYlgMsA8ywkwfKR8VqB23bbYTUNkBJB9n7oagn5Rh1oxFIn
	 NirQnCi8g+0eg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Nov 2025 11:39:36 +0100
Message-Id: <DDYZUHMIJSF3.1XF2MPW7D0Q6@kernel.org>
Cc: <skhan@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v6] rust: kernel: introduce
 `unsafe_precondition_assert!` macro
From: "Benno Lossin" <lossin@kernel.org>
To: "Ritvik Gupta" <ritvikfoss@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20251007215034.213779-1-ritvikfoss@gmail.com>
In-Reply-To: <20251007215034.213779-1-ritvikfoss@gmail.com>

On Tue Oct 7, 2025 at 11:50 PM CEST, Ritvik Gupta wrote:
> Introduce a new `safety` module containing `unsafe_precondition_assert!`
> macro. It is a wrapper around `debug_assert!`, intended for validating
> pre-conditions of unsafe function.
>
> When `CONFIG_RUST_DEBUG_ASSERTIONS` flag is enabled, this macro performs
> runtime checks to ensure that the preconditions for unsafe function hold.
> Otherwise, the macro is a no-op.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1162
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/291566-Library=
/topic/.60unsafe_precondition_assert.60.20macro/with/528457452
> Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>

I think it's a good idea to have something like this, not sure if we
have the final version here, but we should merge something.

Reviewed-by: Benno Lossin <lossin@kernel.org>

One nit below (that Miguel can fix when picking the patch).

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
}", $msg)

This should be singular, since the name of the macro also is singular.

Cheers,
Benno

> +    };
> +}
>
> base-commit: c746c3b5169831d7fb032a1051d8b45592ae8d78


