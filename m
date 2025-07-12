Return-Path: <linux-kernel+bounces-728815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B88B02D3A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 23:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2567D1AA2EF2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 21:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8982309B5;
	Sat, 12 Jul 2025 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4AMNHVM"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98A222B5A3;
	Sat, 12 Jul 2025 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752355930; cv=none; b=FQbc1mdCtXM5SgZqS6kamskq2I10zS3AfQy0q41WTzMbur4ATX2ZAKwYRY68N7NqALMOeHzzCqRIH5eSv49v+ou/uRyrZZxrzbMShkHqqGYJl+TC+I8iu/ELXLgg/jsa9LDqgP7ujaxafLGU+yoJ54ap/157yqxUmHgDd2zimrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752355930; c=relaxed/simple;
	bh=J2wN034E1ANJf8z7zTgfPajB+DTsr36981US4k79sBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XCR1VM2o+N42j0vYuFrT32MR2pS/BMxypzdm2xERaBRqKgMAaDT8QA1rzZ/Vu40Ai+PaXqgjj9DEeaAHev7LJ/lYmU0KO4GlM6qnmlvpgccnSu+E1i1nF/mpWYzMCLGlxIQ5PWQRtpEhkgYikGOxccPGxO415BNHOAqmkA4vpM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4AMNHVM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235f9e87f78so31024085ad.2;
        Sat, 12 Jul 2025 14:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752355928; x=1752960728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hExQIcvoKTg+0rOcrZXWVdh84oK5KeLOdM+0A3CpbHg=;
        b=S4AMNHVMRb+1ydb3534aeTmdf/Sw0xHKhv53kjIpYUaejm9PG7xTA81qwL2eCKEH0L
         HNf1dmaiHqw/OxbcrjZhe/HG+w0H6nZtcYMdb0WfwIaB7tEnk4tN/wWjg9GjDqZraWOl
         aYwU2uIxItO8dEJf2+zjBcyUleFb6VwLcODoVkNt18I9tQkDdLW1CmKT1QrMFycE03UO
         RMGtu35lcZC8vw2YtKEuIDMxeJWAJXs2V8BHncHWOpK1dYn7erbAEl2/pI5TUfGQCM0J
         3t1OJK/+0oMNnaTWmLmzP7B9BJJqGGhCYfcdSHG+PdMp5a/Mjq8GlbwEgDZ8GBO0JHN2
         tERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752355928; x=1752960728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hExQIcvoKTg+0rOcrZXWVdh84oK5KeLOdM+0A3CpbHg=;
        b=MDfB6xzpvGUGNII9kmZKw2kaYqX/C53wP6A3eR5+QXkYNwWLRHlM+3u+jGynA1yDu8
         sAtbJaOMFTwCbFwwi7aFOWeYTbCJTVLxJJWmZypcAzToQFD9fmCcn0muBP0/CN+/8nMn
         pTtUW8k4BF6BogmRBYnaeTSJAi/+fRi1+YUn+fJJ3e7qlEM+37pa/YOtk2zBavTRrdNb
         9Vz7aBS3Sz/gNwojOvZ4Z2iVyeVG+6osw53IxxgIXQkWMvjMETwmhhhX5q5DwXA3XM1T
         /l9X4S6V79Tr31s5gtr3O5siIEK9J5nhwNXm7KzjYHouSn9oFWIV1U3KU4Uls65dfb+r
         /5CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCnjXo4xdUURGmxtUnV0KhOOr+xT8PQnJPPwYlPzuPwjYdaulmx4xFZRReflHzHoGS9/UrspROljM8C/8MJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmzX0GRn/6X2r93WNJUo0ErGIvF39na7fg+6oBZB71jkQRT6Qq
	p1BosyMOmwTo81geSmVNQf9ZUzwqXeTpcwFEMGpRReuqFQ9xw2frB2MK
X-Gm-Gg: ASbGncsUjqAD2w2JQk8b5GyIuydVMg/vpf8v34WjNVu4eeMS8AjbSspV2FHqUQE5iDV
	BLhhYFgws4Nr76QzaCS08ueuV3tlfyPI8FFGdGtFTkCtQskupK0/OJG7TOVhMOs3W9aQp/mK8aJ
	Tf2zuqSLjb4/RU3WKeZ2e6ptEwLCaA33Yk9ogHdXYcxzEj0GdtiEAhMCeFH7adp1OY9A5Cvkf3N
	r+FaiCwjLJqXdtR4z68giTLrxXq/GVOqogIGfLGTuOnszr3PWeYr7p63bL8mq6vrUUEmxwPM3WB
	lTd92UPkpwBy0Lzgcfak7lKmoqPFm2f98g2WFPtu/LxIYrtxbsZqXzB1PT3Vis9nY1xV1dJIzh1
	h65nUuITjtMDqGRyVCsaWNGqRfP9o7UhjDvUDFZ0n9jB8AQ==
X-Google-Smtp-Source: AGHT+IG61yxEcItnZRLBCpzRu1bY9moREdTEBhg3R8F8LHZq7g2AdMJ+EkH1Plxdpo90qEBetLdPOQ==
X-Received: by 2002:a17:903:a8f:b0:22e:5d9b:2ec3 with SMTP id d9443c01a7336-23dede7d432mr121624255ad.30.1752355927891;
        Sat, 12 Jul 2025 14:32:07 -0700 (PDT)
Received: from mitchelllevy.localdomain ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb65aa2sm8003935a91.40.2025.07.12.14.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:32:07 -0700 (PDT)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Sat, 12 Jul 2025 14:31:14 -0700
Subject: [PATCH v2 3/5] rust: percpu: add a rust per-CPU variable test
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250712-rust-percpu-v2-3-826f2567521b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752355923; l=6875;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=J2wN034E1ANJf8z7zTgfPajB+DTsr36981US4k79sBA=;
 b=ujc/F9znVc9J+1BY7Iu7YhgYa/WWZ1LKlVHVug/z90X/Ix09YeqHueTf5rN3LoU+an3ffOqsi
 Dl+ePBIO/+ICPEQO8VX7uxHlAnutjF0PL44suFsx/P1hiIJUkvPQVaA
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

Add a short exercise for Rust's per-CPU variable API, modelled after
lib/percpu_test.c

Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 lib/Kconfig.debug       |   9 ++++
 lib/Makefile            |   1 +
 lib/percpu_test_rust.rs | 120 ++++++++++++++++++++++++++++++++++++++++++++++++
 rust/helpers/percpu.c   |  11 +++++
 4 files changed, 141 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ebe33181b6e6..959ce156c601 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2418,6 +2418,15 @@ config PERCPU_TEST
 
 	  If unsure, say N.
 
+config PERCPU_TEST_RUST
+	tristate "Rust per cpu operations test"
+	depends on m && DEBUG_KERNEL && RUST
+	help
+	  Enable this option to build a test module which validates Rust per-cpu
+	  operations.
+
+	  If unsure, say N.
+
 config ATOMIC64_SELFTEST
 	tristate "Perform an atomic64_t self-test"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index c38582f187dd..ab19106cc22c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -288,6 +288,7 @@ obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
 obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o
 
 obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
+obj-$(CONFIG_PERCPU_TEST_RUST) += percpu_test_rust.o
 
 obj-$(CONFIG_ASN1) += asn1_decoder.o
 obj-$(CONFIG_ASN1_ENCODER) += asn1_encoder.o
diff --git a/lib/percpu_test_rust.rs b/lib/percpu_test_rust.rs
new file mode 100644
index 000000000000..a9652e6ece08
--- /dev/null
+++ b/lib/percpu_test_rust.rs
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+//! A simple self test for the rust per-CPU API.
+
+use core::ffi::c_void;
+
+use kernel::{
+    bindings::{on_each_cpu, smp_processor_id},
+    define_per_cpu,
+    percpu::{cpu_guard::*, *},
+    pr_info,
+    prelude::*,
+    unsafe_get_per_cpu,
+};
+
+module! {
+    type: PerCpuTestModule,
+    name: "percpu_test_rust",
+    author: "Mitchell Levy",
+    description: "Test code to exercise the Rust Per CPU variable API",
+    license: "GPL v2",
+}
+
+struct PerCpuTestModule;
+
+define_per_cpu!(PERCPU: i64 = 0);
+define_per_cpu!(UPERCPU: u64 = 0);
+
+impl kernel::Module for PerCpuTestModule {
+    fn init(_module: &'static ThisModule) -> Result<Self, Error> {
+        pr_info!("rust percpu test start\n");
+
+        let mut native: i64 = 0;
+        // SAFETY: PERCPU is properly defined
+        let mut pcpu: StaticPerCpu<i64> = unsafe { unsafe_get_per_cpu!(PERCPU) };
+        // SAFETY: We only have one PerCpu that points at PERCPU
+        unsafe { pcpu.get(CpuGuard::new()) }.with(|val: &mut i64| {
+            pr_info!("The contents of pcpu are {}\n", val);
+
+            native += -1;
+            *val += -1;
+            pr_info!("Native: {}, *pcpu: {}\n", native, val);
+            assert!(native == *val && native == -1);
+
+            native += 1;
+            *val += 1;
+            pr_info!("Native: {}, *pcpu: {}\n", native, val);
+            assert!(native == *val && native == 0);
+        });
+
+        let mut unative: u64 = 0;
+        // SAFETY: UPERCPU is properly defined
+        let mut upcpu: StaticPerCpu<u64> = unsafe { unsafe_get_per_cpu!(UPERCPU) };
+
+        // SAFETY: We only have one PerCpu pointing at UPERCPU
+        unsafe { upcpu.get(CpuGuard::new()) }.with(|val: &mut u64| {
+            unative += 1;
+            *val += 1;
+            pr_info!("Unative: {}, *upcpu: {}\n", unative, val);
+            assert!(unative == *val && unative == 1);
+
+            unative = unative.wrapping_add((-1i64) as u64);
+            *val = val.wrapping_add((-1i64) as u64);
+            pr_info!("Unative: {}, *upcpu: {}\n", unative, val);
+            assert!(unative == *val && unative == 0);
+
+            unative = unative.wrapping_add((-1i64) as u64);
+            *val = val.wrapping_add((-1i64) as u64);
+            pr_info!("Unative: {}, *upcpu: {}\n", unative, val);
+            assert!(unative == *val && unative == (-1i64) as u64);
+
+            unative = 0;
+            *val = 0;
+
+            unative = unative.wrapping_sub(1);
+            *val = val.wrapping_sub(1);
+            pr_info!("Unative: {}, *upcpu: {}\n", unative, val);
+            assert!(unative == *val && unative == (-1i64) as u64);
+            assert!(unative == *val && unative == u64::MAX);
+        });
+
+        pr_info!("rust static percpu test done\n");
+
+        pr_info!("rust dynamic percpu test start\n");
+        let mut test: DynamicPerCpu<u64> = DynamicPerCpu::new(GFP_KERNEL).unwrap();
+
+        // SAFETY: No prerequisites for on_each_cpu.
+        unsafe {
+            on_each_cpu(Some(inc_percpu), (&raw mut test) as *mut c_void, 0);
+            on_each_cpu(Some(inc_percpu), (&raw mut test) as *mut c_void, 0);
+            on_each_cpu(Some(inc_percpu), (&raw mut test) as *mut c_void, 0);
+            on_each_cpu(Some(inc_percpu), (&raw mut test) as *mut c_void, 1);
+            on_each_cpu(Some(check_percpu), (&raw mut test) as *mut c_void, 1);
+        }
+
+        pr_info!("rust dynamic percpu test done\n");
+
+        // Return Err to unload the module
+        Result::Err(EINVAL)
+    }
+}
+
+extern "C" fn inc_percpu(info: *mut c_void) {
+    // SAFETY: We know that info is a void *const DynamicPerCpu<u64> and DynamicPerCpu<u64> is Send.
+    let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<u64>)).clone() };
+    // SAFETY: smp_processor_id has no preconditions
+    pr_info!("Incrementing on {}\n", unsafe { smp_processor_id() });
+
+    // SAFETY: We don't have multiple clones of pcpu in scope
+    unsafe { pcpu.get(CpuGuard::new()) }.with(|val: &mut u64| *val += 1);
+}
+
+extern "C" fn check_percpu(info: *mut c_void) {
+    // SAFETY: We know that info is a void *const DynamicPerCpu<u64> and DynamicPerCpu<u64> is Send.
+    let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<u64>)).clone() };
+    // SAFETY: smp_processor_id has no preconditions
+    pr_info!("Asserting on {}\n", unsafe { smp_processor_id() });
+
+    // SAFETY: We don't have multiple clones of pcpu in scope
+    unsafe { pcpu.get(CpuGuard::new()) }.with(|val: &mut u64| assert!(*val == 4));
+}
diff --git a/rust/helpers/percpu.c b/rust/helpers/percpu.c
index a091389f730f..0e9b2fed3ebd 100644
--- a/rust/helpers/percpu.c
+++ b/rust/helpers/percpu.c
@@ -1,9 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/percpu.h>
+#include <linux/smp.h>
 
 void __percpu *rust_helper_alloc_percpu(size_t sz, size_t align)
 {
 	return __alloc_percpu(sz, align);
 }
 
+void rust_helper_on_each_cpu(smp_call_func_t func, void *info, int wait)
+{
+	on_each_cpu(func, info, wait);
+}
+
+int rust_helper_smp_processor_id(void)
+{
+	return smp_processor_id();
+}
+

-- 
2.34.1


