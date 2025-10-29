Return-Path: <linux-kernel+bounces-876406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F871C1BC0F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FC6566703
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A5533507B;
	Wed, 29 Oct 2025 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVWOzcBc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCFC2C11F4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748843; cv=none; b=hTXK8p0Pm54UrqujjUc30dGdrp1VgaPSbvEJYGja9QZjjI+7TWSvicTrQfq+P3RNSbUXTSv83YiohKCXk2hE+XojpnNtNNEE4QxZg/6TQwzDFhptKWBV1tefCDNnZR9bq05Nz/H0U2hKIQrQevPZ6qzhNHjdVDMwaEgiB3Hikuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748843; c=relaxed/simple;
	bh=H5CXfnrpZRHN+f4MhQXGUsbef12MtcsG4IIn6H7dHm4=;
	h=Message-ID:Date:From:To:Cc:Subject; b=WhSCl3vVmwu8iOc26grb6TyiVT7epqO8f7El/njVbdJhmOv/zcmcgKACKwDYQvGK839uzN2K/Y1TPQShc5UsMJtUENlEk2xGUH0j/8OXjAO+YbBXCGfabN/6uIhcNKtoCl9XIJ8H7LmTZeZ7IlOhIlPdgu/Ma2Cw4Q1FhuNne7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVWOzcBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3246C4CEF7;
	Wed, 29 Oct 2025 14:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761748843;
	bh=H5CXfnrpZRHN+f4MhQXGUsbef12MtcsG4IIn6H7dHm4=;
	h=Date:From:To:Cc:Subject:From;
	b=oVWOzcBcNdRicnicLYsEccs9lJ7C8P++VBeBPomyD9K1kxbRknyzKqSmfo9dHEpl+
	 I8O8Kp3upmZKPGyDn4ywo0nz+igbyqHudkZA9xM6k/0hkHIl03izjhInTP1u6TUlCb
	 oMV2ZPmaxJ5DCr3/ooezvc4LG3NVpfruAqX87PQlk0A6x0PEwAdHmBh7hl3SnAMa1C
	 VcDmJeNXp8FCVdvWHWw2gbo/Rl0uRQ963RDZJkRdV2+WE/dWWxppVp/Rb2eCkuOBJ7
	 IS7Vz60guaXa7J2G9SNCHmG+gua9z8Dhc8/lagqFwo35Odg9umf78lfItaCFK+eBEu
	 mryZcKNt9x8mQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vE7MZ-000000052tk-2KiJ;
	Wed, 29 Oct 2025 10:41:23 -0400
Message-ID: <20251029144041.475297995@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 29 Oct 2025 10:40:41 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/13] tracing: Reading user space data in syscall events for v6.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 25bd47a592751eba6ed337e6293dc69f8aa2452f


Steven Rostedt (13):
      tracing: Make trace_user_fault_read() exposed to rest of tracing
      tracing: Have syscall trace events read user space string
      perf: tracing: Simplify perf_sysenter_enable/disable() with guards
      perf: tracing: Have perf system calls read user space
      tracing: Have system call events record user array data
      tracing: Display some syscall arrays as strings
      tracing: Allow syscall trace events to read more than one user parameter
      tracing: Add a config and syscall_user_buf_size file to limit amount written
      tracing: Show printable characters in syscall arrays
      tracing: Add trace_seq_pop() and seq_buf_pop()
      tracing: Add parsing of flags to the sys_enter_openat trace event
      tracing: Check for printable characters when printing field dyn strings
      tracing: Have persistent ring buffer print syscalls normally

----
 Documentation/trace/ftrace.rst |   8 +
 include/linux/seq_buf.h        |  17 +
 include/linux/trace_seq.h      |  13 +
 include/trace/syscall.h        |   8 +-
 kernel/trace/Kconfig           |  14 +
 kernel/trace/trace.c           | 327 ++++++++++++---
 kernel/trace/trace.h           |  20 +
 kernel/trace/trace_output.c    |  27 +-
 kernel/trace/trace_syscalls.c  | 929 ++++++++++++++++++++++++++++++++++++++---
 9 files changed, 1244 insertions(+), 119 deletions(-)

