Return-Path: <linux-kernel+bounces-641096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36041AB0CD6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 10:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0D650440D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2A627A476;
	Fri,  9 May 2025 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pi+d/yL7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fPkP1gL9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED892701A2;
	Fri,  9 May 2025 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778371; cv=none; b=SiKEynnYKMecnOllPocb8H7L8SjLxnSJawWr5jCyCSmMwRYb4I4RAT3BrUbj9EniczBXagfFyAiQi67qxmJUNE+Mqml9iIpEdPbrJc+i56UUgiQz4F0OMuIxeC32bBbGz5bgf29AV+TZx8xIapQ6F/GcsCZqbn4ZCGFjHbw9rjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778371; c=relaxed/simple;
	bh=ufx6Ziq+dAmsyXwrmstsrkksT3rgBlh5o1jDkIFjty4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8NvQqIY10tyZWsdrgqDEsOPUUm4Q4RdgQctyv+xwg/biPPnVh63aEAubYgKDx6egrGYB/eDj8NAMRH+wNS6pPrxrz6UBoEIMAbAHx9hk4hZguIdH3pp+03lBqY5vsIs61+oCK770Hx++2AdwYmspZWg7IlcbxsVPkveoTqGT90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pi+d/yL7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fPkP1gL9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746778366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTZS2uwSWMoxWyABrebdhgXyGWRC5r1Wp/cBH7YgJHc=;
	b=pi+d/yL7cRx46sh4B85Zvnofr4OwH6v/IyZ9Y5BCgaNLTQWGnNVpa3dgS2BwlZua4A8DMs
	Y722kUfdwleFPsFko20deVP6dQgDsGkXaCHqxOo7dmndke4DbGf/KRzopFsk8Wkp2ZnV+F
	jsDzuu55TTh9L3BZzVilTsjZK8WEzdb43kvafJPFADAB/wPvuAfbxNaTrMlrxvx076b9j/
	583Z0KFnuO9GQZRQC9oOiOEdYqqLqKyGQAvrnC4SAe23QE1996SxUq/nUfT/EMAElDNvZD
	rmRNt/2IaO4sMRXa3+sJGL/8SMD/GVDjH942eutv2qjARRpqwOKrHfI70X/jdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746778366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTZS2uwSWMoxWyABrebdhgXyGWRC5r1Wp/cBH7YgJHc=;
	b=fPkP1gL9oY/0sCXNetiwvTcscQkTJ/IsPYZXEwkWy/O6YWqzm8xese6vBaCkalE8HHfTLV
	DojztpWGpk11STBw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v7 21/22] rv: Add documentation for rtapp monitor
Date: Fri,  9 May 2025 10:12:20 +0200
Message-Id: <db692a2c13dd1e0c3c589edb0855d39fd98864fa.1746776116.git.namcao@linutronix.de>
In-Reply-To: <cover.1746776116.git.namcao@linutronix.de>
References: <cover.1746776116.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add documentation describing the rtapp monitor.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 Documentation/trace/rv/index.rst         |   1 +
 Documentation/trace/rv/monitor_rtapp.rst | 116 +++++++++++++++++++++++
 2 files changed, 117 insertions(+)
 create mode 100644 Documentation/trace/rv/monitor_rtapp.rst

diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/inde=
x.rst
index 2a27f6bc9429..a2812ac5cfeb 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -14,3 +14,4 @@ Runtime Verification
    monitor_wip.rst
    monitor_wwnr.rst
    monitor_sched.rst
+   monitor_rtapp.rst
diff --git a/Documentation/trace/rv/monitor_rtapp.rst b/Documentation/trace=
/rv/monitor_rtapp.rst
new file mode 100644
index 000000000000..6dcea6e4ffda
--- /dev/null
+++ b/Documentation/trace/rv/monitor_rtapp.rst
@@ -0,0 +1,116 @@
+Real-time application monitors
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+- Name: rtapp
+- Type: container for multiple monitors
+- Author: Nam Cao <namcao@linutronix.de>
+
+Description
+-----------
+
+Real-time applications may have design flaws such that they experience une=
xpected latency and fail
+to meet their time requirements. Often, these flaws follow a few patterns:
+
+  - Page faults: A real-time thread may access memory that does not have a=
 mapped physical backing
+    or must first be copied (such as for copy-on-write). Thus a page fault=
 is raised and the kernel
+    must first perform the expensive action. This causes significant delay=
s to the real-time thread
+  - Priority inversion: A real-time thread blocks waiting for a lower-prio=
rity thread. This causes
+    the real-time thread to effectively take on the scheduling priority of=
 the lower-priority
+    thread. For example, the real-time thread needs to access a shared res=
ource that is protected by
+    a non-pi-mutex, but the mutex is currently owned by a non-real-time th=
read.
+
+The `rtapp` monitor detects these patterns. It aids developers to identify=
 reasons for unexpected
+latency with real-time applications. It is a container of multiple sub-mon=
itors described in the
+following sections.
+
+Monitor pagefault
++++++++++++++++++
+
+The `pagefault` monitor reports real-time tasks raising page faults. Its s=
pecification is::
+
+  RULE =3D always (RT imply not PAGEFAULT)
+
+To fix warnings reported by this monitor, `mlockall()` or `mlock()` can be=
 used to ensure physical
+backing for memory.
+
+This monitor may have false negatives because the pages used by the real-t=
ime threads may just
+happen to be directly available during testing. To minimize this, the syst=
em can be put under memory
+pressure (e.g. invoking the OOM killer using a program that does `ptr =3D =
malloc(SIZE_OF_RAM);
+memset(ptr, 0, SIZE_OF_RAM);`) so that the kernel executes aggressive stra=
tegies to recycle as much
+physical memory as possible.
+
+Monitor sleep
++++++++++++++
+
+The `sleep` monitor reports real-time threads sleeping in a manner that ma=
y cause undesirable
+latency. Real-time applications should only put a real-time thread to slee=
p for one of the following
+reasons:
+
+  - Cyclic work: real-time thread sleeps waiting for the next cycle. For t=
his case, only the
+    `clock_nanosleep` syscall should be used with `TIMER_ABSTIME` (to avoi=
d time drift) and
+    `CLOCK_MONOTONIC` (to avoid the clock being changed). No other method =
is safe for real-time. For
+    example, threads waiting for timerfd can be woken by softirq which pro=
vides no real-time
+    guarantee.
+  - Real-time thread waiting for something to happen (e.g. another thread =
releasing shared
+    resources, or a completion signal from another thread). In this case, =
only futexes with priority
+    inheritance (FUTEX_LOCK_PI, FUTEX_LOCK_PI2 or FUTEX_WAIT_REQUEUE_PI) s=
hould be used.
+    Applications usually do not use futexes directly, but use PI mutexes a=
nd PI condition variables
+    which are built on top of futexes. Be aware that the C library might n=
ot implement conditional
+    variables as safe for real-time. As an alternative, the librtpi librar=
y exists to provide a
+    conditional variable implementation that is correct for real-time appl=
ications in Linux.
+
+Beside the reason for sleeping, the eventual waker should also be real-tim=
e-safe. Namely, one of:
+
+  - An equal-or-higher-priority thread
+  - Hard interrupt handler
+  - Non-maskable interrupt handler
+
+This monitor's warning usually means one of the following:
+
+  - Real-time thread is blocked by a non-real-time thread (e.g. due to con=
tention on a mutex without
+    priority inheritance). This is priority inversion.
+  - Time-critical work waits for something which is not safe for real-time=
 (e.g. timerfd).
+  - The work executed by the real-time thread does not need to run at real=
-time priority at all.
+    This is not a problem for the real-time thread itself, but it is poten=
tially taking the CPU away
+    from other important real-time work.
+
+Application developers may purposely choose to have their real-time applic=
ation sleep in a way that
+is not safe for real-time. It is debatable whether that is a problem. Appl=
ication developers must
+analyze the warnings to make a proper assessment.
+
+The monitor's specification is::
+
+  RULE =3D always ((RT and SLEEP) imply (RT_FRIENDLY_SLEEP or ALLOWLIST))
+
+  RT_FRIENDLY_SLEEP =3D (RT_VALID_SLEEP_REASON or KERNEL_THREAD)
+                  and ((not WAKE) until RT_FRIENDLY_WAKE)
+
+  RT_VALID_SLEEP_REASON =3D FUTEX_WAIT_REQUEUE_PI
+                       or RT_FRIENDLY_NANOSLEEP
+
+  RT_FRIENDLY_NANOSLEEP =3D CLOCK_NANOSLEEP
+                      and NANOSLEEP_TIMER_ABSTIME
+                      and NANOSLEEP_CLOCK_MONOTONIC
+
+  RT_FRIENDLY_WAKE =3D WOKEN_BY_EQUAL_OR_HIGHER_PRIO
+                  or WOKEN_BY_HARDIRQ
+                  or WOKEN_BY_NMI
+                  or KTHREAD_SHOULD_STOP
+
+  ALLOWLIST =3D BLOCK_ON_RT_MUTEX
+           or FUTEX_LOCK_PI
+           or TASK_IS_RCU
+           or TASK_IS_MIGRATION
+
+Beside the scenarios described above, this specification also handle some =
special cases:
+
+  - `KERNEL_THREAD`: kernel tasks do not have any pattern that can be reco=
gnized as valid real-time
+    sleeping reasons. Therefore sleeping reason is not checked for kernel =
tasks.
+  - `KTHREAD_SHOULD_STOP`: a non-real-time thread may stop a real-time ker=
nel thread by waking it
+    and waiting for it to exit (`kthread_stop()`). This wakeup is safe for=
 real-time.
+  - `ALLOWLIST`: to handle known false positives with the kernel.
+  - `BLOCK_ON_RT_MUTEX` is included in the allowlist due to its implementa=
tion. In the release path
+    of rt_mutex, a boosted task is de-boosted before waking the rt_mutex's=
 waiter. Consequently, the
+    monitor may see a real-time-unsafe wakeup (e.g. non-real-time task wak=
ing real-time task). This
+    is actually real-time-safe because preemption is disabled for the dura=
tion.
+  - `FUTEX_LOCK_PI` is included in the allowlist for the same reason as `B=
LOCK_ON_RT_MUTEX`.
--=20
2.39.5


