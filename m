Return-Path: <linux-kernel+bounces-752253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DF6B17305
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6263B1097
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D864478C91;
	Thu, 31 Jul 2025 14:17:06 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB49249625
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971426; cv=none; b=YnvvSlk2CB7mscUOqpMIMGgZYgJLiK9p8rOv3KTrfnKdkZtfp3PYg9gUqnkIN/VUFGOtK4BnRyAHa1Muc3p1jePNCQ0m082FnlhWMpzW5edxTAvNaJDR2hrK2EkW8QkNl+FLFTkjXUBsOcrkHXLXu82TPMI5vPojhBGokLuvkOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971426; c=relaxed/simple;
	bh=7BkcNXjsCpNhUCtuBr1cgN18duD55TYOAK1upCb82As=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Z5c22hCdF0REWVVfOsrmOc9GXzD1YNhxp2vceDFU5ZboLO+BA6/wqluhP2lVxWDOegdnnaKjb0gVJpob/1JgADGRr5bRiO0BeKWQw7kjKKgFyvjtqRHwYfKCRM6e4Kh4nGhYiO7nOdRSMYYrGtL8GG3ySF7F5jgAYGUHzpvLSLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 7B3FB1A03BD;
	Thu, 31 Jul 2025 14:17:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 5C02320026;
	Thu, 31 Jul 2025 14:16:59 +0000 (UTC)
Date: Thu, 31 Jul 2025 10:17:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mark Rutland
 <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Nam Cao
 <namcao@linutronix.de>, Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>, Yury Norov <yury.norov@gmail.com>
Subject: [GIT PULL] tracing: Updates for v6.17
Message-ID: <20250731101717.6c340b66@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5C02320026
X-Stat-Signature: cmm693n8eisswimnk1pe1tswei5ai5dx
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19778PrBjhgva3QrS8afpVtpOiYBUH0Hf4=
X-HE-Tag: 1753971419-554795
X-HE-Meta: U2FsdGVkX1970gOO5mXhQG4O7dDoNLK7x0HVDUWhLyT/JqraVfZwVyJuMx54r+fyDuEC0J+D4fpZOXV+kJDFNk0SJqRux6pEXQ8wLgoABaDCtQy8saT6TKUl+mTGUGFtgmcANDZTo6wm+p4WQwwC7nmFhDJiR+H4fhMwirDrthf48ra3BE4asqio6C1hT25TaKIEIBSDFPoil3/y96Fg6PnHqcQGQ3FSZ16P8p/rtLfiNI4srTTnW0GYyWtD7MO5qUjpar6cO93hFKwoDxpeLdEqtnTb+HXf0BXWIQKNsH8K6sS42u3Q/N2537ujHU2UGEeqhK8ukXNqKhps7ZIvkhJKhXipa8OY


Linus,

tracing changes for 6.17

- Deprecate auto-mounting tracefs to /sys/kernel/debug/tracing

  When tracefs was first introduced back in 2014, the directory
  /sys/kernel/tracing was added and is the designated location to mount
  tracefs. To keep backward compatibility, tracefs was auto-mounted in
  /sys/kernel/debug/tracing as well.

  All distros now mount tracefs on /sys/kernel/tracing. Having it seen in two
  different locations has lead to various issues and inconsistencies.

  The VFS folks have to also maintain debugfs_create_automount() for this
  single user.

  It's been over 10 years. Tooling and scripts should start replacing the
  debugfs location with the tracefs one. The reason tracefs was created in the
  first place was to allow access to the tracing facilities without the need
  to configure debugfs into the kernel. Using tracefs should now be more
  robust.

  A new config is created: CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED
  which is default y, so that the kernel is still built with the automount.
  This config allows those that want to remove the automount from debugfs to
  do so.

  When tracefs is accessed from /sys/kernel/debug/tracing, the following
  printk is triggerd:

   pr_warn("NOTICE: Automounting of tracing to debugfs is deprecated and will be removed in 2030\n");

  This gives users another 5 years to fix their scripts.

- Use queue_rcu_work() instead of call_rcu() for freeing event filters

  The number of filters to be free can be many depending on the number of
  events within an event system. Freeing them from softirq context can
  potentially cause undesired latency. Use the RCU workqueue to free them
  instead.

- Remove pointless memory barriers in latency code

  Memory barriers were added to some of the latency code a long time ago with
  the idea of "making them visible", but that's not what memory barriers are
  for. They are to synchronize access between different variables. There was
  no synchronization here making them pointless.

- Remove "__attribute__()" from the type field of event format

  When LLVM is used to compile the kernel with CONFIG_DEBUG_INFO_BTF=y and
  PAHOLE_HAS_BTF_TAG=y, some of the format fields get expanded with the
  following:

    field:const char * filename;      offset:24;      size:8; signed:0;

  Turns into:

    field:const char __attribute__((btf_type_tag("user"))) * filename;      offset:24;      size:8; signed:0;

  This confuses parsers. Add code to strip these tags from the strings.

- Add eprobe config option CONFIG_EPROBE_EVENTS

  Eprobes were added back in 5.15 but were only enabled when another probe was
  enabled (kprobe, fprobe, uprobe, etc). The eprobes had no config option
  of their own. Add one as they should be a separate entity.

  It's default y to keep with the old kernels but still has dependencies on
  TRACING and HAVE_REGS_AND_STACK_ACCESS_API.

- Add eprobe documentation

  When eprobes were added back in 5.15 no documentation was added to describe
  them. This needs to be rectified.

- Replace open coded cpumask_next_wrap() in move_to_next_cpu()

- Have preemptirq_delay_run() use off-stack CPU mask

- Remove obsolete comment about pelt_cfs event

  DECLARE_TRACE() appends "_tp" to trace events now, but the comment above
  pelt_cfs still mentioned appending it manually.

- Remove EVENT_FILE_FL_SOFT_MODE flag

  The SOFT_MODE flag was required when the soft enabling and disabling of
  trace events was first introduced. But there was a bug with this approach
  as it only worked for a single instance. When multiple users required soft
  disabling and disabling the code was changed to have a ref count. The
  SOFT_MODE flag is now set iff the ref count is non zero. This is redundant
  and just reading the ref count is good enough.

- Fix typo in comment


Please pull the latest trace-v6.17 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.17

Tag SHA1: 24e6f06fdcad116feaabae15bcff715b2ba16386
Head SHA1: 623526ba8984cafdffa0eba7ee424f2e40c8a219


Arnd Bergmann (1):
      kernel: trace: preemptirq_delay_test: use offstack cpu mask

Masami Hiramatsu (Google) (1):
      tracing: Remove "__attribute__()" from the type field of event format

Nam Cao (1):
      tracing: Remove pointless memory barriers

Ricardo Neri (1):
      tracing/sched: Remove obsolete comment on suffixes

Steven Rostedt (6):
      tracing: Use queue_rcu_work() to free filters
      tracing: Remove EVENT_FILE_FL_SOFT_MODE flag
      tracing: Fix comment in trace_module_remove_events()
      tracing: Deprecate auto-mounting tracefs in debugfs
      tracing: Have eprobes have their own config option
      Documentation: tracing: Add documentation about eprobes

Yury Norov (1):
      tracing: Replace opencoded cpumask_next_wrap() in move_to_next_cpu()

----
 .../ABI/obsolete/automount-tracefs-debugfs         |  20 ++
 Documentation/trace/eprobetrace.rst                | 269 +++++++++++++++++++++
 Documentation/trace/index.rst                      |   1 +
 include/linux/trace_events.h                       |   3 -
 include/trace/events/sched.h                       |   2 -
 kernel/trace/Kconfig                               |  27 +++
 kernel/trace/Makefile                              |   2 +-
 kernel/trace/preemptirq_delay_test.c               |  13 +-
 kernel/trace/rv/rv.c                               |   6 -
 kernel/trace/trace.c                               |  49 ++--
 kernel/trace/trace.h                               |   4 +-
 kernel/trace/trace_events.c                        | 154 +++++++++---
 kernel/trace/trace_events_filter.c                 |  28 ++-
 kernel/trace/trace_hwlat.c                         |   5 +-
 14 files changed, 498 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/automount-tracefs-debugfs
 create mode 100644 Documentation/trace/eprobetrace.rst
---------------------------

