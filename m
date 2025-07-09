Return-Path: <linux-kernel+bounces-724163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E7CAFEF55
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA244E5214
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ED52236F2;
	Wed,  9 Jul 2025 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnHnN4j+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B6220B7FE;
	Wed,  9 Jul 2025 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752080712; cv=none; b=C1WVro7WHNAEUg1at7VVtnfIZmI3IvJ5892noUYcw7TMWmtdUAal5PMDGGu5zEGXQBf/+c8jXD9htIwKYfe43MGk/P0BCtQ1FsE2LMNu0sTGx4+ruSET6rWMd3meL1rKlueNnPBckbxp3kqm86P8ujR4Rt1GU0jaIiG3EUafGgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752080712; c=relaxed/simple;
	bh=McnLOlcWCG5BO2jKA1/qEpq1icS9OiqcRxhXegryC/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=glsKfVaHqqFKEdvSKTgr7ZOOlSWtXtwDCUAYs67HLC7ug0u32O9iZ8Rb4zTKFqIa5PBmDffemsCCiHDhJOy6uidDMPV75K5tDk7Ys0Ndb2kW3Lt4TAEnbPENiC805hPh5O2U5n3D8SiOEtI+NUXbQSiDafp+NW/+oin49ImeqgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnHnN4j+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743EBC4CEEF;
	Wed,  9 Jul 2025 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752080711;
	bh=McnLOlcWCG5BO2jKA1/qEpq1icS9OiqcRxhXegryC/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OnHnN4j+AhbiHjBr5rs4CwJrBosZNWH2CZGfGMm+pPPDqINNpZhqpL2B2q6Q0IalF
	 Pd2g/EaQkaci8Hqb0hdRXrLU5vNVcgcOpj2xSFrf2APU5u3G3okNgiBvJOVnryb3hp
	 HaLQQ3y50EV8zH//02z9+TUt9tvXLXvCXRj9eM6cOv0vctKOCPcFxzdN9oUQeYl/HB
	 THfg3Zvxu4vPTN2o1EEWLuDtp+J6Q66PxotSyT/WYxBInPyLOlEo5wb84jHDpQGH61
	 jOVQDj8njJt7qAaT6GA85V3em/I513Zb0eM9Hp7PuRscEo6DY1fM4qHswwRZXDnnoK
	 G9yAFFMaDQuvw==
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
Subject: Re: [PATCH v2 1/4] rust: iov: add iov_iter abstractions for
 ITER_SOURCE
In-Reply-To: <aG5iLiUJg_cHtB8r@google.com> (Alice Ryhl's message of "Wed, 09
	Jul 2025 12:35:58 +0000")
References: <20250704-iov-iter-v2-0-e69aa7c1f40e@google.com>
	<U16UjMBBh1b7dLeO-Nhqw__nw_JwypctB1ze_G44BtsX0l_eVK6Sp-efbobmnuF44J0wQNgnK7b8nCmBX0KS_Q==@protonmail.internalid>
	<20250704-iov-iter-v2-1-e69aa7c1f40e@google.com>
 <878qkyoi6d.fsf@kernel.org>
	<0Y9Bjahrc6dbxzIFtBKXUxv-jQtuvM2UWShaaSUsjKBuC1KKeGIpBFTC4a89oNrOLBP66SXtC7kQx1gtt04CMg==@protonmail.internalid>
	<aG5NdqmUdvUHqUju@google.com> <87ecuplgqy.fsf@kernel.org>
	<q7QRbcFgb5yhmBOt4eLkkzqyckspc2L2g3e0pXhJxm0yBVeG2Hifi4O77gaxwpWss1Z_CUjSy1P22ppxcxo8jw==@protonmail.internalid>
	<aG5iLiUJg_cHtB8r@google.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 09 Jul 2025 19:05:01 +0200
Message-ID: <87ikk1jnwi.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Wed, Jul 09, 2025 at 01:56:37PM +0200, Andreas Hindborg wrote:
>> "Alice Ryhl" <aliceryhl@google.com> writes:
>>
>> > On Tue, Jul 08, 2025 at 04:45:14PM +0200, Andreas Hindborg wrote:
>> >> "Alice Ryhl" <aliceryhl@google.com> writes:
>> >> > +/// # Invariants
>> >> > +///
>> >> > +/// Must hold a valid `struct iov_iter` with `data_source` set to `ITER_SOURCE`. For the duration
>> >> > +/// of `'data`, it must be safe to read the data in this IO vector.
>> >>
>> >> In my opinion, the phrasing you had in v1 was better:
>> >>
>> >>   The buffers referenced by the IO vector must be valid for reading for
>> >>   the duration of `'data`.
>> >>
>> >> That is, I would prefer "must be valid for reading" over "it must be
>> >> safe to read ...".
>> >
>> > If it's backed by userspace data, then technically there aren't any
>> > buffers that are valid for reading in the usual sense. We need to call
>> > into special assembly to read it, and a normal pointer dereference would
>> > be illegal.
>>
>> If you go with "safe to read" for this reason, I think you should expand
>> the statement along the lines you used here.
>>
>> What is the special assembly that is used to read this data? From a
>> quick scan it looks like that if `CONFIG_UACCESS_MEMCPY` is enabled, a
>> regular `memcpy` call is used.
>
> When reading from userspace, you're given an arbitrary untrusted address
> that could point anywhere. The memory could be swapped out and need to
> be loaded back from disk. The memory could correspond to an mmap region
> for a file on a NFS mount and reading it could involve a network call.
> The address could be dangling, which must be properly handled and turned
> into an EFAULT error instead of UB. Every architecture has its own asm
> for handling all of this safely so that behavior is safe no matter what
> pointer we are given from userspace.

I don't think that is relevant. My point is, you can't reference
"special assemby" without detailing what that means.

You have a safety requirement in `from_raw`:

    /// * For the duration of `'data`, the buffers backing this IO vector must be valid for
    ///   reading.

This should probably be promoted to invariant for the type, since
`from_raw` is the only way to construct the type?

But are you saying that the referenced buffers need not be mapped and
readable while this type exists? The mapping happens as part of
`bindings::_copy_to_iter`?

> As for CONFIG_UACCESS_MEMCPY, I don't think it is used on any real
> system today. It would require you to be on a NOMMU system where the
> userspace and the kernel are in the same address space.

Ah. I was just browsing for the "special assembly", and that was all I
could find.

>
>> >> > +    /// Returns the number of bytes available in this IO vector.
>> >> > +    ///
>> >> > +    /// Note that this may overestimate the number of bytes. For example, reading from userspace
>> >> > +    /// memory could fail with `EFAULT`, which will be treated as the end of the IO vector.
>> >> > +    #[inline]
>> >> > +    pub fn len(&self) -> usize {
>> >> > +        // SAFETY: It is safe to access the `count` field.
>> >>
>> >> Reiterating my comment from v1: Why?
>> >
>> > It's the same reason as why this is safe:
>> >
>> > struct HasLength {
>> >     length: usize,
>> > }
>> > impl HasLength {
>> >     fn len(&self) -> usize {
>> >         // why is this safe?
>> >         self.length
>> >     }
>> > }
>> >
>> > I'm not sure how to say it concisely. I guess it's because all access to
>> > the iov_iter goes through the &IovIterSource.
>>
>> So "By existence of a shared reference to `self`, `count` is valid for read."?
>>
>> >
>> >> > +        unsafe {
>> >> > +            (*self.iov.get())
>> >> > +                .__bindgen_anon_1
>> >> > +                .__bindgen_anon_1
>> >> > +                .as_ref()
>> >> > +                .count
>> >> > +        }
>> >> > +    }
>> >> > +
>> >> > +    /// Returns whether there are any bytes left in this IO vector.
>> >> > +    ///
>> >> > +    /// This may return `true` even if there are no more bytes available. For example, reading from
>> >> > +    /// userspace memory could fail with `EFAULT`, which will be treated as the end of the IO vector.
>> >> > +    #[inline]
>> >> > +    pub fn is_empty(&self) -> bool {
>> >> > +        self.len() == 0
>> >> > +    }
>> >> > +
>> >> > +    /// Advance this IO vector by `bytes` bytes.
>> >> > +    ///
>> >> > +    /// If `bytes` is larger than the size of this IO vector, it is advanced to the end.
>> >> > +    #[inline]
>> >> > +    pub fn advance(&mut self, bytes: usize) {
>> >> > +        // SAFETY: `self.iov` is a valid IO vector.
>> >> > +        unsafe { bindings::iov_iter_advance(self.as_raw(), bytes) };
>> >> > +    }
>> >> > +
>> >> > +    /// Advance this IO vector backwards by `bytes` bytes.
>> >> > +    ///
>> >> > +    /// # Safety
>> >> > +    ///
>> >> > +    /// The IO vector must not be reverted to before its beginning.
>> >> > +    #[inline]
>> >> > +    pub unsafe fn revert(&mut self, bytes: usize) {
>> >> > +        // SAFETY: `self.iov` is a valid IO vector, and `bytes` is in bounds.
>> >> > +        unsafe { bindings::iov_iter_revert(self.as_raw(), bytes) };
>> >> > +    }
>> >> > +
>> >> > +    /// Read data from this IO vector.
>> >> > +    ///
>> >> > +    /// Returns the number of bytes that have been copied.
>> >> > +    #[inline]
>> >> > +    pub fn copy_from_iter(&mut self, out: &mut [u8]) -> usize {
>> >> > +        // SAFETY: We will not write uninitialized bytes to `out`.
>> >>
>> >> Can you provide something to back this claim?
>> >
>> > I guess the logic could go along these lines:
>> >
>> > * If the iov_iter reads from userspace, then it's because we always
>> >   consider such reads to produce initialized data.
>>
>> I don't think it is enough to just state that we consider the reads to
>> produce initialized data.
>
> See above re userspace.

You actually have the safety requirement I was looking for in
`from_raw`:


    /// * For the duration of `'data`, the buffers backing this IO vector must be valid for
    ///   reading.

But I am wondering whether this needs to align with the invariant, and
not the other way around?

>
>> > * If the iov_iter reads from a kernel buffer, then the creator of the
>> >   iov_iter must provide an initialized buffer.
>> >
>> > Ultimately, if we don't know that the bytes are initialized, then it's
>> > impossible to use the API correctly because you can never inspect the
>> > bytes in any way. I.e., any implementation of copy_from_iter that
>> > produces uninit data is necessarily buggy.
>>
>> I would agree. How do we fix that? You are more knowledgeable than me in
>> this field, so you probably have a better shot than me, at finding a
>> solution.
>
> I think there is nothing to fix. If there exists a callsite on the C
> side that creates an iov_iter that reads from an uninitialized kernel
> buffer, then we can fix that specific call-site. I don't think anything
> else needs to be done.

If soundness of this code hinges on specific call site behavior, this
should be a safety requirement.

>
>> As far as I can tell, we need to read from a place unknown to the rust
>> abstract machine, and we need to be able to have the abstract machine
>> consider the data initialized after the read.
>>
>> Is this volatile memcpy [1], or would that only solve the data race
>> problem, not uninitialized data problem?
>>
>> [1] https://lore.kernel.org/all/25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de
>
> Volatile memcpy deals with data races.
>
> In general, we can argue all we want about wording of these safety
> comments, but calling copy_from_iter is the right way to read from an
> iov_iter. If there is a problem, the problem is specific call-sites that
> construct an iov_iter with an uninit buffer. I don't know whether such
> call-sites exist.

I am not saying it is the wrong way. I am asking that we detail in the
safety requirements _why_ it is the right way.

You have a type invariant

  For the duration of `'data`, it must be safe to read the data in this IO vector.

that says "safe to read" instead of "valid for read" because "special
assembly" is used to read the data, and that somehow makes it OK. We
should be more specific.

How about making the invariant:

  For the duration of `'data`, it must be safe to read the data in this
  IO vector with the C API `_copy_from_iter`.

And then your safety comment regarding uninit bytes can be:

  We write `out` with `copy_from_iter_raw`, which transitively writes
  `out` using `_copy_from_iter`. By C API contract, `_copy_from_iter`
  does not write uninitialized bytes to `out`.

In this way we can defer to the implementation of `_copy_from_user`,
which is what I think you want?


Best regards,
Andreas Hindborg



