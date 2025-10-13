Return-Path: <linux-kernel+bounces-850969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E8FBD4D25
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E1803350CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E148D30F53B;
	Mon, 13 Oct 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3zQMnZT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975DB30EF96
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370882; cv=none; b=rmrZOkvgp1xpp8En/luhRGlD+/wawM5I49+77MjIXLpOO3CjynEB3yX9g3xOHL6ca6Xd1INZMShnWZHVeoFGDm6PWKUQLf0UQfwsTarEqFpyAc1RR3GoJO67Z+A10dGXT6tjJOXKBNxwXEBFsKwpAP2tRTM4LIKd7tFIpjmJNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370882; c=relaxed/simple;
	bh=vduko4sGUpP7pjMVck+KUjdVmIvmQ9r4zWWxZQSS4iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dU0NCDRFmaPNMInB10CHPsBtM2IUACNDljhI28RneGRKqLKUertdINinwgSMPGhPYs28pVmgi1+EBx5RlQ2WRqT1QJzdkI+tEwgrIr/SNl1sv/6jGyRBNUnU8uXYH0G8EcKII7CBVTP0q8pfvzxmMAd4WGb1b27QtjbHNTlsTJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i3zQMnZT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760370879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8oZkaOhh491/dt/LBPcIdZtDtOEojeqJg0p/jpHGuJg=;
	b=i3zQMnZT1b/2vwKq9sVLtOFlPJb49JDyBCkmdNfrSS9Y665YIRE1T6U5xtFCJWaId9XtJP
	w2WsQgr88f48JUgqZx5mv0txkyot3OGrbMGGht8fYMP0xSb+iPJztQJQuN3X6a+whBPpw5
	z1UyItgZhqJg+WFSvF8REncZYuy0R5Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-6wU7HW9KNG2nNODMD7Uq_Q-1; Mon,
 13 Oct 2025 11:54:36 -0400
X-MC-Unique: 6wU7HW9KNG2nNODMD7Uq_Q-1
X-Mimecast-MFC-AGG-ID: 6wU7HW9KNG2nNODMD7Uq_Q_1760370874
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 349E419560B7;
	Mon, 13 Oct 2025 15:54:34 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.81.1])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 663A43000382;
	Mon, 13 Oct 2025 15:54:31 +0000 (UTC)
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
Subject: [PATCH v13 10/17] rust: sync: Introduce lock::Backend::Context
Date: Mon, 13 Oct 2025 11:48:12 -0400
Message-ID: <20251013155205.2004838-11-lyude@redhat.com>
In-Reply-To: <20251013155205.2004838-1-lyude@redhat.com>
References: <20251013155205.2004838-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Now that we've introduced an `InterruptDisabled` token for marking
contexts in which IRQs are disabled, we can have a way to avoid
`SpinLockIrq` disabling interrupts if the interrupts have already been
disabled. Basically, a `SpinLockIrq` should work like a `SpinLock` if
interrupts are disabled. So a function:

	(&'a SpinLockIrq, &'a InterruptDisabled) -> Guard<'a, .., SpinLockBackend>

makes senses. Note that due to `Guard` and `InterruptDisabled` having the
same lifetime, interrupts cannot be enabled while the Guard exists.

Add a `lock_with()` interface for `Lock`, and an associate type of
`Backend` to describe the context.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

---
V10:
- Fix typos - Dirk

 rust/kernel/sync/lock.rs          | 12 +++++++++++-
 rust/kernel/sync/lock/mutex.rs    |  1 +
 rust/kernel/sync/lock/spinlock.rs |  4 +++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 27202beef90c8..ae42458bff1c0 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -44,6 +44,9 @@ pub unsafe trait Backend {
     /// [`unlock`]: Backend::unlock
     type GuardState;
 
+    /// The context which can be provided to acquire the lock with a different backend.
+    type Context<'a>;
+
     /// Initialises the lock.
     ///
     /// # Safety
@@ -163,8 +166,15 @@ pub unsafe fn from_raw<'a>(ptr: *mut B::State) -> &'a Self {
 }
 
 impl<T: ?Sized, B: Backend> Lock<T, B> {
+    /// Acquires the lock with the given context and gives the caller access to the data protected
+    /// by it.
+    pub fn lock_with<'a>(&'a self, _context: B::Context<'a>) -> Guard<'a, T, B> {
+        todo!()
+    }
+
     /// Acquires the lock and gives the caller access to the data protected by it.
-    pub fn lock(&self) -> Guard<'_, T, B> {
+    #[inline]
+    pub fn lock<'a>(&'a self) -> Guard<'a, T, B> {
         // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
         // that `init` was called.
         let state = unsafe { B::lock(self.state.get()) };
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 581cee7ab842a..be1e2e18cf42d 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -101,6 +101,7 @@ macro_rules! new_mutex {
 unsafe impl super::Backend for MutexBackend {
     type State = bindings::mutex;
     type GuardState = ();
+    type Context<'a> = ();
 
     unsafe fn init(
         ptr: *mut Self::State,
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 6e6d571acd90c..73a7ec554baac 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -3,7 +3,7 @@
 //! A kernel spinlock.
 //!
 //! This module allows Rust code to use the kernel's `spinlock_t`.
-use crate::prelude::*;
+use crate::{interrupt::LocalInterruptDisabled, prelude::*};
 
 /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
 ///
@@ -101,6 +101,7 @@ macro_rules! new_spinlock {
 unsafe impl super::Backend for SpinLockBackend {
     type State = bindings::spinlock_t;
     type GuardState = ();
+    type Context<'a> = ();
 
     unsafe fn init(
         ptr: *mut Self::State,
@@ -243,6 +244,7 @@ macro_rules! new_spinlock_irq {
 unsafe impl super::Backend for SpinLockIrqBackend {
     type State = bindings::spinlock_t;
     type GuardState = ();
+    type Context<'a> = &'a LocalInterruptDisabled;
 
     unsafe fn init(
         ptr: *mut Self::State,
-- 
2.51.0


