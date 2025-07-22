Return-Path: <linux-kernel+bounces-740762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E14B0D8D7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6839216E647
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702332D3EFB;
	Tue, 22 Jul 2025 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jt5ETB0w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE084199237;
	Tue, 22 Jul 2025 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185810; cv=none; b=ZDyD1UXrKtVQsKxELPmZs0TVR4pYTZ0fKLM1Fz134CJcFHX8TxVc2uaPymN4PfKHQncLVt/Vd4ZcgaN2+fqPhjFxeVfygiHv2fD/aWSGC5IJRbBaE+mqyElJwYVp8qjrswlB1zwm4kUj0XzDUkdKZ8s5ElvlAV7H9sbo3mfY04M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185810; c=relaxed/simple;
	bh=TXAjYkdUmXyPxBwsH1cflQGs0k1rSPQ8+883CPwRwOo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=h/aM44HVJHpwCdKvPGrh/C8cHLLsMBOiyj+CJC8VK4b2Ci+pxarl2rheNpKS6vXX0fJ/q2JhLhAe1rt2qmZNBbS15r7KBP26fBtDCZUVP1vqxCbhUd2KP7PJbwUr7PZEySOof0TYonEfilJO/QtzLZEqI8H+rQFc3QsgcoF+780=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jt5ETB0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DA4C4CEEB;
	Tue, 22 Jul 2025 12:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753185810;
	bh=TXAjYkdUmXyPxBwsH1cflQGs0k1rSPQ8+883CPwRwOo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Jt5ETB0wHQro9lz4ZFiHkk6tvmI/w4jvZLH/tR+MyNg4aU9LTRQ03V20uw0NPCK7r
	 7ERTgdunLqC5ZSyOKRjNL9DKDgKxWzsqjeflPjujp9f/N97i1u04D/F/hbe7Rs6vqq
	 YBuNTICWJtn1abp1UPA7v2TJWTGhXEdcH5ea+z6PlJ6qCjn2gi5k1iA6+JAyHuolvN
	 5tXw6rXWZwVWGrjtAWUnAeKW2N5HJRmu+JG7kh9/8jRMSWxuiRmiXbYQqO/dD6DEob
	 e1g9Q+srhAVSFSNLIq4lCQn9jYWO5ulSOdViZK11k9sC44ZI1YabAvm/h1IzsoxGGC
	 8KYTgkfBFhJ3g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Jul 2025 14:03:25 +0200
Message-Id: <DBIKI0KDP1J8.3MOHF5G3A6JEH@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Lyude Paul"
 <lyude@redhat.com>, "Mitchell Levy" <levymitchell0@gmail.com>, "Wedson
 Almeida Filho" <wedsonaf@gmail.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: sync: fix safety comment for `static_lock_class`
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
X-Mailer: aerc 0.20.1
References: <20250520231714.323931-1-lossin@kernel.org>
 <DBIJLR7XNI6U.21PMPODHE83DZ@kernel.org>
 <CAH5fLgh9aEF5V9rNq2a8utS=NxSU8rdxpKsNbsuPoMpDfHN0fg@mail.gmail.com>
In-Reply-To: <CAH5fLgh9aEF5V9rNq2a8utS=NxSU8rdxpKsNbsuPoMpDfHN0fg@mail.gmail.com>

On Tue Jul 22, 2025 at 1:34 PM CEST, Alice Ryhl wrote:
> On Tue, Jul 22, 2025 at 1:21=E2=80=AFPM Benno Lossin <lossin@kernel.org> =
wrote:
>> On Wed May 21, 2025 at 1:17 AM CEST, Benno Lossin wrote:
>> > The safety comment mentions lockdep -- which from a Rust perspective
>> > isn't important -- and doesn't mention the real reason for why it's
>> > sound to create `LockClassKey` as uninitialized memory.
>> >
>> > Signed-off-by: Benno Lossin <lossin@kernel.org>
>> > ---
>> >
>> > I don't think we need to backport this.
>> >
>> > ---
>> >  rust/kernel/sync.rs | 7 +++++--
>> >  1 file changed, 5 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
>> > index 36a719015583..a10c812d8777 100644
>> > --- a/rust/kernel/sync.rs
>> > +++ b/rust/kernel/sync.rs
>> > @@ -93,8 +93,11 @@ fn drop(self: Pin<&mut Self>) {
>> >  macro_rules! static_lock_class {
>> >      () =3D> {{
>> >          static CLASS: $crate::sync::LockClassKey =3D
>> > -            // SAFETY: lockdep expects uninitialized memory when it's=
 handed a statically allocated
>> > -            // lock_class_key
>> > +            // Lockdep expects uninitialized memory when it's handed =
a statically allocated `struct
>> > +            // lock_class_key`.
>> > +            //
>> > +            // SAFETY: `LockClassKey` transparently wraps `Opaque` wh=
ich permits uninitialized
>> > +            // memory.
>> >              unsafe { ::core::mem::MaybeUninit::uninit().assume_init()=
 };
>>
>> Looking at this patch with fresh eyes (thanks for the bump, Alice :) I
>> think we should rather have a public unsafe function on `LockClassKey`
>> that creates an uninitialized lock class key. I'd like to avoid the
>> `MaybeUninit::uninit().assume_init()` pattern, as it might confuse
>> people & it looks very wrong.
>>
>> We can take this patch, as it definitely is an improvement, but I think
>> we should also just fix this properly. Any thoughts?
>
> Could that constructor be used in non-static cases?

I don't know lockdep, so maybe yes? Or do you mean that it could be
abused?

---
Cheers,
Benno

