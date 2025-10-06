Return-Path: <linux-kernel+bounces-843398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC62ABBF1B4
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 21:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87B4F34B21A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 19:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891921E412A;
	Mon,  6 Oct 2025 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="De1mZsGx"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B651D5151
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779276; cv=none; b=EStwE8Y+z5u1Q4tTTfv91+MOz6G6Hai07Mk7UEkqMv88gEvug5oW39Um3R5gwvWLKqyAX5CGWFaR97Ze9shR3qnZf2x+PVaKZLsHYHv86/PBj+Z5Ir1HsxgJIEh0kuKwFDT6znOnVeK7gcr8k1GTIe4+K+vvwjrkq2BXF51bedI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779276; c=relaxed/simple;
	bh=JDJm+S2bjTSWK4cQZ0ryS8ysnVXj9nnpU9GqHnB4+zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmjtRbLexhAz4PNdOe7nc/kv7n2uZd6azuvveTVJpaPyWKV//uPPW8IP7sYD99SzPu0OknUDRxDQRIc4rCMtxbd8PSiOJLev0iuoPPAoIF2ws5zquoREioLpG/RaZQiuysHcBthGYFMrG0HN0bzHHWoJA7VT5t8qMMiTM8+skFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=De1mZsGx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8tVVPMvuMGyIPyxoYSnAZGOks6trTfJpXRjbeOgyePk=; b=De1mZsGxipy+wMWo8qPcYohkdb
	lkUcX8DgLOwzbmdczKDvMFppg69OiPp1tUgX/74E5t3KaTqQGSd9wysm56+1oVUhLEFk3EHzKEwqN
	xJa1kKS1ZcdUYoU0da0YogvCFGMSItW3twfNjJI60DHKQx+AaVq8JadtUlCt9TChhcV8gZDqG/1GU
	ZT4zV2GNybfbEOuhs3TC4S11WyIQZbzcspB8OpSCQ/mz/Pida0f+vvBjT2L02SuBpq5gl1QDkb+CP
	NtyZrw1OpmTBtYZneLnnAk3iKaUqeNXAR69drp2xF/bFTfQj1+eU8AbzaW5dEjPdErTDCEThAG8Rt
	6U1hXFtQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5qyV-0000000H8bA-3rBL;
	Mon, 06 Oct 2025 19:34:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B8EDF300325; Mon, 06 Oct 2025 21:34:21 +0200 (CEST)
Date: Mon, 6 Oct 2025 21:34:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: Re: [PATCH v5 0/2] Fix NUMA sched domain build errors for GNR and CWF
Message-ID: <20251006193421.GA3245006@noisy.programming.kicks-ass.net>
References: <cover.1759515405.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759515405.git.tim.c.chen@linux.intel.com>

On Fri, Oct 03, 2025 at 12:31:26PM -0700, Tim Chen wrote:

> Tim Chen (2):
>   sched: Create architecture specific sched domain distances
>   sched/topology: Fix sched domain build error for GNR, CWF in SNC-3
>     mode
> 
>  arch/x86/kernel/smpboot.c      |  70 +++++++++++++++++++++
>  include/linux/sched/topology.h |   1 +
>  kernel/sched/topology.c        | 108 ++++++++++++++++++++++++++-------
>  3 files changed, 157 insertions(+), 22 deletions(-)

Right, I suppose this'll do. I'll throw it on the pile for post -rc1 or
so.

