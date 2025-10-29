Return-Path: <linux-kernel+bounces-876910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B590C1CB6F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E26FA4E0274
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204073546F0;
	Wed, 29 Oct 2025 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hHtUN2cj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FDB2E093B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761603; cv=none; b=T6rvm8kX/8fmoEScogtD8cy0yoTzv7d3y5EPfSdHznCXEAlu7p54qf15U9+pScf3jXfRaPtVmjwl719DxqEkel+vkKBV49Cgdq7+MzXpq5qG31CSglUymc5LhcmOB7xooTPl6aMxUGSO4R9TFskiDxOp/8aB0Pg9W5VH4bC8L90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761603; c=relaxed/simple;
	bh=YGIjfZ5z6I1RMrOqkJ+iqvqR1zxlzMw5rnw2K83rnhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/4rSscmrEQnAllhlemQYYlInuGcFTZ3j2gqCgP/lNgXlcK+9Lzg1NxV0cykep5kNHiFZ9wQnabJGhu7DuhyfYxd6w1vUc2V1Oo+BB2AADGIZM/bcDcmcpJoqn9RBjzpTOG1pEwrS+2NXPqED7LqkyPjPQtedYjXSbD4aa2jmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hHtUN2cj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TBeHWF004707;
	Wed, 29 Oct 2025 18:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GmIWo2
	qVToSkm55FmMA8r0gBjs4+fBbfI5i0f3chaXM=; b=hHtUN2cj/BXJpMd28BxagL
	4n2sD4iWbPN95YProgXXr+mtu1fpFv334dancvx2JiYBy1X938WVTolcNBPeurp0
	HMIMu/aIDQa+I9ZOVH/ZX2PiKNuEc9Z4FD+UdUDHZDXyp0UivhEcGmPcgyN7d/rn
	o7dHEEjb9S8KX1zRgsw0d6mLV6Zx4GEX9TVlPg+OmugokfBmQBLyFq6BXtARsdnI
	ja/UAxsSLtLkOFkItTFUCK/m/8nEIATzHc2bdmlKD0HbdQmp1tS0RHhQly5WhQuY
	2AY72nuBZhxbYPaqlpchmBdK3x4DdKFDx/qQ3ms3cp6ontyo7wX6ALMfhtntlwfQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34a8mxk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 18:13:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59TGf6H7019555;
	Wed, 29 Oct 2025 18:13:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xy4tn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 18:13:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59TICw7V37814692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 18:12:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 036DF20043;
	Wed, 29 Oct 2025 18:12:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 299A220040;
	Wed, 29 Oct 2025 18:12:56 +0000 (GMT)
Received: from [9.43.108.83] (unknown [9.43.108.83])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 18:12:55 +0000 (GMT)
Message-ID: <875b21ae-c30f-4dff-bef2-e41965013416@linux.ibm.com>
Date: Wed, 29 Oct 2025 23:42:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [next-20251022] Kernel Boot Warnings at
 arch/powerpc/kernel/trace/ftrace.c:234
To: Petr Mladek <pmladek@suse.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, joe.lawrence@redhat.com,
        Naveen N Rao <naveen@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>, jpoimboe@kernel.org
References: <72469502-ca37-4287-90b9-a751cecc498c@linux.ibm.com>
 <cdf7c458-b28f-4657-8708-1f820369baa6@linux.ibm.com>
 <aPjW3P2AU7L71S-s@pathway.suse.cz>
 <ee9aaeec-23bf-42ac-8a8d-4ba899cfdd13@linux.ibm.com>
 <aPnxlEkV1rL0hWOm@pathway.suse.cz>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <aPnxlEkV1rL0hWOm@pathway.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=DYkaa/tW c=1 sm=1 tr=0 ts=6902592e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=fK6JaBiouQS_75ia3JAA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: mk7chUfAGZFJ3sPtzKwaN0jojhrKfi00
X-Proofpoint-ORIG-GUID: mk7chUfAGZFJ3sPtzKwaN0jojhrKfi00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX1TxsO9OKyJNc
 CFFA01PgsBB0LntQtR66nnTER0+K++JCRUOtLr7vvu+0DIbyGME3YJGVvd9lNPHTgupoyF5Jj3g
 htiowomwofQmT4+ddn6Bo5lryM4a6GAoMd+znjdmW/f1b4hvD6n8v8tEbWeAduoZEwnm8N05u1s
 JB5AIGFgs7/av8jS2S1uSbADbiLemgBweLYeLnPi5tYqi85M/IAFUxJw8W7R7E/GEMAZVNAa3HD
 yXTeUlfFL4tfilgF08cs9WmUFusg/ZKaWGFj4igsAO5LfRcQemCB0pfERK/2buj4y7lnFOAN91d
 d5PkppBMHfp6eAuKQ/O5CsSQ6nZe2tONeJBB/EnPVfhaxIiHI2WUhT9TXayKxNrtDyD01h6Dupj
 idcewdffjgCted9pywzqSlbbwUWGew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

Hi Petr,

On 23/10/25 2:42 pm, Petr Mladek wrote:
> On Wed 2025-10-22 19:56:45, Venkat Rao Bagalkote wrote:
>>
>> On 22/10/25 6:36 pm, Petr Mladek wrote:
>>> On Wed 2025-10-22 17:36:18, Venkat Rao Bagalkote wrote:
>>>> On 22/10/25 1:52 pm, Venkat Rao Bagalkote wrote:
>>>>> Greetings!!!
>>>>>
>>>>>
>>>>> IBM CI has reported kernel boot warnings with next-20251022 kernel. I
>>>>> see there are couple of warnings hit and eventually system boots to
>>>>> emergency mode.
>>>>>
>>>>>
>>>> With the identified first bad commit, is casuing the kernel to boot to
>>>> emergency mode. I reverted the bad commit and built the kernel, then kernel
>>>> is booting fine, but with boot warnings.
>>> I guess that it is the same problem which should get fixed by the patch
>>> https://lore.kernel.org/r/e52ee3edf32874da645a9e037a7d77c69893a22a.1760982784.git.jpoimboe@kernel.org
>>
>>
>> Thank you Petr, for pointing to the fix patch. It fixes the kernel booting
>> to emergency mode.
> 
> Great.
> 
>> But boot warning still persists.
> 
> I looks like another problem. I would expect that it is in
> the ftrace code, either in the generic or arch-specific part.
Yeah. This is part of arch-specific code that does init of ftrace
out line stubs. The problem seems to be since commit 1ba9f8979426
("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros").
Before this commit, .text.startup section was featured in INIT_TEXT
but now it seems to feature in TEXT. Is this change right/intentional?
If yes, I can post a fix patch in ftrace arch-specific code accordingly.

- Hari


