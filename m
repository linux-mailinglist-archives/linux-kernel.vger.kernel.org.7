Return-Path: <linux-kernel+bounces-837376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D512EBAC2BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D303BEC4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EB5277030;
	Tue, 30 Sep 2025 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JZBUrIqk"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA001EBA14
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223087; cv=none; b=E0j+/xnaDyBItOn761+yQNVMGCupRQvUTy0cZ0iProtlI3Fq76HHQDs53FYwq31l7858aY3hl769mfA5DF+Xwrmjj2iSOeistY/w4jYnjrcxFP3CJ1Ms8lHhPxjj3MfSmmtritZXZol1X5U2G/hACCYvzYSZwdp30CqbQ2+JVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223087; c=relaxed/simple;
	bh=A6+WlgKH9oFQnpOsXxx+2rVT8kK/7Q6kn6SQRkadzJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVpNVOMPg7CRfgEPWnERvR9mwBpXT6vmWdR9oIjdU8UQR7QTARcowy/OGpvExcgAIQVq8YVr7QQ54wb9+i9AzDgqFltRlvPAHl7LUs9Nckir+dBCWXxYvzrD5x1OpSALavGLfpeObm5zwUb1WIFYhqZdcVfQ6fpwnaiLaj+UT7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JZBUrIqk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uG4yC9nzbA50dxHl1Cj2RAGtT6UvdtI2Equd3NsrccM=; b=JZBUrIqkFXWzSdDWxpI8V6fL5V
	eVnb/AYS+p9nykKJcNxSuv48BDI/XKgBxpeyjN2tQfkRrVm0bWcfHv9XeJaFD2d0m6pLfBFtUKpml
	MSz3FC3jjPz5TA74z6t54I9Jl4RFIgKL0/YXg3m0oIhhGnuGE7cdrxPAxeMXwmLQaqjdZNiqf2PKR
	6U4/x9EVfGDr5++hyXli0E+kYit4CDxXmE/p17iRXuaXLrTXy4p/26SrNQa0/TRbwV7dHB6cS1pfu
	8pKj1nzPElGXkNRz67o6AAgVGuXn0UEPTYBXpwB7xMRV9btMYC9JF7H8tDgg0P5apBK/YIen0Rv1d
	E5D8Yo5A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3WHq-0000000CiWp-1FbA;
	Tue, 30 Sep 2025 09:04:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DC961300220; Tue, 30 Sep 2025 11:04:41 +0200 (CEST)
Date: Tue, 30 Sep 2025 11:04:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Pingfan Liu <piliu@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
Message-ID: <20250930090441.GJ4067720@noisy.programming.kicks-ass.net>
References: <20250929133602.32462-1-piliu@redhat.com>
 <20250929135347.GH3289052@noisy.programming.kicks-ass.net>
 <CAF+s44Q4SDXPRfYc4Ms5TcJgRU07QJB5H5VOHvyrZ31x9z49nw@mail.gmail.com>
 <aNuEpt8IkvtkH9na@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNuEpt8IkvtkH9na@jlelli-thinkpadt14gen4.remote.csb>

On Tue, Sep 30, 2025 at 08:20:06AM +0100, Juri Lelli wrote:

> I actually wonder if we shouldn't make cppc_fie a "special" DEADLINE
> tasks (like schedutil [1]). IIUC that is how it is thought to behave
> already [2], but, since it's missing the SCHED_FLAG_SUGOV flag(/hack),
> it is not "transparent" from a bandwidth tracking point of view.
> 
> 1 - https://elixir.bootlin.com/linux/v6.17/source/kernel/sched/cpufreq_schedutil.c#L661
> 2 - https://elixir.bootlin.com/linux/v6.17/source/drivers/cpufreq/cppc_cpufreq.c#L198

Right, I remember that hack. Bit sad its spreading, but this CPPC thing
is very much like the schedutil one, so might as well do that I suppose.

