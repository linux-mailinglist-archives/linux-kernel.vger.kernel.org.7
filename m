Return-Path: <linux-kernel+bounces-853387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC408BDB75B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B41A502630
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74680296BCD;
	Tue, 14 Oct 2025 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WO5DHnof"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDDE2E7651
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760478495; cv=none; b=lM9MAkgTKL5f3wn3QK92RER4vaMi0W7ioUtUflMqE+uMCneBwOqhVV5SzILSgR3GXWJqUhYKYsZ7jeh7w3/LxNYtX5qQai2u5HFd7DNwG3pi9svOJ0aL9yXJsW2BfZzaXjpEHp4J332V1kOZKE6dlDVeGVrOfcv0af8WyAHxyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760478495; c=relaxed/simple;
	bh=AHNM0DWbjTC1NapMIsHcfWOnWTFTB/8TD2GDQezZdmM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i0nNSdYLltY7BiOI8Lp4JV7d39rjt02kXPFKxiXboTzipa2mB/kLfajbA0VFK4oP6WsdXKEo3lBVRh2efgBwC0in/TMaOpylAtGonqgMNUSsud7YCJVpMZA17KPxGwwl0dolKMupVxkv+Hu+vzt56lQkpzOrgpPhw7dzASjt8uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WO5DHnof; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760478493; x=1792014493;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=AHNM0DWbjTC1NapMIsHcfWOnWTFTB/8TD2GDQezZdmM=;
  b=WO5DHnofmvZKevFDIm/q9r0ectIEu68euSE67lSS5igRnq4uxc2eRCh2
   dPI8UO8s2tqxrF4lguGFgrhhgzG+qTUxxJQHm7OSOerRthGGHc+j2Uf7X
   ufM1CXcb9xeZwr2METTd5ZFS5mbEEXS3JbOEopYJN21g8EaBKCBYNnfgT
   6s6kJlj0YgwQaoVtqzFPop8behvqzdupfFKtgv+iSp930yiiFWT80pTTG
   iuQfBTg2JYRDUNZqsA7DNkIHYAP59t9d42sMerqbZ3P1ausEOGSn6G2U6
   bYnd6iZku03oshUwhpU0nyImkZyLHKtn7jvix//rS+YW763sXyLOZ89IP
   g==;
X-CSE-ConnectionGUID: vlP5C23lQgOXg3tkKr/NMA==
X-CSE-MsgGUID: QUq3mE7MQ8yBNp+FpA9MfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62538824"
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="62538824"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:48:10 -0700
X-CSE-ConnectionGUID: Uo/wlrzaSly8ol9lu0Bm2Q==
X-CSE-MsgGUID: HSJHNkbNQ6qc1fq/I1gm6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,229,1754982000"; 
   d="scan'208";a="181670995"
Received: from unknown (HELO [10.241.242.248]) ([10.241.242.248])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 14:48:10 -0700
Message-ID: <5b82842ff20995cd50b422dad844664089dcd0c7.camel@linux.intel.com>
Subject: Re: [PATCH 00/19] Cache Aware Scheduling
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>, Vincent Guittot	 <vincent.guittot@linaro.org>,
 Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall	 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider	 <vschneid@redhat.com>, Hillf Danton <hdanton@sina.com>,
 Shrikanth Hegde	 <sshegde@linux.ibm.com>, Jianyong Wu
 <jianyong.wu@outlook.com>, Yangyu Chen	 <cyy@cyyself.name>, Tingyin Duan
 <tingyin.duan@gmail.com>, Vern Hao	 <vernhao@tencent.com>, Len Brown
 <len.brown@intel.com>, Aubrey Li	 <aubrey.li@intel.com>, Zhao Liu
 <zhao1.liu@intel.com>, Chen Yu	 <yu.chen.surf@gmail.com>, Chen Yu
 <yu.c.chen@intel.com>, Libo Chen	 <libo.chen@oracle.com>, Adam Li
 <adamli@os.amperecomputing.com>, Tim Chen	 <tim.c.chen@intel.com>,
 linux-kernel@vger.kernel.org
Date: Tue, 14 Oct 2025 14:48:09 -0700
In-Reply-To: <a54c33fd-504d-4eb4-9b0e-ad4a3e2156ad@linux.ibm.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
		 <a54c33fd-504d-4eb4-9b0e-ad4a3e2156ad@linux.ibm.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
 uQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-14 at 17:43 +0530, Madadi Vineeth Reddy wrote:
> Hi Tim,
> Thanks for the patch.
>=20
> On 11/10/25 23:54, Tim Chen wrote:
> > There had been 4 RFC postings of this patch set. We've incorporated
> > the feedbacks and comments and now would like to post this patch set
> > for consideration of inclusion to mainline. The patches are based on
> > the original patch proposed by Peter[1].
> >=20
>=20
> [snip]
>=20
> > The following tunables control under /sys/kernel/debug/sched/ control
> > the behavior of cache aware scheduling:
> >=20
> > 1. llc_aggr_tolerance Controls how aggressive we aggregate tasks to
> > their preferred LLC, based on a process's RSS size and number of runnin=
g
> > threads.  Processes that have smaller memory footprint and fewer number
> > of tasks will benefit better from aggregation.  Varies between 0 to 100
> >         0:  Cache aware scheduling is disabled 1:  Process with RSS
> >         greater than LLC size,
> > 	    or running threads more than number of cpu cores/LLC skip
> > 	    aggregation
> > 	100:  Aggressive; a process's threads are aggregated regardless of
> > 	      RSS or running threads.
> > For example, with a 32MB L3 cache 8 cores in L3:
> >     llc_aggr_tolerance=3D1 -> process with RSS > 32MB, or nr_running_av=
g >
> >     8 are skipped.  llc_aggr_tolerance=3D99 -> process with RSS > 784GB
> >     or nr_running_avg > 785 are skipped.  784GB =3D (1 + (99 - 1) * 256=
)
> >     * 32MB.
> >      785  =3D (1 + (99 - 1) * 8).
> >=20
> > Currently this knob is a global control. Considering that different wor=
kloads have
> > different requirements for task consolidation, it would be ideal to int=
roduce
> > per process control for this knob via prctl in the future.
> > =20
> > 2. llc_overload_pct, llc_imb_pct
> > We'll always try to move a task to its preferred LLC if an LLC's averag=
e core
> > utilization is below llc_overload_pct (default to 50%). Otherwise, the =
utilization
> > of preferred LLC has to be not more than llc_imb_pct (default to 20%) t=
o move a task
> > to it. This is to prevent overloading on the preferred LLC.
> > =20
> > 3. llc_epoch_period
> > Controls how often the scheduler collect LLC occupancy of a process (de=
fault to 10 msec)
> > =20
> > 4. llc_epoch_affinity_timeout
> > Detect that if a process has not run for llc_epoch_affinity_timeout (de=
fault to 50 msec),
> > it loses its cache preference.
>=20
> How are these default values arrived at? Is it based on some theory or
> based on the results of the runs?

Right now the default value of llc_aggr_tolerance is fairly conservative.
We make sure that we don't cause regressions to workloads we tested.

Knobs like llc_overload_pct, llc_imb_pct are actually chosen from
Len's Yogini micro-benchmark experiments we did that gave good aggregation
without overloading LLC.

llc_epoch_period and llc_epoch_affinity_timeout are from Peter's
original patch that seem to work fairly well so we left it as is.=20

>=20
> >=20
> > Test results:
> > The first test platform is a 2 socket Intel Sapphire Rapids with 30
> > cores per socket. The DRAM interleaving is enabled in the BIOS so it
> > essential has one NUMA node with two last level caches. There are 60
> > CPUs associated with each last level cache.
> >=20
> > The second test platform is a AMD Milan. There are 2 Nodes and 64 CPUs
> > per node. Each node has 8 CCXs and each CCX has 8 CPUs.
> >=20
> > The third test platform is a AMD Genoa. There are 4 Nodes and 32 CPUs p=
er node.
> > Each node has 2 CCXs and each CCX has 16 CPUs.
> >=20
> > [TL;DR]
> > Sappire Rapids:
> > hackbench shows significant improvement when there is 1 group
> > with different number of fd pairs(threads) within this process.
> > schbench shows overall wakeup latency improvement.
> > ChaCha20-xiangshan shows ~10% throughput improvement. Other
> > micro-workloads did not show much difference.
> >=20
> > Milan:
> > No obvious difference is observed so far.
> >=20
> > Genoa:
> > ChaCha20-xiangshan shows 44% throughput improvement.
> >=20
> > [Sapphire Rapids details]
> >=20
> > [hackbench]
> > Hackbench show overall improvement when there is only 1
> > group, with different number of fd(pairs). This is the
> > expected behavior because this test scenario would benefit
> > from cache aware load balance most. Other number of groups
> > shows not much difference(using default fd =3D 20).
> >=20
> >        groups              baseline            sched_cache
> > Min       1      37.5960 (   0.00%)     26.4340 (  29.69%)
> > Min       3      38.7050 (   0.00%)     38.6920 (   0.03%)
> > Min       5      39.4550 (   0.00%)     38.6280 (   2.10%)
> > Min       7      51.4270 (   0.00%)     50.6790 (   1.45%)
> > Min       12     62.8540 (   0.00%)     63.6590 (  -1.28%)
> > Min       16     74.0160 (   0.00%)     74.7480 (  -0.99%)
> > Amean     1      38.4768 (   0.00%)     26.7146 *  30.57%*
> > Amean     3      39.0750 (   0.00%)     39.5586 (  -1.24%)
> > Amean     5      41.5178 (   0.00%)     41.2766 (   0.58%)
> > Amean     7      52.1164 (   0.00%)     51.5152 (   1.15%)
> > Amean     12     63.9052 (   0.00%)     64.0420 (  -0.21%)
> > Amean     16     74.5812 (   0.00%)     75.4318 (  -1.14%)
> > BAmean-99 1      38.2027 (   0.00%)     26.5500 (  30.50%)
> > BAmean-99 3      38.8725 (   0.00%)     39.2225 (  -0.90%)
> > BAmean-99 5      41.1898 (   0.00%)     41.0037 (   0.45%)
> > BAmean-99 7      51.8645 (   0.00%)     51.4453 (   0.81%)
> > BAmean-99 12     63.6317 (   0.00%)     63.9307 (  -0.47%)
> > BAmean-99 16     74.4528 (   0.00%)     75.2113 (  -1.02%)
> >=20
> > [schbench]
> > Wakeup Latencies 99.0th improvement is observed.
> >=20
> > threads          baseline             sched_cache          change
> > 1                13.80(1.10)          14.80(2.86)          -7.25%
> > 2                12.00(1.00)          8.00(2.12)           +33.33%
> > 4                9.00(0.00)           5.60(0.89)           +37.78%
> > 8                9.00(0.00)           6.40(1.14)           +28.89%
> > 16               9.20(0.45)           6.20(0.84)           +32.61%
> > 32               9.60(0.55)           7.00(0.71)           +27.08%
> > 64               10.80(0.45)          8.40(0.55)           +22.22%
> > 128              12.60(0.55)          11.40(0.55)          +9.52%
> > 239              14.00(0.00)          14.20(0.45)          -1.43%
> >=20
> > [stream]
> > No much difference is observed.
> >                              baseline                     sc
> > GB/sec copy-2        35.00 (   0.00%)       34.79 (  -0.60%)
> > GB/sec scale-2       24.04 (   0.00%)       23.90 (  -0.58%)
> > GB/sec add-2         28.98 (   0.00%)       28.92 (  -0.22%)
> > GB/sec triad-2       28.32 (   0.00%)       28.31 (  -0.04%)
> >=20
> > [netperf]
> > No much difference is observed(consider the stdev).
> >=20
> >          nr_pairs          netperf                netperf
> >=20
> > Hmean     60      1023.44 (   0.00%)     1021.87 (  -0.15%)
> > BHmean-99 60      1023.78 (   0.00%)     1022.22 (  -0.15%)
> > Hmean     120      792.09 (   0.00%)      793.75 (   0.21%)
> > BHmean-99 120      792.36 (   0.00%)      794.04 (   0.21%)
> > Hmean     180      513.42 (   0.00%)      513.53 (   0.02%)
> > BHmean-99 180      513.81 (   0.00%)      513.80 (  -0.00%)
> > Hmean     240      387.09 (   0.00%)      387.33 (   0.06%)
> > BHmean-99 240      387.18 (   0.00%)      387.45 (   0.07%)
> > Hmean     300      316.04 (   0.00%)      315.68 (  -0.12%)
> > BHmean-99 300      316.12 (   0.00%)      315.77 (  -0.11%)
> > Hmean     360      496.38 (   0.00%)      455.49 (  -8.24%)
> > BHmean-99 360      499.88 (   0.00%)      458.17 (  -8.34%)
> > Hmean     420      497.32 (   0.00%)      501.84 (   0.91%)
> > BHmean-99 420      499.90 (   0.00%)      504.56 (   0.93%)
> > Hmean     480      417.62 (   0.00%)      432.25 (   3.50%)
> > BHmean-99 480      419.96 (   0.00%)      434.43 (   3.45%)
> >=20
> > In above case of 360 pairs, although there is a performance
> > drop of 8.24%, the corresponding:
> > HCoeffVar   360    23.78 (   0.00%)       29.52 ( -24.15%)
> > shows that the regression is within the run-to-run variance.
> >=20
> > [Milan details]
> >=20
> > default settings:
> > [hackbench]
> >=20
> > Min       1      50.8170 (   0.00%)     51.1890 (  -0.73%)
> > Min       3      59.3610 (   0.00%)     58.6080 (   1.27%)
> > Min       5      94.9760 (   0.00%)     96.0210 (  -1.10%)
> > Min       7     123.3270 (   0.00%)    124.1680 (  -0.68%)
> > Min       12    179.2000 (   0.00%)    181.8390 (  -1.47%)
> > Min       16    238.8680 (   0.00%)    242.6390 (  -1.58%)
> > Amean     1      51.6614 (   0.00%)     51.3630 (   0.58%)
> > Amean     3      60.1886 (   0.00%)     59.4542 (   1.22%)
> > Amean     5      95.7602 (   0.00%)     96.8338 (  -1.12%)
> > Amean     7     124.0332 (   0.00%)    124.4406 (  -0.33%)
> > Amean     12    181.0324 (   0.00%)    182.9220 (  -1.04%)
> > Amean     16    239.5556 (   0.00%)    243.3556 *  -1.59%*
> > BAmean-99 1      51.5335 (   0.00%)     51.3338 (   0.39%)
> > BAmean-99 3      59.7848 (   0.00%)     59.0958 (   1.15%)
> > BAmean-99 5      95.6698 (   0.00%)     96.5450 (  -0.91%)
> > BAmean-99 7     123.8478 (   0.00%)    124.3760 (  -0.43%)
> > BAmean-99 12    180.8035 (   0.00%)    182.5135 (  -0.95%)
> > BAmean-99 16    239.1933 (   0.00%)    243.0570 (  -1.62%)
> >=20
> > [schbench]
> >=20
> > threads          baseline             sched_cache          change
> > 1                12.00(2.00)          11.00(0.71)          +8.33%
> > 2                12.40(0.89)          13.80(0.84)          -11.29%
> > 4                14.20(0.45)          14.80(0.45)          -4.23%
> > 8                16.00(0.00)          15.80(0.45)          +1.25%
> > 16               16.00(0.00)          16.00(0.71)          0.00%
> > 32               19.40(0.55)          18.60(0.55)          +4.12%
> > 63               22.20(0.45)          23.20(0.45)          -4.50%
> >=20
> > [stream]
> > No obvious difference is found.
> > export STREAM_SIZE=3D$((128000000))
> >=20
> >                      baseline               sched_cache
> > GB/sec copy-16       726.48 (   0.00%)      715.60 (  -1.50%)
> > GB/sec scale-16      577.71 (   0.00%)      577.03 (  -0.12%)
> > GB/sec add-16        678.85 (   0.00%)      672.87 (  -0.88%)
> > GB/sec triad-16      735.52 (   0.00%)      729.05 (  -0.88%)
> >=20
> >=20
> > [netperf]
> > No much difference is observed.
> >=20
> >          nr_pairs          baseline           sched_cache
> > Hmean     32       755.98 (   0.00%)      755.17 (  -0.11%)
> > BHmean-99 32       756.42 (   0.00%)      755.40 (  -0.13%)
> > Hmean     64       677.38 (   0.00%)      669.75 (  -1.13%)
> > BHmean-99 64       677.50 (   0.00%)      669.86 (  -1.13%)
> > Hmean     96       498.52 (   0.00%)      496.73 (  -0.36%)
> > BHmean-99 96       498.69 (   0.00%)      496.93 (  -0.35%)
> > Hmean     128      604.38 (   0.00%)      604.22 (  -0.03%)
> > BHmean-99 128      604.87 (   0.00%)      604.87 (   0.00%)
> > Hmean     160      471.67 (   0.00%)      468.29 (  -0.72%)
> > BHmean-99 160      474.34 (   0.00%)      471.05 (  -0.69%)
> > Hmean     192      381.18 (   0.00%)      384.88 (   0.97%)
> > BHmean-99 192      383.30 (   0.00%)      386.82 (   0.92%)
> > Hmean     224      327.79 (   0.00%)      326.05 (  -0.53%)
> > BHmean-99 224      329.85 (   0.00%)      327.87 (  -0.60%)
> > Hmean     256      284.61 (   0.00%)      300.52 (   5.59%)
> > BHmean-99 256      286.41 (   0.00%)      302.06 (   5.47%)
> >=20
> > [Genoa details]
> > [ChaCha20-xiangshan]
> > ChaCha20-xiangshan is a simple benchmark using a static build of an
> > 8-thread Verilator of XiangShan(RISC-V). The README file can be
> > found here[2]. The score depends on how aggressive the user set the
> > /sys/kernel/debug/sched/llc_aggr_tolerance. Using the default values,
> > there is no much difference observed. While setting the
> > /sys/kernel/debug/sched/llc_aggr_tolerance to 100, 44% improvment is
> > observed.
> >=20
> > baseline:
> > Host time spent: 50,868ms
> >=20
> > sched_cache:
> > Host time spent: 28,349ms
> >=20
> > The time has been reduced by 44%.
>=20
> Milan showed no improvement across all benchmarks, which could be due to =
the=20
> CCX topology (8 CCXs =C3=97 8 CPUs) where the LLC domain is too small for=
 this
> optimization to be effective. Moreover there could be overhead due to add=
itional
> computations.
>=20
> ChaCha20-xiangshan improvement in Genoa when llc_aggr_tolerance is set to=
 100 seems
> due to having relatively lesser thread count. Please provide the numbers
> with default values too. Would like to know numbers on varying loads.

I'll ask Chen Yu who did the Xiangshan experiments if he has those numbers.

>=20
> In Power 10 and Power 11, the LLC size is 4 threads which is even smaller=
. Not
> expecting improvements here but will run some workloads and share the dat=
a.
>=20
> Not gone through the entire series yet but are the situations like say in=
 two
> NUMA system, if a task's preferred LLC is on the wrong NUMA node for its =
memory,
> which takes precedence?=20

We take preferred NUMA node in the consideration but we do not force task t=
o
go to the preferred node.

I remembered initially we limited the consideration to only LLCs in the
preferred node. But we encountered regressions in hackbench and schbench,
because when the preferred node don't have any occupancy resulting in prefe=
rred LLC
to be set to -1 (no preference), and resulted in extra task migrations.
And also the preferred node for hackbench and schbench was volatile
as they have small memory footprint.  Chen Yu, please chime in if there
were other reasons you remembered.

We'll need to revisit this part of the code to take care of such
corner case. I think ideally we should move tasks to the least loaded LLC
in the preferred node (even if no LLCs have occupancy in the preferred node=
),
as long as preferred NUMA node don't changes too often.


>=20
> Also, what about the workloads that don't share data like stress-ng?=C2=
=A0
>=20

We can test those.  Ideally the controls to prevent over aggregation to pre=
ferred LLC
would keep stress-ng happy.

> It will
> be good to make sure that most other workloads don't suffer. As mentioned=
,
> per process knob for llc_aggr_tolerance could help.

Agree. We are planning to add per process knob for the next version.  One t=
hought is to use
prctl. Any other suggestions are welcome.

Tim

>=20
> Thanks,
> Madadi Vineeth Reddy
>=20
> >=20
> > Thanks to everyone who participated and provided valuable suggestions f=
or
> > the previous versions. Your comments and tests on the latest version ar=
e
> > also greatly appreciated in advance.
> >=20
> > Tim
> >=20
> > [1] https://lore.kernel.org/lkml/20250325120952.GJ36322@noisy.programmi=
ng.kicks-ass.net/
> >=20
> > [2] https://github.com/yu-chen-surf/chacha20-xiangshan/blob/master/READ=
ME.eng.md
> >=20
> > RFC v4:
> > [3] https://lore.kernel.org/all/cover.1754712565.git.tim.c.chen@linux.i=
ntel.com/
> >=20
> > RFC v3
> > [4] https://lore.kernel.org/all/cover.1750268218.git.tim.c.chen@linux.i=
ntel.com/
> >=20
> > RFC v2:
> > [5] https://lore.kernel.org/lkml/cover.1745199017.git.yu.c.chen@intel.c=
om/
> >=20
> >=20
> > Chen Yu (7):
> >   sched/fair: Record per-LLC utilization to guide cache-aware schedulin=
g
> >     decisions
> >   sched/fair: Introduce helper functions to enforce LLC migration polic=
y
> >   sched/fair: Introduce a static key to enable cache aware only for
> >     multi LLCs
> >   sched/fair: Exclude processes with many threads from cache-aware
> >     scheduling
> >   sched/fair: Disable cache aware scheduling for processes with high
> >     thread counts
> >   sched/fair: Avoid cache-aware scheduling for memory-heavy processes
> >   sched/fair: Add user control to adjust the tolerance of cache-aware
> >     scheduling
> >=20
> > Peter Zijlstra (Intel) (1):
> >   sched/fair: Add infrastructure for cache-aware load balancing
> >=20
> > Tim Chen (11):
> >   sched/fair: Add LLC index mapping for CPUs
> >   sched/fair: Assign preferred LLC ID to processes
> >   sched/fair: Track LLC-preferred tasks per runqueue
> >   sched/fair: Introduce per runqueue task LLC preference counter
> >   sched/fair: Count tasks prefering each LLC in a sched group
> >   sched/fair: Prioritize tasks preferring destination LLC during
> >     balancing
> >   sched/fair: Identify busiest sched_group for LLC-aware load balancing
> >   sched/fair: Add migrate_llc_task migration type for cache-aware
> >     balancing
> >   sched/fair: Handle moving single tasks to/from their preferred LLC
> >   sched/fair: Consider LLC preference when selecting tasks for load
> >     balancing
> >   sched/fair: Respect LLC preference in task migration and detach
> >=20
> >  include/linux/cacheinfo.h      |   21 +-
> >  include/linux/mm_types.h       |   45 ++
> >  include/linux/sched.h          |    5 +
> >  include/linux/sched/topology.h |    4 +
> >  include/linux/threads.h        |   10 +
> >  init/Kconfig                   |   20 +
> >  init/init_task.c               |    3 +
> >  kernel/fork.c                  |    6 +
> >  kernel/sched/core.c            |   18 +
> >  kernel/sched/debug.c           |   56 ++
> >  kernel/sched/fair.c            | 1022 +++++++++++++++++++++++++++++++-
> >  kernel/sched/features.h        |    1 +
> >  kernel/sched/sched.h           |   27 +
> >  kernel/sched/topology.c        |   61 +-
> >  14 files changed, 1283 insertions(+), 16 deletions(-)
> >=20
>=20

