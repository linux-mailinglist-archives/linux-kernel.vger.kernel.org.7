Return-Path: <linux-kernel+bounces-733448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEFAB074C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00524A41434
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411402F433B;
	Wed, 16 Jul 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X0vFju8E"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074F2F3C19;
	Wed, 16 Jul 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752665270; cv=none; b=bQca26H7U1LGxqa2ZaAmEDFtHPLVBn11DxQSWk8mhSYmOTmSQEBluX8l8goHwA4M/RB2jQyMGtb0tNRIhIGsn1yGuVWUo536tzulOtiGGPnr5EHca2OTEVYF8UolzZRYxgiJyJ8FmU6iI3RHkQ05rJFcAUxdSnxiMlVffKFV5mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752665270; c=relaxed/simple;
	bh=tF/CGpBDHuoQJLkqIhKtBGCbJrI4tFGNUCxaUGxb3iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGdRBIjahEepN5N0uzsElrblWrRCCDxl37NB83Rnv9nrI60xjncSwWK2NPyv9ZW8+JLBiLh6De1L2TIdv7RbL82cq7EHdN+ehig9wkzI5JYrA9CBR3fjBpt6yxZLIwfjdgeOXMdHyvYd1EcT8qsQRyYk9Bo44nQzM/HDSfKsCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X0vFju8E; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZHVX6m1R3Mlb+Km1KE7CKsn7V7mXoTRhSjns8PcR16s=; b=X0vFju8EEkfRkx5osHztZGBaYi
	+5sgu0BjN/EOp5fcMaQruQYjUpFNyEUpqk7fc34hDikTb5MZAaOsZxr8o9bYbEF93XhQ1Wy9kjJd1
	/VvGed3zY488h11MSiVIrpowd6EEe2h6XWU+qBerfyrUniprjPELu2lUOtC/dg1qk410T5hjdL0K0
	GvZdWsS3ml37ZrN0M9DVIQmPEDscwIpA53l5YH0a3Wr3JvJ6BvJ4p2h5D2VQVo+QemJNcy7+qK6kB
	r8JpnUT1srQbTOkKV8B4CpjsbBDcVKD2uSJR3DDc7SEWrtgq1N8NKLATHfWX2ioIyJ9fLTpMWxbU+
	6KYu/xMg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc0IS-0000000GNag-17O1;
	Wed, 16 Jul 2025 11:27:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 514AF3007A0; Wed, 16 Jul 2025 13:27:35 +0200 (CEST)
Date: Wed, 16 Jul 2025 13:27:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: kernel test robot <lkp@intel.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250716112735.GT1613200@noisy.programming.kicks-ass.net>
References: <20250715071658.267-4-ziqianlu@bytedance.com>
 <202507160730.0cXkgs0S-lkp@intel.com>
 <20250716065707.GA32@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716065707.GA32@bytedance>

On Wed, Jul 16, 2025 at 02:57:07PM +0800, Aaron Lu wrote:
> On Wed, Jul 16, 2025 at 07:29:37AM +0800, kernel test robot wrote:
> > Hi Aaron,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on tip/sched/core]
> > [also build test WARNING on next-20250715]
> > [cannot apply to linus/master v6.16-rc6]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Lu/sched-fair-Add-related-data-structure-for-task-based-throttle/20250715-152307
> > base:   tip/sched/core
> > patch link:    https://lore.kernel.org/r/20250715071658.267-4-ziqianlu%40bytedance.com
> > patch subject: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
> > config: i386-buildonly-randconfig-006-20250716 (https://download.01.org/0day-ci/archive/20250716/202507160730.0cXkgs0S-lkp@intel.com/config)
> > compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507160730.0cXkgs0S-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202507160730.0cXkgs0S-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> kernel/sched/fair.c:5456:33: warning: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
> >     5456 |                         cfs_rq->pelt_clock_throttled = 1;
> >          |                                                      ^ ~

Nice warning from clang.

> 
> Thanks for the report.
> 
> I don't think this will affect correctness since both cfs_rq's throttled
> and pelt_clock_throttled fields are used as true(not 0) or false(0). I
> used bitfield for them to save some space.
> 
> Change their types to either unsigned int or bool should cure this
> warning, I suppose bool looks more clear?
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index dbe52e18b93a0..434f816a56701 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -737,8 +737,8 @@ struct cfs_rq {
>  	u64			throttled_clock_pelt_time;
>  	u64			throttled_clock_self;
>  	u64			throttled_clock_self_time;
> -	int			throttled:1;
> -	int			pelt_clock_throttled:1;
> +	bool			throttled:1;
> +	bool			pelt_clock_throttled:1;
>  	int			throttle_count;
>  	struct list_head	throttled_list;
>  	struct list_head	throttled_csd_list;

Yeah, either this or any unsigned type will do.

