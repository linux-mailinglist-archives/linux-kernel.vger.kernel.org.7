Return-Path: <linux-kernel+bounces-644767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2938AB4435
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 21:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA623A8CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 19:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F27296D2D;
	Mon, 12 May 2025 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLqVsP9d"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E9014F117
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076436; cv=none; b=seqm6qqYWYwoEPYs5p/DEtKLryS52us8o+U+4tgKsMmLBA2uttMM3+XZcah1UGLPuFQgkczLPEq0HAslsNpsXVlnarVwTaMEVLMwDOiIfVp/PMdvEYrbnj5H7uG+B4TIj40+3WG5e6SoXgO25gqwtG3wDl+ovoEzJs2IuaCHziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076436; c=relaxed/simple;
	bh=V5oZlFhSULyFEN6cKZyPDntJBnQj0ah5CDIMVOQ9yMs=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=G24SXRw6BOKon7QWTjhsIoEgZgzfE0t3ieAnnmzNzylV7WfpwhTlxmHtRUQMENinEWgGByKCp9Ho/HwN5Cl0E8Lb9e0LHsht2EEBtE+5BqRXSk+34pVvgURPSHLhFQEOzdMioYNzPOpbZNBXL10EXooS4GLZgThkxj6VH8UCD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sLqVsP9d; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30a96aca21eso4824804a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 12:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747076434; x=1747681234; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rke1067ylbP1EKW6VeuH662EFzeOBQYV7CnDIC0MF2Y=;
        b=sLqVsP9dDmohfcyiM/0mXpEgyNiAgUVMJxGbr6A3OaBYfGs3IEmtw+pXPYYAec+RTe
         Fy3GOTlCSTJWxvRK4dPifSTklJUOC3xrJS69//Bl/wvMb+q9F28iGavA+GgNHPFkAJ6S
         GyYwW6xnTBAY9B1m5CDyyUjy5QhPntp3z6LZrYNwZm9UN5gped6d+5y6rOihXGTwT/M3
         vIpmXHifEL+4smL3WMDfdsIV4+nJYuOUyw1f3yrQfv0vfvgWUNjCCb/ET4oOcnROuxJg
         RYzTiHWdjkvX54Nxl42KZGINQo2NbrbwzlGPfstA1NMJX0eheR+ykA5hAlLpyLNzfbF7
         nIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747076434; x=1747681234;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rke1067ylbP1EKW6VeuH662EFzeOBQYV7CnDIC0MF2Y=;
        b=G1GLd779NdlJYsJ9DCzrNOQLv5NrgTTenMP8JGY+iQHPNUpDgASMmhaXH4nDAo1vNn
         SzMJ0sgtRgeVtD9PtJMzBEvdzEQtwlxzvGDV/y1hBobpyPzxXhSV1hdlMywRnykixka5
         MomXns+J0rVaMpfJqQrt4BOpLaTCB6gVMyz5rB/vTTMIcBUnoRfWBNHBYxxE99+Z8+vx
         6Ys5WIJZkbNxuV+78XX6pb7zKXFtN+AEFR6FE0f1DOTMz5Tv3zuQ6xqk2CW/l5ThdFQy
         NnA95MMxat9gosK9SPs3iXxLWIiBJhMeAr5i1BO6txtrgkLDG8PltooLLVDQAna6ryS6
         Dg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHuDzoT8AU4CoPJ/Hn38RY0XInval6MON6+AXgJCjEVQKDsZBt2w9P6fo6ebTxGWS+UmiWDT4OQtSOixk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcmDSHINwMAvEqYicWyNoHXcCdgHwaTCKUWLlt7cvxAbkWC6U3
	v3/RIMDaUXgHYtuUlYVO//fIc4DkRPnXtcWmBb8xNj/0GM8xZnr9yIumX4R40XfmIaWvmEhk9N5
	+Gt9mBRhiLhvlG8JlCcVs9g==
X-Google-Smtp-Source: AGHT+IE/F0kIiEs3Wgl8vKju/CGXel5grWlSH1aS62vRHCe/E9+XYzgShjCFqsTyp2zUtHZxFqIYjtDWc4wsuNwWgA==
X-Received: from pjbpt8.prod.google.com ([2002:a17:90b:3d08:b0:2ea:5084:5297])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b4a:b0:301:1bce:c255 with SMTP id 98e67ed59e1d1-30c3d64626fmr21715875a91.27.1747076434325;
 Mon, 12 May 2025 12:00:34 -0700 (PDT)
Date: Mon, 12 May 2025 12:00:31 -0700
In-Reply-To: <aB10gNcmsw0TSrqh@yzhao56-desk.sh.intel.com> (message from Yan
 Zhao on Fri, 9 May 2025 11:20:32 +0800)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqz7c2lr6wg.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 08/21] KVM: TDX: Increase/decrease folio ref for huge pages
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: vannapurve@google.com, pbonzini@redhat.com, seanjc@google.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@intel.com, kirill.shutemov@intel.com, 
	tabba@google.com, quic_eberman@quicinc.com, michael.roth@amd.com, 
	david@redhat.com, vbabka@suse.cz, jroedel@suse.de, thomas.lendacky@amd.com, 
	pgonda@google.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, ira.weiny@intel.com, isaku.yamahata@intel.com, 
	xiaoyao.li@intel.com, binbin.wu@linux.intel.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

>> <snip>
>>
>> Very likely because these operations simply don't fail.
>
> I think they are intentionally designed to be no-fail.
>
> e.g. in __iopt_area_unfill_domain(), no-fail is achieved by using a small backup
> buffer allocated on stack in case of kmalloc() failure.
>
>
>> >
>> > That's why we rely on increasing folio ref count to reflect failure, which are
>> > due to unexpected SEAMCALL errors.
>>
>> TDX stack is adding a scenario where invalidation can fail, a cleaner
>> solution would be to propagate the result as an invalidation failure.
> Not sure if linux kernel accepts unmap failure.
>
>> Another option is to notify guest_memfd out of band to convey the
>> ranges that failed invalidation.
> Yes, this might be better. Something similar like holding folio ref count to
> let guest_memfd know that a certain PFN cannot be re-assigned.
>
>> With in-place conversion supported, even if the refcount is raised for
>> such pages, they can still get used by the host if the guest_memfd is
>> unaware that the invalidation failed.
> I thought guest_memfd should check if folio ref count is 0 (or a base count)
> before conversion, splitting or re-assignment. Otherwise, why do you care if
> TDX holds the ref count? :)
>

IIUC the question here is how we should handle failures in unmapping of
private memory, which should be a rare occurrence.

I think there are two options here

1. Fail on unmapping *private* memory

2. Don't fail on unmapping *private* memory, instead tell the owner of
   the memory that this memory is never to be used again.

I think option 1 is better because it is more direct and provides timely
feedback to the caller when the issue happens. There is also room to
provide even more context about the address of the failure here.

It does seem like generally, unmapping memory does not support failing,
but I think that is for shared memory (even in KVM MMU notifiers).
Would it be possible to establish a new contract that for private pages,
unmapping can fail?

The kernel/KVM-internal functions for unmapping GFNs can be modified to
return error when unmapping private memory. Specifically, when
KVM_FILTER_PRIVATE [1] is set, then the unmapping function can return an
error and if not then the caller should not expect failures.

IIUC the only places where private memory is unmapped now is via
guest_memfd's truncate and (future) convert operations, so guest_memfd
can handle those failures or return failure to userspace.

Option 2 is possible too - but seems a little awkward. For conversion
the general steps are to (a) unmap pages from either host, guest or both
page tables (b) change shareability status in guest_memfd. It seems
awkward to first let step (a) pass even though there was an error, and
then proceed to (b) only to check somewhere (via refcount or otherwise)
that there was an issue and the conversion needs to fail.

Currently for private to shared conversions, (will be posting this 1g
page support series (with conversions) soon), I check refcounts == safe
refcount for shared to private conversions before permitting conversions
(error returned to userspace on failure).

For private to shared conversions, there is no check. At conversion
time, when splitting pages, I just spin in the kernel waiting for any
speculative refcounts to drop to go away. The refcount check at
conversion time is currently purely to ensure a safe merge process.

It is possible to check all the refcounts of private pages (split or
huge page) in the requested conversion range to handle unmapping
failures, but that seems expensive to do for every conversion, for
possibly many 4K pages, just to find a rare error case.

Also, if we do this refcount check to find the error, there wouldn't be
any way to tell if it were an error or if it was a speculative refcount,
so guest_memfd would just have to return -EAGAIN for private to shared
conversions. This would make conversions complicated to handle in
userspace, since the userspace VMM doesn't know whether it should retry
(for speculative refcounts) or it should give up because of the
unmapping error. Returning a different error on unmapping failure would
allow userspace to handle the two cases differently.

Regarding Option 2, another way to indicate an error could be to mark
the page as poisoned, but then again that would overlap/shadow true
memory poisoning.

In summary, I think Option 1 is best, which is that we return error
within the kernel, and the caller (for now only guest_memfd unmaps
private memory) should handle the error.

[1] https://github.com/torvalds/linux/blob/627277ba7c2398dc4f95cc9be8222bb2d9477800/include/linux/kvm_host.h#L260

>
>> >
>> > > > Currently, guest_memfd can rely on page ref count to avoid re-assigning a PFN
>> > > > that fails to be unmapped.
>> > > >
>> > > >
>> > > > [1] https://lore.kernel.org/all/20250328153133.3504118-5-tabba@google.com/
>> > > >
>> > > >
>> > > > > >
>> > > > > >
>> > > > > > > Any guest_memfd range updates will result in invalidations/updates of
>> > > > > > > userspace, guest, IOMMU or any other page tables referring to
>> > > > > > > guest_memfd backed pfns. This story will become clearer once the
>> > > > > > > support for PFN range allocator for backing guest_memfd starts getting
>> > > > > > > discussed.
>> > > > > > Ok. It is indeed unclear right now to support such kind of memory.
>> > > > > >
>> > > > > > Up to now, we don't anticipate TDX will allow any mapping of VM_PFNMAP memory
>> > > > > > into private EPT until TDX connect.
>> > > > >
>> > > > > There is a plan to use VM_PFNMAP memory for all of guest_memfd
>> > > > > shared/private ranges orthogonal to TDX connect usecase. With TDX
>> > > > > connect/Sev TIO, major difference would be that guest_memfd private
>> > > > > ranges will be mapped into IOMMU page tables.
>> > > > >
>> > > > > Irrespective of whether/when VM_PFNMAP memory support lands, there
>> > > > > have been discussions on not using page structs for private memory
>> > > > > ranges altogether [1] even with hugetlb allocator, which will simplify
>> > > > > seamless merge/split story for private hugepages to support memory
>> > > > > conversion. So I think the general direction we should head towards is
>> > > > > not relying on refcounts for guest_memfd private ranges and/or page
>> > > > > structs altogether.
>> > > > It's fine to use PFN, but I wonder if there're counterparts of struct page to
>> > > > keep all necessary info.
>> > > >
>> > >
>> > > Story will become clearer once VM_PFNMAP'd memory support starts
>> > > getting discussed. In case of guest_memfd, there is flexibility to
>> > > store metadata for physical ranges within guest_memfd just like
>> > > shareability tracking.
>> > Ok.
>> >
>> > > >
>> > > > > I think the series [2] to work better with PFNMAP'd physical memory in
>> > > > > KVM is in the very right direction of not assuming page struct backed
>> > > > > memory ranges for guest_memfd as well.
>> > > > Note: Currently, VM_PFNMAP is usually used together with flag VM_IO. in KVM
>> > > > hva_to_pfn_remapped() only applies to "vma->vm_flags & (VM_IO | VM_PFNMAP)".
>> > > >
>> > > >
>> > > > > [1] https://lore.kernel.org/all/CAGtprH8akKUF=8+RkX_QMjp35C0bU1zxGi4v1Zm5AWCw=8V8AQ@mail.gmail.com/
>> > > > > [2] https://lore.kernel.org/linux-arm-kernel/20241010182427.1434605-1-seanjc@google.com/
>> > > > >
>> > > > > > And even in that scenario, the memory is only for private MMIO, so the backend
>> > > > > > driver is VFIO pci driver rather than guest_memfd.
>> > > > >
>> > > > > Not necessary. As I mentioned above guest_memfd ranges will be backed
>> > > > > by VM_PFNMAP memory.
>> > > > >
>> > > > > >
>> > > > > >
>> > > > > > > [1] https://elixir.bootlin.com/linux/v6.14.5/source/mm/memory.c#L6543
>> > >

