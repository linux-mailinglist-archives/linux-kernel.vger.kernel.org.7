Return-Path: <linux-kernel+bounces-731742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A74EB058E3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99FD170DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0062D63FF;
	Tue, 15 Jul 2025 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j46ZgDXi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5CF19DF6A;
	Tue, 15 Jul 2025 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579203; cv=none; b=sLoWbKjcl16h1b9Q0AvcQQYKsne78k2HYIlucfhFjpJMfEFE/tPbZx61FWeQzcSwEj6hiMauMkMinKnFPCDIKJ8RVoldwNVx7nGMCieuuAUN7zgaaRibVSEmIdkcKM//DzLvsufu9gXfkMBOiRNJ0IauwkItjTT6tKnw7uvTLDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579203; c=relaxed/simple;
	bh=NzCrCCIRiXzzXCYv2+YzYKUDPlKO09ruOW1F7aYjYLs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RL9a0XEdZ4nzmdsLrEYwxPpG4VGcU2AZ8UnbhqHl2F1GZcGveiT+XEkeP64pMs556nn23il5UjNnvb+knpEroWXZw9NJDaZEshdpPdngg37i3Q4NJQRo0BskCLAB81ryxz1u3YaX5AQ80DBbtfaGwcyoaE84h95rlM5HfEShpnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j46ZgDXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0947FC4CEE3;
	Tue, 15 Jul 2025 11:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752579202;
	bh=NzCrCCIRiXzzXCYv2+YzYKUDPlKO09ruOW1F7aYjYLs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=j46ZgDXiRZfpxX5R7RQPn8zHxQCCPRgLc2OJAnsHHmOyXffxVpjwB86/xdaW7f9cw
	 rh2pwCk99ahHNRST5JTvCI1WLejh4UrdQR6zzjLUMAH2FkOgMTiIaQn8i+V+wg6XhZ
	 2F6oZGvY1HvERjih89nbnxE3eXLvkakdkUS0A+kiCMhJ2FkF9swg7GDGmp4pEyXXrk
	 VUyOdZP7CgW5VRsWwqbjt5/zLxAGAInbgM2y8s+C+Z31msJhh4hlywzKu7/nUpuf0d
	 Gq+V0JMLJZLhoFOliZiPWMsJnDtuk3GxtKECAbI+azp6B+f3LP1NXneKzrYrusnX9n
	 y2Guxfk8/HLxQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 13:33:18 +0200
Message-Id: <DBCLH4WXYTJL.FDZ9B39OO3TY@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4] rust: move ARef and AlwaysRefCounted to sync::aref
From: "Benno Lossin" <lossin@kernel.org>
To: "Shankari Anand" <shankari.ak0208@gmail.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250715110423.334744-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250715110423.334744-1-shankari.ak0208@gmail.com>

On Tue Jul 15, 2025 at 1:04 PM CEST, Shankari Anand wrote:
> Move the definitions of `ARef` and `AlwaysRefCounted` from `types.rs`
> to a new file `sync/aref.rs`.
> Define the corresponding `aref` module under `rust/kernel/sync.rs`.
> These types are better grouped in `sync`.
>
> To avoid breaking existing imports, they are re-exported from `types.rs`.
> Drop unused imports `mem::ManuallyDrop`, `ptr::NonNull` from `types.rs`,
> they are now only used in `sync/aref.rs`, where they are already imported=
.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

One comment below, but that can be fixed when applying the patch.

Reviewed-by: Benno Lossin <lossin@kernel.org>

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> new file mode 100644
> index 000000000000..752eef31d45e
> --- /dev/null
> +++ b/rust/kernel/sync/aref.rs
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Built-in Reference Counting Support
> +
> +use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref, ptr::NonN=
ull};
> +
> +/// Types that are _always_ reference counted.
> +///
> +/// It allows such types to define their own custom ref increment and de=
crement functions.
> +/// Additionally, it allows users to convert from a shared reference `&T=
` to an owned reference
> +/// [`ARef<T>`].
> +///
> +/// This is usually implemented by wrappers to existing structures on th=
e C side of the code. For
> +/// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to=
 create reference-counted
> +/// instances of a type.
> +

There is a missing `///` in this line, but Miguel can fix that when
picking the patch.

---
Cheers,
Benno

> +/// # Safety
> +///
> +/// Implementers must ensure that increments to the reference count keep=
 the object alive in memory
> +/// at least until matching decrements are performed.
> +///
> +/// Implementers must also ensure that all instances are reference-count=
ed. (Otherwise they
> +/// won't be able to honour the requirement that [`AlwaysRefCounted::inc=
_ref`] keep the object
> +/// alive.)
> +pub unsafe trait AlwaysRefCounted {

