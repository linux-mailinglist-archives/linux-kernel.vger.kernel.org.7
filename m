Return-Path: <linux-kernel+bounces-844176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4B5BC13AA
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53C324EF9C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7344F2D3727;
	Tue,  7 Oct 2025 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T4Cq5GQB"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2CB7483
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836912; cv=none; b=lz/9a3we2DxCSNtZo0AcyWdcUmVTNJ6X7j8l64oHJopKWZwTrCtGW+DYybabuKvGbsgdP0XVn+SQNcLEw+wd4Ga6YBok4h9QYFYA0XnDOOKHJ3Ji1Bgz7PQczREOj9JgrAMDWY4QrpV7H9YazU0uzybjzxkSqwm8yQ+m5zkTMXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836912; c=relaxed/simple;
	bh=+65DzjZALD+pdByOWw0+IjGQTVC06aW7DSTivAUKif0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzpS7lK7LlzE06ASQwY3LYTNMNI+Dc+TD6V3n4Lms0A/e3tdp4Ja/CyOzSUuvzWdynOXLQ8lHYlXtu9lz8qqhAtaTd8LMEbv3zvim6aGLIBM0TbWYLhyqG5ErgvUzfrax3hKzjdQtL4HJs6MsEHgth/WgVsYefOlwWom8v99bxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T4Cq5GQB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=2Utf7mKwo+XM3kn2rETfTttGndMm/xQsT7TjcheaZgA=; b=T4Cq5GQBqKLrHatmXj25bgdiqv
	g3i+tzmnxvHDb13dv0L+R9QGyW08qRONBKIPX/16kuxEzeqa6CvR7ujOWeHZDkp/nAFy1gCm0X98j
	qMkZuoOHmOu8eGYwXSNNWGuimlwDP5OcYTCzAHgJ5Pts1rjKZBG6YWdd4+YtN1YzYdbQ8luxH2B1H
	zCMe6wkRc6SnwJpLqqflKFclnW9FYSaWvAC9iRRBAIoA6mDHOsEBVHN7Mp+8xvw+/QLRTA94TrDn1
	RSy0F8b16j/sywx3WXtL0cwzWyNwP4DLEeZxPS+qD9Wby3v+WlJ5NuXC4ebJH/8F/QFpRb4VZJwIy
	BzctyZPg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v65y8-0000000HaC0-1Qzz;
	Tue, 07 Oct 2025 11:35:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 35073300328; Tue, 07 Oct 2025 13:34:59 +0200 (CEST)
Date: Tue, 7 Oct 2025 13:34:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chris Mason <clm@meta.com>
Cc: Joseph Salisbury <joseph.salisbury@oracle.com>, clm@fb.com,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION][v6.17-rc1]sched/fair: Bump sd->max_newidle_lb_cost
 when newidle balance fails
Message-ID: <20251007113459.GF3245006@noisy.programming.kicks-ass.net>
References: <006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.com>
 <28340138-a00e-47bc-a36f-270a01ac83b4@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28340138-a00e-47bc-a36f-270a01ac83b4@meta.com>

On Mon, Oct 06, 2025 at 05:23:46PM -0400, Chris Mason wrote:
> On 10/6/25 4:23 PM, Joseph Salisbury wrote:
> > Hi Chris,
> > 
> > During testing, we are seeing a ~6% performance regression with the 
> > upstream stable v6.12.43 kernel (And Oracle UEK 
> > 6.12.0-104.43.4.el9uek.x86_64 kernel) when running the Phoronix 
> > pts/apache benchmark with 100 concurrent requests [0].  The regression 
> > is seen with the following hardware:
> > 
> > PROCESSOR: Intel Xeon Platinum 8167M Core Count: 8 Thread Count: 16 
> > Extensions: SSE 4.2 + AVX512CD + AVX2 + AVX + RDRAND + FSGSBASE Cache 
> > Size: 16 MB Microcode: 0x1 Core Family: Cascade Lake
> > 
> > After performing a bisect, we found that the performance regression was 
> > introduced by the following commit:
> > 
> > Stable v6.12.43: fc4289233e4b ("sched/fair: Bump sd->max_newidle_lb_cost 
> > when newidle balance fails")
> > Mainline v6.17-rc1: 155213a2aed4 ("sched/fair: Bump 
> > sd->max_newidle_lb_cost when newidle balance fails")
> > 
> > Reverting this commit causes the performance regression to not exist.
> > 
> > I was hoping to get your feedback, since you are the patch author.  Do 
> > you think gathering any additional data will help diagnose this issue?
> 
> Hi everyone,
> 
> Peter, we've had a collection of regression reports based on this
> change, so it sounds like we need to make it less aggressive, or maybe
> we need to make the degrading of the cost number more aggressive?
> 
> Joe (and everyone else who has hit this), can I talk you into trying the
> drgn from
> https://lore.kernel.org/lkml/2fbf24bc-e895-40de-9ff6-5c18b74b4300@meta.com/
> 
> I'm curious if it degrades at all or just gets stuck up high.

Right, that decay is very slow compared to the bump we give it. A little
more data there might be very useful.

If this is indeed due to lack of decay, we could look at making
update_s[gd]_lb_stats(), which is part of the regular load-balance, and has
a wider view of things, boost decay when 'sum_nr_running > nr_cpus' or
something like that. Perhaps proportional to the difference
'sum_nr_running - nr_cpus', more extra tasks more decay.

