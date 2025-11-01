Return-Path: <linux-kernel+bounces-881032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EB5C2740A
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 01:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C6D3B9E87
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 00:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD772110E;
	Sat,  1 Nov 2025 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mhBMGSIc"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8DF1804A
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 00:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955710; cv=none; b=MjrZDDible2OcFibKgjxqozoq7FY4QgdzE4gPT8LYtFgfOaOqKULlXpJCUcnfHXaJD3n2sj56LFij/AlYhtIL8KX9WhUSmUKoRykrzVa6uwXapk9aKYBOQ4GbVfK4VMJZNlepREL9gzb3d7P19zJDprcpJQQE/k+L4L/ME8gidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955710; c=relaxed/simple;
	bh=pad/gjWGpUixHKSXyeTky6Rtp0C5JSdvHOBTuXBlQZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYJcc7moi/WYh3bqt9wD5DY2yssKNRjbqT1HLd2PDOq2HqZjIm1/DaNvutRMike2Hs9IKgGJ3MtVN8DWJS7a/hrU5NGFFrmbw8LvoPNPkOWchG7JNyNMMdg2nytdLmW0EA/N2+9XjKMUutFxfvqILXV+nulmmm8ezMNCu5Ou/1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mhBMGSIc; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dkAgA5Pw3hOQfdBPhvZT0O/RXRqugoIYYaa/9/hEr9E=; b=mhBMGSIci7+07nNJ/GENxkVA9r
	IzwVdsOLLQWgAdZzpbJ5YRDUFImhmgIZr8t3mol+GTWfiocGF6prFZFRxXen301jP5Cj2VGZEG0RN
	HGJSTMcmi0Wt8BMXcy7KC4jXLzw67WB926MPNLDNJjSaUrZ6SItn1nNYJSbtAWJQIrvyzKZXfOdor
	jxNK7DAaAzETR8yTqcJSkxYyMhPlirtkmoIYMq9dW8dM4iSMrwhub3on1xSPNldnQhOMEmPL74Jq2
	t5fnldaNvOHFQO0gcLJn9/JFmtM7CMB6wVCyaeBD7oWWXgN2WIX32aaKhKHPae4O6KloMFmfMl1ZB
	uT2Z1l8g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEyIM-0000000CDrC-3V3s;
	Fri, 31 Oct 2025 23:12:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BAA48300289; Sat, 01 Nov 2025 01:08:03 +0100 (CET)
Date: Sat, 1 Nov 2025 01:08:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Clark Williams <williams@redhat.com>, arighi@nvidia.com
Subject: Re: [RFC PATCH] sched/deadline: Avoid dl_server boosting with
 expired deadline
Message-ID: <20251101000803.GA2212249@noisy.programming.kicks-ass.net>
References: <aO5zxvoCPNfWwfoK@jlelli-thinkpadt14gen4.remote.csb>
 <20251014193300.GA1206438@noisy.programming.kicks-ass.net>
 <aO8zwouX6qIaf-U-@jlelli-thinkpadt14gen4.remote.csb>
 <20251020141130.GJ3245006@noisy.programming.kicks-ass.net>
 <8dc29e28a4d87954378ef1d989e0374526b44723.camel@redhat.com>
 <20251030184205.GB2989771@noisy.programming.kicks-ass.net>
 <20251031130543.GV4068168@noisy.programming.kicks-ass.net>
 <1f2ad071e59db2ed8bc0b382ae202b7474d07afc.camel@redhat.com>
 <20251031152005.GT3245006@noisy.programming.kicks-ass.net>
 <2daa2e6217eeaa239616303626c0d73d808ae947.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2daa2e6217eeaa239616303626c0d73d808ae947.camel@redhat.com>

On Fri, Oct 31, 2025 at 04:41:22PM +0100, Gabriele Monaco wrote:
> On Fri, 2025-10-31 at 16:20 +0100, Peter Zijlstra wrote:
> > On Fri, Oct 31, 2025 at 02:24:17PM +0100, Gabriele Monaco wrote:
> > > 
> > > Different scenario if I have the CPU busy with other tasks (e.g. RT
> > > policies), there I can see the server stopping and starting again.
> > > After I do this I seem to get a different behaviour (even some boosting
> > > after idle), I'm trying to understand what's going on.
> > > 
> 
> After running some heavy RT workload (stress-ng --cpu 10 --sched rr) I do see
> the server stopping and starting as the models would expect, but somehow it's
> always boosting as soon as it's started.
> 
> Apparently dl_defer_running is always 1 in that scenario. Perhaps running idle
> counts as running something too, so it never defers. But I can't really see how
> this happens..

The transition [4], will retain dl_defer_running, such that a timely
re-start of the dl_server can immediately run again.


