Return-Path: <linux-kernel+bounces-739963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4F3B0CD96
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F1E1708FB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EECB24677F;
	Mon, 21 Jul 2025 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTKYDY6W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA01245000
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139512; cv=none; b=Y+9CerWhITD4oSAsZfmx+t/rY8iSYeH5AW+fGgDpQCyXzIxDqxghFiaUo2SRALwBBIwNFF7N108kIdPR6VHXbBnHEI3yZpjCIJaS+luQhNw2WMRlpKFQYigHeTIsjzsEsAdSBMN2zRWcTSxAz2dRx/kP1uawoaONj76Mhp4Jq4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139512; c=relaxed/simple;
	bh=jcjCtNAcQO3+9YMjnkp8D57fNpuPEJInwxLCLjQDjwg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HU8+Uv0qWPuQhUx4wcgDTjhyhnJK143ROtZAwL3v2DI8fTKW+zaOGU6e+d2Xi6GEdryHGbkDH6EjXagyv0GuJk4uhXvo1dWAx33GfAW/6f+nfoohoSObT3MhSLv34KCOetXh9J7mCYI6bOYjvQ5WrLFRpdj4E3/1agdS3bzlBWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTKYDY6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A2DC4CEED;
	Mon, 21 Jul 2025 23:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753139511;
	bh=jcjCtNAcQO3+9YMjnkp8D57fNpuPEJInwxLCLjQDjwg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=WTKYDY6WAN7rcLlwOS/mUMFsHz7HuFXHQo1g0+HflCU3dy9+UawLjHiWU/OIDPF3r
	 0BYxp+NyoSBa+U5N1ntypXjlkLCNYvw1gbDQw225LvyAfY2LIiaK17wz+K5s5kpsxQ
	 lcmz539/N/OrMajmsP8e6lGHWyv5y1TFQdOJPEP15jkrL6uv5dR11zWwzgx9SezSzW
	 t/lr6hILhy3yw3bwENP0D90hk0CCmMzCZH8y0xr4lwHBr69mWIkbOE7faf5RBZA01H
	 PVV6plNpB9QsBW7I4SlQBroMDQwUMMYphKnRXG25mI0aJGzM/sKayzd3W8W9VLGd9F
	 nOqf4tJLoW+KQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udzgE-00000009vIs-3xNT;
	Mon, 21 Jul 2025 19:12:22 -0400
Message-ID: <20250721231222.797319180@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 21 Jul 2025 19:12:08 -0400
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
Subject: [for-next][PATCH 4/9] rtla/timerlat: Add continue action
References: <20250721231204.100737734@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Introduce option to resume tracing after a latency threshold overflow.
The option is implemented as an action named "continue".

Example:
$ rtla timerlat top -q -T 200 -d 1s --on-threshold \
exec,command="echo Threshold" --on-threshold continue
Threshold
Threshold
Threshold
                                     Timer Latency
...

The feature is supported for both hist and top. After the continue
action is executed, processing of the list of actions is stopped and
tracing is resumed.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Chang Yin <cyin@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250626123405.1496931-5-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/actions.c       | 27 +++++++++++-
 tools/tracing/rtla/src/actions.h       |  5 ++-
 tools/tracing/rtla/src/timerlat_hist.c | 40 +++++++++++++++---
 tools/tracing/rtla/src/timerlat_top.c  | 57 ++++++++++++++++----------
 4 files changed, 100 insertions(+), 29 deletions(-)

diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index 63bee5bdabfd..aaf0808125d7 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -17,6 +17,7 @@ actions_init(struct actions *self)
 	self->size = action_default_size;
 	self->list = calloc(self->size, sizeof(struct action));
 	self->len = 0;
+	self->continue_flag = false;
 
 	memset(&self->present, 0, sizeof(self->present));
 
@@ -108,6 +109,20 @@ actions_add_shell(struct actions *self, const char *command)
 	return 0;
 }
 
+/*
+ * actions_add_continue - add an action to resume measurement
+ */
+int
+actions_add_continue(struct actions *self)
+{
+	struct action *action = actions_new(self);
+
+	self->present[ACTION_CONTINUE] = true;
+	action->type = ACTION_CONTINUE;
+
+	return 0;
+}
+
 /*
  * actions_parse - add an action based on text specification
  */
@@ -133,6 +148,8 @@ actions_parse(struct actions *self, const char *trigger)
 		type = ACTION_SIGNAL;
 	else if (strcmp(token, "shell") == 0)
 		type = ACTION_SHELL;
+	else if (strcmp(token, "continue") == 0)
+		type = ACTION_CONTINUE;
 	else
 		/* Invalid trigger type */
 		return -1;
@@ -187,6 +204,11 @@ actions_parse(struct actions *self, const char *trigger)
 		if (strlen(token) > 8 && strncmp(token, "command=", 8) == 0)
 			return actions_add_shell(self, token + 8);
 		return -1;
+	case ACTION_CONTINUE:
+		/* Takes no argument */
+		if (token != NULL)
+			return -1;
+		return actions_add_continue(self);
 	default:
 		return -1;
 	}
@@ -196,7 +218,7 @@ actions_parse(struct actions *self, const char *trigger)
  * actions_perform - perform all actions
  */
 int
-actions_perform(const struct actions *self)
+actions_perform(struct actions *self)
 {
 	int pid, retval;
 	const struct action *action;
@@ -226,6 +248,9 @@ actions_perform(const struct actions *self)
 			if (retval)
 				return retval;
 			break;
+		case ACTION_CONTINUE:
+			self->continue_flag = true;
+			return 0;
 		default:
 			break;
 		}
diff --git a/tools/tracing/rtla/src/actions.h b/tools/tracing/rtla/src/actions.h
index 076bbff8519e..b10a19d55c49 100644
--- a/tools/tracing/rtla/src/actions.h
+++ b/tools/tracing/rtla/src/actions.h
@@ -7,6 +7,7 @@ enum action_type {
 	ACTION_TRACE_OUTPUT,
 	ACTION_SIGNAL,
 	ACTION_SHELL,
+	ACTION_CONTINUE,
 	ACTION_FIELD_N
 };
 
@@ -35,6 +36,7 @@ struct actions {
 	struct action *list;
 	int len, size;
 	bool present[ACTION_FIELD_N];
+	bool continue_flag;
 
 	/* External dependencies */
 	struct tracefs_instance *trace_output_inst;
@@ -45,5 +47,6 @@ void actions_destroy(struct actions *self);
 int actions_add_trace_output(struct actions *self, const char *trace_output);
 int actions_add_signal(struct actions *self, int signal, int pid);
 int actions_add_shell(struct actions *self, const char *command);
+int actions_add_continue(struct actions *self);
 int actions_parse(struct actions *self, const char *trigger);
-int actions_perform(const struct actions *self);
+int actions_perform(struct actions *self);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index d975d2cd6604..4f13a8f92711 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1374,8 +1374,20 @@ int timerlat_hist_main(int argc, char *argv[])
 				goto out_hist;
 			}
 
-			if (osnoise_trace_is_off(tool, record))
-				break;
+			if (osnoise_trace_is_off(tool, record)) {
+				actions_perform(&params->actions);
+
+				if (!params->actions.continue_flag)
+					/* continue flag not set, break */
+					break;
+
+				/* continue action reached, re-enable tracing */
+				if (params->actions.present[ACTION_TRACE_OUTPUT])
+					trace_instance_start(&record->trace);
+				if (!params->no_aa)
+					trace_instance_start(&aa->trace);
+				trace_instance_start(trace);
+			}
 
 			/* is there still any user-threads ? */
 			if (params->user_workload) {
@@ -1385,8 +1397,27 @@ int timerlat_hist_main(int argc, char *argv[])
 				}
 			}
 		}
-	} else
-		timerlat_bpf_wait(-1);
+	} else {
+		while (!stop_tracing) {
+			timerlat_bpf_wait(-1);
+
+			if (!stop_tracing) {
+				/* Threshold overflow, perform actions on threshold */
+				actions_perform(&params->actions);
+
+				if (!params->actions.continue_flag)
+					/* continue flag not set, break */
+					break;
+
+				/* continue action reached, re-enable tracing */
+				if (params->actions.present[ACTION_TRACE_OUTPUT])
+					trace_instance_start(&record->trace);
+				if (!params->no_aa)
+					trace_instance_start(&aa->trace);
+				timerlat_bpf_restart_tracing();
+			}
+		}
+	}
 
 	if (params->mode != TRACING_MODE_TRACEFS) {
 		timerlat_bpf_detach();
@@ -1412,7 +1443,6 @@ int timerlat_hist_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		actions_perform(&params->actions);
 		return_value = FAILED;
 	}
 
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index cdbfda009974..60f9c78cb272 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -906,6 +906,7 @@ timerlat_top_set_signals(struct timerlat_params *params)
 static int
 timerlat_top_main_loop(struct osnoise_tool *top,
 		       struct osnoise_tool *record,
+		       struct osnoise_tool *aa,
 		       struct timerlat_params *params,
 		       struct timerlat_u_params *params_u)
 {
@@ -932,8 +933,20 @@ timerlat_top_main_loop(struct osnoise_tool *top,
 		if (!params->quiet)
 			timerlat_print_stats(params, top);
 
-		if (osnoise_trace_is_off(top, record))
-			break;
+		if (osnoise_trace_is_off(top, record)) {
+			actions_perform(&params->actions);
+
+			if (!params->actions.continue_flag)
+				/* continue flag not set, break */
+				break;
+
+			/* continue action reached, re-enable tracing */
+			if (params->actions.present[ACTION_TRACE_OUTPUT])
+				trace_instance_start(&record->trace);
+			if (!params->no_aa)
+				trace_instance_start(&aa->trace);
+			trace_instance_start(trace);
+		}
 
 		/* is there still any user-threads ? */
 		if (params->user_workload) {
@@ -953,6 +966,7 @@ timerlat_top_main_loop(struct osnoise_tool *top,
 static int
 timerlat_top_bpf_main_loop(struct osnoise_tool *top,
 			   struct osnoise_tool *record,
+			   struct osnoise_tool *aa,
 			   struct timerlat_params *params,
 			   struct timerlat_u_params *params_u)
 {
@@ -964,22 +978,9 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *top,
 		return 0;
 	}
 
-	if (params->quiet) {
-		/* Quiet mode: wait for stop and then, print results */
-		timerlat_bpf_wait(-1);
-
-		retval = timerlat_top_bpf_pull_data(top);
-		if (retval) {
-			err_msg("Error pulling BPF data\n");
-			return retval;
-		}
-
-		return 0;
-	}
-
 	/* Pull and display data in a loop */
 	while (!stop_tracing) {
-		wait_retval = timerlat_bpf_wait(params->sleep_time);
+		wait_retval = timerlat_bpf_wait(params->quiet ? -1 : params->sleep_time);
 
 		retval = timerlat_top_bpf_pull_data(top);
 		if (retval) {
@@ -987,11 +988,24 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *top,
 			return retval;
 		}
 
-		timerlat_print_stats(params, top);
+		if (!params->quiet)
+			timerlat_print_stats(params, top);
 
-		if (wait_retval == 1)
+		if (wait_retval == 1) {
 			/* Stopping requested by tracer */
-			break;
+			actions_perform(&params->actions);
+
+			if (!params->actions.continue_flag)
+				/* continue flag not set, break */
+				break;
+
+			/* continue action reached, re-enable tracing */
+			if (params->actions.present[ACTION_TRACE_OUTPUT])
+				trace_instance_start(&record->trace);
+			if (!params->no_aa)
+				trace_instance_start(&aa->trace);
+			timerlat_bpf_restart_tracing();
+		}
 
 		/* is there still any user-threads ? */
 		if (params->user_workload) {
@@ -1205,9 +1219,9 @@ int timerlat_top_main(int argc, char *argv[])
 	timerlat_top_set_signals(params);
 
 	if (params->mode == TRACING_MODE_TRACEFS)
-		retval = timerlat_top_main_loop(top, record, params, &params_u);
+		retval = timerlat_top_main_loop(top, record, aa, params, &params_u);
 	else
-		retval = timerlat_top_bpf_main_loop(top, record, params, &params_u);
+		retval = timerlat_top_bpf_main_loop(top, record, aa, params, &params_u);
 
 	if (retval)
 		goto out_top;
@@ -1230,7 +1244,6 @@ int timerlat_top_main(int argc, char *argv[])
 		if (!params->no_aa)
 			timerlat_auto_analysis(params->stop_us, params->stop_total_us);
 
-		actions_perform(&params->actions);
 		return_value = FAILED;
 	} else if (params->aa_only) {
 		/*
-- 
2.47.2



