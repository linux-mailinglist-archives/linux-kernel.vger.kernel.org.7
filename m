Return-Path: <linux-kernel+bounces-882543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A5CC2AB20
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508493B4676
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35D51EDA0B;
	Mon,  3 Nov 2025 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="siRz0tRa"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4203208
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762161358; cv=none; b=NGoQYPWI6HbcdwS359MNfHD9XV84ukzQwbRuGj4pRJpj9t6hNWPQqqELdMF4DUXVyDPP+ymFJ5QomyiMI1csOSnk+BUXnJ3T4upqSg1mtHHg64RrmIyvWW9sWdTLptBYMoMWyyX9Tg7gM+6wDxd2kbVcMhl/JZbxA9qyGvHxtvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762161358; c=relaxed/simple;
	bh=685DokDbKVi5A9akrM2R7fQvzLMl2JgiVYmKNFaRhEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzJwiF93Ox8r7xObM4CXQwjs4fRbvE7CLOs+wjoQM/NRftpMv8nb8zfJ5kbKENzE30aQMZuugEQGYoK79sJhIsXRN+NXx6wyhb1V5UdjO/HCSXT6NEXaJV3Wqt99kpQpogLFCjhiKac+gSPb8emShUszrNwZ5aGCUKQ88zMMGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=siRz0tRa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A30Qggn027369;
	Mon, 3 Nov 2025 09:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IGfJOu
	MppmEJDM0TNxP6JanuVkIXzTemvhEsk+EXxaM=; b=siRz0tRaZTYlut6EX5BN/d
	KR1sVrdX2xFzTcYEc4uazjWR+1/xqbSOY77Vn0RQSo3u1jzd8sU8aw/Y+uf2aMiM
	4LpFceN5+VeMGVYwuwpcdbhizLE5fat3SO4IrE7wxTFfE5kr7A9Y6VjEUPkInP6W
	NWN6nMpg8uF/aHnRRA2tJwJr69ugbNNjEAoZ26OGiQDtvXNhlKaqIZ9s9VVuU9lo
	EVlEKSIUqQZZAQcNITF3P3+IYUxjlIMp94jtY7PnnzDKjNemF0j6NfFXo/FV5vmQ
	jju/YhdMuGrSvkGlOe4RtCRXXXMWEfzlZI8GC6yoEl3Oy2v8KiSlIhQ4NH1SFCdw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mqwxqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 09:15:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A39CX23018240;
	Mon, 3 Nov 2025 09:15:39 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mqwxqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 09:15:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A37cLbK019320;
	Mon, 3 Nov 2025 09:15:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whn4u1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 09:15:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A39Fa8H14352736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 09:15:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63E5D20040;
	Mon,  3 Nov 2025 09:15:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 356842004B;
	Mon,  3 Nov 2025 09:15:34 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Nov 2025 09:15:34 +0000 (GMT)
Message-ID: <88d397b7-5eeb-41eb-ba44-980e72008fd2@linux.ibm.com>
Date: Mon, 3 Nov 2025 14:45:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 07/20] cpumask: Introduce cpumask_weighted_or()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Gabriele Monaco <gmonaco@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
        Yury Norov <yury.norov@gmail.com>, LKML <linux-kernel@vger.kernel.org>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.717519165@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20251029124515.717519165@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DMk4TjsduBlVyap8Qif1dmDDHU5Ud9Ei
X-Authority-Analysis: v=2.4 cv=MKhtWcZl c=1 sm=1 tr=0 ts=690872bb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=D39tS0oWZMlAqelJh7kA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: LrhsVmsT67uIWJ0wXQ9Robv3PN6E3fRk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwMSBTYWx0ZWRfXymqAUeVCxO7M
 0FdO8rQBb52M74VLqKRkqjENXOpHuYcDb0SQSvW8JyB5zZKgTL+VkxSoX/C9g+5+7fKdPZ5hUtT
 yAVT75Fo+dKKLcriaeyRn7i9BPhBfJMiLDvkgK3Mmx2yEckAENAw8Wtaak+DvMPrqQHhfj0Jhvh
 G9xeOHgK+humaq4czblP1O+2YEPZjL+ENqoipdglBSqop0TgxtvyvHY5KVa5HY9sXUupmm3P6Kn
 S5DRrLaAiWj+bXh+zSpGEcjxqDiwtXXUTHd5sMsX9GzTqe4Ypo/h8qpCcYALvM3GHByTdXWITXz
 eJrmzBRVAv6hbSc3REYpqAoIF5Stqi/ZNtHQtwWf/CClsTmL67Z7imQSO6mxAlAqj2FsTQjbNL2
 LztTsDvFTLvQ+xrkObJUjIQv+8W1KA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010001



On 10/29/25 6:39 PM, Thomas Gleixner wrote:
> CID management OR's two cpumasks and then calculates the weight on the
> result. That's inefficient as that has to walk the same stuff twice. As
> this is done with runqueue lock held, there is a real benefit of speeding
> this up. Depending on the system this results in 10-20% less cycles spent
> with runqueue lock held for a 4K cpumask.
> 
> Provide cpumask_weighted_or() and the corresponding bitmap functions which
> return the weight of the OR result right away.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
> V3: Rename again - Yury
> V2: Rename and use the BITMAP_WEIGHT() macro - Yury
> ---
>   include/linux/bitmap.h  |   15 +++++++++++++++
>   include/linux/cpumask.h |   16 ++++++++++++++++
>   lib/bitmap.c            |    6 ++++++
>   3 files changed, 37 insertions(+)
> 
   
>   /**
> + * cpumask_weighted_or - *dstp = *src1p | *src2p and return the weight of the result
> + * @dstp: the cpumask result
> + * @src1p: the first input
> + * @src2p: the second input
> + *
> + * Return: The number of bits set in the resulting cpumask @dstp
> + */
> +static __always_inline
> +unsigned int cpumask_weighted_or(struct cpumask *dstp, const struct cpumask *src1p,
> +				 const struct cpumask *src2p)
> +{
> +	return bitmap_weighted_or(cpumask_bits(dstp), cpumask_bits(src1p),
> +				  cpumask_bits(src2p), small_cpumask_bits);
> +}

nit:

We have currently cpumask_weight_and & variants.
Wouldn't it be better to name it cpumask_weight_or ?

