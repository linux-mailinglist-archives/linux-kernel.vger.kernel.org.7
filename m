Return-Path: <linux-kernel+bounces-849940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C23FBD163E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034453B8C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016052C11EC;
	Mon, 13 Oct 2025 04:46:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1569F13AD26
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760330763; cv=none; b=gKuVCImKSa19mlR8KfBheEx9HarZjVb0gsBsmMEK1uziA36obOgZARrcKLrIFlAGOC05RQwd1peKtf1MHZlsGXRdf4l2EgF2Btwe51gwZJVtRhNeV6s7ynWPN9EouG9jAWsjQ1QuZjHtPXPVr9auNWCvBzGY/sRWi6wDdX2U5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760330763; c=relaxed/simple;
	bh=IQ7ECciWsqUNBg9zo///cuIUs6efITdz7uia9d93TEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L63BQmioYWl0uJgH3Qe/oyIFIu2RTP/wvs4eRhUnillrxCF6ktdxugFWPK8O0rUQGjSH6njRz0JqiiwBp0M3kG6z6y2NOFJfSJRZWh/eQdPj6Cbba51uXtG9OLgje/bb1TGaozf3o8fYNle7h2h5Iojs3oRA47JmBdbzgiSzYnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDA6D113E;
	Sun, 12 Oct 2025 21:45:45 -0700 (PDT)
Received: from [10.164.18.45] (unknown [10.164.18.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29DFA3F6A8;
	Sun, 12 Oct 2025 21:45:50 -0700 (PDT)
Message-ID: <535066e3-bd75-49df-b043-e5b0a74dc68d@arm.com>
Date: Mon, 13 Oct 2025 10:15:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch/arm64/mm/fault: Implement exceptions tracepoints
To: Balbir Singh <balbirs@nvidia.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20251013035532.1793181-1-balbirs@nvidia.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251013035532.1793181-1-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/10/25 9:25 AM, Balbir Singh wrote:
> x86 and riscv provide trace points for page-faults (user and kernel
> tracepoints). Some scripts [1],[2] rely on these trace points. The
> tracepoint is useful for tracking faults and their reasons.

Agreed.
> 
> Adding the tracepoints is simple and straight-forward. For arm64
> use esr as error code and untagged memory address as addr.

Providing the entire esr register value makes sense.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> 
> [1] https://www.brendangregg.com/FlameGraphs/memoryflamegraphs.html
> [2] https://taras.glek.net/posts/ebpf-mmap-page-fault-tracing/
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> ---
> 
> Tested at my end with a kernel-compile and running a user space
> program to check that the trace points are indeed reported.
> 
>  arch/arm64/mm/fault.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index d816ff44faff..9d7b86e92434 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -44,6 +44,9 @@
>  #include <asm/tlbflush.h>
>  #include <asm/traps.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/exceptions.h>
> +
>  struct fault_info {
>  	int	(*fn)(unsigned long far, unsigned long esr,
>  		      struct pt_regs *regs);
> @@ -572,8 +575,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  	if (faulthandler_disabled() || !mm)
>  		goto no_context;
>  
> -	if (user_mode(regs))
> +	if (user_mode(regs)) {
>  		mm_flags |= FAULT_FLAG_USER;
> +		trace_page_fault_user(addr, regs, esr);
> +	} else {
> +		trace_page_fault_kernel(addr, regs, esr);
> +	}
>  
>  	/*
>  	 * vm_flags tells us what bits we must have in vma->vm_flags

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

