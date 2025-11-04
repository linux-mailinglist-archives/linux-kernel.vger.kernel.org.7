Return-Path: <linux-kernel+bounces-884802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC14C312F9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DBD4617EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54662F8BC3;
	Tue,  4 Nov 2025 13:14:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB85C2F659C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262060; cv=none; b=joV+GKYvrHBgy+IfRyE4KWHvCEKA4tHnn7cb8p8Pr2o8x9scqYXVkq3F0UcW8LtbrXfftfLBP+KpGb6bKSe3/JDBDMFF9ORbjU/HtNqiLLjU3aB74D4LbrTwazrf3elaC13m/3poK+utWyYHyk17bT4WxgjvszdvBluiLmN4Amg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262060; c=relaxed/simple;
	bh=ntRz6jITIbBBBGOIaf9xFjE4nod5orCM61laMH9WhBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6v/LMvW7AThTvVsVPJDGdwSPrWNlmymmoAIZj+W2KQpHrPkb7EKEazsRgRc2Ob3wHOiEp4G+nnM4xPClDAztkKToV1VIbxp9ot4hmyPTV8QlFOQv+BfE+Xl4jHCmbSiawKGOMrU+AVActiS3MBCOUyRQYNGguaMO134Ji96mxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11CDA1CE0;
	Tue,  4 Nov 2025 05:14:10 -0800 (PST)
Received: from [10.1.31.224] (XHFQ2J9959.cambridge.arm.com [10.1.31.224])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC0DE3F66E;
	Tue,  4 Nov 2025 05:14:16 -0800 (PST)
Message-ID: <b5b978f3-bb29-4cbc-b006-fb9c4402b067@arm.com>
Date: Tue, 4 Nov 2025 13:14:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: kprobes: check the return value of
 set_memory_rox()
Content-Language: en-GB
To: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251103194505.4077265-1-yang@os.amperecomputing.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251103194505.4077265-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/11/2025 19:45, Yang Shi wrote:
> Since commit a166563e7ec3 ("arm64: mm: support large block mapping when
> rodata=full"), __change_memory_common has more chance to fail due to
> memory allocation fialure when splitting page table. So check the return
> value of set_memory_rox(), then bail out if it fails otherwise we may have
> RW memory mapping for kprobes insn page.
> 
> Fixes: 195a1b7d8388 ("arm64: kprobes: call set_memory_rox() for kprobe page")
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>

This patch looks correct so:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

but, I think I see an separate issue below...

> ---
> I actually epxected 195a1b7d8388 ("arm64: kprobes: call set_memory_rox()
> for kprobe page") can be merged in 6.17-rcX, so I just restored it to
> before commit 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in
> alloc_insn_page"), however it turned out to be merged in 6.18-rc1 and it
> is after commit a166563e7ec3 ("arm64: mm: support large block mapping when
> rodata=full"). So I made the fix tag point to it.
> And I don't think we need to backport this patch to pre-6.18.
> 
>  arch/arm64/kernel/probes/kprobes.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 8ab6104a4883..43a0361a8bf0 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -49,7 +49,10 @@ void *alloc_insn_page(void)
>  	addr = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
>  	if (!addr)
>  		return NULL;
> -	set_memory_rox((unsigned long)addr, 1);
> +	if (set_memory_rox((unsigned long)addr, 1)) {

How does x get cleared when freeing this memory? arm64's set_memory_x() sets
PTE_MAYBE_GP and clears PTE_PXN. The only function that will revert that is
set_memory_nx(). But that only gets called from module_enable_data_nx() (which I
don't think is applicable here) and execmem_force_rw() - but only if
CONFIG_ARCH_HAS_EXECMEM_ROX is enabled, which I don't think it is for arm64?

So I think once we flip a page executable, it will be executable forever?

Do we need to modify set_direct_map_default_noflush() to make the memory nx?
Then vm_reset_perms() will fix it up at vfree time?

Thanks,
Ryan

> +		execmem_free(addr);
> +		return NULL;
> +	}
>  	return addr;
>  }
>  


