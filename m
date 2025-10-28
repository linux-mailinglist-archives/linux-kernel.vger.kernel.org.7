Return-Path: <linux-kernel+bounces-873320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EA5C13AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EB81507CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877972DA777;
	Tue, 28 Oct 2025 08:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aA6w5lnE"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01762DA753
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641955; cv=none; b=PbYY+0RaBQv0E2H8Fpa+0DO3ojhQRjrd1RTVeB+tVktgz6y8m0KMeuT0CF3npGATiAJQkcZTTrbErsY0qsK93oymy4Rl7zDJGjGC8kpU5Ia571PNi2icHaPCkNKndNFqZ0co5qmvaIPh/4x9HTz/wOWyrzfJkQH0r62F7l7olJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641955; c=relaxed/simple;
	bh=7eCITXJrFJeNxE3hvEvq9CByeezBo0u6uoO0UjH1gBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7zGJ5APWSAEiuGb98Yqx0LRmZHHY4dIVjEiImwhGy9wMUajl5FD3sr00BYjjwt2ATAe8IqOjFoiFrEDWVTJvSFKC3IlxHuBl0QSwa8cNAhkoF6kEja1aC7gMyz+T9yIYYPsZu+OnkeXpAzt9yiNeu42tr6T9JQ0PXHhYAzuAOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aA6w5lnE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RMwDcs004594;
	Tue, 28 Oct 2025 08:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=afx5Qp
	TACU5XWpfNgC8G7fvB4kwF9GyLx1ba6EDNXCI=; b=aA6w5lnE7omoyhzECluvPc
	VKVNfybxFtogropoR58eQRpuoXrGPYL1nkDHh3DmeMKM5FxKaag8WFleKxC7IItF
	JxYMMOLwCNTFD/El1QNG7pN0huL7lk5JuoiTSAv47FRG6h3iyfPMqNV9PImv3LzV
	+4BK7RAvRcljKltwMBdp8MJtLfTrM35E7gxhjDPfoDWPa6GgltpdcQOXouuPLiqd
	Xk1n2EpaKVajHi8micP4qBLbfPVCkz2qiCg9A3h3jTnbaU0DuGE4/0b7wFd/ZzEJ
	jEvJM0GZE2Us6gUVXC7HlnRia7GHyz8PV9mRhz9ZXK0PmK1M75ncJU9B2DWFRUvQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p992w2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 08:58:55 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59S8rnr9005602;
	Tue, 28 Oct 2025 08:58:54 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p992w2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 08:58:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S8qHaK009424;
	Tue, 28 Oct 2025 08:58:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1b3j1nn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 08:58:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59S8wqLK43844014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 08:58:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4086720043;
	Tue, 28 Oct 2025 08:58:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2969C20040;
	Tue, 28 Oct 2025 08:58:50 +0000 (GMT)
Received: from [9.98.111.108] (unknown [9.98.111.108])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Oct 2025 08:58:49 +0000 (GMT)
Message-ID: <14872f86-43d4-42af-b3c0-233d220757ba@linux.ibm.com>
Date: Tue, 28 Oct 2025 14:28:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/vmlinux.lds: Drop .interp description
To: Vishal Chourasia <vishalc@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20251018-ppc-fix-lld-interp-v1-1-a083de6dccc9@kernel.org>
 <aPdBpqhm3JHvKIWJ@linux.ibm.com> <aP8jT3XY3kQUCwFQ@linux.ibm.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <aP8jT3XY3kQUCwFQ@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=690085cf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CCpqsmhAAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ZHSnkM3jP7rn7XZgXOwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ul9cdbp4aOFLsgKbc677:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: JhZA-HjLs4FesaqE-SdsyT7TJQidPFYA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfX+e5rNKalrEtu
 sstqnuW7/EWyOgklSY5o+3DCvntg0HMNPUXxaHc5tGpvDPze7NkZ9E3q4zZzFhHRvdD8dsBHlTb
 bzI6w6JK9rTF9fPaNMGkJZ+NXHqM6xQnUlo4EK3eR8QkhtBr0V4qYPHJIGEFgi7PAKJwie6V7Ig
 RacVWAnwtHNUl9bgFMqmXCMsdpBfDcLmg1fSwDBLMHorqmglajh35XRH+gGJAz91FfMP0hkuGvq
 TbqEWsl0BFrrlw6a8HJjHXPG52R/6HRD5oXLkNHo+2ITSViKmXI5uPP7TjkaXkILMx9Xx7/XOmT
 4b+BuKuUNCXH3hNACAjhXBMJ3jV2FtVePhoRbj3E/0gvQS1QPlcKEyj3SdIoxTwhw6bcNjLPa10
 6QO1yyfpxh7KyNNjMMBFBt1jVW/thg==
X-Proofpoint-ORIG-GUID: cxNoZzKk-Ut4WXoJsD0wx_seiJzDlGA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250019

Will pick it up. Thanks

Maddy

On 10/27/25 1:16 PM, Vishal Chourasia wrote:
> ping.
>
> what's the status for this patch?
>
> vishalc
>
>
> On Tue, Oct 21, 2025 at 01:48:31PM +0530, Vishal Chourasia wrote:
>> On Sat, Oct 18, 2025 at 06:52:40PM +0100, Nathan Chancellor wrote:
>>> Commit da30705c4621 ("arch/powerpc: Remove .interp section in vmlinux")
>>> intended to drop the .interp section from vmlinux but even with this
>>> change, relocatable kernels linked with ld.lld contain an empty .interp
>>> section, which ends up causing crashes in GDB [1].
>>>
>>>    $ make -skj"$(nproc)" ARCH=powerpc LLVM=1 clean pseries_le_defconfig vmlinux
>>>
>>>    $ llvm-readelf -S vmlinux | grep interp
>>>      [44] .interp           PROGBITS        c0000000021ddb34 21edb34 000000 00   A  0   0  1
>>>
>>> There appears to be a subtle difference between GNU ld and ld.lld when
>>> it comes to discarding sections that specify load addresses [2].
>>>
>>> Since '--no-dynamic-linker' prevents emission of the .interp section,
>>> there is no need to describe it in the output sections of the vmlinux
>>> linker script. Drop the .interp section description from vmlinux.lds.S
>>> to avoid this issue altogether.
>>>
>>> Link: https://sourceware.org/bugzilla/show_bug.cgi?id=33481 [1]
>>> Link: https://github.com/ClangBuiltLinux/linux/issues/2137 [2]
>>> Reported-by: Vishal Chourasia <vishalc@linux.ibm.com>
>>> Closes: https://lore.kernel.org/20251013040148.560439-1-vishalc@linux.ibm.com/
>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>> ---
>>>   arch/powerpc/kernel/vmlinux.lds.S | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
>>> index de6ee7d35cff..15850296c0a9 100644
>>> --- a/arch/powerpc/kernel/vmlinux.lds.S
>>> +++ b/arch/powerpc/kernel/vmlinux.lds.S
>>> @@ -330,7 +330,6 @@ SECTIONS
>>>   	}
>>>   	.hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }
>>>   	.gnu.hash : AT(ADDR(.gnu.hash) - LOAD_OFFSET) { *(.gnu.hash) }
>>> -	.interp : AT(ADDR(.interp) - LOAD_OFFSET) { *(.interp) }
>>>   	.rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET)
>>>   	{
>>>   		__rela_dyn_start = .;
>>>
>>> ---
>>> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
>>> change-id: 20251018-ppc-fix-lld-interp-1a78c361cd42
>>>
>> With this patch, I don't see .interp section being emitted the final
>> vmlinux binary.
>>
>> ```
>> (i) ❯ make LLVM=1 vmlinux
>> (i) ❯ llvm-readelf -p .comment vmlinux
>>
>> String dump of section '.comment':
>> [     1] clang version 22.0.0git (https://github.com/llvm/llvm-project.git 7314565281ec28b745502c3f429fd431e16673eb)
>> [    6d] Linker: LLD 22.0.0 (https://github.com/llvm/llvm-project.git 7314565281ec28b745502c3f429fd431e16673eb)
>>
>> (i) ❯ llvm-readelf -p .interp vmlinux
>> llvm-readelf: warning: 'vmlinux': could not find section '.interp'
>> ```
>>
>> Tested-by: Vishal Chourasia <vishalc@linux.ibm.com>

