Return-Path: <linux-kernel+bounces-607793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA3BA90AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 20:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0EE5A0905
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5397221D3F8;
	Wed, 16 Apr 2025 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUThi2Cs"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5521CA1E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826727; cv=none; b=I5JH5FLOysXDUEFMHLF7gdY0QFJsC56dKKvC9xSD5kNvPk0KMF+9qVN2zm3mcttn0eoZYI1V7b4rl6KunQ5+xRR+bea91NRMAsXsX22dlvgvBBnMRow9zyG/FZXGIcEqHMwZnfdgy1y9ByI5lLpUUY9Fk00QBB+lJX8jZ7cW0rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826727; c=relaxed/simple;
	bh=qVVOFWI4tG2f1bA/OejP77Yl7mmiUbbBq6BO8Hxczz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y6ojYTCwRQ7GbLJ8IvoHmRFqBFDwVpJj3lomHhkbYzWzGEbplEYDGk83meWoPK26a1y5xh61WXhGY3VpEKVC23hw6EgRxAwMt38kjW6Ck4sub4SwHq+UHPVdzAGeC0N7DaC/mpxkN1HD6KsAYY4qRozW2rgQ/ES/oMAubiuRwBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gUThi2Cs; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43f405810b4so28603195e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744826724; x=1745431524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KCvuX6D9+WTa2u7saZuKw/wens1B8oyovtAYHu1B0nk=;
        b=gUThi2CsZv6cn9rD5GxHlimluGrg1EnTcuzVHkn1X4kqIzs2ZZdtoFGQWa/NzLMO+a
         RgJJUoEPkV+bSYqlvyl64MZkuDD3rN7SFcE2M64u6HSOa7kr8cEDhf7fFRnBXpDrjQj4
         750r6r5++NbmWEoiVU4dTDWYAKlqT92zm8bV3s3nUnKYLktT01IG3EcgkcoGavbd4fnF
         LIoaTiU413g/KGVNm5GXQfoG2PfsVOUl41JjgxA0x3JTBy2xHdLcZsXM29PU6Jo9TZiA
         xZuWrueyaBtt5kMg4ncVIqIpwAxVGIjVx/FNd2ml4UqpAhDxw1BugHkWXxpeCk/GK1GG
         kYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744826724; x=1745431524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCvuX6D9+WTa2u7saZuKw/wens1B8oyovtAYHu1B0nk=;
        b=K2SI+2OYQrsfxGjuvsgmc9x6jKUPd2qDdr8VaAvYo5B8s0nK0hrXnu7A9dasOQDMuI
         j6q2dRHzCEziGeWGrCEO+/5v+BKkDyVkjOu38kAtcHsDHjUvDHMJH4NSZEOMMM4TWKyO
         eBUXaTc9xmlRVr0Q3vQIHjCzGWGflUuTMEGViXbyeXwZjnuL+auKXahYHXwIoV6bPgIA
         BUHhQ0e0gLjSwllil3O0PI3knPMRIUH+B4kDbCwKUVdVMTaUQIW5V37tfXFt41OMbXzt
         gn/yE9XEU2q30YEQScPDFNu7KmoITa/tWDM5wmxwk3Utcv7xMXL/4FrsVaxuRSM4GT+y
         3zFg==
X-Forwarded-Encrypted: i=1; AJvYcCWYwStsIbbZNXRzOjV9tJB4yVX1TrCTh6xuVZL9921fng3bhqDgDdgMwsBKLNzUtTXG7fPCmbuWfGof0M8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9d8oC1jSmXDFKfTk4Jnyo3858jwRgl17X74TiwS4s8e3ZGS0s
	zpCA/cPqmKCghxYuA8lRwX/zHCm9GWJ4U+TFeM9/gfsejGZMKZaDUhRsys5iiBxspLkd901M03i
	k0LGL+XPSew==
X-Google-Smtp-Source: AGHT+IE5cwvkKnuP/EFD2BCghKQMI7oHyo8gaZc3cJ97rDzljSXNx93RTJNUG9F85eyGCrsPnHVKzg/isUAoOA==
X-Received: from wmbh25.prod.google.com ([2002:a05:600c:a119:b0:43d:586a:9bcb])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a0e:b0:43d:d06:3798 with SMTP id 5b1f17b1804b1-4405d6adc5emr27421125e9.20.1744826723681;
 Wed, 16 Apr 2025 11:05:23 -0700 (PDT)
Date: Wed, 16 Apr 2025 18:04:33 +0000
In-Reply-To: <20250416180440.231949-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250416180440.231949-1-smostafa@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250416180440.231949-4-smostafa@google.com>
Subject: [PATCH 3/4] KVM: arm64: Introduce CONFIG_UBSAN_KVM_EL2
From: Mostafa Saleh <smostafa@google.com>
To: kvmarm@lists.linux.dev, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	broonie@kernel.org, catalin.marinas@arm.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kees@kernel.org, elver@google.com, andreyknvl@gmail.com, 
	ryabinin.a.a@gmail.com, akpm@linux-foundation.org, yuzenghui@huawei.com, 
	suzuki.poulose@arm.com, joey.gouly@arm.com, masahiroy@kernel.org, 
	nathan@kernel.org, nicolas.schier@linux.dev, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new Kconfig CONFIG_UBSAN_KVM_EL2 for KVM which enables
UBSAN for EL2 code (in protected/nvhe/hvhe) modes.
This will re-use the same checks enabled for the kernel for
the hypervisor. The only difference is that for EL2 it always
emits a "brk" instead of implementing hooks as the hypervisor
can't print reports.

The KVM code will re-use the same code for the kernel
"report_ubsan_failure()" so #ifdefs are changed to also have this
code for CONFIG_UBSAN_KVM_EL2

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 6 ++++++
 include/linux/ubsan.h            | 2 +-
 lib/Kconfig.ubsan                | 9 +++++++++
 lib/ubsan.c                      | 6 ++++--
 scripts/Makefile.ubsan           | 5 ++++-
 5 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index b43426a493df..cbe7e12752bc 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -99,3 +99,9 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS), $(KBUILD_CFLAG
 # causes a build failure. Remove profile optimization flags.
 KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%, $(KBUILD_CFLAGS))
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables -fno-unwind-tables
+
+ifeq ($(CONFIG_UBSAN_KVM_EL2),y)
+UBSAN_SANITIZE := y
+# Always use brk and not hooks
+ccflags-y += $(CFLAGS_UBSAN_FOR_TRAP)
+endif
diff --git a/include/linux/ubsan.h b/include/linux/ubsan.h
index c843816f5f68..3ab8d38aedb8 100644
--- a/include/linux/ubsan.h
+++ b/include/linux/ubsan.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_UBSAN_H
 #define _LINUX_UBSAN_H
 
-#ifdef CONFIG_UBSAN_TRAP
+#if defined(CONFIG_UBSAN_TRAP) || defined(CONFIG_UBSAN_KVM_EL2)
 const char *report_ubsan_failure(u32 check_type);
 #else
 static inline const char *report_ubsan_failure(u32 check_type)
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 4216b3a4ff21..3878858eb473 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -166,4 +166,13 @@ config TEST_UBSAN
 	  This is a test module for UBSAN.
 	  It triggers various undefined behavior, and detect it.
 
+config UBSAN_KVM_EL2
+	bool "UBSAN for KVM code at EL2"
+	depends on ARM64
+	help
+	  Enable UBSAN when running on ARM64 with KVM in a split mode
+	  (nvhe/hvhe/protected) for the hypervisor code running in EL2.
+	  In this mode, any UBSAN violation in EL2 would panic the kernel
+	  and information similar to UBSAN_TRAP would be printed.
+
 endif	# if UBSAN
diff --git a/lib/ubsan.c b/lib/ubsan.c
index 17993727fc96..a6ca235dd714 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -19,7 +19,7 @@
 
 #include "ubsan.h"
 
-#ifdef CONFIG_UBSAN_TRAP
+#if defined(CONFIG_UBSAN_TRAP) || defined(CONFIG_UBSAN_KVM_EL2)
 /*
  * Only include matches for UBSAN checks that are actually compiled in.
  * The mappings of struct SanitizerKind (the -fsanitize=xxx args) to
@@ -97,7 +97,9 @@ const char *report_ubsan_failure(u32 check_type)
 	}
 }
 
-#else
+#endif
+
+#ifndef CONFIG_UBSAN_TRAP
 static const char * const type_check_kinds[] = {
 	"load of",
 	"store to",
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 9e35198edbf0..68af6830af0f 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+#Shared with KVM/arm64
+export CFLAGS_UBSAN_FOR_TRAP := $(call cc-option,-fsanitize-trap=undefined,-fsanitize-undefined-trap-on-error)
+
 # Enable available and selected UBSAN features.
 ubsan-cflags-$(CONFIG_UBSAN_ALIGNMENT)		+= -fsanitize=alignment
 ubsan-cflags-$(CONFIG_UBSAN_BOUNDS_STRICT)	+= -fsanitize=bounds-strict
@@ -10,7 +13,7 @@ ubsan-cflags-$(CONFIG_UBSAN_DIV_ZERO)		+= -fsanitize=integer-divide-by-zero
 ubsan-cflags-$(CONFIG_UBSAN_UNREACHABLE)	+= -fsanitize=unreachable
 ubsan-cflags-$(CONFIG_UBSAN_BOOL)		+= -fsanitize=bool
 ubsan-cflags-$(CONFIG_UBSAN_ENUM)		+= -fsanitize=enum
-ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= $(call cc-option,-fsanitize-trap=undefined,-fsanitize-undefined-trap-on-error)
+ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= $(CFLAGS_UBSAN_FOR_TRAP)
 
 export CFLAGS_UBSAN := $(ubsan-cflags-y)
 
-- 
2.49.0.604.gff1f9ca942-goog


