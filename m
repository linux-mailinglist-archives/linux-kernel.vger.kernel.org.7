Return-Path: <linux-kernel+bounces-860439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE862BF020A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A20554E29A7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB43F2F49F7;
	Mon, 20 Oct 2025 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WQ1Qylfc"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B98E2ECE9C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951849; cv=none; b=GsBr9JbFkbjQuiGSx7ELysvswAzS9HlIjsqeayvmbMXP3XGPPGw0eo6Ic4kN7pfbme5XZvMwZQyqXM13OOdZJzi65PWxZBtuFMhcliFOl/58qC7b3bGrlDwfTQhhaCHBTcc1n214FifCbUk0rBo3VGqv18a4Y89nI8BqqO6sqoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951849; c=relaxed/simple;
	bh=FcyLLHPC1AdPlDRnPGRE0+46IVYw8yKfKXJcxVAb5Bk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ea6GTwWrRqBg52uLQSVS/VF6+eGTarZRA51rkFmv4SNszVwMuviGa0RfU4sG7hNeOYYEFySEIMrUFTWMaIsgWyrv7os72W90NpZ/nxAZQU6jfloKQnOFY9PWhb9U0HW8pw9jDHiIOd+WbIA1aWQXEJYm4UNriF/GrYqigJk0njo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WQ1Qylfc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K2uTA9022756;
	Mon, 20 Oct 2025 09:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PQ5IDN
	ouiD0AMN/ysyFF54Nav47YwQGTIVRGxv2jGLA=; b=WQ1QylfcURI8ugC4beUF0e
	2zvJ7VVrMJMHku7Sn2eKZNCCYNaYQPizsTKYg9+/HLQnij+GoCLDvdDk28BPZE7l
	LzwSBsKKVFgG36Vmc6b34BBI1/hiX5fW6Rwl5+QLrhI7Dsj+8enlLspSrJekX2xn
	/9uloQSFLpfujsO1Tr4+/SvhrvZ9T7JTakYM6zZS20raVRw6h2nA+84oeY8UAQTg
	/ZM4WZn8WEiYRx4plJxrngomrr9sHoBrgLlF+VeCnnFgC3xIBEFOD5wR+xF+MPj2
	ERPubE43hiC/9+7vP92RK1MFZ2N9CFXSl7NNCQrzHEuTPKHxkDaZeubJyTpfKmQA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rrmwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 09:16:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59K7GO9U002381;
	Mon, 20 Oct 2025 09:16:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqej4rs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 09:16:49 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59K9GkNi29753834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 09:16:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 226832004D;
	Mon, 20 Oct 2025 09:16:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A782F20040;
	Mon, 20 Oct 2025 09:16:45 +0000 (GMT)
Received: from [9.111.203.169] (unknown [9.111.203.169])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Oct 2025 09:16:45 +0000 (GMT)
Message-ID: <cc6f34bb-7d05-4260-bc02-299fef2bcb01@linux.ibm.com>
Date: Mon, 20 Oct 2025 11:16:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] unwind: Implement compat fp unwind
From: Jens Remus <jremus@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org,
        rostedt@kernel.org, Indu Bhagat <indu.bhagat@oracle.com>
Cc: linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20250924075948.579302904@infradead.org>
 <20250924080119.613695709@infradead.org>
 <bd9bac99-208c-426d-b828-e23188d93226@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <bd9bac99-208c-426d-b828-e23188d93226@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uhMjgB959wk9XkhpY4f2rJLlc9u3Nq7S
X-Proofpoint-GUID: uhMjgB959wk9XkhpY4f2rJLlc9u3Nq7S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXx2sHEFd9snsb
 r6fDVo0TJXYO9sIRgO+hgopbcMasEOoJ0DDEeZxPh1ri/24FSks/c8rfrQO3M+GRnOsT6Wmf5rD
 ObHL7QG1orwm52jbsV1ci/OyxPVYIDWkN/UrqxNufktc5ANSdRybPDXQeV9b4zF8I1JKBRo7xt7
 ywvrHzKthMaR/UBCf+UytfG/+gqda9FYMWpwiZeup/rYcIFswJckjb/hOprSedfzzVnIiA1Zbrs
 ten91qYWO8AWparDNdnR70cfU2FTze64JQD9vBD7k5O8+XqYIlFt6PQaVFDcOiR9hqdfXDpDxhJ
 FRppzUen+TEr1vQfUSzegNBD72aeseIHb/yGYbHAwX/Grzqx2GmWfyRC8o/GyomXnhuabK+wnOR
 3N1Xgz8VnA24Xt/oT4DFjYRBPfc8xA==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f5fe02 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=kKdXzyBnyl-Den_vObcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Hello Peter!

On 10/17/2025 5:47 PM, Jens Remus wrote:
> while rebasing the unwind user sframe series on top of this series and
> https://lore.kernel.org/linux-trace-kernel/20251007214008.080852573@kernel.org/
> I ran into the following issue:
> 
> On 9/24/2025 9:59 AM, Peter Zijlstra wrote:
> 
>> --- a/include/linux/unwind_user_types.h
>> +++ b/include/linux/unwind_user_types.h
>> @@ -36,6 +36,7 @@ struct unwind_user_state {
>>  	unsigned long				ip;
>>  	unsigned long				sp;
>>  	unsigned long				fp;
>> +	unsigned int				ws;
> 
> Factoring out the word size (ws) from the CFA, FP, and RA offsets is
> clever.  Wondering though whether that would be an issue for unwind user
> sframe.  Do all architectures guarantee that those offsets are aligned
> to the native word size?
> 
>>  	enum unwind_user_type			current_type;
>>  	unsigned int				available_types;
>>  	bool					done;
> 
>> --- a/kernel/unwind/user.c
>> +++ b/kernel/unwind/user.c
> 
>> @@ -29,21 +44,21 @@ static int unwind_user_next_fp(struct un
>>  	}
>>  
>>  	/* Get the Canonical Frame Address (CFA) */
>> -	cfa += frame->cfa_off;
>> +	cfa += state->ws * frame->cfa_off;
> 
> In SFrame the CFA, FP, and RA offsets are unscaled.  Would it be ok, if
> unwind user sframe would factor state->ws from those offset values?  What
> if they were not aligned?  unwind user sframe would then have to fail.

Sorry that I did not immediately think about the most obvious solution
tho above issues:  to not factor out the word size from the frame CFA,
FP, and RA offsets.  What do you think about making the following
changes to this and giyour subsequent patch?  That would work nicely
with unwind user sframe.


diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -8,19 +8,15 @@
 #include <linux/unwind_user.h>
 #include <linux/uaccess.h>
 
-static const struct unwind_user_frame fp_frame = {
-	ARCH_INIT_USER_FP_FRAME
-};
-
 #define for_each_user_frame(state) \
 	for (unwind_user_start(state); !(state)->done; unwind_user_next(state))
 
 static inline int
-get_user_word(unsigned long *word, unsigned long base, int off, int size)
+get_user_word(unsigned long *word, unsigned long base, int off, unsigned int ws)
 {
-	unsigned long __user *addr = (void __user *)base + (off * size);
+	unsigned long __user *addr = (void __user *)base + off;
 #ifdef CONFIG_COMPAT
-	if (size == sizeof(int)) {
+	if (ws == sizeof(int)) {
 		unsigned int data;
 		int ret = get_user(data, (unsigned int __user *)addr);
 		*word = data;
@@ -32,6 +28,9 @@ get_user_word(unsigned long *word, unsigned long base, int off, int size)
 
 static int unwind_user_next_fp(struct unwind_user_state *state)
 {
+	const struct unwind_user_frame fp_frame = {
+		ARCH_INIT_USER_FP_FRAME(state->ws)
+	};
 	const struct unwind_user_frame *frame = &fp_frame;
 	unsigned long cfa, fp, ra;
 
@@ -44,7 +43,7 @@ static int unwind_user_next_fp(struct unwind_user_state *state)
 	}
 
 	/* Get the Canonical Frame Address (CFA) */
-	cfa += state->ws * frame->cfa_off;
+	cfa += frame->cfa_off;
 
 	/* stack going in wrong direction? */
 	if (cfa <= state->sp)


diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -2,10 +2,10 @@
 #ifndef _ASM_X86_UNWIND_USER_H
 #define _ASM_X86_UNWIND_USER_H
 
-#define ARCH_INIT_USER_FP_FRAME				\
-	.cfa_off	=  2,				\
-	.ra_off		= -1,				\
-	.fp_off		= -2,				\
+#define ARCH_INIT_USER_FP_FRAME(ws)			\
+	.cfa_off	=  2*(ws),			\
+	.ra_off		= -1*(ws),			\
+	.fp_off		= -2*(ws),			\
 	.use_fp		= true,
 
 #endif /* _ASM_X86_UNWIND_USER_H */


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


