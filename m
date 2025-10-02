Return-Path: <linux-kernel+bounces-840874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239E7BB5A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 01:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67010486592
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 23:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10AE2C08D5;
	Thu,  2 Oct 2025 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXbWajv5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196E22C031E
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759448671; cv=none; b=pZ5Sz8xFFboooxCCEf8ek8g9Q0EbT5wVGx69MlQbypFWL/wfggjRxPItye80Gl/O+BqUKIabV0lOyzvIAhl3MJ5CYAjFdPTorPVOV6TyuNX1i9ewQ9ZTn0l1yDVAyTWw5TR9GWnwZE0pQb4F/N4DF45s4JPaYSj5Sx3z/zK0Hkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759448671; c=relaxed/simple;
	bh=R6uVG9Okh0A6W3VKSBMqAtqMu3KvZurm5tI7M91CTTs=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=USyQjkvXvvcy2AdvYOBV8sVBtXY5KdNUCAfj2oH09LS9ClAtVfcDM9XbGac6ujwkDJf0Q2emc5gsek8pHhvGywwIlwy5BBFLPdk5qjmLruMohKLAFtq0Au9EXPOYG2Y/R30ima6bCKW3+KLSXug03RZw+amu7vR2JXwz4+LOh4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXbWajv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15597C4CEF4;
	Thu,  2 Oct 2025 23:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759448671;
	bh=R6uVG9Okh0A6W3VKSBMqAtqMu3KvZurm5tI7M91CTTs=;
	h=Date:From:To:Cc:Subject:From;
	b=UXbWajv5zXlEQEukobofrdmlbADybPtlY1fskdI2XZoPcxkpLYXtTPm63Lw9bW6OS
	 AF6YA0+uuQwBIiWDOIQr9RVinri/XySaZQ1rhhImgndgYr+oAIJa+bu2c0jfiIrw6u
	 SqIM9N4iBtOVDGJBBIkcaP8jn6EO6QBPYvINAhQl1f5zCw4OIRwBBbQfcrOc7XFI8J
	 1wljxUYMfmJDwT+PsCGM6TN9VTI/tDiFg0LKfhGBzJFNyueEAGuVassg6wUtAAkAUC
	 FahISA/8Pji2Wofg8cjitwX1B6bB1NbqS83FMbBBva8NL2i7qVC7/NYp8indHjrzBS
	 73BP4N/vXUttw==
Date: Fri, 3 Oct 2025 08:44:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Thorsten Blum <thorsten.blum@linux.dev>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Update for v6.18
Message-Id: <20251003084426.f2de6028fd74e1af4e13d190@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Probes for v6.18:

- fprobe: Performance enhancement of the fprobe using rhltable
  . fprobe: use rhltable for fprobe_ip_table. The fprobe IP table has
    been converted to use an rhltable for improved performance when
    dealing with a large number of probed functions.
  . Fix a suspicious RCU usage warning of the above change in the
    fprobe entry handler.
  . Remove an unused local variable of the above change.
  . Fix to initialize fprobe_ip_table in core_initcall().

- wprobe: Introduce a watchpoint probe event based on hw_breakpoint.
  . Add a new watchpoint probe that uses hardware breakpoints to
    monitor memory accesses. This allows for tracing memory reads
    and writes at specified addresses.
  . Add a basic add/remove test case for wprobe.
  . Add a syntax test case for wprobe.

- probes: Cleanup probe event subsystems.
  . uprobe/eprobe: Allocate traceprobe_parse_context per probe instead
    of each probe argument parsing. This reduce memory allocation/free
    of temporary working memory.
  . uprobes: Cleanup code using __free().
  . eprobes: Cleanup code using __free().
  . probes: Cleanup code using __free(trace_probe_log_clear) to clear
    error log automatically.
  . probes: Replace strcpy() with memcpy() in __trace_probe_log_err().


Please pull the latest probes-v6.18-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-v6.18-2

Tag SHA1: c9699ea9d31215b01384fc3ce3a8c7cb3c8671f9
Head SHA1: 764d1ce2ccf0377dd81a0f199f267703918588da


Masami Hiramatsu (Google) (9):
      tracing: probes: Use __free() for trace_probe_log
      tracing: eprobe: Cleanup eprobe event using __free()
      tracing: uprobes: Cleanup __trace_uprobe_create() with __free()
      tracing: uprobe: eprobes: Allocate traceprobe_parse_context per probe
      tracing: fprobe: Remove unused local variable
      tracing: wprobe: Add watchpoint probe event based on hardware breakpoint
      selftests: tracing: Add a basic testcase for wprobe
      selftests: tracing: Add syntax testcase for wprobe
      tracing: fprobe: Fix to init fprobe_ip_table earlier

Menglong Dong (2):
      tracing: fprobe: use rhltable for fprobe_ip_table
      tracing: fprobe: fix suspicious rcu usage in fprobe_entry

Thorsten Blum (1):
      tracing: probes: Replace strcpy() with memcpy() in __trace_probe_log_err()

----
 Documentation/trace/index.rst                      |   1 +
 Documentation/trace/wprobetrace.rst                |  69 +++
 include/linux/fprobe.h                             |   3 +-
 include/linux/trace_events.h                       |   2 +
 kernel/trace/Kconfig                               |  13 +
 kernel/trace/Makefile                              |   1 +
 kernel/trace/fprobe.c                              | 159 +++--
 kernel/trace/trace.c                               |   9 +-
 kernel/trace/trace.h                               |   5 +
 kernel/trace/trace_eprobe.c                        | 108 ++--
 kernel/trace/trace_probe.c                         |  27 +-
 kernel/trace/trace_probe.h                         |  12 +-
 kernel/trace/trace_uprobe.c                        |  82 +--
 kernel/trace/trace_wprobe.c                        | 685 +++++++++++++++++++++
 tools/testing/selftests/ftrace/config              |   1 +
 .../ftrace/test.d/dynevent/add_remove_wprobe.tc    |  68 ++
 .../test.d/dynevent/wprobes_syntax_errors.tc       |  20 +
 17 files changed, 1076 insertions(+), 189 deletions(-)
 create mode 100644 Documentation/trace/wprobetrace.rst
 create mode 100644 kernel/trace/trace_wprobe.c
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/wprobes_syntax_errors.tc
---------------------------

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

