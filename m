Return-Path: <linux-kernel+bounces-751098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0681EB1653B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB7D54734F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A672DF3D9;
	Wed, 30 Jul 2025 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jcDi7oVG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396C82DECB9;
	Wed, 30 Jul 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895711; cv=none; b=teG5mQ6W47V1b01q/kSnZ7UacjQjYw1bm/BW3Zty/UigFbyYGVPiY0wvcBvXfqpPCzN4Y5ENcb+M0fLicyZr4TgrUpeDln/LDkkaeFIsxzAsUvqX3w07E1Blq71EQIA3ofvMCNTgSm0lKFO7j5Vl4/BTzJ/d3kzT7yCeKpkZ27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895711; c=relaxed/simple;
	bh=s+sx+hOclSZjyk1wL29+d+rxmeuUWcBNu0h4lfKEe88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uS7yUrjgHhc9T+s4waRnTUeK0zrKl0wV62nZ07z70iYL4dAmqjAJWtAkwhttg/A37ghtSsqJueCFVKngO+zngx14JeZ4aPGlwl7Di492xZmFphXUCY1/HEHRTHlfclECswxUCvJ15XiCbsKwakbsliUjD4qZ0R4lNZJElfr7LJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jcDi7oVG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753895707;
	bh=s+sx+hOclSZjyk1wL29+d+rxmeuUWcBNu0h4lfKEe88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jcDi7oVGc+WysbOnMe1u9dnWyB9WedNAZUKfLdGc9khdr0+XV48iUiYi8RPH0LQr8
	 65iQNijBMZu4/1gYTU9Kg+pofKT+s2snC4wo2ReyB0U/FQl6vezRztmPZ+sukDzndv
	 8fD7FM3IiXtZXEo9erBbnjuynDPXP70F90sa7figEsbi5KsLu/Omkp7fJpYI/05I9G
	 bzuSDB/SKWCkIZhNRbOIkMhJUhf6i3mjwU68kw6TOaxPYWpgfbnNVLM7neAFgPDojR
	 ELh9gl+5XRDxGApRCRNS/Epk+wW3TiCJdlIYjGGByb+8E+4tU0tUpVepYflf7C/DfY
	 /FjeHVsff0AYg==
Received: from [192.168.0.7] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E3B2017E130E;
	Wed, 30 Jul 2025 19:15:04 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 30 Jul 2025 14:14:44 -0300
Subject: [PATCH 1/3] rust: lock: pin the inner data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-lock-t-when-t-is-pinned-v1-1-1b97d5f28aa2@collabora.com>
References: <20250730-lock-t-when-t-is-pinned-v1-0-1b97d5f28aa2@collabora.com>
In-Reply-To: <20250730-lock-t-when-t-is-pinned-v1-0-1b97d5f28aa2@collabora.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

In preparation to support Lock<T> where T is pinned, the first thing that
needs to be done is to structurally pin the 'data' member. This switches
the 't' parameter in Lock<T>::new() to take in an impl PinInit<T> instead
of a plain T. This in turn uses the blanket implementation "impl PinInit<T>
for T".

Subsequent patches will touch on Guard<T>.

Link: https://github.com/Rust-for-Linux/linux/issues/1181
Suggested-by: Benno Lossin <lossin@kernel.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/sync/lock.rs | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index e82fa5be289c169b0c9cfe277e15988958563430..9715463cbab867a2cf59e75f03001d75e91bd7b6 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -11,7 +11,7 @@
     types::{NotThreadSafe, Opaque, ScopeGuard},
 };
 use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
-use pin_init::{pin_data, pin_init, PinInit};
+use pin_init::{pin_data, pin_init, PinInit, Wrapper};
 
 pub mod mutex;
 pub mod spinlock;
@@ -115,6 +115,7 @@ pub struct Lock<T: ?Sized, B: Backend> {
     _pin: PhantomPinned,
 
     /// The data protected by the lock.
+    #[pin]
     pub(crate) data: UnsafeCell<T>,
 }
 
@@ -127,9 +128,13 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
 
 impl<T, B: Backend> Lock<T, B> {
     /// Constructs a new lock initialiser.
-    pub fn new(t: T, name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
+    pub fn new(
+        t: impl PinInit<T>,
+        name: &'static CStr,
+        key: Pin<&'static LockClassKey>,
+    ) -> impl PinInit<Self> {
         pin_init!(Self {
-            data: UnsafeCell::new(t),
+            data <- UnsafeCell::pin_init(t),
             _pin: PhantomPinned,
             // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
             // static lifetimes so they live indefinitely.

-- 
2.50.1


