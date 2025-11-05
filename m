Return-Path: <linux-kernel+bounces-886639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 264FDC36244
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89E9D4FA435
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2D3330B0F;
	Wed,  5 Nov 2025 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oMqXh4Xa"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B432E752
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353788; cv=none; b=ZBIjtShA5EFz6cHMLJmWYHZrjzKiPA+/NKTBRDC8rZ3s1dmWri/25lGOus+Br63YOzdghRwpzqX4NUCrmXtieZl4nSUWpDCagoyBlNk/6SRQl/rcSMcAYdgu+jXSD/cx1xEjXMeuaMyxZQ/Y68E3GAOc1evO/l6usfDFIzz7dm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353788; c=relaxed/simple;
	bh=ocmsfTgEBkK48bgX+3vAd5XPh3dUHXjBPXNI34/E2AA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oPxp/c9Tj+7CyIspjbuLB+chYRg5FqRmjgjZynQbQKM34z+Ul8wsG3Q5SaC3P6i+0dyXRL3nl2OF00ZeKijP9jC//AbCXU9NekIjlyemLLRatZq7dMSrGhh5pXLbsAzX4A2V1If15iv+0OexnkrlkCytYCs/Pfq131L3FrPm0mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oMqXh4Xa; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b55283ff3fcso4808775a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762353786; x=1762958586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqjhwJRB6rtUcj/K+Rlq8ccrX0xIvtB3rWcEbMdz6dU=;
        b=oMqXh4XaH3WSKN10+QbbkFhESstBf6A1+4NF6TuLDzlerG2BIm3nCm0jluAVm3nuzn
         Cs/fJ+ShhEHOo7r9AYO/ZNW1rFmuPq4Py4FkwbpqvnbtXB9mU1rrgHBJbr/21Ow/9o89
         XKBd7G/82cRMwBtdRsX3xhz15tr6zKfPNAeBItM3Naw1oIohnqG1e1FlcFbp6IlwIhXa
         ZvCobQBnCU3bhQosWCXYUUFUB2JT2sBTU63PtJoCpNXm0bvpVuob9/pkDP85ZNHfHv3t
         k325AcPcAJ7EftaVIvisA0wzR6xNUv655GgZRUPvf43stawCLvkF/qp7SglAgbg5TClV
         VOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762353786; x=1762958586;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dqjhwJRB6rtUcj/K+Rlq8ccrX0xIvtB3rWcEbMdz6dU=;
        b=VQlxVOkbM1gFYPH7HBmE77Bd6RDbDV+Ul9of4/ArZLXh/CkIeN7tDx7zil6m/ghLHE
         4vXfh8inlssLNUNa7mTLN0rkZIf7udxyAdfhnz/koLgm/z+4DpEhUDMQJ+OP4xPl1YAC
         XsdppkmWdUd99Vy4NJjURd3POtjAGkns/s1DTCfkq2h2tnPgsNJJk1YsVzaGF1JUo2RD
         HUUSYB2WE3dGl/l6pLrNLh4VuIoq3MPACbkazKIdwvN49UdMQbJxZAeMDIZFgh5gKgaL
         vU8M7gJPoVet4mVg4WH/zG5IpZHnQvDUpMMfBgW0Ae1m2fzc/Xy6Pl7tiMWjC/GTzC+e
         Hgiw==
X-Forwarded-Encrypted: i=1; AJvYcCWVaT2U40ZAPcOX+v1+wqyG/YGWUGYysHZi2V5oMbj9fsbJ2rLAd+Ub9FQ+nr43GRzSi/Iz7fCUpCkUuwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmkNX8PF2ihkHWY+Lz06eNZ5uDHJB5AZSvdnxFpbsmS3y3g6hC
	ICfEgCjNpfDV8wTLPKn8fBd+CAfF4fszn1HQG8Fud8GSNT2ggONeaFZOGYSD5EP2nk2wzLWjhvx
	bhy9Drw==
X-Google-Smtp-Source: AGHT+IFp1nnaOUYZBc6y5TXYgXVW8sgHam1Bt50RSGnZmk2JbH5zrhYV8aE4Qf36WHUTFDi0YtfuMteSrV4=
X-Received: from plw16.prod.google.com ([2002:a17:903:45d0:b0:273:8fca:6e12])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e784:b0:295:a1a5:baee
 with SMTP id d9443c01a7336-2962adb34f8mr40614545ad.4.1762353786088; Wed, 05
 Nov 2025 06:43:06 -0800 (PST)
Date: Wed, 5 Nov 2025 06:43:01 -0800
In-Reply-To: <88404ae2-fa4b-4357-918b-fd949dd2521a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030224246.3456492-1-seanjc@google.com> <20251030224246.3456492-4-seanjc@google.com>
 <88404ae2-fa4b-4357-918b-fd949dd2521a@linux.intel.com>
Message-ID: <aQtiYwBYtsz6Whwz@google.com>
Subject: Re: [PATCH 3/4] KVM: x86: Load guest/host XCR0 and XSS outside of the
 fastpath run loop
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jon Kohler <jon@nutanix.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025, Binbin Wu wrote:
>=20
>=20
> On 10/31/2025 6:42 AM, Sean Christopherson wrote:
> [...]
> > -void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu)
> > +static void kvm_load_guest_xfeatures(struct kvm_vcpu *vcpu)
> >   {
> >   	if (vcpu->arch.guest_state_protected)
> >   		return;
> >   	if (kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE)) {
> > -
> >   		if (vcpu->arch.xcr0 !=3D kvm_host.xcr0)
> >   			xsetbv(XCR_XFEATURE_ENABLED_MASK, vcpu->arch.xcr0);
> > @@ -1217,6 +1216,27 @@ void kvm_load_guest_xsave_state(struct kvm_vcpu =
*vcpu)
> >   		    vcpu->arch.ia32_xss !=3D kvm_host.xss)
> >   			wrmsrq(MSR_IA32_XSS, vcpu->arch.ia32_xss);
> >   	}
> > +}
> > +
> > +static void kvm_load_host_xfeatures(struct kvm_vcpu *vcpu)
> > +{
> > +	if (vcpu->arch.guest_state_protected)
> > +		return;
> > +
> > +	if (kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE)) {
> > +		if (vcpu->arch.xcr0 !=3D kvm_host.xcr0)
> > +			xsetbv(XCR_XFEATURE_ENABLED_MASK, kvm_host.xcr0);
> > +
> > +		if (guest_cpu_cap_has(vcpu, X86_FEATURE_XSAVES) &&
> > +		    vcpu->arch.ia32_xss !=3D kvm_host.xss)
> > +			wrmsrq(MSR_IA32_XSS, kvm_host.xss);
> > +	}
> > +}
>=20
> kvm_load_guest_xfeatures() and kvm_load_host_xfeatures() are almost the s=
ame
> except for the guest values VS. host values to set.
> I am wondering if it is worth adding a helper to dedup the code, like:
>=20
> static void kvm_load_xfeatures(struct kvm_vcpu *vcpu, u64 xcr0, u64 xss)
> {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vcpu->arch.guest_state_protected)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE)=
) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vcpu->arch.xc=
r0 !=3D kvm_host.xcr0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 xsetbv(XCR_XFEATURE_ENABLED_MASK, xcr0);
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (guest_cpu_cap=
_has(vcpu, X86_FEATURE_XSAVES) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcp=
u->arch.ia32_xss !=3D kvm_host.xss)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 wrmsrq(MSR_IA32_XSS, xss);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> }

Nice!  I like it.  Want to send a proper patch (relative to this series)?  =
Or
I can turn the above into a patch with a Suggested-by.  Either way works fo=
r me.

