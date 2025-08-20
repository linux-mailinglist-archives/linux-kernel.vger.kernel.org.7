Return-Path: <linux-kernel+bounces-777026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8F4B2D437
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E2A1C231B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993762C3251;
	Wed, 20 Aug 2025 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqdvX2OB"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686542C234C;
	Wed, 20 Aug 2025 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672344; cv=none; b=Na+d7644hpAKaR/7uZCZ4q18MiQ9kiuW6jtJiknEVta5YSkUuBC3mPTlYJz2CZxp1gZiRpIu6/hfTKNKpe6Hny7ip/XlcVxOWoth1RQLRzzwt/DeUV0RGJao2OBPISwI7fXLZJSGTQ4wL1UJPjTS5adCptOT11Mn3tOWgqnCjxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672344; c=relaxed/simple;
	bh=nR2Hrc41c8xWrHe2oOf5LZz68hESHYJ8vCJDWjKNb0k=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VepXuCBZuiP+r1LuIft6sgq6ADnehsLLZWOKA7Jfq/0O1Gi6p9wdy4JjA0NLs1KHAOajK6eXzEw0N6azEFCLSN+zDodzGbMLwiSSrHpVSIClAqnG56uc6qUq/tem3Q+GfZvk+txoCLCNWJUwfT2UnFSCGa8VdYlxn77qEw0fjoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqdvX2OB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2eb20a64so6631513b3a.3;
        Tue, 19 Aug 2025 23:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755672341; x=1756277141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPiJLSCgC1DMhujN/OzW2TN7b5V4r8bSTL9sA1is1v8=;
        b=LqdvX2OBaGYWJOBtiJPE5gOPOiiKWiPSYVKSddEyNdMZ9DB3rVuO46YSSi4G1rTwZ2
         SrPgiIaFlxPYPwMMrdOz1k9pE1Afu9St/552d1ObayAe3Ykuj/bBQHl55dR6d4e0Oxl4
         /qqTGRSkfIby1PfcS27nGcuH3Wp98IJOOS4no587JadaFgZySxE/XUsLhtiNUUobyKyy
         ytG+As2bS5x4LXURIEEjHnNtbksvbfNZL/vCNkIrwPeo72xIGryOms/4vxkUULIT3UoV
         TeVSOHoh1sMifTtgEdQpsqKqWjC4/3pbx0mwoyzZ40VDxOnxt0TKO9bxwuu1wmIPqJcp
         a83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755672341; x=1756277141;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MPiJLSCgC1DMhujN/OzW2TN7b5V4r8bSTL9sA1is1v8=;
        b=WzZmLjXeBiKJdRx/adPXlYJ0YZq3lZCyBG2VFEfw6kDJLsVwt5IIxboxyvQ9KXMDi/
         DnIlarqE1YNkHyl2pGInYH2R79N5+v8Wo1xzPNKrNS7icuE90p5YdKQx1wfDhD3q9cER
         xD9BFNyBSYLDcQmPIP6ON3m6ft8WQBDQysXsU9le/ELnrou0tH5Md1gq227Z6AfWI4l0
         FCMctyPGh34FcUK9+PAh3j4oOF3BwMCHGI6yLiD6SlxTIMrF7xVLndLa0jF2YvMx2zVT
         ShjUM425yRF7ynK/KUBdnBQI2yuYIE9go3Pjy32ExbL24LlxuJtguZneBsGh8AVeW4Bb
         Hcdg==
X-Forwarded-Encrypted: i=1; AJvYcCWVkV6HV/CPxxk7gpwQWi52FAC7OLZ+M/XUggGNKWlSpAwTLxCcO8nBQLrVpskMTUcg5w+DW56gU2MVL9IurSM=@vger.kernel.org, AJvYcCXtPdt4hq9jXNpi7nxJfRzZVMRSCw2pxb7xS1P6OCldY59Vp9yM3ByYlS8RF4qkPsO/Im7v2ZVr3RnsiMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJM1IYFNxLObwBwzh/13dYKAxG5JoTYv9t48X4JbtCK8iyZF31
	QQfUG7xBELSpME7C52XbMBCFqTm/YqRN+Pvh2N8IrNXI/vp1iU1NkTVF
X-Gm-Gg: ASbGncvDIhhQMh9zyVAm4afxrP0kFbOdn1tsBQ5JwHBHiEdNGZZ2fohckzPB6GVP+jM
	o8pacKDEGxNCipbCsrzsLAC/+wpDmdYsTMweqFHAbhTSlRDVyoBQeCcIOUAAlQ9yrq2V54AkQt4
	dxrnPIvLQYPa+KBHWMU5/CHHYFapcuQ8j0QWrBSKa6voc+GwEE75m6vwI99vChlnbH2DGiPSKdd
	iu9o1qauRyVa84LcX7ow2HXTdh8He6gZbzfCg6aKivn2MF1lzmZmXNLAzU7uWZWdD+zwFhkQlcX
	iKPhEHfL8rWvHCx3PstFBXD/ZQxonzVpVmxRkWdngsRSNs3AeDrScgypMEbOxGD1QmDqH8M1mm4
	m+wdKRKvuGII9PjrNDodVZtBFWH33hE5XobHBJYZPx398wPk9SDm+yQzWhXErKc732zaY6buni2
	p7
X-Google-Smtp-Source: AGHT+IFJzA1JUDQ4vIWdw9Z344y34xguQUz4Ttl7I3nyfCY3WaAqxvcI6hzA1WTQgnrT+yFtxqydhw==
X-Received: by 2002:a05:6a00:3cce:b0:75f:9622:4ec4 with SMTP id d2e1a72fcca58-76e8dd29291mr2186855b3a.20.1755672341410;
        Tue, 19 Aug 2025 23:45:41 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7f0b4f34sm4162323b3a.92.2025.08.19.23.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 23:45:40 -0700 (PDT)
Date: Wed, 20 Aug 2025 15:45:35 +0900 (JST)
Message-Id: <20250820.154535.2021779027770226518.fujita.tomonori@gmail.com>
To: daniel.almeida@collabora.com
Cc: fujita.tomonori@gmail.com, a.hindborg@kernel.org,
 alex.gaynor@gmail.com, ojeda@kernel.org, aliceryhl@google.com,
 anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 dakr@kernel.org, frederic@kernel.org, gary@garyguo.net,
 jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org,
 lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org,
 tglx@linutronix.de, tmgross@umich.edu, acourbot@nvidia.com, me@kloenk.dev
Subject: Re: [PATCH v2 2/2] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <F512B17D-5C07-4C10-9710-E2467D21BA80@collabora.com>
References: <20250817044724.3528968-1-fujita.tomonori@gmail.com>
	<20250817044724.3528968-3-fujita.tomonori@gmail.com>
	<F512B17D-5C07-4C10-9710-E2467D21BA80@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 15:30:51 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> Thanks for working on this. Definitely going to be needed by a lot of drivers.
> 
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

Thanks!

> How is the atomic version going to look like? The same, except for
> might_sleep() and without the sleep_delta argument?

If we follow the C implementation, it will be different; C's
read_poll_atomic doesn't use ktime to calculate a timeout.

It would look like the following. I think that the read_poll_timeout
patchset is almost complete so I'll send the
read_poll_timeout_atomic() patchset shortly.

diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index e6325725d5a3..dc4f1ecdf31f 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -8,7 +8,10 @@
     error::{code::*, Result},
     processor::cpu_relax,
     task::might_sleep,
-    time::{delay::fsleep, Delta, Instant, Monotonic},
+    time::{
+        delay::{fsleep, udelay},
+        Delta, Instant, Monotonic,
+    },
 };
 
 /// Polls periodically until a condition is met or a timeout is reached.
@@ -94,3 +97,86 @@ pub fn read_poll_timeout<Op, Cond, T>(
         cpu_relax();
     }
 }
+
+/// Polls periodically until a condition is met or a timeout is reached.
+///
+/// The function repeatedly executes the given operation `op` closure and
+/// checks its result using the condition closure `cond`.
+///
+/// If `cond` returns `true`, the function returns successfully with the result of `op`.
+/// Otherwise, it performs a busy wait for a duration specified by `delay_delta`
+/// before executing `op` again.
+///
+/// This process continues until either `cond` returns `true` or the timeout,
+/// specified by `timeout_delta`, is reached. If `timeout_delta` is `None`,
+/// polling continues indefinitely until `cond` evaluates to `true` or an error occurs.
+///
+/// # Examples
+///
+/// ```no_run
+/// use kernel::io::{Io, poll::read_poll_timeout_atomic};
+/// use kernel::time::Delta;
+///
+/// const HW_READY: u16 = 0x01;
+///
+/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result<()> {
+///     match read_poll_timeout_atomic(
+///         // The `op` closure reads the value of a specific status register.
+///         || io.try_read16(0x1000),
+///         // The `cond` closure takes a reference to the value returned by `op`
+///         // and checks whether the hardware is ready.
+///         |val: &u16| *val == HW_READY,
+///         Delta::from_micros(50),
+///         Delta::from_micros(300),
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
+pub fn read_poll_timeout_atomic<Op, Cond, T>(
+    mut op: Op,
+    mut cond: Cond,
+    delay_delta: Delta,
+    timeout_delta: Delta,
+) -> Result<T>
+where
+    Op: FnMut() -> Result<T>,
+    Cond: FnMut(&T) -> bool,
+{
+    let mut left_ns = timeout_delta.as_nanos();
+    let delay_ns = delay_delta.as_nanos();
+
+    let timeout_is_zero = timeout_delta.is_zero();
+
+    loop {
+        let val = op()?;
+        if cond(&val) {
+            // Unlike the C version, we immediately return.
+            // We know the condition is met so we don't need to check again.
+            return Ok(val);
+        }
+
+        if !timeout_is_zero && left_ns < 0 {
+            // Unlike the C version, we immediately return.
+            // We have just called `op()` so we don't need to call it again.
+            return Err(ETIMEDOUT);
+        }
+
+        if !delay_delta.is_zero() {
+            udelay(delay_delta);
+            if !timeout_is_zero {
+                left_ns -= delay_ns;
+            }
+        }
+
+        cpu_relax();
+        if !timeout_is_zero {
+            left_ns -= 1;
+        }
+    }
+}
-- 
2.43.0


