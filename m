Return-Path: <linux-kernel+bounces-887455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E20C384BC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4193AAD6B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9AF2F39B7;
	Wed,  5 Nov 2025 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdlFPIIK"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6A62D12EE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383751; cv=none; b=jgf0aVGWYfuMVMs0yy3m07SUVGggNn7x7xhBXUxga7z74U45QVZXh10FEs7kLDjt6XdShn5tpCVEmt6lsL1j9PI4cuGfEZWxTtlNZpZNDAeZoHNEN1ELqIzSRL55e8za00QFZvOjKlbZgv4GNE5q16C6fRxnLvu8tLTMqyGJOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383751; c=relaxed/simple;
	bh=YISdcADBQqzuvoNcCs3nt3kan2jGJvuSVytELmc4hYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eayEoYEyWJ3qRukMSqXt3uDoJOv6RKGQEU/rZcekQxjuP7DIenlmUG5j3YxVDPRf2UaqYU1e06yciTVtthwhvaO5kAKWqG5hO/52iNNjMMH7ADyKgpHyw1A9UItf6QPVjL8Du8wvWseHoiY0l7w2n+FpYv7/Rqf9d/m4Ok372so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdlFPIIK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-294fd2ca6acso11323465ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762383749; x=1762988549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6ObyT3Tt6gveKOeNa7NjmSIElr//qB7g+FJoPS22Qs=;
        b=CdlFPIIKw8nPl77hy9x+De6I2lF5QOHNGi/f6NxtdwGA7td/FlTk9Zfqz+4C3x16j7
         sivq/Ywzk8a1R/VMA2J+0lk4EbdHb/c/aVcnCGaFVshtxuhWdAVXnmZr+YPAgQh6aVxi
         d41yWYmZMJffnFvyA3UN2IsbsfXbZ/cjJa2wR+v4+VJgrrXC9MjnNJ+O/skV06NGw5fK
         OpnRAhaTc0KmzJFsBogDMDMTURzPfZN2FFRbQ0BbaSXG0F6SjL1SYzouh0Czci9LMp4t
         A53y+wzfg8x5lJHGH0v49uuavIyK0lBG0FucmgyJOlGFhDZFWQp3JYrOcjM2rHPCW6K5
         nFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762383749; x=1762988549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N6ObyT3Tt6gveKOeNa7NjmSIElr//qB7g+FJoPS22Qs=;
        b=Ixtc8bKK8/rGjgya3+ijCriquUDzF1tNsLK1IZdhiAq+ulrSgJh4DGzC9DzGUMui0b
         yZS7Zb64774Kib18MQ+1L+ZxKpKQ326lsfuh2fvPflydagH38jlGNqdV6Uo50px8FTCH
         B2vLIVUCZaGyi7ZguzBgWev3YP2Dk5C0G+5bxkYxBUckKQfzXPgXmSsmp2uK9BRc9qs8
         pqudiKkeBpWxKv9XHnHOhjx34kb18ljTUaZMqj3kmjZoAHgXOv55otwI6mx+at9YLIVZ
         Ajfkgt0OFB0zEp2tz154SKx4Z0JV3QOhRKxHGX8uv7N/ft6PJuUlLc9KJTyhriXbfFMo
         +WhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVISzOlEJa3i4DtBL8A6gK/qqwifdveInp4B/nYJhHtJz8d66mJnzq22f5f0SRkSloSjixohIhxiu+3AfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye56dzzV28EW9n1cBt/Kabje9wyjSGOY9LJ/NxGOZ0/YsrFqBm
	5tq7++KCt/2iUzAzRflPquVgj9VN1ER+DnNRZO/OAJhfCwY9ghkUUOBL
X-Gm-Gg: ASbGnctfYX1FAxmrqD/UTc3pumP7uBOJvhabDfmBhhRfShTk7T/9NY0L6ZMTDs7RqXR
	FpqKLnRoT5uy7Rl7nvCNBeTwZFTrA5Ews93yzFvRCixEl/hQhtBdd3455Lcj12Y9cbMSDXXMfyG
	thT4M5wPHefELIpcApAeMbW3eCOdAUGx4YPqxRnGBvzM1P3ZJTO4t4NYcqnGFENPRseq4tnrUfx
	+sG59kRgYfTQrwizym/aiPsfo2YMvZoCize1hak1k1/jU7G/qQ0fVGL5JOqccDqE9OXMuGnIbFB
	wRPhFlDrahRt3Ro3/UxDeO4Av8ym+iXov+z1ypcpCB9qfiHA7/8euSQBhJdwCY/OeqpmGciBwPJ
	OYYDu2n4vrDgs4DfYVYQFelsD03gnfVgnM0iQy6XmyaaIl+SXgZVFUp6j2VkGd+/L4sUgKqetA7
	2fbyDUEhPqp0bl6nDi0ndOz+4=
X-Google-Smtp-Source: AGHT+IGQIBe/+YtHTkbz7bKrh6tH5nkd3eR2+Az8/eXaBw/mQbeZbYIkMzrirQWpuRr+NTG9Wz3U+w==
X-Received: by 2002:a17:903:3ba4:b0:271:9b0e:54c7 with SMTP id d9443c01a7336-296509646ecmr14131025ad.11.1762383748599;
        Wed, 05 Nov 2025 15:02:28 -0800 (PST)
Received: from mitchelllevy.localdomain ([131.107.147.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096839asm6325645ad.13.2025.11.05.15.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:02:27 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Wed, 05 Nov 2025 15:01:14 -0800
Subject: [PATCH v4 2/9] rust: cpumask: Add getters for globally defined
 cpumasks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-rust-percpu-v4-2-984b1470adcb@gmail.com>
References: <20251105-rust-percpu-v4-0-984b1470adcb@gmail.com>
In-Reply-To: <20251105-rust-percpu-v4-0-984b1470adcb@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Morton <akpm@linux-foundation.org>, 
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Christoph Lameter <cl@linux.com>, Danilo Krummrich <dakr@kernel.org>, 
 Benno Lossin <lossin@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tyler Hicks <code@tyhicks.com>, Allen Pais <apais@linux.microsoft.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-mm@kvack.org, Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762383744; l=3255;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=YISdcADBQqzuvoNcCs3nt3kan2jGJvuSVytELmc4hYw=;
 b=2O8l3qrtYhENMJ4ZqlEU7sc/NrZB0x6OGnOnA5sdLydLEIj+Vo8YliGfFxguuE1tvcxcUt3d7
 91hJBW1anFIDRnuwpi6vwLUehbr2kbnrL4UdQbknVNHrFetNwdFUNHM
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

Add getters for the global cpumasks documented in
`include/linux/cpumask.h`, specifically:
- cpu_possible_mask
- cpu_online_mask
- cpu_enabled_mask
- cpu_present_mask
- cpu_active_mask

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 rust/kernel/cpumask.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/rust/kernel/cpumask.rs b/rust/kernel/cpumask.rs
index b7401848f59e..a6a130092fcb 100644
--- a/rust/kernel/cpumask.rs
+++ b/rust/kernel/cpumask.rs
@@ -77,6 +77,52 @@ pub unsafe fn as_ref<'a>(ptr: *const bindings::cpumask) -> &'a Self {
         unsafe { &*ptr.cast() }
     }
 
+    /// Get a CPU mask representing possible CPUs; has bit `cpu` set iff cpu is populatable
+    #[inline]
+    pub fn possible_cpus() -> &'static Self {
+        // SAFETY: `__cpu_possible_mask` is a valid global provided by the kernel that lives
+        // forever.
+        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_possible_mask) }
+    }
+
+    /// Get a CPU mask representing online CPUs; has bit `cpu` set iff cpu available to the
+    /// scheduler
+    #[inline]
+    pub fn online_cpus() -> &'static Self {
+        // SAFETY: `__cpu_online_mask` is a valid global provided by the kernel that lives forever.
+        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_online_mask`
+        // may change its value.
+        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_online_mask) }
+    }
+
+    /// Get a CPU mask representing enabled CPUs; has bit `cpu` set iff cpu can be brought online
+    #[inline]
+    pub fn enabled_cpus() -> &'static Self {
+        // SAFETY: `__cpu_enabled_mask` is a valid global provided by the kernel that lives forever.
+        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_enabled_mask`
+        // may change its value.
+        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_enabled_mask) }
+    }
+
+    /// Get a CPU mask representing present CPUs; has bit `cpu` set iff cpu is populated
+    #[inline]
+    pub fn present_cpus() -> &'static Self {
+        // SAFETY: `__cpu_present_mask` is a valid global provided by the kernel that lives
+        // forever. Since we wrap the returned pointer in an `Opaque`, it's ok that
+        // `__cpu_present_mask` may change its value.
+        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_present_mask) }
+    }
+
+    /// Get a CPU mask representing active CPUs; has bit `cpu` set iff cpu is available to
+    /// migration.
+    #[inline]
+    pub fn active_cpus() -> &'static Self {
+        // SAFETY: `__cpu_active_mask` is a valid global provided by the kernel that lives forever.
+        // Since we wrap the returned pointer in an `Opaque`, it's ok that `__cpu_active_mask`
+        // may change its value.
+        unsafe { Cpumask::as_ref(&raw const bindings::__cpu_active_mask) }
+    }
+
     /// Obtain the raw `struct cpumask` pointer.
     pub fn as_raw(&self) -> *mut bindings::cpumask {
         let this: *const Self = self;

-- 
2.34.1


