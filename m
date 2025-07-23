Return-Path: <linux-kernel+bounces-743068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9A2B0FA23
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258773A41B1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752B922B5A3;
	Wed, 23 Jul 2025 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bs6mBIDH"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844472264D6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294750; cv=none; b=cbQMh9DRYkYP/ZuWqLBkqXj2iLY2ZBE+MMb5rVGHKDOVhEL9fYDfkknT+lySl2mtdzd7TJ6qLTtOmi5WGRkUELvbavrrUqWBwANkLfylBgGzNElaUVY9oWgCzyJuHUXKGsVru9OFzk2Un4vCXooDQ9JfJ3Ekxlj4kRPrjqJtVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294750; c=relaxed/simple;
	bh=zdSvmSkd0NmmjOsTjLY3Hz7lD1LJ6biSJtMpZav9cQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c5O/40tvfcRcQ7994lfeVS3myNrHhocOv2kEwObXwmHDPtl8I8LqU8WLHMD71MStscqLyY8paKWkFJpTvz0sGdcIdoKyJl4nLW1P2jd3l2NzAcrulYJwPbqVt1rqFTZPW0EwHaLbLuOGys1wb0u7SnKIcSlQHJ9UFHOE5aTjeOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bs6mBIDH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138e64b3f1so163858a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753294748; x=1753899548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+mgjRhl7QeLuKE3QQ3pMAhg0iltdJ7SjGRF1SJi7olo=;
        b=bs6mBIDH8E+2GKoq+1nehpbsfpj9Wm0TQ7RoOWCwVJltLkoWgW4eJaLtg9FoHWFtcZ
         Jn+QAIuVLpUMr9GmV2oRcLpjoKfUjQIqw5fgrgf7mDzGqOk0Y5B4WJA/c5R+oi6jRcmS
         8zvQRxhb5Ovupr+PNKyvJ3RWzYpIPWTibWimERx/supPFZRGliNrCGjVRWccjRii4jiQ
         Da6NmJolJlp+bxThc6COPjFf7ovwSFJofjIDHM42vx+Dxp/RMejxof0LW8UjE/9qG5Ig
         SvKs0KBgZQyXkj/6kEcB/+HAbraW1T4ntPFx3KCHHjrPO86PwsIbN1Xa6CbJ86DOUUcX
         3Cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753294749; x=1753899549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mgjRhl7QeLuKE3QQ3pMAhg0iltdJ7SjGRF1SJi7olo=;
        b=i9+Q/sZ8pqTru5vzJXSlkJlnAFDMZneDXpCqSe5Rqe16wifP52MPxjPu7XRSD+gptp
         qz5u9Cmi/JXZqGki1rPXmcDIOmXKPKYiOiU/WMH0sPtYdNxqyahuxaepZ6hBoHzHdg6v
         DdyA/BH3T3jdARMZHBgz/4TS/xedbG+dBQDc3VA50YW3Avbmg+Ie1ge/PdRcBL1HztM1
         ISIijo+yE7EmITf/89I+JEgE7ivlIR4JaX0H8BAICyPpkPm/j1+nSSoEfk6eA+A6ym1v
         pbVHqBO2GI6BwzA25okue6mF8OuFrWCPPWwNYIVzoc3G7nokzS6LfInY/clAFd+nWCSd
         Wyzg==
X-Gm-Message-State: AOJu0Yw6XpePmecOGU5kx25oH76CD3gm5dba9Cjo5MDMVqAC5qHWtAlL
	rmoa/LeB2lHPxWpXcI0bpLVr5FhYH4xxBE5FpmrY+Y7F0chicyaKSFHS3KMpP18/xd5XkcU6Trg
	PVFqaFw==
X-Google-Smtp-Source: AGHT+IF0icnWbWtzPJKSEKwjPNwYePDm/cMvEUI0qVfn/lywtl0EFsLb8tVoT1AeoKBbG2DyCjC/dY5y6V8=
X-Received: from pjx3.prod.google.com ([2002:a17:90b:5683:b0:311:7d77:229f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:47:b0:314:2840:8b21
 with SMTP id 98e67ed59e1d1-31e507fe4femr5047003a91.32.1753294748695; Wed, 23
 Jul 2025 11:19:08 -0700 (PDT)
Date: Wed, 23 Jul 2025 11:19:07 -0700
In-Reply-To: <20250422161304.579394-5-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250422161304.579394-1-zack.rusin@broadcom.com> <20250422161304.579394-5-zack.rusin@broadcom.com>
Message-ID: <aIEnm7Y1VN-PCfF8@google.com>
Subject: Re: [PATCH v2 4/5] KVM: x86: Add support for legacy VMware backdoors
 in nested setups
From: Sean Christopherson <seanjc@google.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Doug Covelli <doug.covelli@broadcom.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 22, 2025, Zack Rusin wrote:
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 04c375bf1ac2..74c472e51479 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -22,6 +22,7 @@
>  #include <asm/debugreg.h>
>  
>  #include "kvm_emulate.h"
> +#include "kvm_vmware.h"
>  #include "trace.h"
>  #include "mmu.h"
>  #include "x86.h"
> @@ -1517,6 +1518,11 @@ int nested_svm_exit_special(struct vcpu_svm *svm)
>  			 svm->vcpu.arch.apf.host_apf_flags)
>  			/* Trap async PF even if not shadowing */
>  			return NESTED_EXIT_HOST;
> +#ifdef CONFIG_KVM_VMWARE
> +		else if ((exit_code == (SVM_EXIT_EXCP_BASE + GP_VECTOR)) &&
> +			 kvm_vmware_wants_backdoor_to_l0(vcpu, to_svm(vcpu)->vmcb->save.cpl))
> +			return NESTED_EXIT_HOST;
> +#endif

Either provide a stub or do

		else if (IS_ENABLED(CONFIG_KVM_VMWARE) && ...)

Don't do both.  And definitely don't add a stub and #ifdef (some) callers.  I'd
say just drop the #ifdef and rely on the kvm_vmware_wants_backdoor_to_l0() stub
to get the compiler to optimize out the entire elif.

> @@ -6386,6 +6387,11 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vcpu *vcpu,
>  			return true;
>  		else if (is_ve_fault(intr_info))
>  			return true;
> +#ifdef CONFIG_KVM_VMWARE
> +		else if (is_gp_fault(intr_info) &&
> +			 kvm_vmware_wants_backdoor_to_l0(vcpu, vmx_get_cpl(vcpu)))
> +			return true;
> +#endif

Same thing here.

