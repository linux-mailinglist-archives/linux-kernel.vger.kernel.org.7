Return-Path: <linux-kernel+bounces-812311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFC3B53610
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EB7188A4EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621BF3431E4;
	Thu, 11 Sep 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NouSvw2Q"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2AF31AF25
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601878; cv=none; b=QH3Im0e7tU2ApoOTI1pxTHNbuXfOIG51OxTUhnvS/qhm5pRz0QnxtbhO47ATTCLRmmENl/Xfd0C0PvCKsTEADBjY0fMUWxwHHVfiCWpB5co1HA70NmYXXocVav0iq5zp0vxXPvSXaf+pCO3B3PaSQqBtp4bic+DPwt/okcIog+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601878; c=relaxed/simple;
	bh=h2fQbST/W9MWWMJDPIPk+YR1f3ZTlwqHb5tyL8Oosmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVO5C8hnD/RfG8k0Ektw9nAWzcyYzCt2NX01gt/FODtwWn8FpCEUvxlvQt4XzgHj1HiNzw4+/E2VYlZ84k1nBOdnGynmx2ZhgGqYZICn+nBZbMXNU1XscZ8tgMLDnX6dlsWle7Hm3H8orVyLprWtOLXoUetkUHlE8kw7hfHtEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NouSvw2Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BA1aGq013271;
	Thu, 11 Sep 2025 14:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A300un
	dj5JOdmDlmkCy6sIqnoWKox9OnCXUJSWKyxoE=; b=NouSvw2QNnkeTHsrI5jAJw
	89dk4CCXz90GZRSdqeVFQCFqwUpVdbjrWwVN+6Dq9L+Nm/1B/OOBBFyFeWrrHvUv
	ufW5IzZIlPgW7HQTXTD5QR5VVzskKUr00TBgR09+BwUcSYUiROTi5f7Y5aDQLj1a
	OEs6y+J1BFINkGG6EV3+Q/PvMcLD8fcjR+3BnUy/O4ZR6pWgLOirpHA3aquOzcz3
	g5qdrNiwgJceHg8+Cb3zJaOhK1PuLY4K7mMOicI1BMEdpB+qWeHJkAWxM5qMo7mo
	zJgFQSJbAmY0mUlJQm2uvUXN1IyM1hi9qI+7tdmak0A0gzi870xoO99chx13RwoA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyda5mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 14:44:18 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BETAKo010487;
	Thu, 11 Sep 2025 14:44:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyda5m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 14:44:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BCumPp020495;
	Thu, 11 Sep 2025 14:44:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp16evb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 14:44:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BEiAKV53215604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:44:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF5CC20040;
	Thu, 11 Sep 2025 14:44:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11E5120043;
	Thu, 11 Sep 2025 14:44:02 +0000 (GMT)
Received: from [9.61.95.215] (unknown [9.61.95.215])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 14:44:01 +0000 (GMT)
Message-ID: <c9ab1c85-f868-4a4a-ada9-58df502ffe3d@linux.ibm.com>
Date: Thu, 11 Sep 2025 20:14:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 04/10] sched/core: Dont allow to use CPU marked as
 paravirt
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: vschneid@redhat.com, iii@linux.ibm.com, huschle@linux.ibm.com,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, vineeth@bitbyteword.org,
        jgross@suse.com, pbonzini@redhat.com, seanjc@google.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org
References: <20250910174210.1969750-1-sshegde@linux.ibm.com>
 <20250910174210.1969750-5-sshegde@linux.ibm.com>
 <d5605402-b37a-411a-aabc-842b5a924dbe@amd.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <d5605402-b37a-411a-aabc-842b5a924dbe@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SkhAT8dwWp3xYdrSKglBLTnRj3rEx9CF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX0WPEwdPIlM/h
 3C8gF6nm0Xt2OivrMr40D+CwrQoEKG3xQ679XIspDjcalc79FIPMR7Fl6NuVT6dKEVpndRPbrvk
 L573ASuh+rwL50MVCHjVqiqNfQ6gmyXwRU/5hy7RjKU57KUKdM2RuqoRyqCALHrzgpfPMoZDEFV
 vnEdFYRtA/hg7UCOphkSNvG+ob94oT19Uz/Vxsdgw/r3+18izq8P2Y3LFcbhmVN7QVhJHCizEhX
 +gtq9h197gXtKiPFJqsNIZe2wxbfELY0iW+CGyPEZYugwJvZVMeaGQp2FYrswwwMLK8UKQGMOEZ
 0x9GJdtPwgslDbLQfaCClnyZw3T41FI5nOFDdPtt7rPox4I6HTP7v2V/hzu75ENi3z0b1gnBpnr
 8DXK0Uc4
X-Proofpoint-GUID: 5WcYnnhw3T4zSrOOSNGH9LPLvv8uTT_t
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c2e042 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=uXBPIk7YWzXHA4pK:21 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=Bjl5kDSpjRqkKk4bOxUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235



On 9/11/25 10:46 AM, K Prateek Nayak wrote:
> Hello Shrikanth,
> 

Hi Prateek, Thanks for looking into this.

> On 9/10/2025 11:12 PM, Shrikanth Hegde wrote:
>> @@ -2462,8 +2462,13 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
>>   		return cpu_online(cpu);
>>   
>>   	/* Non kernel threads are not allowed during either online or offline. */
>> -	if (!(p->flags & PF_KTHREAD))
>> -		return cpu_active(cpu);
>> +	if (!(p->flags & PF_KTHREAD)) {
>> +		/* A user thread shouldn't be allowed on a paravirt cpu */
>> +		if (is_cpu_paravirt(cpu))
>> +			return false;
>> +		else
> 
> nit. redundant "else". I think this can be simplified as:
>

alright.
>      return !is_cpu_paravirt(cpu) && cpu_active(cpu);
> 
>> +			return cpu_active(cpu);
>> +	}
> 


