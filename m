Return-Path: <linux-kernel+bounces-745669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9024B11CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFF6547BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511972E5432;
	Fri, 25 Jul 2025 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jgpg/dIX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98952E49A0;
	Fri, 25 Jul 2025 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440665; cv=none; b=V20h7N0Yswu6NJlQmqqHaOUaBslCwmbO2DU3h/dNmYubyiOchLZzeZTvrdU44uMCtcut8o5G6xRMbwa+Q2Mr3G5anUTkNCPjLxbCLZt37qweIBJO1p17Yq33Yv/77yd5yX8/Pqbw5vEw3FyMVAP7X41fGins4QUwGbbQ7iy3ZzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440665; c=relaxed/simple;
	bh=zM8pksNRLwQmf2gSbGQqTAUHdHWN0vI/YeCoS77dA/A=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=OXV+zbTSBd1+NikhzS+t9v+EDckcTEqA3KhFDl2W/+/931ijHR3WCraFDuIrbrJRO4Zz0P5XXdWag4CIBoT8himIxpgdPG70EFH+DMzW51v06b46/IC3eQ7ats/quJ9vvqAEsOFvFRLgEJWvVgrTC0OTPlni1U/vSJlhouJcl3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jgpg/dIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB15C4CEEF;
	Fri, 25 Jul 2025 10:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753440665;
	bh=zM8pksNRLwQmf2gSbGQqTAUHdHWN0vI/YeCoS77dA/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jgpg/dIXJxJeC5o+P8xoWR79GLnzgP1ot5bdkexr4Eb1/pENYrgqJ49LpeUIVezvT
	 i16iZsEDoBgIT1EhfBHeF9za/Ps7x0fflqPCqUvKKn963AO+rriE5+m0wXCSApaNuN
	 ZFC1eUJOMwSbpaLIy17PDvVEfBGZDzLq1ya5xSCWwPY+3bOyCSPwr8XcmZrXmFR4dB
	 D19FlO6j0m3aK0jMt52ZsYr/2t1RiuVv79XcPOFBrJqBmNR9ATRTJao0lj8GNC9kmm
	 gou3mvf7440G8vtckgvRv5BHnmJKVxMDvjr2xt3oWPworN9v+UzVMEJK3iwB2zYZPg
	 TFtPatYoVlXLw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Jul 2025 12:51:00 +0200
Message-Id: <DBL2U6WPW5TO.1KXQ8V64MRRHU@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Boqun Feng"
 <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Waiman Long"
 <longman@redhat.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3] rust: lock: Export Guard::do_unlocked()
X-Mailer: aerc 0.20.1
References: <20250724211634.586808-1-lyude@redhat.com>
In-Reply-To: <20250724211634.586808-1-lyude@redhat.com>

On Thu Jul 24, 2025 at 11:15 PM CEST, Lyude Paul wrote:
> In RVKMS, I discovered a silly issue where as a result of our HrTimer for
> vblank emulation and our vblank enable/disable callbacks sharing a
> spinlock, it was possible to deadlock while trying to disable the vblank
> timer.
>
> The solution for this ended up being simple: keep track of when the HrTim=
er
> could potentially acquire the shared spinlock, and simply drop the spinlo=
ck
> temporarily from our vblank enable/disable callbacks when stopping the
> timer. And do_unlocked() ended up being perfect for this.

In this case, couldn't you also just add another function to stopping
the timer that takes the lock guard (instead of locking the lock itself)?

> Since this seems like it's useful, let's export this for use by the rest =
of
> the world and write short documentation for it.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> ---
> V2:
> * Fix documentation for do_unlocked
> * Add an example
> V3:
> * Documentation changes from Miguel

Please wait a couple days before sending a new version, thanks!

>  rust/kernel/sync/lock.rs | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index e82fa5be289c1..800cdd16dce6e 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -228,7 +228,40 @@ pub fn lock_ref(&self) -> &'a Lock<T, B> {
>          self.lock
>      }
> =20
> -    pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U=
 {
> +    /// Releases this [`Guard`]'s lock temporarily, executes `cb` and th=
en re-acquires it.
> +    ///
> +    /// This can be useful for situations where you may need to do a tem=
porary unlock dance to avoid
> +    /// issues like circular locking dependencies.
> +    ///
> +    /// It returns the value returned by the closure.
> +    ///
> +    /// # Examples
> +    ///
> +    /// The following example shows how to use [`Guard::do_unlocked`] to=
 temporarily release a lock,
> +    /// do some work, then re-lock it.

I would remove this sentence, as the example is pretty easy to follow
(at least at the moment).

> +    ///
> +    /// ```
> +    /// # use kernel::{new_spinlock, sync::lock::{Backend, Guard, Lock}}=
;
> +    /// # use pin_init::stack_pin_init;
> +    /// fn assert_held<T, B: Backend>(guard: &Guard<'_, T, B>, lock: &Lo=
ck<T, B>) {
> +    ///     // Address-equal means the same lock.
> +    ///     assert!(core::ptr::eq(guard.lock_ref(), lock));
> +    /// }
> +    ///
> +    /// stack_pin_init! {
> +    ///     let l =3D new_spinlock!(42)
> +    /// }

I normally write

    stack_pin_init!(let l =3D new_spinlock!(42));

Or do you feel like that's less readable?

> +    ///
> +    /// let mut g =3D l.lock();
> +    /// let val =3D *g;
> +    ///
> +    /// // The lock will be released, but only temporarily
> +    /// g.do_unlocked(|| assert_eq!(val, 42));

I feel like this example doesn't show how `do_unlocked` is useful. How
about you add a function that locks the lock & you call it from inside
the `do_unlocked` call? Similar to the issue you described in the commit
message?

---
Cheers,
Benno

> +    ///
> +    /// // `g` originates from `l` and should be relocked now.
> +    /// assert_held(&g, &l);
> +    /// ```
> +    pub fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
>          // SAFETY: The caller owns the lock, so it is safe to unlock it.
>          unsafe { B::unlock(self.lock.state.get(), &self.state) };
> =20
>
> base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807


