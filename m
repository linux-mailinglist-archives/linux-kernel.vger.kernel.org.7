Return-Path: <linux-kernel+bounces-739959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF9AB0CD94
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FE116ED49
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7319D2459D1;
	Mon, 21 Jul 2025 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATM/eXz6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC51AA7BF
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139511; cv=none; b=PU4yfuQpP2TG4Tdaj2cbJB63dqQDXt20O99grYgf6+vvQfpIMjWRG2np8PSQw7n1mCGQ+7WmLG738YpRvqQ2sacST3Tz1xeQ8wumQeEok4QFtyL+sLEum67I0YAHLoyxPxO2k8XUs1VHFphD33UF0Jm0nWB0aVPbnIlDnMK/YGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139511; c=relaxed/simple;
	bh=uoHm1R5kLjqSWpkW6lNgsT458qnZZBLsLAaK+b2S+Ak=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KcL4z0cJLwTb0oKrxRvRcfPvVsEd9VRZ/x2H1GPQKDR1nIKNQQmpvbN5CSUEe7/bMgNwhuMX807X1Pb06sB/QbVqn355ap/U1XDk3ChpYzUlHwv+AV74xmg1MQ4D3sYqxcxF+3iqtbXpu9PrzKOutYi44O2xrIU3tVCoaXI0zac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATM/eXz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A46C4CEED;
	Mon, 21 Jul 2025 23:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753139511;
	bh=uoHm1R5kLjqSWpkW6lNgsT458qnZZBLsLAaK+b2S+Ak=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ATM/eXz6Qc3SatF8iPzYUl9FdKn8S3BQ3zgZx2xTB/eJ7JdFs9xnjjlNLotMFwCT6
	 hc6kLtt115I1Jh7JvqIiMMJhF5YKdmFQLa3TUlYC4V+6pLR80hOVT7/Lt6m1n3F2aJ
	 NGakaqIc2fnCAwDROr3QvCyPagR4T4M5v2cVttHcra09k4rozZhE69e4Mcu2zAMprI
	 4J6QNaElpet9tT08EpzHSJv8nZOaul9N9y2owrLp/5cX8g4Bc7ErTyAUu3DdB7GC4J
	 GYlLy3mkh7OgjbowVOm4PeSSiZOp44HCBzDAG4pMDTWUz56tkny7f1u5aAALrETWXt
	 Fh3k8kiEx9iYA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udzgE-00000009vHP-1qnC;
	Mon, 21 Jul 2025 19:12:22 -0400
Message-ID: <20250721231222.293482311@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 21 Jul 2025 19:12:05 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Chang Yin <cyin@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Crystal Wood <crwood@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 1/9] rtla/timerlat: Introduce enum timerlat_tracing_mode
References: <20250721231204.100737734@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

After the introduction of BPF-based sample collection, rtla-timerlat
effectively runs in one of three modes:

- Pure BPF mode, with tracefs only being used to set up the timerlat
tracer. Sample processing and stop on threshold are handled by BPF.

- tracefs mode. BPF is unsupported or kernel is lacking the necessary
trace event (osnoise:timerlat_sample). Stop on theshold is handled by
timerlat tracer stopping tracing in all instances.

- BPF/tracefs mixed mode - BPF is used for sample collection for top or
histogram, tracefs is used for trace output and/or auto-analysis. Stop
on threshold is handled both through BPF program, which stops sample
collection for top/histogram and wakes up rtla, and by timerlat
tracer, which stops tracing for trace output/auto-analysis instances.

Add enum timerlat_tracing_mode, with three values:

- TRACING_MODE_BPF
- TRACING_MODE_TRACEFS
- TRACING_MODE_MIXED

Those represent the modes described above. A field of this type is added
to struct timerlat_params, named "mode", replacing the no_bpf variable.
params->mode is set in timerlat_{top,hist}_parse_args to
TRACING_MODE_BPF or TRACING_MODE_MIXED based on whether trace output
and/or auto-analysis is requested. timerlat_{top,hist}_main then checks
if BPF is not unavailable or disabled, in that case, it sets
params->mode to TRACING_MODE_TRACEFS.

A condition is added to timerlat_apply_config that skips setting
timerlat tracer thresholds if params->mode is TRACING_MODE_BPF (those
are unnecessary, since they only turn off tracing, which is already
turned off in that case, since BPF is used to collect samples).

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Chang Yin <cyin@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250626123405.1496931-2-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/timerlat.c      | 24 +++++++----
 tools/tracing/rtla/src/timerlat.h      | 18 ++++++++
 tools/tracing/rtla/src/timerlat_hist.c | 51 +++++++++++++----------
 tools/tracing/rtla/src/timerlat_top.c  | 57 +++++++++++++++-----------
 4 files changed, 97 insertions(+), 53 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index c29e2ba2d7d8..63d6d43eafff 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -40,16 +40,22 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 			CPU_SET(i, &params->monitored_cpus);
 	}
 
-	retval = osnoise_set_stop_us(tool->context, params->stop_us);
-	if (retval) {
-		err_msg("Failed to set stop us\n");
-		goto out_err;
-	}
+	if (params->mode != TRACING_MODE_BPF) {
+		/*
+		 * In tracefs and mixed mode, timerlat tracer handles stopping
+		 * on threshold
+		 */
+		retval = osnoise_set_stop_us(tool->context, params->stop_us);
+		if (retval) {
+			err_msg("Failed to set stop us\n");
+			goto out_err;
+		}
 
-	retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
-	if (retval) {
-		err_msg("Failed to set stop total us\n");
-		goto out_err;
+		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
+		if (retval) {
+			err_msg("Failed to set stop total us\n");
+			goto out_err;
+		}
 	}
 
 
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index 73045aef23fa..e0a553545d03 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -1,6 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "osnoise.h"
 
+/*
+ * Define timerlat tracing mode.
+ *
+ * There are three tracing modes:
+ * - tracefs-only, used when BPF is unavailable.
+ * - BPF-only, used when BPF is available and neither trace saving nor
+ * auto-analysis are enabled.
+ * - mixed mode, used when BPF is available and either trace saving or
+ * auto-analysis is enabled (which rely on sample collection through
+ * tracefs).
+ */
+enum timerlat_tracing_mode {
+	TRACING_MODE_BPF,
+	TRACING_MODE_TRACEFS,
+	TRACING_MODE_MIXED,
+};
+
 struct timerlat_params {
 	/* Common params */
 	char			*cpus;
@@ -30,6 +47,7 @@ struct timerlat_params {
 	cpu_set_t		hk_cpu_set;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
+	enum timerlat_tracing_mode mode;
 	union {
 		struct {
 			/* top only */
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 36d2294c963d..6cf260e8553b 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -802,6 +802,9 @@ static struct timerlat_params
 	params->bucket_size = 1;
 	params->entries = 256;
 
+	/* default to BPF mode */
+	params->mode = TRACING_MODE_BPF;
+
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
@@ -1054,6 +1057,13 @@ static struct timerlat_params
 	if (params->kernel_workload && params->user_workload)
 		timerlat_hist_usage("--kernel-threads and --user-threads are mutually exclusive!");
 
+	/*
+	 * If auto-analysis or trace output is enabled, switch from BPF mode to
+	 * mixed mode
+	 */
+	if (params->mode == TRACING_MODE_BPF && params->trace_output && !params->no_aa)
+		params->mode = TRACING_MODE_MIXED;
+
 	return params;
 }
 
@@ -1149,7 +1159,6 @@ int timerlat_hist_main(int argc, char *argv[])
 	pthread_t timerlat_u;
 	int retval;
 	int nr_cpus, i;
-	bool no_bpf = false;
 
 	params = timerlat_hist_parse_args(argc, argv);
 	if (!params)
@@ -1161,12 +1170,6 @@ int timerlat_hist_main(int argc, char *argv[])
 		goto out_exit;
 	}
 
-	retval = timerlat_hist_apply_config(tool, params);
-	if (retval) {
-		err_msg("Could not apply config\n");
-		goto out_free;
-	}
-
 	trace = &tool->trace;
 	/*
 	 * Save trace instance into global variable so that SIGINT can stop
@@ -1175,24 +1178,30 @@ int timerlat_hist_main(int argc, char *argv[])
 	 */
 	hist_inst = trace;
 
+	/*
+	 * Try to enable BPF, unless disabled explicitly.
+	 * If BPF enablement fails, fall back to tracefs mode.
+	 */
 	if (getenv("RTLA_NO_BPF") && strncmp(getenv("RTLA_NO_BPF"), "1", 2) == 0) {
 		debug_msg("RTLA_NO_BPF set, disabling BPF\n");
-		no_bpf = true;
-	}
-
-	if (!no_bpf && !tep_find_event_by_name(trace->tep, "osnoise", "timerlat_sample")) {
+		params->mode = TRACING_MODE_TRACEFS;
+	} else if (!tep_find_event_by_name(trace->tep, "osnoise", "timerlat_sample")) {
 		debug_msg("osnoise:timerlat_sample missing, disabling BPF\n");
-		no_bpf = true;
-	}
-
-	if (!no_bpf) {
+		params->mode = TRACING_MODE_TRACEFS;
+	} else {
 		retval = timerlat_bpf_init(params);
 		if (retval) {
 			debug_msg("Could not enable BPF\n");
-			no_bpf = true;
+			params->mode = TRACING_MODE_TRACEFS;
 		}
 	}
 
+	retval = timerlat_hist_apply_config(tool, params);
+	if (retval) {
+		err_msg("Could not apply config\n");
+		goto out_free;
+	}
+
 	retval = enable_timerlat(trace);
 	if (retval) {
 		err_msg("Failed to enable timerlat tracer\n");
@@ -1320,7 +1329,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		trace_instance_start(&record->trace);
 	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
-	if (no_bpf) {
+	if (params->mode == TRACING_MODE_TRACEFS) {
 		trace_instance_start(trace);
 	} else {
 		retval = timerlat_bpf_attach();
@@ -1333,7 +1342,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	tool->start_time = time(NULL);
 	timerlat_hist_set_signals(params);
 
-	if (no_bpf) {
+	if (params->mode == TRACING_MODE_TRACEFS) {
 		while (!stop_tracing) {
 			sleep(params->sleep_time);
 
@@ -1362,7 +1371,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	} else
 		timerlat_bpf_wait(-1);
 
-	if (!no_bpf) {
+	if (params->mode != TRACING_MODE_TRACEFS) {
 		timerlat_bpf_detach();
 		retval = timerlat_hist_bpf_pull_data(tool);
 		if (retval) {
@@ -1409,10 +1418,10 @@ int timerlat_hist_main(int argc, char *argv[])
 	osnoise_destroy_tool(aa);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
+	if (params->mode != TRACING_MODE_TRACEFS)
+		timerlat_bpf_destroy();
 	free(params);
 	free_cpu_idle_disable_states();
-	if (!no_bpf)
-		timerlat_bpf_destroy();
 out_exit:
 	exit(return_value);
 }
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 7365e08fe986..1644eeb60181 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -559,6 +559,9 @@ static struct timerlat_params
 	/* display data in microseconds */
 	params->output_divisor = 1000;
 
+	/* default to BPF mode */
+	params->mode = TRACING_MODE_BPF;
+
 	while (1) {
 		static struct option long_options[] = {
 			{"auto",		required_argument,	0, 'a'},
@@ -790,6 +793,13 @@ static struct timerlat_params
 	if (params->kernel_workload && params->user_workload)
 		timerlat_top_usage("--kernel-threads and --user-threads are mutually exclusive!");
 
+	/*
+	 * If auto-analysis or trace output is enabled, switch from BPF mode to
+	 * mixed mode
+	 */
+	if (params->mode == TRACING_MODE_BPF && params->trace_output && !params->no_aa)
+		params->mode = TRACING_MODE_MIXED;
+
 	return params;
 }
 
@@ -994,7 +1004,6 @@ int timerlat_top_main(int argc, char *argv[])
 	char *max_lat;
 	int retval;
 	int nr_cpus, i;
-	bool no_bpf = false;
 
 	params = timerlat_top_parse_args(argc, argv);
 	if (!params)
@@ -1006,38 +1015,38 @@ int timerlat_top_main(int argc, char *argv[])
 		goto out_exit;
 	}
 
-	retval = timerlat_top_apply_config(top, params);
-	if (retval) {
-		err_msg("Could not apply config\n");
-		goto out_free;
-	}
-
 	trace = &top->trace;
 	/*
-	* Save trace instance into global variable so that SIGINT can stop
-	* the timerlat tracer.
-	* Otherwise, rtla could loop indefinitely when overloaded.
-	*/
+	 * Save trace instance into global variable so that SIGINT can stop
+	 * the timerlat tracer.
+	 * Otherwise, rtla could loop indefinitely when overloaded.
+	 */
 	top_inst = trace;
 
+	/*
+	 * Try to enable BPF, unless disabled explicitly.
+	 * If BPF enablement fails, fall back to tracefs mode.
+	 */
 	if (getenv("RTLA_NO_BPF") && strncmp(getenv("RTLA_NO_BPF"), "1", 2) == 0) {
 		debug_msg("RTLA_NO_BPF set, disabling BPF\n");
-		no_bpf = true;
-	}
-
-	if (!no_bpf && !tep_find_event_by_name(trace->tep, "osnoise", "timerlat_sample")) {
+		params->mode = TRACING_MODE_TRACEFS;
+	} else if (!tep_find_event_by_name(trace->tep, "osnoise", "timerlat_sample")) {
 		debug_msg("osnoise:timerlat_sample missing, disabling BPF\n");
-		no_bpf = true;
-	}
-
-	if (!no_bpf) {
+		params->mode = TRACING_MODE_TRACEFS;
+	} else {
 		retval = timerlat_bpf_init(params);
 		if (retval) {
 			debug_msg("Could not enable BPF\n");
-			no_bpf = true;
+			params->mode = TRACING_MODE_TRACEFS;
 		}
 	}
 
+	retval = timerlat_top_apply_config(top, params);
+	if (retval) {
+		err_msg("Could not apply config\n");
+		goto out_free;
+	}
+
 	retval = enable_timerlat(trace);
 	if (retval) {
 		err_msg("Failed to enable timerlat tracer\n");
@@ -1166,7 +1175,7 @@ int timerlat_top_main(int argc, char *argv[])
 		trace_instance_start(&record->trace);
 	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
-	if (no_bpf) {
+	if (params->mode == TRACING_MODE_TRACEFS) {
 		trace_instance_start(trace);
 	} else {
 		retval = timerlat_bpf_attach();
@@ -1179,7 +1188,7 @@ int timerlat_top_main(int argc, char *argv[])
 	top->start_time = time(NULL);
 	timerlat_top_set_signals(params);
 
-	if (no_bpf)
+	if (params->mode == TRACING_MODE_TRACEFS)
 		retval = timerlat_top_main_loop(top, record, params, &params_u);
 	else
 		retval = timerlat_top_bpf_main_loop(top, record, params, &params_u);
@@ -1187,7 +1196,7 @@ int timerlat_top_main(int argc, char *argv[])
 	if (retval)
 		goto out_top;
 
-	if (!no_bpf)
+	if (params->mode != TRACING_MODE_TRACEFS)
 		timerlat_bpf_detach();
 
 	if (params->user_workload && !params_u.stopped_running) {
@@ -1239,6 +1248,8 @@ int timerlat_top_main(int argc, char *argv[])
 		osnoise_destroy_tool(aa);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(top);
+	if (params->mode != TRACING_MODE_TRACEFS)
+		timerlat_bpf_destroy();
 	free(params);
 	free_cpu_idle_disable_states();
 out_exit:
-- 
2.47.2



