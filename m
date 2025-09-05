Return-Path: <linux-kernel+bounces-802936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFACB4588F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F707B1F26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DFC1D5CC9;
	Fri,  5 Sep 2025 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9rVRLBe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7220311713;
	Fri,  5 Sep 2025 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078260; cv=none; b=kPd0VWc9/WoI0GY+lNZolRHavcuJqQ9gTo/k3f4ruwuZHUIEtASu/LmuZWtr/qlelIjTk/Q9YnY0r0REUBWRoOXgmMNIGoift5N9ffFPByUo7Yoa+R580dQXevoWxT+HGF3npv1PrC5JU6V2RfiNhjgraZh9YP/tQRHQ51fiX+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078260; c=relaxed/simple;
	bh=8K1xZwxNKmKwjiFmRPHnpa/BKiKlfNGI82IJte7utGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU32MteGOh2+ndGGpkZdEhzeHAttFauO+TfogSWwqTo/mCkuPZo72yOrFiPB68MEEJydv0XCZv+x/SyF5KW2PAlh1VbRPOsQOT+zkOT6CfFmXYvreEaQvGChayftcYM2XUcRclhc9e6wLpJA8m8hnVuMHnpfXn9jgXKtK7NLdI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9rVRLBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647D2C4CEF1;
	Fri,  5 Sep 2025 13:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757078258;
	bh=8K1xZwxNKmKwjiFmRPHnpa/BKiKlfNGI82IJte7utGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q9rVRLBeVTdx0mNaBBuJriNOuFtKaTEuf+6WfdOYXuOHZZm/b/11EcmtfDGs1OAP2
	 mahMBtF5QOJ/hLuVBXPL5rfnEBppe7ppiTBmK1UU1HemTwxZXHoTE1z00HM6AjA1Qy
	 V9hGNRYOb3XUI3wk2/pjAsXbWvwpJ3kMxg3ck4DOfiaIxa2/+Dk0fz9HFk15miyycC
	 wODJ977c8DbtRC6EATInz6Z+9NuSYtJgwI1sdiWCpkqIq+7Iy2rc+/m547pSwpwvei
	 R5UChH65HMNkk+LODFBTBZiz2Pe4fazxhySC0FecPjnG1yVx77gZ1IWlYZSgAvAu/k
	 8Cx4HxWfQUszQ==
Date: Fri, 5 Sep 2025 15:17:35 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
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
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc: Add CPU Isolation documentation
Message-ID: <aLri71mWB52kklkF@localhost.localdomain>
References: <20250809094247.8384-1-frederic@kernel.org>
 <xhsmhldnpizox.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmhldnpizox.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

Le Mon, Aug 11, 2025 at 06:35:26PM +0200, Valentin Schneider a écrit :
> On 09/08/25 11:42, Frederic Weisbecker wrote:
> > nohz_full was introduced in v3.10 in 2013, which means this
> > documentation is overdue for 12 years.
> >
> 
> 12 years is not that bad, it's not old enough to drink (legally) yet!

;-)

> 
> > The shoemaker's children always go barefoot. And working on timers
> > hasn't made me arriving on time either.
> >
> > Fortunately Paul wrote a part of the needed documentation a while ago,
> > especially concerning nohz_full in Documentation/timers/no_hz.rst and
> > also about per-CPU kthreads in
> > Documentation/admin-guide/kernel-per-CPU-kthreads.rst
> >
> > Introduce a new page that gives an overview of CPU isolation in general.
> >
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  Documentation/admin-guide/cpu-isolation.rst | 338 ++++++++++++++++++++
> >  Documentation/admin-guide/index.rst         |   1 +
> >  2 files changed, 339 insertions(+)
> >  create mode 100644 Documentation/admin-guide/cpu-isolation.rst
> >
> > diff --git a/Documentation/admin-guide/cpu-isolation.rst b/Documentation/admin-guide/cpu-isolation.rst
> > new file mode 100644
> > index 000000000000..250027acf7b2
> > --- /dev/null
> > +++ b/Documentation/admin-guide/cpu-isolation.rst
> > @@ -0,0 +1,338 @@
> > +=============
> > +CPU Isolation
> > +=============
> > +
> > +Introduction
> > +============
> > +
> > +"CPU Isolation" means leaving a CPU exclusive to a given userspace
>                                                             ^^^^^^^^^
> Eh I'm being nitpicky, but this doesn't have to be userspace stuff right?
> "someone" could e.g. affine some IRQ to an isolated CPU to have the
> irqthread run undisturbed there, or somesuch.

Good point!

> > +
> > +Scheduler domain isolation
> > +--------------------------
> > +
> > +This feature isolates a CPU from the scheduler topology. As a result,
> > +the target isn't part of the load balancing. Tasks won't migrate
> > +neither from nor to it unless affine explicitly.
>                                  ^^^^^^
> s/affine/affined/

Right.

> 
> > +As a side effect the CPU is also isolated from unbound workqueues and
> > +unbound kthreads.
> 
> > +Checklist
> > +=========
> > +
> > +You have set up each of the above isolation features but you still
> > +observe jitters that trash your workload? Make sure to check a few
> > +elements before proceeding.
> > +
> > +Some of these checklist items are similar to those of real time
> > +workloads:
> > +
> > +- Use mlock() to prevent your pages from being swapped away. Page
> > +  faults are usually not compatible with jitter sensitive workloads.
> > +
> > +- Avoid SMT to prevent your hardware thread from being "preempted"
> > +  by another one.
> > +
> > +- CPU frequency changes may induce subtle sorts of jitter in a
> > +  workload. Cpufreq should be used and tuned with caution.
> > +
> > +- Deep C-states may result in latency issues upon wake-up. If this
> > +  happens to be a problem, C-states can be limited via kernel boot
> > +  parameters such as processor.max_cstate or intel_idle.max_cstate.
> > +
> 
> Nitpickery again, I know it's not an exhaustive listing, but I'd rather
> point to the sysfs cpuidle interface (or just mention it too), since that
> means deep C-states can be left enabled for HK CPUs.

Yes!

> 
> 
> Should we also mention BIOS/firmware fuckery like SMIs?
> 
> """
> - Your system may be subject to firmware-originating interrupts - x86 has
>   System Management Interrupts (SMIs) for example. Check your system BIOS
>   to disable such interference, and with some luck your vendor will have
>   a BIOS tuning guidance for low-latency operations.
> """

Definetely!

> 
> > +Debugging
> > +=========
> > +
> > +Of course things are never so easy, especially on this matter.
> > +Chances are that actual noise will be observed in the aforementioned
> > +trace.7 file.
> > +
> > +The best way to investigate further is to enable finer grained
> > +tracepoints such as those of subsystems producing asynchronous
> > +events: workqueue, timer, irq_vector, etc... It also can be
> > +interesting to enable the tick_stop event to diagnose why the tick is
> > +retained when that happens.
> > +
> 
> I'd also list the 'ipi_send*' family, although that's emitted from the HK
> CPU, not the disturbed isolated CPU.

Yeah I can do that.

> 
> > +Some tools may also be useful for higher level analysis:
> > +
> > +- :ref:`Documentation/tools/rtla/rtla-osnoise.rst <rtla-osnoise>` runs a kernel
> > +  tracer that analyzes and output a
> > +  summary of the noises.
> > +
> 
> I'd want to point to hwnoise and timerlat as well, so maybe point to
> rtla.rst?

Good point.

Thanks!

> 
> > +- dynticks-testing does something similar but in userspace. It is available
> > +  at git://git.kernel.org/pub/scm/linux/kernel/git/frederic/dynticks-testing.git
> > diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> > index 259d79fbeb94..b5f1fc7d5290 100644
> > --- a/Documentation/admin-guide/index.rst
> > +++ b/Documentation/admin-guide/index.rst
> > @@ -94,6 +94,7 @@ likely to be of interest on almost any system.
> >
> >     cgroup-v2
> >     cgroup-v1/index
> > +   cpu-isolation
> >     cpu-load
> >     mm/index
> >     module-signing
> > --
> > 2.50.1
> 

-- 
Frederic Weisbecker
SUSE Labs

