Return-Path: <linux-kernel+bounces-862408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAD7BF5355
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3292B3A5CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9403016F9;
	Tue, 21 Oct 2025 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P1qcbKaQ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102222F9998
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761034740; cv=none; b=fN8VLocG2huqXHaIKkzCQ7rVdSJscda62KsVAg3UpFobaAiVTevYm2ZsCSvGtfXviccOCYwt5rL8g2jenPK0PRtmTJ5mzjMGBH2eBS7c1wdBKYFfM+hCmwYrIjoKMHl3FFzozefx3EdhJDh/gMB/p76iA75cw+v6T2+WhfneT6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761034740; c=relaxed/simple;
	bh=zoeqtV3NnoVo3PA6cGT6899ushddTj4EG2RgqFSrRLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLhWwBG6YkIJy4Xk7Y4DqwMJcli7ewT1c8Z0ivqLANoYED2cWd7XcwOu25zwtIr8h+HUyKmxqZCOe5QpDs64v10M9WheDhmohUUka8v7CNmng0X/1H88XndkAMZ0QfBgnuucOCLnFFDM1cOKx2yznJcYlUN1d4sbSHz8tZdynUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P1qcbKaQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L0bOeV001179;
	Tue, 21 Oct 2025 08:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L9fBm/
	Whek+136auQz9DyT244vveoKj6ZQ7dh5ArAbg=; b=P1qcbKaQ8uXHTxSPk5ISZ5
	4zlMXuZkCNkBMa/lfDrCZi7wwseJyzambA/shqMej2li3c7tfhGc3G0VIY4kK9SE
	uL/TK8Uab+6nLbQ+8DWGLSvdacU1Kpc8a2nZ0lfpxBYx1ZOtFv9LwxWblxDQCUbj
	ZPtzMND51yL/kQshJmQGZOe5jZEy47lUzQtKzzvlC2QdPRLZcLjO05Ygs0km51Aw
	Z0tL5G8y3A9LFQCHIXwZT5dqbZMv9+vZuV+pS5TkZYcTo6sC8i2JOweT/31skrM7
	Tq38csvhH1QcXE6Epi6yBKoF6r9kQkN7IvXeKBtaGrHDl+YUoGAgiUNsSvwZ5dgw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33f5urg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 08:18:40 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59L8HP4m000378;
	Tue, 21 Oct 2025 08:18:40 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33f5ur9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 08:18:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L88ZDa024953;
	Tue, 21 Oct 2025 08:18:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqjspwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 08:18:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59L8Ib1x49873330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 08:18:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0353820043;
	Tue, 21 Oct 2025 08:18:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D11520040;
	Tue, 21 Oct 2025 08:18:34 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.24.196])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Oct 2025 08:18:34 +0000 (GMT)
Date: Tue, 21 Oct 2025 13:48:31 +0530
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
Message-ID: <aPdBpqhm3JHvKIWJ@linux.ibm.com>
References: <20251018-ppc-fix-lld-interp-v1-1-a083de6dccc9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251018-ppc-fix-lld-interp-v1-1-a083de6dccc9@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f741e0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=CCpqsmhAAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=FAP-1WBkK2k5Bz30Sn0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ul9cdbp4aOFLsgKbc677:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: PUznJ_3OC0JPYd9aU5zX_VlguL7hWr96
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX2NN4/pHCUp6m
 IUj9VOSHR3Vs497FgOot7qomd0Pc9yaTtu5BDqpcXPmlitueloi0Cb4zV+60D44yufbgI9uab5O
 3wLXQtsBLWzTxNUcY4omsb0HovyW6zNVXSMMCnkTRpEgouETDUb/8iJxpet5xueVCR/VL9BEwcz
 psb3Pmb2dh32kvIfTGlWacNbJcR5VSAEduCdSfk5RjdwgR4uzDFVfcd9bIO0GRWshIHrYPd6FBK
 hvyMq/uMscveGxnHOFhwGPi1ekr4kI6WUIrfZ4p/OxfMkcpCDvIrbEtJrJQYsL5dSO68/5xfMEN
 dYVrR7gz6oarwwfwRncmM8or6mrMbSm8HdRN2q1TrvVtAmpiqPAoGH3O0j3XRst/rlbLZw0vNao
 8y3XasGZEPRTVe+vihZzfZysmjVzHQ==
X-Proofpoint-ORIG-GUID: 7lS_-1FnU6zD-yPA5X_Ge0v5bGE8S3z-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Sat, Oct 18, 2025 at 06:52:40PM +0100, Nathan Chancellor wrote:
> Commit da30705c4621 ("arch/powerpc: Remove .interp section in vmlinux")
> intended to drop the .interp section from vmlinux but even with this
> change, relocatable kernels linked with ld.lld contain an empty .interp
> section, which ends up causing crashes in GDB [1].
> 
>   $ make -skj"$(nproc)" ARCH=powerpc LLVM=1 clean pseries_le_defconfig vmlinux
> 
>   $ llvm-readelf -S vmlinux | grep interp
>     [44] .interp           PROGBITS        c0000000021ddb34 21edb34 000000 00   A  0   0  1
> 
> There appears to be a subtle difference between GNU ld and ld.lld when
> it comes to discarding sections that specify load addresses [2].
> 
> Since '--no-dynamic-linker' prevents emission of the .interp section,
> there is no need to describe it in the output sections of the vmlinux
> linker script. Drop the .interp section description from vmlinux.lds.S
> to avoid this issue altogether.
> 
> Link: https://sourceware.org/bugzilla/show_bug.cgi?id=33481 [1]
> Link: https://github.com/ClangBuiltLinux/linux/issues/2137 [2]
> Reported-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Closes: https://lore.kernel.org/20251013040148.560439-1-vishalc@linux.ibm.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/powerpc/kernel/vmlinux.lds.S | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index de6ee7d35cff..15850296c0a9 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -330,7 +330,6 @@ SECTIONS
>  	}
>  	.hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }
>  	.gnu.hash : AT(ADDR(.gnu.hash) - LOAD_OFFSET) { *(.gnu.hash) }
> -	.interp : AT(ADDR(.interp) - LOAD_OFFSET) { *(.interp) }
>  	.rela.dyn : AT(ADDR(.rela.dyn) - LOAD_OFFSET)
>  	{
>  		__rela_dyn_start = .;
> 
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251018-ppc-fix-lld-interp-1a78c361cd42
> 

With this patch, I don't see .interp section being emitted the final
vmlinux binary.

```
(i) ❯ make LLVM=1 vmlinux
(i) ❯ llvm-readelf -p .comment vmlinux

String dump of section '.comment':
[     1] clang version 22.0.0git (https://github.com/llvm/llvm-project.git 7314565281ec28b745502c3f429fd431e16673eb)
[    6d] Linker: LLD 22.0.0 (https://github.com/llvm/llvm-project.git 7314565281ec28b745502c3f429fd431e16673eb)

(i) ❯ llvm-readelf -p .interp vmlinux
llvm-readelf: warning: 'vmlinux': could not find section '.interp'
```

Tested-by: Vishal Chourasia <vishalc@linux.ibm.com>

