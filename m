Return-Path: <linux-kernel+bounces-797933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D034B4174F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF2D3A5BF9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081862E03FF;
	Wed,  3 Sep 2025 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mQ/KJ14/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAD2D9492
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886086; cv=none; b=MYvGFnjMVQAFpKycqRcXyv7HNPpkvHF8Qhr5QCyB11/ug11APYSN5KP9mM2r+C40nOSZuDq67ahBbakqklXXViymEReewQxhe+ipcylM9e18CFtxgA/3K4Rx69g/GrT2h3po1mSEO4mklwK5EMWGVFLr3C1ofzDIvYxvPmcQ+5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886086; c=relaxed/simple;
	bh=KimhsjXQEnuK7Ac+b5+TmvsVMXi1DWgLgX6t3Nkr8/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJw8CdnxTe/au+EfZ/lIF9wu2DipADdaXZIOSRVAkmbkK5nqyMMNEOI1lKutj+T1I/YvXFCbe0h1eR5jv5lxPhME3xQB65qZkJ9WpNgFeL6uuJdIlYAnwOXUsZ2WEjM+2wQeLu/GbHKHSWgdbYmbpYkJA5X81DBKh54r1HVBT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mQ/KJ14/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GCaUGv2Go01YtqEnyZ5jOfHZaSUfQafMQtm8uKTPzx8=; b=mQ/KJ14/TIkltdWYK5dZaEV9B+
	PGQ/4HZ7KwgDsIR3PgbsGafGDB9EB7zxpIIOeQzQmqQH0PFBAreDjhFA0wY9pRy4G/Ze2q5VmOmzT
	HDeco9jdcLjJjrKVH/bn0khyLJMIuX/ks7Wygv/rKy8kTXUajn1+20GhfOJEb/iTugPa79Fr0yWOl
	MKq9v6HVadaP9Jl60fF1AOz93pyLaMD1p00ADZ4jczIa58mSrIkrm2a1Ekm9fhd1jCyq32fXpw9c8
	KSpOXAH23M5as7Omu8IVjoUW/yaccHIQOrFEL+lDw1vlS2srz8apaVR9G+6Xue+Hm0EzsTzUraWKL
	5Kw+auVA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utiKD-0000000HKP8-1BNs;
	Wed, 03 Sep 2025 07:54:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 86DDD30034B; Wed, 03 Sep 2025 09:54:36 +0200 (CEST)
Date: Wed, 3 Sep 2025 09:54:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Doug Berger <opendmb@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH v2] sched/deadline: only set free_cpus for online
 runqueues
Message-ID: <20250903075436.GN3245006@noisy.programming.kicks-ass.net>
References: <20250815012236.4053467-1-opendmb@gmail.com>
 <aKMja4BvgQ5vFaNN@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKMja4BvgQ5vFaNN@jlelli-thinkpadt14gen4.remote.csb>

On Mon, Aug 18, 2025 at 02:58:19PM +0200, Juri Lelli wrote:
> Hello,
> 
> On 14/08/25 18:22, Doug Berger wrote:
> > Commit 16b269436b72 ("sched/deadline: Modify cpudl::free_cpus
> > to reflect rd->online") introduced the cpudl_set/clear_freecpu
> > functions to allow the cpu_dl::free_cpus mask to be manipulated
> > by the deadline scheduler class rq_on/offline callbacks so the
> > mask would also reflect this state.
> > 
> > Commit 9659e1eeee28 ("sched/deadline: Remove cpu_active_mask
> > from cpudl_find()") removed the check of the cpu_active_mask to
> > save some processing on the premise that the cpudl::free_cpus
> > mask already reflected the runqueue online state.
> > 
> > Unfortunately, there are cases where it is possible for the
> > cpudl_clear function to set the free_cpus bit for a CPU when the
> > deadline runqueue is offline. When this occurs while a CPU is
> > connected to the default root domain the flag may retain the bad
> > state after the CPU has been unplugged. Later, a different CPU
> > that is transitioning through the default root domain may push a
> > deadline task to the powered down CPU when cpudl_find sees its
> > free_cpus bit is set. If this happens the task will not have the
> > opportunity to run.
> > 
> > One example is outlined here:
> > https://lore.kernel.org/lkml/20250110233010.2339521-1-opendmb@gmail.com
> > 
> > Another occurs when the last deadline task is migrated from a
> > CPU that has an offlined runqueue. The dequeue_task member of
> > the deadline scheduler class will eventually call cpudl_clear
> > and set the free_cpus bit for the CPU.
> > 
> > This commit modifies the cpudl_clear function to be aware of the
> > online state of the deadline runqueue so that the free_cpus mask
> > can be updated appropriately.
> > 
> > It is no longer necessary to manage the mask outside of the
> > cpudl_set/clear functions so the cpudl_set/clear_freecpu
> > functions are removed. In addition, since the free_cpus mask is
> > now only updated under the cpudl lock the code was changed to
> > use the non-atomic __cpumask functions.
> > 
> > Signed-off-by: Doug Berger <opendmb@gmail.com>
> > ---
> 
> This looks now good to me.
> 
> Acked-by: Juri Lelli <juri.lelli@redhat.com>

So I just had a look at said patch because Juri here poked me; and I
came away with the feeling that cpudl_clear() is now a misnomen, seeing
how it is called from rq_online_dl().

Would cpudl_update() be a better name?

