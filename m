Return-Path: <linux-kernel+bounces-604132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C2DA890FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 03:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B39189BD54
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 01:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102E4136349;
	Tue, 15 Apr 2025 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2RTBR9bI"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071EEA927
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 01:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744679097; cv=none; b=ZPmm0vAXKh7VRhX954E+DWzCGdiWQaAL42ESWSBXk3M5BqDVAUcAjFid0Zrhvu2xyyd7zphVyPDsHlunlorSvm36zg99Q3wnxF/3HFmkoGFBianXpaNMxLys+4SNPirNdMI7X/sqzGLKHxBYtFgQcRNf9V9qJE2EMJsFtOr63Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744679097; c=relaxed/simple;
	bh=XooZ/f4TiYmPULUQaXULiGvnRYi+NYIA50kuHou9MGs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MKf+zvuhJEGgDK9fnO+wzSOrqH7is04xlBhtcCOsmasLg0G/JZkNoYe+47/S2qigzJE/b6DETWFNV7Zl8B4mVXvQNCcfQEz6dYqv75WbXM+cjJpZe2Soyl6MbtHQwV/ngPUA28dbrRb3x+2KzaBcLXxVKPsMOqyOtpv8rrkLFkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2RTBR9bI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736b431ee0dso3528033b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 18:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744679095; x=1745283895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HwEPhkJYP4jHZW6lICXAbTPoDZvwoZbdqFIrWOLvgAk=;
        b=2RTBR9bIi5L3ORxk4pUbpUe0ejp0LfNk59/K33uCM7by763oE25ZHcr8aX5LPs8U1H
         600B/fWgDXbnxcuBaDOhzaZWGiHnCQti0J/0pTbLbyNqYf7RyWBxWiWFMb1YjO+5mmDE
         kXtYQl6iYvjvBQTBTb6ZPJ3MxJWXMJoCR4nw7u0/aV0/fwJlA6/xIAlBsOvORJqjLXin
         WhQYwgZ5HV08zovYHgkdUc1SAIrv7NRh367qqG1vLqjq/wsPoUMK88Skw8WKFVlwf/58
         DTQZIGuvAxgwa1z9cW0LpInPMxEeaD/dEypy1cnQzsqBJ4EJ3Efr/nhti2jMLHGAbSI0
         v3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744679095; x=1745283895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HwEPhkJYP4jHZW6lICXAbTPoDZvwoZbdqFIrWOLvgAk=;
        b=VuGoYlps3dB90RIF/lIo3eKa0LInRSjwAXLxVkcjcztHLgJn4ZCRvhd3tJa+Dmc6xZ
         CE4KBstSSydQjeEgYS+16PG1qBR6aScQ45+YYTkfz3x2/9kQhk1w0DO1mD7D/z72ZCvN
         /Rz2IBzkeZynLWvZD2OG6FPZ01987PR2hDD0MqjaS4oq1YFUjyQqmmmWmWJqf8lC6xjp
         5p+1Gb7MrS6otnA+tBX1WCbRckl/qxpkqSmeJwbELwR1o9C/X0t8rd5a4gf+sG9sHyO2
         gbq/FxyTdER9Zbe9mqPzl9CCmUufglwqesJHJZ7TKmArfqjZamnSQ6kDE3C2EXtyjUfn
         F5Tw==
X-Forwarded-Encrypted: i=1; AJvYcCX2ps74wORuKiXk72eINTjhL9Ir0MUtew+XHfBKDB66Rr5XMGR54G4VIFEfWuVWJ5k03ELz1SGamdOwEKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuL4IkIljb36Q1xwrWFO0N0RniTRcsPDEtf0rf318Ra49WaNmD
	nlp+QLwJy2zkyiHeCmAhJ5X0zpHnbIStsXzi7dXiHITdMrzajMEBpDVYB6+xbu8K5y3BTiTZP0A
	9xQ==
X-Google-Smtp-Source: AGHT+IFXmc+2Aq9ymMVi0Xu5a/XBZEugGWhhYiyOKpCaZ8Hm7AQ7AjvPCxt2y5P8+quyHAjWH2XrQompP+w=
X-Received: from pfbfc2.prod.google.com ([2002:a05:6a00:2e02:b0:736:9d24:ae31])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4f92:b0:201:85f4:ad0a
 with SMTP id adf61e73a8af0-20185f4bb86mr15672211637.30.1744679094931; Mon, 14
 Apr 2025 18:04:54 -0700 (PDT)
Date: Mon, 14 Apr 2025 18:04:53 -0700
In-Reply-To: <20250414081131.97374-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414081131.97374-1-ubizjak@gmail.com>
Message-ID: <Z_2wtfAAxb5uNP4g@google.com>
Subject: Re: [PATCH 1/2] KVM: x86: Use asm_inline() instead of asm() in kvm_hypercall[0-4]()
From: Sean Christopherson <seanjc@google.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

Nit, this is guest code, i.e. should use "kvm/x86:" for the scope.  No need to
send a new version just for that.

On Mon, Apr 14, 2025, Uros Bizjak wrote:
> Use asm_inline() to instruct the compiler that the size of asm()
> is the minimum size of one instruction, ignoring how many instructions
> the compiler thinks it is. ALTERNATIVE macro that expands to several
> pseudo directives causes instruction length estimate to count
> more than 20 instructions.
> 
> bloat-o-meter reports minimal code size increase
> (x86_64 defconfig, gcc-14.2.1):
> 
>   add/remove: 0/0 grow/shrink: 1/0 up/down: 10/0 (10)
> 
> 	Function                          old     new   delta
> 	-----------------------------------------------------
> 	__send_ipi_mask                   525     535     +10
> 
>   Total: Before=23751224, After=23751234, chg +0.00%
> 
> due to different compiler decisions with more precise size
> estimations.
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/include/asm/kvm_para.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
> index 57bc74e112f2..519ab5aee250 100644
> --- a/arch/x86/include/asm/kvm_para.h
> +++ b/arch/x86/include/asm/kvm_para.h
> @@ -38,7 +38,7 @@ static inline long kvm_hypercall0(unsigned int nr)
>  	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>  		return tdx_kvm_hypercall(nr, 0, 0, 0, 0);
>  
> -	asm volatile(KVM_HYPERCALL
> +	asm_inline volatile(KVM_HYPERCALL
>  		     : "=a"(ret)
>  		     : "a"(nr)
>  		     : "memory");
> @@ -52,7 +52,7 @@ static inline long kvm_hypercall1(unsigned int nr, unsigned long p1)
>  	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>  		return tdx_kvm_hypercall(nr, p1, 0, 0, 0);
>  
> -	asm volatile(KVM_HYPERCALL
> +	asm_inline volatile(KVM_HYPERCALL
>  		     : "=a"(ret)
>  		     : "a"(nr), "b"(p1)
>  		     : "memory");
> @@ -67,7 +67,7 @@ static inline long kvm_hypercall2(unsigned int nr, unsigned long p1,
>  	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>  		return tdx_kvm_hypercall(nr, p1, p2, 0, 0);
>  
> -	asm volatile(KVM_HYPERCALL
> +	asm_inline volatile(KVM_HYPERCALL
>  		     : "=a"(ret)
>  		     : "a"(nr), "b"(p1), "c"(p2)
>  		     : "memory");
> @@ -82,7 +82,7 @@ static inline long kvm_hypercall3(unsigned int nr, unsigned long p1,
>  	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>  		return tdx_kvm_hypercall(nr, p1, p2, p3, 0);
>  
> -	asm volatile(KVM_HYPERCALL
> +	asm_inline volatile(KVM_HYPERCALL
>  		     : "=a"(ret)
>  		     : "a"(nr), "b"(p1), "c"(p2), "d"(p3)
>  		     : "memory");
> @@ -98,7 +98,7 @@ static inline long kvm_hypercall4(unsigned int nr, unsigned long p1,
>  	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>  		return tdx_kvm_hypercall(nr, p1, p2, p3, p4);
>  
> -	asm volatile(KVM_HYPERCALL
> +	asm_inline volatile(KVM_HYPERCALL
>  		     : "=a"(ret)
>  		     : "a"(nr), "b"(p1), "c"(p2), "d"(p3), "S"(p4)
>  		     : "memory");
> -- 
> 2.49.0
> 

