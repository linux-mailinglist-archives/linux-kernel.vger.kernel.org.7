Return-Path: <linux-kernel+bounces-855406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C43BE1200
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 02:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3ABB1A2047E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A49192B7D;
	Thu, 16 Oct 2025 00:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CgOUAEuQ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A9415B54A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760575217; cv=none; b=DRJPqwcVVyaqyPANS2PJ53hge0L8ktJdYhW6MkTB0Cp9pePTAS6eI2EJ/xdRPsDe5QjnHW4PnuBgR3KTP+Ge8D+4moxP/urMOGQom4gNgI+Mlw5L86i2D/eTsCUUM4UGJuJlJKUxyQ6iY1nnMrRJvVyX1ivbDXx9XY0hCi4VzUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760575217; c=relaxed/simple;
	bh=7vY9PzWr/yiLC8CW0M2fmrsK2IW0Vzer5uITSO+BXpo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MaSwF7JS8mkZe892UwL0GNRdDUmHHo2yMuT6qemmKzOYtdpLDo5luhJFgOy1WtTpibKgUrnWaYhlSuPtT/T4Z92tCRPKa+TOmsZvIpbnQbrg/uE5FQ8nywWHkKXt+2uSnMUvBmKiRN43Zc91r8ljlkgNbU0Kk9ztnmotzp4CRKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CgOUAEuQ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-334b0876195so217126a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760575213; x=1761180013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3dNlCURooSIJX80Bj3EYkA9QRwRQzSg6kTNlO7f/Gn4=;
        b=CgOUAEuQazcDZPeyqs2s5ACE9C6Y0AJJPmwpGYGC/76AgNkRfLmc9ar7aHVrfFHQ5l
         BbNimUVOtLVJ5uhKaIiJ4j4nqJsCLBubYpnvqli/eQ+HV9NMQ/MOCAPZellBnP3mYVrx
         X/sHoKHWdZ0jrmZ+fDH0RKaDdA0c576nUzSVsGySo2r4+dXYGCSQqGNp+hiZM4iB986+
         1JUTivF7jKYLig8KuQfrENpabOaJTfjAQOWAIJArPii3F7ZFtKrsDtnpLHtoNdHakwIp
         AYzAFMkXD3cnOWm6vFvdxG1AztNU4PnezoSEM2Q0MLZJ6SYDW2IQzT9gVwCrn8Mecy66
         Op4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760575213; x=1761180013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dNlCURooSIJX80Bj3EYkA9QRwRQzSg6kTNlO7f/Gn4=;
        b=hqfxbo2GIlvaJ0XKZKl3cYfHHjd/H92EXBiuzDJo4BludvP00OhQo+M1Usn4wBdol7
         voeQ2K2poGLwj+GhDwH6S3IuBToSczHDI7U0Yq696MC7YwW8/yYgRtYjLXtH/g0pGJ3J
         vj8CRnw1gPMzPiYnkWDE/vnsncBjx7K4x6dtpSfKKIImnolRp+KDNAfd0kNhYQeB5BTE
         qI+YDFTK9y4sUz0/oFrnVH/fw9l11atrAdpRYlZgQubFa74RLSAoxUDSv1tN9jpEij1L
         uMkAPt6vYaOVNLmP+4mbuQwC2BLLgzEkjXU5XKT+SZJb46MjM6WK7RYKpydm+t0ReGEw
         n5AA==
X-Forwarded-Encrypted: i=1; AJvYcCUvm1HMvVfgaNcwhPH4UUrnWWTYRoE+FrqtKLq2Dh2oCwel4PY6ioHhgUElV4gOAwqvec3Sw7wcRgDTl54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8G3VpkM5gsnOI33Hh3E+PX/5xKQqSLyqaTFsiGxdtArAJZ2wE
	z2r81ptQFtPlmHj7nGzPbPJqsnYfcBI9QeUWWz1T65Qro6ptDpGhn/adh4wTLZyJauRzVvWxyPQ
	FDzePNg==
X-Google-Smtp-Source: AGHT+IHfPvjhnedJTgg6CAxnlq4B1q8xkwPd3n+ogO/h0bax4t2Y4qg32T1rBL73rr/Fp9d7GqAYfHy1jZw=
X-Received: from pjbrv22.prod.google.com ([2002:a17:90b:2c16:b0:329:6ac4:ea2e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2412:b0:33b:ade7:51d3
 with SMTP id 98e67ed59e1d1-33bade7553bmr476752a91.20.1760575213249; Wed, 15
 Oct 2025 17:40:13 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:40:11 -0700
In-Reply-To: <aPAnWWmo555uB0-H@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917215031.2567566-1-jmattson@google.com> <20250917215031.2567566-4-jmattson@google.com>
 <aPAnWWmo555uB0-H@google.com>
Message-ID: <aPA-60vV0WQUCmc2@google.com>
Subject: Re: [PATCH 3/4] KVM: selftests: Add VM_MODE_PXXV57_4K VM mode
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	"Pratik R. Sampat" <prsampat@amd.com>, Kai Huang <kai.huang@intel.com>, 
	Eric Auger <eric.auger@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 15, 2025, Sean Christopherson wrote:
> On Wed, Sep 17, 2025, Jim Mattson wrote:
> > Add a new VM mode, VM_MODE_PXXV57_4K, to support tests that require
> > 5-level paging on x86. This mode sets up a 57-bit virtual address
> > space and sets CR4.LA57 in the guest.

Thinking about this more, unless it's _really_ painful, e.g. because tests assume
4-level paging or 48-bit non-canonical address, I would rather turn VM_MODE_PXXV48_4K
into VM_MODE_PXXVXX_4K and have ____vm_create() create the "maximal" VM.  That
way tests don't need to go out of their way just to use 5-level paging, e.g. a
"TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_LA57))" is all that is needed.  It will also
gives quite a bit of coverage for free, e.g. that save/restore works with and
without 5-level paging (contrived example, but you get the point).

The NONCANONICAL #define works for LA57, so hopefully making tests play nice with
LA57 is straightforward?

> > @@ -358,6 +360,25 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
> >  		vm->va_bits = 48;
> >  #else
> >  		TEST_FAIL("VM_MODE_PXXV48_4K not supported on non-x86 platforms");
> > +#endif
> > +		break;
> > +	case VM_MODE_PXXV57_4K:
> > +#ifdef __x86_64__
> > +		kvm_get_cpu_address_width(&vm->pa_bits, &vm->va_bits);
> > +		kvm_init_vm_address_properties(vm);
> > +		/*
> > +		 * For 5-level paging, KVM requires LA57 to be enabled, which
> > +		 * requires a 57-bit virtual address space.
> > +		 */
> > +		TEST_ASSERT(vm->va_bits == 57,
> > +			    "Linear address width (%d bits) not supported for VM_MODE_PXXV57_4K",
> > +			    vm->va_bits);
> > +		pr_debug("Guest physical address width detected: %d\n",
> > +			 vm->pa_bits);
> > +		vm->pgtable_levels = 5;
> > +		vm->va_bits = 57;
> > +#else
> > +		TEST_FAIL("VM_MODE_PXXV57_4K not supported on non-x86 platforms");
> >  #endif
> 
> That's a lot of copy+paste, especially given the #ifdefs.  How about this (untested)?
> 
> 	case VM_MODE_PXXV48_4K:
> 	case VM_MODE_PXXV57_4K:
> #ifdef __x86_64__
> 		kvm_get_cpu_address_width(&vm->pa_bits, &vm->va_bits);
> 		kvm_init_vm_address_properties(vm);
> 
> 		/*
> 		 * Ignore KVM support for 5-level paging (vm->va_bits == 57) if
> 		 * the target mode is 4-level paging (48-bit virtual address
> 		 * space), as 5-level paging only takes effect if CR4.LA57=1.
> 		 */
> 		TEST_ASSERT(vm->va_bits == 57 ||
> 			    (vm->va_bits == 48 && vm->mode == VM_MODE_PXXV48_4K),
> 			    "Linear address width (%d bits) not supported",
> 			    vm->va_bits);
> 		pr_debug("Guest physical address width detected: %d\n",
> 			 vm->pa_bits);
> 		if (vm->mode == VM_MODE_PXXV48_4K) {
> 			vm->pgtable_levels = 4;
> 			vm->va_bits = 48;
> 		} else {
> 			vm->pgtable_levels = 5;
> 			vm->va_bits = 57;
> 		}
> #else
> 		TEST_FAIL("VM_MODE_PXXV{48,57}_4K not supported on non-x86 platforms");
> #endif
> 		break;

