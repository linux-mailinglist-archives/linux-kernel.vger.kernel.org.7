Return-Path: <linux-kernel+bounces-897412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 151F6C52D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A2E9503462
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A346433B6C4;
	Wed, 12 Nov 2025 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p+eWwLpo"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693C223F42D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958271; cv=none; b=jh2jJs5i73klkbHH9VDilBmJ2hsOCpFmFYQVSWeWyvmZagr4w0m22Imk0RddOGp9CxSzuNmtlXjCuYZ/QmJiNAUN5w8Mf977DxU44dC2YE1qYSBHwjYhSr/eHykQcrsmkgXv4PhZpgHCuUqdiO6bKs1ULE1xhmQ/GXayQps+M9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958271; c=relaxed/simple;
	bh=hpkC3W+NJX8KzMkHHg8Cnc5ueNDFa/7APh9Wf2Lb5vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvtgFLKKKub81NvlBaTW6koGkDldnkj9IAkEhrGXSISDGpugTVKbuwkW68Vlpg6iIhjIUsEeSo7sZhjY+ah0rH5tZyyLh3b0oenSPpeAZxGhmXRwIwgCqK0rSt+Z0kqpXTj/7WI4VkhxKxpjA2PuUg4bxX00+37Wz8WBLJHmT6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p+eWwLpo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC516io023600;
	Wed, 12 Nov 2025 14:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VGSJSK
	VY+69AjWM0F1LGNc79oqBRaPKpDvDfhmHgmeg=; b=p+eWwLpougET/Bc30bExn4
	d/XOgDN2q0WG7x9Xq9HXcoA4rOBQb2uboYhlp/AMeuQA8ZoVl09NG3FGOJWGsPe7
	5jkzhSHG75/xXFUf9VDYP7kP3vPgAx7AjnBVKrXL8t5cMNrOa8ytqvR00TLI98+T
	OXFcFlNnqgfEkmRwl92N9TSShsbKhFuvj+u+vmiM/2dydstUbOG0ab4DcG+I/lx1
	/rVnxo72v0O3JCCY04UOAg2wumib5pWc2P+Gt0NdrXYArm7EMbP60lXaqR5YO/br
	m/GmW5JSbS+l8j/BwIiM11b1Z2Sch4LCnkABuFvAA2/r7e9ZdjkyKSCeWFyP3bDw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tk0hry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 14:37:32 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACEQl9X028846;
	Wed, 12 Nov 2025 14:37:31 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tk0hrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 14:37:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACCtAsX007292;
	Wed, 12 Nov 2025 14:37:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdjggv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 14:37:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACEbTmK40239468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 14:37:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7D6920040;
	Wed, 12 Nov 2025 14:37:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A28A82004B;
	Wed, 12 Nov 2025 14:37:25 +0000 (GMT)
Received: from [9.124.217.11] (unknown [9.124.217.11])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 14:37:25 +0000 (GMT)
Message-ID: <2acd7c1d-e2b4-40a0-85de-55f9b2635dad@linux.ibm.com>
Date: Wed, 12 Nov 2025 20:07:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] sched/fair: Small cleanup to sched_balance_newidle()
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
        Chris Mason <clm@meta.com>,
        Joseph Salisbury <joseph.salisbury@oracle.com>,
        Adam Li <adamli@os.amperecomputing.com>,
        Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
        Josh Don <joshdon@google.com>
References: <20251107160645.929564468@infradead.org>
 <20251107161739.525916173@infradead.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251107161739.525916173@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R6upI6lXY_1d9enpLjyEYx-GKOAltSBv
X-Proofpoint-ORIG-GUID: Ohi0sMLgEdApd-thvZEY0z9MiStpX8sA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX0XL6uYOGFHQe
 iQVAmbP/FrvfyP2xFAYOFtyece7rppL92rmmvcXUMbhBG/D7no9IIQ7WeHQTaOQNK2vk/Yf0y+N
 48ZjFTxRoBq1Ov2dkFs6+IHEUaSKnTv/rdeT8F3DrCfbKgDdgs5a1xL9gSERI5Ar7v4bwdrN9pr
 lhpICimfAn8f6Z3ebOPIbsE1mJT72BRdE2SYNfIIMFW9IsyKVVn+C1ajn9oBQSkF94LvTjfa3Mo
 6Khhto6Y5Ro8QT0xw9exllnSCH/Lx8G9SZTGooGB/4bzKQ9PMGifpuJlCmDgV3ohf+VWNMzBnKH
 BAlKKV9q8J9l9bSPYOMH2uyZhW05fWtwDSVSzgcd5icaMfsJVmHOGVEqwmVQYksuCPB7Pzvq1ZU
 cixxBQTloSBUQeIOiLA7SMnl1FFUAg==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=69149bac cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=4Lv97mECmzqO5O8fzCYA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099



On 11/7/25 9:36 PM, Peter Zijlstra wrote:
> Pull out the !sd check to simplify code.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   kernel/sched/fair.c |   10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12811,14 +12811,16 @@ static int sched_balance_newidle(struct
>   
>   	rcu_read_lock();
>   	sd = rcu_dereference_check_sched_domain(this_rq->sd);
> +	if (!sd) {
> +		rcu_read_unlock();
> +		goto out;
> +	}
>   

when is sd null? on isol_cpus ?

if sd is null, i think we are skipping these compared to earlier.

         t0 = sched_clock_cpu(this_cpu);
         sched_balance_update_blocked_averages(this_cpu);

>   	if (!get_rd_overloaded(this_rq->rd) ||
> -	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> +	    this_rq->avg_idle < sd->max_newidle_lb_cost) {
>   
> -		if (sd)
> -			update_next_balance(sd, &next_balance);
> +		update_next_balance(sd, &next_balance);
>   		rcu_read_unlock();
> -
>   		goto out;
>   	}
>   	rcu_read_unlock();
> 
> 


