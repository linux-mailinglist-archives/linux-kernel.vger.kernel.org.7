Return-Path: <linux-kernel+bounces-740582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C491B0D604
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A50188D835
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443F72DC35D;
	Tue, 22 Jul 2025 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY+NhB8D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B732557A;
	Tue, 22 Jul 2025 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176781; cv=none; b=WaJJ2+4RbNJ1dMUGsEkWuUTD+TsoMek1uZTbvjcUeGuFpSxk75ZjYbgNsrxNWd0oI/K/d5AaBM59Y78Sq+ycZO1AKeL29JEpoCfRXYMfuUDad8yZ1KKYxX5IDR3D4EaCWT/wCDwQhNuezukxZLzs4GKjtUmaE8xyI65Z3sfIeEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176781; c=relaxed/simple;
	bh=T/54e2GKIMBgth/Ma53cxRrBRLK1haj82m9epjW0LDs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=NJUXJUOdRgpvmvJqaDtlogEbrudrVcCriKxY0oYNnxDwUFH3OHMfWwyqSDlvIZ78cvox70BXFbajPtggQQmCIJ/qvZm8KSYSSv1huIqzQbZG2a3kCSwJUZmSgPZbHOBezvYojaet0qevyte7pfNUGVWa+YAXtdUgYapo4c0zKpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY+NhB8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44DDC4CEEB;
	Tue, 22 Jul 2025 09:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753176781;
	bh=T/54e2GKIMBgth/Ma53cxRrBRLK1haj82m9epjW0LDs=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=CY+NhB8DTrw9xxzsjxSCR2ADIEQxmTkF63h7rnTfySvttx6+T9BOVyAbjoxjgaK/s
	 qSK35/7eD9QdQV2Weg8jYoydjFw0GV9z3MILHQ8//p69+8HX7yJCnvNVFKi0c1rGgC
	 jLpFpvVkW/5BQOgxgQCppTvowkPlSQgJRrbTZ0XlRHoRl0s9mwv9vR6dZS3q9EDh/8
	 SBrBuewBK1tdOFStytyt28vfIjsMoAtlY3SNGlYAGCj59sxkV8pdaC1hQs1hynsGMd
	 hgCXnelGzW/wWCe4FHQ7j8pT7lfi0qXkRdfWqMZDsFX6UBcfoXuCq4QdNDqQLbiFo0
	 VyI8Ii5l++IzQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Jul 2025 11:32:56 +0200
Message-Id: <DBIHASMYLFEZ.19R61CE8V745Q@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Shankari Anand"
 <shankari.ak0208@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4] rust: move ARef and AlwaysRefCounted to sync::aref
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250715110423.334744-1-shankari.ak0208@gmail.com>
 <CANiq72nZMLghTj8bHerEfXyYMtbWDH_WVxYeQY65ymWjSuxA_g@mail.gmail.com>
In-Reply-To: <CANiq72nZMLghTj8bHerEfXyYMtbWDH_WVxYeQY65ymWjSuxA_g@mail.gmail.com>

On Tue Jul 22, 2025 at 12:46 AM CEST, Miguel Ojeda wrote:
> On Tue, Jul 15, 2025 at 1:04=E2=80=AFPM Shankari Anand
> <shankari.ak0208@gmail.com> wrote:
>>
>> +//! Built-in Reference Counting Support
>
> What is it meant by "built-in" here? Could we just use "Reference
> counting support."? Or do you have another suggestion, Benno?

`ARef` specifically is about supporting types that already have their
own "built-in" reference counting. I'm not sure if built-in is the best
word to describe that, some alternatives are inherent or internal.

Maybe we can just expand the module level docs with:

    //! Internal Reference Counting Support.
    //!
    //! Many C types already have their own reference counting mechanism (e=
.g. by storing a
    //! `refcount_t`). This module provides support for directly using thei=
r internal reference count
    //! from Rust; instead of making users have to use an additional Rust-r=
eference count in the form of
    //! [`Arc`].
    //!
    //! The smart pointer [`ARef<T>`] acts similarly to [`Arc<T>`] in that =
it holds a refcount on the
    //! underlying object, but this refcount is internal to the object. It =
essentially is a Rust
    //! implementation of the `get_` and `put_` pattern used in C for refer=
ence counting.
    //!
    //! To make use of [`ARef<MyType>`], `MyType` needs to implement [`Alwa=
ysRefCounted`]. It is a trait
    //! for accessing the internal reference count of an object of the `MyT=
ype` type.

Thoughts?

---
Cheers,
Benno

