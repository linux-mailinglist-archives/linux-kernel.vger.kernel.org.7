Return-Path: <linux-kernel+bounces-857320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6019EBE6814
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04BE74FB1F6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E0330DD02;
	Fri, 17 Oct 2025 05:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="n63Sp1II"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC330BBA2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760680540; cv=none; b=E5dWc3VGMr6uqJsRCeudnyOYMZOo5AJxDKlhlF5snz+F7YFIQcRlHWlL2OfY2UzoOolLHC7MKM4L5itCYBCsrTb7t/xcpQllvSI3B1mZ4s8n/EBjVgBRWsbMJsLrSGh/10MNQKRXgiuH0lC3k51oyZZcMPYIpbA9pVxJKsaOfJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760680540; c=relaxed/simple;
	bh=al+HM2jB2DFyyB1Lo1/D5J8i31jMvnZ+3iAomvarhI4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=pmrdG6c/be7GBQ6wuVyqrbnMDdt+tr4Fy3OU45HYA0akRlE5L6gd+Z0ZvjjmEEqvCho4LVtuGeLDSgd6cqcf0yPNVfZhXVE7MSZIKxxdT3z3OXoEtk/YUMSVKXsLHKqDG1KVB4Rhbv5JBBAJwzFtZkpmrtW0C8cPAwQ7czMpPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=n63Sp1II; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251017055530epoutp016a10cda622c64add2fe8b358586f0b42~vMZ0kTYvY2861628616epoutp01E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:55:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251017055530epoutp016a10cda622c64add2fe8b358586f0b42~vMZ0kTYvY2861628616epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760680530;
	bh=7fM4AzR1nJU2ZM7NlVXiO8tBQaJZuL012ult4XXGHyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n63Sp1IIwOthD6jdaTIkcWJ/vtBOuqyO5JrT9Scy2IM2kWC74eYknvd1xziPgIZ1A
	 FeZHC2mv+CRdvCImWvKCwrUhjLkGE3r4b0ozERJWSxBCkutZ9WpMkqz50h0oQq0//m
	 fxAh7BnwIBOsm4VXQFFQxrVWO2i/JJmyKfUJJQcE=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20251017055526epcas2p31cac8ee16c0bb46abc3ae7b3eec7b3cc~vMZwktURS1352713527epcas2p3a;
	Fri, 17 Oct 2025 05:55:26 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.209]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cnvDs4mMKz2SSKd; Fri, 17 Oct
	2025 05:55:25 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20251017055524epcas2p2b7cadb80f5d09c4003ccb66d4c39c9dc~vMZvaxaeS2233722337epcas2p2w;
	Fri, 17 Oct 2025 05:55:24 +0000 (GMT)
Received: from perf (unknown [10.229.95.91]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20251017055524epsmtip17f2d85c56e9b08636122013814729936~vMZvVgE0t2236022360epsmtip1G;
	Fri, 17 Oct 2025 05:55:24 +0000 (GMT)
Date: Fri, 17 Oct 2025 15:01:05 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, peterz@infradead.org,
	mingo@redhat.com, vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, m.szyprowski@samsung.com,
	venkat88@linux.ibm.com, jstultz@google.com, d7271.choe@samsung.com,
	soohyuni.kim@samsung.com, bongkyu7.kim@samsung.com,
	youngmin.nam@samsung.com, jkkkkk.choi@samsung.com
Subject: Re: [PATCH] sched/deadline: stop dl_server before CPU goes offline
Message-ID: <aPHbXxJRUTdkBZVA@perf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aO4Tw1SzNpgWutK8@jlelli-thinkpadt14gen4.remote.csb>
X-CMS-MailID: 20251017055524epcas2p2b7cadb80f5d09c4003ccb66d4c39c9dc
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----PDOc320tARUDg5oiqWLD4tz058SOCZsoCdAHhD7Rt0rJ7P1y=_b9054_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251017055524epcas2p2b7cadb80f5d09c4003ccb66d4c39c9dc
References: <20251009184727.673081-1-sshegde@linux.ibm.com>
	<aO4Tw1SzNpgWutK8@jlelli-thinkpadt14gen4.remote.csb>
	<CGME20251017055524epcas2p2b7cadb80f5d09c4003ccb66d4c39c9dc@epcas2p2.samsung.com>

------PDOc320tARUDg5oiqWLD4tz058SOCZsoCdAHhD7Rt0rJ7P1y=_b9054_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Oct 14, 2025 at 11:11:31AM +0200, Juri Lelli wrote:
> Hello,
> 
> On 10/10/25 00:17, Shrikanth Hegde wrote:
> > From: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > IBM CI tool reported kernel warning[1] when running a CPU removal
> > operation through drmgr[2]. i.e "drmgr -c cpu -r -q 1"
> > 
> > WARNING: CPU: 0 PID: 0 at kernel/sched/cpudeadline.c:219 cpudl_set+0x58/0x170
> > NIP [c0000000002b6ed8] cpudl_set+0x58/0x170
> > LR [c0000000002b7cb8] dl_server_timer+0x168/0x2a0
> > Call Trace:
> > [c000000002c2f8c0] init_stack+0x78c0/0x8000 (unreliable)
> > [c0000000002b7cb8] dl_server_timer+0x168/0x2a0
> > [c00000000034df84] __hrtimer_run_queues+0x1a4/0x390
> > [c00000000034f624] hrtimer_interrupt+0x124/0x300
> > [c00000000002a230] timer_interrupt+0x140/0x320
> > 
> > Git bisects to: commit 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
> > 
> > This happens since: 
> > - dl_server hrtimer gets enqueued close to cpu offline, when 
> >   kthread_park enqueues a fair task.
> > - CPU goes offline and drmgr removes it from cpu_present_mask.
> > - hrtimer fires and warning is hit.
> > 
> > Fix it by stopping the dl_server before CPU is marked dead.
> > 
> > [1]: https://lore.kernel.org/all/8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com/
> > [2]: https://github.com/ibm-power-utilities/powerpc-utils/tree/next/src/drmgr
> > 
> > [sshegde: wrote the changelog and tested it]
> > Fixes: 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Closes: https://lore.kernel.org/all/8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> 
> Looks good to me.
> 
> Acked-by: Juri Lelli <juri.lelli@redhat.com>
> 
> Thanks!
> Juri
> 

Hi All,

Could we expect this patch to address the following issue as well?

https://lore.kernel.org/all/aMKTHKfegBk4DgjA@jlelli-thinkpadt14gen4.remote.csb/

Thanks,
Youngmin.

------PDOc320tARUDg5oiqWLD4tz058SOCZsoCdAHhD7Rt0rJ7P1y=_b9054_
Content-Type: text/plain; charset="utf-8"


------PDOc320tARUDg5oiqWLD4tz058SOCZsoCdAHhD7Rt0rJ7P1y=_b9054_--

