Return-Path: <linux-kernel+bounces-747199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C574B130E9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1318F3B4C57
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5309221FF24;
	Sun, 27 Jul 2025 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pvt90VGp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E6D217648;
	Sun, 27 Jul 2025 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753637300; cv=none; b=j5znXmzhW0vfZiGcPupei/GmGxw+EnWoALoA2F/+PAWTKeeOUJvxlZopalKB59Qkbb2Z/NOmIl1yGacM1n0xF3exPlHIdl97g3k9N+G1hzwn//ulV4oxYjg7v1n31wf0hK4BUXJdXKCr/OAvWKc+vL6WsvssVGmXhrkW1SPsBq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753637300; c=relaxed/simple;
	bh=aB7rmwPoHrrWa208LBL4TWr5fe10pGe+mhEMwuzwbgQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GZIAKcPulcsQuUbe8mPQ6qcgfoz4E/NeXGv8E2DAb5gMpa6LUrLSylfA9Q5ivmPe56C+tjVrI+s9xu0wu1MpZqqtvU2dStJdyEBAbhTwDBjIEXaq1r0MN43BQXILfPVRDpykWKLMzERao4ZcDimb7A2Z3ou5BMvSNYuTFGv3TSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pvt90VGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9C0C4CEEB;
	Sun, 27 Jul 2025 17:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753637300;
	bh=aB7rmwPoHrrWa208LBL4TWr5fe10pGe+mhEMwuzwbgQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Pvt90VGpytP/iKvFGkQcwdqN5I3a9hsKYCoT5BEpqvD8f1Q3NamBPLj5B6DIFxtGR
	 AM9n9V9P7PXse6VVGSofoBXaFvG28jdhZ5JNIqK9gGiJNfDA7pLw+vU+m1ZPqLZdSl
	 O9gNjSJ0kCdC8oVIPoiljkfFTKEy+yjH4KQuWBC4HV+y6JUetdwAwMUcNJmBGO1DUX
	 OIRCKyPtPdwklIDwUM7GHq2mBZqXKFl7BEws0mPJtCNg+CVstz1tSTRE5B6EU5hg+f
	 Ez9KGlY3H42mtVwcaF+r2/MGtTB1orYC3BndStL1F5OzKgxhON+3xWyUyBqudupDjt
	 3yEnqjJJix+2g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Jul 2025 19:28:15 +0200
Message-Id: <DBN0JG0QP7TU.PZSZ8NZL5LD6@kernel.org>
Cc: <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust/pin-init: remove workaround for type inference
 cycle
From: "Benno Lossin" <lossin@kernel.org>
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <me@kloenk.dev>, <chrisi.schrefl@gmail.com>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250727170217.206794-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20250727170217.206794-1-suchitkarunakaran@gmail.com>

On Sun Jul 27, 2025 at 7:02 PM CEST, Suchit Karunakaran wrote:
> The `cast_pin_init` and `cast_init` functions previously used an
> intermediate `let` binding before returning the result expression to work
> around a Rust compiler issue causing type inference cycles. With the
> minimum Rust compiler version for the kernel now at 1.78.0, where this
> issue is fixed, the workaround is no longer needed. This patch removes th=
e
> unnecessary `let` variables and returns the expressions directly.
>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

I still encounter the cycle when compiling with 1.78.0, which version
did you test this with?

One of The errors I see after applying the patch on top of
`pin-init-next`:

    error[E0391]: cycle detected when computing type of opaque `cast_pin_in=
it::{opaque#0}`
        --> rust/pin-init/src/lib.rs:1278:73
         |
    1278 | pub const unsafe fn cast_pin_init<T, U, E>(init: impl PinInit<T,=
 E>) -> impl PinInit<U, E> {
         |                                                                 =
        ^^^^^^^^^^^^^^^^^^
         |
    note: ...which requires borrow-checking `cast_pin_init`...
        --> rust/pin-init/src/lib.rs:1278:1
         |
    1278 | pub const unsafe fn cast_pin_init<T, U, E>(init: impl PinInit<T,=
 E>) -> impl PinInit<U, E> {
         | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^
    note: ...which requires promoting constants in MIR for `cast_pin_init`.=
..
        --> rust/pin-init/src/lib.rs:1278:1
         |
    1278 | pub const unsafe fn cast_pin_init<T, U, E>(init: impl PinInit<T,=
 E>) -> impl PinInit<U, E> {
         | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^
    note: ...which requires const checking `cast_pin_init`...
        --> rust/pin-init/src/lib.rs:1278:1
         |
    1278 | pub const unsafe fn cast_pin_init<T, U, E>(init: impl PinInit<T,=
 E>) -> impl PinInit<U, E> {
         | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^
         =3D note: ...which requires computing whether `cast_pin_init::{opa=
que#0}` is freeze...
         =3D note: ...which requires evaluating trait selection obligation =
`cast_pin_init::{opaque#0}: core::marker::Freeze`...
         =3D note: ...which again requires computing type of opaque `cast_p=
in_init::{opaque#0}`, completing the cycle
    note: cycle used when computing type of `cast_pin_init::{opaque#0}`
        --> rust/pin-init/src/lib.rs:1278:73
         |
    1278 | pub const unsafe fn cast_pin_init<T, U, E>(init: impl PinInit<T,=
 E>) -> impl PinInit<U, E> {
         |                                                                 =
        ^^^^^^^^^^^^^^^^^^
         =3D note: see https://rustc-dev-guide.rust-lang.org/overview.html#=
queries and https://rustc-dev-guide.rust-lang.org/query.html for more infor=
mation

> ---
>  rust/pin-init/src/lib.rs | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
> index 62e013a5cc20..cc244eeb19cd 100644
> --- a/rust/pin-init/src/lib.rs
> +++ b/rust/pin-init/src/lib.rs
> @@ -1278,10 +1278,7 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Res=
ult<(), E> {
>  pub const unsafe fn cast_pin_init<T, U, E>(init: impl PinInit<T, E>) -> =
impl PinInit<U, E> {
>      // SAFETY: initialization delegated to a valid initializer. Cast is =
valid by function safety
>      // requirements.
> -    let res =3D unsafe { pin_init_from_closure(|ptr: *mut U| init.__pinn=
ed_init(ptr.cast::<T>())) };
> -    // FIXME: remove the let statement once the nightly-MSRV allows it (=
1.78 otherwise encounters a

Do note the comment mentioning that it is needed for version 1.78 here,
so I think this patch still needs to wait until we bump the minimum.

---
Cheers,
Benno

> -    // cycle when computing the type returned by this function)
> -    res
> +    unsafe { pin_init_from_closure(|ptr: *mut U| init.__pinned_init(ptr.=
cast::<T>())) }
>  }

