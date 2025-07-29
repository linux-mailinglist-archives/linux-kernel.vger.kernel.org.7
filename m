Return-Path: <linux-kernel+bounces-749804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53908B15314
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FACC3BBDF7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC7239E81;
	Tue, 29 Jul 2025 18:42:34 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F90218E99
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814553; cv=none; b=r1u6h9yYF4puebyu7a9V1f30LfkeSeJ6+gfvFGeuLPGgIK5cyRPOUy/MGHUn4H9/t1hpMg6bum/co1DnsJunJdbl5NeYRfe9Tr+/J9+kVFBDJFHU04GvlT5y4i9ADTo2C4LaRBl1pxSC1Q/NXT6WNScfIzLnxRpOxF/tbA15n00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814553; c=relaxed/simple;
	bh=u6YG3dQymVeOHnrNuFd1AeadKpjr/msDJ338fsWA69g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VG2zMN/izWjd6fliAkQtijT/Daz5fnUaICJS8Ze2Bn6tJJbblwosHsEnSPPTxbXxQbzPJqbse5eP9xauo3Z6lj4CQ68B4Jlxw2q+pncM21ZUH/8B2ssjmJtecowhBhExtTMzJBBFLWpRPzg/LoeeCrSPUc9gYOI/ce3xGJCRHL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id BF7E01A01EE;
	Tue, 29 Jul 2025 18:42:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id E938B80009;
	Tue, 29 Jul 2025 18:42:27 +0000 (UTC)
Date: Tue, 29 Jul 2025 14:42:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Artem Sadovnikov
 <a.sadovnikov@ispras.ru>
Subject: [GIT PULL] ftrace: Changes for v6.17
Message-ID: <20250729144226.6b72dca7@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E938B80009
X-Stat-Signature: 3z7tytndufa4rp37qbt3p5piofx1s6dg
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+f4V9wZaOoC8iCWSz/I0ecu9RWNXlPS88=
X-HE-Tag: 1753814547-968171
X-HE-Meta: U2FsdGVkX1+McWbhDorYepp1+Z0chyumnDVNWzxrAjHc0WIu4fP38fimpPxoGYweo0pDYsEtCUNd0LrGMVq8/I89mY3U81Amyly4gHnfmya5ZYotEDFijRMds02b7JAS9LZT3X+pF60rle8Ob5cbNrMARNxA1EHHSr+ktm/B+g/nSh4PzEOW1b6NzZpxs5xpkb6WbY2c0T4Dxmxa8jbIUtUaibpAhuAnZkXeT1LaI5ol/rxbLtsclKi241G9u51Jq3rro+EHGOA0m5zv1JD41wTe+WF1feLRsBQbEYX1zUEUg53jFamgvEeBfHEpFYN5yHGcUQVX4BZF86G/NigymBSOEGzwm0OJ


Linus,

ftrace changes for v6.17:

- Keep track of when fgraph_ops are registered or not

  Keep accounting of when fgraph_ops are registered as if a fgraph_ops is
  registered twice it can mess up the accounting and it will not work as
  expected later. Trigger a warning if something registers it twice as to
  catch bugs before they are found by things just not working as expected.

- Make DYNAMIC_FTRACE always enabled for architectures that support it

  As static ftrace (where all functions are always traced) is very expensive
  and only exists to help architectures support ftrace, do not make it an
  option. As soon as an architecture supports DYNAMIC_FTRACE make it use it.
  This simplifies the code.

- Remove redundant config HAVE_FTRACE_MCOUNT_RECORD

  The CONFIG_HAVE_FTRACE_MCOUNT was added to help simplify the
  DYNAMIC_FTRACE work, but now every architecture that implements
  DYNAMIC_FTRACE also has HAVE_FTRACE_MCOUNT set too, making it redundant
  with the HAVE_DYNAMIC_FTRACE.

- Make pid_ptr string size match the comment

  In print_graph_proc() the pid_ptr string is of size 11, but the comment says
  /* sign + log10(MAX_INT) + '\0' */ which is actually 12.


Please pull the latest ftrace-v6.17 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ftrace-v6.17

Tag SHA1: 58cc39c90ea0e6a1213b565a4859ed6f2a9a0b1a
Head SHA1: 4d6d0a6263babf7c43faa55de4fa3c6637dec624


Artem Sadovnikov (1):
      fgraph: Make pid_str size match the comment

Steven Rostedt (3):
      fgraph: Keep track of when fgraph_ops are registered or not
      ftrace: Make DYNAMIC_FTRACE always enabled for architectures that support it
      tracing: Remove redundant config HAVE_FTRACE_MCOUNT_RECORD

----
 Documentation/trace/ftrace-design.rst | 12 ++++--------
 arch/arm/Kconfig                      |  1 -
 arch/arm64/Kconfig                    |  1 -
 arch/csky/Kconfig                     |  1 -
 arch/loongarch/Kconfig                |  1 -
 arch/microblaze/Kconfig               |  1 -
 arch/mips/Kconfig                     |  1 -
 arch/parisc/Kconfig                   |  1 -
 arch/powerpc/Kconfig                  |  1 -
 arch/riscv/Kconfig                    |  1 -
 arch/s390/Kconfig                     |  1 -
 arch/sh/Kconfig                       |  1 -
 arch/sparc/Kconfig                    |  1 -
 arch/x86/Kconfig                      |  1 -
 include/asm-generic/vmlinux.lds.h     |  2 +-
 include/linux/ftrace.h                |  2 +-
 include/linux/kernel.h                |  6 +++---
 include/linux/module.h                |  2 +-
 kernel/module/main.c                  |  2 +-
 kernel/trace/Kconfig                  | 20 +++++---------------
 kernel/trace/fgraph.c                 | 16 +++++++++++++---
 kernel/trace/ftrace.c                 |  4 ----
 kernel/trace/trace_functions_graph.c  |  2 +-
 scripts/recordmcount.pl               |  2 +-
 24 files changed, 31 insertions(+), 52 deletions(-)
---------------------------

