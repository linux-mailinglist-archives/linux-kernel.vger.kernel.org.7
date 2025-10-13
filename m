Return-Path: <linux-kernel+bounces-851249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BE26CBD5E93
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 839794E0394
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39F72D94A8;
	Mon, 13 Oct 2025 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ge8Y0naB"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEF51D5CD4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760383074; cv=none; b=E2kdZuPQYdX0C5VfctuV6IL4oNOz9iaAwWm4xiKapPiwTvQUZA6StmBoynk6tui4GJ5aT95hmig+mhBuFuOMO8vzfNnaK+CI0N/xt9Mujxj8tEPVJAjbmq1iHCCWlKjagtVt+299ZZSAziE5796NpcSsqkyy8Az/z8fvJV0Lxfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760383074; c=relaxed/simple;
	bh=O7Q0NGqLKUBRSSnOSff5T1L/FDU0YXk+Gz7I705C3HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWcMs25AakxHlmAzcb1QxqxooXsW8NUg1fHn/Y2X0VQEEdu9TqkFQ29KM3AXC1Yt6UZj10GjcEyCoV9EWrgGt4/ZqVCKUoCcEn7dFB8aC9GRVRJxhjuLJmJ0O8rMCNKl49erQSTA0E/aM5aO0p4Zpjk26r8hpNLE7XeVs97swQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ge8Y0naB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PrNMJcwae6lTG90I3gtef1BY25y/Q/nsh7n6+8UnwIQ=; b=ge8Y0naB4ZmTZl+1HE5B4V6E1P
	NWb/Amx47dbTWFXEkDsRl1mYKX4jPpSAHKEEH4ceRPC75zoyH6VMxft2T3L2BnvyXykjUuH1TGenI
	GiWvpXEoLNjr7vA+31ED5W5nBiDqa0M85ibXeTrtFKsyib47T47Z1C7gP8x6cIyCXPY2hAX8RuLuP
	//gJaj0YG6jDn3NJ8gVqpdz65xXfa7zBBfIkowjP+7hMkqAt2JBmUsfQGZs++o5ydb6gqrmDWYeLu
	oF1cdNF3gCz5Vyv0tj3f+pY448m89GsZMAdA5CtowiOWB85CEGxVPK6nDaGHkxlanpS4eSP0PZfI/
	tQECz8TA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8O3C-00000004aCg-1sNo;
	Mon, 13 Oct 2025 19:17:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EBA8C300212; Mon, 13 Oct 2025 21:17:41 +0200 (CEST)
Date: Mon, 13 Oct 2025 21:17:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Doug Berger <opendmb@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/deadline: only set free_cpus for online
 runqueues
Message-ID: <20251013191741.GC2734756@noisy.programming.kicks-ass.net>
References: <20250815012236.4053467-1-opendmb@gmail.com>
 <aKMja4BvgQ5vFaNN@jlelli-thinkpadt14gen4.remote.csb>
 <20250903075436.GN3245006@noisy.programming.kicks-ass.net>
 <5bb8ad3a-9d05-4d07-8d4b-207be28cceb1@gmail.com>
 <88998fa9-b454-45c1-a8e2-164d2e2d94c0@gmail.com>
 <20251006184710.GX3245006@noisy.programming.kicks-ass.net>
 <1dc04a7b-d17b-4bca-9391-7d06d0c563fd@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dc04a7b-d17b-4bca-9391-7d06d0c563fd@broadcom.com>

On Mon, Oct 13, 2025 at 11:22:36AM -0700, Florian Fainelli wrote:
> On 10/6/25 11:47, Peter Zijlstra wrote:
> > On Tue, Sep 23, 2025 at 11:03:18AM -0700, Doug Berger wrote:
> > 
> > > 
> > > Is there any way I can help to move this patch forward?
> > 
> > Let me just apply it before it gets lost again. Sorry; sometimes the
> > amount of email is turning me into a goldfish with ADD :/
> 
> Should we be able to see that patch in linux-next by now?

Should be in queue.git as of today, once the robot reports success I'll
push it towards tip.git, at which point it'll show up in -next.

