Return-Path: <linux-kernel+bounces-723557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5360AFE871
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C93A580766
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048382D8782;
	Wed,  9 Jul 2025 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bL8U51j1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575A12C2AA5;
	Wed,  9 Jul 2025 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062208; cv=none; b=GVuzkMxNUzifbQmUrejkOlrD89SCuq2y4D5DEc8JpkW0bOJiha7E7yo0Yw7qgOUpdNhxsUB0GMGBVLh0/0D55Kly53HkxRYgR/9pNWWStkBvhsAyyl0voDGJyrEIk7W3Y3UIJZwkrV1zQmECDq4R11o2JuifL5L8N3Sx6tZ05oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062208; c=relaxed/simple;
	bh=q2Su56yH/l+hwqndapbmNWubb3102oNRjJGNKporqno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pycUSZVFTsC1f2gl65KDqpNMNHsFHjVsh4oqwGcSkdhKDtUuN6W0yXSzyEx9o2IP7LAsRRZS+kRwhBNmBK0ou9qdezVlfeThAolAQa7KAA54TbZrImbV/Bm6to06K46uhjgHOBAaO577wPxDB0ATWjyw4CegmD/VJgivIjCkQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bL8U51j1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7698C4CEEF;
	Wed,  9 Jul 2025 11:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752062207;
	bh=q2Su56yH/l+hwqndapbmNWubb3102oNRjJGNKporqno=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bL8U51j1eucp0DJTCFh0LCSGMDZ37S9+6o1RcAYc6WUv5MNWvQwc4ZCpmp6+YQXWK
	 j4ReuvUYeGNt2EOvIZxCPVKQz5A6wgocFyJa5SutJFKdCO/7baWX0JnN+w9kujk0jJ
	 maNiM6r+M2mnLqj8jG5ci4L+W+EG+P3bRaJ8BiDOv/6c2rUTPpATrjdmvwWdXhIKYj
	 RxZTVNBYmeUkdx6bGRzPzqDSMA3+o58Xaqokfwu2tcyFrbBaFLihNJtoF55kzx6ncK
	 aNKYPOhCgLpTR6ZD1jDnQK96HvNXP2d1BPnkHPZHlh7P5LiSezfL2Z/elmtUVZ2GvS
	 ipB/xlIZJPaqA==
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
In-Reply-To: <aG5NdqmUdvUHqUju@google.com> (Alice Ryhl's message of "Wed, 09
	Jul 2025 11:07:34 +0000")
References: <20250704-iov-iter-v2-0-e69aa7c1f40e@google.com>
	<U16UjMBBh1b7dLeO-Nhqw__nw_JwypctB1ze_G44BtsX0l_eVK6Sp-efbobmnuF44J0wQNgnK7b8nCmBX0KS_Q==@protonmail.internalid>
	<20250704-iov-iter-v2-1-e69aa7c1f40e@google.com>
 <878qkyoi6d.fsf@kernel.org>
	<0Y9Bjahrc6dbxzIFtBKXUxv-jQtuvM2UWShaaSUsjKBuC1KKeGIpBFTC4a89oNrOLBP66SXtC7kQx1gtt04CMg==@protonmail.internalid>
	<aG5NdqmUdvUHqUju@google.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 09 Jul 2025 13:56:37 +0200
Message-ID: <87ecuplgqy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Tue, Jul 08, 2025 at 04:45:14PM +0200, Andreas Hindborg wrote:
>> "Alice Ryhl" <aliceryhl@google.com> writes:
>> > +/// # Invariants
>> > +///
>> > +/// Must hold a valid `struct iov_iter` with `data_source` set to `ITER_SOURCE`. For the duration
>> > +/// of `'data`, it must be safe to read the data in this IO vector.
>>
>> In my opinion, the phrasing you had in v1 was better:
>>
>>   The buffers referenced by the IO vector must be valid for reading for
>>   the duration of `'data`.
>>
>> That is, I would prefer "must be valid for reading" over "it must be
>> safe to read ...".
>
> If it's backed by userspace data, then technically there aren't any
> buffers that are valid for reading in the usual sense. We need to call
> into special assembly to read it, and a normal pointer dereference would
> be illegal.

If you go with "safe to read" for this reason, I think you should expand
the statement along the lines you used here.

What is the special assembly that is used to read this data? From a
quick scan it looks like that if `CONFIG_UACCESS_MEMCPY` is enabled, a
regular `memcpy` call is used.

>
>> > +    /// Returns the number of bytes available in this IO vector.
>> > +    ///
>> > +    /// Note that this may overestimate the number of bytes. For example, reading from userspace
>> > +    /// memory could fail with `EFAULT`, which will be treated as the end of the IO vector.
>> > +    #[inline]
>> > +    pub fn len(&self) -> usize {
>> > +        // SAFETY: It is safe to access the `count` field.
>>
>> Reiterating my comment from v1: Why?
>
> It's the same reason as why this is safe:
>
> struct HasLength {
>     length: usize,
> }
> impl HasLength {
>     fn len(&self) -> usize {
>         // why is this safe?
>         self.length
>     }
> }
>
> I'm not sure how to say it concisely. I guess it's because all access to
> the iov_iter goes through the &IovIterSource.

So "By existence of a shared reference to `self`, `count` is valid for read."?

>
>> > +        unsafe {
>> > +            (*self.iov.get())
>> > +                .__bindgen_anon_1
>> > +                .__bindgen_anon_1
>> > +                .as_ref()
>> > +                .count
>> > +        }
>> > +    }
>> > +
>> > +    /// Returns whether there are any bytes left in this IO vector.
>> > +    ///
>> > +    /// This may return `true` even if there are no more bytes available. For example, reading from
>> > +    /// userspace memory could fail with `EFAULT`, which will be treated as the end of the IO vector.
>> > +    #[inline]
>> > +    pub fn is_empty(&self) -> bool {
>> > +        self.len() == 0
>> > +    }
>> > +
>> > +    /// Advance this IO vector by `bytes` bytes.
>> > +    ///
>> > +    /// If `bytes` is larger than the size of this IO vector, it is advanced to the end.
>> > +    #[inline]
>> > +    pub fn advance(&mut self, bytes: usize) {
>> > +        // SAFETY: `self.iov` is a valid IO vector.
>> > +        unsafe { bindings::iov_iter_advance(self.as_raw(), bytes) };
>> > +    }
>> > +
>> > +    /// Advance this IO vector backwards by `bytes` bytes.
>> > +    ///
>> > +    /// # Safety
>> > +    ///
>> > +    /// The IO vector must not be reverted to before its beginning.
>> > +    #[inline]
>> > +    pub unsafe fn revert(&mut self, bytes: usize) {
>> > +        // SAFETY: `self.iov` is a valid IO vector, and `bytes` is in bounds.
>> > +        unsafe { bindings::iov_iter_revert(self.as_raw(), bytes) };
>> > +    }
>> > +
>> > +    /// Read data from this IO vector.
>> > +    ///
>> > +    /// Returns the number of bytes that have been copied.
>> > +    #[inline]
>> > +    pub fn copy_from_iter(&mut self, out: &mut [u8]) -> usize {
>> > +        // SAFETY: We will not write uninitialized bytes to `out`.
>>
>> Can you provide something to back this claim?
>
> I guess the logic could go along these lines:
>
> * If the iov_iter reads from userspace, then it's because we always
>   consider such reads to produce initialized data.

I don't think it is enough to just state that we consider the reads to
produce initialized data.

> * If the iov_iter reads from a kernel buffer, then the creator of the
>   iov_iter must provide an initialized buffer.
>
> Ultimately, if we don't know that the bytes are initialized, then it's
> impossible to use the API correctly because you can never inspect the
> bytes in any way. I.e., any implementation of copy_from_iter that
> produces uninit data is necessarily buggy.

I would agree. How do we fix that? You are more knowledgeable than me in
this field, so you probably have a better shot than me, at finding a
solution.

As far as I can tell, we need to read from a place unknown to the rust
abstract machine, and we need to be able to have the abstract machine
consider the data initialized after the read.

Is this volatile memcpy [1], or would that only solve the data race
problem, not uninitialized data problem?


Best regards,
Andreas Hindborg

[1] https://lore.kernel.org/all/25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de


