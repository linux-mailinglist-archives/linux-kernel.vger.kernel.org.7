Return-Path: <linux-kernel+bounces-864433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBD6BFACAB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F7718C6E18
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CB430147E;
	Wed, 22 Oct 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT+7p63A"
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581202FD66C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120385; cv=none; b=R0KJAu9pp+H/SqOebt3nAIb8Nx/7NXwd5G+6tV0xwHryeUTJCqME7Bh1TR3u2d7UVQJ0yrrUrq+aIFGUxWAvzYtCQ0QCs+gkmej+Auwju7qdMVS6zCAEYf2yg6052S9wDHIrdACXRc2G4LaMAGkXnWOgCPTp30gg7NLlBrqCKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120385; c=relaxed/simple;
	bh=11h9/7cLSx4w9Nlnk3G5SzB3wO2oo6urxq94rUmhgIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3Cl+SAq1V1V4CI89wB59+paYrh6frub8YBpEMy3vjaXeota5jl25g7q1wkQabGS23K0ZfEN5pNfKJO5AI37udzmKONoxzmWQWxZuvvQtO5tdGWeWUcwg4iEPzn9NIEQiyIpIeIQG7DRfwBMMxjcv6g4WRkqicxcDBT71AFu4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT+7p63A; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso5831838a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120382; x=1761725182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7pd1xamI1Z87Z/xGHN+zpZ0EaiU7Q5JCHed+8W4tHa8=;
        b=OT+7p63A8dISxStTvo9VrMpayqSkKAjaP1vSYqkVnPTCZd63OD5So4W/qdMytcc5JV
         RPpef6kzJf3PsKWDy9CssdnYD1lko9oVffl0irluGLkB0WMoV96K1KMdPX6eYFOpE79R
         uIH+zEh1XQyeWsEIfm1gL4VaQM8FtzNgrMQ7zKLOl7X6d9LIJnk9fSYnf7Vs+mvgGni8
         zx8S8jiIkzlOX7r5Tao4NET6l/ob2SvDodsizlT/EadDIgxFdsjkOmgjJVzsRvoEMe/r
         U7efk7mq6X2fY9bMIN0Sposqgmqt2irN65wIqCQmH8KeYwnZsAAJunp4qHwHwb5bbpiO
         nwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120382; x=1761725182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pd1xamI1Z87Z/xGHN+zpZ0EaiU7Q5JCHed+8W4tHa8=;
        b=LFz0OCITVMLhZ0+0KeHCg32h1rZKaf3WxNBcZlshFK6y2mW/8OjavutVFDoj/a6wSe
         sVEsIeCXrg5C3gFZzaaKrljtPL8U9oBTFV2RTr2D07At/EaGYVuw5yXZ+qfyA1jwSJh8
         V2x1oRebps2iTdFV4U/zfLM/GHVtvTyTcIQ+vFz+QL1f2DUVwZGJaDTVQxnOGoztUnEU
         6qqtjXb6Qq7na3Dre4B+lhdijLs+w4GJ2vi6au+1XZMHjW4vW4ZlLDR9c5hsbrEUTkGE
         waa7RnOnuLrsbafZMsU6mr6t7vZeQQwxUyOOG4DRt0XRNHIKrJFMWIXNHRcrpR1Y2bCR
         aMQA==
X-Forwarded-Encrypted: i=1; AJvYcCXnz3/lDbwDLaT+T2sF0fCBRRw6EiVGsp/6SnP0vTWAhCCIpmeAkJzE9IPj2ULWC6ZNJy8U/FHtXR/sBWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwueRQJwRc+fjPtywvQBZ0w36T7NLoUUvWlT3/dCKyNyqa+0Lam
	Trp8bu55jlrJrZSSGQ9au0yh+eiPaXe0lFRuc7xbtk9IXZMqfdHdyw0f
X-Gm-Gg: ASbGnctzNQItBo8EQcHQFz5Q1Ip8DBSiPlfRjthbRpuWZkzo5eCKh065uYIAxeFtyf1
	pR1vIzOKCbL1DBWSCZx9Amgncy25v2hUjil35/N/Pge8Bwt3ZtMzH8MlvxliHXnC3KrU97ZK9PT
	d0J6juRvu69GcwM5e0YOpXwKtepa8uy0V4hwzF7HIlKWbcpUWWxRvcE/5BP8SdorfNR5hgLrUnX
	f7sKsABYh04Qg4z3oSiQxXIIeSjiuVCgIGC6Crqr2CkbNThs5oLra/N5/UKoHsvBzKt4XBfIV1V
	r58F+LoURfzwcaUouxjYQPgsSyWXiDpDV5O9MraQFrPiOzC8dBB0Qpeu1xx7xVdtLQ6my/O9VNN
	g+WWo+PzEk19Y2xLZmT6v0KCQURcEc0h/qo48p4QfHHvpv7A/AS/S2luObNoCJEMRpx+sA7/6gv
	afKhmBBj0=
X-Google-Smtp-Source: AGHT+IE70+TREWXzMJPqDOGvy7TIW4dMzKInSqb2lFkSA22INPn9248XY9+0iTdOyzuydSqJYdoiQQ==
X-Received: by 2002:a17:90b:3942:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-33bcf87ab20mr29204108a91.12.1761120382423;
        Wed, 22 Oct 2025 01:06:22 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223c7fb5sm1805330a91.2.2025.10.22.01.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:06:21 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 08/10] selftests/bpf: add testcases for tracing session
Date: Wed, 22 Oct 2025 16:06:11 +0800
Message-ID: <20251022080613.555463-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testcases for BPF_TRACE_SESSION.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/prog_tests/fsession_test.c  |  95 ++++++++++
 .../selftests/bpf/progs/fsession_test.c       | 175 ++++++++++++++++++
 2 files changed, 270 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
new file mode 100644
index 000000000000..d70bdb683691
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <test_progs.h>
+#include "fsession_test.skel.h"
+
+static int check_result(struct fsession_test *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	/* Trigger test function calls */
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return err;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return topts.retval;
+
+	for (int i = 0; i < sizeof(*skel->bss) / sizeof(__u64); i++) {
+		if (!ASSERT_EQ(((__u64 *)skel->bss)[i], 1, "test_result"))
+			return -EINVAL;
+	}
+
+	/* some fields go to the "data" sections, not "bss" */
+	for (int i = 0; i < sizeof(*skel->data) / sizeof(__u64); i++) {
+		if (!ASSERT_EQ(((__u64 *)skel->data)[i], 1, "test_result"))
+			return -EINVAL;
+	}
+	return 0;
+}
+
+static void test_fsession_basic(void)
+{
+	struct fsession_test *skel = NULL;
+	int err;
+
+	skel = fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
+		goto cleanup;
+
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_attach"))
+		goto cleanup;
+
+	check_result(skel);
+cleanup:
+	fsession_test__destroy(skel);
+}
+
+static void test_fsession_reattach(void)
+{
+	struct fsession_test *skel = NULL;
+	int err;
+
+	skel = fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
+		goto cleanup;
+
+	/* First attach */
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_first_attach"))
+		goto cleanup;
+
+	if (check_result(skel))
+		goto cleanup;
+
+	/* Detach */
+	fsession_test__detach(skel);
+
+	/* Reset counters */
+	memset(skel->bss, 0, sizeof(*skel->bss));
+
+	/* Second attach */
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_second_attach"))
+		goto cleanup;
+
+	if (check_result(skel))
+		goto cleanup;
+
+cleanup:
+	fsession_test__destroy(skel);
+}
+
+void test_fsession_test(void)
+{
+#if !defined(__x86_64__)
+	test__skip();
+	return;
+#endif
+	if (test__start_subtest("fsession_basic"))
+		test_fsession_basic();
+	if (test__start_subtest("fsession_reattach"))
+		test_fsession_reattach();
+}
diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
new file mode 100644
index 000000000000..3a756272374d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_entry_result = 0;
+__u64 test1_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test1, int a, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		/* This is entry */
+		test1_entry_result = a == 1 && ret == 0;
+		/* Return 0 to allow exit to be called */
+		return 0;
+	}
+
+	/* This is exit */
+	test1_exit_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test2_entry_result = 0;
+__u64 test2_exit_result = 1;
+
+SEC("fsession/bpf_fentry_test2")
+int BPF_PROG(test2, int a, __u64 b, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		/* This is entry */
+		test2_entry_result = a == 2 && b == 3 && ret == 0;
+		/* Return non-zero value to block exit call */
+		return 1;
+	}
+
+	/* This is exit - should not be called due to blocking */
+	test2_exit_result = 0;
+	return 0;
+}
+
+__u64 test3_entry_result = 0;
+__u64 test3_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test3")
+int BPF_PROG(test3, char a, int b, __u64 c, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test3_entry_result = a == 4 && b == 5 && c == 6 && ret == 0;
+		return 0;
+	}
+
+	test3_exit_result = a == 4 && b == 5 && c == 6 && ret == 15;
+	return 0;
+}
+
+__u64 test4_entry_result = 0;
+__u64 test4_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test4")
+int BPF_PROG(test4, void *a, char b, int c, __u64 d, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test4_entry_result = a == (void *)7 && b == 8 && c == 9 && d == 10 && ret == 0;
+		return 0;
+	}
+
+	test4_exit_result = a == (void *)7 && b == 8 && c == 9 && d == 10 && ret == 34;
+	return 0;
+}
+
+__u64 test5_entry_result = 0;
+__u64 test5_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test5")
+int BPF_PROG(test5, __u64 a, void *b, short c, int d, __u64 e, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test5_entry_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+			e == 15 && ret == 0;
+		return 0;
+	}
+
+	test5_exit_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+		e == 15 && ret == 65;
+	return 0;
+}
+
+__u64 test6_entry_result = 0;
+__u64 test6_exit_result = 1;
+
+SEC("fsession/bpf_fentry_test6")
+int BPF_PROG(test6, __u64 a, void *b, short c, int d, void *e, __u64 f, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test6_entry_result = a == 16 && b == (void *)17 && c == 18 && d == 19 &&
+			e == (void *)20 && f == 21 && ret == 0;
+		return 1;
+	}
+
+	test6_exit_result = 0;
+	return 0;
+}
+
+__u64 test7_entry_result = 0;
+__u64 test7_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test7")
+int BPF_PROG(test7, struct bpf_fentry_test_t *arg, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		if (!arg)
+			test7_entry_result = ret == 0;
+		return 0;
+	}
+
+	if (!arg)
+		test7_exit_result = 1;
+	return 0;
+}
+
+__u64 test8_entry_result = 0;
+__u64 test8_exit_result = 1;
+/*
+ * test1, test8 and test9 hook the same target to verify the "ret" is always
+ * 0 in the entry.
+ */
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test8, int a, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test8_entry_result = a == 1 && ret == 0;
+		return -21;
+	}
+
+	/* This is exit */
+	test8_exit_result = 0;
+	return 0;
+}
+
+__u64 test9_entry_result = 0;
+__u64 test9_exit_result = 1;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test9, int a, int ret)
+{
+	bool is_exit = bpf_tracing_is_exit(ctx);
+
+	if (!is_exit) {
+		test9_entry_result = a == 1 && ret == 0;
+		return -22;
+	}
+
+	test9_exit_result = 0;
+	return 0;
+}
-- 
2.51.1.dirty


