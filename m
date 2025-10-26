Return-Path: <linux-kernel+bounces-870363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E78C0A856
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A345B189FDDB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA90E2DA74D;
	Sun, 26 Oct 2025 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJkZvO94"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14502E040A
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761483332; cv=none; b=LUECSI0ZWlPxKMP7QAiv/NzyFcNUjHFwbnNpqhuXlgDxkXXyzPe7A+oWcvFxzKMoprDDW041CB4AW6GyooauuWNQUYRAc/ONUdEv+BZ+IWc6d2mFXRSgKQAb0dRh0N5gz0YdrH9+oO7VV4eDe9Nv8pFcaZZjoZc5tKZPHLzrCsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761483332; c=relaxed/simple;
	bh=BQH7hgD7+xt4W7z/S368Lm76rShNO58wKexO34QQko8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gB1qj+YNNc8nnLWg4zmLY0NL4E48TR2MThGtaDiwFATdJgPFnsLRN26bt6Hlwyt0M+QHlMhXUgh2pYSyrMTnVpIf1ZdcGVJ/81shUhbFNC1PqtaFRbxjvDTqlTqTT72Rhcfb5fgJovNI/hMy19zq8XbWbCawF8cWEYTS+SJLhrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJkZvO94; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-290cd62acc3so43606415ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761483330; x=1762088130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpL5GRYYewBmCb3HYHj7NyzEFHr83PdgBMD+j8Wif4Y=;
        b=AJkZvO9483JwtKIc9EPOy0w5aYFQiuH3yJ2EqdHKKpXaTikU4mJ1S8ZX9Jm6t55WYa
         iPvCixebq8mm+LX5BURYFz6vbhnmhI0kHKZef8fkEPeQ5cFYLxxNrpo+8iB90QTNv8d+
         6HduCaucLIlnsxeT59Vk0YhktEDL4K7WLbz06GMhu1O60d+dz2bSltHflb5RNbQomjAT
         8nh/TqXCeHtxYpaF20OkC2VOe3u5xf3xjiZrMkXYtmDvlr5L1MGdgjAQmPwHC+cJ3G//
         zt5hvRpjA+FbaRbkcBSza99FvIYhutYQ/QNuSmvXlW1cLaGzT0QFhqM8KPIZOS3/8eYZ
         Dm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761483330; x=1762088130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpL5GRYYewBmCb3HYHj7NyzEFHr83PdgBMD+j8Wif4Y=;
        b=h5ZpLuw4QUQL9lNIvcBR88dnau0oW8Y0tshmZQr2zmIgU8i0QlN/Fjz5s9q/1XtFzs
         hZVRxvNhZFUC6GpfWsYQF+GciNoGt35gs2rnACBs/FFQAq0KK6iVnLzGu+Kl4A3CPM7s
         Pxm7yxWqtiLPSYYMWyq0kYw8tRUEKmZql+PynZrYnYoSWqDyhynty3/wSqXkDFWUoBHh
         zLgVXqCX9otHYmD77OPDgc4s27GZgpKgTurHmwyT3d17H+YSHDWX4I9Zr02WsJy81gaR
         bgb4O1y4gxVKc/lvFQ7DM3ksZ7CaAVvTOKn6QplLo6KbgIk+PJXTyTBwSy4hrpmdl0pW
         DFFw==
X-Forwarded-Encrypted: i=1; AJvYcCWBpaFpZ7FXfAZtGj4QzyIkaHvXLA9CScm2cGoILUsFMWe3ixuiyqGqAwZk8+NUW4dg4k9kBn207YVbClA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfi3SWwUHLgEAXyeRwv6DFyh2Bwz16OsW4pTXRLJTPjRXYb6BF
	KjnTCjQpVpXXZI8mYS8+42gDGLbCWRJ9k/F5ileWxm6WU02e46q0AxhC
X-Gm-Gg: ASbGncv2J+/mykOsRuvtthssebiLC1b8FzQbCKaVOfXnVwa7ZkP+s6n3gaz45lWyTbw
	9wpvQxSKCKaMpr8k5S4zNxsI1SPXGMg3kVf2ExMPNeaiaeYl6eiyZOyuCOJLsgwRUXnmHZxkw3K
	0bmau2RhIsaLIfP9QhH5KCKsPVFvk4EMlppoi+ENpNhvSp4dsFB6izNTD6ZTQpy8af027VYCiwi
	px24tueykwX3ah7E3AuHeKzoO1vfZXW/+mf8HLuwkREE+gUkbWsirlQSc7mLPpoKoR3EdWjJtbP
	MPRTS6PwCYo7as5c7udQqdJGFLlnxMBYYAThx/aMsSvqMcBfqfXjuSOWapmMVWs24PYCvB4DhMT
	0TbAwFm7PNgmLMhoClno06RppJDUsneMTB7ltH5tE9BHcyUMBO7wL9pmtvVW9F+/mH7kpupeYqR
	DZL3O6FEej6G05yCsITAx9O8PVG2vRm+IRl3XcU3iV0cTl/uZI
X-Google-Smtp-Source: AGHT+IGbWGIIOzAhr1d2Z5UjYERrsJ5I4YvcxAZSP1AAcn2uDneNWiOnjZDQ7TMXZAuZy/JTyzooJw==
X-Received: by 2002:a17:902:dac3:b0:277:3488:787e with SMTP id d9443c01a7336-2948b95c1f5mr102003455ad.12.1761483329901;
        Sun, 26 Oct 2025 05:55:29 -0700 (PDT)
Received: from bee.. (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bdb2dsm4641759a12.5.2025.10.26.05.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 05:55:29 -0700 (PDT)
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
Subject: [PATCH v3 1/2] rust: add udelay() function
Date: Sun, 26 Oct 2025 21:54:57 +0900
Message-ID: <20251026125458.2772103-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251026125458.2772103-1-fujita.tomonori@gmail.com>
References: <20251026125458.2772103-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add udelay() function, inserts a delay based on microseconds with busy
waiting, in preparation for supporting read_poll_timeout_atomic().

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/time.c       |  5 +++++
 rust/kernel/time/delay.rs | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

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
index eb8838da62bc..0739b75fb9c3 100644
--- a/rust/kernel/time/delay.rs
+++ b/rust/kernel/time/delay.rs
@@ -47,3 +47,42 @@ pub fn fsleep(delta: Delta) {
         bindings::fsleep(delta.as_micros_ceil() as c_ulong)
     }
 }
+
+/// Inserts a delay based on microseconds with busy waiting.
+///
+/// Equivalent to the C side [`udelay()`], which delays in microseconds.
+///
+/// `delta` must be within `[0, `MAX_UDELAY_MS`]` in milliseconds;
+/// otherwise, it is erroneous behavior. That is, it is considered a bug to
+/// call this function with an out-of-range value, in which case the function
+/// will insert a delay for at least the maximum value in the range and
+/// may warn in the future.
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


