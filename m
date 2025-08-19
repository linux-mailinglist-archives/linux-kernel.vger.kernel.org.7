Return-Path: <linux-kernel+bounces-776368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ED8B2CC9F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FA916A085
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA3332255C;
	Tue, 19 Aug 2025 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ccn24TzN"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9153622FDEC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629785; cv=none; b=tGaAngbJHzttpPwJ5quE2a6NXhWsvX0UbKzlIuqg/5qS1UsMzE++7e+t56i4IY8sFRexvDWC/dyLIPBCRTk3S0GHaQKHbxG1FinvtPpjU/1KjYTTf2FdjLjZwG2MQ8XXgLXCAVRy+nUSnbsWMMhhOH+qSYAHrWNgmpciFtUu2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629785; c=relaxed/simple;
	bh=WuU2Wy5rZtrfG1+HznLL/QRzXucuMnryDBi9PESLIJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m1y3DoNdJxirvyQVsaxJp6Y8AY82BBYoTG32ajXsWcppCtN6GUlSn9phc8xzlKEqSsBzd226IhvZON09tIR1N/GdoTWCNUhWeTNHkQHDhViAkq8UWO+nNQpbFIy/jKiv0BHbXdBd3FnXUfpBDwnXq0qFIBaOCge2Crc/NY8ktLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ccn24TzN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e2506aso5293997a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755629783; x=1756234583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ztQu3jkFmd293zM84+KVmv6vWCMJtSpRl+06Kb99II=;
        b=ccn24TzNffIiccCe/TkEa2DXqrkG+kjtF0GqPWxEKoO/vTQiiMDmFDw8C95osSm9CW
         jG92w5SU6X82wSCvKL3v3JG+WXgoKRZW50q9AAuoZELBqt6xKEh6+xOjXeHmH8NZo24z
         92Pi3tKS1qtC1VxQXZzgwkfZAM+CQidaBMFKfMkc+rqSYiziUgE4yE45CBeULL+nX4gC
         xKcUa+L1VIstIk6WuEiGGsmrBNr8u+K0bwnZLurHYkX8cykZb40HAF9rBQCZyrtkSkfa
         lHN1ubpXhfjw8Hhw7nFFsvw+CtEVkc3+bJzFhjRNkJ3yyI/cdjFCxzd1CXf0OKv2CjAu
         vs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629783; x=1756234583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ztQu3jkFmd293zM84+KVmv6vWCMJtSpRl+06Kb99II=;
        b=NXg/qdLkT0b0mR2C28FCYpt0AY+BbjiiTBHPxVtx/zetwMlETUwWVyvJ7r3cCIz+u4
         HlQoL1ENWlmdjg2PGzMz96tcHER8+fTfdXNp2ohflyUkIXlBiPVVdJlW54hpOJtE/APJ
         ZjOTCikS7kb1EdEKOf6LeCzl3es7ymcKMbWkdmdGNDULKf4mQqGaLVtShPMuATGnP1i0
         k1pjBBwKmok+Fqu0fIras+GrWkxaeA+Zj4YPYBkIk8nCq62yY5XDNig96prDkMgwhLEo
         rdwMeGqN51RSJ7Qv27Ffu6eqHJJ5FcthapMdqS0fxonWtoVJT2XI4FvxN1KL9mv8NA8t
         Drxw==
X-Forwarded-Encrypted: i=1; AJvYcCWroZAwPYDsTJ9WAFCOkCQYN/8lOYJUEeQA2YUDPG3aZ3Uxcg/W4X3Kan3hEzw14x3AGZ0kYzAMoTepV50=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvnHzHcChZywgVwdd6m1FNqEwQbcSqC4GotuCfdZwa5QRBZ1Uf
	2HzFi2kVx5W09TCvmf4+0ayEMw3/2RAyVMzPQg1k97sah7B1y2fjTYZIMUbVnc03mInq8V3SmCz
	GFwG6Dw==
X-Google-Smtp-Source: AGHT+IHGH0ru+slN4c+0dxdrs3ouK8HHTWA+A3x2WcGNNRC9IyXtOeIqquo2QQkGLuu9//j0mr/5FwEF+X8=
X-Received: from pjbqc5.prod.google.com ([2002:a17:90b:2885:b0:31c:4a51:8b75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e70c:b0:312:e731:5a6b
 with SMTP id 98e67ed59e1d1-324e147375bmr250494a91.32.1755629782933; Tue, 19
 Aug 2025 11:56:22 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:56:21 -0700
In-Reply-To: <CAFULd4ZOtj7WZkSSKqLjxCJ-yBr20AYrqzCpxj2K_=XmrX1QZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807063733.6943-1-ubizjak@gmail.com> <aKSRbjgtp7Nk8-sb@google.com>
 <CAFULd4ZOtj7WZkSSKqLjxCJ-yBr20AYrqzCpxj2K_=XmrX1QZg@mail.gmail.com>
Message-ID: <aKTI1WOJAKDnkRyu@google.com>
Subject: Re: [PATCH] KVM: VMX: Micro-optimize SPEC_CTRL handling in __vmx_vcpu_run()
From: Sean Christopherson <seanjc@google.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 19, 2025, Uros Bizjak wrote:
> > >   2d: 48 8b 7c 24 10          mov    0x10(%rsp),%rdi
> > >   32: 8b 87 48 18 00 00       mov    0x1848(%rdi),%eax
> > >   38: 65 3b 05 00 00 00 00    cmp    %gs:0x0(%rip),%eax
> > >   3f: 74 09                   je     4a <...>
> > >   41: b9 48 00 00 00          mov    $0x48,%ecx
> > >   46: 31 d2                   xor    %edx,%edx
> > >   48: 0f 30                   wrmsr
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > Cc: Sean Christopherson <seanjc@google.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > ---
> > >  arch/x86/kvm/vmx/vmenter.S | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> > > index 0a6cf5bff2aa..c65de5de92ab 100644
> > > --- a/arch/x86/kvm/vmx/vmenter.S
> > > +++ b/arch/x86/kvm/vmx/vmenter.S
> > > @@ -118,13 +118,11 @@ SYM_FUNC_START(__vmx_vcpu_run)
> > >        * and vmentry.
> > >        */
> > >       mov 2*WORD_SIZE(%_ASM_SP), %_ASM_DI
> > > -     movl VMX_spec_ctrl(%_ASM_DI), %edi
> > > -     movl PER_CPU_VAR(x86_spec_ctrl_current), %esi
> > > -     cmp %edi, %esi
> > > +     movl VMX_spec_ctrl(%_ASM_DI), %eax
> > > +     cmp PER_CPU_VAR(x86_spec_ctrl_current), %eax
> >
> > Huh.  There's a pre-existing bug lurking here, and in the SVM code.  SPEC_CTRL
> > is an MSR, i.e. a 64-bit value, but the assembly code assumes bits 63:32 are always
> > zero.
> 
> But MSBs are zero, MSR is defined in arch/x86/include/msr-index.h as:
> 
> #define MSR_IA32_SPEC_CTRL 0x00000048 /* Speculation Control */
> 
> and "movl $..., %eax" zero-extends the value to full 64-bit width.
> 
> FWIW, MSR_IA32_SPEC_CTR is handled in the same way in arch/x86/entry/entry.S:
> 
> movl $MSR_IA32_PRED_CMD, %ecx

That's the MSR index, not the value.  I'm pointing out that:

	movl VMX_spec_ctrl(%_ASM_DI), %edi              <== drops vmx->spec_ctrl[63:32]
	movl PER_CPU_VAR(x86_spec_ctrl_current), %esi   <== drop x86_spec_ctrl_current[63:32]
	cmp %edi, %esi                                  <== can get false negatives
	je .Lspec_ctrl_done
	mov $MSR_IA32_SPEC_CTRL, %ecx
	xor %edx, %edx                                  <== can clobber guest value
	mov %edi, %eax
	wrmsr

The bug is _currently_ benign because neither KVM nor the kernel support setting
any of bits 63:32, but it's still a bug that needs to be fixed.

