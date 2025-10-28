Return-Path: <linux-kernel+bounces-874368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4734DC1623E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922DD1C25F49
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C6F34BA49;
	Tue, 28 Oct 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WzIwVWBA"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AAE34D927;
	Tue, 28 Oct 2025 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761672394; cv=none; b=hFaXCs3vvAmwB68bNGwdKQ0TGEeUM1zbrL/L6LYAL5UdWrWBpYBfK5sW6x6DYT9OZhMn65VxpV7iRD4ibqrJ74Djktd1vBIkNLFvWILHboErZmS+7b5umWT6gJaurTB8WsY0qGsWg4oIRvsTOtFRRQMDpjbL9U8e4b+5W6eN6zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761672394; c=relaxed/simple;
	bh=ahDvdYE446ZK3bHn+e1nbAEWl1n/58FEh6Wm8fpXpM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgGhKYs3cCfOFqklVnVgH7gH9VdKji2RhMmL7xITg8nc1C/U4GxG+nTalF2I9AEXocR05lpm4blOR1cfyBRgFrfs/4Jl8//yxyf9oEONpL27nSlZAk+D+hnKZaAiVqxIQQftmCYabISEQp8TQvTwDqKhdtolvWEwvPB2MS7cMxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WzIwVWBA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SDv0LX022264;
	Tue, 28 Oct 2025 17:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JzsMaB
	KmsLArqgMlPsIq1urBFGS39cUxRocFpruEJKo=; b=WzIwVWBAwQBqfOXTQqD6x8
	ypXNyJ8NvXdvi4PLvWBHsTfGhlykHmg76Umm7dgF//2D5uvwo6uFT6sidXenawNS
	zP/dbNj/QzeTJ1ivGTeLmZsRgtVJTiD/okJj47Kuq9Jc1puyk3awxvKL1it0B6bp
	Ko7qxSGYdnm0f8e4jcGE7cRjYJN1QvHcauZYRt3y3qMTuMdb/p0QOdXojzAOcrjy
	+UU3Nnv9zoUMLXMxVe8fMBnlUL6jCxAMxbpSx5VZltEce9eBcM8GM7u55Vwt9c1a
	yo6+y9PhZPd+fRaBVg+kNIy7pcjuMHKX9uNi7D8+ZUO655QZLywrrFCy9hdBPNPA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81ww1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 17:26:15 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59SHNKPP028435;
	Tue, 28 Oct 2025 17:26:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p81ww1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 17:26:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59SFKNdw030353;
	Tue, 28 Oct 2025 17:26:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a1acjv60b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 17:26:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59SHQ9uI31850948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 17:26:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6504E20040;
	Tue, 28 Oct 2025 17:26:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5402620043;
	Tue, 28 Oct 2025 17:26:06 +0000 (GMT)
Received: from [9.124.208.105] (unknown [9.124.208.105])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Oct 2025 17:26:06 +0000 (GMT)
Message-ID: <f19a9080-8d6d-492b-b5de-88f24ce5c015@linux.ibm.com>
Date: Tue, 28 Oct 2025 22:56:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc/kexec: Enable SMT before waking offline CPUs
To: "Nysal Jan K.A." <nysal@linux.ibm.com>
Cc: Srikar Dronamraju <srikar@linux.ibm.com>,
        Sachin P Bappalige <sachinpb@linux.ibm.com>, stable@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Thomas Gleixner
 <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20251025080512.85690-1-nysal@linux.ibm.com>
 <20251028105516.26258-1-nysal@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251028105516.26258-1-nysal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIQ0HJae c=1 sm=1 tr=0 ts=6900fcb7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=aw7bS6XWP1gv3QJPQkgA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: _8HLFSb0f4qF_K5MAkfBhu9h7SzxRH9c
X-Proofpoint-GUID: AsadqQZSaouQXzeKinTnshKpdWRv88pv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyNCBTYWx0ZWRfX0u/NDdWUZBBN
 tG1OTiJkqnN8A4ifMFFQasm6RTYT0Z5XJS80lD5k6M8gAbel86k84bTMIcLczHTqyW1v2PamGIB
 xUocTDAI2DfwTqnCEm5BCrl3M3VwVFGgn6T+Mfg98QW9dGBPobRKaBPef/i+F3fRXiw1KKLjVpN
 dN5NtM6b/+4odRdLEf3kgjd78auIxPbYBH11DbGG1VlkqxHaK/4Y4BKS4Enqs8TUjKpmGfJfQXS
 pt3JL1LcMZWYJBVluPYywgahHbe0sk2Iz2Cgl/ZzVoSPFdNKdMDxcvuIg4xP95fFtvkNnro8mrg
 Nz3eLGeVK1EqAtFayskYmEWM4h28ehvXM3yE9+/wvzXSxCL0rTaT0JL14a4N7fj5uNGBISjokaJ
 aBQBIlghpMZRImw3jqN7qj5UHRM6Sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250024

Hi Nysal.

On 10/28/25 4:25 PM, Nysal Jan K.A. wrote:
> If SMT is disabled or a partial SMT state is enabled, when a new kernel
> image is loaded for kexec, on reboot the following warning is observed:
> 
> kexec: Waking offline cpu 228.
> WARNING: CPU: 0 PID: 9062 at arch/powerpc/kexec/core_64.c:223 kexec_prepare_cpus+0x1b0/0x1bc
> [snip]
>   NIP kexec_prepare_cpus+0x1b0/0x1bc
>   LR  kexec_prepare_cpus+0x1a0/0x1bc
>   Call Trace:
>    kexec_prepare_cpus+0x1a0/0x1bc (unreliable)
>    default_machine_kexec+0x160/0x19c
>    machine_kexec+0x80/0x88
>    kernel_kexec+0xd0/0x118
>    __do_sys_reboot+0x210/0x2c4
>    system_call_exception+0x124/0x320
>    system_call_vectored_common+0x15c/0x2ec
> 
> This occurs as add_cpu() fails due to cpu_bootable() returning false for
> CPUs that fail the cpu_smt_thread_allowed() check or non primary
> threads if SMT is disabled.
> 
> Fix the issue by enabling SMT and resetting the number of SMT threads to
> the number of threads per core, before attempting to wake up all present
> CPUs.
> 
> Fixes: 38253464bc82 ("cpu/SMT: Create topology_smt_thread_allowed()")
> Reported-by: Sachin P Bappalige <sachinpb@linux.ibm.com>
> Cc: stable@vger.kernel.org # v6.6+
> Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>
> Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
> ---
>   arch/powerpc/kexec/core_64.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
> index 222aa326dace..825ab8a88f18 100644
> --- a/arch/powerpc/kexec/core_64.c
> +++ b/arch/powerpc/kexec/core_64.c
> @@ -202,6 +202,23 @@ static void kexec_prepare_cpus_wait(int wait_state)
>   	mb();
>   }
>   
> +
> +/*
> + * The add_cpu() call in wake_offline_cpus() can fail as cpu_bootable()
> + * returns false for CPUs that fail the cpu_smt_thread_allowed() check
> + * or non primary threads if SMT is disabled. Re-enable SMT and set the
> + * number of SMT threads to threads per core.
> + */
> +static void kexec_smt_reenable(void)
> +{
> +#if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
> +	lock_device_hotplug();

I was looking at usage of lock_device_hotplug, looks like a good candidate for
guard() use case. Could be done on its own patch/series.

> +	cpu_smt_num_threads = threads_per_core;
> +	cpu_smt_control = CPU_SMT_ENABLED;
> +	unlock_device_hotplug();
> +#endif
> +}


Will this work too? It might be better since we anyway going to bring that CPU up
by doing add_cpu afterwords.

	cpu_smt_num_threads = threads_per_core;
	cpuhp_smt_enable()

> +
>   /*
>    * We need to make sure each present CPU is online.  The next kernel will scan
>    * the device tree and assume primary threads are online and query secondary
> @@ -216,6 +233,8 @@ static void wake_offline_cpus(void)
>   {
>   	int cpu = 0;
>   
> +	kexec_smt_reenable();
> +

If we do above, just change the below logic to complain if any present CPU is offline.

>   	for_each_present_cpu(cpu) {
>   		if (!cpu_online(cpu)) {
>   			printk(KERN_INFO "kexec: Waking offline cpu %d.\n",


