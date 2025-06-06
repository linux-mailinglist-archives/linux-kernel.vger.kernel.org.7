Return-Path: <linux-kernel+bounces-675207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B580ACFA55
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 02:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6993B3B0182
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 00:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005291FB3;
	Fri,  6 Jun 2025 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ITauuJeu"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFF67FD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 00:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749168723; cv=none; b=Mkao/NUvVnWuESAk2VBucKVfUyrF5uPzJ0VMEhWiAKCVVyqZ6hnkVAxYgU3lja2NYw7Fbt8v9HGk7Wy33Gq74zm8WrPuxIvT+1ReALBgPh5BC6FOx/R43LJ5n8rdw7iRFKDfYdE9rwK3e2vhjGrr1QGtTxY2r67e5DjlcK3uMgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749168723; c=relaxed/simple;
	bh=wDf6tSZb//7+XWN/SrX+v494UtsLj5YYhF5RdZUm2Jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ju9IMM/cXSU8yNQFyOU+gtRqHmbGD/RWsFe39BGi6NmRCoYEAJC58vLcRqfJx9rWzHx/BHxcW/pWHEXMrBpiNxSvAy83dbhkwSWrcnQsoO9G0BmhPah2PuwW/n82hWh9RUUc6An3CNYgIEP3tHBYcKCJlDQrFN36lRt68pH3Q20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ITauuJeu; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a17bf7bf-238f-4b71-8f77-6ca4fea380f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749168718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uXGHLViCT6YsAqsubq+1xL9M6AMjoxBoATCFHCFNHMw=;
	b=ITauuJeusjWNoPZBazcCGDTBOS9Mzdjmvqy+zHyfdEJxh9I5R+6TB+D6FH2g60izyxGVIj
	y8LTRwAPhaN/omJbgCxyx40ZZX/H/8QW+iIhnwPrf0u9C+GHyX3Km2xSGTe2nEZlOGg+YD
	7Jm9BC3zaOXU7d/fDTh+4fstAorXqkU=
Date: Thu, 5 Jun 2025 17:11:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 02/13] RISC-V: KVM: Don't treat SBI HFENCE calls as NOPs
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250605061458.196003-1-apatel@ventanamicro.com>
 <20250605061458.196003-3-apatel@ventanamicro.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20250605061458.196003-3-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/4/25 11:14 PM, Anup Patel wrote:
> The SBI specification clearly states that SBI HFENCE calls should
> return SBI_ERR_NOT_SUPPORTED when one of the target hart doesn’t
> support hypervisor extension (aka nested virtualization in-case
> of KVM RISC-V).
>
> Fixes: c7fa3c48de86 ("RISC-V: KVM: Treat SBI HFENCE calls as NOPs")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>   arch/riscv/kvm/vcpu_sbi_replace.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
> index 9752d2ffff68..b17fad091bab 100644
> --- a/arch/riscv/kvm/vcpu_sbi_replace.c
> +++ b/arch/riscv/kvm/vcpu_sbi_replace.c
> @@ -127,9 +127,9 @@ static int kvm_sbi_ext_rfence_handler(struct kvm_vcpu *vcpu, struct kvm_run *run
>   	case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID:
>   		/*
>   		 * Until nested virtualization is implemented, the
> -		 * SBI HFENCE calls should be treated as NOPs
> +		 * SBI HFENCE calls should return not supported
> +		 * hence fallthrough.
>   		 */
> -		break;
>   	default:
>   		retdata->err_val = SBI_ERR_NOT_SUPPORTED;
>   	}

Reviewed-by: Atish Patra <atishp@rivosinc.com>


