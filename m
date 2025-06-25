Return-Path: <linux-kernel+bounces-701658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBFBAE777E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 08:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF1A1883505
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 06:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF02C1FBEB0;
	Wed, 25 Jun 2025 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="kdTrRPX7"
Received: from va-2-31.ptr.blmpb.com (va-2-31.ptr.blmpb.com [209.127.231.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D41F4628
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750834241; cv=none; b=Mbmc7TZGm+vvdGNFIiGruL4hVEYFHnbiHBubZkak5qWwn6lBAyFCLstP5g1HlmJrdOT92IOowNbz7o1LP577dTUa2LakkYSWRxWBbDI8MNXtluvAkhbyHMnsN/e+vcUXi2Sxifkqk8uAqpquR7IE7n4llPr9ZTuosM4Xtp+2Q9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750834241; c=relaxed/simple;
	bh=XlABoUydV0sy1H6M2rnUHztx2btJk/yKOHYY5NcuhAA=;
	h=To:In-Reply-To:Date:Mime-Version:References:Content-Type:Cc:From:
	 Message-Id:Subject; b=KA97f1Dd0pwDVzsBQ91VDlk5kx2fK37qjg38sXYQo5A8ZWn0H/KbmiYUjo1LKEswG/zkdUc9YvhUJgMmKvKF7UOQyDNStstwVVqbpKLfruzZ1oNyMTDgiIKJAfC6FRBEcz7qJ5N4w7G81o4rB0Tp68VdGm3uUPJHwCfhWfIB4dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=kdTrRPX7; arc=none smtp.client-ip=209.127.231.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1750834215;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Ik8c1hqRgYzer5tdkB7JgwAmNHMzAh0ECFwpDRHcshI=;
 b=kdTrRPX7l9jj9wagONaE8JwGbAVw8enUSWAQSkl7lDA8lxd78m/5OuG4axM5IYSWMgktYV
 lObLN8+E7Qz0nCRFYd8swpsUsZRfC2MEfDOHXzj86lsqjaR0jafwOJ1daZ7KRlyTRPhnlB
 RExAo/pHkOCUpcle/Pr0G16SUjhpPFrofZTotrfTABjA3q+H8sMZzq08IWSMTZnokLF1dR
 b5OepAA5vx/S7HlgKSMCCMJt2VkSSCXTUuCgEcvCsxCxvwIGSnmed4aaFOSMaq8hkQKjNJ
 oJropYL0TKhPhjU2q5JWlJkFBtWuDJC2gjdbYcIQu2hJWJQc+WfBAPO0byqCJA==
To: "Anup Patel" <apatel@ventanamicro.com>, 
	"Atish Patra" <atish.patra@linux.dev>
In-Reply-To: <20250618113532.471448-3-apatel@ventanamicro.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Date: Wed, 25 Jun 2025 14:50:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250618113532.471448-1-apatel@ventanamicro.com> <20250618113532.471448-3-apatel@ventanamicro.com>
Received: from [127.0.0.1] ([139.226.59.215]) by smtp.feishu.cn with ESMTPS; Wed, 25 Jun 2025 14:50:12 +0800
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+2685b9c25+f9787f+vger.kernel.org+liujingqi@lanxincomputing.com>
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Alexandre Ghiti" <alex@ghiti.fr>, 
	"Andrew Jones" <ajones@ventanamicro.com>, 
	"Anup Patel" <anup@brainfault.org>, <kvm@vger.kernel.org>, 
	<kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Message-Id: <44722ec6-b08c-40bd-a612-40d723985aa3@lanxincomputing.com>
Subject: Re: [PATCH v3 02/12] RISC-V: KVM: Drop the return value of kvm_riscv_vcpu_aia_init()
User-Agent: Mozilla Thunderbird
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>

On 6/18/2025 7:35 PM, Anup Patel wrote:
> The kvm_riscv_vcpu_aia_init() does not return any failure so drop
> the return value which is always zero.
>
> Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>   arch/riscv/include/asm/kvm_aia.h | 2 +-
>   arch/riscv/kvm/aia_device.c      | 6 ++----
>   arch/riscv/kvm/vcpu.c            | 4 +---
>   3 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
> index 3b643b9efc07..0a0f12496f00 100644
> --- a/arch/riscv/include/asm/kvm_aia.h
> +++ b/arch/riscv/include/asm/kvm_aia.h
> @@ -147,7 +147,7 @@ int kvm_riscv_vcpu_aia_rmw_ireg(struct kvm_vcpu *vcpu, unsigned int csr_num,
>   
>   int kvm_riscv_vcpu_aia_update(struct kvm_vcpu *vcpu);
>   void kvm_riscv_vcpu_aia_reset(struct kvm_vcpu *vcpu);
> -int kvm_riscv_vcpu_aia_init(struct kvm_vcpu *vcpu);
> +void kvm_riscv_vcpu_aia_init(struct kvm_vcpu *vcpu);
>   void kvm_riscv_vcpu_aia_deinit(struct kvm_vcpu *vcpu);
>   
>   int kvm_riscv_aia_inject_msi_by_id(struct kvm *kvm, u32 hart_index,
> diff --git a/arch/riscv/kvm/aia_device.c b/arch/riscv/kvm/aia_device.c
> index 806c41931cde..b195a93add1c 100644
> --- a/arch/riscv/kvm/aia_device.c
> +++ b/arch/riscv/kvm/aia_device.c
> @@ -509,12 +509,12 @@ void kvm_riscv_vcpu_aia_reset(struct kvm_vcpu *vcpu)
>   	kvm_riscv_vcpu_aia_imsic_reset(vcpu);
>   }
>   
> -int kvm_riscv_vcpu_aia_init(struct kvm_vcpu *vcpu)
> +void kvm_riscv_vcpu_aia_init(struct kvm_vcpu *vcpu)
>   {
>   	struct kvm_vcpu_aia *vaia = &vcpu->arch.aia_context;
>   
>   	if (!kvm_riscv_aia_available())
> -		return 0;
> +		return;
>   
>   	/*
>   	 * We don't do any memory allocations over here because these
> @@ -526,8 +526,6 @@ int kvm_riscv_vcpu_aia_init(struct kvm_vcpu *vcpu)
>   	/* Initialize default values in AIA vcpu context */
>   	vaia->imsic_addr = KVM_RISCV_AIA_UNDEF_ADDR;
>   	vaia->hart_index = vcpu->vcpu_idx;
> -
> -	return 0;
>   }
>   
>   void kvm_riscv_vcpu_aia_deinit(struct kvm_vcpu *vcpu)
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index b467dc1f4c7f..f9fb3dbbe0c3 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -159,9 +159,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>   	kvm_riscv_vcpu_pmu_init(vcpu);
>   
>   	/* Setup VCPU AIA */
> -	rc = kvm_riscv_vcpu_aia_init(vcpu);
> -	if (rc)
> -		return rc;
> +	kvm_riscv_vcpu_aia_init(vcpu);
>   
>   	/*
>   	 * Setup SBI extensions

Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>

Thanks,
Nutty

