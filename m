Return-Path: <linux-kernel+bounces-738182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 971ACB0B581
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 13:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C65A189C892
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0647320E032;
	Sun, 20 Jul 2025 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxFV1Pjc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605171F4168;
	Sun, 20 Jul 2025 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753010638; cv=none; b=ZPZ8P4PlIWL41TqV5DYWH+5RIuAzaKyeXuTZtQAq5NkMdyE3YLI9IP9yzN5L5VsjuxoFJbqlmynSAjL/B8AHk2AUG8z8AOp9tl4TjnNwkhp6zhwozQYh2gf2ljKZT8ANysEAdyoXj/XIhShPgCyOqM/nJkwI+ORR+FoU7eq77Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753010638; c=relaxed/simple;
	bh=qPim9DdbP4b7NY186gk/DEaRqZcO80uudqmQuwg0Rg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbYgnAchklZL8CkDxrlXWVkTjIry9/amKrx3JlRBx0J8aY5CNR+xiYui9FnI+Mk/1nEo8LCP7zMZQw5T13/2MxP8+tzJ/IuvHNYrvNdcO+BETiO8V/ltiExwSYNiOdhihWZXReaRH8KIvFs/yigXs5FHhF9eQqcbrHO61EUdDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxFV1Pjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C44C4CEE7;
	Sun, 20 Jul 2025 11:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753010636;
	bh=qPim9DdbP4b7NY186gk/DEaRqZcO80uudqmQuwg0Rg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxFV1Pjc+48gljdKb81FiZN1xLelYcpoYLACcu89A/OIFz/wZwRCqT4ZIR+Jk69Gu
	 iouFH90aYz/1K5TS/z1VsDTQTpTjUSoxh20S9x72O+3Wzszr4rB/0JS2Imxvv6mLe9
	 TivClCPI62DaeDu/Hwu558nylsVX7dRtVHbZpYOcvO2CtPop9qUOlLfdNNMR22jmCM
	 Uktpq6sw/+ZR8l2c2kxKLSff6fdzZwjs3kT6ZvmYCcF2HwQ3lHUlsvFOLO2jSoIGhp
	 F4K1D2yv9EUk/sVtuJ7uIiq6ACmhbEUt+wRbJAx6CPhaxBknS5ZwWDC0eBt95RakTm
	 GpUlvU+Os8Jjw==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
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
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv6 perf/core 12/22] selftests/bpf: Reorg the uprobe_syscall test function
Date: Sun, 20 Jul 2025 13:21:22 +0200
Message-ID: <20250720112133.244369-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250720112133.244369-1-jolsa@kernel.org>
References: <20250720112133.244369-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding __test_uprobe_syscall with non x86_64 stub to execute all the tests,
so we don't need to keep adding non x86_64 stub functions for new tests.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 34 +++++++------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index b17dc39a23db..a8f00aee7799 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -350,29 +350,8 @@ static void test_uretprobe_shadow_stack(void)
 
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
 }
-#else
-static void test_uretprobe_regs_equal(void)
-{
-	test__skip();
-}
-
-static void test_uretprobe_regs_change(void)
-{
-	test__skip();
-}
-
-static void test_uretprobe_syscall_call(void)
-{
-	test__skip();
-}
 
-static void test_uretprobe_shadow_stack(void)
-{
-	test__skip();
-}
-#endif
-
-void test_uprobe_syscall(void)
+static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
 		test_uretprobe_regs_equal();
@@ -383,3 +362,14 @@ void test_uprobe_syscall(void)
 	if (test__start_subtest("uretprobe_shadow_stack"))
 		test_uretprobe_shadow_stack();
 }
+#else
+static void __test_uprobe_syscall(void)
+{
+	test__skip();
+}
+#endif
+
+void test_uprobe_syscall(void)
+{
+	__test_uprobe_syscall();
+}
-- 
2.50.1


