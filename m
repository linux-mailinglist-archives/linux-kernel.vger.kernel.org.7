Return-Path: <linux-kernel+bounces-790710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940C3B3AC0A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3DF580402
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220442C11C0;
	Thu, 28 Aug 2025 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Ep4rG9Vi"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C42BE657;
	Thu, 28 Aug 2025 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414397; cv=pass; b=k8s3qGnifhA/+6y7axArxTaVWt32wJb0wIpBfO+xoWEJtNF0BMFo2NTZiP4ysUubuHoHLj3Jrhq4QWqLdiz7A76heN+N0vJ4fxLn0K6miz/XKCyb5VL64+b3uSly2TPr0GJuUqDQg553KpCDT3qTb4wr9kvNjNdaf/35KJqbT2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414397; c=relaxed/simple;
	bh=WDRbJYm871uH+OrlgNlxMdnRAU5LMEkdNaazRPXmx6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PK1W3BvRtEkQ0XHxc5MkuBDHAkNLufXIRsr66YmcWdkDNLTfWc7afKy8mnRa3zWFnNOH58ANr+DUIh419lwDA/lcfMklR2eS7LjhHMORkdqGhUXRmQWQkwDTXd90hrURGbQktBKix3hZPCOvjgMwERUC8pisLMs5J8anzr2j7QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Ep4rG9Vi; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756414376; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kMEUC2W4vp+bF2QM0UYYfLsqd+YYDSILGHpcxp3bC7Xzqp4iyI7R2/BQHrOGBDBpYC8kVlOKt7tIjY9Xznnuh115FFJMW6fiXFeVF8pTvTeymAIz1b0f/MktdXPhendUuVU+lxaODX9BIoYJYHaL5q9z7cQx1RG6zef7Sv9MVco=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756414376; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PinYmgq8QkJDg0lGjMIO4YiGjSjM42rzhkNkyt4VEgM=; 
	b=bUc3byhpdyjmBTylR38KHVs0g4I1vFq1qi12R4t388dbsVm88+MYjFqpaP3P3NXD9EXqE8ecxwmKu/CnvyJ9N0hvTG47X6KAHrSJEQYHZrIXKCJ6qwzH7Abt3vxru9KlyX/9Ziss2rOTlhJIO53T3M/UZHKQqQeuW3mXMUkQ1iU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756414376;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=PinYmgq8QkJDg0lGjMIO4YiGjSjM42rzhkNkyt4VEgM=;
	b=Ep4rG9VikSsGgIYqFY+Hi14ETp9YWRsIg6F4q+u5aPqZRxcw0gTGtqc2TuBnHfoQ
	DDtsHk62UIHczcoREcoSEwy8AZGbPgsuPL+0ORZWJ+O+9yBBm/SVkf8lhcQagmgXr4s
	Kh+d2DEybiSWk9cxItOCExbIOquk0961uy2qHMbo=
Received: by mx.zohomail.com with SMTPS id 1756414373847768.3675238134108;
	Thu, 28 Aug 2025 13:52:53 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Thu, 28 Aug 2025 17:52:18 -0300
Subject: [PATCH v2 2/3] rust: lock: pin the inner data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-lock-t-when-t-is-pinned-v2-2-b067c4b93fd6@collabora.com>
References: <20250828-lock-t-when-t-is-pinned-v2-0-b067c4b93fd6@collabora.com>
In-Reply-To: <20250828-lock-t-when-t-is-pinned-v2-0-b067c4b93fd6@collabora.com>
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
X-ZohoMailClient: External

In preparation to support Lock<T> where T is pinned, the first thing that
needs to be done is to structurally pin the 'data' member. This switches
the 't' parameter in Lock<T>::new() to take in an impl PinInit<T> instead
of a plain T. This in turn uses the blanket implementation "impl PinInit<T>
for T".

Subsequent patches will touch on Guard<T>.

Link: https://github.com/Rust-for-Linux/linux/issues/1181
Suggested-by: Benno Lossin <lossin@kernel.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/sync/lock.rs | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index b482f34bf0ce817e70f7a0da93443f77dd19ea79..9242790d15dbf65d66518d060a8a777aac558cfc 100644
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


