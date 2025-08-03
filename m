Return-Path: <linux-kernel+bounces-754501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3F9B194FC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 21:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F375B3A7302
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 19:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB2A1E1DEC;
	Sun,  3 Aug 2025 19:23:52 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005DE22EE5
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754249032; cv=none; b=KmJH/w8blCOpEDXLuBQzKhWgEpP1cBcd5daMzXJyrAO7NJ6xnJ/sfVY11JwwyBwn8wxvnZvZdNAbIkZT3JS9BwwpgjoBU2g6zvQooOvRq6NpQl/KXyZDLUg22pH8GVFaMXNOU6kBOlvorpwR2tCQp/Mp4i1y5hViQAkUf3PMnF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754249032; c=relaxed/simple;
	bh=vKeQAxCs5ZVNuh+UixFc3uBvT0rxgIMg/WRsF+XOxy4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6BPJDogfpxpbTJM6cm47kBmXOoI8PlIiLvgoyhNuto82noELp+zbh3HT0sC7HO5G+oecfgONOnhf8/iYVenFTk0nKrFs7ugjDiSAvj0s9vBre4+QvoHA6POYzJBbXydQrKKhJd/Cu93thr+haF0yPVlLCRivDwDvfwcu+1Fo90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 23B13160892;
	Sun,  3 Aug 2025 19:23:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 9DF0520025;
	Sun,  3 Aug 2025 19:23:45 +0000 (UTC)
Date: Sun, 3 Aug 2025 15:24:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Mel Gorman <mgorman@suse.de>, Tejun Heo <tj@kernel.org>, Valentin Schneider
 <vschneid@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [GIT PULL] Scheduler updates for v6.17
Message-ID: <20250803152411.7fd91614@gandalf.local.home>
In-Reply-To: <CAHk-=wi26+UnKf59XjPbGssqS+quapnED1QGNW1mVDtEiuakdQ@mail.gmail.com>
References: <aIcdTI3e04W_RdM_@gmail.com>
	<CAHk-=whgqmXgL_toAQWF793WuYMCNsBhvTW8B0xAD360eXX8-A@mail.gmail.com>
	<CAHk-=wg7Ad6zjs8QdgDkS-8oJD2EbLK2Ne-WRo36ZXVHa=hmWw@mail.gmail.com>
	<20250802154645.52712449@gandalf.local.home>
	<CAHk-=wi26+UnKf59XjPbGssqS+quapnED1QGNW1mVDtEiuakdQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: e37tof3f65kqqx161wqqir5mmm9tofb3
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 9DF0520025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18iPYsPRlWudPC2phesBc5UsXOivaFx2Ik=
X-HE-Tag: 1754249025-445631
X-HE-Meta: U2FsdGVkX1/Dz9ZTcseXJw0t3oJBaXJ2L8ay2FMgnBZsgEFCHLj6/HuvN5cwxiE43QPOXRImwjGoqqSA8pZgAbdRrplNHfM4C+jdx09uSjp4ZLV0H1tmb3M1TkfMShXKriXzIq4gYLJZ6XX2SYnJluZ7zZyqpKrazY71FFDB12mjDXRVd8SBaZSVSIO4i6gDcekUSe6E852i3KX8BMkZZ6R4yCaxqpjGnhexnYkL5pcs0JcWcLi9ixaeFrUjPbWwMnMEsIHKsYGCgNIqqOlf7KYh0A3KqILSimTPGqOvPsn+OYeCcrq98ItTR3n0OTeXYbQxB0hCNRFKFUXK9d3tImkTdVxauKlghZ2Fy+M2PmOOPb6UbqR2F91hrYU0uwio1bDEfyX0xhUMLeudNrAvdn+Qn61h7AcXr+y5MfT4G4Mf7K+9UiuwqtnCDX6wdsoU

On Sun, 3 Aug 2025 12:10:56 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 2 Aug 2025 at 12:46, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > You could try to enable function tracer and stop the trace with the patch
> > below and see where it happened.
> >
> >  # echo function > /sys/kernel/tracing/current_tracer
> >  # echo 1 > /sys/kernel/tracing/tracing_on
> >
> > After it happens you can take a look at:
> >
> >   # cat /sys/kernel/tracing/trace  
> 
> Note that when this happens, the machine is dead.
> 
> It seems to be alive enough to get this logged, but it's dead from a
> functional standpoint. There's no "when it happens, do this".

Can you trigger a forced soft reboot? 

 echo 1 > /proc/sys/kernel/panic_on_warn

With the kernel command line "panic=1".

If your machine doesn't clear the memory on reboot, you could use the
persistent ring buffer too:

Adding to the kernel command line:

  reserve_mem=20M:12M:trace trace_instance=boot_mapped@trace

Then use:

  # echo function > /sys/kernel/tracing/instances/boot_mapped/current_tracer
  # echo 1 > /sys/kernel/tracing/instances/boot_mapped/tracing_on

After a crash, if the memory is persistent it should have everything up to
the crash:

   # cat /sys/kernel/tracing/instances/boot_mapped/trace  


This is the exact scenario that this was created for.

-- Steve


