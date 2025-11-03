Return-Path: <linux-kernel+bounces-882774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EBEC2B77C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A58104F88A7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E68306B02;
	Mon,  3 Nov 2025 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xr/aPDju"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4BA3064B3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169442; cv=none; b=c1Yrh8nSqnkeBnP9B2vmqUDeZVcobKEuiBZApVq7nIpM1D65uAgMwaZEEn5WlK45i7VAp83GJ1zp4rlP8TL4JHhey2cSmEWonYsOb/5p1u+SmTvE7qL0keQtsdupS+upQwWqew+1YpWFuIsxnozQBNrdhn+2eIgS2tM9dpXU71w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169442; c=relaxed/simple;
	bh=c4fre0DPVQedQ1omSaBy8kI0uNFs2j2AoanFTIizUb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6QSitg7Z1lsaVjWw77ZAoVWJZhcrHKImBc1wwwyNLF6JLudQFsTQXZxKdnJWiRMczuRJLT1fLDt1O2xitpEe5MJw+P1raPz/jqmLAbQufQ2WFgNZ0USuJrR9BuhQqQCg8nF0ciksPtvl18drhcBapW9pN+I04xdYcB8pxC9ngA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xr/aPDju; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7aad4823079so823725b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 03:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762169440; x=1762774240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTYI1ijY3wk0C6HSPCcVsF+f0DiQ6/0qsG0vbcCU7Hs=;
        b=Xr/aPDjuFeKdHnPCy++p2cTqizP3xQbbBxj24o0ARGe7tpgcRUcSRYhk9zX3L+HJNm
         2mSXUrCesLjd/3aIl3V4uh1WptkZX4KlJtHRQ89M8FessdIME9p1Q8ldFGdEmkU0V1tG
         FM9HIxDUUgNajIOZLd9imZZFdsn0jS+Pp0FafGO7ArwOnKTBvLYwJCtAgBiaglU6dT92
         smbTBw8bn5g8lYuIr1l+K127thMDdMMKbLTz0Xutl7Kn1TLaD851L3OKyHd4uigKndm5
         UIQ9AEDtZ52CL36+u2yUsRFMrJdFyfu4f272t4WKpNGiY+2wDUPnu17yFmDgd8ZwYYbH
         Iv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762169440; x=1762774240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTYI1ijY3wk0C6HSPCcVsF+f0DiQ6/0qsG0vbcCU7Hs=;
        b=Yg7eavcTDt8h78d2UjP+g6noPnspVb0keTbXG2WwMxw23IeBMaA4eQOe6U947LcojZ
         MF+eM0+v9f0EmtrxXWZDq4K5DCOWd1Mfjo66R4HjXWylvxDxx9E+6hvKHIiPbf0FsYIB
         o+yrJsCzxtEC6WSWaDAJLQnRJBr1qB6NYhnRSdPv/WGtBuMGjU0knusP2xWwno9jTgff
         l0UF56Qfqk5744vpuQ2hkz7OneBSmHO0pxgPnKO7cDkv0Ul7GpzMcGwUVWlLSOb0Jmrv
         kQw/E7eHmlqc8h08mCbQa23igPVAbrDh7sGaZAUV4pw76BfNjW96r+O8vZD+dKGfDsLI
         KvRg==
X-Forwarded-Encrypted: i=1; AJvYcCUuu6O5MOMvexexOmqsqCQwl/+/xSpTaQfPRCiiDTe/OPV3tDnO12fkIpPMY3tn1Q6wyxpKO0UqMUDSJ/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjYRMDaSBRpO1aYNfwArldZL4QYrr/on7KtBvUXH+JfP8htXWA
	ynzwthXhxy7gkj1lYpnTVtIIWwDBv6XxtdnElM16X8tVRsL6Eo4o1/wx
X-Gm-Gg: ASbGncs/CVgJiaJo4zuUXgmm2Vv3RG/MgdpxtEAvJN+NJxK9yLACZ+lOP+2nO/w844B
	7XZe5oodwlxojTjZRkyBE/YizQY7CjyhDcPiqKVR5gdW4kBkZ2KDDkR1IutmcycVESlHx4rM6VF
	/dSeqoFINvGNfdod07AfMrEKa9Pxy98nsQd9nvnRW1C5y/vJjbno28aJpR6qUVyoDB/Vp318gDM
	tt3C5LBYKfELSdptIqM6g5YLY3SgYodiZ61sgFIWdyknSA+ODSSxsnwLahYmnMyKJP9Fi4S/YoL
	G3BJPOy9dAN3mMg+6UqErlzz8lY8oqYvk8DCTeeOo9DrNp7AYjk+GYN1q7FBwWYnR12QqhD/nsg
	mrfUobqCLUfQEctZx/Rm4xdgs+n/IwrD40Mwameb61JbrrAZNlIW0UHQeSYr4cqQKo9EJSGHbXK
	LCRmjOUcM0z+/cF4fBl1vP/2X/+tUFieFf9Cr1LOHRcDJY10Zv
X-Google-Smtp-Source: AGHT+IFD63eASF0/ho7IY2zD1kT93ld6xW+VcralerQCOlJHoW/IJwkqJ4M2KL2Vbvl399L7WhCpPg==
X-Received: by 2002:a05:6a20:4322:b0:33e:5d06:92d2 with SMTP id adf61e73a8af0-348c9f67250mr16915800637.5.1762169440438;
        Mon, 03 Nov 2025 03:30:40 -0800 (PST)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d897c632sm11011033b3a.10.2025.11.03.03.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:30:40 -0800 (PST)
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
Subject: [PATCH v4 1/2] rust: add udelay() function
Date: Mon,  3 Nov 2025 20:29:57 +0900
Message-ID: <20251103112958.2961517-2-fujita.tomonori@gmail.com>
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

Add udelay() function, inserts a delay based on microseconds with busy
waiting, in preparation for supporting read_poll_timeout_atomic().

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/time.c       |  5 +++++
 rust/kernel/time/delay.rs | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/rust/helpers/time.c b/rust/helpers/time.c
index a318e9fa4408..67a36ccc3ec4 100644
--- a/rust/helpers/time.c
+++ b/rust/helpers/time.c
@@ -33,3 +33,8 @@ s64 rust_helper_ktime_to_ms(const ktime_t kt)
 {
 	return ktime_to_ms(kt);
 }
+
+void rust_helper_udelay(unsigned long usec)
+{
+	udelay(usec);
+}
diff --git a/rust/kernel/time/delay.rs b/rust/kernel/time/delay.rs
index eb8838da62bc..b5b1b42797a0 100644
--- a/rust/kernel/time/delay.rs
+++ b/rust/kernel/time/delay.rs
@@ -47,3 +47,40 @@ pub fn fsleep(delta: Delta) {
         bindings::fsleep(delta.as_micros_ceil() as c_ulong)
     }
 }
+
+/// Inserts a delay based on microseconds with busy waiting.
+///
+/// Equivalent to the C side [`udelay()`], which delays in microseconds.
+///
+/// `delta` must be within `[0, MAX_UDELAY_MS]` in milliseconds;
+/// otherwise, it is erroneous behavior. That is, it is considered a bug to
+/// call this function with an out-of-range value.
+///
+/// The behavior above differs from the C side [`udelay()`] for which out-of-range
+/// values could lead to an overflow and unexpected behavior.
+///
+/// [`udelay()`]: https://docs.kernel.org/timers/delay_sleep_functions.html#c.udelay
+pub fn udelay(delta: Delta) {
+    const MAX_UDELAY_DELTA: Delta = Delta::from_millis(bindings::MAX_UDELAY_MS as i64);
+
+    debug_assert!(delta.as_nanos() >= 0);
+    debug_assert!(delta <= MAX_UDELAY_DELTA);
+
+    let delta = if (Delta::ZERO..=MAX_UDELAY_DELTA).contains(&delta) {
+        delta
+    } else {
+        MAX_UDELAY_DELTA
+    };
+
+    // SAFETY: It is always safe to call `udelay()` with any duration.
+    // Note that the kernel is compiled with `-fno-strict-overflow`
+    // so any out-of-range value could lead to unexpected behavior
+    // but won't lead to undefined behavior.
+    unsafe {
+        // Convert the duration to microseconds and round up to preserve
+        // the guarantee; `udelay()` inserts a delay for at least
+        // the provided duration, but that it may delay for longer
+        // under some circumstances.
+        bindings::udelay(delta.as_micros_ceil() as c_ulong)
+    }
+}
-- 
2.43.0


