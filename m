Return-Path: <linux-kernel+bounces-729974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 666F5B03E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E68164DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9083980B;
	Mon, 14 Jul 2025 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBxjEI8s"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E506F1E9B21
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495486; cv=none; b=CxCq2oAXavCuHU7mPAZYlQDGnRpOINIsOXLEK5OyU+s8btff9nuCskOSlrBXOIhBbL2WDLnsbAqX5w7dHABUonz7eukQvAcSo1VZAVsW2Jg1/IBURdwqzkvkYJg+6iOPdEoifwaxJex5/v4gkBPXOQOd1LGUyKBJbV3dRrqFpMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495486; c=relaxed/simple;
	bh=jBIoviL7c6qON5XngvxGUEMK1KwwBLhlT+iDvFuQWk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RGmoYk2qq+lPQtieLH57bYN5+CKhAFEdtOo5Ci5GKA1cqvbkdR+0YPRQQqQwzUBt1ef7Nt93x6MMzHmdB5IcPNUlPEbhVjPFziTpdJxp9CxqVEyD8+YIHh0c4z9g82BRO+yFil7nOSZjV174bhuQfW1Vug8qfvV4/btHKXD0MOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBxjEI8s; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4560f28b2b1so5217665e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752495483; x=1753100283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hhrbngdtwLIZhz0yqQlqhovMpCwE60clz8fRz49E1Kw=;
        b=cBxjEI8sheP1y3qYdH+5RullYK+KoBxGhdjTs1XfHbCaO7Inma/sQFrWd20I/r5Eqy
         8+OmSxHwPOVSsaOn+hDDH17vzoWPSsxglgQEhPR0jzPWHsRFugLKaV/zkGqtepqHelg5
         8E2D/gtGsacO+DSi+6QTlCajixwosFiXjr0CA3mnpN3Msy7hkEvs99vdHo6YbG+Enwaz
         +GdE4jsYnPjVKb2nfPv5tocl8pFWP4YhXdktxabM+00CUoBj7dv6w7/ahN+BTWO6DUmO
         gkycZKUGJJ18v0/amZt58h1/FWB4bS5Sta6CAUyREeGsjuxl3qGc7ArYzUgr/Q7BEIYD
         0swQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752495483; x=1753100283;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhrbngdtwLIZhz0yqQlqhovMpCwE60clz8fRz49E1Kw=;
        b=TcOmW5WchRvwQcQCwU1TFY0fr1Cu3HvtP5ejHqTI9Z+A4T8bKNBWFhx8i/cK0mOGw1
         4lcBlWOm9XdbYh4/ThiYkKwHqFNXrlX8jMvx+Ou1TM2BCk+ldcR7RXpx3XOKL4kkKAeQ
         Sac3VJPL9eQbe7P9GQYjx81PFvcQMQnEmLtJ8qdzS7tEyAHNL3bl0jgmyACj/cr5Z3jE
         FiC4QO3/k0QruR51U0tWCX6CRXk55zsYh5EmPBPS713CmHdjzac9sP0Wvy2hMtuA1n9E
         w8SrLGoRSyZbs1M4/fjRrVhy7k4QZDbXyY/3nwc3K/N2VNAMXlI9+11KMvSmUVa1NwwW
         viWw==
X-Forwarded-Encrypted: i=1; AJvYcCXAraVq52qauvW7JR1t0D//GGe55Wc7ziPHcSk5iNLTQlVzKqoGMEAOTIbHg5d+HeH8dzUG1iyP4N9L4G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkpEEu+a9MB/V4S1A/kcYzIl4UpiNvKINvMY0qJazyLMX+N90T
	6fZCmPe5NnCrduODKuJZkmiw1Zy4HWp9K7rKwH/cLvupVsyUchfR34Xa1sJNUWMKUABdiAFr/x9
	ngGaNqVm9X+14JjdtCA==
X-Google-Smtp-Source: AGHT+IGuBf6UyD8vga60JCe+ASIW8IX5XzxF/f4ca+3Bx6VIwy7Y5Y4ucTQmymQ87F8Fh/x5SOphse9Y58mi4LI=
X-Received: from wmbhh14.prod.google.com ([2002:a05:600c:530e:b0:456:1518:6d6e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2f87:b0:3a4:edf5:b942 with SMTP id ffacd0b85a97d-3b5f359b131mr10006200f8f.57.1752495483047;
 Mon, 14 Jul 2025 05:18:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 12:18:02 +0000
In-Reply-To: <87ikk1jnwi.fsf@kernel.org>
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
 <aG5NdqmUdvUHqUju@google.com> <87ecuplgqy.fsf@kernel.org> <q7QRbcFgb5yhmBOt4eLkkzqyckspc2L2g3e0pXhJxm0yBVeG2Hifi4O77gaxwpWss1Z_CUjSy1P22ppxcxo8jw==@protonmail.internalid>
 <aG5iLiUJg_cHtB8r@google.com> <87ikk1jnwi.fsf@kernel.org>
Message-ID: <aHT1etvG0R648EB9@google.com>
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

On Wed, Jul 09, 2025 at 07:05:01PM +0200, Andreas Hindborg wrote:
> "Alice Ryhl" <aliceryhl@google.com> writes:
> 
> > On Wed, Jul 09, 2025 at 01:56:37PM +0200, Andreas Hindborg wrote:
> >> "Alice Ryhl" <aliceryhl@google.com> writes:
> >>
> >> > On Tue, Jul 08, 2025 at 04:45:14PM +0200, Andreas Hindborg wrote:
> >> >> "Alice Ryhl" <aliceryhl@google.com> writes:
> >> >> > +/// # Invariants
> >> >> > +///
> >> >> > +/// Must hold a valid `struct iov_iter` with `data_source` set to `ITER_SOURCE`. For the duration
> >> >> > +/// of `'data`, it must be safe to read the data in this IO vector.
> >> >>
> >> >> In my opinion, the phrasing you had in v1 was better:
> >> >>
> >> >>   The buffers referenced by the IO vector must be valid for reading for
> >> >>   the duration of `'data`.
> >> >>
> >> >> That is, I would prefer "must be valid for reading" over "it must be
> >> >> safe to read ...".
> >> >
> >> > If it's backed by userspace data, then technically there aren't any
> >> > buffers that are valid for reading in the usual sense. We need to call
> >> > into special assembly to read it, and a normal pointer dereference would
> >> > be illegal.
> >>
> >> If you go with "safe to read" for this reason, I think you should expand
> >> the statement along the lines you used here.
> >>
> >> What is the special assembly that is used to read this data? From a
> >> quick scan it looks like that if `CONFIG_UACCESS_MEMCPY` is enabled, a
> >> regular `memcpy` call is used.
> >
> > When reading from userspace, you're given an arbitrary untrusted address
> > that could point anywhere. The memory could be swapped out and need to
> > be loaded back from disk. The memory could correspond to an mmap region
> > for a file on a NFS mount and reading it could involve a network call.
> > The address could be dangling, which must be properly handled and turned
> > into an EFAULT error instead of UB. Every architecture has its own asm
> > for handling all of this safely so that behavior is safe no matter what
> > pointer we are given from userspace.
> 
> I don't think that is relevant. My point is, you can't reference
> "special assemby" without detailing what that means.
> 
> You have a safety requirement in `from_raw`:
> 
>     /// * For the duration of `'data`, the buffers backing this IO vector must be valid for
>     ///   reading.
> 
> This should probably be promoted to invariant for the type, since
> `from_raw` is the only way to construct the type?

Sure, let's get the wording consistent, but that was the purpose of this
line in the invariants:

For the duration of `'data`, it must be safe to read the data in this IO vector.

> But are you saying that the referenced buffers need not be mapped and
> readable while this type exists? The mapping happens as part of
> `bindings::_copy_to_iter`?

Ultimately, it's an implementation detail.

In our "# Invariants" section, we tend to "expand" the underlying C
types and describe exactly what it means for that C type to be valid,
even if those details are implementation details that nobody outside
that C file should think about. Usually that's fine, but in this case,
I don't think it is feasible.

The iov_iter type is like a giant enum with a bunch of different
implementations. Some implementations just read from a simple kernel
buffer that must, of course, be mapped. Some implementations traverse
complex data structures and stitch the data together from multiple
buffers. Other implementations map the data into memory on-demand inside
the copy_from_iter call, without requiring it to be mapped at other
times. And finally, some implementations perform IO by reading from
userspace, in which case it's valid for the userspace pointer to be
*literally any 64-bit integer*. If the address is dangling, that's
caught inside the call to copy_from_iter and is not a safety issue.

I just want the type invariant to say that reading from it is valid, as
long as the read happens before a certain lifetime expires, without
elaborating on precisely what that means.

> >> > * If the iov_iter reads from a kernel buffer, then the creator of the
> >> >   iov_iter must provide an initialized buffer.
> >> >
> >> > Ultimately, if we don't know that the bytes are initialized, then it's
> >> > impossible to use the API correctly because you can never inspect the
> >> > bytes in any way. I.e., any implementation of copy_from_iter that
> >> > produces uninit data is necessarily buggy.
> >>
> >> I would agree. How do we fix that? You are more knowledgeable than me in
> >> this field, so you probably have a better shot than me, at finding a
> >> solution.
> >
> > I think there is nothing to fix. If there exists a callsite on the C
> > side that creates an iov_iter that reads from an uninitialized kernel
> > buffer, then we can fix that specific call-site. I don't think anything
> > else needs to be done.
> 
> If soundness of this code hinges on specific call site behavior, this
> should be a safety requirement.

Yes, when we add Rust constructors for this type, they will need
appropriate soundness checks or safety requirements to verify that the
provided buffer is valid for the chosen iter_type.

For now, it is constructed in C and we usually don't have safety
comments in C code.

> >> As far as I can tell, we need to read from a place unknown to the rust
> >> abstract machine, and we need to be able to have the abstract machine
> >> consider the data initialized after the read.
> >>
> >> Is this volatile memcpy [1], or would that only solve the data race
> >> problem, not uninitialized data problem?
> >>
> >> [1] https://lore.kernel.org/all/25e7e425-ae72-4370-ae95-958882a07df9@ralfj.de
> >
> > Volatile memcpy deals with data races.
> >
> > In general, we can argue all we want about wording of these safety
> > comments, but calling copy_from_iter is the right way to read from an
> > iov_iter. If there is a problem, the problem is specific call-sites that
> > construct an iov_iter with an uninit buffer. I don't know whether such
> > call-sites exist.
> 
> I am not saying it is the wrong way. I am asking that we detail in the
> safety requirements _why_ it is the right way.
> 
> You have a type invariant
> 
>   For the duration of `'data`, it must be safe to read the data in this IO vector.
> 
> that says "safe to read" instead of "valid for read" because "special
> assembly" is used to read the data, and that somehow makes it OK. We
> should be more specific.
> 
> How about making the invariant:
> 
>   For the duration of `'data`, it must be safe to read the data in this
>   IO vector with the C API `_copy_from_iter`.
> 
> And then your safety comment regarding uninit bytes can be:
> 
>   We write `out` with `copy_from_iter_raw`, which transitively writes
>   `out` using `_copy_from_iter`. By C API contract, `_copy_from_iter`
>   does not write uninitialized bytes to `out`.
> 
> In this way we can defer to the implementation of `_copy_from_user`,
> which is what I think you want?

Yes, this is pretty much what I want except that _copy_from_user isn't
the only C function you could call to read from an iov_iter.

Alice

