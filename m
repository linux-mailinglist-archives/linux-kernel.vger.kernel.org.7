Return-Path: <linux-kernel+bounces-739964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52774B0CD99
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC90C546841
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDDC24DD1B;
	Mon, 21 Jul 2025 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaudlZIJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A2F245008
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139512; cv=none; b=Tpv1VR7Am3FM8KI/KBlvvkMSt9AxdqJIC2twhdiuGyd6w2/WOjh+KtlKrD7BHNpAb153DQj3SNKV55EG2hvnTqnhAWmwmMIrMfoQFDrXTlRml6wrrPpoqsEDXsMhEeAd8LO43iSE6SIPkEDIPRsaUYskkiTS/bizQuB/fZ5sgLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139512; c=relaxed/simple;
	bh=LVHnQL0MDlysX2xX/2iQYOLlG2OJPiUU5c9ExQc0XXA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VWOzlUpkeAy37rdxsjUZK4BOB38IybDHx3VeIBQAsvRJwEwsZ7te77sClO5yuyQuHGjMydQHoCeAk7UlsakxSo58qlHsiXwjP3czh23kUjgAStQyQMPKzvSpCb2xsasRLlHoMEHY2JA1i24vmdGiX8CwY4i91XpAUE0qir0rZ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaudlZIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32C4C4CEFA;
	Mon, 21 Jul 2025 23:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753139512;
	bh=LVHnQL0MDlysX2xX/2iQYOLlG2OJPiUU5c9ExQc0XXA=;
	h=Date:From:To:Cc:Subject:References:From;
	b=DaudlZIJ9Gy7HnIGdVBCrlO4yQxGbt/X6TswI+uxgicSSRlTMJ0tMBFt5Syjxcn7e
	 w9ZRTrL9T/ervJU0gLglGndn/OQLvWlafzfy131/fLszPpAAanTU24zD6TkGqQBt1Q
	 aawkV9goo0bAmjtk9zRg6uplQVYRh6sIgIAEg2tNEDJa5c/wELu+FDLg6rLWA2FiZK
	 R9fYj+UvmHLzvmJ4jtK2vmi8ZPceLHEqXCDE1hU0NCTvNzGS/Woqtt35prjxo2cCjt
	 O2FY6ZM/SKV1lqFJquGh5ndIF8AZpEcwzBVYjNSD6Nxnlmv824sNsCiL5CaDOR6X2L
	 f8RbgmlkwHSFQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udzgF-00000009vJM-0Rxp;
	Mon, 21 Jul 2025 19:12:23 -0400
Message-ID: <20250721231222.964514612@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 21 Jul 2025 19:12:09 -0400
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
Subject: [for-next][PATCH 5/9] rtla/timerlat: Add action on end feature
References: <20250721231204.100737734@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Implement actions on end next to actions on threshold. A new option,
--on-end is added, parallel to --on-threshold. Instead of being
executed whenever a latency threshold is reached, it is executed at the
end of the measurement.

For example:

$ rtla timerlat hist -d 5s --on-end trace

will save the trace output at the end.

All actions supported by --on-threshold are also supported by --on-end,
except for continue, which does nothing with --on-end.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Chang Yin <cyin@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250626123405.1496931-6-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/timerlat.h      |  5 ++-
 tools/tracing/rtla/src/timerlat_hist.c | 44 +++++++++++++++++--------
 tools/tracing/rtla/src/timerlat_top.c  | 45 ++++++++++++++++++--------
 3 files changed, 65 insertions(+), 29 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index d1fcf9a97621..bc55ed04fc96 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -48,7 +48,10 @@ struct timerlat_params {
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
 	enum timerlat_tracing_mode mode;
-	struct actions actions;
+
+	struct actions threshold_actions;
+	struct actions end_actions;
+
 	union {
 		struct {
 			/* top only */
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4f13a8f92711..9baea1b251ed 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -758,6 +758,7 @@ static void timerlat_hist_usage(char *usage)
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
 		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
 		"	     --on-threshold <action>: define action to be executed at latency threshold, multiple are allowed",
+		"	     --on-end <action>: define action to be executed at measurement end, multiple are allowed",
 		NULL,
 	};
 
@@ -793,7 +794,8 @@ static struct timerlat_params
 	if (!params)
 		exit(1);
 
-	actions_init(&params->actions);
+	actions_init(&params->threshold_actions);
+	actions_init(&params->end_actions);
 
 	/* disabled by default */
 	params->dma_latency = -1;
@@ -846,6 +848,7 @@ static struct timerlat_params
 			{"trace-buffer-size",	required_argument,	0, '\3'},
 			{"deepest-idle-state",	required_argument,	0, '\4'},
 			{"on-threshold",	required_argument,	0, '\5'},
+			{"on-end",		required_argument,	0, '\6'},
 			{0, 0, 0, 0}
 		};
 
@@ -1038,7 +1041,14 @@ static struct timerlat_params
 			params->deepest_idle_state = get_llong_from_str(optarg);
 			break;
 		case '\5':
-			retval = actions_parse(&params->actions, optarg);
+			retval = actions_parse(&params->threshold_actions, optarg);
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
+		case '\6':
+			retval = actions_parse(&params->end_actions, optarg);
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
@@ -1050,7 +1060,7 @@ static struct timerlat_params
 	}
 
 	if (trace_output)
-		actions_add_trace_output(&params->actions, trace_output);
+		actions_add_trace_output(&params->threshold_actions, trace_output);
 
 	if (geteuid()) {
 		err_msg("rtla needs root permission\n");
@@ -1077,7 +1087,8 @@ static struct timerlat_params
 	 * mixed mode
 	 */
 	if (params->mode == TRACING_MODE_BPF &&
-	    (params->actions.present[ACTION_TRACE_OUTPUT] || !params->no_aa))
+	    (params->threshold_actions.present[ACTION_TRACE_OUTPUT] ||
+	     params->end_actions.present[ACTION_TRACE_OUTPUT] || !params->no_aa))
 		params->mode = TRACING_MODE_MIXED;
 
 	return params;
@@ -1270,13 +1281,15 @@ int timerlat_hist_main(int argc, char *argv[])
 		}
 	}
 
-	if (params->actions.present[ACTION_TRACE_OUTPUT]) {
+	if (params->threshold_actions.present[ACTION_TRACE_OUTPUT] ||
+	    params->end_actions.present[ACTION_TRACE_OUTPUT]) {
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
 			goto out_free;
 		}
-		params->actions.trace_output_inst = record->trace.inst;
+		params->threshold_actions.trace_output_inst = record->trace.inst;
+		params->end_actions.trace_output_inst = record->trace.inst;
 
 		if (params->events) {
 			retval = trace_events_enable(&record->trace, params->events);
@@ -1342,7 +1355,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	 * tracing while enabling other instances. The trace instance is the
 	 * one with most valuable information.
 	 */
-	if (params->actions.present[ACTION_TRACE_OUTPUT])
+	if (record)
 		trace_instance_start(&record->trace);
 	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
@@ -1375,14 +1388,14 @@ int timerlat_hist_main(int argc, char *argv[])
 			}
 
 			if (osnoise_trace_is_off(tool, record)) {
-				actions_perform(&params->actions);
+				actions_perform(&params->threshold_actions);
 
-				if (!params->actions.continue_flag)
+				if (!params->threshold_actions.continue_flag)
 					/* continue flag not set, break */
 					break;
 
 				/* continue action reached, re-enable tracing */
-				if (params->actions.present[ACTION_TRACE_OUTPUT])
+				if (record)
 					trace_instance_start(&record->trace);
 				if (!params->no_aa)
 					trace_instance_start(&aa->trace);
@@ -1403,14 +1416,14 @@ int timerlat_hist_main(int argc, char *argv[])
 
 			if (!stop_tracing) {
 				/* Threshold overflow, perform actions on threshold */
-				actions_perform(&params->actions);
+				actions_perform(&params->threshold_actions);
 
-				if (!params->actions.continue_flag)
+				if (!params->threshold_actions.continue_flag)
 					/* continue flag not set, break */
 					break;
 
 				/* continue action reached, re-enable tracing */
-				if (params->actions.present[ACTION_TRACE_OUTPUT])
+				if (record)
 					trace_instance_start(&record->trace);
 				if (!params->no_aa)
 					trace_instance_start(&aa->trace);
@@ -1435,6 +1448,8 @@ int timerlat_hist_main(int argc, char *argv[])
 
 	timerlat_print_stats(params, tool);
 
+	actions_perform(&params->end_actions);
+
 	return_value = PASSED;
 
 	if (osnoise_trace_is_off(tool, record) && !stop_tracing) {
@@ -1464,7 +1479,8 @@ int timerlat_hist_main(int argc, char *argv[])
 	osnoise_destroy_tool(aa);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
-	actions_destroy(&params->actions);
+	actions_destroy(&params->threshold_actions);
+	actions_destroy(&params->end_actions);
 	if (params->mode != TRACING_MODE_TRACEFS)
 		timerlat_bpf_destroy();
 	free(params);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 60f9c78cb272..c80b81c0b4da 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -517,6 +517,7 @@ static void timerlat_top_usage(char *usage)
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
 		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
 		"	     --on-threshold <action>: define action to be executed at latency threshold, multiple are allowed",
+		"	     --on-end: define action to be executed at measurement end, multiple are allowed",
 		NULL,
 	};
 
@@ -552,7 +553,8 @@ static struct timerlat_params
 	if (!params)
 		exit(1);
 
-	actions_init(&params->actions);
+	actions_init(&params->threshold_actions);
+	actions_init(&params->end_actions);
 
 	/* disabled by default */
 	params->dma_latency = -1;
@@ -597,6 +599,7 @@ static struct timerlat_params
 			{"trace-buffer-size",	required_argument,	0, '7'},
 			{"deepest-idle-state",	required_argument,	0, '8'},
 			{"on-threshold",	required_argument,	0, '9'},
+			{"on-end",		required_argument,	0, '\1'},
 			{0, 0, 0, 0}
 		};
 
@@ -623,6 +626,7 @@ static struct timerlat_params
 
 			/* set trace */
 			trace_output = "timerlat_trace.txt";
+
 			break;
 		case '5':
 			/* it is here because it is similar to -a */
@@ -776,7 +780,14 @@ static struct timerlat_params
 			params->deepest_idle_state = get_llong_from_str(optarg);
 			break;
 		case '9':
-			retval = actions_parse(&params->actions, optarg);
+			retval = actions_parse(&params->threshold_actions, optarg);
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
+		case '\1':
+			retval = actions_parse(&params->end_actions, optarg);
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
@@ -788,7 +799,7 @@ static struct timerlat_params
 	}
 
 	if (trace_output)
-		actions_add_trace_output(&params->actions, trace_output);
+		actions_add_trace_output(&params->threshold_actions, trace_output);
 
 	if (geteuid()) {
 		err_msg("rtla needs root permission\n");
@@ -812,7 +823,8 @@ static struct timerlat_params
 	 * mixed mode
 	 */
 	if (params->mode == TRACING_MODE_BPF &&
-	    (params->actions.present[ACTION_TRACE_OUTPUT] || !params->no_aa))
+	    (params->threshold_actions.present[ACTION_TRACE_OUTPUT] ||
+	     params->end_actions.present[ACTION_TRACE_OUTPUT] || !params->no_aa))
 		params->mode = TRACING_MODE_MIXED;
 
 	return params;
@@ -934,14 +946,14 @@ timerlat_top_main_loop(struct osnoise_tool *top,
 			timerlat_print_stats(params, top);
 
 		if (osnoise_trace_is_off(top, record)) {
-			actions_perform(&params->actions);
+			actions_perform(&params->threshold_actions);
 
-			if (!params->actions.continue_flag)
+			if (!params->threshold_actions.continue_flag)
 				/* continue flag not set, break */
 				break;
 
 			/* continue action reached, re-enable tracing */
-			if (params->actions.present[ACTION_TRACE_OUTPUT])
+			if (record)
 				trace_instance_start(&record->trace);
 			if (!params->no_aa)
 				trace_instance_start(&aa->trace);
@@ -993,14 +1005,14 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *top,
 
 		if (wait_retval == 1) {
 			/* Stopping requested by tracer */
-			actions_perform(&params->actions);
+			actions_perform(&params->threshold_actions);
 
-			if (!params->actions.continue_flag)
+			if (!params->threshold_actions.continue_flag)
 				/* continue flag not set, break */
 				break;
 
 			/* continue action reached, re-enable tracing */
-			if (params->actions.present[ACTION_TRACE_OUTPUT])
+			if (record)
 				trace_instance_start(&record->trace);
 			if (!params->no_aa)
 				trace_instance_start(&aa->trace);
@@ -1128,13 +1140,15 @@ int timerlat_top_main(int argc, char *argv[])
 		}
 	}
 
-	if (params->actions.present[ACTION_TRACE_OUTPUT]) {
+	if (params->threshold_actions.present[ACTION_TRACE_OUTPUT] ||
+	    params->end_actions.present[ACTION_TRACE_OUTPUT]) {
 		record = osnoise_init_trace_tool("timerlat");
 		if (!record) {
 			err_msg("Failed to enable the trace instance\n");
 			goto out_free;
 		}
-		params->actions.trace_output_inst = record->trace.inst;
+		params->threshold_actions.trace_output_inst = record->trace.inst;
+		params->end_actions.trace_output_inst = record->trace.inst;
 
 		if (params->events) {
 			retval = trace_events_enable(&record->trace, params->events);
@@ -1201,7 +1215,7 @@ int timerlat_top_main(int argc, char *argv[])
 	 * tracing while enabling other instances. The trace instance is the
 	 * one with most valuable information.
 	 */
-	if (params->actions.present[ACTION_TRACE_OUTPUT])
+	if (record)
 		trace_instance_start(&record->trace);
 	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
@@ -1236,6 +1250,8 @@ int timerlat_top_main(int argc, char *argv[])
 
 	timerlat_print_stats(params, top);
 
+	actions_perform(&params->end_actions);
+
 	return_value = PASSED;
 
 	if (osnoise_trace_is_off(top, record) && !stop_tracing) {
@@ -1276,7 +1292,8 @@ int timerlat_top_main(int argc, char *argv[])
 		osnoise_destroy_tool(aa);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(top);
-	actions_destroy(&params->actions);
+	actions_destroy(&params->threshold_actions);
+	actions_destroy(&params->end_actions);
 	if (params->mode != TRACING_MODE_TRACEFS)
 		timerlat_bpf_destroy();
 	free(params);
-- 
2.47.2



