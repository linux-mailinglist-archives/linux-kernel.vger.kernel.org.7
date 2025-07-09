Return-Path: <linux-kernel+bounces-723563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48535AFE881
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D552E6E279F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E0B2D8782;
	Wed,  9 Jul 2025 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLU+UAc8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A91DDA15;
	Wed,  9 Jul 2025 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062390; cv=none; b=JtlebxHC9tEC089Ev6Sw53TCMUsW2GnRAy4M1mqpEdQF576E3TWFMxyUZcVxTwstY3FF7qzPd6gz0enxk8X9ZX09BbmGDdpi80jRxIN8ZGutFoQKzeh1w9RKj8xELUIOdQuWF4Q3mv9cpciH5krd6lC6Kmb+ghuW+zpvqFTQKt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062390; c=relaxed/simple;
	bh=ZLIawoJpEjJNvcyrTeVPL644EuAsMFEbpNZ0jCIrUFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C2sg2pp+7SmUdZVG9M3sSMfGnD8tgZB6VF6JZS3rOA5n2vgpl7JsDBJ/sWV06ImLua7O30GgBrGFW5QJWstcgvlQ0hzH0Dws3QNxkondcmwystvz3p/j/29CViQNAXkI0ELycDQ+fzqju2JvpVsHfbSLUCOKFzQMP3KAyLvwzAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLU+UAc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21058C4CEEF;
	Wed,  9 Jul 2025 11:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752062389;
	bh=ZLIawoJpEjJNvcyrTeVPL644EuAsMFEbpNZ0jCIrUFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RLU+UAc8l6gmtxK93yIHE7QX+W/vSzPmtGUDInGARybuOMKbGjTWpsTdDjbXPRaVt
	 3BFY8jLb/l0axXC2kbpSny7JT0Ah4FMeV7ZsAFxqpnzndmb2Vv+9awH787RPvhptnm
	 AFb2Jd66kYRZlXPH2ep7c2ug/ibPgjE8mtBpMqKRXInjGf7qFR99NmXuc0ITYzD+iz
	 6vMiw9SOV8BHl47FnqeARe+pWjrxpq/Vi//U2vOAaSMDnvwWbH3FEkpEAPUuMv0XaW
	 xsizmizb5fgIxVPq7trllnIVDTAVJAkLJTXepxYzRIuCnjIHPr3eA1dacZiwdkiOod
	 kY5PmRt3O0yfg==
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
In-Reply-To: <aG5Ole-PoioPgSuh@google.com> (Alice Ryhl's message of "Wed, 09
	Jul 2025 11:12:21 +0000")
References: <20250704-iov-iter-v2-0-e69aa7c1f40e@google.com>
	<A6L7hDRsDyJJvX_NuoUG_Zb-Jy_BMdGLhjsq5xUSRkl6hpItQD9ZvX5ChAr9QIFH4eeDBpW-Q-582Tt4Nef5SA==@protonmail.internalid>
	<20250704-iov-iter-v2-3-e69aa7c1f40e@google.com>
 <87qzyqn38c.fsf@kernel.org>
	<7VOY72SwAlUtrhYdmRhHdME1qp3TgfqYay1YTLsUwtHAN8NA9NCWAMHqM_v71s_Me6KBo6pHVfWoAQ-lLLLdAA==@protonmail.internalid>
	<aG5Ole-PoioPgSuh@google.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 09 Jul 2025 13:59:26 +0200
Message-ID: <8734b5lgm9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Tue, Jul 08, 2025 at 04:53:23PM +0200, Andreas Hindborg wrote:
>> "Alice Ryhl" <aliceryhl@google.com> writes:
>>
>> > These will be used for the read_iter() and write_iter() callbacks, which
>> > are now the preferred back-ends for when a user operates on a char device
>> > with read() and write() respectively.
>> >
>> > Co-developed-by: Lee Jones <lee@kernel.org>
>> > Signed-off-by: Lee Jones <lee@kernel.org>
>> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> > ---
>> >  rust/kernel/miscdevice.rs | 97 ++++++++++++++++++++++++++++++++++++++++++++++-
>> >  1 file changed, 96 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
>> > index 22f291211636f66efca6b33b675833236332719e..a49954c9b0d14117645be8139db792f1fd22589d 100644
>> > --- a/rust/kernel/miscdevice.rs
>> > +++ b/rust/kernel/miscdevice.rs
>> > @@ -14,13 +14,14 @@
>> >      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
>> >      ffi::{c_int, c_long, c_uint, c_ulong},
>> >      fs::File,
>> > +    iov::{IovIterDest, IovIterSource},
>> >      mm::virt::VmaNew,
>> >      prelude::*,
>> >      seq_file::SeqFile,
>> >      str::CStr,
>> >      types::{ForeignOwnable, Opaque},
>> >  };
>> > -use core::{marker::PhantomData, mem::MaybeUninit, pin::Pin};
>> > +use core::{marker::PhantomData, mem::MaybeUninit, pin::Pin, ptr::NonNull};
>> >
>> >  /// Options for creating a misc device.
>> >  #[derive(Copy, Clone)]
>> > @@ -136,6 +137,16 @@ fn mmap(
>> >          build_error!(VTABLE_DEFAULT_ERROR)
>> >      }
>> >
>> > +    /// Read from this miscdevice.
>> > +    fn read_iter(_kiocb: Kiocb<'_, Self::Ptr>, _iov: &mut IovIterDest<'_>) -> Result<usize> {
>> > +        build_error!(VTABLE_DEFAULT_ERROR)
>> > +    }
>> > +
>> > +    /// Write to this miscdevice.
>> > +    fn write_iter(_kiocb: Kiocb<'_, Self::Ptr>, _iov: &mut IovIterSource<'_>) -> Result<usize> {
>> > +        build_error!(VTABLE_DEFAULT_ERROR)
>> > +    }
>> > +
>> >      /// Handler for ioctls.
>> >      ///
>> >      /// The `cmd` argument is usually manipulated using the utilities in [`kernel::ioctl`].
>> > @@ -177,6 +188,36 @@ fn show_fdinfo(
>> >      }
>> >  }
>> >
>> > +/// Wrapper for the kernel's `struct kiocb`.
>> > +///
>> > +/// The type `T` represents the private data of the file.
>> > +pub struct Kiocb<'a, T> {
>> > +    inner: NonNull<bindings::kiocb>,
>> > +    _phantom: PhantomData<&'a T>,
>> > +}
>>
>> Also, `kiocb` is not miscdevice specific. It should probably not live here.
>
> I can place it in rust/kernel/fs.rs, but this is an instance of the more
> general fact that miscdevice defines many things from `file_operations`
> that we should probably generalize in the future.

I support moving `Kiocb` to `fs` now, rather than later.


Best regards,
Andreas Hindborg




