Return-Path: <linux-kernel+bounces-736684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706B9B0A071
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B487A4216
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F312B299A96;
	Fri, 18 Jul 2025 10:16:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C323E21C177
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752833786; cv=none; b=EKXeLSIGCLceoKOes2w2/Px5a/Qdn0UiD7Ub8Sub0nXCcmp1DmwUfRT277d2yh946N2TDpCgjGSWjAMWBfTQ9hGjpXLQlW3RECaXB1ccdhyZewH8PPebMYNMn48F3gLfEJND/tbBKDaJbVLYJV9vXIngvfbNao88saoxNoGfRaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752833786; c=relaxed/simple;
	bh=V5dn39b32PQ8E50FCYYZaMyyfeXpMKEvoQx1bTGELfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ib7CurphriV0Shv5rPNe4MjyNEqsk7dO6Xn3gvVRer6NIZ7ZBcdYFeCcEHGN4jRgFSqY7xEXQhFcGXkqKYEi/fbttG9nXf0WznJtCM6SkCKpkRhr9PnPaWItEPGe8+mRWQunBlbQCOSE2GunVQ+dSsk2St46QuCT0FY6BMGPerI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACA17176C;
	Fri, 18 Jul 2025 03:16:15 -0700 (PDT)
Received: from [10.57.87.202] (unknown [10.57.87.202])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B71593F694;
	Fri, 18 Jul 2025 03:16:20 -0700 (PDT)
Message-ID: <38b08607-b9d9-425b-81c4-b227dda427b3@arm.com>
Date: Fri, 18 Jul 2025 11:16:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: arm64: Map hyp text as RO and dump instr on
 panic
Content-Language: en-GB
To: Mostafa Saleh <smostafa@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
 oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, qperret@google.com, keirf@google.com
References: <20250717234744.2254371-1-smostafa@google.com>
 <20250717234744.2254371-3-smostafa@google.com>
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20250717234744.2254371-3-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mostafa,

On 18/07/2025 00:47, Mostafa Saleh wrote:
> Map the hyp text section as RO, there are no secrets there
> and that allows the kernel extract info for debugging.
> 
> As in case of panic we can now dump the faulting instructions
> similar to the kernel.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>   arch/arm64/kvm/handle_exit.c    |  4 +---
>   arch/arm64/kvm/hyp/nvhe/setup.c | 12 ++++++++++--
>   2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index de12b4d4bccd..d59f33c40767 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -566,9 +566,7 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
>   	kvm_nvhe_dump_backtrace(hyp_offset);
>   
>   	/* Dump the faulting instruction */
> -	if (!is_protected_kvm_enabled() ||
> -	    IS_ENABLED(CONFIG_NVHE_EL2_DEBUG))
> -		dump_instr(panic_addr + kaslr_offset());
> +	dump_instr(panic_addr + kaslr_offset());
This makes the dumping in nvhe no longer conditional on 
CONFIG_NVHE_EL2_DEBUG. A change from what you introduced in the patch. 
Perhaps it makes sense to reorder the patches; do the preparatory work 
for instruction dumping before the enabling.>
>   	/*
>   	 * Hyp has panicked and we're going to handle that by panicking the
> diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> index a48d3f5a5afb..90bd014e952f 100644
> --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> @@ -192,6 +192,7 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
>   	enum pkvm_page_state state;
>   	struct hyp_page *page;
>   	phys_addr_t phys;
> +	enum kvm_pgtable_prot prot;
>   
>   	if (!kvm_pte_valid(ctx->old))
>   		return 0;
> @@ -210,11 +211,18 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
>   	 * configured in the hypervisor stage-1, and make sure to propagate them
>   	 * to the hyp_vmemmap state.
>   	 */
> -	state = pkvm_getstate(kvm_pgtable_hyp_pte_prot(ctx->old));
> +	prot = kvm_pgtable_hyp_pte_prot(ctx->old);
> +	state = pkvm_getstate(prot);
>   	switch (state) {
>   	case PKVM_PAGE_OWNED:
>   		set_hyp_state(page, PKVM_PAGE_OWNED);
> -		return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
> +		/* hyp text is RO in the host stage-2 to be inspected on panic. */
> +		if (prot == PAGE_HYP_EXEC) {
> +			set_host_state(page, PKVM_NOPAGE);
> +			return host_stage2_idmap_locked(phys, PAGE_SIZE, KVM_PGTABLE_PROT_R);
> +		} else {
> +			return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
> +		}
>   	case PKVM_PAGE_SHARED_OWNED:
>   		set_hyp_state(page, PKVM_PAGE_SHARED_OWNED);
>   		set_host_state(page, PKVM_PAGE_SHARED_BORROWED);
-- 
Thanks,

Ben


