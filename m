Return-Path: <linux-kernel+bounces-764246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDB8B2206A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA993423C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CEE2E03F2;
	Tue, 12 Aug 2025 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4vwAT74"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F11D2D9EFC;
	Tue, 12 Aug 2025 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986214; cv=none; b=uOjQY+HL+TgFXj8PCtpjjjNfBVyQ+rRYQA0+55HxjriJK7mauEWNnK4cEl9z6gnMV6BgySrC0kD1mBQeQZRFjgRLHhd2+cb/MliVxsn9b2Ha715uITNxI2jw8Rook/bWmM9W5b1JrlLgnd/XhMicBRI2z90IIRY72hHm60T5MHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986214; c=relaxed/simple;
	bh=1AYWQG54H8dP/KuZvbHzMDhOf9ghwMUB+eF7IZwj644=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=S+dJdmVCrhHnHlfi8zPPyqA4Wb4v/j12k27R2+LxokwQp4oomDHIsaknXW9+jt6CIOlLNoUMlIrh9WKjLV3Qa1RmMg9M9GqLAl762DQTs0vf15rByodoalUlzGxkMdqLXNe0mQh3bXHucfVAnAD39d5wWvbMYUsBDbfU4ybrcA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4vwAT74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3036C4CEF0;
	Tue, 12 Aug 2025 08:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754986213;
	bh=1AYWQG54H8dP/KuZvbHzMDhOf9ghwMUB+eF7IZwj644=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=g4vwAT742Ka0RCJqUh0mUyTeLmR+9TiwWx/Dz7xQuTmmdAqxmdsyFc0u9fcRBDXLI
	 ouv2ni5rhF5SS5CP8pjLjIu8t4er7GqSJSh6q/gvDd4I/wMm9EvXn1smxXdEVM+Fua
	 yiz2fxwqGZLuxclKd4Q87VYfRVpiHFuuiJjg2DRAYDkqt9VbiL3+NFFSlFzRJrayDY
	 gerxoZGpdnx2u6r4vPavKh5WfG0BEoixnbw23bSJ5jxT51jF3JdKMui39akhZe/VYa
	 OtkQnzgZhf4U6oji9ql7kLQwIfbbY9v00vh8xIIK6VVJdaQMcUQ0pCeYRNHGnNoDKD
	 fxG0664O7NeUg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 10:10:08 +0200
Message-Id: <DC0AOTWSN7X8.2ZCPAFGHB9XJ@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, "Fiona Behrens" <me@kloenk.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] rust: implement `kernel::sync::Refcount`
From: "Benno Lossin" <lossin@kernel.org>
To: "Gary Guo" <gary@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Tamir Duberstein" <tamird@gmail.com>, "Ingo
 Molnar" <mingo@kernel.org>, "Mitchell Levy" <levymitchell0@gmail.com>,
 "Lyude Paul" <lyude@redhat.com>, "Wedson Almeida Filho"
 <wedsonaf@gmail.com>, "Viresh Kumar" <viresh.kumar@linaro.org>
X-Mailer: aerc 0.20.1
References: <20250723233312.3304339-1-gary@kernel.org>
 <20250723233312.3304339-2-gary@kernel.org>
In-Reply-To: <20250723233312.3304339-2-gary@kernel.org>

On Thu Jul 24, 2025 at 1:32 AM CEST, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> This is a wrapping layer of `include/linux/refcount.h`. Currently the
> kernel refcount has already been used in `Arc`, however it calls into
> FFI directly.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Benno Lossin <lossin@kernel.org>

> ---
>  rust/helpers/refcount.c      | 10 ++++
>  rust/kernel/sync.rs          |  2 +
>  rust/kernel/sync/refcount.rs | 98 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 110 insertions(+)
>  create mode 100644 rust/kernel/sync/refcount.rs

> +    #[inline]
> +    fn as_ptr(&self) -> *mut bindings::refcount_t {

I think we should make this `pub(crate)` from the get-go.

> +        self.0.get()
> +    }
> +

> +    /// Decrement a refcount and test if it is 0.
> +    ///
> +    /// It will `WARN` on underflow and fail to decrement when saturated=
.
> +    ///
> +    /// Provides release memory ordering, such that prior loads and stor=
es are done
> +    /// before, and provides an acquire ordering on success such that me=
mory deallocation
> +    /// must come after.
> +    ///
> +    /// Returns true if the resulting refcount is 0, false otherwise.
> +    ///
> +    /// # Notes
> +    ///
> +    /// A common pattern of using `Refcount` is to free memory when the =
reference count reaches
> +    /// zero. This means that the reference to `Refcount` could become i=
nvalid after calling this
> +    /// function. This is fine as long as the reference to `Refcount` is=
 no longer used when this
> +    /// function returns `false`. It is not necessary to use raw pointer=
s in this scenario, see
> +    /// https://github.com/rust-lang/rust/issues/55005.

Missing `<>` around link.

---
Cheers,
Benno

