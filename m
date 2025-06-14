Return-Path: <linux-kernel+bounces-686566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB9EAD9931
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 02:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30EF1BC1E19
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 00:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B1F1DA4E;
	Sat, 14 Jun 2025 00:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u/e9RR/r"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A9F4F1
	for <linux-kernel@vger.kernel.org>; Sat, 14 Jun 2025 00:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749861868; cv=none; b=C5Oi/O54D9gIudKZtzcIxy7EYQF2KF9lWLG5gPir2UsnFPFM9vMgBX7hGIpV31NV5xFDDzWPyj2YJXfAaNnnNyBMIWIu3u2mA7Oy/+V1IvBtyZlq26PJm3jq1bjfJ0vPt6mCR1VHKP3dPrCclJKdTyGB8DsehQVkP4khGkNZrK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749861868; c=relaxed/simple;
	bh=29cRgpEIn9i77ft2ErJCGJTeGJHKAHEj16jzFLOkDO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nyh1kjZoaHDZdao1kTZO6AIVbWpfb5b737pD6k9pDa02t8XqRpyJOOi14m5Tv/UlShfBZ7KbIfiakWVnj+Rpn8ym7mZon1IrfpCmyOfkyMmSiRMxS+P9Q5O4+ZRPA2RSHgzUBt4FkjoPU7YcDp02nD2wmcLpeHUr7Pe8/WraebE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u/e9RR/r; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <422c5677-48d1-41be-b128-595829c27167@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749861853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXuSTcUn0J6P+iqyqyqHY+kzA3pvndl/3kAQ7RECPmE=;
	b=u/e9RR/rxfXPFPycnlPVQqNrU5k0V5o6T4a0vCElbgKU5CYulJQONn820Lt+bxrHKt3EJj
	9HC0jaQ//KBjncZGpnjDfEzSqPcZs914149pSwPRty719isCXS245ZnwGFUdJjeAcsJvWy
	YIWig0jncgm0xUQ2x57lRJYqQf2oUeE=
Date: Fri, 13 Jun 2025 17:43:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 06/12] RISC-V: KVM: Implement
 kvm_arch_flush_remote_tlbs_range()
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250613065743.737102-1-apatel@ventanamicro.com>
 <20250613065743.737102-7-apatel@ventanamicro.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20250613065743.737102-7-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/12/25 11:57 PM, Anup Patel wrote:
> The kvm_arch_flush_remote_tlbs_range() expected by KVM core can be
> easily implemented for RISC-V using kvm_riscv_hfence_gvma_vmid_gpa()
> hence provide it.
>
> Also with kvm_arch_flush_remote_tlbs_range() available for RISC-V, the
> mmu_wp_memory_region() can happily use kvm_flush_remote_tlbs_memslot()
> instead of kvm_flush_remote_tlbs().
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>   arch/riscv/include/asm/kvm_host.h | 2 ++
>   arch/riscv/kvm/mmu.c              | 2 +-
>   arch/riscv/kvm/tlb.c              | 8 ++++++++
>   3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index ff1f76d6f177..6162575e2177 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -43,6 +43,8 @@
>   	KVM_ARCH_REQ_FLAGS(5, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>   #define KVM_REQ_STEAL_UPDATE		KVM_ARCH_REQ(6)
>   
> +#define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
> +
>   #define KVM_HEDELEG_DEFAULT		(BIT(EXC_INST_MISALIGNED) | \
>   					 BIT(EXC_BREAKPOINT)      | \
>   					 BIT(EXC_SYSCALL)         | \
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 29f1bd853a66..a5387927a1c1 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -344,7 +344,7 @@ static void gstage_wp_memory_region(struct kvm *kvm, int slot)
>   	spin_lock(&kvm->mmu_lock);
>   	gstage_wp_range(kvm, start, end);
>   	spin_unlock(&kvm->mmu_lock);
> -	kvm_flush_remote_tlbs(kvm);
> +	kvm_flush_remote_tlbs_memslot(kvm, memslot);
>   }
>   
>   int kvm_riscv_gstage_ioremap(struct kvm *kvm, gpa_t gpa,
> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index da98ca801d31..f46a27658c2e 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c
> @@ -403,3 +403,11 @@ void kvm_riscv_hfence_vvma_all(struct kvm *kvm,
>   	make_xfence_request(kvm, hbase, hmask, KVM_REQ_HFENCE_VVMA_ALL,
>   			    KVM_REQ_HFENCE_VVMA_ALL, NULL);
>   }
> +
> +int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn, u64 nr_pages)
> +{
> +	kvm_riscv_hfence_gvma_vmid_gpa(kvm, -1UL, 0,
> +				       gfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT,
> +				       PAGE_SHIFT);
> +	return 0;
> +}

LGTM. However, I noticed that kvm_flush_remote_tlbs_range doesn't 
increment remote_tlb_flush_requests/remote_tlb_flush stat counter.

So we would be losing those stats here. Do you know if there is a 
specific reason behind not supporting the stat counters in the *tlbs_range
function ?

Otherwise,
Reviewed-by: Atish Patra <atishp@rivosinc.com>


