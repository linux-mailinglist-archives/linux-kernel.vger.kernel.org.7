Return-Path: <linux-kernel+bounces-776361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83A8B2CC68
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C113B8469
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5425132A3D5;
	Tue, 19 Aug 2025 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PH8A3uEZ"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E3525A359
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629383; cv=none; b=MKjoLX0IZhLUkW8CW+AbksMxtNKlJhMW6NCgTmrsfcaEyRjCr3IYDW7J6nWcdzamtnfC60oj7eHZDlAaG/ZIswo2XgPYTUocbI6gPddfvLUTS7p93t0KCdpNQlxWCjyPPI4osa9UPvLBiHuohbvrCT92yHaYHoOmFVhxPAlUi28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629383; c=relaxed/simple;
	bh=zhBVg01D6vQm9RuF3UHdaJjFRXl8D7k5OdwAMNICiXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=npm6Z5/7yZykm/slYUJDLUNfSNHt/LOFnZCS5kEUk45ZoJkcg8I7ucQ2VD0PtrWmMYxMDmWY2343omb3kWXUTDzfAu9LE55xPZrfa7jB8hfOvGDxg2Xp5XVbWakSdsIEqZvMKWgTZJjj9OIoxO959ahjuviWbcr5XIjxMDIMq2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PH8A3uEZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eab5baaso4776653b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755629382; x=1756234182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qKCot010HQbarPNzVF5yNUqaoOyh2peZV1sFaUn75Ic=;
        b=PH8A3uEZUNzpMeTLkHc4iGsJsnBjclC2eaK31oFRDJgyC+X3LAt1Suxe2AU2hWXRO5
         MRq2sbYd7BJ6Ghn+7LYakm/CJt9onHTs85dTTVVx1jxShi3Yb8vT/tM7bWN/4oJhFmNv
         YFGSPURIoKSGYdjiyPwHUiivrY9Xr8ftFOsZWOnridXSkPTeMQSwyt/PXKVp9IKQGilQ
         r3tnnwrNZTi4Is3EgjGMn/pUBm3E6MuoBUvbQtjsthqWZ4rI9Otw3Cu8t1P11RQ84iHU
         Bk5waLSawXQBvw/j0VSvBoFKRsvP7nUa01Ra5S/3zUzBrp9125ZdNY5+TtSdcwAKFu4C
         qgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629382; x=1756234182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKCot010HQbarPNzVF5yNUqaoOyh2peZV1sFaUn75Ic=;
        b=TaljT51mAw+u+1YO4LCuxDajRoObfdQ3S12rvgJEjYSpoFnvRrvLJJUyjTj9zCu2fV
         +ztnf0FnU7XEQa5XbR45/pb/28C0ScyMkIx1jJM8+B+VXNZXhAjj/SUw8W8W1H7840iX
         yjslU4fYB26bB0RfhC8uIiAQn4JOheyuuEtrEkHyL+WnSPoGVpqU/00j3y8Mg8j7ahk2
         ZRBPC7FwGDOPshtmcyvoiwD1Nc8Ro7YKo5carWx94tWmCKiZw+EHdve94LJZLynfosUC
         HSvQYzrBcZWi0N1Xg3sd8Qwy3yqVy88X+OxOaBcfHvpcyRzRmBRSOcl57+5wvtTl5sc/
         /+rA==
X-Forwarded-Encrypted: i=1; AJvYcCVrujPSFbLx+HKKjTnZu7fglTR2UrAumTaBdTMHqnNU6kgmog8T7zGYquEzRSTtDuk2d7Hmht+vpClKfjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjTcOhd8fusdARQE7l8mFLqwLzG41EC4reg3MFcKYSeXQi7jvG
	nI2Q5/vbhlixrnIvBubucJOY0Wq0RM8OvMkNRF+UgC4YRP1fV9ZyxBqEp+2nBWWsXOJkHQH+J1g
	WhfYugw==
X-Google-Smtp-Source: AGHT+IEPXJJEVVaEr0HlKWjuZtNNp8HqiYSVkSRVGalYVQejsfDKZi6uLR+yoQTXywGOzB+1SmwrmpxGgWM=
X-Received: from pfig9.prod.google.com ([2002:aa7:8189:0:b0:746:18ec:d11a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:92a3:b0:76e:5bec:5ee4
 with SMTP id d2e1a72fcca58-76e8dc8e566mr314845b3a.13.1755629381622; Tue, 19
 Aug 2025 11:49:41 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:49:40 -0700
In-Reply-To: <20250812025606.74625-21-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812025606.74625-1-chao.gao@intel.com> <20250812025606.74625-21-chao.gao@intel.com>
Message-ID: <aKTHRKKr4C-c2LZy@google.com>
Subject: Re: [PATCH v12 20/24] KVM: x86: Enable CET virtualization for VMX and
 advertise to userspace
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
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index ce10a7e2d3d9..c85c50019523 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -134,6 +134,7 @@
>  #define VMX_BASIC_DUAL_MONITOR_TREATMENT	BIT_ULL(49)
>  #define VMX_BASIC_INOUT				BIT_ULL(54)
>  #define VMX_BASIC_TRUE_CTLS			BIT_ULL(55)
> +#define VMX_BASIC_NO_HW_ERROR_CODE_CC		BIT_ULL(56)
>  
>  static inline u32 vmx_basic_vmcs_revision_id(u64 vmx_basic)
>  {
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 85079caaf507..2515b2623fb1 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -944,6 +944,7 @@ void kvm_set_cpu_caps(void)
>  		VENDOR_F(WAITPKG),
>  		F(SGX_LC),
>  		F(BUS_LOCK_DETECT),
> +		F(SHSTK),

I think we should limit this to 64-bit kernels with X86_64_F().  It probably
won't change anything in practice, but we mitigate the virtualization holes related
to 32-bit vCPUs at least a little bit.

>  	);
>  
>  	/*
> @@ -970,6 +971,7 @@ void kvm_set_cpu_caps(void)
>  		F(AMX_INT8),
>  		F(AMX_BF16),
>  		F(FLUSH_L1D),
> +		F(IBT),
>  	);
>  

