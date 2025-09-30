Return-Path: <linux-kernel+bounces-838191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF65BAEA19
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DF437AA97A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517A22C11D1;
	Tue, 30 Sep 2025 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otOyGW03"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31828C01E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759268719; cv=none; b=E4v7bcN4dFV34n7qVboyakFFTFM7kRrbfJ0tY1q5oTuR1rS73ipq8p7Dba+32tUSCaWlLeFYchNjpjYihxXjg7qyMdoithcYZNDH+x6JcclakYZBCeMC4X4kOgm8ewhM5/xc8AO+JYF90rwUGpysF3rXkDPLv9tVuQYbLb5BoqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759268719; c=relaxed/simple;
	bh=vhfCCAGBjZ+sKsHITf6F2tgtkkrDk1vWKygP1Nk3KbQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DED2LPPQUll7/nWQahlw1iHznwMOYxOm71sw/v/0FzTY8uaRrQgInR53Jsws9XVHQCBPa9dW7fUm/s6QUSLd7hGVPSlO8Cu8vkxBhLjvHqWhBIgaIYYQIxnAz+o3BSGmfV8OLbwazW/j+J/CfES0zN4ODcHgyO5662g7USTW6Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otOyGW03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD752C113CF;
	Tue, 30 Sep 2025 21:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759268719;
	bh=vhfCCAGBjZ+sKsHITf6F2tgtkkrDk1vWKygP1Nk3KbQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=otOyGW03zNy7rBrOD+Csc1mh174ELjEyTkY/kdgzH8wRXuo7o0XcwN+iI0E6tFDL0
	 QQf0G/Pa1ic2mLNFoH02rM4JHsLC9q4i8efNmzYUT4i7gUFNkyDE8jSh7hGk1tMAj5
	 eNCxmdjKdhbm54PaKw4n5Ow0gylHqmQODysiLf79gtSkGfq35CsAZnoqPOybCURTMn
	 S6omkRBxTiMn3KPHaUBpdwFtGpmWYc99y/JxMEdfv2N3ac1fwMfFjFDHH3XAXB+eCM
	 1acx1ezhh0XMCKpHKPfz0Oeq7HQ1dWJ8l7AXhGhhOC3FG9jF3ePEo6SdYaTdPL/sJh
	 VmDlhecaWM32g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3iBT-0000000DUx5-1nRW;
	Tue, 30 Sep 2025 17:46:55 -0400
Message-ID: <20250930214655.279642395@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 17:46:37 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Crystal Wood <crwood@redhat.com>
Subject: [for-next][PATCH 7/7] tools/rtla: Add remaining support for osnoise actions
References: <20250930214630.332381812@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Crystal Wood <crwood@redhat.com>

The basic functionality came with the consolidation; now hook up the
command line options, and add documentation and tests.

Cc: John Kacur <jkacur@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Link: https://lore.kernel.org/20250907022325.243930-8-crwood@redhat.com
Reviewed-by: Tomas Glozar  <tglozar@redhat.com>
Signed-off-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/tools/rtla/common_options.rst   | 61 +++++++++++++++
 .../tools/rtla/common_osnoise_options.rst     |  8 ++
 .../tools/rtla/common_timerlat_options.rst    | 74 +++----------------
 Documentation/tools/rtla/rtla-hwnoise.rst     |  2 +
 .../tools/rtla/rtla-osnoise-hist.rst          |  2 +
 Documentation/tools/rtla/rtla-osnoise-top.rst |  2 +
 .../tools/rtla/rtla-timerlat-hist.rst         |  2 +
 .../tools/rtla/rtla-timerlat-top.rst          |  2 +
 tools/tracing/rtla/src/actions.c              |  8 +-
 tools/tracing/rtla/src/actions.h              |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c         | 20 +++++
 tools/tracing/rtla/src/osnoise_top.c          | 20 +++++
 tools/tracing/rtla/src/timerlat_hist.c        |  6 +-
 tools/tracing/rtla/src/timerlat_top.c         |  6 +-
 tools/tracing/rtla/tests/osnoise.t            | 27 ++++++-
 15 files changed, 168 insertions(+), 74 deletions(-)

diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.rst
index 2dc1575210aa..77ef35d3f831 100644
--- a/Documentation/tools/rtla/common_options.rst
+++ b/Documentation/tools/rtla/common_options.rst
@@ -53,6 +53,67 @@
 **--trace-buffer-size** *kB*
         Set the per-cpu trace buffer size in kB for the tracing output.
 
+**--on-threshold** *action*
+
+        Defines an action to be executed when tracing is stopped on a latency threshold
+        specified by |threshold|.
+
+        Multiple --on-threshold actions may be specified, and they will be executed in
+        the order they are provided. If any action fails, subsequent actions in the list
+        will not be executed.
+
+        Supported actions are:
+
+        - *trace[,file=<filename>]*
+
+          Saves trace output, optionally taking a filename. Alternative to -t/--trace.
+          Note that nlike -t/--trace, specifying this multiple times will result in
+          the trace being saved multiple times.
+
+        - *signal,num=<sig>,pid=<pid>*
+
+          Sends signal to process. "parent" might be specified in place of pid to target
+          the parent process of rtla.
+
+        - *shell,command=<command>*
+
+          Execute shell command.
+
+        - *continue*
+
+          Continue tracing after actions are executed instead of stopping.
+
+        Example:
+
+        $ rtla |tool| |thresharg| 20 --on-threshold trace
+        --on-threshold shell,command="grep ipi_send |tracer|\_trace.txt"
+        --on-threshold signal,num=2,pid=parent
+
+        This will save a trace with the default filename "|tracer|\_trace.txt", print its
+        lines that contain the text "ipi_send" on standard output, and send signal 2
+        (SIGINT) to the parent process.
+
+        Performance Considerations:
+
+        |actionsperf|
+
+**--on-end** *action*
+
+        Defines an action to be executed at the end of tracing.
+
+        Multiple --on-end actions can be specified, and they will be executed in the order
+        they are provided. If any action fails, subsequent actions in the list will not be
+        executed.
+
+        See the documentation for **--on-threshold** for the list of supported actions, with
+        the exception that *continue* has no effect.
+
+        Example:
+
+        $ rtla |tool| -d 5s --on-end trace
+
+        This runs rtla with the default options, and saves trace output at the end.
+
 **-h**, **--help**
 
         Print help menu.
diff --git a/Documentation/tools/rtla/common_osnoise_options.rst b/Documentation/tools/rtla/common_osnoise_options.rst
index d73de2d58f5f..bd3c4f499193 100644
--- a/Documentation/tools/rtla/common_osnoise_options.rst
+++ b/Documentation/tools/rtla/common_osnoise_options.rst
@@ -1,3 +1,11 @@
+.. |threshold|  replace:: **-a/--auto**, **-s/--stop**, or **-S/--stop-total**
+.. |thresharg|  replace:: -s
+.. |tracer|     replace:: osnoise
+
+.. |actionsperf| replace::
+        Due to implementational limitations, actions might be delayed
+        up to one second after tracing is stopped.
+
 **-a**, **--auto** *us*
 
         Set the automatic trace mode. This mode sets some commonly used options
diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index 7854368f1827..1f5d024b53aa 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -1,3 +1,13 @@
+.. |threshold|  replace:: **-a/--auto**, **-i/--irq**, or **-T/--thread**
+.. |thresharg|  replace:: -T
+.. |tracer|     replace:: timerlat
+
+.. |actionsperf| replace::
+        For time-sensitive actions, it is recommended to run **rtla timerlat** with BPF
+        support and RT priority. Note that due to implementational limitations, actions
+        might be delayed up to one second after tracing is stopped if BPF mode is not
+        available or disabled.
+
 **-a**, **--auto** *us*
 
         Set the automatic trace mode. This mode sets some commonly used options
@@ -55,67 +65,3 @@
         Set timerlat to run without workload, waiting for the user to dispatch a per-cpu
         task that waits for a new period on the tracing/osnoise/per_cpu/cpu$ID/timerlat_fd.
         See linux/tools/rtla/sample/timerlat_load.py for an example of user-load code.
-
-**--on-threshold** *action*
-
-        Defines an action to be executed when tracing is stopped on a latency threshold
-        specified by **-i/--irq** or **-T/--thread**.
-
-        Multiple --on-threshold actions may be specified, and they will be executed in
-        the order they are provided. If any action fails, subsequent actions in the list
-        will not be executed.
-
-        Supported actions are:
-
-        - *trace[,file=<filename>]*
-
-          Saves trace output, optionally taking a filename. Alternative to -t/--trace.
-          Note that nlike -t/--trace, specifying this multiple times will result in
-          the trace being saved multiple times.
-
-        - *signal,num=<sig>,pid=<pid>*
-
-          Sends signal to process. "parent" might be specified in place of pid to target
-          the parent process of rtla.
-
-        - *shell,command=<command>*
-
-          Execute shell command.
-
-        - *continue*
-
-          Continue tracing after actions are executed instead of stopping.
-
-        Example:
-
-        $ rtla timerlat -T 20 --on-threshold trace
-        --on-threshold shell,command="grep ipi_send timerlat_trace.txt"
-        --on-threshold signal,num=2,pid=parent
-
-        This will save a trace with the default filename "timerlat_trace.txt", print its
-        lines that contain the text "ipi_send" on standard output, and send signal 2
-        (SIGINT) to the parent process.
-
-        Performance Considerations:
-
-        For time-sensitive actions, it is recommended to run **rtla timerlat** with BPF
-        support and RT priority. Note that due to implementational limitations, actions
-        might be delayed up to one second after tracing is stopped if BPF mode is not
-        available or disabled.
-
-**--on-end** *action*
-
-        Defines an action to be executed at the end of **rtla timerlat** tracing.
-
-        Multiple --on-end actions can be specified, and they will be executed in the order
-        they are provided. If any action fails, subsequent actions in the list will not be
-        executed.
-
-        See the documentation for **--on-threshold** for the list of supported actions, with
-        the exception that *continue* has no effect.
-
-        Example:
-
-        $ rtla timerlat -d 5s --on-end trace
-
-        This runs rtla timerlat with default options and save trace output at the end.
diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/tools/rtla/rtla-hwnoise.rst
index fb1c52bbc00b..3a7163c02ac8 100644
--- a/Documentation/tools/rtla/rtla-hwnoise.rst
+++ b/Documentation/tools/rtla/rtla-hwnoise.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. |tool| replace:: hwnoise
+
 ============
 rtla-hwnoise
 ============
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index f2e79d22c4c4..1fc60ef26106 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -1,3 +1,5 @@
+.. |tool| replace:: osnoise hist
+
 ===================
 rtla-osnoise-hist
 ===================
diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index 5d75d1394516..b1cbd7bcd4ae 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -1,3 +1,5 @@
+.. |tool| replace:: osnoise top
+
 ===================
 rtla-osnoise-top
 ===================
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index b2d8726271b3..4923a362129b 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -1,3 +1,5 @@
+.. |tool| replace:: timerlat hist
+
 =====================
 rtla-timerlat-hist
 =====================
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index ab6cb60c9083..50968cdd2095 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -1,3 +1,5 @@
+.. |tool| replace:: timerlat top
+
 ====================
 rtla-timerlat-top
 ====================
diff --git a/tools/tracing/rtla/src/actions.c b/tools/tracing/rtla/src/actions.c
index aaf0808125d7..991139f9069f 100644
--- a/tools/tracing/rtla/src/actions.c
+++ b/tools/tracing/rtla/src/actions.c
@@ -127,17 +127,17 @@ actions_add_continue(struct actions *self)
  * actions_parse - add an action based on text specification
  */
 int
-actions_parse(struct actions *self, const char *trigger)
+actions_parse(struct actions *self, const char *trigger, const char *tracefn)
 {
 	enum action_type type = ACTION_NONE;
-	char *token;
+	const char *token;
 	char trigger_c[strlen(trigger)];
 
 	/* For ACTION_SIGNAL */
 	int signal = 0, pid = 0;
 
 	/* For ACTION_TRACE_OUTPUT */
-	char *trace_output;
+	const char *trace_output;
 
 	strcpy(trigger_c, trigger);
 	token = strtok(trigger_c, ",");
@@ -160,7 +160,7 @@ actions_parse(struct actions *self, const char *trigger)
 	case ACTION_TRACE_OUTPUT:
 		/* Takes no argument */
 		if (token == NULL)
-			trace_output = "timerlat_trace.txt";
+			trace_output = tracefn;
 		else {
 			if (strlen(token) > 5 && strncmp(token, "file=", 5) == 0) {
 				trace_output = token + 5;
diff --git a/tools/tracing/rtla/src/actions.h b/tools/tracing/rtla/src/actions.h
index b10a19d55c49..a4f9b570775b 100644
--- a/tools/tracing/rtla/src/actions.h
+++ b/tools/tracing/rtla/src/actions.h
@@ -48,5 +48,5 @@ int actions_add_trace_output(struct actions *self, const char *trace_output);
 int actions_add_signal(struct actions *self, int signal, int pid);
 int actions_add_shell(struct actions *self, const char *command);
 int actions_add_continue(struct actions *self);
-int actions_parse(struct actions *self, const char *trigger);
+int actions_parse(struct actions *self, const char *trigger, const char *tracefn);
 int actions_perform(struct actions *self);
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 2c2cdd467a67..dffb6d0a98d7 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -462,6 +462,8 @@ static void osnoise_hist_usage(char *usage)
 		"						       in nanoseconds",
 		"	     --warm-up: let the workload run for s seconds before collecting data",
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
+		"	     --on-threshold <action>: define action to be executed at stop-total threshold, multiple are allowed",
+		"	     --on-end <action>: define action to be executed at measurement end, multiple are allowed",
 		NULL,
 	};
 
@@ -531,6 +533,8 @@ static struct common_params
 			{"filter",		required_argument,	0, '5'},
 			{"warm-up",		required_argument,	0, '6'},
 			{"trace-buffer-size",	required_argument,	0, '7'},
+			{"on-threshold",	required_argument,	0, '8'},
+			{"on-end",		required_argument,	0, '9'},
 			{0, 0, 0, 0}
 		};
 
@@ -692,6 +696,22 @@ static struct common_params
 		case '7':
 			params->common.buffer_size = get_llong_from_str(optarg);
 			break;
+		case '8':
+			retval = actions_parse(&params->common.threshold_actions, optarg,
+					       "osnoise_trace.txt");
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
+		case '9':
+			retval = actions_parse(&params->common.end_actions, optarg,
+					       "osnoise_trace.txt");
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
 		default:
 			osnoise_hist_usage("Invalid option");
 		}
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 5a56c276f9da..95418f7ecc96 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -291,6 +291,8 @@ static void osnoise_top_usage(struct osnoise_params *params, char *usage)
 		"						       in nanoseconds",
 		"	     --warm-up s: let the workload run for s seconds before collecting data",
 		"	     --trace-buffer-size kB: set the per-cpu trace buffer size in kB",
+		"	     --on-threshold <action>: define action to be executed at stop-total threshold, multiple are allowed",
+		"	     --on-end: define action to be executed at measurement end, multiple are allowed",
 		NULL,
 	};
 
@@ -371,6 +373,8 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 			{"filter",		required_argument,	0, '1'},
 			{"warm-up",		required_argument,	0, '2'},
 			{"trace-buffer-size",	required_argument,	0, '3'},
+			{"on-threshold",	required_argument,	0, '4'},
+			{"on-end",		required_argument,	0, '5'},
 			{0, 0, 0, 0}
 		};
 
@@ -511,6 +515,22 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		case '3':
 			params->common.buffer_size = get_llong_from_str(optarg);
 			break;
+		case '4':
+			retval = actions_parse(&params->common.threshold_actions, optarg,
+					       "osnoise_trace.txt");
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
+		case '5':
+			retval = actions_parse(&params->common.end_actions, optarg,
+					       "osnoise_trace.txt");
+			if (retval) {
+				err_msg("Invalid action %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
 		default:
 			osnoise_top_usage(params, "Invalid option");
 		}
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index a9154f83f1a9..606c1688057b 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1047,14 +1047,16 @@ static struct common_params
 			params->deepest_idle_state = get_llong_from_str(optarg);
 			break;
 		case '\5':
-			retval = actions_parse(&params->common.threshold_actions, optarg);
+			retval = actions_parse(&params->common.threshold_actions, optarg,
+					       "timerlat_trace.txt");
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
 			}
 			break;
 		case '\6':
-			retval = actions_parse(&params->common.end_actions, optarg);
+			retval = actions_parse(&params->common.end_actions, optarg,
+					       "timerlat_trace.txt");
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 4f1ce72d6a05..fc479a0dcb59 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -783,14 +783,16 @@ static struct common_params
 			params->deepest_idle_state = get_llong_from_str(optarg);
 			break;
 		case '9':
-			retval = actions_parse(&params->common.threshold_actions, optarg);
+			retval = actions_parse(&params->common.threshold_actions, optarg,
+					       "timerlat_trace.txt");
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
 			}
 			break;
 		case '\1':
-			retval = actions_parse(&params->common.end_actions, optarg);
+			retval = actions_parse(&params->common.end_actions, optarg,
+					       "timerlat_trace.txt");
 			if (retval) {
 				err_msg("Invalid action %s\n", optarg);
 				exit(EXIT_FAILURE);
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 7574ec6a5a53..e3c89d45a6bb 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -8,7 +8,8 @@ set_timeout 2m
 check "verify help page" \
 	"osnoise --help" 0 "osnoise version"
 check "verify the --priority/-P param" \
-	"osnoise top -P F:1 -c 0 -r 900000 -d 10s -q"
+	"osnoise top -P F:1 -c 0 -r 900000 -d 10s -q -S 1 --on-threshold shell,command=\"tests/scripts/check-priority.sh osnoise/ SCHED_FIFO 1\"" \
+	2 "Priorities are set correctly"
 check "verify the --stop/-s param" \
 	"osnoise top -s 30 -T 1" 2 "osnoise hit stop tracing"
 check "verify the  --trace param" \
@@ -22,4 +23,28 @@ check "verify the --entries/-E param" \
 check_with_osnoise_options "apply default period" \
 	"osnoise hist -s 1" 2 period_us=600000000
 
+# Actions tests
+check "trace output through -t with custom filename" \
+	"osnoise hist -S 2 -t custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
+check "trace output through --on-threshold trace" \
+	"osnoise hist -S 2 --on-threshold trace" 2 "^  Saving trace to osnoise_trace.txt$"
+check "trace output through --on-threshold trace with custom filename" \
+	"osnoise hist -S 2 --on-threshold trace,file=custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
+check "exec command" \
+	"osnoise hist -S 2 --on-threshold shell,command='echo TestOutput'" 2 "^TestOutput$"
+check "multiple actions" \
+	"osnoise hist -S 2 --on-threshold shell,command='echo -n 1' --on-threshold shell,command='echo 2'" 2 "^12$"
+check "hist stop at failed action" \
+	"osnoise hist -S 2 --on-threshold shell,command='echo -n 1; false' --on-threshold shell,command='echo -n 2'" 2 "^1# RTLA osnoise histogram$"
+check "top stop at failed action" \
+	"timerlat top -T 2 --on-threshold shell,command='echo -n abc; false' --on-threshold shell,command='echo -n defgh'" 2 "^abc" "defgh"
+check "hist with continue" \
+	"osnoise hist -S 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+check "top with continue" \
+	"osnoise top -q -S 2 -d 1s --on-threshold shell,command='echo TestOutput' --on-threshold continue" 0 "^TestOutput$"
+check "hist with trace output at end" \
+	"osnoise hist -d 1s --on-end trace" 0 "^  Saving trace to osnoise_trace.txt$"
+check "top with trace output at end" \
+	"osnoise top -d 1s --on-end trace" 0 "^  Saving trace to osnoise_trace.txt$"
+
 test_end
-- 
2.50.1



