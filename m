Return-Path: <linux-kernel+bounces-746761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 691F3B12ADE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FBB17F7E5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5E9286D5E;
	Sat, 26 Jul 2025 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBHChjKM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E362857F6
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753539137; cv=none; b=bE2+AJmNHPMIRgUtGfcWI+tIeGzBDeOvfhQuQIKpPDM8w2vCa3qXY9ZuLwDmANiAZK7sc812nclJ5JioTGw9YFEfB0gFakPwacN2i+SZZX0+2J8Cj8WkUvOUPebStzb4yeDzChPA5TxmCFCcN2GOAU1tH7g0WU1Aapz/YERQKUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753539137; c=relaxed/simple;
	bh=zxeIOtfqBO0cjROJjLLehq1s2dLbW3VEVHSE+Bl8A2s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fTwMjqW9dlSJErc/eddj4qwzTlvdhD+sUsQmACvkJDrAmdeCR4bSXp2CwDNL/xhPk4CmwjC/odwlV6Po1HprBFz9BT/IcjN3rQCfJOs2bGpR1pSEoE+MPKmuOCSfDwQ9rfKekxdpD0FlGCugq9UmQpW6UxXsPHD3iVsRKfl5F1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBHChjKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B16C4CEF6;
	Sat, 26 Jul 2025 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753539137;
	bh=zxeIOtfqBO0cjROJjLLehq1s2dLbW3VEVHSE+Bl8A2s=;
	h=Date:From:To:Cc:Subject:References:From;
	b=kBHChjKMKXDYKJqBwJ3m1fXdxK32fbUeu6t3vLLtF+ecfTVKGLkUAlovbw5Q8PG4n
	 Te8ycLzqD3xa9MnLVyPCZFkGOCpm7JiOkDETgv7qaVQu+s3gcfGuOnh8uazoEegdk4
	 xUfIASxU3bl571iAE5gDDyH+4Ffeq44cGcbC09yc2btF1mOhVBsHUib6FkAq/n/6k/
	 0wdbjJbRwkZSClpURLM0rEkDVHz8F42h/w+TtCuS3yhuv30r5qUQPB2E7AGB5fGWyt
	 yD24JEXzOb6QNeEAds0khnXnrHBmp88qk1GhrRIoIEeJJCWwBQMTAVh+gML9zWp29B
	 Jg3QCTzopgsPQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uffdR-00000001seb-0SIT;
	Sat, 26 Jul 2025 10:12:25 -0400
Message-ID: <20250726141224.964201094@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 26 Jul 2025 10:07:11 -0400
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
Subject: [for-next][PATCH 07/10] unwind deferred: Add unwind_completed mask to stop spurious callbacks
References: <20250726140704.560579628@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

If there's more than one registered tracer to the unwind deferred
infrastructure, it is currently possible that one tracer could cause extra
callbacks to happen for another tracer if the former requests a deferred
stacktrace after the latter's callback was executed and before the task
went back to user space.

Here's an example of how this could occur:

  [Task enters kernel]
    tracer 1 request -> add cookie to its buffer
    tracer 1 request -> add cookie to its buffer
    <..>
    [ task work executes ]
    tracer 1 callback -> add trace + cookie to its buffer

    [tracer 2 requests and triggers the task work again]
    [ task work executes again ]
    tracer 1 callback -> add trace + cookie to its buffer
    tracer 2 callback -> add trace + cookie to its buffer
 [Task exits back to user space]

This is because the bit for tracer 1 gets set in the task's unwind_mask
when it did its request and does not get cleared until the task returns
back to user space. But if another tracer were to request another deferred
stacktrace, then the next task work will executed all tracer's callbacks
that have their bits set in the task's unwind_mask.

To fix this issue, add another mask called unwind_completed and place it
into the task's info->cache structure. The cache structure is allocated
on the first occurrence of a deferred stacktrace and this unwind_completed
mask is not needed until then. It's better to have it in the cache than to
permanently waste space in the task_struct.

After a tracer's callback is executed, it's bit gets set in this
unwind_completed mask. When the task_work enters, it will AND the task's
unwind_mask with the inverse of the unwind_completed which will eliminate
any work that already had its callback executed since the task entered the
kernel.

When the task leaves the kernel, it will reset this unwind_completed mask
just like it resets the other values as it enters user space.

Link: https://lore.kernel.org/all/20250716142609.47f0e4a5@batman.local.home/

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
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
Link: https://lore.kernel.org/20250725185740.245440579@kernel.org
Link: https://lore.kernel.org/20250717004957.580552530@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/unwind_deferred.h       |  4 +++-
 include/linux/unwind_deferred_types.h |  1 +
 kernel/unwind/deferred.c              | 19 +++++++++++++++----
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 337ead927d4d..b9ec4c8515c7 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -55,8 +55,10 @@ static __always_inline void unwind_reset_info(void)
 	 * depends on nr_entries being cleared on exit to user,
 	 * this needs to be a separate conditional.
 	 */
-	if (unlikely(info->cache))
+	if (unlikely(info->cache)) {
 		info->cache->nr_entries = 0;
+		info->cache->unwind_completed = 0;
+	}
 }
 
 #else /* !CONFIG_UNWIND_USER */
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 5dc9cda141ff..33b62ac25c86 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -3,6 +3,7 @@
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
 struct unwind_cache {
+	unsigned long		unwind_completed;
 	unsigned int		nr_entries;
 	unsigned long		entries[];
 };
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index e19f02ef416d..a3d26014a2e6 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -166,12 +166,18 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	unwind_user_faultable(&trace);
 
+	if (info->cache)
+		bits &= ~(info->cache->unwind_completed);
+
 	cookie = info->id.id;
 
 	guard(mutex)(&callback_mutex);
 	list_for_each_entry(work, &callbacks, list) {
-		if (test_bit(work->bit, &bits))
+		if (test_bit(work->bit, &bits)) {
 			work->func(work, &trace, cookie);
+			if (info->cache)
+				info->cache->unwind_completed |= BIT(work->bit);
+		}
 	}
 }
 
@@ -260,23 +266,28 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 void unwind_deferred_cancel(struct unwind_work *work)
 {
 	struct task_struct *g, *t;
+	int bit;
 
 	if (!work)
 		return;
 
+	bit = work->bit;
+
 	/* No work should be using a reserved bit */
-	if (WARN_ON_ONCE(BIT(work->bit) & RESERVED_BITS))
+	if (WARN_ON_ONCE(BIT(bit) & RESERVED_BITS))
 		return;
 
 	guard(mutex)(&callback_mutex);
 	list_del(&work->list);
 
-	__clear_bit(work->bit, &unwind_mask);
+	__clear_bit(bit, &unwind_mask);
 
 	guard(rcu)();
 	/* Clear this bit from all threads */
 	for_each_process_thread(g, t) {
-		clear_bit(work->bit, &t->unwind_info.unwind_mask);
+		clear_bit(bit, &t->unwind_info.unwind_mask);
+		if (t->unwind_info.cache)
+			clear_bit(bit, &t->unwind_info.cache->unwind_completed);
 	}
 }
 
-- 
2.47.2



