Return-Path: <linux-kernel+bounces-898256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 018D1C54B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EC8D4E223E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF072EBBA8;
	Wed, 12 Nov 2025 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcdTgyd1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51428C5AA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985993; cv=none; b=skuiq32zDoa/Wvn9+LDL7fzgoiD0uPn2/jKmuVN273IUlTf8xg0ahCpxVyI0EcJlgk9fBpq4Easw+XYa32l2APWEPsVeePF2POgNfzvYmJJgWNQFGgs0VXr3Z6LfZrjK6NzEYkA1RJXgASLPUWUzVkEfJIzgd2phLzeRF3BO7RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985993; c=relaxed/simple;
	bh=POC3u7AnVbXu76ZsMfk8t9LhKEeVXOHlgPr7gXT5pAo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YB0bnpdlBKx8RPiscbSfu7P8/YMGIbithhlacHB6IDRBvOFgGNnOPc1HjWwFB4tgnUd/h7HI2TkH6gtCNAJhto1tDlGKQbVIcQzloKyNhZP5Uc7oPBnRY4/f64/FPzYOcbj+JiDeqFUH4Q0b0i+0DcVsbuZbR3Q3y5SQYPXrdC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcdTgyd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EFEC4CEF7;
	Wed, 12 Nov 2025 22:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762985993;
	bh=POC3u7AnVbXu76ZsMfk8t9LhKEeVXOHlgPr7gXT5pAo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=HcdTgyd1NcLAWwZaXN4m82xXuDUY881z4V9p9TVNbhzqMOaBBbLqhwgF5jJOliDlV
	 O2dfelbis4xeKmu22gfMqP31P1wsg+1TWc5SKM/Gj3bL99WbvkB+kATl/USOnWK6Kj
	 Z6+RKJ+yuol88I5NcyVd0aMp6Eax4O8fl2l08fOiyxa5gmTltJ0Pba9CwBgYyyNUhM
	 e2JKbcsYZ6XYFL2R/qsSk8EabdpdXtAh5kuzvsSra3LkUeqOlIvo1dqHF8yJhFARyn
	 3kkSNsmX5NfqQdYxBHCt1lpJiazGPmr9bX5wF9lj/zziVcLQ4h34cOvxHK6YUMuxsy
	 nsNQ7D91oOTqg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vJJCB-00000001EWq-0Mar;
	Wed, 12 Nov 2025 17:20:07 -0500
Message-ID: <20251112222006.938247478@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 12 Nov 2025 17:19:49 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [for-next][PATCH 3/5] rv: Pass va_list to reactors
References: <20251112221946.389142361@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>

The only thing the reactors can do with the passed in varargs is to
convert it into a va_list. Do that in a central helper instead.
It simplifies the reactors, removes some hairy macro-generated code
and introduces a convenient hook point to modify reactor behavior.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Link: https://lore.kernel.org/r/20251014-rv-lockdep-v1-1-0b9e51919ea8@linutronix.de
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/rv.h               | 11 ++++++++--
 include/rv/da_monitor.h          | 35 +++++++++-----------------------
 include/rv/ltl_monitor.h         | 18 +++++-----------
 kernel/trace/rv/reactor_panic.c  |  6 +-----
 kernel/trace/rv/reactor_printk.c |  6 +-----
 kernel/trace/rv/rv_reactors.c    | 16 ++++++++++++++-
 6 files changed, 41 insertions(+), 51 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 9520aab34bcb..b567b0191e67 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -88,7 +88,7 @@ union rv_task_monitor {
 struct rv_reactor {
 	const char		*name;
 	const char		*description;
-	__printf(1, 2) void	(*react)(const char *msg, ...);
+	__printf(1, 0) void	(*react)(const char *msg, va_list args);
 	struct list_head	list;
 };
 #endif
@@ -102,7 +102,7 @@ struct rv_monitor {
 	void			(*reset)(void);
 #ifdef CONFIG_RV_REACTORS
 	struct rv_reactor	*reactor;
-	__printf(1, 2) void	(*react)(const char *msg, ...);
+	__printf(1, 0) void	(*react)(const char *msg, va_list args);
 #endif
 	struct list_head	list;
 	struct rv_monitor	*parent;
@@ -119,11 +119,18 @@ void rv_put_task_monitor_slot(int slot);
 bool rv_reacting_on(void);
 int rv_unregister_reactor(struct rv_reactor *reactor);
 int rv_register_reactor(struct rv_reactor *reactor);
+__printf(2, 3)
+void rv_react(struct rv_monitor *monitor, const char *msg, ...);
 #else
 static inline bool rv_reacting_on(void)
 {
 	return false;
 }
+
+__printf(2, 3)
+static inline void rv_react(struct rv_monitor *monitor, const char *msg, ...)
+{
+}
 #endif /* CONFIG_RV_REACTORS */
 
 #endif /* CONFIG_RV */
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 17fa4f6e5ea6..0cef64366538 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -16,34 +16,19 @@
 #include <linux/bug.h>
 #include <linux/sched.h>
 
-#ifdef CONFIG_RV_REACTORS
-
-#define DECLARE_RV_REACTING_HELPERS(name, type)							\
-static void cond_react_##name(type curr_state, type event)					\
-{												\
-	if (!rv_reacting_on() || !rv_##name.react)						\
-		return;										\
-	rv_##name.react("rv: monitor %s does not allow event %s on state %s\n",			\
-			#name,									\
-			model_get_event_name_##name(event),					\
-			model_get_state_name_##name(curr_state));				\
-}
-
-#else /* CONFIG_RV_REACTOR */
-
-#define DECLARE_RV_REACTING_HELPERS(name, type)							\
-static void cond_react_##name(type curr_state, type event)					\
-{												\
-	return;											\
-}
-#endif
-
 /*
  * Generic helpers for all types of deterministic automata monitors.
  */
 #define DECLARE_DA_MON_GENERIC_HELPERS(name, type)						\
 												\
-DECLARE_RV_REACTING_HELPERS(name, type)								\
+static void react_##name(type curr_state, type event)						\
+{												\
+	rv_react(&rv_##name,									\
+		 "rv: monitor %s does not allow event %s on state %s\n",			\
+		 #name,										\
+		 model_get_event_name_##name(event),						\
+		 model_get_state_name_##name(curr_state));					\
+}												\
 												\
 /*												\
  * da_monitor_reset_##name - reset a monitor and setting it to init state			\
@@ -126,7 +111,7 @@ da_event_##name(struct da_monitor *da_mon, enum events_##name event)				\
 	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {					\
 		next_state = model_get_next_state_##name(curr_state, event);			\
 		if (next_state == INVALID_STATE) {						\
-			cond_react_##name(curr_state, event);					\
+			react_##name(curr_state, event);					\
 			trace_error_##name(model_get_state_name_##name(curr_state),		\
 					   model_get_event_name_##name(event));			\
 			return false;								\
@@ -165,7 +150,7 @@ static inline bool da_event_##name(struct da_monitor *da_mon, struct task_struct
 	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {					\
 		next_state = model_get_next_state_##name(curr_state, event);			\
 		if (next_state == INVALID_STATE) {						\
-			cond_react_##name(curr_state, event);					\
+			react_##name(curr_state, event);					\
 			trace_error_##name(tsk->pid,						\
 					   model_get_state_name_##name(curr_state),		\
 					   model_get_event_name_##name(event));			\
diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 5368cf5fd623..00c42b36f961 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -16,21 +16,12 @@
 #error "Please include $(MODEL_NAME).h generated by rvgen"
 #endif
 
-#ifdef CONFIG_RV_REACTORS
 #define RV_MONITOR_NAME CONCATENATE(rv_, MONITOR_NAME)
-static struct rv_monitor RV_MONITOR_NAME;
 
-static void rv_cond_react(struct task_struct *task)
-{
-	if (!rv_reacting_on() || !RV_MONITOR_NAME.react)
-		return;
-	RV_MONITOR_NAME.react("rv: "__stringify(MONITOR_NAME)": %s[%d]: violation detected\n",
-			      task->comm, task->pid);
-}
+#ifdef CONFIG_RV_REACTORS
+static struct rv_monitor RV_MONITOR_NAME;
 #else
-static void rv_cond_react(struct task_struct *task)
-{
-}
+extern struct rv_monitor RV_MONITOR_NAME;
 #endif
 
 static int ltl_monitor_slot = RV_PER_TASK_MONITOR_INIT;
@@ -98,7 +89,8 @@ static void ltl_monitor_destroy(void)
 static void ltl_illegal_state(struct task_struct *task, struct ltl_monitor *mon)
 {
 	CONCATENATE(trace_error_, MONITOR_NAME)(task);
-	rv_cond_react(task);
+	rv_react(&RV_MONITOR_NAME, "rv: "__stringify(MONITOR_NAME)": %s[%d]: violation detected\n",
+		 task->comm, task->pid);
 }
 
 static void ltl_attempt_start(struct task_struct *task, struct ltl_monitor *mon)
diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_panic.c
index 74c6bcc2c749..76537b8a4343 100644
--- a/kernel/trace/rv/reactor_panic.c
+++ b/kernel/trace/rv/reactor_panic.c
@@ -13,13 +13,9 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 
-__printf(1, 2) static void rv_panic_reaction(const char *msg, ...)
+__printf(1, 0) static void rv_panic_reaction(const char *msg, va_list args)
 {
-	va_list args;
-
-	va_start(args, msg);
 	vpanic(msg, args);
-	va_end(args);
 }
 
 static struct rv_reactor rv_panic = {
diff --git a/kernel/trace/rv/reactor_printk.c b/kernel/trace/rv/reactor_printk.c
index 2dae2916c05f..48c934e315b3 100644
--- a/kernel/trace/rv/reactor_printk.c
+++ b/kernel/trace/rv/reactor_printk.c
@@ -12,13 +12,9 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 
-__printf(1, 2) static void rv_printk_reaction(const char *msg, ...)
+__printf(1, 0) static void rv_printk_reaction(const char *msg, va_list args)
 {
-	va_list args;
-
-	va_start(args, msg);
 	vprintk_deferred(msg, args);
-	va_end(args);
 }
 
 static struct rv_reactor rv_printk = {
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index d32859fec238..cb1a5968055a 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -438,7 +438,7 @@ int reactor_populate_monitor(struct rv_monitor *mon)
 /*
  * Nop reactor register
  */
-__printf(1, 2) static void rv_nop_reaction(const char *msg, ...)
+__printf(1, 0) static void rv_nop_reaction(const char *msg, va_list args)
 {
 }
 
@@ -477,3 +477,17 @@ int init_rv_reactors(struct dentry *root_dir)
 out_err:
 	return -ENOMEM;
 }
+
+void rv_react(struct rv_monitor *monitor, const char *msg, ...)
+{
+	va_list args;
+
+	if (!rv_reacting_on() || !monitor->react)
+		return;
+
+	va_start(args, msg);
+
+	monitor->react(msg, args);
+
+	va_end(args);
+}
-- 
2.51.0



