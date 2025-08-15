Return-Path: <linux-kernel+bounces-771421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0F1B286EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B101B60985
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DAE275846;
	Fri, 15 Aug 2025 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bdION+ee"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209B0248894
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288282; cv=none; b=IcS2GpjTRUQ9hDdLg5zfL+lEECxabHE4awV7cTvZ1MarCqsNz/98Go4frRfAEkduylcjgClvgrGQ4l0MAdA/EBEB5UnvvuKHN8/OjWDtBLCmm9niuwNeW+xCZHjHiljViwmW174yZ8Vl0w0e63ccTlK4U4VobmPWLx5ZfBbUX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288282; c=relaxed/simple;
	bh=YnJazGOGZYJN/dBOZtTqRX6QsQM8mR8auk3uz2DqgeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McnRmrCwKuzJ5EpBxB5AvWOcCWOQdBTMaeTaGCqK3i122pO3kpwS45whx9Fkns4vVNvWtNRRPQfeArpSEf5sBNMuxNJFwNNbUWZ69uMfZ0Bu6NWj/v34FPMmSPZNvKZ8ZZlk3XXRe/iX/IPDMwdfQMrL+4I7cvKtnmLaOevkwKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bdION+ee; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-88432e2975cso162971839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755288280; x=1755893080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjJzR6BitUGV64diaMvb3KSO/e3Gi7ex2M4rjIRjOr4=;
        b=bdION+eejFvdPEWkEbuMrOJ3+gSdkiYpkxnSXMWsRmBATp6dxZ3jndTZjFN2l7rLrJ
         Wg0MvpyfdW2ATIMfUJomXxy0Mqm/tqGaIQIIr/iKmpQ61rYgzTElr91VQ5GfMPkBU8gd
         +YnJHz+kGMF3kJbMEV7HMFCFu8echSEeWkbVwtJFTO3XUfEfngxnWyltILOoSd8mQ+xH
         nX8MPluR3DzvdNhMr4TJ9CmUpSecA0Tx0nTptZxDrrOoW3nD3b/+uM6GHAxNBEgkjNMX
         MYu452K4mmJn9pooUruBDq82NCy7uHAM2hKvs6BOHecoRXDahyykkLelYYe+TRq5GX2a
         dsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755288280; x=1755893080;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjJzR6BitUGV64diaMvb3KSO/e3Gi7ex2M4rjIRjOr4=;
        b=g9X/wz0kdZczvmBUwGSnI/8U+lzdI6bsG9NFqWYe/yXWiwTsAa0oJB8JS5EAsGDayl
         zpQxoGIMf1gJuE7Jfhr14OXO9YCucuwYFLKi3NvtOpnJOsA5UiTY/SswrtKxLTB63TNQ
         pv56Xn3SR1wpjORu3o3Hp/ukOnkvmEeyJ9LP/KwndoF0E7UMJ7lXzRznEmI49iJ9CMJg
         X7Iv486T9IyAPszUy1ffYQF0R1BMo1fRL4Mv8CrnzVn2e/BVtdRONeFrbj3AIkk7eK0l
         3PWNFiGc6OmgU9XQcNsH4WqjpMQC9gsa7Q2Hnu+v05a2RP5qKzTXQDF0HoPVLCsnysVl
         r/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUwRgWOz59DKLDxwKOjHciQQfCbqqAQQi8N9htPsjvqEcbgdrDCaNvGJ+EaxggfAEt59Fp6WxHM9fh6IMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbIbso0TL48645baJ7nyFTfj4K1dSUOB8wEei8UrqCFj52hclM
	vJk2TwvENLkW7oXlchPDV/QCv7YyjPfvr6l3jNZkqFWWdx6MLUTFpUPK8cymlPA/cdM=
X-Gm-Gg: ASbGncuHmtFrVlHuhBC6lFJFEWi5bwgOgG5WAvkFb39AjH/5iOzbO8Pky+ooEbc7k33
	qN0rvz/0AOmN6BnX35eqgA4AQpG0qgj5EXFIev594/KWlZ0vGJ3CU1MgyXtKTnPYUGKUUxH02Lr
	rgxTuL8hpcCo/bDWHoRxFnRZiwb+BR91Wt3nuo4qVSY80nSHNtWsqjmKUR7fOBNJU+VkjZWCqd9
	1y3h4guR8fTzkyjbMVWwOtMmbkvVvVpv1V9XDXHQ4Nsh21Ludvr+cbsx2/q6qFL7zHKImduLsEB
	ez66qazGXhD8BMe9xK9tduiLS0erZcQXsxndc6NFJthRhKwoJSgYfQPlQc9hzccFjLB0VMrX/H1
	EovcryrmzsPjpfsIUWnrJLSnX
X-Google-Smtp-Source: AGHT+IFVAKt30ibqWuDesYE4Rq4i7q7q9OchtpkO5B6rE/MAYha/hplJL5lUKwJN5zK9vnb+lDVkPA==
X-Received: by 2002:a05:6602:3410:b0:86c:e686:ca29 with SMTP id ca18e2360f4ac-8843e34cd35mr730781139f.2.1755288280204;
        Fri, 15 Aug 2025 13:04:40 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f9f6d8dsm77814839f.24.2025.08.15.13.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 13:04:39 -0700 (PDT)
Date: Fri, 15 Aug 2025 15:04:38 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Atish Patra <atish.patra@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/6] RISC-V: KVM: Set initial value of hedeleg in
 kvm_arch_vcpu_create()
Message-ID: <20250815-5b8056af445fb30be7c387a7@orel>
References: <20250814155548.457172-1-apatel@ventanamicro.com>
 <20250814155548.457172-2-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814155548.457172-2-apatel@ventanamicro.com>

On Thu, Aug 14, 2025 at 09:25:43PM +0530, Anup Patel wrote:
> The hedeleg may be updated by ONE_REG interface before the VCPU
> is run at least once hence set the initial value of hedeleg in
> kvm_arch_vcpu_create() instead of kvm_riscv_vcpu_setup_config().
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/kvm/vcpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index f001e56403f9..86025f68c374 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -133,6 +133,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  
>  	/* Mark this VCPU never ran */
>  	vcpu->arch.ran_atleast_once = false;
> +
> +	vcpu->arch.cfg.hedeleg = KVM_HEDELEG_DEFAULT;
>  	vcpu->arch.mmu_page_cache.gfp_zero = __GFP_ZERO;
>  	bitmap_zero(vcpu->arch.isa, RISCV_ISA_EXT_MAX);
>  
> @@ -570,7 +572,6 @@ static void kvm_riscv_vcpu_setup_config(struct kvm_vcpu *vcpu)
>  			cfg->hstateen0 |= SMSTATEEN0_SSTATEEN0;
>  	}
>  
> -	cfg->hedeleg = KVM_HEDELEG_DEFAULT;
>  	if (vcpu->guest_debug)
>  		cfg->hedeleg &= ~BIT(EXC_BREAKPOINT);
>  }
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

