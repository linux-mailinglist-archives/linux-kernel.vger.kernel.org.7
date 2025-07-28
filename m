Return-Path: <linux-kernel+bounces-748301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9B7B13F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327CA16344F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FCF272803;
	Mon, 28 Jul 2025 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKbEYdnH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02093212B2F;
	Mon, 28 Jul 2025 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717927; cv=none; b=enScryr56ioSJr0Ppari6HbkT1DL+PmLz9rxThO2H0ZBL4h58OshmE+/JjkvoO/w7HYZyB/04KNMA1u7UW0DBGKLZubuTlgca6XOpuGR6zv4wjUgZ0cVQq7N3mL9Gteo4BXkY7sIudB6TioDowGy+ZO2IBLIxLZp6ihAzQe/r70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717927; c=relaxed/simple;
	bh=s6HrPwef56eWy/MaihhJyCe7Yq5GuwY+EBfzE5EXnzM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=gA2s67bbp0/4PDZxNyPaujQC4hg11vGx+7YkgT4kqyeD7QLZ5a+2wAFPKYJet/DdVBSIWw/C39OgQKi6GRHDRT98/37WXsjXdJyvP6OCmNhJXveaoTnXR9p/tKNLKn4joiEr9U3WBiRy72bDyFfLpdPyyrEBZCYPbtIHv7TYs3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKbEYdnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81309C4CEE7;
	Mon, 28 Jul 2025 15:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753717926;
	bh=s6HrPwef56eWy/MaihhJyCe7Yq5GuwY+EBfzE5EXnzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fKbEYdnHHhduOoc0zwunYDhV6BIox7Ay4Mr9eLdLGu/Jco43etJpIV8s/thGro9JR
	 hvSGdixdb+iPT3NuVpdS/60ejQvazzhkFgd7wk8WnfnWet0V+60M/hpodsRp6i3mRC
	 uVfgtWiirnK7ge/Rbn9DOwidAaJRdaH8tzunyLCDJUnzlXdMfeQdd/E8xRnX7RGBUr
	 7zcE9OoahOO7NnTE50ET1eL8AJk6gkRhwQVpVdXFxd82CS7xR+dY3bG9pUdvvxg+2X
	 tXZCGYqYuHajjJIWXKolmgeUblaKYqc/b07yJ/ndmODBOqLaKKlt8+tljWpE0JxQyR
	 9LnPAHTUBtBLQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jul 2025 17:52:01 +0200
Message-Id: <DBNT4B4LANGR.29PBM3597ZQBR@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Christian S. Lima"
 <christiansantoslima21@gmail.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] rust: transmute: add `as_bytes_mut` method to
 `AsBytes` trait
X-Mailer: aerc 0.20.1
References: <20250728-as_bytes-v4-0-b9156af37e33@nvidia.com>
 <20250728-as_bytes-v4-2-b9156af37e33@nvidia.com>
 <DBNRVIEXN4ZR.1VG0GDN6BDXE8@kernel.org> <aIeQPrGSa2rwckiH@tardis-2.local>
In-Reply-To: <aIeQPrGSa2rwckiH@tardis-2.local>

On Mon Jul 28, 2025 at 4:59 PM CEST, Boqun Feng wrote:
> On Mon, Jul 28, 2025 at 04:53:31PM +0200, Benno Lossin wrote:
>> On Mon Jul 28, 2025 at 2:47 PM CEST, Alexandre Courbot wrote:
>> > diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
>> > index d541c9960904d8c7f755351f22d06e4e8dbd546a..000fda2a78f8e6e8378bbe=
93cddd8a5008db20cc 100644
>> > --- a/rust/kernel/transmute.rs
>> > +++ b/rust/kernel/transmute.rs
>> > @@ -56,6 +56,19 @@ fn as_bytes(&self) -> &[u8] {
>> >          // SAFETY: `data` is non-null and valid for reads over `len *=
 sizeof::<u8>()` bytes.
>> >          unsafe { core::slice::from_raw_parts(data, len) }
>> >      }
>> > +
>> > +    /// Returns `self` as a mutable slice of bytes.
>> > +    fn as_bytes_mut(&mut self) -> &mut [u8]
>> > +    where
>> > +        Self: FromBytes,
>> > +    {
>> > +        let data =3D core::ptr::from_mut(self).cast::<u8>();
>>=20
>> Also add a `CAST` comment above this line:
>>=20
>>     // CAST: `Self` implements both `AsBytes` and `FromBytes` thus makin=
g `Self` bi-directionally
>>     // transmutable to `[u8; size_of_val(self)]`.
>>=20
>> On that note, `FromBytes` probably entails `Sized`, or does someone have
>> a use-case in mind? (because then we could replace the
>
> Because if `T` is `FromBytes` then we want `[T]` is `FromBytes` too?
> Also it would be weird if `[u8]` itself doesn't implement `FromBytes`.

Oh yeah that's true.

---
Cheers,
Benno

