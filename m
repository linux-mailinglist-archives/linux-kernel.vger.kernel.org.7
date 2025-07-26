Return-Path: <linux-kernel+bounces-746763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 653DCB12AE1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0729E4E5852
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3750288537;
	Sat, 26 Jul 2025 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErfuAomT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC171FDA
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753539137; cv=none; b=gH3m7M92SwXU+u2YHnzkGR1v40zidwCuEPLDtZwoel+l6PMxWWOIiu+v+8ZmaqxXDO5HpiZq3C8KRHHL7e6b6Xke/0RJbvS5FK/d9VQDsiFaZvmfXoqpm48wdCKqApBqF/6dladg2bEyJergDOPwKwIOHeqZawASUw0UZ8HUxcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753539137; c=relaxed/simple;
	bh=j87oZMixFh27VAzvjm5wL6cqEO6q6gYzANZEcaCLQTY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=tkZf0YsKPvOOVgiihm6hAFf7gjMSf5edB4AU6f4VFeGN2H8UEZp98hHdiLLMtU/WjbGQzOI10ahYZH03jvufa/Gjo31vGKN0TUGoQ7tQ+46nQI4+UGtIkHcv64eEGlgSmCgBCrtWABkKgN5jcEBlBRlMl2el5Fy88I5qYV1AIY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErfuAomT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DD1C4CEED;
	Sat, 26 Jul 2025 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753539137;
	bh=j87oZMixFh27VAzvjm5wL6cqEO6q6gYzANZEcaCLQTY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ErfuAomTc6J1pOOH5vZA4TOcOD7Jn3Jto516/GVGWxRd4tO3MoZj4RuUBi/2CF2G5
	 z3LJsoYkFDHqY1S/K2ZsyrmzYHZxMcIG9gU41Vj2UAwZMpBypVNkWeYbQDlkaNEQk9
	 EYgE8rUX8NXunY+rxESKAvkJUDYbbfLTfsxHAh8kpeLAboWLU9fWwCeeqWBAsmGOWG
	 L+nt3b99dB9lGenLcQXVgBlD5etZ8/gXSznj2gVhxDA5VtFlx18Ji6PCnylYUhgBcX
	 al8wWqShmhJ/2yEg3du++oPjZbuTQGZZpaVF2ERMzglBzMNgb5CProCQFr+PXMBV53
	 Wj5SdjVRK5IAQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uffdR-00000001sfc-1sWq;
	Sat, 26 Jul 2025 10:12:25 -0400
Message-ID: <20250726141225.297220502@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 26 Jul 2025 10:07:13 -0400
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
 "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: [for-next][PATCH 09/10] unwind deferred: Use SRCU unwind_deferred_task_work()
References: <20250726140704.560579628@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Instead of using the callback_mutex to protect the link list of callbacks
in unwind_deferred_task_work(), use SRCU instead. This gets called every
time a task exits that has to record a stack trace that was requested.
This can happen for many tasks on several CPUs at the same time. A mutex
is a bottleneck and can cause a bit of contention and slow down performance.

As the callbacks themselves are allowed to sleep, regular RCU cannot be
used to protect the list. Instead use SRCU, as that still allows the
callbacks to sleep and the list can be read without needing to hold the
callback_mutex.

Link: https://lore.kernel.org/all/ca9bd83a-6c80-4ee0-a83c-224b9d60b755@efficios.com/

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
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
Link: https://lore.kernel.org/20250725185740.581435592@kernel.org
Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/unwind/deferred.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 2311b725d691..a5ef1c1f915e 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -41,7 +41,7 @@ static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
 #define UNWIND_MAX_ENTRIES					\
 	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
 
-/* Guards adding to and reading the list of callbacks */
+/* Guards adding to or removing from the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
 
@@ -49,6 +49,7 @@ static LIST_HEAD(callbacks);
 
 /* Zero'd bits are available for assigning callback users */
 static unsigned long unwind_mask = RESERVED_BITS;
+DEFINE_STATIC_SRCU(unwind_srcu);
 
 static inline bool unwind_pending(struct unwind_task_info *info)
 {
@@ -174,8 +175,9 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	cookie = info->id.id;
 
-	guard(mutex)(&callback_mutex);
-	list_for_each_entry(work, &callbacks, list) {
+	guard(srcu)(&unwind_srcu);
+	list_for_each_entry_srcu(work, &callbacks, list,
+				 srcu_read_lock_held(&unwind_srcu)) {
 		if (test_bit(work->bit, &bits)) {
 			work->func(work, &trace, cookie);
 			if (info->cache)
@@ -213,7 +215,7 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info = &current->unwind_info;
 	unsigned long old, bits;
-	unsigned long bit = BIT(work->bit);
+	unsigned long bit;
 	int ret;
 
 	*cookie = 0;
@@ -230,6 +232,14 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 	if (WARN_ON_ONCE(!CAN_USE_IN_NMI && in_nmi()))
 		return -EINVAL;
 
+	/* Do not allow cancelled works to request again */
+	bit = READ_ONCE(work->bit);
+	if (WARN_ON_ONCE(bit < 0))
+		return -EINVAL;
+
+	/* Only need the mask now */
+	bit = BIT(bit);
+
 	guard(irqsave)();
 
 	*cookie = get_cookie(info);
@@ -281,10 +291,15 @@ void unwind_deferred_cancel(struct unwind_work *work)
 		return;
 
 	guard(mutex)(&callback_mutex);
-	list_del(&work->list);
+	list_del_rcu(&work->list);
+
+	/* Do not allow any more requests and prevent callbacks */
+	work->bit = -1;
 
 	__clear_bit(bit, &unwind_mask);
 
+	synchronize_srcu(&unwind_srcu);
+
 	guard(rcu)();
 	/* Clear this bit from all threads */
 	for_each_process_thread(g, t) {
@@ -307,7 +322,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	work->bit = ffz(unwind_mask);
 	__set_bit(work->bit, &unwind_mask);
 
-	list_add(&work->list, &callbacks);
+	list_add_rcu(&work->list, &callbacks);
 	work->func = func;
 	return 0;
 }
-- 
2.47.2



