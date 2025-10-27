Return-Path: <linux-kernel+bounces-870993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B29C0C2D9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB0018931BF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794882E1C64;
	Mon, 27 Oct 2025 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="In2uTG/Q"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EB72E0B6E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761551213; cv=none; b=ZQ72ocPN3jDWbEYgy2Kjlq2NRTESeswa1xA5prK4VNvSI8l7H7c9kmEP1Iust+y3N2t2OYDEaNGZMu7MJEzg7SBxC+Tzwmk64dtNEZHL2kZ1zIcPww0C6a5zaehA64ddl6EiH9JorLVreHeK7KidFouEFFEVhIL4dBH1NiNu83U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761551213; c=relaxed/simple;
	bh=m+/OpNmk9RjLKoKA8PTUeAPj9b8IhzIlOjvj/YC7iGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+2NELeiq4cfv4MohP++KXuToG/U+vS9Xwj+LTZIzBkFNh8L3NuZSpLL7ijuvZlniUbpE5Wk28ZhxiDhBGdpqmxdhOIa/TSID0BJKzhP4GcgPyJ0eimN+b2WJblDt8tUIbzXpq9Tkdl1Jo89FohFtl4p/9qvKq0qwY8YIzQNSQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=In2uTG/Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59QKrBJq009936;
	Mon, 27 Oct 2025 07:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0Y6BSf
	aXtj7eGt7emfZsnVlTLYftCSxA9NJ9tCnZ7Po=; b=In2uTG/QqQZw6G3At9CEW1
	o5ceaYJD3iPLGGHMz3C4F66zaSCcquNvfvqtVFG3oFtLLxEmA8ag8/maj0wBGW5m
	Sp3MoSpr/pR9Zs8acm6kZxjngjgLMHcWP3xxEvklW7K1v574FqYHKAb7HGXyLDwq
	eLWepCA/aRdlF2fvCmTsImCMjSoVtHlNSFaMsNAgfJTywkgoBa4sPi2n9sqiWRKq
	Wwp/zYWm2NFLIq1ToHS51zqq/ulUAU3o8nQ1QqQ4SCU8PTUI6SZPl4WuxLGb1gn2
	Ojb7Uy94v+d4bVFYSGRm4q9FqpZqPWovOeDGhANiuhuTIBU3O5qu3jhfyF7rwxTg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0myrwn13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 07:46:32 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59R7k8sl024040;
	Mon, 27 Oct 2025 07:46:32 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0myrwn10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 07:46:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59R4ILBv009477;
	Mon, 27 Oct 2025 07:46:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1b3hv7na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 07:46:30 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59R7kTI829557190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 07:46:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EBC72004B;
	Mon, 27 Oct 2025 07:46:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9695F20040;
	Mon, 27 Oct 2025 07:46:26 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.25.223])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 27 Oct 2025 07:46:26 +0000 (GMT)
Date: Mon, 27 Oct 2025 13:16:23 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] powerpc/vmlinux.lds: Drop .interp description
Message-ID: <aP8jT3XY3kQUCwFQ@linux.ibm.com>
References: <20251018-ppc-fix-lld-interp-v1-1-a083de6dccc9@kernel.org>
 <aPdBpqhm3JHvKIWJ@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPdBpqhm3JHvKIWJ@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e3amaIqOg-r1xy8SBw8NhMwTtJVzHPB9
X-Authority-Analysis: v=2.4 cv=ct2WUl4i c=1 sm=1 tr=0 ts=68ff2358 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CCpqsmhAAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=oRvyBlM1FexuHqL2RKMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ul9cdbp4aOFLsgKbc677:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMCBTYWx0ZWRfX6r4Z30l7F8Ic
 IWvJWfnaL7SNrgqgZOVWGD3V19dcWtzpr4zSgECiRKSCnm9XZnXzIXv2TN7CeoLYKR3M/KWC4RF
 QPMx3hoMR9hZOrqs21/9Q/8tRg8BKLrAjgY8eYB0BUoZFGfiixqRQv4S+FfaXcuqk3Pw7yHqoiD
 4xEir7NihCXSIZ/I0ihi8D7hH1SBidXsnMgWhZY1gWSJNZ/sCJ5c2jsRRSXdT17qEzD7qUogffI
 KGLPLQCrhoUERQqhEhJMCPshGUrwTnD9niBZw7xzo3Y7qvvNsqSirSO8Qm7BhQ2wcFHy4d+RW2a
 2J5e3NfejNarpBmvKNP7S7lTEcdExym9RvtOEM9ts7Aj02cT+tcduu5HqsKUXre8qdaIObS/Bxb
 Jf9K59fwH1PLOhxZ/lAuZ2v3jjLYog==
X-Proofpoint-GUID: EmA_x7nIdtsKpHamxbrwTQrjfcKv5Wq6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250010

ping.

what's the status for this patch?

vishalc


On Tue, Oct 21, 2025 at 01:48:31PM +0530, Vishal Chourasia wrote:
> On Sat, Oct 18, 2025 at 06:52:40PM +0100, Nathan Chancellor wrote:
> > Commit da30705c4621 ("arch/powerpc: Remove .interp section in vmlinux")
> > intended to drop the .interp section from vmlinux but even with this
> > change, relocatable kernels linked with ld.lld contain an empty .interp
> > section, which ends up causing crashes in GDB [1].
> > 
> >   $ make -skj"$(nproc)" ARCH=powerpc LLVM=1 clean pseries_le_defconfig vmlinux
> > 
> >   $ llvm-readelf -S vmlinux | grep interp
> >     [44] .interp           PROGBITS        c0000000021ddb34 21edb34 000000 00   A  0   0  1
> > 
> > There appears to be a subtle difference between GNU ld and ld.lld when
> > it comes to discarding sections that specify load addresses [2].
> > 
> > Since '--no-dynamic-linker' prevents emission of the .interp section,
> > there is no need to describe it in the output sections of the vmlinux
> > linker script. Drop the .interp section description from vmlinux.lds.S
> > to avoid this issue altogether.
> > 
> > Link: https://sourceware.org/bugzilla/show_bug.cgi?id=33481 [1]
> > Link: https://github.com/ClangBuiltLinux/linux/issues/2137 [2]
> > Reported-by: Vishal Chourasia <vishalc@linux.ibm.com>
> > Closes: https://lore.kernel.org/20251013040148.560439-1-vishalc@linux.ibm.com/
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  arch/powerpc/kernel/vmlinux.lds.S | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> > index de6ee7d35cff..15850296c0a9 100644
> > --- a/arch/powerpc/kernel/vmlinux.lds.S
> > +++ b/arch/powerpc/kernel/vmlinux.lds.S
> > @@ -330,7 +330,6 @@ SECTIONS
> >  	}
> >  	.hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }
> >  	.gnu.hash : AT(ADDR(.gnu.hash) - LOAD_OFFSET) { *(.gnu.hash) }
> > -	.interp : AT(ADDR(.interp) - LOAD_OFFSET) { *(.interp) }
> >  	.rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET)
> >  	{
> >  		__rela_dyn_start = .;
> > 
> > ---
> > base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> > change-id: 20251018-ppc-fix-lld-interp-1a78c361cd42
> > 
> 
> With this patch, I don't see .interp section being emitted the final
> vmlinux binary.
> 
> ```
> (i) ❯ make LLVM=1 vmlinux
> (i) ❯ llvm-readelf -p .comment vmlinux
> 
> String dump of section '.comment':
> [     1] clang version 22.0.0git (https://github.com/llvm/llvm-project.git 7314565281ec28b745502c3f429fd431e16673eb)
> [    6d] Linker: LLD 22.0.0 (https://github.com/llvm/llvm-project.git 7314565281ec28b745502c3f429fd431e16673eb)
> 
> (i) ❯ llvm-readelf -p .interp vmlinux
> llvm-readelf: warning: 'vmlinux': could not find section '.interp'
> ```
> 
> Tested-by: Vishal Chourasia <vishalc@linux.ibm.com>

