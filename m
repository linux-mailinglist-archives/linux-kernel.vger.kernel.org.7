Return-Path: <linux-kernel+bounces-721828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FF1AFCE45
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046FB3B2DFA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A01B2E06EA;
	Tue,  8 Jul 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VU9TvYfB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615B2DE1FE;
	Tue,  8 Jul 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986411; cv=none; b=cfoHFd8MG7mfvU0h8hayLQYhJ+4ke5/8jd426BV1JILUwT1ta1mwiuv1O6/pLwscoZ1bqAzZXBqpn/fvZq+dIkIK4VWDf6QNK9iapYHehOF2Z4tqWfSPnquVwiucm9yGXHWZ6mwqPzNyqyWn40kNOhasmla65GiZcKb/ps2hj98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986411; c=relaxed/simple;
	bh=CbchSDI0+aXY4EcxahPrJAQQLeD1XK9toKpKKPgC/r4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mz4mvOvh9rXdzJTp1zbjCAsw+me01ffuTYbjzreWfNfqye0XfZJaQq6UdQgjRPIs2Jw+fLq+dxhiJS6bMM+fofXkF4I6Aj6ydJnNob6rZxmGBLelEII+k2ekZcbphVHwn7/oLnYxEztdrwsrsAmxNn8VAQn9y3W0wMvk6g3RgVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VU9TvYfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBD9C4CEED;
	Tue,  8 Jul 2025 14:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751986411;
	bh=CbchSDI0+aXY4EcxahPrJAQQLeD1XK9toKpKKPgC/r4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VU9TvYfB/sR5o/H8+5SBmbHOIYr+zhTJUFM9mUALq2q1Ik0irotNea2VkFFtVKZ3Z
	 EdHBskIh3M6fLrga8tlkeyzVV/HPkFB4noS8HpnYYkMXjsvtEj7z25ASy0BDN8/ROt
	 HXJ+HUzqUrWFWYsId8luypld+gg0lcfUJEQ8I80WAtWKPfmSG2PneF4eb26Wxxz7IB
	 WdCLzBAJrIHZT+PVSI0M+AQHyoUDTFNuTogdfGPKA88PNiCScWWJmYNYmEvy+AdGKv
	 p16ZYqM32jmk7VOqJHKb++enKyjHHIGNsw10OGuKLqx5lkExXg63B6xqNf7N0wNyhQ
	 7vc94RVVQumNQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Alexander Viro"
 <viro@zeniv.linux.org.uk>,  "Arnd Bergmann" <arnd@arndb.de>,  "Miguel
 Ojeda" <ojeda@kernel.org>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary
 Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Matthew Maurer" <mmaurer@google.com>,  "Lee Jones"
 <lee@kernel.org>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>,  "Benno Lossin" <lossin@kernel.org>
Subject: Re: [PATCH v2 3/4] rust: miscdevice: Provide additional
 abstractions for iov_iter and kiocb structures
In-Reply-To: <20250704-iov-iter-v2-3-e69aa7c1f40e@google.com> (Alice Ryhl's
	message of "Fri, 04 Jul 2025 09:26:02 +0000")
References: <20250704-iov-iter-v2-0-e69aa7c1f40e@google.com>
	<A6L7hDRsDyJJvX_NuoUG_Zb-Jy_BMdGLhjsq5xUSRkl6hpItQD9ZvX5ChAr9QIFH4eeDBpW-Q-582Tt4Nef5SA==@protonmail.internalid>
	<20250704-iov-iter-v2-3-e69aa7c1f40e@google.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 08 Jul 2025 16:53:23 +0200
Message-ID: <87qzyqn38c.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> These will be used for the read_iter() and write_iter() callbacks, which
> are now the preferred back-ends for when a user operates on a char device
> with read() and write() respectively.
>
> Co-developed-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/miscdevice.rs | 97 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> index 22f291211636f66efca6b33b675833236332719e..a49954c9b0d14117645be8139db792f1fd22589d 100644
> --- a/rust/kernel/miscdevice.rs
> +++ b/rust/kernel/miscdevice.rs
> @@ -14,13 +14,14 @@
>      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
>      ffi::{c_int, c_long, c_uint, c_ulong},
>      fs::File,
> +    iov::{IovIterDest, IovIterSource},
>      mm::virt::VmaNew,
>      prelude::*,
>      seq_file::SeqFile,
>      str::CStr,
>      types::{ForeignOwnable, Opaque},
>  };
> -use core::{marker::PhantomData, mem::MaybeUninit, pin::Pin};
> +use core::{marker::PhantomData, mem::MaybeUninit, pin::Pin, ptr::NonNull};
>
>  /// Options for creating a misc device.
>  #[derive(Copy, Clone)]
> @@ -136,6 +137,16 @@ fn mmap(
>          build_error!(VTABLE_DEFAULT_ERROR)
>      }
>
> +    /// Read from this miscdevice.
> +    fn read_iter(_kiocb: Kiocb<'_, Self::Ptr>, _iov: &mut IovIterDest<'_>) -> Result<usize> {
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Write to this miscdevice.
> +    fn write_iter(_kiocb: Kiocb<'_, Self::Ptr>, _iov: &mut IovIterSource<'_>) -> Result<usize> {
> +        build_error!(VTABLE_DEFAULT_ERROR)
> +    }
> +
>      /// Handler for ioctls.
>      ///
>      /// The `cmd` argument is usually manipulated using the utilities in [`kernel::ioctl`].
> @@ -177,6 +188,36 @@ fn show_fdinfo(
>      }
>  }
>
> +/// Wrapper for the kernel's `struct kiocb`.
> +///
> +/// The type `T` represents the private data of the file.
> +pub struct Kiocb<'a, T> {
> +    inner: NonNull<bindings::kiocb>,
> +    _phantom: PhantomData<&'a T>,
> +}

Also, `kiocb` is not miscdevice specific. It should probably not live here.


Best regards,
Andreas Hindborg



