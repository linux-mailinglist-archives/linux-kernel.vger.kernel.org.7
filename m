Return-Path: <linux-kernel+bounces-803434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E69B45FC0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A7D1886458
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44724313293;
	Fri,  5 Sep 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/JReImE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A0313288;
	Fri,  5 Sep 2025 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092341; cv=none; b=GI7199+P4OcOEivUOAQi8r3jEBa8aLYlPEKv20Fqk6dHMsz3QExv2FHxXYbtNKDBVP7df/V3ygRjLOzel8PT1IY4OZolGTq7VzcGUklWZWfFRoOIJix/+0lS67lnHgq/2FVRW8TXLRTzCO5H18NrEbL3rM7wVQu6QxTQLAKw0as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092341; c=relaxed/simple;
	bh=IFxTOOPIkWltB7RImBUO8KCn23J9LPZLVhwYnb4mcJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1AItTfOBHy84M3aGDMSn0Kp+POAc5bAp/KADUBkXu5WNUZasImcjVBKZDuHHXzKSGJ/1E0Zmwe4gu/6KdZWq9M69AdJJ3UD1+BXSK3lT5tOfATqxGIOpzvxmY8zmkZ4i1YmfjgMo0m2xe1SrgYxoRw9lCNhWUQ8LTa+A/dikCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/JReImE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9486DC4CEF7;
	Fri,  5 Sep 2025 17:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757092341;
	bh=IFxTOOPIkWltB7RImBUO8KCn23J9LPZLVhwYnb4mcJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/JReImEHbwT6D9rCn4txDYsUXZvuZNsJ0C4osO1jMylhG8tTe1wS5m/NVLfGWYen
	 l83aqMr3qeQRewdIukcrZw5VitGhrPNpbZuz88QsgBdp9KVCu2pMWBied+r6XnaRmE
	 jQzFyHP4l9I7Rqf3iuDgKbfcaFyzp2AnmeEtMfdYnmTFIeKNaxfQcdPPC8MAa8SNHP
	 JJ7S5+XeZ8eDo9yTlHDenGU1Mk4/Gt+z5Yb0dD5w5LYGagANk3oGp5JJFlbATurhGN
	 d442wBKrxc/YO6lCiuNQRoGStZIGbQirQCFkKGqG5QKLgg7vHgFCW9GgpHJG9Fn/uS
	 PS3jLPDQEnElQ==
From: Benno Lossin <lossin@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Alban Kurti <kurti@invicto.ai>,
	Fiona Behrens <me@kloenk.dev>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rust: pin-init: add pin projections to `#[pin_data]`
Date: Fri,  5 Sep 2025 19:12:07 +0200
Message-ID: <20250905171209.944599-2-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905171209.944599-1-lossin@kernel.org>
References: <20250905171209.944599-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the `#[pin_data]` macro generate a `*Projection` struct that holds
either `Pin<&mut Field>` or `&mut Field` for every field of the original
struct. Which version is chosen depends on weather there is a `#[pin]`
or not respectively. Access to this projected version is enabled through
generating `fn project(self: Pin<&mut Self>) -> SelfProjection<'_>`.

Link: https://github.com/Rust-for-Linux/pin-init/pull/75/commits/2d698367d646c7ede90e01aa22842c1002d017b3
[ Adapt workqueue to use the new projection instead of its own, custom
  one - Benno ]
Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/kernel/workqueue.rs    | 10 ++-----
 rust/pin-init/src/macros.rs | 60 +++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index b9343d5bc00f..6ca14c629643 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -356,18 +356,12 @@ struct ClosureWork<T> {
     func: Option<T>,
 }
 
-impl<T> ClosureWork<T> {
-    fn project(self: Pin<&mut Self>) -> &mut Option<T> {
-        // SAFETY: The `func` field is not structurally pinned.
-        unsafe { &mut self.get_unchecked_mut().func }
-    }
-}
-
 impl<T: FnOnce()> WorkItem for ClosureWork<T> {
     type Pointer = Pin<KBox<Self>>;
 
     fn run(mut this: Pin<KBox<Self>>) {
-        if let Some(func) = this.as_mut().project().take() {
+        if let Some(func) = this.as_mut().project().func.take() {
+            // if let Some(func) = this.as_mut().project_func().take() {
             (func)()
         }
     }
diff --git a/rust/pin-init/src/macros.rs b/rust/pin-init/src/macros.rs
index 9ced630737b8..d225cc144904 100644
--- a/rust/pin-init/src/macros.rs
+++ b/rust/pin-init/src/macros.rs
@@ -831,6 +831,17 @@ macro_rules! __pin_data {
             $($fields)*
         }
 
+        $crate::__pin_data!(make_pin_projections:
+            @vis($vis),
+            @name($name),
+            @impl_generics($($impl_generics)*),
+            @ty_generics($($ty_generics)*),
+            @decl_generics($($decl_generics)*),
+            @where($($whr)*),
+            @pinned($($pinned)*),
+            @not_pinned($($not_pinned)*),
+        );
+
         // We put the rest into this const item, because it then will not be accessible to anything
         // outside.
         const _: () = {
@@ -980,6 +991,55 @@ fn drop(&mut self) {
             stringify!($($rest)*),
         );
     };
+    (make_pin_projections:
+        @vis($vis:vis),
+        @name($name:ident),
+        @impl_generics($($impl_generics:tt)*),
+        @ty_generics($($ty_generics:tt)*),
+        @decl_generics($($decl_generics:tt)*),
+        @where($($whr:tt)*),
+        @pinned($($(#[$($p_attr:tt)*])* $pvis:vis $p_field:ident : $p_type:ty),* $(,)?),
+        @not_pinned($($(#[$($attr:tt)*])* $fvis:vis $field:ident : $type:ty),* $(,)?),
+    ) => {
+        $crate::macros::paste! {
+            #[doc(hidden)]
+            $vis struct [< $name Projection >] <'__pin, $($decl_generics)*> {
+                $($(#[$($p_attr)*])* $pvis $p_field : ::core::pin::Pin<&'__pin mut $p_type>,)*
+                $($(#[$($attr)*])* $fvis $field : &'__pin mut $type,)*
+                ___pin_phantom_data: ::core::marker::PhantomData<&'__pin mut ()>,
+            }
+
+            impl<$($impl_generics)*> $name<$($ty_generics)*>
+            where $($whr)*
+            {
+                /// Pin-projects all fields of `Self`.
+                ///
+                /// These fields are structurally pinned:
+                $(#[doc = ::core::concat!(" - `", ::core::stringify!($p_field), "`")])*
+                ///
+                /// These fields are **not** structurally pinned:
+                $(#[doc = ::core::concat!(" - `", ::core::stringify!($field), "`")])*
+                $vis fn project<'__pin>(
+                    self: ::core::pin::Pin<&'__pin mut Self>,
+                ) -> [< $name Projection >] <'__pin, $($ty_generics)*> {
+                    // SAFETY: we only give access to `&mut` for fields not structurally pinned.
+                    let this = unsafe { ::core::pin::Pin::get_unchecked_mut(self) };
+                    [< $name Projection >] {
+                        $(
+                            // SAFETY: `$p_field` is structurally pinned.
+                            $(#[$($p_attr)*])*
+                            $p_field : unsafe { ::core::pin::Pin::new_unchecked(&mut this.$p_field) },
+                        )*
+                        $(
+                            $(#[$($attr)*])*
+                            $field : &mut this.$field,
+                        )*
+                        ___pin_phantom_data: ::core::marker::PhantomData,
+                    }
+                }
+            }
+        }
+    };
     (make_pin_data:
         @pin_data($pin_data:ident),
         @impl_generics($($impl_generics:tt)*),
-- 
2.50.1


