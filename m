Return-Path: <linux-kernel+bounces-764205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2A1B21FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DFDE4E496A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FEA2DC32F;
	Tue, 12 Aug 2025 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAgXF5eH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85446B5;
	Tue, 12 Aug 2025 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985041; cv=none; b=Yhsi22BA9iZoUOgSLGU/rMezIlMAjmt5ku2JW+n+AjxM7RRs3WvMDWl9+RpwYHNtyMrAxWZ/ZmXfHXjmJycmr9SaT+agehUqgVO9fGr5IPHyhi6R7NgHL6wueYJJ36zN7u/5t5NLRSyCRT9objOXR9BCUPs27AeqXefBLXcyr1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985041; c=relaxed/simple;
	bh=jL7TweB+A4An+odth608kJuC46f36dxg8uTFgXc0lrc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=aNHv+vM4157JJOhbh9qNOUYUZQ8LSgPWw6JwSsIhxid0yZEOtBnhUdFNTfzHrxeM9Yp/ELqKnCgbzLQsav1FAj3slR7if2nlQlOs5I42h7qShryd2qi0Vhm+DCBIiFkG+ujCKRoP+2QhELjy6QTO2yv44p//Xels8GMi8R6uF8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAgXF5eH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104CEC4CEF0;
	Tue, 12 Aug 2025 07:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754985040;
	bh=jL7TweB+A4An+odth608kJuC46f36dxg8uTFgXc0lrc=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=eAgXF5eH5tfElQstMZbtQiDrsJ5qbBJbUyxY+YavkBq0wmG6FX7xG0FtnKyN2VHRI
	 M7waiV76/ajkKwWjwRMSH2Ka+HcdlcivP4ODi7gkJcsidA2cpkw8W2eSx9+L+HtQuo
	 847jno7mxblqEbTqcXXxJmsmCdo8vJxOYTs06+vnUM4stRxIi9zemZ7ql5X9SfmHOF
	 39btW+uoklQvyhTmMrQsPdxnYIBPjsKM5DSt9I9gb1Qkmr/e1CToejAhmbcbBbHrbi
	 +RtcmVAknbelYgA0NNztsznPWqLBATkhyP/6yDbK0X1GjfakS3katd6XRu642hwzoP
	 jbDf3KigjDuEA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 09:50:34 +0200
Message-Id: <DC0A9UKTPH05.2O2V0B2KHMIW8@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Russ Weight"
 <russ.weight@linux.dev>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Waiman Long"
 <longman@redhat.com>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <nick.desaulniers+lkml@gmail.com>, "Bill Wendling"
 <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>, "Christian
 Brauner" <brauner@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <llvm@lists.linux.dev>
Subject: Re: [PATCH v14 3/3] rust: replace `CStr` with `core::ffi::CStr`
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250710-cstr-core-v14-0-ca7e0ca82c82@gmail.com>
 <20250710-cstr-core-v14-3-ca7e0ca82c82@gmail.com>
In-Reply-To: <20250710-cstr-core-v14-3-ca7e0ca82c82@gmail.com>

On Thu Jul 10, 2025 at 4:53 PM CEST, Tamir Duberstein wrote:
> `kernel::ffi::CStr` was introduced in commit d126d2380131 ("rust: str:
> add `CStr` type") in November 2022 as an upstreaming of earlier work
> that was done in May 2021[0]. That earlier work, having predated the
> inclusion of `CStr` in `core`, largely duplicated the implementation of
> `std::ffi::CStr`.
>
> `std::ffi::CStr` was moved to `core::ffi::CStr` in Rust 1.64 in
> September 2022. Hence replace `kernel::str::CStr` with `core::ffi::CStr`
> to reduce our custom code footprint, and retain needed custom
> functionality through an extension trait.
>
> Add `CStr` to `ffi` and the kernel prelude.
>
> Link: https://github.com/Rust-for-Linux/linux/commit/faa3cbcca03d0dec8f8e=
43f1d8d5c0860d98a23f [0]
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

> ---
>  rust/ffi.rs                     |   2 +
>  rust/kernel/device.rs           |   1 +
>  rust/kernel/error.rs            |   2 +
>  rust/kernel/firmware.rs         |   9 +-
>  rust/kernel/prelude.rs          |   4 +-
>  rust/kernel/seq_file.rs         |   2 +-
>  rust/kernel/str.rs              | 395 +++++++++-------------------------=
------
>  rust/kernel/sync/condvar.rs     |   2 +-
>  rust/kernel/sync/lock.rs        |   2 +-
>  rust/kernel/sync/lock/global.rs |   2 +-
>  10 files changed, 106 insertions(+), 315 deletions(-)

> +/// Extensions to [`CStr`].
> +pub trait CStrExt {

Should we make this trait sealed?

---
Cheers,
Benno

>      /// Wraps a raw C string pointer.
>      ///
>      /// # Safety

