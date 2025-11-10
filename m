Return-Path: <linux-kernel+bounces-893743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B28C483F2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BBA94ED2EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50302882B4;
	Mon, 10 Nov 2025 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gugj/G+U"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F9228314E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794206; cv=none; b=O35Oq4ZJdc0dJN/qQh5sioDKv60VsQxe1KRkPitz6rkKz34k2dVm+VzL+hmTqFYj7OUaFd83tXflTv0zCYgplCDZtxfQOyPJ4QQf2Cskd38vkPBF54wTxAEyc5Xfml5XwxlWDp1BrffFEI4Mg6qlnqPkMzRaUk7xTkTro2Nmojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794206; c=relaxed/simple;
	bh=9TZgG+B3GES0kSe6IW+/sBTdjHPJ//OONFQeer2/kTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pn2exXyF7TAgakpXQoaO7luEqRDYRjkt6A1EaiZnsAu7ZlSnmZBHf1mcEWIqq7FicYkumojT6li5qzpvlmseY00s2q8AN9YrrQKDVP1XKVKBnSpqoQ5ixP1vrOU+bub3/jV4IbLPDzSrtkyhe77CTWqcHgnZ8saP8cwK+aCULug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gugj/G+U; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AADeCNZ028678;
	Mon, 10 Nov 2025 17:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eyMgkQ
	Az6dS7bO5FbsUIEIAl+bd+EVxxpRwDcgLzq7o=; b=Gugj/G+U963wZ1+A0vqmwM
	pJwDgdvDc/BJ8o2RWU7tYdazB5IC2Q8j4HPLDbSzf1vAQ75CmecQv7QsrwbYOi1P
	/kNPSDSzGPAFTPqO6msD/4vw1B2XSJb7nGJ2F9K0zPyP3nzBxC2ZWbtQGl6Z1WtW
	wn3UYM64b9ZmQaPToK4KkXOVPXAUJ3rfvhQduqp1Tnoan/ZpvnUZBup+Kwj8G84K
	G/5ik8HYURMlqTiSjBSKwGZExKLca7cl9aM8jvpqbrSjIxJzjcCy73Qt84Gu9lyu
	0jJ1XY+jzSGQdRceFlN9ij9ZPQqsBjGEWJMrZLRSI7w7abke7LtldfQ2Ajdk5cPA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgwr9ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 17:02:57 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AAGtVmD015836;
	Mon, 10 Nov 2025 17:02:57 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgwr9h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 17:02:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGTZen014759;
	Mon, 10 Nov 2025 17:02:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpjxmyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 17:02:56 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AAH2pka58720762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 17:02:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17D6A20043;
	Mon, 10 Nov 2025 17:02:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 242AF20040;
	Mon, 10 Nov 2025 17:02:49 +0000 (GMT)
Received: from [9.124.210.118] (unknown [9.124.210.118])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 17:02:48 +0000 (GMT)
Message-ID: <53fd537b-5549-427f-ad7d-28d58daaa5bd@linux.ibm.com>
Date: Mon, 10 Nov 2025 22:32:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/smp: Expose die_id and die_cpumask
To: Srikar Dronamraju <srikar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20251028105734.1894998-1-srikar@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20251028105734.1894998-1-srikar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yLdmRwN_1XDHZT-_nq1UmgV_rjsezNAX
X-Proofpoint-ORIG-GUID: NOMlJ4g_SXKRAtFtr-oSaoY6o5BGSuSL
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=69121ac1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=XNNoshNgl4cG0apxiokA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfXy5G8w2FTlkBB
 rxFV9nPA06JStMZn6WJg8Z/kQarDfSyi7ixSLwq5ksuwxENpxf8YYeb16EeVTNeTv2GkRgUFXMO
 LKWf3wSDjY8+oE8R3YGKMJULeRcyCk2tNFLF+LLSQpeE3KFYEKen9TdgqDSITDDdJmix/niOCBj
 tjTN2bfIFecmgu85cfT3YKyZA7u0slnCNQPpraNQ3ZP7MS5Qx0WKeDdG6fjO9uHII/bCdayYsar
 t7+EJ0H1eYRJtgw2fabypiZRoJQxV4GfD8aS1i51ztwl6sg0nRetHgw15SRlBtrssH79X8i6R4C
 GCooVXrbl0ozDrqpS1k6aYnOb1PbLc2eOv7mU+SKBYwXewIL3V1lmq8zuzjXFemxe9dNm15jl+7
 NoemuTDM7GVf50p/p9FrpY2+Zu2NqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022



> 
> Without this change.
> $ grep . /sys/devices/system/cpu/cpu8/topology/{die*,package*} 2> /dev/null
> /sys/devices/system/cpu/cpu8/topology/package_cpus:0000,ffffff00
> /sys/devices/system/cpu/cpu8/topology/package_cpus_list:8-31
> 
> With this change.
> $ grep . /sys/devices/system/cpu/cpu8/topology/{die*,package*} 2> /dev/null
> /sys/devices/system/cpu/cpu8/topology/die_cpus:0000,0000ff00
> /sys/devices/system/cpu/cpu8/topology/die_cpus_list:8-15
> /sys/devices/system/cpu/cpu8/topology/die_id:4
> /sys/devices/system/cpu/cpu8/topology/package_cpus:0000,ffffff00
> /sys/devices/system/cpu/cpu8/topology/package_cpus_list:8-31
> 
> snipped lstopo-no-graphics o/p
> Group0 L#0
>    Package L#1
>      NUMANode L#1 (P#2 8135MB)
>      Die L#0 + Core L#1

Die L#0 -> Here L# indicates logical die number.
One should run --verbose  to see theactual die_id.

For example:
Die L#8 (P#25) --> die_id is 25.


Maybe you could the same CPU's (CPU8) info of lstopo here?


>        L3 L#2 (4096KB) + L2 L#2 (1024KB) + L1d L#2 (32KB) + L1i L#2 (48KB)
>          PU L#8 (P#8)

> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/topology.h |  4 ++++
>   arch/powerpc/kernel/smp.c           | 18 ++++++++++++++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index f19ca44512d1..c6ad1eb7e44a 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -132,6 +132,8 @@ static inline int cpu_to_coregroup_id(int cpu)
>   #include <asm/cputable.h>
>   
>   struct cpumask *cpu_coregroup_mask(int cpu);
> +const struct cpumask *cpu_die_mask(int cpu);
> +int cpu_die_id(int cpu);
>   
>   #ifdef CONFIG_PPC64
>   #include <asm/smp.h>
> @@ -141,6 +143,8 @@ struct cpumask *cpu_coregroup_mask(int cpu);
>   #define topology_sibling_cpumask(cpu)	(per_cpu(cpu_sibling_map, cpu))
>   #define topology_core_cpumask(cpu)	(per_cpu(cpu_core_map, cpu))
>   #define topology_core_id(cpu)		(cpu_to_core_id(cpu))
> +#define topology_die_id(cpu) (cpu_die_id(cpu))
> +#define topology_die_cpumask(cpu) (cpu_die_mask(cpu))
>   

nit:

can we fix the tab spacing here please? Maybe like below?

+#define topology_sibling_cpumask(cpu)          (per_cpu(cpu_sibling_map, cpu))
+#define topology_core_cpumask(cpu)             (per_cpu(cpu_core_map, cpu))
+#define topology_core_id(cpu)                  (cpu_to_core_id(cpu))
+#define topology_die_id(cpu)                   (cpu_die_id(cpu))
+#define topology_die_cpumask(cpu)              (cpu_die_mask(cpu))

>   #endif
>   #endif
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 68edb66c2964..a0b0b46b78e3 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1085,6 +1085,24 @@ static int __init init_big_cores(void)
>   	return 0;
>   }
>

As you have mentioned in the changelog, could you add a comment here
explaining on which systems we see this information correctly.   
> +const struct cpumask *cpu_die_mask(int cpu)
> +{
> +	if (has_coregroup_support())
> +		return per_cpu(cpu_coregroup_map, cpu);
> +	else
> +		return cpu_node_mask(cpu);
> +}
> +EXPORT_SYMBOL_GPL(cpu_die_mask);
> +
> +int cpu_die_id(int cpu)
> +{
> +	if (has_coregroup_support())
> +		return cpu_to_coregroup_id(cpu);
> +	else
> +		return -1;
> +}
> +EXPORT_SYMBOL_GPL(cpu_die_id);
> +
>   void __init smp_prepare_cpus(unsigned int max_cpus)
>   {
>   	unsigned int cpu, num_threads;


Other than above:

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

