Return-Path: <linux-kernel+bounces-894274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A9DC49A53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB4E24F128C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19752F39B1;
	Mon, 10 Nov 2025 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="f5LUk2Xo"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD872E62C4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814508; cv=none; b=OK3SFWbhAL8yvepxAooacz9Qp6eypYY4uV+nmd7G+AV6B8Bc3QogKsbMuQS3CzOn7yHz1sdAsI/rFjNH3u/tvnH8EVKKfNiCyGvJMbdCcwGsC2oawCOygohb72T58ryOoRoCapBzX9uaV5KgE9m/J4Xxq79bSjClnIr1JsNp8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814508; c=relaxed/simple;
	bh=4JoY9MfyCZiwDVg4KONMXEGjLSYiXMfaGfpiIP0U9NM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i4aWja+t7XGfbIzSNPPIhnlSCJ4kpBmdBZOjoaGBbEJJV4PvR8yELzrqmBi7B5lGZNyDKDzLXcElXC9xfWae0F7eRSPHT6Mgn3r4lswcVxRu/LoqyTRzFFWHab/pilJjES6PnuKL/cd+GwHyBPNR0htchQm6P1NO2DQbaSVy2d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=f5LUk2Xo; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DeA+xRGDRwX5FZJEbvO5br11Fxzt7VrJZ+CdH7mkv84=; b=f5LUk2XoxeftulqsMYS0qZhrMV
	D33Qcoa0qsSO+jFSuayHLqmxEo3cW6jBfksVGvwJE/z3vabkc2SJwxl3EjOxq2p9mWucqxj0ZE5du
	ugMeoZwTLRfUyNjqNVP27O4PJoiCIHbPqBZdm6A4Le9s/UVwO2tnyWIS8Vdv7eP0Uwal9BCoonuWA
	qQTbPhlhuAEsUiXPiLZweAQ2/wNRo0ZExFWaPB39S0hwHuyJw96uYDb8WZXMFudqURwTH7fMDd+PP
	2CMYJyUlguco62buE6sOBk3gl2eHsc0wZosw32CsSo/HCCjL2UFhyjqo3zwOS9h8KfT5bEmMG9mTY
	89G2koBA==;
Received: from [191.8.29.151] (helo=steammachine)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vIaZx-004mkf-PL; Mon, 10 Nov 2025 23:41:42 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	kernel-dev@igalia.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v6] selftests/futex: Create test for robust list
Date: Mon, 10 Nov 2025 19:41:30 -0300
Message-ID: <20251110224130.3044761-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Create a test for the robust list mechanism. Test the following uAPI
operations:

- Creating a robust mutex where the lock waiter is wake by the kernel
  when the lock owner died
- Setting a robust list to the current task
- Getting a robust list from the current task
- Getting a robust list from another task
- Using the list_op_pending field from robust_list_head struct to test
  robustness when the lock owner dies before completing the locking
- Setting a invalid size for syscall argument `len`
- Adding multiple elements to a robust list wait waiting for each of
  them
- Creating a circular list and checking that the kernel does not get
  stuck in an infinity loop

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v5:

- use kselftest_harness.h
- make functions local
- removed casting of void pointers
- whenever a child thread fails, returns -1 immediately
- parent thread checks child returns for test success
- sleep(1) -> usleep(100)
- Use reverse tree ordering, and tabular arrangment
- ASSERT(*futex | FUTEX_OWNER_DIED) -> ASSERT(*futex & FUTEX_OWNER_DIED)
---
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   3 +-
 .../selftests/futex/functional/robust_list.c  | 552 ++++++++++++++++++
 3 files changed, 555 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/robust_list.c

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index 776ad658f75e..23b9fea8d190 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -12,3 +12,4 @@ futex_wait_uninitialized_heap
 futex_wait_wouldblock
 futex_waitv
 futex_numa
+robust_list
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 490ace1f017e..af7ec309ea78 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -22,7 +22,8 @@ TEST_GEN_PROGS := \
 	futex_priv_hash \
 	futex_numa_mpol \
 	futex_waitv \
-	futex_numa
+	futex_numa \
+	robust_list
 
 TEST_PROGS := run.sh
 
diff --git a/tools/testing/selftests/futex/functional/robust_list.c b/tools/testing/selftests/futex/functional/robust_list.c
new file mode 100644
index 000000000000..e7d1254e18ca
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/robust_list.c
@@ -0,0 +1,552 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Igalia S.L.
+ *
+ * Robust list test by André Almeida <andrealmeid@igalia.com>
+ *
+ * The robust list uAPI allows userspace to create "robust" locks, in the sense
+ * that if the lock holder thread dies, the remaining threads that are waiting
+ * for the lock won't block forever, waiting for a lock that will never be
+ * released.
+ *
+ * This is achieve by userspace setting a list where a thread can enter all the
+ * locks (futexes) that it is holding. The robust list is a linked list, and
+ * userspace register the start of the list with the syscall set_robust_list().
+ * If such thread eventually dies, the kernel will walk this list, waking up one
+ * thread waiting for each futex and marking the futex word with the flag
+ * FUTEX_OWNER_DIED.
+ *
+ * See also
+ *	man set_robust_list
+ *	Documententation/locking/robust-futex-ABI.rst
+ *	Documententation/locking/robust-futexes.rst
+ */
+
+#define _GNU_SOURCE
+
+#include "futextest.h"
+#include "../../kselftest_harness.h"
+
+#include <errno.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdatomic.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+
+#define STACK_SIZE (1024 * 1024)
+
+#define FUTEX_TIMEOUT 3
+
+#define SLEEP_US 100
+
+static pthread_barrier_t barrier, barrier2;
+
+static int set_robust_list(struct robust_list_head *head, size_t len)
+{
+	return syscall(SYS_set_robust_list, head, len);
+}
+
+static int get_robust_list(int pid, struct robust_list_head **head, size_t *len_ptr)
+{
+	return syscall(SYS_get_robust_list, pid, head, len_ptr);
+}
+
+/*
+ * Basic lock struct, contains just the futex word and the robust list element
+ * Real implementations have also a *prev to easily walk in the list
+ */
+struct lock_struct {
+	_Atomic(unsigned int)	futex;
+	struct robust_list	list;
+};
+
+/*
+ * Helper function to spawn a child thread. Returns -1 on error, pid on success
+ */
+static int create_child(int (*fn)(void *arg), void *arg)
+{
+	char *stack;
+	pid_t pid;
+
+	stack = mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
+	if (stack == MAP_FAILED)
+		return -1;
+
+	stack += STACK_SIZE;
+
+	pid = clone(fn, stack, CLONE_VM | SIGCHLD, arg);
+
+	if (pid == -1)
+		return -1;
+
+	return pid;
+}
+
+/*
+ * Helper function to prepare and register a robust list
+ */
+static int set_list(struct robust_list_head *head)
+{
+	int ret;
+
+	ret = set_robust_list(head, sizeof(*head));
+	if (ret)
+		return ret;
+
+	head->futex_offset = (size_t) offsetof(struct lock_struct, futex) -
+			     (size_t) offsetof(struct lock_struct, list);
+	head->list.next = &head->list;
+	head->list_op_pending = NULL;
+
+	return 0;
+}
+
+/*
+ * A basic (and incomplete) mutex lock function with robustness
+ */
+static int mutex_lock(struct lock_struct *lock, struct robust_list_head *head, bool error_inject)
+{
+	_Atomic(unsigned int) *futex = &lock->futex;
+	unsigned int zero = 0;
+	pid_t tid = gettid();
+	int ret = -1;
+
+	/*
+	 * Set list_op_pending before starting the lock, so the kernel can catch
+	 * the case where the thread died during the lock operation
+	 */
+	head->list_op_pending = &lock->list;
+
+	if (atomic_compare_exchange_strong(futex, &zero, tid)) {
+		/*
+		 * We took the lock, insert it in the robust list
+		 */
+		struct robust_list *list = &head->list;
+
+		/* Error injection to test list_op_pending */
+		if (error_inject)
+			return 0;
+
+		while (list->next != &head->list)
+			list = list->next;
+
+		list->next = &lock->list;
+		lock->list.next = &head->list;
+
+		ret = 0;
+	} else {
+		/*
+		 * We didn't take the lock, wait until the owner wakes (or dies)
+		 */
+		struct timespec to;
+
+		to.tv_sec = FUTEX_TIMEOUT;
+		to.tv_nsec = 0;
+
+		tid = atomic_load(futex);
+		/* Kernel ignores futexes without the waiters flag */
+		tid |= FUTEX_WAITERS;
+		atomic_store(futex, tid);
+
+		ret = futex_wait((futex_t *) futex, tid, &to, 0);
+
+		/*
+		 * A real mutex_lock() implementation would loop here to finally
+		 * take the lock. We don't care about that, so we stop here.
+		 */
+	}
+
+	head->list_op_pending = NULL;
+
+	return ret;
+}
+
+/*
+ * This child thread will succeed taking the lock, and then will exit holding it
+ */
+static int child_fn_lock(void *arg)
+{
+	struct lock_struct *lock = arg;
+	struct robust_list_head head;
+	int ret;
+
+	ret = set_list(&head);
+	if (ret) {
+		ksft_test_result_fail("set_robust_list error\n");
+		return ret;
+	}
+
+	ret = mutex_lock(lock, &head, false);
+	if (ret) {
+		ksft_test_result_fail("mutex_lock error\n");
+		return ret;
+	}
+
+	pthread_barrier_wait(&barrier);
+
+	/*
+	 * There's a race here: the parent thread needs to be inside
+	 * futex_wait() before the child thread dies, otherwise it will miss the
+	 * wakeup from handle_futex_death() that this child will emit. We wait a
+	 * little bit just to make sure that this happens.
+	 */
+	usleep(SLEEP_US);
+
+	return 0;
+}
+
+/*
+ * Spawns a child thread that will set a robust list, take the lock, register it
+ * in the robust list and die. The parent thread will wait on this futex, and
+ * should be waken up when the child exits.
+ */
+TEST(test_robustness)
+{
+	struct lock_struct lock = { .futex = 0 };
+	_Atomic(unsigned int) *futex = &lock.futex;
+	struct robust_list_head head;
+	int ret, pid, wstatus;
+
+	ret = set_list(&head);
+	ASSERT_EQ(ret, 0);
+
+	/*
+	 * Lets use a barrier to ensure that the child thread takes the lock
+	 * before the parent
+	 */
+	ret = pthread_barrier_init(&barrier, NULL, 2);
+	ASSERT_EQ(ret, 0);
+
+	pid = create_child(&child_fn_lock, &lock);
+	ASSERT_NE(pid, -1);
+
+	pthread_barrier_wait(&barrier);
+	ret = mutex_lock(&lock, &head, false);
+
+	/*
+	 * futex_wait() should return 0 and the futex word should be marked with
+	 * FUTEX_OWNER_DIED
+	 */
+	ASSERT_EQ(ret, 0);
+
+	ASSERT_TRUE(*futex & FUTEX_OWNER_DIED);
+
+	wait(&wstatus);
+	pthread_barrier_destroy(&barrier);
+
+	/* Pass only if the child hasn't return error */
+	if (!WEXITSTATUS(wstatus))
+		ksft_test_result_pass("%s\n", __func__);
+}
+
+/*
+ * The only valid value for len is sizeof(*head)
+ */
+TEST(test_set_robust_list_invalid_size)
+{
+	struct robust_list_head head;
+	size_t head_size = sizeof(head);
+	int ret;
+
+	ret = set_robust_list(&head, head_size);
+	ASSERT_EQ(ret, 0);
+
+	ret = set_robust_list(&head, head_size * 2);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	ret = set_robust_list(&head, head_size - 1);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	ret = set_robust_list(&head, 0);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	ksft_test_result_pass("%s\n", __func__);
+}
+
+/*
+ * Test get_robust_list with pid = 0, getting the list of the running thread
+ */
+TEST(test_get_robust_list_self)
+{
+	struct robust_list_head head, head2, *get_head;
+	size_t head_size = sizeof(head), len_ptr;
+	int ret;
+
+	ret = set_robust_list(&head, head_size);
+	ASSERT_EQ(ret, 0);
+
+	ret = get_robust_list(0, &get_head, &len_ptr);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(get_head, &head);
+	ASSERT_EQ(head_size, len_ptr);
+
+	ret = set_robust_list(&head2, head_size);
+	ASSERT_EQ(ret, 0);
+
+	ret = get_robust_list(0, &get_head, &len_ptr);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(get_head, &head2);
+	ASSERT_EQ(head_size, len_ptr);
+
+	ksft_test_result_pass("%s\n", __func__);
+}
+
+static int child_list(void *arg)
+{
+	struct robust_list_head *head = arg;
+	int ret;
+
+	ret = set_robust_list(head, sizeof(*head));
+	if (ret) {
+		ksft_test_result_fail("set_robust_list error\n");
+		return -1;
+	}
+
+	/*
+	 * After setting the list head, wait until the main thread can call
+	 * get_robust_list() for this thread before exiting.
+	 */
+	pthread_barrier_wait(&barrier);
+	pthread_barrier_wait(&barrier2);
+
+	return 0;
+}
+
+/*
+ * Test get_robust_list from another thread. We use two barriers here to ensure
+ * that:
+ *   1) the child thread set the list before we try to get it from the
+ * parent
+ *   2) the child thread still alive when we try to get the list from it
+ */
+TEST(test_get_robust_list_child)
+{
+	struct robust_list_head head, *get_head;
+	int ret, wstatus;
+	size_t len_ptr;
+	pid_t tid;
+
+	ret = pthread_barrier_init(&barrier, NULL, 2);
+	ret = pthread_barrier_init(&barrier2, NULL, 2);
+	ASSERT_EQ(ret, 0);
+
+	tid = create_child(&child_list, &head);
+	ASSERT_NE(tid, -1);
+
+	pthread_barrier_wait(&barrier);
+
+	ret = get_robust_list(tid, &get_head, &len_ptr);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(&head, get_head);
+
+	pthread_barrier_wait(&barrier2);
+
+	wait(&wstatus);
+	pthread_barrier_destroy(&barrier);
+	pthread_barrier_destroy(&barrier2);
+
+	/* Pass only if the child hasn't return error */
+	if (!WEXITSTATUS(wstatus))
+		ksft_test_result_pass("%s\n", __func__);
+}
+
+static int child_fn_lock_with_error(void *arg)
+{
+	struct lock_struct *lock = arg;
+	struct robust_list_head head;
+	int ret;
+
+	ret = set_list(&head);
+	if (ret) {
+		ksft_test_result_fail("set_robust_list error\n");
+		return -1;
+	}
+
+	ret = mutex_lock(lock, &head, true);
+	if (ret) {
+		ksft_test_result_fail("mutex_lock error\n");
+		return -1;
+	}
+
+	pthread_barrier_wait(&barrier);
+
+	/* See comment at child_fn_lock() */
+	usleep(SLEEP_US);
+
+	return 0;
+}
+
+/*
+ * Same as robustness test, but inject an error where the mutex_lock() exits
+ * earlier, just after setting list_op_pending and taking the lock, to test the
+ * list_op_pending mechanism
+ */
+TEST(test_set_list_op_pending)
+{
+	struct lock_struct lock = { .futex = 0 };
+	_Atomic(unsigned int) *futex = &lock.futex;
+	struct robust_list_head head;
+	int ret, wstatus;
+
+	ret = set_list(&head);
+	ASSERT_EQ(ret, 0);
+
+	ret = pthread_barrier_init(&barrier, NULL, 2);
+	ASSERT_EQ(ret, 0);
+
+	ret = create_child(&child_fn_lock_with_error, &lock);
+	ASSERT_NE(ret, -1);
+
+	pthread_barrier_wait(&barrier);
+	ret = mutex_lock(&lock, &head, false);
+
+	ASSERT_EQ(ret, 0);
+
+	ASSERT_TRUE(*futex & FUTEX_OWNER_DIED);
+
+	wait(&wstatus);
+	pthread_barrier_destroy(&barrier);
+
+	/* Pass only if the child hasn't return error */
+	if (!WEXITSTATUS(wstatus))
+		ksft_test_result_pass("%s\n", __func__);
+	else
+		ksft_test_result_fail("%s\n", __func__);
+}
+
+#define CHILD_NR 10
+
+static int child_lock_holder(void *arg)
+{
+	struct lock_struct *locks = arg;
+	struct robust_list_head head;
+	int i;
+
+	set_list(&head);
+
+	for (i = 0; i < CHILD_NR; i++) {
+		locks[i].futex = 0;
+		mutex_lock(&locks[i], &head, false);
+	}
+
+	pthread_barrier_wait(&barrier);
+	pthread_barrier_wait(&barrier2);
+
+	/* See comment at child_fn_lock() */
+	usleep(SLEEP_US);
+
+	return 0;
+}
+
+static int child_wait_lock(void *arg)
+{
+	struct lock_struct *lock = arg;
+	struct robust_list_head head;
+	int ret;
+
+	pthread_barrier_wait(&barrier2);
+	ret = mutex_lock(lock, &head, false);
+
+	if (ret) {
+		ksft_test_result_fail("mutex_lock error\n");
+		return -1;
+	}
+
+	if (!(lock->futex & FUTEX_OWNER_DIED)) {
+		ksft_test_result_fail("futex not marked with FUTEX_OWNER_DIED\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Test a robust list of more than one element. All the waiters should wake when
+ * the holder dies
+ */
+TEST(test_robust_list_multiple_elements)
+{
+	struct lock_struct locks[CHILD_NR];
+	pid_t pids[CHILD_NR + 1];
+	int i, ret, wstatus;
+
+	ret = pthread_barrier_init(&barrier, NULL, 2);
+	ASSERT_EQ(ret, 0);
+	ret = pthread_barrier_init(&barrier2, NULL, CHILD_NR + 1);
+	ASSERT_EQ(ret, 0);
+
+	pids[0] = create_child(&child_lock_holder, &locks);
+
+	/* Wait until the locker thread takes the look */
+	pthread_barrier_wait(&barrier);
+
+	for (i = 0; i < CHILD_NR; i++)
+		pids[i+1] = create_child(&child_wait_lock, &locks[i]);
+
+	/* Wait for all children to return */
+	ret = 0;
+
+	for (i = 0; i < CHILD_NR; i++) {
+		waitpid(pids[i], &wstatus, 0);
+		if (WEXITSTATUS(wstatus))
+			ret = -1;
+	}
+
+	pthread_barrier_destroy(&barrier);
+	pthread_barrier_destroy(&barrier2);
+
+	/* Pass only if the child hasn't return error */
+	if (!ret)
+		ksft_test_result_pass("%s\n", __func__);
+}
+
+static int child_circular_list(void *arg)
+{
+	static struct robust_list_head head;
+	struct lock_struct a, b, c;
+	int ret;
+
+	ret = set_list(&head);
+	if (ret) {
+		ksft_test_result_fail("set_list error\n");
+		return -1;
+	}
+
+	head.list.next = &a.list;
+
+	/*
+	 * The last element should point to head list, but we short circuit it
+	 */
+	a.list.next = &b.list;
+	b.list.next = &c.list;
+	c.list.next = &a.list;
+
+	return 0;
+}
+
+/*
+ * Create a circular robust list. The kernel should be able to destroy the list
+ * while processing it so it won't be trapped in an infinite loop while handling
+ * a process exit
+ */
+TEST(test_circular_list)
+{
+	int wstatus;
+
+	create_child(child_circular_list, NULL);
+
+	wait(&wstatus);
+
+	/* Pass only if the child hasn't return error */
+	if (!WEXITSTATUS(wstatus))
+		ksft_test_result_pass("%s\n", __func__);
+}
+
+TEST_HARNESS_MAIN
-- 
2.51.2


