Return-Path: <linux-kernel+bounces-819642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B281B5A3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307F2327679
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A192E7BC0;
	Tue, 16 Sep 2025 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bEq6jBrj"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6EC27AC3E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058249; cv=none; b=UWyR+KA0yVJrlcABdHtia8uqscXdvClaH+j0QOgG6UUXv7+i667macinT5KgsBp3nvlUelX1f11n68yj0usjAKo6oLleNB/yJqS9CskDfQZiI2hfrTdkpP2xSLX7iNqbPHBZ5Z9geKrl6a4bGEavW2t/4e4ag3Fq4Cz4LJwwpiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058249; c=relaxed/simple;
	bh=uuuykiy+fXLhx1UXBcRYiN22+ScQo9str+gryyZiAQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAJOISWCg47x+ERlsrkTbHhrfwQ+aTM/xXHvFM33/+wljvmWByUhx/ILyiS44afr0oCm7ChnJq1uBYJUJaRiXlSN6jTanuS41TcfpjvePacv+Dnx/lE5undzBTN2M2waQriyTya+d2f1v14N/TI/K2MOLhGi7p6vRswpT6tCPsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bEq6jBrj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uuuykiy+fXLhx1UXBcRYiN22+ScQo9str+gryyZiAQM=; b=bEq6jBrjfA6kN9TFZmK/LCy0IO
	h0/IjbABHAJQ4Jqj89vQSWvQmTbxv/sf9lclXcfc9dzUMutRsqB3LSwULxU+RQ7Pr6eh6BOuaBzC9
	th1JAs6mvk+QfXp3e2NvLvvsvBMD+fZK/C+hD/PEFjnSCg23RcAfCFX1V7adCnbMAEwb+5CffMFB/
	YIRwT3K7xENIlWhg2H/geVZwzR1TNKgnfEOTmmo0IBH4emjZhV54f4lNWr8uj8s4j+puCJ5ZKzPEw
	Yee6Hv4MBB/3VkKqH2IDeQ6+Ktrz8Iw5YjqA4pfsnRkBUGekDKzJa47jXx0LMMohlXG7eJXdcwkA1
	q+3KnGDQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uydG1-0000000DnVV-19GL;
	Tue, 16 Sep 2025 21:30:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 41AA5300212; Tue, 16 Sep 2025 23:30:36 +0200 (CEST)
Date: Tue, 16 Sep 2025 23:30:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Qais Yousef <qyousef@layalina.io>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [RFC][PATCH] sched/deadline: Fix dl_server getting stuck,
 allowing cpu starvation
Message-ID: <20250916213036.GC2800598@noisy.programming.kicks-ass.net>
References: <CANDhNCreD8f6pPjUa--UzXicJr=xnEGGbKdZhmJCeVPgkEV-Ag@mail.gmail.com>
 <20250916052904.937276-1-jstultz@google.com>
 <aMklFqjbmxMKszkJ@jlelli-thinkpadt14gen4.remote.csb>
 <20250916110155.GH3245006@noisy.programming.kicks-ass.net>
 <CANDhNCqJbnemY8EBYu=4w3ABfrDkuc+dUShDDcjufFpsh7qv1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCqJbnemY8EBYu=4w3ABfrDkuc+dUShDDcjufFpsh7qv1g@mail.gmail.com>

On Tue, Sep 16, 2025 at 10:35:46AM -0700, John Stultz wrote:
> I of course still see the thread spawning issues with my
> ksched_football test that come from keeping the dl_server running for
> the whole period, but that's a separate thing I'm trying to isolate.

So what happens with that football thing -- you're saying thread
spawning issues, so kthread_create() is not making progress?

You're also saying 'keeping the dl_server running for the whole period',
are you seeing it not being limited to its allocated bandwidth?

Per the bug today, the dl_server does get throttled, not sufficiently?

