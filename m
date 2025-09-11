Return-Path: <linux-kernel+bounces-811865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C66B52ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363A116B2C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2410325EFBC;
	Thu, 11 Sep 2025 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NZBJGG2o"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E369E29A2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587364; cv=none; b=bNqF06XeHuEf/A4HV2JRzoxriAsPvnxTPEog0ztPkbeUQEi3rkze5MMPSn6tLkCJ1ZTXnDinKaT/qVbLm6a3Kuqp6mnCr7pOf9+yjhTBNzin3jxCq75Y7D76llUlpjjKM51dub+JixeiWoNwPxTJF6eOk4J7bvnpfsd/JxZLGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587364; c=relaxed/simple;
	bh=om2dTFImFoFSzPQpiCtf4X9C/9x/PRJoxbQWt/S0LuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOH0gFDlwQ8JRkmMWta6Vc4ukg8N1qrvKxmDyCi1AXAAtri0LlX1TudN2w+SrAmm4MXa3wOnD/26Uw9ewxPtPnQLrXcdRdPs2do3SyNP3L1dCR5y1kw29aASwW4H9JTj0+2svQSl7qbKLMT6eyaxuHV3SNX2hIg+cVImX8U+AEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NZBJGG2o; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7eK2DJWfYWExLb1+m/hu10EP82qkEs+OWXqmC/tg+BM=; b=NZBJGG2oA3Z+R32ZZnX+ZNxgCP
	KYh3ziuVMi0QR16Q+cpJFiXCK3Wunx5cGOANzgUI9GvTx1kfCo7Tw1JtJ76WgYkCvjKuMcLv9Ftq7
	M5/dlHzKRkFG6GGK3h217hKzs86mA5n7CPA9z9xhRddou7TDmwHJZobeIxjR4Q+0SFHGsbiRn+AXf
	1Gi5xPqSJNseLfR6+NKuKMDhYn2408xG4aqp95lRwT3/oVIQB+Cz/NboOTTSvAB+YB9/kMPYmcC05
	zAJv3mNABxH4y6ADrX3dLCQIH3P/uM9V9ym/+hDT2ylhFyZg/Hlmi7Ik7DYFedu/qkmXdqzQfmS3i
	rAFnDtjA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwekx-00000009HyX-2ztV;
	Thu, 11 Sep 2025 10:42:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6CAE83002EB; Thu, 11 Sep 2025 12:42:22 +0200 (CEST)
Date: Thu, 11 Sep 2025 12:42:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
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
Subject: Re: [PATCH 0/4] Task based throttle follow ups
Message-ID: <20250911104222.GY3289052@noisy.programming.kicks-ass.net>
References: <20250910095044.278-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910095044.278-1-ziqianlu@bytedance.com>

On Wed, Sep 10, 2025 at 05:50:40PM +0800, Aaron Lu wrote:

> Aaron Lu (4):
>   sched/fair: Propagate load for throttled cfs_rq
>   sched/fair: update_cfs_group() for throttled cfs_rqs
>   sched/fair: Do not special case tasks in throttled hierarchy

I stuffed these first 3 into queue/sched/core, leaving this one:

>   sched/fair: Do not balance task to a throttled cfs_rq

on the table, because the robot already hated on it.

If anybody disagrees with one of the queued patches, holler and I'll
make it go away. Otherwise they should show up in tip 'soonish'.

