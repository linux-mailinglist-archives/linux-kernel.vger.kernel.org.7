Return-Path: <linux-kernel+bounces-858811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6479BEBE7B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAF3400306
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50442D77F5;
	Fri, 17 Oct 2025 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pcVCMmmT"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51A2D4B5A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 22:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739446; cv=none; b=F5U2QRRQNACEJ8OGiSSi8EP50yXrf9TiXjX6tWDQT5s7t1GydLmZoPKDSGoYJwoXm2ImmwpDPdborwmYHQ4Nny1hEbwiQ9OMaCWqAQDzm36fLk9jXepBlG5AT2//NGEBdj5ZIB6xPJCJqgI5U4ZVih0SW+DvJXIu7WHk7LSNZwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739446; c=relaxed/simple;
	bh=CIzxIN2I2K9yucRq6MizmW6QG3zXD+tMMvjx7wAP1N4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M/0/mMICwasROXVIh27i3QC20fI584zeCciEv7hLFxZY7v8gPYhQdVi4O9QfU1JmPsajcix7DVyzg/TSqNqJKWI14wfW6iRWe0U/7+BJiODltimQBJWtuEz8l6SSNFramXB03UIURHsK8+V3X2PHvLPt1bxAQ8BLBcyRaPwJ06s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pcVCMmmT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bcb7796d4so1810751a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760739444; x=1761344244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jBW9JeEw0rbC3waNIsvF3E2h5Mpei0jyfelXeZ/F0jE=;
        b=pcVCMmmTDH1/TJlIGoIg5GptiRRz4f7/eFP3eHKOMAtfHVnwe4wAw6Sv2s56l1zBmn
         gKJ8t2abAqHe0EVExvEgKdbkC5fOIKxXZcCYTzi/IAoYLs9IVxqRIsGsJsyUV0UEuERI
         czlXPhWHOCM/y9Dar4cC/flVBc1kIdtj+g7SDuXARoMSwh33fTVib2LQFycyMfxX4T88
         4ZyTbG0NnipXBYO4aO9u84vJrjUIMzCRaFdmUop7MBE/HtBczbVkD6FEH2l7Zj+4RGny
         d9tbWLRiySynjlBkIhbvcBK9G8EKEUqzPDpMVpniWrGn8rVDyRm3UaJQEcmo/sdQQEQw
         WBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760739444; x=1761344244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBW9JeEw0rbC3waNIsvF3E2h5Mpei0jyfelXeZ/F0jE=;
        b=MY+Nv5RW5mPLm6UrTvf22HsFFO+Im6OsoiPGOTNoiv9x6PfT2WeI+4LXqy403XNMby
         vxGIWYv83elmOy5qrbcs6/S81ri931+Gcf7bPRwLeiQZ1TAKXAoQYQUNtmWB+WhU21RX
         8anmL4+liYj4Uv79WkXCN7SCK3H/NJK+xnQWFAixMVkFM81fWQgP07BvZ/3a8qBTTRR8
         iYKv/yx1szyuLmiwnFHhvrdkKO41DL7auL9Se/oBXxdnoAzW3edh63d5G7ipH7NOch65
         xK4+p/rdNxmqCPinoEDnCR7Ukq0jQWiyhLztHwTI026Pc1RA30uG9tEvYYFIAnrhFqRk
         bp6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTRXWzQiQYARxz7F9yi1YW+KMqQ3yHjeWsSCf01iKwmGvpNsXw3pSDoDBFuTg0wy55+yOQ03t6AhOScSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV01beq34zP/mndD3duMpN45EevQD+nxq1OZ/cb9tqGFVK+Gt3
	fv7mBxvW5Fh4AeGaRvYrTrh0AXRJZ/3jiHFi6E6d209FZUlLw00I3cUTAcxEQ4BMERY/emn8RdE
	H/IzS1A==
X-Google-Smtp-Source: AGHT+IEOUe7QczZRN3Q5VNQEDQ1NSmdvwFmMlqw/2h3dEW9CdY/W7wbLfkkO9C5oHj+q5GBBV+83UpDb3Co=
X-Received: from pjbgx4.prod.google.com ([2002:a17:90b:1244:b0:33d:65b9:53fe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d407:b0:33b:d74b:179
 with SMTP id 98e67ed59e1d1-33bd74b025dmr5715700a91.27.1760739444079; Fri, 17
 Oct 2025 15:17:24 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:17:22 -0700
In-Reply-To: <aO2pROT5K+4J7j9k@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007224515.374516-1-seanjc@google.com> <aO2pROT5K+4J7j9k@yzhao56-desk.sh.intel.com>
Message-ID: <aPLAch-UpHtCeK_s@google.com>
Subject: Re: [PATCH] KVM: selftests: Use "gpa" and "gva" for local variable
 names in pre-fault test
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 14, 2025, Yan Zhao wrote:
> On Tue, Oct 07, 2025 at 03:45:15PM -0700, Sean Christopherson wrote:
> > -	guest_test_phys_mem = align_down(guest_test_phys_mem, alignment);
> > -	guest_test_virt_mem = guest_test_phys_mem & ((1ULL << (vm->va_bits - 1)) - 1);
> > +	gpa = align_down(gpa, alignment);
> > +	gva = gpa & ((1ULL << (vm->va_bits - 1)) - 1);
> >  
> > -	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> > -				    guest_test_phys_mem, TEST_SLOT, TEST_NPAGES,
> > +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, gpa,
> Wrap at 80 characters?
> 
> > +				    TEST_SLOT, TEST_NPAGES,

Hmm, yeah.  Probably this?

	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, gpa, TEST_SLOT,
				    TEST_NPAGES, private ? KVM_MEM_GUEST_MEMFD : 0);

which I like more than:

	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, gpa, TEST_SLOT,
				    TEST_NPAGES,
				    private ? KVM_MEM_GUEST_MEMFD : 0);

> >  				    private ? KVM_MEM_GUEST_MEMFD : 0);
> > -	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, TEST_NPAGES);
> > +	virt_map(vm, gva, gpa, TEST_NPAGES);
> >  
> >  	if (private)
> > -		vm_mem_set_private(vm, guest_test_phys_mem, TEST_SIZE);
> > +		vm_mem_set_private(vm, gpa, TEST_SIZE);
> >  
> > -	pre_fault_memory(vcpu, guest_test_phys_mem, 0, SZ_2M, 0, private);
> > -	pre_fault_memory(vcpu, guest_test_phys_mem, SZ_2M, PAGE_SIZE * 2, PAGE_SIZE, private);
> > -	pre_fault_memory(vcpu, guest_test_phys_mem, TEST_SIZE, PAGE_SIZE, PAGE_SIZE, private);
> > +	pre_fault_memory(vcpu, gpa, 0, SZ_2M, 0, private);
> > +	pre_fault_memory(vcpu, gpa, SZ_2M, PAGE_SIZE * 2, PAGE_SIZE, private);
> > +	pre_fault_memory(vcpu, gpa, TEST_SIZE, PAGE_SIZE, PAGE_SIZE, private);
> >  
> > -	vcpu_args_set(vcpu, 1, guest_test_virt_mem);
> > +	vcpu_args_set(vcpu, 1, gva);
> Should we cleanup guest_code() as below?
> 
> -static void guest_code(uint64_t base_gpa)
> +static void guest_code(uint64_t base_gva)
>  {
>         volatile uint64_t val __used;
>         int i;
> 
>         for (i = 0; i < TEST_NPAGES; i++) {
> -               uint64_t *src = (uint64_t *)(base_gpa + i * PAGE_SIZE);
> +               uint64_t *src = (uint64_t *)(base_gva + i * PAGE_SIZE);
> 
>                 val = *src;
>         }

Yah, no reason not to (lot's of tests assume GPA==GVA, but that's not a good
reason to be deliberately confusing).

