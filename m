Return-Path: <linux-kernel+bounces-721822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3771FAFCE34
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4823A1DCB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62BE2DECD4;
	Tue,  8 Jul 2025 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADi6aOhy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046313957E;
	Tue,  8 Jul 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986281; cv=none; b=fZHAfZBlyHh1s5+N1MOQmG/4AIkpLbnsaVlRgKdTIxVAAJZBmzT5jVEgAdQ03zGG5yCI3JvG7viQRISL5gpr1Xuu5GYBnakSkxUmS//scQOObeV0MLwmtu6QWAsEfdW3uF2Opwdkdvw5ODM8RDcw7gib8mRhuT/N8JQbMGupUtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986281; c=relaxed/simple;
	bh=2dWFtmfC/Fk3lQKdvmV4x8eA0P4RAU40VOp0+/3rNuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m3itDTigVk7DPyHi48M+h+HmAYcOvn+yRIoDY2oqOI0iMmdgvomJXzvrqluPHmT83l/VBD7wmZY5U8vQuiBJXF4saUNOB9mE9iUl+Oc9HeMS62ICAq5kkQuERCdi/aQPVeey1yUZHF6logV0jC53wad1OcAoMBRC4vytmEU0UHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADi6aOhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38830C4CEED;
	Tue,  8 Jul 2025 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751986280;
	bh=2dWFtmfC/Fk3lQKdvmV4x8eA0P4RAU40VOp0+/3rNuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ADi6aOhyGMPJWJ8ylzPN7+2KDsBNsV5AycLQj3o5QMvj5qkJl6OsFrjhjkhPspmEH
	 aaE21wlwxTEgJhtis13dD2wb2rLJgP4qDYHKzBf+MIABfl4hzwHkWQjGt1TFsfh03Z
	 OYlqkuPUPmllsUVRHGcFc8t5gEYBpODoh0AqZrlZEK+twgIScGvHG6iuVzQ+0pzH50
	 dh8+zRwTNL5p6dSsEGajSZCzpiVbo9h3Z2CFUiURh87vJroXijVFQrQjCPdgT/axv6
	 6l9fvC45/cIEeygbfi8Lr0v/fKOEZWSDognYi6WfIfFTMj4U8fbN3ngHbW9AgTur2p
	 C5NRsc4q/NA5Q==
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
Date: Tue, 08 Jul 2025 16:51:11 +0200
Message-ID: <87wm8in3c0.fsf@kernel.org>
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


Could you give more context? Please describe the purpose for the type
and intended use. Perhaps give an example that can be compile tested.


Best regards,
Andreas Hindborg




