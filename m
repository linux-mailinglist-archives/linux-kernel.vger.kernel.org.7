Return-Path: <linux-kernel+bounces-786204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721B0B35680
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C045B201A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4B9285418;
	Tue, 26 Aug 2025 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YT4UpLWN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E6F19D081
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196147; cv=none; b=sknN8IRehotDW2alPueloS6Gtn95IJbhzrU6OKvKBuxFoJaxT1PpWnQQUrHaHaZNznBHLKU56NW8Yr8R6R1OofeaRwkNglhIJ1lczD16lXpq8NTrugxJEZZ4ywflHCgPawfE2dS6eCwmzf0x6TgFSfTlf77eeq7i8wEapMM78yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196147; c=relaxed/simple;
	bh=5ZpyMblazpdXFRmcHC0bOfHLfPG+M1uAM1UjX97bwkM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usGmju0Su79LRC+nmUDPTXucfduRZbQtrXi3s6taIJl96fHyYyPzY76OmEHzAG3L5LE733zpymuIq1uKsg9n3OrtFF9KfA2nNLR0Rb6ngkzJzLYsDw5SeUM28RJ2QE9jhjhiqPWe0nApw59C4ckinB6LnE8KHNWg/UZcbQGznm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YT4UpLWN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q4MQS0020705;
	Tue, 26 Aug 2025 08:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QkrFFeLETaqUcgl2RWu3Vm4u
	63U+mrGd37t/D0+7cP0=; b=YT4UpLWNgyhK4FxZY/7KYcjFG26iaq6zpijKQN1J
	sqjxsjQ8RDllw/YmrRRU5GrMonjfE6E4072aigkmvvrntdmWFW6Tv0UcnBg+Inws
	gWCD3/HWlt9VTFIAmIRkVC/MPL6T5lKDT4rUczWkS6XjD+05doBAtHxsnaFjkuYG
	YxEl64PjjwuAMN0Czy3jDC1aayyTYh5wGkIJS4Sx16rLyNWzraaVgCUJBeVymOPS
	XrJLUaHzpQFuHroro4pDtrNBcrvUpj04FhF6+XlX0aM5nI9Voc7D6bgoHyU+iZiP
	vsVq1uoujFj2jRRIP6O0R0f6yeX5WoeksaOEv69N9HRAOg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x882ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 08:14:54 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57Q8Er0W014651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 08:14:53 GMT
Received: from hu-jiangenj-sha.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 26 Aug 2025 01:14:50 -0700
Date: Tue, 26 Aug 2025 16:14:47 +0800
From: Joey Jiao <quic_jiangenj@quicinc.com>
To: Alexander Potapenko <glider@google.com>
CC: <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <x86@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
        Aleksandr Nogikh
	<nogikh@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Borislav Petkov
	<bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar
	<mingo@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
        Marco Elver
	<elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner
	<tglx@linutronix.de>
Subject: Re: [PATCH v4 05/10] kcov: x86: introduce CONFIG_KCOV_UNIQUE
Message-ID: <aK1s9zuF72Ga36JR@hu-jiangenj-sha.qualcomm.com>
References: <20250731115139.3035888-1-glider@google.com>
 <20250731115139.3035888-6-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250731115139.3035888-6-glider@google.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oQoaVk98TRuas7EobfPX8KtPJfo6az_l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfXywhCum6fZjGw
 RmYCSlBXOvkn6xV8cteZ/Cw3qCzKpjVxc+FwRC7RiAQDW7P/Cgh7Ran100r3fdUp2W+bneWSkK+
 h4SQR1Adg6HpusaeYsontEONr7z5HSsAhYwOpFDvTHig5eVGE6A024S5wRQOoPB4BhKswIMdVCZ
 ch+5vg69BkwzW75/X0jQ0sjfdvbeSLxdmUoKy7BfHuCeCjDip89m61NTH2HGdDJE5/J4J/EbOOM
 QmRCzYagkhxH7KF9GLjATkzxQyFw7h4SZo+ZBZ47LyohS918fwpWHSkTfmd6HeMOzlT0+G53hMr
 3vGmEi8rY/N2T3B/qC1MwPjZBS3X0YZ+PSf53zv6I1Sy9tW17bsYW/hbZNJ6iZpM9q19CUiA0Hj
 +qwOqN/w
X-Proofpoint-GUID: oQoaVk98TRuas7EobfPX8KtPJfo6az_l
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68ad6cfe cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=Twlkf-z8AAAA:8
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=5XT1vE8ebdrwWjwh30IA:9 a=CjuIK1q_8ugA:10
 a=gIUsDA97qKwA:10 a=-74SuR6ZdpOK_LpdRCUo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044

On Thu, Jul 31, 2025 at 01:51:34PM +0200, Alexander Potapenko wrote:
> The new config switches coverage instrumentation to using
>   __sanitizer_cov_trace_pc_guard(u32 *guard)
> instead of
>   __sanitizer_cov_trace_pc(void)
> 
> This relies on Clang's -fsanitize-coverage=trace-pc-guard flag [1].
> 
> Each callback receives a unique 32-bit guard variable residing in .bss.
> Those guards can be used by kcov to deduplicate the coverage on the fly.
> 
> As a first step, we make the new instrumentation mode 1:1 compatible
> with the old one.
> 
> [1] https://clang.llvm.org/docs/SanitizerCoverage.html#tracing-pcs-with-guards
> 
> Cc: x86@kernel.org
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> ---
> v4:
>  - add Reviewed-by: Dmitry Vyukov
> 
> v3:
>  - per Dmitry Vyukov's request, add better comments in
>    scripts/module.lds.S and lib/Kconfig.debug
>  - add -sanitizer-coverage-drop-ctors to scripts/Makefile.kcov
>    to drop the unwanted constructors emitting unsupported relocations
>  - merge the __sancov_guards section into .bss
> 
> v2:
>  - Address comments by Dmitry Vyukov
>    - rename CONFIG_KCOV_ENABLE_GUARDS to CONFIG_KCOV_UNIQUE
>    - update commit description and config description
>  - Address comments by Marco Elver
>    - rename sanitizer_cov_write_subsequent() to kcov_append_to_buffer()
>    - make config depend on X86_64 (via ARCH_HAS_KCOV_UNIQUE)
>    - swap #ifdef branches
>    - tweak config description
>    - remove redundant check for CONFIG_CC_HAS_SANCOV_TRACE_PC_GUARD
> 
> Change-Id: Iacb1e71fd061a82c2acadf2347bba4863b9aec39
> ---
>  arch/x86/Kconfig                  |  1 +
>  arch/x86/kernel/vmlinux.lds.S     |  1 +
>  include/asm-generic/vmlinux.lds.h | 13 ++++++-
>  include/linux/kcov.h              |  2 +
>  kernel/kcov.c                     | 61 +++++++++++++++++++++----------
>  lib/Kconfig.debug                 | 26 +++++++++++++
>  scripts/Makefile.kcov             |  7 ++++
>  scripts/module.lds.S              | 35 ++++++++++++++++++
>  tools/objtool/check.c             |  1 +
>  9 files changed, 126 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 8bed9030ad473..0533070d24fe7 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -94,6 +94,7 @@ config X86
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_KCOV			if X86_64
> +	select ARCH_HAS_KCOV_UNIQUE		if X86_64
>  	select ARCH_HAS_KERNEL_FPU_SUPPORT
>  	select ARCH_HAS_MEM_ENCRYPT
>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 4fa0be732af10..52fe6539b9c91 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -372,6 +372,7 @@ SECTIONS
>  		. = ALIGN(PAGE_SIZE);
>  		*(BSS_MAIN)
>  		BSS_DECRYPTED
> +		BSS_SANCOV_GUARDS
>  		. = ALIGN(PAGE_SIZE);
>  		__bss_stop = .;
>  	}
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index fa5f19b8d53a0..ee78328eecade 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -102,7 +102,8 @@
>   * sections to be brought in with rodata.
>   */
>  #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG) || \
> -defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
> +	defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG) || \
> +	defined(CONFIG_KCOV_UNIQUE)
>  #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
>  #else
>  #define TEXT_MAIN .text
> @@ -121,6 +122,16 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>  #define SBSS_MAIN .sbss
>  #endif
>  
> +#if defined(CONFIG_KCOV_UNIQUE)
> +/* BSS_SANCOV_GUARDS must be part of the .bss section so that it is zero-initialized. */
> +#define BSS_SANCOV_GUARDS			\
> +	__start___sancov_guards = .;		\
> +	*(__sancov_guards);			\
> +	__stop___sancov_guards = .;
> +#else
> +#define BSS_SANCOV_GUARDS
> +#endif
> +
>  /*
>   * GCC 4.5 and later have a 32 bytes section alignment for structures.
>   * Except GCC 4.9, that feels the need to align on 64 bytes.
> diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> index 2b3655c0f2278..2acccfa5ae9af 100644
> --- a/include/linux/kcov.h
> +++ b/include/linux/kcov.h
> @@ -107,6 +107,8 @@ typedef unsigned long long kcov_u64;
>  #endif
>  
>  void __sanitizer_cov_trace_pc(void);
> +void __sanitizer_cov_trace_pc_guard(u32 *guard);
> +void __sanitizer_cov_trace_pc_guard_init(uint32_t *start, uint32_t *stop);
>  void __sanitizer_cov_trace_cmp1(u8 arg1, u8 arg2);
>  void __sanitizer_cov_trace_cmp2(u16 arg1, u16 arg2);
>  void __sanitizer_cov_trace_cmp4(u32 arg1, u32 arg2);
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 5170f367c8a1b..8154ac1c1622e 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -194,27 +194,15 @@ static notrace unsigned long canonicalize_ip(unsigned long ip)
>  	return ip;
>  }
>  
> -/*
> - * Entry point from instrumented code.
> - * This is called once per basic-block/edge.
> - */
> -void notrace __sanitizer_cov_trace_pc(void)
> +static notrace void kcov_append_to_buffer(unsigned long *area, int size,
> +					  unsigned long ip)
>  {
> -	struct task_struct *t;
> -	unsigned long *area;
> -	unsigned long ip = canonicalize_ip(_RET_IP_);
> -	unsigned long pos;
> -
> -	t = current;
> -	if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
> -		return;
> -
> -	area = t->kcov_state.area;
>  	/* The first 64-bit word is the number of subsequent PCs. */
> -	pos = READ_ONCE(area[0]) + 1;
> -	if (likely(pos < t->kcov_state.size)) {
> -		/* Previously we write pc before updating pos. However, some
> -		 * early interrupt code could bypass check_kcov_mode() check
> +	unsigned long pos = READ_ONCE(area[0]) + 1;
> +
> +	if (likely(pos < size)) {
> +		/*
> +		 * Some early interrupt code could bypass check_kcov_mode() check
>  		 * and invoke __sanitizer_cov_trace_pc(). If such interrupt is
>  		 * raised between writing pc and updating pos, the pc could be
>  		 * overitten by the recursive __sanitizer_cov_trace_pc().
> @@ -225,7 +213,40 @@ void notrace __sanitizer_cov_trace_pc(void)
>  		area[pos] = ip;
>  	}
>  }
> +
> +/*
> + * Entry point from instrumented code.
> + * This is called once per basic-block/edge.
> + */
> +#ifdef CONFIG_KCOV_UNIQUE
> +void notrace __sanitizer_cov_trace_pc_guard(u32 *guard)
> +{
> +	if (!check_kcov_mode(KCOV_MODE_TRACE_PC, current))
> +		return;
> +
> +	kcov_append_to_buffer(current->kcov_state.area,
> +			      current->kcov_state.size,
> +			      canonicalize_ip(_RET_IP_));
> +}
> +EXPORT_SYMBOL(__sanitizer_cov_trace_pc_guard);
> +
> +void notrace __sanitizer_cov_trace_pc_guard_init(uint32_t *start,
> +						 uint32_t *stop)
> +{
> +}
> +EXPORT_SYMBOL(__sanitizer_cov_trace_pc_guard_init);
> +#else /* !CONFIG_KCOV_UNIQUE */
> +void notrace __sanitizer_cov_trace_pc(void)
> +{
> +	if (!check_kcov_mode(KCOV_MODE_TRACE_PC, current))
> +		return;
> +
> +	kcov_append_to_buffer(current->kcov_state.area,
> +			      current->kcov_state.size,
> +			      canonicalize_ip(_RET_IP_));
> +}
>  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
> +#endif
>  
>  #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
>  static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
> @@ -253,7 +274,7 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>  	start_index = 1 + count * KCOV_WORDS_PER_CMP;
>  	end_pos = (start_index + KCOV_WORDS_PER_CMP) * sizeof(u64);
>  	if (likely(end_pos <= max_pos)) {
> -		/* See comment in __sanitizer_cov_trace_pc(). */
> +		/* See comment in kcov_append_to_buffer(). */
>  		WRITE_ONCE(area[0], count + 1);
>  		barrier();
>  		area[start_index] = type;
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ebe33181b6e6e..a7441f89465f3 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2153,6 +2153,12 @@ config ARCH_HAS_KCOV
>  	  build and run with CONFIG_KCOV. This typically requires
>  	  disabling instrumentation for some early boot code.
>  
> +config CC_HAS_SANCOV_TRACE_PC
> +	def_bool $(cc-option,-fsanitize-coverage=trace-pc)
> +
> +config CC_HAS_SANCOV_TRACE_PC_GUARD
> +	def_bool $(cc-option,-fsanitize-coverage=trace-pc-guard)
> +
>  config KCOV
>  	bool "Code coverage for fuzzing"
>  	depends on ARCH_HAS_KCOV
> @@ -2166,6 +2172,26 @@ config KCOV
>  
>  	  For more details, see Documentation/dev-tools/kcov.rst.
>  
> +config ARCH_HAS_KCOV_UNIQUE
> +	bool
> +	help
> +	  An architecture should select this when it can successfully
> +	  build and run with CONFIG_KCOV_UNIQUE.
> +
> +config KCOV_UNIQUE
> +	depends on KCOV
> +	depends on CC_HAS_SANCOV_TRACE_PC_GUARD && ARCH_HAS_KCOV_UNIQUE
> +	bool "Enable unique program counter collection mode for KCOV"
> +	help
> +	  This option enables KCOV's unique program counter (PC) collection mode,
> +	  which deduplicates PCs on the fly when the KCOV_UNIQUE_ENABLE ioctl is
> +	  used.
> +
> +	  This significantly reduces the memory footprint for coverage data
> +	  collection compared to trace mode, as it prevents the kernel from
> +	  storing the same PC multiple times.
> +	  Enabling this mode incurs a slight increase in kernel binary size.
> +
>  config KCOV_ENABLE_COMPARISONS
>  	bool "Enable comparison operands collection by KCOV"
>  	depends on KCOV
> diff --git a/scripts/Makefile.kcov b/scripts/Makefile.kcov
> index 78305a84ba9d2..c3ad5504f5600 100644
> --- a/scripts/Makefile.kcov
> +++ b/scripts/Makefile.kcov
> @@ -1,5 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +ifeq ($(CONFIG_KCOV_UNIQUE),y)
> +kcov-flags-y					+= -fsanitize-coverage=trace-pc-guard
> +# Drop per-file constructors that -fsanitize-coverage=trace-pc-guard inserts by default.
> +# Kernel does not need them, and they may produce unknown relocations.
> +kcov-flags-y					+= -mllvm -sanitizer-coverage-drop-ctors
> +else
>  kcov-flags-y					+= -fsanitize-coverage=trace-pc
> +endif
>  kcov-flags-$(CONFIG_KCOV_ENABLE_COMPARISONS)	+= -fsanitize-coverage=trace-cmp
>  
>  kcov-rflags-y					+= -Cpasses=sancov-module
> diff --git a/scripts/module.lds.S b/scripts/module.lds.S
> index 450f1088d5fd3..17f36d5112c5d 100644
> --- a/scripts/module.lds.S
> +++ b/scripts/module.lds.S
> @@ -47,6 +47,7 @@ SECTIONS {
>  	.bss : {
>  		*(.bss .bss.[0-9a-zA-Z_]*)
>  		*(.bss..L*)
> +		*(__sancov_guards)
This line looks like redundant?
I can boot without it both normal build and kasan build.
>  	}
>  
>  	.data : {
> @@ -64,6 +65,40 @@ SECTIONS {
>  		MOD_CODETAG_SECTIONS()
>  	}
>  #endif
> +
> +#ifdef CONFIG_KCOV_UNIQUE
> +	/*
> +	 * CONFIG_KCOV_UNIQUE creates COMDAT groups for instrumented functions,
> +	 * which has the following consequences in the presence of
> +	 * -ffunction-sections:
> +	 *  - Separate .init.text and .exit.text sections in the modules are not
> +	 *    merged together, which results in errors trying to create
> +	 *    duplicate entries in /sys/module/MODNAME/sections/ at module load
> +	 *    time.
> +	 *  - Each function is placed in a separate .text.funcname section, so
> +	 *    there is no .text section anymore. Collecting them together here
> +	 *    has mostly aesthetic purpose, although some tools may be expecting
> +	 *    it to be present.
> +	 */
> +	.text : {
> +		*(.text .text.[0-9a-zA-Z_]*)
> +		*(.text..L*)
> +	}
> +	.init.text : {
> +		*(.init.text .init.text.[0-9a-zA-Z_]*)
> +		*(.init.text..L*)
> +	}
> +	.exit.text : {
> +		*(.exit.text .exit.text.[0-9a-zA-Z_]*)
> +		*(.exit.text..L*)
> +	}
> +	.bss : {
> +		*(.bss .bss.[0-9a-zA-Z_]*)
> +		*(.bss..L*)
> +		*(__sancov_guards)
Need to include __start___sancov_guards and __stop___sancov_guards to treat them as local,
otherwise it won't boot on aarch64, error like:
Modules: module proxy_consumer: overflow in relocation type 311 val 0.

So, finally it should look like:
	__start___sancov_guards = .;
	*(__sancov_guards)
	__stop___sancov_guards = .;
> +	}
> +#endif
> +
>  	MOD_SEPARATE_CODETAG_SECTIONS()
>  }
>  
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 67d76f3a1dce5..60eb5faa27d28 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1156,6 +1156,7 @@ static const char *uaccess_safe_builtin[] = {
>  	"write_comp_data",
>  	"check_kcov_mode",
>  	"__sanitizer_cov_trace_pc",
> +	"__sanitizer_cov_trace_pc_guard",
>  	"__sanitizer_cov_trace_const_cmp1",
>  	"__sanitizer_cov_trace_const_cmp2",
>  	"__sanitizer_cov_trace_const_cmp4",
> -- 
> 2.50.1.552.g942d659e1b-goog
> 

