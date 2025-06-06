Return-Path: <linux-kernel+bounces-676122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA345AD07D7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 19:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D63E1635D0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7828A3FE;
	Fri,  6 Jun 2025 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqiP0rNc"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625141534EC
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749232658; cv=none; b=EmSK8L0Q3OqXroe8M5FM77QJmr3JZ15ZAstuEP7fi8Jl9wTjQpR0Vufa7rqyJIAxe5ImlmQ3q1ztqs5Uod0i74Rk2oWjQSSvsGmgiCkw6xIiZXi4xJMPyQMeut2QocVasvX4L0aT32SqzsgYLEzubiZYs9YzDxgI1VkWBnyxaDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749232658; c=relaxed/simple;
	bh=ZB0NWHd/9jnUvtnq6UmpQDkeF2Lhk/dOw/6eYJnYbfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wxr9KyLWIOpBxtyMuL+wroMsiyS4/YB4xYg3YPZNwcmBWkF32vwok4LR+D5/6UQwv63MnjISZTrZDs64RIcs2mmLLa6S9h4XlSUMxq5w7jz1KOnCMIgKie/fqyLNoOT5o2TGMSu17Ek61lsig+hJ38IPPbVqzCDW7qhCC7NvN2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DqiP0rNc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74299055c3dso3648975b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jun 2025 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749232657; x=1749837457; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uy4s6eK2oicgrVJHBktYrwR1uwscm0ofZKzJBnShpYk=;
        b=DqiP0rNc2QSUfxvthP7HQTAD0TaGsS+vd/pEi10IZjegkOJUXMjvW4V5s8x/Ftab1J
         ZxRC2C8ul8XDkWq/AFDVlGfBQNoGEo93Jrvyx9iOfaAKM/SiIiU7zxEtcTyjzRBBssLr
         A9o9qElUNKwSHOTMfEtNzPFdPwOvJdYHzp/hbRVEMi0Km1M87y5hF8SKnPKH6FSWqqrf
         GZGp6m9xlEl6+UXtcxLfYPwmwfm2rlVPrBzqjVkd8TeeIjNZUcD7o5ZNRZlFm1n1mGJG
         vuHd366gGnL5b0SDs2Ly9S+Z4GqQBLSN+m8a6jq4iQ29OREhmP1n6a2s05zXrcRBhBBx
         iYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749232657; x=1749837457;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uy4s6eK2oicgrVJHBktYrwR1uwscm0ofZKzJBnShpYk=;
        b=fq0kYDotOE3QasR5OHbRqUq2krIgIF7S0R9xscJFEb2xgRhLLn6Urh9vaSvG1fUYqL
         jN5FOIwux6UZOFB7jZ0h97vwbJ4kQ1AmYiz6xQioLl0IkX5pU+mJCQCqldl6lSFZyPfp
         jfHwNcFoKWZTePQ2WWZaK47slX0pD86mYZXmOHWngDBdmBo9ER1gp109Gv+XsSOPxb1L
         IBkF3oaKWwZORYmVyoOkapdRLlrnSfbN+ACkEeV8oFpwmmg1S4R40aS2pwl4puLzR+5m
         TdjPapvJPPySyBqmPgoWJnETQfC0Zq9cfuNSnm0B6mGVgQO8B56V5pb9YFeJ0WcdYLuS
         Iw3w==
X-Forwarded-Encrypted: i=1; AJvYcCWizxN+PWnOyt8wOwKZCe54M7mQ4o+WMiFPOVXzycV42diZL+lpKtu4O/1lkgxSRGKnbM0X8ZRCUgMLlRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynYSdb0K+nueBOpmq4ND4UOf9zdpc+3O/Qq98kbIKyjLox5qXv
	V3qwH1wkm2Ee3CqZVFpeCXRjnUL96Uaknq6gq26P1eChjNaRjWhEvnlsHdgauuBdSKEMXwlQSbp
	W8US5lw==
X-Google-Smtp-Source: AGHT+IE0O8E/z1AW0aCKfeQ6ZwKpA8wqWW3uIA5Eo0Mj+1d46DIjhKhwh8m8l5jhmiyq44/R62b0WTD+8ZQ=
X-Received: from pfaz1.prod.google.com ([2002:aa7:91c1:0:b0:746:3185:144e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22d1:b0:742:a91d:b2f5
 with SMTP id d2e1a72fcca58-74827ea2140mr5987849b3a.13.1749232656472; Fri, 06
 Jun 2025 10:57:36 -0700 (PDT)
Date: Fri, 6 Jun 2025 10:57:34 -0700
In-Reply-To: <SA1PR12MB71990A84FDB4350DC02CEC6EB064A@SA1PR12MB7199.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250524013943.2832-1-ankita@nvidia.com> <20250524013943.2832-4-ankita@nvidia.com>
 <20250527002652.GM61950@nvidia.com> <SA1PR12MB71990A84FDB4350DC02CEC6EB064A@SA1PR12MB7199.namprd12.prod.outlook.com>
Message-ID: <aEMsDsi3DSm1up0G@google.com>
Subject: Re: [PATCH v6 3/5] kvm: arm64: New memslot flag to indicate cacheable mapping
From: Sean Christopherson <seanjc@google.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, "maz@kernel.org" <maz@kernel.org>, 
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "joey.gouly@arm.com" <joey.gouly@arm.com>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "shahuang@redhat.com" <shahuang@redhat.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "david@redhat.com" <david@redhat.com>, 
	Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, 
	Kirti Wankhede <kwankhede@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>, 
	"Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, 
	Andy Currid <acurrid@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
	John Hubbard <jhubbard@nvidia.com>, Dan Williams <danw@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
	Matt Ochs <mochs@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>, 
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, 
	"sebastianene@google.com" <sebastianene@google.com>, "coltonlewis@google.com" <coltonlewis@google.com>, 
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>, 
	"ardb@kernel.org" <ardb@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"gshan@redhat.com" <gshan@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"ddutile@redhat.com" <ddutile@redhat.com>, "tabba@google.com" <tabba@google.com>, 
	"qperret@google.com" <qperret@google.com>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"maobibo@loongson.cn" <maobibo@loongson.cn>
Content-Type: text/plain; charset="us-ascii"

On Tue, May 27, 2025, Ankit Agrawal wrote:
> > I thought we agreed not to do this? Sean was strongly against it
> > right?

Yes.  NAK, at least for this implementation.

IMO, this has no business being in KVM's uAPI, and it's a mess.  KVM x86
unconditionally supports cacheable PFNMAP mappings, yet this:

  bool __weak kvm_arch_supports_cacheable_pfnmap(void)
  {
	return false;
  }

	if (kvm_arch_supports_cacheable_pfnmap())
		valid_flags |= KVM_MEM_ENABLE_CACHEABLE_PFNMAP;

means x86 will disallow KVM_MEM_ENABLE_CACHEABLE_PFNMAP.  Which is fine-ish from
a uAPI perspective, as the flag is documented as arm64-only, and we can state that
all other architectures always allow cacheable mappings.  But even that is a mess,
because KVM won't _guarantee_ the final mapping is cacheable.

On AMD, there's simply no sane way to force WB (KVM can't override guest PAT,
i.e. the memtype requested/set by the guest's stage-1 page tables).

On Intel, after years of pain, we _finally_ got KVM out of a mess where KVM was
forcing WB for all non-MMIO memory.  Only to have to immediately revert and add
KVM_X86_QUIRK_IGNORE_GUEST_PAT because buggy guest drivers were relying on KVM's
behavior :-(

So there's zero chance of this memslot flag ever being supported on x86.  Which,
again, is fine for uAPI.  But for internal code it's going to be all kinds of
confusing, because kvm_arch_supports_cacheable_pfnmap() is a flat out lie.

And as proposed, the memslot flag also doesn't actually address Oliver's want:

  The memslot flag says userspace expects a particular GFN range to guarantee
                                                                    ^^^^^^^^^
  Write-Back semantics.

IIUC, what Oliver wants is:

			if (mapping_type_noncacheable(vma->vm_page_prot)) {
				if (new->flags & KVM_MEM_FORCE_CACHEABLE_PFNMAP)
					return -EINVAL;
			} else {
				if (!kvm_arch_supports_cacheable_pfnmap()))
					return -EINVAL;
			}

That's at least a bit more palatable, as it doesn't create impossible situations
on x86, e.g. x86 simply doesn't support letting userspace force a cacheable.

And Oliver also stated:

  Whether or not FWB is employed for a particular region of IPA space is useful
  information for userspace deciding what it needs to do to access guest memory. 

The above would only cover half of that, i.e. wouldn't prevent userspace from
getting surprised by a WB mapping.  So I think it would need to be this?

			if (mapping_type_noncacheable(vma->vm_page_prot) !=
                            !(new->flags & KVM_MEM_FORCE_CACHEABLE_PFNMAP))
				return -EINVAL;

Which I don't hate as much, but I still don't love it, as it's overly specific,
e.g. only helps with PFNMAP memory, and pushes a sanity from userspace into KVM.

Which is another complaint with this uAPI: it effectively assumes/implies PFNMAP is
device memory, but that's simply not true.  There are zero guarantees with respect
to what actually lies behind any given PFNMAP.  It could be device memory, but
it could also be regular RAM, or something in between.

I would much prefer we have a way userspace query the effective memtype for a
range of memory, either for a VMA or for a KVM mapping, and let _userspace_ do
whatever sanity checks it wants.  That seems like it would be more generally
useful, and would be feasible to support on multiple architectures.  Though I'd
probably prefer to avoid even that, e.g. in favor of providing enough information
in other ways so that userspace can (somewhat easily) deduce how KVM will behave
for a giving mapping.

> > There is no easy way for VFIO to know to set it, and the kernel will
> > not allow switching a cachable VMA to non-cachable anyhow.
> 
> > So all it does is make it harder to create a memslot.
> 
> Oliver had mentioned earlier that he would still prefer a memslot flag as
> VMM should convey its intent through that flag:
>
> https://lore.kernel.org/all/aAdKCGCuwlUeUXKY@linux.dev/
> Oliver, could you please confirm if you are convinced with not having this
> flag? Can we rely on MT_NORMAL in vma mapping to convey this?

Is MT_NORMAL visable and/or controllable by userspace?

