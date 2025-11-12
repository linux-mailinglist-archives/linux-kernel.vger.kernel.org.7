Return-Path: <linux-kernel+bounces-896716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE0BC510B2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDB6D4F3182
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AC32C08C2;
	Wed, 12 Nov 2025 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rOoRZCkN"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5ED1E492A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934562; cv=none; b=XfN2cwiUzIPTepy/K7eEeGSQ/1YDg+gqdScENx+uupHzqvSkpolsNOu+NyJaqtbYsInNsHyB4tqfE8lhPWCzYwmecpN7DMyOaDJchHyKgmeh2ssD3Ra0R5y29LF9860i7zz1JNnmtFaeBD/BAoiNGRhNhWM8DiTDyEyDvv6KMuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934562; c=relaxed/simple;
	bh=Qq7OKFKaOUBXh6xDTU5tCQ+8K8lsX5ZboEN8OLYbUis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S63SZtyNyoU9O1E6igQS4egVsiYxBSrGh39WNp9PWfLaY1rLka1od93NP5HuI9otsRFCkb6+HIxBI6F4Nx+CNWY35uJMm2DzuLKyImSuNqwBWyKF2gk5JTK9X4l9oeUk3T7LzygkhV0+iyu7arFutNKTXmD9p+V2iwaExw8kmto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rOoRZCkN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC1hAHP026220;
	Wed, 12 Nov 2025 08:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=X9AiU2Tb5Ik89/jhJYNzh
	Ooo0OyiNeU7lVH79d+OXhY=; b=rOoRZCkNPfnhIfSpARqg/D81QZXjhDWtVmISZ
	i9YSFAyvEpvYevkKL17VHwxhe6ldy6sUd1Smatw8aqAybqgIq/s977DuV4gXhWPy
	258fTQNzk5UvDTx429SnDPe2QbJhYNstEhOUmtDN5uw4jVuPOhDKPM9cjT4ubbLM
	dNfCQ2DuQ5uRw25UNn7IbLyeJuqQPBdHAzjVmQJse2wb9I1ywlQSskO+k7zPzS20
	SC/m26TamcoVBJ6zADfT6h4ojXZuajEzH8GeiiaAcWBdS8v9kN2kPPQR+fixc1Wk
	B/tmBl+GOkf8f2CeidMFOOmGob3HMNqrWSFbIxyHYX3Xy8nYA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk899gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 08:02:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC637lQ004735;
	Wed, 12 Nov 2025 08:02:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aagjxy4fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 08:02:30 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AC82QaN43516216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 08:02:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D41EA2004B;
	Wed, 12 Nov 2025 08:02:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B521F20040;
	Wed, 12 Nov 2025 08:02:24 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 12 Nov 2025 08:02:24 +0000 (GMT)
Date: Wed, 12 Nov 2025 13:32:23 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, Doug Nelson <doug.nelson@intel.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v4] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
Message-ID: <aRQ_D1vyNfGVo-xK@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfXx2y1LeaFrpVF
 aRAtQ2DH1ERbJjZZSaMzMp+SJlTmHOiMKQpiR+Ty3fah7x4/K5+xRXQttqDdDMk0xFypT1atgTA
 Z9yerqNGiyNdH1VSkTnzWPEAkneCHJEkEOmIygMcjTFD4stdAf0ymur0aXayBpqbY/k3fsfQzOQ
 c63fkWO+CvW9gGamJT0FWHSc6ChkKk+qAD7A6uJhmL4VFrmPkuZ821SXssuBCgN94wo9wRAeUai
 2pozwT0s0yRnRNZfrNNsQ/qGOTIGMZ9baZT72njpHafOIjV+0kCbAitWHQCoLLOEd6HB7jcraFz
 kzzNxiLSnfeGCETdkBugoTvlva1Ehnzv5BsZXQu8aBJxDYXA2tp/Rtlv9mwMwYY2l4DalvDJ20p
 jlUrM3CrsiJT/BjJ5bc/RBETARM9og==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=69143f18 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=jY-qJ0Ov87OzJuVr7I4A:9 a=wPNLvfGTeEIA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: X9_X7_9LL_0-Bk0O5VVs50yWk0AKfmFW
X-Proofpoint-GUID: X9_X7_9LL_0-Bk0O5VVs50yWk0AKfmFW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

* Tim Chen <tim.c.chen@linux.intel.com> [2025-11-10 10:47:35]:

> The NUMA sched domain sets the SD_SERIALIZE flag by default, allowing
> only one NUMA load balancing operation to run system-wide at a time.
> 
> @@ -11757,17 +11772,26 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>  		.fbq_type	= all,
>  		.tasks		= LIST_HEAD_INIT(env.tasks),
>  	};
> +	bool need_unlock;
>  
>  	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
>  
>  	schedstat_inc(sd->lb_count[idle]);
>  
>  redo:
> +	need_unlock = false;
>  	if (!should_we_balance(&env)) {
>  		*continue_balancing = 0;
>  		goto out_balanced;
>  	}
>  
> +	if (sd->flags & SD_SERIALIZE) {
> +		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1)) {
> +			goto out_balanced;
> +		}
> +		need_unlock = true;
> +	}
> +

Moving the serialize check to sched_balance_rq is better since we only take
when its really needed. Previously we could have skipped the balancing for
the appropriate CPU.

>  	group = sched_balance_find_src_group(&env);
>  	if (!group) {
>  		schedstat_inc(sd->lb_nobusyg[idle]);
> @@ -11892,6 +11916,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>  			if (!cpumask_subset(cpus, env.dst_grpmask)) {
>  				env.loop = 0;
>  				env.loop_break = SCHED_NR_MIGRATE_BREAK;
> +				if (need_unlock)
> +					atomic_set_release(&sched_balance_running, 0);
> +

One nit:
While the current code is good, would conditionally resetting the
need_unlock just after resetting the atomic variable better than
unconditional reset that we do now?

>  				goto redo;

Otherwise looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju

