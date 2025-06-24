Return-Path: <linux-kernel+bounces-701143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7735EAE713D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 23:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7155A0447
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 21:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6255A254B09;
	Tue, 24 Jun 2025 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3XNWT5xR"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D449322A807
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799106; cv=none; b=C7EQGBdblaAYh/bDjyy4yOzkjesC4BPR3xGbtyi17nCtcbY15idmFU65J7PXRHqtZrG/Wu2igJVmC+17RjP6qyeM6T5GqdBNLwu9O3kHvQimfLvFFopnIYeQtz7di/TX/Cn2nn6Evv+UPys0hd1iDngQZKyedYDx9b/ZRaG/cEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799106; c=relaxed/simple;
	bh=Wa15KBPHKYpjSiH0ZB1f/hcrK1ekcjNJYu3JI25ijHc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Y3IP5cK7g7O+cS1HCgLUiI6rR9ZLOtSCVKTGaKinSeOozBMrbKFh4N9RiBaORNqi2OVNwn2873jxYtqBOfEg34ctTGqw9U8jTxm9KBd/pZHnEi86loKQnN++g97dQBp0SCapvBMAoa46UEgTiYeaGKpcB5aDbVwbyUkGz+6t7O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3XNWT5xR; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c36951518so1089956a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750799104; x=1751403904; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uR1hz3ksNJh6sj5n+ugCpCRJip2wiGGNB4SniRPrzgc=;
        b=3XNWT5xRen1ujRn/2CwSupf2zwWe7pKQbfhRwNHXZh3uptXWOAN/++6Za/+kX8Df33
         X1fZcKo33PX18X8AhH/0GExanFC4oYQcEQD6xq2YaRku12d106gLFc/5gKVBjM7pc6xn
         Ujf/Hc5l0TqK8uYUmZov0nOJjHEglQqC2JxGUyQNekRKZU0zZp64KWNLhmHC0n1GgEgi
         nVzeptiGDttcWSvEuQOGS0keaiLUqIBwVTzYiuO++oAkumg6Bhr1vLAaL7c3F68ExSZi
         vQG9E7GezwFJ1iINPCbB/p83IrVi2doEl1ROTRt5JYmibaaqEQLjDa/gfsTf2LPdTFfV
         G/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750799104; x=1751403904;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uR1hz3ksNJh6sj5n+ugCpCRJip2wiGGNB4SniRPrzgc=;
        b=s6leNJ0Lq7ZTrXqk+x/OF5pPQ+pIgHulvQH0l+OarDmIUu4EivqQBEr5NsYT91TQFv
         taf6ZdxTov4RTQF/+yfRxCgNCB3k/XMjOLryeJtDtSpbF0C9rdjANkrnaFqCFU1XLw30
         PnFMd7i0R5jp7lj3B3/KlCDn2zHfvGnp0cHQDcyxUzPRE5wZJuLQsUzlwXUFWSu5DoWy
         L8Vv7VprMmLzFGqQQCOu6SvpgiVQA5quLySBIY+FMgoCBx6t04BHeOlcGbhnzxdHYLis
         U0nisCpzafENd6RGJqsGCsIo5wZZjCq6gWKAuoZh0Ulk7Lrj+5l7gllAShgzngo5c9zh
         9xrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2vQ4OQUWH8VLVZzPstf1HCGNFpLZr+JODhjYTwIq6IlKpfk4U6LTeuwhl9ewwa5ZQ9Lx/noRr1HzgY6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+GUb9VeaARmBnbTrLqpU+lEHi31lvc5BEf/GDqtwmhwtVSJg
	dtT4suEIHmfSZGATr+u355YH+hlkg9OCZx2tv1vee3zzVgC1llZzHSmcfxDNEMjsPpy7SRWvmba
	W51nn/LtVeA==
X-Google-Smtp-Source: AGHT+IGxIaDAhsJKac3xtAJJrKrHHPGnMHmo7Ti+2bu4mPpKEUkhNTnOR9JEF5DEgzMMquqDEpRrP0WGaLR7
X-Received: from pgbbz5.prod.google.com ([2002:a05:6a02:605:b0:b2e:c392:14f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6e19:b0:21a:efe4:5c6f
 with SMTP id adf61e73a8af0-2207f14bc75mr488447637.2.1750799104145; Tue, 24
 Jun 2025 14:05:04 -0700 (PDT)
Date: Tue, 24 Jun 2025 14:05:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250624210500.2121303-1-irogers@google.com>
Subject: [PATCH v5] perf debug: Add function symbols to dump_stack
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Symbolize stack traces by creating a live machine. Add this
functionality to dump_stack and switch dump_stack users to use
it. Switch TUI to use it. Add stack traces to the child test function
which can be useful to diagnose blocked code.

Example output:
```
$ perf test -vv PERF_RECORD_
...
  7: PERF_RECORD_* events & perf_sample fields:
  7: PERF_RECORD_* events & perf_sample fields                       : Running (1 active)
^C
Signal (2) while running tests.
Terminating tests with the same signal
Internal test harness failure. Completing any started tests:
:  7: PERF_RECORD_* events & perf_sample fields:

---- unexpected signal (2) ----
    #0 0x55788c6210a3 in child_test_sig_handler builtin-test.c:0
    #1 0x7fc12fe49df0 in __restore_rt libc_sigaction.c:0
    #2 0x7fc12fe99687 in __internal_syscall_cancel cancellation.c:64
    #3 0x7fc12fee5f7a in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:72
    #4 0x7fc12fef1393 in __nanosleep nanosleep.c:26
    #5 0x7fc12ff02d68 in __sleep sleep.c:55
    #6 0x55788c63196b in test__PERF_RECORD perf-record.c:0
    #7 0x55788c620fb0 in run_test_child builtin-test.c:0
    #8 0x55788c5bd18d in start_command run-command.c:127
    #9 0x55788c621ef3 in __cmd_test builtin-test.c:0
    #10 0x55788c6225bf in cmd_test ??:0
    #11 0x55788c5afbd0 in run_builtin perf.c:0
    #12 0x55788c5afeeb in handle_internal_command perf.c:0
    #13 0x55788c52b383 in main ??:0
    #14 0x7fc12fe33ca8 in __libc_start_call_main libc_start_call_main.h:74
    #15 0x7fc12fe33d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
    #16 0x55788c52b9d1 in _start ??:0

---- unexpected signal (2) ----
    #0 0x55788c6210a3 in child_test_sig_handler builtin-test.c:0
    #1 0x7fc12fe49df0 in __restore_rt libc_sigaction.c:0
    #2 0x7fc12fea3a14 in pthread_sigmask@GLIBC_2.2.5 pthread_sigmask.c:45
    #3 0x7fc12fe49fd9 in __GI___sigprocmask sigprocmask.c:26
    #4 0x7fc12ff2601b in __longjmp_chk longjmp.c:36
    #5 0x55788c6210c0 in print_test_result.isra.0 builtin-test.c:0
    #6 0x7fc12fe49df0 in __restore_rt libc_sigaction.c:0
    #7 0x7fc12fe99687 in __internal_syscall_cancel cancellation.c:64
    #8 0x7fc12fee5f7a in clock_nanosleep@GLIBC_2.2.5 clock_nanosleep.c:72
    #9 0x7fc12fef1393 in __nanosleep nanosleep.c:26
    #10 0x7fc12ff02d68 in __sleep sleep.c:55
    #11 0x55788c63196b in test__PERF_RECORD perf-record.c:0
    #12 0x55788c620fb0 in run_test_child builtin-test.c:0
    #13 0x55788c5bd18d in start_command run-command.c:127
    #14 0x55788c621ef3 in __cmd_test builtin-test.c:0
    #15 0x55788c6225bf in cmd_test ??:0
    #16 0x55788c5afbd0 in run_builtin perf.c:0
    #17 0x55788c5afeeb in handle_internal_command perf.c:0
    #18 0x55788c52b383 in main ??:0
    #19 0x7fc12fe33ca8 in __libc_start_call_main libc_start_call_main.h:74
    #20 0x7fc12fe33d65 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
    #21 0x55788c52b9d1 in _start ??:0
  7: PERF_RECORD_* events & perf_sample fields                       : Skip (permissions)
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
v5: Fix v3/v4 by rebasing v2 rather than v1 patch series. Add
    uintptr_t cast to avoid -Werror=pointer-to-int-cast (Namhyung)
v4: Additional addr_location__exit (Namhyung)
v3: Rebase
v2: Fix NO_BACKTRACE=1 build (Arnaldo)
---
 tools/perf/tests/builtin-test.c | 15 +++++++-
 tools/perf/ui/tui/setup.c       |  2 +-
 tools/perf/util/debug.c         | 68 +++++++++++++++++++++++++++------
 tools/perf/util/debug.h         |  1 +
 4 files changed, 73 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 45d3d8b3317a..80375ca39a37 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -6,6 +6,9 @@
  */
 #include <fcntl.h>
 #include <errno.h>
+#ifdef HAVE_BACKTRACE_SUPPORT
+#include <execinfo.h>
+#endif
 #include <poll.h>
 #include <unistd.h>
 #include <setjmp.h>
@@ -231,6 +234,16 @@ static jmp_buf run_test_jmp_buf;
 
 static void child_test_sig_handler(int sig)
 {
+#ifdef HAVE_BACKTRACE_SUPPORT
+	void *stackdump[32];
+	size_t stackdump_size;
+#endif
+
+	fprintf(stderr, "\n---- unexpected signal (%d) ----\n", sig);
+#ifdef HAVE_BACKTRACE_SUPPORT
+	stackdump_size = backtrace(stackdump, ARRAY_SIZE(stackdump));
+	__dump_stack(stderr, stackdump, stackdump_size);
+#endif
 	siglongjmp(run_test_jmp_buf, sig);
 }
 
@@ -244,7 +257,7 @@ static int run_test_child(struct child_process *process)
 
 	err = sigsetjmp(run_test_jmp_buf, 1);
 	if (err) {
-		fprintf(stderr, "\n---- unexpected signal (%d) ----\n", err);
+		/* Received signal. */
 		err = err > 0 ? -err : -1;
 		goto err_out;
 	}
diff --git a/tools/perf/ui/tui/setup.c b/tools/perf/ui/tui/setup.c
index 16c6eff4d241..022534eed68c 100644
--- a/tools/perf/ui/tui/setup.c
+++ b/tools/perf/ui/tui/setup.c
@@ -108,7 +108,7 @@ static void ui__signal_backtrace(int sig)
 
 	printf("-------- backtrace --------\n");
 	size = backtrace(stackdump, ARRAY_SIZE(stackdump));
-	backtrace_symbols_fd(stackdump, size, STDOUT_FILENO);
+	__dump_stack(stdout, stackdump, size);
 
 	exit(0);
 }
diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index f9ef7d045c92..2878a7363ac8 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -14,11 +14,18 @@
 #ifdef HAVE_BACKTRACE_SUPPORT
 #include <execinfo.h>
 #endif
+#include "addr_location.h"
 #include "color.h"
-#include "event.h"
 #include "debug.h"
+#include "event.h"
+#include "machine.h"
+#include "map.h"
 #include "print_binary.h"
+#include "srcline.h"
+#include "symbol.h"
+#include "synthetic-events.h"
 #include "target.h"
+#include "thread.h"
 #include "trace-event.h"
 #include "ui/helpline.h"
 #include "ui/ui.h"
@@ -298,21 +305,60 @@ void perf_debug_setup(void)
 	libapi_set_print(pr_warning_wrapper, pr_warning_wrapper, pr_debug_wrapper);
 }
 
+void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size)
+{
+	/* TODO: async safety. printf, malloc, etc. aren't safe inside a signal handler. */
+	pid_t pid = getpid();
+	struct machine *machine = machine__new_live(/*kernel_maps=*/false, pid);
+	struct thread *thread = NULL;
+
+	if (machine)
+		thread = machine__find_thread(machine, pid, pid);
+
+#ifdef HAVE_BACKTRACE_SUPPORT
+	if (!machine || !thread) {
+		/*
+		 * Backtrace functions are async signal safe. Fall back on them
+		 * if machine/thread creation fails.
+		 */
+		backtrace_symbols_fd(stackdump, stackdump_size, fileno(file));
+		machine__delete(machine);
+		return;
+	}
+#endif
+
+	for (size_t i = 0; i < stackdump_size; i++) {
+		struct addr_location al;
+		u64 addr = (u64)(uintptr_t)stackdump[i];
+		bool printed = false;
+
+		addr_location__init(&al);
+		if (thread && thread__find_map(thread, PERF_RECORD_MISC_USER, addr, &al)) {
+			al.sym = map__find_symbol(al.map, al.addr);
+			if (al.sym) {
+				fprintf(file, "    #%zd %p in %s ", i, stackdump[i], al.sym->name);
+				printed = true;
+			}
+		}
+		if (!printed)
+			fprintf(file, "    #%zd %p ", i, stackdump[i]);
+
+		map__fprintf_srcline(al.map, al.addr, "", file);
+		fprintf(file, "\n");
+		addr_location__exit(&al);
+	}
+	thread__put(thread);
+	machine__delete(machine);
+}
+
 /* Obtain a backtrace and print it to stdout. */
 #ifdef HAVE_BACKTRACE_SUPPORT
 void dump_stack(void)
 {
-	void *array[16];
-	size_t size = backtrace(array, ARRAY_SIZE(array));
-	char **strings = backtrace_symbols(array, size);
-	size_t i;
-
-	printf("Obtained %zd stack frames.\n", size);
-
-	for (i = 0; i < size; i++)
-		printf("%s\n", strings[i]);
+	void *stackdump[32];
+	size_t size = backtrace(stackdump, ARRAY_SIZE(stackdump));
 
-	free(strings);
+	__dump_stack(stdout, stackdump, size);
 }
 #else
 void dump_stack(void) {}
diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index a4026d1fd6a3..6b737e195ce1 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -85,6 +85,7 @@ void debug_set_display_time(bool set);
 void perf_debug_setup(void);
 int perf_quiet_option(void);
 
+void __dump_stack(FILE *file, void **stackdump, size_t stackdump_size);
 void dump_stack(void);
 void sighandler_dump_stack(int sig);
 
-- 
2.50.0.714.g196bf9f422-goog


