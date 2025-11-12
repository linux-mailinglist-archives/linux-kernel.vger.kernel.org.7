Return-Path: <linux-kernel+bounces-897469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FF6C53112
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB9A8502B82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F2D347FDF;
	Wed, 12 Nov 2025 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3YuHf5SR"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7D533D6FE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958878; cv=none; b=UCjV/21msWaT0Nqj9WXsk7BCoE1FJ2hGJNv1ldw5djANi4zDfNQuFQnl1C+OrXvj+lKXpy6iLhP5HlYm3mEJntvGwHPdLrN3WhmSg/Q8W3KPrHe+7Jp+cfYR41mO/VP0SNwLQCm47HbBvT3ks2Gca4AnCCi5g4H/p0YW07Al5kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958878; c=relaxed/simple;
	bh=YDzjPhwh/YmcA6SqNpLTKOVVeIo20EydY7pnz2FTKKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=umNKayd6pxF9CKEC2+9N9ghxF7iJ2IGuBmDLWEe74JHBwrGXSRnbCdGjhSEPvvu0suedfzE2xOxRQllp5om94rbXT6TBxQaL3kyg8fTExBhO6MKVuLKPDISMyfY9D2R7Eev3ZCGFTpoqWsCRRz8udBbwwWMGiYFD7YaizbDwPAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3YuHf5SR; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b98e6ff908aso2055688a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762958876; x=1763563676; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZN98J6jRf1XQ1vL4VVbjTVCscmeEznPH5HyoPAKAoA=;
        b=3YuHf5SR6raGLIp6G9cNF1ftMAWS3uUyODQP7QkY1TzWuNO2j1WCtjJ3fTp9Tbe+hy
         Bxqr1daq2HimDlJty5FZxN3m5uC3ocqfuEzbrvTFm6aF5Tci+cYHKTPO2/XUJ7cK4fyR
         8HLazX5U4DUogXVhtAaZ5MRtQXij0z+tct8SbVA4hA57YnMiIBK75cv8rKiOQGLNBbEg
         5BUqPHmCXJUUhJQZqYE2yOne+syJkkNj/JlXk4FXOO1EA0GLVnfR5qziZxUeksgUKrJI
         KwdVQ35aRWXIRnwpPyF56hS/cI2WkgphGZc3tBZZ/nyqM7X6hlBE20RqBUa1e95a43Ee
         31kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762958876; x=1763563676;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZN98J6jRf1XQ1vL4VVbjTVCscmeEznPH5HyoPAKAoA=;
        b=KBsUaSh/kxh3ld4Xl0cVIsrYKCziyjnUv69B+JniBpctK/zRKy4zh1qbV4WuWlrQQm
         DPTpeVDjp2OIYX3jSdugrpmYIWVNh9ikCzLe4gQYSRZwlodH+lkpRt+z7EJAmCud28rN
         G//kp0I/hmu5nDonTfsnUAwhDPogkqt1srvN2ZHZWVLycGDp3UM5hMN05u10yff/O044
         Vd91/6FN6I86nDPojzUupje/3I9pQhg5QIY0OlMksajsE73FU+K1SH1IIf9LHsU9/CV4
         yxerMRUcU9lhxdkjlqXkF6cBwN3YpmccxiZw2pP8CZ5jokgQVl6fQHvekvdnMIVmFdEi
         czMA==
X-Forwarded-Encrypted: i=1; AJvYcCXGOWFRU4XRdOVhMIRU3hwuRhxR6p9Gf+zFR5K4rvp1wkWrqfAPIC6jTYfNJHz+6BzdI4xQf0gAHTHYzFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaeEQlup4JojxZ72T3onhOxzpp0qVYDytEKWS75quLdcZIibq+
	B4zwy3Fv6pib44uIw6Ye3mlgKfH/9Qg+2OndFktIBTceZSGuP/O9KttVnfw30FASCXJ0ReG+I04
	9pTjhPQ==
X-Google-Smtp-Source: AGHT+IEJQY+2nepVgKrdsQRjbtkTvRt1EmAqv3YmsLcQnJsTwrWBXxD/UMCNxR4bYISKXGGAoW4cTuYzLhg=
X-Received: from pgve25.prod.google.com ([2002:a65:6499:0:b0:b55:6eb3:fd4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:99a0:b0:359:c3:c2ec
 with SMTP id adf61e73a8af0-3590ae34159mr4418503637.35.1762958875737; Wed, 12
 Nov 2025 06:47:55 -0800 (PST)
Date: Wed, 12 Nov 2025 06:47:54 -0800
In-Reply-To: <20251110063212.34902-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251110063212.34902-1-dongli.zhang@oracle.com>
Message-ID: <aRScMffMkpsdi5vs@google.com>
Subject: Re: [PATCH v2 1/1] KVM: VMX: configure SVI during runtime APICv activation
From: Sean Christopherson <seanjc@google.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	chao.gao@intel.com, pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, joe.jin@oracle.com, 
	alejandro.j.jimenez@oracle.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Nov 09, 2025, Dongli Zhang wrote:
> ---
> Changed since v2:
>   - Add support for guest mode (suggested by Chao Gao).
>   - Add comments in the code (suggested by Chao Gao).
>   - Remove WARN_ON_ONCE from vmx_hwapic_isr_update().
>   - Edit commit message "AMD SVM APICv" to "AMD SVM AVIC"
>     (suggested by Alejandro Jimenez).
> 
>  arch/x86/kvm/vmx/vmx.c | 9 ---------
>  arch/x86/kvm/x86.c     | 7 +++++++
>  2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f87c216d976d..d263dbf0b917 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6878,15 +6878,6 @@ void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
>  	 * VM-Exit, otherwise L1 with run with a stale SVI.
>  	 */
>  	if (is_guest_mode(vcpu)) {
> -		/*
> -		 * KVM is supposed to forward intercepted L2 EOIs to L1 if VID
> -		 * is enabled in vmcs12; as above, the EOIs affect L2's vAPIC.
> -		 * Note, userspace can stuff state while L2 is active; assert
> -		 * that VID is disabled if and only if the vCPU is in KVM_RUN
> -		 * to avoid false positives if userspace is setting APIC state.
> -		 */
> -		WARN_ON_ONCE(vcpu->wants_to_run &&
> -			     nested_cpu_has_vid(get_vmcs12(vcpu)));
>  		to_vmx(vcpu)->nested.update_vmcs01_hwapic_isr = true;
>  		return;
>  	}
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b4b5d2d09634..08b34431c187 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10878,9 +10878,16 @@ void __kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
>  	 * pending. At the same time, KVM_REQ_EVENT may not be set as APICv was
>  	 * still active when the interrupt got accepted. Make sure
>  	 * kvm_check_and_inject_events() is called to check for that.
> +	 *
> +	 * When APICv gets enabled, updating SVI is necessary; otherwise,
> +	 * SVI won't reflect the highest bit in vISR and the next EOI from
> +	 * the guest won't be virtualized correctly, as the CPU will clear
> +	 * the SVI bit from vISR.
>  	 */
>  	if (!apic->apicv_active)
>  		kvm_make_request(KVM_REQ_EVENT, vcpu);
> +	else
> +		kvm_apic_update_hwapic_isr(vcpu);

Rather than trigger the update from x86.c, what if we let VMX make the call?
Then we don't need to drop the WARN, and in the unlikely scenario L2 is active,
we'll save a pointless scan of the vISR (VMX will defer the update until L1 is
active).

We could even have kvm_apic_update_hwapic_isr() WARN if L2 is active.  E.g. with
an opportunistic typo fix in vmx_hwapic_isr_update()'s comment (completely untested):

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 0ae7f913d782..786ccfc24252 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -774,7 +774,8 @@ void kvm_apic_update_hwapic_isr(struct kvm_vcpu *vcpu)
 {
        struct kvm_lapic *apic = vcpu->arch.apic;
 
-       if (WARN_ON_ONCE(!lapic_in_kernel(vcpu)) || !apic->apicv_active)
+       if (WARN_ON_ONCE(!lapic_in_kernel(vcpu)) || !apic->apicv_active ||
+                        is_guest_mode(vcpu))
                return;
 
        kvm_x86_call(hwapic_isr_update)(vcpu, apic_find_highest_isr(apic));
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 91b6f2f3edc2..653b8b713547 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4430,6 +4430,14 @@ void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
                                                 kvm_vcpu_apicv_active(vcpu));
 
        vmx_update_msr_bitmap_x2apic(vcpu);
+
+       /*
+        * Refresh SVI if APICv is enabled, as any changes KVM made to vISR
+        * while APICv was disabled need to be reflected in SVI, e.g. so that
+        * the next accelerated EOI will clear the correct vector in vISR.
+        */
+       if (kvm_vcpu_apicv_active(vcpu))
+               kvm_apic_update_hwapic_isr(vcpu);
 }
 
 static u32 vmx_exec_control(struct vcpu_vmx *vmx)
@@ -6880,7 +6888,7 @@ void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
 
        /*
         * If L2 is active, defer the SVI update until vmcs01 is loaded, as SVI
-        * is only relevant for if and only if Virtual Interrupt Delivery is
+        * is only relevant for L2 if and only if Virtual Interrupt Delivery is
         * enabled in vmcs12, and if VID is enabled then L2 EOIs affect L2's
         * vAPIC, not L1's vAPIC.  KVM must update vmcs01 on the next nested
         * VM-Exit, otherwise L1 with run with a stale SVI.

