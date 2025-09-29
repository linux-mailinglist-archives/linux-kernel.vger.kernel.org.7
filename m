Return-Path: <linux-kernel+bounces-836056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA068BA89FC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9677E1881BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EDE2D0292;
	Mon, 29 Sep 2025 09:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z5+6qZP0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MaqAxYGv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0E299A81
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138151; cv=none; b=hHnfqy9O6wIbNiP/nqlG7nIYVTh5vwMAZoD7EqpIZCqlDL5kl/qi8Kw8qOO5t3SQtlxT8cIuiSDFx0il8ok8mILuOklfRV51sgGvrkKtfYnuyqks/fUWkIUrIGyIk02v00q5XzWmiPOXduXHc6/N5+hu8s49Mo8NCQ9kHxCSRLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138151; c=relaxed/simple;
	bh=uaqrx74U0+6kHe6Hgk6l7HWNUn3O1go9qVcUb5Fy71k=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=SCM/lncvhqm08pqcLaOvzpZno2NJOTwl2jzwyS9tkVg7m8XWeNakGB1irDLhtbyePFEuERqzt3IbmWMdJHNcc4Dn1U4taM+Jrcl26YXUVHvcldaqXtWLbcl5W0UoDuxUj7bwB+DtwyG++WPCFFmkzDfSzYiy1++HhbZSenZAzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z5+6qZP0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MaqAxYGv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759138144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=mHVTEQGRFNX9xSUh9Dx6d59Zejf72DCjwRTlBTvKoLk=;
	b=Z5+6qZP00DJaE/24hRr63Wu8PfDsDuE5aT9e9SW2zguzRVNopoaUSGtrS1kHAjUHiw1Pk1
	jKjyUdqkCwJ6YwiKuLtsutbzhVImgiGoYT5PNOHBKeEBRx/rT4seR4XwJNtvPK8XKiMFCm
	TzIlQ0QbI789Kc/aOFcCkDPC/u84bTR2guOHipBPpSKv+OovQkF3TccZ1TpZBHB0YtXkDZ
	wBZDpxh1usg6Oh28OojbgQXbPCqgy/ygXKkWd9ZSw8g8gihz8TM+mOZNis9FuzMb/LfXiS
	x0wA54wzc3AR0VhymLsCyNScJF2928pN3VYVmffHYMofijb/Uv2PgQ82/Ba+Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759138144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=mHVTEQGRFNX9xSUh9Dx6d59Zejf72DCjwRTlBTvKoLk=;
	b=MaqAxYGv6prayqlnJGI9Yt5jDftTEL6WAByKLCP+TcbZabDjJvG7+f9HECvzINgHIudj3Q
	TIkrcgeUr/0VJ4Bw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/futex for v6.18-rc1
References: <175913807599.495041.10251515322736195577.tglx@xen13>
Message-ID: <175913808316.495041.17299607238306952698.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Sep 2025 11:29:02 +0200 (CEST)

Linus,

please pull the latest locking/futex branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-futex-20=
25-09-29

up to:  4386f71623b7: selftest/futex: Fix spelling mistake "boundarie" -> "bo=
undary"

A set of updates for futexes and related selftests:

  - Plug the ptrace_may_access() race against a concurrent exec() which
    allows to pass the check before the target's process transition in
    exec() by taking a read lock on signal->ext_update_lock.

  - A large set of cleanups and enhancement to the futex selftests. The
    bulk of changes is the conversion to the kselftest harness.

Thanks,

	tglx

------------------>
Andr=C3=A9 Almeida (17):
      selftest/futex: Make the error check more precise for futex_numa_mpol
      selftest/futex: Reintroduce "Memory out of range" numa_mpol's subtest
      selftests: kselftest: Create ksft_print_dbg_msg()
      selftests/futex: Refactor futex_requeue_pi with kselftest_harness.h
      selftests/futex: Refactor futex_requeue_pi_mismatched_ops with kselftes=
t_harness.h
      selftests/futex: Refactor futex_requeue_pi_signal_restart with kselftes=
t_harness.h
      selftests/futex: Refactor futex_wait_timeout with kselftest_harness.h
      selftests/futex: Refactor futex_wait_wouldblock with kselftest_harness.h
      selftests/futex: Refactor futex_wait_unitialized_heap with kselftest_ha=
rness.h
      selftests/futex: Refactor futex_wait_private_mapped_file with kselftest=
_harness.h
      selftests/futex: Refactor futex_wait with kselftest_harness.h
      selftests/futex: Refactor futex_requeue with kselftest_harness.h
      selftests/futex: Refactor futex_waitv with kselftest_harness.h
      selftests/futex: Refactor futex_priv_hash with kselftest_harness.h
      selftests/futex: Refactor futex_numa_mpol with kselftest_harness.h
      selftests/futex: Drop logging.h include from futex_numa
      selftests/futex: Remove logging.h file

Colin Ian King (1):
      selftest/futex: Fix spelling mistake "boundarie" -> "boundary"

Dan Carpenter (1):
      selftests/futex: Fix futex_wait() for 32bit ARM

Gopi Krishna Menon (1):
      selftests/futex: Fix typos and grammar in futex_priv_hash

Nai-Chen Cheng (1):
      selftests/futex: Fix format-security warnings in futex_priv_hash

Pranav Tyagi (1):
      futex: Don't leak robust_list pointer on exec race

Sebastian Andrzej Siewior (2):
      selftests/futex: Remove the -g parameter from futex_priv_hash
      selftest/futex: Compile also with libnuma < 2.0.16

Waiman Long (1):
      selftests/futex: Fix some futex_numa_mpol subtests


 kernel/futex/syscalls.c                            | 106 ++++----
 tools/testing/selftests/futex/functional/Makefile  |   8 +-
 .../selftests/futex/functional/futex_numa.c        |   3 +-
 .../selftests/futex/functional/futex_numa_mpol.c   | 100 ++++----
 .../selftests/futex/functional/futex_priv_hash.c   |  67 ++----
 .../selftests/futex/functional/futex_requeue.c     |  76 ++----
 .../selftests/futex/functional/futex_requeue_pi.c  | 266 ++++++++++---------=
--
 .../functional/futex_requeue_pi_mismatched_ops.c   |  86 ++-----
 .../functional/futex_requeue_pi_signal_restart.c   | 129 +++-------
 .../selftests/futex/functional/futex_wait.c        | 103 +++-----
 .../functional/futex_wait_private_mapped_file.c    |  83 ++-----
 .../futex/functional/futex_wait_timeout.c          | 139 +++++------
 .../functional/futex_wait_uninitialized_heap.c     |  76 ++----
 .../futex/functional/futex_wait_wouldblock.c       |  76 ++----
 .../selftests/futex/functional/futex_waitv.c       |  99 ++++----
 tools/testing/selftests/futex/functional/run.sh    |  62 +----
 tools/testing/selftests/futex/include/futextest.h  |  11 +
 tools/testing/selftests/futex/include/logging.h    | 148 ------------
 tools/testing/selftests/kselftest.h                |  14 ++
 tools/testing/selftests/kselftest_harness.h        |  13 +-
 20 files changed, 575 insertions(+), 1090 deletions(-)
 delete mode 100644 tools/testing/selftests/futex/include/logging.h

diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 4b6da9116aa6..880c9bf2f315 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -39,6 +39,56 @@ SYSCALL_DEFINE2(set_robust_list, struct robust_list_head _=
_user *, head,
 	return 0;
 }
=20
+static inline void __user *futex_task_robust_list(struct task_struct *p, boo=
l compat)
+{
+#ifdef CONFIG_COMPAT
+	if (compat)
+		return p->compat_robust_list;
+#endif
+	return p->robust_list;
+}
+
+static void __user *futex_get_robust_list_common(int pid, bool compat)
+{
+	struct task_struct *p =3D current;
+	void __user *head;
+	int ret;
+
+	scoped_guard(rcu) {
+		if (pid) {
+			p =3D find_task_by_vpid(pid);
+			if (!p)
+				return (void __user *)ERR_PTR(-ESRCH);
+		}
+		get_task_struct(p);
+	}
+
+	/*
+	 * Hold exec_update_lock to serialize with concurrent exec()
+	 * so ptrace_may_access() is checked against stable credentials
+	 */
+	ret =3D down_read_killable(&p->signal->exec_update_lock);
+	if (ret)
+		goto err_put;
+
+	ret =3D -EPERM;
+	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
+		goto err_unlock;
+
+	head =3D futex_task_robust_list(p, compat);
+
+	up_read(&p->signal->exec_update_lock);
+	put_task_struct(p);
+
+	return head;
+
+err_unlock:
+	up_read(&p->signal->exec_update_lock);
+err_put:
+	put_task_struct(p);
+	return (void __user *)ERR_PTR(ret);
+}
+
 /**
  * sys_get_robust_list() - Get the robust-futex list head of a task
  * @pid:	pid of the process [zero for current task]
@@ -49,36 +99,14 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 		struct robust_list_head __user * __user *, head_ptr,
 		size_t __user *, len_ptr)
 {
-	struct robust_list_head __user *head;
-	unsigned long ret;
-	struct task_struct *p;
-
-	rcu_read_lock();
-
-	ret =3D -ESRCH;
-	if (!pid)
-		p =3D current;
-	else {
-		p =3D find_task_by_vpid(pid);
-		if (!p)
-			goto err_unlock;
-	}
-
-	ret =3D -EPERM;
-	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
-		goto err_unlock;
+	struct robust_list_head __user *head =3D futex_get_robust_list_common(pid, =
false);
=20
-	head =3D p->robust_list;
-	rcu_read_unlock();
+	if (IS_ERR(head))
+		return PTR_ERR(head);
=20
 	if (put_user(sizeof(*head), len_ptr))
 		return -EFAULT;
 	return put_user(head, head_ptr);
-
-err_unlock:
-	rcu_read_unlock();
-
-	return ret;
 }
=20
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
@@ -455,36 +483,14 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 			compat_uptr_t __user *, head_ptr,
 			compat_size_t __user *, len_ptr)
 {
-	struct compat_robust_list_head __user *head;
-	unsigned long ret;
-	struct task_struct *p;
-
-	rcu_read_lock();
-
-	ret =3D -ESRCH;
-	if (!pid)
-		p =3D current;
-	else {
-		p =3D find_task_by_vpid(pid);
-		if (!p)
-			goto err_unlock;
-	}
-
-	ret =3D -EPERM;
-	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
-		goto err_unlock;
+	struct compat_robust_list_head __user *head =3D futex_get_robust_list_commo=
n(pid, true);
=20
-	head =3D p->compat_robust_list;
-	rcu_read_unlock();
+	if (IS_ERR(head))
+		return PTR_ERR(head);
=20
 	if (put_user(sizeof(*head), len_ptr))
 		return -EFAULT;
 	return put_user(ptr_to_compat(head), head_ptr);
-
-err_unlock:
-	rcu_read_unlock();
-
-	return ret;
 }
 #endif /* CONFIG_COMPAT */
=20
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testin=
g/selftests/futex/functional/Makefile
index 8cfb87f7f7c5..490ace1f017e 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,12 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
+PKG_CONFIG ?=3D pkg-config
+LIBNUMA_TEST =3D $(shell sh -c "$(PKG_CONFIG) numa --atleast-version 2.0.16 =
> /dev/null 2>&1 && echo SUFFICIENT || echo NO")
+
 INCLUDES :=3D -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS :=3D $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS :=3D $(CFLAGS) -g -O2 -Wall -pthread -D_FILE_OFFSET_BITS=3D64 -D_TIME=
_BITS=3D64 $(INCLUDES) $(KHDR_INCLUDES) -DLIBNUMA_VER_$(LIBNUMA_TEST)=3D1
 LDLIBS :=3D -lpthread -lrt -lnuma
=20
 LOCAL_HDRS :=3D \
 	../include/futextest.h \
-	../include/atomic.h \
-	../include/logging.h
+	../include/atomic.h
 TEST_GEN_PROGS :=3D \
 	futex_wait_timeout \
 	futex_wait_wouldblock \
diff --git a/tools/testing/selftests/futex/functional/futex_numa.c b/tools/te=
sting/selftests/futex/functional/futex_numa.c
index f29e4d627e79..e0a33510ccb6 100644
--- a/tools/testing/selftests/futex/functional/futex_numa.c
+++ b/tools/testing/selftests/futex/functional/futex_numa.c
@@ -5,9 +5,10 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 #include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <time.h>
 #include <assert.h>
-#include "logging.h"
 #include "futextest.h"
 #include "futex2test.h"
=20
diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/too=
ls/testing/selftests/futex/functional/futex_numa_mpol.c
index a9ecfb2d3932..d037a3f10ee8 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -16,9 +16,9 @@
 #include <linux/futex.h>
 #include <sys/mman.h>
=20
-#include "logging.h"
 #include "futextest.h"
 #include "futex2test.h"
+#include "../../kselftest_harness.h"
=20
 #define MAX_THREADS	64
=20
@@ -77,7 +77,7 @@ static void join_max_threads(void)
 	}
 }
=20
-static void __test_futex(void *futex_ptr, int must_fail, unsigned int futex_=
flags)
+static void __test_futex(void *futex_ptr, int err_value, unsigned int futex_=
flags)
 {
 	int to_wake, ret, i, need_exit =3D 0;
=20
@@ -88,11 +88,17 @@ static void __test_futex(void *futex_ptr, int must_fail, =
unsigned int futex_flag
=20
 	do {
 		ret =3D futex2_wake(futex_ptr, to_wake, futex_flags);
-		if (must_fail) {
-			if (ret < 0)
-				break;
-			ksft_exit_fail_msg("futex2_wake(%d, 0x%x) should fail, but didn't\n",
-					   to_wake, futex_flags);
+
+		if (err_value) {
+			if (ret >=3D 0)
+				ksft_exit_fail_msg("futex2_wake(%d, 0x%x) should fail, but didn't\n",
+						   to_wake, futex_flags);
+
+			if (errno !=3D err_value)
+				ksft_exit_fail_msg("futex2_wake(%d, 0x%x) expected error was %d, but ret=
urned %d (%s)\n",
+						   to_wake, futex_flags, err_value, errno, strerror(errno));
+
+			break;
 		}
 		if (ret < 0) {
 			ksft_exit_fail_msg("Failed futex2_wake(%d, 0x%x): %m\n",
@@ -106,12 +112,12 @@ static void __test_futex(void *futex_ptr, int must_fail=
, unsigned int futex_flag
 	join_max_threads();
=20
 	for (i =3D 0; i < MAX_THREADS; i++) {
-		if (must_fail && thread_args[i].result !=3D -1) {
+		if (err_value && thread_args[i].result !=3D -1) {
 			ksft_print_msg("Thread %d should fail but succeeded (%d)\n",
 				       i, thread_args[i].result);
 			need_exit =3D 1;
 		}
-		if (!must_fail && thread_args[i].result !=3D 0) {
+		if (!err_value && thread_args[i].result !=3D 0) {
 			ksft_print_msg("Thread %d failed (%d)\n", i, thread_args[i].result);
 			need_exit =3D 1;
 		}
@@ -120,58 +126,30 @@ static void __test_futex(void *futex_ptr, int must_fail=
, unsigned int futex_flag
 		ksft_exit_fail_msg("Aborting due to earlier errors.\n");
 }
=20
-static void test_futex(void *futex_ptr, int must_fail)
+static void test_futex(void *futex_ptr, int err_value)
 {
-	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | F=
UTEX2_NUMA);
+	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | F=
UTEX2_NUMA);
 }
=20
-static void test_futex_mpol(void *futex_ptr, int must_fail)
+static void test_futex_mpol(void *futex_ptr, int err_value)
 {
-	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | F=
UTEX2_NUMA | FUTEX2_MPOL);
+	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | F=
UTEX2_NUMA | FUTEX2_MPOL);
 }
=20
-static void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c    Use color\n");
-	printf("  -h    Display this help message\n");
-	printf("  -v L  Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
-int main(int argc, char *argv[])
+TEST(futex_numa_mpol)
 {
 	struct futex32_numa *futex_numa;
-	int mem_size, i;
 	void *futex_ptr;
-	int c;
-
-	while ((c =3D getopt(argc, argv, "chv:")) !=3D -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-			break;
-		case 'v':
-			log_verbosity(atoi(optarg));
-			break;
-		default:
-			usage(basename(argv[0]));
-			exit(1);
-		}
-	}
-
-	ksft_print_header();
-	ksft_set_plan(1);
+	int mem_size;
=20
 	mem_size =3D sysconf(_SC_PAGE_SIZE);
-	futex_ptr =3D mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MA=
P_ANONYMOUS, 0, 0);
+	futex_ptr =3D mmap(NULL, mem_size * 2, PROT_READ | PROT_WRITE, MAP_PRIVATE =
| MAP_ANONYMOUS, 0, 0);
 	if (futex_ptr =3D=3D MAP_FAILED)
 		ksft_exit_fail_msg("mmap() for %d bytes failed\n", mem_size);
=20
+	/* Create an invalid memory region for the "Memory out of range" test */
+	mprotect(futex_ptr + mem_size, mem_size, PROT_NONE);
+
 	futex_numa =3D futex_ptr;
=20
 	ksft_print_msg("Regular test\n");
@@ -182,27 +160,31 @@ int main(int argc, char *argv[])
 	if (futex_numa->numa =3D=3D FUTEX_NO_NODE)
 		ksft_exit_fail_msg("NUMA node is left uninitialized\n");
=20
-	ksft_print_msg("Memory too small\n");
-	test_futex(futex_ptr + mem_size - 4, 1);
+	/* FUTEX2_NUMA futex must be 8-byte aligned */
+	ksft_print_msg("Mis-aligned futex\n");
+	test_futex(futex_ptr + mem_size - 4, EINVAL);
=20
 	ksft_print_msg("Memory out of range\n");
-	test_futex(futex_ptr + mem_size, 1);
+	test_futex(futex_ptr + mem_size, EFAULT);
=20
 	futex_numa->numa =3D FUTEX_NO_NODE;
 	mprotect(futex_ptr, mem_size, PROT_READ);
 	ksft_print_msg("Memory, RO\n");
-	test_futex(futex_ptr, 1);
+	test_futex(futex_ptr, EFAULT);
=20
 	mprotect(futex_ptr, mem_size, PROT_NONE);
 	ksft_print_msg("Memory, no access\n");
-	test_futex(futex_ptr, 1);
+	test_futex(futex_ptr, EFAULT);
=20
 	mprotect(futex_ptr, mem_size, PROT_READ | PROT_WRITE);
 	ksft_print_msg("Memory back to RW\n");
 	test_futex(futex_ptr, 0);
=20
+	ksft_test_result_pass("futex2 memory boundary tests passed\n");
+
 	/* MPOL test. Does not work as expected */
-	for (i =3D 0; i < 4; i++) {
+#ifdef LIBNUMA_VER_SUFFICIENT
+	for (int i =3D 0; i < 4; i++) {
 		unsigned long nodemask;
 		int ret;
=20
@@ -221,15 +203,17 @@ int main(int argc, char *argv[])
 			ret =3D futex2_wake(futex_ptr, 0, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | =
FUTEX2_NUMA | FUTEX2_MPOL);
 			if (ret < 0)
 				ksft_test_result_fail("Failed to wake 0 with MPOL: %m\n");
-			if (0)
-				test_futex_mpol(futex_numa, 0);
 			if (futex_numa->numa !=3D i) {
 				ksft_exit_fail_msg("Returned NUMA node is %d expected %d\n",
 						   futex_numa->numa, i);
 			}
 		}
 	}
-	ksft_test_result_pass("NUMA MPOL tests passed\n");
-	ksft_finished();
-	return 0;
+	ksft_test_result_pass("futex2 MPOL hints test passed\n");
+#else
+	ksft_test_result_skip("futex2 MPOL hints test requires libnuma 2.0.16+\n");
+#endif
+	munmap(futex_ptr, mem_size * 2);
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/too=
ls/testing/selftests/futex/functional/futex_priv_hash.c
index aea001ac4946..3b7b5851f290 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -14,7 +14,7 @@
 #include <linux/prctl.h>
 #include <sys/prctl.h>
=20
-#include "logging.h"
+#include "../../kselftest_harness.h"
=20
 #define MAX_THREADS	64
=20
@@ -128,46 +128,14 @@ static void futex_dummy_op(void)
 		ksft_exit_fail_msg("pthread_mutex_timedlock() did not timeout: %d.\n", ret=
);
 }
=20
-static void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c    Use color\n");
-	printf("  -g    Test global hash instead intead local immutable \n");
-	printf("  -h    Display this help message\n");
-	printf("  -v L  Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 static const char *test_msg_auto_create =3D "Automatic hash bucket init on t=
hread creation.\n";
 static const char *test_msg_auto_inc =3D "Automatic increase with more than =
16 CPUs\n";
=20
-int main(int argc, char *argv[])
+TEST(priv_hash)
 {
 	int futex_slots1, futex_slotsn, online_cpus;
 	pthread_mutexattr_t mutex_attr_pi;
 	int ret, retry =3D 20;
-	int c;
-
-	while ((c =3D getopt(argc, argv, "chv:")) !=3D -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-			break;
-		case 'v':
-			log_verbosity(atoi(optarg));
-			break;
-		default:
-			usage(basename(argv[0]));
-			exit(1);
-		}
-	}
-
-	ksft_print_header();
-	ksft_set_plan(21);
=20
 	ret =3D pthread_mutexattr_init(&mutex_attr_pi);
 	ret |=3D pthread_mutexattr_setprotocol(&mutex_attr_pi, PTHREAD_PRIO_INHERIT=
);
@@ -189,14 +157,14 @@ int main(int argc, char *argv[])
 	if (ret !=3D 0)
 		ksft_exit_fail_msg("pthread_join() failed: %d, %m\n", ret);
=20
-	/* First thread, has to initialiaze private hash */
+	/* First thread, has to initialize private hash */
 	futex_slots1 =3D futex_hash_slots_get();
 	if (futex_slots1 <=3D 0) {
 		ksft_print_msg("Current hash buckets: %d\n", futex_slots1);
-		ksft_exit_fail_msg(test_msg_auto_create);
+		ksft_exit_fail_msg("%s", test_msg_auto_create);
 	}
=20
-	ksft_test_result_pass(test_msg_auto_create);
+	ksft_test_result_pass("%s", test_msg_auto_create);
=20
 	online_cpus =3D sysconf(_SC_NPROCESSORS_ONLN);
 	ret =3D pthread_barrier_init(&barrier_main, NULL, MAX_THREADS + 1);
@@ -237,11 +205,11 @@ int main(int argc, char *argv[])
 			}
 			ksft_print_msg("Expected increase of hash buckets but got: %d -> %d\n",
 				       futex_slots1, futex_slotsn);
-			ksft_exit_fail_msg(test_msg_auto_inc);
+			ksft_exit_fail_msg("%s", test_msg_auto_inc);
 		}
-		ksft_test_result_pass(test_msg_auto_inc);
+		ksft_test_result_pass("%s", test_msg_auto_inc);
 	} else {
-		ksft_test_result_skip(test_msg_auto_inc);
+		ksft_test_result_skip("%s", test_msg_auto_inc);
 	}
 	ret =3D pthread_mutex_unlock(&global_lock);
=20
@@ -257,17 +225,17 @@ int main(int argc, char *argv[])
=20
 	futex_hash_slots_set_verify(2);
 	join_max_threads();
-	ksft_test_result(counter =3D=3D MAX_THREADS, "Created of waited for %d of %=
d threads\n",
+	ksft_test_result(counter =3D=3D MAX_THREADS, "Created and waited for %d of =
%d threads\n",
 			 counter, MAX_THREADS);
 	counter =3D 0;
-	/* Once the user set something, auto reisze must be disabled */
+	/* Once the user set something, auto resize must be disabled */
 	ret =3D pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
=20
 	create_max_threads(thread_lock_fn);
 	join_max_threads();
=20
 	ret =3D futex_hash_slots_get();
-	ksft_test_result(ret =3D=3D 2, "No more auto-resize after manaul setting, g=
ot %d\n",
+	ksft_test_result(ret =3D=3D 2, "No more auto-resize after manual setting, g=
ot %d\n",
 			 ret);
=20
 	futex_hash_slots_set_must_fail(1 << 29);
@@ -280,7 +248,7 @@ int main(int argc, char *argv[])
 	ret =3D futex_hash_slots_set(0);
 	ksft_test_result(ret =3D=3D 0, "Global hash request\n");
 	if (ret !=3D 0)
-		goto out;
+		return;
=20
 	futex_hash_slots_set_must_fail(4);
 	futex_hash_slots_set_must_fail(8);
@@ -289,17 +257,14 @@ int main(int argc, char *argv[])
 	futex_hash_slots_set_must_fail(6);
=20
 	ret =3D pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
-	if (ret !=3D 0) {
+	if (ret !=3D 0)
 		ksft_exit_fail_msg("pthread_barrier_init failed: %m\n");
-		return 1;
-	}
+
 	create_max_threads(thread_lock_fn);
 	join_max_threads();
=20
 	ret =3D futex_hash_slots_get();
 	ksft_test_result(ret =3D=3D 0, "Continue to use global hash\n");
-
-out:
-	ksft_finished();
-	return 0;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools=
/testing/selftests/futex/functional/futex_requeue.c
index 51485be6eb2f..69e2555b6039 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -7,24 +7,15 @@
=20
 #include <pthread.h>
 #include <limits.h>
-#include "logging.h"
+
 #include "futextest.h"
+#include "../../kselftest_harness.h"
=20
-#define TEST_NAME "futex-requeue"
 #define timeout_ns  30000000
 #define WAKE_WAIT_US 10000
=20
 volatile futex_t *f1;
=20
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 void *waiterfn(void *arg)
 {
 	struct timespec to;
@@ -38,67 +29,49 @@ void *waiterfn(void *arg)
 	return NULL;
 }
=20
-int main(int argc, char *argv[])
+TEST(requeue_single)
 {
-	pthread_t waiter[10];
-	int res, ret =3D RET_PASS;
-	int c, i;
 	volatile futex_t _f1 =3D 0;
 	volatile futex_t f2 =3D 0;
+	pthread_t waiter[10];
+	int res;
=20
 	f1 =3D &_f1;
=20
-	while ((c =3D getopt(argc, argv, "cht:v:")) !=3D -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-		case 'v':
-			log_verbosity(atoi(optarg));
-			break;
-		default:
-			usage(basename(argv[0]));
-			exit(1);
-		}
-	}
-
-	ksft_print_header();
-	ksft_set_plan(2);
-	ksft_print_msg("%s: Test futex_requeue\n",
-		       basename(argv[0]));
-
 	/*
 	 * Requeue a waiter from f1 to f2, and wake f2.
 	 */
 	if (pthread_create(&waiter[0], NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
=20
 	usleep(WAKE_WAIT_US);
=20
-	info("Requeuing 1 futex from f1 to f2\n");
+	ksft_print_dbg_msg("Requeuing 1 futex from f1 to f2\n");
 	res =3D futex_cmp_requeue(f1, 0, &f2, 0, 1, 0);
-	if (res !=3D 1) {
+	if (res !=3D 1)
 		ksft_test_result_fail("futex_requeue simple returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
-	}
=20
-
-	info("Waking 1 futex at f2\n");
+	ksft_print_dbg_msg("Waking 1 futex at f2\n");
 	res =3D futex_wake(&f2, 1, 0);
 	if (res !=3D 1) {
 		ksft_test_result_fail("futex_requeue simple returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_requeue simple succeeds\n");
 	}
+}
+
+TEST(requeue_multiple)
+{
+	volatile futex_t _f1 =3D 0;
+	volatile futex_t f2 =3D 0;
+	pthread_t waiter[10];
+	int res, i;
=20
+	f1 =3D &_f1;
=20
 	/*
 	 * Create 10 waiters at f1. At futex_requeue, wake 3 and requeue 7.
@@ -106,31 +79,28 @@ int main(int argc, char *argv[])
 	 */
 	for (i =3D 0; i < 10; i++) {
 		if (pthread_create(&waiter[i], NULL, waiterfn, NULL))
-			error("pthread_create failed\n", errno);
+			ksft_exit_fail_msg("pthread_create failed\n");
 	}
=20
 	usleep(WAKE_WAIT_US);
=20
-	info("Waking 3 futexes at f1 and requeuing 7 futexes from f1 to f2\n");
+	ksft_print_dbg_msg("Waking 3 futexes at f1 and requeuing 7 futexes from f1 =
to f2\n");
 	res =3D futex_cmp_requeue(f1, 0, &f2, 3, 7, 0);
 	if (res !=3D 10) {
 		ksft_test_result_fail("futex_requeue many returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	}
=20
-	info("Waking INT_MAX futexes at f2\n");
+	ksft_print_dbg_msg("Waking INT_MAX futexes at f2\n");
 	res =3D futex_wake(&f2, INT_MAX, 0);
 	if (res !=3D 7) {
 		ksft_test_result_fail("futex_requeue many returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_requeue many succeeds\n");
 	}
-
-	ksft_print_cnts();
-	return ret;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/to=
ols/testing/selftests/futex/functional/futex_requeue_pi.c
index 215c6cb539b4..f299d75848cd 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -26,11 +26,11 @@
 #include <stdlib.h>
 #include <signal.h>
 #include <string.h>
+
 #include "atomic.h"
 #include "futextest.h"
-#include "logging.h"
+#include "../../kselftest_harness.h"
=20
-#define TEST_NAME "futex-requeue-pi"
 #define MAX_WAKE_ITERS 1000
 #define THREAD_MAX 10
 #define SIGNAL_PERIOD_US 100
@@ -42,12 +42,6 @@ futex_t f1 =3D FUTEX_INITIALIZER;
 futex_t f2 =3D FUTEX_INITIALIZER;
 futex_t wake_complete =3D FUTEX_INITIALIZER;
=20
-/* Test option defaults */
-static long timeout_ns;
-static int broadcast;
-static int owner;
-static int locked;
-
 struct thread_arg {
 	long id;
 	struct timespec *timeout;
@@ -56,18 +50,73 @@ struct thread_arg {
 };
 #define THREAD_ARG_INITIALIZER { 0, NULL, 0, 0 }
=20
-void usage(char *prog)
+FIXTURE(args)
 {
-	printf("Usage: %s\n", prog);
-	printf("  -b	Broadcast wakeup (all waiters)\n");
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -l	Lock the pi futex across requeue\n");
-	printf("  -o	Use a third party pi futex owner during requeue (cancels -l)\n=
");
-	printf("  -t N	Timeout in nanoseconds (default: 0)\n");
-	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
+};
+
+FIXTURE_SETUP(args)
+{
+};
+
+FIXTURE_TEARDOWN(args)
+{
+};
+
+FIXTURE_VARIANT(args)
+{
+	long timeout_ns;
+	bool broadcast;
+	bool owner;
+	bool locked;
+};
+
+/*
+ * For a given timeout value, this macro creates a test input with all the
+ * possible combinations of valid arguments
+ */
+#define FIXTURE_VARIANT_ADD_TIMEOUT(timeout)		\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout)			\
+{							\
+	.timeout_ns =3D timeout,				\
+};							\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout##_broadcast)	\
+{							\
+	.timeout_ns =3D timeout,				\
+	.broadcast =3D true,				\
+};							\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout##_broadcast_locked) \
+{							\
+	.timeout_ns =3D timeout,				\
+	.broadcast =3D true,				\
+	.locked =3D true,					\
+};							\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout##_broadcast_owner) \
+{							\
+	.timeout_ns =3D timeout,				\
+	.broadcast =3D true,				\
+	.owner =3D true,					\
+};							\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout##_locked)		\
+{							\
+	.timeout_ns =3D timeout,				\
+	.locked =3D true,					\
+};							\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout##_owner)		\
+{							\
+	.timeout_ns =3D timeout,				\
+	.owner =3D true,					\
+};							\
+
+FIXTURE_VARIANT_ADD_TIMEOUT(0);
+FIXTURE_VARIANT_ADD_TIMEOUT(5000);
+FIXTURE_VARIANT_ADD_TIMEOUT(500000);
+FIXTURE_VARIANT_ADD_TIMEOUT(2000000000);
=20
 int create_rt_thread(pthread_t *pth, void*(*func)(void *), void *arg,
 		     int policy, int prio)
@@ -81,26 +130,26 @@ int create_rt_thread(pthread_t *pth, void*(*func)(void *=
), void *arg,
=20
 	ret =3D pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
 	if (ret) {
-		error("pthread_attr_setinheritsched\n", ret);
+		ksft_exit_fail_msg("pthread_attr_setinheritsched\n");
 		return -1;
 	}
=20
 	ret =3D pthread_attr_setschedpolicy(&attr, policy);
 	if (ret) {
-		error("pthread_attr_setschedpolicy\n", ret);
+		ksft_exit_fail_msg("pthread_attr_setschedpolicy\n");
 		return -1;
 	}
=20
 	schedp.sched_priority =3D prio;
 	ret =3D pthread_attr_setschedparam(&attr, &schedp);
 	if (ret) {
-		error("pthread_attr_setschedparam\n", ret);
+		ksft_exit_fail_msg("pthread_attr_setschedparam\n");
 		return -1;
 	}
=20
 	ret =3D pthread_create(pth, &attr, func, arg);
 	if (ret) {
-		error("pthread_create\n", ret);
+		ksft_exit_fail_msg("pthread_create\n");
 		return -1;
 	}
 	return 0;
@@ -112,7 +161,7 @@ void *waiterfn(void *arg)
 	struct thread_arg *args =3D (struct thread_arg *)arg;
 	futex_t old_val;
=20
-	info("Waiter %ld: running\n", args->id);
+	ksft_print_dbg_msg("Waiter %ld: running\n", args->id);
 	/* Each thread sleeps for a different amount of time
 	 * This is to avoid races, because we don't lock the
 	 * external mutex here */
@@ -120,26 +169,25 @@ void *waiterfn(void *arg)
=20
 	old_val =3D f1;
 	atomic_inc(&waiters_blocked);
-	info("Calling futex_wait_requeue_pi: %p (%u) -> %p\n",
+	ksft_print_dbg_msg("Calling futex_wait_requeue_pi: %p (%u) -> %p\n",
 	     &f1, f1, &f2);
 	args->ret =3D futex_wait_requeue_pi(&f1, old_val, &f2, args->timeout,
 					  FUTEX_PRIVATE_FLAG);
=20
-	info("waiter %ld woke with %d %s\n", args->id, args->ret,
+	ksft_print_dbg_msg("waiter %ld woke with %d %s\n", args->id, args->ret,
 	     args->ret < 0 ? strerror(errno) : "");
 	atomic_inc(&waiters_woken);
 	if (args->ret < 0) {
 		if (args->timeout && errno =3D=3D ETIMEDOUT)
 			args->ret =3D 0;
 		else {
-			args->ret =3D RET_ERROR;
-			error("futex_wait_requeue_pi\n", errno);
+			ksft_exit_fail_msg("futex_wait_requeue_pi\n");
 		}
 		futex_lock_pi(&f2, NULL, 0, FUTEX_PRIVATE_FLAG);
 	}
 	futex_unlock_pi(&f2, FUTEX_PRIVATE_FLAG);
=20
-	info("Waiter %ld: exiting with %d\n", args->id, args->ret);
+	ksft_print_dbg_msg("Waiter %ld: exiting with %d\n", args->id, args->ret);
 	pthread_exit((void *)&args->ret);
 }
=20
@@ -152,14 +200,14 @@ void *broadcast_wakerfn(void *arg)
 	int nr_wake =3D 1;
 	int i =3D 0;
=20
-	info("Waker: waiting for waiters to block\n");
+	ksft_print_dbg_msg("Waker: waiting for waiters to block\n");
 	while (waiters_blocked.val < THREAD_MAX)
 		usleep(1000);
 	usleep(1000);
=20
-	info("Waker: Calling broadcast\n");
+	ksft_print_dbg_msg("Waker: Calling broadcast\n");
 	if (args->lock) {
-		info("Calling FUTEX_LOCK_PI on mutex=3D%x @ %p\n", f2, &f2);
+		ksft_print_dbg_msg("Calling FUTEX_LOCK_PI on mutex=3D%x @ %p\n", f2, &f2);
 		futex_lock_pi(&f2, NULL, 0, FUTEX_PRIVATE_FLAG);
 	}
  continue_requeue:
@@ -167,16 +215,14 @@ void *broadcast_wakerfn(void *arg)
 	args->ret =3D futex_cmp_requeue_pi(&f1, old_val, &f2, nr_wake, nr_requeue,
 				   FUTEX_PRIVATE_FLAG);
 	if (args->ret < 0) {
-		args->ret =3D RET_ERROR;
-		error("FUTEX_CMP_REQUEUE_PI failed\n", errno);
+		ksft_exit_fail_msg("FUTEX_CMP_REQUEUE_PI failed\n");
 	} else if (++i < MAX_WAKE_ITERS) {
 		task_count +=3D args->ret;
 		if (task_count < THREAD_MAX - waiters_woken.val)
 			goto continue_requeue;
 	} else {
-		error("max broadcast iterations (%d) reached with %d/%d tasks woken or req=
ueued\n",
-		       0, MAX_WAKE_ITERS, task_count, THREAD_MAX);
-		args->ret =3D RET_ERROR;
+		ksft_exit_fail_msg("max broadcast iterations (%d) reached with %d/%d tasks=
 woken or requeued\n",
+		       MAX_WAKE_ITERS, task_count, THREAD_MAX);
 	}
=20
 	futex_wake(&wake_complete, 1, FUTEX_PRIVATE_FLAG);
@@ -187,7 +233,7 @@ void *broadcast_wakerfn(void *arg)
 	if (args->ret > 0)
 		args->ret =3D task_count;
=20
-	info("Waker: exiting with %d\n", args->ret);
+	ksft_print_dbg_msg("Waker: exiting with %d\n", args->ret);
 	pthread_exit((void *)&args->ret);
 }
=20
@@ -200,20 +246,20 @@ void *signal_wakerfn(void *arg)
 	int nr_wake =3D 1;
 	int i =3D 0;
=20
-	info("Waker: waiting for waiters to block\n");
+	ksft_print_dbg_msg("Waker: waiting for waiters to block\n");
 	while (waiters_blocked.val < THREAD_MAX)
 		usleep(1000);
 	usleep(1000);
=20
 	while (task_count < THREAD_MAX && waiters_woken.val < THREAD_MAX) {
-		info("task_count: %d, waiters_woken: %d\n",
+		ksft_print_dbg_msg("task_count: %d, waiters_woken: %d\n",
 		     task_count, waiters_woken.val);
 		if (args->lock) {
-			info("Calling FUTEX_LOCK_PI on mutex=3D%x @ %p\n",
-			     f2, &f2);
+			ksft_print_dbg_msg("Calling FUTEX_LOCK_PI on mutex=3D%x @ %p\n",
+			    f2, &f2);
 			futex_lock_pi(&f2, NULL, 0, FUTEX_PRIVATE_FLAG);
 		}
-		info("Waker: Calling signal\n");
+		ksft_print_dbg_msg("Waker: Calling signal\n");
 		/* cond_signal */
 		old_val =3D f1;
 		args->ret =3D futex_cmp_requeue_pi(&f1, old_val, &f2,
@@ -221,28 +267,23 @@ void *signal_wakerfn(void *arg)
 						 FUTEX_PRIVATE_FLAG);
 		if (args->ret < 0)
 			args->ret =3D -errno;
-		info("futex: %x\n", f2);
+		ksft_print_dbg_msg("futex: %x\n", f2);
 		if (args->lock) {
-			info("Calling FUTEX_UNLOCK_PI on mutex=3D%x @ %p\n",
-			     f2, &f2);
+			ksft_print_dbg_msg("Calling FUTEX_UNLOCK_PI on mutex=3D%x @ %p\n",
+			    f2, &f2);
 			futex_unlock_pi(&f2, FUTEX_PRIVATE_FLAG);
 		}
-		info("futex: %x\n", f2);
-		if (args->ret < 0) {
-			error("FUTEX_CMP_REQUEUE_PI failed\n", errno);
-			args->ret =3D RET_ERROR;
-			break;
-		}
+		ksft_print_dbg_msg("futex: %x\n", f2);
+		if (args->ret < 0)
+			ksft_exit_fail_msg("FUTEX_CMP_REQUEUE_PI failed\n");
=20
 		task_count +=3D args->ret;
 		usleep(SIGNAL_PERIOD_US);
 		i++;
 		/* we have to loop at least THREAD_MAX times */
 		if (i > MAX_WAKE_ITERS + THREAD_MAX) {
-			error("max signaling iterations (%d) reached, giving up on pending waiter=
s.\n",
-			      0, MAX_WAKE_ITERS + THREAD_MAX);
-			args->ret =3D RET_ERROR;
-			break;
+			ksft_exit_fail_msg("max signaling iterations (%d) reached, giving up on p=
ending waiters.\n",
+			      MAX_WAKE_ITERS + THREAD_MAX);
 		}
 	}
=20
@@ -251,8 +292,8 @@ void *signal_wakerfn(void *arg)
 	if (args->ret >=3D 0)
 		args->ret =3D task_count;
=20
-	info("Waker: exiting with %d\n", args->ret);
-	info("Waker: waiters_woken: %d\n", waiters_woken.val);
+	ksft_print_dbg_msg("Waker: exiting with %d\n", args->ret);
+	ksft_print_dbg_msg("Waker: waiters_woken: %d\n", waiters_woken.val);
 	pthread_exit((void *)&args->ret);
 }
=20
@@ -269,35 +310,40 @@ void *third_party_blocker(void *arg)
 	ret2 =3D futex_unlock_pi(&f2, FUTEX_PRIVATE_FLAG);
=20
  out:
-	if (args->ret || ret2) {
-		error("third_party_blocker() futex error", 0);
-		args->ret =3D RET_ERROR;
-	}
+	if (args->ret || ret2)
+		ksft_exit_fail_msg("third_party_blocker() futex error");
=20
 	pthread_exit((void *)&args->ret);
 }
=20
-int unit_test(int broadcast, long lock, int third_party_owner, long timeout_=
ns)
+TEST_F(args, futex_requeue_pi)
 {
-	void *(*wakerfn)(void *) =3D signal_wakerfn;
 	struct thread_arg blocker_arg =3D THREAD_ARG_INITIALIZER;
 	struct thread_arg waker_arg =3D THREAD_ARG_INITIALIZER;
 	pthread_t waiter[THREAD_MAX], waker, blocker;
-	struct timespec ts, *tsp =3D NULL;
+	void *(*wakerfn)(void *) =3D signal_wakerfn;
+	bool third_party_owner =3D variant->owner;
+	long timeout_ns =3D variant->timeout_ns;
+	bool broadcast =3D variant->broadcast;
 	struct thread_arg args[THREAD_MAX];
-	int *waiter_ret;
-	int i, ret =3D RET_PASS;
+	struct timespec ts, *tsp =3D NULL;
+	bool lock =3D variant->locked;
+	int *waiter_ret, i, ret =3D 0;
+
+	ksft_print_msg(
+		"\tArguments: broadcast=3D%d locked=3D%d owner=3D%d timeout=3D%ldns\n",
+		broadcast, lock, third_party_owner, timeout_ns);
=20
 	if (timeout_ns) {
 		time_t secs;
=20
-		info("timeout_ns =3D %ld\n", timeout_ns);
+		ksft_print_dbg_msg("timeout_ns =3D %ld\n", timeout_ns);
 		ret =3D clock_gettime(CLOCK_MONOTONIC, &ts);
 		secs =3D (ts.tv_nsec + timeout_ns) / 1000000000;
 		ts.tv_nsec =3D ((int64_t)ts.tv_nsec + timeout_ns) % 1000000000;
 		ts.tv_sec +=3D secs;
-		info("ts.tv_sec  =3D %ld\n", ts.tv_sec);
-		info("ts.tv_nsec =3D %ld\n", ts.tv_nsec);
+		ksft_print_dbg_msg("ts.tv_sec  =3D %ld\n", ts.tv_sec);
+		ksft_print_dbg_msg("ts.tv_nsec =3D %ld\n", ts.tv_nsec);
 		tsp =3D &ts;
 	}
=20
@@ -307,10 +353,7 @@ int unit_test(int broadcast, long lock, int third_party_=
owner, long timeout_ns)
 	if (third_party_owner) {
 		if (create_rt_thread(&blocker, third_party_blocker,
 				     (void *)&blocker_arg, SCHED_FIFO, 1)) {
-			error("Creating third party blocker thread failed\n",
-			      errno);
-			ret =3D RET_ERROR;
-			goto out;
+			ksft_exit_fail_msg("Creating third party blocker thread failed\n");
 		}
 	}
=20
@@ -318,20 +361,16 @@ int unit_test(int broadcast, long lock, int third_party=
_owner, long timeout_ns)
 	for (i =3D 0; i < THREAD_MAX; i++) {
 		args[i].id =3D i;
 		args[i].timeout =3D tsp;
-		info("Starting thread %d\n", i);
+		ksft_print_dbg_msg("Starting thread %d\n", i);
 		if (create_rt_thread(&waiter[i], waiterfn, (void *)&args[i],
 				     SCHED_FIFO, 1)) {
-			error("Creating waiting thread failed\n", errno);
-			ret =3D RET_ERROR;
-			goto out;
+			ksft_exit_fail_msg("Creating waiting thread failed\n");
 		}
 	}
 	waker_arg.lock =3D lock;
 	if (create_rt_thread(&waker, wakerfn, (void *)&waker_arg,
 			     SCHED_FIFO, 1)) {
-		error("Creating waker thread failed\n", errno);
-		ret =3D RET_ERROR;
-		goto out;
+		ksft_exit_fail_msg("Creating waker thread failed\n");
 	}
=20
 	/* Wait for threads to finish */
@@ -345,7 +384,6 @@ int unit_test(int broadcast, long lock, int third_party_o=
wner, long timeout_ns)
 		pthread_join(blocker, NULL);
 	pthread_join(waker, NULL);
=20
-out:
 	if (!ret) {
 		if (*waiter_ret)
 			ret =3D *waiter_ret;
@@ -355,66 +393,8 @@ int unit_test(int broadcast, long lock, int third_party_=
owner, long timeout_ns)
 			ret =3D blocker_arg.ret;
 	}
=20
-	return ret;
+	if (ret)
+		ksft_test_result_fail("fail");
 }
=20
-int main(int argc, char *argv[])
-{
-	char *test_name;
-	int c, ret;
-
-	while ((c =3D getopt(argc, argv, "bchlot:v:")) !=3D -1) {
-		switch (c) {
-		case 'b':
-			broadcast =3D 1;
-			break;
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-		case 'l':
-			locked =3D 1;
-			break;
-		case 'o':
-			owner =3D 1;
-			locked =3D 0;
-			break;
-		case 't':
-			timeout_ns =3D atoi(optarg);
-			break;
-		case 'v':
-			log_verbosity(atoi(optarg));
-			break;
-		default:
-			usage(basename(argv[0]));
-			exit(1);
-		}
-	}
-
-	ksft_print_header();
-	ksft_set_plan(1);
-	ksft_print_msg("%s: Test requeue functionality\n", basename(argv[0]));
-	ksft_print_msg(
-		"\tArguments: broadcast=3D%d locked=3D%d owner=3D%d timeout=3D%ldns\n",
-		broadcast, locked, owner, timeout_ns);
-
-	ret =3D asprintf(&test_name,
-		       "%s broadcast=3D%d locked=3D%d owner=3D%d timeout=3D%ldns",
-		       TEST_NAME, broadcast, locked, owner, timeout_ns);
-	if (ret < 0) {
-		ksft_print_msg("Failed to generate test name\n");
-		test_name =3D TEST_NAME;
-	}
-
-	/*
-	 * FIXME: unit_test is obsolete now that we parse options and the
-	 * various style of runs are done by run.sh - simplify the code and move
-	 * unit_test into main()
-	 */
-	ret =3D unit_test(broadcast, locked, owner, timeout_ns);
-
-	print_result(test_name, ret);
-	return ret;
-}
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_mismat=
ched_ops.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_mismat=
ched_ops.c
index d0a4d332ea44..77135a22a583 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_op=
s.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_op=
s.c
@@ -23,67 +23,32 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include "futextest.h"
-#include "logging.h"
=20
-#define TEST_NAME "futex-requeue-pi-mismatched-ops"
+#include "futextest.h"
+#include "../../kselftest_harness.h"
=20
 futex_t f1 =3D FUTEX_INITIALIZER;
 futex_t f2 =3D FUTEX_INITIALIZER;
 int child_ret =3D 0;
=20
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 void *blocking_child(void *arg)
 {
 	child_ret =3D futex_wait(&f1, f1, NULL, FUTEX_PRIVATE_FLAG);
 	if (child_ret < 0) {
 		child_ret =3D -errno;
-		error("futex_wait\n", errno);
+		ksft_exit_fail_msg("futex_wait\n");
 	}
 	return (void *)&child_ret;
 }
=20
-int main(int argc, char *argv[])
+TEST(requeue_pi_mismatched_ops)
 {
-	int ret =3D RET_PASS;
 	pthread_t child;
-	int c;
+	int ret;
=20
-	while ((c =3D getopt(argc, argv, "chv:")) !=3D -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-		case 'v':
-			log_verbosity(atoi(optarg));
-			break;
-		default:
-			usage(basename(argv[0]));
-			exit(1);
-		}
-	}
-
-	ksft_print_header();
-	ksft_set_plan(1);
-	ksft_print_msg("%s: Detect mismatched requeue_pi operations\n",
-	       basename(argv[0]));
+	if (pthread_create(&child, NULL, blocking_child, NULL))
+		ksft_exit_fail_msg("pthread_create\n");
=20
-	if (pthread_create(&child, NULL, blocking_child, NULL)) {
-		error("pthread_create\n", errno);
-		ret =3D RET_ERROR;
-		goto out;
-	}
 	/* Allow the child to block in the kernel. */
 	sleep(1);
=20
@@ -102,34 +67,27 @@ int main(int argc, char *argv[])
 			 * FUTEX_WAKE.
 			 */
 			ret =3D futex_wake(&f1, 1, FUTEX_PRIVATE_FLAG);
-			if (ret =3D=3D 1) {
-				ret =3D RET_PASS;
-			} else if (ret < 0) {
-				error("futex_wake\n", errno);
-				ret =3D RET_ERROR;
-			} else {
-				error("futex_wake did not wake the child\n", 0);
-				ret =3D RET_ERROR;
-			}
+			if (ret =3D=3D 1)
+				ret =3D 0;
+			else if (ret < 0)
+				ksft_exit_fail_msg("futex_wake\n");
+			else
+				ksft_exit_fail_msg("futex_wake did not wake the child\n");
 		} else {
-			error("futex_cmp_requeue_pi\n", errno);
-			ret =3D RET_ERROR;
+			ksft_exit_fail_msg("futex_cmp_requeue_pi\n");
 		}
 	} else if (ret > 0) {
-		fail("futex_cmp_requeue_pi failed to detect the mismatch\n");
-		ret =3D RET_FAIL;
+		ksft_test_result_fail("futex_cmp_requeue_pi failed to detect the mismatch\=
n");
 	} else {
-		error("futex_cmp_requeue_pi found no waiters\n", 0);
-		ret =3D RET_ERROR;
+		ksft_exit_fail_msg("futex_cmp_requeue_pi found no waiters\n");
 	}
=20
 	pthread_join(child, NULL);
=20
-	if (!ret)
-		ret =3D child_ret;
-
- out:
-	/* If the kernel crashes, we shouldn't return at all. */
-	print_result(TEST_NAME, ret);
-	return ret;
+	if (!ret && !child_ret)
+		ksft_test_result_pass("futex_requeue_pi_mismatched_ops passed\n");
+	else
+		ksft_test_result_pass("futex_requeue_pi_mismatched_ops failed\n");
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal=
_restart.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal=
_restart.c
index c6b8f32990c8..e34ee0f9ebcc 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restar=
t.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restar=
t.c
@@ -24,11 +24,11 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+
 #include "atomic.h"
 #include "futextest.h"
-#include "logging.h"
+#include "../../kselftest_harness.h"
=20
-#define TEST_NAME "futex-requeue-pi-signal-restart"
 #define DELAY_US 100
=20
 futex_t f1 =3D FUTEX_INITIALIZER;
@@ -37,15 +37,6 @@ atomic_t requeued =3D ATOMIC_INITIALIZER;
=20
 int waiter_ret =3D 0;
=20
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 int create_rt_thread(pthread_t *pth, void*(*func)(void *), void *arg,
 		     int policy, int prio)
 {
@@ -57,35 +48,28 @@ int create_rt_thread(pthread_t *pth, void*(*func)(void *)=
, void *arg,
 	memset(&schedp, 0, sizeof(schedp));
=20
 	ret =3D pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
-	if (ret) {
-		error("pthread_attr_setinheritsched\n", ret);
-		return -1;
-	}
+	if (ret)
+		ksft_exit_fail_msg("pthread_attr_setinheritsched\n");
=20
 	ret =3D pthread_attr_setschedpolicy(&attr, policy);
-	if (ret) {
-		error("pthread_attr_setschedpolicy\n", ret);
-		return -1;
-	}
+	if (ret)
+		ksft_exit_fail_msg("pthread_attr_setschedpolicy\n");
=20
 	schedp.sched_priority =3D prio;
 	ret =3D pthread_attr_setschedparam(&attr, &schedp);
-	if (ret) {
-		error("pthread_attr_setschedparam\n", ret);
-		return -1;
-	}
+	if (ret)
+		ksft_exit_fail_msg("pthread_attr_setschedparam\n");
=20
 	ret =3D pthread_create(pth, &attr, func, arg);
-	if (ret) {
-		error("pthread_create\n", ret);
-		return -1;
-	}
+	if (ret)
+		ksft_exit_fail_msg("pthread_create\n");
+
 	return 0;
 }
=20
 void handle_signal(int signo)
 {
-	info("signal received %s requeue\n",
+	ksft_print_dbg_msg("signal received %s requeue\n",
 	     requeued.val ? "after" : "prior to");
 }
=20
@@ -94,78 +78,46 @@ void *waiterfn(void *arg)
 	unsigned int old_val;
 	int res;
=20
-	waiter_ret =3D RET_PASS;
-
-	info("Waiter running\n");
-	info("Calling FUTEX_LOCK_PI on f2=3D%x @ %p\n", f2, &f2);
+	ksft_print_dbg_msg("Waiter running\n");
+	ksft_print_dbg_msg("Calling FUTEX_LOCK_PI on f2=3D%x @ %p\n", f2, &f2);
 	old_val =3D f1;
 	res =3D futex_wait_requeue_pi(&f1, old_val, &(f2), NULL,
 				    FUTEX_PRIVATE_FLAG);
 	if (!requeued.val || errno !=3D EWOULDBLOCK) {
-		fail("unexpected return from futex_wait_requeue_pi: %d (%s)\n",
+		ksft_test_result_fail("unexpected return from futex_wait_requeue_pi: %d (%=
s)\n",
 		     res, strerror(errno));
-		info("w2:futex: %x\n", f2);
+		ksft_print_dbg_msg("w2:futex: %x\n", f2);
 		if (!res)
 			futex_unlock_pi(&f2, FUTEX_PRIVATE_FLAG);
-		waiter_ret =3D RET_FAIL;
 	}
=20
-	info("Waiter exiting with %d\n", waiter_ret);
 	pthread_exit(NULL);
 }
=20
=20
-int main(int argc, char *argv[])
+TEST(futex_requeue_pi_signal_restart)
 {
 	unsigned int old_val;
 	struct sigaction sa;
 	pthread_t waiter;
-	int c, res, ret =3D RET_PASS;
-
-	while ((c =3D getopt(argc, argv, "chv:")) !=3D -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-		case 'v':
-			log_verbosity(atoi(optarg));
-			break;
-		default:
-			usage(basename(argv[0]));
-			exit(1);
-		}
-	}
-
-	ksft_print_header();
-	ksft_set_plan(1);
-	ksft_print_msg("%s: Test signal handling during requeue_pi\n",
-	       basename(argv[0]));
-	ksft_print_msg("\tArguments: <none>\n");
+	int res;
=20
 	sa.sa_handler =3D handle_signal;
 	sigemptyset(&sa.sa_mask);
 	sa.sa_flags =3D 0;
-	if (sigaction(SIGUSR1, &sa, NULL)) {
-		error("sigaction\n", errno);
-		exit(1);
-	}
+	if (sigaction(SIGUSR1, &sa, NULL))
+		ksft_exit_fail_msg("sigaction\n");
=20
-	info("m1:f2: %x\n", f2);
-	info("Creating waiter\n");
+	ksft_print_dbg_msg("m1:f2: %x\n", f2);
+	ksft_print_dbg_msg("Creating waiter\n");
 	res =3D create_rt_thread(&waiter, waiterfn, NULL, SCHED_FIFO, 1);
-	if (res) {
-		error("Creating waiting thread failed", res);
-		ret =3D RET_ERROR;
-		goto out;
-	}
+	if (res)
+		ksft_exit_fail_msg("Creating waiting thread failed");
=20
-	info("Calling FUTEX_LOCK_PI on f2=3D%x @ %p\n", f2, &f2);
-	info("m2:f2: %x\n", f2);
+	ksft_print_dbg_msg("Calling FUTEX_LOCK_PI on f2=3D%x @ %p\n", f2, &f2);
+	ksft_print_dbg_msg("m2:f2: %x\n", f2);
 	futex_lock_pi(&f2, 0, 0, FUTEX_PRIVATE_FLAG);
-	info("m3:f2: %x\n", f2);
+	ksft_print_dbg_msg("m3:f2: %x\n", f2);
=20
 	while (1) {
 		/*
@@ -173,11 +125,11 @@ int main(int argc, char *argv[])
 		 * restart futex_wait_requeue_pi() in the kernel. Wait for the
 		 * waiter to block on f1 again.
 		 */
-		info("Issuing SIGUSR1 to waiter\n");
+		ksft_print_dbg_msg("Issuing SIGUSR1 to waiter\n");
 		pthread_kill(waiter, SIGUSR1);
 		usleep(DELAY_US);
=20
-		info("Requeueing waiter via FUTEX_CMP_REQUEUE_PI\n");
+		ksft_print_dbg_msg("Requeueing waiter via FUTEX_CMP_REQUEUE_PI\n");
 		old_val =3D f1;
 		res =3D futex_cmp_requeue_pi(&f1, old_val, &(f2), 1, 0,
 					   FUTEX_PRIVATE_FLAG);
@@ -191,12 +143,10 @@ int main(int argc, char *argv[])
 			atomic_set(&requeued, 1);
 			break;
 		} else if (res < 0) {
-			error("FUTEX_CMP_REQUEUE_PI failed\n", errno);
-			ret =3D RET_ERROR;
-			break;
+			ksft_exit_fail_msg("FUTEX_CMP_REQUEUE_PI failed\n");
 		}
 	}
-	info("m4:f2: %x\n", f2);
+	ksft_print_dbg_msg("m4:f2: %x\n", f2);
=20
 	/*
 	 * Signal the waiter after requeue, waiter should return from
@@ -204,19 +154,14 @@ int main(int argc, char *argv[])
 	 * futex_unlock_pi() can't happen before the signal wakeup is detected
 	 * in the kernel.
 	 */
-	info("Issuing SIGUSR1 to waiter\n");
+	ksft_print_dbg_msg("Issuing SIGUSR1 to waiter\n");
 	pthread_kill(waiter, SIGUSR1);
-	info("Waiting for waiter to return\n");
+	ksft_print_dbg_msg("Waiting for waiter to return\n");
 	pthread_join(waiter, NULL);
=20
-	info("Calling FUTEX_UNLOCK_PI on mutex=3D%x @ %p\n", f2, &f2);
+	ksft_print_dbg_msg("Calling FUTEX_UNLOCK_PI on mutex=3D%x @ %p\n", f2, &f2);
 	futex_unlock_pi(&f2, FUTEX_PRIVATE_FLAG);
-	info("m5:f2: %x\n", f2);
-
- out:
-	if (ret =3D=3D RET_PASS && waiter_ret)
-		ret =3D waiter_ret;
-
-	print_result(TEST_NAME, ret);
-	return ret;
+	ksft_print_dbg_msg("m5:f2: %x\n", f2);
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tools/te=
sting/selftests/futex/functional/futex_wait.c
index 685140d9b93d..152ca4612886 100644
--- a/tools/testing/selftests/futex/functional/futex_wait.c
+++ b/tools/testing/selftests/futex/functional/futex_wait.c
@@ -9,25 +9,16 @@
 #include <sys/shm.h>
 #include <sys/mman.h>
 #include <fcntl.h>
-#include "logging.h"
+
 #include "futextest.h"
+#include "../../kselftest_harness.h"
=20
-#define TEST_NAME "futex-wait"
 #define timeout_ns  30000000
 #define WAKE_WAIT_US 10000
 #define SHM_PATH "futex_shm_file"
=20
 void *futex;
=20
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 static void *waiterfn(void *arg)
 {
 	struct timespec to;
@@ -45,53 +36,37 @@ static void *waiterfn(void *arg)
 	return NULL;
 }
=20
-int main(int argc, char *argv[])
+TEST(private_futex)
 {
-	int res, ret =3D RET_PASS, fd, c, shm_id;
-	u_int32_t f_private =3D 0, *shared_data;
 	unsigned int flags =3D FUTEX_PRIVATE_FLAG;
+	u_int32_t f_private =3D 0;
 	pthread_t waiter;
-	void *shm;
+	int res;
=20
 	futex =3D &f_private;
=20
-	while ((c =3D getopt(argc, argv, "cht:v:")) !=3D -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-		case 'v':
-			log_verbosity(atoi(optarg));
-			break;
-		default:
-			usage(basename(argv[0]));
-			exit(1);
-		}
-	}
-
-	ksft_print_header();
-	ksft_set_plan(3);
-	ksft_print_msg("%s: Test futex_wait\n", basename(argv[0]));
-
 	/* Testing a private futex */
-	info("Calling private futex_wait on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling private futex_wait on futex: %p\n", futex);
 	if (pthread_create(&waiter, NULL, waiterfn, (void *) &flags))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
=20
 	usleep(WAKE_WAIT_US);
=20
-	info("Calling private futex_wake on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling private futex_wake on futex: %p\n", futex);
 	res =3D futex_wake(futex, 1, FUTEX_PRIVATE_FLAG);
 	if (res !=3D 1) {
 		ksft_test_result_fail("futex_wake private returned: %d %s\n",
 				      errno, strerror(errno));
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_wake private succeeds\n");
 	}
+}
+
+TEST(anon_page)
+{
+	u_int32_t *shared_data;
+	pthread_t waiter;
+	int res, shm_id;
=20
 	/* Testing an anon page shared memory */
 	shm_id =3D shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
@@ -105,67 +80,65 @@ int main(int argc, char *argv[])
 	*shared_data =3D 0;
 	futex =3D shared_data;
=20
-	info("Calling shared (page anon) futex_wait on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling shared (page anon) futex_wait on futex: %p\n", =
futex);
 	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
=20
 	usleep(WAKE_WAIT_US);
=20
-	info("Calling shared (page anon) futex_wake on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling shared (page anon) futex_wake on futex: %p\n", =
futex);
 	res =3D futex_wake(futex, 1, 0);
 	if (res !=3D 1) {
 		ksft_test_result_fail("futex_wake shared (page anon) returned: %d %s\n",
 				      errno, strerror(errno));
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_wake shared (page anon) succeeds\n");
 	}
=20
+	shmdt(shared_data);
+}
+
+TEST(file_backed)
+{
+	u_int32_t f_private =3D 0;
+	pthread_t waiter;
+	int res, fd;
+	void *shm;
=20
 	/* Testing a file backed shared memory */
 	fd =3D open(SHM_PATH, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
-	if (fd < 0) {
-		perror("open");
-		exit(1);
-	}
+	if (fd < 0)
+		ksft_exit_fail_msg("open");
=20
-	if (ftruncate(fd, sizeof(f_private))) {
-		perror("ftruncate");
-		exit(1);
-	}
+	if (ftruncate(fd, sizeof(f_private)))
+		ksft_exit_fail_msg("ftruncate");
=20
 	shm =3D mmap(NULL, sizeof(f_private), PROT_READ | PROT_WRITE, MAP_SHARED, f=
d, 0);
-	if (shm =3D=3D MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (shm =3D=3D MAP_FAILED)
+		ksft_exit_fail_msg("mmap");
=20
 	memcpy(shm, &f_private, sizeof(f_private));
=20
 	futex =3D shm;
=20
-	info("Calling shared (file backed) futex_wait on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling shared (file backed) futex_wait on futex: %p\n"=
, futex);
 	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
=20
 	usleep(WAKE_WAIT_US);
=20
-	info("Calling shared (file backed) futex_wake on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling shared (file backed) futex_wake on futex: %p\n"=
, futex);
 	res =3D futex_wake(shm, 1, 0);
 	if (res !=3D 1) {
 		ksft_test_result_fail("futex_wake shared (file backed) returned: %d %s\n",
 				      errno, strerror(errno));
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_wake shared (file backed) succeeds\n");
 	}
=20
-	/* Freeing resources */
-	shmdt(shared_data);
 	munmap(shm, sizeof(f_private));
 	remove(SHM_PATH);
 	close(fd);
-
-	ksft_print_cnts();
-	return ret;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/futex_wait_private_mapp=
ed_file.c b/tools/testing/selftests/futex/functional/futex_wait_private_mappe=
d_file.c
index fb4148f23fa3..8952ebda14ab 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file=
.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file=
.c
@@ -27,10 +27,9 @@
 #include <libgen.h>
 #include <signal.h>
=20
-#include "logging.h"
 #include "futextest.h"
+#include "../../kselftest_harness.h"
=20
-#define TEST_NAME "futex-wait-private-mapped-file"
 #define PAGE_SZ 4096
=20
 char pad[PAGE_SZ] =3D {1};
@@ -40,86 +39,44 @@ char pad2[PAGE_SZ] =3D {1};
 #define WAKE_WAIT_US 3000000
 struct timespec wait_timeout =3D { .tv_sec =3D 5, .tv_nsec =3D 0};
=20
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 void *thr_futex_wait(void *arg)
 {
 	int ret;
=20
-	info("futex wait\n");
+	ksft_print_dbg_msg("futex wait\n");
 	ret =3D futex_wait(&val, 1, &wait_timeout, 0);
-	if (ret && errno !=3D EWOULDBLOCK && errno !=3D ETIMEDOUT) {
-		error("futex error.\n", errno);
-		print_result(TEST_NAME, RET_ERROR);
-		exit(RET_ERROR);
-	}
+	if (ret && errno !=3D EWOULDBLOCK && errno !=3D ETIMEDOUT)
+		ksft_exit_fail_msg("futex error.\n");
=20
 	if (ret && errno =3D=3D ETIMEDOUT)
-		fail("waiter timedout\n");
+		ksft_exit_fail_msg("waiter timedout\n");
=20
-	info("futex_wait: ret =3D %d, errno =3D %d\n", ret, errno);
+	ksft_print_dbg_msg("futex_wait: ret =3D %d, errno =3D %d\n", ret, errno);
=20
 	return NULL;
 }
=20
-int main(int argc, char **argv)
+TEST(wait_private_mapped_file)
 {
 	pthread_t thr;
-	int ret =3D RET_PASS;
 	int res;
-	int c;
-
-	while ((c =3D getopt(argc, argv, "chv:")) !=3D -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-		case 'v':
-			log_verbosity(atoi(optarg));
-			break;
-		default:
-			usage(basename(argv[0]));
-			exit(1);
-		}
-	}
-
-	ksft_print_header();
-	ksft_set_plan(1);
-	ksft_print_msg(
-		"%s: Test the futex value of private file mappings in FUTEX_WAIT\n",
-		basename(argv[0]));
-
-	ret =3D pthread_create(&thr, NULL, thr_futex_wait, NULL);
-	if (ret < 0) {
-		fprintf(stderr, "pthread_create error\n");
-		ret =3D RET_ERROR;
-		goto out;
-	}
-
-	info("wait a while\n");
+
+	res =3D pthread_create(&thr, NULL, thr_futex_wait, NULL);
+	if (res < 0)
+		ksft_exit_fail_msg("pthread_create error\n");
+
+	ksft_print_dbg_msg("wait a while\n");
 	usleep(WAKE_WAIT_US);
 	val =3D 2;
 	res =3D futex_wake(&val, 1, 0);
-	info("futex_wake %d\n", res);
-	if (res !=3D 1) {
-		fail("FUTEX_WAKE didn't find the waiting thread.\n");
-		ret =3D RET_FAIL;
-	}
+	ksft_print_dbg_msg("futex_wake %d\n", res);
+	if (res !=3D 1)
+		ksft_exit_fail_msg("FUTEX_WAKE didn't find the waiting thread.\n");
=20
-	info("join\n");
+	ksft_print_dbg_msg("join\n");
 	pthread_join(thr, NULL);
=20
- out:
-	print_result(TEST_NAME, ret);
-	return ret;
+	ksft_test_result_pass("wait_private_mapped_file");
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/=
tools/testing/selftests/futex/functional/futex_wait_timeout.c
index d183f878360b..0c8766aced2e 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -16,26 +16,15 @@
  ***************************************************************************=
**/
=20
 #include <pthread.h>
+
 #include "futextest.h"
 #include "futex2test.h"
-#include "logging.h"
-
-#define TEST_NAME "futex-wait-timeout"
+#include "../../kselftest_harness.h"
=20
 static long timeout_ns =3D 100000;	/* 100us default timeout */
 static futex_t futex_pi;
 static pthread_barrier_t barrier;
=20
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -t N	Timeout in nanoseconds (default: 100,000)\n");
-	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 /*
  * Get a PI lock and hold it forever, so the main thread lock_pi will block
  * and we can test the timeout
@@ -47,13 +36,13 @@ void *get_pi_lock(void *arg)
=20
 	ret =3D futex_lock_pi(&futex_pi, NULL, 0, 0);
 	if (ret !=3D 0)
-		error("futex_lock_pi failed\n", ret);
+		ksft_exit_fail_msg("futex_lock_pi failed\n");
=20
 	pthread_barrier_wait(&barrier);
=20
 	/* Blocks forever */
 	ret =3D futex_wait(&lock, 0, NULL, 0);
-	error("futex_wait failed\n", ret);
+	ksft_exit_fail_msg("futex_wait failed\n");
=20
 	return NULL;
 }
@@ -61,12 +50,11 @@ void *get_pi_lock(void *arg)
 /*
  * Check if the function returned the expected error
  */
-static void test_timeout(int res, int *ret, char *test_name, int err)
+static void test_timeout(int res, char *test_name, int err)
 {
 	if (!res || errno !=3D err) {
 		ksft_test_result_fail("%s returned %d\n", test_name,
 				      res < 0 ? errno : res);
-		*ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("%s succeeds\n", test_name);
 	}
@@ -78,10 +66,8 @@ static void test_timeout(int res, int *ret, char *test_nam=
e, int err)
 static int futex_get_abs_timeout(clockid_t clockid, struct timespec *to,
 				 long timeout_ns)
 {
-	if (clock_gettime(clockid, to)) {
-		error("clock_gettime failed\n", errno);
-		return errno;
-	}
+	if (clock_gettime(clockid, to))
+		ksft_exit_fail_msg("clock_gettime failed\n");
=20
 	to->tv_nsec +=3D timeout_ns;
=20
@@ -93,83 +79,66 @@ static int futex_get_abs_timeout(clockid_t clockid, struc=
t timespec *to,
 	return 0;
 }
=20
-int main(int argc, char *argv[])
+TEST(wait_bitset)
 {
 	futex_t f1 =3D FUTEX_INITIALIZER;
-	int res, ret =3D RET_PASS;
 	struct timespec to;
-	pthread_t thread;
-	int c;
-	struct futex_waitv waitv =3D {
-			.uaddr =3D (uintptr_t)&f1,
-			.val =3D f1,
-			.flags =3D FUTEX_32,
-			.__reserved =3D 0
-		};
-
-	while ((c =3D getopt(argc, argv, "cht:v:")) !=3D -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-		case 't':
-			timeout_ns =3D atoi(optarg);
-			break;
-		case 'v':
-			log_verbosity(atoi(optarg));
-			break;
-		default:
-			usage(basename(argv[0]));
-			exit(1);
-		}
-	}
-
-	ksft_print_header();
-	ksft_set_plan(9);
-	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
-	       basename(argv[0]));
-	ksft_print_msg("\tArguments: timeout=3D%ldns\n", timeout_ns);
-
-	pthread_barrier_init(&barrier, NULL, 2);
-	pthread_create(&thread, NULL, get_pi_lock, NULL);
+	int res;
=20
 	/* initialize relative timeout */
 	to.tv_sec =3D 0;
 	to.tv_nsec =3D timeout_ns;
=20
 	res =3D futex_wait(&f1, f1, &to, 0);
-	test_timeout(res, &ret, "futex_wait relative", ETIMEDOUT);
+	test_timeout(res, "futex_wait relative", ETIMEDOUT);
=20
 	/* FUTEX_WAIT_BITSET with CLOCK_REALTIME */
 	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res =3D futex_wait_bitset(&f1, f1, &to, 1, FUTEX_CLOCK_REALTIME);
-	test_timeout(res, &ret, "futex_wait_bitset realtime", ETIMEDOUT);
+	test_timeout(res, "futex_wait_bitset realtime", ETIMEDOUT);
=20
 	/* FUTEX_WAIT_BITSET with CLOCK_MONOTONIC */
 	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res =3D futex_wait_bitset(&f1, f1, &to, 1, 0);
-	test_timeout(res, &ret, "futex_wait_bitset monotonic", ETIMEDOUT);
+	test_timeout(res, "futex_wait_bitset monotonic", ETIMEDOUT);
+}
+
+TEST(requeue_pi)
+{
+	futex_t f1 =3D FUTEX_INITIALIZER;
+	struct timespec to;
+	int res;
=20
 	/* FUTEX_WAIT_REQUEUE_PI with CLOCK_REALTIME */
 	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res =3D futex_wait_requeue_pi(&f1, f1, &futex_pi, &to, FUTEX_CLOCK_REALTIME=
);
-	test_timeout(res, &ret, "futex_wait_requeue_pi realtime", ETIMEDOUT);
+	test_timeout(res, "futex_wait_requeue_pi realtime", ETIMEDOUT);
=20
 	/* FUTEX_WAIT_REQUEUE_PI with CLOCK_MONOTONIC */
 	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res =3D futex_wait_requeue_pi(&f1, f1, &futex_pi, &to, 0);
-	test_timeout(res, &ret, "futex_wait_requeue_pi monotonic", ETIMEDOUT);
+	test_timeout(res, "futex_wait_requeue_pi monotonic", ETIMEDOUT);
+
+}
+
+TEST(lock_pi)
+{
+	struct timespec to;
+	pthread_t thread;
+	int res;
+
+	/* Create a thread that will lock forever so any waiter will timeout */
+	pthread_barrier_init(&barrier, NULL, 2);
+	pthread_create(&thread, NULL, get_pi_lock, NULL);
=20
 	/* Wait until the other thread calls futex_lock_pi() */
 	pthread_barrier_wait(&barrier);
 	pthread_barrier_destroy(&barrier);
+
 	/*
 	 * FUTEX_LOCK_PI with CLOCK_REALTIME
 	 * Due to historical reasons, FUTEX_LOCK_PI supports only realtime
@@ -181,26 +150,38 @@ int main(int argc, char *argv[])
 	 * smaller than realtime and the syscall will timeout immediately.
 	 */
 	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res =3D futex_lock_pi(&futex_pi, &to, 0, 0);
-	test_timeout(res, &ret, "futex_lock_pi realtime", ETIMEDOUT);
+	test_timeout(res, "futex_lock_pi realtime", ETIMEDOUT);
=20
 	/* Test operations that don't support FUTEX_CLOCK_REALTIME */
 	res =3D futex_lock_pi(&futex_pi, NULL, 0, FUTEX_CLOCK_REALTIME);
-	test_timeout(res, &ret, "futex_lock_pi invalid timeout flag", ENOSYS);
+	test_timeout(res, "futex_lock_pi invalid timeout flag", ENOSYS);
+}
+
+TEST(waitv)
+{
+	futex_t f1 =3D FUTEX_INITIALIZER;
+	struct futex_waitv waitv =3D {
+		.uaddr		=3D (uintptr_t)&f1,
+		.val		=3D f1,
+		.flags		=3D FUTEX_32,
+		.__reserved	=3D 0,
+	};
+	struct timespec to;
+	int res;
=20
 	/* futex_waitv with CLOCK_MONOTONIC */
 	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res =3D futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
-	test_timeout(res, &ret, "futex_waitv monotonic", ETIMEDOUT);
+	test_timeout(res, "futex_waitv monotonic", ETIMEDOUT);
=20
 	/* futex_waitv with CLOCK_REALTIME */
 	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res =3D futex_waitv(&waitv, 1, 0, &to, CLOCK_REALTIME);
-	test_timeout(res, &ret, "futex_waitv realtime", ETIMEDOUT);
-
-	ksft_print_cnts();
-	return ret;
+	test_timeout(res, "futex_waitv realtime", ETIMEDOUT);
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/futex_wait_uninitialize=
d_heap.c b/tools/testing/selftests/futex/functional/futex_wait_uninitialized_=
heap.c
index ed9cd07e31c1..ce2301500d83 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
@@ -29,95 +29,55 @@
 #include <linux/futex.h>
 #include <libgen.h>
=20
-#include "logging.h"
 #include "futextest.h"
+#include "../../kselftest_harness.h"
=20
-#define TEST_NAME "futex-wait-uninitialized-heap"
 #define WAIT_US 5000000
=20
 static int child_blocked =3D 1;
-static int child_ret;
+static bool child_ret;
 void *buf;
=20
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 void *wait_thread(void *arg)
 {
 	int res;
=20
-	child_ret =3D RET_PASS;
+	child_ret =3D true;
 	res =3D futex_wait(buf, 1, NULL, 0);
 	child_blocked =3D 0;
=20
 	if (res !=3D 0 && errno !=3D EWOULDBLOCK) {
-		error("futex failure\n", errno);
-		child_ret =3D RET_ERROR;
+		ksft_exit_fail_msg("futex failure\n");
+		child_ret =3D false;
 	}
 	pthread_exit(NULL);
 }
=20
-int main(int argc, char **argv)
+TEST(futex_wait_uninitialized_heap)
 {
-	int c, ret =3D RET_PASS;
 	long page_size;
 	pthread_t thr;
-
-	while ((c =3D getopt(argc, argv, "chv:")) !=3D -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-		case 'v':
-			log_verbosity(atoi(optarg));
-			break;
-		default:
-			usage(basename(argv[0]));
-			exit(1);
-		}
-	}
+	int ret;
=20
 	page_size =3D sysconf(_SC_PAGESIZE);
=20
 	buf =3D mmap(NULL, page_size, PROT_READ|PROT_WRITE,
 		   MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
-	if (buf =3D=3D (void *)-1) {
-		error("mmap\n", errno);
-		exit(1);
-	}
-
-	ksft_print_header();
-	ksft_set_plan(1);
-	ksft_print_msg("%s: Test the uninitialized futex value in FUTEX_WAIT\n",
-	       basename(argv[0]));
-
+	if (buf =3D=3D (void *)-1)
+		ksft_exit_fail_msg("mmap\n");
=20
 	ret =3D pthread_create(&thr, NULL, wait_thread, NULL);
-	if (ret) {
-		error("pthread_create\n", errno);
-		ret =3D RET_ERROR;
-		goto out;
-	}
+	if (ret)
+		ksft_exit_fail_msg("pthread_create\n");
=20
-	info("waiting %dus for child to return\n", WAIT_US);
+	ksft_print_dbg_msg("waiting %dus for child to return\n", WAIT_US);
 	usleep(WAIT_US);
=20
-	ret =3D child_ret;
-	if (child_blocked) {
-		fail("child blocked in kernel\n");
-		ret =3D RET_FAIL;
-	}
+	if (child_blocked)
+		ksft_test_result_fail("child blocked in kernel\n");
=20
- out:
-	print_result(TEST_NAME, ret);
-	return ret;
+	if (!child_ret)
+		ksft_test_result_fail("child error\n");
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c=
 b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index 2d8230da9064..36b7a54a4085 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -21,72 +21,44 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
+
 #include "futextest.h"
 #include "futex2test.h"
-#include "logging.h"
+#include "../../kselftest_harness.h"
=20
-#define TEST_NAME "futex-wait-wouldblock"
 #define timeout_ns 100000
=20
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
-int main(int argc, char *argv[])
+TEST(futex_wait_wouldblock)
 {
 	struct timespec to =3D {.tv_sec =3D 0, .tv_nsec =3D timeout_ns};
 	futex_t f1 =3D FUTEX_INITIALIZER;
-	int res, ret =3D RET_PASS;
-	int c;
-	struct futex_waitv waitv =3D {
-			.uaddr =3D (uintptr_t)&f1,
-			.val =3D f1+1,
-			.flags =3D FUTEX_32,
-			.__reserved =3D 0
-		};
+	int res;
=20
-	while ((c =3D getopt(argc, argv, "cht:v:")) !=3D -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-		case 'v':
-			log_verbosity(atoi(optarg));
-			break;
-		default:
-			usage(basename(argv[0]));
-			exit(1);
-		}
-	}
-
-	ksft_print_header();
-	ksft_set_plan(2);
-	ksft_print_msg("%s: Test the unexpected futex value in FUTEX_WAIT\n",
-	       basename(argv[0]));
-
-	info("Calling futex_wait on f1: %u @ %p with val=3D%u\n", f1, &f1, f1+1);
+	ksft_print_dbg_msg("Calling futex_wait on f1: %u @ %p with val=3D%u\n", f1,=
 &f1, f1+1);
 	res =3D futex_wait(&f1, f1+1, &to, FUTEX_PRIVATE_FLAG);
 	if (!res || errno !=3D EWOULDBLOCK) {
 		ksft_test_result_fail("futex_wait returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_wait\n");
 	}
+}
=20
-	if (clock_gettime(CLOCK_MONOTONIC, &to)) {
-		error("clock_gettime failed\n", errno);
-		return errno;
-	}
+TEST(futex_waitv_wouldblock)
+{
+	struct timespec to =3D {.tv_sec =3D 0, .tv_nsec =3D timeout_ns};
+	futex_t f1 =3D FUTEX_INITIALIZER;
+	struct futex_waitv waitv =3D {
+		.uaddr		=3D (uintptr_t)&f1,
+		.val		=3D f1 + 1,
+		.flags		=3D FUTEX_32,
+		.__reserved	=3D 0,
+	};
+	int res;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		ksft_exit_fail_msg("clock_gettime failed %d\n", errno);
=20
 	to.tv_nsec +=3D timeout_ns;
=20
@@ -95,17 +67,15 @@ int main(int argc, char *argv[])
 		to.tv_nsec -=3D 1000000000;
 	}
=20
-	info("Calling futex_waitv on f1: %u @ %p with val=3D%u\n", f1, &f1, f1+1);
+	ksft_print_dbg_msg("Calling futex_waitv on f1: %u @ %p with val=3D%u\n", f1=
, &f1, f1+1);
 	res =3D futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
 	if (!res || errno !=3D EWOULDBLOCK) {
 		ksft_test_result_fail("futex_waitv returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv\n");
 	}
-
-	ksft_print_cnts();
-	return ret;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/t=
esting/selftests/futex/functional/futex_waitv.c
index a94337f677e1..c684b10eb76e 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -15,25 +15,16 @@
 #include <pthread.h>
 #include <stdint.h>
 #include <sys/shm.h>
+
 #include "futextest.h"
 #include "futex2test.h"
-#include "logging.h"
+#include "../../kselftest_harness.h"
=20
-#define TEST_NAME "futex-wait"
 #define WAKE_WAIT_US 10000
 #define NR_FUTEXES 30
 static struct futex_waitv waitv[NR_FUTEXES];
 u_int32_t futexes[NR_FUTEXES] =3D {0};
=20
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 void *waiterfn(void *arg)
 {
 	struct timespec to;
@@ -41,7 +32,7 @@ void *waiterfn(void *arg)
=20
 	/* setting absolute timeout for futex2 */
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
=20
 	to.tv_sec++;
=20
@@ -57,34 +48,10 @@ void *waiterfn(void *arg)
 	return NULL;
 }
=20
-int main(int argc, char *argv[])
+TEST(private_waitv)
 {
 	pthread_t waiter;
-	int res, ret =3D RET_PASS;
-	struct timespec to;
-	int c, i;
-
-	while ((c =3D getopt(argc, argv, "cht:v:")) !=3D -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-		case 'v':
-			log_verbosity(atoi(optarg));
-			break;
-		default:
-			usage(basename(argv[0]));
-			exit(1);
-		}
-	}
-
-	ksft_print_header();
-	ksft_set_plan(7);
-	ksft_print_msg("%s: Test FUTEX_WAITV\n",
-		       basename(argv[0]));
+	int res, i;
=20
 	for (i =3D 0; i < NR_FUTEXES; i++) {
 		waitv[i].uaddr =3D (uintptr_t)&futexes[i];
@@ -95,7 +62,7 @@ int main(int argc, char *argv[])
=20
 	/* Private waitv */
 	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
=20
 	usleep(WAKE_WAIT_US);
=20
@@ -104,10 +71,15 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_wake private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv private\n");
 	}
+}
+
+TEST(shared_waitv)
+{
+	pthread_t waiter;
+	int res, i;
=20
 	/* Shared waitv */
 	for (i =3D 0; i < NR_FUTEXES; i++) {
@@ -128,7 +100,7 @@ int main(int argc, char *argv[])
 	}
=20
 	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
=20
 	usleep(WAKE_WAIT_US);
=20
@@ -137,19 +109,24 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_wake shared returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv shared\n");
 	}
=20
 	for (i =3D 0; i < NR_FUTEXES; i++)
 		shmdt(u64_to_ptr(waitv[i].uaddr));
+}
+
+TEST(invalid_flag)
+{
+	struct timespec to;
+	int res;
=20
 	/* Testing a waiter without FUTEX_32 flag */
 	waitv[0].flags =3D FUTEX_PRIVATE_FLAG;
=20
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
=20
 	to.tv_sec++;
=20
@@ -158,17 +135,22 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv without FUTEX_32\n");
 	}
+}
+
+TEST(unaligned_address)
+{
+	struct timespec to;
+	int res;
=20
 	/* Testing a waiter with an unaligned address */
 	waitv[0].flags =3D FUTEX_PRIVATE_FLAG | FUTEX_32;
 	waitv[0].uaddr =3D 1;
=20
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
=20
 	to.tv_sec++;
=20
@@ -177,16 +159,21 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_wake private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv with an unaligned address\n");
 	}
+}
+
+TEST(null_address)
+{
+	struct timespec to;
+	int res;
=20
 	/* Testing a NULL address for waiters.uaddr */
 	waitv[0].uaddr =3D 0x00000000;
=20
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
=20
 	to.tv_sec++;
=20
@@ -195,14 +182,13 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv NULL address in waitv.uaddr\n");
 	}
=20
 	/* Testing a NULL address for *waiters */
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
=20
 	to.tv_sec++;
=20
@@ -211,14 +197,19 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv NULL address in *waiters\n");
 	}
+}
+
+TEST(invalid_clockid)
+{
+	struct timespec to;
+	int res;
=20
 	/* Testing an invalid clockid */
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
=20
 	to.tv_sec++;
=20
@@ -227,11 +218,9 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv invalid clockid\n");
 	}
-
-	ksft_print_cnts();
-	return ret;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index 81739849f299..e88545c06d57 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -18,74 +18,36 @@
 #
 ############################################################################=
###
=20
-# Test for a color capable console
-if [ -z "$USE_COLOR" ]; then
-    tput setf 7 || tput setaf 7
-    if [ $? -eq 0 ]; then
-        USE_COLOR=3D1
-        tput sgr0
-    fi
-fi
-if [ "$USE_COLOR" -eq 1 ]; then
-    COLOR=3D"-c"
-fi
-
-
 echo
-# requeue pi testing
-# without timeouts
-./futex_requeue_pi $COLOR
-./futex_requeue_pi $COLOR -b
-./futex_requeue_pi $COLOR -b -l
-./futex_requeue_pi $COLOR -b -o
-./futex_requeue_pi $COLOR -l
-./futex_requeue_pi $COLOR -o
-# with timeouts
-./futex_requeue_pi $COLOR -b -l -t 5000
-./futex_requeue_pi $COLOR -l -t 5000
-./futex_requeue_pi $COLOR -b -l -t 500000
-./futex_requeue_pi $COLOR -l -t 500000
-./futex_requeue_pi $COLOR -b -t 5000
-./futex_requeue_pi $COLOR -t 5000
-./futex_requeue_pi $COLOR -b -t 500000
-./futex_requeue_pi $COLOR -t 500000
-./futex_requeue_pi $COLOR -b -o -t 5000
-./futex_requeue_pi $COLOR -l -t 5000
-./futex_requeue_pi $COLOR -b -o -t 500000
-./futex_requeue_pi $COLOR -l -t 500000
-# with long timeout
-./futex_requeue_pi $COLOR -b -l -t 2000000000
-./futex_requeue_pi $COLOR -l -t 2000000000
-
+./futex_requeue_pi
=20
 echo
-./futex_requeue_pi_mismatched_ops $COLOR
+./futex_requeue_pi_mismatched_ops
=20
 echo
-./futex_requeue_pi_signal_restart $COLOR
+./futex_requeue_pi_signal_restart
=20
 echo
-./futex_wait_timeout $COLOR
+./futex_wait_timeout
=20
 echo
-./futex_wait_wouldblock $COLOR
+./futex_wait_wouldblock
=20
 echo
-./futex_wait_uninitialized_heap $COLOR
-./futex_wait_private_mapped_file $COLOR
+./futex_wait_uninitialized_heap
+./futex_wait_private_mapped_file
=20
 echo
-./futex_wait $COLOR
+./futex_wait
=20
 echo
-./futex_requeue $COLOR
+./futex_requeue
=20
 echo
-./futex_waitv $COLOR
+./futex_waitv
=20
 echo
-./futex_priv_hash $COLOR
-./futex_priv_hash -g $COLOR
+./futex_priv_hash
=20
 echo
-./futex_numa_mpol $COLOR
+./futex_numa_mpol
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testin=
g/selftests/futex/include/futextest.h
index 7a5fd1d5355e..3d48e9789d9f 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -58,6 +58,17 @@ typedef volatile u_int32_t futex_t;
 #define SYS_futex SYS_futex_time64
 #endif
=20
+/*
+ * On 32bit systems if we use "-D_FILE_OFFSET_BITS=3D64 -D_TIME_BITS=3D64" o=
r if
+ * we are using a newer compiler then the size of the timestamps will be 64b=
it,
+ * however, the SYS_futex will still point to the 32bit futex system call.
+ */
+#if __SIZEOF_POINTER__ =3D=3D 4 && defined(SYS_futex_time64) && \
+	defined(_TIME_BITS) && _TIME_BITS =3D=3D 64
+# undef SYS_futex
+# define SYS_futex SYS_futex_time64
+#endif
+
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
diff --git a/tools/testing/selftests/futex/include/logging.h b/tools/testing/=
selftests/futex/include/logging.h
deleted file mode 100644
index 874c69ce5cce..000000000000
--- a/tools/testing/selftests/futex/include/logging.h
+++ /dev/null
@@ -1,148 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/***************************************************************************=
***
- *
- *   Copyright =C2=A9 International Business Machines  Corp., 2009
- *
- * DESCRIPTION
- *      Glibc independent futex library for testing kernel functionality.
- *
- * AUTHOR
- *      Darren Hart <dvhart@linux.intel.com>
- *
- * HISTORY
- *      2009-Nov-6: Initial version by Darren Hart <dvhart@linux.intel.com>
- *
- ***************************************************************************=
**/
-
-#ifndef _LOGGING_H
-#define _LOGGING_H
-
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <linux/futex.h>
-#include "kselftest.h"
-
-/*
- * Define PASS, ERROR, and FAIL strings with and without color escape
- * sequences, default to no color.
- */
-#define ESC 0x1B, '['
-#define BRIGHT '1'
-#define GREEN '3', '2'
-#define YELLOW '3', '3'
-#define RED '3', '1'
-#define ESCEND 'm'
-#define BRIGHT_GREEN ESC, BRIGHT, ';', GREEN, ESCEND
-#define BRIGHT_YELLOW ESC, BRIGHT, ';', YELLOW, ESCEND
-#define BRIGHT_RED ESC, BRIGHT, ';', RED, ESCEND
-#define RESET_COLOR ESC, '0', 'm'
-static const char PASS_COLOR[] =3D {BRIGHT_GREEN, ' ', 'P', 'A', 'S', 'S',
-				  RESET_COLOR, 0};
-static const char ERROR_COLOR[] =3D {BRIGHT_YELLOW, 'E', 'R', 'R', 'O', 'R',
-				   RESET_COLOR, 0};
-static const char FAIL_COLOR[] =3D {BRIGHT_RED, ' ', 'F', 'A', 'I', 'L',
-				  RESET_COLOR, 0};
-static const char INFO_NORMAL[] =3D " INFO";
-static const char PASS_NORMAL[] =3D " PASS";
-static const char ERROR_NORMAL[] =3D "ERROR";
-static const char FAIL_NORMAL[] =3D " FAIL";
-const char *INFO =3D INFO_NORMAL;
-const char *PASS =3D PASS_NORMAL;
-const char *ERROR =3D ERROR_NORMAL;
-const char *FAIL =3D FAIL_NORMAL;
-
-/* Verbosity setting for INFO messages */
-#define VQUIET    0
-#define VCRITICAL 1
-#define VINFO     2
-#define VMAX      VINFO
-int _verbose =3D VCRITICAL;
-
-/* Functional test return codes */
-#define RET_PASS   0
-#define RET_ERROR -1
-#define RET_FAIL  -2
-
-/**
- * log_color() - Use colored output for PASS, ERROR, and FAIL strings
- * @use_color:	use color (1) or not (0)
- */
-void log_color(int use_color)
-{
-	if (use_color) {
-		PASS =3D PASS_COLOR;
-		ERROR =3D ERROR_COLOR;
-		FAIL =3D FAIL_COLOR;
-	} else {
-		PASS =3D PASS_NORMAL;
-		ERROR =3D ERROR_NORMAL;
-		FAIL =3D FAIL_NORMAL;
-	}
-}
-
-/**
- * log_verbosity() - Set verbosity of test output
- * @verbose:	Enable (1) verbose output or not (0)
- *
- * Currently setting verbose=3D1 will enable INFO messages and 0 will disable
- * them. FAIL and ERROR messages are always displayed.
- */
-void log_verbosity(int level)
-{
-	if (level > VMAX)
-		level =3D VMAX;
-	else if (level < 0)
-		level =3D 0;
-	_verbose =3D level;
-}
-
-/**
- * print_result() - Print standard PASS | ERROR | FAIL results
- * @ret:	the return value to be considered: 0 | RET_ERROR | RET_FAIL
- *
- * print_result() is primarily intended for functional tests.
- */
-void print_result(const char *test_name, int ret)
-{
-	switch (ret) {
-	case RET_PASS:
-		ksft_test_result_pass("%s\n", test_name);
-		ksft_print_cnts();
-		return;
-	case RET_ERROR:
-		ksft_test_result_error("%s\n", test_name);
-		ksft_print_cnts();
-		return;
-	case RET_FAIL:
-		ksft_test_result_fail("%s\n", test_name);
-		ksft_print_cnts();
-		return;
-	}
-}
-
-/* log level macros */
-#define info(message, vargs...) \
-do { \
-	if (_verbose >=3D VINFO) \
-		fprintf(stderr, "\t%s: "message, INFO, ##vargs); \
-} while (0)
-
-#define error(message, err, args...) \
-do { \
-	if (_verbose >=3D VCRITICAL) {\
-		if (err) \
-			fprintf(stderr, "\t%s: %s: "message, \
-				ERROR, strerror(err), ##args); \
-		else \
-			fprintf(stderr, "\t%s: "message, ERROR, ##args); \
-	} \
-} while (0)
-
-#define fail(message, args...) \
-do { \
-	if (_verbose >=3D VCRITICAL) \
-		fprintf(stderr, "\t%s: "message, FAIL, ##args); \
-} while (0)
-
-#endif
diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/ks=
elftest.h
index c3b6d2604b1e..8deeb4b72e73 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -54,6 +54,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <string.h>
 #include <stdio.h>
 #include <sys/utsname.h>
@@ -104,6 +105,7 @@ struct ksft_count {
=20
 static struct ksft_count ksft_cnt;
 static unsigned int ksft_plan;
+static bool ksft_debug_enabled;
=20
 static inline unsigned int ksft_test_num(void)
 {
@@ -175,6 +177,18 @@ static inline __printf(1, 2) void ksft_print_msg(const c=
har *msg, ...)
 	va_end(args);
 }
=20
+static inline void ksft_print_dbg_msg(const char *msg, ...)
+{
+	va_list args;
+
+	if (!ksft_debug_enabled)
+		return;
+
+	va_start(args, msg);
+	ksft_print_msg(msg, args);
+	va_end(args);
+}
+
 static inline void ksft_perror(const char *msg)
 {
 	ksft_print_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/self=
tests/kselftest_harness.h
index 2925e47db995..ffefd2704ca8 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1091,7 +1091,7 @@ static int test_harness_argv_check(int argc, char **arg=
v)
 {
 	int opt;
=20
-	while ((opt =3D getopt(argc, argv, "hlF:f:V:v:t:T:r:")) !=3D -1) {
+	while ((opt =3D getopt(argc, argv, "dhlF:f:V:v:t:T:r:")) !=3D -1) {
 		switch (opt) {
 		case 'f':
 		case 'F':
@@ -1104,12 +1104,16 @@ static int test_harness_argv_check(int argc, char **a=
rgv)
 		case 'l':
 			test_harness_list_tests();
 			return KSFT_SKIP;
+		case 'd':
+			ksft_debug_enabled =3D true;
+			break;
 		case 'h':
 		default:
 			fprintf(stderr,
-				"Usage: %s [-h|-l] [-t|-T|-v|-V|-f|-F|-r name]\n"
+				"Usage: %s [-h|-l|-d] [-t|-T|-v|-V|-f|-F|-r name]\n"
 				"\t-h       print help\n"
 				"\t-l       list all tests\n"
+				"\t-d       enable debug prints\n"
 				"\n"
 				"\t-t name  include test\n"
 				"\t-T name  exclude test\n"
@@ -1142,8 +1146,9 @@ static bool test_enabled(int argc, char **argv,
 	int opt;
=20
 	optind =3D 1;
-	while ((opt =3D getopt(argc, argv, "F:f:V:v:t:T:r:")) !=3D -1) {
-		has_positive |=3D islower(opt);
+	while ((opt =3D getopt(argc, argv, "dF:f:V:v:t:T:r:")) !=3D -1) {
+		if (opt !=3D 'd')
+			has_positive |=3D islower(opt);
=20
 		switch (tolower(opt)) {
 		case 't':


