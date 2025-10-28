Return-Path: <linux-kernel+bounces-874553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17794C168FB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB6204E27D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F9334575E;
	Tue, 28 Oct 2025 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OZQdB5iV"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21928D8F4
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678272; cv=none; b=SSx8mloJ+GqU/1ZCWxiuxs16P6JZfgV8JEAzH9H65UzFFVgdTY8XJUoujhRveY0e63PRlu0XDoHaWmBteC64dWtTWaQkJFUtZryd0i5/XJFWxL2WlFSFMC1L+hp/gmz/PwUFuAlCjQS9QW8YSEGtnruwRPll3LlpTktPG25a0mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678272; c=relaxed/simple;
	bh=K/K0S9uNxaSOBN1rN5pdkkhmp7zyf8luqsky3wyoIBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKiGgJiruKGMOEyp6fUn6YyLNOd/O0zMrQq8Rs4rZI8IKNZTKc+r4vg98XU4UCKcewgIL3oT7iogknalMy3euN+Rsl7fOfWzXTup9+3szuuCxSHVmOcODdhhodixODNxGkAuuZts/wpsmRuh7p2pqOF/nnri2mbeKFuVOzXAWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OZQdB5iV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BUFS8/GDoRKUssZ1xnDZcccJ1KTIaqWaEajKYESfb+k=; b=OZQdB5iV7ahZxUJD4keMym5PmU
	4HI/IgiN21HNZE50SvnjiWrLOaL2fjCymXYFIsdoZVLslFDTSdXAymc8HpQXuUzIUjwhiZcV4u2VS
	03VYQQ9ilY3hvkT3ZUwvuBxceMp/FUVpzremIExY7CewcFNiXAEtYggLEJJ3j5oBtxzKaYXpQdfTx
	TMERPGgJ6gLSi1viUKIYw8ZwR5Gmei3CZCfbqcLINLftdzdNKnnINrA39Spx9qurjFLRbqWUGOZ8s
	tmDVI6BCCYvFvnddVuuopyjlVLl7zhoaGiAZbPjbK+FQtz/aP8iQHN33YaBPGAwTLm2q/pB+jG/Fi
	LA9kZRvw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDo7o-000000056DK-21t8;
	Tue, 28 Oct 2025 18:08:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C70B9300323; Tue, 28 Oct 2025 20:04:22 +0100 (CET)
Date: Tue, 28 Oct 2025 20:04:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] perf/x86: Add cond_resched() when allocate/release DS
 buffers
Message-ID: <20251028190422.GE3419281@noisy.programming.kicks-ass.net>
References: <20251027212724.1759322-1-namhyung@kernel.org>
 <20251028141518.GA4067720@noisy.programming.kicks-ass.net>
 <20251028152747.GR4068168@noisy.programming.kicks-ass.net>
 <aQETYiqpEo5IcTXN@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQETYiqpEo5IcTXN@google.com>

On Tue, Oct 28, 2025 at 12:02:58PM -0700, Namhyung Kim wrote:
> Hi Peter,
> 
> On Tue, Oct 28, 2025 at 04:27:47PM +0100, Peter Zijlstra wrote:
> > On Tue, Oct 28, 2025 at 03:15:18PM +0100, Peter Zijlstra wrote:
> > > On Mon, Oct 27, 2025 at 02:27:24PM -0700, Namhyung Kim wrote:
> > > > On large systems, it's possible to trigger sched latency warning during
> > > > the DS buffer allocation or release.  Add cond_resched() to avoid it.
> > > 
> > > We're >.< close to deleting cond_resched(), it makes absolutely no sense
> > > adding more.
> > 
> > Specifically, IIRC the plan was to do something like the below after the
> > next LTS release, and then continue to remove VOLUNTARY in subsequent
> > releases, leaving NONE the only option for the legacy architectures that
> > do not support preemption.
> 
> Thanks for your review!
> 
> I haven't followed the work in this area so was not aware of the
> PREEMPT_LAZY.  Looks great!  I hope it'll work well on server platforms
> with many batch jobs and interactive tasks.
> 
> I will drop my patch then.

Well, we've been trying to get people to test things... But
realistically people will only test once you force them. So we'll see.

