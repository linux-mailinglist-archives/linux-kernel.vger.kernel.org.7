Return-Path: <linux-kernel+bounces-879511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3DCC2346B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3883B7AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7E22D248E;
	Fri, 31 Oct 2025 04:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j24LRQZF"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7969525782E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761886659; cv=none; b=sIjBquMQFpOF0woTiw++DZhzJROYxKcf+fUn3axrDrm30a7s/mIayACNMUFFyMPhG4h24nP6W8GbD7U7sk+tbYW+hr7WCoAYKL7a6+N0OkTU1Der+SLartBLkZAv+RG2OswF/vIKrt0jWZGOm8zeNC3QbpFCxZCsqGv8VEBEMwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761886659; c=relaxed/simple;
	bh=vNwDPdh8wwIuIXmeUfztGBx/Gwt2+uiNBapjhT1Y2w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bas2MUs02gnGGkqEnHIgDRvt0zmsD+lDadAvtrjh9TzMwvV2051ghXpVSxF4P7ysv7PbfrYT385S1CFD1uuwfYgD3wEIEr7DLCuIRjzlgeyX4sT/SL/lVMRB+F5WnjlCAZrw0i6WxAnuaE4dESU03LNGGKQafijPu3iA8xL3Rbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j24LRQZF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UMV1rN026249;
	Fri, 31 Oct 2025 04:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DV0/Uh
	YdxsOVtqL9Njf2hH8FM3tPVZPjTY1+QMSKAtI=; b=j24LRQZFIl/gFnrv+b8EQy
	O5p74JPTAv3B9TIaUVhOzEHBsLpnSLoh/GjmNX5LChUuBCrnQR/xhmhDLJYLEa+2
	Hi8fILE0rj4M/BB+fIzxeY4SrCcWkhV1xIUA9Ygzzj2NC3RU1a9idqpiSk3t5v3+
	IIE0RPmMCi71OC6ggFb8/jMS30wT0hVLP052YBOOoSYIWjWvANz1xNXUPmnb82t+
	3QrBFsm3DrF9PE7wNxcIxomJV9DS3ptbD6ffOIAyY3qF6ERy7AJUhrHRZWWsSPRU
	K7gbDvZi+GQ1t2dv9HbAuQyl5U5CXKamdIzTvG7bJPfXB5hj2ilXAlzWTNx1G+pw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aauxwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 04:57:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59V41JNb019567;
	Fri, 31 Oct 2025 04:57:26 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xycm0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 04:57:26 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59V4vQwU31719974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 04:57:26 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A4ED5805A;
	Fri, 31 Oct 2025 04:57:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24A3958052;
	Fri, 31 Oct 2025 04:57:22 +0000 (GMT)
Received: from [9.61.246.92] (unknown [9.61.246.92])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Oct 2025 04:57:21 +0000 (GMT)
Message-ID: <9f37aa63-d69b-4220-8ef1-3f710cdfe6d4@linux.ibm.com>
Date: Fri, 31 Oct 2025 10:27:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vmlinux.lds: Exclude .text.startup and .text.exit from
 TEXT_MAIN
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Hari Bathini <hbathini@linux.ibm.com>
References: <07f74b4e5c43872572b7def30f2eac45f28675d9.1761872421.git.jpoimboe@kernel.org>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <07f74b4e5c43872572b7def30f2eac45f28675d9.1761872421.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ALkgKXG8 c=1 sm=1 tr=0 ts=690441b7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=dtFbpFOKsQSLWuiXBUUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GIOqVcLDuQYys2qrWAsgGNmqWOHqF2dr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX4Kego/n11Wxy
 xp6nulIR5E6C+8xJBd1nia1nUlgKhZxVXP35xYa19PcUQ2Tfr6Bf6egvfpvKpM0aMghVcARPsow
 5gNCGpof1jKOzWLAra8sGyCQSUe+uAIWn40xerxok3GJ3o8fAOtKUq4/kTUBET7yarQ02bLIjZS
 1NVfyM9fXetH+al2SWyaKqZr9N0mQOy0UJpCAFsM6szYkMhDxJJaSqZGHdRVCl0Hb1vMzjmGMII
 MHUYvcVTSUOFGE1ooTsj2NXgSbLQB6fkoYyFY4mFMnNgRFFr9ADubnA/1s31rkaXoEmCBKw7u+d
 Qzs06aJVTfgp4tctGP+Jkq9oVp3t71AclUHxwLZYVP2jD7PwnHZY/mxlkhs7TNSoLdmMOqmwl7L
 4Dt2a2sQfwvjP/X2oedLqs8tNU2k5g==
X-Proofpoint-GUID: GIOqVcLDuQYys2qrWAsgGNmqWOHqF2dr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166


On 31/10/25 6:31 am, Josh Poimboeuf wrote:
> An ftrace warning was reported in ftrace_init_ool_stub():
>
>     WARNING: arch/powerpc/kernel/trace/ftrace.c:234 at ftrace_init_ool_stub+0x188/0x3f4, CPU#0: swapper/0
>
> The problem is that the linker script is placing .text.startup in .text
> rather than in .init.text, due to an inadvertent match of the TEXT_MAIN
> '.text.[0-9a-zA-Z_]*' pattern.
>
> This bug existed for some configurations before, but is only now coming
> to light due to the TEXT_MAIN macro unification in commit 1ba9f8979426
> ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros").
>
> The .text.startup section consists of constructors which are used by
> KASAN, KCSAN, and GCOV.  The constructors are only called during boot,
> so .text.startup is supposed to match the INIT_TEXT pattern so it can be
> placed in .init.text and freed after init.  But since INIT_TEXT comes
> *after* TEXT_MAIN in the linker script, TEXT_MAIN needs to manually
> exclude .text.startup.
>
> Update TEXT_MAIN to exclude .text.startup (and its .text.startup.*
> variant from -ffunction-sections), along with .text.exit and
> .text.exit.* which should match EXIT_TEXT.
>
> Specifically, use a series of more specific glob patterns to match
> generic .text.* sections (for -ffunction-sections) while explicitly
> excluding .text.startup[.*] and .text.exit[.*].
>
> Also update INIT_TEXT and EXIT_TEXT to explicitly match their
> -ffunction-sections variants (.text.startup.* and .text.exit.*).
>
> Fixes: 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros")
> Closes: https://lore.kernel.org/72469502-ca37-4287-90b9-a751cecc498c@linux.ibm.com
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Debugged-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---


Thanks for the patch. Tested this patch by applying on top of 
next-20251030, and it fixes the reported issue.


Please add below tag.


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>



Regards,

Venkat.


> For tip/objtool/core.
>
>   include/asm-generic/vmlinux.lds.h | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 5facbc994634..9de1d900fa15 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -88,13 +88,29 @@
>   
>   /*
>    * Support -ffunction-sections by matching .text and .text.*,
> - * but exclude '.text..*'.
> + * but exclude '.text..*', .text.startup[.*], and .text.exit[.*].
>    *
> - * Special .text.* sections that are typically grouped separately, such as
> + * .text.startup and .text.startup.* are matched later by INIT_TEXT.
> + * .text.exit and .text.exit.* are matched later by EXIT_TEXT.
> + *
> + * Other .text.* sections that are typically grouped separately, such as
>    * .text.unlikely or .text.hot, must be matched explicitly before using
>    * TEXT_MAIN.
>    */
> -#define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
> +#define TEXT_MAIN							\
> +	.text								\
> +	.text.[_0-9A-Za-df-rt-z]*					\
> +	.text.s[_0-9A-Za-su-z]*						\
> +	.text.st[_0-9A-Zb-z]*						\
> +	.text.sta[_0-9A-Za-qs-z]*					\
> +	.text.star[_0-9A-Za-su-z]*					\
> +	.text.start[_0-9A-Za-tv-z]*					\
> +	.text.startu[_0-9A-Za-oq-z]*					\
> +	.text.startup[_0-9A-Za-z]*					\
> +	.text.e[_0-9A-Za-wy-z]*						\
> +	.text.ex[_0-9A-Za-hj-z]*					\
> +	.text.exi[_0-9A-Za-su-z]*					\
> +	.text.exit[_0-9A-Za-z]*
>   
>   /*
>    * Support -fdata-sections by matching .data, .data.*, and others,
> @@ -713,16 +729,16 @@
>   
>   #define INIT_TEXT							\
>   	*(.init.text .init.text.*)					\
> -	*(.text.startup)
> +	*(.text.startup .text.startup.*)
>   
>   #define EXIT_DATA							\
>   	*(.exit.data .exit.data.*)					\
>   	*(.fini_array .fini_array.*)					\
> -	*(.dtors .dtors.*)						\
> +	*(.dtors .dtors.*)
>   
>   #define EXIT_TEXT							\
>   	*(.exit.text)							\
> -	*(.text.exit)							\
> +	*(.text.exit .text.exit.*)
>   
>   #define EXIT_CALL							\
>   	*(.exitcall.exit)

