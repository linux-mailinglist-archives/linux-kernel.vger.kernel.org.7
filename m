Return-Path: <linux-kernel+bounces-729925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2ADB03DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C74189F4D8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABD0246BD8;
	Mon, 14 Jul 2025 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SjhnD4Vh"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C9F242D98
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752493954; cv=none; b=VKvNCv4hCVguCpHmveQpUaJjGH6wRjbEIdtlfZ2KL2qHWqnbPuO3qqVsIlnkBMFCsJhV+/yYBBeT0UxwtYjIMXg1sW8qwFL9wKsAVW/6M2mXBpib8AxEuDFVvioBPlrhmiHB111I5Av4UxizNqDGRtDF2pa0LouE4MQkIyiPY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752493954; c=relaxed/simple;
	bh=21d26S9Iwhr07CBmKJbijczEw6nbI1sCsCOP19XTWxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXFiQcytwe8HcRfg8pyjdf11LlrIQFVxMOvf1sntaGeBuXQHXfx4wmNDR0w5bY8v2/rPOOmy0UD8C7yI0UTOvFoPzysk42pv5A8iiLtXaLyxJL/qCgKyk1tfw5/UAuurvH2SqWegFVJml3Q75pmsBdQoW+aUNpc60SyL0Ngvl1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SjhnD4Vh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2M90PkFPEtFYQCEAAA5foFwIa/Tx/j01JcvOGJzKf3s=; b=SjhnD4Vh5Y7Zb5fZyXy3smhlmw
	uvl62Sx74+kgbw9LuEcPkK/arQVvGcMPUvqc8F9zEA56f0eS0lTyUFwijd6hP1rXywIYhoSSR7nl5
	uAHO6cZAiqu6sVPXyhuFN2JWQraRJrj+Ubk0bRSkGSolrewcWBpDG1kn+w2FXqwfVlj3o64sFvXJ0
	bu2Lu+BNXq40+xZgMnMlb3+SDPVf8ScpNc4Qf0Mo16S1nnkobQycDcUhJDaafecM7wGw1X8CIkd97
	9sT6svOU12Asc4a0MheYddIaC5B+tGbmrqHhLrOGL8XbuEdHvOeXnKhrEjtU1WRunif+Z7o4l5ofJ
	RTK//X9Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubHjG-00000007594-2oh9;
	Mon, 14 Jul 2025 11:52:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 858E2300186; Mon, 14 Jul 2025 13:52:17 +0200 (CEST)
Date: Mon, 14 Jul 2025 13:52:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [PATCH v19 0/8] Single RunQueue Proxy Execution (v19)
Message-ID: <20250714115217.GT905792@noisy.programming.kicks-ass.net>
References: <20250712033407.2383110-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250712033407.2383110-1-jstultz@google.com>

On Sat, Jul 12, 2025 at 03:33:41AM +0000, John Stultz wrote:
> Hey All,
> 
> This is just a quick update to the v18 series, to address some
> smaller nits Peter had as well as a few build issues uncovered
> with !SMP and PREEMPT_RT that K Prateek Nayak highlighted.
> 
> So here is v19 of the Proxy Execution series, a generalized form
> of priority inheritance.

I've queued this up in queue.git/sched/core; I had to stomp on it a little
because recent other patches made conflicts. I think I did it right, but
please double check! :-)

