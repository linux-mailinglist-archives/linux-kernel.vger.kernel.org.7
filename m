Return-Path: <linux-kernel+bounces-855354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E728BE0FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0DE3BF3E9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDE73164C5;
	Wed, 15 Oct 2025 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2M6YgmS7"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BED311580
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 22:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760569116; cv=none; b=DyPofsJC9diVWORsakrFZ1W5u90XZdiWGiiIzn7H58k/SfMnF6XX6l2H8nOcNi10NGIdQuRAnRrTPMYYy1q4lYEcTM4IxKWTXK05GMzgV/qp/F0lRkQ3RHuOXsgjC9492cz4mCfD8cPw8fRNSE3vBZ3NEeFgIPzU49crel19rq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760569116; c=relaxed/simple;
	bh=w53eIA9Wi9z3EJ5WJbhZ4E8om71IBlEDzcrhk5NSHvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pee6aqWKKj/ZLWrH8g/2g1cMVaRO9TpLAURQj1ALPlmMXaRs2DsZto21IDUDsj5ax53yb5/ZHy/B+pg0TeRB5EyMlY0i1gejZwJUACXTl3GVuKaCjFlYHkPmyIW2K9U2R4LHfA04RVK3r6THr37yML6oxIOVJnlHeH9pyAOFAHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2M6YgmS7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-798920399a6so1532447b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760569114; x=1761173914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUr9B0K0pRIzbLYdBtnfMRJeB0sa/qrYh6jGMHJXJG8=;
        b=2M6YgmS7kkp238lKC2i/JhzRSsKHou/2AxQ9Tnw6rWIIabvxN9ZpG94JfML+UN0rpB
         uXbpqEQTuhMB3E2RgE0MGzAJeqD827MDpAuutitv3eoIBxBHNYMe7AvNalKFyZZW+/p5
         udumWnIDnIi59aXcsXJhlOQWc3wDIEdOHDlq1i0Mi01Vndub76HUvXfJKgIFsHKMFxRt
         zKZe6tW6FpDd+F7ZRFFsYkZ0RyU3J5JCeAn0nvO7amSdAefcZIHCG5MBYyI8S96J5cj0
         RJ/zM2hNoVDTF9i0L3hsSg9lnOVcB68RXBEXE0XwkUR0ZntgycyrTR8aKHvDYgGMdsku
         SKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760569114; x=1761173914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUr9B0K0pRIzbLYdBtnfMRJeB0sa/qrYh6jGMHJXJG8=;
        b=tjyirF9u5J8mPlVCiqYNiVnDcgd2POiCfbIpjnJZIdNGD7gZ5ysRVx8OhEvuwX1Pty
         lsuELchYm3JFNIvgw3W0N9HjO7eQZbJzelGGNG/lgjf8nFz0V4Avp+nc16HcgdKwsli7
         UZTm5JFDpKWtRkFhnGQfPF6KXW5UTuvuvNwK1yE2X+vdB6lLkSDk9eC3cviqJaLS6Xtd
         Kn+03OeLfsyx86TNLynFR8EELxxrZepLxsnqtzTLBZYyOhmqL27DDsgM8DrgxhXEPKAL
         1NU1uD68Dd45aBTZS7FrhBAuhchYhJHvoiF/RDZoRdImY21NcxZvYVglCIDqvlXc4y5X
         nnMw==
X-Forwarded-Encrypted: i=1; AJvYcCW+CrFeIiNTkdpH0RaqGYRsBwHzM8K5CGct2n0zrTztD8Utmw+YydmTT5M6MobS4ZmXQuEYxjEbNjbTAC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsDCp38nMUwf1WZtGe3yQMhZi1xiJ3kuldSOV7BpNtypZlYBhr
	iBqFvREydFKhkj0GWfp3rA/0Di7gffKbppwiHKmVH5/2Z9YB0VPv5u81KuCK2AlhBePBs27egPg
	lnRv76g==
X-Google-Smtp-Source: AGHT+IEshhj56Wp5ICbcYs7qMS7Yon0bowFGTsFr9tNdJTMEMitmBMKvXRrJL8Py1G1D3gIqV5mIQGcydI4=
X-Received: from pjre3.prod.google.com ([2002:a17:90a:b383:b0:33b:51fe:1a75])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3391:b0:263:4717:559
 with SMTP id adf61e73a8af0-33495db26b7mr1827259637.20.1760569113605; Wed, 15
 Oct 2025 15:58:33 -0700 (PDT)
Date: Wed, 15 Oct 2025 15:58:32 -0700
In-Reply-To: <2mtjboekfjxmuougyiypg4azeurhqxlk7fovzacv5c74hrmzrb@krfinussf2zd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917215031.2567566-1-jmattson@google.com> <20250917215031.2567566-4-jmattson@google.com>
 <2mtjboekfjxmuougyiypg4azeurhqxlk7fovzacv5c74hrmzrb@krfinussf2zd>
Message-ID: <aPAnGDh2u5-VK7gs@google.com>
Subject: Re: [PATCH 3/4] KVM: selftests: Add VM_MODE_PXXV57_4K VM mode
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Eric Auger <eric.auger@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 15, 2025, Yosry Ahmed wrote:
> On Wed, Sep 17, 2025 at 02:48:39PM -0700, Jim Mattson wrote:
> > Add a new VM mode, VM_MODE_PXXV57_4K, to support tests that require
> > 5-level paging on x86. This mode sets up a 57-bit virtual address
> > space and sets CR4.LA57 in the guest.
> > 
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  .../testing/selftests/kvm/include/kvm_util.h  |  1 +
> >  tools/testing/selftests/kvm/lib/kvm_util.c    | 21 +++++++++++++++++
> >  .../testing/selftests/kvm/lib/x86/processor.c | 23 ++++++++++++-------
> >  tools/testing/selftests/kvm/lib/x86/vmx.c     |  7 +++---
> >  4 files changed, 41 insertions(+), 11 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > index 23a506d7eca3..b6ea5d966715 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > @@ -175,6 +175,7 @@ enum vm_guest_mode {
> >  	VM_MODE_P40V48_16K,
> >  	VM_MODE_P40V48_64K,
> >  	VM_MODE_PXXV48_4K,	/* For 48bits VA but ANY bits PA */
> > +	VM_MODE_PXXV57_4K,	/* For 48bits VA but ANY bits PA */
> >  	VM_MODE_P47V64_4K,
> >  	VM_MODE_P44V64_4K,
> >  	VM_MODE_P36V48_4K,
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index c3f5142b0a54..6b0e499c6e91 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -232,6 +232,7 @@ const char *vm_guest_mode_string(uint32_t i)
> >  		[VM_MODE_P40V48_16K]	= "PA-bits:40,  VA-bits:48, 16K pages",
> >  		[VM_MODE_P40V48_64K]	= "PA-bits:40,  VA-bits:48, 64K pages",
> >  		[VM_MODE_PXXV48_4K]	= "PA-bits:ANY, VA-bits:48,  4K pages",
> > +		[VM_MODE_PXXV57_4K]	= "PA-bits:ANY, VA-bits:57,  4K pages",
> >  		[VM_MODE_P47V64_4K]	= "PA-bits:47,  VA-bits:64,  4K pages",
> >  		[VM_MODE_P44V64_4K]	= "PA-bits:44,  VA-bits:64,  4K pages",
> >  		[VM_MODE_P36V48_4K]	= "PA-bits:36,  VA-bits:48,  4K pages",
> > @@ -259,6 +260,7 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
> >  	[VM_MODE_P40V48_16K]	= { 40, 48,  0x4000, 14 },
> >  	[VM_MODE_P40V48_64K]	= { 40, 48, 0x10000, 16 },
> >  	[VM_MODE_PXXV48_4K]	= {  0,  0,  0x1000, 12 },
> > +	[VM_MODE_PXXV57_4K]	= {  0,  0,  0x1000, 12 },
> >  	[VM_MODE_P47V64_4K]	= { 47, 64,  0x1000, 12 },
> >  	[VM_MODE_P44V64_4K]	= { 44, 64,  0x1000, 12 },
> >  	[VM_MODE_P36V48_4K]	= { 36, 48,  0x1000, 12 },
> > @@ -358,6 +360,25 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
> >  		vm->va_bits = 48;
> >  #else
> >  		TEST_FAIL("VM_MODE_PXXV48_4K not supported on non-x86 platforms");
> 
> We should probably update TEST_ASSERT(vm->va_bits == 48 || vm->va_bits == 57)
> above to only assert 48 bits now, right?

No, because CPUID reports the _max_ virtual address width.  In theory, the assert
could be ">= 48", but in practice x86-64 only supports 48-bit and 57-bit VAs, so
selftests are paranoid and are sanity checking KVM at the same time.

