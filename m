Return-Path: <linux-kernel+bounces-804018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB8AB468CA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 06:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BB31BC8051
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA00D23D7F4;
	Sat,  6 Sep 2025 04:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bJhKJKY3"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE429A2
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 04:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757131901; cv=none; b=D8MGr0o1fD23QaKicd+MTAIg5LTckq7FACbdl+uIn0OQ0cdoz/1UxWaEA/9tMMUw9EELa4By9sjjp8tbFeI0GDDpBdpVe32EPjYVSjiXADWvxJprWO1zWUsCO87jvKdaZzBtyZyDLB0YKwhXOzHcDZeYWfmN7K9bkS97BpdYduA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757131901; c=relaxed/simple;
	bh=hEx1NKkKUlIrOaELPbvEtcnBzHNEalLmCs6R4U9+pTc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Tb8QXvP/2qqdQy4Ih/HmVPvp+XLkqqwgfYpHsQ5LF2dwIgdiN5NGHOIFEytYcQsOxdTxVY1EjxZLkd4zHcVjW9WLLaBN6SR9T5gajNMOgqNJgG/dGWPhK+qTx+UuEie6lYxs1PYytCgC3P5OB2N6npvkhfy/i+4YzjhcgJePOqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bJhKJKY3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5862wBNs014242;
	Sat, 6 Sep 2025 04:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=pp1;
	 bh=/XrWDlMSknBUdI+P/nmBO66b2axhhLzm5K67zB4bETQ=; b=bJhKJKY3GTZ6
	ZfBnjHiHrRNTHRONw+rlCI97PyrMPiADjl52pdYNzRhGono/R4qOmEmf6J/VWUiZ
	tgMvWO5Yo+6kIYQaDBa7hkSr8CincgRV6egUrdXktbA7IZVdhRHeI/LB7bs1yx3U
	KLr1cVeSS56D5dpCtmgWKsfvtLkvCNXKVBSne0Jjq8EvdTZOTNOWU63gn4B+MxQz
	U9UqRAO2vYxiEBshfYItKOc1Ww0mmAi0dTXd9dxv8WTSOQNNF6U3zQ2uhMcz9x7d
	K0v3n2IHMynGnC5oIAMy5aG4PIe8d4OOJa4TIuMK3y1/bws+b133X1N5yzVbjnDB
	tBH1dCdJAA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmw85dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Sep 2025 04:10:59 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5864Am07010706;
	Sat, 6 Sep 2025 04:10:58 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmw85de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Sep 2025 04:10:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5861EI5v017222;
	Sat, 6 Sep 2025 04:10:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vc114mc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Sep 2025 04:10:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5864ArSW50790870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 6 Sep 2025 04:10:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A33B20043;
	Sat,  6 Sep 2025 04:10:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1011820040;
	Sat,  6 Sep 2025 04:10:49 +0000 (GMT)
Received: from dw-tp (unknown [9.36.11.250])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  6 Sep 2025 04:10:48 +0000 (GMT)
From: Ritesh Harjani (IBM) <riteshh@linux.ibm.com>
To: Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com
Cc: npiggin@gmail.com, rostedt@goodmis.org, ardb@kernel.org,
        Erhard Furtner <erhard_f@mailbox.org>
Subject: Re: [PATCH RFC] powerpc: Panic on jump label code patching failure
In-Reply-To: <20250905061135.1451362-1-ajd@linux.ibm.com>
Date: Sat, 06 Sep 2025 09:22:04 +0530
Message-ID: <87qzwki6fv.fsf@ritesh.list@gmail.com>
References: <20250905061135.1451362-1-ajd@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PVMDvjw-tL3NZRtUaiBXxzMfAvigclEn
X-Proofpoint-ORIG-GUID: cbeOG78TMkQe-VMJ3z_O--cBwR6-zolj
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68bbb453 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=voM4FWlXAAAA:8 a=1UX6Do5GAAAA:8 a=VnNF1IyMAAAA:8
 a=b3CbU_ItAAAA:8 a=iqv5_9DZO53ucXEhF-8A:9 a=IC2XNlieTeVoXbcui8wp:22
 a=Et2XPkok5AAZYJIKzHr1:22 a=Rv2g8BkzVjQTVhhssdqe:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX/sPPXWdUt8iA
 cDIg8JcAgGeV/LWC8gxJlwyS8uepFEh2etmVIgLRPiW4uFxdN7IgpLf6UcpemvESv3K951sI8py
 Ax0ClkRQ9JJjoBKb9tyRi+znKHDCHCL3kz9pgQz+gj6KlKQt5TWn3QpGdbEArL0+7VyVUYozjfb
 +gfBjzvNqxJwizwgvoNtShktjhDsliOw4V2V9ne1Wow9Ei3Mbu/JwBbkvsdDDGa1210Vjftdg8H
 MM+ZEMKPN4M7FV9iDgzq2HrcT3XMaxss+lCq6XJTqF9D1sbf3NsyyN6AKpfYcYUcfdWeaIkkW8m
 MCfH378QQAFfANXMeJD7jkhC8Ri0aabeq+B0pbUcv5YGjcvshpSVrCIlTlzPY6pkR0LkVaYIQtd
 QYKcGa/O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_09,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Andrew Donnellan <ajd@linux.ibm.com> writes:

> If patch_branch() or patch_instruction() fails while updating a jump
> label, we presently fail silently, leading to unpredictable behaviour
> later on.
>
> Change arch_jump_label_transform() to panic on a code patching failure,
> matching the existing behaviour of arch_static_call_transform().
>
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
>
> ---
>
> Ran into this while debugging an issue that Erhard reported to me about my
> PAGE_TABLE_CHECK series on a G4, where updating a static key failed
> silently, but only for one call site, leading to an incorrect reference
> count later on. This looks to be due to the issue fixed in [0]. A loud
> failure would have saved us all considerable debugging time.
>
> Should I change the return type of arch_jump_label_transform() and handle
> this in an arch-independent way? Are there other users of code patching
> in powerpc that ought to be hardened?
>
> Or is this excessive?
>
> [0] https://patchwork.ozlabs.org/project/linuxppc-dev/patch/4b5e6eb281d7b1ea77619bee17095f905a125168.1757003584.git.christophe.leroy@csgroup.eu/
> ---
>  arch/powerpc/kernel/jump_label.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/jump_label.c b/arch/powerpc/kernel/jump_label.c
> index 2659e1ac8604..80d41ed7ac50 100644
> --- a/arch/powerpc/kernel/jump_label.c
> +++ b/arch/powerpc/kernel/jump_label.c
> @@ -12,9 +12,14 @@ void arch_jump_label_transform(struct jump_entry *entry,
>  			       enum jump_label_type type)
>  {
>  	u32 *addr = (u32 *)jump_entry_code(entry);
> +	int err;
>  
>  	if (type == JUMP_LABEL_JMP)
> -		patch_branch(addr, jump_entry_target(entry), 0);
> +		err = patch_branch(addr, jump_entry_target(entry), 0);
>  	else
> -		patch_instruction(addr, ppc_inst(PPC_RAW_NOP()));
> +		err = patch_instruction(addr, ppc_inst(PPC_RAW_NOP()));
> +
> +	if (err)
> +		panic("%s: patching failed, err %d, type %d, addr %pS, target %pS\n",
> +		      __func__, err, type, addr, (void *)jump_entry_target(entry));
>  }

arch_jump_label_transform() is mainly getting called from
__jump_level_update() and it's used for enabling or updating static keys / branch.

But static keys can also be used by drivers / module subsystem whose
initialization happens late. Although I understand that if the above
fails, it might fail much before, from the arch setup code itself, but
panic() still feels like a big hammer.

Would pr_err() print with WARN_ON_ONCE(1) would suffice in case of an
err?

Also you said you ran into a problem at just one call site where above
was silently failing. With the above change are you able to hit the
panic() now? Because from what I see in patch_instruction(), it mainly
will boil down to calling __patch_mem() which always returns 0.
Although there are other places where there can be an error returned,
so I was wondering if that is what you were hitting or something else?

-ritesh

> -- 
> 2.51.0

