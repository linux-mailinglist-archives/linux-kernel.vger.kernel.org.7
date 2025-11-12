Return-Path: <linux-kernel+bounces-897101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B61DEC52069
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE312502A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F67288537;
	Wed, 12 Nov 2025 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J3hUbAhI"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC8A30BB9F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946771; cv=none; b=oix/1VGAU/Y21xqEGa4LqKCAHAAqZ6dEZJsXw1N13oVk+1ye1HPL2L6+Lxn1uMtQK4ONxB65IDIdEfzsNcyS+LU+n7q2WRX2J0wKyQ+TIoYXWxvZZdHIim0cETuTQ0ChSjgBxRWcLadfm/RY2Vxa2WluJspjhHND7uS1SR6nraQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946771; c=relaxed/simple;
	bh=DRKVPhu7GEjK3Lsinu55P2UxKKLVya/ccat1CHCMKhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQIG/BbIBPeVpiWIGaM4YUtuRA+AOD0HPkXnEu92bZo9LuMJ7tD9bjvctP+133eBt0L77Y63TpferwzdNiANZ0WMSuDfjGCJRYO5nCup5ypbh9LCs1MW4mh30JTks5bW7HQhrcsQct/f6o1r3Iw+ZyBEvIaNDZGCniNLXJ/v1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J3hUbAhI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC0BNGU030154;
	Wed, 12 Nov 2025 11:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=TkHjIKrMPH6NSoUO7aUrJ
	pDtiNzxwl0VIPZVacflsMo=; b=J3hUbAhIkxlT5ZZZY0CbwndEEs+vQ90JPFJ49
	1xtttR8jwiJubScif59C0nxthkR1KftCqRPWiyUaAoGrA6uJ5fRDWFvjivPSfF/J
	2Y7AHwDoV4Wjwbg7vl39hDr43/c3wDYrv/F416X/ttltjftskjJ3ewbm8AAKd61p
	O7MQg15upGdXtNMrGo4cD+T+MBLRbzYXXycIDCuCWvRefKRkJcbVyI2RJsBMFkm7
	oPhcJZCgvYACU/2i6nNNGQK3GODqctNZhoYqZ+JH8+BEhlzhsGJPAy8JwOnLKv1T
	fdNSFG231a71HHY9vxzrN/0rOjpfuH8e1yaQIKc3W+89mxz2w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cj8wjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:25:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC9ehQg004744;
	Wed, 12 Nov 2025 11:25:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aagjxyx57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:25:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACBPpwX43844026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 11:25:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62F5820049;
	Wed, 12 Nov 2025 11:25:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26FED20040;
	Wed, 12 Nov 2025 11:25:49 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 12 Nov 2025 11:25:48 +0000 (GMT)
Date: Wed, 12 Nov 2025 16:55:48 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, Doug Nelson <doug.nelson@intel.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v4] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
Message-ID: <aRRuvLKvMdxw8bZV@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
 <aRQ_D1vyNfGVo-xK@linux.ibm.com>
 <20251112103740.GF4067720@noisy.programming.kicks-ass.net>
 <20251112104555.GE4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20251112104555.GE4068168@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=69146ec4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=uyTiLtyfZruu4zV4nskA:9 a=wPNLvfGTeEIA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfXxNsG/AwDDvc0
 vcEUz7HwGtU8ePG9X8+tpvFduMca7l1ZCC0xIpvuB8OFaDXQTlVcmMo8q8LtO1hfxgsVjO1jB99
 TOud9iT6P+4mqhUcTCd9GDV6DXtbUtAcFR6r7tP0+QfAOgqEr0EkCjRgcpF9eDrR+vUDmV/jAMz
 mx3BU2Pzx2XbfdQjWVdu1BQUCrpUJ4+G2gc0Q1EyTGXyXiCytu9c/orSQyqAc2oaUGMOECd/naj
 H0Rn2G7/n/QLcuoBjE7CB9EmjHCt2Xt/hTceuFR/BZqEN5VdQkM06a5uIaUasFrpoxArDCMQTVw
 OCYBDR0igS0eqlOtqoKcaSk+Lp/SjlaseG5kT+vtsMsnpskC6rBUVh0QIudwl+yT7o8mr9KeSr2
 TXUul0Kc4IY3xtV3ebpOjh0+f7wQYA==
X-Proofpoint-GUID: vjQw07j_pNWyHynreSwy5LWOGgq3HQ_e
X-Proofpoint-ORIG-GUID: vjQw07j_pNWyHynreSwy5LWOGgq3HQ_e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095

* Peter Zijlstra <peterz@infradead.org> [2025-11-12 11:45:55]:

> > 
> > Right, I had the same thought when grabbed the patch yesterday, but
> > ignored it.
> > 
> 
> Hmm, should we not redo while keeping the lock? Doesn't make much sense
> to drop and try to reacquire things here.
> 
> So perhaps this is the better option -- or did I overlook something with
> should_we_balance? It doesn't look like that will make a different
> decision on the retry.
> 
> ---
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11717,26 +11717,25 @@ static int sched_balance_rq(int this_cpu
>  		.fbq_type	= all,
>  		.tasks		= LIST_HEAD_INIT(env.tasks),
>  	};
> -	bool need_unlock;
> +	bool need_unlock = false;
>  
>  	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
>  
>  	schedstat_inc(sd->lb_count[idle]);
>  
> -redo:
> -	need_unlock = false;
>  	if (!should_we_balance(&env)) {
>  		*continue_balancing = 0;
>  		goto out_balanced;
>  	}
>  
>  	if (sd->flags & SD_SERIALIZE) {
> -		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1)) {
> +		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0, 1))
>  			goto out_balanced;
> -		}
> +
>  		need_unlock = true;
>  	}
>  
> +redo:
>  	group = sched_balance_find_src_group(&env);
>  	if (!group) {
>  		schedstat_inc(sd->lb_nobusyg[idle]);
> @@ -11861,9 +11860,6 @@ static int sched_balance_rq(int this_cpu
>  			if (!cpumask_subset(cpus, env.dst_grpmask)) {
>  				env.loop = 0;
>  				env.loop_break = SCHED_NR_MIGRATE_BREAK;
> -				if (need_unlock)
> -					atomic_set_release(&sched_balance_running, 0);
> -
>  				goto redo;
>  			}
>  			goto out_all_pinned;

If the CPU that was doing the balance was not the first CPU of the domain
span, but it was doing the balance since the first CPU was busy, and the
first CPU now happens to be idle at redo, the scheduler would have chosen the
first CPU to do the balance. However it will now choose the CPU that had the atomic..

I think this is better because 
- The first CPU may have tried just before this CPU dropped the atomic and
  hence we may miss the balance opportunity.
- The first CPU and the other CPU may not be sharing cache and hence there
  may be a cache-miss, which we are avoiding by doing this.

-- 
Thanks and Regards
Srikar Dronamraju

