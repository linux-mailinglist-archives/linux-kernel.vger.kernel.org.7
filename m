Return-Path: <linux-kernel+bounces-775394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1249CB2BEA1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E0D47AA673
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9346D32253E;
	Tue, 19 Aug 2025 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gU1d41wL"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A182270EC5;
	Tue, 19 Aug 2025 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598467; cv=none; b=N+LVGShbEW7lJciCi3VGc/eWODqDklog7gn1m8qLVX5weNro91Ml/eBULMyXtRkxevZHXEBG/nXvfusRZLV40ztJ6Rt9BXDMWjveFS8h2YXTMSRz7oPC7VvodP/vBTzxiuMx0j4Ty6Ded3+h1rJ69nDL8TQCRSrPIGi+v5G4kKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598467; c=relaxed/simple;
	bh=4fXsy2RwHnxDypPVftvAWzSLgWnxEwSKYpqfwfOOj/I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efccFLrUB6nC3oQOifOJCjiqIDBkNKi/+7Thqj1d8PDVdcfGjwuJUNEn7HYHHQIT2GK75q0cDyPq3+DieUFCK51JkFKvkBi2xsS8VC9KKm9d2XF0rd7+j8HyFQCY8VrCG3plZajVu/ZBvG1ls7rHJ8Dgqy2maswidPZApcgkKIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gU1d41wL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jTfFk0o9rkuryxDLznvP8p5NG9ZmamSXJKO8t6aHeGQ=; b=gU1d41wL3lESKmZWr/806Po0Th
	8VyGEh1Wz0H1Z0wvpJlkwMG0IytzEILT4hLjIQSYOyhMsmHmI3MK25xcSwN3s7dr3eJYOPKMe75Pz
	o2+f5CtXqku7AoMBbITculoTQXmuFKOLFjMidphYw+VXG+mYxrWLCptzeFj0fq0LHSxDDqAGcNcfb
	gKOgS7+6e/NGKlxOhYSRYGRDBk5cBkKChMmvwffU7Br65aGLQQ/L94ouQ2CPD4z6Pfa8O2X5r01oi
	xZNPz3bS9mbKNSz/NjbeBfqRTY9OwYQ87gE6yvLwVlrqrZEOzGKrmB4+6u5C9Vf575v97jbZrcKH5
	oSA83fuw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoJM4-000000000ih-0DQq;
	Tue, 19 Aug 2025 10:14:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5F6B030036F; Tue, 19 Aug 2025 12:14:11 +0200 (CEST)
Date: Tue, 19 Aug 2025 12:14:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: akpm@linux-foundation.org, wang.yaxin@zte.com.cn, fan.yu9@zte.com.cn,
	corbet@lwn.net, bsingharora@gmail.com, yang.yang29@zte.com.cn,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, jiang.kun2@zte.com.cn,
	xu.xin16@zte.com.cn, wang.yong12@zte.com.cn, zyhtheonly@gmail.com,
	zyhtheonly@yeah.net
Subject: Re: [PATCH] delayacct/sched: add SOFTIRQ delay
Message-ID: <20250819101411.GG4067720@noisy.programming.kicks-ass.net>
References: <20250819092739.GA31177@didi-ThinkCentre-M930t-N000>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819092739.GA31177@didi-ThinkCentre-M930t-N000>

On Tue, Aug 19, 2025 at 05:27:39PM +0800, Tio Zhang wrote:
> Intro SOFTIRQ delay, so we can separate softirq as SOFTIRQ delay
> and hardirq as {IRQ - SOFTIRQ} delay.
> 
> A typical scenario is when tasks delayed by network,
> if they delayed by rx net packets, i.e, net_rx_action(),
> SOFTIRQ delay is almost same as IRQ delay;
> if they delayed by, e.g, bad driver or broken hardware,
> SOFTIRQ delay is almost 0 while IRQ delay remains big.
> 
> Examples tool usage could be found in
> Documentation/accounting/delay-accounting.rst

accounting will be the death of us :/

How do you account ksoftirqd ?

