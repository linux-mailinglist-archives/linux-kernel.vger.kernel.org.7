Return-Path: <linux-kernel+bounces-802011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B54B44CC6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA25BA46360
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466CB26C3B3;
	Fri,  5 Sep 2025 04:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2OVp5MU"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA1926C3BF;
	Fri,  5 Sep 2025 04:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047319; cv=none; b=MOa7WOFDIrA7y3TLRmQ1DIYVa7kYZ46eTxkkHoTP4EYD2x2Cxbac1J2kHfiF2+uht9yxVEFNK5lQTCq4xLg5LbBvH7hb481c8KJoXKXdWyf+Fs+5tW3eJQb1A13/nF5HbZUNt7qwztcMZGzfxI0LQdJn4ctuxFgruOonxQ6e200=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047319; c=relaxed/simple;
	bh=iRuh/R6i6zrXEshxNZI6ZNhqUyjyGviBVHoFaK4WBaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zeuk9KfV8/22JsKA1mkLsmX0SJl2RUE+Ti50zW4DQOFy8dgFueXJIsSXahOxMU/H6Ncc1aGZnj5ZU5PK8uoiJ4H/Dsd0uPjYXT4O0/8NRfMqS/ZNnpBVL15RWdtxQkCPwrCYBdzsiMh83Bt4JNtjwwyr8bR9Xrc9+/MMQEsVojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2OVp5MU; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70dfcc589a6so19086366d6.2;
        Thu, 04 Sep 2025 21:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757047316; x=1757652116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Oha5IBZzZ1/TS20qhGnIJGMno2KT/vwjiVwVvZTsu0=;
        b=H2OVp5MUNUaH/DWe57JgKVB2ZUAnuqSjnUclgLpF50+UYKUecH7h0LCGULvZrp4yHS
         RbCOiuxQFNK2WE+vCqr+RiTDj157IawwEtK42dUcTqGCAo6l8pRgehndvooHjUooOwBW
         +Smd5LMmbZGebq0DubP4LiJXNIsp4gntDsr/kbZe2mit9S64KQTvZRmrJfyJnQhW51uq
         otDU8gGyAKFxJklf23iJWoQXBuwN1qbfVeaqlj47QMP42vrKKl8tfQD9KJuNETSoyy3M
         S8Tx1YwQE2KSzmk7lkb3ia+HoOC1FNgHaizU3zbVeyCcSpCggwzKJ8tdD9uPlGkdKDnS
         uDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757047316; x=1757652116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Oha5IBZzZ1/TS20qhGnIJGMno2KT/vwjiVwVvZTsu0=;
        b=aWn5OgSO+kvIj8i6SJsuDuxJORxgmU9Pu1WWpzJ9vRx/q1kW0eTur7aWWb/GWUPejG
         rNCXhS/SlDzvybC9qn4oUgeoBvRL6dLChsFJCWZEDqdteiW94itRh7je32CyDHOhr+hW
         I9XY0kVS9SnsDgzxrlcoz48sdYDFWRU7qnpOuit7KBDTqDFAlE3IMmERoZF8UrVGNFYO
         78WoTBzyOJ4XnCLOPUqxEOX9ndYnfGMVCjGRfuY1tUcwkfD706atz89HXEOxK9dJhElW
         1m8onEMhIFUJnVw6PZa6M4pywF+wfWkY9yBWAWOG3njnoyr7EElhCpnIs/adj9kopiGE
         QDNw==
X-Forwarded-Encrypted: i=1; AJvYcCVaSxpK175sf2TKugfrMMMD4PViKEtkfd+pES0Dhx2HAOwSOIUYY98Nb+jMupvGmt7GDT05J3Kr8B4kC+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD+R3FN3gzbdeAHh1VH02cWS5iwGxqUe5COug/rXyXUz4MTzDr
	VfPvrzFoeYmbr4ik5wp3xw3nIiuNMNYNk0i2LLGoinBPvznUxLXo31Ju
X-Gm-Gg: ASbGnctz6FnAdnx45HJfbtBSfWgQhxC+w/e+86rkxr/YQClF3TtR42HfR5qvJZLBZ6K
	3Wkz7ymYLcryTp3dklVmOeiFsoGQmkIFvrMLZTzb/1oz5XLOSo4UQXZZg4Ba7e8/9I6hYok86Ii
	2pr3SxwqguSp2xGrxf/hEAkoSZA9jw/8Ab9EvzdiSknG3L5G81tZuAUm4wmWr5pgxcKr8fHpMyO
	1t7glsY8Mw+XkjS7Qvi5lJ4TzV4wMYd6arm0qZXbdhXdDQbRWHZZu5HnatLW1bUJgpSPEBnN/J1
	e1C/+vTe2o00i0BN0GCIibM5LOufu2dUl6RalE1/JRasMJT3a9pLC/51K5a4tdwnlZtRRdzocR8
	tB/ghcxe5OLSvNJZTEoTcYQScFCnkxfMbQUs8bMzIgCN7TzBKec/rm++r5EqUxlbyd74s2zGX0z
	2lSVq/bh7+CuAQssYg0xpjKIY=
X-Google-Smtp-Source: AGHT+IGp92/iYizOniu71fnmqCFw193dcOQ0UOkJic6YQctnsEts+grtrBjYUz+15IcHHiQ+QEP3/A==
X-Received: by 2002:a05:6214:cc3:b0:722:48f8:66a with SMTP id 6a1803df08f44-72248f806bemr136948076d6.28.1757047315709;
        Thu, 04 Sep 2025 21:41:55 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b4666156sm58559096d6.39.2025.09.04.21.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 21:41:55 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id DDE70F40066;
	Fri,  5 Sep 2025 00:41:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 05 Sep 2025 00:41:54 -0400
X-ME-Sender: <xms:Emq6aKoTNnwi7RuoU_FyPUkKyoF-zYBKe09n5fw4YV5HlyuR3YR3jA>
    <xme:Emq6aGUCfQ4_0JYMyhu4kbNg6B_mdS1gL6Vz3IiLzV7GCi0B8d-ikxXAK1UAGPmfZ
    bYtM-fNbs5FifzJ3w>
X-ME-Received: <xmr:Emq6aA-t75nOvATv31xAgAB4oE_6tLhcsuxPqsWD7TsO6-yn8mUaxOIeKxqtnnEs9qKuRFmTmmTxOz6Ra-5i4OnCKDjzVDek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpefghfffvefhhfdvgfejgfekvdelgfekgeevueehlefhiedvgeffjefgteeugfehieen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuh
    igsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    hmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehmihhnghhosehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
    dprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Emq6aGbix-ehMY3LBeqZh_XtLAhHR2zVmP8Gg_69l_C3yHEz_Y1HJA>
    <xmx:Emq6aAeg5i-2knWUfSYt-83maOOTsTXXUv-ZlNYvBdJf-N6OnQvkIA>
    <xmx:Emq6aIqONjtzm3tGYVvPsKyk8l_wxCY2wRvWiB9riailjxALxIqXNg>
    <xmx:Emq6aPBgkReJdF4TC_CgnSaIsjI8txam3yEBJS1xID4R3hZ7VdocRw>
    <xmx:Emq6aOXz96HKGAqBwbPqilfwZer1be0KqVAu_mB38gXIWVblqrqs6U21>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 00:41:54 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev
Cc: "Will Deacon" <will@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	"Ingo Molnar" <mingo@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	stern@rowland.harvard.edu,
	"Miguel Ojeda" <ojeda@kernel.org>,
	alex.gaynor@gmail.com,
	"Gary Guo" <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	"Benno Lossin" <lossin@kernel.org>,
	"Alice Ryhl" <aliceryhl@google.com>,
	"Trevor Gross" <tmgross@umich.edu>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Andreas Hindborg" <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 02/14] rust: sync: Add basic atomic operation mapping framework
Date: Thu,  4 Sep 2025 21:41:29 -0700
Message-ID: <20250905044141.77868-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905044141.77868-1-boqun.feng@gmail.com>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparation for generic atomic implementation. To unify the
implementation of a generic method over `i32` and `i64`, the C side
atomic methods need to be grouped so that in a generic method, they can
be referred as <type>::<method>, otherwise their parameters and return
value are different between `i32` and `i64`, which would require using
`transmute()` to unify the type into a `T`.

Introduce `AtomicImpl` to represent a basic type in Rust that has the
direct mapping to an atomic implementation from C. Use a sealed trait to
restrict `AtomicImpl` to only support `i32` and `i64` for now.

Further, different methods are put into different `*Ops` trait groups,
and this is for the future when smaller types like `i8`/`i16` are
supported but only with a limited set of API (e.g. only set(), load(),
xchg() and cmpxchg(), no add() or sub() etc).

While the atomic mod is introduced, documentation is also added for
memory models and data races.

Also bump my role to the maintainer of ATOMIC INFRASTRUCTURE to reflect
my responsibility on the Rust atomic mod.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/all/20250719030827.61357-3-boqun.feng@gmail.com/
---
 MAINTAINERS                         |   4 +-
 rust/kernel/sync.rs                 |   1 +
 rust/kernel/sync/atomic.rs          |  22 +++
 rust/kernel/sync/atomic/internal.rs | 265 ++++++++++++++++++++++++++++
 4 files changed, 291 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/sync/atomic.rs
 create mode 100644 rust/kernel/sync/atomic/internal.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index daf520a13bdf..37a753ec2aca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3989,7 +3989,7 @@ F:	drivers/input/touchscreen/atmel_mxt_ts.c
 ATOMIC INFRASTRUCTURE
 M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
-R:	Boqun Feng <boqun.feng@gmail.com>
+M:	Boqun Feng <boqun.feng@gmail.com>
 R:	Mark Rutland <mark.rutland@arm.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
@@ -3998,6 +3998,8 @@ F:	arch/*/include/asm/atomic*.h
 F:	include/*/atomic*.h
 F:	include/linux/refcount.h
 F:	scripts/atomic/
+F:	rust/kernel/sync/atomic.rs
+F:	rust/kernel/sync/atomic/
 
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
 M:	Bradley Grove <linuxdrivers@attotech.com>
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 00f9b558a3ad..7e962e5429d2 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -11,6 +11,7 @@
 
 mod arc;
 pub mod aref;
+pub mod atomic;
 pub mod completion;
 mod condvar;
 pub mod lock;
diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
new file mode 100644
index 000000000000..b9f2f4780073
--- /dev/null
+++ b/rust/kernel/sync/atomic.rs
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Atomic primitives.
+//!
+//! These primitives have the same semantics as their C counterparts: and the precise definitions of
+//! semantics can be found at [`LKMM`]. Note that Linux Kernel Memory (Consistency) Model is the
+//! only model for Rust code in kernel, and Rust's own atomics should be avoided.
+//!
+//! # Data races
+//!
+//! [`LKMM`] atomics have different rules regarding data races:
+//!
+//! - A normal write from C side is treated as an atomic write if
+//!   CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y.
+//! - Mixed-size atomic accesses don't cause data races.
+//!
+//! [`LKMM`]: srctree/tools/memory-model/
+
+#[allow(dead_code, unreachable_pub)]
+mod internal;
+
+pub use internal::AtomicImpl;
diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
new file mode 100644
index 000000000000..6fdd8e59f45b
--- /dev/null
+++ b/rust/kernel/sync/atomic/internal.rs
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Atomic internal implementations.
+//!
+//! Provides 1:1 mapping to the C atomic operations.
+
+use crate::bindings;
+use crate::macros::paste;
+use core::cell::UnsafeCell;
+
+mod private {
+    /// Sealed trait marker to disable customized impls on atomic implementation traits.
+    pub trait Sealed {}
+}
+
+// `i32` and `i64` are only supported atomic implementations.
+impl private::Sealed for i32 {}
+impl private::Sealed for i64 {}
+
+/// A marker trait for types that implement atomic operations with C side primitives.
+///
+/// This trait is sealed, and only types that have directly mapping to the C side atomics should
+/// impl this:
+///
+/// - `i32` maps to `atomic_t`.
+/// - `i64` maps to `atomic64_t`.
+pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
+    /// The type of the delta in arithmetic or logical operations.
+    ///
+    /// For example, in `atomic_add(ptr, v)`, it's the type of `v`. Usually it's the same type of
+    /// [`Self`], but it may be different for the atomic pointer type.
+    type Delta;
+}
+
+// `atomic_t` implements atomic operations on `i32`.
+impl AtomicImpl for i32 {
+    type Delta = Self;
+}
+
+// `atomic64_t` implements atomic operations on `i64`.
+impl AtomicImpl for i64 {
+    type Delta = Self;
+}
+
+/// Atomic representation.
+#[repr(transparent)]
+pub struct AtomicRepr<T: AtomicImpl>(UnsafeCell<T>);
+
+impl<T: AtomicImpl> AtomicRepr<T> {
+    /// Creates a new atomic representation `T`.
+    pub const fn new(v: T) -> Self {
+        Self(UnsafeCell::new(v))
+    }
+
+    /// Returns a pointer to the underlying `T`.
+    ///
+    /// # Guarantees
+    ///
+    /// The returned pointer is valid and properly aligned (i.e. aligned to [`align_of::<T>()`]).
+    pub const fn as_ptr(&self) -> *mut T {
+        // GUARANTEE: `self.0` is an `UnsafeCell<T>`, therefore the pointer returned by `.get()`
+        // must be valid and properly aligned.
+        self.0.get()
+    }
+}
+
+// This macro generates the function signature with given argument list and return type.
+macro_rules! declare_atomic_method {
+    (
+        $(#[doc=$doc:expr])*
+        $func:ident($($arg:ident : $arg_type:ty),*) $(-> $ret:ty)?
+    ) => {
+        paste!(
+            $(#[doc = $doc])*
+            fn [< atomic_ $func >]($($arg: $arg_type,)*) $(-> $ret)?;
+        );
+    };
+    (
+        $(#[doc=$doc:expr])*
+        $func:ident [$variant:ident $($rest:ident)*]($($arg_sig:tt)*) $(-> $ret:ty)?
+    ) => {
+        paste!(
+            declare_atomic_method!(
+                $(#[doc = $doc])*
+                [< $func _ $variant >]($($arg_sig)*) $(-> $ret)?
+            );
+        );
+
+        declare_atomic_method!(
+            $(#[doc = $doc])*
+            $func [$($rest)*]($($arg_sig)*) $(-> $ret)?
+        );
+    };
+    (
+        $(#[doc=$doc:expr])*
+        $func:ident []($($arg_sig:tt)*) $(-> $ret:ty)?
+    ) => {
+        declare_atomic_method!(
+            $(#[doc = $doc])*
+            $func($($arg_sig)*) $(-> $ret)?
+        );
+    }
+}
+
+// This macro generates the function implementation with given argument list and return type, and it
+// will replace "call(...)" expression with "$ctype _ $func" to call the real C function.
+macro_rules! impl_atomic_method {
+    (
+        ($ctype:ident) $func:ident($($arg:ident: $arg_type:ty),*) $(-> $ret:ty)? {
+            $unsafe:tt { call($($c_arg:expr),*) }
+        }
+    ) => {
+        paste!(
+            #[inline(always)]
+            fn [< atomic_ $func >]($($arg: $arg_type,)*) $(-> $ret)? {
+                // TODO: Ideally we want to use the SAFETY comments written at the macro invocation
+                // (e.g. in `declare_and_impl_atomic_methods!()`, however, since SAFETY comments
+                // are just comments, and they are not passed to macros as tokens, therefore we
+                // cannot use them here. One potential improvement is that if we support using
+                // attributes as an alternative for SAFETY comments, then we can use that for macro
+                // generating code.
+                //
+                // SAFETY: specified on macro invocation.
+                $unsafe { bindings::[< $ctype _ $func >]($($c_arg,)*) }
+            }
+        );
+    };
+    (
+        ($ctype:ident) $func:ident[$variant:ident $($rest:ident)*]($($arg_sig:tt)*) $(-> $ret:ty)? {
+            $unsafe:tt { call($($arg:tt)*) }
+        }
+    ) => {
+        paste!(
+            impl_atomic_method!(
+                ($ctype) [< $func _ $variant >]($($arg_sig)*) $( -> $ret)? {
+                    $unsafe { call($($arg)*) }
+            }
+            );
+        );
+        impl_atomic_method!(
+            ($ctype) $func [$($rest)*]($($arg_sig)*) $( -> $ret)? {
+                $unsafe { call($($arg)*) }
+            }
+        );
+    };
+    (
+        ($ctype:ident) $func:ident[]($($arg_sig:tt)*) $( -> $ret:ty)? {
+            $unsafe:tt { call($($arg:tt)*) }
+        }
+    ) => {
+        impl_atomic_method!(
+            ($ctype) $func($($arg_sig)*) $(-> $ret)? {
+                $unsafe { call($($arg)*) }
+            }
+        );
+    }
+}
+
+// Delcares $ops trait with methods and implements the trait for `i32` and `i64`.
+macro_rules! declare_and_impl_atomic_methods {
+    ($(#[$attr:meta])* $pub:vis trait $ops:ident {
+        $(
+            $(#[doc=$doc:expr])*
+            fn $func:ident [$($variant:ident),*]($($arg_sig:tt)*) $( -> $ret:ty)? {
+                $unsafe:tt { bindings::#call($($arg:tt)*) }
+            }
+        )*
+    }) => {
+        $(#[$attr])*
+        $pub trait $ops: AtomicImpl {
+            $(
+                declare_atomic_method!(
+                    $(#[doc=$doc])*
+                    $func[$($variant)*]($($arg_sig)*) $(-> $ret)?
+                );
+            )*
+        }
+
+        impl $ops for i32 {
+            $(
+                impl_atomic_method!(
+                    (atomic) $func[$($variant)*]($($arg_sig)*) $(-> $ret)? {
+                        $unsafe { call($($arg)*) }
+                    }
+                );
+            )*
+        }
+
+        impl $ops for i64 {
+            $(
+                impl_atomic_method!(
+                    (atomic64) $func[$($variant)*]($($arg_sig)*) $(-> $ret)? {
+                        $unsafe { call($($arg)*) }
+                    }
+                );
+            )*
+        }
+    }
+}
+
+declare_and_impl_atomic_methods!(
+    /// Basic atomic operations
+    pub trait AtomicBasicOps {
+        /// Atomic read (load).
+        fn read[acquire](a: &AtomicRepr<Self>) -> Self {
+            // SAFETY: `a.as_ptr()` is valid and properly aligned.
+            unsafe { bindings::#call(a.as_ptr().cast()) }
+        }
+
+        /// Atomic set (store).
+        fn set[release](a: &AtomicRepr<Self>, v: Self) {
+            // SAFETY: `a.as_ptr()` is valid and properly aligned.
+            unsafe { bindings::#call(a.as_ptr().cast(), v) }
+        }
+    }
+);
+
+declare_and_impl_atomic_methods!(
+    /// Exchange and compare-and-exchange atomic operations
+    pub trait AtomicExchangeOps {
+        /// Atomic exchange.
+        ///
+        /// Atomically updates `*a` to `v` and returns the old value.
+        fn xchg[acquire, release, relaxed](a: &AtomicRepr<Self>, v: Self) -> Self {
+            // SAFETY: `a.as_ptr()` is valid and properly aligned.
+            unsafe { bindings::#call(a.as_ptr().cast(), v) }
+        }
+
+        /// Atomic compare and exchange.
+        ///
+        /// If `*a` == `*old`, atomically updates `*a` to `new`. Otherwise, `*a` is not
+        /// modified, `*old` is updated to the current value of `*a`.
+        ///
+        /// Return `true` if the update of `*a` occurred, `false` otherwise.
+        fn try_cmpxchg[acquire, release, relaxed](
+            a: &AtomicRepr<Self>, old: &mut Self, new: Self
+        ) -> bool {
+            // SAFETY: `a.as_ptr()` is valid and properly aligned. `core::ptr::from_mut(old)`
+            // is valid and properly aligned.
+            unsafe { bindings::#call(a.as_ptr().cast(), core::ptr::from_mut(old), new) }
+        }
+    }
+);
+
+declare_and_impl_atomic_methods!(
+    /// Atomic arithmetic operations
+    pub trait AtomicArithmeticOps {
+        /// Atomic add (wrapping).
+        ///
+        /// Atomically updates `*a` to `(*a).wrapping_add(v)`.
+        fn add[](a: &AtomicRepr<Self>, v: Self::Delta) {
+            // SAFETY: `a.as_ptr()` is valid and properly aligned.
+            unsafe { bindings::#call(v, a.as_ptr().cast()) }
+        }
+
+        /// Atomic fetch and add (wrapping).
+        ///
+        /// Atomically updates `*a` to `(*a).wrapping_add(v)`, and returns the value of `*a`
+        /// before the update.
+        fn fetch_add[acquire, release, relaxed](a: &AtomicRepr<Self>, v: Self::Delta) -> Self {
+            // SAFETY: `a.as_ptr()` is valid and properly aligned.
+            unsafe { bindings::#call(v, a.as_ptr().cast()) }
+        }
+    }
+);
-- 
2.51.0


