Return-Path: <linux-kernel+bounces-704447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BD3AE9DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 14:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360B83AB4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 12:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EF32E11C2;
	Thu, 26 Jun 2025 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HF79Risw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99012E06E4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941378; cv=none; b=s+FCFIysbvlVq+IEHHb7h5MHdI2nFcprklkUiAFnXktsWQDG3C3XZYz3QI1M+UEeus7ieQ0nRa+ewDt/vW7b5W7komkcGHL0NaEQQ36sKvybo3siEI7tXceg/joCyvODckFPJXYmKV34Rlb+d9EYEO8t/MhsNsoy7EcMCx0jSyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941378; c=relaxed/simple;
	bh=e5G1LQaHGKEk+Uq+ZBbUmduHV4uJn9Y27OD86/nVQTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQVyQrUBXfz68TQYqlThW57G23dCFQwMK9IBcaGWzSQU95ptitKJk4ZTy1iy2wLhprAQcfNGXA4OUm2Te1hpO3kz5PdoXHIkLG0IVR2CJsrjK/eeKZJBvBRhVfrrVal1e6UfYVbFiWSgrwnUMUmgmtmgPMcxjjGwIza17zgN5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HF79Risw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750941375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PsKlgJn34is2kOicYgqOhMcE5nDUrsqk6HaC7NVZhto=;
	b=HF79Risw3Q/ilAxX6WTZLG22XJz3dUktgHMis9yGoc5u4b2Lgfg/tgzUlmhMxSngpd+QEH
	Q5J/t5O/qq8098fSMJ7puebtat4SYxeYyNcefMPisesGwjANowgekHIkha6xHC8hYn7unN
	VmckcD1YFKv1JTGZI7m/HjqepoPOqH0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-j9_UXHl_P7SCABDdSeod2g-1; Thu,
 26 Jun 2025 08:36:09 -0400
X-MC-Unique: j9_UXHl_P7SCABDdSeod2g-1
X-Mimecast-MFC-AGG-ID: j9_UXHl_P7SCABDdSeod2g_1750941368
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55ABF1978F63;
	Thu, 26 Jun 2025 12:36:08 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.241])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E801180045B;
	Thu, 26 Jun 2025 12:36:05 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 1/9] rtla/timerlat: Introduce enum timerlat_tracing_mode
Date: Thu, 26 Jun 2025 14:33:57 +0200
Message-ID: <20250626123405.1496931-2-tglozar@redhat.com>
In-Reply-To: <20250626123405.1496931-1-tglozar@redhat.com>
References: <20250626123405.1496931-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
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
2.49.0


