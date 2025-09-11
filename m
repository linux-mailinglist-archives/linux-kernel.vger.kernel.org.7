Return-Path: <linux-kernel+bounces-811504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A78FB52A11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEE4A03785
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6031F27145C;
	Thu, 11 Sep 2025 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZqvbbKnr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C126F2BF;
	Thu, 11 Sep 2025 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575989; cv=none; b=s6Z3lnTKDKrcFFHk+dSshtp11RjOJdCko936FP77mZLWqu/96nC/1xZAgjCoqnweEs1JMAfFccK3BgUBzoQ3nB66mbiTWaug+42KdYH0W0iR1CFP0qqI4kqV+hqc7YdDxlMTmCFZCIQrpd47bKu9ZnLxzTQnfa1AxVbeWRQzDFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575989; c=relaxed/simple;
	bh=9+pa/D3f6IpuzMuACV6MmhwneOZUp19D7ShXU5203Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMlUZn1SnxYwpC0mPsHiyXlLPxY2fPEQq7AVoMwpi99QfveYmHE1mY8ELkwsRhyKhou47JXM66G7gbPuyRjKElq3G73SZhDX23VH5X28V/u+aWT3sn8b3PSL82quiwQOhdYiH+ci9Y4Fb63s0iXWmQTZmiI0Pv6giC73OEDltRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZqvbbKnr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HVvQa9SOqLHMTxw8NFeJPlkH74zoT6Dz15q00+3yi04=; b=ZqvbbKnra9TL9wPWb16iFjQcTp
	UWv3sTU0z68K0LO+/JdHgxeiKextSrCkFGotpwu7U1QaW8gu54F788QkXWAHnGC0UxxOvy9m9ot25
	0tLXuieOr5pN3/2Hbkk2PrLi6MU/SEryFJSvpAhkkVVuhNB6omVxPLwvRCzxbXRWYOjezQSnpC1le
	2ZV+LOmE/G/JuuWmDoko6ZZUVlwdIbVWMu8uCcPTNrcVNhxx8FMd/n63tuPMwJeHOlnUxuCD63Ebq
	x1UyxTBk4WSRijRPHe8ClVgMIzNu2tbJ7ZunrpGlSJOjP+tjoc4SQ125DrlCfiJp4FogfUgNEunPX
	Sde6P+og==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwbnl-00000006doZ-0qOk;
	Thu, 11 Sep 2025 07:33:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BC30A300399; Thu, 11 Sep 2025 09:33:04 +0200 (CEST)
Date: Thu, 11 Sep 2025 09:33:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:sched/hrtick] [entry,hrtimer,x86] ebf33ab570:
 BUG:soft_lockup-CPU##stuck_for#s![pthread_mutex1_:#]
Message-ID: <20250911073304.GN4067720@noisy.programming.kicks-ass.net>
References: <202509081329.81f1ed82-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202509081329.81f1ed82-lkp@intel.com>

On Mon, Sep 08, 2025 at 01:24:54PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![pthread_mutex1_:#]" on:
> 
> commit: ebf33ab5707c7c9ea25e3c03540b1329ad9aff1d ("entry,hrtimer,x86: Push reprogramming timers into the interrupt return path")
> https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/hrtick
> 
> in testcase: will-it-scale
> version: will-it-scale-x86_64-75f66e4-1_20250906
> with following parameters:
> 
> 	nr_task: 100%
> 	mode: thread
> 	test: pthread_mutex1
> 	cpufreq_governor: performance
> 
> 
> 
> config: x86_64-rhel-9.4
> compiler: gcc-13
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 

Is this the same issue again as last time? Eg. disabling all the perf
monitors makes it go?

