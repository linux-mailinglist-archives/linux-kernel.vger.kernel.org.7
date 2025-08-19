Return-Path: <linux-kernel+bounces-776236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9995FB2CA61
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD7F7BAF3B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFAD2FDC21;
	Tue, 19 Aug 2025 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DNhtBOsy"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CB6277008
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623910; cv=none; b=h7AznFn5U39dr6PSUBP7aaBpQFqkMgFlGZwLzL0TGvH8g1Uy6jG7rhKTVGziyDUJDWJTg1aoPwitS5VUhgXR6HgoVyMgpNiQ7HaCN8dc7E9qd5lS/SjT2PpUTRYJxkdnYSIkNn3ncUTOxD8jQbKGqlfkuFy0NfqxSN82RGav8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623910; c=relaxed/simple;
	bh=PloZW4qYMq4Bc2fEvPDWXxdFo829T4fxjI9JYrCuCVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DAollQNhbaVG4L48ymWJ67HFtaQ6juGBgsgxNVFKBNbpC58Z7HS1lNCFuUA5g8ri9BSPYF3LKlW0rEs45hvbLmES1a/d/UHBMzPyXNvA6wz8kYoJEPQkTJa39LEdtBr8EoV0Q4LXycCan1qD7xIHYOcwNqTYG0VfXdD+GJPrLzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DNhtBOsy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3232677ad11so5201942a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755623908; x=1756228708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sdunIMtBL5Zf9ScbNPV0INPIlGpoPAUen4jDfBOFl4I=;
        b=DNhtBOsyJrD31FfRUr/wvPIqGLdF4LIJAEznTfltLv05Sb+OVrxQf66UV+zuFpoGWj
         nrbGJjc2IgNWpTdf1k2vAFa339EChYwUqUSy+Hie5FLWjbVuHGPA/v06H4Ru3bxyWHoO
         giS0Bk+MeQK+yuOGmZukfd51kyMsGbSfHrndcx8UVH96O+uRvCERy1H5ygKjFbB4JaxQ
         q7SNc3E+KVd5Goz0hoM0FQda+DzEbrkQ7i1DjqWujx7qH8k30AlRKC7/+6YEvnRiHqAe
         kAzJNjmyZj2tpmg6iAROtN/DZhQRyucGg0js9Buq5gWMCwZUuL76PXRIhRZUTNAYlSJ/
         JyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755623908; x=1756228708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdunIMtBL5Zf9ScbNPV0INPIlGpoPAUen4jDfBOFl4I=;
        b=erERptvfdgdqqyrFfECuoCUiU34ZOfCIRVS2172ICfNzkilIyNJjrmbcKNaaAX37qW
         4dZ2ct43sRy9IRiTjrYC/nHOuCCUJtBaVX3P93EcQbZmmcdWR29gHhFwxn372CdxcxvY
         AsiGU9cQlsn56JOu4ykZZ+uxuz/CiFu7ef7LI3Ij+XTncANz0UEEXRAerrPEBR0z6lh0
         bm3XGf08zVa/vQVf/3duBmgulM6iO9s4MJzF9P0b59cylYpZ+dOfPP1NLKf4nuVV6WCj
         D3bO2TJ7MOnylszfFsZ7yjcO4wFz6xC4p8Lc198cKORsOhbkNl8JoY2PSWl7yYt1Ng7v
         oG5g==
X-Forwarded-Encrypted: i=1; AJvYcCXkxaLWyiyFy+ahDKCqZgFtJK8LaWWr1m9NOJ6FTX/r0Olt9CWOiLcxyAvIBvV9TfEZx9sjoO3ud81y9Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvY+eDA9GvS8j6HpIWaqXqhzXEVJ0r30R4ZYSPLkUv1I7AQ96m
	K7D0+G+ns/PJVsTxseqku7CiC8vKqUTMqFOPMGIvoPqyJ3yaM4s++o+T+jRmSwX1anwQkbg3doS
	Ybqhyaw==
X-Google-Smtp-Source: AGHT+IExDY4f3mT+46JVokZkfLCwwzGNF9zAqmzjPJffqHmG05iwkQN4+z0jwppQ4klR4osxAofXnQTrOts=
X-Received: from pjwx11.prod.google.com ([2002:a17:90a:c2cb:b0:31e:998f:7b79])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5585:b0:315:fefe:bebf
 with SMTP id 98e67ed59e1d1-324e12e2848mr34966a91.13.1755623908148; Tue, 19
 Aug 2025 10:18:28 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:18:26 -0700
In-Reply-To: <20250812025606.74625-23-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812025606.74625-1-chao.gao@intel.com> <20250812025606.74625-23-chao.gao@intel.com>
Message-ID: <aKSx4gisPrcHdq1h@google.com>
Subject: Re: [PATCH v12 22/24] KVM: nVMX: Enable CET support for nested guest
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mlevitsk@redhat.com, 
	rick.p.edgecombe@intel.com, weijiang.yang@intel.com, xin@zytor.com, 
	Mathias Krause <minipli@grsecurity.net>, John Allen <john.allen@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 11, 2025, Chao Gao wrote:
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 618cc6c6425c..f20f205c6560 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -721,6 +721,27 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>  	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
>  					 MSR_IA32_MPERF, MSR_TYPE_R);
>  
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_U_CET, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_S_CET, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_PL0_SSP, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_PL1_SSP, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_PL2_SSP, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_PL3_SSP, MSR_TYPE_RW);
> +
> +	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
> +					 MSR_IA32_INT_SSP_TAB, MSR_TYPE_RW);

As with the "regular" support, I don't think MSR_IA32_INT_SSP_TAB needs to be
passed through (though it's entirely possible I'm missing/forgetting something).

> +
>  	kvm_vcpu_unmap(vcpu, &map);
>  
>  	vmx->nested.force_msr_bitmap_recalc = false;
> @@ -2521,6 +2542,32 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
>  	}
>  }
>  
> +static inline

Do not use "inline" for functions that are visible only to the local compilation
unit.  "inline" is just a hint, and modern compilers are smart enough to inline
functions when appropriate without a hint.

A longer explanation/rant here: https://lore.kernel.org/all/ZAdfX+S323JVWNZC@google.com


> void cet_vmcs_fields_get(struct kvm_vcpu *vcpu, u64 *s_cet,

I don't love the names, as it's not super clear what they are doing.  How about:

  vmcs_{read,write}_cet_state()

I like that vmcs_{read,write} matches the vmcs_{read,write}{l,16,32,64} helpers
(makes it clear they are reading/writing VMCS fields), and the cet_state connects
the dots to VM_EXIT_LOAD_CET_STATE (helps clarify which CET fields are accessed).

