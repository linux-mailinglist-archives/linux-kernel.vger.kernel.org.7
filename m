Return-Path: <linux-kernel+bounces-627581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23616AA52F5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 19:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBF44A7784
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 17:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA71274FE0;
	Wed, 30 Apr 2025 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXvRcoVa"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE862620D2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746035465; cv=none; b=XGQbBqjUhstfEGEGVy51d/wYk7Ang0iyQ/MZcsWhhbAVTOK2RCLeLPzhSsITBrfnbp2whG1qoIX+ppeCcqy9txD08pw98txVTyJVuAcecNuPWAPICUHkp2dRXfrArCMFlhQDFusC0Ed7lsBpe1uj5hXPkQnh2VixICyc49yuw00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746035465; c=relaxed/simple;
	bh=Cpj7SfLJpeZm5X2ThA9QdOhm/ocHRn1C/cM/8eJqfTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D9xfpkzznEhdRCWumBy+ZSnjbekJBtBTMZE9N/N9Jbu/z6QeXApKIe75MCNlE2x6AKQDaK27optYrS7/W1Y3uCHSu1LfrJGAoPKieJO86bWD4rznXU9EBKTlc2Fsi3ZBLxDMGKfwMJ5LLanpDIUJ/I37LhDyR2WIZvIrKHk7gs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cXvRcoVa; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-306b51e30ffso128208a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 10:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746035463; x=1746640263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r8RvdQ8SFq1KIeP+jGDhxuv/Zk6eXkFP72n3ZgWDiV8=;
        b=cXvRcoVaZRkFaz6EUhhIe/GMvTPgAIRMCntFwoFH714DYE/5BLBw8e4qLCfFndbMND
         MqmmqFlDin05ORP1kD0xdNdd6pRMSUHYrDv8XCFlPYBMySE9hQMBK+gqSnKM4HuvrxY1
         Vr5hCo/sCrwrxZaIKsFfqiNrJMFiWdG+CLbpFgNyY5etKa7XpVKxc1acOvzNykZi+Ung
         PNMEIyF3A0wNXmtJsG9gL+u8VikK5ypB/wAU/+jP+avFh9qlFc64IyjVX+/dm8w1J0pu
         N2ehOO6RM7+sF+UonhgePp0W278LGPkxDoEi5xQTE9XwtmO1+Ct0NZN4rfwWbkGZOE2y
         QhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746035463; x=1746640263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8RvdQ8SFq1KIeP+jGDhxuv/Zk6eXkFP72n3ZgWDiV8=;
        b=iF7iShX55dFIsDvdybintgsG11ILxmz26U4gF+7JH+Aoy04kZfVojYKvRTmw6FbGpS
         LqumIgpxwcYqeitQ9/e2f1w1DFHKxk8cxW3fzmXG1GnAlPVnVH3ChFcouWpO0DSNOxtH
         zuF9JEVthe3hEcDMHWREsUUIZtbQ3KvqKkSvQTPEt9/1FMpRwcUVGmV6cKB6smLOtzQm
         WcTl+BfS0KBPrTalDw6eQHV9C7GPjA6tnSjrev9STI0Pifb/BcLxZnnlOJIqoE8pD3NF
         dtROkmpHLOM9JRxDHtW1t31WiwmTxDZzTPAScCaQrTzmsdVV7HH0QRXFzGzTJImwp221
         Btaw==
X-Forwarded-Encrypted: i=1; AJvYcCWuSGmEoehYyKQ/9V/yAYcu6wteTFls1jJFNVquhmHlSW0PpEJtyf5jTFQePnf8oGwmONYiSqL2vwxjwbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfXDx7CHEotSfXP5Y+wXgMIzrFeAKVu8vx0ftnA+kajHKJx04u
	yW9lqYv/GLslpU9cBm5E5GNsQ59Y3vZiNkcbPI+wT4EVkod/eaEFqNyKJUF0iAmmNs8qrVCuuSQ
	JNtUSjA==
X-Google-Smtp-Source: AGHT+IGl9FerxjPNZ4o8UL0bzBuP1N0O24NwppnmAtvcSdHMHT9Q9beF3u5qr3WvfKO++NCR4yzPkdEF/vPY
X-Received: from pjgg8.prod.google.com ([2002:a17:90b:57c8:b0:2f5:63a:4513])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17cd:b0:2ee:cded:9ac7
 with SMTP id 98e67ed59e1d1-30a3331ee0bmr5422318a91.20.1746035462064; Wed, 30
 Apr 2025 10:51:02 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:49:50 -0700
In-Reply-To: <20250430175036.184610-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250430175036.184610-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250430175036.184610-3-irogers@google.com>
Subject: [PATCH v2 02/47] perf tests: Silence -Wshorten-64-to-32 warnings
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Eder Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, 
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Howard Chu <howardchu95@gmail.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andrew Kreimer <algonell@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The clang warning -Wshorten-64-to-32 can be useful to catch
inadvertent truncation. In some instances this truncation can lead to
changing the sign of a result, for example, truncation to return an
int to fit a sort routine. Silence the warning by making the implicit
truncation explicit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/api-io.c                   |  2 +-
 tools/perf/tests/bp_signal.c                |  6 +++---
 tools/perf/tests/bp_signal_overflow.c       |  6 +++---
 tools/perf/tests/builtin-test.c             |  9 +++++----
 tools/perf/tests/code-reading.c             |  4 ++--
 tools/perf/tests/dso-data.c                 | 10 +++++-----
 tools/perf/tests/mmap-thread-lookup.c       |  2 +-
 tools/perf/tests/openat-syscall-tp-fields.c |  2 +-
 tools/perf/tests/pmu-events.c               |  2 +-
 tools/perf/tests/sigtrap.c                  |  4 ++--
 tools/perf/tests/switch-tracking.c          | 11 ++++++-----
 tools/perf/tests/vmlinux-kallsyms.c         |  4 ++--
 tools/perf/tests/wp.c                       |  4 ++--
 13 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/tools/perf/tests/api-io.c b/tools/perf/tests/api-io.c
index 0ba3d5ccebcf..4aee1cff062e 100644
--- a/tools/perf/tests/api-io.c
+++ b/tools/perf/tests/api-io.c
@@ -74,7 +74,7 @@ static int setup_test(char path[PATH_MAX], const char *contents,
 		unlink(path);
 		return -1;
 	}
-	io__init(io, io->fd, io->buf, buf_size);
+	io__init(io, io->fd, io->buf, (unsigned int)buf_size);
 	return 0;
 }
 
diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 3faeb5b6fe0b..5ecac6c2d8b6 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -64,7 +64,7 @@ static noinline int test_function(void)
 {
 	__test_function(&the_var);
 	the_var++;
-	return time(NULL);
+	return (int)time(NULL);
 }
 
 static void sig_handler_2(int signum __maybe_unused,
@@ -151,11 +151,11 @@ static int wp_event(void *addr, int sig)
 static long long bp_count(int fd)
 {
 	long long count;
-	int ret;
+	ssize_t ret;
 
 	ret = read(fd, &count, sizeof(long long));
 	if (ret != sizeof(long long)) {
-		pr_debug("failed to read: %d\n", ret);
+		pr_debug("failed to read: %zd\n", ret);
 		return TEST_FAIL;
 	}
 
diff --git a/tools/perf/tests/bp_signal_overflow.c b/tools/perf/tests/bp_signal_overflow.c
index ee560e156be6..eb9021ad8177 100644
--- a/tools/perf/tests/bp_signal_overflow.c
+++ b/tools/perf/tests/bp_signal_overflow.c
@@ -33,7 +33,7 @@ static int overflows;
 
 static noinline int test_function(void)
 {
-	return time(NULL);
+	return (int)time(NULL);
 }
 
 static void sig_handler(int signum __maybe_unused,
@@ -46,11 +46,11 @@ static void sig_handler(int signum __maybe_unused,
 static long long bp_count(int fd)
 {
 	long long count;
-	int ret;
+	ssize_t ret;
 
 	ret = read(fd, &count, sizeof(long long));
 	if (ret != sizeof(long long)) {
-		pr_debug("failed to read: %d\n", ret);
+		pr_debug("failed to read: %zd\n", ret);
 		return TEST_FAIL;
 	}
 
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 14d30a5053be..4ea840580876 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -301,7 +301,7 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 	return 0;
 }
 
-static void finish_test(struct child_test **child_tests, int running_test, int child_test_num,
+static void finish_test(struct child_test **child_tests, size_t running_test, size_t child_test_num,
 		int width)
 {
 	struct child_test *child_test = child_tests[running_test];
@@ -349,7 +349,7 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 		if (perf_use_color_default) {
 			int running = 0;
 
-			for (int y = running_test; y < child_test_num; y++) {
+			for (size_t y = running_test; y < child_test_num; y++) {
 				if (child_tests[y] == NULL)
 					continue;
 				if (check_if_command_finished(&child_tests[y]->process) == 0)
@@ -478,13 +478,14 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 	int err = 0;
 
 	for (struct test_suite **t = suites; *t; t++) {
-		int i, len = strlen(test_description(*t, -1));
+		int i;
+		int len = (int)strlen(test_description(*t, -1));
 
 		if (width < len)
 			width = len;
 
 		test_suite__for_each_test_case(*t, i) {
-			len = strlen(test_description(*t, i));
+			len = (int)strlen(test_description(*t, i));
 			if (width < len)
 				width = len;
 			num_tests += runs_per_test;
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index cf6edbe697b2..0c31d5ff77e2 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -188,7 +188,7 @@ static int objdump_version(void)
 	char *line = NULL;
 	const char *fmt;
 	FILE *f;
-	int ret;
+	ssize_t ret;
 
 	int version_tmp, version_num = 0;
 	char *version = 0, *token;
@@ -295,7 +295,7 @@ static int read_via_objdump(const char *filename, u64 addr, void *buf,
 	if (len) {
 		pr_debug("objdump read too few bytes: %zd\n", len);
 		if (!ret)
-			ret = len;
+			ret = (int)len;
 	}
 
 	pclose(f);
diff --git a/tools/perf/tests/dso-data.c b/tools/perf/tests/dso-data.c
index a1fff4203b75..2954e06ae5b3 100644
--- a/tools/perf/tests/dso-data.c
+++ b/tools/perf/tests/dso-data.c
@@ -233,14 +233,14 @@ static int dsos__create(int cnt, int size, struct dsos *dsos)
 	return 0;
 }
 
-static int set_fd_limit(int n)
+static int set_fd_limit(long n)
 {
 	struct rlimit rlim;
 
 	if (getrlimit(RLIMIT_NOFILE, &rlim))
 		return -1;
 
-	pr_debug("file limit %ld, new %d\n", (long) rlim.rlim_cur, n);
+	pr_debug("file limit %ld, new %ld\n", (long) rlim.rlim_cur, n);
 
 	rlim.rlim_cur = n;
 	return setrlimit(RLIMIT_NOFILE, &rlim);
@@ -249,8 +249,8 @@ static int set_fd_limit(int n)
 static int test__dso_data_cache(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct machine machine;
-	long nr_end, nr = open_files_cnt();
-	int dso_cnt, limit, i, fd;
+	long dso_cnt, limit, nr_end, nr = open_files_cnt();
+	int i, fd;
 
 	/* Rest the internal dso open counter limit. */
 	reset_fd_limit();
@@ -264,7 +264,7 @@ static int test__dso_data_cache(struct test_suite *test __maybe_unused, int subt
 	/* and this is now our dso open FDs limit */
 	dso_cnt = limit / 2;
 	TEST_ASSERT_VAL("failed to create dsos\n",
-			!dsos__create(dso_cnt, TEST_FILE_SIZE, &machine.dsos));
+			!dsos__create((int)dso_cnt, TEST_FILE_SIZE, &machine.dsos));
 
 	for (i = 0; i < (dso_cnt - 1); i++) {
 		struct dso *dso = machine.dsos.dsos[i];
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 446a3615d720..b328ad6973a3 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -45,7 +45,7 @@ static int thread_init(struct thread_data *td)
 	}
 
 	td->map = map;
-	td->tid = syscall(SYS_gettid);
+	td->tid = (pid_t)syscall(SYS_gettid);
 
 	pr_debug("tid = %d, map = %p\n", td->tid, map);
 	return 0;
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 0ef4ba7c1571..68f1498d0a47 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -119,7 +119,7 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 					goto out_delete_evlist;
 				}
 
-				tp_flags = evsel__intval(evsel, &sample, "flags");
+				tp_flags = (int)evsel__intval(evsel, &sample, "flags");
 				perf_sample__exit(&sample);
 				if (flags != tp_flags) {
 					pr_debug("%s: Expected flags=%#x, got %#x\n",
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index db004d26fcb0..2762794827ce 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -609,7 +609,7 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 	pmu_add_sys_aliases(pmu);
 
 	/* Count how many aliases we generated */
-	alias_count = perf_pmu__num_events(pmu);
+	alias_count = (int)perf_pmu__num_events(pmu);
 
 	/* Count how many aliases we expect from the known table */
 	for (table = &test_pmu->aliases[0]; *table; table++)
diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
index a67c756f90b8..b7d7735f8a72 100644
--- a/tools/perf/tests/sigtrap.c
+++ b/tools/perf/tests/sigtrap.c
@@ -154,13 +154,13 @@ sigtrap_handler(int signum __maybe_unused, siginfo_t *info, void *ucontext __may
 {
 	if (!__atomic_fetch_add(&ctx.signal_count, 1, __ATOMIC_RELAXED))
 		ctx.first_siginfo = *info;
-	__atomic_fetch_sub(&ctx.tids_want_signal, syscall(SYS_gettid), __ATOMIC_RELAXED);
+	__atomic_fetch_sub(&ctx.tids_want_signal, (pid_t)syscall(SYS_gettid), __ATOMIC_RELAXED);
 }
 
 static void *test_thread(void *arg)
 {
 	pthread_barrier_t *barrier = (pthread_barrier_t *)arg;
-	pid_t tid = syscall(SYS_gettid);
+	pid_t tid = (pid_t)syscall(SYS_gettid);
 	int i;
 
 	pthread_barrier_wait(barrier);
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 8df3f9d9ffd2..1f0f8321ae40 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -140,8 +140,8 @@ static int process_sample_event(struct evlist *evlist,
 
 	evsel = evlist__id2evsel(evlist, sample.id);
 	if (evsel == switch_tracking->switch_evsel) {
-		next_tid = evsel__intval(evsel, &sample, "next_pid");
-		prev_tid = evsel__intval(evsel, &sample, "prev_pid");
+		next_tid = (int)evsel__intval(evsel, &sample, "next_pid");
+		prev_tid = (int)evsel__intval(evsel, &sample, "prev_pid");
 		cpu = sample.cpu;
 		pr_debug3("sched_switch: cpu: %d prev_tid %d next_tid %d\n",
 			  cpu, prev_tid, next_tid);
@@ -262,9 +262,10 @@ static int compar(const void *a, const void *b)
 {
 	const struct event_node *nodea = a;
 	const struct event_node *nodeb = b;
-	s64 cmp = nodea->event_time - nodeb->event_time;
 
-	return cmp;
+	if (nodea->event_time == nodeb->event_time)
+		return 0;
+	return nodea->event_time < nodeb->event_time ? -1 : 1;
 }
 
 static int process_events(struct evlist *evlist,
@@ -398,7 +399,7 @@ static int test__switch_tracking(struct test_suite *test __maybe_unused, int sub
 
 	switch_evsel = evlist__add_sched_switch(evlist, true);
 	if (IS_ERR(switch_evsel)) {
-		err = PTR_ERR(switch_evsel);
+		err = (int)PTR_ERR(switch_evsel);
 		pr_debug("Failed to create event %s\n", sched_switch);
 		goto out_err;
 	}
diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 74cdbd2ce9d0..fbdb463e965d 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -82,7 +82,7 @@ static bool is_ignored_symbol(const char *name, char type)
 			return true;
 
 	for (p = ignored_suffixes; *p; p++) {
-		int l = strlen(name) - strlen(*p);
+		ssize_t l = strlen(name) - strlen(*p);
 
 		if (l >= 0 && !strcmp(name + l, *p))
 			return true;
@@ -313,7 +313,7 @@ static int test__vmlinux_matches_kallsyms(struct test_suite *test __maybe_unused
 				 * _really_ have a problem.
 				 */
 				s64 skew = mem_end - UM(pair->end);
-				if (llabs(skew) >= page_size)
+				if (llabs(skew) >= (s64)page_size)
 					pr_debug("WARN: %#" PRIx64 ": diff end addr for %s v: %#" PRIx64 " k: %#" PRIx64 "\n",
 						 mem_start, sym->name, mem_end,
 						 UM(pair->end));
diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 6c178985e37f..d5dd17eb5c05 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -31,10 +31,10 @@ volatile u8 data2[3];
 #ifndef __s390x__
 static int wp_read(int fd, long long *count, int size)
 {
-	int ret = read(fd, count, size);
+	ssize_t ret = read(fd, count, size);
 
 	if (ret != size) {
-		pr_debug("failed to read: %d\n", ret);
+		pr_debug("failed to read: %zd\n", ret);
 		return -1;
 	}
 	return 0;
-- 
2.49.0.906.g1f30a19c02-goog


