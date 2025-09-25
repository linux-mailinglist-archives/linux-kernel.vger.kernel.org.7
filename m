Return-Path: <linux-kernel+bounces-831857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46832B9DB61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EFD27B89AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FFC2E8DE5;
	Thu, 25 Sep 2025 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JzbFUOC+"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C052135D7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782183; cv=none; b=RCWYzmNzSD1XZ2PJcp4z7roPR7YJhIFVc2pHWC2M7ahk1q/DERla4rXu2QW9Py+btMjSjS2tg/6KrtoCRXQmwOpxV5IVnPQxDteVBcOLdl+8xY9Kx2nxCLw4nUwVTzfM473K9uOE2TmPDSiWIREqIrjNmQkOz8sNVFtkB/FVmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782183; c=relaxed/simple;
	bh=nK0f0l4IwC1ohqc8dGCnpD/kbqXVTgvJ2Pb1h2QdDAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAy2I2oeyKLCPeGUl/Yrai6MGnoHGl/qBgk2IR4RRJump7CYA77hEEyRl1ZEIFuYOEzZLCHgdIJPc3pZyDSCnSKkeQ5WbxPIFU3l5Yhm946/F8hGs9sWY4FesuAyEJXSNIdpCUM8mRhkDlrEL72w4My06+Sfdz/YrcCSjyJ6n+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JzbFUOC+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OKYYot018175;
	Thu, 25 Sep 2025 06:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2S6MaB
	7nVL4UCP9ik7xvk1O28ZhC19tvGhC/+eMmG4Q=; b=JzbFUOC+guZrIGmqB0mzjg
	TnMwh6nTEw39kyG1sw+SwvA4KmcXwGif+xd8woJAD6UrID5PYuatGFExl0YhQOlN
	u46th+LKN5i67Tej3csAEmQHSt9VKqNGeppbEeY3xnP3oUvd0YTmM+J2vPwB/0oc
	o/KB33xUW17MHjMueeo7FNbiNLLvddDHhsSegmAqL/kHs0xVlnqQzgFT4aN0FTFQ
	vtrdMqXwUWyX2cFUKNPPJ/6V4MeUrMl2z7L6VXcCLnUpuaLco6mGXfoCPUkLk2Hh
	9NxHPVfP99h0oURZlV58A5+mSTt1Cgmi61X5zRHiQ7i5kyVTdnVR13W6hRMTVoMw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksc4216-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 06:35:55 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58P6XBCW029847;
	Thu, 25 Sep 2025 06:35:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksc4212-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 06:35:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58P567vp008294;
	Thu, 25 Sep 2025 06:35:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a6yy4kft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 06:35:53 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58P6ZqhG30474860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 06:35:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53DF35805D;
	Thu, 25 Sep 2025 06:35:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E006658058;
	Thu, 25 Sep 2025 06:35:46 +0000 (GMT)
Received: from [9.98.110.226] (unknown [9.98.110.226])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Sep 2025 06:35:46 +0000 (GMT)
Message-ID: <6e771747-ba73-4a6a-9982-05fea69136a4@linux.ibm.com>
Date: Thu, 25 Sep 2025 12:05:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/fair: Fix cookie check on __select_idle_cpu()
To: K Prateek Nayak <kprateek.nayak@amd.com>,
        Fernand Sieber <sieberf@amazon.com>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        dwmw@amazon.co.uk, jschoenh@amazon.de, liuyuxua@amazon.com,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <cover.1758543008.git.sieberf@amazon.com>
 <64ca6d7f73625cc63fa0bc1800c9b199462a5ef3.1758543008.git.sieberf@amazon.com>
 <f341531d-d65d-4063-9b0c-8d47b49864db@amd.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <f341531d-d65d-4063-9b0c-8d47b49864db@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RKPjozDb9upbOzdHW8dZjLNWmuoqcNy_
X-Proofpoint-GUID: OCbkLqvSNhR-pFOrBxFNc99U8UPdFYk-
X-Authority-Analysis: v=2.4 cv=SdH3duRu c=1 sm=1 tr=0 ts=68d4e2cb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=ZRAjJvf221xVuUItBfsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX6MDBmJmvTH+j
 c69kLq06vkVn48U8xZZeMeBjyzQDNK1Erw7K70ImS0Y8J73vOAwCSfG92DjajRs0zzH/bQJT9s2
 F8K8eh/w3FUoqKm4i/qOMvGGiXJfkCrX8KRC7ABcM3pJZLi7wrDNtWdgU21FMCUZz/gPicdWs5m
 ZcAiin037hSCWKFEdR52NvLzLn5TB99gTOaLgK5gimjcN8k59dVkk4xlqz3J3N79Ly15XR5c/Cw
 pr7HrbUjmy7dCbJQqzv71vIFGYOB+BiNvsq3Iw0X1OKX59yD/DRUqDHl9jSM8MW4lc0EdRe4a4S
 F/gXDjL35zojIpppxtjnyMwPu/LWIJm/OrHhgvj+0+TPgKZTJFar64Zb9Ca+MoBLXDOvawGao82
 zRDlTqKq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020

Hi Prateek,

On 23/09/25 14:12, K Prateek Nayak wrote:
> Hello Fernand,
> 
> On 9/22/2025 6:09 PM, Fernand Sieber wrote:
>> @@ -7447,7 +7447,7 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
>>  static inline int __select_idle_cpu(int cpu, struct task_struct *p)
>>  {
>>  	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
>> -	    sched_cpu_cookie_match(cpu_rq(cpu), p))
>> +	    sched_core_cookie_match(cpu_rq(cpu), p))
> 
> __select_idle_cpu() is only called when "has_idle_core" is false which
> means it is highly unlikely we'll find an idle core. In such cases, just
> matching the cookie should be sufficient right?

Agreed. The only code path I could find where __select_idle_cpu() is called
with has_idle_core == true is in the non-CONFIG_SCHED_SMT case, which is not
relevant to core scheduling.

Thanks,
Madadi Vineeth Reddy

> 
> Do you have any benchmark numbers which shows a large difference with
> these changes?
> 
>>  		return cpu;
>>  
>>  	return -1;
>> @@ -7546,6 +7546,9 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
>>  {
>>  	int cpu;
>>  
>> +	if (!sched_core_cookie_match(cpu_rq(target), p))
>> +		return -1;
>> +
> 
> select_idle_smt() is again called when "has_idle_core" is false and
> sched_cpu_cookie_match() should be sufficient for most part here too.
> 
>>  	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
>>  		if (cpu == target)
>>  			continue;
> 


