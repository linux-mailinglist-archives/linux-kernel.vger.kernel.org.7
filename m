Return-Path: <linux-kernel+bounces-616340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE91EA98B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 15:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C29A445CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 13:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241E117A303;
	Wed, 23 Apr 2025 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fxh3WNnX"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6193596A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745415114; cv=none; b=MRXGIF/R0BJxKW4PuTawTDV+OLYn7XXF0llfL3bYvaFVn4w2S0PArcLLhMlbGUF2axksHlKNwvDlwilJYDawlVDNsq5oSo4w9j/X2pLM88sJHpre9Fx/hVLQ3VWofuv4pMeMcr5G0v99YwRdm2YdpIj3NUeQOhMVmvPutBWbglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745415114; c=relaxed/simple;
	bh=ZupkzBPR8cmfKoFIy/Bz3l8bmdRRaSXKHRNT/09jiaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M4QdhZGOrXi5JKrG+3v8k6PnKYZZGKiSoz+99bjneuwwznlVBnza0IRgQEeF8TIn73i2/uXq1t7EeO9r8r1wj1ClWaHdeLxS1JlxR2aWYpDqeZ+lMAIgqghvLwu0S2O0yjIiJquVPWxEhMJOHij0QAnnMfji9vTQypUjwTgKlUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fxh3WNnX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2264e5b2b7cso56264765ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745415111; x=1746019911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dh8ZI/jK90MDphrRP37d7PJMUfdcgQ0Lww2MM1+53M0=;
        b=Fxh3WNnXPqarVhyToqq2/cNU1/cg2xw5HXnl/NZ93K3NB5KE4Btqpx7tM7B+yXCVGV
         Wo61PRxF/JzS2W48xwzNm7p+c+Hz8jch0HKBBcolCbAQENh33pqBiYm/fFRctjbgm2kl
         POAiHgoDJeoJZ1SCTtH+9DGbyblxMXeR2E+EECaIwFGFXc5EX64DPapy6f8NmOTyOV19
         pgUyCICLw5bfg/6Dy3n7X+m+pXvN3VGQsnEQXNtYiSo34G+wHpu4+uktn2VmzWFnh6Oz
         BK2wEBNMk1jQf2/n7HpW2Tu/PIcgwqKQ6mnj+zjGb+6crGnZoQxlshF0gP3LbfGXXNHz
         YUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745415111; x=1746019911;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dh8ZI/jK90MDphrRP37d7PJMUfdcgQ0Lww2MM1+53M0=;
        b=aKsoULpnWk88vqH6Usj3JYgKcHFgvn6WvpvyGRcAlMeKOVJ/ZlBb8/Ro3ZgtzCgRo5
         RrsCZAsgyZkWrYtXB4xJ+Nkjof/VXwp1u/5CvR9UQWy8QLFa5dAfJEk5K8by0YS2WYVG
         8ttGZU6bf51okD32Rl0pMbgX/GGbq9xIlntrpZ6aNxF8k75CCf06Ek7v4C3Y8d8r3dJW
         LZR75xNkkcy9TAJx+vJ5ibEtxPSutHVufEQP9gOsKlS2VoBGTnfwksUDhOixIIv7YCJT
         EHLGRhuqbIrgMDczNDE00urWDBvldMkScGnfuTfnZlg2vtmSuRPU80viI+ZKYlinc6tt
         BSVA==
X-Forwarded-Encrypted: i=1; AJvYcCWVhwykCh9P4J8fX8KHJXUT8XEq/OCjkGPBBYAzEOXhcWOpXIxRleAG0yrIjqNn8CH56x/seo16Dpzy124=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3WLNLK2OoieO15xO6uvkBRlIu+k92/uMJ2wiRH3oFqcYGFv1k
	7Y7cIXUysDA1ICcrUeamYVUrFa4nfK5lE5pIjziFof7nf7ORhNNnzirPhdvhUbQYiEzxm+GPpDq
	TbQ==
X-Google-Smtp-Source: AGHT+IGv+vxgd+76joaYvgrFepSB3A2pNuWp+RXvZableO5Alrip9cwuMbT40VIQBgiKgvaBAP7dq9sMMog=
X-Received: from plsp11.prod.google.com ([2002:a17:902:bd0b:b0:220:c562:ede1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce8c:b0:224:160d:3f54
 with SMTP id d9443c01a7336-22c535ad0f8mr290475345ad.31.1745415110755; Wed, 23
 Apr 2025 06:31:50 -0700 (PDT)
Date: Wed, 23 Apr 2025 06:31:49 -0700
In-Reply-To: <CABQX2QMznYZiVm40Ligq+pFKmEkVpScW+zcKYbPpGgm0=S2Xkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250422161304.579394-1-zack.rusin@broadcom.com>
 <20250422161304.579394-5-zack.rusin@broadcom.com> <a803c925-b682-490f-8cd9-ca8d4cc599aa@zytor.com>
 <CABQX2QMznYZiVm40Ligq+pFKmEkVpScW+zcKYbPpGgm0=S2Xkg@mail.gmail.com>
Message-ID: <aAjrOgsooR4RYIJr@google.com>
Subject: Re: [PATCH v2 4/5] KVM: x86: Add support for legacy VMware backdoors
 in nested setups
From: Sean Christopherson <seanjc@google.com>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org, 
	Doug Covelli <doug.covelli@broadcom.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025, Zack Rusin wrote:
> On Wed, Apr 23, 2025 at 3:56=E2=80=AFAM Xin Li <xin@zytor.com> wrote:
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index 300cef9a37e2..5dc57bc57851 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -4653,6 +4653,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kv=
m, long ext)
> > >   #ifdef CONFIG_KVM_VMWARE
> > >       case KVM_CAP_X86_VMWARE_BACKDOOR:
> > >       case KVM_CAP_X86_VMWARE_HYPERCALL:
> > > +     case KVM_CAP_X86_VMWARE_NESTED_BACKDOOR_L0:

I would probably omit the L0, because KVM could be running as L1.

> > >   #endif
> > >               r =3D 1;
> > >               break;
> > > @@ -6754,6 +6755,13 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
> > >               kvm->arch.vmware.hypercall_enabled =3D cap->args[0];
> > >               r =3D 0;
> > >               break;
> > > +     case KVM_CAP_X86_VMWARE_NESTED_BACKDOOR_L0:
> > > +             r =3D -EINVAL;
> > > +             if (cap->args[0] & ~1)
> >
> > Replace ~1 with a macro for better readability please.
>=20
> Are you sure about that? This code is already used elsewhere in the
> file  (for KVM_CAP_EXIT_ON_EMULATION_FAILURE) so, ignoring the fact
> that it's arguable whether IS_ZERO_OR_ONE is more readable than & ~1,
> if we use a macro for the vmware caps and not for
> KVM_CAP_EXIT_ON_EMULATION_FAILURE then the code would be inconsistent
> and that decreases the readability.

Heh, KVM_CAP_EXIT_ON_EMULATION_FAILURE is the odd one out.  Even if that we=
ren't
the case, this is one of the situations where diverging from the existing c=
ode is
desirable, because the existing code is garbage.

arch/x86/kvm/x86.c:             if (cap->args[0] & ~kvm_caps.supported_quir=
ks)
arch/x86/kvm/x86.c:             if (cap->args[0] & ~KVM_X2APIC_API_VALID_FL=
AGS)
arch/x86/kvm/x86.c:             if (cap->args[0] & ~kvm_get_allowed_disable=
_exits())
arch/x86/kvm/x86.c:                 (cap->args[0] & ~KVM_X86_DISABLE_EXITS_=
PAUSE))
arch/x86/kvm/x86.c:             if (cap->args[0] & ~KVM_MSR_EXIT_REASON_VAL=
ID_MASK)
arch/x86/kvm/x86.c:             if (cap->args[0] & ~KVM_BUS_LOCK_DETECTION_=
VALID_MODE)
arch/x86/kvm/x86.c:             if (cap->args[0] & ~KVM_EXIT_HYPERCALL_VALI=
D_MASK) {
arch/x86/kvm/x86.c:             if (cap->args[0] & ~1)
arch/x86/kvm/x86.c:             if (!enable_pmu || (cap->args[0] & ~KVM_CAP=
_PMU_VALID_MASK))
arch/x86/kvm/x86.c:             if ((u32)cap->args[0] & ~KVM_X86_NOTIFY_VME=
XIT_VALID_BITS)
virt/kvm/kvm_main.c:            if (cap->flags || (cap->args[0] & ~allowed_=
options))


> Or are you saying that since I'm already there you'd like to see a
> completely separate patch that defines some kind of IS_ZERO_OR_ONE
> macro for KVM, use it for KVM_CAP_EXIT_ON_EMULATION_FAILURE and, once
> that lands then I can make use of it in this series?

Xin is suggesting that you add a macro in arch/x86/include/uapi/asm/kvm.h t=
o
#define which bits are valid and which bits are reserved.

At a glance, you can kill multiple birds with one stone.  Rather than add t=
hree
separate capabilities, add one capability and then a variety of flags.  E.g=
.

#define KVM_X86_VMWARE_HYPERCALL	_BITUL(0)
#define KVM_X86_VMWARE_BACKDOOR		_BITUL(1)
#define KVM_X86_VMWARE_NESTED_BACKDOOR	_BITUL(2)
#define KVM_X86_VMWARE_VALID_FLAGS	(KVM_X86_VMWARE_HYPERCALL |
					 KVM_X86_VMWARE_BACKDOOR |
					 KVM_X86_VMWARE_NESTED_BACKDOOR)

	case KVM_CAP_X86_VMWARE_EMULATION:
		r =3D -EINVAL;
		if (cap->args[0] & ~KVM_X86_VMWARE_VALID_FLAGS)
			break;

		mutex_lock(&kvm->lock);
		if (!kvm->created_vcpus) {
			if (cap->args[0] & KVM_X86_VMWARE_HYPERCALL)
				kvm->arch.vmware.hypercall_enabled =3D true;
			if (cap->args[0] & KVM_X86_VMWARE_BACKDOOR)
				kvm->arch.vmware.backdoor_enabled;
			if (cap->args[0] & KVM_X86_VMWARE_NESTED_BACKDOOR)
				kvm->arch.vmware.nested_backdoor_enabled =3D true;
			r =3D 0;
		}
		mutex_unlock(&kvm->lock);
		break;

That approach wouldn't let userspace disable previously enabled VMware capa=
bilities,
but unless there's a use case for doing so, that should be a non-issue.

