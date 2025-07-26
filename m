Return-Path: <linux-kernel+bounces-746759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BADBB12ADD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C200B3AF481
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF46728643A;
	Sat, 26 Jul 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhMvs9b4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C8F245000
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753539137; cv=none; b=d2/XbMQewFLgWGZuYQn2bHqbhDapU9DgZNRnxg4DESFKSD9plBhfb+WvaWwwserssr4ky6DhlF9odMS622exnaNdCfAxvFIS0+/a2mkfMr7EHwGvSpva9ahp22QBorRhlIOcnMO5J3Mud6I0B3WwFsyQ151jLU2r2m04PTotRiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753539137; c=relaxed/simple;
	bh=k8G4+w7Lveoc7WwBZA/bdbyFE3GFQKX3cxXTnI8tWgs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YaukqxSHClnYZfbxNpiLEa18pla1aXA72T99Oe46F/KbquH01wwmxOQfmd/rQ7cTh0Ks/NVsYTKPQs1xBOZpmo6LpO1mIpV/h6ojc8u3IdyKLe1yxewJWPIrtbvhR56filoogEvvcwIu0WbF2G4LvOHdQxHkvn4mqKjswYdx3AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhMvs9b4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AEDC4CEF4;
	Sat, 26 Jul 2025 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753539137;
	bh=k8G4+w7Lveoc7WwBZA/bdbyFE3GFQKX3cxXTnI8tWgs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=PhMvs9b4xCwX2v0A3ALQIc28l81BRdwZfUfeqRBtatrQDyv3J7S+0WzK93sm0OiBa
	 buD6WcXCUuFAgi74//jdx8Zc/Kt7biy5j9nBplo3rpYiux2ZD0hfa0Db1DHTzP4jxP
	 86U/Ib1o81bo2H8SsyikFDgCPbZwtnMxKtchzHVz+SI15sj/EDZo4wHSCcsfLxnkj1
	 5g3TROX5C+IpzZZqL18aSdMQSdkouqvv2DynUGfAg+T0gvqQarKCCRCKRgxt2HXKYh
	 hTFih9WQF8u2IP6ZNEtqYc252kzkKoEF/S+uaiC8rOfMkeMRw3zLgG0kvudp6FNLWF
	 A4LdFmOW4777w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uffdQ-00000001sdc-3F5e;
	Sat, 26 Jul 2025 10:12:24 -0400
Message-ID: <20250726141224.627257236@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 26 Jul 2025 10:07:09 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [for-next][PATCH 05/10] unwind_user/deferred: Make unwind deferral requests NMI-safe
References: <20250726140704.560579628@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Make unwind_deferred_request() NMI-safe so tracers in NMI context can
call it and safely request a user space stacktrace when the task exits.

Note, this is only allowed for architectures that implement a safe
cmpxchg. If an architecture requests a deferred stack trace from NMI
context that does not support a safe NMI cmpxchg, it will get an -EINVAL
and trigger a warning. For those architectures, they would need another
method (perhaps an irqwork), to request a deferred user space stack trace.
That can be dealt with later if one of theses architectures require this
feature.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Jens Remus <jremus@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Sam James <sam@gentoo.org>
Link: https://lore.kernel.org/20250725185739.906767342@kernel.org
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/unwind/deferred.c | 52 +++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 2cbae2ada309..c5ac087d2396 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -12,6 +12,31 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 
+/*
+ * For requesting a deferred user space stack trace from NMI context
+ * the architecture must support a safe cmpxchg in NMI context.
+ * For those architectures that do not have that, then it cannot ask
+ * for a deferred user space stack trace from an NMI context. If it
+ * does, then it will get -EINVAL.
+ */
+#if defined(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG)
+# define CAN_USE_IN_NMI		1
+static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
+{
+	u32 old = 0;
+
+	return try_cmpxchg(&info->id.cnt, &old, cnt);
+}
+#else
+# define CAN_USE_IN_NMI		0
+/* When NMIs are not allowed, this always succeeds */
+static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
+{
+	info->id.cnt = cnt;
+	return true;
+}
+#endif
+
 /* Make the cache fit in a 4K page */
 #define UNWIND_MAX_ENTRIES					\
 	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
@@ -42,14 +67,13 @@ static DEFINE_PER_CPU(u32, unwind_ctx_ctr);
 static u64 get_cookie(struct unwind_task_info *info)
 {
 	u32 cnt = 1;
-	u32 old = 0;
 
 	if (info->id.cpu)
 		return info->id.id;
 
 	/* LSB is always set to ensure 0 is an invalid value */
 	cnt |= __this_cpu_read(unwind_ctx_ctr) + 2;
-	if (try_cmpxchg(&info->id.cnt, &old, cnt)) {
+	if (try_assign_cnt(info, cnt)) {
 		/* Update the per cpu counter */
 		__this_cpu_write(unwind_ctx_ctr, cnt);
 	}
@@ -167,31 +191,43 @@ static void unwind_deferred_task_work(struct callback_head *head)
 int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info = &current->unwind_info;
+	long pending;
 	int ret;
 
 	*cookie = 0;
 
-	if (WARN_ON_ONCE(in_nmi()))
-		return -EINVAL;
-
 	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
 	    !user_mode(task_pt_regs(current)))
 		return -EINVAL;
 
+	/*
+	 * NMI requires having safe cmpxchg operations.
+	 * Trigger a warning to make it obvious that an architecture
+	 * is using this in NMI when it should not be.
+	 */
+	if (WARN_ON_ONCE(!CAN_USE_IN_NMI && in_nmi()))
+		return -EINVAL;
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



