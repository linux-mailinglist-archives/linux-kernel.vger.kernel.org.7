Return-Path: <linux-kernel+bounces-852471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF36BD9108
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87703E0C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2BD30BF7B;
	Tue, 14 Oct 2025 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lRqJ9paR"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675B71DFCB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441864; cv=none; b=s4ZXlk/+odssGmkxxFosaz9seZLe/b7qolbtZDE77Z4/vwl1AKMU4Qmy7JMsPqS/3fiT5txLaBhHBaZjJCIon9SOI5b/elCsZmx6S1M0QiuZOkvJk59/RI8Hhjth6kTlVSlXsk/0RwPRnsuLFMQG64euFvTocJFbZWEqXWStoms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441864; c=relaxed/simple;
	bh=jOfBXnGAPqF8PCUD/WeavURv3SVCuesX8bq0yVdNYa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByOcpTmvUyWRUEXsq86Lx7bR5tLpacBx5qC7fc0iAyLfVCg/FP47mZlcL4+k9R9kf7PZLMaR+DRVW0apLReoHKqbUWgHKNWoFPLfwibfGmViLvLl9zQ1mPzrs/Ytz2vFDq6vY3IHfD8Y6XkD59jnJHPjzKVhE0gUfCjzfSMImgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lRqJ9paR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zofAk4H/2Qn4eteAkk0EdVWWuSyxbO4f8g/Cwd5x8i8=; b=lRqJ9paRgFD3UE6aQBpHQSEu//
	fj2v+dRvJ4vVzTSTrajCMKdzE64Te/wRAqtZVASNyIu4t2KcW4w39EdbmWE0TCBa9I9LdniowGy3s
	IHi0VHVbZmtCSHcEJM5OFQ///Z0gqcWE7FN06i6xSmU0562CDesr9E0wCq/Jcpk0UyCKOnM0tbTZz
	yurhGyl1zR/jSVSEX2SfMHDylbu1VNJ4BX4fhPCfZiuasvD7/33VySEY6DsCu2cWQn9hk+hoZJw0p
	9Q9qah/pLCSddd+BvZwA5ob3i8xLpe9g6r1ONjnlCbBsXTQXZnMIGinE3OCbYzSmuP/9CWQF1mWsD
	ZNb+WdvQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8dLO-00000009kKG-32c7;
	Tue, 14 Oct 2025 11:37:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7EC4D300212; Tue, 14 Oct 2025 13:37:31 +0200 (CEST)
Date: Tue, 14 Oct 2025 13:37:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Adam Li <adamli@os.amperecomputing.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, cl@linux.com,
	linux-kernel@vger.kernel.org, patches@amperecomputing.com,
	shkaushik@amperecomputing.com
Subject: Re: [PATCH RESEND] sched/fair: Only update stats for allowed CPUs
 when looking for dst group
Message-ID: <20251014113731.GO4067720@noisy.programming.kicks-ass.net>
References: <20251011064322.8500-1-adamli@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011064322.8500-1-adamli@os.amperecomputing.com>

On Sat, Oct 11, 2025 at 06:43:22AM +0000, Adam Li wrote:
> Load imbalance is observed when the workload frequently forks new threads.
> Due to CPU affinity, the workload can run on CPU 0-7 in the first
> group, and only on CPU 8-11 in the second group. CPU 12-15 are always idle.
> 
> { 0 1 2 3 4 5 6 7 } {8 9 10 11 12 13 14 15}
>   * * * * * * * *    * * *  *
> 
> When looking for dst group for newly forked threads, in many times
> update_sg_wakeup_stats() reports the second group has more idle CPUs
> than the first group. The scheduler thinks the second group is less
> busy. Then it selects least busy CPUs among CPU 8-11. Therefore CPU 8-11
> can be crowded with newly forked threads, at the same time CPU 0-7
> can be idle.
> 
> A task may not use all the CPUs in a schedule group due to CPU affinity.
> Only update schedule group statistics for allowed CPUs.
> 
> Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
> ---
> Resending this patch from the patchset:
> https://lore.kernel.org/lkml/20250717062036.432243-2-adamli@os.amperecomputing.com/
> 

Right, lets start with this then ;-)

No need to do the cpumask_and() thing, that's just more changes vs
update_sg_lb_stats().

