Return-Path: <linux-kernel+bounces-759409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1484B1DD2F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D4717C1F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C2021772D;
	Thu,  7 Aug 2025 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noJAjtUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1E258A;
	Thu,  7 Aug 2025 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591980; cv=none; b=ls9imY+9eudde7aYM2MuK5jb+60Pv+QXXR0Frq+ojc+teYc93oTXjNHrimkZ8utHRqVLE+0QKpTlGnc2vJS3YN6tQkvhshKSFwkHEIfoHaEN3auCglykSwPeFit+1LTuZV5EWw085Vdy4sNU+CFHJN3Fh1M/BSrHwtcvluRCvhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591980; c=relaxed/simple;
	bh=bPCKJRjhjh4Dtw4/JoSSK+9T9FOVH22EqlYJPCnTKv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cl30xOI/98GLURHOmE4ueS7FQfJXooh0pU/UiLS0/s/XR8A0xa7LXtJ7PwDk/qKHx8VKATnPmGOKFx9JLS58BJ9xbrDHOxHPeL3ukyixH96+ywsBVRNUC7O3e7t3dZ3Vfmr0VzzRtKVB9cJrBItfEqyiBPg9yMbixTLYNRJ4jX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noJAjtUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C427C4CEEB;
	Thu,  7 Aug 2025 18:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754591980;
	bh=bPCKJRjhjh4Dtw4/JoSSK+9T9FOVH22EqlYJPCnTKv4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=noJAjtUvVZB919riuFxsSkOJAi4dvtPKlq/vkaKLFDaJVHd44HD/mie4Ab5cpYHgm
	 HGgdyQtXskNkcyihqE4pG4R0uiGi/VAcXb+QA1zr2we7XmtJSmp8doQSZj6hMZLCsF
	 m77ogBhBUsyQS/pYtQeevn6y0UTPCCLhfYZYd1amMwvqG2cvwZZlVznIvBiuRS0lhK
	 X8jHQZ4+rjlUFnOtKpQRBG+XWWeCtwlRNkzC+b2VBXeTNlXgXlvgmM30BDlUN1RJQr
	 BfhOLI5+pPtUw7oZ2HgUCysg+YdcA++rNvE9AVWfaQ6LrnK6a+Ks67NQ6XKywx6eYN
	 KrrDLiIynukrg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>
Subject: Re: [PATCH v6 3/7] rust: hrtimer: Add HrTimer::raw_forward() and
 forward()
In-Reply-To: <20250724185236.556482-4-lyude@redhat.com>
References: <20250724185236.556482-1-lyude@redhat.com>
 <ei8aqAnSlMI4QZKI6lsAsRHQwSfnrFDKH4qKKWq1fp0F6AwT66hF8tpIhRRyk3Vg6W4Ewpib1NZB9JPI1g1B9A==@protonmail.internalid>
 <20250724185236.556482-4-lyude@redhat.com>
Date: Thu, 07 Aug 2025 20:39:29 +0200
Message-ID: <87h5yj6kny.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> Within the hrtimer API there are quite a number of functions that can only
> be safely called from one of two contexts:
>
> * When we have exclusive access to the hrtimer and the timer is not active.
> * When we're within the hrtimer's callback context as it is being executed.
>
> This commit adds bindings for hrtimer_forward() for the first such context,
> along with HrTimer::raw_forward() for later use in implementing the
> hrtimer_forward() in the latter context.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> ---
> V4:
> * Fix the safety contract for raw_forward()
> * Require Pin<&mut Self>, not &mut self
> * Drop incorrect UniquePin example
> * Rewrite documentation a bit (re: Andreas)
> V6:
> * Remove the reference to HrTimerCallbackContext::forward() until this
>   function gets added.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/time/hrtimer.rs | 40 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index be1bad4aacaad..5ccdd1b0b8021 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -168,6 +168,46 @@ pub(crate) unsafe fn raw_cancel(this: *const Self) -> bool {
>          // handled on the C side.
>          unsafe { bindings::hrtimer_cancel(c_timer_ptr) != 0 }
>      }
> +
> +    /// Forward the timer expiry for a given timer pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `self_ptr` must point to a valid `Self`.
> +    /// - The caller must either have exclusive access to the data pointed at by `self_ptr`, or be
> +    ///   within the context of the timer callback.
> +    #[inline]
> +    unsafe fn raw_forward(self_ptr: *mut Self, now: HrTimerInstant<T>, interval: Delta) -> u64
> +    where
> +        T: HasHrTimer<T>,
> +    {
> +        // SAFETY:
> +        // * The C API requirements for this function are fulfilled by our safety contract.
> +        // * `self_ptr` is guaranteed to point to a valid `Self` via our safety contract
> +        unsafe {
> +            bindings::hrtimer_forward(Self::raw_get(self_ptr), now.as_nanos(), interval.as_nanos())
> +        }
> +    }
> +
> +    /// Conditionally forward the timer.
> +    ///
> +    /// If the timer expires after `now`, this function does nothing and returns 0. If the timer
> +    /// expired at or before `now`, this function forwards the timer by `interval` until the timer
> +    /// expires after `now` and then returns the number of times the timer was forwarded by
> +    /// `interval`.
> +    ///
> +    /// Returns the number of overruns that occurred as a result of the timer expiry change.
> +    pub fn forward(self: Pin<&mut Self>, now: HrTimerInstant<T>, interval: Delta) -> u64
> +    where
> +        T: HasHrTimer<T>,
> +    {
> +        // SAFETY:
> +        // - `raw_forward` does not move `self`.
> +        // - Self is a mutable reference and thus always points to a valid `HrTimer`
> +        // - The only way that we could hold a mutable reference to `HrTimer<T>` is if we have
> +        //   exclusive access to it - fulfilling the requirements of the C API.

C API requirements are not relevant for this call. Maybe you can replace
the last two lines by:

  By existence of `Pin<&mut Self>`, the pointer passed to `raw_forward`
  points to a valid `Self` that we have exclusive access to.

It is slightly obscure because we coerce `self.get_unchecked_mut() ->
&mut Self` to `*mut Self` in one go. Perhaps split it up:

  let self_ptr: *mut Self = self.get_unchecked_mut();
  // SAFETY: ...
  unsafe { Self::raw_forward(self_ptr, now, interval) }

Best regards,
Andreas Hindborg


