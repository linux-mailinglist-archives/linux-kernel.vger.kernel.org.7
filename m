Return-Path: <linux-kernel+bounces-809008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC63CB50766
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67CD1C658FD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7D63570C2;
	Tue,  9 Sep 2025 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="V9zZrVHK"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A31F78F54;
	Tue,  9 Sep 2025 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450865; cv=pass; b=DRGN0XDmdgDEVMTqXbZuaM5mA9Ojr9t2AKmuZEjcjaZLYdTh/H97v0SqoyM7tyOCSyOW9byy1h1UW4Xh/BknZaWyTaikmQ8W/ZLCe2T7DN9LodE/sMWI/8XpfaHs9hgU357+eSKIrkHs6hV4byQaPCVk4wjmQKHNifpswaGuM6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450865; c=relaxed/simple;
	bh=Qa2ll3BVVpB5aAIg+ho61m4eACb5NpV0z/JSHo8TlGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fXdgLhU+l8FsnvMabm+DmjY/igaPHgsUDCo4gvziU7SuSJ+KJx76PpMgcEF5iTm+Yt/L25JwIRGFfwotUCssUZktCGdZQJsK3ed3ca3bVeclcjqPmIB27IbMKd1PdK+Jny2tj1bCd/mVRcyZv7Ai+7//H8e40ZT97LnP4lxI0aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=V9zZrVHK; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757450848; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KEsmyRKlprPk5xfmi+YpO23FTskByoyUCZ4j4WI2vij4L6nbHTWMhTv42yzp8RSR4ojit5m1iVbVmEG51fRg8nMxWVJ1nGDT7Z1PriUyCGVaJZUM+1sbJE3HblhDoiX2gx6+rzFOj6WYXJ3gEGJKuM6JWjunGZ3GIm+++jv2Iag=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757450848; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TWs+/bHrT8S1EcXwM/Qh1rN2SkCFsPpL2DGXvSv40UQ=; 
	b=YFkC08YvKmw8bhLXZgrhT8A7jBrMBmL4C+qg3eiSLFc7VkkO6oXxFJ6/Cd++XIADw6pOKt/Ft23fq/bHRsudazzOFGHvMf8wmjBRwsW1jKnXu+2XE+OusWpHjTb+JqQgzTKtth1s1teILR85QSKY8K2MNcAgfC52U57C76sDBr0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757450848;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=TWs+/bHrT8S1EcXwM/Qh1rN2SkCFsPpL2DGXvSv40UQ=;
	b=V9zZrVHKH3E9Ip5I1sialc93dyk91YzmGXLHnDQxFOwZ8iUhzjWczFK36XMdrBi5
	RmErTaJ7LxBuOm/5RjQklq2O+8KKfUeiPRrBtHWUMmsfX/2sf6yHOhpprfC6v0rzbyk
	pGiha24wUZ0YzPOoF+dVCbtc4shshAJFWRU8ZYFM=
Received: by mx.zohomail.com with SMTPS id 1757450847036149.5317195361498;
	Tue, 9 Sep 2025 13:47:27 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 09 Sep 2025 17:46:55 -0300
Subject: [PATCH] rust: irq: request: touch up the documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-irq-andreas-fixes-v1-1-dbc9aafed2cb@collabora.com>
X-B4-Tracking: v=1; b=H4sIAD6SwGgC/x3LSwqAMAwA0atI1gbqj1qvIi6qjZpN1QREKN7d4
 vIxTAIlYVIYigRCNysfMaMqC1h2HzdCDtlQm7ozzjhkudDHIOQVV35IsbW26Rq7hLmvIH+n0B/
 yNk7v+wESP84YYwAAAA==
X-Change-ID: 20250909-irq-andreas-fixes-4773537cdb81
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

Parts of the documentation are either unclear or misplaced and can
otherwise be improved. This commit fixes them.

This is specially important in the context of the safety requirements of
functions or type invariants, as users have to uphold the former and may
rely on the latter, so we should avoid anything that may create
confusion.

Suggested-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/irq/request.rs | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
index b150563fdef809899c7ca39221c4928238e31110..a1d0e934972fa555968dba5731077cb11606a0d3 100644
--- a/rust/kernel/irq/request.rs
+++ b/rust/kernel/irq/request.rs
@@ -30,6 +30,11 @@ pub enum IrqReturn {
 pub trait Handler: Sync {
     /// The hard IRQ handler.
     ///
+    /// A "hard" handler in the context of the Linux kernel is the part of an
+    /// interrupt handler that runs in interrupt context. The hard handler
+    /// usually defers time consuming processing to run in process context, for
+    /// instance by queuing the work on a work queue for later execution.
+    ///
     /// This is executed in interrupt context, hence all corresponding
     /// limitations do apply.
     ///
@@ -54,9 +59,7 @@ fn handle(&self, device: &Device<Bound>) -> IrqReturn {
 /// # Invariants
 ///
 /// - `self.irq` is the same as the one passed to `request_{threaded}_irq`.
-/// - `cookie` was passed to `request_{threaded}_irq` as the cookie. It is guaranteed to be unique
-///   by the type system, since each call to `new` will return a different instance of
-///   `Registration`.
+/// - `cookie` is unique.
 #[pin_data(PinnedDrop)]
 struct RegistrationInner {
     irq: u32,
@@ -91,7 +94,9 @@ fn drop(self: Pin<&mut Self>) {
 // concurrent access.
 unsafe impl Sync for RegistrationInner {}
 
-// SAFETY: It is safe to send `RegistrationInner` across threads.
+// SAFETY: It is safe to transfer ownership of `RegistrationInner` from another
+// thread, because it has no shared mutable state. The IRQ owned by
+// `RegistrationInner` via `cookie` can be dropped from any thread.
 unsafe impl Send for RegistrationInner {}
 
 /// A request for an IRQ line for a given device.
@@ -112,7 +117,7 @@ impl<'a> IrqRequest<'a> {
     ///
     /// - `irq` should be a valid IRQ number for `dev`.
     pub(crate) unsafe fn new(dev: &'a Device<Bound>, irq: u32) -> Self {
-        // INVARIANT: `irq` is a valid IRQ number for `dev`.
+        // By function safety requirement, irq` is a valid IRQ number for `dev`.
         IrqRequest { dev, irq }
     }
 
@@ -183,6 +188,8 @@ pub fn irq(&self) -> u32 {
 /// * We own an irq handler whose cookie is a pointer to `Self`.
 #[pin_data]
 pub struct Registration<T: Handler + 'static> {
+    /// We need to drop inner before handler, as we must ensure that the handler
+    /// is valid until `free_irq` is called.
     #[pin]
     inner: Devres<RegistrationInner>,
 
@@ -196,7 +203,8 @@ pub struct Registration<T: Handler + 'static> {
 }
 
 impl<T: Handler + 'static> Registration<T> {
-    /// Registers the IRQ handler with the system for the given IRQ number.
+    /// Registers the IRQ handler with the system for the IRQ number represented
+    /// by `request`.
     pub fn new<'a>(
         request: IrqRequest<'a>,
         flags: Flags,
@@ -208,7 +216,11 @@ pub fn new<'a>(
             inner <- Devres::new(
                 request.dev,
                 try_pin_init!(RegistrationInner {
-                    // INVARIANT: `this` is a valid pointer to the `Registration` instance
+                    // INVARIANT: `this` is a valid pointer to the `Registration` instance.
+                    // INVARIANT: `cookie` is being passed to `request_irq` as
+                    // the cookie. It is guaranteed to be unique by the type
+                    // system, since each call to `new` will return a different
+                    // instance of `Registration`.
                     cookie: this.as_ptr().cast::<c_void>(),
                     irq: {
                         // SAFETY:
@@ -260,7 +272,8 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
 
 /// # Safety
 ///
-/// This function should be only used as the callback in `request_irq`.
+/// - This function should be only used as the callback in `request_irq`.
+/// - `ptr` must be valid for use as a reference to `T`
 unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *mut c_void) -> c_uint {
     // SAFETY: `ptr` is a pointer to `Registration<T>` set in `Registration::new`
     let registration = unsafe { &*(ptr as *const Registration<T>) };
@@ -288,6 +301,11 @@ pub enum ThreadedIrqReturn {
 pub trait ThreadedHandler: Sync {
     /// The hard IRQ handler.
     ///
+    /// A "hard" handler in the context of the Linux kernel is the part of an
+    /// interrupt handler that runs in interrupt context. The hard handler
+    /// usually defers time consuming processing to run in process context, for
+    /// instance by queuing the work on a work queue for later execution.
+    ///
     /// This is executed in interrupt context, hence all corresponding
     /// limitations do apply. All work that does not necessarily need to be
     /// executed from interrupt context, should be deferred to the threaded
@@ -427,6 +445,10 @@ pub fn new<'a>(
                 request.dev,
                 try_pin_init!(RegistrationInner {
                     // INVARIANT: `this` is a valid pointer to the `ThreadedRegistration` instance.
+                    // INVARIANT: `cookie` is being passed to
+                    // `request_threaded_irq` as the cookie. It is guaranteed to
+                    // be unique by the type system, since each call to `new`
+                    // will return a different instance of `Registration`.
                     cookie: this.as_ptr().cast::<c_void>(),
                     irq: {
                         // SAFETY:
@@ -479,7 +501,8 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
 
 /// # Safety
 ///
-/// This function should be only used as the callback in `request_threaded_irq`.
+/// - This function should be only used as the callback in `request_threaded_irq`.
+/// - `ptr` must be valid for use as a reference to `T`
 unsafe extern "C" fn handle_threaded_irq_callback<T: ThreadedHandler>(
     _irq: i32,
     ptr: *mut c_void,
@@ -495,7 +518,8 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> Result {
 
 /// # Safety
 ///
-/// This function should be only used as the callback in `request_threaded_irq`.
+/// - This function should be only used as the callback in `request_threaded_irq`.
+/// - `ptr` must be valid for use as a reference to `T`
 unsafe extern "C" fn thread_fn_callback<T: ThreadedHandler>(_irq: i32, ptr: *mut c_void) -> c_uint {
     // SAFETY: `ptr` is a pointer to `ThreadedRegistration<T>` set in `ThreadedRegistration::new`
     let registration = unsafe { &*(ptr as *const ThreadedRegistration<T>) };

---
base-commit: 4c48aed6dfcd32ea23e52adc1072405a62facf46
change-id: 20250909-irq-andreas-fixes-4773537cdb81

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


