Return-Path: <linux-kernel+bounces-863023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D134BF6D15
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 874074F0233
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F68338930;
	Tue, 21 Oct 2025 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdCpJs3L"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DC3339702
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053686; cv=none; b=Q+9+TGo2X3kIFY2vyP4+K11Vklc81jEFN7C5LW8jPSIQA+P7akJBnhKQ5MiBjpNEj4/JZOEli3IjmEWGFqH5u6hvJQxV8fLucUZD0IFsnlk97kojIJyfNBtl02WJMAr2238wltsX+2V5G0TCqWl3TUd3z6cDeCNAiKiuYGOwdPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053686; c=relaxed/simple;
	bh=JD9tnLvhb0BCLBhU3oDZt9t/3nIJ0uQg415gEcHPfTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pGeHWt95AxEKSAnsphpKtYiZ2EPiyuYjAGVGVeR5ZlS9bvIJ/Qn9rWHeMzKE/se8S+tgiCewlhHO0azhNaPFvsDCwNszEewkNvwkHv4jZ5/dJxJGh1XHIe9zW4mQGjOo6vw9JXHCdDYOexcPN+nXeVezbmCYMvJI62Gd+XfMpmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdCpJs3L; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42700160169so2796432f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761053680; x=1761658480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UzfH8PMUJmAJUfqV7EQWQQrNJP7atdrSjM6p96pL1d0=;
        b=mdCpJs3L8Lrl52acqFzLTPiYmp/MSQg3SmkpM/wvs5er2i6BWn0YhLdm98ABdwPgXC
         4ZG3hZm4xo+LT6nR+T8D/HP6slo7SlU78bvhfDqHN+V55jQnerCQirFzEuTRbMOqKaKd
         d56+/yd713kGbzhDOkXiXP+yI1tFF3gpqo0KPGoIGM24ZCZkPetAWO/P2RNf8e1xtFT+
         ZgKS2m60c524vxvDshO3exyuKV1r2369ReExO/wlRvcvGPpMTsMHJsC/E2h8tEG2CLzY
         Vo+PGRWK3B7mZLXwDLseD+yYcBVGu7OjTIQewZ0Gi8ztK09ZtUXnJrFv4xm2yrGn8fAt
         zTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053680; x=1761658480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzfH8PMUJmAJUfqV7EQWQQrNJP7atdrSjM6p96pL1d0=;
        b=Ni51ER1LQIj1ZURgDBTw34WFpoopXS+xu+3Moyx3zX5j9pKP2Pe26XM+RIuumOdY4d
         8bE1YzfUuAAl8qjoEdCnr3LJDYZTdaqG7PurJDq6vzbAVU6q63tVrQytj0HK3S5NTJrh
         Bn1OQBE98Oi9nEClVReS8eJBHW3Vu3ywo9PCguS+sPF0NK2dJVQc0UfSSFlmrJJc4Of/
         ZDBd3I52WL7Lu6Jkk6VCGkYQ5XdmWLvDvVzwBYrOCVo5O7ouCnnYppA6/Ey6f713MVr2
         /FX6e/370AVxHKi6EM5/xvVRtfOhxoE/TQo45AgqxkP1/oW4HzByUORLC1xarlagn9G9
         W4pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh4FTAvcSTKHwmS8ePtjaJDm9AOIEhblezO4d2wZivo0LWAW7NvZr2W1BdFy0Z3MhXr8gdyhBuImDprnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKg7H6a6fEGiJF7dHliSfvNs+TkzqDi73ywT994dunOwSrNFUE
	czFn/cD+6dhHnyZkmjllEeuOMAkL3oA5lIK8EsdteRlOk9ZhFdKDEgn2NpXWfUr/2XnBOtn7BHt
	OzZSJFL8hkDnCPQ==
X-Google-Smtp-Source: AGHT+IGiIgbaC40m9Xvw65qy211QKJVo0mx93SoS5R34PfEI1F2nHUhgIqWH8aoIsEOJEz48uo70kFhjxJPiSg==
X-Received: from wma7.prod.google.com ([2002:a05:600c:8907:b0:46e:2897:9c17])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40da:b0:427:928:789e with SMTP id ffacd0b85a97d-42709287b2cmr10579240f8f.61.1761053680190;
 Tue, 21 Oct 2025 06:34:40 -0700 (PDT)
Date: Tue, 21 Oct 2025 13:34:39 +0000
In-Reply-To: <20251016200417.97003-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016200417.97003-1-seanjc@google.com> <20251016200417.97003-2-seanjc@google.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDO1FFOJKSTK.3LSOUFU5RM6PD@google.com>
Subject: Re: [PATCH v3 1/4] KVM: VMX: Flush CPU buffers as needed if L1D cache
 flush is skipped
From: Brendan Jackman <jackmanb@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu Oct 16, 2025 at 8:04 PM UTC, Sean Christopherson wrote:
> If the L1D flush for L1TF is conditionally enabled, flush CPU buffers to
> mitigate MMIO Stale Data as needed if KVM skips the L1D flush, e.g.
> because none of the "heavy" paths that trigger an L1D flush were tripped
> since the last VM-Enter.

Presumably the assumption here was that the L1TF conditionality is good
enough for the MMIO stale data vuln too? I'm not qualified to assess if
that assumption is true, but also even if it's a good one it's
definitely not obvious to users that the mitigation you pick for L1TF
has this side-effect. So I think I'm on board with calling this a bug.
If anyone turns out to be depending on the current behaviour for
performance I think they should probably add it back as a separate flag.

> MDS mitigation was inadvertently fixed by commit 43fb862de8f6 ("KVM/VMX:
> Move VERW closer to VMentry for MDS mitigation"), but previous kernels
> that flush CPU buffers in vmx_vcpu_enter_exit() are affected.
>
> Fixes: 650b68a0622f ("x86/kvm/vmx: Add MDS protection when L1D Flush is not active")
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f87c216d976d..ce556d5dc39b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6663,7 +6663,7 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>   * information but as all relevant affected CPUs have 32KiB L1D cache size
>   * there is no point in doing so.
>   */
> -static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
> +static noinstr bool vmx_l1d_flush(struct kvm_vcpu *vcpu)
>  {
>  	int size = PAGE_SIZE << L1D_CACHE_ORDER;
>  
> @@ -6691,14 +6691,14 @@ static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
>  		kvm_clear_cpu_l1tf_flush_l1d();
>  
>  		if (!flush_l1d)
> -			return;
> +			return false;
>  	}
>  
>  	vcpu->stat.l1d_flush++;
>  
>  	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
>  		native_wrmsrq(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
> -		return;
> +		return true;
>  	}
>  
>  	asm volatile(
> @@ -6722,6 +6722,7 @@ static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
>  		:: [flush_pages] "r" (vmx_l1d_flush_pages),
>  		    [size] "r" (size)
>  		: "eax", "ebx", "ecx", "edx");
> +	return true;

The comment in the caller says the L1D flush "includes CPU buffer clear
to mitigate MDS" - do we actually know that this software sequence
mitigates the MMIO stale data vuln like the verw does? (Do we even know if
it mitigates MDS?)

Anyway, if this is an issue, it's orthogonal to this patch.

Reviewed-by: Brendan Jackman <jackmanb@google.com>

>  }
>  
>  void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
> @@ -7330,8 +7331,9 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
>  	 * and is affected by MMIO Stale Data. In such cases mitigation in only
>  	 * needed against an MMIO capable guest.
>  	 */
> -	if (static_branch_unlikely(&vmx_l1d_should_flush))
> -		vmx_l1d_flush(vcpu);
> +	if (static_branch_unlikely(&vmx_l1d_should_flush) &&
> +	    vmx_l1d_flush(vcpu))
> +		;
>  	else if (static_branch_unlikely(&cpu_buf_vm_clear) &&
>  		 (flags & VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO))
>  		x86_clear_cpu_buffers();


