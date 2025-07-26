Return-Path: <linux-kernel+bounces-746762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82D6B12AE0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60C51C2375D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA298288533;
	Sat, 26 Jul 2025 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h24hNXQO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D575285CA8
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753539137; cv=none; b=X73Inptw7qZLgjX0ys1pZj3ObZtML2HJ0tfp9RMoNnPbPOjF28ntHyj1Y/jHTvje70KHROZkA5h+DQgX8nkIt62eELAsrFCPYU10eeeGN+XHRTMeitMR3fNaoWXl2yBTBhCHrGw6cFugOibmXlr4ARwFjtOqIarC9amrnXgJBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753539137; c=relaxed/simple;
	bh=TSnt1MZyrgImeniojWyfyPM5ExY493RrmpPNKzuycvE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RRTjd+vHYkons34ym4qs1Vi1r3fgfjUs7akPgyhCcGxuKB0m3qpAdXlEktt7KrrFg8TJEtxjD5STmsMA5pjuP5Hjx/ewKbgHt+uLiMCkQipo0osAou2MJcZ2UqRLpMaV2pQ867Hm7t/LX6nd1/9bTEJJESkwuWB9FjSOx6KRGVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h24hNXQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5FAC4CEFB;
	Sat, 26 Jul 2025 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753539137;
	bh=TSnt1MZyrgImeniojWyfyPM5ExY493RrmpPNKzuycvE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=h24hNXQOpc5JZg5jxQMB9Gryq2LacD3F7RlJew+XkVzbhpguRuQuulM7WzMGNo+hI
	 EV8CtgUIboWSwhxZMS2A+zz6u6aT3ltp0vfBQvLmaQs6luGiu/ZEhjjtwD4Y8i4cNJ
	 m7kg63N1ZqjnBABcuFCTRg1svaNgNQvLS+7li30akdYlTXi0KrYRLYnKhdr59NRU8q
	 U3tb1THCxK8KAAUa1TmwHi2Wj1EfXbw9ZBR4XH2fNT0MVVA66vJe2OdI+J7XrEo1+D
	 xWHEN60uFmKgzq8isNkmhvsLDZuSNJha1QnUzWQuDmPD5jUe1M+ofYGfnL1x+hFbeM
	 F//rxOdZ/Nqmg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uffdR-00000001sf6-1A0m;
	Sat, 26 Jul 2025 10:12:25 -0400
Message-ID: <20250726141225.129577701@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 26 Jul 2025 10:07:12 -0400
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
Subject: [for-next][PATCH 08/10] unwind: Add USED bit to only have one conditional on way back to user
 space
References: <20250726140704.560579628@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

On the way back to user space, the function unwind_reset_info() is called
unconditionally (but always inlined). It currently has two conditionals.
One that checks the unwind_mask which is set whenever a deferred trace is
called and is used to know that the mask needs to be cleared. The other
checks if the cache has been allocated, and if so, it resets the
nr_entries so that the unwinder knows it needs to do the work to get a new
user space stack trace again (it only does it once per entering the
kernel).

Use one of the bits in the unwind mask as a "USED" bit that gets set
whenever a trace is created. This will make it possible to only check the
unwind_mask in the unwind_reset_info() to know if it needs to do work or
not and eliminates a conditional that happens every time the task goes
back to user space.

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
Link: https://lore.kernel.org/20250725185740.414087734@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/unwind_deferred.h | 18 +++++++++---------
 kernel/unwind/deferred.c        |  5 ++++-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index b9ec4c8515c7..2efbda01e959 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -20,10 +20,14 @@ struct unwind_work {
 
 enum {
 	UNWIND_PENDING_BIT = 0,
+	UNWIND_USED_BIT,
 };
 
 enum {
 	UNWIND_PENDING		= BIT(UNWIND_PENDING_BIT),
+
+	/* Set if the unwinding was used (directly or deferred) */
+	UNWIND_USED		= BIT(UNWIND_USED_BIT)
 };
 
 void unwind_task_init(struct task_struct *task);
@@ -49,15 +53,11 @@ static __always_inline void unwind_reset_info(void)
 				return;
 		} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
 		current->unwind_info.id.id = 0;
-	}
-	/*
-	 * As unwind_user_faultable() can be called directly and
-	 * depends on nr_entries being cleared on exit to user,
-	 * this needs to be a separate conditional.
-	 */
-	if (unlikely(info->cache)) {
-		info->cache->nr_entries = 0;
-		info->cache->unwind_completed = 0;
+
+		if (unlikely(info->cache)) {
+			info->cache->nr_entries = 0;
+			info->cache->unwind_completed = 0;
+		}
 	}
 }
 
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index a3d26014a2e6..2311b725d691 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -45,7 +45,7 @@ static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
 
-#define RESERVED_BITS	(UNWIND_PENDING)
+#define RESERVED_BITS	(UNWIND_PENDING | UNWIND_USED)
 
 /* Zero'd bits are available for assigning callback users */
 static unsigned long unwind_mask = RESERVED_BITS;
@@ -140,6 +140,9 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
 
 	cache->nr_entries = trace->nr;
 
+	/* Clear nr_entries on way back to user space */
+	set_bit(UNWIND_USED_BIT, &info->unwind_mask);
+
 	return 0;
 }
 
-- 
2.47.2



