Return-Path: <linux-kernel+bounces-865225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECD7BFC98D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD6B6E038F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2CB34D936;
	Wed, 22 Oct 2025 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EUdSsyti"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403831DD82
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143230; cv=none; b=OSk04gkuexg5w6Pw9uUczk4FlJ8vhTluAOpgC/GmH5okMChog85nx57JqflFNad3LEHfI+wTSr1dw5n7We25n1iLVElJrm2K34k6fV57NUUpQIx7Zw9Dk0jEUusv6xu/1Ap+E2tvdIHi8fZSIvluP5oZTQuCa73WeFlE/rn4zTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143230; c=relaxed/simple;
	bh=d5XNWgnDyYArk7hUDnjrgs5dU/pkjGFvY/H3+MZJMN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZ70V8RaiXcjM6+xcFItC2UCK52krH1JfauPV3rlsdWRRacYEFz1AuojQnmsxoYCm+WZNxP1BA0oU/4xJzUixzExh5bo+kQ8kCmbEWlbB66wQMqzjqH+z6EusKmmg4iANoym8mcDf9756nZ64d1p8ExUKDVRvRdZf7SwqbvUqMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EUdSsyti; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAPX7W020537;
	Wed, 22 Oct 2025 14:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5Tfdjt
	RyftlOzKxBDI3Ba/xWzdPhBDRmqzDZJYzaANQ=; b=EUdSsytiEj6WDsDryz9WdZ
	wosFz4nP1A3V6opr/fU6tT0572ujl9QcQ3K7mo1P1b6qVFaeGD43maSV+0qpqFu9
	o6SNAo6pvKRshBc/D70m0RPie5g0gT/wnNOBXT3p6NmkBT4LBaKvpmUQr98edYr4
	QD4jgRAW7tTjuqUxxANSPIfv1WL8xnY6aZg3eFPWog9jEFC+zVJJ6QI2mPKEkri9
	aKR1pEAn2uZrfgM/68LgeJQBZc4bF+AbTG0ilClBPeqNR+xPPZdy5Jr61+AbsVeI
	SF/N6oqPOsXrBonbo24lED3vtJYX26mVhT15m1hpXvrZZ5ncaJyUOwXGn2wqXxEg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s57g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 14:26:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MBJvhV024677;
	Wed, 22 Oct 2025 14:26:52 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk0q8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 14:26:52 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MEQcY530081634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 14:26:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6132B58060;
	Wed, 22 Oct 2025 14:26:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84C0C5803F;
	Wed, 22 Oct 2025 14:26:47 +0000 (GMT)
Received: from [9.61.243.114] (unknown [9.61.243.114])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 14:26:47 +0000 (GMT)
Message-ID: <ee9aaeec-23bf-42ac-8a8d-4ba899cfdd13@linux.ibm.com>
Date: Wed, 22 Oct 2025 19:56:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [next-20251022] Kernel Boot Warnings at
 arch/powerpc/kernel/trace/ftrace.c:234
Content-Language: en-GB
To: Petr Mladek <pmladek@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>, joe.lawrence@redhat.com,
        Naveen N Rao <naveen@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>, jpoimboe@kernel.org
References: <72469502-ca37-4287-90b9-a751cecc498c@linux.ibm.com>
 <cdf7c458-b28f-4657-8708-1f820369baa6@linux.ibm.com>
 <aPjW3P2AU7L71S-s@pathway.suse.cz>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <aPjW3P2AU7L71S-s@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4KKhWbCSXVNx6gKkG9NJUfU6lA_UrVPS
X-Proofpoint-GUID: 4KKhWbCSXVNx6gKkG9NJUfU6lA_UrVPS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX3r42AfKyCWVy
 NNlj1jLHeEhaYwM0vIqh8SppJWfz7Lk8AoksalUiNAB05nIX64UuE3jrMXljcoRgZg13pkUl6TS
 qbqWXx0Fy9T1yfaNvhYLtwqsv2gloHBghF9YM3bJZ96aYDQ9KvScWNrIji3CJzyXqN8RDsTxI4V
 iARoil7mTbeu2GDNkJTIYj/YlIqRW37sewce8hzEbh7c8R65qeoPVFb1XoUR2VWoR/VyZmGuqfn
 Lk2qG+lPhBU5PEH4nBiZBQZmvVBhqi7QIi+CWSZtTV9d1R/Fx2ec0NVIeLUgsjLApKqFjkd//6g
 nQBBc5gV3OH2dUiVZmpioJIjZ+LBH12InB1I+v9X/c6hc4vdKpuAD7vBbyuaZ7VvDOoSmrKlwMB
 49N3PcPy86HbLtzZ/ABEgg73hZphlA==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f8e9ad cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=p0AH9lBHCLZ3R6_psTIA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022


On 22/10/25 6:36 pm, Petr Mladek wrote:
> On Wed 2025-10-22 17:36:18, Venkat Rao Bagalkote wrote:
>> On 22/10/25 1:52 pm, Venkat Rao Bagalkote wrote:
>>> Greetings!!!
>>>
>>>
>>> IBM CI has reported kernel boot warnings with next-20251022 kernel. I
>>> see there are couple of warnings hit and eventually system boots to
>>> emergency mode.
>>>
>>>
>> With the identified first bad commit, is casuing the kernel to boot to
>> emergency mode. I reverted the bad commit and built the kernel, then kernel
>> is booting fine, but with boot warnings.
> I guess that it is the same problem which should get fixed by the patch
> https://lore.kernel.org/r/e52ee3edf32874da645a9e037a7d77c69893a22a.1760982784.git.jpoimboe@kernel.org


Thank you Petr, for pointing to the fix patch. It fixes the kernel 
booting to emergency mode.

But boot warning still persists.

Regards,

Venkat.

>
> Best Regards,
> Petr

