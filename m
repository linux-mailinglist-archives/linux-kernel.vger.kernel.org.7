Return-Path: <linux-kernel+bounces-678768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A31AD2DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 08:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFCE18926A7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 06:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA621279333;
	Tue, 10 Jun 2025 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gdOBdhk/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601225E801
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749536585; cv=none; b=MYtGTP8xUgWbM6uGiZPQ7PIWf9GJJ3+mBTJPorRt067oh7fZNLAykVpumCq9iWm3jNYmGBz31NqwTW5V7zVj58K3IN99SJXCbg07A46CEwfPaXQdpvIvkErcsRFzXmIu7GuEFnPe2t/AeQyQ4SCCJbt5GW3sxA2tc+84fIe5cPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749536585; c=relaxed/simple;
	bh=z06hXIBzReKWh4a6IUEFpvl7a4XZ4UazqCXQ0e6YMek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acqE/p8PbRJblyWoEnvqEKg2C8CLyWyLwn1szXtjtsBnQ6yP9A7y4ZGOyV62W3CTGJhllOG+EFj+KKtejkaXTQ4fvSmmORYbxmQAkHrjNwxVqRuOUxpPvk9+KH6S+uGt8O1jS2yRKAQrcxjtZdR/jZ2olmgd4lQJl/ZhCYQnsbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gdOBdhk/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A09xC3000783;
	Tue, 10 Jun 2025 06:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XP208G
	XL2PeCWloqg8m6xDqEyY7/H1aJmFJcFYLwapA=; b=gdOBdhk/RbHxpd+w9Na6Lw
	aHVZNMb6L1pzm90wQFOVCu6PLX1TcBtBc7b8ie51W51/Jv/IIuXHhjhO5k6CH5/t
	4Z3gpH/WVOa8T4OV3J4DcOjUX0MijTTeYymUuPRHgf0foPoPW8RMVZcUnkzPgT4f
	0OO2fqOmKU98ddXmyISFgpQlxHAvi6y/8k5JYo8Ogg8zJQZ/GX9e8H/uOKCg4/Ly
	udXOkNWtlg1FRMaLoGPaV8UedKG/i8ND52oN0q0pslN0VV0y4+p1xPPtH8yWGuHr
	jxKVkGwaQopJe2yfcIF0WggD3/pQ0UFHiZNvEaYAnRusaSOgylUdE9BnXvpizIdw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769wyh5y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 06:22:48 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55A67m3T014056;
	Tue, 10 Jun 2025 06:22:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769wyh5y2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 06:22:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55A3EWrM015191;
	Tue, 10 Jun 2025 06:22:47 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrt9af8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 06:22:47 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55A6MkUt11534872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 06:22:46 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B22758059;
	Tue, 10 Jun 2025 06:22:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5434A58043;
	Tue, 10 Jun 2025 06:22:41 +0000 (GMT)
Received: from [9.43.59.164] (unknown [9.43.59.164])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Jun 2025 06:22:40 +0000 (GMT)
Message-ID: <5b103f2a-8d32-4f77-8e81-73680ceaf52e@linux.ibm.com>
Date: Tue, 10 Jun 2025 11:52:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/vdso: Fix build of VDSO32 with pcrel
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1fa3453f07d42a50a70114da9905bf7b73304fca.1747073669.git.christophe.leroy@csgroup.eu>
 <8dceee14-6008-48d0-a3c8-30ae777660a1@csgroup.eu>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <8dceee14-6008-48d0-a3c8-30ae777660a1@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pE9kUb4q8g_0ovTPiyUdq032bGXVcVdf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA0NiBTYWx0ZWRfX1PqYEWEdmzvD mZerRvFrpp//VvKuJ98wH/ssdyalhi6Pue+oZhDaIHZgtwUK43UsS6bD7llcFB93g+Dynil9Yg+ f/XGgk5UnIgcmLeK0s7Qf0MSFiEtQQ/AkeOZ1+wqbhkuR6zXbgKD01Pzze1I0sgQYtxml9kmtYz
 HcuDPNzx3CLNEnILfbqxvnvSUazfQ79MzxmurviYQ1dSp6I06uuNaY/2JYyhKGqpOPKN1ooiwGN htukYwc8+dCQYWy+aR1ooA21jvLaiiQbbt4YF65fvgFu0pWK+kfDx81i6sERpQaIGIYOVB0TsZE HAgnuRPrsoXnszNj0g9PuH4wChQ0tkUaT4jxkDHVSc6csTeqZaT+15bGbfIzcYlcl8s9btQziv+
 90jwfCzU0/cbrZR45jyCFhDMRXtvlg1h0dP6XAMG/cS69Mg3iHXaeQAGf7k783+qGqinF481
X-Authority-Analysis: v=2.4 cv=YKGfyQGx c=1 sm=1 tr=0 ts=6847cf38 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=1UX6Do5GAAAA:8 a=U2Z_qZhADA7zUz1wkAIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-GUID: NbnXFPJ0HV5kMqvvyPaDAtfufLdzBvqk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_02,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=760
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100046



On 6/10/25 11:33 AM, Christophe Leroy wrote:
> Hi Maddy,
> 
> ping ?

Yes, its not lost :) . Will add it for the next fixes PR.

Maddy

> 
> Christophe
> 
> Le 12/05/2025 à 20:14, Christophe Leroy a écrit :
>> Building vdso32 on power10 with pcrel leads to following errors:
>>
>>       VDSO32A arch/powerpc/kernel/vdso/gettimeofday-32.o
>>     arch/powerpc/kernel/vdso/gettimeofday.S: Assembler messages:
>>     arch/powerpc/kernel/vdso/gettimeofday.S:40: Error: syntax error; found `@', expected `,'
>>     arch/powerpc/kernel/vdso/gettimeofday.S:71:  Info: macro invoked from here
>>     arch/powerpc/kernel/vdso/gettimeofday.S:40: Error: junk at end of line: `@notoc'
>>     arch/powerpc/kernel/vdso/gettimeofday.S:71:  Info: macro invoked from here
>>      ...
>>     make[2]: *** [arch/powerpc/kernel/vdso/Makefile:85: arch/powerpc/kernel/vdso/gettimeofday-32.o] Error 1
>>     make[1]: *** [arch/powerpc/Makefile:388: vdso_prepare] Error 2
>>
>> Once the above is fixed, the following happens:
>>
>>       VDSO32C arch/powerpc/kernel/vdso/vgettimeofday-32.o
>>     cc1: error: '-mpcrel' requires '-mcmodel=medium'
>>     make[2]: *** [arch/powerpc/kernel/vdso/Makefile:89: arch/powerpc/kernel/vdso/vgettimeofday-32.o] Error 1
>>     make[1]: *** [arch/powerpc/Makefile:388: vdso_prepare] Error 2
>>     make: *** [Makefile:251: __sub-make] Error 2
>>
>> Make sure pcrel version of CFUNC() macro is used only for powerpc64
>> builds and remove -mpcrel for powerpc32 builds.
>>
>> Fixes: 7e3a68be42e1 ("powerpc/64: vmlinux support building with PCREL addresing")
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/include/asm/ppc_asm.h | 2 +-
>>   arch/powerpc/kernel/vdso/Makefile  | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
>> index 02897f4b0dbf..b891910fce8a 100644
>> --- a/arch/powerpc/include/asm/ppc_asm.h
>> +++ b/arch/powerpc/include/asm/ppc_asm.h
>> @@ -183,7 +183,7 @@
>>   /*
>>    * Used to name C functions called from asm
>>    */
>> -#ifdef CONFIG_PPC_KERNEL_PCREL
>> +#if defined(__powerpc64__) && defined(CONFIG_PPC_KERNEL_PCREL)
>>   #define CFUNC(name) name@notoc
>>   #else
>>   #define CFUNC(name) name
>> diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
>> index e8824f933326..8834dfe9d727 100644
>> --- a/arch/powerpc/kernel/vdso/Makefile
>> +++ b/arch/powerpc/kernel/vdso/Makefile
>> @@ -53,7 +53,7 @@ ldflags-$(CONFIG_LD_ORPHAN_WARN) += -Wl,--orphan-handling=$(CONFIG_LD_ORPHAN_WAR
>>   ldflags-y += $(filter-out $(CC_AUTO_VAR_INIT_ZERO_ENABLER) $(CC_FLAGS_FTRACE) -Wa$(comma)%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
>>     CC32FLAGS := -m32
>> -CC32FLAGSREMOVE := -mcmodel=medium -mabi=elfv1 -mabi=elfv2 -mcall-aixdesc
>> +CC32FLAGSREMOVE := -mcmodel=medium -mabi=elfv1 -mabi=elfv2 -mcall-aixdesc -mpcrel
>>   ifdef CONFIG_CC_IS_CLANG
>>   # This flag is supported by clang for 64-bit but not 32-bit so it will cause
>>   # an unused command line flag warning for this file.
> 


