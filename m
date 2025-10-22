Return-Path: <linux-kernel+bounces-864965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F12A3BFBFC1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD981A06DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE62834846D;
	Wed, 22 Oct 2025 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DHCBGOG3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ug6Jonux"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945EA348450
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137526; cv=none; b=PZW+BYGNSg6JwJEb9M8vEE8y6TdbeTfaUI1v9ROpBq8hlVlZX/Z68KgwG4jDBaBvXJ5t9o9p06HPyLZMXjnvvED3WW1+ZDAo36DagLowFrnVR3ANh9xLQ2EM/bGXTifd/HKPTSFu/NvREPyJSAZm1sVCDjv6MZgyEGtEaEKs0P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137526; c=relaxed/simple;
	bh=x0yQP/DDMGlpdA5MPdyJrpRdTXFVdLtp8+GY0cU+ufk=;
	h=Message-ID:From:To:Cc:Subject:Date; b=HAMrHSwdmGSPu1YNour6pdSiXEWjaL4MFcIqpy40qhb/9ti7HjkRVdP0uzR0LNvmb9Xx0pe9JEr8/nlPr/ZMfrrfoJeEm6/oGoAxp93p/zCLJQV4tKfSNLZDUVSAAM9HFiDRiHksKU3Xl1AyOgcowgpyuU7/b0Gepjj81ly4tE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DHCBGOG3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ug6Jonux; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121836.019469732@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=LJrVhjnK3JNkK01lPe27E1NT9Rrq80CDjTjOuJXeGOY=;
	b=DHCBGOG3PEhWw0C8dZ4vNQP9GGWBbcgxVZ3yev8fMzl6AIsxzxhxw5bqNiuL8jMgaXYd4J
	8BLeEYbbVPNe26+FzaVEiggS/A3pYzHuswMdC67BjZnJMiY7IyXtJrYgW9NaShEC0qNobF
	Uu039tIF/+0oBEf48cmLoU41Li3PoPPSmfGjnaFTsh5BUWEMEgbmqXbrjTcRdZWO+hcyJD
	8P/zsx17t+eND82V4Jk4QEF7DHqy0s6J8v/yLHY5Z2CdeV/dJhLvo7Jxe+xlxNarzZ2KWy
	op0jsxfCA4gghvSclYks+3vGKVhBAYuiRLsq9UblvUvsuxrNWEja6lKMMLiCcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=LJrVhjnK3JNkK01lPe27E1NT9Rrq80CDjTjOuJXeGOY=;
	b=ug6JonuxXTZIZsxJ2ic/AhVQLgShdH6gMgA6TPiXhai8RfgTWZN1ku0OgYAqzF2O3CCliI
	JQhJrL+o8Qmg4qDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 x86@kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V5 00/31] rseq: Optimize exit to user space
Date: Wed, 22 Oct 2025 14:52:00 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a follow up on the V4 series, which can be found here:

   https://lore.kernel.org/all/20250908212737.353775467@linutronix.de

The V2 posting contains a detailed list of the addressed problems:

   https://lore.kernel.org/20250916163004.674341701@linutronix.de

TLDR:
    - A significant amount of pointless RSEQ operations on exit to user
      space, which have been reported by people as measurable impact after
      glibc switched to use RSEQ

    - Suboptimal hotpath handling both in the scheduler and on exit to user
      space.

This series addresses these issues by:

  1) Limiting the RSEQ work to the actual conditions where it is
     required. The full benefit is only available for architectures using
     the generic entry infrastructure. All others get at least the basic
     improvements.

  2) Re-implementing the whole user space handling based on proper data
     structures and by actually looking at the impact it creates in the
     fast path.

  3) Moving the actual handling of RSEQ out to the latest point in the exit
     path, where possible. This is fully inlined into the fast path to keep
     the impact confined.

Changes vs. V4:

  - Add a comment to the KVM retrigger logic - Sean

  - Reduce the fast path decision to event::sched_switch - Mathieu

  - Initialize IDs on registration, keep them on fork and lift the first
    exit restriction in the debug code - Mathieu

  - Update comments and fix typos - Mathieu

  - Adapted it to the uaccess changes

  - Dropped the already upstream parts and prerequisites

As for the previous version these patches have a dependency on the uaccess
scope series:

   https://lore.kernel.org/20251022102427.400699796@linutronix.de

which is available at:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git uaccess/scoped

For your convenience the combination of both is available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/perf

Thanks,

	tglx
---
Thomas Gleixner (31):
      rseq: Avoid pointless evaluation in __rseq_notify_resume()
      rseq: Condense the inline stubs
      rseq: Move algorithm comment to top
      rseq: Remove the ksig argument from rseq_handle_notify_resume()
      rseq: Simplify registration
      rseq: Simplify the event notification
      rseq, virt: Retrigger RSEQ after vcpu_run()
      rseq: Avoid CPU/MM CID updates when no event pending
      rseq: Introduce struct rseq_data
      entry: Cleanup header
      entry: Remove syscall_enter_from_user_mode_prepare()
      entry: Inline irqentry_enter/exit_from/to_user_mode()
      sched: Move MM CID related functions to sched.h
      rseq: Cache CPU ID and MM CID values
      rseq: Record interrupt from user space
      rseq: Provide tracepoint wrappers for inline code
      rseq: Expose lightweight statistics in debugfs
      rseq: Provide static branch for runtime debugging
      rseq: Provide and use rseq_update_user_cs()
      rseq: Replace the original debug implementation
      rseq: Make exit debugging static branch based
      rseq: Use static branch for syscall exit debug when GENERIC_IRQ_ENTRY=y
      rseq: Provide and use rseq_set_ids()
      rseq: Separate the signal delivery path
      rseq: Rework the TIF_NOTIFY handler
      rseq: Optimize event setting
      rseq: Implement fast path for exit to user
      rseq: Switch to fast path processing on exit to user
      entry: Split up exit_to_user_mode_prepare()
      rseq: Split up rseq_exit_to_user_mode()
      rseq: Switch to TIF_RSEQ if supported

 Documentation/admin-guide/kernel-parameters.txt |    4 
 arch/x86/entry/syscall_32.c                     |    3 
 drivers/hv/mshv_root_main.c                     |    3 
 fs/binfmt_elf.c                                 |    2 
 fs/exec.c                                       |    2 
 include/asm-generic/thread_info_tif.h           |    3 
 include/linux/entry-common.h                    |   38 -
 include/linux/irq-entry-common.h                |   68 ++
 include/linux/mm.h                              |   25 
 include/linux/resume_user_mode.h                |    2 
 include/linux/rseq.h                            |  228 +++++---
 include/linux/rseq_entry.h                      |  592 +++++++++++++++++++++
 include/linux/rseq_types.h                      |   93 +++
 include/linux/sched.h                           |   48 +
 include/linux/thread_info.h                     |    5 
 include/trace/events/rseq.h                     |    4 
 include/uapi/linux/rseq.h                       |   21 
 init/Kconfig                                    |   28 -
 kernel/entry/common.c                           |   39 -
 kernel/entry/syscall-common.c                   |    8 
 kernel/ptrace.c                                 |    6 
 kernel/rseq.c                                   |  654 ++++++++++--------------
 kernel/sched/core.c                             |   10 
 kernel/sched/membarrier.c                       |    8 
 kernel/sched/sched.h                            |    5 
 virt/kvm/kvm_main.c                             |    7 
 26 files changed, 1301 insertions(+), 605 deletions(-)




