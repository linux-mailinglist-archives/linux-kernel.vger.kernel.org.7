Return-Path: <linux-kernel+bounces-811703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACF8B52CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E521856759B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCAA26E71F;
	Thu, 11 Sep 2025 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hbIRJvoy"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899A2E88B1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581943; cv=none; b=Ov+yxDeUgSe6Mfe/xGDkB+mXG2M5p38b07f7g8O2NjQO/S1Q+VbUFBcwHBXftOblG13AN36TkTV53rp5eSWbBXqz3/NFWshhgs/4b/3WFa9tv7CP6Y2aylKnphwdZHmqO8abwT35eIiI1lvF0d86wZdIR1OkU1a9b9POrzz+iT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581943; c=relaxed/simple;
	bh=BGsmBXzehjF13MQf30PFGpNo/vzV9SyOez+N2SR1Vog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GuwV1VyN0R9r07/E5v7xIwy/OX5dTAycFpWKl2x0o6tm0I+H3xBR++gDEGWLmDW1zeeB9o1LtODEUGAp6Bs1FrZmi1h3PA734lvC4K95n9zyoDa4xPw+BjWYvfTVnl38glRYqFTHyzZmmLf9P44VKQ+kec3wibZzwCHjiX0DL4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hbIRJvoy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2mJx7029252;
	Thu, 11 Sep 2025 09:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZLeqRFZW477Mv1AvfEJf1/Q37ynfkU
	f8aL4tvu2p3zY=; b=hbIRJvoyzPWvOj8GENPNC4ZU7a6lHWobCG+lTXfiXaPY8X
	xtWF6x4PHJDi0WY6Ib+SImKUoXwLnunApZpBLkd4+KrTdfgV6/jw3QAq7HGK8CnX
	EvGza+JDNKVD5kElBe+KhGOBuU7Z/j6UrMmLauSWQfG0zQQ+iK+nlHLLpC+vRlk+
	51gx3jAAf7nTsV0WUy+XeqqnWuMYwloVlxvuE9acEBHJtYjYAHgmPi1zWck0D8aY
	EDt/YeJj41gCshLk0s/3G67DY7VTMOowiyc6tq9H9+eTmScs5NGXPOwfKM6OkaZ2
	K6uJRikdaTMDunH6RXMeeLFWcJ2nCOuaEi3KF/yw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct2yv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 09:12:01 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58B980AY027411;
	Thu, 11 Sep 2025 09:12:00 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct2yuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 09:12:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58B6s6EN017219;
	Thu, 11 Sep 2025 09:11:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmmta4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 09:11:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58B9Bt7x57278822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 09:11:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B31A32004E;
	Thu, 11 Sep 2025 09:11:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A2422004B;
	Thu, 11 Sep 2025 09:11:55 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Sep 2025 09:11:55 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
        Heiko Carstens
 <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra
 <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun
 Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean
 Christopherson <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan
 Cui <decui@microsoft.com>, x86@kernel.org,
        Arnd Bergmann
 <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Paul Walmsley
 <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V4 33/36] s390: Use generic TIF bits
In-Reply-To: <20250908212927.373210812@linutronix.de> (Thomas Gleixner's
	message of "Mon, 8 Sep 2025 23:32:34 +0200 (CEST)")
References: <20250908212737.353775467@linutronix.de>
	<20250908212927.373210812@linutronix.de>
Date: Thu, 11 Sep 2025 11:11:55 +0200
Message-ID: <yt9dqzwds690.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfXzuSo1cpcTbgk
 Q8+CZ3acE65tVdxVMaD2cbJ6IF3SvA3O+DXswp5AIhyWqsocws1pC4C3l2BqjE5rLrRKjRep9Qy
 KdZb3OvQ9O4IWRWYSLFTMfkmko+dsxXU3PUO+JKrEwG22jaIX1ueWHM4okjFMi7Bq6a1TPBrWtJ
 HgyMBL+xUMLhOjuRckE8qkTQRo58Af5c8U9Yi630Fs9EkY674FurlJ7iI3wpP8hlgSY91brP3i6
 DdPmH84CBnoKbxbzyS/hZOQJowJmZ0Qcw3Pj1MdK6bAPhFpc6Cwj3YR7JHDSLpLUrIRYAt1fxdv
 YuBO5AAmxpYyBxLadR49ShskoQf8vL9rmw5skIKA2yJbVazkxzwX4rXgAE024d17CD4fd5+02mG
 TuPLNHFH
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c29261 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=kDN6fFDDvmrDChyy9gMA:9
X-Proofpoint-GUID: YuJHFk-KAQCBijC3eMIuVqpZ0J7WgFWf
X-Proofpoint-ORIG-GUID: wKZbnpgPHU1EuL1-8zSu5pXB-xiX9XhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

Thomas Gleixner <tglx@linutronix.de> writes:

> No point in defining generic items and the upcoming RSEQ optimizations are
> only available with this _and_ the generic entry infrastructure, which is
> already used by s390. So no further action required here.
>
> This leaves a comment about the AUDIT/TRACE/SECCOMP bits which are handled
> by SYSCALL_WORK in the generic code, so they seem redundant, but that's a
> problem for the s390 wizards to think about.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
>
> --- a/arch/s390/include/asm/thread_info.h
> +++ b/arch/s390/include/asm/thread_info.h
> @@ -56,43 +56,35 @@ void arch_setup_new_exec(void);
> [..]

> +/* These could move over to SYSCALL_WORK bits, no? */
>  #define TIF_SYSCALL_TRACE	24	/* syscall trace active */
>  #define TIF_SYSCALL_AUDIT	25	/* syscall auditing active */
>  #define TIF_SECCOMP		26	/* secure computing */
>  #define TIF_SYSCALL_TRACEPOINT	27	/* syscall tracepoint instrumentation */

Looks like these flags are a leftover of the conversion to generic
entry and are no longer used. I'll send a patch on top of your patchset
which remove them.

Thanks!
Sven

