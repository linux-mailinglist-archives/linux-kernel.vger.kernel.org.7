Return-Path: <linux-kernel+bounces-889389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B984C3D728
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA9C24E5D86
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E063043BA;
	Thu,  6 Nov 2025 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEHCPqnZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F929C351
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762463038; cv=none; b=igGvNnwsyIZjw9FcIkHkGDIIbP5kdsU/jvtqtmz09Elp7wIIAdgB6po2sY0oqCMYsEBvBLXo4ep5NIrlSo3ek4JflLzWKay2UT3IjsdlW7Va6RSgu0+W2d+QoiOHQGfq9/+DL6U6GNbRlZ0wYYqbJt6UgmifCxf96Ty0kVcGNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762463038; c=relaxed/simple;
	bh=biueGNuOv9UPK8/nnzCA2kVC09WSzD0Q7CjKujCviZQ=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Ri1L9cjZ37mIshnctY5qi1oq63era+lXZ3prPmatBLf2PUWZv7iq8naBtR0I5cukTYnie9WeWYCeFDRs8JoTkA1RxX/tHg03aUvxYrYyNGaoguS6UujCyHXElpKZL4asM4WP/7cbTiACDY5G0al6dwjFQfMDv/V2w9CjK2G1XQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEHCPqnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67012C19425;
	Thu,  6 Nov 2025 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762463037;
	bh=biueGNuOv9UPK8/nnzCA2kVC09WSzD0Q7CjKujCviZQ=;
	h=Date:From:To:Cc:Subject:From;
	b=KEHCPqnZZi1GucjcpBllPitYg/4A25qNH3Qj2//YHjZD/4uDNPelm2UFX9uCEPGHF
	 nzLuEae9EAklk1baDafrOxHTPT2FqKooSxPc0rI3IhxqvHJ61L+8S1Ch9Q04Pq/xEc
	 s37/vXzqMdr+zZE9vuYfbrOxrgaxDeBdbl5xfddF64/pzLBBrGTBmd7ikCdmYft1jv
	 zbI106LXHCPHi/Mzz7r9vktDBEDT1xxUFUzPUyvZoIIV32UtyudvpB+uZzuAdJusCE
	 SXGCw+a/tDHoONPPQx/27GwUkIopBP65moQyGHZd2mDqqOy6pTBfDKsE6npDJqUVR6
	 F/JdsGpDNq0ZQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vH79A-000000008As-41XX;
	Thu, 06 Nov 2025 16:03:56 -0500
Message-ID: <20251106210331.537317097@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 06 Nov 2025 16:03:31 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/7] tracing: Updates for v6.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: c9f79d5021b714fb39cc9110fc092196d17cc18c


Masami Hiramatsu (Google) (2):
      tracing: Allow tracer to add more than 32 options
      tracing: Add an option to show symbols in _text+offset for function profiler

Steven Rostedt (6):
      Merge branch 'topic/func-profiler-offset' of git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux into trace/trace/core
      tracing: Hide __NR_utimensat and _NR_mq_timedsend when not defined
      tracing: Remove dummy options and flags
      tracing: Have add_tracer_options() error pass up to callers
      tracing: Exit out immediately after update_marker_trace()
      tracing: Use switch statement instead of ifs in set_tracer_flag()

----
 kernel/trace/blktrace.c              |   6 +-
 kernel/trace/ftrace.c                |  26 +++-
 kernel/trace/trace.c                 | 274 ++++++++++++++++++-----------------
 kernel/trace/trace.h                 |  40 ++---
 kernel/trace/trace_events.c          |   4 +-
 kernel/trace/trace_events_synth.c    |   2 +-
 kernel/trace/trace_fprobe.c          |   6 +-
 kernel/trace/trace_functions_graph.c |  18 +--
 kernel/trace/trace_irqsoff.c         |  30 ++--
 kernel/trace/trace_kdb.c             |   2 +-
 kernel/trace/trace_kprobe.c          |   6 +-
 kernel/trace/trace_output.c          |  18 +--
 kernel/trace/trace_output.h          |  11 ++
 kernel/trace/trace_sched_wakeup.c    |  24 +--
 kernel/trace/trace_syscalls.c        |   8 +-
 15 files changed, 265 insertions(+), 210 deletions(-)

