Return-Path: <linux-kernel+bounces-842768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA68BBD84E
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EED0A4EA5DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C50B2116E7;
	Mon,  6 Oct 2025 09:53:56 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4381F2BB5
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744435; cv=none; b=eyt3JuUMTcNrimC0WzkWTkti+kVsAvMNIhPjjDOmDpK4Mycj/ApNWdgAG8e9rs10YGmSCryrqYw+Ce6trdTc/i8ApHyx+Ep6RX0liKDUUPklqt5ZIzPB/Z8WEsPqprfzLRVMc6lSkPs3DenV4uwYi0MJO590ZBpxbaalm6OA8/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744435; c=relaxed/simple;
	bh=NFKU/d1VNslHPHjRed4LBghQn+v8hjBZCkuybwQb9Vc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMHsNB4Nr9cqrUb2Af/k2REG7A11iUO2DY6o4rRo/v8s2h4TtAqtOD+6KnmGbseGfr8VsRGfZpMpfVNDLZfrm1bwLann0XR/KBYia96Wm2+inGBfe5cMUxnsqrcKjlKCu8JFYAtOMptUMzaDIZgnDqqkM6dRz3pfvTPsoRnXFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cgF2P1b5Dz6L51s;
	Mon,  6 Oct 2025 17:53:17 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id CFE04140276;
	Mon,  6 Oct 2025 17:53:49 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 6 Oct
 2025 10:53:48 +0100
Date: Mon, 6 Oct 2025 10:53:46 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Bharata B Rao <bharata@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<dave.hansen@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <peterz@infradead.org>,
	<raghavendra.kt@amd.com>, <riel@surriel.com>, <rientjes@google.com>,
	<sj@kernel.org>, <weixugc@google.com>, <willy@infradead.org>,
	<ying.huang@linux.alibaba.com>, <ziy@nvidia.com>, <dave@stgolabs.net>,
	<nifan.cxl@gmail.com>, <xuezhengchu@huawei.com>, <yiannis@zptcorp.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <byungchul@sk.com>,
	<kinseyho@google.com>, <joshua.hahnjy@gmail.com>, <yuanchu@google.com>,
	<balbirs@nvidia.com>, <alok.rathore@samsung.com>
Subject: Re: [RFC PATCH v2 8/8] mm: sched: Move hot page promotion from
 NUMAB=2 to kpromoted
Message-ID: <20251006105346.00004634@huawei.com>
In-Reply-To: <b13fc805-728a-494e-93ea-f2dea351eb00@amd.com>
References: <20250910144653.212066-1-bharata@amd.com>
	<20250910144653.212066-9-bharata@amd.com>
	<20251003133818.000017af@huawei.com>
	<b13fc805-728a-494e-93ea-f2dea351eb00@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 6 Oct 2025 11:27:21 +0530
Bharata B Rao <bharata@amd.com> wrote:

> On 03-Oct-25 6:08 PM, Jonathan Cameron wrote:
> > On Wed, 10 Sep 2025 20:16:53 +0530
> > Bharata B Rao <bharata@amd.com> wrote:
> >   
> >> Currently hot page promotion (NUMA_BALANCING_MEMORY_TIERING
> >> mode of NUMA Balancing) does hot page detection (via hint faults),
> >> hot page classification and eventual promotion, all by itself and
> >> sits within the scheduler.
> >>
> >> With the new hot page tracking and promotion mechanism being
> >> available, NUMA Balancing can limit itself to detection of
> >> hot pages (via hint faults) and off-load rest of the
> >> functionality to the common hot page tracking system.
> >>
> >> pghot_record_access(PGHOT_HINT_FAULT) API is used to feed the
> >> hot page info. In addition, the migration rate limiting and
> >> dynamic threshold logic are moved to kpromoted so that the same
> >> can be used for hot pages reported by other sources too.
> >>
> >> Signed-off-by: Bharata B Rao <bharata@amd.com>  
> > 
> > Making a direct replacement without any fallback to previous method
> > is going to need a lot of data to show there are no important regressions.
> > 
> > So bold move if that's the intent!   
> 
> Firstly I am only moving the existing hot page heuristics that is part of
> NUMAB=2 to kpromoted so that the same can be applied to hot pages being
> identified by other sources. So the hint fault mechanism that is inherent
> to NUMAB=2 still remains.

That makes sense.

> 
> In fact, kscand effort started as a potential replacement for the existing
> hot page promotion mechanism by getting rid of hint faults and moving the
> page table scanning out of process context.

Understood and I'm in favor of the that approach but not sure it will be
a fit for all workloads.

> 
> In any case, I will start including numbers from the next post.

Great.

> >>  
> >>  static unsigned int sysctl_pghot_freq_window = KPROMOTED_FREQ_WINDOW;
> >>  
> >> +/* Restrict the NUMA promotion throughput (MB/s) for each target node. */
> >> +static unsigned int sysctl_pghot_promote_rate_limit = 65536;  
> > 
> > If the comment correlates with the value, this is 64 GiB/s?  That seems
> > unlikely if I guess possible.  
> 
> IIUC, the existing logic tries to limit promotion rate to 64 GiB/s by
> limiting the number of candidate pages that are promoted within the
> 1s observation interval.
> 
> Are you saying that achieving the rate of 64 GiB/s is not possible
> or unlikely?

Seem rather too high to me, but maybe I just have the wrong mental model
of what we should be moving. 
> 
> >   
> >> +
> >>  #ifdef CONFIG_SYSCTL
> >>  static const struct ctl_table pghot_sysctls[] = {
> >>  	{
> >> @@ -44,8 +50,17 @@ static const struct ctl_table pghot_sysctls[] = {
> >>  		.proc_handler	= proc_dointvec_minmax,
> >>  		.extra1		= SYSCTL_ZERO,
> >>  	},
> >> +	{
> >> +		.procname	= "pghot_promote_rate_limit_MBps",
> >> +		.data		= &sysctl_pghot_promote_rate_limit,
> >> +		.maxlen		= sizeof(unsigned int),
> >> +		.mode		= 0644,
> >> +		.proc_handler	= proc_dointvec_minmax,
> >> +		.extra1		= SYSCTL_ZERO,
> >> +	},
> >>  };
> >>  #endif
> >> +  
> > Put that in earlier patch to reduce noise here.  
> 
> This patch moves the hot page heuristics to kpromoted and hence this
> related sysctl is also being moved in this patch.

I just mean the blank line - not the block above.
This is just a patch set tidying up comment.

Jonathan



