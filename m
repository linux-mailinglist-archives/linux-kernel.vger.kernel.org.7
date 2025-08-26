Return-Path: <linux-kernel+bounces-787148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F18B371F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9123F1B27D14
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43E534F464;
	Tue, 26 Aug 2025 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mm3j8dm2"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5D719DF66
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231896; cv=none; b=DI45+HQrzXxd9GboQirWfXUsMdhVfLxTMKQyqkeNVwk3cW89+OW9bl6Kb3XnTIs8c/Ek2lfiUhzXrLsLNYxcU3LhmdozKwA7xySikTr1iACyFQtLpRCuf+NXUbDRlDOKNO5JKRbR9oZjn82JGamaVkebd0fL0VK4wgHsX+rg6N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231896; c=relaxed/simple;
	bh=Wfg6FJwlor8gqsUlKQ4xZ/KQv3CU7fygk/qgzHl1Ogs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HMP8rROVl4RfHpBACdnEJ1RvjGoOmbtTShFuWhsaSJkHa66ja6K5FeOdpVbji6GASEk+h6N5k7v5G+H4JTJxINwJBjYCIv+D1Euicreswi6pXfQ7TM8T6qunNxMchJt0jeAzR4EPmBrcBv7MSG5ZdcY63xzUQVEyRnnFNe+RxCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mm3j8dm2; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7705115a2a5so2390203b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756231894; x=1756836694; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZSj/n10BJ4OeUS/QJ+jQC8hloyvH7XyUvVbBr+E+h4=;
        b=Mm3j8dm2nDxXU06FRZvuKvI0bB9KkQ8FSPyZkLGJ7lcj7cMnVALp+P2BTkyum/Jx1X
         TfnZrPxaEFZKi9A2M4sjk91KAicxAKHKrnQIfGnRZ4h/SgOPjwavYg0034yxuDOjtUSM
         jccH4opTE5krKRMagtrEHW7XSCflxPYrFyv1lSUFXWCoDkJEI60sv0lU1FL5DV0hv9E/
         NQVoiXTf00aMz8UevUoF/YJ4o2/eHjpXJBm2bGj2Fkw1QrWMSXLy4+TS9hK656BWkoEj
         onpsu6esOqJeqXryAhXmjMOAhj6l81bcC9lp8uZoU7K3YFNuTsSr/zwOLGngxSF7I9ED
         BGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756231894; x=1756836694;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZSj/n10BJ4OeUS/QJ+jQC8hloyvH7XyUvVbBr+E+h4=;
        b=VklcLvzytskY7n2Xg8g36Coq8ZNvy7AuAm3c0r2c4GRRToPJ5erG3FkGuqQaOAbwF2
         ZyBkGPFjt5r7ZURq0IbFvD/q0z8ZxGXWyeQdiXajGFOv9TykHv04wmYR14zil6N9xdUg
         m7D8h/DgABF0oDnW5we9cVduyogxhW0PK+dpaxVnjEMJOiZrSr0swJy0ly6bIXaM4ovj
         1WkpkfTT6sNBzuyksi98hstg7hVCOImTKJ1AwRdIu4SpDBMJWww/faCusvcDytjLZyjb
         f+YLx6Y3KDbBANvuzCp6Z8iOjWF5EoYQ7pb1zW3L+NHNAqP5ZJFrx0GzHZFfb2s+SIUQ
         PhhQ==
X-Gm-Message-State: AOJu0YzPHE4IkFQrWZIckgkTztTBkXxP0P6aqhKeMih5wdkX/Zr/dD89
	fQvrMuvIl4+Y9J1y4J1joyaMbAoUVXWVWmHoeAmwmyF9M/+bX3NNSWb2IemL3mtI7aXIB5clXwR
	UzvBP4w==
X-Google-Smtp-Source: AGHT+IHCa7ZYOLeXLjKB/7vjVkBxomlghGlzcqR93DVBG6dNOIVpZmLqMUZL5y20T2paLxLkRXE13Cqmu9Y=
X-Received: from pjbpq16.prod.google.com ([2002:a17:90b:3d90:b0:325:7fbe:1c64])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d83:b0:215:efed:acfc
 with SMTP id adf61e73a8af0-24340b80d09mr23159644637.7.1756231893619; Tue, 26
 Aug 2025 11:11:33 -0700 (PDT)
Date: Tue, 26 Aug 2025 11:11:31 -0700
In-Reply-To: <2dd8c323-7654-4a28-86f1-d743b70d10b1@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821223630.984383-1-xin@zytor.com> <20250821223630.984383-7-xin@zytor.com>
 <2dd8c323-7654-4a28-86f1-d743b70d10b1@zytor.com>
Message-ID: <aK340-6yIE_qujUm@google.com>
Subject: Re: [PATCH v6 06/20] KVM: VMX: Set FRED MSR intercepts
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org, 
	peterz@infradead.org, andrew.cooper3@citrix.com, chao.gao@intel.com, 
	hch@infradead.org
Content-Type: text/plain; charset="us-ascii"

On Sun, Aug 24, 2025, Xin Li wrote:
> On 8/21/2025 3:36 PM, Xin Li (Intel) wrote:
> > +	/*
> > +	 * MSR_IA32_FRED_RSP0 and MSR_IA32_PL0_SSP (aka MSR_IA32_FRED_SSP0) are
> > +	 * designated for event delivery while executing in userspace.  Since
> > +	 * KVM operates exclusively in kernel mode (the CPL is always 0 after
> > +	 * any VM exit), KVM can safely retain and operate with the guest-defined
> > +	 * values for MSR_IA32_FRED_RSP0 and MSR_IA32_PL0_SSP.
> > +	 *
> > +	 * Therefore, interception of MSR_IA32_FRED_RSP0 and MSR_IA32_PL0_SSP
> > +	 * is not required.
> > +	 *
> > +	 * Note, save and restore of MSR_IA32_PL0_SSP belong to CET supervisor
> > +	 * context management.  However the FRED SSP MSRs, including
> > +	 * MSR_IA32_PL0_SSP, are supported by any processor that enumerates FRED.
> > +	 * If such a processor does not support CET, FRED transitions will not
> > +	 * use the MSRs, but the MSRs would still be accessible using MSR-access
> > +	 * instructions (e.g., RDMSR, WRMSR).
> > +	 */
> > +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_FRED_RSP0, MSR_TYPE_RW, intercept);
> > +	vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL0_SSP, MSR_TYPE_RW, intercept);
> 
> Hi Sean,
> 
> I'd like to bring up an issue concerning MSR_IA32_PL0_SSP.
> 
> The FRED spec claims:
> 
> The FRED SSP MSRs are supported by any processor that enumerates
> CPUID.(EAX=7,ECX=1):EAX.FRED[bit 17] as 1. If such a processor does not
> support CET, FRED transitions will not use the MSRs (because shadow stacks
> are not enabled), but the MSRs would still be accessible using MSR-access
> instructions (e.g., RDMSR, WRMSR).
> 
> It means KVM needs to handle MSR_IA32_PL0_SSP even when FRED is supported
> but CET is not.  And this can be broken down into two subtasks:
> 
> 1) Allow such a guest to access MSR_IA32_PL0_SSP w/o triggering #GP.  And
> this behavior is already implemented in patch 8 of this series.
> 
> 2) Save and restore MSR_IA32_PL0_SSP in both KVM and Qemu for such a guest.

What novel work needs to be done in KVM?  For QEMU, I assume it's just adding an
"or FRED" somewhere.  For KVM, I'm missing what additional work would be required
that wouldn't be naturally covered by patch 8 (assuming patch 8 is bug-free).

> I have the patches for 2) but they are not included in this series, because
> 
> 1) how much do we care the value in MSR_IA32_PL0_SSP in such a guest?
> 
> Yes, Chao told me that you are the one saying that MSRs can be used as
> clobber registers and KVM should preserve the value.  Does MSR_IA32_PL0_SSP
> in such a guest count?

If the architecture says that MSR_IA32_PL0_SSP exists and is accessible, then
KVM needs to honor that.

> 2) Saving/restoring MSR_IA32_PL0_SSP adds complexity, though it's seldom
> used.  Is it worth it?

Honoring the architecture is generally not optional.  There are extreme cases
where KVM violates that rule and takes (often undocumented) erratum, e.g. APIC
base relocation would require an absurd amount of complexity for no real world
benefit.  But I would be very surprised if the complexity in KVM or QEMU to support
this scenario is at all meaningful, let alone enough to justify diverging from
the architectural spec.

> BTW I'm still working on a KVM unit test for it, using a L1 VMM that
> enumerates FRED but not CET.
> 
> Thanks!
>     Xin

