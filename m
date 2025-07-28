Return-Path: <linux-kernel+bounces-747825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5908B138CD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019903B5E36
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C4B25B69F;
	Mon, 28 Jul 2025 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK4O7RcA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8942B25B1C5;
	Mon, 28 Jul 2025 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697914; cv=none; b=GxpU5UK4iyji13fRqKMgopaS6kSYKhxvvZcWi8EhmrK9Hw8Wfg4k0tvAnddq5HZ8rfHkBpro12+ZQjMQ52VQPSWGCDp9sbl0hSGxOzJ53e0/XRkI6YBvr0PPeZ47ANZjQ5C538wjJVV0ygqAvB/FvpywUWOjrKjjTt4yijICeRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697914; c=relaxed/simple;
	bh=P5VB9PD0iIZZL9kzIBZpyzOHWM7gFzqaWnjVehBJfXw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=eE8u47MsmR75cmtgkyl7pHr0rv8CNhi4HHHiwveriMvxQt/DBn8+hVHGUADHoNWRqZUpryi8paZBOX1pc25kmk5KW3iW1vrgQMnexd2eaKtOYuvLgEVrZqhG7oht5Ie7E7bgvIXYpC3ib4Pm+M+jAL+jEq1icGiqiZb3x7AdDLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IK4O7RcA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F58C4CEF6;
	Mon, 28 Jul 2025 10:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753697914;
	bh=P5VB9PD0iIZZL9kzIBZpyzOHWM7gFzqaWnjVehBJfXw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=IK4O7RcAnvDopGLVqz556LpcWJhLcHW2oh9gVE+q3Nmw/6aKPgXiq+9UxzvOyGgsM
	 vTvrS81xZA2bgHsVVsH4ZJ9G6LjesbIqG0ChrBIwiBV6hrAWaJVmddP92DJVqfCrlw
	 0/CcDwWwdY18+8YCfLVmhmwgT3SAQNsyhAEcQsPjBeg3DbFGSopmBBc6rxNnQ8cydt
	 dt/7spsDLveRnhPoI/svk3RvvITnAANi8X+uGde5mByKejrClbHOZAi4zGQ+Bc6/1i
	 1o+vF6dBQzGlh/z/7AkkL/R6Daukl92VhEGDcwBmrHrVc6ZDYjbQrvwqVUsHuU3zb8
	 5UZz2AIprWLyw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jul 2025 12:18:29 +0200
Message-Id: <DBNM0XTCESZY.18G1A6U91QNE6@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: sync: refactor static_lock_class!() macro
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>
Cc: "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250728-lock-class-key-cleanup-v2-0-ad02b80c69e1@google.com>
 <20250728-lock-class-key-cleanup-v2-1-ad02b80c69e1@google.com>
In-Reply-To: <20250728-lock-class-key-cleanup-v2-1-ad02b80c69e1@google.com>

On Mon Jul 28, 2025 at 11:42 AM CEST, Alice Ryhl wrote:
> By introducing a new_static() constructor, the macro does not need to go
> through MaybeUninit::uninit().assume_init(), which is a pattern that is
> best avoided when possible.
>
> The safety comment requires not only requires that the value is leaked,

"requires" appears twice.

> but also that it is stored in the right portion of memory. This is so
> that the lockdep static_obj() check will succeed when using this
> constructor. One could argue that lockdep detects this scenario, so the
> safety comment isn't needed. However, it simplifies matters to require
> that static_obj() will succeed and it's not a burdensome requirement on
> the caller.

I'd argue that's implementation detail and the safety requirement of
using a lockclass key is that it either is uninit in static memory or it
was registered. (otherwise we wouldn't be "allowed" to add this as a
safety requirement)

(just adding this for info, feel free to keep the paragraph above as-is)

> Suggested-by: Benno Lossin <lossin@kernel.org>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

> @@ -95,13 +110,11 @@ fn drop(self: Pin<&mut Self>) {
>  #[macro_export]
>  macro_rules! static_lock_class {
>      () =3D> {{
> -        static CLASS: $crate::sync::LockClassKey =3D
> -            // Lockdep expects uninitialized memory when it's handed a s=
tatically allocated `struct
> -            // lock_class_key`.
> -            //
> -            // SAFETY: `LockClassKey` transparently wraps `Opaque` which=
 permits uninitialized
> -            // memory.
> -            unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
> +        // SAFETY: The returned `LockClassKey` is stored in static memor=
y. Drop never runs on a

You're not mentioning the "pinned in a static memory location" part
(only the static memory, so missing the pinning). A read-only static
is implicitly pinned, so we should mention that.

---
Cheers,
Benno

> +        // static global.
> +        static CLASS: $crate::sync::LockClassKey =3D unsafe {
> +            $crate::sync::LockClassKey::new_static()
> +        };
>          $crate::prelude::Pin::static_ref(&CLASS)
>      }};
>  }


