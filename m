Return-Path: <linux-kernel+bounces-752263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B96B1734C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0F81C238E7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3EA18E750;
	Thu, 31 Jul 2025 14:32:01 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5201484D13
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753972321; cv=none; b=YDvwfeoEqhCXug/NWnraq5SrDW3I/AGQSMmLfNSeWFdm3HJb1NlLhgpu0jL5KxIBYPhFjNj8hCPoIzlpY0X1v+9A4kBt2A0lAtSg7zFSg/I+xxDabUkNrvB8DcWbrgG3irZCdnk3pTIClBeg4KVizsyavcrarj53YoXEVrFBHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753972321; c=relaxed/simple;
	bh=OjYBOi6lfVQaVSPqYRvBXrHHcJSrruVnIlAoGzmsMEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nS+D6e2rs+L9rQeJe8viiYOyp6q3jtIBtNcyo1SL/+VTYAUkiRNN3TST0604obEoXdQY6ovowaUQu+pGfPHkkgZlvoZP+Kv3r0wZ0gyxlGohPhph/c3/+wcVlxmbkm3RpD5QAwBOlxzJljCjJehSLPUeJ6ZT5EIZQhALv8dr8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 00389C0551;
	Thu, 31 Jul 2025 14:31:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 8B40D1B;
	Thu, 31 Jul 2025 14:31:53 +0000 (UTC)
Date: Thu, 31 Jul 2025 10:32:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: [GIT PULL] unwind_deferred: Inclusion for v6.17
Message-ID: <20250731103211.10b42cb5@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8B40D1B
X-Stat-Signature: 9fjsiyzy1nat1qexy9j1nzjn1owzpz9g
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/h8dPpxYJfOLkHsGa1pxloUjwdFjMh0eQ=
X-HE-Tag: 1753972313-276571
X-HE-Meta: U2FsdGVkX19A+RPZmgxW8PS/UIvt/rInpBE1rVrJQvs2UOTALmwOvhcccXYBcGQaA4FRWwpWm4/Mob0nT/wufsyYr/MJQOjslph4rZPhuoT2SKGrySdnGRjWojKzyrIxWRQjRkqsxAtoKBetD10BpzIhpl9G5LThGsKmqNCL6jus9WXm9RaOpiJGWO2CTZvJCe0PWrA/FohFbrxAkIQF1hhysddspi2wZfrDRiBSLrEZEj8o45wTPxaKF1nOltBqCwcMxEF3vdoyTEq1mEoKt+TZYmk3eE208xWI9UiSGfmlFexCrWHdi1kX8KEttSOfLuJox7uJhvHLtgtqrZLMDYIrFnX3jew0lRMdv8kul5CVniZY3/oh4Kfdh8/S3BBtzqrwV5oabCxYBWUzZL1u0G0WUDDFgI/h1gJYgJ3+nlrbw1Ep461Ed3aG5BDKcOzwdkEd3UvGIQde9wtAe3EYdRunSnTvNTm0UVdq9PvZT3s=


Linus,

Deferred unwind changes for 6.17

This is the core infrastructure for the deferred unwinder that is required
for sframes[1]. Several other patch series is based on this work although
those patch series are not dependent on each other. In order to simplify the
development, having this core series upstream will allow the other series to
be worked on in parallel. The other series are:

- The two patches to implement x86:
  https://lore.kernel.org/linux-trace-kernel/20250717004958.260781923@kernel.org/
  https://lore.kernel.org/linux-trace-kernel/20250717004958.432327787@kernel.org/

- The s390 work:
  https://lore.kernel.org/linux-trace-kernel/20250710163522.3195293-1-jremus@linux.ibm.com/

- The perf work:
  https://lore.kernel.org/linux-trace-kernel/20250718164119.089692174@kernel.org/

- The ftrace work:
  https://lore.kernel.org/linux-trace-kernel/20250424192612.505622711@goodmis.org/

- The sframe work:
  https://lore.kernel.org/linux-trace-kernel/20250717012848.927473176@kernel.org/

And more is on the way.

The core infrastructure adds the following in kernel APIs:

- int unwind_user_faultable(struct unwind_stacktrace *trace);

    Performs a user space stack trace that may fault user pages in.

- int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func);

    Allows a tracer to register with the unwind deferred infrastructure.

- int unwind_deferred_request(struct unwind_work *work, u64 *cookie);

    Used when a tracer request a deferred trace. Can be called from interrupt
    or NMI context.

- void unwind_deferred_cancel(struct unwind_work *work);

    Called by a tracer to unregister from the deferred unwind infrastructure.

- void unwind_deferred_task_exit(struct task_struct *task);

    Called by task exit code to flush any pending unwind requests.

- void unwind_task_init(struct task_struct *task);

    Called by do_fork() to initialize the task struct for the deferred
    unwinder.

- void unwind_task_free(struct task_struct *task);

    Called by do_exit() to free up any resources used by the deferred
    unwinder.

None of the above is actually compiled unless an architecture enables it,
which none currently do.

[1] https://sourceware.org/binutils/wiki/sframe


Please pull the latest trace-deferred-unwind-v6.17 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-deferred-unwind-v6.17

Tag SHA1: 174c4bf22a4c37e5cf4fedb540bfd7c09f472640
Head SHA1: b3b9cb11aa034cfa9eb880bb9bb3d5aaf732e479


Josh Poimboeuf (3):
      unwind_user: Add user space unwinding API with frame pointer support
      unwind_user/deferred: Add unwind cache
      unwind_user/deferred: Add deferred unwinding interface

Steven Rostedt (7):
      unwind_user/deferred: Add unwind_user_faultable()
      unwind_user/deferred: Make unwind deferral requests NMI-safe
      unwind deferred: Use bitmask to determine which callbacks to call
      unwind deferred: Add unwind_completed mask to stop spurious callbacks
      unwind: Add USED bit to only have one conditional on way back to user space
      unwind deferred: Use SRCU unwind_deferred_task_work()
      unwind: Finish up unwind when a task exits

----
 MAINTAINERS                           |   8 +
 arch/Kconfig                          |   7 +
 include/asm-generic/Kbuild            |   1 +
 include/asm-generic/unwind_user.h     |   5 +
 include/linux/entry-common.h          |   2 +
 include/linux/sched.h                 |   5 +
 include/linux/unwind_deferred.h       |  81 ++++++++
 include/linux/unwind_deferred_types.h |  39 ++++
 include/linux/unwind_user.h           |  14 ++
 include/linux/unwind_user_types.h     |  44 +++++
 kernel/Makefile                       |   1 +
 kernel/exit.c                         |   2 +
 kernel/fork.c                         |   4 +
 kernel/unwind/Makefile                |   1 +
 kernel/unwind/deferred.c              | 362 ++++++++++++++++++++++++++++++++++
 kernel/unwind/user.c                  | 128 ++++++++++++
 16 files changed, 704 insertions(+)
 create mode 100644 include/asm-generic/unwind_user.h
 create mode 100644 include/linux/unwind_deferred.h
 create mode 100644 include/linux/unwind_deferred_types.h
 create mode 100644 include/linux/unwind_user.h
 create mode 100644 include/linux/unwind_user_types.h
 create mode 100644 kernel/unwind/Makefile
 create mode 100644 kernel/unwind/deferred.c
 create mode 100644 kernel/unwind/user.c
---------------------------

