Return-Path: <linux-kernel+bounces-772344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0ABB29194
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 06:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407862A3430
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 04:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD6D21770D;
	Sun, 17 Aug 2025 04:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi8T00iU"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538622153D2;
	Sun, 17 Aug 2025 04:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755406119; cv=none; b=ZdfM1YEb3VIUqkCgp5YJVmu8pHA6wMAoweUwFwiiHGzlP7/DBsaBO/1iAalE/NcJG48MfRzvbT6CjwiNlMBmPkQBUDrx43awkNo1cjOb0QmRlxAzTurnEQTGCkr4Dt/bMhQkPhvWE6JJBHjVsXIQQyi1C2quYKGe+hp/HSIt2R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755406119; c=relaxed/simple;
	bh=OfUxQNP8egEuZF0aozRSs7eNFemq+iAsPOP/S6eHncs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kF2FO88/wlbXA8ATC0zgfNJIfWmphuf+v7LQHgg1h0h0HdIx2lpw00JkaRcS2b6ZFjcqxpEo7KeUX7oE6lLQSlGah9CnWSF3kXJ5bKD40vp2VYWut/jIW6sL+xoCgMW1CKDE5w9EeJ/7yrRTZsaF1lgETV09Q24LrTeHaQx7b7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mi8T00iU; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b472da8ff0eso1219069a12.3;
        Sat, 16 Aug 2025 21:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755406118; x=1756010918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEV5IZfQmSvRoL3MwRp7ZUYnDWVnp35CPvZMegD2V0g=;
        b=mi8T00iU1Gm3JCHudNtLNzValjzbBxUEwXknSZ5B/jwWI88t/LZsN1rajl3Liek8P4
         j8GLEYSDta6T7mqtKtDIGtMj1qY8yoWFbsvtXN/tuQUCae0uD5ExzAKG90z1NtcMqt8a
         yMPxRfl+IaS3Ebf1cGII4mFt94+ER6GnjY7z1lEIa6DnwFv4t5eVVi7zMPEmIQ3724h0
         K/KDxIvEQt8+hkFniAEvF2JkSWKHtGdKH3kV7XFAgQs+cYBVmvZg3m9GWBeENvG0DadY
         JEUQtZZoQGaZ5K0Dyg9hUBQafPdl46gFwA+xsY1h/31bD6bKsoNDk0ayxk8WWa+bMGlc
         CyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755406118; x=1756010918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEV5IZfQmSvRoL3MwRp7ZUYnDWVnp35CPvZMegD2V0g=;
        b=fWWGgwlORj5y3FD12vADiLmtPlCRvIbCjQctz5qu1W0cXeUMNWX5zB2VPwPKKZzFNo
         yLD0NBDbVxRW3GyhdirFavRVVcJgRIe14NS+dxlEEQaaSeF4Ahl/OoMal6d5Hg86dumc
         y7jxhHXgdmLrf2CJ8TvwrTHwXVEDbCt9zkF2uM7k8rpP1tU9xPlvkh5LlrkMC+03ZRsO
         50RcIwlGB+6u+PqHbr/3rYfSIP0b6WujqtsdAjaC85+BBtKHgiHwASqc4hwn+qk9OQl5
         z/ROT/QZ4k6p9vCRw/4R/JvYcZK9+Bz9MhdCJvyWY03U6ROg4gS9FIaBY8CpZkuqM4D0
         2pyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO4aARKrODTJwTy1vxLiioY8T6Zl9iAcseUajSP9ueevbZEF+3UkwTxizjpF8WNFDRrQuFhOi2FiowzfTsFpg=@vger.kernel.org, AJvYcCXHqBcMeimLfJp7pqy30TyT8h/ADCdQS7CG8X9tv1q+5nbocWYZzibIMNkZHe5HOwBy44o1gE2qUNaanB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPfLFXMqwTFg9+oAJvm93pn/40gl/SI9YjtJPCI0D2JdbXgs2K
	q/b9GSz2KtdfXn1bXyr6M5LGg03X4O4Mbk5ithTJ8ncdr2wDNDIulhzV
X-Gm-Gg: ASbGncsCOdgSiPsa9TeFjJiFVhIIG9Nr918WxuZF7COOHreiI0xMLMTjMAu2EFrXFqM
	JMyTzFN91XKVO/g8G1LSDESa/dyq4KJCJFW7mfvzxp0wZEOyCcWzHfTWgyBYSpNl9uJ5sDwpbLo
	psn272a7GEgXOmd5fAtG3UmltyIPk4S0WQHzz3szPenMHVhLX+GTiDZG8OWuuQSNZ768iPPGmuF
	D1AtJD8/XP0q/u3KzRZ3weayuics+QG7gUHVkylDTRSiDB/e8UwwKnuzaseMKLZfl27Hh6h1Qz8
	rJC2QAEH0i0y0DVimoSgctC801DQYZs7yyWIOfjAtGiODqz9LokkVsagAErrtJ8U8Bqj9gBpChU
	pmKl45AGbn0S62lZznkV29NPdIwYLMBtGi0Sg+TRWvZQYm9kR+80S0FuUE6Ve29aE9G9JCAY=
X-Google-Smtp-Source: AGHT+IF3mKlARKZlgu4rIfuZaOYHZe+PHuOmFUESxWQXKaN9Yfogir+setAFdgEpphUdZDi2/mDncA==
X-Received: by 2002:a17:90b:4a10:b0:31e:8203:4b9d with SMTP id 98e67ed59e1d1-3234dc9ec09mr5767729a91.29.1755406117580;
        Sat, 16 Aug 2025 21:48:37 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3234368aeadsm4740645a91.0.2025.08.16.21.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 21:48:37 -0700 (PDT)
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
Subject: [PATCH v2 2/2] rust: Add read_poll_timeout functions
Date: Sun, 17 Aug 2025 13:47:23 +0900
Message-ID: <20250817044724.3528968-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250817044724.3528968-1-fujita.tomonori@gmail.com>
References: <20250817044724.3528968-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add read_poll_timeout function which poll periodically until a
condition is met or a timeout is reached.

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
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/io.rs      |  1 +
 rust/kernel/io/poll.rs | 96 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
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
index 000000000000..e6325725d5a3
--- /dev/null
+++ b/rust/kernel/io/poll.rs
@@ -0,0 +1,96 @@
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
+/// Polls periodically until a condition is met or a timeout is reached.
+///
+/// The function repeatedly executes the given operation `op` closure and
+/// checks its result using the condition closure `cond`.
+///
+/// If `cond` returns `true`, the function returns successfully with the result of `op`.
+/// Otherwise, it waits for a duration specified by `sleep_delta`
+/// before executing `op` again.
+///
+/// This process continues until either `cond` returns `true` or the timeout,
+/// specified by `timeout_delta`, is reached. If `timeout_delta` is `None`,
+/// polling continues indefinitely until `cond` evaluates to `true` or an error occurs.
+///
+/// This function can only be used in a nonatomic context.
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


