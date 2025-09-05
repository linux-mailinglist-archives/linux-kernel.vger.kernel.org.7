Return-Path: <linux-kernel+bounces-803694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DA9B463D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1873B4444
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03137281351;
	Fri,  5 Sep 2025 19:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="YYol3hGO"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9F613D539;
	Fri,  5 Sep 2025 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757101381; cv=pass; b=VBvGOcRjGiefhGAWW66rGfy5joENXovq4DNQ8+3SCzaAeHEwjpIjlE8njdqZkIj9wDECk5J4UMtaY08shAvyOAtQHqO76U8ZpPOqDgDfYS34t6AvjvmmB+RDywaHnavg5AS89am0WGQzZ/t+H27mqOdtC60A9DU1qICoF7X3ynU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757101381; c=relaxed/simple;
	bh=eTkDk+I/OKsADe2MIpR12aMPJSAbnJMYjX9dKyIZjkw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kwNP1fSJfe9gsR66IpBirL1cyxR2N1dvs0kRTwM/C0n08XEtQh+ZuFLQ4/fqVF0Xxw9zUkz4uy2ukLZU3Z3f8jBW4tKW3QU21jKa3XiHTIfjgvhrGidMBJHudYcsWXXTk47i/XD+r4ARvL/OJ3oLSzKHuUHsmta1HH9tp8K0TRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=YYol3hGO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757101350; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VFAR4NZkwck0nu+5baqJYzb/+J1rmtR/IpgsO+sJczmYaKadeurzFbmN5JjJGu5ukTU2z+7oa/pDY8JtxIKECZIPvUnZiYRIIU/h+nhW4RBrHdQHEvji/oOQKKEIzYNFycbjuIDH7EJX0q6sL2MdeMkYkuFfcxFVhcGom9NGdBY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757101350; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=K6Hy2lEwesd2Fo+prBdvk6dcBl3iKpawrLmZHQx7Zfg=; 
	b=A+HgTR01aF/7OlRqMYhGoVCsFxS3TaUakzJYWFA+PTyG5r460rQz8NJLwnhe06oE1VfTxvMlaz5mnakyai8TOOdnhRQNB9iDW/7L2q0lf9+VDOK2X2zA0dDm5cIz9HnwwQYZgGuWrxYP898HEqvITAD6hMTg6rFJYoWqBgs23d4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757101350;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=K6Hy2lEwesd2Fo+prBdvk6dcBl3iKpawrLmZHQx7Zfg=;
	b=YYol3hGOUXrpMjg+MT34Z3kpQduGfF+/y9KgroA+Cssoq6mBAcEuv1ahAdn3PE02
	04dfPlTOzetio8p55eKuBtECyK/K5G83gXxzieDUq4EWMFRS92NkxoK6ZzxKprLxE2u
	3Z/uMqbayJlSBTETAcYQSBf3giHyeDSgfsOf5jlo=
Received: by mx.zohomail.com with SMTPS id 1757101347383113.13212255591861;
	Fri, 5 Sep 2025 12:42:27 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 6/7] rust: ww_mutex/exec: add high-level API
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250903131313.4365-7-work@onurozkan.dev>
Date: Fri, 5 Sep 2025 16:42:09 -0300
Cc: rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lossin@kernel.org,
 lyude@redhat.com,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 dakr@kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 will@kernel.org,
 longman@redhat.com,
 felipe_life@live.com,
 daniel@sedlak.dev,
 bjorn3_gh@protonmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D30FEF7-07E7-4851-A7A2-76649AD0B217@collabora.com>
References: <20250903131313.4365-1-work@onurozkan.dev>
 <20250903131313.4365-7-work@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Onur,

> On 3 Sep 2025, at 10:13, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> `ExecContext` is a helper built on top of ww_mutex

Again, I wonder what people think about this particular name.

> that provides a retrying interface for lock acquisition.
> When `EDEADLK` is hit, it drops all held locks, resets
> the acquire context and retries the given (by the user)
> locking algorithm until it succeeds.
>=20
> The API keeps track of acquired locks, cleans them up
> automatically and allows data access to the protected
> data through `with_locked()`. The `lock_all()` helper
> allows implementing multi-mutex algorithms in a simpler
> and less error-prone way while keeping the ww_mutex
> semantics.
>=20

Great, this was exactly what I was looking for! :)

> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
> rust/kernel/sync/lock/ww_mutex.rs      |   2 +
> rust/kernel/sync/lock/ww_mutex/exec.rs | 176 +++++++++++++++++++++++++
> 2 files changed, 178 insertions(+)
> create mode 100644 rust/kernel/sync/lock/ww_mutex/exec.rs
>=20
> diff --git a/rust/kernel/sync/lock/ww_mutex.rs =
b/rust/kernel/sync/lock/ww_mutex.rs
> index b415d6deae9b..7de6578513e5 100644
> --- a/rust/kernel/sync/lock/ww_mutex.rs
> +++ b/rust/kernel/sync/lock/ww_mutex.rs
> @@ -16,6 +16,8 @@
> use core::cell::UnsafeCell;
> use core::marker::PhantomData;
>=20
> +pub mod exec;
> +
> /// Create static [`WwClass`] instances.
> ///
> /// # Examples
> diff --git a/rust/kernel/sync/lock/ww_mutex/exec.rs =
b/rust/kernel/sync/lock/ww_mutex/exec.rs
> new file mode 100644
> index 000000000000..2f1fc540f0b8
> --- /dev/null
> +++ b/rust/kernel/sync/lock/ww_mutex/exec.rs
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A high-level [`WwMutex`] execution helper.
> +//!
> +//! Provides a retrying lock mechanism on top of [`WwMutex`] and =
[`WwAcquireCtx`].
> +//! It detects [`EDEADLK`] and handles it by rolling back and =
retrying the
> +//! user-supplied locking algorithm until success.
> +
> +use crate::prelude::*;
> +use crate::sync::lock::ww_mutex::{WwAcquireCtx, WwClass, WwMutex, =
WwMutexGuard};
> +use core::ptr;
> +
> +/// High-level execution type for ww_mutex.
> +///
> +/// Tracks a series of locks acquired under a common =
[`WwAcquireCtx`].
> +/// It ensures proper cleanup and retry mechanism on deadlocks and =
provides
> +/// type-safe access to locked data via [`with_locked`].
> +///
> +/// Typical usage is through [`lock_all`], which retries a =
user-supplied
> +/// locking algorithm until it succeeds without deadlock.
> +pub struct ExecContext<'a> {
> +    class: &'a WwClass,
> +    acquire: Pin<KBox<WwAcquireCtx<'a>>>,
> +    taken: KVec<WwMutexGuard<'a, ()>>,
> +}
> +
> +impl<'a> Drop for ExecContext<'a> {
> +    fn drop(&mut self) {
> +        self.release_all_locks();

If we move this to the acquire context, then we can do away with this =
drop impl.

> +    }
> +}
> +
> +impl<'a> ExecContext<'a> {
> +    /// Creates a new [`ExecContext`] for the given lock class.
> +    ///
> +    /// All locks taken through this context must belong to the same =
class.
> +    ///
> +    /// TODO: Add some safety mechanism to ensure classes are not =
different.

core::ptr::eq()?

> +    pub fn new(class: &'a WwClass) -> Result<Self> {
> +        Ok(Self {
> +            class,
> +            acquire: KBox::pin_init(WwAcquireCtx::new(class), =
GFP_KERNEL)?,
> +            taken: KVec::new(),
> +        })
> +    }
> +
> +    /// Attempts to lock a [`WwMutex`] and records the guard.
> +    ///
> +    /// Returns [`EDEADLK`] if lock ordering would cause a deadlock.
> +    pub fn lock<T>(&mut self, mutex: &'a WwMutex<'a, T>) -> =
Result<()> {
> +        let guard =3D self.acquire.lock(mutex)?;
> +        // SAFETY: Type is erased for storage. Actual access uses =
`with_locked`
> +        // which safely casts back.

Why?

> +        let erased: WwMutexGuard<'a, ()> =3D unsafe { =
core::mem::transmute(guard) };

We should really try our very best to avoid transmuting things.

Why can=E2=80=99t you store a KVec<MutexGuard<=E2=80=98a, T>>? Seems =
straightforward if
you add a T parameter to ExecContext.

Also, someone correct me if I am wrong, but users can explicitly have T =
be
e.g.: KBox<dyn SomeTrait> if they want to.

> +        self.taken.push(erased, GFP_KERNEL)?;
> +
> +        Ok(())
> +    }
> +
> +    /// Runs `locking_algorithm` until success with retrying on =
deadlock.
> +    ///
> +    /// `locking_algorithm` should attempt to acquire all needed =
locks.
> +    /// If [`EDEADLK`] is detected, this function will roll back, =
reset
> +    /// the context and retry automatically.
> +    ///
> +    /// Once all locks are acquired successfully, =
`on_all_locks_taken` is
> +    /// invoked for exclusive access to the locked values. =
Afterwards, all
> +    /// locks are released.
> +    ///
> +    /// # Example
> +    ///
> +    /// ```
> +    /// use kernel::alloc::KBox;
> +    /// use kernel::c_str;
> +    /// use kernel::prelude::*;
> +    /// use kernel::sync::Arc;
> +    /// use kernel::sync::lock::ww_mutex;
> +    /// use pin_init::stack_pin_init;
> +    ///
> +    /// stack_pin_init!(let class =3D =
ww_mutex::WwClass::new_wound_wait(c_str!("lock_all_example")));
> +    ///
> +    /// let mutex1 =3D Arc::pin_init(ww_mutex::WwMutex::new(0, =
&class), GFP_KERNEL)?;
> +    /// let mutex2 =3D Arc::pin_init(ww_mutex::WwMutex::new(0, =
&class), GFP_KERNEL)?;
> +    /// let mut ctx =3D =
KBox::pin_init(ww_mutex::exec::ExecContext::new(&class)?, GFP_KERNEL)?;
> +    ///
> +    /// ctx.lock_all(
> +    ///     |ctx| {
> +    ///         // Try to lock both mutexes.
> +    ///         ctx.lock(&mutex1)?;
> +    ///         ctx.lock(&mutex2)?;
> +    ///
> +    ///         Ok(())
> +    ///     },
> +    ///     |ctx| {
> +    ///         // Safely mutate both values while holding the locks.
> +    ///         ctx.with_locked(&mutex1, |v| *v +=3D 1)?;
> +    ///         ctx.with_locked(&mutex2, |v| *v +=3D 1)?;
> +    ///
> +    ///         Ok(())
> +    ///     },
> +    /// )?;

Can you add intermediary variables to hold the closures, just for extra =
clarity?

i.e.:

let locking_algorithm =3D =E2=80=A6;
let on_all_locks_taken =3D =E2=80=A6;

This is of course identical, but it conveys the meaning just a bit =
better.

> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn lock_all<T, Y, Z>(
> +        &mut self,
> +        mut locking_algorithm: T,
> +        mut on_all_locks_taken: Y,
> +    ) -> Result<Z>
> +    where
> +        T: FnMut(&mut ExecContext<'a>) -> Result<()>,

Just =E2=80=9CResult=E2=80=9D.

> +        Y: FnMut(&mut ExecContext<'a>) -> Result<Z>,
> +    {
> +        loop {
> +            match locking_algorithm(self) {
> +                Ok(()) =3D> {
> +                    // All locks in `locking_algorithm` succeeded.
> +                    // The user can now safely use them in =
`on_all_locks_taken`.
> +                    let res =3D on_all_locks_taken(self);
> +                    self.release_all_locks();
> +
> +                    return res;
> +                }
> +                Err(e) if e =3D=3D EDEADLK =3D> {
> +                    // Deadlock detected, retry from scratch.
> +                    self.cleanup_on_deadlock()?;
> +                    continue;
> +                }
> +                Err(e) =3D> {
> +                    return Err(e);
> +                }
> +            }
> +        }
> +    }

This apparently looks ok.

> +
> +    /// Executes `f` with a mutable reference to the data behind =
`mutex`.
> +    ///
> +    /// Fails with [`EINVAL`] if the mutex was not locked in this =
context.
> +    pub fn with_locked<T, Y>(
> +        &mut self,
> +        mutex: &'a WwMutex<'a, T>,
> +        f: impl FnOnce(&mut T) -> Y,
> +    ) -> Result<Y> {
> +        // Find the matching guard.
> +        for guard in &mut self.taken {
> +            if mutex.as_ptr() =3D=3D guard.mutex.as_ptr() {

core::ptr::eq() ?

> +                // SAFETY: We know this guard belongs to `mutex` and =
holds the lock.
> +                let typed =3D unsafe { &mut =
*ptr::from_mut(guard).cast::<WwMutexGuard<'a, T>>() };
> +                return Ok(f(&mut **typed));

This doesn=E2=80=99t look good, but it will probably improve once we get =
rid of the transmute.

 Also, can you find a comparable use-case for this in the C code?

> +            }
> +        }
> +
> +        // `mutex` isn't locked in this `ExecContext`.
> +        Err(EINVAL)
> +    }
> +
> +    /// Releases all currently held locks in this context.
> +    ///
> +    /// It is intended to be used for internal implementation only.
> +    fn release_all_locks(&mut self) {
> +        self.taken.clear();
> +    }
> +
> +    /// Resets this context after a deadlock detection.
> +    ///
> +    /// Drops all held locks and reinitializes the [`WwAcquireCtx`].
> +    ///
> +    /// It is intended to be used for internal implementation only.

^ This last line can go away as this is private.

> +    fn cleanup_on_deadlock(&mut self) -> Result {
> +        self.release_all_locks();
> +        // Re-init fresh `WwAcquireCtx`.
> +        self.acquire =3D =
KBox::pin_init(WwAcquireCtx::new(self.class), GFP_KERNEL)?;

This will require one allocation per rollback.

> +
> +        Ok(())
> +    }
> +}
> --
> 2.50.0
>=20


