Return-Path: <linux-kernel+bounces-761093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79405B1F44D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 13:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8083A7C0B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 11:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0347426D4C6;
	Sat,  9 Aug 2025 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlVUzisE"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363F23A997;
	Sat,  9 Aug 2025 11:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754737622; cv=none; b=tas4iuFiVywQCwA/nH6gfM8R73HbaIVAAPQ+pKfPOcshaM/d4WmiecXgxBE772SQ7sR/cW6OySgCqfE09U/k9wBqaHom8KRi9pZoCwW3ozkRxliIosl61ApbS+ja2E4nNPHdKFrUtNILNBVlnGJQ+jl969xSmZI443/hw6sdlZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754737622; c=relaxed/simple;
	bh=ZBcYuR/xm1+lIvVeKv3aI9vAQBS14fd9bGqcy9Y50PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxFEOMTzWtL+PMIARAoGF1mO3gh5+sbdHlJTVHWTaMffnB8C/eyAqBc48bQ/gXdbQ55icng/VTAnQS4TT0VwP9NZ/8j8h5srzCgAJyOkL//vN3UjWaU5zfNeR/XylT+5itLtd/L8X7aemgR6x+mCvX2lM6yewJzbTLO9c6CoZxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlVUzisE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2400f746440so24312615ad.2;
        Sat, 09 Aug 2025 04:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754737620; x=1755342420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=igQD9HRickPK424NYLGsoc2YBXM4LFFhbjaNF8EPVWY=;
        b=QlVUzisE2tXlqIRL3VrcAElbXccQuTOb2k3Nj6CCAdn7/SGcwoYPiMHml8rMCvwNxA
         a0WM1yYv1CQ4BreMM0Zm5cIRGnJsumuCeKcZQd9hgnooyXoKRCdcQGBvQD/1iMujNgSk
         dQix5Juh45CWXjoRBpWJx+OF3oML4ta4yByDkL+X3EOA9IYyckdwtg4bHhYwrxQ7uf4q
         helgMfM7XHcTJguY9cLg2PVZVN68pUCscHcAYlm26TdwUHYuwK2tWWa7w/+ifAxdphsa
         5M5B8GuURoqwy+024QGvB5BrZIi2kGS9/G7KbTWtXdtrmb4BY8YuaLXJVWo5wU2QKoQD
         4rKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754737620; x=1755342420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igQD9HRickPK424NYLGsoc2YBXM4LFFhbjaNF8EPVWY=;
        b=CnY3nJBOoA0RKyL/BQGmJX2Li2Cd6qRxbDezOgeeYpvjiPLQD20z9WSBghzaKKHkKP
         V5Dup9KPYu5gm4p+nOoB33gSRuJLEgqWcMqyX79itp844BHmH+eJaoHrTESVMu3HtzBW
         NOjR2b8gTBhJRwnL26T4KciclWOTb1MsZXqR9OrZsIWUrcUaThpkeGDNnri7r/SG1VAg
         O4VBJk1OZkBPorBge6pNfhd6+LjzC9p0SpE4T9k9p1C1HnHBTJEQU7f+VKW6DJv1wjak
         8oDy9lZstPY7oS0kG5jPfoAjSTSfehVUVwKAQ8siJIeBfBQDdlVgXrfS51NeqGBY8KwI
         qbuA==
X-Forwarded-Encrypted: i=1; AJvYcCUMv9J109lCVTkHfOCUaHMjJztoneiMp+gCIhrc70OVsfSGORGYGEIDfZuOp3Gehe/K9U0HwtL2wqwb8rpz@vger.kernel.org, AJvYcCXQe1G1xJMIJahXdZXONgHqnHtIxcQJIdk0UX/kgDk38IIZZ3fWEudpo7FLMqWD3FbLvUMSzKcEQSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ/aqJ1ehYkBj+fhYWm4rwTuAlzkKxB115espbnfICySH13xfV
	gzX9YS2S1aORJIOeoBWKi7naxKIQm3rFAvXEzxfLEJcA9geoTtEdYNTC
X-Gm-Gg: ASbGncsfKFd9Xwm6bRbt5Crx6s1iPcKt/9NTe/5T+wkQkfaVnpi5eqz3KAIpLF00c4V
	2OG5jZr7p5KKKRzQYneuLdaXHG4NQie9TsVYnhkIKq8NvK15Y2NWhajN4sCrKuQUAI9C8X2Si3l
	zmu/HOzg27suXL91kOeZw5TJ6ehi9NCN2WkanV6y4S4O8diuKMx1rfKMlD0YAmkbR7l4Q9IGWR6
	uJpI68v/UWRPlfwj20J8p0Uk73mSnf9hpAOrfgD3DpHm5t4dCL58SJGcwF81EPnZ2s1tdWz4qFQ
	J9w7NUMdvcJXwlViCZ8Tuaw+glgJWSqqzJgypIthTk5paD1jGPq9ziy3nZWpuEAbMOXCKbMYG/G
	IKIS3Xy34xT4DLKHXZdO67n1wUfWnLJBx
X-Google-Smtp-Source: AGHT+IEJRuCLYuHuprUkYFpZx4V++yJZ8UjG6UfXDSngY1T9lFItwn31tAWF17oY89J1ZY1XjUgClA==
X-Received: by 2002:a17:903:4b08:b0:234:d7b2:2ac3 with SMTP id d9443c01a7336-242c21a7db6mr82665125ad.20.1754737619798;
        Sat, 09 Aug 2025 04:06:59 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977345sm226947525ad.108.2025.08.09.04.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 04:06:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 811BC4207D08; Sat, 09 Aug 2025 18:06:54 +0700 (WIB)
Date: Sat, 9 Aug 2025 18:06:54 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
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
Message-ID: <aJcrzjAz6VafUsqz@archie.me>
References: <20250809094247.8384-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250809094247.8384-1-frederic@kernel.org>

On Sat, Aug 09, 2025 at 11:42:47AM +0200, Frederic Weisbecker wrote:
> +- :ref:`Documentation/admin-guide/cgroup-v2.rst <Cpuset v2 "isolated"
> +  partitions>`
> +  are recommended because they are tunable at runtime.

Anchor link target and name are mistakenly swapped so I have to correct them
back to their appropriate places:

---- >8 ----
diff --git a/Documentation/admin-guide/cpu-isolation.rst b/Documentation/admin-guide/cpu-isolation.rst
index 250027acf7b26f..aef0b53b0ad5e6 100644
--- a/Documentation/admin-guide/cpu-isolation.rst
+++ b/Documentation/admin-guide/cpu-isolation.rst
@@ -107,9 +107,8 @@ are extracted from the global load balancing.
 Interface
 ~~~~~~~~~
 
-- :ref:`Documentation/admin-guide/cgroup-v2.rst <Cpuset v2 "isolated"
-  partitions>`
-  are recommended because they are tunable at runtime.
+- :doc:`cgroup cpuset isolated partitions <cgroup-v2>` are recommended because
+  they are tunable at runtime.
 
 - The 'isolcpus=' kernel boot parameter with the 'domain' flag is a
   less flexible alternative that doesn't allow for runtime
@@ -124,7 +123,8 @@ target CPUs.
 Interface
 ~~~~~~~~~
 
-- /proc/irq/*/smp_affinity as explained :ref:`Documentation/core-api/irq/irq-affinity.rst <here>` in detail.
+- /proc/irq/\*/smp_affinity as explained in
+  Documentation/core-api/irq/irq-affinity.rst.
 
 - The "irqaffinity=" kernel boot parameter for a default setting.
 
@@ -330,9 +330,8 @@ retained when that happens.
 
 Some tools may also be useful for higher level analysis:
 
-- :ref:`Documentation/tools/rtla/rtla-osnoise.rst <rtla-osnoise>` runs a kernel
-  tracer that analyzes and output a
-  summary of the noises.
+- :doc:`rtla-osnoise </tools/rtla/rtla-osnoise>` runs a kernel tracer that
+  analyzes and output a summary of the noises.
 
 - dynticks-testing does something similar but in userspace. It is available
   at git://git.kernel.org/pub/scm/linux/kernel/git/frederic/dynticks-testing.git

> +The full command line is then:
> +
> +  nohz_full=7 irqaffinity=0-6 isolcpus=managed_irq,7 nosmt
> +
> +CPUSET configuration (cgroup v2)
> +--------------------------------
> +
> +Assuming cgroup v2 is mounted to /sys/fs/cgroup, the following script
> +isolates CPU 7 from scheduler domains.
> +
> +  cd /sys/fs/cgroup
> +  # Activate the cpuset subsystem
> +  echo +cpuset > cgroup.subtree_control
> +  # Create partition to be isolated
> +  mkdir test
> +  cd test
> +  echo +cpuset > cgroup.subtree_control
> +  # Isolate CPU 7
> +  echo 7 > cpuset.cpus
> +  echo "isolated" > cpuset.cpus.partition
> +
> +The userspace workload
> +----------------------
> +
> +Fake a pure userspace workload, the below program runs a dummy
> +userspace loop on the isolated CPU 7.
> +
> +  #include <stdio.h>
> +  #include <fcntl.h>
> +  #include <unistd.h>
> +  #include <errno.h>
> +  int main(void)
> +  {
> +  	// Move the current task to the isolated cpuset (bind to CPU 7)
> +  	int fd = open("/sys/fs/cgroup/test/cgroup.procs", O_WRONLY);
> +  	if (fd < 0) {
> +  		perror("Can't open cpuset file...\n");
> +  		return 0;
> +  	}
> +
> +  	write(fd, "0\n", 2);
> +  	close(fd);
> +
> +  	// Run an endless dummy loop until the launcher kills us
> +  	while (1)
> +  	;
> +
> +  	return 0;
> +  }
> +
> +Build it and save for later step:
> +
> +  # gcc user_loop.c -o user_loop
> +
> +The launcher
> +------------
> +
> +The below launcher runs the above program for 10 seconds and traces
> +the noise resulting from preempting tasks and IRQs.
> +
> +  TRACING=/sys/kernel/tracing/
> +  # Make sure tracing is off for now
> +  echo 0 > $TRACING/tracing_on
> +  # Flush previous traces
> +  echo > $TRACING/trace
> +  # Record disturbance from other tasks
> +  echo 1 > $TRACING/events/sched/sched_switch/enable
> +  # Record disturbance from interrupts
> +  echo 1 > $TRACING/events/irq_vectors/enable
> +  # Now we can start tracing
> +  echo 1 > $TRACING/tracing_on
> +  # Run the dummy user_loop for 10 seconds on CPU 7
> +  ./user_loop &
> +  USER_LOOP_PID=$!
> +  sleep 10
> +  kill $USER_LOOP_PID
> +  # Disable tracing and save traces from CPU 7 in a file
> +  echo 0 > $TRACING/tracing_on
> +  cat $TRACING/per_cpu/cpu7/trace > trace.7
> +
> +If no specific problem arose, the output of trace.7 should look like
> +the following:
> +
> +  <idle>-0 [007] d..2. 1980.976624: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=user_loop next_pid=1553 next_prio=120
> +  user_loop-1553 [007] d.h.. 1990.946593: reschedule_entry: vector=253
> +  user_loop-1553 [007] d.h.. 1990.946593: reschedule_exit: vector=253

Wrap these snippets above in literal code blocks.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

