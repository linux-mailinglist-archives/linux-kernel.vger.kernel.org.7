Return-Path: <linux-kernel+bounces-855685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EF2BE1F81
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADE634F8094
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C5D2FDC51;
	Thu, 16 Oct 2025 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YEkmPmbs"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D02F7AB1
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600604; cv=none; b=VZNeUAJoKnX/zd3MAW/FO7Iu8vHDQ6gc+ePAHLX/ZqcSt9hX0a0jAJmnk5qGw0dRd5xIi1Dglnf2pwYv/HVzbZmnJ7DW3CWpvJCWc5K7WRst5NJs4d4jFqUETUNzW301YlCRHpMmFElicHCsWm8GuerZXHXDFJpuTSW//UiCDQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600604; c=relaxed/simple;
	bh=OCk8VPrYtr77eXtccQA5LH7YKsdD7s+kAIS1pmRdYMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jqv++qPszXqlNPkq0gjhQXnOUtuGZx/YKdQs0GEwnn3rNXyqsP492llyGAfm+7Ghx0u8IC9KEaw09/sPgGxwD9L909YCl0Edmj8ZfIXEzPUeG2SltKMOe86/e2abg4tlxjm+ZrUMywJWYKK5ktZ8NbSJHzOPdF43pZCYGmNPIQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YEkmPmbs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OCk8VPrYtr77eXtccQA5LH7YKsdD7s+kAIS1pmRdYMw=; b=YEkmPmbsiuQz452QQ7cwxWlEB+
	o3L9PjX6L9pdedM37qodutDcjz72jITwS9y7YVx4BaCulYFtZowmTReYfXLcN5FNxHGRJrLtpFn31
	cRlIDQuT5fZNM941Iyr3Rr6+B260LxtPei4/AdACRZAJXZpY4Nd/gzp2AviEOxLdY02uWmhZhtekk
	vtu2xdiZJXMWdw/nMOqpNNbXhgRf7IJ9HwYg2ZnD3K5ozYKdiJ4cRHiC21xLf89QbvwuqDxfGKUbz
	PIP3Wpp73Sbj5zMK7jhroSA5Ho4z70oWb3zhe+TSeY0M5JfcWcLLKfXGyTPvv83WG1TM1OMyzJAnz
	X/uBO7kg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9Id2-00000006Zbm-1kJ1;
	Thu, 16 Oct 2025 07:42:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F3A1F3001D4; Thu, 16 Oct 2025 09:42:27 +0200 (CEST)
Date: Thu, 16 Oct 2025 09:42:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Hillf Danton <hdanton@sina.com>,
	Jianyong Wu <jianyong.wu@outlook.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>,
	Vern Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>,
	Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org,
	Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 04/19] sched/fair: Introduce a static key to enable cache
 aware only for multi LLCs
Message-ID: <20251016074227.GY3289052@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ef136e6a6f5a2ef840b1f9571c47411f04705b6a.1760206683.git.tim.c.chen@linux.intel.com>
 <20251015110450.GO3289052@noisy.programming.kicks-ass.net>
 <15b871f2-49b8-4b62-926d-31f93ad49f51@intel.com>
 <6007f50a-7abd-46c8-8934-f1b09df57479@linux.ibm.com>
 <3d7b6b2c-7b48-4bd5-87bf-39f4c72fa741@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d7b6b2c-7b48-4bd5-87bf-39f4c72fa741@intel.com>

On Thu, Oct 16, 2025 at 01:01:05AM +0800, Chen, Yu C wrote:

> Oh, do you mean only using sched_cache_allowed in sched_cache_enabled()?
> I misunderstood that Peter suggested introducing only one key. But I didn't
> quite catch up - do you mean we should monitor the switch of FEAT, modify
> sched_cache_allowed when needed, and that the OS only queries
> sched_cache_allowed
> at runtime?

Just don't use sched_feat(), add a debugfs file like numa_balancing and
then combine the userspace and topology information when setting the one
static_branch.

