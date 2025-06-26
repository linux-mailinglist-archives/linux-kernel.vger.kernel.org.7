Return-Path: <linux-kernel+bounces-704677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7C2AEA062
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 16:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1944E3EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE262E7F22;
	Thu, 26 Jun 2025 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzGLtaD8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318B51FFC41
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947650; cv=none; b=cJCPe9jx/5NorAErEAsxI58YcibqlrP/YSOnWYQ9/ffc+DcuO7WghoJiNI9WY5XDXRuPCzVze/zl+5Mwn13ujohqp7n+yv7KMd4fo7QDZ1Wd0ZyYdYyQWaCG1O+IErN7GHRsTZiGXGKHgiyXt1BOtZTIN3DB/INrdB5HyH9Z49Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947650; c=relaxed/simple;
	bh=bclxeXv0n/JZRrzO5RtoRO8C6M2nw+tu77BU7PQ5Up8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F86YaFcn6HS39s+sBL/HRmFywmQCkXRnx4A96BDxTjcdDcbwAh7iBHg/6sxcA5MFcVody91RXtH1ZB940aEjSS2AVKySw4mXzixQevNsrL6hAsB8u5c1H8h+geLTRTITlf+XZcpyL8jVWRs+lnhJtfDF6DrVl4SFxiz8vjickWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzGLtaD8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750947648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fpjZ7Ix+hSftMvcLs9udwlSD+jACUpMj3pQyikQ0cME=;
	b=VzGLtaD8ax5FE6I9zKyGQDZvPawp93m5EBy5eaAwDSovYt9Dub9oOHrAi0w0zmjdsRgkYM
	lH5nR+Zb4hELZFXlPLYYEt7Gj/88NpnhNNyAGKdDJ7f/EEcbHCGVV0hpJCewypHADxqHiP
	MjeG5gF4+porIovkdN/W2fIp5SwbSZA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-Ee7nGeq4NKO0P7RyMkatVA-1; Thu,
 26 Jun 2025 10:20:44 -0400
X-MC-Unique: Ee7nGeq4NKO0P7RyMkatVA-1
X-Mimecast-MFC-AGG-ID: Ee7nGeq4NKO0P7RyMkatVA_1750947638
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4237D193F069;
	Thu, 26 Jun 2025 14:20:37 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.64.203])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 063D818002B9;
	Thu, 26 Jun 2025 14:20:24 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Wander Lairson Costa <wander@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 0/2] tracing/preemptirq: Optimize disabled tracepoint overhead
Date: Thu, 26 Jun 2025 11:20:08 -0300
Message-ID: <20250626142017.26372-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


This series addresses unnecessary overhead introduced by the
preempt/irq tracepoints when they are compiled into the kernel
but are not actively enabled (i.e., when tracing is disabled).

These optimizations ensure that when tracing is inactive, the kernel
can largely bypass operations that would otherwise incur a passive
performance penalty. This makes the impact of disabled preemptirq
IRQ and preempt tracing negligible in performance-sensitive environments.

Wander Lairson Costa (2):
  trace/preemptirq: reduce overhead of irq_enable/disable tracepoints
  tracing/preemptirq: Optimize preempt_disable/enable() tracepoint
    overhead

---
Performance Measurements

Measurements were taken using a specialized kernel module [1] to benchmark
`local_irq_disable/enable()` and `preempt_disable/enable()` call pairs.
The kernel used for benchmarking was version 6.16.0-rc2. "Max Average"
represents the average of the 1000 highest samples, used to reduce noise
from single highest samples.

Each benchmark run collected 10^7 samples in parallel from each CPU
for each call pair (used for average, max_avg, and median calculations).
The 99th percentile was measured in a separate benchmark run, focused
on a single CPU.

The results show that compiling with tracers (Kernel Build:
`-master-trace`) introduced significant overhead compared to a base
kernel without tracers (Kernel Build: `-master`). After applying these
patches (Kernel Build: `-patched-trace`), the overhead is
substantially reduced, approaching the baseline.

x86-64 Metrics

Tests were run on a system equipped with an Intel(R) Xeon(R) Silver 4310 CPU.

IRQ Metrics

Combined Metric            average  max_avg  median  percentile
Kernel Build
6.16.0-rc2-master               28     5587      29          23
6.16.0-rc2-master-trace         46     7895      48          32
6.16.0-rc2-patched-trace        30     6030      31          27

Preempt Metrics

Combined Metric            average  max_avg  median  percentile
Kernel Build
6.16.0-rc2-master               26     5748      27          20
6.16.0-rc2-master-trace         45     7526      48          26
6.16.0-rc2-patched-trace        27     5479      27          21

AArch64 Metrics

Tests were also conducted on an AArch64 platform.

IRQ Metrics

Combined Metric             average  max_avg  median  percentile
Kernel Build
aarch64-6.16.0-rc2-master        28     3298      32          64
aarch64-6.16.0-rc2-master-trace 105     5769      96         128
aarch64-6.16.0-rc2-patched-trace 29     3192      32          64

Preempt Metrics

Combined Metric             average  max_avg  median  percentile
Kernel Build
aarch64-6.16.0-rc2-master        27     3371      32          32
aarch64-6.16.0-rc2-master-trace  32     3000      32          64
aarch64-6.16.0-rc2-patched-trace 28     3132      32          64

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>

---
References:
[1] https://github.com/walac/tracer-benchmark

Wander Lairson Costa (2):
  trace/preemptirq: reduce overhead of irq_enable/disable tracepoints
  tracing/preemptirq: Optimize preempt_disable/enable() tracepoint
    overhead

 include/linux/irqflags.h        | 25 +++++++++++++++--------
 include/linux/preempt.h         | 35 ++++++++++++++++++++++++++++++---
 kernel/sched/core.c             | 12 +----------
 kernel/trace/trace_preemptirq.c | 22 +++++++++++++++++++++
 4 files changed, 72 insertions(+), 22 deletions(-)

-- 
2.50.0


