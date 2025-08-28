Return-Path: <linux-kernel+bounces-790585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7064B3AA80
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDA61C86CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B226343D69;
	Thu, 28 Aug 2025 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa082iQd"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A543431E3;
	Thu, 28 Aug 2025 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407668; cv=none; b=s5q/jRQp7LLKmJjGMq51vdMBVd7wgHsDXOX3y3RyJcnmBSK8GFf7EzufGfSylF4fDlHT3eOiuE428fPaEg6WygM1Zqj13KLgL3DP2r97M5SXZXk/1aH68UwhvX5LEhZdXin892IJTF3W0ktAw34hanKqK+X4HJz46B13pUdIaVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407668; c=relaxed/simple;
	bh=E3oVGdPxyaJFgaTqf2y8btrQgXMEMCM/zUm8ETp1y5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JIp/rBzbGngawNhVqToFHYPBI74CbmFUxRWh4bp2RrwL40coaN5mA7cIpc+QCU5XZxuUgUrrANMbxvdA5Bs6Nn3c+K/3Jx9hXZKpcQyMPdlE3Hk4w8c2Q/ANG6V8AxLREluXmo70UoVVnTPsv2cOExS+COVqSwhoDN1QtC48JCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aa082iQd; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32783de3e87so1355578a91.0;
        Thu, 28 Aug 2025 12:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756407665; x=1757012465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PofwN+sl6dw2dDWCuPOORWJpa23jS48M28BtJ3SIOeU=;
        b=aa082iQdXbXlU8y2SKgpyUO7arztkbj6ukbBvWkbqus/rKXYcMm1mz/NqSATwizwUy
         G7dGJ6lJvQdjOOdDd5qRZLFng5fQKJTBIncHNrzIPnxcnSg1So5fJkMhHlsAxXQZLqc7
         gbefAUc/8jH1d+dhcHPHOe4ScCUtQ/+XSivakZ5YO6UlRQKyX3pS59b3hZ4F6prZVgSh
         T/p773XFEi62RO3zn6aC356JVIJfkGPLY7yZFuvVQ6aqhG5eGKJX7KbYkp1TDczYlZ7C
         vIHLQtW5k9aXYqvh/MmNGYrEpYrXCMrwqyF8bmBHxuG/8U2GHP0FTqv+6d0G2XqUQxNO
         iG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756407665; x=1757012465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PofwN+sl6dw2dDWCuPOORWJpa23jS48M28BtJ3SIOeU=;
        b=kaDvyF7BE8GuN6T2CbgESh+PcSn9lVLhrSK6gT+ar0WPIljLeEhEW6nHYUxZh95e99
         3EUUK6oPzDF1Cco+OJqIL91aIRySZs9ZBRRvahnk2vbb+HVvbuk6uswDZ3z0aB6wW7VO
         ff5zScn4G5HIt2/w/Xx8ZIL1kntBpxXVQVKlCf0GrdPfq9AOdQH+WqH9swXIsL3IhMch
         IXW6xLgNQ9i3/v9/fNfPo1iKeDY44lSuTLXI6in8SOHbsO2IUT1Pak6XD5++WOrZ01oZ
         39HbJGIWFKTtcdgxCfMfqsjVZ/HKY4GYS0YZZ0iYJGiL7SziRVnku6eX93FdlA7MQ0Ug
         cOOA==
X-Forwarded-Encrypted: i=1; AJvYcCUT9su3dRvy3sgQu6mrODPdul5ex0pjntb8+1y0fr0Fqx5frgJzr485WpleEjBGFQSO491VdL+o5UbsGdM=@vger.kernel.org, AJvYcCVIVfflyDUchTVJtcCJQfITHIjkMY1ug1DMWalHWtBaTKuL/uQN+hvqDEJJOyV4DVWvK+42rTR1x4fyD1fH31Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk5NHap/GWT2P1DUbXJbV5AvP2H7Ei64gqEWTnWvzvPBQ93Ex7
	ifCg7qPO8zI0yx7YrOsxQFxlJgJSTzVWJQUiT7taI2/D4Vchvhn8FzOdRZ1pXSux
X-Gm-Gg: ASbGncv5BcT21VyQMVdvJh2lLX+wBnT6VtYM29A0tMaSfGNNItQ4db4F8fZUc1GaHBX
	10wz3FHQHWpxRQXTMAa4+lvkQdFEZL4O9QXZIGNWUDEV5qPT/4eAbw9XByFPjCfoVxg8mOPc3rH
	V+C15EQrayi5sa5kIwDidx61fk+JPP6IIXiTX2xakazzSKxzykK61bURJQ2OF0GntrOsE/vWttX
	rRVuAZGaEgMKBVP5pU9TDvmLsHG6dzlhdoqJIvIV2QiRRINJ94evnpw6RIorDJKsREPvuw3uBHD
	4LrZM58ODBkcCtcFAOMJKh6kTq1Fknu8Uv3RqmnB/eXpVDxyGVGf2XPNm1bj/geBhMupna5LeKA
	CIJlIZLZmddiekyaM4fBOUdrDP5ywRBKY07GvXsCS+KGfxuYwsxukGdSa
X-Google-Smtp-Source: AGHT+IFS3JVNNhR3zNJyk8gBLIrCVFra0me8HIrQNR73Yc/VuaZrqjY1lLTK7uNwZToUsptvYvMAug==
X-Received: by 2002:a17:90b:52cc:b0:327:d4e9:c4ea with SMTP id 98e67ed59e1d1-327d4e9c960mr1680821a91.4.1756407664152;
        Thu, 28 Aug 2025 12:01:04 -0700 (PDT)
Received: from mitchelllevy.localdomain ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da8e5ad5sm405729a91.18.2025.08.28.12.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 12:01:03 -0700 (PDT)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Thu, 28 Aug 2025 12:00:14 -0700
Subject: [PATCH v3 7/7] rust: percpu: cache per-CPU pointers in the dynamic
 case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-rust-percpu-v3-7-4dd92e1e7904@gmail.com>
References: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
In-Reply-To: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Morton <akpm@linux-foundation.org>, 
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Christoph Lameter <cl@linux.com>, Danilo Krummrich <dakr@kernel.org>, 
 Benno Lossin <lossin@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org, 
 Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756407651; l=3005;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=E3oVGdPxyaJFgaTqf2y8btrQgXMEMCM/zUm8ETp1y5c=;
 b=EzwFDp+SiJdNfpKZyQsIfCPW4wWXpRD3O7suWpzgYPTt0ZCT0wH9WnekbdPgj5jQlRyhAXkKS
 RUSwrYD8Pa1BCS54cUq+TOw4bSu3hPrC3vCTdt3FbdvBg5XQJzJ5KH3
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

Currently, the creation of a `PerCpuNumeric` requires a memory read via
the `Arc` managing the dynamic allocation. While the compiler might be
clever enough to consolidate these reads in some cases, the read must
happen *somewhere*, which, when we're concerning ourselves with
individual instructions, is a very high burden.

Instead, cache the `PerCpuPointer` inside the `DynamicPerCpu` structure;
then, the `Arc` is used solely to manage the allocation.

Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 rust/kernel/percpu/dynamic.rs | 8 ++++++--
 rust/kernel/percpu/numeric.rs | 4 ++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/percpu/dynamic.rs b/rust/kernel/percpu/dynamic.rs
index aad08e4b4251..8683e94bcd9f 100644
--- a/rust/kernel/percpu/dynamic.rs
+++ b/rust/kernel/percpu/dynamic.rs
@@ -58,7 +58,10 @@ fn drop(&mut self) {
 pub struct DynamicPerCpu<T> {
     // INVARIANT: The memory location in each CPU's per-CPU area pointed at by `alloc.0` has been
     // initialized.
+    // INVARIANT: `ptr` is the per-CPU pointer managed by `alloc`, which does not change for the
+    // lifetime of `self`.
     pub(super) alloc: Arc<PerCpuAllocation<T>>,
+    pub(super) ptr: PerCpuPtr<T>,
 }
 
 impl<T: Zeroable> DynamicPerCpu<T> {
@@ -70,9 +73,10 @@ impl<T: Zeroable> DynamicPerCpu<T> {
     pub fn new_zero(flags: Flags) -> Option<Self> {
         let alloc: PerCpuAllocation<T> = PerCpuAllocation::new_zero()?;
 
+        let ptr = alloc.0;
         let arc = Arc::new(alloc, flags).ok()?;
 
-        Some(Self { alloc: arc })
+        Some(Self { alloc: arc, ptr })
     }
 }
 
@@ -102,7 +106,7 @@ pub fn new_with(val: T, flags: Flags) -> Option<Self> {
 
         let arc = Arc::new(alloc, flags).ok()?;
 
-        Some(Self { alloc: arc })
+        Some(Self { alloc: arc, ptr })
     }
 }
 
diff --git a/rust/kernel/percpu/numeric.rs b/rust/kernel/percpu/numeric.rs
index 4de93f653f0e..3412c2de85fd 100644
--- a/rust/kernel/percpu/numeric.rs
+++ b/rust/kernel/percpu/numeric.rs
@@ -20,7 +20,7 @@ impl DynamicPerCpu<$ty> {
             pub fn num(&mut self) -> PerCpuNumeric<'_, $ty> {
                 // The invariant is satisfied because `DynamicPerCpu`'s invariant guarantees that
                 // this pointer is valid and initialized on all CPUs.
-                PerCpuNumeric { ptr: &self.alloc.0 }
+                PerCpuNumeric { ptr: &self.ptr }
             }
         }
         impl StaticPerCpu<$ty> {
@@ -71,7 +71,7 @@ impl DynamicPerCpu<$ty> {
             pub fn num(&mut self) -> PerCpuNumeric<'_, $ty> {
                 // The invariant is satisfied because `DynamicPerCpu`'s invariant guarantees that
                 // this pointer is valid and initialized on all CPUs.
-                PerCpuNumeric { ptr: &self.alloc.0 }
+                PerCpuNumeric { ptr: &self.ptr }
             }
         }
         impl StaticPerCpu<$ty> {

-- 
2.34.1


