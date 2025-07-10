Return-Path: <linux-kernel+bounces-724694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2F7AFF5FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBDE1BC8B77
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816351A0B0E;
	Thu, 10 Jul 2025 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puERIawX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA914F121
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107553; cv=none; b=JO03TJDGWU/JP8PzhrewcsPE3cuFzXbxYhXOnDENj3eQwxuzzOL74zbvxHCQ1N2BpqtdRUEnfgxFeKdaSLJshr9sHrcYhaycE83X1UVuvtajlhQTwQczelzbDUYtxDNhnx/Ri6nGNQEfQl1OjZF8iECU/wmrF9CtEw5yNa4gTZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107553; c=relaxed/simple;
	bh=qw7BlKa0gX60JljMveu0WGaBOu17LB9Ua3FrZLY+xP4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FuJqwEbLmczup7fQ3YAULUTWLLC870cndP5AKIOTsOh4Eb01pLnr21DPWN9Y+hyYK+xuc07EaFCl8hmbH2N+POjudsapV4l+DlnkmeRqUZT87F6QZQU6odmrFXuWh7pfGAUL26DQKVMYtBQCJFdViV8w9vrVbLzKGiVYuhxDdeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puERIawX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F20C4CEF6;
	Thu, 10 Jul 2025 00:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107552;
	bh=qw7BlKa0gX60JljMveu0WGaBOu17LB9Ua3FrZLY+xP4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=puERIawXvvm7gRuVQmNFk7zdtidSJb30d17Z3WxoG3/eK/CjaEXDwI0oil+8wL74Y
	 svTYCr3cVhYMN+qdN+SKeJ+CEaCbQRV6kgtSReVbZyIwwLMjtBr+rXhShWnyZ/zARO
	 GI1hokXe7JhzBLAfdZxvg4LJcxeK2hFm8IcWDBbgMda5o7UV4py+FU4CxfT33P5hbU
	 OA4u7X3ARrql23m08y9xuyHqx6O91TLvO3ppL+NObIiKb0CVeG3ICQjIiLhN41nIeO
	 DPpYSeQfTQPr7PAyVLY5S/SVIXgRxIl9WhqMRWK/YI+EapFHxZfOHIj6Yg4eGbrNud
	 5S4PO69AkM6LA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfDJ-00000001WSk-1Wx3;
	Wed, 09 Jul 2025 20:32:37 -0400
Message-ID: <20250710003237.217747036@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:32:07 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Ogness <john.ogness@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 11/12] rv: Add documentation for rtapp monitor
References: <20250710003156.209859354@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Add documentation describing the rtapp monitor.

Cc: John Ogness <john.ogness@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/df0242d74c12511e82cc9d73c082def91a160c74.1752088709.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/rv/index.rst         |   1 +
 Documentation/trace/rv/monitor_rtapp.rst | 133 +++++++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 Documentation/trace/rv/monitor_rtapp.rst

diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/index.rst
index e80e0057feb4..26042dff70bb 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -13,3 +13,4 @@ Runtime Verification
    monitor_wip.rst
    monitor_wwnr.rst
    monitor_sched.rst
+   monitor_rtapp.rst
diff --git a/Documentation/trace/rv/monitor_rtapp.rst b/Documentation/trace/rv/monitor_rtapp.rst
new file mode 100644
index 000000000000..c8104eda924a
--- /dev/null
+++ b/Documentation/trace/rv/monitor_rtapp.rst
@@ -0,0 +1,133 @@
+Real-time application monitors
+==============================
+
+- Name: rtapp
+- Type: container for multiple monitors
+- Author: Nam Cao <namcao@linutronix.de>
+
+Description
+-----------
+
+Real-time applications may have design flaws such that they experience
+unexpected latency and fail to meet their time requirements. Often, these flaws
+follow a few patterns:
+
+  - Page faults: A real-time thread may access memory that does not have a
+    mapped physical backing or must first be copied (such as for copy-on-write).
+    Thus a page fault is raised and the kernel must first perform the expensive
+    action. This causes significant delays to the real-time thread
+  - Priority inversion: A real-time thread blocks waiting for a lower-priority
+    thread. This causes the real-time thread to effectively take on the
+    scheduling priority of the lower-priority thread. For example, the real-time
+    thread needs to access a shared resource that is protected by a
+    non-pi-mutex, but the mutex is currently owned by a non-real-time thread.
+
+The `rtapp` monitor detects these patterns. It aids developers to identify
+reasons for unexpected latency with real-time applications. It is a container of
+multiple sub-monitors described in the following sections.
+
+Monitor pagefault
++++++++++++++++++
+
+The `pagefault` monitor reports real-time tasks raising page faults. Its
+specification is::
+
+  RULE = always (RT imply not PAGEFAULT)
+
+To fix warnings reported by this monitor, `mlockall()` or `mlock()` can be used
+to ensure physical backing for memory.
+
+This monitor may have false negatives because the pages used by the real-time
+threads may just happen to be directly available during testing.  To minimize
+this, the system can be put under memory pressure (e.g.  invoking the OOM killer
+using a program that does `ptr = malloc(SIZE_OF_RAM); memset(ptr, 0,
+SIZE_OF_RAM);`) so that the kernel executes aggressive strategies to recycle as
+much physical memory as possible.
+
+Monitor sleep
++++++++++++++
+
+The `sleep` monitor reports real-time threads sleeping in a manner that may
+cause undesirable latency. Real-time applications should only put a real-time
+thread to sleep for one of the following reasons:
+
+  - Cyclic work: real-time thread sleeps waiting for the next cycle. For this
+    case, only the `clock_nanosleep` syscall should be used with `TIMER_ABSTIME`
+    (to avoid time drift) and `CLOCK_MONOTONIC` (to avoid the clock being
+    changed). No other method is safe for real-time. For example, threads
+    waiting for timerfd can be woken by softirq which provides no real-time
+    guarantee.
+  - Real-time thread waiting for something to happen (e.g. another thread
+    releasing shared resources, or a completion signal from another thread). In
+    this case, only futexes (FUTEX_LOCK_PI, FUTEX_LOCK_PI2 or one of
+    FUTEX_WAIT_*) should be used.  Applications usually do not use futexes
+    directly, but use PI mutexes and PI condition variables which are built on
+    top of futexes. Be aware that the C library might not implement conditional
+    variables as safe for real-time. As an alternative, the librtpi library
+    exists to provide a conditional variable implementation that is correct for
+    real-time applications in Linux.
+
+Beside the reason for sleeping, the eventual waker should also be
+real-time-safe. Namely, one of:
+
+  - An equal-or-higher-priority thread
+  - Hard interrupt handler
+  - Non-maskable interrupt handler
+
+This monitor's warning usually means one of the following:
+
+  - Real-time thread is blocked by a non-real-time thread (e.g. due to
+    contention on a mutex without priority inheritance). This is priority
+    inversion.
+  - Time-critical work waits for something which is not safe for real-time (e.g.
+    timerfd).
+  - The work executed by the real-time thread does not need to run at real-time
+    priority at all.  This is not a problem for the real-time thread itself, but
+    it is potentially taking the CPU away from other important real-time work.
+
+Application developers may purposely choose to have their real-time application
+sleep in a way that is not safe for real-time. It is debatable whether that is a
+problem. Application developers must analyze the warnings to make a proper
+assessment.
+
+The monitor's specification is::
+
+  RULE = always ((RT and SLEEP) imply (RT_FRIENDLY_SLEEP or ALLOWLIST))
+
+  RT_FRIENDLY_SLEEP = (RT_VALID_SLEEP_REASON or KERNEL_THREAD)
+                  and ((not WAKE) until RT_FRIENDLY_WAKE)
+
+  RT_VALID_SLEEP_REASON = FUTEX_WAIT
+                       or RT_FRIENDLY_NANOSLEEP
+
+  RT_FRIENDLY_NANOSLEEP = CLOCK_NANOSLEEP
+                      and NANOSLEEP_TIMER_ABSTIME
+                      and NANOSLEEP_CLOCK_MONOTONIC
+
+  RT_FRIENDLY_WAKE = WOKEN_BY_EQUAL_OR_HIGHER_PRIO
+                  or WOKEN_BY_HARDIRQ
+                  or WOKEN_BY_NMI
+                  or KTHREAD_SHOULD_STOP
+
+  ALLOWLIST = BLOCK_ON_RT_MUTEX
+           or FUTEX_LOCK_PI
+           or TASK_IS_RCU
+           or TASK_IS_MIGRATION
+
+Beside the scenarios described above, this specification also handle some
+special cases:
+
+  - `KERNEL_THREAD`: kernel tasks do not have any pattern that can be recognized
+    as valid real-time sleeping reasons. Therefore sleeping reason is not
+    checked for kernel tasks.
+  - `KTHREAD_SHOULD_STOP`: a non-real-time thread may stop a real-time kernel
+    thread by waking it and waiting for it to exit (`kthread_stop()`). This
+    wakeup is safe for real-time.
+  - `ALLOWLIST`: to handle known false positives with the kernel.
+  - `BLOCK_ON_RT_MUTEX` is included in the allowlist due to its implementation.
+    In the release path of rt_mutex, a boosted task is de-boosted before waking
+    the rt_mutex's waiter. Consequently, the monitor may see a real-time-unsafe
+    wakeup (e.g. non-real-time task waking real-time task). This is actually
+    real-time-safe because preemption is disabled for the duration.
+  - `FUTEX_LOCK_PI` is included in the allowlist for the same reason as
+    `BLOCK_ON_RT_MUTEX`.
-- 
2.47.2



