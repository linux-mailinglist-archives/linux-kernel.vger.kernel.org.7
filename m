Return-Path: <linux-kernel+bounces-814859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE66B559C5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C14D5C3643
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F7E2609DC;
	Fri, 12 Sep 2025 22:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjoqhsHB"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AA9283FC2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757717729; cv=none; b=Y72bBjTryO6bU2t62cUK09tdLnCSKkz3whGBOsZK01S+WgQmiuroDM6PSWbCfC8x67d0ZjH7RGuq6tl91hCSvQDvZbLbw8ojaPC1xHcvLJHjCjvEQnsy4Gbu2RCp5CGQkmTFmGBN9jPAOMOZTH8nIPzKQBESw6B/XwKQUs4saKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757717729; c=relaxed/simple;
	bh=s81gDgnQeGccrS8LsVmeNH8hG65sh8m34+oHvpgsrrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tYaRHJ4iJhk3drpHpHmGB5oFyQGsHGQtfAwJWICxOIhVNt/aGj4HdjRxKtoerSYmTTiS6pnCPjfu+Up4cehbNWpWJ4D8bKmKlFgxbfurmJED3L0Sgrw5a1fPzkqRtcR+1+s1hmYKceu18drWlb/hzSSHrHLFP5jiiQ4IuXmVV2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UjoqhsHB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445806b18aso24183175ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757717727; x=1758322527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5UxjIlsEgvTF8daNW02GCq6jap774PItnDVhlq0f8c=;
        b=UjoqhsHBA61DXGARwcZ/ROhWFgX4maQIWYOp5mN9IV3MW0X5MWk7xdLBpAeRRCMmUK
         pdtcq2WVt3/qkLjJy9J4cbCRWaBCMWFzWpzRdYMot1MRQiRG3sb8w3/27juv7qVbFYHD
         p4R5d/5O4cL34/hsCTStpRuAb41nW1UjuS5qxnKIlCnCRbMd9WWGP7T9wExKM+SvAby2
         IokeMJjXzdMt8PFiw7++y+hFWdQSmw1pY2ovq8Es0v565lb0OVyNLKcAipNole5ZySiw
         eH236h9HrPy7L/UA9CV+ZpzJ77BMC+Cow0MV1BopuB/yQaptc+ynze6vcxiSUpFUfOps
         j8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757717727; x=1758322527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5UxjIlsEgvTF8daNW02GCq6jap774PItnDVhlq0f8c=;
        b=pdEJXKIUaKGOfQsMW9jKgfrfNd0kOeOTzwfFtTTaJGsayV4jgA10X6fwovUlgf8dHl
         Grh14G95dmZ6jnJHkZU6ZV5t3qsngrQA3SHExzwM5dKnREZcuMS+uI+tbqY+B6+r7R+l
         xBiSYZJqsF3WjORjvA6ITJZPc+SvsqBgV+kpkkfFAkC6OaeqAf5uXU3vruXd1DOzmNdc
         KzFtAMEf5ZoKG6Z9rmCANTW9y0qIxxnIt8fvAVN7+LFp/l/pg3ea3hjBBU2feLxvnwgS
         Dboicyql7hZpSxlnJIPErWB0tWT7EUl6HHIPB2rRT70qhXy/UtzYlVeI8hmjhiXoY/ZZ
         mGeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEtTmgBIPm7mmPbtJ1mfGSqVmjKMdLNdc5pgoDKz8iGXlZWJs9uGhO9mIbAckBGmVTMJazaDbu9bu0pjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0ICC5uprlyL/A4kXfHON8Yg1v2jFU7L1fArDqZpTzTEs02tM
	E3rCf7zGtFy4cyB3k7OyVgBqrE8SzHti1zfv1pWerpvUyLlFjUDEF0uBVjHKs+GW+vj/ckLBfp/
	nfiIE2A==
X-Google-Smtp-Source: AGHT+IEBFW2+no450hTjR9z5hEWHspR3hha0vnhjysBUIwJUVLZG1hVKgUXc1l4Dd+5wBSZ/IjDFCVmvLWg=
X-Received: from plbja20.prod.google.com ([2002:a17:902:efd4:b0:25c:a8a8:add6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f60d:b0:25d:df7a:b1a2
 with SMTP id d9443c01a7336-25ddf7ab591mr33868625ad.5.1757717727608; Fri, 12
 Sep 2025 15:55:27 -0700 (PDT)
Date: Fri, 12 Sep 2025 15:55:25 -0700
In-Reply-To: <20250908201750.98824-2-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250908201750.98824-1-john.allen@amd.com> <20250908201750.98824-2-john.allen@amd.com>
Message-ID: <aMSk3fY7XzScBuOx@google.com>
Subject: Re: [PATCH v4 1/5] KVM: x86: SVM: Emulate reads and writes to shadow
 stack MSRs
From: Sean Christopherson <seanjc@google.com>
To: John Allen <john.allen@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	pbonzini@redhat.com, dave.hansen@intel.com, rick.p.edgecombe@intel.com, 
	mlevitsk@redhat.com, weijiang.yang@intel.com, chao.gao@intel.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 08, 2025, John Allen wrote:
> Emulate shadow stack MSR access by reading and writing to the
> corresponding fields in the VMCB.
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  arch/x86/kvm/svm/svm.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e4af4907c7d8..fee60f3378e1 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2767,6 +2767,15 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (guest_cpuid_is_intel_compatible(vcpu))
>  			msr_info->data |= (u64)svm->sysenter_esp_hi << 32;
>  		break;
> +	case MSR_IA32_S_CET:
> +		msr_info->data = svm->vmcb->save.s_cet;
> +		break;
> +	case MSR_IA32_INT_SSP_TAB:
> +		msr_info->data = svm->vmcb->save.isst_addr;
> +		break;
> +	case MSR_KVM_INTERNAL_GUEST_SSP:
> +		msr_info->data = svm->vmcb->save.ssp;
> +		break;
>  	case MSR_TSC_AUX:
>  		msr_info->data = svm->tsc_aux;
>  		break;
> @@ -2999,6 +3008,15 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>  		svm->vmcb01.ptr->save.sysenter_esp = (u32)data;
>  		svm->sysenter_esp_hi = guest_cpuid_is_intel_compatible(vcpu) ? (data >> 32) : 0;
>  		break;
> +	case MSR_IA32_S_CET:
> +		svm->vmcb->save.s_cet = data;

These writes should mark VMCB_CET (the dirty/clean flag) dirty, and obviously
KVM should mark VMCB_CET clean along with everything else on #VMEXIT.

> +		break;
> +	case MSR_IA32_INT_SSP_TAB:
> +		svm->vmcb->save.isst_addr = data;
> +		break;
> +	case MSR_KVM_INTERNAL_GUEST_SSP:
> +		svm->vmcb->save.ssp = data;
> +		break;
>  	case MSR_TSC_AUX:
>  		/*
>  		 * TSC_AUX is always virtualized for SEV-ES guests when the
> -- 
> 2.47.3
> 

