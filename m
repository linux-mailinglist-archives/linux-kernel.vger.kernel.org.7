Return-Path: <linux-kernel+bounces-810053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86154B51540
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4E703A39BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C975E2737E7;
	Wed, 10 Sep 2025 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWzGmc8p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9A425A355;
	Wed, 10 Sep 2025 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502956; cv=none; b=pFlkZPxPCG1GEtwny3QWQ5ZOkeJ0LuSb+bz2w3KReaWkfm43iD7aaWeDq527bZetBEi+6DCIUJ0oYBtFH2IQ3EZE8du2X1QtUEbJnf1jbrHgTucPh/9ss7wRyiZEl/yT9Td9tOGpnPbr3ZY+WiXSXVaBMvsF27aarl3X0CipYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502956; c=relaxed/simple;
	bh=BdC2G/sPdAAcWM8ibb7077nWQaIdcyBi3i4pvQB9Mn4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=GD1Gv/G4fe9eilNOIANf4RU0uQTw+JA+1wWoINJeY6uZhZOSLtw2dSbw01AM8X3tbt4C6URLo/vT7fhxsOkZjJpNdT8aZF5qp1EP08nckFcmyCyXE1CrSsSgi6e+Ccw0QolXgND3faYP6Z/+SqngHLqZ7TeIUdbTmpoIHXHTW0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWzGmc8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60833C4CEF0;
	Wed, 10 Sep 2025 11:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757502954;
	bh=BdC2G/sPdAAcWM8ibb7077nWQaIdcyBi3i4pvQB9Mn4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=pWzGmc8pSRElyq4MLXJdB+mp2TyP1/q0W+/TF+r7eOyXCEvqEMj5iuno0Ff4iJEJN
	 CdGp/fDFxjXggrgxlIIv9Ag4ctNkIXyxtvksZxZFOknM9aWFoEhu2EFP5/aVZ9WrQ2
	 tfCEpvBMuXKGeU44LF/kRSyG0C+1bhe8k50hR8F7mQVyAPaOQ4J9KmDXl3HzNqc9tf
	 mhWzK5wKEzOAXtHYdB8XUnc44GWXLYB93ROFnfd1Sfry6lEZ78VM2i1doEPLUK/BdY
	 FgZ92sVS92KYw+UMis0bYYfniksCt245FOv2RE5g/eMHrZTCC1qifSIr4/DsJ/HxFb
	 Q9zTlzMrKj7Pg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 13:15:50 +0200
Message-Id: <DCP2STI9M1XX.3RHBQDPQOC3JO@kernel.org>
Subject: Re: [PATCH v2] rust: pin-init: add `#[bind]` attribute to access
 previously initialized fields
Cc: "Benno Lossin" <lossin@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Fiona Behrens" <me@kloenk.dev>, "Alban
 Kurti" <kurti@invicto.ai>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250910100755.2361281-1-lossin@kernel.org>
 <aMFQL-Hq1KvBG5lh@google.com> <DCP1Y8N4SRRF.25V7F6PV5ODCQ@kernel.org>
 <CAH5fLgg+-oz_cP9=ke+ukp9qYZAsD=hKqvvGfkJWRcCKdrTQ-g@mail.gmail.com>
In-Reply-To: <CAH5fLgg+-oz_cP9=ke+ukp9qYZAsD=hKqvvGfkJWRcCKdrTQ-g@mail.gmail.com>

On Wed Sep 10, 2025 at 12:40 PM CEST, Alice Ryhl wrote:
> On Wed, Sep 10, 2025 at 12:36=E2=80=AFPM Benno Lossin <lossin@kernel.org>=
 wrote:
>>
>> On Wed Sep 10, 2025 at 12:17 PM CEST, Alice Ryhl wrote:
>> > On Wed, Sep 10, 2025 at 12:07:53PM +0200, Benno Lossin wrote:
>> >> Assigning a field a value in an initializer macro can be marked with =
the
>> >> `#[bind]` attribute. Doing so creates a `let` binding with the same
>> >> name. This `let` binding has the type `Pin<&mut T>` if the field is
>> >> structurally pinned or `&mut T` otherwise (where `T` is the type of t=
he
>> >> field).
>> >>
>> >> Signed-off-by: Benno Lossin <lossin@kernel.org>
>> >
>> > Is there a reason we can't apply this to all fields and avoid the
>> > attribute?
>>
>> Adding the attribute was due to Boqun's concern on v1 [1]. I think it
>> might be surprising too, but I'm also happy with no attribute.
>>
>> [1]: https://lore.kernel.org/all/aLshd0_C-1rh3FAg@tardis-2.local
>
> IMO the ideal is if it works without an attribute. Perhaps trying that
> in the kernel is a reasonable experiment to find out whether that's
> reasonable to do for the general language feature?
>
>> > Do we have a place that might be able to use this?
>>
>> I didn't find one, but Danilo plans to base some changes on top this
>> cycle that need this.

We can use it in devres right away:

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index d04e3fcebafb..97c616a1733d 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -137,10 +137,11 @@ pub fn new<'a, E>(
     {
         let callback =3D Self::devres_callback;
=20
-        try_pin_init!(&this in Self {
+        try_pin_init!(Self {
             dev: dev.into(),
             callback,
             // INVARIANT: `inner` is properly initialized.
+            #[bind]
             inner <- Opaque::pin_init(try_pin_init!(Inner {
                     devm <- Completion::new(),
                     revoke <- Completion::new(),
@@ -150,8 +151,7 @@ pub fn new<'a, E>(
             //
             // [1] https://github.com/Rust-for-Linux/pin-init/pull/69
             _add_action: {
-                // SAFETY: `this` is a valid pointer to uninitialized memo=
ry.
-                let inner =3D unsafe { &raw mut (*this.as_ptr()).inner };
+                let inner =3D core::ptr::from_ref(inner.into_ref().get_ref=
());
=20
                 // SAFETY:
                 // - `dev.as_raw()` is a pointer to a valid bound device.
@@ -160,7 +160,7 @@ pub fn new<'a, E>(
                 //    properly initialized, because we require `dev` (i.e.=
 the *bound* device) to
                 //    live at least as long as the returned `impl PinInit<=
Self, Error>`.
                 to_result(unsafe {
-                    bindings::devm_add_action(dev.as_raw(), Some(callback)=
, inner.cast())
+                    bindings::devm_add_action(dev.as_raw(), Some(callback)=
, inner.cast_mut().cast())
                 }).inspect_err(|_| {
                     let inner =3D Opaque::cast_into(inner);
=20

Together with the initializer code blocks this becomes quite nice. :)

> Danilo, what plans do you have?

Besides that, the plan is [1].

[1] https://lore.kernel.org/all/DCL32RUQ6Z56.1ERY7JBK6O1J6@kernel.org/

