Return-Path: <linux-kernel+bounces-778720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0EEB2E962
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52BF68628D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDCA1D2F42;
	Thu, 21 Aug 2025 00:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRHacBiY"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C201DE3C7;
	Thu, 21 Aug 2025 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755735729; cv=none; b=r1ysRb63xf92oeTwIA32gb8BRA5WMbskfGcYAlcEofkcFkN0Nt2UDtB1tiwUIWZTENRWsX+KPpAhvQPDaNxq7iYnVx/qxMEL9PG0lekrQKjHgEF7sGkd1zi05MesWXUNRGTSNkneBDm9IawiHFKfd0lXXTbcJJo2RHxLN9Z4ny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755735729; c=relaxed/simple;
	bh=ZN4DcybsJ/hxeAf8lql3Y4iPc4prodHMHcuxdkv+qwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOmYNlmz39ncQoOsYizAU4VRxPN1AWlF0Da+XYR2O18lUE/2dQeD6GL5abwNiBDeBw8jEGtfUq6BFV91ixmEZsW/6cVksRIJpX6XV5dgFUv7L9+uT0qdhJBSTEpPe0J6q21Ohf8PaK5DR2eaaTM/m6ydnbBkwrWvOC4wkAAshCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRHacBiY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-244581cc971so5144365ad.2;
        Wed, 20 Aug 2025 17:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755735725; x=1756340525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fF/VpAOBTz14ECxxicJGO+4RQ9xxO3xahz8GG4kXVUU=;
        b=mRHacBiYIQVH3YMIVPmQfuVzjftwLq3JltzbADl06PCaA55PzOPTufokxF7cqjkeTY
         wF8VwVd2QVvlZeOsWqvV40ab/PMrGG5c3cb8NwtlOU591glHV/ZiCNXODHwWHiNkCWMS
         wEk32mE9C8riJSBZ+WhxwcHBRZM4NIGiXPR4T/XMMTbhpXcQbrqXRtaDcc3pB+Fny0ij
         MWIsrnVpqCIFI6DrD92hfBb/StWj2BPrd6V03uJSJcCijjSw+ib5GKvjiHp782vP9QGT
         1H93IKLvS6yJLxHcsR3Pdvob687s1I7gkk0SuTcHmilETGkrHG6HJfjTyVxLweUXmD+L
         qAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755735725; x=1756340525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fF/VpAOBTz14ECxxicJGO+4RQ9xxO3xahz8GG4kXVUU=;
        b=nUcp88kcUQLMoXf12SNkyfzgEA28GwLWHgAmnx7t4MLA/Uy+NTcmYd3vqDAwNiLza7
         /QYF+X4nndhagQfF3QvdqrQppxmZEqZsfbMVqQJdmlFTIIUQwxEZszB7Sk5g+PEVu7ld
         j7nJDIhC+6hGt79YJlM1TaZ0fjKl0oXYpSQen8GwhflKEDbS9nbkmp394/xHX0qaKVOf
         Jkpc5jyjY2vmXt1y6ZcLrdpDGwx916Ui7xD3m9vDfPOsB8RE5sr+Zp7V0ogDSfLqhYEo
         etaORqhDuozwIuwMprbaZejHrqN+HXPeigGrwSS3M487SqYkJOB7jIN8bcwlrcrksqUg
         4cyA==
X-Forwarded-Encrypted: i=1; AJvYcCVtAZ9aySVvYb2fHK8T4+NCvo55Qm0bteLqpbBkbiKupSfg2Q/sNnEYsmeHzF05tgwOMx0b3Efu2bl9UK4=@vger.kernel.org, AJvYcCWaAyI7LyIJMF2P36lBsjmIgYX1SS4k7x6Ekj+sg2PPXpc5KjdRpitKOORxG1zzx4+MCx9ktLdn8Puilah2CUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3h1eOC9+rBTXNWxlfLUaWQXnMxopl7G0Zzuc4ZZTbeiJBXpb
	PsovVQkpF+AFqpj9STGjzkx3twj681dIj0emv63UcfVvyQfdEqWyOZ81
X-Gm-Gg: ASbGncvtROJh5yx0bp5DJ3rSoX3AcwWGkNupM+knWaXDq+HwUXM3mOpvrWlPahb8iHf
	sxvNVQSkjYNQNnLefdOvQF120iY3il7/xvBDtyC0r4DEdrxKEvlo7IncdDuVrDRT6gj7zPNbB/3
	bfxLyea2OqruZQsRmwigpbYL/CRojjMpPSpXtO5ZFWJIBe19LNRsCZ0DtZ410mH1o001PB4PoHm
	s136y5/de0oBD+jTwJzb/z/5cgG6u8b0ZUJt4rYxwk9zT10qffwOBrKSXyoZRulGhLRtKTA/L1F
	wzGlQVL2z39PgnwjL/Oocdzuf7pFLE9RXr6glcmIaWFrdyR0AYLLGTlryf1j9l1RNVurG8sdRDN
	75RoAt1N9OLh2FBNI56GsPN7UezHIVUumbBI/2gTf/QB6lFIncI7kRc0Cy9Uq/wpUWpkgMQk=
X-Google-Smtp-Source: AGHT+IE/T+m0lWPzoVpo+MiZxtJgtLPflYaj28GMhbyq8Suo+/4lL5hJMUkn+xJXM533hA4rDJlcKQ==
X-Received: by 2002:a17:903:3885:b0:246:61c:a67c with SMTP id d9443c01a7336-246061cab2bmr2966845ad.59.1755735724782;
        Wed, 20 Aug 2025 17:22:04 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed50352esm37464065ad.128.2025.08.20.17.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 17:22:04 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org
Cc: aliceryhl@google.com,
	anna-maria@linutronix.de,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	frederic@kernel.org,
	gary@garyguo.net,
	jstultz@google.com,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	lyude@redhat.com,
	rust-for-linux@vger.kernel.org,
	sboyd@kernel.org,
	tglx@linutronix.de,
	tmgross@umich.edu,
	acourbot@nvidia.com,
	daniel.almeida@collabora.com,
	Fiona Behrens <me@kloenk.dev>
Subject: [PATCH v3 2/2] rust: Add read_poll_timeout function
Date: Thu, 21 Aug 2025 09:20:55 +0900
Message-ID: <20250821002055.3654160-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821002055.3654160-1-fujita.tomonori@gmail.com>
References: <20250821002055.3654160-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add read_poll_timeout function which polls periodically until a
condition is met, an error occurs, or the timeout is reached.

The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
macro and a simple wrapper for Rust doesn't work. So this implements
the same functionality in Rust.

The C version uses usleep_range() while the Rust version uses
fsleep(), which uses the best sleep method so it works with spans that
usleep_range() doesn't work nicely with.

The sleep_before_read argument isn't supported since there is no user
for now. It's rarely used in the C version.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Tested-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/io.rs      |   1 +
 rust/kernel/io/poll.rs | 104 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 rust/kernel/io/poll.rs

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 03b467722b86..ee182b0b5452 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -8,6 +8,7 @@
 use crate::{bindings, build_assert, ffi::c_void};
 
 pub mod mem;
+pub mod poll;
 pub mod resource;
 
 pub use resource::Resource;
diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
new file mode 100644
index 000000000000..7af1934e397a
--- /dev/null
+++ b/rust/kernel/io/poll.rs
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! IO polling.
+//!
+//! C header: [`include/linux/iopoll.h`](srctree/include/linux/iopoll.h).
+
+use crate::{
+    error::{code::*, Result},
+    processor::cpu_relax,
+    task::might_sleep,
+    time::{delay::fsleep, Delta, Instant, Monotonic},
+};
+
+/// Polls periodically until a condition is met, an error occurs,
+/// or the timeout is reached.
+///
+/// The function repeatedly executes the given operation `op` closure and
+/// checks its result using the condition closure `cond`.
+///
+/// If `cond` returns `true`, the function returns successfully with
+/// the result of `op`. Otherwise, it waits for a duration specified
+/// by `sleep_delta` before executing `op` again.
+///
+/// This process continues until either `op` returns an error, `cond`
+/// returns `true`, or the timeout specified by `timeout_delta` is
+/// reached.
+///
+/// This function can only be used in a nonatomic context.
+///
+/// # Errors
+///
+/// If `op` returns an error, then that error is returned directly.
+///
+/// If the timeout specified by `timeout_delta` is reached, then
+/// `Err(ETIMEDOUT)` is returned.
+///
+/// # Examples
+///
+/// ```no_run
+/// use kernel::io::{Io, poll::read_poll_timeout};
+/// use kernel::time::Delta;
+///
+/// const HW_READY: u16 = 0x01;
+///
+/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result<()> {
+///     match read_poll_timeout(
+///         // The `op` closure reads the value of a specific status register.
+///         || io.try_read16(0x1000),
+///         // The `cond` closure takes a reference to the value returned by `op`
+///         // and checks whether the hardware is ready.
+///         |val: &u16| *val == HW_READY,
+///         Delta::from_millis(50),
+///         Delta::from_secs(3),
+///     ) {
+///         Ok(_) => {
+///             // The hardware is ready. The returned value of the `op` closure
+///             // isn't used.
+///             Ok(())
+///         }
+///         Err(e) => Err(e),
+///     }
+/// }
+/// ```
+#[track_caller]
+pub fn read_poll_timeout<Op, Cond, T>(
+    mut op: Op,
+    mut cond: Cond,
+    sleep_delta: Delta,
+    timeout_delta: Delta,
+) -> Result<T>
+where
+    Op: FnMut() -> Result<T>,
+    Cond: FnMut(&T) -> bool,
+{
+    let start: Instant<Monotonic> = Instant::now();
+
+    // Unlike the C version, we always call `might_sleep()` unconditionally,
+    // as conditional calls are error-prone. We clearly separate
+    // `read_poll_timeout()` and `read_poll_timeout_atomic()` to aid
+    // tools like klint.
+    might_sleep();
+
+    loop {
+        let val = op()?;
+        if cond(&val) {
+            // Unlike the C version, we immediately return.
+            // We know the condition is met so we don't need to check again.
+            return Ok(val);
+        }
+
+        if start.elapsed() > timeout_delta {
+            // Unlike the C version, we immediately return.
+            // We have just called `op()` so we don't need to call it again.
+            return Err(ETIMEDOUT);
+        }
+
+        if !sleep_delta.is_zero() {
+            fsleep(sleep_delta);
+        }
+
+        // fsleep() could be busy-wait loop so we always call cpu_relax().
+        cpu_relax();
+    }
+}
-- 
2.43.0


