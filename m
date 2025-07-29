Return-Path: <linux-kernel+bounces-749118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D42B14A58
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD623BF701
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C31285C8F;
	Tue, 29 Jul 2025 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jIdkKcKV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4BHxysGD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E51B0413
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778772; cv=none; b=Hy8WfKw+F9xKZTuOGFkhvEW4BM5fc2sD6v+mRjlXt6UPeH/R5xDCD2Q979UyGskPAIP1b2fHgembkkq15Idxw2Ebs+HftUC7CX6cH/iIP5xBEg7O1gpXVdbZNTz5BHcQfFSEzSik7n1kwMuBmAqfuQYxDvYslZywGkUfX4TWH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778772; c=relaxed/simple;
	bh=/CsVACXaSUrax3Yi4OEmsECny244MlNBE3uuAX1CK9E=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=YyI8s0JbXrTpgdXlDwdBKjbfAHsr4BU5uRwkFB6h1dCtDkii/maXg5C3wAcsxwgSaO14VTSq8S8RmL0op+6MO7hiq89NjNSUZdL08GilVfeW9GWnzOC/56d83qH2rz51ItTHmbsCPZ2duCh4j21eeeSKhGbsG62YJlbFdQLB8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jIdkKcKV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4BHxysGD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753778768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=o/wwjPIr/L6F6bTPbSDSJBHGnOIfmreslYOGtTLSat4=;
	b=jIdkKcKV+ZfSP0IAuVZdKYNA1r6PiM/sln6FwnpvDE677rL4ZlVbWbf4gmCWwb7RLghtnb
	hm5rK0XpO0pvEE0b1qymS3CAdnAAdm/ljfsA/zPYz7j9xF7ANlnko5AoOVj1cjYC/L1oc/
	0wWTFIX9BhBAl6LOtIDlecbEPh57K922Teyt2O7BR9DI3D9thnRqmkdppWbEJjPpxkm83m
	vnJqjKSVrIJjhScirihlb0WDm5dxBRDmwvPxuftqqvfYYciPFS3LyVPszzniLrgKGp4lEl
	2DQtUU4yXfLIyLirq7PBeqko+YAlqyW6877L0hUHevydSIpAQMfRrJBT4twL/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753778768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=o/wwjPIr/L6F6bTPbSDSJBHGnOIfmreslYOGtTLSat4=;
	b=4BHxysGDPl7KQQ+XoYvjAraRza6s7QVR05RoqKOSZJWtMPjFzOVr/Xwrfngb63SF6HScRN
	FDEw2qayZgCibWBQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/vdso for v6.17-rc1
References: 
 <175377875455.620102.9417697212609201411.tglx@xen13.tec.linutronix.de>
Message-ID: 
 <175377875763.620102.5832465811647184511.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Jul 2025 10:46:08 +0200 (CEST)

Linus,

please pull the latest timers/vdso branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-vdso-2025=
-07-29

up to:  437079605c26: selftests: vDSO: vdso_standalone_test_x86: Replace sour=
ce file with symlink

A set of updates for the VDSO selftests:

  - Skip the chacha test when the architecture does not provide the random
    infrastructure in the VDSO

  - Switch back to a symlink for vdso_standalone_test_x86 to avoid code
    duplication.

  - Improve code quality and TAP output compliance


 =20

Thanks,

	tglx

------------------>
Thomas Wei=C3=9Fschuh (9):
      selftests: vDSO: chacha: Correctly skip test if necessary
      selftests: vDSO: clock_getres: Drop unused include of err.h
      selftests: vDSO: vdso_test_getrandom: Drop unused include of linux/comp=
iler.h
      selftests: vDSO: vdso_test_getrandom: Avoid -Wunused
      selftests: vDSO: vdso_config: Avoid -Wunused-variables
      selftests: vDSO: Enable -Wall
      selftests: vDSO: vdso_test_correctness: Fix -Wstrict-prototypes
      selftests: vDSO: vdso_test_getrandom: Always print TAP header
      selftests: vDSO: vdso_standalone_test_x86: Replace source file with sym=
link


 tools/testing/selftests/vDSO/Makefile              |  2 +-
 tools/testing/selftests/vDSO/vdso_config.h         |  2 +
 .../selftests/vDSO/vdso_standalone_test_x86.c      | 59 +-------------------=
--
 tools/testing/selftests/vDSO/vdso_test_chacha.c    |  3 +-
 .../selftests/vDSO/vdso_test_clock_getres.c        |  1 -
 .../testing/selftests/vDSO/vdso_test_correctness.c |  2 +-
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 10 ++--
 7 files changed, 13 insertions(+), 66 deletions(-)
 mode change 100644 =3D> 120000 tools/testing/selftests/vDSO/vdso_standalone_=
test_x86.c

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/=
vDSO/Makefile
index 12a0614b9fd4..918a2caa070e 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -12,7 +12,7 @@ TEST_GEN_PROGS +=3D vdso_test_correctness
 TEST_GEN_PROGS +=3D vdso_test_getrandom
 TEST_GEN_PROGS +=3D vdso_test_chacha
=20
-CFLAGS :=3D -std=3Dgnu99 -O2
+CFLAGS :=3D -std=3Dgnu99 -O2 -Wall -Wstrict-prototypes
=20
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS +=3D -lgcc_s
diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selft=
ests/vDSO/vdso_config.h
index 722260f97561..5fdd0f362337 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -58,6 +58,7 @@
 #define VDSO_NAMES		1
 #endif
=20
+__attribute__((unused))
 static const char *versions[7] =3D {
 	"LINUX_2.6",
 	"LINUX_2.6.15",
@@ -68,6 +69,7 @@ static const char *versions[7] =3D {
 	"LINUX_5.10"
 };
=20
+__attribute__((unused))
 static const char *names[2][7] =3D {
 	{
 		"__kernel_gettimeofday",
diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/=
testing/selftests/vDSO/vdso_standalone_test_x86.c
deleted file mode 100644
index 9ce795b806f0..000000000000
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ /dev/null
@@ -1,58 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * vdso_test_gettimeofday.c: Sample code to test parse_vdso.c and
- *                           vDSO gettimeofday()
- * Copyright (c) 2014 Andy Lutomirski
- *
- * Compile with:
- * gcc -std=3Dgnu99 vdso_test_gettimeofday.c parse_vdso_gettimeofday.c
- *
- * Tested on x86, 32-bit and 64-bit.  It may work on other architectures, to=
o.
- */
-
-#include <stdio.h>
-#ifndef NOLIBC
-#include <sys/auxv.h>
-#include <sys/time.h>
-#endif
-
-#include "../kselftest.h"
-#include "parse_vdso.h"
-#include "vdso_config.h"
-#include "vdso_call.h"
-
-int main(int argc, char **argv)
-{
-	const char *version =3D versions[VDSO_VERSION];
-	const char **name =3D (const char **)&names[VDSO_NAMES];
-
-	unsigned long sysinfo_ehdr =3D getauxval(AT_SYSINFO_EHDR);
-	if (!sysinfo_ehdr) {
-		printf("AT_SYSINFO_EHDR is not present!\n");
-		return KSFT_SKIP;
-	}
-
-	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
-
-	/* Find gettimeofday. */
-	typedef long (*gtod_t)(struct timeval *tv, struct timezone *tz);
-	gtod_t gtod =3D (gtod_t)vdso_sym(version, name[0]);
-
-	if (!gtod) {
-		printf("Could not find %s\n", name[0]);
-		return KSFT_SKIP;
-	}
-
-	struct timeval tv;
-	long ret =3D VDSO_CALL(gtod, 2, &tv, 0);
-
-	if (ret =3D=3D 0) {
-		printf("The time is %lld.%06lld\n",
-		       (long long)tv.tv_sec, (long long)tv.tv_usec);
-	} else {
-		printf("%s failed\n", name[0]);
-		return KSFT_FAIL;
-	}
-
-	return 0;
-}
diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/=
testing/selftests/vDSO/vdso_standalone_test_x86.c
new file mode 120000
index 000000000000..4d3d96f1e440
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -0,0 +1 @@
+vdso_test_gettimeofday.c
\ No newline at end of file
diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/=
selftests/vDSO/vdso_test_chacha.c
index 8757f738b0b1..0aad682b12c8 100644
--- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -76,7 +76,8 @@ static void reference_chacha20_blocks(uint8_t *dst_bytes, c=
onst uint32_t *key, u
=20
 void __weak __arch_chacha20_blocks_nostack(uint8_t *dst_bytes, const uint32_=
t *key, uint32_t *counter, size_t nblocks)
 {
-	ksft_exit_skip("Not implemented on architecture\n");
+	ksft_test_result_skip("Not implemented on architecture\n");
+	ksft_finished();
 }
=20
 int main(int argc, char *argv[])
diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/te=
sting/selftests/vDSO/vdso_test_clock_getres.c
index 38d46a8bf7cb..b5d5f59f725a 100644
--- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
+++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
@@ -13,7 +13,6 @@
=20
 #define _GNU_SOURCE
 #include <elf.h>
-#include <err.h>
 #include <fcntl.h>
 #include <stdint.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/tes=
ting/selftests/vDSO/vdso_test_correctness.c
index 5fb97ad67eea..da651cf53c6c 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -108,7 +108,7 @@ static void *vsyscall_getcpu(void)
 }
=20
=20
-static void fill_function_pointers()
+static void fill_function_pointers(void)
 {
 	void *vdso =3D dlopen("linux-vdso.so.1",
 			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testi=
ng/selftests/vDSO/vdso_test_getrandom.c
index 95057f7567db..dd1132508a0d 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -21,7 +21,6 @@
 #include <sys/wait.h>
 #include <sys/types.h>
 #include <linux/random.h>
-#include <linux/compiler.h>
 #include <linux/ptrace.h>
=20
 #include "../kselftest.h"
@@ -101,6 +100,7 @@ static void *vgetrandom_get_state(void)
 	return state;
 }
=20
+__attribute__((unused)) /* Example for libc implementors */
 static void vgetrandom_put_state(void *state)
 {
 	if (!state)
@@ -242,6 +242,7 @@ static void kselftest(void)
 	pid_t child;
=20
 	ksft_print_header();
+	vgetrandom_init();
 	ksft_set_plan(2);
=20
 	for (size_t i =3D 0; i < 1000; ++i) {
@@ -265,7 +266,7 @@ static void kselftest(void)
 	}
 	for (;;) {
 		struct ptrace_syscall_info info =3D { 0 };
-		int status, ret;
+		int status;
 		ksft_assert(waitpid(child, &status, 0) >=3D 0);
 		if (WIFEXITED(status)) {
 			ksft_assert(WEXITSTATUS(status) =3D=3D 0);
@@ -295,8 +296,6 @@ static void usage(const char *argv0)
=20
 int main(int argc, char *argv[])
 {
-	vgetrandom_init();
-
 	if (argc =3D=3D 1) {
 		kselftest();
 		return 0;
@@ -306,6 +305,9 @@ int main(int argc, char *argv[])
 		usage(argv[0]);
 		return 1;
 	}
+
+	vgetrandom_init();
+
 	if (!strcmp(argv[1], "bench-single"))
 		bench_single();
 	else if (!strcmp(argv[1], "bench-multi"))


