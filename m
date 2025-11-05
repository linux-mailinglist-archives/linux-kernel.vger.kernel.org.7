Return-Path: <linux-kernel+bounces-887462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8458C384B9
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 551204F584A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510C22F7475;
	Wed,  5 Nov 2025 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDfHChHo"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF792F60A2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383760; cv=none; b=ux2DWi6FlGQzUyEIitPxeXcNLEYQrxjAvweS9LOCqmEcd5Wht131+AQh93OXVn7onxY0hUCQiUCMY3i8AuqQz1VSOjhitkmr5N1bfIEFH9WrLk8Ejky0uAfl4+mRucpEJkzOI2oS4q1pFSfWz2m1TmPIEIIbg5Tutw498E3QxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383760; c=relaxed/simple;
	bh=D3RYV7HLnBtitWmFErq2p8agS2TaxcSWS/fZMuq/eYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PfKy2FArSN07AYNcfEkE4tMUOWpHF7Idsd289/7BUJbaRytCvGJ6e+vfauvAzvCSDhjrh5o1hRH4VbO3GBC0lV0lPe6M/ZXbhi27zdCHHqiKzztYS7cFJbrJHVUWEQONNUByz6mcdAIM9Y8ZoLSllqUZm/hPRW5bkEB/UBrO8Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDfHChHo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29470bc80ceso4089075ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762383758; x=1762988558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CKxB9LH52Z/bMQCpny1rQR1F6MuknwX7Uens3YkL/M=;
        b=nDfHChHoUBguPjIV+y5+ojr9zcj4KRUwDC4qQ998BvSYl1r77zW+Mz0RvKbwnKq2of
         +lHcn6pJNGr6swlbMwE3iFXmaHWqF5TTsTXis7DVyqcSh2pJbppnNnvK503KkQhIGJcC
         HxmJB+T2PttBwOM3PDD/BJBDNlErUuBoKOQMnSyiivJ8RGXt+70ChjU86XZip2BgdPL2
         84FUO4lkBrZive47VG6tJP5Ukn6tjEOgQYuixiIOzrMzXEzi/6lYtvOjCkksuZuLz+WA
         gPaAz2+8xcHF46RlMr25NQcAB3W9swp/YgXE99c8o0YXDU0wcEtC85GIXpzcAostl++r
         4yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762383758; x=1762988558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4CKxB9LH52Z/bMQCpny1rQR1F6MuknwX7Uens3YkL/M=;
        b=PckZleXrOXFibQtdVXWW9GgK7myUpIYYIYaQrSm/3sHPmAMw8r3A/NNH7S4LXZKtjq
         zkSOi2ksIh9x7Ynzoq3M18GosRI6Yg0VdntI79UCAknB85MZA77PDYJJABd4QZxmn4NW
         bZnmrIQzQCCPXEGDMsQkIBGcD/mBOfkFWDTgg4PCzGckZxX2wprGcOoSHy53hYKTkS4S
         +Ha2QxO4PQPRpFufePwkdf38iGc71V74AKazFcShI1HKvXDFX3tNt0y3+KVTQld92Q4R
         t9wXU0F4i59z5EI/jHOUaEWwCyHvNypWvcG6mCTrDE8IHw/K5onhnfoZihEa2ppxh53W
         vtvA==
X-Forwarded-Encrypted: i=1; AJvYcCVihHgoBgqtyfODVC5sZUTa/R3Wpwfai6TyKcjUaVpqPbFlzkVnhdJFalJeVr4i+ZNy0dNaXHKaA9N6kT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA9XREZRhaiKhoTjX9fJ2MBTRNiCcPBQDusRiB2dCB+m6t7MLY
	ST7+ISoGO/8ABsILgGpXnqagr4XDassX7sMdUxmkVAhsI5cs1r7j/0va
X-Gm-Gg: ASbGncvbQJoREV8KtOUXHB1qXPUpuLs9amdUalVUpR3nAt4IKtRYxMlJ9dSCyCSGYy1
	zQGTj0XxXGU4rWK4kywslXxwYZ6IoaJsCXJs2qHSxVMPcpkHHDTpdBkr5Oo5gxF8slo74vLepmN
	6F6sdXw4BWjEbmkkMww5S7HvKqH7gK26RERTK3WUKuB7wbzZ6zm5WlMn+GdmdRpofoRtB+vmO07
	BBGoPjRM+OfwO55Ec0BWzHmusU3J4sS0PtD3wU4jzJyLP7xHI8+BaBJ/PJeXDN5Ltl4DGBfcZwc
	d4/5lYdzHZF8j7XJ+Peb53RVKX5l8Shj2KEpvWsKAioEDmuOM15YkzZyEDZ9U506GChMjQE2XCA
	g0uESGAcC2kyuLnTPIfErdlaBVq7hbwAfpHAhCr/6kWa6f1xN5rK1trPOeo05iaWqe2AwgsRM4j
	X0kLYjKN6Kn7E4j+DIq8tD+dmUKh25ifGIEA==
X-Google-Smtp-Source: AGHT+IHhgn+8YeMFZ6PkDMcRo+YCf1hZhzierVrKIefbBTSFSntXm/b76xNV6gdhRNX1LQibgdMpiQ==
X-Received: by 2002:a17:903:19c5:b0:295:50f5:c0e3 with SMTP id d9443c01a7336-29650c5af22mr13633165ad.14.1762383757680;
        Wed, 05 Nov 2025 15:02:37 -0800 (PST)
Received: from mitchelllevy.localdomain ([131.107.147.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096839asm6325645ad.13.2025.11.05.15.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:02:37 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Wed, 05 Nov 2025 15:01:21 -0800
Subject: [PATCH v4 9/9] rust: percpu: cache per-CPU pointers in the dynamic
 case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-rust-percpu-v4-9-984b1470adcb@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762383744; l=3408;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=D3RYV7HLnBtitWmFErq2p8agS2TaxcSWS/fZMuq/eYY=;
 b=F3SsT9YaklVAwHq+tWc26blxo+XKhI/hNXdvlsqIbyeoSRfdd0pXKRoUeMLZ44FBDlWmhxL/e
 gWSNZYhRA9NAl0i5KEtL+ADOegGqjFQajhB5DktuXDNdnfmDxdg1IZC
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
 rust/kernel/percpu/dynamic.rs | 22 ++++++++++++----------
 rust/kernel/percpu/numeric.rs |  4 ++--
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/percpu/dynamic.rs b/rust/kernel/percpu/dynamic.rs
index 99acbf6363f5..dcf3e1c4f7a9 100644
--- a/rust/kernel/percpu/dynamic.rs
+++ b/rust/kernel/percpu/dynamic.rs
@@ -72,6 +72,9 @@ pub struct DynamicPerCpu<T> {
     // INVARIANT: The memory location in each CPU's per-CPU area pointed at by the alloc is
     // initialized.
     alloc: Option<Arc<PerCpuAllocation<T>>>,
+    // INVARIANT: `ptr` is the per-CPU pointer managed by `alloc`, which does not change for the
+    // lifetime of `self`.
+    pub(super) ptr: PerCpuPtr<T>,
 }
 
 impl<T: Zeroable> DynamicPerCpu<T> {
@@ -83,9 +86,13 @@ impl<T: Zeroable> DynamicPerCpu<T> {
     pub fn new_zero(flags: Flags) -> Option<Self> {
         let alloc: PerCpuAllocation<T> = PerCpuAllocation::new_zero()?;
 
+        let ptr = alloc.0;
         let arc = Arc::new(alloc, flags).ok()?;
 
-        Some(Self { alloc: Some(arc) })
+        Some(Self {
+            alloc: Some(arc),
+            ptr,
+        })
     }
 }
 
@@ -115,15 +122,10 @@ pub fn new_with(val: &T, flags: Flags) -> Option<Self> {
 
         let arc = Arc::new(alloc, flags).ok()?;
 
-        Some(Self { alloc: Some(arc) })
-    }
-}
-
-impl<T> DynamicPerCpu<T> {
-    /// Gets the allocation backing this per-CPU variable.
-    pub(crate) fn alloc(&self) -> &Arc<PerCpuAllocation<T>> {
-        // SAFETY: This type's invariant ensures that `self.alloc` is `Some`.
-        unsafe { self.alloc.as_ref().unwrap_unchecked() }
+        Some(Self {
+            alloc: Some(arc),
+            ptr,
+        })
     }
 }
 
diff --git a/rust/kernel/percpu/numeric.rs b/rust/kernel/percpu/numeric.rs
index e76461f05c66..23a7a09216d0 100644
--- a/rust/kernel/percpu/numeric.rs
+++ b/rust/kernel/percpu/numeric.rs
@@ -22,7 +22,7 @@ impl DynamicPerCpu<$ty> {
             pub fn num(&mut self) -> PerCpuNumeric<'_, $ty> {
                 // The invariant is satisfied because `DynamicPerCpu`'s invariant guarantees that
                 // this pointer is valid and initialized on all CPUs.
-                PerCpuNumeric { ptr: &self.alloc().0 }
+                PerCpuNumeric { ptr: &self.ptr }
             }
         }
         impl StaticPerCpu<$ty> {
@@ -78,7 +78,7 @@ impl DynamicPerCpu<$ty> {
             pub fn num(&mut self) -> PerCpuNumeric<'_, $ty> {
                 // The invariant is satisfied because `DynamicPerCpu`'s invariant guarantees that
                 // this pointer is valid and initialized on all CPUs.
-                PerCpuNumeric { ptr: &self.alloc().0 }
+                PerCpuNumeric { ptr: &self.ptr }
             }
         }
         impl StaticPerCpu<$ty> {

-- 
2.34.1


