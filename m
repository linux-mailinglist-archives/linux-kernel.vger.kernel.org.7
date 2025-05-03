Return-Path: <linux-kernel+bounces-630677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 741ECAA7DC3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 May 2025 02:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F3A18856D9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 May 2025 00:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32D5F4ED;
	Sat,  3 May 2025 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsbxC10G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D5625;
	Sat,  3 May 2025 00:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746232590; cv=none; b=Il2weqY8R0mX+0RAY2oJ98XkOAh6/F3eeHst0RmI1vRKXsLE/x98eorT1U7MYsgXpeB3fSPolV0LTqCjrF8x2zFvxgr70dSL8wucRlvN+A+QnySK+kRhm9HPD1ZUfP1fhCzhkyJWKzJuwNE9mEeotSasdkgEU0RtduNmjbKcPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746232590; c=relaxed/simple;
	bh=9vXVxFH9J/W84trDs2dR6CJK23BfRglIs8GvXOA3J2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSEgzoksAFaVDqYkb/FQoqeofWWmndCiWEbwnsQHbtYqo78CfIKcxsGrxk98ZsqXztWkLY1Fyux0QRi+YcQKKpxrjM3qTyChML7yuMuqdF7rL+C+PgCKUoGBvrsvTSIaF7muibFmL2qESCOty+Qb0kGEGB1Ewvt+mlazN7f76dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsbxC10G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250ACC4CEE4;
	Sat,  3 May 2025 00:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746232589;
	bh=9vXVxFH9J/W84trDs2dR6CJK23BfRglIs8GvXOA3J2o=;
	h=From:To:Cc:Subject:Date:From;
	b=GsbxC10GjLX9BKMxVLShJKW9sdbkeWF1ynqAEusjlzlyrSJZ1OI+y0GPSucvoxcWb
	 jJx+wu2hq1CJnV+ZVuY65GwaAt0aSPzI8rM3rzQLb+RjivLePV3nFnx7GjlTx4BCLz
	 s7RrWfKwujDnsPUzxGZe01nCAobNL2yCob6y6V4N2BJ4XULQLzXQtISE7/9gKBv2tt
	 BoTYTJ0DOuEqsgXYLrjqysYRlHJpm/JBrY/UBjLn5YONMT4jxhO52C/LOQ6LSBhgSi
	 1JukSNoZTFjwfbSPGeC4juroVkXRMDkXY0f8C6ybXu7BwsZWUDscAJ7Q/bOfGk9sjG
	 Iyj9ihovjtC9A==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Dmitry Vyukov <dvyukov@google.com>
Subject: [RFC/PATCH] perf report: Support latency profiling in system-wide mode
Date: Fri,  2 May 2025 17:36:20 -0700
Message-ID: <20250503003620.45072-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When it profile a target process (and its children), it's
straight-forward to track parallelism using sched-switch info.  The
parallelism is kept in machine-level in this case.

But when it profile multiple processes like in the system-wide mode,
it might not be clear how to apply the (machine-level) parallelism to
different tasks.  That's why it disabled the latency profiling for
system-wide mode.

But it should be able to track parallelism in each process and it'd
useful to profile latency issues in multi-threaded programs.  So this
patch tries to enable it.

However using sched-switch info can be a problem since it may emit a lot
more data and more chances for losing data when perf cannot keep up with
it.

Instead, it can maintain the current process for each CPU when it sees
samples.  And the process updates parallelism so that it can calculate
the latency based on the value.  One more point to improve is to remove
the idle task from latency calculation.

Here's an example:

  # perf record -a -- perf bench sched messaging

This basically forks each sender and receiver tasks for the run.

  # perf report --latency -s comm --stdio
  ...
  #
  #  Latency  Overhead  Command
  # ........  ........  ...............
  #
      98.14%    95.97%  sched-messaging
       0.78%     0.93%  gnome-shell
       0.36%     0.34%  ptyxis
       0.23%     0.23%  kworker/u112:0-
       0.23%     0.44%  perf
       0.08%     0.10%  KMS thread
       0.05%     0.05%  rcu_preempt
       0.05%     0.05%  kworker/u113:2-
       ...

So the latency profile is similar to the overhead.  But when you run
with -t option to make it multi-threaded:

  # perf record -a -- perf bench sched messaging -t

Then the latency profile result differs with the overhead.

  # perf report --latency -s comm --stdio
  ...
  #
  #  Latency  Overhead  Command
  # ........  ........  ...............
  #
      58.94%    94.52%  sched-messaging
      19.12%     1.22%  perf
      12.13%     0.77%  ptyxis
       4.07%     0.28%  gnome-shell
       1.31%     0.08%  perf-exec
       0.95%     0.06%  kworker/u113:2-
       0.86%     0.05%  KMS thread
       0.85%     0.05%  kworker/18:1-mm
       ...

A side effect is that it will most likely show latency output column
for system-wide mode by default.

Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c | 16 ++---------
 tools/perf/builtin-report.c | 56 +++++++++++++++++++++++++++++--------
 tools/perf/util/event.c     | 48 ++++++++++++++++++++++++-------
 tools/perf/util/machine.c   | 21 ++++++++++++++
 tools/perf/util/machine.h   |  4 +++
 tools/perf/util/thread.h    | 23 +++++++++++++++
 6 files changed, 133 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8898357325cf4132..67f746601ac05e4d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4062,19 +4062,9 @@ int cmd_record(int argc, const char **argv)
 	}
 
 	if (record.latency) {
-		/*
-		 * There is no fundamental reason why latency profiling
-		 * can't work for system-wide mode, but exact semantics
-		 * and details are to be defined.
-		 * See the following thread for details:
-		 * https://lore.kernel.org/all/Z4XDJyvjiie3howF@google.com/
-		 */
-		if (record.opts.target.system_wide) {
-			pr_err("Failed: latency profiling is not supported with system-wide collection.\n");
-			err = -EINVAL;
-			goto out_opts;
-		}
-		record.opts.record_switch_events = true;
+		/* It can use sample->cpu to get process-level parallelism. */
+		if (!target__has_cpu(&record.opts.target))
+			record.opts.record_switch_events = true;
 	}
 
 	if (rec->buildid_mmap) {
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index f0299c7ee0254a37..4294508b9df52d83 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1280,6 +1280,22 @@ static int process_attr(const struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
+static bool is_latency_requested(void)
+{
+	if (symbol_conf.parallelism_list_str || symbol_conf.prefer_latency)
+		return true;
+
+	if (sort_order && (strstr(sort_order, "latency") ||
+			   strstr(sort_order, "parallelism")))
+		return true;
+
+	if (field_order && (strstr(field_order, "latency") ||
+			    strstr(field_order, "parallelism")))
+		return true;
+
+	return false;
+}
+
 #define CALLCHAIN_BRANCH_SORT_ORDER	\
 	"srcline,symbol,dso,callchain_branch_predicted," \
 	"callchain_branch_abort,callchain_branch_cycles"
@@ -1735,18 +1751,10 @@ int cmd_report(int argc, const char **argv)
 	}
 
 	symbol_conf.enable_latency = true;
-	if (report.disable_order || !perf_session__has_switch_events(session)) {
-		if (symbol_conf.parallelism_list_str ||
-			symbol_conf.prefer_latency ||
-			(sort_order && (strstr(sort_order, "latency") ||
-				strstr(sort_order, "parallelism"))) ||
-			(field_order && (strstr(field_order, "latency") ||
-				strstr(field_order, "parallelism")))) {
-			if (report.disable_order)
-				ui__error("Use of latency profile or parallelism is incompatible with --disable-order.\n");
-			else
-				ui__error("Use of latency profile or parallelism requires --latency flag during record.\n");
-			return -1;
+	if (report.disable_order) {
+		if (is_latency_requested()) {
+			ui__error("Use of latency profile or parallelism is incompatible with --disable-order.\n");
+			goto error;
 		}
 		/*
 		 * If user did not ask for anything related to
@@ -1755,6 +1763,30 @@ int cmd_report(int argc, const char **argv)
 		symbol_conf.enable_latency = false;
 	}
 
+	if (!perf_session__has_switch_events(session)) {
+		if (evlist__combined_sample_type(session->evlist) & PERF_SAMPLE_CPU) {
+			struct machine *machine = &session->machines.host;
+
+			/*
+			 * Maintain current process for each CPU to track
+			 * parallelism in process level.
+			 */
+			ret = machine__create_current_table(machine);
+			if (ret < 0)
+				goto error;
+		} else if (is_latency_requested()) {
+			ui__error("Use of latency profile or parallelism requires --latency flag during record.\n");
+			goto error;
+		}
+		else {
+			/*
+			 * If user did not ask for anything related to
+			 * latency/parallelism explicitly, just don't show it.
+			 */
+			symbol_conf.enable_latency = false;
+		}
+	}
+
 	if (last_key != K_SWITCH_INPUT_DATA) {
 		if (sort_order && strstr(sort_order, "ipc")) {
 			parse_options_usage(report_usage, options, "s", 1);
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index c23b77f8f854ad21..6c2c9cd68e3afb5e 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -767,16 +767,44 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 			al->socket = env->cpu[al->cpu].socket_id;
 	}
 
-	/* Account for possible out-of-order switch events. */
-	al->parallelism = max(1, min(machine->parallelism, machine__nr_cpus_avail(machine)));
-	if (test_bit(al->parallelism, symbol_conf.parallelism_filter))
-		al->filtered |= (1 << HIST_FILTER__PARALLELISM);
-	/*
-	 * Multiply it by some const to avoid precision loss or dealing
-	 * with floats. The multiplier does not matter otherwise since
-	 * we only print it as percents.
-	 */
-	al->latency = sample->period * 1000 / al->parallelism;
+	if (symbol_conf.enable_latency) {
+		if (machine->current && al->cpu >= 0) {
+			struct thread *curr = machine->current[al->cpu];
+
+			if (curr) {
+				thread__dec_parallelism(curr);
+				thread__put(curr);
+			}
+
+			curr = machine__findnew_thread(machine, sample->pid,
+						       sample->pid);
+			if (curr) {
+				machine->current[al->cpu] = curr;
+
+				thread__inc_parallelism(curr);
+				thread__get(curr);
+			}
+
+			al->parallelism = curr ? thread__parallelism(curr) : 1;
+		} else {
+			/* Account for possible out-of-order switch events. */
+			al->parallelism = max(1, min(machine->parallelism,
+						     machine__nr_cpus_avail(machine)));
+		}
+
+		if (test_bit(al->parallelism, symbol_conf.parallelism_filter))
+			al->filtered |= (1 << HIST_FILTER__PARALLELISM);
+		/*
+		 * Multiply it by some const to avoid precision loss or dealing
+		 * with floats. The multiplier does not matter otherwise since
+		 * we only print it as percents.
+		 */
+		al->latency = sample->period * 1000 / al->parallelism;
+
+		/* It won't be exciting to see idle threads in latency profile. */
+		if (sample->pid == 0)
+			al->latency = 0;
+	}
 
 	if (al->map) {
 		if (symbol_conf.dso_list &&
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2531b373f2cf7ca0..8c0e7d418a88f528 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -117,6 +117,7 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	}
 
 	machine->current_tid = NULL;
+	machine->current = NULL;
 	err = 0;
 
 out:
@@ -183,6 +184,12 @@ void machine__exit(struct machine *machine)
 	zfree(&machine->current_tid);
 	zfree(&machine->kallsyms_filename);
 
+	if (machine->current) {
+		for (int i = 0; i < machine__nr_cpus_avail(machine); i++)
+			thread__put(machine->current[i]);
+		zfree(&machine->current);
+	}
+
 	threads__exit(&machine->threads);
 }
 
@@ -3271,3 +3278,17 @@ int machine__hit_all_dsos(struct machine *machine)
 {
 	return dsos__hit_all(&machine->dsos);
 }
+
+int machine__create_current_table(struct machine *machine)
+{
+	int nr = machine__nr_cpus_avail(machine);
+
+	if (nr == 0)
+		return -EINVAL;
+
+	machine->current = calloc(nr, sizeof(*machine->current));
+	if (machine->current == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index b56abec84fed1e3f..13d23b14b25e51fc 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -64,6 +64,8 @@ struct machine {
 	};
 	struct machines   *machines;
 	bool		  trampolines_mapped;
+	/* per-CPU current process for parallelism */
+	struct thread	  **current;
 };
 
 /*
@@ -332,4 +334,6 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 
 int machine__hit_all_dsos(struct machine *machine);
 
+int machine__create_current_table(struct machine *machine);
+
 #endif /* __PERF_MACHINE_H */
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index cd574a896418ac94..5233436404408d10 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -39,6 +39,7 @@ DECLARE_RC_STRUCT(thread) {
 	pid_t			ppid;
 	int			cpu;
 	int			guest_cpu; /* For QEMU thread */
+	int			parallelism; /* Valid for group leaders */
 	refcount_t		refcnt;
 	/**
 	 * @exited: Has the thread had an exit event. Such threads are usually
@@ -359,4 +360,26 @@ void thread__free_stitch_list(struct thread *thread);
 void thread__resolve(struct thread *thread, struct addr_location *al,
 		     struct perf_sample *sample);
 
+static inline int thread__parallelism(const struct thread *thread)
+{
+	return RC_CHK_ACCESS(thread)->parallelism ? : 1;
+}
+
+static inline void thread__set_parallelism(struct thread *thread, int parallelism)
+{
+	RC_CHK_ACCESS(thread)->parallelism = parallelism;
+}
+
+static inline void thread__inc_parallelism(struct thread *thread)
+{
+	if (thread__pid(thread))
+		RC_CHK_ACCESS(thread)->parallelism++;
+}
+
+static inline void thread__dec_parallelism(struct thread *thread)
+{
+	if (thread__pid(thread) && RC_CHK_ACCESS(thread)->parallelism > 0)
+		RC_CHK_ACCESS(thread)->parallelism--;
+}
+
 #endif	/* __PERF_THREAD_H */
-- 
2.49.0


