Return-Path: <linux-kernel+bounces-899273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E08EC5741D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2CA3AECEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCA733EB1D;
	Thu, 13 Nov 2025 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vNGVUJfn"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87CC345CAC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034321; cv=none; b=Bckgps+z0UYUaYVABZ68Kz772CQ17NudN0pOjsdYxnZ848uf9pQYnPZqODzIsfWC65ET/XNSLhYglarCcYCSdrnDUkYBRcavG0wSRfg3tXxJ9uQGudQROMuVhuqGs3GJGLSM3Fk2wM/JGwFDqRyv6nApnnXYKAlPZOAb18UeFa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034321; c=relaxed/simple;
	bh=o97LNDCE8sRKWgvFmbhQgiJX2C/f0cT5IjvvMFvpiPw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LsyiMAxnASebtfDtO1ATGLFSB5M3XojJNqp+eSqqTUIfTVObs3oN3UIJb+jCF9QauOAvytz/dpmDWXblGWzpigEaI2oQeTbAY7AcP4uX0w4YA4uTHiPnpBVHXYDBKkdSSCMMd5Kv7miXSosvU8E4zyq+dlQaaF4hjgCno1KF2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vNGVUJfn; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4777885a071so4447955e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763034318; x=1763639118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lWqAqMJ+7iUYGNXIT9R0NKkBc66Uxkdz+Gl6CTrmWCY=;
        b=vNGVUJfnDo65CpcuBGgJMQKDjEPsA3YqR2qFBUAy+XXW2XfcxbJ2QYKklc3pSmCDvG
         i7j+5Ndvgg68tA/v7Rt0mf0PRN9XY5ntsi7pGe+sIv4ZRsewQkOUrvL4U9ZltbvgxRTP
         JEjvPBLY7p6rzkigIHdC6GktNLsnYk0+E1qv2CrWpVNCUK2ENAanW9bb2eZujveDg9UN
         9c/t9HLLz6ZnjX7RetX10hbEbJ5Q585oEaPXb7RtVIaNRSMmcOC3zQu+T/FB+R826e8W
         1gGg4I4KGCxvH5T7G89trTC9eblG894SukysvBz7pSVfUJFHYVk1soZknF7Hl+6br3Xf
         S2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763034318; x=1763639118;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWqAqMJ+7iUYGNXIT9R0NKkBc66Uxkdz+Gl6CTrmWCY=;
        b=mchI9XBEA2LSkK15HljjmZXKglr+uZjemLyyIBGnPHlm66QZNjSZeOClBnyvNEFB+R
         SrDJsDvHGs3Y6KMtDx5jYLNoEzx/a7BlVzq9aLmwaOVQ0VRfox3/KS+/0/nrzlB+1bfS
         aZwT/O3sp+gd3TYotYkaNNANeM2fHOvJGTN6wPlJGy3iHExDRgN+ue6YnZQWpnpo3gb+
         0fWiZYRG2Il6+FF68Ic4sFmwNDDGdfXE6gVWvdUwH6kx9qiCD/bs5n6p3GD9FkG4lbUJ
         WZ3Bz9bDI77G8mDf2YW00qgs+bBE+X745bikKfCOZPrKCvTA/lLHhJVC4J/5c060tvlr
         bEfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHwHG9UF3ClpOylTL/ik6ZvgTV8q9FG5fqPjOcdzYXtUFlEIIAqbhjTUKAnz17YCH1CA2Qv9xke/UZgTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK0YMg8Rm4+Mv+I6hmmGdnp+4PwRgE0zXTfexc11SO9BpP5ZWk
	42/i2RcI3DJfsoXyc5roLa/yBKdiPfGAb3QWIJI/FKbQVMZwUKGD8bg69u4oiuGSlMmJOrsPfUP
	gyel+E2Ci9b4PEQeMTA==
X-Google-Smtp-Source: AGHT+IGbY7eShC9/mUBzLML+9sBZdsrYqV7V7ymCzDINnPzuUZqVoguiehJENSBtb2LboX8MjAgwi4Ke94Rt6xQ=
X-Received: from wmcq1.prod.google.com ([2002:a05:600c:c101:b0:477:40c1:3e61])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a012:b0:46e:206a:78cc with SMTP id 5b1f17b1804b1-4778b9ceb3dmr30607885e9.28.1763034318040;
 Thu, 13 Nov 2025 03:45:18 -0800 (PST)
Date: Thu, 13 Nov 2025 11:45:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMLEFWkC/x2MQQqAIBAAvxJ7TmiNjPpKdLDcaim2UIpA/HvSa
 ZjDTIRAnilAX0Tw9HDgU7JgWcC8WVlJscsOutINItaK5WAhdZzzrm75MWGrjam17ToHObw8Lfz +02FM6QNcOoYWZAAAAA==
X-Change-Id: 20251113-inline-lock-unlock-b1726632a99d
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8449; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=o97LNDCE8sRKWgvFmbhQgiJX2C/f0cT5IjvvMFvpiPw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpFcTIR5U/E8Yxm0UreO6s8nFEFqd0ICg2F8/IV
 c1lGR32HsKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRXEyAAKCRAEWL7uWMY5
 RldCD/oCYwzweaIKBwrXf9O2qHpEH7ZEat8rcJRqlP7pjzTxfU0FabakSS6402bX7XttMObd2VE
 rgY3FYAJXAJzdzSU6WZDjl+kzBp/54S2Ko3eu57Tqk7AHN68bYjwYTmKMPB0CgZ9YowiCcIIvIC
 qhQulI+WHUOsrrVicWnWkF93hzBfbKvEVUI1cCRe7HNKL2IfwRBAFFKUwyFwWBKmRwAxc+6svfW
 zO3iNCYfEu7iut0Fb9lOrk/41oSkn3vaKOBvOc1e+/3HMKCrgtL7uHR8CpnhgXzPyokMS/gwQBf
 6B6AXcTjx1WGidIkekoM2b4CzpEgvQhOVBS8FgYzBWqQLAsGmieBJoTTYcIXC1K1LNW5fakAKaC
 Phg9/WeQlQCaM2KurP7T6hsR3PNPJx/3hLuqBcocSEoFHMnauUGLRanuaUlsjWezGHMSzhqec9T
 sme9TjT8JqdfM0FldUTNPdRyPpwqVVjMOT7kWog3M5AmL4cI8s3oEuoKaLrO6oBzTAv7HP3Nesr
 heBQK1Wo9jBdy/VPwT5RrAVs3GJvAtSFr/43PlPsvZKlbdAbvb7c82nIyq+Jwl9gAZEcpbabMUZ
 fgxonx1hcPhnM0w14xbo8c2dY1Wplkfn6MlX9iojS3OpWjwAWuz3f1gR+FyDxl5eaVJWEtlLjq2 8E1kNoyPu3zdzUA==
X-Mailer: b4 0.14.2
Message-ID: <20251113-inline-lock-unlock-v1-1-1b6e8c323bcf@google.com>
Subject: [PATCH] rust: sync: inline various lock related methods
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

While debugging a different issue [1], I inspected a rust_binder.ko file
and noticed the following relocation:

	R_AARCH64_CALL26	_RNvXNtNtNtCsdfZWD8DztAw_6kernel4sync4lock8spinlockNtB2_15SpinLockBackendNtB4_7Backend6unlock

This relocation (and a similar one for lock) occurred many times
throughout the module. That is not really useful because all this
function does is call spin_unlock(), so what we actually want here is
that a call to spin_unlock() dirctly is generated in favor of this
wrapper method.

Thus, mark these methods inline.

Link: https://lore.kernel.org/p/20251111-binder-fix-list-remove-v1-0-8ed14a0da63d@google.com
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/lock.rs          | 7 +++++++
 rust/kernel/sync/lock/global.rs   | 2 ++
 rust/kernel/sync/lock/mutex.rs    | 5 +++++
 rust/kernel/sync/lock/spinlock.rs | 5 +++++
 4 files changed, 19 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 27202beef90c88dda13c58bbea9e8d4ce8d314de..1544347c89d24e2b892686d84fb07a79c18e1307 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -151,6 +151,7 @@ impl<B: Backend> Lock<(), B> {
     /// the whole lifetime of `'a`.
     ///
     /// [`State`]: Backend::State
+    #[inline]
     pub unsafe fn from_raw<'a>(ptr: *mut B::State) -> &'a Self {
         // SAFETY:
         // - By the safety contract `ptr` must point to a valid initialised instance of `B::State`
@@ -164,6 +165,7 @@ pub unsafe fn from_raw<'a>(ptr: *mut B::State) -> &'a Self {
 
 impl<T: ?Sized, B: Backend> Lock<T, B> {
     /// Acquires the lock and gives the caller access to the data protected by it.
+    #[inline]
     pub fn lock(&self) -> Guard<'_, T, B> {
         // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
         // that `init` was called.
@@ -177,6 +179,7 @@ pub fn lock(&self) -> Guard<'_, T, B> {
     /// Returns a guard that can be used to access the data protected by the lock if successful.
     // `Option<T>` is not `#[must_use]` even if `T` is, thus the attribute is needed here.
     #[must_use = "if unused, the lock will be immediately unlocked"]
+    #[inline]
     pub fn try_lock(&self) -> Option<Guard<'_, T, B>> {
         // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
         // that `init` was called.
@@ -245,6 +248,7 @@ pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
 impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {
     type Target = T;
 
+    #[inline]
     fn deref(&self) -> &Self::Target {
         // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
         unsafe { &*self.lock.data.get() }
@@ -252,6 +256,7 @@ fn deref(&self) -> &Self::Target {
 }
 
 impl<T: ?Sized, B: Backend> core::ops::DerefMut for Guard<'_, T, B> {
+    #[inline]
     fn deref_mut(&mut self) -> &mut Self::Target {
         // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
         unsafe { &mut *self.lock.data.get() }
@@ -259,6 +264,7 @@ fn deref_mut(&mut self) -> &mut Self::Target {
 }
 
 impl<T: ?Sized, B: Backend> Drop for Guard<'_, T, B> {
+    #[inline]
     fn drop(&mut self) {
         // SAFETY: The caller owns the lock, so it is safe to unlock it.
         unsafe { B::unlock(self.lock.state.get(), &self.state) };
@@ -271,6 +277,7 @@ impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
     /// # Safety
     ///
     /// The caller must ensure that it owns the lock.
+    #[inline]
     pub unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
         // SAFETY: The caller can only hold the lock if `Backend::init` has already been called.
         unsafe { B::assert_is_held(lock.state.get()) };
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index d65f94b5caf2668586088417323496629492932f..f0d086be5a69610cba315c2f375a0a7814f686d6 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -77,6 +77,7 @@ pub unsafe fn init(&'static self) {
     }
 
     /// Lock this global lock.
+    #[inline]
     pub fn lock(&'static self) -> GlobalGuard<B> {
         GlobalGuard {
             inner: self.inner.lock(),
@@ -84,6 +85,7 @@ pub fn lock(&'static self) -> GlobalGuard<B> {
     }
 
     /// Try to lock this global lock.
+    #[inline]
     pub fn try_lock(&'static self) -> Option<GlobalGuard<B>> {
         Some(GlobalGuard {
             inner: self.inner.try_lock()?,
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 581cee7ab842ad62ec144e67138676c000a3f5e4..cda0203efefb9fcb32c7eab28721e8678ccec575 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -102,6 +102,7 @@ unsafe impl super::Backend for MutexBackend {
     type State = bindings::mutex;
     type GuardState = ();
 
+    #[inline]
     unsafe fn init(
         ptr: *mut Self::State,
         name: *const crate::ffi::c_char,
@@ -112,18 +113,21 @@ unsafe fn init(
         unsafe { bindings::__mutex_init(ptr, name, key) }
     }
 
+    #[inline]
     unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
         // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
         // memory, and that it has been initialised before.
         unsafe { bindings::mutex_lock(ptr) };
     }
 
+    #[inline]
     unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
         // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
         // caller is the owner of the mutex.
         unsafe { bindings::mutex_unlock(ptr) };
     }
 
+    #[inline]
     unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
         // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
         let result = unsafe { bindings::mutex_trylock(ptr) };
@@ -135,6 +139,7 @@ unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
         }
     }
 
+    #[inline]
     unsafe fn assert_is_held(ptr: *mut Self::State) {
         // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
         unsafe { bindings::mutex_assert_is_held(ptr) }
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index d7be38ccbdc7dc4d70caaed0e7088f59f65fc6d1..ef76fa07ca3a2b5e32e956e828be5b295da0bc28 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -101,6 +101,7 @@ unsafe impl super::Backend for SpinLockBackend {
     type State = bindings::spinlock_t;
     type GuardState = ();
 
+    #[inline]
     unsafe fn init(
         ptr: *mut Self::State,
         name: *const crate::ffi::c_char,
@@ -111,18 +112,21 @@ unsafe fn init(
         unsafe { bindings::__spin_lock_init(ptr, name, key) }
     }
 
+    #[inline]
     unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
         // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
         // memory, and that it has been initialised before.
         unsafe { bindings::spin_lock(ptr) }
     }
 
+    #[inline]
     unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
         // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
         // caller is the owner of the spinlock.
         unsafe { bindings::spin_unlock(ptr) }
     }
 
+    #[inline]
     unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
         // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
         let result = unsafe { bindings::spin_trylock(ptr) };
@@ -134,6 +138,7 @@ unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
         }
     }
 
+    #[inline]
     unsafe fn assert_is_held(ptr: *mut Self::State) {
         // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
         unsafe { bindings::spin_assert_is_held(ptr) }

---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251113-inline-lock-unlock-b1726632a99d

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


