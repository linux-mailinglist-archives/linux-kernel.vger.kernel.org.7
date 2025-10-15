Return-Path: <linux-kernel+bounces-854841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6D9BDF8A4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2356B1A605DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ABC29A9C8;
	Wed, 15 Oct 2025 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DTMYRDGb"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9681186E40
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544303; cv=none; b=P1CZR0z/nCvz6JWOWCSKkkeWvqcWLkA0KyOQQM0idzZo5VMZeTAIZXnaUnFVTLridKm921eL2EqjBb4Fi5b1VkVZNsVEBiCjNUwVgOdZp8DgaxvDTLKo/NGqDHrr41O2uRiGq65IIhKwSMIPMf2wEPPVH56DeV4EH0ziDbnifGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544303; c=relaxed/simple;
	bh=16eBxg7txFfBsqUuajXpRFF59e1zCPC6RLyurv+78h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3qpe9ENFmqQ+pKHpELxQxNJTk2hMp7PHNHgkJrSxJ1oCZ428vb7txJzZAIa6J08HyqwCYmo9ZGaXK0stmKn6Uxi/5NJb1ZGgWogUqFkp1wDDJpV177dSz7spCN9fJhhg77SMna8FVEZn3s69YyvYiHm4/rz6qClXC8HRVh/3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DTMYRDGb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FDhs4b001980;
	Wed, 15 Oct 2025 16:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5opmQQ
	rcs+iQAYIWBtfey0J/RoSdwtl4mYe2y0r2Ztg=; b=DTMYRDGbbruCsK1hiGXePi
	NbuXJV52I8gbDdNY9W5EKuZLmSAQBDEHUcH2r6peMBVF2Oh/kCdqsMc6mxNJQeGk
	Aw/B6GpRKQu9tbPPJPJ5RcRbuXlQxkNIz3azQRk3KPsJdXHGfHlzxPt5XjgVOFvx
	BQ0/nhlzIIbQQbXnf7MtSdlfo00TmjjfcvDlThYf6U71fY5o3fDsIjTJh+vcOdIU
	dYavP4hNgCW5L+atWQrgXhGeac0cJhNwANNxfuvecdQnBk3x2YFd+dKpK2iMiVYX
	HZrFxNrwGZjChtL00YRH1UN34CxwbVQLSiBfOUaLpbw6E+d0LxTAOcF+Z6tH/v8Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp80e96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 16:02:30 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59FFxv93008767;
	Wed, 15 Oct 2025 16:02:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp80e90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 16:02:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59FDu6dv003626;
	Wed, 15 Oct 2025 16:02:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy1a38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 16:02:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59FG2Pc631261170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 16:02:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D48E200E6;
	Wed, 15 Oct 2025 16:02:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34465200DB;
	Wed, 15 Oct 2025 16:02:11 +0000 (GMT)
Received: from [9.124.218.242] (unknown [9.124.218.242])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Oct 2025 16:02:10 +0000 (GMT)
Message-ID: <9901f2e8-653e-42f4-9344-03b2f70846bb@linux.ibm.com>
Date: Wed, 15 Oct 2025 21:32:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/21] paravirt: Remove asm/paravirt_api_clock.h
To: Juergen Gross <jgross@suse.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
        Alexey Makhalov <alexey.makhalov@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Russell King
 <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux.dev,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org
References: <20251006074606.1266-1-jgross@suse.com>
 <20251006074606.1266-6-jgross@suse.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251006074606.1266-6-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9ZUK4UeNEA3M63-5xIUdjnNRJmI9KQSO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX90a/KFqHOFA4
 3LTXuANmdsGxWyQx7Ukevm3RyFSkQJ9pXc2oVr8K5uv/q7SJflj3vhk6rgQPg5a2e4JMHRcokhT
 E+w6CfzUtDgCzNqO7x7Qz0iPi2Udyp1mB5qOlV79KYdYo8wEkzexJTGI0NvxBMb9zp2anqktjy6
 x7dXmTESXxwuIWmKuQwlY9VJQdv5AweqVNhod++KR+c5UndqULhfyI4H+V7In+JTOm9GWN4E92e
 bZgooNZopePk7kVmv+pt2VQaWzIRRgwHx3+Ivefade+IPstSVao1M49g8pQuFBZku8ozOWBjVco
 XGxbdE4m67DWVP6wWkyIRV4aUp8gC4N6DdEGT4oMISQu4RWJ20yslN8ham/g8aBzCSTrxBcUSHp
 17smtvjqfZzcfkxRb2PzijiKsYbetw==
X-Proofpoint-GUID: dV8tQT4HDH7j4wsc4MFx6qXJyZuneU1L
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68efc596 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=VnNF1IyMAAAA:8 a=RR7mTWzPQ-4l2d7n_HwA:9
 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=DXsff8QfwkrTrK3sU8N1:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=bWyr8ysk75zN3GCy5bjg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084



On 10/6/25 1:15 PM, Juergen Gross wrote:
> All architectures supporting CONFIG_PARAVIRT share the same contents
> of asm/paravirt_api_clock.h:
> 
>    #include <asm/paravirt.h>
> 
> So remove all incarnations of asm/paravirt_api_clock.h and remove the
> only place where it is included, as there asm/paravirt.h is included
> anyway.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/arm/include/asm/paravirt_api_clock.h       | 1 -
>   arch/arm64/include/asm/paravirt_api_clock.h     | 1 -
>   arch/loongarch/include/asm/paravirt_api_clock.h | 1 -
>   arch/powerpc/include/asm/paravirt_api_clock.h   | 2 --
>   arch/riscv/include/asm/paravirt_api_clock.h     | 1 -
>   arch/x86/include/asm/paravirt_api_clock.h       | 1 -
>   kernel/sched/sched.h                            | 1 -
>   7 files changed, 8 deletions(-)
>   delete mode 100644 arch/arm/include/asm/paravirt_api_clock.h
>   delete mode 100644 arch/arm64/include/asm/paravirt_api_clock.h
>   delete mode 100644 arch/loongarch/include/asm/paravirt_api_clock.h
>   delete mode 100644 arch/powerpc/include/asm/paravirt_api_clock.h
>   delete mode 100644 arch/riscv/include/asm/paravirt_api_clock.h
>   delete mode 100644 arch/x86/include/asm/paravirt_api_clock.h
> 

For powerpc, scheduler bits

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

