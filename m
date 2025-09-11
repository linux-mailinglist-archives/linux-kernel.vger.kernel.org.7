Return-Path: <linux-kernel+bounces-811992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F645B53158
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192C4164500
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B802E541E;
	Thu, 11 Sep 2025 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENO8mXS7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BC72C159A;
	Thu, 11 Sep 2025 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757591279; cv=none; b=PpOSNPNzgSRa8mx8OhoQUsAgADjnm9TVZrczGQQ5mAN5Ypr05NtqeJHipMI7N82G+dCLV519PfW+CWbS7KHZFwNfFsdtlrvg1s/cxYt4WTdprr1uisYJ17SKz4gg5x721Di4Rl6nKdcqvDFXesPxqFQ+rfPKTm9N73wfNrALAzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757591279; c=relaxed/simple;
	bh=bgyGI40NvAFqCW9x6Rj2Hf2ynqOaS/i2xlX77tigdPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHhVwWqcBA0DwEYr2bVV/2C8zU5DRs2gtv53/AJm0zSDX6V0ektK7+/G2xzC+UHonibBSEHMsgWQ7218Bi5rC887+nczlcPr6voQy2bge/PBXX3+urCBSl4vxVgGXy4fLQ0SlUfNQUSTf1Mftw5iZaGaY5KCe63NBg3W0uPO+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENO8mXS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93183C4CEF0;
	Thu, 11 Sep 2025 11:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757591279;
	bh=bgyGI40NvAFqCW9x6Rj2Hf2ynqOaS/i2xlX77tigdPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ENO8mXS7jN1vH8dZDXPJNxVLUX1czffoV76dZ8av4n7MbfoBu7cY5NuUPNlk9XFdz
	 BXzUM/pdPimBC3ecaFoCyG2Dt5HWzYpAgMGvn4BO905Rt1jBmvhrT7qINCmadVlWPt
	 FX8JB3UEVYGTmRrDwVgZ4CG9OtuKQ+g2c3vXxGwtahES2Cy1cWXT4z1Sj0VH+HNohd
	 79Lvo21VjsjDuL+FKNCXyvYG/HmIIBjpdj10PMI27JUwWvjJjJbncjsQU53wI2sUGf
	 DJ+wR0HGVwEMIG83azbTWVRJYU3bdETGpaA2UJKUeLR6RI0XzwfSDpIg9ORHZ1+HoR
	 BTJcDwMjdOTrQ==
Date: Thu, 11 Sep 2025 13:47:56 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
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
	Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc: Add CPU Isolation documentation
Message-ID: <aMK27L52yLpohO0p@localhost.localdomain>
References: <20250809094247.8384-1-frederic@kernel.org>
 <8f357de1-72ba-497f-997a-f9a61aec6190@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f357de1-72ba-497f-997a-f9a61aec6190@redhat.com>

Le Mon, Aug 11, 2025 at 04:38:53PM -0400, Waiman Long a écrit :
> On 8/9/25 5:42 AM, Frederic Weisbecker wrote:
> > nohz_full was introduced in v3.10 in 2013, which means this
> > documentation is overdue for 12 years.
> > 
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
> 
> Thanks for working on this document. It will be really useful for those
> customers that need CPU isolation.
> 
> 
> > ---
> >   Documentation/admin-guide/cpu-isolation.rst | 338 ++++++++++++++++++++
> >   Documentation/admin-guide/index.rst         |   1 +
> >   2 files changed, 339 insertions(+)
> >   create mode 100644 Documentation/admin-guide/cpu-isolation.rst
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
> > +workload without any undesired code interference from the kernel.
> > +
> > +Those interferences, commonly pointed out as "noise", can be triggered
> > +by asynchronous events (interrupts, timers, scheduler preemption by
> > +workqueues and kthreads, ...) or synchronous events (syscalls and page
> > +faults).
> > +
> > +Such noise usually goes unnoticed. After all synchronous events are a
> > +component of the requested kernel service. And asynchronous events are
> > +either sufficiently well distributed by the scheduler when executed
> > +as tasks or reasonably fast when executed as interrupt. The timer
> > +interrupt can even execute 1024 times per seconds without
> > +significantly measurable impact most of the time.
> 
> "significantly measurable" looks odd to me. Maybe "without a significant and
> measurable impact most of the time".

Makes sense.

> 
> > +
> > +Tradeoffs
> > +~~~~~~~~~
> > +
> > +In terms of cost, this is the most invasive isolation feature. It is
> > +assumed to be used when the workload spends most of its time in
> > +userspace and doesn't rely on the kernel except for preparatory
> > +work because:
> > +
> > +- RCU is slower due to the locked, offloaded and threaded callbacks
> > +  processing (the same that would be obtained with "rcu_nocb=" boot
> > +  parameter).
> Should be "rcu_nocbs". The '=' is optional.

Ok.

Thanks!

> 
> Cheers,
> Longman
> 

-- 
Frederic Weisbecker
SUSE Labs

