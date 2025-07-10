Return-Path: <linux-kernel+bounces-724695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A534AFF5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0AA587DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A331A01C6;
	Thu, 10 Jul 2025 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYmYaeUS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B4D153598
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107553; cv=none; b=D6K/U8ngu4fmVThxFdzOCkJRThkPIXjDzXdUzBzOvJrZzaOmHOSfU93Te+MoOMUiO0nUvVKB8L60TjQd0/XvvK5mlaKeUtsnVUfsJowDlirfjRIKnPEhBtW/zUrtMx3IAOmZNBsQOrbzBFevffa6L6GRnTswiNvaWnFeSKZH5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107553; c=relaxed/simple;
	bh=YIkdfA0oJxoTSNLQmu2YXgWjNnY6Q5LWM2PUs7xxxwM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HqxoqwkR9/OBq0P1D3KkIfMUo5mi4VgmI7aszIMl8Y2RqSsN2gUNELa0HtwRUdXv0Tx9ZO+VcTeNXtHRtEEUcFSkAIdHLMM+5FHDBpy0pxDZtzpp2j/72iadQjzQq0DrdYCInHENh14vJ8AtFxJUN7jfKBQM7HKbXRjg8FqvW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYmYaeUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF716C4CEF5;
	Thu, 10 Jul 2025 00:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107552;
	bh=YIkdfA0oJxoTSNLQmu2YXgWjNnY6Q5LWM2PUs7xxxwM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=MYmYaeUSCzM+kNfm4WChHSE27kGf1jHN9puFb9AMJfTBZEk1vJ1EoOmY0SLRuRDRQ
	 0dLOdV0cf6Z649p7d6aTFyqCsfmQqkXI7RMxMd2/sRdvnRqKQ9G2DcBqOJss9yU4TR
	 OtiLdGACCe6MHMeOYZYqriLwDE55JcIc6E70jG6svb1niZt7HKYUPxZsaLam+STgNB
	 d/N2eWmjp0qLfV7A2p/xCPnGEbM9sYL52RyN/De4Y16XGoNwyA6bQsI/zcPJaIeV9t
	 ayJW5J6ugzyXRsvZWKUQp/FdJ+s8+Kmtw4HEX6izL/sIwD3CNyxqLqruLTwS9AeOlz
	 H0K7Ntl4hOgwg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfDJ-00000001WTF-2FjB;
	Wed, 09 Jul 2025 20:32:37 -0400
Message-ID: <20250710003237.385737381@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:32:08 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Ogness <john.ogness@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 12/12] rv: Allow to configure the number of per-task monitor
References: <20250710003156.209859354@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Now that there are 2 monitors for real-time applications, users may want to
enable both of them simultaneously. Make the number of per-task monitor
configurable. Default it to 2 for now.

Cc: John Ogness <john.ogness@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/93e83313fc4ba7f6e66f4abe80ca5f5494d658d0.1752088709.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/rv.h                     | 9 +--------
 include/linux/sched.h                  | 8 +++-----
 kernel/trace/rv/Kconfig                | 9 +++++++++
 kernel/trace/rv/monitors/rtapp/Kconfig | 1 +
 kernel/trace/rv/rv.c                   | 8 ++++----
 5 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 1d5579f9b75a..97baf58d88b2 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -75,14 +75,7 @@ struct ltl_monitor {};
 
 #endif /* CONFIG_RV_LTL_MONITOR */
 
-/*
- * Per-task RV monitors count. Nowadays fixed in RV_PER_TASK_MONITORS.
- * If we find justification for more monitors, we can think about
- * adding more or developing a dynamic method. So far, none of
- * these are justified.
- */
-#define RV_PER_TASK_MONITORS		1
-#define RV_PER_TASK_MONITOR_INIT	(RV_PER_TASK_MONITORS)
+#define RV_PER_TASK_MONITOR_INIT	(CONFIG_RV_PER_TASK_MONITORS)
 
 union rv_task_monitor {
 	struct da_monitor	da_mon;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4f78a64beb52..fabd7fe1a07a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1642,12 +1642,10 @@ struct task_struct {
 
 #ifdef CONFIG_RV
 	/*
-	 * Per-task RV monitor. Nowadays fixed in RV_PER_TASK_MONITORS.
-	 * If we find justification for more monitors, we can think
-	 * about adding more or developing a dynamic method. So far,
-	 * none of these are justified.
+	 * Per-task RV monitor, fixed in CONFIG_RV_PER_TASK_MONITORS.
+	 * If memory becomes a concern, we can think about a dynamic method.
 	 */
-	union rv_task_monitor		rv[RV_PER_TASK_MONITORS];
+	union rv_task_monitor		rv[CONFIG_RV_PER_TASK_MONITORS];
 #endif
 
 #ifdef CONFIG_USER_EVENTS
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 942d57575e67..c11bf7e61ebf 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -32,6 +32,15 @@ menuconfig RV
 	  For further information, see:
 	    Documentation/trace/rv/runtime-verification.rst
 
+config RV_PER_TASK_MONITORS
+	int "Maximum number of per-task monitor"
+	depends on RV
+	range 1 8
+	default 2
+	help
+	  This option configures the maximum number of per-task RV monitors that can run
+	  simultaneously.
+
 source "kernel/trace/rv/monitors/wip/Kconfig"
 source "kernel/trace/rv/monitors/wwnr/Kconfig"
 source "kernel/trace/rv/monitors/sched/Kconfig"
diff --git a/kernel/trace/rv/monitors/rtapp/Kconfig b/kernel/trace/rv/monitors/rtapp/Kconfig
index b7415c3570bb..1ce9370a9ba8 100644
--- a/kernel/trace/rv/monitors/rtapp/Kconfig
+++ b/kernel/trace/rv/monitors/rtapp/Kconfig
@@ -1,5 +1,6 @@
 config RV_MON_RTAPP
 	depends on RV
+	depends on RV_PER_TASK_MONITORS >= 2
 	bool "rtapp monitor"
 	help
 	  Collection of monitors to check for common problems with real-time
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index e25d65fe432a..108429d16ec1 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -165,7 +165,7 @@ struct dentry *get_monitors_root(void)
 LIST_HEAD(rv_monitors_list);
 
 static int task_monitor_count;
-static bool task_monitor_slots[RV_PER_TASK_MONITORS];
+static bool task_monitor_slots[CONFIG_RV_PER_TASK_MONITORS];
 
 int rv_get_task_monitor_slot(void)
 {
@@ -173,12 +173,12 @@ int rv_get_task_monitor_slot(void)
 
 	lockdep_assert_held(&rv_interface_lock);
 
-	if (task_monitor_count == RV_PER_TASK_MONITORS)
+	if (task_monitor_count == CONFIG_RV_PER_TASK_MONITORS)
 		return -EBUSY;
 
 	task_monitor_count++;
 
-	for (i = 0; i < RV_PER_TASK_MONITORS; i++) {
+	for (i = 0; i < CONFIG_RV_PER_TASK_MONITORS; i++) {
 		if (task_monitor_slots[i] == false) {
 			task_monitor_slots[i] = true;
 			return i;
@@ -194,7 +194,7 @@ void rv_put_task_monitor_slot(int slot)
 {
 	lockdep_assert_held(&rv_interface_lock);
 
-	if (slot < 0 || slot >= RV_PER_TASK_MONITORS) {
+	if (slot < 0 || slot >= CONFIG_RV_PER_TASK_MONITORS) {
 		WARN_ONCE(1, "RV releasing an invalid slot!: %d\n", slot);
 		return;
 	}
-- 
2.47.2



