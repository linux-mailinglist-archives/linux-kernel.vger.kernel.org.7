Return-Path: <linux-kernel+bounces-838188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6335BAEA0D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599D617F78B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F122C029E;
	Tue, 30 Sep 2025 21:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEwKAyVh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E72243367
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759268718; cv=none; b=aOuKiTHprQxzDqxDk8I1IBFPA7JHl7CWaHPyR4PzJH/mML9Jom/pK41fJ5Ge2hcpb/zEwQVZ3Of99bPmxUsa7D+8ZnJwQqT+3OtsZybQNcSA825Dpcz6/t6mwY9qhtfF07VIitK0mIk1UlCnhCXmIr3EYPC5ddd+pmt0R5nNBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759268718; c=relaxed/simple;
	bh=3l7AYllKSu3VON3a1IlVakLvTWXPoDSXroDXjOVK2Zo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mBmVx+YgoEqUb5JYCxtcDMNv9uh5gb8z+d7Of7GAp6DI3rRapjp3XlSnSkeDFFB9BSIX+gRXexyfQzxK4xnhlmaQgjDLGXhPGeoUhO2dYBlVIxDSHW7jIN9eQnVY4vf5f9xJlWfu4ylx3uOZi95CJmv0GYWa2cCwptymU7LVnd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEwKAyVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCBCC116C6;
	Tue, 30 Sep 2025 21:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759268718;
	bh=3l7AYllKSu3VON3a1IlVakLvTWXPoDSXroDXjOVK2Zo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=QEwKAyVhkVrLe6OYmdt65FLFECbUS7Ec9tS0GuMbF3SsB/xIHNsLm8KhijMuXpGEb
	 cuqds9M68ut3VNPVN5j8z+YdelSGxNCAMHhAD45ESjdbkZnG4CBeo8Vehk6F+Q54fp
	 NBebV8SexNI9eJ+ipTV3N5qzchkcHrFjzMSp51Qn0Ecup+vY8K0Og/oP6fqzlN0CQj
	 2DkxjX51HxYiYUSJqUzwlz6Kot2Vy+A+Zc1/QD+d1RLEyalEo01rgryJ5HBk5udrL3
	 /kqQ6llKC/B85clRW1o0HEHwCbPsDpeHF1Hr6KDUJJI5Ar1bFYJmxXVdspojI3L86q
	 2lT/cMQAPhDEw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3iBS-0000000DUv8-389f;
	Tue, 30 Sep 2025 17:46:54 -0400
Message-ID: <20250930214654.602648274@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 17:46:33 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Crystal Wood <crwood@redhat.com>
Subject: [for-next][PATCH 3/7] tools/rtla: Create common_apply_config()
References: <20250930214630.332381812@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Crystal Wood <crwood@redhat.com>

Merge the common bits of osnoise_apply_config() and
timerlat_apply_config().  Put the result in a new common.c, and move
enough things to common.h so that common.c does not need to include
osnoise.h.

Cc: John Kacur <jkacur@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Link: https://lore.kernel.org/20250907022325.243930-4-crwood@redhat.com
Reviewed-by: Tomas Glozar  <tglozar@redhat.com>
Signed-off-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/Build           |  1 +
 tools/tracing/rtla/src/common.c        | 63 ++++++++++++++++++++++++
 tools/tracing/rtla/src/common.h        | 67 ++++++++++++++++++++++++++
 tools/tracing/rtla/src/osnoise.c       | 37 ++------------
 tools/tracing/rtla/src/osnoise.h       | 64 ------------------------
 tools/tracing/rtla/src/timerlat.c      | 51 ++------------------
 tools/tracing/rtla/src/timerlat.h      |  1 -
 tools/tracing/rtla/src/timerlat_hist.c |  4 +-
 tools/tracing/rtla/src/timerlat_top.c  |  4 +-
 9 files changed, 142 insertions(+), 150 deletions(-)
 create mode 100644 tools/tracing/rtla/src/common.c

diff --git a/tools/tracing/rtla/src/Build b/tools/tracing/rtla/src/Build
index 66631280b75b..329e24a40cf7 100644
--- a/tools/tracing/rtla/src/Build
+++ b/tools/tracing/rtla/src/Build
@@ -1,6 +1,7 @@
 rtla-y += trace.o
 rtla-y += utils.o
 rtla-y += actions.o
+rtla-y += common.o
 rtla-y += osnoise.o
 rtla-y += osnoise_top.o
 rtla-y += osnoise_hist.o
diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
new file mode 100644
index 000000000000..32a6faffc714
--- /dev/null
+++ b/tools/tracing/rtla/src/common.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <unistd.h>
+#include "common.h"
+
+/*
+ * common_apply_config - apply common configs to the initialized tool
+ */
+int
+common_apply_config(struct osnoise_tool *tool, struct common_params *params)
+{
+	int retval, i;
+
+	if (!params->sleep_time)
+		params->sleep_time = 1;
+
+	retval = osnoise_set_cpus(tool->context, params->cpus ? params->cpus : "all");
+	if (retval) {
+		err_msg("Failed to apply CPUs config\n");
+		goto out_err;
+	}
+
+	if (!params->cpus) {
+		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
+			CPU_SET(i, &params->monitored_cpus);
+	}
+
+	if (params->hk_cpus) {
+		retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
+					   &params->hk_cpu_set);
+		if (retval == -1) {
+			err_msg("Failed to set rtla to the house keeping CPUs\n");
+			goto out_err;
+		}
+	} else if (params->cpus) {
+		/*
+		 * Even if the user do not set a house-keeping CPU, try to
+		 * move rtla to a CPU set different to the one where the user
+		 * set the workload to run.
+		 *
+		 * No need to check results as this is an automatic attempt.
+		 */
+		auto_house_keeping(&params->monitored_cpus);
+	}
+
+	/*
+	 * Set workload according to type of thread if the kernel supports it.
+	 * On kernels without support, user threads will have already failed
+	 * on missing fd, and kernel threads do not need it.
+	 */
+	retval = osnoise_set_workload(tool->context, params->kernel_workload);
+	if (retval < -1) {
+		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
+		goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	return -1;
+}
+
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 276dfbc7f955..c306ba502688 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -1,8 +1,67 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #pragma once
 
+#include "trace.h"
 #include "utils.h"
 
+/*
+ * osnoise_context - read, store, write, restore osnoise configs.
+ */
+struct osnoise_context {
+	int			flags;
+	int			ref;
+
+	char			*curr_cpus;
+	char			*orig_cpus;
+
+	/* 0 as init value */
+	unsigned long long	orig_runtime_us;
+	unsigned long long	runtime_us;
+
+	/* 0 as init value */
+	unsigned long long	orig_period_us;
+	unsigned long long	period_us;
+
+	/* 0 as init value */
+	long long		orig_timerlat_period_us;
+	long long		timerlat_period_us;
+
+	/* 0 as init value */
+	long long		orig_tracing_thresh;
+	long long		tracing_thresh;
+
+	/* -1 as init value because 0 is disabled */
+	long long		orig_stop_us;
+	long long		stop_us;
+
+	/* -1 as init value because 0 is disabled */
+	long long		orig_stop_total_us;
+	long long		stop_total_us;
+
+	/* -1 as init value because 0 is disabled */
+	long long		orig_print_stack;
+	long long		print_stack;
+
+	/* -1 as init value because 0 is off */
+	int			orig_opt_irq_disable;
+	int			opt_irq_disable;
+
+	/* -1 as init value because 0 is off */
+	int			orig_opt_workload;
+	int			opt_workload;
+};
+
+/*
+ * osnoise_tool -  osnoise based tool definition.
+ */
+struct osnoise_tool {
+	struct trace_instance		trace;
+	struct osnoise_context		*context;
+	void				*data;
+	void				*params;
+	time_t				start_time;
+};
+
 struct hist_params {
 	char			no_irq;
 	char			no_thread;
@@ -44,4 +103,12 @@ struct common_params {
 	int			output_divisor;
 	int			pretty_output;
 	int			quiet;
+	int			kernel_workload;
 };
+
+int osnoise_set_cpus(struct osnoise_context *context, char *cpus);
+void osnoise_restore_cpus(struct osnoise_context *context);
+
+int osnoise_set_workload(struct osnoise_context *context, bool onoff);
+
+int common_apply_config(struct osnoise_tool *tool, struct common_params *params);
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 06ae7437c2c7..4051b21db69a 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1120,21 +1120,14 @@ osnoise_report_missed_events(struct osnoise_tool *tool)
 }
 
 /*
- * osnoise_apply_config - apply common configs to the initialized tool
+ * osnoise_apply_config - apply osnoise configs to the initialized tool
  */
 int
 osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 {
 	int retval;
 
-	if (!params->common.sleep_time)
-		params->common.sleep_time = 1;
-
-	retval = osnoise_set_cpus(tool->context, params->common.cpus ? params->common.cpus : "all");
-	if (retval) {
-		err_msg("Failed to apply CPUs config\n");
-		goto out_err;
-	}
+	params->common.kernel_workload = true;
 
 	if (params->runtime || params->period) {
 		retval = osnoise_set_runtime_period(tool->context,
@@ -1169,31 +1162,7 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 		goto out_err;
 	}
 
-	if (params->common.hk_cpus) {
-		retval = sched_setaffinity(getpid(), sizeof(params->common.hk_cpu_set),
-					   &params->common.hk_cpu_set);
-		if (retval == -1) {
-			err_msg("Failed to set rtla to the house keeping CPUs\n");
-			goto out_err;
-		}
-	} else if (params->common.cpus) {
-		/*
-		 * Even if the user do not set a house-keeping CPU, try to
-		 * move rtla to a CPU set different to the one where the user
-		 * set the workload to run.
-		 *
-		 * No need to check results as this is an automatic attempt.
-		 */
-		auto_house_keeping(&params->common.monitored_cpus);
-	}
-
-	retval = osnoise_set_workload(tool->context, true);
-	if (retval < -1) {
-		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
-		goto out_err;
-	}
-
-	return 0;
+	return common_apply_config(tool, &params->common);
 
 out_err:
 	return -1;
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index b64b39de97b5..25baf46a2520 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -2,7 +2,6 @@
 #pragma once
 
 #include "common.h"
-#include "trace.h"
 
 enum osnoise_mode {
 	MODE_OSNOISE = 0,
@@ -18,53 +17,6 @@ struct osnoise_params {
 	enum osnoise_mode	mode;
 };
 
-/*
- * osnoise_context - read, store, write, restore osnoise configs.
- */
-struct osnoise_context {
-	int			flags;
-	int			ref;
-
-	char			*curr_cpus;
-	char			*orig_cpus;
-
-	/* 0 as init value */
-	unsigned long long	orig_runtime_us;
-	unsigned long long	runtime_us;
-
-	/* 0 as init value */
-	unsigned long long	orig_period_us;
-	unsigned long long	period_us;
-
-	/* 0 as init value */
-	long long		orig_timerlat_period_us;
-	long long		timerlat_period_us;
-
-	/* 0 as init value */
-	long long		orig_tracing_thresh;
-	long long		tracing_thresh;
-
-	/* -1 as init value because 0 is disabled */
-	long long		orig_stop_us;
-	long long		stop_us;
-
-	/* -1 as init value because 0 is disabled */
-	long long		orig_stop_total_us;
-	long long		stop_total_us;
-
-	/* -1 as init value because 0 is disabled */
-	long long		orig_print_stack;
-	long long		print_stack;
-
-	/* -1 as init value because 0 is off */
-	int			orig_opt_irq_disable;
-	int			opt_irq_disable;
-
-	/* -1 as init value because 0 is off */
-	int			orig_opt_workload;
-	int			opt_workload;
-};
-
 /*
  * *_INIT_VALs are also invalid values, they are used to
  * communicate errors.
@@ -76,9 +28,6 @@ struct osnoise_context *osnoise_context_alloc(void);
 int osnoise_get_context(struct osnoise_context *context);
 void osnoise_put_context(struct osnoise_context *context);
 
-int osnoise_set_cpus(struct osnoise_context *context, char *cpus);
-void osnoise_restore_cpus(struct osnoise_context *context);
-
 int osnoise_set_runtime_period(struct osnoise_context *context,
 			       unsigned long long runtime,
 			       unsigned long long period);
@@ -105,19 +54,6 @@ int osnoise_set_print_stack(struct osnoise_context *context,
 			    long long print_stack);
 
 int osnoise_set_irq_disable(struct osnoise_context *context, bool onoff);
-int osnoise_set_workload(struct osnoise_context *context, bool onoff);
-
-/*
- * osnoise_tool -  osnoise based tool definition.
- */
-struct osnoise_tool {
-	struct trace_instance		trace;
-	struct osnoise_context		*context;
-	void				*data;
-	void				*params;
-	time_t				start_time;
-};
-
 void osnoise_destroy_tool(struct osnoise_tool *top);
 struct osnoise_tool *osnoise_init_tool(char *tool_name);
 struct osnoise_tool *osnoise_init_trace_tool(char *tracer);
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 0b2f03e1e612..e4bf58db1dd2 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -24,21 +24,7 @@
 int
 timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 {
-	int retval, i;
-
-	if (!params->common.sleep_time)
-		params->common.sleep_time = 1;
-
-	retval = osnoise_set_cpus(tool->context, params->common.cpus ? params->common.cpus : "all");
-	if (retval) {
-		err_msg("Failed to apply CPUs config\n");
-		goto out_err;
-	}
-
-	if (!params->common.cpus) {
-		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
-			CPU_SET(i, &params->common.monitored_cpus);
-	}
+	int retval;
 
 	if (params->mode != TRACING_MODE_BPF) {
 		/*
@@ -75,29 +61,11 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 		goto out_err;
 	}
 
-	if (params->common.hk_cpus) {
-		retval = sched_setaffinity(getpid(), sizeof(params->common.hk_cpu_set),
-					   &params->common.hk_cpu_set);
-		if (retval == -1) {
-			err_msg("Failed to set rtla to the house keeping CPUs\n");
-			goto out_err;
-		}
-	} else if (params->common.cpus) {
-		/*
-		 * Even if the user do not set a house-keeping CPU, try to
-		 * move rtla to a CPU set different to the one where the user
-		 * set the workload to run.
-		 *
-		 * No need to check results as this is an automatic attempt.
-		 */
-		auto_house_keeping(&params->common.monitored_cpus);
-	}
-
 	/*
 	 * If the user did not specify a type of thread, try user-threads first.
 	 * Fall back to kernel threads otherwise.
 	 */
-	if (!params->kernel_workload && !params->user_data) {
+	if (!params->common.kernel_workload && !params->user_data) {
 		retval = tracefs_file_exists(NULL, "osnoise/per_cpu/cpu0/timerlat_fd");
 		if (retval) {
 			debug_msg("User-space interface detected, setting user-threads\n");
@@ -105,22 +73,11 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 			params->user_data = 1;
 		} else {
 			debug_msg("User-space interface not detected, setting kernel-threads\n");
-			params->kernel_workload = 1;
+			params->common.kernel_workload = 1;
 		}
 	}
 
-	/*
-	 * Set workload according to type of thread if the kernel supports it.
-	 * On kernels without support, user threads will have already failed
-	 * on missing timerlat_fd, and kernel threads do not need it.
-	 */
-	retval = osnoise_set_workload(tool->context, params->kernel_workload);
-	if (retval < -1) {
-		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
-		goto out_err;
-	}
-
-	return 0;
+	return common_apply_config(tool, &params->common);
 
 out_err:
 	return -1;
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index 212ee7971bab..86cd9bac8855 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -27,7 +27,6 @@ struct timerlat_params {
 	int			no_aa;
 	int			dump_tasks;
 	int			user_workload;
-	int			kernel_workload;
 	int			user_data;
 	int			deepest_idle_state;
 	int			aa_only;
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4dc22a749885..d339e2cffae2 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -941,7 +941,7 @@ static struct timerlat_params
 			params->common.stop_us = get_llong_from_str(optarg);
 			break;
 		case 'k':
-			params->kernel_workload = 1;
+			params->common.kernel_workload = 1;
 			break;
 		case 'n':
 			params->common.output_divisor = 1;
@@ -1081,7 +1081,7 @@ static struct timerlat_params
 	if (!params->common.stop_us && !params->common.stop_total_us)
 		params->no_aa = 1;
 
-	if (params->kernel_workload && params->user_workload)
+	if (params->common.kernel_workload && params->user_workload)
 		timerlat_hist_usage("--kernel-threads and --user-threads are mutually exclusive!");
 
 	/*
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 72be083d7d71..bb42697d2575 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -694,7 +694,7 @@ static struct timerlat_params
 			params->common.stop_us = get_llong_from_str(optarg);
 			break;
 		case 'k':
-			params->kernel_workload = true;
+			params->common.kernel_workload = true;
 			break;
 		case 'n':
 			params->common.output_divisor = 1;
@@ -816,7 +816,7 @@ static struct timerlat_params
 	if (params->no_aa && params->aa_only)
 		timerlat_top_usage("--no-aa and --aa-only are mutually exclusive!");
 
-	if (params->kernel_workload && params->user_workload)
+	if (params->common.kernel_workload && params->user_workload)
 		timerlat_top_usage("--kernel-threads and --user-threads are mutually exclusive!");
 
 	/*
-- 
2.50.1



