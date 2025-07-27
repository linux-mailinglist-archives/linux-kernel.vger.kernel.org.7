Return-Path: <linux-kernel+bounces-747087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E03B12F81
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 14:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2556188989C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 12:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F09212B2F;
	Sun, 27 Jul 2025 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rv5+0JLf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF11C8604;
	Sun, 27 Jul 2025 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753619984; cv=none; b=nqJmtakez7rphHp2DZLhqWG8BBNfaqinFF33G+xypd3m3qlvtFQrPf+sa261hM7t7i1f5FYohiGvX8/Kt+bKya5KsEWx0PfBQpATv41thlZ+SMN/HvFMOpCH8YnvHeDYyHdZ+5a39BNm+EwKujAzWYjvEDnI3nazeq67QQgreyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753619984; c=relaxed/simple;
	bh=fIXQgL9YEiRqNQxiYSID7ZjBcy7GeSQhzu+5YaUrg7k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=oprDB4CGhlZqVcAdWLOfYc10ea6M/SOHI6nTn18AnMu5s6ubL5e4zNVCt5ycRhAfhmX2nW+TLpUdQLzIi+ye/ZBj+rl1JRZ/NZuS7y0YEckyH2HbsmV9HLO/kfv1OexdT5YpbY7OfSXTzKZEnDOXhWKEHlk3barYOxbYPExxTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rv5+0JLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F47AC4CEEB;
	Sun, 27 Jul 2025 12:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753619984;
	bh=fIXQgL9YEiRqNQxiYSID7ZjBcy7GeSQhzu+5YaUrg7k=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=rv5+0JLf03BsZyyLJ4SqD+8fQmTbff6WjrWDLgui+5tTMtEUh1+ZAO4E6B5O5QEl7
	 InAR8jpKa/1vowj+PtEBGZTTYRBnhNiUubAAlbmlsBqQrOvXxwlNHVLVMxZqsfpeg3
	 /pZKe3ssPKCGJH9cZNnHtbmkSxIFrD79/vtK99lUAL/J/qYfXl9RlgR4i1sTNaLhfN
	 u1wV97EdaiAYKgoE/11lgpl+xH9OvwWW2PcNfIGLtlrePtA4QqjUpFfijIhjCm68fp
	 1eyNY2v7HcDAE608nli7ceE3hUkTObOGpeK8LFhWorPZk83xtUT2l7rk90JgC71tGf
	 DamYTvpVaB9hg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Jul 2025 14:39:39 +0200
Message-Id: <DBMUEH5MYR2L.CXM12OIUH7TZ@kernel.org>
Subject: Re: [PATCH v3] rust: transmute: add `as_bytes` method for `AsBytes`
 trait
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
Cc: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Robin
 Murphy" <robin.murphy@arm.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Christian S. Lima" <christiansantoslima21@gmail.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250726-as_bytes-v3-1-eb7514faab28@nvidia.com>
 <CAH5fLghNDDo0HKupPXe8G6z2TP4TJE881Bd76k0LDjSm75KcEQ@mail.gmail.com>
 <aIX-JDehurnGYppE@google.com>
In-Reply-To: <aIX-JDehurnGYppE@google.com>

On Sun Jul 27, 2025 at 12:23 PM CEST, Alice Ryhl wrote:
> On Sun, Jul 27, 2025 at 08:52:00AM +0200, Alice Ryhl wrote:
>> On Sat, Jul 26, 2025 at 4:47=E2=80=AFAM Alexandre Courbot <acourbot@nvid=
ia.com> wrote:
>> > diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
>> > index 1c7d43771a37b90150de86699f114a2ffb84db91..69c46c19a89191d8a2abc5=
801564cacda232218c 100644
>> > --- a/rust/kernel/transmute.rs
>> > +++ b/rust/kernel/transmute.rs
>> > @@ -47,7 +47,16 @@ macro_rules! impl_frombytes {
>> >  ///
>> >  /// Values of this type may not contain any uninitialized bytes. This=
 type must not have interior
>> >  /// mutability.
>> > -pub unsafe trait AsBytes {}
>> > +pub unsafe trait AsBytes {
>> > +    /// Returns `self` as a slice of bytes.
>> > +    fn as_bytes(&self) -> &[u8] {
>> > +        let data =3D core::ptr::from_ref(self).cast::<u8>();
>> > +        let len =3D size_of_val(self);
>> > +
>> > +        // SAFETY: `data` is non-null and valid for `len * sizeof::<u=
8>()` bytes.
>> > +        unsafe { core::slice::from_raw_parts(data, len) }
>> > +    }
>> > +}
>>=20
>> Let's also have an as_bytes_mut() method. I would require the type to
>> also implement FromBytes as it lets you replace the value with another
>> set of bytes.
>
> s/I would/It would/
>
> FromBytes is needed only for as_bytes_mut(), not for the existing
> method.

I agree with your suggestion, but it can be an independent patch and
doesn't need to go in via this one, right?

---
Cheers,
Benno

