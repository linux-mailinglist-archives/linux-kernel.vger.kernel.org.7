Return-Path: <linux-kernel+bounces-803054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B1EB459F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2BF5A85EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7AF2116E7;
	Fri,  5 Sep 2025 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLe9MdJC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE114D599;
	Fri,  5 Sep 2025 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080865; cv=none; b=hZxtJ/E+1vtjc1QG6I/2DxVKP8ZflzCcZCaCUuicechpRhjNXJLmKs9Wr5cS4bBPMa+omh3u1M47IcyrQcNRKUW5nwnUHYJFta2qSarEh99oZ4P4GpJ3rSgnBycW5pNWmuzS+FgwJvtxjYbFr8IJTVeA/GwS4ZnsQTCqYAF7rXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080865; c=relaxed/simple;
	bh=XJYeR1vMRPrhidXf4LWEzRXzk+3oKK02B8DIM7yIL0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OI7K8+7xn668Pg84z6+E1xSjjKPYrVSB2x8rqkYDDkkj7GRc4kxn3KkI3jQPucON3K5gvFU8CbMAtvsrKpnmgtCMukMP32y71GMxrBcosZkwBHLfRXjRkF3dssVrn9WXqwO8kjHF13WDNSxvncKdnXFtYWBP9vhESWSzfatgmBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLe9MdJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2CAC4CEF1;
	Fri,  5 Sep 2025 14:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757080865;
	bh=XJYeR1vMRPrhidXf4LWEzRXzk+3oKK02B8DIM7yIL0g=;
	h=From:To:Cc:Subject:Date:From;
	b=fLe9MdJC25o6uCUtbKqbiA2ZwS+Ha6/0k1EInFOUjg8eARkP8fCTQ23psp890tNYw
	 b9GonNquH0DdfBsCcwIIIAfLSwggTbJy8NsWt5w0wVCDUhmL6gNM5gsVbv4YhLbZjs
	 OU3SIO6gUQZuwGFtvZbEMrwOQ5neWys4tH1pfo6zHJP6B8WOE7kG0SJfy4Wn6zHp/q
	 En8hAiZB9QKHX+bSwjWoWOcz4yVfWNW2AlhAeEVEEXGpbboiKf/0Av8Dwxnktt5ETT
	 b0u9/+e0JMkatiDI5N5L1hg+Kofvnuj4/AgPaGLHtKp3IRvjpypWXXpq1aH+80d5Yt
	 Ghj6CP71WiquA==
From: Benno Lossin <lossin@kernel.org>
To: Benno Lossin <lossin@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Fiona Behrens <me@kloenk.dev>,
	Alban Kurti <kurti@invicto.ai>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: pin-init: add references to previously initialized fields
Date: Fri,  5 Sep 2025 16:00:46 +0200
Message-ID: <20250905140047.3325945-1-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After initializing a field in an initializer macro, create a variable
holding a reference that points at that field. The type is either
`Pin<&mut T>` or `&mut T` depending on the field's structural pinning
kind.

Link: https://github.com/Rust-for-Linux/pin-init/pull/83/commits/0f658594c39398f58cd5cb99a8141e370e225e74
Signed-off-by: Benno Lossin <lossin@kernel.org>
---
 rust/pin-init/src/macros.rs | 149 ++++++++++++++++++++++++++++--------
 1 file changed, 115 insertions(+), 34 deletions(-)

diff --git a/rust/pin-init/src/macros.rs b/rust/pin-init/src/macros.rs
index 9ced630737b8..1100c5a0b3de 100644
--- a/rust/pin-init/src/macros.rs
+++ b/rust/pin-init/src/macros.rs
@@ -988,38 +988,56 @@ fn drop(&mut self) {
         @pinned($($(#[$($p_attr:tt)*])* $pvis:vis $p_field:ident : $p_type:ty),* $(,)?),
         @not_pinned($($(#[$($attr:tt)*])* $fvis:vis $field:ident : $type:ty),* $(,)?),
     ) => {
-        // For every field, we create a projection function according to its projection type. If a
-        // field is structurally pinned, then it must be initialized via `PinInit`, if it is not
-        // structurally pinned, then it can be initialized via `Init`.
-        //
-        // The functions are `unsafe` to prevent accidentally calling them.
-        #[allow(dead_code)]
-        #[expect(clippy::missing_safety_doc)]
-        impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
-        where $($whr)*
-        {
-            $(
-                $(#[$($p_attr)*])*
-                $pvis unsafe fn $p_field<E>(
-                    self,
-                    slot: *mut $p_type,
-                    init: impl $crate::PinInit<$p_type, E>,
-                ) -> ::core::result::Result<(), E> {
-                    // SAFETY: TODO.
-                    unsafe { $crate::PinInit::__pinned_init(init, slot) }
-                }
-            )*
-            $(
-                $(#[$($attr)*])*
-                $fvis unsafe fn $field<E>(
-                    self,
-                    slot: *mut $type,
-                    init: impl $crate::Init<$type, E>,
-                ) -> ::core::result::Result<(), E> {
-                    // SAFETY: TODO.
-                    unsafe { $crate::Init::__init(init, slot) }
-                }
-            )*
+        $crate::macros::paste! {
+            // For every field, we create a projection function according to its projection type. If a
+            // field is structurally pinned, then it must be initialized via `PinInit`, if it is not
+            // structurally pinned, then it can be initialized via `Init`.
+            //
+            // The functions are `unsafe` to prevent accidentally calling them.
+            #[allow(dead_code)]
+            #[expect(clippy::missing_safety_doc)]
+            impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
+            where $($whr)*
+            {
+                $(
+                    $(#[$($p_attr)*])*
+                    $pvis unsafe fn $p_field<E>(
+                        self,
+                        slot: *mut $p_type,
+                        init: impl $crate::PinInit<$p_type, E>,
+                    ) -> ::core::result::Result<(), E> {
+                        // SAFETY: TODO.
+                        unsafe { $crate::PinInit::__pinned_init(init, slot) }
+                    }
+
+                    $(#[$($p_attr)*])*
+                    $pvis unsafe fn [<__project_ $p_field>]<'__slot>(
+                        self,
+                        slot: &'__slot mut $p_type,
+                    ) -> ::core::pin::Pin<&'__slot mut $p_type> {
+                        ::core::pin::Pin::new_unchecked(slot)
+                    }
+                )*
+                $(
+                    $(#[$($attr)*])*
+                    $fvis unsafe fn $field<E>(
+                        self,
+                        slot: *mut $type,
+                        init: impl $crate::Init<$type, E>,
+                    ) -> ::core::result::Result<(), E> {
+                        // SAFETY: TODO.
+                        unsafe { $crate::Init::__init(init, slot) }
+                    }
+
+                    $(#[$($attr)*])*
+                    $fvis unsafe fn [<__project_ $field>]<'__slot>(
+                        self,
+                        slot: &'__slot mut $type,
+                    ) -> &'__slot mut $type {
+                        slot
+                    }
+                )*
+            }
         }
     };
 }
@@ -1216,6 +1234,13 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
         // return when an error/panic occurs.
         // We also use the `data` to require the correct trait (`Init` or `PinInit`) for `$field`.
         unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), init)? };
+        // SAFETY:
+        // - the project function does the correct field projection,
+        // - the field has been initialized,
+        // - the reference is only valid until the end of the initializer.
+        #[allow(unused_variables)]
+        let $field = $crate::macros::paste!(unsafe { $data.[< __project_ $field >](&mut (*$slot).$field) });
+
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
@@ -1247,6 +1272,14 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
         // SAFETY: `slot` is valid, because we are inside of an initializer closure, we
         // return when an error/panic occurs.
         unsafe { $crate::Init::__init(init, ::core::ptr::addr_of_mut!((*$slot).$field))? };
+
+        // SAFETY:
+        // - the field is not structurally pinned, since the line above must compile,
+        // - the field has been initialized,
+        // - the reference is only valid until the end of the initializer.
+        #[allow(unused_variables)]
+        let $field = unsafe { &mut (*$slot).$field };
+
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
@@ -1265,7 +1298,48 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
             );
         }
     };
-    (init_slot($($use_data:ident)?):
+    (init_slot(): // No `use_data`, so all fields are not structurally pinned
+        @data($data:ident),
+        @slot($slot:ident),
+        @guards($($guards:ident,)*),
+        // Init by-value.
+        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
+    ) => {
+        {
+            $(let $field = $val;)?
+            // Initialize the field.
+            //
+            // SAFETY: The memory at `slot` is uninitialized.
+            unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
+        }
+
+        #[allow(unused_variables)]
+        // SAFETY:
+        // - the field is not structurally pinned, since no `use_data` was required to create this
+        //   initializer,
+        // - the field has been initialized,
+        // - the reference is only valid until the end of the initializer.
+        let $field = unsafe { &mut (*$slot).$field };
+
+        // Create the drop guard:
+        //
+        // We rely on macro hygiene to make it impossible for users to access this local variable.
+        // We use `paste!` to create new hygiene for `$field`.
+        $crate::macros::paste! {
+            // SAFETY: We forget the guard later when initialization has succeeded.
+            let [< __ $field _guard >] = unsafe {
+                $crate::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
+            };
+
+            $crate::__init_internal!(init_slot():
+                @data($data),
+                @slot($slot),
+                @guards([< __ $field _guard >], $($guards,)*),
+                @munch_fields($($rest)*),
+            );
+        }
+    };
+    (init_slot($use_data:ident):
         @data($data:ident),
         @slot($slot:ident),
         @guards($($guards:ident,)*),
@@ -1279,6 +1353,13 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
             // SAFETY: The memory at `slot` is uninitialized.
             unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
         }
+        // SAFETY:
+        // - the project function does the correct field projection,
+        // - the field has been initialized,
+        // - the reference is only valid until the end of the initializer.
+        #[allow(unused_variables)]
+        let $field = $crate::macros::paste!(unsafe { $data.[< __project_ $field >](&mut (*$slot).$field) });
+
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
@@ -1289,7 +1370,7 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
                 $crate::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
             };
 
-            $crate::__init_internal!(init_slot($($use_data)?):
+            $crate::__init_internal!(init_slot($use_data):
                 @data($data),
                 @slot($slot),
                 @guards([< __ $field _guard >], $($guards,)*),

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


