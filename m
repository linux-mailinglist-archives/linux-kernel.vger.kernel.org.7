Return-Path: <linux-kernel+bounces-801783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BA9B449CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A59B3B4311
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB132EBDC0;
	Thu,  4 Sep 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZQ3Onqm"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389A2EC569
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025557; cv=none; b=ngblvgM5LqTpnTDxkrZvXnFUy5w1tD0DVq1Pd8pB24TZmHRFPhphi5Ob8f7Yrh3QhIOjc1Y7LXIK0U6sDB9R26o/Oym0PrOOWw+Vporu0Hwzb1UNBlzoWowTVG/n0FPReluWwRW1RLUnabQR879RxjCgDf29TLkeQNz+YBoNWac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025557; c=relaxed/simple;
	bh=wpukPNGidBsZHZNBLMBXDHyt6toluvhOIdHF3dHictg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pROE07/YRkFEJk4N2v/ILj2GoCMolWC+D47odI6eoDq3Z11l6xTcUt2e0u9Em8PfyiNBYg5p2OIeL39gdA6j4441dNyUUb0528q5x6KMNiSrjnszXSv5e0mKXMtefVKVO+StJjbb4QzOQinaYm8p3dwFw625hMg7b+k/68nPWZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZQ3Onqm; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329ee88fb47so2390364a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 15:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757025555; x=1757630355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dtLRBEibPgJC5DKIIcXUNvr0Jg7QinxVii68wLCzhSQ=;
        b=hZQ3Onqmi4lLIpKpNRqcRCVknF2dTIeIZLqF+mXwiP3lD9C86SXGo/qxgybR/CQaVd
         OVUj7FTSC24yLc0iOLBcYrGu2rojA8as0vFpUskKXoLOrtJDyMKm8Rsa9XGJtdwE8Y/Y
         Uji7rKIv+vz0qgRkmAnyGAuuFatagBCqlxJl4bEPvbTsLLSlrhHZTaA43PH33zbbMvpf
         /bo7il7PtHKgE5jG/VhNtUMkdEIjuVjBmInRfXaFCFMx00tTVme+ImfAU/o5ASy5gpF+
         k9ZRCQWQ2HKNArie+CHDJgsJ308zZBN7RHFUYOuDuuLXie5MmR0JP4Q1vSvZPYAff84I
         AAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757025555; x=1757630355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dtLRBEibPgJC5DKIIcXUNvr0Jg7QinxVii68wLCzhSQ=;
        b=FuX6O5lNU5qRnOZr6PQtI3RdP8Gv0wp2sOrpXszyWVMX+sO1O077hYrDG55rq/kr62
         k0ATA2n7NtGqjaTlplzD4YR9IkZARbNOoG/v4Q0F4LJxXXQLj5phnlB/RsN0QyybwXNL
         N3qjOZncS5ew2mSSlPbjPQvGJqOWhAS9AlSRcceS7K5zNRRhei8qXi3So+rJvKC5Dqp/
         0qX+mgIq1Mc30tIlu/Bh7d94oBojbLoHkCq91dcE0On24WBl5py8FnjSh+dhBeZt7s0w
         tbqsGCh0WdfaEdrqOdpwvZ1GzjqURZvVz9wabi6htBkqRHqJvZeawXm4d7/f+4SgH29E
         jLYg==
X-Forwarded-Encrypted: i=1; AJvYcCV1N8j35NMX4xy8F4Dnw3T8sqekHkGX8E/2bkpaZUhkPEGq6flCdYyB4AVk3iM4x1SOwv7QD0aEdkoEGuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLbEPhafMbYsI5ky9l6ZkJd8zY0wuo/P96jW2DMdJD/LegSmLD
	2WpLeY/T1HJGW8SBOPAqsfXKeD//WdFc0fnFmdN0MRJknkoL5K1DuGO28pczKfoVD2gIkF7RGWN
	UJfljSqo8p8VxHc2CI12KdUSVWQ==
X-Google-Smtp-Source: AGHT+IGXLPNA47OzrNlwR+6Ds93TCeSbcveB/7SH+UNLQts5VBH9tcTynj2fUKqKY9GmrReRRyDIXA2CAA/pnv5LGQ==
X-Received: from pjl11.prod.google.com ([2002:a17:90b:2f8b:b0:329:d09b:a3f2])
 (user=dylanbhatch job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3905:b0:32b:8b8d:c2af with SMTP id 98e67ed59e1d1-32b8b8dc8e4mr6542460a91.9.1757025555612;
 Thu, 04 Sep 2025 15:39:15 -0700 (PDT)
Date: Thu,  4 Sep 2025 22:38:45 +0000
In-Reply-To: <20250904223850.884188-1-dylanbhatch@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904223850.884188-1-dylanbhatch@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250904223850.884188-2-dylanbhatch@google.com>
Subject: [PATCH v2 1/6] unwind: build kernel with sframe info
From: Dylan Hatch <dylanbhatch@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Jiri Kosina <jikos@kernel.org>
Cc: Dylan Hatch <dylanbhatch@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Weinan Liu <wnliu@google.com>, Mark Rutland <mark.rutland@arm.com>, Ian Rogers <irogers@google.com>, 
	linux-toolchains@vger.kernel.org, linux-kernel@vger.kernel.org, 
	live-patching@vger.kernel.org, joe.lawrence@redhat.com, 
	Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>, 
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"

Use the -Wa,--gsframe flags to build the code, so GAS will generate
a new .sframe section for the stack trace information.
Currently, the sframe format only supports arm64 and x86_64
architectures. Add this configuration on arm64 to enable sframe
unwinder in the future.

Signed-off-by: Weinan Liu <wnliu@google.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
Reviewed-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
---
 Makefile                          |  8 ++++++++
 arch/Kconfig                      |  6 ++++++
 arch/arm64/Kconfig.debug          | 10 ++++++++++
 arch/arm64/kernel/vdso/Makefile   |  2 +-
 include/asm-generic/vmlinux.lds.h | 15 +++++++++++++++
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b9c661913250..09972c71a3e8 100644
--- a/Makefile
+++ b/Makefile
@@ -1078,6 +1078,14 @@ endif
 # Ensure compilers do not transform certain loops into calls to wcslen()
 KBUILD_CFLAGS += -fno-builtin-wcslen
 
+# build with sframe table
+ifdef CONFIG_SFRAME_UNWIND_TABLE
+CC_FLAGS_SFRAME := -Wa,--gsframe
+KBUILD_CFLAGS	+= $(CC_FLAGS_SFRAME)
+KBUILD_AFLAGS	+= $(CC_FLAGS_SFRAME)
+export CC_FLAGS_SFRAME
+endif
+
 # change __FILE__ to the relative path to the source directory
 ifdef building_out_of_srctree
 KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srcroot)/=)
diff --git a/arch/Kconfig b/arch/Kconfig
index d1b4ffd6e085..4362d2f49d91 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1782,4 +1782,10 @@ config ARCH_WANTS_PRE_LINK_VMLINUX
 config ARCH_HAS_CPU_ATTACK_VECTORS
 	bool
 
+config AS_SFRAME
+	def_bool $(as-instr,.cfi_sections .sframe\n.cfi_startproc\n.cfi_endproc)
+
+config SFRAME_UNWIND_TABLE
+	bool
+
 endmenu
diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 265c4461031f..d64bf58457de 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -20,4 +20,14 @@ config ARM64_RELOC_TEST
 	depends on m
 	tristate "Relocation testing module"
 
+config SFRAME_UNWINDER
+	bool "Sframe unwinder"
+	depends on AS_SFRAME
+	depends on 64BIT
+	select SFRAME_UNWIND_TABLE
+	help
+	  This option enables the sframe (Simple Frame) unwinder for unwinding
+	  kernel stack traces. It uses unwind table that is directly generated
+	  by toolchain based on DWARF CFI information.
+
 source "drivers/hwtracing/coresight/Kconfig"
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 7dec05dd33b7..c60ef921956f 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -38,7 +38,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 CC_FLAGS_REMOVE_VDSO := $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
 			$(RANDSTRUCT_CFLAGS) $(KSTACK_ERASE_CFLAGS) \
 			$(GCC_PLUGINS_CFLAGS) \
-			$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
+			$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(CC_FLAGS_SFRAME) \
 			-Wmissing-prototypes -Wmissing-declarations
 
 CC_FLAGS_ADD_VDSO := -O2 -mcmodel=tiny -fasynchronous-unwind-tables
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ae2d2359b79e..4f486080e4fb 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -473,6 +473,8 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 		*(.rodata1)						\
 	}								\
 									\
+	SFRAME								\
+									\
 	/* PCI quirks */						\
 	.pci_fixup        : AT(ADDR(.pci_fixup) - LOAD_OFFSET) {	\
 		BOUNDED_SECTION_PRE_LABEL(.pci_fixup_early,  _pci_fixups_early,  __start, __end) \
@@ -891,6 +893,19 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define TRACEDATA
 #endif
 
+#ifdef CONFIG_SFRAME_UNWIND_TABLE
+#define SFRAME							\
+	/* sframe */						\
+	.sframe : AT(ADDR(.sframe) - LOAD_OFFSET) {		\
+		__start_sframe_header = .;			\
+		KEEP(*(.sframe))				\
+		KEEP(*(.init.sframe))				\
+		__stop_sframe_header = .;			\
+	}
+#else
+#define SFRAME
+#endif
+
 #ifdef CONFIG_PRINTK_INDEX
 #define PRINTK_INDEX							\
 	.printk_index : AT(ADDR(.printk_index) - LOAD_OFFSET) {		\
-- 
2.51.0.355.g5224444f11-goog


