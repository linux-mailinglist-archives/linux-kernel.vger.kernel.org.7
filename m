Return-Path: <linux-kernel+bounces-675198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA29ACFA39
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 02:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9BA17A16E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 00:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F27748D;
	Fri,  6 Jun 2025 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ro5Ve4iw"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8ED1DFCE
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 00:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749168054; cv=none; b=H9nvsxydCooGyhhPP28g0cpEA3Tdrmxj1L9IeHY6zV7IVEaJcgJudZgIqsX9D0M0IwjoHMBccq2zNrw3LA8CNvEeR3bz7v5cEQc+DLO/GnzfHWmiMmuXrFwNVQ59WN9eMEvmy+8h5/cxj4ns5CGWbbgu+fPVYagaZO8NNMPps9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749168054; c=relaxed/simple;
	bh=yF81W6xg7pXep5ORBgjRaqlgriNmy3LE1ibfI78BKQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLYpB9qTeYf6G59hO7snO0K9L3kYbjBogvN5Ol+2Pk82mwgeYOVC3qzK/ymHKsOAQpghBU0zOFhikGjfzi/Yg0gvEKvEW2yO0XDgP7A0GPa0DqFswDMhdcMrvwMCcm+y7+vZduclPOOul4X0i2bZq+13JQ1rBBGsut+nJHuycUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ro5Ve4iw; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cc2caf0b-7c2f-4793-9510-0dd6c391088a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749168040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ci1aLZP2uGDNNh5buVx4u3tAr7sY/YsrNm+RPVvB3I8=;
	b=Ro5Ve4iwh0itvA3O67QDkEdjRqdvpxYprJZQz0r8mJiDlH8Fowyn7uZRRcqoFN2cWVA2G9
	05P/KjWr7hz6phBLy4d9vgYX4DzrMZVmSI+d+A7kmLFHdrGpxMSdXLJzxiVXMRhOG/jvNK
	t2GzY3qBGgpqqiVubwPgdfji62Ge5TQ=
Date: Thu, 5 Jun 2025 17:00:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 01/13] RISC-V: KVM: Fix the size parameter check in SBI
 SFENCE calls
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250605061458.196003-1-apatel@ventanamicro.com>
 <20250605061458.196003-2-apatel@ventanamicro.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20250605061458.196003-2-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/4/25 11:14 PM, Anup Patel wrote:
> As-per the SBI specification, an SBI remote fence operation applies
> to the entire address space if either:
> 1) start_addr and size are both 0
> 2) size is equal to 2^XLEN-1
>
>  From the above, only #1 is checked by SBI SFENCE calls so fix the
> size parameter check in SBI SFENCE calls to cover #2 as well.
>
> Fixes: 13acfec2dbcc ("RISC-V: KVM: Add remote HFENCE functions based on VCPU requests")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>   arch/riscv/kvm/vcpu_sbi_replace.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
> index 5fbf3f94f1e8..9752d2ffff68 100644
> --- a/arch/riscv/kvm/vcpu_sbi_replace.c
> +++ b/arch/riscv/kvm/vcpu_sbi_replace.c
> @@ -103,7 +103,7 @@ static int kvm_sbi_ext_rfence_handler(struct kvm_vcpu *vcpu, struct kvm_run *run
>   		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_FENCE_I_SENT);
>   		break;
>   	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA:
> -		if (cp->a2 == 0 && cp->a3 == 0)
> +		if ((cp->a2 == 0 && cp->a3 == 0) || cp->a3 == -1UL)
>   			kvm_riscv_hfence_vvma_all(vcpu->kvm, hbase, hmask);
>   		else
>   			kvm_riscv_hfence_vvma_gva(vcpu->kvm, hbase, hmask,
> @@ -111,7 +111,7 @@ static int kvm_sbi_ext_rfence_handler(struct kvm_vcpu *vcpu, struct kvm_run *run
>   		kvm_riscv_vcpu_pmu_incr_fw(vcpu, SBI_PMU_FW_HFENCE_VVMA_SENT);
>   		break;
>   	case SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID:
> -		if (cp->a2 == 0 && cp->a3 == 0)
> +		if ((cp->a2 == 0 && cp->a3 == 0) || cp->a3 == -1UL)
>   			kvm_riscv_hfence_vvma_asid_all(vcpu->kvm,
>   						       hbase, hmask, cp->a4);
>   		else


Thanks for the fix.
Reviewed-by: Atish Patra <atishp@rivosinc.com>


