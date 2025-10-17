Return-Path: <linux-kernel+bounces-858340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 678B2BEAC05
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F26941131
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36405330B3A;
	Fri, 17 Oct 2025 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rxLGtBl7"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED148330B0C
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716086; cv=none; b=pt+sovGFJuffrGDG6qXUWz0nnnQ+63yyuVtxjSqkRp4nSVHrk/C9AqUhLIZGqpQR8BqCrMyGTyIHys6KQfVowLOS9kjb+d3v3rW4Mrs1bCI5jXjUon2YUP5WBmO4nVnsJuvmepMIRk9JjnWwiVrIH6+fADTRNG3+9fycoXCblPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716086; c=relaxed/simple;
	bh=dGQRdBE6mPBL8rQFb7TG6FuMDya6OwWh4pFBXCOjxYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezAJW52ppI2s4HvaQbd22HPjXLbbqnvWUA1osSkppRHC9FGWfZfm6J358W1SdSljbEEStzgAOWK4Ul8yjQ8K1JvjKLeQSW6iVe4sDGeo1enO8BQwdz8CPDm1GR7TlTLifeUM/oxRoyGcPsQw5sZaTBKHOa4hleMhzVdHE0GH8MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rxLGtBl7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HBmW5D021864;
	Fri, 17 Oct 2025 15:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n7iz6J
	4aQLlP/NIJMiqQ7m0EHnmLnFn3zcDnvz91BKY=; b=rxLGtBl7hXkVxc7muokLSl
	5+qwpmOhqRXSKXPLIStYfLG+mbf+4OxnGUkr0u/05WVMiNkTjpNJRTYXaIpM8Rol
	bJt2dxTmLsbbOg2VYEaNqLrd+vdnB0VLEVslDEpPUYtXMJR5ZaY3EGeRUb3LH/ES
	06msRP7b4npEb6rKTt/Oano+zrvaVyYA8fygliEdxHs83Fhlgw1KS1P/o+vCR5Dy
	8Eh5jfEcgX6+NpsrOsn6EQEwvbcuRerK84vzVdanTnaQ22o58l2Xis65SY9R9nug
	84aBS6KjqEy5DVjYCjzpv866KN3pGKXDAGY6YRHZlMxuntJEExX4KYnd5sVrBWBQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey9bqe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 15:47:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59HCZequ016705;
	Fri, 17 Oct 2025 15:47:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32ke1c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Oct 2025 15:47:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59HFlSAn49938840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 15:47:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 032882004B;
	Fri, 17 Oct 2025 15:47:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6990520040;
	Fri, 17 Oct 2025 15:47:27 +0000 (GMT)
Received: from [9.111.136.134] (unknown [9.111.136.134])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Oct 2025 15:47:27 +0000 (GMT)
Message-ID: <bd9bac99-208c-426d-b828-e23188d93226@linux.ibm.com>
Date: Fri, 17 Oct 2025 17:47:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] unwind: Implement compat fp unwind
To: Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
        rostedt@kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20250924075948.579302904@infradead.org>
 <20250924080119.613695709@infradead.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20250924080119.613695709@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aOYkW3NGnsnwbKmemrBDXREoodSswcCQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX8qhUa4fy1B2F
 4L4mVcozEM5vrNwv6fA6y7TiwWmGIh4RwvslD2YMcO5uhMpzcO4W298uXu07NN+gK1DnaBZh7W0
 jLJ6Ta3kylOse7Y8A39AN3fQMa+zaCtveYg0alLisR25VuVGfMOcqml1KTgZDmPd/SJZw+ysEwK
 8kSB809CA2ZYhKr/R7xFnNLbLAvLHXOfZEmgaSY5eZJ7qRi/VgecIpqWqVfJRG9aiTex65cNWoa
 YpzNoxzdUX5uYXOqfAl32dqp+qyb5CDnlwJUghDoCMxB0WRGwLXGGCFvC0zFPv9Il3hOYf+ImiT
 4EvKGFj76WYDBDkkB6XwMN/qmXA51pdRio3BLW/zHrBVzLhqS9WXdbGwnlLDrAvPhVIOqzT4Hyh
 +O7yLXKXFUl91Aoh+NIj571I0HQIQg==
X-Proofpoint-GUID: aOYkW3NGnsnwbKmemrBDXREoodSswcCQ
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68f26515 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=KEZ8l_Vj1H9mb3Yf3isA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011

Hello Peter, Steve, Josh, and Indu,

while rebasing the unwind user sframe series on top of this series and
https://lore.kernel.org/linux-trace-kernel/20251007214008.080852573@kernel.org/
I ran into the following issue:

On 9/24/2025 9:59 AM, Peter Zijlstra wrote:

> --- a/include/linux/unwind_user_types.h
> +++ b/include/linux/unwind_user_types.h
> @@ -36,6 +36,7 @@ struct unwind_user_state {
>  	unsigned long				ip;
>  	unsigned long				sp;
>  	unsigned long				fp;
> +	unsigned int				ws;

Factoring out the word size (ws) from the CFA, FP, and RA offsets is
clever.  Wondering though whether that would be an issue for unwind user
sframe.  Do all architectures guarantee that those offsets are aligned
to the native word size?

>  	enum unwind_user_type			current_type;
>  	unsigned int				available_types;
>  	bool					done;

> --- a/kernel/unwind/user.c
> +++ b/kernel/unwind/user.c

> @@ -29,21 +44,21 @@ static int unwind_user_next_fp(struct un
>  	}
>  
>  	/* Get the Canonical Frame Address (CFA) */
> -	cfa += frame->cfa_off;
> +	cfa += state->ws * frame->cfa_off;

In SFrame the CFA, FP, and RA offsets are unscaled.  Would it be ok, if
unwind user sframe would factor state->ws from those offset values?  What
if they were not aligned?  unwind user sframe would then have to fail.

@Indu: Thought from a SFrame perspective?

>  
>  	/* stack going in wrong direction? */
>  	if (cfa <= state->sp)
>  		return -EINVAL;
>  
>  	/* Make sure that the address is word aligned */
> -	if (cfa & (sizeof(long) - 1))
> +	if (cfa & (state->ws - 1))
>  		return -EINVAL;

Alternatively using a state->ws of 1 in uwind user sframe would defeat
this alignment check.

>  
>  	/* Find the Return Address (RA) */
> -	if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
> +	if (get_user_word(&ra, cfa, frame->ra_off, state->ws))
>  		return -EINVAL;
>  
> -	if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
> +	if (frame->fp_off && get_user_word(&fp, cfa, frame->fp_off, state->ws))
>  		return -EINVAL;
>  
>  	state->ip = ra;
> @@ -100,6 +115,7 @@ static int unwind_user_start(struct unwi
>  	state->ip = instruction_pointer(regs);
>  	state->sp = user_stack_pointer(regs);
>  	state->fp = frame_pointer(regs);
> +	state->ws = compat_user_mode(regs) ? sizeof(int) : sizeof(long);
>  
>  	return 0;
>  }
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


