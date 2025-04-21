Return-Path: <linux-kernel+bounces-612282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB65A94D02
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 09:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B9116B73F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 07:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125DC25B666;
	Mon, 21 Apr 2025 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLSSHLZw"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FFA25A658
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220209; cv=none; b=AfZUn9GUB5RcF/Br2LsI5nW58xFDrmUnkLPL0QXdMHCNmuq5spVqk72ZWzeNuPlBa9206EKDrva/nzF8f/Mhq9htXu4RMRi5WCzPlYJk2pofa2zO/Lv3GIvuxrpF/xne5Lbn/qWi+dVrjP242JTtUWeoL50YHocwSCzJeY0gkY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220209; c=relaxed/simple;
	bh=XMVRemRDB+USIyH6+v0V8k2TtHpJ0xAOzgLjiptbO0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=La5Tf0Ahpy8KFQMBi0koL0uughqgPEgR1QwEeGmm/TbGABy1u4pTdxZQZz7qFiaT9d2ZZdPyqZZ681S7JMIPVj7m8Yf8B5Bmjji9N+uTgagLxAiQb0GoaBo+tVmuantmq/7n0h8bIwZlkG2uhb1SwQh8yN315D6FVl9ygB9HrZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XLSSHLZw; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736bfa487c3so3181547b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745220207; x=1745825007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tTGfWa+XR18CgmLZL098GuduPchQV1dpPmnVmRAGRA=;
        b=XLSSHLZwSPbIF8r0OcwOXKesv6C/AQM7gZ+tqerDCUB9asa1swp+CtGY9jCZxiJMJS
         pL9w4ZgG3fQnKD1ScHMJb5m2fW1ufLbuLB0Ir2D7rPkdyFIHgXNltdyr9AiWl45xrCf/
         hI/Z5y+B8cj3XScqU3ZZ5CxPOIXJJX91TtnXYs/ndJzUP8F/1sHV00lZK+kAr9/JS0Vg
         FmkA5r2AWDiER+3M4RyKu1nDANGmvZ+61sBdZY9SUrEJlKK6NsveeT9UKVBZQgEgcuym
         RVzuc+3HIMpd1v4gtTAVv5pKHzdAA7cU6hpCLUspqojb9DlOPsUcwIC/RlsO/Pd0I5Ih
         AGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745220207; x=1745825007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tTGfWa+XR18CgmLZL098GuduPchQV1dpPmnVmRAGRA=;
        b=RXz21EOzF5GTW0XWQrQZHM28udg+oafdh4pXYUH5zx1Yfd5P9aJKhYMYL2v3ZHTjRG
         c41mPwdMnAfUcnTn1FtC20XlSZ07wCQrjWmVvzCK9EWVu9ED8VyUDrKSzuYg2us9P7bS
         Sfy/TUZ/tWJ/5N6XLBfwl6jAmJthz/HdbuK0WNwjvqfrTgW/qQYqIRe26C4UeOE/UTxh
         G8XqJcuOmC7ElNQAb6d366YbJlVmWYynpCaAwSN1FLiLXl18n3ZLKTxkobOwC7g96qbq
         zYB7ZTxs5v/wWBbRqU9dXGwiGEXpgcFhb2Fe673erfb4KNp9OeyFKwA5XTdz95lMTMAU
         G/kw==
X-Forwarded-Encrypted: i=1; AJvYcCWwO7eT3qOQL5Xm0gzk2frIG7faqkMAdMivjEe0j1T79w1zz52fxWzmDB8G8BpD75m2Ufs8DxFjis/u/Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwmgNIQaWm8oDftnIT0TSw8oWHESAYuV42+iBNxbQyb+Ah8skk
	uFt70BW1liracADa7knpmWRXpzw5fL9YfI7LDhERLDgNuuu5AA56KWj60fCjuFg=
X-Gm-Gg: ASbGncsKbWtnlWJeQJZuIwDjPh1JTOJPhVfisBJ3m9zG91LRmzhVGRrNAqKcT/H71Jx
	ul4IMwerJQ7MQtdc8WwOJmNtEVQXEkSY3rAzFiXuLH+/kQE/nF15/qmmkUOpzTCVOWUuBU4htaY
	sVt3rh2iGuUTcW62l2CI4mpk8IzbvqKO29oaFBV1O+3By+8lnZdQczDgPuKGVUDE1024PMNZv0q
	fexIDDcQKD1lMvEhYwc7aCkxLP0I63QhwNs2momrVAUbswwO1VSTOelMJYeFC3VYp12h81a4V0J
	x1UB6ZBlRRANJqEv9MvUgecmcRnQ7EIP54D/Qpozrw==
X-Google-Smtp-Source: AGHT+IFjJtFg0oARjKoCdKj8ac4jdmbXnB/8wMyyNuzy89hrSl6KALaSX9+y/Rlv9M5tCIGVLSfGZw==
X-Received: by 2002:a05:6a20:c887:b0:1f3:397d:86f1 with SMTP id adf61e73a8af0-203cbc538d8mr15555909637.16.1745220206870;
        Mon, 21 Apr 2025 00:23:26 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfab289asm5866738b3a.153.2025.04.21.00.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 00:23:26 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 11/15] rust: cpufreq: Add initial abstractions for cpufreq framework
Date: Mon, 21 Apr 2025 12:52:18 +0530
Message-Id: <2187facc51586cb3eb1dfff0d2d893680572caf0.1745218976.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745218975.git.viresh.kumar@linaro.org>
References: <cover.1745218975.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce initial Rust abstractions for the cpufreq core. This includes
basic representations for cpufreq flags, relation types, and the cpufreq
table.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/cpufreq.c          |  10 +
 rust/helpers/helpers.c          |   1 +
 rust/kernel/cpufreq.rs          | 364 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 6 files changed, 379 insertions(+)
 create mode 100644 rust/helpers/cpufreq.c
 create mode 100644 rust/kernel/cpufreq.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 931e418f89ed..aa56eacbda71 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6142,6 +6142,7 @@ F:	drivers/cpufreq/
 F:	include/linux/cpufreq.h
 F:	include/linux/sched/cpufreq.h
 F:	kernel/sched/cpufreq*.c
+F:	rust/kernel/cpufreq.rs
 F:	tools/testing/selftests/cpufreq/
 
 CPU HOTPLUG
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 529f22891e0b..7c1d78f68076 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -12,6 +12,7 @@
 #include <linux/blkdev.h>
 #include <linux/clk.h>
 #include <linux/cpu.h>
+#include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/cred.h>
 #include <linux/device/faux.h>
diff --git a/rust/helpers/cpufreq.c b/rust/helpers/cpufreq.c
new file mode 100644
index 000000000000..7c1343c4d65e
--- /dev/null
+++ b/rust/helpers/cpufreq.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/cpufreq.h>
+
+#ifdef CONFIG_CPU_FREQ
+void rust_helper_cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
+{
+	cpufreq_register_em_with_opp(policy);
+}
+#endif
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index ae595c9cd91b..df1fcfb3adf3 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -12,6 +12,7 @@
 #include "build_assert.c"
 #include "build_bug.c"
 #include "clk.c"
+#include "cpufreq.c"
 #include "cpumask.c"
 #include "cred.c"
 #include "device.c"
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
new file mode 100644
index 000000000000..279956c6d056
--- /dev/null
+++ b/rust/kernel/cpufreq.rs
@@ -0,0 +1,364 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! CPU frequency scaling.
+//!
+//! This module provides rust abstractions for interacting with the cpufreq subsystem.
+//!
+//! C header: [`include/linux/cpufreq.h`](srctree/include/linux/cpufreq.h)
+//!
+//! Reference: <https://docs.kernel.org/admin-guide/pm/cpufreq.html>
+
+use crate::{
+    error::{code::*, to_result, Result},
+    ffi::c_ulong,
+    prelude::*,
+};
+
+use core::{
+    pin::Pin,
+};
+
+/// Default transition latency value in nanoseconds.
+pub const ETERNAL_LATENCY_NS: u32 = bindings::CPUFREQ_ETERNAL as u32;
+
+/// CPU frequency driver flags.
+pub mod flags {
+    /// Driver needs to update internal limits even if frequency remains unchanged.
+    pub const NEED_UPDATE_LIMITS: u16 = 1 << 0;
+
+    /// Platform where constants like `loops_per_jiffy` are unaffected by frequency changes.
+    pub const CONST_LOOPS: u16 = 1 << 1;
+
+    /// Register driver as a thermal cooling device automatically.
+    pub const IS_COOLING_DEV: u16 = 1 << 2;
+
+    /// Supports multiple clock domains with per-policy governors in `cpu/cpuN/cpufreq/`.
+    pub const HAVE_GOVERNOR_PER_POLICY: u16 = 1 << 3;
+
+    /// Allows post-change notifications outside of the `target()` routine.
+    pub const ASYNC_NOTIFICATION: u16 = 1 << 4;
+
+    /// Ensure CPU starts at a valid frequency from the driver's freq-table.
+    pub const NEED_INITIAL_FREQ_CHECK: u16 = 1 << 5;
+
+    /// Disallow governors with `dynamic_switching` capability.
+    pub const NO_AUTO_DYNAMIC_SWITCHING: u16 = 1 << 6;
+}
+
+/// Relations from the C code.
+const CPUFREQ_RELATION_L: u32 = 0;
+const CPUFREQ_RELATION_H: u32 = 1;
+const CPUFREQ_RELATION_C: u32 = 2;
+
+/// Can be used with any of the above values.
+const CPUFREQ_RELATION_E: u32 = 1 << 2;
+
+/// CPU frequency selection relations.
+///
+/// CPU frequency selection relations, each optionally marked as "efficient".
+#[derive(Copy, Clone, Debug, Eq, PartialEq)]
+pub enum Relation {
+    /// Select the lowest frequency at or above target.
+    Low(bool),
+    /// Select the highest frequency below or at target.
+    High(bool),
+    /// Select the closest frequency to the target.
+    Close(bool),
+}
+
+impl Relation {
+    // Construct from a C-compatible `u32` value.
+    fn new(val: u32) -> Result<Self> {
+        let efficient = val & CPUFREQ_RELATION_E != 0;
+
+        Ok(match val & !CPUFREQ_RELATION_E {
+            CPUFREQ_RELATION_L => Self::Low(efficient),
+            CPUFREQ_RELATION_H => Self::High(efficient),
+            CPUFREQ_RELATION_C => Self::Close(efficient),
+            _ => return Err(EINVAL),
+        })
+    }
+}
+
+impl From<Relation> for u32 {
+    // Convert to a C-compatible `u32` value.
+    fn from(rel: Relation) -> Self {
+        let (mut val, efficient) = match rel {
+            Relation::Low(e) => (CPUFREQ_RELATION_L, e),
+            Relation::High(e) => (CPUFREQ_RELATION_H, e),
+            Relation::Close(e) => (CPUFREQ_RELATION_C, e),
+        };
+
+        if efficient {
+            val |= CPUFREQ_RELATION_E;
+        }
+
+        val
+    }
+}
+
+/// Policy data.
+///
+/// Rust abstraction for the C `struct cpufreq_policy_data`.
+///
+/// # Invariants
+///
+/// A [`PolicyData`] instance always corresponds to a valid C `struct cpufreq_policy_data`.
+///
+/// The callers must ensure that the `struct cpufreq_policy_data` is valid for access and remains
+/// valid for the lifetime of the returned reference.
+#[repr(transparent)]
+pub struct PolicyData(Opaque<bindings::cpufreq_policy_data>);
+
+impl PolicyData {
+    /// Creates a mutable reference to an existing `struct cpufreq_policy_data` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid for writing and remains valid for the lifetime
+    /// of the returned reference.
+    #[inline]
+    pub unsafe fn from_raw_mut<'a>(ptr: *mut bindings::cpufreq_policy_data) -> &'a mut Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        //
+        // INVARIANT: The caller ensures that `ptr` is valid for writing and remains valid for the
+        // lifetime of the returned reference.
+        unsafe { &mut *ptr.cast() }
+    }
+
+    /// Returns a raw pointer to the underlying C `cpufreq_policy_data`.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::cpufreq_policy_data {
+        let this: *const Self = self;
+        this.cast_mut().cast()
+    }
+
+    /// Wrapper for `cpufreq_generic_frequency_table_verify`.
+    #[inline]
+    pub fn generic_verify(&self) -> Result<()> {
+        // SAFETY: By the type invariant, the pointer stored in `self` is valid.
+        to_result(unsafe { bindings::cpufreq_generic_frequency_table_verify(self.as_raw()) })
+    }
+}
+
+/// The frequency table index.
+///
+/// Represents index with a frequency table.
+///
+/// # Invariants
+///
+/// The index must correspond to a valid entry in the [`Table`] it is used for.
+#[derive(Copy, Clone, PartialEq, Eq, Debug)]
+pub struct TableIndex(usize);
+
+impl TableIndex {
+    /// Creates an instance of [`TableIndex`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `index` correspond to a valid entry in the [`Table`] it is used
+    /// for.
+    pub unsafe fn new(index: usize) -> Self {
+        // INVARIANT: The caller ensures that `index` correspond to a valid entry in the [`Table`].
+        Self(index)
+    }
+}
+
+impl From<TableIndex> for usize {
+    #[inline]
+    fn from(index: TableIndex) -> Self {
+        index.0
+    }
+}
+
+/// CPU frequency table.
+///
+/// Rust abstraction for the C `struct cpufreq_frequency_table`.
+///
+/// # Invariants
+///
+/// A [`Table`] instance always corresponds to a valid C `struct cpufreq_frequency_table`.
+///
+/// The callers must ensure that the `struct cpufreq_frequency_table` is valid for access and
+/// remains valid for the lifetime of the returned reference.
+///
+/// ## Examples
+///
+/// The following example demonstrates how to read a frequency value from [`Table`].
+///
+/// ```
+/// use kernel::cpufreq::{Policy, TableIndex};
+///
+/// fn show_freq(policy: &Policy) {
+///     let table = policy.freq_table().unwrap();
+///
+///     // SAFETY: Index is a valid entry in the table.
+///     let index = unsafe { TableIndex::new(0) };
+///
+///     pr_info!("The frequency at index 0 is: {:?}\n", table.freq(index).unwrap());
+///     pr_info!("The flags at index 0 is: {}\n", table.flags(index));
+///     pr_info!("The data at index 0 is: {}\n", table.data(index));
+/// }
+/// ```
+#[repr(transparent)]
+pub struct Table(Opaque<bindings::cpufreq_frequency_table>);
+
+impl Table {
+    /// Creates a reference to an existing C `struct cpufreq_frequency_table` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid for reading and remains valid for the lifetime
+    /// of the returned reference.
+    #[inline]
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::cpufreq_frequency_table) -> &'a Self {
+        // SAFETY: Guaranteed by the safety requirements of the function.
+        //
+        // INVARIANT: The caller ensures that `ptr` is valid for reading and remains valid for the
+        // lifetime of the returned reference.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns the raw mutable pointer to the C `struct cpufreq_frequency_table`.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::cpufreq_frequency_table {
+        let this: *const Self = self;
+        this.cast_mut().cast()
+    }
+
+    /// Returns frequency at `index` in the [`Table`].
+    #[inline]
+    pub fn freq(&self, index: TableIndex) -> Result<Hertz> {
+        // SAFETY: By the type invariant, the pointer stored in `self` is valid and `index` is
+        // guaranteed to be valid by its safety requirements.
+        Ok(Hertz::from_khz(unsafe {
+            (*self.as_raw().add(index.into())).frequency.try_into()?
+        }))
+    }
+
+    /// Returns flags at `index` in the [`Table`].
+    #[inline]
+    pub fn flags(&self, index: TableIndex) -> u32 {
+        // SAFETY: By the type invariant, the pointer stored in `self` is valid and `index` is
+        // guaranteed to be valid by its safety requirements.
+        unsafe { (*self.as_raw().add(index.into())).flags }
+    }
+
+    /// Returns data at `index` in the [`Table`].
+    #[inline]
+    pub fn data(&self, index: TableIndex) -> u32 {
+        // SAFETY: By the type invariant, the pointer stored in `self` is valid and `index` is
+        // guaranteed to be valid by its safety requirements.
+        unsafe { (*self.as_raw().add(index.into())).driver_data }
+    }
+}
+
+/// CPU frequency table owned and pinned in memory, created from a [`TableBuilder`].
+pub struct TableBox {
+    entries: Pin<KVec<bindings::cpufreq_frequency_table>>,
+}
+
+impl TableBox {
+    /// Constructs a new [`TableBox`] from a [`KVec`] of entries.
+    ///
+    /// # Errors
+    ///
+    /// Returns `EINVAL` if the entries list is empty.
+    #[inline]
+    fn new(entries: KVec<bindings::cpufreq_frequency_table>) -> Result<Self> {
+        if entries.is_empty() {
+            return Err(EINVAL);
+        }
+
+        Ok(Self {
+            // Pin the entries to memory, since we are passing its pointer to the C code.
+            entries: Pin::new(entries),
+        })
+    }
+
+    /// Returns a raw pointer to the underlying C `cpufreq_frequency_table`.
+    #[inline]
+    fn as_raw(&self) -> *const bindings::cpufreq_frequency_table {
+        // The pointer is valid until the table gets dropped.
+        self.entries.as_ptr()
+    }
+}
+
+impl Deref for TableBox {
+    type Target = Table;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The caller owns TableBox, it is safe to deref.
+        unsafe { Self::Target::from_raw(self.as_raw()) }
+    }
+}
+
+/// CPU frequency table builder.
+///
+/// This is used by the CPU frequency drivers to build a frequency table dynamically.
+///
+/// ## Examples
+///
+/// The following example demonstrates how to create a CPU frequency table.
+///
+/// ```
+/// use kernel::cpufreq::{TableBuilder, TableIndex};
+/// use kernel::clk::Hertz;
+///
+/// let mut builder = TableBuilder::new();
+///
+/// // Adds few entries to the table.
+/// builder.add(Hertz::from_mhz(700), 0, 1).unwrap();
+/// builder.add(Hertz::from_mhz(800), 2, 3).unwrap();
+/// builder.add(Hertz::from_mhz(900), 4, 5).unwrap();
+/// builder.add(Hertz::from_ghz(1), 6, 7).unwrap();
+///
+/// let table = builder.to_table().unwrap();
+///
+/// // SAFETY: Index values correspond to valid entries in the table.
+/// let (index0, index2) = unsafe { (TableIndex::new(0), TableIndex::new(2)) };
+///
+/// assert_eq!(table.freq(index0), Ok(Hertz::from_mhz(700)));
+/// assert_eq!(table.flags(index0), 0);
+/// assert_eq!(table.data(index0), 1);
+///
+/// assert_eq!(table.freq(index2), Ok(Hertz::from_mhz(900)));
+/// assert_eq!(table.flags(index2), 4);
+/// assert_eq!(table.data(index2), 5);
+/// ```
+#[derive(Default)]
+#[repr(transparent)]
+pub struct TableBuilder {
+    entries: KVec<bindings::cpufreq_frequency_table>,
+}
+
+impl TableBuilder {
+    /// Creates a new instance of [`TableBuilder`].
+    #[inline]
+    pub fn new() -> Self {
+        Self {
+            entries: KVec::new(),
+        }
+    }
+
+    /// Adds a new entry to the table.
+    pub fn add(&mut self, freq: Hertz, flags: u32, driver_data: u32) -> Result<()> {
+        // Adds the new entry at the end of the vector.
+        Ok(self.entries.push(
+            bindings::cpufreq_frequency_table {
+                flags,
+                driver_data,
+                frequency: freq.as_khz() as u32,
+            },
+            GFP_KERNEL,
+        )?)
+    }
+
+    /// Consumes the [`TableBuilder`] and returns [`TableBox`].
+    pub fn to_table(mut self) -> Result<TableBox> {
+        // Add last entry to the table.
+        self.add(Hertz(c_ulong::MAX), 0, 0)?;
+
+        TableBox::new(self.entries)
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 11d333c8c673..871fcdc09b35 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -45,6 +45,8 @@
 #[cfg(CONFIG_COMMON_CLK)]
 pub mod clk;
 pub mod cpu;
+#[cfg(CONFIG_CPU_FREQ)]
+pub mod cpufreq;
 pub mod cpumask;
 pub mod cred;
 pub mod device;
-- 
2.31.1.272.g89b43f80a514


