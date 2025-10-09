Return-Path: <linux-kernel+bounces-847048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B287EBC9BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C3242042E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471291E3DE8;
	Thu,  9 Oct 2025 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6l+juS+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A271DE8AE
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023460; cv=none; b=RqnN5eEJcLAbsQ54eI4AwK8uyJwT6l83k/tvFIKiCgp/V7HYLv48tEB6MQEuFhqjzy+Kz6+NCA1g2lkVKqu4XwfUW2SOk2sJGHX/TeRQyNos2fuaG7tq8L0dfvKylMtq2meIbrGK+nXM9H6LCxD/hek8vdOtF6vR3UWhxN96/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023460; c=relaxed/simple;
	bh=vuHe3/aJFDwUPDtXRtoy+y3ro41VKulaaZzxgwyyzGg=;
	h=Message-ID:Date:From:To:Cc:Subject; b=YnzrkeIkSVsiakqrNlhSGE/4bH2iESEuOARXmqASlLt0Rl2pyb2qpIq0l12RfA9KzvSiMso1V/IzzYiuKYYIpqDgqrA1EZ48e2ZL8VD9PGoNuPsMtABkgqvuRp9b9RmCztRW53b2lvbNmosgDsdoye9IqUzGT2xvmfOopEriuew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6l+juS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F13FC4CEF8;
	Thu,  9 Oct 2025 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760023460;
	bh=vuHe3/aJFDwUPDtXRtoy+y3ro41VKulaaZzxgwyyzGg=;
	h=Date:From:To:Cc:Subject:From;
	b=g6l+juS+W2x0TzwVamlgWX59R6qfLjmrAjX1IkIg5iJAodJO/B+jWWDGcR4aVYn6N
	 9c3AuxOO94P0xyroE4j9R9AANe1gE2+20j3WISW7FMTVGpcGVGUVgZ866LbRi4Mu1I
	 206CKmDAaSHn6+doA7/gQAK/4E5Rt0U30sq7047v2kbBJF/EB56yZjGxGaq53ZMCoM
	 gVkok0CHdSrvdV+2eKTrOckEp1gVgKjKbF4OjzXb8Ba5JRC4WiU5+YvYSrcSqym/6I
	 Ps7Eykuiqfheg+txC8ivOD1U02MS8GvIVbfzQsRwNMJeJtQaJhat1wQVjzljN2JvHC
	 XLjbFxp/n2KMg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v6sVA-00000000Bc0-2KU0;
	Thu, 09 Oct 2025 11:24:20 -0400
Message-ID: <20251009152359.604267051@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 09 Oct 2025 11:23:59 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/5] tracing: Clean up and fixes or v6.18
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


tracing clean up and fixes for v6.18:

- Have osnoise tracer use memdup_user_nul()

  The function osnoise_cpus_write() open codes a kmalloc() and then
  a copy_from_user() and then adds a nul byte at the end which is the
  same as simply using memdup_user_nul().

- Fix wakeup and irq tracers when failing to acquire calltime

  When the wakeup and irq tracers use the function graph tracer for
  tracing function times, it saves a timestamp into the fgraph shadow
  stack. It is possible that this could fail to be stored. If that
  happens, it exits the routine early. These functions also disable
  nesting of the operations by incremeting the data "disable" counter.
  But if the calltime exits out early, it never increments the counter
  back to what it needs to be.

  Since there's only a couple of lines of code that does work after
  acquiring the calltime, instead of exiting out early, reverse the
  if statement to be true if calltime is acquired, and place the code
  that is to be done within that if block. The clean up will always
  be done after that.

- Fix ring_buffer_map() return value on failure of __rb_map_vma()

  If __rb_map_vma() fails in ring_buffer_map(), it does not return
  an error. This means the caller will be working against a bad vma
  mapping. Have ring_buffer_map() return an error when __rb_map_vma()
  fails.

- Fix regression of writing to the trace_marker file

  A bug fix was made to change __copy_from_user_inatomic() to
  copy_from_user_nofault() in the trace_marker write function.
  The trace_marker file is used by applications to write into
  it (usually with a file descriptor opened at the start of the
  program) to record into the tracing system. It's usually used
  in critical sections so the write to trace_marker is highly
  optimized.

  The reason for copying in an atomic section is that the write
  reserves space on the ring buffer and then writes directly into
  it. After it writes, it commits the event. The time between
  reserve and commit must have preemption disabled.

  The trace marker write does not have any locking nor can it
  allocate due to the nature of it being a critical path.

  Unfortunately, converting __copy_from_user_inatomic() to
  copy_from_user_nofault() caused a regression in Android.
  Now all the writes from its applications trigger the fault that
  is rejected by the _nofault() version that wasn't rejected by
  the _inatomic() version. Instead of getting data, it now just
  gets a trace buffer filled with:

    tracing_mark_write: <faulted>

  To fix this, on opening of the trace_marker file, allocate
  per CPU buffers that can be used by the write call. Then
  when entering the write call, do the following:

    preempt_disable();
    cpu = smp_processor_id();
    do {
	cnt = nr_context_switches_cpu(cpu);
	migrate_disable();
	preempt_enable();
	ret = copy_from_user(buffer, ptr, size);
	preempt_disable();
	migrate_enable();
    } while (!ret && cnt != nr_context_switches_cpu(cpu));
    if (!ret)
	ring_buffer_write(buffer);
    preempt_enable();

  This works similarly to seqcount. As it must enabled preemption
  to do a copy_from_user() into a per CPU buffer, if it gets
  preempted, the buffer could be corrupted by another task.
  To handle this, read the number of context switches of the current
  CPU, disable migration, enable preemption, copy the data from
  user space, then immediately disable preemption again.
  If the number of context switches is the same, the buffer
  is still valid. Otherwise it must be assumed that the buffer may
  have been corrupted and it needs to try again.

  Now the trace_marker write can get the user data even if it has
  to fault it in, and still not grab any locks of its own.

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/fixes

Head SHA1: 64cf7d058a005c5c31eb8a0b741f35dc12915d18


Ankit Khushwaha (1):
      ring buffer: Propagate __rb_map_vma return value to caller

Steven Rostedt (3):
      tracing: Fix wakeup tracers on failure of acquiring calltime
      tracing: Fix irqoff tracers on failure of acquiring calltime
      tracing: Have trace_marker use per-cpu data to read user space

Thorsten Blum (1):
      tracing/osnoise: Replace kmalloc + copy_from_user with memdup_user_nul

----
 kernel/trace/ring_buffer.c        |   2 +-
 kernel/trace/trace.c              | 268 +++++++++++++++++++++++++++++++-------
 kernel/trace/trace_irqsoff.c      |  23 ++--
 kernel/trace/trace_osnoise.c      |  11 +-
 kernel/trace/trace_sched_wakeup.c |  16 +--
 5 files changed, 241 insertions(+), 79 deletions(-)

