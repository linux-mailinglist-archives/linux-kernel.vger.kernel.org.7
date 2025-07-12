Return-Path: <linux-kernel+bounces-728816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFFCB02D3B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 23:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FC04E0A9B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 21:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EF8231A32;
	Sat, 12 Jul 2025 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJJXpIHC"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7287A22F389;
	Sat, 12 Jul 2025 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752355932; cv=none; b=AXpy5pXffQc3gO3l7yHrkK3Y1CHcuGOOb7S4ZPW4Uuljo9U6WUge8lYbof6TwOhlhHnKabmMc2KYQL19oxyeF9a8uCuIYLWkHnuRIxHS6cF5qjxhcczxoclGkelhxCl9VorgxsGoUhnoapL0UnQOD8J02CAw6omQpDs8tH/l2Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752355932; c=relaxed/simple;
	bh=e1kjOZMlHir0QAwDPK2Mh6knOwIrBRKVgMEnFQ0sips=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=POPEYJMVg2K9nqoyYVtjuL+yMF9QvBplzgBZm52xIWbGayTV8Muk5pGRu4khaGz0Bt9r9rcqmaVxRQb4DaEHiU3qo25JuItZs4y91gw6wyr8GFLMk8pErQBkSyQz3VXalq3A4q2JPEz2r1xx6dnePOMZqJBDiVoNEELrbCPk9VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJJXpIHC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-311e46d38ddso2890512a91.0;
        Sat, 12 Jul 2025 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752355930; x=1752960730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtRQST6oRjj0LgYjY2mtVgF/hjywiLbC7jwSxYoLgQA=;
        b=iJJXpIHC1G9ehA6QxYVCLu+GdWjiEm848O7eXnlgoFg5e8uqrANwyi7yZVb0bkTT/n
         Y1DgK21+BLZXF80o6+a4nZkMhUrhnefFyAjo1IED8Ri+GXVI6foPdo4kKM5PwVBTLYnz
         fyCx6sanjb+19aO8RKDo4l7L+E9L7QUsvHHV0Ve7zUlZebMu8zyNY5ZP25YXBpwCrrxP
         0EL0xzc7sGDsVSY+esvGjrK2ZI5n6O/7588UnzdIUkzkTPZZo8NdwXNUas+gE9MuLimR
         Azf79HwD5SJCLqKzhu40DOcX3byTTwLKWxmp7H1/yagcBJk4JzTs7IVkEQF438yVexX1
         JO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752355930; x=1752960730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtRQST6oRjj0LgYjY2mtVgF/hjywiLbC7jwSxYoLgQA=;
        b=f3GgA8YYjDl+8q9PFcd0f/MVaC4qvVIiZi9t4XYYc2d5tmZU4/T7XVbp63tygMBXny
         /ni6OMaVCqYWxsUvbw2pVdFHOe239QovzYjZihEPvBHWmpbJrE9NM8rnTX+oM5xRv4Yf
         jjPGfE+9P6KdUO/bjIpZ+AlMqEMFAJwKpnQLsw3mnJfhR/2lR78zGKCV8gzw/nzvmIPS
         xuUcK3AjCaHONGZH0zqwzDAMXviw+GSO+NztXihm95CxdDRg4IqtsZvyun8J4s6aD0+K
         wibDyl8HtCirq+le89aNc9UNadudRreiQ15Gznfhfz9HHmGn00rdQwXpz6dSaBLMDZXA
         MogQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgSyd4bRh56TvMpd/20E+iV2e/9nvUGXuPtTBla+nCrdshwxmZvs2ayfcmDpek0LtdstypT8Gf+6JM3uKwBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz85E5Wt9psBwYTmFrpg5WG1ODokZ108gC8kZlmb67Z4Rd6h+b9
	IozcdNYKgM6dZYy71MLC/QGwtpXojygDROrFNCt44twxMOeiJtYZ4112
X-Gm-Gg: ASbGncvYU0xS6GjZe5MQQVJNzcvrFquCgi2XsRUaKCxHa3PKxMckviiF79w+o6bb63n
	KWhx86YK230knZhaOF3yFV0oxjh4OXtmx7ITRFF5JGpm94HjK4YSduLv/FIupvwc2qTdx0yitkE
	Q1+eZDwFGyJsCXlGZggEneBP6J/bni8tR+18TT+2+gMUAnq/Txlbu9ukdDha8G5uGfjaKZ0aY5l
	TwMZqQQFNScZobTZwQdEBZe1Bj2kR56nhSHsPoa2D1I/F2//O3Agx3jE9TB0iLFIJXKfrAx9YSg
	Jdanr4cFqF43Hul3I5v20cStYiDaTXFIK9Bwslb7ZywKm8xdc6eShTYnpi5bpX0PhTsp4hGwsWv
	ccZOawXrPpopi7oZo2Vy2uVcjbCr74gHlPRyRJukoumM/5A==
X-Google-Smtp-Source: AGHT+IH4o4Ul3dJAPkL8Zf1bVxHe/F3eh4QfvlGGzhfBDOyFuZ6X4iobwmvAQbZVaFZoUk34LWX8BA==
X-Received: by 2002:a17:90b:2f03:b0:312:e90b:419e with SMTP id 98e67ed59e1d1-31c50d7b487mr11598155a91.12.1752355929612;
        Sat, 12 Jul 2025 14:32:09 -0700 (PDT)
Received: from mitchelllevy.localdomain ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb65aa2sm8003935a91.40.2025.07.12.14.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:32:09 -0700 (PDT)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Sat, 12 Jul 2025 14:31:16 -0700
Subject: [PATCH v2 5/5] rust: percpu: cache per-CPU pointers in the dynamic
 case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250712-rust-percpu-v2-5-826f2567521b@gmail.com>
References: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
In-Reply-To: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Morton <akpm@linux-foundation.org>, 
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Christoph Lameter <cl@linux.com>, Danilo Krummrich <dakr@kernel.org>, 
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-mm@kvack.org, Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752355923; l=3148;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=e1kjOZMlHir0QAwDPK2Mh6knOwIrBRKVgMEnFQ0sips=;
 b=SNmvATz+HCHFQwUB26nikspj2mxM7yzHBgPaqP8iLy3oOOIsHr2Ff3x4m6cZ0iwMHZviz/pI0
 7ZWaguSukFNCvS4HxAy06fKXvmysfDraT3Dh5NuKZoVezP+qab4M0nC
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
 rust/kernel/percpu.rs         | 12 +++++++++---
 rust/kernel/percpu/numeric.rs |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/percpu.rs b/rust/kernel/percpu.rs
index b97d1d07a614..7458fe413f25 100644
--- a/rust/kernel/percpu.rs
+++ b/rust/kernel/percpu.rs
@@ -26,7 +26,10 @@
 
 /// Holds a dynamically-allocated per-CPU variable.
 pub struct DynamicPerCpu<T> {
+    // INVARIANT: `ptr` is managed by `alloc` and the value of `ptr` does not change for the
+    // lifetime of `self`.
     alloc: Arc<PerCpuAllocation<T>>,
+    ptr: PerCpuPtr<T>,
 }
 
 /// Holds a statically-allocated per-CPU variable.
@@ -204,9 +207,10 @@ impl<T: Zeroable> DynamicPerCpu<T> {
     pub fn new(flags: Flags) -> Option<Self> {
         let alloc: PerCpuAllocation<T> = PerCpuAllocation::new()?;
 
+        let ptr = alloc.0;
         let arc = Arc::new(alloc, flags).ok()?;
 
-        Some(Self { alloc: arc })
+        Some(Self { alloc: arc, ptr })
     }
 }
 
@@ -217,8 +221,9 @@ impl<T> DynamicPerCpu<T> {
     /// * `alloc` - The allocation to use
     /// * `flags` - The flags used to allocate an `Arc` that keeps track of the `PerCpuAllocation`.
     pub fn new_from_allocation(alloc: PerCpuAllocation<T>, flags: Flags) -> Option<Self> {
+        let ptr = alloc.0;
         let arc = Arc::new(alloc, flags).ok()?;
-        Some(Self { alloc: arc })
+        Some(Self { alloc: arc, ptr })
     }
 }
 
@@ -226,7 +231,7 @@ pub fn new_from_allocation(alloc: PerCpuAllocation<T>, flags: Flags) -> Option<S
 // don't deallocate the underlying `PerCpuAllocation` until `self` is dropped.
 unsafe impl<T> PerCpu<T> for DynamicPerCpu<T> {
     unsafe fn ptr(&mut self) -> &PerCpuPtr<T> {
-        &self.alloc.0
+        &self.ptr
     }
 }
 
@@ -234,6 +239,7 @@ impl<T> Clone for DynamicPerCpu<T> {
     fn clone(&self) -> Self {
         Self {
             alloc: self.alloc.clone(),
+            ptr: self.ptr,
         }
     }
 }
diff --git a/rust/kernel/percpu/numeric.rs b/rust/kernel/percpu/numeric.rs
index e4008f872af1..1b37cc7e5c19 100644
--- a/rust/kernel/percpu/numeric.rs
+++ b/rust/kernel/percpu/numeric.rs
@@ -62,7 +62,7 @@ impl DynamicPerCpu<$ty> {
             /// Returns a `PerCpuNumeric` that can be used to manipulate the underlying per-CPU
             /// variable.
             pub fn num(&self) -> PerCpuNumeric<'_, $ty> {
-                PerCpuNumeric { ptr: &self.alloc.0 }
+                PerCpuNumeric { ptr: &self.ptr }
             }
         }
         impl StaticPerCpu<$ty> {

-- 
2.34.1


