Return-Path: <linux-kernel+bounces-836350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86336BA970D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381D1167D11
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5420A308F32;
	Mon, 29 Sep 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eVjDcG2z"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F611FBC91
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154034; cv=none; b=p5YahUehG8nXJ/dBt3XsJMOjzIPkShB5ek+abjTgEJoPfUuYkLdSWkWsHmF7nY3FxWbwvm93g9umqUskbZCox9mzZolG5dmmHdRqnCZHVSxHIZlRULr7xNwfH4sNJWic+xQqm7DoTpVQheoobTEp4attUDQ9rWrMyDv0dUM6zhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154034; c=relaxed/simple;
	bh=CIBOyO+3pbAtHNloP0JWex0lAwgtx8mQ90GIW5QUQ9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ro+Hf1pzPTHQQfOQbvBRq5o6EHzRRkYkJecL6OcH5xXdQaOVvZGuC/IAmfFvC9y0PEKH1asP2OJGVIc9of9A/4nOMX2q4VsZVQZ9ftbEyE7WGTE3DnJ2ZcqVkQHrgQLofE1RrvrZC/Mdk2/y9a+gjHFFW6TE+HdtkR3b8+0OvSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eVjDcG2z; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yf9w0E04hLVeqKesfMuuOwiPuA9NfgaTUlq6K84ihNM=; b=eVjDcG2zwSAIAkj6Gdpp28AmCJ
	gexqxAC5bEM+TsuxgjexbLSxTmTQFHT4+DcU9S69iSmWhukbnqP1mHTdVLlwBHtvbilUhl6RioCeS
	SfBBBh3BtBGz67M//l5dJyx5pLqgabUtWHpKOxMTJaOjXxEblRTp+V9evZrE7KTSw6Q516hsjQsdr
	uewhLQO12Yuf3i7EuwP0STAMor0ZRsKu262PrgfDPViSET9CxzCoYTzE4SIf1G7XkgFTHV5dSvdax
	73Ewb+zPc/tHwjtycWR0X/WIdLrQVC4ZMbxhXQxE0zccAGWjM/LHWp2hZXIeBCar76ULiKanbCNPc
	du1PAtow==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3EK3-0000000C9O2-2cAV;
	Mon, 29 Sep 2025 13:53:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 30CCF300359; Mon, 29 Sep 2025 15:53:47 +0200 (CEST)
Date: Mon, 29 Sep 2025 15:53:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
Message-ID: <20250929135347.GH3289052@noisy.programming.kicks-ass.net>
References: <20250929133602.32462-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929133602.32462-1-piliu@redhat.com>

On Mon, Sep 29, 2025 at 09:36:02PM +0800, Pingfan Liu wrote:
> When testing kexec-reboot on a 144 cpus machine with
> isolcpus=managed_irq,domain,1-71,73-143 in kernel command line, I
> encounter the following bug:
> 
> [   97.114759] psci: CPU142 killed (polled 0 ms)
> [   97.333236] Failed to offline CPU143 - error=-16
> [   97.333246] ------------[ cut here ]------------
> [   97.342682] kernel BUG at kernel/cpu.c:1569!

> [   97.514379] Call trace:
> [   97.516874]  smp_shutdown_nonboot_cpus+0x104/0x128
> [   97.521769]  machine_shutdown+0x20/0x38
> [   97.525693]  kernel_kexec+0xc4/0xf0
> [   97.529260]  __do_sys_reboot+0x24c/0x278
> [   97.533272]  __arm64_sys_reboot+0x2c/0x40

> Tracking down this issue, I found that dl_bw_deactivate() returned
> -EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
> When a CPU is inactive, its rd is set to def_root_domain. For an S-state

You mean a blocked task?

> deadline task (in this case, "cppc_fie"), it was not migrated to CPU0,
> and its task_rq() information is stale. As a result, its bandwidth is
> wrongly accounted into def_root_domain during domain rebuild.
> 
> This patch uses the rd from the run queue of still-active CPU to get the
> correct root domain.

That doesn't seem right in general. What if there are multiple root
domains; how does it know which to use?

