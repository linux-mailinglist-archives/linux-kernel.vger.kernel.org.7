Return-Path: <linux-kernel+bounces-852754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED1EBD9CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9D5C35549C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CAB265609;
	Tue, 14 Oct 2025 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V12dNzqf"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE7749C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449857; cv=none; b=fdz1q0dI7nHbzMkBcCMHgA72KjHpRM2c0IQKDQMcAbyAALJDjy5IzsLDorl2HqMlpnEUvTqhPy1Mw1fgF6O0q1aDeNwf/om/b89qL8eV9k4amWhqubBbVLao/DwBszq8lGd97s34guXEr/2wp5Ut3VvJ+T93+gnDXvc57ZdIKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449857; c=relaxed/simple;
	bh=08s4hNqL73lJfclAoyTeWySAaUeyKkrBMu0GYoSUv1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hO0w+0pL5nojyOiCN+70UxJ9IRUmcB1qq1FaDfMzJyL28avxk+FPFCAi6tsRr+XzdkxECUSTfKaJ4xUz7LzylMERyhoLvpL0pl7ZmxNLVvW1kgwWoxcxqGL9HfT1WP8F4sR4Je42ABB4oGTQa2H2sbrVlBsJi9vCm31EFEjuZww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V12dNzqf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E5U79V008641;
	Tue, 14 Oct 2025 13:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=P4ewbUHQlcBrpBc8GRTSt
	Oi1XPRe2K+KNzft89xndVo=; b=V12dNzqfFQ2rlLwXS1qIzeu4jifPsa8gOxoWJ
	WjeriYOXE6up53ZcqaanOE4hxEURrfaCLKGSZXGixFSVdIq0Ulx3aiQ4h4Pb+vpk
	qDPSpQFnNLrf7wW/zga++lgVZRbE6DKLrGjINHYAB7R1SysPw4+Rczxsc8+/XJeO
	ad15gpLbsWXqTqnoqjKHUOg54vXkuFIy9OWZRcCTkFnpciPAG4Xs1LdGJvh8Mb7h
	3AMFLkbOEAQ3dZxw6f4zAlnqf6y6EXAjP7Y4OpW4UhQEuo8T78pPdzmTKAEkBG8m
	fxC/sjY3G/N4pv6Yim3ijlNGBlxlUHJg17CjtwKbb6iSBaWhg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewty09b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 13:50:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59EAoqtE018812;
	Tue, 14 Oct 2025 13:50:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r2jmk7gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 13:50:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59EDocvC38797676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 13:50:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C7F62008D;
	Tue, 14 Oct 2025 13:50:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 515D120089;
	Tue, 14 Oct 2025 13:50:36 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 14 Oct 2025 13:50:36 +0000 (GMT)
Date: Tue, 14 Oct 2025 19:20:35 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, Doug Nelson <doug.nelson@intel.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [RESEND PATCH] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
Message-ID: <aO5VK4PO_REXNhnN@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
 <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
 <aa3d20e6d451e0d0b812fe16e9d403c1033feeaa.camel@linux.intel.com>
 <20251014092436.GK4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20251014092436.GK4067720@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lfgDG7RAB442uAbvuQ_GtBQeK7c8eIn_
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68ee5533 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=P7ho2RKDmmS_tY2JI-cA:9 a=wPNLvfGTeEIA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: lfgDG7RAB442uAbvuQ_GtBQeK7c8eIn_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX9TCGDsUWPOg0
 WHA4FejpJ2V38DHC4AqStEf544pi3fDLj1AjRISWIfAAt0t1WnH7Lj35oAUgHYKguCShlNHZehl
 QlePEM/jz3AT9EuA7vrQ2+NL1E7c3MZxxnUlv4QT12Grn7JDLE03D89MvtSGtxz3hdt20oj1/h7
 fgmgfp/z6I/SUFUcFYPvQwUXvHXh/b3pGx0gCthThW3az7R+vTlLSrf14R2Vvpre4fjaYuFFphS
 VmF9Y7sd0tX4fuqwycVFWEsAux20JLlwcnyPKdKU+eSo/UzisDNw9lSGEptFMXby6/FczSXJIMK
 BOqPJkZa6UewKURoGtjykVs8r43yaNG16WY8QUwvQh5OdcTGmZ7/Dg4h3B+N9Q8FhF+DLaRW8Zd
 +E/h1CNqY0BRhyM3UpCO2nKTr24CyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

* Peter Zijlstra <peterz@infradead.org> [2025-10-14 11:24:36]:

> On Mon, Oct 13, 2025 at 02:54:19PM -0700, Tim Chen wrote:
> 
> 
> Right, Yu Chen said something like that as well, should_we_balance() is
> too late.
> 
> Should we instead move the whole serialize thing inside
> sched_balance_rq() like so:
> 
> @@ -12122,21 +12148,6 @@ static int active_load_balance_cpu_stop(void *data)
>  	return 0;
>  }
>  
> -/*
> - * This flag serializes load-balancing passes over large domains
> - * (above the NODE topology level) - only one load-balancing instance
> - * may run at a time, to reduce overhead on very large systems with
> - * lots of CPUs and large NUMA distances.
> - *
> - * - Note that load-balancing passes triggered while another one
> - *   is executing are skipped and not re-tried.
> - *
> - * - Also note that this does not serialize rebalance_domains()
> - *   execution, as non-SD_SERIALIZE domains will still be
> - *   load-balanced in parallel.
> - */
> -static atomic_t sched_balance_running = ATOMIC_INIT(0);
> -
>  /*
>   * Scale the max sched_balance_rq interval with the number of CPUs in the system.
>   * This trades load-balance latency on larger machines for less cross talk.
> @@ -12192,7 +12203,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>  	/* Earliest time when we have to do rebalance again */
>  	unsigned long next_balance = jiffies + 60*HZ;
>  	int update_next_balance = 0;
> -	int need_serialize, need_decay = 0;
> +	int need_decay = 0;
>  	u64 max_cost = 0;
>  
>  	rcu_read_lock();
> @@ -12216,13 +12227,6 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>  		}
>  
>  		interval = get_sd_balance_interval(sd, busy);
> -
> -		need_serialize = sd->flags & SD_SERIALIZE;
> -		if (need_serialize) {
> -			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
> -				goto out;
> -		}
> -
>  		if (time_after_eq(jiffies, sd->last_balance + interval)) {
>  			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
>  				/*
> @@ -12236,9 +12240,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>  			sd->last_balance = jiffies;
>  			interval = get_sd_balance_interval(sd, busy);
>  		}
> -		if (need_serialize)
> -			atomic_set_release(&sched_balance_running, 0);
> -out:
> +
>  		if (time_after(next_balance, sd->last_balance + interval)) {
>  			next_balance = sd->last_balance + interval;
>  			update_next_balance = 1;

I think this is better since previously the one CPU which was not suppose to
do the balancing may increment the atomic variable. If the CPU, that was
suppose to do the balance now tries it may fail since the variable was not
yet decremented.

-- 
Thanks and Regards
Srikar Dronamraju

