Return-Path: <linux-kernel+bounces-724687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC684AFF5F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABCD1BC8A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A049185C5E;
	Thu, 10 Jul 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="by1ZW1OX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE1433A5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107552; cv=none; b=Us/aL3BIbpQDz6bi+GxkwpXg3GD3RdXIcZ3GpXefd/l/SM2fNZXX28yBUwtHhNxdrf/s1+7bK/EH1RDgeCOL73tELWb1a61BocF7MeUz1tKZTc+OYH23LB38KK+pF+h3/Y6o/Xq9yUk1fTw9Ak/zcSBOPAE6152GZfLcelmCMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107552; c=relaxed/simple;
	bh=BDWmY35h6pBVIEpAlXWHYeo6mtEk7up6CMYAvDU20rs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JGzU1X62Bo5JB8Oj705DoeQ6KHTO3ljTkYzNulCB5MMbJPEPtM+97DVoWd+viMiSLEUsYpq+wPECNZc5ALx3Sa8e7i/sAr3R8ArmnhcbklM4bHpBrwLLdpTkT1453IKoqTJ92ZDXYQ7XzYvkz/I/pZGnmPFbOkrhH7ttOeRVReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=by1ZW1OX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C00AC4CEF9;
	Thu, 10 Jul 2025 00:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107551;
	bh=BDWmY35h6pBVIEpAlXWHYeo6mtEk7up6CMYAvDU20rs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=by1ZW1OX1F19tcffGXV6+e+Yk0mSJa5XiYWt9V2STufc+T2/7nSixM8YSUM5etmC1
	 bI4MlXvpItYKXMsWMu16jUhmnGvtkTI/BGPOKQjjrdsK/+WWZnK/kIpFO6+hiYGpL+
	 CdbXnfFZiQnDKtaxgBy9MSoYStM3SRKNVNpHUlA6C3zvrrth5epvYqNoJxTrniZjYR
	 /PT7a1DpCsqK9KpQJf+Ejh5w1Sdz2Zjo008pYZwNPmnL9ikbG3AL2RQMWlQzm+qB/k
	 t0ML4HnhPPusB/VQsn43nGnEx6l1El10STM+IeA2axDSzOm8juzKH7KHg8A9iyhmG3
	 07Ea+G1gHqbOQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfDI-00000001WPG-0m2I;
	Wed, 09 Jul 2025 20:32:36 -0400
Message-ID: <20250710003236.036259895@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:32:00 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 04/12] rv: Let the reactors take care of buffers
References: <20250710003156.209859354@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Each RV monitor has one static buffer to send to the reactors. If multiple
errors are detected simultaneously, the one buffer could be overwritten.

Instead, leave it to the reactors to handle buffering.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/rv.h               |  9 +++++--
 include/rv/da_monitor.h          | 45 +++++++-------------------------
 kernel/trace/rv/reactor_panic.c  |  8 ++++--
 kernel/trace/rv/reactor_printk.c |  8 ++++--
 kernel/trace/rv/rv_reactors.c    |  2 +-
 5 files changed, 30 insertions(+), 42 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 3452b5e4b29e..9428e62eb8e9 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -38,7 +38,7 @@ union rv_task_monitor {
 struct rv_reactor {
 	const char		*name;
 	const char		*description;
-	void			(*react)(char *msg);
+	__printf(1, 2) void	(*react)(const char *msg, ...);
 };
 #endif
 
@@ -50,7 +50,7 @@ struct rv_monitor {
 	void			(*disable)(void);
 	void			(*reset)(void);
 #ifdef CONFIG_RV_REACTORS
-	void			(*react)(char *msg);
+	__printf(1, 2) void	(*react)(const char *msg, ...);
 #endif
 };
 
@@ -64,6 +64,11 @@ void rv_put_task_monitor_slot(int slot);
 bool rv_reacting_on(void);
 int rv_unregister_reactor(struct rv_reactor *reactor);
 int rv_register_reactor(struct rv_reactor *reactor);
+#else
+static inline bool rv_reacting_on(void)
+{
+	return false;
+}
 #endif /* CONFIG_RV_REACTORS */
 
 #endif /* CONFIG_RV */
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 510c88bfabd4..15f9ed4e4bb6 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -19,45 +19,22 @@
 #ifdef CONFIG_RV_REACTORS
 
 #define DECLARE_RV_REACTING_HELPERS(name, type)							\
-static char REACT_MSG_##name[1024];								\
-												\
-static inline char *format_react_msg_##name(type curr_state, type event)			\
-{												\
-	snprintf(REACT_MSG_##name, 1024,							\
-		 "rv: monitor %s does not allow event %s on state %s\n",			\
-		 #name,										\
-		 model_get_event_name_##name(event),						\
-		 model_get_state_name_##name(curr_state));					\
-	return REACT_MSG_##name;								\
-}												\
-												\
-static void cond_react_##name(char *msg)							\
+static void cond_react_##name(type curr_state, type event)					\
 {												\
-	if (rv_##name.react)									\
-		rv_##name.react(msg);								\
-}												\
-												\
-static bool rv_reacting_on_##name(void)								\
-{												\
-	return rv_reacting_on();								\
+	if (!rv_reacting_on() || !rv_##name.react)						\
+		return;										\
+	rv_##name.react("rv: monitor %s does not allow event %s on state %s\n",			\
+			#name,									\
+			model_get_event_name_##name(event),					\
+			model_get_state_name_##name(curr_state));				\
 }
 
 #else /* CONFIG_RV_REACTOR */
 
 #define DECLARE_RV_REACTING_HELPERS(name, type)							\
-static inline char *format_react_msg_##name(type curr_state, type event)			\
-{												\
-	return NULL;										\
-}												\
-												\
-static void cond_react_##name(char *msg)							\
+static void cond_react_##name(type curr_state, type event)					\
 {												\
 	return;											\
-}												\
-												\
-static bool rv_reacting_on_##name(void)								\
-{												\
-	return 0;										\
 }
 #endif
 
@@ -170,8 +147,7 @@ da_event_##name(struct da_monitor *da_mon, enum events_##name event)				\
 		return true;									\
 	}											\
 												\
-	if (rv_reacting_on_##name())								\
-		cond_react_##name(format_react_msg_##name(curr_state, event));			\
+	cond_react_##name(curr_state, event);							\
 												\
 	trace_error_##name(model_get_state_name_##name(curr_state),				\
 			   model_get_event_name_##name(event));					\
@@ -202,8 +178,7 @@ static inline bool da_event_##name(struct da_monitor *da_mon, struct task_struct
 		return true;									\
 	}											\
 												\
-	if (rv_reacting_on_##name())								\
-		cond_react_##name(format_react_msg_##name(curr_state, event));			\
+	cond_react_##name(curr_state, event);							\
 												\
 	trace_error_##name(tsk->pid,								\
 			   model_get_state_name_##name(curr_state),				\
diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_panic.c
index 0186ff4cbd0b..74c6bcc2c749 100644
--- a/kernel/trace/rv/reactor_panic.c
+++ b/kernel/trace/rv/reactor_panic.c
@@ -13,9 +13,13 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 
-static void rv_panic_reaction(char *msg)
+__printf(1, 2) static void rv_panic_reaction(const char *msg, ...)
 {
-	panic(msg);
+	va_list args;
+
+	va_start(args, msg);
+	vpanic(msg, args);
+	va_end(args);
 }
 
 static struct rv_reactor rv_panic = {
diff --git a/kernel/trace/rv/reactor_printk.c b/kernel/trace/rv/reactor_printk.c
index 178759dbf89f..2dae2916c05f 100644
--- a/kernel/trace/rv/reactor_printk.c
+++ b/kernel/trace/rv/reactor_printk.c
@@ -12,9 +12,13 @@
 #include <linux/init.h>
 #include <linux/rv.h>
 
-static void rv_printk_reaction(char *msg)
+__printf(1, 2) static void rv_printk_reaction(const char *msg, ...)
 {
-	printk_deferred(msg);
+	va_list args;
+
+	va_start(args, msg);
+	vprintk_deferred(msg, args);
+	va_end(args);
 }
 
 static struct rv_reactor rv_printk = {
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 9501ca886d83..740603670dd1 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -490,7 +490,7 @@ void reactor_cleanup_monitor(struct rv_monitor_def *mdef)
 /*
  * Nop reactor register
  */
-static void rv_nop_reaction(char *msg)
+__printf(1, 2) static void rv_nop_reaction(const char *msg, ...)
 {
 }
 
-- 
2.47.2



