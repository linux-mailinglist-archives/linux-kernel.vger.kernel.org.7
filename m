Return-Path: <linux-kernel+bounces-871087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D734FC0C6A9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82CD434B5D0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E072F5A39;
	Mon, 27 Oct 2025 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KqDeAcIA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hLrblx9D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DC62F60A1
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554657; cv=none; b=anrhrK395xQc47za/c1sn0UDqcixExklmZSETTCmRY7CIK24QICea8IGio7pp4uDnqBU2rGBxT+M0e9qVfoucfyDvQbcVbKCTZ+V17nXjWMqmUK5FNe/mRdnCIVwVzh5OSQ6PpfV4gl2+DxGGhFGFqZW0/QXTrbjWPcCxD3chr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554657; c=relaxed/simple;
	bh=uYGTEblQsxxRJ1xLPVpApKO/MHMjAjHzH9fWBK6+XZ0=;
	h=Message-ID:From:To:Cc:Subject:Date; b=stAElbYBZymhMNkiHTMMaIeODp7jrjxfgNoSpphvpYTcScPvA7Eo0YPoLIMCfmfM5kqRhSKjM7PZlYkioJ3jRlvk4M1kJz9nsdv008p7H8Lhvo7aKjeNxn6hhzaI1VFmJ7Hd7T34slWdETNe/V7Aw9hjc32AV0uaGadUhFGiZwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KqDeAcIA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hLrblx9D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084220.785525188@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=N0FFUvk9AfhECllaQ9no9Kxbik2kTIg91OxGdFyC8gs=;
	b=KqDeAcIAkRgz3lGviKjiw37KzNHUTC3sMTxjStRTem7Jg/aggVBnmC56tLXUMyvVXqdt+t
	qtli9Rei0J8en9tq06FUm4OQDY6/j6nClfo9bM/FUO/QyNwsAk62DlzdFDSd0JOKiSkbwA
	YSZ8g2zrbEwigpUk0Q5GtmyFRGC/Z/Ms3QhcfatT50Q8ptqEOiaakMe8xfXDOiHt9m6VNY
	VS2yuJUQF/EZybBTy/lf9i2cGaRvmQtFwR1w0LNI9kxLIShJJ33ZKWg3GKYR+LP86JCssn
	PU7Wm5z7OKd3v710IgqgV7EtviqLNqZsrPEKYlX5ZKmdFVi9d6/drNE9xO2xFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=N0FFUvk9AfhECllaQ9no9Kxbik2kTIg91OxGdFyC8gs=;
	b=hLrblx9DkHhj2o9HHB3ky6Zl2+uTU8M5MByRWromIj+OED/ShzUkkrmYGAxIo4ZFIejeMp
	//1cLvSBsjVE8xBA==
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
Subject: [patch V6 00/31] rseq: Optimize exit to user space
Date: Mon, 27 Oct 2025 09:44:14 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a trivial follow up on the V5 series, which can be found here:

   https://lore.kernel.org/all/20251022121836.019469732@linutronix.de

Changes vs. V5:

  - Adjust to the uaccess changes

As for the previous version these patches have a dependency on the uaccess
scope series:

   https://lore.kernel.org/20251027083700.573016505@linutronix.de

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


