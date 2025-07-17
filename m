Return-Path: <linux-kernel+bounces-735822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3D5B09434
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7373B5AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E17207DFE;
	Thu, 17 Jul 2025 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOddCMqJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D952080E8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777829; cv=none; b=AAq0I6fc8WgnGbiMOAr/pGVZvmvsNE64wFUj3OEFtDs7M1aKYZAOoP7shAE7AWnpl0/IFvAmQsnPtC3EB3wCb5jzEV2LNXfAAUMawiwMOVKVVRbjkGBOY/hZAeA+68pMEIoR0YXKvi20ej6B6c0qEInWFo+j2WILa6wO9cCBHf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777829; c=relaxed/simple;
	bh=01pi2INLPP1Z+uaaRur/9uZiC09dxQQF8pgxeaVKloo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLk2CyIPV49/4TuKQNtaw6ya5RIp8AwMXB5+CRzi+qp/wmK6pRKumNIAITiPMV/YmT3AJZW2SbojTG2eFG0inDxcObBO/mgPmF4wheTb7Ao9FQN5z507HM1SHcwy0XVIOZA65vut3FSh2osPuOuJxyct9IdhBEFVpPFpMYR6ZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QOddCMqJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752777827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7iebjM2Ivzslk0KPqnQKdrqVruOYg8Gy9xkQ0KiJiQ=;
	b=QOddCMqJKCMxvVLvpLklV/xyiafjZ6ToUbCZR6Ws3a/fqzaaOZ2Vm7TzMOOkT3HhYqGEge
	vdVRKQ977h5Ut64P5hYbOQb1y7+myT+z4hMHs0XR91vnfGiqwWZl7bDGfRTCXYM5p2j95n
	icTSahojl2E61eZWyOF77I3+HyPgDuM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-fYBS6SZFOLmdz4w6NzcFug-1; Thu,
 17 Jul 2025 14:43:42 -0400
X-MC-Unique: fYBS6SZFOLmdz4w6NzcFug-1
X-Mimecast-MFC-AGG-ID: fYBS6SZFOLmdz4w6NzcFug_1752777820
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 114791800878;
	Thu, 17 Jul 2025 18:43:40 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.66.69])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1079A18003FC;
	Thu, 17 Jul 2025 18:42:27 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v11 09/14] rust: sync: lock: Add `Backend::BackendInContext`
Date: Thu, 17 Jul 2025 14:38:01 -0400
Message-ID: <20250717184055.2071216-10-lyude@redhat.com>
In-Reply-To: <20250717184055.2071216-1-lyude@redhat.com>
References: <20250717184055.2071216-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Boqun Feng <boqun.feng@gmail.com>

`SpinLock`'s backend can be used for `SpinLockIrq`, if the interrupts are
disabled. And it actually provides performance gains since interrupts are
not needed to be disabled anymore. So add `Backend::BackendInContext` to
describe the case where one backend can be used for another. Use it to
implement the `lock_with()` so that `SpinLockIrq` can avoid disabling
interrupts by using `SpinLock`'s backend.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V10:
* Fix typos - Dirk/Lyude
* Since we're adding support for context locks to GlobalLock as well, let's
  also make sure to cover try_lock while we're at it and add try_lock_with
* Add a private function as_lock_in_context() for handling casting from a
  Lock<T, B> to Lock<T, B::BackendInContext> so we don't have to duplicate
  safety comments
V11:
* Fix clippy::ref_as_ptr error in Lock::as_lock_in_context()

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync/lock.rs          | 61 ++++++++++++++++++++++++++++++-
 rust/kernel/sync/lock/mutex.rs    |  1 +
 rust/kernel/sync/lock/spinlock.rs | 41 +++++++++++++++++++++
 3 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f94ed1a825f6d..7368c5ea824a6 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -30,10 +30,15 @@
 ///   is owned, that is, between calls to [`lock`] and [`unlock`].
 /// - Implementers must also ensure that [`relock`] uses the same locking method as the original
 ///   lock operation.
+/// - Implementers must ensure if [`BackendInContext`] is a [`Backend`], it's safe to acquire the
+///   lock under the [`Context`], the [`State`] of two backends must be the same.
 ///
 /// [`lock`]: Backend::lock
 /// [`unlock`]: Backend::unlock
 /// [`relock`]: Backend::relock
+/// [`BackendInContext`]: Backend::BackendInContext
+/// [`Context`]: Backend::Context
+/// [`State`]: Backend::State
 pub unsafe trait Backend {
     /// The state required by the lock.
     type State;
@@ -47,6 +52,9 @@ pub unsafe trait Backend {
     /// The context which can be provided to acquire the lock with a different backend.
     type Context<'a>;
 
+    /// The alternative backend we can use if a [`Context`](Backend::Context) is provided.
+    type BackendInContext: Sized;
+
     /// Initialises the lock.
     ///
     /// # Safety
@@ -166,10 +174,59 @@ pub unsafe fn from_raw<'a>(ptr: *mut B::State) -> &'a Self {
 }
 
 impl<T: ?Sized, B: Backend> Lock<T, B> {
+    /// Casts the lock as a `Lock<T, B::BackendInContext>`.
+    fn as_lock_in_context<'a>(
+        &'a self,
+        _context: B::Context<'a>,
+    ) -> &'a Lock<T, B::BackendInContext>
+    where
+        B::BackendInContext: Backend,
+    {
+        // SAFETY:
+        // - Per the safety guarantee of `Backend`, if `B::BackendInContext` and `B` should
+        //   have the same state, the layout of the lock is the same so it's safe to convert one to
+        //   another.
+        // - The caller provided `B::Context<'a>`, so it is safe to recast and return this lock.
+        unsafe { &*(core::ptr::from_ref(self) as *const _) }
+    }
+
     /// Acquires the lock with the given context and gives the caller access to the data protected
     /// by it.
-    pub fn lock_with<'a>(&'a self, _context: B::Context<'a>) -> Guard<'a, T, B> {
-        todo!()
+    pub fn lock_with<'a>(&'a self, context: B::Context<'a>) -> Guard<'a, T, B::BackendInContext>
+    where
+        B::BackendInContext: Backend,
+    {
+        let lock = self.as_lock_in_context(context);
+
+        // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
+        // that `init` was called. Plus the safety guarantee of `Backend` guarantees that `B::State`
+        // is the same as `B::BackendInContext::State`, also it's safe to call another backend
+        // because there is `B::Context<'a>`.
+        let state = unsafe { B::BackendInContext::lock(lock.state.get()) };
+
+        // SAFETY: The lock was just acquired.
+        unsafe { Guard::new(lock, state) }
+    }
+
+    /// Tries to acquire the lock with the given context.
+    ///
+    /// Returns a guard that can be used to access the data protected by the lock if successful.
+    pub fn try_lock_with<'a>(
+        &'a self,
+        context: B::Context<'a>,
+    ) -> Option<Guard<'a, T, B::BackendInContext>>
+    where
+        B::BackendInContext: Backend,
+    {
+        let lock = self.as_lock_in_context(context);
+
+        // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
+        // that `init` was called. Plus the safety guarantee of `Backend` guarantees that `B::State`
+        // is the same as `B::BackendInContext::State`, also it's safe to call another backend
+        // because there is `B::Context<'a>`.
+        unsafe {
+            B::BackendInContext::try_lock(lock.state.get()).map(|state| Guard::new(lock, state))
+        }
     }
 
     /// Acquires the lock and gives the caller access to the data protected by it.
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index be1e2e18cf42d..662a530750703 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -102,6 +102,7 @@ unsafe impl super::Backend for MutexBackend {
     type State = bindings::mutex;
     type GuardState = ();
     type Context<'a> = ();
+    type BackendInContext = ();
 
     unsafe fn init(
         ptr: *mut Self::State,
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 73a7ec554baac..68cbd225c3860 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -102,6 +102,7 @@ unsafe impl super::Backend for SpinLockBackend {
     type State = bindings::spinlock_t;
     type GuardState = ();
     type Context<'a> = ();
+    type BackendInContext = ();
 
     unsafe fn init(
         ptr: *mut Self::State,
@@ -221,6 +222,45 @@ macro_rules! new_spinlock_irq {
 /// # Ok::<(), Error>(())
 /// ```
 ///
+/// The next example demonstrates locking a [`SpinLockIrq`] using [`lock_with()`] in a function
+/// which can only be called when local processor interrupts are already disabled.
+///
+/// ```
+/// use kernel::sync::{new_spinlock_irq, SpinLockIrq};
+/// use kernel::interrupt::*;
+///
+/// struct Inner {
+///     a: u32,
+/// }
+///
+/// #[pin_data]
+/// struct Example {
+///     #[pin]
+///     inner: SpinLockIrq<Inner>,
+/// }
+///
+/// impl Example {
+///     fn new() -> impl PinInit<Self> {
+///         pin_init!(Self {
+///             inner <- new_spinlock_irq!(Inner { a: 20 }),
+///         })
+///     }
+/// }
+///
+/// // Accessing an `Example` from a function that can only be called in no-interrupt contexts.
+/// fn noirq_work(e: &Example, interrupt_disabled: &LocalInterruptDisabled) {
+///     // Because we know interrupts are disabled from interrupt_disable, we can skip toggling
+///     // interrupt state using lock_with() and the provided token
+///     assert_eq!(e.inner.lock_with(interrupt_disabled).a, 20);
+/// }
+///
+/// # let e = KBox::pin_init(Example::new(), GFP_KERNEL)?;
+/// # let interrupt_guard = local_interrupt_disable();
+/// # noirq_work(&e, &interrupt_guard);
+/// #
+/// # Ok::<(), Error>(())
+/// ```
+///
 /// [`lock()`]: SpinLockIrq::lock
 /// [`lock_with()`]: SpinLockIrq::lock_with
 pub type SpinLockIrq<T> = super::Lock<T, SpinLockIrqBackend>;
@@ -245,6 +285,7 @@ unsafe impl super::Backend for SpinLockIrqBackend {
     type State = bindings::spinlock_t;
     type GuardState = ();
     type Context<'a> = &'a LocalInterruptDisabled;
+    type BackendInContext = SpinLockBackend;
 
     unsafe fn init(
         ptr: *mut Self::State,
-- 
2.50.0


