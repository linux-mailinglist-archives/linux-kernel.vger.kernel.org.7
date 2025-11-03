Return-Path: <linux-kernel+bounces-882775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BA5C2B6EA
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE8B3BB7DF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97410306D3D;
	Mon,  3 Nov 2025 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNwtr868"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E838306B2D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169446; cv=none; b=b8doJDA+KoNTk+JRMM1YdaALZPk9ZHZZX1GDfjjXZ6mbzLnglt/eswfGnS5fQ27tbGCzIWR2i53G4rEfJG5HRy/emywYlrpwaXRMOXxXC43SYFEOBGxymz5kL+XasGWEiAway+HpmKdSNVcwAyixHRAi2JtQLfnqywch1KqIYaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169446; c=relaxed/simple;
	bh=Qs7F9UIu6YqaEfJe3oGUDLwZfwqHWL3NgU5G+AF7xMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBo0qHPSqlpkbUSRgwu2qkKs36HXoTxM01SrJGKsxGAXNuS/ToIGEtJ7/yn9szw9El1EELIb1afd5+SRuhG7jQ2o91xrsfla6NOWgR6MK1dwOUocQ/DNmEKS65B4Z61U8Vn/TpDEuAejIXz9doOgaN0YkVfeLuCKFEXHneocyUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNwtr868; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33db8fde85cso4191371a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762169445; x=1762774245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBtU3a0ysV2uBxdh/EjwzVIfbYaw1pOF5fN9hWc8SI0=;
        b=XNwtr868WMbh8gKTflU8Xv5ITDFXkiQTZr0Fe284+XtPqpoeTWnHFZ7lQ9eY0caTi/
         9QVd9DZ1ZLgFiO9eHN4gtDmz2jknOUgPn9+TrJUvo1JggD9Et22iaTlx8+F2oQflvva2
         z+izOuR5S7gMZQKQVsvxxqoQy76ix6/klCpkteeU8uOOJ7T6rb9YrRnrTSXMSabMawTT
         FKF85aSiNpnymGU+1HNj5rqJNmDoiwZpZX75Ok3UbCzoHmm5dy5hCOEfXJzFJU0xJ+qw
         2/fbHKkYNm2PzKM5oBo9Pv6mUmOTJT5M4+rNPZ/q9Dp9lr+GBfyz4XWE6TkQrsaubJwq
         aX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762169445; x=1762774245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBtU3a0ysV2uBxdh/EjwzVIfbYaw1pOF5fN9hWc8SI0=;
        b=h8cDGI1ewwVtmpM1L/BNrZvXdWB0fygGa7dovFKZS8btHD5nKkleoTmAXwInopzHzi
         KABl7Bk09n5mJnw1CzHGi/5QJWg/+MGfgy6I0vRptHvWQHP6eLJCMrGPWLe9NtqdEA48
         r4dMGMHeS2yHxHx+ndNAqRr/G4PW/EFcsqMs5bciBQ/Oxp6Ci1KCIgqtoP1eftsdH7iL
         A1ux1+T8yQHRWKUkXDN1YA7wcjd58+A0bQQngidvJ3196B6VM1bDRF30d+pBulpQx/e+
         Uw/M73hmb9BwknvM5jqcissc4iepNDdD6JwRuAvT9Fdnxj1rPCzFmxaHO2MVmJrGmWxe
         V/Zg==
X-Forwarded-Encrypted: i=1; AJvYcCV8lPAlMspEPbBCZSkK9XHWX1hEdi8VB3Q7zkMYGRlkax9o+79XuPh76Y7+5S9Prbk/6afLUNP7ZHVWjvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZttOBVr2v4uU9wKPJFueJVkVlJzkc7bxJx5XsbZjxYjyqEvf6
	V8oCzJhveeDSWkS44hvlHajmxXlkTbx+XzeYtiDNTWYogv3OsP+DfY+f
X-Gm-Gg: ASbGncsJ1q8PkWmnUjjUG2raAvL8wIfEY85a+B6QCJaILn59W1/VdnO9pVoeNulWSS0
	27qaFE0FlAxncjhKKHMi7u4lrFOXwKwx7m02KR3OfrZryHdns94poqMjz30AU81G0elGI2iQZOb
	/B0V0sy0llqG9yjf0HFth2WEyAnqM8HjS5DyhqImS6qbLcaumq3zUi6zWaW+xebO8b+jaetHh7a
	nPJ3RUaE+A9vvZAJcRh1Wo8hsAyVKBoSRBGRoPDtkTxgm3pxJwjrRpWS62RelIA7zVsm1JN1j+m
	PL7qbFpNZWl/4qvQKPElX7Mue2LBKvbe6Bxq5qQfKq8QwH9mWn4cCWdJYvhK+8Ddfr6V+Q8sC5b
	oIgYaVuJOTkPOJ1XpgaOdz0QeQI+PVXy+OzIY5LFoKnN4FZzmol42hu6fA36K9aFVetHoKX2M8i
	L0juMWjhntKyh4sxsYbv9+3g3H48X2c9VjhcWzh9JfWq0mY50W
X-Google-Smtp-Source: AGHT+IHmOwyUcmyvsEy5tPHeBGjIMAhnC0ExrOtR/nmM8pCo5eJUoNeq+D7oFCJVNElcXl4sgNqsYw==
X-Received: by 2002:a17:90b:3fc6:b0:340:ca32:bcad with SMTP id 98e67ed59e1d1-340ca32bdadmr7979089a91.19.1762169444530;
        Mon, 03 Nov 2025 03:30:44 -0800 (PST)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d897c632sm11011033b3a.10.2025.11.03.03.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:30:44 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	ojeda@kernel.org
Cc: anna-maria@linutronix.de,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	frederic@kernel.org,
	gary@garyguo.net,
	jstultz@google.com,
	linux-kernel@vger.kernel.org,
	lossin@kernel.org,
	lyude@redhat.com,
	rust-for-linux@vger.kernel.org,
	sboyd@kernel.org,
	tglx@linutronix.de,
	tmgross@umich.edu
Subject: [PATCH v4 2/2] rust: Add read_poll_timeout_atomic function
Date: Mon,  3 Nov 2025 20:29:58 +0900
Message-ID: <20251103112958.2961517-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103112958.2961517-1-fujita.tomonori@gmail.com>
References: <20251103112958.2961517-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add read_poll_timeout_atomic function which polls periodically until a
condition is met, an error occurs, or the attempt limit is reached.

The C's read_poll_timeout_atomic() is used for the similar purpose.
In atomic context the timekeeping infrastructure is unavailable, so
reliable time-based timeouts cannot be implemented. So instead, the
helper accepts a maximum number of attempts and busy-waits (udelay +
cpu_relax) between tries.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/io/poll.rs | 72 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index 8f8886543f34..18bed3e78ef7 100644
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
 
 /// Polls periodically until a condition is met, an error occurs,
@@ -96,3 +99,70 @@ pub fn read_poll_timeout<Op, Cond, T>(
         cpu_relax();
     }
 }
+
+/// Polls periodically until a condition is met, an error occurs,
+/// or the attempt limit is reached.
+///
+/// The function repeatedly executes the given operation `op` closure and
+/// checks its result using the condition closure `cond`.
+///
+/// If `cond` returns `true`, the function returns successfully with the result of `op`.
+/// Otherwise, it performs a busy wait for a duration specified by `delay_delta`
+/// before executing `op` again.
+///
+/// This process continues until either `op` returns an error, `cond`
+/// returns `true`, or the attempt limit specified by `retry` is reached.
+///
+/// # Errors
+///
+/// If `op` returns an error, then that error is returned directly.
+///
+/// If the attempt limit specified by `retry` is reached, then
+/// `Err(ETIMEDOUT)` is returned.
+///
+/// # Examples
+///
+/// ```no_run
+/// use kernel::io::{poll::read_poll_timeout_atomic, Io};
+/// use kernel::time::Delta;
+///
+/// const HW_READY: u16 = 0x01;
+///
+/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result {
+///     read_poll_timeout_atomic(
+///         // The `op` closure reads the value of a specific status register.
+///         || io.try_read16(0x1000),
+///         // The `cond` closure takes a reference to the value returned by `op`
+///         // and checks whether the hardware is ready.
+///         |val: &u16| *val == HW_READY,
+///         Delta::from_micros(50),
+///         1000,
+///     )?;
+///     Ok(())
+/// }
+/// ```
+pub fn read_poll_timeout_atomic<Op, Cond, T>(
+    mut op: Op,
+    mut cond: Cond,
+    delay_delta: Delta,
+    retry: usize,
+) -> Result<T>
+where
+    Op: FnMut() -> Result<T>,
+    Cond: FnMut(&T) -> bool,
+{
+    for _ in 0..retry {
+        let val = op()?;
+        if cond(&val) {
+            return Ok(val);
+        }
+
+        if !delay_delta.is_zero() {
+            udelay(delay_delta);
+        }
+
+        cpu_relax();
+    }
+
+    Err(ETIMEDOUT)
+}
-- 
2.43.0


