Return-Path: <linux-kernel+bounces-761057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F50FB1F3D0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F00E5632EA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB5323D287;
	Sat,  9 Aug 2025 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZhklySx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC96241114;
	Sat,  9 Aug 2025 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754732576; cv=none; b=UmDv5c26rWoqrBd+yupvqKdqtXgiF2t5JgxX5e43lbpk2cQZ/sF49djYZdH1Dv0B9gG39rhTh/hcq4Kw4fGLtTyuaqbzxa8jUWqqtA41kf1NtYReqMc8/ZUfFz46aPW4+47R1uf9ZCJKUP2cknjiT9CJN48pY1LLaXHEKhDe2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754732576; c=relaxed/simple;
	bh=3VHE2B0l2Q90/ed5gALWvq6pSkiRJCQYOUx232VRNPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YGAUecnnTyXRDIs4mTXZw44maaluv44XZYWGgLIPypy+7No+Yqj9rdwupw97O+zQXe34v9BvanqdMPezs+o42o97ZJf5Q3F6G/Uxx2ccAEdqmZ0YjQGtVQBLIpDTgotCr+lEhCfAi+Dy/3qNkOxH7CMQFOmB7RwQFEO3LFl8ga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZhklySx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17C9C4CEE7;
	Sat,  9 Aug 2025 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754732575;
	bh=3VHE2B0l2Q90/ed5gALWvq6pSkiRJCQYOUx232VRNPs=;
	h=From:To:Cc:Subject:Date:From;
	b=lZhklySxjgEYlC0qHipBextwx/4FwvYnf2XeDrbjLmoJBKJcmuWyA000lTE3YEuYQ
	 ONkcPM8uKZVG6LD9YoXJK39NGBQHqafTT+irDiJ8+5UVJActMTRpj1LNQJCvFVYpKB
	 sTU3g0YpiUPLIvK89Serw2M9GxjWyFMLwnJBHY+Oh+yw5yXwv9AFbNSByq7b5kO6WD
	 k2Y6gUZjGnrI1VOvLV1aoE+zlOG2Q9L5baU6o0vkYG3MalLVAYtlYE9sz+FKkj9Sl/
	 aQxWKlbSCvdeCc6goz7T+XSKPe27Ld5PCakFoBgvS0Lr2r2mf0gTQSccpiFdNUIA/d
	 5ObM0d2x7UvLA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH] doc: Add CPU Isolation documentation
Date: Sat,  9 Aug 2025 11:42:47 +0200
Message-ID: <20250809094247.8384-1-frederic@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nohz_full was introduced in v3.10 in 2013, which means this
documentation is overdue for 12 years.

The shoemaker's children always go barefoot. And working on timers
hasn't made me arriving on time either.

Fortunately Paul wrote a part of the needed documentation a while ago,
especially concerning nohz_full in Documentation/timers/no_hz.rst and
also about per-CPU kthreads in
Documentation/admin-guide/kernel-per-CPU-kthreads.rst

Introduce a new page that gives an overview of CPU isolation in general.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 Documentation/admin-guide/cpu-isolation.rst | 338 ++++++++++++++++++++
 Documentation/admin-guide/index.rst         |   1 +
 2 files changed, 339 insertions(+)
 create mode 100644 Documentation/admin-guide/cpu-isolation.rst

diff --git a/Documentation/admin-guide/cpu-isolation.rst b/Documentation/admin-guide/cpu-isolation.rst
new file mode 100644
index 000000000000..250027acf7b2
--- /dev/null
+++ b/Documentation/admin-guide/cpu-isolation.rst
@@ -0,0 +1,338 @@
+=============
+CPU Isolation
+=============
+
+Introduction
+============
+
+"CPU Isolation" means leaving a CPU exclusive to a given userspace
+workload without any undesired code interference from the kernel.
+
+Those interferences, commonly pointed out as "noise", can be triggered
+by asynchronous events (interrupts, timers, scheduler preemption by
+workqueues and kthreads, ...) or synchronous events (syscalls and page
+faults).
+
+Such noise usually goes unnoticed. After all synchronous events are a
+component of the requested kernel service. And asynchronous events are
+either sufficiently well distributed by the scheduler when executed
+as tasks or reasonably fast when executed as interrupt. The timer
+interrupt can even execute 1024 times per seconds without
+significantly measurable impact most of the time.
+
+However some rare and extreme workloads can be quite sensitive to
+those kinds of noise. This is the case, for example, with high
+bandwidth network processing that can't afford losing a single packet
+or very low latency network processing. Typically those usecases
+involve DPDK, bypassing the kernel networking stack and performing
+direct access to the networking device from userscace.
+
+In order to run a CPU without or with limited kernel noise, the
+related housekeeping work needs to be either shutdown, migrated or
+offloaded.
+
+Housekeeping
+============
+
+In the CPU isolation terminology, housekeeping is the work, often
+asynchronous, that the kernel needs to process in order to maintain
+all its services. It matches the noises and disturbances enumerated
+above except when at least one CPU is isolated. Then housekeeping may
+make use of further coping mechanisms if CPU-tied work must be
+offloaded.
+
+Housekeeping CPUs are the non-isolated CPUs where the kernel noise
+is moved away from isolated CPUs.
+
+The isolation can be implemented in several ways depending on the
+nature of the noise:
+
+- Unbound work, where "unbound" means not tied to any CPU, can be
+  simply migrated away from isolated CPUs to housekeeping CPUs.
+  This is the case of unbound workqueues, kthreads and timers.
+
+- Bound work, where "bound" means tied to a specific CPU, usually
+  can't be moved away as-is by nature. Either:
+
+	- The work must switch to a locked implementation. Eg: This is
+	  the case of RCU with CONFIG_RCU_NOCB_CPU.
+
+	- The related feature must be shutdown and considered
+	  incompatible with isolated CPUs. Eg: Lockup watchdog,
+	  unreliable clocksources, etc...
+
+	- An elaborated and heavyweight coping mechanism stands as a
+	  replacement. Eg: the timer tick is shutdown on nohz_full but
+	  with the constraint of running a single task on the CPU. A
+	  significant cost penalty is added on kernel entry/exit and
+	  a residual 1Hz scheduler tick is offloaded to housekeeping
+	  CPUs.
+
+In any case, housekeeping work has to be handled, which is why there
+must be at least one housekeeping CPU in the system, preferrably more
+if the machine runs a lot of CPUs. For example one per node on NUMA
+systems.
+
+Also CPU isolation often means a tradeoff between noise-free isolated
+CPUs and added overhead on housekeeping CPUs, sometimes even on
+isolated CPUs entering the kernel.
+
+Isolation features
+==================
+
+Different levels of isolation can be configured in the kernel, each of
+which having their own drawbacks and tradeoffs.
+
+Scheduler domain isolation
+--------------------------
+
+This feature isolates a CPU from the scheduler topology. As a result,
+the target isn't part of the load balancing. Tasks won't migrate
+neither from nor to it unless affine explicitly.
+
+As a side effect the CPU is also isolated from unbound workqueues and
+unbound kthreads.
+
+Requirements
+~~~~~~~~~~~~
+
+- CONFIG_CPUSETS=y for the cpusets based interface
+
+Tradeoffs
+~~~~~~~~~
+
+By nature, the system load is overall less distributed since some CPUs
+are extracted from the global load balancing.
+
+Interface
+~~~~~~~~~
+
+- :ref:`Documentation/admin-guide/cgroup-v2.rst <Cpuset v2 "isolated"
+  partitions>`
+  are recommended because they are tunable at runtime.
+
+- The 'isolcpus=' kernel boot parameter with the 'domain' flag is a
+  less flexible alternative that doesn't allow for runtime
+  reconfiguration.
+
+IRQs isolation
+--------------
+
+Isolate the IRQs whenever possible, so that they don't fire on the
+target CPUs.
+
+Interface
+~~~~~~~~~
+
+- /proc/irq/*/smp_affinity as explained :ref:`Documentation/core-api/irq/irq-affinity.rst <here>` in detail.
+
+- The "irqaffinity=" kernel boot parameter for a default setting.
+
+- The "managed_irq" flag in the "isolcpus=" kernel boot parameter
+  tries a best effort affinity override for managed IRQs.
+
+Full Dynticks (aka nohz_full)
+-----------------------------
+
+Full dynticks extends the dynticks idle mode, which stop the tick when
+the CPU is idle, to CPUs running a single task in userspace. That is,
+the timer tick is stopped if the environment allows it.
+
+Global timer callbacks are also isolated from the nohz_full CPUs.
+
+Requirements
+~~~~~~~~~~~~
+
+- CONFIG_NO_HZ_FULL=y
+
+Constraints
+~~~~~~~~~~~
+
+- The isolated CPUs must run a single task only. Multitask requires
+  the tick to maintain preemption. This is usually fine since the
+  workload usually can't stand the latency of random context switches.
+
+- No call to the kernel from isolated CPUs, at the risk of triggering
+  random noise.
+
+- No use of posix CPU timers on isolated CPUs.
+
+- Architecture must have a stable and reliable clocksource (no
+  unreliable TSC that requires the watchdog).
+
+
+Tradeoffs
+~~~~~~~~~
+
+In terms of cost, this is the most invasive isolation feature. It is
+assumed to be used when the workload spends most of its time in
+userspace and doesn't rely on the kernel except for preparatory
+work because:
+
+- RCU is slower due to the locked, offloaded and threaded callbacks
+  processing (the same that would be obtained with "rcu_nocb=" boot
+  parameter).
+
+- Kernel entry/exit through syscalls, exceptions and IRQs are more
+  costly due to fully ordered RmW operations that maintain userspace
+  as RCU extended quiescent state. Also the CPU time is accounted on
+  kernel boundaries instead of periodically from the tick.
+
+- Housekeeping CPUs must run a 1Hz residual remote scheduler tick
+  on behalf of the isolated CPUs.
+
+Checklist
+=========
+
+You have set up each of the above isolation features but you still
+observe jitters that trash your workload? Make sure to check a few
+elements before proceeding.
+
+Some of these checklist items are similar to those of real time
+workloads:
+
+- Use mlock() to prevent your pages from being swapped away. Page
+  faults are usually not compatible with jitter sensitive workloads.
+
+- Avoid SMT to prevent your hardware thread from being "preempted"
+  by another one.
+
+- CPU frequency changes may induce subtle sorts of jitter in a
+  workload. Cpufreq should be used and tuned with caution.
+
+- Deep C-states may result in latency issues upon wake-up. If this
+  happens to be a problem, C-states can be limited via kernel boot
+  parameters such as processor.max_cstate or intel_idle.max_cstate.
+
+
+Full isolation example
+======================
+
+In this example, the system has 8 CPUs and the 8th is to be fully
+isolated. Since CPUs start from 0, the 8th CPU is CPU 7.
+
+Kernel parameters
+-----------------
+
+Set the following kernel boot parameters to disable SMT and setup tick
+and IRQ isolation:
+
+- Full dynticks: nohz_full=7
+
+- IRQs isolation: irqaffinity=0-6
+
+- Managed IRQs isolation: isolcpus=managed_irq,7
+
+- Prevent from SMT: nosmt
+
+The full command line is then:
+
+  nohz_full=7 irqaffinity=0-6 isolcpus=managed_irq,7 nosmt
+
+CPUSET configuration (cgroup v2)
+--------------------------------
+
+Assuming cgroup v2 is mounted to /sys/fs/cgroup, the following script
+isolates CPU 7 from scheduler domains.
+
+  cd /sys/fs/cgroup
+  # Activate the cpuset subsystem
+  echo +cpuset > cgroup.subtree_control
+  # Create partition to be isolated
+  mkdir test
+  cd test
+  echo +cpuset > cgroup.subtree_control
+  # Isolate CPU 7
+  echo 7 > cpuset.cpus
+  echo "isolated" > cpuset.cpus.partition
+
+The userspace workload
+----------------------
+
+Fake a pure userspace workload, the below program runs a dummy
+userspace loop on the isolated CPU 7.
+
+  #include <stdio.h>
+  #include <fcntl.h>
+  #include <unistd.h>
+  #include <errno.h>
+  int main(void)
+  {
+  	// Move the current task to the isolated cpuset (bind to CPU 7)
+  	int fd = open("/sys/fs/cgroup/test/cgroup.procs", O_WRONLY);
+  	if (fd < 0) {
+  		perror("Can't open cpuset file...\n");
+  		return 0;
+  	}
+
+  	write(fd, "0\n", 2);
+  	close(fd);
+
+  	// Run an endless dummy loop until the launcher kills us
+  	while (1)
+  	;
+
+  	return 0;
+  }
+
+Build it and save for later step:
+
+  # gcc user_loop.c -o user_loop
+
+The launcher
+------------
+
+The below launcher runs the above program for 10 seconds and traces
+the noise resulting from preempting tasks and IRQs.
+
+  TRACING=/sys/kernel/tracing/
+  # Make sure tracing is off for now
+  echo 0 > $TRACING/tracing_on
+  # Flush previous traces
+  echo > $TRACING/trace
+  # Record disturbance from other tasks
+  echo 1 > $TRACING/events/sched/sched_switch/enable
+  # Record disturbance from interrupts
+  echo 1 > $TRACING/events/irq_vectors/enable
+  # Now we can start tracing
+  echo 1 > $TRACING/tracing_on
+  # Run the dummy user_loop for 10 seconds on CPU 7
+  ./user_loop &
+  USER_LOOP_PID=$!
+  sleep 10
+  kill $USER_LOOP_PID
+  # Disable tracing and save traces from CPU 7 in a file
+  echo 0 > $TRACING/tracing_on
+  cat $TRACING/per_cpu/cpu7/trace > trace.7
+
+If no specific problem arose, the output of trace.7 should look like
+the following:
+
+  <idle>-0 [007] d..2. 1980.976624: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=user_loop next_pid=1553 next_prio=120
+  user_loop-1553 [007] d.h.. 1990.946593: reschedule_entry: vector=253
+  user_loop-1553 [007] d.h.. 1990.946593: reschedule_exit: vector=253
+
+That is, no specific noise triggered between the first trace and the
+second during 10 seconds when user_loop was running.
+
+Debugging
+=========
+
+Of course things are never so easy, especially on this matter.
+Chances are that actual noise will be observed in the aforementioned
+trace.7 file.
+
+The best way to investigate further is to enable finer grained
+tracepoints such as those of subsystems producing asynchronous
+events: workqueue, timer, irq_vector, etc... It also can be
+interesting to enable the tick_stop event to diagnose why the tick is
+retained when that happens.
+
+Some tools may also be useful for higher level analysis:
+
+- :ref:`Documentation/tools/rtla/rtla-osnoise.rst <rtla-osnoise>` runs a kernel
+  tracer that analyzes and output a
+  summary of the noises.
+
+- dynticks-testing does something similar but in userspace. It is available
+  at git://git.kernel.org/pub/scm/linux/kernel/git/frederic/dynticks-testing.git
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 259d79fbeb94..b5f1fc7d5290 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -94,6 +94,7 @@ likely to be of interest on almost any system.
 
    cgroup-v2
    cgroup-v1/index
+   cpu-isolation
    cpu-load
    mm/index
    module-signing
-- 
2.50.1


