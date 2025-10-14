Return-Path: <linux-kernel+bounces-852544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A71BD94AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6BBC4E4520
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F94A29DB88;
	Tue, 14 Oct 2025 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KMdrxIU0"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8C312802
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444081; cv=none; b=Z0vDdc3680cHKiRy+HfzGoyS7v88dtOVmQIys2C1cKNrfg8kxBNzN8T3O9JWe3eU/fekBP2HlAZHmHO9Pf38M0/eTfT39kxpLbV7WM9hJqmQfqQfuFp8V6hZ5/PS4H1x+kOEvsQ68HkOcgfZEAY3fgfBsIzuyp2UCaHUvCcz03A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444081; c=relaxed/simple;
	bh=Z37RZwaXuUSX5BAt4s3UaX2iLyLqhiwPxWIMsOp35kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pg/z1f58ejJ+wB9r7Oim05Xlm6nc83tJdpzHewRyhdkXa8yJcSitGKNEcXxLrK0o27f8IiJk1Dh3rrSXRlYT6x3EuWF294witYPU0g24aKMowWTAmuj5uXKHKNqAIionH1s4iDrsYjnAbL/QdhCcW55y7OZE9YIdKYTg/9btpeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KMdrxIU0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E0AgFi016832;
	Tue, 14 Oct 2025 12:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KElt8+
	ZOcTLmUe+M5zaPX2/MFmgx7DuYOuuAkANb1kc=; b=KMdrxIU0pK28UZpaVBcJV+
	PFy9Ciy28nrBBUPSqRBjWpgTMT4nKPDKm+7YVvHoGDKWNdkDRxlIiiW5Xhg7Qv3n
	rV4c+pXqP/5DW27KExxZo8axKpUkoAPhh1Cuxb2E0jY7q3Fo8+J8KSy8AJprt+ix
	G3lCPqkewHZpsKsEDyzd1ouSn2i8SGXxqx2jI0afdyLX2lrCsmAgA15VgdxgYJET
	1fQsH9asWKyq2cVt5W3yp1flqCmFseUixICuHbnfN1kuLoXAqUGdpK4ZPDpdUWLO
	tpx5GMW6QyY9vVzg94U2dVEz1OUbvs2eOgUk+lCeMhYwkOmLC306ZrAhbvdK1P3Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewtxg1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 12:14:07 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59EC6F2w021335;
	Tue, 14 Oct 2025 12:14:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewtxg16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 12:14:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59EAjm4t003663;
	Tue, 14 Oct 2025 12:14:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xxtw1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 12:14:05 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59ECE3IN37552742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 12:14:03 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EAC958056;
	Tue, 14 Oct 2025 12:14:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90F4E58052;
	Tue, 14 Oct 2025 12:13:52 +0000 (GMT)
Received: from [9.43.109.189] (unknown [9.43.109.189])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Oct 2025 12:13:52 +0000 (GMT)
Message-ID: <a54c33fd-504d-4eb4-9b0e-ad4a3e2156ad@linux.ibm.com>
Date: Tue, 14 Oct 2025 17:43:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] Cache Aware Scheduling
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
        Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>,
        Len Brown <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Chen Yu <yu.c.chen@intel.com>, Libo Chen <libo.chen@oracle.com>,
        Adam Li <adamli@os.amperecomputing.com>,
        Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <cover.1760206683.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JwpEE8N8Hkxwh1k26HOInUXBpK5NGRTJ
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68ee3e8f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=WsHKUha7AAAA:8 a=NEAV23lmAAAA:8 a=QyXUC8HyAAAA:8
 a=Hcr3Eg6ltpK8k9MnD90A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=H4LAKuo8djmI0KOkngUh:22 a=poXaRoVlC6wW9_mwW8W4:22 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=p-dnK0njbqwfn1k4-x12:22 a=rLkV7i5x5X597yo9dRWc:22
X-Proofpoint-ORIG-GUID: vyQmVf9K24en41ov3L9I2AXqOe0wopOs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX6x69l7v7VCHc
 VkT/01uoL8z4RUrhsrNTJF+xoIJrTzmKEaL6jx2zxfZ2+W3gZyyoSe9jXgQKvmbjDDRTJc7+zoA
 azP9PztZVqmvk0me1fWrm9xI5j0sVF4I/A1WcgrV8KgSTnuwCPPj5M/OnQmY8ANyP6A8Fi4aKR+
 u96uXWYOGPieVJFQnk3JNWO2iwgpZyhkt5zm6+us+oDDx1Usq8dnu+VMeBThEVi0y8GbD3NbI/r
 OmD1djSV0kSU8HmvoC/I3LyJlQdpfni9Cbh+QPKAmwQSAuiGMgfYX5/iK/mbwrDLL6lru0oNwJP
 5UVja3UinBW96jhp5DDtqDT5a1NatawN6zr8ptk9KcfDT2qfAPUYrlcNB4YpY7WEA7ZVV9YL9o0
 4zDWB/lc1N+W1a/qjberXkZLQsQx2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

Hi Tim,
Thanks for the patch.

On 11/10/25 23:54, Tim Chen wrote:
> There had been 4 RFC postings of this patch set. We've incorporated
> the feedbacks and comments and now would like to post this patch set
> for consideration of inclusion to mainline. The patches are based on
> the original patch proposed by Peter[1].
> 

[snip]

> The following tunables control under /sys/kernel/debug/sched/ control
> the behavior of cache aware scheduling:
> 
> 1. llc_aggr_tolerance Controls how aggressive we aggregate tasks to
> their preferred LLC, based on a process's RSS size and number of running
> threads.  Processes that have smaller memory footprint and fewer number
> of tasks will benefit better from aggregation.  Varies between 0 to 100
>         0:  Cache aware scheduling is disabled 1:  Process with RSS
>         greater than LLC size,
> 	    or running threads more than number of cpu cores/LLC skip
> 	    aggregation
> 	100:  Aggressive; a process's threads are aggregated regardless of
> 	      RSS or running threads.
> For example, with a 32MB L3 cache 8 cores in L3:
>     llc_aggr_tolerance=1 -> process with RSS > 32MB, or nr_running_avg >
>     8 are skipped.  llc_aggr_tolerance=99 -> process with RSS > 784GB
>     or nr_running_avg > 785 are skipped.  784GB = (1 + (99 - 1) * 256)
>     * 32MB.
>      785  = (1 + (99 - 1) * 8).
> 
> Currently this knob is a global control. Considering that different workloads have
> different requirements for task consolidation, it would be ideal to introduce
> per process control for this knob via prctl in the future.
>  
> 2. llc_overload_pct, llc_imb_pct
> We'll always try to move a task to its preferred LLC if an LLC's average core
> utilization is below llc_overload_pct (default to 50%). Otherwise, the utilization
> of preferred LLC has to be not more than llc_imb_pct (default to 20%) to move a task
> to it. This is to prevent overloading on the preferred LLC.
>  
> 3. llc_epoch_period
> Controls how often the scheduler collect LLC occupancy of a process (default to 10 msec)
>  
> 4. llc_epoch_affinity_timeout
> Detect that if a process has not run for llc_epoch_affinity_timeout (default to 50 msec),
> it loses its cache preference.

How are these default values arrived at? Is it based on some theory or
based on the results of the runs?

>
> Test results:
> The first test platform is a 2 socket Intel Sapphire Rapids with 30
> cores per socket. The DRAM interleaving is enabled in the BIOS so it
> essential has one NUMA node with two last level caches. There are 60
> CPUs associated with each last level cache.
> 
> The second test platform is a AMD Milan. There are 2 Nodes and 64 CPUs
> per node. Each node has 8 CCXs and each CCX has 8 CPUs.
> 
> The third test platform is a AMD Genoa. There are 4 Nodes and 32 CPUs per node.
> Each node has 2 CCXs and each CCX has 16 CPUs.
> 
> [TL;DR]
> Sappire Rapids:
> hackbench shows significant improvement when there is 1 group
> with different number of fd pairs(threads) within this process.
> schbench shows overall wakeup latency improvement.
> ChaCha20-xiangshan shows ~10% throughput improvement. Other
> micro-workloads did not show much difference.
> 
> Milan:
> No obvious difference is observed so far.
> 
> Genoa:
> ChaCha20-xiangshan shows 44% throughput improvement.
> 
> [Sapphire Rapids details]
> 
> [hackbench]
> Hackbench show overall improvement when there is only 1
> group, with different number of fd(pairs). This is the
> expected behavior because this test scenario would benefit
> from cache aware load balance most. Other number of groups
> shows not much difference(using default fd = 20).
> 
>        groups              baseline            sched_cache
> Min       1      37.5960 (   0.00%)     26.4340 (  29.69%)
> Min       3      38.7050 (   0.00%)     38.6920 (   0.03%)
> Min       5      39.4550 (   0.00%)     38.6280 (   2.10%)
> Min       7      51.4270 (   0.00%)     50.6790 (   1.45%)
> Min       12     62.8540 (   0.00%)     63.6590 (  -1.28%)
> Min       16     74.0160 (   0.00%)     74.7480 (  -0.99%)
> Amean     1      38.4768 (   0.00%)     26.7146 *  30.57%*
> Amean     3      39.0750 (   0.00%)     39.5586 (  -1.24%)
> Amean     5      41.5178 (   0.00%)     41.2766 (   0.58%)
> Amean     7      52.1164 (   0.00%)     51.5152 (   1.15%)
> Amean     12     63.9052 (   0.00%)     64.0420 (  -0.21%)
> Amean     16     74.5812 (   0.00%)     75.4318 (  -1.14%)
> BAmean-99 1      38.2027 (   0.00%)     26.5500 (  30.50%)
> BAmean-99 3      38.8725 (   0.00%)     39.2225 (  -0.90%)
> BAmean-99 5      41.1898 (   0.00%)     41.0037 (   0.45%)
> BAmean-99 7      51.8645 (   0.00%)     51.4453 (   0.81%)
> BAmean-99 12     63.6317 (   0.00%)     63.9307 (  -0.47%)
> BAmean-99 16     74.4528 (   0.00%)     75.2113 (  -1.02%)
> 
> [schbench]
> Wakeup Latencies 99.0th improvement is observed.
> 
> threads          baseline             sched_cache          change
> 1                13.80(1.10)          14.80(2.86)          -7.25%
> 2                12.00(1.00)          8.00(2.12)           +33.33%
> 4                9.00(0.00)           5.60(0.89)           +37.78%
> 8                9.00(0.00)           6.40(1.14)           +28.89%
> 16               9.20(0.45)           6.20(0.84)           +32.61%
> 32               9.60(0.55)           7.00(0.71)           +27.08%
> 64               10.80(0.45)          8.40(0.55)           +22.22%
> 128              12.60(0.55)          11.40(0.55)          +9.52%
> 239              14.00(0.00)          14.20(0.45)          -1.43%
> 
> [stream]
> No much difference is observed.
>                              baseline                     sc
> GB/sec copy-2        35.00 (   0.00%)       34.79 (  -0.60%)
> GB/sec scale-2       24.04 (   0.00%)       23.90 (  -0.58%)
> GB/sec add-2         28.98 (   0.00%)       28.92 (  -0.22%)
> GB/sec triad-2       28.32 (   0.00%)       28.31 (  -0.04%)
> 
> [netperf]
> No much difference is observed(consider the stdev).
> 
>          nr_pairs          netperf                netperf
> 
> Hmean     60      1023.44 (   0.00%)     1021.87 (  -0.15%)
> BHmean-99 60      1023.78 (   0.00%)     1022.22 (  -0.15%)
> Hmean     120      792.09 (   0.00%)      793.75 (   0.21%)
> BHmean-99 120      792.36 (   0.00%)      794.04 (   0.21%)
> Hmean     180      513.42 (   0.00%)      513.53 (   0.02%)
> BHmean-99 180      513.81 (   0.00%)      513.80 (  -0.00%)
> Hmean     240      387.09 (   0.00%)      387.33 (   0.06%)
> BHmean-99 240      387.18 (   0.00%)      387.45 (   0.07%)
> Hmean     300      316.04 (   0.00%)      315.68 (  -0.12%)
> BHmean-99 300      316.12 (   0.00%)      315.77 (  -0.11%)
> Hmean     360      496.38 (   0.00%)      455.49 (  -8.24%)
> BHmean-99 360      499.88 (   0.00%)      458.17 (  -8.34%)
> Hmean     420      497.32 (   0.00%)      501.84 (   0.91%)
> BHmean-99 420      499.90 (   0.00%)      504.56 (   0.93%)
> Hmean     480      417.62 (   0.00%)      432.25 (   3.50%)
> BHmean-99 480      419.96 (   0.00%)      434.43 (   3.45%)
> 
> In above case of 360 pairs, although there is a performance
> drop of 8.24%, the corresponding:
> HCoeffVar   360    23.78 (   0.00%)       29.52 ( -24.15%)
> shows that the regression is within the run-to-run variance.
> 
> [Milan details]
> 
> default settings:
> [hackbench]
> 
> Min       1      50.8170 (   0.00%)     51.1890 (  -0.73%)
> Min       3      59.3610 (   0.00%)     58.6080 (   1.27%)
> Min       5      94.9760 (   0.00%)     96.0210 (  -1.10%)
> Min       7     123.3270 (   0.00%)    124.1680 (  -0.68%)
> Min       12    179.2000 (   0.00%)    181.8390 (  -1.47%)
> Min       16    238.8680 (   0.00%)    242.6390 (  -1.58%)
> Amean     1      51.6614 (   0.00%)     51.3630 (   0.58%)
> Amean     3      60.1886 (   0.00%)     59.4542 (   1.22%)
> Amean     5      95.7602 (   0.00%)     96.8338 (  -1.12%)
> Amean     7     124.0332 (   0.00%)    124.4406 (  -0.33%)
> Amean     12    181.0324 (   0.00%)    182.9220 (  -1.04%)
> Amean     16    239.5556 (   0.00%)    243.3556 *  -1.59%*
> BAmean-99 1      51.5335 (   0.00%)     51.3338 (   0.39%)
> BAmean-99 3      59.7848 (   0.00%)     59.0958 (   1.15%)
> BAmean-99 5      95.6698 (   0.00%)     96.5450 (  -0.91%)
> BAmean-99 7     123.8478 (   0.00%)    124.3760 (  -0.43%)
> BAmean-99 12    180.8035 (   0.00%)    182.5135 (  -0.95%)
> BAmean-99 16    239.1933 (   0.00%)    243.0570 (  -1.62%)
> 
> [schbench]
> 
> threads          baseline             sched_cache          change
> 1                12.00(2.00)          11.00(0.71)          +8.33%
> 2                12.40(0.89)          13.80(0.84)          -11.29%
> 4                14.20(0.45)          14.80(0.45)          -4.23%
> 8                16.00(0.00)          15.80(0.45)          +1.25%
> 16               16.00(0.00)          16.00(0.71)          0.00%
> 32               19.40(0.55)          18.60(0.55)          +4.12%
> 63               22.20(0.45)          23.20(0.45)          -4.50%
> 
> [stream]
> No obvious difference is found.
> export STREAM_SIZE=$((128000000))
> 
>                      baseline               sched_cache
> GB/sec copy-16       726.48 (   0.00%)      715.60 (  -1.50%)
> GB/sec scale-16      577.71 (   0.00%)      577.03 (  -0.12%)
> GB/sec add-16        678.85 (   0.00%)      672.87 (  -0.88%)
> GB/sec triad-16      735.52 (   0.00%)      729.05 (  -0.88%)
> 
> 
> [netperf]
> No much difference is observed.
> 
>          nr_pairs          baseline           sched_cache
> Hmean     32       755.98 (   0.00%)      755.17 (  -0.11%)
> BHmean-99 32       756.42 (   0.00%)      755.40 (  -0.13%)
> Hmean     64       677.38 (   0.00%)      669.75 (  -1.13%)
> BHmean-99 64       677.50 (   0.00%)      669.86 (  -1.13%)
> Hmean     96       498.52 (   0.00%)      496.73 (  -0.36%)
> BHmean-99 96       498.69 (   0.00%)      496.93 (  -0.35%)
> Hmean     128      604.38 (   0.00%)      604.22 (  -0.03%)
> BHmean-99 128      604.87 (   0.00%)      604.87 (   0.00%)
> Hmean     160      471.67 (   0.00%)      468.29 (  -0.72%)
> BHmean-99 160      474.34 (   0.00%)      471.05 (  -0.69%)
> Hmean     192      381.18 (   0.00%)      384.88 (   0.97%)
> BHmean-99 192      383.30 (   0.00%)      386.82 (   0.92%)
> Hmean     224      327.79 (   0.00%)      326.05 (  -0.53%)
> BHmean-99 224      329.85 (   0.00%)      327.87 (  -0.60%)
> Hmean     256      284.61 (   0.00%)      300.52 (   5.59%)
> BHmean-99 256      286.41 (   0.00%)      302.06 (   5.47%)
> 
> [Genoa details]
> [ChaCha20-xiangshan]
> ChaCha20-xiangshan is a simple benchmark using a static build of an
> 8-thread Verilator of XiangShan(RISC-V). The README file can be
> found here[2]. The score depends on how aggressive the user set the
> /sys/kernel/debug/sched/llc_aggr_tolerance. Using the default values,
> there is no much difference observed. While setting the
> /sys/kernel/debug/sched/llc_aggr_tolerance to 100, 44% improvment is
> observed.
> 
> baseline:
> Host time spent: 50,868ms
> 
> sched_cache:
> Host time spent: 28,349ms
> 
> The time has been reduced by 44%.

Milan showed no improvement across all benchmarks, which could be due to the 
CCX topology (8 CCXs × 8 CPUs) where the LLC domain is too small for this
optimization to be effective. Moreover there could be overhead due to additional
computations.

ChaCha20-xiangshan improvement in Genoa when llc_aggr_tolerance is set to 100 seems
due to having relatively lesser thread count. Please provide the numbers
with default values too. Would like to know numbers on varying loads.

In Power 10 and Power 11, the LLC size is 4 threads which is even smaller. Not
expecting improvements here but will run some workloads and share the data.

Not gone through the entire series yet but are the situations like say in two
NUMA system, if a task's preferred LLC is on the wrong NUMA node for its memory,
which takes precedence? 

Also, what about the workloads that don't share data like stress-ng? It will
be good to make sure that most other workloads don't suffer. As mentioned,
per process knob for llc_aggr_tolerance could help.

Thanks,
Madadi Vineeth Reddy

> 
> Thanks to everyone who participated and provided valuable suggestions for
> the previous versions. Your comments and tests on the latest version are
> also greatly appreciated in advance.
> 
> Tim
> 
> [1] https://lore.kernel.org/lkml/20250325120952.GJ36322@noisy.programming.kicks-ass.net/
> 
> [2] https://github.com/yu-chen-surf/chacha20-xiangshan/blob/master/README.eng.md
> 
> RFC v4:
> [3] https://lore.kernel.org/all/cover.1754712565.git.tim.c.chen@linux.intel.com/
> 
> RFC v3
> [4] https://lore.kernel.org/all/cover.1750268218.git.tim.c.chen@linux.intel.com/
> 
> RFC v2:
> [5] https://lore.kernel.org/lkml/cover.1745199017.git.yu.c.chen@intel.com/
> 
> 
> Chen Yu (7):
>   sched/fair: Record per-LLC utilization to guide cache-aware scheduling
>     decisions
>   sched/fair: Introduce helper functions to enforce LLC migration policy
>   sched/fair: Introduce a static key to enable cache aware only for
>     multi LLCs
>   sched/fair: Exclude processes with many threads from cache-aware
>     scheduling
>   sched/fair: Disable cache aware scheduling for processes with high
>     thread counts
>   sched/fair: Avoid cache-aware scheduling for memory-heavy processes
>   sched/fair: Add user control to adjust the tolerance of cache-aware
>     scheduling
> 
> Peter Zijlstra (Intel) (1):
>   sched/fair: Add infrastructure for cache-aware load balancing
> 
> Tim Chen (11):
>   sched/fair: Add LLC index mapping for CPUs
>   sched/fair: Assign preferred LLC ID to processes
>   sched/fair: Track LLC-preferred tasks per runqueue
>   sched/fair: Introduce per runqueue task LLC preference counter
>   sched/fair: Count tasks prefering each LLC in a sched group
>   sched/fair: Prioritize tasks preferring destination LLC during
>     balancing
>   sched/fair: Identify busiest sched_group for LLC-aware load balancing
>   sched/fair: Add migrate_llc_task migration type for cache-aware
>     balancing
>   sched/fair: Handle moving single tasks to/from their preferred LLC
>   sched/fair: Consider LLC preference when selecting tasks for load
>     balancing
>   sched/fair: Respect LLC preference in task migration and detach
> 
>  include/linux/cacheinfo.h      |   21 +-
>  include/linux/mm_types.h       |   45 ++
>  include/linux/sched.h          |    5 +
>  include/linux/sched/topology.h |    4 +
>  include/linux/threads.h        |   10 +
>  init/Kconfig                   |   20 +
>  init/init_task.c               |    3 +
>  kernel/fork.c                  |    6 +
>  kernel/sched/core.c            |   18 +
>  kernel/sched/debug.c           |   56 ++
>  kernel/sched/fair.c            | 1022 +++++++++++++++++++++++++++++++-
>  kernel/sched/features.h        |    1 +
>  kernel/sched/sched.h           |   27 +
>  kernel/sched/topology.c        |   61 +-
>  14 files changed, 1283 insertions(+), 16 deletions(-)
> 


