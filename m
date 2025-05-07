Return-Path: <linux-kernel+bounces-636927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ED8AAD1D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 02:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159FA983CAB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 00:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2953B4A35;
	Wed,  7 May 2025 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eF2tOBbz"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0610E0
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 00:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746576354; cv=none; b=im1QsPC/64zi296YNRaxwMv8Q5fwnRuAhxTZO3Mbt1ALumkC3wpmo9562jo3X9S2uocPjo2FhA9RNlLyOlZ1TjmnDH//k9KFRtSdInibeVNS8jlrRtJD/Mgl3ozPrUbTUE9EXcCkZWunhkkpKSJwD9sDa0d6PQ2EYCSaDw+CNT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746576354; c=relaxed/simple;
	bh=yaCcykgp16u3flZaJJz5SvxS7btAI9N+qBqGdItQ0JU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q7Z0RBp6kk+lBfaeMR/YszlJkSUCxKPDFU9gE1vILuAihWZISTV67rHyYi5ui6aIAKQWprUAQ1UeIjPOd3xTz/JaPszktPhR0JA3zxvOp5xaRmiMidGrCN3k/amCioReFhXyT2laRVHap+ZaunHrfzng9nEqsjTa+c9tSWUGiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eF2tOBbz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff68033070so5609535a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 17:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746576352; x=1747181152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kf6t6m3UzjOjQqBtIkrrADeHvo58X2zFNTMCoBeF4hc=;
        b=eF2tOBbzGZO6vUIE3oglN2kxjSIr39BC7rYQf1YTL8IDzJ7+717anzomy6Jbj69ieJ
         K8F95fCv8Q+xh8QZQOQ/Ia65J0eFHbZZ7erEIjRW4dOueXq8TZ6TEcQa2bKZtg/nDyuu
         IR+3DYhWrmirYmOAyJHRBJHS696TlGWcAJ2clUOVp4cbjEtcx3LA307l5aPWBP9R/SU8
         9wbwFSvwy9gk34l/fUbxa98H67qigFMvwBoOq1gNUZg4083j5yzn55MY57XCngVIz16o
         0X9s4C6QA7dcwF4CDE0e96MieV5H+dvvQQyo+IFF88dTCwN/0GVQZcxG1eKIuQKQZzaB
         0afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746576352; x=1747181152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kf6t6m3UzjOjQqBtIkrrADeHvo58X2zFNTMCoBeF4hc=;
        b=v4bH9K4W6G3kLa41V8FzWT/o8K+iWgt9v04SFHoD6SGCZgK4YC0sKlZhdIGoJiwg72
         oJuPEQDOc70V3MO/07IThdZfQPhwHRZdVHYl7hA5NsxzSy/MyrjC8m//2KIl9CsDl5u7
         pjYyjy9Op/eZNRG3ZKfl97UqgIoTQMSvXepSdOs2nMWQeijaBZFtGsGbs3Rnqi8xB9fP
         RAxBC/iJQX1sn0RETTVD1GlB2b3HtpD8Qgks/8F0NVaCEWMHRQapvjI75SdJmrWUkblU
         AnIC8JmlyTcyA5Hu2vevzH/bqk826oFgucOlwwhQWACvZLp6T2cqyc4CsYSVBhsF7Mi9
         WnAA==
X-Forwarded-Encrypted: i=1; AJvYcCU4xugDrpn6dKo4IvXZqXwYSXldxV/Y4igEFrsE2JJMJ0A8qrDgpq8NgtPQULrIyJdqUkuDRk8L/X/UwMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT2ozDo/kwN7jaGAzLxRVmsxgwPxyews2WAe38EXenqT2EYzpN
	flc3sTQySvbuxHeLcem5vLJUlx+0wEqL9ec/+RG4SAr0QAa3T35f/+y23aRKcSbtsOOXOxOD8ER
	EEw==
X-Google-Smtp-Source: AGHT+IFMFJ1FHxkmhNJJNI7L8Ht1/2Wzfj8wbIGxb39Uyx2QJZM+bpzpV88A2XUmDg8f6OQLimWa7W0pTy4=
X-Received: from pjbnd2.prod.google.com ([2002:a17:90b:4cc2:b0:2f5:63a:4513])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da87:b0:2fe:b907:3b05
 with SMTP id 98e67ed59e1d1-30aac29bf2bmr1865902a91.29.1746576352169; Tue, 06
 May 2025 17:05:52 -0700 (PDT)
Date: Tue, 6 May 2025 17:05:50 -0700
In-Reply-To: <20250109204929.1106563-6-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109204929.1106563-1-jthoughton@google.com> <20250109204929.1106563-6-jthoughton@google.com>
Message-ID: <aBqj3s8THH9SFzLO@google.com>
Subject: Re: [PATCH v2 05/13] KVM: x86/mmu: Add support for KVM_MEM_USERFAULT
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Yan Zhao <yan.y.zhao@intel.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Anish Moorthy <amoorthy@google.com>, 
	Peter Gonda <pgonda@google.com>, Peter Xu <peterx@redhat.com>, 
	David Matlack <dmatlack@google.com>, wei.w.wang@intel.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Jan 09, 2025, James Houghton wrote:
> Adhering to the requirements of KVM Userfault:
> 
> 1. Zap all sptes for the memslot when KVM_MEM_USERFAULT is toggled on
>    with kvm_arch_flush_shadow_memslot().
> 2. Only all PAGE_SIZE sptes when KVM_MEM_USERFAULT is enabled (for both
>    normal/GUP memory and guest_memfd memory).
> 3. Reconstruct huge mappings when KVM_MEM_USERFAULT is toggled off with
>    kvm_mmu_recover_huge_pages(). This is the behavior when dirty logging
>    is disabled; remain consistent with it.
> 
> With the new logic in kvm_mmu_slot_apply_flags(), I've simplified the
> two dirty-logging-toggle checks into one, and I have dropped the
> WARN_ON() that was there.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  arch/x86/kvm/Kconfig            |  1 +
>  arch/x86/kvm/mmu/mmu.c          | 27 +++++++++++++++++++++----
>  arch/x86/kvm/mmu/mmu_internal.h | 20 +++++++++++++++---
>  arch/x86/kvm/x86.c              | 36 ++++++++++++++++++++++++---------
>  include/linux/kvm_host.h        |  5 ++++-
>  5 files changed, 71 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index ea2c4f21c1ca..286c6825cd1c 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -47,6 +47,7 @@ config KVM_X86
>  	select KVM_GENERIC_PRE_FAULT_MEMORY
>  	select KVM_GENERIC_PRIVATE_MEM if KVM_SW_PROTECTED_VM
>  	select KVM_WERROR if WERROR
> +	select HAVE_KVM_USERFAULT
>  
>  config KVM
>  	tristate "Kernel-based Virtual Machine (KVM) support"
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 2401606db260..5cab2785b97f 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4280,14 +4280,19 @@ static inline u8 kvm_max_level_for_order(int order)
>  	return PG_LEVEL_4K;
>  }
>  
> -static u8 kvm_max_private_mapping_level(struct kvm *kvm, kvm_pfn_t pfn,
> -					u8 max_level, int gmem_order)
> +static u8 kvm_max_private_mapping_level(struct kvm *kvm,
> +					struct kvm_memory_slot *slot,
> +					kvm_pfn_t pfn, u8 max_level,
> +					int gmem_order)
>  {
>  	u8 req_max_level;
>  
>  	if (max_level == PG_LEVEL_4K)
>  		return PG_LEVEL_4K;
>  
> +	if (kvm_memslot_userfault(slot))

Unless I'm missing something, this can go in kvm_mmu_hugepage_adjust():

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a4439e9e0726..49eb6b9b268c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3304,7 +3304,7 @@ void kvm_mmu_hugepage_adjust(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
        if (is_error_noslot_pfn(fault->pfn))
                return;
 
-       if (kvm_slot_dirty_track_enabled(slot))
+       if (kvm_slot_dirty_track_enabled(slot) || kvm_is_userfault_memslot(slot))
                return;
 
>  static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 1b04092ec76a..2abb425a6514 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -13053,12 +13053,36 @@ static void kvm_mmu_slot_apply_flags(struct kvm *kvm,
>  	u32 new_flags = new ? new->flags : 0;
>  	bool log_dirty_pages = new_flags & KVM_MEM_LOG_DIRTY_PAGES;
>  
> +	/*
> +	 * When toggling KVM Userfault on, zap all sptes so that userfault-ness
> +	 * will be respected at refault time. All new faults will only install
> +	 * small sptes. Therefore, when toggling it off, recover hugepages.
> +	 *
> +	 * For MOVE and DELETE, there will be nothing to do, as the old
> +	 * mappings will have already been deleted by
> +	 * kvm_arch_flush_shadow_memslot().
> +	 *
> +	 * For CREATE, no mappings will have been created yet.
> +	 */

Eh, trim this down and the reference the comment below to explain why FLAGS_ONLY
is the only case that needs to be handled.

> +	if ((old_flags ^ new_flags) & KVM_MEM_USERFAULT &&
> +	    (change == KVM_MR_FLAGS_ONLY)) {
> +		if (old_flags & KVM_MEM_USERFAULT)
> +			kvm_mmu_recover_huge_pages(kvm, new);
> +		else
> +			kvm_arch_flush_shadow_memslot(kvm, old);

The call to kvm_arch_flush_shadow_memslot() should definitely go in common code.
The fancy recovery logic is arch specific, but blasting the memslot when userfault
is toggled on is not.

