Return-Path: <linux-kernel+bounces-873646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0D0C1453D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B613A19C623A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC600304BC1;
	Tue, 28 Oct 2025 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dbzwL+jC"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CE82DA774
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650312; cv=none; b=W0DK9vfIXt87CQ31ElmuRPBEkHz0VbblmatLS5tCDlePWux3hHTIjsTNvvGM+zoFAa59+VJfqoMViYOLAyqRJ7oc4h52V1PqetYgIm54MyiKaIpLYbNCDDpuF78SmETh4aeY8X0tblkC602bUqtjTdIQ2zThkkwAPOPNPnFG68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650312; c=relaxed/simple;
	bh=LAsGmp/Dyx+lbUrkKX+j49ViZ2RL2iR+yZ8BTmE5K2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBlClQBUKOzAC3kmSN0VZFG5e7c+k0bTfFgRSNbgLLkJ1mfc2DlfULlOCHK+vgTUs53CMp0dBMEhkApBwMyVndyT3eDlTsxtJdz3X7GSCwD1/31zvnLwM0tZnVqCAxgne+ffL8Lk4cCPGyBEHHLCQytEYDCc0jTBVkK6IiNYL/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dbzwL+jC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vSp+YiyfoR78QY2XyJUcfKupefIxdmPNK1VTkoa8Zdg=; b=dbzwL+jCe+J1unmK9BbV0fKvjc
	UBfKAjh42+TTTgJmApwft5wjwpkdcxvxgNHLx9u7vasliZDZRLeEdioO988FYS5RliSvAKZE2hmsB
	eqPd9l/NL8XmImHq8QauCql7a00i9XXUYRZ+AbFmIwkPqnXWxCNwBtpmEbuFVZ4TVonM0lKemY3/E
	e75wk3VJVO1rYPpEQaClUn9M456SN/+D2MdfODVfgmrOZhU88vbcf5H8/5QLsjsLgK5P3eBCRIp+l
	M0Um2lKsyhJBy21rJVSLw8f3nfEjvjVTpEw4+q1vf/l0TIjCDMJ6mczQC1d1G1uwxZKaXP/RsqGdM
	0s5EtNEw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDhiP-0000000CthW-0MPW;
	Tue, 28 Oct 2025 11:18:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3CF2C300323; Tue, 28 Oct 2025 12:18:13 +0100 (CET)
Date: Tue, 28 Oct 2025 12:18:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Ben Segall <bsegall@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Nicholas Piggin <npiggin@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 1/2] sched: Feature to decide if steal should update CPU
 capacity
Message-ID: <20251028111813.GK3245006@noisy.programming.kicks-ass.net>
References: <20251028104255.1892485-1-srikar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028104255.1892485-1-srikar@linux.ibm.com>

On Tue, Oct 28, 2025 at 04:12:54PM +0530, Srikar Dronamraju wrote:
> At present, scheduler scales CPU capacity for fair tasks based on time
> spent on irq and steal time. If a CPU sees irq or steal time, its
> capacity for fair tasks decreases causing tasks to migrate to other CPU
> that are not affected by irq and steal time. All of this is gated by
> NONTASK_CAPACITY.
> 
> In virtualized setups, a CPU that reports steal time (time taken by the
> hypervisor) can cause tasks to migrate unnecessarily to sibling CPUs that
> appear to be less busy, only for the situation to reverse shortly.
> 
> To mitigate this ping-pong behaviour, this change introduces a new
> scheduler feature flag: ACCT_STEAL which will control whether steal time
> contributes to non-task capacity adjustments (used for fair scheduling).

Please don't use sched_feat like this. If this is something that wants
to be set by architectures move it to a normal static_branch (like eg.
sched_energy_present, sched_asymc_cpucapacity, sched_cluster_active,
sched_smt_present, sched_numa_balancing etc.).

