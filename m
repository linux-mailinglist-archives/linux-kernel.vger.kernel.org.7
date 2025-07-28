Return-Path: <linux-kernel+bounces-748606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A810B14384
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402DA4E39AF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A27527BF7D;
	Mon, 28 Jul 2025 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsaBNAV4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C690624BD04
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735787; cv=none; b=f0t2e1tRhfcZJ2eGbET3Teo+ybJ5Xs8CssNfwJhBgZ89r5WPhMp9hKWdRIhlZXQXYzHtvRHHHcQ/M/zZnzyWQxUEuom0WrXO4+gwSDylXO8mLGPFSiDE6RWUaSctNAkzTYv1i7xIwVdCiOUJ1SFmUUDGWRmk4KHNHMZ4AxazzAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735787; c=relaxed/simple;
	bh=9YGKh50GtwHPpbC/Wepnr2POH1NKu0X7MUW8JpJaOGI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CArCsB4LyIE6Dvc0uE8lNmz1WQWbx3L8+clZu/lEBYf/EjWhDYXZ/gKMZruoSG0unXgK90kyf4Ogd11aTNhWRgrsNLH1+KybDldwMwfXkDRNJs7uRpBpVk7I6DwC051XMf0xCamn+1aM+rq4WqVHOFGZtQ+TF8H8VpXQb+TfB1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsaBNAV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4423EC4CEF6;
	Mon, 28 Jul 2025 20:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753735786;
	bh=9YGKh50GtwHPpbC/Wepnr2POH1NKu0X7MUW8JpJaOGI=;
	h=Date:From:To:Cc:Subject:References:From;
	b=IsaBNAV4REztse1y0UZ8PuUVEW4xABK1rQ7OfkREoar7bWcK3zVjqePt0gedD9ztn
	 hhXZhG+hjEX7uU4hbp+U9ETpCm6ueC7SO9DFmjiispCvnvtEOhdZWxJHAWDSsTzMRw
	 BpNAXLL85jqkiVV+92nAcqD0nisL3YL27fpeoeEo812erVTdkrjypEU4QtnPJpkiC0
	 ncDkA40ARM0nNqm0TuGSm3rUw++gYwFHXyx22Vqo/8ag83OZyndODkb2fh7MyrrUYx
	 IhDKDDW7yNq+c4Cm06ibDfhxNXs0TGbrg/o28kbbQQ4qoqKJQ536UsLoKpdXsGkXKJ
	 XsZe5gP1Es6nQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugUnH-000000042xG-0I1z;
	Mon, 28 Jul 2025 16:49:59 -0400
Message-ID: <20250728204958.921448608@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 28 Jul 2025 16:49:41 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Ingo Molnar <mingo@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Juri Lelli <jlelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 07/11] rv: Retry when da monitor detects race conditions
References: <20250728204934.281385756@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

DA monitor can be accessed from multiple cores simultaneously, this is
likely, for instance when dealing with per-task monitors reacting on
events that do not always occur on the CPU where the task is running.
This can cause race conditions where two events change the next state
and we see inconsistent values. E.g.:

  [62] event_srs: 27: sleepable x sched_wakeup -> running (final)
  [63] event_srs: 27: sleepable x sched_set_state_sleepable -> sleepable
  [63] error_srs: 27: event sched_switch_suspend not expected in the state running

In this case the monitor fails because the event on CPU 62 wins against
the one on CPU 63, although the correct state should have been
sleepable, since the task get suspended.

Detect if the current state was modified by using try_cmpxchg while
storing the next value. If it was, try again reading the current state.
After a maximum number of failed retries, react by calling a special
tracepoint, print on the console and reset the monitor.

Remove the functions da_monitor_curr_state() and da_monitor_set_state()
as they only hide the underlying implementation in this case.

Monitors where this type of condition can occur must be able to account
for racing events in any possible order, as we cannot know the winner.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Juri Lelli <jlelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/20250728135022.255578-6-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/rv.h         |   3 +-
 include/rv/da_monitor.h    | 107 +++++++++++++++++++------------------
 kernel/trace/rv/Kconfig    |   5 ++
 kernel/trace/rv/rv_trace.h |  24 +++++++++
 4 files changed, 85 insertions(+), 54 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 80731242fe60..14410a42faef 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -10,7 +10,8 @@
 #include <linux/types.h>
 #include <linux/list.h>
 
-#define MAX_DA_NAME_LEN	32
+#define MAX_DA_NAME_LEN			32
+#define MAX_DA_RETRY_RACING_EVENTS	3
 
 #ifdef CONFIG_RV
 #include <linux/bitops.h>
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index ed3c34fe18d6..17fa4f6e5ea6 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -54,23 +54,6 @@ static inline void da_monitor_reset_##name(struct da_monitor *da_mon)				\
 	da_mon->curr_state = model_get_initial_state_##name();					\
 }												\
 												\
-/*												\
- * da_monitor_curr_state_##name - return the current state					\
- */												\
-static inline type da_monitor_curr_state_##name(struct da_monitor *da_mon)			\
-{												\
-	return da_mon->curr_state;								\
-}												\
-												\
-/*												\
- * da_monitor_set_state_##name - set the new current state					\
- */												\
-static inline void										\
-da_monitor_set_state_##name(struct da_monitor *da_mon, enum states_##name state)		\
-{												\
-	da_mon->curr_state = state;								\
-}												\
-												\
 /*												\
  * da_monitor_start_##name - start monitoring							\
  *												\
@@ -127,63 +110,81 @@ static inline bool da_monitor_handling_event_##name(struct da_monitor *da_mon)
  * Event handler for implicit monitors. Implicit monitor is the one which the
  * handler does not need to specify which da_monitor to manipulate. Examples
  * of implicit monitor are the per_cpu or the global ones.
+ *
+ * Retry in case there is a race between getting and setting the next state,
+ * warn and reset the monitor if it runs out of retries. The monitor should be
+ * able to handle various orders.
  */
 #define DECLARE_DA_MON_MODEL_HANDLER_IMPLICIT(name, type)					\
 												\
 static inline bool										\
 da_event_##name(struct da_monitor *da_mon, enum events_##name event)				\
 {												\
-	type curr_state = da_monitor_curr_state_##name(da_mon);					\
-	type next_state = model_get_next_state_##name(curr_state, event);			\
-												\
-	if (next_state != INVALID_STATE) {							\
-		da_monitor_set_state_##name(da_mon, next_state);				\
-												\
-		trace_event_##name(model_get_state_name_##name(curr_state),			\
-				   model_get_event_name_##name(event),				\
-				   model_get_state_name_##name(next_state),			\
-				   model_is_final_state_##name(next_state));			\
-												\
-		return true;									\
+	enum states_##name curr_state, next_state;						\
+												\
+	curr_state = READ_ONCE(da_mon->curr_state);						\
+	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {					\
+		next_state = model_get_next_state_##name(curr_state, event);			\
+		if (next_state == INVALID_STATE) {						\
+			cond_react_##name(curr_state, event);					\
+			trace_error_##name(model_get_state_name_##name(curr_state),		\
+					   model_get_event_name_##name(event));			\
+			return false;								\
+		}										\
+		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {	\
+			trace_event_##name(model_get_state_name_##name(curr_state),		\
+					   model_get_event_name_##name(event),			\
+					   model_get_state_name_##name(next_state),		\
+					   model_is_final_state_##name(next_state));		\
+			return true;								\
+		}										\
 	}											\
 												\
-	cond_react_##name(curr_state, event);							\
-												\
-	trace_error_##name(model_get_state_name_##name(curr_state),				\
-			   model_get_event_name_##name(event));					\
-												\
+	trace_rv_retries_error(#name, model_get_event_name_##name(event));			\
+	pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)					\
+		" retries reached for event %s, resetting monitor %s",				\
+		model_get_event_name_##name(event), #name);					\
 	return false;										\
 }												\
 
 /*
  * Event handler for per_task monitors.
+ *
+ * Retry in case there is a race between getting and setting the next state,
+ * warn and reset the monitor if it runs out of retries. The monitor should be
+ * able to handle various orders.
  */
 #define DECLARE_DA_MON_MODEL_HANDLER_PER_TASK(name, type)					\
 												\
 static inline bool da_event_##name(struct da_monitor *da_mon, struct task_struct *tsk,		\
 				   enum events_##name event)					\
 {												\
-	type curr_state = da_monitor_curr_state_##name(da_mon);					\
-	type next_state = model_get_next_state_##name(curr_state, event);			\
-												\
-	if (next_state != INVALID_STATE) {							\
-		da_monitor_set_state_##name(da_mon, next_state);				\
-												\
-		trace_event_##name(tsk->pid,							\
-				   model_get_state_name_##name(curr_state),			\
-				   model_get_event_name_##name(event),				\
-				   model_get_state_name_##name(next_state),			\
-				   model_is_final_state_##name(next_state));			\
-												\
-		return true;									\
+	enum states_##name curr_state, next_state;						\
+												\
+	curr_state = READ_ONCE(da_mon->curr_state);						\
+	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {					\
+		next_state = model_get_next_state_##name(curr_state, event);			\
+		if (next_state == INVALID_STATE) {						\
+			cond_react_##name(curr_state, event);					\
+			trace_error_##name(tsk->pid,						\
+					   model_get_state_name_##name(curr_state),		\
+					   model_get_event_name_##name(event));			\
+			return false;								\
+		}										\
+		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {	\
+			trace_event_##name(tsk->pid,						\
+					   model_get_state_name_##name(curr_state),		\
+					   model_get_event_name_##name(event),			\
+					   model_get_state_name_##name(next_state),		\
+					   model_is_final_state_##name(next_state));		\
+			return true;								\
+		}										\
 	}											\
 												\
-	cond_react_##name(curr_state, event);							\
-												\
-	trace_error_##name(tsk->pid,								\
-			   model_get_state_name_##name(curr_state),				\
-			   model_get_event_name_##name(event));					\
-												\
+	trace_rv_retries_error(#name, model_get_event_name_##name(event));			\
+	pr_warn("rv: " __stringify(MAX_DA_RETRY_RACING_EVENTS)					\
+		" retries reached for event %s, resetting monitor %s",				\
+		model_get_event_name_##name(event), #name);					\
 	return false;										\
 }
 
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 26017378f79b..34164eb4ec91 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -3,12 +3,17 @@
 config RV_MON_EVENTS
 	bool
 
+config RV_MON_MAINTENANCE_EVENTS
+	bool
+
 config DA_MON_EVENTS_IMPLICIT
 	select RV_MON_EVENTS
+	select RV_MON_MAINTENANCE_EVENTS
 	bool
 
 config DA_MON_EVENTS_ID
 	select RV_MON_EVENTS
+	select RV_MON_MAINTENANCE_EVENTS
 	bool
 
 config LTL_MON_EVENTS_ID
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index d38e0d3abdfd..3af46cd185b3 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -176,6 +176,30 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
 #include <monitors/sleep/sleep_trace.h>
 // Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
 #endif /* CONFIG_LTL_MON_EVENTS_ID */
+
+#ifdef CONFIG_RV_MON_MAINTENANCE_EVENTS
+/* Tracepoint useful for monitors development, currenly only used in DA */
+TRACE_EVENT(rv_retries_error,
+
+	TP_PROTO(char *name, char *event),
+
+	TP_ARGS(name, event),
+
+	TP_STRUCT__entry(
+		__string(	name,	name	)
+		__string(	event,	event	)
+	),
+
+	TP_fast_assign(
+		__assign_str(name);
+		__assign_str(event);
+	),
+
+	TP_printk(__stringify(MAX_DA_RETRY_RACING_EVENTS)
+		" retries reached for event %s, resetting monitor %s",
+		__get_str(event), __get_str(name))
+);
+#endif /* CONFIG_RV_MON_MAINTENANCE_EVENTS */
 #endif /* _TRACE_RV_H */
 
 /* This part must be outside protection */
-- 
2.47.2



