Return-Path: <linux-kernel+bounces-809916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA720B51376
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A570F3B6162
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D65431194C;
	Wed, 10 Sep 2025 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2ELCipT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839F24169D;
	Wed, 10 Sep 2025 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757498881; cv=none; b=GFZuLyIObq8LMx0ZqggUxOZP1ckBOeQ5ZijvCZ8Kww0U54lGdQCxaVdSy3uPL87rluotTtveeaZ5STb0qs6QGavSu0fd9RzMFX0FPtK1V62C6Ndk8X07M/CnxhRJ8NGVp+2+uptz6VBKjcsLwWXMyI9E4rSZ5x8r93JZk5bsAok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757498881; c=relaxed/simple;
	bh=SgY377TySytRn6FIO/rE2+aLA7x8CvZYrR5OUKT5s/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mO9cSJhUVmuw6McE5gRpkawRRZtporTbfaZLJemizGw4F2bdAUudWnCjdZKf6dJQHI1XpfWGooOaM+1oiStuGM5eIGVOp/QjWEhQM8foUYcLTlRQ/9So/004kCpbg4MqiWRzPu/VCo8pk41ZgniEi4zcf49ogMXCFqVqx5Kslis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2ELCipT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B1EC4CEF0;
	Wed, 10 Sep 2025 10:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757498880;
	bh=SgY377TySytRn6FIO/rE2+aLA7x8CvZYrR5OUKT5s/M=;
	h=From:To:Cc:Subject:Date:From;
	b=j2ELCipT1u5m8iD0vib9RNYRmxAf1Vb2HFxTmZ1bqSh4lnUBVqfcHNrwysi5dYFxZ
	 WR4UW1cCaw+i++Ed+nhYeN494sfsc6e6+zK9NFVPqo1RvSaIzhxdJXyDjojoPuW8K7
	 jI2j0oMU/4+07kDxiVi146JF0B9vXhAs/H/RPH/cxzcAi2atOfHg9We/ghZZvHAWfM
	 yB502zF5WapOR6WHT+UidHPlTz5RcqDqri/CBSnhgbrnKxNXX7RUh17LblQo15iBv4
	 6ZgQwZNSoqY0TSZkAT/hHntYOSPCdiKH952CeSz4r2KTnWVfH92BYCPqoYueT94B1M
	 W2t7pCg/zv1VA==
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
Subject: [PATCH v2] rust: pin-init: add `#[bind]` attribute to access previously initialized fields
Date: Wed, 10 Sep 2025 12:07:53 +0200
Message-ID: <20250910100755.2361281-1-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Assigning a field a value in an initializer macro can be marked with the
`#[bind]` attribute. Doing so creates a `let` binding with the same
name. This `let` binding has the type `Pin<&mut T>` if the field is
structurally pinned or `&mut T` otherwise (where `T` is the type of the
field).

Signed-off-by: Benno Lossin <lossin@kernel.org>
---
Changes from v1:
* require explicit annotation through `#[bind]` to create the let
  binding
* this removes the need to patch existing uses of initializer macros
---
 rust/pin-init/src/macros.rs | 181 ++++++++++++++++++++++++++++--------
 1 file changed, 142 insertions(+), 39 deletions(-)

diff --git a/rust/pin-init/src/macros.rs b/rust/pin-init/src/macros.rs
index 9ced630737b8..21798a9d195f 100644
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
@@ -1207,7 +1225,7 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
         @slot($slot:ident),
         @guards($($guards:ident,)*),
         // In-place initialization syntax.
-        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
+        @munch_fields($(#[$bind:ident])? $field:ident <- $val:expr, $($rest:tt)*),
     ) => {
         let init = $val;
         // Call the initializer.
@@ -1216,6 +1234,11 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
         // return when an error/panic occurs.
         // We also use the `data` to require the correct trait (`Init` or `PinInit`) for `$field`.
         unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), init)? };
+        $crate::__init_internal!(bind($(#[$bind])?):
+            @field($field),
+            @slot($slot),
+            @data($data),
+        );
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
@@ -1239,7 +1262,7 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
         @slot($slot:ident),
         @guards($($guards:ident,)*),
         // In-place initialization syntax.
-        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
+        @munch_fields($(#[$bind:ident])? $field:ident <- $val:expr, $($rest:tt)*),
     ) => {
         let init = $val;
         // Call the initializer.
@@ -1247,6 +1270,13 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
         // SAFETY: `slot` is valid, because we are inside of an initializer closure, we
         // return when an error/panic occurs.
         unsafe { $crate::Init::__init(init, ::core::ptr::addr_of_mut!((*$slot).$field))? };
+
+        $crate::__init_internal!(bind($(#[$bind])?):
+            @field($field),
+            @slot($slot),
+            @data(),
+        );
+
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
@@ -1265,12 +1295,51 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
             );
         }
     };
-    (init_slot($($use_data:ident)?):
+    (init_slot(): // No `use_data`, so all fields are not structurally pinned
+        @data($data:ident),
+        @slot($slot:ident),
+        @guards($($guards:ident,)*),
+        // Init by-value.
+        @munch_fields($(#[$bind:ident])? $field:ident $(: $val:expr)?, $($rest:tt)*),
+    ) => {
+        {
+            $(let $field = $val;)?
+            // Initialize the field.
+            //
+            // SAFETY: The memory at `slot` is uninitialized.
+            unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
+        }
+
+        $crate::__init_internal!(bind($(#[$bind])?):
+            @field($field),
+            @slot($slot),
+            @data(),
+        );
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
         // Init by-value.
-        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
+        @munch_fields($(#[$bind:ident])? $field:ident $(: $val:expr)?, $($rest:tt)*),
     ) => {
         {
             $(let $field = $val;)?
@@ -1279,6 +1348,12 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
             // SAFETY: The memory at `slot` is uninitialized.
             unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
         }
+        $crate::__init_internal!(bind($(#[$bind])?):
+            @field($field),
+            @slot($slot),
+            @data($data),
+        );
+
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
@@ -1289,7 +1364,7 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
                 $crate::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
             };
 
-            $crate::__init_internal!(init_slot($($use_data)?):
+            $crate::__init_internal!(init_slot($use_data):
                 @data($data),
                 @slot($slot),
                 @guards([< __ $field _guard >], $($guards,)*),
@@ -1297,6 +1372,34 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
             );
         }
     };
+    (bind(#[bind]):
+        @field($field:ident),
+        @slot($slot:ident),
+        @data($data:ident),
+    ) => {
+        // SAFETY:
+        // - the project function does the correct field projection,
+        // - the field has been initialized,
+        // - the reference is only valid until the end of the initializer.
+        let $field = $crate::macros::paste!(unsafe { $data.[< __project_ $field >](&mut (*$slot).$field) });
+    };
+    (bind(#[bind]):
+        @field($field:ident),
+        @slot($slot:ident),
+        @data(),
+    ) => {
+        // SAFETY:
+        // - the field is not structurally pinned, since no `use_data` was required to create this
+        //   initializer,
+        // - the field has been initialized,
+        // - the reference is only valid until the end of the initializer.
+        let $field = unsafe { &mut (*$slot).$field };
+    };
+    (bind():
+        @field($field:ident),
+        @slot($slot:ident),
+        @data($($data:ident)?),
+    ) => {};
     (make_initializer:
         @slot($slot:ident),
         @type_name($t:path),
@@ -1354,7 +1457,7 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
     (make_initializer:
         @slot($slot:ident),
         @type_name($t:path),
-        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
+        @munch_fields($(#[$bind:ident])? $field:ident <- $val:expr, $($rest:tt)*),
         @acc($($acc:tt)*),
     ) => {
         $crate::__init_internal!(make_initializer:
@@ -1367,7 +1470,7 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
     (make_initializer:
         @slot($slot:ident),
         @type_name($t:path),
-        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
+        @munch_fields($(#[$bind:ident])? $field:ident $(: $val:expr)?, $($rest:tt)*),
         @acc($($acc:tt)*),
     ) => {
         $crate::__init_internal!(make_initializer:

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


