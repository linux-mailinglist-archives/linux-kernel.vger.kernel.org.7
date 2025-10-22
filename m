Return-Path: <linux-kernel+bounces-865290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B160BFCB6C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CD0C1A00DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20E635BDAD;
	Wed, 22 Oct 2025 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fqx1HCRR"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A2B28031C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144916; cv=none; b=rByVTNJagDablFY5phOyFyA2HzPPIfyEGP5kkvQc4b8rN7P/qGfBf8mgots9vnFyhIC4Kojxbp4a/nsMN6l5OzpuW2Jc+iNgf7k2cIAzfeJlp+wkozi4YeBZgIlA5eImcq78ramYtw2MD3kNoyHmNV5zNnPVsF1GCW93a02YYLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144916; c=relaxed/simple;
	bh=xixcZTX0eL1d7xfnAtnsiDVqngsxSpBsAPH4d0uTQCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9JTRjQyAEQekYeBMmF/A/nzG9tb3hl+L8Grrmt/OZvZZUSzHfavRjfqOStWXibW0bSTsc/qaVhqhWmfjKe1dzxi8IbEdY2zVykP0vmQFKOpQPZC9M4ZecLvGrEpLmNiNhPGqwGze9HQ6XF6lVcXVSl02xQ5FH2Jdc1Xbwu76OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fqx1HCRR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAxsGx001260;
	Wed, 22 Oct 2025 14:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=l27BBe
	gJyx7DxIFqkcgjXnfZZVih1LLKp87o90TDHU0=; b=Fqx1HCRRVx9WeK+DDWklsR
	BdFHpylF1AJjYn1AxUG3hzJSFl/Q7GfrIrnrL1SE1hYPjuhXCkfPAMISQsFGAFFL
	Sb4w/eCMa1Rm4yUiol2QSgITh8n5G/9LdnZEmOAGbGVJomACxQV/flVIDOi1BCN+
	7zhwQRiXl7UCdjCVEDdIh3I0T6uaCWYZt0ptlLbVpgy2AwTrTRhM6lMEjDyW7bPl
	n//mHI691q5yybNqd7oKLR5VtlPYoh8i/TPBerXZ2SDb4clur2Y5FI/O3+ATuxQv
	TPi8RQBPsdg/XQb4Mf8tOmIV5I+y4CtstZMg1ioYQjmgceyPVxY5jB5Tabw1cN5A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s5cc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 14:55:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59ME0HEn017058;
	Wed, 22 Oct 2025 14:55:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnky117s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 14:55:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MEt3rF59572706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 14:55:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05CDC2004B;
	Wed, 22 Oct 2025 14:55:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E97820043;
	Wed, 22 Oct 2025 14:55:02 +0000 (GMT)
Received: from [9.111.139.78] (unknown [9.111.139.78])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 14:55:02 +0000 (GMT)
Message-ID: <5bdb1c91-8862-44b1-9f12-c5afa9e1806c@linux.ibm.com>
Date: Wed, 22 Oct 2025 16:55:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] unwind: Implement compat fp unwind
To: Peter Zijlstra <peterz@infradead.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <20250924075948.579302904@infradead.org>
 <20250924080119.613695709@infradead.org>
 <bd9bac99-208c-426d-b828-e23188d93226@linux.ibm.com>
 <cc6f34bb-7d05-4260-bc02-299fef2bcb01@linux.ibm.com>
 <20251020103940.GP3419281@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20251020103940.GP3419281@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hTbVpASIbEPY8NAoi_K5Tvqqd8d0yyWp
X-Proofpoint-GUID: hTbVpASIbEPY8NAoi_K5Tvqqd8d0yyWp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9+GXXEZo0DWS
 /8LNZxjI2mKX5cOWV7Lxxcabo4fX3SF5H7tr+cerQc6JnpxJIH8GSFz5ggPx1I7U2h2e4aJE+6X
 VuuaKA/8DXhbeNgDJ14BLc4a0vXdnBAeVGaUlyuQ8yVEKbU2rT3vbsTUtVH5RdfUWICYaYnHQlC
 sjWF+6TWAaqLV7yGODXT/vV9oisCp2udKAZ9JTEwOHzEUpxU5WNPl7oOGR5GHcjfuoldyK62Jf8
 ViBdeISq6pUB0pVfGZvgaww2MtGoGDmYKmZjnaHDYESF2bCSTXO6EuQmSIJjDnDQklFhPTqKQGq
 uUNRydkY7VBcTzTCw6QEpGNZOf1Ptzv6DCpvb9KFhVcTCQuSbLRouotXTIn6oYjRqgWOVj1OLk/
 LyUWUgiDInUXtHxellJ2f4zW2Cya8A==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f8f04c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=0MvmVg10__VCTnNSAJcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Hello Peter!

On 10/20/2025 12:39 PM, Peter Zijlstra wrote:
> On Mon, Oct 20, 2025 at 11:16:45AM +0200, Jens Remus wrote:
>> On 10/17/2025 5:47 PM, Jens Remus wrote:

>>> In SFrame the CFA, FP, and RA offsets are unscaled.  Would it be ok, if
>>> unwind user sframe would factor state->ws from those offset values?  What
>>> if they were not aligned?  unwind user sframe would then have to fail.
>>
>> Sorry that I did not immediately think about the most obvious solution
>> tho above issues:  to not factor out the word size from the frame CFA,
>> FP, and RA offsets.  What do you think about making the following
>> changes to this and giyour subsequent patch?  That would work nicely
>> with unwind user sframe.
> 
> 
> Yes, this should do nicely. I've made the changes, I'll do a test build
> and then push out to the robots.

Thanks!  Looking at your following updated patch I found that your
change from "pointer to const struct unwind_user_frame" to
"const struct unwind_user_frame" (done for obvious reasons) will require
unwind user sframe to undo this when refactoring unwind_user_next_fp()
into unwind_user_next_common().  Would that be the usual procedure or
could you leave it as "pointer to const struct unwind_user_frame" for
now?

https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=unwind/cleanup&id=f3624d64ba4862067b620fbd5bfbc0bfaf5368ae

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/


