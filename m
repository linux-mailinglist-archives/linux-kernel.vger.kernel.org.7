Return-Path: <linux-kernel+bounces-796488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E74B40145
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52B41B61057
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03782D9EE2;
	Tue,  2 Sep 2025 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLpTS3WF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1F02D9ECA;
	Tue,  2 Sep 2025 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817442; cv=none; b=NfX5XGlmjw8ImPEGjhg1GI82p2nPb7tzWXZ9l79eQNkuB5rK5y7akItrnPV1TfQ9ifgEXOooVymi3xWPW4hnVrMK+GZ54QH4SwvI9DaqHIxt/rZWsbDrYWWw2q41bpvr1pNbs+UQdbromd7vTZLeDVORPpbV7jo2G2kpVCUaGjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817442; c=relaxed/simple;
	bh=WhaMkkgkoFeMb9qsdVyBs9ZfWhMHeeDVSv/bjPnmM9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=De9MHzLwpUjwANY7fiwLmmdzwC+rzeAbPJon9zrSuC8xOTzUpYPM83TefPzm5xPGUrskZ/ZdVBqFdX7/AJGLHxPEwkywILNePXsT7HKrWgvzhb6ez3bN117wBmQdEsTPnxA9dsUedo1f5LbxOofMnl2W6lglXVQ5wqCXMTkisbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLpTS3WF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736E9C4CEF5;
	Tue,  2 Sep 2025 12:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756817441;
	bh=WhaMkkgkoFeMb9qsdVyBs9ZfWhMHeeDVSv/bjPnmM9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLpTS3WFolxyUE1dGsWYAtX+62arrpBv52s63lSEEgPz0NKMQuq/zadLtaz61ew4m
	 WkmFaxpROXnTG+qexVn7JHZSvi1dxX7lYhph4iQn0UbICxGYKsWF7d3VZK9j5JeSEU
	 lrjgxbVPAeaGrsFk2eua1+YHcv9rPamcf5QHag01DPyZ1Fx0WuNkf7fB4xcGU/bLfW
	 5AfK6bSmiyf8fpO4lwZq76g8KAR8KwLQxAZmvk2SSntwktwFg7ahLu9cWH3WJW6c90
	 UPSIr/nwoab2GWgGPO9WPLXusmR7nSUSeZj+n1ii2MDnSxrGMRYH4I7zfEg4vR4Qow
	 OX/rLjpxlR2nw==
Date: Tue, 2 Sep 2025 14:50:39 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc: Add CPU Isolation documentation
Message-ID: <aLboH4AKMVLBNKaf@localhost.localdomain>
References: <20250809094247.8384-1-frederic@kernel.org>
 <aJcrzjAz6VafUsqz@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJcrzjAz6VafUsqz@archie.me>

Le Sat, Aug 09, 2025 at 06:06:54PM +0700, Bagas Sanjaya a écrit :
> On Sat, Aug 09, 2025 at 11:42:47AM +0200, Frederic Weisbecker wrote:
> > +- :ref:`Documentation/admin-guide/cgroup-v2.rst <Cpuset v2 "isolated"
> > +  partitions>`
> > +  are recommended because they are tunable at runtime.
> 
> Anchor link target and name are mistakenly swapped so I have to correct them
> back to their appropriate places:
> 
> ---- >8 ----
> diff --git a/Documentation/admin-guide/cpu-isolation.rst b/Documentation/admin-guide/cpu-isolation.rst
> index 250027acf7b26f..aef0b53b0ad5e6 100644
> --- a/Documentation/admin-guide/cpu-isolation.rst
> +++ b/Documentation/admin-guide/cpu-isolation.rst
> @@ -107,9 +107,8 @@ are extracted from the global load balancing.
>  Interface
>  ~~~~~~~~~
>  
> -- :ref:`Documentation/admin-guide/cgroup-v2.rst <Cpuset v2 "isolated"
> -  partitions>`
> -  are recommended because they are tunable at runtime.
> +- :doc:`cgroup cpuset isolated partitions <cgroup-v2>` are recommended because
> +  they are tunable at runtime.
>  
>  - The 'isolcpus=' kernel boot parameter with the 'domain' flag is a
>    less flexible alternative that doesn't allow for runtime
> @@ -124,7 +123,8 @@ target CPUs.
>  Interface
>  ~~~~~~~~~
>  
> -- /proc/irq/*/smp_affinity as explained :ref:`Documentation/core-api/irq/irq-affinity.rst <here>` in detail.
> +- /proc/irq/\*/smp_affinity as explained in
> +  Documentation/core-api/irq/irq-affinity.rst.
>  
>  - The "irqaffinity=" kernel boot parameter for a default setting.
>  
> @@ -330,9 +330,8 @@ retained when that happens.
>  
>  Some tools may also be useful for higher level analysis:
>  
> -- :ref:`Documentation/tools/rtla/rtla-osnoise.rst <rtla-osnoise>` runs a kernel
> -  tracer that analyzes and output a
> -  summary of the noises.
> +- :doc:`rtla-osnoise </tools/rtla/rtla-osnoise>` runs a kernel tracer that
> +  analyzes and output a summary of the noises.
>  
>  - dynticks-testing does something similar but in userspace. It is available
>    at git://git.kernel.org/pub/scm/linux/kernel/git/frederic/dynticks-testing.git
> 
> > +The full command line is then:
> > +
> > +  nohz_full=7 irqaffinity=0-6 isolcpus=managed_irq,7 nosmt
> > +
> > +CPUSET configuration (cgroup v2)
> > +--------------------------------
> > +
> > +Assuming cgroup v2 is mounted to /sys/fs/cgroup, the following script
> > +isolates CPU 7 from scheduler domains.
> > +
> > +  cd /sys/fs/cgroup
> > +  # Activate the cpuset subsystem
> > +  echo +cpuset > cgroup.subtree_control
> > +  # Create partition to be isolated
> > +  mkdir test
> > +  cd test
> > +  echo +cpuset > cgroup.subtree_control
> > +  # Isolate CPU 7
> > +  echo 7 > cpuset.cpus
> > +  echo "isolated" > cpuset.cpus.partition
> > +
> > +The userspace workload
> > +----------------------
> > +
> > +Fake a pure userspace workload, the below program runs a dummy
> > +userspace loop on the isolated CPU 7.
> > +
> > +  #include <stdio.h>
> > +  #include <fcntl.h>
> > +  #include <unistd.h>
> > +  #include <errno.h>
> > +  int main(void)
> > +  {
> > +  	// Move the current task to the isolated cpuset (bind to CPU 7)
> > +  	int fd = open("/sys/fs/cgroup/test/cgroup.procs", O_WRONLY);
> > +  	if (fd < 0) {
> > +  		perror("Can't open cpuset file...\n");
> > +  		return 0;
> > +  	}
> > +
> > +  	write(fd, "0\n", 2);
> > +  	close(fd);
> > +
> > +  	// Run an endless dummy loop until the launcher kills us
> > +  	while (1)
> > +  	;
> > +
> > +  	return 0;
> > +  }
> > +
> > +Build it and save for later step:
> > +
> > +  # gcc user_loop.c -o user_loop
> > +
> > +The launcher
> > +------------
> > +
> > +The below launcher runs the above program for 10 seconds and traces
> > +the noise resulting from preempting tasks and IRQs.
> > +
> > +  TRACING=/sys/kernel/tracing/
> > +  # Make sure tracing is off for now
> > +  echo 0 > $TRACING/tracing_on
> > +  # Flush previous traces
> > +  echo > $TRACING/trace
> > +  # Record disturbance from other tasks
> > +  echo 1 > $TRACING/events/sched/sched_switch/enable
> > +  # Record disturbance from interrupts
> > +  echo 1 > $TRACING/events/irq_vectors/enable
> > +  # Now we can start tracing
> > +  echo 1 > $TRACING/tracing_on
> > +  # Run the dummy user_loop for 10 seconds on CPU 7
> > +  ./user_loop &
> > +  USER_LOOP_PID=$!
> > +  sleep 10
> > +  kill $USER_LOOP_PID
> > +  # Disable tracing and save traces from CPU 7 in a file
> > +  echo 0 > $TRACING/tracing_on
> > +  cat $TRACING/per_cpu/cpu7/trace > trace.7
> > +
> > +If no specific problem arose, the output of trace.7 should look like
> > +the following:
> > +
> > +  <idle>-0 [007] d..2. 1980.976624: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=user_loop next_pid=1553 next_prio=120
> > +  user_loop-1553 [007] d.h.. 1990.946593: reschedule_entry: vector=253
> > +  user_loop-1553 [007] d.h.. 1990.946593: reschedule_exit: vector=253
> 
> Wrap these snippets above in literal code blocks.
> 
> Thanks.


Thanks, I'll do these modifications. I had a hard time building the
documentation (still haven't managed so far) so I missed the actual
rendering. Hopefully I'll figure it out at some point.

-- 
Frederic Weisbecker
SUSE Labs

