Return-Path: <linux-kernel+bounces-883957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C4EC2EE97
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 03:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976D1189413C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 02:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B565F23A58E;
	Tue,  4 Nov 2025 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b="YAD1qoUR"
Received: from sg-1-23.ptr.blmpb.com (sg-1-23.ptr.blmpb.com [118.26.132.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD51D7995
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 02:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762221880; cv=none; b=cJZQo8AfXTENV9OX4mifERXkoY4SqZkNrcXyhxvwulx4YMEsVUmZ8G2x6eqXuc5FAevgfti1gsorAb8HgiVhWmMBG/FOVlWDMgLt/Fd/97AZYV/idIkz+GlyNLgmbUrDBySYfaAhpzGhfAbDqMZR/JvT5nP0c3HAQVwuc1KoBts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762221880; c=relaxed/simple;
	bh=3dHXHFYNyWdBrj3QM1sPWTu1d7dOjFuM0sBqiRWqc84=;
	h=Subject:Date:Message-Id:Mime-Version:To:Content-Type:Cc:From; b=UMeUgsXNfF4vffXN21H7e3UC+LChddXpozBA747/cOF8kJcrxrUGHsfyXsV9UcLIfVydjY3rBeIjan3dZ7epHcEcEiCWBMD3mIequvWHpGdUor6m8vW1XNnk2TxUvTvwxg4K1MWgXTrr8OQHnVADF4mCmcyVaJL/QhEY1oBgZHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club; spf=pass smtp.mailfrom=openatom.club; dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b=YAD1qoUR; arc=none smtp.client-ip=118.26.132.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openatom.club
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1762221867;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=aAdyEZtvZBLjgCCraE7HYCkvc3HoTW1UVwpwoqEAgIU=;
 b=YAD1qoURgyNSSnbxBit/Htl0VzY/z4nO9et1H+MbwZOhOIeFeqq4Y2wR6VHcyQ7F7sBN6X
 YS98nM/OS1v+Tikcv/FskxHD6sZZV6PMBeMnH5gdyvsceAhLO9juhtrjDMkKfK6jRQEVDL
 mNn6FVw6oBxOf2yQQvAszOsIFISPBYVvXPU9fyyXcMfLblWUIA0IuRaj3Lvw3xBdSoQFfz
 sWuHZwV/stIrSKcFC0YZO1bC0zTD57ONQb9BVp5ZX7+UcQ6WVILV9x8k8X9EkmWIJmvJ9t
 v0zAOIS1crx6kr+obTPrRT7CGpEM7bhytNz6yDSqmoHxgICBvwbAniCJ6CElxw==
Subject: [PATCH] rust: kernel: Support more jump_label api
Received: from localhost.localdomain ([114.249.49.233]) by smtp.feishu.cn with ESMTPS; Tue, 04 Nov 2025 10:04:24 +0800
X-Lms-Return-Path: <lba+269095f29+4c89be+vger.kernel.org+chenmiao@openatom.club>
X-Mailer: git-send-email 2.43.0
Date: Tue,  4 Nov 2025 02:04:17 +0000
Message-Id: <df3a68334760b2b254219a69426982bf858dee39.1762221537.git.chenmiao@openatom.club>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: <ojeda@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Cc: "Alex Gaynor" <alex.gaynor@gmail.com>, 
	"Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	"Benno Lossin" <lossin@kernel.org>, 
	"Andreas Hindborg" <a.hindborg@kernel.org>, 
	"Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, 
	"Danilo Krummrich" <dakr@kernel.org>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	"open list:RUST" <rust-for-linux@vger.kernel.org>, 
	"open list" <linux-kernel@vger.kernel.org>
From: "chenmiao" <chenmiao@openatom.club>
X-Original-From: chenmiao <chenmiao@openatom.club>

The initial implementation of arch_static_branch was achieved by accessing
the offset from the original type. However, this approach extended the
path and introduced redundant calculations when dealing with types like
`static_key_true/false`, as shown below:

```
static_brach_unlikely(tp, tracepoint, key)
  => tracepoint->key->key
  => &tracepoint->key(static_key_false) == &tracepoint->key.key(static_key)
  => off: tracepoint->key - tracepoint
```

In practice, the implementation of `arch_static_branch` overlooked many
detailed descriptions. To improve clarity, additional comments have been
added to the original logic. The approach has been modified to directly
locate the corresponding `static_key` instead of using offsets, thereby
reducing  computational overhead.

If finding the offset from the primitive type is necessary for this
implementation, I will abandon this change.

Additionally, support for the `static_branch_enable/disable` APIs has been
introduced.

Signed-off-by: chenmiao <chenmiao@openatom.club>
---
 .../generated_arch_static_branch_asm.rs.S     |   2 +-
 rust/kernel/jump_label.rs                     | 169 ++++++++++++++++--
 2 files changed, 155 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/generated_arch_static_branch_asm.rs.S b/rust/kernel/generated_arch_static_branch_asm.rs.S
index 2afb638708db3..08603dc2d61e7 100644
--- a/rust/kernel/generated_arch_static_branch_asm.rs.S
+++ b/rust/kernel/generated_arch_static_branch_asm.rs.S
@@ -4,4 +4,4 @@
 
 // Cut here.
 
-::kernel::concat_literals!(ARCH_STATIC_BRANCH_ASM("{symb} + {off} + {branch}", "{l_yes}"))
+::kernel::concat_literals!(ARCH_STATIC_BRANCH_ASM("{real_key} + {branch}", "{l_yes}"))
diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
index 4e974c768dbd5..12ae78f95c761 100644
--- a/rust/kernel/jump_label.rs
+++ b/rust/kernel/jump_label.rs
@@ -6,22 +6,63 @@
 //!
 //! C header: [`include/linux/jump_label.h`](srctree/include/linux/jump_label.h).
 
-/// Branch based on a static key.
+/// The key used for the static_key_false/true.
 ///
-/// Takes three arguments:
+/// If the key just contains a static_key, like: `struct tracepoint`;
 ///
-/// * `key` - the path to the static variable containing the `static_key`.
-/// * `keytyp` - the type of `key`.
-/// * `field` - the name of the field of `key` that contains the `static_key`.
+/// ```
+/// pub struct tracepoint {
+///     ...,
+///     key: static_key,
+///     ...,
+/// }
 ///
-/// # Safety
+/// // When you use the tracepoint as the parameter.
+/// if static_branch_unlikely!(tp, tracepoint, key) {
+///     // Do something
+/// }
 ///
-/// The macro must be used with a real static key defined by C.
-#[macro_export]
-macro_rules! static_branch_unlikely {
-    ($key:path, $keytyp:ty, $field:ident) => {{
+/// // It just like:
+/// let _key: *const crate::bindings::tracepoint = ::core::ptr::addr_of!($key);
+/// let _key: *const crate::bindings::static_key_false = ::core::ptr::addr_of!((*_key).key);
+/// let _key: *const crate::bindings::static_key = _key.cast();
+/// ```
+///
+/// If the key just contains a single static_key, like: `struct static_key_false`;
+///
+/// ```
+/// pub struct static_key_false {
+///     key: static_key,
+/// }
+///
+/// // When you use the static_key_false as the parameter.
+/// if static_branch_unlikely!(key) {
+///     // Do something
+/// }
+///
+/// // It just like:
+/// let _key: *const crate::bindings::static_key_false = ::core::ptr::addr_of!($key);
+/// let _key: *const crate::bindings::static_key = _key.cast();
+/// ```
+///
+macro_rules! __static_branch_base {
+    ($basety:ty, $branch:expr, $key:path) => {{
+        let _key: *const $basety = ::core::ptr::addr_of!($key);
+        let _key: *const $crate::bindings::static_key = _key.cast();
+
+        #[cfg(not(CONFIG_JUMP_LABEL))]
+        {
+            $crate::bindings::static_key_count(_key.cast_mut()) > 0
+        }
+
+        #[cfg(CONFIG_JUMP_LABEL)]
+        {
+            $crate::jump_label::arch_static_branch! { _key, $branch }
+        }
+    }};
+    ($basety:ty, $branch:expr, $key:path, $keytyp:ty, $field:ident) => {{
         let _key: *const $keytyp = ::core::ptr::addr_of!($key);
-        let _key: *const $crate::bindings::static_key_false = ::core::ptr::addr_of!((*_key).$field);
+        let _key: *const $basety = ::core::ptr::addr_of!((*_key).$field);
         let _key: *const $crate::bindings::static_key = _key.cast();
 
         #[cfg(not(CONFIG_JUMP_LABEL))]
@@ -30,7 +71,88 @@ macro_rules! static_branch_unlikely {
         }
 
         #[cfg(CONFIG_JUMP_LABEL)]
-        $crate::jump_label::arch_static_branch! { $key, $keytyp, $field, false }
+        {
+            $crate::jump_label::arch_static_branch! { _key, $branch }
+        }
+    }};
+}
+
+/// Branch based on a static key.
+///
+/// Takes two type arguments:
+///
+/// First Type takes one argument:
+///
+/// * `key` - the static variable containing the `static_key`.
+///
+/// Second Type takes three arguments:
+///
+/// * `key` - the path to the static variable containing the `static_key`.
+/// * `keytyp` - the type of `key`.
+/// * `field` - the name of the field of `key` that contains the `static_key`.
+///
+/// # Safety
+///
+/// ```
+/// let tp: tracepoint = tracepoint::new();
+/// if static_key_likely!(tp, tracepoint, key) {
+///     // Do something
+/// }
+///
+/// let key: static_key_false = static_key_true::new();
+/// if static_key_likely!(key) {
+///     // Do something
+/// }
+/// ```
+///
+/// The macro must be used with a real static key defined by C.
+#[macro_export]
+macro_rules! static_branch_likely {
+    ($key:path) => {{
+        __static_branch_base! { $crate::bindings::static_key_true, true, $key }
+    }};
+    ($key:path, $keytyp:ty, $field:ident) => {{
+        __static_branch_base! { $crate::bindings::static_key_true, true, $key, $keytyp, $field }
+    }};
+}
+pub use static_branch_likely;
+
+/// Branch based on a static key.
+///
+/// Takes two type arguments:
+///
+/// First Type takes one argument:
+///
+/// * `key` - the static variable containing the `static_key`.
+///
+/// Second Type takes three arguments:
+///
+/// * `key` - the path to the static variable containing the `static_key`.
+/// * `keytyp` - the type of `key`.
+/// * `field` - the name of the field of `key` that contains the `static_key`.
+///
+/// # Safety
+///
+/// ```
+/// let tp: tracepoint = tracepoint::new();
+/// if static_key_unlikely!(tp, tracepoint, key) {
+///     // Do something
+/// }
+///
+/// let key: static_key_false = static_key_false::new();
+/// if static_key_unlikely!(key) {
+///     // Do something
+/// }
+/// ```
+///
+/// The macro must be used with a real static key defined by C.
+#[macro_export]
+macro_rules! static_branch_unlikely {
+    ($key:path) => {{
+        static_branch_base! { $crate::bindings::static_key_false, false, $key }
+    }};
+    ($key:path, $keytyp:ty, $field:ident) => {{
+        static_branch_base! { $crate::bindings::static_key_false, false, $key, $keytyp, $field }
     }};
 }
 pub use static_branch_unlikely;
@@ -46,14 +168,13 @@ macro_rules! static_branch_unlikely {
 #[doc(hidden)]
 #[cfg(CONFIG_JUMP_LABEL)]
 macro_rules! arch_static_branch {
-    ($key:path, $keytyp:ty, $field:ident, $branch:expr) => {'my_label: {
+    ($key:path, $branch:expr) => {'my_label: {
         $crate::asm!(
             include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_static_branch_asm.rs"));
             l_yes = label {
                 break 'my_label true;
             },
-            symb = sym $key,
-            off = const ::core::mem::offset_of!($keytyp, $field),
+            real_key = sym $key,
             branch = const $crate::jump_label::bool_to_int($branch),
         );
 
@@ -72,3 +193,21 @@ macro_rules! arch_static_branch {
 pub const fn bool_to_int(b: bool) -> i32 {
     b as i32
 }
+
+/// Enable a static branch.
+#[macro_export]
+macro_rules! static_branch_enable {
+    ($key:path) => {{
+        let _key: *const $crate::bindings::static_key = ::core::ptr::addr_of!($key);
+        $crate::bindings::static_key_enable(_key.cast_mut());
+    }};
+}
+
+/// Disable a static branch.
+#[macro_export]
+macro_rules! static_branch_disable {
+    ($key:path) => {{
+        let _key: *const $crate::bindings::static_key = ::core::ptr::addr_of!($key);
+        $crate::bindings::static_key_disable(_key.cast_mut());
+    }};
+}
-- 
2.43.0

