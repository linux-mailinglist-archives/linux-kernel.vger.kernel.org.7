Return-Path: <linux-kernel+bounces-841697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E836BB802A
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 21:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 039AD34751C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 19:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A0B27FD54;
	Fri,  3 Oct 2025 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/LYqs5j"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB323815C
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 19:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759521262; cv=none; b=XwdyhBdVFT8D1Z3Yq0SQlxph/Gc7ixnpOYfI72eNP7vZn0uDUVvZWfCD3dbaJFOsJtkNtZH5wHNWiMRRcjnDwwA8p3OUQ+01VoQ31e1XBsLf/yk5sdFvIJ9PKKfTKBLPRv8+90Z0W9GWCNH9kabWxJmNTPLWkoW+U47LNknYmwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759521262; c=relaxed/simple;
	bh=nMleBFXH6bcfJx5OJ8L/WmJo6u6eVfE6KPYO/5HKNFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4cKtdTOxW2a/4REYqfenaecilncp4YF9GZfKfh8rJTIRIaSz0u8bwISST4AB1kfDDlzsx/Ort6TOL7Bbo4lnPwoqHIDdcK9SnnKn3keDpwpDKnizFeevvmNvBVGj0qS7b+ZtTk5ZFErinWXcs4tNJOb+qTGwwJEroHZhUNxsPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/LYqs5j; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42f3acb1744so4989685ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 12:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759521259; x=1760126059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xG/jchVd7FOQzHSdx6QmN8oRj8yUYSgtpFCtEzkaOx4=;
        b=T/LYqs5jrAtmuBtkL7xHXhZYm1+PuHo3BevgFLHl386W0LHcAz1TMIF0JWOlosro9l
         y1lKEAABePWdeVP2+HeZLxFAQH9GvxsPRnFCn8dm+syCV+BxVdXrmS9xkiiQUg5uaXwC
         wia19hcpPzXNLkZJPBBg/tesk3/8MLRcCerkcAV/VF9BwDqXh29ZKkgQg5k3Qyx+Kzgg
         weaMpMYZF6y1nSU7VESYiHYN4gHCHs8kyvXNV9qKtSjRX59uL+L1wHrI2M9iFyNoIx9O
         ht4WDKf4Qsqjg35bUHk2UL53qIUJVAp9bgFVfqp52A/sYWqjGTH68sUqFzME0mL2SQd5
         jAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759521259; x=1760126059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xG/jchVd7FOQzHSdx6QmN8oRj8yUYSgtpFCtEzkaOx4=;
        b=tOtLN9xMOUGd4X/MI1AJ+zLf0LGYusmPtj3zLcEDQEKu14ZViyBHK7qwd/rdhE9LAe
         5x8Irw65vCP8JzuYToEOtUC1s4KiXkAqDZNkg9UGHirUz7DL8O9t0gz+Hn3MO9wTo5tr
         ajPoGIREBPanxs6xuyC6A5THqzEX9DKX0U74QuC5UoXuKaQ/RPJ2FhxyF0gqb8hflqoc
         iyeUc43ieXhH4VP+ENxqicE4KwTNKKEoQynbW1B2vXO5JBB2GnaOfCl0aKDGZcWau/L8
         EKBn0p67OV+Q1Z7eiCDlLYzor0tRyQZu7mPEQw56M3kBSMTVq2UypJOtBiuaaaNzhM9G
         WlAQ==
X-Gm-Message-State: AOJu0YxQ4FvDX53nZRxtKozaazd+/eWgAqf9m8dJEvWfPjQl4hHW9QxX
	FPpCvpdVTwTjELPpbu7wfojhAlJAcMLAHOJPgZsd6zuoJpmVNbjSKTij6M03EB3A
X-Gm-Gg: ASbGncuHcRoClfmgiXH7uijNJqPBLp71kbaNdznL1w5mB3KwSusei3a/Ti7a07Gz6FG
	rJF2dQ6a/XSalOAFYlOIF0C9gfY0vN+O41M1tIybs3WX1/f6k2YJVnxLWKhT25lh6SZx7mEyChG
	xgd0mBg2dPLQomQVdREePzIUZt8xsXEsihr6lnf+QTp86nrm84JHDYm2Wjj/pUr+l/nSP4LoWco
	o+hou5/JrCMJloT7vIHElUK1hM21tue5FYg41tQT4vTCl0jchhOxk1CD8jne5IeWYhGDwKf0Dpf
	5UN5T8XwvOIY6UECwXomLrNVIhqmbG7j1iOltZ1HlnuDAnTT1zFUT83JfDtsN2cvYqqiOKr+k3/
	ZnTRF+iGQy2JmP+I0lNfHnku0uk3M5mOgiVxt86Qr5MK+ESv+qwIUiZ87GPE39jRuUNrJXoVtHN
	iuVsSMYzWopfThAPR0KqGAR1aRHMna5QN5NxXvwoGGAs7iZw==
X-Google-Smtp-Source: AGHT+IFhQESd9MQviCWJSFFOrRvgjRZzpsmh8SUF0fLNVcge/P4nHtN5W/C+Uxj8rE05FoG9s+NFYA==
X-Received: by 2002:a05:6e02:168e:b0:42d:840f:319b with SMTP id e9e14a558f8ab-42e7ad8458cmr57492035ab.18.1759521258744;
        Fri, 03 Oct 2025 12:54:18 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ebc8181sm2296390173.47.2025.10.03.12.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:54:17 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	arighi@nvidia.com,
	rrnewton@gmail.com,
	newton@meta.com
Subject: [PATCH v2 3/3] sched_ext: Add a selftest for scx_bpf_dsq_peek
Date: Fri,  3 Oct 2025 15:54:08 -0400
Message-ID: <20251003195408.675527-4-rrnewton@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003195408.675527-1-rrnewton@gmail.com>
References: <20251003195408.675527-1-rrnewton@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
 .../selftests/sched_ext/peek_dsq.bpf.c        | 268 ++++++++++++++++++
 tools/testing/selftests/sched_ext/peek_dsq.c  | 235 +++++++++++++++
 3 files changed, 504 insertions(+)
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
index 000000000000..977ecf2c6ffc
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/peek_dsq.bpf.c
@@ -0,0 +1,268 @@
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
+#define MAX_SAMPLES 100
+#define MAX_CPUS 512
+#define DSQ_POOL_SIZE 8
+int max_samples = MAX_SAMPLES;
+int max_cpus = MAX_CPUS;
+int dsq_pool_size = DSQ_POOL_SIZE;
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
+/* DSQ pool for stress testing */
+int dsq_pool_base_id = 2000;
+int phase1_complete = -1;
+int total_peek_attempts = -1;
+int successful_peeks = -1;
+
+/* BPF map for sharing peek results with userspace */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, MAX_SAMPLES);
+	__type(key, u32);
+	__type(value, long);
+} peek_results SEC(".maps");
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
+static inline int get_random_dsq_id(void)
+{
+	u64 time = bpf_ktime_get_ns();
+
+	return dsq_pool_base_id + (time % DSQ_POOL_SIZE);
+}
+
+static inline void record_peek_result(long pid)
+{
+	u32 slot_key;
+	long *slot_pid_ptr;
+	int ix;
+
+	if (pid <= 0)
+		return;
+
+	/* Find an empty slot or one with the same PID */
+	bpf_for(ix, 0, 10) {
+		slot_key = (pid + ix) % MAX_SAMPLES;
+		slot_pid_ptr = bpf_map_lookup_elem(&peek_results, &slot_key);
+		if (!slot_pid_ptr)
+			continue;
+
+		if (*slot_pid_ptr == -1 || *slot_pid_ptr == pid) {
+			*slot_pid_ptr = pid;
+			break;
+		}
+	}
+}
+
+/* Scan all DSQs in the pool and try to move a task to local */
+static inline int scan_dsq_pool(void)
+{
+	struct task_struct *task;
+	int moved = 0;
+	int i;
+
+	bpf_for(i, 0, DSQ_POOL_SIZE) {
+		int dsq_id = dsq_pool_base_id + i;
+
+		total_peek_attempts++;
+
+		task = __COMPAT_scx_bpf_dsq_peek(dsq_id);
+		if (task) {
+			successful_peeks++;
+			record_peek_result(task->pid);
+
+			/* Try to move this task to local */
+			if (!moved && scx_bpf_dsq_move_to_local(dsq_id) == 0) {
+				moved = 1;
+				break;
+			}
+		}
+	}
+	return moved;
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
+	/* Phase 1: Simple insert-then-peek test (only on first task) */
+	if (last_insert_test_cpu == -1) {
+		bpf_printk("peek_dsq_enqueue beginning phase 1 peek test on cpu %d\n", cpu);
+
+		/* Test 1: Peek empty DSQ - should return NULL */
+		peek_result = __COMPAT_scx_bpf_dsq_peek(test_dsq_id);
+		dsq_peek_result1 = (long)peek_result; /* Should be 0 (NULL) */
+
+		/* Test 2: Insert task into test DSQ for testing in dispatch callback */
+		dsq_inserted_pid = p->pid;
+		scx_bpf_dsq_insert(p, test_dsq_id, 0, enq_flags);
+		dsq_peek_result2_expected = (long)p; /* Expected the task we just inserted */
+	} else if (!phase1_complete) {
+		/* Still in phase 1, use real DSQ */
+		scx_bpf_dsq_insert(p, real_dsq_id, 0, enq_flags);
+	} else {
+		/* Phase 2: Random DSQ insertion for stress testing */
+		int random_dsq_id = get_random_dsq_id();
+
+		scx_bpf_dsq_insert(p, random_dsq_id, 0, enq_flags);
+	}
+}
+
+void BPF_STRUCT_OPS(peek_dsq_dispatch, s32 cpu, struct task_struct *prev)
+{
+	dispatch_count++;
+
+	/* Phase 1: Complete the simple peek test if we inserted a task but
+	 * haven't tested peek yet
+	 */
+	if (insert_test_cpu == cpu && dsq_peek_result2 == -1) {
+		struct task_struct *peek_result;
+
+		bpf_printk("peek_dsq_dispatch completing phase 1 peek test on cpu %d\n", cpu);
+
+		/* Test 3: Peek DSQ after insert - should return the task we inserted */
+		peek_result = __COMPAT_scx_bpf_dsq_peek(test_dsq_id);
+		/* Store the PID of the peeked task for comparison */
+		dsq_peek_result2 = (long)peek_result;
+		dsq_peek_result2_pid = peek_result ? peek_result->pid : -1;
+
+		/* Now consume the task since we've peeked at it */
+		scx_bpf_dsq_move_to_local(test_dsq_id);
+
+		/* Mark phase 1 as complete */
+		phase1_complete = 1;
+		bpf_printk("Phase 1 complete, starting phase 2 stress testing\n");
+	} else if (!phase1_complete) {
+		/* Still in phase 1, use real DSQ */
+		scx_bpf_dsq_move_to_local(real_dsq_id);
+	} else {
+		/* Phase 2: Scan all DSQs in the pool and try to move a task */
+		if (!scan_dsq_pool()) {
+			/* No tasks found in DSQ pool, fall back to real DSQ */
+			scx_bpf_dsq_move_to_local(real_dsq_id);
+		}
+	}
+}
+
+s32 BPF_STRUCT_OPS_SLEEPABLE(peek_dsq_init)
+{
+	s32 err;
+	int i;
+
+	/* Always set debug values so we can see which version we're using */
+	debug_ksym_exists = check_dsq_peek_ksym();
+
+	/* Initialize state first */
+	insert_test_cpu = -1;
+	enqueue_count = 0;
+	dispatch_count = 0;
+	phase1_complete = 0;
+	total_peek_attempts = 0;
+	successful_peeks = 0;
+	dsq_create_result = 0; /* Reset to 0 before attempting */
+
+	/* Create the test and real DSQs */
+	err = scx_bpf_create_dsq(test_dsq_id, -1);
+	if (!err)
+		err = scx_bpf_create_dsq(real_dsq_id, -1);
+	if (err) {
+		dsq_create_result = err;
+		scx_bpf_error("Failed to create primary DSQ %d: %d", test_dsq_id, err);
+		return err;
+	}
+
+	/* Create the DSQ pool for stress testing */
+	bpf_for(i, 0, DSQ_POOL_SIZE) {
+		int dsq_id = dsq_pool_base_id + i;
+
+		err = scx_bpf_create_dsq(dsq_id, -1);
+		if (err) {
+			dsq_create_result = err;
+			scx_bpf_error("Failed to create DSQ pool entry %d: %d", dsq_id, err);
+			return err;
+		}
+	}
+
+	dsq_create_result = 1; /* Success */
+
+	/* Initialize the peek results map */
+	bpf_for(i, 0, MAX_SAMPLES) {
+		u32 key = i;
+		long pid = -1;
+
+		bpf_map_update_elem(&peek_results, &key, &pid, BPF_ANY);
+	}
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(peek_dsq_exit, struct scx_exit_info *ei)
+{
+	int i;
+
+	/* Destroy the primary DSQs */
+	scx_bpf_destroy_dsq(test_dsq_id);
+	scx_bpf_destroy_dsq(real_dsq_id);
+
+	/* Destroy the DSQ pool */
+	bpf_for(i, 0, DSQ_POOL_SIZE) {
+		int dsq_id = dsq_pool_base_id + i;
+
+		scx_bpf_destroy_dsq(dsq_id);
+	}
+
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
index 000000000000..1e326d494d1f
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/peek_dsq.c
@@ -0,0 +1,235 @@
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
+#define NUM_WORKERS 100
+
+static bool workload_running = true;
+static pthread_t workload_threads[NUM_WORKERS];
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
+static int print_observed_pids(struct bpf_map *map, int max_samples, const char *dsq_name)
+{
+	long count = 0;
+
+	printf("Observed %s DSQ peek pids:\n", dsq_name);
+	for (int i = 0; i < max_samples; i++) {
+		long pid;
+		int err;
+
+		err = bpf_map_lookup_elem(bpf_map__fd(map), &i, &pid);
+		if (err == 0) {
+			if (pid == 0) {
+				printf("  Sample %d: NULL peek\n", i);
+			} else if (pid > 0) {
+				printf("  Sample %d: pid %ld\n", i, pid);
+				count++;
+			}
+		} else {
+			printf("  Sample %d: error reading pid (err=%d)\n", i, err);
+		}
+	}
+	printf("Observed ~%ld pids in the %s DSQ(s)\n", count, dsq_name);
+	return count;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct peek_dsq *skel = ctx;
+	bool failed = false;
+	int seconds = 3;
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
+	printf("Starting %d background workload threads...\n", NUM_WORKERS);
+	workload_running = true;
+	for (int i = 0; i < NUM_WORKERS; i++) {
+		err = pthread_create(&workload_threads[i], NULL, workload_thread_fn, NULL);
+		if (err) {
+			SCX_ERR("Failed to create workload thread %d: %s", i, strerror(err));
+			/* Stop already created threads */
+			workload_running = false;
+			for (int j = 0; j < i; j++)
+				pthread_join(workload_threads[j], NULL);
+			bpf_link__destroy(link);
+			return SCX_TEST_FAIL;
+		}
+	}
+
+	printf("Waiting for enqueue events.\n");
+	sleep(seconds);
+	while (skel->data->enqueue_count <= 0) {
+		printf(".");
+		fflush(stdout);
+		sleep(1);
+		seconds++;
+		if (seconds >= 30) {
+			printf("\n\u2717 Timeout waiting for enqueue events\n");
+			/* Stop workload threads and cleanup */
+			workload_running = false;
+			for (int i = 0; i < NUM_WORKERS; i++)
+				pthread_join(workload_threads[i], NULL);
+			bpf_link__destroy(link);
+			return SCX_TEST_FAIL;
+		}
+	}
+
+	workload_running = false;
+	for (int i = 0; i < NUM_WORKERS; i++) {
+		err = pthread_join(workload_threads[i], NULL);
+		if (err) {
+			SCX_ERR("Failed to join workload thread %d: %s", i, strerror(err));
+			bpf_link__destroy(link);
+			return SCX_TEST_FAIL;
+		}
+	}
+	printf("Background workload threads stopped.\n");
+
+	/* Detach the scheduler */
+	bpf_link__destroy(link);
+
+	/* Check if DSQ creation succeeded */
+	if (skel->data->dsq_create_result != 1) {
+		printf("\u2717 DSQ create failed: got %d, expected 1\n",
+		       skel->data->dsq_create_result);
+		failed = true;
+	} else {
+		printf("\u2713 DSQ create succeeded\n");
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
+		printf("\u2713 DSQ insert succeeded !\n");
+	else {
+		printf("\u2717 DSQ insert failed or not attempted\n");
+		failed = true;
+	}
+
+	/* Check DSQ peek results */
+	printf("  DSQ peek result 1 (before insert): %d\n",
+	       skel->data->dsq_peek_result1);
+	if (skel->data->dsq_peek_result1 == 0)
+		printf("\u2713 DSQ peek verification success: peek returned NULL!\n");
+	else {
+		printf("\u2717 DSQ peek verification failed\n");
+		failed = true;
+	}
+
+	printf("  DSQ peek result 2 (after insert): %ld\n",
+	       skel->data->dsq_peek_result2);
+	printf("  DSQ peek result 2, expected: %ld\n",
+	       skel->data->dsq_peek_result2_expected);
+	if (skel->data->dsq_peek_result2 ==
+	    skel->data->dsq_peek_result2_expected)
+		printf("\u2713 DSQ peek verification success: peek returned the inserted task!\n");
+	else {
+		printf("\u2717 DSQ peek verification failed\n");
+		failed = true;
+	}
+
+	printf("  Inserted test task -> pid: %ld\n", skel->data->dsq_inserted_pid);
+	printf("  DSQ peek result 2 -> pid: %ld\n", skel->data->dsq_peek_result2_pid);
+
+	if (skel->data->dsq_destroy_result != 1) {
+		printf("\u2717 DSQ destroy failed: got %d, expected 1\n",
+		       skel->data->dsq_destroy_result);
+		failed = true;
+	}
+
+	int pid_count;
+
+	pid_count = print_observed_pids(skel->maps.peek_results,
+					skel->data->max_samples, "DSQ pool");
+
+	if (skel->data->debug_ksym_exists && pid_count == 0) {
+		printf("\u2717 DSQ pool test failed: no successful peeks in native mode\n");
+		failed = true;
+	}
+	if (skel->data->debug_ksym_exists && pid_count > 0)
+		printf("\u2713 DSQ pool test success: observed successful peeks in native mode\n");
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
+	if (workload_running) {
+		workload_running = false;
+		for (int i = 0; i < NUM_WORKERS; i++)
+			pthread_join(workload_threads[i], NULL);
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


