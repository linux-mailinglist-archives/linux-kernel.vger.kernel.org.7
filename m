Return-Path: <linux-kernel+bounces-723613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 511D9AFE917
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962AA7B8B6F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368E02D320E;
	Wed,  9 Jul 2025 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJawIXL5"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C0828A71D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064562; cv=none; b=nakBLQ+T78OUrpt/ac3KZuXonaGXRdXOQdTgAB+ZlT8/dYtioUFM7bkxX6ioiqCY8stVqrgtszd98wQ+Oe/qRYtwDYfrhh8JraLzLJxHpcIgY3mFllMlP5B8AuiywG+uXSdv/+zkgh0yLsEWL0dwUA01nFg1Ec95T+76rNC9yKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064562; c=relaxed/simple;
	bh=wd/qNz7WyhKf3bMX6G1qHHU6RUMyYpRH/AnK/WBT+CA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L0XTtFsXRGfopkuI9YULjbUGU18XimI55PWuCEbGaaDRv3YgzhIHgOTlnMzfrjcN90G2h/SHYFMeb4b3lUFMUiy9lUBW3TBJclKlxediZr+D1ySZ405AcV3S6EJbG43PEp+QnGM8lWqjz+kUpIWfkzRf8gbeUBJmcdYz2/h6ykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJawIXL5; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso3784082f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 05:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752064559; x=1752669359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PzMQHSy9JLo2QGlJbPTZapiM88FLqMBKfBHKtJNkziE=;
        b=iJawIXL5eL8EmjCw2sX4Aizqi8/9LP/cj2GNwkh6dhbWpy/6oN5zKVpj4ChRGxTgFO
         bUKADbIR+Zq2nYnJt+LMG/tR0L05rdussEFd26ib0y9SQz+jLXJEfwq10pQjUNThoEJ8
         r0rnbldGIqGuwcPa5g/LLJx3XZ8+OYAFW0kxMPR1Kcgusa3GH5B/BFmsv7Zhy9Ipy1NZ
         zRnoHiHtwwJM/WFn0Xsl0voTrM31+LAKm7SO8947GLaWBiGa2wc5AQ8xCYGNUQvtu6g/
         S+asP1aLtoPKXTowWg9p0Vx96fEVqaiR+MIsp+qsKnKETCOVHHAtze9aUicKbC5bW988
         SZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752064559; x=1752669359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzMQHSy9JLo2QGlJbPTZapiM88FLqMBKfBHKtJNkziE=;
        b=lCEMW2hcxrZlLJt8hHM5p4zVLn8RbJ6FU7y27CsQZyjaN+MW3uqH3jXXBz9zvCkhoW
         vy2XlIo4iFnZ4zX4kTc8OQOM0DGlpdjWqbRpopuNGFFZkqHYnjYRFpTINnE6Hz7dU9tH
         fW942OUN8qMC6tjfF/P9md7dXuYa2tD2opD0AacyoxtEXUHWDjBsyVIYtOB2mxkf7Gqs
         gjJohelvCtL9vPbkbZTpxwwEiEePdN0Dmc3Xh4SRcJJduylmiP8QfbJJkl86oIiL+Suw
         6Oe6pzMRO9MaBYmKlsqWiGNwAadXBIkQQAr7TcNwx7R1RWEwAva66FietrFw7t5LCkrE
         F9TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq3I7rWnoPs5ZL5MnV6g3pvKBlWpJfmVuTRwu0BScZhgk5/d6yms4fS6ccAE2GGyrPkEXdt1nAK/d/+pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVIwqRjggOcmuQsBP6G6kuokHMFLUt2DIBV/F2vmu05s5Ppayg
	iq0vstSdISGhGsENKB0bvLHm7jmTRzggc7fnCxZSeL7gkRuP85XuT76doJUg8B4NVeu/Mi7+YvX
	G9TIdfPQNK+feqk/Dug==
X-Google-Smtp-Source: AGHT+IF7QHhjUXjHwJksOrL/orpdHi4Kes3SJuAJrzIJBlL3WdIgqqtU+4Lgj0bT7jgo2Q+FCveakmLmMeOH064=
X-Received: from wmbes22.prod.google.com ([2002:a05:600c:8116:b0:453:8a72:e19e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:588c:0:b0:3a4:d6ed:8e00 with SMTP id ffacd0b85a97d-3b5e4537e82mr1931665f8f.33.1752064558922;
 Wed, 09 Jul 2025 05:35:58 -0700 (PDT)
Date: Wed, 9 Jul 2025 12:35:58 +0000
In-Reply-To: <87ecuplgqy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250704-iov-iter-v2-0-e69aa7c1f40e@google.com>
 <U16UjMBBh1b7dLeO-Nhqw__nw_JwypctB1ze_G44BtsX0l_eVK6Sp-efbobmnuF44J0wQNgnK7b8nCmBX0KS_Q==@protonmail.internalid>
 <20250704-iov-iter-v2-1-e69aa7c1f40e@google.com> <878qkyoi6d.fsf@kernel.org>
 <0Y9Bjahrc6dbxzIFtBKXUxv-jQtuvM2UWShaaSUsjKBuC1KKeGIpBFTC4a89oNrOLBP66SXtC7kQx1gtt04CMg==@protonmail.internalid>
 <aG5NdqmUdvUHqUju@google.com> <87ecuplgqy.fsf@kernel.org>
Message-ID: <aG5iLiUJg_cHtB8r@google.com>
Subject: Re: [PATCH v2 1/4] rust: iov: add iov_iter abstractions for ITER_SOURCE
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Wed, Jul 09, 2025 at 01:56:37PM +0200, Andreas Hindborg wrote:
> "Alice Ryhl" <aliceryhl@google.com> writes:
> 
> > On Tue, Jul 08, 2025 at 04:45:14PM +0200, Andreas Hindborg wrote:
> >> "Alice Ryhl" <aliceryhl@google.com> writes:
> >> > +/// # Invariants
> >> > +///
> >> > +/// Must hold a valid `struct iov_iter` with `data_source` set to `ITER_SOURCE`. For the duration
> >> > +/// of `'data`, it must be safe to read the data in this IO vector.
> >>
> >> In my opinion, the phrasing you had in v1 was better:
> >>
> >>   The buffers referenced by the IO vector must be valid for reading for
> >>   the duration of `'data`.
> >>
> >> That is, I would prefer "must be valid for reading" over "it must be
> >> safe to read ...".
> >
> > If it's backed by userspace data, then technically there aren't any
> > buffers that are valid for reading in the usual sense. We need to call
> > into special assembly to read it, and a normal pointer dereference would
> > be illegal.
> 
> If you go with "safe to read" for this reason, I think you should expand
> the statement along the lines you used here.
> 
> What is the special assembly that is used to read this data? From a
> quick scan it looks like that if `CONFIG_UACCESS_MEMCPY` is enabled, a
> regular `memcpy` call is used.

When reading from userspace, you're given an arbitrary untrusted address
that could point anywhere. The memory could be swapped out and need to
be loaded back from disk. The memory could correspond to an mmap region
for a file on a NFS mount and reading it could involve a network call.
The address could be dangling, which must be properly handled and turned
into an EFAULT error instead of UB. Every architecture has its own asm
for handling all of this safely so that behavior is safe no matter what
pointer we are given from userspace.

As for CONFIG_UACCESS_MEMCPY, I don't think it is used on any real
system today. It would require you to be on a NOMMU system where the
userspace and the kernel are in the same address space.

> >> > +    /// Returns the number of bytes available in this IO vector.
> >> > +    ///
> >> > +    /// Note that this may overestimate the number of bytes. For example, reading from userspace
> >> > +    /// memory could fail with `EFAULT`, which will be treated as the end of the IO vector.
> >> > +    #[inline]
> >> > +    pub fn len(&self) -> usize {
> >> > +        // SAFETY: It is safe to access the `count` field.
> >>
> >> Reiterating my comment from v1: Why?
> >
> > It's the same reason as why this is safe:
> >
> > struct HasLength {
> >     length: usize,
> > }
> > impl HasLength {
> >     fn len(&self) -> usize {
> >         // why is this safe?
> >         self.length
> >     }
> > }
> >
> > I'm not sure how to say it concisely. I guess it's because all access to
> > the iov_iter goes through the &IovIterSource.
> 
> So "By existence of a shared reference to `self`, `count` is valid for read."?
> 
> >
> >> > +        unsafe {
> >> > +            (*self.iov.get())
> >> > +                .__bindgen_anon_1
> >> > +                .__bindgen_anon_1
> >> > +                .as_ref()
> >> > +                .count
> >> > +        }
> >> > +    }
> >> > +
> >> > +    /// Returns whether there are any bytes left in this IO vector.
> >> > +    ///
> >> > +    /// This may return `true` even if there are no more bytes available. For example, reading from
> >> > +    /// userspace memory could fail with `EFAULT`, which will be treated as the end of the IO vector.
> >> > +    #[inline]
> >> > +    pub fn is_empty(&self) -> bool {
> >> > +        self.len() == 0
> >> > +    }
> >> > +
> >> > +    /// Advance this IO vector by `bytes` bytes.
> >> > +    ///
> >> > +    /// If `bytes` is larger than the size of this IO vector, it is advanced to the end.
> >> > +    #[inline]
> >> > +    pub fn advance(&mut self, bytes: usize) {
> >> > +        // SAFETY: `self.iov` is a valid IO vector.
> >> > +        unsafe { bindings::iov_iter_advance(self.as_raw(), bytes) };
> >> > +    }
> >> > +
> >> > +    /// Advance this IO vector backwards by `bytes` bytes.
> >> > +    ///
> >> > +    /// # Safety
> >> > +    ///
> >> > +    /// The IO vector must not be reverted to before its beginning.
> >> > +    #[inline]
> >> > +    pub unsafe fn revert(&mut self, bytes: usize) {
> >> > +        // SAFETY: `self.iov` is a valid IO vector, and `bytes` is in bounds.
> >> > +        unsafe { bindings::iov_iter_revert(self.as_raw(), bytes) };
> >> > +    }
> >> > +
> >> > +    /// Read data from this IO vector.
> >> > +    ///
> >> > +    /// Returns the number of bytes that have been copied.
> >> > +    #[inline]
> >> > +    pub fn copy_from_iter(&mut self, out: &mut [u8]) -> usize {
> >> > +        // SAFETY: We will not write uninitialized bytes to `out`.
> >>
> >> Can you provide something to back this claim?
> >
> > I guess the logic could go along these lines:
> >
> > * If the iov_iter reads from userspace, then it's because we always
> >   consider such reads to produce initialized data.
> 
> I don't think it is enough to just state that we consider the reads to
> produce initialized data.

See above re userspace.

> > * If the iov_iter reads from a kernel buffer, then the creator of the
> >   iov_iter must provide an initialized buffer.
> >
> > Ultimately, if we don't know that the bytes are initialized, then it's
> > impossible to use the API correctly because you can never inspect the
> > bytes in any way. I.e., any implementation of copy_from_iter that
> > produces uninit data is necessarily buggy.
> 
> I would agree. How do we fix that? You are more knowledgeable than me in
> this field, so you probably have a better shot than me, at finding a
> solution.

I think there is nothing to fix. If there exists a callsite on the C
side that creates an iov_iter that reads from an uninitialized kernel
buffer, then we can fix that specific call-site. I don't think anything
else needs to be done.

> As far as I can tell, we need to read from a place unknown to the rust
> abstract machine, and we need to be able to have the abstract machine
> consider the data initialized after the read.
> 
> Is this volatile memcpy [1], or would that only solve the data race
> problem, not uninitialized data problem?
> 
> [1] https://lore.kernel.org/all/25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de

Volatile memcpy deals with data races.

In general, we can argue all we want about wording of these safety
comments, but calling copy_from_iter is the right way to read from an
iov_iter. If there is a problem, the problem is specific call-sites that
construct an iov_iter with an uninit buffer. I don't know whether such
call-sites exist.

Alice

