Return-Path: <linux-kernel+bounces-745792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CED2B11EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B371D1CE4577
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257BD2EBDEA;
	Fri, 25 Jul 2025 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3FRW4TW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877732EBB80
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447325; cv=none; b=FoUYe3LHcSfdgStS6xBYepmBMCFhf74uZsvtsila5ZZ52E65kvswRED0dg2U/E9/DkB7AbGXNpCNjAUS8HlVL3kUQ/ms7/X6/gQCjyio7waIc14R+/Aw2GCWVUlS3E8JZAl6KmSbxqnVNMfs4KbmZLJLxUZE+BK8i/Zhwvs+BUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447325; c=relaxed/simple;
	bh=psGOwIuP9HH/51ebcOi1ci4UCQfTXt1PBhJLrekVYdg=;
	h=Message-ID:Date:From:To:Cc:Subject; b=Cf8Vt6Ht7EHOjYxUPxD+4p+QJYc8gHyAfcVaLa/tIZ7Nd2Kixf1YAnZ8aLhgzr/bnHj1k2tY/f+ExE6r0ABzFUjQnt7yhirUBpIGpnCg6NANrDmpzva1jkOJaTFxyT85+E0+9a3AyS31q5aRJRnYuqMNi1Y5VTTmbsPpGAhXqEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3FRW4TW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BA7C4CEE7;
	Fri, 25 Jul 2025 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753447325;
	bh=psGOwIuP9HH/51ebcOi1ci4UCQfTXt1PBhJLrekVYdg=;
	h=Date:From:To:Cc:Subject:From;
	b=Y3FRW4TWzdXVG3zZoaCacLWitYzDwuYe2CKTzW5m3EbxEmjepyP3o6shW/j2tXq4M
	 A4u/JO3fkfl6cPLNb7CI29w7GiSiG/zDTM5Yvmz9QsQugkevy67R26sQyHX791TrOX
	 Hc7ufKamqEkle6Ktl/9eU5W3jaMk2FVdSamJTid6zvb9MJxJ8ucCr+hjmjQ8KZPbgW
	 zWH7jzXTUKgU1R5sJUcnB20Jjd2BPJcv/QcEjkJITY7yCkwNLO6eg9wnXtxH4Ywk9P
	 GBCQegH8Yduuq7lvA8koOI+NaK/3hVgL+ys3mbSM26LR1DuuGEBzMPQ7AtPwZhzaRH
	 G/3Q9Awbtfj7A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufHkY-00000001CsR-1hoA;
	Fri, 25 Jul 2025 08:42:10 -0400
Message-ID: <20250725124145.391996103@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 08:41:45 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/9] tracing: Fixes for unused tracepoints for 6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
unused-tracepoints/for-next

Head SHA1: 8c4e53a1a09374c232fe96232426226b2824f473


Steven Rostedt (9):
      tracing, AER: Hide PCIe AER event when PCIEAER is not configured
      alarmtimer: Hide alarmtimer_suspend event when RTC_CLASS is not configured
      PM: cpufreq: powernv/tracing: Move powernv_throttle trace event
      PM: tracing: Hide psci_domain_idle events under ARM_PSCI_CPUIDLE
      PM: tracing: Hide device_pm_callback events under PM_SLEEP
      PM: tracing: Hide power_domain_target event under ARCH_OMAP2PLUS
      binder: Remove unused binder lock events
      tracing: arm: arm64: Hide trace events ipi_raise, ipi_entry and ipi_exit
      tracing: Call trace_ftrace_test_filter() for the event

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
 kernel/trace/Kconfig               |  6 ++++
 kernel/trace/power-traces.c        |  1 -
 kernel/trace/trace_events_filter.c |  4 +++
 13 files changed, 100 insertions(+), 73 deletions(-)
 create mode 100644 drivers/cpufreq/powernv-trace.h

