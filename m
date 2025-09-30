Return-Path: <linux-kernel+bounces-838185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 924CABAEA16
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 787417AA30E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244502C08D9;
	Tue, 30 Sep 2025 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6L4XmfZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0216132F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759268718; cv=none; b=VWYg2qjNPHXFGfWZQbRfCXzH3m6XbOdoo/bvHej9HoL4GlQVp7ClzvHd6zZb1Y6sNlftutQd5I4glwVhkt4zkkvD55uIhXctSl1XUL03hsyWTgVM92WFAqZz/IQHzW6VFlpEzWzl0TZxwprpjnuWOYPOSVh1SiqCl3kKQ1wyktM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759268718; c=relaxed/simple;
	bh=VTVSvstmjy0jmEur838qZYYVS+TMaTV7zn7Yi3QAR98=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gIKylIhIamckH6otpeIUlWcFnlbLVRzagnTTQZlbFVCdV4hMNQ/IxAFwBlrVHU0+Mwo1OzScRrs2YEXPx/XIx+xPurFolyJq3ZDuqZChAU2gNZPvTWSqylOPIx3K8cRZkiduOsUTu2IrAa2MXpOG8jLFxroFJqdTdFGDW+paF/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6L4XmfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3D4C4CEF0;
	Tue, 30 Sep 2025 21:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759268718;
	bh=VTVSvstmjy0jmEur838qZYYVS+TMaTV7zn7Yi3QAR98=;
	h=Date:From:To:Cc:Subject:References:From;
	b=i6L4XmfZ25K6QOqG0Mlo+8vRbaH/XkNUpU0VEIIGsRBhsPbiT0JBk49NIsOA36tHk
	 qsARi3Kqec93/Pky49ltoLj/X4Gr0pRapj+nW/YWyEFI1c21tPYNYnSVeFycHFDm+E
	 EY8l9xry31S+R53n7dOJ0N6y5X3uQin839wTAxWdIvyoJF/6OQslnmrwWxa+Fgic1F
	 KaDuCvNqPXzxcF7ZyBgRF8Z1/ve/9O0B9z3kW64V7mb2BtARWQyfPy77OgnCtvrXrR
	 H/Pj1uT5bU+LOFGKJuh2m+bEbN+vw89x73rEIAy2aOvTvKTmQU3bjuLPvTlncGvsrh
	 76XpSZELXiLdQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3iBS-0000000DUu7-1k2W;
	Tue, 30 Sep 2025 17:46:54 -0400
Message-ID: <20250930214654.270276531@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 17:46:31 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Crystal Wood <crwood@redhat.com>
Subject: [for-next][PATCH 1/7] tools/rtla: Consolidate common parameters into shared structure
References: <20250930214630.332381812@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Costa Shulyupin <costa.shul@redhat.com>

timerlat_params and osnoise_params structures contain 15 identical
fields.

Introduce a new header common.h and define a common_params structure to
consolidate shared fields, reduce code duplication, and enhance
maintainability.

Cc: John Kacur <jkacur@redhat.com>
Link: https://lore.kernel.org/20250907022325.243930-2-crwood@redhat.com
Reviewed-by: Tomas Glozar  <tglozar@redhat.com>
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
Signed-off-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/common.h        |  30 +++++++
 tools/tracing/rtla/src/osnoise.c       |  20 ++---
 tools/tracing/rtla/src/osnoise.h       |  19 +----
 tools/tracing/rtla/src/osnoise_hist.c  |  92 ++++++++++----------
 tools/tracing/rtla/src/osnoise_top.c   |  80 ++++++++---------
 tools/tracing/rtla/src/timerlat.c      |  24 +++---
 tools/tracing/rtla/src/timerlat.h      |  18 +---
 tools/tracing/rtla/src/timerlat_bpf.c  |   4 +-
 tools/tracing/rtla/src/timerlat_hist.c | 113 +++++++++++++------------
 tools/tracing/rtla/src/timerlat_top.c  | 105 +++++++++++------------
 10 files changed, 253 insertions(+), 252 deletions(-)
 create mode 100644 tools/tracing/rtla/src/common.h

diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
new file mode 100644
index 000000000000..0a44cfaa7c0b
--- /dev/null
+++ b/tools/tracing/rtla/src/common.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+#include "utils.h"
+
+/*
+ * common_params - Parameters shared between timerlat_params and osnoise_params
+ */
+struct common_params {
+	/* trace configuration */
+	char			*cpus;
+	cpu_set_t		monitored_cpus;
+	struct trace_events	*events;
+	int			buffer_size;
+
+	/* Timing parameters */
+	int			warmup;
+	long long		stop_us;
+	long long		stop_total_us;
+	int			sleep_time;
+	int			duration;
+
+	/* Scheduling parameters */
+	int			set_sched;
+	struct sched_attr	sched_param;
+	int			cgroup;
+	char			*cgroup_name;
+	int			hk_cpus;
+	cpu_set_t		hk_cpu_set;
+};
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 2dc3e4539e99..06ae7437c2c7 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1127,10 +1127,10 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 {
 	int retval;
 
-	if (!params->sleep_time)
-		params->sleep_time = 1;
+	if (!params->common.sleep_time)
+		params->common.sleep_time = 1;
 
-	retval = osnoise_set_cpus(tool->context, params->cpus ? params->cpus : "all");
+	retval = osnoise_set_cpus(tool->context, params->common.cpus ? params->common.cpus : "all");
 	if (retval) {
 		err_msg("Failed to apply CPUs config\n");
 		goto out_err;
@@ -1151,13 +1151,13 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 		goto out_err;
 	}
 
-	retval = osnoise_set_stop_us(tool->context, params->stop_us);
+	retval = osnoise_set_stop_us(tool->context, params->common.stop_us);
 	if (retval) {
 		err_msg("Failed to set stop us\n");
 		goto out_err;
 	}
 
-	retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
+	retval = osnoise_set_stop_total_us(tool->context, params->common.stop_total_us);
 	if (retval) {
 		err_msg("Failed to set stop total us\n");
 		goto out_err;
@@ -1169,14 +1169,14 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 		goto out_err;
 	}
 
-	if (params->hk_cpus) {
-		retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
-					   &params->hk_cpu_set);
+	if (params->common.hk_cpus) {
+		retval = sched_setaffinity(getpid(), sizeof(params->common.hk_cpu_set),
+					   &params->common.hk_cpu_set);
 		if (retval == -1) {
 			err_msg("Failed to set rtla to the house keeping CPUs\n");
 			goto out_err;
 		}
-	} else if (params->cpus) {
+	} else if (params->common.cpus) {
 		/*
 		 * Even if the user do not set a house-keeping CPU, try to
 		 * move rtla to a CPU set different to the one where the user
@@ -1184,7 +1184,7 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 		 *
 		 * No need to check results as this is an automatic attempt.
 		 */
-		auto_house_keeping(&params->monitored_cpus);
+		auto_house_keeping(&params->common.monitored_cpus);
 	}
 
 	retval = osnoise_set_workload(tool->context, true);
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index ac1c99910744..0386bb50ffa1 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #pragma once
 
-#include "utils.h"
+#include "common.h"
 #include "trace.h"
 
 enum osnoise_mode {
@@ -10,26 +10,11 @@ enum osnoise_mode {
 };
 
 struct osnoise_params {
-	/* Common params */
-	char			*cpus;
-	cpu_set_t		monitored_cpus;
+	struct common_params	common;
 	char			*trace_output;
-	char			*cgroup_name;
 	unsigned long long	runtime;
 	unsigned long long	period;
 	long long		threshold;
-	long long		stop_us;
-	long long		stop_total_us;
-	int			sleep_time;
-	int			duration;
-	int			set_sched;
-	int			cgroup;
-	int			hk_cpus;
-	cpu_set_t		hk_cpu_set;
-	struct sched_attr	sched_param;
-	struct trace_events	*events;
-	int			warmup;
-	int			buffer_size;
 	union {
 		struct {
 			/* top only */
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 8d579bcee709..3fb9bb553498 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -243,7 +243,7 @@ static void osnoise_hist_header(struct osnoise_tool *tool)
 		trace_seq_printf(s, "Index");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -274,7 +274,7 @@ osnoise_print_summary(struct osnoise_params *params,
 		trace_seq_printf(trace->seq, "count:");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -288,7 +288,7 @@ osnoise_print_summary(struct osnoise_params *params,
 		trace_seq_printf(trace->seq, "min:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -303,7 +303,7 @@ osnoise_print_summary(struct osnoise_params *params,
 		trace_seq_printf(trace->seq, "avg:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -321,7 +321,7 @@ osnoise_print_summary(struct osnoise_params *params,
 		trace_seq_printf(trace->seq, "max:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -357,7 +357,7 @@ osnoise_print_stats(struct osnoise_params *params, struct osnoise_tool *tool)
 					 bucket * data->bucket_size);
 
 		for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-			if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+			if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 				continue;
 
 			if (!data->hist[cpu].count)
@@ -395,7 +395,7 @@ osnoise_print_stats(struct osnoise_params *params, struct osnoise_tool *tool)
 		trace_seq_printf(trace->seq, "over: ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].count)
@@ -537,7 +537,7 @@ static struct osnoise_params
 		switch (c) {
 		case 'a':
 			/* set sample stop to auto_thresh */
-			params->stop_us = get_llong_from_str(optarg);
+			params->common.stop_us = get_llong_from_str(optarg);
 
 			/* set sample threshold to 1 */
 			params->threshold = 1;
@@ -552,27 +552,27 @@ static struct osnoise_params
 				osnoise_hist_usage("Bucket size needs to be > 0 and <= 1000000\n");
 			break;
 		case 'c':
-			retval = parse_cpu_set(optarg, &params->monitored_cpus);
+			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
 				osnoise_hist_usage("\nInvalid -c cpu list\n");
-			params->cpus = optarg;
+			params->common.cpus = optarg;
 			break;
 		case 'C':
-			params->cgroup = 1;
+			params->common.cgroup = 1;
 			if (!optarg) {
 				/* will inherit this cgroup */
-				params->cgroup_name = NULL;
+				params->common.cgroup_name = NULL;
 			} else if (*optarg == '=') {
 				/* skip the = */
-				params->cgroup_name = ++optarg;
+				params->common.cgroup_name = ++optarg;
 			}
 			break;
 		case 'D':
 			config_debug = 1;
 			break;
 		case 'd':
-			params->duration = parse_seconds_duration(optarg);
-			if (!params->duration)
+			params->common.duration = parse_seconds_duration(optarg);
+			if (!params->common.duration)
 				osnoise_hist_usage("Invalid -D duration\n");
 			break;
 		case 'e':
@@ -582,10 +582,10 @@ static struct osnoise_params
 				exit(EXIT_FAILURE);
 			}
 
-			if (params->events)
-				tevent->next = params->events;
+			if (params->common.events)
+				tevent->next = params->common.events;
 
-			params->events = tevent;
+			params->common.events = tevent;
 			break;
 		case 'E':
 			params->entries = get_llong_from_str(optarg);
@@ -597,8 +597,8 @@ static struct osnoise_params
 			osnoise_hist_usage(NULL);
 			break;
 		case 'H':
-			params->hk_cpus = 1;
-			retval = parse_cpu_set(optarg, &params->hk_cpu_set);
+			params->common.hk_cpus = 1;
+			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
 			if (retval) {
 				err_msg("Error parsing house keeping CPUs\n");
 				exit(EXIT_FAILURE);
@@ -610,10 +610,10 @@ static struct osnoise_params
 				osnoise_hist_usage("Period longer than 10 s\n");
 			break;
 		case 'P':
-			retval = parse_prio(optarg, &params->sched_param);
+			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
 				osnoise_hist_usage("Invalid -P priority");
-			params->set_sched = 1;
+			params->common.set_sched = 1;
 			break;
 		case 'r':
 			params->runtime = get_llong_from_str(optarg);
@@ -621,10 +621,10 @@ static struct osnoise_params
 				osnoise_hist_usage("Runtime shorter than 100 us\n");
 			break;
 		case 's':
-			params->stop_us = get_llong_from_str(optarg);
+			params->common.stop_us = get_llong_from_str(optarg);
 			break;
 		case 'S':
-			params->stop_total_us = get_llong_from_str(optarg);
+			params->common.stop_total_us = get_llong_from_str(optarg);
 			break;
 		case 'T':
 			params->threshold = get_llong_from_str(optarg);
@@ -653,8 +653,8 @@ static struct osnoise_params
 			params->with_zeros = 1;
 			break;
 		case '4': /* trigger */
-			if (params->events) {
-				retval = trace_event_add_trigger(params->events, optarg);
+			if (params->common.events) {
+				retval = trace_event_add_trigger(params->common.events, optarg);
 				if (retval) {
 					err_msg("Error adding trigger %s\n", optarg);
 					exit(EXIT_FAILURE);
@@ -664,8 +664,8 @@ static struct osnoise_params
 			}
 			break;
 		case '5': /* filter */
-			if (params->events) {
-				retval = trace_event_add_filter(params->events, optarg);
+			if (params->common.events) {
+				retval = trace_event_add_filter(params->common.events, optarg);
 				if (retval) {
 					err_msg("Error adding filter %s\n", optarg);
 					exit(EXIT_FAILURE);
@@ -675,10 +675,10 @@ static struct osnoise_params
 			}
 			break;
 		case '6':
-			params->warmup = get_llong_from_str(optarg);
+			params->common.warmup = get_llong_from_str(optarg);
 			break;
 		case '7':
-			params->buffer_size = get_llong_from_str(optarg);
+			params->common.buffer_size = get_llong_from_str(optarg);
 			break;
 		default:
 			osnoise_hist_usage("Invalid option");
@@ -755,9 +755,9 @@ static void
 osnoise_hist_set_signals(struct osnoise_params *params)
 {
 	signal(SIGINT, stop_hist);
-	if (params->duration) {
+	if (params->common.duration) {
 		signal(SIGALRM, stop_hist);
-		alarm(params->duration);
+		alarm(params->common.duration);
 	}
 }
 
@@ -798,16 +798,16 @@ int osnoise_hist_main(int argc, char *argv[])
 	if (retval)
 		goto out_destroy;
 
-	if (params->set_sched) {
-		retval = set_comm_sched_attr("osnoise/", &params->sched_param);
+	if (params->common.set_sched) {
+		retval = set_comm_sched_attr("osnoise/", &params->common.sched_param);
 		if (retval) {
 			err_msg("Failed to set sched parameters\n");
 			goto out_free;
 		}
 	}
 
-	if (params->cgroup) {
-		retval = set_comm_cgroup("timerlat/", params->cgroup_name);
+	if (params->common.cgroup) {
+		retval = set_comm_cgroup("timerlat/", params->common.cgroup_name);
 		if (!retval) {
 			err_msg("Failed to move threads to cgroup\n");
 			goto out_free;
@@ -821,14 +821,14 @@ int osnoise_hist_main(int argc, char *argv[])
 			goto out_free;
 		}
 
-		if (params->events) {
-			retval = trace_events_enable(&record->trace, params->events);
+		if (params->common.events) {
+			retval = trace_events_enable(&record->trace, params->common.events);
 			if (retval)
 				goto out_hist;
 		}
 
-		if (params->buffer_size > 0) {
-			retval = trace_set_buffer_size(&record->trace, params->buffer_size);
+		if (params->common.buffer_size > 0) {
+			retval = trace_set_buffer_size(&record->trace, params->common.buffer_size);
 			if (retval)
 				goto out_hist;
 		}
@@ -845,9 +845,9 @@ int osnoise_hist_main(int argc, char *argv[])
 		trace_instance_start(&record->trace);
 	trace_instance_start(trace);
 
-	if (params->warmup > 0) {
-		debug_msg("Warming up for %d seconds\n", params->warmup);
-		sleep(params->warmup);
+	if (params->common.warmup > 0) {
+		debug_msg("Warming up for %d seconds\n", params->common.warmup);
+		sleep(params->common.warmup);
 		if (stop_tracing)
 			goto out_hist;
 
@@ -868,7 +868,7 @@ int osnoise_hist_main(int argc, char *argv[])
 	osnoise_hist_set_signals(params);
 
 	while (!stop_tracing) {
-		sleep(params->sleep_time);
+		sleep(params->common.sleep_time);
 
 		retval = tracefs_iterate_raw_events(trace->tep,
 						    trace->inst,
@@ -899,8 +899,8 @@ int osnoise_hist_main(int argc, char *argv[])
 	}
 
 out_hist:
-	trace_events_destroy(&record->trace, params->events);
-	params->events = NULL;
+	trace_events_destroy(&record->trace, params->common.events);
+	params->common.events = NULL;
 out_free:
 	osnoise_free_histogram(tool->data);
 out_destroy:
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 2c12780c8aa9..ad5daa8210aa 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -238,7 +238,7 @@ osnoise_print_stats(struct osnoise_params *params, struct osnoise_tool *top)
 	osnoise_top_header(top);
 
 	for (i = 0; i < nr_cpus; i++) {
-		if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
 			continue;
 		osnoise_top_print(top, i);
 	}
@@ -377,7 +377,7 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 		switch (c) {
 		case 'a':
 			/* set sample stop to auto_thresh */
-			params->stop_us = get_llong_from_str(optarg);
+			params->common.stop_us = get_llong_from_str(optarg);
 
 			/* set sample threshold to 1 */
 			params->threshold = 1;
@@ -387,27 +387,27 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 
 			break;
 		case 'c':
-			retval = parse_cpu_set(optarg, &params->monitored_cpus);
+			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
 				osnoise_top_usage(params, "\nInvalid -c cpu list\n");
-			params->cpus = optarg;
+			params->common.cpus = optarg;
 			break;
 		case 'C':
-			params->cgroup = 1;
+			params->common.cgroup = 1;
 			if (!optarg) {
 				/* will inherit this cgroup */
-				params->cgroup_name = NULL;
+				params->common.cgroup_name = NULL;
 			} else if (*optarg == '=') {
 				/* skip the = */
-				params->cgroup_name = ++optarg;
+				params->common.cgroup_name = ++optarg;
 			}
 			break;
 		case 'D':
 			config_debug = 1;
 			break;
 		case 'd':
-			params->duration = parse_seconds_duration(optarg);
-			if (!params->duration)
+			params->common.duration = parse_seconds_duration(optarg);
+			if (!params->common.duration)
 				osnoise_top_usage(params, "Invalid -d duration\n");
 			break;
 		case 'e':
@@ -417,9 +417,9 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 				exit(EXIT_FAILURE);
 			}
 
-			if (params->events)
-				tevent->next = params->events;
-			params->events = tevent;
+			if (params->common.events)
+				tevent->next = params->common.events;
+			params->common.events = tevent;
 
 			break;
 		case 'h':
@@ -427,8 +427,8 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 			osnoise_top_usage(params, NULL);
 			break;
 		case 'H':
-			params->hk_cpus = 1;
-			retval = parse_cpu_set(optarg, &params->hk_cpu_set);
+			params->common.hk_cpus = 1;
+			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
 			if (retval) {
 				err_msg("Error parsing house keeping CPUs\n");
 				exit(EXIT_FAILURE);
@@ -440,10 +440,10 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 				osnoise_top_usage(params, "Period longer than 10 s\n");
 			break;
 		case 'P':
-			retval = parse_prio(optarg, &params->sched_param);
+			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
 				osnoise_top_usage(params, "Invalid -P priority");
-			params->set_sched = 1;
+			params->common.set_sched = 1;
 			break;
 		case 'q':
 			params->quiet = 1;
@@ -454,10 +454,10 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 				osnoise_top_usage(params, "Runtime shorter than 100 us\n");
 			break;
 		case 's':
-			params->stop_us = get_llong_from_str(optarg);
+			params->common.stop_us = get_llong_from_str(optarg);
 			break;
 		case 'S':
-			params->stop_total_us = get_llong_from_str(optarg);
+			params->common.stop_total_us = get_llong_from_str(optarg);
 			break;
 		case 't':
 			if (optarg) {
@@ -474,8 +474,8 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 			params->threshold = get_llong_from_str(optarg);
 			break;
 		case '0': /* trigger */
-			if (params->events) {
-				retval = trace_event_add_trigger(params->events, optarg);
+			if (params->common.events) {
+				retval = trace_event_add_trigger(params->common.events, optarg);
 				if (retval) {
 					err_msg("Error adding trigger %s\n", optarg);
 					exit(EXIT_FAILURE);
@@ -485,8 +485,8 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 			}
 			break;
 		case '1': /* filter */
-			if (params->events) {
-				retval = trace_event_add_filter(params->events, optarg);
+			if (params->common.events) {
+				retval = trace_event_add_filter(params->common.events, optarg);
 				if (retval) {
 					err_msg("Error adding filter %s\n", optarg);
 					exit(EXIT_FAILURE);
@@ -496,10 +496,10 @@ struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 			}
 			break;
 		case '2':
-			params->warmup = get_llong_from_str(optarg);
+			params->common.warmup = get_llong_from_str(optarg);
 			break;
 		case '3':
-			params->buffer_size = get_llong_from_str(optarg);
+			params->common.buffer_size = get_llong_from_str(optarg);
 			break;
 		default:
 			osnoise_top_usage(params, "Invalid option");
@@ -583,9 +583,9 @@ static void stop_top(int sig)
 static void osnoise_top_set_signals(struct osnoise_params *params)
 {
 	signal(SIGINT, stop_top);
-	if (params->duration) {
+	if (params->common.duration) {
 		signal(SIGALRM, stop_top);
-		alarm(params->duration);
+		alarm(params->common.duration);
 	}
 }
 
@@ -622,16 +622,16 @@ int osnoise_top_main(int argc, char **argv)
 		goto out_free;
 	}
 
-	if (params->set_sched) {
-		retval = set_comm_sched_attr("osnoise/", &params->sched_param);
+	if (params->common.set_sched) {
+		retval = set_comm_sched_attr("osnoise/", &params->common.sched_param);
 		if (retval) {
 			err_msg("Failed to set sched parameters\n");
 			goto out_free;
 		}
 	}
 
-	if (params->cgroup) {
-		retval = set_comm_cgroup("osnoise/", params->cgroup_name);
+	if (params->common.cgroup) {
+		retval = set_comm_cgroup("osnoise/", params->common.cgroup_name);
 		if (!retval) {
 			err_msg("Failed to move threads to cgroup\n");
 			goto out_free;
@@ -645,14 +645,14 @@ int osnoise_top_main(int argc, char **argv)
 			goto out_free;
 		}
 
-		if (params->events) {
-			retval = trace_events_enable(&record->trace, params->events);
+		if (params->common.events) {
+			retval = trace_events_enable(&record->trace, params->common.events);
 			if (retval)
 				goto out_top;
 		}
 
-		if (params->buffer_size > 0) {
-			retval = trace_set_buffer_size(&record->trace, params->buffer_size);
+		if (params->common.buffer_size > 0) {
+			retval = trace_set_buffer_size(&record->trace, params->common.buffer_size);
 			if (retval)
 				goto out_top;
 		}
@@ -669,9 +669,9 @@ int osnoise_top_main(int argc, char **argv)
 		trace_instance_start(&record->trace);
 	trace_instance_start(trace);
 
-	if (params->warmup > 0) {
-		debug_msg("Warming up for %d seconds\n", params->warmup);
-		sleep(params->warmup);
+	if (params->common.warmup > 0) {
+		debug_msg("Warming up for %d seconds\n", params->common.warmup);
+		sleep(params->common.warmup);
 		if (stop_tracing)
 			goto out_top;
 
@@ -692,7 +692,7 @@ int osnoise_top_main(int argc, char **argv)
 	osnoise_top_set_signals(params);
 
 	while (!stop_tracing) {
-		sleep(params->sleep_time);
+		sleep(params->common.sleep_time);
 
 		retval = tracefs_iterate_raw_events(trace->tep,
 						    trace->inst,
@@ -725,8 +725,8 @@ int osnoise_top_main(int argc, char **argv)
 	}
 
 out_top:
-	trace_events_destroy(&record->trace, params->events);
-	params->events = NULL;
+	trace_events_destroy(&record->trace, params->common.events);
+	params->common.events = NULL;
 out_free:
 	osnoise_free_top(tool->data);
 	osnoise_destroy_tool(record);
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 63d6d43eafff..0b2f03e1e612 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -26,18 +26,18 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 {
 	int retval, i;
 
-	if (!params->sleep_time)
-		params->sleep_time = 1;
+	if (!params->common.sleep_time)
+		params->common.sleep_time = 1;
 
-	retval = osnoise_set_cpus(tool->context, params->cpus ? params->cpus : "all");
+	retval = osnoise_set_cpus(tool->context, params->common.cpus ? params->common.cpus : "all");
 	if (retval) {
 		err_msg("Failed to apply CPUs config\n");
 		goto out_err;
 	}
 
-	if (!params->cpus) {
+	if (!params->common.cpus) {
 		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
-			CPU_SET(i, &params->monitored_cpus);
+			CPU_SET(i, &params->common.monitored_cpus);
 	}
 
 	if (params->mode != TRACING_MODE_BPF) {
@@ -45,13 +45,13 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 		 * In tracefs and mixed mode, timerlat tracer handles stopping
 		 * on threshold
 		 */
-		retval = osnoise_set_stop_us(tool->context, params->stop_us);
+		retval = osnoise_set_stop_us(tool->context, params->common.stop_us);
 		if (retval) {
 			err_msg("Failed to set stop us\n");
 			goto out_err;
 		}
 
-		retval = osnoise_set_stop_total_us(tool->context, params->stop_total_us);
+		retval = osnoise_set_stop_total_us(tool->context, params->common.stop_total_us);
 		if (retval) {
 			err_msg("Failed to set stop total us\n");
 			goto out_err;
@@ -75,14 +75,14 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 		goto out_err;
 	}
 
-	if (params->hk_cpus) {
-		retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
-					   &params->hk_cpu_set);
+	if (params->common.hk_cpus) {
+		retval = sched_setaffinity(getpid(), sizeof(params->common.hk_cpu_set),
+					   &params->common.hk_cpu_set);
 		if (retval == -1) {
 			err_msg("Failed to set rtla to the house keeping CPUs\n");
 			goto out_err;
 		}
-	} else if (params->cpus) {
+	} else if (params->common.cpus) {
 		/*
 		 * Even if the user do not set a house-keeping CPU, try to
 		 * move rtla to a CPU set different to the one where the user
@@ -90,7 +90,7 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 		 *
 		 * No need to check results as this is an automatic attempt.
 		 */
-		auto_house_keeping(&params->monitored_cpus);
+		auto_house_keeping(&params->common.monitored_cpus);
 	}
 
 	/*
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index bc55ed04fc96..dd9e0f05bdad 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -20,33 +20,17 @@ enum timerlat_tracing_mode {
 };
 
 struct timerlat_params {
-	/* Common params */
-	char			*cpus;
-	cpu_set_t		monitored_cpus;
-	char			*cgroup_name;
-	unsigned long long	runtime;
-	long long		stop_us;
-	long long		stop_total_us;
+	struct common_params	common;
 	long long		timerlat_period_us;
 	long long		print_stack;
-	int			sleep_time;
 	int			output_divisor;
-	int			duration;
-	int			set_sched;
 	int			dma_latency;
 	int			no_aa;
 	int			dump_tasks;
-	int			cgroup;
-	int			hk_cpus;
 	int			user_workload;
 	int			kernel_workload;
 	int			user_data;
-	int			warmup;
-	int			buffer_size;
 	int			deepest_idle_state;
-	cpu_set_t		hk_cpu_set;
-	struct sched_attr	sched_param;
-	struct trace_events	*events;
 	enum timerlat_tracing_mode mode;
 
 	struct actions threshold_actions;
diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index 1666215dd687..a6c77ac55e00 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.c
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -23,8 +23,8 @@ int timerlat_bpf_init(struct timerlat_params *params)
 	/* Pass common options */
 	bpf->rodata->output_divisor = params->output_divisor;
 	bpf->rodata->entries = params->entries;
-	bpf->rodata->irq_threshold = params->stop_us;
-	bpf->rodata->thread_threshold = params->stop_total_us;
+	bpf->rodata->irq_threshold = params->common.stop_us;
+	bpf->rodata->thread_threshold = params->common.stop_total_us;
 	bpf->rodata->aa_only = params->aa_only;
 
 	if (params->entries != 0) {
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 9baea1b251ed..a3de644f2b75 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -303,7 +303,7 @@ static void timerlat_hist_header(struct osnoise_tool *tool)
 		trace_seq_printf(s, "Index");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -357,7 +357,7 @@ timerlat_print_summary(struct timerlat_params *params,
 		trace_seq_printf(trace->seq, "count:");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -381,7 +381,7 @@ timerlat_print_summary(struct timerlat_params *params,
 		trace_seq_printf(trace->seq, "min:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -411,7 +411,7 @@ timerlat_print_summary(struct timerlat_params *params,
 		trace_seq_printf(trace->seq, "avg:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -441,7 +441,7 @@ timerlat_print_summary(struct timerlat_params *params,
 		trace_seq_printf(trace->seq, "max:  ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -488,7 +488,7 @@ timerlat_print_stats_all(struct timerlat_params *params,
 	sum.min_user = ~0;
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -636,7 +636,7 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *tool)
 					 bucket * data->bucket_size);
 
 		for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-			if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+			if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 				continue;
 
 			if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -676,7 +676,7 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *tool)
 		trace_seq_printf(trace->seq, "over: ");
 
 	for (cpu = 0; cpu < data->nr_cpus; cpu++) {
-		if (params->cpus && !CPU_ISSET(cpu, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(cpu, &params->common.monitored_cpus))
 			continue;
 
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
@@ -867,8 +867,8 @@ static struct timerlat_params
 			auto_thresh = get_llong_from_str(optarg);
 
 			/* set thread stop to auto_thresh */
-			params->stop_total_us = auto_thresh;
-			params->stop_us = auto_thresh;
+			params->common.stop_total_us = auto_thresh;
+			params->common.stop_us = auto_thresh;
 
 			/* get stack trace */
 			params->print_stack = auto_thresh;
@@ -878,19 +878,19 @@ static struct timerlat_params
 
 			break;
 		case 'c':
-			retval = parse_cpu_set(optarg, &params->monitored_cpus);
+			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
 				timerlat_hist_usage("\nInvalid -c cpu list\n");
-			params->cpus = optarg;
+			params->common.cpus = optarg;
 			break;
 		case 'C':
-			params->cgroup = 1;
+			params->common.cgroup = 1;
 			if (!optarg) {
 				/* will inherit this cgroup */
-				params->cgroup_name = NULL;
+				params->common.cgroup_name = NULL;
 			} else if (*optarg == '=') {
 				/* skip the = */
-				params->cgroup_name = ++optarg;
+				params->common.cgroup_name = ++optarg;
 			}
 			break;
 		case 'b':
@@ -902,8 +902,8 @@ static struct timerlat_params
 			config_debug = 1;
 			break;
 		case 'd':
-			params->duration = parse_seconds_duration(optarg);
-			if (!params->duration)
+			params->common.duration = parse_seconds_duration(optarg);
+			if (!params->common.duration)
 				timerlat_hist_usage("Invalid -D duration\n");
 			break;
 		case 'e':
@@ -913,10 +913,10 @@ static struct timerlat_params
 				exit(EXIT_FAILURE);
 			}
 
-			if (params->events)
-				tevent->next = params->events;
+			if (params->common.events)
+				tevent->next = params->common.events;
 
-			params->events = tevent;
+			params->common.events = tevent;
 			break;
 		case 'E':
 			params->entries = get_llong_from_str(optarg);
@@ -928,15 +928,15 @@ static struct timerlat_params
 			timerlat_hist_usage(NULL);
 			break;
 		case 'H':
-			params->hk_cpus = 1;
-			retval = parse_cpu_set(optarg, &params->hk_cpu_set);
+			params->common.hk_cpus = 1;
+			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
 			if (retval) {
 				err_msg("Error parsing house keeping CPUs\n");
 				exit(EXIT_FAILURE);
 			}
 			break;
 		case 'i':
-			params->stop_us = get_llong_from_str(optarg);
+			params->common.stop_us = get_llong_from_str(optarg);
 			break;
 		case 'k':
 			params->kernel_workload = 1;
@@ -950,16 +950,16 @@ static struct timerlat_params
 				timerlat_hist_usage("Period longer than 1 s\n");
 			break;
 		case 'P':
-			retval = parse_prio(optarg, &params->sched_param);
+			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
 				timerlat_hist_usage("Invalid -P priority");
-			params->set_sched = 1;
+			params->common.set_sched = 1;
 			break;
 		case 's':
 			params->print_stack = get_llong_from_str(optarg);
 			break;
 		case 'T':
-			params->stop_total_us = get_llong_from_str(optarg);
+			params->common.stop_total_us = get_llong_from_str(optarg);
 			break;
 		case 't':
 			if (optarg) {
@@ -997,8 +997,8 @@ static struct timerlat_params
 			params->with_zeros = 1;
 			break;
 		case '6': /* trigger */
-			if (params->events) {
-				retval = trace_event_add_trigger(params->events, optarg);
+			if (params->common.events) {
+				retval = trace_event_add_trigger(params->common.events, optarg);
 				if (retval) {
 					err_msg("Error adding trigger %s\n", optarg);
 					exit(EXIT_FAILURE);
@@ -1008,8 +1008,8 @@ static struct timerlat_params
 			}
 			break;
 		case '7': /* filter */
-			if (params->events) {
-				retval = trace_event_add_filter(params->events, optarg);
+			if (params->common.events) {
+				retval = trace_event_add_filter(params->common.events, optarg);
 				if (retval) {
 					err_msg("Error adding filter %s\n", optarg);
 					exit(EXIT_FAILURE);
@@ -1032,10 +1032,10 @@ static struct timerlat_params
 			params->dump_tasks = 1;
 			break;
 		case '\2':
-			params->warmup = get_llong_from_str(optarg);
+			params->common.warmup = get_llong_from_str(optarg);
 			break;
 		case '\3':
-			params->buffer_size = get_llong_from_str(optarg);
+			params->common.buffer_size = get_llong_from_str(optarg);
 			break;
 		case '\4':
 			params->deepest_idle_state = get_llong_from_str(optarg);
@@ -1076,7 +1076,7 @@ static struct timerlat_params
 	/*
 	 * Auto analysis only happens if stop tracing, thus:
 	 */
-	if (!params->stop_us && !params->stop_total_us)
+	if (!params->common.stop_us && !params->common.stop_total_us)
 		params->no_aa = 1;
 
 	if (params->kernel_workload && params->user_workload)
@@ -1167,9 +1167,9 @@ static void
 timerlat_hist_set_signals(struct timerlat_params *params)
 {
 	signal(SIGINT, stop_hist);
-	if (params->duration) {
+	if (params->common.duration) {
 		signal(SIGALRM, stop_hist);
-		alarm(params->duration);
+		alarm(params->common.duration);
 	}
 }
 
@@ -1235,16 +1235,16 @@ int timerlat_hist_main(int argc, char *argv[])
 		goto out_free;
 	}
 
-	if (params->set_sched) {
-		retval = set_comm_sched_attr("timerlat/", &params->sched_param);
+	if (params->common.set_sched) {
+		retval = set_comm_sched_attr("timerlat/", &params->common.sched_param);
 		if (retval) {
 			err_msg("Failed to set sched parameters\n");
 			goto out_free;
 		}
 	}
 
-	if (params->cgroup && !params->user_workload) {
-		retval = set_comm_cgroup("timerlat/", params->cgroup_name);
+	if (params->common.cgroup && !params->user_workload) {
+		retval = set_comm_cgroup("timerlat/", params->common.cgroup_name);
 		if (!retval) {
 			err_msg("Failed to move threads to cgroup\n");
 			goto out_free;
@@ -1268,7 +1268,7 @@ int timerlat_hist_main(int argc, char *argv[])
 		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 		for (i = 0; i < nr_cpus; i++) {
-			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+			if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
 				continue;
 			if (save_cpu_idle_disable_state(i) < 0) {
 				err_msg("Could not save cpu idle state.\n");
@@ -1291,14 +1291,14 @@ int timerlat_hist_main(int argc, char *argv[])
 		params->threshold_actions.trace_output_inst = record->trace.inst;
 		params->end_actions.trace_output_inst = record->trace.inst;
 
-		if (params->events) {
-			retval = trace_events_enable(&record->trace, params->events);
+		if (params->common.events) {
+			retval = trace_events_enable(&record->trace, params->common.events);
 			if (retval)
 				goto out_hist;
 		}
 
-		if (params->buffer_size > 0) {
-			retval = trace_set_buffer_size(&record->trace, params->buffer_size);
+		if (params->common.buffer_size > 0) {
+			retval = trace_set_buffer_size(&record->trace, params->common.buffer_size);
 			if (retval)
 				goto out_hist;
 		}
@@ -1328,22 +1328,22 @@ int timerlat_hist_main(int argc, char *argv[])
 		/* all threads left */
 		params_u.stopped_running = 0;
 
-		params_u.set = &params->monitored_cpus;
-		if (params->set_sched)
-			params_u.sched_param = &params->sched_param;
+		params_u.set = &params->common.monitored_cpus;
+		if (params->common.set_sched)
+			params_u.sched_param = &params->common.sched_param;
 		else
 			params_u.sched_param = NULL;
 
-		params_u.cgroup_name = params->cgroup_name;
+		params_u.cgroup_name = params->common.cgroup_name;
 
 		retval = pthread_create(&timerlat_u, NULL, timerlat_u_dispatcher, &params_u);
 		if (retval)
 			err_msg("Error creating timerlat user-space threads\n");
 	}
 
-	if (params->warmup > 0) {
-		debug_msg("Warming up for %d seconds\n", params->warmup);
-		sleep(params->warmup);
+	if (params->common.warmup > 0) {
+		debug_msg("Warming up for %d seconds\n", params->common.warmup);
+		sleep(params->common.warmup);
 		if (stop_tracing)
 			goto out_hist;
 	}
@@ -1374,7 +1374,7 @@ int timerlat_hist_main(int argc, char *argv[])
 
 	if (params->mode == TRACING_MODE_TRACEFS) {
 		while (!stop_tracing) {
-			sleep(params->sleep_time);
+			sleep(params->common.sleep_time);
 
 			retval = tracefs_iterate_raw_events(trace->tep,
 							    trace->inst,
@@ -1456,7 +1456,8 @@ int timerlat_hist_main(int argc, char *argv[])
 		printf("rtla timerlat hit stop tracing\n");
 
 		if (!params->no_aa)
-			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
+			timerlat_auto_analysis(params->common.stop_us,
+					       params->common.stop_total_us);
 
 		return_value = FAILED;
 	}
@@ -1467,13 +1468,13 @@ int timerlat_hist_main(int argc, char *argv[])
 		close(dma_latency_fd);
 	if (params->deepest_idle_state >= -1) {
 		for (i = 0; i < nr_cpus; i++) {
-			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+			if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
 				continue;
 			restore_cpu_idle_disable_state(i);
 		}
 	}
-	trace_events_destroy(&record->trace, params->events);
-	params->events = NULL;
+	trace_events_destroy(&record->trace, params->common.events);
+	params->common.events = NULL;
 out_free:
 	timerlat_free_histogram(tool->data);
 	osnoise_destroy_tool(aa);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index c80b81c0b4da..9fb60f4dd092 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -457,7 +457,7 @@ timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *top)
 	timerlat_top_header(params, top);
 
 	for (i = 0; i < nr_cpus; i++) {
-		if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+		if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
 			continue;
 		timerlat_top_print(top, i);
 		timerlat_top_update_sum(top, i, &summary);
@@ -618,8 +618,8 @@ static struct timerlat_params
 			auto_thresh = get_llong_from_str(optarg);
 
 			/* set thread stop to auto_thresh */
-			params->stop_total_us = auto_thresh;
-			params->stop_us = auto_thresh;
+			params->common.stop_total_us = auto_thresh;
+			params->common.stop_us = auto_thresh;
 
 			/* get stack trace */
 			params->print_stack = auto_thresh;
@@ -633,8 +633,8 @@ static struct timerlat_params
 			auto_thresh = get_llong_from_str(optarg);
 
 			/* set thread stop to auto_thresh */
-			params->stop_total_us = auto_thresh;
-			params->stop_us = auto_thresh;
+			params->common.stop_total_us = auto_thresh;
+			params->common.stop_us = auto_thresh;
 
 			/* get stack trace */
 			params->print_stack = auto_thresh;
@@ -643,27 +643,27 @@ static struct timerlat_params
 			params->aa_only = 1;
 			break;
 		case 'c':
-			retval = parse_cpu_set(optarg, &params->monitored_cpus);
+			retval = parse_cpu_set(optarg, &params->common.monitored_cpus);
 			if (retval)
 				timerlat_top_usage("\nInvalid -c cpu list\n");
-			params->cpus = optarg;
+			params->common.cpus = optarg;
 			break;
 		case 'C':
-			params->cgroup = 1;
+			params->common.cgroup = 1;
 			if (!optarg) {
 				/* will inherit this cgroup */
-				params->cgroup_name = NULL;
+				params->common.cgroup_name = NULL;
 			} else if (*optarg == '=') {
 				/* skip the = */
-				params->cgroup_name = ++optarg;
+				params->common.cgroup_name = ++optarg;
 			}
 			break;
 		case 'D':
 			config_debug = 1;
 			break;
 		case 'd':
-			params->duration = parse_seconds_duration(optarg);
-			if (!params->duration)
+			params->common.duration = parse_seconds_duration(optarg);
+			if (!params->common.duration)
 				timerlat_top_usage("Invalid -d duration\n");
 			break;
 		case 'e':
@@ -673,24 +673,24 @@ static struct timerlat_params
 				exit(EXIT_FAILURE);
 			}
 
-			if (params->events)
-				tevent->next = params->events;
-			params->events = tevent;
+			if (params->common.events)
+				tevent->next = params->common.events;
+			params->common.events = tevent;
 			break;
 		case 'h':
 		case '?':
 			timerlat_top_usage(NULL);
 			break;
 		case 'H':
-			params->hk_cpus = 1;
-			retval = parse_cpu_set(optarg, &params->hk_cpu_set);
+			params->common.hk_cpus = 1;
+			retval = parse_cpu_set(optarg, &params->common.hk_cpu_set);
 			if (retval) {
 				err_msg("Error parsing house keeping CPUs\n");
 				exit(EXIT_FAILURE);
 			}
 			break;
 		case 'i':
-			params->stop_us = get_llong_from_str(optarg);
+			params->common.stop_us = get_llong_from_str(optarg);
 			break;
 		case 'k':
 			params->kernel_workload = true;
@@ -704,10 +704,10 @@ static struct timerlat_params
 				timerlat_top_usage("Period longer than 1 s\n");
 			break;
 		case 'P':
-			retval = parse_prio(optarg, &params->sched_param);
+			retval = parse_prio(optarg, &params->common.sched_param);
 			if (retval == -1)
 				timerlat_top_usage("Invalid -P priority");
-			params->set_sched = 1;
+			params->common.set_sched = 1;
 			break;
 		case 'q':
 			params->quiet = 1;
@@ -716,7 +716,7 @@ static struct timerlat_params
 			params->print_stack = get_llong_from_str(optarg);
 			break;
 		case 'T':
-			params->stop_total_us = get_llong_from_str(optarg);
+			params->common.stop_total_us = get_llong_from_str(optarg);
 			break;
 		case 't':
 			if (optarg) {
@@ -736,8 +736,8 @@ static struct timerlat_params
 			params->user_data = true;
 			break;
 		case '0': /* trigger */
-			if (params->events) {
-				retval = trace_event_add_trigger(params->events, optarg);
+			if (params->common.events) {
+				retval = trace_event_add_trigger(params->common.events, optarg);
 				if (retval) {
 					err_msg("Error adding trigger %s\n", optarg);
 					exit(EXIT_FAILURE);
@@ -747,8 +747,8 @@ static struct timerlat_params
 			}
 			break;
 		case '1': /* filter */
-			if (params->events) {
-				retval = trace_event_add_filter(params->events, optarg);
+			if (params->common.events) {
+				retval = trace_event_add_filter(params->common.events, optarg);
 				if (retval) {
 					err_msg("Error adding filter %s\n", optarg);
 					exit(EXIT_FAILURE);
@@ -771,10 +771,10 @@ static struct timerlat_params
 			params->dump_tasks = 1;
 			break;
 		case '6':
-			params->warmup = get_llong_from_str(optarg);
+			params->common.warmup = get_llong_from_str(optarg);
 			break;
 		case '7':
-			params->buffer_size = get_llong_from_str(optarg);
+			params->common.buffer_size = get_llong_from_str(optarg);
 			break;
 		case '8':
 			params->deepest_idle_state = get_llong_from_str(optarg);
@@ -809,7 +809,7 @@ static struct timerlat_params
 	/*
 	 * Auto analysis only happens if stop tracing, thus:
 	 */
-	if (!params->stop_us && !params->stop_total_us)
+	if (!params->common.stop_us && !params->common.stop_total_us)
 		params->no_aa = 1;
 
 	if (params->no_aa && params->aa_only)
@@ -906,9 +906,9 @@ static void
 timerlat_top_set_signals(struct timerlat_params *params)
 {
 	signal(SIGINT, stop_top);
-	if (params->duration) {
+	if (params->common.duration) {
 		signal(SIGALRM, stop_top);
-		alarm(params->duration);
+		alarm(params->common.duration);
 	}
 }
 
@@ -926,7 +926,7 @@ timerlat_top_main_loop(struct osnoise_tool *top,
 	int retval;
 
 	while (!stop_tracing) {
-		sleep(params->sleep_time);
+		sleep(params->common.sleep_time);
 
 		if (params->aa_only && !osnoise_trace_is_off(top, record))
 			continue;
@@ -992,7 +992,7 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *top,
 
 	/* Pull and display data in a loop */
 	while (!stop_tracing) {
-		wait_retval = timerlat_bpf_wait(params->quiet ? -1 : params->sleep_time);
+		wait_retval = timerlat_bpf_wait(params->quiet ? -1 : params->common.sleep_time);
 
 		retval = timerlat_top_bpf_pull_data(top);
 		if (retval) {
@@ -1094,16 +1094,16 @@ int timerlat_top_main(int argc, char *argv[])
 		goto out_free;
 	}
 
-	if (params->set_sched) {
-		retval = set_comm_sched_attr("timerlat/", &params->sched_param);
+	if (params->common.set_sched) {
+		retval = set_comm_sched_attr("timerlat/", &params->common.sched_param);
 		if (retval) {
 			err_msg("Failed to set sched parameters\n");
 			goto out_free;
 		}
 	}
 
-	if (params->cgroup && !params->user_data) {
-		retval = set_comm_cgroup("timerlat/", params->cgroup_name);
+	if (params->common.cgroup && !params->user_data) {
+		retval = set_comm_cgroup("timerlat/", params->common.cgroup_name);
 		if (!retval) {
 			err_msg("Failed to move threads to cgroup\n");
 			goto out_free;
@@ -1127,7 +1127,7 @@ int timerlat_top_main(int argc, char *argv[])
 		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 		for (i = 0; i < nr_cpus; i++) {
-			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+			if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
 				continue;
 			if (save_cpu_idle_disable_state(i) < 0) {
 				err_msg("Could not save cpu idle state.\n");
@@ -1150,14 +1150,14 @@ int timerlat_top_main(int argc, char *argv[])
 		params->threshold_actions.trace_output_inst = record->trace.inst;
 		params->end_actions.trace_output_inst = record->trace.inst;
 
-		if (params->events) {
-			retval = trace_events_enable(&record->trace, params->events);
+		if (params->common.events) {
+			retval = trace_events_enable(&record->trace, params->common.events);
 			if (retval)
 				goto out_top;
 		}
 
-		if (params->buffer_size > 0) {
-			retval = trace_set_buffer_size(&record->trace, params->buffer_size);
+		if (params->common.buffer_size > 0) {
+			retval = trace_set_buffer_size(&record->trace, params->common.buffer_size);
 			if (retval)
 				goto out_top;
 		}
@@ -1190,22 +1190,22 @@ int timerlat_top_main(int argc, char *argv[])
 		/* all threads left */
 		params_u.stopped_running = 0;
 
-		params_u.set = &params->monitored_cpus;
-		if (params->set_sched)
-			params_u.sched_param = &params->sched_param;
+		params_u.set = &params->common.monitored_cpus;
+		if (params->common.set_sched)
+			params_u.sched_param = &params->common.sched_param;
 		else
 			params_u.sched_param = NULL;
 
-		params_u.cgroup_name = params->cgroup_name;
+		params_u.cgroup_name = params->common.cgroup_name;
 
 		retval = pthread_create(&timerlat_u, NULL, timerlat_u_dispatcher, &params_u);
 		if (retval)
 			err_msg("Error creating timerlat user-space threads\n");
 	}
 
-	if (params->warmup > 0) {
-		debug_msg("Warming up for %d seconds\n", params->warmup);
-		sleep(params->warmup);
+	if (params->common.warmup > 0) {
+		debug_msg("Warming up for %d seconds\n", params->common.warmup);
+		sleep(params->common.warmup);
 	}
 
 	/*
@@ -1258,7 +1258,8 @@ int timerlat_top_main(int argc, char *argv[])
 		printf("rtla timerlat hit stop tracing\n");
 
 		if (!params->no_aa)
-			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
+			timerlat_auto_analysis(params->common.stop_us,
+					       params->common.stop_total_us);
 
 		return_value = FAILED;
 	} else if (params->aa_only) {
@@ -1279,13 +1280,13 @@ int timerlat_top_main(int argc, char *argv[])
 		close(dma_latency_fd);
 	if (params->deepest_idle_state >= -1) {
 		for (i = 0; i < nr_cpus; i++) {
-			if (params->cpus && !CPU_ISSET(i, &params->monitored_cpus))
+			if (params->common.cpus && !CPU_ISSET(i, &params->common.monitored_cpus))
 				continue;
 			restore_cpu_idle_disable_state(i);
 		}
 	}
-	trace_events_destroy(&record->trace, params->events);
-	params->events = NULL;
+	trace_events_destroy(&record->trace, params->common.events);
+	params->common.events = NULL;
 out_free:
 	timerlat_free_top(top->data);
 	if (aa && aa != top)
-- 
2.50.1



