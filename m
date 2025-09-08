Return-Path: <linux-kernel+bounces-806678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD3AB49A4A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2DB175919
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123A02D3A9E;
	Mon,  8 Sep 2025 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oP4A1pOo"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F852BE7C3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757360805; cv=none; b=GijB6Jvj6QwRttU+TaObTOnXv+32Pf5BVLe6St4mlML195Dyp2dumREX5UkioMB8VLfBsLX1KjgcEF2/vZHAtRrT2P/OEHiyCxMrW4gwfk0jKvgxopVTMdif6LoqIEkhHYJ7XsmiVlM7L+t1ggsVaEPiHqGftmUITaH4Nk+KBFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757360805; c=relaxed/simple;
	bh=OR45YgabH7Xzwh9KWzzPc1daGgk0Nr/x02ecaLsxgSs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bnHl5P/tUQhe0VPyHRLP4SQ7pU4PpWPc2Ll2OYYeVPmthUekPFf3LVbiw7boykZxRigIVlIYSMmjX1UulZIlkPf0R2TWvk6udHNdNjXgdpuvwoldNum0Zkx4W+074NH+V4Ool8r+HzUPH9TNUDbBhu0Sq2K97yd8bukmTaVhq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oP4A1pOo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24ca417fb41so56589585ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757360803; x=1757965603; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OtuFE8fz0uXe9VtzwZec8xI+z6SKpPfaDmAZDtJxuFo=;
        b=oP4A1pOo8K7zMGwGhdn8TaZX07j3rFwXsfVbgMoolBCly4Dd5KjVT311E28xLeYmFm
         Pdc9K04h7U7ODJXEsYIufIB1JI/E3y0SJT7k3LuLGpnQCJEpMqWzkIslSqZ1wFTplYK7
         l+mkbqRDyQLSfX2yRUGeaJ2976eSZDG6Ef831K60L+K4yCunsJ1pItTnUzSilUiLPyNN
         Sv3AO7Dvq+KPZhfFQizdfDh3FHVG8jO4nZbrEQCLi6ux1SUCv2CG/8l4rLDAO88ZFvYv
         SAfxTrbodTk8OMLn8ss/RlDHQNcbwGt8/2blEvDLYjYu+8PhBW79j//cLyieoJXaG+wE
         M1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757360803; x=1757965603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OtuFE8fz0uXe9VtzwZec8xI+z6SKpPfaDmAZDtJxuFo=;
        b=YrDNTTZc4dtloT9KX24CftpksdsZ3MGXQqProW+EMyGw3Ib7QurNIPj2CKZ/6S7m/l
         0y3T1RUr0gVKI9eXVGAsXKYE+lILkCio9Qx8RO5iMt9V1phpiHhIYcgUnxrpGtQwmkPR
         BmbGUpA0X6QdS5kgCwpPRWHnRC8raUTh0f9MGzs2HwZEDA9jXKPdOFy0lSec8+R3Iy7H
         EG5BzRMeXWO0rZ2rV+C2Y5Uox2BWq5825yVvyuhbu/zr3mcYJFNXERTqLC9FSynzQ+vW
         nmnZUVO2HbX4aKBIolxF8MewLaG3z5CAvkMHAicrlgYgbJmWmydBlVc+vEuvYdte2ugw
         /p2w==
X-Forwarded-Encrypted: i=1; AJvYcCVvW8uM6D16T1sfRqaXTNPyk6V7X8I4AUJeUXaxL6Np06Xa1Qadfa1V3k/BEWRQr9s6pwS5Gpw7Lu1akhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXbJiQ9+TsK9VT+QtTDrTRpOCtez0Ahzijv9k1CXM+whOO/r9W
	9vDiFPRKnprOzrzfeJ27iVT4FdGwUt3r7PkiRFXBML3pWLdUKW3gqpZAdpkYRBlFpOORmBrKvWP
	5IY/JWg==
X-Google-Smtp-Source: AGHT+IFb1neEFkxq+1aKM895lwflQXUWxZfzQ3TkgAtLxYrbO6zawNDmMq2mZAuMldFhSu9Kf+nu0tLZnJY=
X-Received: from pjeb1.prod.google.com ([2002:a17:90a:10c1:b0:32b:b3c4:a304])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec8e:b0:24e:e5c9:ed14
 with SMTP id d9443c01a7336-251734f2fbemr125000785ad.35.1757360803162; Mon, 08
 Sep 2025 12:46:43 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:46:41 -0700
In-Reply-To: <20250819090853.3988626-4-keirf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819090853.3988626-1-keirf@google.com> <20250819090853.3988626-4-keirf@google.com>
Message-ID: <aL8yoZLK73svpYv7@google.com>
Subject: Re: [PATCH v3 3/4] KVM: Implement barriers before accessing
 kvm->buses[] on SRCU read paths
From: Sean Christopherson <seanjc@google.com>
To: Keir Fraser <keirf@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 19, 2025, Keir Fraser wrote:
> This ensures that, if a VCPU has "observed" that an IO registration has
> occurred, the instruction currently being trapped or emulated will also
> observe the IO registration.
> 
> At the same time, enforce that kvm_get_bus() is used only on the
> update side, ensuring that a long-term reference cannot be obtained by
> an SRCU reader.
> 
> Signed-off-by: Keir Fraser <keirf@google.com>
> ---
>  arch/x86/kvm/vmx/vmx.c   |  7 +++++++
>  include/linux/kvm_host.h | 10 +++++++---
>  virt/kvm/kvm_main.c      | 33 +++++++++++++++++++++++++++------
>  3 files changed, 41 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index aa157fe5b7b3..2d3c8cb4f860 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5785,6 +5785,13 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
>  		if (kvm_test_request(KVM_REQ_EVENT, vcpu))
>  			return 1;
>  
> +		/*
> +		 * Ensure that any updates to kvm->buses[] observed by the
> +		 * previous instruction (emulated or otherwise) are also
> +		 * visible to the instruction we are about to emulate.

Please avoid pronouns, e.g.

		 * visible to the instruction KVM is about to emulate.

> +		 */
> +		smp_rmb();

...

>  static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 6c07dd423458..4f35ae23ee5a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1103,6 +1103,15 @@ void __weak kvm_arch_create_vm_debugfs(struct kvm *kvm)
>  {
>  }
>  
> +/* Called only on cleanup and destruction paths when there are no users. */
> +static inline struct kvm_io_bus *kvm_get_bus_for_destruction(struct kvm *kvm,
> +							     enum kvm_bus idx)
> +{
> +	return rcu_dereference_protected(kvm->buses[idx],
> +					 !refcount_read(&kvm->users_count));
> +}
> +

Extra newline.

> +
>  static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
>  {
>  	struct kvm *kvm = kvm_arch_alloc_vm();
> @@ -1228,7 +1237,7 @@ static struct kvm *kvm_create_vm(unsigned long type, const char *fdname)
>  out_err_no_arch_destroy_vm:
>  	WARN_ON_ONCE(!refcount_dec_and_test(&kvm->users_count));
>  	for (i = 0; i < KVM_NR_BUSES; i++)
> -		kfree(kvm_get_bus(kvm, i));
> +		kfree(kvm_get_bus_for_destruction(kvm, i));
>  	kvm_free_irq_routing(kvm);
>  out_err_no_irq_routing:
>  	cleanup_srcu_struct(&kvm->irq_srcu);
> @@ -1276,7 +1285,7 @@ static void kvm_destroy_vm(struct kvm *kvm)
>  
>  	kvm_free_irq_routing(kvm);
>  	for (i = 0; i < KVM_NR_BUSES; i++) {
> -		struct kvm_io_bus *bus = kvm_get_bus(kvm, i);
> +		struct kvm_io_bus *bus = kvm_get_bus_for_destruction(kvm, i);
>  
>  		if (bus)
>  			kvm_io_bus_destroy(bus);
> @@ -5843,6 +5852,18 @@ static int __kvm_io_bus_write(struct kvm_vcpu *vcpu, struct kvm_io_bus *bus,
>  	return -EOPNOTSUPP;
>  }
>  
> +static struct kvm_io_bus *kvm_get_bus_srcu(struct kvm *kvm, enum kvm_bus idx)
> +{
> +	/*
> +	 * Ensure that any updates to kvm_buses[] observed by the previous VCPU

s/VCPU/vCPU to match KVM's preferred/typical style.

> +	 * machine instruction are also visible to the VCPU machine instruction
> +	 * that triggered this call.
> +	 */
> +	smp_mb__after_srcu_read_lock();
> +
> +	return srcu_dereference(kvm->buses[idx], &kvm->srcu);
> +}

