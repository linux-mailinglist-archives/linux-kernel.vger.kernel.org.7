Return-Path: <linux-kernel+bounces-827977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F71B93944
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43F507B1719
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17C52FB98D;
	Mon, 22 Sep 2025 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L2GvIUii"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF4F27A906
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583658; cv=none; b=Q2wmoSVlHDFbTHyg/aJm1eAi9Zc3SDrT7/merkgWEAQl7h1iIRr1Bbm7jJITVP8U1horGTKpB58NR+q9hDiWy7Ke1PT5M6LOTaZ+v3NfShXSJPSV7m/wSgtCl16X5aac5e0/htwVyoDQgbB+qNFM62JjTtqD6v0r4tTXwEvBinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583658; c=relaxed/simple;
	bh=ZXX+CFA0G/zoD33DMEjaMH/vL172/ljPCfyp5hx8hHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmElCflW5v7MgHdhDb9sGdILdyfMxFg9HU86Ipl5cLY31APC30G292WiEeCJC88JhlgCS54ynCCXTjZE625d91W0t+b9wKRLP6UsAtF0IiRnYg51ZeuPDTu7dJzVM03L+L79mCqkQFMJ5aaCWpwGgbKDEC55IBBNSFb/KKCj/KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L2GvIUii; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Sep 2025 16:27:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758583644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dq7+iioGGBjdY4sZUiiwAdtrKxyUAcd9xWPR2FHx19w=;
	b=L2GvIUiiyYrNMbg/rAqi2PZY32HhmJC1v8/9oNKOpk0DSAxUJSxTSE5F/EiqZfPx4CpGmh
	bl0OxUFnk/j4FYgOmLza+Znwlrh0zg1DjJN5firsACIogIVIu1CTxTC1d322T7mC/krIOI
	ChBHzIZcP7FoSBkjhM/EkTC97tUUGQE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Priscilla Lam <prl@amazon.com>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, dwmw@amazon.co.uk, gurugubs@amazon.com,
	christoffer.dall@arm.com, graf@amazon.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Implement KVM_TRANSLATE ioctl for arm64
Message-ID: <aNHbUqTi4nOK_w5I@linux.dev>
References: <20250922202452.45810-1-prl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922202452.45810-1-prl@amazon.com>
X-Migadu-Flow: FLOW_OUT

Hi Priscilla,

On Mon, Sep 22, 2025 at 01:24:52PM -0700, Priscilla Lam wrote:
> There is a KVM_TRANSLATE ioctl for x86 to translate a GVA
> (guest virtual address) to a GPA (guest physical address) in EL1
> which is not yet implemented for arm64.
> 
> Implement KVM_TRANSLATE on arm64 for both configurations that
> support and do not support VHE. The VHE path uses the AT
> instruction directly while the non-VHE implementation wraps the
> AT call in a hypercall to allow for its execution in EL2. Add
> selftest that tests the ioctl in both configurations.
> 
> Signed-off-by: Priscilla Lam <prl@amazon.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h              |   2 +
>  arch/arm64/kvm/guest.c                        |  89 ++++++++++++++-
>  arch/arm64/kvm/hyp/nvhe/Makefile              |   3 +-
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  10 ++
>  arch/arm64/kvm/hyp/nvhe/translate.c           |  84 ++++++++++++++
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  tools/testing/selftests/kvm/arm64/translate.c | 107 ++++++++++++++++++

Please do selftests changes in a separate patch.

> +static int kvm_translate_vhe(struct kvm_vcpu *vcpu, struct kvm_translation *tr)

So arch/arm64/kvm/at.c exists for this exact purpose: walking guest page
tables. While it was previously constrained to handling NV-enabled VMs,
Marc's SEA TTW series opens up the stage-1 walker for general use.

I am not keen on adding yet another page-table walker implementation for
the sole purpose of servicing this ioctl.

https://lore.kernel.org/kvmarm/175845226586.1792635.11249464012956393475.b4-ty@kernel.org

> +{
> +	unsigned long flags;
> +	uint64_t hcr_old, hcr_new, par;
> +	const uint64_t gva = tr->linear_address;

"linear_address" is a delightful x86-ism. I'd prefer naming that was
either architecture-generic -or- an arm64-specific struct that used our
architectural terms.

> +	preempt_disable();
> +	local_irq_save(flags);
> +
> +	/* Ensure we're in the expected VHE regime and enable S2 so PAR returns IPA. */
> +	hcr_old = read_sysreg(hcr_el2);
> +	hcr_new = hcr_old | HCR_E2H | HCR_VM;
> +	hcr_new &= ~HCR_TGE;
> +	write_sysreg(hcr_new, hcr_el2);
> +	isb();

Thanks to borken hardware, this needs to go through the write_sysreg_hcr()
accessor.

> +
> +	/* Load guest EL1 S1 context into *_EL12 (do not write into _EL1). */
> +	write_sysreg_s(vcpu_read_sys_reg(vcpu, TTBR0_EL1), SYS_TTBR0_EL12);
> +	write_sysreg_s(vcpu_read_sys_reg(vcpu, TTBR1_EL1), SYS_TTBR1_EL12);
> +	write_sysreg_s(vcpu_read_sys_reg(vcpu, TCR_EL1), SYS_TCR_EL12);
> +	write_sysreg_s(vcpu_read_sys_reg(vcpu, MAIR_EL1), SYS_MAIR_EL12);
> +	write_sysreg_s(vcpu_read_sys_reg(vcpu, SCTLR_EL1), SYS_SCTLR_EL12);

KVM supports both FEAT_S1PIE and FEAT_S1POE, so this is not a complete
MMU context.

> +	/* Check address read */
> +	asm volatile("at s1e1r, %0" :: "r"(gva));
> +	isb();

The AT instruction can generate an exception, which is why __kvm_at()
exists.

And this is where reusing the existing translation infrastructure is
really important. The AT instruction *will* fail if the stage-1
translation tables are unmapped at stage-2. The only option at that
point is falling back to a software table walker that potentially faults
in the missing translation tables.

> +
> +	par = read_sysreg(par_el1);
> +	if (!(par & 1)) {
> +		tr->valid = true;
> +		tr->physical_address = par_to_ipa(par, gva);

What about permissions besides RW?

> +int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu, struct kvm_translation *tr)
> +{
> +	if (has_vhe())
> +		return kvm_translate_vhe(vcpu, tr);
> +	else
> +		return kvm_translate_nvhe(vcpu, tr);
>  }

Yet another interesting consideration around this entire infrastructure
is the guest's view of the translation that the VMM will now use. KVM uses a
pseudo-TLB for the guest's VNCR page and maintains it just like a literal
TLB.

How would the guest invalidate the translation fetched by the VMM when
unmapping/remapping the VA? Doesn't the stage-1 PTW need to set the
Access flag as this amounts to a TLB fill?

Understanding what it is you're trying to accomplish would be quite
helpful. I'm concerned this trivializes some of the gory details of
participating in the guest's virtual memory.

Thanks,
Oliver

