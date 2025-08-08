Return-Path: <linux-kernel+bounces-759905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D3BB1E45A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55B818C0FC1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C35625CC4D;
	Fri,  8 Aug 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s29IR6Vx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626394A11;
	Fri,  8 Aug 2025 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754641613; cv=none; b=cIP91aP9lLnwThg3MxCAccvnNbJpjE1Ffkq4Ff68XWFpj9pBfqIEp0OIufiRADfivkO8B/rFb18Y2rEnlkk7/Q2E3g8f3oZrTkRblXK+7wMh+Sf5UxC/EGI57x6LWR7oh56vhLXTpgUIeEX3Kko+TD+j7Sz+6abWExTcA5WTaFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754641613; c=relaxed/simple;
	bh=PIkUBeN5p34CHt8RnUZp/dB6DGJnt0aCMOsTGN4ZLms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nFhVBZ7yfLkY/lUV9E3cMjYSu+Rn6yNFDGQHTrvS12XukQb3HWzTtY/A/0H3wMO7j2w0gt5GfVUNixOyv7KVvNZodmsQwWCMKRsQdODcdfAmdwM7ExPq4BxuZEmzIUKeSVYfVTuGM1ixGtG3ENY4arV7/iI+NiFe7vXsljgDCSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s29IR6Vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E40C4CEED;
	Fri,  8 Aug 2025 08:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754641612;
	bh=PIkUBeN5p34CHt8RnUZp/dB6DGJnt0aCMOsTGN4ZLms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=s29IR6VxkL4tlA+dRVUMeUbATTld2jxxUo7YDY35pOY0iYFCHijHu0LovP5BTviCp
	 r8LKKMUzx07K+HJ29ERjYhJNGTc0j1NoB8VoTR5vVRflmJVRmbRxi2SoL/mxgDNi7f
	 Ci2jBonyEhWPsQppFVwob/qw90N84vSoqL/mz7drOAZKL1/wFlXOSpJ4SThCqMEz6L
	 KJFwD2jV4KMV06vfI8qpMVmoxLH+kH/v92sBFhZYeMMfek+JbwtTJEjtxtmtpd7TDd
	 Ee+zMkG7u+oA37e9LPatK52YHMHPuQgTpXPOh4sUtVf53Pi2+Tw/tI2GpkZz5esA7A
	 dnIBKy9pAKs3Q==
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
 <dakr@kernel.org>, Tamir
 Duberstein <tamird@gmail.com>
Subject: Re: [PATCH v6 4/7] rust: hrtimer: Add HrTimerCallbackContext and
 ::forward()
In-Reply-To: <20250724185236.556482-5-lyude@redhat.com>
References: <20250724185236.556482-1-lyude@redhat.com>
 <tArVEF3mt3aJ9Sgu--Ijmmln4kx_TyXOWLVFaPQAL1E3-CbqsZnQguTK9x9b1k1Nx08lbc2naNxGsP7H__I_jw==@protonmail.internalid>
 <20250724185236.556482-5-lyude@redhat.com>
Date: Fri, 08 Aug 2025 10:07:00 +0200
Message-ID: <87bjoq6xuj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> With Linux's hrtimer API, there's a number of methods that can only be
> called in two situations:
>
> * When we have exclusive access to the hrtimer and it is not currently
>   active
> * When we're within the context of an hrtimer callback context
>
> This commit handles the second situation and implements hrtimer_forward()
> support in the context of a timer callback. We do this by introducing a
> HrTimerCallbackContext type which is provided to users during the
> RawHrTimerCallback::run() callback, and then add a forward() function to
> the type.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> ---
> V2:
> * Improve SAFETY comments for HrTimerCallbackContext uses (I forgot to
>   mention that we're within RawHrTimerCallback::run()
> * Split forward into forward() and raw_forward() since we're going to have
>   two contexts that we can call forward() from now.
> * Clarify contexts in which certain hrtimer methods can be called.
> * Make sure that we use a mutable reference for forward() here - just in
>   case :).
> * Rename interval to duration
> V3:
> * Rename duration -back- to interval (now that I actually have read
>   hrtimer_forward's source, interval does make more sense than duration
>   considering the fact we return the number of overruns that occurred
>   according to the given interval).
> * Rewrite documentation a bit (re: Andreas)
> V6:
> * Move reference to HrTimerCallbackContext::forward() in HrTimer::forward()
>   comments into this commit so rustdoc doesn't fail.
> * Deduplicate documentation for HrTimerCallbackContext::forward()
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/kernel/time/hrtimer.rs         | 63 +++++++++++++++++++++++++++--
>  rust/kernel/time/hrtimer/arc.rs     |  9 ++++-
>  rust/kernel/time/hrtimer/pin.rs     |  9 ++++-
>  rust/kernel/time/hrtimer/pin_mut.rs | 12 ++++--
>  rust/kernel/time/hrtimer/tbox.rs    |  9 ++++-
>  5 files changed, 93 insertions(+), 9 deletions(-)
>
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index 5ccdd1b0b8021..a8fb176e599e8 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -69,7 +69,7 @@
>
>  use super::{ClockSource, Delta, Instant};
>  use crate::{prelude::*, types::Opaque};
> -use core::marker::PhantomData;
> +use core::{marker::PhantomData, ptr::NonNull};
>  use pin_init::PinInit;
>
>  /// A type-alias to refer to the [`Instant<C>`] for a given `T` from [`HrTimer<T>`].
> @@ -196,6 +196,10 @@ unsafe fn raw_forward(self_ptr: *mut Self, now: HrTimerInstant<T>, interval: Del
>      /// expires after `now` and then returns the number of times the timer was forwarded by
>      /// `interval`.
>      ///
> +    /// This function is mainly useful for timer types which can provide exclusive access to the
> +    /// timer when the timer is not running. For forwarding the timer from within the timer callback
> +    /// context, see [`HrTimerCallbackContext::forward()`].
> +    ///
>      /// Returns the number of overruns that occurred as a result of the timer expiry change.
>      pub fn forward(self: Pin<&mut Self>, now: HrTimerInstant<T>, interval: Delta) -> u64
>      where
> @@ -345,9 +349,13 @@ pub trait HrTimerCallback {
>      type Pointer<'a>: RawHrTimerCallback;
>
>      /// Called by the timer logic when the timer fires.
> -    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>) -> HrTimerRestart
> +    fn run(
> +        this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>,
> +        ctx: HrTimerCallbackContext<'_, Self>,
> +    ) -> HrTimerRestart
>      where
> -        Self: Sized;
> +        Self: Sized,
> +        Self: HasHrTimer<Self>;
>  }

You fixed a bug here since v5 (unbounded T). Please remember to put it in the change
log, it makes review easier.


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



