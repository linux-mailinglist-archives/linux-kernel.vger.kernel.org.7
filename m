Return-Path: <linux-kernel+bounces-804652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ACAB47B17
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 13:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7041C1B21B34
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2F5258ED4;
	Sun,  7 Sep 2025 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2YkkkLc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764831991C9;
	Sun,  7 Sep 2025 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757245773; cv=none; b=dzYMwk5TYKR5kfofat5f+LUuzYI/Uww5L3XNRt9V86QcqWMQBsJ5iYDFTHB4RGdzxnHxIoGtlED5tdcUmAhKHN9g3PbrIiIQD0GGYAzi/XtXkOMwZoymjbkzHGGpjeR0m9FoJJe6wt0xapZTwMdMFYgNPSrLBwZx3yf2N08Dx4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757245773; c=relaxed/simple;
	bh=aIdhlvipyo2+0PeyQWDF3eftzsmA1c2NyjjqT0eU764=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Y+TBjnuXHhm+DB5e5lo3BfvhhqNUp/wncexhSMPLEJoKvPiX0u13KuELt9ZibAzVFqeNEoVKODp3dUHq6daV2Ap2GDiNOv/zpfnDVde+QpMt4V599eK/vQxysqaWLca468RhyiTy6Kdcz7ZivavpdVkD/d2rU4n0CNnyw7p31lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2YkkkLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B88C4CEF0;
	Sun,  7 Sep 2025 11:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757245773;
	bh=aIdhlvipyo2+0PeyQWDF3eftzsmA1c2NyjjqT0eU764=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=b2YkkkLc+dGfx3ZjDLU5dsOg9R4XIg0hxranpL9139I6xYZ7xJCaFK+glzyeI9+fo
	 KEJGfXq1VGvaUGy1SaoLjk1IC9f5xFa1Au7RVhW3nztY/qhU1HCjc9JYqFwXgl6Wed
	 YxI2OoHXEkkWj8QCQQPJSlBb2B1uRjqWhdo8pzAZgbFth2gHLlxGvpczcwudpHIXup
	 gEJZ4PuoNGyMtFWPnYkSmB5haPTdIsg1LPIbth0stNwkRuZ/zYnKwoOaf3iA70jWa3
	 we0eaH1e/Nlf5LdQBVAcON6HuCD5Ux2cGuzpd69c/ULfIIn9nhO6mrpfXrS+LeNJI+
	 KUJahWylYrZWg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Sep 2025 13:49:28 +0200
Message-Id: <DCMJMXGN68E0.IZ2F31AI11JW@kernel.org>
Subject: Re: [PATCH] rust: pin-init: add code blocks to `[try_][pin_]init!`
 macros
Cc: "Benno Lossin" <lossin@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Fiona Behrens" <me@kloenk.dev>,
 "Christian Schrefl" <chrisi.schrefl@gmail.com>, "Alban Kurti"
 <kurti@invicto.ai>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250905140534.3328297-1-lossin@kernel.org>
 <aL1lHyhzWX0xGrmo@google.com> <DCMJ0VFOV9L1.33BPI08N4H7WZ@kernel.org>
 <aL1tloBwmJnYFPpa@google.com>
In-Reply-To: <aL1tloBwmJnYFPpa@google.com>

On Sun Sep 7, 2025 at 1:33 PM CEST, Alice Ryhl wrote:
> On Sun, Sep 07, 2025 at 01:20:39PM +0200, Danilo Krummrich wrote:
>> On Sun Sep 7, 2025 at 12:57 PM CEST, Alice Ryhl wrote:
>> > On Fri, Sep 05, 2025 at 04:05:31PM +0200, Benno Lossin wrote:
>> >> Allow writing `_: { /* any number of statements */ }` in initializers=
 to
>> >> run arbitrary code during initialization.
>> >>=20
>> >>     try_init!(MyStruct {
>> >>         _: {
>> >>             if check_something() {
>> >>                 return Err(MyError);
>> >>             }
>> >>         },
>> >>         foo: Foo::new(val),
>> >>         _: {
>> >>             println!("successfully initialized `MyStruct`");
>> >>         },
>> >>     })
>> >>=20
>> >> Link: https://github.com/Rust-for-Linux/pin-init/pull/84/commits/2880=
a9b898336e2d54f80715f00ce00f21f74d2f
>> >> Signed-off-by: Benno Lossin <lossin@kernel.org>
>> >
>> > Nice! Would it be possible to include a user so I can see it work in
>> > practice? E.g., for the irq feature?
>>=20
>> Devres needs this too, but the corresponding devres stuff was a fix and =
is in
>> the current -rc only, so that's not a candidate.
>>=20
>> The IRQ stuff is in driver-core-next going to Linus for v6.18, hence, us=
ing it
>> there, this patch would have to go through the driver-core tree as well.
>>=20
>> For me it is fine either way.
>
> It doesn't have to land together. I would be happy with:
>
> 	THIS CYCLE: Land just this patch.
> 	NEXT CYCLE: Land the irq and/or devres user.
>
> But I'd like to see it work in practice before I give a Reviewed-by.
> It's hard to evaluate this kind of macro change just from the macro
> itself.

Here's a patch for using it in devres (we backmerged -rc3 into
driver-core-next):

From 23e48f081b7ba6bebd375c6fa929f070f7977fc5 Mon Sep 17 00:00:00 2001
From: Danilo Krummrich <dakr@kernel.org>
Date: Sun, 7 Sep 2025 13:44:43 +0200
Subject: [PATCH] rust: devres: take advantage of initializer code blocks

Use pin-init initializer code blocks to register the devres action.

This resolved the TODO introduced by commit 75a7b151e808 ("rust: devres:
fix leaking call to devm_add_action()").

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 132545962218..430fc4880ddb 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -119,7 +119,6 @@ pub struct Devres<T: Send> {
     // explicit `Send` and `Sync' impls can be removed.
     #[pin]
     inner: Opaque<Inner<T>>,
-    _add_action: (),
 }

 impl<T: Send> Devres<T> {
@@ -146,10 +145,7 @@ pub fn new<'a, E>(
                     revoke <- Completion::new(),
                     data <- Revocable::new(data),
             })),
-            // TODO: Replace with "initializer code blocks" [1] once avail=
able.
-            //
-            // [1] https://github.com/Rust-for-Linux/pin-init/pull/69
-            _add_action: {
+            _: {
                 // SAFETY: `this` is a valid pointer to uninitialized memo=
ry.
                 let inner =3D unsafe { &raw mut (*this.as_ptr()).inner };


base-commit: 544c94f0e155614551e0210074597a23d117830c
--
2.51.0


