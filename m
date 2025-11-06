Return-Path: <linux-kernel+bounces-888234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5941CC3A47A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66DF188562F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EEC28640B;
	Thu,  6 Nov 2025 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S3vTlJ6F"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F5427146A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424905; cv=none; b=KuRYlIPdxvvNPHkzkw29Jg6mCFKOOoTHfy+Jw8lLPZuh0XHSOn/p9Vmkv7rwLcP5AmpegYTaGzeuI4O2XkYX1sVPvmhaFEP3bqGieEOTNRHdTMS6ADEIA+zCJ/41NKpnSGzwUHdexeMG3cuuHffWcyesqVq2whvmjaxEHVa1n9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424905; c=relaxed/simple;
	bh=AVZ5wby1RDzze4ng10kHKDCxhdHqulO0oxGWwRvnIyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XS4+yqLH+PgxELuVMRgopvPXiua39aIFsNxJOLJN7FZdU761yazEAXLoFB0fVMuhYnhDv8Dav6+x/YUJiWnmhH/Mb4XPuQvb1k431N82Ao69YSw3sBNGU2KUGFuZ99QYajetUF5qv9DHbdn1IRl8jZKIjCoD9pSxm+Mxg5Yhzzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S3vTlJ6F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5N8VxY007895;
	Thu, 6 Nov 2025 10:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ks5H+V
	3f1oICR1stDY6x9P0Y6IC/di+AhRqGqfNT63g=; b=S3vTlJ6FUqitBivLh7gBLi
	HcavO/MZzW76NDJv9UCOfyfhO1RZicNpOYxICX4l9I4K74PK7H1uJhA39ZMZQpMS
	EnJK7MBgs/haJ3H1flSae+mU/OL2Ul9vFqrADfubt2SvYyIMmS8dAijQviZUcx2V
	B72GtysY8DVutJkKixAI685w2Iq0WGE++tZzALtaI/s6GG9+dt9riB/EOza8qVs0
	KxtUDCHDb1hCv+SyrKKcXoTjPyi7ch9tIMRqT18MCIkAnFoviOnf4o2pYUhaP1Wl
	Vh70Oqyop/gl0UDFSUx30JyXotGhFCieTCeXwz9BRpM/WmnvefDVMZvkqP3qjIjA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mrduap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 10:28:08 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A6AHTbi017098;
	Thu, 6 Nov 2025 10:28:08 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mrduak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 10:28:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A67p3rY018659;
	Thu, 6 Nov 2025 10:28:07 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whnmws7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 10:28:07 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A6AS6gJ19726888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 10:28:06 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58D9C58053;
	Thu,  6 Nov 2025 10:28:06 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF25C58043;
	Thu,  6 Nov 2025 10:28:00 +0000 (GMT)
Received: from [9.98.110.226] (unknown [9.98.110.226])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Nov 2025 10:28:00 +0000 (GMT)
Message-ID: <a3059d6c-9e3e-459d-aeb2-ec009c9ab06a@linux.ibm.com>
Date: Thu, 6 Nov 2025 15:57:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Optimize core cookie matching check
To: Fernand Sieber <sieberf@amazon.com>
Cc: kprateek.nayak@amd.com, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, dwmw@amazon.co.uk,
        jschoenh@amazon.de, liuyuxua@amazon.com,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20251105152538.470586-1-sieberf@amazon.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20251105152538.470586-1-sieberf@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KNqQWK9pORY5ohE4HGUPOYTgw75yey4U
X-Authority-Analysis: v=2.4 cv=MKhtWcZl c=1 sm=1 tr=0 ts=690c7838 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vggBfdFIAAAA:8 a=VnNF1IyMAAAA:8 a=2esi0OvIpO2VS2o9Y34A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: gbN0qlmO49m8W80iIadARpd2yRbj0jFs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwMSBTYWx0ZWRfXxTRrDRrrDLAg
 yAUGMP2V/xiFfkSs71JuvSxKwMEMnHgk9cZdT6VS9RX67p/hTpcF6IVFbcDjDPvAT0ZzUoDn9Yu
 XeVW4w9xzHj1eaixhI79R28zL4/ENXo1pEWr83GgdWOs+MMm6r4xHOx/dyaVsAnaITOvW6efKit
 MW0HQBonXnypYlGyZIn4XRUTEMidTSgJ7HVeseRPVBaNoCou8SsCoN6n4FtJbopSnq9gDhYBwA3
 4tHNb4qUFcq/ujzXX2QCniBOb+01t4SAyPmJMm/OYnMPwns2oR50MIDCIPTPecX7u31VTu9GjHo
 qz/VHcoLhxtGJAX6yAk6WLMjbk0mvSRoYFbg2lR7gVzqFyX5gs/oOeGPCrz7a6nSSOqk0q0rsiq
 lcIYyKCrGU4oHbCpA5znBvn0e6q9FA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010001

Hi Fernand,

On 05/11/25 20:55, Fernand Sieber wrote:
> Early return true if the core cookie matches. This avoids the SMT mask
> loop to check for an idle core, which might be more expensive on wide
> platforms.
> 
> Signed-off-by: Fernand Sieber <sieberf@amazon.com>
> ---
>  kernel/sched/sched.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index adfb6e3409d7..381cd561e99b 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1432,6 +1432,9 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
>  	if (!sched_core_enabled(rq))
>  		return true;
>  
> +	if (rq->core->core_cookie == p->core_cookie)
> +		return true;
> +
>  	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
>  		if (!available_idle_cpu(cpu)) {
>  			idle_core = false;
> @@ -1443,7 +1446,7 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
>  	 * A CPU in an idle core is always the best choice for tasks with
>  	 * cookies.
>  	 */
> -	return idle_core || rq->core->core_cookie == p->core_cookie;
> +	return idle_core;
>  }

LGTM.
Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks,
Madadi Vineeth Reddy

>  
>  static inline bool sched_group_cookie_match(struct rq *rq,


