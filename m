Return-Path: <linux-kernel+bounces-735670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A8BB09255
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0ACB5A1A34
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B924A2FD5B0;
	Thu, 17 Jul 2025 16:57:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D9E2FCFE1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771442; cv=none; b=rS4gbrCN7UtKxFjZrod5K95DANQSproMMrQvcpvetbPLCV3xqZPUrQXZzuMXNOa/ihtX6ec43kQg2A8Jp/HEIHrevwkm5JZZkmNQlXwccoz9acAog0fKUX/WzP9BaVI47ue/oAnVeFFjJtncvduBs1ytscJjsMUuEl5KzdO5t38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771442; c=relaxed/simple;
	bh=ijTER4NxnoTYjWPfsGTVVsZbR4kOu38wXqr7PQEnLmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5eXNFtpktQcg/Ywxdob3l0ofWD8opa9PKTVjosegYO7jR+srygjMnxACOvR62aLzO+fxNGZnXm4jFH4UvIWOjgvtV2HB3CkzlOzXFvUy47RhWoK5ULZQNmq+LjJo1sJWdsEflsqpQECGC9vz+yHr0w1V+Z9uL1mrd25NhMmfHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 097051596;
	Thu, 17 Jul 2025 09:57:11 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 569D83F694;
	Thu, 17 Jul 2025 09:57:15 -0700 (PDT)
Date: Thu, 17 Jul 2025 18:57:02 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, clm@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] sched: Address schbench regression
Message-ID: <aHkrQXhRtYi3ydKo@arm.com>
References: <20250702114924.091581796@infradead.org>
 <aHj01PaJ_rcsduMn@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHj01PaJ_rcsduMn@arm.com>

On Thu, Jul 17, 2025 at 03:04:55PM +0200, Beata Michalska wrote:
> Hi Peter,
> 
> Below are the results of running the schbench on Altra
> (as a reminder 2-core MC, 2 Numa Nodes, 160 cores)
> 
> `Legend:
> - 'Flags=none' means neither TTWU_QUEUE_DEFAULT nor
>   TTWU_QUEUE_DELAYED is set (or available).
> - '*…*' marks Top-3 Min & Max, Bottom-3 Std dev, and
>   Top-3 90th-percentile values.
> 
> Base 6.16-rc5
>   Flags=none
>   Min=681870.77 | Max=913649.50 | Std=53802.90       | 90th=890201.05
> 
> sched/fair: bump sd->max_newidle_lb_cost when newidle balance fails
>   Flags=none
>   Min=770952.12 | Max=888047.45 | Std=34430.24       | 90th=877347.24
> 
> sched/psi: Optimize psi_group_change() cpu_clock() usage
>   Flags=none
>   Min=748137.65 | Max=936312.33 | Std=56818.23       | 90th=*921497.27*
> 
> sched/deadline: Less agressive dl_server handling
>   Flags=none
>   Min=783621.95 | Max=*944604.67* | Std=43538.64     | 90th=*909961.16*
> 
> sched: Optimize ttwu() / select_task_rq()
>   Flags=none
>   Min=*826038.87* | Max=*1003496.73* | Std=49875.43  | 90th=*971944.88*
> 
> sched: Use lock guard in ttwu_runnable()
>   Flags=none
>   Min=780172.75 | Max=914170.20 | Std=35998.33       | 90th=866095.80
> 
> sched: Add ttwu_queue controls
>   Flags=TTWU_QUEUE_DEFAULT
>   Min=*792430.45* | Max=903422.78 | Std=33582.71     | 90th=887256.68
> 
>   Flags=none
>   Min=*803532.80* | Max=894772.48 | Std=29359.35     | 90th=877920.34
> 
> sched: Introduce ttwu_do_migrate()
>   Flags=TTWU_QUEUE_DEFAULT
>   Min=749824.30 | Max=*965139.77* | Std=57022.47     | 90th=903659.07
>  
>   Flags=none
>   Min=787464.65 | Max=885349.20 | Std=27030.82       | 90th=875750.44
> 
> psi: Split psi_ttwu_dequeue()
>   Flags=TTWU_QUEUE_DEFAULT
>   Min=762960.98 | Max=916538.12 | Std=42002.19       | 90th=876425.84
>  
>   Flags=none
>   Min=773608.48 | Max=920812.87 | Std=42189.17       | 90th=871760.47
> 
> sched: Re-arrange __ttwu_queue_wakelist()
>   Flags=TTWU_QUEUE_DEFAULT
>   Min=702870.58 | Max=835243.42 | Std=44224.02       | 90th=825311.12
> 
>   Flags=none
>   Min=712499.38 | Max=838492.03 | Std=38351.20       | 90th=817135.94
> 
> sched: Use lock guard in sched_ttwu_pending()
>   Flags=TTWU_QUEUE_DEFAULT
>   Min=729080.55 | Max=853609.62 | Std=43440.63       | 90th=838684.48
> 
>   Flags=none
>   Min=708123.47 | Max=850804.48 | Std=40642.28       | 90th=830295.08
> 
> sched: Change ttwu_runnable() vs sched_delayed
>   Flags=TTWU_QUEUE_DEFAULT
>   Min=580218.87 | Max=838684.07 | Std=57078.24       | 90th=792973.33
> 
>   Flags=none
>   Min=721274.90 | Max=784897.92 | Std=*19017.78*     | 90th=774792.30
> 
> sched: Add ttwu_queue support for delayed tasks
>   Flags=none
>   Min=712979.48 | Max=830192.10 | Std=33173.90       | 90th=798599.66
> 
>   Flags=TTWU_QUEUE_DEFAULT
>   Min=698094.12 | Max=857627.93 | Std=38294.94       | 90th=789981.59
>  
>   Flags=TTWU_QUEUE_DEFAULT/TTWU_QUEUE_DELAYED
>   Min=683348.77 | Max=782179.15 | Std=25086.71       | 90th=750947.00
> 
>   Flags=TTWU_QUEUE_DELAYED
>   Min=669822.23 | Max=807768.85 | Std=38766.41       | 90th=794052.05
> 
> sched: fix ttwu_delayed
This one is actually:
sched: Add ttwu_queue support for delayed tasks
+
https://lore.kernel.org/all/0672c7df-543c-4f3e-829a-46969fad6b34@amd.com/

Apologies for that.

---
BR
Beata
>   Flags=none
>   Min=671844.35 | Max=798737.67 | Std=33438.64       | 90th=788584.62
> 
>   Flags=TTWU_QUEUE_DEFAULT
>   Min=688607.40 | Max=828679.53 | Std=33184.78       | 90th=782490.23
> 
>   Flags=TTWU_QUEUE_DEFAULT/TTWU_QUEUE_DELAYED
>   Min=579171.13 | Max=643929.18 | Std=*14644.92*     | 90th=639764.16
> 
>   Flags=TTWU_QUEUE_DELAYED
>   Min=614265.22 | Max=675172.05 | Std=*13309.92*     | 90th=647181.10
> 
> 
> Best overall performer:
> sched: Optimize ttwu() / select_task_rq()
>   Flags=none
>   Min=*826038.87* | Max=*1003496.73* | Std=49875.43 | 90th=*971944.88*
> 
> Hope this will he somehwat helpful.
> 
> ---
> BR
> Beata
> 
> On Wed, Jul 02, 2025 at 01:49:24PM +0200, Peter Zijlstra wrote:
> > Hi!
> > 
> > Previous version:
> > 
> >   https://lkml.kernel.org/r/20250520094538.086709102@infradead.org
> > 
> > 
> > Changes:
> >  - keep dl_server_stop(), just remove the 'normal' usage of it (juril)
> >  - have the sched_delayed wake list IPIs do select_task_rq() (vingu)
> >  - fixed lockdep splat (dietmar)
> >  - added a few preperatory patches
> > 
> > 
> > Patches apply on top of tip/master (which includes the disabling of private futex)
> > and clm's newidle balance patch (which I'm awaiting vingu's ack on).
> > 
> > Performance is similar to the last version; as tested on my SPR on v6.15 base:
> > 
> > v6.15:
> > schbench-6.15.0-1.txt:average rps: 2891403.72
> > schbench-6.15.0-2.txt:average rps: 2889997.02
> > schbench-6.15.0-3.txt:average rps: 2894745.17
> > 
> > v6.15 + patches 1-10:
> > schbench-6.15.0-dirty-4.txt:average rps: 3038265.95
> > schbench-6.15.0-dirty-5.txt:average rps: 3037327.50
> > schbench-6.15.0-dirty-6.txt:average rps: 3038160.15
> > 
> > v6.15 + all patches:
> > schbench-6.15.0-dirty-deferred-1.txt:average rps: 3043404.30
> > schbench-6.15.0-dirty-deferred-2.txt:average rps: 3046124.17
> > schbench-6.15.0-dirty-deferred-3.txt:average rps: 3043627.10
> > 
> > 
> > Patches can also be had here:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
> > 
> > 
> > I'm hoping we can get this merged for next cycle so we can all move on from this.
> > 
> > 
> 

