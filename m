Return-Path: <linux-kernel+bounces-672463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DC8ACCFD7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 00:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9251D1897599
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 22:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D98A2522BE;
	Tue,  3 Jun 2025 22:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eRimniX8"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669738DD1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748989407; cv=none; b=U1km+h0Tf9OTeNDojBYur85fHYhyyuMU+QSJeDKlGzQl9cLbT2bLsnSwVcT5THsfWxG4cbJtvj6lNWpkfnrQ7Q4PPnUEjfcTUouJNbeDjpIzoOx6iYMTQvbcscHWHOIgOBVVrBPAzMzhyHrnDuEYe6VRtLeD+Htl8kIAE47DF7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748989407; c=relaxed/simple;
	bh=/MhTDh1qESFrZExtR+SCTFFsKrkDxVGO6OCMPivcISk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AH26o/zmGMBxfPxDyiYpu0VN8Ep/T8lKE6fzNI3u2BqFGCZ3xRQhE++uFrMYvQl5dEbwPu5L4tVOWru+vinK5xOruXIKUBOd675oUcdtzQv+sWnSf4gZxiiSJJRkNbdcgi30YaUmq4kQ+qXTkldsrD2e/0XocqEsuod89hJ6xpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eRimniX8; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 3 Jun 2025 15:22:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748989402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=niaSUpNhBQ89KPyB0pVEOrY4XFpNCP0lf6WviOejFww=;
	b=eRimniX8eSc5OSQy+LM1nI6Dhv3MYnIr4b0Kj8coGDibHna3u81l7v23qFFDHdwinARZa8
	xMuELseQUnvc+hrp9LYmF5h20GBKCGCcaLBq7LdbJM3ZbJB56zDxKeEoegbVsE5HltYeQg
	j/YwAqMYBnAAtov23jZAIUGTZntaGa8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 10/17] KVM: arm64: Writethrough trapped PMEVTYPER register
Message-ID: <aD91vp8QXdIjs1Nh@linux.dev>
References: <20250602192702.2125115-1-coltonlewis@google.com>
 <20250602192702.2125115-11-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602192702.2125115-11-coltonlewis@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 02, 2025 at 07:26:55PM +0000, Colton Lewis wrote:
> With FGT in place, the remaining trapped registers need to be written
> through to the underlying physical registers as well as the virtual
> ones. Failing to do this means delaying when guest writes take effect.
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index d368eeb4f88e..afd06400429a 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -18,6 +18,7 @@
>  #include <linux/printk.h>
>  #include <linux/uaccess.h>
>  #include <linux/irqchip/arm-gic-v3.h>
> +#include <linux/perf/arm_pmu.h>
>  #include <linux/perf/arm_pmuv3.h>
>  
>  #include <asm/arm_pmuv3.h>
> @@ -942,7 +943,11 @@ static bool pmu_counter_idx_valid(struct kvm_vcpu *vcpu, u64 idx)
>  {
>  	u64 pmcr, val;
>  
> -	pmcr = kvm_vcpu_read_pmcr(vcpu);
> +	if (kvm_vcpu_pmu_is_partitioned(vcpu))
> +		pmcr = read_pmcr();

Reading PMCR_EL0 from EL2 is not going to have the desired effect.
PMCR_EL0.N only returns HPMN when read from the guest.

> +	else
> +		pmcr = kvm_vcpu_read_pmcr(vcpu);
> +
>  	val = FIELD_GET(ARMV8_PMU_PMCR_N, pmcr);
>  	if (idx >= val && idx != ARMV8_PMU_CYCLE_IDX) {
>  		kvm_inject_undefined(vcpu);
> @@ -1037,6 +1042,22 @@ static bool access_pmu_evcntr(struct kvm_vcpu *vcpu,
>  	return true;
>  }
>  
> +static void writethrough_pmevtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> +				   u64 reg, u64 idx)
> +{
> +	u64 evmask = kvm_pmu_evtyper_mask(vcpu->kvm);
> +	u64 val = p->regval & evmask;
> +
> +	__vcpu_sys_reg(vcpu, reg) = val;
> +
> +	if (idx == ARMV8_PMU_CYCLE_IDX)
> +		write_pmccfiltr(val);
> +	else if (idx == ARMV8_PMU_INSTR_IDX)
> +		write_pmicfiltr(val);
> +	else
> +		write_pmevtypern(idx, val);
> +}
> +

How are you preventing the VM from configuring an event counter to count
at EL2?

I see that you're setting MDCR_EL2.HPMD (which assumes FEAT_PMUv3p1) but
due to an architecture bug there's no control to prohibit the cycle
counter until FEAT_PMUv3p5 (MDCR_EL2.HCCD).

Since you're already trapping PMCCFILTR you could potentially configure
the hardware value in such a way that it filters EL2.

>  static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  			       const struct sys_reg_desc *r)
>  {
> @@ -1063,7 +1084,9 @@ static bool access_pmu_evtyper(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  	if (!pmu_counter_idx_valid(vcpu, idx))
>  		return false;
>  
> -	if (p->is_write) {
> +	if (kvm_vcpu_pmu_is_partitioned(vcpu) && p->is_write) {
> +		writethrough_pmevtyper(vcpu, p, reg, idx);

What about the vPMU event filter?

> +	} else if (p->is_write) {
>  		kvm_pmu_set_counter_event_type(vcpu, p->regval, idx);
>  		kvm_vcpu_pmu_restore_guest(vcpu);
>  	} else {
> -- 
> 2.49.0.1204.g71687c7c1d-goog
> 

Thanks,
Oliver

