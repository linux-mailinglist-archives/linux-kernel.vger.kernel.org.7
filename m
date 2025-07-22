Return-Path: <linux-kernel+bounces-741404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA85B0E3AF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEF517F4F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EF8283680;
	Tue, 22 Jul 2025 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t07SyrOC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA0521516E;
	Tue, 22 Jul 2025 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210225; cv=none; b=EXfNHqUeGP8hA1lGr4o7CaJfa9vJlg8WCJWvs1fMAF6VTaKYIlnbs7IdVUCYG8gh3RtSWk9Cby03CNq1lErf9UVIT91rugVKIGlxbWlL3xkKtDnrgaYrkFehMk7HVeZeVUPeI/YgUxJPP8v8K/tUfkFdbcB6ntcTipMNb9T+g3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210225; c=relaxed/simple;
	bh=TKaehvJFYucpqRsCQiA/i3iI7bsv4bNIH/1U9NLuV6o=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=PSDk4D4D11mfbTWhAHObnLqgO5sp6nsZbM/Ffk+K48KJps208MxdmJoEiAUfapGI03ylCyAEOyDr54U94k2UpF/Dr0yrtt86zXj0Dk9KGjQYuXjNiYvQakImCNKrXSie6RXi4qzG46UtBTwFhLnUbKI3upBWpHt9XdsnD1Dzs0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t07SyrOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E38C4CEEB;
	Tue, 22 Jul 2025 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753210225;
	bh=TKaehvJFYucpqRsCQiA/i3iI7bsv4bNIH/1U9NLuV6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t07SyrOCN+jt16upJhz/Zr7FzQyb5HRf810CZRhIbKO1AyVC8bQ8Lj9XY/xuE3Ogz
	 Jru5i2/nryRgMYsWxsOMb47sim2naQv9yshKVY/Uxhn8pAXCEG/ejtGXpy0iqLVkz6
	 Ili5KEOm0/DnqWZDiPGiJZV814av/KZa34XYs8uaYh2SDgax0m57iMVkLNutJz05ZJ
	 4Cw1RtUToIcJyF9hmwrO5swBBtBx2R1EJHDaixm+b5MiuwFKUrdu7OU0f28vux5vKt
	 fLKqyrMBjgfm4UdxTmXbfWzPdmjzu6fubZF1YkVlyBv0VnZU3KjfsX4xKPycc9Miy1
	 /DB8DVaUyxvnA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Jul 2025 20:50:20 +0200
Message-Id: <DBIT5KD4CXDZ.1MZUPQMAWL4Y8@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Lyude Paul" <lyude@redhat.com>, "Mitchell Levy" <levymitchell0@gmail.com>,
 "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: sync: fix safety comment for `static_lock_class`
X-Mailer: aerc 0.20.1
References: <20250520231714.323931-1-lossin@kernel.org>
 <DBIJLR7XNI6U.21PMPODHE83DZ@kernel.org>
 <CAH5fLgh9aEF5V9rNq2a8utS=NxSU8rdxpKsNbsuPoMpDfHN0fg@mail.gmail.com>
 <DBIKI0KDP1J8.3MOHF5G3A6JEH@kernel.org> <aH-hcnZ3hiQIQj-5@tardis-2.local>
In-Reply-To: <aH-hcnZ3hiQIQj-5@tardis-2.local>

On Tue Jul 22, 2025 at 4:34 PM CEST, Boqun Feng wrote:
> On Tue, Jul 22, 2025 at 02:03:25PM +0200, Benno Lossin wrote:
>> On Tue Jul 22, 2025 at 1:34 PM CEST, Alice Ryhl wrote:
>> > On Tue, Jul 22, 2025 at 1:21=E2=80=AFPM Benno Lossin <lossin@kernel.or=
g> wrote:
>> >> On Wed May 21, 2025 at 1:17 AM CEST, Benno Lossin wrote:
>> >> > The safety comment mentions lockdep -- which from a Rust perspectiv=
e
>> >> > isn't important -- and doesn't mention the real reason for why it's
>> >> > sound to create `LockClassKey` as uninitialized memory.
>> >> >
>> >> > Signed-off-by: Benno Lossin <lossin@kernel.org>
>> >> > ---
>> >> >
>> >> > I don't think we need to backport this.
>> >> >
>> >> > ---
>> >> >  rust/kernel/sync.rs | 7 +++++--
>> >> >  1 file changed, 5 insertions(+), 2 deletions(-)
>> >> >
>> >> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
>> >> > index 36a719015583..a10c812d8777 100644
>> >> > --- a/rust/kernel/sync.rs
>> >> > +++ b/rust/kernel/sync.rs
>> >> > @@ -93,8 +93,11 @@ fn drop(self: Pin<&mut Self>) {
>> >> >  macro_rules! static_lock_class {
>> >> >      () =3D> {{
>> >> >          static CLASS: $crate::sync::LockClassKey =3D
>> >> > -            // SAFETY: lockdep expects uninitialized memory when i=
t's handed a statically allocated
>> >> > -            // lock_class_key
>> >> > +            // Lockdep expects uninitialized memory when it's hand=
ed a statically allocated `struct
>> >> > +            // lock_class_key`.
>> >> > +            //
>> >> > +            // SAFETY: `LockClassKey` transparently wraps `Opaque`=
 which permits uninitialized
>> >> > +            // memory.
>> >> >              unsafe { ::core::mem::MaybeUninit::uninit().assume_ini=
t() };
>> >>
>> >> Looking at this patch with fresh eyes (thanks for the bump, Alice :) =
I
>> >> think we should rather have a public unsafe function on `LockClassKey=
`
>> >> that creates an uninitialized lock class key. I'd like to avoid the
>> >> `MaybeUninit::uninit().assume_init()` pattern, as it might confuse
>> >> people & it looks very wrong.
>> >>
>> >> We can take this patch, as it definitely is an improvement, but I thi=
nk
>> >> we should also just fix this properly. Any thoughts?
>> >
>> > Could that constructor be used in non-static cases?
>>=20
>> I don't know lockdep, so maybe yes? Or do you mean that it could be
>
> Using in non-static cases is wrong. For static keys, lockdep could use
> it address as keys but for dynamic keys, since they can be freed, they
> have to be registered before use (that's what
> `LockClassKey::new_dynamic()` is about.
>
> See this:
>
> 	https://lore.kernel.org/rust-for-linux/20240815074519.2684107-3-nmi@meta=
space.dk/
>
> We would need to add "for static only" for the proposed unsafe function.

Yeah sounds good, I like it better than using the pattern above. We can
also make it `#[doc(hidden)]`, so people don't use it :)

---
Cheers,
Benno

