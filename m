Return-Path: <linux-kernel+bounces-758181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6A5B1CC0F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B8617B9B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B058829C33C;
	Wed,  6 Aug 2025 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="USMrL2Od"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAACB29CB48
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505645; cv=none; b=Ot8cKO+d0lVJXWURit+MlVsy7WmQKSFHRl3QvNmry+MZyKZWi5rTkMZv6ZyhTmF9WiCQ4CibRJFAzMUnfpew1zFYL2QdcgD52mfFW6eO02JEkUtQQaiOrNQSs9vfBWqeZWWGOuN05DZIP5xh1GG2ec6eJU07YxDpoQd/8aBIJlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505645; c=relaxed/simple;
	bh=FmgVduqyFQrrDuTkN7hPJDhYuDQHId3NQC+lreC3wvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVCq+MZO7lUw1pDbx1CBpgRftSSgVRr5k0ES1cCKc4ahS6+EDTUn6EpdU0icZjHKMAynwjA8DMNenGMI3SJPO+Bdh7J2F+NV2jatGUKHkM5pdkCzlM/T8RyxZczeN2RYlMiRykwZisiG0h65QRAExpQe21g2X/TW00pOKCCScv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=USMrL2Od; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 6 Aug 2025 11:40:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754505639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/FXfno0W+qkpNiKxLIrH/CR0MHBmoVI+HrerVsQ0Cgk=;
	b=USMrL2Odl7Ei5b5TqPKxvz+HtGXYtu/kKIKKNcerxJkN8b2z5ic0tmfV6bChFP2sHI3jq4
	ekTWF6YMSsjzqv8UfnHfloXaJJO57ckvtMzNvW2edwhG2ZZZhnMkzm1ExBxozG8ZY0JpST
	KmUqbaAD2hGhdHywq49wBLXp4eYV218=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1 2/2] KVM: arm64: nv: update CPU register PAR_EL1 after
 'at s*'
Message-ID: <aJOhnHCUR0Af4XJt@linux.dev>
References: <20250806141707.3479194-1-volodymyr_babchuk@epam.com>
 <20250806141707.3479194-3-volodymyr_babchuk@epam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806141707.3479194-3-volodymyr_babchuk@epam.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 06, 2025 at 02:17:55PM +0000, Volodymyr Babchuk wrote:
> Previously this code update only vCPU's in-memory value, which is good,
> but not enough, as there will be no context switch after exiting
> exception handler, so in-memory value will not get into actual
> register.
> 
> It worked good enough for VHE guests because KVM code tried fast path,
> which of course updated real PAR_EL1.
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>  arch/arm64/kvm/sys_regs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 7b8a0a6f26468..ab2b5e261d312 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -3463,6 +3463,9 @@ static bool handle_at_s1e2(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  
>  	__kvm_at_s1e2(vcpu, op, p->regval);
>  
> +	/* No context switch happened, so we need to update PAR_EL1 manually */
> +	write_sysreg(vcpu_read_sys_reg(vcpu, PAR_EL1), par_el1);
> +

Ok, this had me thoroughly confused for a moment. The bug is actually in
kvm_write_sys_reg() which is supposed to update the sysreg value when
things are loaded on the CPU. __kvm_at_s1e2() is doing the right thing
by calling this accessor.

For registers like PAR_EL1 that don't have an EL2->EL1 mapping we assume
they belong to the EL1 context and thus are in-memory when in a hyp
context. TPIDR(RO)_EL0 is similarly affected.

This is a bit of an ugly hack, but something like the following should
get things working if you're able to test it:

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index ad2548477257..32f8d1de8f1a 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -149,6 +149,22 @@ static bool get_el2_to_el1_mapping(unsigned int reg,
 	}
 }
 
+/*
+ * Special-cased registers that do not have an ELx mapping and are always
+ * loaded on the CPU.
+ */
+static bool reg_has_elx_mapping(int reg)
+{
+	switch (reg) {
+	case TPIDR_EL0:
+	case TPIDRRO_EL0:
+	case PAR_EL1:
+		return false;
+	default:
+		return true;
+	}
+}
+
 u64 vcpu_read_sys_reg(const struct kvm_vcpu *vcpu, int reg)
 {
 	u64 val = 0x8badf00d8badf00d;
@@ -158,6 +174,9 @@ u64 vcpu_read_sys_reg(const struct kvm_vcpu *vcpu, int reg)
 	if (!vcpu_get_flag(vcpu, SYSREGS_ON_CPU))
 		goto memory_read;
 
+	if (!reg_has_elx_mapping(reg))
+		goto sysreg_read;
+
 	if (unlikely(get_el2_to_el1_mapping(reg, &el1r, &xlate))) {
 		if (!is_hyp_ctxt(vcpu))
 			goto memory_read;
@@ -204,6 +223,7 @@ u64 vcpu_read_sys_reg(const struct kvm_vcpu *vcpu, int reg)
 	if (unlikely(is_hyp_ctxt(vcpu)))
 		goto memory_read;
 
+sysreg_read:
 	if (__vcpu_read_sys_reg_from_cpu(reg, &val))
 		return val;
 
@@ -219,6 +239,9 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
 	if (!vcpu_get_flag(vcpu, SYSREGS_ON_CPU))
 		goto memory_write;
 
+	if (!reg_has_elx_mapping(reg))
+		goto sysreg_write;
+
 	if (unlikely(get_el2_to_el1_mapping(reg, &el1r, &xlate))) {
 		if (!is_hyp_ctxt(vcpu))
 			goto memory_write;
@@ -259,6 +282,7 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
 	if (unlikely(is_hyp_ctxt(vcpu)))
 		goto memory_write;
 
+sysreg_write:
 	if (__vcpu_write_sys_reg_to_cpu(val, reg))
 		return;
 
-- 
Thanks,
Oliver

