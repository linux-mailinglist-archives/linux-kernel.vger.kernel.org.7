Return-Path: <linux-kernel+bounces-750019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F74DB155FB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CC8188B869
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275BE281358;
	Tue, 29 Jul 2025 23:29:13 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B237246BD7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831752; cv=none; b=KEpPYiC0agZyJ2fI4cDbKWZs0IEXagbtV69BsiMSTxhUNznOuHDgxSDy1pBxFL+KxPHPplbpWxM7oIddZE6lb0vHcayfmBQyMBPXkL5k98jICYKSulmla4eqDewwEMfNaBnar2bWSadIC3aMS/FTyyBbLheq7usilMISqRYHquk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831752; c=relaxed/simple;
	bh=7+57hzZY2qD/qkumBUkirJlpj83Sx9X+jWtVez/+Rac=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=m3BKXK3nFdriXwcriJwXZ96/p/9zkQITETqmw/lkiU8xSygonc1KX/3k5AyFZztvCxedprfJGY2KqGuMgAuV2cvzeGXP5ZHISsTcJbu9my2m0I1xBIVohY3MAn+98Rzmj/y2f8sOBTvnsBwayyDLXE6JKC32eU9sL0FNiIowkjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 282131A027F;
	Tue, 29 Jul 2025 23:29:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 6430F1A;
	Tue, 29 Jul 2025 23:29:07 +0000 (UTC)
Date: Tue, 29 Jul 2025 19:29:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: [GIT PULL] tracing: Remove or hide some unused tracepoints for 6.17
Message-ID: <20250729192922.37db57dc@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 6430F1A
X-Stat-Signature: a857hbxrrkrs1h4dnm5yrz3bg3ngwfzw
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/f56BxiH4+1VtluhC4bQo9j3q/qfdO/C0=
X-HE-Tag: 1753831747-543705
X-HE-Meta: U2FsdGVkX1+10eS9DxeXZR0PNqMzThSxdftYGadf1gz7xFTEA95rV32S8N8rZcas8VHmMFyOFq+wJntGYKddrvVjr+kxavmPBTeuRFq2GxUM8mHKQWNuoYcpNIFRdu9gkdOmF2eULFQaijZ1NCO45AzrSGvOLiuC+l5dmB8iJEqq3ac6jQzhD3vduSV2W3gpEDNfuVKMG1DYaxDTNaa1c50Wfy9uaIRqfRF8FMm0EFcXb87CMBqrPE3PlLVJiKKbXG5L6JtfBP+E0S0XVBqeSAxX1gF0WFMr9TBbdlASBmb9P2bF+rxerEsxcwZeDZbR5/XgqglR3AmEWDFpL+pEYDokrasu0FA5



Linus,

Remove or hide unused tracepoints

Tracepoints take up memory (around 5K per tracepoint) even when they are
unused. Changes are being made to detect when a tracepoint is defined but
unused and a warning is shown at build. But those changes are not yet
ready for inclusion.

- Fix some of the unused tracepoints that it detected

  Some tracepoints were removed and others were hidden by config settings
  to match the config settings of where they are instantiated. Some
  tracepoints were moved into architecture specific code as only one
  architecture used them.

- Call the ftrace_test_filter tracepoint in an unreachable if statement

  The ftrace_test_filter tracepoint which is defined when ftrace selftests
  are configured and is used to test the filter logic, but the tracepoint is
  not actually called. It is put into an if statement to not have it get
  compiled out, but also not warn for not being used.


Please pull the latest trace-unused-v6.17 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-unused-v6.17

Tag SHA1: 71bbc6de907c84ee983687aea4522604a42c820e
Head SHA1: c2dbaf0af05193fa69f267c37d1f825c1c3a59ab


Steven Rostedt (11):
      tracing, AER: Hide PCIe AER event when PCIEAER is not configured
      alarmtimer: Hide alarmtimer_suspend event when RTC_CLASS is not configured
      PM: cpufreq: powernv/tracing: Move powernv_throttle trace event
      PM: tracing: Hide psci_domain_idle events under ARM_PSCI_CPUIDLE
      PM: tracing: Hide device_pm_callback events under PM_SLEEP
      PM: tracing: Hide power_domain_target event under ARCH_OMAP2PLUS
      binder: Remove unused binder lock events
      tracing: arm: arm64: Hide trace events ipi_raise, ipi_entry and ipi_exit
      tracing: Call trace_ftrace_test_filter() for the event
      powerpc/thp: tracing: Hide hugepage events under CONFIG_PPC_BOOK3S_64
      tracing: sched: Hide numa events under CONFIG_NUMA_BALANCING

----
 arch/arm/Kconfig                   |  1 +
 arch/arm64/Kconfig                 |  1 +
 drivers/android/binder_trace.h     | 21 --------------
 drivers/cpufreq/Makefile           |  1 +
 drivers/cpufreq/powernv-cpufreq.c  |  4 ++-
 drivers/cpufreq/powernv-trace.h    | 44 +++++++++++++++++++++++++++++
 include/ras/ras_event.h            |  2 ++
 include/trace/events/alarmtimer.h  |  2 ++
 include/trace/events/ipi.h         | 58 ++++++++++++++++++++------------------
 include/trace/events/power.h       | 28 ++++--------------
 include/trace/events/sched.h       |  2 +-
 include/trace/events/thp.h         |  2 ++
 kernel/trace/Kconfig               |  6 ++++
 kernel/trace/power-traces.c        |  1 -
 kernel/trace/trace_events_filter.c |  4 +++
 15 files changed, 103 insertions(+), 74 deletions(-)
 create mode 100644 drivers/cpufreq/powernv-trace.h
---------------------------

