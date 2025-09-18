Return-Path: <linux-kernel+bounces-808176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A427B4FB7E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157C03BF2B5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C723375DA;
	Tue,  9 Sep 2025 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdpnaDqS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E44132A3D7;
	Tue,  9 Sep 2025 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421613; cv=none; b=upQYzFJXJAUM81PL2Oln+JGy6y8Cg9HXcB8/gileAPdaS6qKqbjIxKUjpVJfduZrMRm+XuUS813viUaR6K9SXUCIV+atRDm9f8VBrGKkhAn+gNQpEHJPb8mD/wuMxmZKGqLswP71wCEeJ6Oe/aE3q6jjcsh/rIrFV+oZU7ZxxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421613; c=relaxed/simple;
	bh=E0pyzzXc5ywisIehqLd9QVqn8ohz0R6l3t8a5bN6GPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjuqdS9xrcK+Ysv1OpfDwdxgtPo7Zh5JYsC+RCCc35k0CMa+u4E2O9xwQ7mlO5HadeJQhGC6DIcBfRU4xqk948zUoRNYBdLkyE5C7U2gO8duGLOZzt98qUYUtFHXiqniYK5tKximFgE9cHRq25TCpt4wR9Gs3Azan3bEwJmr22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdpnaDqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B11DC4CEF4;
	Tue,  9 Sep 2025 12:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757421612;
	bh=E0pyzzXc5ywisIehqLd9QVqn8ohz0R6l3t8a5bN6GPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NdpnaDqSV+cIrUEa0xp48dPO9/HLwy2WjTn/gdyoiBwiV03w8my8dnDSlWtX5pcy0
	 tKUuU78gwaXUDoL5kHeSumgsXw5rGiWb8FuRqjOqQFHQypt/ZsAF87cu0iLh4XPMVB
	 oKatSJuVKW3KvmOzHN+T0xqYen9FVEstV4fWndAFoyoGhh76EcmAnEp44sbGMeDd6W
	 NmwCYWVpnoV6tTCJdlWXWxnqhmEX88MW3bCXhH4y8I4bjUsDdR37Ssaeb5R/uRrqd+
	 vFkW7+0oxAhr9y7tHWSEQpF/u42j5BVrfki6M31XSlMEkTUi6RX0QQpp7FH+KfpWPH
	 1uyWd42IlBOqw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv3 perf/core 6/6] selftests/bpf: Add kprobe multi write ctx attach test
Date: Tue,  9 Sep 2025 14:38:57 +0200
Message-ID: <20250909123857.315599-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909123857.315599-1-jolsa@kernel.org>
References: <20250909123857.315599-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test to check we can't attach kprobe multi program
that writes to the context.

It's x86_64 specific test.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 27 +++++++++++++++++++
 .../selftests/bpf/progs/kprobe_write_ctx.c    |  7 +++++
 2 files changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index e19ef509ebf8..bc52389217e2 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -7,6 +7,7 @@
 #include "kprobe_multi_session.skel.h"
 #include "kprobe_multi_session_cookie.skel.h"
 #include "kprobe_multi_verifier.skel.h"
+#include "kprobe_write_ctx.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -753,6 +754,30 @@ static void test_attach_override(void)
 	kprobe_multi_override__destroy(skel);
 }
 
+#ifdef __x86_64__
+static void test_attach_write_ctx(void)
+{
+	struct kprobe_write_ctx *skel = NULL;
+	struct bpf_link *link = NULL;
+
+	skel = kprobe_write_ctx__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_write_ctx__open_and_load"))
+		return;
+
+	link = bpf_program__attach_kprobe_opts(skel->progs.kprobe_multi_write_ctx,
+						     "bpf_fentry_test1", NULL);
+	if (!ASSERT_ERR_PTR(link, "bpf_program__attach_kprobe_opts"))
+		bpf_link__destroy(link);
+
+	kprobe_write_ctx__destroy(skel);
+}
+#else
+static void test_attach_write_ctx(void)
+{
+	test__skip();
+}
+#endif
+
 void serial_test_kprobe_multi_bench_attach(void)
 {
 	if (test__start_subtest("kernel"))
@@ -792,5 +817,7 @@ void test_kprobe_multi_test(void)
 		test_session_cookie_skel_api();
 	if (test__start_subtest("unique_match"))
 		test_unique_match();
+	if (test__start_subtest("attach_write_ctx"))
+		test_attach_write_ctx();
 	RUN_TESTS(kprobe_multi_verifier);
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c b/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
index 4621a5bef4e2..f77aef0474d3 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
@@ -12,4 +12,11 @@ int kprobe_write_ctx(struct pt_regs *ctx)
 	ctx->ax = 0;
 	return 0;
 }
+
+SEC("kprobe.multi")
+int kprobe_multi_write_ctx(struct pt_regs *ctx)
+{
+	ctx->ax = 0;
+	return 0;
+}
 #endif
-- 
2.51.0


