Return-Path: <linux-kernel+bounces-854966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9D3BDFDC0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 035C24F1750
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A763233A01C;
	Wed, 15 Oct 2025 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sbdMrW8S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a2jG27yk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF582FB098
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549369; cv=none; b=JBjxUmWqcdIVk1oNn9o2BigN3pfmxeVWr6oqISoz5uEq6QhGh4Ro0NhHhEWjHJQxXUExWjbQz1X8kiLB1+15Za83b8FsTAsh4kNWC4MaEV18AGHOj0mpwUxHm/x9UA4vID3JWwFataI5ojY0wTnWLSvu29+nLiFQYcMj+3ZakR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549369; c=relaxed/simple;
	bh=7+i2/o5XXjg4l1I1GO7cL8StSLAWeGHhA6Ff7YZNufI=;
	h=Message-ID:From:To:Cc:Subject:Date; b=SQNUR9jXznNqUXkSjRTxtmHx8oVoA8xHcZzBYYZCH4j83fqUp07PDcYwtdKqOTWInaEdES3BqLdo8BfR9bRset5bfVglmI7xxjnq1Tz8Ub9cpJKql2ZLC4Gsl8+uAvSLv3cCXSJSbYSLBC4gat4f/86OUAUgvFfKL+wBL8zZgxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sbdMrW8S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a2jG27yk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251015164952.694882104@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760549364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=2Z1ihAKdjeWD4iqxARINUxJvnnN64IhWtH3SmPXNbIg=;
	b=sbdMrW8SANaZG+s5V16j0O30vuj8sWpcg1mmTjncVyG3wEWHVzYLsUkzQv9oRqyh/NOQeb
	p69HGAQHP3x8DIWVutAsePJo8qDQT/D0vszMqsykh03Sq/WJHa062NCoQk0Ums0Y43Y1zV
	vSL20pRxWHGNjH3pwOwdoxkNmWsZsE5gHyqJbpaUwQnbG5Orc4DNp9Yu2Dul+WoqCklawZ
	UX51BMCsuhvSMmzYzdw5Baqg/Wed4nSsrtht0Rw2PhgDkcSz3/x5oNqUVXNwmdd3avsExV
	JhwIXHI2TUtKRWebVY/LTUYBaGCLtPVCsbEkJCcBqqKcVQiZ4pLsNH2/Q5VQtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760549364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=2Z1ihAKdjeWD4iqxARINUxJvnnN64IhWtH3SmPXNbIg=;
	b=a2jG27ykqCz5BVv6wGK4HrTCUHlk9w4UiaZ1wZoT5g9MM+H2g8Ew8yOPY4oTm22gzk3H3b
	iEFFETXeTI26ewDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>,
 Tim Chen <tim.c.chen@intel.com>,
 TCMalloc Team <tcmalloc-eng@google.com>
Subject: [patch 00/19] sched: Rewrite MM CID management
Date: Wed, 15 Oct 2025 19:29:23 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a follow up on the discussion and initial attempt to address the MM
CID management issues related to the CID space compaction in task work:

    https://lore.kernel.org/20250716160603.138385-8-gmonaco@redhat.com

and my naive way to fix this, which brought parts of the regression back
that caused the current implementation of CID magic:

   https://lore.kernel.org/87tt0k3oks.ffs@tglx

As a couple of people have rightfully pointed out to me that this helps
only in the back to back scheduling case of threads which belong to the
same process (mm), I went back to the drawing board and started over
from a fresh plate and took five steps back.

There are only two set in stone ABI requirements:

  1) It's guaranteed that at no given point in time the same CID is used
     by concurrent tasks in userspace.

  2) The CID space must not exceed the number of possible CPUs in a
     system.

The CID space compaction itself is not a functional correctness
requirement, it is only a useful optimization mechanism to reduce the
memory foot print in unused user space pools.

The optimal CID space is:

    min(nr_tasks, nr_cpus_allowed);

Where @nr_tasks is the number of actual user space threads associated to
the mm.

@nr_cpus_allowed is the superset of all task affinities. It is growth
only as it would be insane to take a racy snapshot of all task
affinities when the affinity of one task changes just do redo it 2
milliseconds later when the next task changes its affinity.

When looking at the current implementation, there are immediately a
couple of obvious problems related to the @nr_tasks and @nr_cpus_allowed
handling.

@nr_tasks is evaluating mm::mm_users, which is the wrong metric because
kernel users which temporarily take a reference on the MM are skewing
the picture. That's easy enough to fix as that can be seperately
accounted for in a mm:mm_cid specific way on fork() and exit().

@nr_cpus_allowed management does way too much useless work for the common
case where a process starts with unrestricted affinity,
i.e. @nr_cpus_allowed is equal to the number of possible CPUs right
away. So obviously this wants to check whether that limit is reached
already and then avoid the whole cpumask update and evaluation.

The update is also called from the wrong place because migrate_disable()
and migrate_enable() related updates are completely irrelevant.
migrate_disable() is restricting the runnable CPUs to the current CPU,
which obviously is in the task's affinity mask at that time.
migrate_enable() restores the actual task affinity, which might have
changed by that time, but that change is already accounted for at that
point.

As @nr_tasks only changes on fork() and exit() and @nr_cpus_allowed only
on affinity changes it's completely bogus to do the

    min(nr_tasks, nr_cpus_allowed);

as a racy snapshot all over the place. This can be done at exactly those
points and the result provided as a non-atomic variable which is not
really subject to frequent changes, while mm::mm_users can be contended
under certain circumstances and workload scenarios.

When observing the current behaviour I also noticed that both the per MM
CID related variables and the per MM CID per CPU variables are subject
to false sharing. Moving them into data structures which are cache line
aligned makes that immediately go away.

So once I established that there are only three events where the
constraints can actually change it became pretty obvious what needs to
be done:

1) As long as the number of tasks is lower or equal than the number
   of CPUs allowed, each task owns a CID. If the number of tasks
   exceeds the number of CPUs allowed it switches to per CPU mode,
   where the CPUs own the CIDs and the tasks borrow them as long
   as they are scheduled in.

2) Account the tasks in fork() and exit() and make the decision
   whether to switch to per CPU mode or back to per task mode.

   If fork() or exit() changes the mode, then that context is the
   obvious candidate to do the fixup work which is required to do a
   mode change.

   While the kernel tries to make fork() as fast as possible, the
   reality is that compared to context switching, task migration and
   return to user space, it is pretty much in the noise when fork()
   has to walk through possible CPUs or through the thread list of a
   process. The same applies for exit().

3) The common fork() case is really fast if there is no mode change
   happening. If the process (MM) is in per task mode it acquires a
   CID and the new task, which is not yet visible owns it. If it's in
   per CPU mode, then nothing to do as the task will borrow the CID
   from the CPU when it becomes runnable.

4) The common exit() case is equally trivial if there is no mode
   change. If the process (MM) is in per task mode the task drops the
   CID and hands it back into the pool. In per CPU mode it does
   nothing because the CPU owns the CID.

5) As a consequence context switching becomes most of the time a very
   trivial sequence of operations.

   The scheduling out task does exactly nothing, which spares access to
   likely cache cold data. The scheduling in task needs to do a little bit
   of work obviously:

     if (!next->mm_cid.active)
        return;

     cpu_cid = __this_cpu_read(mm->mm_cid.pcpu->cid);
     if (unlikely(READ_ONCE(mm->mm_cid.percpu)))
        mm_cid_from_cpu(next, cpu_cid);
     else
        mm_cid_from_task(next, cpu_cid);
   
    mm_cid_from_cpu() does in the common case:

      tcid = next->mm_cid.cid;
      if (likely(cid_on_cpu(cpu_cid & tcid))) {
	 if (likely(cpu_cid_in_range(cpu_cid))) {
	    next->mm_cid.tcid = cpu_cid;
            return;
	 }
      }

    mm_cid_from_task() does in the common case:

     tcid = next->mm_cid.cid;
     if (likely(cid_on_task(tcid | cpu_cid))) {
        if (likely(task_cid_in_range(tcid))) {
           this_cpu_write(next->mm.mm_cid.pcpu.cid, tcid);
           return;
	}
     }

  The common case is almost invisible in perf top with that change.
   
  After some fighting with postgresql I got that sysbench benchmark
  running which caused the current implementation. I don't have the
  expertise to actually evaluate the sysbench output, but looking at
  all those magic numbers this trends upwards in throughput.

  But on a 128 Core (256 threads) machine I clearly can see in perf
  top that __schedule() drops:

  upstream 	+rseq/perf	+cid rework
    0.43%          0.42%          0.30%                [k] __schedule 

  when I run sysbench with 255 threads, which means a total of 256 threads,
  i.e. still in the per task limit on that box. PSQL uses processes for the
  connections which means there is only one user per process. That doesn't
  look a lot, but summed up over millions of operations that accumulates
  pretty fast. There is a way bigger surprise in that benchmark as you will
  see below.

  Of course that does not exercise the switch from task mode to per CPU
  mode and back, but with some artifical test cases which I wrote myself,
  the assumption that the occasional overhead in fork() and exit() does not
  matter at all turns out to be true.


6) Required serialization

  A) The hotpath relevant members of tsk->mm.mm_cid are protected by
     mm::mm_cid::lock a raw spinlock with a minimal hold time even
     for the mode switch case. This lock is also taken in the
     affinity change path.

  B) As the mode changes (ignore affinity increasing @nr_allowed_cpus
     for now) happen in fork() and exit() this obviously requires
     serialization for those. But that serialization wants to be
     separate from the raw spinlock for obvious reasons and is simply
     using a mutex. That's possible because the exit path does not
     rely on sighand lock and the TASK_EXITING state anymore.

     The contention case on that mutex is when there is a scenario where
     really frequent thread creation runs concurrently with frequent thread
     termination. But as the common lock held times are really short and
     both fork() and exit() are subject to lock contention on various
     sleeping locks already, this is the least of my worries.

     The reason why this needs to be serialized is that mode switching
     and the therefore required fixups need to be synchronous from the
     fork()/exit() context point of view in order to maintain the
     completely uncontended fast path in context_switch() and that's
     what really matters.

     So on a mode switch from per task mode to per CPU mode, which can
     only happen on fork(), the task which creates the thread has to
     walk the thread list of the process (MM), which is simple and safe
     because of the per MM serialization through the mutex, which
     prevents it to change in the same way as sighand or tasklist lock.

     The simplified sequence in fork for going to per CPU mode is:

     guard(mutex)(&mm->mm_cid.mutex);
     scoped_guard(raw_spinlock_irq, &mm->mm_cid.lock) {
               mm->mm_cid.users++;
               mode_change = update_constraints(mm);

               if (!mm->mm_cid.percpu)
                   t->mm_cid.cid = mm_get_cid(mm);

	       if (!mode_change)
               	   return;

               if (mm->mm_cid.percpu)
               	   transfer_cid_to_cpu(current);
               else
              	   transfer_cid_to_task(current);
    }
    // mutex stays locked

    Depending on mode, this either walks the possible CPUs and
    transfers/removes ownership from them or walks the thread list
    and transfers ownership to the corresponding CPUs.

    You might ask why that can do both directions as the obvious
    direction in fork() is from per task to per CPU mode as fork()
    increases the number of tasks. But that fork can race with the
    deferred mode switch towards per task caused by a affinity change
    which increased @nr_cpus_allowed. See below.

    That transfer needs obviously to be serialized against context
    switching and that needs runqueue lock, but the hold time of that
    is in both cases minimal:

    In the thread list walk case this does for the transition to CPU
    mode (simplified) for each thread until all thread owned CIDs are
    transferred or the thread list walk terminates:

           // Protects both the task _and_ the per CPU CID store
           // and prevents a concurrent schedule from screwing it up.
           guard(task_rq_lock)(sibling);
           if (!cid_on_task(sibling->mm_cid.cid))
                 continue;

	   if (sibling == task_rq(sibling)->curr) {
                 // Transfer it to the CPU
            	 sibling->mm_cid.cid |= MM_CID_ONCPU;
                 per_cpu(mm->mm_cid.pcpu.cid, task_cpu(sibling)) = sibling->mm_cid.cid;
           } else {
                 // Remove it from the sibling and drop it
                 mm_cid_drop(sibling->mm_cid.cid);
                 sibling->mm_cid.cid = MM_CID_UNSET;
           }

    For the unlikley CLONE_VM case where multiple processes share a MM,
    that's unfortunately not sufficient. In that case it has to walk the
    full tasklist to find all tasks which reference the MM. As this is
    mostly a historical leftover, I'm not using my sleep over that.  As the
    number of users is known the walk can terminated when all tasks have
    been accounted for.

    In the reverse case which is also shared by exit() this walks the
    possible CPUs and does (again simplified):

        pcpu = per_cpu_ptr(mm->mm_cid.pcpu, cpu);

	rq = cpu_rq(cpu);
        // See above ....
        guard(rq_lock_irq)(rq);
        if (!cid_on_cpu(pcp->cid))
               continue;

        if (rq->curr->mm == mm) {
              // Transfer it to rq->curr
              rq->curr->mm_cid.cid = cpu_cid_to_cid(pcp->cid);
              pcpu->cid = rq->curr->mm_cid.cid;
	} else {
             // Remove ownership from the CPU and drop it
             pcp->cid = cpu_cid_to_cid(pcp->cid);
             mm_drop_cid(mm, pcp->cid);
	}

    So the whole point of this exercise is that _all_ other tasks
    related to the MM can freely schedule independent of the mode
    change happening. The only constraint is on fork() vs. exit().

    That puts a constraint on the user count threshold which allows to
    switch back to per task mode. It can't be larger than nr_cpu_ids / 2.
    Otherwise the CID space might become exhausted when tasks are scheduled
    in on CPUs which already transferred ownership before the fixup
    function was able to free or transfer enough CIDs. That would result in
    a live lock because the task loops in mm_get_cid() with runqueue lock
    held and the fixup function is stuck on that runqueue lock.

    A very reasonable limitation in my opinion because the kernel should
    never optimize for user space being careless and just expecting that
    the most insane configurations are magically offering the best results.

 C) The other case is the affinity change when it increases the number of
    allowed CPUs to the point where per CPU mode can be disabled.

    As that happens in the guts of the scheduler with the runqueue lock
    held, there is no way to do any of that sanely. So it is deferred
    first to irq work and then to a regular work, which then does the
    thread/tasklist walk.

    If a fork() or exit() happens before the work runs, the deferred
    operation is taken care of in that context.

    But that's sill using all the same infrastructure and logic without
    affecting the actual context switch path in a noticable way.

 D) Lock order and protection rules

    mm::mm_cid::mutex serializes fork() and exit() and therefore protects
    mm::mm_cid::users.

    mm::mm_cid::lock: serializes mm_update_max_cids() and
    mm_update_cpus_allowed().

    The mm_cidmask bitmap is not protected by any of the mm::mm_cid locks
    and can only be modified with atomic operations.

    The mm::mm_cid:pcpu per CPU storage is protected by the CPUs runqueue
    lock.

    Possible lock nesting
    mm::mm_cid::mutex -> mm::mm_cid::lock
    mm::mm_cid::mutex -> rq::lock
    rq::lock          -> mm::mm_cid::lock


7) CID space consolidation

   If the number of tasks decreases the CID space is consolidated when a
   task schedules in. In the CID on tasks case this means:

     tcid = next->mm_cid.cid;
     if (likely(cid_on_task(tcid | cpu_cid))) {
         if (likely(task_cid_in_range(tcid))) { <- range check fails
             this_cpu_write(next->mm.mm_cid.pcpu.cid, tcid);
             return;
         }
	 // Try to get a lower CID and drop the old one

   In that case it does not matter when a task with a high numbered CID
   sleeps forever because that CID is not visible to user space and when it
   wakes up it will correct it into the then valid range before going back.


8) Concurrency

   Context switch has no real constraints vs. concurrent mode changes
   because the entity which initiates it ensures that the mode change
   operation is finished before the number of users can change again.

   Due to that it does not matter whether mm_cid_schedin() observes the
   correct state of mm::mm_cid::per_cpu or not, which means none of this is
   subject to (memory) ordering constraints outside of those provided by
   rq::lock.


9) Size impact

   text	   data	    bss	    dec	    hex	filename
  62852	  25501	    640	  88993	  15ba1	kernel/sched/core.o - Before
  62316	  25513	    576	  88405	  15955	kernel/sched/core.o - After


10) Test results

   All tests except the malloc benchmark were run with glibc 2.41 as
   provided by Debian 13. It registers rseq unconditionally.

   malloc benchmarks

     I tried https://github.com/f18m/malloc-benchmarks, but that's not even
     producing stable results for repeated runs on the same kernel...

     Then I noticed that neither glibc nor the community tcmalloc nor
     jemalloc use rseq::mm_cid.

     The google tcmalloc code does, but that just does not build without
     trying to debug their bazel java buildsystem monstrosity. So *shrug*

     Which makes me really ask the obvious question why this CID mechanism
     had to be shoved unconditionally into the kernel when there is very
     close to zero usage for it. The proper solution would have been to
     make it opt in with the rseq registration so that it's only used when
     actually required. But that ship has mostly sailed or perhaps not...


   sysbench postgres benchmark

     That's the one which exposed the lock contention in the original MMCID
     implementation and led to the complexity we have today.

     After capping the maximum frequency of my test machine so it stays in
     the thermal limits under load I was able to produce halfways
     reproducible results with a low single digit standard deviation,
     except for the number of CPU migrations which vary widely.

   	         transactions/sec	 queries/sec
     v6.17	      89024.34		 1424389.43
     +rseq/perf	     102123.97		 1633984.04	+14.7%
     +cid rework     105239.86		 1683837.80	 +3.1%

     I triple checked the upstream vs. rseq/perf numbers because I couldn't
     believe them on first sight. They stayed that way. perf does not give an
     obvious explanation, but enabling the lightweight counters from the
     rseq/perf branch shows:

     exit:          666811173
     signal:             2243
     slowp:         198556051	// TIF_NOTIFY_RESUME	30% of all exits
     ids:           198408670
     cs:            198408670
     clear:         198408670
     fixup:                 0

     versus rseq/perf:

     exit:          797571142				
     signal:             2262	
     slowp:              1908	// TIF_NOTIFY_RESUME    ~0%
     fastp:           1991494	// TIF_RSEQ		 0.25% of all exits
     ids:             1864356
     cs:                    0
     clear:                 0
     fixup:                 0

     While perf top does not really notice as there is more noise going on
     in the system, this simply adds up pretty fast. Assuming 50
     instructions per rseq update on exit adds up to ~6 seconds of time on
     that machine. Take the corresponding exits of the psql workers into
     account and it gets pretty close to the loss projected on the full 60
     seconds runtime of the benchmark: 60s * 0.147 = 8.82s

     I really need to sit down now and get this rseq rewrite sorted, but it
     seems that everything related to it is amazingly efficient.


   Thread create teardown

     I wrote a micro benchmark, which spawns pools which each create
     threads and let the threads die after creation. The 32 pools/ 32
     threads case triggers the ownership mode change case in both
     directions. The source is appended at the end of this mail.

     I initialy wrote it to stress the mode change mechanics, but then I
     noticed the massive difference when I ran it on upstream:

		8 pools / 8 threads	32 pools / 32 threads

     v6.17	  23666 thr/sec	       16161 thr/sec
     +rseq/perf	  23656 thr/sec	 0%    16196 thr/sec	 0%	
     +cid rework  32025 thr/sec	 +35%  21004 thr/sec	+30%

     Both v6.17 and v6.17 + rseq/perf show this in perf top:

      14.62%  [kernel]     [k] update_sd_lb_stats.constprop.0
      13.08%  [kernel]     [k] native_queued_spin_lock_slowpath
       4.66%  [kernel]     [k] osq_lock
       3.06%  [kernel]     [k] _find_next_and_bit
       2.21%  [kernel]     [k] __schedule
       2.16%  [kernel]     [k] sched_balance_rq

    with the CID rewrite this becomes:

     13.48%  [kernel]      [k] native_queued_spin_lock_slowpath
      8.98%  [kernel]      [k] update_sd_lb_stats.constprop.0
      5.16%  [kernel]      [k] osq_lock
      2.28%  [kernel]      [k] _find_next_and_bit
      2.11%  [kernel]      [k] __schedule
      1.75%  [kernel]      [k] psi_group_change
      ...
      1.32%  [kernel]      [k] sched_balance_rq

   I haven't been able to understand that massive difference yet.


The following series rewrites MM CID management as outlined above. After
trying to gradually rework the upstream implementation which ended up in
uncomprehensible patches, I more or less reverted the complex CID
management and switched back to the simple set/clear bit approach in
context_switch(). That let me gradually work towards the final solution in
a hopefully comprehensible way. The actual revert at the beginning does not
qualify obviously.

The series is based on the V4 series of the rseq rewrite:

    https://lore.kernel.org/20250908212737.353775467@linutronix.de

which is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/perf

That branch is now rebased on v6.17 to have a sane base point.

The series on top of the rseq/perf branch is available from git as well:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/cid

While this is slightly more code than the naive solution, this still
removes more code than it adds. See below.

Further testing required

As there is no ready to use benchmark for MM CID this really needs to be
tested by those people who use it and can actually build their stuff.

The other benchmarks like sysbench etc. want to be run by people who
actually know how to do proper benchmarking and have automated test rigs at
their hand.

It would be helpful to have results based on v6.17, the rseq/perf branch
and the rseq/cid branch of my devel repository. See links above.

Thanks,

	tglx
---
 include/linux/bitmap.h     |   15 +
 include/linux/cpumask.h    |   16 +
 include/linux/mm_types.h   |  125 ---------
 include/linux/rseq.h       |    8 
 include/linux/rseq_types.h |   54 ++++
 include/linux/sched.h      |   19 -
 init/init_task.c           |    3 
 kernel/exit.c              |    1 
 kernel/fork.c              |    8 
 kernel/sched/core.c        |  582 +++++++--------------------------------------
 kernel/sched/sched.h       |  426 +++++++++++++++-----------------
 kernel/signal.c            |    2 
 lib/bitmap.c               |   17 +
 13 files changed, 426 insertions(+), 850 deletions(-)
---
#include <errno.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>
#include <sys/sysinfo.h>

struct threadarg {
	pthread_mutex_t	mut;
	pthread_cond_t	cond;
	unsigned int	cnt;
	unsigned int	die;
	unsigned int	step;
	unsigned int	timeout;
	unsigned int	fail;
	unsigned int	create;
	unsigned long	tcreate;
};

static int num_threads = 8;
static int num_pools = 8;

static void *tfn(void *arg)
{
	struct threadarg *ta = arg;

	pthread_mutex_lock(&ta->mut);
	ta->cnt++;
	pthread_cond_broadcast(&ta->cond);
	while (!ta->die)
		pthread_cond_wait(&ta->cond, &ta->mut);
	ta->die--;
	ta->cnt--;
	pthread_cond_broadcast(&ta->cond);
	pthread_mutex_unlock(&ta->mut);
	return NULL;
}

static void *poolfn(void *arg)
{
	struct threadarg *ta = arg;

	while (1) {
		unsigned int threads = 0;
		pthread_t t;

		for (int i = 0; i < num_threads; i++) {
			struct timespec st, end;

			clock_gettime(CLOCK_MONOTONIC, &st);

			if (!pthread_create(&t, NULL, tfn, ta)) {
				clock_gettime(CLOCK_MONOTONIC, &end);

				pthread_detach(t);
				ta->step++;
				ta->create++;
				threads++;

				unsigned long s = st.tv_sec * 1000000000UL + st.tv_nsec;
				unsigned long e = end.tv_sec * 1000000000UL + end.tv_nsec;
				ta->tcreate += e - s;
			} else {
				ta->fail++;
			}
		}

		pthread_mutex_lock(&ta->mut);
		ta->step = 1000;
		while (ta->cnt < threads) {
			struct timespec to;

			clock_gettime(CLOCK_REALTIME, &to);
			to.tv_sec++;

			int r = pthread_cond_timedwait(&ta->cond, &ta->mut, &to);

			switch (r) {
			case ETIMEDOUT:
				ta->timeout++;
			case EINTR:
				pthread_cond_broadcast(&ta->cond);
				break;
			default:
				ta->step++;
			}
		}
		ta->step = 2000;
		ta->die = threads;
		pthread_cond_broadcast(&ta->cond);
		while (ta->cnt > 0) {
			pthread_cond_wait(&ta->cond, &ta->mut);
			ta->step++;
		}
		pthread_mutex_unlock(&ta->mut);
		ta->step = 0;
	}
	return NULL;
}

static struct threadarg targs[1024];

static void __sigfun(unsigned int secs)
{
	unsigned long tot = 0;

	if (secs) {
		for (int i = 0; i < num_pools; i++)
			tot += targs[i].create;
		printf("%8u %16lu %lu / sec\n", secs, tot, tot / secs);
	}

	printf("    Step     Cnt     Die    Tout  Create    Fail Tcreate\n");
	for (int i = 0; i < num_pools; i++) {
		printf("%8u%8u%8u%8u%8u%8u%16lu\n", targs[i].step, targs[i].cnt,
		       targs[i].die, targs[i].timeout, targs[i].create,
		       targs[i].fail, targs[i].tcreate / targs[i].create);
	}
}

static void sigfun(int sig)
{
	__sigfun(0);
}

int main(int argc, char *argv[])
{
	pthread_t t;
	int opt;

	while ((opt = getopt(argc, argv, "p:t:")) != -1) {
		switch (opt) {
		case 'p':
			num_pools = atoi(optarg);
			break;
		case 't':
			num_threads = atoi(optarg);
			break;
		default: /* '?'	 */
			fprintf(stderr, "Usage: %s [-p pools] [-t] threads\n",
				argv[0]);
			exit(1);
		}
	}

	signal(SIGUSR1, sigfun);

	for (int i = 0; i < num_pools; i++) {
		targs[i] = (struct threadarg) {
			.mut  = PTHREAD_MUTEX_INITIALIZER,
			.cond = PTHREAD_COND_INITIALIZER,
		};

		pthread_create(&t, NULL, poolfn, &targs[i]);
	}

	unsigned int strt = time(NULL);
	for (;;) {
		sleep(10);
		__sigfun(time(NULL) - strt);
	}

	return 0;
}


