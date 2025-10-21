Return-Path: <linux-kernel+bounces-863759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E274CBF90A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4EEA4EC987
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A3B29BDAA;
	Tue, 21 Oct 2025 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PZBtwdFq"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4DF29B217
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761085462; cv=none; b=RNkPlwejqWHEn+9rUPiSmEDAFQN81rTtLyKAgT7J2SAI7pjmbYcUk4lQf0YVqrOmj+pi/CTQUZe7go7CvoedrDn9oSrL1IfOVf3iwjzZJjUkG3JmkkeE3pROfi1CslCs2xUdcWgb3pCU9Fs6Xsxsk2FPQADoyiNV+J2fOGOqJQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761085462; c=relaxed/simple;
	bh=CP9KR/xzX9TyFvLPu8adIb+it5Pyhohgjs8X1OkE2iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=havJFEAFCeZn+KiJkBtKk3/U7hB8wzGnQ17R73nIbaQ/ounzYIxIoBNAb7pp+XtSp7o0h0HvjCepZtKtoJPHoPYoW6UOPMnMQZhSsPPC3aQ/f9f9ONOCqNcHXz/jfBlm/ASHmlHSZXlNCLsXvUOBsF5mDPm1JtRpI6Zc8p/a5vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PZBtwdFq; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 21 Oct 2025 22:24:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761085456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ep32iEtRqnbxjE+4eR0M11BpTD44EmrSfqBnuPC/4dE=;
	b=PZBtwdFqJh5wnUoDczcoPoWRsmycAfwDMo2NdRDR3Ih5hymIgkuMkyNaGgLMrq0ZX0Xris
	9yZWV6TImZaGVFlj7H/1NI8xUH0cnOi2a9imsi/Bxo8KSfhFtFfP9RVKiojySC4RV3SPb1
	byA2PXYIRfFtKFgcCVv1TcT6ssmnYUU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Eric Auger <eric.auger@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] KVM: selftests: Use a loop to walk guest page tables
Message-ID: <3jg5nvjkbza7c7anqwoivea67wbdy3co2rdz2zzmxv6i5k4sbx@5hz6b5wcnff4>
References: <20250917215031.2567566-1-jmattson@google.com>
 <20250917215031.2567566-3-jmattson@google.com>
 <o7m5gh76crbgzlfvq4lbp6ymuzbgze25qphlhsezl2ox5rfjuv@3xh7gqh5dmlt>
 <CALMp9eRK7d1GF6Kqhji_KFz2+5jEs5JgbvyiCrqCiW_ZZiaoWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eRK7d1GF6Kqhji_KFz2+5jEs5JgbvyiCrqCiW_ZZiaoWQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 21, 2025 at 03:11:56PM -0700, Jim Mattson wrote:
> On Mon, Oct 20, 2025 at 10:21 AM Yosry Ahmed <yosry.ahmed@linux.dev> wrote:
> >
> > On Wed, Sep 17, 2025 at 02:48:38PM -0700, Jim Mattson wrote:
> > > Walk the guest page tables via a loop when searching for a PTE,
> > > instead of using unique variables for each level of the page tables.
> > >
> > > This simplifies the code and makes it easier to support 5-level paging
> > > in the future.
> > >
> > > Signed-off-by: Jim Mattson <jmattson@google.com>
> > > ---
> > >  .../testing/selftests/kvm/lib/x86/processor.c | 21 +++++++------------
> > >  1 file changed, 8 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> > > index 0238e674709d..433365c8196d 100644
> > > --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> > > +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> > > @@ -270,7 +270,8 @@ static bool vm_is_target_pte(uint64_t *pte, int *level, int current_level)
> > >  uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
> > >                                   int *level)
> > >  {
> > > -     uint64_t *pml4e, *pdpe, *pde;
> > > +     uint64_t *pte = &vm->pgd;
> > > +     int current_level;
> > >
> > >       TEST_ASSERT(!vm->arch.is_pt_protected,
> > >                   "Walking page tables of protected guests is impossible");
> > > @@ -291,19 +292,13 @@ uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
> > >       TEST_ASSERT(vaddr == (((int64_t)vaddr << 16) >> 16),
> > >               "Canonical check failed.  The virtual address is invalid.");
> > >
> > > -     pml4e = virt_get_pte(vm, &vm->pgd, vaddr, PG_LEVEL_512G);
> > > -     if (vm_is_target_pte(pml4e, level, PG_LEVEL_512G))
> > > -             return pml4e;
> > > -
> > > -     pdpe = virt_get_pte(vm, pml4e, vaddr, PG_LEVEL_1G);
> > > -     if (vm_is_target_pte(pdpe, level, PG_LEVEL_1G))
> > > -             return pdpe;
> > > -
> > > -     pde = virt_get_pte(vm, pdpe, vaddr, PG_LEVEL_2M);
> > > -     if (vm_is_target_pte(pde, level, PG_LEVEL_2M))
> > > -             return pde;
> > > +     for (current_level = vm->pgtable_levels; current_level > 0; current_level--) {
> >
> > This should be current_level >= PG_LEVEL_4K. It's the same, but easier
> > to read.
> >
> > > +             pte = virt_get_pte(vm, pte, vaddr, current_level);
> > > +             if (vm_is_target_pte(pte, level, current_level))
> >
> > Seems like vm_is_target_pte() is written with the assumption that it
> > operates on an upper-level PTE, but I think it works on 4K PTEs as well.
> 
> I believe it does. Would you prefer that I exit the loop before
> PG_LEVEL_4K and restore the virt_get_pte() below?

Slightly. Only because virt_get_pte() checks the large bit and uses
terminology like "hugepage", so I think using it for 4K PTEs is a bit
confusing.

Not a big deal either way tho.

> 
> > > +                     return pte;
> > > +     }
> > >
> > > -     return virt_get_pte(vm, pde, vaddr, PG_LEVEL_4K);
> > > +     return pte;
> > >  }
> > >
> > >  uint64_t *vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr)
> > > --
> > > 2.51.0.470.ga7dc726c21-goog
> > >

