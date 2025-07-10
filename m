Return-Path: <linux-kernel+bounces-725423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C1BAFFEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C012C4824BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A682D837E;
	Thu, 10 Jul 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RadJuAWg"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4832D661F;
	Thu, 10 Jul 2025 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142406; cv=none; b=XI+UCjbmofGxfXvsXpdBCJkRVvhkB2V5ODjxNPpUmvKMG5BZLegAM1j6T1izny0CM4gFNGeYo0guMQ5wa63EnAsaesNzyobArqjpy72++l43WckOZu7dsSGHujA1Epi1q17y8G64FqVTNLWw7K4LOuUI+anvFi4EIAu3JF4khgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142406; c=relaxed/simple;
	bh=F9Zn38Ia5P+j2FJQVJkhDRVVfMYoxSFosPDOuypiIMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoqhT2ECSbsTiB47+X+lmrZjcb4GnywhiREMJ0Gf4PwXgPIjmuSsoE85tO3A9lLuV9c7kfTaR8WOebwM/F3JtbLeye7R9P0gVWyO/cZtsgA4+MAJd6WHCrVh+scKUsJ2W2/hawxJbg9Z6/fovrPq3mbUeyOiYGEFGnWFm76cpcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RadJuAWg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ENYhfh0yC13BHVhZjvhSu3orUCwcKZQ5QjaaRVv3TS4=; b=RadJuAWgSyMYaLX8M7SGTm5T7v
	LZaYlLHu5zA2FYrYvjLwRFAjjh8xZAS5uEizug0oqKd10Ybnfw1zt0kdsGIopqn8e9e6egwke6bQo
	fRjArkm0xUiErhdJCWUy3mvnap9Mx8FQCO92a0rapwUmoPXQxl5Irxh4+s7MEgyW2JCHI/+aacXxn
	NtYO5aYS7RBx67Mg0J5F4CcCMzzS/wBg7cTvBO/PHLeZ9zEhDVVGJF6zcsXcLFl7j5pfBv8eNRU/M
	gPgqGbn6fV+Hhv3Jg2VLdTtD4pc5ypw4B8QMjIbeicwe/CE89+Yi1lQ+l990Jht0IUI/n3caLYY9X
	zdbTKUSw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZoHF-00000008Rvt-053y;
	Thu, 10 Jul 2025 10:13:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9720030023C; Thu, 10 Jul 2025 12:13:16 +0200 (CEST)
Date: Thu, 10 Jul 2025 12:13:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	aubrey.li@linux.intel.com
Subject: Re: [PATCH] lib/smp_processor_id: Make migration check unconditional
 of SMP
Message-ID: <20250710101316.GJ1613376@noisy.programming.kicks-ass.net>
References: <202507100448.6b88d6f1-lkp@intel.com>
 <6cf071f3-ff5b-4025-8ce7-2f2cceb03984@intel.com>
 <20250710062528.T-Obm39T@linutronix.de>
 <292e70ed-aae5-4f52-8f85-80cba7ff301d@intel.com>
 <20250710081114.5wnABNG7@linutronix.de>
 <20250710082748.-DPO1rjO@linutronix.de>
 <cf437def-4542-4b73-b62b-ae9b304d40be@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf437def-4542-4b73-b62b-ae9b304d40be@intel.com>

On Thu, Jul 10, 2025 at 04:32:57PM +0800, Chen, Yu C wrote:
> On 7/10/2025 4:27 PM, Sebastian Andrzej Siewior wrote:
> > Commit cac5cefbade90 ("sched/smp: Make SMP unconditional")
> > migrate_disable() even on UP builds.
> > Commit 06ddd17521bf1 ("sched/smp: Always define is_percpu_thread() and
> > scheduler_ipi()") made is_percpu_thread() check the affinity mask
> > instead replying always true for UP mask.
> > 
> > As a consequence smp_processor_id() now complains if invoked within a
> > migrate_disable() section because is_percpu_thread() checks its mask and
> > the migration check is left out.
> > 
> > Make migration check unconditional of SMP.
> > 
> > Fixes: cac5cefbade90 ("sched/smp: Make SMP unconditional")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202507100448.6b88d6f1-lkp@intel.com
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> 
> From my understanding,
> 
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>

Thanks; let me go stick this in a tree somewhere.

