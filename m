Return-Path: <linux-kernel+bounces-790579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69807B3AA7A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1075DA0224D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E718C33CEBD;
	Thu, 28 Aug 2025 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFc0p7nA"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E4132BF2E;
	Thu, 28 Aug 2025 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407658; cv=none; b=TLR0q3bVItUZLBkuBZbrkleOt+d0Pie/0zuDjkOJvreYpESQFDDcfV3i9SJnAKI18DVajsDz8vuGottF/LFKMagQuBsWWKa1yjqYYLBHZ9BfnH3Aoxd5S+aDw04IUobDJEAovEQSJgxYKuJ3l4plICQm1JXqUPPCo9/QwGxNxyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407658; c=relaxed/simple;
	bh=pd7OPcbrPdAWI/7kgDpMFHa6ITv6ppIv2SVJeXLx/4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+fc1s6bbedgBCx8qpBGDjqzzEjY1HDIwexI72q0EBniC+nzD6ZcvSqvXaB/8ARqYvONGDJWL6oJn/TgWeVbG7nVRjppT3xmMuBqPA41uJ9+Qu5HDXS7pKSzwT3VXQTbfna2n6oBCBtovbc7BNrhjqUJw2epn4xYoRYfIXiGOUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFc0p7nA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-327b657924dso794134a91.0;
        Thu, 28 Aug 2025 12:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756407656; x=1757012456; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZhDUhaFQNfQlBtAcofKP9r1jz8p+0mi3JI78z3ft6A=;
        b=YFc0p7nAhg/xQuglDzFbT5NiUHgqon5JW6o/Nl7t0AeRyboh0se/ikxuKjBJ58BEHf
         12fTfljQtljhy0ZOgyHCk1Dnd8PBao/T6DCwGXqE1WcnVA4rcmxqqfRsHTKccaz2dmAR
         8QU3jcTPv7ELMhJPYrsB8uQKhSU+NQgaymdqXSncfGRKYMmh8m20z0JTiNmdTEAfQUoy
         qtLf6Cx8dkGwXQMDEThnH3ungB4dE8b7cocopZRD3PKgLsc/OeB39pNrUmm0IZOr2q6j
         dI6XqWxlAU9jRpOqaw6+HOQtMJQsa040uJKOzXUrTg0NCOP5E5n0I3KzH6K5tkvNFHIy
         2+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756407656; x=1757012456;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZhDUhaFQNfQlBtAcofKP9r1jz8p+0mi3JI78z3ft6A=;
        b=hpILNBjwOAJnfGjovXXvWeSwMhfp3OX53NnuOeGJQs1RsPaMNEyLCDv2I0l0FBqD7p
         svpLDtgTeMQFPVUT8ETODWs6IuKi/HLMnY5QzsoGV9J8ZeWY/RZodwHroUZvj8/vcn5h
         WS1675gmflS6epjyWHSqPzi540hK62FlkyV4iClq3+Ilpx24cDIsUJEP8XWaaXu9NiYZ
         HDdL9YrgCKtEFPzRxwFvtAffpMDvM1MYlS9yNnPQvnERAchZ/BdQv7GTrvckLv98QGgM
         ZZy047Zt752M6+8seBaKrSyEYZgIQU2q3wcMpk5ril6EC2+/5JcU7DYTUCnAwvw8gfQw
         byHA==
X-Forwarded-Encrypted: i=1; AJvYcCVvX+2NIQn8XqbaAJ5CXx453BP9qOKkmNxPlxYFPuax/1bxICc8E6ttfgERdIKIfrMVF3qwmxGT/4oFi7E=@vger.kernel.org, AJvYcCX0+kaTnnFpGk0mndSq63CMjat+EP/9dkDYSSehUt7QOQWdvH5S1LDrUtX8Wu+LOQQsuZ76mmrBbFVUOxHkk88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJEVbI54DRlQirfkIVA/9ZDj21XlYSx5y2LSIf8hgq+LBtp4r
	cRbdoS5rSSMrvfUxJkxHCF1SIm9bu38Z2TYdk82Wu+1OapYlLvlh9xpY1Xz+7m4V
X-Gm-Gg: ASbGncv26hg0qoWBgMI2FGh4SFROKnw/jiT7YlwwFajGx03qGKhK0ZCfZ1LBkCtnIDU
	rIQrMqtIO13rMwZSffn2yxeiM4kOWQqKQ/EFt5yzJZM/Nww0WfmxHZk6LTACWqlonDiNhKEVsPj
	moHAyWj9LL/FZMjI+FQbn3Eq6awLx2dFu6c9mOO6wp8U1g03DGeMH9k2UWOimdk2BQjo4GBpWsv
	dLSZtPGFj/RV1SAnZIfpZUKEikCFj1KmRuaoTZ4cgrZ1AuETK9azee6Sufkjj1DTXuMG29qTNOs
	fm9tZj0vNB+Geec8iH2V8oGc7wjmDPJIY3nidHVYJHqWZ1GlUaW49Sg3Xch4nGY/rDuxuC++Dxc
	cCnBFGetQDBQZo5xcIOvDS4kDJvkNYncEOOhaUe4cavXp+6/F/b2JWmYXQ0WwVDs93kE=
X-Google-Smtp-Source: AGHT+IHo7oikH+vFaY9+hLdTEQynZ5bmtJTwKQPd/bkYuk10/5MoVZOnXrdbi27adYGqQTrDB9+UAg==
X-Received: by 2002:a17:90b:5101:b0:313:2206:adf1 with SMTP id 98e67ed59e1d1-32515ec3611mr32905500a91.4.1756407656141;
        Thu, 28 Aug 2025 12:00:56 -0700 (PDT)
Received: from mitchelllevy.localdomain ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da8e5ad5sm405729a91.18.2025.08.28.12.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 12:00:55 -0700 (PDT)
From: Mitchell Levy <levymitchell0@gmail.com>
Date: Thu, 28 Aug 2025 12:00:09 -0700
Subject: [PATCH v3 2/7] rust: percpu: add a rust per-CPU variable sample
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-rust-percpu-v3-2-4dd92e1e7904@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756407651; l=8590;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=pd7OPcbrPdAWI/7kgDpMFHa6ITv6ppIv2SVJeXLx/4I=;
 b=4mAs3HCOL9pJ49x1leBl0+kcOiuQILdFXWsH7vNLoFF1Wq1q/MBWhoCiT2WAwz0Md1dx4ui2m
 v3yZReoHe2iAs8mOLddeXU1f7l6uG4C5ye4DJW8gUYzwd2VbteBC/J8
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

Add a short exercise for Rust's per-CPU variable API, modelled after
lib/percpu_test.c

Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
 rust/helpers/percpu.c       |   6 ++
 samples/rust/Kconfig        |   9 +++
 samples/rust/Makefile       |   1 +
 samples/rust/rust_percpu.rs | 163 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 179 insertions(+)

diff --git a/rust/helpers/percpu.c b/rust/helpers/percpu.c
index a091389f730f..8cc01d094752 100644
--- a/rust/helpers/percpu.c
+++ b/rust/helpers/percpu.c
@@ -1,9 +1,15 @@
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
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 7f7371a004ee..23e35d64ac78 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -105,6 +105,15 @@ config SAMPLE_RUST_DRIVER_AUXILIARY
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_PERCPU
+	tristate "Per-CPU support"
+	depends on m
+	help
+	  Enable this option to build a module which demonstrates Rust per-CPU
+	  operations.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_HOSTPROGS
 	bool "Host programs"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index bd2faad63b4f..8a34d9d74754 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
 obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
+obj-$(CONFIG_SAMPLE_RUST_PERCPU)		+= rust_percpu.o
 
 rust_print-y := rust_print_main.o rust_print_events.o
 
diff --git a/samples/rust/rust_percpu.rs b/samples/rust/rust_percpu.rs
new file mode 100644
index 000000000000..98ca1c781b6b
--- /dev/null
+++ b/samples/rust/rust_percpu.rs
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+//! A simple demonstration of the rust per-CPU API.
+
+use core::cell::RefCell;
+use core::ffi::c_void;
+
+use kernel::{
+    bindings::on_each_cpu,
+    cpu::CpuId,
+    define_per_cpu, get_static_per_cpu,
+    percpu::{cpu_guard::*, *},
+    pr_info,
+    prelude::*,
+};
+
+module! {
+    type: PerCpuMod,
+    name: "rust_percpu",
+    authors: ["Mitchell Levy"],
+    description: "Sample to demonstrate the Rust per-CPU API",
+    license: "GPL v2",
+}
+
+struct PerCpuMod;
+
+define_per_cpu!(PERCPU: i64 = 0);
+define_per_cpu!(UPERCPU: u64 = 0);
+define_per_cpu!(CHECKED: RefCell<u64> = RefCell::new(0));
+
+impl kernel::Module for PerCpuMod {
+    fn init(_module: &'static ThisModule) -> Result<Self, Error> {
+        pr_info!("rust percpu test start\n");
+
+        let mut native: i64 = 0;
+        let mut pcpu: StaticPerCpu<i64> = get_static_per_cpu!(PERCPU);
+
+        // SAFETY: We only have one PerCpu that points at PERCPU
+        unsafe { pcpu.get_mut(CpuGuard::new()) }.with(|val: &mut i64| {
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
+        let mut upcpu: StaticPerCpu<u64> = get_static_per_cpu!(UPERCPU);
+
+        // SAFETY: We only have one PerCpu pointing at UPERCPU
+        unsafe { upcpu.get_mut(CpuGuard::new()) }.with(|val: &mut u64| {
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
+        let mut checked_native: u64 = 0;
+        let mut checked: StaticPerCpu<RefCell<u64>> = get_static_per_cpu!(CHECKED);
+        checked.get(CpuGuard::new()).with(|val: &RefCell<u64>| {
+            checked_native += 1;
+            *val.borrow_mut() += 1;
+            pr_info!(
+                "Checked native: {}, *checked: {}\n",
+                checked_native,
+                val.borrow()
+            );
+            assert!(checked_native == *val.borrow() && checked_native == 1);
+
+            checked_native = checked_native.wrapping_add((-1i64) as u64);
+            val.replace_with(|old: &mut u64| old.wrapping_add((-1i64) as u64));
+            pr_info!(
+                "Checked native: {}, *checked: {}\n",
+                checked_native,
+                val.borrow()
+            );
+            assert!(checked_native == *val.borrow() && checked_native == 0);
+
+            checked_native = checked_native.wrapping_add((-1i64) as u64);
+            val.replace_with(|old: &mut u64| old.wrapping_add((-1i64) as u64));
+            pr_info!(
+                "Checked native: {}, *checked: {}\n",
+                checked_native,
+                val.borrow()
+            );
+            assert!(checked_native == *val.borrow() && checked_native == (-1i64) as u64);
+
+            checked_native = 0;
+            *val.borrow_mut() = 0;
+
+            checked_native = checked_native.wrapping_sub(1);
+            val.replace_with(|old: &mut u64| old.wrapping_sub(1));
+            pr_info!(
+                "Checked native: {}, *checked: {}\n",
+                checked_native,
+                val.borrow()
+            );
+            assert!(checked_native == *val.borrow() && checked_native == (-1i64) as u64);
+            assert!(checked_native == *val.borrow() && checked_native == u64::MAX);
+        });
+
+        pr_info!("rust static percpu test done\n");
+
+        pr_info!("rust dynamic percpu test start\n");
+        let mut test: DynamicPerCpu<u64> = DynamicPerCpu::new_zero(GFP_KERNEL).unwrap();
+
+        // SAFETY: No prerequisites for on_each_cpu.
+        unsafe {
+            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 0);
+            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 0);
+            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 0);
+            on_each_cpu(Some(inc_percpu), (&raw mut test).cast(), 1);
+            on_each_cpu(Some(check_percpu), (&raw mut test).cast(), 1);
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
+    pr_info!("Incrementing on {}\n", CpuId::current().as_u32());
+
+    // SAFETY: We don't have multiple clones of pcpu in scope
+    unsafe { pcpu.get_mut(CpuGuard::new()) }.with(|val: &mut u64| *val += 1);
+}
+
+extern "C" fn check_percpu(info: *mut c_void) {
+    // SAFETY: We know that info is a void *const DynamicPerCpu<u64> and DynamicPerCpu<u64> is Send.
+    let mut pcpu = unsafe { (*(info as *const DynamicPerCpu<u64>)).clone() };
+    pr_info!("Asserting on {}\n", CpuId::current().as_u32());
+
+    // SAFETY: We don't have multiple clones of pcpu in scope
+    unsafe { pcpu.get_mut(CpuGuard::new()) }.with(|val: &mut u64| assert!(*val == 4));
+}

-- 
2.34.1


