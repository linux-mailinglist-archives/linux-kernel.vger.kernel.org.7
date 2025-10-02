Return-Path: <linux-kernel+bounces-839786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CF3BB2680
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 04:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD7719E0912
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 02:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D470286D71;
	Thu,  2 Oct 2025 02:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LytkQdS5"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643AB29BDBC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759373859; cv=none; b=cwPdnltSpN8qDWYNkhrqQmAo2q4uLG7RAghRfYwq736yWb/3dxdbb1+NqUrjTXV+9h7sxnjWwQrQ//Pw9j0oDI65RNTfENnQ33QGQfG9/CtVFnnahIX0rBgUKpEmUPKxS5kPX3e+SKzwEkqaWkvMRKiGYJE2dHF/dLg3xSIWmp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759373859; c=relaxed/simple;
	bh=NsT/7leM+Z+LkGB8o+Jjf49sZXdF/46YFSdWNa66/AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrTHgK9c4KM/EKBHvhaVc4dFG+SH55NOpfuFWE+1JoORJO09d6PJMhihhmyCaN/4GIvoXuoPjKATE5/PtXO4u+evDhH+CPeOY7+0MbbssZK2KOilHzkem5Jqg1UUTkXeMRdzXfBw51fl1FDLoEtZW6Q0khYQkisGFF245PqjZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LytkQdS5; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-42486ed0706so2979895ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759373856; x=1759978656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wU35K+1akWNuALAzb08WKRtex5CvCVX+avkesvY8u3M=;
        b=LytkQdS5pOo9dJNg1xk56wDA88Y4AOP9SN/NpobM96ezl0B0P3AsF2LM1JUmoDuagT
         hcsBZ9X3WStPre2VejjXijx3z0CBQOaA1VqEEP9dmHpObJd37LXNiMdRop/eSJzjgWEC
         O4o+tcrtVHyXpiw+4rOs/GrKXft2F22gRYaJWq8q70yiWDSXaE9/jtSV2q7V1ZvhYTfB
         qGcf7q76CnsOxLyToEZpul7J6wJGxb7Hu5ySo6hTvvxdFUxQ+zZl5eHnMVh9JsjUaTA9
         2uhkGZNn1Gratcov5RDAv1lF5ShoeznPClt54rByXQc90h3Py7xXdiOEJyaymdimoOR2
         GyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759373856; x=1759978656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wU35K+1akWNuALAzb08WKRtex5CvCVX+avkesvY8u3M=;
        b=EBamHjkCHRF9GGRxpmwhpBp0JFtD/UGJTNU7QFKGJQ114GqQbmkH3x1FWdopZ16fPd
         R3Oyq+vLii2Jm8vJQ0hpAuJmZc4d0sJuwImuGDX9qmIaN/zfF6hs643Sw1H9Bvs2n4Xb
         zPFeeVEzTzeSMpFfEaPWyKnengMRcsNrdrzTV5ibUkDNZBaVmpYtA1kUXEEq/IIL1Pkc
         4z9p1syX3naOsMsL3dF2v1j24y7EMTXa110z0s3L6kZrzuF1Y4oGRBgU40KM78zTV3LU
         JVMFf4zZBx4uVSlH0iYIGrDuX8KqilY+U+RFxzRgCocIVB9nexFWyPAS/jb0zkhP++b2
         kBBQ==
X-Gm-Message-State: AOJu0YwZ2ClUUEg7J74xYtBB1UYoV9UgIq0FV3sWwjBfo6HlFfygPQb1
	BFzCjiYH5eGPs9y0zP/CogacBq54p0t7BfV/pv+6jsSQIvQFyQEMtCvMEztpT2Hd
X-Gm-Gg: ASbGncvulHWILaCmQGHJP+N1pwT2O9GYR4bhhJVjqrnmMNZmxIhb+2NSDlD5UkAMm0R
	1WR+ZnZvexrpewsKUPQIOdlvtUhUzL3X/1t5a0aNC169Mi9ylv7nqKtdzo1FTaqrErRbnnzYVNU
	F03cHjyk0GZrpglmHpTF7sGQcwl9mTTxLc7QQQFsB/99PprwDmnqiCeZWz2dE4NnWABTq3yF2MJ
	TE/g3UG2V+IrsPnxo5U4wiQBF1y9H+6LtQT0lXpdpwUPCFCYLIC8YWTWzUx2m5nB2uohATMTdwS
	X/X+Xft0FDBgZIM9JDEokTQmyjEZZ4dFiDO3vEaAzsHzgWT3QD/HB4AoD4hT3e0gGw9oM4W4+aI
	bi+DHZN8IGRF/2Ovr6yFgQw5ndQ9fGexvPxh574MIIoevoArNSltEJbfbNQwd+taMDDgeJETwFe
	q7TKs12x1LhNI3sBeygkVONLyU8YXK07T5+depuNP0yCCiwQ==
X-Google-Smtp-Source: AGHT+IGFJnbkla4p6ugYoueYkRXj84y9YL9EJyBOrh5P+LWZK3apsFtDtdfikGHF20BbFxGDDzykSQ==
X-Received: by 2002:a05:6e02:1fc4:b0:42a:cc5e:bde5 with SMTP id e9e14a558f8ab-42d8161765bmr71964395ab.21.1759373855573;
        Wed, 01 Oct 2025 19:57:35 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b1f4f0asm5250255ab.2.2025.10.01.19.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:57:34 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	arighi@nvidia.com,
	newton@meta.com
Subject: [PATCH 3/3] sched_ext: Add a selftest for scx_bpf_dsq_peek
Date: Wed,  1 Oct 2025 22:57:21 -0400
Message-ID: <20251002025722.3420916-4-rrnewton@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002025722.3420916-1-rrnewton@gmail.com>
References: <20251002025722.3420916-1-rrnewton@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ryan Newton <newton@meta.com>

This is the most basic unit test: make sure an empty queue peeks as
empty, and when we put one element in the queue, make sure peek returns
that element.

However, even this simple test is a little complicated by the different
behavior of scx_bpf_dsq_insert in different calling contexts:
 - insert is for direct dispatch in enqueue
 - insert is delayed when called from select_cpu

In this case we split the insert and the peek that verifies the
result between enqueue/dispatch.

Note: An alternative would be to call `scx_bpf_dsq_move_to_local` on an
empty queue, which in turn calls `flush_dispatch_buf`, in order to flush
the buffered insert. Unfortunately, this is not viable within the
enqueue path, as it attempts a voluntary context switch within an RCU
read-side critical section.

Signed-off-by: Ryan Newton <newton@meta.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/peek_dsq.bpf.c        | 133 +++++++++++++
 tools/testing/selftests/sched_ext/peek_dsq.c  | 188 ++++++++++++++++++
 3 files changed, 322 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/peek_dsq.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 9d9d6b4c38b0..5fe45f9c5f8f 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -174,6 +174,7 @@ auto-test-targets :=			\
 	minimal				\
 	numa				\
 	allowed_cpus			\
+	peek_dsq			\
 	prog_run			\
 	reload_loop			\
 	select_cpu_dfl			\
diff --git a/tools/testing/selftests/sched_ext/peek_dsq.bpf.c b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
new file mode 100644
index 000000000000..6bbd98799503
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A BPF program for testing DSQ operations including create, destroy,
+ * and peek operations. Uses a hybrid approach:
+ * - Syscall program for DSQ lifecycle (create/destroy)
+ * - Struct ops scheduler for task insertion/dequeue testing
+ *
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Ryan Newton <ryan.newton@alum.mit.edu>
+ */
+
+#include <scx/common.bpf.h>
+#include <scx/compat.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+/* Global variables to store test results */
+int dsq_create_result = -1;
+int dsq_destroy_result = -1;
+int dsq_peek_result1 = -1;
+long dsq_inserted_pid = -1;
+int insert_test_cpu = -1; /* Set to the cpu that performs the test */
+long dsq_peek_result2 = -1;
+long dsq_peek_result2_pid = -1;
+long dsq_peek_result2_expected = -1;
+int test_dsq_id = 1234; /* Use a simple ID like create_dsq example */
+int real_dsq_id = 1235; /* DSQ for normal operation */
+int enqueue_count = -1;
+int dispatch_count = -1;
+int debug_ksym_exists = -1;
+
+
+/* Test if we're actually using the native or compat version */
+int check_dsq_insert_ksym(void)
+{
+	return bpf_ksym_exists(scx_bpf_dsq_insert) ? 1 : 0;
+}
+
+int check_dsq_peek_ksym(void)
+{
+	return bpf_ksym_exists(scx_bpf_dsq_peek) ? 1 : 0;
+}
+
+/* Struct_ops scheduler for testing DSQ peek operations */
+void BPF_STRUCT_OPS(peek_dsq_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	struct task_struct *peek_result;
+	int last_insert_test_cpu, cpu;
+
+	enqueue_count++;
+	cpu = bpf_get_smp_processor_id();
+	last_insert_test_cpu = __sync_val_compare_and_swap(
+		&insert_test_cpu, -1, cpu);
+
+	/* On the first task, just do the empty DSQ test and insert into test DSQ */
+	if (last_insert_test_cpu == -1) {
+		bpf_printk("peek_dsq_enqueue beginning peek test on cpu %d\n", cpu);
+
+		/* Test 1: Peek empty DSQ - should return NULL */
+		peek_result = __COMPAT_scx_bpf_dsq_peek(test_dsq_id);
+		dsq_peek_result1 = (long)peek_result; /* Should be 0 (NULL) */
+
+		/* Test 2: Insert task into test DSQ for testing in dispatch callback */
+		dsq_inserted_pid = p->pid;
+		scx_bpf_dsq_insert(p, test_dsq_id, 0, enq_flags);
+		dsq_peek_result2_expected = (long)p; /* Expected the task we just inserted */
+	} else
+		scx_bpf_dsq_insert(p, real_dsq_id, 0, enq_flags);
+}
+
+void BPF_STRUCT_OPS(peek_dsq_dispatch, s32 cpu, struct task_struct *prev)
+{
+	dispatch_count++;
+	/* Complete the peek test if we inserted a task but haven't tested peek yet */
+	if (insert_test_cpu == cpu && dsq_peek_result2 == -1) {
+		struct task_struct *peek_result;
+
+		bpf_printk("peek_dsq_dispatch completing second half of peek test on cpu %d\n",
+			   cpu);
+
+		/* Test 3: Peek DSQ after insert - should return the task we inserted */
+		peek_result = __COMPAT_scx_bpf_dsq_peek(test_dsq_id);
+		/* Store the PID of the peeked task for comparison */
+		dsq_peek_result2 = (long)peek_result;
+		dsq_peek_result2_pid = peek_result ? peek_result->pid : -1;
+
+		/* Now consume the task since we've peeked at it */
+		scx_bpf_dsq_move_to_local(test_dsq_id);
+	} else
+		scx_bpf_dsq_move_to_local(real_dsq_id);
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(peek_dsq_init)
+{
+	s32 err;
+
+	/* Always set debug values so we can see which version we're using */
+	debug_ksym_exists = check_dsq_peek_ksym();
+
+	/* Initialize state first */
+	insert_test_cpu = -1;
+	enqueue_count = 0;
+	dsq_create_result = 0; /* Reset to 0 before attempting */
+
+	/* Create a DSQ */
+	err = scx_bpf_create_dsq(test_dsq_id, -1);
+	if (!err)
+		err = scx_bpf_create_dsq(real_dsq_id, -1);
+	if (err) {
+		dsq_create_result = err;
+		scx_bpf_error("Failed to create DSQ %d: %d", test_dsq_id, err);
+		return err;
+	}
+
+	dsq_create_result = 1; /* Success */
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(peek_dsq_exit, struct scx_exit_info *ei)
+{
+	scx_bpf_destroy_dsq(test_dsq_id);
+	dsq_destroy_result = 1;
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops peek_dsq_ops = {
+	.enqueue = (void *)peek_dsq_enqueue,
+	.dispatch = (void *)peek_dsq_dispatch,
+	.init = (void *)peek_dsq_init,
+	.exit = (void *)peek_dsq_exit,
+	.name = "peek_dsq",
+};
diff --git a/tools/testing/selftests/sched_ext/peek_dsq.c b/tools/testing/selftests/sched_ext/peek_dsq.c
new file mode 100644
index 000000000000..ba9e03c2bd49
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/peek_dsq.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test for DSQ operations including create, destroy, and peek operations.
+ *
+ * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2025 Ryan Newton <ryan.newton@alum.mit.edu>
+ */
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <string.h>
+#include <sched.h>
+#include "peek_dsq.bpf.skel.h"
+#include "scx_test.h"
+
+static bool workload_running = true;
+static pthread_t workload_thread;
+
+/**
+ * Background workload thread that sleeps and wakes rapidly to exercise
+ * the scheduler's enqueue operations and ensure DSQ operations get tested.
+ */
+static void *workload_thread_fn(void *arg)
+{
+	while (workload_running) {
+		/* Sleep for a very short time to trigger scheduler activity */
+		usleep(1000); /* 1ms sleep */
+		/* Yield to ensure we go through the scheduler */
+		sched_yield();
+	}
+	return NULL;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct peek_dsq *skel;
+
+	skel = peek_dsq__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(peek_dsq__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct peek_dsq *skel = ctx;
+	bool failed = false;
+	int seconds = 2;
+	int err;
+
+	/* Enable the scheduler to test DSQ operations */
+	printf("Enabling scheduler to test DSQ insert operations...\n");
+
+	struct bpf_link *link =
+		bpf_map__attach_struct_ops(skel->maps.peek_dsq_ops);
+
+	if (!link) {
+		SCX_ERR("Failed to attach struct_ops");
+		return SCX_TEST_FAIL;
+	}
+
+	/* Start background workload thread to exercise the scheduler */
+	printf("Starting background workload thread...\n");
+	workload_running = true;
+	err = pthread_create(&workload_thread, NULL, workload_thread_fn, NULL);
+	if (err) {
+		SCX_ERR("Failed to create workload thread: %s", strerror(err));
+		bpf_link__destroy(link);
+		return SCX_TEST_FAIL;
+	}
+
+	printf("Waiting for enqueue events.\n");
+	sleep(2);
+	while (skel->data->enqueue_count <= 0) {
+		printf(".");
+		fflush(stdout);
+		sleep(1);
+		seconds++;
+		if (seconds >= 30) {
+			printf("\n✗ Timeout waiting for enqueue events\n");
+			/* Stop workload thread and cleanup */
+			workload_running = false;
+			pthread_join(workload_thread, NULL);
+			bpf_link__destroy(link);
+			return SCX_TEST_FAIL;
+		}
+	}
+
+	workload_running = false;
+	err = pthread_join(workload_thread, NULL);
+	if (err) {
+		SCX_ERR("Failed to join workload thread: %s", strerror(err));
+		bpf_link__destroy(link);
+		return SCX_TEST_FAIL;
+	}
+	printf("Background workload thread stopped.\n");
+
+	/* Detach the scheduler */
+	bpf_link__destroy(link);
+
+	/* Check if DSQ creation succeeded */
+	if (skel->data->dsq_create_result != 1) {
+		printf("✗ DSQ create failed: got %d, expected 1\n",
+		       skel->data->dsq_create_result);
+		failed = true;
+	} else {
+		printf("✓ DSQ create succeeded\n");
+	}
+
+	printf("Enqueue/dispatch count over %d seconds: %d / %d\n", seconds,
+		skel->data->enqueue_count, skel->data->dispatch_count);
+	printf("Debug: ksym_exists=%d\n",
+	       skel->data->debug_ksym_exists);
+
+	/* Check DSQ insert result */
+	printf("DSQ insert test done on cpu: %d\n", skel->data->insert_test_cpu);
+	if (skel->data->insert_test_cpu != -1)
+		printf("✓ DSQ insert succeeded !\n");
+	else {
+		printf("✗ DSQ insert failed or not attempted\n");
+		failed = true;
+	}
+
+	/* Check DSQ peek results */
+	printf("  DSQ peek result 1 (before insert): %d\n",
+	       skel->data->dsq_peek_result1);
+	if (skel->data->dsq_peek_result1 == 0)
+		printf("✓ DSQ peek verification succeeded - peek returned NULL!\n");
+	else {
+		printf("✗ DSQ peek verification failed\n");
+		failed = true;
+	}
+
+	printf("  DSQ peek result 2 (after insert): %ld\n",
+	       skel->data->dsq_peek_result2);
+	printf("  DSQ peek result 2, expected: %ld\n",
+	       skel->data->dsq_peek_result2_expected);
+	if (skel->data->dsq_peek_result2 ==
+	    skel->data->dsq_peek_result2_expected)
+		printf("✓ DSQ peek verification succeeded - peek returned the inserted task!\n");
+	else {
+		printf("✗ DSQ peek verification failed\n");
+		failed = true;
+	}
+
+	printf("  Inserted test task -> pid: %ld\n", skel->data->dsq_inserted_pid);
+	printf("  DSQ peek result 2 -> pid: %ld\n", skel->data->dsq_peek_result2_pid);
+
+	if (skel->data->dsq_destroy_result != 1) {
+		printf("✗ DSQ destroy failed: got %d, expected 1\n",
+		       skel->data->dsq_destroy_result);
+		failed = true;
+	}
+
+	if (failed)
+		return SCX_TEST_FAIL;
+	else
+		return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct peek_dsq *skel = ctx;
+
+	/* Ensure workload thread is stopped */
+	if (workload_running) {
+		workload_running = false;
+		pthread_join(workload_thread, NULL);
+	}
+
+	peek_dsq__destroy(skel);
+}
+
+struct scx_test peek_dsq = {
+	.name = "peek_dsq",
+	.description =
+		"Test DSQ create/destroy operations and future peek functionality",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&peek_dsq)
-- 
2.51.0


