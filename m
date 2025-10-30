Return-Path: <linux-kernel+bounces-878658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0327C21316
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFCF188C513
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1670366FBF;
	Thu, 30 Oct 2025 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lFMHd8O5"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB73678A1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841577; cv=none; b=pkp2YxmP/epheDMJNHtQozr8duDWPgZisrawtj6CozFBba/7qVKsWMlyJMIXF/KHN5GiWUA2pXmlTrOYNLjBPNXJWgrkuxb2UQWvXDlFCIAoYK2aw3otsK4mbJyD1aFm0DZISDOUbUJh3UB5DExn3e7L0E2j6TJxYCx6iY5jMTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841577; c=relaxed/simple;
	bh=eDmpmRV/ZNwGix8F1hLn2eltY/f5k4rXZJVH9UOROjI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OFpnjC2yV7Nqq3BMtTwYIzaJX/Bv0NFmocKuZ6FkINYZvm0xC+6DCRrRlvunXbLhdczGtkWP87jMKKLM0KCawWHhwJq1vOJ7V70UK9km2rBWUxmud7cZOh8MCKh0ssoYvBktGmaXG+42j8bqbDrvQQB8JaZQlu8+gL3HiifNGdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lFMHd8O5; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477124f7c00so7161775e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761841571; x=1762446371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mUcHikc00JVyhViII/UBbKRulbb7db3Z+EvGHwldIE=;
        b=lFMHd8O5EXMhnG8UfHZ9qKXwMFArzpKnC9RxKIg7pRNIOiv823N9R6ZvPk8OjeRrtf
         MQK/GoDc9Sp9O+x8YG0lG6Kcgv+e+Ls/wLmXE/wbPz0Wj9Mvd9zlX6IXP/mRQJTDk/dc
         B5IdTu/xttSK2MoUXcVGMUJL2iCdchNHUz9IesEW3F3KVJbuEM1Kl/GRjuOeo9lGAUq5
         fnsMHS/gb28vTVuc1Bf9U8g6N0bewl2+zX3hWnVnbgEBxSE7rjsq0Le3Srf28jzkJ8dP
         E94kf62m0/Qs5g1sbE7cLiHMC2I7U1HNFaf1ncteakltHB7BcR2rFCiEnKo8FY2tCrW2
         KfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761841571; x=1762446371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mUcHikc00JVyhViII/UBbKRulbb7db3Z+EvGHwldIE=;
        b=C3qCZmWHu6b3mOhKD5hAAF+v1wJbSGIGFmBGeCt96BJX7hk5mws0DNTXLn5W1N27e9
         Hh3IFLTsEF6iVEpvEv0/Y/B1w6yrqS6O+8bOf+JZT3U1lkS/GG8KtY+n6PVpTvYXx5gu
         IL56MhrJfOETo1uYhDxeE5/iAGJ+QeVjczRpQP8CTZE70P8PnMJH/4gVeW6c3zMmt9my
         glHE+yeoze2UheJburbaiidWpZSyzEa9DsrELuYvKqljQ7yNL8oeo/lXlkdklbChCqPI
         QBq0wIWqu7nEFNToBcTDuRRoujr3W3NFWHDzc84Us8KZ/EGT57a/cpzDrlgWJWqvTpmF
         iKWw==
X-Forwarded-Encrypted: i=1; AJvYcCWx3abl7en0tjlmWTgmZkeDITaNCmNAQR1nekrCGqG3TR2hpe9tqSiqcLdU9o8l8f0xWtXRZ4QwQdpBwXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzr3o6jAj3PCBypeRgRPmB3VPKt6UGH27BKu3wzeyiX78fxEfs
	tty9sIl8bwi2t5dLvXrZkFnT0bLRymFHk1TRS8ZY+FPbHHHPdIxdGVg2ROzj1U7wtITEYVUzZC6
	jJNoNCuYRfRyEKQ==
X-Google-Smtp-Source: AGHT+IFGfOI5GGOoZu/FznqScqK81s0PahXoAIRUX8rG/K1uKkyKen3uibwRjOLiewUxdMnOjmZhdmN8oKlvUw==
X-Received: from wmon4.prod.google.com ([2002:a05:600c:4644:b0:477:1162:935])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:198a:b0:477:bb0:5e0e with SMTP id 5b1f17b1804b1-477308a118dmr2613715e9.20.1761841571504;
 Thu, 30 Oct 2025 09:26:11 -0700 (PDT)
Date: Thu, 30 Oct 2025 16:26:10 +0000
In-Reply-To: <aQONEWlBwFCXx3o6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029-verw-vm-v1-0-babf9b961519@linux.intel.com>
 <20251029-verw-vm-v1-3-babf9b961519@linux.intel.com> <DDVO5U7JZF4F.1WXXE8IYML140@google.com>
 <aQONEWlBwFCXx3o6@google.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDVSPNXCG4HY.1B7OBAPDZ97CX@google.com>
Subject: Re: [PATCH 3/3] x86/mmio: Unify VERW mitigation for guests
From: Brendan Jackman <jackmanb@google.com>
To: Sean Christopherson <seanjc@google.com>, Brendan Jackman <jackmanb@google.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, <linux-kernel@vger.kernel.org>, 
	<kvm@vger.kernel.org>, Tao Zhang <tao1.zhang@intel.com>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu Oct 30, 2025 at 4:06 PM UTC, Sean Christopherson wrote:
> On Thu, Oct 30, 2025, Brendan Jackman wrote:
>> > @@ -160,6 +163,8 @@ SYM_FUNC_START(__vmx_vcpu_run)
>> >  	/* Load guest RAX.  This kills the @regs pointer! */
>> >  	mov VCPU_RAX(%_ASM_AX), %_ASM_AX
>> >  
>> > +	/* Check EFLAGS.ZF from the VMX_RUN_CLEAR_CPU_BUFFERS bit test above */
>> > +	jz .Lskip_clear_cpu_buffers
>> 
>> Hm, it's a bit weird that we have the "alternative" inside
>> VM_CLEAR_CPU_BUFFERS, but then we still keep the test+jz
>> unconditionally. 
>
> Yeah, I had the same reaction, but couldn't come up with a clean-ish solution
> and so ignored it :-)
>
>> If we really want to super-optimise the no-mitigations-needed case,
>> shouldn't we want to avoid the conditional in the asm if it never
>> actually leads to a flush?
>> 
>> On the other hand, if we don't mind a couple of extra instructions,
>> shouldn't we be fine with just having the whole asm code based solely
>> on VMX_RUN_CLEAR_CPU_BUFFERS and leaving the
>> X86_FEATURE_CLEAR_CPU_BUF_VM to the C code?
>> 
>> I guess the issue is that in the latter case we'd be back to having
>> unnecessary inconsistency with AMD code while in the former case... well
>> that would just be really annoying asm code - am I on the right
>> wavelength there? So I'm not necessarily asking for changes here, just
>> probing in case it prompts any interesting insights on your side.
>> 
>> (Also, maybe this test+jz has a similar cost to the nops that the
>> "alternative" would inject anyway...?)
>
> It's not at all expensive.  My bigger objection is that it's hard to follow what's
> happening.
>
> Aha!  Idea.  IIUC, only the MMIO Stale Data is conditional based on the properties
> of the vCPU, so we should track _that_ in a KVM_RUN flag.  And then if we add yet
> another X86_FEATURE for MMIO Stale Data flushing (instead of a static branch),
> this path can use ALTERNATIVE_2.  The use of ALTERNATIVE_2 isn't exactly pretty,
> but IMO this is much more intuitive.
>
> diff --git a/arch/x86/kvm/vmx/run_flags.h b/arch/x86/kvm/vmx/run_flags.h
> index 004fe1ca89f0..b9651960e069 100644
> --- a/arch/x86/kvm/vmx/run_flags.h
> +++ b/arch/x86/kvm/vmx/run_flags.h
> @@ -4,10 +4,10 @@
>  
>  #define VMX_RUN_VMRESUME_SHIFT                 0
>  #define VMX_RUN_SAVE_SPEC_CTRL_SHIFT           1
> -#define VMX_RUN_CLEAR_CPU_BUFFERS_SHIFT                2
> +#define VMX_RUN_CAN_ACCESS_HOST_MMIO_SHIT      2
>  
>  #define VMX_RUN_VMRESUME               BIT(VMX_RUN_VMRESUME_SHIFT)
>  #define VMX_RUN_SAVE_SPEC_CTRL         BIT(VMX_RUN_SAVE_SPEC_CTRL_SHIFT)
> -#define VMX_RUN_CLEAR_CPU_BUFFERS      BIT(VMX_RUN_CLEAR_CPU_BUFFERS_SHIFT)
> +#define VMX_RUN_CAN_ACCESS_HOST_MMIO   BIT(VMX_RUN_CAN_ACCESS_HOST_MMIO_SHIT)
>  
>  #endif /* __KVM_X86_VMX_RUN_FLAGS_H */
> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> index ec91f4267eca..50a748b489b4 100644
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
> @@ -137,8 +137,10 @@ SYM_FUNC_START(__vmx_vcpu_run)
>         /* Load @regs to RAX. */
>         mov (%_ASM_SP), %_ASM_AX
>  
> -       /* jz .Lskip_clear_cpu_buffers below relies on this */
> -       test $VMX_RUN_CLEAR_CPU_BUFFERS, %ebx
> +       /* Check if jz .Lskip_clear_cpu_buffers below relies on this */
> +       ALTERNATIVE_2 "",
> +                     "", X86_FEATURE_CLEAR_CPU_BUF
> +                     "test $VMX_RUN_CAN_ACCESS_HOST_MMIO, %ebx", X86_FEATURE_CLEAR_CPU_BUFFERS_MMIO

Er, I don't understand the ALTERNATIVE_2 here, don't we just need this?

ALTERNATIVE "" "test $VMX_RUN_CAN_ACCESS_HOST_MMIO, %ebx", 
	    X86_FEATURE_CLEAR_CPU_BUFFERS_MMIO

>  
>         /* Check if vmlaunch or vmresume is needed */
>         bt   $VMX_RUN_VMRESUME_SHIFT, %ebx
> @@ -163,8 +165,9 @@ SYM_FUNC_START(__vmx_vcpu_run)
>         /* Load guest RAX.  This kills the @regs pointer! */
>         mov VCPU_RAX(%_ASM_AX), %_ASM_AX
>  
> -       /* Check EFLAGS.ZF from the VMX_RUN_CLEAR_CPU_BUFFERS bit test above */
> -       jz .Lskip_clear_cpu_buffers
> +       ALTERNATIVE_2 "jmp .Lskip_clear_cpu_buffers",
> +                     "", X86_FEATURE_CLEAR_CPU_BUF
> +                     "jz .Lskip_clear_cpu_buffers", X86_FEATURE_CLEAR_CPU_BUFFERS_MMIO

To fit with the rest of Pawan's code this would need
s/X86_FEATURE_CLEAR_CPU_BUF/X86_FEATURE_CLEAR_CPU_BUF_VM/, right?

In case it reveals that I just don't understand ALTERNATIVE_2 at all,
I'm reading this second one as saying:

if cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUFFERS_MMIO)
   "jz .Lskip_clear_cpu_buffers "
else if !cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF_VM)
   "jmp .Lskip_clear_cpu_buffers"

I.e. I'm understanding X86_FEATURE_CLEAR_CPU_BUFFERS_MMIO as mutually
exclusive with X86_FEATURE_CLEAR_CPU_BUF_VM, it means "you _only_ need
to verw MMIO". So basically we moved cpu_buf_vm_clear_mmio_only into a
CPU feature to make it accessible from asm?

(Also let's use BUF instead of BUFFERS in the name, for consistency)

