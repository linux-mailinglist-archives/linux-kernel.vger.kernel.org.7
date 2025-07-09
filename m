Return-Path: <linux-kernel+bounces-724517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8246FAFF3E3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCB55A7D5C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DFA2459E1;
	Wed,  9 Jul 2025 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lvpU8+xU"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6135D23AB86
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096366; cv=none; b=EghNs/fWCzlPi4nzZZkZK+jE0AtaCpEbqpIROeujP3f1jBzn4mOm3bJ7zy7s+jsmeT7gh924sh9tAnNyMyPOz4HA9Os5LQnHv556RGOQL/A7v04uAW+G0Nv+/Y2hHJeEjYn1mqVic55OWhmAqIlJWEKOnXRVqkriiO9LacsBRW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096366; c=relaxed/simple;
	bh=JN5RMLEHICyZc002MuT4nzGEIbF38xkIf26bUm21Crg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecQgUvjH9n1NhnbGXKU+sjhGh9QZEME7mwOouD2Viizn6fC608NXqbcHfNQGHQgFztKLbPjpgSxcBEji919rAkw5KAT7v1+6pok/HKcht9rb+5L5nLGuI7fjlPjEULdpkw076gH+eWv25jE03kh3wmi16fBaX4zAbXfi1jbnvsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=lvpU8+xU; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1752096363;
	bh=JN5RMLEHICyZc002MuT4nzGEIbF38xkIf26bUm21Crg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lvpU8+xUOBSKkTMNHciLOHamjL6925svjwq4kcre0mVqqgN+xr2DL6eoO7fIWtVQf
	 yK82deWLKMY36usGcisC8XcDNexwEUTdrh2M2zmZcIRP5JZqJLQ6CUSUFNnlZJ2p1J
	 x8x4NFSmQOXEgg5uuv5JNBtUappKTG4/+BxhXUIOuMuc6iMSlOXLh2cJFH9Wz+Z5aH
	 XuAj6nKVypKU/6ppm5tqt2pmwIWNcE1Rj00x9ar8wOZhpfpEOnjvxY8kVLqmMGlmOr
	 wYMMc7QX7nKi4IGLECKaUNmgs1HVlXGZK+wpqOb8QbIqUj2kI+JgfAsegqGBPJnCDH
	 hOKcpZKPlJKXA==
Received: from compudjdev.. (192-222-132-26.qc.cable.ebox.net [192.222.132.26])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4bcrcq03JxzPN6;
	Wed,  9 Jul 2025 17:26:02 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 4/5] unwind: Rename unwind_stacktrace to unwind_user_stacktrace
Date: Wed,  9 Jul 2025 17:25:51 -0400
Message-ID: <20250709212556.32777-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the unwind_stacktrace structure to unwind_user_stacktrace to make
it consistent with the rest of the API.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Jens Remus <jremus@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/unwind_deferred.h   | 10 +++++-----
 include/linux/unwind_user.h       |  2 +-
 include/linux/unwind_user_types.h |  2 +-
 kernel/unwind/deferred.c          |  6 +++---
 kernel/unwind/user.c              |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index ddc985ba982a..62f1faf5f2b8 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -8,7 +8,7 @@
 
 struct unwind_work;
 
-typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stacktrace *trace, u64 cookie);
+typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_user_stacktrace *trace, u64 cookie);
 
 struct unwind_work {
 	struct list_head		list;
@@ -33,8 +33,8 @@ enum {
 void unwind_task_init(struct task_struct *task);
 void unwind_task_free(struct task_struct *task);
 
-int unwind_user_faultable(struct unwind_stacktrace *trace);
-int unwind_user_trace_cached(struct unwind_stacktrace *trace);
+int unwind_user_faultable(struct unwind_user_stacktrace *trace);
+int unwind_user_trace_cached(struct unwind_user_stacktrace *trace);
 
 int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
 int unwind_deferred_request(struct unwind_work *work, u64 *cookie);
@@ -67,8 +67,8 @@ static __always_inline void unwind_reset_info(void)
 static inline void unwind_task_init(struct task_struct *task) {}
 static inline void unwind_task_free(struct task_struct *task) {}
 
-static inline int unwind_user_faultable(struct unwind_stacktrace *trace) { return -ENOSYS; }
-static inline int unwind_user_trace_cached(struct unwind_stacktrace *trace) { return -ENOSYS; }
+static inline int unwind_user_faultable(struct unwind_user_stacktrace *trace) { return -ENOSYS; }
+static inline int unwind_user_trace_cached(struct unwind_user_stacktrace *trace) { return -ENOSYS; }
 static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func) { return -ENOSYS; }
 static inline int unwind_deferred_request(struct unwind_work *work, u64 *timestamp) { return -ENOSYS; }
 static inline void unwind_deferred_cancel(struct unwind_work *work) {}
diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
index 0308adb349fc..6022c77518f3 100644
--- a/include/linux/unwind_user.h
+++ b/include/linux/unwind_user.h
@@ -25,6 +25,6 @@ static inline void arch_unwind_user_init(struct unwind_user_state *state, struct
 static inline void arch_unwind_user_next(struct unwind_user_state *state) {}
 #endif
 
-int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries);
+int unwind_user(struct unwind_user_stacktrace *trace, unsigned int max_entries);
 
 #endif /* _LINUX_UNWIND_USER_H */
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index fc440ae3a29b..860f84cd7998 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -28,7 +28,7 @@ enum unwind_user_type {
 	UNWIND_USER_TYPE_FP =			(1U << UNWIND_USER_TYPE_FP_BIT),
 };
 
-struct unwind_stacktrace {
+struct unwind_user_stacktrace {
 	unsigned int	nr;
 	unsigned long	*entries;
 };
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 02ab1d2afc21..4006d253c793 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -105,7 +105,7 @@ static u64 get_cookie(struct unwind_task_info *info)
  * Return: 0 on success and negative on error
  *         On success @trace will contain the user space stacktrace
  */
-int unwind_user_faultable(struct unwind_stacktrace *trace)
+int unwind_user_faultable(struct unwind_user_stacktrace *trace)
 {
 	struct unwind_task_info *info = &current->unwind_info;
 	struct unwind_cache *cache;
@@ -158,7 +158,7 @@ EXPORT_SYMBOL_GPL(unwind_user_faultable);
  * Return: 0 on success and negative on error
  *         On success @trace will contain the user space stacktrace
  */
-int unwind_user_trace_cached(struct unwind_stacktrace *trace)
+int unwind_user_trace_cached(struct unwind_user_stacktrace *trace)
 {
 	struct unwind_task_info *info = &current->unwind_info;
 	struct unwind_cache *cache;
@@ -180,7 +180,7 @@ EXPORT_SYMBOL_GPL(unwind_user_trace_cached);
 static void process_unwind_deferred(struct task_struct *task)
 {
 	struct unwind_task_info *info = &task->unwind_info;
-	struct unwind_stacktrace trace;
+	struct unwind_user_stacktrace trace;
 	struct unwind_work *work;
 	unsigned long bits;
 	u64 cookie;
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index 9aefbfc8427a..dfe7bf50d8f6 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -167,7 +167,7 @@ static int unwind_user_start(struct unwind_user_state *state)
 	return 0;
 }
 
-int unwind_user(struct unwind_stacktrace *trace, unsigned int max_entries)
+int unwind_user(struct unwind_user_stacktrace *trace, unsigned int max_entries)
 {
 	struct unwind_user_state state;
 
-- 
2.43.0


