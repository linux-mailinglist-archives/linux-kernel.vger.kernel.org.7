Return-Path: <linux-kernel+bounces-837946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28740BAE1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4907D327798
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816EA30BBAC;
	Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbrzSm+S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62530595D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251685; cv=none; b=t+RLLzXLBfwrbExzDZ40aFyy5Z4f8quh0hO1jejq9sNboIiW7nR8ZSohX4C02Ar/kn0c6sSBAPWdyAA+D6xjztFx3xky8INhDZGjepO4/u1kPnvmpN+SXGLPKXRF9AvRBnxCT3F2eFMohhb46diXPSlmNxZsBixAbD8DDJGUdmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251685; c=relaxed/simple;
	bh=48IxChaDAoNUP2QfjSx0DcUi3DxWmFrUfv66bwcZjyc=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Q83kVNW0j9f0kq3wmh6bDT0rc7xuNP7cQ2GmOaFGT2ywzPv5AyhEMITcVW0kaqc1tS+IMMDyE2vZUsPSjkGf67B/YojVRqXqOyLWmJ6Q/Aj2YasVqj+3o8NTPs1EpECK2a2W6NkNaqShrk9KQvP3SH46BRFVgoKD5R7KWmhgyDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbrzSm+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7764BC113D0;
	Tue, 30 Sep 2025 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759251685;
	bh=48IxChaDAoNUP2QfjSx0DcUi3DxWmFrUfv66bwcZjyc=;
	h=Date:From:To:Cc:Subject:From;
	b=rbrzSm+SC0mVdVVn3ki4g5Ymd+wR7FLBqcIA7T+enwyfUkUwXp5NH1DmRXVhdjl1q
	 mbnl0WCI+v3qG1SV5RyKgB1u6fs9s9r2UHkQ/pRvU9rLHf4M10baSIYKl/F7TO3GC9
	 7L1PY837o2N8edfjC12RuquCvIY8rmFrNgjpFhIXUg2XXT5cqnbJJ1ZuCmj3P2AbZS
	 aOVisJjX0KpfY1Yam//BZp2LFyrBzk9z2PlEhhmbfUW1kyRVIhK/vmz5I9wDmHAh0h
	 8K6G5LdQ01Jwfqk7GJG4ggkIP1sMgnu75zUbPBSvJqUUpQfK58AZXIZgJO0ss41Zsu
	 gD4+NeUdZQUEA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3dkj-0000000DIFL-1Oj4;
	Tue, 30 Sep 2025 13:03:01 -0400
Message-ID: <20250930170135.285740909@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 13:01:35 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/11] tracing: Updates for v6.18
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Bah, I just noticed these were still sitting in my local repository
and I never pushed them up. Mostly clean ups anyway. No new features.

Just finished running them through my internal tests.

-- Steve


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: db04eea49423f28faf2e2fb6e799b78f2b38564f


Elijah Wright (1):
      tracing: Move buffer in trace_seq to end of struct

Fushuai Wang (1):
      tracing/osnoise: Use for_each_online_cpu() instead of for_each_cpu()

Liao Yuanhong (1):
      tracing: Remove redundant 0 value initialization

Marco Crivellari (1):
      tracing: replace use of system_wq with system_percpu_wq

Michal Koutný (1):
      tracing: Ensure optimized hashing works

Qianfeng Rong (1):
      tracing: Use vmalloc_array() to improve code

Sasha Levin (1):
      tracing: Fix lock imbalance in s_start() memory allocation failure path

Steven Rostedt (2):
      tracing: Replace syscall RCU pointer assignment with READ/WRITE_ONCE()
      tracing: Have syscall trace events show "0x" for values greater than 10

Thorsten Blum (1):
      tracing/osnoise: Replace kmalloc() + copy_from_user() with memdup_user()

Vladimir Riabchun (1):
      ftrace: Fix softlockup in ftrace_module_enable

----
 include/linux/trace_seq.h         |  2 +-
 kernel/trace/ftrace.c             |  2 ++
 kernel/trace/trace.h              |  4 ++--
 kernel/trace/trace_events.c       |  3 +--
 kernel/trace/trace_events_user.c  |  2 +-
 kernel/trace/trace_osnoise.c      | 13 +++++--------
 kernel/trace/trace_sched_switch.c |  3 ++-
 kernel/trace/trace_syscalls.c     | 26 +++++++++++++++-----------
 kernel/trace/tracing_map.c        |  2 +-
 9 files changed, 30 insertions(+), 27 deletions(-)

