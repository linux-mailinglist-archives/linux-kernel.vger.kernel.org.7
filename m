Return-Path: <linux-kernel+bounces-726181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BC6B00919
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2843E178B69
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71262F0044;
	Thu, 10 Jul 2025 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="W2FEa5gW"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5040280A3B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165790; cv=none; b=FR3AHnmqF8bQBDSYx/whnW0qhy4N0DXGkAGLZ42Jld62CFj6TEPldFs+XsMIWSN/HocbjfBAuRlWvULkq1PrZEMgp4XU3zokAXXO1QGqqK7J2u4OdI9LyGaokYv9SsYDZitW7fpUeEwbzhffhgq/B2nXJ33fuW/A75LZNaKEbIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165790; c=relaxed/simple;
	bh=iauZL9jmjufsByEqjLynOS/a/I/93HipMuGHw4CkAUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2AzFjzJcniWE4eh7aT0qV2sBOHdjPNIMK0Cot+/LTy04cvWY4gD7Y4qDpMn8ReUHscEBYAaou0y44Ppyov+ZHurONUC8UqWEDInLCrKCNW6NrN9FuQaUucT19e/XtXdTxjL5g8g8Jia117bExy++AtTi5P9g3IJ+pFUyjn6pN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=W2FEa5gW; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1752165787;
	bh=iauZL9jmjufsByEqjLynOS/a/I/93HipMuGHw4CkAUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W2FEa5gWKrWfLNFrclgLeBD1+6NtU9tpTe6XPzm1LsN4QxMfQg8tAsJCKPdQP9RvY
	 SK1jd44Qn3Odt+TsFhLZzFmsXlhesFiZ7rx359D5ogGqHpRgltrd/TxNRr038bg0UO
	 EbZzRrGNbmcudCowsvXTs54QAj78PNFKuWebGUlyY1YdtN3M7ZpM5XHr+HawyWHoio
	 RJGRKovFvIvDwdbodtBHASRvAb3NJe6imnyDLWF70y0u/oc5qHRc8kcme2nmckNvbu
	 umB3WZR6/R6GVH93HhWfAqlbBbY9sOr2G6rcZzi1zGljJdDmJ+OoD4uJ25rMPbTtHE
	 0doI4YoSOzKgw==
Received: from compudjdev.. (192-222-132-26.qc.cable.ebox.net [192.222.132.26])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4bdLHv40qpzq8s;
	Thu, 10 Jul 2025 12:43:07 -0400 (EDT)
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
Subject: [RFC PATCH v2 3/3] unwind deferred: Introduce unwind_user_trace_cached
Date: Thu, 10 Jul 2025 12:42:58 -0400
Message-ID: <20250710164301.3094-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710164301.3094-1-mathieu.desnoyers@efficios.com>
References: <20250710164301.3094-1-mathieu.desnoyers@efficios.com>
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


