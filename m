Return-Path: <linux-kernel+bounces-884795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D4AC312B6
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4974275D6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2B32EDD60;
	Tue,  4 Nov 2025 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwrtHff4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5462F7446;
	Tue,  4 Nov 2025 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261810; cv=none; b=eJXr6w2f9XSdbpSAgzFtK1f/rWy4Ybyp/M1pAheJLk7YV7ch2fI/LGQCoRJMiOnrZ871cIOubSd4uxRGsXoQXeDISPHNTFV44yU8rBIy1s95008YhJYXsY8mjGtAovMd2pwkgCDTUEVO0uUIZHNJS4x64c150SjUNK8HApQy3ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261810; c=relaxed/simple;
	bh=p14sODUXnnOpdTxi73+aY04rSHjs8Q9n6BTtPP0joeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e2PUA23IGIJ1N0BqJv/tjb3UQKpXII7FTQCifyeQ5+lsTxTHBn22I2YJ5x9sqkYNmTnNrAXBzMvbvvrhygpdCcEK4ziAImwtRUbGVXBjpk7tum/L0Lx+WvIUS7LKj+/WdxmyKhQ8qacWounq8WhDZ8r4hyXkP39K3CzreqbjsDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwrtHff4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7B7C116B1;
	Tue,  4 Nov 2025 13:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762261809;
	bh=p14sODUXnnOpdTxi73+aY04rSHjs8Q9n6BTtPP0joeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jwrtHff4kDk5a60SWz4y5uWl/Ak8YOLyBc+P1n90aQPgZRtyA00Rjvm9EvgiYh588
	 Y8YB3xjnzpRFI67zFY7UQbVEVtlHAdGLu8o9nMEL/bgRguu0a6XLA2ULCeS3n73EAP
	 eQ09o0IZwPC3x+3YpnETqBVrXy7vbJ8cZZpUkwe7i5ujFa5sZIprXd45uPjfq6nhJp
	 sGrQnIOYzNbewhARa63COXgSWQ559Fx4a1dYCdI8h/Wp3+GhEWnHFAyGHgamSZMNRL
	 RDw9p0RGMd5xHlefkGmBClVuP9BzwREe0bygIYOPLxbcEoGcSLQGDaVsBoSPzFeUtK
	 GI4///o1zG9jg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Almeida
 <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Mitchell
 Levy <levymitchell0@gmail.com>, Shankari Anand
 <shankari.ak0208@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v13 09/17] rust: sync: Add SpinLockIrq
In-Reply-To: <20251013155205.2004838-10-lyude@redhat.com>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-10-lyude@redhat.com>
Date: Tue, 04 Nov 2025 14:09:49 +0100
Message-ID: <87zf926j1e.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lyude Paul <lyude@redhat.com> writes:

> A variant of SpinLock that is expected to be used in noirq contexts, so
> lock() will disable interrupts and unlock() (i.e. `Guard::drop()` will
> undo the interrupt disable.
>
> [Boqun: Port to use spin_lock_irq_disable() and
> spin_unlock_irq_enable()]
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>
> ---
> V10:
> * Also add support to GlobalLock
> * Documentation fixes from Dirk
> V11:
> * Add unit test requested by Daniel Almeida
>
>  rust/kernel/sync.rs               |   4 +-
>  rust/kernel/sync/lock/global.rs   |   3 +
>  rust/kernel/sync/lock/spinlock.rs | 229 ++++++++++++++++++++++++++++++
>  3 files changed, 235 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index cf5b638a097d9..f293bbe13e855 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -26,7 +26,9 @@
>  pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
>  pub use lock::global::{global_lock, GlobalGuard, GlobalLock, GlobalLockBackend, GlobalLockedBy};
>  pub use lock::mutex::{new_mutex, Mutex, MutexGuard};
> -pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
> +pub use lock::spinlock::{
> +    new_spinlock, new_spinlock_irq, SpinLock, SpinLockGuard, SpinLockIrq, SpinLockIrqGuard,
> +};
>  pub use locked_by::LockedBy;
>  pub use refcount::Refcount;
>  
> diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
> index d65f94b5caf26..47e200b750c1d 100644
> --- a/rust/kernel/sync/lock/global.rs
> +++ b/rust/kernel/sync/lock/global.rs
> @@ -299,4 +299,7 @@ macro_rules! global_lock_inner {
>      (backend SpinLock) => {
>          $crate::sync::lock::spinlock::SpinLockBackend
>      };
> +    (backend SpinLockIrq) => {
> +        $crate::sync::lock::spinlock::SpinLockIrqBackend
> +    };
>  }
> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
> index d7be38ccbdc7d..6e6d571acd90c 100644
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -3,6 +3,7 @@
>  //! A kernel spinlock.
>  //!
>  //! This module allows Rust code to use the kernel's `spinlock_t`.
> +use crate::prelude::*;
>  
>  /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
>  ///
> @@ -139,3 +140,231 @@ unsafe fn assert_is_held(ptr: *mut Self::State) {
>          unsafe { bindings::spin_assert_is_held(ptr) }
>      }
>  }
> +
> +/// Creates a [`SpinLockIrq`] initialiser with the given name and a newly-created lock class.
> +///
> +/// It uses the name if one is given, otherwise it generates one based on the file name and line
> +/// number.
> +#[macro_export]
> +macro_rules! new_spinlock_irq {
> +    ($inner:expr $(, $name:literal)? $(,)?) => {
> +        $crate::sync::SpinLockIrq::new(
> +            $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
> +    };
> +}
> +pub use new_spinlock_irq;
> +
> +/// A spinlock that may be acquired when local processor interrupts are disabled.
> +///
> +/// This is a version of [`SpinLock`] that can only be used in contexts where interrupts for the
> +/// local CPU are disabled. It can be acquired in two ways:
> +///
> +/// - Using [`lock()`] like any other type of lock, in which case the bindings will modify the
> +///   interrupt state to ensure that local processor interrupts remain disabled for at least as long
> +///   as the [`SpinLockIrqGuard`] exists.
> +/// - Using [`lock_with()`] in contexts where a [`LocalInterruptDisabled`] token is present and
> +///   local processor interrupts are already known to be disabled, in which case the local interrupt
> +///   state will not be touched. This method should be preferred if a [`LocalInterruptDisabled`]
> +///   token is present in the scope.
> +///
> +/// For more info on spinlocks, see [`SpinLock`]. For more information on interrupts,
> +/// [see the interrupt module](kernel::interrupt).
> +///
> +/// # Examples
> +///
> +/// The following example shows how to declare, allocate initialise and access a struct (`Example`)
> +/// that contains an inner struct (`Inner`) that is protected by a spinlock that requires local
> +/// processor interrupts to be disabled.
> +///
> +/// ```
> +/// use kernel::sync::{new_spinlock_irq, SpinLockIrq};
> +///
> +/// struct Inner {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// #[pin_data]
> +/// struct Example {
> +///     #[pin]
> +///     c: SpinLockIrq<Inner>,
> +///     #[pin]
> +///     d: SpinLockIrq<Inner>,
> +/// }
> +///
> +/// impl Example {
> +///     fn new() -> impl PinInit<Self> {
> +///         pin_init!(Self {
> +///             c <- new_spinlock_irq!(Inner { a: 0, b: 10 }),
> +///             d <- new_spinlock_irq!(Inner { a: 20, b: 30 }),
> +///         })
> +///     }
> +/// }
> +///
> +/// // Allocate a boxed `Example`
> +/// let e = KBox::pin_init(Example::new(), GFP_KERNEL)?;
> +///
> +/// // Accessing an `Example` from a context where interrupts may not be disabled already.
> +/// let c_guard = e.c.lock(); // interrupts are disabled now, +1 interrupt disable refcount
> +/// let d_guard = e.d.lock(); // no interrupt state change, +1 interrupt disable refcount
> +///
> +/// assert_eq!(c_guard.a, 0);
> +/// assert_eq!(c_guard.b, 10);
> +/// assert_eq!(d_guard.a, 20);
> +/// assert_eq!(d_guard.b, 30);
> +///
> +/// drop(c_guard); // Dropping c_guard will not re-enable interrupts just yet, since d_guard is
> +///                // still in scope.
> +/// drop(d_guard); // Last interrupt disable reference dropped here, so interrupts are re-enabled
> +///                // now
> +/// # Ok::<(), Error>(())
> +/// ```
> +///
> +/// [`lock()`]: SpinLockIrq::lock
> +/// [`lock_with()`]: SpinLockIrq::lock_with
> +pub type SpinLockIrq<T> = super::Lock<T, SpinLockIrqBackend>;
> +
> +/// A kernel `spinlock_t` lock backend that is acquired in interrupt disabled contexts.

I would suggest rephrasing to "A kernel `spinlock_t` lock backend that can only be
acquired in interrupt disabled contexts.".

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Best regards,
Andreas Hindborg




