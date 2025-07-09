Return-Path: <linux-kernel+bounces-724515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39957AFF3E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D635A7AC0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED9E23BD13;
	Wed,  9 Jul 2025 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fKQgKrKb"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95BD230BC9
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096365; cv=none; b=nwODXVr06kygY5dYdZtJOUUGjKBnVv8s4i8Y6JyT7zzOfxhce6HU2NpaaRQA5n0djqwTU2NBMEUYPcXQG+npKflI4q3ZyOmCbea/P9LalWMrs8TTt/leaK/2Vcig9bioVRab0i0juojUv/hmAdE/8QUn+8PwO4YMoFcjXxhbODU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096365; c=relaxed/simple;
	bh=iauZL9jmjufsByEqjLynOS/a/I/93HipMuGHw4CkAUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZh3binjpqhUlOBoNDnQnWscr2iO/zQ2tqHqYLkC+t5k3aJGpSM/FeLDbvkvjjaxo9Vg9HvTCROA6JfgU7UxqjKDemWTcz4pwLautKTFZn+Y/ernZDccOcU/VALiy6wtBXX5wk/E7ZkVqtryFPgwsIGCRrpTH2F7EdVRN1Kt574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=fKQgKrKb; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1752096362;
	bh=iauZL9jmjufsByEqjLynOS/a/I/93HipMuGHw4CkAUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fKQgKrKbHnseUqsqLWBsQJMsXUQvKuXRe7UYe16qIO7Nq9lmpXwIEHBrc+pqUCB92
	 CwJ+oEGkRNC2vcfWS+JYsoXSc1kQRKBBoPRoqud0+XGeMQoD5410XhvUF6kdB1AMhk
	 oFaPAmAa0RYJ6IjVi6ojH+qtnT3BtrC2QpSmWCxp9ooWeBjXfL3FctqeRp48Pa4ZiV
	 KWphDqIT1nwUEixM6cQyMLjfL4+Icp4AUkMkDcORVSNO1Aowp/4qoKs7wTk9P8jM+b
	 9pLDOtWjXbc6ghAHJFTUdq5bUSaXpI3NV/AUvwkSjd6cvve6jl9nbnMPm5pLVkjW8N
	 D9H41DxbioF+g==
Received: from compudjdev.. (192-222-132-26.qc.cable.ebox.net [192.222.132.26])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4bcrcp4QsSzPN5;
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
Subject: [RFC PATCH 3/5] unwind deferred: Introduce unwind_user_trace_cached
Date: Wed,  9 Jul 2025 17:25:50 -0400
Message-ID: <20250709212556.32777-4-mathieu.desnoyers@efficios.com>
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

Introduce unwind_user_trace_cached which copies the stack trace if it
was previously stored into the cache since the last reset of the cache.

The expected use-case is sampling a stack trace from a faultable context
at system call entry (coping it into the cache), and then copying the
stack trace from the cache from non-faultable context to a ring buffer.

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
 include/linux/unwind_deferred.h |  2 ++
 kernel/unwind/deferred.c        | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index a9d5b100d6b2..ddc985ba982a 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -34,6 +34,7 @@ void unwind_task_init(struct task_struct *task);
 void unwind_task_free(struct task_struct *task);
 
 int unwind_user_faultable(struct unwind_stacktrace *trace);
+int unwind_user_trace_cached(struct unwind_stacktrace *trace);
 
 int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);
 int unwind_deferred_request(struct unwind_work *work, u64 *cookie);
@@ -67,6 +68,7 @@ static inline void unwind_task_init(struct task_struct *task) {}
 static inline void unwind_task_free(struct task_struct *task) {}
 
 static inline int unwind_user_faultable(struct unwind_stacktrace *trace) { return -ENOSYS; }
+static inline int unwind_user_trace_cached(struct unwind_stacktrace *trace) { return -ENOSYS; }
 static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func) { return -ENOSYS; }
 static inline int unwind_deferred_request(struct unwind_work *work, u64 *timestamp) { return -ENOSYS; }
 static inline void unwind_deferred_cancel(struct unwind_work *work) {}
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 039e12700d49..02ab1d2afc21 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -145,6 +145,37 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(unwind_user_faultable);
+
+/**
+ * unwind_user_trace_cached - Copy user stack trace from cache
+ * @trace: The descriptor that will store the user stacktrace
+ *
+ * Copy user stack trace from cache if the cache was populated by
+ * unwind_user_faultable prior to this call. The returned trace
+ * entries are only valid until the cache is reset.
+ *
+ * Return: 0 on success and negative on error
+ *         On success @trace will contain the user space stacktrace
+ */
+int unwind_user_trace_cached(struct unwind_stacktrace *trace)
+{
+	struct unwind_task_info *info = &current->unwind_info;
+	struct unwind_cache *cache;
+
+	if (!current->mm)
+		return -EINVAL;
+
+	cache = info->cache;
+	if (!cache || !cache->nr_entries)
+		return -ENOENT;
+
+	trace->nr = cache->nr_entries;
+	trace->entries = cache->entries;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(unwind_user_trace_cached);
 
 static void process_unwind_deferred(struct task_struct *task)
 {
-- 
2.43.0


