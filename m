Return-Path: <linux-kernel+bounces-686570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E105AD993C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 02:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316021BC19B3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jun 2025 00:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C4F1DFDE;
	Sat, 14 Jun 2025 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s4zK3NXh"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92606BA33
	for <linux-kernel@vger.kernel.org>; Sat, 14 Jun 2025 00:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749862052; cv=none; b=TvkwbtErgsAdXCuTRxUh+HkTf2BvQKwWIT5dyN/6f2cl52Qk1cL6odxWHDLVe+piRMFEh2Qdn/5V/T4htruUWpiY9AFjazMp/1+rDHNUFTVXICTFcI8bXpX+B9GUIPss/45juZmcfFxnIyLcWHrLguW3mh9VYtJYqzXhBgnLI3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749862052; c=relaxed/simple;
	bh=la74RQV8h2p+IDkzPWQSufDLfZGwDtiQubsQvkiupD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2nvwcHP/TtYwwD8btZWpUGMwFeoKoaWaJ7ZshdrfWkzZliW6yalnAphMfF4FWm+0uQ56rlFuCKG3OiE/bJFjodSXU3pMJQQ3cO5RsLw0Mjplx6QMSPSuu13mmKRZEv2yxcxQTGaudbjSCjrYP+iT8ORCuGjSd3IsRII8EDJSoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s4zK3NXh; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f60715b1-3d15-4929-95c6-f21b433c14c5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749862047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HzvEnJHeRWwDZLaUSOe8vqoCojm1nty38UfDyMGsc1I=;
	b=s4zK3NXhh6sDB8D0PyKptlOn6KfFHjeJdB/DX+lfO4Rz7irNI0NmjoVF6SrrzuT54b2rPv
	Oh5gUqaVEPt0xllkEaIWwsz5Yo9VbNdQlC8LgN2gMPEUnN6gLSawr352WGsZA7Yz375v4P
	zeH3m6SRfoIEx/mXQ/O6/TFfYAAx5bM=
Date: Fri, 13 Jun 2025 17:46:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 07/12] RISC-V: KVM: Use ncsr_xyz() in
 kvm_riscv_vcpu_trap_redirect()
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250613065743.737102-1-apatel@ventanamicro.com>
 <20250613065743.737102-8-apatel@ventanamicro.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20250613065743.737102-8-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/12/25 11:57 PM, Anup Patel wrote:
> The H-extension CSRs accessed by kvm_riscv_vcpu_trap_redirect() will
> trap when KVM RISC-V is running as Guest/VM hence remove these traps
> by using ncsr_xyz() instead of csr_xyz().
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>   arch/riscv/kvm/vcpu_exit.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 6e0c18412795..85c43c83e3b9 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -9,6 +9,7 @@
>   #include <linux/kvm_host.h>
>   #include <asm/csr.h>
>   #include <asm/insn-def.h>
> +#include <asm/kvm_nacl.h>
>   
>   static int gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
>   			     struct kvm_cpu_trap *trap)
> @@ -135,7 +136,7 @@ unsigned long kvm_riscv_vcpu_unpriv_read(struct kvm_vcpu *vcpu,
>   void kvm_riscv_vcpu_trap_redirect(struct kvm_vcpu *vcpu,
>   				  struct kvm_cpu_trap *trap)
>   {
> -	unsigned long vsstatus = csr_read(CSR_VSSTATUS);
> +	unsigned long vsstatus = ncsr_read(CSR_VSSTATUS);
>   
>   	/* Change Guest SSTATUS.SPP bit */
>   	vsstatus &= ~SR_SPP;
> @@ -151,15 +152,15 @@ void kvm_riscv_vcpu_trap_redirect(struct kvm_vcpu *vcpu,
>   	vsstatus &= ~SR_SIE;
>   
>   	/* Update Guest SSTATUS */
> -	csr_write(CSR_VSSTATUS, vsstatus);
> +	ncsr_write(CSR_VSSTATUS, vsstatus);
>   
>   	/* Update Guest SCAUSE, STVAL, and SEPC */
> -	csr_write(CSR_VSCAUSE, trap->scause);
> -	csr_write(CSR_VSTVAL, trap->stval);
> -	csr_write(CSR_VSEPC, trap->sepc);
> +	ncsr_write(CSR_VSCAUSE, trap->scause);
> +	ncsr_write(CSR_VSTVAL, trap->stval);
> +	ncsr_write(CSR_VSEPC, trap->sepc);
>   
>   	/* Set Guest PC to Guest exception vector */
> -	vcpu->arch.guest_context.sepc = csr_read(CSR_VSTVEC);
> +	vcpu->arch.guest_context.sepc = ncsr_read(CSR_VSTVEC);
>   
>   	/* Set Guest privilege mode to supervisor */
>   	vcpu->arch.guest_context.sstatus |= SR_SPP;


Reviewed-by: Atish Patra <atishp@rivosinc.com>


