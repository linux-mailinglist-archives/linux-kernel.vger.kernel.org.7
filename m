Return-Path: <linux-kernel+bounces-811483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ADCB529BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0A15676D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C14B266EEA;
	Thu, 11 Sep 2025 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AMQAQzrS"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F11329F2D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575220; cv=none; b=gvHjiNV1DwfNcb/wIjGJx8hmdz4WPwdKfRTZmbTUxAErcQBDXvv3S9cbpVLGcfyKdqMmpqYIaqWiLiB4osV+L/c9BPEYfuBNZVdAx6D73izhVWA51N4jmuNUhP0fTAw6a5JQoM5Phsd8ibrsqnoarGu6hyFAIDx8g0dM+lLdjcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575220; c=relaxed/simple;
	bh=FFFZOEtzLooP94LFZkfn6bByeWGQ5C7Y5GLiw0synX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=pSDL/G847B+0zb6KufM8Yvl3g3cGygeFNU0DJMlEYHuTNEePIMypshU4Y1zAXWe9QV1GtNI9+31SCTpvn5T9RocPIBVFWzKg9IxfZqDCh/4AjoyqjHGkWAbGTrgHwY2MBlY1YOYzrR5A1eluDIcXotvI7/ifh1VlLcCqLo4CRnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AMQAQzrS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B4lKKS019188;
	Thu, 11 Sep 2025 07:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yNqAtT
	/aliri3+dN8b0Rc4k4zSy8N4HZNRUjg2zdfqQ=; b=AMQAQzrSC1N+VfS3f+kSjo
	T9LIu2WMvN5tF9rXdXUWsFAztLDr2H4pYVnR/LS7DbkxrVHD3JpJJ2MAO+WkcK73
	9dCdDk82UctiS8MMkgaj7YH2MKcNErg/1WPT7CKOolnQbX2iIB93DheLscCcdC7d
	Bl2ch4VShQGtByY0ez79fjtUJWeRwonqZ0Xb9BUwqqz2rikOwJwyurmSGXvYRQil
	7pprLU7BJCvJ+Js8RRu4AJ6nDvHbv9o3r/SMZ+N+18lokZQ4ndHLC53s1zzEzGZ0
	Qmx/8LRP0uAciPOxKdXntXjrTNb4GuqBAliS5dnFhmsFBkVHmr/hRK08LoMUn2qQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct2dgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 07:20:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58B7JSMD020847;
	Thu, 11 Sep 2025 07:20:06 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct2dgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 07:20:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58B6wq1O001188;
	Thu, 11 Sep 2025 07:20:05 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 491203m9uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 07:20:05 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58B7K45E60293542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 07:20:04 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F149758D79;
	Thu, 11 Sep 2025 06:45:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EAB458D50;
	Thu, 11 Sep 2025 06:45:18 +0000 (GMT)
Received: from [9.98.110.226] (unknown [9.98.110.226])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 06:45:11 +0000 (GMT)
Message-ID: <8f0c39e3-af68-4f01-94e5-e63ee52864df@linux.ibm.com>
Date: Thu, 11 Sep 2025 12:15:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: fair: drop useless cpumask_empty() in
 find_energy_efficient_cpu()
To: Yury Norov <yury.norov@gmail.com>
References: <20250911023426.457745-1-yury.norov@gmail.com>
Content-Language: en-US
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250911023426.457745-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX5zPFdRRsVaJo
 Po7ABAhWLwofQwiJWZKqpKLYdTyZepwDaE/HD+lf19yUGP9lOTGUBx0hOc79jCqBM/BC5SDpLdY
 CFzPuqtDjlhWfh/U9sRhoKkOKmicVoDd0w6JJIrNr8y2Ihgovh0AfshDs2kWEq5piVgfFXkChJs
 5p0iymy2Oc49nhzbLGV2DHlfdHvkc5R4bvj3AcPx5a/VkTIB1of8fqG9sMnYOzW6kDIiFUyMKq+
 95p26eWRcGLdhg0JOUNnxCZcIdc7BpT1iZ6tTTTqIhSg33bQI7yFC8H63K21NSsax3vuRkfwsGO
 RQEbxMrAgH2q+51dfV2U4mgXV2DBUB914hNONxTb/RyOVd3/+80TKXHqPjlKPDHb+uaLECnHOoa
 K0pDaduD
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c27826 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=6Bb8fD9tztjf4PytmToA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3F6g7Uqw7JqiW9Dq09P6Liu43JzwoHXG
X-Proofpoint-ORIG-GUID: GtCv1V-k3dSnSIgAtiOdzGH-UJb2c802
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

On 11/09/25 08:04, Yury Norov wrote:
> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> cpumask_empty() call is O(N) and useless, because the previous
> cpumask_and() returns false for empty 'cpus'.
> 

LGTM

Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks,
Madadi Vineeth Reddy

> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  kernel/sched/fair.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..7229339cbb1b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8320,9 +8320,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  		int max_spare_cap_cpu = -1;
>  		int fits, max_fits = -1;
>  
> -		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> -
> -		if (cpumask_empty(cpus))
> +		if (!cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask))
>  			continue;
>  
>  		/* Account external pressure for the energy estimation */


