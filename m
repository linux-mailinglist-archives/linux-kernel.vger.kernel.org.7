Return-Path: <linux-kernel+bounces-850967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB61BD54EE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89DCE506933
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871AF30E84B;
	Mon, 13 Oct 2025 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPsflF9o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B37D30E83E
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370870; cv=none; b=cwr4txG0MsWqAiIWyCy0la/pT4oWH9B3ZKXuLDUTYA1eFfcK6GRTEmA06m4zGJ6qJZ5QuCRYr8tRnfskAEJz6GugT31H3Kt3fiZn5P2QXZcHjAsedSZy9fs8XgGNgNj8qrcxNuzrfocmRHh24tA1maRJVUYD18Kiip4RW4kaSHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370870; c=relaxed/simple;
	bh=4he4jiIAoAbyeZWVjbYkIsDNdmML3owFBrc+YzFGJVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLfqrIZkzxg6EQrpKOTRtP0kScMBxbgUQ6LF5S8YdXQCQbI3whzyVCfgg+bDf5mZpnQ7IhxRWGuVfvCe47V+vLo5lZYzcqahEXUpm9jy9bahd2MC7fmlMtbTW/U8W3VRL60GGeFqIFcEluD9oCEZLBC2pM6PiweFaNHw3X1nGD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPsflF9o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760370867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0wD+yzVVKK5U4LC8P3lLzuyUM/hOvIp3NviRgZGEp0=;
	b=WPsflF9ok4QQK+BeqempcjUOb8IXN/GyHcf+BJtdGir6eXT8/4Mqqa1VmiLO9aVqi1x2Eq
	PYnHWJxqrcQEq5Q09tTyjN1I/MuidR6mhC47B6jV+1dph3Lp/6ufnxIS6NDgR/5s8Diy8K
	QHIfxgPxJWQ0QDmoA2QyXoikVZL9DNo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-pJdm0-gPMU2rK3jXX17KjQ-1; Mon,
 13 Oct 2025 11:54:24 -0400
X-MC-Unique: pJdm0-gPMU2rK3jXX17KjQ-1
X-Mimecast-MFC-AGG-ID: pJdm0-gPMU2rK3jXX17KjQ_1760370861
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A36CF1800288;
	Mon, 13 Oct 2025 15:54:21 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.81.1])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBC5630002D0;
	Mon, 13 Oct 2025 15:54:17 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Cc: Benno Lossin <lossin@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Krishna Ketan Rai <prafulrai522@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [PATCH v13 07/17] rust: Introduce interrupt module
Date: Mon, 13 Oct 2025 11:48:09 -0400
Message-ID: <20251013155205.2004838-8-lyude@redhat.com>
In-Reply-To: <20251013155205.2004838-1-lyude@redhat.com>
References: <20251013155205.2004838-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This introduces a module for dealing with interrupt-disabled contexts,
including the ability to enable and disable interrupts along with the
ability to annotate functions as expecting that IRQs are already
disabled on the local CPU.

[Boqun: This is based on Lyude's work on interrupt disable abstraction,
I port to the new local_interrupt_disable() mechanism to make it work
as a guard type. I cannot even take the credit of this design, since
Lyude also brought up the same idea in zulip. Anyway, this is only for
POC purpose, and of course all bugs are mine]

Signed-off-by: Lyude Paul <lyude@redhat.com>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>

---

V10:
* Fix documentation typos
V11:
* Get rid of unneeded `use bindings;`
* Move ASSUME_DISABLED into assume_disabled()
* Confirm using lockdep_assert_irqs_disabled() that local interrupts are in
  fact disabled when LocalInterruptDisabled::assume_disabled() is called.

 rust/helpers/helpers.c   |  1 +
 rust/helpers/interrupt.c | 18 +++++++++
 rust/helpers/sync.c      |  5 +++
 rust/kernel/interrupt.rs | 86 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs       |  1 +
 5 files changed, 111 insertions(+)
 create mode 100644 rust/helpers/interrupt.c
 create mode 100644 rust/kernel/interrupt.rs

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 551da6c9b5064..01ffade6c0389 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -29,6 +29,7 @@
 #include "err.c"
 #include "irq.c"
 #include "fs.c"
+#include "interrupt.c"
 #include "io.c"
 #include "jump_label.c"
 #include "kunit.c"
diff --git a/rust/helpers/interrupt.c b/rust/helpers/interrupt.c
new file mode 100644
index 0000000000000..f2380dd461ca5
--- /dev/null
+++ b/rust/helpers/interrupt.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/spinlock.h>
+
+void rust_helper_local_interrupt_disable(void)
+{
+	local_interrupt_disable();
+}
+
+void rust_helper_local_interrupt_enable(void)
+{
+	local_interrupt_enable();
+}
+
+bool rust_helper_irqs_disabled(void)
+{
+	return irqs_disabled();
+}
diff --git a/rust/helpers/sync.c b/rust/helpers/sync.c
index ff7e68b488101..45b2f519f4e2e 100644
--- a/rust/helpers/sync.c
+++ b/rust/helpers/sync.c
@@ -11,3 +11,8 @@ void rust_helper_lockdep_unregister_key(struct lock_class_key *k)
 {
 	lockdep_unregister_key(k);
 }
+
+void rust_helper_lockdep_assert_irqs_disabled(void)
+{
+	lockdep_assert_irqs_disabled();
+}
diff --git a/rust/kernel/interrupt.rs b/rust/kernel/interrupt.rs
new file mode 100644
index 0000000000000..6c8d2f58bca70
--- /dev/null
+++ b/rust/kernel/interrupt.rs
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Interrupt controls
+//!
+//! This module allows Rust code to annotate areas of code where local processor interrupts should
+//! be disabled, along with actually disabling local processor interrupts.
+//!
+//! # ⚠️ Warning! ⚠️
+//!
+//! The usage of this module can be more complicated than meets the eye, especially surrounding
+//! [preemptible kernels]. It's recommended to take care when using the functions and types defined
+//! here and familiarize yourself with the various documentation we have before using them, along
+//! with the various documents we link to here.
+//!
+//! # Reading material
+//!
+//! - [Software interrupts and realtime (LWN)](https://lwn.net/Articles/520076)
+//!
+//! [preemptible kernels]: https://www.kernel.org/doc/html/latest/locking/preempt-locking.html
+
+use kernel::types::NotThreadSafe;
+
+/// A guard that represents local processor interrupt disablement on preemptible kernels.
+///
+/// [`LocalInterruptDisabled`] is a guard type that represents that local processor interrupts have
+/// been disabled on a preemptible kernel.
+///
+/// Certain functions take an immutable reference of [`LocalInterruptDisabled`] in order to require
+/// that they may only be run in local-interrupt-disabled contexts on preemptible kernels.
+///
+/// This is a marker type; it has no size, and is simply used as a compile-time guarantee that local
+/// processor interrupts are disabled on preemptible kernels. Note that no guarantees about the
+/// state of interrupts are made by this type on non-preemptible kernels.
+///
+/// # Invariants
+///
+/// Local processor interrupts are disabled on preemptible kernels for as long as an object of this
+/// type exists.
+pub struct LocalInterruptDisabled(NotThreadSafe);
+
+/// Disable local processor interrupts on a preemptible kernel.
+///
+/// This function disables local processor interrupts on a preemptible kernel, and returns a
+/// [`LocalInterruptDisabled`] token as proof of this. On non-preemptible kernels, this function is
+/// a no-op.
+///
+/// **Usage of this function is discouraged** unless you are absolutely sure you know what you are
+/// doing, as kernel interfaces for rust that deal with interrupt state will typically handle local
+/// processor interrupt state management on their own and managing this by hand is quite error
+/// prone.
+pub fn local_interrupt_disable() -> LocalInterruptDisabled {
+    // SAFETY: It's always safe to call `local_interrupt_disable()`.
+    unsafe { bindings::local_interrupt_disable() };
+
+    LocalInterruptDisabled(NotThreadSafe)
+}
+
+impl Drop for LocalInterruptDisabled {
+    fn drop(&mut self) {
+        // SAFETY: Per type invariants, a `local_interrupt_disable()` must be called to create this
+        // object, hence call the corresponding `local_interrupt_enable()` is safe.
+        unsafe { bindings::local_interrupt_enable() };
+    }
+}
+
+impl LocalInterruptDisabled {
+    /// Assume that local processor interrupts are disabled on preemptible kernels.
+    ///
+    /// This can be used for annotating code that is known to be run in contexts where local
+    /// processor interrupts are disabled on preemptible kernels. It makes no changes to the local
+    /// interrupt state on its own.
+    ///
+    /// # Safety
+    ///
+    /// For the whole life `'a`, local interrupts must be disabled on preemptible kernels. This
+    /// could be a context like for example, an interrupt handler.
+    pub unsafe fn assume_disabled<'a>() -> &'a LocalInterruptDisabled {
+        const ASSUME_DISABLED: &LocalInterruptDisabled = &LocalInterruptDisabled(NotThreadSafe);
+
+        // Confirm they're actually disabled if lockdep is available
+        // SAFETY: It's always safe to call `lockdep_assert_irqs_disabled()`
+        unsafe { bindings::lockdep_assert_irqs_disabled() };
+
+        ASSUME_DISABLED
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3dd7bebe78882..75a466d9319b2 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -96,6 +96,7 @@
 pub mod fs;
 pub mod id_pool;
 pub mod init;
+pub mod interrupt;
 pub mod io;
 pub mod ioctl;
 pub mod iov;
-- 
2.51.0


