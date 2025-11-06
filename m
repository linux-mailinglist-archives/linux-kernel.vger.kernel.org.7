Return-Path: <linux-kernel+bounces-888349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D711C3A92B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60EA04E9081
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B5930EF8B;
	Thu,  6 Nov 2025 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GedZhs0+"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB4330EF7E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428462; cv=none; b=AkVHmxarMud1Mmdy2X3e/NLOnZdtI3UzJmsz6bgUpSLdVVxP6Ot4fS+HdfC8ror0dBWRLGSyP4YfRaiYGaHSGd66NrhCbRIcr9KqEFBZT6aUh1vFdrdMJaGUq/QAEgWCfjI6FVYfoRbAFnozEsBR0LR/BEqDnEj4Edd0bJVhFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428462; c=relaxed/simple;
	bh=5l1A11byDhaH/ZXfLz1/7aeITzhmtLT6BGEzFNt/pvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maBBn8/hwhvGy7zWkSo3nT6De9fT+by0WAlt65WK4cJRACtuxT1gV2Kpw4RaoA6q3oP96siWFhmJjVT6Qsh+OFD4JXW/Q//wJkCRrUXTwWg2UHzZ5WorGoSko3TrmTVaBtU2AOYgBL/PlRzsP+9/xskSULLXjMYjAQsFTM9JuaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GedZhs0+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QVQzJEMAxtUvD+13LPpc2potBJpYJoIMM8+6hUy+fY4=; b=GedZhs0+TV7qeE3nByH4P5lUHM
	/1wU/NJ18qMRxVYHo2WYW0kksuOk2bXXfU3/ZhUhqax54ETGjPWSJ+MistZsZM0O5Y/ZErnFlQOXn
	vwYGx/RxVJtR6l7ipSs/MpCjIbVlO2bX/U94ulsGyxvDfV49VMO+n11Oft3PSXDS/njTk2Eg+ZMoN
	PkvwE44Psd71rrLfnsMuFUMENKwdOwll+0FWGjeCTrvpdoexc9QDiZzkVEOI53g5dT3bq46kCy9Pq
	TMTAquX8Dc1itTXiufJVrhHIa0W+ZyD3t0Bob+F4m748TWl2tjQw88diPiozSKXHsHamEtucr1YEi
	YZUwQsLg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGxHU-0000000488a-3p9M;
	Thu, 06 Nov 2025 10:31:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6C05E300230; Thu, 06 Nov 2025 12:27:21 +0100 (CET)
Date: Thu, 6 Nov 2025 12:27:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Benjamin Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Hao Jia <jiahao.kernel@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3] sched/fair: Prevent cfs_rq from being unthrottled
 with zero runtime_remaining
Message-ID: <20251106112721.GS3245006@noisy.programming.kicks-ass.net>
References: <20251030032755.560-1-ziqianlu@bytedance.com>
 <xm26346sjh47.fsf@google.com>
 <20251106112500.GA471@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106112500.GA471@bytedance>

On Thu, Nov 06, 2025 at 07:25:00PM +0800, Aaron Lu wrote:
> On Wed, Nov 05, 2025 at 01:37:28PM -0800, Benjamin Segall wrote:
> ... ...
> > Reviewed-By: Benjamin Segall <bsegall@google.com>
> 
> Thank you Ben.
> 
> Hi Peter,
> 
> Do you have any other comments about this patch? Or do I need to send an
> updated version with all the tags collected? Thanks.

I can tag the whole thread (esc-t) and pipe the whole lot through b4 to
easily do so -- in fact I just did :-)

This was meant to go in sched/urgent, right?

