Return-Path: <linux-kernel+bounces-756309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46937B1B283
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7549017B44A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9AB247287;
	Tue,  5 Aug 2025 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQDpU2e9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3000B1D7E5B;
	Tue,  5 Aug 2025 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754392690; cv=none; b=i73wz+O2sUP0ifz2TLXUD/pSp7iVtogyt7gK3RLIrQVlFpams1C/Aq0r9PGI8f5TKQFEzJ8XlRRMH8dTQ5yV6OTY2dU/yRpAjcYK7r2SFJIhySTyVci+Y5L9CEWqQ9k81bT1FiJ7NWR4FoIv+ZLjN2bFLu/Jw0jMJbmZ0JyLsCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754392690; c=relaxed/simple;
	bh=xvDDh6gLJbQlXLbG0l9A91FOiX1KeXuPAWb5BgdpKv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VKVsXpAPAPvgwKkOtNUtPNjpBOZOe39xO1JFBV3ecyPoNCZpua0uLG+BxyolQtXwYHUxnM2D/7gh1iPE7OzAZhExxzpK/buL78+qFINZegx5JoBE01U2dUGxlvzcjZZlV0BPHcKkur1y+CwDVej6rbyHbtb8Ywi2ZGmznQgpQLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQDpU2e9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DB4C4CEF0;
	Tue,  5 Aug 2025 11:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754392689;
	bh=xvDDh6gLJbQlXLbG0l9A91FOiX1KeXuPAWb5BgdpKv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tQDpU2e9dyJ0Y0eo/K6rBrM9cRpIq6uWRFS+9PJRr5rNS93vHBoBW2AlujTez0uBa
	 7VDkhp22hATZxeej3I4zI2uIm6caqGQ98Q6L2pmwNu/wAcIrnjFwzv38JDc9coa2gO
	 yFgs9/nmNA/9zkZ+BqxYOevMpKJL6w1qfV2EGM8ECdjEWUV2uHHXKXXzG+OdHMKK/P
	 HTIhCSvsRgwP6kp+5miv7AykyR0Dph0OFMQ5Wd72nvXF/DT1Whsl2XZAq8+tEN0TFk
	 cmvq3AcUwiUm9a4hZ42Ny+sdolKuKR0U8h2Fs9q0Uze1RHt+cRazv0b/x96rxOoQUQ
	 5pLE2krAf0qOw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>,
 Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Alice
 Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>
Subject: Re: [PATCH v3 1/4] rust: iov: add iov_iter abstractions for
 ITER_SOURCE
In-Reply-To: <20250722-iov-iter-v3-1-3efc9c2c2893@google.com>
References: <20250722-iov-iter-v3-0-3efc9c2c2893@google.com>
 <IMil7T48wWl_KirFiwKV5bNm7TuVsFNPEX3_6CJWEzwQ6n4jaVn943ujBotHAettCFL5Slnb0v_3Cz50enMdqw==@protonmail.internalid>
 <20250722-iov-iter-v3-1-3efc9c2c2893@google.com>
Date: Tue, 05 Aug 2025 13:17:57 +0200
Message-ID: <871ppq9fve.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> This adds abstractions for the iov_iter type in the case where
> data_source is ITER_SOURCE. This will make Rust implementations of
> fops->write_iter possible.
>
> This series only has support for using existing IO vectors created by C
> code. Additional abstractions will be needed to support the creation of
> IO vectors in Rust code.
>
> These abstractions make the assumption that `struct iov_iter` does not
> have internal self-references, which implies that it is valid to move it
> between different local variables.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

..

> +
> +    /// Advance this IO vector backwards by `bytes` bytes.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The IO vector must not be reverted to before its beginning.
> +    #[inline]
> +    pub unsafe fn revert(&mut self, bytes: usize) {
> +        // SAFETY: By the struct invariants, `self.iov` is a valid IO vector, and `bytes` is in
> +        // bounds.

"... and by method safety requirements `bytes` is in bounds", right?

> +        unsafe { bindings::iov_iter_revert(self.as_raw(), bytes) };
> +    }
> +
> +    /// Read data from this IO vector.
> +    ///
> +    /// Returns the number of bytes that have been copied.
> +    #[inline]
> +    pub fn copy_from_iter(&mut self, out: &mut [u8]) -> usize {
> +        // SAFETY: `Self::copy_from_iter_raw` guarantees that it will not deinitialize any bytes in
> +        // the provided buffer, so `out` is still a valid `u8` slice after this call.

I am curious if there is a particular reason you chose "deinitialize"
over "write uninitialized" for the wording throughout this patch? It's
an unfamiliar phrasing to me.


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




