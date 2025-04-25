Return-Path: <linux-kernel+bounces-621131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6783A9D454
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 23:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1406E4C4B27
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 21:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F169824A06A;
	Fri, 25 Apr 2025 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KFtOvyjQ"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51F24E4A9
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617242; cv=none; b=QSzuEzrt4yXiyW+Nuyi4NB4fOKjzzczoZ0Tolph3imt+0QwrWFx7BNq0VuxK1xJknuKfFxYxGb3/fAAG4LMBcOyPmaUe70D60er5MMAd6E+ttwmGlbZuPYuomE5bbToPj9Miun6PfH86Mx9f/bJRHph3hRGDypD0072ObQz2qNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617242; c=relaxed/simple;
	bh=txG5RZ/s604iECqbAkxhFGWQwLHjQHTg9L+54iRXeXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=CJxjwUsJjuPUQBCy8kVeigkw752uZVwYwQAgj6d0l/dLVNIIQbmHwbSRyDAzNrW1jjktxUefWlzSSCO3aTbWsKPNlpFYDa5UJvHs0ySlyoVLtf8cAkfRweKHpK+0dUNvKMu7vPd3RJ4C4N6vgbv51vD4dB3fvbaRth3X3k8CQYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KFtOvyjQ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b15e08f1eb4so1529239a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745617240; x=1746222040; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+o0y2Xr/2vqMuWaMFlJgPCAPqw/FYZ1X/ud/CGzIhA=;
        b=KFtOvyjQxX92dBTdPuPytltNrzaWN7xeW++jUClGApnBwvk/Ui+4VIlljaME4H3nvJ
         da7efmhic7wIrvoHGhwRDYh6ldPvdG1spnTz23UGw4FuHW7GPzCMjxWUhSClcIBV57lw
         m2BiM9iQG20gcwvOI3uKvgZLBb541MATpFLVswBe2ENCuRqlP59TQd19HDNMOQUeBXIR
         c4Wr1unQq3tYPWbQcj9IyN8JPXOECc+Iid2KIB2B0QEPiV/PrlamR9NQkGfDN6LKxD9Q
         MfTVPYa2f/LikAcUmaN+ablkxtk6bVVdRJwecjlsTnHIY3QCFS/lAtGnyGvMRPYiyXoE
         kIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617240; x=1746222040;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+o0y2Xr/2vqMuWaMFlJgPCAPqw/FYZ1X/ud/CGzIhA=;
        b=OtreKpSQPNc++1L5oQSPURNXueznLNCqu8um25oB7Z9Z2hRezgKG9xzwNt4t6BUzu2
         1fEYsesRjr+IYoGckl+ErynFndDIffKrnoyP8E6cNShuZDf17O6PASM5k10ZbXtl+wuK
         fTXzfYXQemzQrZAbj69xHj+/hV/Lo585TJB+xQzj35Ti+TR3sl7wRkjf6MjIl0M0qbhM
         2A4rM0GUceSQSqs13HIus+GCfOdAZ5Mc1th2Jl40Utj3L0qB7+zKcCAxbnGsQc7EXn+p
         9IqEwdjBCKI9gJT5Ud2zS+P/3lH4mzQ3i2E7OlGfgwJ2LdBSAQsec7jdR+hbjVkUkQWH
         6qlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsjE0/3St7vrVpLQn/e526TGXhGyVCGxFoC+5ekAUat6OYodNup3iSk932CPPMonLbVGnaHUl61LKCoP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbLg9Z0C0SI/7L287QhtCKCHouxYM8PtZADDuWMuYU6daglJzy
	qghnb45C6CC7v7M6aB1Kvqe7COMsJeDRIfn1tOcYCMDj2ss28i3tZhquLUN26K0dWEr0qIZzEu8
	QqpIATg==
X-Google-Smtp-Source: AGHT+IFDoNOY10ZJCIMJHlocxbHQOatRaPfj34HXRIwx+RZyBDPer7aT+TN7oy11z+Psyw7MTMSK0mkzesDr
X-Received: from pgns27.prod.google.com ([2002:a63:925b:0:b0:af0:e359:c50a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c707:b0:1f5:8754:324d
 with SMTP id adf61e73a8af0-2045b6c213fmr5225680637.9.1745617240108; Fri, 25
 Apr 2025 14:40:40 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:40:07 -0700
In-Reply-To: <20250425214008.176100-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250425214008.176100-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425214008.176100-10-irogers@google.com>
Subject: [PATCH v3 09/10] perf target: Remove uid from target
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Gathering threads with a uid by scanning /proc is inherently racy
leading to perf_event_open failures that quit perf. It also misses new
processes a user starts. All users of the target functionality now use
BPF filters, so remove uid and uid_str from target.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-ftrace.c                 |  1 -
 tools/perf/builtin-kvm.c                    |  2 -
 tools/perf/builtin-stat.c                   |  4 +-
 tools/perf/builtin-trace.c                  |  1 -
 tools/perf/tests/backward-ring-buffer.c     |  1 -
 tools/perf/tests/event-times.c              |  4 +-
 tools/perf/tests/openat-syscall-tp-fields.c |  1 -
 tools/perf/tests/perf-record.c              |  1 -
 tools/perf/tests/task-exit.c                |  1 -
 tools/perf/util/bpf-filter.c                |  2 +-
 tools/perf/util/evlist.c                    |  3 +-
 tools/perf/util/target.c                    | 46 +--------------------
 tools/perf/util/target.h                    | 12 +-----
 13 files changed, 6 insertions(+), 73 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 7caa18d5ffc3..ae901f2a18ef 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1590,7 +1590,6 @@ int cmd_ftrace(int argc, const char **argv)
 	int (*cmd_func)(struct perf_ftrace *) = NULL;
 	struct perf_ftrace ftrace = {
 		.tracer = DEFAULT_TRACER,
-		.target = { .uid = UINT_MAX, },
 	};
 	const struct option common_options[] = {
 	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 67fd2b006b0b..d75bd3684980 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1871,8 +1871,6 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 	kvm->opts.user_interval = 1;
 	kvm->opts.mmap_pages = 512;
 	kvm->opts.target.uses_mmap = false;
-	kvm->opts.target.uid_str = NULL;
-	kvm->opts.target.uid = UINT_MAX;
 
 	symbol__init(NULL);
 	disable_buildid_cache();
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 300b6393bb41..c2ed49ff2048 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -108,9 +108,7 @@ static struct parse_events_option_args parse_events_option_args = {
 
 static bool all_counters_use_bpf = true;
 
-static struct target target = {
-	.uid	= UINT_MAX,
-};
+static struct target target;
 
 static volatile sig_atomic_t	child_pid			= -1;
 static int			detailed_run			=  0;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1f7d2b3d8b3d..aa0a27dd7d21 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5374,7 +5374,6 @@ int cmd_trace(int argc, const char **argv)
 	struct trace trace = {
 		.opts = {
 			.target = {
-				.uid	   = UINT_MAX,
 				.uses_mmap = true,
 			},
 			.user_freq     = UINT_MAX,
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 79a980b1e786..c5e7999f2817 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -91,7 +91,6 @@ static int test__backward_ring_buffer(struct test_suite *test __maybe_unused, in
 	struct parse_events_error parse_error;
 	struct record_opts opts = {
 		.target = {
-			.uid = UINT_MAX,
 			.uses_mmap = true,
 		},
 		.freq	      = 0,
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index deefe5003bfc..2148024b4f4a 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -17,9 +17,7 @@
 static int attach__enable_on_exec(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__last(evlist);
-	struct target target = {
-		.uid = UINT_MAX,
-	};
+	struct target target = {};
 	const char *argv[] = { "true", NULL, };
 	char sbuf[STRERR_BUFSIZE];
 	int err;
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 0ef4ba7c1571..2a139d2781a8 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -28,7 +28,6 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 {
 	struct record_opts opts = {
 		.target = {
-			.uid = UINT_MAX,
 			.uses_mmap = true,
 		},
 		.no_buffering = true,
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 0958c7c8995f..0b3c37e66871 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -45,7 +45,6 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 {
 	struct record_opts opts = {
 		.target = {
-			.uid = UINT_MAX,
 			.uses_mmap = true,
 		},
 		.no_buffering = true,
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 8e328bbd509d..4053ff2813bb 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -46,7 +46,6 @@ static int test__task_exit(struct test_suite *test __maybe_unused, int subtest _
 	struct evsel *evsel;
 	struct evlist *evlist;
 	struct target target = {
-		.uid		= UINT_MAX,
 		.uses_mmap	= true,
 	};
 	const char *argv[] = { "true", NULL };
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index a4fdf6911ec1..ed4845ff4a10 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -449,7 +449,7 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 	struct bpf_program *prog;
 	struct bpf_link *link;
 	struct perf_bpf_filter_entry *entry;
-	bool needs_idx_hash = !target__has_cpu(target) && !target->uid_str;
+	bool needs_idx_hash = !target__has_cpu(target);
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
 	if (entry == NULL)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 0a21da4f990f..86b11ffc09b7 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1005,8 +1005,7 @@ int evlist__create_maps(struct evlist *evlist, struct target *target)
 	 * per-thread data. thread_map__new_str will call
 	 * thread_map__new_all_cpus to enumerate all threads.
 	 */
-	threads = thread_map__new_str(target->pid, target->tid, target->uid,
-				      all_threads);
+	threads = thread_map__new_str(target->pid, target->tid, UINT_MAX, all_threads);
 
 	if (!threads)
 		return -1;
diff --git a/tools/perf/util/target.c b/tools/perf/util/target.c
index f3ad59ccfa99..8cf71bea295a 100644
--- a/tools/perf/util/target.c
+++ b/tools/perf/util/target.c
@@ -28,20 +28,6 @@ enum target_errno target__validate(struct target *target)
 			ret = TARGET_ERRNO__PID_OVERRIDE_CPU;
 	}
 
-	/* UID and PID are mutually exclusive */
-	if (target->tid && target->uid_str) {
-		target->uid_str = NULL;
-		if (ret == TARGET_ERRNO__SUCCESS)
-			ret = TARGET_ERRNO__PID_OVERRIDE_UID;
-	}
-
-	/* UID and CPU are mutually exclusive */
-	if (target->uid_str && target->cpu_list) {
-		target->cpu_list = NULL;
-		if (ret == TARGET_ERRNO__SUCCESS)
-			ret = TARGET_ERRNO__UID_OVERRIDE_CPU;
-	}
-
 	/* PID and SYSTEM are mutually exclusive */
 	if (target->tid && target->system_wide) {
 		target->system_wide = false;
@@ -49,13 +35,6 @@ enum target_errno target__validate(struct target *target)
 			ret = TARGET_ERRNO__PID_OVERRIDE_SYSTEM;
 	}
 
-	/* UID and SYSTEM are mutually exclusive */
-	if (target->uid_str && target->system_wide) {
-		target->system_wide = false;
-		if (ret == TARGET_ERRNO__SUCCESS)
-			ret = TARGET_ERRNO__UID_OVERRIDE_SYSTEM;
-	}
-
 	/* BPF and CPU are mutually exclusive */
 	if (target->bpf_str && target->cpu_list) {
 		target->cpu_list = NULL;
@@ -70,13 +49,6 @@ enum target_errno target__validate(struct target *target)
 			ret = TARGET_ERRNO__BPF_OVERRIDE_PID;
 	}
 
-	/* BPF and UID are mutually exclusive */
-	if (target->bpf_str && target->uid_str) {
-		target->uid_str = NULL;
-		if (ret == TARGET_ERRNO__SUCCESS)
-			ret = TARGET_ERRNO__BPF_OVERRIDE_UID;
-	}
-
 	/* BPF and THREADS are mutually exclusive */
 	if (target->bpf_str && target->per_thread) {
 		target->per_thread = false;
@@ -124,31 +96,19 @@ uid_t parse_uid(const char *str)
 	return result->pw_uid;
 }
 
-enum target_errno target__parse_uid(struct target *target)
-{
-	target->uid = parse_uid(target->uid_str);
-
-	return target->uid != UINT_MAX ? TARGET_ERRNO__SUCCESS : TARGET_ERRNO__INVALID_UID;
-}
-
 /*
  * This must have a same ordering as the enum target_errno.
  */
 static const char *target__error_str[] = {
 	"PID/TID switch overriding CPU",
-	"PID/TID switch overriding UID",
-	"UID switch overriding CPU",
 	"PID/TID switch overriding SYSTEM",
-	"UID switch overriding SYSTEM",
 	"SYSTEM/CPU switch overriding PER-THREAD",
 	"BPF switch overriding CPU",
 	"BPF switch overriding PID/TID",
-	"BPF switch overriding UID",
 	"BPF switch overriding THREAD",
-	"Invalid User: %s",
 };
 
-int target__strerror(struct target *target, int errnum,
+int target__strerror(struct target *target __maybe_unused, int errnum,
 			  char *buf, size_t buflen)
 {
 	int idx;
@@ -173,10 +133,6 @@ int target__strerror(struct target *target, int errnum,
 		snprintf(buf, buflen, "%s", msg);
 		break;
 
-	case TARGET_ERRNO__INVALID_UID:
-		snprintf(buf, buflen, msg, target->uid_str);
-		break;
-
 	default:
 		/* cannot reach here */
 		break;
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index e082bda990fb..84ebb9c940c6 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -9,9 +9,7 @@ struct target {
 	const char   *pid;
 	const char   *tid;
 	const char   *cpu_list;
-	const char   *uid_str;
 	const char   *bpf_str;
-	uid_t	     uid;
 	bool	     system_wide;
 	bool	     uses_mmap;
 	bool	     default_per_cpu;
@@ -36,32 +34,24 @@ enum target_errno {
 
 	/* for target__validate() */
 	TARGET_ERRNO__PID_OVERRIDE_CPU	= __TARGET_ERRNO__START,
-	TARGET_ERRNO__PID_OVERRIDE_UID,
-	TARGET_ERRNO__UID_OVERRIDE_CPU,
 	TARGET_ERRNO__PID_OVERRIDE_SYSTEM,
-	TARGET_ERRNO__UID_OVERRIDE_SYSTEM,
 	TARGET_ERRNO__SYSTEM_OVERRIDE_THREAD,
 	TARGET_ERRNO__BPF_OVERRIDE_CPU,
 	TARGET_ERRNO__BPF_OVERRIDE_PID,
-	TARGET_ERRNO__BPF_OVERRIDE_UID,
 	TARGET_ERRNO__BPF_OVERRIDE_THREAD,
 
-	/* for target__parse_uid() */
-	TARGET_ERRNO__INVALID_UID,
-
 	__TARGET_ERRNO__END,
 };
 
 enum target_errno target__validate(struct target *target);
 
 uid_t parse_uid(const char *str);
-enum target_errno target__parse_uid(struct target *target);
 
 int target__strerror(struct target *target, int errnum, char *buf, size_t buflen);
 
 static inline bool target__has_task(struct target *target)
 {
-	return target->tid || target->pid || target->uid_str;
+	return target->tid || target->pid;
 }
 
 static inline bool target__has_cpu(struct target *target)
-- 
2.49.0.850.g28803427d3-goog


