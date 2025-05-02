Return-Path: <linux-kernel+bounces-630282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B733AA77C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 18:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD839E38DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53B526FD81;
	Fri,  2 May 2025 16:50:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD1B26A1A7;
	Fri,  2 May 2025 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204611; cv=none; b=DF930Rt0bGxWeHrxe6XW7hmzzmw7xRfTBi+XcuoygMpfIrUSlzmM9Us8Etf9WdRgwRr0X7vCYvvTZ22lwC1NfrKsgKPsEsgA5J2xtSrh1VSDew+YXRccgEDZ58DdWEdB2tqyTNmS0tx4EqRjnbOUEpsbIKPGy1JvZ+4/8TSEpCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204611; c=relaxed/simple;
	bh=UEtOWE46xuWwuKMxIWNEj9dYVjmErfJIhfo7snUx5gA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=M2DlQBQoZIlCKZphIMrdjTkVrEEXYTwQow5BMQDsYENjb8tMqVwszyjjM1IlFJ2qMEGYE11PA42fuYAcQfzBnJmnRALgscEPNzhFykeKsK55UpOlPEDyfQk54+RcHhN8dh8fC7jHOtYmnSS/KEl3eQxN7SbYocvh6oh2x8H661Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C81C4CEF6;
	Fri,  2 May 2025 16:50:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAtaT-0000000034E-0ttS;
	Fri, 02 May 2025 12:50:09 -0400
Message-ID: <20250502165009.069806229@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 12:47:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v7 10/17] unwind_user/deferred: Make unwind deferral requests NMI-safe
References: <20250502164746.178864972@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Make unwind_deferred_request() NMI-safe so tracers in NMI context can
call it to get the cookie immediately rather than have to do the fragile
"schedule irq work and then call unwind_deferred_request()" dance.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v6: https://lore.kernel.org/20250424192612.669992559@goodmis.org

- Have unwind_deferred_request() return positive if already queued.

 include/linux/unwind_deferred_types.h |   1 +
 kernel/unwind/deferred.c              | 100 ++++++++++++++++++++++----
 2 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 33373c32c221..8f47d77ddda0 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -10,6 +10,7 @@ struct unwind_cache {
 struct unwind_task_info {
 	struct unwind_cache	cache;
 	u64			cookie;
+	u64			nmi_cookie;
 	struct callback_head	work;
 	int			pending;
 };
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index b93ad97daf94..d86ea82a8915 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -47,23 +47,47 @@ static u64 ctx_to_cookie(u64 cpu, u64 ctx)
 
 /*
  * Read the task context cookie, first initializing it if this is the first
- * call to get_cookie() since the most recent entry from user.
+ * call to get_cookie() since the most recent entry from user.  This has to be
+ * done carefully to coordinate with unwind_deferred_request_nmi().
  */
 static u64 get_cookie(struct unwind_task_info *info)
 {
 	u64 ctx_ctr;
 	u64 cookie;
-	u64 cpu;
 
 	guard(irqsave)();
 
-	cookie = info->cookie;
+	cookie = READ_ONCE(info->cookie);
 	if (cookie)
 		return cookie;
 
-	cpu = raw_smp_processor_id();
-	ctx_ctr = __this_cpu_inc_return(unwind_ctx_ctr);
-	info->cookie = ctx_to_cookie(cpu, ctx_ctr);
+	ctx_ctr = __this_cpu_read(unwind_ctx_ctr);
+
+	/* Read ctx_ctr before info->nmi_cookie */
+	barrier();
+
+	cookie = READ_ONCE(info->nmi_cookie);
+	if (cookie) {
+		/*
+		 * This is the first call to get_cookie() since an NMI handler
+		 * first wrote it to info->nmi_cookie.  Sync it.
+		 */
+		WRITE_ONCE(info->cookie, cookie);
+		WRITE_ONCE(info->nmi_cookie, 0);
+		return cookie;
+	}
+
+	/*
+	 * Write info->cookie.  It's ok to race with an NMI here.  The value of
+	 * the cookie is based on ctx_ctr from before the NMI could have
+	 * incremented it.  The result will be the same even if cookie or
+	 * ctx_ctr end up getting written twice.
+	 */
+	cookie = ctx_to_cookie(raw_smp_processor_id(), ctx_ctr + 1);
+	WRITE_ONCE(info->cookie, cookie);
+	WRITE_ONCE(info->nmi_cookie, 0);
+	barrier();
+	__this_cpu_write(unwind_ctx_ctr, ctx_ctr + 1);
 
 	return info->cookie;
 }
@@ -139,6 +163,51 @@ static void unwind_deferred_task_work(struct callback_head *head)
 		WRITE_ONCE(info->cookie, 0);
 }
 
+static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *cookie)
+{
+	struct unwind_task_info *info = &current->unwind_info;
+	bool inited_cookie = false;
+	int ret;
+
+	*cookie = info->cookie;
+	if (!*cookie) {
+		/*
+		 * This is the first unwind request since the most recent entry
+		 * from user.  Initialize the task cookie.
+		 *
+		 * Don't write to info->cookie directly, otherwise it may get
+		 * cleared if the NMI occurred in the kernel during early entry
+		 * or late exit before the task work gets to run.  Instead, use
+		 * info->nmi_cookie which gets synced later by get_cookie().
+		 */
+		if (!info->nmi_cookie) {
+			u64 cpu = raw_smp_processor_id();
+			u64 ctx_ctr;
+
+			ctx_ctr = __this_cpu_inc_return(unwind_ctx_ctr);
+			info->nmi_cookie = ctx_to_cookie(cpu, ctx_ctr);
+
+			inited_cookie = true;
+		}
+
+		*cookie = info->nmi_cookie;
+	}
+
+	if (info->pending)
+		return 1;
+
+	ret = task_work_add(current, &info->work, TWA_NMI_CURRENT);
+	if (ret) {
+		if (inited_cookie)
+			info->nmi_cookie = 0;
+		return ret;
+	}
+
+	info->pending = 1;
+
+	return 0;
+}
+
 /*
  * Schedule a user space unwind to be done in task work before exiting the
  * kernel.
@@ -160,31 +229,38 @@ static void unwind_deferred_task_work(struct callback_head *head)
 int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info = &current->unwind_info;
+	int pending;
 	int ret;
 
 	*cookie = 0;
 
-	if (WARN_ON_ONCE(in_nmi()))
-		return -EINVAL;
-
 	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
 	    !user_mode(task_pt_regs(current)))
 		return -EINVAL;
 
+	if (in_nmi())
+		return unwind_deferred_request_nmi(work, cookie);
+
 	guard(irqsave)();
 
 	*cookie = get_cookie(info);
 
 	/* callback already pending? */
-	if (info->pending)
+	pending = READ_ONCE(info->pending);
+	if (pending)
+		return 1;
+
+	/* Claim the work unless an NMI just now swooped in to do so. */
+	if (!try_cmpxchg(&info->pending, &pending, 1))
 		return 1;
 
 	/* The work has been claimed, now schedule it. */
 	ret = task_work_add(current, &info->work, TWA_RESUME);
-	if (WARN_ON_ONCE(ret))
+	if (WARN_ON_ONCE(ret)) {
+		WRITE_ONCE(info->pending, 0);
 		return ret;
+	}
 
-	info->pending = 1;
 	return 0;
 }
 
-- 
2.47.2



