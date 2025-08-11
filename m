Return-Path: <linux-kernel+bounces-761775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C29B1FE4B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB15C3B697A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB03326CE04;
	Mon, 11 Aug 2025 04:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rmz+RDLt"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9655324A06D;
	Mon, 11 Aug 2025 04:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754885519; cv=none; b=BEsXx1DUJcO0poz5HFYsdygcTyvpg3SIdyUkDcUqMIcBvVefTUwAg8bEUAXc5BD/E5o0e1NOaBYMRvZ/CeNRCIFd6cD+RkyROXbp8T3UrVjln8c2d4dMvASzMIR7cv0TuEGcA4dBlk4iHucNJRexlvcn0BYr5jLRru8ZV2G1/uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754885519; c=relaxed/simple;
	bh=xwXLAtceT7f6iHArT7IsFD5C5AOOE91oY0DrjN2V0Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5Ir8qcvve0tTdl9KCqoSaHMXHMoab/nwlGAhdRQRmcVDzmd4tGy1WKoi+Lqu2ziMX/yql0xIImafz84fhRCEye7JR7NKRFhxYPjfwXIVtIpShn1T6f7cAoAHym0URm01xr5es3KronHyqq+qJfJwbI1g2eHW148jrugO8i5r7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rmz+RDLt; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso2860881a12.2;
        Sun, 10 Aug 2025 21:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754885517; x=1755490317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohn/TkKZtr6iwWdjA5YyNUEtgLAL94J+pfrIn12Q9tw=;
        b=Rmz+RDLt0XnWjwDSHvQ9XLcwI24EbtsF5XSWdhgP9w3UpNdbTxD9QrS2YYfS4yoaLt
         pYYfQS+I2T17D8vwMVxB3KupVcEGQudYTgY3rkkeIAwlDrtd9IKlhbvDGEbt4nZgBlAH
         ZfC5BXXS5YRaoMvVz672UFpvjfeQTthqogyOspcTB7WzUDVUiJlck42lr+9SBfs5Th2v
         DMqPMfPG/HDrw8IXgNBPiYPCwdZO0XBj4nRUp0Q5qb9YthCt7yTVBDEmEfMEGduJiO7E
         2EKdjY4pBWBMrdmwRnkJq47qrQJ1lmDg71SwrEbPlsRd0RrBYxsNu99eVap5fnP8wg29
         vp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754885517; x=1755490317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohn/TkKZtr6iwWdjA5YyNUEtgLAL94J+pfrIn12Q9tw=;
        b=K5WCU1DMuFAFuNwcVd5pNiOSFiYsGPHFRr33ZdMWUpDgp95hyHX/WimUBZ6y7bWbl9
         SD7x35/pp1z1GAY76JTkHkH+p0foz97qC1xqmbRIeM0MxCnLPeFraHejxaXcsZbMOHak
         /qbklXhvC1uFYut12MGjYEnhijN1bthSZ4IXXY7cmRFbSHy2CKDjVK9yKtN1BWbmRmXH
         eawyZ6oOV7TbYaILoM+2rme77QxjfMynozKcDEEnryo1qseoE/1AM0fgZxdDOFfiF68l
         x9OEnTbWcAIe+2604ZXjcvkyIylGbbOYSwmE9ySncaJXBM77pfpCBLR74gHn9fnVSRF7
         ei7w==
X-Forwarded-Encrypted: i=1; AJvYcCVWSc/1wptFArg41Y71fmDjXtkcpdNiRKMnQZcE1keTVX4InYohT5OoDDqcMsZlKxSZBzG9YecFB6Q1IoH8wdg=@vger.kernel.org, AJvYcCVrP+OYkhpQ+Ri+V6bFdDTquLpfcG9M5lXBtUdHsAse86H+RZSWcopkCHfoguJ8k5nTTDae1KbpC9OgXuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDK1D/wb8808BSbjpH+iEF8HXIKDJLTffWKzI9LNxtlZRQtd4M
	vPPDCxCrkeXTthM45OI8BTtYn2jFb4mB+4FkGJ+c55YZTq+TPktzCh32
X-Gm-Gg: ASbGncsCAE6uD1ipvP2E21j3lsuWipeZnlIWD8YkZvQNU+mWDg4v40oNXwVH7nRE1Ma
	jFlRKPnIuwv9/XVQOyT3OjzpeG8Hy+kJPwwtYj2q3bz9/z7WcRyPZUNg/S8LlS+BeLjZk46LcP/
	xRY88XFEUAIKhaa3uhs++7uhvFgtw2m5LVsdYeqMyN2tCcUwkOTP8WC+thmr4H36xROr1W7CLRy
	mC/FUJYbTIMmNLkXwyYCZo8VCH5JNaGajQhAAiig3SO40i+9TDMkbX2WDBhiACu/SfXiOv/r6ag
	ZOWkcUo/z5sqVBKh6sHSsJuVAPPudFH3ikYFRuBMEeYY8WFCeXqedfGLBF9L2kMOtqfwFmKgR6V
	vaQFo/I33DN77z/k3uFs7aruZWjHDuqeKnIbOPCthHD/Wn+EaJTbJVmlqw77nLpPx9xqT2og=
X-Google-Smtp-Source: AGHT+IHn/aoNaKWBvFIZYUFU+x3t0lIBf7WFt/CWGDM6WsBHEraZEMm6pVXSn2WA99T3Ulh8nZQgPg==
X-Received: by 2002:a17:903:1b4e:b0:242:9bc4:f1c9 with SMTP id d9443c01a7336-242c22a0e73mr157563865ad.56.1754885516829;
        Sun, 10 Aug 2025 21:11:56 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899aa1asm260029025ad.122.2025.08.10.21.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 21:11:56 -0700 (PDT)
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
Subject: [PATCH v1 2/2] rust: Add read_poll_timeout functions
Date: Mon, 11 Aug 2025 13:10:38 +0900
Message-ID: <20250811041039.3231548-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811041039.3231548-1-fujita.tomonori@gmail.com>
References: <20250811041039.3231548-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add read_poll_timeout functions which poll periodically until a
condition is met or a timeout is reached.

The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
macro and a simple wrapper for Rust doesn't work. So this implements
the same functionality in Rust.

The C version uses usleep_range() while the Rust version uses
fsleep(), which uses the best sleep method so it works with spans that
usleep_range() doesn't work nicely with.

The sleep_before_read argument isn't supported since there is no user
for now. It's rarely used in the C version.

read_poll_timeout() can only be used in a nonatomic context. This
requirement is not checked by these abstractions, but it is intended
that klint [1] or a similar tool will be used to check it in the
future.

Link: https://rust-for-linux.com/klint [1]
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs      |   1 +
 rust/kernel/time/poll.rs | 104 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 rust/kernel/time/poll.rs

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 64c8dcf548d6..ec0ec33c838c 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -28,6 +28,7 @@
 
 pub mod delay;
 pub mod hrtimer;
+pub mod poll;
 
 /// The number of nanoseconds per microsecond.
 pub const NSEC_PER_USEC: i64 = bindings::NSEC_PER_USEC as i64;
diff --git a/rust/kernel/time/poll.rs b/rust/kernel/time/poll.rs
new file mode 100644
index 000000000000..9cf0acb1e165
--- /dev/null
+++ b/rust/kernel/time/poll.rs
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
+/// use kernel::io::Io;
+/// use kernel::time::{poll::read_poll_timeout, Delta};
+///
+/// const HW_READY: u16 = 0x01;
+///
+/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result<()> {
+///     // The `op` closure reads the value of a specific status register.
+///     let op = || -> Result<u16> { io.try_read16(0x1000) };
+///
+///     // The `cond` closure takes a reference to the value returned by `op`
+///     // and checks whether the hardware is ready.
+///     let cond = |val: &u16| *val == HW_READY;
+///
+///     match read_poll_timeout(op, cond, Delta::from_millis(50), Some(Delta::from_secs(3))) {
+///         Ok(_) => {
+///             // The hardware is ready. The returned value of the `op`` closure isn't used.
+///             Ok(())
+///         }
+///         Err(e) => Err(e),
+///     }
+/// }
+/// ```
+///
+/// ```rust
+/// use kernel::sync::{SpinLock, new_spinlock};
+/// use kernel::time::Delta;
+/// use kernel::time::poll::read_poll_timeout;
+///
+/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
+/// let g = lock.lock();
+/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Some(Delta::from_micros(42)));
+/// drop(g);
+///
+/// # Ok::<(), Error>(())
+/// ```
+#[track_caller]
+pub fn read_poll_timeout<Op, Cond, T>(
+    mut op: Op,
+    mut cond: Cond,
+    sleep_delta: Delta,
+    timeout_delta: Option<Delta>,
+) -> Result<T>
+where
+    Op: FnMut() -> Result<T>,
+    Cond: FnMut(&T) -> bool,
+{
+    let start: Instant<Monotonic> = Instant::now();
+    let sleep = !sleep_delta.is_zero();
+
+    // Unlike the C version, we always call `might_sleep()`.
+    might_sleep();
+
+    loop {
+        let val = op()?;
+        if cond(&val) {
+            // Unlike the C version, we immediately return.
+            // We know the condition is met so we don't need to check again.
+            return Ok(val);
+        }
+        if let Some(timeout_delta) = timeout_delta {
+            if start.elapsed() > timeout_delta {
+                // Unlike the C version, we immediately return.
+                // We have just called `op()` so we don't need to call it again.
+                return Err(ETIMEDOUT);
+            }
+        }
+        if sleep {
+            fsleep(sleep_delta);
+        }
+        // fsleep() could be busy-wait loop so we always call cpu_relax().
+        cpu_relax();
+    }
+}
-- 
2.43.0


