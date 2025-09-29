Return-Path: <linux-kernel+bounces-836060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5949BA8A41
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9C23B6970
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFBF2D0C75;
	Mon, 29 Sep 2025 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kw7534sC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HMfxD7eu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22702C235F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138156; cv=none; b=ewQI+3klakgWg2CpG5zKlmrxzg07GSGrQpwesW0awHeWxWGcHYeAncypJnVnGwV0EYtwWKhiwngbUL+H5UQ2sH/y7DlCuMYCGdx1gnUdJiPdXzQEncvNN2DGtC/t/AAfXQtewDr6hTe6dToftnAClcRAvIHa3gzUfx/aU7HBQA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138156; c=relaxed/simple;
	bh=rSlLMiUVZh+XO0Fv0bFe4z+VLjRR3paB6Q9r9Gha8M4=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=Q52o4wipqIpNzecgiBUh49HE6txUcxCl9p32VfoEnQny2RHSzys8cMqgbwiX+IvKUsktcHMuotaE7inCu7P8iqIeLAMdxn2QXQAR44PgYWkpjRxts6VeHwlJRZAA6OOA9gO5Sj5QMgvJT0h/+hfHpmQOoJMkz/Yn7Ysb9Qpkxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kw7534sC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HMfxD7eu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759138151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=+gp7Kq5WEyOuMjp3DN/zwaoZPxGHvf6GXkWR5pYbxdA=;
	b=kw7534sCV2G+adEGhD6eEiFVY8i/z8Z3JVKxLDIhG0gUl4PJQqgqBlrYN33LHoiw5o14Dc
	QA44YuAtzTVb8lhsKVDNo6sUYxJ1DweBrXrgAf0PYSwAypnaVGEBlhjiCfHtz2CJb8mbAP
	zW2CWeXFSFxC6taEzABpMrXnts/xTmkftSBnC1soVWQAkwkrtnjA85jv5ZZbVjY4826giD
	yMKuIz6y28DeAOuMWFZ/K0TwAQAfzTC3ptpMMF5qKRgKbPBbjgs3FW+TtLr96m2Qicl9tE
	5YmWLp9W74M+Tnl2Ca9DQ9quw1DQ/5FxnYJqhdQcQWN+gWScvJQZ+P5uGxlCXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759138151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=+gp7Kq5WEyOuMjp3DN/zwaoZPxGHvf6GXkWR5pYbxdA=;
	b=HMfxD7euYShWfz4MEXw7ghqp8W0E/DjmE+xbVgOf+yy0khEUjzYty+R1uUWnZ6MuWi42Dn
	HEEKTAPZhDZ9SLDw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/vdso for v6.18-rc1
References: <175913807599.495041.10251515322736195577.tglx@xen13>
Message-ID: <175913809032.495041.16459509621135862969.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Sep 2025 11:29:10 +0200 (CEST)

Linus,

please pull the latest timers/vdso branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-vdso-2025=
-09-29

up to:  e82bf7570d5c: selftests: vDSO: Drop vdso_test_clock_getres

Updates for the VDSO subsystem:

  - Further consolidation of the VDSO infrastructure and the common data
    store.

  - Simplification of the related Kconfig logic

  - Improve the VDSO selftest suite

Thanks,

	tglx

------------------>
Rasmus Villemoes (1):
      ARM: VDSO: Remove cntvct_ok global variable

Thomas Wei=C3=9Fschuh (19):
      vdso/datastore: Gate time data behind CONFIG_GENERIC_GETTIMEOFDAY
      vdso: Move ENABLE_COMPAT_VDSO from core to arm64
      vdso/gettimeofday: Remove !CONFIG_TIME_NS stubs
      time: Build generic update_vsyscall() only with generic time vDSO
      riscv: vdso: Untangle Kconfig logic
      vdso: Drop kconfig GENERIC_VDSO_32
      vdso: Drop kconfig GENERIC_COMPAT_VDSO
      vdso: Drop Kconfig GENERIC_VDSO_DATA_STORE
      vdso: Drop Kconfig GENERIC_VDSO_TIME_NS
      vdso: Gate VDSO_GETRANDOM behind HAVE_GENERIC_VDSO
      vdso: Add struct __kernel_old_timeval forward declaration to gettime.h
      selftests: vDSO: Fix -Wunitialized in powerpc VDSO_CALL() wrapper
      selftests: vDSO: vdso_test_abi: Correctly skip whole test with missing =
vDSO
      selftests: vDSO: vdso_test_abi: Use ksft_finished()
      selftests: vDSO: vdso_test_abi: Drop clock availability tests
      selftests: vDSO: vdso_test_abi: Use explicit indices for name array
      selftests: vDSO: vdso_test_abi: Test CPUTIME clocks
      selftests: vDSO: vdso_test_abi: Add tests for clock_gettime64()
      selftests: vDSO: Drop vdso_test_clock_getres


 arch/Kconfig                                       |   2 +-
 arch/arm/include/asm/vdso/vsyscall.h               |   2 -
 arch/arm/kernel/vdso.c                             |  10 +-
 arch/arm/mm/Kconfig                                |   2 -
 arch/arm64/Kconfig                                 |   3 -
 arch/arm64/include/asm/vdso/compat_barrier.h       |   7 +-
 arch/arm64/include/asm/vdso/compat_gettimeofday.h  |   6 +-
 arch/arm64/include/asm/vdso/gettimeofday.h         |   8 ++
 arch/arm64/kernel/vdso32/Makefile                  |   1 -
 arch/loongarch/Kconfig                             |   2 -
 arch/mips/Kconfig                                  |   1 -
 arch/powerpc/Kconfig                               |   2 -
 arch/riscv/Kconfig                                 |  12 +-
 arch/s390/Kconfig                                  |   2 -
 arch/x86/Kconfig                                   |   3 -
 include/asm-generic/vdso/vsyscall.h                |   4 -
 include/vdso/datapage.h                            |   9 +-
 include/vdso/gettime.h                             |   1 +
 init/Kconfig                                       |   2 +-
 kernel/time/Makefile                               |   2 +-
 lib/vdso/Kconfig                                   |  25 +----
 lib/vdso/Makefile                                  |   2 +-
 lib/vdso/datastore.c                               |   6 +-
 lib/vdso/gettimeofday.c                            |  27 -----
 tools/testing/selftests/pidfd/config               |   1 -
 tools/testing/selftests/vDSO/.gitignore            |   1 -
 tools/testing/selftests/vDSO/Makefile              |   2 -
 tools/testing/selftests/vDSO/vdso_call.h           |   7 +-
 tools/testing/selftests/vDSO/vdso_test_abi.c       | 101 +++++++++--------
 .../selftests/vDSO/vdso_test_clock_getres.c        | 123 -------------------=
--
 30 files changed, 91 insertions(+), 285 deletions(-)
 delete mode 100644 tools/testing/selftests/vDSO/vdso_test_clock_getres.c

diff --git a/arch/Kconfig b/arch/Kconfig
index d1b4ffd6e085..f6ca7f303172 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1609,7 +1609,7 @@ config HAVE_SPARSE_SYSCALL_NR
 	  related optimizations for a given architecture.
=20
 config ARCH_HAS_VDSO_ARCH_DATA
-	depends on GENERIC_VDSO_DATA_STORE
+	depends on HAVE_GENERIC_VDSO
 	bool
=20
 config ARCH_HAS_VDSO_TIME_DATA
diff --git a/arch/arm/include/asm/vdso/vsyscall.h b/arch/arm/include/asm/vdso=
/vsyscall.h
index 4e7226ad02ec..ff1c729af05f 100644
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -7,8 +7,6 @@
 #include <vdso/datapage.h>
 #include <asm/cacheflush.h>
=20
-extern bool cntvct_ok;
-
 static __always_inline
 void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
 {
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 325448ffbba0..e38a30477f3d 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -54,11 +54,9 @@ struct elfinfo {
 	char		*dynstr;	/* ptr to .dynstr section */
 };
=20
-/* Cached result of boot-time check for whether the arch timer exists,
- * and if so, whether the virtual counter is useable.
+/* Boot-time check for whether the arch timer exists, and if so,
+ * whether the virtual counter is usable.
  */
-bool cntvct_ok __ro_after_init;
-
 static bool __init cntvct_functional(void)
 {
 	struct device_node *np;
@@ -159,7 +157,7 @@ static void __init patch_vdso(void *ehdr)
 	 * want programs to incur the slight additional overhead of
 	 * dispatching through the VDSO only to fall back to syscalls.
 	 */
-	if (!cntvct_ok) {
+	if (!cntvct_functional()) {
 		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime64");
@@ -197,8 +195,6 @@ static int __init vdso_init(void)
 	vdso_total_pages =3D VDSO_NR_PAGES; /* for the data/vvar pages */
 	vdso_total_pages +=3D text_pages;
=20
-	cntvct_ok =3D cntvct_functional();
-
 	patch_vdso(vdso_start);
=20
 	return 0;
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 5c1023a6d78c..7b27ee9482b3 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -926,9 +926,7 @@ config VDSO
 	default y if ARM_ARCH_TIMER
 	select HAVE_GENERIC_VDSO
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_32
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_DATA_STORE
 	help
 	  Place in the process address space an ELF shared object
 	  providing fast implementations of gettimeofday and
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfacc35a6..e19b006842e2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -162,8 +162,6 @@ config ARM64
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_DATA_STORE
-	select GENERIC_VDSO_TIME_NS
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT
 	select HAVE_MOVE_PMD
@@ -1782,7 +1780,6 @@ config COMPAT_VDSO
 	bool "Enable vDSO for 32-bit applications"
 	depends on !CPU_BIG_ENDIAN
 	depends on (CC_IS_CLANG && LD_IS_LLD) || "$(CROSS_COMPILE_COMPAT)" !=3D ""
-	select GENERIC_COMPAT_VDSO
 	default y
 	help
 	  Place in the process address space of 32-bit applications an
diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/includ=
e/asm/vdso/compat_barrier.h
index 3ac35f4a667c..6d75e03d3827 100644
--- a/arch/arm64/include/asm/vdso/compat_barrier.h
+++ b/arch/arm64/include/asm/vdso/compat_barrier.h
@@ -7,11 +7,10 @@
=20
 #ifndef __ASSEMBLY__
 /*
- * Warning: This code is meant to be used with
- * ENABLE_COMPAT_VDSO only.
+ * Warning: This code is meant to be used from the compat vDSO only.
  */
-#ifndef ENABLE_COMPAT_VDSO
-#error This header is meant to be used with ENABLE_COMPAT_VDSO only
+#ifdef __arch64__
+#error This header is meant to be used with from the compat vDSO only
 #endif
=20
 #ifdef dmb
diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/i=
nclude/asm/vdso/compat_gettimeofday.h
index d60ea7a72a9c..7d1a116549b1 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -2,8 +2,8 @@
 /*
  * Copyright (C) 2018 ARM Limited
  */
-#ifndef __ASM_VDSO_GETTIMEOFDAY_H
-#define __ASM_VDSO_GETTIMEOFDAY_H
+#ifndef __ASM_VDSO_COMPAT_GETTIMEOFDAY_H
+#define __ASM_VDSO_COMPAT_GETTIMEOFDAY_H
=20
 #ifndef __ASSEMBLY__
=20
@@ -163,4 +163,4 @@ static inline bool vdso_clocksource_ok(const struct vdso_=
clock *vc)
=20
 #endif /* !__ASSEMBLY__ */
=20
-#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
+#endif /* __ASM_VDSO_COMPAT_GETTIMEOFDAY_H */
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/=
asm/vdso/gettimeofday.h
index da1ab8759592..c59e84105b43 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -5,6 +5,8 @@
 #ifndef __ASM_VDSO_GETTIMEOFDAY_H
 #define __ASM_VDSO_GETTIMEOFDAY_H
=20
+#ifdef __aarch64__
+
 #ifndef __ASSEMBLY__
=20
 #include <asm/alternative.h>
@@ -96,4 +98,10 @@ static __always_inline const struct vdso_time_data *__arch=
_get_vdso_u_time_data(
=20
 #endif /* !__ASSEMBLY__ */
=20
+#else /* !__aarch64__ */
+
+#include "compat_gettimeofday.h"
+
+#endif /* __aarch64__ */
+
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Mak=
efile
index f2dfdc7dc818..230fdc26796a 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -59,7 +59,6 @@ VDSO_CAFLAGS +=3D -DDISABLE_BRANCH_PROFILING
 VDSO_CAFLAGS +=3D -march=3Darmv8-a
=20
 VDSO_CFLAGS :=3D $(VDSO_CAFLAGS)
-VDSO_CFLAGS +=3D -DENABLE_COMPAT_VDSO=3D1
 # KBUILD_CFLAGS from top-level Makefile
 VDSO_CFLAGS +=3D -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                -fno-strict-aliasing -fno-common \
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f0abc38c40ac..754626b58b92 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -108,8 +108,6 @@ config LOONGARCH
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_DATA_STORE
-	select GENERIC_VDSO_TIME_NS
 	select GPIOLIB
 	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index caf508f6e9ec..f7e6bbd755e0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -51,7 +51,6 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_DATA_STORE
 	select GUP_GET_PXX_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
 	select HAS_IOPORT if !NO_IOPORT_MAP || ISA
 	select HAVE_ARCH_COMPILER_H
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 93402a1d9c9f..d715e3d65b5c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -207,8 +207,6 @@ config PPC
 	select GENERIC_PCI_IOMAP		if PCI
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_DATA_STORE
-	select GENERIC_VDSO_TIME_NS
 	select HAS_IOPORT			if PCI
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMALLOC		if HAVE_ARCH_HUGE_VMAP
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a4b233a0659e..6e5efbeb83d7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -52,7 +52,7 @@ config RISCV
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN
-	select ARCH_HAS_VDSO_ARCH_DATA if GENERIC_VDSO_DATA_STORE
+	select ARCH_HAS_VDSO_ARCH_DATA if HAVE_GENERIC_VDSO
 	select ARCH_KEEP_MEMBLOCK if ACPI
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
@@ -107,7 +107,7 @@ config RISCV
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_ENTRY
-	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
+	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO && 64BIT
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IOREMAP if MMU
 	select GENERIC_IRQ_IPI if SMP
@@ -120,9 +120,7 @@ config RISCV
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
-	select GENERIC_VDSO_DATA_STORE if MMU
-	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
+	select GENERIC_TIME_VSYSCALL if GENERIC_GETTIMEOFDAY
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT if MMU
 	select HAVE_ALIGNED_STRUCT_PAGE
@@ -165,7 +163,7 @@ config RISCV
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_GCC_PLUGINS
-	select HAVE_GENERIC_VDSO if MMU && 64BIT
+	select HAVE_GENERIC_VDSO if MMU
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KERNEL_BZIP2 if !XIP_KERNEL && !EFI_ZBOOT
 	select HAVE_KERNEL_GZIP if !XIP_KERNEL && !EFI_ZBOOT
@@ -221,7 +219,7 @@ config RISCV
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select UACCESS_MEMCPY if !MMU
-	select VDSO_GETRANDOM if HAVE_GENERIC_VDSO
+	select VDSO_GETRANDOM if HAVE_GENERIC_VDSO && 64BIT
 	select USER_STACKTRACE_SUPPORT
 	select ZONE_DMA32 if 64BIT
=20
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index bf680c26a33c..e06ebbd860da 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -167,8 +167,6 @@ config S390
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_DATA_STORE
-	select GENERIC_VDSO_TIME_NS
 	select GENERIC_IOREMAP if PCI
 	select HAVE_ALIGNED_STRUCT_PAGE
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..d1961811e291 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -14,7 +14,6 @@ config X86_32
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select CLKSRC_I8253
 	select CLONE_BACKWARDS
-	select GENERIC_VDSO_32
 	select HAVE_DEBUG_STACKOVERFLOW
 	select KMAP_LOCAL
 	select MODULES_USE_ELF_REL
@@ -182,8 +181,6 @@ config X86
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_DATA_STORE
-	select GENERIC_VDSO_TIME_NS
 	select GENERIC_VDSO_OVERFLOW_PROTECT
 	select GUP_GET_PXX_LOW_HIGH		if X86_PAE
 	select HARDIRQS_SW_RESEND
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/v=
syscall.h
index 7fc0b560007d..5c6d9799f4e7 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -4,8 +4,6 @@
=20
 #ifndef __ASSEMBLY__
=20
-#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
-
 #ifndef __arch_get_vdso_u_time_data
 static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_d=
ata(void)
 {
@@ -20,8 +18,6 @@ static __always_inline const struct vdso_rng_data *__arch_g=
et_vdso_u_rng_data(vo
 }
 #endif
=20
-#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
-
 #ifndef __arch_update_vdso_clock
 static __always_inline void __arch_update_vdso_clock(struct vdso_clock *vc)
 {
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 02533038640e..23c39b96190f 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -31,7 +31,7 @@ struct arch_vdso_time_data {};
=20
 #if defined(CONFIG_ARCH_HAS_VDSO_ARCH_DATA)
 #include <asm/vdso/arch_data.h>
-#elif defined(CONFIG_GENERIC_VDSO_DATA_STORE)
+#else
 struct vdso_arch_data {
 	/* Needed for the generic code, never actually used at runtime */
 	char __unused;
@@ -164,7 +164,6 @@ struct vdso_rng_data {
  * With the hidden visibility, the compiler simply generates a PC-relative
  * relocation, and this is what we need.
  */
-#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
 extern struct vdso_time_data vdso_u_time_data __attribute__((visibility("hid=
den")));
 extern struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("hidde=
n")));
 extern struct vdso_arch_data vdso_u_arch_data __attribute__((visibility("hid=
den")));
@@ -185,8 +184,6 @@ enum vdso_pages {
 	VDSO_NR_PAGES
 };
=20
-#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
-
 /*
  * The generic vDSO implementation requires that gettimeofday.h
  * provides:
@@ -196,11 +193,7 @@ enum vdso_pages {
  * - clock_gettime_fallback(): fallback for clock_gettime.
  * - clock_getres_fallback(): fallback for clock_getres.
  */
-#ifdef ENABLE_COMPAT_VDSO
-#include <asm/vdso/compat_gettimeofday.h>
-#else
 #include <asm/vdso/gettimeofday.h>
-#endif /* ENABLE_COMPAT_VDSO */
=20
 #else /* !__ASSEMBLY__ */
=20
diff --git a/include/vdso/gettime.h b/include/vdso/gettime.h
index c50d152e7b3e..9ac161866653 100644
--- a/include/vdso/gettime.h
+++ b/include/vdso/gettime.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
=20
 struct __kernel_timespec;
+struct __kernel_old_timeval;
 struct timezone;
=20
 #if !defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64)
diff --git a/init/Kconfig b/init/Kconfig
index d811cad02a75..497bd326d39a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1347,7 +1347,7 @@ config UTS_NS
=20
 config TIME_NS
 	bool "TIME namespace"
-	depends on GENERIC_VDSO_TIME_NS
+	depends on GENERIC_GETTIMEOFDAY
 	default y
 	help
 	  In this namespace boottime and monotonic clocks can be set.
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index e6e9b85d4db5..f7d52d9543cc 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_LEGACY_TIMER_TICK)			+=3D tick-legacy.o
 ifeq ($(CONFIG_SMP),y)
  obj-$(CONFIG_NO_HZ_COMMON)			+=3D timer_migration.o
 endif
-obj-$(CONFIG_HAVE_GENERIC_VDSO)			+=3D vsyscall.o
+obj-$(CONFIG_GENERIC_GETTIMEOFDAY)		+=3D vsyscall.o
 obj-$(CONFIG_DEBUG_FS)				+=3D timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+=3D test_udelay.o
 obj-$(CONFIG_TIME_NS)				+=3D namespace.o
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 45df764b49ad..db87ba34ef19 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -12,24 +12,6 @@ config GENERIC_GETTIMEOFDAY
 	  Each architecture that enables this feature has to
 	  provide the fallback implementation.
=20
-config GENERIC_VDSO_32
-	bool
-	depends on GENERIC_GETTIMEOFDAY && !64BIT
-	help
-	  This config option helps to avoid possible performance issues
-	  in 32 bit only architectures.
-
-config GENERIC_COMPAT_VDSO
-	bool
-	help
-	  This config option enables the compat VDSO layer.
-
-config GENERIC_VDSO_TIME_NS
-	bool
-	help
-	  Selected by architectures which support time namespaces in the
-	  VDSO
-
 config GENERIC_VDSO_OVERFLOW_PROTECT
 	bool
 	help
@@ -37,14 +19,9 @@ config GENERIC_VDSO_OVERFLOW_PROTECT
 	  time getter functions for the price of an extra conditional
 	  in the hotpath.
=20
-endif
-
 config VDSO_GETRANDOM
 	bool
 	help
 	  Selected by architectures that support vDSO getrandom().
=20
-config GENERIC_VDSO_DATA_STORE
-	bool
-	help
-	  Selected by architectures that use the generic vDSO data store.
+endif
diff --git a/lib/vdso/Makefile b/lib/vdso/Makefile
index aedd40aaa950..405f743253d7 100644
--- a/lib/vdso/Makefile
+++ b/lib/vdso/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
=20
-obj-$(CONFIG_GENERIC_VDSO_DATA_STORE) +=3D datastore.o
+obj-$(CONFIG_HAVE_GENERIC_VDSO) +=3D datastore.o
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 3693c6caf2c4..a565c30c71a0 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -11,14 +11,14 @@
 /*
  * The vDSO data page.
  */
-#ifdef CONFIG_HAVE_GENERIC_VDSO
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 static union {
 	struct vdso_time_data	data;
 	u8			page[PAGE_SIZE];
 } vdso_time_data_store __page_aligned_data;
 struct vdso_time_data *vdso_k_time_data =3D &vdso_time_data_store.data;
 static_assert(sizeof(vdso_time_data_store) =3D=3D PAGE_SIZE);
-#endif /* CONFIG_HAVE_GENERIC_VDSO */
+#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
=20
 #ifdef CONFIG_VDSO_GETRANDOM
 static union {
@@ -46,7 +46,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mappin=
g *sm,
=20
 	switch (vmf->pgoff) {
 	case VDSO_TIME_PAGE_OFFSET:
-		if (!IS_ENABLED(CONFIG_HAVE_GENERIC_VDSO))
+		if (!IS_ENABLED(CONFIG_GENERIC_GETTIMEOFDAY))
 			return VM_FAULT_SIGBUS;
 		pfn =3D __phys_to_pfn(__pa_symbol(vdso_k_time_data));
 		if (timens_page) {
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 02ea19f67164..95df0153f05a 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -108,15 +108,11 @@ bool vdso_get_timestamp(const struct vdso_time_data *vd=
, const struct vdso_clock
 	return true;
 }
=20
-#ifdef CONFIG_TIME_NS
-
-#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
 static __always_inline
 const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso=
_time_data *vd)
 {
 	return (void *)vd + PAGE_SIZE;
 }
-#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
=20
 static __always_inline
 bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clo=
ck *vcns,
@@ -149,20 +145,6 @@ bool do_hres_timens(const struct vdso_time_data *vdns, c=
onst struct vdso_clock *
=20
 	return true;
 }
-#else
-static __always_inline
-const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso=
_time_data *vd)
-{
-	return NULL;
-}
-
-static __always_inline
-bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clo=
ck *vcns,
-		    clockid_t clk, struct __kernel_timespec *ts)
-{
-	return false;
-}
-#endif
=20
 static __always_inline
 bool do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
@@ -204,7 +186,6 @@ bool do_hres(const struct vdso_time_data *vd, const struc=
t vdso_clock *vc,
 	return true;
 }
=20
-#ifdef CONFIG_TIME_NS
 static __always_inline
 bool do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_c=
lock *vcns,
 		      clockid_t clk, struct __kernel_timespec *ts)
@@ -233,14 +214,6 @@ bool do_coarse_timens(const struct vdso_time_data *vdns,=
 const struct vdso_clock
=20
 	return true;
 }
-#else
-static __always_inline
-bool do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_c=
lock *vcns,
-		      clockid_t clk, struct __kernel_timespec *ts)
-{
-	return false;
-}
-#endif
=20
 static __always_inline
 bool do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,
diff --git a/tools/testing/selftests/pidfd/config b/tools/testing/selftests/p=
idfd/config
index 6133524710f7..cf7cc0ce0248 100644
--- a/tools/testing/selftests/pidfd/config
+++ b/tools/testing/selftests/pidfd/config
@@ -4,6 +4,5 @@ CONFIG_USER_NS=3Dy
 CONFIG_PID_NS=3Dy
 CONFIG_NET_NS=3Dy
 CONFIG_TIME_NS=3Dy
-CONFIG_GENERIC_VDSO_TIME_NS=3Dy
 CONFIG_CGROUPS=3Dy
 CONFIG_CHECKPOINT_RESTORE=3Dy
diff --git a/tools/testing/selftests/vDSO/.gitignore b/tools/testing/selftest=
s/vDSO/.gitignore
index 30d5c8f0e5c7..ba322a353aff 100644
--- a/tools/testing/selftests/vDSO/.gitignore
+++ b/tools/testing/selftests/vDSO/.gitignore
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 vdso_test
 vdso_test_abi
-vdso_test_clock_getres
 vdso_test_correctness
 vdso_test_gettimeofday
 vdso_test_getcpu
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/=
vDSO/Makefile
index 918a2caa070e..e361aca22a74 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -4,7 +4,6 @@ include ../../../scripts/Makefile.arch
 TEST_GEN_PROGS :=3D vdso_test_gettimeofday
 TEST_GEN_PROGS +=3D vdso_test_getcpu
 TEST_GEN_PROGS +=3D vdso_test_abi
-TEST_GEN_PROGS +=3D vdso_test_clock_getres
 ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS +=3D vdso_standalone_test_x86
 endif
@@ -29,7 +28,6 @@ CFLAGS_NOLIBC :=3D -nostdlib -nostdinc -ffreestanding -fno-=
asynchronous-unwind-tab
 $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
-$(OUTPUT)/vdso_test_clock_getres: vdso_test_clock_getres.c
=20
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c =
| headers
 $(OUTPUT)/vdso_standalone_test_x86: CFLAGS:=3D$(CFLAGS_NOLIBC) $(CFLAGS)
diff --git a/tools/testing/selftests/vDSO/vdso_call.h b/tools/testing/selftes=
ts/vDSO/vdso_call.h
index bb237d771051..e7205584cbdc 100644
--- a/tools/testing/selftests/vDSO/vdso_call.h
+++ b/tools/testing/selftests/vDSO/vdso_call.h
@@ -44,7 +44,6 @@
 	register long _r6 asm ("r6");					\
 	register long _r7 asm ("r7");					\
 	register long _r8 asm ("r8");					\
-	register long _rval asm ("r3");					\
 									\
 	LOADARGS_##nr(fn, args);					\
 									\
@@ -54,13 +53,13 @@
 		"	bns+	1f\n"					\
 		"	neg	3, 3\n"					\
 		"1:"							\
-		: "+r" (_r0), "=3Dr" (_r3), "+r" (_r4), "+r" (_r5),	\
+		: "+r" (_r0), "+r" (_r3), "+r" (_r4), "+r" (_r5),	\
 		  "+r" (_r6), "+r" (_r7), "+r" (_r8)			\
-		: "r" (_rval)						\
+		:							\
 		: "r9", "r10", "r11", "r12", "cr0", "cr1", "cr5",	\
 		  "cr6", "cr7", "xer", "lr", "ctr", "memory"		\
 	);								\
-	_rval;								\
+	_r3;								\
 })
=20
 #else
diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/sel=
ftests/vDSO/vdso_test_abi.c
index a54424e2336f..238d609a457a 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -26,24 +26,31 @@
 static const char *version;
 static const char **name;
=20
+/* The same as struct __kernel_timespec */
+struct vdso_timespec64 {
+	uint64_t tv_sec;
+	uint64_t tv_nsec;
+};
+
 typedef long (*vdso_gettimeofday_t)(struct timeval *tv, struct timezone *tz);
 typedef long (*vdso_clock_gettime_t)(clockid_t clk_id, struct timespec *ts);
+typedef long (*vdso_clock_gettime64_t)(clockid_t clk_id, struct vdso_timespe=
c64 *ts);
 typedef long (*vdso_clock_getres_t)(clockid_t clk_id, struct timespec *ts);
 typedef time_t (*vdso_time_t)(time_t *t);
=20
-const char *vdso_clock_name[12] =3D {
-	"CLOCK_REALTIME",
-	"CLOCK_MONOTONIC",
-	"CLOCK_PROCESS_CPUTIME_ID",
-	"CLOCK_THREAD_CPUTIME_ID",
-	"CLOCK_MONOTONIC_RAW",
-	"CLOCK_REALTIME_COARSE",
-	"CLOCK_MONOTONIC_COARSE",
-	"CLOCK_BOOTTIME",
-	"CLOCK_REALTIME_ALARM",
-	"CLOCK_BOOTTIME_ALARM",
-	"CLOCK_SGI_CYCLE",
-	"CLOCK_TAI",
+static const char * const vdso_clock_name[] =3D {
+	[CLOCK_REALTIME]		=3D "CLOCK_REALTIME",
+	[CLOCK_MONOTONIC]		=3D "CLOCK_MONOTONIC",
+	[CLOCK_PROCESS_CPUTIME_ID]	=3D "CLOCK_PROCESS_CPUTIME_ID",
+	[CLOCK_THREAD_CPUTIME_ID]	=3D "CLOCK_THREAD_CPUTIME_ID",
+	[CLOCK_MONOTONIC_RAW]		=3D "CLOCK_MONOTONIC_RAW",
+	[CLOCK_REALTIME_COARSE]		=3D "CLOCK_REALTIME_COARSE",
+	[CLOCK_MONOTONIC_COARSE]	=3D "CLOCK_MONOTONIC_COARSE",
+	[CLOCK_BOOTTIME]		=3D "CLOCK_BOOTTIME",
+	[CLOCK_REALTIME_ALARM]		=3D "CLOCK_REALTIME_ALARM",
+	[CLOCK_BOOTTIME_ALARM]		=3D "CLOCK_BOOTTIME_ALARM",
+	[10 /* CLOCK_SGI_CYCLE */]	=3D "CLOCK_SGI_CYCLE",
+	[CLOCK_TAI]			=3D "CLOCK_TAI",
 };
=20
 static void vdso_test_gettimeofday(void)
@@ -70,6 +77,33 @@ static void vdso_test_gettimeofday(void)
 	}
 }
=20
+static void vdso_test_clock_gettime64(clockid_t clk_id)
+{
+	/* Find clock_gettime64. */
+	vdso_clock_gettime64_t vdso_clock_gettime64 =3D
+		(vdso_clock_gettime64_t)vdso_sym(version, name[5]);
+
+	if (!vdso_clock_gettime64) {
+		ksft_print_msg("Couldn't find %s\n", name[5]);
+		ksft_test_result_skip("%s %s\n", name[5],
+				      vdso_clock_name[clk_id]);
+		return;
+	}
+
+	struct vdso_timespec64 ts;
+	long ret =3D VDSO_CALL(vdso_clock_gettime64, 2, clk_id, &ts);
+
+	if (ret =3D=3D 0) {
+		ksft_print_msg("The time is %lld.%06lld\n",
+			       (long long)ts.tv_sec, (long long)ts.tv_nsec);
+		ksft_test_result_pass("%s %s\n", name[5],
+				      vdso_clock_name[clk_id]);
+	} else {
+		ksft_test_result_fail("%s %s\n", name[5],
+				      vdso_clock_name[clk_id]);
+	}
+}
+
 static void vdso_test_clock_gettime(clockid_t clk_id)
 {
 	/* Find clock_gettime. */
@@ -171,23 +205,23 @@ static inline void vdso_test_clock(clockid_t clock_id)
 	ksft_print_msg("clock_id: %s\n", vdso_clock_name[clock_id]);
=20
 	vdso_test_clock_gettime(clock_id);
+	vdso_test_clock_gettime64(clock_id);
=20
 	vdso_test_clock_getres(clock_id);
 }
=20
-#define VDSO_TEST_PLAN	16
+#define VDSO_TEST_PLAN	29
=20
 int main(int argc, char **argv)
 {
 	unsigned long sysinfo_ehdr =3D getauxval(AT_SYSINFO_EHDR);
=20
 	ksft_print_header();
-	ksft_set_plan(VDSO_TEST_PLAN);
=20
-	if (!sysinfo_ehdr) {
-		ksft_print_msg("AT_SYSINFO_EHDR is not present!\n");
-		return KSFT_SKIP;
-	}
+	if (!sysinfo_ehdr)
+		ksft_exit_skip("AT_SYSINFO_EHDR is not present!\n");
+
+	ksft_set_plan(VDSO_TEST_PLAN);
=20
 	version =3D versions[VDSO_VERSION];
 	name =3D (const char **)&names[VDSO_NAMES];
@@ -198,40 +232,17 @@ int main(int argc, char **argv)
=20
 	vdso_test_gettimeofday();
=20
-#if _POSIX_TIMERS > 0
-
-#ifdef CLOCK_REALTIME
 	vdso_test_clock(CLOCK_REALTIME);
-#endif
-
-#ifdef CLOCK_BOOTTIME
 	vdso_test_clock(CLOCK_BOOTTIME);
-#endif
-
-#ifdef CLOCK_TAI
 	vdso_test_clock(CLOCK_TAI);
-#endif
-
-#ifdef CLOCK_REALTIME_COARSE
 	vdso_test_clock(CLOCK_REALTIME_COARSE);
-#endif
-
-#ifdef CLOCK_MONOTONIC
 	vdso_test_clock(CLOCK_MONOTONIC);
-#endif
-
-#ifdef CLOCK_MONOTONIC_RAW
 	vdso_test_clock(CLOCK_MONOTONIC_RAW);
-#endif
-
-#ifdef CLOCK_MONOTONIC_COARSE
 	vdso_test_clock(CLOCK_MONOTONIC_COARSE);
-#endif
-
-#endif
+	vdso_test_clock(CLOCK_PROCESS_CPUTIME_ID);
+	vdso_test_clock(CLOCK_THREAD_CPUTIME_ID);
=20
 	vdso_test_time();
=20
-	ksft_print_cnts();
-	return ksft_get_fail_cnt() =3D=3D 0 ? KSFT_PASS : KSFT_FAIL;
+	ksft_finished();
 }
diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/te=
sting/selftests/vDSO/vdso_test_clock_getres.c
deleted file mode 100644
index b5d5f59f725a..000000000000
--- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
+++ /dev/null
@@ -1,123 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
-/*
- * vdso_clock_getres.c: Sample code to test clock_getres.
- * Copyright (c) 2019 Arm Ltd.
- *
- * Compile with:
- * gcc -std=3Dgnu99 vdso_clock_getres.c
- *
- * Tested on ARM, ARM64, MIPS32, x86 (32-bit and 64-bit),
- * Power (32-bit and 64-bit), S390x (32-bit and 64-bit).
- * Might work on other architectures.
- */
-
-#define _GNU_SOURCE
-#include <elf.h>
-#include <fcntl.h>
-#include <stdint.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <time.h>
-#include <sys/auxv.h>
-#include <sys/mman.h>
-#include <sys/time.h>
-#include <unistd.h>
-#include <sys/syscall.h>
-
-#include "../kselftest.h"
-
-static long syscall_clock_getres(clockid_t _clkid, struct timespec *_ts)
-{
-	long ret;
-
-	ret =3D syscall(SYS_clock_getres, _clkid, _ts);
-
-	return ret;
-}
-
-const char *vdso_clock_name[12] =3D {
-	"CLOCK_REALTIME",
-	"CLOCK_MONOTONIC",
-	"CLOCK_PROCESS_CPUTIME_ID",
-	"CLOCK_THREAD_CPUTIME_ID",
-	"CLOCK_MONOTONIC_RAW",
-	"CLOCK_REALTIME_COARSE",
-	"CLOCK_MONOTONIC_COARSE",
-	"CLOCK_BOOTTIME",
-	"CLOCK_REALTIME_ALARM",
-	"CLOCK_BOOTTIME_ALARM",
-	"CLOCK_SGI_CYCLE",
-	"CLOCK_TAI",
-};
-
-/*
- * This function calls clock_getres in vdso and by system call
- * with different values for clock_id.
- *
- * Example of output:
- *
- * clock_id: CLOCK_REALTIME [PASS]
- * clock_id: CLOCK_BOOTTIME [PASS]
- * clock_id: CLOCK_TAI [PASS]
- * clock_id: CLOCK_REALTIME_COARSE [PASS]
- * clock_id: CLOCK_MONOTONIC [PASS]
- * clock_id: CLOCK_MONOTONIC_RAW [PASS]
- * clock_id: CLOCK_MONOTONIC_COARSE [PASS]
- */
-static inline int vdso_test_clock(unsigned int clock_id)
-{
-	struct timespec x, y;
-
-	printf("clock_id: %s", vdso_clock_name[clock_id]);
-	clock_getres(clock_id, &x);
-	syscall_clock_getres(clock_id, &y);
-
-	if ((x.tv_sec !=3D y.tv_sec) || (x.tv_nsec !=3D y.tv_nsec)) {
-		printf(" [FAIL]\n");
-		return KSFT_FAIL;
-	}
-
-	printf(" [PASS]\n");
-	return KSFT_PASS;
-}
-
-int main(int argc, char **argv)
-{
-	int ret =3D 0;
-
-#if _POSIX_TIMERS > 0
-
-#ifdef CLOCK_REALTIME
-	ret +=3D vdso_test_clock(CLOCK_REALTIME);
-#endif
-
-#ifdef CLOCK_BOOTTIME
-	ret +=3D vdso_test_clock(CLOCK_BOOTTIME);
-#endif
-
-#ifdef CLOCK_TAI
-	ret +=3D vdso_test_clock(CLOCK_TAI);
-#endif
-
-#ifdef CLOCK_REALTIME_COARSE
-	ret +=3D vdso_test_clock(CLOCK_REALTIME_COARSE);
-#endif
-
-#ifdef CLOCK_MONOTONIC
-	ret +=3D vdso_test_clock(CLOCK_MONOTONIC);
-#endif
-
-#ifdef CLOCK_MONOTONIC_RAW
-	ret +=3D vdso_test_clock(CLOCK_MONOTONIC_RAW);
-#endif
-
-#ifdef CLOCK_MONOTONIC_COARSE
-	ret +=3D vdso_test_clock(CLOCK_MONOTONIC_COARSE);
-#endif
-
-#endif
-	if (ret > 0)
-		return KSFT_FAIL;
-
-	return KSFT_PASS;
-}


