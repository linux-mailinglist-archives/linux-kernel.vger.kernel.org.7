Return-Path: <linux-kernel+bounces-877902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD730C1F4BE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE79A188A62F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B013112C1;
	Thu, 30 Oct 2025 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dInDxbEa"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77BB341678
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816627; cv=none; b=Q018y5hNp47A08i2OGBz8y7wlqo0ADyO072NbYQonZ8Bg7QNYUUS5FH1uux35IemKQiPTQl8s7FnUMQ6EzXv2cgETGz83QOvJBYah2vI9lDHrp5Qw5HjV3DrYZlwd9EpFwNpM6WV0KjWr5+OpVG1bL5ldrepydRBey1QEcfcLmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816627; c=relaxed/simple;
	bh=5GlMRQtGH2G2gDAvQEsZfUFiG9JUxvh98BBVJOE8/lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubajCzO8gj0XOW3e/t7fQuqlU8TMP4Sch5wfWH7211uJn9pMb5p6ckLdzaSXBn0kpWQ1HxzK22PUI8KJDF6sRll3yDpN5lJuipczAkPmHD61XAKcpa0g/+M4PEry0Ao0t/0SO9T2BvDwz5cR/wxBbvBe9BAswRAAM0M4cJDz36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dInDxbEa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/nDypDsdSKuowBHLqpSMoZOwLxsLaOUn0lb2AWVf9v4=; b=dInDxbEasc+47t+VNB40tKpYzN
	iuLOWtWEL8L6MK17CVdNKcylRdnpzJWxidxy08xuuCjOJGHJsGFw4J+PDHZQ68uqSyR0Vq8xOOtq5
	gfjYpFtuQieGBtigMfGBnq+QR7lK0a4av1P+H/2GmgcCa8kYRizhb26uSdqc6HGgwtS7UMN3+kWwM
	JmXZHPVwqtfnK/zsA+PRXNkpPpJ+cAlg0c7l88dz7K8DGlMLkGBDU5V2zs1j9FQk+EXnSUuINim3O
	d0TmyCvtUmXjHWS3G1HCwOpJ1+zJojQPGZij4qeAFNJW7c5DDu+QUQUtI/tfC5CK6S9KPgKH0+Exu
	FWPseAIg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEOyz-00000001bSO-2QKR;
	Thu, 30 Oct 2025 09:30:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4F2D630029E; Thu, 30 Oct 2025 10:30:13 +0100 (CET)
Date: Thu, 30 Oct 2025 10:30:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Adam Li <adamli@os.amperecomputing.com>
Cc: Joseph Salisbury <joseph.salisbury@oracle.com>,
	Chris Mason <clm@meta.com>, clm@fb.com,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] : Re: [REGRESSION][v6.17-rc1]sched/fair: Bump
 sd->max_newidle_lb_cost when newidle balance fails
Message-ID: <20251030093013.GI4067720@noisy.programming.kicks-ass.net>
References: <006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.com>
 <28340138-a00e-47bc-a36f-270a01ac83b4@meta.com>
 <20251007113459.GF3245006@noisy.programming.kicks-ass.net>
 <36545e62-9947-43ef-9bc1-776f5663a45c@oracle.com>
 <20251010170937.GG4067720@noisy.programming.kicks-ass.net>
 <2aa7380b-bebd-4bb9-8597-49e06d1dcc6d@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aa7380b-bebd-4bb9-8597-49e06d1dcc6d@os.amperecomputing.com>


Hi Adam,

On Thu, Oct 30, 2025 at 03:22:34PM +0800, Adam Li wrote:

> Commit 155213a2aed4 brings ~6% regression for SpecJBB critical-jOPS on
> AmpereOne server. 
> 
> Baseline: v6.17 kernel + patch. Compared with baseline:
> NI_TARGET	+7%
> NI_SPARE	-3%
> NI_RUNNABLE	-4%
> NI_RANDOM	-3%
> 
> So NI_TARGET reverts the performance regression.
> The other options brings more regression for SpecJBB.

Excellent, how does NI_TARGET+NI_RANDOM work for you? Like Chris, I
found that the schbench workload was really suffering from doing too
many idle balance attempts that weren't really working out.

NI_RANDOM reduces the number of newidle balances based on the success
ratio. Eg. if you have successful balancing 25% of the time, it will do
1 in 4 balances and count a successful balance as 4 to keep the
accounting straight.

So workloads with a high success rate will keep newidle balance calls
frequent, while workloads with a low success rate (like schbench) will
greatly reduce the number of calls.

