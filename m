Return-Path: <linux-kernel+bounces-804309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9052EB471BF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3035835EC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF91A1CDFAC;
	Sat,  6 Sep 2025 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="gX5ZGY/V"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969C1C860B;
	Sat,  6 Sep 2025 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757171124; cv=pass; b=JwRr55fVV4q+lDE5iFvl3dKws+DH4XqeiKtGXhvEWlDdLvoE924fEOtmNHMwrRXXrVVmuMV/nK76KQ5lB9vto8WvwO8TUCju8LrsVxR311O5PPJ3QArhwi5bTI9TdvnTE07CtqoaZWWRj/TDWt1briMJ/J+597TSgwuGZnTZXQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757171124; c=relaxed/simple;
	bh=Eu+hIWLDs09hmPwF4k9e+OsiPtCXhzD6+wDoSe4wn0g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=k7Wl0USMcpxyHwXnIud132yEWvTDCaR/ncT+sfIsqJN9d2lkRRlDP0RxhRt8+9Pzb8y7NawJYOVFAOhZZZJa2ndjIKcfIbs/NHEvETP4Lgb+7L420ZctOqvYj9Yrkhbji9hzjH6wo//oVkN26JEz+lWo47WihAwIIfBlCah3jmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=gX5ZGY/V; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757171095; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AZk5Ue6NT88z/liCZtY/fm9daPn+2y7bTSvlHgAKKlbBMQruxQhRmEtXoJB4e8hSQFHodhK8qtiw2mtiSMRBReERO9DeUIiNlWN/JgUpa1hGeAv3plVPECmjj6yArIx03bVBqclU0YdR+1VtDDjsG1iHfqwp4ZMlnb7sr5ktN50=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757171095; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=m805r+yGMLHx9IRCaLcGsEYjWTQoHM4JGx6RfK0VXlo=; 
	b=GS1toMvr4F4WyhT3C+J7dW8XH89rklP4jG4QWsvgUfDiakyVa0xvo0BasDVC5SkK4J0+9bFbgXgZ1zXEyU4JF8tF0pfxTIfp4wyHFmzxO4u8u2TKG4KT/rlI3MZns+VqxcF18e50peFsmPntRUoVKMF51sB78nCmq8INgbmxvZc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757171095;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=m805r+yGMLHx9IRCaLcGsEYjWTQoHM4JGx6RfK0VXlo=;
	b=gX5ZGY/VcInLsVG+kIb/QtAErBSz9C5ympF1AQpiaR8QW0lGxe8O1tnpBiyiZjNS
	doGAfxs/wd+zC/VtruA8Zg2Bvi7YcivNk35TbWgJRM0qEeR1emmAcFEAHaQYrNMEEI3
	f9EyXVAI36hhvSZiX5geb86xJLNASkKCatgddxuE=
Received: by mx.zohomail.com with SMTPS id 1757171093349158.79188754233246;
	Sat, 6 Sep 2025 08:04:53 -0700 (PDT)
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
In-Reply-To: <20250906141310.2c29aa8e@nimda.home>
Date: Sat, 6 Sep 2025 12:04:34 -0300
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
Message-Id: <2B16DBF4-1F6C-4025-8373-5651867B7D49@collabora.com>
References: <20250903131313.4365-1-work@onurozkan.dev>
 <20250903131313.4365-7-work@onurozkan.dev>
 <6D30FEF7-07E7-4851-A7A2-76649AD0B217@collabora.com>
 <20250906141310.2c29aa8e@nimda.home>
To: Onur <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 6 Sep 2025, at 08:13, Onur <work@onurozkan.dev> wrote:
>=20
> On Fri, 5 Sep 2025 16:42:09 -0300
> Daniel Almeida <daniel.almeida@collabora.com> wrote:
>=20
>> Hi Onur,
>>=20
>>> On 3 Sep 2025, at 10:13, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>>>=20
>>> `ExecContext` is a helper built on top of ww_mutex
>>=20
>> Again, I wonder what people think about this particular name.
>>=20
>>> that provides a retrying interface for lock acquisition.
>>> When `EDEADLK` is hit, it drops all held locks, resets
>>> the acquire context and retries the given (by the user)
>>> locking algorithm until it succeeds.
>>>=20
>>> The API keeps track of acquired locks, cleans them up
>>> automatically and allows data access to the protected
>>> data through `with_locked()`. The `lock_all()` helper
>>> allows implementing multi-mutex algorithms in a simpler
>>> and less error-prone way while keeping the ww_mutex
>>> semantics.
>>>=20
>>=20
>> Great, this was exactly what I was looking for! :)
>>=20
>>> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
>>> ---
>>> rust/kernel/sync/lock/ww_mutex.rs      |   2 +
>>> rust/kernel/sync/lock/ww_mutex/exec.rs | 176
>>> +++++++++++++++++++++++++ 2 files changed, 178 insertions(+)
>>> create mode 100644 rust/kernel/sync/lock/ww_mutex/exec.rs
>>>=20
>>> diff --git a/rust/kernel/sync/lock/ww_mutex.rs
>>> b/rust/kernel/sync/lock/ww_mutex.rs index
>>> b415d6deae9b..7de6578513e5 100644 ---
>>> a/rust/kernel/sync/lock/ww_mutex.rs +++
>>> b/rust/kernel/sync/lock/ww_mutex.rs @@ -16,6 +16,8 @@
>>> use core::cell::UnsafeCell;
>>> use core::marker::PhantomData;
>>>=20
>>> +pub mod exec;
>>> +
>>> /// Create static [`WwClass`] instances.
>>> ///
>>> /// # Examples
>>> diff --git a/rust/kernel/sync/lock/ww_mutex/exec.rs
>>> b/rust/kernel/sync/lock/ww_mutex/exec.rs new file mode 100644
>>> index 000000000000..2f1fc540f0b8
>>> --- /dev/null
>>> +++ b/rust/kernel/sync/lock/ww_mutex/exec.rs
>>> @@ -0,0 +1,176 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! A high-level [`WwMutex`] execution helper.
>>> +//!
>>> +//! Provides a retrying lock mechanism on top of [`WwMutex`] and
>>> [`WwAcquireCtx`]. +//! It detects [`EDEADLK`] and handles it by
>>> rolling back and retrying the +//! user-supplied locking algorithm
>>> until success. +
>>> +use crate::prelude::*;
>>> +use crate::sync::lock::ww_mutex::{WwAcquireCtx, WwClass, WwMutex,
>>> WwMutexGuard}; +use core::ptr;
>>> +
>>> +/// High-level execution type for ww_mutex.
>>> +///
>>> +/// Tracks a series of locks acquired under a common
>>> [`WwAcquireCtx`]. +/// It ensures proper cleanup and retry
>>> mechanism on deadlocks and provides +/// type-safe access to locked
>>> data via [`with_locked`]. +///
>>> +/// Typical usage is through [`lock_all`], which retries a
>>> user-supplied +/// locking algorithm until it succeeds without
>>> deadlock. +pub struct ExecContext<'a> {
>>> +    class: &'a WwClass,
>>> +    acquire: Pin<KBox<WwAcquireCtx<'a>>>,
>>> +    taken: KVec<WwMutexGuard<'a, ()>>,
>>> +}
>>> +
>>> +impl<'a> Drop for ExecContext<'a> {
>>> +    fn drop(&mut self) {
>>> +        self.release_all_locks();
>>=20
>> If we move this to the acquire context, then we can do away with this
>> drop impl.
>>=20
>>> +    }
>>> +}
>>> +
>>> +impl<'a> ExecContext<'a> {
>>> +    /// Creates a new [`ExecContext`] for the given lock class.
>>> +    ///
>>> +    /// All locks taken through this context must belong to the
>>> same class.
>>> +    ///
>>> +    /// TODO: Add some safety mechanism to ensure classes are not
>>> different.
>>=20
>> core::ptr::eq()?
>>=20
>=20
> I was thinking more of a type-level mechanism to do ensure that.

Why?

>=20
>>> +    pub fn new(class: &'a WwClass) -> Result<Self> {
>>> +        Ok(Self {
>>> +            class,
>>> +            acquire: KBox::pin_init(WwAcquireCtx::new(class),
>>> GFP_KERNEL)?,
>>> +            taken: KVec::new(),
>>> +        })
>>> +    }
>>> +
>>> +    /// Attempts to lock a [`WwMutex`] and records the guard.
>>> +    ///
>>> +    /// Returns [`EDEADLK`] if lock ordering would cause a
>>> deadlock.
>>> +    pub fn lock<T>(&mut self, mutex: &'a WwMutex<'a, T>) ->
>>> Result<()> {
>>> +        let guard =3D self.acquire.lock(mutex)?;
>>> +        // SAFETY: Type is erased for storage. Actual access uses
>>> `with_locked`
>>> +        // which safely casts back.
>>=20
>> Why?
>>=20
>>> +        let erased: WwMutexGuard<'a, ()> =3D unsafe {
>>> core::mem::transmute(guard) };
>>=20
>> We should really try our very best to avoid transmuting things.
>>=20
>> Why can=E2=80=99t you store a KVec<MutexGuard<=E2=80=98a, T>>? Seems =
straightforward
>> if you add a T parameter to ExecContext.
>>=20
>> Also, someone correct me if I am wrong, but users can explicitly have
>> T be e.g.: KBox<dyn SomeTrait> if they want to.
>=20
> So it can run different types inside the same execution context (see
> test_with_different_input_type). If there isn't a use-case for this, I
> can change it into `T`.

That=E2=80=99s my point, you can have =E2=80=9Cdifferent T=E2=80=9D =
using T =3D KBox<dyn
SomeTrait> if you really want it. Of course that is not free, but it=E2=80=
=99s also
optional.

>=20
>>> +        self.taken.push(erased, GFP_KERNEL)?;
>>> +
>>> +        Ok(())
>>> +    }
>>> +
>>> +    /// Runs `locking_algorithm` until success with retrying on
>>> deadlock.
>>> +    ///
>>> +    /// `locking_algorithm` should attempt to acquire all needed
>>> locks.
>>> +    /// If [`EDEADLK`] is detected, this function will roll back,
>>> reset
>>> +    /// the context and retry automatically.
>>> +    ///
>>> +    /// Once all locks are acquired successfully,
>>> `on_all_locks_taken` is
>>> +    /// invoked for exclusive access to the locked values.
>>> Afterwards, all
>>> +    /// locks are released.
>>> +    ///
>>> +    /// # Example
>>> +    ///
>>> +    /// ```
>>> +    /// use kernel::alloc::KBox;
>>> +    /// use kernel::c_str;
>>> +    /// use kernel::prelude::*;
>>> +    /// use kernel::sync::Arc;
>>> +    /// use kernel::sync::lock::ww_mutex;
>>> +    /// use pin_init::stack_pin_init;
>>> +    ///
>>> +    /// stack_pin_init!(let class =3D
>>> ww_mutex::WwClass::new_wound_wait(c_str!("lock_all_example")));
>>> +    ///
>>> +    /// let mutex1 =3D Arc::pin_init(ww_mutex::WwMutex::new(0,
>>> &class), GFP_KERNEL)?;
>>> +    /// let mutex2 =3D Arc::pin_init(ww_mutex::WwMutex::new(0,
>>> &class), GFP_KERNEL)?;
>>> +    /// let mut ctx =3D
>>> KBox::pin_init(ww_mutex::exec::ExecContext::new(&class)?,
>>> GFP_KERNEL)?;
>>> +    ///
>>> +    /// ctx.lock_all(
>>> +    ///     |ctx| {
>>> +    ///         // Try to lock both mutexes.
>>> +    ///         ctx.lock(&mutex1)?;
>>> +    ///         ctx.lock(&mutex2)?;
>>> +    ///
>>> +    ///         Ok(())
>>> +    ///     },
>>> +    ///     |ctx| {
>>> +    ///         // Safely mutate both values while holding the
>>> locks.
>>> +    ///         ctx.with_locked(&mutex1, |v| *v +=3D 1)?;
>>> +    ///         ctx.with_locked(&mutex2, |v| *v +=3D 1)?;
>>> +    ///
>>> +    ///         Ok(())
>>> +    ///     },
>>> +    /// )?;
>>=20
>> Can you add intermediary variables to hold the closures, just for
>> extra clarity?
>>=20
>> i.e.:
>>=20
>> let locking_algorithm =3D =E2=80=A6;
>> let on_all_locks_taken =3D =E2=80=A6;
>>=20
>> This is of course identical, but it conveys the meaning just a bit
>> better.
>>=20
>=20
> Sure, I will do that in the following patch.
>=20
>>> +    ///
>>> +    /// # Ok::<(), Error>(())
>>> +    /// ```
>>> +    pub fn lock_all<T, Y, Z>(
>>> +        &mut self,
>>> +        mut locking_algorithm: T,
>>> +        mut on_all_locks_taken: Y,
>>> +    ) -> Result<Z>
>>> +    where
>>> +        T: FnMut(&mut ExecContext<'a>) -> Result<()>,
>>=20
>> Just =E2=80=9CResult=E2=80=9D.
>>=20
>>> +        Y: FnMut(&mut ExecContext<'a>) -> Result<Z>,
>>> +    {
>>> +        loop {
>>> +            match locking_algorithm(self) {
>>> +                Ok(()) =3D> {
>>> +                    // All locks in `locking_algorithm` succeeded.
>>> +                    // The user can now safely use them in
>>> `on_all_locks_taken`.
>>> +                    let res =3D on_all_locks_taken(self);
>>> +                    self.release_all_locks();
>>> +
>>> +                    return res;
>>> +                }
>>> +                Err(e) if e =3D=3D EDEADLK =3D> {
>>> +                    // Deadlock detected, retry from scratch.
>>> +                    self.cleanup_on_deadlock()?;
>>> +                    continue;
>>> +                }
>>> +                Err(e) =3D> {
>>> +                    return Err(e);
>>> +                }
>>> +            }
>>> +        }
>>> +    }
>>=20
>> This apparently looks ok.
>>=20
>>> +
>>> +    /// Executes `f` with a mutable reference to the data behind
>>> `mutex`.
>>> +    ///
>>> +    /// Fails with [`EINVAL`] if the mutex was not locked in this
>>> context.
>>> +    pub fn with_locked<T, Y>(
>>> +        &mut self,
>>> +        mutex: &'a WwMutex<'a, T>,
>>> +        f: impl FnOnce(&mut T) -> Y,
>>> +    ) -> Result<Y> {
>>> +        // Find the matching guard.
>>> +        for guard in &mut self.taken {
>>> +            if mutex.as_ptr() =3D=3D guard.mutex.as_ptr() {
>>=20
>> core::ptr::eq() ?
>>=20
>>> +                // SAFETY: We know this guard belongs to `mutex`
>>> and holds the lock.
>>> +                let typed =3D unsafe { &mut
>>> *ptr::from_mut(guard).cast::<WwMutexGuard<'a, T>>() };
>>> +                return Ok(f(&mut **typed));
>>=20
>> This doesn=E2=80=99t look good, but it will probably improve once we =
get rid
>> of the transmute.
>>=20
>> Also, can you find a comparable use-case for this in the C code?
>>=20
>=20
> I think there is no use case in C code that can be compared to what I
> was aiming for (the multi-type support in single context). I thought =
it
> was cool thing to have but I am not sure if it's really needed. :)

I=E2=80=99m not sure we need this, but it can always come later.


