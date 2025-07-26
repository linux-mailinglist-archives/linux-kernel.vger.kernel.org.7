Return-Path: <linux-kernel+bounces-746756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 533DBB12ADA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87BE317F6FA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF2285CA6;
	Sat, 26 Jul 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8H+eA3x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674C242D88
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753539137; cv=none; b=fA4889mPFRJZVNRy/89RnVQHzX4oR8YpXGRWFuchL+/8bnvZzX/nANGUU4EIf0hF8G2HvZSCa1VPuGDki7nBmumj2Me7f/WbvsW4K1Qa/J9aB8mWSB5U3G5pUZv849USOXA307+RrX/3Es9OxWVAN2IRbTUg4WgbQIn9U/IGMhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753539137; c=relaxed/simple;
	bh=ElMmRuS83DAUUR1L+Yv66gB7W/upU6aBIZclPNRqxrg=;
	h=Message-ID:Date:From:To:Cc:Subject; b=YLj6eOrIpU5P0NZYOXadfPkgJBxbbiYo8zY2w9t7LvCDh55CGWao2IAUWXKrHXtgu0GohqLCOS7fV+qzVNfqy7qWb2gCKLc2I3E/MZLfTjEbTrdGBByTjLEnd6ZaWAlokjUuVSrbPaHBDORebEcT5xSSW4kgfDAr55f4dluYRk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8H+eA3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5825EC4CEED;
	Sat, 26 Jul 2025 14:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753539136;
	bh=ElMmRuS83DAUUR1L+Yv66gB7W/upU6aBIZclPNRqxrg=;
	h=Date:From:To:Cc:Subject:From;
	b=D8H+eA3xu0jILLHikscRuLHVXIen6cYhmvwJZe5BZce4ExfhJ/KaaQqLtAJDdq0V8
	 AXVMXLEy6Do5U1+GD2lGm2PEl3z5mP4tDJTv5/uNpjS/YkoH/tucozKs/LVRtmyqBE
	 3hGT7lBbasnCUMiNPjQUk80NeOYqJOFd83koTYm49dSnQ8N+/BBXStV35FEOTIEMK7
	 LjgGfVmkyFvhZGQ1PyKZHW77ZsJdNeXDFWYTePMshOHGdM27rOxn+8ujVP+H+QywyG
	 h4z72vQbibYbux8eQmnWokp4NPR8vVJ5Gs2BxPPYoZ7DEKI9rNWnaJf/vH3wyOs4Ug
	 mmOPOW1kSnrjA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uffdP-00000001sb9-3pOe;
	Sat, 26 Jul 2025 10:12:23 -0400
Message-ID: <20250726140704.560579628@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 26 Jul 2025 10:07:04 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [for-next][PATCH 00/10] unwind_deferred: Core infrasrtucture for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


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

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
unwind/for-next

Head SHA1: 2879dee3655de961e4c0d715c36b9c550dd7c2de


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

