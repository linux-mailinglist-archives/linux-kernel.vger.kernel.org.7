Return-Path: <linux-kernel+bounces-599592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05066A855A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 09:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289101B6830F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 07:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A115729C323;
	Fri, 11 Apr 2025 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TI59miba";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Drq6HGdM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD712989BF;
	Fri, 11 Apr 2025 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357098; cv=none; b=HH6Vc4DgylxcdeBnVjGCxbxiHJg3LH8/2YlvTqgqLncr8/k4pngF3xM6yUqNanOSFPoyX5yZXqjGx+E/okR63gdxUTZebZ50aQARvqSwjPwxSZKv0+P13Hk8cdzMhvEn0z4teLkxIWJ7tmaeQi6G/qXiyqMDnYEHipu/+qJoHvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357098; c=relaxed/simple;
	bh=VjuLN4BCsiedjDgii6JHLbOd9Gy7io6KtSONf2Y+g9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gpw/eq4hw0JzUc0OnAFRF5Yutvupc3GHXiGrBfyayqpg9+7J2lG1qn33Lt8dfDFHLqa+z0QjGooFGCoGiQHQRzYDcUk3sa+/JwRkrNStVdNpqTjZbjNTwljUs4JDYPP9U7u+EvjYOWZhwdl6e4ghSfkXCS62gAtFcM2lvI9vEK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TI59miba; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Drq6HGdM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744357094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3OhnswQXkfnZGRMC0VN5QlApLE4QjbD6F/rNGRvySU=;
	b=TI59mibaxEICVQpO29RADqyC+Ttpb7aBPU2Ua3sLvqXqbeF4nmUt6YAW9Y+DsnhMrSd8Ra
	rSydgUKW7l5MoRW49dcXQWmOLwJA4+5j9Vh88BKJ5c3Dc64qvQ9dhOH2WkMynJ1TKq6CeT
	/lZw8Q3fmXv5SElt9XRfUD10SUzSuONLM0CPlh7+YKWwGgKj+4UloCVXrVgK56Eic984vL
	6dA70RBH1QHdbi25nTM7I2EO5dxHeLYxcilD4CUvRs4GuWPoWRvkJThKsOb/nB6Ot4EJRh
	tXlW50LUp12lw29AaE8gmBT1jikfPLtro8gFUH/CIIcRsz1tU+aaxlLXXdjAIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744357094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3OhnswQXkfnZGRMC0VN5QlApLE4QjbD6F/rNGRvySU=;
	b=Drq6HGdMiDivC1kGcc7ZvEkrDONkJ+zlKbjzzpzTVDRmRbhs+OiG/80cBY8gaKEMyK9Ulu
	xxdQaflNJdocgAAQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 21/22] rv: Add documentation for rtapp monitor
Date: Fri, 11 Apr 2025 09:37:37 +0200
Message-Id: <9d5b01d8bdff50081d6ad17be0474c8c355aa139.1744355018.git.namcao@linutronix.de>
In-Reply-To: <cover.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add documentation describing the rtapp monitor.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 Documentation/trace/rv/monitor_rtapp.rst | 105 +++++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/trace/rv/monitor_rtapp.rst

diff --git a/Documentation/trace/rv/monitor_rtapp.rst b/Documentation/trace=
/rv/monitor_rtapp.rst
new file mode 100644
index 000000000000..1cd188039a7e
--- /dev/null
+++ b/Documentation/trace/rv/monitor_rtapp.rst
@@ -0,0 +1,105 @@
+Scheduler monitors
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
+    `nanosleep` syscall should be used. No other method is safe for real-t=
ime. For example, threads
+    waiting for timerfd can be woken by softirq which provides no real-tim=
e guarantee.
+  - Real-time thread waiting for something to happen (e.g. another thread =
releasing shared
+    resources, or a completion signal from another thread). In this case, =
only futexes with priority
+    inheritance (PI) should be used. Applications usually do not use futex=
es directly, but use PI
+    mutexes and PI condition variables which are built on top of futexes. =
Be aware that the C
+    library might not implement conditional variables as safe for real-tim=
e. As an alternative, the
+    librtpi library exists to provide a conditional variable implementatio=
n that is correct for
+    real-time applications in Linux.
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
+  RULE =3D always (RT imply (SLEEP imply (RT_FRIENDLY_SLEEP or ALLOWLIST)))
+
+  RT_FRIENDLY_SLEEP =3D (RT_VALID_SLEEP_REASON or KERNEL_THREAD)
+                  and ((not WAKE) until RT_FRIENDLY_WAKE)
+
+  RT_VALID_SLEEP_REASON =3D PI_FUTEX or NANOSLEEP
+
+  RT_FRIENDLY_WAKE =3D WOKEN_BY_EQUAL_OR_HIGHER_PRIO
+                  or WOKEN_BY_HARDIRQ
+                  or WOKEN_BY_NMI
+
+  ALLOWLIST =3D BLOCK_ON_RT_MUTEX
+           or TASK_IS_RCU
+           or TASK_IS_MIGRATION
+           or KTHREAD_SHOULD_STOP
+
+Beside the scenarios described above, this specification also handle some =
special cases:
+
+  - `KERNEL_THREAD`: kernel tasks do not have any pattern that can be reco=
gnized as valid real-time
+    sleeping reasons. Therefore sleeping reason is not checked for kernel =
tasks.
+  - `RT_SLEEP_WHITELIST`: to handle known false positives with kernel task=
s.
+  - `BLOCK_ON_RT_MUTEX` is included in the allowlist due to its implementa=
tion. In the release path
+    of rt_mutex, a boosted task is de-boosted before waking the rt_mutex's=
 waiter. Consequently, the
+    monitor may see a real-time-unsafe wakeup (e.g. non-real-time task wak=
ing real-time task). This
+    is actually real-time-safe because preemption is disable for the durat=
ion.
--=20
2.39.5


