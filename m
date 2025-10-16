Return-Path: <linux-kernel+bounces-855559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B94E9BE1A31
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA09419C078E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFC5253F13;
	Thu, 16 Oct 2025 06:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OJ5JqKey"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2724F14F125
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760594803; cv=none; b=E4oayJ4VeG4hoTZeq22q+p0xo5wpaS+MqDQMlIOdVwKbG+2JU8PU+AGaDdYNBdKLfAjwrEO7gEGyfDZITtGWHBFFNKfKJfh4/q6ULWDFSHgt6OL7uoF2dKT9/TgrcKUnLzRT2vussk8qSRCHb9VoIlNdt3LJqPh7Z95hTclSkSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760594803; c=relaxed/simple;
	bh=tljkTNowknMzKXEvIQB4lhu1urm3F6ZbijcJidiBms4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgLapz1RKV14TtWMp5kESCF/rUHYYxYWYIuXiDmpdtEl/glYelqZsrr8S087JDhSizO2mx/qD8TSBI7GmdCtxBZk5jSzCjP3R+1J9ZnFGhiFl3qD6MKihqNv6f6LaEuzbqU82+rXhKGJozDZAdFaMe9rZxviKmQbTAAjAdq1JYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OJ5JqKey; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G0xTrD021081;
	Thu, 16 Oct 2025 06:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=23BFo5
	NLUkzmzCmHHTtExAib8hTG4oYZFh0n5xDzJSE=; b=OJ5JqKey7JZhTdthd4Q4cf
	/nJza+emHbNeAs3XTw3IEj7HvDZcYVpW39WP+700xXL4WKORjLvDA/ajdbkoCslv
	szxBboXcNTepkbn7Z4sjb1nFDvPfPqQQsfH0PSyIQZrF7Z+2mAqnKmA/hftMIWhJ
	cBHtIvCW3ULc4AQAjxvA2YhbClyIwFxpoxlWQhIDN8qctER3TKvK0MqWIzEX5JqM
	To74UJJcAZJXdQZr05VEVw5MKCz0h0HniQW4r8CT1SdFux4XylfzqWqXCd1ALcvw
	8HPh9OwxNnXD5jHVOBjto6UaMgJEiooKz4lL4/Vy/MT012t5qmCxo3NkMDmEpDSQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew07pun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 06:06:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59G2mFo3015010;
	Thu, 16 Oct 2025 06:06:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjkyt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 06:06:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59G66KO262587366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 06:06:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AD6E20043;
	Thu, 16 Oct 2025 06:06:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51F5820040;
	Thu, 16 Oct 2025 06:06:18 +0000 (GMT)
Received: from [9.39.26.252] (unknown [9.39.26.252])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 06:06:18 +0000 (GMT)
Message-ID: <df656b31-d06f-4216-9e34-094e6e54b89b@linux.ibm.com>
Date: Thu, 16 Oct 2025 11:36:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/powerpc: Remove .interp section in vmlinux
To: Nathan Chancellor <nathan@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
References: <eeaf8fd6628a75d19872ab31cf7e7179e2baef5e.1751366959.git.christophe.leroy@csgroup.eu>
 <20251013040148.560439-1-vishalc@linux.ibm.com>
 <2b4a3215-1620-40c9-a00c-ca833ebbb7b6@csgroup.eu>
 <aOypxKMzsLR5tAtv@linux.ibm.com> <20251015002154.GA2300901@ax162>
 <aO8XEhMdT19UOPlp@linux.ibm.com> <20251015182754.GA1055324@ax162>
Content-Language: en-US, en-IN
From: Vishal Chourasia <vishalc@linux.ibm.com>
In-Reply-To: <20251015182754.GA1055324@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w04b11U9kwOQz219026f-f5VIsSaAmVG
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f08b5e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=FSImCwsN6pc2FdypRLQA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX8gEKrMcTbn0Y
 ba1Ajrou5+Je5z5BZ2kMT+XgHaUeaOzqHRan/Xhs1pMDsth63S6Y3UBPWWXYpJWYfRtxRm1cStr
 BMqMnVRcdr2IyHhnYpGXcwCSJN8qV7xIzQbnwWVfk/4mEAJBXEXCrwFtZ96VLnma81+YzHua0Zv
 J0T/l/cjPF5dSyY2QuLMDKEnp2gOScV4wesJ1KURpl+3p78Nhx+eNU51CGsIkeOYwc4hugDZ5lM
 7gVwS24rnlEjrk+ndcMJx2ctv2WyyCmXq38nm/h3i2JemKhZdJuXzvc1qt1RcVMUACYmZd7kNgx
 kNwLJAuLtdLrq9mu/P4s2TbO3Oem7BKE/JKsQ1vUBfDTSodVQCR3wFKeX9mGioZPZLfRTnXxz9u
 UHk4V3nopURoGbQdJjeiV9j8+NInNQ==
X-Proofpoint-GUID: w04b11U9kwOQz219026f-f5VIsSaAmVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014


On 15/10/25 23:57, Nathan Chancellor wrote:
> On Wed, Oct 15, 2025 at 09:07:54AM +0530, Vishal Chourasia wrote:
>> Hello Nathan,
>>
>> On Tue, Oct 14, 2025 at 05:21:54PM -0700, Nathan Chancellor wrote:
>>> In this bug report, you mention using LLVM=1. Does the issue happen if
>>> you use GNU ld (ld.bfd) via LD (i.e., LD=powerpc64le-linux-gnu-ld or
>>> equivalent) over ld.lld from LLVM=1? This sounds more likely to be a
>>> linker difference rather than a compiler difference.
>> Thank you for the insight.
>>
>> Yes, when using powerpc64le-linux-gnu-ld linker .interp section is not
>> emitted.
>>
>> Command:
>> $ make LLVM=1 ARCH=powerpc LD=powerpc64le-linux-gnu-ld -j 8 zImage
>> $ llvm-readelf -p .comment vmlinux
>>
>> String dump of section '.comment':
>> [     0] clang version 22.0.0git (https://github.com/llvm/llvm-project.git 7314565281ec28b745502c3f429fd431e16673eb)
>>
>> $ llvm-readelf -p .interp vmlinux
>> llvm-readelf: warning: 'vmlinux': could not find section '.interp'
> Thanks for confirming. Does this fix the issue for you? It appears to
> work for me.
>
> Cheers,
> Nathan
>
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index de6ee7d35cff..15850296c0a9 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -330,7 +330,6 @@ SECTIONS
>   	}
>   	.hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }
>   	.gnu.hash : AT(ADDR(.gnu.hash) - LOAD_OFFSET) { *(.gnu.hash) }
> -	.interp : AT(ADDR(.interp) - LOAD_OFFSET) { *(.interp) }
>   	.rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET)
>   	{
>   		__rela_dyn_start = .;

Hello Nathan,

It does solve the problem, but with GNU linker it would work even
without this change.

regards,
vishalc


